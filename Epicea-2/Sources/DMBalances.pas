{***************************************************************
 * Unit Name: DMBalances
 * Purpose  :
 * Author   :
 * History  :
 ****************************************************************}
unit DMBalances;

interface

uses
  Db, DBTables,Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, StdCtrls, Mask, DBCtrls, ExtCtrls,LibZoneSaisie,
  Menus,LibSQL, Registry, Math,DMClotures,LibDates,DMTier,E2_Decl_Records
  ,Variants,DMConstantes,DMProgramme,
  E2_LibInfosTable,
  E2_GenerCpt_PM,
  LibFichRep,
  lib_chaine,
  Gauges,
  E2_VisuListeView,DiversProjets,
  Gr_Librairie_Obj;

type
  TDMBalance = class(TDataModule)
    TaBalance: TTable;
    TaBalanceCompte: TStringField;
    TaBalanceTiers: TStringField;
    TaBalanceDebit_Report: TFloatField;
    TaBalanceCredit_Report: TFloatField;
    TaBalanceDebit_Base: TFloatField;
    TaBalanceCredit_Base: TFloatField;
    TaBalanceDebit_Total: TFloatField;
    TaBalanceCredit_Total: TFloatField;
    TaBalanceQt1_Report: TFloatField;
    TaBalanceQt2_Report: TFloatField;
    TaBalanceQt1_Base: TFloatField;
    TaBalanceQt2_Base: TFloatField;
    TaBalanceQt1_Total: TFloatField;
    TaBalanceQt2_Total: TFloatField;
    QueryEcriture: TQuery;
    QueryEcriturecompte: TStringField;
    QueryEcritureSUMOFDebitSaisie: TFloatField;
    QueryEcritureSUMOFCreditSaisie: TFloatField;
    TaBalanceTotalDeb: TFloatField;
    TaBalanceTotalCred: TFloatField;
    QueryRecup: TQuery;
    QueryRecupCompte: TStringField;
    QueryRecupTotal: TFloatField;
    QueryRecupQtTotal: TFloatField;
    QuMAJBalanceN1: TQuery;
    TaMAJBalanceN1: TTable;
    QuCalcEquilibreBalance: TQuery;
    QuCalcEquilibreBalanceResultat1_5: TFloatField;
    QuDeleteReportN1: TQuery;
    TaBalanceT: TTable;
    TaMAJBalanceTiersN1: TTable;
    QuSoldeCompte: TQuery;


    Procedure MAJBalance(DelRec:Boolean;Quantite,DebitCredit,Compte,OldCompte:string ;
    Qte,OldQte:Double ; Ptotal,OldPtotal:currency ;Etat:TDataSetState);
    Procedure MAJBalance_AvecQuantite(DelRec:Boolean;Quantite1,Quantite2,DebitCredit,Compte,
    OldCompte:string ; Qte1,Qte2,OldQte1,OldQte2:Double ; Ptotal,OldPtotal:currency ;Etat:TDataSetState);
    Procedure MAJBalance_N1(DelRec:Boolean;Quantite,DebitCredit,Compte,OldCompte:string ;
    Qte,OldQte:Double ; Ptotal,OldPtotal:currency ;Etat:TDataSetState);
    Procedure MAJBalance_N1_AvecQuantite(DelRec:Boolean;Quantite1,Quantite2,DebitCredit,Compte,
    OldCompte:string ; Qte1,Qte2,OldQte1,OldQte2:Double ; Ptotal,OldPtotal:currency ;Etat:TDataSetState);
    Procedure MAJBalanceDesTiers(DelRec:Boolean;Quantite,DebitCredit,Tiers,Compte,
    OldTiers:string ; Qte,OldQte:Double ; Ptotal,OldPtotal:currency ;Etat:TDataSetState);
    procedure DMBalanceCreate(Sender: TObject);
    procedure DMBalanceDestroy(Sender: TObject);
    procedure MiseAJourBalanceEntiere;
    procedure TraitementMiseAJourBalanceEntiere(TableBalance:TTable);
//    procedure FiltrageBalancePourChangementExo(Filtrage:Tquery);
//    procedure InitialisationChampAZero(QueryTmp:Tquery);
//    procedure FiltrageBalancePourBasculageExoSuivant;
    Function DetruitCptSiVide(compte:string;Tiers:boolean;BalanceCourante:TTable):boolean;
//    function VerifCptSiVide(compte:string):boolean;
    procedure TaBalanceAfterInsert(DataSet: TDataSet);
    procedure MiseAJourSimpleBalance_N_vers_N1(Sens:boolean;Montant:currency;Compte:string;Qt1:real=0;Qt2:real=0);
    function MiseAJourGlobalBalance_N_vers_N1(Charges_et_Produits:boolean):boolean;
    function VerifEquilibreBalanceN:TErreurSaisie;
    procedure QuBalanceAffichFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    function MiseAJourDuResultatDansN1(confirmation : Boolean=true):TExceptLGR;
    function VerifSoldeBalanceN_N1:boolean;
    function MiseAJourGlobalBalanceTiers_N_vers_N1:boolean;
    Procedure MAJBalanceDesTiers_N1(DelRec:Boolean;Quantite,DebitCredit,Tiers,Compte,
       OldTiers:string ; Qte,OldQte:Double ; Ptotal,OldPtotal:currency ;Etat:TDataSetState);
    Function RetourneSoldeCompteAvantReprise(Compte:string;DatasetEnCours:TDataset;MontantReprise:Currency;Sens:string):TSoldeCompte;
    function RecupSoldeCompte(Compte:string;DatasetEnCours:TDataset;RepriseEnCours:currency;Sens:string):Tcalcul;
    function MiseAJourGlobalBalance_N(RepertoireExocourant:string;DateDeb,DateFin:Tdatetime;Charges_et_Produits:boolean):boolean;

    function ControlBalanceTiersReport2(Gauge:TGauge=nil;Global:boolean=true ; Forcer:boolean=false):texceptlgr;
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  TotDebReport:currency;
  end;

var
  DMBalance: TDMBalance;
  grosseErreur:boolean;

  Function CptExisteDansBalance(cpt:string):boolean;
  Function PossibiliteRepriseCompte(compte:string;Dataset:TDataset;Sens:string;Ecran:string):Texceptlgr;

implementation
  uses E2_Librairie_obj,DMEcriture,DMBaseDonnee,DMDiocEtatBalance,CalculResultat,
  DMDiocEtatBalanceT, DMPlanCpt, DMRecherche, LibRessourceString,
  E2_Patientez, E2_Cloture_Def;

{$R *.DFM}


//****************************************************************************//
procedure TDMBalance.DMBalanceCreate(Sender: TObject);
var
i:integer;
begin
//try
 self.tag:=1;  //SIMULE
OuvrirTouteTable('',TControl(self));


end;
//******************* TDMBalance.DMBalanceDestroy *************************
procedure TDMBalance.DMBalanceDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
DMBalance:=nil;
end;
//******************* TDMBalance.MAJBalance *************************
//DelRec : Passe a true si l'on efface un enregistrement de la base source
//Quantite DebitCredit :nom du champ pour mise a jour
//Compte Qte Ptotal : Valeur modifi�e
//OldCompte OldQte OldPtotal :Valeur avant modif
//Etat de la table
//******************* TDMBalance.MAJBalance *************************
Procedure TDMBalance.MAJBalance(DelRec:Boolean;Quantite,DebitCredit,Compte,
OldCompte:string ; Qte,OldQte:Double ; Ptotal,OldPtotal:currency ;Etat:TDataSetState);
var
mettreAjour:boolean;
ParamGenerCptAffiche:TParamGenerCptAffiche;
begin     //Controle si le compte existe dans la balance
try
  mettreAjour:=true;
    case e.TypeMAJBalance of
      MAJ_Normal:begin
                     //abort;
                 end;
      MAJ_Base:begin
                    //
                 end;
      MAJ_Report:begin
                    if ((uppercase(DebitCredit)='CREDIT_REPORT')or(uppercase(DebitCredit)='DEBIT_REPORT')) then
                      mettreAjour:=false;
                 end;
    end;
if mettreAjour then
  begin
   TableGereStartTransaction(TaBalance);
     if not delrec then
       begin
         if empty(compte)then abort;
         if not DMPlan.CompteExistePCU(Compte) then
            Begin
              if not DMPlan.TaCompte.Active then DMPlan.TaCompte.Open;
              DMPlan.TaCompte.Insert;
              DMPlan.InitialiseInsertionCompte(Compte,DMPlan.TaCompte);
              DMPlan.TaCompte.FlushBuffers;
              ParamGenerCptAffiche.Affiche:=True;
              DMPlan.CreationAuto(Compte,ParamGenerCptAffiche);
            End;
         If TaBalance.Locate('Compte',Compte,[loCaseInsensitive]) Then
           begin //le compte existe dans la balance
               case Etat of              // Etat de la table source
                    dsInsert:begin // Etat insertion
                             TaBalance.Edit; // Mise a jour de la balance
                             TaBalance.FieldByName(DebitCredit).AsCurrency := TaBalance.FieldByName(DebitCredit).AsCurrency + Ptotal;
                             TaBalance.FieldByName(Quantite).AsFloat := TaBalance.FieldByName(Quantite).AsFloat+ Qte;
                             TableGerePost(TaBalance);
                             end ;//fin Etat insertion
                    dsEdit  :begin//Etat modification
                             if compte=Oldcompte then
                               begin //Si le compte n'est pas modifi�
                               TaBalance.Edit;          // Mise a jour de la balance
                               TaBalance.FieldByName(DebitCredit).AsCurrency := TaBalance.FieldByName(DebitCredit).AsCurrency - OldPtotal + Ptotal;
                               TaBalance.FieldByName(Quantite).AsFloat := TaBalance.FieldByName(Quantite).AsFloat - OldQte + Qte;
                               TableGerePost(TaBalance);
                               end //Fin le compte n'est pas modifi�
                               else //Si le compte est modifi�
                               begin
                                     begin // Nouveau Compte Trouv�
                                     TaBalance.Edit;
                                     TaBalance.FieldByName(DebitCredit).AsCurrency := TaBalance.FieldByName(DebitCredit).AsCurrency  + Ptotal;
                                     TaBalance.FieldByName(Quantite).AsFloat := TaBalance.FieldByName(Quantite).AsFloat + Qte;
                                     TableGerePost(TaBalance);
                                     end; // Fin Nouveau Compte Trouv�
                                     If TaBalance.Locate('Compte',OldCompte,[loCaseInsensitive]) Then
                                       begin // vieux Compte Trouv�
                                       TaBalance.Edit;       // Mise a jour de la balance
                                       TaBalance.FieldByName(DebitCredit).AsCurrency := TaBalance.FieldByName(DebitCredit).AsCurrency - OldPtotal ;//+ Ptotal;
                                       TaBalance.FieldByName(Quantite).AsFloat := TaBalance.FieldByName(Quantite).AsFloat - OldQte  ;//+ Qte;
                                       TableGerePost(TaBalance);
                                       DetruitCptSiVide(OldCompte,false,TaBalance);
                                       end // fin vieux Compte Trouv�
                                    else // vieux Compte n'est pas trouv� PROBLEME
                                       begin
                                       Application.MessageBox(Pchar('Probl�me dans la mise a jour de la balance !!!'),'Attention',MB_ICONWARNING);
//                                       Messagedlg('Probl�me dans la mise a jour de la balance !!!',MtWarning,[mbok],0);
                                      // Screen.Cursors[crNone];
                                       abort;
                                       end; // fin vieux Compte n'est pas trouv� PROBLEME
                                       // Si le compte est modifi� recherche le nouveau compte
                                       //pour y faire la mise � jour
                               end;// fin compte est modifi�
                             end;// fin etat modification
               end;  //fin case.Etat
           end //Fin le compte existe dans la balance
           else
           begin // Compte non trouv� dans la balance
               case Etat of // Etat de la table source
                    dsInsert:begin // Etat insertion
                             TaBalance.Insert;  //enregistrement nouveau compte balance
                             TaBalance.FindField('compte').AsString:= Compte;
                             TaBalance.FieldByName(DebitCredit).AsCurrency := Ptotal;
                             TaBalance.FieldByName(Quantite).AsFloat := Qte;
                             TableGerePost(TaBalance);
                             end; // Fin Etat insertion
                    dsEdit:  begin // Etat modification
                             TaBalance.Insert;  //enregistrement nouveau compte balance
                             TaBalance.FindField('compte').AsString:= Compte;
                             TaBalance.FieldByName(DebitCredit).AsCurrency := Ptotal;
                             TaBalance.FieldByName(Quantite).AsFloat := Qte;
                             TableGerePost(TaBalance);
                              If TaBalance.Locate('Compte',OldCompte,[loCaseInsensitive]) Then
                                 begin  // si vieux Compte Trouv�
                                 TaBalance.Edit; //on modifie le prix et la quantit�
                                 TaBalance.FieldByName(DebitCredit).AsCurrency := TaBalance.FieldByName(DebitCredit).AsCurrency - OldPtotal ;//+ Ptotal;
                                 TaBalance.FieldByName(Quantite).AsFloat := TaBalance.FieldByName(Quantite).AsFloat - OldQte  ;//+ Qte;
                                 TableGerePost(TaBalance);
                                 DetruitCptSiVide(OldCompte,false,TaBalance);
                                 end
                                 else // si vieux Compte n'est pas Trouv�
                                 begin
                                 Application.MessageBox(Pchar('Probl�me dans la mise a jour de la balance !!!'),'Attention',MB_ICONWARNING);
                                // Messagedlg('Probl�me dans la mise a jour de la balance !!!',MtWarning,[mbok],0);
    //                             Screen.Cursors[crNone];
                                 abort;
                                 end; // Fin vieux Compte n'est pas Trouv�
                             end;// fin Etat modification
               end; //fin case.ETat
           end;//fin compte non trouve dans balance
       end//fin si ajout ou modif
       else
           begin // si suppression d'un enregistrement
            if empty(OldCompte)then abort;
            if TaBalance.Locate('Compte',OldCompte,[loCaseInsensitive]) Then // Efface un enregistrement
              begin       // si trouve compte dans la balance
              TaBalance.Edit; //modification du prix et de la quantit�
              TaBalance.FieldByName(DebitCredit).AsCurrency := TaBalance.FieldByName(DebitCredit).AsCurrency - OldPtotal ;
              TaBalance.FieldByName(Quantite).AsFloat := TaBalance.FieldByName(Quantite).AsFloat - OldQte ;
              TableGerePost(TaBalance);
              DetruitCptSiVide(OldCompte,false,TaBalance);
              DelRec:=False;
              end  // fin trouve compte dans la balance
              else
              begin //Si le compte n'est pas trouv� PROBLEME
              Application.MessageBox(Pchar('Probl�me dans la mise a jour de la balance !!!'),'Attention',MB_ICONWARNING);
              //Messagedlg('Probl�me dans la mise a jour de la balance !!!' + TaBalance.findfield('compte').AsString,MtWarning,[mbok],0);
              abort;
              end;
           end;// Fin suppression d'un enregistrement
  end//si mettre � jour
else
  if e.TypeClient=cl_isa then messagedlg_lgr('Pas de mise � jour de la balance');  
except
  TableGereRollBack(TaBalance);
  abort;
end;
end;

Procedure TDMBalance.MAJBalance_AvecQuantite(DelRec:Boolean;Quantite1,Quantite2,DebitCredit,Compte,
OldCompte:string ; Qte1,Qte2,OldQte1,OldQte2:Double ; Ptotal,OldPtotal:currency ;Etat:TDataSetState);
var
mettreAjour:boolean;
ParamGenerCptAffiche:TParamGenerCptAffiche;
begin     //Controle si le compte existe dans la balance
try
  mettreAjour:=true;
    case e.TypeMAJBalance of
      MAJ_Normal:begin
                     //abort;
                 end;
      MAJ_Base:begin
                    //
                 end;
      MAJ_Report:begin
                    if ((uppercase(DebitCredit)='CREDIT_REPORT')or(uppercase(DebitCredit)='DEBIT_REPORT')) then
                      mettreAjour:=false;
                 end;
    end;
if mettreAjour then
  begin
   TableGereStartTransaction(TaBalance);
     if not delrec then
       begin
         if empty(compte)then abort;
         if not DMPlan.CompteExistePCU(Compte) then
            Begin
              if not DMPlan.TaCompte.Active then DMPlan.TaCompte.Open;
              DMPlan.TaCompte.Insert;
              DMPlan.InitialiseInsertionCompte(Compte,DMPlan.TaCompte);
              DMPlan.TaCompte.FlushBuffers;
              ParamGenerCptAffiche.Affiche:=True;
              DMPlan.CreationAuto(Compte,ParamGenerCptAffiche);
            End;
         If TaBalance.Locate('Compte',Compte,[loCaseInsensitive]) Then
           begin //le compte existe dans la balance
               case Etat of              // Etat de la table source
                    dsInsert:begin // Etat insertion
                             TaBalance.Edit; // Mise a jour de la balance
                             TaBalance.FieldByName(DebitCredit).AsCurrency := TaBalance.FieldByName(DebitCredit).AsCurrency + Ptotal;
                             TaBalance.FieldByName(Quantite1).AsFloat := TaBalance.FieldByName(Quantite1).AsFloat+ Qte1;
                             TaBalance.FieldByName(Quantite2).AsFloat := TaBalance.FieldByName(Quantite2).AsFloat+ Qte2;
                             TableGerePost(TaBalance);
                             end ;//fin Etat insertion
                    dsEdit  :begin//Etat modification
                             if compte=Oldcompte then
                               begin //Si le compte n'est pas modifi�
                               TaBalance.Edit;          // Mise a jour de la balance
                               TaBalance.FieldByName(DebitCredit).AsCurrency := TaBalance.FieldByName(DebitCredit).AsCurrency - OldPtotal + Ptotal;
                               TaBalance.FieldByName(Quantite1).AsFloat := TaBalance.FieldByName(Quantite1).AsFloat - OldQte1 + Qte1;
                               TaBalance.FieldByName(Quantite2).AsFloat := TaBalance.FieldByName(Quantite2).AsFloat - OldQte2 + Qte2;
                               TableGerePost(TaBalance);
                               end //Fin le compte n'est pas modifi�
                               else //Si le compte est modifi�
                               begin
                                     begin // Nouveau Compte Trouv�
                                     TaBalance.Edit;
                                     TaBalance.FieldByName(DebitCredit).AsCurrency := TaBalance.FieldByName(DebitCredit).AsCurrency  + Ptotal;
                                     TaBalance.FieldByName(Quantite1).AsFloat := TaBalance.FieldByName(Quantite1).AsFloat + Qte1;
                                     TaBalance.FieldByName(Quantite2).AsFloat := TaBalance.FieldByName(Quantite2).AsFloat + Qte2;
                                     TableGerePost(TaBalance);
                                     end; // Fin Nouveau Compte Trouv�
                                     If TaBalance.Locate('Compte',OldCompte,[loCaseInsensitive]) Then
                                       begin // vieux Compte Trouv�
                                       TaBalance.Edit;       // Mise a jour de la balance
                                       TaBalance.FieldByName(DebitCredit).AsCurrency := TaBalance.FieldByName(DebitCredit).AsCurrency - OldPtotal ;//+ Ptotal;
                                       TaBalance.FieldByName(Quantite1).AsFloat := TaBalance.FieldByName(Quantite1).AsFloat - OldQte1  ;//+ Qte;
                                       TaBalance.FieldByName(Quantite2).AsFloat := TaBalance.FieldByName(Quantite2).AsFloat - OldQte2  ;//+ Qte;
                                       TableGerePost(TaBalance);
                                       DetruitCptSiVide(OldCompte,false,TaBalance);
                                       end // fin vieux Compte Trouv�
                                    else // vieux Compte n'est pas trouv� PROBLEME
                                       begin
                                       Application.MessageBox(Pchar('Probl�me dans la mise a jour de la balance !!!'),'Attention',MB_ICONWARNING);
//                                       Messagedlg('Probl�me dans la mise a jour de la balance !!!',MtWarning,[mbok],0);
                                      // Screen.Cursors[crNone];
                                       abort;
                                       end; // fin vieux Compte n'est pas trouv� PROBLEME
                                       // Si le compte est modifi� recherche le nouveau compte
                                       //pour y faire la mise � jour
                               end;// fin compte est modifi�
                             end;// fin etat modification
               end;  //fin case.Etat
           end //Fin le compte existe dans la balance
           else
           begin // Compte non trouv� dans la balance
               case Etat of // Etat de la table source
                    dsInsert:begin // Etat insertion
                             TaBalance.Insert;  //enregistrement nouveau compte balance
                             TaBalance.FindField('compte').AsString:= Compte;
                             TaBalance.FieldByName(DebitCredit).AsCurrency := Ptotal;
                             TaBalance.FieldByName(Quantite1).AsFloat := Qte1;
                             TaBalance.FieldByName(Quantite2).AsFloat := Qte2;
                             TableGerePost(TaBalance);
                             end; // Fin Etat insertion
                    dsEdit:  begin // Etat modification
                             TaBalance.Insert;  //enregistrement nouveau compte balance
                             TaBalance.FindField('compte').AsString:= Compte;
                             TaBalance.FieldByName(DebitCredit).AsCurrency := Ptotal;
                             TaBalance.FieldByName(Quantite1).AsFloat := Qte1;
                             TaBalance.FieldByName(Quantite2).AsFloat := Qte2;
                             TableGerePost(TaBalance);
                              If TaBalance.Locate('Compte',OldCompte,[loCaseInsensitive]) Then
                                 begin  // si vieux Compte Trouv�
                                 TaBalance.Edit; //on modifie le prix et la quantit�
                                 TaBalance.FieldByName(DebitCredit).AsCurrency := TaBalance.FieldByName(DebitCredit).AsCurrency - OldPtotal ;//+ Ptotal;
                                 TaBalance.FieldByName(Quantite1).AsFloat := TaBalance.FieldByName(Quantite1).AsFloat - OldQte1  ;//+ Qte;
                                 TaBalance.FieldByName(Quantite2).AsFloat := TaBalance.FieldByName(Quantite2).AsFloat - OldQte2  ;//+ Qte;
                                 TableGerePost(TaBalance);
                                 DetruitCptSiVide(OldCompte,false,TaBalance);
                                 end
                                 else // si vieux Compte n'est pas Trouv�
                                 begin
                                 Application.MessageBox(Pchar('Probl�me dans la mise a jour de la balance !!!'),'Attention',MB_ICONWARNING);
                                 //Messagedlg('Probl�me dans la mise a jour de la balance !!!',MtWarning,[mbok],0);
    //                             Screen.Cursors[crNone];
                                 abort;
                                 end; // Fin vieux Compte n'est pas Trouv�
                             end;// fin Etat modification
               end; //fin case.ETat
           end;//fin compte non trouve dans balance
       end//fin si ajout ou modif
       else
           begin // si suppression d'un enregistrement
            if empty(OldCompte)then abort;
            if TaBalance.Locate('Compte',OldCompte,[loCaseInsensitive]) Then // Efface un enregistrement
              begin       // si trouve compte dans la balance
              TaBalance.Edit; //modification du prix et de la quantit�
              TaBalance.FieldByName(DebitCredit).AsCurrency := TaBalance.FieldByName(DebitCredit).AsCurrency - OldPtotal ;
              TaBalance.FieldByName(Quantite1).AsFloat := TaBalance.FieldByName(Quantite1).AsFloat - OldQte1 ;
              TaBalance.FieldByName(Quantite2).AsFloat := TaBalance.FieldByName(Quantite2).AsFloat - OldQte2 ;
              TableGerePost(TaBalance);
              DetruitCptSiVide(OldCompte,false,TaBalance);
              DelRec:=False;
              end  // fin trouve compte dans la balance
              else
              begin //Si le compte n'est pas trouv� PROBLEME
              Application.MessageBox(Pchar('Probl�me dans la mise a jour de la balance !!!'),'Attention',MB_ICONWARNING);
              //Messagedlg('Probl�me dans la mise a jour de la balance !!!' + TaBalance.findfield('compte').AsString,MtWarning,[mbok],0);
              abort;
              end;
           end;// Fin suppression d'un enregistrement
  end;//si mettre � jour
except
  TableGereRollBack(TaBalance);
  abort;
end;
end;


Procedure TDMBalance.MAJBalance_N1(DelRec:Boolean;Quantite,DebitCredit,Compte,
OldCompte:string ; Qte,OldQte:Double ; Ptotal,OldPtotal:currency ;Etat:TDataSetState);
begin     //Controle si le compte existe dans la balance
try
   TableGereStartTransaction(TaMAJBalanceN1);
   if not delrec then
     begin //si ajout ou modif
       if empty(compte)then abort;
       If TaMAJBalanceN1.Locate('Compte',Compte,[loCaseInsensitive]) Then
       begin //le compte existe dans la balance
           case Etat of              // Etat de la table source
                dsInsert:begin // Etat insertion
                         TaMAJBalanceN1.Edit; // Mise a jour de la balance
                         TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency := TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency + Ptotal;
                         TaMAJBalanceN1.FieldByName(Quantite).AsFloat := TaMAJBalanceN1.FieldByName(Quantite).AsFloat+ Qte;
                         TableGerePost(TaMAJBalanceN1);
                         end ;//fin Etat insertion
                dsEdit  :begin//Etat modification
                         if compte=Oldcompte then
                           begin //Si le compte n'est pas modifi�
                           TaMAJBalanceN1.Edit;          // Mise a jour de la balance
                           TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency := TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency - OldPtotal + Ptotal;
                           TaMAJBalanceN1.FieldByName(Quantite).AsFloat := TaMAJBalanceN1.FieldByName(Quantite).AsFloat - OldQte + Qte;
                           TableGerePost(TaMAJBalanceN1);
                           end //Fin le compte n'est pas modifi�
                           else //Si le compte est modifi�
                           begin
                                 begin // Nouveau Compte Trouv�
                                 TaMAJBalanceN1.Edit;
                                 TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency := TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency  + Ptotal;
                                 TaMAJBalanceN1.FieldByName(Quantite).AsFloat := TaMAJBalanceN1.FieldByName(Quantite).AsFloat + Qte;
                                 TableGerePost(TaMAJBalanceN1);
                                 end; // Fin Nouveau Compte Trouv�
                                 If TaMAJBalanceN1.Locate('Compte',OldCompte,[loCaseInsensitive]) Then
                                   begin // vieux Compte Trouv�
                                   TaMAJBalanceN1.Edit;       // Mise a jour de la balance
                                   TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency := TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency - OldPtotal ;//+ Ptotal;
                                   TaMAJBalanceN1.FieldByName(Quantite).AsFloat := TaMAJBalanceN1.FieldByName(Quantite).AsFloat - OldQte  ;//+ Qte;
                                   TableGerePost(TaMAJBalanceN1);
                                   DetruitCptSiVide(OldCompte,false,TaMAJBalanceN1);
                                   end // fin vieux Compte Trouv�
                                else // vieux Compte n'est pas trouv� PROBLEME
                                   begin
                                   Application.MessageBox(Pchar('Probl�me dans la mise a jour de la balance !!!'),'Attention',MB_ICONWARNING);
                                   //Messagedlg('Probl�me dans la mise a jour de la balance !!!',MtWarning,[mbok],0);
                                  // Screen.Cursors[crNone];
                                   abort;
                                   end; // fin vieux Compte n'est pas trouv� PROBLEME
                                   // Si le compte est modifi� recherche le nouveau compte
                                   //pour y faire la mise � jour
                           end;// fin compte est modifi�
                         end;// fin etat modification
           end;  //fin case.Etat
       end //Fin le compte existe dans la balance
       else
       begin // Compte non trouv� dans la balance
           case Etat of // Etat de la table source
                dsInsert:begin // Etat insertion
                         TaMAJBalanceN1.Insert;  //enregistrement nouveau compte balance
                         TaMAJBalanceN1.FindField('compte').AsString:= Compte;
                         TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency := Ptotal;
                         TaMAJBalanceN1.FieldByName(Quantite).AsFloat := Qte;
                         TableGerePost(TaMAJBalanceN1);
                         end; // Fin Etat insertion
                dsEdit:  begin // Etat modification
                         TaMAJBalanceN1.Insert;  //enregistrement nouveau compte balance
                         TaMAJBalanceN1.FindField('compte').AsString:= Compte;
                         TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency := Ptotal;
                         TaMAJBalanceN1.FieldByName(Quantite).AsFloat := Qte;
                         TableGerePost(TaMAJBalanceN1);
                          If TaMAJBalanceN1.Locate('Compte',OldCompte,[loCaseInsensitive]) Then
                             begin  // si vieux Compte Trouv�
                             TaMAJBalanceN1.Edit; //on modifie le prix et la quantit�
                             TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency := TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency - OldPtotal ;//+ Ptotal;
                             TaMAJBalanceN1.FieldByName(Quantite).AsFloat := TaMAJBalanceN1.FieldByName(Quantite).AsFloat - OldQte  ;//+ Qte;
                             TableGerePost(TaMAJBalanceN1);
                             DetruitCptSiVide(OldCompte,false,TaMAJBalanceN1);
                             end
                             else // si vieux Compte n'est pas Trouv�
                             begin
                             Application.MessageBox(Pchar('Probl�me dans la mise a jour de la balance !!!'),'Attention',MB_ICONWARNING);
                             //Messagedlg('Probl�me dans la mise a jour de la balance !!!',MtWarning,[mbok],0);
//                             Screen.Cursors[crNone];
                             abort;
                             end; // Fin vieux Compte n'est pas Trouv�
                         end;// fin Etat modification
           end; //fin case.ETat
       end;//fin compte non trouve dans balance
     end//fin si ajout ou modif
    else
           begin // si suppression d'un enregistrement
              if empty(oldcompte)then abort;
              if TaMAJBalanceN1.Locate('Compte',OldCompte,[loCaseInsensitive]) Then // Efface un enregistrement
              begin       // si trouve compte dans la balance
              TaMAJBalanceN1.Edit; //modification du prix et de la quantit�
              TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency := TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency - OldPtotal ;
              TaMAJBalanceN1.FieldByName(Quantite).AsFloat := TaMAJBalanceN1.FieldByName(Quantite).AsFloat - OldQte ;
              TableGerePost(TaMAJBalanceN1);
              DetruitCptSiVide(OldCompte,false,TaMAJBalanceN1);
              DelRec:=False;
              end  // fin trouve compte dans la balance
              else
              begin //Si le compte n'est pas trouv� PROBLEME
              Application.MessageBox(Pchar('Probl�me dans la mise a jour de la balance !!!'),'Attention',MB_ICONWARNING);
              //Messagedlg('Probl�me dans la mise a jour de la balance !!!' + TaMAJBalanceN1.findfield('compte').AsString,MtWarning,[mbok],0);
              abort;
              end;
           end;// Fin suppression d'un enregistrement
except
  TableGereRollBack(TaMAJBalanceN1);
  abort;
end;
end;

Procedure TDMBalance.MAJBalance_N1_AvecQuantite(DelRec:Boolean;Quantite1,Quantite2,DebitCredit,Compte,
OldCompte:string ; Qte1,Qte2,OldQte1,OldQte2:Double ; Ptotal,OldPtotal:currency ;Etat:TDataSetState);

begin     //Controle si le compte existe dans la balance
try
   TableGereStartTransaction(TaMAJBalanceN1);
   if not delrec then
     begin //si ajout ou modif
       if empty(compte)then abort;
       If TaMAJBalanceN1.Locate('Compte',Compte,[loCaseInsensitive]) Then
       begin //le compte existe dans la balance
           case Etat of              // Etat de la table source
                dsInsert:begin // Etat insertion
                         TaMAJBalanceN1.Edit; // Mise a jour de la balance
                         TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency := TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency + Ptotal;
                         TaMAJBalanceN1.FieldByName(Quantite1).AsFloat := TaMAJBalanceN1.FieldByName(Quantite1).AsFloat+ Qte1;
                         TaMAJBalanceN1.FieldByName(Quantite2).AsFloat := TaMAJBalanceN1.FieldByName(Quantite2).AsFloat+ Qte2;
                         TableGerePost(TaMAJBalanceN1);
                         end ;//fin Etat insertion
                dsEdit  :begin//Etat modification
                         if compte=Oldcompte then
                           begin //Si le compte n'est pas modifi�
                           TaMAJBalanceN1.Edit;          // Mise a jour de la balance
                           TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency := TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency - OldPtotal + Ptotal;
                           TaMAJBalanceN1.FieldByName(Quantite1).AsFloat := TaMAJBalanceN1.FieldByName(Quantite1).AsFloat - OldQte1 + Qte1;
                           TaMAJBalanceN1.FieldByName(Quantite2).AsFloat := TaMAJBalanceN1.FieldByName(Quantite2).AsFloat - OldQte2 + Qte2;
                           TableGerePost(TaMAJBalanceN1);
                           end //Fin le compte n'est pas modifi�
                           else //Si le compte est modifi�
                           begin
                                 begin // Nouveau Compte Trouv�
                                 TaMAJBalanceN1.Edit;
                                 TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency := TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency  + Ptotal;
                                 TaMAJBalanceN1.FieldByName(Quantite1).AsFloat := TaMAJBalanceN1.FieldByName(Quantite1).AsFloat + Qte1;
                                 TaMAJBalanceN1.FieldByName(Quantite2).AsFloat := TaMAJBalanceN1.FieldByName(Quantite2).AsFloat + Qte2;
                                 TableGerePost(TaMAJBalanceN1);
                                 end; // Fin Nouveau Compte Trouv�
                                 If TaMAJBalanceN1.Locate('Compte',OldCompte,[loCaseInsensitive]) Then
                                   begin // vieux Compte Trouv�
                                   TaMAJBalanceN1.Edit;       // Mise a jour de la balance
                                   TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency := TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency - OldPtotal ;//+ Ptotal;
                                   TaMAJBalanceN1.FieldByName(Quantite1).AsFloat := TaMAJBalanceN1.FieldByName(Quantite1).AsFloat - OldQte1  ;//+ Qte;
                                   TaMAJBalanceN1.FieldByName(Quantite2).AsFloat := TaMAJBalanceN1.FieldByName(Quantite2).AsFloat - OldQte2  ;//+ Qte;
                                   TableGerePost(TaMAJBalanceN1);
                                   DetruitCptSiVide(OldCompte,false,TaMAJBalanceN1);
                                   end // fin vieux Compte Trouv�
                                else // vieux Compte n'est pas trouv� PROBLEME
                                   begin
                                   Application.MessageBox(Pchar('Probl�me dans la mise a jour de la balance !!!'),'Attention',MB_ICONWARNING);
                                   //Messagedlg('Probl�me dans la mise a jour de la balance !!!',MtWarning,[mbok],0);
                                  // Screen.Cursors[crNone];
                                   abort;
                                   end; // fin vieux Compte n'est pas trouv� PROBLEME
                                   // Si le compte est modifi� recherche le nouveau compte
                                   //pour y faire la mise � jour
                           end;// fin compte est modifi�
                         end;// fin etat modification
           end;  //fin case.Etat
       end //Fin le compte existe dans la balance
       else
       begin // Compte non trouv� dans la balance
           case Etat of // Etat de la table source
                dsInsert:begin // Etat insertion
                         TaMAJBalanceN1.Insert;  //enregistrement nouveau compte balance
                         TaMAJBalanceN1.FindField('compte').AsString:= Compte;
                         TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency := Ptotal;
                         TaMAJBalanceN1.FieldByName(Quantite1).AsFloat := Qte1;
                         TaMAJBalanceN1.FieldByName(Quantite2).AsFloat := Qte2;
                         TableGerePost(TaMAJBalanceN1);
                         end; // Fin Etat insertion
                dsEdit:  begin // Etat modification
                         TaMAJBalanceN1.Insert;  //enregistrement nouveau compte balance
                         TaMAJBalanceN1.FindField('compte').AsString:= Compte;
                         TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency := Ptotal;
                         TaMAJBalanceN1.FieldByName(Quantite1).AsFloat := Qte1;
                         TaMAJBalanceN1.FieldByName(Quantite2).AsFloat := Qte2;
                         TableGerePost(TaMAJBalanceN1);
                          If TaMAJBalanceN1.Locate('Compte',OldCompte,[loCaseInsensitive]) Then
                             begin  // si vieux Compte Trouv�
                             TaMAJBalanceN1.Edit; //on modifie le prix et la quantit�
                             TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency := TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency - OldPtotal ;//+ Ptotal;
                             TaMAJBalanceN1.FieldByName(Quantite1).AsFloat := TaMAJBalanceN1.FieldByName(Quantite1).AsFloat - OldQte1  ;//+ Qte;
                             TaMAJBalanceN1.FieldByName(Quantite2).AsFloat := TaMAJBalanceN1.FieldByName(Quantite2).AsFloat - OldQte2  ;//+ Qte;
                             TableGerePost(TaMAJBalanceN1);
                             DetruitCptSiVide(OldCompte,false,TaMAJBalanceN1);
                             end
                             else // si vieux Compte n'est pas Trouv�
                             begin
                             Application.MessageBox(Pchar('Probl�me dans la mise a jour de la balance !!!'),'Attention',MB_ICONWARNING);
                             //Messagedlg('Probl�me dans la mise a jour de la balance !!!',MtWarning,[mbok],0);
//                             Screen.Cursors[crNone];
                             abort;
                             end; // Fin vieux Compte n'est pas Trouv�
                         end;// fin Etat modification
           end; //fin case.ETat
       end;//fin compte non trouve dans balance
     end//fin si ajout ou modif
    else
           begin // si suppression d'un enregistrement
              if empty(oldcompte)then abort;
              if TaMAJBalanceN1.Locate('Compte',OldCompte,[loCaseInsensitive]) Then // Efface un enregistrement
              begin       // si trouve compte dans la balance
              TaMAJBalanceN1.Edit; //modification du prix et de la quantit�
              TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency := TaMAJBalanceN1.FieldByName(DebitCredit).AsCurrency - OldPtotal ;
              TaMAJBalanceN1.FieldByName(Quantite1).AsFloat := TaMAJBalanceN1.FieldByName(Quantite1).AsFloat - OldQte1 ;
              TaMAJBalanceN1.FieldByName(Quantite2).AsFloat := TaMAJBalanceN1.FieldByName(Quantite2).AsFloat - OldQte2 ;
              TableGerePost(TaMAJBalanceN1);
              DetruitCptSiVide(OldCompte,false,TaMAJBalanceN1);
              DelRec:=False;
              end  // fin trouve compte dans la balance
              else
              begin //Si le compte n'est pas trouv� PROBLEME
              Application.MessageBox(Pchar('Probl�me dans la mise a jour de la balance !!!'),'Attention',MB_ICONWARNING);
//              Messagedlg('Probl�me dans la mise a jour de la balance !!!' + TaMAJBalanceN1.findfield('compte').AsString,MtWarning,[mbok],0);
              abort;
              end;
           end;// Fin suppression d'un enregistrement
except
  TableGereRollBack(TaMAJBalanceN1);
  abort;
end;
end;


Procedure TDMBalance.MAJBalanceDesTiers(DelRec:Boolean;Quantite,DebitCredit,Tiers,Compte,
OldTiers:string ; Qte,OldQte:Double ; Ptotal,OldPtotal:currency ;Etat:TDataSetState);
var
mettreAjour:boolean;
begin     //Controle si le compte existe dans la balance
try
  mettreAjour:=true;
    case e.TypeMAJBalance of
      MAJ_Normal:begin
                     //
                 end;
      MAJ_Base:begin
                    //
                 end;
      MAJ_Report:begin
                    if ((uppercase(DebitCredit)='CREDIT_REPORT')or(uppercase(DebitCredit)='DEBIT_REPORT')) then
                      mettreAjour:=false;
                 end;
    end;
if mettreAjour then
  begin
 //Controle si le compte existe dans la balance
    TableGereStartTransaction(TaBalanceT);
    if not delrec then
      begin//si ajout ou modif
        if ((empty(Tiers))or (empty(compte)))then abort;
        If TaBalanceT.Locate('Tiers',Tiers,[loCaseInsensitive]) Then
           begin //le compte existe dans la balance
               case Etat of              // Etat de la table source
                    dsInsert:begin // Etat insertion
                             TaBalanceT.Edit; // Mise a jour de la balance
                             TaBalanceT.FieldByName(DebitCredit).AsCurrency := TaBalanceT.FieldByName(DebitCredit).AsCurrency + Ptotal;
                             TaBalanceT.FieldByName(Quantite).AsFloat := TaBalanceT.FieldByName(Quantite).AsFloat+ Qte;
                             TableGerePost(TaBalanceT);
                             end ;//fin Etat insertion
                    dsEdit  :begin//Etat modification
                             if Tiers=OldTiers then
                               begin //Si le compte n'est pas modifi�
                               TaBalanceT.Edit;          // Mise a jour de la balance
                               TaBalanceT.FieldByName(DebitCredit).AsCurrency := TaBalanceT.FieldByName(DebitCredit).AsCurrency - OldPtotal + Ptotal;
                               TaBalanceT.FieldByName(Quantite).AsFloat := TaBalanceT.FieldByName(Quantite).AsFloat - OldQte + Qte;
                               TableGerePost(TaBalanceT);
                               end //Fin le compte n'est pas modifi�
                               else //Si le compte est modifi�
                               begin
                                     begin // Nouveau Compte Trouv�
                                     TaBalanceT.Edit;
                                     TaBalanceT.FieldByName(DebitCredit).AsCurrency := TaBalanceT.FieldByName(DebitCredit).AsCurrency  + Ptotal;
                                     TaBalanceT.FieldByName(Quantite).AsFloat := TaBalanceT.FieldByName(Quantite).AsFloat + Qte;
                                     TableGerePost(TaBalanceT);
                                     end; // Fin Nouveau Compte Trouv�
                                     If TaBalanceT.Locate('Tiers',OldTiers,[loCaseInsensitive]) Then
                                       begin // vieux Compte Trouv�
                                       TaBalanceT.Edit;       // Mise a jour de la balance
                                       TaBalanceT.FieldByName(DebitCredit).AsCurrency := TaBalanceT.FieldByName(DebitCredit).AsCurrency - OldPtotal ;//+ Ptotal;
                                       TaBalanceT.FieldByName(Quantite).AsFloat := TaBalanceT.FieldByName(Quantite).AsFloat - OldQte  ;//+ Qte;
                                       TableGerePost(TaBalanceT);
                                       DetruitCptSiVide(OldTiers,true,TaBalanceT);
                                       end // fin vieux Compte Trouv�
                                    else // vieux Compte n'est pas trouv� PROBLEME
                                       if not empty(OldTiers)then
                                       begin
                                       Application.MessageBox(Pchar('Probl�me dans la mise a jour de la balance !!!'),'Attention',MB_ICONWARNING);
                                      // Messagedlg('Probl�me dans la mise a jour de la balance !!!',MtWarning,[mbok],0);
                                      // Screen.Cursors[crNone];
                                       abort;
                                       end; // fin vieux Compte n'est pas trouv� PROBLEME
                                       // Si le compte est modifi� recherche le nouveau compte
                                       //pour y faire la mise � jour
                               end;// fin compte est modifi�
                             end;// fin etat modification
               end;  //fin case.Etat
           end //Fin le compte existe dans la balance
           else
           begin // Compte non trouv� dans la balance
               case Etat of // Etat de la table source
                    dsInsert:begin // Etat insertion
                             TaBalanceT.Insert;  //enregistrement nouveau compte balance
                             TaBalanceT.FindField('Tiers').AsString:= tiers;
                             TaBalanceT.FindField('Compte').AsString:= compte;
                             TaBalanceT.FieldByName(DebitCredit).AsCurrency := Ptotal;
                             TaBalanceT.FieldByName(Quantite).AsFloat := Qte;
                             TableGerePost(TaBalanceT);
                             end; // Fin Etat insertion
                    dsEdit:  begin // Etat modification
                             TaBalanceT.Insert;  //enregistrement nouveau compte balance
                             TaBalanceT.FindField('Tiers').AsString:= tiers;
                             TaBalanceT.FindField('Compte').AsString:= compte;
                             TaBalanceT.FieldByName(DebitCredit).AsCurrency := Ptotal;
                             TaBalanceT.FieldByName(Quantite).AsFloat := Qte;
                             TableGerePost(TaBalanceT);
                              If TaBalanceT.Locate('Tiers',Oldtiers,[loCaseInsensitive]) Then
                                 begin  // si vieux Compte Trouv�
                                 TaBalanceT.Edit; //on modifie le prix et la quantit�
                                 TaBalanceT.FieldByName(DebitCredit).AsCurrency := TaBalanceT.FieldByName(DebitCredit).AsCurrency - OldPtotal ;//+ Ptotal;
                                 TaBalanceT.FieldByName(Quantite).AsFloat := TaBalanceT.FieldByName(Quantite).AsFloat - OldQte  ;//+ Qte;
                                 TableGerePost(TaBalanceT);
                                 DetruitCptSiVide(Oldtiers,true,TaBalanceT);
                                 end
                                 else // si vieux Compte n'est pas Trouv�
                                 if not empty(OldTiers)then
                                 begin
                                 Application.MessageBox(Pchar('Probl�me dans la mise a jour de la balance !!!'),'Attention',MB_ICONWARNING);
//                                 Messagedlg('Probl�me dans la mise a jour de la balance !!!',MtWarning,[mbok],0);
    //                             Screen.Cursors[crNone];
                                 abort;
                                 end; // Fin vieux Compte n'est pas Trouv�
                             end;// fin Etat modification
               end; //fin case.ETat
           end;//fin compte non trouve dans balance
      end//fin si ajout ou modif
     else
           begin // si suppression d'un enregistrement
              //if empty(Oldtiers)then abort;
              if TaBalanceT.Locate('Tiers',Oldtiers,[loCaseInsensitive]) Then // Efface un enregistrement
              begin       // si trouve compte dans la balance
              TaBalanceT.Edit; //modification du prix et de la quantit�
              TaBalanceT.FieldByName(DebitCredit).AsCurrency := TaBalanceT.FieldByName(DebitCredit).AsCurrency - OldPtotal ;
              TaBalanceT.FieldByName(Quantite).AsFloat := TaBalanceT.FieldByName(Quantite).AsFloat - OldQte ;
              TableGerePost(TaBalanceT);
              DetruitCptSiVide(Oldtiers,true,TaBalanceT);
              DelRec:=False;
              end  // fin trouve compte dans la balance
              else
              if not empty(Oldtiers)then
              begin //Si le compte n'est pas trouv� PROBLEME
              Application.MessageBox(Pchar('Probl�me dans la mise a jour de la balance !!!'),'Attention',MB_ICONWARNING);
              //Messagedlg('Probl�me dans la mise a jour de la balance !!!' + TaBalanceT.findfield('Tiers').AsString,MtWarning,[mbok],0);
              TableGereRollBack(TaBalanceT);
              abort;
              end;
           end;// Fin suppression d'un enregistrement
//        Screen.Cursors[crNone];
  end;//fin si mettre � jour
except
  TableGereRollBack(TaBalanceT);
  abort;
end;
end;




//******************* TDMBalance.TraitementMiseAJourBalanceEntiere *************************
//cette procedure compare les cr�dits et d�bits de la balance en fonction
//des d�bits et cr�dits de la queryEcriture
//op�re un traitement en fonction des diff�rences rencontr�es.
//*******************************************************************************
procedure TDMBalance.TraitementMiseAJourBalanceEntiere(TableBalance:TTable);
begin
grosseErreur:=false;
try
TableGereStartTransaction(TableBalance);
if TableBalance.Locate('compte',QueryEcriturecompte.AsString,[loCaseInsensitive]) then
     begin //si le compte existe
        if TableBalance.FindField('Credit_Base').AsCurrency<>QueryEcritureSUMOFCreditSaisie.AsCurrency then
          //compare CreditSaisie et D�bitSaisie de queryEcriture
          //avec debit_base et credit_base de balance
           begin //s'il trouve une diff�rence pour le credit
            if TableBalance.FindField('Credit_Base').AsCurrency<QueryEcritureSUMOFCreditSaisie.AsCurrency then
              begin //si la balance au cr�dit est inf�rieur
                if Application.Messagebox(Pchar('Le compte '+QueryEcriturecompte.AsString+
                ' de la balance pr�sente, au cr�dit, un �cart de -'
                +floattostr(QueryEcritureSUMOFCreditSaisie.AsCurrency-TableBalance.FindField('Credit_Base').AsCurrency)+
                ' par rapport � ces �critures pass�es !!! Voulez vous mettre � jour la balance pour ce compte')
                ,'Attention',mb_iconWarning+MB_YESNO+MB_DEFBUTTON2)=mrno then
                   // on verra plus tard avec philippe
                else   // si pas ok pour mise � jour
                   begin // si ok pour mise � jour
                   TableBalance.Edit;
                   TableBalance.FindField('Credit_Base').AsCurrency:=QueryEcritureSUMOFCreditSaisie.AsCurrency;
                   TableGerePost(TableBalance);
                   end;
              end; //fin la balance au cr�dit est inf�rieur
            if TableBalance.FindField('Credit_Base').AsCurrency>QueryEcritureSUMOFCreditSaisie.AsCurrency then
              begin //si la balance au cr�dit est sup�rieur
                if Application.Messagebox(Pchar('Le compte '+QueryEcriturecompte.AsString+
                'de la balance  pr�sente, au cr�dit, un ecart de +'
                +floattostr(TableBalance.FindField('Credit_Base').AsCurrency-QueryEcritureSUMOFCreditSaisie.AsCurrency)+
                ' par rapport � ces �critures pass�es !!! Voulez vous mettre � jour la balance pour ce compte')
                ,'Attention',mb_iconWarning+MB_YESNO+MB_DEFBUTTON2)=mrno then
                   // on verra plus tard avec philippe
                else // si pas ok pour mise � jour
                   begin // si ok pour mise � jour
                   TableBalance.Edit;
                   TableBalance.FindField('Credit_Base').AsCurrency:=QueryEcritureSUMOFCreditSaisie.AsCurrency;
                   TableGerePost(TableBalance);
                   end;
              end; //fin la balance au cr�dit est sup�rieur
           end;//fin il trouve une diff�rence pour le credit
        if TableBalance.FindField('Debit_Base').AsCurrency<>QueryEcritureSUMOFDebitSaisie.AsCurrency then
           begin //s'il trouve une diff�rence pour le Debit
            if TableBalance.FindField('Debit_Base').AsCurrency<QueryEcritureSUMOFDebitSaisie.AsCurrency then
              begin //si la balance au D�bit est inf�rieur
                if Application.Messagebox(Pchar('Le compte '+QueryEcriturecompte.AsString+
                ' de la balance pr�sente, au D�bit, un �cart de -'
                +floattostr(QueryEcritureSUMOFDebitSaisie.AsCurrency-TableBalance.FindField('Debit_Base').AsCurrency)+
                ' par rapport � ces �critures pass�es !!! Voulez vous mettre � jour la balance pour ce compte'),
                'Attention',mb_iconWarning+MB_YESNO+MB_DEFBUTTON2)=mrno then
                   // on verra plus tard avec philippe
                else  // si pas ok pour mise � jour
                   begin // si ok pour mise � jour
                   TableBalance.Edit;
                   TableBalance.FindField('Debit_Base').AsCurrency:=QueryEcritureSUMOFDebitSaisie.AsCurrency;
                   TableGerePost(TableBalance);
                   end;
              end; //fin la balance au cr�dit est inf�rieur
            if TableBalance.FindField('Debit_Base').AsCurrency>QueryEcritureSUMOFDebitSaisie.AsCurrency then
              begin //si la balance au D�bit est sup�rieur
                if Application.Messagebox(Pchar('Le compte '+QueryEcriturecompte.AsString+
                ' de la balance  pr�sente, au D�bit, un �cart de +'+
                floattostr(TableBalance.FindField('Debit_Base').AsCurrency-QueryEcritureSUMOFDebitSaisie.AsCurrency)+
                ' par rapport � ces �critures pass�es !!! Voulez vous mettre � jour la balance pour ce compte'),'Attention',mb_iconWarning+MB_YESNO+MB_DEFBUTTON2)=mrno then
                  // on verra plus tard avec philippe
                else  // si pas ok pour mise � jour
                   begin // si ok pour mise � jour
                   TableBalance.Edit;
                   TableBalance.FindField('Debit_Base').AsCurrency:=QueryEcritureSUMOFDebitSaisie.AsCurrency;
                   TableGerePost(TableBalance);
                   end;
              end; //fin la balance au cr�dit est sup�rieur
           end;//fin il trouve une diff�rence pour le Debit
     end//fin si le compte existe
     else
     begin //si le compte n'existe pas dans la balance
      Application.MessageBox(Pchar('Attention, il y a une erreur importante dans la mise � jour de la balance'),'Attention',MB_ICONERROR);
//      MessageDlg('Attention, il y a une erreur importante dans la mise � jour de la balance',mtError,[mbok],0);
      grosseErreur:=true;
      end;
except
  TableGereRollBack(TableBalance);
  abort;
end;
end;// fin procedure

//******************* TDMBalance.MiseAJourBalanceEntiere *************************
//cette procedure parcours la queryEcriture et fait appel � la procedure
// TraitementMiseAJourBalanceEntiere pour comparer les cr�dits et d�bit
// et d�clenche un traitement en fonction
//********************************************************************
procedure TDMBalance.MiseAJourBalanceEntiere;

begin
QueryEcriture.Close;
//QueryEcriture.ExecSQL;
QueryEcriture.ParamByName('DateDebExo').AsDate:=E.DatExoDebut;
QueryEcriture.Open;
QueryEcriture.First;
QueryEcriture.findfield('compte').AsString;
QueryEcriturecompte.AsString;
while not QueryEcriture.EOF do //parcourt la query jusqu'au dernier enregistrement
  begin //lecture de l'enregistrement courant
  TraitementMiseAJourBalanceEntiere(TaBalance);
  if grosseErreur=true then
  //on verra plus tard avec philippe
    Begin
      abort;
    End
  else
  QueryEcriture.Next;
  end; //fin de boucle, on est sur le dernier enregistrement
//  if grosseErreur=false then
//  TraitementMiseAJourBalanceEntiere;//traitement du dernier enregistrement
//  if grosseErreur=true then
//   //on verra plus tard avec philippe
end;// fin de la procedure


////Cette procedure permet de remettre � jour la balance de l'exercice N+1 tant que
////la cl�ture n'est pas faite.
//procedure TDMBalance.FiltrageBalancePourChangementExo(Filtrage:Tquery);
//begin
//    try
//    InitialisationChampAZero(Filtrage);
//    Filtrage.ExecSQL;
//    except
//    showmessage('Probl�me � l''�criture dans la nouvelle table '+tabalance.TableName);
//    abort;
//    end;//fin du try
//end;
//
//
////Cette procedure permet de remettre � jour la balance de l'exercice N+1 tant que
////la cl�ture n'est pas faite.
//procedure TDMBalance.FiltrageBalancePourBasculageExoSuivant;
//begin
//    try
//    DMBD.BrancheTableVersN1(TaMAJBalanceN1);
//    InitialisationChampAZero(QueryRecup);
//    QueryRecup.ExecSQL;
//      if QueryRecup.RecordCount<>0 then
//      //DMBD.TaParcours.TableName:=tabalance.TableName;
//      //DMBD.TaParcours.Open;
//      TaMAJBalanceN1.Open;
//      while not(QueryRecup.EOF) do
//      begin
//      //Si le compte existe d�j� dans la nouvelle balance
//      if TaMAJBalanceN1.Locate('Compte',QueryRecupCompte.AsString,[])then
//      TaMAJBalanceN1.Edit
//      else
//      TaMAJBalanceN1.Insert;
//      TaMAJBalanceN1.FindField('Compte').AsString:=QueryRecupCompte.AsString;
//      if QueryRecupTotal.AsFloat > 0 then
//      begin
//      TaMAJBalanceN1.FindField('Debit_Report').AsFloat:=QueryRecupTotal.AsFloat;
//      TaMAJBalanceN1.FindField('Qt1_Report').AsFloat:=QueryRecupQtTotal.AsFloat;
//      end;
//      if QueryRecupTotal.AsFloat < 0 then
//      begin
//      TaMAJBalanceN1.FindField('Credit_Report').AsFloat:=QueryRecupTotal.AsFloat;
//      TaMAJBalanceN1.FindField('Qt2_Report').AsFloat:=QueryRecupQtTotal.AsFloat;
//      end;
//      TableGerePost(TaMAJBalanceN1);
//      TaMAJBalanceN1.Next;
//      QueryRecup.Next;
//      end;
//    except
//    showmessage('Probl�me � l''�criture dans la nouvelle table '+TaMAJBalanceN1.Name);
//    abort;
//    end;//fin du try
//end;
//
//
//procedure TDMBalance.InitialisationChampAZero(QueryTmp:Tquery);
//var
//QueryInit:Tquery;
//begin
//   try
//   QueryInit:=tquery.Create(self);
//   QueryInit.DatabaseName:=QueryTmp.DatabaseName;
//   QueryInit.SQL.Add('update Balance.Db  set Debit_Report =0 where Debit_Report is null');
//   QueryInit.ExecSQL;
//   QueryInit.SQL.Clear;
//   QueryInit.SQL.Add('update Balance.Db  set Debit_Base =0 where Debit_Base is null');
//   QueryInit.ExecSQL;
//   QueryInit.SQL.Clear;
//   QueryInit.SQL.Add('update Balance.Db  set Credit_Report =0 where Credit_Report is null');
//   QueryInit.ExecSQL;
//   QueryInit.SQL.Clear;
//   QueryInit.SQL.Add('update Balance.Db  set Credit_Base =0 where Credit_Base is null');
//   QueryInit.ExecSQL;
//   QueryInit.SQL.Clear;
//   QueryInit.SQL.Add('update Balance.Db  set Qt1_Base =0 where Qt1_Base is null');
//   QueryInit.ExecSQL;
//   QueryInit.SQL.Clear;
//   QueryInit.SQL.Add('update Balance.Db  set Qt2_Base =0 where Qt2_Base is null');
//   QueryInit.ExecSQL;
//   QueryInit.SQL.Clear;
//   QueryInit.SQL.Add('update Balance.Db  set Qt1_Report =0 where Qt1_Report is null');
//   QueryInit.ExecSQL;
//   QueryInit.SQL.Clear;
//   QueryInit.SQL.Add('update Balance.Db  set Qt2_Report =0 where Qt2_Report is null');
//   QueryInit.ExecSQL;
//   QueryInit.SQL.Clear;
//   queryInit.SQL.Add('Select * from Balance');
//   queryInit.Open;
//   queryinit.Refresh;
//   queryInit.close;
//   queryinit.Free;
//   except
//   queryinit.Refresh;
//   queryinit.Free;
//   abort;
//   end;
//end;

Function CptExisteDansBalance(cpt:string):boolean;
begin
if DMRech=nil then DMRech:=TDMRech.create(Application.MainForm);
result:=Infos_TInfosBalance(DMRech.TaBalanceRech,'Compte',[cpt]).ResultInfos;
End;


//D�truit Compte dans Balance si tous les champs sont vide
// Retourne vrai si destruction de compte
Function TDMBalance.DetruitCptSiVide(compte:string;Tiers:boolean;BalanceCourante:TTable):boolean;
var
TaBalAux:TTable;
i:integer;
PasValeur:boolean;
begin
result := false;
TaBalAux:=TTable.Create(DMBalance);
TaBalAux.DatabaseName:=BalanceCourante.DatabaseName;
TaBalAux.TableName:=BalanceCourante.TableName;
TaBalAux.Open;
if tiers then
  result := TaBalAux.Locate('Tiers',Compte,[])
else
  result := TaBalAux.Locate('Compte',Compte,[]);
if result then
   begin
    Pasvaleur:=true;
    i:=1;
    while ((Pasvaleur=true) and (IncMaxi(i,TaBalAux.FieldCount - 2))) do
          begin
           Pasvaleur:=empty(TaBalAux.Fields[i].AsString) or (TaBalAux.Fields[i].AsFloat=0);
          end;
    if Pasvaleur=true then TableGereDelete(TaBalAux);
   end;
TaBalAux.Close;
TaBalAux.Free;
end;


//Function TDMBalance.VerifCptSiVide(compte:string):boolean;
//var
//TaBalAux:TTable;
//i:integer;
//PasValeur:boolean;
//begin
//result := false;
//TaBalAux:=TTable.Create(DMBalance);
//TaBalAux.DatabaseName:=DMBalance.TaBalance.DatabaseName;
//TaBalAux.TableName:=DMBalance.TaBalance.TableName;
//TaBalAux.Open;
//if TaBalAux.Locate('Compte',Compte,[])then
//   begin
//    Pasvaleur:=true;
//    i:=0;
//    while ((Pasvaleur=true) and (IncMaxi(i,TaBalAux.FieldCount - 1))) do
//          begin
//           Pasvaleur:=empty(TaBalAux.Fields[i].AsString) or (TaBalAux.Fields[i].AsFloat=0);
//          end;
//    if Pasvaleur=true then result:=true;
//   end
//else//s'il n'existe pas, alors je consid�re qu'il est vide
//   result:=true;
//
//TaBalAux.Close;
//TaBalAux.Free;
//end;


procedure TDMBalance.TaBalanceAfterInsert(DataSet: TDataSet);
begin
TaBalance.SetFields([null,null,0,0,0,0,0,0,0,0,0,0,0,0]);
end;

procedure TDMBalance.MiseAJourSimpleBalance_N_vers_N1(Sens:boolean;Montant:currency;Compte:string;Qt1:real;Qt2:real);
Begin
DMBD.BrancheTableVersN1(TaMAJBalanceN1);
   try
     if not sens then
         begin
         DebCredEcriture:='Debit_Report';
         QteEcriture1:='Qt1_Report';
         QteEcriture2:='Qt2_Report';
         end
     else
          begin
          DebCredEcriture:='Credit_Report';
         QteEcriture1:='Qt1_Report';
         QteEcriture2:='Qt2_Report';
          end;
   DMBalance.MAJBalance_N1_AvecQuantite(false,QteEcriture1,QteEcriture2,DebCredEcriture,compte,
     compte,Qt1,Qt2,Qt1,Qt2,Montant,Montant,dsinsert);
   except
    showmessage('Probl�me lors de la mise � jour de la nouvelle balance d''ouverture');
    TableGereRollBack(TaMAJBalanceN1);
    abort;
   end;//fin du try except
End;


function TDMBalance.MiseAJourGlobalBalance_N_vers_N1(Charges_et_Produits:boolean):boolean;
var
i:integer;
InfosExoN:TInfosGestDossier;
Begin
try
DMBD.BrancheTableVersN1(TaMAJBalanceN1);
result:=true;
 try
  QuDeleteReportN1.close;
  QuDeleteReportN1.sql.clear;
  QuDeleteReportN1.sql.add('update  ::ExoN1::Balance');
  QuDeleteReportN1.sql.add('set Debit_Report = 0,');
  QuDeleteReportN1.sql.add('Credit_Report = 0,');
  QuDeleteReportN1.sql.add('Qt1_Report = 0,');
  QuDeleteReportN1.sql.add('Qt2_Report = 0');
  QuDeleteReportN1.ExecSQL;
  QuDeleteReportN1.close;

  QuMAJBalanceN1.close; //supprime tous les comptes qui n'ont pas de mouvements dans l'ann�e N+1.
  QuMAJBalanceN1.sql.clear;
  QuMAJBalanceN1.sql.add('delete from ::ExoN1::Balance B_N1');
  QuMAJBalanceN1.sql.add('where');
  QuMAJBalanceN1.sql.add('(B_N1.Debit_Base=0 or B_N1.Debit_Base is null)');
  QuMAJBalanceN1.sql.add('and (B_N1.Credit_Base=0 or B_N1.Credit_Base is null)');
  QuMAJBalanceN1.ExecSQL;   //debit_base et credit_base
  QuMAJBalanceN1.close;  //pour pouvoir faire ou refaire la mise � jour des reports de N vers N+1
 except
   abort;
 end;
   If not TaMAJBalanceN1.active then
   TaMAJBalanceN1.open;
//   QuCalculSurPeriode(e.DatExoDebut,e.DatExoFin);
   //r�cup�rer les dates de l'exo N
   InfosExoN:=ChercheInfos_ExoN(e.NomDossier);
//   if DMDiocEtatBal=nil then DMDiocEtatBal:=TDMDiocEtatBal.create(application.MainForm);
//   DMDiocEtatBal.SommeTotauxBalance(InfosExoN.DATE_DEB_EXO,InfosExoN.DATE_FIN_EXO,nil,'');
   DMDiocEtatBal.SommeTotauxBalanceCalc(InfosExoN.DATE_DEB_EXO,InfosExoN.DATE_FIN_EXO,nil,'');

{ isa  le  11/10/04 }
   DMDiocEtatBal.TaBalanceCalc.first;
   while not(DMDiocEtatBal.TaBalanceCalc.eof)do
     Begin
     if Charges_et_Produits then
       Begin
         if not VerifFNumeric(DMDiocEtatBal.TaBalanceCalcSolde_Debit_Total_Calc).VideOUZero then
           MAJBalance_N1_AvecQuantite(false,'Qt1_Report','Qt2_Report','Debit_Report',DMDiocEtatBal.TaBalanceCalccompte.AsString,DMDiocEtatBal.TaBalanceCalccompte.AsString,DMDiocEtatBal.TaBalanceCalcSolde_Qt1_Total_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcSolde_Qt2_Total_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcSolde_Qt1_Total_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcSolde_Qt2_Total_Calc.AsFloat,
           DMDiocEtatBal.TaBalanceCalcSolde_Debit_Total_Calc.AsCurrency,DMDiocEtatBal.TaBalanceCalcSolde_Debit_Total_Calc.AsCurrency,dsinsert)
         else
          if not VerifFNumeric(DMDiocEtatBal.TaBalanceCalcSolde_Credit_Total_Calc).VideOUZero then
           MAJBalance_N1_AvecQuantite(false,'Qt1_Report','Qt2_Report','Credit_Report',DMDiocEtatBal.TaBalanceCalccompte.AsString,DMDiocEtatBal.TaBalanceCalccompte.AsString,DMDiocEtatBal.TaBalanceCalcSolde_Qt1_Total_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcSolde_Qt2_Total_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcSolde_Qt1_Total_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcSolde_Qt2_Total_Calc.AsFloat,
           DMDiocEtatBal.TaBalanceCalcSolde_Credit_Total_Calc.AsCurrency,DMDiocEtatBal.TaBalanceCalcSolde_Credit_Total_Calc.AsCurrency,dsinsert)
       End
     else
       Begin
         //if ((not(copy(DMDiocEtatBal.TaBalanceCalccompte.Asstring,1,1)='6')) and (not(copy(DMDiocEtatBal.TaBalanceCalccompte.Asstring,1,1)='7')) and (not(copy(DMDiocEtatBal.TaBalanceCalccompte.Asstring,1,2)='12'))) then
         //enlever '12*' le 01/08/03 par isa car dans dos le compte 120 est report� dans la balance d'ouverture
         if ((not(copy(DMDiocEtatBal.TaBalanceCalccompte.Asstring,1,1)='6')) and (not(copy(DMDiocEtatBal.TaBalanceCalccompte.Asstring,1,1)='7'))) then
           begin
      //   Mise � jour balance pour tous les comptes  sauf 6 et 7
             if not VerifFNumeric(DMDiocEtatBal.TaBalanceCalcSolde_Debit_Total_Calc).VideOUZero then
               MAJBalance_N1_AvecQuantite(false,'Qt1_Report','Qt2_Report','Debit_Report',DMDiocEtatBal.TaBalanceCalccompte.AsString,DMDiocEtatBal.TaBalanceCalccompte.AsString,DMDiocEtatBal.TaBalanceCalcQt1_Total_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcQt2_Total_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcQt1_Total_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcQt2_Total_Calc.AsFloat,
               DMDiocEtatBal.TaBalanceCalcSolde_Debit_Total_Calc.AsCurrency,DMDiocEtatBal.TaBalanceCalcSolde_Debit_Total_Calc.AsCurrency,dsinsert)
             else
              if not VerifFNumeric(DMDiocEtatBal.TaBalanceCalcSolde_Credit_Total_Calc).VideOUZero then
               MAJBalance_N1_AvecQuantite(false,'Qt1_Report','Qt2_Report','Credit_Report',DMDiocEtatBal.TaBalanceCalccompte.AsString,DMDiocEtatBal.TaBalanceCalccompte.AsString,DMDiocEtatBal.TaBalanceCalcQt1_Total_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcQt2_Total_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcQt1_Total_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcQt2_Total_Calc.AsFloat,
               DMDiocEtatBal.TaBalanceCalcSolde_Credit_Total_Calc.AsCurrency,DMDiocEtatBal.TaBalanceCalcSolde_Credit_Total_Calc.AsCurrency,dsinsert)
           end;
       End;
     tablegerecommit(TaMAJBalanceN1);
     DMDiocEtatBal.TaBalanceCalc.next;
     End;
{ isa  le  11/10/04 }

//   DMDiocEtatBal.TaBalanceaffich.first;
//   while not(DMDiocEtatBal.TaBalanceaffich.eof)do
//     Begin
//     if Charges_et_Produits then
//       Begin
//         if not VerifFNumeric(DMDiocEtatBal.TaBalanceaffichSolde_Debit_Total_Calc).VideOUZero then
//           MAJBalance_N1(false,'Qt1_Report','Debit_Report',DMDiocEtatBal.TaBalanceaffichcompte.AsString,DMDiocEtatBal.TaBalanceaffichcompte.AsString,0,0,
//           DMDiocEtatBal.TaBalanceaffichSolde_Debit_Total_Calc.AsCurrency,DMDiocEtatBal.TaBalanceaffichSolde_Debit_Total_Calc.AsCurrency,dsinsert)
//         else
//          if not VerifFNumeric(DMDiocEtatBal.TaBalanceaffichSolde_Credit_Total_Calc).VideOUZero then
//           MAJBalance_N1(false,'Qt2_Report','Credit_Report',DMDiocEtatBal.TaBalanceaffichcompte.AsString,DMDiocEtatBal.TaBalanceaffichcompte.AsString,0,0,
//           DMDiocEtatBal.TaBalanceaffichSolde_Credit_Total_Calc.AsCurrency,DMDiocEtatBal.TaBalanceaffichSolde_Credit_Total_Calc.AsCurrency,dsinsert);
//       End
//     else
//       Begin
//         //if ((not(copy(DMDiocEtatBal.TaBalanceaffichcompte.Asstring,1,1)='6')) and (not(copy(DMDiocEtatBal.TaBalanceaffichcompte.Asstring,1,1)='7')) and (not(copy(DMDiocEtatBal.TaBalanceaffichcompte.Asstring,1,2)='12'))) then
//         //enlever '12*' le 01/08/03 par isa car dans dos le compte 120 est report� dans la balance d'ouverture
//         if ((not(copy(DMDiocEtatBal.TaBalanceaffichcompte.Asstring,1,1)='6')) and (not(copy(DMDiocEtatBal.TaBalanceaffichcompte.Asstring,1,1)='7'))) then
//           begin
//      //   Mise � jour balance pour tous les comptes  sauf 6 et 7
//             if not VerifFNumeric(DMDiocEtatBal.TaBalanceaffichSolde_Debit_Total_Calc).VideOUZero then
//               MAJBalance_N1(false,'Qt1_Report','Debit_Report',DMDiocEtatBal.TaBalanceaffichcompte.AsString,DMDiocEtatBal.TaBalanceaffichcompte.AsString,0,0,
//               DMDiocEtatBal.TaBalanceaffichSolde_Debit_Total_Calc.AsCurrency,DMDiocEtatBal.TaBalanceaffichSolde_Debit_Total_Calc.AsCurrency,dsinsert)
//             else
//              if not VerifFNumeric(DMDiocEtatBal.TaBalanceaffichSolde_Credit_Total_Calc).VideOUZero then
//               MAJBalance_N1(false,'Qt2_Report','Credit_Report',DMDiocEtatBal.TaBalanceaffichcompte.AsString,DMDiocEtatBal.TaBalanceaffichcompte.AsString,0,0,
//               DMDiocEtatBal.TaBalanceaffichSolde_Credit_Total_Calc.AsCurrency,DMDiocEtatBal.TaBalanceaffichSolde_Credit_Total_Calc.AsCurrency,dsinsert);
//           end;
//       End;
//     DMDiocEtatBal.TaBalanceaffich.next;
//     End;
TableGereCommit(TaMAJBalanceN1);
except
  result:=false;
  abort;
end;
End;


function TDMBalance.VerifEquilibreBalanceN:TErreurSaisie;
var
listeCptBalance:Tstringlist;
TotauxBalance:TTotauxBalance;
i:integer;
Begin
try//finally
try//except
listeCptBalance:=Tstringlist.Create;
//g�rer les comptes de 1 � 7 (soit toute la balance)
for i:=1 to 7 do
listeCptBalance.Add(inttostr(i)+'*');
TotauxBalance:=DMDiocEtatBal.SommeTotauxBalanceCalc(E.DatExoDebut,E.DatExoFin,listeCptBalance,'Compte');
result.retour:=TotauxBalance.SoldeFin=0;
if not result.retour then
  begin
    if ((TotauxBalance.SoldeReport<>0)and(TotauxBalance.SoldeBase=0)) then
      result.CodeErreur:=7002
    else
      result.CodeErreur:=7001;
  end;
except
  result.retour:=false;
  showmessage('Probl�me lors du contr�le de l''�quilibre de la balance ');
  abort;
end;//fin du except
finally
  if listeCptBalance<>nil then listeCptBalance.Free;
end;//fin du finally
End;



procedure TDMBalance.QuBalanceAffichFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
//if not((csDestroying)in dataset.ComponentState) then
//Accept:=length(QuBalanceAffich.findfield('Compte').AsString) > 4;
end;



function TDMBalance.MiseAJourDuResultatDansN1(confirmation : Boolean):TExceptLGR;
var
ListeCptResultat:TStringList;  { d�clarer la liste }
TotauxBalance6_7,TotauxBalance1_5:TTotauxBalance;
CompteResult:TInfos_Piece;
InfosGestDossier:TInfosGestDossier;
DateDebTmp,DateFinTmp:Tdate;
begin
  try
    try//except
      result.retour:=VerifSoldeBalanceN_N1;
      //sauve la configuration avant contr�le
      DateDebTmp:=E.DatExoDebut;
      DateFinTmp:=E.DatExoFin;
      if not result.retour then
        begin
          result.Mess:='La balance de fin de l''exercice de base ne correspond pas � la balance d''ouverture du nouvel exercice';
          showmessage(result.Mess);
          abort;
        end;
      ListeCptResultat:= TStringList.Create;  { construire l'objet liste }
      //g�rer les comptes de 6 � 7
      ListeCptResultat.Add('6*');
      ListeCptResultat.Add('7*');

      //calcul du r�sultat � partir de la liste des comptes  (ici les comptes 6 et 7) sur N
      InfosGestDossier:=ChercheInfos_ExoN(e.NomDossier);
      E.DatExoDebut:=InfosGestDossier.DATE_DEB_EXO;
      E.DatExoFin:=InfosGestDossier.DATE_FIN_EXO;
      TotauxBalance6_7:=DMDiocEtatBal.SommeTotauxBalanceCalc(E.DatExoDebut,E.DatExoFin,ListeCptResultat,'Compte');

    if (TotauxBalance6_7.soldefin) <> 0 then
       begin //s'il y a un r�sultat � reporter
          CompteResult:=AffichResultat(Cloture_Def,TotauxBalance6_7,confirmation);
          if CompteResult.Retour then
            Begin
              if not empty(CompteResult.Compte) then
                Begin//mettre � jour la balance des reports de N+1
                   MiseAJourSimpleBalance_N_vers_N1(not(TotauxBalance6_7.SoldeDebitCreditFin),TotauxBalance6_7.soldefin,CompteResult.Compte);
                   TableGereCommit(TaMAJBalanceN1);
                end
              else
                abort;
            end
          else
            abort;
       End;//fin s'il y a un r�sultat � reporter
    except
       result.retour:=false;
    end;//fin du except
  finally
      ListeCptResultat.free;
      //Restaure la configuration avant contr�le
       E.DatExoDebut:=DateDebTmp;
       E.DatExoFin:=DateFinTmp;
  end;//fin du finally
end;

function TDMBalance.VerifSoldeBalanceN_N1:boolean;
var
TotauxBalanceN,TotauxBalanceN1:TTotauxBalance;
ListeCptResultat:TStringList;  { d�clarer la liste }
i:integer;
InfosGestDossier:TInfosGestDossier;
DateDebTmp,DateFinTmp:Tdate;
Begin
try//finally
  try//except
  result:=true;
  ListeCptResultat:= TStringList.Create;  { construire l'objet liste }
  //sauve la configuration avant contr�le
  DateDebTmp:=E.DatExoDebut;
  DateFinTmp:=E.DatExoFin;
  for i:=1 to 5 do
  ListeCptResultat.Add(inttostr(i)+'*');

  if DMBD.BrancheTableVersN(DMDiocEtatBal.TaBalanceCalc)=false then abort;
  InfosGestDossier:=ChercheInfos_ExoN(e.NomDossier);
  E.DatExoDebut:=InfosGestDossier.DATE_DEB_EXO;
  E.DatExoFin:=InfosGestDossier.DATE_FIN_EXO;
  TotauxBalanceN:=DMDiocEtatBal.SommeTotauxBalanceCalc(E.DatExoDebut,E.DatExoFin,ListeCptResultat,'Compte');

    //v�rifie si balance N fin = balance N+1 report
 if (DMBD.BrancheTableVersN1(DMDiocEtatBal.TaBalanceCalc)=false)then abort;

  InfosGestDossier:=ChercheInfos_ExoN1(e.NomDossier);
   E.DatExoDebut:=InfosGestDossier.DATE_DEB_EXO;
   E.DatExoFin:=InfosGestDossier.DATE_FIN_EXO;
  TotauxBalanceN1:=DMDiocEtatBal.SommeTotauxBalanceCalc(E.DatExoDebut,E.DatExoFin,ListeCptResultat,'Compte');

  result:=((TotauxBalanceN.SoldeFin=TotauxBalanceN1.SoldeReport)and(TotauxBalanceN.SoldeDebitCreditFin=TotauxBalanceN1.SoldeDebitCreditReport));
  except//except
    result:=false;
  end;
finally//finally
  //Restaure la configuration avant contr�le
   E.DatExoDebut:=DateDebTmp;
   E.DatExoFin:=DateFinTmp;
   DMBD.BrancheTableVersN(DMDiocEtatBal.TaBalanceCalc);
end;
end;





function TDMBalance.MiseAJourGlobalBalanceTiers_N_vers_N1:boolean;
var
i:integer;
InfosExoN:TInfosGestDossier;
Begin
try
result:=true;
 try //supprime tous les comptes qui n'ont pas de mouvements dans l'ann�e N+1.

     DMBD.BrancheTableVersN1(TaMAJBalanceTiersN1);

   //d�plac� le 24/08/2011
   InfosExoN:=ChercheInfos_ExoN(e.NomDossier);
   if(InfosExoN.ResultInfos=false)then abort;

   If not TaMAJBalanceTiersN1.active then
   TaMAJBalanceTiersN1.open;
   //d�plac� le 24/08/2011

  QuDeleteReportN1.close;
  QuDeleteReportN1.sql.clear;
  QuDeleteReportN1.sql.add('update  ::ExoN1::BalanceTiers ');
  QuDeleteReportN1.sql.add('set Debit_Report = 0,');
  QuDeleteReportN1.sql.add('Credit_Report = 0');
  QuDeleteReportN1.ExecSQL;
  QuDeleteReportN1.close;

  QuMAJBalanceN1.close;
  QuMAJBalanceN1.sql.clear;
  QuMAJBalanceN1.sql.add('delete from ::ExoN1::BalanceTiers ');
  QuMAJBalanceN1.sql.add('where');
  QuMAJBalanceN1.sql.add('(Debit_Base=0 or Debit_Base is null)');
  QuMAJBalanceN1.sql.add('and (Credit_Base=0 or Credit_Base is null)');
  QuMAJBalanceN1.ExecSQL;   //debit_base et credit_base
  QuMAJBalanceN1.close;  //pour pouvoir faire ou refaire la mise � jour des reports de N vers N+1
 except
   abort;
 end;
//   QuCalculSurPeriode(e.DatExoDebut,e.DatExoFin);
   //r�cup�rer les dates de l'exo N
//   if DMDiocEtatBal=nil then DMDiocEtatBal:=TDMDiocEtatBal.create(application.MainForm);
//   DMDiocEtatBalT.SommeTotauxBalanceT(InfosExoN.DATE_DEB_EXO,InfosExoN.DATE_FIN_EXO,nil,'');

//rajoute le 24/08/2011
DeFiltrageDataSet(DMDiocEtatBalT.TaBalanceaffichT);
DeFiltrageDataSet(DMDiocEtatBalT.TaBalanceCalcT);
//rajoute le 24/08/2011


//   InfosExoN:=ChercheInfos_ExoN(e.NomDossier);
//   if(InfosExoN.ResultInfos=false)then abort;
//
//   If not TaMAJBalanceTiersN1.active then
//   TaMAJBalanceTiersN1.open

   DMDiocEtatBalT.SommeTotauxBalanceTCalc(InfosExoN.DATE_DEB_EXO,InfosExoN.DATE_FIN_EXO,nil,'',true);

{ isa  le  11/10/04 }
   DMDiocEtatBalT.TaBalanceCalcT.first;
   while not(DMDiocEtatBalT.TaBalanceCalcT.eof)do
     Begin
       if not VerifFNumeric(DMDiocEtatBalT.TaBalanceCalcTSolde_Debit_Total_Calc).VideOUZero then
         MAJBalanceDesTiers_N1(false,'Qt1_Report','Debit_Report',DMDiocEtatBalT.TaBalanceCalcTTiers.AsString,DMDiocEtatBalT.TaBalanceCalcTcompte.AsString,DMDiocEtatBalT.TaBalanceCalcTTiers.AsString,0,0,
         DMDiocEtatBalT.TaBalanceCalcTSolde_Debit_Total_Calc.AsCurrency,DMDiocEtatBalT.TaBalanceCalcTSolde_Debit_Total_Calc.AsCurrency,dsinsert)
       else
        if not VerifFNumeric(DMDiocEtatBalT.TaBalanceCalcTSolde_Credit_Total_Calc).VideOUZero then
         MAJBalanceDesTiers_N1(false,'Qt2_Report','Credit_Report',DMDiocEtatBalT.TaBalanceCalcTTiers.AsString,DMDiocEtatBalT.TaBalanceCalcTcompte.AsString,DMDiocEtatBalT.TaBalanceCalcTTiers.AsString,0,0,
         DMDiocEtatBalT.TaBalanceCalcTSolde_Credit_Total_Calc.AsCurrency,DMDiocEtatBalT.TaBalanceCalcTSolde_Credit_Total_Calc.AsCurrency,dsinsert);
       DMDiocEtatBalT.TaBalanceCalcT.next;
     End;//   DMDiocEtatBalT.TaBalanceaffichT.first;
{ isa  le  11/10/04 }

//   while not(DMDiocEtatBalT.TaBalanceaffichT.eof)do
//     Begin
//       if not VerifFNumeric(DMDiocEtatBalT.TaBalanceaffichTSolde_Debit_Total_Calc).VideOUZero then
//         MAJBalanceDesTiers_N1(false,'Qt1_Report','Debit_Report',DMDiocEtatBalT.TaBalanceaffichTTiers.AsString,DMDiocEtatBalT.TaBalanceaffichTcompte.AsString,DMDiocEtatBalT.TaBalanceaffichTTiers.AsString,0,0,
//         DMDiocEtatBalT.TaBalanceaffichTSolde_Debit_Total_Calc.AsCurrency,DMDiocEtatBalT.TaBalanceaffichTSolde_Debit_Total_Calc.AsCurrency,dsinsert)
//       else
//        if not VerifFNumeric(DMDiocEtatBalT.TaBalanceaffichTSolde_Credit_Total_Calc).VideOUZero then
//         MAJBalanceDesTiers_N1(false,'Qt2_Report','Credit_Report',DMDiocEtatBalT.TaBalanceaffichTTiers.AsString,DMDiocEtatBalT.TaBalanceaffichTcompte.AsString,DMDiocEtatBalT.TaBalanceaffichTTiers.AsString,0,0,
//         DMDiocEtatBalT.TaBalanceaffichTSolde_Credit_Total_Calc.AsCurrency,DMDiocEtatBalT.TaBalanceaffichTSolde_Credit_Total_Calc.AsCurrency,dsinsert);
//       DMDiocEtatBalT.TaBalanceaffichT.next;
//     End;

TableGereCommit(TaMAJBalanceTiersN1);
except
  TableGereRollBack(TaMAJBalanceTiersN1);
  result:=false;
  abort;
end;
End;


Procedure TDMBalance.MAJBalanceDesTiers_N1(DelRec:Boolean;Quantite,DebitCredit,Tiers,Compte,
OldTiers:string ; Qte,OldQte:Double ; Ptotal,OldPtotal:currency ;Etat:TDataSetState);

begin
try
 //Controle si le compte existe dans la balance
    TableGereStartTransaction(TaMAJBalanceTiersN1);
    if not delrec then
      begin//si ajout ou modif
        if ((empty(Tiers))or (empty(compte)))then abort;
        If TaMAJBalanceTiersN1.Locate('Tiers',Tiers,[loCaseInsensitive]) Then
           begin //le compte existe dans la balance
               case Etat of              // Etat de la table source
                    dsInsert:begin // Etat insertion
                             TaMAJBalanceTiersN1.Edit; // Mise a jour de la balance
                             TaMAJBalanceTiersN1.FieldByName(DebitCredit).AsCurrency := TaMAJBalanceTiersN1.FieldByName(DebitCredit).AsCurrency + Ptotal;
                             TaMAJBalanceTiersN1.FieldByName(Quantite).AsFloat := TaMAJBalanceTiersN1.FieldByName(Quantite).AsFloat+ Qte;
                             TableGerePost(TaMAJBalanceTiersN1);
                             end ;//fin Etat insertion
                    dsEdit  :begin//Etat modification
                             if Tiers=OldTiers then
                               begin //Si le compte n'est pas modifi�
                               TaMAJBalanceTiersN1.Edit;          // Mise a jour de la balance
                               TaMAJBalanceTiersN1.FieldByName(DebitCredit).AsCurrency := TaMAJBalanceTiersN1.FieldByName(DebitCredit).AsCurrency - OldPtotal + Ptotal;
                               TaMAJBalanceTiersN1.FieldByName(Quantite).AsFloat := TaMAJBalanceTiersN1.FieldByName(Quantite).AsFloat - OldQte + Qte;
                               TableGerePost(TaMAJBalanceTiersN1);
                               end //Fin le compte n'est pas modifi�
                               else //Si le compte est modifi�
                               begin
                                     begin // Nouveau Compte Trouv�
                                     TaMAJBalanceTiersN1.Edit;
                                     TaMAJBalanceTiersN1.FieldByName(DebitCredit).AsCurrency := TaMAJBalanceTiersN1.FieldByName(DebitCredit).AsCurrency  + Ptotal;
                                     TaMAJBalanceTiersN1.FieldByName(Quantite).AsFloat := TaMAJBalanceTiersN1.FieldByName(Quantite).AsFloat + Qte;
                                     TableGerePost(TaMAJBalanceTiersN1);
                                     end; // Fin Nouveau Compte Trouv�
                                     If TaMAJBalanceTiersN1.Locate('Tiers',OldTiers,[loCaseInsensitive]) Then
                                       begin // vieux Compte Trouv�
                                       TaMAJBalanceTiersN1.Edit;       // Mise a jour de la balance
                                       TaMAJBalanceTiersN1.FieldByName(DebitCredit).AsCurrency := TaMAJBalanceTiersN1.FieldByName(DebitCredit).AsCurrency - OldPtotal ;//+ Ptotal;
                                       TaMAJBalanceTiersN1.FieldByName(Quantite).AsFloat := TaMAJBalanceTiersN1.FieldByName(Quantite).AsFloat - OldQte  ;//+ Qte;
                                       TableGerePost(TaMAJBalanceTiersN1);
                                       DetruitCptSiVide(OldTiers,true,TaMAJBalanceTiersN1);
                                       end // fin vieux Compte Trouv�
                                    else // vieux Compte n'est pas trouv� PROBLEME
                                       begin
                                       Application.MessageBox(Pchar('Probl�me dans la mise a jour de la balance !!!'),'Attention',MB_ICONWARNING);
                                       //Messagedlg('Probl�me dans la mise a jour de la balance !!!',MtWarning,[mbok],0);
                                      // Screen.Cursors[crNone];
                                       abort;
                                       end; // fin vieux Compte n'est pas trouv� PROBLEME
                                       // Si le compte est modifi� recherche le nouveau compte
                                       //pour y faire la mise � jour
                               end;// fin compte est modifi�
                             end;// fin etat modification
               end;  //fin case.Etat
           end //Fin le compte existe dans la balance
           else
           begin // Compte non trouv� dans la balance
               case Etat of // Etat de la table source
                    dsInsert:begin // Etat insertion
                             TaMAJBalanceTiersN1.Insert;  //enregistrement nouveau compte balance
                             TaMAJBalanceTiersN1.FindField('Tiers').AsString:= tiers;
                             TaMAJBalanceTiersN1.FindField('Compte').AsString:= compte;
                             TaMAJBalanceTiersN1.FieldByName(DebitCredit).AsCurrency := Ptotal;
                             TaMAJBalanceTiersN1.FieldByName(Quantite).AsFloat := Qte;
                             TableGerePost(TaMAJBalanceTiersN1);
                             end; // Fin Etat insertion
                    dsEdit:  begin // Etat modification
                             TaMAJBalanceTiersN1.Insert;  //enregistrement nouveau compte balance
                             TaMAJBalanceTiersN1.FindField('Tiers').AsString:= tiers;
                             TaMAJBalanceTiersN1.FindField('Compte').AsString:= compte;
                             TaMAJBalanceTiersN1.FieldByName(DebitCredit).AsCurrency := Ptotal;
                             TaMAJBalanceTiersN1.FieldByName(Quantite).AsFloat := Qte;
                             TableGerePost(TaMAJBalanceTiersN1);
                              If TaMAJBalanceTiersN1.Locate('Tiers',Oldtiers,[loCaseInsensitive]) Then
                                 begin  // si vieux Compte Trouv�
                                 TaMAJBalanceTiersN1.Edit; //on modifie le prix et la quantit�
                                 TaMAJBalanceTiersN1.FieldByName(DebitCredit).AsCurrency := TaMAJBalanceTiersN1.FieldByName(DebitCredit).AsCurrency - OldPtotal ;//+ Ptotal;
                                 TaMAJBalanceTiersN1.FieldByName(Quantite).AsFloat := TaMAJBalanceTiersN1.FieldByName(Quantite).AsFloat - OldQte  ;//+ Qte;
                                 TableGerePost(TaMAJBalanceTiersN1);
                                 DetruitCptSiVide(Oldtiers,true,TaMAJBalanceTiersN1);
                                 end
                                 else // si vieux Compte n'est pas Trouv�
                                 begin
                                 Application.MessageBox(Pchar('Probl�me dans la mise a jour de la balance !!!'),'Attention',MB_ICONWARNING);
                                 //Messagedlg('Probl�me dans la mise a jour de la balance !!!',MtWarning,[mbok],0);
    //                             Screen.Cursors[crNone];
                                 abort;
                                 end; // Fin vieux Compte n'est pas Trouv�
                             end;// fin Etat modification
               end; //fin case.ETat
           end;//fin compte non trouve dans balance
      end//fin si ajout ou modif
     else
           begin // si suppression d'un enregistrement
              if empty(Oldtiers)then abort;
              if TaMAJBalanceTiersN1.Locate('Tiers',Oldtiers,[loCaseInsensitive]) Then // Efface un enregistrement
              begin       // si trouve compte dans la balance
              TaMAJBalanceTiersN1.Edit; //modification du prix et de la quantit�
              TaMAJBalanceTiersN1.FieldByName(DebitCredit).AsCurrency := TaMAJBalanceTiersN1.FieldByName(DebitCredit).AsCurrency - OldPtotal ;
              TaMAJBalanceTiersN1.FieldByName(Quantite).AsFloat := TaMAJBalanceTiersN1.FieldByName(Quantite).AsFloat - OldQte ;
              TableGerePost(TaMAJBalanceTiersN1);
              DetruitCptSiVide(Oldtiers,true,TaMAJBalanceTiersN1);
              DelRec:=False;
              end  // fin trouve compte dans la balance
              else
              begin //Si le compte n'est pas trouv� PROBLEME
              Application.MessageBox(Pchar('Probl�me dans la mise a jour de la balance !!!'),'Attention',MB_ICONWARNING);
              //Messagedlg('Probl�me dans la mise a jour de la balance !!!' + TaMAJBalanceTiersN1.findfield('Tiers').AsString,MtWarning,[mbok],0);
              TableGereRollBack(TaMAJBalanceTiersN1);
              abort;
              end;
           end;// Fin suppression d'un enregistrement
//        Screen.Cursors[crNone];
TableGereCommit(TaMAJBalanceTiersN1);
except
  TableGereRollBack(TaMAJBalanceTiersN1);
  abort;
end;
end;


Function TDMBalance.RetourneSoldeCompteAvantReprise(Compte:string;DatasetEnCours:TDataset;MontantReprise:Currency;Sens:string):TSoldeCompte;
begin
  try
    initialise_TSoldeCompte(result);
    result.ListeSolde:=TStringList.Create;
    
    ////V�rif charges ou produits
    result.SoldeCharge:=RecupSoldeCompte(Compte,DatasetEnCours,MontantReprise,Sens);
    if result.SoldeCharge.Retour then
     begin
      if result.SoldeCharge.SensTotal=-1 then//solde au d�bit
        result.ListeSolde.Add(uppercase((DatasetEnCours as TTable).TableName)+';'+Compte+';'+currtostr(result.SoldeCharge.Total)+';0;')
      else //solde au cr�dit
        result.ListeSolde.Add(uppercase((DatasetEnCours as TTable).TableName)+';'+Compte+';0;'+currtostr(result.SoldeCharge.Total)+';');
     end;
    ////// v�rif balance
    result.SoldeBalance:=DMDiocEtatBal.VerifSoldeCompteDansBalance(compte);
    if result.SoldeBalance.Retour then
     begin
      if result.SoldeBalance.SensTotal=-1 then//solde au d�bit
        result.ListeSolde.Add('BALANCE;'+Compte+';'+currtostr(result.SoldeBalance.Total)+';0;')
      else //solde au cr�dit
        result.ListeSolde.Add('BALANCE;'+Compte+';0;'+currtostr(result.SoldeBalance.Total)+';');
     end;
    ////V�rif BO
    result.SoldeBo:=DMPlan.VerifSoldeCompteDansBO(compte);
    if result.SoldeBo.Retour then
     begin
      if result.SoldeBo.SensTotal=-1 then//solde au d�bit
        result.ListeSolde.Add('BILAN OUVERTURE;'+Compte+';'+currtostr(result.SoldeBo.Total)+';0;')
      else //solde au cr�dit
        result.ListeSolde.Add('BILAN OUVERTURE;'+Compte+';0;'+currtostr(result.SoldeBo.Total)+';');
     end;
  except
     initialise_TSoldeCompte(result);
  end;
end;


function TDMBalance.RecupSoldeCompte(Compte:string;DatasetEnCours:TDataset;RepriseEnCours:currency;Sens:string):Tcalcul;
begin
  try//except
    if ((DatasetEnCours=nil)or(not(DatasetEnCours is TTable))) then abort;
    initialise_TCalcul(result);
    QuSoldeCompte.Close;
    QuSoldeCompte.SQL.clear;
case IndexTableEpicea((DatasetEnCours as TTable).TableName)of
  302:begin /// V�rif sur ChargesRepartir
        QuSoldeCompte.SQL.add('select (sum(MtBilanOuverture))as MontantRestant');
        QuSoldeCompte.SQL.add(' from ChargesRepartir.DB where compte=:Cpt and DateSaisie='''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
      end;
  301:begin /// V�rif sur ChargeAPayer                                               
        QuSoldeCompte.SQL.add('select sum(MontantHT)as MontantRestant ,sum(Tva)as TVA');
        QuSoldeCompte.SQL.add(' from ChargeAPayer.DB where compte=:Cpt and DateSaisie='''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
        QuSoldeCompte.SQL.add('and Sens='''+Sens+'''');
      end;
  308:begin/// V�rif sur PCA
        QuSoldeCompte.SQL.add('select sum(MontantHT)as MontantRestant');
        QuSoldeCompte.SQL.add(' from PCA.DB where compte=:Cpt and DateSaisie='''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
        QuSoldeCompte.SQL.add('and Sens='''+Sens+'''');
      end;
  309:begin/// V�rif sur Provisions
        QuSoldeCompte.SQL.add(' select (sum(MtBilanOuverture))as MontantRestant');
        QuSoldeCompte.SQL.add(' from Provisions.DB where compte=:Cpt and DateSaisie='''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
      end;
  310:begin /// V�rif sur Stocks
        QuSoldeCompte.SQL.add('select (Sum(MontantTotalHT))as MontantRestant');
        QuSoldeCompte.SQL.add(' from Stock.DB where compte=:Cpt and Date_Saisie='''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
      end;
end;//fin du case
    QuSoldeCompte.ParamByName('Cpt').asstring:=compte;
    QuSoldeCompte.open;

    result.Retour:=QuSoldeCompte.recordcount<>0;
    if result.retour then
     begin
       if IndexTableEpicea((DatasetEnCours as TTable).TableName)=301 then
         result.Total:=QuSoldeCompte.findfield('MontantRestant').ascurrency+QuSoldeCompte.findfield('TVA').ascurrency+RepriseEnCours
       else
         result.Total:=QuSoldeCompte.findfield('MontantRestant').ascurrency+RepriseEnCours;
       if sens='D' then
         result.SensTotal:=-1
       else
         result.SensTotal:=1;
     end;
  except
    result.Retour:=false;
  end;//fin except
end;

function TDMBalance.MiseAJourGlobalBalance_N(RepertoireExocourant:string;DateDeb,DateFin:Tdatetime;Charges_et_Produits:boolean):boolean;
var
i:integer;
InfosExoN:TInfosGestDossier;
Begin
try
result:=true;
 try
  QuDeleteReportN1.close;
  QuDeleteReportN1.sql.clear;
  QuDeleteReportN1.sql.add('update "'+RepertoireExocourant+'Balance"');
  QuDeleteReportN1.sql.add('set Debit_Report = 0,');
  QuDeleteReportN1.sql.add('Credit_Report = 0,');
  QuDeleteReportN1.sql.add('Qt1_Report = 0,');
  QuDeleteReportN1.sql.add('Qt2_Report = 0');
  QuDeleteReportN1.ExecSQL;
  QuDeleteReportN1.close;
 except
   abort;
 end;
   If not TaBalance.active then
   TaBalance.open;
   DMDiocEtatBal.SommeTotauxBalanceCalc(DateDeb,DateFin,nil,'');

{ isa  le  11/10/04 }
   DMDiocEtatBal.TaBalanceCalc.first;
   while not(DMDiocEtatBal.TaBalanceCalc.eof)do
     Begin
         if ((not(copy(DMDiocEtatBal.TaBalanceCalccompte.Asstring,1,1)='6')) and (not(copy(DMDiocEtatBal.TaBalanceCalccompte.Asstring,1,1)='7'))) then
           begin
      //   Mise � jour balance pour tous les comptes  sauf 6 et 7
             if not VerifFNumeric(DMDiocEtatBal.TaBalanceCalcSolde_Debit_Report_Calc).VideOUZero then
               MAJBalance_AvecQuantite(false,'Qt1_Report','Qt2_Report','Debit_Report',DMDiocEtatBal.TaBalanceCalccompte.AsString,DMDiocEtatBal.TaBalanceCalccompte.AsString,DMDiocEtatBal.TaBalanceCalcQt1_Report_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcQt2_Report_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcQt1_Report_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcQt2_Report_Calc.AsFloat,
               DMDiocEtatBal.TaBalanceCalcSolde_Debit_Report_Calc.AsCurrency,DMDiocEtatBal.TaBalanceCalcSolde_Debit_Report_Calc.AsCurrency,dsinsert)
             else
              if not VerifFNumeric(DMDiocEtatBal.TaBalanceCalcSolde_Credit_Report_Calc).VideOUZero then
               MAJBalance_AvecQuantite(false,'Qt1_Report','Qt2_Report','Credit_Report',DMDiocEtatBal.TaBalanceCalccompte.AsString,DMDiocEtatBal.TaBalanceCalccompte.AsString,DMDiocEtatBal.TaBalanceCalcQt1_Report_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcQt2_Report_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcQt1_Report_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcQt2_Report_Calc.AsFloat,
               DMDiocEtatBal.TaBalanceCalcSolde_Credit_Report_Calc.AsCurrency,DMDiocEtatBal.TaBalanceCalcSolde_Credit_Report_Calc.AsCurrency,dsinsert)
           end;

         if ((not(copy(DMDiocEtatBal.TaBalanceCalccompte.Asstring,1,1)='6')) and (not(copy(DMDiocEtatBal.TaBalanceCalccompte.Asstring,1,1)='7'))) then
           begin
      //   Mise � jour balance pour tous les comptes  sauf 6 et 7
             if not VerifFNumeric(DMDiocEtatBal.TaBalanceCalcSolde_Debit_Base_Calc).VideOUZero then
               MAJBalance_AvecQuantite(false,'Qt1_Base','Qt2_Base','Debit_Base',DMDiocEtatBal.TaBalanceCalccompte.AsString,DMDiocEtatBal.TaBalanceCalccompte.AsString,DMDiocEtatBal.TaBalanceCalcQt1_Base_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcQt2_Base_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcQt1_Base_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcQt2_Base_Calc.AsFloat,
               DMDiocEtatBal.TaBalanceCalcSolde_Debit_Base_Calc.AsCurrency,DMDiocEtatBal.TaBalanceCalcSolde_Debit_Base_Calc.AsCurrency,dsinsert)
             else
              if not VerifFNumeric(DMDiocEtatBal.TaBalanceCalcSolde_Credit_Base_Calc).VideOUZero then
               MAJBalance_AvecQuantite(false,'Qt1_Base','Qt2_Base','Credit_Base',DMDiocEtatBal.TaBalanceCalccompte.AsString,DMDiocEtatBal.TaBalanceCalccompte.AsString,DMDiocEtatBal.TaBalanceCalcQt1_Base_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcQt2_Base_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcQt1_Base_Calc.AsFloat,DMDiocEtatBal.TaBalanceCalcQt2_Base_Calc.AsFloat,
               DMDiocEtatBal.TaBalanceCalcSolde_Credit_Base_Calc.AsCurrency,DMDiocEtatBal.TaBalanceCalcSolde_Credit_Base_Calc.AsCurrency,dsinsert)
           end;
     tablegerecommit(TaBalance);
     DMDiocEtatBal.TaBalanceCalc.next;
     End;
TableGereCommit(TaBalance);
except
  result:=false;
  abort;
end;
End;


//function TDMBalance.CalculDuResultat(confirmation : Boolean):TExceptLGR;
//var
//ListeCptResultat:TStringList;  { d�clarer la liste }
//TotauxBalance6_7,TotauxBalance1_5:TTotauxBalance;
//CompteResult:TInfos_Piece;
//InfosGestDossier:TInfosGestDossier;
//DateDebTmp,DateFinTmp:Tdate;
//begin
//  try
//    try//except
//      result.retour:=VerifSoldeBalanceN_N1;
//      //sauve la configuration avant contr�le
//      DateDebTmp:=E.DatExoDebut;
//      DateFinTmp:=E.DatExoFin;
//      if not result.retour then
//        begin
//          result.Mess:='La balance de fin de l''exercice de base ne correspond pas � la balance d''ouverture du nouvel exercice';
//          showmessage(result.Mess);
//          abort;
//        end;
//      ListeCptResultat:= TStringList.Create;  { construire l'objet liste }
//      //g�rer les comptes de 6 � 7
//      ListeCptResultat.Add('6*');
//      ListeCptResultat.Add('7*');
//
//      //calcul du r�sultat � partir de la liste des comptes  (ici les comptes 6 et 7) sur N
//      InfosGestDossier:=ChercheInfos_ExoN(e.NomDossier);
//      E.DatExoDebut:=InfosGestDossier.DATE_DEB_EXO;
//      E.DatExoFin:=InfosGestDossier.DATE_FIN_EXO;
//      TotauxBalance6_7:=DMDiocEtatBal.SommeTotauxBalanceCalc(E.DatExoDebut,E.DatExoFin,ListeCptResultat,'Compte');
//
//    if (TotauxBalance6_7.soldefin) <> 0 then
//       begin //s'il y a un r�sultat � reporter
//          CompteResult:=AffichResultat(TotauxBalance6_7,confirmation);
//          if CompteResult.Retour then
//            Begin
//              if not empty(CompteResult.Compte) then
//                Begin//mettre � jour la balance des reports de N+1
//                   MiseAJourSimpleBalance_N_vers_N1(not(TotauxBalance6_7.SoldeDebitCreditFin),TotauxBalance6_7.soldefin,CompteResult.Compte);
//                   TableGereCommit(TaMAJBalanceN1);
//                end
//              else
//                abort;
//            end
//          else
//            abort;
//       End;//fin s'il y a un r�sultat � reporter
//    except
//       result.retour:=false;
//    end;//fin du except
//  finally
//      ListeCptResultat.free;
//      //Restaure la configuration avant contr�le
//       E.DatExoDebut:=DateDebTmp;
//       E.DatExoFin:=DateFinTmp;
//  end;//fin du finally
//end;

Function PossibiliteRepriseCompte(compte:string;Dataset:TDataset;Sens:string;Ecran:string):Texceptlgr;
var
Ret:integer;
SoldeCompte:TSoldeCompte;
ParamAffichage:TParamAffichage;
Begin
    try
       Result.retour:=true;
       Result.NumErreur:=0;
       SoldeCompte:=DMBalance.RetourneSoldeCompteAvantReprise(Compte,Dataset,0,Sens[1]);
       if ((SoldeCompte.SoldeBO.Retour)and(SoldeCompte.SoldeBalance.Retour)) then //importation
         begin
            if ((SoldeCompte.SoldeBO.Total<>SoldeCompte.SoldeBalance.Total)or(SoldeCompte.SoldeBO.SensTotal<>SoldeCompte.SoldeBalance.SensTotal)) then
              raise ExceptLGR.Create('',1,false,mtError,Result);
            if ((SoldeCompte.SoldeCharge.Total<>SoldeCompte.SoldeBalance.Total)or(SoldeCompte.SoldeCharge.SensTotal<>SoldeCompte.SoldeBalance.SensTotal)) then
              raise ExceptLGR.Create('',2,false,mtError,Result);
         end
       else
       if ((SoldeCompte.Soldecharge.Retour)and(SoldeCompte.SoldeBalance.Retour)) then //normal
         begin
            if ((SoldeCompte.SoldeCharge.Total<>SoldeCompte.SoldeBalance.Total)or(SoldeCompte.SoldeCharge.SensTotal<>SoldeCompte.SoldeBalance.SensTotal)) then
              raise ExceptLGR.Create('',3,false,mtError,Result);
         end
       else
          raise ExceptLGR.Create('',4,false,mtError,Result);
    except
         case Result.NumErreur of
           1,2,3:begin
                   Ret:=Application.MessageBox(Pchar('il existe une diff�rence entre vos '+Ecran+', le solde de la '+#13+#10+'balance et le solde du bilan d''ouverture '+#13+#10+'sur le compte :'+#13+#10+'Vous ne pouvez pas reprendre vos '+Ecran+' sur ce '+#13+#10+'compte'+#13+#10+'Souhaitez vous visualiser ces diff�rences ou annuler cette reprise ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNOCANCEL+MB_DEFBUTTON1);
                   if Ret=mryes then
                     begin
                        Initialise_TParamAffichage(ParamAffichage);
                        ParamAffichage.AffichModal := true;
                        ParamAffichage.Titre:='Liste des Soldes du compte '+Compte;
                        ParamAffichage.GestionAffichForm.Caption := ParamAffichage.Titre;
                        AfficheVisuListView(ParamAffichage,['Ecran','Compte','D�bit','Cr�dit'],
                                                           [200,200,150,150],
                                                           [SoldeCompte.ListeSolde],
                                                           [taLeftJustify,taLeftJustify,taRightJustify,taRightJustify],
                                                           [1..2],
                                                           [3..4],[0]);
                     end;
                  if ret=Mrno then
                    Result.retour:=Application.MessageBox(Pchar('Etes-vous s�r de vouloir faire la reprise'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes;
                 end;
           4:begin
               if Application.MessageBox(Pchar('il existe une diff�rence entre le solde de la balance et le solde '+#13+#10+'de vos '+Ecran+' sur le compte :'+Compte+#13+#10+'Vous ne pouvez pas reprendre vos '+Ecran+' pour ce compte. Souhaitez vous annuler cette reprise ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                  Result.retour:=Application.MessageBox(Pchar('Etes-vous s�r de vouloir faire la reprise'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes;
             end;
         end;//fin du case ExceptLGR
    end;//fin try except
end;


function TDMBalance.ControlBalanceTiersReport2(Gauge:TGauge;Global:boolean ; Forcer:boolean):texceptlgr;
var
i:integer;
corriger,continuer:boolean;
InfosExoN,InfosExoNMoins1:TInfosGestDossier;
RequeteBalance,RequeteEcriture1,RequeteTiers:TQuery;
TotauxBalanceNMoins1,TotauxBalanceN:TTotauxBalance;
compteCollectifNMoins1,TiersNMoins1:TCompteComparaison;
listeFiltre,listeDifference,listeDifferenceCollectif:Tstringlist;
listeComparaisonCollectif,listeComparaisonTiers:Tstringlist;
nomModule:string;
 Label detail;
Begin
try//finally
try//except
nomModule:='ControlBalanceTiersReport';
result.NumErreur:=22000;
result.retour:=true;
corriger:=false;
continuer:=true;
PatienterAffich;
 if DMDiocEtatBalT=nil then DMDiocEtatBalT:=TDMDiocEtatBalT.Create(Application.MainForm);
 if DMDiocEtatBal=nil then DMDiocEtatBal:=TDMDiocEtatBal.Create(Application.MainForm);
  if DMRech=nil then DMRech:=TDMRech.Create(Application.MainForm);

GestionGauge(10,Gauge,100,0,'Contr�le de la balance des tiers');
 RequeteBalance:=TQuery.Create(application.MainForm);
 RequeteEcriture1:=TQuery.Create(application.MainForm);
 RequeteTiers:=TQuery.Create(application.MainForm);

 listeFiltre:=Tstringlist.Create;
 listeDifference:=Tstringlist.Create;
 listeDifferenceCollectif:=Tstringlist.Create;
 listeComparaisonCollectif:=Tstringlist.Create;
 listeComparaisonTiers:=Tstringlist.Create;

 FiltrageDataset(DMRech.TaVerifRech,CreeFiltreET(['exercice','module'],[e.NomExo,nomModule]));
 if(DMRech.TaVerifRech.RecordCount<>0 )then continuer:=DMRech.TaVerifRech.FindField('continuer').AsBoolean;
 if (continuer)or(Forcer) then
   begin
       DMBD.BrancheTableVersN(TaBalanceT);
          If not TaBalanceT.active then
             TaBalanceT.open;


         InfosExoN:=ChercheInfos_ExoN(e.NomDossier);
         if(InfosExoN.DATE_DEB_EXO<>e.DatExoDebut)then abort;
         InfosExoNMoins1:=ChercheInfos_ExoSurDate(e.NomDossier,InfosExoN.DATE_DEB_EXO);


         if(InfosExoNMoins1.ResultInfos=false)then abort;
         if(InfosExoN.ResultInfos=false)then abort;




      //controle
      if(Global)then
      begin   //si v�rif globale
               RequeteBalance.close;
               RequeteBalance.SQL.Clear;
               RequeteBalance.DatabaseName:=DM_C_NomAliasDossier;



               RequeteBalance.SQL.Add('select  sum(b.Debit_Report)as Debit_Report,sum(b.Credit_Report)as Credit_Report,sum(b.Qt1_Report)as Qt1_Report,sum(b.Qt2_Report)as Qt2_Report ');
                    RequeteBalance.SQL.Add(' , sum(b.Debit_base) as TotDebit,sum(b.Credit_base) as TotCredit, ');
                    RequeteBalance.SQL.Add('  sum(b.Qt1_base)as TotQt1,sum(b.Qt2_base)as TotQt2 ');
               RequeteBalance.SQL.Add(' from  "'+IncludeTrailingPathDelimiter(InfosExoNMoins1.Dir_Exo)+'balanceTiers" b ');

               RequeteBalance.Open;
               RequeteBalance.First;

//               RequeteEcriture.close;
//               RequeteEcriture.SQL.Clear;
//               RequeteEcriture.DatabaseName:=DM_C_NomAliasDossier;
//               RequeteEcriture.SQL.Add('Select  sum(Ecr.DebitSaisie) as TotDebit,Sum(Ecr.CreditSaisie) as TotCredit, ');
//               RequeteEcriture.SQL.Add(' sum(Ecr.Qt1)as TotQt1,sum(Ecr.Qt2)as TotQt2');
//               RequeteEcriture.SQL.Add(' from Ecriture Ecr join Piece Pi on (Pi.ID=Ecr.ID_Piece)');
//               RequeteEcriture.SQL.Add(' right join Tiers T on T.tiers=Ecr.Tiers');
//               RequeteEcriture.SQL.Add(' where Pi."Date" >=:DateDeb and Pi."Date" <=:DateFin');
//               RequeteEcriture.ParamByName('DateDeb').AsDate:=InfosExoNMoins1.DATE_DEB_EXO;
//               RequeteEcriture.ParamByName('DateFin').AsDate:=InfosExoNMoins1.DATE_FIN_EXO;
//               RequeteEcriture.Open;
//               RequeteEcriture.First;
               while not(RequeteBalance.eof)do
               begin
                   InitialiseTotauxBalance(TotauxBalanceNMoins1);
                   TotauxBalanceNMoins1.TotalDebitReport:=RequeteBalance.findfield('Debit_Report').AsCurrency;
                   TotauxBalanceNMoins1.TotalCreditReport:=RequeteBalance.findfield('Credit_Report').AsCurrency;
//                   if(RequeteEcriture.RecordCount<>0)then
//                   begin
                     TotauxBalanceNMoins1.TotalDebitBase:=RequeteBalance.findfield('TotDebit').AsCurrency;
                     TotauxBalanceNMoins1.TotalCreditBase:=RequeteBalance.findfield('TotCredit').AsCurrency;
//                   end;
                   TotauxBalanceNMoins1.TotalDebitFin:=TotauxBalanceNMoins1.TotalDebitReport+TotauxBalanceNMoins1.TotalDebitBase;
                   TotauxBalanceNMoins1.TotalCreditFin:=TotauxBalanceNMoins1.TotalCreditReport+TotauxBalanceNMoins1.TotalCreditBase;
                   DetermineSolde(TotauxBalanceNMoins1.TotalDebitFin,TotauxBalanceNMoins1.TotalCreditFin);
                         TotauxBalanceN:=DMDiocEtatBalT.SommeTotauxBalanceTCalc(InfosExoN.DATE_DEB_EXO,InfosExoN.DATE_FIN_EXO,nil,'',true);
                         DetermineSolde(TotauxBalanceN.TotalSoldeDebitReport,TotauxBalanceN.TotalSoldeCreditReport);
                         if(TotauxBalanceN.TotalSoldeDebitReport<>TotauxBalanceNMoins1.TotalDebitFin)or(TotauxBalanceN.TotalSoldeCreditReport<>TotauxBalanceNMoins1.TotalCreditFin)then
                         begin
                           corriger:=true;
                         end;
                 RequeteBalance.Next;
               end;
         if(corriger)then goto detail;
      end   //fin si v�rif globale
      else
      begin //si v�rif tiers par tiers
      detail:
               GestionGauge(10,Gauge,-1,-1,'Contr�le de la balance des tiers');
               listeDifference.Add('tiers;Compte;Debit_NMoins1;Credit_NMoins1;Debit_N;Credit_N');

                     RequeteBalance.close;
                     RequeteBalance.SQL.Clear;
                     RequeteBalance.DatabaseName:=DM_C_NomAliasDossier;
                     RequeteBalance.filter:='';
                     RequeteBalance.filtered:=true;

                     RequeteBalance.SQL.Add(' select b.tiers,b.compte, (b.Debit_Report)as Debit_Report,(b.Credit_Report)as Credit_Report,(b.Qt1_Report)as Qt1_Report,(b.Qt2_Report)as Qt2_Report, ');
                    RequeteBalance.SQL.Add('  (b.Debit_base) as TotDebit,(b.Credit_base) as TotCredit, ');
                    RequeteBalance.SQL.Add('  (b.Qt1_base)as TotQt1,(b.Qt2_base)as TotQt2 ');
                    RequeteBalance.SQL.Add(' from  "'+IncludeTrailingPathDelimiter(InfosExoNMoins1.Dir_Exo)+'balanceTiers" b ');
                    RequeteBalance.SQL.Add('  order by b.compte,b.tiers ');


//                     RequeteBalance.SQL.Add(' select b.tiers,b.compte, (b.Debit_Report)as Debit_Report,(b.Credit_Report)as Credit_Report,(b.Qt1_Report)as Qt1_Report,(b.Qt2_Report)as Qt2_Report, ');
//                    RequeteBalance.SQL.Add(' Ecr.tiers, sum(Ecr.DebitSaisie) as TotDebit,Sum(Ecr.CreditSaisie) as TotCredit, ');
//                    RequeteBalance.SQL.Add('  sum(Ecr.Qt1)as TotQt1,sum(Ecr.Qt2)as TotQt2 ');
//                    RequeteBalance.SQL.Add(' from  "'+IncludeTrailingPathDelimiter(InfosExoNMoins1.Dir_Exo)+'balanceTiers" b ');
//                    RequeteBalance.SQL.Add(' full join Ecriture Ecr on Ecr.tiers=b.tiers ');
//                    RequeteBalance.SQL.Add('  join Piece Pi on (Pi.ID=Ecr.ID_Piece) ');
//                    RequeteBalance.SQL.Add('  where Ecr.tiers is not null and Ecr.tiers <>'''' and Pi."Date" between :DateDeb and :DateFin ');
//                    RequeteBalance.SQL.Add('  group by b.tiers,b.compte, (b.Debit_Report),(b.Credit_Report),(b.Qt1_Report),(b.Qt2_Report), ');
//                    RequeteBalance.SQL.Add(' Ecr.tiers ');
//                    RequeteBalance.SQL.Add('  order by b.compte,b.tiers ');
//               RequeteBalance.ParamByName('DateDeb').AsDate:=InfosExoNMoins1.DATE_DEB_EXO;
//               RequeteBalance.ParamByName('DateFin').AsDate:=InfosExoNMoins1.DATE_FIN_EXO;
                     RequeteBalance.Open;
                     RequeteBalance.First;
                    compteCollectifNMoins1:=TCompteComparaison.Create;

                     while not(RequeteBalance.eof)do
                      begin
                             if(compteCollectifNMoins1.compte<>RequeteBalance.findfield('compte').asstring )and(compteCollectifNMoins1.compte<>'')then
                             begin
                                compteCollectifNMoins1.TotauxBalance.TotalDebitFin:=compteCollectifNMoins1.TotauxBalance.TotalDebitReport+compteCollectifNMoins1.TotauxBalance.TotalDebitBase;
                                compteCollectifNMoins1.TotauxBalance.TotalCreditFin:=compteCollectifNMoins1.TotauxBalance.TotalCreditReport+compteCollectifNMoins1.TotauxBalance.TotalCreditBase;
                                DetermineSolde(compteCollectifNMoins1.TotauxBalance.TotalDebitFin,compteCollectifNMoins1.TotauxBalance.TotalCreditFin);
                                listeComparaisonCollectif.AddObject(compteCollectifNMoins1.compte,compteCollectifNMoins1);
                                //nouveau compte collectif
                                compteCollectifNMoins1:=TCompteComparaison.Create;
                             end;
                             compteCollectifNMoins1.compte :=RequeteBalance.findfield('compte').asstring;
                             TiersNMoins1:=TCompteComparaison.Create;
                             TiersNMoins1.tiers:=RequeteBalance.findfield('tiers').asstring;
                             TiersNMoins1.compte:=RequeteBalance.findfield('compte').asstring;
                             InitialiseTotauxBalance(TotauxBalanceNMoins1);
                             TotauxBalanceNMoins1.TotalDebitReport:=RequeteBalance.findfield('Debit_Report').AsCurrency;
                             TotauxBalanceNMoins1.TotalCreditReport:=RequeteBalance.findfield('Credit_Report').AsCurrency;
                             TotauxBalanceNMoins1.TotalDebitBase:=RequeteBalance.findfield('TotDebit').AsCurrency;
                             TotauxBalanceNMoins1.TotalCreditBase:=RequeteBalance.findfield('TotCredit').AsCurrency;
                             //gestion du compte collectif
                             compteCollectifNMoins1.TotauxBalance.TotalDebitReport:=compteCollectifNMoins1.TotauxBalance.TotalDebitReport+RequeteBalance.findfield('Debit_Report').AsCurrency;
                             compteCollectifNMoins1.TotauxBalance.TotalCreditReport:=compteCollectifNMoins1.TotauxBalance.TotalCreditReport+RequeteBalance.findfield('Credit_Report').AsCurrency;
                             compteCollectifNMoins1.TotauxBalance.TotalDebitBase:=compteCollectifNMoins1.TotauxBalance.TotalDebitBase+RequeteBalance.findfield('TotDebit').AsCurrency;
                             compteCollectifNMoins1.TotauxBalance.TotalCreditBase:=compteCollectifNMoins1.TotauxBalance.TotalCreditBase+RequeteBalance.findfield('TotCredit').AsCurrency;
                             //
                             TotauxBalanceNMoins1.TotalDebitFin:=TotauxBalanceNMoins1.TotalDebitReport+TotauxBalanceNMoins1.TotalDebitBase;
                             TotauxBalanceNMoins1.TotalCreditFin:=TotauxBalanceNMoins1.TotalCreditReport+TotauxBalanceNMoins1.TotalCreditBase;
                             DetermineSolde(TotauxBalanceNMoins1.TotalDebitFin,TotauxBalanceNMoins1.TotalCreditFin);

                             TiersNMoins1.TotauxBalance.TotalDebitReport:=RequeteBalance.findfield('Debit_Report').AsCurrency;
                             TiersNMoins1.TotauxBalance.TotalCreditReport:=RequeteBalance.findfield('Credit_Report').AsCurrency;
                             TiersNMoins1.TotauxBalance.TotalDebitBase:=RequeteBalance.findfield('TotDebit').AsCurrency;
                             TiersNMoins1.TotauxBalance.TotalCreditBase:=RequeteBalance.findfield('TotCredit').AsCurrency;

                             TiersNMoins1.TotauxBalance.TotalDebitFin:=TiersNMoins1.TotauxBalance.TotalDebitReport+TiersNMoins1.TotauxBalance.TotalDebitBase;
                             TiersNMoins1.TotauxBalance.TotalCreditFin:=TiersNMoins1.TotauxBalance.TotalCreditReport+TiersNMoins1.TotauxBalance.TotalCreditBase;
                             DetermineSolde(TiersNMoins1.TotauxBalance.TotalDebitFin,TiersNMoins1.TotauxBalance.TotalCreditFin);
                             listeComparaisonTiers.AddObject(TiersNMoins1.compte,TiersNMoins1);
                         InitialiseTotauxBalance(TotauxBalanceN);

                         TotauxBalanceN:=DMDiocEtatBalT.SommeTotauxBalanceParTiers(InfosExoN.DATE_DEB_EXO,InfosExoN.DATE_FIN_EXO,RequeteBalance.findfield('tiers').asstring,true);
                         DetermineSolde(TotauxBalanceN.TotalSoldeDebitReport,TotauxBalanceN.TotalSoldeCreditReport);
                         if(TotauxBalanceN.TotalSoldeDebitReport<>TotauxBalanceNMoins1.TotalDebitFin)or(TotauxBalanceN.TotalSoldeCreditReport<>TotauxBalanceNMoins1.TotalCreditFin)then
                         begin
                           corriger:=true;
                           listeDifference.AddObject(TiersNMoins1.tiers
                                               +';'+TiersNMoins1.compte
                                               +';'+FloatToStr_Lgr(TotauxBalanceNMoins1.TotalDebitFin)
                                               +';'+FloatToStr_Lgr(TotauxBalanceNMoins1.TotalCreditFin)
                                               +';'+FloatToStr_Lgr(TotauxBalanceN.TotalSoldeDebitReport)
                                               +';'+FloatToStr_Lgr(TotauxBalanceN.TotalSoldeCreditReport),TiersNMoins1);
                         end;

                     RequeteBalance.Next;
                end;//fin boucle sur tous les tiers
         end;//fin si v�rif tiers par tiers
       if(corriger)then
       begin
              continuer:=true;
              GestionGauge(50,Gauge,-1,-1,'Contr�le de la balance des tiers');
           //controle compte collectif
               i:=0;
               while (i<listeComparaisonCollectif.Count-1)do
                 begin
                   compteCollectifNMoins1:=TCompteComparaison(listeComparaisonCollectif.Objects[i]);
                    InitialiseTotauxBalance(TotauxBalanceN);

                     TotauxBalanceN:=DMDiocEtatBal.SommeTotauxBalanceParCompte(InfosExoN.DATE_DEB_EXO,InfosExoN.DATE_FIN_EXO,TCompteComparaison(listeComparaisonCollectif.Objects[i]).compte,true);
                     DetermineSolde(TotauxBalanceN.TotalSoldeDebitReport,TotauxBalanceN.TotalSoldeCreditReport);
                     if(TotauxBalanceN.TotalSoldeDebitReport<>compteCollectifNMoins1.TotauxBalance.TotalDebitFin)or(TotauxBalanceN.TotalSoldeCreditReport<>compteCollectifNMoins1.TotauxBalance.TotalCreditFin)then
                       begin
                           continuer:=false;
                           listeDifferenceCollectif.AddObject(''
                                               +';'+compteCollectifNMoins1.compte
                                               +';'+FloatToStr_Lgr(compteCollectifNMoins1.TotauxBalance.TotalDebitFin)
                                               +';'+FloatToStr_Lgr(compteCollectifNMoins1.TotauxBalance.TotalCreditFin)
                                               +';'+FloatToStr_Lgr(TotauxBalanceN.TotalSoldeDebitReport)
                                               +';'+FloatToStr_Lgr(TotauxBalanceN.TotalSoldeCreditReport),compteCollectifNMoins1);
                       end;
                     inc(i);
                 end;//fin boucle sur les compte de tiers existant
            //
         if continuer then
         begin
           Application.MessageBox(Pchar('Les reports de votre balance des Tiers ne sont pas coh�rents.'+retourchariotsimple+'ils vont �tre automatiquement corrig�s.'+
           AppelerServiceMaintenance),'Attention',MB_ICONWARNING);
           listeDifference.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireExercice)+'correctionBalanceTiersReport.txt');
                try
                GestionGauge(30,Gauge,-1,-1,'Contr�le de la balance des tiers');
                RequeteBalance.close;
                RequeteBalance.sql.clear;
               RequeteBalance.filter:='';
               RequeteBalance.filtered:=false;
                RequeteBalance.DatabaseName:=DM_C_NomAliasExercice;
                RequeteBalance.sql.add('update  BalanceTiers');
                RequeteBalance.sql.add('set Debit_Report = 0,');
                RequeteBalance.sql.add('Credit_Report = 0,');
                RequeteBalance.sql.add('Qt1_Report = 0,');
                RequeteBalance.sql.add('Qt2_Report = 0');
                RequeteBalance.ExecSQL;
                RequeteBalance.close;

                RequeteBalance.close; //supprime tous les comptes qui n'ont pas de mouvements dans l'ann�e N.
                RequeteBalance.sql.clear;
                RequeteBalance.DatabaseName:=DM_C_NomAliasExercice;
                RequeteBalance.sql.add('delete from BalanceTiers B');
                RequeteBalance.sql.add('where');
                RequeteBalance.sql.add('(B.Debit_Base=0 or B.Debit_Base is null)');
                RequeteBalance.sql.add('and (B.Credit_Base=0 or B.Credit_Base is null)');
                RequeteBalance.ExecSQL;   //debit_base et credit_base
                RequeteBalance.close;  //pour pouvoir faire ou refaire la mise � jour des reports de N-1 vers N
               except
                 abort;
               end;

               i:=0;
               while (i<=listeComparaisonTiers.Count-1) do
               begin

                   TiersNMoins1:=TCompteComparaison(listeComparaisonTiers.Objects[i]);

                   if TiersNMoins1.TotauxBalance.TotalDebitFin<>0 then
                     MAJBalanceDesTiers(false,'Qt1_Report','Debit_Report',TiersNMoins1.tiers,TiersNMoins1.compte,
                     TiersNMoins1.tiers,0,0,
                     TiersNMoins1.TotauxBalance.TotalDebitFin,TiersNMoins1.TotauxBalance.TotalDebitFin,dsinsert)
                   else
                    if TiersNMoins1.TotauxBalance.TotalCreditFin<>0 then
                     MAJBalanceDesTiers(false,'Qt2_Report','Credit_Report',TiersNMoins1.tiers,TiersNMoins1.compte,
                     TiersNMoins1.tiers,0,0,
                     TiersNMoins1.TotauxBalance.TotalCreditFin,TiersNMoins1.TotauxBalance.TotalCreditFin,dsinsert);

                   inc(i);
               end;
         end//fin si continuer
         else
         begin //si collectif balance pas egal � collectif balanceTiers
           Application.MessageBox(Pchar('Le contr�le [N� '+inttostr(result.NumErreur)+'] du dossier ne s''est pas d�roul� correctement !'+
           retourchariotdouble+'Les reports de votre balance des Tiers ne sont pas coh�rents.'+
           AppelerServiceMaintenance),'Attention',MB_ICONWARNING);
           listeDifferenceCollectif.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireExercice)+'correctionBalanceTiersReportCollectif.txt');
           listeDifference.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireExercice)+'correctionBalanceTiersReport.txt');
         end;  //fin si collectif balance pas egal � collectif balanceTiers
      end;//fin si corriger
      TableGereCommit(TaBalanceT);
   end;//fin si continuer parce que pas trouve dans table taVerif
except
  TableGereRollBack(TaBalanceT);
  result.retour:=false;
  //abort;
end;
finally
GestionGauge(10,Gauge,-1,-1,'Contr�le de la balance des tiers');
Patienterfermer;
  RequeteEcriture1.close;
  RequeteBalance.close;
  RequeteTiers.Close;
  Initialise_TStringlist(listeFiltre);
  Initialise_TStringlist(listeDifference);
  Initialise_TStringlist(listeDifferenceCollectif);
  Initialise_TStringlist(listeComparaisonCollectif);
  Initialise_TStringlist(listeComparaisonTiers);
  RequeteEcriture1.free;
  RequeteBalance.free;
  RequeteTiers.free;
end;
End;


end.
