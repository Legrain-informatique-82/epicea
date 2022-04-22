unit DMChargesAPayer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,
  Gr_Librairie_obj,
  E2_Librairie_obj,
  LibSQL,
  E2_LibInfosTable,
  {E2_ChargesAPayer_Isa,}
  AideMontant2,
  DMTVA,
  DMBalances,
  DMPiece,
  DMClotures,
  RxMemDS,
  E2_Decl_Records,
  LibZoneSaisie,
  Editions,
  Lib_Chaine,
  LibDates,
  ShellApi,
  DMConstantes,
  Variants,
  StdCtrls,
  ObjetEdition,
  LibRessourceString,
  GrDBGrid,E2_VisuListeView;

type
  TParamDMChargeAPayer=Record
   Quoi,Quand:Integer;
   ChargeAPayerDataStateChange:TNotifyEvent;
   GEstInterfaceEvent:TGEstInterfaceEvent;
   Compte:String;
   AfficheListe:boolean;
  end;

  TInfosDMChargeAPayer=Record
    Retour:Boolean;
   end;

//ce record sert � recup�rer les param�tres de Mise � jour de la balance apr�s l'enregistrement
//ou la suppression d'une charge � payer ou d'un produit � recevoir
     TRecupParametres=record
     sens1,sens2,sens3,sens4:string;
     Qte1,Qte2,Qte3,Qte4:string;
     compteTva:string;
     end;

  TDMChargeAPayer = class(TDataModule)
    TaChAPayer: TTable;
    DataChAPayer: TDataSource;
    TaChAPayer2: TTable;
    DataChAPayer2: TDataSource;
    DataChAPayer3: TDataSource;
    TaChAPayer3: TTable;
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
    QuChargeAPayerEdition: TQuery;
    QuListeValRupt: TQuery;
    QuSousTotal: TQuery;
    QuTotalG: TQuery;
    QuChargesAPayer_Edition: TQuery;
    procedure DMChargeAPayerCreate(Sender: TObject);
    procedure DMChargeAPayerDestroy(Sender: TObject);
    procedure FiltrageAffichageGrille(Tag_bis:integer;Compte:String);
    Function  CtrlSaisieChargesAPayer(CCourant:Tfield):TErreurSaisie;

    procedure TaChAPayerAfterPost(DataSet: TDataSet);
    procedure TaChAPayerBeforePost(DataSet: TDataSet);
    procedure TaChAPayerBeforeEdit(DataSet: TDataSet);

    procedure TaChAPayerBeforeDelete(DataSet: TDataSet);
    procedure TaChAPayerAfterDelete(DataSet: TDataSet);
    procedure TaChAPayerBeforeInsert(DataSet: TDataSet);
    // Procedure branch� lorsque E.AccesCloture = false et/ou E.AccesOuverture = false
    procedure TaChAPayerBeforeEIDOuv_Abort(DataSet: TDataSet);
    procedure TaChAPayerBeforeEIDClo_Abort(DataSet: TDataSet);

    function  RecupParametreMAJBalance(tag_module:integer):TRecupParametres;
    procedure TraitementMAJBalance(Ch_Pr:integer;Suppression:boolean;EtatTaChApayer:TDataSetState;Ref:string);
    function CreationListeOD(DateExo:TDateTime;sens:string):TStringList;
    procedure DemandeAffichageReprise;
    procedure CreationODChargeAPayerReprise;
    procedure CreationODChargeAPayerCloture;
    Procedure EcritureReference(ID:integer;Changerdate:boolean;Ref:string;Date:Tdatetime);
    procedure FiltragePourOuvertureReprise1(sens:string);
    procedure VerifSaisieFeuilleReprise1(cCourant:tfield);
    procedure TaChAPayer3BeforeDelete(DataSet: TDataSet);
    procedure TaChAPayer3BeforePost(DataSet: TDataSet);
    procedure TaChAPayer3BeforeEdit(DataSet: TDataSet);
    procedure TaChAPayer3BeforeInsert(DataSet: TDataSet);
    procedure InitialisationVariablesTemp;
    procedure Filtrage_EcriturePourNouvelExo(var tMem:TRxMemoryData;NouvelleDate:Tdatetime);
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

    procedure TaChAPayerAfterScroll(DataSet: TDataSet);
    procedure TraitementCloture2000(sender:Tobject);
    procedure CreationODCloture_avecObjet(TableEnCours:TTable;ODModif:string);
    procedure CreationODReprise_avecObjet(TableEnCours:TTable;ODModif:string);
    procedure TaChAPayerCalcFields(DataSet: TDataSet);
    Procedure GestionAccesChargesAPayer;
    procedure GestionFiltrageAideCompte(sender:tobject);
    procedure QuChargeAPayerFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure EventValider(Sender: TObject);

  private
    { D�clarations priv�es }
    FOnGEstInterfaceEvent:TGEstInterfaceEvent;
    QuandQuoi:Integer;
  public
    { D�clarations publiques }
    Erreur:TErreurSaisie;
    CompteChargeOuProduit,Libelle_CompteChargeOuProduit:string;// Servent � recup�rer le compte et son libelle
    ListeEditCompte,ListeEditCompte2:TStringList;
                                                               // de Charges � Payer
    LaisserPasser:boolean;
    Quand,Quoi:Integer;
    AfficheListe:Boolean;
    property OnGEstInterfaceEvent:TGEstInterfaceEvent read FOnGEstInterfaceEvent write FOnGEstInterfaceEvent;
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


    Function InitialiseDMChargeAPayer(ParamDMChargeAPayer:TParamDMChargeAPayer):TInfosDMChargeAPayer;
    Function EditionChargeAPayer(TypeEdition : integer; Quand : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;

    function VerifRepriseChargesOuverture_OK(var messageTmp:Tmessages):boolean;
    function VerifExistChargesAPayerOuverture(var messageTmp:Tmessages;Mess:boolean):boolean;
    function VerifExistChargesAPayerCloture(var messageTmp:Tmessages;Mess:boolean):boolean;
    function VerifExistChargesAPayerOuvertureAReprendre(var messageTmp:Tmessages;Mess:boolean):boolean;

    Function EditionChargesAPayerL(TypeEdition : integer; Quand, Quoi : integer; DataSet:TDataSet;Compte,compte2:String;Site:TEditLien):Boolean;overload;
    Function EditionChargesAPayerL(TypeEdition : integer; Quand, Quoi : integer; DataSet:TDataSet;ListeCompte,ListeCompte2:TStringList;Site:TEditLien):Boolean;overload;

    Function AffichChargesAPayerSurPeriode(Quand,Quoi:integer):Boolean;


implementation

uses DMPlanCpt,E2_AideCompte, E2_Main,DMImportation,DMBaseDonnee,
  E2_ChargesAPayer_Isa, DMRecherche;

{$R *.DFM}

Function InitialiseDMChargeAPayer(ParamDMChargeAPayer:TParamDMChargeAPayer):TInfosDMChargeAPayer;
Begin
 if DMChargeAPayer=nil then DMChargeAPayer:=TDMChargeAPayer.Create(Application.MainForm);
 if DMRech = Nil then DMRech:=TDMRech.Create(Application.MainForm);

 DMChargeAPayer.OnGEstInterfaceEvent := ParamDMChargeAPayer.GEstInterfaceEvent;
 DMChargeAPayer.CompteChargeOuProduit := ParamDMChargeAPayer.Compte;

 // Initialisation du QuoiQuand (remplace le tag)
 DMChargeAPayer.QuandQuoi := StrToInt_Lgr(inttostr(ParamDMChargeAPayer.Quand+1)+inttostr(ParamDMChargeAPayer.Quoi));
 DMChargeAPayer.Tag := DMChargeAPayer.QuandQuoi;
 DMChargeAPayer.Quand:=ParamDMChargeAPayer.Quand;
 DMChargeAPayer.Quoi := ParamDMChargeAPayer.Quoi;
 DMChargeAPayer.AfficheListe:=ParamDMChargeAPayer.AfficheListe;
 if DMChargeAPayer.AfficheListe then
   begin
        AffichChargesAPayerSurPeriode(DMChargeAPayer.Quand,DMChargeAPayer.Quoi);
           if DMPieces.RetourViewListe.retour then
              DMChargeAPayer.CompteChargeOuProduit:=DMPieces.RetourViewListe.VisuListeView.ItemCourantValeurCol(0);
   end;
  case DMChargeAPayer.DataChAPayer.State of
    dsBrowse:Begin
              DMChargeAPayer.FiltrageAffichageGrille(DMChargeAPayer.QuandQuoi,DMChargeAPayer.CompteChargeOuProduit);
              DMChargeAPayer.DataChAPayer.OnStateChange:=ParamDMChargeAPayer.ChargeAPayerDataStateChange;
             End;
    dsInsert,dsEdit:Begin

                    End;
  end;
End;


Function EditionChargeAPayer(TypeEdition : integer; Quand : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
var
NomFich,Chemin:String;
Begin
  Chemin :=E.RepertoireComptaWeb;
 case Quand of
    C_Ouverture: case DMChargeAPayer.Tag of
                    11:NomFich:='ChargesAPayerOuv';
                    12:NomFich:='ProduitsARecevoirOuv';
                 end;
    C_Cloture:  case DMChargeAPayer.Tag of
                    21:NomFich:='ChargesAPayerClo';
                    22:NomFich:='ProduitsARecevoirClo';
                end;
 end;

 if DMChargeAPayer=nil then DMChargeAPayer:=TDMChargeAPayer.Create(Application.MainForm);
 if dataset = nil then
  begin
   // Prevu pour passer le dataset concern�
   // Inutile dans ChargeRepartir pour l'instant
  end;
 case Quand of
    C_Ouverture:begin
                 DMChargeAPayer.QuListeValRupt.SQL.Clear;
                 DMChargeAPayer.QuListeValRupt.SQL.Add('select distinct compte from ChargeAPayer.db where ');
                 DMChargeAPayer.QuListeValRupt.SQL.Add(' DateSaisie='''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
                 DMChargeAPayer.QuListeValRupt.SQL.Add(' and compte='''+DMChargeAPayer.CompteChargeOuProduit+'''');
                 case DMChargeAPayer.Tag of
                    11:DMChargeAPayer.QuListeValRupt.SQL.Add(' and Sens=''C''');
                    12:DMChargeAPayer.QuListeValRupt.SQL.Add(' and Sens=''D''');
                 end;
                 DMChargeAPayer.QuListeValRupt.Open;

                 DMChargeAPayer.QuSousTotal.SQL.Clear;
                 DMChargeAPayer.QuSousTotal.Params.Clear;
                 DMChargeAPayer.QuSousTotal.SQL.Add('select sum(MontantHT) as MontantHT, sum(TVA) as MontantTVA, sum(MontantHT+TVA) asMontantTTC,0 ');
                 DMChargeAPayer.QuSousTotal.SQL.Add('from ChargeAPayer.db where compte =:compte ');
                 DMChargeAPayer.QuSousTotal.SQL.Add('and DateSaisie='''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
                 DMChargeAPayer.QuSousTotal.Params[0].DataType := ftString;
                 case DMChargeAPayer.Tag of
                    11:DMChargeAPayer.QuSousTotal.SQL.Add(' and Sens=''C''');
                    12:DMChargeAPayer.QuSousTotal.SQL.Add(' and Sens=''D''');
                 end;
                 DMChargeAPayer.QuSousTotal.Open;

//                 // Requete de sous total par compte2
//                 select distinct compte2, sum(MontantHT), sum(TVA)
//                 from ChargeAPayer.db where compte ='4081'
//                 group by compte2

                 DMChargeAPayer.QuTotalG.SQL.Clear;
                 DMChargeAPayer.QuTotalG.SQL.Add('select sum(MontantHT) as MontantHT, sum(TVA) as MontantTVA, sum(MontantHT+TVA) asMontantTTC,0 from ChargeAPayer.db where ');
                 DMChargeAPayer.QuTotalG.SQL.Add(' DateSaisie='''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
                 case DMChargeAPayer.Tag of
                    11:DMChargeAPayer.QuTotalG.SQL.Add(' and Sens=''C''');
                    12:DMChargeAPayer.QuTotalG.SQL.Add(' and Sens=''D''');
                 end;
                 DMChargeAPayer.QuTotalG.Open;

                 DMChargeAPayer.QuChargeAPayerEdition.SQL.Clear;
                 DMChargeAPayer.QuChargeAPayerEdition.SQL.Add('Select ch.*,(Ch.MontantHT+Ch.TVA) as MontantTTC from ChargeAPayer Ch where ');
                 DMChargeAPayer.QuChargeAPayerEdition.SQL.Add('DateSaisie = '''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
                 case DMChargeAPayer.Tag of
                    11:DMChargeAPayer.QuChargeAPayerEdition.SQL.Add(' and Sens=''C''');
                    12:DMChargeAPayer.QuChargeAPayerEdition.SQL.Add(' and Sens=''D''');
                 end;
                 DMChargeAPayer.QuChargeAPayerEdition.Open;

                 case TypeEdition  of
                    C_EditionSimple:Begin
                                     Site.lien := false;
//                                     case DMChargeAPayer.Tag of
//                                          11:EditChargeAPayer(Chemin,NomFich,DMChargeAPayer.QuChargeAPayerEdition,'Compte',DMChargeAPayer.QuListeValRupt,DMChargeAPayer.QuSousTotal,DMChargeAPayer.QuTotalG,DateToStr(E.DatExoDebut),Site,C_Ouverture);
//                                          12:EditProduitARecevoir(Chemin,NomFich,DMChargeAPayer.QuChargeAPayerEdition,'Compte',DMChargeAPayer.QuListeValRupt,DMChargeAPayer.QuSousTotal,DMChargeAPayer.QuTotalG,DateToStr(E.DatExoDebut),Site);
//                                     end;
                                  //   EditChargeAPayer(Chemin,NomFich,DMChargeAPayer.QuChargeAPayerEdition,'Compte',DMChargeAPayer.QuListeValRupt,DMChargeAPayer.QuSousTotal,DMChargeAPayer.QuTotalG,DateToStr(now),Site,C_Ouverture);
                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                                    End;
                    C_EditionWeb:Begin
                                     Site.lien := True;
//                                     EditChargeRepartir(NomMenuSiteWeb,DMChargeRepartir.QuChargeRepartirEdition,'Compte',DMChargeRepartir.QuListeValRupt,DMChargeRepartir.QuSousTotal,DMChargeRepartir.QuTotalG,DateToStr(now),Site);
//                                      case DMChargeAPayer.Tag of
//                                          11:EditChargeAPayer(Chemin,NomFich,DMChargeAPayer.QuChargeAPayerEdition,'Compte',DMChargeAPayer.QuListeValRupt,DMChargeAPayer.QuSousTotal,DMChargeAPayer.QuTotalG,DateToStr(E.DatExoDebut),Site,C_Ouverture);
//                                          12:EditProduitARecevoir(Chemin,NomFich,DMChargeAPayer.QuChargeAPayerEdition,'Compte',DMChargeAPayer.QuListeValRupt,DMChargeAPayer.QuSousTotal,DMChargeAPayer.QuTotalG,DateToStr(E.DatExoDebut),Site);
//                                     end;
                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar('file:///'+Chemin+NomFich+'.xml'),nil,sw_show);
                                 End;
                 end;
                 DMChargeAPayer.QuListeValRupt.Close;
                 DMChargeAPayer.QuSousTotal.Close;
                 DMChargeAPayer.QuTotalG.Close;
                 DMChargeAPayer.QuChargeAPayerEdition.Close;
                end;

    C_Cloture: begin
                 DMChargeAPayer.QuListeValRupt.SQL.Clear;
                 DMChargeAPayer.QuListeValRupt.SQL.Add('select distinct compte from ChargeAPayer.db where ');
                 DMChargeAPayer.QuListeValRupt.SQL.Add(' DateSaisie='''+DateInfos(E.DatExoFin).DatePourSQLStr+'''');
                 DMChargeAPayer.QuListeValRupt.SQL.Add(' and compte='''+DMChargeAPayer.CompteChargeOuProduit+'''');
                 case DMChargeAPayer.Tag of
                    21:DMChargeAPayer.QuListeValRupt.SQL.Add(' and Sens=''C''');
                    22:DMChargeAPayer.QuListeValRupt.SQL.Add(' and Sens=''D''');
                 end;
                 DMChargeAPayer.QuListeValRupt.Open;

                 DMChargeAPayer.QuSousTotal.SQL.Clear;
                 DMChargeAPayer.QuSousTotal.Params.Clear;
                 DMChargeAPayer.QuSousTotal.SQL.Add('select sum(MontantHT) as MontantHT, sum(TVA) as MontantTVA, sum(MontantHT+TVA) asMontantTTC,0 ');
                 DMChargeAPayer.QuSousTotal.SQL.Add('from ChargeAPayer.db where compte =:compte ');
                 DMChargeAPayer.QuSousTotal.SQL.Add('and DateSaisie='''+DateInfos(E.DatExoFin).DatePourSQLStr+'''');
                 DMChargeAPayer.QuSousTotal.Params[0].DataType := ftString;
                 case DMChargeAPayer.Tag of
                    21:DMChargeAPayer.QuSousTotal.SQL.Add(' and Sens=''C''');
                    22:DMChargeAPayer.QuSousTotal.SQL.Add(' and Sens=''D''');
                 end;
                 DMChargeAPayer.QuSousTotal.Open;

//                 // Requete de sous total par compte2
//                 select distinct compte2, sum(MontantHT), sum(TVA)
//                 from ChargeAPayer.db where compte ='4081'
//                 group by compte2

                 DMChargeAPayer.QuTotalG.SQL.Clear;
                 DMChargeAPayer.QuTotalG.SQL.Add('select sum(MontantHT) as MontantHT, sum(TVA) as MontantTVA, sum(MontantHT+TVA) asMontantTTC,0 from ChargeAPayer.db where ');
                 DMChargeAPayer.QuTotalG.SQL.Add(' DateSaisie='''+DateInfos(E.DatExoFin).DatePourSQLStr+'''');
                 case DMChargeAPayer.Tag of
                    21:DMChargeAPayer.QuTotalG.SQL.Add(' and Sens=''C''');
                    22:DMChargeAPayer.QuTotalG.SQL.Add(' and Sens=''D''');
                 end;
                 DMChargeAPayer.QuTotalG.Open;

                 DMChargeAPayer.QuChargeAPayerEdition.SQL.Clear;
                 DMChargeAPayer.QuChargeAPayerEdition.SQL.Add('Select ch.*,(Ch.MontantHT+Ch.TVA) as MontantTTC from ChargeAPayer Ch where ');
                 DMChargeAPayer.QuChargeAPayerEdition.SQL.Add('DateSaisie = '''+DateInfos(E.DatExoFin).DatePourSQLStr+'''');
                 case DMChargeAPayer.Tag of
                    21:DMChargeAPayer.QuChargeAPayerEdition.SQL.Add(' and Sens=''C''');
                    22:DMChargeAPayer.QuChargeAPayerEdition.SQL.Add(' and Sens=''D''');
                 end;
                 DMChargeAPayer.QuChargeAPayerEdition.Open;

                 case TypeEdition  of
                    C_EditionSimple:Begin
                                     Site.lien := False;
//                                     case DMChargeAPayer.Tag of
//                                          21:EditChargeAPayer(Chemin,NomFich,DMChargeAPayer.QuChargeAPayerEdition,'Compte',DMChargeAPayer.QuListeValRupt,DMChargeAPayer.QuSousTotal,DMChargeAPayer.QuTotalG,DateToStr(E.DatExoFin),Site,C_Cloture);
//                                          22:EditProduitARecevoir(Chemin,NomFich,DMChargeAPayer.QuChargeAPayerEdition,'Compte',DMChargeAPayer.QuListeValRupt,DMChargeAPayer.QuSousTotal,DMChargeAPayer.QuTotalG,DateToStr(E.DatExoFin),Site);
//                                     end;
                                   //  EditChargeAPayer(Chemin,NomFich,DMChargeAPayer.QuChargeAPayerEdition,'Compte',DMChargeAPayer.QuListeValRupt,DMChargeAPayer.QuSousTotal,DMChargeAPayer.QuTotalG,DateToStr(now),Site,C_Cloture);
                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                                    End;
                    C_EditionWeb:Begin
                                     Site.lien := False;
//                                     EditChargeRepartir(NomMenuSiteWeb,DMChargeRepartir.QuChargeRepartirEdition,'Compte',DMChargeRepartir.QuListeValRupt,DMChargeRepartir.QuSousTotal,DMChargeRepartir.QuTotalG,DateToStr(now),Site);
//                                     case DMChargeAPayer.Tag of
//                                          21:EditChargeAPayer(Chemin,NomFich,DMChargeAPayer.QuChargeAPayerEdition,'Compte',DMChargeAPayer.QuListeValRupt,DMChargeAPayer.QuSousTotal,DMChargeAPayer.QuTotalG,DateToStr(E.DatExoFin),Site,C_Cloture);
//                                          22:EditProduitARecevoir(Chemin,NomFich,DMChargeAPayer.QuChargeAPayerEdition,'Compte',DMChargeAPayer.QuListeValRupt,DMChargeAPayer.QuSousTotal,DMChargeAPayer.QuTotalG,DateToStr(E.DatExoFin),Site);
//                                     end;
                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar('file:///'+Chemin+NomFich+'.xml'),nil,sw_show);
                                 End;
                 end;
                 DMChargeAPayer.QuListeValRupt.Close;
                 DMChargeAPayer.QuSousTotal.Close;
                 DMChargeAPayer.QuTotalG.Close;
                 DMChargeAPayer.QuChargeAPayerEdition.Close;
                end;
 end;
End;

//v�rifie la saisie dans la feuille E2_ReprisechargeAPayer
procedure TDMChargeAPayer.VerifSaisieFeuilleReprise1(cCourant:tfield);
begin
case CCourant.Index of
     12: Begin//TaChAPayer3Date_Piece
             If not(empty(ccourant.asstring))Then
             Begin
                  // V�rifier que la date saisie est dans l'ann�e de l'exercice en cours
                  If ((CCourant.AsDateTime < E.DatExoDebut) Or (CCourant.AsDateTime > E.DatExoFin)) Then
                  Begin
                       Messagedlg('La date saisie doit appartenir � l''exercice courant !!!',mtWarning,[mbok],0);
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
FiltrageDataSet(TaChAPayer3,CreeFiltreET(['DateSaisie','Sens'],[DateToStr(E.DatExoDebut-1),Sens]));
end;

//Ecrit la reference dans la table charges a payer apr�s avoir cr�er l'OD
Procedure TDMChargeAPayer.EcritureReference(ID:integer;Changerdate:boolean;Ref:string;Date:Tdatetime);
begin
try
    if TaChAPayerEcritureReference.Locate('ID',ID,[]) then
    begin
      TaChAPayerEcritureReference.Edit;
      TaChAPayerEcritureReference.FindField('Reference').AsString:= Ref;
      if Changerdate=true then
      TaChAPayerEcritureReference.FindField('Date_Piece').Asdatetime:=Date;
      TableGerePost(TaChAPayerEcritureReference);
   end;
  finally

  end;
end;

//Cr�ation des OD apr�s la reprise des charges
procedure TDMChargeAPayer.CreationODChargeAPayerReprise;
var
SoldeCompte:TSoldeCompte;
Except_LGR:TExceptLGR;
ParamAffichage:TParamAffichage;
NbEnregistrement:integer;
Ecran:string;
Ret:integer;
begin
MontantTTC:=0;
TaChAPayer2.Refresh;
   try
Initialise_ExceptLGR(Except_LGR);
       TableGereStartTransaction(TaChAPayer2);
       //filtrage avant la Cr�ation des OD de Reprise;
       FiltrageDataSet(TaChAPayer2,'Date_Piece <>null and Date_Piece >= '''+DateTimeToStr(E.DatExoDebut)+''' And Date_Piece <= '''+DateTimeToStr(E.DatExoFin)+''' And DateSaisie = '''+DateTimeToStr(E.DatExoDebut - 1)+''' And Reference = ''''');
       NbEnregistrement:=TaChAPayer2.RecordCount;
       TaChAPayer2.first;
       // Tant qu'il reste des enregistrements dans la table TaCAR
        While (Not(NbEnregistrement=0)) Do
        Begin
             if TaChAPayer2.findfield('Sens').Asstring[1]='C'then
               Ecran:='Produit � recevoir'
             else
               Ecran:='Charges � payer';
         Except_LGR:=PossibiliteRepriseCompte(TaChAPayer2.findfield('Compte').Asstring,TaChAPayer2,TaChAPayer2.findfield('Sens').Asstring[1],Ecran);
//           try//except
//               Except_LGR.retour:=true;
//               Except_LGR.NumErreur:=0;
//               SoldeCompte:=DMBalance.RetourneSoldeCompteAvantReprise(TaChAPayer2.findfield('Compte').Asstring,TaChAPayer2,0,TaChAPayer2.findfield('Sens').Asstring[1]);
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
//                       Ret:=Application.MessageBox(Pchar('il existe une diff�rence entre vos '+Ecran+', le solde de la '+#13+#10+'balance et le solde du bilan d''ouverture '+#13+#10+'sur le compte :'+#13+#10+'Vous ne pouvez pas reprendre vos '+Ecran+' sur ce '+#13+#10+'compte'+#13+#10+'Souhaitez vous visualiser ces diff�rences ou annuler cette reprise ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNOCANCEL+MB_DEFBUTTON2);
//                       if Ret=mryes then
//                         begin
//                            Initialise_TParamAffichage(ParamAffichage);
//                            ParamAffichage.AffichModal := true;
//                            ParamAffichage.Titre:='Liste des Soldes du compte '+TaChAPayer2.findfield('Compte').Asstring;
//                            ParamAffichage.GestionAffichForm.Caption := ParamAffichage.Titre;
//                            AfficheVisuListView(ParamAffichage,['Ecran','Compte','D�bit','Cr�dit'],
//                                                               [200,200,150,150],
//                                                               [SoldeCompte.ListeSolde],
//                                                               [taLeftJustify,taLeftJustify,taRightJustify,taRightJustify],
//                                                               [1..2],
//                                                               [3..4],[0]);
//                         end;
//                      if ret=Mrno then
//                        Except_LGR.retour:=Application.MessageBox(Pchar('Etes-vous s�r de vouloir faire la reprise'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes;
//                     end;
//               4:begin
//                   if Application.MessageBox(Pchar('il existe une diff�rence entre le solde de la balance et le solde '+#13+#10+'de vos '+Ecran+' sur le compte :'+TaChAPayer2.findfield('Compte').Asstring+#13+#10+'Vous ne pouvez pas reprendre vos '+Ecran+' pour ce compte. Souhaitez vous annuler cette reprise ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNOCANCEL+MB_DEFBUTTON1)=mryes then
//                      Except_LGR.retour:=Application.MessageBox(Pchar('Etes-vous s�r de vouloir faire la reprise'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes;
//                  // MessageDlg('il existe une diff�rence entre le solde de la balance et le solde '+#13+#10+'de vos '+Ecran+' sur le compte :'+TaChAPayer2.findfield('Compte').Asstring+#13+#10+'Vous ne pouvez pas reprendre vos '+Ecran+' pour ce compte. Voulez-vous annuler cette proc�dure ?', mtWarning, [mbYes,mbNo], 0);
//                 end;
//             end;//fin du case ExceptLGR
//           end;
         if Except_LGR.retour then
           begin
            MontantTTC:=TaChAPayer2MontantHT.AsCurrency+TaChAPayer2TVA.AsCurrency;
            CreationODReprise_avecObjet(TaChAPayer2,'');
            //une fois l'OD cr�e, on �crit la r�f�rence de cette pi�ce dans la table des charges � payer
            EcritureReference(DMChargeAPayer.TaChAPayer2ID.AsInteger,false,DMImport.Piece_Import.Reference,e.DatExoDebut);
           end;
        TaChAPayer2.Next; //et on continue jusqu'� ce qu'il n'y ai plus de nouvelle charges enregistr�e sans r�f�rence
        NbEnregistrement:=NbEnregistrement-1;
        end;
        TableGereCommit(TaChAPayer2);
        TableGereCommit(DMPieces.TaPiece);
   except
       begin
       showmessage('Probl�me � l''enregistrement des OD d''ouverture');
       TableGereRollBack(TaChAPayer2);
       TableGereRollBack(DMPieces.TaPiece);
       abort;
       end;
   end;
end;

//cr�ation des OD concernant les charges et produits enregistr�s dans la cl�ture
procedure TDMChargeAPayer.CreationODChargeAPayerCloture;
var
NbEnregistrement:integer;
begin
try
   try
      TableGereStartTransaction(TaChAPayer);
      // filtrage avant la Creation des OD de Cloture pour soustraire les charges ou produits avant de les
      //r�enregistrer suite � la cr�ation des OD
      FiltrageDataSet(TaChAPayer,'DateSaisie = '''+DateTimeToStr(E.DatExoFin)+''' And Reference = ''''');
      NbEnregistrement:=TaChAPayer.RecordCount;
      TaChAPayer.First;
      While (Not(NbEnregistrement=0)) Do
        Begin
        MontantTTC:=TaChAPayerMontantHT.AsCurrency+TaChAPayerTVA.AsCurrency;
        InitialisationVariablesTemp;//mise � z�ro des variables temporaires
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
//      pour tous les nouvelles charges ou produits enregistr�e dans la cl�ture
//      on soustrait de la balance le montant de ces charges 1 par 1
//      pour pouvoir les mettre � jour de nouveau en cr�ant les OD de cl�ture
        if TaChAPayerSens.AsString='C'then  //traitement porte sur les charges
        TraitementMAJBalance(21,true,dsbrowse,'');
        if TaChAPayerSens.AsString='D'then  //traitement porte sur les produits
        TraitementMAJBalance(22,true,dsbrowse,'');
        TaChAPayer.next;
        NbEnregistrement:=NbEnregistrement-1;
        end;
       // filtrage avant la Creation des OD de Cloture.Ce filtrage intervient apr�s la MAJBalance'' 
       FiltrageDataSet(TaChAPayer2,'DateSaisie = '''+DateTimeToStr(E.DatExoFin)+''' And Reference = ''''');
       NbEnregistrement:=TaChAPayer2.RecordCount;
       TaChAPayer2.first;
       // Tant qu'il reste des enregistrements dans la table TaCAR
        While (Not(NbEnregistrement=0)) Do
        Begin
        TaChAPayer2.Refresh;
        MontantTTC:=TaChAPayer2MontantHT.AsCurrency+TaChAPayer2TVA.AsCurrency;
        CreationODCloture_avecObjet(TaChAPayer2,'');
        //une fois l'OD cr�e, on �crit la r�f�rence de cette pi�ce dans la table des charges � payer
        EcritureReference(DMChargeAPayer.TaChAPayer2ID.AsInteger,true,DMImport.Piece_Import.Reference,e.DatExoFin);
        TaChAPayer2.Next; //et on continue jusqu'� ce qu'il n'y ai plus de nouvelle charges enregistr�e sans r�f�rence
        NbEnregistrement:=NbEnregistrement-1;
        end;
        TableGereCommit(TaChAPayer2);
        TableGereCommit(DMPieces.TaPiece);
   except
       begin
       showmessage('Probl�me � l''enregistrement des OD d''ouverture');
       TableGereRollBack(TaChAPayer2);
       TableGereRollBack(DMPieces.TaPiece);
       abort;
       end;
   end;
finally
   DeFiltrageDataSet(TaChAPayer);
end;
end;


//mise � z�ro des variables temporaires
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


//pr�pare les listes d'OD � afficher dans ''E2_RepriseChargesAPayer2_Isa''
//passe les param�tres d'affichage de cette fen�tre (caption, boutons,etc...)
//Cette fen�tre sert � afficher les OD des diff�rents menu d'ouverture et de cl�ture
//les param�tres d'affichage sont pass�s au moment de la demande d'affichage de cette fen�tre
procedure TDMChargeAPayer.DemandeAffichageReprise;
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
   liste1:=CreationListeOD(E.DatExoDebut-1,'C');
   liste2:= CreationListeOD(E.DatExoDebut-1,'D');
   DMPieces.AffichageFeuilleReprise(NumButton,liste1,liste2,'OD de Reprise des Charges A Payer et Produits A Recevoir',
   'OD de Reprise Charges A Payer','OD de Reprise Produits A Recevoir',true);
 end;
if numtag=2 then
  begin
    liste1:=CreationListeOD(E.datexofin,'C');
    liste2:=CreationListeOD(E.datexofin,'D');
    DMPieces.AffichageFeuilleReprise(NumButton,liste1,liste2,'OD Cl�ture des Charges A Payer et Produits A Recevoir',
    'OD Cl�ture Charges A Payer','OD Cl�ture Produits A Recevoir',true);
  end;
//liste1.Free;
//liste2.Free;
end;


//cr�e la liste des OD � afficher dans ''E2_RepriseChargesAPayer2_Isa'
//l'appel de cette fonction se fait dans ''DemandeAffichageReprise''
function TDMChargeAPayer.CreationListeOD(DateExo:TDateTime;sens:string):TStringList;
begin
try
FiltrageDataSet(TaChAPayer,'DateSaisie = '''+DateTimeToStr(DateExo)+''' And Reference <> '''' And Sens = '''+sens+'''');
result:=TStringList.Create;
result.Clear;
  While (Not(TaChAPayer.EOF)) Do
     Begin
         If result.IndexOf(TaChAPayerReference.AsString) = -1 Then
            result.Add(TaChAPayerReference.AsString);
         TaChAPayer.Next;
     End;

except
   result.clear;
end;
end;


//******************* TDMChargeAPayer.TraitementMAJBalance *************************
//Permet de mettre � jour la balance � la fois lors de l'enregistrement d'une nouvelle
//charges ou produit en ajout, mais aussi en soustraction avant la cr�ation d'une OD
//car la cr�ation de l'OD g�n�re une mise � jour de la balance elle aussi.
procedure TDMChargeAPayer.TraitementMAJBalance(Ch_Pr:integer;Suppression:boolean;EtatTaChApayer:TDataSetState;Ref:string);
var
param:TRecupParametres; //nom du champ(Debit ou Credit)et du champ Quantit�
begin
try
if Ch_Pr= 0 then
param:=RecupParametreMAJBalance(self.tag)//r�cup�ration des param�tres de MAJ Balance
else
param:=RecupParametreMAJBalance(Ch_Pr);//r�cup�ration des param�tres de MAJ Balance
with param do
   begin //D�but du with   
    if empty(Ref) then
    begin
    //mise � jour balance pour le compte de charges A Payer
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
                 compteTmp,TaChAPayerQte.AsFloat,QteTmp,MontantTTC,TTCTmp,EtatTaChApayer);//MAJ Balance pour compte de charges ou de produits
                 //s'il y a de la tva sur la charge
                 if((TaChAPayerTVA.AsCurrency<>0) or(TvaTmp<>0))then
                 DMBalance.MAJBalance(Suppression,qte2,sens2,compteTva,
                 compteTva,0,0,TaChAPayerTVA.AsCurrency,TvaTmp,EtatTaChApayer);
                 end;
           21,22:begin//si cl�ture, MAJ balance de cl�ture (Base)
                 DMBalance.MAJBalance(Suppression,qte1,sens1,TaChAPayerCompte.AsString,
                 compteTmp,TaChAPayerQte.AsFloat,QteTmp,MontantTTC,TTCTmp,dsinsert);//MAJ Balance pour compte de charges ou de produits
                 //s'il y a de la tva sur la charge
                 if((TaChAPayerTVA.AsCurrency<>0) or(TvaTmp<>0))then
                 DMBalance.MAJBalance(Suppression,qte2,sens2,compteTva,
                 compteTva,0,0,TaChAPayerTVA.AsCurrency,TvaTmp,dsinsert);
                 end;
           end;//fin du case
       end;// FIN si la charge a une OD
end;//fin du with
except
  abort;
end;
end;


//******************* TDMChargeAPayer.TaChAPayerBeforePost *************************
//Contr�le de la saisie, mise � jour de la balance, ouverture d'une transaction
procedure TDMChargeAPayer.TaChAPayerBeforePost(DataSet: TDataSet);
var
Annee,Mois,Jour:word;
DateCourante:Tdatetime;
I:integer;
controleSaisie:TErreurSaisie;
begin
if DataSet.State in [dsinsert,dsedit] then
   begin//si insertion ou modification
      case E.TypeEtatExercice of
        ET_Importation,
        ET_Normal,
        ET_Maint:    Begin
                        ////Contr�le la saisie////////
                           for i:=8 to 9 do
                             begin
                             controleSaisie:=CtrlSaisieChargesAPayer(TaChAPayer.Fields[i]);
                             if controleSaisie.Retour=false then
                                   case controleSaisie.CodeErreur of
                                   8100,8101:begin
                                          //Focus sur compte2
                                          LaisserPasser:=false;
                                          if ((not empty(DataSet.Fields[8].asstring))and(controleSaisie.CodeErreur<>8101))then
                                            begin
                                            if application.MessageBox(Pchar('Ce compte n''est pas coh�rent dans ce context, voulez-vous continuer'),'Erreur de saisie',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON1)=mrno then
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
                        //           8101:begin
                        //                  DataSet.Fields[8].FocusControl;
                        //                  abort;//champ code emprunt
                        //                end;
                                   end;//fin du case
                             end;//fin du i=8 � 10
                           for i:=4 to 5 do
                             begin
                             controleSaisie:=CtrlSaisieChargesAPayer(TaChAPayer.Fields[i]);
                             if controleSaisie.Retour=false then
                                   case controleSaisie.CodeErreur of
                                   5100:begin
                                          if assigned(FOnGEstInterfaceEvent) then
                                           FOnGEstInterfaceEvent(DataSet.Fields[5]);
//                                         DataSet.Fields[5].FocusControl;
                                          abort;//champ code emprunt
                                        end;
                                   end;//fin du case
                             end;//fin du i=4 to 5

                            controleSaisie:=CtrlSaisieChargesAPayer(TaChAPayer.Fields[10]);
                            ////fin du Contr�le de la saisie////////
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
      TaChAPayerID.AsInteger:=MaxId_Query(TaChAPayer,'ID');
      TaChAPayerCompte.AsString:=CompteChargeOuProduit; //PB le 29/12/2002

      TaChAPayerLibelle.AsString:=DMPlan.LibelleDuNumCptPCU(CompteChargeOuProduit); //PB le 29/12/2002
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
      showmessage('Probl�me � l''�criture dans la table Charges A Payer !!!');
      abort;
      end;//fin du try
/////fin du Remplissage des champs hors saisie////////

      case E.TypeEtatExercice of
        ET_Importation,
        ET_Normal,ET_EnCloture,
        ET_Maint:    Begin
                       //Mise � jour de la balance
                       TableGereStartTransaction(TaChAPayer);
                       try
                       MontantTTC:=TaChAPayerMontantHT.AsCurrency+TaChAPayerTVA.AsCurrency;
                        TraitementMAJBalance(self.tag,false,DataSet.State,ref);
                           if DataSet.State =dsEdit then //si en modification
                             if not(empty(ref)) then //si OD cr��e
                                 begin //si la modification porte sur un champ autre que la d�signation
                                 //on supprime l'OD
                                    if (trim(TaChAPayerCompte2.AsString)<>trim(Compte2Tmp))or
                                   (TaChAPayerMontantHT.AsCurrency<>MontantTmp)or(TaChAPayerQte.AsFloat<>QteTmp)
                                   or (TaChAPayerTVA.AsFloat<>TvaTmp)then
                                   begin
                                   DMPieces.SuppressionOD(TaChAPayerReference.AsString);
                                   TaChAPayerReference.AsString:='';
                                   TaChAPayerDate_Piece.Asstring:='';
                                   TaChAPayerDateSysteme.AsDateTime:=now;
                                   end
                                   else //sinon, on modifie l'OD uniquement
                                   if trim(TaChAPayerLibelle2.asstring)<>trim(DesignationTmp) then
                                   DMPieces.ModificationOD(TaChAPayerReference.AsString,TaChAPayerLibelle2.asstring);
                                 end;//fin si modif et OD
                       except
                       //si probl�me, annule toutes les �critures (Suppression ou modif OD, MAJ Balance,enregistrement charge)
                       TableGereRollback(DataSet);
                       TableGereRollback(DMPieces.TaPiece);
                       showmessage('Probl�me � la mise � jour de la balance !!!');
                       abort;
                       end;//fin du try
                     end;//fin type etat ()
      end;//fin du case typeEtatExercice
   end;//fin si insertion ou modification
end;

//sert � contr�ler la saisie, � proposer une liste dans certain cas,
//� remplir un champ vide par d�faut dans certain cas
//enfin, renvoie un code erreur si la saisie reste invalide
Function TDMChargeAPayer.CtrlSaisieChargesAPayer(CCourant:Tfield):TErreurSaisie;
var
//RetourEnregistrement:TEnregistrementComplet;
RetourEnregistrement:TInfosPlanCpt;
begin // initialisation des variables de retour de fonction
CtrlSaisieChargesAPayer.CodeErreur:=0;
CtrlSaisieChargesAPayer.Retour:=True;
  if TaChAPayer.State in [dsinsert,dsEdit] then
  begin //si �tat insertion ou modification
        case CCourant.Index of
        8: begin // si champ n� 1 (compte2)
         if LaisserPasser then
           LaisserPasser:=(CCourant.AsString=Compte2Tmp);
        GestionFiltrageAideCompte(ccourant);//on filtre aideCompte par
        //rapport au compte de charges pour y afficher les comptes de reprise correspondants
           if LaisserPasser=false then
               begin//si non laisserPasser
//                 if not VerifSiCompteSaisieDsBO(CCourant.AsString,true,CCourant.DataSet,Quand=C_Ouverture) then
//                   begin //si pas d�j� utilis� dans ouverture
                   if AideCompteDansContexte_LaisserPasser(CCourant.AsString,ccourant,['Rac1','Rac2','Rac3','Rac4','Rac5'],false,false,MessDerSub,LaisserPasser,true,true,false,true,0)=false then
                     begin//si compte pas ok
                       if not LaisserPasser then
                         begin //si LaisserPasser=faux
                         if not DMPlan.CompteExistePCU(CCourant.AsString) then
                           CtrlSaisieChargesAPayer.CodeErreur:=8101  //Compte non existant ou d�j� utilis� ailleurs
                         else
                           CtrlSaisieChargesAPayer.CodeErreur:=8100;  //Compte hors contexte
                         CtrlSaisieChargesAPayer.Retour:=False;
                         end;//fin si not LaisserPasser
//                         else
//                          begin//si laisser passer, on ne laisse pas passer les comptes collectifs ou rattach� � code tva
//                            if (DMPlan.CptEstCollectif(CCourant.AsString))or(FTvaCompteDeTva(CCourant.AsString))then
//                               begin//si Compte hors contexte
//                                  showmessage('Ce compte n''est pas correct dans le contexte');
//                                  CtrlSaisieChargesAPayer.CodeErreur:=8100;  //Compte hors contexte
//                                  CtrlSaisieChargesAPayer.Retour:=False;
//                               end;//fin si Compte hors contexte
//                          end;// Fin (si laisser passer, on ne laisse pas passer les comptes collectifs ou rattach� � code tva)
                     end;//fin si compte pas ok
                   //end//fin si pas d�j� utilis� dans ouverture
//                 else
//                   begin //si utilis� dans ouverture
//                      CtrlSaisieChargesAPayer.CodeErreur:=8101;  //Compte hors d�j� utilis� ailleurs
//                      CtrlSaisieChargesAPayer.Retour:=False;
//                   end;// fin si utilis� dans ouverture
               end; //fin si non laisserPasser
                //R�cup�re les param�tres du compte de reprise s�l�ctionn�, et en fonction
             //initialise certains champs comme la Quantit� ou la tva, si champ libell� vide,
             //rempli par d�faut avec le libell� du compte
             if result.retour then
              begin
                 if (CCourant.AsString=CompteChargeOuProduit)then
                 begin
                   showmessage('Ce compte n''est pas correct dans le contexte');
                   CtrlSaisieChargesAPayer.CodeErreur:=8200;
                   CtrlSaisieChargesAPayer.Retour:=False;
                 end
               else RecupInfoApresVerif(true);
//               if VerifSiCompteSaisieDsBO(CCourant.AsString,true,CCourant.DataSet,Quand=C_Ouverture) then
//                 begin
//                   LaisserPasser:=false;
//                   if assigned(FOnGEstInterfaceEvent) then
//                     FOnGEstInterfaceEvent(CCourant);
////                   CCourant.FocusControl;
//                   CtrlSaisieChargesAPayer.CodeErreur:=8200;  //Compte d�j� utilis� dans BO
//                   CtrlSaisieChargesAPayer.Retour:=False;
//                 end else

             end;
           end;//fin champ n�1
// //rapport au compte de charges pour y afficher les comptes de reprise correspondants
        9: begin//si champ n�2(D�signation)
            // Le champ est vide, affectation du libell� utilisateur par d�faut
            DeFiltrageDataSet(DMRech.TaPlanCptRech);
            If Empty(CCourant.AsString) then
               begin
               RetourEnregistrement:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[CCourant.DataSet.FindField('compte2').AsString]);
//               RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaChAPayerCompte2.AsString);
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
                 RetourEnregistrement:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[CCourant.DataSet.FindField('compte2').AsString]);
//                 RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaChAPayerCompte2.AsString);
                  if not(empty(RetourEnregistrement.Libelle)) then
                     begin
                     ccourant.AsString:=RetourEnregistrement.Libelle;
                     DernierLibelle:=RetourEnregistrement.Libelle;
                     end;
               end;//fin champ n�2 vide
           end;//fin si champ n�2(D�signation)
        4: begin//si champ n�3 (Qt�)
            If (Empty(CCourant.AsString)) and (ccourant.ReadOnly=false) then
             cCourant.AsString:='0';
           end;//fin si champ n�3 (Qt�)
        5: begin//si champ n�4 (Montant HT)
             if VerifFNumeric(CCourant).VideOUZero then // PB le 05/08/2002
             Begin // si champ n�4 vide ou =0
             CtrlSaisieChargesAPayer.CodeErreur:=5100;
             CtrlSaisieChargesAPayer.Retour:=False;
             Application.Messagebox(Pchar('La saisie du montant HT est obligatoire !!!'),'Erreur de saisie',0);
             end;//fin  si champ n�4 vide ou =0
           end;//fin si champ n�4 (Montant HT)
        10:begin//si champ n�5 (TVA)
             If (Empty(CCourant.AsString)) and (ccourant.ReadOnly=false) then
             Begin // si champ n�5 vide et pas en lecture seule
             cCourant.AsString:='0';
             end;//fin si champ n�5 vide et pas en lecture seule
             if not VerifFNumeric(CCourant).VideOUZero then // PB le 05/08/2002
             Begin // si champ n�5 pas vide
             // v�rifie la coh�rence du montant tva saisie avec le montant calcul� en fonction
             // des taux r�cup�r�s. si incoh�rent,envoie message et AideMontantTTC
             VerifTVA;
             end;//fin si champ n�5 pas vide
           end;//fin si champ n� 5 (TVA)
        end;//fin du case.ccourant
  end; //fin etat insertion ou modif
end;


//filtre la grille suivant si on est sur la fen�tre d'ouverture ou de cl�ture
procedure TDMChargeAPayer.FiltrageAffichageGrille(Tag_bis:integer;Compte:String);
begin
 case Tag_bis of
    1,11,12 : FiltrageDataSet(TaChAPayer,CreeFiltreET(['Compte','DateSaisie'],[Compte,datetostr(E.DatExoDebut-1)]));
    2,21,22 : FiltrageDataSet(TaChAPayer,CreeFiltreET(['Compte','DateSaisie'],[Compte,DateToStr(E.DatExoFin)]));
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

ListeEditCompte:=TStringList.Create;
ListeEditCompte2:=TStringList.Create;

MessDerSub:=true;
end;


//Fermeture des tables
procedure TDMChargeAPayer.DMChargeAPayerDestroy(Sender: TObject);
begin
  try
    FermerTouteTable('',TControl(self));
    ListeEditCompte.Free;
    ListeEditCompte2.Free;
    DMChargeAPayer := nil;
  except
   Showmessage('Erreur lors la lib�ration de : '+self.Name);
  end;
end;



//permet de r�cup�rer des param�tres de MAJ de balance suivant si elle intervient � l'ouverture
//ou � la cl�ture, si elle porte sur une charge ou un produit
function  TDMChargeAPayer.RecupParametreMAJBalance(tag_module:integer):TRecupParametres;
begin
   with result do
   begin
    case tag_module of
         11:begin //ouverture-Charges
            sens1:='Credit_Report';
//            Qte1:='Qt2_Report';
            Qte1:='Qt1_Report';
            sens2:='Debit_Report';
            Qte2:='Qt1_Report';
            compteTva:=DM_C_CompteTVAChargeAPayer
            end;
         21:begin //Cloture-Charges
            sens1:='Credit_Base';
//            Qte1:='Qt2_Base';
            Qte1:='Qt1_Base';
            sens2:='Debit_Base';
            Qte2:='Qt1_Base';
            compteTva:=DM_C_CompteTVAChargeAPayer
            end;
         12:begin //ouverture-Produits
            sens1:='Debit_Report';
            Qte1:='Qt1_Report';
            sens2:='Credit_Report';
//            Qte2:='Qt2_Report';
            Qte2:='Qt1_Report';
            compteTva:=DM_C_CompteTVAProduitARecevoir
            end;
         22:begin //Cloture-Produits
            sens1:='Debit_Base';
            Qte1:='Qt1_Base';
            sens2:='Credit_Base';
//            Qte2:='Qt2_Base';
            Qte2:='Qt1_Base';
            compteTva:=DM_C_CompteTVAProduitARecevoir

            end;
         end;//fin du case
   end;//fin du with
end;

//fini la transaction, r�cup�re l'ID de la derni�re ligne de la grille, filtre la grille en fonction
//du nouvel enregistrement �crit et mise � z�ro des variables temporaires
procedure TDMChargeAPayer.TaChAPayerAfterPost(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMPieces.TaPiece);
//if @DataChAPayer.OnStateChange<>nil then DataChAPayer.OnStateChange(TaChAPayer);
InitialisationVariablesTemp;
MessDerSub:=true;
end;

//Rempli les variables temporaires avant la modification, envoie un message de confirmation
//si la charges d�pend d'une OD,
procedure TDMChargeAPayer.TaChAPayerBeforeEdit(DataSet: TDataSet);
var
   messagetmp: String;
begin
if inttostr(self.Tag) < inttostr(2) then
if VerifSiCompteSaisieDsBO(CompteChargeOuProduit,true,DataSet) then
  begin
    abort;  //Compte d�j� utilis� dans BO
  end;
      //Pr�pare un message suivant si la modif porte sur une charge ou un produit
      Case self.Tag Of
      11,21: messagetmp := 'Attention, la reprise de cette charge � payer a �t� effectu�e !!!'+#10#13+'La modification de cette charge � payer entra�nera la modification de l''OD de reprise et la mise � jour de la balance !!!'+#10#13+'Confirmer la modification de cette charge � payer ?';
      12,22: messagetmp := 'Attention, la reprise de ce produit � recevoir a �t� effectu�e !!!'+#10#13+'La modification de ce produit � recevoir entra�nera la modification de l''OD de reprise et la mise � jour de la balance !!!'+#10#13+'Confirmer la modification de ce produit � recevoir ?';
      End; // Fin du Case

      // Si le compte poss�de une OD, envoie du message de confirmation
      If DMChargeAPayer.TaChAPayerReference.AsString <> '' Then
           If Messagedlg(messagetmp,MtConfirmation,[mbyes,mbno],0) = mrno Then
                abort;
//mise � z�ro des variables temporaires
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


//Pr�pare un message de confirmation de suppression si la charge ou le produit d�pend d'une
//OD, mise � z�ro des variables temporaires et remplissage de ces variables avant suppression
//commence une transaction

procedure TDMChargeAPayer.TaChAPayerBeforeDelete(DataSet: TDataSet);
var
   messagetmp: String;
begin
try
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

            if empty(TaChAPayerReference.AsString) then
              messagetmp :='�tes-vous s�r de supprimer cette charge � payer ?'
            else
              if self.tag=21 then
                messagetmp :='�tes-vous s�r de supprimer cette charge � payer ?'+#10#13+'La suppression de cette charge � payer entra�nera la suppression de l''OD et la mise � jour de la balance !!!'+#10#13+'Confirmer la suppression de cette charge � payer ?'
              else
                messagetmp :='Attention, la reprise de cette charge � payer a �t� effectu�e !!!'+#10#13+'La suppression de cette charge � payer entra�nera la suppression de l''OD de reprise et la mise � jour de la balance !!!'+#10#13+'Confirmer la suppression de cette charge � payer ?';
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

            if empty(TaChAPayerReference.AsString) then
            messagetmp :='�tes-vous s�r de supprimer ce produit � recevoir ?'
            else
            if self.tag=22 then
              messagetmp := '�tes-vous s�r de supprimer ce produit � recevoir ?'+#10#13+'La suppression de ce produit � recevoir entra�nera la suppression de l''OD et la mise � jour de la balance !!!'+#10#13+'Confirmer la modification de ce produit � recevoir ?'
            else
              messagetmp := 'Attention, la reprise de ce produit � recevoir a �t� �ffectu�e !!!'+#10#13+'La suppression de ce produit � recevoir entra�nera la suppression de l''OD et la mise � jour de la balance !!!'+#10#13+'Confirmer la modification de ce produit � recevoir ?';
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

      //mise � z�ro des variables temporaires
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

      //D�but de transaction
      TableGereStartTransaction(TaChAPayer);
      if not(empty(ref)) then
         begin//si la charge ou produit � une OD
            try
              DMPieces.SuppressionOD(ref);//suppression de l'OD
            except
              showmessage('Probl�me � la suppression d''une charge');
              abort;
            end;//fin du try
         end;// fin si la charge ou produit � une OD
         try
           //Mise � jour de la balance d'ouverture en soustraction
          case self.tag of
             11,12:TraitementMAJBalance(self.tag,true,dsBrowse,ref);
          end;//fin du case
         except
         //si probl�me, annule toutes les �critures (Suppression OD, MAJ Balance,suppression charge)
         TableGereRollback(DataSet);
         TableGereRollback(DMPieces.TaPiece);
         showmessage('Probl�me � la Mise A Jour de la balance apr�s une suppression d''OD ');
         abort;
         end;//fin du try
except
 TableGereRollback(DataSet);
 TableGereRollback(DMPieces.TaPiece);
 abort;
end;
end;


//fini la transaction, r�cup�re l'ID de la derni�re ligne de la grille, d�clenche un
//changement d'Etat pour g�rer les boutons, mise � z�ro des variables temporaires
procedure TDMChargeAPayer.TaChAPayerAfterDelete(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMPieces.TaPiece);
if @DataChAPayer.OnStateChange<>nil then DataChAPayer.OnStateChange(TaChAPayer);
InitialisationVariablesTemp;
end;


//emp�che la suppression d'une charge ou d'un produit dans fen�tre de reprise
procedure TDMChargeAPayer.TaChAPayer3BeforeDelete(DataSet: TDataSet);
begin
abort;
end;


//v�rifie la saisie de la date de reprise dans E2_repriseChargesAPayer_Isa ,ouvre une transaction
//supprime l'OD si date enlev�, modifie l'OD si date modifi�e
procedure TDMChargeAPayer.TaChAPayer3BeforePost(DataSet: TDataSet);
var
messages:string;
begin
messages:='Probl�me � la suppression ou la modification de l''OD ';
   try
   VerifSaisieFeuilleReprise1(TaChAPayer3Date_Piece);
   except
   abort;
   end;
   TableGereStartTransaction(DataSet);
   if TaChAPayer3.State = dsedit then
   try
     if (datepiece<>TaChAPayer3Date_Piece.AsDateTime) and (not(empty(TaChAPayer3Reference.AsString))) then
       if empty(TaChAPayer3Date_Piece.asstring) then
         begin
         if application.MessageBox(Pchar('Attention, la suppression de la date entra�nera la suppression de l''OD de reprise et la modification de la balance !!!'+#10#13+'Confirmer la suppression de la date ?'),'Confirmation',MB_YESNO+MB_DEFBUTTON1)=mryes then
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
         if application.MessageBox(Pchar('Attention, la modification de la date entra�nera la modification de l''OD de reprise et la modification de la balance !!!'+#10#13+'Confirmer la modification de la date ?'),'Confirmation',MB_YESNO+MB_DEFBUTTON1)=mryes then
             Begin
               DMPieces.ModificationDatePiece(TaChAPayer3Reference.AsString,TaChAPayer3Date_Piece.asdatetime);
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


//emp�che l'insertion d'une charge ou d'un produit dans fen�tre de reprise
procedure TDMChargeAPayer.TaChAPayer3BeforeInsert(DataSet: TDataSet);
begin
abort;
end;

//filtre les charges ou produits de cl�ture qui ne sont pas repris
procedure TDMChargeAPayer.Filtrage_EcriturePourNouvelExo(var tMem:TRxMemoryData;NouvelleDate:Tdatetime);
var
Filtre:string;
begin
   try
   //filtre les charges ou produits de cl�ture
   Filtre:=TaChAPayer.Filter;
   if TaChAPayer.active=false then
     TaChAPayer.open;
   FiltrageDataSet(TaChAPayer,'(DateSaisie<='''+datetostr(E.DatExoFin)+'''and reference ='''')or (DateSaisie='''+datetostr(E.DatExoFin)+''')');
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
   FiltrageDataSet(TaChAPayer,filtre);
   except
   showmessage('Probl�me � l''�criture dans la nouvelle table '+TaChAPayer.tableName);
   abort;
   end;//fin du try
end;


//si erreur � l'enregistrement de la charge ou du produit, annule toutes les �critures
//(MAJ balance, Suppression ou Modif d'OD, enregistrement de la charges)
procedure TDMChargeAPayer.TaChAPayerPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(DataSet);
TableGereRollBack(DMPieces.TaPiece);
end;


//si erreur � la suppression de la charge ou du produit, annule toutes les �critures
//(MAJ balance, Suppression OD, suppression de la charges)
procedure TDMChargeAPayer.TaChAPayerDeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(DataSet);
TableGereRollBack(DMPieces.TaPiece);
end;


//R�cup�re les param�tres du compte de reprise s�l�ctionn�, et en fonction de ces param�tres
//initialise certains champs comme la Quantit� ou la tva, si champ libell� vide, le remplie par
//d�faut avec le libell� du compte
procedure TDMChargeAPayer.RecupInfoApresVerif(Tout:boolean);
var
RetourEnregistrement:TEnregistrementComplet;
begin
   //R�cup�re tous les param�tres d'un compte
   RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaChAPayerCompte2.AsString);
       if empty(RetourEnregistrement.Un1) then//si pas de param�tre Quantit�
       begin
       if TaChAPayer.Fields[4].ReadOnly=false then
       TaChAPayer.Fields[4].asstring:='';
       TaChAPayer.Fields[4].ReadOnly:=true;
       end
       else
       TaChAPayer.Fields[4].ReadOnly:=false;//si param�tre Quantit�
       ////////////////////////////
       if empty(RetourEnregistrement.TvaCode) then//si pas de param�tre TVA
       begin
       if TaChAPayer.Fields[10].ReadOnly=false then
       TaChAPayer.Fields[10].asstring:='';
       TaChAPayer.Fields[10].ReadOnly:=true;
       end
      else
       TaChAPayer.Fields[10].ReadOnly:=false;//si param�tre TVA
       ///////////////////////
       if tout then
       begin
          if not(empty(RetourEnregistrement.Libelle)) then //Si param�tre libell�
          begin
             if (empty(TaChAPayerLibelle2.AsString)) then//si libell� de la grille vide
             TaChAPayerLibelle2.AsString:=RetourEnregistrement.Libelle
             //remplir par d�faut avec le libell�
             else //si libell� de la  grille pas vide, v�rifie que le libell� ne correspond
             //pas au libell� de l'ancien compte saisie
               if (TaChAPayerLibelle2.AsString=trim(dernierlibelle)) then
               TaChAPayerLibelle2.AsString:=RetourEnregistrement.Libelle;
               DernierLibelle:=RetourEnregistrement.Libelle;
          end;
       end;
Compte2Tmp:=TaChAPayerCompte2.AsString;
 end;

//R�cup�re les param�tres du compte de reprise s�l�ctionn�. Si param�tre TVA trouv�, v�rifie
// la coh�rence du montant tva saisie avec le montant calcul� en fonction des taux r�cup�r�
//si le montant saisi ne rentre pas dans la fourchette calcul�e, envoie d'un message et de la
//fen�tre ''AideMontantTTC''pour aider l'utilisateur � saisir son montant TVA
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
             //R�cup�re tous les param�tres d'un compte
             RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaChAPayerCompte2.AsString);
             if RetourEnregistrement.CodeRetour then
                begin//si le compte a �t� trouv�
                   if not(empty(RetourEnregistrement.TvaCode))then
                   begin //si il y a un code tva
                   //r�cup�re les param�tre du codeTva trouv� dans les param�tre du compte
                   RetourTva:=FTvaRecupMiniMaxTva(RetourEnregistrement.TvaCode);
                   case retourtva.CodeRetour of  //v�rifie que la tva saisie rentre dans la fourchette
                   //des calculs fais � partir des taux r�cup�r�s
                   1:begin //le calcul porte sur 1 seul taux (Taux_Inf)
                       if ((calcultva(retourtva.Taux_Inf,0,TaChAPayerMontantHT.AsCurrency,0,13).TVA<>TaChAPayerTVA.AsCurrency)and(abs(calcultva(retourtva.Taux_Inf,0,TaChAPayerMontantHT.AsCurrency,0,13).TVA-TaChAPayerTVA.AsCurrency)>0.01)) then
                       begin
//                       Messagedlg('Le taux de TVA est incoh�rent !!!',MtWarning,[mbok],0);
                       if application.MessageBox(Pchar('Le taux de TVA est incoh�rent, voulez-vous continuer ?'),'Attention',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON1)=mryes then
                       Recuperer:=false
                       else
                       resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,TaChAPayerMontantHT.AsCurrency,TaChAPayerTVA.AsCurrency],4,True,[TaChAPayerTVA],[4],E.DeviseSigle[1]);
                       end
                       else
                       Recuperer:=false;
                     end;
                   2:begin //le calcul porte sur 1 seul taux (Taux_Supp)
                       if ((calcultva(retourtva.Taux_Supp,0,TaChAPayerMontantHT.AsCurrency,0,13).TVA<>TaChAPayerTVA.AsCurrency)and(abs(calcultva(retourtva.Taux_Supp,0,TaChAPayerMontantHT.AsCurrency,0,13).TVA-TaChAPayerTVA.AsCurrency)>0.01)) then
                       begin
//                       Messagedlg('Le taux de TVA est incoh�rent !!!',MtWarning,[mbok],0);
                       if application.MessageBox(Pchar('Le taux de TVA est incoh�rent, voulez-vous continuer ?'),'Attention',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON1)=mryes then
                       Recuperer:=false
                       else
                       resultat:=AideMontantAffiche([retourtva.Taux_Supp,0,TaChAPayerMontantHT.AsCurrency,TaChAPayerTVA.AsCurrency],4,True,[TaChAPayerTVA],[4],E.DeviseSigle[1]);
//                       resultat:=AideMontantAffiche([retourtva.Taux_Supp,0,TaChAPayerMontantHT.AsCurrency,TaChAPayerTVA.AsFloat]);
                       end
                       else
                       Recuperer:=false;
                     end;
                  12:begin //le calcul porte sur 2 taux (Taux_Inf et taux_Supp)
                       if (calcultva(retourtva.Taux_Inf,0,TaChAPayerMontantHT.AsCurrency,0,13).TVA>DMChargeAPayer.TaChAPayerTVA.AsCurrency+0.01)or
                        (calcultva(retourtva.Taux_Supp,0,TaChAPayerMontantHT.AsCurrency,0,13).TVA<TaChAPayerTVA.AsCurrency-0.01)then
                       begin
                       if application.MessageBox(Pchar('Le taux de TVA est incoh�rent, voulez-vous continuer ?'),'Attention',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON1)=mryes then
                        Recuperer:=false
                       else
                       resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,TaChAPayerMontantHT.AsCurrency,TaChAPayerTVA.AsCurrency,retourtva.Taux_Supp,0,DMChargeAPayer.TaChAPayerMontantHT.AsCurrency,DMChargeAPayer.TaChAPayerTVA.AsCurrency],4,True,[TaChAPayerTVA],[4],E.DeviseSigle[1]);
//                       resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,TaChAPayerMontantHT.AsCurrency,TaChAPayerTVA.AsFloat,retourtva.Taux_Supp,0,DMChargeAPayer.TaChAPayerMontantHT.AsCurrency,DMChargeAPayer.TaChAPayerTVA.AsFloat]);
                       end
                       else
                       Recuperer:=false;
                     end;
                   0:begin //le calcul porte sur 1 seul taux (Taux_Inf)
                       if application.MessageBox(Pchar('Le code de TVA '''''+RetourEnregistrement.TvaCode+''''' n''est li� � aucun taux, Etes-vous s�r de vouloir continuer ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
                         Recuperer:=false
                       else
                         begin
                           resultat.HT:=TaChAPayerMontantHT.AsCurrency;
                           resultat.TVA:=0;
                         end;
                     end;
                   end;//fin du case retourTva

                   /////Si erreur de saisie rencontr�e et nouveaux montants tva r�cup�r�s
                   if (Recuperer) and (resultat.Retour) then
                   begin
                      TaChAPayer.Fields[5].AsCurrency:=resultat.HT;
                      TaChAPayer.Fields[10].AsCurrency:=resultat.TVA;
                       case retourtva.CodeRetour of
                      1:begin
                          if calcultva(retourtva.Taux_Inf,0,TaChAPayerMontantHT.AsCurrency,0,13).TVA>TaChAPayerTVA.AsFloat+0.01 then
                            if Messagedlg('Le taux de TVA est incoh�rent !!! Voulez-vous confirmer votre choix',MtWarning,[mbyes,mbno],0)=mrno then
                            abort;
                        end;
                      2:begin
                          if calcultva(retourtva.Taux_Supp,0,TaChAPayerMontantHT.AsCurrency,0,13).TVA<TaChAPayerTVA.AsFloat-0.01 then
                          if Messagedlg('Le taux de TVA est incoh�rent !!! Voulez-vous confirmer votre choix',MtWarning,[mbyes,mbno],0)=mrno then
                            abort;                     end;
                     12:begin
                          if (calcultva(retourtva.Taux_Inf,0,TaChAPayerMontantHT.AsCurrency,0,13).TVA>DMChargeAPayer.TaChAPayerTVA.AsFloat+0.01)or
                           (calcultva(retourtva.Taux_Supp,0,TaChAPayerMontantHT.AsCurrency,0,13).TVA<TaChAPayerTVA.AsFloat-0.01)then
                          if Messagedlg('Le taux de TVA est incoh�rent !!! Voulez-vous confirmer votre choix',MtWarning,[mbyes,mbno],0)=mrno then
                            abort;
                        end;
                      end;//fin du case retourTva
                   end
                   else
                   if resultat.Retour=false then
                    if Messagedlg('Le taux de TVA est incoh�rent !!! Voulez-vous confirmer votre choix',MtWarning,[mbyes,mbno],0)=mrno then
                      abort;
                   end;
                end;//fin si le compte a �t� trouv�
end;

//ferme la transaction
procedure TDMChargeAPayer.TaChAPayer3AfterPost(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMPieces.TaPiece);
end;

//si erreur, annule toutes les �critures(MAJ Balance, enregistrement date,
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
if assigned(FOnGEstInterfaceEvent) then
 FOnGEstInterfaceEvent(DataSet.Fields[8]);
//  dataset.Fields[8].focuscontrol;
if inttostr(self.Tag) < inttostr(2) then
if VerifSiCompteSaisieDsBO(CompteChargeOuProduit,true,DataSet) then
  begin
    abort;  //Compte d�j� utilis� dans BO
  end;
LaisserPasser:=false;
end;

procedure TDMChargeAPayer.TaChAPayerBeforeEIDOuv_Abort(DataSet: TDataSet);
Begin
case self.tag of
   11:Begin
        if not e.AccesOuverture then
         MessageDlg('Vous ne pouvez plus modifier les Charges � Payer d''ouverture !', mtInformation, [mbOK], 0)
         else MessageDlg('Erreur Interne, vous ne devez pas pouvoir modifier les Charges � Payer d''ouverture !', mtError, [mbOK], 0);
        abort;
      End;

   12:Begin
        if not e.AccesOuverture then
         MessageDlg('Vous ne pouvez plus modifier les Produits � Recevoir d''ouverture !', mtInformation, [mbOK], 0)
         else MessageDlg('Erreur Interne, vous ne devez pas pouvoir modifier les Produits � Recevoir d''ouverture !', mtError, [mbOK], 0);
        abort;
      End;
end;

End;

procedure TDMChargeAPayer.TaChAPayerBeforeEIDClo_Abort(DataSet: TDataSet);
Begin
case self.tag of
   21:Begin
        if not e.AccesCloture then
         MessageDlg('Vous ne pouvez plus modifier les Charges � Payer de cl�ture !', mtInformation, [mbOK], 0)
         else MessageDlg('Erreur Interne, vous ne devez pas pouvoir modifier les Charges � Payer de cl�ture !', mtError, [mbOK], 0);
        abort;
      End;

   22:Begin
        if not e.AccesOuverture then
         MessageDlg('Vous ne pouvez plus modifier les Produits � Recevoir de cl�ture !', mtInformation, [mbOK], 0)
         else MessageDlg('Erreur Interne, vous ne devez pas pouvoir modifier les Produits � Recevoir de cl�ture !', mtError, [mbOK], 0);
        abort;
      End;

end;
End;


function VerifRepriseChargesOuverture_OK(var messageTmp:Tmessages):boolean;
Begin
  result:=false;
if DMChargeAPayer=nil then DMChargeAPayer:=TDMChargeAPayer.Create(application.MainForm);
if DMRech=nil then DMRech:=TDMRech.Create(application.MainForm);
try
   result:=VerifExistChargesAPayerOuvertureAReprendre(messagetmp,false);
     if not result then
        begin
         messageTmp.MessageErreur:='Toutes Les Charges � Payer ou Produits � Recevoir d''ouverture n''ont pas �t� repris.'+#10#13#10#13;
         messageTmp.MessageQuestion:='Voulez-vous les reprendre avant la cl�ture d�finitive ?';
        end
      else
         messageTmp.MessageErreur:='OK';
  except
   showmessage('probl�me lors de la v�rification des reprises de Charges � Payer et Produits � Recevoir d''ouverture');
   abort;
  end;
End;

function VerifExistChargesAPayerOuverture(var messageTmp:Tmessages;Mess:boolean):boolean;
Begin
if DMChargeAPayer=nil then DMChargeAPayer:=TDMChargeAPayer.Create(application.MainForm);
if DMRech=nil then DMRech:=TDMRech.Create(application.MainForm);
  try
     if not DMChargeAPayer.TaRechercheChAPayer.Active then
       DMChargeAPayer.TaRechercheChAPayer.open;
     DMChargeAPayer.TaRechercheChAPayer.Filtered := False;
     DMChargeAPayer.TaRechercheChAPayer.Filter := ('DateSaisie = '''+DateTimeToStr(E.DatExoDebut - 1)+'''');
     DMChargeAPayer.TaRechercheChAPayer.Filtered := True;
     result:= DMChargeAPayer.TaRechercheChAPayer.RecordCount<>0 ;
      if ((not result)and(mess)) then
         messageTmp.MessageErreur:='Aucune Charge � Payer ou Produit � Recevoir d''ouverture n''ont �t� saisis'
      else
         messageTmp.MessageErreur:='OK';
  except
   showmessage('probl�me lors de la v�rification de l''existence des Charges � Payer et Produits � Recevoir d''ouverture');
   abort;
  end;
End;

function VerifExistChargesAPayerCloture(var messageTmp:Tmessages;Mess:boolean):boolean;
Begin
if DMChargeAPayer=nil then DMChargeAPayer:=TDMChargeAPayer.Create(application.MainForm);
if DMRech=nil then DMRech:=TDMRech.Create(application.MainForm);
  try
     if not DMChargeAPayer.TaRechercheChAPayer.Active then
       DMChargeAPayer.TaRechercheChAPayer.open;
     DMChargeAPayer.TaRechercheChAPayer.Filtered := False;
     DMChargeAPayer.TaRechercheChAPayer.Filter := ('DateSaisie = '''+DateTimeToStr(E.DatExofin)+'''');
     DMChargeAPayer.TaRechercheChAPayer.Filtered := True;
     result:= DMChargeAPayer.TaRechercheChAPayer.RecordCount<>0;
      if ((not result)and(mess)) then
         messageTmp.MessageErreur:='Aucune Charge � Payer ou Produit � Recevoir de cl�ture n''ont �t� saisis'
      else
         messageTmp.MessageErreur:='OK';
  except
   showmessage('probl�me lors de la v�rification de l''existence des Charges � Payer et Produits � Recevoir de cl�ture');
   abort;
  end;
End;


function VerifExistChargesAPayerOuvertureAReprendre(var messageTmp:Tmessages;Mess:boolean):boolean;
Begin
if DMChargeAPayer=nil then DMChargeAPayer:=TDMChargeAPayer.Create(application.MainForm);
if DMRech=nil then DMRech:=TDMRech.Create(application.MainForm);
  try
     if not DMChargeAPayer.TaRechercheChAPayer.Active then
       DMChargeAPayer.TaRechercheChAPayer.open;
     DMChargeAPayer.TaRechercheChAPayer.Filtered := False;
     DMChargeAPayer.TaRechercheChAPayer.Filter := ('Date_Piece=null and DateSaisie = '''+DateTimeToStr(E.DatExoDebut - 1)+'''');
     DMChargeAPayer.TaRechercheChAPayer.Filtered := True;
     result:= DMChargeAPayer.TaRechercheChAPayer.RecordCount=0 ;
      if ((not result)and(mess)) then
         messageTmp.MessageErreur:='Il reste des Charges � Payer ou des Produits � Recevoir d''ouverture � reprendre'
      else
         messageTmp.MessageErreur:='OK';
  except
   showmessage('probl�me lors de la v�rification de l''existence des reprises des Charges � Payer et Produits � Recevoir d''ouverture');
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


procedure TDMChargeAPayer.CreationODCloture_avecObjet(TableEnCours:TTable;ODModif:string);
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
       DMImport.VerifCreationPieceEcriture;
       DMImport.Piece_Import.NouvellePiece(false);
       if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
         DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
//       Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece);

       rang:=1;
       //remplissage ligne vide
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H'],true,false,-1);
       if TableEnCours.findfield('Sens').AsString='C' then
//       if copy(TableEnCours.findfield('Compte2').AsString,1,1)='6' then //si l'OD concerne une charge
          begin
          //remplissage de 2 lignes pour l'OD avec peut-�tre de la TVA
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte2').asstring,'','',DetermineQte_Cpt(TableEnCours.findfield('Qte').asfloat,TableEnCours.findfield('MontantHT').AsCurrency,0,TableEnCours.findfield('Compte2').asstring),0,-TableEnCours.findfield('MontantHT').AsCurrency,-TableEnCours.findfield('TVA').AsCurrency,DM_C_CompteTVAChargeAPayer,'',0,'',''],true,false,-1);
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte').asstring,'','',DetermineQte_Cpt(TableEnCours.findfield('Qte').asfloat,0,MontantTTC,TableEnCours.findfield('Compte').asstring),0,MontantTTC,0,'','',0,'',''],true,false,-1);
          end
        else
//        if copy(TableEnCours.findfield('Compte2').AsString,1,1)='7' then //si l'OD concerne un produit
       if TableEnCours.findfield('Sens').AsString='D' then
          Begin
          //remplissage de 2 lignes pour l'OD      DetermineQte_Cpt(TableEnCours.findfield('Qte').asfloat,0,TableEnCours.findfield('MontantHT').AsCurrency,TableEnCours.findfield('Compte2').asstring)
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte2').asstring,'','',DetermineQte_Cpt(TableEnCours.findfield('Qte').asfloat,0,TableEnCours.findfield('MontantHT').AsCurrency,TableEnCours.findfield('Compte2').asstring),0,TableEnCours.findfield('MontantHT').AsCurrency,TableEnCours.findfield('TVA').AsCurrency,DM_C_CompteTVAProduitARecevoir,'',0,'',''],true,false,-1);
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte').asstring,'','',DetermineQte_Cpt(TableEnCours.findfield('Qte').asfloat,MontantTTC,0,TableEnCours.findfield('Compte').asstring),0,-MontantTTC,0,'','',0,'',''],true,false,-1);
          End;

       DMImport.RecupPieceEcriture_SurRecords(false,SourcePiece,DMImport.Ecriture_Import.ListeEcriturePiece,ValPieceAutoGen,'','',0);
       ListeOd:=TStringList.Create;
       DMImport.EnregistrementPiece(false,nil,ListeOd,listeFactice);
     except
       if DMImport.messageTmp then
         showmessage('Probl�me lors de l''enregistrement d''une pi�ce');
       abort;
     end;//fin du try except
   finally
   Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,DMChargeAPayer,false);
//   if DMImport.Ecriture_Import.ListeEcriturePiece<>nil then
//     Begin
//        DMImport.Ecriture_Import.ListeEcriturePiece.Free;
//        DMImport.Ecriture_Import.ListeEcriturePiece:=nil;
//     End;
   end;//fin du try finally
End;




procedure TDMChargeAPayer.CreationODReprise_avecObjet(TableEnCours:TTable;ODModif:string);
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
       DMImport.VerifCreationPieceEcriture;
       DMImport.Piece_Import.NouvellePiece(false);
       if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
       DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
//       Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece);

       rang:=1;
       //remplissage ligne vide
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H'],true,false,-1);
       if TableEnCours.findfield('Sens').AsString='C' then
//       if copy(TableEnCours.findfield('Compte2').AsString,1,1)='6' then //si l'OD concerne une charge
          begin
          //remplissage de 2 lignes pour l'OD avec peut-�tre de la TVA     //  DetermineQte_Cpt(0,0,0,Cpt)
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte2').asstring,'','',DetermineQte_Cpt(TableEnCours.findfield('Qte').asfloat,0,TableEnCours.findfield('MontantHT').AsCurrency,TableEnCours.findfield('Compte2').asstring),0,TableEnCours.findfield('MontantHT').AsCurrency,TableEnCours.findfield('TVA').AsCurrency,DM_C_CompteTVAChargeAPayer,'',0,'',''],true,false,-1);
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte').asstring,'','',DetermineQte_Cpt(TableEnCours.findfield('Qte').asfloat,MontantTTC,0,TableEnCours.findfield('Compte').asstring),0,-MontantTTC,0,'','',0,'',''],true,false,-1);
          end     
        else
       if TableEnCours.findfield('Sens').AsString='D' then
//        if copy(TableEnCours.findfield('Compte2').AsString,1,1)='7' then //si l'OD concerne un produit
          Begin
          //remplissage de 2 lignes pour l'OD
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte2').asstring,'','',DetermineQte_Cpt(TableEnCours.findfield('Qte').asfloat,TableEnCours.findfield('MontantHT').AsCurrency,0,TableEnCours.findfield('Compte2').asstring),0,-TableEnCours.findfield('MontantHT').AsCurrency,-TableEnCours.findfield('TVA').AsCurrency,DM_C_CompteTVAProduitARecevoir,'',0,'',''],true,false,-1);
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte').asstring,'','',DetermineQte_Cpt(TableEnCours.findfield('Qte').asfloat,0,MontantTTC,TableEnCours.findfield('Compte').asstring),0,MontantTTC,0,'','',0,'',''],true,false,-1);
          End;
//       DMImport.ExecutionDuFiltrageAideCompteSuivantContexte(DMChargeAPayer,SourcePiece);

       DMImport.RecupPieceEcriture_SurRecords(false,SourcePiece,DMImport.Ecriture_Import.ListeEcriturePiece,ValPieceAutoGen,'','',0);
       ListeOd:=TStringList.Create;
       DMImport.EnregistrementPiece(false,nil,ListeOd,listeFactice);
     except
       if DMImport.messageTmp then
         showmessage('Probl�me lors de l''enregistrement d''une pi�ce');
       abort;
     end;//fin du try except
   finally
   Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,DMChargeAPayer,false);
//   if DMImport.Ecriture_Import.ListeEcriturePiece<>nil then
//     Begin
//        DMImport.Ecriture_Import.ListeEcriturePiece.Free;
//        DMImport.Ecriture_Import.ListeEcriturePiece:=nil;
//     End;
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
try
Initialise_ExceptLGR(ErreurSaisie);
// On effectue un controle sur le tag du DataModule qui doit �tre en bonne position
// Pour �tre certain que les bons traitements se feront
  case self.Tag of
  11:begin//si ouverture et charges � payer
      try
       if DataSet.State in [dsEdit,dsInsert] then
        begin
          Raise ExceptLGR.Create('Vous devez enregistrer la saisie en cours avant l''importation des Charges � Payer',0,true,mtError,ErreurSaisie);
        end;
        CompteChargeOuProduit:=string(valeurs[1].VAnsiString);
        Libelle_CompteChargeOuProduit:=string(valeurs[2].VAnsiString);
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
  12:begin//si ouverture et produits � recevoir
      Raise ExceptLGR.Create('Erreur sur le tag ('+IntToStr(Tag)+') lors de l''importation des Charges � Payer',0,true,mtError,ErreurSaisie);
     end;
  21,22:begin//si cl�ture
         Raise ExceptLGR.Create('Erreur sur le tag ('+IntToStr(Tag)+') lors de l''importation des Charges � Payer',0,true,mtError,ErreurSaisie);
        end;
  end;
except
  showmessage('Probl�me lors de l''importation des charges � payer');
end;
End;

Procedure TDMChargeAPayer.ImportPrARecevoir(Valeurs:array of const;DataSet:TDataSet);
var
ErreurSaisie:TExceptLGR;
Begin
Initialise_ExceptLGR(ErreurSaisie);
// On effectue un controle sur le tag du DataModule qui doit �tre en bonne position
// Pour �tre certain que les bons traitements se feront
  case self.Tag of
  11:begin//si ouverture et charges � payer
      Raise ExceptLGR.Create('Erreur sur le tag ('+IntToStr(Tag)+') lors de l''importation des Produits � Recevoir',0,true,mtError,ErreurSaisie);
     end;
  12:begin//si ouverture et produits � recevoir
      try
       if DataSet.State in [dsEdit,dsInsert] then
        begin
          Raise ExceptLGR.Create('Vous devez enregistrer la saisie en cours avant l''importation des Charges � Payer',0,true,mtError,ErreurSaisie);
        end;
        CompteChargeOuProduit:=string(valeurs[1].VAnsiString);
        Libelle_CompteChargeOuProduit:=string(valeurs[2].VAnsiString);
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
  21,22:begin//si cl�ture
         Raise ExceptLGR.Create('Erreur sur le tag ('+IntToStr(Tag)+') lors de l''importation des Produits � Recevoir',0,true,mtError,ErreurSaisie);
        end;
  end;
End;


Procedure TDMChargeAPayer.GestionAccesChargesAPayer;
Begin
  case self.tag of
     11,12:Begin
            if E.AccesOuverture then
             begin
              TaChAPayer.BeforeInsert := TaChAPayerBeforeInsert;
              TaChAPayer.BeforeEdit := TaChAPayerBeforeEdit;
              TaChAPayer.BeforeDelete := TaChAPayerBeforeDelete;
             end
            else
             begin
              TaChAPayer.BeforeInsert := TaChAPayerBeforeEIDOuv_Abort;
              TaChAPayer.BeforeEdit := TaChAPayerBeforeEIDOuv_Abort;
              TaChAPayer.BeforeDelete := TaChAPayerBeforeEIDOuv_Abort;
             end;
           End;

     21,22:Begin
            if E.AccesCloture then
             begin
              TaChAPayer.BeforeInsert := TaChAPayerBeforeInsert;
              TaChAPayer.BeforeEdit := TaChAPayerBeforeEdit;
              TaChAPayer.BeforeDelete := TaChAPayerBeforeDelete;
             end
            else
             begin
              TaChAPayer.BeforeInsert := TaChAPayerBeforeEIDClo_Abort;
              TaChAPayer.BeforeEdit := TaChAPayerBeforeEIDClo_Abort;
              TaChAPayer.BeforeDelete := TaChAPayerBeforeEIDClo_Abort;
             end;
           End;
  end;

End;


//******************* TChargesAPayer_Isa.GestionFiltrageAideCompte *************************
//permet de filtrer aideCompte suivant plusieurs cas
{1/ suivant si on travail sur les charges ou les produits
 2/ Si on cherche � r�cup�rer un compte de charges (l'appel se fait de l'EditNumcpt) ou un compte de reprise
 d�pendant du compte de charge (l'appel se fait du 1er champ de la Grille)}
//************************************************************************************

procedure TDMChargeAPayer.GestionFiltrageAideCompte(sender:tobject);
begin
  case self.tag of
     11,21:Begin //charges
              if (sender  is TEdit) then
                  AideCompte.FiltrageAideCompte(9);
              if (sender is TGrDBGrid) or (sender is Tfield) then
                  AideCompte.FiltrageAideCompteSurCompte(9,DMChargeAPayer.CompteChargeOuProduit); // PB 29/12/02
        //          AideCompte.FiltrageAideCompteSurCompte(9,numcpt.Text); PB Le 29/12/02
           End;

     12,22:Begin//produits
              if (sender  is TEdit) then
                  AideCompte.FiltrageAideCompte(10);
              if (sender is TGrDBGrid) or (sender is Tfield) then
                  AideCompte.FiltrageAideCompteSurCompte(10,DMChargeAPayer.CompteChargeOuProduit); // PB 29/12/02
        //          AideCompte.FiltrageAideCompteSurCompte(10,numcpt.Text); PB Le 29/12/02
           End;
  end;//fin du case self.tag
end;

Function AffichChargesAPayerSurPeriode(Quand,Quoi:integer):Boolean;
var
 i:integer;
 Liste:TList;
 Compte,Designation:String;
 ParamAffichage:TParamAffichage;
 List1:TStringList;
 PeriodeAutre_Tmp:TPeriode;
 Requete:TQuery;
begin
  Try
  Requete:=Tquery.Create(application.MainForm);
  List1:=TStringList.Create;
  Initialise_TParamAffichage(ParamAffichage);
  ParamAffichage.Titre:='Liste des Comptes utilis�s dans l''exercice.';
  Requete.DatabaseName:=DM_C_NomAliasExercice;
  Requete.SQL.Clear;
  ParamAffichage.GestionAffichForm.Caption:='Selectionnez un compte';
//  Requete.SQL.Add('Select distinct Compte,Compte2,Libelle2,Qte,MontantHT,TVA');
  Requete.SQL.Add('Select distinct Compte');
  Requete.SQL.Add('from ChargeAPayer where DateSaisie between :DateDeb and :DateFin');
    if DMPieces = nil then DMPieces:=TDMPieces.Create(Application.MainForm);
    case Quand of
     C_Ouverture:begin
                  case quoi of
                    1:Begin
                           Requete.SQL.Add(' and Sens=''C''');
                           ParamAffichage.TitrePetit:='Liste des charges A payer';
                      end;
                    2:Begin
                           Requete.SQL.Add(' and Sens=''D''');
                           ParamAffichage.TitrePetit:='Liste des produits � recevoir';
                      end;
                  end;//fin du case quoi
                 end;
       C_Cloture:begin
                  case quoi of
                    1:Begin
                           Requete.SQL.Add(' and Sens=''C''');
                           ParamAffichage.TitrePetit:='Liste des charges A payer';
                      end;
                    2:Begin
                           Requete.SQL.Add(' and Sens=''D''');
                           ParamAffichage.TitrePetit:='Liste des produits � recevoir';
                      end;
                  end;//fin du case quoi
//                   FiltrageDataSet(DMRech.TaChargeAPayerRech,CreeFiltreET(['DateSaisie'],[DateToStr(E.DatExoFin)]));
//                   ParamAffichage.Titre:='Liste des charges A payer et des produits � recevoir de la cl�ture';
                 end;
    end;//fin du case
  Requete.SQL.Add(' Order by Compte');
  Requete.ParamByName('DateDeb').AsDate:=E.DatExoDebut-1;
  Requete.ParamByName('DateFin').AsDate:=E.DatExoFin;
  Requete.open;
  if Requete.recordcount<>0 then
    begin
    List1:=ChampTableVersListeEx(['Compte'],Requete,';',true);
//    List1:=ChampTableVersListeEx(['Compte','Compte2','Libelle2','Qte','MontantHT','TVA'],DMRech.TaChargeAPayerRech,';',true);
    ParamAffichage.AffichModal := true;
    ParamAffichage.EventButtonValiderClick:=DMChargeAPayer.EventValider;
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
  Requete.Close;
    LibereObjet(TObject(Requete));
    E.PeriodeAutre:=PeriodeAutre_Tmp;
    E.AutrePeriode:=PeriodeAutre_Tmp.Retour;
//    E.AutrePeriode:=False;
    ParamAffichage.EventButtonDetailClick :=nil;
//    DeFiltrageDataSet(DMRech.TaChargeAPayerRech);
    LibereObjet(TObject(List1));
  end;
End;


Function EditionChargesAPayerL(TypeEdition : integer; Quand, Quoi : integer; DataSet:TDataSet;Compte,compte2:String;Site:TEditLien):Boolean;
Var
ListeCompte,ListeCompte2:TStringList;
Begin
ListeCompte:=TStringList.Create;
ListeCompte.Add(Compte);
ListeCompte2:=TStringList.Create;
ListeCompte2.Add(Compte2);
EditionChargesAPayerL(TypeEdition,Quand,Quoi,DataSet,ListeCompte,ListeCompte2,Site);
End;

Function EditionChargesAPayerL(TypeEdition : integer; Quand, Quoi : integer; DataSet:TDataSet;ListeCompte,ListeCompte2:TStringList;Site:TEditLien):Boolean;
var
NomFich,Chemin:String;
NomMenuSiteWeb:TfileStream;
TotQteCompte2,TotMontantHTCompte2,TotTvaCompte2,TotTvaCompte,TotQteCompte,TotMontantHTCompte:currency;
TotGENQte,TotGENMontantHT,TotGENTva:currency;
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
TotTvaCompte2:=0;
TotTvaCompte:=0;
TotQteCompte:=0;
TotMontantHTCompte:=0;
TotGENQte:=0;
TotGENMontantHT:=0;
TotGENTva:=0;
 case Quand of
    C_Ouverture: begin
                     LibelleQuand:='� l''ouverture';
                     case DMChargeAPayer.Tag of
                        11:NomFich:='ChargesAPayerOuv';
                        12:NomFich:='ProduitsARecevoirOuv';
                     end;
                 end;
    C_Cloture : begin
                    LibelleQuand:='� la cl�ture';
                    case DMChargeAPayer.Tag of
                        21:NomFich:='ChargesAPayerClo';
                        22:NomFich:='ProduitsARecevoirClo';
                    end;
                end;
 end;


 if DMChargeAPayer=nil then DMChargeAPayer:=TDMChargeAPayer.Create(Application.MainForm);
 if dataset = nil then
  begin
   // Prevu pour passer le dataset concern�
   // Inutile dans Stocks pour l'instant
  end;
 ListeValeur:=TStringList.Create;
 ObjPrn.FontLigneSeule.Style := [fsBold];

 DMChargeAPayer.QuChargesAPayer_Edition.Filtered:=false;
 DMChargeAPayer.QuChargesAPayer_Edition.OnFilterRecord :=nil;

   if ListeCompte2<>nil then
     DMChargeAPayer.ListeEditCompte2.Assign(ListeCompte2);

 if ListeCompte <> nil then
  begin
   TitreCompte:='Du compte :'+ListeCompte.Strings[0]+' au compte :'+ListeCompte.Strings[ListeCompte.count-1];
   DMChargeAPayer.ListeEditCompte.Assign(ListeCompte);
   DMChargeAPayer.QuChargesAPayer_Edition.OnFilterRecord :=DMChargeAPayer.QuChargeAPayerFilterRecord;
   DMChargeAPayer.QuChargesAPayer_Edition.Filtered:=true;
  end
 else
  begin
    case quoi of
      1: TitreCompte:=' Toutes les charges constat�es d''avance';
      2: TitreCompte:=' Tous les produits constat�s d''avance';
    end;//fin du case quoi
  end;

 //tronc commun au 2 �tats
 DMChargeAPayer.QuChargesAPayer_Edition.Params.Clear;
 DMChargeAPayer.QuChargesAPayer_Edition.SQL.Clear;
 DMChargeAPayer.QuChargesAPayer_Edition.SQL.Add('select * from ChargeAPayer.db ');
 DMChargeAPayer.QuChargesAPayer_Edition.SQL.Add(' where DateSaisie =:DateANouveau');
 case Quoi of
    1:begin
        DMChargeAPayer.QuChargesAPayer_Edition.SQL.Add(' and Sens=''C''');
        ObjPrn.FTitreEdition := 'Etat des charges � payer '+LibelleQuand;
      end;
    2:begin
        DMChargeAPayer.QuChargesAPayer_Edition.SQL.Add(' and Sens=''D''');
        ObjPrn.FTitreEdition := 'Etat des produits � recevoir '+LibelleQuand;
      end;
 end;
 DMChargeAPayer.QuChargesAPayer_Edition.SQL.Add(' order by compte,compte2');
 DMChargeAPayer.QuChargesAPayer_Edition.Params[0].DataType := ftDAte;
 //fin du tronc commun au 2 �tats

 case Quand of
    C_Ouverture:begin
                 DMChargeAPayer.QuChargesAPayer_Edition.Params[0].AsDate := E.DatExoDebut -1;
                 DMChargeAPayer.QuChargesAPayer_Edition.Open;
                 if DMChargeAPayer.QuChargesAPayer_Edition.recordcount<>0 then
                 begin
                 DMChargeAPayer.QuChargesAPayer_Edition.First;
                 ValeurCompte:=DMChargeAPayer.QuChargesAPayer_Edition.FindField('Compte').AsString;
                 ListeValeur.Add('9;COMPTE : '+ValeurCompte);
                 while not DMChargeAPayer.QuChargesAPayer_Edition.Eof do
                   begin
                    TotQteCompte2:=TotQteCompte2+DMChargeAPayer.QuChargesAPayer_Edition.FindField('Qte').AsCurrency;
                    TotMontantHTCompte2:=TotMontantHTCompte2+DMChargeAPayer.QuChargesAPayer_Edition.FindField('MontantHT').AsCurrency;
                    TotTvaCompte2:=TotTvaCompte2+DMChargeAPayer.QuChargesAPayer_Edition.FindField('TVA').AsCurrency;
                    TotTvaCompte:=TotTvaCompte+DMChargeAPayer.QuChargesAPayer_Edition.FindField('TVA').AsCurrency;
                    TotQteCompte:=TotQteCompte+DMChargeAPayer.QuChargesAPayer_Edition.FindField('Qte').AsCurrency;
                    TotMontantHTCompte:=TotMontantHTCompte+DMChargeAPayer.QuChargesAPayer_Edition.FindField('MontantHT').AsCurrency;
                    TotGENQte:=TotGENQte+DMChargeAPayer.QuChargesAPayer_Edition.FindField('Qte').AsCurrency;
                    TotGENMontantHT:=TotGENMontantHT+DMChargeAPayer.QuChargesAPayer_Edition.FindField('MontantHT').AsCurrency;
                    TotGENTva:=TotGENTva+DMChargeAPayer.QuChargesAPayer_Edition.FindField('TVA').AsCurrency;
                    ValeurCompte2:=DMChargeAPayer.QuChargesAPayer_Edition.FindField('Compte2').AsString;
                    ListeValeur.Add('0'+
                                     ';'+
                                     '; '+
                                     GereLibelle(DMChargeAPayer.QuChargesAPayer_Edition.FindField('Compte2').AsString)+
                                     ';'+
                                     GereLibelle(DMChargeAPayer.QuChargesAPayer_Edition.FindField('Libelle2').AsString)+
                                     ';'+
                                     DMChargeAPayer.QuChargesAPayer_Edition.FindField('Qte').AsString+
                                     ';'+
                                     DMChargeAPayer.QuChargesAPayer_Edition.FindField('MontantHT').AsString+
                                     ';'+
                                     DMChargeAPayer.QuChargesAPayer_Edition.FindField('TVA').AsString
                                     );
                    DMChargeAPayer.QuChargesAPayer_Edition.Next;
                    if ((ValeurCompte <> DMChargeAPayer.QuChargesAPayer_Edition.FindField('Compte').AsString)or(ValeurCompte2<>DMChargeAPayer.QuChargesAPayer_Edition.FindField('Compte2').AsString)) then
                     begin
                      if ValeurCompte<>DMChargeAPayer.QuChargesAPayer_Edition.FindField('Compte').AsString then
                        begin
                            ListeValeur.Add('1;;; @Total du compte de reprise  '+GereLibelle(ValeurCompte2)+' : ;'+CurrToStr(TotQteCompte2)+';'+CurrToStr(TotMontantHTCompte2)+';'+CurrToStr(TotTvaCompte2));
                            ListeValeur.Add('1;;; @TOTAL DU COMPTE  '+GereLibelle(ValeurCompte)+' : ;'+CurrToStr(TotQteCompte)+';'+CurrToStr(TotMontantHTCompte)+';'+CurrToStr(TotTvaCompte));
                            ValeurCompte:=DMChargeAPayer.QuChargesAPayer_Edition.FindField('Compte').AsString;
                            TotQteCompte:=0;
                            TotMontantHTCompte:=0;
                            TotTvaCompte:=0;
                            ValeurCompte:=DMChargeAPayer.QuChargesAPayer_Edition.FindField('Compte').AsString;
                            ListeValeur.Add('9;COMPTE : '+GereLibelle(ValeurCompte));
                            ValeurCompte2:=DMChargeAPayer.QuChargesAPayer_Edition.FindField('Compte2').AsString;
                            TotQteCompte2:=0;
                            TotMontantHTCompte2:=0;
                            TotTvaCompte2:=0;
                        end
                      else
                      if ValeurCompte2<>DMChargeAPayer.QuChargesAPayer_Edition.FindField('Compte2').AsString then
                        begin
                            ListeValeur.Add('1;;; @Total du compte de reprise  '+GereLibelle(ValeurCompte2)+' : ;'+CurrToStr(TotQteCompte2)+';'+CurrToStr(TotMontantHTCompte2)+';'+CurrToStr(TotTvaCompte2));
                            ValeurCompte2:=DMChargeAPayer.QuChargesAPayer_Edition.FindField('Compte2').AsString;
                            TotQteCompte2:=0;
                            TotMontantHTCompte2:=0;
                            TotTvaCompte2:=0;
                        end;
                     end;
                   end;
                 ListeValeur.Add('1;;; @Total du compte de reprise  '+GereLibelle(ValeurCompte2)+' : ;'+CurrToStr(TotQteCompte2)+';'+CurrToStr(TotMontantHTCompte2)+';'+CurrToStr(TotTvaCompte2));
                 ListeValeur.Add('1;;; @TOTAL DU COMPTE  '+GereLibelle(ValeurCompte)+' : ;'+CurrToStr(TotQteCompte)+';'+CurrToStr(TotMontantHTCompte)+';'+CurrToStr(TotTvaCompte));
                 ListeValeur.Add('1;;; @TOTAL GENERAL   : ;'+CurrToStr(TotGENQte)+';'+CurrToStr(TotGENMontantHT)+';'+CurrToStr(TotGENTva));
                 DMChargeAPayer.QuChargesAPayer_Edition.Close;
                 ObjPrn.FTitre2Edition :='P�riode du '+DateInfos(E.DatExoDebut).DateStr+' au '+DateInfos(E.DatExoFin).DateStr;
                 ObjPrn.FTitre3Edition := 'Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
                 ListeValeur.Insert(0,' Compte ; Compte reprise ; Libell� ; Qt� ; Montant Total ; TVA ');
                 ListeValeur.Insert(1,'1;1.2;2;0.6;1.2;1.2');
                 ListeValeur.Insert(2,'texte;texte;texte;curr;curr;Curr');
                 end;
                 ObjPrn.AffichageImp(ListeValeur);
                end;

    C_Cloture: begin
                 DMChargeAPayer.QuChargesAPayer_Edition.Params[0].AsDate := E.DatExoFin;
                 DMChargeAPayer.QuChargesAPayer_Edition.Open;
                 if DMChargeAPayer.QuChargesAPayer_Edition.recordcount<>0 then
                 begin
                 DMChargeAPayer.QuChargesAPayer_Edition.First;
                 ValeurCompte:=DMChargeAPayer.QuChargesAPayer_Edition.FindField('Compte').AsString;
                 ListeValeur.Add('9;COMPTE : '+ValeurCompte);
                 while not DMChargeAPayer.QuChargesAPayer_Edition.Eof do
                   begin
                    TotQteCompte2:=TotQteCompte2+DMChargeAPayer.QuChargesAPayer_Edition.FindField('Qte').AsCurrency;
                    TotMontantHTCompte2:=TotMontantHTCompte2+DMChargeAPayer.QuChargesAPayer_Edition.FindField('MontantHT').AsCurrency;
                    TotTvaCompte2:=TotTvaCompte2+DMChargeAPayer.QuChargesAPayer_Edition.FindField('TVA').AsCurrency;
                    TotTvaCompte:=TotTvaCompte+DMChargeAPayer.QuChargesAPayer_Edition.FindField('TVA').AsCurrency;
                    TotQteCompte:=TotQteCompte+DMChargeAPayer.QuChargesAPayer_Edition.FindField('Qte').AsCurrency;
                    TotMontantHTCompte:=TotMontantHTCompte+DMChargeAPayer.QuChargesAPayer_Edition.FindField('MontantHT').AsCurrency;
                    TotGENQte:=TotGENQte+DMChargeAPayer.QuChargesAPayer_Edition.FindField('Qte').AsCurrency;
                    TotGENMontantHT:=TotGENMontantHT+DMChargeAPayer.QuChargesAPayer_Edition.FindField('MontantHT').AsCurrency;
                    TotGENTva:=TotGENTva+DMChargeAPayer.QuChargesAPayer_Edition.FindField('TVA').AsCurrency;
                    ValeurCompte2:=DMChargeAPayer.QuChargesAPayer_Edition.FindField('Compte2').AsString;
                    ListeValeur.Add('0'+
                                     ';'+
                                     '; '+
                                     GereLibelle(DMChargeAPayer.QuChargesAPayer_Edition.FindField('Compte2').AsString)+
                                     ';'+
                                     GereLibelle(DMChargeAPayer.QuChargesAPayer_Edition.FindField('Libelle2').AsString)+
                                     ';'+
                                     DMChargeAPayer.QuChargesAPayer_Edition.FindField('Qte').AsString+
                                     ';'+
                                     DMChargeAPayer.QuChargesAPayer_Edition.FindField('MontantHT').AsString+
                                     ';'+
                                     DMChargeAPayer.QuChargesAPayer_Edition.FindField('TVA').AsString
                                     );
                    DMChargeAPayer.QuChargesAPayer_Edition.Next;
                    if ((ValeurCompte <> DMChargeAPayer.QuChargesAPayer_Edition.FindField('Compte').AsString)or(ValeurCompte2<>DMChargeAPayer.QuChargesAPayer_Edition.FindField('Compte2').AsString)) then
                     begin
                      if ValeurCompte<>DMChargeAPayer.QuChargesAPayer_Edition.FindField('Compte').AsString then
                        begin
                            ListeValeur.Add('1;;; @Total du compte de reprise  '+GereLibelle(ValeurCompte2)+' : ;'+CurrToStr(TotQteCompte2)+';'+CurrToStr(TotMontantHTCompte2)+';'+CurrToStr(TotTvaCompte2));
                            ListeValeur.Add('1;;; @TOTAL DU COMPTE  '+GereLibelle(ValeurCompte)+' : ;'+CurrToStr(TotQteCompte)+';'+CurrToStr(TotMontantHTCompte)+';'+CurrToStr(TotTvaCompte));
                            ValeurCompte:=DMChargeAPayer.QuChargesAPayer_Edition.FindField('Compte').AsString;
                            TotQteCompte:=0;
                            TotMontantHTCompte:=0;
                            TotTvaCompte:=0;
                            ValeurCompte:=DMChargeAPayer.QuChargesAPayer_Edition.FindField('Compte').AsString;
                            ListeValeur.Add('9;COMPTE : '+GereLibelle(ValeurCompte));
                            ValeurCompte2:=DMChargeAPayer.QuChargesAPayer_Edition.FindField('Compte2').AsString;
                            TotQteCompte2:=0;
                            TotMontantHTCompte2:=0;
                            TotTvaCompte2:=0;
                        end
                      else
                      if ValeurCompte2<>DMChargeAPayer.QuChargesAPayer_Edition.FindField('Compte2').AsString then
                        begin
                            ListeValeur.Add('1;;; @Total du compte de reprise  '+GereLibelle(ValeurCompte2)+' : ;'+CurrToStr(TotQteCompte2)+';'+CurrToStr(TotMontantHTCompte2)+';'+CurrToStr(TotTvaCompte2));
                            ValeurCompte2:=DMChargeAPayer.QuChargesAPayer_Edition.FindField('Compte2').AsString;
                            TotQteCompte2:=0;
                            TotMontantHTCompte2:=0;
                            TotTvaCompte2:=0;
                        end;
                     end;
                   end;
                 ListeValeur.Add('1;;; @Total du compte de reprise  '+GereLibelle(ValeurCompte2)+' : ;'+CurrToStr(TotQteCompte2)+';'+CurrToStr(TotMontantHTCompte2)+';'+CurrToStr(TotTvaCompte2));
                 ListeValeur.Add('1;;; @TOTAL DU COMPTE  '+GereLibelle(ValeurCompte)+' : ;'+CurrToStr(TotQteCompte)+';'+CurrToStr(TotMontantHTCompte)+';'+CurrToStr(TotTvaCompte));
                 ListeValeur.Add('1;;; @TOTAL GENERAL   : ;'+CurrToStr(TotGENQte)+';'+CurrToStr(TotGENMontantHT)+';'+CurrToStr(TotGENTva));
                 DMChargeAPayer.QuChargesAPayer_Edition.Close;
                 ObjPrn.FTitre2Edition :='P�riode du '+DateInfos(E.DatExoDebut).DateStr+' au '+DateInfos(E.DatExoFin).DateStr;
                 ObjPrn.FTitre3Edition := 'Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
                 ListeValeur.Insert(0,' Compte ; Compte reprise ; Libell� ; Qt� ; Montant Total ; TVA ');
                 ListeValeur.Insert(1,'1;1.2;2;0.6;1.2;1.2');
                 ListeValeur.Insert(2,'texte;texte;texte;curr;curr;Curr');
                 end;
                 ObjPrn.AffichageImp(ListeValeur);
                end;
 end;
Finally
   DeFiltrageDataSet(DMChargeAPayer.QuChargesAPayer_Edition);
   DMChargeAPayer.QuChargesAPayer_Edition.OnFilterRecord :=nil;
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;
End;

procedure TDMChargeAPayer.QuChargeAPayerFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
accept := ListeEditCompte.IndexOf(DAtaSet.findField('compte').AsString) <> -1;
//if accept then
//  accept := ListeEditCompte2.IndexOf(DAtaSet.findField('compte2').AsString) <> -1;
end;


procedure TDMChargeAPayer.EventValider(Sender: TObject);
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