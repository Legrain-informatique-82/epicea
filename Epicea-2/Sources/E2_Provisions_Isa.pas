unit E2_Provisions_Isa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  Gr_Librairie_obj,
  E2_Librairie_obj,
  Grids,
  DBGrids,
  Db,
  DBTables,
  E2_AideCompte,
  LibSQL,
  Menus,
  Buttons,
  Gr_MiseAJourBalance,
  RXDBCtrl,
  ExRxDBGrid,
  DMBalances,
  DMPiece,
  DMProvision,
  registry,
  RXCtrls,
  GrDBGrid,
  LibZoneSaisie,
  E2_AssistantClotureDef,
  DMEcriture,
  LibRessourceString,
  E2_Decl_Records,
  Mask,
  ToolEdit,
  E2_Cloture_Def,
  GrGrid,
  E2_LibInfosTable,
  Librairie_Isa,
  DMConstantes,
  jpeg,
  LibGestionParamXML,
  editions;

type
  TParamAfficheProvisions = Record    
   Affiche:Boolean;
   AffichageModal:Boolean;
   Quand:Integer;
   TitreForm:String;
   SousTitreForm:String;
   AfficheListe:boolean;
   end;

   TProvisions_Isa = class(TForm)
    Patitre: TPanel;
    PaBtn: TPanel;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    PaBas: TPanel;
    PaGrille: TPanel;
    DBProv: TGrDBGrid;
    BtnAnnuler: TButton;
    BtnImprimer: TButton;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Insrer1: TMenuItem;
    Modifier1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    N2: TMenuItem;
    Prcdent1: TMenuItem;
    Suivant1: TMenuItem;
    RxLabTitre: TRxLabel;
    ImEnTete: TImage;
    RxSpeedButton2: TRxSpeedButton;
    RxSpeedButton1: TRxSpeedButton;
    PaTools: TPanel;
    RxSpeedButton4: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    PaLabel: TPanel;
    RxSpeedButton3: TRxSpeedButton;
    Label6: TLabel;
    Label5: TLabel;
    NumCpt: TEdit;
    EdLibelle: TEdit;
    EdDate: TDateEdit;
    PaCumul1: TPanel;
    Panel7: TPanel;
    GrGrid1: TGrGrid;
    RxSBImport: TRxSpeedButton;
    ListedesProvisions1: TMenuItem;
    ImprimerlaProvisioncourante1: TMenuItem;
    RxMAJ_Balance: TRxSpeedButton;
    Exporter1: TMenuItem;
    Saisiengative1: TMenuItem;
    procedure AideEnLigne(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure DBProvKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBProvColExit(Sender: TObject);
    procedure DBProvEnter(Sender: TObject);
    procedure ChangementEtatBoutons(Sender: TObject);
    procedure ChangementEtatCaption(Sender: TObject);
    procedure ChangementEtatGrille(Sender: TObject);
    procedure Enregistrement;
    procedure NumCptExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure NumCptKeyPress(Sender: TObject; var Key: Char);
    procedure RxSpeedButton2Click(Sender: TObject);
    procedure RxSpeedButton1Click(Sender: TObject);
    procedure PatitreResize(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Aideenligne1Click(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure NumCptEnter(Sender: TObject);
    procedure RxSpeedButton3Click(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure RxSBInfoVersionClick(Sender: TObject);
    Procedure PositionTotaux;
    procedure RxSBImportClick(Sender: TObject);
    Procedure GereAccesEcran;
    Procedure GestionInitDM(AffichePreListe:boolean=true);
    procedure ListedesProvisions1Click(Sender: TObject);
    procedure ImprimerlaProvisioncourante1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RxMAJ_BalanceClick(Sender: TObject);
    procedure RxMAJ_BalanceMouseEnter(Sender: TObject);
    procedure RxMAJ_BalanceMouseLeave(Sender: TObject);
    procedure RxMAJ_BalanceMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Exporter1Click(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
    procedure Saisiengative1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    TitreForm,SousTitreForm:String;
    Quand:Integer;
    AfficheListe:boolean;
  end;

var
  Provisions_Isa: TProvisions_Isa;
  Mark: TBookMark;
  LastSize:integer;
  DernierCptValide,DernierLibValide:string;
  MessDerSub:boolean;
  FlagProvisionCourante:boolean;
  Function ProvisionsAffiche(ParamAfficheProvisions:TParamAfficheProvisions):Boolean;

implementation

uses DMPlanCpt, E2_Main,E2_Recherche,
  //UQReport,
  E2_AideAssist, DMAide, DMRecherche, DMImportation,
  LibClassObjetSenders,DMCorrection,DMExports, ImportDll, InputQueryFrm_F;

{$R *.DFM}


Function ProvisionsAffiche(ParamAfficheProvisions:TParamAfficheProvisions):Boolean;
var
ParamDMProvisions:TParamDMProvision;
Begin
 if (Provisions_Isa = nil) then Provisions_Isa:=TProvisions_Isa.Create(Application.MainForm);
 if ((ParamAfficheProvisions.Quand <> Provisions_Isa.Quand) and (Provisions_Isa.Visible=true)) then
   Provisions_Isa.Close;
 Provisions_Isa.Quand:=ParamAfficheProvisions.Quand;
 if not empty(ParamAfficheProvisions.TitreForm) then
   Provisions_Isa.TitreForm:=ParamAfficheProvisions.TitreForm;
 Provisions_Isa.SousTitreForm:=ParamAfficheProvisions.SousTitreForm;

 ParamDMProvisions.ProvisionDataStateChange := Provisions_Isa.changementEtatBoutons;
 ParamDMProvisions.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ParamDMProvisions.Quand := Provisions_Isa.Quand;
 ParamDMProvisions.CompteProvision := Provisions_Isa.NumCpt.Text;
 ParamDMProvisions.AfficheListe:=ParamAfficheProvisions.AfficheListe;
 Provisions_Isa.AfficheListe:=ParamAfficheProvisions.AfficheListe;
 
   case Provisions_Isa.Quand of
      C_Ouverture:Begin
                   InitialiseDMProvision(ParamDMProvisions);
                  End;

      C_Cloture:Begin
                   InitialiseDMProvision(ParamDMProvisions);
                End;
   end;

 if ParamAfficheProvisions.Affiche then
  begin
   Provisions_Isa.DBProv.DataSource := DMProvisions.DataProvision;
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(Application.MainForm);

   if ParamAfficheProvisions.AffichageModal then
     Provisions_Isa.ShowModal
    else
     Provisions_Isa.Show;
  end;
// GestListForm(Stocks.TitreForm+' - '+Stocks.SousTitreForm,Stoks1);
// AffichageForm(Monofenetrage,Stocks);
End;

procedure TProvisions_Isa.AideEnLigne(Sender: TObject);
var
   aa,result:boolean;
begin
try
//WinShape(ActiveControl,Shape1,shape2,Main.ContourCouleur);
if ((AideAssist <> nil) and (AideAssist.Visible)) then
Result:=DMAides.taAssist.FindKey([self.Name+inttostr(self.Quand),ActiveControl.Name]);
     if not Result then
        DMAides.taAssist.FindKey(['Vide','Vide']);
except;
end;
end;

procedure TProvisions_Isa.Enregistrement;
begin
  try
  TableGerePost(DMProvisions.TaProvision);
  except
  abort;
  end;
end;

//****************************************************************************//
// Gestion du Show de la fenêtre.                                             //
//****************************************************************************//
procedure TProvisions_Isa.FormShow(Sender: TObject);
var
   Colonne: TColumn;
   I: Integer;
begin
DMProvisions.Quand:=self.Quand;

     Case Self.Quand Of
          // Si fenêtre d'ouverture
          C_Ouverture: Begin
                //DBProv.LockedCols:=0;
                  GrDbGridInitColonne(DBProv,DMProvisions.DataProvision,DMProvisions.TaProvision,
                       ['Désignation','Mt total Provision','Mt Bilan Ouverture'],
                       ['Designation','MtTotalProvision','MtBilanOuverture'],
                       E.FormatMonnaie,E.EditFormat);
                  GrGrid1.ColCount:=2;
                  Suivant1.Visible:=true;
                  Suivant1.Enabled:=true;
                  RxLabTitre.Caption:='Ouverture : Provisions';
                  Patitre.Color:=$00ADEBFF;
                  EdDate.Text := DateToStr(E.DatExoDebut);
                  Self.Caption :='Ouverture - Provisions';
                  RxSpeedButton1.Visible:=True and (not main.Monofenetrage);;
                  //For I:= 0 To 2 Do DBProv.Columns[I].ReadOnly := False;
                  PositionTotaux;
                  //RxSBImport.Visible := ((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'));
             End; // Fin fenêtre d'ouverture

          // Si fenêtre de clôture
          C_Cloture: Begin
                  GrGrid1.ColCount:=4;
//                  GrDbGridInitColonne(DBProv,DMProvisions.DataProvision,DMProvisions.TaProvision,
//                                      ['Reprise','Désignation','Mt total Provision','Mt à Reprendre','Reprise exercice','Solde fin exercice'],
//                                      ['Reprise','Designation','MtTotalProvision','MtBilanOuverture','MontantReprise','MtRestant'],
//                                      E.FormatMonnaie,E.EditFormat);
                  GrDbGridInitColonne(DBProv,DMProvisions.DataProvision,DMProvisions.TaProvision,
                                      ['Désignation','Mt total Provision','Mt à Reprendre','Reprise exercice','Solde fin exercice'],
                                      ['Designation','MtTotalProvision','MtBilanOuverture','MontantReprise','MtRestant'],
                                      E.FormatMonnaie,E.EditFormat);
                  //DBProv.LockedCols:=1;
                  Suivant1.Visible:=false;
                  Suivant1.Enabled:=false;
                  EdDate.Text := DateToStr(E.DatExoFin);
               RxLabTitre.Caption:='Clôture : Provisions';
               Patitre.Color:=$0033CCFF;
               RxSpeedButton1.Visible:=false;
               //DBProv.Columns[0].ReadOnly := True;
               PositionTotaux;
               RxSBImport.Visible := False;
             End; // Fin fenêtre de clôture
     End; // Fin de Self.Quand
     ChangementEtatCaption(self);


//     Case Self.Quand Of
//          1: Begin //si ouverture
//               //on affiche les données dont la date de saisie
//               //correspond à la date de début d'exercice
//               FiltrageDataSet(DMProvisions.TaProvision,'DateSaisie = '''+DateToStr(E.DatExoDebut-1)+'''');
//             End;
//          C_Cloture: Begin //si clôture
//               DeFiltrageDataSet(DMProvisions.TaProvision);
//             End;
//     End;
//       DMProvisions.FiltrageAffichageGrille(self.Quand);
//     DMProvisions.TaProvision.First;
////     DBProv.SetFocus;
//     DMProvisions.DaTaProvision.OnStateChange:=ChangementEtatBoutons;
//     DMProvisions.DaTaProvision.OnStateChange(DMProvisions.TaProvision);

end;
//****************************************************************************//


//****************************************************************************//
// Initialisation à la création de la fenêtre.                                //
//****************************************************************************//
procedure TProvisions_Isa.FormCreate(Sender: TObject);
Var
	Registre :TRegistry;
Begin
 if DMProvisions=nil then
 DMProvisions:=TDMProvisions.Create(self);

 if AideCompte=nil then
 AideCompte:=TAideCompte.Create(self);

 Registre:= TRegistry.Create;

   try
     with Registre do
     begin
        RootKey := HKEY_LOCAL_MACHINE;
        OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, false);
      try
        NumCpt.Text:=ReadString('NumCpt');
        EdLibelle.Text:=ReadString('label3');
      except
        NumCpt.Text:=DM_C_CompteProvisionsDefaut;
        EdLibelle.Text:=DMPlan.LibelleDuNumCptPCU(DM_C_CompteProvisionsDefaut);
      end;
   end;
   finally
    Registre.Free;
   end;
FlagProvisionCourante:=false;
   if empty(numcpt.text) or(not DMPlan.CompteExistePCU(NumCpt.Text)) then
      Begin
        NumCpt.Text:=DM_C_CompteProvisionsDefaut;
        EdLibelle.Text:=DMPlan.LibelleDuNumCptPCU(DM_C_CompteProvisionsDefaut);
      End;
DernierCptValide:=NumCpt.Text;
DernierLibValide:=EdLibelle.Text;
 DMProvisions.CompteProvision:= numcpt.text;
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        InitialiseFormPosDefaut(self);
	//Left:= 30; Top:= 70; Width:= screen.Width-60; Height:= screen.Height-top-30;
    end;
 Patitre.Color:=$00ADEBFF;
 LastSize:=0;
 MessDerSub:=true;
// DMProvisions.DataProvision.OnStateChange:=ChangementEtatBoutons;
end;
//****************************************************************************//


//****************************************************************************//
// Libération de la mémoire.                                                  //
//****************************************************************************//
Procedure TProvisions_Isa.InitialiseTable_A_Nil;
Begin
    if DMProvisions<>nil then
    InitDatasetEvent_A_Nil_Sur_Form([DMProvisions.DataProvision]);
End;

procedure TProvisions_Isa.FormDestroy(Sender: TObject);
Var
	Registre :TRegistry;
Begin
      Registre:= TRegistry.Create;
      try
       InitialiseTable_A_Nil;
         with Registre do begin
            RootKey := HKEY_LOCAL_MACHINE;

            OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, True);
             WriteString('NumCpt',NumCpt.Text);
             WriteString('label3',EdLibelle.Text);

            CloseKey;
         end;
      finally
         Registre.Free;
     LibGestionParamXML.DestroyForm(Self,E.USer);
     if DMProvisions<>nil then
         DMProvisions.Free;
     Provisions_Isa:=Nil;
      end;
end;
//****************************************************************************//


//******************* ChangementEtatBoutons *************************
procedure TProvisions_Isa.ChangementEtatBoutons(Sender: TObject);
var
TotauxGeneric:TTotauxGeneric;
begin
   case DMProvisions.TaProvision.State of
   dsBrowse	: begin
                    NumCpt.Enabled:=true;
                    BtnEnregistrer.Enabled:=false;
                    BtnInserer.Enabled:=true;
                    BtnModifier.Enabled:=(Not(DMProvisions.TaProvision.RecordCount = 0));
                    BtnSupprimer.Enabled:=(Not(DMProvisions.TaProvision.RecordCount = 0));
                    BtnImprimer.Enabled:=true;
                    DBProv.OnColExit:=nil;
                    case self.Quand of
                       C_Ouverture:Begin
                           FiltrageDataSet(DMRech.TaProvisionsRech,DBProv.DataSource.DataSet.Filter);
                           TotauxGeneric:=SommeTotauxGeneric(['MtTotalProvision','MtBilanOuverture'],DMRech.TaProvisionsRech);
                           GrGrid1.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total1);
                           GrGrid1.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total2);
                           DeFiltrageDataSet(DMRech.TaProvisionsRech);
                         End;

                       C_Cloture:Begin
                           FiltrageDataSet(DMRech.TaProvisionsRech,DBProv.DataSource.DataSet.Filter);
                           TotauxGeneric:=SommeTotauxGeneric(['MtTotalProvision','MtBilanOuverture','MontantReprise'],DMRech.TaProvisionsRech);
                           GrGrid1.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total1);
                           GrGrid1.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total2);
                           GrGrid1.cells[2,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total3);
                           GrGrid1.cells[3,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total2-TotauxGeneric.Total3);
                           DeFiltrageDataSet(DMRech.TaProvisionsRech);
                         End;
                   end;
                 end;

   dsedit:   begin
            NumCpt.Enabled:=False;
            BtnEnregistrer.Enabled:=true;
            BtnInserer.Enabled:=false;
            BtnModifier.Enabled:=false;
            BtnSupprimer.Enabled:=false;
            BtnImprimer.Enabled:=false;
            DBProv.OnColExit:=DBProvColExit;
           end;

   dsinsert: begin
            NumCpt.Enabled:=False;
            BtnEnregistrer.Enabled:=false;
            BtnInserer.Enabled:=false;
            BtnModifier.Enabled:=false;
            BtnSupprimer.Enabled:=false;
            BtnImprimer.Enabled:=false;
            DBProv.OnColExit:=DBProvColExit;
           end;
   end; //fin du case
   //Pop-up Menu
   Fermer1.Enabled:=BtnFermer.Enabled;
   Insrer1.Enabled:=BtnInserer.Enabled;
   Enregister1.Enabled:=BtnEnregistrer.Enabled;
   Modifier1.Enabled:=BtnModifier.Enabled;
   Supprimer1.Enabled:=BtnSupprimer.Enabled;
   imprimer1.Enabled:=btnimprimer.Enabled;
   ChangementEtatCaption(self);//appel d'une procédure de changement
   //des captions en fonction de l'état de la table
   ChangementEtatGrille(self); //appel d'une procédure de changement
   //d'état de la grille en fonction de l'état de la table
   GereAccesEcran;
end;




//******************* ChangementEtatCaption *************************
procedure TProvisions_Isa.ChangementEtatCaption(Sender: TObject);
var
   messagetmp: String;
begin
 Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DBProv.DataSource.DataSet);
end;


//******************* ChangementEtatGrille *************************

procedure TProvisions_Isa.ChangementEtatGrille(Sender: TObject);
var I:integer;
begin
DBProv.OnColExit:=nil;
  case DBProv.DataSource.State of
    dsinsert : begin //si table en insertion
                 DBProv.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
                 Case Self.Quand Of
                 C_Cloture: Begin //si clôture
                         DBProv.DataSource.DataSet.Fields[2].FocusControl;
                         DBProv.Columns[0].ReadOnly:=false;
                         DBProv.Columns[1].ReadOnly:=false;
                         DBProv.Columns[3].ReadOnly:=false;

                         //InitChampReadOnly(DBProv.DataSource.DataSet,[2,3,7],false);
                         //InitChampReadOnly(DBProv.DataSource.DataSet,[6],true);
                    End;
                 End; // Fin du Case.Quand
                 DBProv.TitreColor(true);
                 DBProv.SetFocus;
               end;// fin insertion
    dsbrowse : begin //si table en consultation
                 DBProv.Options := [dgediting,dgtitles,dgindicator,dgrowlines,dgcollines,dgtabs];
                 if DBProv.InplaceEditor <> nil then
                    DBProv.EditorMode:=false;
                 Case Self.Quand Of
                 C_Cloture: begin //si clôture
                         If DMProvisions.TaProvisionDateSaisie.AsDateTime = E.DatExoDebut-1 Then
                            DBProv.DataSource.DataSet.Fields[7].FocusControl
                         Else
                            DBProv.DataSource.DataSet.Fields[2].FocusControl;
                    End;
                 End;//fin du case.Quand
                 DBProv.TitreColor(true);
               end;//fin de consultation
    dsEdit : begin //si table en modification
               DBProv.TitreColor(true);
               DBProv.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               DBProv.SetFocus;
               If Self.Quand = C_Cloture Then//si clôture
               Begin
                    If DMProvisions.TaProvisionDateSaisie.AsDateTime = E.DatExoDebut-1 Then
                    Begin //si date début Exercice
                         DBProv.DataSource.DataSet.Fields[7].FocusControl;
                         DBProv.Columns[3].ReadOnly:=false;
                         DBProv.Columns[0].ReadOnly:=true;
                         DBProv.Columns[1].ReadOnly:=true;
                         DBProv.Columns[2].ReadOnly:=true;

//                         InitChampReadOnly(DBProv.DataSource.DataSet,[7],false);
//                         InitChampReadOnly(DBProv.DataSource.DataSet,[2,3,4],true);
                         //InitChampReadOnly(DBProv.DataSource.DataSet,[6,2,3,4],true);
                    End //fin date début
                    Else //si date fin Exercice
                    Begin
                         //DBProv.DataSource.DataSet.Fields[2].FocusControl;
                         DBProv.Columns[2].ReadOnly:=true;
                         DBProv.Columns[0].ReadOnly:=false;
                         DBProv.Columns[1].ReadOnly:=false;
                         DBProv.Columns[3].ReadOnly:=false;

//                         InitChampReadOnly(DBProv.DataSource.DataSet,[2,3,7],false);
//                         InitChampReadOnly(DBProv.DataSource.DataSet,[4],true);
                         //InitChampReadOnly(DBProv.DataSource.DataSet,[6,4],true);
                    End;//fin date fin
               End;//fin Quand=C_Cloture
         End;//fin modification
  end;//fin du case.state
  DBProv.OnColExit:=DBProvColExit;
end;


//****************************************************************************//
// Permet d'insérer une charge à répartir.                                    //
//****************************************************************************//
procedure TProvisions_Isa.BtnInsererClick(Sender: TObject);
begin
 TableAjoute(DMProvisions.TaProvision);
end;
//****************************************************************************//


//****************************************************************************//
// Permet de fermer la fenêtre.                                               //
//****************************************************************************//
procedure TProvisions_Isa.BtnFermerClick(Sender: TObject);
begin
     Self.Close;
end;
//****************************************************************************//


//****************************************************************************//
// Permet de supprimer la charge sélectionnée par l'utilisateur.              //
//****************************************************************************//
procedure TProvisions_Isa.BtnSupprimerClick(Sender: TObject);
begin
   try
   TableGereDelete(DMProvisions.TaProvision);
   except
   abort;
   end;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion des touches alphanumériques.                                       //
//****************************************************************************//
procedure TProvisions_Isa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
FlagProvisionCourante:=(ssCtrl in Shift);
     If Key = VK_ESCAPE Then
     Begin

          If DMProvisions.TaProvision.State = dsBrowse Then
          Begin
            if DBProv.Focused then Self.Close;
            if NumCpt.Focused then DBProv.SetFocus;
          End;

       // Si l'utilisateur est en mode Insertion
          If DMProvisions.TaProvision.State = dsInsert Then
          Begin
          if Messagedlg('Voulez-vous annuler la création cette provision ?',
            MtConfirmation,[mbyes,mbno],0) = mryes Then
            begin
             DMProvisions.TaProvision.Cancel;
             abort;
            end
            else
            begin
             Abort;
            end;
          End;


          If DMProvisions.TaProvision.State = dsEdit Then
          Begin
               If Messagedlg('Annuler les modifications de cette provision ?',
               MtConfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                 DMProvisions.TaProvision.Cancel;
//                    DBProv.SelectedIndex := 1;
                 abort;
               End
               Else
               Begin
                    Abort;
               End;
          End;
     End;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click sur le bouton Modifier.                                   //
//****************************************************************************//
procedure TProvisions_Isa.BtnModifierClick(Sender: TObject);
begin
  DMProvisions.TaProvision.Edit;
end;
//****************************************************************************//



//****************************************************************************//
// Gestion du click sur le bouton Enregistrer.                                //
//****************************************************************************//
procedure TProvisions_Isa.BtnEnregistrerClick(Sender: TObject);
begin
  if DMProvisions.TaProvision.State in  [dsinsert,dsedit] then
     begin
     Enregistrement;
     //DBProv.SelectedIndex:=0;
     //DBGridChargesCA.DataSource.DataSet.Fields[].FocusControl;
     DBProv.SetFocus;
     end;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion des touches dans la grille.                                        //
//****************************************************************************//
procedure TProvisions_Isa.DBProvKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if DMProvisions.TaProvision.State in [dsBrowse] then
if ((key=VK_INSERT) and (Shift=[ssCtrl])) then BtnInserer.Click;
if ((key=VK_INSERT) and (Shift=[])) then key:=0;
end;
//****************************************************************************//



//****************************************************************************//
// Permet de contrôler la saisie de l'utilisateur dans la grille.             //
//****************************************************************************//
procedure TProvisions_Isa.DBProvColExit(Sender: TObject);
var retourFonction:TErreurSaisie;
begin
if DBProv.DataSource.DataSet.State in [dsinsert,dsEdit] then
   begin
   // appel de la fonction de contrôle de saisie
   retourFonction:=DMProvisions.CtrlSaisieProvisions(DBProv.SelectedField);
           if  RetourFonction.Retour=false then
            begin
              case self.Quand of
              C_Ouverture:begin //si ouverture
                   case  RetourFonction.CodeErreur of
                 2100,2200:
                         begin // erreur de saisie, resaisir
                         DBProv.DataSource.DataSet.Fields[2].FocusControl;
                         abort;
                         end;
                 3100,3200:
                         begin // erreur de saisie, resaisir
                         DBProv.DataSource.DataSet.Fields[3].FocusControl;
                         abort;
                         end;
                 4100,4102,4200,4202:
                         begin // erreur de saisie, resaisir
                         DBProv.DataSource.DataSet.Fields[4].FocusControl;
                         abort;
                         end;
                   end;      
                end;//fin ouverture
              C_Cloture:begin
                   case  RetourFonction.CodeErreur of
                       3200:
                         begin // erreur de saisie, resaisir
                         DBProv.DataSource.DataSet.Fields[3].FocusControl;
                         abort;
                         end;
                       4202:
                         begin // erreur de saisie, resaisir
                         //DBProv.SelectedIndex:=3;
                         DBProv.DataSource.DataSet.Fields[4].FocusControl;
                         abort;
                         end;
                       7203:
                         begin // erreur de saisie, resaisir
                         //DBProv.SelectedIndex:=4;
                         DBProv.DataSource.DataSet.Fields[7].FocusControl;
                         abort;
                         end;
                   end; //fin du case codeErreur
                end;//fin de clôture

              end;//fin case.Quand
              DBProv.SetFocus
            end
            else //si le retour=true (il n'y a pas d'erreur)
            begin
              case self.Quand of
                C_Ouverture: begin //si ouverture
                    if (DBProv.SelectedField.FieldNo =3) and (DMProvisions.TaProvision.State<>dsbrowse) then
                       begin
                         BtnEnregistrer.Enabled:=true;
                         Enregister1.Enabled:=true;
                       end;
                   end;

                C_Cloture: begin //si clôture
                    if (DBProv.SelectedField.FieldNo =3) and (DMProvisions.TaProvision.State<>dsbrowse) then
                       begin
                         BtnEnregistrer.Enabled:=true;
                         Enregister1.Enabled:=true;
                       end;
                    if  DBProv.SelectedField.FieldNo =4 then
                       DBProv.DataSource.DataSet.Fields[7].FocusControl;
                       //DBProv.SelectedIndex:=4;
                   end;
              end;//fin du case.Quand
            end;//si le retour=true(il n'y a pas d'erreur)
   end;
end;


procedure TProvisions_Isa.DBProvEnter(Sender: TObject);
begin
 if empty(numcpt.Text) then
  begin
   numcpt.SetFocus;
   abort;
  end;
end;

procedure TProvisions_Isa.NumCptExit(Sender: TObject);
var
Infosplancpt:TInfosplancpt;
begin
AideCompte.FiltrageAideCompte(11);
    if AideCompteDansContexte(NumCpt.text,NumCpt,['Rac1'],false,MessDerSub,true,true,false,true,0)=true then
       begin
         DMProvisions.FiltrageAffichageGrille(self.Quand);
         DeFiltrageDataSet(DMRech.TaPlanCptRech);
         Infosplancpt:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[numcpt.text]);
         if Infosplancpt.ResultInfos then
         EdLibelle.Text:=Infosplancpt.Libelle;
         DMProvisions.CompteProvision:= numcpt.text;
       end
       else
       begin
         numcpt.SetFocus;
         abort;
       end;

     if VerifSiCompteSaisieDsBO(NumCpt.text,true,DMProvisions.TaProvision,self.Quand = C_Ouverture) then
      begin
        NumCpt.SetFocus;
        abort;
      end;
MessDerSub:=true;
DernierCptValide:=NumCpt.Text;
DernierLibValide:=EdLibelle.Text;
if (DMProvisions.TaProvision.State in [dsBrowse]) then
   begin
    DMProvisions.FiltrageAffichageGrille(self.Quand);
    DMProvisions.DataProvision.OnStateChange(DMProvisions.TaProvision);
 end;
end;

procedure TProvisions_Isa.FormActivate(Sender: TObject);
begin
  GestionInitDM(false);
//  ListedesProvisions1.Click;
initialisationMAJ_Balance(RxMAJ_Balance);
  affichageOD:=false;
  Initialiser_ShortCut_Main(true);
  Patitre.visible:=Main.AfficheTitre;
  CouleurFond([PaTools,PaBtn,PaBas,PaLabel],ParamUtil.CouleurPanelCorps);

  DBProv.ParamColor:=true;
  DBProv.Param:=ParamUtil.CouleurDBGrid;
  DBProv.UpDateColor;

  GrGrid1.ParamColor:=true;
  GrGrid1.Param:=ParamUtil.CouleurDBGrid;
  GrGrid1.DessineContourLigne:=false;
  GrGrid1.UpDateColor;
  GrGrid1.FixedColor:=ParamUtil.CouleurDBGrid.GrilleColorFond;

if Patitre.visible then
 begin
  N2.Visible:=true;
  Prcdent1.Visible:=true;
  Suivant1.Visible:=true;
  Prcdent1.Enabled:=true;
  Suivant1.Enabled:=true;
 end
 else
 begin
  N2.Visible:=false;
  Prcdent1.Visible:=false;
  Suivant1.Visible:=false;
  Prcdent1.Enabled:=false;
  Suivant1.Enabled:=false;
 end;

//DMPlan.TaCompte.OnFilterRecord:=nil;
//DMProvisions.FiltrageAffichageGrille(self.Quand);
//if (DMProvisions.TaProvision.State in [dsBrowse]) then
//   begin
//    DMProvisions.FiltrageAffichageGrille(self.Quand);
//    DMProvisions.DataProvision.OnStateChange(DMProvisions.TaProvision);
// end;
//Screen.OnActiveControlChange:=AideEnLigne;
GereAccesEcran;
PaGrilleResize(PaGrille);
//if AfficheListe then
//  ListedesProvisions1.Click;
end;

procedure TProvisions_Isa.NumCptKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in [#48..#57,#13,#8,#9]) then
key:=#0;
if key=#13 then
 begin
   DBProv.SetFocus;
 end;
end;

procedure TProvisions_Isa.RxSpeedButton2Click(Sender: TObject);
begin
case self.Quand of
   C_Ouverture:Main.Cetprecevoir1Click(Main.Cetprecevoir1);
   C_Cloture:Main.Dpensedelentreprise1Click(Main.Dpensedelentreprise1);
end;


end;

procedure TProvisions_Isa.RxSpeedButton1Click(Sender: TObject);
begin
Main.Balance1Click(Main.Bilandouverture1);
end;

procedure TProvisions_Isa.PatitreResize(Sender: TObject);
begin
//RxSpeedButton1.top:=12;
RxSpeedButton1.Left:=Patitre.Width-104;
//RxSpeedButton1.Height:=Patitre.Height-24;
end;

procedure TProvisions_Isa.PaGrilleResize(Sender: TObject);
begin
if DBProv.DataSource<>nil then
  DBProv.DataSource.DataSet.close;
  case self.Quand of
     C_Ouverture:Begin
        FormateTailleColonne(DBProv,9,[4,2,2]);
        GrGrid1.ColCount:=2;
        PositionTotaux;
       End;

     C_Cloture:Begin
//        FormateTailleColonne(DBProv,29,[2,9,4,4,4,4]);
        FormateTailleColonne(DBProv,29,[9,4,4,4,4]);
        GrGrid1.ColCount:=4;
        PositionTotaux;
       End;
  end;
if DBProv.DataSource<>nil then
  DBProv.DataSource.DataSet.open;
  WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);

end;

procedure TProvisions_Isa.PaBtnResize(Sender: TObject);
begin
  FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TProvisions_Isa.FormResize(Sender: TObject);
begin
if self.Width < 450 then
     if LastSize > self.Width
       then
           begin
          LastSize:=self.Width;
           abort;
           end;
LastSize:=self.Width;

end;

procedure TProvisions_Isa.Aide1Click(Sender: TObject);
begin
 If activecontrol = DBProv Then
  begin
   case DBProv.DataSource.State of
      dsbrowse:case self.Quand of
                  C_Ouverture:case DBProv.SelectedField.FieldNo of
                        3:Rechercher(DBProv,DMProvisions.TaProvision,['Designation','DateSaisie','ID','Compte'],['Désignation','Date Saisie','',''],'',0);
                    end;
                  C_Cloture:case DBProv.SelectedField.FieldNo of
                      7:Rechercher(DBProv,DMProvisions.TaProvision,['Reference','Designation','ID','DateSaisie','Compte'],['Réference','Désignation','','',''],'',0);
                      3:Rechercher(DBProv,DMProvisions.TaProvision,['Designation','Reference','DateSaisie','ID','Compte'],['Désignation','Réference','','',''],'',0);
                    end;
               end;
  end;
 end;
 If activecontrol = NumCpt Then
  begin
   case DBProv.DataSource.State of
      dsbrowse:begin
                    AideCompte.FiltrageAideCompte(11);
                    MessDerSub:=false;
                    AideCompteDansContexte(NumCpt.text,NumCpt,['Rac1'],true,MessDerSub,true,true,false,true,0);
                    MessDerSub:=true;
               end;
   end;
  end;
end;

procedure TProvisions_Isa.BtnImprimerClick(Sender: TObject);
var
Site:TEditLien;
begin
//case self.Quand of
//   C_Ouverture:EditionProvisionsL(C_EditionSimple,C_Ouverture,nil,nil,Site);
//   C_Cloture:EditionProvisionsL(C_EditionSimple,C_Cloture,nil,nil,Site);
//end;
 if FlagProvisionCourante then
   EditionProvisionsL(C_EditionSimple,self.Quand,nil,DMProvisions.TaProvision.FindField('Compte').AsString,Site)
 else
   EditionProvisionsL(C_EditionSimple,self.Quand,nil,nil,Site);
 FlagProvisionCourante:=False;

end;

procedure TProvisions_Isa.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TProvisions_Isa.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
canclose:=true;
try//finally
try//except
If DMProvisions <> nil then
begin
If DMProvisions.TaProvision.State = dsInsert Then
     Begin
          self.WindowState:=wsNormal;
          self.BringToFront;
          If BtnEnregistrer.Enabled Then //s'il y a une saisie
          Begin
               If Messagedlg('Voulez-vous enregistrer cette provision ?',
               MtConfirmation,[mbyes,mbno],0) = mryes Then
                begin
                  Enregistrement;
                end
               else //si on ne veut pas enregistrer
                begin
                 DMProvisions.TaProvision.Cancel;
                end;
          End
          Else //s'il n'y a rien de saisi
          Begin
               If Messagedlg('Voulez-vous annuler la création cette provision ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                begin
                  DMProvisions.TaProvision.Cancel;
                end
               Else
                begin
                  canclose:=false;
                end;
          End;
     End;// Fin utilisateur est en mode Insertion

     // Si l'utilisateur est en mode Modification
     If DMProvisions.TaProvision.State = dsEdit Then
     Begin
          self.WindowState:=wsNormal;
          self.BringToFront;
          If Messagedlg('Voulez-vous enregistrer les modifications de cette provision ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
             Enregistrement
          else //si on ne veut pas enregistrer
             DMProvisions.TaProvision.Cancel;
     End; // Fin utilisateur est en mode Modification

     Case Self.Quand Of
          C_Cloture: Begin //si cloture
                InitChampReadOnly(DBProv.DataSource.DataSet,[2,3,4,6,7],false);
                   try
                     DeFiltrageDataSet(DBProv.DataSource.DataSet);
                       if DMProvisions.FiltrageTablePourRepriseouverture=true then
                         begin
                            DMProvisions.CreationODChargeOuverture;
                            affichageOD:=true;
                         end;
                       if DMProvisions.FiltrageTablePourRepriseCloture=true then
                         begin
                           DMProvisions.CreationODChargeCloture;
                           affichageOD:=true;
                         end;

                   except
                         showmessage('Problème à la création des OD ');
                         abort;
                   end;//fin du try except

             if affichageOD then
               DMProvisions.DemandeAffichageReprise;

                 //end;//fin si on a trouvé des charges à repartir
             self.Quand:=-1; // initialisation du Quand sinon plusieurs passage
             end;//fin si cloture
     End; // Fin du Self.Quand
end;
if not empty(NumCpt.Text) then
   begin
    AideCompte.FiltrageAideCompte(11);
    MessDerSub:=false;
    if AideCompteDansContexte(NumCpt.text,NumCpt,['Rac1'],false,MessDerSub,false,true,false,true,0)= false then
     begin
     NumCpt.Text:=DernierCptValide;
     EdLibelle.Text:=DernierLibValide;
     end;
    end
  else
    begin
    NumCpt.Text:=DernierCptValide;
    EdLibelle.Text:=DernierLibValide;
    end;
except
  canclose:=false;
end;
if CanClose then InitialiseTable_A_Nil { isa  le  29/01/04 }
 else
 begin
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(self);

 end;
AssistantClotRafraichit(5);
try
//    if ((Cloture_Def<>nil)and(ActivationForm(Cloture_Def))) then // PB
//      begin
//        if Cloture_Def.EtapeSuivante>=6 then
//          Cloture_Def.EtapeSuivante:=5;{ isa  le  16/09/03 }
//      end;
except
  //
end;
finally
  affichageOD:=false;
end;
end;

procedure TProvisions_Isa.Aideenligne1Click(Sender: TObject);
begin
if AideAssist = Nil then AideAssist:= TAideAssist.Create(Self);
if AideAssist.Visible then
     begin
      AideAssist.close;
      self.show;
     end
     else begin
      AideAssist.Show;
      self.show;
     end;
end;

procedure TProvisions_Isa.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TProvisions_Isa.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TProvisions_Isa.NumCptEnter(Sender: TObject);
begin
  EnableWinControl([BtnAnnuler,BtnFermer],True);
  EnableWinControl([BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnImprimer],False);
  //Pop menu
  EnableItemMenu([Annuler1,Fermer1],true);
  EnableItemMenu([Enregister1,Insrer1,Modifier1,Supprimer1,Imprimer1],False);

end;

procedure TProvisions_Isa.RxSpeedButton3Click(Sender: TObject);
begin
DetailEcritureCompte(NumCpt.text,true,False);
end;

procedure TProvisions_Isa.Visualisation1Click(Sender: TObject);
begin
DetailEcritureCompte(NumCpt.text,true,False);
end;

procedure TProvisions_Isa.RxSBInfoVersionClick(Sender: TObject);
begin
Showmessage(Provisions_IsaRxSBInfoVersionWarning+numVersion.messageVersion);
end;

Procedure TProvisions_Isa.PositionTotaux;
Begin
  case self.Quand of
     C_Ouverture:Begin
        Panel7.Width:=RenvoiTailleColonne(DBProv,[0,1])+10;
        GrGrid1.ColWidths[0]:=RenvoiTailleColonne(DBProv,[2]);
        GrGrid1.ColWidths[1]:=RenvoiTailleColonne(DBProv,[3]);
       End;

     C_Cloture:Begin
//        Panel7.Width:=RenvoiTailleColonne(DBProv,[0,1,2])+10;
//        GrGrid1.ColWidths[0]:=RenvoiTailleColonne(DBProv,[3]);
//        GrGrid1.ColWidths[1]:=RenvoiTailleColonne(DBProv,[4]);
//        GrGrid1.ColWidths[2]:=RenvoiTailleColonne(DBProv,[5]);
//        GrGrid1.ColWidths[3]:=RenvoiTailleColonne(DBProv,[6]);

        Panel7.Width:=RenvoiTailleColonne(DBProv,[0,1])+10;
        GrGrid1.ColWidths[0]:=RenvoiTailleColonne(DBProv,[2]);
        GrGrid1.ColWidths[1]:=RenvoiTailleColonne(DBProv,[3]);
        GrGrid1.ColWidths[2]:=RenvoiTailleColonne(DBProv,[4]);
        GrGrid1.ColWidths[3]:=RenvoiTailleColonne(DBProv,[5]);
       End;
  end;
End;
procedure TProvisions_Isa.RxSBImportClick(Sender: TObject);
begin
  DMProvisions.TaProvision.DisableControls;
  DMImport.Import_Provision(DMProvisions.TaProvision,true);
  changementEtatBoutons(DMProvisions.TaProvision);
  DMProvisions.TaProvision.EnableControls;
end;

Procedure TProvisions_Isa.GereAccesEcran;
begin
  case self.Quand of
     C_Ouverture:Begin
                  DBProv.ReadOnly := not E.AccesOuverture;
                  DBProv.FSauteColReadOnly := not DBProv.ReadOnly;
                  EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer],E.AccesOuverture);
                  EnableItemMenu([Insrer1,Modifier1,Supprimer1],E.AccesOuverture);
                 End;

     C_Cloture:Begin
                  DBProv.ReadOnly := not E.AccesCloture;
                  DBProv.FSauteColReadOnly := not DBProv.ReadOnly;
                  EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer],E.AccesCloture);
                  EnableItemMenu([Insrer1,Modifier1,Supprimer1],E.AccesCloture);
               End;
  end;
DMProvisions.GestionAccesProvisions;
end;

Procedure TProvisions_Isa.GestionInitDM(AffichePreListe:boolean);
var
ParamDMProvision:TParamDMProvision;
Begin
 ParamDMProvision.ProvisionDataStateChange := changementEtatBoutons;
 ParamDMProvision.Quand := Quand;
 ParamDMProvision.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ParamDMProvision.CompteProvision := Provisions_Isa.NumCpt.Text;
 ParamDMProvision.AfficheListe:=AffichePreListe;
 InitialiseDMProvision(ParamDMProvision);
// ParamDMProvision.CompteProvision := Provisions_Isa.NumCpt.Text;
End;

procedure TProvisions_Isa.ListedesProvisions1Click(Sender: TObject);
begin
//AffichProvisionsSurPeriode(Quand);
//if DMPieces.RetourViewListe.retour then
//   DMProvisions.CompteProvision:=DMPieces.RetourViewListe.VisuListeView.ItemCourantValeurCol(0);
GestionInitDM;
if not empty(DMProvisions.CompteProvision) then
  NumCpt.Text:=DMProvisions.CompteProvision;
DMProvisions.CompteProvision:=NumCpt.Text;
end;

procedure TProvisions_Isa.ImprimerlaProvisioncourante1Click(
  Sender: TObject);
begin
FlagProvisionCourante:=true;
BtnImprimer.Click;
end;

procedure TProvisions_Isa.PopupMenu1Popup(Sender: TObject);
begin
ImprimerlaProvisioncourante1.Caption := 'Imprimer le compte : '+ DBProv.DataSource.DataSet.findField('Compte').AsString;
end;

procedure TProvisions_Isa.FormDeactivate(Sender: TObject);
begin
e.TypeMAJBalance:=MAJ_Normal;
initialisationMAJ_Balance(RxMAJ_Balance);
end;

procedure TProvisions_Isa.RxMAJ_BalanceClick(Sender: TObject);
begin
Activation_Desactivation_MAJ_Balance;
initialisationMAJ_Balance(RxMAJ_Balance);
end;

procedure TProvisions_Isa.RxMAJ_BalanceMouseEnter(Sender: TObject);
begin
(Sender as TRxSpeedButton).Font.Color:=clREd;
(Sender as TRxSpeedButton).Font.Style:=[fsBold];
end;

procedure TProvisions_Isa.RxMAJ_BalanceMouseLeave(Sender: TObject);
begin
(Sender as TRxSpeedButton).Font.Color:=clWindowText;
(Sender as TRxSpeedButton).Font.Style:=[];
end;

procedure TProvisions_Isa.RxMAJ_BalanceMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
initialisationMAJ_Balance(RxMAJ_Balance);
end;

procedure TProvisions_Isa.Exporter1Click(Sender: TObject);
begin
if Quand=c_ouverture then
ExportDonnees(DBProv.DataSource.DataSet,E.RepertoireExportDossier,'Prov_Ouv_'+E.NomDossier + E.NomExo + '.Txt')
else
ExportDonnees(DBProv.DataSource.DataSet,E.RepertoireExportDossier,'Prov_Clôt_'+E.NomDossier + E.NomExo + '.Txt');
end;

procedure TProvisions_Isa.Calculatrice1Click(Sender: TObject);
begin
if DBProv.Col in [2,3,4] then
  AfficheCalculatrice(DBProv)
else
  AfficheCalculatrice(nil);
end;

procedure TProvisions_Isa.Saisiengative1Click(Sender: TObject);
var chiffre:String;
begin
       chiffre:=CurrToStr(0);
       if(MyInputQuery_Chiffre(self,'Report reprise déduction pour investissement','Saisir le montant de la reprise négative',
                    chiffre,'',[#48..#57,'-',DecimalSeparator],-100000000000,0,true)) then
                begin

                end;
end;

end.
