unit Utilisation_deduction;

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
  GrGrid, jpeg;

type

  TParamAfficheUtilisationDeduction = Record
   Affiche:Boolean;
   AffichageModal:Boolean;
   TitreForm:String;
   SousTitreForm:String;
   DeductionCourante:integer;
   end;

  TUtilisation_Deductions = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
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
    GrGridTotaux: TGrGrid;
    PaGrille: TPanel;
    DBUtilisationDeductions: TGrDBGrid;
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
    PaLabel: TPanel;
    PaTitreG: TPanel;
    Label1: TLabel;
    LaLibelleDeduction: TLabel;
    Label3: TLabel;
    LaExerciceDeduction: TLabel;
    PaReste: TPanel;
    Panel2: TPanel;
    GrGridReste: TGrGrid;
    Label2: TLabel;
    LaMontantInitial: TLabel;
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure Enregistrement;
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    Procedure GestionInitDM;
    Procedure GereAccesEcran;
    procedure ChangementEtatGrille(Sender: TObject);
    procedure ChangementEtatBoutons(Sender: TObject);
    procedure ChangementEtatCaption(Sender: TObject);
    procedure DBUtilisationDeductionsColExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    Procedure InitialiseTable_A_Nil;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    Procedure PositionTotaux;
    procedure Aide1Click(Sender: TObject);
    procedure Exporter1Click(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure RxSBInfoVersionClick(Sender: TObject);
    Procedure InitInfosDeduction(deductionCourante : integer);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBUtilisationDeductionsKeyPress(Sender: TObject;
      var Key: Char);
    procedure DBUtilisationDeductionsCellClick(Column: TColumn);
    function GestionListeExercice:TStrings;
    procedure BtnImprimerClick(Sender: TObject);
    procedure DBUtilisationDeductionsKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure Calculatrice1Click(Sender: TObject);
//    procedure DBUtilisationDeductionsTitleClick(Column: TColumn);
  private
    { D�clarations priv�es }
    Tri:string;

  public
    { D�clarations publiques }
    TitreForm,SousTitreForm:String;
  end;

var
  Utilisation_Deductions: TUtilisation_Deductions;
  LastSize:integer;
  FlagUtililsationDeductionCourant:boolean;
    //Liste des index secondaires disponibles
 IndexList: TStrings;
 //Liste des index secondaires cr��s � la vol�e
 CreatedIndexList: TStrings;
   Function UtilisationDeductionAffiche(ParamAfficheUtilisationDeduction:TParamAfficheUtilisationDeduction):Boolean;

implementation
uses DMDeductions, E2_Main,E2_Recherche,
   DMRecherche,
   LibClassObjetSenders,DMCorrection,DMExports, ImportDll;
  
{$R *.dfm}

Function UtilisationDeductionAffiche(ParamAfficheUtilisationDeduction:TParamAfficheUtilisationDeduction):Boolean;
var
ParamDMUtilisationDeduction:TParamDMUtilisationDeduction;
Begin
  if DMDeduction.InfosDeductionCourante.ChampRemplie ='Mt_N'then
  begin
     Application.MessageBox(Pchar('Vous ne pouvez d�crire une utilisation d''une d�duction acquise dans l''exercice courant'),'Attention',MB_ICONEXCLAMATION);
     abort;
  end;
 if (Utilisation_Deductions = nil) then Utilisation_Deductions:=TUtilisation_Deductions.Create(Application.MainForm);
 if not empty(ParamAfficheUtilisationDeduction.TitreForm) then
   Utilisation_Deductions.TitreForm:=ParamAfficheUtilisationDeduction.TitreForm
 else Utilisation_Deductions.TitreForm:=Utilisation_Deductions.RxLabTitre.Caption;
 Utilisation_Deductions.SousTitreForm:=ParamAfficheUtilisationDeduction.SousTitreForm;

 ParamDMUtilisationDeduction.UtilisationDeductionDataStateChange := Utilisation_Deductions.changementEtatBoutons;
 ParamDMUtilisationDeduction.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 DeductionCourante := ParamAfficheUtilisationDeduction.DeductionCourante;
 
 
 if(ParamAfficheUtilisationDeduction.DeductionCourante=0)then
   begin
     Application.MessageBox(Pchar('La d�duction est mal initialis�e.'),'Attention',MB_ICONWARNING );
     abort;
   end;


 InitialiseDMUtilisationDeduction(ParamDMUtilisationDeduction);
 TTable(Utilisation_Deductions.DBUtilisationDeductions.DataSource.DataSet).Active:=false;
 TTable(Utilisation_Deductions.DBUtilisationDeductions.DataSource.DataSet).IndexName:='Exercice';
 TTable(Utilisation_Deductions.DBUtilisationDeductions.DataSource.DataSet).Active:=true;
  if ParamAfficheUtilisationDeduction.Affiche then
  begin
   Utilisation_Deductions.DBUtilisationDeductions.DataSource := DMDeduction.DataUtilisation_deduc;


   if ParamAfficheUtilisationDeduction.AffichageModal then
     Utilisation_Deductions.ShowModal
    else
     Utilisation_Deductions.Show;
  end;
End;

procedure TUtilisation_Deductions.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TUtilisation_Deductions.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TUtilisation_Deductions.BtnEnregistrerClick(Sender: TObject);
begin
  if DMDeduction.TaUtilisation_deduc.State in  [dsinsert,dsedit] then
     begin
     Enregistrement;
     DBUtilisationDeductions.SetFocus;
     end;
end;


procedure TUtilisation_Deductions.Enregistrement;
begin
  try
    TableGerePost(DMDeduction.TaUtilisation_deduc);
  except
    abort;
  end;
end;

procedure TUtilisation_Deductions.BtnModifierClick(Sender: TObject);
begin
  DMDeduction.TaUtilisation_deduc.Edit;
end;

procedure TUtilisation_Deductions.BtnInsererClick(Sender: TObject);
begin
TableAjoute(DMDeduction.TaUtilisation_deduc);
end;

procedure TUtilisation_Deductions.BtnSupprimerClick(Sender: TObject);
begin
begin
   try
   if Application.MessageBox(Pchar('Confirmez-vous la suppression de cette ligne d''utilisation de DPI ?'),
     'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
   TableGereDelete(DMDeduction.TaUtilisation_deduc);
   except
      begin
      abort;
      end;
   end;
end;
end;

procedure TUtilisation_Deductions.BtnFermerClick(Sender: TObject);
begin
Self.Close;
end;

procedure TUtilisation_Deductions.FormActivate(Sender: TObject);
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

DBUtilisationDeductions.ParamColor:=true;
DBUtilisationDeductions.Param:=ParamUtil.CouleurDBGrid;
DBUtilisationDeductions.UpDateColor;

  GrGridTotaux.ParamColor:=true;
  GrGridTotaux.Param:=ParamUtil.CouleurDBGrid;
  GrGridTotaux.DessineContourLigne:=false;
  GrGridTotaux.UpDateColor;
  GrGridTotaux.FixedColor:=ParamUtil.CouleurDBGrid.GrilleColorFond;

  GrGridReste.ParamColor:=true;
  GrGridReste.Param:=ParamUtil.CouleurDBGrid;
  GrGridReste.DessineContourLigne:=false;
  GrGridReste.UpDateColor;
  GrGridReste.FixedColor:=ParamUtil.CouleurDBGrid.GrilleColorFond;

 CouleurFond([PaTools,PaBtn,PaBas],ParamUtil.CouleurPanelCorps);
 GereAccesEcran;
 DBUtilisationDeductions.Columns[0].PickList:=GestionListeExercice;
end;


function TUtilisation_Deductions.GestionListeExercice:Tstrings;
Begin
  result:=TStringList.Create;
  if DMDeduction.InfosDeductionCourante.ChampRemplie ='Mt_N'then
  begin
     //on ne propose rien, pas d'utilisation possible
  end;
  if DMDeduction.InfosDeductionCourante.ChampRemplie ='Mt_N1'then
  begin
    result.Add('N');
  end;
  if DMDeduction.InfosDeductionCourante.ChampRemplie ='Mt_N2'then
  begin
     result.Add('N');
     result.Add('N-1');
  end;
  if DMDeduction.InfosDeductionCourante.ChampRemplie ='Mt_N3'then
  begin
     result.Add('N');
     result.Add('N-1');
     result.Add('N-2');
  end;
  if DMDeduction.InfosDeductionCourante.ChampRemplie ='Mt_N4'then
  begin
     result.Add('N');
     result.Add('N-1');
     result.Add('N-2');
     result.Add('N-3');
  end;
  if DMDeduction.InfosDeductionCourante.ChampRemplie ='Mt_N5'then
  begin
     result.Add('N');
     result.Add('N-1');
     result.Add('N-2');
     result.Add('N-3');
     result.Add('N-4');
  end;
End;

Procedure TUtilisation_Deductions.GestionInitDM;
var
DMUtilisationDeduction:TParamDMUtilisationDeduction;
Begin
 DMUtilisationDeduction.UtilisationDeductionDataStateChange := changementEtatBoutons;
 DMUtilisationDeduction.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 InitialiseDMUtilisationDeduction(DMUtilisationDeduction);
 InitInfosDeduction(DeductionCourante);
End;

Procedure TUtilisation_Deductions.GereAccesEcran;
begin
DBUtilisationDeductions.ReadOnly := not E.AccesCloture;
DBUtilisationDeductions.FSauteColReadOnly := not DBUtilisationDeductions.ReadOnly;
EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer],E.AccesCloture);
EnableItemMenu([Insrer1,Modifier1,Supprimer1],E.AccesCloture);

DMDeduction.GestionAccesUtilisationDeductions;
end;


procedure TUtilisation_Deductions.ChangementEtatBoutons(Sender: TObject);
var
TotauxGeneric:TTotauxGeneric;
MontantDeduction:Currency;
begin
   case DMDeduction.TaUtilisation_deduc.State of
   dsBrowse	: begin
            BtnEnregistrer.Enabled:=false;
            BtnInserer.Enabled:=DMDeduction.InfosDeductionCourante.Montant -
                       DMDeduction.RecupUtilisationDeduction([DeductionCourante]).MontantUtilise>0;
            BtnModifier.Enabled:=(Not(DMDeduction.TaUtilisation_deduc.RecordCount = 0));
            BtnSupprimer.Enabled:=(Not(DMDeduction.TaUtilisation_deduc.RecordCount = 0));
            BtnImprimer.Enabled:=true;
            DBUtilisationDeductions.OnColExit:=nil;

           FiltrageDataSet(DMRech.TaUtilisation_deducRech,DBUtilisationDeductions.DataSource.DataSet.Filter);
           TotauxGeneric:=SommeTotauxGeneric(['Mt_immo','Mt_social','Mt_stocks','Reinteg_except'],DMRech.TaUtilisation_deducRech);
           MontantDeduction:=DMDeduction.InfosDeductionCourante.Montant;
           GrGridTotaux.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total1);
           GrGridTotaux.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total2);
           GrGridTotaux.cells[2,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total3);
           GrGridTotaux.cells[3,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total1+TotauxGeneric.Total2+TotauxGeneric.Total3);
           GrGridTotaux.cells[4,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total4);

           GrGridReste.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',(MontantDeduction)-(TotauxGeneric.Total1+TotauxGeneric.Total2+TotauxGeneric.Total3));
           GrGridReste.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',(MontantDeduction)-(TotauxGeneric.Total1+TotauxGeneric.Total2+TotauxGeneric.Total3+TotauxGeneric.Total4));
            if (MontantDeduction)-(TotauxGeneric.Total1+TotauxGeneric.Total2+TotauxGeneric.Total3)<0 then
              begin
                GrGridReste.font.Color:=clRed;
                GrGridReste.font.Style:=[fsbold];
                GrGridReste.font.Size:=9;
              end
            else
              begin
                GrGridReste.font.Color:=GrGridTotaux.font.Color;
                GrGridReste.font.Style:=GrGridTotaux.font.Style;
                GrGridReste.font.Size:=GrGridTotaux.font.Size;
              end;
           DeFiltrageDataSet(DMRech.TaUtilisation_deducRech);
           end;

   dsEdit:   begin
               EnableWinControl([BtnAnnuler,BtnEnregistrer,BtnFermer],True);
               EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer,BtnImprimer],False);
               DBUtilisationDeductions.OnColExit:=DBUtilisationDeductionsColExit;
             end;

   dsInsert: begin
               EnableWinControl([BtnAnnuler,BtnEnregistrer,BtnFermer],True);
               EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer,BtnImprimer],False);
               DBUtilisationDeductions.OnColExit:=DBUtilisationDeductionsColExit;
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

procedure TUtilisation_Deductions.ChangementEtatCaption(Sender: TObject);
begin
Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DMDeduction.TaUtilisation_deduc);
end;


//******************* ChangementEtatGrille *************************
procedure TUtilisation_Deductions.ChangementEtatGrille(Sender: TObject);
var I:integer;
begin
DBUtilisationDeductions.OnColExit:=nil;
  case DMDeduction.TaUtilisation_deduc.State of
    dsinsert : begin //si table en insertion
                 DBUtilisationDeductions.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
                         DBUtilisationDeductions.DataSource.DataSet.Fields[1].FocusControl;
               DBUtilisationDeductions.SetFocus;
               DBUtilisationDeductions.TitreColor(true);
               end;// fin insertion
    dsbrowse : begin //si table en consultation
                DBUtilisationDeductions.Options := [dgediting,dgtitles,dgindicator,dgrowlines,dgcollines,dgtabs];
                DBUtilisationDeductions.TitreColor(true);
                DBUtilisationDeductions.DataSource.DataSet.Fields[1].FocusControl;

               if DBUtilisationDeductions.InplaceEditor <> nil then
                  DBUtilisationDeductions.EditorMode:=false;
               end;//fin de consultation
    dsEdit : begin //si table en modification
               DBUtilisationDeductions.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               DBUtilisationDeductions.SetFocus;
               DBUtilisationDeductions.TitreColor(true);
         End;//fin modification
  end;//fin du case.state
  DBUtilisationDeductions.OnColExit:=DBUtilisationDeductionsColExit;
end;

procedure TUtilisation_Deductions.DBUtilisationDeductionsColExit(Sender: TObject);
var retourFonction:TErreurSaisie;
begin
try//except
if DBUtilisationDeductions.DataSource.DataSet.State in [dsinsert,dsEdit] then
   begin
   // appel de la fonction de contr�le de saisie
   retourFonction:=DMDeduction.CtrlSaisieUtilisationDeduction(DBUtilisationDeductions.SelectedField);
       if  RetourFonction.Retour=false then
        begin
           abort;
        end
        else //si le retour=true (il n'y a pas d'erreur)
        begin
            //if (DBUtilisationDeductions.SelectedField.FieldName ='Reinteg_except') and (DMDeduction.TaUtilisation_deduc.State<>dsbrowse) then
//                   begin
//                     BtnEnregistrer.Enabled:=true;
//                     Enregister1.Enabled:=true;
//                   end;
        end;//si le retour=true(il n'y a pas d'erreur)
   end;
except
   DBUtilisationDeductions.SelectedField.FocusControl;
   abort;
end;
end;


procedure TUtilisation_Deductions.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
try//finally
canclose:=true;
  try//except
      if DMDeduction <> nil then
       begin
        // Si l'utilisateur est en mode Insertion
           If DMDeduction.TaUtilisation_deduc.State = dsInsert Then
           Begin
             self.WindowState:=wsNormal;
                self.BringToFront;
                If BtnEnregistrer.Enabled Then
                Begin
                     If Messagedlg('Voulez-vous enregistrer cette nouvelle utilisation de d�duction ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                       begin
                         Enregistrement;
                        end
                        else
                         begin
                         DMDeduction.TaUtilisation_deduc.Cancel;
                         end;
                End
                Else
                Begin
                     If Messagedlg('Voulez-vous annuler la cr�ation de cette utilisation de d�duction ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                      begin
                         DMDeduction.TaUtilisation_deduc.Cancel;
                      end
                     Else
                       begin
                        canclose:=false;
                        end;
                End;
           End; // Fin utilisateur est en mode Insertion

           // Si l'utilisateur est en mode Modification
           If DMDeduction.TaUtilisation_deduc.State = dsEdit Then
           Begin
             self.WindowState:=wsNormal;
             self.BringToFront;
                If Messagedlg('Voulez-vous enregistrer les modifications de cette utilisation de d�duction ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                 begin
                  Enregistrement;
                   end
                   else
                   begin
                    DMDeduction.TaUtilisation_deduc.Cancel;
                   end;
           End; // Fin utilisateur est en mode Modification
     end;
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


Procedure TUtilisation_Deductions.InitialiseTable_A_Nil;
Begin
if DMDeduction<>nil then
    InitDatasetEvent_A_Nil_Sur_Form([DMDeduction.DataUtilisation_deduc]);
End;

procedure TUtilisation_Deductions.FormCreate(Sender: TObject);
begin
    try
      LibGestionParamXML.InitialiseForm(E.User,Self);
        //R�cup�rer la liste des index d�clar�s
        //avant le lancement du programme
        (DBUtilisationDeductions.DataSource.DataSet as TTable).GetIndexNames(IndexList);
    except
        InitialiseFormPosDefaut(self);
    end;
 LastSize:=0;
 FlagUtililsationDeductionCourant:=false;
end;

procedure TUtilisation_Deductions.FormDestroy(Sender: TObject);
// var
// i: integer;
 begin
// with (DBUtilisationDeductions.DataSource.DataSet as TTable) do
// begin
// Close;
// Exclusive := True;
// for i := 0 to CreatedIndexList.Count - 1 do
// try
// DeleteIndex(CreatedIndexList.Strings[i]);
// except
// //
// end;
// Exclusive := False;
// Close;
// end;

     InitialiseTable_A_Nil;
     LibGestionParamXML.DestroyForm(Self,E.USer);
     if DMDeduction<>nil then
       DMDeduction.Free;
     Utilisation_Deductions:=Nil;
end;

procedure TUtilisation_Deductions.FormResize(Sender: TObject);
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

procedure TUtilisation_Deductions.FormShow(Sender: TObject);
var
   I: Integer;
begin
RxLabTitre.Caption:='Utilisation des d�ductions pour investissements';
Patitre.Color:=$0033CCFF;
GrGridTotaux.ColCount:=5;
GrGridReste.ColCount:=2;

ChangementEtatCaption(self);
self.Realign;
PaGrille.Realign;
PaGrilleResize(PaGrille);

DMDeduction.TaUtilisation_deduc.First;
DBUtilisationDeductions.SetFocus;
DMDeduction.DataUtilisation_deduc.OnStateChange:=ChangementEtatBoutons;
DMDeduction.DataUtilisation_deduc.OnStateChange(DMDeduction.TaUtilisation_deduc);
end;

procedure TUtilisation_Deductions.PaGrilleResize(Sender: TObject);
begin
if DBUtilisationDeductions.DataSource <> nil then
 begin
  DBUtilisationDeductions.DataSource.DataSet.close;
  FormateTailleColonne(DBUtilisationDeductions,38,[2,5,5,5,5,5,10]);
  GrGridTotaux.ColCount:=5;
  GrGridReste.ColCount:=2;
  PositionTotaux;
  DBUtilisationDeductions.DataSource.DataSet.open;
  WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
 end;
end;

Procedure TUtilisation_Deductions.PositionTotaux;
Begin
Panel7.Width:=RenvoiTailleColonne(DBUtilisationDeductions,[0,1])+10;
GrGridTotaux.ColWidths[0]:=RenvoiTailleColonne(DBUtilisationDeductions,[2]);
GrGridTotaux.ColWidths[1]:=RenvoiTailleColonne(DBUtilisationDeductions,[3]);
GrGridTotaux.ColWidths[2]:=RenvoiTailleColonne(DBUtilisationDeductions,[4]);
GrGridTotaux.ColWidths[3]:=RenvoiTailleColonne(DBUtilisationDeductions,[5]);
GrGridTotaux.ColWidths[4]:=RenvoiTailleColonne(DBUtilisationDeductions,[6]);

Panel2.Width:=RenvoiTailleColonne(DBUtilisationDeductions,[0,1,2,3,4])+13;
GrGridReste.ColWidths[0]:=RenvoiTailleColonne(DBUtilisationDeductions,[5]);
GrGridReste.ColWidths[1]:=RenvoiTailleColonne(DBUtilisationDeductions,[6]);
End;

procedure TUtilisation_Deductions.Aide1Click(Sender: TObject);
begin
 If activecontrol = DBUtilisationDeductions Then
  begin
     if UpperCase(DBUtilisationDeductions.SelectedField.FieldName)='EXERCICE' then
       begin
           DBUtilisationDeductions.EditorMode:=true;
           if(DBUtilisationDeductions.InplaceEditor<>nil)then
                (DBUtilisationDeductions.InplaceEditor as TGrInplaceEdit).DropDown;
       end;         
 end;
end;

procedure TUtilisation_Deductions.Exporter1Click(Sender: TObject);
begin
ExportDonnees(DBUtilisationDeductions.DataSource.DataSet,E.RepertoireExportDossier,'UtilisationDeduction_'+E.NomDossier + E.NomExo + '.Txt');
end;

procedure TUtilisation_Deductions.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TUtilisation_Deductions.RxSBInfoVersionClick(Sender: TObject);
begin
Showmessage(UtilisationDeductionRxSBInfoVersionWarning+numVersion.messageVersion);
end;


Procedure TUtilisation_Deductions.InitInfosDeduction(deductionCourante : integer);
var
FieldName : string;
Increment : integer;
begin
FiltrageDataSet(DMRech.TaDeductionRech,CreeFiltreOU('id',[deductionCourante]));
LaExerciceDeduction.Caption := '';
LaLibelleDeduction.Caption :=  '';
LaMontantInitial.Caption := '';

LaLibelleDeduction.Caption := dmrech.TaDeductionRech.FindField('Libelle').AsString;

FieldName := 'Mt_N';
Increment :=0;
LaExerciceDeduction.Caption := '';
while (Increment<=5)and(LaExerciceDeduction.Caption='')do
  begin
     if dmrech.TaDeductionRech.FindField(FieldName).AsCurrency > 0 then
       begin
         LaExerciceDeduction.Caption := 'N-'+IntToStr(increment);
         LaMontantInitial.Caption :=FormatCurr('0.00',dmrech.TaDeductionRech.FindField(FieldName).AsCurrency);
       end;
     inc(increment,1);
     FieldName:='Mt_N'+IntToStr(increment);
  end;
end;
procedure TUtilisation_Deductions.BtnAnnulerClick(Sender: TObject);
begin
try//except
      If DMDeduction.TaUtilisation_deduc.State = dsInsert Then
          Begin
               If Messagedlg('Voulez vous annuler la cr�ation de cette utilisation de d�duction ?',MtConfirmation,[mbno,mbyes],0) = mryes Then
               Begin
                    DMDeduction.TaUtilisation_deduc.Cancel;
                    Abort;
               End
               Else
               Begin
                    Abort;
               End;
          End;

          If DMDeduction.TaUtilisation_deduc.State = dsEdit Then
          Begin
               If Messagedlg('Annuler les modifications de cette utilisation de d�duction ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    DMDeduction.TaUtilisation_deduc.Cancel;
                    Abort;
               End
               Else
               Begin
                    Abort;
               End
          End;
ModalResult := mrCancel;
except
end;
end;

procedure TUtilisation_Deductions.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
     If Key = VK_ESCAPE Then
       BtnAnnuler.Click;

end;

procedure TUtilisation_Deductions.DBUtilisationDeductionsKeyPress(
  Sender: TObject; var Key: Char);
begin
if UpperCase(DBUtilisationDeductions.SelectedField.FieldName)='EXERCICE' then
  abort;
end;

procedure TUtilisation_Deductions.DBUtilisationDeductionsCellClick(
  Column: TColumn);
var
key:word;
shift:TShiftState;
begin
if (Column.PickList<>nil)and(Column.PickList.Count>0)then
  begin
    DBUtilisationDeductions.EditorMode := true;
  end;
end;

procedure TUtilisation_Deductions.BtnImprimerClick(Sender: TObject);
begin
EditionDesDeductions(C_EditionSimple,false,DMDeduction.InfosDeductionCourante.Exo,nil,'');
end;

procedure TUtilisation_Deductions.DBUtilisationDeductionsKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
if (UpperCase(DBUtilisationDeductions.SelectedField.FieldName)='EXERCICE') and (key=vk_down)and (Shift=[ssCtrl])then
  begin
    if(DBUtilisationDeductions.InplaceEditor<>nil)then
      (DBUtilisationDeductions.InplaceEditor as TGrInplaceEdit).DropDown;
    key:=0;
  end;
end;

procedure TUtilisation_Deductions.Calculatrice1Click(Sender: TObject);
begin
if DBUtilisationDeductions.Col in [2,3,4,6] then
  AfficheCalculatrice(DBUtilisationDeductions)
else
  AfficheCalculatrice(nil);
end;

//procedure TUtilisation_Deductions.DBUtilisationDeductionsTitleClick(
//  Column: TColumn);
// begin
// if tri='_A' then tri:='_D' else tri:='_A';
////TTable(DBUtilisationDeductions.DataSource.DataSet).IndexName:='Exercice'+inttostr(tri);
//
// if DBUtilisationDeductions.ValidFieldIndex(Column.Index) then
// begin
// //Un index correspondant � la colonne cliqu�e existe-t-il ?
// if IndexList.IndexOf(Column.FieldName+tri) <> -1 then
// begin
//   //Si oui, l'utilise
//   with TTable(DBUtilisationDeductions.DataSource.DataSet) do
//    IndexName := Column.FieldName+tri;
// end
// else
// //L'index n'existe pas :
// with TTable(DBUtilisationDeductions.DataSource.DataSet) do
//   begin
//     Close;
//     Exclusive := True;
//     //cr�er un index secondaire correspondant
//     //� la colonne cliqu�e
//         try
//           if tri='_A' then
//             AddIndex(Column.FieldName+tri, Column.FieldName, [])
//           else
//            AddIndex(Column.FieldName+tri, Column.FieldName, [ixDescending]);
//           //rendre actif l'index cr��
//           IndexName := Column.FieldName+tri;
//           Exclusive := False;
//           Open;
//           //R�actualiser la liste des index de la table
//           GetIndexNames(IndexList);
//           //et l'afficher
//
//           CreatedIndexList.Assign(IndexList);
//         except
//             on EDatabaseError do
//               begin
//               ShowMessageFmt('Impossible de cr�er un index sur le champ ',
//               [Column.FieldName]);
//               IndexFieldNames := '';
//               Exclusive := False;
//               if not Active then
//               Open;
//               end;
//         end;
//     end;
// end;
//
// end;




 initialization
 IndexList := TStringList.Create;
 CreatedIndexList := TStringList.Create;

 finalization
 IndexList.Free;
 CreatedIndexList.Free;
end.