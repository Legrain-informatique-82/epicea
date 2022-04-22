unit Deduction;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Gr_Librairie_obj, E2_Librairie_obj, Grids, DBGrids, Db,
  DBTables,
  E2_AideCompte,
  LibSQL, Menus, Buttons,
  RXDBCtrl, ExRxDBGrid,DMBalances,DMPiece, RXCtrls, GrDBGrid,LibZoneSaisie,
  E2_AssistantClotureDef,LibRessourceString,E2_Decl_Records,
  E2_Cloture_Def,
  DMConstantes,LibGestionParamXML,
  ObjetEdition,
  GrGrid,
  lib_chaine,
  Utilisation_deduction,
   jpeg;

type

  TParamAfficheDeduction = Record
   Affiche:Boolean;
   AffichageModal:Boolean;
   TitreForm:String;
   SousTitreForm:String;
   end;


  TDeductions = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    RxSpeedButton1: TRxSpeedButton;
    RxSpeedButton2: TRxSpeedButton;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    PaBas: TPanel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnModifier: TButton;
    BtnInserer: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    PaCumul1: TPanel;
    Panel7: TPanel;
    GrGrid1: TGrGrid;
    PaGrille: TPanel;
    DBDeduction: TGrDBGrid;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    Exporter1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Modifier1: TMenuItem;
    Insrer1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    N2: TMenuItem;
    Prcdent1: TMenuItem;
    Suivant1: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    GrGrid2: TGrGrid;
    Utilisations: TMenuItem;
    N3: TMenuItem;
    BtnUtilisations: TButton;
    Label1: TLabel;

    procedure ChangementEtatBoutons(Sender: TObject);
    procedure ChangementEtatGrille(Sender: TObject);
    procedure ChangementEtatCaption(Sender: TObject);
    procedure DBDeductionColExit(Sender: TObject);
    Procedure GereAccesEcran;
    procedure FormActivate(Sender: TObject);
    Procedure GestionInitDM;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Enregistrement;
    Procedure InitialiseTable_A_Nil;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    Procedure PositionTotaux;
    procedure PatitreResize(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
    procedure Exporter1Click(Sender: TObject);
    procedure RxSBInfoVersionClick(Sender: TObject);
    procedure RxSpeedButton2Click(Sender: TObject);
    procedure RxSpeedButton1Click(Sender: TObject);
    function InitReadOnlyChamp:boolean;
    procedure DBDeductionEnter(Sender: TObject);
    procedure DBDeductionShowEditor(Sender: TObject; Field: TField;
      var AllowEdit: Boolean);
    procedure BtnImprimerClick(Sender: TObject);
    procedure DBDeductionDblClick(Sender: TObject);

  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
    TitreForm,SousTitreForm:String;
  end;

var
  Deductions: TDeductions;
  LastSize:integer;
  FlagDeductionCourant:boolean;

  Function DeductionAffiche(ParamAfficheDeduction:TParamAfficheDeduction):Boolean;
implementation

uses DMDeductions, E2_Main,E2_Recherche,
   DMRecherche,
   LibClassObjetSenders,DMCorrection,DMExports, ImportDll;



{$R *.dfm}


Function DeductionAffiche(ParamAfficheDeduction:TParamAfficheDeduction):Boolean;
var
ParamDMDeduction:TParamDMDeduction;
Begin
 if (Deductions = nil) then Deductions:=TDeductions.Create(Application.MainForm);
 if not empty(ParamAfficheDeduction.TitreForm) then
   Deductions.TitreForm:=ParamAfficheDeduction.TitreForm
 else Deductions.TitreForm:=Deductions.RxLabTitre.Caption;
 Deductions.SousTitreForm:=ParamAfficheDeduction.SousTitreForm;

 ParamDMDeduction.DeductionDataStateChange := Deductions.changementEtatBoutons;
 ParamDMDeduction.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;

 InitialiseDMDeduction(ParamDMDeduction);


 if ParamAfficheDeduction.Affiche then
  begin
   Deductions.DBDeduction.DataSource := DMDeduction.DataDeduction;

   if ParamAfficheDeduction.AffichageModal then
     Deductions.ShowModal
    else
     Deductions.Show;
  end;

End;


procedure TDeductions.ChangementEtatBoutons(Sender: TObject);
var
TotauxGeneric:TTotauxGeneric;
Reste,TotalReste:currency;
begin
   case DMDeduction.TaDeduction.State of
   dsBrowse	: begin
            BtnEnregistrer.Enabled:=false;
            BtnInserer.Enabled:=true;
            BtnModifier.Enabled:=(Not(DMDeduction.TaDeduction.RecordCount = 0));
            BtnSupprimer.Enabled:=(Not(DMDeduction.TaDeduction.RecordCount = 0));
            BtnImprimer.Enabled:=true;
            DBDeduction.OnColExit:=nil;

           FiltrageDataSet(DMRech.TaDeductionRech,DBDeduction.DataSource.DataSet.Filter);
           TotauxGeneric:=SommeTotauxGeneric(['Mt_N','Mt_N1','Mt_N2','Mt_N3','Mt_N4','Mt_N5'],DMRech.TaDeductionRech);
           GrGrid1.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total1);
           GrGrid1.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total2);
           GrGrid1.cells[2,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total3);
           GrGrid1.cells[3,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total4);
           GrGrid1.cells[4,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total5);
           GrGrid1.cells[5,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total6);

           Reste:=0;
           TotalReste:=0;

           Reste :=TotauxGeneric.Total1-DMDeduction.RecupUtilisationDeduction(DMDeduction.Recup_IDDeductionNx('Mt_N').id).MontantUtilise;
           TotalReste:=TotalReste+Reste;
           GrGrid2.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',Reste);

           Reste :=TotauxGeneric.Total2-DMDeduction.RecupUtilisationDeduction(DMDeduction.Recup_IDDeductionNx('Mt_N1').id).MontantUtilise;
           TotalReste:=TotalReste+Reste;
           GrGrid2.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',Reste);

           Reste :=TotauxGeneric.Total3-DMDeduction.RecupUtilisationDeduction(DMDeduction.Recup_IDDeductionNx('Mt_N2').id).MontantUtilise;
           TotalReste:=TotalReste+Reste;
           GrGrid2.cells[2,0]:=FormatFloat(E.FormatMonnaie + ';; ',Reste);

           Reste :=TotauxGeneric.Total4-DMDeduction.RecupUtilisationDeduction(DMDeduction.Recup_IDDeductionNx('Mt_N3').id).MontantUtilise;
           TotalReste:=TotalReste+Reste;
           GrGrid2.cells[3,0]:=FormatFloat(E.FormatMonnaie + ';; ',Reste);

           Reste :=TotauxGeneric.Total5-DMDeduction.RecupUtilisationDeduction(DMDeduction.Recup_IDDeductionNx('Mt_N4').id).MontantUtilise;
           TotalReste:=TotalReste+Reste;
           GrGrid2.cells[4,0]:=FormatFloat(E.FormatMonnaie + ';; ',Reste);

           Reste :=TotauxGeneric.Total6-DMDeduction.RecupUtilisationDeduction(DMDeduction.Recup_IDDeductionNx('Mt_N5').id).MontantUtilise;
           TotalReste:=TotalReste+Reste;
           GrGrid2.cells[5,0]:=FormatFloat(E.FormatMonnaie + ';; ',Reste);
           
           GrGrid2.cells[6,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotalReste);

           DeFiltrageDataSet(DMRech.TaDeductionRech);


           end;

   dsEdit:   begin
               EnableWinControl([BtnAnnuler,BtnEnregistrer,BtnFermer],True);
               EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer,BtnImprimer],False);
               DBDeduction.OnColExit:=DBDeductionColExit;
             end;

   dsInsert: begin
               EnableWinControl([BtnAnnuler,BtnEnregistrer,BtnFermer],True);
               EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer,BtnImprimer],False);
               DBDeduction.OnColExit:=DBDeductionColExit;
             end;
   end;//fin du case.state
   //Pop-up Menu
   Fermer1.Enabled:=BtnFermer.Enabled;
   Insrer1.Enabled:=BtnInserer.Enabled;
   Enregister1.Enabled:=BtnEnregistrer.Enabled;
   Modifier1.Enabled:=BtnModifier.Enabled;
   Supprimer1.Enabled:=BtnSupprimer.Enabled;
   Imprimer1.Enabled:=BtnImprimer.Enabled;

   ChangementEtatCaption(self);//appel d'une proc�dure de changement
   //des captions en fonction de l'�tat de la table
   ChangementEtatGrille(self); //appel d'une proc�dure de changement
   //d'�tat de la grille en fonction de l'�tat de la table
GereAccesEcran;
end;

procedure TDeductions.ChangementEtatCaption(Sender: TObject);
begin
Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DMDeduction.TaDeduction);
end;


//******************* ChangementEtatGrille *************************
procedure TDeductions.ChangementEtatGrille(Sender: TObject);
var I:integer;
begin
DBDeduction.OnColExit:=nil;
  case DMDeduction.TaDeduction.State of
    dsinsert : begin //si table en insertion
                 DBDeduction.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
                         DBDeduction.DataSource.DataSet.Fields[1].FocusControl;
               DBDeduction.SetFocus;
               DBDeduction.TitreColor(true);
               end;// fin insertion
    dsbrowse : begin //si table en consultation
                DBDeduction.Options := [dgediting,dgtitles,dgindicator,dgrowlines,dgcollines,dgtabs];
                DBDeduction.TitreColor(true);
                DBDeduction.DataSource.DataSet.Fields[1].FocusControl;

               if DBDeduction.InplaceEditor <> nil then
                  DBDeduction.EditorMode:=false;
               end;//fin de consultation
    dsEdit : begin //si table en modification
               DBDeduction.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               DBDeduction.SetFocus;
               DBDeduction.TitreColor(true);
         End;//fin modification
  end;//fin du case.state
  DBDeduction.OnColExit:=DBDeductionColExit;
end;



//****************************************************************************//
// Permet de contr�ler la saisie de l'utilisateur dans la grille.             //
//****************************************************************************//
procedure TDeductions.DBDeductionColExit(Sender: TObject);
var retourFonction:TErreurSaisie;
begin
try//except
if DBDeduction.DataSource.DataSet.State in [dsinsert,dsEdit] then
   begin
   // appel de la fonction de contr�le de saisie
   retourFonction:=DMDeduction.CtrlSaisieDeduction(DBDeduction.SelectedField);
           if  RetourFonction.Retour=false then
            begin
               abort;
            end
            else //si le retour=true (il n'y a pas d'erreur)
            begin
              //
            end;//si le retour=true(il n'y a pas d'erreur)
   end;
InitReadOnlyChamp;
except
   DBDeduction.SelectedField.FocusControl;
   abort;
end;
end;
//****************************************************************************//


Procedure TDeductions.GereAccesEcran;
begin
DBDeduction.ReadOnly := not E.AccesCloture;
DBDeduction.FSauteColReadOnly := not DBDeduction.ReadOnly;
EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer],E.AccesCloture);
EnableItemMenu([Insrer1,Modifier1,Supprimer1],E.AccesCloture);

DMDeduction.GestionAccesDeductions;
end;

procedure TDeductions.FormActivate(Sender: TObject);
begin
GestionInitDM;
Initialiser_ShortCut_Main(true);
Patitre.visible:=Main.AfficheTitre;
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

DBDeduction.ParamColor:=true;
DBDeduction.Param:=ParamUtil.CouleurDBGrid;
DBDeduction.UpDateColor;

  GrGrid1.ParamColor:=true;
  GrGrid1.Param:=ParamUtil.CouleurDBGrid;
  GrGrid1.DessineContourLigne:=false;
  GrGrid1.UpDateColor;
  GrGrid1.FixedColor:=ParamUtil.CouleurDBGrid.GrilleColorFond;

  GrGrid2.ParamColor:=true;
  GrGrid2.Param:=ParamUtil.CouleurDBGrid;
  GrGrid2.DessineContourLigne:=false;
  GrGrid2.UpDateColor;
  GrGrid2.FixedColor:=ParamUtil.CouleurDBGrid.GrilleColorFond;

 CouleurFond([PaTools,PaBtn,PaBas],ParamUtil.CouleurPanelCorps);
 GereAccesEcran;
DBDeduction.FSauteLigne:=false;
end;

Procedure TDeductions.GestionInitDM;
var
ParamDMDeduction:TParamDMDeduction;
Begin
 ParamDMDeduction.DeductionDataStateChange := changementEtatBoutons;
 ParamDMDeduction.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 InitialiseDMDeduction(ParamDMDeduction);
 DBDeduction.DataSource.DataSet.Refresh;
End;


procedure TDeductions.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
try//finally
canclose:=true;
  try//except
      if DMDeduction <> nil then
       begin
        // Si l'utilisateur est en mode Insertion
           If DMDeduction.TaDeduction.State = dsInsert Then
           Begin
             self.WindowState:=wsNormal;
                self.BringToFront;
                If BtnEnregistrer.Enabled Then
                Begin
                     If Messagedlg('Voulez-vous enregistrer cette nouvelle d�duction ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                       begin
                         Enregistrement;
                        end
                        else
                         begin
                         DMDeduction.TaDeduction.Cancel;
                         end;
                End
                Else
                Begin
                     If Messagedlg('Voulez-vous annuler la cr�ation de cette d�duction ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                      begin
                         DMDeduction.TaDeduction.Cancel;
                      end
                     Else
                       begin
                        canclose:=false;
                        end;
                End;
           End; // Fin utilisateur est en mode Insertion

           // Si l'utilisateur est en mode Modification
           If DMDeduction.TaDeduction.State = dsEdit Then
           Begin
             self.WindowState:=wsNormal;
             self.BringToFront;
                If Messagedlg('Voulez-vous enregistrer les modifications de cette d�duction ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                 begin
                  Enregistrement;
                   end
                   else
                   begin
                    DMDeduction.TaDeduction.Cancel;
                   end;
           End; // Fin utilisateur est en mode Modification
     end;
      AssistantClotRafraichit(2);
  except
    canclose:=false;
  end;
finally
  if CanClose=false then
   begin
     if AideCompte=nil then
       AideCompte:=TAideCompte.Create(self);
   end
  else
    begin
      InitialiseTable_A_Nil; { isa  le  29/01/04 }
      DMDeduction.OnGEstInterfaceEvent:=nil;
    end;
end;
end;


procedure TDeductions.Enregistrement;
begin
  try
    TableGerePost(DMDeduction.TaDeduction);
  except
    abort;
  end;
end;

//****************************************************************************//


//****************************************************************************//

Procedure TDeductions.InitialiseTable_A_Nil;
Begin
if (DMDeduction<>nil) then
    InitDatasetEvent_A_Nil_Sur_Form([DMDeduction.DataDeduction]);
End;





procedure TDeductions.FormCreate(Sender: TObject);
begin
    try
      LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        InitialiseFormPosDefaut(self);
    end;
 LastSize:=0;
 FlagDeductionCourant:=false;
end;

procedure TDeductions.FormDestroy(Sender: TObject);
begin
     InitialiseTable_A_Nil;
     LibGestionParamXML.DestroyForm(Self,E.USer);
     if DMDeduction<>nil then
       DMDeduction.Free;
     Deductions:=Nil;
end;

procedure TDeductions.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
FlagDeductionCourant:=(ssCtrl in Shift);
     If Key = VK_ESCAPE Then
     Begin

       If DMDeduction.TaDeduction.State = dsBrowse Then
          begin
            if DBDeduction.Focused then Self.Close else DBDeduction.SetFocus;
          end;

      If DMDeduction.TaDeduction.State = dsInsert Then
          Begin
               If Messagedlg('Voulez vous annuler la cr�ation de cette d�duction ?',MtConfirmation,[mbno,mbyes],0) = mryes Then
               Begin
                    DMDeduction.TaDeduction.Cancel;
                    Abort;
               End
               Else
               Begin
                    Abort;
               End;
          End;

          If DMDeduction.TaDeduction.State = dsEdit Then
          Begin
               If Messagedlg('Annuler les modifications de cette d�duction ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    DMDeduction.TaDeduction.Cancel;
                    Abort;
               End
               Else
               Begin
                    Abort;
               End
          End;
    end;
end;


procedure TDeductions.FormResize(Sender: TObject);
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

procedure TDeductions.FormShow(Sender: TObject);
var
   I: Integer;
begin
RxLabTitre.Caption:='D�ductions pour investissements';
Patitre.Color:=$0033CCFF;
GrGrid1.ColCount:=6;
GrGrid2.ColCount:=7;

ChangementEtatCaption(self);
self.Realign;
PaGrille.Realign;
PaGrilleResize(PaGrille);

DMDeduction.TaDeduction.First;
DBDeduction.SetFocus;
DMDeduction.DataDeduction.OnStateChange:=ChangementEtatBoutons;
DMDeduction.DataDeduction.OnStateChange(DMDeduction.TaDeduction);
end;


procedure TDeductions.PaGrilleResize(Sender: TObject);
begin
if DBDeduction.DataSource <> nil then
 begin
  DBDeduction.DataSource.DataSet.close;
  FormateTailleColonne(DBDeduction,50,[10,5,5,5,5,5,5,5]);
  GrGrid1.ColCount:=6;
  GrGrid2.ColCount:=7;
  PositionTotaux;
  DBDeduction.DataSource.DataSet.open;
  WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
 end;
end;

procedure TDeductions.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer,BtnUtilisations],PaBtn,90,0);
end;

Procedure TDeductions.PositionTotaux;
Begin
Panel7.Width:=RenvoiTailleColonne(DBDeduction,[0,1])+10;
GrGrid1.ColWidths[0]:=RenvoiTailleColonne(DBDeduction,[2]);
GrGrid1.ColWidths[1]:=RenvoiTailleColonne(DBDeduction,[3]);
GrGrid1.ColWidths[2]:=RenvoiTailleColonne(DBDeduction,[4]);
GrGrid1.ColWidths[3]:=RenvoiTailleColonne(DBDeduction,[5]);
GrGrid1.ColWidths[4]:=RenvoiTailleColonne(DBDeduction,[6]);
GrGrid1.ColWidths[5]:=RenvoiTailleColonne(DBDeduction,[7]);
//GrGrid1.ColWidths[6]:=RenvoiTailleColonne(DBDeduction,[8]);

Panel2.Width:=RenvoiTailleColonne(DBDeduction,[0,1])+10;
GrGrid2.ColWidths[0]:=RenvoiTailleColonne(DBDeduction,[2]);
GrGrid2.ColWidths[1]:=RenvoiTailleColonne(DBDeduction,[3]);
GrGrid2.ColWidths[2]:=RenvoiTailleColonne(DBDeduction,[4]);
GrGrid2.ColWidths[3]:=RenvoiTailleColonne(DBDeduction,[5]);
GrGrid2.ColWidths[4]:=RenvoiTailleColonne(DBDeduction,[6]);
GrGrid2.ColWidths[5]:=RenvoiTailleColonne(DBDeduction,[7]);
GrGrid2.ColWidths[6]:=RenvoiTailleColonne(DBDeduction,[8]);
End;

procedure TDeductions.PatitreResize(Sender: TObject);
begin
RxSpeedButton1.Left:=Patitre.Width-104;
end;

procedure TDeductions.Aide1Click(Sender: TObject);
begin
 If activecontrol = DBDeduction Then
  begin
   case DBDeduction.DataSource.State of
      dsbrowse:
       case DBDeduction.SelectedField.FieldNo of
             7:Rechercher(DBDeduction,DMDeduction.TaDeduction,['','',''],['','',''],'',0);
             3:Rechercher(DBDeduction,DMDeduction.TaDeduction,['','',''],['','',''],'',0);
       end;
   end;
 end;
end;



procedure TDeductions.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TDeductions.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TDeductions.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TDeductions.BtnEnregistrerClick(Sender: TObject);
begin
  if DMDeduction.TaDeduction.State in  [dsinsert,dsedit] then
     begin
     Enregistrement;
     DBDeduction.SetFocus;
     end;
end;

procedure TDeductions.BtnModifierClick(Sender: TObject);
begin
  DMDeduction.TaDeduction.Edit;
end;

procedure TDeductions.BtnInsererClick(Sender: TObject);
begin
TableAjoute(DMDeduction.TaDeduction);
end;

procedure TDeductions.BtnSupprimerClick(Sender: TObject);
var
messagetmp:string;
begin
   try
   if DMDeduction.RecupUtilisationDeduction([DBDeduction.DataSource.DataSet.Findfield('id').AsInteger]).Nb_utilisations>0 then
      messagetmp:='Confirmez-vous la suppression de cette d�duction et toutes ses utilisations ?'
   else
      messagetmp:='Confirmez-vous la suppression de cette d�duction ?';
      if Application.MessageBox(Pchar(messagetmp),
     'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
     TableGereDelete(DMDeduction.TaDeduction);
   except
      begin
      abort;
      end;
   end;
end;

procedure TDeductions.BtnFermerClick(Sender: TObject);
begin
Self.Close;
end;

procedure TDeductions.Calculatrice1Click(Sender: TObject);
begin
if DBDeduction.Col in [2,3,4,5,6,7,8] then
  AfficheCalculatrice(DBDeduction)
else
  AfficheCalculatrice(nil);
end;

procedure TDeductions.Exporter1Click(Sender: TObject);
begin
ExportDonnees(DBDeduction.DataSource.DataSet,E.RepertoireExportDossier,'Deduction_'+E.NomDossier + E.NomExo + '.Txt');
end;

procedure TDeductions.RxSBInfoVersionClick(Sender: TObject);
begin
Showmessage(DeductionRxSBInfoVersionWarning+numVersion.messageVersion);
end;

procedure TDeductions.RxSpeedButton2Click(Sender: TObject);
begin
//
end;

procedure TDeductions.RxSpeedButton1Click(Sender: TObject);
begin
//
end;

Function TDeductions.InitReadOnlyChamp():boolean;
var
FieldName : string;
Increment : integer;
InfosDeduction:TInfosDeduction;
begin
FieldName := 'Mt_N';
Increment :=0;
InfosDeduction:=DMDeduction.InfosDeductionCourante;
  FieldName := 'Mt_N';
  Increment :=0;
  while (Increment<6)do
    begin
       if(FieldName<>InfosDeduction.ChampRemplie)then
          DBDeduction.DataSource.DataSet.FindField(FieldName).ReadOnly:=InfosDeduction.Remplie
       else DBDeduction.DataSource.DataSet.FindField(FieldName).ReadOnly:= false;
       inc(increment,1);
       FieldName:='Mt_N'+IntToStr(increment);
    end;
result:=InfosDeduction.Remplie;
//DBDeduction.FSauteColReadOnly:=E.ExerciceCloture;
end;
procedure TDeductions.DBDeductionEnter(Sender: TObject);
begin
InitReadOnlyChamp();

end;

procedure TDeductions.DBDeductionShowEditor(Sender: TObject; Field: TField;
  var AllowEdit: Boolean);
begin
InitReadOnlyChamp;
AllowEdit:=field.ReadOnly=false;
end;

procedure TDeductions.BtnImprimerClick(Sender: TObject);
begin
EditionDesDeductions(C_EditionSimple,false,nil,nil,'');
end;

procedure TDeductions.DBDeductionDblClick(Sender: TObject);
var
ParamAfficheUtilisationDeduction:TParamAfficheUtilisationDeduction;
begin
  try//finally
      try//except
        if DBDeduction.DataSource.DataSet.State in [dsinsert,dsedit]then
          BtnEnregistrer.Click;
        ParamAfficheUtilisationDeduction.AffichageModal := true;
        ParamAfficheUtilisationDeduction.Affiche := true;
        ParamAfficheUtilisationDeduction.TitreForm :='';
        ParamAfficheUtilisationDeduction.SousTitreForm := '';
        ParamAfficheUtilisationDeduction.DeductionCourante := DBDeduction.DataSource.DataSet.Findfield('id').AsInteger;
        if not UtilisationDeductionAffiche(ParamAfficheUtilisationDeduction) then abort;
      except
         abort;
      end;
  finally
  DBDeduction.DataSource.DataSet.Refresh;
  DMDeduction.DataDeduction.OnStateChange(DMDeduction.TaDeduction);
  end;
end;
end.