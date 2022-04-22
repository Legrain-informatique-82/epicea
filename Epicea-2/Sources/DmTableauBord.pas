unit DmTableauBord;

interface

uses
  SysUtils, Classes, xmldom, XMLIntf,Dialogs, msxmldom, XMLDoc,ITableauDeBord2, XMLBrokr, E2_Decl_Records,Variants,
  Menus,Forms,DiversProjets, E2_ParamEnt, E2_Librairie_Obj, DMRecherche,
  E2_LibInfosTable, LibSQL, LibDates, DateUtils, DMDiocEtatBalance,
  DMEcriture, ChoixPeriode,DBTables,Controls;

type

  TCompte3Annee=class(TObject)
    compte:string;
    mois:string;
    periode:string;
    rang:integer;
    dateDeb:TDateTime;
    dateFin:TDateTime;
    SoldeExoN:currency;
    SoldeExoNMoins1:currency;
    SoldeExoNMoins2:currency;
    constructor Create;
    destructor Destroy;
  end;

  TChargesProduits=class(TObject)
    compte:string;
    charges:currency;
    produits:currency;
    periode:string;
    dateDeb:TDateTime;
    dateFin:TDateTime;
    ordre:integer;
    constructor Create;
    destructor Destroy;
  end;
  TDmTableauDeBord = class(TDataModule)
    XMLTableauDeBord1: TXMLDocument;

  private
    { Déclarations privées }
  public
    { Déclarations publiques }

    interfaceTableaudebord:IXMLTableauDeBordType;
     XMLTableauDeBord:Txmldocument;
    function rempliXML_Tresorerie(ListeCpt:TStringList; Regrouper : integer):boolean;
    function InitialiseXML(nomFichier:string):boolean;
    function SauveXML(nomFichier:string):boolean;
    function rempliXML_DettesEtCreances(ListeCpt:TStringList; Regrouper : integer):boolean;
    function rempliXML_ChargesProduitsResultat(ListeCpt:TStringList ; Regrouper : integer):boolean;
    function rempliXML_TresorerieMensuelle2(ListeCpt:TStringList;Regrouper : integer):boolean;
    function rempliXML_TresorerieMensuelle(ListeCpt:TStringList;Regrouper : integer):boolean;
  end;

var
  DmTableauDeBord: TDmTableauDeBord;
  function TriListeChargesProduits(LaListe: TStringList; Index1, Index2: Integer): Integer;
  function TriListeDettesEtCreances(LaListe: TStringList; Index1, Index2: Integer): Integer;
  function TriListe(LaListe: TStringList; Index1, Index2: Integer): Integer;
  function TriListeCompte(LaListe: TStringList; Index1, Index2: Integer): Integer;
implementation

uses DMPlanCpt, DMRapprochementBancaire, lib_chaine, DMConstantes,
  DMProgramme, DMPointages2, DB, Gr_Librairie_Obj, E2_Patientez,
  TStringlistLGR, Math;

//uses
//DiversProjets, E2_ParamEnt, E2_Librairie_Obj, DMRecherche,
//  E2_LibInfosTable, LibSQL, LibDates, DateUtils, DMDiocEtatBalance,
//  DMEcriture, ChoixPeriode;



{$R *.dfm}
function TDmTableauDeBord.InitialiseXML(nomFichier:string):boolean;
var
  TexteNewFichierUtil:string;
    InfosParam_Dossier:TInfosParam_Dossier;

begin
//nomFichier:='tableauDeBord.xml';
//   XMLTableauDeBord:=nil;
   XMLTableauDeBord:=TXMLDocument.Create(nil);
//   interfaceTableaudebord:=NewtableauDeBord;
   XMLTableauDeBord.FileName:=nomFichier;
   if(FileExists(nomFichier))then DeleteFile(nomFichier);
   TexteNewFichierUtil :='<?xml version="1.0" encoding="utf-8"?>'+'<tableauDeBord>'+'</tableauDeBord>';
   AjouterFichierTexte(nomFichier,TexteNewFichierUtil);
  XMLTableauDeBord.FileName:=nomFichier;
   XMLTableauDeBord.LoadFromFile(nomFichier);
   XMLTableauDeBord.Active:=true;
   //XMLTableauDeBord.LoadFromFile(nomFichier);
   //XMLTableauDeBord.Active := True;
   interfaceTableaudebord:=GettableauDeBord(XMLTableauDeBord);
   DeFiltrageDataSet(DMRech.TaParam_DossierRech);
   DMRech.TaParam_DossierRech.Open;

   interfaceTableaudebord.Dossier;
   interfaceTableaudebord.Dossier.Codedossier:=pchar(e.NomDossier);
   interfaceTableaudebord.Dossier.Codeexercice:=e.ExerciceSaisie;
   interfaceTableaudebord.Dossier.Nom_Exercice:=pchar(e.NomExo);
   interfaceTableaudebord.Dossier.Raison_sociale:=pchar(e.RaisonSociale);
   interfaceTableaudebord.Dossier.Debutn:=e.DatExoDebut;
   interfaceTableaudebord.Dossier.Finn:=e.DatExoFin;
   interfaceTableaudebord.Dossier.Finn1:=e.DatExoDebut-1;
   interfaceTableaudebord.Dossier.Finn2:=IncYear(e.DatExoDebut-1,1);
   Initialise_TInfosParam_Dossier(InfosParam_Dossier);
   Remplit_TInfosParam_Dossier(dmrech.TaParam_DossierRech,InfosParam_Dossier);
   interfaceTableaudebord.Dossier.Adresse1:=pchar(InfosParam_Dossier.Adr1);
   interfaceTableaudebord.Dossier.Adresse2:=pchar(InfosParam_Dossier.Adr2);
   interfaceTableaudebord.Dossier.Cp:=pchar(InfosParam_Dossier.CP);
   interfaceTableaudebord.Dossier.Ville:=pchar(InfosParam_Dossier.VILLE);

   interfaceTableaudebord.Pages.Clear;
end;

function TDmTableauDeBord.SauveXML(nomFichier:string):boolean;
begin
interfaceTableaudebord.OwnerDocument.SaveToFile(nomFichier);
interfaceTableaudebord.OwnerDocument.active:=false;
// XMLTableauDeBord.SaveToFile(nomFichier);
// XMLTableauDeBord.Active:=false;
 XMLTableauDeBord.Active:=false;

end;

function TDmTableauDeBord.rempliXML_DettesEtCreances(ListeCpt:TStringList; Regrouper : integer):boolean;
var
retour,listeTmp:TStringList;
i,j:integer;
LigneType:IXMLLigneType;
pagesType:IXMLPageType;
DettesEtCreances:TDettesEtCreances;
listeParCompte1,listeParCompte2,ListeParDate1,ListeParAnnee,
listeDettes,listeCreances,listeExo,Liste3Derniers:Tstringlist;
CompteRegroupeCreances,CompteRegroupeDettes:string;
Compte3AnneeDettes,Compte3AnneeCreances,Compte3Annee:TCompte3Annee;
exerciceCourant:TExercice;
trouve:boolean;
begin
try
listeTmp:=Tstringlist.create;
listeParCompte1:=Tstringlist.create;
listeParCompte2:=Tstringlist.create;
ListeParDate1:=Tstringlist.create;
ListeParAnnee:=Tstringlist.create;
listeDettes:=Tstringlist.create;
listeCreances:=Tstringlist.create;
Liste3Derniers:=Tstringlist.create;
listeExo:=Tstringlist.create;

for i:=0 to ListeCpt.Count-1 do
begin
  listeTmp.Add(ListeCpt.Strings[i]);
end;


   //récupérer tous les exercices pour travailler dessus
    listeExo:=listeExercice(e.ID_Dos,false);

     pagesType:=interfaceTableaudebord.Pages.Add();
   retour:=listeDettesEtCreancesSurPeriode(true,listeTmp,true,nil,'',1,Regrouper);
//    i:=listeExo.IndexOf(e.NomExo);
//    if(i<>-1)then exerciceCourant:=TExercice(listeExo.Objects[i]);
//    retour:=TableauEvolutionAnnuelleDetteCreance(ListeCpt,true,nil,'',Regrouper,exerciceCourant,Liste3Derniers.IndexOf(listeExo.Strings[i]));

   listeParCompte1:=TStringList(retour.Objects[0]);
   ListeParDate1:=TStringList(retour.Objects[1]);


   
   for i:=0 to listeParCompte1.Count-1 do
    begin
       DettesEtCreances:=TDettesEtCreances(listeParCompte1.Objects[i]);
       if(DettesEtCreances.Dettes<>0)then
       begin
           LigneType:= pagesType.Dettesetcreances.Dettes.Add();
           LigneType.compte:=DettesEtCreances.compte;
           LigneType.Libell:=DettesEtCreances.libelle;
           LigneType.Total:=DettesEtCreances.Dettes;
           LigneType.Echance:=DettesEtCreances.DettesEcheance;
       end;
       if(DettesEtCreances.Creances<>0)then
       begin
           LigneType:= pagesType.Dettesetcreances.Creances.Add();
           LigneType.compte:=DettesEtCreances.compte;
           LigneType.Libell:=DettesEtCreances.libelle;
           LigneType.Total:=DettesEtCreances.Creances;
           LigneType.Echance:=DettesEtCreances.CreancesEcheance;
       end;
//    DettesEtCreances.free;
//    DettesEtCreances:=nil;
    end;
    Initialise_TStringlist(listeParCompte1,nil,false);

  ListeParDate1:=TableauEvolutionMensuelleDetteCreance(false,ListeParDate1);
 for i:=0 to ListeParDate1.Count-1 do
    begin
       DettesEtCreances:=TDettesEtCreances(ListeParDate1.Objects[i]);
       LigneType:= pagesType.Dettesetcreances.Courbesdettesmensuelle.Add();
       LigneType.Mois :=DettesEtCreances.Exo;
       LigneType.Dettes:=DettesEtCreances.Dettes;
       LigneType.Creances:=DettesEtCreances.Creances;
//       DettesEtCreances.Free;
//       DettesEtCreances:=nil;
    end;

   //Initialise_TStringlist(ListeParDate1,nil,false);
   Initialise_TStringlist(retour,nil,false);

    //récupérer les 3 derniers exercices pour travailler dessus
    for i:=0 to listeExo.count-1 do
    begin
       if(listeExo.Strings[i]=e.NomExo)then
         begin
             Liste3Derniers.AddObject(listeExo.Strings[i],listeExo.Objects[i]);
             if(i>0)then Liste3Derniers.AddObject(listeExo.Strings[i-1],listeExo.Objects[i-1]);;
             if(i>1)then Liste3Derniers.AddObject(listeExo.Strings[i-2],listeExo.Objects[i-2]);;
         end;
    end;
  i:=0;
  trouve:=false;
  while (not trouve)and (i<listeExo.count)do
  //for i:=0 to listeExo.count-1 do
  begin
     retour:=TableauEvolutionAnnuelleDetteCreance(ListeCpt,true,nil,'',Regrouper,TExercice(listeExo.Objects[i]),Liste3Derniers.IndexOf(listeExo.Strings[i]));
     for j:=0 to TStringList(retour.Objects[0]).count-1 do
        listeParCompte2.AddObject(TStringList(retour.Objects[0]).Strings[j] ,TStringList(retour.Objects[0]).Objects[j]);
     for j:=0 to TStringList(retour.Objects[1]).count-1 do
        ListeParAnnee.AddObject(TStringList(retour.Objects[1]).Strings[j],TStringList(retour.Objects[1]).Objects[j]);
     Initialise_TStringlist(retour,nil,false);
     trouve:=TExercice(listeExo.Objects[i]).nom_exo=e.NomExo;
     inc(i);
  end;
  Initialise_TStringlist(listeExo,nil,false);


 for i:=0 to ListeParAnnee.Count-1 do
    begin
       DettesEtCreances:=TDettesEtCreances(ListeParAnnee.Objects[i]);
       LigneType:= pagesType.Dettesetcreances.Courbesdettesannuelle.Add();
       LigneType.Exo :=DettesEtCreances.Exo;
       LigneType.Dettes:=DettesEtCreances.Dettes;
       LigneType.Crances:=DettesEtCreances.Creances;
//       DettesEtCreances.free;
//       DettesEtCreances:=nil;
    end;

listeParCompte2.CustomSort(TriListeDettesEtCreances);

CompteRegroupeDettes:='';
CompteRegroupeCreances:='';
if(listeParCompte2.Count>0)then
begin
   DettesEtCreances:=TDettesEtCreances(listeParCompte2.Objects[0]);
   if(DettesEtCreances.dettes<>0)then  CompteRegroupeDettes:=DettesEtCreances.compte;
   if(DettesEtCreances.Creances<>0)then  CompteRegroupeCreances:=DettesEtCreances.compte;
//   DettesEtCreances.free;
//   DettesEtCreances:=nil;
end;
    for i:=0 to  listeParCompte2.Count-1 do
    begin
       DettesEtCreances:=TDettesEtCreances(listeParCompte2.Objects[i]);
       if(DettesEtCreances.dettes<>0)then
         begin
             if(CompteRegroupeDettes<>DettesEtCreances.compte)or(Compte3AnneeDettes=nil)then
                begin
                  Compte3AnneeDettes:=TCompte3Annee.Create;
                  listeDettes.AddObject(DettesEtCreances.compte,Compte3AnneeDettes);
                end;
              CompteRegroupeDettes:=DettesEtCreances.compte;
                  Compte3AnneeDettes.compte:=CompteRegroupeDettes;
              case DettesEtCreances.ordre of
                 2:Compte3AnneeDettes.SoldeExoNMoins2:=DettesEtCreances.Dettes;
                 1:Compte3AnneeDettes.SoldeExoNMoins1:=DettesEtCreances.Dettes;
                 0:Compte3AnneeDettes.SoldeExoN:=DettesEtCreances.Dettes;
              end;
        end;
       if(DettesEtCreances.Creances<>0)then
         begin
             if(CompteRegroupeCreances <>DettesEtCreances.compte)or(Compte3AnneeCreances=nil)then
                begin
                  Compte3AnneeCreances:=TCompte3Annee.Create;
                  listeCreances.AddObject(DettesEtCreances.compte,Compte3AnneeCreances);
                end;
              CompteRegroupeCreances:=DettesEtCreances.compte;
                  Compte3AnneeCreances.compte:=CompteRegroupeCreances;
              case DettesEtCreances.ordre of
                 2:Compte3AnneeCreances.SoldeExoNMoins2:=DettesEtCreances.Creances;
                 1:Compte3AnneeCreances.SoldeExoNMoins1:=DettesEtCreances.Creances;
                 0:Compte3AnneeCreances.SoldeExoN:=DettesEtCreances.Creances;
              end;
        end;
//    DettesEtCreances.free;
//    DettesEtCreances:=nil;
    end;
    Initialise_TStringlist(listeParCompte2,nil,false);

for i:=0 to listeDettes.Count-1 do
begin
  Compte3Annee:=TCompte3Annee(listeDettes.Objects[i]);
  LigneType:= pagesType.RepartitionDettes.Add;
  LigneType.compte:=Compte3Annee.compte;
  LigneType.ExoN:=Compte3Annee.SoldeExoN;
  LigneType.ExoN1:=Compte3Annee.SoldeExoNMoins1;
  LigneType.ExoN2:=Compte3Annee.SoldeExoNMoins2;
//  Compte3Annee.Free;
//  Compte3Annee:=nil;
end;

for i:=0 to listeCreances.Count-1 do
begin
  Compte3Annee:=TCompte3Annee(listeCreances.Objects[i]);
  LigneType:= pagesType.RepartitionCreances.Add;
  LigneType.compte:=Compte3Annee.compte;
  LigneType.ExoN:=Compte3Annee.SoldeExoN;
  LigneType.ExoN1:=Compte3Annee.SoldeExoNMoins1;
  LigneType.ExoN2:=Compte3Annee.SoldeExoNMoins2;
//  Compte3Annee.Free;
//  Compte3Annee:=nil;
end;

//listeDettes.Clear;
//listeCreances.clear;
finally
    Initialise_TStringlist(listeTmp);
    Initialise_TStringlist(listeParCompte1);
    Initialise_TStringlist(listeParCompte2);
    Initialise_TStringlist(ListeParDate1);
    Initialise_TStringlist(ListeDettes);
    Initialise_TStringlist(listeCreances);
    Initialise_TStringlist(ListeParAnnee);
    Initialise_TStringlist(Liste3Derniers);
    Initialise_TStringlist(listeExo);
    Initialise_TStringlist(retour);
end;
end;


function TDmTableauDeBord.rempliXML_Tresorerie(ListeCpt:TStringList; Regrouper : integer):boolean;
var
  debit,credit:currency;
  LigneType:IXMLLigneType;
  pagesType:IXMLPageType;
  ParamAffichPeriode:TParamAffichPeriode;
  periode:TPeriode;
  EtatFiltre:TEtatFiltre;
  TotauxRappBanc:TTotauxRappBanc;
  TotauxCompte:TTotauxBalance;
  i:integer;
  compte:string;
  TotalDebitAutre,TotalCreditAutre:currency;
  TotalReleveDebitAutre,TotalReleveCreditAutre:currency;
  listeEx0,Liste3Derniers,ListeTotaux:Tstringlist;
  RequeteBalance,RequeteEcriture:TQuery;
  Compte3Annee:TCompte3Annee;
  moisCourant,moisFinExo:integer;

begin
try//finally
PatienterAffich();
   pagesType:=interfaceTableaudebord.Pages.Add();
   RequeteBalance:=TQuery.Create(application.MainForm);
   RequeteEcriture:=TQuery.Create(application.MainForm);
   Initialise_ParamAffichPeriode(ParamAffichPeriode);
   ParamAffichPeriode.DateDansExercice:=true;
   periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
   Liste3Derniers:=TStringList.create;
   ListeTotaux:=TStringList.create;
     for i:=0 to ListeCpt.Count-1 do
     begin
       compte:=ListeCpt.Strings[i];
       TotauxRappBanc:=CalculTotauxRappBanc(Compte,C_CalculerSoldeReleveBanque,periode.DateDeb,periode.DateFin);
       TotauxCompte:= DMDiocEtatBal.SommeTotauxBalanceParCompte(periode.DateDeb,periode.DateFin,compte);
       if(TotauxCompte.SoldeDebitCreditFin=false) then TotauxCompte.SoldeFin:=TotauxCompte.SoldeFin*-1;
      // if(str_commence_par(compte,'512'))or(str_commence_par(compte,'530'))then
          begin
             LigneType:= pagesType.Tresorerie.Soldecomptes.Add();
             LigneType.Comptes:=compte;
             LigneType.Libell:=DMPlan.LibelleDuNumCptPCU(compte);

             LigneType.Balance:=TotauxCompte.SoldeFin;
             debit:=TotauxRappBanc.SoldeReleveBanqueDebit;
             credit:=TotauxRappBanc.SoldeReleveBanqueCredit;
             debit:= DetermineSoldeValeurReelle(debit,credit);
             LigneType.Rapprochement:=debit;
          end
//       else
//         begin
//            TotalDebitAutre:=TotalDebitAutre+TotauxCompte.SoldeFin;
//            //TotalCreditAutre:=TotalCreditAutre+TotauxRappBanc.SoldeCompteCredit;
//            TotalReleveDebitAutre:=TotalReleveDebitAutre+TotauxRappBanc.SoldeReleveBanqueDebit;
//            TotalReleveCreditAutre:=TotalReleveCreditAutre+TotauxRappBanc.SoldeReleveBanqueCredit;
//         end;
     end;
     //TotalDebitAutre:=DetermineSolde(TotalDebitAutre,TotalCreditAutre);
     TotalReleveDebitAutre:=DetermineSoldeValeurReelle(TotalReleveDebitAutre,TotalReleveCreditAutre);
     if(TotalDebitAutre<>0)or(TotalReleveDebitAutre<>0)then
        begin
             LigneType:= pagesType.Tresorerie.Soldecomptes.Add();
             LigneType.Comptes:='5';
             LigneType.Libell:=DMPlan.LibelleDuNumCptPCU('5');
             LigneType.Balance:=TotalDebitAutre;
             LigneType.Rapprochement:=TotalReleveDebitAutre;
       end;

    //récupérer les différents 3 derniers exercices pour travailler dessus
    listeEx0:=listeExercice(e.ID_Dos,false);
    for i:=0 to listeEx0.count-1 do
    begin

       if(listeEx0.Strings[i]=e.NomExo)then
         begin
             Liste3Derniers.AddObject(listeEx0.Strings[i],listeEx0.Objects[i]);
             if(i>0)then Liste3Derniers.AddObject(listeEx0.Strings[i-1],listeEx0.Objects[i-1]);;
             if(i>1)then Liste3Derniers.AddObject(listeEx0.Strings[i-2],listeEx0.Objects[i-2]);;
         end;
    end;
    DMDiocEtatBal.ListeFiltreEdit.Assign(ListeCpt);
    //Pour chaque exercice, récupérer les totaux de la balance pour chaque compte
    //de la liste
    for i:=0 to Liste3Derniers.count-1 do
    begin
         RequeteBalance.close;
         RequeteBalance.SQL.Clear;
         RequeteBalance.Filtered := true;
         RequeteBalance.OnFilterRecord:=DMDiocEtatBal.TaBalanceCalcFilterRecord;
         RequeteBalance.DatabaseName:=DM_C_NomAliasDossier;

         RequeteBalance.SQL.Add('select p.libelle,P.compte, (b.Debit_Report),(b.Credit_Report) ');
         RequeteBalance.SQL.Add(' from plancpt P');
         RequeteBalance.SQL.Add(' full join  "'+IncludeTrailingPathDelimiter(TExercice(Liste3Derniers.Objects[i]).dir_exo)+'balance" b on p.compte=b.compte');
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
         RequeteEcriture.ParamByName('DateDeb').AsDate:=TExercice(Liste3Derniers.Objects[i]).Date_Deb_Exo;
         RequeteEcriture.ParamByName('DateFin').AsDate:=TExercice(Liste3Derniers.Objects[i]).Date_Fin_Exo;
         RequeteEcriture.Open;
         RequeteEcriture.First;
      if RequeteBalance.recordcount<> 0 then
         begin
              compte :='';
          while not RequeteBalance.Eof do
           begin
           compte :=RequeteBalance.FindField('Compte').AsString;
              if(ListeTotaux.IndexOf(compte)<>-1)then Compte3Annee:=TCompte3Annee(ListeTotaux.Objects[ListeTotaux.IndexOf(compte)])
                else
                  begin
                    if(compte='')then compte :=RequeteBalance.FindField('Compte').AsString;
                    Compte3Annee:=TCompte3Annee.Create;
                    Compte3Annee.compte:=compte;
                    ListeTotaux.AddObject(compte,Compte3Annee);
                  end;
              InitialiseTotauxBalance(TotauxCompte);

              FiltrageDataSet(RequeteEcriture,CreeFiltreOU('compte',[compte]));
              TotauxCompte.TotalDebitReport := RequeteBalance.FindField('Debit_Report').AsCurrency ;
              TotauxCompte.TotalCreditReport := RequeteBalance.FindField('Credit_Report').AsCurrency ;
              if(RequeteEcriture.RecordCount<>0)then
              begin
                TotauxCompte.TotalDebitBase:=RequeteEcriture.FindField('TotDebit').AsCurrency;
                TotauxCompte.TotalCreditBase:=RequeteEcriture.FindField('TotCredit').AsCurrency;;
              end;
              TotauxCompte.TotalDebitFin:=TotauxCompte.TotalDebitReport+TotauxCompte.TotalDebitBase;
              TotauxCompte.TotalCreditFin:=TotauxCompte.TotalCreditReport+TotauxCompte.TotalCreditBase;
              TotauxCompte.SoldeFin:=DetermineSoldeValeurReelle(TotauxCompte.TotalDebitFin,TotauxCompte.TotalCreditFin);
              case i of
                 0: begin
                      Compte3Annee.SoldeExoN:=TotauxCompte.SoldeFin;
                    end;
                 1: begin
                       Compte3Annee.SoldeExoNMoins1:= TotauxCompte.SoldeFin;
//                       Compte3Annee.SoldeExoN:=TotauxCompte.SoldeFin;
                    end;
                 2: begin
                       Compte3Annee.SoldeExoNMoins2:= TotauxCompte.SoldeFin;
//                       Compte3Annee.SoldeExoNMoins1:= Compte3Annee.SoldeExoN;
//                       Compte3Annee.SoldeExoN:=TotauxCompte.SoldeFin;
                    end;
              end;
           RequeteBalance.next;
           end;
         end;

    end;
    for i:=0 to  ListeTotaux.Count-1 do
    begin
        LigneType:= pagesType.Tresorerie.Courbesevolutiontresorerie.Add();
        LigneType.compte:=TCompte3Annee(ListeTotaux.Objects[i]).compte;
        LigneType.ExoN:=TCompte3Annee(ListeTotaux.Objects[i]).SoldeExoN;
        LigneType.ExoN1:=TCompte3Annee(ListeTotaux.Objects[i]).SoldeExoNMoins1;
        LigneType.ExoN2:=TCompte3Annee(ListeTotaux.Objects[i]).SoldeExoNMoins2;
    end;




finally
PatienterFermer();
RequeteBalance.close;
RequeteEcriture.close;
Liste3Derniers.free;
Liste3Derniers:=nil;
ListeTotaux.Free;
ListeTotaux:=nil;
end;
end;


function TDmTableauDeBord.rempliXML_ChargesProduitsResultat(ListeCpt:TStringList;Regrouper : integer):boolean;
var
  debit,credit:currency;
  LigneType:IXMLLigneType;
  pagesType:IXMLPageType;
  ParamAffichPeriode:TParamAffichPeriode;
  periode:TPeriode;
  EtatFiltre:TEtatFiltre;
  TotauxRappBanc:TTotauxRappBanc;
  TotauxCompte:TTotauxBalance;
  i:integer;
  CompteRegroupe:string;
  TotalDebitAutre,TotalCreditAutre:currency;
  TotalReleveDebitAutre,TotalReleveCreditAutre:currency;
  listeEx0,Liste3Derniers,ListeTotaux,ListeTotauxRepartition,
  listeCharges,listeProduits:Tstringlist;
  RequeteBalance,RequeteEcriture:TQuery;
  ChargesProduits,ChargesProduitsRepartition:TChargesProduits;
  listeMoisExo,listeTmp:Tstringlist;
  Exercice:TExercice;
  DateDepart,DateFin,DateTmp:TDate;
  fini,trouve:boolean;
  A,M,D : word;
  ExoCourant:integer;
  Compte3Annee:TCompte3Annee;
  listeControl:Tstringlist;
begin
try//finally
PatienterAffich();
listeControl:=TStringList.create;
   pagesType:=interfaceTableaudebord.Pages.Add();
   listeMoisExo:=Tstringlist.create;
   listeTmp:=Tstringlist.create;
   listeCharges:=Tstringlist.create;
   listeProduits:=Tstringlist.create;
   RequeteBalance:=TQuery.Create(application.MainForm);
   RequeteEcriture:=TQuery.Create(application.MainForm);
   Initialise_ParamAffichPeriode(ParamAffichPeriode);
   ParamAffichPeriode.DateDansExercice:=true;
   periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
   ListeTotauxRepartition:=TStringList.create;
   Liste3Derniers:=TStringList.create;
   ListeTotaux:=TStringList.create;

   //récupérer tous les exercices pour travailler dessus
    listeEx0:=listeExercice(e.ID_Dos,false);

    //récupérer les 3 derniers exercices pour travailler dessus
    for i:=0 to listeEx0.count-1 do
    begin
       if(listeEx0.Strings[i]=e.NomExo)then
         begin
             Liste3Derniers.AddObject(listeEx0.Strings[i],listeEx0.Objects[i]);
             if(i>0)then Liste3Derniers.AddObject(listeEx0.Strings[i-1],listeEx0.Objects[i-1]);;
             if(i>1)then Liste3Derniers.AddObject(listeEx0.Strings[i-2],listeEx0.Objects[i-2]);;
         end;
    end;


    DMDiocEtatBal.ListeFiltreEdit.Assign(ListeCpt);
    //Pour chaque exercice, récupérer les totaux de la balance pour les charges et les produits
    //de la liste
  i:=0;
  trouve:=false;
  while (not trouve)and (i<listeEx0.count)do
    //for i:=0 to listeEx0.count-1 do
    begin
         ChargesProduitsRepartition:=nil;
         ExoCourant:=Liste3Derniers.IndexOf(listeEx0.Strings[i]);
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
         RequeteEcriture.ParamByName('DateDeb').AsDate:=TExercice(listeEx0.Objects[i]).Date_Deb_Exo;
         RequeteEcriture.ParamByName('DateFin').AsDate:=TExercice(listeEx0.Objects[i]).Date_Fin_Exo;
         RequeteEcriture.Open;
         RequeteEcriture.First;
      if RequeteEcriture.recordcount<> 0 then
         begin
          ChargesProduits:=TChargesProduits.Create;
           InitialiseTotauxBalance(TotauxCompte);
           CompteRegroupe:=copy(RequeteEcriture.FindField('compte').AsString,1,Regrouper);
          while not RequeteEcriture.Eof do
           begin
              if(ExoCourant<>-1)then
              begin
              if (ChargesProduitsRepartition=nil) or ((copy(CompteRegroupe,1,Regrouper) <> copy(RequeteEcriture.FindField('compte').AsString,1,Regrouper))) then
                 begin
                  ChargesProduitsRepartition:=TChargesProduits.Create;
                  ChargesProduitsRepartition.periode:=TExercice(listeEx0.Objects[i]).nom_exo;
                  ChargesProduitsRepartition.dateDeb:= TExercice(listeEx0.Objects[i]).Date_Deb_Exo;
                  ChargesProduitsRepartition.dateFin:= TExercice(listeEx0.Objects[i]).Date_Fin_Exo;
                  ListeTotauxRepartition.AddObject(ChargesProduitsRepartition.compte,ChargesProduitsRepartition);
                 end;
              end;
              CompteRegroupe:=copy(RequeteEcriture.FindField('compte').AsString,1,Regrouper);
              InitialiseTotauxBalance(TotauxCompte);
              TotauxCompte.TotalDebitFin:=RequeteEcriture.FindField('TotDebit').AsCurrency;
              TotauxCompte.TotalCreditFin:=RequeteEcriture.FindField('TotCredit').AsCurrency;;


              if(str_commence_par(CompteRegroupe,'6'))then
              begin
                 TotauxCompte.SoldeFin:=DetermineSoldeValeurReelle(TotauxCompte.TotalDebitFin,TotauxCompte.TotalCreditFin);
                 if(ExoCourant<>-1)then  ChargesProduitsRepartition.charges:=ChargesProduitsRepartition.charges+TotauxCompte.SoldeFin;
                  ChargesProduits.charges:=ChargesProduits.charges+TotauxCompte.SoldeFin;
                  listeControl.Add(TExercice(listeEx0.Objects[i]).nom_exo+';'+CompteRegroupe+';'+CurrToStr_Lgr(TotauxCompte.TotalDebitFin)+';'+CurrToStr_Lgr(TotauxCompte.TotalCreditFin)+';'+CurrToStr_Lgr(TotauxCompte.SoldeFin));
              end;
              if(str_commence_par(CompteRegroupe,'7')) then
              begin
                  TotauxCompte.SoldeFin:=DetermineSoldeValeurReelle(TotauxCompte.TotalCreditFin,TotauxCompte.TotalDebitFin);
                  if(ExoCourant<>-1)then ChargesProduitsRepartition.produits:=ChargesProduitsRepartition.produits+TotauxCompte.SoldeFin;
                  ChargesProduits.produits:=ChargesProduits.produits+(TotauxCompte.SoldeFin);
                   listeControl.Add(TExercice(listeEx0.Objects[i]).nom_exo+';'+CompteRegroupe+';'+CurrToStr_Lgr(TotauxCompte.TotalDebitFin)+';'+CurrToStr_Lgr(TotauxCompte.TotalCreditFin)+';'+CurrToStr_Lgr(TotauxCompte.SoldeFin));
              end;
           if(ExoCourant<>-1)then
            begin
              ChargesProduitsRepartition.compte:=CompteRegroupe;
              ChargesProduitsRepartition.ordre:=ExoCourant;
              //ListeTotauxRepartition.AddObject(ChargesProduitsRepartition.compte,ChargesProduitsRepartition);
            end;
           RequeteEcriture.next;
           end;
           ChargesProduits.periode:=TExercice(listeEx0.Objects[i]).nom_exo;
           ChargesProduits.dateDeb:= TExercice(listeEx0.Objects[i]).Date_Deb_Exo;
           ChargesProduits.dateFin:= TExercice(listeEx0.Objects[i]).Date_Fin_Exo;
           ListeTotaux.AddObject(ChargesProduits.periode,ChargesProduits);
         end;
         trouve:=TExercice(listeEx0.Objects[i]).nom_exo=e.NomExo;
       inc(i);
    end;
    for i:=0 to  ListeTotaux.Count-1 do
    begin
        LigneType:= pagesType.Chargesproduits.Courbeschargesproduitsannuelle.Add();
        LigneType.Exo:=TChargesProduits(ListeTotaux.Objects[i]).periode;
        LigneType.Charges:=TChargesProduits(ListeTotaux.Objects[i]).charges;
        LigneType.Produits:=TChargesProduits(ListeTotaux.Objects[i]).produits;
        LigneType.Resultat:=LigneType.Produits-LigneType.Charges;
    end;

listeControl.SaveToFile(e.RepertoireDossier+'\controlCharges.txt');

ListeTotaux.clear;
ListeTotauxRepartition.CustomSort(TriListeChargesProduits);
CompteRegroupe:='';
if(ListeTotauxRepartition.Count>0)then
begin
   ChargesProduits:=TChargesProduits(ListeTotauxRepartition.Objects[0]);
  CompteRegroupe:=ChargesProduits.compte;
end;
    for i:=0 to  ListeTotauxRepartition.Count-1 do
    begin
       ChargesProduits:=TChargesProduits(ListeTotauxRepartition.Objects[i]);

       if(str_commence_par(ChargesProduits.compte,'6'))then
         begin
             if(CompteRegroupe<>ChargesProduits.compte)or(Compte3Annee=nil)then
                begin
                  Compte3Annee:=TCompte3Annee.Create;
                  listeCharges.AddObject(ChargesProduits.compte,Compte3Annee);
                end;
              CompteRegroupe:=ChargesProduits.compte;
                  Compte3Annee.compte:=CompteRegroupe;
              case ChargesProduits.ordre of
                 2:Compte3Annee.SoldeExoNMoins2:=ChargesProduits.charges;
                 1:Compte3Annee.SoldeExoNMoins1:=ChargesProduits.charges;
                 0:Compte3Annee.SoldeExoN:=ChargesProduits.charges;
              end;
        end;
        if(str_commence_par(ChargesProduits.compte,'7'))then
         begin
             if(CompteRegroupe<>ChargesProduits.compte)or(Compte3Annee=nil)then
                begin
                  Compte3Annee:=TCompte3Annee.Create;
                  listeProduits.AddObject(ChargesProduits.compte,Compte3Annee);
                end;
              CompteRegroupe:=ChargesProduits.compte;
                  Compte3Annee.compte:=CompteRegroupe;
              case ChargesProduits.ordre of
                 2:Compte3Annee.SoldeExoNMoins2:=ChargesProduits.produits;
                 1:Compte3Annee.SoldeExoNMoins1:=ChargesProduits.produits;
                 0:Compte3Annee.SoldeExoN:=ChargesProduits.produits;
              end;
        end;
    end;
for i:=0 to listeCharges.Count-1 do
begin
  Compte3Annee:=TCompte3Annee(listeCharges.Objects[i]);
  LigneType:= pagesType.RepartitionCharges.Add;
  LigneType.compte:=Compte3Annee.compte;
  LigneType.ExoN:=Compte3Annee.SoldeExoN;
  LigneType.ExoN1:=Compte3Annee.SoldeExoNMoins1;
  LigneType.ExoN2:=Compte3Annee.SoldeExoNMoins2;
end;

for i:=0 to listeProduits.Count-1 do
begin
  Compte3Annee:=TCompte3Annee(listeProduits.Objects[i]);
  LigneType:= pagesType.RepartitionProduits.Add;
  LigneType.compte:=Compte3Annee.compte;
  LigneType.ExoN:=Compte3Annee.SoldeExoN;
  LigneType.ExoN1:=Compte3Annee.SoldeExoNMoins1;
  LigneType.ExoN2:=Compte3Annee.SoldeExoNMoins2;
end;

if(periode.DateDeb<=e.DatExoDebut)then                                              //on ne travail que sur les mois de l'exercice en cours
  DateDepart:=e.DatExoDebut else  dateDepart:=periode.DateDeb;   //ou sur les mois demandés si dans l'exercice en cours
if(periode.DateFin>=e.DatExoFin)then
  dateFin:=e.DatExoFin else  dateFin:=periode.DateFin;

DecodeDate(DateDepart,A,M,D);
DateDepart:=EncodeDate(A,M,1);
DecodeDate(Datefin,A,M,D);
Datefin:=EncodeDate(A,M,1)-1;

fini:=false;
DateTmp:=DateDepart;
Exercice:=TExercice.Create;
Exercice.Date_Deb_Exo:=DateTmp;
Exercice.Date_Fin_Exo:=moissuivant(DateTmp,0).Date_-1;
listeMoisExo.AddObject(MoisStr(DateTmp),Exercice);
while (not fini)do
begin

DateTmp:=MoisSuivant(DateTmp,0).Date_;
   if(DateTmp-1<=DateFin) then
     begin
       Exercice:=TExercice.Create;
       Exercice.Date_Deb_Exo:=DateTmp;
       Exercice.Date_Fin_Exo:=moissuivant(DateTmp,0).Date_-1;
       listeMoisExo.AddObject(MoisStrReduit(DateTmp),Exercice);
     end else fini:=true;
end;

    //rechercher tous les mois de l'exercice
    for i:=0 to listeMoisExo.count-1 do
    begin
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
         RequeteEcriture.ParamByName('DateDeb').AsDate:=DateDepart;
         RequeteEcriture.ParamByName('DateFin').AsDate:=TExercice(listeMoisExo.Objects[i]).Date_Fin_Exo;
         RequeteEcriture.Open;
         RequeteEcriture.First;
      if RequeteEcriture.recordcount<> 0 then
         begin
          ChargesProduits:=TChargesProduits.Create;
           InitialiseTotauxBalance(TotauxCompte);
          while not RequeteEcriture.Eof do
           begin
              CompteRegroupe:=RequeteEcriture.FindField('compte').AsString;
              TotauxCompte.TotalDebitFin:=RequeteEcriture.FindField('TotDebit').AsCurrency;
              TotauxCompte.TotalCreditFin:=RequeteEcriture.FindField('TotCredit').AsCurrency;;
              TotauxCompte.SoldeFin:=DetermineSoldeValeurReelle(TotauxCompte.TotalCreditFin,TotauxCompte.TotalDebitFin);
              if(str_commence_par(CompteRegroupe,'6'))then
              begin
                TotauxCompte.SoldeFin:=DetermineSoldeValeurReelle(TotauxCompte.TotalDebitFin,TotauxCompte.TotalCreditFin);
                ChargesProduits.charges:=ChargesProduits.charges+TotauxCompte.SoldeFin;
              end;
              if(str_commence_par(CompteRegroupe,'7')) then
              begin
                TotauxCompte.SoldeFin:=DetermineSoldeValeurReelle(TotauxCompte.TotalCreditFin,TotauxCompte.TotalDebitFin);
                ChargesProduits.produits:=ChargesProduits.produits+TotauxCompte.SoldeFin;
              end;
           RequeteEcriture.next;
           end;
           ChargesProduits.periode:=MoisStrReduit(TExercice(listeMoisExo.Objects[i]).Date_Fin_Exo);
           ChargesProduits.dateDeb:= TExercice(listeMoisExo.Objects[i]).Date_Deb_Exo;
           ChargesProduits.dateFin:= TExercice(listeMoisExo.Objects[i]).Date_Fin_Exo;
           ListeTotaux.AddObject(ChargesProduits.periode,ChargesProduits);
         end;

    end;
    for i:=0 to  ListeTotaux.Count-1 do
    begin
        LigneType:= pagesType.Chargesproduits.Courbeschargesproduitsmensuelle.Add();
        LigneType.Mois:=TChargesProduits(ListeTotaux.Objects[i]).periode;
        LigneType.Charges:=TChargesProduits(ListeTotaux.Objects[i]).charges;
        LigneType.Produits:=TChargesProduits(ListeTotaux.Objects[i]).produits;
        LigneType.Resultat:=LigneType.Produits-LigneType.Charges;
    end;
   

finally
PatienterFermer();
RequeteBalance.close;
RequeteEcriture.close;
Initialise_TStringlist(Liste3Derniers);
Initialise_TStringlist(ListeTotaux);
Initialise_TStringlist(ListeTotauxRepartition);
Initialise_TStringlist(listeCharges);
Initialise_TStringlist(listeProduits);
end;
end;


function XMLNodeValue(Noeud : IXMLNode; DefaultValue : string) : string;
begin
  if assigned(noeud) then
    try
      if not VarIsNull(noeud.NodeValue) then Result := noeud.NodeValue
      else Result := DefaultValue;
    except
      Result := DefaultValue;
    end
  else
    result := DefaultValue;
end;


function GetNode(XmlNode : IXmlNode;NodeName : String) : IXmlNode;
var
 i : integer;
begin
  Result := nil;

//Les noeuds internes sont traités récursivement
  if XMLNode.NodeType <> ntElement then
    Exit;

  //S'il s'agit d'une feuille
  if XMLNode.IsTextElement then
    if UpperCase(XmlNode.NodeName) = UpperCase(NodeName) then
    begin
      Result := XmlNode;
      Exit;
    end;
  // S'il s'agit d'un attribut
  for i := 0 to XMLNode.AttributeNodes.Count - 1 do
    if UpperCase(XMLNode.AttributeNodes.Nodes[I].NodeName) = Uppercase(NodeName) then
    begin
      Result := XMLNode.AttributeNodes.Nodes[I];
      Exit;
    end;

  // Si le noeud a des enfants on recherche dedans.
  if XMLNode.HasChildNodes then
    for I := 0 to XMLNode.ChildNodes.Count - 1 do
    begin
      Result := GetNode(XmlNode.ChildNodes.Nodes[I],NodeName);
      // si on a un resultat on quitte car c'est celui qu'on recherche
      if Result <> nil then
        Exit;
    end;
end;

constructor TCompte3Annee.Create;
    //constructeur
begin
  inherited Create;
end;

destructor TCompte3Annee.Destroy;
//destructeur
begin
  inherited Destroy;
end;

constructor TChargesProduits.Create;
    //constructeur
begin
compte:='';
charges:=0;
produits:=0;
periode:='';
dateDeb:=0;
dateFin:=0;
  inherited Create;
end;

destructor TChargesProduits.Destroy;
//destructeur
begin
  inherited Destroy;
end;


function TriListeDettesEtCreances(LaListe: TStringList; Index1, Index2: Integer): Integer;
var
  sTmp1, sTmp2: string;
begin
// Chaines à comparer
  sTmp1 :=TDettesEtCreances(LaListe.Objects[Index1]).compte;
  sTmp2 :=TDettesEtCreances(LaListe.Objects[Index2]).compte;
// Valeur de retour pour classement
  Result := CompareStr(sTmp1, sTmp2) ;

end;

function TriListeChargesProduits(LaListe: TStringList; Index1, Index2: Integer): Integer;
var
  sTmp1, sTmp2: string;
begin
// Chaines à comparer
  sTmp1 :=TChargesProduits(LaListe.Objects[Index1]).compte;
  sTmp2 :=TChargesProduits(LaListe.Objects[Index2]).compte;
// Valeur de retour pour classement
  Result := CompareStr(sTmp1, sTmp2) ;

end;



function TDmTableauDeBord.rempliXML_TresorerieMensuelle2(ListeCpt:TStringList;Regrouper : integer):boolean;
var
  debit,credit:currency;
  LigneType:IXMLLigneType;
  pagesType:IXMLPageType;
  ParamAffichPeriode:TParamAffichPeriode;
  periode:TPeriode;
  EtatFiltre:TEtatFiltre;
  TotauxRappBanc:TTotauxRappBanc;
  TotauxCompte:TTotauxBalance;
  i:integer;
  CompteRegroupe:string;
  TotalDebitAutre,TotalCreditAutre:currency;
  TotalReleveDebitAutre,TotalReleveCreditAutre:currency;
  listeEx0,Liste3Derniers,ListeTotaux,ListeTotauxRepartition,
  listeCharges,listeProduits:Tstringlist;
  RequeteBalance,RequeteEcriture:TQuery;
  ChargesProduits,ChargesProduitsRepartition:TChargesProduits;
  listeMoisExo,listeTmp:Tstringlist;
  Exercice:TExercice;
  DateDepart,DateFin,DateTmp:TDate;
  fini,trouve:boolean;
  A,M,D : word;
  ExoCourant:integer;
  Compte3Annee:TCompte3Annee;
  listeControl:Tstringlist;
begin
try//finally
PatienterAffich();
listeControl:=TStringList.create;
   pagesType:=interfaceTableaudebord.Pages.Add();
   listeMoisExo:=Tstringlist.create;
   listeTmp:=Tstringlist.create;
   listeCharges:=Tstringlist.create;
   listeProduits:=Tstringlist.create;
   RequeteBalance:=TQuery.Create(application.MainForm);
   RequeteEcriture:=TQuery.Create(application.MainForm);
   Initialise_ParamAffichPeriode(ParamAffichPeriode);
   ParamAffichPeriode.DateDansExercice:=true;
   periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
   ListeTotauxRepartition:=TStringList.create;
   Liste3Derniers:=TStringList.create;
   ListeTotaux:=TStringList.create;

   //récupérer tous les exercices pour travailler dessus
    listeEx0:=listeExercice(e.ID_Dos,false);

    //récupérer les 3 derniers exercices pour travailler dessus
    for i:=0 to listeEx0.count-1 do
    begin
       if(listeEx0.Strings[i]=e.NomExo)then
         begin
             Liste3Derniers.AddObject(listeEx0.Strings[i],listeEx0.Objects[i]);
             if(i>0)then Liste3Derniers.AddObject(listeEx0.Strings[i-1],listeEx0.Objects[i-1]);;
             if(i>1)then Liste3Derniers.AddObject(listeEx0.Strings[i-2],listeEx0.Objects[i-2]);;
         end;
    end;



dateDepart:=periode.DateDeb;   
dateFin:=periode.DateFin;

DecodeDate(DateDepart,A,M,D);
DateDepart:=EncodeDate(A,M,1);
DecodeDate(Datefin,A,M,D);
Datefin:=EncodeDate(A,M,1)-1;

fini:=false;
DateTmp:=DateDepart;
Exercice:=TExercice.Create;
Exercice.Date_Deb_Exo:=DateTmp;
Exercice.Date_Fin_Exo:=moissuivant(DateTmp,0).Date_-1;
listeMoisExo.AddObject(MoisStr(DateTmp),Exercice);
while (not fini)do
begin

DateTmp:=MoisSuivant(DateTmp,0).Date_;
   if(DateTmp-1<=DateFin) then
     begin
       Exercice:=TExercice.Create;
       Exercice.Date_Deb_Exo:=DateTmp;
       Exercice.Date_Fin_Exo:=moissuivant(DateTmp,0).Date_-1;
       listeMoisExo.AddObject(MoisStrReduit(DateTmp),Exercice);
     end else fini:=true;
end;

    //rechercher tous les mois de l'exercice
    for i:=0 to listeMoisExo.count-1 do
    begin
         RequeteBalance.close;
         RequeteBalance.SQL.Clear;
         RequeteBalance.Filtered := true;
         RequeteBalance.OnFilterRecord:=DMDiocEtatBal.TaBalanceCalcFilterRecord;
         RequeteBalance.DatabaseName:=DM_C_NomAliasDossier;

         RequeteBalance.SQL.Add('select p.libelle,P.compte, (b.Debit_Report),(b.Credit_Report) ');
         RequeteBalance.SQL.Add(' from plancpt P');
         RequeteBalance.SQL.Add(' full join  "'+IncludeTrailingPathDelimiter(TExercice(Liste3Derniers.Objects[i]).dir_exo)+'balance" b on p.compte=b.compte');
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
         RequeteEcriture.ParamByName('DateDeb').AsDate:=TExercice(Liste3Derniers.Objects[i]).Date_Deb_Exo;
         RequeteEcriture.ParamByName('DateFin').AsDate:=TExercice(Liste3Derniers.Objects[i]).Date_Fin_Exo;
         RequeteEcriture.Open;
         RequeteEcriture.First;
      if RequeteBalance.recordcount<> 0 then
         begin
          ChargesProduits:=TChargesProduits.Create;
           InitialiseTotauxBalance(TotauxCompte);
          while not RequeteEcriture.Eof do
           begin
              CompteRegroupe:=RequeteEcriture.FindField('compte').AsString;
              TotauxCompte.TotalDebitFin:=RequeteEcriture.FindField('TotDebit').AsCurrency;
              TotauxCompte.TotalCreditFin:=RequeteEcriture.FindField('TotCredit').AsCurrency;;
              TotauxCompte.SoldeFin:=DetermineSoldeValeurReelle(TotauxCompte.TotalCreditFin,TotauxCompte.TotalDebitFin);
              if(str_commence_par(CompteRegroupe,'6'))then
              begin
                TotauxCompte.SoldeFin:=DetermineSoldeValeurReelle(TotauxCompte.TotalDebitFin,TotauxCompte.TotalCreditFin);
                ChargesProduits.charges:=ChargesProduits.charges+TotauxCompte.SoldeFin;
              end;
              if(str_commence_par(CompteRegroupe,'7')) then
              begin
                TotauxCompte.SoldeFin:=DetermineSoldeValeurReelle(TotauxCompte.TotalCreditFin,TotauxCompte.TotalDebitFin);
                ChargesProduits.produits:=ChargesProduits.produits+TotauxCompte.SoldeFin;
              end;
           RequeteEcriture.next;
           end;
           ChargesProduits.periode:=MoisStrReduit(TExercice(listeMoisExo.Objects[i]).Date_Fin_Exo);
           ChargesProduits.dateDeb:= TExercice(listeMoisExo.Objects[i]).Date_Deb_Exo;
           ChargesProduits.dateFin:= TExercice(listeMoisExo.Objects[i]).Date_Fin_Exo;
           ListeTotaux.AddObject(ChargesProduits.periode,ChargesProduits);
         end;

    end;
    for i:=0 to  ListeTotaux.Count-1 do
    begin
        LigneType:= pagesType.Chargesproduits.Courbeschargesproduitsmensuelle.Add();
        LigneType.Mois:=TChargesProduits(ListeTotaux.Objects[i]).periode;
        LigneType.Charges:=TChargesProduits(ListeTotaux.Objects[i]).charges;
        LigneType.Produits:=TChargesProduits(ListeTotaux.Objects[i]).produits;
        LigneType.Resultat:=LigneType.Produits-LigneType.Charges;
    end;
   

finally
PatienterFermer();
RequeteBalance.close;
RequeteEcriture.close;
Initialise_TStringlist(Liste3Derniers);
Initialise_TStringlist(ListeTotaux);
Initialise_TStringlist(ListeTotauxRepartition);
Initialise_TStringlist(listeCharges);
Initialise_TStringlist(listeProduits);
end;
end;



function TDmTableauDeBord.rempliXML_TresorerieMensuelle(ListeCpt:TStringList; Regrouper : integer):boolean;
var
  debit,credit:currency;
  LigneType:IXMLLigneType;
  LigneCompteType:IXMLLigneCompteType;
  pagesType:IXMLPageType;
//  ParamAffichPeriode:TParamAffichPeriode;
//  periode:TPeriode;
  EtatFiltre:TEtatFiltre;
  TotauxRappBanc:TTotauxRappBanc;
  TotauxCompte:TTotauxBalance;
  i,j,rang1,rang2:integer;
  compte,mois,ordreTri:string;
  TotalDebitAutre,TotalCreditAutre:currency;
  TotalReleveDebitAutre,TotalReleveCreditAutre:currency;
  listeEx0,Liste3Derniers:Tstringlist;
  ListeTotaux:TStringlistLGR1;
  RequeteBalance,RequeteEcriture:TQuery;
  Compte3Annee:TCompte3Annee;
  moisCourant,moisFinExo:integer;
  listeMoisExo,listeTmp:Tstringlist;
  Exercice:TExercice;

  DateDepart,DateFin,DateTmp:TDate;
  fini,trouve:boolean;
  A,M,D : word;
begin
try//finally
PatienterAffich();
   pagesType:=interfaceTableaudebord.Pages.Add();
   RequeteBalance:=TQuery.Create(application.MainForm);
   RequeteEcriture:=TQuery.Create(application.MainForm);
//   Initialise_ParamAffichPeriode(ParamAffichPeriode);
//   ParamAffichPeriode.DateDansExercice:=true;
//   periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
   Liste3Derniers:=TStringList.create;
   ListeTotaux:=TStringlistLGR1.Create;
   listeMoisExo:=TStringList.create;


      //récupérer tous les exercices pour travailler dessus
    listeEx0:=listeExercice(e.ID_Dos,false);

    //récupérer les 3 derniers exercices pour travailler dessus
    for i:=0 to listeEx0.count-1 do
    begin
       if(listeEx0.Strings[i]=e.NomExo)then
         begin
             Liste3Derniers.AddObject(listeEx0.Strings[i],listeEx0.Objects[i]);
             if(i>0)then Liste3Derniers.AddObject(listeEx0.Strings[i-1],listeEx0.Objects[i-1]);;
             if(i>1)then Liste3Derniers.AddObject(listeEx0.Strings[i-2],listeEx0.Objects[i-2]);;
         end;
    end;


    rang1:=1;
    rang2:=1;
    ///pour chaque mois et Pour chaque exercice, récupérer les totaux de la balance pour chaque compte
    //de la liste
    for i:=0 to Liste3Derniers.count-1 do
    begin
         listeMoisExo.clear;
         dateDepart:=TExercice(Liste3Derniers.Objects[i]).Date_Deb_Exo;
         dateFin:=TExercice(Liste3Derniers.Objects[i]).Date_Fin_Exo;

         DecodeDate(DateDepart,A,M,D);
         DateDepart:=EncodeDate(A,M,1);
         DecodeDate(Datefin,A,M,D);
         Datefin:=EncodeDate(A,M,1)-1;

         fini:=false;
         DateTmp:=DateDepart;
         Exercice:=TExercice.Create;
         Exercice.Date_Deb_Exo:=DateTmp;
         Exercice.Date_Fin_Exo:=moissuivant(DateTmp,0).Date_-1;
         listeMoisExo.AddObject(MoisStr(DateTmp),Exercice);
         while (not fini)do
         begin

         DateTmp:=MoisSuivant(DateTmp,0).Date_;
           if(DateTmp-1<=DateFin) then
             begin
               Exercice:=TExercice.Create;
               Exercice.Date_Deb_Exo:=DateDepart;
               Exercice.Date_Fin_Exo:=moissuivant(DateTmp,0).Date_-1;
               listeMoisExo.AddObject(MoisStrReduit(DateTmp),Exercice);
             end else fini:=true;
         end;
         //rechercher tous les mois de l'exercice en cours (exoN, exoN-1 ou ExoN-2)
         for j:=0 to listeMoisExo.count-1 do
            begin
                 RequeteBalance.close;
                 RequeteBalance.SQL.Clear;
                 RequeteBalance.Filtered := true;
                 RequeteBalance.OnFilterRecord:=DMDiocEtatBal.TaBalanceCalcFilterRecord;
                 RequeteBalance.DatabaseName:=DM_C_NomAliasDossier;

                 RequeteBalance.SQL.Add('select p.libelle,P.compte, (b.Debit_Report),(b.Credit_Report) ');
                 RequeteBalance.SQL.Add(' from plancpt P');
                 RequeteBalance.SQL.Add(' full join  "'+IncludeTrailingPathDelimiter(TExercice(Liste3Derniers.Objects[i]).dir_exo)+'balance" b on p.compte=b.compte');
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
                 RequeteEcriture.ParamByName('DateDeb').AsDate:=TExercice(listeMoisExo.Objects[j]).Date_Deb_Exo;
                 RequeteEcriture.ParamByName('DateFin').AsDate:=TExercice(listeMoisExo.Objects[j]).Date_Fin_Exo;;
                 RequeteEcriture.Open;
                 RequeteEcriture.First;
                if RequeteBalance.recordcount<> 0 then
                   begin
                        compte :='';
                    while not RequeteBalance.Eof do
                     begin
                     compte :=RequeteBalance.FindField('Compte').AsString;
                     mois:=IntToStr_Lgr( DateInfos(TExercice(listeMoisExo.Objects[j]).Date_Fin_Exo).mois);
                     while(Length(mois)<2)do mois:='0'+mois;
                        if(ListeTotaux.indexOfCol(compte+';'+mois,1,'@')<>-1)then
                        begin
                          Compte3Annee:=TCompte3Annee(ListeTotaux.Objects[ListeTotaux.indexOfCol(compte+';'+mois,1,'@')]);
                          Compte3Annee.rang:=j;
                        end
                          else
                            begin
                              if(compte='')then compte :=RequeteBalance.FindField('Compte').AsString;
                              Compte3Annee:=TCompte3Annee.Create;
                              Compte3Annee.compte:=compte;
                              Compte3Annee.periode:=MoisStrReduit(TExercice(listeMoisExo.Objects[j]).Date_Fin_Exo);
                              Compte3Annee.mois:=mois;
                              Compte3Annee.rang:=j;
                              Compte3Annee.dateDeb:= TExercice(listeMoisExo.Objects[j]).Date_Deb_Exo;
                              Compte3Annee.dateFin:= TExercice(listeMoisExo.Objects[j]).Date_Fin_Exo;
                              ListeTotaux.AddObject(compte+';'+mois+'@'+IntToStr_Lgr(rang1),Compte3Annee);
                            end;
                        InitialiseTotauxBalance(TotauxCompte);

                        FiltrageDataSet(RequeteEcriture,CreeFiltreOU('compte',[compte]));
                        TotauxCompte.TotalDebitReport := RequeteBalance.FindField('Debit_Report').AsCurrency ;
                        TotauxCompte.TotalCreditReport := RequeteBalance.FindField('Credit_Report').AsCurrency ;
                        if(RequeteEcriture.RecordCount<>0)then
                        begin
                          TotauxCompte.TotalDebitBase:=RequeteEcriture.FindField('TotDebit').AsCurrency;
                          TotauxCompte.TotalCreditBase:=RequeteEcriture.FindField('TotCredit').AsCurrency;;
                        end;
                        TotauxCompte.TotalDebitFin:=TotauxCompte.TotalDebitReport+TotauxCompte.TotalDebitBase;
                        TotauxCompte.TotalCreditFin:=TotauxCompte.TotalCreditReport+TotauxCompte.TotalCreditBase;
                        TotauxCompte.SoldeFin:=DetermineSoldeValeurReelle(TotauxCompte.TotalDebitFin,TotauxCompte.TotalCreditFin);
                        case i of
                           0: begin
                                Compte3Annee.SoldeExoN:=TotauxCompte.SoldeFin;
                              end;
                           1: begin
                                 Compte3Annee.SoldeExoNMoins1:= TotauxCompte.SoldeFin;
          //                       Compte3Annee.SoldeExoN:=TotauxCompte.SoldeFin;
                              end;
                           2: begin
                                 Compte3Annee.SoldeExoNMoins2:= TotauxCompte.SoldeFin;
          //                       Compte3Annee.SoldeExoNMoins1:= Compte3Annee.SoldeExoN;
          //                       Compte3Annee.SoldeExoN:=TotauxCompte.SoldeFin;
                              end;
                        end;
                     RequeteBalance.next;

                     end;
                    inc(rang1);
                   end;
            end;
    end;
    j:=0;
    rang1:=65;
    rang2:=0;
    ListeTotaux.CustomSort(TriListeCompte);
//    ListeTotaux.SaveToFile(e.RepertoireDossier+'/listeCompteAvant.txt');

    if(ListeTotaux.Count>0) and(ListeTotaux.Objects[0]<>nil )then
       compte:=TCompte3Annee(ListeTotaux.Objects[0]).compte;
    while(j<ListeTotaux.count)do
    begin
       if(compte<>TCompte3Annee(ListeTotaux.Objects[j]).compte)then
       begin
          compte:=TCompte3Annee(ListeTotaux.Objects[j]).compte;
          inc(rang1);
       end;
       rang2:=TCompte3Annee(ListeTotaux.Objects[j]).rang;
       ordreTri:=IntToStr_Lgr(rang2);
       while (Length(ordreTri)<2)do ordreTri:='0'+ordreTri;
       ListeTotaux.Strings[j]:=chr(rang1)+ordreTri+'-'+ListeTotaux.Strings[j]+'/'+
           TCompte3Annee(ListeTotaux.Objects[j]).compte+'/'+TCompte3Annee(ListeTotaux.Objects[j]).mois;
       inc(j);
    end;
//        ListeTotaux.SaveToFile(e.RepertoireDossier+'/listeCompteApresModif.txt');
     ListeTotaux.CustomSort(TriListe);
//        ListeTotaux.SaveToFile(e.RepertoireDossier+'/listeCompteApresTri2.txt');

    LigneCompteType:=nil;
        j:=1;
    for i:=0 to  ListeTotaux.Count-1 do
    begin
        if(LigneCompteType=nil)or(LigneCompteType.Compte<>TCompte3Annee(ListeTotaux.Objects[i]).compte)then
        begin
            LigneCompteType:= pagesType.Tresorerie.Courbesevolutiontresoreriemensuelle.Add();
            LigneCompteType.Compte:=TCompte3Annee(ListeTotaux.Objects[i]).compte;
            LigneCompteType.Rang:=j;
            inc(j);
        end;
        LigneType:=LigneCompteType.Add();
//        LigneType.Mois:=TCompte3Annee(ListeTotaux.Objects[i]).mois+'-'+TCompte3Annee(ListeTotaux.Objects[i]).periode;
        LigneType.Mois:=TCompte3Annee(ListeTotaux.Objects[i]).mois;
        LigneType.Tri:=TCompte3Annee(ListeTotaux.Objects[i]).rang;
        LigneType.ExoN:=TCompte3Annee(ListeTotaux.Objects[i]).SoldeExoN;
        LigneType.ExoN1:=TCompte3Annee(ListeTotaux.Objects[i]).SoldeExoNMoins1;
        LigneType.ExoN2:=TCompte3Annee(ListeTotaux.Objects[i]).SoldeExoNMoins2;
    end;
finally
PatienterFermer();
RequeteBalance.close;
RequeteEcriture.close;
Liste3Derniers.free;
Liste3Derniers:=nil;
ListeTotaux.Free;
ListeTotaux:=nil;
listeMoisExo.free;
listeMoisExo:=nil;
end;
end;

function TriListe(LaListe: TStringList; Index1, Index2: Integer): Integer;
var
  sTmp1, sTmp2: string;
begin
  sTmp1 := GetStringElement( LaListe.Strings[Index1],1,'-');
  sTmp2 := GetStringElement( LaListe.Strings[Index2],1,'-');;
// Valeur de retour pour classement
    Result := CompareStr(sTmp1,sTmp2);
    case result of
      1,0:begin
//        if(sousTmp1>sousTmp2)then
//          Result := 1
//          else if(sousTmp1<sousTmp2) then
//           result:=-1;
        end;
    end;
end;

function TriListeCompte(LaListe: TStringList; Index1, Index2: Integer): Integer;
var
  sTmp1, sTmp2: string;
    sousTmp1, sousTmp2: integer;
begin
// Chaines à comparer
  sTmp1 := TCompte3Annee(LaListe.Objects[Index1]).compte;
  sTmp2 := TCompte3Annee(LaListe.Objects[Index2]).compte;
  sousTmp1 := TCompte3Annee(LaListe.Objects[Index1]).rang;
  sousTmp2 := TCompte3Annee(LaListe.Objects[Index2]).rang;
// Valeur de retour pour classement
    Result := CompareStr(sTmp1,sTmp2);
    if(result>=0)then
        begin
          //Result := CompareValue(sousTmp1,sousTmp2);
        end;
//    case result of
//      1,0:begin
//        if(sousTmp1>sousTmp2)then
//          Result := 1
//          else if(sousTmp1<sousTmp2) then
//           result:=-1;
//        end;
//    end;
end;

end.
