unit DMDiocEtatBalance;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,E2_Decl_Records,LibSQL,DMBalances,DMEcriture,E2_Librairie_Obj,
  GR_Librairie_Obj,
  LibRessourceString,
  ObjetEdition,
  LibFichRep,Printers,
  editions,shellapi,choixperiode,libdates,lib_chaine,DMRecherche, LibZoneSaisie;

type


  PPeriode = class(TObject)
   DateDeb:TDate;
   DateFin:TDate;
   DateDebExo:TDate;
   DirExoBalance:string;
   Retour:Boolean;
       constructor Create;
    destructor Destroy;
  end;



  TCompteComparaison=class(TObject)
    compte:string;
    tiers:string;
    Designation:string;
    classe : string;
    TotauxBalance:TTotauxBalance;
    Periode:PPeriode;
    constructor Create;
    destructor Destroy;
  end;

  TDMDiocEtatBal = class(TDataModule)
    TaBalanceaffich: TTable;
    DaBalance: TDataSource;
    TaPlanCpt: TTable;
    TaBalanceaffichCompte: TStringField;
    TaBalanceaffichComptePlanCpt: TStringField;
    TaBalanceaffichDebit_Report: TFloatField;
    TaBalanceaffichCredit_Report: TFloatField;
    TaBalanceaffichDebit_Report_Calc: TCurrencyField;
    TaBalanceaffichCredit_report_calc: TCurrencyField;
    TaBalanceaffichCredit_Base_Calc: TCurrencyField;
    TaBalanceaffichDebit_Base_Calc: TCurrencyField;
    TaBalanceaffichDebit_Total_Calc: TCurrencyField;
    TaBalanceaffichCredit_Total_Calc: TCurrencyField;
    QuEcritureReport: TQuery;
    QuEcritureReportCompte: TStringField;
    QuEcritureReportTotDebit: TCurrencyField;
    QuEcritureReportTotCredit: TCurrencyField;
    QuEcritureBase: TQuery;
    QuEcritureBaseCompte: TStringField;
    QuEcritureBaseTotDebit: TCurrencyField;
    QuEcritureBaseTotCredit: TCurrencyField;
    TaBalanceaffichDebit_Base_QueryBase: TCurrencyField;
    TaBalanceaffichCredit_Base_QueryBase: TCurrencyField;
    TaBalanceaffichSolde_Debit_Report_Calc: TCurrencyField;
    TaBalanceaffichSolde_Credit_Report_Calc: TCurrencyField;
    TaBalanceaffichSolde_Debit_Base_Calc: TCurrencyField;
    TaBalanceaffichSolde_Credit_Base_Calc: TCurrencyField;
    TaBalanceaffichSolde_Debit_Total_Calc: TCurrencyField;
    TaBalanceaffichSolde_Credit_Total_Calc: TCurrencyField;
    TaBalanceCalc: TTable;
    TaBalanceCalcCompte: TStringField;
    TaBalanceCalcComptePlanCpt: TStringField;
    TaBalanceCalcDebit_Report_Calc: TCurrencyField;
    TaBalanceCalcCredit_report_calc: TCurrencyField;
    TaBalanceCalcSolde_Debit_Report_Calc: TCurrencyField;
    TaBalanceCalcDebit_Base_Calc: TCurrencyField;
    TaBalanceCalcCredit_Base_Calc: TCurrencyField;
    TaBalanceCalcSolde_Debit_Base_Calc: TCurrencyField;
    TaBalanceCalcSolde_Credit_Base_Calc: TCurrencyField;
    TaBalanceCalcDebit_Total_Calc: TCurrencyField;
    TaBalanceCalcCredit_Total_Calc: TCurrencyField;
    TaBalanceCalcSolde_Debit_Total_Calc: TCurrencyField;
    TaBalanceCalcSolde_Credit_Total_Calc: TCurrencyField;
    TaBalanceCalcDebit_Report: TFloatField;
    TaBalanceCalcCredit_Report: TFloatField;
    TaBalanceCalcDebit_Base_QueryBase: TCurrencyField;
    TaBalanceCalcCredit_Base_QueryBase: TCurrencyField;
    TaBalanceCalcTiers: TStringField;
    DaBalancePourODAuto: TDataSource;
    TaBalanceaffichID_Affichage: TIntegerField;
    QuListeValRupt: TQuery;
    QuSousTotal: TQuery;
    QuTotalG: TQuery;
    QuTotalG2: TQuery;
    TaBalanceMaintS: TTable;
    DaTaBalanceCalc: TDataSource;
    TaBalanceCalcDebit_Base: TFloatField;
    TaBalanceCalcCredit_Base: TFloatField;
    QuCorrectionBalance: TQuery;
    TaBalanceCalcQt2_Report_Calc: TFloatField;
    TaBalanceCalcQt1_Report_calc: TFloatField;
    TaBalanceCalcQt1_Base_Calc: TFloatField;
    TaBalanceCalcQt2_Base_Calc: TFloatField;
    TaBalanceCalcQt1_Total_Calc: TFloatField;
    TaBalanceCalcQt2_Total_Calc: TFloatField;
    TaBalanceCalcQt1_Report: TFloatField;
    TaBalanceCalcQt2_Report: TFloatField;
    TaBalanceCalcQt1_Base: TFloatField;
    TaBalanceCalcQt2_Base: TFloatField;
    TaBalanceCalcSolde_Qt1_Report_Calc: TFloatField;
    TaBalanceCalcSolde_Qt2_Report_Calc: TFloatField;
    TaBalanceCalcSolde_Qt1_Base_Calc: TFloatField;
    TaBalanceCalcSolde_Qt2_Base_Calc: TFloatField;
    TaBalanceCalcSolde_Qt1_Total_Calc: TFloatField;
    TaBalanceCalcSolde_Qt2_Total_Calc: TFloatField;
    TaBalanceCalcSolde_Credit_Report_Calc: TCurrencyField;
    TaBalanceCalcQt1_Base_QueryBase: TFloatField;
    TaBalanceCalcQt2_Base_QueryBase: TFloatField;
    QuEcritureBaseTotQt1: TFloatField;
    QuEcritureBaseTotQt2: TFloatField;
    QuEcritureReportTotQt1: TFloatField;
    QuEcritureReportTotQt2: TFloatField;
    TaBalanceCalcCollectif: TBooleanField;
    TaBalanceCalcPointable: TBooleanField;
    TaSensCompte: TTable;
    procedure TaBalanceaffichCalcFields(DataSet: TDataSet);
    Procedure CalculSurPeriode(DateDeb,DateFin:TDate);

    Function SommeTotauxBalance(DateDeb,DateFin:TDate;ListeFiltre:TStringList;ChampFiltre:String):TTotauxBalance;
    procedure DMDiocEtatBalCreate(Sender: TObject);
    procedure TaBalanceaffichBeforeOpen(DataSet: TDataSet);
    procedure TaBalanceCalcCalcFields(DataSet: TDataSet);
    Function SommeTotauxBalanceCalc(DateDeb,DateFin:TDate;ListeFiltre:TStringList;ChampFiltre:String;ForcerClose:boolean=true):TTotauxBalance;
    Function SommeTotauxBalanceParCompte(DateDeb,DateFin:TDate;Compte:String;ForcerClose:boolean=true):TTotauxBalance;
    procedure TaBalanceaffichBeforeInsert(DataSet: TDataSet);
    procedure TaBalanceaffichBeforeEdit(DataSet: TDataSet);
    procedure TaBalanceaffichBeforeDelete(DataSet: TDataSet);
    procedure DMDiocEtatBalDestroy(Sender: TObject);
    procedure TaBalanceaffichFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);

    Procedure Balance_Maj_BO_Vers_Balance(DataSetBO:TDataSet);
    Function VerifSoldeCompteDansBalance(Compte:string):TCalcul;
    procedure TaBalanceCalcFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaBalanceCalcFilterRecordSurOuverture(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaBalanceCalcFilterRecordSurChargesEtProduitOuverture(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaBalanceCalcBeforeRefresh(DataSet: TDataSet);
    Procedure ResultatExercice(var Debit,Credit:Currency;DateDeb,DateFin:TDate;ListeFiltreBalance:TStringList);overload;
    function SensCompte(compte:string):String;
    function DetermineSensVariation(solde1,solde2:currency;sens1,sens2,SensTheorique:string;typeVariation:integer=0):Currency;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    ListeFiltreAffich,ListeFiltreEdit : TStringList;
        PeriodeExercice:Boolean;
  end;

  Function MiseAJourBalanceNCpt:Boolean;
  Function ControleBalanceCpt(ListeCptFiltre,ListeCptNonEquilibre:TStringList):Boolean;
  Function EditionBalance(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
  Function EditionBalanceL(TypeEdition : integer; DemandePeriode:Boolean; ListeCompte:TStringList;DataSet:TDataSet;Regrouper:integer=0):Boolean;
  Function EditionBalanceOuvertureL(ListeCompte:TStringList;DataSet:TDataSet):Boolean;
  Function EditionChargesEtProduitsOuvertureL(ListeEdition:TStringList):Boolean;
  Procedure ResultatExercice(var Debit,Credit:Currency;DateDeb,DateFin:TDate);overload;
  Function EditionBalanceComparative(ListeCompte:TStringList;PeriodesDemandees:TStringList;DataSet:TDataSet;Regrouper:integer;solde:boolean=false;typeVariation:integer=0):Boolean;
var
  DMDiocEtatBal: TDMDiocEtatBal;
     function listeExercice(idDossier:integer;premierVide:boolean=true):TStringList;
     function liste3DerniersExercices(listeEx0:TStringList):TStringList;
implementation

uses DMPlanCpt, DMProgramme, DMConstantes;

{$R *.DFM}
Function MiseAJourBalanceNCpt:Boolean;
var
ListeMiseAJour:Tstringlist;
Begin
try
 try
     result:= true;
     ListeMiseAJour:=TStringList.Create;
    if DMDiocEtatBal=nil then DMDiocEtatBal:=TDMDiocEtatBal.Create(Application.MainForm);
    if DMRech=nil then DMRech:=TDMRech.create(Application.MainForm);
      //supprimer les comptes de la balance qui n'ont pas de Report et
      //"Raz" des mouvements de ceux qui ont des reports
      DMDiocEtatBal.QuCorrectionBalance.Close;
      DMDiocEtatBal.QuCorrectionBalance.SQL.Clear;
      DMDiocEtatBal.QuCorrectionBalance.SQL.add('delete from balance');
      DMDiocEtatBal.QuCorrectionBalance.SQL.add('where ((Debit_Report = 0 or Debit_Report is Null) and (Credit_Report = 0 or Credit_Report is Null))');
      DMDiocEtatBal.QuCorrectionBalance.ExecSQL;
      //fin de la suppression
      DMDiocEtatBal.QuCorrectionBalance.Close;
      DMDiocEtatBal.QuCorrectionBalance.SQL.Clear;
      DMDiocEtatBal.QuCorrectionBalance.SQL.add('update balance.Db');
      DMDiocEtatBal.QuCorrectionBalance.SQL.add('set Debit_base = 0 ,Credit_Base = 0 ');
      DMDiocEtatBal.QuCorrectionBalance.ExecSQL;
      //fin du RAZ pour ceux qui on des reports
      DMDiocEtatBal.QuEcritureBase.Close;
      DMDiocEtatBal.QuEcritureBase.ParamByName('DateDeb').AsDate:=E.DatExoDebut;
      DMDiocEtatBal.QuEcritureBase.ParamByName('DateFin').AsDate:=E.DatExoFin;
      DMDiocEtatBal.QuEcritureBase.Open;
//    FiltrageDataSet(DMRech.TaBalanceRech,'((Debit_Base <> 0 and Debit_Base <> Null) or (Credit_Base <> 0 and Credit_Base <> Null))');
    DMRech.TaBalanceRech.First;
    DMDiocEtatBal.QuEcritureBase.First;
    while not DMDiocEtatBal.QuEcritureBase.Eof do
     begin
     if DMRech.TaBalanceRech.Locate('Compte',DMDiocEtatBal.QuEcritureBase.FindField('Compte').AsString,[]) then
      begin
      DMDiocEtatBal.QuCorrectionBalance.Close;
      DMDiocEtatBal.QuCorrectionBalance.SQL.Clear;
      DMDiocEtatBal.QuCorrectionBalance.SQL.add('update Balance.Db  set Debit_Base = '+str_QueDesChiffresCurr_SQL(DMDiocEtatBal.QuEcritureBase.FindField('TotDebit').AsString)+
                                                ', Credit_Base = '+str_QueDesChiffresCurr_SQL(DMDiocEtatBal.QuEcritureBase.FindField('TotCredit').AsString)+
                                                ' where Compte='''+DMDiocEtatBal.QuEcritureBase.FindField('Compte').AsString+'''');
    //  showmessage(DMDiocEtatBal.QuCorrectionBalance.SQL.Text);
      DMDiocEtatBal.QuCorrectionBalance.ExecSQL;
             ListeMiseAJour.Add(DMRech.TaBalanceRech.FindField('Compte').AsString+
                                ' | '+
                                DMDiocEtatBal.QuEcritureBase.FindField('Compte').AsString+
                                ' ## BaseD : '+
                                DMRech.TaBalanceRech.FindField('Debit_Base').AsString+
                                ' | '+
                                DMDiocEtatBal.QuEcritureBase.FindField('Totdebit').AsString+
                                ' ## BaseC : '+
                                DMRech.TaBalanceRech.FindField('Credit_Base').AsString+
                                ' | '+
                                DMDiocEtatBal.QuEcritureBase.FindField('TotCredit').AsString
                                );
       end
      else
      begin//si le compte n'existe pas dans la balance, il faut le créer
      DMDiocEtatBal.QuCorrectionBalance.Close;
      DMDiocEtatBal.QuCorrectionBalance.SQL.Clear;
      DMDiocEtatBal.QuCorrectionBalance.SQL.add('insert into Balance.Db  (compte,Debit_Report,Credit_Report,Debit_Base,Credit_base,Debit_Total,'+
                                                 'Credit_Total,Qt1_Report,Qt2_Report,Qt1_base,Qt2_base,Qt1_total,Qt2_Total)'+
                                                 'values('''+DMDiocEtatBal.QuEcritureBase.FindField('Compte').AsString+''',0,0,'+
                                                 str_QueDesChiffresCurr_SQL(DMDiocEtatBal.QuEcritureBase.FindField('TotDebit').AsString)+
                                                 ','+
                                                 str_QueDesChiffresCurr_SQL(DMDiocEtatBal.QuEcritureBase.FindField('TotCredit').AsString)+',0,0,0,0,0,0,0,0)');
      DMDiocEtatBal.QuCorrectionBalance.ExecSQL;
             ListeMiseAJour.Add(DMRech.TaBalanceRech.FindField('Compte').AsString+
                                ' | '+
                                DMDiocEtatBal.QuEcritureBase.FindField('Compte').AsString+
                                ' ## BaseD : '+
                                DMRech.TaBalanceRech.FindField('Debit_Base').AsString+
                                ' | '+
                                DMDiocEtatBal.QuEcritureBase.FindField('Totdebit').AsString+
                                ' ## BaseC : '+
                                DMRech.TaBalanceRech.FindField('Credit_Base').AsString+
                                ' | '+
                                DMDiocEtatBal.QuEcritureBase.FindField('TotCredit').AsString
                                );

      end;//fin si le compte n'existe pas dans la balance
      DMDiocEtatBal.QuEcritureBase.Next;
     end;
    except
     result := False;
    end;
 finally;
  DeFiltrageDataSet(DMRech.TaBalanceRech);
  ListeMiseAJour.SaveToFile(e.RepertoireDossier+'MiseAJourBalanceNCpt.txt');
 end;
End;

Function ControleBalanceCpt(ListeCptFiltre,ListeCptNonEquilibre:TStringList):Boolean;
Var
//QueryBal:TQuery;
Equilibre:Boolean;
Begin
try//finally
 result:= true;
//QueryBal:=TQuery.Create(nil);
if DMDiocEtatBal=nil then DMDiocEtatBal:=TDMDiocEtatBal.Create(Application.MainForm);
if DMRech=nil then DMRech:=TDMRech.create(Application.MainForm);
  DMDiocEtatBal.QuEcritureBase.Close;
  DMDiocEtatBal.QuEcritureBase.ParamByName('DateDeb').AsDate:=E.DatExoDebut;
  DMDiocEtatBal.QuEcritureBase.ParamByName('DateFin').AsDate:=E.DatExoFin;
  DMDiocEtatBal.QuEcritureBase.Open;
  ListeCptNonEquilibre.Add(DMDiocEtatBal.QuEcritureBase.sql.Text);
//DMDiocEtatBal.SommeTotauxBalanceCalc(E.DatExoDebut,E.DatExoFin,ListeCptFiltre,'Compte');
//Fi
FiltrageDataSet(DMRech.TaBalanceRech,'((Debit_Base <> 0 and Debit_Base <> Null) or (Credit_Base <> 0 and Credit_Base <> Null))');
//la réquete quand elle est vide renvoie quand même un recordcount=1, alors il faut vérifier que cet enregistrement n'en ai pas un
//et que la table "DMRech.TaBalanceRech" est vide aussi
result := (DMDiocEtatBal.QuEcritureBase.RecordCount = DMRech.TaBalanceRech.RecordCount);
if not result then
result:=((DMDiocEtatBal.QuEcritureBase.RecordCount=1) and(VerifFNumeric(DMDiocEtatBal.QuEcritureBase.FindField('Compte')).VideOUZero) and(DMRech.TaBalanceRech.RecordCount=0));
if not result then exit;

DMRech.TaBalanceRech.First;
DMDiocEtatBal.QuEcritureBase.First;
while not DMRech.TaBalanceRech.Eof do
 begin
  Equilibre:=(DMRech.TaBalanceRech.FindField('Compte').AsString = DMDiocEtatBal.QuEcritureBase.FindField('Compte').AsString);
  if Equilibre then
    Equilibre:=(DMRech.TaBalanceRech.FindField('Debit_Base').AsCurrency = DMDiocEtatBal.QuEcritureBase.FindField('TotDebit').AsCurrency);
  if Equilibre then
    Equilibre:=(DMRech.TaBalanceRech.FindField('Credit_Base').AsCurrency = DMDiocEtatBal.QuEcritureBase.FindField('TotCredit').AsCurrency);
  if not Equilibre then
   begin
     if ListeCptNonEquilibre <> nil then
       ListeCptNonEquilibre.Add(DMRech.TaBalanceRech.FindField('Compte').AsString+
                                ' | '+
                                DMDiocEtatBal.QuEcritureBase.FindField('Compte').AsString+
//                                ' ## ReportD : '+
//                                DMRech.TaBalanceRech.FindField('Debit_Report').AsString+
//                                ' | '+
//                                DMDiocEtatBal.QuEcritureBase.FindField('Debit_Report').AsString+
//                                ' ## ReportC : '+
//                                DMRech.TaBalanceRech.FindField('Credit_Report').AsString+
//                                ' | '+
//                                DMDiocEtatBal.QuEcritureBase.FindField('Credit_Report').AsString+
                                ' ## BaseD : '+
                                DMRech.TaBalanceRech.FindField('Debit_Base').AsString+
                                ' | '+
                                DMDiocEtatBal.QuEcritureBase.FindField('Totdebit').AsString+
                                ' ## BaseC : '+
                                DMRech.TaBalanceRech.FindField('Credit_Base').AsString+
                                ' | '+
                                DMDiocEtatBal.QuEcritureBase.FindField('TotCredit').AsString
                                );
     result:= false;
   end;
  DMRech.TaBalanceRech.Next;
  DMDiocEtatBal.QuEcritureBase.Next;
 end;
finally
DeFiltrageDataSet(DMRech.TaBalanceRech);
ListeCptNonEquilibre.SaveToFile(e.RepertoireDossier+'ControleBalanceCpt.txt');
end;
End;


Function EditionBalance(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
  var NomFich,Chemin:String;
  var periode:TPeriode;
  var TaBalEdition:TTable;
  var i:integer;
  var deb_rep,cred_rep,
      deb_mvt,cred_mvt,
      deb_solde,cred_solde:Currency;
  var cpt1,cpt2:String;
ParamAffichPeriode:TParamAffichPeriode;

Begin

  Chemin :=E.RepertoireComptaWeb;
  NomFich:='BalanceEx';
    Initialise_ParamAffichPeriode(ParamAffichPeriode);
    periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
  if periode.Retour then begin
      if DMDiocEtatBal=nil then DMDiocEtatBal:=TDMDiocEtatBal.Create(Application.MainForm);
      if dataset = nil then begin
         // Prevu pour passer le dataset concerné
      end;

      DMDiocEtatBal.CalculSurPeriode(periode.DateDeb,periode.DateFin);
      //Création de la table temporaire
      TaBalEdition:=TTable.Create(DMDiocEtatBal);
      TaBalEdition.TableName:='BalanceEdition';
      TaBalEdition.TableType:=ttParadox;
      TaBalEdition.DatabaseName:='Exercice';
      TaBalEdition.FieldDefs.Clear;
      with TaBalEdition.FieldDefs.AddFieldDef do begin
        Name:='compte';
        DataType:=ftString;
        Size:=8;
        Required:=true;
      end;
      with TaBalEdition.FieldDefs.AddFieldDef do begin
        Name:='libelle';
        DataType:=ftString;
        Size:=100;
        Required:=true;
      end;
      with TaBalEdition.FieldDefs.AddFieldDef do begin
        Name:='debit_report';
        DataType:=ftCurrency;
        Required:=true;
      end;
      with TaBalEdition.FieldDefs.AddFieldDef do begin
        Name:='credit_report';
        DataType:=ftCurrency;
        Required:=true;
      end;
      with TaBalEdition.FieldDefs.AddFieldDef do begin
        Name:='debit_mvt';
        DataType:=ftCurrency;
        Required:=true;
      end;
      with TaBalEdition.FieldDefs.AddFieldDef do begin
        Name:='credit_mvt';
        DataType:=ftCurrency;
        Required:=true;
      end;
      with TaBalEdition.FieldDefs.AddFieldDef do begin
        Name:='debit_fin';
        DataType:=ftCurrency;
        Required:=true;
      end;
      with TaBalEdition.FieldDefs.AddFieldDef do begin
        Name:='credit_fin';
        DataType:=ftCurrency;
        Required:=true;
      end;
      TaBalEdition.CreateTable;

      //Remplissage de la table temporaire
      if TaBalEdition.Active then TaBalEdition.close;
      DeFiltrageDataSet(DMDiocEtatBal.TaBalanceCalc);
      //if DMDiocEtatBal.TaBalanceCalc.Active then DMDiocEtatBal.TaBalanceCalc.close;

      TaBalEdition.Active:=true;
      //DMDiocEtatBal.TaBalanceCalc.Active:=true;
      DMDiocEtatBal.TaBalanceCalc.First;
      deb_solde:=0;
      cred_solde:=0;
      while not DMDiocEtatBal.TaBalanceCalc.Eof do begin
          deb_rep:=DMDiocEtatBal.TaBalanceCalc.FindField('Debit_Report_calc').AsCurrency-DMDiocEtatBal.TaBalanceCalc.FindField('Credit_Report_calc').AsCurrency;
          cred_rep:=DMDiocEtatBal.TaBalanceCalc.FindField('Credit_Report_calc').AsCurrency-DMDiocEtatBal.TaBalanceCalc.FindField('Debit_Report_calc').AsCurrency;
          if deb_rep<cred_rep then
            deb_rep:=0
          else
            cred_rep:=0;

          deb_mvt:=DMDiocEtatBal.TaBalanceCalc.FindField('Debit_base_calc').AsCurrency;
          cred_mvt:=DMDiocEtatBal.TaBalanceCalc.FindField('Credit_base_calc').AsCurrency;
{ isa  le  07/10/03 }
//          deb_mvt:=DMDiocEtatBal.TaBalanceCalc.FindField('Debit_base_calc').AsCurrency-DMDiocEtatBal.TaBalanceCalc.FindField('Credit_base_calc').AsCurrency;
//          cred_mvt:=DMDiocEtatBal.TaBalanceCalc.FindField('Credit_base_calc').AsCurrency-DMDiocEtatBal.TaBalanceCalc.FindField('Debit_base_calc').AsCurrency;
//          if deb_mvt<cred_mvt then
//            deb_mvt:=0
//          else
//            cred_mvt:=0;

          deb_solde:=(DMDiocEtatBal.TaBalanceCalc.FindField('Debit_Report_calc').AsCurrency+DMDiocEtatBal.TaBalanceCalc.FindField('Debit_base_calc').AsCurrency)
                    -(DMDiocEtatBal.TaBalanceCalc.FindField('Credit_Report_calc').AsCurrency+DMDiocEtatBal.TaBalanceCalc.FindField('Credit_base_calc').AsCurrency);
          cred_solde:=(DMDiocEtatBal.TaBalanceCalc.FindField('Credit_base_calc').AsCurrency+DMDiocEtatBal.TaBalanceCalc.FindField('Credit_Report_calc').AsCurrency)
                    -(DMDiocEtatBal.TaBalanceCalc.FindField('Debit_Report_calc').AsCurrency+DMDiocEtatBal.TaBalanceCalc.FindField('Debit_base_calc').AsCurrency);
          if deb_solde<cred_solde then
            deb_solde:=0
          else
            cred_solde:=0;

          TaBalEdition.AppendRecord([
            DMDiocEtatBal.TaBalanceCalc.FindField('Compte').AsString,
            DMDiocEtatBal.TaBalanceCalc.FindField('ComptePlanCpt').AsString,
            deb_rep,
            cred_rep,
            deb_mvt,
            cred_mvt,
            deb_solde,
            cred_solde
          ]);
          DMDiocEtatBal.TaBalanceCalc.Next;      
      end;

      //choix des comptes
      DMDiocEtatBal.QuTotalG.SQL.Clear;
      DMDiocEtatBal.QuTotalG.SQL.Add('select distinct compte from balanceEdition order by compte');
      DMDiocEtatBal.QuTotalG.Open;
      Cpt1:=DMDiocEtatBal.QuTotalG.findfield('compte').AsString;
      DMDiocEtatBal.QuTotalG.Last;
      Cpt2:=DMDiocEtatBal.QuTotalG.findfield('compte').AsString;
      DMDiocEtatBal.QuTotalG.Close;

      //liste des ruptures
      DMDiocEtatBal.QuListeValRupt.SQL.Clear;
      DMDiocEtatBal.QuListeValRupt.SQL.Add('select distinct substring(compte from 1 for 1) from balanceEdition');
      DMDiocEtatBal.QuListeValRupt.SQL.Add(' where compte between '''+cpt1+''' and '''+cpt2+'''');
      DMDiocEtatBal.QuListeValRupt.Open;

      //sous total
      DMDiocEtatBal.QuSousTotal.SQL.Clear;
      DMDiocEtatBal.QuSousTotal.Params.Clear;
      DMDiocEtatBal.QuSousTotal.SQL.Add('select sum(debit_report),sum(credit_report),sum(debit_mvt),sum(credit_mvt),sum(debit_fin),sum(credit_fin) from balanceEdition where compte like :compte');
      DMDiocEtatBal.QuSousTotal.SQL.Add(' and compte between '''+cpt1+''' and '''+cpt2+'''');
      DMDiocEtatBal.QuSousTotal.Params[0].DataType := ftString;
      DMDiocEtatBal.QuSousTotal.Open;

//      DMDiocEtatBal.QuSousTotal.SQL.Clear;
//      ////////report debut
//      DMDiocEtatBal.QuSousTotal.Params.Clear;
//      DMDiocEtatBal.QuSousTotal.SQL.Add('select distinct cast(sum(b.debit_report) as numeric)+ ');
//      DMDiocEtatBal.QuSousTotal.SQL.Add('  (select cast(sum(e.debitsaisie) as numeric) ');
//      DMDiocEtatBal.QuSousTotal.SQL.Add('  from "'+E.RepertoireExercice+'Balance" b, ecriture e, piece p ');
//      DMDiocEtatBal.QuSousTotal.SQL.Add('  where e.compte=b.compte and compte like :compte and p.id=e.id_piece and p."date"<'''+DateInfos(periode.DateDeb).DatePourSQLStr+''' ');
//      DMDiocEtatBal.QuSousTotal.SQL.Add('  ) as debit_report ');
//      DMDiocEtatBal.QuSousTotal.SQL.Add(',cast(sum(b.credit_report) as numeric)+ ');
//      DMDiocEtatBal.QuSousTotal.SQL.Add('  (select cast(sum(e.Creditsaisie) as numeric) ');
//      DMDiocEtatBal.QuSousTotal.SQL.Add('  from "'+E.RepertoireExercice+'Balance" b, ecriture e, piece p ');
//      DMDiocEtatBal.QuSousTotal.SQL.Add('  where e.compte=b.compte and  compte like :compte and p.id=e.id_piece and p."date"<'''+DateInfos(periode.DateDeb).DatePourSQLStr+''' ');
//      DMDiocEtatBal.QuSousTotal.SQL.Add('  ) as credit_report ');
//      ////////mouvement
//      DMDiocEtatBal.QuSousTotal.SQL.Add(',(select sum(debitsaisie) debit_base from ecriture where compte like :compte');
//      DMDiocEtatBal.QuSousTotal.SQL.Add(' and ecriture."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''') as debit_base');
//      DMDiocEtatBal.QuSousTotal.SQL.Add(',(select sum(creditsaisie) credit_base from ecriture where compte like :compte');
//      DMDiocEtatBal.QuSousTotal.SQL.Add(' and ecriture."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''') as credit_base');
//      //////
//      DMDiocEtatBal.QuSousTotal.SQL.Add('from "'+E.RepertoireExercice+'Balance" b, ecriture e, piece p ');
//      DMDiocEtatBal.QuSousTotal.SQL.Add('where e.compte=b.compte and p.id=e.id_piece and  compte like :compte');
//      DMDiocEtatBal.QuSousTotal.Params[0].DataType := ftString;
//      DMDiocEtatBal.QuSousTotal.Open;

      //total général
      DMDiocEtatBal.QuTotalG.SQL.Clear;
      DMDiocEtatBal.QuTotalG.Params.Clear;
      DMDiocEtatBal.QuTotalG.SQL.Add('select sum(debit_report),sum(credit_report),sum(debit_mvt),sum(credit_mvt),sum(debit_fin),sum(credit_fin) from balanceEdition');
      DMDiocEtatBal.QuTotalG.SQL.Add(' where compte between '''+cpt1+''' and '''+cpt2+'''');
      DMDiocEtatBal.QuTotalG.Open;

      //total debut + periode
      DMDiocEtatBal.QuTotalG2.SQL.Clear;
      DMDiocEtatBal.QuTotalG2.Params.Clear;
      DMDiocEtatBal.QuTotalG2.SQL.Add('select sum(debit_report)+sum(debit_mvt),sum(credit_mvt)+sum(credit_report) from balanceEdition');
      DMDiocEtatBal.QuTotalG2.SQL.Add(' where compte between '''+cpt1+''' and '''+cpt2+'''');
      DMDiocEtatBal.QuTotalG2.Open;

      case TypeEdition  of
          C_EditionSimple:Begin
                              Site.lien := false;
                              //EditBalanceEx(Chemin,NomFich,TaBalEdition,'compte',DMDiocEtatBal.QuListeValRupt,DMDiocEtatBal.QuSousTotal,DMDiocEtatBal.QuTotalG,DMDiocEtatBal.QuTotalG2,cpt1,cpt2,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),Site);
                              ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                          End;
          C_EditionWeb: Begin
                            Site.lien := false;
                            //LienEditJournalPart(NomMenuSiteWeb,Chemin,NomFich,DMJournal.QuJournalPartEdition,'date',DMJournal.QuListeValRupt,DMJournal.QuSousTotal,DMJournal.QuTotalG,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),NomJournal,Site);
                            ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                        End;
      end;
      TaBalEdition.Close;
      DMDiocEtatBal.QuListeValRupt.Close;
      DMDiocEtatBal.QuSousTotal.Close;
      DMDiocEtatBal.QuTotalG.Close;
      DMDiocEtatBal.QuTotalG2.Close;
      TaBalEdition.Free;
  end;
End;

Function EditionBalanceL(TypeEdition : integer; DemandePeriode:Boolean; ListeCompte:TStringList;DataSet:TDataSet;Regrouper:integer):Boolean;
  var NomFich,Chemin:String;
  var periode:TPeriode;

EtatFiltre:TEtatFiltre;
ListeValeur,LigneEdition:TStringList;
ObjPrn:TObjetEdition;
ParamAffichPeriode:TParamAffichPeriode;
ClasseCompteTmp:String;
CompteRegroupe:String;
// Variable des totaux généraux par classes de compte
TotalReportDebit,TotalReportCredit,TotalBaseDebit,
TotalBaseCredit,TotalFinDebit,TotalFinCredit:Currency;

// Variable des totaux des comptes regroupés
RegReportDebit,RegReportCredit,RegBaseDebit,
RegBaseCredit,RegFinDebit,RegFinCredit:Currency;

// Variable des totaux généraux par classes de compte 6
TotalFinDebitResultat,TotalFinCreditResultat:Currency;
TotalFinDebitResultat6,TotalFinCreditResultat6:Currency;
TotalFinDebitResultat7,TotalFinCreditResultat7:Currency;
//TotalFinResultat6,TotalFinResultat7:currency;
// Variable des totaux généraux
TotalReportDebitG,TotalReportCreditG,TotalBaseDebitG,
TotalBaseCreditG,TotalFinDebitG,TotalFinCreditG:Currency;

Begin
try
      ObjPrn:=TObjetEdition.Create(application.MainForm);
  Chemin :=E.RepertoireComptaWeb;
  NomFich:='BalanceEx';
  if DemandePeriode then
    begin
    Initialise_ParamAffichPeriode(ParamAffichPeriode);
    periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
    end
   else
    begin
     periode.Retour := true;
     periode.DateDeb := E.DatExoDebut;
     periode.DateFin := E.DatExoFin;
    end;
if periode.DateDeb<e.DatExoDebut then
  begin
      periode.Retour:=false;
      showmessage(AccesProcedureRefuse_SurDate);
  end;

  if periode.Retour then
  begin
      ListeValeur:=TStringList.Create;
      LigneEdition:=TStringList.Create;
      ObjPrn.FontLigneSeule.Style := [fsBold];

      if DMDiocEtatBal=nil then DMDiocEtatBal:=TDMDiocEtatBal.Create(Application.MainForm);
      if DMEcritures = nil then DMEcritures:=TDMEcritures.Create(Application.MainForm);

      DMDiocEtatBal.PeriodeExercice := ((periode.DateDeb=E.DatExoDebut) and (periode.DateFin = E.DatExoFin));

      DMEcritures.TaEcritureBal.DisableControls;
      TableSauveEtatFiltre(DMEcritures.TaEcritureBal,EtatFiltre);
      DeFiltrageDataSet(DMEcritures.TaEcritureBal);
      DMEcritures.TaEcritureBal.MasterSource :=  DMDiocEtatBal.DaTaBalanceCalc;

      if dataset = nil then begin
         // Prevu pour passer le dataset concerné
      end;
      DMDiocEtatBal.QuEcritureReport.Close;
      DMDiocEtatBal.QuEcritureBase.Close;

      DMDiocEtatBal.CalculSurPeriode(periode.DateDeb,periode.DateFin);
      DeFiltrageDataSet(DMDiocEtatBal.TaBalanceCalc);

      if ListeCompte = nil then ListeCompte:=ChampTableVersListe('Compte',DMDiocEtatBal.TaBalanceCalc);
      DMDiocEtatBal.ListeFiltreEdit.Assign(ListeCompte);

      DMDiocEtatBal.TaBalanceCalc.Filtered := true;
      DMDiocEtatBal.TaBalanceCalc.OnFilterRecord:=DMDiocEtatBal.TaBalanceCalcFilterRecord;
      TableRefreshSurClose(DMDiocEtatBal.TaBalanceCalc,'Compte');
      DMDiocEtatBal.TaBalanceCalc.First;

      if DMDiocEtatBal.TaBalanceCalc.recordcount<> 0 then
         begin
         CompteRegroupe := copy(DMDiocEtatBal.TaBalanceCalc.FindField('Compte').AsString,1,Regrouper);
          while not DMDiocEtatBal.TaBalanceCalc.Eof do
           begin
            ClasseCompteTmp :=DMDiocEtatBal.TaBalanceCalc.FindField('Compte').AsString;
            TotalReportDebit := DMDiocEtatBal.TaBalanceCalc.FindField('Solde_Debit_Report_Calc').AsCurrency + TotalReportDebit;
            TotalReportCredit := DMDiocEtatBal.TaBalanceCalc.FindField('Solde_Credit_Report_Calc').AsCurrency + TotalReportCredit;
            TotalBaseDebit := DMDiocEtatBal.TaBalanceCalc.FindField('Debit_Base_Calc').AsCurrency + TotalBaseDebit;
            TotalBaseCredit := DMDiocEtatBal.TaBalanceCalc.FindField('Credit_Base_Calc').AsCurrency + TotalBaseCredit;
            TotalFinDebit := DMDiocEtatBal.TaBalanceCalc.FindField('Solde_Debit_Total_Calc').AsCurrency + TotalFinDebit;
            TotalFinCredit := DMDiocEtatBal.TaBalanceCalc.FindField('Solde_Credit_Total_Calc').AsCurrency + TotalFinCredit;

            RegReportDebit := DMDiocEtatBal.TaBalanceCalc.FindField('Solde_Debit_Report_Calc').AsCurrency + RegReportDebit;
            RegReportCredit := DMDiocEtatBal.TaBalanceCalc.FindField('Solde_Credit_Report_Calc').AsCurrency + RegReportCredit;
            RegBaseDebit := DMDiocEtatBal.TaBalanceCalc.FindField('Debit_Base_Calc').AsCurrency + RegBaseDebit;
            RegBaseCredit := DMDiocEtatBal.TaBalanceCalc.FindField('Credit_Base_Calc').AsCurrency + RegBaseCredit;
            RegFinDebit := DMDiocEtatBal.TaBalanceCalc.FindField('Solde_Debit_Total_Calc').AsCurrency + RegFinDebit;
            RegFinCredit := DMDiocEtatBal.TaBalanceCalc.FindField('Solde_Credit_Total_Calc').AsCurrency + RegFinCredit;
            if(Regrouper=0) or (Regrouper=8)then
             ListeValeur.Add('0'+
                             ';'+
                             GereLibelle(DMDiocEtatBal.TaBalanceCalc.FindField('Compte').AsString)+
                             ';'+
                             GereLibelle(DMDiocEtatBal.TaBalanceCalc.FindField('ComptePlanCpt').AsString)+
                             ';'+
                             E.FormatCurrSansDevise(DMDiocEtatBal.TaBalanceCalc.FindField('Solde_Debit_Report_Calc').AsCurrency)+
                             ';'+
                             E.FormatCurrSansDevise(DMDiocEtatBal.TaBalanceCalc.FindField('Solde_Credit_Report_Calc').AsCurrency)+
                             ';'+
                             E.FormatCurrSansDevise(DMDiocEtatBal.TaBalanceCalc.FindField('Debit_Base_Calc').AsCurrency)+
                             ';'+
                             E.FormatCurrSansDevise(DMDiocEtatBal.TaBalanceCalc.FindField('Credit_Base_Calc').AsCurrency)+
                             ';'+
                             E.FormatCurrSansDevise(DMDiocEtatBal.TaBalanceCalc.FindField('Solde_Debit_Total_Calc').AsCurrency)+
                             ';'+
                             E.FormatCurrSansDevise(DMDiocEtatBal.TaBalanceCalc.FindField('Solde_Credit_Total_Calc').AsCurrency)
                             );

    //         EditionEcritureL(0,C_TypeEditionLigneSimple,false,DMDiocEtatBal.TaBalanceCalc.FindField('Compte').AsString,LigneEdition,nil,Site);
    //         ListeValeur.AddStrings(LigneEdition);

             DMDiocEtatBal.TaBalanceCalc.Next;
             if(Regrouper>0) and (Regrouper<8)then
             if (copy(CompteRegroupe,1,Regrouper) <> copy(DMDiocEtatBal.TaBalanceCalc.FindField('Compte').AsString,1,Regrouper))or(DMDiocEtatBal.TaBalanceCalc.eof) then
              begin
             DetermineSolde(RegReportDebit,RegReportCredit);
            // DetermineSolde(RegBaseDebit,RegBaseCredit); //il ne faut pas le faire celui_là
             DetermineSolde(RegFinDebit,RegFinCredit);
             ListeValeur.Add('0'+
                             ';'+
                             GereLibelle(CompteRegroupe)+
                             ';'+
                             GereLibelle(DMPlan.LibelleDuNumCpt(CompteRegroupe))+
                             ';'+
                               E.FormatCurrSansDevise(RegReportDebit)+
                               ';'+
                               E.FormatCurrSansDevise(RegReportCredit)+
                               ';'+
                               E.FormatCurrSansDevise(RegBaseDebit)+
                               ';'+
                               E.FormatCurrSansDevise(RegBaseCredit)+
                               ';'+
                               E.FormatCurrSansDevise(RegFinDebit)+
                               ';'+
                               E.FormatCurrSansDevise(RegFinCredit));
               CompteRegroupe := copy(DMDiocEtatBal.TaBalanceCalc.FindField('Compte').AsString,1,Regrouper);
               RegReportDebit:=0;
               RegReportCredit:=0;
               RegBaseDebit:=0;
               RegBaseCredit:=0;
               RegFinDebit:=0;
               RegFinCredit:=0;
             end;
             if copy(ClasseCompteTmp,1,1) <> copy(DMDiocEtatBal.TaBalanceCalc.FindField('Compte').AsString,1,1) then
              begin
           listeValeur.Add('16');
               ListeValeur.Add('3;; @TOTAL CLASSE '+copy(ClasseCompteTmp,1,1)+' : ;'+
                               E.FormatCurrSansDevise(TotalReportDebit)+
                               ';'+
                               E.FormatCurrSansDevise(TotalReportCredit)+
                               ';'+
                               E.FormatCurrSansDevise(TotalBaseDebit)+
                               ';'+
                               E.FormatCurrSansDevise(TotalBaseCredit)+
                               ';'+
                               E.FormatCurrSansDevise(TotalFinDebit)+
                               ';'+
                               E.FormatCurrSansDevise(TotalFinCredit));
              TotalReportDebitG := TotalReportDebitG + TotalReportDebit;
              TotalReportCreditG := TotalReportCreditG + TotalReportCredit;
              TotalBaseDebitG :=TotalBaseDebitG + TotalBaseDebit;
              TotalBaseCreditG :=TotalBaseCreditG + TotalBaseCredit;
              TotalFinDebitG := TotalFinDebitG + TotalFinDebit;
              TotalFinCreditG := TotalFinCreditG + TotalFinCredit;

              DetermineSolde(TotalReportDebit,TotalReportCredit);
              DetermineSolde(TotalBaseDebit,TotalBaseCredit);
              DetermineSolde(TotalFinDebit,TotalFinCredit);
               ListeValeur.Add('1;; @Solde classe '+copy(ClasseCompteTmp,1,1)+' : ;'+
                               E.FormatCurrSansDevise(TotalReportDebit)+
                               ';'+
                               E.FormatCurrSansDevise(TotalReportCredit)+
                               ';'+
                               E.FormatCurrSansDevise(TotalBaseDebit)+
                               ';'+
                               E.FormatCurrSansDevise(TotalBaseCredit)+
                               ';'+
                               E.FormatCurrSansDevise(TotalFinDebit)+
                               ';'+
                               E.FormatCurrSansDevise(TotalFinCredit));
//           if str_commence_par(ClasseCompteTmp,'6') then
//              begin
//                  TotalFinDebitResultat:=TotalFinDebit;
//                  TotalFinCreditResultat:=TotalFinCredit;
//              end;

//           if str_commence_par(ClasseCompteTmp,'7') then
//              begin
//                  TotalFinDebitResultat:=TotalFinDebit;
//                  TotalFinCreditResultat:=TotalFinCredit;
//              end;

           if str_commence_par(ClasseCompteTmp,'6') then
              begin
                  TotalFinDebitResultat6:=TotalFinDebit;
                  TotalFinCreditResultat6:=TotalFinCredit;
              end;

           if str_commence_par(ClasseCompteTmp,'7') then
              begin
                  TotalFinDebitResultat7:=TotalFinDebit;
                  TotalFinCreditResultat7:=TotalFinCredit;
              end;


              TotalReportDebit := 0;
              TotalReportCredit := 0;
              TotalBaseDebit := 0;
              TotalBaseCredit := 0;
              TotalFinDebit := 0;
              TotalFinCredit := 0;
              ClasseCompteTmp :=DMDiocEtatBal.TaBalanceCalc.FindField('Compte').AsString;
              end;
          end;
           // Pour la dernière classe
           listeValeur.Add('16');
           ListeValeur.Add('3;; @TOTAL CLASSE '+copy(ClasseCompteTmp,1,1)+' : ;'+
                           E.FormatCurrSansDevise(TotalReportDebit)+
                           ';'+
                           E.FormatCurrSansDevise(TotalReportCredit)+
                           ';'+
                           E.FormatCurrSansDevise(TotalBaseDebit)+
                           ';'+
                           E.FormatCurrSansDevise(TotalBaseCredit)+
                           ';'+
                           E.FormatCurrSansDevise(TotalFinDebit)+
                           ';'+
                           E.FormatCurrSansDevise(TotalFinCredit));

            TotalReportDebitG := TotalReportDebitG + TotalReportDebit;
            TotalReportCreditG := TotalReportCreditG + TotalReportCredit;
            TotalBaseDebitG :=TotalBaseDebitG + TotalBaseDebit;
            TotalBaseCreditG :=TotalBaseCreditG + TotalBaseCredit;
            TotalFinDebitG := TotalFinDebitG + TotalFinDebit;
            TotalFinCreditG := TotalFinCreditG + TotalFinCredit;

              DetermineSolde(TotalReportDebit,TotalReportCredit);
              DetermineSolde(TotalBaseDebit,TotalBaseCredit);
              DetermineSolde(TotalFinDebit,TotalFinCredit);
               ListeValeur.Add('1;; @Solde classe '+copy(ClasseCompteTmp,1,1)+' : ;'+
                               E.FormatCurrSansDevise(TotalReportDebit)+
                               ';'+
                               E.FormatCurrSansDevise(TotalReportCredit)+
                               ';'+
                               E.FormatCurrSansDevise(TotalBaseDebit)+
                               ';'+
                               E.FormatCurrSansDevise(TotalBaseCredit)+
                               ';'+
                               E.FormatCurrSansDevise(TotalFinDebit)+
                               ';'+
                               E.FormatCurrSansDevise(TotalFinCredit));


           if str_commence_par(ClasseCompteTmp,'6') then
              begin
                  TotalFinDebitResultat6:=TotalFinDebit;
                  TotalFinCreditResultat6:=TotalFinCredit;
              end;

           if str_commence_par(ClasseCompteTmp,'7') then
              begin
                  TotalFinDebitResultat7:=TotalFinDebit;
                  TotalFinCreditResultat7:=TotalFinCredit;
              end;

           // Totaux Généraux
           listeValeur.Add('16');
           ListeValeur.Add('3;; @TOTAUX : ;'+
                           E.FormatCurrSansDevise(TotalReportDebitG)+
                           ';'+
                           E.FormatCurrSansDevise(TotalReportCreditG)+
                           ';'+
                           E.FormatCurrSansDevise(TotalBaseDebitG)+
                           ';'+
                           E.FormatCurrSansDevise(TotalBaseCreditG)+
                           ';'+
                           E.FormatCurrSansDevise(TotalFinDebitG)+
                           ';'+
                           E.FormatCurrSansDevise(TotalFinCreditG));



           // Soldes Généraux
           // Calcul des soldes
           DetermineSolde(TotalReportDebitG,TotalReportCreditG);
           DetermineSolde(TotalBaseDebitG,TotalBaseCreditG);
           DetermineSolde(TotalFinDebitG,TotalFinCreditG);

           ListeValeur.Add('1;; @Soldes : ;'+
                           E.FormatCurrSansDevise(TotalReportDebitG)+
                           ';'+
                           E.FormatCurrSansDevise(TotalReportCreditG)+
                           ';'+
                           E.FormatCurrSansDevise(TotalBaseDebitG)+
                           ';'+
                           E.FormatCurrSansDevise(TotalBaseCreditG)+
                           ';'+
                           E.FormatCurrSansDevise(TotalFinDebitG)+
                           ';'+
                           E.FormatCurrSansDevise(TotalFinCreditG));

//           DetermineSolde(TotalFinDebitResultat,TotalFinCreditResultat);
           TotalFinDebitResultat:=(TotalFinDebitResultat6+TotalFinDebitResultat7);
           TotalFinCreditResultat:=(TotalFinCreditResultat6+TotalFinCreditResultat7);
           DetermineSolde(TotalFinDebitResultat,TotalFinCreditResultat);
           if(TotalFinDebitResultat<>0)or (TotalFinCreditResultat<>0)then
             begin //si résultat différent de 0
               if (TotalFinCreditResultat>TotalFinDebitResultat)then
               ListeValeur.Add('1;; @Résultat positif pour la période : ;;;; ;'+
                               E.FormatCurrSansDevise(TotalFinDebitResultat)+
                               ';'+
                               E.FormatCurrSansDevise(TotalFinCreditResultat))
               else
               ListeValeur.Add('1;; @Résultat négatif pour la période : ;;;; ;'+
                               E.FormatCurrSansDevise(TotalFinDebitResultat)+
                               ';'+
                               E.FormatCurrSansDevise(TotalFinCreditResultat));
             end//fin si résultat différent de 0
             else ListeValeur.Add('1;; @Résultat nul pour la période : ;;;; ;'+
                               E.FormatCurrSansDevise(0)+
                               ';'+
                               E.FormatCurrSansDevise(0));
         ObjPrn.FTitreEdition := 'BALANCE COMPTES DE L''EXERCICE';
         ObjPrn.FTitre2Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;
         ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
         ListeValeur.Insert(0,' Compte ; Désignation ; Débit ; Crédit ; Débit ; Crédit ; Débit ; Crédit ');
         ListeValeur.Insert(1,'0.6;2;0.8;0.8;0.8;0.8;0.8;0.8');
         ListeValeur.Insert(2,'texte;texte;curr;curr;curr;curr;curr;curr');
         ListeValeur.Insert(3,'  ; Report Début ; Mouvement ; Solde Fin ;SURTITRE');
         ListeValeur.Insert(4,'2.6;1.6;1.6;1.6');
    //     ListeValeur.Add('1;;Tiers : '+CompteDeTiers+';;;; TOTAL MVT ;'+CurrToStr(TotalMouvementCreance) +';'+CurrToStr(TotalMouvementDette));
         end;//s'il y a des écritures à imprimer
     ObjPrn.AffichageImp(ListeValeur);
//     ListeValeur.SaveToFile('c:\Balance.txt');
//      case TypeEdition  of
//          C_EditionSimple:Begin
//                              Site.lien := false;
//                              EditBalanceEx(Chemin,NomFich,TaBalEdition,'compte',DMDiocEtatBal.QuListeValRupt,DMDiocEtatBal.QuSousTotal,DMDiocEtatBal.QuTotalG,DMDiocEtatBal.QuTotalG2,cpt1,cpt2,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),Site);
//                              ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
//                          End;
//          C_EditionWeb: Begin
//                            Site.lien := false;
//                            //LienEditJournalPart(NomMenuSiteWeb,Chemin,NomFich,DMJournal.QuJournalPartEdition,'date',DMJournal.QuListeValRupt,DMJournal.QuSousTotal,DMJournal.QuTotalG,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),NomJournal,Site);
//                            ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
//                        End;
      end;
Finally
  DMDiocEtatBal.TaBalanceCalc.OnFilterRecord:=nil;
  DeFiltrageDataSet(DMDiocEtatBal.TaBalanceCalc);
  TableRestoreEtatFiltre(DMEcritures.TaEcritureBal,EtatFiltre);
  DMEcritures.TaEcritureBal.MasterSource := DMDiocEtatBal.DaBalance;
  ReEnableControls(DMEcritures.TaEcritureBal);
  LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;
End;



procedure TDMDiocEtatBal.TaBalanceaffichCalcFields(DataSet: TDataSet);
begin
try
// Calcul du report
if QuEcritureReport.locate('Compte',TaBalanceaffichCompte.AsString,[]) then
 begin
  TaBalanceaffichDebit_Report_Calc.AsCurrency:=0+TaBalanceaffichDebit_Report.AsCurrency+QuEcritureReportTotDebit.AsCurrency;
//  TaBalanceaffichDebit_report_Query.AsCurrency;
  TaBalanceaffichCredit_Report_Calc.AsCurrency:=0+TaBalanceaffichCredit_Report.AsCurrency+QuEcritureReportTotCredit.AsCurrency;
  //TaBalanceaffichCredit_report_Query.AsCurrency;

 end
 else
 Begin
  TaBalanceaffichDebit_Report_Calc.AsCurrency:=0+TaBalanceaffichDebit_Report.AsCurrency;
  TaBalanceaffichCredit_Report_Calc.AsCurrency:=0+TaBalanceaffichCredit_Report.AsCurrency;
 End;


// Calcul des Solde Report
TaBalanceaffichSolde_Debit_Report_Calc.AsCurrency:=0;
TaBalanceaffichSolde_Credit_Report_Calc.AsCurrency:=0;
if TaBalanceaffichDebit_Report_Calc.AsCurrency - TaBalanceaffichCredit_Report_Calc.AsCurrency > 0 then
 Begin
   TaBalanceaffichSolde_Debit_Report_Calc.AsCurrency:=TaBalanceaffichDebit_Report_Calc.AsCurrency - TaBalanceaffichCredit_Report_Calc.AsCurrency;
 End
 else
 Begin
  TaBalanceaffichSolde_Credit_Report_Calc.AsCurrency:=TaBalanceaffichCredit_Report_Calc.AsCurrency-TaBalanceaffichDebit_Report_Calc.AsCurrency;
 End;


 // Calcul de totaux Base (mouvement de l'année)
TaBalanceaffichDebit_Base_Calc.AsCurrency:=0+TaBalanceaffichDebit_Base_QueryBase.AsCurrency;
TaBalanceaffichCredit_Base_Calc.AsCurrency:=0+TaBalanceaffichCredit_Base_QueryBase.AsCurrency;

// Calcul des Solde Base (solde des mouvement de l'année)

TaBalanceaffichSolde_Debit_Base_Calc.AsCurrency:=0;
TaBalanceaffichSolde_Credit_Base_Calc.AsCurrency:=0;
if TaBalanceaffichDebit_Base_Calc.AsCurrency - TaBalanceaffichCredit_Base_Calc.AsCurrency > 0 then
 Begin
   TaBalanceaffichSolde_Debit_Base_Calc.AsCurrency:=TaBalanceaffichDebit_Base_Calc.AsCurrency - TaBalanceaffichCredit_Base_Calc.AsCurrency;
 End
 else
 Begin
  TaBalanceaffichSolde_Credit_Base_Calc.AsCurrency:=TaBalanceaffichCredit_Base_Calc.AsCurrency-TaBalanceaffichDebit_Base_Calc.AsCurrency;
 End;

// Calcul Totaux Total
TaBalanceaffichDebit_Total_Calc.AsCurrency:=TaBalanceaffichDebit_Report_Calc.AsCurrency+TaBalanceaffichDebit_Base_Calc.AsCurrency;
TaBalanceaffichCredit_Total_Calc.AsCurrency:=TaBalanceaffichCredit_Report_Calc.AsCurrency+TaBalanceaffichCredit_Base_Calc.AsCurrency;

// Calcul des Solde Totaux
TaBalanceaffichSolde_Debit_Total_Calc.AsCurrency:=0;
TaBalanceaffichSolde_Credit_Total_Calc.AsCurrency:=0;

if TaBalanceaffichDebit_Total_Calc.AsCurrency - TaBalanceaffichCredit_Total_Calc.AsCurrency > 0 then
 Begin
   TaBalanceaffichSolde_Debit_Total_Calc.AsCurrency:=TaBalanceaffichDebit_Total_Calc.AsCurrency - TaBalanceaffichCredit_Total_Calc.AsCurrency;
 End
 else
 Begin
  TaBalanceaffichSolde_Credit_Total_Calc.AsCurrency:=TaBalanceaffichCredit_Total_Calc.AsCurrency-TaBalanceaffichDebit_Total_Calc.AsCurrency;
 End;
except
 showmessage('Erreur sur calcul balance');
end;
end;

Procedure TDMDiocEtatBal.CalculSurPeriode(DateDeb,DateFin:TDate);
Begin
if DateDeb < E.DatExoDebut then
 begin
//  MessageDlg('DMDiocEtatBal.CalculSurPeriode : La date de début de période est antérieure à la date de début '+#13+#10+'d''exercice.', mtWarning, [mbOK], 0);
//  DateDeb := E.DatExoDebut;
 end;
//QuEcritureReport.Close;
QuEcritureReport.ParamByName('DateDeb').AsDate:=E.DatExoDebut;
QuEcritureReport.ParamByName('DateFin').AsDate:=DateDeb;
QuEcritureReport.Open;

//QuEcritureBase.Close;
QuEcritureBase.ParamByName('DateDeb').AsDate:=DateDeb;
QuEcritureBase.ParamByName('DateFin').AsDate:=DateFin;
QuEcritureBase.Open;


if not TaBalanceaffich.Active then TaBalanceaffich.open;
TaBalanceaffich.Refresh;

End;





Function TDMDiocEtatBal.SommeTotauxBalance(DateDeb,DateFin:TDate;ListeFiltre:TStringList;ChampFiltre:String):TTotauxBalance;
Begin
QuEcritureReport.close;
QuEcritureBase.close;
TaBalanceaffich.DisableControls;
CalculSurPeriode(DateDeb,DateFin);
InitialiseTotauxBalance(result);
//TaBalanceaffich.Filter:='';
TaBalanceaffich.Filtered:=true;

TaBalanceaffich.Open;
TaBalanceaffich.First;
//if ListeFiltre <> nil then
// Begin
// if ListeFiltre.Count > 0 then
//  begin
//    TaBalanceaffich.Filter:=CreeFiltreOU(ChampFiltre,[ListeFiltre]);
//    TaBalanceaffich.Filtered:=true;
//  end;
// End;

while not TaBalanceaffich.EOF do
      Begin
       Result.TotalDebitReport:=Result.TotalDebitReport+TaBalanceaffich.FindField('Debit_report_calc').AsCurrency;
       Result.TotalCreditReport:=Result.TotalCreditReport+TaBalanceaffich.FindField('credit_report_calc').AsCurrency;

       //Calcul des soldes
       Result.TotalSoldeDebitReport:=Result.TotalSoldeDebitReport+TaBalanceaffich.FindField('Solde_Debit_Report_Calc').AsCurrency;
       Result.TotalSoldeCreditReport:=Result.TotalSoldeCreditReport+TaBalanceaffich.FindField('Solde_Credit_Report_Calc').AsCurrency;

       Result.TotalDebitBase:=Result.TotalDebitBase+TaBalanceaffich.FindField('debit_Base_calc').AsCurrency;
       Result.TotalCreditBase:=Result.TotalCreditBase+TaBalanceaffich.FindField('Credit_Base_calc').AsCurrency;

       Result.TotalDebitFin:=Result.TotalDebitBase+Result.TotalDebitReport;
       Result.TotalCreditFin:=Result.TotalCreditBase+Result.TotalCreditReport;

       Result.TotalDebitFin:=Result.TotalDebitBase+Result.TotalDebitReport;
       Result.TotalCreditFin:=Result.TotalCreditBase+Result.TotalCreditReport;

       //Calcul des soldes
       Result.TotalSoldeDebitTotal:=Result.TotalSoldeDebitTotal+TaBalanceaffich.FindField('Solde_Debit_Total_Calc').AsCurrency;
       Result.TotalSoldeCreditTotal:=Result.TotalSoldeCreditTotal+TaBalanceaffich.FindField('Solde_Credit_Total_Calc').AsCurrency;

       TaBalanceaffich.Next;
      End;
 Result.SoldeReport:=Result.TotalSoldeDebitReport-Result.TotalSoldeCreditReport;
 Result.SoldeBase:=Result.TotalDebitBase-Result.TotalCreditBase;
 Result.SoldeFin:=Result.TotalSoldeDebitTotal-Result.TotalSoldeCreditTotal;
 if Result.SoldeReport > 0 then
    begin
     Result.SoldeDebitCreditReport:=true;
    end
    else
    begin
     Result.SoldeDebitCreditReport:=False;
    end;
 if Result.SoldeBase > 0 then
    begin
     Result.SoldeDebitCreditBase:=true;
    end
    else
    begin
     Result.SoldeDebitCreditBase:=false;
    end;
 if Result.SoldeFin > 0 then
    begin
     Result.SoldeDebitCreditFin:=true;
    end
    else
    begin
      Result.SoldeDebitCreditFin:=false;
    end;
//Dataset.GotoBookmark(TempBookmark);
//Dataset.FreeBookmark(TempBookmark);
TaBalanceaffich.EnableControls;
end;

procedure TDMDiocEtatBal.DMDiocEtatBalCreate(Sender: TObject);
begin
 PeriodeExercice:=false;
 ListeFiltreAffich:=TStringList.Create;
 ListeFiltreEdit := TStringList.Create;
 self.tag:=1;  //SIMULE

 TaBalanceCalc.OnFilterRecord:=nil;
 TaBalanceaffich.OnCalcFields:=nil;

if DMEcritures <> nil then
DMEcritures.TaEcritureBal.Open
else
begin
 DMEcritures:=TDMEcritures.Create(Application.MainForm);
 DMEcritures.TaEcritureBal.Open;
end;

OuvrirTouteTable('',TControl(self));
//TaBalanceaffich.Open;
//QuEcritureReport.Open;
//QuEcritureBase.Open;

TaBalanceaffich.OnCalcFields:=TaBalanceaffichCalcFields;
//
TCurrencyField(TaBalanceaffich.FindField('Solde_Debit_Report_Calc')).DisplayFormat:=E.FormatMonnaie;
TCurrencyField(TaBalanceaffich.FindField('Solde_Credit_Report_Calc')).DisplayFormat:=E.FormatMonnaie;
TCurrencyField(TaBalanceaffich.FindField('Debit_Base_Calc')).DisplayFormat:=E.FormatMonnaie;
TCurrencyField(TaBalanceaffich.FindField('Credit_Base_Calc')).DisplayFormat:=E.FormatMonnaie;
TCurrencyField(TaBalanceaffich.FindField('Solde_Debit_Total_Calc')).DisplayFormat:=E.FormatMonnaie;
TCurrencyField(TaBalanceaffich.FindField('Solde_Credit_Total_Calc')).DisplayFormat:=E.FormatMonnaie;


end;

procedure TDMDiocEtatBal.TaBalanceaffichBeforeOpen(DataSet: TDataSet);
begin
OuvreTables('',[TaPlanCpt,QuEcritureReport,QuEcritureBase]);
if not QuEcritureReport.Active then QuEcritureReport.Open;
if not QuEcritureBase.Active then QuEcritureBase.Open;
end;

procedure TDMDiocEtatBal.TaBalanceCalcCalcFields(DataSet: TDataSet);
var
Qte1Tmp,Qte2Tmp:real;
begin
  if PeriodeExercice then
   begin//si calcul sur bornes exercice
    try
    // Calcul du report
      TaBalanceCalcDebit_Report_Calc.AsCurrency:=0+TaBalanceCalcDebit_Report.AsCurrency;
      TaBalanceCalcCredit_Report_Calc.AsCurrency:=0+TaBalanceCalcCredit_Report.AsCurrency;
//      //quantite
      TaBalanceCalcQt1_Report_Calc.AsCurrency:=0+TaBalanceCalcQt1_Report.AsCurrency;
      TaBalanceCalcQt2_Report_Calc.AsCurrency:=0+TaBalanceCalcQt2_Report.AsCurrency;
    // Calcul des Soldes Report
    TaBalanceCalcSolde_Debit_Report_Calc.AsCurrency:=0;
    TaBalanceCalcSolde_Credit_Report_Calc.AsCurrency:=0;
    if TaBalanceCalcDebit_Report_Calc.AsCurrency - TaBalanceCalcCredit_Report_Calc.AsCurrency > 0 then
     Begin
       TaBalanceCalcSolde_Debit_Report_Calc.AsCurrency:=TaBalanceCalcDebit_Report_Calc.AsCurrency - TaBalanceCalcCredit_Report_Calc.AsCurrency;
     End
     else
     Begin
      TaBalanceCalcSolde_Credit_Report_Calc.AsCurrency:=TaBalanceCalcCredit_Report_Calc.AsCurrency-TaBalanceCalcDebit_Report_Calc.AsCurrency;
     End;


     // Calcul de totaux Base (mouvement de l'année)
    TaBalanceCalcDebit_Base_Calc.AsCurrency:=0+TaBalanceCalcDebit_Base.AsCurrency;
    TaBalanceCalcCredit_Base_Calc.AsCurrency:=0+TaBalanceCalcCredit_Base.AsCurrency;
    //Quantite
      TaBalanceCalcQt1_Base_Calc.AsCurrency:=0+TaBalanceCalcQt1_Base.AsCurrency;
      TaBalanceCalcQt2_Base_Calc.AsCurrency:=0+TaBalanceCalcQt2_Base.AsCurrency;
//
    // Calcul des Solde Base (solde des mouvement de l'année)

    TaBalanceCalcSolde_Debit_Base_Calc.AsCurrency:=0;
    TaBalanceCalcSolde_Credit_Base_Calc.AsCurrency:=0;
    if TaBalanceCalcDebit_Base_Calc.AsCurrency - TaBalanceCalcCredit_Base_Calc.AsCurrency > 0 then
     Begin
       TaBalanceCalcSolde_Debit_Base_Calc.AsCurrency:=TaBalanceCalcDebit_Base_Calc.AsCurrency - TaBalanceCalcCredit_Base_Calc.AsCurrency;
     End
     else
     Begin
      TaBalanceCalcSolde_Credit_Base_Calc.AsCurrency:=TaBalanceCalcCredit_Base_Calc.AsCurrency-TaBalanceCalcDebit_Base_Calc.AsCurrency;
     End;

    // Calcul Totaux Total
    TaBalanceCalcDebit_Total_Calc.AsCurrency:=TaBalanceCalcDebit_Report_Calc.AsCurrency+TaBalanceCalcDebit_Base_Calc.AsCurrency;
    TaBalanceCalcCredit_Total_Calc.AsCurrency:=TaBalanceCalcCredit_Report_Calc.AsCurrency+TaBalanceCalcCredit_Base_Calc.AsCurrency;
//    //quantite
     TaBalanceCalcQt1_Total_Calc.AsCurrency:=TaBalanceCalcQt1_Report_Calc.AsCurrency+TaBalanceCalcQt1_Base_Calc.AsCurrency;
     TaBalanceCalcQt2_Total_Calc.AsCurrency:=TaBalanceCalcQt2_Report_Calc.AsCurrency+TaBalanceCalcQt2_Base_Calc.AsCurrency;
    TaBalanceCalcSolde_Qt1_Total_Calc.AsCurrency:=TaBalanceCalcQt1_Total_Calc.AsCurrency;
    TaBalanceCalcSolde_Qt2_Total_Calc.AsCurrency:=TaBalanceCalcQt2_Total_Calc.AsCurrency;
    // Calcul des Solde Totaux
    TaBalanceCalcSolde_Debit_Total_Calc.AsCurrency:=0;
    TaBalanceCalcSolde_Credit_Total_Calc.AsCurrency:=0;

    if TaBalanceCalcDebit_Total_Calc.AsCurrency - TaBalanceCalcCredit_Total_Calc.AsCurrency > 0 then
     Begin
       TaBalanceCalcSolde_Debit_Total_Calc.AsCurrency:=TaBalanceCalcDebit_Total_Calc.AsCurrency - TaBalanceCalcCredit_Total_Calc.AsCurrency;
     End
     else
     Begin
      TaBalanceCalcSolde_Credit_Total_Calc.AsCurrency:=TaBalanceCalcCredit_Total_Calc.AsCurrency-TaBalanceCalcDebit_Total_Calc.AsCurrency;
     End;
    except
     showmessage('Erreur sur calcul des reports');
    end;
   end //fin si calcul sur bornes exercice
  else
   begin//si calcul periode particulière
    try
    // Calcul du report
    if QuEcritureReport.locate('Compte',TaBalanceCalcCompte.AsString,[]) then
     begin
      TaBalanceCalcDebit_Report_Calc.AsCurrency:=0+TaBalanceCalcDebit_Report.AsCurrency+QuEcritureReportTotDebit.AsCurrency;
      TaBalanceCalcCredit_Report_Calc.AsCurrency:=0+TaBalanceCalcCredit_Report.AsCurrency+QuEcritureReportTotCredit.AsCurrency;
//      //quantite
      //qte1
      TaBalanceCalcQt1_Report_Calc.AsCurrency:=0+TaBalanceCalcQt1_Report.AsCurrency+QuEcritureReportTotQt1.AsCurrency;
      //qte2
      TaBalanceCalcQt2_Report_Calc.AsCurrency:=0+TaBalanceCalcQt2_Report.AsCurrency+QuEcritureReportTotQt2.AsCurrency;
     end
     else
     Begin
      TaBalanceCalcDebit_Report_Calc.AsCurrency:=0+TaBalanceCalcDebit_Report.AsCurrency;
      TaBalanceCalcCredit_Report_Calc.AsCurrency:=0+TaBalanceCalcCredit_Report.AsCurrency;
      //qte1
      TaBalanceCalcQt1_Report_Calc.AsCurrency:=0+TaBalanceCalcQt1_Report.AsCurrency;
      //qte2
      TaBalanceCalcQt2_Report_Calc.AsCurrency:=0+TaBalanceCalcQt2_Report.AsCurrency;
     End;
    TaBalanceCalcSolde_Qt1_Report_Calc.AsCurrency:=TaBalanceCalcQt1_Report_Calc.AsCurrency;
    TaBalanceCalcSolde_Qt2_Report_Calc.AsCurrency:=TaBalanceCalcQt2_Report_Calc.AsCurrency;

    // Calcul des Solde Report
    TaBalanceCalcSolde_Debit_Report_Calc.AsCurrency:=0;
    TaBalanceCalcSolde_Credit_Report_Calc.AsCurrency:=0;
    if TaBalanceCalcDebit_Report_Calc.AsCurrency - TaBalanceCalcCredit_Report_Calc.AsCurrency > 0 then
     Begin
       TaBalanceCalcSolde_Debit_Report_Calc.AsCurrency:=TaBalanceCalcDebit_Report_Calc.AsCurrency - TaBalanceCalcCredit_Report_Calc.AsCurrency;
     End
     else
     Begin
      TaBalanceCalcSolde_Credit_Report_Calc.AsCurrency:=TaBalanceCalcCredit_Report_Calc.AsCurrency-TaBalanceCalcDebit_Report_Calc.AsCurrency;
     End;


     // Calcul de totaux Base (mouvement de l'année)
    TaBalanceCalcDebit_Base_Calc.AsCurrency:=0+TaBalanceCalcDebit_Base_QueryBase.AsCurrency;
    TaBalanceCalcCredit_Base_Calc.AsCurrency:=0+TaBalanceCalcCredit_Base_QueryBase.AsCurrency;
//    //Quantite
    TaBalanceCalcQt1_Base_Calc.AsCurrency:=0+TaBalanceCalcQt1_Base_QueryBase.AsCurrency;
    TaBalanceCalcQt2_Base_Calc.AsCurrency:=0+TaBalanceCalcQt2_Base_QueryBase.AsCurrency;
    TaBalanceCalcSolde_Qt1_Base_Calc.AsCurrency:=TaBalanceCalcQt1_Base_Calc.AsCurrency;
    TaBalanceCalcSolde_Qt2_Base_Calc.AsCurrency:=TaBalanceCalcQt2_Base_Calc.AsCurrency;
    // Calcul des Solde Base (solde des mouvement de l'année)

    TaBalanceCalcSolde_Debit_Base_Calc.AsCurrency:=0;
    TaBalanceCalcSolde_Credit_Base_Calc.AsCurrency:=0;
    if TaBalanceCalcDebit_Base_Calc.AsCurrency - TaBalanceCalcCredit_Base_Calc.AsCurrency > 0 then
     Begin
       TaBalanceCalcSolde_Debit_Base_Calc.AsCurrency:=TaBalanceCalcDebit_Base_Calc.AsCurrency - TaBalanceCalcCredit_Base_Calc.AsCurrency;
     End
     else
     Begin
      TaBalanceCalcSolde_Credit_Base_Calc.AsCurrency:=TaBalanceCalcCredit_Base_Calc.AsCurrency-TaBalanceCalcDebit_Base_Calc.AsCurrency;
     End;

    // Calcul Totaux Total
    TaBalanceCalcDebit_Total_Calc.AsCurrency:=TaBalanceCalcDebit_Report_Calc.AsCurrency+TaBalanceCalcDebit_Base_Calc.AsCurrency;
    TaBalanceCalcCredit_Total_Calc.AsCurrency:=TaBalanceCalcCredit_Report_Calc.AsCurrency+TaBalanceCalcCredit_Base_Calc.AsCurrency;
//    //Quantite
    TaBalanceCalcQt1_Total_Calc.AsCurrency:=TaBalanceCalcQt1_Report_Calc.AsCurrency+TaBalanceCalcQt1_Base_Calc.AsCurrency;
    TaBalanceCalcQt2_Total_Calc.AsCurrency:=TaBalanceCalcQt2_Report_Calc.AsCurrency+TaBalanceCalcQt2_Base_Calc.AsCurrency;
    TaBalanceCalcSolde_Qt1_Total_Calc.AsCurrency:=TaBalanceCalcQt1_Total_Calc.AsCurrency;
    TaBalanceCalcSolde_Qt2_Total_Calc.AsCurrency:=TaBalanceCalcQt2_Total_Calc.AsCurrency;
    // Calcul des Solde Totaux
    TaBalanceCalcSolde_Debit_Total_Calc.AsCurrency:=0;
    TaBalanceCalcSolde_Credit_Total_Calc.AsCurrency:=0;

    if TaBalanceCalcDebit_Total_Calc.AsCurrency - TaBalanceCalcCredit_Total_Calc.AsCurrency > 0 then
     Begin
       TaBalanceCalcSolde_Debit_Total_Calc.AsCurrency:=TaBalanceCalcDebit_Total_Calc.AsCurrency - TaBalanceCalcCredit_Total_Calc.AsCurrency;
     End
     else
     Begin
      TaBalanceCalcSolde_Credit_Total_Calc.AsCurrency:=TaBalanceCalcCredit_Total_Calc.AsCurrency-TaBalanceCalcDebit_Total_Calc.AsCurrency;
     End;
    except
     showmessage('Erreur sur calcul des reports');
    end;
   end;//fin si calcul periode particulière


end;


Function TDMDiocEtatBal.SommeTotauxBalanceCalc(DateDeb,DateFin:TDate;ListeFiltre:TStringList;ChampFiltre:String;ForcerClose:boolean):TTotauxBalance;
var
QteTmp:real;
Begin
try//finally
TaBalanceCalc.Close;
//if e.typeclient=cl_isa then
//  begin
    if ForcerClose then QuEcritureReport.Close;
    if ForcerClose then QuEcritureBase.Close;
//  end
//else
//  begin
//    QuEcritureReport.Close;
//    QuEcritureBase.Close;
//  end;

if Uppercase(ChampFiltre) = Uppercase('Compte') then
TaBalanceCalc.TableName:='Balance.DB'
else
if Uppercase(ChampFiltre) = Uppercase('Tiers') then
TaBalanceCalc.TableName:='BalanceTiers.DB';

TaBalanceCalc.DisableControls;


PeriodeExercice := ((DateDeb=E.DatExoDebut) and (DateFin = E.DatExoFin));

if ((Type_version_execution=CT_DISTRIBUTION)and (not ForcerClose)) then
  PeriodeExercice := false; // A remettre si le calcul Balance issue de la lecture de la
                          // table balance ne marche pas !!!!!
if not PeriodeExercice then
  begin
     CalculSurPeriode(DateDeb,DateFin);
  end
else
  begin
//      TaBalanceCalc.OnCalcFields:=nil;
      QuEcritureReport.ParamByName('DateDeb').AsDate:=DateDeb;
      QuEcritureReport.ParamByName('DateFin').AsDate:=DateDeb;
      if QuEcritureReport.Active then
        QuEcritureReport.Refresh
      else
        QuEcritureReport.Open;
//
      QuEcritureBase.ParamByName('DateDeb').AsDate:=DateDeb;
      QuEcritureBase.ParamByName('DateFin').AsDate:=DateFin;
      if QuEcritureBase.Active then
        QuEcritureBase.Refresh
      else
        QuEcritureBase.Open;
  end;

InitialiseTotauxBalance(result);

TaBalanceCalc.Filter:='';
TaBalanceCalc.Filtered:=false;

if ListeFiltre <> nil then
 Begin
 if ListeFiltre.Count > 0 then
  begin
    TaBalanceCalc.Filter:=CreeFiltreOU(ChampFiltre,[ListeFiltre]);
    TaBalanceCalc.Filtered:=true;
  end;
 End;
TaBalanceCalc.Open;
TaBalanceCalc.First;
if PeriodeExercice then
 begin//si période dans bornes exercice
  while not TaBalanceCalc.EOF do
    Begin
     Result.TotalDebitReport:=Result.TotalDebitReport+TaBalanceCalc.FindField('Debit_report').AsCurrency;
     Result.TotalCreditReport:=Result.TotalCreditReport+TaBalanceCalc.FindField('credit_report').AsCurrency;
//     //Quantité
     Result.TotalQt1Report:=Result.TotalQt1Report+TaBalanceCalc.findfield('Qt1_Report').asfloat;
     Result.TotalQt2Report:=Result.TotalQt2Report+TaBalanceCalc.findfield('Qt2_Report').asfloat;
     //Calcul des soldes
     Result.TotalSoldeDebitReport:=Result.TotalDebitReport;
     Result.TotalSoldeCreditReport:=Result.TotalCreditReport;

     Result.TotalDebitBase:=Result.TotalDebitBase+TaBalanceCalc.FindField('debit_Base').AsCurrency;
     Result.TotalCreditBase:=Result.TotalCreditBase+TaBalanceCalc.FindField('Credit_Base').AsCurrency;
////     //quantite
     Result.TotalQt1Base:=Result.TotalQt1Base+TaBalanceCalc.findfield('Qt1_Base').asfloat;
     Result.TotalQt2Base:=Result.TotalQt2Base+TaBalanceCalc.findfield('Qt2_Base').asfloat;

     Result.TotalDebitFin:=Result.TotalDebitBase+Result.TotalDebitReport;
     Result.TotalCreditFin:=Result.TotalCreditBase+Result.TotalCreditReport;
    // result.totalq
     //Calcul des soldes
     Result.TotalSoldeDebitTotal:=Result.TotalSoldeDebitTotal+TaBalanceCalc.FindField('Solde_Debit_Total_Calc').AsCurrency;
     Result.TotalSoldeCreditTotal:=Result.TotalSoldeCreditTotal+TaBalanceCalc.FindField('Solde_Credit_Total_Calc').AsCurrency;

     TaBalanceCalc.Next;
    End;
 end //fin si période dans bornes exercice
else
 begin//si période particulière
  while not TaBalanceCalc.EOF do
    Begin
     Result.TotalDebitReport:=Result.TotalDebitReport+TaBalanceCalc.FindField('Debit_report_calc').AsCurrency;
     Result.TotalCreditReport:=Result.TotalCreditReport+TaBalanceCalc.FindField('credit_report_calc').AsCurrency;
//     //Quantité
     Result.TotalQt1Report:=Result.TotalQt1Report+TaBalanceCalc.findfield('Qt1_Report_Calc').asfloat;
     Result.TotalQt2Report:=Result.TotalQt2Report+TaBalanceCalc.findfield('Qt2_Report_Calc').asfloat;

     //Calcul des soldes
     Result.TotalSoldeDebitReport:=Result.TotalSoldeDebitReport+TaBalanceCalc.FindField('Solde_Debit_Report_Calc').AsCurrency;
     Result.TotalSoldeCreditReport:=Result.TotalSoldeCreditReport+TaBalanceCalc.FindField('Solde_Credit_Report_Calc').AsCurrency;

     Result.TotalDebitBase:=Result.TotalDebitBase+TaBalanceCalc.FindField('debit_Base_calc').AsCurrency;
     Result.TotalCreditBase:=Result.TotalCreditBase+TaBalanceCalc.FindField('Credit_Base_calc').AsCurrency;
//     //quantite
     Result.TotalQt1Base:=Result.TotalQt1Base+TaBalanceCalc.FindField('Qt1_Base_Calc').asfloat;
     Result.TotalQt2Base:=Result.TotalQt2Base+TaBalanceCalc.FindField('Qt2_Base_Calc').asfloat;

     Result.TotalDebitFin:=Result.TotalDebitBase+Result.TotalDebitReport;
     Result.TotalCreditFin:=Result.TotalCreditBase+Result.TotalCreditReport;

     //Calcul des soldes
     Result.TotalSoldeDebitTotal:=Result.TotalSoldeDebitTotal+TaBalanceCalc.FindField('Solde_Debit_Total_Calc').AsCurrency;
     Result.TotalSoldeCreditTotal:=Result.TotalSoldeCreditTotal+TaBalanceCalc.FindField('Solde_Credit_Total_Calc').AsCurrency;

     TaBalanceCalc.Next;
    End;
 end;//fin si période particulière

 Result.SoldeReport:=Result.TotalSoldeDebitReport-Result.TotalSoldeCreditReport;
 Result.SoldeBase:=Result.TotalDebitBase-Result.TotalCreditBase;
 Result.SoldeFin:=Result.TotalSoldeDebitTotal-Result.TotalSoldeCreditTotal;
// //quantite
 Result.SoldeFinQt1:=Result.TotalQt1Report+result.TotalQt1Base;
 Result.SoldeFinQt2:=Result.TotalQt2Report+result.TotalQt2Base;
 if Result.SoldeReport > 0 then
    begin
     Result.SoldeDebitCreditReport:=true;
    end
    else
    begin
     Result.SoldeDebitCreditReport:=False;
    end;
 if Result.SoldeBase > 0 then
    begin
     Result.SoldeDebitCreditBase:=true;
    end
    else
    begin
     Result.SoldeDebitCreditBase:=false;
    end;
 if Result.SoldeFin > 0 then
    begin
     Result.SoldeDebitCreditFin:=true;
    end
    else
    begin
      Result.SoldeDebitCreditFin:=false;
    end;
 Result.SoldeReport:=abs(Result.SoldeReport);
 Result.SoldeBase:=abs(Result.SoldeBase);
 Result.SoldeFin:=abs(Result.SoldeFin);
//Dataset.GotoBookmark(TempBookmark);
//Dataset.FreeBookmark(TempBookmark);
finally
//ReEnableControls(TaBalanceCalc);
//TaBalanceCalc.OnCalcFields:=TaBalanceCalcCalcFields;
end;//fin finally
End;





Function TDMDiocEtatBal.SommeTotauxBalanceParCompte(DateDeb,DateFin:TDate;Compte:String;ForcerClose:boolean):TTotauxBalance;
var
ListeCpt:TStringList;
Begin
if not empty(Compte) then
 begin
  ListeCpt:=TStringList.Create;
  ListeCpt.Add(Compte);
  if copy(Compte,1,1)='+' then
   begin
    result:=SommeTotauxBalanceCalc(DateDeb,DAteFin,ListeCpt,'Tiers',ForcerClose);
   end
    else
   begin
    result:=SommeTotauxBalanceCalc(DateDeb,DAteFin,ListeCpt,'Compte',ForcerClose);
   end;
  ListeCpt.Free;
  ListeCpt:=nil;
 end
 else
 begin
//  MessageDlg('TDMDiocEtatBal.SommeTotauxBalanceParCompte:Le compte ou le Tiers est vide !', mtWarning, [mbOK], 0);
 end;
End;

procedure TDMDiocEtatBal.TaBalanceaffichBeforeInsert(DataSet: TDataSet);
begin
abort;
end;

procedure TDMDiocEtatBal.TaBalanceaffichBeforeEdit(DataSet: TDataSet);
begin
abort;
end;

procedure TDMDiocEtatBal.TaBalanceaffichBeforeDelete(DataSet: TDataSet);
begin
abort;
end;

procedure TDMDiocEtatBal.DMDiocEtatBalDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
ListeFiltreAffich.Free;
ListeFiltreEdit.Free;
DMDiocEtatBal := nil;
end;

procedure TDMDiocEtatBal.TaBalanceaffichFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
accept := ((ListeFiltreAffich.IndexOf(DataSet.FindField('Compte').AsString) <> -1) or (ListeFiltreAffich.Count=0));
end;

Procedure TDMDiocEtatBal.Balance_Maj_BO_Vers_Balance(DataSetBO:TDataSet);
Begin
try
 try
  FiltrageDataSet(DataSetBO,'Compte < ''6''');
  DataSetBO.First;
  if not TaBalanceMaintS.Active then TaBalanceMaintS.Open;
  While not DataSetBO.Eof do
   begin
     if DMPlan.ImporterCpt(DataSetBO.findfield('Compte').AsString) then
      begin
       if not TaBalanceMaintS.Locate('Compte',DataSetBO.findfield('Compte').AsString,[]) then
         begin
          if not (VerifFNumeric(DataSetBO.findfield('Debit_Deb')).VideOUZero and VerifFNumeric(DataSetBO.findfield('Credit_Deb')).VideOUZero) then
           begin
             TaBalanceMaintS.Insert;
             TaBalanceMaintS.SetFields([DataSetBO.findfield('Compte').AsString,
                                       nil,
                                       DataSetBO.findfield('Debit_Deb').AsCurrency,
                                       DataSetBO.findfield('Credit_Deb').AsCurrency,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       DataSetBO.findfield('Compte').AsInteger]);
             TaBalanceMaintS.Post;
             TaBalanceMaintS.FlushBuffers;
           end;
         end
         else
         begin
           TaBalanceMaintS.Edit;
           TaBalanceMaintS.SetFields([DataSetBO.findfield('Compte').AsString,
                                     nil,
                                     DataSetBO.findfield('Debit_Deb').AsCurrency,
                                     DataSetBO.findfield('Credit_Deb').AsCurrency,
                                     nil,
                                     nil,
                                     nil,
                                     nil,
                                     nil,
                                     nil,
                                     nil,
                                     nil,
                                     nil,
                                     nil,
                                     DataSetBO.findfield('Compte').AsInteger]);
           TaBalanceMaintS.Post;
           TaBalanceMaintS.FlushBuffers;
         end;
      end;
   DataSetBO.Next;
   end;
  except
   Showmessage('Erreur inconnu lors du vérouillage BO --> Balance sur le compte : '+DataSetBO.findfield('Compte').AsString);
  end;
finally
DeFiltrageDataSet(DataSetBO);
end;
End;


Function TDMDiocEtatBal.VerifSoldeCompteDansBalance(Compte:string):TCalcul;
var
TotalBalanceReport:TTotauxBalance;
Begin
   try
      try
        //on recherche le solde de ce compte dans la balance
         InitialiseTotauxBalance(TotalBalanceReport);
         initialise_TCalcul(result);
         TotalBalanceReport:=DMDiocEtatBal.SommeTotauxBalanceParCompte(e.DatExoDebut,e.DatExoFin,compte);
         result.Retour:=TotalBalanceReport.SoldeReport<>0;
         if result.Retour then
           begin
               if TotalBalanceReport.SoldeDebitCreditReport then
                 result.SensTotal:=-1
               else
                 result.SensTotal:=1;
               result.Total:=TotalBalanceReport.SoldeReport;
           end;
      except
       Showmessage('Un problème est apparu lors de la recherche du compte : '+Compte+' dans la balance');
       result.retour:=false;
      end;
   finally
   end;
End;

procedure TDMDiocEtatBal.TaBalanceCalcFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
Accept:=(ListeFiltreEdit.IndexOf(DAtaSet.findField('Compte').AsString) <> -1);
end;


procedure TDMDiocEtatBal.TaBalanceCalcFilterRecordSurOuverture(DataSet: TDataSet;
  var Accept: Boolean);
begin
Accept:=(ListeFiltreEdit.IndexOf(DAtaSet.findField('Compte').AsString) <> -1)
 and (DAtaSet.findField('Compte').AsString < '6');
end;

procedure TDMDiocEtatBal.TaBalanceCalcFilterRecordSurChargesEtProduitOuverture(DataSet: TDataSet;
  var Accept: Boolean);
begin
Accept:=(ListeFiltreEdit.IndexOf(DAtaSet.findField('Compte').AsString) <> -1)
 and (DAtaSet.findField('Compte').AsString >= '6');
end;

procedure TDMDiocEtatBal.TaBalanceCalcBeforeRefresh(DataSet: TDataSet);
begin
if not QuEcritureReport.Active  then QuEcritureReport.Open;
if not QuEcritureBase.Active  then QuEcritureBase.Open;
QuEcritureReport.Refresh;
QuEcritureBase.Refresh;
TaPlanCpt.Refresh;
end;


Procedure TDMDiocEtatBal.ResultatExercice(var Debit,Credit:Currency;DateDeb,DateFin:TDate;ListeFiltreBalance:TStringList);
var
 TotauxBalance:TTotauxBalance;
// Debit_1_5,Credit_1_5,
ListeFiltreBalanceLocale:Tstringlist;
 Debit_6_7,Credit_6_7:Currency;
 i:integer;
begin
 ListeFiltreBalanceLocale:=TStringList.Create;
// ListeFiltreBalance:=TStringList.Create;
// ListeFiltreBalance.Clear;
// ListeFiltreBalance.Add('1*');
// ListeFiltreBalance.Add('2*');
// ListeFiltreBalance.Add('3*');
// ListeFiltreBalance.Add('4*');
// ListeFiltreBalance.Add('5*');
// TotauxBalance:=SommeTotauxBalanceCalc(DateDeb,DateFin,ListeFiltreBalance,'Compte');
// Debit_1_5:=TotauxBalance.TotalDebitFin;
// Credit_1_5:=TotauxBalance.TotalCreditFin;
// DetermineSolde(Debit_1_5,Credit_1_5);
if(ListeFiltreBalance=nil)or(ListeFiltreBalance.count=0)then
begin
 ListeFiltreBalanceLocale.Clear;
 ListeFiltreBalanceLocale.Add('6*');
 ListeFiltreBalanceLocale.Add('7*');
end
else
  begin
     for i:=0 to ListeFiltreBalance.count-1 do
     begin
       if(str_commence_par(ListeFiltreBalance.Strings[i],'6'))or
         (str_commence_par(ListeFiltreBalance.Strings[i],'7')) then
          ListeFiltreBalanceLocale.Add(ListeFiltreBalance.Strings[i]);
     end;
     if(ListeFiltreBalanceLocale.count=0)and(ListeFiltreBalance.count>0)then
         ListeFiltreBalanceLocale.Add('');
  end;
 TotauxBalance:=DMDiocEtatBal.SommeTotauxBalanceCalc(DateDeb,DateFin,ListeFiltreBalanceLocale,'Compte');
 Debit_6_7:=TotauxBalance.TotalDebitFin;
 Credit_6_7:=TotauxBalance.TotalCreditFin;
 DetermineSolde(Debit_6_7,Credit_6_7);

// if ((Debit_1_5 <> Credit_6_7) or (Credit_1_5 <> Debit_6_7)) then
//  begin
////   MessageDlg('Le calcul du résultat indique une incohérance dans votre '+#13+#10+'comptabilité.'+
////              RetourChariotDouble
////              , mtWarning, [mbOK], 0);
//  end;
Debit:=-Debit_6_7;
Credit:=  Credit_6_7;

End;

Procedure ResultatExercice(var Debit,Credit:Currency;DateDeb,DateFin:TDate);
var
 ListeFiltreBalance:TStringList;
Begin
 ListeFiltreBalance:=TStringList.Create;
 ListeFiltreBalance.Clear;
 ListeFiltreBalance.Add('6*');
 ListeFiltreBalance.Add('7*');
 DMDiocEtatBal.ResultatExercice(Debit,Credit,DateDeb,DateFin,ListeFiltreBalance);
End;

Function EditionBalanceOuvertureL( ListeCompte:TStringList;DataSet:TDataSet):Boolean;
  var NomFich,Chemin:String;
  var periode:TPeriode;

EtatFiltre:TEtatFiltre;
ListeValeur,LigneEdition:TStringList;
ObjPrn:TObjetEdition;
ParamAffichPeriode:TParamAffichPeriode;
ClasseCompteTmp:String;
// Variable des totaux généraux par classes de compte
TotalReportDebit,TotalReportCredit:Currency;

// Variable des totaux généraux
TotalReportDebitG,TotalReportCreditG:Currency;

Begin
try
      ObjPrn:=TObjetEdition.Create(application.MainForm);
  Chemin :=E.RepertoireComptaWeb;
  NomFich:='BalanceEx';
    //période fixe
     periode.Retour := true;
     periode.DateDeb := StrToDate_Lgr('01/01/1970');
     periode.DateFin := E.DatExoDebut;

  if periode.Retour then
  begin
      ListeValeur:=TStringList.Create;
      LigneEdition:=TStringList.Create;
      ObjPrn.FontLigneSeule.Style := [fsBold];

      if DMDiocEtatBal=nil then DMDiocEtatBal:=TDMDiocEtatBal.Create(Application.MainForm);
      if DMEcritures = nil then DMEcritures:=TDMEcritures.Create(Application.MainForm);
      
DMDiocEtatBal.PeriodeExercice := ((periode.DateDeb=StrToDate_Lgr('01/01/1970')) and (periode.DateFin = E.DatExoDebut));

      DMEcritures.TaEcritureBal.DisableControls;
      TableSauveEtatFiltre(DMEcritures.TaEcritureBal,EtatFiltre);
      DeFiltrageDataSet(DMEcritures.TaEcritureBal);
      DMEcritures.TaEcritureBal.MasterSource :=  DMDiocEtatBal.DaTaBalanceCalc;

      if dataset = nil then begin
         // Prevu pour passer le dataset concerné
      end;
      DMDiocEtatBal.QuEcritureReport.Close;
      DMDiocEtatBal.QuEcritureBase.Close;

      DMDiocEtatBal.CalculSurPeriode(periode.DateDeb,periode.DateFin);
      DeFiltrageDataSet(DMDiocEtatBal.TaBalanceCalc);

      if ListeCompte = nil then ListeCompte:=ChampTableVersListe('Compte',DMDiocEtatBal.TaBalanceCalc);
      DMDiocEtatBal.ListeFiltreEdit.Assign(ListeCompte);
                                                           
      DMDiocEtatBal.TaBalanceCalc.Filtered := true;
      DMDiocEtatBal.TaBalanceCalc.OnFilterRecord:=DMDiocEtatBal.TaBalanceCalcFilterRecordSurOuverture;
      TableRefreshSurClose(DMDiocEtatBal.TaBalanceCalc,'Compte');
      DMDiocEtatBal.TaBalanceCalc.First;
      if DMDiocEtatBal.TaBalanceCalc.recordcount<> 0 then
         begin
          while not DMDiocEtatBal.TaBalanceCalc.Eof do
           begin
            ClasseCompteTmp :=DMDiocEtatBal.TaBalanceCalc.FindField('Compte').AsString;
            TotalReportDebit := DMDiocEtatBal.TaBalanceCalc.FindField('Solde_Debit_Report_Calc').AsCurrency + TotalReportDebit;
            TotalReportCredit := DMDiocEtatBal.TaBalanceCalc.FindField('Solde_Credit_Report_Calc').AsCurrency + TotalReportCredit;
             ListeValeur.Add('0'+
                             ';'+
                             GereLibelle(DMDiocEtatBal.TaBalanceCalc.FindField('Compte').AsString)+
                             ';'+
                             GereLibelle(DMDiocEtatBal.TaBalanceCalc.FindField('ComptePlanCpt').AsString)+
                             ';'+
                             E.FormatCurrSansDevise(DMDiocEtatBal.TaBalanceCalc.FindField('Solde_Debit_Report_Calc').AsCurrency)+
                             ';'+
                             E.FormatCurrSansDevise(DMDiocEtatBal.TaBalanceCalc.FindField('Solde_Credit_Report_Calc').AsCurrency)
                             );

    //         EditionEcritureL(0,C_TypeEditionLigneSimple,false,DMDiocEtatBal.TaBalanceCalc.FindField('Compte').AsString,LigneEdition,nil,Site);
    //         ListeValeur.AddStrings(LigneEdition);

             DMDiocEtatBal.TaBalanceCalc.Next;
             if copy(ClasseCompteTmp,1,1) <> copy(DMDiocEtatBal.TaBalanceCalc.FindField('Compte').AsString,1,1) then
              begin
           listeValeur.Add('16');
               ListeValeur.Add('3;; @TOTAL CLASSE '+copy(ClasseCompteTmp,1,1)+' : ;'+
                               E.FormatCurrSansDevise(TotalReportDebit)+
                               ';'+
                               E.FormatCurrSansDevise(TotalReportCredit));
              TotalReportDebitG := TotalReportDebitG + TotalReportDebit;
              TotalReportCreditG := TotalReportCreditG + TotalReportCredit;

              DetermineSolde(TotalReportDebit,TotalReportCredit);
               ListeValeur.Add('1;; @Solde classe '+copy(ClasseCompteTmp,1,1)+' : ;'+
                               E.FormatCurrSansDevise(TotalReportDebit)+
                               ';'+
                               E.FormatCurrSansDevise(TotalReportCredit));
              TotalReportDebit := 0;
              TotalReportCredit := 0;
              ClasseCompteTmp :=DMDiocEtatBal.TaBalanceCalc.FindField('Compte').AsString;
              end;
          end;
           // Pour la dernière classe
           listeValeur.Add('16');
           ListeValeur.Add('3;; @TOTAL CLASSE '+copy(ClasseCompteTmp,1,1)+' : ;'+
                           E.FormatCurrSansDevise(TotalReportDebit)+
                           ';'+
                           E.FormatCurrSansDevise(TotalReportCredit));

            TotalReportDebitG := TotalReportDebitG + TotalReportDebit;
            TotalReportCreditG := TotalReportCreditG + TotalReportCredit;

              DetermineSolde(TotalReportDebit,TotalReportCredit);
               ListeValeur.Add('1;; @Solde classe '+copy(ClasseCompteTmp,1,1)+' : ;'+
                               E.FormatCurrSansDevise(TotalReportDebit)+
                               ';'+
                               E.FormatCurrSansDevise(TotalReportCredit));

           // Totaux Généraux
           listeValeur.Add('16');
           ListeValeur.Add('3;; @TOTAUX : ;'+
                           E.FormatCurrSansDevise(TotalReportDebitG)+
                           ';'+
                           E.FormatCurrSansDevise(TotalReportCreditG));

           // Soldes Généraux
           // Calcul des soldes
           DetermineSolde(TotalReportDebitG,TotalReportCreditG);

           ListeValeur.Add('1;; @Soldes : ;'+
                           E.FormatCurrSansDevise(TotalReportDebitG)+
                           ';'+
                           E.FormatCurrSansDevise(TotalReportCreditG));

         ObjPrn.FTitreEdition := 'BALANCE D''OUVERTURE';
         ObjPrn.FTitre2Edition :='Période du '+DateInfos(periode.DateDeb).DateStr+' au '+DateInfos(Periode.Datefin).DateStr;
         ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
         ListeValeur.Insert(0,' Compte ; Désignation ; Débit ; Crédit  ');
         ListeValeur.Insert(1,'1;3;1.5;1.5');
         ListeValeur.Insert(2,'texte;texte;curr;curr');
         ListeValeur.Insert(3,'  ; Report Début ;SURTITRE');
         ListeValeur.Insert(4,'4;3');
         end;//s'il y a des écritures à imprimer
     ObjPrn.AffichageImp(ListeValeur);
      end;
Finally
  DMDiocEtatBal.TaBalanceCalc.OnFilterRecord:=nil;
  DeFiltrageDataSet(DMDiocEtatBal.TaBalanceCalc);
  TableRestoreEtatFiltre(DMEcritures.TaEcritureBal,EtatFiltre);
  DMEcritures.TaEcritureBal.MasterSource := DMDiocEtatBal.DaBalance;
  ReEnableControls(DMEcritures.TaEcritureBal);
  LibereObjet(Tobject(ObjPrn));
end;
End;

Function EditionChargesEtProduitsOuvertureL(ListeEdition:TStringList):Boolean;
var
periode:TPeriode;
ObjPrn:TObjetEdition;
i:integer;
ListeValeur:TStringList;
ClasseCompteTmp:String;
// Variable des totaux généraux par classes de compte
TotalReportDebit,TotalReportCredit,TotalBaseDebit,
TotalBaseCredit,TotalFinDebit,TotalFinCredit:Currency;

// Variable des totaux généraux par classes de compte 6
TotalFinDebitResultat,TotalFinCreditResultat:Currency;

// Variable des totaux généraux
TotalReportDebitG,TotalReportCreditG,TotalBaseDebitG,
TotalBaseCreditG,TotalFinDebitG,TotalFinCreditG:Currency;

Begin
try
      ObjPrn:=TObjetEdition.Create(application.MainForm);
      ListeValeur:=TStringList.Create;
    //période fixe
     periode.Retour := true;
     periode.DateDeb := StrToDate_Lgr('01/01/1970');
     periode.DateFin := E.DatExoDebut;

  if periode.Retour then
  begin
      ObjPrn.FontLigneSeule.Style := [fsBold];
      if (ListeEdition<>nil)and(ListeEdition.Count>0) then
         begin
         i:=0;
         while i<=ListeEdition.Count-1 do
           begin
            ClasseCompteTmp :=str_getstringelement(ListeEdition.Strings[i],1,';');
            TotalReportDebit := StrToCurr_Lgr(str_getstringelement(ListeEdition.Strings[i],3,';' )) + TotalReportDebit;
            TotalReportCredit := StrToCurr_Lgr(str_getstringelement(ListeEdition.Strings[i],4,';' )) + TotalReportCredit;
             ListeValeur.Add('0'+
                             ';'+
                             str_getstringelement(ListeEdition.Strings[i],1,';' )+
                             ';'+
                             str_getstringelement(ListeEdition.Strings[i],2,';' )+
                             ';'+
                             str_getstringelement(ListeEdition.Strings[i],3,';' )+
                             ';'+
                             str_getstringelement(ListeEdition.Strings[i],4,';' )
                             );
             inc(i);
             if (i=ListeEdition.Count)or(copy(ClasseCompteTmp,1,1) <> copy(str_getstringelement(ListeEdition.Strings[i],1,';' ),1,1)) then
              begin
           listeValeur.Add('16');
               ListeValeur.Add('3;; @TOTAL CLASSE '+copy(ClasseCompteTmp,1,1)+' : ;'+
                               E.FormatCurrSansDevise(TotalReportDebit)+
                               ';'+
                               E.FormatCurrSansDevise(TotalReportCredit));
              TotalReportDebitG := TotalReportDebitG + TotalReportDebit;
              TotalReportCreditG := TotalReportCreditG + TotalReportCredit;

              DetermineSolde(TotalReportDebit,TotalReportCredit);
               ListeValeur.Add('1;; @Solde classe '+copy(ClasseCompteTmp,1,1)+' : ;'+
                               E.FormatCurrSansDevise(TotalReportDebit)+
                               ';'+
                               E.FormatCurrSansDevise(TotalReportCredit));
              TotalReportDebit := 0;
              TotalReportCredit := 0;
              if i<ListeEdition.Count then
                ClasseCompteTmp :=str_getstringelement(ListeEdition.Strings[i],1,';' );
              end;
          end;
           // Totaux Généraux
           listeValeur.Add('16');
           ListeValeur.Add('3;; @TOTAUX : ;'+
                           E.FormatCurrSansDevise(TotalReportDebitG)+
                           ';'+
                           E.FormatCurrSansDevise(TotalReportCreditG));

           // Soldes Généraux
           // Calcul des soldes
           DetermineSolde(TotalReportDebitG,TotalReportCreditG);

           ListeValeur.Add('1;; @Soldes : ;'+
                           E.FormatCurrSansDevise(TotalReportDebitG)+
                           ';'+
                           E.FormatCurrSansDevise(TotalReportCreditG));

         ObjPrn.FTitreEdition := 'CHARGES ET PRODUITS D''OUVERTURE';
         ObjPrn.FTitre2Edition :='Période du '+DateInfos(periode.DateDeb).DateStr+' au '+DateInfos(Periode.Datefin).DateStr;
         ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
         ListeValeur.Insert(0,' Compte ; Désignation ; Débit ; Crédit  ');
         ListeValeur.Insert(1,'1;3;1.5;1.5');
         ListeValeur.Insert(2,'texte;texte;curr;curr');
         ListeValeur.Insert(3,'  ; Report Début ;SURTITRE');
         ListeValeur.Insert(4,'4;3');
         end;//s'il y a des écritures à imprimer
     ObjPrn.AffichageImp(ListeValeur);
      end;
Finally
  LibereObjet(Tobject(ObjPrn));
end;
End;



Function EditionBalanceComparative(ListeCompte:TStringList;PeriodesDemandees:TStringList;DataSet:TDataSet;Regrouper:integer;solde:boolean;typeVariation:integer):Boolean;
  var NomFich,Chemin:String;
//  var periode:TPeriode;
i,j,rang:integer;
EtatFiltre:TEtatFiltre;
ListeValeur,listeComparaison,listePeriodes:TStringList;    //,LigneEdition
ObjPrn:TObjetEdition;
ParamAffichPeriode:TParamAffichPeriode;
ClasseCompteTmp,CompteTmp,LibelleCptTmp:String;
CompteRegroupe:String;
// Variable des totaux g?n?raux par classes de compte
TotalReportDebit,TotalReportCredit:currency;

TotalBaseDebit1,TotalBaseDebit2,TotalBaseDebit3,
TotalBaseCredit1,TotalBaseCredit2,TotalBaseCredit3,
TotalFinDebit1,TotalFinDebit2,TotalFinDebit3,
TotalFinCredit1,TotalFinCredit2,TotalFinCredit3:Currency;
FinDebit,FinCredit:Currency;
// Variable des totaux des comptes regroup?s
RegReportDebit,RegReportCredit,RegBaseDebit,
RegBaseCredit,RegFinDebit,RegFinCredit:Currency;

SoldeMouv1,SoldeMouv2,SoldeMouv3,SoldeFin1,SoldeFin2,SoldeFin3:Currency;
VarMouv1,VarMouv2,VarMouv3:Currency;
PourMouv1,PourMouv2,PourMouv3:Currency;

// Variable des totaux g?n?raux

TotalBaseDebitG1,TotalBaseDebitG2,TotalBaseDebitG3,
TotalBaseCreditG1,TotalBaseCreditG2,TotalBaseCreditG3,
TotalFinDebitG1,TotalFinDebitG2,TotalFinDebitG3,
TotalFinCreditG1,TotalFinCreditG2,TotalFinCreditG3:Currency;

ResultatDebit61,ResultatDebit62,ResultatDebit63:Currency;
ResultatDebit71,ResultatDebit72,ResultatDebit73:Currency;

ResultatCredit61,ResultatCredit62,ResultatCredit63:Currency;
ResultatCredit71,ResultatCredit72,ResultatCredit73:Currency;
Resultat1,Resultat2,Resultat3:currency;
afficheResultat:boolean;

Exercice:PPeriode;
compteCompare1,compteCompare2,compteCompare3:TCompteComparaison;
compteCompare:TCompteComparaison;
RequeteBalance,RequeteEcriture:TQuery;

maxiPeriode:boolean;
dateDebP1,dateDebP2,dateDebP3,dateFinP1,dateFinP2,dateFinP3,titreMouv,titreMouv2,
sens1,sens2,sens3,sensTheorique:string;

Begin
try
      ObjPrn:=TObjetEdition.Create(application.MainForm);
      listeComparaison:=Tstringlist.Create;
      RequeteBalance:=TQuery.Create(application.MainForm);
      RequeteEcriture:=TQuery.Create(application.MainForm);


  Chemin :=E.RepertoireComptaWeb;
  NomFich:='BalanceComparative';


      ListeValeur:=TStringList.Create;
      ObjPrn.FontLigneSeule.Style := [fsBold];

      if DMDiocEtatBal=nil then DMDiocEtatBal:=TDMDiocEtatBal.Create(Application.MainForm);

      if ListeCompte = nil then ListeCompte:=ChampTableVersListe('Compte',DMDiocEtatBal.TaBalanceCalc);
      DMDiocEtatBal.ListeFiltreEdit.Assign(ListeCompte);

      maxiPeriode:=(PeriodesDemandees.count>2);

      for i:=0 to PeriodesDemandees.Count-1 do
      begin
         Exercice:=PPeriode(PeriodesDemandees.Objects[i]);

         RequeteBalance.close;
         RequeteBalance.SQL.Clear;
         RequeteBalance.Filtered := true;
         RequeteBalance.OnFilterRecord:=DMDiocEtatBal.TaBalanceCalcFilterRecord;
         RequeteBalance.DatabaseName:=DM_C_NomAliasDossier;

         RequeteBalance.SQL.Add('select p.libelle,P.compte, (b.Debit_Report),(b.Credit_Report) ');
         RequeteBalance.SQL.Add(' from plancpt P');
         RequeteBalance.SQL.Add(' full join  "'+IncludeTrailingPathDelimiter(Exercice.DirExoBalance)+'balance" b on p.compte=b.compte');
         RequeteBalance.SQL.Add(' order by P.compte');
         RequeteBalance.Open;
         RequeteBalance.First;

         RequeteEcriture.close;
         RequeteEcriture.SQL.Clear;
         RequeteEcriture.Filtered := true;
         RequeteEcriture.OnFilterRecord:=DMDiocEtatBal.TaBalanceCalcFilterRecord;
         RequeteEcriture.DatabaseName:=DM_C_NomAliasDossier;
         RequeteEcriture.SQL.Add('Select Ecr.Compte, sum(Ecr.DebitSaisie) as TotDebit,Sum(Ecr.CreditSaisie) as TotCredit, ');
         RequeteEcriture.SQL.Add(' sum(Ecr.Qt1)as TotQt1,sum(Ecr.Qt2)as TotQt2');
         RequeteEcriture.SQL.Add(' from Ecriture Ecr join Piece Pi on (Pi.ID=Ecr.ID_Piece)');
         RequeteEcriture.SQL.Add(' right join plancpt P on p.compte=Ecr.compte');
         RequeteEcriture.SQL.Add(' where Pi."Date" >=:DateDeb and Pi."Date" <=:DateFin');
         RequeteEcriture.SQL.Add(' group by Ecr.Compte order by Ecr.compte');
         if(solde)then
         begin
           RequeteEcriture.ParamByName('DateDeb').AsDate:=Exercice.DateDebExo;
           RequeteEcriture.ParamByName('DateFin').AsDate:=Exercice.DateFin;
         end
         else
         begin
           RequeteEcriture.ParamByName('DateDeb').AsDate:=Exercice.DateDeb;
           RequeteEcriture.ParamByName('DateFin').AsDate:=Exercice.DateFin;
         end;
         RequeteEcriture.Open;
         RequeteEcriture.First;


         //faire un traitement pour remplir les objets de comparaison
         //? partir de la date d?but pr?c?dent la date d?but choisie, calculer les reports jusqu'? la date d?but choisie -1 jour
      if RequeteBalance.recordcount<> 0 then
         begin
         CompteRegroupe := copy(RequeteBalance.FindField('Compte').AsString,1,Regrouper);
          while not RequeteBalance.Eof do
           begin
           rang:=listeComparaison.IndexOf(RequeteBalance.FindField('Compte').AsString);
           if(rang=-1)then listePeriodes:=Tstringlist.Create
           else listePeriodes:=TStringList(listeComparaison.Objects[rang]);
           compteCompare:=TCompteComparaison.Create;
           compteCompare.Periode:=Exercice;
            compteCompare.compte :=RequeteBalance.FindField('Compte').AsString;

            //sensTheorique:=DMDiocEtatBal.SensCompte(compteCompare.compte);

            FiltrageDataSet(RequeteEcriture,CreeFiltreOU('compte',[compteCompare.compte]));
            compteCompare.Designation:=GereLibelle(RequeteBalance.FindField('libelle').AsString);
            compteCompare.TotauxBalance.TotalDebitReport := RequeteBalance.FindField('Debit_Report').AsCurrency + TotalReportDebit;
            compteCompare.TotauxBalance.TotalCreditReport := RequeteBalance.FindField('Credit_Report').AsCurrency + TotalReportCredit;
            compteCompare.TotauxBalance.TotalDebitBase:=0;
            compteCompare.TotauxBalance.TotalCreditBase:=0;
            if(RequeteEcriture.RecordCount<>0)then
            begin
              compteCompare.TotauxBalance.TotalDebitBase:=RequeteEcriture.FindField('TotDebit').AsCurrency;
              compteCompare.TotauxBalance.TotalCreditBase:=RequeteEcriture.FindField('TotCredit').AsCurrency;;
            end;
            RegReportDebit := RequeteBalance.FindField('Debit_Report').AsCurrency+ RegReportDebit;
            RegReportCredit := RequeteBalance.FindField('Credit_Report').AsCurrency+ RegReportCredit;
            RegBaseDebit:=compteCompare.TotauxBalance.TotalDebitBase+RegBaseDebit;
            RegBaseCredit:=compteCompare.TotauxBalance.TotalCreditBase+RegBaseCredit;
              listePeriodes.AddObject(compteCompare.compte,compteCompare);
            if(Regrouper=0) or (Regrouper=8)and (rang=-1)then
            begin
              listeComparaison.AddObject(compteCompare.compte, listePeriodes);
            end;
             RequeteBalance.Next;
             if(Regrouper>0) and (Regrouper<8)then
             if (copy(CompteRegroupe,1,Regrouper) <> copy(RequeteBalance.FindField('Compte').AsString,1,Regrouper))or(RequeteBalance.eof) then
              begin

             rang:=listeComparaison.IndexOf(CompteRegroupe);
             if(rang=-1)then listePeriodes:=Tstringlist.Create
                else listePeriodes:=TStringList(listeComparaison.Objects[rang]);
             compteCompare:=TCompteComparaison.Create;
             compteCompare.Periode:=Exercice;
             compteCompare.compte:=GereLibelle(CompteRegroupe);
             compteCompare.Designation:=GereLibelle(DMPlan.LibelleDuNumCpt(CompteRegroupe));
             compteCompare.TotauxBalance.TotalDebitReport:=RegReportDebit;
             compteCompare.TotauxBalance.TotalCreditReport:=RegReportCredit;
             compteCompare.TotauxBalance.TotalDebitBase:=RegBaseDebit;
            compteCompare.TotauxBalance.TotalCreditBase:=RegBaseCredit;
            if(listePeriodes.count>i)then
              listePeriodes.Objects[i]:=compteCompare
            else
            listePeriodes.AddObject(compteCompare.compte,compteCompare);
             if(rang=-1)then
              begin
                listeComparaison.AddObject(compteCompare.compte, listePeriodes);
              end; 
               CompteRegroupe := copy(RequeteBalance.FindField('Compte').AsString,1,Regrouper);
               RegReportDebit:=0;
               RegReportCredit:=0;
               RegBaseDebit:=0;
               RegBaseCredit:=0;
               RegFinDebit:=0;
               RegFinCredit:=0;
             end;
          end;

         end;//s'il y a des ?critures ? imprimer
         end;//fin traitement sur p?riode
         if(listeComparaison.Count>0)then ClasseCompteTmp:=listeComparaison.Strings[0];
     for i:=0 to listeComparaison.Count-1 do
     begin
             if copy(ClasseCompteTmp,1,1) <> copy(listeComparaison.Strings[i],1,1) then
              begin
          // listeValeur.Add('16');
               TotalBaseDebitG1 :=TotalBaseDebitG1 + TotalBaseDebit1;
              TotalBaseDebitG2 :=TotalBaseDebitG2 + TotalBaseDebit2;
              TotalBaseDebitG3 :=TotalBaseDebitG3 + TotalBaseDebit3;

              TotalBaseCreditG1:=TotalBaseCreditG1 + TotalBaseCredit1;
              TotalBaseCreditG2 :=TotalBaseCreditG2 + TotalBaseCredit2;
              TotalBaseCreditG3 :=TotalBaseCreditG3 + TotalBaseCredit3;

              TotalFinDebitG1 := TotalFinDebitG1 + TotalFinDebit1;
              TotalFinDebitG2 := TotalFinDebitG2 + TotalFinDebit2;
              TotalFinDebitG3 := TotalFinDebitG3 + TotalFinDebit3;

              TotalFinCreditG1 := TotalFinCreditG1 + TotalFinCredit1;
              TotalFinCreditG2 := TotalFinCreditG2 + TotalFinCredit2;
              TotalFinCreditG3 := TotalFinCreditG3 + TotalFinCredit3;

                   if(copy(ClasseCompteTmp,1,1)='6')then
                     begin
                       if(not solde)then
                         begin
                           ResultatDebit61:=TotalBaseDebit1;
                           ResultatDebit62:=TotalBaseDebit2;
                           ResultatDebit63:=TotalBaseDebit3;
                           ResultatCredit61:=TotalBaseCredit1;
                           ResultatCredit62:=TotalBaseCredit2;
                           ResultatCredit63:=TotalBaseCredit3;
                           afficheResultat:=true;
                         end
                       else
                         begin
                           ResultatDebit61:=TotalFinDebit1;
                           ResultatDebit62:=TotalFinDebit2;
                           ResultatDebit63:=TotalFinDebit3;
                           ResultatCredit61:=TotalFinCredit1;
                           ResultatCredit62:=TotalFinCredit2;
                           ResultatCredit63:=TotalFinCredit3;
                           afficheResultat:=true;
                         end;
                     end;
              if(copy(ClasseCompteTmp,1,1)='7')then
                     begin
                       if(not solde)then
                         begin
                           ResultatDebit71:=TotalBaseDebit1;
                           ResultatDebit72:=TotalBaseDebit2;
                           ResultatDebit73:=TotalBaseDebit3;
                           ResultatCredit71:=TotalBaseCredit1;
                           ResultatCredit72:=TotalBaseCredit2;
                           ResultatCredit73:=TotalBaseCredit3;
                           afficheResultat:=true;
                         end
                       else
                         begin
                           ResultatDebit71:=TotalFinDebit1;
                           ResultatDebit72:=TotalFinDebit2;
                           ResultatDebit73:=TotalFinDebit3;
                           ResultatCredit71:=TotalFinCredit1;
                           ResultatCredit72:=TotalFinCredit2;
                           ResultatCredit73:=TotalFinCredit3;
                           afficheResultat:=true;
                         end;
                     end;
               sens1:='';
              TotalBaseDebit1:=DetermineSolde(TotalBaseDebit1,TotalBaseCredit1);
              TotalFinDebit1:=DetermineSolde(TotalFinDebit1,TotalFinCredit1);
               if(TotalBaseDebit1>0)then sens1:='D';
               if(TotalBaseCredit1>0)then sens1:='C';
               if(solde)then
                 begin
                   TotalBaseDebit1:=TotalFinDebit1;
                   sens1:='';
                   if(TotalFinDebit1>0)then sens1:='D';
                   if(TotalFinCredit1>0)then sens1:='C';
                 end;

               sens2:='';
              TotalBaseDebit2:=DetermineSolde(TotalBaseDebit2,TotalBaseCredit2);
              TotalFinDebit2:=DetermineSolde(TotalFinDebit2,TotalFinCredit2);
               if(TotalBaseDebit2>0)then sens2:='D';
               if(TotalBaseCredit2>0)then sens2:='C';
               if(solde)then
                 begin
                   TotalBaseDebit2:=TotalFinDebit2;
                   sens2:='';
                   if(TotalFinDebit2>0)then sens2:='D';
                   if(TotalFinCredit2>0)then sens2:='C';
                 end;

               sens3:='';
              TotalBaseDebit3:=DetermineSolde(TotalBaseDebit3,TotalBaseCredit3);
              TotalFinDebit3:=DetermineSolde(TotalFinDebit3,TotalFinCredit3);
               if(TotalBaseDebit3>0)then sens3:='D';
               if(TotalBaseCredit3>0)then sens3:='C';
               if(solde)then
                 begin
                   TotalBaseDebit3:=TotalFinDebit3;
                   sens3:='';
                   if(TotalFinDebit3>0)then sens3:='D';
                   if(TotalFinCredit3>0)then sens3:='C';
                 end;
                       sensTheorique:='';
//                     if(sens1=sens2)then VarMouv1:= abs(TotalBaseDebit1-TotalBaseDebit2)else VarMouv1:= abs(TotalBaseDebit1+TotalBaseDebit2);
//                     if(sens3=sens2)then VarMouv2:= abs(TotalBaseDebit2-TotalBaseDebit3)else VarMouv2:=abs(TotalBaseDebit2+TotalBaseDebit3);
//                     if(sens3=sens2)then VarMouv3:= abs(TotalBaseDebit1-TotalBaseDebit3)else VarMouv3:= abs(TotalBaseDebit1+TotalBaseDebit3);
                     VarMouv1:= DMDiocEtatBal.DetermineSensVariation(TotalBaseDebit1,TotalBaseDebit2,sens1,sens2,sensTheorique,1);
                     VarMouv2:= DMDiocEtatBal.DetermineSensVariation(TotalBaseDebit2,TotalBaseDebit3,sens2,sens3,sensTheorique,1);
                     VarMouv3:= DMDiocEtatBal.DetermineSensVariation(TotalBaseDebit1,TotalBaseDebit3,sens1,sens3,sensTheorique,1);

                     if(TotalBaseDebit2<>0)then PourMouv1:=(VarMouv1*100)/TotalBaseDebit2 else if(TotalBaseDebit1<>0)then PourMouv1:=100 else PourMouv1:=0;
                     if(TotalBaseDebit3<>0)then PourMouv2:=(VarMouv2*100)/TotalBaseDebit3 else if(TotalBaseDebit2<>0)then PourMouv2:=100 else PourMouv2:=0;
                     if(TotalBaseDebit3<>0)then PourMouv3:=(VarMouv3*100)/TotalBaseDebit3 else if(TotalBaseDebit1<>0)then PourMouv3:=100 else PourMouv3:=0;


            if(maxiPeriode)then
                          ListeValeur.Add('1;; @SOLDE CLASSE '+copy(ClasseCompteTmp,1,1)+' : '+
                             ';'+
                             E.FormatCurrSansDevise(TotalBaseDebit1)+
                             ';'+
                             GereLibelle(sens1)+
                             ';'+
                             E.FormatCurrSansDevise(TotalBaseDebit2)+
                             ';'+
                             GereLibelle(sens2)+
                             ';'+
                             E.FormatCurrSansDevise(TotalBaseDebit3)+
                             ';'+
                             GereLibelle(sens3)+
                             ';'+
                             E.FormatCurrSansDevise(VarMouv2)+
                             ';'+
                             E.FormatCurrSansDevise(PourMouv2)+
                             ';'+
                             E.FormatCurrSansDevise(VarMouv1)+
                             ';'+
                             E.FormatCurrSansDevise(PourMouv1)+
                             ';'+
                             E.FormatCurrSansDevise(VarMouv3)+
                             ';'+
                             E.FormatCurrSansDevise(PourMouv3)
                             )
         else
                          ListeValeur.Add('1;; @SOLDE CLASSE '+copy(ClasseCompteTmp,1,1)+' : '+
                             ';'+
                             E.FormatCurrSansDevise(TotalBaseDebit1)+
                             ';'+
                             GereLibelle(sens1)+
                             ';'+
                             E.FormatCurrSansDevise(TotalBaseDebit2)+
                             ';'+
                             GereLibelle(sens2)+
                             ';'+
                             E.FormatCurrSansDevise(VarMouv1)+
                             ';'+
                             E.FormatCurrSansDevise(PourMouv1)
                             );
              TotalBaseDebit1:=0;
              TotalBaseDebit2:=0;
              TotalBaseDebit3:=0;

              TotalBaseCredit1:=0;
              TotalBaseCredit2:=0;
              TotalBaseCredit3:=0;

              TotalFinDebit1:=0;
              TotalFinDebit2:=0;
              TotalFinDebit3:=0;

              TotalFinCredit1:=0;
              TotalFinCredit2:=0;
              TotalFinCredit3:=0;
            end;

        listePeriodes:=TStringList(listeComparaison.Objects[i]);
        SoldeMouv1:=0;
        SoldeMouv2:=0;
        SoldeMouv3:=0;
        if(listePeriodes.count>3)then showmessage('Erreur dans la balance comparative');
        ClasseCompteTmp:=copy(listeComparaison.Strings[i],1,1);
        if(listePeriodes.count>0)then compteCompare1:=TCompteComparaison(listePeriodes.Objects[0])else compteCompare1:=nil;
        if(listePeriodes.count>1)then compteCompare2:=TCompteComparaison(listePeriodes.Objects[1])else compteCompare2:=nil;
        if(listePeriodes.count>2)then compteCompare3:=TCompteComparaison(listePeriodes.Objects[2]) else compteCompare3:=nil;
       if(compteCompare1<>nil)then
       begin
         CompteTmp:=compteCompare1.compte;
         LibelleCptTmp:=compteCompare1.Designation;
         FinDebit:=compteCompare1.TotauxBalance.TotalDebitReport+compteCompare1.TotauxBalance.TotalDebitBase;
         FinCredit:=compteCompare1.TotauxBalance.TotalCreditReport+compteCompare1.TotauxBalance.TotalCreditBase;
         TotalBaseDebit1 := compteCompare1.TotauxBalance.TotalDebitBase+ TotalBaseDebit1;
         TotalBaseCredit1 := compteCompare1.TotauxBalance.TotalCreditBase + TotalBaseCredit1;
         TotalFinDebit1 := FinDebit + TotalFinDebit1;
         TotalFinCredit1 := FinCredit + TotalFinCredit1;
         SoldeFin1:=DetermineSolde(FinDebit,FinCredit);
         SoldeMouv1:=DetermineSolde(compteCompare1.TotauxBalance.TotalDebitBase,compteCompare1.TotauxBalance.TotalCreditBase);
         sens1:='';
         if(compteCompare1.TotauxBalance.TotalDebitBase>0)then sens1:='D';
         if(compteCompare1.TotauxBalance.TotalCreditBase>0)then sens1:='C';
         if(solde)then
           begin
             SoldeMouv1:= SoldeFin1;
             sens1:='';
             if(FinDebit>0)then sens1:='D';
             if(FinCredit>0)then sens1:='C';
           end;
       end;
       if(compteCompare2<>nil)then
       begin
         CompteTmp:=compteCompare2.compte;
         LibelleCptTmp:=compteCompare2.Designation;
         FinDebit:=compteCompare2.TotauxBalance.TotalDebitReport+compteCompare2.TotauxBalance.TotalDebitBase;
         FinCredit:=compteCompare2.TotauxBalance.TotalCreditReport+compteCompare2.TotauxBalance.TotalCreditBase;
         TotalBaseDebit2 := compteCompare2.TotauxBalance.TotalDebitBase+ TotalBaseDebit2;
         TotalBaseCredit2 := compteCompare2.TotauxBalance.TotalCreditBase + TotalBaseCredit2;
         TotalFinDebit2 := FinDebit + TotalFinDebit2;
         TotalFinCredit2 := FinCredit + TotalFinCredit2;
         SoldeFin2:=DetermineSolde(FinDebit,FinCredit);
         SoldeMouv2:=DetermineSolde(compteCompare2.TotauxBalance.TotalDebitBase,compteCompare2.TotauxBalance.TotalCreditBase);
         sens2:='';
         if(compteCompare2.TotauxBalance.TotalDebitBase>0)then sens2:='D';
         if(compteCompare2.TotauxBalance.TotalCreditBase>0)then sens2:='C';
         if(solde)then
           begin
             SoldeMouv2:= SoldeFin2;
             sens2:='';
             if(FinDebit>0)then sens2:='D';
             if(FinCredit>0)then sens2:='C';
           end;
       end;
       if(compteCompare3<>nil)then
       begin
         CompteTmp:=compteCompare3.compte;
         LibelleCptTmp:=compteCompare3.Designation;
         FinDebit:=compteCompare3.TotauxBalance.TotalDebitReport+compteCompare3.TotauxBalance.TotalDebitBase;
         FinCredit:=compteCompare3.TotauxBalance.TotalCreditReport+compteCompare3.TotauxBalance.TotalCreditBase;
         TotalBaseDebit3 := compteCompare3.TotauxBalance.TotalDebitBase+ TotalBaseDebit3;
         TotalBaseCredit3 := compteCompare3.TotauxBalance.TotalCreditBase + TotalBaseCredit3;
         TotalFinDebit3 := FinDebit + TotalFinDebit3;
         TotalFinCredit3 := FinCredit + TotalFinCredit3;
         SoldeFin3:=DetermineSolde(FinDebit,FinCredit);
         SoldeMouv3:=DetermineSolde(compteCompare3.TotauxBalance.TotalDebitBase,compteCompare3.TotauxBalance.TotalCreditBase);
         sens3:='';
         if(compteCompare3.TotauxBalance.TotalDebitBase>0)then sens3:='D';
         if(compteCompare3.TotauxBalance.TotalCreditBase>0)then sens3:='C';
         if(solde)then
           begin
             SoldeMouv3:= SoldeFin3;
             sens3:='';
             if(FinDebit>0)then sens3:='D';
             if(FinCredit>0)then sens3:='C';
           end;
       end;
                        sensTheorique:=DMDiocEtatBal.SensCompte(CompteTmp);
//                     if(sens1=sens2)then VarMouv1:= abs(SoldeMouv1-SoldeMouv2)else VarMouv1:= abs(SoldeMouv1+SoldeMouv2);
//                     if(sens3=sens2)then VarMouv2:= abs(SoldeMouv2-SoldeMouv3)else VarMouv2:=abs(SoldeMouv2+SoldeMouv3);
//                     if(sens3=sens2)then VarMouv3:= abs(SoldeMouv1-SoldeMouv3)else VarMouv3:= abs(SoldeMouv1+SoldeMouv3);
                     VarMouv1:= DMDiocEtatBal.DetermineSensVariation(SoldeMouv1,SoldeMouv2,sens1,sens2,sensTheorique,typeVariation);
                     VarMouv2:= DMDiocEtatBal.DetermineSensVariation(SoldeMouv2,SoldeMouv3,sens2,sens3,sensTheorique,typeVariation);
                     VarMouv3:= DMDiocEtatBal.DetermineSensVariation(SoldeMouv1,SoldeMouv3,sens1,sens3,sensTheorique,typeVariation);

                     if(SoldeMouv2<>0)then PourMouv1:=(VarMouv1*100)/SoldeMouv2 else if(SoldeMouv1<>0)then PourMouv1:=100*(VarMouv1/abs(VarMouv1)) else PourMouv1:=0;
                     if(SoldeMouv3<>0)then PourMouv2:=(VarMouv2*100)/SoldeMouv3 else if(SoldeMouv2<>0)then PourMouv2:=100*(VarMouv2/abs(VarMouv2)) else PourMouv2:=0;
                     if(SoldeMouv3<>0)then PourMouv3:=(VarMouv3*100)/SoldeMouv3 else if(SoldeMouv1<>0)then PourMouv3:=100*(VarMouv3/abs(VarMouv3)) else  PourMouv3:=0;


            if(maxiPeriode)then
             ListeValeur.Add('0'+
                             ';'+
                             GereLibelle(CompteTmp)+
                             ';'+
                             GereLibelle(LibelleCptTmp)+
                             ';'+
                             E.FormatCurrSansDevise(SoldeMouv1)+
                             ';'+
                             GereLibelle(sens1)+
                             ';'+
                             E.FormatCurrSansDevise(SoldeMouv2)+
                             ';'+
                             GereLibelle(sens2)+
                             ';'+
                             E.FormatCurrSansDevise(SoldeMouv3)+
                             ';'+
                             GereLibelle(sens3)+
                             ';'+
                             E.FormatCurrSansDevise(VarMouv2)+
                             ';'+
                             E.FormatCurrSansDevise(PourMouv2)+
                             ';'+
                             E.FormatCurrSansDevise(VarMouv1)+
                             ';'+
                             E.FormatCurrSansDevise(PourMouv1)+
                             ';'+
                             E.FormatCurrSansDevise(VarMouv3)+
                             ';'+
                             E.FormatCurrSansDevise(PourMouv3)
                             )
            else
                           ListeValeur.Add('0'+
                             ';'+
                             GereLibelle(CompteTmp)+
                             ';'+
                             GereLibelle(LibelleCptTmp)+
                             ';'+
                             E.FormatCurrSansDevise(SoldeMouv1)+
                             ';'+
                             GereLibelle(sens1)+
                             ';'+
                             E.FormatCurrSansDevise(SoldeMouv2)+
                             ';'+
                             GereLibelle(sens2)+
                             ';'+
                             E.FormatCurrSansDevise(VarMouv1)+
                             ';'+
                             E.FormatCurrSansDevise(PourMouv1)
                             )

     end;


                   if(copy(ClasseCompteTmp,1,1)='6')then
                     begin
                       if(not solde)then
                         begin
                           ResultatDebit61:=TotalBaseDebit1;
                           ResultatDebit62:=TotalBaseDebit2;
                           ResultatDebit63:=TotalBaseDebit3;
                           ResultatCredit61:=TotalBaseCredit1;
                           ResultatCredit62:=TotalBaseCredit2;
                           ResultatCredit63:=TotalBaseCredit3;
                           afficheResultat:=true;
                         end
                       else
                         begin
                           ResultatDebit61:=TotalFinDebit1;
                           ResultatDebit62:=TotalFinDebit2;
                           ResultatDebit63:=TotalFinDebit3;
                           ResultatCredit61:=TotalFinCredit1;
                           ResultatCredit62:=TotalFinCredit2;
                           ResultatCredit63:=TotalFinCredit3;
                           afficheResultat:=true;
                         end;
                     end;
              if(copy(ClasseCompteTmp,1,1)='7')then
                     begin
                       if(not solde)then
                         begin
                           ResultatDebit71:=TotalBaseDebit1;
                           ResultatDebit72:=TotalBaseDebit2;
                           ResultatDebit73:=TotalBaseDebit3;
                           ResultatCredit71:=TotalBaseCredit1;
                           ResultatCredit72:=TotalBaseCredit2;
                           ResultatCredit73:=TotalBaseCredit3;
                           afficheResultat:=true;
                         end
                       else
                         begin
                           ResultatDebit71:=TotalFinDebit1;
                           ResultatDebit72:=TotalFinDebit2;
                           ResultatDebit73:=TotalFinDebit3;
                           ResultatCredit71:=TotalFinCredit1;
                           ResultatCredit72:=TotalFinCredit2;
                           ResultatCredit73:=TotalFinCredit3;
                           afficheResultat:=true;
                         end;
                     end;
               TotalBaseDebitG1 :=TotalBaseDebitG1 + TotalBaseDebit1;
              TotalBaseDebitG2 :=TotalBaseDebitG2 + TotalBaseDebit2;
              TotalBaseDebitG3 :=TotalBaseDebitG3 + TotalBaseDebit3;

              TotalBaseCreditG1:=TotalBaseCreditG1 + TotalBaseCredit1;
              TotalBaseCreditG2 :=TotalBaseCreditG2 + TotalBaseCredit2;
              TotalBaseCreditG3 :=TotalBaseCreditG3 + TotalBaseCredit3;

              TotalFinDebitG1 := TotalFinDebitG1 + TotalFinDebit1;
              TotalFinDebitG2 := TotalFinDebitG2 + TotalFinDebit2;
              TotalFinDebitG3 := TotalFinDebitG3 + TotalFinDebit3;

              TotalFinCreditG1 := TotalFinCreditG1 + TotalFinCredit1;
              TotalFinCreditG2 := TotalFinCreditG2 + TotalFinCredit2;
              TotalFinCreditG3 := TotalFinCreditG3 + TotalFinCredit3;

               sens1:='';
              TotalBaseDebit1:=DetermineSolde(TotalBaseDebit1,TotalBaseCredit1);
              TotalFinDebit1:=DetermineSolde(TotalFinDebit1,TotalFinCredit1);
               if(TotalBaseDebit1>0)then sens1:='D';
               if(TotalBaseCredit1>0)then sens1:='C';
               if(solde)then
                 begin
                   TotalBaseDebit1:=TotalFinDebit1;
                   sens1:='';
                   if(TotalFinDebit1>0)then sens1:='D';
                   if(TotalFinCredit1>0)then sens1:='C';
                 end;

               sens2:='';
              TotalBaseDebit2:=DetermineSolde(TotalBaseDebit2,TotalBaseCredit2);
              TotalFinDebit2:=DetermineSolde(TotalFinDebit2,TotalFinCredit2);
               if(TotalBaseDebit2>0)then sens2:='D';
               if(TotalBaseCredit2>0)then sens2:='C';
               if(solde)then
                 begin
                   TotalBaseDebit2:=TotalFinDebit2;
                   sens2:='';
                   if(TotalFinDebit2>0)then sens2:='D';
                   if(TotalFinCredit2>0)then sens2:='C';
                 end;

               sens3:='';
              TotalBaseDebit3:=DetermineSolde(TotalBaseDebit3,TotalBaseCredit3);
              TotalFinDebit3:=DetermineSolde(TotalFinDebit3,TotalFinCredit3);
               if(TotalBaseDebit3>0)then sens3:='D';
               if(TotalBaseCredit3>0)then sens3:='C';
               if(solde)then
                 begin
                   TotalBaseDebit3:=TotalFinDebit3;
                   sens3:='';
                   if(TotalFinDebit3>0)then sens3:='D';
                   if(TotalFinCredit3>0)then sens3:='C';
                 end;

                       sensTheorique:='';
//                     if(sens1=sens2)then VarMouv1:= abs(TotalBaseDebit1-TotalBaseDebit2)else VarMouv1:= abs(TotalBaseDebit1+TotalBaseDebit2);
//                     if(sens3=sens2)then VarMouv2:= abs(TotalBaseDebit2-TotalBaseDebit3)else VarMouv2:=abs(TotalBaseDebit2+TotalBaseDebit3);
//                     if(sens3=sens2)then VarMouv3:= abs(TotalBaseDebit1-TotalBaseDebit3)else VarMouv3:= abs(TotalBaseDebit1+TotalBaseDebit3);
                     VarMouv1:= DMDiocEtatBal.DetermineSensVariation(TotalBaseDebit1,TotalBaseDebit2,sens1,sens2,sensTheorique,1);
                     VarMouv2:= DMDiocEtatBal.DetermineSensVariation(TotalBaseDebit2,TotalBaseDebit3,sens2,sens3,sensTheorique,1);
                     VarMouv3:= DMDiocEtatBal.DetermineSensVariation(TotalBaseDebit1,TotalBaseDebit3,sens1,sens3,sensTheorique,1);

                     if(TotalBaseDebit2<>0)then PourMouv1:=(VarMouv1*100)/TotalBaseDebit2 else if(TotalBaseDebit1<>0)then PourMouv1:=100 else PourMouv1:=0;
                     if(TotalBaseDebit3<>0)then PourMouv2:=(VarMouv2*100)/TotalBaseDebit3 else if(TotalBaseDebit2<>0)then PourMouv2:=100 else PourMouv2:=0;
                     if(TotalBaseDebit3<>0)then PourMouv3:=(VarMouv3*100)/TotalBaseDebit3 else if(TotalBaseDebit1<>0)then PourMouv3:=100 else PourMouv3:=0;



             if(maxiPeriode)then
                          ListeValeur.Add('1;; @SOLDE CLASSE '+copy(ClasseCompteTmp,1,1)+' : '+
                             ';'+
                             E.FormatCurrSansDevise(TotalBaseDebit1)+
                             ';'+
                             GereLibelle(sens1)+
                             ';'+
                             E.FormatCurrSansDevise(TotalBaseDebit2)+
                             ';'+
                             GereLibelle(sens2)+
                             ';'+
                             E.FormatCurrSansDevise(TotalBaseDebit3)+
                             ';'+
                             GereLibelle(sens3)+
                             ';'+
                             E.FormatCurrSansDevise(VarMouv2)+
                             ';'+
                             E.FormatCurrSansDevise(PourMouv2)+
                             ';'+
                             E.FormatCurrSansDevise(VarMouv1)+
                             ';'+
                             E.FormatCurrSansDevise(PourMouv1)+
                             ';'+
                             E.FormatCurrSansDevise(VarMouv3)+
                             ';'+
                             E.FormatCurrSansDevise(PourMouv3)
                             )
         else
                          ListeValeur.Add('1;; @SOLDE CLASSE '+copy(ClasseCompteTmp,1,1)+' : '+
                             ';'+
                             E.FormatCurrSansDevise(TotalBaseDebit1)+
                             ';'+
                             GereLibelle(sens1)+
                             ';'+
                             E.FormatCurrSansDevise(TotalBaseDebit2)+
                             ';'+
                             GereLibelle(sens2)+
                             ';'+
                             E.FormatCurrSansDevise(VarMouv1)+
                             ';'+
                             E.FormatCurrSansDevise(PourMouv1)
                             );

           // Soldes G?n?raux
           // Calcul des soldes
               sens1:='';
           TotalBaseDebitG1:=DetermineSolde(TotalBaseDebitG1,TotalBaseCreditG1);
           TotalFinDebitG1:=DetermineSolde(TotalFinDebitG1,TotalFinCreditG1);
               if(TotalBaseDebitG1>0)then sens1:='D';
               if(TotalBaseCreditG1>0)then sens1:='C';
               if(solde)then
                 begin
                   TotalBaseDebitG1:=TotalFinDebitG1;
                   sens1:='';
                   if(TotalFinDebitG1>0)then sens1:='D';
                   if(TotalFinCreditG1>0)then sens1:='C';
                 end;

               sens2:='';
           TotalBaseDebitG2:=DetermineSolde(TotalBaseDebitG2,TotalBaseCreditG2);
           TotalFinDebitG2:=DetermineSolde(TotalFinDebitG2,TotalFinCreditG2);
               if(TotalBaseDebitG2>0)then sens2:='D';
               if(TotalBaseCreditG2>0)then sens2:='C';
               if(solde)then
                 begin
                   TotalBaseDebitG2:=TotalFinDebitG2;
                   sens2:='';
                   if(TotalFinDebitG2>0)then sens2:='D';
                   if(TotalFinCreditG2>0)then sens2:='C';
                 end;

               sens3:='';
           TotalBaseDebitG3:=DetermineSolde(TotalBaseDebitG3,TotalBaseCreditG3);
           TotalFinDebitG3:=DetermineSolde(TotalFinDebitG3,TotalFinCreditG3);
               if(TotalBaseDebitG3>0)then sens3:='D';
               if(TotalBaseCreditG3>0)then sens3:='C';
               if(solde)then
                 begin
                   TotalBaseDebitG3:=TotalFinDebitG3;
                   sens3:='';
                   if(TotalFinDebitG3>0)then sens3:='D';
                   if(TotalFinCreditG3>0)then sens3:='C';
                 end;


                      sensTheorique:='';
                     VarMouv1:= DMDiocEtatBal.DetermineSensVariation(TotalBaseDebitG1,TotalBaseDebitG2,sens1,sens2,sensTheorique,1);
                     VarMouv2:= DMDiocEtatBal.DetermineSensVariation(TotalBaseDebitG2,TotalBaseDebitG3,sens2,sens3,sensTheorique,1);
                     VarMouv3:= DMDiocEtatBal.DetermineSensVariation(TotalBaseDebitG1,TotalBaseDebitG3,sens1,sens3,sensTheorique,1);

                     if(TotalBaseDebitG2<>0)then PourMouv1:=(VarMouv1*100)/TotalBaseDebitG2 else if(TotalBaseDebitG1<>0)then PourMouv1:=100 else  PourMouv1:=0;
                     if(TotalBaseDebitG3<>0)then PourMouv2:=(VarMouv2*100)/TotalBaseDebitG3 else if(TotalBaseDebitG2<>0)then PourMouv2:=100 else   PourMouv2:=0;
                     if(TotalBaseDebitG3<>0)then PourMouv3:=(VarMouv3*100)/TotalBaseDebitG3 else if(TotalBaseDebitG1<>0)then PourMouv3:=100 else   PourMouv3:=0;



            if(maxiPeriode)then
                          ListeValeur.Add('1;; @SOLDE GENERAL : '+
                             ';'+
                             E.FormatCurrSansDevise(TotalBaseDebitG1)+
                             ';'+
                             GereLibelle(sens1)+
                             ';'+
                             E.FormatCurrSansDevise(TotalBaseDebitG2)+
                             ';'+
                             GereLibelle(sens2)+
                             ';'+
                             E.FormatCurrSansDevise(TotalBaseDebitG3)+
                             ';'+
                             GereLibelle(sens3)+
                             ';'+
                             E.FormatCurrSansDevise(VarMouv2)+
                             ';'+
                             E.FormatCurrSansDevise(PourMouv2)+
                             ';'+
                             E.FormatCurrSansDevise(VarMouv1)+
                             ';'+
                             E.FormatCurrSansDevise(PourMouv1)+
                             ';'+
                             E.FormatCurrSansDevise(VarMouv3)+
                             ';'+
                             E.FormatCurrSansDevise(PourMouv3)
                             )
         else
                         ListeValeur.Add('1;; @SOLDE GENERAL : '+
                             ';'+
                             E.FormatCurrSansDevise(TotalBaseDebitG1)+
                             ';'+
                             GereLibelle(sens1)+
                             ';'+
                             E.FormatCurrSansDevise(TotalBaseDebitG2)+
                             ';'+
                             GereLibelle(sens2)+
                             ';'+
                             E.FormatCurrSansDevise(VarMouv1)+
                             ';'+
                             E.FormatCurrSansDevise(PourMouv1)
                             );

// gestion du resultat
             if(afficheResultat)then
             begin
               ResultatDebit61:=abs(ResultatDebit71+ResultatDebit61);
               ResultatDebit62:=abs(ResultatDebit72+ResultatDebit62);
               ResultatDebit63:=abs(ResultatDebit73+ResultatDebit63);
               ResultatCredit61:=abs(ResultatCredit71+ResultatCredit61);
               ResultatCredit62:=abs(ResultatCredit72+ResultatCredit62);
               ResultatCredit63:=abs(ResultatCredit73+ResultatCredit63);
               Resultat1:=DetermineSolde(ResultatDebit61,ResultatCredit61);
               Resultat2:=DetermineSolde(ResultatDebit62,ResultatCredit62);
               Resultat3:=DetermineSolde(ResultatDebit63,ResultatCredit63);

               sens1:='';
               if(ResultatDebit61>0)then Resultat1:=-1*Resultat1;

               sens2:='';
               if(ResultatDebit62>0)then Resultat2:=-1*Resultat2;

               sens3:='';
               if(ResultatDebit63>0)then Resultat3:=-1*Resultat3;

                      sensTheorique:='';
                     VarMouv1:= Resultat1-Resultat2;
                     VarMouv2:= Resultat2-Resultat3;
                     VarMouv3:= Resultat1-Resultat3;

                     if(Resultat2<>0)then PourMouv1:=(VarMouv1*100)/Resultat2 else if(Resultat1<>0)then PourMouv1:=100 else  PourMouv1:=0;
                     if(Resultat3<>0)then PourMouv2:=(VarMouv2*100)/Resultat3 else if(Resultat2<>0)then PourMouv2:=100 else   PourMouv2:=0;
                     if(Resultat3<>0)then PourMouv3:=(VarMouv3*100)/Resultat3 else if(Resultat1<>0)then PourMouv3:=100 else   PourMouv3:=0;
                     //pour que le signe du pourcentage = le signe de la variation
                     if(VarMouv1<>0)then PourMouv1:=abs(PourMouv1)*(VarMouv1/abs(VarMouv1));
                     if(VarMouv2<>0)then PourMouv2:=abs(PourMouv2)*(VarMouv2/abs(VarMouv2));
                     if(VarMouv3<>0)then PourMouv3:=abs(PourMouv3)*(VarMouv3/abs(VarMouv3));

              if(maxiPeriode)then
                          ListeValeur.Add('1;; @RESULTAT : '+
                             ';'+
                             E.FormatCurrSansDevise(Resultat1)+
                             ';'+
                             GereLibelle(sens1)+
                             ';'+
                             E.FormatCurrSansDevise(Resultat2)+
                             ';'+
                             GereLibelle(sens2)+
                             ';'+
                             E.FormatCurrSansDevise(Resultat3)+
                             ';'+
                             GereLibelle(sens3)+
                             ';'+
                             E.FormatCurrSansDevise(VarMouv2)+
                             ';'+
                             E.FormatCurrSansDevise(PourMouv2)+
                             ';'+
                             E.FormatCurrSansDevise(VarMouv1)+
                             ';'+
                             E.FormatCurrSansDevise(PourMouv1)+
                             ';'+
                             E.FormatCurrSansDevise(VarMouv3)+
                             ';'+
                             E.FormatCurrSansDevise(PourMouv3)
                             )
         else
                         ListeValeur.Add('1;; @RESULTAT : '+
                             ';'+
                             E.FormatCurrSansDevise(Resultat1)+
                             ';'+
                             GereLibelle(sens1)+
                             ';'+
                             E.FormatCurrSansDevise(Resultat2)+
                             ';'+
                             GereLibelle(sens2)+
                             ';'+
                             E.FormatCurrSansDevise(VarMouv1)+
                             ';'+
                             E.FormatCurrSansDevise(PourMouv1)
                             );
         end;
//

     if(ListeValeur.count>0)then
       begin
       if(solde)then
         begin
           titreMouv:='SOLDES FIN SUR '+IntToStr_Lgr(listePeriodes.Count)+' PERIODES';
           ObjPrn.FTitreEdition := 'BALANCES COMPARATIVES DES SOLDES FIN';
         end
       else
         begin
           titreMouv:='MOUVEMENTS SUR '+IntToStr_Lgr(listePeriodes.Count)+' PERIODES';
           ObjPrn.FTitreEdition := 'BALANCES COMPARATIVES DES MOUVEMENTS';
         end;

         if(PeriodesDemandees.count>0)and(PeriodesDemandees.Objects[0]<>nil)then
           begin
             Exercice:=PPeriode(PeriodesDemandees.Objects[0]);
             dateDebP1:=DateInfos(Exercice.DateDeb).DateStr;
             dateFinP1:=DateInfos(Exercice.DateFin).DateStr;
             ObjPrn.FTitre2Edition :='P?riode 1 du '+dateDebP1+' au '+dateFinP1;
           end;
         if(PeriodesDemandees.count>1)and(PeriodesDemandees.Objects[1]<>nil)then
           begin
             Exercice:=PPeriode(PeriodesDemandees.Objects[1]);
             dateDebP2:=DateInfos(Exercice.DateDeb).DateStr;
             dateFinP2:=DateInfos(Exercice.DateFin).DateStr;
             ObjPrn.FTitre2Edition :=ObjPrn.FTitre2Edition+' ,P?riode 2 du '+dateDebP2+' au '+dateFinP2;
           end;
         if(PeriodesDemandees.count>2)and(PeriodesDemandees.Objects[2]<>nil)then
           begin
             Exercice:=PPeriode(PeriodesDemandees.Objects[2]);
             dateDebP3:=DateInfos(Exercice.DateDeb).DateStr;
             dateFinP3:=DateInfos(Exercice.DateFin).DateStr;
             ObjPrn.FTitre2Edition :=ObjPrn.FTitre2Edition+' et P?riode 3 du '+dateDebP3+' au '+dateFinP3;
           end;
        ObjPrn.FTitre3Edition :='* Rappel : (P1-P2) signifie (valeur de la P?riode 1 - valeur de la P?riode 2)';
        ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
         if(not maxiPeriode)then
         begin
         ListeValeur.Insert(0,' Compte ; libell? du compte ; valeur P1 ; S ; valeur P2 ; S ; (P1-P2) ; %  ');
         ListeValeur.Insert(1,'0.6;2.0;1.3;0.2;1.3;0.2;1.0;0.5');
         ListeValeur.Insert(2,'texte;texte;curr;texte;curr;texte;curr;curr');
         ListeValeur.Insert(3,' DESIGNATION  ; '+titreMouv+' ;  VARIATIONS  ;SURTITRE');
         ListeValeur.Insert(4,'2.6;3.0;1.5');
         ListeValeur.Insert(5,' ; du '+dateDebP1+'& au '+dateFinP1+' ; du '+dateDebP2+'& au '+dateFinP2+' ; & * (P signifie P?riode) ;SURTITREDOUBLE');
         ListeValeur.Insert(6,'2.6;1.5;1.5;1.5');
         ObjPrn.Orientation := poPortrait;
         end
         else
         begin
         ListeValeur.Insert(0,' Compte ; libell? du compte ; valeur P1 ; S ; valeur P2 ; S ; valeur P3 ; S ; (P2-P3) ; % ; (P1-P2) ; % ; (P1-P3) ; %  ');
         ListeValeur.Insert(1,'0.6;2.0;1;0.2;1;0.2;1;0.2;1.0;0.5;1.0;0.5;1.0;0.5');
         ListeValeur.Insert(2,'texte;texte;curr;texte;curr;texte;curr;texte;curr;curr;curr;curr;curr;curr');
         ListeValeur.Insert(3,' DESIGNATION  ; '+titreMouv+' ; VARIATIONS  ;SURTITRE');
         ListeValeur.Insert(4,'2.6;3.6;4.5');
         ListeValeur.Insert(5,'  ; du '+dateDebP1+'& au '+dateFinP1+' ; du '+dateDebP2+'& au '+dateFinP2+' ; du '+dateDebP3+'& au '+dateFinP3+' ;  & * (P signifie P?riode)  ;SURTITREDOUBLE');
         ListeValeur.Insert(6,'2.6;1.2;1.2;1.2;4.5');
         ObjPrn.Orientation := poLandscape;
         end;
     end;
            ObjPrn.AffichageImp(ListeValeur);
Finally
  RequeteEcriture.close;
  RequeteBalance.close;

  RequeteEcriture.free;
  RequeteBalance.free;

  listeComparaison.Free;
  LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;
End;


constructor TCompteComparaison.Create;
    //constructeur
begin
  inherited Create;
end;

destructor TCompteComparaison.Destroy;
//destructeur
begin
  inherited Destroy;
end;

constructor PPeriode.Create;
    //constructeur
begin
  inherited Create;
end;

destructor PPeriode.Destroy;
//destructeur
begin
  inherited Destroy;
end;


function TDMDiocEtatBal.SensCompte(compte:string):String;
begin
result:='';
while (empty(result))and(Length(compte)>0)do
    begin
        FiltrageDataSet(TaSensCompte,CreeFiltreOU('compte',[compte]));
        if(TaSensCompte.RecordCount>0)then
          result:=TaSensCompte.findfield('Sens').AsString;
        if(empty(result))and(Length(compte)>0)then
           compte:=DMPlan.PereComptePCU(compte);
    end;
end;

function TDMDiocEtatBal.DetermineSensVariation(solde1,solde2:currency;sens1,sens2,SensTheorique:string;typeVariation:integer):Currency;
begin
result:=0;
if(sens1=sens2)then
  begin
    result:=solde1-solde2;
    if(sens1<>SensTheorique)then
      result:=result*-1;
  end
  else
  begin
    result:=abs(solde1+solde2);
    if(sens1<>SensTheorique)then
      result:=abs(result)*-1;
  end;
if(typeVariation=1)then result:=abs(result);
end;

function liste3DerniersExercices(listeEx0:TStringList):TStringList;
var
i:integer;
begin
result:=TStringList.create;
      //récupérer les 3 derniers exercices pour travailler dessus
    for i:=0 to listeEx0.count-1 do
    begin
       if(listeEx0.Strings[i]=e.NomExo)then
         begin
             result.AddObject(listeEx0.Strings[i],listeEx0.Objects[i]);
             if(i>0)then result.AddObject(listeEx0.Strings[i-1],listeEx0.Objects[i-1]);;
             if(i>1)then result.AddObject(listeEx0.Strings[i-2],listeEx0.Objects[i-2]);;
         end;
    end;
end;

function listeExercice(idDossier:integer;premierVide:boolean):TStringList;
var
Requete:TQuery;
Exercice:TExercice;
begin
try//finally
 result:=TStringList.Create;
 Requete:=TQuery.Create(DMDiocEtatBal);
 Requete.DatabaseName:=DM_C_NomAliasProgram;
      try//except
        if idDossier=0 then abort;
        Requete.sql.Add('select nom_dossier,dir_dossier,nom_Exo,Dir_Exo,Date_Deb_Exo,Date_Fin_Exo,cloture,Designation_dossier from GestDossier');
        Requete.sql.Add('where id_dossier=:Dossier');
        Requete.sql.Add('Order by Date_Deb_Exo,Date_Fin_Exo');
        Requete.ParamByName('Dossier').asinteger:=idDossier;
        Requete.Open;
        Requete.first;
                    if(premierVide)then
                      begin
                        Exercice:=TExercice.Create;
                        Exercice.nom_Dossier:=Requete.findfield('nom_Dossier').AsString;
                        Exercice.id_Dossier:=idDossier;
                        Exercice.dir_dossier:=Requete.findfield('dir_dossier').AsString;
                        Exercice.dir_exo:='-';
                        Exercice.nom_exo:='-';
                        Exercice.cloture:=false;
                        Exercice.Date_Deb_Exo:=0;
                        Exercice.Date_Fin_Exo:=0;
                        Exercice.Designation_dossier:='non déterminé';
                        result.AddObject(Exercice.nom_exo,Exercice);
                      end;
                while not(Requete.eof) do
                  begin
                    Exercice:=TExercice.Create;
                    Exercice.nom_Dossier:=Requete.findfield('nom_Dossier').AsString;
                    Exercice.id_Dossier:=idDossier;
                    Exercice.dir_dossier:=Requete.findfield('dir_dossier').AsString;
                    Exercice.dir_exo:=Requete.findfield('dir_exo').AsString;
                    Exercice.nom_exo:=Requete.findfield('nom_Exo').AsString;
                    Exercice.cloture:=Requete.findfield('cloture').AsBoolean;
                    Exercice.Date_Deb_Exo:=Requete.findfield('Date_Deb_Exo').AsDateTime;
                    Exercice.Date_Fin_Exo:=Requete.findfield('Date_Fin_Exo').AsDateTime;
                    Exercice.Designation_dossier:=Requete.findfield('Designation_dossier').AsString;

                    result.AddObject(Exercice.nom_exo,Exercice);
                    Requete.next;
                  end;



      except
         result:=nil;
      end;
  finally
    Requete.close;
    LibereObjet(TObject(Requete));
  end;
end;
end.
