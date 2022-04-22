unit DMTmntTVA;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,LibDates,Gr_Librairie_Obj,E2_Librairie_Obj,DMParamEnt,DMClotures,LibZoneSaisie,
  E2_Decl_Records;

type
  TTotaux = Record
   SommeDebit:currency;
   SommeCredit:currency;
   CodeTVA:String[2];
  end;
  TDMTtmntTVA = class(TDataModule)
    TaH_TVA: TTable;
    DaH_TVA: TDataSource;
    Query1: TQuery;
    DataSource1: TDataSource;
    Query2: TQuery;
    DataSource2: TDataSource;
    QuAnalyseEcriture: TQuery;
    QuAnalyseEcritureId_Piece: TIntegerField;
    QuAnalyseEcritureTypeLigne: TStringField;
    QuAnalyseEcritureTvaCode: TStringField;
    QuAnalyseEcritureTvaType: TStringField;
    QuAnalyseEcritureCredit: TFloatField;
    QuAnalyseEcritureDebit: TFloatField;
    DataAnalyseEcriture: TDataSource;
    QuAnalyseEcritureCompteTva: TStringField;
    QuAnalyseEcritureCreditTva: TCurrencyField;
    QuAnalyseEcritureDebitTva: TCurrencyField;
    QuAnalyseEcritureTaux_Inf: TFloatField;
    QuAnalyseEcritureTaux_Supp: TFloatField;
    QuAnalyseEcritureTauxTvaDifferent: TBooleanField;
    QuAnalyseEcritureCompte: TStringField;
    QuAnalyseEcritureTvaDate: TDateField;
    QuAnalyseEcritureDebitPCentHT: TFloatField;
    QuAux: TQuery;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    StringField3: TStringField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    StringField5: TStringField;
    CurrencyField1: TCurrencyField;
    CurrencyField2: TCurrencyField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    BooleanField1: TBooleanField;
    QuAnalyseEcritureDebitTotalHt: TCurrencyField;
    QuAnalyseEcritureDebitMontantTva: TCurrencyField;
    QuAnalyseEcritureCreditPCentHT: TFloatField;
    QuAnalyseEcritureCreditTotalHt: TCurrencyField;
    QuAnalyseEcritureCreditMontantTva: TCurrencyField;
    QuerySumEcrPiece: TQuery;
    QuerySumEcrPieceTotalTTCDebit: TFloatField;
    QuerySumEcrPieceTotalTTCCredit: TFloatField;
    QuerySumEcrPieceSolde: TFloatField;
    QuerySumEcrPieceID_Piece: TIntegerField;
    QuAux2: TQuery;
    IntegerField2: TIntegerField;
    StringField2: TStringField;
    StringField6: TStringField;
    FloatField5: TFloatField;
    FloatField6: TFloatField;
    StringField8: TStringField;
    CurrencyField3: TCurrencyField;
    CurrencyField4: TCurrencyField;
    FloatField7: TFloatField;
    FloatField8: TFloatField;
    BooleanField2: TBooleanField;
    QuAux2TotalDebitTTC: TCurrencyField;
    QuAux2TotalCreditTTC: TCurrencyField;
    QuAnalyseEcritureQuAnalyseEcritureTotalDebitTTCParCodeTva: TCurrencyField;
    QuAnalyseEcritureEcritureTotalCreditTTCParCodeTva: TCurrencyField;
    DataSource3: TDataSource;
    QuAnalyseEcritureTotalTTCPieceDebit: TCurrencyField;
    QuAnalyseEcritureTotalTTCCreditPiece: TCurrencyField;
    QuAnalyseEcritureSoldePieceTTCCredit: TCurrencyField;
    QuAnalyseEcritureSoldePieceTTCDebit: TCurrencyField;
    TaDec_Tva: TTable;
    DaDec_Tva: TDataSource;
    QuAnalyseEcritureID: TIntegerField;
    QuAuxPointages: TQuery;
    QuAuxPointagesID_Debit: TIntegerField;
    QuAuxPointagesID_Credit: TIntegerField;
    QuAuxPointagesMontant: TFloatField;
    QuAnalyseEcriturePourPiecePointe: TQuery;
    IntegerField4: TIntegerField;
    StringField4: TStringField;
    StringField7: TStringField;
    StringField9: TStringField;
    StringField10: TStringField;
    FloatField9: TFloatField;
    FloatField10: TFloatField;
    StringField11: TStringField;
    QuAnalyseEcriturePourPiecePointeCreditTva: TCurrencyField;
    QuAnalyseEcriturePourPiecePointeDebitTva: TCurrencyField;
    FloatField11: TFloatField;
    FloatField12: TFloatField;
    QuAnalyseEcriturePourPiecePointeTauxTvaDifferent: TBooleanField;
    DaAnalyseEcriturePourPiecePointeDebit: TDataSource;
    QuAuxDatePiece: TQuery;
    QuAuxPointagesDatePieceCredit: TDateField;
    QuAuxPointagesDatePieceDebit: TDateField;
    QuAuxPointagesMontantPieceDebit: TCurrencyField;
    QuAuxPointagesMontantPieceCredit: TCurrencyField;
    QuAuxPointagesProRataCredit: TFloatField;
    QuAuxPointagesProRataDebit: TFloatField;
    QuAnalyseEcriturePourPiecePointeMontantTvaAdeclarerCredit: TCurrencyField;
    QuAnalyseEcriturePourPiecePointeMontantTvaAdeclarerDebit: TCurrencyField;
    QuAuxPointagesId_Piece_Debit: TIntegerField;
    QuAuxPointagesId_Piece_Credit: TIntegerField;
    QuAnalyseEcriturePourPiecePointeTvaDateCredit: TDateField;
    QuAnalyseEcriturePourPiecePointeTvaDateDebit: TDateField;
    QuEcriture: TQuery;
    QuTotauxJournauxTva: TQuery;
    QuPointages: TQuery;
    QuAuxPointagesProRAtaDebitHTParCodeTva: TFloatField;
    QuAuxPointagesProRAtaCreditHTParCodeTva: TFloatField;
    QuAuxPointagesProRataDebitTotal: TFloatField;
    QuAuxPointagesProRataCreditTotal: TFloatField;
    QuAnalyseEcriturePourPiecePointeId: TIntegerField;
    QuAuxPointagesMontantHTDebitParCodeTVA: TCurrencyField;
    QuAuxPointagesMontantHTCreditParCodeTVA: TCurrencyField;
    QuH_TVARecherche: TQuery;
    QuJournauxTvaPourPiece: TQuery;
    DaJournauxTvaPourPiece: TDataSource;
    QuLigneTvaSurCode: TQuery;
    QuJournauxTvaPourPieceId_Piece: TIntegerField;
    QuJournauxTvaPourPieceTypeLigne: TStringField;
    QuJournauxTvaPourPieceTvaCode: TStringField;
    QuJournauxTvaPourPieceSolde: TCurrencyField;
    QuLigneTvaSurCodeTvaCode: TStringField;
    QuLigneTvaSurCodeCompte: TStringField;
    QuLigneTvaSurCodeSolde: TCurrencyField;
    QuJournauxTvaPourPieceSoldeTvaSurCode: TCurrencyField;
    QuInfoLigne: TQuery;
    QuInfoLigneId_Piece: TIntegerField;
    QuInfoLigneTypeLigne: TStringField;
    QuInfoLigneTvaCode: TStringField;
    QuInfoLigneTvaType: TStringField;
    QuInfoLigneDebitSaisie: TCurrencyField;
    QuInfoLigneCreditSaisie: TCurrencyField;
    DaLigneTvaSurCode: TDataSource;
    DaQuEcriture: TDataSource;
    QuInfoLigneTvaDate: TDateField;
    QuSumPointagesDebitVersCredit: TQuery;
    QuSumPointagesCreditVersDebit: TQuery;
    TaEcritureLigneX: TTable;
    TaEcritureLigneXID: TIntegerField;
    TaEcritureLigneXID_Piece: TIntegerField;
    TaEcritureLigneXCompte: TStringField;
    TaEcritureLigneXDebitSaisie: TCurrencyField;
    TaEcritureLigneXCreditSaisie: TCurrencyField;
    TaEcritureLigneXSoldeContrePartie: TCurrencyField;
    QuSumPointagesDebitVersCreditSUMOFMontant: TCurrencyField;
    QuSumPointagesCreditVersDebitSUMOFMontant: TCurrencyField;
    TaEcritureLigneXID_Ligne: TSmallintField;
    TaPointage: TTable;
    procedure DMTtmntTVACreate(Sender: TObject);
    procedure DMTtmntTVADestroy(Sender: TObject);
    Procedure CalculTVA_ED_SurPeriode(DateDebutPeriodeTVA,DateFinPeriodeTVA:TDate;TypeTvaE,TypeTvaD:string);
    Procedure CalculTVA_E_SurPeriode(DateDebutPeriodeTVA,DateFinPeriodeTVA:TDate);
    Function DateDebutPeriode:TDate;
    Function TotauxParSelection(Filtre,ChampDebit,ChampCredit:string;DataSet:TDataSet):TTotaux;
    procedure QuAnalyseEcritureCalcFields(DataSet: TDataSet);
    procedure QuAux2CalcFields(DataSet: TDataSet);
    procedure QuAuxPointagesCalcFields(DataSet: TDataSet);
    procedure QuAnalyseEcriturePourPiecePointeCalcFields(DataSet: TDataSet);
    procedure TaEcritureLigneXCalcFields(DataSet: TDataSet);
    procedure QuAuxDatePieceBeforeOpen(DataSet: TDataSet);
    procedure QuAnalyseEcriturePourPiecePointeBeforeOpen(
      DataSet: TDataSet);
    procedure QuAuxBeforeOpen(DataSet: TDataSet);
    procedure QuAuxPointagesBeforeOpen(DataSet: TDataSet);


  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;


var
  DMTtmntTVA: TDMTtmntTVA;
JournauxTva:PJournauxTva;
//  JournauxTva:PJournauxTva;
  InfoLigneTva:PInfoLigneTva;
//  ListeJournaux, ListeInfoLigne:TList;

  Function DeclarationTVATypeD(ID_Piece:TStringList):Boolean;
  Function DeclarationTVATypeE(ID_Pointage:TStringList):Boolean;
  function RemplirJournauxTva(IdPiece:Integer;var ListJournalTva:TList):boolean;
  Function RemplirInfoLigneTva(ListJournauxTva:TList;var ListeInfoLigneTva:TList;IdPiece:Integer;DateDebutPeriodeTVA,DateFinPeriodeTVA:TDate):boolean;

implementation

uses DMEcriture,LibSQL,DMTva,DMPiece;

{$R *.DFM}

Function DeclarationTVATypeD(ID_Piece:TStringList):Boolean;
var
i,j,ID:integer;
Aux:string;
TotauxTypeD,TotauxTypeE:currency;
Begin
if DMTtmntTVA = nil then DMTtmntTVA:=TDMTtmntTVA.Create(Application.mainForm);
If DMEcritures = nil then DMEcritures:=TDMEcritures.Create(Application.mainForm);
Result:=ID_Piece.Count>0;
if not DMEcritures.TaEcritureRecup.Active then DMEcritures.TaEcritureRecup.Open;
if not DMEcritures.TaEcritureRecupTotalPiece.Active then DMEcritures.TaEcritureRecupTotalPiece.Open;
DMEcritures.TaEcritureRecup.Refresh;
DMEcritures.TaEcritureRecupTotalPiece.Refresh;
//Traitement Tva type D (Credit et Debit)
for i:=0 to ID_Piece.Count-1 do
    Begin
    Aux:='T';
    DMEcritures.TaEcritureRecup.Filter:=CreeFiltreET(['Id_Piece','TypeLigne'],[ID_Piece.Strings[i],Aux]);
    DMEcritures.TaEcritureRecup.Filtered:=true;
    Aux:='X';
    DMEcritures.TaEcritureRecupTotalPiece.Filter:=CreeFiltreET(['Id_Piece','TypeLigne'],[ID_Piece.Strings[i],Aux]);
    DMEcritures.TaEcritureRecupTotalPiece.Filtered:=true;
    Result:=DMEcritures.TaEcritureRecup.RecordCount > 0;
    if result then
       Begin
        DMEcritures.TaEcritureRecup.Filter:=CreeFiltreET(['Id_Piece'],[ID_Piece.Strings[i]]);
        TotauxTypeD:=0;
        TotauxTypeE:=0;
        DMTtmntTVA.QuAux2.Params[0].AsInteger:=strtoint(ID_Piece.Strings[i]);
        DMTtmntTVA.QuAux2.Open;
        DMTtmntTVA.QuAux.Params[0].AsInteger:=strtoint(ID_Piece.Strings[i]);
        DMTtmntTVA.QuAux.Open;
        DMTtmntTVA.QuerySumEcrPiece.Params[0].AsInteger:=strtoint(ID_Piece.Strings[i]);
        DMTtmntTVA.QuerySumEcrPiece.Open;
        DMTtmntTVA.QuAnalyseEcriture.Params[0].AsInteger:=strtoint(ID_Piece.Strings[i]);
        DMTtmntTVA.QuAnalyseEcriture.Open;
        DMTtmntTVA.TaDec_Tva.Open;
        DMTtmntTVA.QuAnalyseEcriture.First;
        for j:=0 to DMTtmntTVA.QuAnalyseEcriture.RecordCount-1 do
          Begin
            ID:=DMTtmntTVA.TaDec_Tva.RecordCount+1;
            DMTtmntTVA.TaDec_Tva.AppendRecord([ID,
                  DMTtmntTVA.QuAnalyseEcriture.FindField('Id_Piece').AsInteger,
                  DMTtmntTVA.QuAnalyseEcriture.FindField('Id').AsInteger,
                  DMTtmntTVA.QuAnalyseEcriture.FindField('TvaCode').AsString,
                  DMTtmntTVA.QuAnalyseEcriture.FindField('TvaType').AsString,
                  DMTtmntTVA.QuAnalyseEcriture.FindField('TvaDate').AsDateTime,
                  DMTtmntTVA.QuAnalyseEcriture.FindField('DebitMontantTva').AsCurrency,
                  DMTtmntTVA.QuAnalyseEcriture.FindField('CreditMontantTva').AsCurrency]);
            DMTtmntTVA.TaDec_Tva.FlushBuffers;
            DMTtmntTVA.QuAnalyseEcriture.Next;
        end;
        DMTtmntTVA.QuAux2.close;
        DMTtmntTVA.QuAux.close;
        DMTtmntTVA.QuerySumEcrPiece.close;
        DMTtmntTVA.QuAnalyseEcriture.close;
       End;
    End;
//if result= false then exit;


//        DMTtmntTVA.QuerySumEcrPiece.Params[0].AsInteger:=strtoint(ID_Piece.Strings[0]);
//        DMTtmntTVA.QuerySumEcrPiece.Open;
//        DMTtmntTVA.QuAnalyseEcriture.Params[0].AsInteger:=strtoint(ID_Piece.Strings[0]);
//        DMTtmntTVA.QuAnalyseEcriture.Open;

//        DMTtmntTVA.TaDec_Tva.Open;
//        DMTtmntTVA.QuAnalyseEcriture.First;
//       end;

End;


Function DeclarationTVATypeE(ID_Pointage:TStringList):Boolean;
var
i,j,ID:integer;
Aux:string;
begin
if DMTtmntTVA = nil then DMTtmntTVA:=TDMTtmntTVA.Create(Application.mainForm);
If DMEcritures = nil then DMEcritures:=TDMEcritures.Create(Application.mainForm);
    if not DMEcritures.TaEcritureRecup.Active then DMEcritures.TaEcritureRecup.Open;
    if not DMEcritures.TaEcritureQuAuxRecup.Active then DMEcritures.TaEcritureQuAuxRecup.Open;

//    if not DMEcritures.TaEcritureRecupTotalPiece.Active then DMEcritures.TaEcritureRecupTotalPiece.Open;
    DMEcritures.TaEcritureRecup.Refresh;
    DMEcritures.TaEcritureQuAuxRecup.Refresh;
//    if DMEcritures.TaEcritureRecup.RecordCount > 0 then
//       Begin

        //Récupération des ligne concernée par le pointage
        DMTtmntTVA.QuAuxDatePiece.close;
        DMTtmntTVA.QuAuxDatePiece.Params[0].AsInteger:=strtoint(ID_Pointage.Strings[0]);
        DMTtmntTVA.QuAuxDatePiece.Open;

//        DMTtmntTVA.QuAux2.Params[0].AsInteger:=DMTtmntTVA.QuAuxDatePiece.findField('ID_Piece').AsInteger;
//        DMTtmntTVA.QuAux2.Open;

       /////isa rajout le 17-03-02
        DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.OnCalcFields:=nil;
        DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.close;
        DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.Params[0].asinteger:=DMTtmntTVA.QuAuxDatePiece.findField('ID_Piece').AsInteger;
        DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.open;
        DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.OnCalcFields:=DMTtmntTVA.QuAnalyseEcriturePourPiecePointeCalcFields;
        /////fin isa rajout le 17-03-02
        DMEcritures.TaEcritureQuAuxRecup.Filter:=CreeFiltreET(['Id_Piece'],[DMTtmntTVA.QuAuxDatePiece.findField('ID_Piece').asString]);
        // Retourne les sommes Tva par CodeTva
        DMTtmntTVA.QuAux.Params[0].AsInteger:=DMTtmntTVA.QuAuxDatePiece.findField('ID_Piece').AsInteger;
        DMTtmntTVA.QuAux.Open;

        DMTtmntTVA.TaPointage.Filter:=CreeFiltreET(['Id'],[ID_Pointage.Strings[0]]);
        DMEcritures.TaEcritureRecup.Filter:=CreeFiltreET(['Id'],['-1']);
        if DMTtmntTVA.TaPointage.RecordCount > 0 then
        DMEcritures.TaEcritureRecup.Filter:=CreeFiltreET(['Id_Piece'],[DMTtmntTVA.QuAuxDatePiece.findField('ID_Piece').asString]);
//        DMEcritures.TaEcritureRecup.Filter:=CreeFiltreET(['Id'],[DMTtmntTVA.TaPointage.findfield('ID_Debit').asString]);

        // Retourne tous les champ du pointage ID_Pointage
        DMTtmntTVA.QuAuxPointages.Params[0].AsInteger:=strtoint(ID_Pointage.Strings[0]);
        DMTtmntTVA.QuAuxPointages.Open;
        // Recupere la ligne concerne par le pointage
        DMEcritures.TaEcritureRecup.Filtered:=true;
//        DMEcritures.TaEcritureRecup.Filter:=CreeFiltreET(['Id'],['-1']);
//        if DMTtmntTVA.QuAuxPointages.RecordCount > 0 then
//        DMEcritures.TaEcritureRecup.Filter:=CreeFiltreET(['Id'],[DMTtmntTVA.QuAuxPointages.findfield('ID_Debit').asString]);
        if DMEcritures.TaEcritureRecup.RecordCount > 0 then
        Begin
        // Traite la piece dont le solde est au debit
        Aux:='T';
        DMEcritures.TaEcritureRecup.Filter:=CreeFiltreET(['Id_Piece','TypeLigne'],[DMTtmntTVA.QuAuxPointages.findfield('Id_Piece_Debit').AsString,Aux]);
        DMEcritures.TaEcritureRecup.Filtered:=true;
        DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.ParamByName('IDPiece').AsInteger:=DMTtmntTVA.QuAuxPointages.findfield('ID_Piece_Debit').AsInteger;
//        DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.Filter:=CreeFiltreET(['Id'],[DMTtmntTVA.QuAuxPointages.findfield('Id_Debit').AsString]);
        DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.Open;
        DMTtmntTVA.TaDec_Tva.Open;
        DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.First;
        for j:=0 to DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.RecordCount-1 do
          Begin
            ID:=DMTtmntTVA.TaDec_Tva.RecordCount+1;
            if not DMTtmntTVA.TaDec_Tva.Locate('Id_Piece;ID_Ligne',VarArrayOf([DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.FindField('Id_Piece').AsInteger,
                  DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.FindField('Id').AsInteger]),[]) then
            DMTtmntTVA.TaDec_Tva.AppendRecord([ID,
                  DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.FindField('Id_Piece').AsInteger,
                  DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.FindField('Id').AsInteger,
                  DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.FindField('TvaCode').AsString,
                  DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.FindField('TvaType').AsString,
                  DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.FindField('TvaDateCredit').AsDateTime,
                  DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.FindField('MontantTvaAdeclarerDebit').AsCurrency,
                  DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.FindField('MontantTvaAdeclarerCredit').AsCurrency]);
            DMTtmntTVA.TaDec_Tva.FlushBuffers;
            DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.Next;
          end;
        End;

//        DMTtmntTVA.QuAuxDatePiece.close;
//        DMTtmntTVA.QuAuxPointages.close;
        DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.close;

        DMTtmntTVA.TaPointage.Filter:=CreeFiltreET(['Id'],[ID_Pointage.Strings[0]]);
        DMEcritures.TaEcritureRecup.Filter:=CreeFiltreET(['Id'],['-1']);
        if DMTtmntTVA.TaPointage.RecordCount > 0 then
        DMEcritures.TaEcritureRecup.Filter:=CreeFiltreET(['Id_Piece'],[DMTtmntTVA.QuAuxDatePiece.findField('ID_Piece').asString]);
//        DMEcritures.TaEcritureRecup.Filter:=CreeFiltreET(['Id'],[DMTtmntTVA.TaPointage.findfield('ID_Credit').asString]);

//        DMEcritures.TaEcritureRecup.Filter:=CreeFiltreET(['Id'],['-1']);
//        if DMTtmntTVA.QuAuxPointages.RecordCount > 0 then
//        DMEcritures.TaEcritureRecup.Filter:=CreeFiltreET(['Id'],[DMTtmntTVA.QuAuxPointages.findfield('ID_Credit').asString]);
//        DMEcritures.TaEcritureRecup.Filtered:=true;

        if DMEcritures.TaEcritureRecup.RecordCount > 0 then
        Begin
        // Traite la piece dont le solde est au credit
        Aux:='T';
        DMEcritures.TaEcritureRecup.Filter:=CreeFiltreET(['Id_Piece','TypeLigne'],[DMTtmntTVA.QuAuxPointages.findfield('Id_Piece_Credit').AsString,Aux]);
        DMEcritures.TaEcritureRecup.Filtered:=true;
        DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.ParamByName('IDPiece').AsInteger:=DMTtmntTVA.QuAuxPointages.findfield('Id_Piece_Credit').AsInteger;
//        DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.Filter:=CreeFiltreET(['Id'],[DMTtmntTVA.QuAuxPointages.findfield('Id_Credit').AsString]);
        DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.Open;
        DMTtmntTVA.TaDec_Tva.Open;
        DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.First;
        for j:=0 to DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.RecordCount-1 do
          Begin
            ID:=DMTtmntTVA.TaDec_Tva.RecordCount+1;
            if not DMTtmntTVA.TaDec_Tva.Locate('Id_Piece;ID_Ligne',VarArrayOf([DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.FindField('Id_Piece').AsInteger,
                  DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.FindField('Id').AsInteger]),[]) then
            DMTtmntTVA.TaDec_Tva.AppendRecord([ID,
                  DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.FindField('Id_Piece').AsInteger,
                  DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.FindField('Id').AsInteger,
                  DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.FindField('TvaCode').AsString,
                  DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.FindField('TvaType').AsString,
                  DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.FindField('TvaDateDebit').AsDateTime,
                  DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.FindField('MontantTvaAdeclarerDebit').AsCurrency,
                  DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.FindField('MontantTvaAdeclarerCredit').AsCurrency]);
            DMTtmntTVA.TaDec_Tva.FlushBuffers;
            DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.Next;
          end;
        end;
//DMEcritures.TaEcritureRecup.close;
//DMTtmntTVA.TaDec_Tva.close;
//DMTtmntTVA.QuAuxDatePiece.close;
//DMTtmntTVA.QuAuxPointages.close;
//DMTtmntTVA.QuAnalyseEcriturePourPiecePointe.close;
//DMTtmntTVA.QuAux2.Close;
//DMTtmntTVA.QuAux.Close;
end;

function RemplirJournauxTva(IdPiece:Integer;var ListJournalTva:TList):boolean;
var
i:integer;
Begin
if ListJournalTva= nil then ListJournalTva:=TList.Create;
ListJournalTva.Clear;
i:=1;
if DMTtmntTVA = nil then DMTtmntTVA:=TDMTtmntTVA.Create(Application.mainForm);
DMTtmntTVA.QuLigneTvaSurCode.Close;
DMTtmntTVA.QuLigneTvaSurCode.ParamByName('IDPiece').AsInteger:=IdPiece;

DMTtmntTVA.QuJournauxTvaPourPiece.Close;
DMTtmntTVA.QuJournauxTvaPourPiece.ParamByName('IDPiece').AsInteger:=IdPiece;
DMTtmntTVA.QuJournauxTvaPourPiece.Open;
DMTtmntTVA.QuJournauxTvaPourPiece.First;

while not DMTtmntTVA.QuJournauxTvaPourPiece.EOF do
      Begin
      new(JournauxTva);
      JournauxTva^.CodeTva:=DMTtmntTVA.QuJournauxTvaPourPiece.findfield('TvaCode').AsString;
      JournauxTva^.SoldeHT_TypeEtCode:=abs(DMTtmntTVA.QuJournauxTvaPourPiece.findfield('Solde').AsCurrency);
      JournauxTva^.SoldeTVA_TypeEtCode:=abs(DMTtmntTVA.QuJournauxTvaPourPiece.findfield('SoldeTvaSurCode').AsCurrency);
      JournauxTva^.TypeTva:=#0;
      JournauxTva^.SoldeTTC_TypeEtCode:=JournauxTva^.SoldeHT_TypeEtCode+JournauxTva^.SoldeTVA_TypeEtCode;
      ListJournalTva.Capacity:=i;
      ListJournalTva.Add(JournauxTva);
      inc(i);
      DMTtmntTVA.QuJournauxTvaPourPiece.Next;
      End;
//DMTtmntTVA.QuJournauxTvaPourPiece.Close;
End;

Function RemplirInfoLigneTva(ListJournauxTva:TList;var ListeInfoLigneTva:TList;IdPiece:Integer;DateDebutPeriodeTVA,DateFinPeriodeTVA:TDate):Boolean;
var
i:integer;
//JournauxTva:PJournauxTva;
//InfoLigneTva:PInfoLigneTva;
begin
if ListJournauxTva = nil then
   Begin
   showmessage('La liste des journaux tva n''est pas correctement remplie !');
   result:=false;
   abort;
   End;
if ListeInfoLigneTva= nil then ListeInfoLigneTva:=TList.Create;
ListeInfoLigneTva.Clear;
if DMTtmntTVA = nil then DMTtmntTVA:=TDMTtmntTVA.Create(Application.mainForm);
DMTtmntTVA.QuInfoLigne.Close;
DMTtmntTVA.QuInfoLigne.ParamByName('IDPiece').AsInteger:=IdPiece;
DMTtmntTVA.QuInfoLigne.Open;

DMTtmntTVA.QuSumPointagesDebitVersCredit.Close;
DMTtmntTVA.QuSumPointagesDebitVersCredit.ParamByName('DateDeb').AsDate:=DateDebutPeriodeTVA;
DMTtmntTVA.QuSumPointagesDebitVersCredit.ParamByName('DateFin').AsDate:=DateFinPeriodeTVA;


DMTtmntTVA.QuSumPointagesCreditVersDebit.Close;
DMTtmntTVA.QuSumPointagesCreditVersDebit.ParamByName('DateDeb').AsDate:=DateDebutPeriodeTVA;
DMTtmntTVA.QuSumPointagesCreditVersDebit.ParamByName('DateFin').AsDate:=DateFinPeriodeTVA;

for i:=0 to ListJournauxTva.Count -1 do
 Begin
   DMTtmntTVA.QuInfoLigne.First;
   While not DMTtmntTVA.QuInfoLigne.EOF do
   begin
     if DMTtmntTVA.QuInfoLigne.FindField('TvaCode').AsString=PJournauxTva(ListJournauxTva.items[i])^.CodeTva then
      Begin
        new(InfoLigneTva);
        InfoLigneTva^.CodeTva:=DMTtmntTVA.QuInfoLigne.findField('TvaCode').AsString;
        if not empty(DMTtmntTVA.QuInfoLigne.findField('TvaType').AsString) then
            InfoLigneTva^.TypeTva:=DMTtmntTVA.QuInfoLigne.findField('TvaType').AsString[1];
        if not VerifFNumeric(DMTtmntTVA.QuInfoLigne.findField('DebitSaisie')).VideOUZero then
         Begin  // Sens Debit
          InfoLigneTva^.MontantLigne:=DMTtmntTVA.QuInfoLigne.findField('DebitSaisie').AsCurrency;
          InfoLigneTva^.SensCredit:=false;
          if InfoLigneTva^.TypeTva='D' then
           Begin
              // Recuperer si la date de la piece est dans l'intervale de la periode
             InfoLigneTva^.DansPeriode:=DateDsIntervale(DateDebutPeriodeTVA,DMTtmntTVA.QuInfoLigne.findField('TvaDate').AsDateTime,DateFinPeriodeTVA);
             if InfoLigneTva^.DansPeriode
               then InfoLigneTva^.PourcentagePointe:=1
               else InfoLigneTva^.PourcentagePointe:=0;

             InfoLigneTva^.PourcentageTvaLigne:=InfoLigneTva^.MontantLigne / PJournauxTva(ListJournauxTva.items[i])^.SoldeHT_TypeEtCode;
             InfoLigneTva^.MontantTvaLigne:=InfoLigneTva^.PourcentageTvaLigne * PJournauxTva(ListJournauxTva.items[i])^.SoldeTVA_TypeEtCode;

             InfoLigneTva^.PourcentageApplique:=InfoLigneTva^.PourcentagePointe;
             InfoLigneTva^.MontantTvaDeclare:=InfoLigneTva^.MontantTvaLigne * InfoLigneTva^.PourcentageApplique;
           End
           else
           Begin // Si le Type Tva = E
             DMTtmntTVA.QuSumPointagesCreditVersDebit.ParamByName('IDCredit').AsInteger:=DMTtmntTVA.TaEcritureLigneX.findfield('ID').AsInteger;
             DMTtmntTVA.QuSumPointagesCreditVersDebit.Open;
             InfoLigneTva^.PourcentagePointe:=DMTtmntTVA.QuSumPointagesCreditVersDebitSUMOFMontant.AsCurrency / DMTtmntTVA.TaEcritureLigneXSoldeContrePartie.AsCurrency;
             InfoLigneTva^.DansPeriode:=true; // Recuperer si la date de la piece est dans l'intervale de la periode
             InfoLigneTva^.PourcentageTvaLigne:=InfoLigneTva^.MontantLigne / PJournauxTva(ListJournauxTva.items[i])^.SoldeHT_TypeEtCode;
             InfoLigneTva^.MontantTvaLigne:=InfoLigneTva^.PourcentageTvaLigne * PJournauxTva(ListJournauxTva.items[i])^.SoldeTVA_TypeEtCode;

             InfoLigneTva^.PourcentageApplique:=InfoLigneTva^.PourcentagePointe * InfoLigneTva^.PourcentageTvaLigne;
             InfoLigneTva^.MontantTvaDeclare:=PJournauxTva(ListJournauxTva.items[i])^.SoldeTVA_TypeEtCode * InfoLigneTva^.PourcentageApplique;
           End;
         End // Fin sens debit
        else
         Begin  // Sens Credit
          InfoLigneTva^.MontantLigne:=DMTtmntTVA.QuInfoLigne.findField('CreditSaisie').AsCurrency;
          InfoLigneTva^.SensCredit:=true;
          if InfoLigneTva^.TypeTva='D' then
           Begin
              // Recuperer si la date de la piece est dans l'intervale de la periode
             InfoLigneTva^.DansPeriode:=DateDsIntervale(DateDebutPeriodeTVA,DMTtmntTVA.QuInfoLigne.findField('TvaDate').AsDateTime,DateFinPeriodeTVA);
             if InfoLigneTva^.DansPeriode
               then InfoLigneTva^.PourcentagePointe:=1
               else InfoLigneTva^.PourcentagePointe:=0;

             InfoLigneTva^.PourcentageTvaLigne:=InfoLigneTva^.MontantLigne / PJournauxTva(ListJournauxTva.items[i])^.SoldeHT_TypeEtCode;
             InfoLigneTva^.MontantTvaLigne:=InfoLigneTva^.PourcentageTvaLigne * PJournauxTva(ListJournauxTva.items[i])^.SoldeTVA_TypeEtCode;

             InfoLigneTva^.PourcentageApplique:=InfoLigneTva^.PourcentagePointe;
             InfoLigneTva^.MontantTvaDeclare:=InfoLigneTva^.MontantTvaLigne * InfoLigneTva^.PourcentageApplique;
           End
           else
           Begin // Si le Type Tva = E
             DMTtmntTVA.QuSumPointagesDebitVersCredit.ParamByName('IDDebit').AsInteger:=DMTtmntTVA.TaEcritureLigneX.findfield('ID').AsInteger;
             DMTtmntTVA.QuSumPointagesDebitVersCredit.Open;
             InfoLigneTva^.PourcentagePointe:=DMTtmntTVA.QuSumPointagesDebitVersCreditSUMOFMontant.AsCurrency / DMTtmntTVA.TaEcritureLigneXSoldeContrePartie.AsCurrency;
             InfoLigneTva^.DansPeriode:=true; // Recuperer si la date de la piece est dans l'intervale de la periode
             InfoLigneTva^.PourcentageTvaLigne:=InfoLigneTva^.MontantLigne / PJournauxTva(ListJournauxTva.items[i])^.SoldeHT_TypeEtCode;
             InfoLigneTva^.MontantTvaLigne:=InfoLigneTva^.PourcentageTvaLigne * PJournauxTva(ListJournauxTva.items[i])^.SoldeTVA_TypeEtCode;

             InfoLigneTva^.PourcentageApplique:=InfoLigneTva^.PourcentagePointe * InfoLigneTva^.PourcentageTvaLigne;
             InfoLigneTva^.MontantTvaDeclare:=PJournauxTva(ListJournauxTva.items[i])^.SoldeTVA_TypeEtCode * InfoLigneTva^.PourcentageApplique;
           End;
         End;   // Fin Sens Credit
       ListeInfoLigneTva.Add(InfoLigneTva);
      End;
   DMTtmntTVA.QuInfoLigne.Next;
  end;
 End;
End;

procedure TDMTtmntTVA.DMTtmntTVACreate(Sender: TObject);
begin
OuvrirTouteTable('',TControl(self));

//ListeJournaux:=TList.Create;
//ListeInfoLigne:=TList.Create;
end;

procedure TDMTtmntTVA.DMTtmntTVADestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
//ListeJournaux.Free;
//ListeInfoLigne.Free;
end;

Procedure TDMTtmntTVA.CalculTVA_ED_SurPeriode(DateDebutPeriodeTVA,DateFinPeriodeTVA:TDate;TypeTvaE,TypeTvaD:string);
Begin
QuTotauxJournauxTva.Close;
QuTotauxJournauxTva.ParamByName('D').AsString:=TypeTvaD;
QuTotauxJournauxTva.ParamByName('E').AsString:=TypeTvaE;
QuTotauxJournauxTva.ParamByName('DateDeb').AsDate:=DateDebutPeriodeTVA;
QuTotauxJournauxTva.ParamByName('DateFin').AsDate:=DateFinPeriodeTVA;
QuTotauxJournauxTva.open;
//Query1.Close;
//Query1.SQL.Strings[33]:=DateInfos(DateDebutPeriodeTVA).MoisStr+'/'+DateInfos(DateDebutPeriodeTVA).JourStr+'/'+DateInfos(DateDebutPeriodeTVA).AnStr;
//Query1.SQL.Strings[35]:=DateInfos(DateFinPeriodeTVA).MoisStr+'/'+DateInfos(DateFinPeriodeTVA).JourStr+'/'+DateInfos(DateFinPeriodeTVA).AnStr;
//Query1.Open;
End;

Function TDMTtmntTVA.DateDebutPeriode:TDate;
Begin
if TaH_TVA.RecordCount = 0
   then result:=0
   else
   Begin
    TaH_TVA.Last;
    result:=JourSuivant(TaH_TVA.FindField('Fin_Periode').AsDateTime,1).Date_;
   End;
End;

Function TDMTtmntTVA.TotauxParSelection(Filtre,ChampDebit,ChampCredit:string;DataSet:TDataSet):TTotaux;
var
OldFiltre:string;
OldFiltered:boolean;
Begin
Result.SommeDebit:=0;
Result.SommeCredit:=0;
Result.CodeTVA:='';
OldFiltre:=DataSet.Filter;
DataSet.Filter:=Filtre;
OldFiltered:=DataSet.Filtered;
DataSet.Filtered:=not empty(Filtre);
If not DataSet.Active then DataSet.Open;
DataSet.First;
While not DataSet.EOF do
 Begin
 Result.SommeDebit:=DataSet.FindField(ChampDebit).AsCurrency+Result.SommeDebit;
 Result.SommeCredit:=DataSet.FindField(ChampCredit).AsCurrency+Result.SommeCredit;
 DataSet.Next;
 End;
//DataSet.close;

DataSet.Filter:=OldFiltre;
DataSet.Filtered:=OldFiltered;

End;

Procedure TDMTtmntTVA.CalculTVA_E_SurPeriode(DateDebutPeriodeTVA,DateFinPeriodeTVA:TDate);
Begin

//Query2.Close;
//Query2.ParamByName('DateDeb').AsDate:=DateDebutPeriodeTVA;
//Query2.ParamByName('DateFin').AsDate:=DateFinPeriodeTVA;
//Query2.SQL.Strings[42]:=DAteToStr(DateDebutPeriodeTVA);
//Query2.SQL.Strings[44]:=DAteToStr(DateFinPeriodeTVA);
//Query2.SQL.Strings[51]:=DAteToStr(DateDebutPeriodeTVA);
//Query2.SQL.Strings[53]:=DAteToStr(DateFinPeriodeTVA);
//Query2.Open;
End;

procedure TDMTtmntTVA.QuAnalyseEcritureCalcFields(DataSet: TDataSet);
begin
QuAnalyseEcritureTauxTvaDifferent.AsBoolean:=QuAnalyseEcritureTaux_Inf.AsFloat=QuAnalyseEcritureTaux_Supp.AsFloat;
QuAux.Locate('TvaCode',QuAnalyseEcritureTvaCode.AsString,[]);
QuAnalyseEcritureDebitTotalHt.AsCurrency:=QuAux.findfield('Debit').AsCurrency;
if not VerifFNumeric(QuAnalyseEcritureDebitTotalHt).VideOUZero then
begin
  QuAnalyseEcritureDebitPCentHT.AsFloat:=QuAnalyseEcritureDebit.AsFloat / QuAnalyseEcritureDebitTotalHt.AsFloat;
  QuAnalyseEcritureDebitMontantTva.AsCurrency:=QuAnalyseEcritureDebitTva.AsCurrency*QuAnalyseEcritureDebitPCentHT.AsFloat;
end;
QuAnalyseEcritureCreditTotalHt.AsCurrency:=QuAux.findfield('Credit').AsCurrency;
if not VerifFNumeric(QuAnalyseEcritureCreditTotalHt).VideOUZero then
begin
  // Prorata du Credit par compte et par typeTva et TvaDate/ Rapport au credit par CodeTva
  QuAnalyseEcritureCreditPCentHT.AsFloat:=QuAnalyseEcritureCredit.AsFloat / QuAnalyseEcritureCreditTotalHt.AsFloat;
  QuAnalyseEcritureCreditMontantTva.AsCurrency:=QuAnalyseEcritureCreditTva.AsCurrency*QuAnalyseEcritureCreditPCentHT.AsFloat;
end;
QuAnalyseEcritureDebitTotalHt.AsCurrency:=QuAux.findfield('Debit').AsCurrency;
if not VerifFNumeric(QuAnalyseEcritureDebitTotalHt).VideOUZero then
begin
  // Prorata du Debit par compte et par typeTva et TvaDate/ Rapport au Debit par CodeTva
  QuAnalyseEcritureDebitPCentHT.AsFloat:=QuAnalyseEcritureDebit.AsFloat / QuAnalyseEcritureDebitTotalHt.AsFloat;
  QuAnalyseEcritureDebitMontantTva.AsCurrency:=QuAnalyseEcritureDebitTva.AsCurrency*QuAnalyseEcritureDebitPCentHT.AsFloat;
end;
if VerifFNumeric(QuerySumEcrPieceSolde).Pos then
   QuAnalyseEcritureSoldePieceTTCCredit.AsCurrency:=QuerySumEcrPieceSolde.AsCurrency;
if VerifFNumeric(QuerySumEcrPieceSolde).VideOUZero then
   QuAnalyseEcritureSoldePieceTTCDebit.AsCurrency:=0.00;
if VerifFNumeric(QuerySumEcrPieceSolde).Neg then
   QuAnalyseEcritureSoldePieceTTCDebit.AsCurrency:=abs(QuerySumEcrPieceSolde.AsCurrency);
end;

procedure TDMTtmntTVA.QuAux2CalcFields(DataSet: TDataSet);
begin
QuAux2TotalDebitTTC.AsCurrency:=QuAux2.findfield('Debit').AsCurrency+QuAux2.findfield('DebitTva').AsCurrency;
QuAux2TotalCreditTTC.AsCurrency:=QuAux2.findfield('Credit').AsCurrency+QuAux2.findfield('CreditTva').AsCurrency;
end;

procedure TDMTtmntTVA.QuAuxPointagesCalcFields(DataSet: TDataSet);
begin
QuAux.Close;
QuAux.Params[0].AsInteger:=QuAuxPointagesId_Piece_Debit.AsInteger;
QuAux.Open;

QuAux.Locate('TvaCode',QuAnalyseEcriturePourPiecePointe.FindField('TvaCode').AsString,[]);
QuAuxPointagesMontantHTDebitParCodeTVA.AsCurrency:=QuAux.Findfield('Debit').AsCurrency;

if not VerifFNumeric(QuAuxPointagesMontantHTDebitParCodeTVA).VideOUZero then
begin
QuAuxPointagesProRAtaDebitHTParCodeTva.AsFloat:=QuAuxPointagesMontantHTDebitParCodeTVA.AsCurrency / QuAuxPointagesMontantPieceDebit.AsCurrency;
end
else QuAuxPointagesProRAtaDebitHTParCodeTva.AsFloat:=1;

QuAux.Close;
QuAux.Params[0].AsInteger:=QuAuxPointagesId_Piece_Credit.AsInteger;
QuAux.Open;


QuAux.Locate('TvaCode',QuAnalyseEcriturePourPiecePointe.FindField('TvaCode').AsString,[]);
//QuAux.Locate('TvaCode',QuAnalyseEcritureTvaCode.AsString,[]);
QuAuxPointagesMontantHTCreditParCodeTVA.AsCurrency:=QuAux.Findfield('Credit').AsCurrency;

if not VerifFNumeric(QuAuxPointagesMontantHTCreditParCodeTVA).VideOUZero then
begin
QuAuxPointagesProRAtaCreditHTParCodeTva.AsFloat:=QuAuxPointagesMontantHTCreditParCodeTVA.AsCurrency / QuAuxPointagesMontantPieceCredit.AsCurrency;
end else QuAuxPointagesProRAtaCreditHTParCodeTva.AsFloat:=1;
//QuAnalyseEcritureDebitTotalHt.AsCurrency:=QuAux.findfield('Debit').AsCurrency;
//if not VerifFNumeric(QuAnalyseEcritureDebitTotalHt).VideOUZero then
//begin
//  QuAnalyseEcritureDebitPCentHT.AsFloat:=QuAnalyseEcritureDebit.AsFloat / QuAnalyseEcritureDebitTotalHt.AsFloat;
//  QuAnalyseEcritureDebitMontantTva.AsCurrency:=QuAnalyseEcritureDebitTva.AsCurrency*QuAnalyseEcritureDebitPCentHT.AsFloat;
//end;
//QuAnalyseEcritureCreditTotalHt.AsCurrency:=QuAux.findfield('Credit').AsCurrency;
//if not VerifFNumeric(QuAnalyseEcritureCreditTotalHt).VideOUZero then
//begin
//  // Prorata du Credit par compte et par typeTva et TvaDate/ Rapport au credit par CodeTva
//  QuAnalyseEcritureCreditPCentHT.AsFloat:=QuAnalyseEcritureCredit.AsFloat / QuAnalyseEcritureCreditTotalHt.AsFloat;
//  QuAnalyseEcritureCreditMontantTva.AsCurrency:=QuAnalyseEcritureCreditTva.AsCurrency*QuAnalyseEcritureCreditPCentHT.AsFloat;
//end;
//QuAnalyseEcritureDebitTotalHt.AsCurrency:=QuAux.findfield('Debit').AsCurrency;
//if not VerifFNumeric(QuAnalyseEcritureDebitTotalHt).VideOUZero then
//begin
//  // Prorata du Debit par compte et par typeTva et TvaDate/ Rapport au Debit par CodeTva
//  QuAnalyseEcritureDebitPCentHT.AsFloat:=QuAnalyseEcritureDebit.AsFloat / QuAnalyseEcritureDebitTotalHt.AsFloat;
//  QuAnalyseEcritureDebitMontantTva.AsCurrency:=QuAnalyseEcritureDebitTva.AsCurrency*QuAnalyseEcritureDebitPCentHT.AsFloat;
//end;

//QuAux2.Close;
//QuAux2.ParamByName('IDPiece').AsInteger:=DMEcritures.TaEcritureRecup.findfield('ID_Piece').AsInteger;
//QuAux2.Open;
//QuAuxPointagesProRAtaDebitHTParCodeTva.AsFloat:=
QuAuxPointagesProRataCredit.AsFloat:=QuAuxPointagesMontant.AsCurrency / QuAuxPointagesMontantPieceCredit.AsCurrency;
QuAuxPointagesProRataDebit.AsFloat:=QuAuxPointagesMontant.AsCurrency / QuAuxPointagesMontantPieceDebit.AsCurrency;

QuAuxPointagesProRataDebitTotal.AsFloat :=QuAuxPointagesProRataDebit.AsFloat * QuAuxPointagesProRAtaDebitHTParCodeTva.AsFloat;
QuAuxPointagesProRataCreditTotal.AsFloat :=QuAuxPointagesProRataCredit.AsFloat * QuAuxPointagesProRAtaCreditHTParCodeTva.AsFloat;
//QuAuxPointagesPCentReglement.AsCurrency:=QuAuxPointagesMontant.AsCurrency / QuAuxPointagesMontantSoldePiece.AsCurrency;
end;

procedure TDMTtmntTVA.QuAnalyseEcriturePourPiecePointeCalcFields(
  DataSet: TDataSet);
begin
//Si solde piece en cours au debit   // Prendre la date Credit
QuAnalyseEcriturePourPiecePointeMontantTvaAdeclarerCredit.AsCurrency:=QuAnalyseEcriturePourPiecePointeCreditTva.AsCurrency * QuAuxPointagesProRataCreditTotal.AsFloat;
QuAnalyseEcriturePourPiecePointeMontantTvaAdeclarerDebit.AsCurrency:=QuAnalyseEcriturePourPiecePointeDebitTva.AsCurrency * QuAuxPointagesProRataDebitTotal.AsFloat;

//Si solde piece en cours au credit
//QuAnalyseEcriturePourPiecePointeMontantTvaAdeclarerCredit.AsCurrency:=QuAnalyseEcriturePourPiecePointeCreditTva.AsCurrency * QuAuxPointagesProRataCredit.AsFloat;
//QuAnalyseEcriturePourPiecePointeMontantTvaAdeclarerDebit.AsCurrency:=QuAnalyseEcriturePourPiecePointeDebitTva.AsCurrency * QuAuxPointagesProRataCredit.AsFloat;

QuAnalyseEcriturePourPiecePointeTvaDateCredit.AsDateTime:=QuAuxPointagesDatePieceCredit.AsDateTime;
QuAnalyseEcriturePourPiecePointeTvaDateDebit.AsDateTime:=QuAuxPointagesDatePieceDebit.AsDateTime;
end;




procedure TDMTtmntTVA.TaEcritureLigneXCalcFields(DataSet: TDataSet);
begin
TaEcritureLigneXSoldeContrePartie.AsCurrency:=abs(TaEcritureLigneXDebitSaisie.AsCurrency - TaEcritureLigneXCreditSaisie.AsCurrency);
end;

procedure TDMTtmntTVA.QuAuxDatePieceBeforeOpen(DataSet: TDataSet);
begin
//showmessage('QuAuxDatePiece');
end;

procedure TDMTtmntTVA.QuAnalyseEcriturePourPiecePointeBeforeOpen(
  DataSet: TDataSet);
begin
//showmessage('QuAnalyseEcriturePourPiecePointe');
end;

procedure TDMTtmntTVA.QuAuxBeforeOpen(DataSet: TDataSet);
begin
//showmessage('QuAux');
end;

procedure TDMTtmntTVA.QuAuxPointagesBeforeOpen(DataSet: TDataSet);
begin
//showmessage('QuAuxPointages');
end;


end.

