unit DMClotures;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,RxMemDS,
  E2_Librairie_Obj,
  E2_Decl_Records,
  LibRessourceString,
  DMProgramme,
  E2_Patientez,
  E2_OKCreatExoDlg,
  Gr_MultDos,
  LibFichRep,
  LibDates,
  ImportDll,
  Gr_Librairie_Obj,
  E2_LibInfosTable;


type

  TDMCloture = class(TDataModule)
    TableN1: TTable;
    BatchMove1: TBatchMove;
    function ReecritureDesTablesPourNouvelExo:boolean;
    function VerifSoldeCompteAvantClotureDefinitive(liste:TstringList):TErreurcloture;
    Procedure TraitementCloture7001(sender:Tobject);
    Procedure TraitementCloture7002(sender:Tobject);
    Procedure TraitementCloture7003(sender:Tobject);
    function VerifAvantCloture(Etape:integer=99):TRetourListeErreur;
    procedure DMClotureCreate(Sender: TObject);
    procedure DMClotureDestroy(Sender: TObject);
    function ClotureDefinitiveExercice(RepDossier,NomDossier,NomExo:string):Texceptlgr;
    Procedure TraitementCloture11001(sender:Tobject);
    Procedure TraitementCloture12001(sender:Tobject);
    function MiseAJourAnalytiqueSurN1(confirmation : Boolean=true):TExceptLGR;
  private
    { Déclarations privées }
  Protected
    { Déclarations protégées }
  public
    { Déclarations publiques }
        JournalErreur:Tstringlist;
  end;

var
  DMCloture: TDMCloture;

  Function RapportClotureAffich(JournalErreur:Tstringlist):TExceptLGR;


implementation
uses E2_Main,DMDepenses,DMProvision,DMChargesRepartir,DMChargesAPayer,DMChargesCA,DMStocks,DMBalances,DMPlanCpt,
  E2_AideCompte, LibSQL, DMImmos,DMEcriture,E2_RepartitionResult,E2_GestSauvegarde,
  DMBaseDonnee,
  DMImmo_Clot,
  DMDiocEtatBalance,
  DMDiocEtatBalanceT,
  DMTTVA,
  DMParamEnt,
  DMRecherche,
  DMRepartition,
  DMCorrection,
  DMDeductions,
  DMAnalytique,
  DMPiece, DateUtils, DMConstantes;
{$R *.DFM}

function TDMCloture.ReecritureDesTablesPourNouvelExo:boolean;
var
tableMem:TRxMemoryData;
DateDeb,DateFin:Tdate;
//ChangementExo:TChangtExo;
InfosGestDossier:TInfosGestDossier;
EffaceTable:tquery;
EtatTmp:TTypeEtatExercice;
ParamDMStocks:TParamDMStocks;
DatamoduleCree:boolean;
begin
try//finally
result:=false;
DatamoduleCree:=false;

Screen.Cursor := crSQLWait;

EffaceTable:=tquery.Create(application);
DMBD.BrancheTableVersN1(EffaceTable);

//récupérer les dates de l'exo de N+1
  InfosGestDossier:=ChercheInfos_ExoN1(e.NomDossier);
//ChangementExo:=GestDossierInfosExoN1;

//je sauvegarde les dates de E avant la réécriture des tables pour
//pouvoir les changer temporairement car dans les écrans d'ouverture on se sert de ces dates pour enregistrer les
//charges et produits suivant si ce sont des charges d'ouverture ou de cloture hors si je ne les change pas, dans
//le before post de chaque table, il me met la date de début ou de fin de l'exercice mais ces dates correspondent
//toujours à l'exercice N ce ne sont pas les bonnes dates pour l'exercice N+1
DateDeb:=e.DatExoDebut;
DateFin:=e.DatExoFin;

   try
    EtatTmp:=e.TypeEtatExercice;
    if e.TypeEtatExercice in [ET_Cloture] then
      begin
        showmessage('Cet exercice est déjà clôturé, vous ne pouvez pas le modifier');
        abort;
      end;
    e.TypeEtatExercice:=ET_EnCloture;
   //e.TypeEtatExercice:=ET_Normal;
   TableGereStartTransaction(tablen1);
   if DMRech = nil then DMRech := TDMRech.Create(application.MainForm);

   if not SauvegardeImmosExo.retour then abort;

   
   // table deduction
   if DMDeduction=nil then DMDeduction:=TDMDeduction.Create(application.MainForm);

   TableMem:=TRxMemoryData.Create(Application);
   DMDeduction.Filtrage_DeductionPourNouvelExo(TableMem,InfosGestDossier.DATE_DEB_EXO -1);

   DMBD.BrancheTableVersN1(DMRech.TaDeductionRech);
   if DMRech.TaDeductionRech.active=false then DMRech.TaDeductionRech.open;

    e.DatExoDebut:=InfosGestDossier.DATE_DEB_EXO;
    e.DatExoFin:=InfosGestDossier.DATE_FIN_EXO;

   //  TableGereStartTransaction(effacetable);
     EffaceTable.SQL.Clear;
     Effacetable.SQL.Add('Delete from '+DMRech.TaDeductionRech.tableName);
     effacetable.ExecSQL;
    // TableGereCommit(effacetable);

   if tableMem.RecordCount<>0 then
     begin
     while TableMem.RecordCount<>0 do
       Begin
        DMDeduction.ImportDeduction([TableMem.FindField('id').AsInteger,
                                    TableMem.FindField('libelle').asstring,
                                    TableMem.FindField('Mt_N').ascurrency,
                                    TableMem.FindField('Mt_N1').ascurrency,
                                    TableMem.FindField('Mt_N2').ascurrency,
                                    TableMem.FindField('Mt_N3').ascurrency,
                                    TableMem.FindField('Mt_N4').ascurrency,
                                    TableMem.FindField('Mt_N5').ascurrency,
                                    TableMem.FindField('Reste').ascurrency,
                                    TableMem.FindField('Divers_Str').asstring],DMRech.TaDeductionRech);
        TableMem.Delete;
       end;
     end;

     EffaceTable.SQL.Clear;
     Effacetable.SQL.Add('Delete from '+DMRech.TaDeductionRech.tableName+' where (Mt_N=0 or Mt_N is null) '+
     ' and (Mt_N1=0 or Mt_N1 is null)and (Mt_N2=0 or Mt_N2 is null) and (Mt_N3=0 or Mt_N3 is null) '+
     ' and (Mt_N4=0 or Mt_N4 is null) and (Mt_N5=0 or Mt_N5 is null)');
     effacetable.ExecSQL;

   DMBD.BrancheTableVersN(DMRech.TaDeductionRech);
Screen.Cursor := crSQLWait;
   e.DatExoDebut:=DateDeb;
   e.DatExoFin:=DateFin;

   TableMem.close;
   TableMem.Free;

   //fin table deduction

   // table Utilisationdeduction
   if DMDeduction=nil then DMDeduction:=TDMDeduction.Create(application.MainForm);
   if DMBalance=nil then DMBalance:=TDMBalance.Create(application.MainForm);

   TableMem:=TRxMemoryData.Create(Application);
   DMDeduction.Filtrage_UtilisationDeductionPourNouvelExo(TableMem,InfosGestDossier.DATE_DEB_EXO -1);

   DMBD.BrancheTableVersN1(DMRech.TaUtilisation_deducRech);

   if DMRech.TaUtilisation_deducRech.active=false then DMRech.TaUtilisation_deducRech.open;

    e.DatExoDebut:=InfosGestDossier.DATE_DEB_EXO;
    e.DatExoFin:=InfosGestDossier.DATE_FIN_EXO;

   // TableGereStartTransaction(effacetable);

     EffaceTable.SQL.Clear;
     Effacetable.SQL.Add('Delete from '+DMRech.TaUtilisation_deducRech.tableName);
     effacetable.ExecSQL;
     DMRech.TaUtilisation_deducRech.Refresh;
   //  TableGereCommit(effacetable);
Screen.Cursor := crSQLWait;
   if tableMem.RecordCount<>0 then
     begin
     while TableMem.RecordCount<>0 do
       Begin
        DMDeduction.ImportDeduction([TableMem.FindField('id').AsInteger,
                                    TableMem.FindField('id_deduction').AsInteger,
                                    TableMem.FindField('id_immo').AsInteger,
                                    TableMem.FindField('Exercice').asstring,
                                    TableMem.FindField('Mt_immo').ascurrency,
                                    TableMem.FindField('Mt_social').ascurrency,
                                    TableMem.FindField('Mt_stocks').ascurrency,
                                    TableMem.FindField('Reinteg_except').ascurrency,
                                    TableMem.FindField('Libelle_Reinteg').asstring,
                                    TableMem.FindField('Divers_Str').asstring],DMRech.TaUtilisation_deducRech);
        TableMem.Delete;
       end;
     end;
     EffaceTable.SQL.Clear;
     Effacetable.SQL.Add('Delete from '+DMRech.TaUtilisation_deducRech.tableName+' where id_deduction not in(select id from ta_deduction)');
     effacetable.ExecSQL;

     EffaceTable.SQL.Clear;
     Effacetable.SQL.Add('Delete from '+DMRech.TaUtilisation_deducRech.tableName+' where upper(exercice) =''N-5''');
     effacetable.ExecSQL;
   DMBD.BrancheTableVersN(DMRech.TaUtilisation_deducRech);

   e.DatExoDebut:=DateDeb;
   e.DatExoFin:=DateFin;

   TableMem.close;
   TableMem.Free;

   //fin table Utilisationdeduction

   //Table des Dépenses
 //  TableGereStartTransaction(effacetable);
   if DMDepenseEnt=nil then DMDepenseEnt:=TDMDepenseEnt.Create(application.MainForm);
   if DMBalance=nil then DMBalance:=TDMBalance.Create(application.MainForm);

   TableMem:=TRxMemoryData.Create(Application);
   DMDepenseEnt.Filtrage_EcriturePourNouvelExo(TableMem,InfosGestDossier.DATE_DEB_EXO -1);

   DMBD.BrancheTableVersN1(DMDepenseEnt.TaDepense);
   DMBD.BrancheTableVersN1(DMBalance.TaBalance);
   if DMDepenseEnt.TaDepense.active=false then DMDepenseEnt.TaDepense.open;
   if DMBalance.TaBalance.active=false then DMBalance.TaBalance.open;

    e.DatExoDebut:=InfosGestDossier.DATE_DEB_EXO;
    e.DatExoFin:=InfosGestDossier.DATE_FIN_EXO;

     EffaceTable.SQL.Clear;
     Effacetable.SQL.Add('Delete from '+DMDepenseEnt.TaDepense.tableName);
     Effacetable.SQL.Add('where DateExercice<:DateDeb');
     Effacetable.ParamByName('DateDeb').AsDate:=InfosGestDossier.DATE_DEB_EXO;
     effacetable.ExecSQL;

//   while DMDepenseEnt.TaDepense.RecordCount<>0 do
//     Begin
//       TableGereDelete(DMDepenseEnt.TaDepense);
//     end;

   if tableMem.RecordCount<>0 then
     begin
     while TableMem.RecordCount<>0 do
       Begin
        DMDepenseEnt.ImportDepenses([MaxId_Query(dmrech.TaDepensesEntreprisesRech,'id'),
                                    TableMem.FindField('Compte').asstring,
                                    TableMem.FindField('Libelle').asstring,
                                    TableMem.FindField('Sens').asstring[1],
                                    TableMem.FindField('Qte').asfloat,
                                    TableMem.FindField('MontantHT').ascurrency,
                                    TableMem.FindField('DateSaisie').asdatetime,
                                    TableMem.FindField('DateExercice').asdatetime,
                                    TableMem.FindField('Compte2').asstring,
                                    TableMem.FindField('Libelle2').asstring,
                                    TableMem.FindField('TVA').ascurrency,
                                    TableMem.FindField('DatePiece').asstring,
                                    TableMem.FindField('Reference').asstring,
                                    TableMem.FindField('DateSysteme').asdatetime],DMDepenseEnt.TaDepense);
        TableMem.Delete;
       end;
     end;
   DMBD.BrancheTableVersN(DMDepenseEnt.TaDepense);

   e.DatExoDebut:=DateDeb;
   e.DatExoFin:=DateFin;
Screen.Cursor := crSQLWait;
   TableMem.close;
   TableMem.Free;


//Table des Charges à payer
   TableMem:=TRxMemoryData.Create(Application);
   if DMBalance=nil then DMBalance:=TDMBalance.Create(application.MainForm);
   if DMChargeAPayer=nil then DMChargeAPayer:=TDMChargeAPayer.Create(application.MainForm);
   DMChargeAPayer.Filtrage_EcriturePourNouvelExo(TableMem,InfosGestDossier.DATE_DEB_EXO-1);

   DMBD.BrancheTableVersN1(DMChargeAPayer.TaChAPayer);
   DMBD.BrancheTableVersN1(DMBalance.TaBalance);
   if DMChargeAPayer.TaChAPayer.active=false then DMChargeAPayer.TaChAPayer.open;
   if DMBalance.TaBalance.active=false then DMBalance.TaBalance.open;

    e.DatExoDebut:=InfosGestDossier.DATE_DEB_EXO;
    e.DatExoFin:=InfosGestDossier.DATE_FIN_EXO;


     EffaceTable.SQL.Clear;
     Effacetable.SQL.Add('Delete from '+DMChargeAPayer.TaChAPayer.tableName);
     Effacetable.SQL.Add('where DateExercice<:DateDeb');
     Effacetable.ParamByName('DateDeb').AsDate:=InfosGestDossier.DATE_DEB_EXO;
     effacetable.ExecSQL;

//   while DMChargeAPayer.TaChAPayer.RecordCount<>0 do
//     Begin
//       TableGereDelete(DMChargeAPayer.TaChAPayer);
//     end;

   if tableMem.RecordCount<>0 then
     begin
     while TableMem.RecordCount<>0 do
       Begin
        if TableMem.FindField('Sens').asstring[1]='C' then
          begin//si charges
          DMChargeAPayer.tag:=11;
//          DMChargeAPayer.QuandQuoi:=DMChargeAPayer.tag;
          DMChargeAPayer.ImportChAPayer([MaxId_Query(dmrech.TaChargeAPayerRech,'id'),
                                          TableMem.FindField('Compte').asstring,
                                          TableMem.FindField('Libelle').asstring,
                                          TableMem.FindField('Sens').asstring[1],
                                          TableMem.FindField('Qte').asfloat,
                                          TableMem.FindField('MontantHT').ascurrency,
                                          TableMem.FindField('DateSaisie').asdatetime,
                                          TableMem.FindField('DateExercice').asdatetime,
                                          TableMem.FindField('Compte2').asstring,
                                          TableMem.FindField('Libelle2').asstring,
                                          TableMem.FindField('TVA').ascurrency,
                                          TableMem.FindField('DateSysteme').asdatetime,
                                          TableMem.FindField('Date_Piece').asstring,
                                          TableMem.FindField('Reference').asstring,
                                          TableMem.FindField('Id_Piece').asstring
                                          ],DMChargeAPayer.TaChAPayer);
          TableMem.Delete;
          end//fin si charges
        else
          begin //si produits
          DMChargeAPayer.tag:=12;
//          DMChargeAPayer.QuandQuoi:=DMChargeAPayer.tag;
          DMChargeAPayer.ImportPrARecevoir([MaxId_Query(dmrech.TaChargeAPayerRech,'id'),
                                          TableMem.FindField('Compte').asstring,
                                          TableMem.FindField('Libelle').asstring,
                                          TableMem.FindField('Sens').asstring[1],
                                          TableMem.FindField('Qte').asfloat,
                                          TableMem.FindField('MontantHT').ascurrency,
                                          TableMem.FindField('DateSaisie').asdatetime,
                                          TableMem.FindField('DateExercice').asdatetime,
                                          TableMem.FindField('Compte2').asstring,
                                          TableMem.FindField('Libelle2').asstring,
                                          TableMem.FindField('TVA').ascurrency,
                                          TableMem.FindField('DateSysteme').asdatetime,
                                          TableMem.FindField('Date_Piece').asstring,
                                          TableMem.FindField('Reference').asstring,
                                          TableMem.FindField('Id_Piece').asstring
                                          ],DMChargeAPayer.TaChAPayer);
          TableMem.Delete;
          end;//fin si produit
       end;
     end;
   DMBD.BrancheTableVersN(DMChargeAPayer.TaChAPayer);

   e.DatExoDebut:=DateDeb;
   e.DatExoFin:=DateFin;

   TableMem.close;
   TableMem.Free;
Screen.Cursor := crSQLWait;

//Table des Charges constatées
   TableMem:=TRxMemoryData.Create(Application);
   if DMBalance=nil then DMBalance:=TDMBalance.Create(application.MainForm);
   if DMChargeCA=nil then DMChargeCA:=TDMChargeCA.Create(application.MainForm);

   DMChargeCA.Filtrage_EcriturePourNouvelExo(TableMem,InfosGestDossier.DATE_DEB_EXO-1);

   DMBD.BrancheTableVersN1(DMChargeCA.TaPCA);
   DMBD.BrancheTableVersN1(DMBalance.TaBalance);
   if DMChargeCA.TaPCA.active=false then DMChargeCA.TaPCA.open;
   if DMBalance.TaBalance.active=false then DMBalance.TaBalance.open;

    e.DatExoDebut:=InfosGestDossier.DATE_DEB_EXO;
    e.DatExoFin:=InfosGestDossier.DATE_FIN_EXO;

     EffaceTable.SQL.Clear;
     Effacetable.SQL.Add('Delete from '+DMChargeCA.TaPCA.tableName);
     Effacetable.SQL.Add('where DateExercice<:DateDeb');
     Effacetable.ParamByName('DateDeb').AsDate:=InfosGestDossier.DATE_DEB_EXO;
     effacetable.ExecSQL;

//   while DMChargeCA.TaPCA.RecordCount<>0 do
//     Begin
//       TableGereDelete(DMChargeCA.TaPCA);
//     end;

   if tableMem.RecordCount<>0 then
     begin
     while TableMem.RecordCount<>0 do
       Begin
        if TableMem.FindField('Sens').asstring[1]='D' then
          begin//si charges
          DMChargeCA.tag:=11;
          DMChargeCA.ImportChCAvance([MaxId_Query(dmrech.TaPCARech,'id'),
                            TableMem.FindField('Compte').asstring,
                            TableMem.FindField('Libelle').asstring,
                            TableMem.FindField('Sens').asstring[1],
                            TableMem.FindField('Qte').asfloat,
                            TableMem.FindField('MontantHT').ascurrency,
                            TableMem.FindField('DateSaisie').asdatetime,
                            TableMem.FindField('DateExercice').asdatetime,
                            TableMem.FindField('Compte2').asstring,
                            TableMem.FindField('Libelle2').asstring,
                            TableMem.FindField('DateSysteme').asdatetime,
                            TableMem.FindField('Date_Piece').asstring,
                            TableMem.FindField('Reference').asstring
                            ],DMChargeCA.TaPCA);
          TableMem.Delete;
          end//fin si charges
        else
          begin//si produits
          DMChargeCA.tag:=12;
          DMChargeCA.ImportPrCAvance([MaxId_Query(dmrech.TaPCARech,'id'),
                            TableMem.FindField('Compte').asstring,
                            TableMem.FindField('Libelle').asstring,
                            TableMem.FindField('Sens').asstring[1],
                            TableMem.FindField('Qte').asfloat,
                            TableMem.FindField('MontantHT').ascurrency,
                            TableMem.FindField('DateSaisie').asdatetime,
                            TableMem.FindField('DateExercice').asdatetime,
                            TableMem.FindField('Compte2').asstring,
                            TableMem.FindField('Libelle2').asstring,
                            TableMem.FindField('DateSysteme').asdatetime,
                            TableMem.FindField('Date_Piece').asstring,
                            TableMem.FindField('Reference').asstring
                            ],DMChargeCA.TaPCA);
          TableMem.Delete;
          end;//fin si produits
       end;
     end;
   DMBD.BrancheTableVersN(DMChargeCA.TaPCA);

   e.DatExoDebut:=DateDeb;
   e.DatExoFin:=DateFin;

   TableMem.close;
   TableMem.Free;

Screen.Cursor := crSQLWait;
//Table des Charges à répartir
   TableMem:=TRxMemoryData.Create(Application);
   if DMBalance=nil then DMBalance:=TDMBalance.Create(application.MainForm);
   if DMChargeRepartir=nil then DMChargeRepartir:=TDMChargeRepartir.Create(application.MainForm);

   DMChargeRepartir.Filtrage_EcriturePourNouvelExo(tableMem,InfosGestDossier.DATE_DEB_EXO-1);

   DMBD.BrancheTableVersN1(DMChargeRepartir.TaCar);
   DMBD.BrancheTableVersN1(DMBalance.TaBalance);
   if DMChargeRepartir.TaCar.active=false then DMChargeRepartir.TaCar.open;
   if DMBalance.TaBalance.active=false then DMBalance.TaBalance.open;

    e.DatExoDebut:=InfosGestDossier.DATE_DEB_EXO;
    e.DatExoFin:=InfosGestDossier.DATE_FIN_EXO;

     EffaceTable.SQL.Clear;
     Effacetable.SQL.Add('Delete from '+DMChargeRepartir.TaCar.tableName);
     Effacetable.SQL.Add('where DateSaisie<:DateDeb');
     Effacetable.ParamByName('DateDeb').AsDate:=InfosGestDossier.DATE_DEB_EXO;
     effacetable.ExecSQL;

//   while DMChargeRepartir.TaCar.RecordCount<>0 do
//     Begin
//       TableGereDelete(DMChargeRepartir.TaCar);
//     end;

   if tableMem.RecordCount<>0 then
     begin
     while TableMem.RecordCount<>0 do
       Begin
        DMChargeRepartir.ImportsChargeRepartir([MaxId_Query(dmrech.TaChargesRepartirRech,'id'),
                                                TableMem.FindField('Compte').asstring,
                                                TableMem.FindField('Designation').asstring,
                                                TableMem.FindField('MtTotalCharge').ascurrency,
                                                TableMem.FindField('MtBilanOuverture').ascurrency,
                                                TableMem.FindField('DateSysteme').asdatetime,
                                                TableMem.FindField('Reference').asstring,
                                                TableMem.FindField('MontantReprise').ascurrency,
                                                TableMem.FindField('DateSaisie').asdatetime
                                                ],DMChargeRepartir.TaCar);
        TableMem.Delete;
       end;
     end;
   DMBD.BrancheTableVersN(DMChargeRepartir.TaCar);

   e.DatExoDebut:=DateDeb;
   e.DatExoFin:=DateFin;

   TableMem.close;
   TableMem.Free;
Screen.Cursor := crSQLWait;

//Table des provisions
   TableMem:=TRxMemoryData.Create(Application);
   if DMBalance=nil then DMBalance:=TDMBalance.Create(application.MainForm);
   if DMProvisions=nil then DMProvisions:=TDMProvisions.Create(application.MainForm);

   DMProvisions.Filtrage_EcriturePourNouvelExo(TableMem,InfosGestDossier.DATE_DEB_EXO-1);

   DMBD.BrancheTableVersN1(DMProvisions.TaProvision);
   DMBD.BrancheTableVersN1(DMBalance.TaBalance);
   if DMProvisions.TaProvision.active=false then DMProvisions.TaProvision.open;
   if DMBalance.TaBalance.active=false then DMBalance.TaBalance.open;

   DMProvisions.tag:=c_cloture;

    e.DatExoDebut:=InfosGestDossier.DATE_DEB_EXO;
    e.DatExoFin:=InfosGestDossier.DATE_FIN_EXO;

     EffaceTable.SQL.Clear;
     Effacetable.SQL.Add('Delete from '+DMProvisions.TaProvision.tableName);
     Effacetable.SQL.Add('where DateSaisie<:DateDeb');
     Effacetable.ParamByName('DateDeb').AsDate:=InfosGestDossier.DATE_DEB_EXO;
     effacetable.ExecSQL;

//   while DMProvisions.TaProvision.RecordCount<>0 do
//     Begin
//       TableGereDelete(DMProvisions.TaProvision);
//     end;

   if tableMem.RecordCount<>0 then
     begin
     while TableMem.RecordCount<>0 do
       Begin

        DMProvisions.ImportProvisions([MaxId_Query(dmrech.TaProvisionsRech,'id'),
                                        TableMem.FindField('Compte').asstring,
                                        TableMem.FindField('Designation').asstring,
                                        TableMem.FindField('MtTotalProvision').ascurrency,
                                        TableMem.FindField('MtBilanOuverture').ascurrency,
                                        TableMem.FindField('DateSysteme').asdatetime,
                                        TableMem.FindField('Reference').asstring,
                                        TableMem.FindField('MontantReprise').ascurrency,
                                        TableMem.FindField('DateSaisie').asdatetime
                                        ],DMProvisions.TaProvision);
        TableMem.Delete;
       end;
     end;
   DMBD.BrancheTableVersN(DMProvisions.TaProvision);

   e.DatExoDebut:=DateDeb;
   e.DatExoFin:=DateFin;

   TableMem.close;
   TableMem.Free;

Screen.Cursor := crSQLWait;
//Table des stocks
   TableMem:=TRxMemoryData.Create(Application);
   if DMBalance=nil then DMBalance:=TDMBalance.Create(application.MainForm);
   if DMStock=nil then DMStock:=TDMStock.Create(application.MainForm);

   DMStock.Filtrage_EcriturePourNouvelExo(TableMem,InfosGestDossier.DATE_DEB_EXO-1);

   DMBD.BrancheTableVersN1(DMStock.TaStock);
   DMBD.BrancheTableVersN1(DMBalance.TaBalance);
   if DMStock.TaStock.active=false then DMStock.TaStock.open;
   if DMBalance.TaBalance.active=false then DMBalance.TaBalance.open;

    e.DatExoDebut:=InfosGestDossier.DATE_DEB_EXO;
    e.DatExoFin:=InfosGestDossier.DATE_FIN_EXO;

     EffaceTable.SQL.Clear;
     Effacetable.SQL.Add('Delete from '+DMStock.TaStock.tableName);
     Effacetable.SQL.Add('where Date_Saisie<:DateDeb');
     Effacetable.ParamByName('DateDeb').AsDate:=InfosGestDossier.DATE_DEB_EXO;
     effacetable.ExecSQL;

//   while DMStock.TaStock.RecordCount<>0 do
//     Begin
//       TableGereDelete(DMStock.TaStock);
//     end;
 ParamDMStocks.StocksDataStateChange := nil;
 ParamDMStocks.GEstInterfaceEvent := nil;
 ParamDMStocks.Quand := C_Ouverture;
 InitialiseDMStocks(ParamDMStocks);
 
   if tableMem.RecordCount<>0 then
     begin
     while TableMem.RecordCount<>0 do
       Begin
         DMStock.ImportStocks([MaxId_Query(dmrech.TaStockRech,'id'),
                               TableMem.FindField('Compte').AsString,
                               TableMem.FindField('Designation').Asstring,
                               TableMem.FindField('Qte').Asfloat,
                               TableMem.FindField('Prix_Unitaire').Ascurrency,
                               TableMem.FindField('Decote').Asfloat,
                               TableMem.FindField('MontantTotalHT').Ascurrency],DMStock.TaStock);
        TableMem.Delete;
       end;
     end;
   DMBD.BrancheTableVersN(DMStock.TaStock);

   e.DatExoDebut:=DateDeb;
   e.DatExoFin:=DateFin;

   TableMem.close;
   TableMem.Free;

Screen.Cursor := crSQLWait;
TableGereCommit(tablen1);

//table immos
//avant de recopier, il faut sauveqarder la table immos
if not SauvegardeImmosExo.retour then abort;
  if not InitialisationDesImmosApresChangementExercice then
    abort;
Screen.Cursor := crSQLWait;
  if not MaJReportChargeEtProduit(DMRech.TaBalanceRech) then
    abort;
Screen.Cursor := crSQLWait;
  if not MiseAJourAnalytiqueSurN1.retour then
    abort;
Screen.Cursor := crSQLWait;
TableGereCommit(tablen1);

DMBD.BrancheTableVersN(DMBalance.TaBalance);
result:=true;
//  abort;
   except
    TableGereRollBack(tablen1);
    TableGereRollBack(DMStock.TaStock);
    TableGereRollBack(DMEcritures.TaEcriture);
//    RestaureImmosDossier;
    RestaureImmosDossierNew;
    result:=false;
    abort;
   end;//fin du try except
finally
e.DatExoDebut:=DateDeb;
e.DatExoFin:=DateFin;
e.TypeEtatExercice:=EtatTmp;
Screen.Cursor := crSQLWait;
end;//fin finally
end;





function TDMCloture.VerifSoldeCompteAvantClotureDefinitive(liste:TstringList):TErreurcloture;
//verifier le contenu de certain compte avant clôture
//notamment les comptes de résultats
var
TotauxBalance:TTotauxBalance;
//i:integer;
Begin
if DMDiocEtatBal=nil then DMDiocEtatBal:=TDMDiocEtatBal.Create(application.MainForm);

TotauxBalance:=DMDiocEtatBal.SommeTotauxBalanceCalc(e.DatExoDebut,e.DatExoFin,liste,'compte');
if liste <> nil then
if ((((TotauxBalance.TotalCreditBase<>0) or(TotauxBalance.TotaldebitBase<>0)))and(TotauxBalance.SoldeFin<>0))then
  begin
  result.messages.MessageErreur:='Des écritures ont été effectuées sur les comptes de résultats.'+#10#13#10#13+'Vous devez vous même solder tous les comptes de résultat avant la clôture définitive';
  result.erreur.retour:=false;
  result.erreur.CodeErreur:=7001;
  end
  else
   if TotauxBalance.Soldefin<>0  then
      Begin
         result.messages.MessageErreur:='Tous les comptes de résultat (12...) n''ont pas été soldés, vous devez les solder avant la clôture définitive !!!';
         result.erreur.retour:=false;
         result.erreur.CodeErreur:=7003;
      End;
End;


Procedure TDMCloture.TraitementCloture7003(sender:Tobject);
var
ParamAfficheRepartitionResult:TParamAfficheRepartitionResult;
Begin
 //Repartition à faire avant clôture
 //ouvrir fenêtre de traitement de la repartition
ParamAfficheRepartitionResult.AffichageModal:=true;
ParamAfficheRepartitionResult.Affiche:=true;
ParamAfficheRepartitionResult.TitreForm:='Répartition du Résultat';
ParamAfficheRepartitionResult.SousTitreForm:='Clôture : Répartition du résultat';
ParamAfficheRepartitionResult.ListeCompte:=Tstringlist.Create;
FiltrageDataSet(dmrech.TaPlanCptRech,'compte=''12*''');
ParamAfficheRepartitionResult.ListeCompte:=ChampTableVersListe('compte',dmrech.TaPlanCptRech);
 if not AideRepartitionAffiche(ParamAfficheRepartitionResult) then
   abort;
End;

Procedure TDMCloture.TraitementCloture7001(sender:Tobject);
Begin
  //Problème d'écritures passées sur les comptes de résultats
  //ouvrir la balance pour consultation et réctification par l'utilisateur
  Main.Balance2Click(Main.Balance2);
End;

Procedure TDMCloture.TraitementCloture7002(sender:Tobject);
Begin
  //Problème d'écritures passées sur les comptes de résultats
  //ouvrir la balance pour consultation et réctification par l'utilisateur
  Main.Balance1Click(Main.Bilandouverture1);
End;


Procedure TDMCloture.TraitementCloture11001(sender:Tobject);
Begin
if e.ExerciceCloture then
   showmessage('Cet exercice est clôturé, vous ne pouvez pas effectuer de modification sur la balance.')
else
if not MiseAJourBalanceNCpt then
  begin
   showmessage('Erreur sur la balance des mouvements, la correction ne peut pas s''effectuer correctement');
   abort;
  end;
End;

Procedure TDMCloture.TraitementCloture12001(sender:Tobject);
Begin
if e.ExerciceCloture then
   showmessage('Cet exercice est clôturé, vous ne pouvez pas effectuer de modification sur la balance des tiers.')
else
if not MiseAJourBalanceNTiers then
  begin
   showmessage('Erreur sur la balance des tiers, la correction ne peut pas s''effectuer correctement');
   abort;
  end;
End;


function TDMCloture.VerifAvantCloture(Etape:integer):TRetourListeErreur;
var
MessageTemp:Tmessages;
ListeCloture:PListCloture;
erreur:TerreurCloture;
listeCptResultat:tstringlist;
Begin
try//finally
  try//Except
    // Passer en revue tous les écrans de charges ou de produits succeptibles d'être repris
    //avant clôture définitive
    //Passer à l'état de cloture en cours
//Exception
result.ListErreur:=Tlist.Create;
result.NbProcedure:=0;
PatienterAffich;
    //vérif sur existence des Stocks d'ouverture   étape 0
    if etape in [0,99] then
    begin
      MessageTemp.MessageErreur:='';
      MessageTemp.MessageQuestion:='';
      new(ListeCloture);
      InitialiseListeCloture(ListeCloture^);
      ListeCloture.CodeVerif:=0;
      ListeCloture.TitreListe:='existence des Stocks d''Ouverture';
      if e.AccesOuverture then
      if not VerifExistStockOuverture(MessageTemp) then
         Begin
          ListeCloture.erreur.CodeErreur :=1002;
          ListeCloture.erreur.Retour:=false;
          ListeCloture.messages:=MessageTemp;
          ListeCloture.TitreBouton:='Création des Stocks d''Ouverture';
          ListeCloture.AdresseTraitement:=DMStock.MethodAddress('TraitementCloture'+inttostr(ListeCloture.erreur.CodeErreur));
         End;
     result.ListErreur.Add(ListeCloture);
//     ListeCloture.Obligatoire:=true;
    end;//fin si etape = 0 ou 99

      ///////// Verif sur reprise des Stocks d'ouverture      étape 1
    if etape in [1,99] then
    begin
      MessageTemp.MessageErreur:='';
      new(ListeCloture);
      InitialiseListeCloture(ListeCloture^);
      ListeCloture.CodeVerif:=1;
      ListeCloture.TitreListe:='Reprise des Stocks d''Ouverture';
      if not VerifRepriseStockOuverture_OK(MessageTemp) then
         Begin
          ListeCloture.erreur.CodeErreur :=1000;
          ListeCloture.erreur.Retour:=false;
          ListeCloture.messages:=MessageTemp;
          ListeCloture.TitreBouton:='Reprise des Stocks d''Ouverture';
          ListeCloture.AdresseTraitement:=DMStock.MethodAddress('TraitementCloture'+inttostr(ListeCloture.erreur.CodeErreur));
         End;
     result.ListErreur.Add(ListeCloture);
     //ListeCloture.Obligatoire:=true;
    end;//fin si etape 1 ou 99

      ///////// Verif sur existence des Stocks de clôture     étape 2
    if etape in [2,99] then
    begin
      MessageTemp.MessageErreur:='';
      new(ListeCloture);
      InitialiseListeCloture(ListeCloture^);
      ListeCloture.CodeVerif:=2;
      ListeCloture.TitreListe:='Existence des Stocks de clôture';
      if not VerifExistStockCloture(MessageTemp) then
         Begin
      //remplissage de la liste des verif effectuées
          ListeCloture.erreur.CodeErreur :=1001;
          ListeCloture.erreur.Retour:=false;
          ListeCloture.messages:=MessageTemp;
          ListeCloture.TitreBouton:='Création des stocks de clôture';
          ListeCloture.AdresseTraitement:=DMStock.MethodAddress('TraitementCloture'+inttostr(ListeCloture.erreur.CodeErreur));
         End;
     result.ListErreur.Add(ListeCloture);
   end;//fin si etape 2 ou 99
// Fin des Stocks


      ///////// Verif sur Charges A Payer           étape 3
    if etape in [3,99] then
    begin
      MessageTemp.MessageErreur:='';
      new(ListeCloture);
      InitialiseListeCloture(ListeCloture^);
      ListeCloture.CodeVerif:=3;
      ListeCloture.TitreListe:='Reprise des charges à payer d''Ouverture';
      if not VerifRepriseChargesOuverture_OK(MessageTemp) then
        Begin
          ListeCloture.erreur.CodeErreur :=2000;
          ListeCloture.erreur.Retour:=false;
          ListeCloture.messages:=MessageTemp;
          ListeCloture.TitreBouton:='Reprise des charges à payer d''Ouverture';
          ListeCloture.AdresseTraitement:=DMChargeAPayer.MethodAddress('TraitementCloture'+inttostr(ListeCloture.erreur.CodeErreur));
        End;
     result.ListErreur.Add(ListeCloture);
    end;//fin si etape 3 ou 99

      ///////// Verif sur Charges constatées d'avances    étape 4
    if etape in [4,99] then
    begin
      MessageTemp.MessageErreur:='';
      new(ListeCloture);
      InitialiseListeCloture(ListeCloture^);
      ListeCloture.CodeVerif:=4;
      ListeCloture.TitreListe:='Reprise des charges Constatées d''Ouverture';
      if not VerifRepriseChargesCAOuverture_OK(MessageTemp) then
        Begin
          ListeCloture.erreur.CodeErreur :=3000;
          ListeCloture.erreur.Retour:=false;
          ListeCloture.messages:=MessageTemp;
          ListeCloture.TitreBouton:='Reprise des charges Constatées d''Ouverture';
          ListeCloture.AdresseTraitement:=DMChargeCA.MethodAddress('TraitementCloture'+inttostr(ListeCloture.erreur.CodeErreur));
        End;
     result.ListErreur.Add(ListeCloture);
    end;//fin si etape 4 ou 99

      ///////// Verif sur Charges à Répartir                étape 5
    if etape in [5,99] then
    begin
      MessageTemp.MessageErreur:='';
      new(ListeCloture);
      InitialiseListeCloture(ListeCloture^);
      ListeCloture.CodeVerif:=5;
      ListeCloture.TitreListe:='Reprise des charges à répartir d''Ouverture';
      if not VerifRepriseChargesARepartir(MessageTemp) then
        Begin
          ListeCloture.erreur.CodeErreur :=4000;
          ListeCloture.erreur.Retour:=false;
          ListeCloture.messages:=MessageTemp;
          ListeCloture.TitreBouton:='Reprise des charges à répartir d''Ouverture';
          ListeCloture.AdresseTraitement:=DMChargeRepartir.MethodAddress('TraitementCloture'+inttostr(ListeCloture.erreur.CodeErreur));
        End;
     result.ListErreur.Add(ListeCloture);
    end;//fin si etape 5 ou 99


      ///////// Verif sur Provisions                     étape 6
    if etape in [6,99] then
    begin
      MessageTemp.MessageErreur:='';
      new(ListeCloture);
      InitialiseListeCloture(ListeCloture^);
      ListeCloture.CodeVerif:=6;
      ListeCloture.TitreListe:='Reprise des provisions d''Ouverture';
      if not VerifRepriseProvisions(MessageTemp) then
        Begin
          ListeCloture.erreur.CodeErreur :=5000;
          ListeCloture.erreur.Retour:=false;
          ListeCloture.messages:=MessageTemp;
          ListeCloture.TitreBouton:='Reprise des provisions d''Ouverture';
          ListeCloture.AdresseTraitement:=DMProvisions.MethodAddress('TraitementCloture'+inttostr(ListeCloture.erreur.CodeErreur));
        End;
      result.ListErreur.Add(ListeCloture);
    end;//fin si etape 6 ou 99

      ////////////Vérif immos                             étape 7
    if etape in [7,99] then
    begin
      MessageTemp.MessageErreur:='';
      InitialiseListeCloture(erreur);
      new(ListeCloture);
      InitialiseListeCloture(ListeCloture^);
      ListeCloture.CodeVerif:=7;
      ListeCloture.TitreListe:='Vérification de la gestion des immobilisations (Acquisition et Cession)';
      erreur:=VerifResteAcquisitionOuCession_AvantCloture(e.DatExoDebut,e.DatExoFin);
      if ((erreur.erreur.retour=false)or(erreur.erreur.CodeErreur<>0)) then
        Begin
          ListeCloture.ListErreur:=erreur.ListErreur;
          ListeCloture.erreur.CodeErreur :=erreur.erreur.CodeErreur;
          ListeCloture.erreur.Retour:=false;
          ListeCloture.messages:=erreur.messages;
          ListeCloture.TitreBouton:=erreur.TitreBouton;
          ListeCloture.AdresseTraitement:=DMImmo_Clo.MethodAddress('TraitementCloture'+inttostr(ListeCloture.erreur.CodeErreur));
        End;
     result.ListErreur.Add(ListeCloture);
    end;//fin si etape 7 ou 99


      ////////////Vérif immos                             étape 8 (deuxième procédure)
    if etape in [8,99] then
    begin
      InitialiseListeCloture(erreur);
      new(ListeCloture);
      InitialiseListeCloture(ListeCloture^);
      ListeCloture.CodeVerif:=8;
      ListeCloture.TitreListe:='Vérification de la gestion des immobilisations (Solde)';
      erreur:=VerifGestionImmo_AvantCloture(e.DatExoDebut,e.DatExoFin);
      if ((erreur.erreur.retour=false)or(erreur.erreur.CodeErreur<>0)) then
        Begin
          ListeCloture.ListErreur:=erreur.ListErreur;
          ListeCloture.erreur.CodeErreur :=erreur.erreur.CodeErreur;
          if erreur.erreur.CodeErreur<>5 then
            ListeCloture.erreur.Retour:=false;
          ListeCloture.messages:=erreur.messages;
          ListeCloture.TitreBouton:=erreur.TitreBouton;
          ListeCloture.AdresseTraitement:=DMImmo_Clo.MethodAddress('TraitementCloture'+inttostr(ListeCloture.erreur.CodeErreur));
        End;
//     if ListeCloture.erreur.CodeErreur in [2,3,6] then
//       ListeCloture.Obligatoire:=true;
     result.ListErreur.Add(ListeCloture);
    end;//fin si etape 8 ou 99

        //verif si compte de résult est soldé            étape 9
    if etape in [9,99] then
    begin
      InitialiseListeCloture(erreur);
      listeCptResultat:=tstringlist.Create;
      listeCptResultat.Add('12*');
      new(ListeCloture);
      InitialiseListeCloture(ListeCloture^);
      ListeCloture.CodeVerif:=9;
      ListeCloture.TitreListe:='Vérification du compte de résultat';
      erreur:=VerifSoldeCompteAvantClotureDefinitive(listeCptResultat);
      if not Erreur.erreur.Retour then
        Begin
          ListeCloture.erreur.CodeErreur :=erreur.erreur.CodeErreur;
          ListeCloture.erreur.Retour:=false;
          ListeCloture.messages:=erreur.messages;
          if erreur.erreur.CodeErreur=7001 then
            ListeCloture.TitreBouton:='Vérifier les soldes sur les comptes de résultat'
          else
            ListeCloture.TitreBouton:='Solder les comptes de résultat';
          ListeCloture.AdresseTraitement:=DMCloture.MethodAddress('TraitementCloture'+inttostr(ListeCloture.erreur.CodeErreur));
        end;
      //ListeCloture.Obligatoire:=true;
      result.ListErreur.Add(ListeCloture);
    end;//fin si etape 9 ou 99

//      vérifier si toutes les déclarations tva sont à jour          étape 10
    if etape in [10,99] then
    begin
      MessageTemp.MessageErreur:='';
      InitialiseListeCloture(erreur);
      new(ListeCloture);
      InitialiseListeCloture(ListeCloture^);
      ListeCloture.CodeVerif:=10;
      ListeCloture.TitreListe:='Vérification des déclarations de TVA';
      erreur.erreur:=Verif_SiDeclarationTvaAJour(MessageTemp);
      if not erreur.erreur.retour then
        Begin
          ListeCloture.erreur.CodeErreur :=erreur.erreur.CodeErreur;
          ListeCloture.erreur.Retour:=false;
          ListeCloture.messages:=MessageTemp;
          ListeCloture.TitreBouton:='Création de la déclaration de TVA';
          ListeCloture.AdresseTraitement:=DMTmTVA.MethodAddress('TraitementCloture'+copy(inttostr(ListeCloture.erreur.CodeErreur),1,1));
        End;
//     ListeCloture.Obligatoire:=true;
     result.ListErreur.Add(ListeCloture);
    end;//fin si etape 10 ou 99


//  if not CorrectionDeLaBalanceDesMouvements(false,false).retour then


//      vérifier si balance des mouvements correcte          étape 11
    if etape in [11,99] then
    begin
      MessageTemp.MessageErreur:='';
      InitialiseListeCloture(erreur);
      new(ListeCloture);
      InitialiseListeCloture(ListeCloture^);
      ListeCloture.CodeVerif:=11;
      ListeCloture.TitreListe:='Vérification de la balance des mouvements';
      erreur.erreur.retour:=CorrectionDeLaBalanceDesMouvements(false,false).retour;
      if not erreur.erreur.retour then
        Begin
          ListeCloture.erreur.CodeErreur :=11001;
          ListeCloture.erreur.Retour:=false;
          ListeCloture.messages.MessageErreur:='la balance des mouvements n''est pas correcte, vous devez la corriger avant la clôture définitive';
          ListeCloture.TitreBouton:='Correction de la balance des mouvements';
          ListeCloture.AdresseTraitement:=DMCloture.MethodAddress('TraitementCloture'+inttostr(ListeCloture.erreur.CodeErreur));
        End;
     ListeCloture.Obligatoire:=true;
     result.ListErreur.Add(ListeCloture);
    end;//fin si etape 111 ou 99


//      vérifier si balance des mouvements correcte          étape 12
    if etape in [12,99] then
    begin
      MessageTemp.MessageErreur:='';
      InitialiseListeCloture(erreur);
      new(ListeCloture);
      InitialiseListeCloture(ListeCloture^);
      ListeCloture.CodeVerif:=11;
      ListeCloture.TitreListe:='Vérification de la balance des tiers';
      erreur.erreur.retour:=CorrectionDeLaBalanceDesTiers(false,false).retour;
      if not erreur.erreur.retour then
        Begin
          ListeCloture.erreur.CodeErreur :=12001;
          ListeCloture.erreur.Retour:=false;
          ListeCloture.messages.MessageErreur:='la balance des tiers n''est pas correcte, vous devez la corriger avant la clôture définitive';
          ListeCloture.TitreBouton:='Correction de la balance des tiers';
          ListeCloture.AdresseTraitement:=DMCloture.MethodAddress('TraitementCloture'+inttostr(ListeCloture.erreur.CodeErreur));
        End;
     ListeCloture.Obligatoire:=true;
     result.ListErreur.Add(ListeCloture);
    end;//fin si etape 12 ou 99


//      vérifier si balance équilibrée          étape 13
    if etape in [13,99] then
    begin
      MessageTemp.MessageErreur:='';
      InitialiseListeCloture(erreur);
      new(ListeCloture);
      InitialiseListeCloture(ListeCloture^);
      ListeCloture.CodeVerif:=13;
      ListeCloture.TitreListe:='Vérification de l''équilibre de la balance';
      erreur.erreur:=DMBalance.VerifEquilibreBalanceN;
      if not erreur.erreur.retour then
        Begin
          ListeCloture.erreur.CodeErreur :=erreur.erreur.CodeErreur;
          ListeCloture.erreur.Retour:=false;
          if erreur.erreur.CodeErreur = 7001 then
            begin
            ListeCloture.messages.MessageErreur:='la balance de fin de l''exercice de base n''est pas équilibrée';
            ListeCloture.TitreBouton:='Visualisation de la balance';
            end
          else
            begin
            ListeCloture.messages.MessageErreur:='le bilan d''ouverture de l''exercice de base n''est pas équilibrée';
            ListeCloture.TitreBouton:='Visualisation du bilan d''ouverture';
            end;
          ListeCloture.AdresseTraitement:=DMCloture.MethodAddress('TraitementCloture'+inttostr(ListeCloture.erreur.CodeErreur));
        End;
     ListeCloture.Obligatoire:=true;
     result.ListErreur.Add(ListeCloture);
    end;//fin si etape 13 ou 99

    if etape=100 then//je m'en sers pour récupérer le nombre de procédure de vérif en place
      begin
        result.NbProcedure:=13;
      end;

  except
   abort;
  end;//fin du try except
Finally
 PatienterFermer;
end;//fin du try finally
End;

procedure TDMCloture.DMClotureCreate(Sender: TObject);
begin
 if DMStock=nil then
 DMStock:=TDMStock.Create(Application.MainForm);

 if DMChargeRepartir=nil then
 DMChargeRepartir:=TDMChargeRepartir.Create(self);

 if DMChargeCA=nil then
 DMChargeCA:=TDMChargeCA.Create(self);

 if DMChargeAPayer=nil then
 DMChargeAPayer:=TDMChargeAPayer.Create(self);

 if DMProvisions=nil then
 DMProvisions:=TDMProvisions.Create(self);

 if DMDepenseEnt=nil then
 DMDepenseEnt:=TDMDepenseEnt.Create(self);

 if DMImmo_Clo=nil then
 DMImmo_Clo:=TDMImmo_Clo.Create(self);
end;

procedure TDMCloture.DMClotureDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
if DMImmo_Clo<>nil then DMImmo_Clo.Free;
LibereObjet(Tobject(JournalErreur));
DMCloture:=nil;

end;

function TDMCloture.ClotureDefinitiveExercice(RepDossier,NomDossier,NomExo:string):Texceptlgr;
var
messages:string;
i:integer;
InfosGestDossier:TInfosGestDossier;
dateDeb,dateFin:TDateTime;
Liste : TStringList;
begin

if DMRech=nil then DMRech:=TDMRech.Create(application.MainForm);
if DMBalance=nil then DMBalance:=TDMBalance.Create(application.MainForm);
if DMPieces=nil then DMPieces:=TDMPieces.Create(application.MainForm);
try//finally
  try //
if(FileExists(IncludeTrailingPathDelimiter(e.RepertoireExercice)+DMRech.TaImmosRech.TableName))then
  SupprimerTable(DMRech.TaBalanceRech.DatabaseName,DMRech.TaImmosRech.TableName);
DeleteFile(IncludeTrailingPathDelimiter(e.RepertoireExercice)+DMRech.TaImmosRech.TableName);
if(FileExists(IncludeTrailingPathDelimiter(e.RepertoireExercice)+DMRech.TaImmosRech.TableName))then abort;
//PatienterAffich;
Screen.Cursor := crSQLWait;
//Vérifier la table GDossier si elle peut être réindexée
Liste := TStringList.Create;
Liste.Add(DMRech.TaGDossierRech.DatabaseName+';'+DMRech.TaGDossierRech.TableName+';1');
if(ReindexationTableProc(liste,nil,false,false,true).retour=false)then
  begin
      messages:='Arrêt de la clôture définitive.'+RetourChariotSimple+
      'La table GDossier n''a pas pu être ré-indexée.'+RetourChariotSimple+
      'Merci d''appeler le service de maintenance (05.63.30.31.66)';
      abort;
  end;
Screen.Cursor := crSQLWait;

if(SauvegardeImmosExo(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'immosTemporaire.db',IncludeTrailingPathDelimiter(e.RepertoireDossier)+'immos.db').retour=false)then abort;
//if not ControleAmort_DerogSurChangementExercice(nil,false).retour then abort;
if(E.ControleDuDossier)then if(coherenceImmosReport(nil,false,2).retour=false)then abort;

 
  if GEstDossierExerciceEnCoursCloturable(E) then
   begin//si exo cloturable
       FiltrageDataSet(DMRech.TaGestDossierRech,CreeFiltreET(['Nom_Dossier','Cloture'],[NomDossier,false]) +' and Nom_exo = '''+NomExo+'''');
       dateDeb:=DMRech.TaGestDossierRech.FindField('DATE_DEB_EXO').AsDateTime;
       dateFin:=DMRech.TaGestDossierRech.FindField('DATE_FIN_EXO').AsDateTime;

   if GEstDossierNbExoNonCloture(NomDossier) = 2 then
    begin
     FiltrageDataSet(DMRech.TaGestDossierRech,CreeFiltreET(['Nom_Dossier','Cloture'],[NomDossier,false]) +' and Nom_exo <> '''+NomExo+'''');
     //     if not CreeNouveauExo(E.RepertoireDossier+'\'+DMRech.TaGestDossierRech.FindField('Nom_Exo').AsString,false,true) then
     if not CreeNouveauExo(RepDossier+DMRech.TaGestDossierRech.FindField('Nom_Exo').AsString,false,true) then
      begin
       messages:='Un problème est apparut lors de la vérification de l''exercice N+1, il n''existe pas sur votre disque dur !';
     JournalErreur.Add(LigneSeparation);
       JournalErreur.Add(messages);
       abort;
      end;
    end
    else if GEstDossierNbExoNonCloture(NomDossier) = 1 then
    begin
     if DMRech.TaGestDossierRech.FindField('id_Dossier').Asinteger<0 then
      begin
         messages:='Abandon de la procedure de changement d''exercice !'+
                     RetourChariotDouble+
                     'Ce dossier est un dossier importé, vous ne pouvez pas créer de nouvel exercice !';

          JournalErreur.Add(LigneSeparation);
         JournalErreur.Add(messages);
         abort;
      end
     else
      begin
       FiltrageDataSet(DMRech.TaGestDossierRech,CreeFiltreET(['Nom_Dossier','Cloture'],[NomDossier,false]) +' and Nom_exo = '''+NomExo+'''');
       if CreationNewExoAffich(NomDossier,RepDossier,DMRech.TaGestDossierRech.FindField('DATE_DEB_EXO').AsDateTime,DMRech.TaGestDossierRech.FindField('DATE_FIN_EXO').AsDateTime) then
        begin
        end
        else
        begin
         messages:='Abandon de la procedure de changement d''exercice !';
         abort;
        end;
      end;
    end
    else
    begin
     messages:='Impossible d''effectuer le changement d''exercice !';
     JournalErreur.Add(LigneSeparation);
     JournalErreur.Add(messages);
     abort;
    end;
Screen.Cursor := crSQLWait;

  InfosGestDossier:=ChercheInfos_ExoN1(NomDossier);
  //effectuer tous les changements d'exercice avec verrouillage de l'ancien exercice
                      //*****************************//
                 

  if application.MessageBox(Pchar(ChangementExerciceDefinitifWarning),'Changement d''exercice',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON1)=mrno
  then abort;

  //creer le journal de cloture comprenant toutes les erreurs rencontrées dans le changement d''exercice
    JournalErreur.SaveToFile(e.RepertoireDossier+C_Cloture_Exercice+e.NomExo+'.TXT');
    messages:='';


     JournalErreur.Add(LigneSeparation);
     JournalErreur.Add('Validation du Rapport');

     result.retour:=false;
     while result.retour=false do
       begin
           RapportClotureAffich(nil);
           case Application.MessageBox(Pchar(ChangementExerciceDefinitifWarning2),'Attention',MB_ICONWARNING+MB_YESNOCANCEL+MB_DEFBUTTON1) of
             mrYes:begin
                       result.retour:=true;
                       result.Mess:='La procédure de clôture a été validée';
                       JournalErreur.Add(result.Mess);
                   end;
             mrno:Begin
                   result.Mess:='La procédure de clôture n''a pas été validée';
                   JournalErreur.Add(result.Mess);
                   abort;
                  end;
             mrCancel:result.retour:=false;
           end;//fin du case
       end;
Screen.Cursor := crSQLWait;
   try
  if not DMCloture.ReecritureDesTablesPourNouvelExo then
        abort;
    except
      begin
       messages:='Problème lors de la réécriture des tables dans le nouvel exercice';
       abort;
      end;
    end;
Screen.Cursor := crSQLWait;
  //Mise à jour de la balance
  try
  if not DMBalance.MiseAJourGlobalBalance_N_vers_N1(false)then
    abort;
  except
    begin
     messages:='Problème lors de la mise à jour de la balance dans le nouvel exercice';
     abort;
    end;
  end;
//  //

  //Mise à jour de la balance des tiers
  try
  if not DMBalance.MiseAJourGlobalBalanceTiers_N_vers_N1 then
    abort;
  except
    begin
     messages:='Problème lors de la mise à jour de la balance des Tiers dans le nouvel exercice';
     abort;
    end;
  end;


  //calculer le résultat pour le mettre sur le compte de bénéfice ou de perte selon le cas
  try
    result:=DMBalance.MiseAJourDuResultatDansN1;
  if not result.retour then   abort;
  except
    messages:='Problème lors de la Mise à jour du resultat dans le nouvel exercice';
    abort;
  end;
//  //verrouillage des déclarations TVA de l'année à clôturer
//  VerrouillageDeclaration_Exercice(DMRech.TaGestDossierRech.FindField('DATE_FIN_EXO').AsDateTime);


  //Marquer Clôturé l'ancien exercice dans gest_Dossier
  try
     FiltrageDataSet(DMRech.TaGestDossierRech,CreeFiltreET(['Nom_Dossier','Cloture'],[NomDossier,false]) +' and Nom_exo = '''+NomExo+'''');
    if not DMBD.CloturerExercice_N(DMProg.TaGestDosModif,DMRech.TaGestDossierRech.FindField('id_Dossier').Asinteger,DMRech.TaGestDossierRech.FindField('id_Table').Asinteger)then abort;
  except
    Begin
     messages:='Problème lors de la clôture du dossier en cours';
     abort;
    end;
   end;


    //Mettre à jour le champ "Exo_Base" dans le dossier avec le nouveau code exo qui est "Exo_Saisie" courant
   try
    DMParamEntreprise.MiseAJourParamDossier_SurClotureDefinitiveExercice(InfosGestDossier.EXO_SAISIE);
   except
        messages:='Problème lors de la Mise à jour des paramètres de l''exercice clôturé';
       abort;
   end;
    TableGereCommit(DMPieces.TaPiece);
    TableGereCommit(DMBalance.TaBalance);

  //verrouillage des déclarations TVA de l'année à clôturer
  VerrouillageDeclaration_Exercice(dateFin);

    showmessage('La clôture et le changement d''exercice se sont bien déroulés.');
    JournalErreur.Add(LigneSeparation);
    JournalErreur.Add('La clôture et le changement d''exercice se sont déroulés avec succès, le '+LibDates.DateInfos(now,'-').DateStrFormat+' à '+LibDates.HeureInfos(now,'-').HeureStrFormate);

  //creer le journal de cloture comprenant toutes les erreurs rencontrées dans le changement d''exercice
    JournalErreur.SaveToFile(e.RepertoireDossier+C_Cloture_Exercice+e.NomExo+'.TXT');
    if not FermerDossier(E) then abort;
    Main.OuvreExo(NomDossier,InfosGestDossier.Nom_Exo,false);

  end//si exo cloturable
  else
    begin
      Messages:='L'' exercice : '+NomExo+' n''est pas clôturable';
      abort;
    end;
  except
    result.retour:=false;
    if not empty(messages) then Application.MessageBox(Pchar(messages+RetourChariotSimple+AppelerServiceMaintenance),'Attention',MB_ICONERROR);
      //showmessage(messages);
    TableGereRollBack(DMPieces.TaPiece);
    TableGereRollBack(DMBalance.TaBalance);
    RestaureImmosDossierNew;
     JournalErreur.Add(Messages);
     JournalErreur.Add(LigneSeparation);
     JournalErreur.Add('Abandon de la clôture, le '+LibDates.DateInfos(now,'-').DateStrFormat+' à '+LibDates.HeureInfos(now,'-').HeureStrFormate);
     //creer le journal de cloture comprenant toutes les erreurs rencontrées dans le changement d''exercice
    JournalErreur.SaveToFile(e.RepertoireDossier+C_Cloture_Exercice+e.NomExo+'.TXT');
    //Screen.Cursor := crDefault;
    abort;
  end;//fin du try except
finally
  if(result.retour=true)then if coherenceImmosReport(nil,false,2).retour=false then
    ShowMessage('Un incident est survenu lors du changement d''exercice, vous devez restaurer la sauvegarde.'+RetourChariotSimple+
    'faite avant la clôture de l''exercice...'+
    AppelerServiceMaintenance);
  if (result.retour=false)and( VerifTableImmosIdentique(nil,false).retour=false)then
    RestaureImmosDossierNew(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'immosTemporaire.db',DM_C_NomAliasDossier);
if(FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'immosTemporaire.db'))then
  begin
    SupprimerTable(DM_C_NomAliasDossier,'immosTemporaire.db');
    DeleteFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'immosTemporaire.db');
  end;
  Screen.Cursor := crDefault;
  //PatienterFermer;
end;
end;

Function RapportClotureAffich(JournalErreur:Tstringlist):TExceptLGR;
begin
  try //except
    result.retour:= AfficheReport(Pchar(e.RepertoireDossier+C_Cloture_Exercice+e.NomExo+'.TXT'),
                      'Rapport de votre clôture',
                      PChar('Période du '+LibDates.DateInfos(E.DatExoDebut).DateStr+' au '+LibDates.DateInfos(E.DatExoFin).DateStr),
                      PChar('Dossier : '+E.NomDossier +' - ' +e.RaisonSociale),
                      600,
                      800,
                      1,
                      0)=mrok;
    if not result.retour then
      Begin
       result.Mess:='La procédure de clôture n''a pas été validée';
      end
    else
      result.Mess:='OK';
  except
    result.retour:=false;
  end;
end;

function TDMCloture.MiseAJourAnalytiqueSurN1(confirmation : Boolean):TExceptLGR;
var
DatamoduleCree:boolean;
begin
DatamoduleCree:=false;
  try
    try//except
Initialise_ExceptLGR(result);
//Table des affectations des comptes dans l'analytique

   if DMAnalytiques=nil then
   begin
     DMAnalytiques:=TDMAnalytiques.Create(application.MainForm);
     DatamoduleCree:=true;
   end;

   SauvegardeAnalytiqueExo;
   
   TableN1.TableName:=DMAnalytiques.Ta_Atelier_Activite.TableName;
   viderTable(TableN1);
   BatchMove1.Source:=DMAnalytiques.Ta_Atelier_Activite;
   BatchMove1.Destination:=TableN1;
   BatchMove1.Execute;

   TableN1.TableName:=DMAnalytiques.Ta_Compte_Atelier.TableName;
   viderTable(TableN1);
   BatchMove1.Source:=DMAnalytiques.Ta_Compte_Atelier;
   BatchMove1.Destination:=TableN1;
   BatchMove1.Execute;

   TableN1.TableName:=DMBalance.TaBalance.TableName;

   if DatamoduleCree then
     DMAnalytiques.Destroy;
//fin table analytique des affectations de comptes
    except
       result.retour:=false;
    end;//fin du except
  finally
  end;//fin du finally
end;

end.

