unit DMProgramme;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,LibSQL, Menus,Gr_Librairie_Obj,E2_Decl_records,DMRecherche,E2_LibInfosTAble,
  FileCtrl,
  LibFichREp,
  Lib_Chaine,
  LibRessourceString,E2_Librairie_Obj,LibZoneSaisie,Gr_MultDos,LibDates,DMConstantes
  ,Variants
  ;

type
TFileGestDossier = record
         CLe_Dossier:String[24];
         ID_Dossier:string[8];
         ID_Table:string[8];
         Nom_Dossier:string[255];
         Dir_Dossier:string[255];
         Nom_Exo:string[255];
         Dir_Exo:string[255];
         Annee_Dossier:string[10];
         DateUtil:string[10];
         Cloture:string[10];
         EXO_BASE:string[2];
         EXO_SAISIE:string[2];
         DATE_DEB_EXO:string[10];
         DATE_FIN_EXO:string[10];
         ResultInfos:string[10];
end;

  TExercice = class(TObject)
    private
    { Déclarations privées }
  public
    { Déclarations publiques }
    nom_Dossier:string;
    id_Dossier:integer;
    dir_dossier:string;
    dir_exo:string;
    nom_exo:string;
    cloture:boolean;
    Date_Deb_Exo:TDate;
    Date_Fin_Exo:TDate;
    Designation_dossier:string;

    constructor Create;
    destructor Destroy;
  end;

  

  TDMProg = class(TDataModule)
    TaGestDossierConsult: TTable;
    DaGestDossierConsult: TDataSource;
    Query1: TQuery;
    TaGestDos: TTable;
    TaGestDosID_Dossier: TIntegerField;
    TaGestDosID_Table: TIntegerField;
    TaGestDosNom_Dossier: TStringField;
    TaGestDosDir_Dossier: TStringField;
    TaGestDosNom_Exo: TStringField;
    TaGestDosDir_Exo: TStringField;
    TaGestDosAnnee_Dossier: TDateTimeField;
    TaGestDosDateUtil: TDateTimeField;
    TaGestDosCloture: TBooleanField;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    daGestDos: TDataSource;
    TaGestDosEXO_BASE: TStringField;
    TaGestDosEXO_SAISIE: TStringField;
    TaGestDosDATE_DEB_EXO: TDateField;
    TaGestDosDATE_FIN_EXO: TDateField;
    QuGestDossierMenu: TQuery;
    TaGestDosModif: TTable;
    QuGEstDossier: TQuery;
    TaGDossier: TTable;
    QuGestDossierMenuDossier: TQuery;
    QuGestDossierMenuExercice: TQuery;
    TaGestDosDESIGNATION_DOSSIER: TStringField;
    TaGDossierID_Dossier: TIntegerField;
    TaGDossierID_Table: TIntegerField;
    TaGDossierNom_Dossier: TStringField;
    TaGDossierDir_Dossier: TStringField;
    TaGDossierNom_Exo: TStringField;
    TaGDossierDir_Exo: TStringField;
    TaGDossierAnnee_Dossier: TDateTimeField;
    TaGDossierDateUtil: TDateTimeField;
    TaGDossierCloture: TBooleanField;
    TaGDossierEXO_BASE: TStringField;
    TaGDossierEXO_SAISIE: TStringField;
    TaGDossierDATE_DEB_EXO: TDateField;
    TaGDossierDATE_FIN_EXO: TDateField;
    TaGDossierDESIGNATION_DOSSIER: TStringField;
    procedure DMProgCreate(Sender: TObject);
    Function CtrlSaisieNewExo(CCourant:TField):TErreurSaisie;
    Function CtrlSaisieNewDossier(CCourant:TField):TErreurSaisie;
    procedure TaGestDosModifBeforePost(DataSet: TDataSet);
    procedure QuGestDossierMenuFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuGestDossierMenuBeforeOpen(DataSet: TDataSet);
    procedure QuGestDossierMenuAfterClose(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    Function SauveGestDossierFichier(NomDossier:String;RepDossier:String=''):Boolean;
    procedure TaGestDosModifAfterPost(DataSet: TDataSet);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    ListeDossierTableTraiteMenu:TStringList;
  end;
FichierDossier = File of TFileGestDossier;

var
  DMProg: TDMProg;

  Function DossierExiste(NomDossier,DirDossier:string):boolean;
  Function ExoExiste(NomExo,DirExo:string):boolean;
  Function GEstDossierNomDossier(IDDossier:String):string;
  Function GEstDossierNomExo(IDDossier,IDExo:String):string;
  Function GEstDossierNbExoNonCloture(NomDossier:String):integer;
  Function GEstDossierExerciceEnCoursCloturable(ParamEntreprise:TEntreprise):Boolean;
  function GestDossierInfosExoN1:TChangtExo;
  Procedure GEstDossierMaJDateUtilDossier(NomDos,NomExo,DesignationDossier:string);
  Procedure GestDossierMaj_Exo_Base_Exo_Courant_DatesExo(NomDos,NomExo,Exo_Base,Exo_Saisie:string;Date_Deb_Exo,Date_Fin_Exo:TDate);
  Function ListeCodeExoDejaUtilisePourDossier(NomDossier:string):TStringList;
  Function GEstDossierSuppressionDossier(NomDossier:String):Boolean;
  Function GEstDossierSuppressionExo(NomDossier,NomExo:String):Boolean;
  function GestDossierDatesRemplies(NomDossier,NomExo:String):boolean;
  Function ChercheInfos_ExoN1(Dossier:string):TInfosGestDossier;
  Function ChercheInfos_ExoN(Dossier:string):TInfosGestDossier;
  Function LitGestDossierFichier(NomFichier:String;Var E_Tmp:TEntreprise;SauveGardeDeSecours:Boolean):Boolean;
  Function ChercheInfos_ExoMoinsN1(Dossier:string):TInfosGestDossier;
  Function ChercheInfos_ExoSurDate(Dossier:string;Date : Tdate):TInfosGestDossier;
  
implementation

uses DMXMLs;

{$R *.DFM}

Function DossierExiste(NomDossier,DirDossier:string):boolean;
Begin
  try
    result:=false;
    if DMProg = nil then
    DMProg:=TDMProg.Create(Application.MainForm);
    if not DMProg.TaGestDossierConsult.Active then DMProg.TaGestDossierConsult.Open;
    result:=DMProg.TaGestDossierConsult.locate('Nom_Dossier',NomDossier,[loCaseInsensitive]);
    if not result then
      result:=DMProg.TaGestDossierConsult.locate('Dir_Dossier',DirDossier,[loCaseInsensitive])
  except
    result:=false;
  end;
End;

Function ExoExiste(NomExo,DirExo:string):boolean;
Begin
  try
    result:=false;
    if DMProg = nil then
    DMProg:=TDMProg.Create(Application.MainForm);
    if not DMProg.TaGestDossierConsult.Active then DMProg.TaGestDossierConsult.Open;
    result:=DMProg.TaGestDossierConsult.locate('Nom_Exo',NomExo,[loCaseInsensitive]);
    if not result then
      result:=DMProg.TaGestDossierConsult.locate('Dir_Exo',DirExo,[loCaseInsensitive])
  except
    result:=false;
  end;
End;

Function GEstDossierNomDossier(IDDossier:String):string;
Begin
  try
    result:=DM_C_NomAliasDemo;
    if DMProg = nil then
    DMProg:=TDMProg.Create(Application.MainForm);
    if not DMProg.TaGestDossierConsult.Active then DMProg.TaGestDossierConsult.Open;
    if DMProg.TaGestDossierConsult.locate('ID_Dossier',StrToInt(IDDossier),[loCaseInsensitive]) then
      result:=DMProg.TaGestDossierConsult.FindField('Nom_Dossier').AsString;
    if not empty(result) then
     begin
     end;
  except
    result:=DM_C_NomAliasDemo;
  end;
End;


Function GEstDossierNomExo(IDDossier,IDExo:String):string;
Begin
  try
    result:=DM_C_NomAliasExoDemo;
    if DMProg = nil then
    DMProg:=TDMProg.Create(Application);
    if not DMProg.TaGestDossierConsult.Active then DMProg.TaGestDossierConsult.Open;
    if DMProg.TaGestDossierConsult.locate('ID_Dossier;ID_Table',VarArrayOf([StrToInt(IDDossier),StrToInt(IDExo)]),[loCaseInsensitive]) then
      result:=DMProg.TaGestDossierConsult.FindField('Nom_Exo').AsString;
    if not empty(result) then
     begin
     end;
  except
    result:=DM_C_NomAliasExoDemo;
  end;
End;

Function GEstDossierNbExoNonCloture(NomDossier:String):integer;
Begin
  try
    result:=0;;
    if DMProg = nil then
    DMProg:=TDMProg.Create(Application);
    if not DMProg.TaGestDossierConsult.Active then DMProg.TaGestDossierConsult.Open;
    DMProg.TaGestDossierConsult.Filter:=CreeFiltreET(['Nom_Dossier','Cloture'],[NomDossier,false]);
    DMProg.TaGestDossierConsult.Open;
    REsult:=DMProg.TaGestDossierConsult.RecordCount;
  except
    result:=0;;
  end;
End;

// Retourne vrai si un exo est cloturable par rapport à la table Gest_Dossier
// Aucune verif ici portant sur les critères physique d'un exercice (repertoire, etc ...)
Function GEstDossierExerciceEnCoursCloturable(ParamEntreprise:TEntreprise):Boolean;
Begin
  try
    result:=False;
    if DMProg = nil then
    DMProg:=TDMProg.Create(Application);
    if DMProg.TaGestDossierConsult.Active then DMProg.TaGestDossierConsult.close;
    FiltrageDataSet(DMProg.TaGestDossierConsult,CreeFiltreET(['Nom_Dossier','Cloture'],[ParamEntreprise.NomDossier,false]));
    // le dossier en cours ne possede qu'un seul exercice cloturable
    if DMProg.TaGestDossierConsult.RecordCount in [1..2] then
     begin
       DMProg.TaGestDossierConsult.Filter:=CreeFiltreET(['Nom_Dossier','Nom_Exo','Cloture'],[ParamEntreprise.NomDossier,ParamEntreprise.NomExo,false]);
       // Si l'exo non cloture est bien celui qu'on veut vérifier
       if (DMProg.TaGestDossierConsult.RecordCount = 1) then
        begin
       // On verifie que cet exo ne possède pas d'exo ultérieur cloture !!!!
         DMProg.TaGestDossierConsult.Filter:=CreeFiltreET(['Nom_Dossier','Cloture','DATE_DEB_EXO'],[ParamEntreprise.NomDossier,true,DateInfos(ParamEntreprise.DatExoFin+1).DateStr]);
         if (DMProg.TaGestDossierConsult.RecordCount = 0) then
          begin
          // On verifie que cet exo ne possède pas d'exo antérieur non cloture !!!!
            DMProg.TaGestDossierConsult.Filter:=CreeFiltreET(['Nom_Dossier','Cloture','DATE_FIN_EXO'],[ParamEntreprise.NomDossier,false,DateInfos(ParamEntreprise.DatExoDebut-1).DateStr]);
            result:=(DMProg.TaGestDossierConsult.RecordCount = 0);
          end;
        end;
     end;
  except
     result:=false;
  end;
End;

function GestDossierInfosExoN1:TChangtExo;
begin
    try
    if DMProg = nil then
    DMProg:=TDMProg.Create(Application);
    if DMProg.TaGestDossierConsult.Active then DMProg.TaGestDossierConsult.close;
       // On verifie que l'exo courant possède un exo ultérieur non cloturé !!!!
         DMProg.TaGestDossierConsult.Filter:=CreeFiltreET(['Nom_Dossier','Cloture','DATE_DEB_EXO'],[E.NomDossier,false,DateInfos(E.DatExoFin+1).DateStr]);
         DMProg.TaGestDossierConsult.Open;
         if (DMProg.TaGestDossierConsult.RecordCount = 1) then
          begin
          result.CheminBase:=DMProg.TaGestDossierConsult.findfield('Dir_Exo').asstring;
          result.NomBase:= DMProg.TaGestDossierConsult.findfield('Nom_Exo').asstring;
          result.ExoBase:=DMProg.TaGestDossierConsult.findfield('EXO_BASE').AsString;
          result.ExoSaisie:=DMProg.TaGestDossierConsult.findfield('EXO_SAISIE').AsString;
          result.ExoDebut:=DMProg.TaGestDossierConsult.findfield('DATE_DEB_EXO').AsDateTime;
          result.ExoFin:=DMProg.TaGestDossierConsult.findfield('DATE_FIN_EXO').AsDateTime;
          result.Cloture:=DMProg.TaGestDossierConsult.findfield('Cloture').AsBoolean;
          result.IDDos:=DMProg.TaGestDossierConsult.findfield('id_dossier').asinteger;
          result.IDexo:=DMProg.TaGestDossierConsult.findfield('id_table').asinteger;
          DMProg.TaGestDossierConsult.close;
          end
       else
          begin
          DMProg.TaGestDossierConsult.close;
          showmessage('Il n''y a pas d''autre exercice de créé, la réécriture ne pourra pas s''effectuer !!!');
          abort;
          end;
    finally
     DMProg.TaGestDossierConsult.close;
    end;//fin du try
end;


Procedure GEstDossierMaJDateUtilDossier(NomDos,NomExo,DesignationDossier:string);
var
HeureUtil:TDateTime;
FiltreOld,index_old:String;
Begin
//FiltreOld:=Main.gestDos.Filter;
//Main.GestDos.Filtered:=false;
//index_old:=Main.GestDos.IndexName;
//Main.GestDos.IndexName:='Date_Util';
If NomDos = DM_C_NomAliasDemo then exit;
    if DMProg = nil then
    DMProg:=TDMProg.Create(Application);
DMProg.TaGestDosModif.close;
DMProg.TaGestDosModif.Filter:=CreeFiltreET(['Nom_Dossier','Nom_Exo'],[NomDos,NomExo]);
DMProg.TaGestDosModif.Filtered:=true;
DMProg.TaGestDosModif.BeforePost:=nil;
DMProg.TaGestDosModif.Open;
DMProg.TaGestDosModif.Last;
HeureUtil:=DMProg.TaGestDosModif.findfield('DateUtil').AsDateTime;
if HeureUtil >= now then
   begin
    MessageDlg('Attention, votre ordinateur '+#13+#10+'semble avoir un problème d'+#39+'horloge.'+#13+#10+'Un de vos dossier semble avoir une date de '+#13+#10+'dernière utilisation incorrecte.',mtWarning,[mbOK],0);
//    HeureUtil:=HeureUtil+1;
   end;
//   else
HeureUtil:=Now;
//Main.GestDos.IndexName:=index_old;
//Main.GestDos.Filter:=CreeFiltreET(['Nom_Dossier'],[NomDoss]);
//Main.GestDos.Filtered:=True;
DMProg.TaGestDosModif.Last;
//While Not DMProg.TaGestDosModif.EOF do begin
DMProg.TaGestDosModif.edit;
DMProg.TaGestDosModif.FieldValues['DateUtil']:=HeureUtil;
DMProg.TaGestDosModif.FieldValues['DESIGNATION_DOSSIER']:=DesignationDossier;
TableGerePost(DMProg.TaGestDosModif);
//	Main.GestDos.Next;
//	end;

DMProg.TaGestDosModif.close;
DMProg.TaGestDosModif.Filter:=CreeFiltreET(['Nom_Dossier'],[NomDos]);
DMProg.TaGestDosModif.Filtered:=true;
DMProg.TaGestDosModif.open;
DMProg.TaGestDosModif.first;
While Not DMProg.TaGestDosModif.EOF do
  begin
      DMProg.TaGestDosModif.edit;
      DMProg.TaGestDosModif.FieldValues['DESIGNATION_DOSSIER']:=DesignationDossier;
      TableGerePost(DMProg.TaGestDosModif);
      DMProg.TaGestDosModif.Next;
  end;


DMProg.TaGestDosModif.BeforePost:=DMProg.TaGestDosModifBeforePost;
DMProg.TaGestDosModif.Filtered:=false;
DMProg.TaGestDosModif.Filter:='';
end;

Procedure GestDossierMaj_Exo_Base_Exo_Courant_DatesExo(NomDos,NomExo,Exo_Base,Exo_Saisie:string;Date_Deb_Exo,Date_Fin_Exo:TDate);
Begin
    if DMProg = nil then
    DMProg:=TDMProg.Create(Application);
  DMProg.TaGestDosModif.close;
  DMProg.TaGestDosModif.Filter:=CreeFiltreET(['Nom_Dossier','Nom_Exo'],[NomDos,NomExo]);
  DMProg.TaGestDosModif.Filtered:=true;
  DMProg.TaGestDosModif.BeforePost:=nil;
  DMProg.TaGestDosModif.Open;
  DMProg.TaGestDosModif.Edit;
  DMProg.TaGestDosModif.FindField('EXO_BASE').AsString:=Exo_Base;
  DMProg.TaGestDosModif.FindField('EXO_SAISIE').AsString:=Exo_Saisie;
  DMProg.TaGestDosModif.FindField('DATE_DEB_EXO').AsDateTime:=Date_Deb_Exo;
  DMProg.TaGestDosModif.FindField('DATE_FIN_EXO').AsDateTime:=Date_Fin_Exo;
  TableGerePost(DMProg.TaGestDosModif);
  DMProg.TaGestDosModif.BeforePost:=DMProg.TaGestDosModifBeforePost;
  DMProg.TaGestDosModif.close;
End;

Function ListeCodeExoDejaUtilisePourDossier(NomDossier:string):TStringList;
Begin
  try
    result:=TStringList.Create;
    if DMRech = nil then
    DMRech:=TDMRech.Create(Application.MainForm);
    if not DMRech.TaGestDossierRech.Active then DMRech.TaGestDossierRech.Open;
    FiltrageDataSet(DMRech.TaGestDossierRech,'Nom_Dossier = '''+NomDossier+'''');
    result:=ChampTableVersListe('EXO_SAISIE',DMRech.TaGestDossierRech);
  except
   Showmessage('Erreur Interne : Erreur à la récupération des Codes Exercices');
   abort;
  end;
End;

// importe une sauvegarde d'un dossier déjà existant dans Epicéa // PB le 22/09/03
Function GEstDossierRestaurationDossier(NomDossier:String;DAtaSetDossier:TDataSet):Boolean;
Var
DossierIdentique:Boolean;
Begin
DeFiltrageDataSet(DAtaSetDossier);
DeFiltrageDataSet(DMRech.TaGestDossierRech);
DAtaSetDossier.First;
DMRech.TaGestDossierRech.First;

While ((DAtaSetDossier.FindField('Id_TAble').AsInteger = DMRech.TaGestDossierRech.FindField('Id_TAble').AsInteger)
   and (DAtaSetDossier.FindField('Nom_Dossier').AsString = DMRech.TaGestDossierRech.FindField('Nom_Dossier').AsString)
   and (DAtaSetDossier.FindField('Dir_Dossier').AsString = DMRech.TaGestDossierRech.FindField('Dir_Dossier').AsString)
   and (DAtaSetDossier.FindField('Nom_Exo').AsString = DMRech.TaGestDossierRech.FindField('Nom_Exo').AsString)
   and (DAtaSetDossier.FindField('Dir_Exo').AsString = DMRech.TaGestDossierRech.FindField('Dir_Exo').AsString)
   and (DAtaSetDossier.FindField('Annee_Dossier').AsDateTime = DMRech.TaGestDossierRech.FindField('Annee_Dossier').AsDateTime)
   and (DAtaSetDossier.FindField('Cloture').AsBoolean = DMRech.TaGestDossierRech.FindField('Cloture').AsBoolean)
   and (DAtaSetDossier.FindField('Exo_Base').AsString = DMRech.TaGestDossierRech.FindField('Exo_Base').AsString)
   and (DAtaSetDossier.FindField('Exo_Saisie').AsString = DMRech.TaGestDossierRech.FindField('Exo_Saisie').AsString)
   and (DAtaSetDossier.FindField('DATE_DEB_EXO').AsString = DMRech.TaGestDossierRech.FindField('DATE_DEB_EXO').AsString)
   and (DAtaSetDossier.FindField('DATE_FIN_EXO').AsString = DMRech.TaGestDossierRech.FindField('DATE_FIN_EXO').AsString)) do
 begin
  DAtaSetDossier.Next;
  DMRech.TaGestDossierRech.Next;
 end;

End;

Function GEstDossierSuppressionDossier(NomDossier:String):Boolean;
var
EtatFiltre:TEtatFiltre;
Begin
try
  result:=true;
  if DMProg = nil then DMProg:=TDMProg.Create(Application);
  DMProg.TaGestDosModif.DisableControls;
  TableSauveEtatFiltre(DMProg.TaGestDosModif,EtatFiltre);
  FiltrageDataSet(DMProg.TaGestDosModif,CreeFiltreET(['Nom_Dossier'],[NomDossier]));
  while DMProg.TaGestDosModif.RecordCount <>0 do
  begin
   DMProg.TaGestDosModif.Delete;
  end;
  DMProg.TaGestDosModif.Refresh;
  ReEnableControls(DMProg.TaGestDosModif);
  TableRestoreEtatFiltre(DMProg.TaGestDosModif,EtatFiltre);
except
 REsult:=false;
 TableRestoreEtatFiltre(DMProg.TaGestDosModif,EtatFiltre);
 Showmessage('Erreur lors de l''effacement du dossier !');
end;

End;

Function GEstDossierSuppressionExo(NomDossier,NomExo:String):Boolean;
var
EtatFiltre:TEtatFiltre;
Begin
try
  result:=true;
  if DMProg = nil then DMProg:=TDMProg.Create(Application);
  DMProg.TaGestDosModif.DisableControls;
  TableSauveEtatFiltre(DMProg.TaGestDosModif,EtatFiltre);
  FiltrageDataSet(DMProg.TaGestDosModif,CreeFiltreET(['Nom_Dossier','Nom_Exo'],[NomDossier,NomExo]));
  DMProg.TaGestDosModif.Delete;
  DMProg.TaGestDosModif.Refresh;
  ReEnableControls(DMProg.TaGestDosModif);
except
 REsult:=false;
  TableRestoreEtatFiltre(DMProg.TaGestDosModif,EtatFiltre);
 Showmessage('Erreur lors de l''effacement de l''exercice !');
end;
End;



procedure TDMProg.DMProgCreate(Sender: TObject);
begin
 OuvrirTouteTable('',TControl(self));
end;

{ La création des dossiers et exercices se fait en 2 temps :
 On créé d'abord le dossier, si ok, alors on poste les données du dossier
  même si la création de l'exercice se fait immédiatement !
  donc, lors de la création du premier exercice, le dataset est obligatoire en mode édition
  Lors de la création des exercices suivant, le dataset est en mode insertion, et les données du dossier
  ne sont pas recontrolé, mais dupliquées !!!
  }

Function TDMProg.CtrlSaisieNewExo(CCourant:TField):TErreurSaisie;
Begin
result.CodeErreur:=0;
Result.retour:=true;
FiltrageDataSet(DMRech.TaGestDossierRech,'ID_Dossier = '+IntTosTr(E.ID_Dos));
case CCourant.DataSet.State of
   dsInsert:Begin
             case CCourant.Index of
                1:Begin

                  End;
                2:Begin

                  End;
             end;
            End;
   dsEdit:Begin  // Création d'un premier exercice dans le dossier courant, le dossier a obligatoirement
                 // été créé avant
                 //
             FiltrageDataSet(DMrech.TaGestDossierRech,
                             'Id_Dossier='+CCOurant.dataSet.findField('Id_Dossier').AsString+
                             ' and ID_Table <> '+CCOurant.dataSet.findField('Id_Table').AsString);
             case CCourant.Index of
                // Nom_Exo
                4:Begin
                    IF Infos_TInfosGestDossier(DMrech.TaGestDossierRech,'Nom_Exo',[CCourant.asstring]).ResultInfos then
                     Begin
                       result.CodeErreur:=4001;
                       Result.retour:=False;
                       MessageDlg('Ce nom d''exercice existe déjà !',mtError,[mbOK],0);
                     End;
                    if empty(CCourant.AsString) then
                     Begin
                       result.CodeErreur:=4002;
                       Result.retour:=False;
                     End;
                    if length(CCourant.AsString) > 10 then
                     Begin
                       result.CodeErreur:=4003;
                       Result.retour:=False;
                     End;
                  End;
                // Dir_Exo
                5:Begin
                    IF Infos_TInfosGestDossier(DMrech.TaGestDossierRech,'Dir_Exo',[CCourant.asstring]).ResultInfos then
                     Begin
                       result.CodeErreur:=5001;
                       Result.retour:=False;
                       MessageDlg('Ce nom d''exercice existe déjà !',mtError,[mbOK],0);
                     End;
                    if empty(CCourant.AsString) then
                     Begin
                       result.CodeErreur:=5002;
                       Result.retour:=False;
                     End;
                    if DirectoryExists(CCOurant.dataSet.findField('Dir_Dossier').AsString+'\'+CCOurant.AsString) then
                     Begin
                       result.CodeErreur:=5003;
                       Result.retour:=False;
                       MessageDlg('Epicéa a détecté un répertoire nommé : '+RetourChariotDouble+
                                   UpperCase(CCOurant.AsString)+RetourChariotDouble+
                                   'Ce répertoire sera renommé : '+RetourChariotDouble+
                                   UpperCase(CCOurant.AsString) + 'JJ-MM-AAAA:hh:mm:ss',mtError,[mbOK],0);
                     End;

                  End;
             end;
          End;
end;

End;

// Le controle d'un dossier ne se fait que lors de l'ajout d'un nouveau dossier
// Lors de l'ajout d'un nouvel exercice, on ne recontrole pas les données concernant le dossier,
// on se contente de les dupliquer !!
Function TDMProg.CtrlSaisieNewDossier(CCourant:TField):TErreurSaisie;
var
DetailDate:TDetailDate;
DetailTime:TDetailTime;
Begin
result.CodeErreur:=0;
Result.retour:=true;
case CCourant.DataSet.State of
   dsInsert:Begin
             // création d'un nouveau dossier
             // le controle d'un nouvel exo se fait dans CtrlNewExo
             DeFiltrageDataSet(DMREch.TaGestDossierRech);
             case CCourant.Index of
                2:Begin
                    IF Infos_TInfosGestDossier(DMREch.TaGestDossierRech,'Nom_Dossier',[CCourant.asString]).ResultInfos then
                     Begin
                      result.CodeErreur:=2001;
                      Result.retour:=False;
//                      ShowMEssage('Attention, le Dossier : '+CCourant.AsString+' existe déjà !');
                     End;
                    if empty(CCourant.AsString) then
                     Begin
                       result.CodeErreur:=2002;
                       Result.retour:=False;
                     End;
                  End;
                3:Begin
                    IF Infos_TInfosGestDossier(DMREch.TaGestDossierRech,'Dir_Dossier',[CCourant.asString]).ResultInfos then
                     Begin
                      result.CodeErreur:=3001;
                      Result.retour:=False;
                     End;
                    if empty(CCourant.AsString) then
                     Begin
                       result.CodeErreur:=3002;
                       Result.retour:=False;
                     End;

                    if DirectoryExists(CCOurant.AsString) then
                     Begin
                       result.CodeErreur:=3003;
                       Result.retour:=False;
                       DetailDate:=DateInfos(now);
                       DetailTime:=HeureInfos(Time,'-');
                       MessageDlg('Epicéa a détecté un répertoire nommé : '+RetourChariotDouble+
                                   UpperCase(CCOurant.AsString)+RetourChariotDouble+
                                   'Ce répertoire sera renommé : '+RetourChariotDouble+
                                   UpperCase(CCOurant.AsString) +'-'+ DetailDate.JourStr+'-'+DetailDate.MoisStr+'-'+DetailDate.AnStr+'-'+DetailTime.HeureStrFormate,mtError,[mbOK],0);
                       MoveFile(PChar(CCOurant.AsString),PChar(CCOurant.AsString+'-'+DetailDate.JourStr+'-'+DetailDate.MoisStr+'-'+DetailDate.AnStr+'-'+DetailTime.HeureStrFormate));
//                       if MoveFile(PChar(CCOurant.AsString),PChar(CCOurant.AsString+'-'+DetailDate.JourStr+'-'+DetailDate.MoisStr+'-'+DetailDate.AnStr+'-'+DetailTime.HeureStrFormate)) = false then
//                              Showmessage('Erreur de renommage du répertoire');
                     End;
                  End;
             end;
            End;
   dsEdit:Begin
             case CCourant.Index of
                1:Begin

                  End;
                2:Begin

                  End;
             end;
          End;
end;

End;

procedure TDMProg.TaGestDosModifBeforePost(DataSet: TDataSet);
var
i:integer;
ErreurSaisie:TErreurSaisie;
begin
try
  case DataSet.State of
     dsInsert:Begin
              try
               DeFiltrageDataSet(DMRech.TaGestDossierRech);
               for i:=0 to DataSet.FieldCount-1 do
                Begin
                 ErreurSaisie:=CtrlSaisieNewDossier(DataSet.Fields[i]);

                 if not ErreurSaisie.retour then
                 Begin
                   case ErreurSaisie.CodeErreur of
                      2001:Begin
                            ShowMEssage('Attention, le Dossier : '+DataSet.Fields[i].AsString+' existe déjà !');
                            abort;
                           End;
                      2002:begin
                            ShowMEssage('Attention, le nom du Dossier est vide !');
                            abort;
                           end;
                      3002:begin
                            ShowMEssage('Attention, le répertoire du Dossier existe déjà dans la gestion des dossiers !');
                            abort;
                           end;
                      3003:begin
//                            ShowMEssage('Attention, le répertoire du Dossier n''à pas pu être renommé !');
//                            abort;
                           end;
                   end;  // Fin du case
                 End; // Fin ErreurSaisie Dossier


                 ErreurSaisie:=CtrlSaisieNewExo(DataSet.Fields[i]);

                 if not ErreurSaisie.retour then
                 Begin
                   case ErreurSaisie.CodeErreur of
                      1: ;
                      2: ;
                   end;  // Fin du case
                 End; // Fin ErreurSaisie Exercice
                End; // fin du for

              if VerifFNumeric(DataSet.FindField('Id_Dossier')).VideOUZero then
               begin // Création nouveau dossier
                DeFiltrageDataSet(DMRech.TaGestDossierRech);
                DataSet.FindField('Id_Dossier').AsInteger:=MaxId_Query(DMRech.TaGestDossierRech,'ID_Dossier');
                if not CreeNouveauDossier(DataSet.FindField('Dir_Dossier').AsString,false,false) then
                 abort
                 else
                  if not CreeNouveauExo(DataSet.FindField('Dir_Exo').AsString,False,false) then
                   abort;
               end
               else
               begin // Création nouvel exo, mais a partir du 2 ième exo
                     // La création du premier exo est traité dans le dsEdit
                     // car il y a des traitements spéciaux lors de la création du premier exercice
                DataSet.FindField('Cloture').AsBoolean:=false;
               end;
              except
               abort;
              end;
              End; // Fin du dsInsert
     dsEdit:Begin
            End;
end;
except
 DataSet.Cancel;
 showmessage('Le dossier ou l''exercice n''ont pas pu être créée !');
 abort;
end;
end;

procedure TDMProg.QuGestDossierMenuFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
accept:=ListeDossierTableTraiteMenu.IndexOf(DataSet.FindField('ID_Dossier').AsString+DataSet.FindField('ID_Table').AsString) = -1;
end;

procedure TDMProg.QuGestDossierMenuBeforeOpen(DataSet: TDataSet);
begin
ListeDossierTableTraiteMenu:=TStringList.Create;
end;

procedure TDMProg.QuGestDossierMenuAfterClose(DataSet: TDataSet);
begin
ListeDossierTableTraiteMenu.Free;
end;

function GestDossierDatesRemplies(NomDossier,NomExo:String):boolean;
Begin
  try
    result:=true;
    if DMProg = nil then
    DMProg:=TDMProg.Create(Application);
    if not DMProg.TaGestDossierConsult.Active then DMProg.TaGestDossierConsult.Open;
    if DMProg.TaGestDossierConsult.locate('Nom_Dossier;Nom_Exo',VarArrayOf([NomDossier,NomExo]),[loCaseInsensitive]) then
      Begin
        REsult:=not ((VerifFNumeric(DMProg.TaGestDossierConsult.findfield('Exo_Saisie')).Vide)or(VerifFNumeric(DMProg.TaGestDossierConsult.findfield('Date_Deb_Exo')).Vide)or(VerifFNumeric(DMProg.TaGestDossierConsult.findfield('Date_Fin_Exo')).Vide));
      end;
  except
    result:=false;
  end;
end;

Function ChercheInfos_ExoN1(Dossier:string):TInfosGestDossier;
var
E_Tmp:TEntreprise;
begin
  Initialise_TInfosGestDossier(result);
  result.ResultInfos:=false;
    try
    if DMProg = nil then
    DMProg:=TDMProg.Create(Application);
    E_Tmp:= TEntreprise.Create(application.MainForm);
       // On verifie que le dossier en question possède 1 ou 2 exo(s) non cloturé(s) !!!!
       FiltrageDataSet(DMRech.TaGestDossierRech,CreeFiltreET(['Nom_Dossier','Cloture'],[Dossier,false]));
         if (DMRech.TaGestDossierRech.RecordCount =2) then
          begin
             DMRech.TaGestDossierRech.first;
            while ((not(DMRech.TaGestDossierRech.eof))and(result.ResultInfos=false))do
              Begin
               e.InitTEntreprise(E_Tmp);
               Remplit_TInfosGestDossier(DMRech.TaGestDossierRech,result);
               E_Tmp.NomDossier:=result.Nom_Dossier;
               E_Tmp.NomExo:=result.Nom_Exo;
               E_Tmp.DatExoDebut:=result.DATE_DEB_EXO;
               E_Tmp.DatExoFin:=result.DATE_FIN_EXO;
               E_Tmp.Regime:=e.Regime;
               E_Tmp.ExerciceBase:=e.ExerciceBase;
               E_Tmp.ExerciceSaisie:=e.ExerciceSaisie;
               E_Tmp.RepertoireDossier:=e.RepertoireDossier;
               E_Tmp.RepertoireExercice:=e.RepertoireExercice;
               E_Tmp.RepertoireProgram:=e.RepertoireProgram;
               
                if not GEstDossierExerciceEnCoursCloturable(E_Tmp) then
                  Begin
                    result.ResultInfos:=true;
                  end;
                DMRech.TaGestDossierRech.next;
              end;
          end
       else
          begin
            result.ResultInfos:=false;
          end;
    finally
     DeFiltrageDataSet(DMRech.TaGestDossierRech);
     E_Tmp.Free;
     if result.ResultInfos=false then Initialise_TInfosGestDossier(result);
    end;//fin du try
end;

Function ChercheInfos_ExoMoinsN1(Dossier:string):TInfosGestDossier;
var
E_Tmp:TEntreprise;
begin
  Initialise_TInfosGestDossier(result);
  result.ResultInfos:=false;
    try
    if DMProg = nil then
    DMProg:=TDMProg.Create(Application);
    E_Tmp:= TEntreprise.Create(application.MainForm);

       FiltrageDataSet(DMRech.TaGestDossierRech,CreeFiltreET(['Nom_Dossier','DATE_FIN_EXO'],[Dossier,DateToStr_SQL(e.DatExoDebut-1)]));
         if (DMRech.TaGestDossierRech.RecordCount =1) then
          begin
             DMRech.TaGestDossierRech.first;
            while ((not(DMRech.TaGestDossierRech.eof))and(result.ResultInfos=false))do
              Begin
               e.InitTEntreprise(E_Tmp);
               Remplit_TInfosGestDossier(DMRech.TaGestDossierRech,result);
               E_Tmp.NomDossier:=result.Nom_Dossier;
               E_Tmp.NomExo:=result.Nom_Exo;
               E_Tmp.DatExoDebut:=result.DATE_DEB_EXO;
               E_Tmp.DatExoFin:=result.DATE_FIN_EXO;
               E_Tmp.Regime:=e.Regime;
               E_Tmp.ExerciceBase:=e.ExerciceBase;
               E_Tmp.ExerciceSaisie:=e.ExerciceSaisie;
               E_Tmp.RepertoireDossier:=e.RepertoireDossier;
               E_Tmp.RepertoireExercice:=e.RepertoireExercice;
               E_Tmp.RepertoireProgram:=e.RepertoireProgram;
               
                if not GEstDossierExerciceEnCoursCloturable(E_Tmp) then
                  Begin
                    result.ResultInfos:=true;
                  end;
                DMRech.TaGestDossierRech.next;
              end;
          end
       else
          begin
            result.ResultInfos:=false;
          end;
    finally
     DeFiltrageDataSet(DMRech.TaGestDossierRech);
     E_Tmp.Free;
     if result.ResultInfos=false then Initialise_TInfosGestDossier(result);
    end;//fin du try
end;

Function ChercheInfos_ExoSurDate(Dossier:string;Date : Tdate):TInfosGestDossier;
var
E_Tmp:TEntreprise;
filtre:string;
begin
  Initialise_TInfosGestDossier(result);
  result.ResultInfos:=false;
    try
    if DMProg = nil then
    DMProg:=TDMProg.Create(Application);
    E_Tmp:= TEntreprise.Create(application.MainForm);
    filtre:='Nom_Dossier = '''+Dossier+''' and DATE_FIN_EXO >= '''+DateToStr_SQL(Date-1)+''' and DATE_DEB_EXO <= '''+DateToStr_SQL(Date-1)+'''';
       FiltrageDataSet(DMRech.TaGestDossierRech,filtre);
         if (DMRech.TaGestDossierRech.RecordCount =1) then
          begin
             DMRech.TaGestDossierRech.first;
            while ((not(DMRech.TaGestDossierRech.eof))and(result.ResultInfos=false))do
              Begin
               e.InitTEntreprise(E_Tmp);
               Remplit_TInfosGestDossier(DMRech.TaGestDossierRech,result);
               E_Tmp.NomDossier:=result.Nom_Dossier;
               E_Tmp.NomExo:=result.Nom_Exo;
               E_Tmp.DatExoDebut:=result.DATE_DEB_EXO;
               E_Tmp.DatExoFin:=result.DATE_FIN_EXO;
               E_Tmp.Regime:=e.Regime;
               E_Tmp.ExerciceBase:=e.ExerciceBase;
               E_Tmp.ExerciceSaisie:=e.ExerciceSaisie;
               E_Tmp.RepertoireDossier:=e.RepertoireDossier;
               E_Tmp.RepertoireExercice:=e.RepertoireExercice;
               E_Tmp.RepertoireProgram:=e.RepertoireProgram;
               
                if not GEstDossierExerciceEnCoursCloturable(E_Tmp) then
                  Begin
                    result.ResultInfos:=true;
                  end;
                DMRech.TaGestDossierRech.next;
              end;
          end
       else
          begin
            result.ResultInfos:=false;
          end;
    finally
     DeFiltrageDataSet(DMRech.TaGestDossierRech);
     E_Tmp.Free;
     if result.ResultInfos=false then Initialise_TInfosGestDossier(result);
    end;//fin du try
end;


Function ChercheInfos_ExoN(Dossier:string):TInfosGestDossier;
var
E_Tmp:TEntreprise;
begin
  Initialise_TInfosGestDossier(result);
  result.ResultInfos:=false;
    try
    if DMProg = nil then
    DMProg:=TDMProg.Create(Application);
       // On verifie que le dossier en question possède 1 ou 2 exo(s) non cloturé(s) !!!!
       FiltrageDataSet(DMRech.TaGestDossierRech,CreeFiltreET(['Nom_Dossier','Cloture'],[Dossier,false]));
         if (DMRech.TaGestDossierRech.RecordCount >0) then
          begin
             DMRech.TaGestDossierRech.first;
            while ((not(DMRech.TaGestDossierRech.eof))and(result.ResultInfos=false))do
              Begin
               E_Tmp:= TEntreprise.Create(application.MainForm);
               e.InitTEntreprise(E_Tmp);
               Remplit_TInfosGestDossier(DMRech.TaGestDossierRech,result);
               E_Tmp.NomDossier:=result.Nom_Dossier;
               E_Tmp.NomExo:=result.Nom_Exo;
               E_Tmp.DatExoDebut:=result.DATE_DEB_EXO;
               E_Tmp.DatExoFin:=result.DATE_FIN_EXO;
               E_Tmp.Regime:=e.Regime;
               E_Tmp.ExerciceBase:=e.ExerciceBase;
               E_Tmp.ExerciceSaisie:=e.ExerciceSaisie;
               E_Tmp.RepertoireDossier:=e.RepertoireDossier;
               E_Tmp.RepertoireExercice:=e.RepertoireExercice;
               E_Tmp.RepertoireProgram:=e.RepertoireProgram;
                if GEstDossierExerciceEnCoursCloturable(E_Tmp) then
                  Begin
                    result.ResultInfos:=true;
                  end;
                DMRech.TaGestDossierRech.next;
              end;
          end
       else
          begin
            result.ResultInfos:=false;
          end;
    finally
     DeFiltrageDataSet(DMRech.TaGestDossierRech);
     E_Tmp.Free;
     if result.ResultInfos=false then Initialise_TInfosGestDossier(result);
    end;//fin du try
end;




procedure TDMProg.DataModuleDestroy(Sender: TObject);
begin
DMProg := nil;
end;


Function TDMProg.SauveGestDossierFichier(NomDossier:String;RepDossier:String):Boolean;
var
FichierDos:file;
Buffer:TFileGestDossier;
NomFichierDos:String;
InfosGestDossier:TInfosGestDossier;
GDossierExiste:boolean;
RaisonSociale:string;
Begin
try
 try
  TaGDossier.Close;
  DMRech.TaGDossierRech.Close;

  if(RepDossier='')then RepDossier:=e.RepertoireDossier;

  GDossierExiste:=FileExists(IncludeTrailingPathDelimiter(RepDossier)+'GDossier.DB');{ isa  le  22/10/04 }

  if GDossierExiste then
  begin
  TaGDossier.EmptyTable;
  DeFiltrageDataSet(TaGDossier);
  if TaGDossier.RecordCount > 0 then
   begin
    MessageDlg('DMProg.SauveGestDossierFichier:La Table GDossier n''a pas été vidée !', mtError, [mbOK], 0);
    result := false;
    abort;
   end;
  end;


  QuGEstDossier.Close;
  QuGEstDossier.SQL.Clear;
  QuGEstDossier.SQL.Add(' Select * from GEstDossier.db ');
  QuGEstDossier.SQL.Add(' where Nom_Dossier =:NomDos ');
  QuGEstDossier.SQL.Add(' order by ID_Table ');
  QuGEstDossier.Params[0].DataType := ftString;
  QuGEstDossier.Params[0].AsString := NomDossier;
  QuGEstDossier.Open;
  QuGEstDossier.First;
  if QuGEstDossier.findField('ID_Dossier').AsInteger >= 0 then
   begin
      NomFichierDos:=QuGEstDossier.findField('Dir_Dossier').AsString+'\'+QuGEstDossier.findField('Nom_Dossier').AsString+'.epi';
      AssignFile(FichierDos,NomFichierDos);

      if not empty(NomFichierDos) then
       begin
        if FileExists(NomFichierDos) then
         deletefile(NomFichierDos);
       end
       else
        begin
          Showmessage('SauveGestDossierFichier : erreur lors de la récupération du nom du dossier');
          abort;
        end;

       Rewrite(FichierDos,SizeOF(Buffer));
      while not QuGEstDossier.Eof do
      begin
       Remplit_TInfosGestDossier(QuGestDossier,InfosGestDossier);
       if not empty(InfosGestDossier.DESIGNATION_DOSSIER)then RaisonSociale:=InfosGestDossier.DESIGNATION_DOSSIER;
       try
         Buffer.CLe_Dossier:=DMXml.RetourneValItemProgramme('QueryUser2');
       except
          Buffer.CLe_Dossier:=C_ValeurCleVide;
       end;
       // Partie Fichier Texte .epi
       Buffer.Annee_Dossier :=DAteInfos(InfosGestDossier.Annee_Dossier).DateStr;
       Buffer.Cloture := str_bool2str_LGR(InfosGestDossier.Cloture,'Vrai','Faux');
       Buffer.DateUtil:=DAteInfos(InfosGestDossier.DateUtil).DateStr;
       Buffer.DATE_DEB_EXO:=DAteInfos(InfosGestDossier.DATE_DEB_EXO).DateStr;
       Buffer.DATE_FIN_EXO:=DAteInfos(InfosGestDossier.DATE_FIN_EXO).DateStr;
       Buffer.Dir_Dossier := InfosGestDossier.Dir_Dossier;
       Buffer.Dir_Exo :=InfosGestDossier.Dir_Exo;
       Buffer.EXO_BASE := InfosGestDossier.EXO_BASE;
       Buffer.EXO_SAISIE := InfosGestDossier.EXO_SAISIE;
       Buffer.ID_Dossier := IntToStr(InfosGestDossier.ID_Dossier);
       Buffer.ID_Table := IntToStr(InfosGestDossier.ID_Table);
       Buffer.Nom_Dossier := InfosGestDossier.Nom_Dossier;
       Buffer.Nom_Exo := InfosGestDossier.Nom_Exo;
       if StrToint(Buffer.ID_Dossier) > 0 then
       BlockWrite(FichierDos,Buffer,1);

       if GDossierExiste then
         begin
             TaGDossier.Insert;
             TaGDossier.FindField('ID_Dossier').AsInteger:=InfosGestDossier.ID_Dossier;
             TaGDossier.FindField('ID_Table').AsInteger:=InfosGestDossier.ID_Table;
             TaGDossier.FindField('Nom_Dossier').AsString:=InfosGestDossier.Nom_Dossier;
             TaGDossier.FindField('Dir_Dossier').AsString:=InfosGestDossier.Dir_Dossier;
             TaGDossier.FindField('Nom_Exo').AsString:=InfosGestDossier.Nom_Exo;
             TaGDossier.FindField('Dir_Exo').AsString:=InfosGestDossier.Dir_Exo;
             TaGDossier.FindField('Annee_Dossier').AsDateTime:=InfosGestDossier.Annee_Dossier;
             TaGDossier.FindField('DateUtil').AsDateTime:=InfosGestDossier.DateUtil;
             TaGDossier.FindField('Cloture').Asboolean:=InfosGestDossier.Cloture;
             TaGDossier.FindField('EXO_BASE').AsString:=InfosGestDossier.EXO_BASE;
             TaGDossier.FindField('EXO_SAISIE').AsString:=InfosGestDossier.EXO_SAISIE;
             TaGDossier.FindField('DATE_DEB_EXO').AsDateTime:=InfosGestDossier.DATE_DEB_EXO;
             TaGDossier.FindField('DATE_FIN_EXO').AsDateTime:=InfosGestDossier.DATE_FIN_EXO;
             TaGDossier.FindField('DESIGNATION_DOSSIER').AsString:=RaisonSociale;
             //TaGDossier.FindField('DESIGNATION_DOSSIER').AsString:=InfosGestDossier.DESIGNATION_DOSSIER;
             TableGerePost(TaGDossier);
         end;
       QuGEstDossier.Next;
      end;
      end; // Fin du if
     Finally
     if QuGEstDossier <> nil then
      QuGEstDossier.Close;
      try
        {$I-}
        Reset(FichierDos);
        {$I+}
        if IOResult =0 then
          closeFile(FichierDos);
      except

      end;
     end;
except

end;
End;

Function LitGestDossierFichier(NomFichier:String;Var E_Tmp:TEntreprise;SauveGardeDeSecours:Boolean):Boolean;
var
FichierDos:File;
Buffer:TFileGestDossier;
//NomFichierDos:String;
InfosGestDossier:TInfosGestDossier;
i,IdDossierTmp:integer;
DossierExisteDsGEstDossier,DossierIdentique:Boolean;
DirDossierImporte,NomFichierDossier:String;
NomRepProgramme:String;
ListeDossier:TStringList;
Begin
    if DMProg = nil then
    DMProg:=TDMProg.Create(Application);
//showmessage('Nom du Fichier'+NomFichier);
DossierExisteDsGEstDossier:=false;
DossierIdentique:=False;
 try
  DirDossierImporte:=ExtractFilePath(NomFichier);
  NomFichierDossier :=ExtractFileName(NomFichier);
  if not FileExistDialog(DirDossierImporte,NomFichierDossier,true) then
//  if empty(NomFichier) then
   begin
    NomRepProgramme:= E_tmp.RepertoireProgram;
    if ChercheFileDialog(NomRepProgramme,NomFichier,'Fichiers dossier Epicéa2(*.epi)|*.epi',true,'') then
      AssignFile(FichierDos,NomRepProgramme+NomFichier);
   end
   else
   begin
    if FileExists(DirDossierImporte+NomFichierDossier) then
       AssignFile(FichierDos,DirDossierImporte+NomFichierDossier);
//        showmessage('LEcture du Fichier : '+NomFichier);
   end;

  if empty(NomFichier) then
   begin
//      showmessage('le nom du fichier est vide');
      abort;
    end;
  i:=SizeOf(Buffer);
  reset(FichierDos,i);
  BlockRead(FichierDos,Buffer,1);
        //  showmessage('LEcture du Fichier');
   DeFiltrageDataSet(DMRech.TaGestDossierRech);
   InfosGestDossier:=Infos_TInfosGestDossier(DMRech.TaGestDossierRech,'Nom_Dossier',[Buffer.Nom_Dossier]);

  if InfosGestDossier.ResultInfos then
   begin
   // Vérifier que les données trouvé dans le fichier GEstDos.epi sont identique
   // aux données présentent de GestDossier.db
   // Pour l'instant le controle porte sur le nom et le repertoire du dossier
   // Il faudrait utiliser la cle de protection du dossier pour faire se controle !!!!!
    DossierExisteDsGEstDossier:=copy(UpperCase(Buffer.Dir_Dossier),LastDelimiter('\',Buffer.Dir_Dossier),Length(Buffer.Dir_Dossier)) =
                                copy(UpperCase(InfosGestDossier.Dir_Dossier),LastDelimiter('\',InfosGestDossier.Dir_Dossier),Length(InfosGestDossier.Dir_Dossier));

    if DossierExisteDsGEstDossier then
     begin
      DossierExisteDsGEstDossier:=UpperCase(InfosGestDossier.Nom_Dossier) = UpperCase(Buffer.Nom_Dossier);
      DossierIdentique:=DossierExisteDsGEstDossier;
      FiltrageDataSet(DMRech.TaGestDossierRech,'Nom_Dossier = '''+Buffer.Nom_Dossier+'''');
      DMRech.TaGestDossierRech.First;
      Seek(FichierDos,0);
      DirDossierImporte := ExcludeTrailingPathDelimiter(DirDossierImporte);
      while ((not Eof(FichierDos)) and (DossierIdentique)) do
      begin
        BlockRead(FichierDos,Buffer,1);
//        if str_fini_par(DirDossierImporte,'\') then
//          DirDossierImporte:=str_Suppr_N_Car_ADroite(DirDossierImporte,1);
//        DateInfos(date).DateStrFormat;
        DossierIdentique :=((DMRech.TaGestDossierRech.FindField('ID_Dossier').AsString = Buffer.ID_Dossier) and
                           (DMRech.TaGestDossierRech.FindField('ID_Table').AsString = Buffer.ID_Table) and
                           (UpperCase(DMRech.TaGestDossierRech.FindField('Nom_Dossier').AsString) = UpperCase(Buffer.Nom_Dossier)) and
                           (UpperCase(DMRech.TaGestDossierRech.FindField('Dir_Dossier').AsString) = UpperCase(DirDossierImporte)) and
                           (UpperCase(DMRech.TaGestDossierRech.FindField('Nom_Exo').AsString) = UpperCase(Buffer.Nom_Exo)) and
                           (UpperCase(DMRech.TaGestDossierRech.FindField('Dir_Exo').AsString) = UpperCase((IncludeTrailingPathDelimiter(DirDossierImporte) + Buffer.Nom_Exo))) and
                           (DateInfos(DMRech.TaGestDossierRech.FindField('Annee_Dossier').AsDateTime).DateStrFormat = Buffer.Annee_Dossier) and
                           (DateInfos(DMRech.TaGestDossierRech.FindField('DateUtil').AsDateTime).DateStrFormat = Buffer.DateUtil) and
                           (DMRech.TaGestDossierRech.FindField('Cloture').AsBoolean = (Buffer.Cloture = 'Vrai')) and
                           (DMRech.TaGestDossierRech.FindField('EXO_BASE').AsString = Buffer.EXO_BASE) and
                           (DMRech.TaGestDossierRech.FindField('EXO_SAISIE').AsString = Buffer.EXO_SAISIE) and
                           (DateInfos(DMRech.TaGestDossierRech.FindField('DATE_DEB_EXO').AsDateTime).DateStrFormat = Buffer.DATE_DEB_EXO) and
                           (DateInfos(DMRech.TaGestDossierRech.FindField('DATE_FIN_EXO').AsDateTime).DateStrFormat = Buffer.DATE_FIN_EXO));
//      showmessage(DateInfos(DMRech.TaGestDossierRech.FindField('DATE_DEB_EXO').AsDateTime).DateStrFormat);
        DMRech.TaGestDossierRech.Next;
        if DossierIdentique then DossierIdentique :=Eof(FichierDos)=DMRech.TaGestDossierRech.eof;//isa le 10/12/2008
//        Showmessage(str_bool2str(DossierIdentique));
      end;
     end;
   end;
  if DossierExisteDsGEstDossier then
   begin
//    AfficheInfoObjet('Info dossier',E,true);
    E_Tmp.NomDossier := Buffer.Nom_Dossier;
    E_Tmp.NomExo := Buffer.Nom_Exo;
    E_Tmp.RepertoireDossier := IncludeTrailingPathDelimiter(Buffer.Dir_Dossier);
    E_Tmp.RepertoireExercice := IncludeTrailingPathDelimiter(Buffer.Dir_Exo);
    E_Tmp.ID_Dos := StrToInt(Buffer.ID_Dossier);
    E_Tmp.ID_Exo := StrToInt(Buffer.ID_Table);
//    AfficheInfoObjet('Info dossier',E,true);
//    showmessage('Le dossier est trouvé');
//    ListeDossier:=TStringList.Create;
//    ListeDossier.Add()
    if not DossierIdentique then
     begin
      // Le Dossier existe dans Epicéa, mais comporte des différences entre GestDossier et le fichier .epi
      // On propose de sauver le dossier courant et ensuite on détruit le dossier courant pour le remplacer par le dossier que l'on est en train d'ouvrir
      if SauveGardeDeSecours then
       begin
       //enlever suite à demande de Denis le 08 Avril 2009 car ça ne sert à rien de faire une sauvegarde
       //en ouvrant avec le .epi ou MDcogere car la restauration à déjà été faite dans ces 2 cas
//        if MessageDlg('Voulez-Vous faire une sauvegarde de secours avant d''importer '+#13+#10+'le dossier ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
//        SauveDossier(nil,'','','-SauvegardeAvantImportationDossier');
       end;
      // Destruction du dossier courant
      GEstDossierSuppressionDossier(E_Tmp.NomDossier);
//      // Renommage pour DosTmp ...
//      RenommeDossier(ExcludeTrailingPathDelimiter(E_Tmp.RepertoireDossier),ExcludeTrailingPathDelimiter(E_Tmp.RepertoireDossier)+'_TMP');
      // Création dans GestDossier du dossier que l'on importe du .epi
      DeFiltrageDataSet(DMRech.TaGestDossierRech);
      IdDossierTmp := MaxId_Query(DMRech.TaGestDossierRech,'ID_Dossier');
      Seek(FichierDos,0);
      while not Eof(FichierDos) do
      begin
        BlockRead(FichierDos,Buffer,1);
        if not DMRech.TaGestDossierRech.Active then DMRech.TaGestDossierRech.Open;
        DMRech.TaGestDossierRech.Insert;
        if str_fini_par(DirDossierImporte,'\') then
          DirDossierImporte:=str_Suppr_N_Car_ADroite(DirDossierImporte,1);
        DMRech.TaGestDossierRech.FindField('ID_Dossier').AsInteger := IdDossierTmp;
        DMRech.TaGestDossierRech.FindField('ID_Table').AsString := Buffer.ID_Table;
        DMRech.TaGestDossierRech.FindField('Nom_Dossier').AsString := Buffer.Nom_Dossier;
        DMRech.TaGestDossierRech.FindField('Dir_Dossier').AsString := DirDossierImporte;
        DMRech.TaGestDossierRech.FindField('Nom_Exo').AsString := Buffer.Nom_Exo;
        DMRech.TaGestDossierRech.FindField('Dir_Exo').AsString := IncludeTrailingPathDelimiter(DirDossierImporte) + Buffer.Nom_Exo;
        DMRech.TaGestDossierRech.FindField('Annee_Dossier').AsString := Buffer.Annee_Dossier;
        DMRech.TaGestDossierRech.FindField('DateUtil').AsString := Buffer.DateUtil;
        DMRech.TaGestDossierRech.FindField('Cloture').AsBoolean := (Buffer.Cloture = 'Vrai');
        DMRech.TaGestDossierRech.FindField('EXO_BASE').AsString := Buffer.EXO_BASE;
        DMRech.TaGestDossierRech.FindField('EXO_SAISIE').AsString := Buffer.EXO_SAISIE;
        DMRech.TaGestDossierRech.FindField('DATE_DEB_EXO').AsString := Buffer.DATE_DEB_EXO;
        DMRech.TaGestDossierRech.FindField('DATE_FIN_EXO').AsString := Buffer.DATE_FIN_EXO;
        DMRech.TaGestDossierRech.Post;
        DMRech.TaGestDossierRech.FlushBuffers;

  //      showmessage(Buffer.Nom_Exo+' '+Buffer.CLe_Dossier);
      end;
     end
    else
     begin
     end;
    E_Tmp.NomDossier := Buffer.Nom_Dossier;
    E_Tmp.NomExo := Buffer.Nom_Exo;
    E_Tmp.RepertoireDossier := IncludeTrailingPathDelimiter(Buffer.Dir_Dossier);
    E_Tmp.RepertoireExercice := IncludeTrailingPathDelimiter(Buffer.Dir_Exo);
    E_Tmp.ID_Dos := StrToInt(Buffer.ID_Dossier);
    E_Tmp.ID_Exo := StrToInt(Buffer.ID_Table);
   end
  else
   Begin
   if MessageDlg('Attention,'+
                 #13+#10+
                 'le dossier - '+
                 Buffer.Nom_Dossier +
                 ' - n''existe pas dans la gestion des dossiers.'+
                 #13+#10+
                 'Êtes-Vous sûr de vouloir l''ajouter ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
    // traiter ici le fait qu'un dossier à été créée avec un autre Epicéa

    IdDossierTmp := MaxId_Query(DMRech.TaGestDossierRech,'ID_Dossier')
    else IdDossierTmp := MinId_Query(DMRech.TaGestDossierRech,'ID_Dossier');
//    DirDossierImporte:=E.RepertoireProgram;
//    DirDossierImporte:=ExtractFileDir(E.RepertoireProgram+NomFichier);
    Seek(FichierDos,0);
    while not Eof(FichierDos) do
    begin
      BlockRead(FichierDos,Buffer,1);
      if not DMRech.TaGestDossierRech.Active then DMRech.TaGestDossierRech.Open;
      DMRech.TaGestDossierRech.Insert;
      if str_fini_par(DirDossierImporte,'\') then
        DirDossierImporte:=str_Suppr_N_Car_ADroite(DirDossierImporte,1);
      DMRech.TaGestDossierRech.FindField('ID_Dossier').AsInteger := IdDossierTmp;
      DMRech.TaGestDossierRech.FindField('ID_Table').AsString := Buffer.ID_Table;
      DMRech.TaGestDossierRech.FindField('Nom_Dossier').AsString := Buffer.Nom_Dossier;
      DMRech.TaGestDossierRech.FindField('Dir_Dossier').AsString := DirDossierImporte;
      DMRech.TaGestDossierRech.FindField('Nom_Exo').AsString := Buffer.Nom_Exo;
      DMRech.TaGestDossierRech.FindField('Dir_Exo').AsString := IncludeTrailingPathDelimiter(DirDossierImporte) + Buffer.Nom_Exo;
      DMRech.TaGestDossierRech.FindField('Annee_Dossier').AsString := Buffer.Annee_Dossier;
      DMRech.TaGestDossierRech.FindField('DateUtil').AsString := Buffer.DateUtil;
      DMRech.TaGestDossierRech.FindField('Cloture').AsBoolean := (Buffer.Cloture = 'Vrai');
      DMRech.TaGestDossierRech.FindField('EXO_BASE').AsString := Buffer.EXO_BASE;
      DMRech.TaGestDossierRech.FindField('EXO_SAISIE').AsString := Buffer.EXO_SAISIE;
      DMRech.TaGestDossierRech.FindField('DATE_DEB_EXO').AsString := Buffer.DATE_DEB_EXO;
      DMRech.TaGestDossierRech.FindField('DATE_FIN_EXO').AsString := Buffer.DATE_FIN_EXO;
      DMRech.TaGestDossierRech.Post;
      DMRech.TaGestDossierRech.FlushBuffers;

//      showmessage(Buffer.Nom_Exo+' '+Buffer.CLe_Dossier);
    end;
    DossierExisteDsGEstDossier:= true;
    if DossierExisteDsGEstDossier then
     begin
      E_Tmp.NomDossier := Buffer.Nom_Dossier;
      E_Tmp.NomExo := Buffer.Nom_Exo;
      E_Tmp.RepertoireDossier := IncludeTrailingPathDelimiter(Buffer.Dir_Dossier);
      E_Tmp.RepertoireExercice := IncludeTrailingPathDelimiter(Buffer.Dir_Exo);
      E_Tmp.ID_Dos := StrToInt(Buffer.ID_Dossier);
      E_Tmp.ID_Exo := StrToInt(Buffer.ID_Table);
     end;
   End;
 Finally
  try
   closeFile(FichierDos);
  except

  end;
 end;
End;

Procedure test;
var

FromF,ToF:file;
NumRead,NumWritten:Integer;
Buf:array[1..2048]of Char;
begin
//if OpenDialog1.Executethen {Affichage de la boîte de dialogue d'ouverture }
begin
AssignFile(FromF,'tt');
Reset(FromF,1);	{Taille d'enregistrement =1 }
if true then      {Affichage de la boîte de dialogue d'enregistrement}
begin
AssignFile(ToF,'tt');	{Ouverture du fichier de sortie }

Rewrite(ToF,1);	{Taille d'enregistrement =1 }
//Canvas.TextOut(10,10,'Copie de '+IntToStr(FileSize(FromF))
//+'octets...');
repeat
BlockRead(FromF,Buf,SizeOf(Buf),NumRead);
BlockWrite(ToF,Buf,NumRead,NumWritten);
until (NumRead =0)or(NumWritten <>NumRead);
CloseFile(FromF);
CloseFile(ToF);
end;
end;
end;



procedure TDMProg.TaGestDosModifAfterPost(DataSet: TDataSet);
begin
DeFiltrageDataSet(DMRech.TaGestDossierRech);
end;

constructor TExercice.Create;
    //constructeur
begin
  inherited Create;
end;

destructor TExercice.Destroy;
//destructeur
begin
  inherited Destroy;
end;

end.
