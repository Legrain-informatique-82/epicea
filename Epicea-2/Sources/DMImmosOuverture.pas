unit DMImmosOuverture;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,
  E2_Decl_Records,
  Gr_Librairie_Obj,
  E2_Librairie_Obj,
  DMPlanCpt,
  LibSQL,
  DMImmos,
  LibDates,
  RXDBCtrl,
  ToolEdit,
  PickDate,
  LibZoneSaisie,
  DMImmo_Clot,
  E2_LibInfosTable,
  DMRecherche,
  LibRessourceString,
  DMConstantes,
  ObjetEdition,
  Printers,
  lib_chaine,
  ChoixPeriode;


type


TParamDMImmos_Ouverture=record
   typeImmos:TtypeImmos;
   Quand:Integer;
   ImmosDataStateChange:TNotifyEvent;
   ImmosBeforeScroll:TDataSetNotifyEvent;
   ImmosAfterScroll:TDataSetNotifyEvent;
   GEstInterfaceEvent:TGEstInterfaceEvent;
  end;

  TInfosDMImmos_Ouverture=Record
    Retour:Boolean;
   end;

  TTypechoisiPourCompte=record
    compte:string;
    choisi:boolean;
  end;

  TDMImmos_Ouverture = class(TDataModule)
    QuRecupImmosSurCpt: TQuery;
    QuRecupImmosSurCptImmobilisation: TStringField;
    QuRecupImmosSurCptValeur_a_Amortir: TCurrencyField;
    QuRecupImmosSurCptID: TIntegerField;
    QuRecupImmosSurCptTypeA: TStringField;
    QuRecupImmosSurCptType_Amt: TStringField;
    QuRecupImmosSurCptEcriture_Cession: TIntegerField;
    QuRecupImmosSurCptCompte: TStringField;
    daRecupImmosSurCpt: TDataSource;
    QuCptUtiliseImmos_Ouverture: TQuery;
    QuCptUtiliseImmos_OuvertureCompte: TStringField;
    QuCptUtiliseImmos_OuvertureLibelle: TStringField;
    DaCptUtiliseImmos_Ouverture: TDataSource;
    taDetailImmo: TTable;
    taDetailImmoID: TIntegerField;
    taDetailImmoLibelle: TStringField;
    taDetailImmoEcriture_Achat: TIntegerField;
    taDetailImmoEcriture_Cession: TIntegerField;
    taDetailImmoCompte: TStringField;
    taDetailImmoCode: TStringField;
    taDetailImmoSous_Code: TStringField;
    taDetailImmoDate_Org: TDateField;
    taDetailImmoValeur_Org: TCurrencyField;
    taDetailImmoValeur_Venale: TCurrencyField;
    taDetailImmoDuree: TSmallintField;
    taDetailImmoValeur_a_Amortir: TCurrencyField;
    taDetailImmoDate_Achat: TDateField;
    taDetailImmoDate_Mise_en_Service: TDateField;
    taDetailImmoDuree_Amt: TSmallintField;
    taDetailImmoType_Amt: TStringField;
    taDetailImmoDeduc_Invest: TBooleanField;
    taDetailImmoMt_Deduc_Invest: TCurrencyField;
    taDetailImmoReprise_deduc_invest: TCurrencyField;
    taDetailImmoValeur_Nette: TCurrencyField;
    taDetailImmoAmort_Eco: TCurrencyField;
    taDetailImmoAmort_Derog: TCurrencyField;
    taDetailImmoMt_Cession: TCurrencyField;
    taDetailImmoDate_Cession: TDateField;
    taDetailImmoRebut: TBooleanField;
    taDetailImmoAchat_dans_Annee: TBooleanField;
    taDetailImmoCession_dans_Annee: TBooleanField;
    taDetailImmoDuree_Restante: TSmallintField;
    taDetailImmoSimulation: TStringField;
    taDetailImmoSous_Compte: TBooleanField;
    taDetailImmoMaxi: TCurrencyField;
    taDetailImmoMini: TCurrencyField;
    taDetailImmoChoix: TCurrencyField;
    taDetailImmoEco: TCurrencyField;
    taDetailImmoTerminee: TBooleanField;
    taDetailImmoEnCours: TBooleanField;
    taDetailImmoCodeTerminee: TStringField;
    taDetailImmoCompteTerminee: TStringField;
    daDetailImmo: TDataSource;
    qryCumulImmos: TQuery;
    qryCumulImmosCompte: TStringField;
    qryCumulImmosLibelle: TStringField;
    qryCumulImmosV_Acq: TCurrencyField;
    qryCumulImmosA_Cumule: TCurrencyField;
    qryCumulImmosVNC: TCurrencyField;
    dsCumulImmos: TDataSource;
    qryTotalCumulImmos: TQuery;
    qryTotalCumulImmosV_Acq: TCurrencyField;
    qryTotalCumulImmosA_Cumule: TCurrencyField;
    qryTotalCumulImmosVNC: TCurrencyField;
    dsTotalCumulImmos: TDataSource;
    QuRecImmos_ParamDivers: TQuery;
    dsDivers: TDataSource;
    QuRecupImmosSurCptDate_Achat: TDateField;
    taDetailImmoTauxAmo: TFloatField;
    taDetailImmoTiers: TStringField;
    taDetailImmoReferenceFacture: TStringField;
    taDetailImmoMontantTTC: TCurrencyField;
    taDetailImmoVNC_Ouverture: TCurrencyField;
    QuRecupImmosSurCptAmortissement: TCurrencyField;
    QuRecupImmosSurCptValeur_Nette: TCurrencyField;
    QuImmosOuverture_Edition: TQuery;
    QuSyntheseImmosOuverture_Edition: TQuery;
    taDetailImmoSousCodeTerminee: TStringField;
    procedure Filtrage_QuRecupImmosSurCpt_SurCpt(Cpt:string;Datefin:Tdate);
    procedure DMImmos_OuvertureCreate(Sender: TObject);
    procedure DMImmos_OuvertureDestroy(Sender: TObject);
    procedure taDetailImmoAfterPost(DataSet: TDataSet);
    procedure taDetailImmoBeforePost(DataSet: TDataSet);
    procedure taDetailImmoPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure taDetailImmoDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    function ExisteNumImmo(table:TTable;Compte,Code,SousCode,IDCourant:string):boolean;
    procedure FiltrageQuRecImmos_ParamDivers(TextSql:string);
    procedure taDetailImmoBeforeEdit(DataSet: TDataSet);
    procedure taDetailImmoAfterDelete(DataSet: TDataSet);
    procedure taDetailImmoBeforeDelete(DataSet: TDataSet);
    procedure taDetailImmoAfterInsert(DataSet: TDataSet);
    function CalculerAmortAnneeSurImmo(Dataset:Tdataset;ID:integer):TAmortImmo;
    procedure taDetailImmoCalcFields(DataSet: TDataSet);
    procedure QuRecupImmosSurCptCalcFields(DataSet: TDataSet);
//    function CtrlSaisieDescriptionAmort_Ouverture(EditCourant:Tfield;EditDate:Twincontrol;var MiseAJourEdit:TRetourCtrlSaisieImmo):TErreurSaisie;
    Function CtrlSuppressionImmosOuverture(Dataset:TDataSet):TExceptLGR;
    function CtrlSaisieDescriptionAmort_Ouverture(EditCourant:Tfield):TExceptLGR;
    procedure AfterEnregistrement_AvecModifDuCompte_et_Sens;
    procedure AfterEnregistrement_Simple;
    procedure qryTotalCumulImmosAfterOpen(DataSet: TDataSet);
    procedure QuRecupImmosSurCptAfterOpen(DataSet: TDataSet);
    procedure taDetailImmoAfterOpen(DataSet: TDataSet);
    procedure qryCumulImmosAfterOpen(DataSet: TDataSet);
    procedure OnfilterRecordImmos_Ouverture_Tous(DataSet: TDataSet;
       var Accept: Boolean);
    procedure OnfilterRecordImmos_Ouverture_2(DataSet: TDataSet;
       var Accept: Boolean);
    procedure OnfilterRecordImmos_Ouverture_131(DataSet: TDataSet;
       var Accept: Boolean);
    procedure GestionFiltrageAideCompte(cpt:string);
    function RecupListeCompteExclus(Cpt:string):tstringlist;
    procedure QuRecupImmosSurCptBeforeInsert(DataSet: TDataSet);
    procedure QuImmosOuverture_EditionFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    { isa  le  21/01/04 }
    procedure GestionAccesEmprunts;
    procedure taDetailImmoBeforeEIDOuv_Abort(DataSet: TDataSet);
    procedure QuCptUtiliseImmos_OuvertureAfterScroll(DataSet: TDataSet);
    Procedure ChangementRepertoireTableImmos;
  private
    { Déclarations privées }
    FOnGEstInterfaceEvent:TGEstInterfaceEvent;

  public
    { Déclarations publiques }
     DerniereDateSaisie:Tdatetime;
     DernierCompteSaisie:string;
     Importation:boolean;
     ImmosEnCours:Tinfosimmos;
     ListeExclus:Tstringlist;
     ListeFilterRecordImmosOuverture:Tstringlist;
     Quand:Integer;
     TypechoisiPourCompte:TTypechoisiPourCompte;
     Procedure ImportImmos(Valeurs:array of const;DataSet:TDataSet);
     property OnGEstInterfaceEvent:TGEstInterfaceEvent read FOnGEstInterfaceEvent write FOnGEstInterfaceEvent;
  end;

  { isa  le  17/10/03 }
   Function EditionDesImmosOuvertureL(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string):Boolean;overload;
   Function EditionDesImmosOuvertureL(TypeEdition : integer; DemandePeriode:Boolean; Compte:String;DataSet:TDataSet;SousTitre:string):Boolean;overload;
   Function EditionDesImmosOuvertureL(TypeEdition : integer; Filtre:string; DemandePeriode:Boolean; DataSet:TDataSet;SousTitre:string):Boolean;overload;
  { isa  le  21/01/04 }
   Function InitialiseDMImmos_Ouverture(ParamDMImmos_Ouverture:TParamDMImmos_Ouverture):TInfosDMImmos_Ouverture;
   { isa  le  12/02/04 }
   Function EditionSyntheseDesImmosOuvertureL(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string):Boolean;overload;
   Function EditionSyntheseDesImmosOuvertureL(TypeEdition : integer; DemandePeriode:Boolean; Compte:String;DataSet:TDataSet;SousTitre:string):Boolean;overload;
   Function EditionSyntheseDesImmosOuvertureL(TypeEdition : integer; Filtre:string; DemandePeriode:Boolean; DataSet:TDataSet;SousTitre:string):Boolean;overload;
   { isa  le  12/02/04 }

var
  DMImmos_Ouverture: TDMImmos_Ouverture;
  CompteTmp,CodeTmp,SousCodeTmp,LibelleTmp:string;
  MontantTmp:currency;
  MontantCourant:currency;
  Amort_EcoTmp:currency;
  Amort_EcoCourant:currency;
  Amort_DerogTmp:currency;
  Amort_DerogCourant:currency;
  LastIDImmos:Integer;
  LastCptImmos:String;
  Mt_deduc_Invest_Tmp:currency;


implementation
uses E2_Immo_Ouverture, E2_AideCompte, DMBalances, DMPiece,DMExports;
{$R *.DFM}


Function InitialiseDMImmos_Ouverture(ParamDMImmos_Ouverture:TParamDMImmos_Ouverture):TInfosDMImmos_Ouverture;
Begin
try//except
result.Retour:=true;
 if DMImmos_Ouverture=nil then DMImmos_Ouverture:=TDMImmos_Ouverture.Create(Application.MainForm);
 if DMRech = Nil then DMRech:=TDMRech.Create(Application.MainForm);
 if AideCompte=nil then AideCompte:=TAideCompte.Create(Application.MainForm);
 DMImmos_Ouverture.OnGEstInterfaceEvent := ParamDMImmos_Ouverture.GEstInterfaceEvent;

 DMImmos_Ouverture.Quand := ParamDMImmos_Ouverture.Quand;
 
 Case DMImmos_Ouverture.Quand Of
      C_Ouverture: Begin //si ouverture
                        DMImmos_Ouverture.ChangementRepertoireTableImmos;
                      DMImmos_Ouverture.daDetailImmo.OnStateChange:=ParamDMImmos_Ouverture.ImmosDataStateChange;
                      DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.AfterScroll:=ParamDMImmos_Ouverture.ImmosAfterScroll;
                      DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.BeforeScroll:=ParamDMImmos_Ouverture.ImmosBeforeScroll;
                      if (DMImmos_Ouverture.daDetailImmo.State in [dsinsert,dsedit]) then
                          DMImmos_Ouverture.taDetailImmo.cancel;
                      if DMImmos_Ouverture.TaDetailImmo.active then DMImmos_Ouverture.TaDetailImmo.close;
                      DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.close;
//                      DMImmos_Ouverture.TaDetailImmo.MasterSource:=DMImmos_Ouverture.daRecupImmosSurCpt;
//                      DMImmos_Ouverture.TaDetailImmo.MasterFields:='ID';
                      case ParamDMImmos_Ouverture.typeImmos of
                         C_Toutes:DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.ParamByName('Cpt').asstring:='%';
                         C_Sub:DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.ParamByName('Cpt').asstring:='131%';
                         C_Immo:DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.ParamByName('Cpt').asstring:='2%';
                      end;//fin du case typecompte
                      DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.ParamByName('Datefin').asdate:=e.DatExoDebut-1;
                      DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.ParamByName('DateDeb').asdate:=e.DatExoDebut-1;
                      DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.open;
                      //DMImmos_Ouverture.TaDetailImmo.open;
                      DMImmos_Ouverture.daDetailImmo.OnStateChange(DMImmos_Ouverture.taDetailImmo);
                      DMImmos_Ouverture.QuCptUtiliseImmos_OuvertureAfterScroll(DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture);
                   End;
 End;
except
  result.Retour:=false;
end;//fin try except
End;

procedure TDMImmos_Ouverture.GestionAccesEmprunts;
Begin
  case Quand of
     C_Ouverture:Begin
                  if E.AccesOuverture then
                   begin
                    taDetailImmo.BeforeInsert := nil;
                    taDetailImmo.BeforeEdit := taDetailImmoBeforeEdit;
                    taDetailImmo.BeforeDelete := taDetailImmoBeforeDelete;
                   end
                  else
                   begin
                    taDetailImmo.BeforeInsert := taDetailImmoBeforeEIDOuv_Abort;
                    taDetailImmo.BeforeEdit := taDetailImmoBeforeEIDOuv_Abort;
                    taDetailImmo.BeforeDelete := taDetailImmoBeforeEIDOuv_Abort;
                   end;
                 End;
  end;
End;

procedure TDMImmos_Ouverture.taDetailImmoBeforeEIDOuv_Abort(DataSet: TDataSet);
Begin
if not e.AccesOuverture then
 MessageDlg('Vous ne pouvez plus modifier les immobilisations d''ouverture !', mtInformation, [mbOK], 0)
 else MessageDlg('Erreur Interne, vous ne devez pas pouvoir modifier les immobilisations d''ouverture !', mtError, [mbOK], 0);
abort;
End;

procedure TDMImmos_Ouverture.Filtrage_QuRecupImmosSurCpt_SurCpt(Cpt:string;Datefin:Tdate);
Begin
QuRecupImmosSurCpt.Close;
QuRecupImmosSurCpt.SQL.Clear;

QuRecupImmosSurCpt.SQL.Add('select Compte + "  " + Code + "  " + Sous_Code + "  " + Libelle as Immobilisation,');
QuRecupImmosSurCpt.SQL.Add('Date_Achat, Valeur_a_Amortir,');
QuRecupImmosSurCpt.SQL.Add('Type_Amt, (Amort_Eco+Amort_Derog)as Amortissement, (Valeur_A_Amortir-Amort_Eco-Amort_Derog)as Valeur_nette, ID,Ecriture_Cession,Compte');
QuRecupImmosSurCpt.SQL.Add('from immos');
QuRecupImmosSurCpt.SQL.Add('where Compte like :Cpt');
QuRecupImmosSurCpt.SQL.Add(' and Date_Achat<= :DateAchat and ((Date_Cession is null)or(Date_Cession >:DateDeb))');


QuRecupImmosSurCpt.SQL.Add('order by Immobilisation');

QuRecupImmosSurCpt.parambyname('Cpt').asstring:=Cpt;
QuRecupImmosSurCpt.parambyname('DateAchat').asDate:=Datefin;
QuRecupImmosSurCpt.parambyname('DateDeb').asDate:=e.DatExoDebut-1;

QuRecupImmosSurCpt.Prepare;
QuRecupImmosSurCpt.open;
End;


//procedure TDMImmos_Ouverture.QuCptUtiliseImmos_OuvertureAfterScroll(
//  DataSet: TDataSet);
//begin
//QuRecupImmosSurCpt.DisableControls;
//Filtrage_QuRecupImmosSurCpt_SurCpt(DMImmos_Ouverture.QuCptUtiliseImmos_OuvertureCompte.asstring,DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.ParamByName('DateFin').asdate);
//
//qryTotalCumulImmos.DisableControls;
//qryTotalCumulImmos.ParamByName('Cpt').asstring:=DMImmos_Ouverture.QuCptUtiliseImmos_OuvertureCompte.AsString;
//qryTotalCumulImmos.Active:=false;
//qryTotalCumulImmos.Open;
//qryTotalCumulImmos.EnableControls;
//
//QuRecupImmosSurCpt.EnableControls;
//end;



procedure TDMImmos_Ouverture.DMImmos_OuvertureCreate(Sender: TObject);
begin
 if DataModuleImmos=nil then
 DataModuleImmos:=TDataModuleImmos.Create(self);

OuvrirTouteTable('',TControl(self));

FormateMonnaieField(taDetailImmo,E.FormatMonnaie,E.EditFormat);

taDetailImmoCode.ValidChars:=(['0'..'9']);
taDetailImmoSous_Code.ValidChars:=(['1'..'9']);
taDetailImmoCompte.ValidChars:=(['0'..'9']);
if ListeExclus=nil then ListeExclus:=TStringList.Create;
if ListeFilterRecordImmosOuverture= nil then ListeFilterRecordImmosOuverture:=TStringList.Create;

Importation:=false;
end;

procedure TDMImmos_Ouverture.DMImmos_OuvertureDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
//FreeAndNil(ListeExclus);
//FreeAndNil(ListeFilterRecordImmosOuverture);
LibereObjet(Tobject(ListeExclus));
LibereObjet(Tobject(ListeFilterRecordImmosOuverture));
//if DataModuleImmos<>nil then  DataModuleImmos.Free;
DMImmos_Ouverture:=nil;
end;

procedure TDMImmos_Ouverture.taDetailImmoAfterPost(DataSet: TDataSet);
begin
  try
    TableGereCommit(DataSet);
    TableGereCommit(DMBalance.TaBalance);
    //raffraîchir les querys
     DMImmos_Ouverture.taDetailImmo.DisableControls;
//     DMImmos_Ouverture.QuRecupImmosSurCpt.DisableControls;
//     DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.DisableControls;
     DMImmos_Ouverture.taDetailImmo.Refresh;

     DMImmos_Ouverture.QuRecupImmosSurCpt.Close;
     DMImmos_Ouverture.QuRecupImmosSurCpt.Open;
     DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.Close;
     DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.Open;
     
     DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.Locate('Compte',LastCptImmos,[]);
     DMImmos_Ouverture.QuRecupImmosSurCpt.Locate('ID',LastIDImmos,[]);

     DMImmos_Ouverture.taDetailImmo.EnableControls;
//     DMImmos_Ouverture.QuRecupImmosSurCpt.EnableControls;
     DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.EnableControls;
  except
    TableGereRollBack(DataSet);
    TableGereRollBack(DMBalance.TaBalance);
    abort;
  end;
end;

procedure TDMImmos_Ouverture.taDetailImmoBeforePost(DataSet: TDataSet);
var
i:integer;
valide:TExceptLGR;
AmortAnnee,AmortOuverture:TAmortImmo;
reference:string;
retourMessagebox:integer;
choix_ouv:Tchoix;
begin
Initialise_ExceptLGR(valide);
QuCptUtiliseImmos_Ouverture.DisableControls;
//QuRecupImmosSurCpt.DisableControls;
initialiserChoix(choix_ouv);
  try

  if  taDetailImmoType_Amt.asstring<>'N' then
    begin
        if VerificationSiPieceDeDotation(reference)then
          begin
      //    if application.MessageBox(Pchar('La pièce de dotation aux amortissement va être supprimée, voulez-vous continuer ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
      //      DMPieces.SuppressionOD(reference)
          if not DMImmo_Clo.SuppressionPieceDeDotationAmortissement(reference)then
            abort;
          end;
     end;
  except
    abort;
  end;
//vérifier que tout soit bien rempli avant de poster
  try
      for i:=1 to 26 do
        Begin
          if not (i in [2,3,10,16])then
//             valide:=DMImmos_Ouverture.CtrlSaisieDescriptionAmort_Ouverture(taDetailImmo.Fields[i],editdateAcquis,retouredit);
             valide:=DMImmos_Ouverture.CtrlSaisieDescriptionAmort_Ouverture(taDetailImmo.Fields[i]);
        if valide.Retour=false then
            abort;
        End;
    //si tout ok, calculer l'identifiant
    if taDetailImmo.State in [dsinsert,dsedit] then
      begin
        if taDetailImmo.State = dsinsert then
          begin
            taDetailImmoID.AsInteger:=MaxId_Query(taDetailImmo,'ID');
          end;
//        taDetailImmoValeur_Nette.AsCurrency:=taDetailImmoValeur_a_Amortir.AsCurrency-(taDetailImmoAmort_Eco.AsCurrency+taDetailImmoAmort_Derog.AsCurrency);//-taDetailImmoChoix.AsCurrency;
        //calculer l'amortissement cumulé au mini ou au maxi depuis mise en service de l'immo
        //puis regarder si l'amort ecrit rentre dans la fourchette calculée
        if  taDetailImmoType_Amt.asstring<>'N' then
          begin//si amortissable
            if not Importation then
              Begin//si non importation
                 AmortOuverture:=CalculerAmortAnneeSurImmo(taDetailImmo,-1);
                 if ((taDetailImmoAmort_Eco.AsCurrency<>AmortOuverture.Mini)and(abs(taDetailImmoAmort_Eco.AsCurrency-AmortOuverture.Mini)>1))then
                    Begin
                      retourMessagebox:=application.MessageBox(Pchar('L''amortissement Economique de cette immobilisation n''est pas cohérent, il devrait être égale à '+currtostr(AmortOuverture.Mini)+', voulez-vous récupérer cette valeur ?'),'Erreur de Saisie',MB_ICONWARNING +MB_YESNOCANCEL+MB_DEFBUTTON1);
                      if retourMessagebox=IDCANCEL then
                        begin
                          DataSet.FieldByName('Amort_Eco').FocusControl;
                          abort;
                        end
                      else
                        if retourMessagebox=IDYES	 then
                          begin
                            taDetailImmoAmort_Eco.AsCurrency:=AmortOuverture.Mini;
                             if(str_commence_par(taDetailImmoCompte.AsString,'262'))then //part sociale
                                 taDetailImmoReprise_deduc_invest.ascurrency:=arrondi((taDetailImmoValeur_a_Amortir.ascurrency/10)*libdates.NbAnneReel(e.DatExoDebut-1,taDetailImmoDate_Achat.AsDateTime),2)
                             else //si immo normale
                                 taDetailImmoReprise_deduc_invest.ascurrency:=arrondi(((taDetailImmoAmort_Eco.ascurrency+taDetailImmoAmort_Derog.ascurrency)
                                   /taDetailImmoValeur_a_Amortir.ascurrency)*taDetailImmoMt_Deduc_Invest.ascurrency,2);

                            valide:=DMImmos_Ouverture.CtrlSaisieDescriptionAmort_Ouverture(taDetailImmo.Fields[20]);
                            if valide.Retour=false then
                               begin
                                //DataSet.FieldByName('Amort_Eco').FocusControl;
                                abort;
                               end;
                          end;
                    End;
              end;//fin si non importation
             //calculer l'amortissement pour l'année en cours
             Remplit_TInfosImmos(taDetailImmo,ImmosEnCours);
             AmortAnnee:=DataModuleImmos.CalculerAmortAnneeSurImmo(ImmosEnCours,e.DatExoDebut,e.DatExoFin,choix_ouv);
//   if AmortAnnee.Choix-AmortAnnee.Derog<>AmortAnnee.EcoRepartition then
   if ((AmortAnnee.Choix-AmortAnnee.Derog<>AmortAnnee.EcoRepartition) and (AmortAnnee.Choix-AmortAnnee.Derog<=AmortAnnee.VNC))then
      AmortAnnee.EcoRepartition:=AmortAnnee.Choix-AmortAnnee.Derog; { isa  le  13/03/04 }

             taDetailImmoEco.AsCurrency:=AmortAnnee.EcoRepartition;
             taDetailImmoMini.AsCurrency:=AmortAnnee.Mini;
             taDetailImmoMaxi.AsCurrency:=AmortAnnee.Maxi;
             taDetailImmoChoix.AsCurrency:=AmortAnnee.Choix;
             if VerifFNumeric(taDetailImmoTauxAmo).Vide then
               taDetailImmoTauxAmo.AsCurrency:=0;
           end;//fin si amortissable
      end;
    //Traitement de mise à jour de la balance des reports
    if taDetailImmo.State=dsedit then
      AfterEnregistrement_AvecModifDuCompte_et_Sens;
    AfterEnregistrement_Simple;
    LastCptImmos:=taDetailImmoCompte.AsString;
    LastIDImmos:=taDetailImmoID.AsInteger;
  except
    DMImmos_Ouverture.taDetailImmo.Fields[i].FocusControl;
    abort;
  end;//fin du try except
end;

procedure TDMImmos_Ouverture.taDetailImmoPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(Dataset);
TableGereRollBack(DMBalance.TaBalance);
end;

procedure TDMImmos_Ouverture.taDetailImmoDeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(Dataset);
TableGereRollBack(DMBalance.TaBalance);
end;

function TDMImmos_Ouverture.ExisteNumImmo(table:TTable;Compte,Code,SousCode,IDCourant:string):boolean;
var
TableTemp:TTable;
Begin
  try
  result:=false;
  TableTemp:=TTable.Create(self);
  TableTemp.DatabaseName:=table.DatabaseName;
  TableTemp.TableName:=table.TableName;
  TableTemp.Open;
  if Table.State=dsedit then
    tabletemp.Filter:='Compte='''+Compte+'''and Code='''+Code+'''and sous_Code='''+SousCode+'''and ID<>'''+IDCourant+''''
  else
    tabletemp.Filter:='Compte='''+Compte+'''and Code='''+Code+'''and sous_Code='''+SousCode+'''';
  tabletemp.filtered:=true;
  if tabletemp.recordcount<>0 then
    result:=true;
  finally
  TableTemp.close;
  tabletemp.Free;
  tabletemp:=nil;
  end;//fin du try finally
End;


//function TDMImmos_Ouverture.TrouveCode(Cpt:string) : string;
//var i:integer; s:string;
//begin
//   with QuRecImmos_ParamDivers do begin
//      Close;
//		SQL.Clear;
//      SQL.Add('select Compte, Code, Sous_Code');
//      SQL.Add('From Immos.db');
//      SQL.Add('Where Compte = "' + Cpt + '"');
//      SQL.Add('Order by Code, Sous_Code');
//      Prepare;
//      Open;
//      if RecordCount > 0 then begin
//         Last;
//         i := StrToInt_Lgr(FindField('Code').AsString);
//         s := IntToStr(i+1);
//         while length(s) < 3 do s := '0' + s;
//         result := s;
//      end
//      else begin
//         result := '001';
//      end;
//		Close;
//      UnPrepare;
//   end;
//end;


//function TDMImmos_Ouverture.Trouve_sous_code(Cpt,code:string): string;
//var i:integer; s:string;
//begin
//  try
//     FiltrageQuRecImmos_ParamDivers('select Compte, Code, Sous_Code From Immos.db Where Compte = "'+Cpt +'" and Code = "' + code + '" Order by Sous_Code');
//     QuRecImmos_ParamDivers.Last;
//        if not empty(QuRecImmos_ParamDivers.FindField('Sous_Code').AsString)then
//        Begin
//        i := StrToInt_Lgr(QuRecImmos_ParamDivers.FindField('Sous_Code').AsString);
//        s := IntToStr(i + 1);
//        result := s;
//        End
//        else
//        result:='0';
//  except
//   result:='';
//   abort;
//  end;
//end;


procedure TDMImmos_Ouverture.FiltrageQuRecImmos_ParamDivers(TextSql:string);
Begin
   try
   QuRecImmos_ParamDivers.Close;
   QuRecImmos_ParamDivers.SQL.Clear;
   QuRecImmos_ParamDivers.SQL.Add(TextSql);
   QuRecImmos_ParamDivers.Open;
   QuRecImmos_ParamDivers.RecordCount;
   except
     showmessage('Problème lors du filtrage d''une immobilisation ');
     abort;
   end;//fin du try except
End;



procedure TDMImmos_Ouverture.taDetailImmoBeforeEdit(DataSet: TDataSet);
begin
  TypechoisiPourCompte.compte:=taDetailImmoCompte.asstring;
  TypechoisiPourCompte.choisi:=true;
  CompteTmp:=taDetailImmoCompte.asstring;
  CodeTmp:=taDetailImmoCode.asstring;
  SousCodeTmp:=taDetailImmoSous_Code.asstring;
  LibelleTmp:=taDetailImmoLibelle.asstring;
  MontantTmp:=taDetailImmoValeur_A_Amortir.AsCurrency;
  MontantCourant:=taDetailImmoValeur_A_Amortir.AsCurrency;
  Amort_EcoTmp:=taDetailImmoAmort_Eco.AsCurrency;
  Amort_EcoCourant:=taDetailImmoAmort_Eco.AsCurrency;
  Amort_DerogTmp:=taDetailImmoAmort_Derog.AsCurrency;
  Amort_DerogCourant:=taDetailImmoAmort_Derog.AsCurrency;
  Mt_deduc_Invest_Tmp:=taDetailImmoMt_Deduc_Invest.AsCurrency;
end;

procedure TDMImmos_Ouverture.taDetailImmoAfterDelete(DataSet: TDataSet);
begin
  try
    TableGereCommit(DataSet);
    TableGereCommit(DMBalance.TaBalance);
    //raffraîchir les querys
     DMImmos_Ouverture.taDetailImmo.DisableControls;
//     DMImmos_Ouverture.QuRecupImmosSurCpt.DisableControls;
//     DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.DisableControls;
     DMImmos_Ouverture.taDetailImmo.Refresh;
     DMImmos_Ouverture.QuRecupImmosSurCpt.Close;
     DMImmos_Ouverture.QuRecupImmosSurCpt.Open;
     DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.Close;
     DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.Open;

     DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.Locate('Compte',LastCptImmos,[]);
     DMImmos_Ouverture.QuRecupImmosSurCpt.Locate('ID',LastIDImmos-1,[]);

     DMImmos_Ouverture.taDetailImmo.EnableControls;
//     DMImmos_Ouverture.QuRecupImmosSurCpt.EnableControls;
     DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.EnableControls;
  except
    TableGereRollBack(DataSet);
    TableGereRollBack(DMBalance.TaBalance);
    abort;
  end;
end;
{-----------------------------------------------------------------------------
  Procedure: TDMImmos_Ouverture.CtrlSuppressionImmosOuverture
  Author:    Blanc Philippe
  Date:      10-sept.-2003
  Arguments: Datase
  Result:    TErreurSaisie
-----------------------------------------------------------------------------}
Function TDMImmos_Ouverture.CtrlSuppressionImmosOuverture(Dataset:TDataSEt):TExceptLGR;
var
reference:string;
Begin
Initialise_ExceptLGR(result);
  try
     if VerifSiCompteSaisieDsBO(DataSet.FindField('Compte').AsString,False,DataSet) then
      begin
       Messagedlg(CompteImporte_DossierDos,mtInformation,[mbok],0);
       Abort;
      end;

  if  taDetailImmoType_Amt.asstring<>'N' then
    begin//si amortissable
    if VerificationSiPieceDeDotation(reference)then
      begin
     if MessageDlg('La suppression de cette immobilisation, '+
                                       RetourChariotDouble+
                                       'va entrainer la suppression de la'+
                                       RetourChariotDouble+
                                       '  PIECE DE DOTATION AUX AMORTISSEMENTS'+
                                       RetourChariotDouble+
                                       'voulez-Vous continuer ?',
                                       mtWarning,
                                       [mbYes,mbNo],
                                       0) = mrYes then
// PB le 10/09/03
//      if application.MessageBox(Pchar('La suppression de cette immobilisation, '+
//                                       RetourChariotDouble+
//                                       'va entrainer la suppression de la'+
//                                       RetourChariotDouble+
//                                       'PIECE DE DOTATION AUX AMORTISSEMENTS'+
//                                       RetourChariotDouble+
//                                       'voulez-vous continuer ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
//      if application.MessageBox(Pchar('La pièce de dotation aux amortissement va être supprimée, voulez-vous continuer ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
      begin
      if not DMImmo_Clo.SuppressionPieceDeDotationAmortissement(reference,false)then
        abort;
      end
      else
        abort;
      end;
    end;//fin si amortissable
Case E.TypeEtatExercice of
 ET_Importation:begin
                  //
                end;
  ET_Normal:    begin
                   if MessageDlg('Êtes-vous sûr de vouloir supprimer cette immobilisation ?', mtConfirmation, [mbYes,mbNo], 0) = mrno then
                     abort;
                end;
end;//fin du case E.TypeEtatExercice

  except
    abort;
  end;

End;


procedure TDMImmos_Ouverture.taDetailImmoBeforeDelete(DataSet: TDataSet);
var
param:TRecupParametres;
compteComptable:TCompteAmortissement;
CompteAmortTmp:TCompteAmortissement;
//reference:string;
Begin
  try
    QuCptUtiliseImmos_Ouverture.DisableControls;
      try
        CtrlSuppressionImmosOuverture(DataSet); // PB le 10/09/03
      except
        abort;
      end;
    try
    //récupération des paramètres de MAJ Balance pour l'immo ou la subvention
    if not VerifFNumeric(taDetailImmoValeur_a_amortir).VideOUZero then
      begin
       if copy(taDetailImmoCompte.AsString,1,1)='2' then
          begin //si Immobilisation
                param.sens1:='Debit_Report';
                param.Qte1:='Qt1_Report';
          end//fin si Immobilisation
       else
         if copy(taDetailImmoCompte.AsString,1,2)='13'then
             begin //si subvention
                param.sens1:='Credit_Report';
                param.Qte1:='Qt2_Report';
             end;//fin si subvention
        //mise à jour balance pour le compte d'immo
        DMBalance.MAJBalance(true,param.qte1,param.sens1,taDetailImmoCompte.AsString,
        taDetailImmoCompte.AsString,0,0,taDetailImmoValeur_a_amortir.AsCurrency,
        taDetailImmoValeur_a_amortir.AsCurrency,dsbrowse);
      end;
        //récupération des paramètres de MAJ Balance pour le compte d'amortissement
    if not VerifFNumeric(taDetailImmoAmort_Eco).VideOUZero then
      begin
        compteComptable:=RecupCompteDotationSurCompteImmo(100,taDetailImmoCompte.AsString);
        if copy(compteComptable.CompteAmort,1,1)='1'then
          begin
            param.sens1:='Debit_Report';
            param.Qte1:='Qt1_Report';
          end
        else
          Begin
            param.sens1:='Credit_Report';
            param.Qte1:='Qt2_Report';
          End;
        //mise à jour balance pour le compte d'Amortissement
        DMBalance.MAJBalance(true,param.qte1,param.sens1,compteComptable.CompteAmort,
        compteComptable.CompteAmort,0,0,taDetailImmoAmort_Eco.AsCurrency,
        taDetailImmoAmort_Eco.AsCurrency,dsbrowse);
      end;
       //récupération des paramètres de MAJ Balance pour le compte 145 (DM_C_CompteAmortDerogatoire)
       if ((not VerifFNumeric(taDetailImmoAmort_Derog).VideOUZero)and(copy(taDetailImmoCompte.AsString,1,1)<>'1')) then
          begin //si amort derogatoire
            if taDetailImmoAmort_Derog.ascurrency<0 then
               begin // si derog negatif
                     param.sens1:='Debit_Report';
                     param.Qte1:='Qt1_Report';
               end//fin si derog negatif
            else
               begin //si derog positif
                  param.sens1:='Credit_Report';
                  param.Qte1:='Qt2_Report';
               end;//fin si derog positif
             //mise à jour balance pour le compte de charges A Payer
             DMBalance.MAJBalance(true,param.qte1,param.sens1,DM_C_CompteAmortDerogatoire,
             DM_C_CompteAmortDerogatoire,0,0,taDetailImmoAmort_Derog.AsCurrency,
             taDetailImmoAmort_Derog.AsCurrency,dsbrowse);
         end; //fin si amort derogatoire
        LastCptImmos:=taDetailImmoCompte.AsString;
        LastIDImmos:=taDetailImmoID.AsInteger;
      except
        TableGereRollBack(DataSet);
        TableGereRollBack(DMBalance.TaBalance);
        abort;
      end;//fin du try except
  Finally
   ReEnableControls(QuCptUtiliseImmos_Ouverture);
  end;
end;

procedure TDMImmos_Ouverture.taDetailImmoAfterInsert(DataSet: TDataSet);
begin
  CompteTmp:=taDetailImmoCompte.asstring;
  CodeTmp:=taDetailImmoCode.asstring;
  SousCodeTmp:=taDetailImmoSous_Code.asstring;
  LibelleTmp:=taDetailImmoLibelle.asstring;
  if DerniereDateSaisie>0 then
    taDetailImmoDate_Achat.AsDateTime:=DerniereDateSaisie;
  if not empty(DernierCompteSaisie) then
    taDetailImmoCompte.AsString:=DernierCompteSaisie;
  MontantTmp:=taDetailImmoValeur_A_Amortir.AsCurrency;
  MontantCourant:=taDetailImmoValeur_A_Amortir.AsCurrency;
  Amort_EcoTmp:=taDetailImmoAmort_Eco.AsCurrency;
  Amort_EcoCourant:=taDetailImmoAmort_Eco.AsCurrency;
  Amort_DerogTmp:=taDetailImmoAmort_Derog.AsCurrency;
  Amort_DerogCourant:=taDetailImmoAmort_Derog.AsCurrency;
  Mt_deduc_Invest_Tmp:=taDetailImmoMt_Deduc_Invest.AsCurrency;
  
InitChampAfterInsert([0,nil,0,0,nil,nil,nil,nil,0,0,0,0,nil,nil,0,nil,false,0,0,0,0,0,0,nil,false,false,false,0,nil,false,0,0,0,0,false,false,nil,nil,0,nil,nil,0],DataSet);

taDetailImmoType_Amt.AsString:='L';
end;


//function TDMImmos_Ouverture.CalculerAmortAnneeSurImmo(Dataset:Tdataset;ID:integer):TAmortImmo;
//var
//MiniCumul,Report:currency;
//Nb_Jour,Nb_Mois,AnneeRestantes,reste:integer;
//DatefinAmo,DatefinAmo2,DateDebutAmo,DebutExo,FinExo,
//DebutExoCalculLin,DebutExoCalculDeg,FinExoCalcul:tdatetime;
//TauxLin, TauxDeg:Extended;
//Mini,Maxi:currency;
//courantValide:boolean;
//A1,M1,J1,A,M,J: Word;
////Debut:boolean;
//Begin
//initialiserAmortissement(result);
////Debut:=true;
//if id=-1 then courantValide:=true
//else
//courantValide:=Dataset.Locate('ID',ID,[]);
//if courantValide then
//  Begin
//     MiniCumul:=0;
//     Nb_Jour:=0;
//     Nb_Mois:=0;
//     result.VNC:=Dataset.FindField('Valeur_a_Amortir').AsCurrency;
//     DebutExoCalculLin:=Dataset.FindField('date_mise_en_service').AsDateTime;
//     DecodeDate(e.DatExoDebut,A,M,J);
//     DecodeDate(DebutExoCalculLin,A1,M1,J1);
//     if M1<M then
//       DebutExo:=EncodeDate(A1-1,M,J)
//     else
//       DebutExo:=EncodeDate(A1,M,J);
//     DecodeDate(Dataset.FindField('date_mise_en_service').AsDateTime,A1,M1,J1);
//     j1:=1;
//     DebutExoCalculDeg:=EncodeDate(A1,M1,J1);
//     FinExoCalcul:=(MoisSuivant(DebutExo,11).Date_-1);
//     report:=0;
//     DateDebutAmo := Dataset.FindField('date_mise_en_service').AsDateTime;
//     if datevalide(Dataset.FindField('date_cession').Asstring) then
//       DatefinAmo:=Dataset.FindField('date_cession').AsDateTime
//     else
//       DatefinAmo:=MoisSuivant(Dataset.FindField('date_mise_en_service').AsDateTime,Dataset.FindField('Duree_Amt').AsInteger-1).Date_;
//     DatefinAmo2:=MoisSuivant(Dataset.FindField('date_mise_en_service').AsDateTime,Dataset.FindField('Duree_Amt').AsInteger-1).Date_;
//     DataModuleImmos.Calcule_taux(Dataset.FindField('Duree_Amt').AsInteger, Dataset.FindField('date_mise_en_service').AsDateTime,Dataset.FindField('Date_Achat').AsDateTime, TauxLin, TauxDeg,Dataset.FindField('TauxAmo').Asfloat);
//     reste:=Dataset.FindField('Duree_Amt').AsInteger mod 12;
//     if reste>0 then
//       AnneeRestantes:=(Dataset.FindField('Duree_Amt').AsInteger div 12)+1
//     else
//       AnneeRestantes:=Dataset.FindField('Duree_Amt').AsInteger div 12;
//     reste:=Dataset.FindField('Duree_Amt').AsInteger;
//     //tant que DebutExo < e.DatExoDebut, faire le calcul pour l'année déterminée et rajouter
//     //au fur et à mesure au calcul précédent
//     while  ((DebutExo<e.DatExoDebut)and(DebutExo<=datefinamo)) do
//     begin
//     Mini:=0;
//     Maxi:=0;
//     if FinExoCalcul>datefinamo then
//       FinExoCalcul:=datefinamo;
//     result.MiniAnnee:=DataModuleImmos.Amort_lin_SurBase360(DebutExoCalculLin,DatefinAmo,Dataset.FindField('date_cession').AsDateTime, Dataset.FindField('Valeur_a_Amortir').AsCurrency,result.Mini, TauxLin,'L',Nb_jour,Dataset.FindField('date_cession').AsDateTime<>0);
//     if ((Dataset.FindField('Type_Amt').AsString = 'L')or(result.MiniAnnee=0)) then
//        Mini :=result.MiniAnnee
//     else
//        Mini :=DataModuleImmos.Amort_lin_SurBase360(DebutExoCalculDeg,DatefinAmo,Dataset.FindField('date_cession').AsDateTime, Dataset.FindField('Valeur_a_Amortir').AsCurrency,result.Mini, TauxLin,Dataset.FindField('Type_Amt').AsString[1],Nb_jour,Dataset.FindField('date_cession').AsDateTime<>0);
//     if Dataset.FindField('Type_Amt').AsString = 'D' then
//         Maxi := DataModuleImmos.Amort_degr(DebutExoCalculDeg,FinExoCalcul,FinExoCalcul,result.VNC-result.Maxi,result.MiniAnnee, TauxDeg,Nb_Mois,AnneeRestantes,Reste,Dataset.FindField('date_cession').AsDateTime<>0)
//       else Maxi := Mini;
//     result.choix:=Mini;
//
//     result.Derog:=result.Derog+result.choix-result.MiniAnnee;
//     result.EcoRepartition:=result.EcoRepartition+result.MiniAnnee;
//     result.Mini:=result.Mini+Mini;
//     result.Maxi:=result.Maxi+Maxi;
//     result.MiniAnnee:=result.MiniAnnee;
//     DebutExo:=MoisSuivant(DebutExo,11).Date_;
//     DebutExoCalculLin:=DebutExo;
//     DebutExoCalculDeg:=DebutExo;
//     FinExoCalcul:=(MoisSuivant(DebutExo,11).Date_-1);
//     dec(AnneeRestantes);
//     reste:=reste-Nb_Mois;
//     //Debut:=false;
//     end;//fin du while
//
//     result.choix:=ArrondiCentieme(result.choix);
//     result.Derog:=arrondicentieme(result.Derog);
//     result.EcoRepartition:=arrondicentieme(result.EcoRepartition);
//     result.Mini:=arrondicentieme(result.Mini);
//     result.Maxi:=arrondicentieme(result.Maxi);
//     result.MiniAnnee:=arrondicentieme(result.MiniAnnee);
//  End;
//End;
function TDMImmos_Ouverture.CalculerAmortAnneeSurImmo(Dataset:Tdataset;ID:integer):TAmortImmo;
var
MiniCumul,Report:currency;
Nb_Jour,Nb_Mois,AnneeRestantes,reste:integer;
DatefinAmo,DateDebutAmo,DebutExo,FinExo,
DebutExoCalculLin,DebutExoCalculDeg,FinExoCalcul:tdatetime;
TauxLin, TauxDeg:Extended;
Mini,Maxi:currency;
courantValide:boolean;
A1,M1,J1,A,M,J: Word;
Derniere_Annee:boolean;
Mess:TMessageLGR;
Begin
initialiserAmortissement(result);
if id=-1 then courantValide:=true
else
courantValide:=Dataset.Locate('ID',ID,[]);
if courantValide then
  Begin
     MiniCumul:=0;
     Nb_Jour:=0;
     Nb_Mois:=0;
     result.VNC:=Dataset.FindField('Valeur_a_Amortir').AsCurrency;
     DebutExoCalculLin:=Dataset.FindField('date_mise_en_service').AsDateTime;
//     DateInfos(e.DatExoDebut)
     DecodeDate(e.DatExoDebut,A,M,J);
     DecodeDate(DebutExoCalculLin,A1,M1,J1);
     if M1<M then
       DebutExo:=EncodeDate(A1-1,M,J)
     else
       DebutExo:=EncodeDate(A1,M,J);
     DecodeDate(Dataset.FindField('date_mise_en_service').AsDateTime,A1,M1,J1);
     j1:=1;
     DebutExoCalculDeg:=EncodeDate(A1,M1,J1);
     FinExoCalcul:=(MoisSuivant(DebutExo,11).Date_-1);
     report:=0;
     DateDebutAmo := Dataset.FindField('date_mise_en_service').AsDateTime;
     if datevalide(Dataset.FindField('date_cession').Asstring) then
       DatefinAmo:=Dataset.FindField('date_cession').AsDateTime
     else
       DatefinAmo:=MoisSuivant(Dataset.FindField('date_mise_en_service').AsDateTime,Dataset.FindField('Duree_Amt').AsInteger-1).Date_;
//       DatefinAmo:=MoisSuivant(DebutExo,Dataset.FindField('Duree_Amt').AsInteger-1).Date_;
     DataModuleImmos.Calcule_taux(Dataset.FindField('Duree_Amt').AsInteger, Dataset.FindField('date_mise_en_service').AsDateTime,Dataset.FindField('Date_Achat').AsDateTime, TauxLin, TauxDeg,Dataset.FindField('TauxAmo').Asfloat);
     reste:=Dataset.FindField('Duree_Amt').AsInteger mod 12;
     if reste>0 then
       AnneeRestantes:=(Dataset.FindField('Duree_Amt').AsInteger div 12)+1
     else
       AnneeRestantes:=Dataset.FindField('Duree_Amt').AsInteger div 12;
     reste:=Dataset.FindField('Duree_Amt').AsInteger;
     //tant que DebutExo < e.DatExoDebut, faire le calcul pour l'année déterminée et rajouter
     //au fur et à mesure au calcul précédent
     while  ((DebutExo<e.DatExoDebut)and(DebutExo<=datefinamo)) do
     begin
     Mini:=0;
     Maxi:=0;
     Derniere_Annee:=DateDsIntervale(debutExo,datefinamo,FinExoCalcul,Mess);

     if FinExoCalcul>datefinamo then
       FinExoCalcul:=datefinamo;
//     result.MiniAnnee:=DataModuleImmos.Amort_lin_SurBase360(DebutExoCalculLin,FinExoCalcul, Dataset.FindField('Valeur_a_Amortir').AsCurrency,result.Mini, TauxLin,Dataset.FindField('Type_Amt').AsString[1],Nb_jour);
     result.MiniAnnee:=DataModuleImmos.Amort_lin_SurBase360(DebutExoCalculLin,FinExoCalcul,Dataset.FindField('date_cession').AsDateTime, Dataset.FindField('Valeur_a_Amortir').AsCurrency,result.Mini, TauxLin,'L',Nb_jour,false,Derniere_Annee,false);
//     AnneeRestantes:=AnneeRestantes-(NbAnne(Dataset.FindField('date_mise_en_service').AsDateTime,DatefinAmo)-1);
//     MiniCumul:=DataModuleImmos.Amort_lin(DebutExoCalcul,FinExoCalcul,DebutExo,FinExoCalcul, Dataset.FindField('Valeur_a_Amortir').AsCurrency,MiniCumul, TauxLin,Nb_jour);
     if ((Dataset.FindField('Type_Amt').AsString = 'L')or(result.MiniAnnee=0)) then
        Mini :=result.MiniAnnee
     else
        //Mini :=DataModuleImmos.CalculMini(result.MiniAnnee+result.Eco,Report,result.VNC);
       //Mini :=DataModuleImmos.Amort_lin_SurBase360(DebutExoCalculLin,FinExoCalcul,Dataset.FindField('date_cession').AsDateTime, Dataset.FindField('Valeur_a_Amortir').AsCurrency,result.Mini, TauxLin,'L',Nb_jour,false);
                Mini :=DataModuleImmos.Amort_lin_SurBase360(DebutExoCalculDeg,FinExoCalcul,Dataset.FindField('date_cession').AsDateTime, Dataset.FindField('Valeur_a_Amortir').AsCurrency,result.Mini, TauxLin,Dataset.FindField('Type_Amt').AsString[1],Nb_jour,false,Derniere_Annee,false);
     if Dataset.FindField('Type_Amt').AsString = 'D' then
         Maxi := DataModuleImmos.Amort_degr(DebutExoCalculDeg,FinExoCalcul,Dataset.FindField('date_cession').AsDateTime,result.VNC-result.Maxi,result.MiniAnnee, TauxDeg,Nb_Mois,AnneeRestantes,Reste,false)
       else Maxi := Mini;
     result.choix:=Mini;
     result.Derog:=result.Derog+result.choix-result.MiniAnnee;
     result.EcoRepartition:=result.EcoRepartition+result.MiniAnnee;
     result.Mini:=result.Mini+Mini;
     result.Maxi:=result.Maxi+Maxi;
     result.MiniAnnee:=result.MiniAnnee;
     DebutExo:=MoisSuivant(DebutExo,11).Date_;
     DebutExoCalculLin:=DebutExo;
     DebutExoCalculDeg:=DebutExo;
     FinExoCalcul:=(MoisSuivant(DebutExo,11).Date_-1);
     dec(AnneeRestantes);
     reste:=reste-Nb_Mois;
     end;//fin du while
     result.choix:=ArrondiCentieme(result.choix);
     result.Derog:=arrondicentieme(result.Derog);
     result.EcoRepartition:=arrondicentieme(result.EcoRepartition);
     result.Mini:=arrondicentieme(result.Mini);
     result.Maxi:=arrondicentieme(result.Maxi);
     result.MiniAnnee:=arrondicentieme(result.MiniAnnee);
     result.compte:=Dataset.FindField('compte').AsString;
  End;
End;



procedure TDMImmos_Ouverture.taDetailImmoCalcFields(DataSet: TDataSet);
begin
taDetailImmoVNC_Ouverture.AsCurrency:=taDetailImmoValeur_a_Amortir.AsCurrency-(taDetailImmoAmort_Eco.AsCurrency+taDetailImmoAmort_Derog.AsCurrency);
end;

procedure TDMImmos_Ouverture.QuRecupImmosSurCptCalcFields(
  DataSet: TDataSet);
begin
   with Dataset do
    begin
      if FieldValues['Type_Amt'] = 'L' then
        FieldValues['TypeA'] := 'Linéaire';
      if FieldValues['Type_Amt'] = 'D' then
        FieldValues['TypeA'] := 'Dégressif';
      if FieldValues['Type_Amt'] = 'N' then
        FieldValues['TypeA'] := 'Non amortissable';
    end;
end;


//function TDMImmos_Ouverture.CtrlSaisieDescriptionAmort_Ouverture(EditCourant:Tfield;EditDate:Twincontrol;var MiseAJourEdit:TRetourCtrlSaisieImmo):TErreurSaisie;
function TDMImmos_Ouverture.CtrlSaisieDescriptionAmort_Ouverture(EditCourant:Tfield):TExceptLGR;
var
date:Tdatetime;
Infosplancpt:TInfosplancpt;
A,M,J:word;
MessageLGR:TMessageLGR;
Begin
try//finally
try//except
//result.NumErreur:=0;
//result.Retour:=true;
// result.GestMessageLGR:=GestMessageLGR;
Initialise_ExceptLGR(result,GestMessageLGR);
 result.NomModule:='CtrlSaisieDescriptionAmort_Ouverture';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;

if DMImmos_Ouverture.taDetailImmo.State in [dsinsert,dsedit]then
  begin//si en insertion ou modification

       case EditCourant.Index of
       //////////////  Libelle
         1:Begin //si edit  Libelle
            if ((empty(LibelleTmp))or(LibelleTmp<>editcourant.AsString))then
              Begin//si modification
                if empty(EditCourant.AsString)then
                  begin
                  EditCourant.AsString:=DMPlan.LibelleDuNumCptPCU(taDetailImmocompte.asstring);
                  LastLibImmo:=editcourant.AsString;
                  end
                else
                  Begin// si le libellé est déjà rempli, regarder
                    if ((LastLibImmo=libelletmp)and (LastLibImmo<>'')and (LastLibImmo<>DMPlan.LibelleDuNumCptPCU(taDetailImmocompte.asstring)))then
                       begin
                       EditCourant.AsString:=DMPlan.LibelleDuNumCptPCU(taDetailImmocompte.asstring);
                       LastLibImmo:=editcourant.AsString;
                       end;
                  End;
              End;//fin si modification
           end;//fin si edit libelle
       //////////////  Compte
         4:Begin //si edit Compte
            if ((empty(compteTmp))or(compteTmp<>editcourant.AsString))then
              Begin //si modification
              if ((TypechoisiPourCompte.compte<>editcourant.AsString)or(empty(TypechoisiPourCompte.compte))) then
                begin
                  TypechoisiPourCompte.choisi:=false;
                  TypechoisiPourCompte.compte:=editcourant.AsString;
                end;
//               if VerifSiCompteSaisieDsBO(editcourant.AsString,true,editcourant.DataSet) then
//                  begin
//                   result.Retour := false;
//                   result.CodeErreur:=4000;//compte verrouillé
//                  end
//                else
//                  begin
                           /// à vérifier ////
                    if Importation then
                      GestionFiltrageAideCompte('%')
                    else
                      GestionFiltrageAideCompte(QuCptUtiliseImmos_Ouverture.ParamByName('Cpt').asstring);
                           //***************//

                    if Importation then MessDerSub:=false;
                    result.retour:=AideCompteDansContexte(editcourant.AsString,editcourant,['Rac1'],false,MessDerSub,true,true,false,false,0);
                    if result.retour then result.retour:=((ListeExclus.IndexOf(copy(editcourant.asstring,1,3))=-1) and (ListeExclus.IndexOf(copy(editcourant.asstring,1,2))=-1));
                    if result.retour then result.retour:=not(VerifSiCompteSaisieDsBO(editcourant.AsString,true,editcourant.DataSet));
                    Infosplancpt:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[editcourant.AsString]);
                    if result.Retour then
                      Begin //si compte rempli, vérifier si correct et pré-remplir le reste
                         //compteTmp:=editcourant.AsString;
                         result.retour:=Infosplancpt.Immobilisation;
                         if not result.retour then
                           result.NumErreur:=4001//compte pas correct, pas dans plan immo
                         else
                           begin//si correct, regarder si le numéro d'immo n'existe pas déjà
                           result.Retour:=not(DMImmos_Ouverture.ExisteNumImmo(taDetailImmo,editcourant.AsString,taDetailImmoCode.AsString,taDetailImmoSous_code.AsString,taDetailImmoID.asstring));
                           if not result.Retour then
                             begin
                             result.NumErreur:=4002;//compte pas correct, déjà existant
                             end;
                           end;//fin si correct, regarder si le numéro d'immo n'existe pas déjà
                         if result.Retour then
                           Begin //si correct, remplir le code, souscode, libellé par défaut
                              ////traiter le libellé par défaut
                              if empty(taDetailImmolibelle.AsString)then
                                begin
                                taDetailImmolibelle.AsString:=DMPlan.LibelleDuNumCptPCU(taDetailImmocompte.asstring);
                                LastLibImmo:=taDetailImmolibelle.AsString;
                                end
                              else
                                Begin// si le libellé est déjà rempli, regarder
                                  if ((LastLibImmo=libelleTmp) and (LastLibImmo<>'')and (LastLibImmo<>DMPlan.LibelleDuNumCptPCU(taDetailImmocompte.asstring)))then
                                     begin
                                     taDetailImmolibelle.AsString:=DMPlan.LibelleDuNumCptPCU(taDetailImmocompte.asstring);
                                     LastLibImmo:=taDetailImmolibelle.AsString;
                                     end;
                                End;
                              //traiter le code par défaut
                              if empty(taDetailImmocode.AsString)then
                                begin
                                taDetailImmocode.AsString:=DataModuleImmos.TrouveCode(taDetailImmocompte.asstring);
                                Lastcode:=taDetailImmocode.AsString;
                                end
                              else
                                Begin// si le libellé est déjà rempli, regarder
                                  if ((Lastcode=codetmp)and (DMImmos_Ouverture.ExisteNumImmo(DMImmos_Ouverture.taDetailImmo,taDetailImmocompte.AsString,taDetailImmocode.AsString,taDetailImmoSous_code.AsString,taDetailImmoID.asstring)))then
                                     begin
                                     taDetailImmocode.AsString:=DataModuleImmos.TrouveCode(taDetailImmocompte.asstring);
                                     Lastcode:=taDetailImmocode.AsString;
                                     end;
                                End;
                              //traiter le souscode par défaut
                              if empty(taDetailImmoSous_code.AsString)then
                                begin
                                taDetailImmoSous_code.AsString:=DataModuleImmos.Trouve_sous_code(taDetailImmocompte.asstring,taDetailImmocode.asstring);
                                LastSousCode:=taDetailImmoSous_code.AsString;
                                end
                              else
                                Begin// si le libellé est déjà rempli, regarder
                                  if ((LastSousCode=Souscodetmp)and (DMImmos_Ouverture.ExisteNumImmo(taDetailImmo,taDetailImmocompte.AsString,taDetailImmocode.AsString,taDetailImmoSous_code.AsString,taDetailImmoID.asstring)))then
                                     begin
                                     taDetailImmoSous_code.AsString:=DataModuleImmos.Trouve_sous_code(taDetailImmocompte.asstring,taDetailImmocode.asstring);
                                     LastSousCode:=taDetailImmoSous_code.AsString;
                                     end;
                                End;
                           End;// fin si correct, remplir le code, souscode, libellé par défaut
                            Infosplancpt:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[taDetailImmoCompte.AsString]);
                             if ((not DataModuleImmos.Amortissable(taDetailImmoCompte.AsString).devenirAmortissable){and(EditCourant.DataSet.DataSource.State=dsinsert)}) then
                               Begin
                                taDetailImmoType_Amt.AsString:='N';
                               End
                             else
                               Begin
                                 if TypechoisiPourCompte.choisi=false then
                                   begin
                                       //if DMImmos_Ouverture.taDetailImmo.State=dsinsert then
                                          begin
                                            if Infosplancpt.ImmoDegressif then
                                              taDetailImmoType_Amt.AsString:='D'
                                            else
                                              taDetailImmoType_Amt.AsString:='L';
                                          end;
                                   end;
                               End;
                      End//fin si compte rempli
                  else
                      begin//si pas correct
    //                  showmessage('Ce compte n''est pas correct dans ce contexte.');
                      result.NumErreur:=4003;//compte pas correct, déjà existant
                      end;//fin si pas correct
                  //end;
              if not result.retour then
                begin//si retour false
                  case result.NumErreur of
                     4001:showmessage('Le compte '+taDetailImmoCompte.AsString+' ne fait pas partie du plan des immobilisations.');
                     4002:showmessage('Le Code et sous-Code  '+taDetailImmocode.AsString+' '+taDetailImmoSous_code.AsString+' existe déjà pour une immobilisation portant sur le même compte');
                     4003:showmessage('Le compte  '+taDetailImmoCompte.AsString+' n''est pas correct dans ce contexte.');
                  end;//fin du case
                end;//fin si retour false
              MessDerSub:=true;
              end;//fin si modification
           end; //fin si edit compte
       //////////////  Code
         5:Begin //si edit Code
            if ((empty(codeTmp))or(codeTmp<>editcourant.AsString))then
              Begin// si modification
                if empty(editcourant.AsString)then
                  editcourant.AsString:=DataModuleImmos.TrouveCode(taDetailImmocompte.asstring)
                else
                  Begin// si le code est déjà rempli, regarder
                    result.Retour:=not(DMImmos_Ouverture.ExisteNumImmo(taDetailImmo,taDetailImmocompte.AsString,editcourant.AsString,taDetailImmoSous_code.AsString,DMImmos_Ouverture.taDetailImmoID.asstring));
                    if ((result.retour)and (taDetailImmocode.AsString='000'))then taDetailImmocode.AsString:=DataModuleImmos.TrouveCode(taDetailImmocompte.asstring);
                    if ((Lastcode=taDetailImmocode.AsString)and (result.retour=false))then
                       taDetailImmocode.AsString:=DataModuleImmos.TrouveCode(taDetailImmocompte.asstring);
                  End;
                if result.Retour then
                  Lastcode:=editcourant.AsString;
                if result.Retour=false then
                   begin
                   showmessage('Le Code '+taDetailImmocode.AsString+' existe déjà pour une immobilisation ayant sur le même compte et le même sous-Code');
                   result.NumErreur:=5001;
                   end;
              end;//fin si modification
           end;// fin si edit Code
       //////////////  SousCode
         6:Begin //si edit SousCode
            if ((empty(SousCodeTmp))or(SousCodeTmp<>editcourant.AsString))then
              Begin// si modification
               if empty(editcourant.AsString)then
                 editcourant.AsString:=DataModuleImmos.Trouve_sous_code(taDetailImmocompte.asstring,taDetailImmocode.asstring)
               else
                 Begin// si le libellé est déjà rempli, regarder
                   result.Retour:=not(DMImmos_Ouverture.ExisteNumImmo(taDetailImmo,taDetailImmocompte.AsString,taDetailImmocode.AsString,editcourant.AsString,taDetailImmoID.asstring));
                   if ((LastSousCode=editcourant.AsString)and (result.retour=false))then
                      editcourant.AsString:=DataModuleImmos.Trouve_sous_code(taDetailImmocompte.asstring,taDetailImmocode.asstring);
                 End;
                if result.Retour then
                  LastSousCode:=editcourant.AsString;
                if result.Retour=false then
                   begin
                   showmessage('Le sous-Code '+taDetailImmoSous_code.AsString+' existe déjà pour une immobilisation ayant le même compte et le même code');
                   result.NumErreur:=6001;
                   end;
              end;//fin si modification
           end;//fin si edit SousCode
       //////////////  date_org
        7:Begin //si edit Date réelle d'Achat(date_org)
           if not ((empty(editcourant.asstring))or(trim(editcourant.asstring)<>'/  /'))then
             begin// si date remplie
               if not DateValide(EditCourant.Text)then
                 Begin
//                    //déclencher le popupdate
//                    date:=e.DatExoDebut-1;
//                    PopupDate(date,EditDate);
//                    editcourant.AsDateTime:=Date;
                     MessageDlg('La date '+editcourant.asstring+' n'+#39+'est pas correcte',mtWarning,[mbOK],0);
                     result.NumErreur:=12001;
                     result.Retour:=false;
                 End
                 else
                 if EditCourant.AsDateTime>=e.DatExoDebut then
                   begin
                     showmessage('La date d''achat réel d"amortissement doit-être inférieur à l''exercice courant.');
                     result.NumErreur:=12001;
                     result.Retour:=false;
                   end;
             end//fin si date remplie
           else
             Begin

             End;
           end;//fin si edit Date réelle d'Achat(DateAchat)
       //////////////  Valeur_vénale
         9:Begin //si edit Valeur vénale
              //editcourant.AsCurrency:=ValeurAcquis.Field.AsCurrency-Amo_Derog.Field.AsCurrency-Amo_Eco.Field.AsCurrency;
           end;
       //////////////  Valeur_a_amortir
         11:Begin //si edit Valeur Acquisition(Valeur_a_amortir)
//             if not Importation then
//             begin
               if ((empty(EditCourant.AsString))or(EditCourant.AsCurrency=0)) then
                 begin
                     //tout initialiser car si pas de valeur, alors pas de durée ni de report d'amort
                      EditCourant.dataset.FindField('Type_amt').asstring:='N';
                      TypechoisiPourCompte.choisi:=false;
//                    result.Retour := false;
//                    MessageDlg('Le montant '+EditCourant.AsString+' n'+#39+'est pas correct',mtWarning,[mbOK],0);
//                    result.CodeErreur:=7001;
                 end
               else
                   CtrlSaisieDescriptionAmort_Ouverture(taDetailImmoType_Amt);
//             end;
               MontantCourant:=EditCourant.ascurrency;
           end;//fin si edit Valeur Acquisition(Valeur_Org)
       //////////////  Date_Achat
         12:Begin //si edit Date Acquisition(Date_Achat)
               if not empty(EditCourant.asstring)then
                  begin //si la date est remplie
                    if not DateValide(EditCourant.asstring)then
                      Begin //si la date n'est pas valide
                        MessageDlg('La date '+EditCourant.asstring+' n'+#39+'est pas correcte',mtWarning,[mbOK],0);
                        result.NumErreur:=12001;
                        result.Retour:=false;
                      End;//fin si la date n'est pas valide
                  end //fin si la date est remplie
               else
                  Begin //si la date est vide
                    //déclencher le popupdate
                     MessageDlg('La date '+EditCourant.asstring+' n'+#39+'est pas correcte',mtWarning,[mbOK],0);
                     result.NumErreur:=12001;
                     result.Retour:=false;
//                    Application.MessageBox(Pchar('Vous devez saisir une date de pièce, !!!'),'Erreur de saisie',0);
                  End;//fin si la date est vide
            if EditCourant.AsDateTime>=e.DatExoDebut then
              Begin
                showmessage('La date d''acquisition doit être antérieure à l''exercice courant.');
                result.NumErreur:=12001;
                result.Retour:=false;
              End;    
           End;//fin si edit Date Acquisition(Date_Achat)
       //////////////  Date_mise_en_service
         13:Begin //si edit Date mise en service(debut amortissement)
              if empty(editcourant.asstring)then
                begin
                editcourant.AsDateTime:=taDetailImmoDate_Achat.asdatetime;
                end
              else
               if not DateValide(EditCourant.Text)then
                 Begin
                    //déclencher le popupdate
                     result.NumErreur:=12001;
                     result.Retour:=false;
                 End;
           end; //fin si edit Date mise en service(debut amortissement)
       //////////////  Duree_Amt
         14:Begin //si edit Durée amortissement(Duree_Amt)
             if taDetailImmoValeur_a_Amortir.Ascurrency<>0 then
                 begin//si valeur à amortir <>0, je contrôle
                     if (((Empty(EditCourant.AsString))or(EditCourant.Asinteger=0))and(taDetailImmoType_Amt.AsString<>'N')) then
                        begin
                           showmessage('La durée d"amortissement doit-être renseignée.');
                           result.NumErreur:=9001;//date pas renseignée
                           result.Retour:=false;
                        end
                     else
                     if ((EditCourant.Asinteger < 12)and(taDetailImmoType_Amt.AsString<>'N')) then
                        begin
                        result.Retour := false;
                        result.NumErreur:=9002;//date inférieure à 12 mois
                        MessageDlg('La durée d"amortissement doit être supérieure à 12 mois',mtWarning,[mbOK],0);
                        end;
                 end//fin si valeur à amortir <>0, je contrôle
               else
                 taDetailImmoType_Amt.AsString:='N';
           end;
       //////////////  Type_amt
         15:Begin //si edit Type amort
              Infosplancpt:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[taDetailImmoCompte.AsString]);
               if ((not DataModuleImmos.Amortissable(taDetailImmoCompte.AsString).devenirAmortissable){and(EditCourant.DataSet.DataSource.State=dsinsert)}) then
                 Begin
                  taDetailImmoType_Amt.AsString:='N';
                 End
               else
                 Begin
                   if TypechoisiPourCompte.choisi=false then
                     begin
                         //if DMImmos_Ouverture.taDetailImmo.State=dsinsert then
                            begin
                              if Infosplancpt.ImmoDegressif then
                                taDetailImmoType_Amt.AsString:='D'
                              else
                                taDetailImmoType_Amt.AsString:='L';
                            end;
                          TypechoisiPourCompte.choisi:=true;
                     end;
                 End;
              DernierCompteSaisie:=taDetailImmoCompte.asstring;
             if taDetailImmoValeur_a_Amortir.ascurrency=0 then
                taDetailImmoType_Amt.AsString:='N';
             if taDetailImmoType_Amt.AsString='N' then
               Begin //alors pas de report d'amortissement
                  taDetailImmoDuree_Amt.asinteger:=0;
                  taDetailImmoAmort_Eco.ascurrency:=0;
                  taDetailImmoAmort_Derog.ascurrency:=0;
                  taDetailImmoEco.ascurrency:=0;
                  taDetailImmoMini.ascurrency:=0;
                  taDetailImmoMaxi.ascurrency:=0;
                  taDetailImmoChoix.ascurrency:=0;
               end;
         if(taDetailImmoValeur_a_Amortir.AsCurrency<>MontantCourant)then
           begin
           Mt_deduc_Invest_Tmp:=0;
           CtrlSaisieDescriptionAmort_Ouverture(taDetailImmoMt_Deduc_Invest);
           end;
           end;
       //////////////  Mt_Deduc_Invest
         17:Begin //si edit Montant Deduction
            //si changement de valeur, alors pre-remplir la reprise de déduction
            if (Mt_deduc_Invest_Tmp=0) or (Mt_deduc_Invest_Tmp<>editcourant.AsCurrency) then
              begin
              if(taDetailImmoValeur_a_Amortir.ascurrency=0)then
                      taDetailImmoReprise_deduc_invest.ascurrency:=0
              else
                begin                                                // and(not libdates.DateDsIntervale(E.DatExoDebut,taDetailImmoDate_Achat.AsDateTime,E.DatExoFin)))
                 if(str_commence_par(taDetailImmoCompte.AsString,'262'))then //part sociale
                     taDetailImmoReprise_deduc_invest.ascurrency:=arrondi((taDetailImmoMt_Deduc_Invest.ascurrency/10)*libdates.NbAnneReel(e.DatExoDebut-1,taDetailImmoDate_Achat.AsDateTime),2)
                 else //si immo normale
                     if(taDetailImmoValeur_a_Amortir.ascurrency<>0) then
                     taDetailImmoReprise_deduc_invest.ascurrency:=arrondi(((taDetailImmoAmort_Eco.ascurrency+taDetailImmoAmort_Derog.ascurrency)
                       /taDetailImmoValeur_a_Amortir.ascurrency)*taDetailImmoMt_Deduc_Invest.ascurrency,2)
                     else taDetailImmoReprise_deduc_invest.ascurrency:=0;
                end;
              end;
           Mt_deduc_Invest_Tmp:=EditCourant.AsCurrency;
           end;
       //////////////  Reprise_Deduc_Invest
         18:Begin //si edit Reprise Deduc
            if taDetailImmoReprise_deduc_invest.ascurrency>taDetailImmoMt_Deduc_Invest.ascurrency then
                taDetailImmoReprise_deduc_invest.ascurrency:=taDetailImmoMt_Deduc_Invest.ascurrency;
           end;
       //////////////  valeur_nette
         19:Begin //si edit valeur nette
              if VerifFNumeric(EditCourant).Vide then
                EditCourant.AsCurrency:=0;
            end;
       //////////////  Amort_eco
         20:Begin //si edit Amort eco
              if VerifFNumeric(EditCourant).Vide then
                EditCourant.AsCurrency:=0;
               if ((taDetailImmoType_Amt.AsString='N')and(taDetailImmoAmort_Eco.AsCurrency<>0)) then
                   raise ExceptLGR.Create('Cette immobilisation n''est pas amortissable, if ne peut donc pas y avoir d''amortissement économique',20000,true,mtError,Result);
               if taDetailImmoAmort_Eco.AsCurrency>taDetailImmoValeur_a_Amortir.AsCurrency then
                 begin
//                   result.Retour := false;
//                   result.NumErreur:=20001;//Amor_Eco>valeur_a_Amortir
                   raise ExceptLGR.Create('L"amortissement économique ne peut pas être supérieure à la valeur à amortir',20001,true,mtError,Result);
                   //MessageDlg('',mtWarning,[mbOK],0);
                 end;
               if result.retour then
                 begin
                    if taDetailImmoAmort_Eco.AsCurrency+taDetailImmoAmort_Derog.AsCurrency>taDetailImmoValeur_a_Amortir.AsCurrency then
                       begin
//                         result.Retour := false;
//                         result.NumErreur:=20002;//
                         raise ExceptLGR.Create('Incohérence dans les montants !!',20002,true,mtError,Result);
                         //MessageDlg('',mtWarning,[mbOK],0);
                       end;
                 end;
                 if(taDetailImmoAmort_Eco.AsCurrency<>Amort_EcoCourant)then
                   begin
                   Mt_deduc_Invest_Tmp:=0;
                   CtrlSaisieDescriptionAmort_Ouverture(taDetailImmoMt_Deduc_Invest);
                   end;
               Amort_EcoCourant:=EditCourant.AsCurrency;
            end;
       //////////////  Amort_dérog
         21:Begin //si edit Amort dérog
              if VerifFNumeric(EditCourant).Vide then
                EditCourant.AsCurrency:=0;
               if ((taDetailImmoType_Amt.AsString='N')and(taDetailImmoAmort_Derog.AsCurrency<>0)) then
                   raise ExceptLGR.Create('Cette immobilisation n''est pas amortissable, if ne peut donc pas y avoir d''amortissement dérogatoire',20000,true,mtError,Result);
               if taDetailImmoAmort_Derog.AsCurrency>taDetailImmoValeur_a_Amortir.AsCurrency then
                 begin
//                   result.Retour := false;
//                   result.NumErreur:=20001;//Amor_Eco>valeur_a_Amortir
                   raise ExceptLGR.Create('L"amortissement dérogatoire ne peut pas être supérieure à la valeur à amortir',20001,true,mtError,Result);
                   //MessageDlg('',mtWarning,[mbOK],0);
                 end;
               if result.retour then
                 begin
                    if taDetailImmoAmort_Eco.AsCurrency+taDetailImmoAmort_Derog.AsCurrency>taDetailImmoValeur_a_Amortir.AsCurrency then
                       begin
//                         result.Retour := false;
//                         result.NumErreur:=20002;//
                         raise ExceptLGR.Create('Incohérence dans les montants !!',20002,true,mtError,Result);
                         //MessageDlg('',mtWarning,[mbOK],0);
                       end;
                 end;
                 if(taDetailImmoAmort_Derog.AsCurrency<>Amort_DerogCourant)then
                   begin
                   Mt_deduc_Invest_Tmp:=0;
                   CtrlSaisieDescriptionAmort_Ouverture(taDetailImmoMt_Deduc_Invest);
                   end;
               Amort_DerogCourant:=EditCourant.AsCurrency;
            end;
       //////////////  Achat_dans_Annee
         25:Begin //si Achat_dans_Annee
             if DateDsIntervale(e.DatExoDebut,taDetailImmoDate_Achat.AsDateTime,e.DatExoFin,MessageLGR) then
               begin
                  taDetailImmoAchat_dans_Annee.AsBoolean:=true;
               end;
           end;//fin si edit Achat_dans_Annee
       //////////////  Cession_dans_Annee
         26:Begin //si edit Cession_dans_Annee
             if DateDsIntervale(e.DatExoDebut,taDetailImmoDate_Cession.AsDateTime,e.DatExoFin,MessageLGR) then
               begin
                  taDetailImmoCession_dans_Annee.AsBoolean:=true;
               end;
           end;//fin si edit Cession_dans_Annee
       end;//fin du case EditCourant.Tag
  end;//fin si en insertion ou modification
except
  result.retour:=false;
end;
finally
  result.GestMessageLGR.Enregistrement:=false;
end;
End;



procedure TDMImmos_Ouverture.AfterEnregistrement_AvecModifDuCompte_et_Sens;
var
param:TRecupParametres;
compteComptable:TCompteAmortissement;
CompteAmortTmp:TCompteAmortissement;
Begin
try
//récupération des paramètres de MAJ Balance pour l'immo ou la subvention
//qui a été modifiée
  if montantTmp<>0 then
    begin
       if copy(compteTmp,1,1)='2' then
          begin //si Immobilisation
                param.sens1:='Debit_Report';
                param.Qte1:='Qt1_Report';
          end//fin si Immobilisation
       else
         if copy(compteTmp,1,2)='13'then
             begin //si subvention
                param.sens1:='Credit_Report';
                param.Qte1:='Qt2_Report';
             end;//fin si subvention
        if empty(compteTmp)then abort;
        //mise à jour balance pour le compte d'immo qui a été modifié
        DMBalance.MAJBalance(true,param.qte1,param.sens1,compteTmp,
        compteTmp,0,0,montantTmp,
        montantTmp,dsbrowse);
     end;
    //récupération des paramètres de MAJ Balance pour le compte d'amortissement
    //qui a été modifié
  if Amort_EcoTmp<>0 then
    begin
       CompteAmortTmp:=RecupCompteDotationSurCompteImmo(100,CompteTmp);
       
       if copy(CompteAmortTmp.CompteAmort,1,1)='1'then
         begin
           param.sens1:='Debit_Report';
           param.Qte1:='Qt1_Report';
         end
       else
         Begin
           param.sens1:='Credit_Report';
           param.Qte1:='Qt2_Report';
         End;
       if empty(CompteAmortTmp.CompteAmort)then abort;
       //mise à jour balance pour le compte d'Amortissement
       DMBalance.MAJBalance(true,param.qte1,param.sens1,CompteAmortTmp.CompteAmort,
       CompteAmortTmp.CompteAmort,0,0,Amort_EcoTmp,
       Amort_EcoTmp,dsbrowse);
    end;
   //récupération des paramètres de MAJ Balance pour le compte 145 (DM_C_CompteAmortDerogatoire)
   //pour supprimer le derogatoire modifié
   if ((Amort_DerogTmp<>0)and(copy(CompteTmp,1,1)<>'1')) then
      begin //si amort derogatoire
        if Amort_DerogTmp<0 then
           begin // si derog negatif
                 param.sens1:='Debit_Report';
                 param.Qte1:='Qt1_Report';
           end//fin si derog negatif
        else
           begin //si derog positif
              param.sens1:='Credit_Report';
              param.Qte1:='Qt2_Report';
           end;//fin si derog positif
         if empty(DM_C_CompteAmortDerogatoire) then abort;
         //mise à jour balance pour le compte du derogatoire
         DMBalance.MAJBalance(true,param.qte1,param.sens1,DM_C_CompteAmortDerogatoire,
         DM_C_CompteAmortDerogatoire,0,0,Amort_DerogTmp,
         Amort_DerogTmp,dsbrowse);
     end; //fin si amort derogatoire
except
  showmessage('Problème lors de la mise à jour de la balance d''une immobilisation d''ouverture');
  abort;
end;
End;



procedure TDMImmos_Ouverture.AfterEnregistrement_Simple;
var
param:TRecupParametres;
compteComptable:TCompteAmortissement;
CompteAmortTmp:TCompteAmortissement;
Begin
try
//récupération des paramètres de MAJ Balance pour l'immo ou la subvention
    if not VerifFNumeric(taDetailImmoValeur_a_amortir).VideOUZero then
      begin
         if copy(taDetailImmoCompte.AsString,1,1)='2' then
            begin //si Immobilisation
                  param.sens1:='Debit_Report';
                  param.Qte1:='Qt1_Report';
            end//fin si Immobilisation
         else
           if copy(taDetailImmoCompte.AsString,1,2)='13'then
               begin //si subvention
                  param.sens1:='Credit_Report';
                  param.Qte1:='Qt2_Report';
               end;//fin si subvention
          if empty(taDetailImmoCompte.AsString)then abort;
          //mise à jour balance pour le compte d'immo
          DMBalance.MAJBalance(false,param.qte1,param.sens1,taDetailImmoCompte.AsString,
          compteTmp,0,0,taDetailImmoValeur_a_amortir.AsCurrency,
          montantTmp,dsinsert);
      end;
    //récupération des paramètres de MAJ Balance pour le compte d'amortissement
    if not VerifFNumeric(taDetailImmoAmort_Eco).VideOUZero then
      begin
      compteComptable:=RecupCompteDotationSurCompteImmo(100,taDetailImmoCompte.AsString);
      CompteAmortTmp:=RecupCompteDotationSurCompteImmo(100,CompteTmp);
      if copy(compteComptable.CompteAmort,1,1)='1'then
        begin
          param.sens1:='Debit_Report';
          param.Qte1:='Qt1_Report';
        end
      else
        Begin
          param.sens1:='Credit_Report';
          param.Qte1:='Qt2_Report';
        End;
      if empty(compteComptable.CompteAmort)then abort;
      //mise à jour balance pour le compte d'Amortissement
      DMBalance.MAJBalance(false,param.qte1,param.sens1,compteComptable.CompteAmort,
      CompteAmortTmp.CompteAmort,0,0,taDetailImmoAmort_Eco.AsCurrency,
      Amort_EcoTmp,dsinsert);
      end;
   //récupération des paramètres de MAJ Balance pour le compte 145 (DM_C_CompteAmortDerogatoire)
   if ((not VerifFNumeric(taDetailImmoAmort_Derog).VideOUZero)and(copy(taDetailImmoCompte.AsString,1,1)<>'1')) then
      begin //si amort derogatoire
        if taDetailImmoAmort_Derog.ascurrency<0 then
           begin // si derog negatif
                 param.sens1:='Debit_Report';
                 param.Qte1:='Qt1_Report';
           end//fin si derog negatif
        else
           begin //si derog positif
              param.sens1:='Credit_Report';
              param.Qte1:='Qt2_Report';
           end;//fin si derog positif
         if empty(DM_C_CompteAmortDerogatoire)then abort;
         //mise à jour balance pour le compte de charges A Payer
         DMBalance.MAJBalance(false,param.qte1,param.sens1,DM_C_CompteAmortDerogatoire,
         DM_C_CompteAmortDerogatoire,0,0,taDetailImmoAmort_Derog.AsCurrency,
         Amort_DerogTmp,dsinsert);
     end; //fin si amort derogatoire
except
  showmessage('Problème lors de la mise à jour de la balance d''une immobilisation d''ouverture');
  abort;
end;
End;

procedure TDMImmos_Ouverture.qryTotalCumulImmosAfterOpen(
  DataSet: TDataSet);
begin
FormateMonnaieField(dataset,E.FormatMonnaie,'');
end;

procedure TDMImmos_Ouverture.QuRecupImmosSurCptAfterOpen(
  DataSet: TDataSet);
begin
FormateMonnaieField(dataset,E.FormatMonnaie,'');
if taDetailImmo.Active=false then taDetailImmo.open; 
end;

procedure TDMImmos_Ouverture.taDetailImmoAfterOpen(DataSet: TDataSet);
begin
FormateValidCharCurrField(taDetailImmo,['0'..'9',DecimalSeparator]);
FormateMonnaieField(taDetailImmo,E.FormatMonnaie,'0.00');
end;

procedure TDMImmos_Ouverture.qryCumulImmosAfterOpen(DataSet: TDataSet);
begin
//FormateValidCharCurrField(qryCumulImmos,['0'..'9',DecimalSeparator]);
FormateMonnaieField(qryCumulImmos,E.FormatMonnaie,'');
end;


procedure TDMImmos_Ouverture.OnfilterRecordImmos_Ouverture_Tous(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
    try
    if ((dataset.name<>'QuLibelle')and (ListeExclus<>nil))then
      accept:=((DataSet.FindField('immobilisation').asboolean)and(ListeExclus.IndexOf(copy(DataSet.FindField('Compte').AsString,1,3))=-1)and(ListeExclus.IndexOf(copy(DataSet.FindField('Compte').AsString,1,2))=-1)and(length(DataSet.FindField('Compte').AsString)>2)) ;
      if ((accept) and (ParamUtil.PlanDeSaisie = true) and (DMPLan.AideCompteVisible = true)) then
         accept:=DataSet.FindField('PlanSaisie').asBoolean;
    except
      accept:=true;
    end;
  end;
end;

procedure TDMImmos_Ouverture.OnfilterRecordImmos_Ouverture_2(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
    try
    if dataset.name<>'QuLibelle'then
      accept:=((DataSet.FindField('immobilisation').asboolean)and(ListeExclus.IndexOf(copy(DataSet.FindField('Compte').AsString,1,3))=-1)and(ListeExclus.IndexOf(copy(DataSet.FindField('Compte').AsString,1,2))=-1)and(copy(DataSet.FindField('Compte').AsString,1,1)='2')and(length(DataSet.FindField('Compte').AsString)>2)) ;
      if ((accept) and (ParamUtil.PlanDeSaisie = true) and (DMPLan.AideCompteVisible = true)) then
         accept:=DataSet.FindField('PlanSaisie').asBoolean;
    except
      accept:=true;
    end;
  end;
end;

procedure TDMImmos_Ouverture.OnfilterRecordImmos_Ouverture_131(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
    try
    if dataset.name<>'QuLibelle'then
      accept:=((DataSet.FindField('immobilisation').asboolean)and(ListeExclus.IndexOf(copy(DataSet.FindField('Compte').AsString,1,3))=-1)and(ListeExclus.IndexOf(copy(DataSet.FindField('Compte').AsString,1,2))=-1)and(copy(DataSet.FindField('Compte').AsString,1,2)='13')and(length(DataSet.FindField('Compte').AsString)>2)) ;
      if ((accept) and (ParamUtil.PlanDeSaisie = true) and (DMPLan.AideCompteVisible = true)) then
         accept:=DataSet.FindField('PlanSaisie').asBoolean;
    except
      accept:=true;
    end;
  end;
end;

procedure TDMImmos_Ouverture.GestionFiltrageAideCompte(cpt:string);
Begin
try
if ListeExclus= nil then ListeExclus:=TStringList.Create
else
  ListeExclus.Clear;
ListeExclus:=RecupListeCompteExclus(cpt);
  if cpt='2%'then
  begin //si uniquement les immos
    DMPlan.FiltrageAideCompte(43,ListeExclus,OnfilterRecordImmos_Ouverture_2);
  end;//fin si uniquement les immos

  if cpt='13%'then
  begin//si uniquement les subventions
    DMPlan.FiltrageAideCompte(43,ListeExclus,OnfilterRecordImmos_Ouverture_131);
  end;//fin si uniquement les subventions

  if cpt='%'then
  begin//si toutes
    DMPlan.FiltrageAideCompte(43,nil,OnfilterRecordImmos_Ouverture_tous);
  end;//fin si toutes
finally
  //
end;
End;


Procedure TDMImmos_Ouverture.ImportImmos(Valeurs:array of const;DataSet:TDataSet);
Begin
  try
   ImportTable(Valeurs,DataSet);
   Importation:=false;
  except
   abort;
  end;
End;

function TDMImmos_Ouverture.RecupListeCompteExclus(Cpt:string):tstringlist;
var
filtre:TFiltre;
Regime:string;
Begin
try
Result:=tstringlist.Create;
filtre.filtre:=DMPlan.TaParamCpt.Filter;
filtre.filtrer:=DMPlan.TaParamCpt.filtered;
regime:=e.Regime;
  if cpt='2%'then
  begin //si uniquement les immos
  FiltrageDataSet(DMPlan.TaParamCpt,CreeFiltreET(['Regime','Famille'],[regime,'36']));
  Result:=ChampTableVersListe('rac1',DMPlan.TaParamCpt);
  end;//fin si uniquement les immos

  if cpt='13%'then
  begin//si uniquement les subventions
  FiltrageDataSet(DMPlan.TaParamCpt,CreeFiltreet(['Regime','Famille'],[regime,'37']));
  Result:=ChampTableVersListe('rac1',DMPlan.TaParamCpt);
  end;//fin si uniquement les subventions

  if cpt='%'then
  begin//si toutes
  FiltrageDataSet(DMPlan.TaParamCpt,CreeFiltreET(['Regime','Famille'],[regime,'36']));
  Result:=ChampTableVersListe('rac1',DMPlan.TaParamCpt);
  FiltrageDataSet(DMPlan.TaParamCpt,CreeFiltreet(['Regime','Famille'],[regime,'37']));
  Result:=ChampTableVersListe('rac1',DMPlan.TaParamCpt);
  end;//fin si toutes
finally
  if ((filtre.filtrer)and(not empty(filtre.filtre))) then
    FiltrageDataSet(DMPlan.TaParamCpt,filtre.filtre)
  else
    DeFiltrageDataSet(DMPlan.TaParamCpt);
end;

End;

procedure TDMImmos_Ouverture.QuRecupImmosSurCptBeforeInsert(
  DataSet: TDataSet);
begin
abort;
end;


Function EditionDesImmosOuvertureL(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string):Boolean;
var
periode:TPeriode;
i,J:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
compteTmp:string;
Compteur:integer;
ValeurNetteEco,ValeurNetteFiscale:currency;
TotalCompteVal,TotalCompteDeduc,TotalCompteEco,TotalComptederog,TotalCompteNetteEco,TotalCompteNetteFiscale:currency;
TotalVal,TotalDeduc,TotalEco,Totalderog,TotalNetteEco,TotalNetteFiscale:currency;
Requete:TQuery;
TitreCompte:string;
ParamAffichPeriode:TParamAffichPeriode;
dateDebutImmos:Tdate;
RepertoireImmos : String;
ListeEdition:Tstringlist;
begin
try
if E.ExerciceCloture then
  Begin //si exo clôturé
    if FileExists(DMBalance.TaBalance.Database.Directory+'Immos.db') then
      RepertoireImmos := DMBalance.TaBalance.DatabaseName
    else
      RepertoireImmos := DMPieces.TaPiece.DatabaseName;
  end //fin si exo clôturé
else
  begin //si exo non clôturé
    RepertoireImmos := DMPieces.TaPiece.DatabaseName;
  end;//fin si exo non clôturé

ObjPrn:=TObjetEdition.Create(application.MainForm);
TotalCompteVal:=0;
TotalCompteDeduc:=0;
TotalVal:=0;
TotalDeduc:=0;

Requete:=TQuery.Create(application.MainForm);
Requete.SQL.Clear;
Requete.SQL.Add('select min(Date_achat) as DateDeb');

Requete.SQL.Add('from immos.db where compte is not null');
Requete.DatabaseName:=RepertoireImmos;
Requete.open;
if ((requete.recordcount<>0)and(not empty(Requete.findfield('DateDeb').Asstring)))then
  dateDebutImmos:=Requete.findfield('DateDeb').AsDateTime
else
  dateDebutImmos:=e.DatExoDebut-1;
  if DemandePeriode then
   begin
     if Choix_Periode=nil then Choix_Periode:=tChoix_Periode.Create(application.MainForm);
     Choix_Periode.EdDateFin.Enabled:=false;
     Initialise_ParamAffichPeriode(ParamAffichPeriode);
     periode:=ChoixPeriodeAffich(dateDebutImmos,e.DatExoDebut-1,'',ParamAffichPeriode)
   end
  else
    begin
     periode.Retour := true;
     periode.DateDeb := dateDebutImmos;
     periode.DateFin :=  E.DatExoDebut-1;
    end;
  if periode.Retour then
   begin

    ObjPrn.FontLigneSeule.Style := [fsBold];

    ListeValeur:=TStringList.Create;
    ListeEdition:=TStringList.Create;

    if DMImmos_Ouverture =nil then DMImmos_Ouverture:=TDMImmos_Ouverture.Create(Application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
        DMImmos_Ouverture.QuImmosOuverture_Edition.DatabaseName:=RepertoireImmos;
        DMImmos_Ouverture.ListeFilterRecordImmosOuverture.clear;
        if (Compte<>nil)and(compte.Count=0)then abort;
        if Compte<>nil then      // Tous les comptes
         begin
          TitreCompte:='Du compte :'+compte.Strings[0]+' au compte :'+compte.Strings[compte.count-1];
          DMImmos_Ouverture.ListeFilterRecordImmosOuverture.Assign(compte);
          DMImmos_Ouverture.QuImmosOuverture_Edition.OnFilterRecord:=DMImmos_Ouverture.QuImmosOuverture_EditionFilterRecord;
          DMImmos_Ouverture.QuImmosOuverture_Edition.filtered:=true;
         end
        else
          begin
            DMImmos_Ouverture.QuImmosOuverture_Edition.OnFilterRecord:=nil;
            TitreCompte:=' Tous les comptes ';
          end;
          DMImmos_Ouverture.QuImmosOuverture_Edition.Close;
          DMImmos_Ouverture.QuImmosOuverture_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
          DMImmos_Ouverture.QuImmosOuverture_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
          DMImmos_Ouverture.QuImmosOuverture_Edition.Open;
          DMImmos_Ouverture.QuImmosOuverture_Edition.First;
          if DMImmos_Ouverture.QuImmosOuverture_Edition.recordcount<>0 then
          begin
          Compteur:=0;
          compteTmp:=DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Compte').AsString;
          ListeValeur.Add('9;COMPTE : '+GereLibelle(compteTmp));

          TotalCompteVal:=0;
          TotalCompteDeduc:=0;
          TotalCompteEco:=0;
          TotalComptederog:=0;
          TotalCompteNetteEco:=0;
          TotalCompteNetteFiscale:=0;
          TotalVal:=0;
          TotalDeduc:=0;
          TotalEco:=0;
          Totalderog:=0;
          TotalNetteEco:=0;
          TotalNetteFiscale:=0;
          ListeEdition.add('Compte ; Code ; S/Code ;Désignation ; Type ; Durée ; Date Achat ; Date Amort. ; Valeur Org. ; Déduc. Invest. ; CumulEco ; CumulDerog ; NetteEco ; NetteFiscale ');

          while not DMImmos_Ouverture.QuImmosOuverture_Edition.Eof do
            begin
                ValeurNetteEco:=(DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Valeur_A_Amortir').AsCurrency-DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Amort_eco').AsCurrency);
                ValeurNetteFiscale:=(DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Valeur_A_Amortir').AsCurrency-(DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Amort_eco').AsCurrency+DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Amort_derog').AsCurrency));
                  ListeEdition.Add(GereLibelle(DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Compte').AsString)+
                                   ';'+
                                   GereLibelle(DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Code').AsString)+
                                   ';'+
                                   GereLibelle(DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Sous_Code').AsString)+
                                   ';'+
                                   GereLibelle(DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Libelle').AsString)+
                                   ';'+
                                   DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Type_Amt').AsString+
                                   ';'+
                                   DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Duree_Amt').AsString+
                                   ';'+
                                   DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Date_Achat').AsString+
                                   ';'+
                                   DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Date_Mise_en_service').AsString+
                                   ';'+
                                   DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Valeur_A_Amortir').AsString+
                                   ';'+
                                   DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Mt_Deduc_Invest').AsString+
                                   ';'+
                                   DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Amort_eco').AsString+
                                   ';'+
                                   DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Amort_derog').AsString+
                                   ';'+
                                   currtostr(ValeurNetteEco)+
                                   ';'+
                                   currtostr(ValeurNetteFiscale)
                                   );
                  ListeValeur.Add('0'+
                                   ';'+
                                   GereLibelle(DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Code').AsString)+
                                   ';'+
                                   GereLibelle(DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Sous_Code').AsString)+
                                   ';'+
                                   GereLibelle(DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Libelle').AsString)+
                                   ';'+
                                   DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Type_Amt').AsString+
                                   ';'+
                                   DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Duree_Amt').AsString+
                                   ';'+
                                   DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Date_Achat').AsString+
                                   ';'+
                                   DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Date_Mise_en_service').AsString+
                                   ';'+
                                   DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Valeur_A_Amortir').AsString+
                                   ';'+
                                   DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Mt_Deduc_Invest').AsString+
                                   ';'+
                                   DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Amort_eco').AsString+
                                   ';'+
                                   DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Amort_derog').AsString+
                                   ';'+
                                   currtostr(ValeurNetteEco)+
                                   ';'+
                                   currtostr(ValeurNetteFiscale)
                                   );
                   TotalCompteVal:=TotalCompteVal+DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Valeur_A_Amortir').AsCurrency;
                   TotalCompteDeduc:=TotalCompteDeduc+DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Mt_Deduc_Invest').AsCurrency;
                   TotalCompteEco:=TotalCompteEco+DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Amort_eco').AsCurrency;
                   TotalComptederog:=TotalComptederog+DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Amort_derog').AsCurrency;
                   TotalCompteNetteEco:=TotalCompteNetteEco+ValeurNetteEco;
                   TotalCompteNetteFiscale:=TotalCompteNetteFiscale+ValeurNetteFiscale;
                   inc(Compteur);
                   DMImmos_Ouverture.QuImmosOuverture_Edition.Next;
              if compteTmp<>DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Compte').AsString then
                begin
                  compteTmp:=DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Compte').AsString;
                  ListeValeur.Add('3;;;;;;; @TOTAL COMPTE : ;'+CurrToStr(TotalCompteVal) +';'+CurrToStr(TotalCompteDeduc)+';'+CurrToStr(TotalCompteEco)+';'+CurrToStr(TotalComptederog)+';'+CurrToStr(TotalCompteNetteEco)+';'+CurrToStr(TotalCompteNetteFiscale));
                  ListeValeur.Add('9;COMPTE : '+GereLibelle(compteTmp));
                  TotalVal:=TotalVal+TotalCompteVal;
                  TotalDeduc:=TotalDeduc+TotalCompteDeduc;
                  TotalEco:=TotalEco+TotalCompteEco;
                  Totalderog:=Totalderog+TotalComptederog;
                  TotalNetteEco:=TotalNetteEco+TotalCompteNetteEco;
                  TotalNetteFiscale:=TotalNetteFiscale+TotalCompteNetteFiscale;

                  TotalCompteVal:=0;
                  TotalCompteDeduc:=0;
                  TotalCompteEco:=0;
                  TotalComptederog:=0;
                  TotalCompteNetteEco:=0;
                  TotalCompteNetteFiscale:=0;
                end;
            end;//fin du while not DataModuleImmos.QuAcquisition_Edition.eof
             compteTmp:=DMImmos_Ouverture.QuImmosOuverture_Edition.FindField('Compte').AsString;
             ListeValeur.Add('3;;;;;;; @TOTAL COMPTE : ;'+CurrToStr(TotalCompteVal) +';'+CurrToStr(TotalCompteDeduc)+';'+CurrToStr(TotalCompteEco)+';'+CurrToStr(TotalComptederog)+';'+CurrToStr(TotalCompteNetteEco)+';'+CurrToStr(TotalCompteNetteFiscale));
             TotalVal:=TotalVal+TotalCompteVal;
             TotalDeduc:=TotalDeduc+TotalCompteDeduc;
             TotalEco:=TotalEco+TotalCompteEco;
             Totalderog:=Totalderog+TotalComptederog;
             TotalNetteEco:=TotalNetteEco+TotalCompteNetteEco;
             TotalNetteFiscale:=TotalNetteFiscale+TotalCompteNetteFiscale;

             ListeValeur.Add('8;Nombre total d''immobilisation : '+ inttostr(Compteur));

             ListeValeur.Add('1;;;;;;; @TOTAL DES IMMOBILISATIONS D''OUVERTURE : ;'+CurrToStr(TotalVal) +';'+CurrToStr(TotalDeduc)+';'+CurrToStr(TotalEco)+';'+CurrToStr(Totalderog)+';'+CurrToStr(TotalNetteEco)+';'+CurrToStr(TotalNetteFiscale));
             ObjPrn.FTitreEdition := ' TABLEAUX DES IMMOBILISATIONS D''OUVERTURE ';
             ObjPrn.FSousTitreEdition:=SousTitre;
             ObjPrn.FTitre2Edition :=TitreCompte;
             ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
             ObjPrn.FTitre3Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr  ;
             ObjPrn.Orientation:=poLandscape;
             j:=0;
             ListeValeur.Insert(0,'  ;  ;  ;  ;  ;  ;  ;  ;  ; Eco ; Derog ; Eco ; Fiscale ');
             ListeValeur.Insert(1,'0.4;0.2;1.8;0.2;0.4;0.7;0.7;0.7;0.7;0.7;0.7;0.7;0.7');//9.2
             ListeValeur.Insert(2,'texte;texte;texte;texte;float;texte;texte;curr;curr;curr;curr;curr;curr');
             ListeValeur.Insert(3,' Immobilisation ; T. ; Durée ; Date Achat ; Date Amort. ; Valeur Org. ; Déduc. Invest. ; Situation Debut Exercice ;SURTITRE');
             ListeValeur.Insert(4,'2.4;0.2;0.4;0.7;0.7;0.7;0.7;2.8'); //9.2
             ListeValeur.Insert(5,' Code ; S/C. ;Désignation ;  ;  ;  ;  ;  ;  ; Cumul ; Valeur nette ;SURTITRE');
             ListeValeur.Insert(6,'0.4;0.2;1.8;0.2;0.4;0.7;0.7;0.7;0.7;1.4;1.4'); //9.2
          end;
     if TypeEdition=C_Exportation then
        ExportDonnees(ListeEdition,E.RepertoireExportDossier,'Immos_Ouverture_'+E.NomDossier + E.NomExo + '.Txt')
     else
       ObjPrn.AffichageImp(ListeValeur);
  end;//fin du periode.retour
finally
  if Choix_Periode<>nil then Choix_Periode.EdDateFin.Enabled:=true;
  LibereObjet(Tobject(Requete));
  LibereObjet(Tobject(ObjPrn));
  Initialise_TStringlist(ListeEdition);
end;
end;



Function EditionDesImmosOuvertureL(TypeEdition : integer; DemandePeriode:Boolean; Compte:string;DataSet:TDataSet;SousTitre:string):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(Retour);
  try
   Maliste:=TStringList.Create;
   if not empty (Compte)then
     Maliste.Add(Compte)
   else
     raise ExceptLGR.Create('Aucun Compte n''est defini !',1000,true,mtError,Retour);
   EditionDesImmosOuvertureL(TypeEdition,DemandePeriode,Maliste,DataSet,SousTitre);
  except
     abort;
  end;
end;

Function EditionDesImmosOuvertureL(TypeEdition : integer; Filtre:string; DemandePeriode:Boolean; DataSet:TDataSet;SousTitre:string):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(Retour);
  try
   Maliste:=TStringList.Create;
   if not empty (Filtre)then
     begin
      FiltrageDataSet(dmrech.TaPlanCptRech,CreeFiltreET(['compte','Immobilisation'],[Filtre,True]));
      Maliste:=ChampTableVersListeEx(['compte'],dmrech.TaPlanCptRech,';',false);
     end
   else
     raise ExceptLGR.Create('Aucun Compte n''est defini !',1000,true,mtError,Retour);
   EditionDesImmosOuvertureL(TypeEdition,DemandePeriode,Maliste,DataSet,SousTitre);
  except
     abort;
  end;
end;


Function EditionSyntheseDesImmosOuvertureL(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string):Boolean;
var
periode:TPeriode;
i,J:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
compteTmp:string;
Compteur:integer;
ValeurNetteEco,ValeurNetteFiscale:currency;
TotalCompteVal,TotalCompteDeduc,TotalCompteEco,TotalComptederog,TotalCompteNetteEco,TotalCompteNetteFiscale:currency;
TotalVal,TotalDeduc,TotalEco,Totalderog,TotalNetteEco,TotalNetteFiscale:currency;
Requete:TQuery;
TitreCompte:string;
ParamAffichPeriode:TParamAffichPeriode;
dateDebutImmos:Tdate;
RepertoireImmos : string;
begin
try
if E.ExerciceCloture then
  Begin //si exo clôturé
    if FileExists(DMBalance.TaBalance.Database.Directory+'Immos.db') then
      RepertoireImmos := DMBalance.TaBalance.DatabaseName
    else
      RepertoireImmos := DMPieces.TaPiece.DatabaseName;
  end //fin si exo clôturé
else
  begin //si exo non clôturé
    RepertoireImmos := DMPieces.TaPiece.DatabaseName;
  end;//fin si exo non clôturé
ObjPrn:=TObjetEdition.Create(application.MainForm);
TotalCompteVal:=0;
TotalCompteDeduc:=0;
TotalVal:=0;
TotalDeduc:=0;

Requete:=TQuery.Create(application.MainForm);
Requete.SQL.Clear;
Requete.SQL.Add('select min(Date_achat) as DateDeb');
Requete.SQL.Add('from immos');
Requete.DatabaseName:=RepertoireImmos;
Requete.open;
if ((requete.recordcount<>0)and(not empty(Requete.findfield('DateDeb').Asstring)))then
  dateDebutImmos:=Requete.findfield('DateDeb').AsDateTime
else
  dateDebutImmos:=e.DatExoDebut-1;
  if DemandePeriode then
   begin
     if Choix_Periode=nil then Choix_Periode:=tChoix_Periode.Create(application.MainForm);
     Choix_Periode.EdDateFin.Enabled:=false;
     Initialise_ParamAffichPeriode(ParamAffichPeriode);
     periode:=ChoixPeriodeAffich(dateDebutImmos,e.DatExoDebut-1,'',ParamAffichPeriode)
   end
  else
    begin
     periode.Retour := true;
     periode.DateDeb := dateDebutImmos;
     periode.DateFin :=  E.DatExoDebut-1;
    end;
  if periode.Retour then
   begin

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;

    if DMImmos_Ouverture =nil then DMImmos_Ouverture:=TDMImmos_Ouverture.Create(Application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
        DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.DatabaseName:=RepertoireImmos;
        DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.sql.Clear;
        DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.sql.add('select count(id)as NB_Immos_Compte,compte,P.libelle,sum(Valeur_a_amortir) as Valeur_a_amortir,');
        DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.sql.add(' sum(Amort_eco)as Amort_eco,sum(Amort_Derog)as Amort_Derog,sum(Mt_Deduc_Invest)as Mt_Deduc_Invest');
        DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.sql.add(' from immos I JOIN "'+E.RepertoireDossier+'PlanCpt" P ON (I.compte=P.compte)');
        DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.sql.add(' where  date_achat  between :DateDeb and  :DateFin');
        DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.sql.add(' and ((date_cession >:datefin)or(date_cession is null))');
        DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.sql.add(' group by compte,P.libelle');
        DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.sql.add(' order by Compte');
        DMImmos_Ouverture.ListeFilterRecordImmosOuverture.clear;
        if (Compte<>nil)and(compte.Count=0)then abort;
        if Compte<>nil then      // Tous les comptes
         begin
          TitreCompte:='Du compte :'+compte.Strings[0]+' au compte :'+compte.Strings[compte.count-1];
          DMImmos_Ouverture.ListeFilterRecordImmosOuverture.Assign(compte);
          DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.OnFilterRecord:=DMImmos_Ouverture.QuImmosOuverture_EditionFilterRecord;
          DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.filtered:=true;
         end
        else
          begin
            DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.OnFilterRecord:=nil;
            TitreCompte:='Tous les comptes ';
          end;
          DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.Close;
          DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
          DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
          DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.Open;
          DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.First;
          if DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.recordcount<> 0 then
          begin
          Compteur:=0;
          compteTmp:=DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.FindField('Compte').AsString;
          ListeValeur.Add('9;COMPTE : '+GereLibelle(compteTmp));

          TotalCompteVal:=0;
          TotalCompteDeduc:=0;
          TotalCompteEco:=0;
          TotalComptederog:=0;
          TotalCompteNetteEco:=0;
          TotalCompteNetteFiscale:=0;
          TotalVal:=0;
          TotalDeduc:=0;
          TotalEco:=0;
          Totalderog:=0;
          TotalNetteEco:=0;
          TotalNetteFiscale:=0;

          while not DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.Eof do
            begin
                ValeurNetteEco:=(DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.FindField('Valeur_A_Amortir').AsCurrency-DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.FindField('Amort_eco').AsCurrency);
                ValeurNetteFiscale:=(DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.FindField('Valeur_A_Amortir').AsCurrency-(DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.FindField('Amort_eco').AsCurrency+DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.FindField('Amort_derog').AsCurrency));

                  ListeValeur.Add('0'+
                                   ';'+
                                   GereLibelle(DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.FindField('compte').AsString)+
                                   ';'+
                                   GereLibelle(DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.FindField('Libelle').AsString)+
                                   ';'+
                                   DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.FindField('Valeur_A_Amortir').AsString+
                                   ';'+
                                   DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.FindField('Mt_Deduc_Invest').AsString+
                                   ';'+
                                   DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.FindField('Amort_eco').AsString+
                                   ';'+
                                   DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.FindField('Amort_derog').AsString+
                                   ';'+
                                   currtostr(ValeurNetteEco)+
                                   ';'+
                                   currtostr(ValeurNetteFiscale)
                                   );
                   TotalCompteVal:=TotalCompteVal+DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.FindField('Valeur_A_Amortir').AsCurrency;
                   TotalCompteDeduc:=TotalCompteDeduc+DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.FindField('Mt_Deduc_Invest').AsCurrency;
                   TotalCompteEco:=TotalCompteEco+DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.FindField('Amort_eco').AsCurrency;
                   TotalComptederog:=TotalComptederog+DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.FindField('Amort_derog').AsCurrency;
                   TotalCompteNetteEco:=TotalCompteNetteEco+ValeurNetteEco;
                   TotalCompteNetteFiscale:=TotalCompteNetteFiscale+ValeurNetteFiscale;
                   inc(Compteur,DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.FindField('NB_Immos_Compte').Asinteger);

                   DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.Next;
              if compteTmp<>DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.FindField('Compte').AsString then
                begin
                  compteTmp:=DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.FindField('Compte').AsString;
                  ListeValeur.Add('3;; @TOTAL COMPTE : ;'+CurrToStr(TotalCompteVal) +';'+CurrToStr(TotalCompteDeduc)+';'+CurrToStr(TotalCompteEco)+';'+CurrToStr(TotalComptederog)+';'+CurrToStr(TotalCompteNetteEco)+';'+CurrToStr(TotalCompteNetteFiscale));
                  ListeValeur.Add('9;COMPTE : '+GereLibelle(compteTmp));
                  TotalVal:=TotalVal+TotalCompteVal;
                  TotalDeduc:=TotalDeduc+TotalCompteDeduc;
                  TotalEco:=TotalEco+TotalCompteEco;
                  Totalderog:=Totalderog+TotalComptederog;
                  TotalNetteEco:=TotalNetteEco+TotalCompteNetteEco;
                  TotalNetteFiscale:=TotalNetteFiscale+TotalCompteNetteFiscale;

                  TotalCompteVal:=0;
                  TotalCompteDeduc:=0;
                  TotalCompteEco:=0;
                  TotalComptederog:=0;
                  TotalCompteNetteEco:=0;
                  TotalCompteNetteFiscale:=0;
                end;
            end;//fin du while not DataModuleImmos.QuAcquisition_Edition.eof
               compteTmp:=DMImmos_Ouverture.QuSyntheseImmosOuverture_Edition.FindField('Compte').AsString;
               ListeValeur.Add('3;; @TOTAL COMPTE : ;'+CurrToStr(TotalCompteVal) +';'+CurrToStr(TotalCompteDeduc)+';'+CurrToStr(TotalCompteEco)+';'+CurrToStr(TotalComptederog)+';'+CurrToStr(TotalCompteNetteEco)+';'+CurrToStr(TotalCompteNetteFiscale));
               TotalVal:=TotalVal+TotalCompteVal;
               TotalDeduc:=TotalDeduc+TotalCompteDeduc;
               TotalEco:=TotalEco+TotalCompteEco;
               Totalderog:=Totalderog+TotalComptederog;
               TotalNetteEco:=TotalNetteEco+TotalCompteNetteEco;
               TotalNetteFiscale:=TotalNetteFiscale+TotalCompteNetteFiscale;

               ListeValeur.Add('8;Nombre total d''immobilisation : '+ inttostr(Compteur));
               ListeValeur.Add('1;; @TOTAL IMMOBILISATIONS D''OUVERTURE: ;'+CurrToStr(TotalVal) +';'+CurrToStr(TotalDeduc)+';'+CurrToStr(TotalEco)+';'+CurrToStr(Totalderog)+';'+CurrToStr(TotalNetteEco)+';'+CurrToStr(TotalNetteFiscale));
               ObjPrn.FTitreEdition := ' SYNTHESE DU TABLEAUX DES IMMOBILISATIONS D''OUVERTURE ';
               ObjPrn.FSousTitreEdition:=SousTitre;
               ObjPrn.FTitre2Edition :=TitreCompte;
               ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
               ObjPrn.FTitre3Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr  ;
               //ObjPrn.Orientation:=poLandscape;
               ListeValeur.Insert(0,'  ;  ;  ;  ; Eco ; Derog ; Eco ; Fiscale ');
               ListeValeur.Insert(1,'0.4;2.2;0.7;0.7;0.7;0.7;0.7;0.7');//
               ListeValeur.Insert(2,'texte;texte;curr;curr;curr;curr;curr;curr');
               ListeValeur.Insert(3,' Immobilisation ; Valeur Org. ; Déduc. Invest. ; Situation Debut Exercice ;SURTITRE');
               ListeValeur.Insert(4,'2.6;0.7;0.7;2.8'); //
               ListeValeur.Insert(5,' Code ; Désignation ;  ;  ; Cumul ; Valeur nette ;SURTITRE');
               ListeValeur.Insert(6,'0.4;2.2;0.7;0.7;1.4;1.4'); //
          end;
     ObjPrn.AffichageImp(ListeValeur);
  end;//fin du periode.retour
finally
  if Choix_Periode<>nil then Choix_Periode.EdDateFin.Enabled:=true; 
  LibereObjet(Tobject(Requete));
  LibereObjet(Tobject(ObjPrn));
end;
end;



Function EditionSyntheseDesImmosOuvertureL(TypeEdition : integer; DemandePeriode:Boolean; Compte:string;DataSet:TDataSet;SousTitre:string):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(Retour);
  try
   Maliste:=TStringList.Create;
   if not empty (Compte)then
     Maliste.Add(Compte)
   else
     raise ExceptLGR.Create('Aucun Compte n''est defini !',1000,true,mtError,Retour);
   EditionSyntheseDesImmosOuvertureL(TypeEdition,DemandePeriode,Maliste,DataSet,SousTitre);
  except
     abort;
  end;
end;

Function EditionSyntheseDesImmosOuvertureL(TypeEdition : integer; Filtre:string; DemandePeriode:Boolean; DataSet:TDataSet;SousTitre:string):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(Retour);
  try
   Maliste:=TStringList.Create;
   if not empty (Filtre)then
     begin
      FiltrageDataSet(dmrech.TaPlanCptRech,CreeFiltreET(['compte','Immobilisation'],[Filtre,True]));
      Maliste:=ChampTableVersListeEx(['compte'],dmrech.TaPlanCptRech,';',false);
     end
   else
     raise ExceptLGR.Create('Aucun Compte n''est defini !',1000,true,mtError,Retour);
   EditionSyntheseDesImmosOuvertureL(TypeEdition,DemandePeriode,Maliste,DataSet,SousTitre);
  except
     abort;
  end;
end;

procedure TDMImmos_Ouverture.QuImmosOuverture_EditionFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
    accept:=ListeFilterRecordImmosOuverture.IndexOf(DataSet.FindField('compte').AsString) <> -1;
  end;
end;

procedure TDMImmos_Ouverture.QuCptUtiliseImmos_OuvertureAfterScroll(
  DataSet: TDataSet);
begin
//
end;



Procedure TDMImmos_Ouverture.ChangementRepertoireTableImmos;
begin
    try
//       FermerTouteTable('',Tcontrol(DataModuleImmos));
       case taDetailImmo.State of
          dsEdit:Begin
                   Application.MessageBox(Pchar('La table : ' + #13#10#13#10+UpperCase(taDetailImmo.Name)+#13#10#13#10+'Dans le module : '+ #13#10#13#10+UpperCase(DataModuleImmos.Name)+ #13#10#13#10+'est en modification.'),'Attention',MB_ICONWARNING +MB_OK);
                 End;
          dsInsert:Begin
                     Application.MessageBox(Pchar('La table : ' + #13#10#13#10+UpperCase(taDetailImmo.Name)+#13#10#13#10+'Dans le module : '+ #13#10#13#10+UpperCase(DataModuleImmos.Name)+ #13#10#13#10+'est en insertion.'),'Attention',MB_ICONWARNING +MB_OK);
                   End;
          dsBrowse,dsinactive:begin
                      QuCptUtiliseImmos_Ouverture.Close;
                      QuRecupImmosSurCpt.close;
                      qryTotalCumulImmos.Close;
                      qryCumulImmos.close;
                      taDetailImmo.close ;
                      if E.ExerciceCloture then
                        Begin //si exo clôturé
                          if FileExists(DMBalance.TaBalance.Database.Directory+'Immos.db') then
                            begin
                              QuCptUtiliseImmos_Ouverture.DatabaseName:=DMBalance.TaBalance.DatabaseName;
                              QuCptUtiliseImmos_Ouverture.sql.Clear;
                              QuCptUtiliseImmos_Ouverture.sql.Add('SELECT Immos.Compte, PlanCpt.Libelle');
                              QuCptUtiliseImmos_Ouverture.sql.Add(' FROM Immos INNER JOIN "'+E.RepertoireDossier+'PlanCpt" ON Immos.Compte = PlanCpt.Compte');
                              QuCptUtiliseImmos_Ouverture.sql.Add(' where Compte like:Cpt');
                              QuCptUtiliseImmos_Ouverture.sql.Add(' and Immos.Date_Achat<= :DateFin and ((Date_Cession is null)or(Date_Cession >:DateDeb))');
                              QuCptUtiliseImmos_Ouverture.sql.Add(' GROUP BY Immos.Compte, PlanCpt.Libelle');
//
                              QuRecupImmosSurCpt.DatabaseName:=DMBalance.TaBalance.DatabaseName;
                              qryTotalCumulImmos.DatabaseName:=DMBalance.TaBalance.DatabaseName;
                              taDetailImmo.DatabaseName:=DMBalance.TaBalance.DatabaseName;
                              qryCumulImmos.DatabaseName:=DMBalance.TaBalance.DatabaseName;

                            end
                          else
                            begin
                              taDetailImmo.DatabaseName:=DMPieces.TaPiece.DatabaseName;
                              QuCptUtiliseImmos_Ouverture.DatabaseName:=DMPieces.TaPiece.DatabaseName;
                              QuRecupImmosSurCpt.DatabaseName:=DMPieces.TaPiece.DatabaseName;
                              qryTotalCumulImmos.DatabaseName:=DMPieces.TaPiece.DatabaseName;
                              qryCumulImmos.DatabaseName:=DMPieces.TaPiece.DatabaseName;
                            end;
                        end //fin si exo clôturé
                      else
                        begin //si exo non clôturé
                          taDetailImmo.DatabaseName:=DMPieces.TaPiece.DatabaseName;
                        end;//fin si exo non clôturé
                      //QuCptUtiliseImmos.open;
                      //QuRecupImmosSurCpt.open;
                      //taDetailImmo.open;
                   end;
       end;//fin du case
    except
       begin
       Application.MessageBox(Pchar('Erreur à la redirection de la table : ' + #13#10#13#10+UpperCase(taDetailImmo.Name)+#13#10#13#10+'Dans le module : '+ #13#10#13#10+UpperCase(DataModuleImmos.Name)),'Attention',MB_ICONWARNING +MB_OK);
       end;
    end;
end;

end.


