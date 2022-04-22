unit E2_ConfirmImportCOGERE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid, ComCtrls,
  RXSlider, RXCtrls, ExtCtrls,
  Db,
  LibSQL,
  E2_Librairie_Obj,
  DMInitTablesEpi,
  E2_Decl_records,
  FRAssistant1, Menus;

type
  TConfirmImportCOGERE = class(TForm)
    FRAssistant1: TFRAssistant;
    PaFond: TPanel;
    PaListeImport: TPanel;
    PaListe: TPanel;
    RxChBImports: TRxCheckListBox;
    RxSliderImport: TRxSlider;
    PaPTitre: TPanel;
    PaListeVisu: TPanel;
    ListViewResult: TListView;
    PaListeRappImport: TPanel;
    PaSousGrille: TPanel;
    PaResultImport: TPanel;
    PaGrille: TPanel;
    DBCompareBalance: TGrDBGrid;
    PopupMenu1: TPopupMenu;
    Suppressiontotaledudossier1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RxChBImportsClickCheck(Sender: TObject);
    procedure InitIndicateurAvancement;
    procedure FRAssistant1BtnSuivantClick(Sender: TObject);
    procedure FRAssistant1PaBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Suppressiontotaledudossier1Click(Sender: TObject);
  private
    { Déclarations privées }
    CheminImport,NomFicBal,NomFicImmo:String;
    RepImportDejaValide:Boolean;
    Procedure EtapeDebut(Sender : TObject);
    Procedure Etape0(Sender : TObject);
    Procedure Etape1(Sender : TObject);
    Procedure EtapeFin(Sender : TObject);
  public
    { Déclarations publiques }
  end;

var
  ConfirmImportCOGERE: TConfirmImportCOGERE;

  Function ConfirmImportCOGEREAffiche:Boolean;

implementation

uses DMImmosOuverture, DMImportation, DMPlanCpt, DMDiocEtatBalance,
  DMRecherche, DMBaseDonnee, E2_InitTableEpi;

{$R *.dfm}

Function ConfirmImportCOGEREAffiche:Boolean;
Begin
if ConfirmImportCOGERE = nil then ConfirmImportCOGERE:=TConfirmImportCOGERE.Create(Application);
ConfirmImportCOGERE.ShowModal;
End;

Procedure TConfirmImportCOGERE.EtapeDebut(Sender : TObject);
Begin
  try
    if not RepImportDejaValide then
     begin
      E.RepertoireImportCourante:=E.RepertoireImportationSIEA;
      RepImportDejaValide:=ChoisirRepImportation(E.RepertoireImportCourante,'SIEA DOS');
      if RepImportDejaValide then
       E.RepertoireImportationSIEA := E.RepertoireImportCourante;
     end;
//      Etape0(Sender);
  except
    abort;
  end;
// Etape0(Sender);
End;

// Mise à jour du plan uniquement avec les comptes qui manquent venant de la balance
Procedure TConfirmImportCOGERE.Etape0(Sender: TObject);
var
EventBeforePost,EventBeforeInsert:TDataSetNotifyEvent;
begin
//    procedure TaPlanCptBeforeInsert_Import(DataSet: TDataSet);
//    procedure TaPlanCptBeforePost_Import(DataSet: TDataSet);
try
  try
   if ((RxChBImports.Checked[0]) and (RxSliderImport.Value = 3)) then
    begin
     Screen.Cursor := crHourGlass;
  // Section d'importation du BO SIEA
    InitDatasetEvent_A_Nil_Sur_Form([DMPlan.TaPlanCpt,DMPlan.DaPlanCpt]);
    EventBeforePost :=DMPLAn.TaPlanCptBeforePost;
    EventBeforeInsert := DMPLAn.TaPlanCptBeforeInsert;
    DMPlan.TaPlanCpt.BeforePost := DMPlan.TaPlanCptBeforePost_Import;
    DMPlan.TaPlanCpt.BeforeInsert := DMPlan.TaPlanCptBeforeInsert_Import;

//    CheminImport:=E.RepertoireImportEPI_DOS;
//    DMImport.Import_BO_SIEA_DOS_MAJCPT(DMPlan.TaPlanCpt,TRue,CheminImport,NomFicBal);
    DMImport.Import_BO_SIEA_DOS_MAJCPT(DMPlan.TaPlanCpt,TRue,E.RepertoireImportCourante,NomFicBal);
    DMPlan.GestionDesComptesObligatoireDsPlanCpt(true);

//      FormateTailleColonne(DBCompareBalance,27,[3,2,2,7,4,4,4]);
    end;
  except

  end;
finally
  Screen.Cursor := crDefault;
  RxSliderImport.Value := 2;
  RxChBImports.Checked[0]:=false;
  DMPlan.TaPlanCpt.BeforePost := EventBeforePost;
  DMPlan.TaPlanCpt.BeforeInsert := EventBeforeInsert;
//  DMPlan.TaPlanBO.Refresh;
//  DMPlan.TaPlanBO.OnCalcFields := Dmplan.TaPlanBOCalcCalcFields;
//  ReEnableControls(DMPlan.TaPlanBO);
end;
end;

Procedure TConfirmImportCOGERE.Etape1(Sender : TObject);
Begin
try
  try
  //  // Importation des immo ouverture !
   if ((RxChBImports.Checked[1]) and (RxSliderImport.Value = 2)) then
    begin
      Screen.Cursor := crHourGlass;
      if DMImmos_Ouverture = nil then DMImmos_Ouverture:=TDMImmos_Ouverture.Create(Application.MainForm);
      DMImmos_Ouverture.taDetailImmo.MasterFields := ''; // PB
      DMImmos_Ouverture.taDetailImmo.MasterSource :=nil; // PB
      E.TypeMAJBalance := MAJ_Report;
      DMImport.Import_Immo_SIEA2I(DMImmos_Ouverture.taDetailImmo,True,NomFicBal,E.RepertoireImportCourante,NomFicImmo);
////      GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMImmos_Ouverture.taDetailImmo,
////                       ['Compte','Code','Sous Code','Libellé','Date Achat','Valeur à Amortir','Type'],
////                       ['Compte','Code','Sous_Code','Libelle','Date_Achat','Valeur_a_Amortir','Type_Amt']
////                       ,E.FormatMonnaie,E.EditFormat);
////      ListViewResult.Items.Clear;
////      DMImport.AffichRapportImport(nil,ListViewResult);
////      PaResultImport.Caption := 'Résultat de l''importation des Immobilisations d''ouverture';
////      BtnCompBal.Enabled := true;
////      BtnCompBal.OnClick:=BtnCompBalImmosClick;
////      FormateTailleColonne(DBCompareBalance,27,[3,2,2,7,4,4,4]);
    end;

  except

  end;
finally
  E.TypeMAJBalance := MAJ_Normal;
  RxChBImports.Checked[1] := False;
  RxSliderImport.Value := 1;
  Screen.Cursor := crDefault;
  ReEnableControls(DMImmos_Ouverture.taDetailImmo);
end;


End;

Procedure TConfirmImportCOGERE.EtapeFin(Sender : TObject);
var
EventBeforePost,EventBeforeInsert:TDataSetNotifyEvent;
Begin
try
  try
   if ((RxChBImports.Checked[2]) and (RxSliderImport.Value = 1)) then
    begin
    if DMPlan = nil then DMPlan:=TDMPlan.Create(Application.MainForm);
     Screen.Cursor := crHourGlass;
  // Section d'importation du BO SIEA
    InitDatasetEvent_A_Nil_Sur_Form([DMPlan.TaPlanCpt,DMPlan.DaPlanCpt]);
    EventBeforePost :=DMPLAn.TaPlanCptBeforePost;
    EventBeforeInsert := DMPLAn.TaPlanCptBeforeInsert;
    DMPlan.TaPlanCpt.BeforePost := DMPlan.TaPlanCptBeforePost_Import;
    DMPlan.TaPlanCpt.BeforeInsert := DMPlan.TaPlanCptBeforeInsert_Import;
//    DMPlan.TaPlanBO.OnCalcFields := nil;
    //DMImport.Import_BO_SIEA_DOS(DMPlan.TaPlanCpt,TRue,CheminImport,NomFicBal); { isa  le  04/11/03 }
    DMImport.Import_BO_SIEA_DOS(DMPlan.TaPlanMaint,TRue,E.RepertoireImportCourante,NomFicBal);{ isa  le  04/11/03 }
//      FormateTailleColonne(DBCompareBalance,27,[3,2,2,7,4,4,4]);
    DMRech.TaPlanCptRech.Refresh;
    DMDiocEtatBal.Balance_Maj_BO_Vers_Balance(DMRech.TaPlanCptRech);
    end
   else
    Begin
     self.close;
    End;


  except

  end;
finally
  Screen.Cursor := crDefault;
  RxChBImports.Checked[2]:=false;
  DMPlan.TaPlanCpt.BeforePost := EventBeforePost;
  DMPlan.TaPlanCpt.BeforeInsert := EventBeforeInsert;
//  DMPlan.TaPlanBO.Refresh;
//  DMPlan.TaPlanBO.OnCalcFields := Dmplan.TaPlanBOCalcCalcFields;
//  ReEnableControls(DMPlan.TaPlanBO);
end;

  // Fin Section d'importation du BO SIEA
End;

procedure TConfirmImportCOGERE.FormCreate(Sender: TObject);
begin
  case Type_version_execution of
    CT_DEVELOPPEMENT:Begin
                      FRAssistant1.BtnSuivant.Enabled := True;
                     End;

    CT_DISTRIBUTION:Begin
//                      FRAssistant1.BtnSuivant.Enabled := false;
                      FRAssistant1.BtnSuivant.Enabled := True;
                    End;
    end;
 FRAssistant1.InitScenario([EtapeDebut,Etape0,Etape1],EtapeFin);

end;

procedure TConfirmImportCOGERE.FormDestroy(Sender: TObject);
begin
 ConfirmImportCOGERE := nil;
end;

procedure TConfirmImportCOGERE.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_ESCAPE then
 FRAssistant1.BtnAnnuler.Click;
end;

procedure TConfirmImportCOGERE.RxChBImportsClickCheck(Sender: TObject);
begin
 InitIndicateurAvancement;
end;

procedure TConfirmImportCOGERE.InitIndicateurAvancement;
var
i:integer;
Begin
for i:=0 to (RxChBImports.Items.Count-1) do
//for i:=(RxChBImports.Items.Count) DownTo 1 do
 if RxChBImports.Checked[i] then
  begin
    RxSliderImport.Value := (RxChBImports.Items.Count-i);
    exit;
  end;
End;

procedure TConfirmImportCOGERE.FRAssistant1BtnSuivantClick(
  Sender: TObject);
begin
//  try
//    if not RepImportDejaValide then
//     begin
//      E.RepertoireImportCourante:=E.RepertoireImportationSIEA;
//      RepImportDejaValide:=ChoisirRepImportation(E.RepertoireImportCourante,'import SIEA DOS');
//      if RepImportDejaValide then
//       E.RepertoireImportationSIEA := E.RepertoireImportCourante;
//     end;
//      FRAssistant1.Etape0(Sender);
//  except
//    abort;
//  end;
end;

procedure TConfirmImportCOGERE.FRAssistant1PaBtnClick(Sender: TObject);
begin
Etape1(sender);
end;

procedure TConfirmImportCOGERE.FormShow(Sender: TObject);
begin
RepImportDejaValide:=False;
end;

procedure TConfirmImportCOGERE.Suppressiontotaledudossier1Click(
  Sender: TObject);
begin
if MessageDlg('Attention,'+#13+#10+''+#13+#10+'Vous êtes sur le point de supprimer le dossier courant.'+#13+#10+''+#13+#10+'Continuer ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
 begin
   if MessageDlg('Suite à la suppression du dossier, '+#13+#10+'Epicéa.va se fermer automatiquement.'+#13+#10+''+#13+#10+'Continuer ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
    Begin
       InitDataBase(DMBD.dbNameProg,DMBD.dbNameDossier,DMBD.dbNameExo,false);
       InitTableEpi.SelectionnerTableAvantImport(nil);
       Application.Terminate;
    End;

 end;
end;

end.
