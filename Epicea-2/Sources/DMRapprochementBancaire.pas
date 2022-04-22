unit DMRapprochementBancaire;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,LibSQL,E2_Librairie_Obj,E2_Decl_Records,Gr_Librairie_Obj,
  ObjetEdition,
  LibFichRep,
  editions,shellapi,lib_chaine,libdates;

type
  TDMRappBanc = class(TDataModule)
    TaEcr_RappBanc: TTable;
    DaEcr_RappBanc: TDataSource;
    QuSumRappNonMarque: TQuery;
    QuSumRappMarque: TQuery;
    QuListeMarque: TQuery;
    QuSumRappParMarque: TQuery;
    QuSumRappNonMarqueAvantDate: TQuery;
    QuSousTotal: TQuery;
    QuTotalG: TQuery;
    QuRapprochementEdition: TQuery;
    QuSoldeEdition: TQuery;
    QuTotalGdebit_solde_releve: TCurrencyField;
    QuTotalGcredit_solde_releve: TCurrencyField;
    TaReleveTemp: TTable;
    TaReferencePiece: TTable;
    TaEcr_RappBancID: TIntegerField;
    TaEcr_RappBancID_Piece: TIntegerField;
    TaEcr_RappBancTypeLigne: TStringField;
    TaEcr_RappBancID_Ligne: TSmallintField;
    TaEcr_RappBancDate: TDateField;
    TaEcr_RappBancCompte: TStringField;
    TaEcr_RappBancTiers: TStringField;
    TaEcr_RappBancLibelle: TStringField;
    TaEcr_RappBancQt1: TFloatField;
    TaEcr_RappBancQt2: TFloatField;
    TaEcr_RappBancDebitSaisie: TCurrencyField;
    TaEcr_RappBancCreditSaisie: TCurrencyField;
    TaEcr_RappBancID_Devise: TIntegerField;
    TaEcr_RappBancDebit: TCurrencyField;
    TaEcr_RappBancCredit: TCurrencyField;
    TaEcr_RappBancTvaCode: TStringField;
    TaEcr_RappBancTvaType: TStringField;
    TaEcr_RappBancTvaTaux: TFloatField;
    TaEcr_RappBancTvaDate: TDateField;
    TaEcr_RappBancRapprochement: TStringField;
    TaEcr_RappBancValidation: TDateField;
    TaEcr_RappBancQui: TStringField;
    TaEcr_RappBancQuand: TDateTimeField;
    TaEcr_RappBancNum_Cheque: TStringField;
    TaEcr_RappBancTable_Gen: TStringField;
    TaEcr_RappBancChamp_Gen: TStringField;
    TaEcr_RappBancVal_Champ_Gen: TStringField;
    TaEcr_RappBancID_GESTCO: TFloatField;
    TaEcr_RappBancCODE_GESTCO: TStringField;
    TaEcr_RappBancMontant_Tva: TCurrencyField;
    TaEcr_RappBancID_GESTANAL: TIntegerField;
    TaEcr_RappBancCODE_GESTANAL: TStringField;
    TaEcr_RappBancMarqueReleve: TStringField;
    TaEcr_RappBancReferencePiece: TStringField;
    procedure DMRappBancCreate(Sender: TObject);
    procedure DMRappBancDestroy(Sender: TObject);
    procedure TaEcr_RappBancAfterOpen(DataSet: TDataSet);
    procedure TaEcr_RappBancFilterRecord_EnCours(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaEcr_RappBancFilterRecord_NonMarque(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaEcr_RappBancFilterRecord_Marque(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaEcr_RappBancFilterRecord_MarqueSpecifique(DataSet: TDataSet;
             var Accept: Boolean);
    procedure TaEcr_RappBancFilterRecord_DemarquageEnCours(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaEcr_RappBancFilterRecord_Tous(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaEcr_RappBancBeforeInsert(DataSet: TDataSet);
    procedure TaEcr_RappBancBeforePost(DataSet: TDataSet);
    procedure TaEcr_RappBancBeforeDelete(DataSet: TDataSet);
    Function  SommeRappNonMarqueAvantDate(Compte:String;DateFin:TDate):TTotauxCompte;
    Function ListeMarque(CompteBanque:String):TStringList;
    procedure QuTotalGCalcFields(DataSet: TDataSet);
    procedure TaEcr_RappBancBeforeEdit(DataSet: TDataSet);
    procedure TaEcr_RappBancBeforeOpen(DataSet: TDataSet);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    ListeMarquageEnCours:TStringList;
    marqueSpecifique:string;
    MarqueCourante:String;
    OldMarqueReleve,OldMarqueRapprochement:string;
    GererReleveDirect:boolean;
  end;

  Function CalculTotauxRappBanc(CompteBanque:String;TypeCalcul:Integer;DateDeb,DateFin:Tdate):TTotauxRappBanc;
  Function EditionEtatRapprochementL(Compte:String;TypeEdition : integer;TypeAffichage:integer; DataSet:TDataSet):Boolean;
  Function EditionRapprochement(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
  Function EditionEtatRapprochement(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;

var
  DMRappBanc: TDMRappBanc;

implementation

uses DMRecherche, DMDiocEtatBalance, DmImportReleves;

{$R *.DFM}
Function CalculTotauxRappBanc(CompteBanque:String;TypeCalcul:Integer;DateDeb,DateFin:Tdate):TTotauxRappBanc;
var
  SoldeDebit,SoldeCredit:Currency;
  TotauxCompte_:TTotauxCompte;
  TotauxReport_:TTotauxBalance;
Debut,Fin:TTime;
Begin
      Debut:=Time;
  if DMRappBanc=nil then DMRappBanc:=TDMRappBanc.Create(Application.MainForm);
  if DMDiocEtatBal = nil then DMDiocEtatBal:=TDMDiocEtatBal.Create(Application.MainForm);
  Initialise_TotauxRappBanc(Result);
  InitialiseTotauxBalance(TotauxReport_);
  Initialise_TotauxCompte(TotauxCompte_);
  case TypeCalcul of
      C_CalculerTout:Begin
//                       TotauxReport_:=DMDiocEtatBal.SommeTotauxBalanceParCompte(E.DatExoDebut,E.DatExoFin,CompteBanque);
                       //TotauxCompte_:=DMRappBanc.SommeRappNonMarqueAvantDate(CompteBanque,E.DatExoDebut);

                       TotauxReport_:=DMDiocEtatBal.SommeTotauxBalanceParCompte(DateDeb,DateFin,CompteBanque);
                       TotauxCompte_:=DMRappBanc.SommeRappNonMarqueAvantDate(CompteBanque,DateDeb-1);

                       // Si le solde de la balance report debut est débiteur
                       // alors on ajoute a ce solde le solde créditeur des mvt non marqué avant date
                       // et on soustrait à ce solde le solde débiteur des mvt !
                       if TotauxReport_.SoldeDebitCreditReport then
                        begin
                         SoldeDebit:=TotauxReport_.TotalSoldeDebitReport + TotauxCompte_.SoldeCredit - TotauxCompte_.SoldeDebit;
                         SoldeCredit :=0;
                         if SoldeDebit < 0 then
                          begin
                           SoldeCredit := - SoldeDebit;
                           SoldeDebit := 0;
                          end;
                        end
                       else
                       // Si le solde de la balance report début est Créditeur
                       // alors on soustrait à ce solde le solde créditeur des mvt non marqué avant date
                       // et on ajoute à ce solde le solde débiteur des mvt !
                        begin
                         SoldeDebit := 0;
                         SoldeCredit:=TotauxReport_.TotalSoldeCreditReport - TotauxCompte_.SoldeCredit + TotauxCompte_.SoldeDebit;
                         if SoldeCredit < 0 then
                          Begin
                           SoldeDebit := - SoldeCredit;
                           SoldeCredit := 0;
                          End;

                        end;

                        result.SoldeReportDebit:=TotauxReport_.TotalDebitReport;
                        result.SoldeReportCredit:=TotauxReport_.TotalCreditReport;
                        DetermineSolde(result.SoldeReportDebit,result.SoldeReportCredit);

                        result.SoldeReportReleveBanqueDebit := SoldeDebit;
                        result.SoldeReportReleveBanqueCredit := SoldeCredit;

                        result.TotalMvtCompteDebit := TotauxReport_.TotalDebitFin;
                        result.TotalMvtCompteCredit := TotauxReport_.TotalCreditFin;

                        result.SoldeCompteDebit := TotauxReport_.TotalSoldeDebitTotal;
                        result.SoldeCompteCredit := TotauxReport_.TotalSoldeCreditTotal;

                     End;
      C_CalculerReportReleveBanque:;
      C_CalculerTotalMvtCompte:;
      C_CalculerSoldeCompte:;
      C_CalculerTotalMvtCompteNonMarque:;
      C_CalculerSoldeReleveBanque:begin
                                   TotauxReport_:=DMDiocEtatBal.SommeTotauxBalanceParCompte(DateDeb,DateFin,CompteBanque);
                                   TotauxCompte_:=DMRappBanc.SommeRappNonMarqueAvantDate(CompteBanque,DateFin);

                                    result.SoldeReportDebit:=TotauxReport_.TotalDebitReport;
                                    result.SoldeReportCredit:=TotauxReport_.TotalCreditReport;
                                    DetermineSolde(result.SoldeReportDebit,result.SoldeReportCredit);

                                   Result.TotalMvtCompteNonMarqueDebit:=TotauxCompte_.TotalDebit;
                                   Result.TotalMvtCompteNonMarqueCredit:=TotauxCompte_.TotalCredit;
                                   if TotauxReport_.SoldeDebitCreditFin then
                                    begin
                                     Result.SoldeReleveBanqueDebit:=TotauxReport_.TotalSoldeDebitTotal + TotauxCompte_.TotalCredit - TotauxCompte_.TotalDebit;
                                     Result.SoldeReleveBanqueCredit:=0;
                                     if Result.SoldeReleveBanqueDebit < 0 then
                                      begin
                                        Result.SoldeReleveBanqueCredit:= -Result.SoldeReleveBanqueDebit;
                                        Result.SoldeReleveBanqueDebit :=0;
                                      end;
                                    end
                                   else
                                    begin
                                     Result.SoldeReleveBanqueCredit:=TotauxReport_.TotalSoldeCreditTotal - TotauxCompte_.TotalCredit + TotauxCompte_.TotalDebit;
                                     Result.SoldeReleveBanqueDebit:=0;
                                     if Result.SoldeReleveBanqueCredit < 0 then
                                      begin
                                        Result.SoldeReleveBanqueDebit:= -Result.SoldeReleveBanqueCredit;
                                        Result.SoldeReleveBanqueCredit :=0;
                                      end;
                                    end;

                                  end;
  else MessageDlg('CalculTotauxRappBanc:TypeCalcul inconnu', mtWarning, [mbOK], 0);;
  end;

     Fin:=Time;
//     AjouterFichierTexte(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'Débuggage.txt','"CalculTotauxRappBanc"  Debut : '+TimeToStr(Debut)+' - Fin : '+TimeToStr(Fin)+' Temp : '+timetostr(Fin-Debut));
//       showmessage('Temp : '+timetostr(Fin-Debut));

End;

Function EditionEtatRapprochementL(Compte:String;TypeEdition : integer;TypeAffichage:integer; DataSet:TDataSet):Boolean;
 var NomFich,Chemin:String;
     marque:string;
 var date:TDate;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
TotauxRappBanc:TTotauxRappBanc;
TotDebitSaisie,TotCreditSaisie:currency;
Libelle:string;
Begin
try//finally
  Chemin :=E.RepertoireComptaWeb;
  NomFich:='EtatDeRapprochement';
//  compte:='5120';
  date:=e.DatExoDebut;
   ObjPrn:=TObjetEdition.Create(application.MainForm);
 ListeValeur:=TStringList.Create;
TotDebitSaisie:=0;
TotCreditSaisie:=0;

      if DMRappBanc=nil then DMRappBanc:=TDMRappBanc.Create(Application.MainForm);
      ProtectObjetNil([dataSet]);
      if dataset = nil then begin
         // Prevu pour passer le dataset concerné
      end;
      DMRappBanc.QuRapprochementEdition.Filtered := true;
      DMRappBanc.QuRapprochementEdition.Filter := DataSet.Filter;
      DMRappBanc.QuRapprochementEdition.OnFilterRecord := DataSet.OnFilterRecord;
      DMRappBanc.QuRapprochementEdition.Close;
      DMRappBanc.QuRapprochementEdition.SQL.Clear;
      DMRappBanc.QuRapprochementEdition.SQL.Add(' select * from ecriture.db E ');
      DMRappBanc.QuRapprochementEdition.SQL.Add(' where E.compte=:compteLoc');
      DMRappBanc.QuRapprochementEdition.SQL.Add('and E."Date"<=:DateFin');
      DMRappBanc.QuRapprochementEdition.SQL.Add(' order by E."date", E.compte, E.tiers');
      DMRappBanc.QuRapprochementEdition.ParamByName('compteLoc').AsString:=compte;
      DMRappBanc.QuRapprochementEdition.ParamByName('DateFin').AsDate:=e.DatExoFin;
      DMRappBanc.QuRapprochementEdition.Open;
      TotauxRappBanc:=CalculTotauxRappBanc(Compte,C_CalculerTout,e.DatExoDebut,e.DatExoFin);
      DeFiltrageDataSet(DMrech.TaModelRech);
      if GrLocate(DMrech.TaModelRech,'Compte',[Compte]) then
        Libelle:=DMrech.TaModelRech.findField('Journal').AsString + ' : '+DMrech.TaModelRech.findField('Libelle_Model').AsString;
      ListeValeur.Add('9;; Compte : '+Compte+' - '+GereLibelle(Libelle) );
      if TypeAffichage in [2,3] then//mouvement non marqués ou tous
        ListeValeur.Add('4;; @Solde sur votre compta. (au '+DateToSTr(E.DatExoDebut)+') ;'+E.FormatCurrSansDevise(TotauxRappBanc.SoldeReportDebit)
        +';'+E.FormatCurrSansDevise(TotauxRappBanc.SoldeReportCredit)+'');
       //if DMRappBanc.QuRapprochementEdition.RecordCount <> 0 then
        //begin
          DMRappBanc.QuRapprochementEdition.First;
          while not DMRappBanc.QuRapprochementEdition.Eof do
            begin
              ListeValeur.Add('0'+
                               ';'+
                               DMRappBanc.QuRapprochementEdition.FindField('Date').AsString+
                               ';'+
                               GereLibelle(DMRappBanc.QuRapprochementEdition.FindField('Libelle').AsString)+
                               ';'+
                               DMRappBanc.QuRapprochementEdition.FindField('DebitSaisie').AsString+
                               ';'+
                               DMRappBanc.QuRapprochementEdition.FindField('CreditSaisie').AsString+
                               ';'+
                               DMRappBanc.QuRapprochementEdition.FindField('Rapprochement').AsString
                               );
      //        ListeValeur.Add('16');
              TotDebitSaisie:=TotDebitSaisie+DMRappBanc.QuRapprochementEdition.FindField('DebitSaisie').Ascurrency;
              TotCreditSaisie:=TotCreditSaisie+DMRappBanc.QuRapprochementEdition.FindField('CreditSaisie').Ascurrency;
              DMRappBanc.QuRapprochementEdition.Next;
            end;
          ListeValeur.Add('16');

      case TypeAffichage of
        0:begin
               ListeValeur.Add('4;; @Solde ( votre compta.) au '+DateToSTr(E.DatExoFin)+' :  ;'+E.FormatCurrSansDevise(TotauxRappBanc.SoldeCompteDebit)+';'+E.FormatCurrSansDevise(TotauxRappBanc.SoldeCompteCredit)+'');
               //récupérer le solde de la compta avant de recalculer les totaux pour le reste
               TotauxRappBanc:=CalculTotauxRappBanc(Compte,C_CalculerSoldeReleveBanque,e.DatExoDebut,e.DatExoFin);
               ListeValeur.Add('4;; @Mouvements non marqués au '+DateToSTr(E.DatExoFin)+' :  ;'+E.FormatCurrSansDevise(TotauxRappBanc.TotalMvtCompteNonMarqueDebit)+';'+E.FormatCurrSansDevise(TotauxRappBanc.TotalMvtCompteNonMarqueCredit)+'');
               ListeValeur.Add('4;; @Solde sur le relevé de banque au '+DateToSTr(E.DatExoFin)+' :  ;'+E.FormatCurrSansDevise(TotauxRappBanc.SoldeReleveBanqueDebit)+';'+E.FormatCurrSansDevise(TotauxRappBanc.SoldeReleveBanqueCredit)+'');
               ObjPrn.FSousTitreEdition:='Mouvements non marqués au '+DateToSTr(E.DatExoFin);
          end;
        1:begin
               ListeValeur.Add('4;; @Mouvements marqués au : '+DateToSTr(E.DatExoFin)+' : ;'+E.FormatCurrSansDevise(TotDebitSaisie)+';'+E.FormatCurrSansDevise(TotCreditSaisie)+'');
               DetermineSolde(TotDebitSaisie,TotCreditSaisie);
               ListeValeur.Add('4;; @Solde des Mouvements marqués au : '+DateToSTr(E.DatExoFin)+' :  ;'+E.FormatCurrSansDevise(TotDebitSaisie)+';'+E.FormatCurrSansDevise(TotCreditSaisie)+'');
               ObjPrn.FSousTitreEdition:='Mouvements déjà marqués au '+DateToSTr(E.DatExoFin);
          end
      else
        begin
    //    GrGrid5.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.TotalMvtCompteDebit);
    //    GrGrid5.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.TotalMvtCompteCredit);
               ListeValeur.Add('4;; @Mouvements du '+DateToSTr(E.DatExoDebut)+' au '+DateToSTr(E.DatExoFin)+' : ;'+E.FormatCurrSansDevise(TotauxRappBanc.TotalMvtCompteDebit)+';'+E.FormatCurrSansDevise(TotauxRappBanc.TotalMvtCompteCredit)+'');

    //    GrGrid4.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.SoldeCompteDebit);
    //    GrGrid4.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.SoldeCompteCredit);
               ListeValeur.Add('4;; @Solde ( votre compta.) au '+DateToSTr(E.DatExoFin)+' :  ;'+E.FormatCurrSansDevise(TotauxRappBanc.SoldeCompteDebit)+';'+E.FormatCurrSansDevise(TotauxRappBanc.SoldeCompteCredit)+'');

        TotauxRappBanc:=CalculTotauxRappBanc(Compte,C_CalculerSoldeReleveBanque,e.DatExoDebut,e.DatExoFin);

    //   GrGrid3.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.TotalMvtCompteNonMarqueDebit);
    //   GrGrid3.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.TotalMvtCompteNonMarqueCredit);
               ListeValeur.Add('4;; @Mouvements non marqués au '+DateToSTr(E.DatExoFin)+' :  ;'+E.FormatCurrSansDevise(TotauxRappBanc.TotalMvtCompteNonMarqueDebit)+';'+E.FormatCurrSansDevise(TotauxRappBanc.TotalMvtCompteNonMarqueCredit)+'');

    //   GrGrid1.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.SoldeReleveBanqueDebit);
    //   GrGrid1.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.SoldeReleveBanqueCredit);
               ListeValeur.Add('4;; @Solde sur le relevé de banque au '+DateToSTr(E.DatExoFin)+' :  ;'+E.FormatCurrSansDevise(TotauxRappBanc.SoldeReleveBanqueDebit)+';'+E.FormatCurrSansDevise(TotauxRappBanc.SoldeReleveBanqueCredit)+'');
               if TypeAffichage = 2 then
                 ObjPrn.FSousTitreEdition:='Tous les mouvements au '+DateToSTr(E.DatExoFin)
               else
                 ObjPrn.FSousTitreEdition:='En cours de marquage au '+DateToSTr(E.DatExoFin);
        end;
      end;//fin du case typeAffichage

       //end
//        else
//        begin
//         MessageDlg('Aucune données à imprimer.', mtInformation, [mbOK], 0);
//        end;
              DMRappBanc.QuRapprochementEdition.Close;
              ObjPrn.FTitreEdition := ' Rapprochement bancaire';
              //ObjPrn.FTitre2Edition :='Période du '+DateInfos(E.DatExoDebut).DateStr+' au '+DateInfos(E.DatExoFin).DateStr;
              ObjPrn.FTitre3Edition := 'Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
              ListeValeur.Insert(0,' Date ; Libellé ; Décaissement ; Encaissement ; Marque ');
              ListeValeur.Insert(1,'0.6;2.0;1.0;1.0;0.6');
              ListeValeur.Insert(2,'texte;texte;curr;curr;texte');
             ObjPrn.AffichageImp(ListeValeur);
finally
 LibereObjet(tobject(ObjPrn));
//if ObjPrn <> nil then
// begin
//  ObjPrn.Free;
//  ObjPrn := nil;
// end;
end;
End;

Function EditionEtatRapprochement(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
 var NomFich,Chemin:String;
 var compte,
     marque:string;
 var date:TDate;

Begin
  Chemin :=E.RepertoireComptaWeb;
  NomFich:='EtatDeRapprochement';
  compte:='5120';
  date:=e.DatExoDebut;

      if DMRappBanc=nil then DMRappBanc:=TDMRappBanc.Create(Application.MainForm);
      if dataset = nil then begin
         // Prevu pour passer le dataset concerné
      end;

      //solde comptable (debut)
      DMRappBanc.QuSoldeEdition.SQL.Clear;
      DMRappBanc.QuSoldeEdition.SQL.Add('select distinct ((select cast(sum(debitsaisie) as numeric) from ecriture e,piece p where p.id=e.id_piece and e.compte='''+compte+''' and e.rapprochement is null and p."date"<'''+DateInfos(date).DatePourSQLStr+''')');
      DMRappBanc.QuSoldeEdition.SQL.Add('+b.debit_report)-');
      DMRappBanc.QuSoldeEdition.SQL.Add('((select cast(sum(debitsaisie) as numeric) from ecriture e,piece p where p.id=e.id_piece and e.compte='''+compte+''' and e.rapprochement is null and p."date"<'''+DateInfos(date).DatePourSQLStr+''')');
      DMRappBanc.QuSoldeEdition.SQL.Add('+b.credit_report)');
      DMRappBanc.QuSoldeEdition.SQL.Add('debit_solde,((select cast(sum(creditsaisie) as numeric) from ecriture e,piece p where p.id=e.id_piece and e.compte='''+compte+''' and e.rapprochement is null and p."date"<'''+DateInfos(date).DatePourSQLStr+''')');
      DMRappBanc.QuSoldeEdition.SQL.Add('+b.credit_report)-');
      DMRappBanc.QuSoldeEdition.SQL.Add('((select cast(sum(creditsaisie) as numeric) from ecriture e,piece p where p.id=e.id_piece and e.compte='''+compte+''' and e.rapprochement is null and p."date"<'''+DateInfos(date).DatePourSQLStr+''')');
      DMRappBanc.QuSoldeEdition.SQL.Add('+b.debit_report) credit_solde');
      DMRappBanc.QuSoldeEdition.SQL.Add(' from "'+E.RepertoireExercice+'Balance" b join ecriture e on (e.compte=b.compte) join piece p on (p.id=e.id_piece) ');
      DMRappBanc.QuSoldeEdition.SQL.Add(' where e.compte='''+compte+''' and e.rapprochement is null');
      DMRappBanc.QuSoldeEdition.Open;

      //sous total
      DMRappBanc.QuSousTotal.SQL.Clear;
      DMRappBanc.QuSousTotal.SQL.Add('select cast(sum(e.debitsaisie) as numeric) debit,cast(sum(e.creditsaisie) as numeric) credit from ecriture e,piece p where e.id_piece=p.id and e.compte='''+compte+''' and e.rapprochement is null and p."date">='''+DateInfos(date).DatePourSQLStr+'''');
      DMRappBanc.QuSousTotal.Open;

      //total general
      DMRappBanc.QuTotalG.SQL.Clear;
      DMRappBanc.QuTotalG.SQL.Add('select distinct 0 from ecriture');
      DMRappBanc.QuTotalG.Open;

      DMRappBanc.QuRapprochementEdition.SQL.Clear;
      DMRappBanc.QuRapprochementEdition.SQL.Add('select piece."date",piece.reference,piece.libelle,sum(debitsaisie) debit,sum(creditsaisie) credit from ecriture,piece where id_piece=piece.id and ecriture.compte='''+compte+''' and piece."date">='''+DateInfos(date).DatePourSQLStr+''' and rapprochement is null group by piece."date",piece.reference,piece.libelle');
      DMRappBanc.QuRapprochementEdition.Open;
      DMRappBanc.QuRapprochementEdition.First;
      if not DMRappBanc.QuRapprochementEdition.Eof then begin
          case TypeEdition  of
              C_EditionSimple:Begin
                              Site.lien := false;
                              //EditEtatDeRapprochement(Chemin,NomFich,DMRappBanc.QuRapprochementEdition,compte,DMRappBanc.QuSoldeEdition,DMRappBanc.QuSousTotal,DMRappBanc.QuTotalG,DateToStr(date),Site);
                              ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                          End;
              C_EditionWeb: Begin
                            Site.lien := false;
                            //LienEditJournalPart(NomMenuSiteWeb,Chemin,NomFich,DMJournal.QuJournalPartEdition,'date',DMJournal.QuListeValRupt,DMJournal.QuSousTotal,DMJournal.QuTotalG,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),NomJournal,Site);
                            ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                        End;
          end;
      end;
      DMRappBanc.QuSoldeEdition.Close;
      DMRappBanc.QuSousTotal.Close;
      DMRappBanc.QuTotalG.Close;
      DMRappBanc.QuRapprochementEdition.Close;
End;

Function EditionRapprochement(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
 var NomFich,Chemin:String;
 var compte,
     marque:string;

Begin
  Chemin :=E.RepertoireComptaWeb;
  NomFich:='Rapprochement';
  compte:='5120';
  marque:='a';
  
      if DMRappBanc=nil then DMRappBanc:=TDMRappBanc.Create(Application.MainForm);
      if dataset = nil then begin
         // Prevu pour passer le dataset concerné
      end;

      //sous total
      DMRappBanc.QuSousTotal.SQL.Clear;
      DMRappBanc.QuSousTotal.SQL.Add('select sum(debitsaisie) debit,sum(creditsaisie) credit from ecriture,piece where id_piece=piece.id and piece.compte='''+compte+''' and rapprochement='''+marque+'''');
      DMRappBanc.QuSousTotal.Open;

      //total general
      DMRappBanc.QuTotalG.SQL.Clear;
      DMRappBanc.QuTotalG.SQL.Add('select sum(debitsaisie)-sum(creditsaisie) ,sum(creditsaisie)-sum(debitsaisie) from ecriture,piece where id_piece=piece.id and piece.compte='''+compte+''' and rapprochement='''+marque+'''');
      DMRappBanc.QuTotalG.Open;

      DMRappBanc.QuRapprochementEdition.SQL.Clear;
      DMRappBanc.QuRapprochementEdition.SQL.Add('select piece."date",piece.reference,piece.libelle,sum(debitsaisie) debit,sum(creditsaisie) credit from ecriture,piece where id_piece=piece.id and piece.compte='''+compte+''' and rapprochement='''+marque+''' group by piece."date",piece.reference,piece.libelle');
      DMRappBanc.QuRapprochementEdition.Open;
      DMRappBanc.QuRapprochementEdition.First;
      if not DMRappBanc.QuRapprochementEdition.Eof then begin
          case TypeEdition  of
              C_EditionSimple:Begin
                              Site.lien := false;
                             // EditBalanceEx(Chemin,NomFich,DMDiocEtatBal.QuBalanceEdition,'compte',DMDiocEtatBal.QuListeValRupt,DMDiocEtatBal.QuSousTotal,DMDiocEtatBal.QuSousTotal,DMDiocEtatBal.QuTotalG,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),Site);
                              //EditRapprochementMarque(Chemin,NomFich,DMRappBanc.QuRapprochementEdition,compte,DMRappBanc.QuSousTotal,DMRappBanc.QuTotalG,marque,Site);
                              ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                          End;
              C_EditionWeb: Begin
                            Site.lien := false;
                            //LienEditJournalPart(NomMenuSiteWeb,Chemin,NomFich,DMJournal.QuJournalPartEdition,'date',DMJournal.QuListeValRupt,DMJournal.QuSousTotal,DMJournal.QuTotalG,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),NomJournal,Site);
                            ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                        End;
          end;
      end;
      DMRappBanc.QuSousTotal.Close;
      DMRappBanc.QuTotalG.Close;
      DMRappBanc.QuRapprochementEdition.Close;
End;

procedure TDMRappBanc.DMRappBancCreate(Sender: TObject);
begin
OuvrirTouteTable('',Tcontrol(self));
ListeMarquageEnCours:=TStringList.Create;
ListeMarquageEnCours.Sorted:=true;
ListeMarquageEnCours.Duplicates:= dupIgnore;
if DMImportReleve=nil then DMImportReleve:=TDMImportReleve.Create(Application.MainForm);
end;

procedure TDMRappBanc.DMRappBancDestroy(Sender: TObject);
begin
//ListeMarquageEnCours.SaveToFile('List.txt');
FermerTouteTable('',TControl(self));
ListeMarquageEnCours.Free;
DMRappBanc := nil;
end;

procedure TDMRappBanc.TaEcr_RappBancAfterOpen(DataSet: TDataSet);
begin
FormateMonnaieField(DataSet,E.FormatMonnaie,E.EditFormat);
end;

// Permet d'afficher les enregistrements non marque ainsi que ceux en cours de marquage
// grace à ListeMarquageEnCours
procedure TDMRappBanc.TaEcr_RappBancFilterRecord_EnCours(DataSet: TDataSet;
  var Accept: Boolean);
begin
Accept:=(((ListeMarquageEnCours.IndexOf(DAtaSet.findField('ID').AsString) <> -1)
          or (DAtaSet.findField('Rapprochement').AsString = '')));
if accept then
  accept:=DAtaSet.findField('Date').asdatetime<=e.DatExoFin;
end;

// Permet d'afficher les enregistrments non Marque
procedure TDMRappBanc.TaEcr_RappBancFilterRecord_NonMarque(DataSet: TDataSet;
  var Accept: Boolean);
Begin
Accept:=(DAtaSet.findField('Rapprochement').AsString = '');
if accept then
  accept:=DAtaSet.findField('Date').asdatetime<=e.DatExoFin;
End;

// Permet d'afficher les enregistrments Déjà Marque
procedure TDMRappBanc.TaEcr_RappBancFilterRecord_Marque(DataSet: TDataSet;
  var Accept: Boolean);
Begin
Accept:=(DAtaSet.findField('Rapprochement').AsString <> '');
if accept then
  accept:=DAtaSet.findField('Date').asdatetime<=e.DatExoFin;
End;

// A n'utiliser que lors du démmarquage des marques en cours !!!!!!!!!!!
//
procedure TDMRappBanc.TaEcr_RappBancFilterRecord_DemarquageEnCours(DataSet: TDataSet;
  var Accept: Boolean);
begin
Accept:=(ListeMarquageEnCours.IndexOf(DAtaSet.findField('ID').AsString) <> -1)
  and(DAtaSet.findField('rapprochement').AsString<>'');
if accept then
  accept:=DAtaSet.findField('Date').asdatetime<=e.DatExoFin;
end;


procedure TDMRappBanc.TaEcr_RappBancFilterRecord_Tous(DataSet: TDataSet;
  var Accept: Boolean);
begin
accept:=DAtaSet.findField('Date').asdatetime<=e.DatExoFin;
end;


procedure TDMRappBanc.TaEcr_RappBancBeforeInsert(DataSet: TDataSet);
begin
abort;
end;

procedure TDMRappBanc.TaEcr_RappBancBeforePost(DataSet: TDataSet);
Var
I:Integer;
retour:boolean;
begin
try
try
retour:=DMImportReleve.GestionRelationMarqueRapprochement(
OldMarqueReleve,OldMarqueRapprochement,DMRappBanc.GererReleveDirect,DataSet.FindField('id').AsInteger);
if not retour then
begin
  DataSet.FindField('Rapprochement').AsString:=OldMarqueRapprochement;
end
else
  begin
    I:=ListeMarquageEnCours.IndexOf(DAtaSet.findField('ID').AsString);
    if ((I <> -1) and (DAtaSet.findField('Rapprochement').AsString = '' )) then
      begin
        ListeMarquageEnCours.Delete(I);
      end;
    if DAtaSet.findField('Rapprochement').AsString <> '' then
     begin
      ListeMarquageEnCours.Add(DAtaSet.findField('ID').AsString);
      DMRappBanc.MarqueCourante:=DAtaSet.findField('Rapprochement').AsString;
     end;
  end;   
except
  TableGereCancel(dataset);
  TableGereRollBack(dataset);
end;
finally
OldMarqueReleve:='';
OldMarqueRapprochement:='';
end;
end;

procedure TDMRappBanc.TaEcr_RappBancBeforeDelete(DataSet: TDataSet);
begin
Showmessage('Veuillez utiliser - Saisie Pièce - pour supprimer une pièce !');
abort;
end;

Function  TDMRappBanc.SommeRappNonMarqueAvantDate(Compte:String;DateFin:TDate):TTotauxCompte;
Begin
Initialise_TotauxCompte(result);
QuSumRappNonMarqueAvantDate.Close;
QuSumRappNonMarqueAvantDate.ParamByName('Compte').AsString:=Compte;
QuSumRappNonMarqueAvantDate.ParamByName('DateFin').AsDate := DateFin;
QuSumRappNonMarqueAvantDate.OnFilterRecord:=TaEcr_RappBancFilterRecord_MarqueSpecifique;
QuSumRappNonMarqueAvantDate.Open;
Result.TotalDebit := QuSumRappNonMarqueAvantDate.findField('TotDebit').AsCurrency;
Result.TotalCredit := QuSumRappNonMarqueAvantDate.findField('TotCredit').AsCurrency;
Result.SoldeEnDebit := Result.SoldeDebit >= Result.TotalCredit;
if Result.SoldeEnDebit then
 begin
  Result.SoldeDebit := Abs(Result.TotalDebit - Result.TotalCredit);
  Result.SoldeCredit:=0;
 end
else
 begin
  Result.SoldeDebit := 0;
  Result.SoldeCredit:=Abs(Result.TotalDebit - Result.TotalCredit);;
 end;
End;

Function TDMRappBanc.ListeMarque(CompteBanque:String):TStringList;
Var
I:Integer;
Begin
Result:=TStringList.Create;
Result.Clear;
QuListeMarque.Close;
QuListeMarque.ParamByName('Compte').AsString := CompteBanque;
QuListeMarque.Open;
QuListeMarque.First;
//DeFiltrageDataSet(DMRech.TaEcritureRech);
//DMRech.TaEcritureRech.OnFilterRecord :=
//DMRech.TaEcritureRech.Filtered :=true;

 while not DMRappBanc.QuListeMarque.EOF do
   begin
   // Permet d'écrire les date de dbut et de fin
//     CBoxListeMarque.Items.Add('Du '+DMRappBanc.QuListeMarque.FindField('DateDeb').AsString+' au '+DMRappBanc.QuListeMarque.FindField('DateFin').AsString+' : '+DMRappBanc.QuListeMarque.FindField('Rapprochement').AsString);
     if trim(DMRappBanc.QuListeMarque.FindField('Rapprochement').AsString)<>'' then
       Result.Add(DMRappBanc.QuListeMarque.FindField('Rapprochement').AsString);
     DMRappBanc.QuListeMarque.Next;
   end;
end;

procedure TDMRappBanc.QuTotalGCalcFields(DataSet: TDataSet);
begin
  QuSoldeEdition.Open;
  QuSousTotal.Open;
  if QuSoldeEdition.FindField('debit_solde').AsCurrency>=QuSoldeEdition.FindField('credit_solde').AsCurrency then begin
      QuTotalGdebit_solde_releve.AsCurrency:=
      QuSoldeEdition.FindField('credit_solde').AsCurrency-(QuSousTotal.FindField('credit').AsCurrency-QuSousTotal.FindField('debit').AsCurrency);
  end
  else begin
      QuTotalGdebit_solde_releve.AsCurrency:=
      QuSoldeEdition.FindField('debit_solde').AsCurrency-(QuSousTotal.FindField('debit').AsCurrency-QuSousTotal.FindField('credit').AsCurrency);
  end;

//if ((TotauxReport.SoldeDebitCreditFin = (DMRappBanc.QuSumRappNonMarque.FindField('TotDebit').AsCurrency<=DMRappBanc.QuSumRappNonMarque.FindField('TotCredit').AsCurrency))) then
//SoldeReleveBanqueDebit:=TotauxReport.TotalSoldeDebitTotal - (DMRappBanc.QuSumRappNonMarque.FindField('TotDebit').AsCurrency - DMRappBanc.QuSumRappNonMarque.FindField('TotCredit').AsCurrency);
//
//if ((TotauxReport.SoldeDebitCreditFin = (DMRappBanc.QuSumRappNonMarque.FindField('TotDebit').AsCurrency>=DMRappBanc.QuSumRappNonMarque.FindField('TotCredit').AsCurrency))) then
//SoldeReleveBanqueDebit:=TotauxReport.TotalSoldeCreditTotal-(DMRappBanc.QuSumRappNonMarque.FindField('TotCredit').AsCurrency - DMRappBanc.QuSumRappNonMarque.FindField('TotDebit').AsCurrency);
end;


procedure TDMRappBanc.TaEcr_RappBancFilterRecord_MarqueSpecifique(DataSet: TDataSet;
  var Accept: Boolean);
Begin
Accept:=((DAtaSet.findField('Rapprochement').AsString ='')or(DAtaSet.findField('Rapprochement').AsString <> marqueSpecifique));
if accept then
  accept:=DAtaSet.findField('Date').asdatetime<=e.DatExoFin;
End;


procedure TDMRappBanc.TaEcr_RappBancBeforeEdit(DataSet: TDataSet);
begin
OldMarqueReleve:=dataset.findfield('MarqueReleve').AsString;
OldMarqueRapprochement:=dataset.findfield('Rapprochement').AsString;
end;

procedure TDMRappBanc.TaEcr_RappBancBeforeOpen(DataSet: TDataSet);
begin
TaReferencePiece.close;
TaReferencePiece.Open;
end;

end.
