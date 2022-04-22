{-----------------------------------------------------------------------------
 Unit Name: E2_ChargeRepartir_Isa
 Author:    Blanc Philippe
 Purpose:
 History:
 Initialisation de la fonction ChargeARepartirAffiche avec TParamAffichage
 Affiche:Boolean; : Détermine si l'on veut afficher ou non l'écran de stock
 AffichageModal:Boolean; Détermine si l'on veut afficher ou non l'écran de stock en modal
 Quand:Integer;   : Détermine si l'on est en Ouverture ou en Cloture, elle
                    affecte la variable Stocks.Quand (remplace l'utilisation de Tag)
 TitreForm:String; : Titre de la form
 SousTitreForm:String; : SousTitre de la form
-----------------------------------------------------------------------------}
unit E2_ChargeRepartir_Isa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Gr_Librairie_obj, E2_Librairie_obj, Grids, DBGrids, Db,
  DBTables, E2_AideCompte, LibSQL, Menus, Buttons,Gr_MiseAJourBalance,
  RXDBCtrl, ExRxDBGrid,DMBalances,DMPiece, RXCtrls, GrDBGrid,LibZoneSaisie,
  E2_AssistantClotureDef,LibRessourceString,E2_Decl_Records, Mask, ToolEdit,
  E2_Cloture_Def,Librairie_Isa,DMConstantes,LibGestionParamXML,
  ObjetEdition,
  GrGrid,Editions, jpeg;

type
  TParamAfficheChargeARepartir = Record
   Affiche:Boolean;
   AffichageModal:Boolean;
   Quand:Integer;
   TitreForm:String;
   SousTitreForm:String;
   end;

   TChargeARepartir_Isa = class(TForm)
    Patitre: TPanel;
    PaLabel: TPanel;
    PaBtn: TPanel;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    PaBas: TPanel;
    PaGrille: TPanel;
    BtnImprimer: TButton;
    BtnAnnuler: TButton;
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
    DBCAR: TGrDBGrid;
    N2: TMenuItem;
    Prcdent1: TMenuItem;
    Suivant1: TMenuItem;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    RxLabTitre: TRxLabel;
    ImEnTete: TImage;
    RxSpeedButton1: TRxSpeedButton;
    RxSpeedButton2: TRxSpeedButton;
    Label6: TLabel;
    EdCompte: TEdit;
    EdLibelle: TEdit;
    Label1: TLabel;
    EdDate: TDateEdit;
    PaCumul1: TPanel;
    Panel7: TPanel;
    GrGrid1: TGrGrid;
    RxSBImport: TRxSpeedButton;
    imprimerlachargecourante1: TMenuItem;
    RxMAJ_Balance: TRxSpeedButton;
    Exporter1: TMenuItem;
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
    procedure DBCARKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBCARColExit(Sender: TObject);
    procedure ChangementEtatBoutons(Sender: TObject);
    procedure ChangementEtatCaption(Sender: TObject);
    procedure ChangementEtatGrille(Sender: TObject);
    procedure Enregistrement;
    procedure PatitreResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure RxSpeedButton2Click(Sender: TObject);
    procedure RxSpeedButton1Click(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Aideenligne1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure RxSBInfoVersionClick(Sender: TObject);
    Procedure PositionTotaux;
    procedure RxSBImportClick(Sender: TObject);
    Procedure GereAccesEcran;
    Procedure GestionInitDM;
    procedure imprimerlachargecourante1Click(Sender: TObject);
    procedure RxMAJ_BalanceClick(Sender: TObject);
    procedure RxMAJ_BalanceMouseEnter(Sender: TObject);
    procedure RxMAJ_BalanceMouseLeave(Sender: TObject);
    procedure RxMAJ_BalanceMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure FormDeactivate(Sender: TObject);
    procedure Exporter1Click(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    TitreForm,SousTitreForm:String;
    Quand:Integer;
  end;

var
  ChargeARepartir_Isa: TChargeARepartir_Isa;
  Mark: TBookMark;
  LastSize:integer;
  FlagChargeARepartirCourant:boolean;
Function ChargeARepartirAffiche(ParamAfficheChargeARepartir:TParamAfficheChargeARepartir):Boolean;


implementation

uses DMChargesRepartir, E2_Main,E2_Recherche,
  //UQReport,
  E2_AideAssist, DMAide,DMEcriture, DMPlanCpt, DMRecherche,
  DMImportation, LibClassObjetSenders,DMCorrection,DMExports, ImportDll;

{$R *.DFM}


Function ChargeARepartirAffiche(ParamAfficheChargeARepartir:TParamAfficheChargeARepartir):Boolean;
var
ParamDMChargeARepartir:TParamDMChargeRepartir;
Begin
 if (ChargeARepartir_Isa = nil) then ChargeARepartir_Isa:=TChargeARepartir_Isa.Create(Application.MainForm);
 if ((ParamAfficheChargeARepartir.Quand <> ChargeARepartir_Isa.Quand) and (ChargeARepartir_Isa.Visible=true)) then
   ChargeARepartir_Isa.Close;
 ChargeARepartir_Isa.Quand:=ParamAfficheChargeARepartir.Quand;
 if not empty(ParamAfficheChargeARepartir.TitreForm) then
   ChargeARepartir_Isa.TitreForm:=ParamAfficheChargeARepartir.TitreForm;
 ChargeARepartir_Isa.SousTitreForm:=ParamAfficheChargeARepartir.SousTitreForm;

 ParamDMChargeARepartir.ChargeARepartirDataStateChange := ChargeARepartir_Isa.changementEtatBoutons;
 ParamDMChargeARepartir.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ParamDMChargeARepartir.Quand := ChargeARepartir_Isa.Quand;

   case ChargeARepartir_Isa.Quand of
      C_Ouverture:Begin
                   InitialiseDMChargeARepartir(ParamDMChargeARepartir);
                  End;

      C_Cloture:Begin
                   InitialiseDMChargeARepartir(ParamDMChargeARepartir);
                End;
   end;

 if ParamAfficheChargeARepartir.Affiche then
  begin
   ChargeARepartir_Isa.DBCAR.DataSource := DMChargeRepartir.DataCar;
//   if AideCompte=nil then
//   AideCompte:=TAideCompte.Create(Application.MainForm); { isa  le  19/01/04 }

   if ParamAfficheChargeARepartir.AffichageModal then
     ChargeARepartir_Isa.ShowModal
    else
     ChargeARepartir_Isa.Show;
  end;
End;

//****************************************************************************//
// Procédure AideEnLigne.                                                     //
//****************************************************************************//
procedure TChargeARepartir_Isa.AideEnLigne(Sender: TObject);
var
   aa,result:boolean;
begin
try
//WinShape(ActiveControl,Shape1,shape2,Main.ContourCouleur);
if ((AideAssist <> nil) and (AideAssist.Visible)) then
Result:=DMAides.taAssist.FindKey([self.Name+inttostr(Quand),ActiveControl.Name]);
     if not Result then
        DMAides.taAssist.FindKey(['Vide','Vide']);
except;
end;
end;
//****************************************************************************//

procedure TChargeARepartir_Isa.Enregistrement;
begin
  try
    TableGerePost(DMChargeRepartir.TaCar);
  except
    abort;
  end;
end;

//****************************************************************************//
// Gestion du Show de la fenêtre.                                             //
//****************************************************************************//
procedure TChargeARepartir_Isa.FormShow(Sender: TObject);
var
   I: Integer;
begin
//DMChargeRepartir.Tag:=self.Tag;

     Case Quand Of
         // Si fenêtre d'ouverture
          C_Ouverture: Begin
                //DBCAR.LockedCols:=0;
                GrDbGridInitColonne(DBCAR,DMChargeRepartir.DataCar,DMChargeRepartir.TaCar,
                   ['Désignation','Mt total Charge','Mt Bilan Ouverture'],
                   ['Designation','MtTotalCharge','MtBilanOuverture']
                   ,E.FormatMonnaie,E.EditFormat);
                EdDate.Date:=E.DatExoDebut;
                RxLabTitre.Caption:='Ouverture - Charges à répartir sur plusieurs exercices';
                Patitre.Color:=$00ADEBFF;
                GrGrid1.ColCount:=2;
               // RxSBImport.Visible := ((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'));
                //For I:= 0 To 2 Do DBCAR.Columns[I].ReadOnly := False;
                //DBCAR.datasource.DataSet.Fields[].readonly:=false;
             End; // Fin fenêtre d'ouverture

          // Si fenêtre de clôture
          C_Cloture: Begin
                //DBCAR.LockedCols:=1;
//                GrDbGridInitColonne(DBCAR,DMChargeRepartir.DataCar,DMChargeRepartir.TaCar,
//                   ['Reprise','Désignation','Mt total Charge','Mt à Reprendre','Reprise exercice','Solde fin exercice'],
//                   ['Reprise','Designation','MtTotalCharge','MtBilanOuverture','MontantReprise','MtRestant']
//                   ,E.FormatMonnaie,E.EditFormat);
                GrDbGridInitColonne(DBCAR,DMChargeRepartir.DataCar,DMChargeRepartir.TaCar,
                   ['Désignation','Mt total Charge','Mt à Reprendre','Reprise exercice','Solde fin exercice'],
                   ['Designation','MtTotalCharge','MtBilanOuverture','MontantReprise','MtRestant']
                   ,E.FormatMonnaie,E.EditFormat);
                EdDate.Date:=E.DatExoFin;
                RxLabTitre.Caption:='Clôture - Charges à répartir sur plusieurs exercices';
                Patitre.Color:=$0033CCFF;
                GrGrid1.ColCount:=4;
                RxSBImport.Visible := False;
                //DBCAR.Columns[0].ReadOnly := True;
             End; // Fin fenêtre de clôture
     End; // Fin de Self.Quand

     ChangementEtatCaption(self);
     self.Realign;
     PaGrille.Realign;
     PaGrilleResize(PaGrille);

     EdCompte.Text := DM_C_CompteChargeARepartir;
     EdLibelle.Text := DMPlan.LibelleDuNumCptPCU(EdCompte.Text);
//     Case Quand Of
//          C_Ouverture: Begin //si ouverture
//               //on affiche les données dont la date de saisie
//               //correspond à la date de début d'exercice
//               FiltrageDataSet(DMChargeRepartir.tacar,'DateSaisie = '''+DateToStr(E.DatExoDebut-1)+'''');
//             End;
//          C_Cloture: Begin //si clôture
//               DeFiltrageDataSet(DMChargeRepartir.tacar);
//             End;
//     End;
//     DMChargeRepartir.FiltrageTable;
     DMChargeRepartir.TaCAR.First;
     DBCAR.SetFocus;
     DMChargeRepartir.DataCar.OnStateChange:=ChangementEtatBoutons;
     DMChargeRepartir.DataCar.OnStateChange(DMChargeRepartir.TaCar);



end;
//****************************************************************************//


//****************************************************************************//
// Initialisation à la création de la fenêtre.                                //
//****************************************************************************//
procedure TChargeARepartir_Isa.FormCreate(Sender: TObject);
begin
    try
      LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        InitialiseFormPosDefaut(self);
	//Left:= 30; Top:= 70; Width:= screen.Width-60; Height:= screen.Height-top-30;
    end;
 LastSize:=0;
 FlagChargeARepartirCourant:=false;    
case Quand of
   C_Ouverture:Begin
       GrGrid1.ColCount:=2;
     End;

   C_Cloture:Begin
       GrGrid1.ColCount:=4;
     End;
end;
end;
//****************************************************************************//


//****************************************************************************//

Procedure TChargeARepartir_Isa.InitialiseTable_A_Nil;
Begin
    if DMChargeRepartir<>nil then
    InitDatasetEvent_A_Nil_Sur_Form([DMChargeRepartir.DataCar]);
End;

//****************************************************************************//
// Libération de la mémoire.                                                  //
//****************************************************************************//
procedure TChargeARepartir_Isa.FormDestroy(Sender: TObject);
begin
     InitialiseTable_A_Nil;
     LibGestionParamXML.DestroyForm(Self,E.USer);
     if DMChargeRepartir<>nil then
       DMChargeRepartir.Free;
     ChargeARepartir_Isa:=Nil;
end;

//******************* ChangementEtatBoutons *************************
procedure TChargeARepartir_Isa.ChangementEtatBoutons(Sender: TObject);
var
TotauxGeneric:TTotauxGeneric;
begin
   case DMChargeRepartir.TaCar.State of
   dsBrowse	: begin
            BtnEnregistrer.Enabled:=false;
            BtnInserer.Enabled:=true;
            BtnModifier.Enabled:=(Not(DMChargeRepartir.TaCAR.RecordCount = 0));
            BtnSupprimer.Enabled:=(Not(DMChargeRepartir.TaCAR.RecordCount = 0));
            BtnImprimer.Enabled:=true;
            dbcar.OnColExit:=nil;
            case Quand of
               C_Ouverture:Begin
                   FiltrageDataSet(DMRech.TaChargesRepartirRech,dbcar.DataSource.DataSet.Filter);
                   TotauxGeneric:=SommeTotauxGeneric(['MtTotalCharge','MtBilanOuverture'],DMRech.TaChargesRepartirRech);
                   GrGrid1.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total1);
                   GrGrid1.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total2);
                   DeFiltrageDataSet(DMRech.TaChargesRepartirRech);
                 End;

               C_Cloture:Begin
                   FiltrageDataSet(DMRech.TaChargesRepartirRech,dbcar.DataSource.DataSet.Filter);
                   TotauxGeneric:=SommeTotauxGeneric(['MtTotalCharge','MtBilanOuverture','MontantReprise'],DMRech.TaChargesRepartirRech);
                   GrGrid1.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total1);
                   GrGrid1.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total2);
                   GrGrid1.cells[2,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total3);
                   GrGrid1.cells[3,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total2-TotauxGeneric.Total3);
                   DeFiltrageDataSet(DMRech.TaChargesRepartirRech);
                 End;
            end;

           end;

   dsEdit:   begin
               EnableWinControl([BtnAnnuler,BtnEnregistrer,BtnFermer],True);
               EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer,BtnImprimer],False);
               dbcar.OnColExit:=DBCARColExit;
             end;

   dsInsert: begin
               EnableWinControl([BtnAnnuler,BtnFermer],True);
               EnableWinControl([BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnImprimer],False);
               dbcar.OnColExit:=DBCARColExit;
             end;
   end;//fin du case.state
   //Pop-up Menu
   Fermer1.Enabled:=BtnFermer.Enabled;
   Insrer1.Enabled:=BtnInserer.Enabled;
   Enregister1.Enabled:=BtnEnregistrer.Enabled;
   Modifier1.Enabled:=BtnModifier.Enabled;
   Supprimer1.Enabled:=BtnSupprimer.Enabled;
   Imprimer1.Enabled:=BtnImprimer.Enabled;

   ChangementEtatCaption(self);//appel d'une procédure de changement
   //des captions en fonction de l'état de la table
   ChangementEtatGrille(self); //appel d'une procédure de changement
   //d'état de la grille en fonction de l'état de la table
GereAccesEcran;
end;




//******************* ChangementEtatCaption *************************
procedure TChargeARepartir_Isa.ChangementEtatCaption(Sender: TObject);
begin
Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DMChargeRepartir.TaCar);
end;


//******************* ChangementEtatGrille *************************
procedure TChargeARepartir_Isa.ChangementEtatGrille(Sender: TObject);
var I:integer;
begin
dbcar.OnColExit:=nil;
  case DMChargeRepartir.TaCar.State of
    dsinsert : begin //si table en insertion
                 DBCAR.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
                 Case Quand Of
                 C_Cloture: Begin //si clôture
                         dbcar.DataSource.DataSet.Fields[2].FocusControl;
                         //InitChampReadOnly(dbcar.DataSource.DataSet,[2,3,7],false);
                         dbcar.Columns[0].ReadOnly:=false;
                         dbcar.Columns[1].ReadOnly:=false;
                         dbcar.Columns[3].ReadOnly:=false;
                         //InitChampReadOnly(dbcar.DataSource.DataSet,[6],true);
                    End;
                 End; // Fin du Case.Quand
               DBCAR.SetFocus;
               DBCAR.TitreColor(true);
               end;// fin insertion
    dsbrowse : begin //si table en consultation
                DBCAR.Options := [dgediting,dgtitles,dgindicator,dgrowlines,dgcollines,dgtabs];
                DBCAR.TitreColor(true);
                 Case Quand Of
                 C_Cloture: begin //si clôture
                         If DMChargeRepartir.TaCARDateSaisie.AsDateTime = E.DatExoDebut-1 Then
                            dbcar.DataSource.DataSet.Fields[7].FocusControl
                         Else
                            dbcar.DataSource.DataSet.Fields[2].FocusControl;
                    End;
                 End;//fin du case.Quand
               if DBCAR.InplaceEditor <> nil then
                  DBCAR.EditorMode:=false;
               end;//fin de consultation
    dsEdit : begin //si table en modification
               DBCAR.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               DBCAR.SetFocus;
               DBCAR.TitreColor(true);
               If Quand = C_Cloture Then//si clôture
               Begin
                    If DMChargeRepartir.TaCarDateSaisie.AsDateTime = E.DatExoDebut-1 Then
                    Begin //si date début Exercice
                         dbcar.DataSource.DataSet.Fields[7].FocusControl;
                         dbcar.Columns[3].ReadOnly:=false;
                         dbcar.Columns[0].ReadOnly:=true;
                         dbcar.Columns[1].ReadOnly:=true;
                         dbcar.Columns[2].ReadOnly:=true;
                         //InitChampReadOnly(dbcar.DataSource.DataSet,[7],false);
                         //InitChampReadOnly(dbcar.DataSource.DataSet,[2,3,4],true);
//                         InitChampReadOnly(dbcar.DataSource.DataSet,[6,2,3,4],true);
                    End //fin date début
                    Else //si date fin Exercice
                    Begin
                         //dbcar.DataSource.DataSet.Fields[2].FocusControl;
                         dbcar.Columns[2].ReadOnly:=true;
                         dbcar.Columns[0].ReadOnly:=false;
                         dbcar.Columns[1].ReadOnly:=false;
                         dbcar.Columns[3].ReadOnly:=false;

//                         InitChampReadOnly(dbcar.DataSource.DataSet,[2,3,7],false);
//                         InitChampReadOnly(dbcar.DataSource.DataSet,[4],true);
                         //InitChampReadOnly(dbcar.DataSource.DataSet,[6,4],true);
                    End;//fin date fin
               End;//fin Quand=C_Cloture
         End;//fin modification
  end;//fin du case.state
  dbcar.OnColExit:=DBCARColExit;
end;


//****************************************************************************//
// Permet d'insérer une charge à répartir.                                    //
//****************************************************************************//
procedure TChargeARepartir_Isa.BtnInsererClick(Sender: TObject);
begin
TableAjoute(DMChargeRepartir.TaCar);
end;
//****************************************************************************//


//****************************************************************************//
// Permet de fermer la fenêtre.                                               //
//****************************************************************************//
procedure TChargeARepartir_Isa.BtnFermerClick(Sender: TObject);
begin
     Self.Close;
end;
//****************************************************************************//


//****************************************************************************//
// Permet de supprimer la charge sélectionnée par l'utilisateur.              //
//****************************************************************************//
procedure TChargeARepartir_Isa.BtnSupprimerClick(Sender: TObject);
begin
//DMChargeRepartir.TaCar.Database.StartTransaction;
//DMChargeRepartir.TaCar.Database.TransIsolation:=tiDirtyRead;

   try
   TableGereDelete(DMChargeRepartir.TaCar);
   except
      begin
      abort;
      end;
//   raise;
   end;
//DMChargeRepartir.TaCar.Refresh;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion des touches alphanumériques.                                       //
//****************************************************************************//
procedure TChargeARepartir_Isa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
FlagChargeARepartirCourant:=(ssCtrl in Shift);
     If Key = VK_ESCAPE Then
     Begin

       If DMChargeRepartir.TaCar.State = dsBrowse Then
          begin
            if DBCAR.Focused then Self.Close else DBCAR.SetFocus;
          end;

      If DMChargeRepartir.TaCar.State = dsInsert Then
          Begin
               If Messagedlg('Voulez vous annuler la création de cette charge à répartir ?',MtConfirmation,[mbno,mbyes],0) = mryes Then
               Begin
                    DMChargeRepartir.TaCar.Cancel;
                    Abort;
               End
               Else
               Begin
                    Abort;
               End;
          End;

          If DMChargeRepartir.TaCar.State = dsEdit Then
          Begin
               If Messagedlg('Annuler les modifications de cette charge à répartir ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    DMChargeRepartir.TaCAR.Cancel;
                    Abort;
               End
               Else
               Begin
                    Abort;
               End
          End;
    end;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click sur le bouton Modifier.                                   //
//****************************************************************************//
procedure TChargeARepartir_Isa.BtnModifierClick(Sender: TObject);
begin
  DMChargeRepartir.TaCar.Edit;
end;
//****************************************************************************//



//****************************************************************************//
// Gestion du click sur le bouton Enregistrer.                                //
//****************************************************************************//
procedure TChargeARepartir_Isa.BtnEnregistrerClick(Sender: TObject);
begin
  if DMChargeRepartir.TaCar.State in  [dsinsert,dsedit] then
     begin
     Enregistrement;
//     DBCAR.SelectedIndex:=0;
     DBCAR.SetFocus;
     end;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion des touches dans la grille.                                        //
//****************************************************************************//
procedure TChargeARepartir_Isa.DBCARKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if DMChargeRepartir.DataCar.State in [dsBrowse] then
 if not DBCAR.ReadOnly then
   if ((key=VK_INSERT) and (Shift=[ssCtrl])) then BtnInserer.Click;
end;
//****************************************************************************//



//****************************************************************************//
// Permet de contrôler la saisie de l'utilisateur dans la grille.             //
//****************************************************************************//
procedure TChargeARepartir_Isa.DBCARColExit(Sender: TObject);
var retourFonction:TErreurSaisie;
begin
if dbcar.DataSource.DataSet.State in [dsinsert,dsEdit] then
   begin
   // appel de la fonction de contrôle de saisie
   retourFonction:=DMChargeRepartir.CtrlSaisieChargesRepartir(DBCAR.SelectedField);
           if  RetourFonction.Retour=false then
            begin
              case Quand of
              C_Ouverture:begin //si ouverture
                end;//fin ouverture
              C_Cloture:begin
                   case  RetourFonction.CodeErreur of
                       3200:
                         begin // erreur de saisie, resaisir
//                         dbcar.SelectedIndex:=3;
                         dbcar.DataSource.DataSet.Fields[3].FocusControl;
                         abort;
                         end;
                       4202:
                         begin // erreur de saisie, resaisir
                         //dbcar.SelectedIndex:=3;
                         dbcar.DataSource.DataSet.Fields[4].FocusControl;
                         abort;
                         end;
                       7203:
                         begin // erreur de saisie, resaisir
                         //dbcar.SelectedIndex:=4;
                         dbcar.DataSource.DataSet.Fields[7].FocusControl;
                         abort;
                         end;
                   end; //fin du case codeErreur
                end;//fin de clôture

              end;//fin case.Quand
              DBCAR.SetFocus
            end
            else //si le retour=true (il n'y a pas d'erreur)
            begin
              case Quand of
                C_Ouverture: begin //si ouverture
                    if (dbcar.SelectedField.FieldNo =3) and (DMChargeRepartir.TaCar.State<>dsbrowse) then
                       begin
                         BtnEnregistrer.Enabled:=true;
                         Enregister1.Enabled:=true;
                       end;
                   end;

                C_Cloture: begin //si clôture
                    if (dbcar.SelectedField.FieldNo =3) and (DMChargeRepartir.TaCar.State<>dsbrowse) then
                       begin
                         BtnEnregistrer.Enabled:=true;
                         Enregister1.Enabled:=true;
                       end;
                    if  dbcar.SelectedField.FieldNo =4 then
                       dbcar.DataSource.DataSet.Fields[7].FocusControl;
                       //dbcar.SelectedIndex:=4;
                   end;
              end;//fin du case.Quand
            end;//si le retour=true(il n'y a pas d'erreur)
   end;
end;
//****************************************************************************//

procedure TChargeARepartir_Isa.PatitreResize(Sender: TObject);
begin
//RxSpeedButton1.top:=12;
RxSpeedButton1.Left:=Patitre.Width-104;
//RxSpeedButton1.Width:=Patitre.Width-2;
//RxSpeedButton1.Height:=Patitre.Height-24;
end;

procedure TChargeARepartir_Isa.FormResize(Sender: TObject);
begin
if self.Width < 450 then
     if LastSize > self.Width
       then
           begin
          LastSize:=self.Width;
//           self.Width:=450;
           abort;
           end;
LastSize:=self.Width;

end;

procedure TChargeARepartir_Isa.PaGrilleResize(Sender: TObject);
begin
if DBCAR.DataSource <> nil then
 begin
  DBCAR.DataSource.DataSet.close;
  case Quand of
     C_Ouverture:Begin
        FormateTailleColonne(DBCAR,9,[4,2,2]);
        GrGrid1.ColCount:=2;
        PositionTotaux;
       End;

     C_Cloture:Begin
  //      FormateTailleColonne(DBCAR,29,[2,9,4,4,4,4]);
        FormateTailleColonne(DBCAR,29,[9,4,4,4,4]);
        GrGrid1.ColCount:=4;
        PositionTotaux;
       End;
  end;
  DBCAR.DataSource.DataSet.open;
  WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
 end;
end;

procedure TChargeARepartir_Isa.RxSpeedButton2Click(Sender: TObject);
begin
case Quand of
//   1:Main.Stoks1Click(Main.Stoks1);
   C_Ouverture:Main.DettetCreancesClick(Main.DettetCreances);
   C_Cloture:Main.Chargespayeretproduitsrecevoir3Click(Main.Chargespayeretproduitsrecevoir3) ;
end;


end;

procedure TChargeARepartir_Isa.RxSpeedButton1Click(Sender: TObject);
begin
 case Quand of
    C_Ouverture:Main.Cetpconstatsdavance1Click(Main.Cetpconstatsdavance1);
    C_Cloture:Main.Dpensedelentreprise1Click(Main.Dpensedelentreprise1) ;
 end;
end;

procedure TChargeARepartir_Isa.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TChargeARepartir_Isa.Aide1Click(Sender: TObject);
begin
 If activecontrol = DBCAR Then
  begin
   case DBCAR.DataSource.State of
      dsbrowse:case Quand of
                  C_Ouverture:case DBCAR.SelectedField.FieldNo of
                     3:Rechercher(DBCAR,DMChargeRepartir.TaCar,['Designation','DateSaisie'],['Désignation','Date Saisie'],'',0);
//                     1:Rechercher(DBCAR,DMChargeRepartir.TaCar,['Designation','Reference','DateSaisie'],['Désignation','Références',''],'',0);
                    end;
                  C_Cloture:case DBCAR.SelectedField.FieldNo of
                     7:Rechercher(DBCAR,DMChargeRepartir.TaCar,['Reference','Designation','DateSaisie'],['Références','Désignation','Date Saisie'],'',0);
                     3:Rechercher(DBCAR,DMChargeRepartir.TaCar,['Designation','Reference','DateSaisie'],['Désignation','Références','Date Saisie'],'',0);
                    end;
               end;


   end;
 end;

end;

procedure TChargeARepartir_Isa.BtnImprimerClick(Sender: TObject);
var
Site:TEditLien;
//ObjPrn:TObjetEdition;
ListeValeur:TStringList;
i:integer;
begin
case Quand of
   C_Ouverture:begin
               case E.Type_Edition of
                   C_IMP_MOZiLLA_LOCAL:Begin
                         EditionChargeRepartir(C_EditionSimple,C_Ouverture,DMChargeRepartir.TaCar,nil,Site);

                                       End;

                   C_IMP_NORMAL:Begin
                                 if FlagChargeARepartirCourant then
                                 EditionChargeRepartirL(C_EditionSimple,C_Ouverture,nil,DMChargeRepartir.TaCar.FindField('id').AsString,Site)
                                 else
                                 EditionChargeRepartirL(C_EditionSimple,C_Ouverture,nil,nil,Site);
                                 FlagChargeARepartirCourant:=False;
                                End;

                   C_IMP_MOZiLLA_WEB:Begin

                                     End;

                   else showmessage('Type_Edition non défini');
                 end;
             end;
   C_Cloture:begin
                case E.Type_Edition of
                   C_IMP_MOZiLLA_LOCAL:Begin
                         EditionChargeRepartir(C_EditionSimple,C_Cloture,DMChargeRepartir.TaCar,nil,Site);
                                       End;

                   C_IMP_NORMAL:Begin
                                 if FlagChargeARepartirCourant then
                                 EditionChargeRepartirL(C_EditionSimple,C_Cloture,nil,DMChargeRepartir.TaCar.FindField('id').AsString,Site)
                                 else
                                 EditionChargeRepartirL(C_EditionSimple,C_Cloture,nil,nil,Site);
                                 FlagChargeARepartirCourant:=False;
                                End;

                   C_IMP_MOZiLLA_WEB:Begin

                                     End;

                   else showmessage('Type_Edition non défini');
                   end;
              end;
//
end;
end;

procedure TChargeARepartir_Isa.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
try//finally
canclose:=true;
  try//except
      if DMChargeRepartir <> nil then
       begin
        // Si l'utilisateur est en mode Insertion
           If DMChargeRepartir.TaCar.State = dsInsert Then
           Begin
             self.WindowState:=wsNormal;
                self.BringToFront;
                If BtnEnregistrer.Enabled Then
                Begin
                     If Messagedlg('Voulez-vous enregistrer cette nouvelle charge ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                       begin
                         Enregistrement;
                        end
                        else
                         begin
                         DMChargeRepartir.TaCar.Cancel;
                         end;
                End
                Else
                Begin
                     If Messagedlg('Voulez-vous annuler la création de cette charge ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                      begin
                         DMChargeRepartir.TaCar.Cancel;
                      end
                     Else
                       begin
                        canclose:=false;
                        end;
                End;
           End; // Fin utilisateur est en mode Insertion

           // Si l'utilisateur est en mode Modification
           If DMChargeRepartir.TaCar.State = dsEdit Then
           Begin
             self.WindowState:=wsNormal;
             self.BringToFront;
                If Messagedlg('Voulez-vous enregistrer les modifications de cette charge ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                 begin
                  Enregistrement;
                   end
                   else
                   begin
                    DMChargeRepartir.TaCar.Cancel;
                   end;
           End; // Fin utilisateur est en mode Modification

           // Si l'utilisateur est en train de clôturer ses stocks
           If Quand = C_Cloture Then
      //                 begin//si on a trouvé des charges à repartir
                           try
                           initChampReadOnly(DBCAR.DataSource.DataSet,[2,3,4,6,7],false);
                           if DMChargeRepartir.FiltrageTablePourRepriseouverture then
                             begin
                               DMChargeRepartir.CreationODChargeOuverture;
                               affichageOD:=true;
                             end;
                           if DMChargeRepartir.FiltrageTablePourRepriseCloture then
                             begin
                               DMChargeRepartir.CreationODChargeCloture;
                               affichageOD:=true;
                             end;

                          except
                             begin
                             showmessage('Problème à la création des OD ');
                             DMChargeRepartir.DataCar.OnStateChange:=ChangementEtatBoutons;
                             abort;
                             end;
                          end;
                       try
                       if affichageOD then
                         DMChargeRepartir.DemandeAffichageReprise;
                       except
                         canclose:=true;
                       end;
                       Quand:=-1; // initialisation du tag sinon plusieurs passage
      //                 end;//fin si on a trouvé des charges à repartir
                   end;//fin si cloture

      AssistantClotRafraichit(2);

//          if ((Cloture_Def<>nil)and(ActivationForm(Cloture_Def))) then // PB
//           begin
//              if Cloture_Def.EtapeSuivante>=5 then
//                Cloture_Def.EtapeSuivante:=4;{ isa  le  16/09/03 }
//           end;
  except
    canclose:=false;
  end;
finally
  affichageOD:=false;
  if CanClose=false then
   begin
     if AideCompte=nil then
       AideCompte:=TAideCompte.Create(self);
   end
  else InitialiseTable_A_Nil; { isa  le  29/01/04 } 
end;
end;

procedure TChargeARepartir_Isa.Aideenligne1Click(Sender: TObject);
var
   aa,result:boolean;
begin
try
if AideAssist = Nil then AideAssist:= TAideAssist.Create(Self);
Result:=DMAides.taAssist.FindKey([self.Name+inttostr(Quand),ActiveControl.Name]);
     if not Result then
        DMAides.taAssist.FindKey(['Vide','Vide']);

if AideAssist.Visible then
     begin
      AideAssist.close;
      self.show;
     end
     else begin
      AideAssist.Show;
      self.show;
     end;
except;
end;

end;

procedure TChargeARepartir_Isa.FormActivate(Sender: TObject);
begin
GestionInitDM;
initialisationMAJ_Balance(RxMAJ_Balance);
Initialiser_ShortCut_Main(true);
Patitre.visible:=Main.AfficheTitre;
affichageOD:=false;
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

DBCAR.ParamColor:=true;
DBCAR.Param:=ParamUtil.CouleurDBGrid;
DBCAR.UpDateColor;

  GrGrid1.ParamColor:=true;
  GrGrid1.Param:=ParamUtil.CouleurDBGrid;
  GrGrid1.DessineContourLigne:=false;
  GrGrid1.UpDateColor;
  GrGrid1.FixedColor:=ParamUtil.CouleurDBGrid.GrilleColorFond;

 CouleurFond([PaTools,PaBtn,PaBas,PaLabel],ParamUtil.CouleurPanelCorps);
 GereAccesEcran;
end;

procedure TChargeARepartir_Isa.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TChargeARepartir_Isa.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TChargeARepartir_Isa.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TChargeARepartir_Isa.Visualisation1Click(Sender: TObject);
begin
DetailEcritureCompte(EdCompte.Text,true,False);
end;

procedure TChargeARepartir_Isa.RxSBInfoVersionClick(Sender: TObject);
begin
Showmessage(ChargeARepartir_IsaRxSBInfoVersionWarning+numVersion.messageVersion);
end;

Procedure TChargeARepartir_Isa.PositionTotaux;
Begin
  case Quand of
     C_Ouverture:Begin
        Panel7.Width:=RenvoiTailleColonne(DBCAR,[0,1])+10;
        GrGrid1.ColWidths[0]:=RenvoiTailleColonne(DBCAR,[2]);
        GrGrid1.ColWidths[1]:=RenvoiTailleColonne(DBCAR,[3]);
       End;

     C_Cloture:Begin
//        Panel7.Width:=RenvoiTailleColonne(DBCAR,[0,1,2])+10;
//        GrGrid1.ColWidths[0]:=RenvoiTailleColonne(DBCAR,[3]);
//        GrGrid1.ColWidths[1]:=RenvoiTailleColonne(DBCAR,[4]);
//        GrGrid1.ColWidths[2]:=RenvoiTailleColonne(DBCAR,[5]);
//        GrGrid1.ColWidths[3]:=RenvoiTailleColonne(DBCAR,[6]);
        Panel7.Width:=RenvoiTailleColonne(DBCAR,[0,1])+10;
        GrGrid1.ColWidths[0]:=RenvoiTailleColonne(DBCAR,[2]);
        GrGrid1.ColWidths[1]:=RenvoiTailleColonne(DBCAR,[3]);
        GrGrid1.ColWidths[2]:=RenvoiTailleColonne(DBCAR,[4]);
        GrGrid1.ColWidths[3]:=RenvoiTailleColonne(DBCAR,[5]);
       End;
  end;
End;
procedure TChargeARepartir_Isa.RxSBImportClick(Sender: TObject);
begin
  DMChargeRepartir.TaCar.DisableControls;
  DMImport.Import_ChARepartir(DMChargeRepartir.TaCar,True);
  changementEtatBoutons(DMChargeRepartir.TaCar);
  DMChargeRepartir.TaCar.EnableControls;

end;

Procedure TChargeARepartir_Isa.GereAccesEcran;
begin
  case Quand of
     C_Ouverture:Begin
                  DBCAR.ReadOnly := not E.AccesOuverture;
                  DBCAR.FSauteColReadOnly := not DBCAR.ReadOnly;
                  EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer],E.AccesOuverture);
                  EnableItemMenu([Insrer1,Modifier1,Supprimer1],E.AccesOuverture);
                 End;

     C_Cloture:Begin
                  DBCAR.ReadOnly := not E.AccesCloture;
                  DBCAR.FSauteColReadOnly := not DBCAR.ReadOnly;
                  EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer],E.AccesCloture);
                  EnableItemMenu([Insrer1,Modifier1,Supprimer1],E.AccesCloture);
               End;
  end;
DMChargeRepartir.GestionAccesChargesRepartir;
end;

Procedure TChargeARepartir_Isa.GestionInitDM;
var
ParamDMChargeRepartir:TParamDMChargeRepartir;
Begin
 ParamDMChargeRepartir.ChargeARepartirDataStateChange := changementEtatBoutons;
 ParamDMChargeRepartir.Quand := Quand;
 ParamDMChargeRepartir.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 InitialiseDMChargeARepartir(ParamDMChargeRepartir);
End;
procedure TChargeARepartir_Isa.imprimerlachargecourante1Click(
  Sender: TObject);
begin
FlagChargeARepartirCourant:=true;
BtnImprimer.Click;
end;

procedure TChargeARepartir_Isa.RxMAJ_BalanceClick(Sender: TObject);
begin
Activation_Desactivation_MAJ_Balance;
initialisationMAJ_Balance(RxMAJ_Balance);
end;

procedure TChargeARepartir_Isa.RxMAJ_BalanceMouseEnter(Sender: TObject);
begin
(Sender as TRxSpeedButton).Font.Color:=clREd;
(Sender as TRxSpeedButton).Font.Style:=[fsBold];
end;

procedure TChargeARepartir_Isa.RxMAJ_BalanceMouseLeave(Sender: TObject);
begin
(Sender as TRxSpeedButton).Font.Color:=clWindowText;
(Sender as TRxSpeedButton).Font.Style:=[];
end;

procedure TChargeARepartir_Isa.RxMAJ_BalanceMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
initialisationMAJ_Balance(RxMAJ_Balance);
end;

procedure TChargeARepartir_Isa.FormDeactivate(Sender: TObject);
begin
e.TypeMAJBalance:=MAJ_Normal;
initialisationMAJ_Balance(RxMAJ_Balance);
end;

procedure TChargeARepartir_Isa.Exporter1Click(Sender: TObject);
begin
if Quand=c_ouverture then
ExportDonnees(DBCAR.DataSource.DataSet,E.RepertoireExportDossier,'Ch_Repartir_Ouv_'+E.NomDossier + E.NomExo + '.Txt')
else
ExportDonnees(DBCAR.DataSource.DataSet,E.RepertoireExportDossier,'Ch_Repartir_Clôt_'+E.NomDossier + E.NomExo + '.Txt');
end;

procedure TChargeARepartir_Isa.Calculatrice1Click(Sender: TObject);
begin
if DBCAR.Col in [2,3,4] then
  AfficheCalculatrice(DBCAR)
else
  AfficheCalculatrice(nil);
end;

end.
