unit DMPointages;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,Gr_Librairie_obj, E2_Librairie_obj,Piece,LibSQl,LibZoneSaisie,
  E2_Decl_Records,LibDates,E2_DetailPointage,Ecriture_Isa,Variants;

type

  TDMPointage = class(TDataModule)
    TaPointage: TTable;
    DataPointage: TDataSource;
    ReqPointage: TQuery;
    QueryMaxIDPointage: TQuery;
    QueryMaxIDPointageMAXOFID: TFloatField;
    TaReste: TTable;
    QueryMaxIDReste: TQuery;
    QueryMaxIDResteMAXOFID: TIntegerField;
    TaResteRecup: TTable;
    DaQueryRecupPointage: TDataSource;
    QueryRecupPointage: TQuery;
    QueryRecupPointageReference: TStringField;
    QueryRecupPointageDate: TDateField;
    QueryRecupPointageID: TIntegerField;
    QueryRecupPointageDebitSaisie: TCurrencyField;
    QueryRecupPointageCreditSaisie: TCurrencyField;
    QueryRecupPointagereste: TCurrencyField;
    QueryRecupPointageSens: TStringField;
    QueryRecupPointageJournal: TIntegerField;
    QuSumPointeDebit: TQuery;
    QueryRecupPointageTotalPointeDebit: TCurrencyField;
    QuSumPointeCredit: TQuery;
    QueryRecupPointageTotalPointeCredit: TCurrencyField;
    QuLigneBanqueTiersEnCours: TQuery;
    TaPointageImputation: TTable;
    QuLigneBanqueTiersEnCoursMontantImputationDebit: TCurrencyField;
    QuLigneBanqueTiersEnCoursID: TIntegerField;
    QuLigneBanqueTiersEnCoursId_Piece: TIntegerField;
    QuLigneBanqueTiersEnCoursTypeLigne: TStringField;
    QuLigneBanqueTiersEnCoursID_Ligne: TSmallintField;
    QuLigneBanqueTiersEnCoursCompte: TStringField;
    QuLigneBanqueTiersEnCoursTiers: TStringField;
    QuLigneBanqueTiersEnCoursDebitSaisie: TCurrencyField;
    QuLigneBanqueTiersEnCoursCreditSaisie: TCurrencyField;
    QuLigneBanqueTiersEnCoursID_Devise: TIntegerField;
    QuLigneBanqueTiersEnCoursMontantImputationCredit: TCurrencyField;
    QuLigneBanqueTiersEnCoursSommeTotalPointageIDDebit: TCurrencyField;
    QuLigneBanqueTiersEnCoursSommeTotalPointageIDCredit: TCurrencyField;
    QuLigneBanqueTiersEnCoursPointages: TCurrencyField;
    QuLigneBanqueTiersEnCoursTotalReglement: TCurrencyField;
    QuLigneBanqueTiersEnCoursResteAPointer: TCurrencyField;
    QuLigneBanqueTiersEnCoursReference: TStringField;
    QuLigneBanqueTiersEnCoursDate: TDateField;
    QuLigneBanqueTiersEnCoursJournal: TIntegerField;
    QuLigneBanqueTiersEnCoursComptePiece: TStringField;
    QuSumPointeDebitID_Debit: TIntegerField;
    QuSumPointeDebitTotalPointeDebit: TCurrencyField;
    QuSumPointeCreditID_Credit: TIntegerField;
    QuSumPointeCreditTotalPointeCredit: TCurrencyField;
    QuSumPointeCreditNbLignePointee: TIntegerField;
    QuSumPointeDebitNbLignePointee: TIntegerField;
    QuLigneBanqueTiersEnCoursLignesPointeeDebit: TIntegerField;
    QuLigneBanqueTiersEnCoursLignesPointeeCredit: TIntegerField;
    QuLigneBanqueTiersEnCoursPointee: TBooleanField;
    QuLigneBanqueTiersEnCoursNbLignePointee: TIntegerField;
    DaLigneBanqueTiersEnCours: TDataSource;
    QuPointagePieceAppelante: TQuery;
    QuPointagePieceAppelanteJournal: TIntegerField;
    QuPointagePieceAppelanteID: TIntegerField;
    QuPointagePieceAppelanteDate: TDateField;
    QuPointagePieceAppelanteReference: TStringField;
    QuPointagePieceAppelanteDebitSaisie: TCurrencyField;
    QuPointagePieceAppelanteCreditSaisie: TCurrencyField;
    QuPointagePieceAppelanteTotalPointe: TCurrencyField;
    QuPointagePieceAppelanteTotalPointeDebit: TCurrencyField;
    QuPointagePieceAppelanteTotalPointeCredit: TCurrencyField;
    QuPointagePieceAppelanteResteAPointer: TCurrencyField;
    QuPointagePieceAppelanteSensReste: TBooleanField;
    QuLigneBanqueTiersEnCoursLibelle: TStringField;
    QuPointagePieceAppelanteLibelle: TStringField;
    QueryRecupPointageLibelle: TStringField;
    QuVerifPointagesDebit: TQuery;
    QuVerifPointagesDebitJournal: TIntegerField;
    QuVerifPointagesDebitID: TIntegerField;
    QuVerifPointagesDebitDate: TDateField;
    QuVerifPointagesDebitReference: TStringField;
    QuVerifPointagesDebitLibelle: TStringField;
    QuVerifPointagesDebitDebitSaisie: TCurrencyField;
    QuVerifPointagesDebitCreditSaisie: TCurrencyField;
    QuVerifPointagesDebitResteAPointer: TCurrencyField;
    TaRestePourVerifPointage: TTable;
    TaRestePourVerifPointageID: TIntegerField;
    TaRestePourVerifPointageID_Ecriture: TIntegerField;
    TaRestePourVerifPointageID_Piece: TIntegerField;
    TaRestePourVerifPointageDate: TDateField;
    TaRestePourVerifPointageReference: TStringField;
    TaRestePourVerifPointageTiers: TStringField;
    TaRestePourVerifPointageLibelle: TStringField;
    TaRestePourVerifPointageDebit: TCurrencyField;
    TaRestePourVerifPointageCredit: TCurrencyField;
    TaRestePourVerifPointageSens: TStringField;
    TaRestePourVerifPointageReste: TCurrencyField;
    TaRestePourVerifPointageLettre: TStringField;
    TaRestePourVerifPointageMontant: TCurrencyField;
    TaRestePourVerifPointageLigne: TIntegerField;
    QuVerifPointagesCredit: TQuery;
    QuVerifPointagesCreditJournal: TIntegerField;
    QuVerifPointagesCreditID: TIntegerField;
    QuVerifPointagesCreditDate: TDateField;
    QuVerifPointagesCreditReference: TStringField;
    QuVerifPointagesCreditLibelle: TStringField;
    QuVerifPointagesCreditDebitSaisie: TCurrencyField;
    QuVerifPointagesCreditCreditSaisie: TCurrencyField;
    QuVerifPointagesCreditResteAPointer: TCurrencyField;
    QuVerifPointagesDebitTiers: TStringField;
    QuVerifPointagesCreditTiers: TStringField;
    QuVerifPointagesDebitcompte: TStringField;
    QuVerifPointagesCreditcompte: TStringField;
    QueryRecupPointageIDPiece: TIntegerField;
    QueryRecupPointageTypeTvaE: TStringField;
    QuLigneBanqueTiersEnCourssensReglement: TBooleanField;
    QueryRecupPointageSensReglement: TBooleanField;
    DaPointageAffich: TDataSource;
    QuPointageAffich: TQuery;
    procedure DMPointageCreate(Sender: TObject);
    procedure DMPointageDestroy(Sender: TObject);
    function FiltragePointageSurEcriture(var Requete:TQuery;IDEcriture:integer;sensCredit:boolean;ChercheSens:boolean;Partiel:boolean;IDContrePartie:integer):TinfosPointageS;
    function FiltragePointageSurEcritureAffich(var Requete:TQuery;IDentifiant:string;TypeIdentifiant:Integer;sensCredit:boolean;ChercheSens:boolean;Partiel:boolean;IDContrePartie:integer):TinfosPointageS;
    procedure RechercheMaxIdPointage;
    procedure RechercheMaxIdReste;
    function CalculResteSurIDPiece(IDPiece:integer;Tiers:string):TReste;
    function CalculResteSurIDEcriture(IDEcriture:integer;Tiers:string):TReste;
    function CalculResteSurTiers(var Tableau:variant;Tiers:string;PasTous:boolean):integer;
    function CreationPointageSurIDEcriture(var TabID:Variant;TiersTmp:string;GererReste:boolean;TabIDSuppr:array of integer):integer;
    function SupprimePointageSurEcriture(RequeteFiltree:Tquery;infosPiece:TStringlist;Indice:integer;var TabIDSuppr:array of integer):integer;
//    function RecupImputationReglementSurIDEcriture(IDEcriture,IDReglement:integer;sensEcriture,SensReglement:boolean):currency;
    function SupprimeResteSurIDEcriture(IDEcriture:integer):boolean;
    function RenvoieInfosPointageSurIDEcriture_AvecParametre(IDReglement:integer;SensReglement:boolean;Compte,tiers:string):integer;
    function RecupPiecePointableSurTiers_Et_Journal_PourReglement(Tiers:string;Journal:integer;Option:integer;IDAppelant:integer;SensAppelant,SensRegl:boolean):Treste;
    procedure RecupPiecePointableSurTiers_Et_Journal_PourPointages(Tiers:string;Journal:string);
    function RecupPiecePointableSurTiers_Et_Journal_PourPieceAchat_Vente(Tiers:string;Option:integer;IDAppelant:integer;SensAppelant,SensRegl:boolean):Treste;
    procedure QueryRecupPointageCalcFields(DataSet: TDataSet);
    procedure QuLigneBanqueTiersEnCoursCalcFields(DataSet: TDataSet);
    procedure QuPointagePieceAppelanteCalcFields(DataSet: TDataSet);
    procedure QuVerifPointagesDebitCalcFields(DataSet: TDataSet);
    procedure QuVerifPointagesCreditCalcFields(DataSet: TDataSet);
    procedure PointagesAutomatique(TaEcritureDebit,TaEcritureCredit:TQuery;DateDeb,DAteFin:TDate);
    procedure TraitementCloture1000(sender:Tobject);
    procedure TraitementCloture2000(sender:Tobject);
    procedure QuPointageAffichBeforeInsert(DataSet: TDataSet);
    procedure GestionDuReste(var InfosCreationReste:TInfosCreationReste;SuppEcriture:boolean);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    MaxIdPointage:integer;
    MaxIdReste:integer;
  end;

var
  DMPointage: TDMPointage;
  procedure CreationReste(Max,ID,IDPiece:integer;Date:Tdate;Ref,Tiers,Libelle,Lettre:string;sens:boolean;Debit,Credit,reste,montant:currency);
//  Function DetailPointageAffich(Identifiant:string;TypeIdentifiant:integer;affich:boolean):boolean;



implementation
uses DMEcriture,DMPiece,ObjReglement, DMBalances;
{$R *.DFM}

//Function DetailPointageAffich(Identifiant:string;TypeIdentifiant:integer;affich:boolean):boolean;
//Begin
//if (DMPointage = nil) then DMPointage:=TDMPointage.Create(Application.MainForm);
//with DMPointage do
//     begin
//       QuPointageAffich.Active:=false;
//       DaPointageAffich.DataSet:=QuPointageAffich;
//       DMPointage.FiltragePointageSurEcritureaffich(QuPointageAffich,Identifiant,TypeIdentifiant,false,true,false,-1);
//
//       if (DetailPointage = nil) then DetailPointage:=TDetailPointage.Create(Application.MainForm);
//       QuPointageAffich.Open;
//
//       DetailPointage.GrDBDetailPointages.DataSource:=nil;
//       DetailPointage.GrDBDetailPointages.Columns.RebuildColumns;
//
//
//       DetailPointage.GrDBDetailPointages.DataSource:=DaPointageAffich;
//
////      TCurrencyField(QueryEcrCompte.FindField('Debit')).DisplayFormat:=E.FormatMonnaie;
////      TCurrencyField(QueryEcrCompte.FindField('Credit')).DisplayFormat:=E.FormatMonnaie;
//
//      DetailPointage.GrDBDetailPointages.Columns.Add.Field:=QuPointageAffich.FindField('Reference');
//      DetailPointage.GrDBDetailPointages.Columns.Add.Field:=QuPointageAffich.FindField('Date');
//      DetailPointage.GrDBDetailPointages.Columns.Add.Field:=QuPointageAffich.FindField('Libelle');
//      DetailPointage.GrDBDetailPointages.Columns.Add.Field:=QuPointageAffich.FindField('DebitSaisie');
//      DetailPointage.GrDBDetailPointages.Columns.Add.Field:=QuPointageAffich.FindField('CreditSaisie');
//      DetailPointage.GrDBDetailPointages.Columns.Add.Field:=QuPointageAffich.FindField('Montant');
//      // Titre des colonnes
//      DetailPointage.GrDBDetailPointages.Columns[0].Title.Caption:='Référence';
//      DetailPointage.GrDBDetailPointages.Columns[1].Title.Caption:='Date';
//      DetailPointage.GrDBDetailPointages.Columns[2].Title.Caption:='Libellé';
//      DetailPointage.GrDBDetailPointages.Columns[3].Title.Caption:='Débit';
//      DetailPointage.GrDBDetailPointages.Columns[4].Title.Caption:='Crédit';
//      DetailPointage.GrDBDetailPointages.Columns[5].Title.Caption:='Imputation';
////      DetailPointage.Caption:='Détail des pointages pour le compte : '+cpt + ' - ' + DMPlan.LibelleDuNumCptPCU(cpt);
//
//       DetailPointage.Caption:='ID = ' + Identifiant;
//       DetailPointage.Show;
//     end;
//End;


procedure TDMPointage.DMPointageCreate(Sender: TObject);
var
   I:Integer;
begin
   try
     For i:=0 to ComponentCount -1
         do if Components[i].ClassNameis('TTable') then (Components[i] as TTable).Open ;
     except
        begin
        MessageDlg('Erreur à l'+#39+'ouverture de la table' + Components[i].Name+' dans le module DMPointage ',mtError,[],0);
        abort;
        end;
     end;
end;

procedure TDMPointage.DMPointageDestroy(Sender: TObject);
var
   I:Integer;
begin
   try
     For i:=0 to ComponentCount -1
        do if Components[i].ClassNameis('TTable') then(Components[i] as TTable).Close ;
   except
        begin
        MessageDlg('Erreur à la fermeture de la table' + Components[i].Name+' dans le module DMPointage ',mtError,[],0);
        abort;
        end;
   end;//fin Try Except
ReqPointage.Close;
end;


function TDMPointage.FiltragePointageSurEcriture(var Requete:TQuery;IDEcriture:integer;sensCredit:boolean;ChercheSens:boolean;Partiel:boolean;IDContrePartie:integer):TinfosPointageS;
var
sens:string;
//TableTemp:TTable;
tab:variant;
begin

  if ChercheSens then
     begin
     if RenvoieInfoSurTableDiverse(inttostr(IDEcriture),DMEcritures.TaEcriture,'ID',['DebitSaisie'],tab)>
     RenvoieInfoSurTableDiverse(inttostr(IDEcriture),DMEcritures.TaEcriture,'ID',['CreditSaisie'],tab)then
     sensCredit:=false
     else
     sensCredit:=true;
     tab:=Unassigned;
     end;
result.NbLignePointee:=0;
result.Pointee:=false;
  case ord(sensCredit) of
   0:sens:='ID_Debit';
   1:sens:='ID_Credit';
  end;//fin du case
Requete.SQL.Clear;
Requete.SQL.Add('select * from Pointage.db where '+sens+'= '''+inttostr(IDEcriture)+'''');
   if ((partiel)and(IDContrepartie<>-1)) then
   begin
     case ord(sensCredit) of
      1:sens:='ID_Debit';
      0:sens:='ID_Credit';
     end;//fin du case
   Requete.SQL.Add(' and '+sens+'= '''+inttostr(IDcontrePartie)+'''');
   end;
Requete.Open;
if Requete.RecordCount<>0 then
   begin
   result.NbLignePointee:=Requete.RecordCount;
   result.Pointee:=true;
   end;
End;

function TDMPointage.FiltragePointageSurEcritureAffich(var Requete:TQuery;IDentifiant:string;TypeIdentifiant:Integer;sensCredit:boolean;ChercheSens:boolean;Partiel:boolean;IDContrePartie:integer):TinfosPointageS;
var
sens,SaisieAu,SensPointe:string;
//TableTemp:TTable;
tab:variant;
ID:string;
begin
TypeIdentifiant:=0;
case TypeIdentifiant of
   0:begin
     if RenvoieInfoSurTableDiverse(IDentifiant,DMEcritures.TaEcriture,'ID',['DebitSaisie'],tab)>
     RenvoieInfoSurTableDiverse(IDentifiant,DMEcritures.TaEcriture,'ID',['CreditSaisie'],tab)then
     sensCredit:=false
     else
     sensCredit:=true;
     tab:=Unassigned;
     end;
   1:begin
     if RenvoieInfoSurTableDiverse(IDentifiant,DMEcritures.TaEcriture,'Compte',['DebitSaisie'],tab)>
     RenvoieInfoSurTableDiverse(IDentifiant,DMEcritures.TaEcriture,'Compte',['CreditSaisie'],tab)then
     sensCredit:=false
     else
     sensCredit:=true;
     tab:=Unassigned;
     end;
end;


result.NbLignePointee:=0;
result.Pointee:=false;
  case ord(sensCredit) of
   0:begin
      sens:='ID_Debit';
      SensPointe:='ID_Credit';
      SaisieAu:='DebitSaisie';
     end;
   1:begin
      sens:='ID_Credit';
      SensPointe:='ID_Debit';
      SaisieAu:='CreditSaisie';
     end;
  end;//fin du case
Requete.SQL.Clear;
Requete.SQL.Add('select P.Reference,P."Date",E.Libelle,E.DebitSaisie,E.CreditSaisie,Po.Montant from Pointage Po ');
//Requete.SQL.Add('select P.Reference,P."Date",E.Libelle,E.'+SaisieAu+',Po.Montant from Pointage Po ');
Requete.SQL.Add('join Ecriture E on (E.Id =  Po.'+SensPointe+') ');
Requete.SQL.Add('join Piece P on (P.id = E.Id_Piece) ');
case TypeIdentifiant of
   0:Requete.SQL.Add('where Po.'+sens+'='''+IDentifiant+'''');
   1:Requete.SQL.Add('where E.Compte='''+IDentifiant+'''');
end;


//Requete.SQL.Add('select * from Pointage.db where '+sens+'= '''+inttostr(IDEcriture)+'''');
//   if ((partiel)and(IDContrepartie<>-1)) then
//   begin
//     case ord(sensCredit) of
//      1:sens:='ID_Debit';
//      0:sens:='ID_Credit';
//     end;//fin du case
//   Requete.SQL.Add(' and '+sens+'= '''+inttostr(IDcontrePartie)+'''');
//   end;
Requete.Open;
if Requete.RecordCount<>0 then
   begin
   result.NbLignePointee:=Requete.RecordCount;
   result.Pointee:=true;
   result.Dataset:=Requete;
   end;
End;

//function TDMPointage.FiltragePointageSurEcriture(Requete:TQuery;IDEcriture:integer;sensCredit:boolean;ChercheSens:boolean;Partiel:boolean;IDContrePartie:integer):TinfosPointage;
//var
//sens:string;
////TableTemp:TTable;
//tab:variant;
//begin
//result.NbLignePointee:=0;
//result.Pointee:=false;
//
//   QuSumPointeCredit.close;
//   QuSumPointeCredit.ParamByName('Tiers').AsString:=Tiers;
//   QuSumPointeCredit.open;
//   QuSumPointeDebit.close;
//   QuSumPointeDebit.ParamByName('Tiers').AsString:=Tiers;
//   QuSumPointeDebit.open;
//
//   QuPointagePieceAppelante.SQL.clear;
//   QuPointagePieceAppelante.SQL.Add('');
//   QuPointagePieceAppelante.SQL.Add('');
//   QuPointagePieceAppelante.SQL.Add('');
//   QuPointagePieceAppelante.SQL.Add('');
//   QuPointagePieceAppelante.SQL.Add('');
//   QuPointagePieceAppelante.SQL.Add('');
//
//   QuPointagePieceAppelante.Close;
//   QuPointagePieceAppelante.ParamByName('Tiers').asstring:=Tiers;
//   QuPointagePieceAppelante.ParamByName('IDTiers').asinteger:=IDEcriture;
//   if Partiel then
//   QuPointagePieceAppelante.ParamByName('IDContre').asinteger:=IDContrePartie;
//   QuPointagePieceAppelante.open;
//
//if QuPointagePieceAppelante.RecordCount<>0 then
//   begin
//   result.NbLignePointee:=QuPointagePieceAppelante.RecordCount;
//   result.Pointee:=true;
//   end;
//End;
//

//function TDMPointage.RecupImputationReglementSurIDEcriture(IDEcriture,IDReglement:integer;sensEcriture,SensReglement:boolean):currency;
//var
////QueryTmp:Tquery;
//sensE,sensR:string;
//Begin
//result:=0;
////QueryTmp:=Tquery.Create(self);
////QueryTmp.DatabaseName:=ReqPointage.DatabaseName;
//
//  case ord(sensEcriture) of
//   0:sensE:='ID_Debit';
//   1:sensE:='ID_Credit';
//  end;//fin du case
//    case ord(SensReglement) of
//   0:sensR:='ID_Debit';
//   1:sensR:='ID_Credit';
//  end;//fin du case
//ReqPointage.SQL.Clear;
//ReqPointage.SQL.Add('select * from Pointage.db where '+sensE+'= '''+inttostr(IDEcriture)+'''and '+sensR+'='''+inttostr(IDReglement)+'''');
//ReqPointage.Open;
//   if ReqPointage.RecordCount<>0 then
//      result:=ReqPointage.FindField('Montant').ascurrency;
//
//ReqPointage.Close;
//End;




function TDMPointage.SupprimePointageSurEcriture(RequeteFiltree:Tquery;infosPiece:TStringlist;Indice:integer;var TabIDSuppr:array of integer):integer;
var
MontantPointage:currency;
Tab:variant;
IDDebit,IDCredit:integer;
CreationReste_Debit,CreationReste_Credit:TInfosCreationReste;
begin
TaPointage.open;
tapointage.Filtered:=false;
result:=0;
   try
      RequeteFiltree.First;
         while not(RequeteFiltree.EOF) do
         Begin
           if TaPointage.Locate('ID',RequeteFiltree.findfield('ID').asinteger,[]) then
              try
                MontantPointage:=TaPointage.findfield('Montant').ascurrency;
                IDDebit:=TaPointage.findfield('ID_Debit').asinteger;
                IDCredit:=TaPointage.findfield('ID_Credit').asinteger;
                //récup infos sur ecriture debit ///////////
                //initiallisation des infos reste pour l'ecriture debit
                initialise_InfosCreationReste(CreationReste_Debit);
                CreationReste_Debit.Pointage.MontantPointage:=MontantPointage;
                if (infospiece.Objects[indice]is Tpiece) then
                  CreationReste_Debit.Tiers:=(infospiece.Objects[indice]as Tpiece).tiers
                else
                if (infospiece.Objects[indice]is TReglementList) then
                  CreationReste_Debit.Tiers:=(infospiece.Objects[indice]as TReglementList).tiers;
                CreationReste_Debit.IDEcriture:=IDDebit;
                RenvoieInfoSurTableDiverse(inttostr(IDDebit),DMEcritures.TaEcriture,'ID',['ID_Piece','DebitSaisie','CreditSaisie','Libelle','Date'],Tab);
                CreationReste_Debit.IDPiece:=tab[0];//id_piece
                CreationReste_Debit.MontantDebit:=tab[1];//DebitSaisie
                CreationReste_Debit.MontantCredit:=tab[2];//créditSaisie
                CreationReste_Debit.Libelle:=tab[3];//Libelle
                CreationReste_Debit.DatePiece:=strtodate(tab[4]);//Dateecriture
                RenvoieInfoSurTableDiverse(inttostr(CreationReste_Debit.IDPiece),DMPieces.TaPiece,'ID',['Reference'],Tab);
                CreationReste_Debit.Reference:=tab[0];//reference
                if CreationReste_Debit.MontantDebit<>0 then
                    CreationReste_Debit.Reste.SensReste:=false
                else
                    CreationReste_Debit.Reste.SensReste:=true;

                //récup infos sur ecriture Crédit ///////////
                //initiallisation des infos reste pour l'ecriture debit
                initialise_InfosCreationReste(CreationReste_Credit);
                CreationReste_Credit.Pointage.MontantPointage:=MontantPointage;
                if (infospiece.Objects[indice]is Tpiece) then
                  CreationReste_Credit.Tiers:=(infospiece.Objects[indice]as Tpiece).tiers
                else
                if (infospiece.Objects[indice]is TReglementList) then
                  CreationReste_Credit.Tiers:=(infospiece.Objects[indice]as TReglementList).tiers;
                CreationReste_Credit.IDEcriture:=IDCredit;
                RenvoieInfoSurTableDiverse(inttostr(IDCredit),DMEcritures.TaEcriture,'ID',['ID_Piece','DebitSaisie','CreditSaisie','Libelle','Date'],Tab);
                CreationReste_Credit.IDPiece:=tab[0];//id_piece
                CreationReste_Credit.MontantDebit:=tab[1];//DebitSaisie
                CreationReste_Credit.MontantCredit:=tab[2];//créditSaisie
                CreationReste_Credit.Libelle:=tab[3];//Libelle
                CreationReste_Credit.DatePiece:=strtodate(tab[4]);//Dateecriture
                RenvoieInfoSurTableDiverse(inttostr(CreationReste_Credit.IDPiece),DMPieces.TaPiece,'ID',['Reference'],Tab);
                CreationReste_Credit.Reference:=tab[0];//reference
                if CreationReste_Credit.MontantDebit<>0 then
                    CreationReste_Credit.Reste.SensReste:=false
                else
                    CreationReste_Credit.Reste.SensReste:=true;

                TaPointage.Delete;
                TaPointage.FlushBuffers;
              ///////////////////////
              GestionDuReste(CreationReste_Debit,true);//pour l'ecriture Debit
              GestionDuReste(CreationReste_Credit,true);//pour l'ecriture Crédit
              ///////////////////////
                Tab:=Unassigned;
              except
              abort;
              end;//fin du try
         RequeteFiltree.Next;
         End;
   except
   showmessage('Problème à la suppression des pointages de la pièce en cours !!');
   abort;
   end;//fin du try except
TaPointage.close;
End;



procedure TDMPointage.RechercheMaxIdPointage;
begin
     QueryMaxIDPointage.close ;
     QueryMaxIDPointage.open ;
     MaxIdPointage:= QueryMaxIDPointageMAXOFID.asinteger + 1;
     QueryMaxIDPointage.close ;
end;


procedure TDMPointage.RechercheMaxIdReste;
begin
     QueryMaxIDReste.close ;
     QueryMaxIDReste.open ;
     MaxIdReste:= QueryMaxIDResteMAXOFID.asinteger + 1;
     QueryMaxIDReste.close ;
end;


function TDMPointage.CreationPointageSurIDEcriture(var TabID:Variant;TiersTmp:string;GererReste:boolean;TabIDSuppr:array of integer):integer;
var
i,j:integer;
IDDebit,IDCredit:integer;
TvaDate:TdateTime;
tab:variant;
InfosCreationReste:TInfosCreationReste;
montantPointage:currency;
begin
montantPointage:=0;
result:=-1;
   try
      try
         if not TaPointage.active then
           TaPointage.open;
         if not tareste.active then
           tareste.open;
         for i:=0 to VarArrayHighBound(tabID,1) do
           begin
             if TabIDSuppr[0]<>-1 then
               MaxIdPointage:=TabIDSuppr[0]
             else
               RechercheMaxIdPointage;
             IDDebit:=TabID[i,0];
             IDCredit:=TabID[i,1];
             montantPointage:=TabID[i,3];
             TaPointage.Filtered:=false;
             TaPointage.filter:='';
             TaPointage.filter:=('ID_Debit= '''+inttostr(IDDebit)+'''and ID_Credit= ''' +inttostr(IDCredit)+'''');
             TaPointage.Filtered:=true;
             if TaPointage.RecordCount<>0 then
                Begin
                 TaPointage.Edit;
                 TaPointage.FindField('Montant').AsCurrency:=TaPointage.FindField('Montant').AsCurrency+montantPointage ;
                 TaPointage.Post;
                 TaPointage.FlushBuffers;
                 TaPointage.Filtered:=false;
                 TaPointage.filter:='';
                 TaPointage.Filtered:=true;
                End
             else
                TaPointage.AppendRecord([MaxIdPointage,TabID[i,0],TabID[i,1],TabID[i,2],
                montantPointage,TabID[i,4],null,'',now]);
             TaPointage.FlushBuffers;
             for j:=0 to 1 do
               begin
                 initialise_InfosCreationReste(InfosCreationReste);
                 InfosCreationReste.Pointage.MontantPointage:=montantPointage;
                 InfosCreationReste.Tiers:=Tierstmp;
                 InfosCreationReste.IDEcriture:=TabID[i,j];
                 //rechercher la pièce concernant l'écriture en cours pour récupérer la référence
                 //l'IDPiece et le libelle de la pièce
                 InfosCreationReste.IDPiece:=strtoint(RenvoieInfoSurTableDiverse(inttostr(InfosCreationReste.IDEcriture),DMEcritures.TaEcriture,'ID',['ID_Piece'],tab));
                 //récupérer la référence de la pièce
                 if InfosCreationReste.IDPiece<>0 then
                   begin
                     RenvoieInfoSurTableDiverse(inttostr(InfosCreationReste.IDPiece),DMpieces.TaPiece,'ID',['Reference','Libelle','Date'],tab);
                     InfosCreationReste.Reference:=tab[0];
                     InfosCreationReste.Libelle:=tab[1];
                     InfosCreationReste.DatePiece:=strtodate(tab[2]);
                     InfosCreationReste.Tiers:=InfosCreationReste.Tiers;
                     InfosCreationReste.IDEcriture:=InfosCreationReste.IDEcriture;
                     RenvoieInfoSurTableDiverse(inttostr(InfosCreationReste.IDEcriture),DMEcritures.TaEcriture,'ID',['DebitSaisie','CreditSaisie'],tab);
                     InfosCreationReste.MontantDebit:=strtocurr(tab[0]);
                     InfosCreationReste.MontantCredit:=strtocurr(tab[1]);
                   end
                 else
                    abort;
                 if InfosCreationReste.MontantDebit<>0 then
                   begin
                     InfosCreationReste.Reste.Reste:=InfosCreationReste.MontantDebit-InfosCreationReste.Pointage.MontantPointage;
                     InfosCreationReste.Reste.SensReste:=false;
                   end
                 else
                   begin
                     InfosCreationReste.Reste.Reste:=InfosCreationReste.MontantCredit-InfosCreationReste.Pointage.MontantPointage;;
                     InfosCreationReste.Reste.SensReste:=true;
                   end;

                 GestionDuReste(InfosCreationReste,false);
               end;//fin for j
             result:=MaxIdPointage;
           end;
      except
      showmessage('Problème à la création des pointages après enregistrement d''une nouvelle piece !!');
      if TaPointage.Database.InTransaction then
        TaPointage.Database.Rollback;
      result:=-1;
      abort;
      end;//fin du try
   finally
//   TaPointage.close;
   tareste.close;
   end;//fin du try finally
End;


function TDMPointage.CalculResteSurIDEcriture(IDEcriture:integer;Tiers:string):TReste;
var
ReqRest:tquery;
Begin
result.Reste:=0;
result.SensReste:=false;
  try
   QuSumPointeCredit.close;
   QuSumPointeDebit.close;
   QuPointagePieceAppelante.Close;
   if copy(tiers,1,1)<>'+'then
     Begin
      QuSumPointeCredit.SQL.Strings[4]:='E.compte=:tiers';
      QuSumPointeDebit.SQL.Strings[4]:='E.compte=:tiers';
      QuPointagePieceAppelante.SQL.Strings[7]:='E.compte=:tiers';
     End
   else
     Begin
      QuSumPointeCredit.SQL.Strings[4]:='E.tiers=:tiers';
      QuSumPointeDebit.SQL.Strings[4]:='E.tiers=:tiers';
      QuPointagePieceAppelante.SQL.Strings[7]:='E.tiers=:tiers';
     End;
   QuSumPointeCredit.ParamByName('Tiers').AsString:=Tiers;
   QuSumPointeCredit.open;
   QuSumPointeDebit.ParamByName('Tiers').AsString:=Tiers;
   QuSumPointeDebit.open;   
   QuPointagePieceAppelante.ParamByName('Tiers').asstring:=Tiers;
   QuPointagePieceAppelante.ParamByName('IDTiers').asinteger:=IDEcriture;
   QuPointagePieceAppelante.open;

     if QuPointagePieceAppelante.RecordCount<>0 then
       begin
       result.Reste:=QuPointagePieceAppelanteResteAPointer.AsCurrency;
       result.SensReste:=QuPointagePieceAppelanteSensReste.AsBoolean;
       Result.ResteInitial:=0;
       end;
  except
   showmessage('Problème au calcul du reste des Dettes et Créances');
   abort;
  end;
End;


function TDMPointage.CalculResteSurIDPiece(IDPiece:integer;Tiers:string):TReste;
var
ReqRest:tquery;
Begin
result.Reste:=0;
result.SensReste:=false;
ReqRest:=tquery.Create(self);
ReqRest.DatabaseName:=TaPointage.DatabaseName;
ReqRest.SQL.Clear;
ReqRest.SQL.Add('select Piece.ID,((ecriture.CreditSaisie)-sum(pointage.montant))as reste_Credit,');
ReqRest.SQL.Add('((ecriture.DebitSaisie)-sum(pointage.montant))as reste_Debit');
ReqRest.SQL.Add(' from Piece,ecriture,pointage where piece.ID=ecriture.ID_Piece');
ReqRest.SQL.Add(' and ((ecriture.ID=pointage.ID_Credit)or(ecriture.ID=pointage.ID_Debit))');
ReqRest.SQL.Add(' and piece.ID='+inttostr(IDPiece)+' and ecriture.Tiers='''+Tiers+'''group by Piece.ID');
ReqRest.ExecSQL;
   try
     if ReqRest.RecordCount<>0 then
       begin
          if ((ReqRest.FindField('Reste_Credit').ascurrency>0)and(not empty(ReqRest.FindField('Reste_Credit').asstring))) then
          result.Reste:=ReqRest.FindField('Reste_Credit').ascurrency
          else
            if ((ReqRest.FindField('reste_Debit').ascurrency>0)and (not empty(ReqRest.FindField('reste_Debit').asstring))) then
            result.Reste:=ReqRest.FindField('reste_Debit').ascurrency;
       Result.ResteInitial:=0;     
       end;
   except
   showmessage('Problème au calcul du reste des Dettes et Créances');
   abort;
   end;
ReqRest.Close;
ReqRest.Free;
ReqRest:=nil;
End;


function TDMPointage.CalculResteSurTiers(var Tableau:variant;Tiers:string;PasTous:boolean):integer;
type
TTab=array[0..1,0..1]of integer;
TPtrTab=^TTab;
var
ReqRest:tquery;
i:integer;
PointeurTab:TPtrTab;
Begin
result:=0;
ReqRest:=tquery.Create(self);
ReqRest.DatabaseName:=TaPointage.DatabaseName;
ReqRest.SQL.Clear;
ReqRest.SQL.Add('select Piece.ID,((ecriture.CreditSaisie)-sum(pointage.montant))as reste_Credit,');
ReqRest.SQL.Add('((ecriture.DebitSaisie)-sum(pointage.montant))as reste_Debit');
ReqRest.SQL.Add(' from Piece,ecriture,pointage where piece.ID=ecriture.ID_Piece');
ReqRest.SQL.Add(' and ((ecriture.ID=pointage.ID_Credit)or(ecriture.ID=pointage.ID_Debit))');
ReqRest.SQL.Add(' and ecriture.Tiers='''+Tiers+'''group by Piece.ID');
if PasTous then
ReqRest.SQL.Add('having ((((ecriture.CreditSaisie)-sum(pointage.montant))<>0)or(((ecriture.DebitSaisie)-sum(pointage.montant))<>0))');
ReqRest.Open;
   try
   result:=ReqRest.RecordCount;
     if result<>0 then
       begin
       VarArrayRedim(tableau,result);
       ReqRest.First;
       i:=0;
       PointeurTab:=VarArrayLock(tableau);//verrouillage du tableau avant ecriture
          try
          while not(ReqRest.EOF) do
             Begin
             if ((not empty(ReqRest.FindField('Reste_Credit').asstring))and (ReqRest.FindField('Reste_Credit').ascurrency>0)) then
                begin
                tableau[0,i]:=ReqRest.FindField('Reste_Credit').ascurrency;
                tableau[2,i]:=ReqRest.FindField('ID').asinteger;
                end
             else
               if ((not empty(ReqRest.FindField('reste_Debit').asstring))and (ReqRest.FindField('reste_Debit').ascurrency>0)) then
               begin
                tableau[0,i]:=ReqRest.FindField('reste_Debit').ascurrency;
                tableau[1,i]:=ReqRest.FindField('ID').asinteger;
                end;
             inc(i);
             ReqRest.Next;
             End;
          finally
          VarArrayUnLock(tableau);//Déverrouillage du tableau après ecriture
          end;//fin du try finally
       end;
   except
   showmessage('Problème au calcul du reste des Dettes et Créances');
   abort;
   end;
ReqRest.Close;
ReqRest.Free;
ReqRest:=nil;
End;


function TDMPointage.SupprimeResteSurIDEcriture(IDEcriture:integer):boolean;
Begin
  try
  if not TaReste.active then
  TaReste.open;
      try
        if TaReste.Locate('ID_Ecriture',IDEcriture,[]) then
        begin
          tareste.delete;
          tareste.FlushBuffers;
        end
      except
      result:=false;
      abort;
      end;//fin du try except
  finally
  TaReste.close;
  end;
End;


procedure CreationReste(Max,ID,IDPiece:integer;Date:Tdate;Ref,Tiers,Libelle,Lettre:string;sens:boolean;Debit,Credit,reste,montant:currency);
var
sensTmp:string;
Begin
    try
    if sens then
      sensTmp:='C'
    else
      sensTmp:='D';
    DMPointage.TaReste.AppendRecord([Max,ID,IDPiece,Date,Ref,Tiers,Libelle,Debit,Credit,sensTmp,reste,Lettre]);
    DMPointage.TaReste.FlushBuffers;
    except
    showmessage('Problème lors de la création d''une Dette et Créance !!!');
    abort;
    end;//fin du try except
End;


function TDMPointage.RenvoieInfosPointageSurIDEcriture_AvecParametre(IDReglement:integer;SensReglement:boolean;Compte,tiers:string):integer;
var
sensE,sensR:string;
Begin
result:=0;
  case ord(SensReglement) of
   0:Begin
       sensR:='ID_Debit';
       sensE:='ID_Credit';
     End;
   1:Begin
       sensR:='ID_Credit';
       sensE:='ID_Debit';
     End;
  end;//fin du case
ReqPointage.SQL.Clear;
ReqPointage.SQL.Add('select ecriture.ID from ecriture,pointage where ecriture.ID = pointage.ID_Credit');
ReqPointage.SQL.Add('and pointage.ID_Debit ='''+inttostr(IDReglement)+'''');
ReqPointage.SQL.Add('and pointage.ID_Credit in (select distinct Ecriture.ID from Ecriture');
if empty (tiers)then
ReqPointage.SQL.Add('Where ecriture.tiers is null and ecriture.compte ='''+Compte+'''')
else
ReqPointage.SQL.Add('Where ecriture.tiers ='''+tiers+''' and ecriture.compte ='''+Compte+'''');
ReqPointage.SQL.Add('and ecriture.ID_Piece in (select ecriture.ID_Piece from ecriture');
ReqPointage.SQL.Add('where ecriture.TvaType =''E''))');
ReqPointage.Open;
result:=ReqPointage.recordcount;

ReqPointage.Close;

End;


//****Récupère les lignes d'un tier qui soient encore pointables ou non
function TDMPointage.RecupPiecePointableSurTiers_Et_Journal_PourReglement(Tiers:string;Journal:integer;Option:integer;IDAppelant:integer;SensAppelant,SensRegl:boolean):Treste;
var
Esttiers:boolean;
ChampID:string;
Begin
result.Reste:=0;
result.ResteInitial:=0;
result.SensReste:=false;
   try
   if IDAppelant<>-1 then
     begin
      if SensRegl then
      ChampID:='ID_Credit'
      else
      ChampID:='ID_Debit';
      TaPointageImputation.Filtered:=false;
      TaPointageImputation.Filter:='';
      TaPointageImputation.Filter:=(ChampID+' ='''+inttostr(IDAppelant)+'''');
      TaPointageImputation.Filtered:=true;
     end
   else
     begin
      TaPointageImputation.Filtered:=false;
      TaPointageImputation.Filter:='';
      TaPointageImputation.Filtered:=true;
     end;
   QuSumPointeCredit.close;
   QuSumPointeDebit.close;
   EstTiers:=copy(tiers,1,1)='+';
   if not EstTiers then
     Begin
      QuSumPointeCredit.SQL.Strings[4]:='E.compte=:tiers';
      QuSumPointeDebit.SQL.Strings[4]:='E.compte=:tiers';
     End
   else
     Begin
      QuSumPointeCredit.SQL.Strings[4]:='E.Tiers=:tiers';
      QuSumPointeDebit.SQL.Strings[4]:='E.Tiers=:tiers';
     End;
   QuSumPointeCredit.ParamByName('Tiers').AsString:=Tiers;
   QuSumPointeCredit.open;
   QuSumPointeDebit.ParamByName('Tiers').AsString:=Tiers;
   QuSumPointeDebit.open;

       
        if not option in [1,2,3] then
          abort;
        QueryRecupPointage.active:=false;
        QueryRecupPointage.SQL.Clear;
           QueryRecupPointage.SQL.Add('Select P.Journal,E.Id,P."Date",P.Reference,P.Libelle,E.DebitSaisie,E.CreditSaisie');
           QueryRecupPointage.SQL.Add('From Piece P');
           QueryRecupPointage.SQL.Add('Join Ecriture E On (P.Id = E.Id_Piece)');
           if EstTiers then
           QueryRecupPointage.SQL.Add('Where E.tiers=:Tiers')
           else
           QueryRecupPointage.SQL.Add('Where E.Compte=:Tiers');
           if sensRegl then
              QueryRecupPointage.SQL.Add('and E.DebitSaisie<>0')
           else
              QueryRecupPointage.SQL.Add('and E.CreditSaisie<>0');
           if option in [1,2] then
             begin
              QueryRecupPointage.SQL.Add('and Exists (Select R1.Id_Ecriture from ResteDC R1 join Pointage Po1 on (R1.Id_Ecriture = Po1.Id_Debit or R1.Id_Ecriture = Po1.Id_Credit)');
              QueryRecupPointage.SQL.Add(' Where R1.Tiers=:Tiers and R1.Id_Ecriture=E.Id) or');
             end
           else
             if option =3 then
               begin
                QueryRecupPointage.SQL.Add('and not Exists (Select R1.Id_Ecriture from ResteDC R1 join Pointage Po1 on (R1.Id_Ecriture = Po1.Id_Debit or R1.Id_Ecriture = Po1.Id_Credit)');
                QueryRecupPointage.SQL.Add(' Where R1.Tiers=:Tiers and R1.Id_Ecriture=E.Id) and');
               end;

           if EstTiers then
           QueryRecupPointage.SQL.Add(' E.tiers=:Tiers')
           else
           QueryRecupPointage.SQL.Add(' E.Compte=:Tiers');
           if sensRegl then
              QueryRecupPointage.SQL.Add('and E.DebitSaisie<>0')
           else
              QueryRecupPointage.SQL.Add('and E.CreditSaisie<>0');
           if option in [1,2] then
             Begin
               QueryRecupPointage.SQL.Add('and (not Exists(select Po2.Id_Debit from Pointage Po2 where Po2.Id_Debit=E.Id)');
               QueryRecupPointage.SQL.Add('and not Exists(select Po3.Id_Credit from Pointage Po3 where Po3.Id_Credit=E.Id))');
             End;
          if option =3 then
             Begin
               QueryRecupPointage.SQL.Add('and (Exists(select Po2.Id_Debit from Pointage Po2 where Po2.Id_Debit=E.Id)');
               QueryRecupPointage.SQL.Add('or  Exists(select Po3.Id_Credit from Pointage Po3 where Po3.Id_Credit=E.Id))');
             End;

      QueryRecupPointage.ParamByName('Tiers').AsString:=Tiers;
   //   showmessage(QueryRecupPointage.sql.Text);

      QueryRecupPointage.open;
      QueryRecupPointage.RecordCount;
      QueryRecupPointage.First;

      QuLigneBanqueTiersEnCours.active:=false;
      QuLigneBanqueTiersEnCours.SQL.Clear;
      QuLigneBanqueTiersEnCours.SQL.Add('select  P.Journal,P."Date",P.Reference,P.Libelle,E2.* from');
      QuLigneBanqueTiersEnCours.SQL.Add('Ecriture E2');
      QuLigneBanqueTiersEnCours.SQL.Add('join Piece P on (E2.Id_Piece=P.Id and P.Journal in');
      QuLigneBanqueTiersEnCours.SQL.Add('(select ID from model where id_Journal=:IDJournal))');
      if EstTiers then
      QuLigneBanqueTiersEnCours.SQL.Add('where E2.Tiers=:Tiers')
      else
      QuLigneBanqueTiersEnCours.SQL.Add('where E2.compte=:Tiers');
      if sensRegl then
         QuLigneBanqueTiersEnCours.SQL.Add('and E2.DebitSaisie<>0')
      else
         QuLigneBanqueTiersEnCours.SQL.Add('and E2.CreditSaisie<>0');
      QuLigneBanqueTiersEnCours.SQL.Add('and  P.Reference in');
      QuLigneBanqueTiersEnCours.SQL.Add('(Select P.Reference');
      QuLigneBanqueTiersEnCours.SQL.Add('From Piece P');
      QuLigneBanqueTiersEnCours.SQL.Add('Join Ecriture E On (P.Id = E.Id_Piece)');
      if EstTiers then
      QuLigneBanqueTiersEnCours.SQL.Add('Where E.tiers= '''+Tiers+'''')
      else
      QuLigneBanqueTiersEnCours.SQL.Add('Where E.Compte= '''+Tiers+'''');
      if option in [1,2] then
        begin
         QuLigneBanqueTiersEnCours.SQL.Add('and Exists (Select R1.Id_Ecriture from ResteDC R1 join Pointage Po1 on (R1.Id_Ecriture = Po1.Id_Debit or R1.Id_Ecriture = Po1.Id_Credit)');
         QuLigneBanqueTiersEnCours.SQL.Add(' Where R1.Tiers= '''+Tiers+''' and R1.Id_Ecriture=E.Id) or');
        end
      else
        if option =3 then
          begin
           QuLigneBanqueTiersEnCours.SQL.Add('and not Exists (Select R1.Id_Ecriture from ResteDC R1 join Pointage Po1 on (R1.Id_Ecriture = Po1.Id_Debit or R1.Id_Ecriture = Po1.Id_Credit)');
           QuLigneBanqueTiersEnCours.SQL.Add(' Where R1.Tiers= '''+Tiers+''' and R1.Id_Ecriture=E.Id) and');
          end;

      if EstTiers then
      QuLigneBanqueTiersEnCours.SQL.Add(' E.tiers= '''+Tiers+'''')
      else
      QuLigneBanqueTiersEnCours.SQL.Add(' E.Compte= '''+Tiers+'''');
      if option in [1,2] then
        Begin
          QuLigneBanqueTiersEnCours.SQL.Add('and (not Exists(select Po2.Id_Debit from Pointage Po2 where Po2.Id_Debit=E.Id)');
          QuLigneBanqueTiersEnCours.SQL.Add('and not Exists(select Po3.Id_Credit from Pointage Po3 where Po3.Id_Credit=E.Id)))');
        End;
     if option =3 then
        Begin
          QuLigneBanqueTiersEnCours.SQL.Add('and (Exists(select Po2.Id_Debit from Pointage Po2 where Po2.Id_Debit=E.Id)');
          QuLigneBanqueTiersEnCours.SQL.Add('or  Exists(select Po3.Id_Credit from Pointage Po3 where Po3.Id_Credit=E.Id)))');
        End;

      QuLigneBanqueTiersEnCours.ParamByName('IDJournal').AsInteger:=Journal;
      QuLigneBanqueTiersEnCours.ParamByName('Tiers').AsString:=Tiers;

      QuLigneBanqueTiersEnCours.open;
      if QuLigneBanqueTiersEnCours.RecordCount<>0 then
        Begin
//          result.Reste:=QuLigneBanqueTiersEnCoursResteAPointer.AsCurrency;
//          result.ResteInitial:=result.Reste;
//          result.SensReste:=true; 
        End;
      QuLigneBanqueTiersEnCours.first;
   except
   showmessage('Problème lors de la récupération des lignes à Pointer !!! ');
   abort;
   end;//fin du try except
End;


procedure TDMPointage.RecupPiecePointableSurTiers_Et_Journal_PourPointages(Tiers:string;Journal:string);
var
Esttiers:boolean;
ChampID:string;
i:integer;
Begin

   try
   QuSumPointeCredit.close;
   QuSumPointeDebit.close;
   EstTiers:=copy(tiers,1,1)='+';
   if not EstTiers then
     Begin
      QuSumPointeCredit.SQL.Strings[4]:='E.compte=:tiers';
      QuSumPointeDebit.SQL.Strings[4]:='E.compte=:tiers';
     End
   else
     Begin
      QuSumPointeCredit.SQL.Strings[4]:='E.Tiers=:tiers';
      QuSumPointeDebit.SQL.Strings[4]:='E.Tiers=:tiers';
     End;
   QuSumPointeCredit.ParamByName('Tiers').AsString:=Tiers;
   QuSumPointeCredit.open;
   QuSumPointeDebit.ParamByName('Tiers').AsString:=Tiers;
   QuSumPointeDebit.open;

        QueryRecupPointage.active:=false;
        QueryRecupPointage.SQL.Clear;
           QueryRecupPointage.SQL.Add('Select P.Journal,E.Id,P."Date",P.Reference,P.Libelle,E.DebitSaisie,E.CreditSaisie');
           QueryRecupPointage.SQL.Add('From Piece P');
           QueryRecupPointage.SQL.Add('Join Ecriture E On (P.Id = E.Id_Piece)');
           if EstTiers then
           QueryRecupPointage.SQL.Add('Where E.tiers=:Tiers')
           else
           QueryRecupPointage.SQL.Add('Where E.Compte=:Tiers');
           QueryRecupPointage.SQL.Add('and Exists (Select R1.Id_Ecriture from ResteDC R1 join Pointage Po1 on (R1.Id_Ecriture = Po1.Id_Debit or R1.Id_Ecriture = Po1.Id_Credit)');
           QueryRecupPointage.SQL.Add(' Where R1.Tiers=:Tiers and R1.Id_Ecriture=E.Id) or');
           if EstTiers then
           QueryRecupPointage.SQL.Add(' E.tiers=:Tiers')
           else
           QueryRecupPointage.SQL.Add(' E.Compte=:Tiers');
           QueryRecupPointage.SQL.Add('and (not Exists(select Po2.Id_Debit from Pointage Po2 where Po2.Id_Debit=E.Id)');
           QueryRecupPointage.SQL.Add('and not Exists(select Po3.Id_Credit from Pointage Po3 where Po3.Id_Credit=E.Id))');

      QueryRecupPointage.ParamByName('Tiers').AsString:=Tiers;
  //    showmessage(QueryRecupPointage.sql.Text);
      DMPieces.QuRecupPieceTvaTypeE.Close;
      DMPieces.QuRecupPieceTvaTypeE.open;
      

      QueryRecupPointage.open;
      QueryRecupPointage.RecordCount;
      QueryRecupPointage.First;

      QuLigneBanqueTiersEnCours.active:=false;
      QuLigneBanqueTiersEnCours.SQL.Clear;
      QuLigneBanqueTiersEnCours.SQL.Add('select  P.Journal,P."Date",P.Reference,P.Libelle,E2.* from');
      QuLigneBanqueTiersEnCours.SQL.Add('Ecriture E2');
      QuLigneBanqueTiersEnCours.SQL.Add('join Piece P on (E2.Id_Piece=P.Id and P.Journal in');
      QuLigneBanqueTiersEnCours.SQL.Add('(select ID from model where id_Journal in '+Journal+'))');
      if EstTiers then
      QuLigneBanqueTiersEnCours.SQL.Add('where E2.Tiers=:Tiers')
      else
      QuLigneBanqueTiersEnCours.SQL.Add('where E2.compte=:Tiers');
      QuLigneBanqueTiersEnCours.SQL.Add('and  P.Reference in');
      QuLigneBanqueTiersEnCours.SQL.Add('(Select P.Reference');
      QuLigneBanqueTiersEnCours.SQL.Add('From Piece P');
      QuLigneBanqueTiersEnCours.SQL.Add('Join Ecriture E On (P.Id = E.Id_Piece)');
      if EstTiers then
      QuLigneBanqueTiersEnCours.SQL.Add('Where E.tiers= '''+Tiers+'''')
      else
      QuLigneBanqueTiersEnCours.SQL.Add('Where E.Compte= '''+Tiers+'''');
      QuLigneBanqueTiersEnCours.SQL.Add('and Exists (Select R1.Id_Ecriture from ResteDC R1 join Pointage Po1 on (R1.Id_Ecriture = Po1.Id_Debit or R1.Id_Ecriture = Po1.Id_Credit)');
      QuLigneBanqueTiersEnCours.SQL.Add(' Where R1.Tiers= '''+Tiers+''' and R1.Id_Ecriture=E.Id) or');
      if EstTiers then
      QuLigneBanqueTiersEnCours.SQL.Add(' E.tiers= '''+Tiers+'''')
      else
      QuLigneBanqueTiersEnCours.SQL.Add(' E.Compte= '''+Tiers+'''');
      QuLigneBanqueTiersEnCours.SQL.Add('and (not Exists(select Po2.Id_Debit from Pointage Po2 where Po2.Id_Debit=E.Id)');
      QuLigneBanqueTiersEnCours.SQL.Add('and not Exists(select Po3.Id_Credit from Pointage Po3 where Po3.Id_Credit=E.Id)))');

    //  QuLigneBanqueTiersEnCours.ParamByName('IDJournal').AsInteger:=Journal;
      QuLigneBanqueTiersEnCours.ParamByName('Tiers').AsString:=Tiers;

    //  showmessage(QuLigneBanqueTiersEnCours.sql.Text);
      QuLigneBanqueTiersEnCours.open;
      QuLigneBanqueTiersEnCours.RecordCount;
      QuLigneBanqueTiersEnCours.first;

      while not QuLigneBanqueTiersEnCours.EOF do
         Begin
            QuLigneBanqueTiersEnCoursReference.AsString;
            QuLigneBanqueTiersEnCoursResteAPointer.AsCurrency;
            QuLigneBanqueTiersEnCours.Next;
         End;

   except
   showmessage('Problème lors de la récupération des lignes à Pointer !!! ');
   abort;
   end;//fin du try except
End;

procedure TDMPointage.QueryRecupPointageCalcFields(DataSet: TDataSet);
begin
if not VerifFNumeric(QueryRecupPointageDebitSaisie).VideOUZero then
    QueryRecupPointagereste.AsCurrency:=QueryRecupPointageDebitSaisie.AsCurrency - QueryRecupPointageTotalPointeDebit.AsCurrency;
if not VerifFNumeric(QueryRecupPointageCreditSaisie).VideOUZero then
    QueryRecupPointagereste.AsCurrency:=QueryRecupPointageCreditSaisie.AsCurrency - QueryRecupPointageTotalPointeCredit.AsCurrency;
 if QueryRecupPointageCreditSaisie.AsCurrency>QueryRecupPointageDebitSaisie.AsCurrency then
   QueryRecupPointageSensReglement.AsBoolean:=true
 else
   QueryRecupPointageSensReglement.AsBoolean:=false;
end;

procedure TDMPointage.QuLigneBanqueTiersEnCoursCalcFields(DataSet: TDataSet);
begin
 if ((VerifFNumeric(QuLigneBanqueTiersEnCoursMontantImputationCredit).VideOUZero)and(VerifFNumeric(QuLigneBanqueTiersEnCoursSommeTotalPointageIDCredit).VideOUZero)) then
 QuLigneBanqueTiersEnCoursPointages.AsCurrency:=QuLigneBanqueTiersEnCoursSommeTotalPointageIDDebit.AsCurrency-QuLigneBanqueTiersEnCoursMontantImputationDebit.AsCurrency
 else
 QuLigneBanqueTiersEnCoursPointages.AsCurrency:=QuLigneBanqueTiersEnCoursSommeTotalPointageIDCredit.AsCurrency-QuLigneBanqueTiersEnCoursMontantImputationCredit.AsCurrency;

///
 if abs(QuLigneBanqueTiersEnCoursCreditSaisie.AsCurrency)<abs(QuLigneBanqueTiersEnCoursDebitSaisie.AsCurrency) then
   QuLigneBanqueTiersEnCoursTotalReglement.AsCurrency:=QuLigneBanqueTiersEnCoursDebitSaisie.AsCurrency
 else
   QuLigneBanqueTiersEnCoursTotalReglement.AsCurrency:=QuLigneBanqueTiersEnCoursCreditSaisie.AsCurrency;

///
// if QuLigneBanqueTiersEnCoursCreditSaisie.AsCurrency>QuLigneBanqueTiersEnCoursDebitSaisie.AsCurrency then
//   QuLigneBanqueTiersEnCoursSensReglement.AsBoolean:=true
// else
//   QuLigneBanqueTiersEnCoursSensReglement.AsBoolean:=false;


///
 if VerifFNumeric(QuLigneBanqueTiersEnCoursMontantImputationCredit).VideOUZero then
   QuLigneBanqueTiersEnCoursResteAPointer.AsCurrency:= abs(QuLigneBanqueTiersEnCoursTotalReglement.AsCurrency)-QuLigneBanqueTiersEnCoursPointages.AsCurrency-QuLigneBanqueTiersEnCoursMontantImputationDebit.AsCurrency
 else
   QuLigneBanqueTiersEnCoursResteAPointer.AsCurrency:= abs(QuLigneBanqueTiersEnCoursTotalReglement.AsCurrency)-QuLigneBanqueTiersEnCoursPointages.AsCurrency-QuLigneBanqueTiersEnCoursMontantImputationCredit.AsCurrency;

///
if not VerifFNumeric(QuLigneBanqueTiersEnCoursLignesPointeeCredit).VideOUZero then
  Begin
    QuLigneBanqueTiersEnCoursNbLignePointee.AsInteger:=QuLigneBanqueTiersEnCoursLignesPointeeCredit.AsInteger;
    QuLigneBanqueTiersEnCoursPointee.AsBoolean:=true;
  End
else
  if not VerifFNumeric(QuLigneBanqueTiersEnCoursLignesPointeeDebit).VideOUZero then
     Begin
       QuLigneBanqueTiersEnCoursNbLignePointee.AsInteger:=QuLigneBanqueTiersEnCoursLignesPointeeDebit.AsInteger;
       QuLigneBanqueTiersEnCoursPointee.AsBoolean:=true;
     End
  else
   QuLigneBanqueTiersEnCoursPointee.AsBoolean:=false;
///
end;

procedure TDMPointage.QuPointagePieceAppelanteCalcFields(
  DataSet: TDataSet);
begin
  if QuPointagePieceAppelanteCreditSaisie.AsCurrency>QuPointagePieceAppelanteDebitSaisie.AsCurrency then
    QuPointagePieceAppelanteSensReste.AsBoolean:=true
  else
    QuPointagePieceAppelanteSensReste.AsBoolean:=false;

  if abs(QuPointagePieceAppelanteTotalPointeCredit.AsCurrency)>abs(QuPointagePieceAppelanteTotalPointeDebit.AsCurrency) then
    QuPointagePieceAppelanteTotalPointe.AsCurrency:=QuPointagePieceAppelanteTotalPointeCredit.AsCurrency - QuPointagePieceAppelanteTotalPointeDebit.AsCurrency
  else
    QuPointagePieceAppelanteTotalPointe.AsCurrency:=QuPointagePieceAppelanteTotalPointeDebit.AsCurrency- QuPointagePieceAppelanteTotalPointeCredit.AsCurrency;

  if abs(QuPointagePieceAppelanteCreditSaisie.AsCurrency)<abs(QuPointagePieceAppelanteDebitSaisie.AsCurrency) then
     QuPointagePieceAppelanteResteAPointer.AsCurrency:= abs(QuPointagePieceAppelanteDebitSaisie.AsCurrency)-QuPointagePieceAppelanteTotalPointe.AsCurrency
  else
     QuPointagePieceAppelanteResteAPointer.AsCurrency:= abs(QuPointagePieceAppelanteCreditSaisie.AsCurrency)-QuPointagePieceAppelanteTotalPointe.AsCurrency;

end;

//****Récupère les lignes d'un tier qui soient encore pointables ou non
function TDMPointage.RecupPiecePointableSurTiers_Et_Journal_PourPieceAchat_Vente(Tiers:string;Option:integer;IDAppelant:integer;SensAppelant,SensRegl:boolean):Treste;
var
Esttiers:boolean;
ChampID:string;
Begin
result.Reste:=0;
result.ResteInitial:=0;
result.SensReste:=false;
   try
   if IDAppelant<>-1 then
     begin
      if SensRegl then
      ChampID:='ID_Credit'
      else
      ChampID:='ID_Debit';
      TaPointageImputation.Filtered:=false;
      TaPointageImputation.Filter:='';
      TaPointageImputation.Filter:=(ChampID+' ='''+inttostr(IDAppelant)+'''');
      TaPointageImputation.Filtered:=true;
     end
   else
     begin
      TaPointageImputation.Filtered:=false;
      TaPointageImputation.Filter:='';
      TaPointageImputation.Filtered:=true;
     end;
   QuSumPointeCredit.close;
   QuSumPointeDebit.close;
   EstTiers:=copy(tiers,1,1)='+';
   if not EstTiers then
     Begin
      QuSumPointeCredit.SQL.Strings[4]:='E.compte=:tiers';
      QuSumPointeDebit.SQL.Strings[4]:='E.compte=:tiers';
     End
   else
     Begin
      QuSumPointeCredit.SQL.Strings[4]:='E.Tiers=:tiers';
      QuSumPointeDebit.SQL.Strings[4]:='E.Tiers=:tiers';
     End;
   QuSumPointeCredit.ParamByName('Tiers').AsString:=Tiers;
   QuSumPointeCredit.open;
   QuSumPointeDebit.ParamByName('Tiers').AsString:=Tiers;
   QuSumPointeDebit.open;

       
        if not option in [2,3] then
          abort;
        QueryRecupPointage.active:=false;
        QueryRecupPointage.SQL.Clear;
           QueryRecupPointage.SQL.Add('Select P.Journal,E.Id,P."Date",P.Reference,P.Libelle,E.DebitSaisie,E.CreditSaisie');
           QueryRecupPointage.SQL.Add('From Piece P');
           QueryRecupPointage.SQL.Add('Join Ecriture E On (P.Id = E.Id_Piece)');
           if EstTiers then
           QueryRecupPointage.SQL.Add('Where E.tiers=:Tiers')
           else
           QueryRecupPointage.SQL.Add('Where E.Compte=:Tiers');
           if sensRegl then
              QueryRecupPointage.SQL.Add('and E.DebitSaisie<>0')
           else
              QueryRecupPointage.SQL.Add('and E.CreditSaisie<>0');
           if option in [1,2] then
             begin
              QueryRecupPointage.SQL.Add('and Exists (Select R1.Id_Ecriture from ResteDC R1 join Pointage Po1 on (R1.Id_Ecriture = Po1.Id_Debit or R1.Id_Ecriture = Po1.Id_Credit)');
              QueryRecupPointage.SQL.Add(' Where R1.Tiers=:Tiers and R1.Id_Ecriture=E.Id) or');
             end
           else
             if option =3 then
               begin
                QueryRecupPointage.SQL.Add('and not Exists (Select R1.Id_Ecriture from ResteDC R1 join Pointage Po1 on (R1.Id_Ecriture = Po1.Id_Debit or R1.Id_Ecriture = Po1.Id_Credit)');
                QueryRecupPointage.SQL.Add(' Where R1.Tiers=:Tiers and R1.Id_Ecriture=E.Id) and');
               end;

           if EstTiers then
           QueryRecupPointage.SQL.Add(' E.tiers=:Tiers')
           else
           QueryRecupPointage.SQL.Add(' E.Compte=:Tiers');
           if sensRegl then
              QueryRecupPointage.SQL.Add('and E.DebitSaisie<>0')
           else
              QueryRecupPointage.SQL.Add('and E.CreditSaisie<>0');
           if option in [1,2] then
             Begin
               QueryRecupPointage.SQL.Add('and (not Exists(select Po2.Id_Debit from Pointage Po2 where Po2.Id_Debit=E.Id)');
               QueryRecupPointage.SQL.Add('and not Exists(select Po3.Id_Credit from Pointage Po3 where Po3.Id_Credit=E.Id))');
             End;
          if option =3 then
             Begin
               QueryRecupPointage.SQL.Add('and (Exists(select Po2.Id_Debit from Pointage Po2 where Po2.Id_Debit=E.Id)');
               QueryRecupPointage.SQL.Add('or  Exists(select Po3.Id_Credit from Pointage Po3 where Po3.Id_Credit=E.Id))');
             End;

      QueryRecupPointage.ParamByName('Tiers').AsString:=Tiers;
   //   showmessage(QueryRecupPointage.sql.Text);

      QueryRecupPointage.open;
      QueryRecupPointage.RecordCount;
      QueryRecupPointage.First;

      QuLigneBanqueTiersEnCours.active:=false;
      QuLigneBanqueTiersEnCours.SQL.Clear;
      QuLigneBanqueTiersEnCours.SQL.Add('select  P.Journal,P."Date",P.Reference,P.Libelle,E2.* from');
      QuLigneBanqueTiersEnCours.SQL.Add('Ecriture E2');
      QuLigneBanqueTiersEnCours.SQL.Add('join Piece P on (E2.Id_Piece=P.Id and P.Journal in');
      QuLigneBanqueTiersEnCours.SQL.Add('(select ID from model where id_Journal in (1,2)))');
      if EstTiers then
      QuLigneBanqueTiersEnCours.SQL.Add('where E2.Tiers=:Tiers')
      else
      QuLigneBanqueTiersEnCours.SQL.Add('where E2.compte=:Tiers');
      if sensRegl then
         QuLigneBanqueTiersEnCours.SQL.Add('and E2.DebitSaisie<>0')
      else
         QuLigneBanqueTiersEnCours.SQL.Add('and E2.CreditSaisie<>0');
      QuLigneBanqueTiersEnCours.SQL.Add('and  P.Reference in');
      QuLigneBanqueTiersEnCours.SQL.Add('(Select P.Reference');
      QuLigneBanqueTiersEnCours.SQL.Add('From Piece P');
      QuLigneBanqueTiersEnCours.SQL.Add('Join Ecriture E On (P.Id = E.Id_Piece)');
      if EstTiers then
      QuLigneBanqueTiersEnCours.SQL.Add('Where E.tiers= '''+Tiers+'''')
      else
      QuLigneBanqueTiersEnCours.SQL.Add('Where E.Compte= '''+Tiers+'''');
      if option in [1,2] then
        begin
         QuLigneBanqueTiersEnCours.SQL.Add('and Exists (Select R1.Id_Ecriture from ResteDC R1 join Pointage Po1 on (R1.Id_Ecriture = Po1.Id_Debit or R1.Id_Ecriture = Po1.Id_Credit)');
         QuLigneBanqueTiersEnCours.SQL.Add(' Where R1.Tiers= '''+Tiers+''' and R1.Id_Ecriture=E.Id) or');
        end
      else
        if option =3 then
          begin
           QuLigneBanqueTiersEnCours.SQL.Add('and not Exists (Select R1.Id_Ecriture from ResteDC R1 join Pointage Po1 on (R1.Id_Ecriture = Po1.Id_Debit or R1.Id_Ecriture = Po1.Id_Credit)');
           QuLigneBanqueTiersEnCours.SQL.Add(' Where R1.Tiers= '''+Tiers+''' and R1.Id_Ecriture=E.Id) and');
          end;

      if EstTiers then
      QuLigneBanqueTiersEnCours.SQL.Add(' E.tiers= '''+Tiers+'''')
      else
      QuLigneBanqueTiersEnCours.SQL.Add(' E.Compte= '''+Tiers+'''');
      if option in [1,2] then
        Begin
          QuLigneBanqueTiersEnCours.SQL.Add('and (not Exists(select Po2.Id_Debit from Pointage Po2 where Po2.Id_Debit=E.Id)');
          QuLigneBanqueTiersEnCours.SQL.Add('and not Exists(select Po3.Id_Credit from Pointage Po3 where Po3.Id_Credit=E.Id)))');
        End;
     if option =3 then
        Begin
          QuLigneBanqueTiersEnCours.SQL.Add('and (Exists(select Po2.Id_Debit from Pointage Po2 where Po2.Id_Debit=E.Id)');
          QuLigneBanqueTiersEnCours.SQL.Add('or  Exists(select Po3.Id_Credit from Pointage Po3 where Po3.Id_Credit=E.Id)))');
        End;

//      QuLigneBanqueTiersEnCours.ParamByName('IDJournal').AsInteger:=Journal;
      QuLigneBanqueTiersEnCours.ParamByName('Tiers').AsString:=Tiers;

      QuLigneBanqueTiersEnCours.open;
      if QuLigneBanqueTiersEnCours.RecordCount<>0 then
        Begin
//          result.Reste:=QuLigneBanqueTiersEnCoursResteAPointer.AsCurrency;
//          result.ResteInitial:=result.Reste;
//          result.SensReste:=true; 
        End;
      QuLigneBanqueTiersEnCours.first;
   except
   showmessage('Problème lors de la récupération des lignes à Pointer !!! ');
   abort;
   end;//fin du try except
End;




procedure TDMPointage.QuVerifPointagesDebitCalcFields(DataSet: TDataSet);
begin
  QuVerifPointagesDebitResteAPointer.AsCurrency:=QuVerifPointagesDebitDebitSaisie.AsCurrency;
if TaRestePourVerifPointage.Locate('ID_Ecriture;Sens',VarArrayOf([QuVerifPointagesDebitID.AsInteger,'D']),[])then
      QuVerifPointagesDebitResteAPointer.AsCurrency:=TaRestePourVerifPointageReste.AsCurrency;
end;

procedure TDMPointage.QuVerifPointagesCreditCalcFields(DataSet: TDataSet);
begin
  QuVerifPointagesCreditResteAPointer.AsCurrency:=QuVerifPointagesCreditCreditSaisie.AsCurrency;
if TaRestePourVerifPointage.Locate('ID_Ecriture;Sens',VarArrayOf([QuVerifPointagesCreditID.AsInteger,'C']),[])then
      QuVerifPointagesCreditResteAPointer.AsCurrency:=TaRestePourVerifPointageReste.AsCurrency;
end;

procedure TDMPointage.PointagesAutomatique(TaEcritureDebit,TaEcritureCredit:TQuery;DateDeb,DAteFin:TDate);
var
QuParcours:TQuery;
Tab:variant;
IDPointage:integer;
ListePointages:TStringList;
Begin
ListePointages:=TStringList.Create;
// Preparation de la query de parcours
QuParcours:=TQuery.Create(self);
QuParcours.DatabaseName:=TaEcritureDebit.DatabaseName;
QuParcours.SQL:=TaEcritureDebit.SQL;
QuParcours.Filter:=CreeFiltreETPlage(['Date'],[DateDeb,DAteFin]);
QuParcours.Filtered:=true;
QuParcours.Open;

TaEcritureDebit.Close;
TaEcritureDebit.Filtered:=true;
TaEcritureDebit.Open;

TaEcritureCredit.Close;
TaEcritureCredit.Filtered:=true;
TaEcritureCredit.Open;

QuParcours.First;
while not QuParcours.EOF do
  begin
   TaEcritureDebit.Filter:=CreeFiltreETPlage(['Date','ResteAPointer','Tiers'],[DateDeb,DAteFin,QuParcours.findField('ResteAPointer').AsCurrency,QuParcours.findField('ResteAPointer').AsCurrency,QuParcours.findField('Tiers').Asstring,QuParcours.findField('Tiers').Asstring]);
   TaEcritureCredit.Filter:=CreeFiltreETPlage(['Date','ResteAPointer','Tiers'],[DateDeb,DAteFin,QuParcours.findField('ResteAPointer').AsCurrency,QuParcours.findField('ResteAPointer').AsCurrency,QuParcours.findField('Tiers').Asstring,QuParcours.findField('Tiers').Asstring]);
   case TaEcritureDebit.RecordCount of
     0:Begin
        // Problème
        showmessage('Un problème est survenu lors du pointage Automatique');
       End;
     1:Begin
        case TaEcritureCredit.RecordCount of
          0:Begin
             // Aucune ligne à pointer coté Crédit
            End;
          1:Begin // On peut effectuer le pointage automatique
             //récupérer les infos du pointage à faire
                   Tab:=VarArrayCreate([0,4],varVariant);
                   //récupérer tous les paramétres nécessaire pour créer le pointage
                   //et recréer le reste de chaque idEcriture du pointage

                       tab[0]:=TaEcritureDebit.findfield('ID').asinteger;
                       tab[1]:=TaEcritureCredit.findfield('ID').asinteger;
                    case CompareDate(TaEcritureDebit.findfield('Date').AsDateTime,TaEcritureCredit.findfield('Date').AsDateTime) of
                       -2: begin//date pas cohérente;
                             showmessage('La date de l''écriture '+TaEcritureDebit.findfield('ID').asstring+' ou la date de l''écriture '+TaEcritureCredit.findfield('ID').asstring+' est incorrecte.');
                             abort;
                           end;
                       -1: tab[2]:=TaEcritureDebit.findfield('Date').AsDateTime;
                        0: tab[2]:=TaEcritureDebit.findfield('Date').AsDateTime;
                        1: tab[2]:=TaEcritureCredit.findfield('Date').AsDateTime;
                    end;
                   tab[3]:=TaEcritureDebit.findfield('resteAPointer').AsCurrency;
                   tab[4]:=tab[2];
             // Pointage auto
                   if not empty(QuParcours.findField('Tiers').Asstring)then
                   IDPointage:=DMPointage.CreationPointageSurIDEcriture(tab,QuParcours.findField('Tiers').Asstring,true,[0])
                   else
                   IDPointage:=DMPointage.CreationPointageSurIDEcriture(tab,QuParcours.findField('compte').Asstring,true,[0]);
                   if IDPointage<>-1 then
                   ListePointages.Add(inttostr(IDPointage));
                   Tab:=Unassigned;
            End;
        else
          Begin
               // Plusieurs lignes à pointer coté Crédit, il faut proposer le pointage Manuel
          End;
        end; // Fin 2 Case
       End; // Fin du 1
   else
     Begin // Plusieurs lignes à pointer coté Débit, il faut proposer le pointage Manuel

     End;
   end; // Fin Du Premier CAse
  QuParcours.Next;
  end;
ListePointages.Free;
End;


procedure TDMPointage.TraitementCloture1000(sender:Tobject);
Begin
  try
    //faire un pointage automatique
    if not QuVerifPointagesDebit.Database.InTransaction then
      Begin
         QuVerifPointagesDebit.Database.TransIsolation:=tiDirtyRead;
         QuVerifPointagesDebit.Database.StartTransaction;
      End;
    PointagesAutomatique(QuVerifPointagesDebit,QuVerifPointagesCredit,e.DatExoDebut,e.DatExoFin);
    if QuVerifPointagesDebit.Database.InTransaction then
       QuVerifPointagesDebit.Database.Commit;
             if DMBalance.TaBalance.Database.InTransaction then
        DMBalance.TaBalance.Database.commit;
  except
    showmessage('Problème lors du pointage automatique');
    if QuVerifPointagesDebit.Database.InTransaction then
      QuVerifPointagesDebit.Database.Rollback;
    abort;
  end;//fin du try except
End;

procedure TDMPointage.TraitementCloture2000(sender:Tobject);
Begin
  //
End;


procedure TDMPointage.QuPointageAffichBeforeInsert(DataSet: TDataSet);
begin
abort;
end;



procedure TDMPointage.GestionDuReste(var InfosCreationReste:TInfosCreationReste;SuppEcriture:boolean);
begin
if not TaReste.Active then
   TaReste.open;
 if TaReste.Locate('ID_Ecriture',InfosCreationReste.IDEcriture,[])then
    Begin//si on trouve une ligne reste pour cette écriture, on la modifie
      TaReste.edit;
      if SuppEcriture then
        TaReste.FindField('Reste').ascurrency:=TaReste.FindField('Reste').ascurrency+InfosCreationReste.Pointage.MontantPointage
      else
        TaReste.FindField('Reste').ascurrency:=TaReste.FindField('Reste').ascurrency-InfosCreationReste.Pointage.MontantPointage;
      TaReste.Post;
      TaReste.FlushBuffers;
    end
 else
   Begin
     RechercheMaxIdReste;
     CreationReste(Maxidreste,InfosCreationReste.IDEcriture,InfosCreationReste.idpiece,
     InfosCreationReste.DatePiece,InfosCreationReste.Reference,InfosCreationReste.tiers,
     InfosCreationReste.Libelle,'',InfosCreationReste.Reste.SensReste,
     InfosCreationReste.MontantDebit,InfosCreationReste.MontantCredit,
     InfosCreationReste.Reste.reste,0);
   End;
end;



end.
