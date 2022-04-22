unit DMDepenses;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Gr_Librairie_obj, E2_Librairie_obj,LibSQL,E2_ChargesAPayer_Isa,
  AideMontant2,DMTVA,DMBalances,DMPiece,DMProvision, RxMemDS,DMClotures,
  E2_Decl_Records,DMRecherche,E2_LibInfosTable,DMConstantes;

type
     TRecupParametres=record
     sens1,sens2,sens3,sens4:string;
     Qte1,Qte2,Qte3,Qte4:string;
     compteTva:string;
end;


type
  TDMDepenseEnt = class(TDataModule)
    TaDepense: TTable;
    DataDepense: TDataSource;
    TaDepense2: TTable;
    DataDepense2: TDataSource;
    DataDepense3: TDataSource;
    TaDepense3: TTable;
    QueryDesignation: TQuery;
    QueryDesignationId: TIntegerField;
    QueryDesignationCompte2: TStringField;
    QueryDesignationSens: TStringField;
    DataDesignation: TDataSource;
    TaRechercheDepense: TTable;
    TaDepenseID: TIntegerField;
    TaDepenseCompte: TStringField;
    TaDepenseLibelle: TStringField;
    TaDepenseSens: TStringField;
    TaDepenseQte: TFloatField;
    TaDepenseMontantHT: TCurrencyField;
    TaDepenseDateSaisie: TDateField;
    TaDepenseDateExercice: TDateField;
    TaDepenseCompte2: TStringField;
    TaDepenseLibelle2: TStringField;
    TaDepenseTVA: TCurrencyField;
    TaDepenseDatePiece: TDateField;
    TaDepenseReference: TStringField;
    TaDepenseDateSysteme: TDateTimeField;
    TaDepense2ID: TIntegerField;
    TaDepense2Compte: TStringField;
    TaDepense2Libelle: TStringField;
    TaDepense2Sens: TStringField;
    TaDepense2Qte: TFloatField;
    TaDepense2MontantHT: TCurrencyField;
    TaDepense2DateSaisie: TDateField;
    TaDepense2DateExercice: TDateField;
    TaDepense2Compte2: TStringField;
    TaDepense2Libelle2: TStringField;
    TaDepense2TVA: TCurrencyField;
    TaDepense2DatePiece: TDateField;
    TaDepense2Reference: TStringField;
    TaDepense2DateSysteme: TDateTimeField;
    QueryDesignationDesignation: TStringField;

    procedure FiltrageAffichageGrille(tag_bis:integer);
    Function  CtrlSaisieDepenses(CCourant:Tfield):TErreurSaisie;
    procedure TaDepenseAfterPost(DataSet: TDataSet);
    procedure TaDepenseBeforePost(DataSet: TDataSet);
    procedure TaDepenseBeforeEdit(DataSet: TDataSet);
    procedure TaDepenseBeforeDelete(DataSet: TDataSet);
    procedure TaDepenseAfterDelete(DataSet: TDataSet);
    function  RecupParametreMAJBalance(tag_module:integer):TRecupParametres;
    procedure TraitementMAJBalance(Ch_Pr:integer;Suppression:boolean;TableDepenseCourante:Tdataset;Etat:Tdatasetstate);
    function CreationListeOD(sens:string):TStringList;
    procedure DemandeAffichageReprise;
    function FiltragePourAffichageODCloture:Boolean;
    procedure CreationODChargeAPayerCloture;
    Procedure EcritureReference(ID:integer;date:boolean;Ref:string);
    procedure TaDepenseAfterEdit(DataSet: TDataSet);
    procedure TaDepenseAfterInsert(DataSet: TDataSet);
    procedure DMDepenseEntCreate(Sender: TObject);
    procedure DMDepenseEntDestroy(Sender: TObject);
    procedure Filtrage_EcriturePourNouvelExo(var tMem:TRxMemoryData;NouvelleDate:Tdatetime);
    procedure TaDepensePostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaDepenseDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure VerifTVA;
    procedure RecupInfoApresVerif(Tout:boolean);
    function VerifExistDepensesCloture(var messageTmp:string;Mess:boolean):boolean;
    procedure CreationODCloture_avecObjet(TableEnCours:TTable;ODModif:string);
    Procedure ImportDepenses(Valeurs:array of const;DataSet:TDataSet);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    Erreur:TErreurSaisie;
    CompteExploitant:string;
   
  end;

var
  DMDepenseEnt: TDMDepenseEnt;
  CompteEdit:string;
  DatePiece:Tdatetime;
  EtatTable:tdatasetstate;
  Mark: TBookMark;
  dernierlibelle:string;

  InfosDepensesEntreprisesTmp,InfosDepensesEntreprises:TInfosDepensesEntreprises;

implementation
uses DMPlanCpt,E2_AideCompte,E2_DepensesEntreprise,E2_RepriseChargeAPayer2_Isa,
  E2_Main, DMImportation,DMBaseDonnee;
{$R *.DFM}


procedure TDMDepenseEnt.Filtrage_EcriturePourNouvelExo(var tMem:TRxMemoryData;NouvelleDate:Tdatetime);
begin
     try
     FiltrageDataSet(dmrech.TaDepensesEntreprisesRech,CreeFiltreET(['DateSaisie'],[datetostr(E.DatExoFin)]));
     TableGereStartTransaction(dmrech.TaDepensesEntreprisesRech);
     if dmrech.TaDepensesEntreprisesRech.RecordCount<>0 then
        begin
        tMem.LoadFromDataSet(dmrech.TaDepensesEntreprisesRech,0,lmCopy);
        tMem.First;
        while not(tMem.EOF) do
           begin
           tMem.edit;
           tMem.FindField('DateSaisie').AsDateTime:=NouvelleDate;
           tMem.FindField('DateSysteme').AsDateTime:=now;
           tMem.FindField('DatePiece').Asstring:='';
           tMem.FindField('Reference').Asstring:='';
           tMem.Post;
           tmem.FieldCount;
           tMem.Next;
           end;
        end;
     TableGereCommit(dmrech.TaDepensesEntreprisesRech);
     TableGereCommit(DMPieces.TaPiece);
     except
     TableGereRollBack(dmrech.TaDepensesEntreprisesRech);
     TableGereRollback(DMPieces.TaPiece);
     showmessage('Problème à l''écriture dans la nouvelle table '+dmrech.TaDepensesEntreprisesRech.tableName);
     abort;
     end;//fin du try
end;


Procedure TDMDepenseEnt.EcritureReference(ID:integer;date:boolean;Ref:string);
begin
  try
    if TaDepense2.Locate('ID',ID,[]) then
    begin
    if not (TaDepense2.State in [dsinsert,dsedit])then
      TaDepense2.Edit;
    TaDepense2Reference.AsString:= Ref;
    if date=true then
    TaDepense2DatePiece.Asdatetime:=e.DatExoFin;
    TableGerePost(TaDepense2);
   end;
  except
     abort;
  end;
end;




procedure TDMDepenseEnt.CreationODChargeAPayerCloture;
var
NbEnregistrement:integer;
begin
   try
      FiltrageDataSet(DMRech.TaDepensesEntreprisesRech,CreeFiltreET(['Reference'],['']));
      TableGereStartTransaction(DMRech.TaDepensesEntreprisesRech);

      NbEnregistrement:=DMRech.TaDepensesEntreprisesRech.RecordCount;
      DMRech.TaDepensesEntreprisesRech.First;
      While (Not(NbEnregistrement=0)) Do
        Begin
        Remplit_TInfosDepensesEntreprises(DMRech.TaDepensesEntreprisesRech,InfosDepensesEntreprisesTmp);
        Remplit_TInfosDepensesEntreprises(DMRech.TaDepensesEntreprisesRech,InfosDepensesEntreprises);

        if DMRech.TaDepensesEntreprisesRech.findfield('Sens').AsString='C'then
        TraitementMAJBalance(2,true,DMRech.TaDepensesEntreprisesRech,dsbrowse);

        if DMRech.TaDepensesEntreprisesRech.findfield('Sens').AsString='D'then
        TraitementMAJBalance(1,true,DMRech.TaDepensesEntreprisesRech,dsbrowse);

        CreationODCloture_avecObjet(DMRech.TaDepensesEntreprisesRech,'');
        EcritureReference(DMRech.TaDepensesEntreprisesRech.findfield('ID').AsInteger,true,DMImport.Piece_Import.Reference);
        DMRech.TaDepensesEntreprisesRech.next;
        NbEnregistrement:=NbEnregistrement-1;
        end;
      TableGereCommit(DMRech.TaDepensesEntreprisesRech);
      TableGereCommit(DMPieces.TaPiece);
   except
       begin
       showmessage('Problème à l''enregistrement des OD de clôture');
       TableGereRollBack(DMRech.TaDepensesEntreprisesRech);
       TableGereRollBack(DMPieces.TaPiece);
       abort;
       end;
   end;//fin du try
   DMRech.TaDepensesEntreprisesRech.close;
end;


function TDMDepenseEnt.FiltragePourAffichageODCloture:Boolean;
begin
TaDepense.Filter := '';
TaDepense.Filtered := True;
result:=TaDepense.RecordCount <> 0
end;


procedure TDMDepenseEnt.DemandeAffichageReprise;
var
Liste1,Liste2:TStringList;
begin
  try
    liste1:=CreationListeOD('D');
    liste2:= CreationListeOD('C');
    DMPieces.AffichageFeuilleReprise(1,liste1,liste2,'Dépenses de l''Entreprise et du Privé',
    'Dépense de l''Entreprise','Dépenses du Privé',true);
  finally
//    liste1.Free;
//    liste2.Free;
  end;
end;



function TDMDepenseEnt.CreationListeOD(sens:string):TStringList;
begin
try
FiltrageDataSet(TaDepense,'Reference <> ''''And Sens = '''+sens+'''');
result:=TStringList.Create;
result.Clear;
  While (Not(TaDepense.EOF)) Do
     Begin
         If result.IndexOf(TaDepenseReference.AsString) = -1 Then
            result.Add(TaDepenseReference.AsString);
         TaDepense.Next;
     End;
except
  result.clear;
end;
end;

//******************* TDMChargeAPayer.TraitementMAJBalance *************************
procedure TDMDepenseEnt.TraitementMAJBalance(Ch_Pr:integer;Suppression:boolean;TableDepenseCourante:Tdataset;Etat:Tdatasetstate);
var
param:TRecupParametres; //nom du champ(Debit ou Credit)et du champ Quantité
begin
if Ch_Pr= 0 then
param:=RecupParametreMAJBalance(self.tag)//récupération des paramètres de MAJ Balance
else
param:=RecupParametreMAJBalance(Ch_Pr);//récupération des paramètres de MAJ Balance
with param do
   begin //Début du with
        //mise à jour balance pour le compte de l'exploitant
        DMBalance.MAJBalance(Suppression,qte1,sens1,TableDepenseCourante.findfield('Compte').AsString,
        InfosDepensesEntreprisesTmp.Compte,TableDepenseCourante.findfield('Qte').AsFloat,InfosDepensesEntreprisesTmp.Qte,
        InfosDepensesEntreprises.MontantHT+InfosDepensesEntreprises.TVA,
        InfosDepensesEntreprisesTmp.MontantHT+InfosDepensesEntreprisesTmp.TVA,Etat);
   end;//fin du with
end;

//******************* TDMDepenseEnt.TaDepenseBeforePost *************************
procedure TDMDepenseEnt.TaDepenseBeforePost(DataSet: TDataSet);
var
I:integer;
controleSaisie:TErreurSaisie;
begin
if DataSet.State in [dsinsert,dsedit] then
   begin //vérife sur compte et libelle
      case E.TypeEtatExercice of
        ET_Importation,
        ET_Normal,
        ET_Maint:    Begin
                       for i:=8 to 9 do
                         controleSaisie:=CtrlSaisieDepenses(TaDepense.Fields[i]);
                             if controleSaisie.Retour=false then
                               case controleSaisie.CodeErreur of
                                  8100,8101:begin
                                              DataSet.Fields[8].FocusControl;
                                              abort;//champ code emprunt
                                            end;
                               end;//fin du case
                       for i:=4 to 5 do //vérife sur Qte et montant
                         controleSaisie:=CtrlSaisieDepenses(TaDepense.Fields[i]);
                             if controleSaisie.Retour=false then
                               case controleSaisie.CodeErreur of
                                       5100:begin
                                              DataSet.Fields[5].FocusControl;
                                              abort;//champ code emprunt
                                            end;
                               end;//fin du case
                       if DepensesEntreprise.SBEntreprise.Down then
                         CtrlSaisieDepenses(TaDepense.Fields[10]);
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
   try
      if TaDepense.State=dsinsert then
      begin //si table en insertion
      if DepensesEntreprise.SBEntreprise.Down then
      TaDepensesens.AsString:='D'
      else
      TaDepensesens.AsString:='C';
      TaDepenseID.AsInteger:=MaxId_Query(TaDepense,'ID');
      TaDepenseCompte.AsString:=DepensesEntreprise.NumCpt.Text;
      TaDepenseLibelle.AsString:=DepensesEntreprise.Label2.Caption;
      TaDepenseDateSysteme.AsDateTime:=now;
      TaDepenseDateSaisie.AsDateTime:=e.DatExoFin;
      TaDepenseDateExercice.AsDateTime:=e.DatExoDebut;
      end;//fin table en insertion
      except
      showmessage('Problème à l''écriture dans la table Depenses Entreprise !!!');
      abort;
      end;//fin du try

TableGereStartTransaction(DataSet);
 try
      case E.TypeEtatExercice of
        ET_Importation,
        ET_Normal,ET_EnCloture,
        ET_Maint:    Begin
                        Remplit_TInfosDepensesEntreprises(TaDepense,InfosDepensesEntreprises);
                        if empty(TaDepenseReference.AsString)then
                          TraitementMAJBalance(self.tag,false,TaDepense,EtatTable);
                        if EtatTable =dsEdit then
                          if not(empty(TaDepenseReference.AsString)) then
                              begin //si modif et OD
                                 if (trim(TaDepenseCompte2.AsString)<>trim(InfosDepensesEntreprisestmp.Compte2))or
                                (TaDepenseMontantHT.AsCurrency<>InfosDepensesEntreprisesTmp.MontantHT)or
                                (TaDepenseQte.AsFloat<>InfosDepensesEntreprisesTmp.Qte)
                                or (TaDepenseTVA.AsFloat<>InfosDepensesEntreprisesTmp.TVA)then
                                begin
                                DMPieces.SuppressionOD(TaDepenseReference.AsString);
                                CreationODCloture_avecObjet(TaDepense,TaDepenseReference.AsString);
                                end
                                else
                                if trim(TaDepenseLibelle2.asstring)<>trim(InfosDepensesEntreprisesTmp.Libelle2) then
                                DMPieces.ModificationOD(TaDepenseReference.AsString,TaDepenseLibelle2.asstring);
                              end;//fin si modif et OD
                     end;
      end;//fin du case typeEtatExercice
   except
         TableGereRollback(DataSet);
         TableGereRollback(DMPieces.TaPiece);
   showmessage('Problème à la mise à jour de la balance !!!');
   abort;
   end;//fin du try
   end;
end;


Function TDMDepenseEnt.CtrlSaisieDepenses(CCourant:Tfield):TErreurSaisie;
var
RetourEnregistrement:TEnregistrementComplet;
begin // initialisation des variables de retour de fonction
CtrlSaisieDepenses.CodeErreur:=0;
CtrlSaisieDepenses.Retour:=True;
  if TaDepense.State in [dsinsert,dsEdit] then
  begin //si état insertion ou modification
        case CCourant.Index of
        8: begin // si champ n° 1 (compte2)
             DMPlan.FiltrageAideCompteSurCompte(16,CompteExploitant,nil,nil);
               if AideCompteDansContexte(CCourant.AsString,ccourant,['Rac1','Rac2','Rac3','Rac4','Rac5'],false,MessDerSub,true,true,false,true,0)=false then
               begin
                CtrlSaisieDepenses.CodeErreur:=8100;
                CtrlSaisieDepenses.Retour:=False;
                end//fin champ n°1 vide
                else
                   RecupInfoApresVerif(true);
              end;

        9: begin//si champ n°2(Désignation)
               If Empty(CCourant.AsString) then
                begin
                RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaDepenseCompte.AsString);
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
                  RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaDepenseCompte.AsString);
                   if not(empty(RetourEnregistrement.Libelle)) then
                      begin
                      ccourant.AsString:=RetourEnregistrement.Libelle;
                      DernierLibelle:=RetourEnregistrement.Libelle;
                      end;
                end;
           end;
        4: begin//si champ n°3 (Qté)
            If (Empty(CCourant.AsString)) and (ccourant.ReadOnly=false) then
             cCourant.AsString:='0';
           end;//fin si champ n°3 (Qté)
        5: begin//si champ n°4 (Montant HT)
             If (Empty(CCourant.AsString)) or (ccourant.AsString='0') then
             Begin // si champ n°4 vide ou =0
             CtrlSaisieDepenses.CodeErreur:=5100;
             CtrlSaisieDepenses.Retour:=False;
             Application.Messagebox(Pchar('La saisie du montant HT est obligatoire !!!'),'Erreur de saisie',0);
             end;//fin  si champ n°4 vide ou =0
           end;//fin si champ n°4 (Montant HT)
        10:begin//si champ n°5 (TVA)
             If (Empty(CCourant.AsString)) and (ccourant.ReadOnly=false) then
             Begin // si champ n°5 vide et pas en lecture seule
             cCourant.AsString:='0';
             end;//fin si champ n°5 vide et pas en lecture seule
             If not(Empty(CCourant.AsString))and (CCourant.Asfloat<>0) then
             Begin // si champ n°5 pas vide
             VerifTVA;
             end;//fin si champ n°5 pas vide
           end;//fin si champ n° 5 (TVA)
        end;//fin du case.ccourant
  end; //fin etat insertion ou modif
//  Erreur:=result;

end;



procedure TDMDepenseEnt.FiltrageAffichageGrille(tag_bis:integer);
var
sens:string;
begin
if tag_bis=1 then
sens:='D'
else
sens:='C';
FiltrageDataSet(TaDepense,CreeFiltreET(['Compte','Sens'],[DepensesEntreprise.NumCpt.Text,sens]));
DataDepense.OnStateChange(TaDepense);
end;

procedure TDMDepenseEnt.DMDepenseEntCreate(Sender: TObject);
begin
TaDepense.AfterScroll:=nil;
OuvrirTouteTable('',TControl(self));
TaDepenseCompte2.ValidChars := ['0'..'9'];

TaDepenseMontantHT.DisplayFormat:=E.FormatMonnaie;
TaDepenseMontantHT.EditFormat:='0.00 ;-0.00 ';

TaDepenseTVA.DisplayFormat:=E.FormatMonnaie;
TaDepenseTVA.EditFormat:='0.00 ;-0.00 ';

TaDepenseQte.ReadOnly:=true;
TaDepenseTVA.ReadOnly:=true;
end;


function  TDMDepenseEnt.RecupParametreMAJBalance(tag_module:integer):TRecupParametres;
begin
   with result do
   begin
      case tag_module of
           1:begin //Depenses de l'entreprise
              sens1:='Debit_Base';
              Qte1:='Qt1_Base';
              sens2:='Credit_Base';
              Qte2:='Qt2_Base';
              end;
           2:begin //Dépenses du Privé
              sens1:='Credit_Base';
              Qte1:='Qt2_Base';
              sens2:='Debit_Base';
              Qte2:='Qt1_Base';              
              end;
      end;//fin du case
   end;//fin du with
end;


procedure TDMDepenseEnt.TaDepenseAfterPost(DataSet: TDataSet);
begin
 TableGereCommit(DataSet);
 TableGereCommit(DMPieces.TaPiece);
 FiltrageAffichageGrille(self.tag);
 EtatTable:=DataSet.State;
end;

procedure TDMDepenseEnt.TaDepenseBeforeEdit(DataSet: TDataSet);
begin
Remplit_TInfosDepensesEntreprises(DMRech.TaDepensesEntreprisesRech,InfosDepensesEntreprisesTmp);
end;

procedure TDMDepenseEnt.TaDepenseBeforeDelete(DataSet: TDataSet);
begin
try
   If Messagedlg('Êtes-vous sûr de supprimer cette Dépense ?',MtConfirmation,[mbyes,mbno],0) = mrno Then
     abort
   else
   begin
   Remplit_TInfosDepensesEntreprises(TaDepense,InfosDepensesEntreprisesTmp);
   Remplit_TInfosDepensesEntreprises(TaDepense,InfosDepensesEntreprises);

   TableGereStartTransaction(DataSet);

       if empty(InfosDepensesEntreprisesTmp.Reference)then
         begin
           try
             TraitementMAJBalance(self.tag,true,TaDepense,dsBrowse);
           except
           showmessage('Problème à la Mise A Jour de la balance ');
           abort;
           end;//fin du try
         end;

    if not(empty(InfosDepensesEntreprisesTmp.Reference)) then
       begin//si la charge ou produit à une OD
          try
            DMPieces.SuppressionOD(InfosDepensesEntreprisesTmp.Reference);
          except
            showmessage('Problème à la suppression d''une charge');
            abort;
          end;//fin du try
       end;// fin si la charge ou produit à une OD

   end;
except
   TableGereRollBack(DataSet);
   TableGereRollBack(DMPieces.TaPiece);
   abort;
end;
end;

procedure TDMDepenseEnt.TaDepenseAfterDelete(DataSet: TDataSet);
begin
 TableGereCommit(DataSet);
 TableGereCommit(DMPieces.TaPiece);
 if @DataDepense.OnStateChange<>nil then DataDepense.OnStateChange(DataSet);
end;



procedure TDMDepenseEnt.TaDepenseAfterEdit(DataSet: TDataSet);
begin
EtatTable:=TaDepense.State;
end;

procedure TDMDepenseEnt.TaDepenseAfterInsert(DataSet: TDataSet);
begin
EtatTable:=TaDepense.State;
end;

procedure TDMDepenseEnt.DMDepenseEntDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
DMDepenseEnt:=nil;
end;

procedure TDMDepenseEnt.TaDepensePostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
 TableGereRollBack(TaDepense);
 TableGereRollBack(DMPieces.TaPiece);
end;

procedure TDMDepenseEnt.TaDepenseDeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
 TableGereRollBack(TaDepense);
 TableGereRollBack(DMPieces.TaPiece);
end;

procedure TDMDepenseEnt.VerifTVA;
var
RetourTva:TRecupMiniMaxTva;
resultat:TAideMontantTTC2RetFunction;
RetourEnregistrement:TEnregistrementComplet;
Recuperer:boolean;
begin//si champ TVA rempli
Recuperer:=true;
resultat.Retour:=true;
             //Récupère tous les paramètres d'un compte
             RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaDepenseCompte2.AsString);
             if RetourEnregistrement.CodeRetour then
                begin//si le compte a été trouvé
                   if not(empty(RetourEnregistrement.TvaCode))then
                   begin //si il y a un code tva
                   //récupère les paramètre du codeTva trouvé dans les paramètre du compte
                   RetourTva:=FTvaRecupMiniMaxTva(RetourEnregistrement.TvaCode);
                   case retourtva.CodeRetour of  //vérifie que la tva saisie rentre dans la fourchette
                   //des calculs fais à partir des taux récupérés
                   1:begin //le calcul porte sur 1 seul taux (Taux_Inf)
                       if calcultva(retourtva.Taux_Inf,0,TaDepenseMontantHT.AsCurrency,0,13).TVA>TaDepenseTVA.AsFloat then
                       begin
                       Messagedlg('Le taux de TVA est incohérent !!!',MtWarning,[mbok],0);
//                       resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,TaDepenseMontantHT.AsCurrency,TaDepenseTVA.AsFloat]);
                       end
                       else
                       Recuperer:=false;
                     end;
                   2:begin //le calcul porte sur 1 seul taux (Taux_Supp)
                       if calcultva(retourtva.Taux_Supp,0,TaDepenseMontantHT.AsCurrency,0,13).TVA<TaDepenseTVA.AsFloat then
                       begin
                       Messagedlg('Le taux de TVA est incohérent !!!',MtWarning,[mbok],0);
//                       resultat:=AideMontantAffiche([retourtva.Taux_Supp,0,TaDepenseMontantHT.AsCurrency,TaDepenseTVA.AsFloat]);
                       end
                       else
                       Recuperer:=false;
                     end;
                  12:begin //le calcul porte sur 2 taux (Taux_Inf et taux_Supp)
                       if (calcultva(retourtva.Taux_Inf,0,TaDepenseMontantHT.AsCurrency,0,13).TVA>TaDepenseTVA.AsFloat)or
                        (calcultva(retourtva.Taux_Supp,0,TaDepenseMontantHT.AsCurrency,0,13).TVA<TaDepenseTVA.AsFloat)then
                       begin
                       Messagedlg('Le taux de TVA est incohérent !!!',MtWarning,[mbok],0);
//                       resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,TaDepenseMontantHT.AsCurrency,TaDepenseTVA.AsFloat,retourtva.Taux_Supp,0,TaDepenseMontantHT.AsCurrency,TaDepenseTVA.AsFloat]);
                       end
                       else
                       Recuperer:=false;
                     end;
                   end;//fin du case retourTva

                   /////Si erreur de saisie rencontrée et nouveaux montants tva récupérés
                   if (Recuperer) and (resultat.Retour) then
                   begin
                      TaDepense.Fields[5].AsCurrency:=resultat.HT;
                      TaDepense.Fields[10].AsCurrency:=resultat.TVA;
                       case retourtva.CodeRetour of
                      1:begin
                          if calcultva(retourtva.Taux_Inf,0,TaDepenseMontantHT.AsCurrency,0,13).TVA>TaDepenseTVA.AsFloat then
                            if Messagedlg('Le taux de TVA est incohérent !!! Voulez-vous confirmer votre choix',MtWarning,[mbyes,mbno],0)=mrno then
                            abort;
                        end;
                      2:begin
                          if calcultva(retourtva.Taux_Supp,0,TaDepenseMontantHT.AsCurrency,0,13).TVA<TaDepenseTVA.AsFloat then
                          if Messagedlg('Le taux de TVA est incohérent !!! Voulez-vous confirmer votre choix',MtWarning,[mbyes,mbno],0)=mrno then
                            abort;                     end;
                     12:begin
                          if (calcultva(retourtva.Taux_Inf,0,TaDepenseMontantHT.AsCurrency,0,13).TVA>TaDepenseTVA.AsFloat)or
                           (calcultva(retourtva.Taux_Supp,0,TaDepenseMontantHT.AsCurrency,0,13).TVA<TaDepenseTVA.AsFloat)then
                          if Messagedlg('Le taux de TVA est incohérent !!! Voulez-vous confirmer votre choix',MtWarning,[mbyes,mbno],0)=mrno then
                            abort;
                        end;
                      end;//fin du case retourTva
                   end
                   else
                   if resultat.Retour=false then
                    if Messagedlg('Le taux de TVA est incohérent !!! Voulez-vous confirmer votre choix',MtWarning,[mbyes,mbno],0)=mrno then
                      abort;
                   end;
                end;//fin si le compte a été trouvé
end;

procedure TDMDepenseEnt.RecupInfoApresVerif(Tout:boolean);
var
RetourEnregistrement:TEnregistrementComplet;
begin
   RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaDepenseCompte2.AsString);
       if empty(RetourEnregistrement.Un1) then
       begin
       if TaDepense.Fields[4].ReadOnly=false then
       TaDepense.Fields[4].asstring:='';
       TaDepense.Fields[4].ReadOnly:=true;
       //liste.Add('Qte');
       end
       else
       TaDepense.Fields[4].ReadOnly:=false;
       if empty(RetourEnregistrement.TvaCode) then
       begin
       if TaDepense.Fields[10].ReadOnly=false then
       TaDepense.Fields[10].asstring:='';
       TaDepense.Fields[10].ReadOnly:=true;
       end
      else
       TaDepense.Fields[10].ReadOnly:=false;
    ///////////////////////
    if tout then
       begin
          if not(empty(RetourEnregistrement.Libelle)) then
          begin
             if (empty(TaDepenseLibelle2.AsString)) then
             TaDepenseLibelle2.AsString:=RetourEnregistrement.Libelle
             else
               if (TaDepenseLibelle2.AsString=trim(dernierlibelle)) then
               TaDepenseLibelle2.AsString:=RetourEnregistrement.Libelle;
               DernierLibelle:=RetourEnregistrement.Libelle;
          end;
       end;
 end;

function TDMDepenseEnt.VerifExistDepensesCloture(var messageTmp:string;Mess:boolean):boolean;
Begin
result:=false;
  try
     FiltrageDataSet(DMRech.TaDepensesEntreprisesRech,CreeFiltreET(['DateSaisie'],[DateTimeToStr(E.DatExofin)]));
     result:= DMRech.TaDepensesEntreprisesRech.RecordCount<>0;
      if ((not result)and(mess)) then
         messageTmp:='Aucune Dépense de l''entreprise ou du privé de clôture n''ont été saisies'
      else
         messageTmp:='OK';
  except
   showmessage('problème lors de la vérification de l''existence des Dépenses de l''entreprise ou du privé de clôture');
   abort;
  end;
End;


procedure TDMDepenseEnt.CreationODCloture_avecObjet(TableEnCours:TTable;ODModif:string);
var
ListeOd:TStringList;
SourcePiece:TRecordPiece;
listeFactice:Tlist;
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
       SourcePiece.Validation:=e.DatExoFin;
       SourcePiece.Libelle:=TableEnCours.findfield('Libelle').AsString;
       SourcePiece.Compte:=TableEnCours.findfield('Compte').AsString;
       SourcePiece.Journal:='OD';
       SourcePiece.Reference:=ODModif;
       DMImport.VerifCreationPieceEcriture;
       DMImport.Piece_Import.NouvellePiece(false);

       if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
       DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
       RenvoieInfoSurTableDiverse(DM_C_CompteTVAAutreBiensServices_A1,DMTVACode.TaTvaCode,'Compte',['TvaCode'],Tab);
       compteTvaTemp:=tab[0];
       //remplissage ligne vide
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H'],true,false,-1);
       if TableEnCours.findfield('Sens').AsString='D' then
          begin
          //remplissage de 4 lignes pour l'OD
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte').asstring,'','',0,0,-(TableEnCours.findfield('MontantHT').AsCurrency+TableEnCours.findfield('TVA').AsCurrency),0,'','',0,'',''],true,false,-1);
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte2').asstring,'','',0,0,TableEnCours.findfield('MontantHT').AsCurrency,TableEnCours.findfield('TVA').AsCurrency,'',compteTvaTemp,0,'',''],true,false,-1);
          end
        else
          Begin
          //remplissage de 2 lignes pour l'OD
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte').asstring,'','',0,0,(TableEnCours.findfield('MontantHT').AsCurrency+TableEnCours.findfield('TVA').AsCurrency),0,'','',0,'',''],true,false,-1);
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte2').asstring,'','',0,0,-TableEnCours.findfield('MontantHT').AsCurrency,-TableEnCours.findfield('TVA').AsCurrency,'',compteTvaTemp,0,'',''],true,false,-1);
          End;
       DMImport.RecupPieceEcriture_SurRecords(false,SourcePiece,DMImport.Ecriture_Import.ListeEcriturePiece,ValPieceAutoGen,'','',0);
       ListeOd:=TStringList.Create;
       DMImport.EnregistrementPiece(false,nil,ListeOd,listeFactice);
     except
       if DMImport.messageTmp then
         showmessage('Problème lors de l''enregistrement d''une pièce');
       abort;
     end;//fin du try except
   finally
   Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,DMDepenseEnt,false);
//   if DMImport.Ecriture_Import.ListeEcriturePiece<>nil then
//     Begin
//        DMImport.Ecriture_Import.ListeEcriturePiece.Free;
//        DMImport.Ecriture_Import.ListeEcriturePiece:=nil;
//     End;
   end;//fin du try finally
End;



Procedure TDMDepenseEnt.ImportDepenses(Valeurs:array of const;DataSet:TDataSet);
Begin
  try
   ImportTable(Valeurs,DataSet);
  except
   abort;
  end;
End;

end.
