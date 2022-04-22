unit UniteCorrection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, Grids, DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid,
  RXCtrls, jpeg, ExtCtrls,
  LibZoneSaisie,
  DMImmos,
  Gr_Librairie_Obj,
  LibGestionParamXML,
  LibSQL,
  DMConstantes,
  DBTables,
  ReindexationTable,
  E2_Librairie_Obj,
  E2_Decl_Records,
  lib_chaine,
  LibFichRep,
  ShellAPI,
  DMImmo_Clot,
  LibDates,
  Gauges,
  LibRessourceString,DiversProjets,
  DMCorrection, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP;

type

  TParamAffichageCorrection = Record
   Affiche:Boolean;
   AffichageModal:Boolean;
   Quand:Integer;
   DateDeb,DateFin:Tdate;
   DemandePeriode:boolean;
   TitreForm:String;
   SousTitreForm:String;
   end;

  TUniteCorrections = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaBas: TPanel;
    PaTitrePetit: TPanel;
    PaBtn: TPanel;
    BtnFermer: TButton;
    BtnAnnuler: TButton;
    PopupMenu1: TPopupMenu;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    Panel1: TPanel;
    RxLabel2: TRxLabel;
    BtnControlPointage: TButton;
    BtnRecalculPointage: TButton;
    RxLabel4: TRxLabel;
    BtnBalance: TButton;
    RxLabel3: TRxLabel;
    BtnLibelleTiers: TButton;
    RxLabel1: TRxLabel;
    BtnTransfert: TButton;
    RxLabAdresse: TRxLabel;
    BtnCorrectionImmos: TButton;
    BtnRecalcul: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    RxLabel5: TRxLabel;
    BtnToutControler: TButton;
    RxLabel6: TRxLabel;
    BtnReindexation: TButton;
    RxLabel7: TRxLabel;
    BtnPiece: TButton;
    BtnChgtReference: TButton;
    RxLabel8: TRxLabel;
    BtnPlanComptable: TButton;
    RxLabel9: TRxLabel;
    BtnAnalytique: TButton;
    Gauge1: TGauge;
    BtnDerogatoire: TButton;
    Button1: TButton;
    RxLabel10: TRxLabel;
    BtnBalanceTiers: TButton;
    IdHTTP1: TIdHTTP;
    BtnEcritures: TButton;
    BtnControlPointageTiers: TButton;
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnTransfertClick(Sender: TObject);
    procedure BtnRecalculClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    Procedure GestionInitDM;
    procedure BtnCorrectionImmosClick(Sender: TObject);
    procedure BtnControlPointageClick(Sender: TObject);
    procedure BtnRecalculPointageClick(Sender: TObject);
    procedure BtnLibelleTiersClick(Sender: TObject);
    procedure BtnBalanceClick(Sender: TObject);
    procedure BtnToutControlerClick(Sender: TObject);
    procedure BtnReindexationClick(Sender: TObject);
    procedure BtnPieceClick(Sender: TObject);
    procedure BtnChgtReferenceClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    Procedure GereAccesEcran;
    procedure BtnPlanComptableClick(Sender: TObject);
    procedure BtnDerogatoireClick(Sender: TObject);
    procedure BtnAnalytiqueClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BtnBalanceTiersClick(Sender: TObject);
    procedure BtnEcrituresClick(Sender: TObject);
    procedure BtnControlPointageTiersClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    TitreForm,SousTitreForm:String;
    Quand:Integer;
    DateDeb,DateFin:Tdate;
    DemandePeriode:boolean;
  end;

var
  UniteCorrections: TUniteCorrections;

  Function CorrectionAffiche(ParamAffichageCorrection:TParamAffichageCorrection):Boolean;

implementation

uses LibClassObjetSenders, DMRecherche, DMXMLs,E2_GestSauvegarde,
  ImportDll;

{$R *.dfm}

procedure TUniteCorrections.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TUniteCorrections.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TUniteCorrections.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnFermer],PaBtn,90,0);
end;

procedure TUniteCorrections.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TUniteCorrections.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
self.close;
end;

procedure TUniteCorrections.BtnFermerClick(Sender: TObject);
begin
self.close;
end;

procedure TUniteCorrections.BtnTransfertClick(Sender: TObject);
begin
if CorrectionDesTvaCode.retour then
  Application.MessageBox(Pchar('Le transfert du code TVA  A2 vers le code  A1 '+#13+#10+' s''est bien déroulé.'),'Terminé avec succès',MB_ICONINFORMATION)
  //MessageDlg('Le transfert du code TVA  A2 vers le code  A1 '+#13+#10+' s''est bien déroulé.', mtWarning, [mbOK], 0)
else
  BtnTransfert.SetFocus;  
end;

procedure TUniteCorrections.BtnRecalculClick(Sender: TObject);
begin
if not AppelRecalculGeneralImmos.retour then
  BtnRecalcul.SetFocus;
end;

procedure TUniteCorrections.FormCreate(Sender: TObject);
begin
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;

procedure TUniteCorrections.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,E.User);
UniteCorrections:=nil;
end;


Function CorrectionAffiche(ParamAffichageCorrection:TParamAffichageCorrection):Boolean;
var
ParamDMcorrections:TParamDMcorrections;
Begin
 if (UniteCorrections = nil) then UniteCorrections:=TUniteCorrections.Create(Application.MainForm);
 if ((ParamAffichageCorrection.Quand <> UniteCorrections.Quand) and (UniteCorrections.Visible=true)) then
   UniteCorrections.Close;
 UniteCorrections.Quand:=ParamAffichageCorrection.Quand;
 if not empty(ParamAffichageCorrection.TitreForm) then
   UniteCorrections.TitreForm:=ParamAffichageCorrection.TitreForm;
 UniteCorrections.SousTitreForm:=ParamAffichageCorrection.SousTitreForm;
 UniteCorrections.DateDeb:=ParamAffichageCorrection.DateDeb;
 UniteCorrections.DateFin:=ParamAffichageCorrection.DateFin;
 UniteCorrections.DemandePeriode:=ParamAffichageCorrection.DemandePeriode;
 ParamDMcorrections.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ParamDMcorrections.Quand := UniteCorrections.Quand;

 InitialiseDMcorrections(ParamDMcorrections);
UniteCorrections.BtnChgtReference.Visible:=((Type_version_execution=CT_DEVELOPPEMENT)or(((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS')))or(e.TypeClient=cl_isa));
 if ParamAffichageCorrection.Affiche then
  begin
   if ParamAffichageCorrection.AffichageModal then
     UniteCorrections.ShowModal
    else
     UniteCorrections.Show;
  end;
End;


Procedure TUniteCorrections.GestionInitDM;
var
ParamDMcorrections:TParamDMcorrections;
Begin
 ParamDMcorrections.Quand := Quand;
 ParamDMcorrections.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 InitialiseDMcorrections(ParamDMcorrections);
 GereAccesEcran;
End;

procedure TUniteCorrections.BtnCorrectionImmosClick(Sender: TObject);
begin
if CorrectionDesImmosIncorrectes(UniteCorrections.DateDeb,UniteCorrections.DateFin,DemandePeriode).retour then
  Application.MessageBox(Pchar('Le contrôle des immobilisations est terminé'),'Terminé avec succès',MB_ICONINFORMATION)
  //MessageDlg('Le contrôle des immobilisations est terminé', mtInformation, [mbOK], 0)
else
 BtnCorrectionImmos.SetFocus;
end;

procedure TUniteCorrections.BtnControlPointageClick(Sender: TObject);
begin
 if not VerificationsDesPointagesSurComptesPointables.retour then
   BtnControlPointage.SetFocus;
end;

procedure TUniteCorrections.BtnRecalculPointageClick(Sender: TObject);
begin
if CorrectionDesPointages.retour then
  Application.MessageBox(Pchar('Le contrôle des restes à pointer s''est bien déroulé.'),'Terminé avec succès',MB_ICONINFORMATION)
  //MessageDlg('Le contrôle des restes à pointer s''est bien déroulé.', mtWarning, [mbOK], 0)
else
  BtnRecalculPointage.SetFocus;
end;

procedure TUniteCorrections.BtnLibelleTiersClick(Sender: TObject);
begin
// contrôle des Libellés
  try
    if CorrectionDesTiers_ou_Libelle(false).retour then
      Application.MessageBox(Pchar('Le contrôle des libellés est terminé.'),'Terminé avec succès',MB_ICONINFORMATION)
      //MessageDlg('Le contrôle des libellés est terminé.', mtWarning, [mbOK], 0)
    else
        raise ExceptLGR.Create('',0,false,mtError);
  except
  end;
// contrôle des tiers
  try
    if CorrectionDesTiers_ou_Libelle(true).retour then
      Application.MessageBox(Pchar('Le contrôle des tiers est terminé.'),'Terminé avec succès',MB_ICONINFORMATION)
     // MessageDlg('Le contrôle des tiers est terminé.', mtWarning, [mbOK], 0)
    else
      BtnLibelleTiers.SetFocus;
  except
  end;

end;

procedure TUniteCorrections.BtnBalanceClick(Sender: TObject);
begin
try
    if not CorrectionDeLaBalance.retour then abort;
    Application.MessageBox(Pchar('Le contrôle de la balance est terminé.'),'Terminé avec succès',MB_ICONINFORMATION);
    //MessageDlg('Le contrôle de la balance est terminé.', mtWarning, [mbOK], 0);
    if not CorrectionDeLaBalanceDesMouvements.retour then abort;
    Application.MessageBox(Pchar('Le contrôle de la balance des mouvements est terminé.'),'Terminé avec succès',MB_ICONINFORMATION);
    //MessageDlg('Le contrôle de la balance des mouvements est terminé.', mtWarning, [mbOK], 0);
    if not CorrectionDeLaBalanceDesTiers.retour then abort;
    Application.MessageBox(Pchar('Le contrôle de la balance des tiers est terminé.'),'Terminé avec succès',MB_ICONINFORMATION);
    //MessageDlg('Le contrôle de la balance des tiers est terminé.', mtWarning, [mbOK], 0);
    if not CorrectionDeLaBalanceDesQuantites(Gauge1).retour then abort;
    Application.MessageBox(Pchar('Le contrôle de la balance des quantités est terminé.'),'Terminé avec succès',MB_ICONINFORMATION);
//    MessageDlg('Le contrôle de la balance des quantités est terminé.', mtWarning, [mbOK], 0);
except
  BtnBalance.SetFocus;
end;
end;

procedure TUniteCorrections.BtnToutControlerClick(Sender: TObject);
begin
if CorrectionTotal(Gauge1).retour then
  begin
    Application.MessageBox(Pchar('Le contrôle général est terminé'),'Contrôle Terminé');
    //E.DateVersion:=C_Date+'-'+C_Version;
    E.DateVersion:=numVersion.DateVersion+'-'+numVersion.Version;
  end
else
  BtnToutControler.SetFocus;
end;

procedure TUniteCorrections.BtnReindexationClick(Sender: TObject);
var
Liste,ListeBackup,ListeDelete:Tstringlist;
i:integer;
ParamAffichageReindexation:TParamAffichageReindexation;
begin
ParamAffichageReindexation.AffichageModal:=true;
ParamAffichageReindexation.Affiche:=true;
ParamAffichageReindexation.SelectionListeTable:=nil;
ParamAffichageReindexation.dbProgram:=DMRech.TaGestDossier_OK.Database;
ParamAffichageReindexation.dbDossier:=DMRech.TaParam_DossierRech.Database;
ParamAffichageReindexation.dbExo:=DMRech.TaBalanceRech.Database;
ParamAffichageReindexation.SelectionListeTable:=TStringList.Create;
Liste := TStringList.Create;
ListeDelete:=TStringList.Create;

Session.GetTableNames(DMRech.TaParam_DossierRech.DatabaseName, '*.db',true, False, Liste);
for i:=0 to Liste.count-1 do
  if str_position_caseInsensitive('_QSQ',Liste.Strings[i])=0 then
    ParamAffichageReindexation.SelectionListeTable.Add(DMRech.TaParam_DossierRech.DatabaseName+';'+Liste.Strings[i]+'; 1');
Liste.Clear;
// Exercice
Session.GetTableNames(DMRech.TaBalanceRech.DatabaseName, '*.db',true, False, Liste);
for i:=0 to Liste.count-1 do
  if str_position_caseInsensitive('_QSQ',Liste.Strings[i])=0 then
    ParamAffichageReindexation.SelectionListeTable.Add(DMRech.TaBalanceRech.DatabaseName+';'+Liste.Strings[i]+'; 1');
Liste.Clear;
  try
      ListeBackup := TStringList.Create;
      if FileExists(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'ReindexListDef.bk')then
        begin
            ListeBackup.LoadFromFile(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'ReindexListDef.bk');
            i:=0;
            while i<ParamAffichageReindexation.SelectionListeTable.Count do
              begin
                if ListeBackup.IndexOf(uppercase(str_getstringelement(ParamAffichageReindexation.SelectionListeTable.strings[i],2,';')))=-1 then
                   ParamAffichageReindexation.SelectionListeTable.Delete(i)
                 else
                   inc(i);
              end;
        end;
  except
  end;         
//ReindexationTableProc(ParamAffichageReindexation.SelectionListeTable);
if ReindexationTableAffiche(ParamAffichageReindexation).retour then
  if not ReindexationTableProc(ParamAffichageReindexation.SelectionListeTable,Gauge1).retour then
    BtnReindexation.SetFocus;
end;

procedure TUniteCorrections.BtnPieceClick(Sender: TObject);
begin
if CorrectionDesPieces(UniteCorrections.DateDeb,UniteCorrections.DateDeb,DemandePeriode).retour then
  Application.MessageBox(Pchar('Le contrôle des pièces est terminé'),'Terminé avec succès',MB_ICONINFORMATION)
  //MessageDlg('Le contrôle des pièces est terminé', mtInformation, [mbOK], 0)
else
  BtnPiece.SetFocus;
end;

procedure TUniteCorrections.BtnChgtReferenceClick(Sender: TObject);
var
Mot:string;
MotPasse:Boolean;
begin
//showmessage('ExtractFileDir : '+ExtractFileDir(IncludeTrailingPathDelimiter(e.RepertoireExercice)+'immos.db'));
//showmessage('ExtractFilePath : '+ExtractFilePath(IncludeTrailingPathDelimiter(e.RepertoireExercice)+'immos.db'));
//showmessage('ExtractFileDrive : '+ExtractFileDrive(IncludeTrailingPathDelimiter(e.RepertoireExercice)+'immos.db'));
//showmessage('ExtractFileName : '+ExtractFileName(IncludeTrailingPathDelimiter(e.RepertoireExercice)+'immos.db'));
//showmessage('ExtractFileExt : '+ExtractFileExt(IncludeTrailingPathDelimiter(e.RepertoireExercice)+'immos.db'));
//showmessage('ExpandFileName : '+ExpandFileName(IncludeTrailingPathDelimiter(e.RepertoireExercice)+'immos.db'));
//showmessage('ExtractShortPathName : '+ExtractShortPathName(IncludeTrailingPathDelimiter(e.RepertoireExercice)+'immos.db'));
Mot:=inputbox('Saisir le mot de passe','','***');
if Mot=IntToStr(LibDates.NbDeJours(StrToDate('01/01/'+LibDates.DateInfos(Date).AnStr),Date)+82)
then
  begin
     MotPasse:=true;
     CorrectionDesimmosSurRecalculAmort(Gauge1,MotPasse,false,true);
  end
else
  if Mot='RAZ'then
  begin
     //E.DateVersion:=C_Date+'-'+C_Version;
     E.DateVersion:=numVersion.DateVersion+'-'+numVersion.Version;
     E.ControleDuDossier:=false;
     DMXml.ModifieVarDos(E.NomDossier,CXML_DateVersion,E.DateVersion);
  end;
//ControleAmort_DerogSurChangementExercice(gauge1,true);
end;

Procedure TUniteCorrections.GereAccesEcran;
begin
     //Boutons de contrôle
     EnableWinControl([BtnToutControler,BtnCorrectionImmos,BtnRecalcul,BtnRecalculPointage,
     BtnControlPointage,BtnReindexation,BtnTransfert,BtnLibelleTiers,BtnBalance,BtnPiece],not E.ExerciceCloture);
end;
procedure TUniteCorrections.FormActivate(Sender: TObject);
begin
GestionInitDM;
end;


procedure TUniteCorrections.BtnPlanComptableClick(Sender: TObject);
begin
if (CorrectionPlanComptable.retour) then
  Application.MessageBox(Pchar('Le contrôle du plan comptable s''est bien déroulé.'),'Terminé avec succès',MB_ICONINFORMATION)
else
  BtnPlanComptable.SetFocus;
end;



procedure TUniteCorrections.BtnDerogatoireClick(Sender: TObject);
begin
//if not ControleAmort_DerogSurChangementExercice(gauge1,true).retour then
//  BtnDerogatoire.SetFocus
//else
//  showmessage('Le contrôle s''est bien déroulé');
end;

procedure TUniteCorrections.BtnAnalytiqueClick(Sender: TObject);
begin
if CorrectionAnalytique.retour then
  Application.MessageBox(Pchar('Le contrôle de l''analytique s''est bien déroulé.'),'Terminé avec succès',MB_ICONINFORMATION)
else
  BtnAnalytique.SetFocus;
end;

procedure TUniteCorrections.Button1Click(Sender: TObject);
begin
//ControleAmort_DerogSurChangementExercice(gauge1,true);
//coherenceImmosReport(gauge1,true);
end;

procedure TUniteCorrections.BtnBalanceTiersClick(Sender: TObject);
begin
try
    if not CorrectionDeLaBalanceReportDesTiers.retour then abort;
    Application.MessageBox(Pchar('Le contrôle de la balance des reports des tiers est terminé.'),'Terminé avec succès',MB_ICONINFORMATION);
except
  BtnBalanceTiers.SetFocus;
end;
end;

procedure TUniteCorrections.BtnEcrituresClick(Sender: TObject);
begin
if CorrectionIdEcriture().retour then
  Application.MessageBox(Pchar('Le contrôle des écritures est terminé'),'Terminé avec succès',MB_ICONINFORMATION)
else
  BtnEcritures.SetFocus;
end;

procedure TUniteCorrections.BtnControlPointageTiersClick(Sender: TObject);
begin
 if not CorrectionDesPointages_pasMemeTiers.retour then
   BtnControlPointageTiers.SetFocus;
end;

end.

