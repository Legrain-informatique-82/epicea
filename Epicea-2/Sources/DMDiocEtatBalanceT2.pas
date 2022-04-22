unit DMDiocEtatBalanceT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,E2_Decl_Records,LibSQL,DMBalances,DMEcriture,E2_Librairie_Obj,
  editions,
  ObjetEdition,
  LibZoneSaisie,
  Gr_Librairie_Obj,
  LibRessourceString,
  shellapi,choixperiode,libdates,lib_chaine;

type

  TDMDiocEtatBalT = class(TDataModule)
    TaBalanceaffichT: TTable;
    DaBalanceT: TDataSource;
    TaPlanCpt: TTable;
    TaBalanceaffichTCompte: TStringField;
    TaBalanceaffichTLibTiers: TStringField;
    TaBalanceaffichTDebit_Report: TFloatField;
    TaBalanceaffichTCredit_Report: TFloatField;
    TaBalanceaffichTDebit_Report_Calc: TCurrencyField;
    TaBalanceaffichTCredit_report_calc: TCurrencyField;
    TaBalanceaffichTCredit_Base_Calc: TCurrencyField;
    TaBalanceaffichTDebit_Base_Calc: TCurrencyField;
    TaBalanceaffichTDebit_Total_Calc: TCurrencyField;
    TaBalanceaffichTCredit_Total_Calc: TCurrencyField;
    QuEcritureReport: TQuery;
    QuEcritureBase: TQuery;
    TaBalanceaffichTDebit_Base_QueryBase: TCurrencyField;
    TaBalanceaffichTCredit_Base_QueryBase: TCurrencyField;
    TaBalanceaffichTSolde_Debit_Report_Calc: TCurrencyField;
    TaBalanceaffichTSolde_Credit_Report_Calc: TCurrencyField;
    TaBalanceaffichTSolde_Debit_Base_Calc: TCurrencyField;
    TaBalanceaffichTSolde_Credit_Base_Calc: TCurrencyField;
    TaBalanceaffichTSolde_Debit_Total_Calc: TCurrencyField;
    TaBalanceaffichTSolde_Credit_Total_Calc: TCurrencyField;
    TaBalanceCalcT: TTable;
    TaBalanceCalcTCompte: TStringField;
    TaBalanceCalcTComptePlanCpt: TStringField;
    TaBalanceCalcTDebit_Report_Calc: TCurrencyField;
    TaBalanceCalcTCredit_report_calc: TCurrencyField;
    TaBalanceCalcTSolde_Debit_Report_Calc: TCurrencyField;
    TaBalanceCalcTSolde_Credit_Report_Calc: TCurrencyField;
    TaBalanceCalcTDebit_Base_Calc: TCurrencyField;
    TaBalanceCalcTCredit_Base_Calc: TCurrencyField;
    TaBalanceCalcTSolde_Debit_Base_Calc: TCurrencyField;
    TaBalanceCalcTSolde_Credit_Base_Calc: TCurrencyField;
    TaBalanceCalcTDebit_Total_Calc: TCurrencyField;
    TaBalanceCalcTCredit_Total_Calc: TCurrencyField;
    TaBalanceCalcTSolde_Debit_Total_Calc: TCurrencyField;
    TaBalanceCalcTSolde_Credit_Total_Calc: TCurrencyField;
    TaBalanceCalcTDebit_Report: TFloatField;
    TaBalanceCalcTCredit_Report: TFloatField;
    TaBalanceCalcTDebit_Base_QueryBase: TCurrencyField;
    TaBalanceCalcTCredit_Base_QueryBase: TCurrencyField;
    TaBalanceCalcTTiers: TStringField;
    DaBalancePourODAuto: TDataSource;
    TaBalanceaffichTTiers: TStringField;
    TaTiers: TTable;
    QuEcritureReportTiers: TStringField;
    QuEcritureReportTotDebit: TCurrencyField;
    QuEcritureReportTotCredit: TCurrencyField;
    QuEcritureBaseTiers: TStringField;
    QuEcritureBaseTotDebit: TCurrencyField;
    QuEcritureBaseTotCredit: TCurrencyField;
    QuListeValRupt: TQuery;
    QuSousTotal: TQuery;
    QuTotalG: TQuery;
    QuTotalG2: TQuery;
    TaBalanceCalcTLibTiers: TStringField;
    DaTaBalanceCalcT: TDataSource;
    QuCorrectionBalanceT: TQuery;
    TaBalanceCalcTDebit_Base: TFloatField;
    TaBalanceCalcTCredit_Base: TFloatField;
    TaBalanceCalcTDebit_Total: TFloatField;
    TaBalanceCalcTCredit_Total: TFloatField;
    TaBalanceCalcTQt1_Report: TFloatField;
    TaBalanceCalcTQt2_Report: TFloatField;
    TaBalanceCalcTQt1_Base: TFloatField;
    TaBalanceCalcTQt2_Base: TFloatField;
    TaBalanceCalcTQt1_Total: TFloatField;
    TaBalanceCalcTQt2_Total: TFloatField;
    TaBalanceCalcTID_Affichage: TIntegerField;
    QuEcritureBaseCompte: TStringField;
    procedure TaBalanceaffichTCalcFields(DataSet: TDataSet);
    Procedure CalculSurPeriode(DateDeb,DateFin:TDate);
    Function SommeTotauxBalanceT(DateDeb,DateFin:TDate;ListeFiltre:TStringList;ChampFiltre:String):TTotauxBalance;
    procedure DMDiocEtatBalCreate(Sender: TObject);
    procedure TaBalanceaffichTBeforeOpen(DataSet: TDataSet);
    procedure TaBalanceCalcTCalcFields(DataSet: TDataSet);
    Function SommeTotauxBalanceTCalc(DateDeb,DateFin:TDate;ListeFiltre:TStringList;ChampFiltre:String;ForcerClose:boolean=true):TTotauxBalance;
    Function SommeTotauxBalanceParTiers(DateDeb,DateFin:TDate;Compte:String;ForcerClose:Boolean=true):TTotauxBalance;
    procedure TaBalanceaffichTBeforeInsert(DataSet: TDataSet);
    procedure TaBalanceaffichTBeforeEdit(DataSet: TDataSet);
    procedure TaBalanceaffichTBeforeDelete(DataSet: TDataSet);
    procedure TaBalanceCalcTFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure DataModuleDestroy(Sender: TObject);
    procedure TaBalanceCalcTBeforeRefresh(DataSet: TDataSet);
    procedure TaBalanceaffichTFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
  private
    { Déclarations privées }
    PeriodeExercice:Boolean;
  public
    { Déclarations publiques }
    ListeFiltreAffich,ListeFiltreEdit : TStringList;
  end;

  Function MiseAJourBalanceNTiers:Boolean;
  Function ControleBalanceTiers(ListeTiersFiltre,ListeTiersNonEquilibre:TStringList):Boolean;
  Function EditionBalanceTiers(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
  Function EditionBalanceTiersL(TypeEdition : integer; DemandePeriode:Boolean; ListeCompte:TStringList;DataSet:TDataSet;SautDePage:boolean):Boolean;

var
  DMDiocEtatBalT: TDMDiocEtatBalT;

implementation

uses DMRecherche,DMExports;

{$R *.DFM}
Function MiseAJourBalanceNTiers:Boolean;
var
ListeMiseAJour:Tstringlist;
Begin
try
 try
     result:= true;
     ListeMiseAJour:=TStringList.Create;
    if DMDiocEtatBalT=nil then DMDiocEtatBalT:=TDMDiocEtatBalT.Create(Application.MainForm);
    if DMRech=nil then DMRech:=TDMRech.create(Application.MainForm);
      //supprimer les comptes de la balance qui n'ont pas de Report et
      //"Raz" des mouvements de ceux qui ont des reports
      DMDiocEtatBalT.QuCorrectionBalanceT.Close;
      DMDiocEtatBalT.QuCorrectionBalanceT.SQL.Clear;
      DMDiocEtatBalT.QuCorrectionBalanceT.SQL.add('delete from balanceTiers');
      DMDiocEtatBalT.QuCorrectionBalanceT.SQL.add('where ((Debit_Report = 0 or Debit_Report is Null) and (Credit_Report = 0 or Credit_Report is Null))');
      DMDiocEtatBalT.QuCorrectionBalanceT.ExecSQL;
      //fin de la suppression
      DMDiocEtatBalT.QuCorrectionBalanceT.Close;
      DMDiocEtatBalT.QuCorrectionBalanceT.SQL.Clear;
      DMDiocEtatBalT.QuCorrectionBalanceT.SQL.add('update balanceTiers.Db');
      DMDiocEtatBalT.QuCorrectionBalanceT.SQL.add('set Debit_base = 0 ,Credit_Base = 0 ');
      DMDiocEtatBalT.QuCorrectionBalanceT.ExecSQL;
      //fin du RAZ pour ceux qui on des reports
      DMDiocEtatBalT.QuEcritureBase.Close;
      DMDiocEtatBalT.QuEcritureBase.ParamByName('DateDeb').AsDate:=E.DatExoDebut;
      DMDiocEtatBalT.QuEcritureBase.ParamByName('DateFin').AsDate:=E.DatExoFin;
      DMDiocEtatBalT.QuEcritureBase.Open;
//    FiltrageDataSet(DMRech.TaBalanceTiersRech,'((Debit_Base <> 0 and Debit_Base <> Null) or (Credit_Base <> 0 and Credit_Base <> Null))');
    DMRech.TaBalanceTiersRech.First;
    DMDiocEtatBalT.QuEcritureBase.First;
    while not DMDiocEtatBalT.QuEcritureBase.Eof do
     begin
     if (DMDiocEtatBalT.QuEcritureBase.FindField('Tiers').AsString<>'') then
        begin//si tiers rempli
         if DMRech.TaBalanceTiersRech.Locate('Tiers',DMDiocEtatBalT.QuEcritureBase.FindField('Tiers').AsString,[]) then
          begin
          DMDiocEtatBalT.QuCorrectionBalanceT.Close;
          DMDiocEtatBalT.QuCorrectionBalanceT.SQL.Clear;
          DMDiocEtatBalT.QuCorrectionBalanceT.SQL.add('update BalanceTiers.Db  set Debit_Base = '+str_QueDesChiffresCurr_SQL(DMDiocEtatBalT.QuEcritureBase.FindField('TotDebit').AsString)+
                                                    ', Credit_Base = '+str_QueDesChiffresCurr_SQL(DMDiocEtatBalT.QuEcritureBase.FindField('TotCredit').AsString)+
                                                    ' where Tiers='''+DMDiocEtatBalT.QuEcritureBase.FindField('Tiers').AsString+'''');
        //  showmessage(DMDiocEtatBalT.QuCorrectionBalanceT.SQL.Text);
          DMDiocEtatBalT.QuCorrectionBalanceT.ExecSQL;
                 ListeMiseAJour.Add(DMRech.TaBalanceRech.FindField('Tiers').AsString+
                                    ' | '+
                                    DMDiocEtatBalT.QuEcritureBase.FindField('Tiers').AsString+
                                    ' ## BaseD : '+
                                    DMRech.TaBalanceRech.FindField('Debit_Base').AsString+
                                    ' | '+
                                    DMDiocEtatBalT.QuEcritureBase.FindField('Totdebit').AsString+
                                    ' ## BaseC : '+
                                    DMRech.TaBalanceRech.FindField('Credit_Base').AsString+
                                    ' | '+
                                    DMDiocEtatBalT.QuEcritureBase.FindField('TotCredit').AsString
                                    );
           end
          else
          begin//si le tiers n'existe pas dans la balance, il faut le créer
          DMDiocEtatBalT.QuCorrectionBalanceT.Close;
          DMDiocEtatBalT.QuCorrectionBalanceT.SQL.Clear;
          DMDiocEtatBalT.QuCorrectionBalanceT.SQL.add('insert into BalanceTiers.Db  (Tiers,compte,Debit_Report,Credit_Report,Debit_Base,Credit_base,Debit_Total,'+
                                                     'Credit_Total,Qt1_Report,Qt2_Report,Qt1_base,Qt2_base,Qt1_total,Qt2_Total)'+
                                                     'values('''+DMDiocEtatBalT.QuEcritureBase.FindField('Tiers').AsString+''','''+DMDiocEtatBalT.QuEcritureBase.FindField('Compte').AsString+''',0,0,'+
                                                     str_QueDesChiffresCurr_SQL(DMDiocEtatBalT.QuEcritureBase.FindField('TotDebit').AsString)+
                                                     ','+
                                                     str_QueDesChiffresCurr_SQL(DMDiocEtatBalT.QuEcritureBase.FindField('TotCredit').AsString)+',0,0,0,0,0,0,0,0)');
//                                                     str_QueDesChiffresCurr_SQL(DMDiocEtatBalT.QuEcritureBase.FindField('TotCredit').AsString)+',0,0,0,0,0,0,0,0)');
          DMDiocEtatBalT.QuCorrectionBalanceT.ExecSQL;
                 ListeMiseAJour.Add(DMRech.TaBalanceRech.FindField('Tiers').AsString+
                                    ' | '+
                                    DMDiocEtatBalT.QuEcritureBase.FindField('Tiers').AsString+
                                    ' ## BaseD : '+
                                    DMRech.TaBalanceRech.FindField('Debit_Base').AsString+
                                    ' | '+
                                    DMDiocEtatBalT.QuEcritureBase.FindField('Totdebit').AsString+
                                    ' ## BaseC : '+
                                    DMRech.TaBalanceRech.FindField('Credit_Base').AsString+
                                    ' | '+
                                    DMDiocEtatBalT.QuEcritureBase.FindField('TotCredit').AsString
                                    );

          end;//fin si le compte n'existe pas dans la balance
        end;//fin si tiers rempli
      DMDiocEtatBalT.QuEcritureBase.Next;
     end;
    except
     result := False;
    end;
 finally;
  DeFiltrageDataSet(DMRech.TaBalanceTiersRech);
  ListeMiseAJour.SaveToFile(e.RepertoireDossier+'MiseAJourBalanceNTiers.txt');
 end;
End;


Function ControleBalanceTiers(ListeTiersFiltre,ListeTiersNonEquilibre:TStringList):Boolean;
Var
//QueryBal:TQuery;
Equilibre:Boolean;
Begin
try//finally
 result:= true;
//QueryBal:=TQuery.Create(nil);
if DMDiocEtatBalT=nil then DMDiocEtatBalT:=TDMDiocEtatBalT.Create(Application.MainForm);
if DMRech=nil then DMRech:=TDMRech.create(Application.MainForm);
  DMDiocEtatBalT.QuEcritureBase.Close;
  DMDiocEtatBalT.QuEcritureBase.ParamByName('DateDeb').AsDate:=E.DatExoDebut;
  DMDiocEtatBalT.QuEcritureBase.ParamByName('DateFin').AsDate:=E.DatExoFin;
  DMDiocEtatBalT.QuEcritureBase.Open;
  ListeTiersNonEquilibre.Add(DMDiocEtatBalT.QuEcritureBase.sql.Text);

//  if
//DMDiocEtatBal.SommeTotauxBalanceCalc(E.DatExoDebut,E.DatExoFin,ListeCptFiltre,'Compte');
//Fi
FiltrageDataSet(DMRech.TaBalanceTiersRech,'((Debit_Base <> 0 and Debit_Base <> Null) or (Credit_Base <> 0 and Credit_Base <> Null))');

result := (DMDiocEtatBalT.QuEcritureBase.RecordCount = DMRech.TaBalanceTiersRech.RecordCount);
//la réquete quand elle est vide renvoie quand même un recordcount=1, alors il faut vérifier que cet enregistrement n'en ai pas un
//et que la table "DMRech.TaBalanceRech" est vide aussi
if not result then
  result:=((DMDiocEtatBalT.QuEcritureBase.RecordCount=1) and(VerifFNumeric(DMDiocEtatBalT.QuEcritureBase.FindField('Tiers')).VideOUZero) and(DMRech.TaBalanceTiersRech.RecordCount=0));
if not result then exit;

DMRech.TaBalanceTiersRech.First;
DMDiocEtatBalT.QuEcritureBase.First;
while not DMRech.TaBalanceTiersRech.Eof do
 begin
  Equilibre:=(DMRech.TaBalanceTiersRech.FindField('Tiers').AsString = DMDiocEtatBalT.QuEcritureBase.FindField('Tiers').AsString);
  if Equilibre then
    Equilibre:=(DMRech.TaBalanceTiersRech.FindField('Debit_Base').AsCurrency = DMDiocEtatBalT.QuEcritureBase.FindField('TotDebit').AsCurrency);
  if Equilibre then
    Equilibre:=(DMRech.TaBalanceTiersRech.FindField('Credit_Base').AsCurrency = DMDiocEtatBalT.QuEcritureBase.FindField('TotCredit').AsCurrency);
  if not Equilibre then
   begin
     if ListeTiersNonEquilibre <> nil then
       ListeTiersNonEquilibre.Add(DMRech.TaBalanceTiersRech.FindField('Tiers').AsString+
                                ' | '+
                                DMDiocEtatBalT.QuEcritureBase.FindField('Tiers').AsString+
//                                ' ## ReportD : '+
//                                DMRech.TaBalanceRech.FindField('Debit_Report').AsString+
//                                ' | '+
//                                DMDiocEtatBal.QuEcritureBase.FindField('Debit_Report').AsString+
//                                ' ## ReportC : '+
//                                DMRech.TaBalanceRech.FindField('Credit_Report').AsString+
//                                ' | '+
//                                DMDiocEtatBal.QuEcritureBase.FindField('Credit_Report').AsString+
                                ' ## BaseD : '+
                                DMRech.TaBalanceTiersRech.FindField('Debit_Base').AsString+
                                ' | '+
                                DMDiocEtatBalT.QuEcritureBase.FindField('Totdebit').AsString+
                                ' ## BaseC : '+
                                DMRech.TaBalanceTiersRech.FindField('Credit_Base').AsString+
                                ' | '+
                                DMDiocEtatBalT.QuEcritureBase.FindField('TotCredit').AsString
                                );
     result:= false;
   end;
  DMRech.TaBalanceTiersRech.Next;
  DMDiocEtatBalT.QuEcritureBase.Next;
 end;
finally
DeFiltrageDataSet(DMRech.TaBalanceTiersRech);
ListeTiersNonEquilibre.SaveToFile(e.RepertoireDossier+'ControleBalanceTiers.txt');
end;
End;


Function EditionBalanceTiers(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
  var NomFich,Chemin:String;
  var periode:TPeriode;
  var TaBalEdition:TTable;
  var deb_rep,cred_rep,
      deb_mvt,cred_mvt,
      deb_solde,cred_solde:Currency;
  var cpt1,cpt2,tiers:String;
ParamAffichPeriode:TParamAffichPeriode;

Begin

  Chemin :=E.RepertoireComptaWeb;
  NomFich:='BalanceTiers';
    Initialise_ParamAffichPeriode(ParamAffichPeriode);
    periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
  if periode.Retour then begin
      if DMDiocEtatBalT=nil then DMDiocEtatBalT:=TDMDiocEtatBalT.Create(Application.MainForm);
      if dataset = nil then begin
         // Prevu pour passer le dataset concerné
      end;

      DMDiocEtatBalT.CalculSurPeriode(periode.DateDeb,periode.DateFin);
      //Création de la table temporaire
      TaBalEdition:=TTable.Create(DMDiocEtatBalT);
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
        Name:='tiers';
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
      TaBalEdition.Active:=true;
      DMDiocEtatBalT.TaBalanceCalcT.Active:=true;
      DMDiocEtatBalT.TaBalanceCalcT.First;
      deb_solde:=0;
      cred_solde:=0;
      while not DMDiocEtatBalT.TaBalanceCalcT.Eof do begin
          deb_rep:=DMDiocEtatBalT.TaBalanceCalcT.FindField('Debit_Report_calc').AsCurrency-DMDiocEtatBalT.TaBalanceCalcT.FindField('Credit_Report_calc').AsCurrency;
          cred_rep:=DMDiocEtatBalT.TaBalanceCalcT.FindField('Credit_Report_calc').AsCurrency-DMDiocEtatBalT.TaBalanceCalcT.FindField('Debit_Report_calc').AsCurrency;
          if deb_rep<cred_rep then
            deb_rep:=0
          else
            cred_rep:=0;

          deb_mvt:=DMDiocEtatBalT.TaBalanceCalcT.FindField('Debit_base_calc').AsCurrency-DMDiocEtatBalT.TaBalanceCalcT.FindField('Credit_base_calc').AsCurrency;
          cred_mvt:=DMDiocEtatBalT.TaBalanceCalcT.FindField('Credit_base_calc').AsCurrency-DMDiocEtatBalT.TaBalanceCalcT.FindField('Debit_base_calc').AsCurrency;
          if deb_mvt<cred_mvt then
            deb_mvt:=0
          else
            cred_mvt:=0;

          deb_solde:=(DMDiocEtatBalT.TaBalanceCalcT.FindField('Debit_Report_calc').AsCurrency+DMDiocEtatBalT.TaBalanceCalcT.FindField('Debit_base_calc').AsCurrency)
                    -(DMDiocEtatBalT.TaBalanceCalcT.FindField('Credit_Report_calc').AsCurrency+DMDiocEtatBalT.TaBalanceCalcT.FindField('Credit_base_calc').AsCurrency);
          cred_solde:=(DMDiocEtatBalT.TaBalanceCalcT.FindField('Credit_base_calc').AsCurrency+DMDiocEtatBalT.TaBalanceCalcT.FindField('Credit_Report_calc').AsCurrency)
                    -(DMDiocEtatBalT.TaBalanceCalcT.FindField('Debit_Report_calc').AsCurrency+DMDiocEtatBalT.TaBalanceCalcT.FindField('Debit_base_calc').AsCurrency);
          if deb_solde<cred_solde then
            deb_solde:=0
          else
            cred_solde:=0;
            
          tiers:=copy(DMDiocEtatBalT.TaBalanceCalcT.FindField('Tiers').AsString,2,length(DMDiocEtatBalT.TaBalanceCalcT.FindField('Tiers').AsString)-1);

          TaBalEdition.AppendRecord([
            DMDiocEtatBalT.TaBalanceCalcT.FindField('Compte').AsString,
            tiers,
            DMDiocEtatBalT.TaBalanceCalcT.FindField('LibTiers').AsString,
            deb_rep,
            cred_rep,
            deb_mvt,
            cred_mvt,
            deb_solde,
            cred_solde
          ]);
          DMDiocEtatBalT.TaBalanceCalcT.Next;
      end;

      //choix des comptes
      DMDiocEtatBalT.QuTotalG.SQL.Clear;
      DMDiocEtatBalT.QuTotalG.SQL.Add('select distinct tiers from balanceEdition order by tiers');
      DMDiocEtatBalT.QuTotalG.Open;
      Cpt1:=DMDiocEtatBalT.QuTotalG.findfield('tiers').AsString;
      DMDiocEtatBalT.QuTotalG.Last;
      Cpt2:=DMDiocEtatBalT.QuTotalG.findfield('tiers').AsString;
      DMDiocEtatBalT.QuTotalG.Close;

      //liste des ruptures
      DMDiocEtatBalT.QuListeValRupt.SQL.Clear;
      DMDiocEtatBalT.QuListeValRupt.SQL.Add('select distinct compte from balanceEdition');
      DMDiocEtatBalT.QuListeValRupt.SQL.Add(' where tiers between '''+cpt1+''' and '''+cpt2+'''');
      DMDiocEtatBalT.QuListeValRupt.Open;

      //sous total
      DMDiocEtatBalT.QuSousTotal.SQL.Clear;
      DMDiocEtatBalT.QuSousTotal.Params.Clear;
      DMDiocEtatBalT.QuSousTotal.SQL.Add('select sum(debit_report),sum(credit_report),sum(debit_mvt),sum(credit_mvt),sum(debit_fin),sum(credit_fin) from balanceEdition where compte = :compte');
      DMDiocEtatBalT.QuSousTotal.SQL.Add(' and tiers between '''+cpt1+''' and '''+cpt2+'''');
      DMDiocEtatBalT.QuSousTotal.Params[0].DataType := ftString;
      DMDiocEtatBalT.QuSousTotal.Open;

      //total général
      DMDiocEtatBalT.QuTotalG.SQL.Clear;
      DMDiocEtatBalT.QuTotalG.Params.Clear;
      DMDiocEtatBalT.QuTotalG.SQL.Add('select sum(debit_report),sum(credit_report),sum(debit_mvt),sum(credit_mvt),sum(debit_fin),sum(credit_fin) from balanceEdition');
      DMDiocEtatBalT.QuTotalG.SQL.Add(' where tiers between '''+cpt1+''' and '''+cpt2+'''');
      DMDiocEtatBalT.QuTotalG.Open;

      //total debut + periode
      DMDiocEtatBalT.QuTotalG2.SQL.Clear;
      DMDiocEtatBalT.QuTotalG2.Params.Clear;
      DMDiocEtatBalT.QuTotalG2.SQL.Add('select sum(debit_report)+sum(debit_mvt),sum(credit_mvt)+sum(credit_report) from balanceEdition');
      DMDiocEtatBalT.QuTotalG2.SQL.Add(' where tiers between '''+cpt1+''' and '''+cpt2+'''');
      DMDiocEtatBalT.QuTotalG2.Open;

      case TypeEdition  of
          C_EditionSimple:Begin
                              Site.lien := false;
//                              EditBalanceTiers(Chemin,NomFich,TaBalEdition,'compte',DMDiocEtatBalT.QuListeValRupt,DMDiocEtatBalT.QuSousTotal,DMDiocEtatBalT.QuTotalG,DMDiocEtatBalT.QuTotalG2,cpt1,cpt2,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),Site);
                              ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                          End;
          C_EditionWeb: Begin
                            Site.lien := false;
                            //LienEditJournalPart(NomMenuSiteWeb,Chemin,NomFich,DMJournal.QuJournalPartEdition,'date',DMJournal.QuListeValRupt,DMJournal.QuSousTotal,DMJournal.QuTotalG,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),NomJournal,Site);
                            ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                        End;
      end;
      TaBalEdition.Close;
      DMDiocEtatBalT.QuListeValRupt.Close;
      DMDiocEtatBalT.QuSousTotal.Close;
      DMDiocEtatBalT.QuTotalG.Close;
      DMDiocEtatBalT.QuTotalG2.Close;
      TaBalEdition.Free;
  end;
End;

Function EditionBalanceTiersL(TypeEdition : integer; DemandePeriode:Boolean; ListeCompte:TStringList;DataSet:TDataSet;SautDePage:boolean):Boolean;
  var NomFich,Chemin:String;
  var periode:TPeriode;

EtatFiltre:TEtatFiltre;
ListeValeur,ListeEdition:TStringList;
ObjPrn:TObjetEdition;
ParamAffichPeriode:TParamAffichPeriode;
ClasseCompteTmp:String;
// Variable des totaux généraux par classes de compte
TotalReportDebit,TotalReportCredit,TotalBaseDebit,
TotalBaseCredit,TotalFinDebit,TotalFinCredit:Currency;
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
      ListeEdition:=TStringList.Create;
      ObjPrn.FontLigneSeule.Style := [fsBold];

      if DMDiocEtatBalT=nil then DMDiocEtatBalT:=TDMDiocEtatBalT.Create(Application.MainForm);
      if DMEcritures = nil then DMEcritures:=TDMEcritures.Create(Application.MainForm);
      
DMDiocEtatBalT.PeriodeExercice := ((periode.DateDeb=E.DatExoDebut) and (periode.DateFin = E.DatExoFin));

      DMEcritures.TaEcritureBalT.DisableControls;
      TableSauveEtatFiltre(DMEcritures.TaEcritureBalT,EtatFiltre);
      DeFiltrageDataSet(DMEcritures.TaEcritureBalT);
      DMEcritures.TaEcritureBalT.MasterSource :=  DMDiocEtatBalT.DaTaBalanceCalcT;
      if dataset = nil then begin
         // Prevu pour passer le dataset concerné
      end;
      DMDiocEtatBalT.QuEcritureReport.Close;
      DMDiocEtatBalT.QuEcritureBase.Close;

      DMDiocEtatBalT.CalculSurPeriode(periode.DateDeb,periode.DateFin);
      DeFiltrageDataSet(DMDiocEtatBalT.TaBalanceCalcT);

      if ListeCompte = nil then ListeCompte:=ChampTableVersListe('Tiers',DMDiocEtatBalT.TaBalanceCalcT);
      DMDiocEtatBalT.ListeFiltreEdit.Assign(ListeCompte);

      DMDiocEtatBalT.TaBalanceCalcT.Filtered := true;
      DMDiocEtatBalT.TaBalanceCalcT.OnFilterRecord:=DMDiocEtatBalT.TaBalanceCalcTFilterRecord;
      DMDiocEtatBalT.TaBalanceCalcT.Refresh;
      DMDiocEtatBalT.TaBalanceCalcT.First;
      if DMDiocEtatBalT.TaBalanceCalcT.recordcount<>0 then
      begin
//      deb_solde:=0;
//      cred_solde:=0;
      while not DMDiocEtatBalT.TaBalanceCalcT.Eof do
       begin
        ClasseCompteTmp :=DMDiocEtatBalT.TaBalanceCalcT.FindField('Compte').AsString;
        TotalReportDebit := DMDiocEtatBalT.TaBalanceCalcT.FindField('Solde_Debit_Report_Calc').AsCurrency + TotalReportDebit;
        TotalReportCredit := DMDiocEtatBalT.TaBalanceCalcT.FindField('Solde_Credit_Report_Calc').AsCurrency + TotalReportCredit;
        TotalBaseDebit := DMDiocEtatBalT.TaBalanceCalcT.FindField('Debit_Base_Calc').AsCurrency + TotalBaseDebit;
        TotalBaseCredit := DMDiocEtatBalT.TaBalanceCalcT.FindField('Credit_Base_Calc').AsCurrency + TotalBaseCredit;
        TotalFinDebit := DMDiocEtatBalT.TaBalanceCalcT.FindField('Solde_Debit_Total_Calc').AsCurrency + TotalFinDebit;
        TotalFinCredit := DMDiocEtatBalT.TaBalanceCalcT.FindField('Solde_Credit_Total_Calc').AsCurrency + TotalFinCredit;
         listeEdition.Add(GereLibelle(DMDiocEtatBalT.TaBalanceCalcT.FindField('Tiers').AsString)+
                         ';'+
                         GereLibelle(DMDiocEtatBalT.TaBalanceCalcT.FindField('Compte').AsString)+
                         ';'+
                         GereLibelle(DMDiocEtatBalT.TaBalanceCalcT.FindField('LibTiers').AsString)+
                         ';'+
                         DMDiocEtatBalT.TaBalanceCalcT.FindField('Solde_Debit_Report_Calc').AsString+
                         ';'+
                         DMDiocEtatBalT.TaBalanceCalcT.FindField('Solde_Credit_Report_Calc').AsString+
                         ';'+
                         DMDiocEtatBalT.TaBalanceCalcT.FindField('Debit_Base_Calc').AsString+
                         ';'+
                         DMDiocEtatBalT.TaBalanceCalcT.FindField('Credit_Base_Calc').AsString+
                         ';'+
                         DMDiocEtatBalT.TaBalanceCalcT.FindField('Solde_Debit_Total_Calc').AsString+
                         ';'+
                         DMDiocEtatBalT.TaBalanceCalcT.FindField('Solde_Credit_Total_Calc').AsString
                         );
         ListeValeur.Add('0'+
                         ';'+
                         GereLibelle(DMDiocEtatBalT.TaBalanceCalcT.FindField('Tiers').AsString)+
                         ';'+
                         GereLibelle(DMDiocEtatBalT.TaBalanceCalcT.FindField('LibTiers').AsString)+
                         ';'+
                         DMDiocEtatBalT.TaBalanceCalcT.FindField('Solde_Debit_Report_Calc').AsString+
                         ';'+
                         DMDiocEtatBalT.TaBalanceCalcT.FindField('Solde_Credit_Report_Calc').AsString+
                         ';'+
                         DMDiocEtatBalT.TaBalanceCalcT.FindField('Debit_Base_Calc').AsString+
                         ';'+
                         DMDiocEtatBalT.TaBalanceCalcT.FindField('Credit_Base_Calc').AsString+
                         ';'+
                         DMDiocEtatBalT.TaBalanceCalcT.FindField('Solde_Debit_Total_Calc').AsString+
                         ';'+
                         DMDiocEtatBalT.TaBalanceCalcT.FindField('Solde_Credit_Total_Calc').AsString
                         );

//         EditionEcritureL(0,C_TypeEditionLigneSimple,false,DMDiocEtatBal.TaBalanceCalc.FindField('Compte').AsString,LigneEdition,nil,Site);
//         ListeValeur.AddStrings(LigneEdition);

         DMDiocEtatBalT.TaBalanceCalcT.Next;
         if ClasseCompteTmp <> DMDiocEtatBalT.TaBalanceCalcT.FindField('Compte').AsString then
          begin
       ListeValeur.Add('16');
           ListeValeur.Add('3;; @TOTAL COMPTE COLLECTIF '+GereLibelle(ClasseCompteTmp) +' : ;'+
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
           ListeValeur.Add('1;; @Solde compte '+GereLibelle(ClasseCompteTmp) +' : ;'+
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

          TotalReportDebit := 0;
          TotalReportCredit := 0;
          TotalBaseDebit := 0;
          TotalBaseCredit := 0;
          TotalFinDebit := 0;
          TotalFinCredit := 0;
          if (sautDePage)then ListeValeur.add('20');
          ClasseCompteTmp :=DMDiocEtatBalT.TaBalanceCalcT.FindField('Compte').AsString;

          end;
      end;
       // Pour la dernière classe
       ListeValeur.Add('16');
       ListeValeur.Add('3;; @TOTAL COMPTE COLLECTIF '+GereLibelle(ClasseCompteTmp)+' : ;'+
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
           ListeValeur.Add('1;; @Solde compte '+GereLibelle(ClasseCompteTmp) +' : ;'+
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
       ListeValeur.Add('16');
       if (sautDePage)then ListeValeur.add('20');
       // Totaux Généraux
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

       ListeValeur.Add('1;; @Soldes totaux: ;'+
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

     ObjPrn.FTitreEdition := 'BALANCE TIERS DE L''EXERCICE';
     ObjPrn.FTitre2Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;
     ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
     ListeValeur.Insert(0,' Tiers ; Désignation ; Débit ; Crédit ; Débit ; Crédit ; Débit ; Crédit ');
     ListeValeur.Insert(1,'1.0;1.6;0.8;0.8;0.8;0.8;0.8;0.8');
     ListeValeur.Insert(2,'texte;texte;curr;curr;curr;curr;curr;curr');
     ListeValeur.Insert(3,'  ; Report Début ; Mouvement ; Solde Fin ;SURTITRE');
     ListeValeur.Insert(4,'2.6;1.6;1.6;1.6');
     ListeEdition.Insert(0,'Tiers;Compte;Désignation;Solde_Debit_Report;Solde_Credit_Report;Mouv_Debit;Mouv_Credit;Solde_Debit_Total;Solde_Credit_Total');
     end;//s'il y a des lignes de tiers à imprimer
     if TypeEdition=c_exportation then
       ExportDonnees(ListeEdition,E.RepertoireExportDossier, 'Bal_Tiers_'+E.NomDossier + E.NomExo + '.Txt')
     else
       ObjPrn.AffichageImp(ListeValeur);
      end;
Finally
  DMDiocEtatBalT.TaBalanceCalcT.OnFilterRecord:=nil;
  DeFiltrageDataSet(DMDiocEtatBalT.TaBalanceCalcT);
  TableRestoreEtatFiltre(DMEcritures.TaEcritureBalT,EtatFiltre);
  DMEcritures.TaEcritureBalT.MasterSource := DMDiocEtatBalT.DaBalanceT;
  ReEnableControls(DMEcritures.TaEcritureBalT);
     LibereObjet(Tobject(ObjPrn));
     Initialise_TStringlist(ListeEdition,nil);
//   ObjPrn.destroy;
end;
End;




procedure TDMDiocEtatBalT.TaBalanceaffichTCalcFields(DataSet: TDataSet);
begin
try
// Calcul du report
if QuEcritureReport.locate('Tiers',TaBalanceaffichTTiers.AsString,[]) then
 begin
  TaBalanceaffichTDebit_Report_Calc.AsCurrency:=0+TaBalanceaffichTDebit_Report.AsCurrency+QuEcritureReportTotDebit.AsCurrency;
//  TaBalanceaffichDebit_report_Query.AsCurrency;
  TaBalanceaffichTCredit_Report_Calc.AsCurrency:=0+TaBalanceaffichTCredit_Report.AsCurrency+QuEcritureReportTotCredit.AsCurrency;
  //TaBalanceaffichCredit_report_Query.AsCurrency;

 end
 else
 Begin
  TaBalanceaffichTDebit_Report_Calc.AsCurrency:=0+TaBalanceaffichTDebit_Report.AsCurrency;
  TaBalanceaffichTCredit_Report_Calc.AsCurrency:=0+TaBalanceaffichTCredit_Report.AsCurrency;
 End;


// Calcul des Solde Report
TaBalanceaffichTSolde_Debit_Report_Calc.AsCurrency:=0;
TaBalanceaffichTSolde_Credit_Report_Calc.AsCurrency:=0;
if TaBalanceaffichTDebit_Report_Calc.AsCurrency - TaBalanceaffichTCredit_Report_Calc.AsCurrency > 0 then
 Begin
   TaBalanceaffichTSolde_Debit_Report_Calc.AsCurrency:=TaBalanceaffichTDebit_Report_Calc.AsCurrency - TaBalanceaffichTCredit_Report_Calc.AsCurrency;
 End
 else
 Begin
  TaBalanceaffichTSolde_Credit_Report_Calc.AsCurrency:=TaBalanceaffichTCredit_Report_Calc.AsCurrency-TaBalanceaffichTDebit_Report_Calc.AsCurrency;
 End;


 // Calcul de totaux Base (mouvement de l'année)
TaBalanceaffichTDebit_Base_Calc.AsCurrency:=0+TaBalanceaffichTDebit_Base_QueryBase.AsCurrency;
TaBalanceaffichTCredit_Base_Calc.AsCurrency:=0+TaBalanceaffichTCredit_Base_QueryBase.AsCurrency;

// Calcul des Solde Base (solde des mouvement de l'année)

TaBalanceaffichTSolde_Debit_Base_Calc.AsCurrency:=0;
TaBalanceaffichTSolde_Credit_Base_Calc.AsCurrency:=0;
if TaBalanceaffichTDebit_Base_Calc.AsCurrency - TaBalanceaffichTCredit_Base_Calc.AsCurrency > 0 then
 Begin
   TaBalanceaffichTSolde_Debit_Base_Calc.AsCurrency:=TaBalanceaffichTDebit_Base_Calc.AsCurrency - TaBalanceaffichTCredit_Base_Calc.AsCurrency;
 End
 else
 Begin
  TaBalanceaffichTSolde_Credit_Base_Calc.AsCurrency:=TaBalanceaffichTCredit_Base_Calc.AsCurrency-TaBalanceaffichTDebit_Base_Calc.AsCurrency;
 End;

// Calcul Totaux Total
TaBalanceaffichTDebit_Total_Calc.AsCurrency:=TaBalanceaffichTDebit_Report_Calc.AsCurrency+TaBalanceaffichTDebit_Base_Calc.AsCurrency;
TaBalanceaffichTCredit_Total_Calc.AsCurrency:=TaBalanceaffichTCredit_Report_Calc.AsCurrency+TaBalanceaffichTCredit_Base_Calc.AsCurrency;

// Calcul des Solde Totaux
TaBalanceaffichTSolde_Debit_Total_Calc.AsCurrency:=0;
TaBalanceaffichTSolde_Credit_Total_Calc.AsCurrency:=0;

if TaBalanceaffichTDebit_Total_Calc.AsCurrency - TaBalanceaffichTCredit_Total_Calc.AsCurrency > 0 then
 Begin
   TaBalanceaffichTSolde_Debit_Total_Calc.AsCurrency:=TaBalanceaffichTDebit_Total_Calc.AsCurrency - TaBalanceaffichTCredit_Total_Calc.AsCurrency;
 End
 else
 Begin
  TaBalanceaffichTSolde_Credit_Total_Calc.AsCurrency:=TaBalanceaffichTCredit_Total_Calc.AsCurrency-TaBalanceaffichTDebit_Total_Calc.AsCurrency;
 End;
except
 showmessage('Erreur sur calcul balance Tiers');
end;
end;

Procedure TDMDiocEtatBalT.CalculSurPeriode(DateDeb,DateFin:TDate);
Begin
//QuEcritureReport.Close;
QuEcritureReport.ParamByName('DateDeb').AsDate:=E.DatExoDebut;
QuEcritureReport.ParamByName('DateFin').AsDate:=DateDeb;
   if QuEcritureReport.Active then
     QuEcritureReport.Refresh else QuEcritureReport.Open;

//QuEcritureBase.Close;
QuEcritureBase.ParamByName('DateDeb').AsDate:=DateDeb;
QuEcritureBase.ParamByName('DateFin').AsDate:=DateFin;
    if QuEcritureBase.Active then
     QuEcritureBase.Refresh else QuEcritureBase.Open;

if not TaBalanceaffichT.Active then TaBalanceaffichT.open;
TaBalanceaffichT.Refresh;

End;

Function TDMDiocEtatBalT.SommeTotauxBalanceT(DateDeb,DateFin:TDate;ListeFiltre:TStringList;ChampFiltre:String):TTotauxBalance;
Begin
QuEcritureReport.close;
QuEcritureBase.close;
TaBalanceafficht.DisableControls;
CalculSurPeriode(DateDeb,DateFin);
InitialiseTotauxBalance(result);
//TaBalanceafficht.Filter:='';
TaBalanceafficht.Filtered:=true;

TaBalanceafficht.Open;
TaBalanceafficht.First;
//if ListeFiltre <> nil then
// Begin
// if ListeFiltre.Count > 0 then
//  begin
//    TaBalanceafficht.Filter:=CreeFiltreOU(ChampFiltre,[ListeFiltre]);
//    TaBalanceafficht.Filtered:=true;
//  end;
// End;

while not TaBalanceafficht.EOF do
      Begin
       Result.TotalDebitReport:=Result.TotalDebitReport+TaBalanceafficht.FindField('Debit_report_calc').AsCurrency;
       Result.TotalCreditReport:=Result.TotalCreditReport+TaBalanceafficht.FindField('credit_report_calc').AsCurrency;

       //Calcul des soldes
       Result.TotalSoldeDebitReport:=Result.TotalSoldeDebitReport+TaBalanceafficht.FindField('Solde_Debit_Report_Calc').AsCurrency;
       Result.TotalSoldeCreditReport:=Result.TotalSoldeCreditReport+TaBalanceafficht.FindField('Solde_Credit_Report_Calc').AsCurrency;

       Result.TotalDebitBase:=Result.TotalDebitBase+TaBalanceaffichT.FindField('debit_Base_calc').AsCurrency;
       Result.TotalCreditBase:=Result.TotalCreditBase+TaBalanceaffichT.FindField('Credit_Base_calc').AsCurrency;

       Result.TotalDebitFin:=Result.TotalDebitBase+Result.TotalDebitReport;
       Result.TotalCreditFin:=Result.TotalCreditBase+Result.TotalCreditReport;

       Result.TotalDebitFin:=Result.TotalDebitBase+Result.TotalDebitReport;
       Result.TotalCreditFin:=Result.TotalCreditBase+Result.TotalCreditReport;

       //Calcul des soldes
       Result.TotalSoldeDebitTotal:=Result.TotalSoldeDebitTotal+TaBalanceaffichT.FindField('Solde_Debit_Total_Calc').AsCurrency;
       Result.TotalSoldeCreditTotal:=Result.TotalSoldeCreditTotal+TaBalanceaffichT.FindField('Solde_Credit_Total_Calc').AsCurrency;

       TaBalanceaffichT.Next;
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
TaBalanceaffichT.EnableControls;
end;

procedure TDMDiocEtatBalT.DMDiocEtatBalCreate(Sender: TObject);
begin
 PeriodeExercice:=false;
 ListeFiltreAffich:=TStringList.Create;
 ListeFiltreEdit := TStringList.Create;
 self.tag:=1;  //SIMULE

 TaBalanceCalcT.OnFilterRecord:=nil;
 TaBalanceaffichT.OnCalcFields:=nil;

if DMEcritures <> nil then
DMEcritures.TaEcritureBalT.Open
else
begin
 DMEcritures:=TDMEcritures.Create(Application.MainForm);
 DMEcritures.TaEcritureBalT.Open;
end;

OuvrirTouteTable('',TControl(self));
// TaBalanceaffichT.Open;
//QuEcritureReport.Open;
//QuEcritureBase.Open;
TaBalanceaffichT.OnCalcFields:=TaBalanceaffichTCalcFields;
//
TCurrencyField(TaBalanceaffichT.FindField('Solde_Debit_Report_Calc')).DisplayFormat:=E.FormatMonnaie;
TCurrencyField(TaBalanceaffichT.FindField('Solde_Credit_Report_Calc')).DisplayFormat:=E.FormatMonnaie;
TCurrencyField(TaBalanceaffichT.FindField('Debit_Base_Calc')).DisplayFormat:=E.FormatMonnaie;
TCurrencyField(TaBalanceaffichT.FindField('Credit_Base_Calc')).DisplayFormat:=E.FormatMonnaie;
TCurrencyField(TaBalanceaffichT.FindField('Solde_Debit_Total_Calc')).DisplayFormat:=E.FormatMonnaie;
TCurrencyField(TaBalanceaffichT.FindField('Solde_Credit_Total_Calc')).DisplayFormat:=E.FormatMonnaie;


end;

procedure TDMDiocEtatBalT.TaBalanceaffichTBeforeOpen(DataSet: TDataSet);
begin
OuvreTables('',[TaPlanCpt,QuEcritureReport,QuEcritureBase]);
if not QuEcritureBase.Active  then QuEcritureBase.Open;
if not QuEcritureReport.Active  then QuEcritureReport.Open;
end;

procedure TDMDiocEtatBalT.TaBalanceCalcTCalcFields(DataSet: TDataSet);
begin
  if PeriodeExercice then
   begin//si calcul sur bornes exercice
    try
    // Calcul du report
      TaBalanceCalcTDebit_Report_Calc.AsCurrency:=0+TaBalanceCalcTDebit_Report.AsCurrency;
      TaBalanceCalcTCredit_Report_Calc.AsCurrency:=0+TaBalanceCalcTCredit_Report.AsCurrency;
    // Calcul des Soldes Report
    TaBalanceCalcTSolde_Debit_Report_Calc.AsCurrency:=0;
    TaBalanceCalcTSolde_Credit_Report_Calc.AsCurrency:=0;
    if TaBalanceCalcTDebit_Report_Calc.AsCurrency - TaBalanceCalcTCredit_Report_Calc.AsCurrency > 0 then
     Begin
       TaBalanceCalcTSolde_Debit_Report_Calc.AsCurrency:=TaBalanceCalcTDebit_Report_Calc.AsCurrency - TaBalanceCalcTCredit_Report_Calc.AsCurrency;
     End
     else
     Begin
      TaBalanceCalcTSolde_Credit_Report_Calc.AsCurrency:=TaBalanceCalcTCredit_Report_Calc.AsCurrency-TaBalanceCalcTDebit_Report_Calc.AsCurrency;
     End;


     // Calcul de totaux Base (mouvement de l'année)
    TaBalanceCalcTDebit_Base_Calc.AsCurrency:=0+TaBalanceCalcTDebit_Base.AsCurrency;
    TaBalanceCalcTCredit_Base_Calc.AsCurrency:=0+TaBalanceCalcTCredit_Base.AsCurrency;
    // Calcul des Solde Base (solde des mouvement de l'année)

    TaBalanceCalcTSolde_Debit_Base_Calc.AsCurrency:=0;
    TaBalanceCalcTSolde_Credit_Base_Calc.AsCurrency:=0;
    if TaBalanceCalcTDebit_Base_Calc.AsCurrency - TaBalanceCalcTCredit_Base_Calc.AsCurrency > 0 then
     Begin
       TaBalanceCalcTSolde_Debit_Base_Calc.AsCurrency:=TaBalanceCalcTDebit_Base_Calc.AsCurrency - TaBalanceCalcTCredit_Base_Calc.AsCurrency;
     End
     else
     Begin
      TaBalanceCalcTSolde_Credit_Base_Calc.AsCurrency:=TaBalanceCalcTCredit_Base_Calc.AsCurrency-TaBalanceCalcTDebit_Base_Calc.AsCurrency;
     End;

    // Calcul Totaux Total
    TaBalanceCalcTDebit_Total_Calc.AsCurrency:=TaBalanceCalcTDebit_Report_Calc.AsCurrency+TaBalanceCalcTDebit_Base_Calc.AsCurrency;
    TaBalanceCalcTCredit_Total_Calc.AsCurrency:=TaBalanceCalcTCredit_Report_Calc.AsCurrency+TaBalanceCalcTCredit_Base_Calc.AsCurrency;
    // Calcul des Solde Totaux
    TaBalanceCalcTSolde_Debit_Total_Calc.AsCurrency:=0;
    TaBalanceCalcTSolde_Credit_Total_Calc.AsCurrency:=0;

    if TaBalanceCalcTDebit_Total_Calc.AsCurrency - TaBalanceCalcTCredit_Total_Calc.AsCurrency > 0 then
     Begin
       TaBalanceCalcTSolde_Debit_Total_Calc.AsCurrency:=TaBalanceCalcTDebit_Total_Calc.AsCurrency - TaBalanceCalcTCredit_Total_Calc.AsCurrency;
     End
     else
     Begin
      TaBalanceCalcTSolde_Credit_Total_Calc.AsCurrency:=TaBalanceCalcTCredit_Total_Calc.AsCurrency-TaBalanceCalcTDebit_Total_Calc.AsCurrency;
     End;
    except
     showmessage('Erreur sur calcul des reports');
    end;
   end //fin si calcul sur bornes exercice
  else
   begin//si calcul periode particulière
    try
    // Calcul du report
      if QuEcritureReport.locate('Tiers',TaBalanceCalcTTiers.AsString,[]) then
       begin
        TaBalanceCalcTDebit_Report_Calc.AsCurrency:=0+TaBalanceCalcTDebit_Report.AsCurrency+QuEcritureReportTotDebit.AsCurrency;
      //  TaBalanceCalcDebit_report_Query.AsCurrency;
        TaBalanceCalcTCredit_Report_Calc.AsCurrency:=0+TaBalanceCalcTCredit_Report.AsCurrency+QuEcritureReportTotCredit.AsCurrency;
        //TaBalanceCalcCredit_report_Query.AsCurrency;

       end
       else
       Begin
        TaBalanceCalcTDebit_Report_Calc.AsCurrency:=0+TaBalanceCalcTDebit_Report.AsCurrency;
        TaBalanceCalcTCredit_Report_Calc.AsCurrency:=0+TaBalanceCalcTCredit_Report.AsCurrency;
       End;


      // Calcul des Solde Report
      TaBalanceCalcTSolde_Debit_Report_Calc.AsCurrency:=0;
      TaBalanceCalcTSolde_Credit_Report_Calc.AsCurrency:=0;
      if TaBalanceCalcTDebit_Report_Calc.AsCurrency - TaBalanceCalcTCredit_Report_Calc.AsCurrency > 0 then
       Begin
         TaBalanceCalcTSolde_Debit_Report_Calc.AsCurrency:=TaBalanceCalcTDebit_Report_Calc.AsCurrency - TaBalanceCalcTCredit_Report_Calc.AsCurrency;
       End
       else
       Begin
        TaBalanceCalcTSolde_Credit_Report_Calc.AsCurrency:=TaBalanceCalcTCredit_Report_Calc.AsCurrency-TaBalanceCalcTDebit_Report_Calc.AsCurrency;
       End;


       // Calcul de totaux Base (mouvement de l'année)
      TaBalanceCalcTDebit_Base_Calc.AsCurrency:=0+TaBalanceCalcTDebit_Base_QueryBase.AsCurrency;
      TaBalanceCalcTCredit_Base_Calc.AsCurrency:=0+TaBalanceCalcTCredit_Base_QueryBase.AsCurrency;

      // Calcul des Solde Base (solde des mouvement de l'année)

      TaBalanceCalcTSolde_Debit_Base_Calc.AsCurrency:=0;
      TaBalanceCalcTSolde_Credit_Base_Calc.AsCurrency:=0;
      if TaBalanceCalcTDebit_Base_Calc.AsCurrency - TaBalanceCalcTCredit_Base_Calc.AsCurrency > 0 then
       Begin
         TaBalanceCalcTSolde_Debit_Base_Calc.AsCurrency:=TaBalanceCalcTDebit_Base_Calc.AsCurrency - TaBalanceCalcTCredit_Base_Calc.AsCurrency;
       End
       else
       Begin
        TaBalanceCalcTSolde_Credit_Base_Calc.AsCurrency:=TaBalanceCalcTCredit_Base_Calc.AsCurrency-TaBalanceCalcTDebit_Base_Calc.AsCurrency;
       End;

      // Calcul Totaux Total
      TaBalanceCalcTDebit_Total_Calc.AsCurrency:=TaBalanceCalcTDebit_Report_Calc.AsCurrency+TaBalanceCalcTDebit_Base_Calc.AsCurrency;
      TaBalanceCalcTCredit_Total_Calc.AsCurrency:=TaBalanceCalcTCredit_Report_Calc.AsCurrency+TaBalanceCalcTCredit_Base_Calc.AsCurrency;

      // Calcul des Solde Totaux
      TaBalanceCalcTSolde_Debit_Total_Calc.AsCurrency:=0;
      TaBalanceCalcTSolde_Credit_Total_Calc.AsCurrency:=0;

      if TaBalanceCalcTDebit_Total_Calc.AsCurrency - TaBalanceCalcTCredit_Total_Calc.AsCurrency > 0 then
       Begin
         TaBalanceCalcTSolde_Debit_Total_Calc.AsCurrency:=TaBalanceCalcTDebit_Total_Calc.AsCurrency - TaBalanceCalcTCredit_Total_Calc.AsCurrency;
       End
       else
       Begin
        TaBalanceCalcTSolde_Credit_Total_Calc.AsCurrency:=TaBalanceCalcTCredit_Total_Calc.AsCurrency-TaBalanceCalcTDebit_Total_Calc.AsCurrency;
       End;
    except
     showmessage('Erreur sur calcul des reports');
    end;
   end;//fin si calcul periode particulière

//begin
//try
//// Calcul du report
//if QuEcritureReport.locate('Tiers',TaBalanceCalcTTiers.AsString,[]) then
// begin
//  TaBalanceCalcTDebit_Report_Calc.AsCurrency:=0+TaBalanceCalcTDebit_Report.AsCurrency+QuEcritureReportTotDebit.AsCurrency;
////  TaBalanceCalcDebit_report_Query.AsCurrency;
//  TaBalanceCalcTCredit_Report_Calc.AsCurrency:=0+TaBalanceCalcTCredit_Report.AsCurrency+QuEcritureReportTotCredit.AsCurrency;
//  //TaBalanceCalcCredit_report_Query.AsCurrency;
//
// end
// else
// Begin
//  TaBalanceCalcTDebit_Report_Calc.AsCurrency:=0+TaBalanceCalcTDebit_Report.AsCurrency;
//  TaBalanceCalcTCredit_Report_Calc.AsCurrency:=0+TaBalanceCalcTCredit_Report.AsCurrency;
// End;
//
//
//// Calcul des Solde Report
//TaBalanceCalcTSolde_Debit_Report_Calc.AsCurrency:=0;
//TaBalanceCalcTSolde_Credit_Report_Calc.AsCurrency:=0;
//if TaBalanceCalcTDebit_Report_Calc.AsCurrency - TaBalanceCalcTCredit_Report_Calc.AsCurrency > 0 then
// Begin
//   TaBalanceCalcTSolde_Debit_Report_Calc.AsCurrency:=TaBalanceCalcTDebit_Report_Calc.AsCurrency - TaBalanceCalcTCredit_Report_Calc.AsCurrency;
// End
// else
// Begin
//  TaBalanceCalcTSolde_Credit_Report_Calc.AsCurrency:=TaBalanceCalcTCredit_Report_Calc.AsCurrency-TaBalanceCalcTDebit_Report_Calc.AsCurrency;
// End;
//
//
// // Calcul de totaux Base (mouvement de l'année)
//TaBalanceCalcTDebit_Base_Calc.AsCurrency:=0+TaBalanceCalcTDebit_Base_QueryBase.AsCurrency;
//TaBalanceCalcTCredit_Base_Calc.AsCurrency:=0+TaBalanceCalcTCredit_Base_QueryBase.AsCurrency;
//
//// Calcul des Solde Base (solde des mouvement de l'année)
//
//TaBalanceCalcTSolde_Debit_Base_Calc.AsCurrency:=0;
//TaBalanceCalcTSolde_Credit_Base_Calc.AsCurrency:=0;
//if TaBalanceCalcTDebit_Base_Calc.AsCurrency - TaBalanceCalcTCredit_Base_Calc.AsCurrency > 0 then
// Begin
//   TaBalanceCalcTSolde_Debit_Base_Calc.AsCurrency:=TaBalanceCalcTDebit_Base_Calc.AsCurrency - TaBalanceCalcTCredit_Base_Calc.AsCurrency;
// End
// else
// Begin
//  TaBalanceCalcTSolde_Credit_Base_Calc.AsCurrency:=TaBalanceCalcTCredit_Base_Calc.AsCurrency-TaBalanceCalcTDebit_Base_Calc.AsCurrency;
// End;
//
//// Calcul Totaux Total
//TaBalanceCalcTDebit_Total_Calc.AsCurrency:=TaBalanceCalcTDebit_Report_Calc.AsCurrency+TaBalanceCalcTDebit_Base_Calc.AsCurrency;
//TaBalanceCalcTCredit_Total_Calc.AsCurrency:=TaBalanceCalcTCredit_Report_Calc.AsCurrency+TaBalanceCalcTCredit_Base_Calc.AsCurrency;
//
//// Calcul des Solde Totaux
//TaBalanceCalcTSolde_Debit_Total_Calc.AsCurrency:=0;
//TaBalanceCalcTSolde_Credit_Total_Calc.AsCurrency:=0;
//
//if TaBalanceCalcTDebit_Total_Calc.AsCurrency - TaBalanceCalcTCredit_Total_Calc.AsCurrency > 0 then
// Begin
//   TaBalanceCalcTSolde_Debit_Total_Calc.AsCurrency:=TaBalanceCalcTDebit_Total_Calc.AsCurrency - TaBalanceCalcTCredit_Total_Calc.AsCurrency;
// End
// else
// Begin
//  TaBalanceCalcTSolde_Credit_Total_Calc.AsCurrency:=TaBalanceCalcTCredit_Total_Calc.AsCurrency-TaBalanceCalcTDebit_Total_Calc.AsCurrency;
// End;
//except
// showmessage('Erreur sur calcul des reports');
//end;
//
//end;

end;



Function TDMDiocEtatBalT.SommeTotauxBalanceTCalc(DateDeb,DateFin:TDate;ListeFiltre:TStringList;ChampFiltre:String;ForcerClose:boolean):TTotauxBalance;
Begin
TaBalanceCalcT.Close;

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
TaBalanceCalcT.TableName:='Balance.DB'
else
if Uppercase(ChampFiltre) = Uppercase('Tiers') then
TaBalanceCalcT.TableName:='BalanceTiers.DB';

TaBalanceCalcT.DisableControls;

PeriodeExercice := ((DateDeb=E.DatExoDebut) and (DateFin = E.DatExoFin));

if Type_version_execution=CT_DISTRIBUTION then
  PeriodeExercice := false; // A remettre si le calcul Balance issue de la lecture de la
                          // table balance ne marche pas !!!!!
if not PeriodeExercice then
  CalculSurPeriode(DateDeb,DateFin)
else
  begin
    QuEcritureReport.ParamByName('DateDeb').AsDate:=DateDeb;
    QuEcritureReport.ParamByName('DateFin').AsDate:=DateDeb;
    if QuEcritureReport.Active then
     QuEcritureReport.Refresh else QuEcritureReport.Open;
    //
    QuEcritureBase.ParamByName('DateDeb').AsDate:=DateDeb;
    QuEcritureBase.ParamByName('DateFin').AsDate:=DateFin;
    if QuEcritureBase.Active then
     QuEcritureBase.Refresh else QuEcritureBase.Open;
  end;

InitialiseTotauxBalance(result);

TaBalanceCalcT.Filter:='';
TaBalanceCalcT.Filtered:=false;

if ListeFiltre <> nil then
 Begin
 if ListeFiltre.Count > 0 then
  begin
    TaBalanceCalcT.Filter:=CreeFiltreOU(ChampFiltre,[ListeFiltre]);
    TaBalanceCalcT.Filtered:=true;
  end;
 End;
TaBalanceCalcT.Open;
TaBalanceCalcT.First;
if PeriodeExercice then
 begin//si période dans bornes exercice
  while not TaBalanceCalcT.EOF do
    Begin
     Result.TotalDebitReport:=Result.TotalDebitReport+TaBalanceCalcT.FindField('Debit_report').AsCurrency;
     Result.TotalCreditReport:=Result.TotalCreditReport+TaBalanceCalcT.FindField('credit_report').AsCurrency;
     //Calcul des soldes
     Result.TotalSoldeDebitReport:=Result.TotalDebitReport;
     Result.TotalSoldeCreditReport:=Result.TotalCreditReport;

     Result.TotalDebitBase:=Result.TotalDebitBase+TaBalanceCalcT.FindField('debit_Base').AsCurrency;
     Result.TotalCreditBase:=Result.TotalCreditBase+TaBalanceCalcT.FindField('Credit_Base').AsCurrency;
     Result.TotalDebitFin:=Result.TotalDebitBase+Result.TotalDebitReport;
     Result.TotalCreditFin:=Result.TotalCreditBase+Result.TotalCreditReport;
     //Calcul des soldes
     Result.TotalSoldeDebitTotal:=Result.TotalSoldeDebitTotal+TaBalanceCalcT.FindField('Solde_Debit_Total_Calc').AsCurrency;
     Result.TotalSoldeCreditTotal:=Result.TotalSoldeCreditTotal+TaBalanceCalcT.FindField('Solde_Credit_Total_Calc').AsCurrency;

     TaBalanceCalcT.Next;
    End;
 end //fin si période dans bornes exercice
else
 begin//si période particulière
  while not TaBalanceCalcT.EOF do
    Begin
     Result.TotalDebitReport:=Result.TotalDebitReport+TaBalanceCalcT.FindField('Debit_report_calc').AsCurrency;
     Result.TotalCreditReport:=Result.TotalCreditReport+TaBalanceCalcT.FindField('credit_report_calc').AsCurrency;
     //Calcul des soldes
     Result.TotalSoldeDebitReport:=Result.TotalSoldeDebitReport+TaBalanceCalcT.FindField('Solde_Debit_Report_Calc').AsCurrency;
     Result.TotalSoldeCreditReport:=Result.TotalSoldeCreditReport+TaBalanceCalcT.FindField('Solde_Credit_Report_Calc').AsCurrency;

     Result.TotalDebitBase:=Result.TotalDebitBase+TaBalanceCalcT.FindField('debit_Base_calc').AsCurrency;
     Result.TotalCreditBase:=Result.TotalCreditBase+TaBalanceCalcT.FindField('Credit_Base_calc').AsCurrency;

     Result.TotalDebitFin:=Result.TotalDebitBase+Result.TotalDebitReport;
     Result.TotalCreditFin:=Result.TotalCreditBase+Result.TotalCreditReport;

     //Calcul des soldes
     Result.TotalSoldeDebitTotal:=Result.TotalSoldeDebitTotal+TaBalanceCalcT.FindField('Solde_Debit_Total_Calc').AsCurrency;
     Result.TotalSoldeCreditTotal:=Result.TotalSoldeCreditTotal+TaBalanceCalcT.FindField('Solde_Credit_Total_Calc').AsCurrency;

     TaBalanceCalcT.Next;
    End;
 end;//fin si période particulière

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
 Result.SoldeReport:=abs(Result.SoldeReport);
 Result.SoldeBase:=abs(Result.SoldeBase);
 Result.SoldeFin:=abs(Result.SoldeFin);

End;


//Function TDMDiocEtatBalT.SommeTotauxBalanceTCalc(DateDeb,DateFin:TDate;ListeFiltre:TStringList;ChampFiltre:String):TTotauxBalance;
//Begin
//TaBalanceCalcT.Close;
//if Uppercase(ChampFiltre) = Uppercase('Compte') then
//TaBalanceCalcT.TableName:='Balance.DB'
//else
//if Uppercase(ChampFiltre) = Uppercase('Tiers') then
//TaBalanceCalcT.TableName:='BalanceTiers.DB';
//
//TaBalanceCalcT.DisableControls;
//CalculSurPeriode(DateDeb,DateFin);
//
//InitialiseTotauxBalance(result);
//
//TaBalanceCalcT.Filter:='';
//TaBalanceCalcT.Filtered:=false;
//
//TaBalanceCalcT.Open;
//TaBalanceCalcT.First;
//if ListeFiltre <> nil then
// Begin
// if ListeFiltre.Count > 0 then
//  begin
//    TaBalanceCalcT.Filter:=CreeFiltreOU(ChampFiltre,[ListeFiltre]);
//    TaBalanceCalcT.Filtered:=true;
//  end;
// End;
//
//while not TaBalanceCalcT.EOF do
//      Begin
//       Result.TotalDebitReport:=Result.TotalDebitReport+TaBalanceCalcT.FindField('Debit_report_calc').AsCurrency;
//       Result.TotalCreditReport:=Result.TotalCreditReport+TaBalanceCalcT.FindField('credit_report_calc').AsCurrency;
//
//       //Calcul des soldes
//       Result.TotalSoldeDebitReport:=Result.TotalSoldeDebitReport+TaBalanceCalcT.FindField('Solde_Debit_Report_Calc').AsCurrency;
//       Result.TotalSoldeCreditReport:=Result.TotalSoldeCreditReport+TaBalanceCalcT.FindField('Solde_Credit_Report_Calc').AsCurrency;
//
//       Result.TotalDebitBase:=Result.TotalDebitBase+TaBalanceCalcT.FindField('debit_Base_calc').AsCurrency;
//       Result.TotalCreditBase:=Result.TotalCreditBase+TaBalanceCalcT.FindField('Credit_Base_calc').AsCurrency;
//
//       Result.TotalDebitFin:=Result.TotalDebitBase+Result.TotalDebitReport;
//       Result.TotalCreditFin:=Result.TotalCreditBase+Result.TotalCreditReport;
//
//       Result.TotalDebitFin:=Result.TotalDebitBase+Result.TotalDebitReport;
//       Result.TotalCreditFin:=Result.TotalCreditBase+Result.TotalCreditReport;
//
//       //Calcul des soldes
//       Result.TotalSoldeDebitTotal:=Result.TotalSoldeDebitTotal+TaBalanceCalcT.FindField('Solde_Debit_Total_Calc').AsCurrency;
//       Result.TotalSoldeCreditTotal:=Result.TotalSoldeCreditTotal+TaBalanceCalcT.FindField('Solde_Credit_Total_Calc').AsCurrency;
//
//       TaBalanceCalcT.Next;
//      End;
// Result.SoldeReport:=Result.TotalSoldeDebitReport-Result.TotalSoldeCreditReport;
// Result.SoldeBase:=Result.TotalDebitBase-Result.TotalCreditBase;
// Result.SoldeFin:=Result.TotalSoldeDebitTotal-Result.TotalSoldeCreditTotal;
// if Result.SoldeReport > 0 then
//    begin
//     Result.SoldeDebitCreditReport:=true;
//    end
//    else
//    begin
//     Result.SoldeDebitCreditReport:=False;
//    end;
// if Result.SoldeBase > 0 then
//    begin
//     Result.SoldeDebitCreditBase:=true;
//    end
//    else
//    begin
//     Result.SoldeDebitCreditBase:=false;
//    end;
// if Result.SoldeFin > 0 then
//    begin
//     Result.SoldeDebitCreditFin:=true;
//    end
//    else
//    begin
//      Result.SoldeDebitCreditFin:=false;
//    end;
// Result.SoldeReport:=abs(Result.SoldeReport);
// Result.SoldeBase:=abs(Result.SoldeBase);
// Result.SoldeFin:=abs(Result.SoldeFin);
////Dataset.GotoBookmark(TempBookmark);
////Dataset.FreeBookmark(TempBookmark);
//
//End;

Function TDMDiocEtatBalT.SommeTotauxBalanceParTiers(DateDeb,DateFin:TDate;Compte:String;ForcerClose:Boolean):TTotauxBalance;
var
ListeCpt:TStringList;
Begin
ListeCpt:=TStringList.Create;
ListeCpt.Add(Compte);
if copy(Compte,1,1)='+' then
 begin
  result:=SommeTotauxBalanceTCalc(DateDeb,DAteFin,ListeCpt,'Tiers',ForcerClose);
 end
  else
 begin
  result:=SommeTotauxBalanceTCalc(DateDeb,DAteFin,ListeCpt,'Compte',ForcerClose);
 end;
ListeCpt.Free;
ListeCpt:=nil;
End;

procedure TDMDiocEtatBalT.TaBalanceaffichTBeforeInsert(DataSet: TDataSet);
begin
abort;
end;

procedure TDMDiocEtatBalT.TaBalanceaffichTBeforeEdit(DataSet: TDataSet);
begin
abort;
end;

procedure TDMDiocEtatBalT.TaBalanceaffichTBeforeDelete(DataSet: TDataSet);
begin
abort;
end;

procedure TDMDiocEtatBalT.TaBalanceCalcTFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
Accept:=ListeFiltreEdit.IndexOf(DAtaSet.findField('Tiers').AsString) <> -1;
end;
procedure TDMDiocEtatBalT.DataModuleDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
ListeFiltreAffich.Free;
ListeFiltreEdit.Free;
DMDiocEtatBalT := nil;
end;


procedure TDMDiocEtatBalT.TaBalanceCalcTBeforeRefresh(DataSet: TDataSet);
begin
if not QuEcritureReport.Active  then QuEcritureReport.Open;
if not QuEcritureBase.Active  then QuEcritureBase.Open;
TaPlanCpt.Refresh;
QuEcritureReport.Refresh;
QuEcritureBase.Refresh;
end;
procedure TDMDiocEtatBalT.TaBalanceaffichTFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
accept := ((ListeFiltreAffich.IndexOf(DataSet.FindField('Tiers').AsString) <> -1) or (ListeFiltreAffich.Count=0));
end;

end.
