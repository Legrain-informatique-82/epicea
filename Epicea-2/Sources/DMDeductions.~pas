unit DMDeductions;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  Gr_Librairie_obj,
  E2_Librairie_obj,
  Printers,
  Grids,
  DBGrids,
  DMExports,
  Db,
  DBTables,
  E2_AideCompte,
  LibSQL,
  Menus,
  Buttons,
  RxMemDS,
  DMClotures,
  DMPlanCpt,
  LibDates,
  E2_Decl_Records,
  DMRecherche,
  E2_LibInfosTable,
  Editions,
  ShellApi,
  Lib_Chaine,
  LibRessourceString,
  ObjetEdition,
  DMConstantes;

Const
RequeteExercice=' select cast(''N''as varchar(3))as Exercice from ta_deduction D'+
' left join ta_utilisation_deduc U on (U.id_deduction=D.id)'+
' where (Mt_N) is not null and (Mt_N)<>0'+
' union'+
' select cast(''N-1''as varchar(3)) from ta_deduction D'+
' left join ta_utilisation_deduc U on (U.id_deduction=D.id)'+
' where (Mt_N1) is not null and (Mt_N1)<>0'+
' union'+
' select cast(''N-2''as varchar(3)) from ta_deduction D'+
' left join ta_utilisation_deduc U on (U.id_deduction=D.id)'+
' where (Mt_N2) is not null and (Mt_N2)<>0'+
' union'+
' select cast(''N-3''as varchar(3)) from ta_deduction D'+
' left join ta_utilisation_deduc U on (U.id_deduction=D.id)'+
' where (Mt_N3) is not null and (Mt_N3)<>0'+
' union'+
' select cast(''N-4''as varchar(3)) from ta_deduction D '+
' left join ta_utilisation_deduc U on (U.id_deduction=D.id)'+
' where (Mt_N4) is not null and (Mt_N4)<>0'+
' union'+
' select cast(''N-5''as varchar(3)) from ta_deduction D'+
' left join ta_utilisation_deduc U on (U.id_deduction=D.id)'+
' where (Mt_N5) is not null and (Mt_N5)<>0'+
' order by Exercice desc';

type
  TParamDMDeduction=Record
   DeductionDataStateChange:TNotifyEvent;
   GEstInterfaceEvent:TGEstInterfaceEvent;
  end;

  TParamDMUtilisationDeduction=Record
   UtilisationDeductionDataStateChange:TNotifyEvent;
   GEstInterfaceEvent:TGEstInterfaceEvent;
  end;

  TInfosDMDeduction=Record
    Retour:Boolean;
   end;

  TInfosDeduction=Record
    id:array of TvarRec;
    Libelle : string;
    Remplie:Boolean;
    ChampRemplie:string;
    Montant:currency;
    Exo:string;
   end;

   TinfosUtilisation=Record
    Nb_utilisations:integer;
    MontantUtilise:currency;
    Mt_immos:currency;
    Mt_Social:currency;
    Mt_Stocks:currency;
    Reinteg_except:currency;
   end;

  TDMDeduction = class(TDataModule)
    TaDeduction: TTable;
    DataDeduction: TDataSource;
    TaUtilisation_deduc: TTable;
    DataUtilisation_deduc: TDataSource;
    TaDeductionID: TIntegerField;
    TaDeductionLibelle: TStringField;
    TaDeductionMt_N: TCurrencyField;
    TaDeductionMt_N1: TCurrencyField;
    TaDeductionMt_N2: TCurrencyField;
    TaDeductionMt_N3: TCurrencyField;
    TaDeductionMt_N4: TCurrencyField;
    TaDeductionMt_N5: TCurrencyField;
    TaDeductionDivers_Str: TStringField;
    TaUtilisation_deducID: TIntegerField;
    TaUtilisation_deducID_deduction: TIntegerField;
    TaUtilisation_deducid_immo: TIntegerField;
    TaUtilisation_deducExercice: TStringField;
    TaUtilisation_deducMt_immo: TCurrencyField;
    TaUtilisation_deducMt_social: TCurrencyField;
    TaUtilisation_deducMt_stocks: TCurrencyField;
    TaUtilisation_deducReinteg_except: TCurrencyField;
    TaUtilisation_deducDivers_Str: TStringField;
    QuDeductionEdition: TQuery;
    TaUtilisation_deducTotalUtilise: TCurrencyField;
    TaDeductionResteCalcule: TCurrencyField;
    TaUtilisation_deducLibelle_Reinteg: TStringField;
    QuEditionAmort_A_Reinteg: TQuery;

    procedure DMDeductionCreate(Sender: TObject);
    Function CtrlSaisieDeduction(CCourant:Tfield):TErreurSaisie;
    Function CtrlSaisieUtilisationDeduction(CCourant:Tfield):TErreurSaisie;
    procedure DMDeductionDestroy(Sender: TObject);
    procedure TaDeductionAfterPost(DataSet: TDataSet);
    procedure TaDeductionAfterDelete(DataSet: TDataSet);

    procedure Filtrage_DeductionPourNouvelExo(var tMem:TRxMemoryData;NouvelleDate:Tdatetime);
    procedure Filtrage_UtilisationDeductionPourNouvelExo(var tMem:TRxMemoryData;NouvelleDate:Tdatetime);

    procedure TaDeductionPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaDeductionDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaDeductionBeforeInsert(DataSet: TDataSet);
    procedure TaDeductionBeforeEIDClo_Abort(DataSet: TDataSet);
    procedure TaUtilisationDeductionBeforeEIDClo_Abort(DataSet: TDataSet);
    Procedure TraitementCloture6000(sender:Tobject);
    procedure TaDeductionAfterInsert(DataSet: TDataSet);

    procedure GestionAccesDeductions;
    procedure QuDeductionEditionFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuEditionAmort_A_ReintegFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaDeductionBeforeDelete(DataSet: TDataSet);
    procedure TaDeductionBeforeEdit(DataSet: TDataSet);
    procedure TaDeductionBeforePost(DataSet: TDataSet);
    Procedure GestionAccesUtilisationDeductions;
    procedure TaUtilisation_deducAfterDelete(DataSet: TDataSet);
    procedure TaUtilisation_deducAfterInsert(DataSet: TDataSet);
    procedure TaUtilisation_deducAfterPost(DataSet: TDataSet);
    procedure TaUtilisation_deducBeforeDelete(DataSet: TDataSet);
    procedure TaUtilisation_deducBeforeEdit(DataSet: TDataSet);
    procedure TaUtilisation_deducBeforeInsert(DataSet: TDataSet);
    procedure TaUtilisation_deducBeforePost(DataSet: TDataSet);
    procedure TaUtilisation_deducDeleteError(DataSet: TDataSet;
      E: EDatabaseError; var Action: TDataAction);
    procedure TaUtilisation_deducPostError(DataSet: TDataSet;
      E: EDatabaseError; var Action: TDataAction);
    procedure TaUtilisation_deducCalcFields(DataSet: TDataSet);
    function InfosDeductionCourante(Dataset:TDataset=nil):TInfosDeduction;
    procedure initialiseTInfosDeduction(var infosDeduction:TInfosDeduction);
    function RecupUtilisationDeduction(deduction:array of TvarRec;idCourant:integer=0;Dataset:TDataset=nil):TinfosUtilisation;
    procedure initialiseTinfosUtilisation(var infosUtilisation:TinfosUtilisation);
    procedure TaDeductionCalcFields(DataSet: TDataSet);
    procedure TaUtilisation_deducAfterEdit(DataSet: TDataSet);
    procedure TaDeductionFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
      Procedure ImportDeduction(Valeurs:array of const;DataSet:TDataSet);
    function DPI_NonAffecteesDansLes5Ans:currency;
    function Recup_IDDeductionNx(ChampNx:String):TInfosDeduction;
    function ReintegrationExceptionnelleDansExerciceN:currency;
    function InfosDeductionSurNx(Dataset:TDataset):TInfosDeduction;
    procedure RecupUtilisationCourante;
  private
    { Déclarations privées }
    FOnGEstInterfaceEvent:TGEstInterfaceEvent;

  Protected
    { Déclarations protégées }

  public
    { Déclarations publiques }
    ListeEdit:TStringList;
    ListeFilterRecordDeductions:TStringList;
    utilisationCourante:TinfosUtilisation;
    property OnGEstInterfaceEvent:TGEstInterfaceEvent read FOnGEstInterfaceEvent write FOnGEstInterfaceEvent;


  end;

var
  DMDeduction: TDMDeduction;
  EtatTable:TDataSetState;

  DeductionCourante:integer;

    Function InitialiseDMDeduction(ParamDMDeduction:TParamDMDeduction):TInfosDMDeduction;
    Function InitialiseDMUtilisationDeduction(ParamDMUtilisationDeduction:TParamDMUtilisationDeduction):TInfosDMDeduction;
    function VerifExistChargesARepartir(var messageTmp:Tmessages;Mess:boolean):boolean;

    Function EditionDesDeductions(TypeEdition : integer; DemandePeriode:Boolean; Exercice:TStringList;DataSet:TDataSet;SousTitre:string):Boolean;overload;
    Function EditionDesDeductions(TypeEdition : integer; DemandePeriode:Boolean; Exercice:string;DataSet:TDataSet;SousTitre:string):Boolean;overload;

    Function EditionAmort_A_Reinteg(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string):Boolean;overload;
    Function EditionAmort_A_Reinteg(TypeEdition : integer; DemandePeriode:Boolean; Compte:string;DataSet:TDataSet;SousTitre:string):Boolean;overload;

implementation

 uses DMPiece, DMBalances,DMEcriture, E2_Main, DMImportation,DMBaseDonnee,DMDiocEtatBalance,
  E2_VisuListeView,LibZoneSaisie, ChoixPeriode;

{$R *.DFM}

// C_Ouverture = 0;
// C_Cloture = 1;
// C_Mouvement = 2;

Function InitialiseDMDeduction(ParamDMDeduction:TParamDMDeduction):TInfosDMDeduction;
Begin
 if DMDeduction=nil then DMDeduction:=TDMDeduction.Create(Application.MainForm);
 if DMRech = Nil then DMRech:=TDMRech.Create(Application.MainForm);
 if AideCompte=nil then AideCompte:=TAideCompte.Create(Application.MainForm);
 DMDeduction.OnGEstInterfaceEvent := ParamDMDeduction.GEstInterfaceEvent;
 DMDeduction.DataDeduction.OnStateChange := ParamDMDeduction.DeductionDataStateChange;
End;


Function InitialiseDMUtilisationDeduction(ParamDMUtilisationDeduction:TParamDMUtilisationDeduction):TInfosDMDeduction;
Begin
 if DMDeduction=nil then DMDeduction:=TDMDeduction.Create(Application.MainForm);
 if DMRech = Nil then DMRech:=TDMRech.Create(Application.MainForm);
 if AideCompte=nil then AideCompte:=TAideCompte.Create(Application.MainForm);
 DMDeduction.OnGEstInterfaceEvent := ParamDMUtilisationDeduction.GEstInterfaceEvent;
 DMDeduction.DataUtilisation_deduc.OnStateChange := ParamDMUtilisationDeduction.UtilisationDeductionDataStateChange;

 FiltrageDataSet(DMDeduction.TaUtilisation_deduc,CreeFiltreou('id_deduction',[DeductionCourante]));
End;







//******************* TDMDeduction.CtrlSaisieChargesRepartir *************************
//Cette fonction sert à vérifier tous les champs saisis avant l'enregistrement
//dans la table 'ChargesARepartir'

Function TDMDeduction.CtrlSaisieDeduction(CCourant:Tfield):TErreurSaisie;
var
infosCompte:TInfosplancpt;
begin // initialisation des variables de retour de fonction
 CtrlSaisieDeduction.CodeErreur:=0;
 CtrlSaisieDeduction.Retour:=True;
  if TaDeduction.State in [dsinsert,dsEdit] then
  begin //si état insertion ou modification
       case CCourant.Index of
           1: begin // si champ n° 0 (Libelle)
               If Empty(CCourant.AsString) then
                Begin // si champ vide
                  CtrlSaisieDeduction.CodeErreur:=1;
                  CtrlSaisieDeduction.Retour:=False;
                  Application.Messagebox(Pchar('La saisie du libellé est obligatoire !!!'),'Erreur de saisie',0);
                end;//fin champ vide
               end;//fin champ 0
       end;//fin du case
      if InfosDeductionCourante.Montant -
        RecupUtilisationDeduction([TaDeductionID.AsInteger]).MontantUtilise < 0
        then
        begin
            Application.MessageBox(Pchar('Le reste à utilisé est inférieur à la déduction.'),'Attention',MB_ICONWARNING);
            abort;
        end;
  end; //fin de l'état insertion ou modification
end;


//******************* TDMDeduction.CtrlSaisieChargesRepartir *************************
//Cette fonction sert à vérifier tous les champs saisis avant l'enregistrement
//dans la table 'ChargesARepartir'

Function TDMDeduction.CtrlSaisieUtilisationDeduction(CCourant:Tfield):TErreurSaisie;
var
infosCompte:TInfosplancpt;
Utilisation:currency;
begin // initialisation des variables de retour de fonction
 CtrlSaisieUtilisationDeduction.CodeErreur:=0;
 CtrlSaisieUtilisationDeduction.Retour:=True;
  if TaUtilisation_deduc.State in [dsinsert,dsEdit] then
  begin //si état insertion ou modification
       if (CCourant.FieldName) ='Exercice' then
           begin // si champ n° Exercice
               If Empty(CCourant.AsString) then
                Begin // si champ vide
                  CtrlSaisieUtilisationDeduction.CodeErreur:=1;
                  CtrlSaisieUtilisationDeduction.Retour:=False;
                  Application.Messagebox(Pchar('La saisie de l''exercice est obligatoire !!!'),'Erreur de saisie',0);
                end;//fin champ vide
               end;//fin champ Exercice
       if (CCourant.FieldName) ='Mt_immo' then
           begin // si champ n° Mt_immo
               If not str_Empty_Numeric(CCourant.AsString) then
                Begin // si champ vide
                Utilisation:=RecupUtilisationDeduction([DeductionCourante],TaUtilisation_deducID.AsInteger).MontantUtilise
                      +(utilisationCourante.Mt_Social+utilisationCourante.Mt_Stocks+utilisationCourante.Reinteg_except);
                  if InfosDeductionCourante.Montant - Utilisation < CCourant.AsCurrency then
                    begin
                        CtrlSaisieUtilisationDeduction.CodeErreur:=CCourant.Index;
                        CtrlSaisieUtilisationDeduction.Retour:=False;
                        Application.MessageBox(Pchar('Le Total des utilisations supérieur à la déduction.'),'Attention',MB_ICONWARNING);
                        //abort;
                    end;
                end;//fin champ vide
               utilisationCourante.Mt_immos:=TaUtilisation_deducMt_immo.AsCurrency;
               end;//fin si champ n° 4
       if (CCourant.FieldName) ='Mt_social' then
           begin // si champ n° Mt_social
               If not str_Empty_Numeric(CCourant.AsString) then
                Begin // si champ vide
//                  if InfosDeductionCourante.Montant -
//                    RecupUtilisationDeduction([DeductionCourante],utilisationCourante.Mt_Social).MontantUtilise < CCourant.AsCurrency then
                Utilisation:=RecupUtilisationDeduction([DeductionCourante],TaUtilisation_deducID.AsInteger).MontantUtilise
                      +(utilisationCourante.Mt_immos+utilisationCourante.Mt_Stocks+utilisationCourante.Reinteg_except);
                  if InfosDeductionCourante.Montant - Utilisation < CCourant.AsCurrency then
                    begin
                        CtrlSaisieUtilisationDeduction.CodeErreur:=CCourant.Index;
                        CtrlSaisieUtilisationDeduction.Retour:=False;
                        Application.MessageBox(Pchar('Le Total des utilisations supérieur à la déduction.'),'Attention',MB_ICONWARNING);
                        //abort;
                    end;
                end;//fin champ vide
               utilisationCourante.Mt_Social:=TaUtilisation_deducMt_social.AsCurrency;
               end;//fin si champ n° 5
       if (CCourant.FieldName) ='Mt_stocks' then
           begin // si champ n° Mt_stocks
               If not str_Empty_Numeric(CCourant.AsString) then
                Begin // si champ vide
                Utilisation:=RecupUtilisationDeduction([DeductionCourante],TaUtilisation_deducID.AsInteger).MontantUtilise
                      +(utilisationCourante.Mt_Social+utilisationCourante.Mt_immos+utilisationCourante.Reinteg_except);
                  if InfosDeductionCourante.Montant - Utilisation < CCourant.AsCurrency then
                    begin
                        CtrlSaisieUtilisationDeduction.CodeErreur:=CCourant.Index;
                        CtrlSaisieUtilisationDeduction.Retour:=False;
                        Application.MessageBox(Pchar('Le Total des utilisations supérieur à la déduction.'),'Attention',MB_ICONWARNING);
                        //abort;
                    end;
                end;//fin champ vide
               utilisationCourante.Mt_Stocks:=TaUtilisation_deducMt_stocks.AsCurrency;
               end;//fin si champ n° 6
       if (CCourant.FieldName) ='Reinteg_except' then
           begin // si champ n° Reinteg_except
               If not str_Empty_Numeric(CCourant.AsString) then
                Begin // si champ vide
                Utilisation:=RecupUtilisationDeduction([DeductionCourante],TaUtilisation_deducID.AsInteger).MontantUtilise
                      +(utilisationCourante.Mt_Social+utilisationCourante.Mt_Stocks+utilisationCourante.Mt_immos);
                  if InfosDeductionCourante.Montant - Utilisation < CCourant.AsCurrency then
                    begin
                        CtrlSaisieUtilisationDeduction.CodeErreur:=CCourant.Index;
                        CtrlSaisieUtilisationDeduction.Retour:=False;
                        Application.MessageBox(Pchar('Le Total des utilisations supérieur à la déduction.'),'Attention',MB_ICONWARNING);
                        //abort;
                    end;
                end;//fin champ vide
               utilisationCourante.Reinteg_except:=TaUtilisation_deducReinteg_except.AsCurrency;
               end;//fin si champ n° 7
           //end;//fin du case

  end; //fin de l'état insertion ou modification
end;


//******************* TDMDeduction.DMDeductionCreate *************************
//cette procedure permet d'ouvrir toutes les tables et de créer des formats type de saisie
///*********************************************************************************
procedure TDMDeduction.DMDeductionCreate(Sender: TObject);
begin
OuvrirTouteTable('',TControl(self));
if DMRech=nil then DMRech:=TDMRech.Create(Application.MainForm);
//table TaDeduction
 TaDeduction.FindField('Mt_N').ValidChars:=['0'..'9',decimalseparator];
 TaDeduction.FindField('Mt_N1').ValidChars:=['0'..'9',decimalseparator];
 TaDeduction.FindField('Mt_N2').ValidChars:=['0'..'9',decimalseparator];
 TaDeduction.FindField('Mt_N3').ValidChars:=['0'..'9',decimalseparator];
 TaDeduction.FindField('Mt_N4').ValidChars:=['0'..'9',decimalseparator];
 TaDeduction.FindField('Mt_N5').ValidChars:=['0'..'9',decimalseparator];
 TaDeduction.FindField('ResteCalcule').ValidChars:=['0'..'9',decimalseparator];


 TaDeductionMt_N.DisplayFormat:=E.FormatMonnaie;
 TaDeductionMt_N.EditFormat:='0.00 ;-0.00 ';

 TaDeductionMt_N1.DisplayFormat:=E.FormatMonnaie;
 TaDeductionMt_N1.EditFormat:='0.00 ;-0.00 ';


 TaDeductionMt_N2.DisplayFormat:=E.FormatMonnaie;
 TaDeductionMt_N2.EditFormat:='0.00 ;-0.00 ';

 TaDeductionMt_N3.DisplayFormat:=E.FormatMonnaie;
 TaDeductionMt_N3.EditFormat:='0.00 ;-0.00 ';

 TaDeductionMt_N4.DisplayFormat:=E.FormatMonnaie;
 TaDeductionMt_N4.EditFormat:='0.00 ;-0.00 ';

 TaDeductionMt_N5.DisplayFormat:=E.FormatMonnaie;
 TaDeductionMt_N5.EditFormat:='0.00 ;-0.00 ';

 TaDeductionResteCalcule.DisplayFormat:=E.FormatMonnaie;
 TaDeductionResteCalcule.EditFormat:='0.00 ;-0.00 ';

//
//Table  TaUtilisation_deduc
 TaUtilisation_deduc.FindField('Mt_immo').ValidChars:=['0'..'9',decimalseparator];
 TaUtilisation_deduc.FindField('Mt_social').ValidChars:=['0'..'9',decimalseparator];
 TaUtilisation_deduc.FindField('Mt_stocks').ValidChars:=['0'..'9',decimalseparator];
 TaUtilisation_deduc.FindField('Reinteg_except').ValidChars:=['0'..'9',decimalseparator];

 TaUtilisation_deducMt_immo.DisplayFormat:=E.FormatMonnaie;
 TaUtilisation_deducMt_immo.EditFormat:='0.00 ;-0.00 ';

 TaUtilisation_deducMt_social.DisplayFormat:=E.FormatMonnaie;
 TaUtilisation_deducMt_social.EditFormat:='0.00 ;-0.00 ';

 TaUtilisation_deducMt_stocks.DisplayFormat:=E.FormatMonnaie;
 TaUtilisation_deducMt_stocks.EditFormat:='0.00 ;-0.00 ';

 TaUtilisation_deducReinteg_except.DisplayFormat:=E.FormatMonnaie;
 TaUtilisation_deducReinteg_except.EditFormat:='0.00 ;-0.00 ';

 ListeEdit:=TStringList.Create;
 if ListeFilterRecordDeductions= nil then ListeFilterRecordDeductions:=TStringList.Create;
end;

//******************* TDMDeduction.DMDeductionDestroy *************************
//cette procedure permet de fermer toutes tables
///*********************************************************************************
procedure TDMDeduction.DMDeductionDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
ListeEdit.Free;
LibereObjet(Tobject(ListeFilterRecordDeductions));
DMDeduction:=nil;
end;






//******************* TDMDeduction.TaCarAfterPost *************************
//
///*********************************************************************************
procedure TDMDeduction.TaDeductionAfterPost(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
end;

//******************* TDMDeduction.TaCarAfterDelete *************************
//on déclenche un changement de state,
///*********************************************************************************
procedure TDMDeduction.TaDeductionAfterDelete(DataSet: TDataSet);
begin 
TableGereCommit(DataSet);
TableGereCommit(TaUtilisation_deduc);
DataDeduction.OnStateChange(DataSet);
end;






procedure TDMDeduction.Filtrage_DeductionPourNouvelExo(var tMem:TRxMemoryData;NouvelleDate:Tdatetime);
//var
//Calcul:tquery;
begin
try
   try
   if dmrech.TaDeductionRech.Active then dmrech.TaDeductionRech.Close;
   dmrech.TaDeductionRech.OnFilterRecord:=TaDeductionFilterRecord;
   FiltrageDataSet(dmrech.TaDeductionRech,'');

   TableGereStartTransaction(dmrech.TaDeductionRech);
   if dmrech.TaDeductionRech.RecordCount<>0 then
      begin
      tMem.LoadFromDataSet(dmrech.TaDeductionRech,0,lmcopy);
      tMem.First;
      while not(tMem.EOF) do
         begin
         tMem.edit;
         tMem.FindField('Reste').AsCurrency:=tMem.FindField('Mt_N5').AsCurrency;
         tMem.FindField('Mt_N5').AsCurrency:=tMem.FindField('Mt_N4').AsCurrency;
         tMem.FindField('Mt_N4').AsCurrency:=tMem.FindField('Mt_N3').AsCurrency;
         tMem.FindField('Mt_N3').AsCurrency:=tMem.FindField('Mt_N2').AsCurrency;
         tMem.FindField('Mt_N2').AsCurrency:=tMem.FindField('Mt_N1').AsCurrency;
         tMem.FindField('Mt_N1').AsCurrency:=tMem.FindField('Mt_N').AsCurrency;
         tMem.FindField('Mt_N').AsCurrency:=0;
         tMem.Post;
         tmem.FieldCount;
         tMem.Next;
//         calcul.Next;
         end;
      end;
      TableGereCommit(dmrech.TaDeductionRech);
   except
   DeFiltrageDataSet(dmrech.TaDeductionRech);
   dmrech.TaDeductionRech.OnFilterRecord:=nil;
   TableGereRollBack(dmrech.TaDeductionRech);
   showmessage('Problème à l''écriture dans la nouvelle table '+dmrech.TaDeductionRech.TableName);
   abort;
   end;//fin du try
finally
   dmrech.TaDeductionRech.Filtered:=false;
   dmrech.TaDeductionRech.Filter:='';
   dmrech.TaDeductionRech.OnFilterRecord:=nil;
end;
end;


procedure TDMDeduction.Filtrage_UtilisationDeductionPourNouvelExo(var tMem:TRxMemoryData;NouvelleDate:Tdatetime);
var
i:integer;
begin
try
   try
   if dmrech.TaUtilisation_deducRech.Active then dmrech.TaUtilisation_deducRech.Close;
   FiltrageDataSet(dmrech.TaUtilisation_deducRech,'');
   tMem.LoadFromDataSet(dmrech.TaUtilisation_deducRech,0,lmcopy);
      tMem.First;
      while not(tMem.EOF) do
         begin
         tMem.edit;
         if tMem.FindField('Exercice').AsString = 'N' then
           tMem.FindField('Exercice').AsString:='N-1'
         else
           begin
             i:=StrToInt(str_n_der_char(tMem.FindField('Exercice').AsString,1))+1;
             tMem.FindField('Exercice').AsString:=str_n_prem_char(tMem.FindField('Exercice').AsString,2)+IntToStr(i);
           end;
         tMem.Post;
         tmem.FieldCount;
         tMem.Next;
         end;
      TableGereCommit(dmrech.TaDeductionRech);
   except
   DeFiltrageDataSet(dmrech.TaUtilisation_deducRech);
   showmessage('Problème à l''écriture dans la nouvelle table '+dmrech.TaUtilisation_deducRech.TableName);
   abort;
   end;//fin du try
finally
   dmrech.TaDeductionRech.Filtered:=false;
   dmrech.TaDeductionRech.Filter:='';
   dmrech.TaDeductionRech.OnFilterRecord:=nil;
end;
end;


procedure TDMDeduction.TaDeductionPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(DataSet);
end;

procedure TDMDeduction.TaDeductionDeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(DataSet);
end;


procedure TDMDeduction.TaDeductionBeforeInsert(DataSet: TDataSet);
begin
if assigned(FOnGEstInterfaceEvent) then
 FOnGEstInterfaceEvent(DataSet.FieldByName('Libelle'));
end;


procedure TDMDeduction.TaDeductionBeforeEIDClo_Abort(DataSet: TDataSet);
Begin
if not e.AccesCloture then
 MessageDlg('Vous ne pouvez pas modifier les déductions sur un exercice clôturé !', mtInformation, [mbOK], 0)
 else MessageDlg('Erreur Interne, vous ne devez pas modifier les déductions sur un exercice clôturé !', mtError, [mbOK], 0);
abort;
End;

procedure TDMDeduction.TaUtilisationDeductionBeforeEIDClo_Abort(DataSet: TDataSet);
Begin
if not e.AccesCloture then
 MessageDlg('Vous ne pouvez pas modifier les utilisations des déductions sur un exercice clôturé !', mtInformation, [mbOK], 0)
 else MessageDlg('Erreur Interne, vous ne devez pas modifier les utilisations des déductions sur un exercice clôturé !', mtError, [mbOK], 0);
abort;
End;

function VerifExistChargesARepartir(var messageTmp:Tmessages;Mess:boolean):boolean;
Begin
//if DMDeduction=nil then DMDeduction:=TDMDeduction.create(Application.MainForm);
//if DMRech=nil then DMRech:=TDMRech.create(Application.MainForm);
//  try
//     DeFiltrageDataSet(DMRech.TaChargesRepartirRech);
//     result:= DMRech.TaChargesRepartirRech.RecordCount<>0 ;
//      if ((not result)and(mess)) then
//         messageTmp.MessageErreur:='Aucune Charge à répartir  n''a été saisie'
//      else
//          messageTmp.MessageErreur:='OK';
//  except
//   showmessage('problème lors de la vérification de l''existence des Charges à répartir');
//   abort;
//  end;
End;




Procedure TDMDeduction.TraitementCloture6000(sender:Tobject);
Begin
main.Chargesrpartir2Click(main.Chargesrpartir2);
End;




procedure TDMDeduction.TaDeductionAfterInsert(DataSet: TDataSet);
begin
InitChampAfterInsert([nil,0,0,0,0,0,0,0,nil],DataSet);
end;

Procedure TDMDeduction.GestionAccesUtilisationDeductions;
Begin
    if E.AccesCloture then
     begin
      TaUtilisation_deduc.BeforeInsert := TaUtilisation_deducBeforeInsert;
      TaUtilisation_deduc.BeforeEdit := TaUtilisation_deducBeforeEdit;
      TaUtilisation_deduc.BeforePost := TaUtilisation_deducBeforePost;
     end
    else
     begin
      TaUtilisation_deduc.BeforeInsert := TaUtilisationDeductionBeforeEIDClo_Abort;
      TaUtilisation_deduc.BeforeEdit := TaUtilisationDeductionBeforeEIDClo_Abort;
      TaUtilisation_deduc.BeforePost := TaUtilisationDeductionBeforeEIDClo_Abort;
     end;

End;

Procedure TDMDeduction.GestionAccesDeductions;
Begin
    if E.AccesCloture then
     begin
      TaDeduction.BeforeInsert := TaDeductionBeforeInsert;
      TaDeduction.BeforeEdit := TaDeductionBeforeEdit;
      TaDeduction.BeforePost := TaDeductionBeforePost;
     end
    else
     begin
      TaDeduction.BeforeInsert := TaDeductionBeforeEIDClo_Abort;
      TaDeduction.BeforeEdit := TaDeductionBeforeEIDClo_Abort;
      TaDeduction.BeforePost := TaDeductionBeforeEIDClo_Abort;
     end;

End;





procedure TDMDeduction.QuDeductionEditionFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if(ListeFilterRecordDeductions<>nil)and (ListeFilterRecordDeductions.Count>0)then
  accept := ListeFilterRecordDeductions.IndexOf(DAtaSet.findField('Exo').AsString) <> -1;
end;

procedure TDMDeduction.QuEditionAmort_A_ReintegFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if (ListeFilterRecordDeductions<>nil )and (ListeFilterRecordDeductions.count>0)then
  accept:= (ListeFilterRecordDeductions.IndexOf(DAtaSet.findField('compte').AsString) <> -1);
if accept then accept := (arrondi(DAtaSet.findField('Reprise_deduc_invest').AsCurrency,2) < DAtaSet.findField('mt_deduc_invest').AsCurrency);
end;

procedure TDMDeduction.TaDeductionBeforeDelete(DataSet: TDataSet);
var
Query:Tquery;
begin
  try//finally
    try//except
        Query:=Tquery.Create(Application.MainForm);
        query.DatabaseName := DM_C_NomAliasExercice;
        TableGereStartTransaction(Query);
        query.SQL.Add('delete from ta_utilisation_deduc where id_deduction ='+inttostr(TaDeductionID.AsInteger));
        query.ExecSQL;
    except
       abort;
       TableGereRollBack(Query);
    end;
  finally
   query.close;
   query.free;
  end;
end;

procedure TDMDeduction.TaDeductionBeforeEdit(DataSet: TDataSet);
begin
//
end;

procedure TDMDeduction.TaDeductionBeforePost(DataSet: TDataSet);
var
I:integer;
RetourFonction:TErreurSaisie;
begin
EtatTable:=TaDeduction.State;
  case TaDeduction.State of
  dsInsert: begin
            TaDeductionID.AsInteger := MaxId_Query((DataSet as TTable),'id');
            end;
  end;//fin case state

for I:=1 to 8 do //vérification du champ 1 à 8
   begin
   RetourFonction:=CtrlSaisieDeduction(TaDeduction.Fields[I]);
     if  RetourFonction.Retour=false then
         case  RetourFonction.CodeErreur of
             1,2,3,4,5,6,7,8:
               begin // erreur de saisie, resaisir
                if assigned(FOnGEstInterfaceEvent) then
                 FOnGEstInterfaceEvent(DataSet.Fields[i]);
               abort;
               end;
         end; //fin case
   end; //fin boucle
if InfosDeductionCourante.Montant=0 then
 begin
  Application.MessageBox(Pchar('Vous devez remplir le montant de la déduction.'),'Attention',MB_ICONWARNING);
  abort;
 end;  
TableGereCommit(DataSet);
end;

procedure TDMDeduction.TaUtilisation_deducAfterDelete(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
DataUtilisation_deduc.OnStateChange(DataSet);
end;

procedure TDMDeduction.TaUtilisation_deducAfterInsert(DataSet: TDataSet);
begin
//récupérer l'id déduction appelante
InitChampAfterInsert([nil,DeductionCourante,0,'',0,0,0,0,nil],DataSet);
RecupUtilisationCourante;

end;

procedure TDMDeduction.TaUtilisation_deducAfterPost(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
end;

procedure TDMDeduction.TaUtilisation_deducBeforeDelete(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
end;

procedure TDMDeduction.TaUtilisation_deducBeforeEdit(DataSet: TDataSet);
begin
//
end;

procedure TDMDeduction.TaUtilisation_deducBeforeInsert(DataSet: TDataSet);
begin
if assigned(FOnGEstInterfaceEvent) then
 FOnGEstInterfaceEvent(DataSet.FieldByName('Exercice'));
end;

procedure TDMDeduction.TaUtilisation_deducBeforePost(DataSet: TDataSet);
var
I:integer;
RetourFonction:TErreurSaisie;
begin
EtatTable:=TaUtilisation_deduc.State;
  case TaUtilisation_deduc.State of
  dsInsert: begin
            TaUtilisation_deducID.AsInteger := MaxId_Query((DataSet as TTable),'id');
            end;
  end;//fin case state
RecupUtilisationCourante;
for I:=1 to 8 do //vérification du champ 1 à 8
   begin
   RetourFonction:=CtrlSaisieUtilisationDeduction(TaUtilisation_deduc.Fields[I]);
     if  RetourFonction.Retour=false then
         case  RetourFonction.CodeErreur of
             1,2,3,4,5,6,7,8:
               begin // erreur de saisie, resaisir
                if assigned(FOnGEstInterfaceEvent) then
                 FOnGEstInterfaceEvent(DataSet.Fields[i]);
               abort;
               end;
         end; //fin case
   end; //fin boucle
if (TaUtilisation_deducMt_immo.AsCurrency+TaUtilisation_deducMt_social.AsCurrency+TaUtilisation_deducMt_stocks.AsCurrency+TaUtilisation_deducReinteg_except.AsCurrency)<=0 then
  begin
    Application.MessageBox(Pchar('Vous devez saisir un montant d''utilisation de la déduction'),'Attention',MB_ICONWARNING);
    abort;
  end;
end;

procedure TDMDeduction.TaUtilisation_deducDeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(DataSet);
end;

procedure TDMDeduction.TaUtilisation_deducPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(DataSet);
end;



procedure TDMDeduction.TaUtilisation_deducCalcFields(DataSet: TDataSet);
begin
TaUtilisation_deducTotalUtilise.AsCurrency :=
  (TaUtilisation_deducMt_immo.AsCurrency+
  TaUtilisation_deducMt_social.AsCurrency+
  TaUtilisation_deducMt_stocks.AsCurrency);
end;


function TDMDeduction.InfosDeductionSurNx(Dataset:TDataset):TInfosDeduction;
var
FieldName : string;
Increment : integer;
i:integer;
begin
if Dataset=nil then Dataset := TaDeduction;
FieldName := 'Mt_N';
Increment :=0;
initialiseTInfosDeduction(result);
SetLength(result.id,Dataset.RecordCount);
Dataset.First;
i:=0;
while not dataset.Eof do
  begin
      result.id[i].VType := vtInteger;
      Result.id[i].VInteger:=Dataset.FindField('id').AsInteger;
      result.Libelle :=Dataset.FindField('Libelle').AsString;
        while (not result.Remplie)and(Increment<6)do
          begin
             result.Remplie := not str_Empty_Numeric(Dataset.FindField(FieldName).AsString);
             result.ChampRemplie :=FieldName;
             inc(increment,1);
             FieldName:='Mt_N'+IntToStr(increment);
          end;
      if Result.ChampRemplie<>'' then
        result.Montant := result.Montant+Dataset.findfield(Result.ChampRemplie).AsCurrency;
  dataset.Next;
  inc(i);
  end;
end;


function TDMDeduction.InfosDeductionCourante(Dataset:TDataset):TInfosDeduction;
var
FieldName : string;
Increment : integer;
begin
if Dataset=nil then Dataset := TaDeduction;
FieldName := 'Mt_N';
Increment :=0;
initialiseTInfosDeduction(result);
SetLength(result.id,1);
result.id[0].VType := vtInteger;
result.id[0].VInteger := Dataset.FindField('id').AsInteger;
result.Libelle :=Dataset.FindField('Libelle').AsString;
  while (not result.Remplie)and(Increment<6)do
    begin
       result.Remplie := not str_Empty_Numeric(Dataset.FindField(FieldName).AsString);
       result.ChampRemplie :=FieldName;
       if result.Remplie then result.exo:='N'+inttostr(increment*-1);
       inc(increment,1);
       FieldName:='Mt_N'+IntToStr(increment);
    end;

if Result.ChampRemplie<>'' then
  result.Montant := Dataset.findfield(Result.ChampRemplie).AsCurrency;
end;

procedure TDMDeduction.initialiseTInfosDeduction(var infosDeduction:TInfosDeduction);
begin
  SetLength(infosDeduction.id,0);
  infosDeduction.Libelle :='';
  infosDeduction.Remplie := false;
  infosDeduction.ChampRemplie :='';
  infosDeduction.Montant :=0;
  infosDeduction.Exo:='';
end;


function TDMDeduction.RecupUtilisationDeduction(deduction:array of TvarRec;idCourant:integer;Dataset:TDataset):TinfosUtilisation;
var
TotauxGeneric:TTotauxGeneric;
i:integer;
filtre:string;
begin
if dataset=nil then dataset:=DMRech.TaUtilisation_deducRech;
    DMDeduction.initialiseTinfosUtilisation(result);
    if(high(deduction)>-1)then
    begin
    if DMRech = nil then DMRech := TDMRech.Create(Application.MainForm);
      Filtre:= CreeFiltreOU('id_deduction',deduction);
      if Filtre<>'' then Filtre:='('+Filtre+') and not('+CreeFiltreOU('id',[idCourant])+')';
      FiltrageDataSet(dataset,Filtre);
      TotauxGeneric:=SommeTotauxGeneric(['Mt_immo','Mt_social','Mt_stocks','Reinteg_except'],dataset);
      Result.Nb_utilisations := Result.Nb_utilisations+dataset.RecordCount;
      Result.Mt_immos := Result.Mt_immos+TotauxGeneric.Total1;
      Result.Mt_Social := Result.Mt_Social+TotauxGeneric.Total2;
      Result.Mt_Stocks := Result.Mt_Stocks+TotauxGeneric.Total3;
      Result.Reinteg_except := Result.Reinteg_except+TotauxGeneric.Total4;
      Result.MontantUtilise := Result.MontantUtilise+((TotauxGeneric.Total1+TotauxGeneric.Total2+TotauxGeneric.Total3+TotauxGeneric.Total4));
    end;
DeFiltrageDataSet(dataset);
end;

procedure TDMDeduction.initialiseTinfosUtilisation(var infosUtilisation:TinfosUtilisation);
begin
 infosUtilisation.Nb_utilisations:=0;
 infosUtilisation.MontantUtilise := 0;
 infosUtilisation.Mt_immos:= 0;
 infosUtilisation.Mt_Social:= 0;
 infosUtilisation.Mt_Stocks:= 0;
 infosUtilisation.Reinteg_except:= 0;
end;

procedure TDMDeduction.TaDeductionCalcFields(DataSet: TDataSet);
begin
TaDeductionResteCalcule.AsCurrency :=InfosDeductionCourante.Montant
   -  RecupUtilisationDeduction([TaDeduction.findfield('id').AsInteger]).MontantUtilise;
end;

procedure TDMDeduction.TaUtilisation_deducAfterEdit(DataSet: TDataSet);
begin
RecupUtilisationCourante;
end;

procedure TDMDeduction.TaDeductionFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
accept:=(not str_Empty_Numeric(TaDeductionMt_N.AsString)) or
         (not str_Empty_Numeric(TaDeductionMt_N1.AsString)) or
         (not str_Empty_Numeric(TaDeductionMt_N2.AsString)) or
         (not str_Empty_Numeric(TaDeductionMt_N3.AsString)) or
       (not str_Empty_Numeric(TaDeductionMt_N4.AsString)) or
         (not str_Empty_Numeric(TaDeductionMt_N5.AsString));
end;



Procedure TDMDeduction.ImportDeduction(Valeurs:array of const;DataSet:TDataSet);
Begin
  try
   ImportTable(Valeurs,DataSet);
  except
   abort;
  end;
End;





Function EditionDesDeductions(TypeEdition : integer; DemandePeriode:Boolean; Exercice:TStringList;DataSet:TDataSet;SousTitre:string):Boolean;
var
periode:TPeriode;
i,J:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
ExoTmp,libelleTmp,ExerciceTmp:string;
ParamAffichPeriode:TParamAffichPeriode;
ListeEdition:Tstringlist;
TitreExercice:string;
ResteProgressif,ResteProgressifApres,TotalUtilise:currency;
TotImmo,TotSocial,TotStocks,TotReinteg:currency;
TotUtilise,TotResteProgr,TotResteProgrApres:currency;
begin
try
TitreExercice:='';
ResteProgressif:=0;
TotalUtilise:=0;
TotImmo:=0;
TotSocial:=0;
TotStocks:=0;
TotReinteg:=0;
TotUtilise:=0;
TotResteProgr:=0;
TotResteProgrApres:=0;
ObjPrn:=TObjetEdition.Create(application.MainForm);
//  if DemandePeriode then
//   begin
//     if Choix_Periode=nil then Choix_Periode:=tChoix_Periode.Create(application.MainForm);
//     Choix_Periode.EdDateFin.Enabled:=false;
//     Initialise_ParamAffichPeriode(ParamAffichPeriode);
//     periode:=ChoixPeriodeAffich(dateDebutImmos,e.DatExoDebut-1,'',ParamAffichPeriode)
//   end
//  else
//    begin
     periode.Retour := true;
     periode.DateDeb := E.DatExoDebut;
     periode.DateFin :=  E.DatExoFin-1;
//    end;
  if periode.Retour then
   begin

    ObjPrn.FontLigneSeule.Style := [fsBold];

    ListeValeur:=TStringList.Create;
    ListeEdition:=TStringList.Create;

    if DMDeduction =nil then DMDeduction:=TDMDeduction.Create(Application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
        DMDeduction.ListeFilterRecordDeductions.clear;
        if (Exercice<>nil)and(Exercice.Count=0)then abort;
        if Exercice<>nil then      // Tous les Exercice
         begin
          TitreExercice:='De l''exercice :'+Exercice.Strings[0]+' à l''exercice :'+Exercice.Strings[Exercice.count-1];
          DMDeduction.ListeFilterRecordDeductions.Assign(Exercice);
          DMDeduction.QuDeductionEdition.OnFilterRecord:=DMDeduction.QuDeductionEditionFilterRecord;
          DMDeduction.QuDeductionEdition.filtered:=true;
         end
        else
          begin
            DMDeduction.QuDeductionEdition.OnFilterRecord:=nil;
            TitreExercice:=' Tous les Exercices ';
          end;

          DMDeduction.QuDeductionEdition.Close;
          DMDeduction.QuDeductionEdition.Open;
          DMDeduction.QuDeductionEdition.First;
          if DMDeduction.QuDeductionEdition.recordcount<>0 then
          begin
          ExoTmp:=DMDeduction.QuDeductionEdition.FindField('Exo').AsString;
          libelleTmp:=DMDeduction.QuDeductionEdition.FindField('Libelle').AsString;
          ListeValeur.Add('9;Déductions pratiquées sur l''exercice '+GereLibelle(ExoTmp)+' : '+
          libelleTmp+'      : '+E.FormatCurr(DMDeduction.QuDeductionEdition.FindField('montant').AsCurrency));
         TotalUtilise:=DMDeduction.QuDeductionEdition.FindField('Mt_Immo').AsCurrency+
         DMDeduction.QuDeductionEdition.FindField('Mt_social').AsCurrency+
         DMDeduction.QuDeductionEdition.FindField('Mt_stocks').AsCurrency;

          ResteProgressif:=DMDeduction.QuDeductionEdition.FindField('montant').AsCurrency-TotalUtilise;
          ResteProgressifApres:=DMDeduction.QuDeductionEdition.FindField('montant').AsCurrency-TotalUtilise-
          DMDeduction.QuDeductionEdition.FindField('Reinteg_except').AsCurrency;
          ExerciceTmp:=DMDeduction.QuDeductionEdition.FindField('Exercice').AsString;
          while not DMDeduction.QuDeductionEdition.Eof do
            begin
          TotImmo:=TotImmo+DMDeduction.QuDeductionEdition.FindField('Mt_Immo').AsCurrency;
          TotSocial:=TotSocial+DMDeduction.QuDeductionEdition.FindField('Mt_social').AsCurrency;
          TotStocks:=TotStocks+DMDeduction.QuDeductionEdition.FindField('Mt_stocks').AsCurrency;
          TotReinteg:=TotReinteg+DMDeduction.QuDeductionEdition.FindField('Reinteg_except').AsCurrency;
          TotUtilise:=TotUtilise+TotalUtilise;
          TotResteProgr:=ResteProgressif;
          TotResteProgrApres:=ResteProgressifApres;
                  ListeEdition.Add(GereLibelle('Utilisation sur l''exercice '+DMDeduction.QuDeductionEdition.FindField('Exercice').AsString)+
                                   ';'+
                                   GereLibelle(DMDeduction.QuDeductionEdition.FindField('Mt_Immo').AsString)+
                                   ';'+
                                   GereLibelle(DMDeduction.QuDeductionEdition.FindField('Mt_social').AsString)+
                                   ';'+
                                   GereLibelle(DMDeduction.QuDeductionEdition.FindField('Mt_stocks').AsString)+
                                   ';'+
                                   CurrToStr_Lgr(TotalUtilise)+
                                   ';'+
                                   CurrToStr_Lgr(ResteProgressif)+
                                   ';'+
                                   DMDeduction.QuDeductionEdition.FindField('Reinteg_except').AsString+
                                   ';'+
                                   CurrToStr_Lgr(ResteProgressifApres));
              if(TotalUtilise+DMDeduction.QuDeductionEdition.FindField('Reinteg_except').AsCurrency<>0)then
                  ListeValeur.Add('0'+
                                  ';'+
                                   GereLibelle('Utilisation sur l''exercice '+DMDeduction.QuDeductionEdition.FindField('Exercice').AsString)+
                                   ';'+
                                   GereLibelle(DMDeduction.QuDeductionEdition.FindField('Mt_Immo').AsString)+
                                   ';'+
                                   GereLibelle(DMDeduction.QuDeductionEdition.FindField('Mt_social').AsString)+
                                   ';'+
                                   GereLibelle(DMDeduction.QuDeductionEdition.FindField('Mt_stocks').AsString)+
                                   ';'+
                                   CurrToStr_Lgr(TotalUtilise)+
                                   ';'+
                                   CurrToStr_Lgr(ResteProgressif)+
                                   ';'+
                                   DMDeduction.QuDeductionEdition.FindField('Reinteg_except').AsString+
                                   ';'+
                                   CurrToStr_Lgr(ResteProgressifApres));
                   DMDeduction.QuDeductionEdition.Next;
         TotalUtilise:=DMDeduction.QuDeductionEdition.FindField('Mt_Immo').AsCurrency+
         DMDeduction.QuDeductionEdition.FindField('Mt_social').AsCurrency+
         DMDeduction.QuDeductionEdition.FindField('Mt_stocks').AsCurrency;

                   ResteProgressif:=ResteProgressif-TotalUtilise;
                   ResteProgressifApres:=ResteProgressifApres-TotalUtilise-DMDeduction.QuDeductionEdition.FindField('Reinteg_except').AsCurrency;
              if (ExoTmp<>DMDeduction.QuDeductionEdition.FindField('Exo').AsString)or(libelleTmp<>DMDeduction.QuDeductionEdition.FindField('Libelle').AsString) then
                begin
                   if(ExerciceTmp<>'')then
                           ListeValeur.Add('1;@Total '+GereLibelle('exercice '+ExerciceTmp)+' ;'+E.FormatCurr(TotImmo) +';'+E.FormatCurr(TotSocial)+';'+E.FormatCurr(TotStocks)+';'+E.FormatCurr(TotUtilise)+';'+E.FormatCurr(TotResteProgr)+';'+E.FormatCurr(TotReinteg)+';'+E.FormatCurr(TotResteProgrApres));
                  ExoTmp:=DMDeduction.QuDeductionEdition.FindField('Exo').AsString;
                  libelleTmp:=DMDeduction.QuDeductionEdition.FindField('Libelle').AsString;
                  ListeValeur.Add('9;Déductions pratiquées sur l''exercice '+GereLibelle(ExoTmp)+' : '+
                  libelleTmp+'      : '+E.FormatCurr(DMDeduction.QuDeductionEdition.FindField('montant').AsCurrency));
                   TotalUtilise:=DMDeduction.QuDeductionEdition.FindField('Mt_Immo').AsCurrency+
                   DMDeduction.QuDeductionEdition.FindField('Mt_social').AsCurrency+
                   DMDeduction.QuDeductionEdition.FindField('Mt_stocks').AsCurrency;

                    ResteProgressif:=DMDeduction.QuDeductionEdition.FindField('montant').AsCurrency-TotalUtilise;
                    ResteProgressifApres:=DMDeduction.QuDeductionEdition.FindField('montant').AsCurrency-TotalUtilise-DMDeduction.QuDeductionEdition.FindField('Reinteg_except').AsCurrency;
                   ExerciceTmp:=DMDeduction.QuDeductionEdition.FindField('Exercice').AsString;
                   TotImmo:=0;
                   TotSocial:=0;
                   TotStocks:=0;
                   TotReinteg:=0;
                   TotUtilise:=0;
                   TotResteProgr:=0;
                   TotResteProgrApres:=0;
                end
              else
                if (ExerciceTmp<>DMDeduction.QuDeductionEdition.FindField('Exercice').AsString) then
                  begin
                     if(ExerciceTmp<>'')then
                            ListeValeur.Add('1;@Total '+GereLibelle('exercice '+ExerciceTmp)+' ;'+E.FormatCurr(TotImmo) +';'+E.FormatCurr(TotSocial)+';'+E.FormatCurr(TotStocks)+';'+E.FormatCurr(TotUtilise)+';'+E.FormatCurr(TotResteProgr)+';'+E.FormatCurr(TotReinteg)+';'+E.FormatCurr(TotResteProgrApres));
                     ExerciceTmp:=DMDeduction.QuDeductionEdition.FindField('Exercice').AsString;
                     TotImmo:=0;
                     TotSocial:=0;
                     TotStocks:=0;
                     TotReinteg:=0;
                     TotUtilise:=0;
                     TotResteProgr:=0;
                     TotResteProgrApres:=0;
                  end;

            end;//fin du while not DataModuleImmos.QuAcquisition_Edition.eof

             if DMDeduction.QuDeductionEdition.FindField('Exercice').AsString<>''then
//               ListeValeur.Add('1;@Total '+GereLibelle('exercice '+DMDeduction.QuDeductionEdition.FindField('Exercice').AsString)+' ;'+E.FormatCurr(TotImmo) +';'+E.FormatCurr(TotSocial)+';'+E.FormatCurr(TotStocks)+';'+E.FormatCurr(TotalUtilise)+';'+E.FormatCurr(ResteProgressif)+';'+E.FormatCurr(TotReinteg)+';'+E.FormatCurr(ResteProgressifApres));
                ListeValeur.Add('1;@Total '+GereLibelle('exercice '+ExerciceTmp)+' ;'+E.FormatCurr(TotImmo) +';'+E.FormatCurr(TotSocial)+';'+E.FormatCurr(TotStocks)+';'+E.FormatCurr(TotUtilise)+';'+E.FormatCurr(TotResteProgr)+';'+E.FormatCurr(TotReinteg)+';'+E.FormatCurr(TotResteProgrApres));
             ObjPrn.FTitreEdition := ' Utilisation des déductions pour investissement ';
             ObjPrn.FSousTitreEdition:=SousTitre;
             //ObjPrn.FTitre2Edition :=TitreExercice;
             ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
             ObjPrn.FTitre3Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr  ;
             ObjPrn.Orientation:=poLandscape;
             j:=0;
              ObjPrn.FTitre3Edition := 'Exercice : du '+datetostr(e.DatExoDebut)+' au '+datetostr(e.DatExoFin);
              ListeValeur.Insert(0,'  ;  ; coop. ;  ; utilisé ; utiliser ; exceptionnelle ; Réintégr. except.');
              ListeValeur.Insert(1,'1.5;1.3;1.3;1.3;1.3;1.3;1.3;1.3');
              ListeValeur.Insert(2,'texte;curr;curr;curr;curr;curr;curr;curr');
              ListeValeur.Insert(3,' Utilisation ; immos ; Parts sociales ; stocks ; Total ; Reste à ; Réintégration ; Reste après ;SURTITRE');
              ListeValeur.Insert(4,'1.5;1.3;1.3;1.3;1.3;1.3;1.3;1.3');
          end;
     if TypeEdition=C_Exportation then
        ExportDonnees(ListeEdition,E.RepertoireExportDossier,'Deductions_'+E.NomDossier + E.NomExo + '.Txt')
     else
       ObjPrn.AffichageImp(ListeValeur);
  end;//fin du periode.retour
finally
  if Choix_Periode<>nil then Choix_Periode.EdDateFin.Enabled:=true;
  LibereObjet(Tobject(ObjPrn));
  Initialise_TStringlist(ListeEdition);
end;
end;

Function EditionDesDeductions(TypeEdition : integer; DemandePeriode:Boolean; Exercice:string;DataSet:TDataSet;SousTitre:string):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(Retour);
  try
   Maliste:=TStringList.Create;
   if not empty (Exercice)then
     Maliste.Add(Exercice)
   else
     raise ExceptLGR.Create('Aucun Compte n''est defini !',1000,true,mtError,Retour);
   EditionDesDeductions(TypeEdition,DemandePeriode,Maliste,DataSet,SousTitre);
  except
     abort;
  end;
end;


Function EditionAmort_A_Reinteg(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string):Boolean;
var
periode:TPeriode;
i,J:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
CompteTmp:string;
ParamAffichPeriode:TParamAffichPeriode;
ListeEdition:Tstringlist;
TitreCompte:string;
AmortReintegr,Reste:currency;
TotDeduction,TotAmort,TotReinteg,TotReprise,TotReste:currency;
TotGenDeduction,TotGenAmort,TotGenReinteg,TotGenReprise,TotGenReste:currency;
TotGenReintegAmort,TotGenReintegSocial,Reinteg_except_N,DPINonAffectees,NewDPI:currency;
RepertoireImmos:string;
begin
try
TitreCompte:='';
TotGenReintegAmort:=0;
TotGenReintegSocial:=0;
Reinteg_except_N:=0;
DPINonAffectees:=0;
AmortReintegr:=0;
Reste:=0;
NewDPI:=0;
ObjPrn:=TObjetEdition.Create(application.MainForm);
if E.ExerciceCloture then RepertoireImmos:=e.RepertoireExercice
else RepertoireImmos:=e.RepertoireDossier;
RepertoireImmos := IncludeTrailingPathDelimiter(RepertoireImmos);
//  if DemandePeriode then
//   begin
//     if Choix_Periode=nil then Choix_Periode:=tChoix_Periode.Create(application.MainForm);
//     Choix_Periode.EdDateFin.Enabled:=false;
//     Initialise_ParamAffichPeriode(ParamAffichPeriode);
//     periode:=ChoixPeriodeAffich(dateDebutImmos,e.DatExoDebut-1,'',ParamAffichPeriode)
//   end
//  else
//    begin
     periode.Retour := true;
     periode.DateDeb := E.DatExoDebut;
     periode.DateFin :=  E.DatExoFin-1;
//    end;
  if periode.Retour then
   begin

    ObjPrn.FontLigneSeule.Style := [fsBold];

    ListeValeur:=TStringList.Create;
    ListeEdition:=TStringList.Create;

    if DMDeduction =nil then DMDeduction:=TDMDeduction.Create(Application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
        DMDeduction.ListeFilterRecordDeductions.clear;
        if (Compte<>nil)and(Compte.Count=0)then abort;
        if Compte<>nil then      // Tous les comptes
         begin
          TitreCompte:='Du compte :'+Compte.Strings[0]+' au compte :'+Compte.Strings[Compte.count-1];
          DMDeduction.ListeFilterRecordDeductions.Assign(Compte);
          DMDeduction.QuEditionAmort_A_Reinteg.OnFilterRecord:=DMDeduction.QuEditionAmort_A_ReintegFilterRecord;
          DMDeduction.QuEditionAmort_A_Reinteg.filtered:=true;
         end
        else
          begin
            DMDeduction.QuEditionAmort_A_Reinteg.OnFilterRecord:=DMDeduction.QuEditionAmort_A_ReintegFilterRecord;
            DMDeduction.QuEditionAmort_A_Reinteg.filtered:=true;
            TitreCompte:=' Tous les comptes ';
          end;

          //début de la réintégration des amortissements
          TotDeduction:=0;
          TotAmort:=0;
          TotReinteg:=0;
          TotReprise:=0;
          TotReste:=0;
          TotGenDeduction:=0;
          TotGenAmort:=0;
          TotGenReinteg:=0;
          TotGenReprise:=0;
          TotGenReste:=0;

          DMDeduction.QuEditionAmort_A_Reinteg.Close;
          DMDeduction.QuEditionAmort_A_Reinteg.SQL.Clear;
          DMDeduction.QuEditionAmort_A_Reinteg.sql.Add(' select compte, (compte||''-''||code||''-''||sous_code)as immo,Date_achat,valeur_a_amortir,mt_deduc_invest,choix,');
          DMDeduction.QuEditionAmort_A_Reinteg.sql.Add(' ((mt_deduc_invest/valeur_a_amortir)*choix)as Amort_a_reinteg,reprise_deduc_invest');
          DMDeduction.QuEditionAmort_A_Reinteg.sql.Add(' ,libelle from "'+RepertoireImmos+'immos.db" where (mt_deduc_invest is not null) and (mt_deduc_invest<>0)');
          DMDeduction.QuEditionAmort_A_Reinteg.sql.Add(' and (reprise_deduc_invest<mt_deduc_invest) and (date_cession is null or date_cession  between :dateDeb and :DateFin)');
          DMDeduction.QuEditionAmort_A_Reinteg.sql.Add(' and compte not like(''262%'')');
          DMDeduction.QuEditionAmort_A_Reinteg.sql.Add(' order by compte,immo');
          DMDeduction.QuEditionAmort_A_Reinteg.ParamByName('dateDeb').AsDateTime:=E.DatExoDebut;
          DMDeduction.QuEditionAmort_A_Reinteg.ParamByName('DateFin').AsDateTime:=E.DatExoFin;
          DMDeduction.QuEditionAmort_A_Reinteg.Open;
          DMDeduction.QuEditionAmort_A_Reinteg.First;
          if DMDeduction.QuEditionAmort_A_Reinteg.recordcount<>0 then
          begin
          CompteTmp:=DMDeduction.QuEditionAmort_A_Reinteg.FindField('compte').AsString;

          ListeValeur.Add('9;Amortissements à réintégrer');
         end;
//          ListeValeur.Add('9;Compte : '+GereLibelle(CompteTmp));

          while not DMDeduction.QuEditionAmort_A_Reinteg.Eof do
            begin

            TotDeduction:=TotDeduction+DMDeduction.QuEditionAmort_A_Reinteg.FindField('mt_deduc_invest').AsCurrency;
            TotAmort:=TotAmort+DMDeduction.QuEditionAmort_A_Reinteg.FindField('choix').AsCurrency;

            if(DMDeduction.QuEditionAmort_A_Reinteg.FindField('Amort_a_reinteg').AsCurrency+
              DMDeduction.QuEditionAmort_A_Reinteg.FindField('reprise_deduc_invest').AsCurrency>DMDeduction.QuEditionAmort_A_Reinteg.FindField('mt_deduc_invest').AsCurrency)then
              AmortReintegr:=DMDeduction.QuEditionAmort_A_Reinteg.FindField('mt_deduc_invest').AsCurrency-DMDeduction.QuEditionAmort_A_Reinteg.FindField('reprise_deduc_invest').AsCurrency
            else
              AmortReintegr:=DMDeduction.QuEditionAmort_A_Reinteg.FindField('Amort_a_reinteg').AsCurrency;
            AmortReintegr:=arrondi(AmortReintegr,2);
            TotReinteg:=TotReinteg+AmortReintegr;

            TotReprise:=TotReprise+arrondi(DMDeduction.QuEditionAmort_A_Reinteg.FindField('reprise_deduc_invest').AsCurrency,2);
            Reste:=DMDeduction.QuEditionAmort_A_Reinteg.FindField('mt_deduc_invest').AsCurrency-AmortReintegr-arrondi(DMDeduction.QuEditionAmort_A_Reinteg.FindField('reprise_deduc_invest').AsCurrency,2);
            TotReste:=TotReste+Reste;

            TotGenDeduction:=TotGenDeduction+DMDeduction.QuEditionAmort_A_Reinteg.FindField('mt_deduc_invest').AsCurrency;
            TotGenAmort:=TotGenAmort+DMDeduction.QuEditionAmort_A_Reinteg.FindField('choix').AsCurrency;
            TotGenReinteg:=TotGenReinteg+AmortReintegr;
            TotGenReprise:=TotGenReprise+arrondi(DMDeduction.QuEditionAmort_A_Reinteg.FindField('reprise_deduc_invest').AsCurrency,2);
            TotGenReste:=TotGenReste+Reste;

                  ListeEdition.Add(GereLibelle(DMDeduction.QuEditionAmort_A_Reinteg.FindField('immo').AsString)+
                                   ';'+
                                   GereLibelle(DMDeduction.QuEditionAmort_A_Reinteg.FindField('libelle').AsString)+
                                   ';'+
                                   GereLibelle(DMDeduction.QuEditionAmort_A_Reinteg.FindField('Date_Achat').AsString)+
                                   ';'+
                                   E.FormatCurr(DMDeduction.QuEditionAmort_A_Reinteg.FindField('valeur_a_amortir').AsCurrency)+
                                   ';'+
                                   E.FormatCurr(DMDeduction.QuEditionAmort_A_Reinteg.FindField('mt_deduc_invest').AsCurrency)+
                                   ';'+
                                   E.FormatCurr(DMDeduction.QuEditionAmort_A_Reinteg.FindField('choix').AsCurrency)+
                                   ';'+
                                   E.FormatCurr(AmortReintegr)+
                                   ';'+
                                   E.FormatCurr(DMDeduction.QuEditionAmort_A_Reinteg.FindField('reprise_deduc_invest').AsCurrency)+
                                   ';'+
                                   E.FormatCurr(Reste));
                  ListeValeur.Add('0'+
                                  ';'+
                                   GereLibelle(DMDeduction.QuEditionAmort_A_Reinteg.FindField('immo').AsString)+
                                   ';'+
                                   GereLibelle(DMDeduction.QuEditionAmort_A_Reinteg.FindField('libelle').AsString)+
                                   ';'+
                                   GereLibelle(DMDeduction.QuEditionAmort_A_Reinteg.FindField('Date_Achat').AsString)+
                                   ';'+
                                   E.FormatCurr(DMDeduction.QuEditionAmort_A_Reinteg.FindField('valeur_a_amortir').AsCurrency)+
                                   ';'+
                                   E.FormatCurr(DMDeduction.QuEditionAmort_A_Reinteg.FindField('mt_deduc_invest').AsCurrency)+
                                   ';'+
                                   E.FormatCurr(DMDeduction.QuEditionAmort_A_Reinteg.FindField('choix').AsCurrency)+
                                   ';'+
                                   E.FormatCurr(AmortReintegr)+
                                   ';'+
                                   E.FormatCurr(DMDeduction.QuEditionAmort_A_Reinteg.FindField('reprise_deduc_invest').AsCurrency)+
                                   ';'+
                                   E.FormatCurr(Reste));
                   DMDeduction.QuEditionAmort_A_Reinteg.Next;
              if CompteTmp<>DMDeduction.QuEditionAmort_A_Reinteg.FindField('compte').AsString then
                begin
//                  ListeValeur.Add('1;;;@TOTAL Du Compte: '+CompteTmp+' ;'+E.FormatCurr(TotDeduction) +';'+E.FormatCurr(TotAmort)+';'+E.FormatCurr(TotReinteg)+';'+E.FormatCurr(TotReprise)+';'+E.FormatCurr(TotReste));
                  TotDeduction:=0;
                  TotAmort:=0;
                  TotReinteg:=0;
                  TotReprise:=0;
                  TotReste:=0;
                  CompteTmp:=DMDeduction.QuEditionAmort_A_Reinteg.FindField('compte').AsString;
//                  ListeValeur.Add('9;Compte : '+GereLibelle(CompteTmp));
                end;
            end;//fin du while not DMDeduction.QuEditionAmort_A_Reinteg.eof
//            ListeValeur.Add('1;;;@TOTAL Du Compte: '+CompteTmp+' ;'+E.FormatCurr(TotDeduction) +';'+E.FormatCurr(TotAmort)+';'+E.FormatCurr(TotReinteg)+';'+E.FormatCurr(TotReprise)+';'+E.FormatCurr(TotReste));
            if(TotGenDeduction<>0)or(TotGenAmort<>0)or(TotGenReinteg<>0)or(TotGenReprise<>0)or(TotGenReste<>0) then
              ListeValeur.Add('3;;;;@TOTAL général ;'+E.FormatCurr(TotGenDeduction) +';'+E.FormatCurr(TotGenAmort)+';'+E.FormatCurr(TotGenReinteg)+';'+E.FormatCurr(TotGenReprise)+';'+E.FormatCurr(TotGenReste));
            TotGenReintegAmort:=TotGenReinteg;
            //end;//fin si recordcount<>0
            //fin de la reintégration des amortissements

            //début de la réintégration des parts sociales
          TotDeduction:=0;
          TotAmort:=0;
          TotReinteg:=0;
          TotReprise:=0;
          TotReste:=0;
          TotGenDeduction:=0;
          TotGenAmort:=0;
          TotGenReinteg:=0;
          TotGenReprise:=0;
          TotGenReste:=0;
          DMDeduction.QuEditionAmort_A_Reinteg.Close;
          DMDeduction.QuEditionAmort_A_Reinteg.SQL.Clear;
          DMDeduction.QuEditionAmort_A_Reinteg.sql.Add(' select compte, (compte||''-''||code||''-''||sous_code)as immo,Date_achat,valeur_a_amortir,mt_deduc_invest,');
          DMDeduction.QuEditionAmort_A_Reinteg.sql.Add(' (mt_deduc_invest/10)as Amort_a_reinteg,reprise_deduc_invest');
          DMDeduction.QuEditionAmort_A_Reinteg.sql.Add(' ,libelle from "'+RepertoireImmos+'immos.db" where (mt_deduc_invest is not null) and (mt_deduc_invest<>0)');
          DMDeduction.QuEditionAmort_A_Reinteg.sql.Add(' and (reprise_deduc_invest<mt_deduc_invest) and (date_cession is null or date_cession  between :dateDeb and :DateFin)');
          DMDeduction.QuEditionAmort_A_Reinteg.sql.Add(' and compte like(''262%'') and achat_dans_annee=false');
          DMDeduction.QuEditionAmort_A_Reinteg.sql.Add(' order by compte,immo');
          DMDeduction.QuEditionAmort_A_Reinteg.ParamByName('dateDeb').AsDateTime:=E.DatExoDebut;
          DMDeduction.QuEditionAmort_A_Reinteg.ParamByName('DateFin').AsDateTime:=E.DatExoFin;
          DMDeduction.QuEditionAmort_A_Reinteg.Open;
          DMDeduction.QuEditionAmort_A_Reinteg.First;
          if DMDeduction.QuEditionAmort_A_Reinteg.recordcount<>0 then
          begin
          CompteTmp:=DMDeduction.QuEditionAmort_A_Reinteg.FindField('compte').AsString;

          ListeValeur.Add('9;Parts sociales de coopérative à réintégrer');
          end;
//          ListeValeur.Add('9;Compte : '+GereLibelle(CompteTmp));

          while not DMDeduction.QuEditionAmort_A_Reinteg.Eof do
            begin

            TotDeduction:=TotDeduction+DMDeduction.QuEditionAmort_A_Reinteg.FindField('mt_deduc_invest').AsCurrency;
            if(DMDeduction.QuEditionAmort_A_Reinteg.FindField('reprise_deduc_invest').AsCurrency+
              DMDeduction.QuEditionAmort_A_Reinteg.FindField('Amort_a_reinteg').AsCurrency>DMDeduction.QuEditionAmort_A_Reinteg.FindField('mt_deduc_invest').AsCurrency)then
              AmortReintegr :=DMDeduction.QuEditionAmort_A_Reinteg.FindField('mt_deduc_invest').AsCurrency-DMDeduction.QuEditionAmort_A_Reinteg.FindField('reprise_deduc_invest').AsCurrency
            else
              AmortReintegr :=DMDeduction.QuEditionAmort_A_Reinteg.FindField('Amort_a_reinteg').AsCurrency;
            AmortReintegr:=arrondi(AmortReintegr,2);
            TotReinteg:=TotReinteg+AmortReintegr;
            TotReprise:=TotReprise+arrondi(DMDeduction.QuEditionAmort_A_Reinteg.FindField('reprise_deduc_invest').AsCurrency,2);
            Reste :=DMDeduction.QuEditionAmort_A_Reinteg.FindField('mt_deduc_invest').AsCurrency-AmortReintegr-arrondi(DMDeduction.QuEditionAmort_A_Reinteg.FindField('reprise_deduc_invest').AsCurrency,2);
            TotReste:=TotReste+Reste;

            TotGenDeduction:=TotGenDeduction+DMDeduction.QuEditionAmort_A_Reinteg.FindField('mt_deduc_invest').AsCurrency;
            TotGenReinteg:=TotGenReinteg+AmortReintegr;
            TotGenReprise:=TotGenReprise+arrondi(DMDeduction.QuEditionAmort_A_Reinteg.FindField('reprise_deduc_invest').AsCurrency,2);
            TotGenReste:=TotGenReste+Reste;

                  ListeEdition.Add(GereLibelle(DMDeduction.QuEditionAmort_A_Reinteg.FindField('immo').AsString)+
                                   ';'+
                                   GereLibelle(DMDeduction.QuEditionAmort_A_Reinteg.FindField('libelle').AsString)+
                                   ';'+
                                   GereLibelle(DMDeduction.QuEditionAmort_A_Reinteg.FindField('Date_Achat').AsString)+
                                   ';'+
                                   E.FormatCurr(DMDeduction.QuEditionAmort_A_Reinteg.FindField('valeur_a_amortir').AsCurrency)+
                                   ';'+
                                   E.FormatCurr(DMDeduction.QuEditionAmort_A_Reinteg.FindField('mt_deduc_invest').AsCurrency)+
                                   ';'+
                                   ''+
                                   ';'+
                                   E.FormatCurr(AmortReintegr)+
                                   ';'+
                                   E.FormatCurr(DMDeduction.QuEditionAmort_A_Reinteg.FindField('reprise_deduc_invest').AsCurrency)+
                                   ';'+
                                   E.FormatCurr(Reste));
                  ListeValeur.Add('0'+
                                  ';'+
                                   GereLibelle(DMDeduction.QuEditionAmort_A_Reinteg.FindField('immo').AsString)+
                                   ';'+
                                   GereLibelle(DMDeduction.QuEditionAmort_A_Reinteg.FindField('libelle').AsString)+
                                   ';'+
                                   GereLibelle(DMDeduction.QuEditionAmort_A_Reinteg.FindField('Date_Achat').AsString)+
                                   ';'+
                                   E.FormatCurr(DMDeduction.QuEditionAmort_A_Reinteg.FindField('valeur_a_amortir').AsCurrency)+
                                   ';'+
                                   E.FormatCurr(DMDeduction.QuEditionAmort_A_Reinteg.FindField('mt_deduc_invest').AsCurrency)+
                                   ';'+
                                   ''+
                                   ';'+
                                   E.FormatCurr(AmortReintegr)+
                                   ';'+
                                   E.FormatCurr(DMDeduction.QuEditionAmort_A_Reinteg.FindField('reprise_deduc_invest').AsCurrency)+
                                   ';'+
                                   E.FormatCurr(Reste));
                   DMDeduction.QuEditionAmort_A_Reinteg.Next;
              if CompteTmp<>DMDeduction.QuEditionAmort_A_Reinteg.FindField('compte').AsString then
                begin
//                  ListeValeur.Add('1;;;@TOTAL Du Compte: '+CompteTmp+' ;'+E.FormatCurr(TotDeduction) +';'+E.FormatCurr(TotAmort)+';'+E.FormatCurr(TotReinteg)+';'+E.FormatCurr(TotReprise)+';'+E.FormatCurr(TotReste));
                  TotDeduction:=0;
                  TotAmort:=0;
                  TotReinteg:=0;
                  TotReprise:=0;
                  TotReste:=0;
                  CompteTmp:=DMDeduction.QuEditionAmort_A_Reinteg.FindField('compte').AsString;
//                  ListeValeur.Add('9;Compte : '+GereLibelle(CompteTmp));
                end;
            end;//fin du while not DMDeduction.QuEditionAmort_A_Reinteg.eof
//            ListeValeur.Add('1;;;@TOTAL Du Compte: '+CompteTmp+' ;'+E.FormatCurr(TotDeduction) +';'+E.FormatCurr(TotAmort)+';'+E.FormatCurr(TotReinteg)+';'+E.FormatCurr(TotReprise)+';'+E.FormatCurr(TotReste));
            if(TotGenDeduction<>0)or(TotGenAmort<>0)or(TotGenReinteg<>0)or(TotGenReprise<>0)or(TotGenReste<>0) then
              ListeValeur.Add('3;;;;@TOTAL général ;'+E.FormatCurr(TotGenDeduction) +';'+E.FormatCurr(TotGenAmort)+';'+E.FormatCurr(TotGenReinteg)+';'+E.FormatCurr(TotGenReprise)+';'+E.FormatCurr(TotGenReste));
            TotGenReintegSocial:=TotGenReinteg;
          // end;// si recordcount<>0
            // fin de la réintégration des parts sociales
            Reinteg_except_N:=DMDeduction.ReintegrationExceptionnelleDansExerciceN;
            DPINonAffectees:=DMDeduction.DPI_NonAffecteesDansLes5Ans;
            NewDPI:=DMDeduction.Recup_IDDeductionNx('Mt_N').Montant;
          if (ListeValeur.Count<>0) or (Reinteg_except_N<>0) or (DPINonAffectees<>0) or( NewDPI<>0 )then
           begin
            ListeValeur.Add('1;;;;;;;;');
            ListeValeur.Add('3;;;;@Total des amortissements à réintégrer;'+E.FormatCurr(TotGenReintegAmort));
            ListeValeur.Add('3;;;;@Total des parts sociales à réintégrer;'+E.FormatCurr(TotGenReintegSocial));
            ListeValeur.Add('3;;;;@DPI non affectées dans les 5 ans;'+E.FormatCurr(DPINonAffectees));
            ListeValeur.Add('3;;;;@Réintégrations exceptionnelles;'+E.FormatCurr(Reinteg_except_N));
            ListeValeur.Add('1;;;;@Total à réintégrer au résultat de l''exercice;'+E.FormatCurr(TotGenReintegAmort+TotGenReintegSocial+DPINonAffectees+Reinteg_except_N));
            ListeValeur.Add('3;;;;@Nouvelles DPI pratiquées le : '+datetostr(e.DatExoFin)+
               ' (à déduire du resultat de l''exercice) ;'+E.FormatCurr(NewDPI));
            ListeValeur.Add('1;;;;@Solde des DPI le : '+datetostr(e.DatExoFin)+' ;'+E.FormatCurr((TotGenReintegAmort+TotGenReintegSocial+DPINonAffectees+Reinteg_except_N)-NewDPI));

             ObjPrn.FTitreEdition := ' Réintégration des déductions pour investissement (DPI)';
             ObjPrn.FSousTitreEdition:=SousTitre;
             //ObjPrn.FTitre2Edition :=TitreCompte;
             ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
             ObjPrn.FTitre3Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr  ;
             ObjPrn.Orientation:=poLandscape;
             j:=0;
              ObjPrn.FTitre3Edition := 'Exercice : du '+datetostr(e.DatExoDebut)+' au '+datetostr(e.DatExoFin);
              ListeValeur.Insert(0,' ;  ;  ; d''acquisition ; affectée ; de l''année ; Réintégrer ; années antér.; Réintégrer ');
              ListeValeur.Insert(1,'1.5;2.0;1.0;1.0;1.0;1.0;1.0;1.0;1.0');
              ListeValeur.Insert(2,'texte;texte;texte;curr;curr;curr;curr;curr;curr');
              ListeValeur.Insert(3,' N° immobilisation ; Désignation ; Date d''achat ; Valeur ; Déduction ; Amort. Comptable ; Amort. à ; Réintégration ; Reste à ;SURTITRE');
              ListeValeur.Insert(4,'1.5;2.0;1.0;1.0;1.0;1.0;1.0;1.0;1.0');
          end;
     if TypeEdition=C_Exportation then
        ExportDonnees(ListeEdition,E.RepertoireExportDossier,'Deductions_'+E.NomDossier + E.NomExo + '.Txt')
     else
       ObjPrn.AffichageImp(ListeValeur);
  end;//fin du periode.retour
finally
  if Choix_Periode<>nil then Choix_Periode.EdDateFin.Enabled:=true;
  LibereObjet(Tobject(ObjPrn));
  Initialise_TStringlist(ListeEdition);
end;
end;

Function EditionAmort_A_Reinteg(TypeEdition : integer; DemandePeriode:Boolean; Compte:string;DataSet:TDataSet;SousTitre:string):Boolean;
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
   EditionAmort_A_Reinteg(TypeEdition,DemandePeriode,Maliste,DataSet,SousTitre);
  except
     abort;
  end;
end;


function TDMDeduction.DPI_NonAffecteesDansLes5Ans:currency;
var
deduction:TInfosDeduction;
Montant,MontantUtilise:currency;
begin
result:=0;
     Montant:=Recup_IDDeductionNx('Mt_N5').Montant;
     MontantUtilise:=RecupUtilisationDeduction(Recup_IDDeductionNx('Mt_N5').id).MontantUtilise;
     result:=Montant-MontantUtilise ;

end;

function TDMDeduction.ReintegrationExceptionnelleDansExerciceN:currency;
var
deduction:TInfosDeduction;
TotauxGeneric:TTotauxGeneric;
begin
result:=0;
FiltrageDataSet(DMRech.TaUtilisation_deducRech,CreeFiltreOU('Exercice',['N']));
TotauxGeneric:=SommeTotauxGeneric(['Reinteg_except'],DMRech.TaUtilisation_deducRech);
Result:=TotauxGeneric.Total1;
end;

function TDMDeduction.Recup_IDDeductionNx(ChampNx:String):TInfosDeduction;
begin
initialiseTInfosDeduction(result);
FiltrageDataSet(DMRech.TaDeductionRech,'('+ChampNx+' <>0)and('+ChampNx+' is not null)');
if DMRech.TaDeductionRech.RecordCount>0 then
begin
     result:=InfosDeductionSurNx(DMRech.TaDeductionRech);
end;
end;

procedure TDMDeduction.RecupUtilisationCourante;
begin
initialiseTinfosUtilisation(utilisationCourante);
utilisationCourante.Mt_immos:=TaUtilisation_deducMt_immo.AsCurrency;
utilisationCourante.Mt_Social:=TaUtilisation_deducMt_social.AsCurrency;
utilisationCourante.Mt_Stocks:=TaUtilisation_deducMt_stocks.AsCurrency;
utilisationCourante.Reinteg_except:=TaUtilisation_deducReinteg_except.AsCurrency;
utilisationCourante.MontantUtilise:=utilisationCourante.Mt_immos+utilisationCourante.Mt_Social+utilisationCourante.Mt_Stocks;
end;
end.

