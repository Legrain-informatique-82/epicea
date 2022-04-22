unit DMRepartition;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,
  LibSQL,
  Lib_chaine,
  DMDiocEtatBalance,
  DMrecherche,
  DMConstantes,
  DMEcriture,
  E2_LibInfosTable,
  E2_Decl_Records,
  Gr_Librairie_Obj,
  E2_Librairie_Obj,
  LibDates,
  Gr_MultDos,
  E2_VisuListeView,
  LibZoneSaisie;

type
  TDMRepart = class(TDataModule)
    Balance: TTable;
    Repartition: TTable;
    Query1: TQuery;
    Table1: TTable;
    Table1ID: TIntegerField;
    Table1Type: TStringField;
    Table1ID_Ligne: TIntegerField;
    Table1Libelle: TStringField;
    Table1Col1: TStringField;
    Table1Col2: TStringField;
    Table1Col3: TStringField;
    Table1Col4: TStringField;
    Table1Col5: TStringField;
    Table1Col6: TStringField;
    Table1Col2New: TStringField;
    DataSource1: TDataSource;
    Table2: TTable;
    TaBalanceCptPourZoneBilan: TTable;
    TaBalanceCptPourZoneBilanCompte: TStringField;
    TaBalanceCptPourZoneBilanLibelle: TStringField;
    TaBalanceCptPourZoneBilanSoldeFinDebit: TCurrencyField;
    TaBalanceCptPourZoneBilanSoldeFinCredit: TCurrencyField;
    DaBalanceCptPourZoneBilan: TDataSource;
    TaPlanCpt: TTable;
    DaPlanCpt: TDataSource;
    TaReport: TTable;
    QuBalanceCptPourZoneBilan: TQuery;
    QuBalanceCptPourZoneBilanCompte: TStringField;
    QuBalanceCptPourZoneBilanLibelle: TStringField;
    QuBalanceCptPourZoneBilanSoldeFinDebit: TCurrencyField;
    QuBalanceCptPourZoneBilanSoldeFinCredit: TCurrencyField;
    QuBalanceCptPourZoneBilanSoldeReportDebit: TCurrencyField;
    QuBalanceCptPourZoneBilanSoldeReportCredit: TCurrencyField;
    TaReportLibelle: TStringField;
    TaReportCompte: TStringField;
    TaReportDebit_Report: TFloatField;
    TaReportCredit_Report: TFloatField;
    TaReportQt1_Report: TFloatField;
    TaReportQt2_Report: TFloatField;
    Repartition_Bic: TTable;
    RepartitionOuverture: TTable;
    RepartitionOuverture_Bic: TTable;
    procedure BtnDetailClickVisuListe(Sender: TObject);
    procedure DMRepartCreate(Sender: TObject);
    procedure DMRepartDestroy(Sender: TObject);
    procedure TaBalanceCptPourZoneBilanCalcFields(DataSet: TDataSet);
    procedure TaBalanceCptPourZoneBilanBeforeInsert(DataSet: TDataSet);
    procedure TaBalanceCptPourZoneBilanBeforeEdit(DataSet: TDataSet);
    procedure QuBalanceCptPourZoneBilanCalcFields(DataSet: TDataSet);
    Procedure VisuList_DetailClick(Sender : TObject);
    Procedure VisuList_ImprimerBalanceOuvertureClick(Sender : TObject);
    Procedure VisuList_ImprimerChargesEtProduitsOuvertureClick(Sender : TObject);    
    procedure QuBalanceCptPourZoneBilanFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    ListeCell : TStringList;    //contient la liste des cellules du PDF, leur montant
                              // et le détail des comptes la compose
    RetourViewListe:TRetourViewListe;
    ZoneCourante:integer;
  end;

type
  TRepartition = class(TObject)
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    MontantTotal : currency;   //montant total de la cellule
    libelleBilan : string;
    titre:string;
    soustitre:string;
    colBilan:string;
    cellule:string;
    Feuille:string;
    compte : TStringList;      //compte intervenant dans le montant total
    constructor Create;
    destructor Destroy;
  end;

type
  TMontant = class(TObject)
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    MontantCpt : currency;    //montant pour chacun des comptes
    constructor Create;
    destructor Destroy;
  end;

var
  DMRepart : TDMRepart;

  function est_reparti_debit(cpt,Regime,NomCol:string;Repartition:TDataSet):string;
  //retourne le code de la cellule de répartition du PDF correspondant au compte cpt au débit
  //dans la table Répartition

  function est_reparti_credit(cpt,Regime,NomCol:string;Repartition:TDataSet):string;
  //retourne le code de la cellule de répartition du PDF correspondant au compte cpt au crédit
  //dans la table Répartition

  function pererepart(cpt,Regime,NomCol:string;Repartition:TDataSet):string;
  //retourne le premier père du compte cpt qui est réparti dans la table Répartition

  Procedure AjouteCellule(NomPBilan_Debit,NomPBilan_Credit,cpt_a_repartir,Regime:String;Debit,Credit:Currency;Repartition:TDataset);
  //Remplit Une cellule de ListeCell

  procedure liste_cellule(Balance,Repartition:TDataSet;Regime:String);
  //initialise ListeCell

  Procedure SommeCellule(ParamLia:TDataSet;Ouverture:boolean=false);
  // Effectue les sommes et les attribues aux Zones prévues

Function VisuListeCompteDeZoneAffich(NomZone:String;ExercicePrecedent:Boolean):Boolean;
Function MaJReportChargeEtProduit(DataSet:TDataSet):Boolean;
Function AffichBilanOuvertureSurPeriode:Boolean;
Function AffichChargesEtProduitOuvertureSurPeriode:Boolean;
Procedure SommeCellule_Bic(ParamLia_Bic:TDataSet;Ouverture:boolean=false);

var
ListeEdition:TStringList;


implementation


uses E2_VisuListe, DMBaseDonnee,  E2_DetailEcr, DMPiece, DMPlanCpt;
{$R *.DFM}

constructor TRepartition.Create;
    //constructeur
begin
  inherited Create;
  compte := TStringList.Create;
end;

destructor TRepartition.Destroy;
//destructeur
begin
  compte.Free;
  inherited Destroy;
end;

constructor TMontant.Create;
 //constructeur
begin
  inherited Create;
end;

destructor TMontant.Destroy;
    //destructeur
begin
  inherited Destroy;
end;

function est_reparti_debit(cpt,Regime,NomCol:string;Repartition:TDataSet):string;
  //retourne le code de la cellule de répartition du PDF correspondant au compte cpt au débit
  //dans la table Répartition
const ValDefaut : string = '00';      //valeur dans la table si le compte n'est pas réparti
begin
      est_reparti_debit := ValDefaut;
      FiltrageDataSet(Repartition,CreeFiltreEt(['Compte','Regime'],[Cpt,Regime]));
      if (Repartition.RecordCount=1) and (Repartition.FindField(NomCol).AsString <>ValDefaut) then
            //cpt existe et est réparti
            est_reparti_debit := Repartition.FindField(NomCol).AsString;
      Repartition.Filtered := false;
end;

//retourne le code de la cellule de répartition du PDF correspondant au compte cpt au crédit
//dans la table Répartition
function est_reparti_credit(cpt,Regime,NomCol:string;Repartition:TDataSet):string;
const ValDefaut : string = '00';    //valeur dans la table si le compte n'est pas réparti
begin
      est_reparti_credit := ValDefaut;
      FiltrageDataSet(Repartition,CreeFiltreEt(['Compte','Regime'],[Cpt,Regime]));
      if (Repartition.RecordCount=1) and (Repartition.FindField(NomCol).AsString <>ValDefaut) then
            //cpt existe et est réparti
            est_reparti_credit:=Repartition.FindField(NomCol).AsString;
      Repartition.Filtered := false;
end;



//retourne le premier père du compte cpt qui est réparti dans la table Répartition
function pererepart(cpt,Regime,NomCol:string;Repartition:TDataSet):string;
const ValDefaut : string = '00'; //valeur dans la table si le compte n'est pas réparti
var i   : integer;
    res : boolean;
begin
      i  := length(cpt);
      res:= false;
      while (res=false) and (i>1) do
      begin
          i := i-1;
          cpt:=copy(cpt,0,i);
          if est_reparti_debit(cpt,Regime,NomCol,Repartition)<>ValDefaut then
             res := true;
      end;
      pererepart := cpt;
end;



//Remplit Une cellule de ListeCell
Procedure AjouteCellule(NomPBilan_Debit,NomPBilan_Credit,cpt_a_repartir,Regime:String;Debit,Credit:Currency;Repartition:TDataset);
    var
      InfoRepartD, InfoRepartC : TRepartition;
      MontantD, MontantC :TMontant;
      cpt,                                   //compte réellement utilisé dans la répartition
//      cpt_a_repartir,                        //compte traité
      cellule,                               //Nom de la cellule dans le PDF
//      NomPBilan_Debit,                        // Nom de la colonne débit traité dans PBilan
//      NomPBilan_Credit,                        // Nom de la colonne crédit traité dans PBilan
      signe : string;
//      Debit,                                 //Débit dans la balance
//      Credit : Currency;                     //Crédit dans la balance
      i : integer;
Begin
//        If ((est_reparti_debit(cpt_a_repartir,Regime,NomPBilan_Debit,DMRepart.Repartition) <> '00')
//            and (est_reparti_debit(cpt_a_repartir,Regime,NomPBilan_Debit,DMRepart.Repartition) <> ''))  then
        If not empty(est_reparti_debit(cpt_a_repartir,Regime,NomPBilan_Debit,Repartition)) then
         begin
            MontantD := TMontant.Create;
            MontantC := TMontant.Create;
            InfoRepartD := TRepartition.Create;
            InfoRepartC := TRepartition.Create;

//            if cpt_a_repartir = '44562' then showmessage('top');

            if est_reparti_debit(cpt_a_repartir,Regime,NomPBilan_Debit,Repartition)<>'00' then
               //le compte est réparti directement
               cpt:=cpt_a_repartir
            else
               //le compte n'est pas réparti, il faut prendre son père
                cpt:=pererepart(cpt_a_repartir,Regime,NomPBilan_Debit,Repartition);

            /////////////////--DEBIT--//////////////////////////////////////////////
            Cellule := copy(est_reparti_debit(cpt,Regime,NomPBilan_Debit,Repartition),2,length(est_reparti_debit(cpt,Regime,NomPBilan_Debit,Repartition)));
            if not empty(cellule) then
              begin //si cellule non vide
                  signe   := copy(est_reparti_debit(cpt,Regime,NomPBilan_Debit,Repartition),0,1);
                  if signe='+' then
                     MontantD.MontantCpt := Debit
                  else
                     MontantD.MontantCpt := -Debit;

                  if DMRepart.ListeCell.IndexOf(Cellule)=-1 then
                  begin
                     //nouvelle cellule
                     InfoRepartD.compte.AddObject(cpt_a_repartir,MontantD);
                     if signe='+' then
                        InfoRepartD.MontantTotal := debit
                     else
                        InfoRepartD.MontantTotal := -debit;
                      if MontantD.MontantCpt <> 0 then
                       DMRepart.ListeCell.AddObject(Cellule,InfoRepartD);
                  end
                  else
                  begin
                     //modification d'un cellule deja presente
                     if signe='+' then
                        TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).MontantTotal := TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).MontantTotal+debit
                     else
                        TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).MontantTotal := TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).MontantTotal-debit;
      //               I := TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).compte.indexof(cpt_a_repartir);
      //               if I<>-1 then
                      if MontantD.MontantCpt <> 0 then
                       TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).compte.AddObject(cpt_a_repartir,MontantD);
      //                  if TMontant(TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).compte.Objects[i]).MontantCpt=0 then
      //                  //modification du montant du compte deja ajouté au debit avec un montant = 0
      //                     TMontant(TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).compte.Objects[i]).MontantCpt := MontantC.MontantCpt;


      //               TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).compte.AddObject(cpt_a_repartir,MontantD);
                  end;
              end;//fin si cellule non vide
            //////////////////--CREDIT--////////////////////////////////////////////
            Cellule := copy(est_reparti_credit(cpt,Regime,NomPBilan_Credit,Repartition),2,length(est_reparti_credit(cpt,Regime,NomPBilan_Credit,Repartition)));
            if not empty(cellule) then
              begin //si cellule non vide
                  signe   := copy(est_reparti_credit(cpt,Regime,NomPBilan_Credit,Repartition),0,1);
                  if signe='+' then
                     MontantC.MontantCpt := Credit
                  else
                     MontantC.MontantCpt := -Credit;

                  if DMRepart.ListeCell.IndexOf(Cellule)=-1 then
                  begin
                     //nouvelle cellule
                     InfoRepartC.compte.AddObject(cpt_a_repartir,MontantC);
                     if signe='+' then
                        InfoRepartC.MontantTotal := credit
                     else
                        InfoRepartC.MontantTotal := -credit;
                      if MontantC.MontantCpt <> 0 then
                       DMRepart.ListeCell.AddObject(Cellule,InfoRepartC);
                  end
                  else
                  begin
                     //modification d'un cellule deja presente
                     if signe='+' then
                        TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).MontantTotal := TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).MontantTotal+credit
                     else
                        TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).MontantTotal := TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).MontantTotal-credit;
      //               I := TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).compte.indexof(cpt_a_repartir);
      //               if I<>-1 then
                      if MontantC.MontantCpt <> 0 then
                       TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).compte.AddObject(cpt_a_repartir,MontantC);
      //                  if TMontant(TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).compte.Objects[i]).MontantCpt=0 then
      //                  //modification du montant du compte deja ajouté au debit avec un montant = 0
      //                     TMontant(TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).compte.Objects[i]).MontantCpt := MontantC.MontantCpt;
                  end;
              end;//fin si cellule remplie
         end; // Fin Empty
End;

//initialise ListeCell
procedure liste_cellule(Balance,Repartition:TDataSet;Regime:String);
    var
      InfoRepartD, InfoRepartC : TRepartition;
      MontantD, MontantC :TMontant;
      cpt,                                   //compte réellement utilisé dans la répartition
      cpt_a_repartir,                        //compte traité
      cellule,                               //Nom de la cellule dans le PDF
      NomPBilan_Debit,                        // Nom de la colonne débit traité dans PBilan
      NomPBilan_Credit,                        // Nom de la colonne crédit traité dans PBilan
      signe : string;
      Debit,                                 //Débit dans la balance
      Credit : Currency;                     //Crédit dans la balance
      i : integer;
      requeteReport:TQuery;
  begin
    try//finally
      if DMRepart = nil then DMRepart:=TDMRepart.Create(Application.MainForm);

      DMDiocEtatBal.SommeTotauxBalanceCalc(E.DatExoDebut,E.DatExoFin,nil,'Compte');
      DMRepart.ListeCell.Clear;
      requeteReport:=TQuery.Create(application.MainForm);
        /////////////////////////////////////////////////////////////////////////
//
//      requeteReport.DatabaseName:=DMRepart.TaReport.DatabaseName;
//      requeteReport.SQL.Clear;
//      requeteReport.sql.Add('select * from Report.DB R  ');
//      requeteReport.sql.Add(' union select * from Balance.DB B where B.compte not in(select compte from report.db) order by compte ');
//      requeteReport.Open;


      /// Traitement de table report
      DeFiltrageDataSet(DMRepart.TaReport);
      DMRepart.TaReport.Refresh;
      DMRepart.TaReport.First;
      //parcours de la table TaReport
      while not DMRepart.TaReport.EOF do
       begin
         cpt_a_repartir:=DMRepart.TaReport.FindField('compte').AsString;
       // if cpt_a_repartir = '7752' then showmessage('stop');

         Debit:=DMRepart.TaReport.FindField('Debit_Report').AsCurrency;
         Credit:=DMRepart.TaReport.FindField('Credit_Report').AsCurrency;

         // Traitement des soldes Report Debut de la table Report
         NomPBilan_Debit := 'SoldeReportDebit';
         NomPBilan_Credit := 'SoldeReportCredit';

         AjouteCellule(NomPBilan_Debit,NomPBilan_Credit,cpt_a_repartir,Regime,Debit,Credit,Repartition);

         DMRepart.TaReport.Next;
        end;

        /////////////////////////////////////////////////////////////////////////

       /////////////////////////////////////////////////////////////////////////
      /// Traitement de la balance
      DeFiltrageDataSet(Balance);
      Balance.Refresh;
      Balance.First;
      while not Balance.EOF do begin
        //parcours de la balance
        cpt_a_repartir:=Balance.FindField('compte').AsString;
//        if cpt_a_repartir = '44562' then showmessage('stop');

        Debit:=Balance.FindField('Solde_Debit_Report_Calc').AsCurrency;
        Credit:=Balance.FindField('Solde_Credit_Report_Calc').AsCurrency;

        // Traitement des soldes Report Debut
        NomPBilan_Debit := 'SoldeReportDebit';
        NomPBilan_Credit := 'SoldeReportCredit';

       AjouteCellule(NomPBilan_Debit,NomPBilan_Credit,cpt_a_repartir,Regime,Debit,Credit,Repartition);
        /////////////////////////////////////////////////////////////////////////

        // Traitement des soldes Fin

        NomPBilan_Debit := 'SoldeFinDebit';
        NomPBilan_Credit := 'SoldeFinCredit';
        Debit:=Balance.FindField('Solde_Debit_Total_Calc').AsCurrency;
        Credit:=Balance.FindField('Solde_Credit_Total_Calc').AsCurrency;

        AjouteCellule(NomPBilan_Debit,NomPBilan_Credit,cpt_a_repartir,Regime,Debit,Credit,Repartition);

        Balance.Next;
      end;

      // Traitement du resultat
    finally
        requeteReport.close;
        requeteReport.free;
    end;
  end;

Procedure SommeCellule(ParamLia:TDataSet;Ouverture:boolean);
var
ListeZoneTotaux,ListeZonePourSommeTotauxBilan:TStringList;
i,j,Index,k:integer;
Signe:string;
Chaine:String;
PositionChaine:Integer;
ChaineVariableDep,ChaineVariableFin,ChaineFixe1,ChaineFixe2:String;
InfoRepartTotal:TRepartition;
Begin
 if DMRepart = nil then DMRepart:=TDMRepart.Create(Application.MainForm);
 if DMRepart.ListeCell <> nil then
   begin
    if not ouverture then
      ListeZoneTotaux:=DM_C_ListeZoneTotauxBilan
    else
      ListeZoneTotaux:=DM_C_ListeZoneTotauxBilanOuverture;
    for  i:=0  to ListeZoneTotaux.Count -1 do
    begin
      InfoRepartTotal := TRepartition.Create;
      DMRepart.ListeCell.AddObject(ListeZoneTotaux.Strings[i],InfoRepartTotal);
    end;

    for  i:=0  to ListeZoneTotaux.Count -1 do
    begin
      // Ajout de la cellule de total
      // Récupération de la liste des zones à lire pour faire le total
      if not ouverture then
        ListeZonePourSommeTotauxBilan:=DM_C_ListeZonePourSommeTotauxBilan(ListeZoneTotaux.Strings[i])
      else
        ListeZonePourSommeTotauxBilan:=DM_C_ListeZonePourSommeTotauxBilanOuverture(ListeZoneTotaux.Strings[i]);
      // Pour chaque élément de la somme, on fait l'analyse syntaxique de la formule
      for j:=0 to ListeZonePourSommeTotauxBilan.Count - 1 do
       begin
       // Général : Chaque formule doit commencer par le signe de l'opération
       signe := str_n_prem_char(ListeZonePourSommeTotauxBilan.Strings[j],1);
       // 1° Cas : "+NomZone1:NomZone2", comme par exe : "+RN_A2_1_2:RN_A2_12_2"
       if Str_position(':',ListeZonePourSommeTotauxBilan.Strings[j]) > 0 then
        begin
         if Str_PositionVariable(ListeZonePourSommeTotauxBilan.Strings[j],PositionChaine,ChaineVariableDep,ChaineVariableFin,ChaineFixe1,ChaineFixe2) then
          begin
            for index := StrToInt(ChaineVariableDep) to StrToInt(ChaineVariableFin) do
             begin
             // On effectue ici le traitement de la liste des cellules
              k:=DMRepart.ListeCell.IndexOf(ChaineFixe1+IntToStr(Index)+ChaineFixe2);
              if k <>-1 then
              begin
                // Ajout de la cellule courante au Total de la cellule courante Total
                if signe = '+' then
                TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ListeZoneTotaux.Strings[i])]).MontantTotal :=
                TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ListeZoneTotaux.Strings[i])]).MontantTotal+
                TRepartition(DMRepart.ListeCell.Objects[k]).MontantTotal
//                TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ChaineFixe1+IntToStr(Index)+ChaineFixe2)]).MontantTotal +
                else
                TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ListeZoneTotaux.Strings[i])]).MontantTotal :=
                TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ListeZoneTotaux.Strings[i])]).MontantTotal -
                TRepartition(DMRepart.ListeCell.Objects[k]).MontantTotal;
//                TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ChaineFixe1+IntToStr(Index)+ChaineFixe2)]).MontantTotal -
//                TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ListeZoneTotaux.Strings[i])]).MontantTotal -
//                showmessage(currtostr(TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ChaineFixe1+IntToStr(Index)+ChaineFixe2)]).MontantTotal));
//                showmessage(ChaineFixe1+IntToStr(Index)+ChaineFixe2);
              end;
             end;
          end;
        end
        else
        // Dernier cas, c'est une zone simple, ex : "+RN_A2_1_2"
        begin
         Chaine := copy(ListeZonePourSommeTotauxBilan.Strings[j],2,length(ListeZonePourSommeTotauxBilan.Strings[j]));
         // On effectue ici le traitement de la liste des cellules
          k:=DMRepart.ListeCell.IndexOf(Chaine);
          if k <>-1 then
          begin
            // Ajout de la cellule courante au Total de la cellule courante Total
            if signe = '+' then
            TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ListeZoneTotaux.Strings[i])]).MontantTotal :=
            TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ListeZoneTotaux.Strings[i])]).MontantTotal+
            TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Chaine)]).MontantTotal
            else
            TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ListeZoneTotaux.Strings[i])]).MontantTotal :=
            TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ListeZoneTotaux.Strings[i])]).MontantTotal -
            TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Chaine)]).MontantTotal;
          end;

        end;

       end;
    end;

   end;
//
End;


Function VisuListeCompteDeZoneAffich(NomZone:String;ExercicePrecedent:Boolean):Boolean;
var
i,j:integer;
filtre:string;
Begin
 try
    Screen.Cursor := crSQLWait;
  if VisuListe = nil then VisuListe:=TVisuListe.Create(Application.MainForm);
  if DMRepart = nil then DMRepart:=TDMRepart.Create(Application.MainForm);
  i:=DMRepart.ListeCell.IndexOf(NomZone);
  DMRepart.ZoneCourante:= DMRepart.ListeCell.IndexOf(NomZone);
  DMRepart.QuBalanceCptPourZoneBilan.Close;
  DMRepart.QuBalanceCptPourZoneBilan.OnFilterRecord:=DMRepart.QuBalanceCptPourZoneBilanFilterRecord;
  DMRepart.QuBalanceCptPourZoneBilan.Filtered:=true;
  DMRepart.QuBalanceCptPourZoneBilan.Open;
  VisuListe.RxLabTitre.Caption:='Détails de la zone : '+NomZone;
  VisuListe.PaTitrePetit.Caption:='Listes des comptes de la zone de bilan : '+NomZone;
  VisuListe.BtnDetail.OnClick := DMRepart.BtnDetailClickVisuListe;
  VisuListe.GrDBVisu.OnDblClick := DMRepart.BtnDetailClickVisuListe;
  if Not ExercicePrecedent then
   begin
    VisuListe.DateDebut:=E.DatExoDebut;
    VisuListe.DateFin:=E.DatExoFin;
   end
  else
   begin
    VisuListe.DateDebut:=DateInfos(MoisOffset(E.DatExoDebut,-12).Date_).Date_;
    VisuListe.DateFin:=E.DatExoDebut-1;
   end;
  if i <> -1 then
   begin
//    filtre:=CreeFiltreOU('Compte',[TRepartition(DMRepart.ListeCell.Objects[i]).compte]);
//    FiltrageDataSet(DMRepart.QuBalanceCptPourZoneBilan,filtre);
    if ExercicePrecedent then
     begin
      GrDbGridInitColonne(VisuListe.GrDBVisu,DMRepart.DaBalanceCptPourZoneBilan,DMRepart.QuBalanceCptPourZoneBilan,
                         ['Compte','Libellé','Solde Report Debit','Solde Report Credit'],
                         ['Compte','Libelle','SoldeReportDebit','SoldeReportCredit']
                         ,E.FormatMonnaie,E.EditFormat);
     end
    else
     begin
      GrDbGridInitColonne(VisuListe.GrDBVisu,DMRepart.DaBalanceCptPourZoneBilan,DMRepart.QuBalanceCptPourZoneBilan,
                         ['Compte','Libellé','Solde Fin Debit','Solde Fin Credit'],
                         ['Compte','Libelle','SoldeFinDebit','SoldeFinCredit']
                         ,E.FormatMonnaie,E.EditFormat);
     end;
   end;
 Finally
//  DMRepart.ZoneCourante:=-1;
//  DMRepart.QuBalanceCptPourZoneBilan.OnFilterRecord:=nil;
  Screen.Cursor := crDefault;
 end;
VisuListe.Showmodal;
  DMRepart.QuBalanceCptPourZoneBilan.close;
  DMRepart.QuBalanceCptPourZoneBilan.OnFilterRecord:=nil;
  DMRepart.ZoneCourante:=-1;
VisuListe.BtnDetail.OnClick := nil;
VisuListe.GrDBVisu.OnDblClick := nil;
End;

Function MaJReportChargeEtProduit(DataSet:TDataSet):Boolean;
var
InfosPlanCpt:TInfosPlanCpt;
InfosBalance:TTotauxBalance;
ListeCompte:Tstringlist;
Begin
try//finally
try//except
result:=true;
  if DMRepart = nil then DMRepart:=TDMRepart.Create(Application.MainForm);
  if DMRepart.TaReport.Active then
   DMRepart.TaReport.Close;

if UpperCase((DataSet as TTable).Name) = UpperCase('TaPlanCptRech') then
  begin//si table plancpt
  if ((e.ID_Exo = 1) and (E.AccesOuverture =true)) then
      Begin//si acces ouverture et premier exercice
         if DataSet.ClassNameis('TTable') then
           begin //si TTable
//             if UpperCase((DataSet as TTable).Name) = UpperCase('TaPlanCptRech') then
//              begin//si table plancpt
               DMRepart.TaReport.EmptyTable;
               DMRepart.TaReport.Open;
               if DMRepart.TaReport.RecordCount > 0 then
                   Begin
                    MessageDlg('La table Report n''a pas été vidée correctement', mtError, [mbOK], 0);
                   End;
               FiltrageDataSet(DataSet,'Compte >=''6*''');
               (DataSet as TTable).Refresh;

               (DataSet as TTable).First;
               while not (DataSet as TTable).Eof do
                 begin//while
                  Remplit_TInfosplancpt(DataSet,Infosplancpt);
        //          if Infosplancpt.Compte = '60110' then showmessage('60110');
                  if ((true) and ( ((Infosplancpt.Debit_Deb <> 0) or (Infosplancpt.Credit_Deb <> 0)) )) then
                   begin //si
                    DMRepart.TaReport.Insert;
                    DMRepart.TaReport.FindField('Compte').AsString := Infosplancpt.Compte;
                    DMRepart.TaReport.FindField('Debit_Report').AsCurrency := Infosplancpt.Debit_Deb;
                    DMRepart.TaReport.FindField('Credit_Report').AsCurrency := Infosplancpt.Credit_Deb;
                    DMRepart.TaReport.FindField('Qt1_Report').AsCurrency := Infosplancpt.Qt1_Deb;
                    DMRepart.TaReport.FindField('Qt2_Report').AsCurrency := Infosplancpt.Qt2_Deb;
                    TableGerePost(DMRepart.TaReport);
                   end;
                  (DataSet as TTable).Next;
                 end;//fin du while
          end;//fin si TTable
      end;//fin si acces ouverture et premier exercice
  end//fin si table plancpt
  else
  if UpperCase((DataSet as TTable).Name) = UpperCase('TabalanceRech') then
    begin//si table balance
//    if ((e.ID_Exo <> 1) and (E.AccesOuverture =false)and (not Verif_Si_Ouverture_ExoN1(e.NomDossier,e.NomExo))) then
//      Begin//si exercice suivant ouverture et 1er cloturé
         if DataSet.ClassNameis('TTable') then
           begin //si TTable
//             if UpperCase((DataSet as TTable).Name) = UpperCase('TabalanceRech') then
//              begin//si table balance
               ListeCompte:=Tstringlist.create;
               if not DMBD.BrancheTableVersN1(DMRepart.TaReport) then
                abort;
               DMRepart.TaReport.Close;
               DMRepart.TaReport.EmptyTable;
               DMRepart.TaReport.Open;
               if DMRepart.TaReport.RecordCount > 0 then
                   Begin
                    MessageDlg('La table Report n''a pas été vidée correctement', mtError, [mbOK], 0);
                   End;
               FiltrageDataSet(DataSet,'Compte >=''6*''');
               (DataSet as TTable).Refresh;
               (DataSet as TTable).First;
               while not (DataSet as TTable).Eof do
                 begin//while
                  ListeCompte.Clear;
                  ListeCompte.Add((DataSet as TTable).findfield('compte').asstring) ;
                  InitialiseTotauxBalance(InfosBalance);
                  InfosBalance:=DMDiocEtatBal.SommeTotauxBalanceCalc(e.DatExoDebut,e.DatExoFin,ListeCompte,'Compte');
                  if ((true) and ( ((InfosBalance.TotalDebitFin <> 0) or (InfosBalance.TotalCreditFin <> 0)) )) then
                   begin //si
                    DMRepart.TaReport.Insert;
                    DMRepart.TaReport.FindField('Compte').AsString := (DataSet as TTable).findfield('compte').asstring;
                    DMRepart.TaReport.FindField('Debit_Report').AsCurrency := InfosBalance.TotalDebitFin;
                    DMRepart.TaReport.FindField('Credit_Report').AsCurrency := InfosBalance.TotalCreditFin;
                    DMRepart.TaReport.FindField('Qt1_Report').AsCurrency := InfosBalance.SoldeFinQt1;
                    DMRepart.TaReport.FindField('Qt2_Report').AsCurrency := InfosBalance.SoldeFinQt2;
                    TableGerePost(DMRepart.TaReport);
                   end;
                  (DataSet as TTable).Next;
                 end;//fin du while
          end;//fin si TTable
      //end;//fin si exercice suivant ouverture
    end;//fin si table balance
except
result:=false;
end;//fin du try except
finally
   DMBD.BrancheTableVersN(DMRepart.TaReport);
end;
End;

procedure TDMRepart.BtnDetailClickVisuListe(Sender: TObject);
begin
if VisuListe.GrDBVisu.DataSource <> nil then
 begin
  if VisuListe.GrDBVisu.DataSource = DMRepart.DaBalanceCptPourZoneBilan then
   begin
    E.AutrePeriode:=true;

    E.PeriodeAutre.DateDeb :=VisuListe.DateDebut;
    E.PeriodeAutre.DateFin :=VisuListe.DateFin;
    if VisuListe.GrDBVisu.DataSource.DataSet = DMRepart.TaBalanceCptPourZoneBilan then
     DetailEcritureCompte(DMRepart.TaBalanceCptPourZoneBilan.FindField('Compte').AsString,true,False);
    if VisuListe.GrDBVisu.DataSource.DataSet = DMRepart.QuBalanceCptPourZoneBilan then
     DetailEcritureCompte(DMRepart.QuBalanceCptPourZoneBilan.FindField('Compte').AsString,true,False);
   end;
 end;
end;

procedure TDMRepart.DMRepartCreate(Sender: TObject);
begin
ListeCell:=TStringList.Create;
ZoneCourante:=-1;
OuvrirTouteTable('',TControl(self));
end;

procedure TDMRepart.DMRepartDestroy(Sender: TObject);
begin
 DMRepart.ListeCell.Free;
 DMRepart := nil;
end;


procedure TDMRepart.TaBalanceCptPourZoneBilanCalcFields(DataSet: TDataSet);
var
TotauxBalance:TTotauxBalance;
begin
TotauxBalance:=DMDiocEtatBal.SommeTotauxBalanceParCompte(E.DatExoDebut,E.DatExoFin,TaBalanceCptPourZoneBilan.FindField('Compte').AsString);
TaBalanceCptPourZoneBilan.FindField('SoldeFinDebit').AsCurrency:=TotauxBalance.TotalSoldeDebitTotal;
TaBalanceCptPourZoneBilan.FindField('SoldeFinCredit').AsCurrency:=TotauxBalance.TotalSoldeCreditTotal;
end;

procedure TDMRepart.TaBalanceCptPourZoneBilanBeforeInsert(
  DataSet: TDataSet);
begin
abort;
end;

procedure TDMRepart.TaBalanceCptPourZoneBilanBeforeEdit(DataSet: TDataSet);
begin
abort;
end;

procedure TDMRepart.QuBalanceCptPourZoneBilanCalcFields(DataSet: TDataSet);
var
TotauxBalance:TTotauxBalance;
InfosReport:TInfosReport;
begin
  DataSet.FindField('SoldeFinDebit').AsCurrency:=0;
  DataSet.FindField('SoldeFinCredit').AsCurrency:=0;
  DataSet.FindField('SoldeReportDebit').AsCurrency:=0;
  DataSet.FindField('SoldeReportCredit').AsCurrency:=0;

  TotauxBalance:=DMDiocEtatBal.SommeTotauxBalanceParCompte(E.DatExoDebut,E.DatExoFin,DataSet.FindField('Compte').AsString);
  DataSet.FindField('SoldeFinDebit').AsCurrency:=TotauxBalance.TotalSoldeDebitTotal;
  DataSet.FindField('SoldeFinCredit').AsCurrency:=TotauxBalance.TotalSoldeCreditTotal;
  DataSet.FindField('SoldeReportDebit').AsCurrency:=TotauxBalance.TotalSoldeDebitReport;
  DataSet.FindField('SoldeReportCredit').AsCurrency:=TotauxBalance.TotalSoldeCreditReport;
  if ((copy(DataSet.FindField('Compte').AsString,1,1) ='6') or (copy(DataSet.FindField('Compte').AsString,1,1) ='7')) then
    begin
     InfosReport:=Infos_TInfosReport(DMRech.TaReportRech,'Compte',[DataSet.FindField('Compte').AsString]);
     if InfosReport.ResultInfos then
      begin
        DataSet.FindField('SoldeReportDebit').AsCurrency:=InfosReport.Debit_Report;
        DataSet.FindField('SoldeReportCredit').AsCurrency:=InfosReport.Credit_Report;
      end
     else
      begin
        DataSet.FindField('SoldeReportDebit').AsCurrency:=0;
        DataSet.FindField('SoldeReportCredit').AsCurrency:=0;
      end;
    end;
end;



Function AffichBilanOuvertureSurPeriode:Boolean;
var
 i:integer;
 Liste:TList;
 Compte,Designation:String;
 ParamAffichage:TParamAffichage;
 List1:TStringList;
 Requete : TQuery;
begin
  Try
    if DMRepart = nil then DMRepart:=TDMRepart.Create(Application.MainForm);
    Requete:=TQuery.Create(Application.MainForm);
    Requete.DatabaseName:=DMRech.TaBalanceRech.DatabaseName;
    Requete.SQL.Add(' select B.compte, P.libelle, B.Debit_Report,B.Credit_Report from balance B ');
    Requete.SQL.Add(' left join "'+e.RepertoireDossier+'Plancpt" P on (P.compte = B.compte) ');
    Requete.SQL.Add(' where B.compte < ''6'' and not(B.Debit_Report is null and B.Debit_Report=0 and B.Credit_Report is null and B.Credit_Report=0)');
    Requete.SQL.Add(' order by B.compte');
    Requete.Open;
    List1:=TStringList.Create;
    List1:=ChampTableVersListeEx(['Compte','Libelle','Debit_Report','Credit_Report'],Requete,';',true);
        for i:=0 to List1.Count-1 do
          begin
          list1.Strings[i]:=str_Setstringelement(list1.Strings[i],3,';',e.FormatCurrSansDevise(StrToCurr_Lgr(str_Getstringelement(list1.Strings[i],3,';'))));
          list1.Strings[i]:=str_Setstringelement(list1.Strings[i],4,';',e.FormatCurrSansDevise(StrToCurr_Lgr(str_Getstringelement(list1.Strings[i],4,';'))));
          end;

    Initialise_TParamAffichage(ParamAffichage);
    ParamAffichage.AffichModal := true;
    ParamAffichage.EventButtonDetailClick :=DMRepart.VisuList_DetailClick;
    ParamAffichage.EventButtonImprimerClick :=DMRepart.VisuList_ImprimerBalanceOuvertureClick;
    ParamAffichage.Titre:='Balance d''ouverture';
    ParamAffichage.TitrePetit:=ParamAffichage.Titre;
    ParamAffichage.GestionAffichForm.Caption := ParamAffichage.Titre;

    Initialise_Periode(e.PeriodeAutre);
    E.AutrePeriode:=True;
    E.PeriodeAutre.DateDeb := StrToDAte_lgr('01/01/1970');
    E.PeriodeAutre.DateFin := E.DatExoDebut-1;
    DMRepart.RetourViewListe:=AfficheVisuListView(ParamAffichage,['Compte','Libellé','Debit Report','Credit Report'],
                                       [150,300,150,150],
                                       [List1],
                                       [taLeftJustify,taLeftJustify,taRightJustify,taRightJustify],
                                       [1..2],
                                       [3..4],
                                       [0]);
  Finally
    E.AutrePeriode:=False;
    ParamAffichage.EventButtonDetailClick :=nil;
    DeFiltrageDataSet(DMPieces.TaPieceVisu);
    List1.Free;
    Requete.Close;
    Requete.Free;
  end;
//  Try
//    if DMRepart = nil then DMRepart:=TDMRepart.Create(Application.MainForm);
//    DeFiltrageDataSet(DMPlan.TaPlanBO);
//    FiltrageDataSet(DMPlan.TaPlanBO,'Compte < 6');
//    List1:=TStringList.Create;
//    List1:=ChampTableVersListeEx(['Compte','Libelle','Debit_Deb_Calc','Credit_Deb_Calc'],DMPlan.TaPlanBO,';',true);
//    Initialise_TParamAffichage(ParamAffichage);
//    ParamAffichage.AffichModal := true;
//    ParamAffichage.EventButtonDetailClick :=DMRepart.VisuList_DetailClick;
//    ParamAffichage.Titre:='Bilan d''ouverture';
//    ParamAffichage.TitrePetit:=ParamAffichage.Titre;
//    ParamAffichage.GestionAffichForm.Caption := ParamAffichage.Titre;
//
//    Initialise_Periode(e.PeriodeAutre);
//    E.AutrePeriode:=True;
//    E.PeriodeAutre.DateDeb := StrToDAte_lgr('01/01/1970');
//    E.PeriodeAutre.DateFin := E.DatExoDebut-1;
////    DMPieces.VisuPeriode:=e.PeriodeAutre;
//    DMRepart.RetourViewListe:=AfficheVisuListView(ParamAffichage,['Compte','Libellé','Debit Report','Credit Report'],
//                                       [100,100,100,100],
//                                       [List1],
//                                       [taLeftJustify,taLeftJustify,taRightJustify,taRightJustify],
//                                       [1..4],
//                                       [0],
//                                       [0]);
//  Finally
//    E.AutrePeriode:=False;
//    ParamAffichage.EventButtonDetailClick :=nil;
////    DeFiltrageDataSet(DMPlan.TaPlanBO);
//    List1.Free;
//  end;
End;


Procedure TDMRepart.VisuList_DetailClick(Sender : TObject);
var
listeRetour:Tstringlist;
Begin
try
listeRetour:=VisuListeView.ItemCourantValeurRow;
if (listeRetour=nil)or(VisuListeView.ItemCourantValeurRow.count<2) then exit;
if DetailEcritureCompte(listeRetour.Strings[0],False,false) then
 case DetailEcr.Tag of
    1:begin
      if DMEcritures.QueryEcrCompte.Locate('ID_Piece',DMPieces.TaPieceVisu.findfield('ID').AsInteger,[]) then
        PieceEcritureTiers;
      end;
    2:begin
      if DMEcritures.QueryEcrCompte.Locate('ID_Piece',DMPieces.TaPieceVisu.findfield('ID').AsInteger,[]) then
        PieceEcritureCompte;
      end;
 end;//fin du case
Finally

end;
End;


Procedure TDMRepart.VisuList_ImprimerBalanceOuvertureClick(Sender : TObject);
Begin
EditionBalanceOuvertureL(nil,nil);
End;

Procedure TDMRepart.VisuList_ImprimerChargesEtProduitsOuvertureClick(Sender : TObject);
Begin
if ListeEdition<>nil then
   EditionChargesEtProduitsOuvertureL(ListeEdition);
End;

Function AffichChargesEtProduitOuvertureSurPeriode:Boolean;
var
 i:integer;
 Liste:TList;
 Compte,Designation:String;
 ParamAffichage:TParamAffichage;
 List1:TStringList;
begin
  Try
    if DMRepart = nil then DMRepart:=TDMRepart.Create(Application.MainForm);
    if ListeEdition=nil then ListeEdition:=TStringList.Create;
    FiltrageDataSet(DMRepart.TaReport,'Compte >= 6');
    List1:=TStringList.Create;
    List1:=ChampTableVersListeEx(['Compte','Libelle','Debit_Report','Credit_Report'],DMRepart.TaReport,';',true);
        for i:=0 to List1.Count-1 do
          begin
          list1.Strings[i]:=str_Setstringelement(list1.Strings[i],3,';',e.FormatCurrSansDevise(StrToCurr_Lgr(str_Getstringelement(list1.Strings[i],3,';'))));
          list1.Strings[i]:=str_Setstringelement(list1.Strings[i],4,';',e.FormatCurrSansDevise(StrToCurr_Lgr(str_Getstringelement(list1.Strings[i],4,';'))));
          end;
    Initialise_TParamAffichage(ParamAffichage);
    ParamAffichage.AffichModal := true;
    ParamAffichage.EventButtonDetailClick :=DMRepart.VisuList_DetailClick;
    ParamAffichage.EventButtonImprimerClick :=DMRepart.VisuList_ImprimerChargesEtProduitsOuvertureClick;    
    ParamAffichage.Titre:='Charges et produits N-1';
    ParamAffichage.TitrePetit:=ParamAffichage.Titre;
    ParamAffichage.GestionAffichForm.Caption := ParamAffichage.Titre;
    ListeEdition.Assign(list1);
    Initialise_Periode(e.PeriodeAutre);
    E.AutrePeriode:=True;
    E.PeriodeAutre.DateDeb := StrToDAte_lgr('01/01/1970');
    E.PeriodeAutre.DateFin := E.DatExoDebut-1;
    DMRepart.RetourViewListe:=AfficheVisuListView(ParamAffichage,['Compte','Libellé','Debit Report','Credit Report'],
                                       [150,300,150,150],
                                       [List1],
                                       [taLeftJustify,taLeftJustify,taRightJustify,taRightJustify],
                                       [1..4],
                                       [0],
                                       [0]);
  Finally
    E.AutrePeriode:=False;
    ParamAffichage.EventButtonDetailClick :=nil;
    DeFiltrageDataSet(DMPieces.TaPieceVisu);
    List1.Free;
  end;
End;


////////******** Traitement du Bic **********///////////////
///////////////////////////////////////////////////////////
Procedure SommeCellule_Bic(ParamLia_Bic:TDataSet;Ouverture:boolean);
var
ListeZoneTotaux,ListeZonePourSommeTotauxBilan:TStringList;
i,j,Index,k:integer;
Signe:string;
Chaine:String;
PositionChaine:Integer;
ChaineVariableDep,ChaineVariableFin,ChaineFixe1,ChaineFixe2:String;
InfoRepartTotal:TRepartition;
Begin
 if DMRepart = nil then DMRepart:=TDMRepart.Create(Application.MainForm);
 if DMRepart.ListeCell <> nil then
   begin
    if not ouverture then
      ListeZoneTotaux:=DM_C_ListeZoneTotauxBilan_Bic
    else
      ListeZoneTotaux:=DM_C_ListeZoneTotauxBilanOuverture_Bic;
    for  i:=0  to ListeZoneTotaux.Count -1 do
    begin
      InfoRepartTotal := TRepartition.Create;
      DMRepart.ListeCell.AddObject(ListeZoneTotaux.Strings[i],InfoRepartTotal);
    end;

    for  i:=0  to ListeZoneTotaux.Count -1 do
    begin
      // Ajout de la cellule de total
//      if ListeZoneTotaux.Strings[i] = 'RN_ZCL_8' then  //abort;
//      showmessage('RN_ZCL_8');

      // Récupération de la liste des zones à lire pour faire le total
      if not ouverture then
        ListeZonePourSommeTotauxBilan:=DM_C_ListeZonePourSommeTotauxBilan_Bic(ListeZoneTotaux.Strings[i])
      else
        ListeZonePourSommeTotauxBilan:=DM_C_ListeZonePourSommeTotauxBilanOuverture_Bic(ListeZoneTotaux.Strings[i]);
      // Pour chaque élément de la somme, on fait l'analyse syntaxique de la formule
      for j:=0 to ListeZonePourSommeTotauxBilan.Count - 1 do
       begin
       // Général : Chaque formule doit commencer par le signe de l'opération
       signe := str_n_prem_char(ListeZonePourSommeTotauxBilan.Strings[j],1);
       // 1° Cas : "+NomZone1:NomZone2", comme par exe : "+RN_A2_1_2:RN_A2_12_2"
       if Str_position(':',ListeZonePourSommeTotauxBilan.Strings[j]) > 0 then
        begin
         if Str_PositionVariable(ListeZonePourSommeTotauxBilan.Strings[j],PositionChaine,ChaineVariableDep,ChaineVariableFin,ChaineFixe1,ChaineFixe2) then
          begin
            for index := StrToInt(ChaineVariableDep) to StrToInt(ChaineVariableFin) do
             begin
             // On effectue ici le traitement de la liste des cellules
              k:=DMRepart.ListeCell.IndexOf(ChaineFixe1+IntToStr(Index)+ChaineFixe2);
              if k <>-1 then
              begin
                // Ajout de la cellule courante au Total de la cellule courante Total
                if signe = '+' then
                TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ListeZoneTotaux.Strings[i])]).MontantTotal :=
                TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ListeZoneTotaux.Strings[i])]).MontantTotal+
                TRepartition(DMRepart.ListeCell.Objects[k]).MontantTotal
//                TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ChaineFixe1+IntToStr(Index)+ChaineFixe2)]).MontantTotal +
                else
                TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ListeZoneTotaux.Strings[i])]).MontantTotal :=
                TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ListeZoneTotaux.Strings[i])]).MontantTotal -
                TRepartition(DMRepart.ListeCell.Objects[k]).MontantTotal;
//                TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ChaineFixe1+IntToStr(Index)+ChaineFixe2)]).MontantTotal -
//                TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ListeZoneTotaux.Strings[i])]).MontantTotal -
//                showmessage(currtostr(TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ChaineFixe1+IntToStr(Index)+ChaineFixe2)]).MontantTotal));
//                showmessage(ChaineFixe1+IntToStr(Index)+ChaineFixe2);
              end;
             end;
          end;
        end
        else
        // Dernier cas, c'est une zone simple, ex : "+RN_A2_1_2"
        begin
         Chaine := copy(ListeZonePourSommeTotauxBilan.Strings[j],2,length(ListeZonePourSommeTotauxBilan.Strings[j]));
         // On effectue ici le traitement de la liste des cellules
          k:=DMRepart.ListeCell.IndexOf(Chaine);
          if k <>-1 then
          begin
            // Ajout de la cellule courante au Total de la cellule courante Total
            if signe = '+' then
            TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ListeZoneTotaux.Strings[i])]).MontantTotal :=
            TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ListeZoneTotaux.Strings[i])]).MontantTotal+
            TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Chaine)]).MontantTotal
            else
            TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ListeZoneTotaux.Strings[i])]).MontantTotal :=
            TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(ListeZoneTotaux.Strings[i])]).MontantTotal -
            TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Chaine)]).MontantTotal;
          end;

        end;

       end;
    end;

   end;
//
End;




procedure TDMRepart.QuBalanceCptPourZoneBilanFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
begin
if ZoneCourante<>-1 then
  Accept:=TRepartition(DMRepart.ListeCell.Objects[ZoneCourante]).compte.IndexOf(DataSet.findfield('Compte').AsString)<>-1
end;

end.
