unit DMParamEnt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,DMEcriture,Gr_Librairie_Obj,LibZoneSaisie,E2_Main,E2_Decl_Records,LibSQL,
  E2_Librairie_Obj,DMRecherche,GR_MultDos,LibDates,E2_LibInfosTable,DMProgramme,LibRessourceString
  ,Lib_Chaine,DMDevises, DiversProjets,DMConstantes,
  DMCorrection,
  DMTTVA;

type
// TErreurDossier = record
//       CodeErreur:integer;
//       Retour:boolean;
//       end;

  TParamEntAcces = record
   CLEReadOnly:Boolean;
   NOM_DOSSReadOnly:Boolean;
   PLAN_AUXReadOnly:Boolean;
   DATE_DEB_EXOReadOnly:Boolean;
//   DATE_FIN_EXOReadOnly:Boolean;
   EXO_SAISIEReadOnly:Boolean;
   DATE_PREM_DECL_TVAReadOnly:Boolean;
   end;

  TDMParamEntreprise = class(TDataModule)
    taParamDoss: TTable;
    dbParam_Dos: TDataSource;
    TaParam_DosRecherche: TTable;
    taParamDossCLE: TStringField;
    taParamDossNOM_DOSS: TStringField;
    taParamDossAdr1: TStringField;
    taParamDossAdr2: TStringField;
    taParamDossCP: TStringField;
    taParamDossVILLE: TStringField;
    taParamDossREGIME_Agr: TStringField;
    taParamDossTYPE_SOC: TStringField;
    taParamDossTYPE_FISC: TStringField;
    taParamDossPERIODE_TVA: TStringField;
    taParamDossTVA_DEBIT: TStringField;
    taParamDossPLAN_AUX: TStringField;
    taParamDossPERIODE: TStringField;
    taParamDossTYPE_IMPOT: TStringField;
    taParamDossTYPE_DEC_FISC: TStringField;
    taParamDossDATE_DEB_EXO: TDateField;
    taParamDossDATE_FIN_EXO: TDateField;
    taParamDossEXO_SAISIE: TStringField;
    taParamDossEXO_BASE: TStringField;
    taParamDossDEVISE_EXO: TStringField;
    taParamDossDIV: TBlobField;
    taParamDossDATE_PREM_DECL_TVA: TDateTimeField;
    taParamDossDEROGATOIRE: TBooleanField;
    taParamDossDATE_PASSAGE_REEL: TDateTimeField;
    taParamDossAU_REEL: TBooleanField;
    taParamDossPARAM_DIV: TStringField;
    taParamDossUTILISATEUR: TStringField;
    TaParam_DosRechercheCLE: TStringField;
    TaParam_DosRechercheNOM_DOSS: TStringField;
    TaParam_DosRechercheAdr1: TStringField;
    TaParam_DosRechercheAdr2: TStringField;
    TaParam_DosRechercheCP: TStringField;
    TaParam_DosRechercheVILLE: TStringField;
    TaParam_DosRechercheREGIME_Agr: TStringField;
    TaParam_DosRechercheTYPE_SOC: TStringField;
    TaParam_DosRechercheTYPE_FISC: TStringField;
    TaParam_DosRecherchePERIODE_TVA: TStringField;
    TaParam_DosRechercheTVA_DEBIT: TStringField;
    TaParam_DosRecherchePLAN_AUX: TStringField;
    TaParam_DosRecherchePERIODE: TStringField;
    TaParam_DosRechercheTYPE_IMPOT: TStringField;
    TaParam_DosRechercheTYPE_DEC_FISC: TStringField;
    TaParam_DosRechercheDATE_DEB_EXO: TDateField;
    TaParam_DosRechercheDATE_FIN_EXO: TDateField;
    TaParam_DosRechercheEXO_SAISIE: TStringField;
    TaParam_DosRechercheEXO_BASE: TStringField;
    TaParam_DosRechercheDEVISE_EXO: TStringField;
    TaParam_DosRechercheDIV: TBlobField;
    TaParam_DosRechercheDATE_PREM_DECL_TVA: TDateTimeField;
    TaParam_DosRechercheDEROGATOIRE: TBooleanField;
    TaParam_DosRechercheDATE_PASSAGE_REEL: TDateTimeField;
    TaParam_DosRechercheAU_REEL: TBooleanField;
    TaParam_DosRecherchePARAM_DIV: TStringField;
    TaParam_DosRechercheUTILISATEUR: TStringField;
    TaParamDossMAJ: TTable;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    StringField8: TStringField;
    StringField9: TStringField;
    StringField10: TStringField;
    StringField11: TStringField;
    StringField12: TStringField;
    StringField13: TStringField;
    StringField14: TStringField;
    StringField15: TStringField;
    DateField1: TDateField;
    DateField2: TDateField;
    StringField16: TStringField;
    StringField17: TStringField;
    StringField18: TStringField;
    BlobField1: TBlobField;
    DateTimeField1: TDateTimeField;
    BooleanField1: TBooleanField;
    DateTimeField2: TDateTimeField;
    BooleanField2: TBooleanField;
    StringField19: TStringField;
    StringField20: TStringField;
    TaParam_DosRechercheCREATION: TStringField;
    TaParam_DosRechercheMODIFICATION: TStringField;
    TaParam_DosRechercheFORCE: TBooleanField;
    taParamDossCREATION: TStringField;
    taParamDossMODIFICATION: TStringField;
    taParamDossFORCE: TBooleanField;
    Ta_infosJuridique: TTable;
    DaInfosJuridique: TDataSource;
    procedure DMParamEntrepriseCreate(Sender: TObject);
    procedure DMParamEntrepriseDestroy(Sender: TObject);
    Function ControleDateExo(DateDeb,DateFin:TDate):TExceptLGR;
    Function CtrlSaisieDossier(CCourant:Tfield):TExceptLGR;
    procedure taParamDossAfterOpen(DataSet: TDataSet);
    procedure taParamDossBeforePost(DataSet: TDataSet);
    procedure taParamDossAfterPost(DataSet: TDataSet);
    procedure taParamDossBeforeEdit(DataSet: TDataSet);
    Function taParamDossierChampLectureSeule(DataSet:TDataSet;TypeVersion:TTypeDossier;NbEnregistrement:Integer):Boolean;
    procedure taParamDossBeforeOpen(DataSet: TDataSet);
    Procedure MiseAJourParamDossier_SurOuvertureExo(InfosBascule_Tmp:TInfosBascule);
    Function ModifParamEntAcces(ParamEntAcces:TParamEntAcces;TypeVersion:TTypeDossier):TParamEntAcces;
    Procedure MiseAJourParamDossier_SurClotureDefinitiveExercice(ExoBase:string);
    procedure taParamDossBeforeInsert(DataSet: TDataSet);
    procedure taParamDossAfterInsert(DataSet: TDataSet);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    DerogatoireAux:Boolean;
  end;

var
  DMParamEntreprise: TDMParamEntreprise;
  DatePremiereTva:Tdate;


  Function VerifMP:boolean;
  Function Decalage:Integer;
  function DossierTypeRegime:string;
  function DossierTypeEntreprise:string;
  function DossierIDDevise:Integer;
   function DossierDevise:string;
  Function DossierTypeDossier:TTypeDossier;
  Function PlanAuxT:Boolean;
  Function Derogatoire:Boolean;
  Function CalC(Dataset:TDataset):integer;
// PB le 18/02/04  Function PeriodiciteTVA:Integer;            
  Function Init_E_Entreprise_Avec_TaParamEntreprise:Boolean;
  function ParamEntrepriseRemplis:integer;
    Procedure ModifChampDerogatoire;

implementation

uses DMPiece;

{$R *.DFM}


Function Init_E_Entreprise_Avec_TaParamEntreprise:Boolean;
var
InfosParam_Dossier:TInfosParam_Dossier;
Begin
  result:=true;
  if DMRech = nil then DMRech:=TDMRech.Create(Application);
  if DMRech.TaParam_DossierRech.active=false then DMRech.TaParam_DossierRech.open;
  DMRech.TaParam_DossierRech.Refresh;
  DeFiltrageDataSet(DMRech.TaParam_DossierRech);
  Remplit_TInfosParam_Dossier(DMRech.TaParam_DossierRech,InfosParam_Dossier);
   if DMRech.TaParam_DossierRech.RecordCount = 1 then
    begin
       E.NomUtilisateur :=InfosParam_Dossier.UTILISATEUR;
      {Monnaie :String;}
      E.derogatoire:=InfosParam_Dossier.DEROGATOIRE;
      E.Regime :=InfosParam_Dossier.REGIME_Agr;
      E.ExerciceBase :=InfosParam_Dossier.EXO_BASE;
      E.ExerciceSaisie :=InfosParam_Dossier.EXO_SAISIE;
      E.Devise :=DossierIDDevise;
      if E.Devise < 1 then E.Devise := E.IDDevise_ParDefaut;
//      E.DeviseSigle:=DeviseSigle(E.Devise);
      E.DeviseSigle:=DossierDevise;
      E.FormatMonnaie:=',0.00 '+E.DeviseSigle+';-,0.00 '+E.DeviseSigle+';,0.00 '+E.DeviseSigle;
      E.EditFormat:='0.00 ;-0.00 ';
      E.ArrondiDebit:=DM_C_CompteArrondiDebit;
      E.ArrondiCredit :=DM_C_CompteArrondiCredit;
      E.ArrondiMontant :=DM_C_ArrondiMontant;
      E.ParamArrondisTVA:=DM_C_ParamArrondisTVA;
      E.DatExoDebut:=InfosParam_Dossier.DATE_DEB_EXO;
      E.DatExoFin :=InfosParam_Dossier.DATE_FIN_EXO;

      // Calcul de la périodicité de déclaration TVA exprimée en nb de mois 
      E.PeriodiciteTva:=0;
      if InfosParam_Dossier.PERIODE_TVA = 'M' then E.PeriodiciteTva:=1;
      if InfosParam_Dossier.PERIODE_TVA = 'T' then E.PeriodiciteTva:=3;
      if InfosParam_Dossier.PERIODE_TVA = 'A' then E.PeriodiciteTva:=12;

//      E.DatExoDemoDebut:=StrToDate('01/01/20'+E.ExerciceSaisie); ne pas prendre en compte ici
//      E.DateExoDemoFin:=StrToDate('31/12/20'+E.ExerciceSaisie);  ne pas prendre en compte ici
//
//      E.RepertoireProgram :=ExtractFilePath(Application.ExeName);ne pas prendre en compte ici
//      E.RepertoireDossier :=RepertoireProgram + 'Demo\';         ne pas prendre en compte ici
//      E.RepertoireExercice :=RepertoireProgram + 'Demo\ExoDemo\';ne pas prendre en compte ici
//      E.RepertoireImportEPI_DOS := RepertoireProgram + 'Importation\';ne pas prendre en compte ici
//      E.NomExo:='ExoDemo';ne pas prendre en compte ici
//      E.NomDossier:='Demo';ne pas prendre en compte ici
      E.TypeEntreprise:=InfosParam_Dossier.TYPE_SOC;
      if not empty(InfosParam_Dossier.UTILISATEUR) then
      E.User:=InfosParam_Dossier.UTILISATEUR;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//      E.DateDebutDeclarationTVA:= a calculer en fonctiondes déclaration effectué ou non  !!!!!!!!
//      E.DateFinDeclarationTVA:=a calculer en fonctiondes déclaration effectué ou non     !!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      E.PremiereDateDeclaration:=InfosParam_Dossier.DATE_PREM_DECL_TVA; // date à partir de laquelle on prend en compte la TVA !!!
      if DMTmTVA = nil then DMTmTVA:=TDMTmTVA.Create(Application.MainForm);
      DMTmTVA.MAJ_DateDeclarationTVA(E.DateDebutDeclarationTVA,E.DateFinDeclarationTVA);
      E.RaisonSociale:=InfosParam_Dossier.NOM_DOSS;
      //Infos_TInfosParam_Dossier(dmrech.TaParam_DossierRech,'Cle',[1]).NOM_DOSS;

//
//      E.ID_Dos:=0;ne pas prendre en compte ici
//      E.ID_Exo:=0;ne pas prendre en compte ici
      E.PlanAuxT:=PlanAuxT;

//      if E.TypeVersionToInt(E.TypeDossier) = InfosParam_Dossier.DIVParam_Dossier
      //,VerDemoGeneral,VerDemoAgri
      //VerInconnu

//      if ((E.TypeDossier in [VerInconnu]) and (DMRech.TaParam_DossierRech.Database.Directory <> E.RepertoireProgram+'\Demo\'))then
      E.TypeDossier:=DossierTypeDossier
//      E.TypeDossierdemo:=VerDemoAgri;ne pas prendre en compte ici
//      E.ExerciceCloture:=;ne pas prendre en compte ici

    end
    else
    begin
     E.TypeDossier := VerInconnu;
     result:=False;
    end;

End;

function DossierTypeRegime:string;
Begin
  result:='';
  if DMRech = nil then DMRech:=DMRech.Create(Application);
  if not DMRech.TaParam_DossierRech.active then
  DMRech.TaParam_DossierRech.Open;
  DMRech.TaParam_DossierRech.Refresh;
   if DMRech.TaParam_DossierRech.RecordCount = 1 then
      result:=UpperCase(DMRech.TaParam_DossierRech.findfield('REGIME_Agr').AsString);
End;

function DossierTypeEntreprise:string;
Begin
  result:='';
  if DMRech = nil then DMRech:=DMRech.Create(Application);
  if not DMRech.TaParam_DossierRech.active then
  DMRech.TaParam_DossierRech.Open;
  DMRech.TaParam_DossierRech.Refresh;
   if DMRech.TaParam_DossierRech.RecordCount = 1 then
      result:=UpperCase(DMRech.TaParam_DossierRech.findfield('Type_Soc').AsString);
End;

function DossierIDDevise:Integer;
Begin
  result:=0;
  if DMRech = nil then DMRech:=DMRech.Create(Application);
  if not DMRech.TaParam_DossierRech.active then
  DMRech.TaParam_DossierRech.Open;
  DMRech.TaParam_DossierRech.Refresh;
   if DMRech.TaParam_DossierRech.RecordCount = 1 then
     if VerifFNumeric(DMRech.TaParam_DossierRech.findfield('DEVISE_EXO')).Vide then
      result:=-1
     else
      result:=DMRech.TaParam_DossierRech.findfield('DEVISE_EXO').AsInteger;
End;

function DossierDevise:string;
Begin
  result:=currencyStringEpicea;
  if DMParamEntreprise = nil then DMParamEntreprise:=DMParamEntreprise.Create(Application);
  if not DMParamEntreprise.Ta_infosJuridique.active then
  DMParamEntreprise.Ta_infosJuridique.Open;
  DMParamEntreprise.Ta_infosJuridique.Refresh;
   if DMParamEntreprise.Ta_infosJuridique.RecordCount = 1 then
     if DMParamEntreprise.Ta_infosJuridique.findfield('DEVISE').asstring='' then
      result:=currencyStringEpicea
     else
      result:=DMParamEntreprise.Ta_infosJuridique.findfield('DEVISE').AsString ;
End;

Function DossierTypeDossier:TTypeDossier;
Begin
result:=VerInconnu;
//VerAgriClot,VerGeneClot,VerDiocClot
if DMRech = nil then DMRech:=DMRech.Create(Application);
if not DMRech.TaParam_DossierRech.Active then
DMRech.TaParam_DossierRech.Open;
DMRech.TaParam_DossierRech.Refresh;
if DMRech.TaGestDossier_OK.Active then DMRech.TaGestDossier_OK.Close;

FiltrageDataSet(DMRech.TaGestDossier_OK,CreeFiltreET(['Nom_Dossier','Nom_Exo'],[E.NomDossier,E.NomExo]));
DMRech.TaGestDossier_OK.Open;
if DMRech.TaParam_DossierRech.findfield('Regime_Agr').AsString = 'A' then
 begin
   if DMRech.TaGestDossier_OK.findfield('Cloture').AsBoolean then result:=VerAgriClot
   else
    begin
//    if ((DMRech.TaGestDossier_OK.findfield('EXO_SAISIE').AsString = DMRech.TaParam_DossierRech.findfield('EXO_SAISIE').AsString)
//       and (DMRech.TaGestDossier_OK.findfield('EXO_BASE').AsString = DMRech.TaParam_DossierRech.findfield('EXO_BASE').AsString))
//      then
      result:=VerAgricole;
    end;
   if (DMRech.TaParam_DossierRech.Database.Directory = E.RepertoireProgram+'Demo\') then
    result:=VerDemoAgri;

 end;

if DMRech.TaParam_DossierRech.findfield('Regime_Agr').AsString = 'I' then
 begin
   if DMRech.TaGestDossier_OK.findfield('Cloture').AsBoolean then result:=VerGeneClot
   else
    begin
//    if ((DMRech.TaGestDossier_OK.findfield('EXO_SAISIE').AsString = DMRech.TaParam_DossierRech.findfield('EXO_SAISIE').AsString)
//       and (DMRech.TaGestDossier_OK.findfield('EXO_BASE').AsString = DMRech.TaParam_DossierRech.findfield('EXO_BASE').AsString))
//      then
       result:=VerGeneral;
    end;
   if (DMRech.TaParam_DossierRech.Database.Directory = E.RepertoireProgram+'Demo\') then
    result:=VerDemoGeneral;
 end;

if DMRech.TaParam_DossierRech.findfield('Regime_Agr').AsString = 'D' then
 begin
   if DMRech.TaGestDossier_OK.findfield('Cloture').AsBoolean then result:=VerDiocClot
   else
    begin
//    if ((DMRech.TaGestDossier_OK.findfield('EXO_SAISIE').AsString = DMRech.TaParam_DossierRech.findfield('EXO_SAISIE').AsString)
//       and (DMRech.TaGestDossier_OK.findfield('EXO_BASE').AsString = DMRech.TaParam_DossierRech.findfield('EXO_BASE').AsString))
//      then
       result:=VerDiocese;
    end;
   if (DMRech.TaParam_DossierRech.Database.Directory = E.RepertoireProgram+'DemoDioc\') then
    result:=VerDemoDioc;
 end;
End;

Function PlanAuxT:Boolean;
Begin
  if DMRech = nil then DMRech:=TDMRech.Create(Application);
  result:=False;
  if not DMRech.TaParam_DossierRech.active then
          DMRech.TaParam_DossierRech.Open;
  DMRech.TaParam_DossierRech.Refresh;
   if DMRech.TaParam_DossierRech.RecordCount = 1 then
      result:=UpperCase(DMRech.TaParam_DossierRech.findfield('PLAN_AUX').AsString)='T';
End;

Function Derogatoire:Boolean;
Begin
  if DMRech = nil then DMRech:=TDMRech.Create(Application);
  result:=False;
  if not DMRech.TaParam_DossierRech.active then
          DMRech.TaParam_DossierRech.Open;
  DMRech.TaParam_DossierRech.Refresh;
   if DMRech.TaParam_DossierRech.RecordCount = 1 then
      result:=DMRech.TaParam_DossierRech.findfield('DEROGATOIRE').AsBoolean;
End;

Function CalC(Dataset:TDataset):integer;
var
aux,l,i:integer;
AuxS,Aux2S:string;
begin
Aux2S:='';
if DataSet <> nil then
 begin
  try
   if not DataSet.Active then DataSet.Open;
   AuxS:=DAtaSet.FindField('NOM_DOSS').AsString;
   l:=length(AuxS);
   for i:=1 to l do
     begin
      Aux2S:=Aux2S+inttostr(ord((AuxS[i])));
//      showmessage(inttostr(ord((AuxS[i]))));
     end;
     result:=StrToInt(Aux2S);
//   while StrToInt(Aux2S) >
  except
  end;
 end;
end;


Function VerifMP:boolean;
var
NBE:Integer;
Begin
result:=false;
if DMParamEntreprise = nil then DMParamEntreprise:=TDMParamEntreprise.Create(application.MainForm);
if not DMParamEntreprise.taParamDoss.active then
        DMParamEntreprise.taParamDoss.Open;
 if DMParamEntreprise.taParamDoss.RecordCount = 0 then
    result:=false;
 result:=(DMParamEntreprise.taParamDoss.RecordCount = 1);
 if result=false then
 begin
   NBE:=((200 div 4)*2)+(((75 div 3)*4)div 2);
   result:=NBE>=DMEcriture.NBE;
 end
  else
 begin

 end;
End;

Function Decalage:Integer;
begin
result:=6*4;
end;

procedure TDMParamEntreprise.DMParamEntrepriseCreate(Sender: TObject);
begin
if DMRech = nil then DMRech:=TDMRech.Create(application.MainForm);
OuvrirTouteTable('',TControl(self));
end;

procedure TDMParamEntreprise.DMParamEntrepriseDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
DMParamEntreprise := nil;
end;

// PB le 18/02/04
//Function PeriodiciteTVA:Integer;
//Begin
//  result:=0;
//  if DMParamEntreprise = nil then DMParamEntreprise:=TDMParamEntreprise.create(Application);
//  if not DMParamEntreprise.TaParamDoss.Active then DMParamEntreprise.taParamDoss.Active:=true;
//  if DMParamEntreprise.TaParamDoss.findfield('PERIODE_TVA').AsString = 'M' then Result:=1;
//  if DMParamEntreprise.TaParamDoss.findfield('PERIODE_TVA').AsString = 'T' then Result:=3;
//  if DMParamEntreprise.TaParamDoss.findfield('PERIODE_TVA').AsString = 'A' then Result:=12;
//End;

Function TDMParamEntreprise.ControleDateExo(DateDeb,DateFin:TDate):TExceptLGR;
Begin
if not DateInfos(DateDeb).Valide then
 Begin
   Result.NumErreur:=15000;
   Result.Retour:=False;
 End
else
 Begin
   if not DateInfos(DateFin).Valide then
    Begin
      Result.NumErreur:=16000;
      Result.Retour:=False;
    End
    else
    begin
      case CompareDate(DateDeb,DateFin) of
         -1:Begin
             Result.NumErreur:=16001;
             Result.Retour:=False;
             showmessage('Attention, la date de début d''exercice doit être antérieure à la date de fin d''exercice')
            End;

         0:Begin
             Result.NumErreur:=16002;
             Result.Retour:=False;
             showmessage('Attention, la date de début d''exercice doit être antérieure à la date de fin d''exercice')
            End;

         1:Begin
            if NbMois(DateDeb,DateFin) <> 12 then
             begin
               Result.NumErreur:=16003;
               Result.Retour:=true;
               ShowMEssage('Attention, la durée de votre exercice est de : ' +IntToStr(NbMois(DateDeb,DateFin))+' mois !');
             end;
            End;
      end;

    end;
 End;

//
End;

Function TDMParamEntreprise.CtrlSaisieDossier(CCourant:Tfield):TExceptLGR;
var
Reference:String;
Begin
// Auto Généré !!!!!!!!!!!!!!!!!!!!
//*********************************************************************************
Try
  Result.NumErreur:=0;
  Result.Retour:=True;
  GestMessageLGR.FichierMessage := 'ErrSaisieDos.txt';
Initialise_ExceptLGR(result,GestMessageLGR);
//  Result.GestMessageLGR := GestMessageLGR;
  Case CCourant.DataSet.State of
    dsInsert:Begin
              case CCourant.Index of
                 // Traitement CLE
                 //*************************************************************************
                 0:Begin
                    if Empty(CCourant.AsString) then
                       raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),False,mtError,result);
                   End;
                 // Traitement NOM_DOSS
                 //*************************************************************************
                 1:Begin
                    if Empty(CCourant.AsString) then
                       raise ExceptLGR.Create('Veuillez saisir le nom de votre entreprise'+
                                               RetourChariotDouble+
                                              'Ce nom sera utilisé dans vos éditions !',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement Adr1
                 //*************************************************************************
                 2:Begin
//                    if Empty(CCourant.AsString) then
//                       raise ExceptLGR.Create('Veuillez saisir l''adresse de votre entreprise'+
//                                               RetourChariotDouble+
//                                              'Cette adresse sera utilisée dans vos éditions !',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement Adr2
                 //*************************************************************************
                 3:Begin
//                    if Empty(CCourant.AsString) then
//                       raise ExceptLGR.Create('Veuillez saisir l''adresse de votre entreprise'+
//                                               RetourChariotDouble+
//                                              'Cette adresse sera utilisée dans vos éditions !',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement CP
                 //*************************************************************************
                 4:Begin
                   if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('Veuillez saisir le code postal de votre entreprise'+
                                            RetourChariotDouble+
                                            'Il sera utilisé dans vos éditions !',StrToInt(IntToStr(CCourant.Index)+'000'),True,mtError,result);

                   if length(CCourant.AsString) <> 5 then
                     raise ExceptLGR.Create('Le code postal doit contenir 5 chiffres !',StrToInt(IntToStr(CCourant.Index)+'001'),True,mtError,result);

                   // Verifie si le champ Code Postal ne contient que des chiffres
                   if not str_N_Car_IsNumeric(CCourant.AsString,5,length(CCourant.AsString)) then
                     raise ExceptLGR.Create('Le code postal ne doit contenir que des chiffres !',StrToInt(IntToStr(CCourant.Index)+'002'),True,mtError,result);
                   End;
                 // Traitement VILLE
                 //*************************************************************************
                 5:Begin
                   if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('Veuillez saisir la ville de votre entreprise'+
                                            RetourChariotDouble+
                                            'Elle sera utilisé dans vos éditions !',StrToInt(IntToStr(CCourant.Index)+'000'),True,mtError,result);
                   End;
                 // Traitement REGIME_Agr
                 //*************************************************************************
                 6:Begin
                   if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('Veuillez indiquer le régime de votre entreprise'+
                                            RetourChariotDouble+
                                            'Ce champ est obligatoire pour déterminer sur quel plan comptable vous allez travailler !',StrToInt(IntToStr(CCourant.Index)+'000'),True,mtError,result);

                   if not (CCourant.AsString[1] in ['I','A']) then
                     raise ExceptLGR.Create('Les lettres valide pour déterminer le régime de votre entreprise sont : '+
                                            RetourChariotDouble+
                                            'A : régime Agricole'+
                                            RetourChariotDouble+
                                            'I : régime Industriel',StrToInt(IntToStr(CCourant.Index)+'001'),True,mtError,result);
                   End;
                 // Traitement TYPE_SOC
                 //*************************************************************************
                 7:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement TYPE_FISC
                 //*************************************************************************
                 8:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement PERIODE_TVA
                 //*************************************************************************
                 9:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement TVA_DEBIT
                 //*************************************************************************
                 10:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement PLAN_AUX
                 //*************************************************************************
                 11:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement PERIODE
                 //*************************************************************************
                 12:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement TYPE_IMPOT
                 //*************************************************************************
                 13:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement TYPE_DEC_FISC
                 //*************************************************************************
                 14:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement DATE_DEB_EXO
                 //*************************************************************************
                 15:Begin
                    if Empty(CCourant.AsString) then
                       raise ExceptLGR.Create('La date de début d''exercice n''est pas valide',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result)
                    else
                       result:=ControleDateExo(CCourant.AsDateTime,CCourant.DataSet.findField('Date_FIN_EXO').AsDateTime);
                       if result.retour=false then  raise ExceptLGR.Create('');
                    if ((DatePremiereTva=0)or(DatePremiereTva=CCourant.AsDateTime)or(CCourant.DataSet.FindField('DATE_PREM_DECL_TVA').AsDateTime=0)) then
                       begin
                         CCourant.DataSet.FindField('DATE_PREM_DECL_TVA').AsDateTime:=DatePremiereTva;
                       end;
                   End;
                 // Traitement DATE_FIN_EXO
                 //*************************************************************************
                 16:Begin
                    if Empty(CCourant.AsString) then
                       raise ExceptLGR.Create('La date de fin d''exercice n''est pas valide',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result)
                    else
                       result:=ControleDateExo(CCourant.DataSet.findField('DATE_DEB_EXO').AsDateTime,CCourant.AsDateTime);
                        if result.retour=false then  raise ExceptLGR.Create('');
                   End;
                 // Traitement EXO_SAISIE
                 //*************************************************************************
                 17:Begin
                   if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('Veuillez saisir le code pour le premier exercice de saisie '+
                                            RetourChariotDouble+
                                            'Il sera utilisé dans les références des pièces.',StrToInt(IntToStr(CCourant.Index)+'000'),True,mtError,result);

                   if length(CCourant.AsString) <> 2 then
                     raise ExceptLGR.Create('Le code pour le premier exercice de saisie doit contenir 2 chiffres !',StrToInt(IntToStr(CCourant.Index)+'001'),True,mtError,result);

                   // Verifie si le champ Code Postal ne contient que des chiffres
                   if not str_N_Car_IsNumeric(CCourant.AsString,2,length(CCourant.AsString)) then
                     raise ExceptLGR.Create('Le code pour le premier exercice de saisie ne doit contenir que des chiffres !',StrToInt(IntToStr(CCourant.Index)+'002'),True,mtError,result);
                   End;
                 // Traitement EXO_BASE
                 //*************************************************************************
                 18:Begin
                    if Empty(CCourant.AsString) then
                       raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),false,mtError,result);
                   End;
                 // Traitement DEVISE_EXO
                 //*************************************************************************
                 19:Begin
                    if VerifFNumeric(CCourant).VideOUZero then
                        CCourant.AsInteger:=E.IDDevise_ParDefaut;
                    if VerifFNumeric(CCourant).VideOUZero then
                       raise ExceptLGR.Create('Erreur à la récupération de E.IDDevise_ParDefaut',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement DIV
                 //*************************************************************************
                 20:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement DATE_PREM_DECL_TVA
                 //*************************************************************************
                 21:Begin
                     if not DateInfos(CCourant.AsDateTime).Valide then
                        raise ExceptLGR.Create('Veuillez saisir une date valide de début de période pour votre prochaine déclaration TVA !',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                     if (DatePremiereTva<>CCourant.AsDateTime)then
                        DatePremiereTva:=CCourant.AsDateTime;
                   End;
                 // Traitement DEROGATOIRE
                 //*************************************************************************
                 22:Begin

                    End;
                 // Traitement DATE_PASSAGE_REEL
                 //*************************************************************************
                 23:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement AU_REEL
                 //*************************************************************************
                 24:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement PARAM_DIV
                 //*************************************************************************
                 25:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement UTILISATEUR
                 //*************************************************************************
                 26:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
              End; // Fin du case
             End; // Fin Begin du dsInsert
  // Zone Edition
    dsEdit:Begin
              case CCourant.Index of
                 // Traitement CLE
                 //*************************************************************************
                 0:Begin
                    if Empty(CCourant.AsString) then
                       raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),False,mtError,result);
                   End;
                 // Traitement NOM_DOSS
                 //*************************************************************************
                 1:Begin
                    if Empty(CCourant.AsString) then
                       raise ExceptLGR.Create('Veuillez saisir le nom de votre entreprise'+
                                               RetourChariotDouble+
                                              'Ce nom sera utilisé dans vos éditions !',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement Adr1
                 //*************************************************************************
                 2:Begin
//                    if Empty(CCourant.AsString) then
//                       raise ExceptLGR.Create('Veuillez saisir l''adresse de votre entreprise'+
//                                               RetourChariotDouble+
//                                              'Cette adresse sera utilisée dans vos éditions !',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement Adr2
                 //*************************************************************************
                 3:Begin
//                    if Empty(CCourant.AsString) then
//                       raise ExceptLGR.Create('Veuillez saisir l''adresse de votre entreprise'+
//                                               RetourChariotDouble+
//                                              'Cette adresse sera utilisée dans vos éditions !',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement CP
                 //*************************************************************************
                 4:Begin
                   if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('Veuillez saisir le code postal de votre entreprise'+
                                            RetourChariotDouble+
                                            'Il sera utilisé dans vos éditions !',StrToInt(IntToStr(CCourant.Index)+'000'),True,mtError,result);

                   if length(CCourant.AsString) <> 5 then
                     raise ExceptLGR.Create('Le code postal doit contenir 5 chiffres !',StrToInt(IntToStr(CCourant.Index)+'001'),True,mtError,result);

                   // Verifie si le champ Code Postal ne contient que des chiffres
                   if not str_N_Car_IsNumeric(CCourant.AsString,5,length(CCourant.AsString)) then
                     raise ExceptLGR.Create('Le code postal ne doit contenir que des chiffres !',StrToInt(IntToStr(CCourant.Index)+'002'),True,mtError,result);
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement VILLE
                 //*************************************************************************
                 5:Begin
                   if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('Veuillez saisir la ville de votre entreprise'+
                                            RetourChariotDouble+
                                            'Elle sera utilisé dans vos éditions !',StrToInt(IntToStr(CCourant.Index)+'000'),True,mtError,result);
                   End;
                 // Traitement REGIME_Agr
                 //*************************************************************************
                 6:Begin
                   if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('Veuillez indiquer le régime de votre entreprise'+
                                            RetourChariotDouble+
                                            'Ce champ est obligatoire pour déterminer sur quel plan comptable vous allez travailler !',StrToInt(IntToStr(CCourant.Index)+'000'),True,mtError,result);

                   if not (CCourant.AsString[1] in ['I','A']) then
                     raise ExceptLGR.Create('Les lettres valide pour déterminer le régime de votre entreprise sont : '+
                                            RetourChariotDouble+
                                            'A : régime Agricole'+
                                            RetourChariotDouble+
                                            'I : régime Industriel',StrToInt(IntToStr(CCourant.Index)+'001'),True,mtError,result);
                   End;
                 // Traitement TYPE_SOC
                 //*************************************************************************
                 7:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement TYPE_FISC
                 //*************************************************************************
                 8:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement PERIODE_TVA
                 //*************************************************************************
                 9:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement TVA_DEBIT
                 //*************************************************************************
                 10:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement PLAN_AUX
                 //*************************************************************************
                 11:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement PERIODE
                 //*************************************************************************
                 12:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement TYPE_IMPOT
                 //*************************************************************************
                 13:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement TYPE_DEC_FISC
                 //*************************************************************************
                 14:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement DATE_DEB_EXO
                 //*************************************************************************
                 15:Begin
                    if Empty(CCourant.AsString) then
                       raise ExceptLGR.Create('La date de début d''exercice n''est pas valide',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result)
                    else
                       result:=ControleDateExo(CCourant.AsDateTime,CCourant.DataSet.findField('Date_FIN_EXO').AsDateTime);
                          if result.retour=false then  raise ExceptLGR.Create('');
                   End;
                 // Traitement DATE_FIN_EXO
                 //*************************************************************************
                 16:Begin
                    if Empty(CCourant.AsString) then
                       raise ExceptLGR.Create('La date de fin d''exercice n''est pas valide',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result)
                    else
                       result:= ControleDateExo(CCourant.DataSet.findField('DATE_DEB_EXO').AsDateTime,CCourant.AsDateTime);
                          if result.retour=false then  raise ExceptLGR.Create('');
                   End;
                 // Traitement EXO_SAISIE
                 //*************************************************************************
                 17:Begin
                   if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('Veuillez saisir le code pour le premier exercice de saisie '+
                                            RetourChariotDouble+
                                            'Il sera utilisé dans les références des pièces.',StrToInt(IntToStr(CCourant.Index)+'000'),True,mtError,result);

                   if length(CCourant.AsString) <> 2 then
                     raise ExceptLGR.Create('Le code pour le premier exercice de saisie doit contenir 2 chiffres !',StrToInt(IntToStr(CCourant.Index)+'001'),True,mtError,result);

                   // Verifie si le champ Code Postal ne contient que des chiffres
                   if not str_N_Car_IsNumeric(CCourant.AsString,2,length(CCourant.AsString)) then
                     raise ExceptLGR.Create('Le code pour le premier exercice de saisie ne doit contenir que des chiffres !',StrToInt(IntToStr(CCourant.Index)+'002'),True,mtError,result);
                   End;
                 // Traitement EXO_BASE
                 //*************************************************************************
                 18:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement DEVISE_EXO
                 //*************************************************************************
                 19:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement DIV
                 //*************************************************************************
                 20:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement DATE_PREM_DECL_TVA
                 //*************************************************************************
                 21:Begin
                    if Empty(CCourant.AsString) then
                       raise ExceptLGR.Create('Vous devez indiquer la date de début de prise en compte de TVA',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement DEROGATOIRE
                 //*************************************************************************
                 22:Begin
                      if DerogatoireAux <> CCourant.AsBoolean then
                       if VerificationSiPieceDeDotation(reference) then
                         raise ExceptLGR.Create('Vous devez supprimer votre pièce de dotation aux amortissement pour modifier ce paramètre ! ',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement DATE_PASSAGE_REEL
                 //*************************************************************************
                 23:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement AU_REEL
                 //*************************************************************************
                 24:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement PARAM_DIV
                 //*************************************************************************
                 25:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
                 // Traitement UTILISATEUR
                 //*************************************************************************
                 26:Begin
  //                  if Empty(CCourant.AsString) then
  //                     raise ExceptLGR.Create('Mess',StrToInt(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                   End;
              End; // Fin du case
             End; // Fin Begin du dsEdit
  End; // Fin du Case

  Except
    raise ExceptLGR.Create('');
  End;

////**********************************************************************
////Function TDM_ModelDM.CtrlSaisieDM_ModelDM(CCourant:Tfield):TExceptLGR;
////Begin
// case CCourant.DataSet.State of
//   dsInsert:Begin
//             case CCourant.Index of
//                // Traitement Clé
//                //*************************************************************************
//                0:Begin
//                   if Empty(CCourant.AsString) then
//                     raise ExceptLGR.Create('Message!',0,False,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement NomDoss
//                //*************************************************************************
//                1:Begin
//                   if Empty(CCourant.AsString) then
//                     raise ExceptLGR.Create('Veuillez saisir le nom de votre entreprise'+
//                                            RetourChariotDouble+
//                                            'Ce nom sera utilisé dans vos éditions !',1000,True,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement Adr1
//                //*************************************************************************
//                2:Begin
//                   if Empty(CCourant.AsString) then
//                     raise ExceptLGR.Create('Veuillez saisir l''adresse de votre entreprise'+
//                                            RetourChariotDouble+
//                                            'Cette adresse sera utilisée dans vos éditions !',2000,True,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement Adr2
//                //*************************************************************************
//                3:Begin
//                   if Empty(CCourant.AsString) then
//                     raise ExceptLGR.Create('Veuillez saisir l''adresse de votre entreprise'+
//                                            RetourChariotDouble+
//                                            'Cette adresse sera utilisée dans vos éditions !',3000,False,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement Code Postal
//                //*************************************************************************
//                4:Begin
//                   if Empty(CCourant.AsString) then
//                     raise ExceptLGR.Create('Veuillez saisir le code postal de votre entreprise'+
//                                            RetourChariotDouble+
//                                            'Il sera utilisé dans vos éditions !',4000,True,mtError,result);
//
//                   if length(CCourant.AsString) <> 5 then
//                     raise ExceptLGR.Create('Le code postal doit contenir 5 chiffres !',4001,True,mtError,result);
//
//                   // Verifie si le champ Code Postal ne contient que des chiffres
//                   if str_N_Car_IsNumeric(CCourant.AsString,5,length(CCourant.AsString)) then
//                     raise ExceptLGR.Create('Le code postal ne doit contenir que des chiffres !',4002,True,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement Ville
//                //*************************************************************************
//                5:Begin
//                   if Empty(CCourant.AsString) then
//                     raise ExceptLGR.Create('Veuillez saisir la ville de votre entreprise'+
//                                            RetourChariotDouble+
//                                            'Elle sera utilisé dans vos éditions !',5000,True,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement Regime_Agr
//                //*************************************************************************
//                6:Begin
//                   if Empty(CCourant.AsString) then
//                     raise ExceptLGR.Create('Veuillez indiquer le régime de votre entreprise'+
//                                            RetourChariotDouble+
//                                            'Ce champ est obligatoire pour déterminer sur quel plan comptable vous allez travailler !',6000,True,mtError,result);
//
//                   if not (CCourant.AsString[1] in ['I','A']) then
//                     raise ExceptLGR.Create('Les lettres valide pour déterminer le régime de votre entreprise sont : '+
//                                            RetourChariotDouble+
//                                            'A : régime Agricole'+
//                                            RetourChariotDouble+
//                                            'I : régime Industriel',6001,True,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement TYPE_SOC
//                //*************************************************************************
//                7:Begin
////                  if CONDITION then
////                     raise ExceptLGR.Create(''Message!'',NUM_ERREUR,true,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement TYPE_FISC
//                //*************************************************************************
//                8:Begin
////                  if CONDITION then
////                     raise ExceptLGR.Create(''Message!'',NUM_ERREUR,true,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement PERIODE_TVA
//                //*************************************************************************
//                9:Begin
////                  if CONDITION then
////                     raise ExceptLGR.Create(''Message!'',NUM_ERREUR,true,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement TVA_DEBIT
//                //*************************************************************************
//                10:Begin
////                  if CONDITION then
////                     raise ExceptLGR.Create(''Message!'',NUM_ERREUR,true,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement PLAN_AUX
//                //*************************************************************************
//                11:Begin
////                  if CONDITION then
////                     raise ExceptLGR.Create(''Message!'',NUM_ERREUR,true,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement PERIODE
//                //*************************************************************************
//                12:Begin
////                  if CONDITION then
////                     raise ExceptLGR.Create(''Message!'',NUM_ERREUR,true,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement TYPE_IMPOT
//                //*************************************************************************
//                13:Begin
////                  if CONDITION then
////                     raise ExceptLGR.Create(''Message!'',NUM_ERREUR,true,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement TYPE_DEC_FISC
//                //*************************************************************************
//                14:Begin
////                  if CONDITION then
////                     raise ExceptLGR.Create(''Message!'',NUM_ERREUR,true,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement DATE_DEB_EXO
//                //*************************************************************************
//                15:Begin
////ControleDateExo(CCourant.AsDateTime,CCourant.DataSet.findField('Date_FIN_EXO').AsDateTime);
////                  if CONDITION then
////                     raise ExceptLGR.Create(''Message!'',NUM_ERREUR,true,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement DATE_FIN_EXO
//                //*************************************************************************
//                16:Begin
////                  if CONDITION then
////                     raise ExceptLGR.Create(''Message!'',NUM_ERREUR,true,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement EXO_SAISIE
//                //*************************************************************************
//                17:Begin
////                  if CONDITION then
////                     raise ExceptLGR.Create(''Message!'',NUM_ERREUR,true,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement EXO_BASE
//                //*************************************************************************
//                18:Begin
////                  if CONDITION then
////                     raise ExceptLGR.Create(''Message!'',NUM_ERREUR,true,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement DEVISE_EXO
//                //*************************************************************************
//                19:Begin
////                  if CONDITION then
////                     raise ExceptLGR.Create(''Message!'',NUM_ERREUR,true,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement DIV
//                //*************************************************************************
//                20:Begin
////                  if CONDITION then
////                     raise ExceptLGR.Create(''Message!'',NUM_ERREUR,true,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement DATE_PREM_DECL_TVA
//                //*************************************************************************
//                21:Begin
////                  if CONDITION then
////                     raise ExceptLGR.Create(''Message!'',NUM_ERREUR,true,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement DEROGATOIRE
//                //*************************************************************************
//                22:Begin
////                  if CONDITION then
////                     raise ExceptLGR.Create(''Message!'',NUM_ERREUR,true,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement DATE_PASSAGE_REEL
//                //*************************************************************************
//                23:Begin
////                  if CONDITION then
////                     raise ExceptLGR.Create(''Message!'',NUM_ERREUR,true,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement AU_REEL
//                //*************************************************************************
//                24:Begin
////                  if CONDITION then
////                     raise ExceptLGR.Create(''Message!'',NUM_ERREUR,true,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement PARAM_DIV
//                //*************************************************************************
//                25:Begin
////                  if CONDITION then
////                     raise ExceptLGR.Create(''Message!'',NUM_ERREUR,true,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement UTILISATEUR
//                //*************************************************************************
//                26:Begin
////                  if CONDITION then
////                     raise ExceptLGR.Create(''Message!'',NUM_ERREUR,true,mtError,result);
//                  End;
//                //*************************************************************************
//
//             End;
//            End;
//   dsEdit:Begin
//             case CCourant.Index of
//                // Traitement NomDuChamp
//                //*************************************************************************
//                1:Begin
////                  if CONDITION then
////                     raise ExceptLGR.Create(''Message!'',NUM_ERREUR,true,mtError,result);
//                  End;
//                //*************************************************************************
//
//                // Traitement NomDuChamp
//                //*************************************************************************
//                2:Begin
////                  if CONDITION then
////                     raise ExceptLGR.Create(''Message!'',NUM_ERREUR,true,mtError,result);
//                  End;
//                //*************************************************************************
//             End;
//          End;
// End;
//End;

{Result.CodeErreur:=0;
Result.Retour:=true;
case CCourant.DataSet.State of
   dsInsert:Begin
             case CCourant.Index of
                0:Begin  // Clé
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=1001;
                      Result.Retour:=False;
                    End;
                  End;
                1:Begin // Nom Doss
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=1000;
                      Result.Retour:=False;
                    End;
                  End;
                2:Begin //Adr1
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=2000;
                      Result.Retour:=False;
                    End;
                  End;
                3:Begin //Adr2
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=3000;
                      Result.Retour:=False;
                    End;
                  End;
                4:Begin  //Code Postal
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=4000;
                      Result.Retour:=False;
                    End;
                  End;
                5:Begin // Ville
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=5000;
                      Result.Retour:=False;
                    End;
                  End;
                6:Begin // Regime_Agr
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=6000;
                      Result.Retour:=False;
                    End;
                  End;
                7:Begin // Type_Soc
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=7000;
                      Result.Retour:=False;
                    End;
                  End;
                8:Begin // Type_Fisc
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=8000;
                      Result.Retour:=False;
                    End;
                  End;
                9:Begin // Periode_TVA
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=9000;
                      Result.Retour:=False;
                    End;
                  End;
                10:Begin // Tva_Debit
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=10000;
                      Result.Retour:=False;
                    End;
                  End;
                11:Begin //Plan_Aux
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=11000;
                      Result.Retour:=False;
                    End;
                  End;
                12:Begin // Periode
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=12000;
                      Result.Retour:=False;
                    End;
                  End;
                13:Begin // Type_Impot
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=13000;
                      Result.Retour:=False;
                    End;
                  End;
                14:Begin //Typ_Dec_Fisc
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=14000;
                      Result.Retour:=False;
                    End;
                  End;
                15:Begin // Date_Deb_Exo
                    Result:=ControleDateExo(CCourant.AsDateTime,CCourant.DataSet.findField('Date_FIN_EXO').AsDateTime);
                  End;
                16:Begin // Date_Fin_Exo
                    Result:=ControleDateExo(CCourant.DataSet.findField('Date_DEB_EXO').AsDateTime,CCourant.AsDateTime);
                  End;
                17:Begin // Exo_Saisie
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=17000;
                      Result.Retour:=False;
                    End;
                  End;
                18:Begin // Exo_Base
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=18000;
                      Result.Retour:=False;
                    End;
                  End;
                19:Begin // Devise_Exo
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=19000;
                      Result.Retour:=False;
                    End;
                  End;
             end;
            End;
   dsEdit:Begin
             case CCourant.Index of
                0:Begin  // Clé
                   if VerifFNumeric(CCourant).VideOUZero then
                    Begin
                      Result.CodeErreur:=1001;
                      Result.Retour:=False;
                    End
                    else
                    if CCourant.AsInteger = 1 then
                    Begin
                      Result.CodeErreur:=0;
                      Result.Retour:=true;
                    End
                    else
                    if CCourant.AsInteger > 1 then
                    Begin
                      Result.CodeErreur:=1002;
                      Result.Retour:=false;
                    End;
                  End;
                1:Begin // Nom Doss
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=1000;
                      Result.Retour:=False;
                    End;
                  End;
                2:Begin //Adr1
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=2000;
                      Result.Retour:=False;
                    End;
                  End;
                3:Begin //Adr2
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=3000;
                      Result.Retour:=False;
                    End;
                  End;
                4:Begin  //Code Postal
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=4000;
                      Result.Retour:=False;
                    End;
                  End;
                5:Begin // Ville
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=5000;
                      Result.Retour:=False;
                    End;
                  End;
                6:Begin // Regime_Agr
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=6000;
                      Result.Retour:=False;
                    End;
                  End;
                7:Begin // Type_Soc
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=7000;
                      Result.Retour:=False;
                    End;
                  End;
                8:Begin // Type_Fisc
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=8000;
                      Result.Retour:=False;
                    End;
                  End;
                9:Begin // Periode_TVA
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=9000;
                      Result.Retour:=False;
                    End;
                  End;
                10:Begin // Tva_Debit
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=10000;
                      Result.Retour:=False;
                    End;
                  End;
                11:Begin //Plan_Aux
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=11000;
                      Result.Retour:=False;
                    End;
                  End;
                12:Begin // Periode
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=12000;
                      Result.Retour:=False;
                    End;
                  End;
                13:Begin // Type_Impot
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=13000;
                      Result.Retour:=False;
                    End;
                  End;
                14:Begin //Typ_Dec_Fisc
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=14000;
                      Result.Retour:=False;
                    End;
                  End;
                15:Begin // Date_Deb_Exo
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=15000;
                      Result.Retour:=False;
                    End;
                  End;
                16:Begin // Date_Fin_Exo
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=16000;
                      Result.Retour:=False;
                    End;
                  End;
                17:Begin // Exo_Saisie
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=17000;
                      Result.Retour:=False;
                    End;
                  End;
                18:Begin // Exo_Base
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=18000;
                      Result.Retour:=False;
                    End;
                  End;
                19:Begin // Devise_Exo
                   if Empty(CCourant.AsString) then
                    Begin
                      Result.CodeErreur:=19000;
                      Result.Retour:=False;
                    End;
                  End;
             end;
          End;
end;}

End;

procedure TDMParamEntreprise.taParamDossAfterOpen(DataSet: TDataSet);
var
NbEnregistrement:Integer;
begin
if not TaParamDoss.Active then TaParamDoss.Open;
NbEnregistrement:=TaParamDoss.RecordCount;
TaParamDoss.Close;
  case E.TypeDossier of
    VerDemoAgri,VerDemoGeneral:
                begin
                 TaParamDoss.Close;
                 taParamDoss.AfterOpen:=nil;
                 taParamDoss.ReadOnly:=false;//DMRech.TaBalanceRech.RecordCount <> 0;
                 taParamDoss.BeforePost:=nil;
                 taParamDoss.AfterPost:=nil;
                  if NbEnregistrement = 0 then
                   begin
                     taParamDoss.Open;
                     TaParamDoss.InsertRecord(['1',
                                               'Le Grain SA (Version Démo)',
                                               'Bd La Gare',
                                               ' ',
                                               '82230',
                                               'Monclar de Quercy',
                                               E.Regime,
                                               'IND',
                                               nil,
                                               'A',
                                               'E',
                                               str_bool2str_LGR (E.PlanAuxT,'T',''),
                                               nil,
                                               nil,
                                               nil,
                                               DateInfos(E.DatExoDebut).DateStr,
                                               DateInfos(E.DatExoFin).DateStr,
                                               E.ExerciceSaisie,
                                               E.ExerciceBase,
                                               E.Devise
                                               ]);
                   TablegerePost(taParamDoss);
//                     taParamDoss.Post;
                     //TaParamDoss.FlushBuffers;
                     TaParamDoss.Close;
                   end;
                 TaParamDossierChampLectureSeule(taParamDoss,E.TypeDossier,NbEnregistrement);

                 taParamDoss.Open;

//{ isa  le  11/10/03 }                 taParamDoss.AfterOpen:=taParamDossAfterOpen;
                 taParamDoss.BeforePost:=taParamDossBeforePost;
                 taParamDoss.AfterPost:=taParamDossAfterPost;
                end;
    VerAgricole,VerGeneral:begin
                 if not DMRech.TaBalanceRech.Active then DMRech.TaBalanceRech.Open;
                 taParamDoss.Close;
                 TaParamDossierChampLectureSeule(taParamDoss,E.TypeDossier,NbEnregistrement);
                 taParamDoss.AfterOpen:=nil;
                 taParamDoss.Open;
//{ isa  le  11/10/03 }                 taParamDoss.AfterOpen:=taParamDossAfterOpen;
                end;
    VerDiocese:begin
                 if not DMRech.TaBalanceRech.Active then
                 DMRech.TaBalanceRech.Open;
                 taParamDoss.Close;
                 taParamDossNOM_DOSS.ReadOnly:=false;
                 taParamDoss.AfterOpen:=nil;

                 if DMRech = nil then DMRech:=TDMRech.Create(application.MainForm);
                 DMRech.TaBalanceRech.Filtered := false;
                 DMRech.TaEcritureRech.Filtered := false;
                 if not DMRech.TaBalanceRech.Active then DMRech.TaBalanceRech.Open;
                 if not DMRech.TaEcritureRech.Active then DMRech.TaEcritureRech.Open;
                 taParamDoss.ReadOnly:=((DMRech.TaBalanceRech.RecordCount <> 0) or (DMRech.TaEcritureRech.RecordCount <> 0));

                 taParamDoss.Open;
//{ isa  le  11/10/03 }                 taParamDoss.AfterOpen:=taParamDossAfterOpen;
                end;
    VerInconnu:begin
                 TaParamDoss.Close;
                 taParamDoss.AfterOpen:=nil;
                 taParamDoss.ReadOnly:=false;//DMRech.TaBalanceRech.RecordCount <> 0;
//                 taParamDoss.BeforePost:=nil;
//                 taParamDoss.AfterPost:=nil;
                  if NbEnregistrement = 0 then
                   begin
                    // E.TypeDossier := E.TypeDossierdemo;
                     taParamDoss.Open;
                     TaParamDoss.InsertRecord(['1',
                                               'Le Grain SA (Version Démo)',
                                               'Bd La Gare',
                                               ' ',
                                               '82230',
                                               'Monclar de Quercy',
                                               E.Regime,
                                               'IND',
                                               nil,
                                               'A',
                                               'E',
                                               str_bool2str_LGR (E.PlanAuxT,'T',''),
                                               nil,
                                               nil,
                                               nil,
                                               DateInfos(E.DatExoDebut).DateStr,
                                               DateInfos(E.DatExoFin).DateStr,
                                               E.ExerciceSaisie,
                                               E.ExerciceBase,
                                               E.Devise]);
                                               //,E.TypeVersionToInt(E.TypeDossier)]);

                     TablegerePost(taParamDoss);
//                     taParamDoss.Post;
//                     TaParamDoss.FlushBuffers;
                     TaParamDoss.Close;
                   end;
                 TaParamDossierChampLectureSeule(taParamDoss,E.TypeDossier,NbEnregistrement);

                 taParamDoss.Open;

//{ isa  le  11/10/03 }                 taParamDoss.AfterOpen:=taParamDossAfterOpen;

//                 taParamDoss.BeforePost:=taParamDossBeforePost;
//                 taParamDoss.AfterPost:=taParamDossAfterPost;

                end;
  end;
//taParamDossDATE_DEB_EXO.DisplayFormat:='dd/mm/yyyy';
//taParamDossDIV.AsString
end;

procedure TDMParamEntreprise.taParamDossBeforePost(DataSet: TDataSet);
Var
I:Integer;
CtrlSaisie:TExceptLGR;
begin
// auto Généré
//******************************************************************************
Try
Case DataSet.State of
   dsInsert:Begin
            For I:=0 to DataSet.FieldCount-1 do
              begin
               try
                CtrlSaisie:=CtrlSaisieDossier(DataSet.Fields[i]);
               except
                case CtrlSaisie.NumErreur of
                // Traitement CLE
                //*************************************************************************
                0000:Begin
                       DataSet.Fields[i].AsInteger := 1;
//                        DataSet.Fields[i].FocusControl;
//                        abort;
                     End;
                // Traitement NOM_DOSS
                //*************************************************************************
                1000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Adr1
                //*************************************************************************
                2000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Adr2
                //*************************************************************************
                3000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement CP
                //*************************************************************************
                4000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement VILLE
                //*************************************************************************
                5000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement REGIME_Agr
                //*************************************************************************
                6000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement TYPE_SOC
                //*************************************************************************
                7000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement TYPE_FISC
                //*************************************************************************
                8000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement PERIODE_TVA
                //*************************************************************************
                9000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement TVA_DEBIT
                //*************************************************************************
                10000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement PLAN_AUX
                //*************************************************************************
                11000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement PERIODE
                //*************************************************************************
                12000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement TYPE_IMPOT
                //*************************************************************************
                13000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement TYPE_DEC_FISC
                //*************************************************************************
                14000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement DATE_DEB_EXO
                //*************************************************************************
                15000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement DATE_FIN_EXO
                //*************************************************************************
                16000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement EXO_SAISIE
                //*************************************************************************
                17000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement EXO_BASE
                //*************************************************************************
                18000:Begin
                        DataSet.Fields[i].AsString := DataSet.FindField('EXO_SAISIE').AsString
                     End;
                // Traitement DEVISE_EXO
                //*************************************************************************
                19000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement DIV
                //*************************************************************************
                20000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement DATE_PREM_DECL_TVA
                //*************************************************************************
                21000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement DEROGATOIRE
                //*************************************************************************
                22000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement DATE_PASSAGE_REEL
                //*************************************************************************
                23000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement AU_REEL
                //*************************************************************************
                24000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement PARAM_DIV
                //*************************************************************************
                25000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement UTILISATEUR
                //*************************************************************************
                26000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                End; // Fin du case
               End; // Fin du try
              End; // Fin du begin de boucle For
            End; // Fin Begin du dsInsert
// Zone Edition
   dsEdit:Begin
            For I:=0 to DataSet.FieldCount-1 do
              begin
               try
                CtrlSaisie:=CtrlSaisieDossier(DataSet.Fields[i]);
               except
                case CtrlSaisie.NumErreur of
                // Traitement CLE
                //*************************************************************************
                0000:Begin
                       DataSet.Fields[i].AsInteger := 1;
//                        DataSet.Fields[i].FocusControl;
//                        abort;
                     End;
                // Traitement NOM_DOSS
                //*************************************************************************
                1000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Adr1
                //*************************************************************************
                2000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Adr2
                //*************************************************************************
                3000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement CP
                //*************************************************************************
                4000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement VILLE
                //*************************************************************************
                5000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement REGIME_Agr
                //*************************************************************************
                6000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement TYPE_SOC
                //*************************************************************************
                7000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement TYPE_FISC
                //*************************************************************************
                8000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement PERIODE_TVA
                //*************************************************************************
                9000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement TVA_DEBIT
                //*************************************************************************
                10000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement PLAN_AUX
                //*************************************************************************
                11000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement PERIODE
                //*************************************************************************
                12000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement TYPE_IMPOT
                //*************************************************************************
                13000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement TYPE_DEC_FISC
                //*************************************************************************
                14000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement DATE_DEB_EXO
                //*************************************************************************
                15000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement DATE_FIN_EXO
                //*************************************************************************
                16000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement EXO_SAISIE
                //*************************************************************************
                17000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement EXO_BASE
                //*************************************************************************
                18000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement DEVISE_EXO
                //*************************************************************************
                19000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement DIV
                //*************************************************************************
                20000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement DATE_PREM_DECL_TVA
                //*************************************************************************
                21000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement DEROGATOIRE
                //*************************************************************************
                22000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement DATE_PASSAGE_REEL
                //*************************************************************************
                23000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement AU_REEL
                //*************************************************************************
                24000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement PARAM_DIV
                //*************************************************************************
                25000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement UTILISATEUR
                //*************************************************************************
                26000:Begin
//                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                End; // Fin du case
               End; // Fin du try
              End; // Fin du begin de boucle For
              End; // Fin Begin du dsEdit
End; // Fin du Case

Except
// Showmessage(InTtoStr(DataSet.RecordCount));
 TableGereRollBack(DataSet);
 abort;
End;

//******************************************************************************
//  for i:=0 to DataSet.fieldCount-1 do
//  Begin
//   ExceptLGR:=CtrlSaisieDossier(DataSet.fields[i]);
//   if not ExceptLGR.retour then
//    Begin
//
//    End;
//
//  End;
//
end;

procedure TDMParamEntreprise.taParamDossAfterPost(DataSet: TDataSet);
var
InfosParam_Dossier:TInfosParam_Dossier;
begin
Init_E_Entreprise_Avec_TaParamEntreprise;
Remplit_TInfosParam_Dossier(DataSet,InfosParam_Dossier);
// Maj gest dossier
  case E.TypeDossier of
  VerInconnu:begin
//               GestDossierMaj_Exo_Base_Exo_Courant_DatesExo(E.NomDossier,E.NomExo,
//                                                            InfosParam_Dossier.EXO_BASE,InfosParam_Dossier.EXO_SAISIE,
//                                                            InfosParam_Dossier.DATE_DEB_EXO,InfosParam_Dossier.DATE_FIN_EXO);
             End;
  // Dossier de type agricole
  VerAgricole:begin
               GestDossierMaj_Exo_Base_Exo_Courant_DatesExo(E.NomDossier,E.NomExo,
                                                            InfosParam_Dossier.EXO_BASE,InfosParam_Dossier.EXO_SAISIE,
                                                            InfosParam_Dossier.DATE_DEB_EXO,InfosParam_Dossier.DATE_FIN_EXO);
              end;
  VerDemoAgri:Begin

              End;
  VerAgriClot:Begin

              End;
  // Dossier de type Diocese
  VerDiocese:begin

              end;
  VerDemoDioc:Begin

              End;
  VerDiocClot:Begin

              End;
  // Dossier de type Industriel
  VerGeneral:Begin
               GestDossierMaj_Exo_Base_Exo_Courant_DatesExo(E.NomDossier,E.NomExo,
                                                            InfosParam_Dossier.EXO_BASE,InfosParam_Dossier.EXO_SAISIE,
                                                            InfosParam_Dossier.DATE_DEB_EXO,InfosParam_Dossier.DATE_FIN_EXO);
             end;
  VerDemoGeneral:Begin

                 End;
  VerGeneClot:Begin

              End;

end;
OuvreExercice(E.NomDossier,E.NomExo);
end;

procedure TDMParamEntreprise.taParamDossBeforeEdit(DataSet: TDataSet);
begin
DerogatoireAux:=Derogatoire;
DatePremiereTva:=DataSet.FindField('DATE_PREM_DECL_TVA').AsDateTime;
//If not((e.AccesOuverture)or((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'))) then abort;
end;

Function TDMParamEntreprise.taParamDossierChampLectureSeule(DataSet:TDataSet;TypeVersion:TTypeDossier;NbEnregistrement:Integer):Boolean;
var
ListEvent:TList;
i:integer;
Begin
if DAtaSet.State in [dsEdit,dsInsert] then
 begin
  showmessage('Attention, la table ParamEntreprise ne devrait pas être en modif ou insert.');
  TableGerePost(DataSet);
 end;
if dAtaSet.Active then
 begin
  showmessage('Attention, la table ParamEntreprise ne devrait pas être ouverte.');
  DataSet.Close;
 end;
ListEvent:=TList.Create;
ListEvent.Clear;
 if DMRech = nil then DMRech:=TDMRech.Create(application.MainForm);

 DeFiltrageDataSet(DMRech.TaBalanceRech);
 DeFiltrageDataSet(DMRech.TaEcritureRech);
 DeFiltrageDataSet(DMRech.TaBalanceTiersRech);
 DeFiltrageDataSet(DMRech.TaH_TVARech);
 DeFiltrageDataSet(DMRech.TaEcritureRech);
 DeFiltrageDataSet(DMRech.TaTiersRech);

// taParamDoss.ReadOnly:=
//DataSet.MethodAddress
case e.TypeDossier of
  // Si type Inconnu, certainement nouveau dossier
  VerInconnu:Begin
               for i:=0 to TTable(DAtaSet).FieldCount-1 do
               TTable(DAtaSet).Fields[i].ReadOnly := false;
             End;
  // Dossier de type agricole
  VerAgricole,VerGeneral:begin
                if NbEnregistrement = 1 then
                 begin
                  taParamDossCLE.ReadOnly:=((DMRech.TaBalanceRech.RecordCount <> 0) or (DMRech.TaEcritureRech.RecordCount <> 0));
                  taParamDossNOM_DOSS.ReadOnly:=((DMRech.TaBalanceRech.RecordCount <> 0) or (DMRech.TaEcritureRech.RecordCount <> 0));
                  taParamDossAdr1.ReadOnly:=false;
                  taParamDossAdr2.ReadOnly:=false;
                  taParamDossCP.ReadOnly:=false;
                  taParamDossVILLE.ReadOnly:=false;
                  taParamDossREGIME_Agr.ReadOnly:=true;
                  taParamDossTYPE_SOC.ReadOnly:=false;
                  taParamDossTYPE_FISC.ReadOnly:=false;
                  taParamDossPERIODE_TVA.ReadOnly:=false;
                  taParamDossTVA_DEBIT.ReadOnly:=false;
                  taParamDossPLAN_AUX.ReadOnly:=(DMRech.TaTiersRech.RecordCount <> 0);
                  taParamDossPERIODE.ReadOnly:=false;
                  taParamDossTYPE_IMPOT.ReadOnly:=false;
                  taParamDossTYPE_DEC_FISC.ReadOnly:=false;
                  taParamDossDATE_DEB_EXO.ReadOnly:=((DMRech.TaBalanceRech.RecordCount <> 0) or (DMRech.TaEcritureRech.RecordCount <> 0));
                  taParamDossDATE_FIN_EXO.ReadOnly:=false;
                  taParamDossEXO_SAISIE.ReadOnly:=((DMRech.TaBalanceRech.RecordCount <> 0) or (DMRech.TaEcritureRech.RecordCount <> 0));
                  taParamDossEXO_BASE.ReadOnly:=false;
                  taParamDossDEVISE_EXO.ReadOnly:=((DMRech.TaBalanceRech.RecordCount <> 0) or (DMRech.TaEcritureRech.RecordCount <> 0));
                  taParamDossDIV.ReadOnly:=false;
                  taParamDossDATE_PREM_DECL_TVA.ReadOnly:=(DMRech.TaEcritureRech.RecordCount <> 0);
                  taParamDossDEROGATOIRE.ReadOnly:=false;
                  taParamDossDATE_PASSAGE_REEL.ReadOnly:=false;
                  taParamDossAU_REEL.ReadOnly:=false;
                  taParamDossPARAM_DIV.ReadOnly:=false;
                  taParamDossUTILISATEUR.ReadOnly:=false;
                 end
                 else
                 begin
                   for i:=0 to TTable(DAtaSet).FieldCount-1 do
                     TTable(DAtaSet).Fields[i].ReadOnly := false;
                 end;
//                  taParamDoss.ReadOnly :=false;

              end;
  VerDemoAgri,VerDemoGeneral:Begin
                if NbEnregistrement = 1 then
                 begin
                  taParamDossCLE.ReadOnly:=False;
                  taParamDossNOM_DOSS.ReadOnly:=false;
                  taParamDossAdr1.ReadOnly:=false;
                  taParamDossAdr2.ReadOnly:=false;
                  taParamDossCP.ReadOnly:=false;
                  taParamDossVILLE.ReadOnly:=false;
                  taParamDossREGIME_Agr.ReadOnly:=true;
                  taParamDossTYPE_SOC.ReadOnly:=false;
                  taParamDossTYPE_FISC.ReadOnly:=false;
                  taParamDossPERIODE_TVA.ReadOnly:=false;
                  taParamDossTVA_DEBIT.ReadOnly:=false;
                  taParamDossPLAN_AUX.ReadOnly:=true;
                  taParamDossPERIODE.ReadOnly:=false;
                  taParamDossTYPE_IMPOT.ReadOnly:=false;
                  taParamDossTYPE_DEC_FISC.ReadOnly:=false;
                  taParamDossDATE_DEB_EXO.ReadOnly:=((DMRech.TaBalanceRech.RecordCount <> 0) or (DMRech.TaEcritureRech.RecordCount <> 0));
                  taParamDossDATE_FIN_EXO.ReadOnly:=false;
                  taParamDossEXO_SAISIE.ReadOnly:=((DMRech.TaBalanceRech.RecordCount <> 0) or (DMRech.TaEcritureRech.RecordCount <> 0));
                  taParamDossEXO_BASE.ReadOnly:=false;
                  taParamDossDEVISE_EXO.ReadOnly:=((DMRech.TaBalanceRech.RecordCount <> 0) or (DMRech.TaEcritureRech.RecordCount <> 0));
                  taParamDossDIV.ReadOnly:=false;
                  taParamDossDATE_PREM_DECL_TVA.ReadOnly:=(DMRech.TaEcritureRech.RecordCount <> 0);
                  taParamDossDEROGATOIRE.ReadOnly:=false;
                  taParamDossDATE_PASSAGE_REEL.ReadOnly:=false;
                  taParamDossAU_REEL.ReadOnly:=false;
                  taParamDossPARAM_DIV.ReadOnly:=false;
                  taParamDossUTILISATEUR.ReadOnly:=false;
                 end
                 else
                 begin
                   for i:=0 to TTable(DAtaSet).FieldCount-1 do
                     TTable(DAtaSet).Fields[i].ReadOnly := false;
                 end;
                 //taParamDoss.ReadOnly :=false;
              End;
  VerAgriClot:Begin

              End;
  // Dossier de type Diocese
  VerDiocese:begin

              end;
  VerDemoDioc:Begin

              End;
  VerDiocClot:Begin

              End;
  // Dossier de type Industriel
//  VerGeneral:Begin
//
//             end;
//  VerDemoGeneral:Begin
//
//                 End;
  VerGeneClot:Begin

              End;

end;
ListEvent.Free;
End;

procedure TDMParamEntreprise.taParamDossBeforeOpen(DataSet: TDataSet);
begin
//showmessage('Avant');
//taParamDoss.AfterOpen:=nil; // Obligztoire
end;


///***********************************************************////////////
//-1 l'enregistrement n'est pas créé
//0 les paramètres entreprise ne sont pas remplis, mais l'enregistrement existe
//1 les paramètres entreprise sont remplis.
function ParamEntrepriseRemplis:integer;
Begin
  result:=-1;
  if DMRech = nil then DMRech:=DMRech.Create(Application);
  if not DMRech.TaParam_DossierRech.active then
  DMRech.TaParam_DossierRech.Open;
  DMRech.TaParam_DossierRech.Refresh;
  result:=DMRech.TaParam_DossierRech.RecordCount;
  if result>-1 then //si la ligne existe
     if ((VerifFNumeric(DMRech.TaParam_DossierRech.findfield('DATE_DEB_EXO')).Vide)and(VerifFNumeric(DMRech.TaParam_DossierRech.findfield('DATE_FIN_EXO')).Vide)and(VerifFNumeric(DMRech.TaParam_DossierRech.findfield('EXO_SAISIE')).Vide)) then
      result:=-1 //les paramètres ne sont pas remplis
     else
      result:=2; //les paramètres sont remplis
End;
///***********************************************************////////////




Procedure TDMParamEntreprise.MiseAJourParamDossier_SurOuvertureExo(InfosBascule_Tmp:TInfosBascule);
var
ExceptLGR_:TExceptLGR;
Event_Tmp:TDataSetNotifyEvent;
begin
try//except
Initialise_ExceptLGR(ExceptLGR_);
  if not TaParamDossMAJ.active then TaParamDossMAJ.Open;
  if TaParamDossMAJ.RecordCount=0 then
    Begin
      raise ExceptLGR.Create('La description de l"entreprise n"existe pas !',0000,true,mtError,ExceptLGR_);
    end;
//  Event_Tmp:=taParamDoss.AfterPost;
//  taParamDoss.AfterPost:=nil;
  TaParamDossMAJ.edit;
  TaParamDossMAJ.FindField('DATE_DEB_EXO').asdatetime:=InfosBascule_Tmp.DateDeb;
  TaParamDossMAJ.FindField('DATE_FIN_EXO').asdatetime:=InfosBascule_Tmp.DateFin;
  TaParamDossMAJ.FindField('Exo_Saisie').asstring:=InfosBascule_Tmp.ExoSaisie;
  if(e.TypeUtilisateur in [U_Normal,U_SuperComptable,U_LibreService])then
  begin
//    if(TaParamDossMAJ.FindField('creation').asstring='')then
//    begin
//     TaParamDossMAJ.FindField('creation').asstring:=TypeUtilisateurToStr(e.TypeUtilisateur);
//     TaParamDossMAJ.FindField('FORCE').AsBoolean:=true;
//    end;
  end;
  TableGerePost(TaParamDossMAJ);
//  taParamDoss.AfterPost:=Event_Tmp;
  TaParamDossMAJ.Close;
except
  abort;
end;//fin except
end;

Function TDMParamEntreprise.ModifParamEntAcces(ParamEntAcces:TParamEntAcces;TypeVersion:TTypeDossier):TParamEntAcces;
var
ListEvent:TList;
i,NbEnregistrement:integer;
Begin
//if DAtaSet.State in [dsEdit,dsInsert] then
// begin
//  showmessage('Attention, la table ParamEntreprise ne devrait pas être en modif ou insert.');
//  TableGerePost(DataSet);
// end;
//if dAtaSet.Active then
// begin
//  showmessage('Attention, la table ParamEntreprise ne devrait pas être ouverte.');
//  DataSet.Close;
// end;
ListEvent:=TList.Create;
ListEvent.Clear;
 if DMRech = nil then DMRech:=TDMRech.Create(application.MainForm);

 DeFiltrageDataSet(DMRech.TaBalanceRech);
 DeFiltrageDataSet(DMRech.TaEcritureRech);
 DeFiltrageDataSet(DMRech.TaBalanceTiersRech);
 DeFiltrageDataSet(DMRech.TaH_TVARech);
 DeFiltrageDataSet(DMRech.TaEcritureRech);
 DeFiltrageDataSet(DMRech.TaTiersRech);
 DeFiltrageDataSet(DMRech.TaParam_DossierRech);
 NbEnregistrement := DMRech.TaParam_DossierRech.RecordCount;

// taParamDoss.ReadOnly:=
//DataSet.MethodAddress
case e.TypeDossier of
  // Si type Inconnu, certainement nouveau dossier
  VerInconnu:Begin
              Result.CLEReadOnly := false;
              Result.DATE_DEB_EXOReadOnly := false;
              Result.DATE_PREM_DECL_TVAReadOnly := false;
              Result.EXO_SAISIEReadOnly := false;
              Result.NOM_DOSSReadOnly := false;
              Result.PLAN_AUXReadOnly := false;
             End;
  // Dossier de type agricole
  VerAgricole,VerGeneral:begin
                if NbEnregistrement = 1 then
                 begin
                  Result.CLEReadOnly := ((DMRech.TaBalanceRech.RecordCount <> 0) or (DMRech.TaEcritureRech.RecordCount <> 0));
                  Result.DATE_DEB_EXOReadOnly := ((DMRech.TaBalanceRech.RecordCount <> 0) or (DMRech.TaEcritureRech.RecordCount <> 0));
                  Result.DATE_PREM_DECL_TVAReadOnly := (DMRech.TaEcritureRech.RecordCount <> 0);
                  Result.EXO_SAISIEReadOnly := ((DMRech.TaBalanceRech.RecordCount <> 0) or (DMRech.TaEcritureRech.RecordCount <> 0));
                  Result.NOM_DOSSReadOnly := ((DMRech.TaBalanceRech.RecordCount <> 0) or (DMRech.TaEcritureRech.RecordCount <> 0));
                  Result.PLAN_AUXReadOnly := (DMRech.TaTiersRech.RecordCount <> 0);

//                  taParamDossDEVISE_EXO.ReadOnly:=((DMRech.TaBalanceRech.RecordCount <> 0) or (DMRech.TaEcritureRech.RecordCount <> 0));

                 end
                 else
                 begin
                  Result.CLEReadOnly := False;
                  Result.DATE_DEB_EXOReadOnly := False;
                  Result.DATE_PREM_DECL_TVAReadOnly := False;
                  Result.EXO_SAISIEReadOnly := False;
                  Result.NOM_DOSSReadOnly := False;
                  Result.PLAN_AUXReadOnly := False;
                 end;
//                  taParamDoss.ReadOnly :=false;

              end;
  VerDemoAgri,VerDemoGeneral:Begin
                if NbEnregistrement = 1 then
                 begin
                  Result.CLEReadOnly := False;
                  Result.DATE_DEB_EXOReadOnly := ((DMRech.TaBalanceRech.RecordCount <> 0) or (DMRech.TaEcritureRech.RecordCount <> 0));
                  Result.DATE_PREM_DECL_TVAReadOnly := (DMRech.TaEcritureRech.RecordCount <> 0);
                  Result.EXO_SAISIEReadOnly := ((DMRech.TaBalanceRech.RecordCount <> 0) or (DMRech.TaEcritureRech.RecordCount <> 0));
                  Result.NOM_DOSSReadOnly := False;
                  Result.PLAN_AUXReadOnly := true;
                 end
                 else
                 begin
                  Result.CLEReadOnly := False;
                  Result.DATE_DEB_EXOReadOnly := False;
                  Result.DATE_PREM_DECL_TVAReadOnly := False;
                  Result.EXO_SAISIEReadOnly := False;
                  Result.NOM_DOSSReadOnly := False;
                  Result.PLAN_AUXReadOnly := False;
                 end;
                 //taParamDoss.ReadOnly :=false;
              End;
  VerAgriClot:Begin

              End;
  // Dossier de type Diocese
  VerDiocese:begin

              end;
  VerDemoDioc:Begin

              End;
  VerDiocClot:Begin

              End;
  // Dossier de type Industriel
//  VerGeneral:Begin
//
//             end;
//  VerDemoGeneral:Begin
//
//                 End;
  VerGeneClot:Begin

              End;

end;
ListEvent.Free;
End;

//procedure rajoutée par isa et phil (à l'arrache) pour gérer l'empechement
//de l'arret du dérogatoire alors qu'il existe encore des soldes sur report derog dans les immos
Procedure ModifChampDerogatoire;
begin
try
   if DMRech = nil then DMRech:=TDMRech.Create(application.MainForm);
   DeFiltrageDataSet(DMRech.TaParam_DossierRech);
   if DMRech.TaParam_DossierRech.RecordCount=1 then
     begin
        if ((VerifSiReportDerogatoire(e.DatExoDebut,e.DatExofin).retour)and(DMRech.TaParam_DossierRech.findfield('Derogatoire').AsBoolean=false)) then
          begin
             DMRech.TaParam_DossierRech.edit;
             DMRech.TaParam_DossierRech.findfield('Derogatoire').AsBoolean:=true;
             tablegerepost(DMRech.TaParam_DossierRech);
          end;
     end;
except
  showmessage('ModifChampDerogatoire : Problème sur le champ dérogatoire.');
end;
end;


Procedure TDMParamEntreprise.MiseAJourParamDossier_SurClotureDefinitiveExercice(ExoBase:string);
var
ExceptLGR_:TExceptLGR;
Event_Tmp:TDataSetNotifyEvent;
begin
try//except
Initialise_ExceptLGR(ExceptLGR_);
  if not TaParamDossMAJ.active then TaParamDossMAJ.Open;
  if TaParamDossMAJ.RecordCount=0 then
    Begin
      raise ExceptLGR.Create('La description de l"entreprise n"existe pas !',0000,true,mtError,ExceptLGR_);
    end;
  TaParamDossMAJ.edit;
  TaParamDossMAJ.FindField('Exo_Base').asstring:=ExoBase;
  TableGerePost(TaParamDossMAJ);
  TaParamDossMAJ.Close;
except
  abort;
end;//fin except
end;

procedure TDMParamEntreprise.taParamDossBeforeInsert(DataSet: TDataSet);
begin
DatePremiereTva:=0;
//If not((e.AccesOuverture)or((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'))) then abort;
end;

procedure TDMParamEntreprise.taParamDossAfterInsert(DataSet: TDataSet);
begin
taParamDoss.FindField('Derogatoire').AsBoolean:=false;
end;

end.
