{***************************************************************
 *
 * Unit Name: E2_BilanOuverture
 * Purpose  :
 * Author   :  Assemat, BP
 * History  :
 *
 ****************************************************************}

unit E2_BilanOuverture;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables, StdCtrls, Mask, DBCtrls, ExtCtrls,E2_Librairie_obj,
  Gr_Librairie_obj, E2_AideModel, LibZoneSaisie,
  Menus, Buttons, RXCtrls, RXDBCtrl, ExRxDBGrid, GrDBGrid,
  ToolEdit, CurrEdit,LibSQL,DMEcriture,LibRessourceString, GrGrid, DMRecherche,
  DMRepartition,
  E2_Decl_Records,DMConstantes, LibGestionParamXML, jpeg;

type
  TBilanOuverture = class(TForm)
    Patitre: TPanel;
    PaBas: TPanel;
    PaBtn: TPanel;
    BtnEnregistrer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnInserer: TButton;
    Label3: TLabel;
    Panel1: TPanel;
    BtnClasse1: TSpeedButton;
    BtnClasse2: TSpeedButton;
    BtnClasse3: TSpeedButton;
    BtnClasse4: TSpeedButton;
    BtnClasse5: TSpeedButton;
    BtnClasse6: TSpeedButton;
    BtnClasse7: TSpeedButton;
    PaBasD: TPanel;
    EdCompte: TEdit;
    Label4: TLabel;
    PaGrille: TPanel;
    PopupMenu1: TPopupMenu;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Insrer1: TMenuItem;
    Modifier1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    DBGridCpt: TGrDBGrid;
    DBTextCompte: TDBText;
    DBCompte: TDBEdit;
    Visualisation1: TMenuItem;
    N2: TMenuItem;
    Prcdent1: TMenuItem;
    Suivant1: TMenuItem;
    BtnImprimer: TButton;
    Imprimer1: TMenuItem;
    BtnAnnuler: TButton;
    RxSpeedButton2: TRxSpeedButton;
    RxSpeedButton1: TRxSpeedButton;
    RxLabTitre: TRxLabel;
    ImEnTete: TImage;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    RxSpeedButton3: TRxSpeedButton;
    PaCumul1: TPanel;
    Panel7: TPanel;
    GrGrid1: TGrGrid;
    PaCumul2: TPanel;
    Panel2: TPanel;
    GrGrid2: TGrGrid;
    Visualisationsurpriode1: TMenuItem;
    Exporter1: TMenuItem;
    Calculatrice1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnClasse1Click(Sender: TObject);
    procedure EdCompteChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdCompteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridCptEnter(Sender: TObject);
    procedure DataSource1StateChange(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure SBBilanOuvertureClick(Sender: TObject);
    procedure SBChargesProduitsClick(Sender: TObject);
    procedure BtnClasse6Click(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);
    procedure RxSpeedButton2Click(Sender: TObject);
    procedure RxSpeedButton1Click(Sender: TObject);
    procedure PatitreResize(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    Function CalculLeft (colcourante : integer) : integer;
    procedure PaBasDResize(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBGridCptDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBCompteEnter(Sender: TObject);
    procedure EdCompteExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure PaTotauxResize(Sender: TObject);
    procedure BtnEnregistrerEnter(Sender: TObject);
    procedure BtnEnregistrerExit(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure RxSpeedButton3Click(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    Procedure PositionTotaux;
    procedure Visualisationsurpriode1Click(Sender: TObject);
    Procedure GereAccesEcran;
    procedure Exporter1Click(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    TitreForm,SousTitreForm:String;
  end;


var
  BilanOuverture: TBilanOuverture;

  Mark : TBookMark;
  CompteChange: Boolean;
  PlanBOChange:Boolean;

implementation
{$R *.DFM}
Uses
  //Gr_Calculatrice,
  E2_AideAssist,  E2_Main,E2_Recherche,DMPlanCpt,
  DMDiocEtatBalance,DMExports;


//****************************************************************************//
// Gestion de la création de la fenêtre.                                      //
//****************************************************************************//
procedure TBilanOuverture.FormCreate(Sender: TObject);
begin
PlanBOChange:=False;
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poDesigned;
        InitialiseFormPosDefaut(self);
	//Left:= 0; Top:= 70; Width:= screen.Width; Height:= screen.Height-top;
    end;
DBGridCpt.FSauteColReadOnly:=true;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion de l'évènement Show de la fenêtre.                                 //
//****************************************************************************//
procedure TBilanOuverture.FormShow(Sender: TObject);
begin
  DefiltrageDataSet(DMDiocEtatBal.TaBalanceCalc);
     DMPlan.TaPlanBO.DisableControls;

if self.Tag = 1 then
 begin
     BtnClasse1.Visible := True;
     BtnClasse2.Visible := True;
     BtnClasse3.Visible := True;
     BtnClasse4.Visible := True;
     BtnClasse5.Visible := True;
     BtnClasse6.Visible := False;
     BtnClasse7.Visible := False;

     BtnClasse1.Down := True;
     BtnClasse2.Down := True;
     BtnClasse3.Down := True;
     BtnClasse4.Down := True;
     BtnClasse5.Down := True;
     BtnClasse6.Down := False;
     BtnClasse7.Down := False;

     RxSpeedButton1.Visible:=false;// and (not main.Monofenetrage);;

     DMPlan.TaPlanBO.Filtered := False;
     DMPlan.TaPlanBO.Filter := CreeFiltreOU('Compte',['1*','2*','3*','4*','5*']);
     DMPlan.TaPlanBO.Filtered := True;
     DMPlan.TaPlanBO.Open;
     RxLabTitre.Caption:='Ouverture : Balance d''ouverture';
     Self.Caption := 'Balance d''ouverture';
     DBGridCpt.Columns[2].Title.Caption := 'Débit';
     DBGridCpt.Columns[3].Title.Caption := 'Crédit';

 end;

if self.Tag = 2 then
 begin
     BtnClasse1.Visible := False;
     BtnClasse2.Visible := False;
     BtnClasse3.Visible := False;
     BtnClasse4.Visible := False;
     BtnClasse5.Visible := False;
     BtnClasse6.Visible := True;
     BtnClasse7.Visible := True;

     BtnClasse1.Down := False;
     BtnClasse2.Down := False;
     BtnClasse3.Down := False;
     BtnClasse4.Down := False;
     BtnClasse5.Down := False;
     BtnClasse6.Down := True;
     BtnClasse7.Down := True;

     RxSpeedButton1.Visible:=false;

     DMPlan.TaPlanBO.Filtered := False;
     DMPlan.TaPlanBO.Filter := CreeFiltreOU('Compte',['6*','7*']);
     DMPlan.TaPlanBO.Filtered := True;
     DMPlan.TaPlanBO.Open;
     RxLabTitre.Caption:='Ouverture : Charges et Produits N-1';
     Self.Caption := 'Charges & Produits N-1';
     DBGridCpt.Columns[2].Title.Caption := 'Charges & Dépenses';
     DBGridCpt.Columns[3].Title.Caption := 'Produits & Recettes';
 end;
     CompteChange := False;
     EdCompte.Text := '';
     mark := nil;



     DMPlan.TaPlanBO.Filtered := True;
//     DMPlan.TaPlanBO.Refresh;
//     DMPlan.TaPlanBO.First;
     DBGridCpt.SelectedIndex := 2;
     DMPlan.TaPlanBO.EnableControls;
     DMPlan.DaPlanBO.OnStateChange:=DataSource1StateChange;
     DataSource1StateChange(DMPlan.DaPlanBO);

//Label5.Caption:=inttostr( DMPlan.QuCompteUtiliseOuvClot.RecordCount);
end;
//****************************************************************************//


//****************************************************************************//
// Gestion des Touches.                                                       //
//****************************************************************************//
procedure TBilanOuverture.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     If key = VK_ESCAPE Then
     Begin
          Key := 0;
          If Not(DMPlan.TaPlanBO.State in [dsEdit]) Then
          Begin
           if ActiveControl = DBGridCpt then Self.Close;
           if ActiveControl <> DBGridCpt then DBGridCpt.SetFocus;
          End
          Else
          Begin
               DMPlan.TaPlanBO.Cancel;
          End;
     end;
if self.Tag = 1 then
 begin
     If ((Key = VK_NUMPAD0) And (Shift = [ssCtrl])) Then
     Begin
          DBCompte.SetFocus;
     End;
     If ((Key = VK_NUMPAD1) And (Shift = [ssCtrl])) Then
     Begin
          BtnClasse1.Down := Not(BtnClasse1.Down);
          BtnClasse1.Click;
     End;
     If ((Key = VK_NUMPAD2) And (Shift = [ssCtrl])) Then
     Begin
          BtnClasse2.Down := Not(BtnClasse2.Down);
          BtnClasse2.Click;
     End;
     If ((Key = VK_NUMPAD3) And (Shift = [ssCtrl])) Then
     Begin
          BtnClasse3.Down := Not(BtnClasse3.Down);
          BtnClasse3.Click;
     End;
     If ((Key = VK_NUMPAD4) And (Shift = [ssCtrl])) Then
     Begin
          BtnClasse4.Down := Not(BtnClasse4.Down);
          BtnClasse4.Click;
     End;
     If ((Key = VK_NUMPAD5) And (Shift = [ssCtrl])) Then
     Begin
          BtnClasse5.Down := Not(BtnClasse5.Down);
          BtnClasse5.Click;
     End;
 end;
if self.tag = 2 then
 begin
     If ((Key = VK_NUMPAD6) And (Shift = [ssCtrl])) Then
     Begin
          BtnClasse6.Down := Not(BtnClasse6.Down);
          BtnClasse6.Click;
     End;
     If ((Key = VK_NUMPAD7) And (Shift = [ssCtrl])) Then
     Begin
          BtnClasse7.Down := Not(BtnClasse7.Down);
          BtnClasse7.Click;
     End;
 end;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click sur les classes des comptes.                              //
//****************************************************************************//
procedure TBilanOuverture.BtnClasse1Click(Sender: TObject);
var
   var1, var2, var3, var4, var5: String;
   Bookmark: TBookMark;
//   TotalDebit, Totalcredit: Currency;
   Classes : TStringList;
begin

     Classes := TStringList.Create;

     // Initialisation des variables
     If BtnClasse1.Down = True Then Var1 := '1*' Else Var1 := '0*';
     If BtnClasse2.Down = True Then Var2 := '2*' Else Var2 := '0*';
     If BtnClasse3.Down = True Then Var3 := '3*' Else Var3 := '0*';
     If BtnClasse4.Down = True Then Var4 := '4*' Else Var4 := '0*';
     If BtnClasse5.Down = True Then Var5 := '5*' Else Var5 := '0*';

     // Initialisation des labels
     If Not(BtnClasse1.Down and BtnClasse2.Down and BtnClasse3.Down and BtnClasse4.Down and BtnClasse5.Down) Then
     Begin
          Classes.Clear;
          If BtnClasse1.Down Then Classes.Add('1');
          If BtnClasse2.Down Then Classes.Add('2');
          If BtnClasse3.Down Then Classes.Add('3');
          If BtnClasse4.Down Then Classes.Add('4');
          If BtnClasse5.Down Then Classes.Add('5');

//          Label1.Caption := 'Total pour les classes ' + Classes.CommaText;
//          Label2.Caption := 'Solde pour les classes ' + Classes.CommaText;

          Classes.Destroy;
     End
     Else
     Begin
//          Label1.Caption := 'Total au bilan d''ouverture';
//          Label2.Caption := 'Solde';
     End;

     Bookmark := DMPlan.TaPlanBO.GetBookmark;
     DMPlan.TaPlanBO.DisableControls;

     // Filtrage de la table des comptes
     DMPlan.TaPlanBO.Filtered := False;
     DMPlan.TaPlanBO.Filter :=CreeFiltreOU('Compte',[var1,var2,var3,var4,var5]);
     DMPlan.TaPlanBO.Filtered := True;




     Try
        DMPlan.TaPlanBO.GotoBookmark(Bookmark);
     Except
        DMPlan.TaPlanBO.First;
     End;

     DMPlan.TaPlanBO.FreeBookmark(Bookmark);
     DMPlan.TaPlanBO.EnableControls;

end;
//****************************************************************************//


//****************************************************************************//
// Permet de sélectionner dans la grille le compte saisie par l'utilisateur   //
//****************************************************************************//
procedure TBilanOuverture.EdCompteChange(Sender: TObject);
Var
   var1,var2,var3,var4,var5,var6,var7 : string;
   cpte: string;
//   TotalDebit, Totalcredit: Currency;
   Classes : TStringList;
begin
     // Si l'utilisateur est dans le Bilan d'ouverture
//     If SBBilanOuverture.Down Then
     If self.tag=1 Then
     Begin
          If Not(CompteChange) Then
          Begin
               Classes := TStringList.Create;

               cpte := copy(EdCompte.Text,1,1);

               if (cpte = btnclasse1.caption) and (BtnClasse1.down = false) then
                  BtnClasse1.down := true;
               if (cpte = btnclasse2.caption) and (BtnClasse2.down = false) then
                  BtnClasse2.down := true;
               if (cpte = btnclasse3.caption) and (BtnClasse3.down = false) then
                  BtnClasse3.down := true;
               if (cpte = btnclasse4.caption) and (BtnClasse4.down = false) then
                  BtnClasse4.down := true;
               if (cpte = btnclasse5.caption) and (BtnClasse5.down = false) then
                  BtnClasse5.down := true;


               if BtnClasse1.Down = True Then var1 := '1*' else var1 := '0*';
               if BtnClasse2.Down = True Then var2 := '2*' else var2 := '0*';
               if BtnClasse3.Down = True Then var3 := '3*' else var3 := '0*';
               if BtnClasse4.Down = True Then var4 := '4*' else var4 := '0*';
               if BtnClasse5.Down = True Then var5 := '5*' else var5 := '0*';


               // Initialisation des labels
               If Not(BtnClasse1.Down and BtnClasse2.Down and BtnClasse3.Down and BtnClasse4.Down and BtnClasse5.Down) Then
               Begin
                    Classes.Clear;
                    If BtnClasse1.Down Then Classes.Add('1');
                    If BtnClasse2.Down Then Classes.Add('2');
                    If BtnClasse3.Down Then Classes.Add('3');
                    If BtnClasse4.Down Then Classes.Add('4');
                    If BtnClasse5.Down Then Classes.Add('5');

//                    Label1.Caption := 'Total pour les classes ' + Classes.CommaText;
//                    Label2.Caption := 'Solde pour les classes ' + Classes.CommaText;

                    Classes.Destroy;
               End
               Else
               Begin
//                    Label1.Caption := 'Total au bilan d''ouverture';
//                    Label2.Caption := 'Solde';
               End;

               DMPlan.TaPlanBO.DisableControls;

               // Filtrage de la table des comptes
               DMPlan.TaPlanBO.Filtered := False;
               DMPlan.TaPlanBO.Filter :=CreeFiltreOU('Compte',[var1,var2,var3,var4,var5]);
               DMPlan.TaPlanBO.Filtered := True;


               DMPlan.TaPlanBO.FindNearest([EdCompte.Text]);
//               DMPlan.TaPlanBO.
               //Libération du dernier marqueur s'il le faut
               if (mark <> nil) and (edcompte.text <> '') then
                  DMPlan.TaPlanBO.freebookmark(mark);
               if edcompte.text <> '' then
                  mark := DMPlan.TaPlanBO.GetBookmark;
               if (edcompte.text = '') and (mark <> nil) then
                  DMPlan.TaPlanBO.GotoBookmark(mark);

               DMPlan.TaPlanBO.EnableControls;
          End;
     End; // Fin Utilisateur est dans Bilan d'ouverture

     // Si l'utilisateur est dans les charges et Produits
     If self.tag=2 Then
     Begin
          If Not(CompteChange) Then
          Begin
               Classes := TStringList.Create;

               cpte := copy(EdCompte.Text,1,1);

               if (cpte = btnclasse6.caption) and (BtnClasse6.down = false) then
                  BtnClasse6.down := true;
               if (cpte = btnclasse7.caption) and (BtnClasse7.down = false) then
                  BtnClasse7.down := true;

               if BtnClasse6.Down = True Then var6 := '6*' else var6 := '0*';
               if BtnClasse7.Down = True Then var7 := '7*' else var7 := '0*';

               // Initialisation des labels
               If Not(BtnClasse6.Down and BtnClasse7.Down) Then
               Begin
                    Classes.Clear;
                    If BtnClasse6.Down Then Classes.Add('6');
                    If BtnClasse7.Down Then Classes.Add('7');

//                    Label1.Caption := 'Total des Charges et Produits pour les classes ' + Classes.CommaText;
//                    Label2.Caption := 'Solde pour les classes ' + Classes.CommaText;

                    Classes.Destroy;
               End
               Else
               Begin
//                    Label1.Caption := 'Total des Charges et Produits';
//                    Label2.Caption := 'Solde';
               End;

               DMPlan.TaPlanBO.DisableControls;

               // Filtrage de la table des comptes
               DMPlan.TaPlanBO.Filtered := False;
               DMPlan.TaPlanBO.Filter :=CreeFiltreOU('Compte',[var6,var7]);
               DMPlan.TaPlanBO.Filtered := True;


               DMPlan.TaPlanBO.FindNearest([EdCompte.Text]);
               //Libération du dernier marqueur s'il le faut
               if (mark <> nil) and (edcompte.text <> '') then
                  DMPlan.TaPlanBO.freebookmark(mark);
               if edcompte.text <> '' then
                  mark := DMPlan.TaPlanBO.GetBookmark;
               if (edcompte.text = '') and (mark <> nil) then
                  DMPlan.TaPlanBO.GotoBookmark(mark);

               DMPlan.TaPlanBO.EnableControls;
          End;
     End; // Fin Utilisateur est dans Charges et Produits

end;
//****************************************************************************//



//****************************************************************************//
// Gestion de la fermeture de la fenêtre.                                     //
//****************************************************************************//
procedure TBilanOuverture.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     if mark <> nil then
        DMPlan.TaPlanBO.FreeBookmark(mark);

     If DMPlan.TaPlanBO.State in [dsEdit] Then
     Begin
          If Messagedlg('Voulez-vous enregistrer avant de Fermer la fenêtre',mtconfirmation,[mbyes,mbno],0) = mryes Then
             BtnEnregistrer.Click
          Else
              Annuler1.Click;
     End;

//     DMPlan.TaPlanBO.Close;

end;
//****************************************************************************//


//****************************************************************************//
// Gestion des touches quand l'utilisateur est dans EdCompte                  //
//****************************************************************************//
procedure TBilanOuverture.EdCompteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     Case Key of

     VK_ESCAPE: Begin
                   try
                     if mark <> nil then
                          DMPlan.TaPlanBO.GotoBookmark(mark);
                    except;
                    DMPlan.TaPlanBO.First
                   end;
                     DBGridCpt.SelectedIndex := 2;
//                     DBGridCpt.SetFocus;
                     EdCompte.text := ''
                End;
     VK_RETURN: Begin
                     DBGridCpt.SelectedIndex := 2;
                     DBGridCpt.SetFocus;
                     EdCompte.text := ''
                End;

     VK_UP: Begin
                 If EdCompte.Text <> '' Then
                 Begin
                      CompteChange := True;
                      if mark <> nil then
                      begin

                           DMPlan.TaPlanBO.GotoBookmark(mark);
                           If Not DMPlan.TaPlanBO.BOF then DMPlan.TaPlanBO.Prior;
                           DBGridCpt.SelectedIndex := 2;
                           DBGridCpt.SetFocus;
                      end;
                 End
                 Else
                 Begin
                      DBGridCpt.SelectedIndex := 2;
                      DBGridCpt.SetFocus;
                 End;

            End;

     VK_DOWN: Begin
                   If EdCompte.Text <> '' Then
                   Begin
                        CompteChange := True;
                        if mark <> nil then
                        begin
                             DMPlan.TaPlanBO.GotoBookmark(mark);
                             If Not DMPlan.TaPlanBO.EOF Then DMPlan.TaPlanBO.Next;
                             DBGridCpt.SelectedIndex := 2;
                             DBGridCpt.SetFocus;
                        end;
                   End
                   Else
                   Begin
                        DBGridCpt.SelectedIndex := 2;
                        DBGridCpt.SetFocus;
                   End;
              End;
     end;  // Fin du Case
end;
//****************************************************************************//


//****************************************************************************//
// Gerer EdCompte quand la grille reçoit la focalisation.                     //
//****************************************************************************//
procedure TBilanOuverture.DBGridCptEnter(Sender: TObject);
begin
     If Not(EdCompte.Text = '') Then
     Begin
          CompteChange := true;
          EdCompte.Text := '';
          CompteChange := false;
     End;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du changement de l'état de la table.                               //
//****************************************************************************//
procedure TBilanOuverture.DataSource1StateChange(Sender: TObject);
var
TotauxGeneric:TTotauxGeneric;
//CompteTmp:String;
begin
 Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DMPlan.TaPlanBO);
case self.tag of
   1:     Case DMPlan.TaPlanBO.State Of

          dsBrowse : Begin
                          BtnEnregistrer.Enabled := False;
                          BtnSupprimer.Enabled := True;
                          Annuler1.Enabled := False;
                          EdCompte.Enabled := True;
                          BtnClasse1.Enabled := True;
                          BtnClasse2.Enabled := True;
                          BtnClasse3.Enabled := True;
                          BtnClasse4.Enabled := True;
                          BtnClasse5.Enabled := True;


               FiltrageDataSet(DMPlan.TaPlanBOCalc,DBGridCpt.DataSource.DataSet.Filter);
               TotauxGeneric:=SommeTotauxGeneric(['Debit_Deb','Credit_Deb','Debit_Deb_Calc','Credit_Deb_Calc'],DMPlan.TaPlanBOCalc);
               DBGridCpt.DataSource.DataSet.EnableControls;

               // Totaux de la saisie directe
               GrGrid1.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total1);
               GrGrid1.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total2);

               TotauxGeneric.Total5:=TotauxGeneric.Total1 - TotauxGeneric.Total2;

               if TotauxGeneric.Total5 >= 0 then
                begin
                 GrGrid2.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total5);
                 GrGrid2.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',0);
                end
                else
                begin
                 GrGrid2.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',0);
                 GrGrid2.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',-TotauxGeneric.Total5);
                end;

               // Totaux de la saisie dans les écrans automatiques

               GrGrid1.cells[2,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total3);
               GrGrid1.cells[3,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total4);

               TotauxGeneric.Total6:=TotauxGeneric.Total3 - TotauxGeneric.Total4;

               if TotauxGeneric.Total6 >= 0 then
                begin
                 GrGrid2.cells[2,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total6);
                 GrGrid2.cells[3,0]:=FormatFloat(E.FormatMonnaie + ';; ',0);
                end
                else
                begin
                 GrGrid2.cells[2,0]:=FormatFloat(E.FormatMonnaie + ';; ',0);
                 GrGrid2.cells[3,0]:=FormatFloat(E.FormatMonnaie + ';; ',-TotauxGeneric.Total6);
                end;

               DeFiltrageDataSet(DMPlan.TaPlanBOCalc);
               ChangementEtatGrille(DBGridCpt);

                     End;

          dsEdit : Begin
                        BtnEnregistrer.Enabled := False;
                        BtnSupprimer.Enabled := True;
                        Annuler1.Enabled := True;
                        EdCompte.Enabled := False;
                        BtnClasse1.Enabled := False;
                        BtnClasse2.Enabled := False;
                        BtnClasse3.Enabled := False;
                        BtnClasse4.Enabled := False;
                        BtnClasse5.Enabled := False;
                        PlanBOChange:=true;
                        ChangementEtatGrille(DBGridCpt);
                   End;

     End; // Fin du Case

   2:     Case DMPlan.TaPlanBO.State Of

          dsBrowse : Begin
                          BtnEnregistrer.Enabled := False;
                          BtnSupprimer.Enabled := True;
                          Annuler1.Enabled := False;
                          EdCompte.Enabled := True;
                          BtnClasse6.Enabled := True;
                          BtnClasse7.Enabled := True;

               FiltrageDataSet(DMPlan.TaPlanBOCalc,DBGridCpt.DataSource.DataSet.Filter);
               TotauxGeneric:=SommeTotauxGeneric(['Debit_Deb','Credit_Deb','Debit_Deb_Calc','Credit_Deb_Calc'],DMPlan.TaPlanBOCalc);
               DBGridCpt.DataSource.DataSet.EnableControls;

               GrGrid1.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total1);
               GrGrid1.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total2);
               TotauxGeneric.Total5:=TotauxGeneric.Total1 - TotauxGeneric.Total2;
               if TotauxGeneric.Total5 >= 0 then
                begin
                 GrGrid2.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total5);
                 GrGrid2.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',0);
                end
                else
                begin
                 GrGrid2.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',0);
                 GrGrid2.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',-TotauxGeneric.Total5);
                end;

               // Totaux de la saisie dans les écrans automatiques

               GrGrid1.cells[2,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total3);
               GrGrid1.cells[3,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total4);

               TotauxGeneric.Total6:=TotauxGeneric.Total3 - TotauxGeneric.Total4;

               if TotauxGeneric.Total6 >= 0 then
                begin
                 GrGrid2.cells[2,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total6);
                 GrGrid2.cells[3,0]:=FormatFloat(E.FormatMonnaie + ';; ',0);
                end
                else
                begin
                 GrGrid2.cells[2,0]:=FormatFloat(E.FormatMonnaie + ';; ',0);
                 GrGrid2.cells[3,0]:=FormatFloat(E.FormatMonnaie + ';; ',-TotauxGeneric.Total6);
                end;

               DeFiltrageDataSet(DMPlan.TaPlanBOCalc);
               ChangementEtatGrille(DBGridCpt);



                     End;

          dsEdit : Begin
                        BtnEnregistrer.Enabled := False;
                        BtnSupprimer.Enabled := True;
                        Annuler1.Enabled := True;
                        EdCompte.Enabled := False;
                        BtnClasse6.Enabled := False;
                        BtnClasse7.Enabled := False;
                        PlanBOChange:=true;
                        ChangementEtatGrille(DBGridCpt);
                   End;

     End; // Fin du Case

end;

end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click sur le bouton enregistrer                                 //
//****************************************************************************//
procedure TBilanOuverture.BtnEnregistrerClick(Sender: TObject);
begin
     If BtnEnregistrer.Enabled Then
     Begin
          TableGerePost(DMPlan.TaPlanBO);
          DBGridCpt.SetFocus;
     End;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click sur le bouton Annuler.                                    //
//****************************************************************************//
procedure TBilanOuverture.BtnAnnulerClick(Sender: TObject);
begin
     If Annuler1.Enabled Then
     Begin
          DMPlan.TaPlanBO.Cancel;
          DBGridCpt.SetFocus;
     End;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du Click sur le bouton Fermer.                                     //
//****************************************************************************//
procedure TBilanOuverture.BtnFermerClick(Sender: TObject);
begin
     Self.Close;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click sur le Speed Bouton Bilan Ouverture.                      //
//****************************************************************************//
procedure TBilanOuverture.SBBilanOuvertureClick(Sender: TObject);
//var
//   var1,var2,var3,var4,var5 : string;
//   Classes : TStringList;
//   BookMark : TBookmark;
//   TotalDebit, TotalCredit: Currency;
begin

//          SBBilanOuverture.Font.Color := clRed;
//          SBChargesProduits.Font.Color := clWindowText;
//          Patitre.Caption:='Ouverture : Balance d''ouverture';
//          Self.Caption := 'Balance d''ouverture';
//          DBGridCpt.Columns[2].Title.Caption := 'Débit';
//          DBGridCpt.Columns[3].Title.Caption := 'Crédit';
//          BtnClasse1.Visible := True;
//          BtnClasse2.Visible := True;
//          BtnClasse3.Visible := True;
//          BtnClasse4.Visible := True;
//          BtnClasse5.Visible := True;
//          BtnClasse6.Visible := False;
//          BtnClasse7.Visible := False;
//
//          Classes := TStringList.Create;
//
//     // Initialisation des variables
//     If BtnClasse1.Down = True Then Var1 := '1*' Else Var1 := '0*';
//     If BtnClasse2.Down = True Then Var2 := '2*' Else Var2 := '0*';
//     If BtnClasse3.Down = True Then Var3 := '3*' Else Var3 := '0*';
//     If BtnClasse4.Down = True Then Var4 := '4*' Else Var4 := '0*';
//     If BtnClasse5.Down = True Then Var5 := '5*' Else Var5 := '0*';
//
//     // Initialisation des labels
//     If Not(BtnClasse1.Down and BtnClasse2.Down and BtnClasse3.Down and BtnClasse4.Down and BtnClasse5.Down) Then
//     Begin
//          Classes.Clear;
//          If BtnClasse1.Down Then Classes.Add('1');
//          If BtnClasse2.Down Then Classes.Add('2');
//          If BtnClasse3.Down Then Classes.Add('3');
//          If BtnClasse4.Down Then Classes.Add('4');
//          If BtnClasse5.Down Then Classes.Add('5');
//
//          Label1.Caption := 'Total pour les classes ' + Classes.CommaText;
//          Label2.Caption := 'Solde pour les classes ' + Classes.CommaText;
//
//          Classes.Destroy;
//     End
//     Else
//     Begin
//          Label1.Caption := 'Total balance d''ouverture :';
//          Label2.Caption := 'Solde';
//     End;
//
//     DMPlan.TaPlanBO.DisableControls;
//
//     // Filtrage de la table des comptes
//     DMPlan.TaPlanBO.Filtered := False;
//     DMPlan.TaPlanBO.Filter :=CreeFiltreOU('Compte',[var1,var2,var3,var4,var5]);
//     DMPlan.TaPlanBO.Filtered := True;
//
//     Bookmark := DMPlan.TaPlanBO.GetBookmark;
//
//     TotalDebit := 0;
//     TotalCredit := 0;
//     DMPlan.TaPlanBO.First;
//     while not DMPlan.TaPlanBO.EOF do
//     begin
//          TotalDebit := TotalDebit + DMPlan.TaPlanBODebit_Deb.Value;
//          Totalcredit := TotalCredit + DMPlan.TaPlanBOCredit_Deb.Value;
//          DMPlan.TaPlanBO.Next;
//     end;
//
//     EdTotalDeb.Text := FloatToStr(TotalDebit);
//     EdTotalCred.Text := FloatToStr(TotalCredit);
//
//     If TotalDebit = TotalCredit Then
//     Begin
//          EdSoldeCredit.Text := FloatToStr(0);
//          EdSoldeDebit.Text := FloatToStr(0);
//     End
//     Else
//     Begin
//          If TotalDebit > TotalCredit Then
//          Begin
//               EdSoldeCredit.Text := FloatToStr(0);
//               EdSoldeDebit.Text := FloatToStr(TotalDebit - TotalCredit);
//          End
//          Else
//          Begin
//               EdSoldeCredit.Text := FloatToStr(TotalCredit - TotalDebit);
//               EdSoldeDebit.Text := FloatToStr(0);
//          End;
//     End;
//
//
//     Try
//        DMPlan.TaPlanBO.GotoBookmark(Bookmark);
//     Except
//        DMPlan.TaPlanBO.First;
//     End;
//
//     DMPlan.TaPlanBO.FreeBookmark(Bookmark);
//     DMPlan.TaPlanBO.EnableControls;


end;
//****************************************************************************//



//****************************************************************************//
// Gestion du click sur le Speed Bouton Charges & Crédits N-1                 //
//****************************************************************************//
procedure TBilanOuverture.SBChargesProduitsClick(Sender: TObject);
//var
//   var6, var7 : string;
//   Classes : TStringList;
//   Bookmark : TBookmark;
//   TotalCredit, TotalDebit: Currency;
begin

//          SBChargesProduits.Font.Color := clRed;
//          SBBilanOuverture.Font.Color := clWindowText;
//          Patitre.Caption:='Ouverture : Charges et Produits N-1';
//          Self.Caption := 'Charges & Produits N-1';
//          DBGridCpt.Columns[2].Title.Caption := 'Charges & Dépenses';
//          DBGridCpt.Columns[3].Title.Caption := 'Produits & Recettes';
//          BtnClasse1.Visible := False;
//          BtnClasse2.Visible := False;
//          BtnClasse3.Visible := False;
//          BtnClasse4.Visible := False;
//          BtnClasse5.Visible := False;
//          BtnClasse6.Visible := True;
//          BtnClasse7.Visible := True;
//
//          Classes := TStringList.Create;
//
//          // Initialisation des variables
//          If BtnClasse6.Down = True Then Var6 := '6*' Else Var6 := '0*';
//          If BtnClasse7.Down = True Then Var7 := '7*' Else Var7 := '0*';
//
//          // Initialisation des labels
//          If Not(BtnClasse6.Down and BtnClasse7.Down) Then
//          Begin
//               Classes.Clear;
//               If BtnClasse6.Down Then Classes.Add('6');
//               If BtnClasse7.Down Then Classes.Add('7');
//
//               Label1.Caption := 'Total des Charges et Produits pour les classes ' + Classes.CommaText;
//               Label2.Caption := 'Solde pour les classes ' + Classes.CommaText;
//
//               Classes.Destroy;
//          End
//          Else
//          Begin
//               Label1.Caption := 'Total des Charges et Produits';
//               Label2.Caption := 'Solde';
//          End;
//
//          Bookmark := DMPlan.TaPlanBO.GetBookmark;
//          DMPlan.TaPlanBO.DisableControls;
//
//          // Filtrage de la table des comptes
//          DMPlan.TaPlanBO.Filtered := False;
//          DMPlan.TaPlanBO.Filter :=CreeFiltreOU('Compte',[var6,var7]);
//          DMPlan.TaPlanBO.Filtered := True;
//
//
//          TotalDebit := 0;
//          TotalCredit := 0;
//          DMPlan.TaPlanBO.First;
//          while not DMPlan.TaPlanBO.EOF do
//          begin
//               TotalDebit := TotalDebit + DMPlan.TaPlanBODebit_Deb.Value;
//               Totalcredit := TotalCredit + DMPlan.TaPlanBOCredit_Deb.Value;
//               DMPlan.TaPlanBO.Next;
//          end;
//
//          EdTotalDeb.Text := FloatToStr(TotalDebit);
//          EdTotalCred.Text := FloatToStr(TotalCredit);
//
//          If TotalDebit = TotalCredit Then
//          Begin
//               EdSoldeCredit.Text := FloatToStr(0);
//               EdSoldeDebit.Text := FloatToStr(0);
//          End
//          Else
//          Begin
//               If TotalDebit > TotalCredit Then
//               Begin
//                    EdSoldeCredit.Text := FloatToStr(0);
//                    EdSoldeDebit.Text := FloatToStr(TotalDebit - TotalCredit);
//               End
//               Else
//               Begin
//                    EdSoldeCredit.Text := FloatToStr(TotalCredit - TotalDebit);
//                    EdSoldeDebit.Text := FloatToStr(0);
//               End;
//          End;
//
//
//          Try
//             DMPlan.TaPlanBO.GotoBookmark(Bookmark);
//          Except
//             DMPlan.TaPlanBO.First;
//          End;
//
//          DMPlan.TaPlanBO.FreeBookmark(Bookmark);
//          DMPlan.TaPlanBO.EnableControls;
//
end;
//****************************************************************************//


//****************************************************************************//
// Gestion de la sélection des classes 6 et 7 des comptes.                    //
//****************************************************************************//
procedure TBilanOuverture.BtnClasse6Click(Sender: TObject);
var
   var6, var7: String;
   Bookmark: TBookMark;
//   TotalDebit, Totalcredit: Currency;
   Classes : TStringList;
begin

     Classes := TStringList.Create;

     // Initialisation des variables
     If BtnClasse6.Down = True Then Var6 := '6*' Else Var6 := '0*';
     If BtnClasse7.Down = True Then Var7 := '7*' Else Var7 := '0*';

     // Initialisation des labels
     If Not(BtnClasse6.Down and BtnClasse7.Down) Then
     Begin
          Classes.Clear;
          If BtnClasse6.Down Then Classes.Add('6');
          If BtnClasse7.Down Then Classes.Add('7');

//          Label1.Caption := 'Total des Charges et Produits pour les classes ' + Classes.CommaText;
//          Label2.Caption := 'Solde pour les classes ' + Classes.CommaText;

          Classes.Destroy;
     End
     Else
     Begin
//          Label1.Caption := 'Total des Charges et Produits';
//          Label2.Caption := 'Solde';
     End;

     Bookmark := DMPlan.TaPlanBO.GetBookmark;
     DMPlan.TaPlanBO.DisableControls;

     // Filtrage de la table des comptes
     DMPlan.TaPlanBO.Filtered := False;
     DMPlan.TaPlanBO.Filter :=CreeFiltreOU('Compte',[var6,var7]);
     DMPlan.TaPlanBO.Filtered := True;



     Try
        DMPlan.TaPlanBO.GotoBookmark(Bookmark);
     Except
        DMPlan.TaPlanBO.First;
     End;

     DMPlan.TaPlanBO.FreeBookmark(Bookmark);
     DMPlan.TaPlanBO.EnableControls;

end;
//****************************************************************************//

Procedure TBilanOuverture.InitialiseTable_A_Nil;
Begin
     if DMPlan<>nil then
     InitDatasetEvent_A_Nil_Sur_Form([DMPlan.DaPlanBO]);
End;

//****************************************************************************//
// Gestion du Destroy de la fenêtre.                                          //
//****************************************************************************//
procedure TBilanOuverture.FormDestroy(Sender: TObject);
begin
     InitialiseTable_A_Nil;
     LibGestionParamXML.DestroyForm(Self,E.USer);
     BilanOuverture:=Nil;
end;
//****************************************************************************//

procedure TBilanOuverture.RxSpeedButton2Click(Sender: TObject);
begin
case self.tag of
   1:Main.Provisions1Click(Main.Provisions1);
   2:begin
       self.tag:=1;
       Main.Balance1Click(Main.Bilandouverture1);
       SBBilanOuvertureClick(RxSpeedButton2);
       RxSpeedButton1.Visible:=true;
     end;
end;


end;

procedure TBilanOuverture.RxSpeedButton1Click(Sender: TObject);
begin
case self.tag of
   1:begin
       self.tag:=2;
       Main.ChargesetProduitsAnneAntrieure1Click(Main.ChargesetProduitsAnneAntrieure1);
       SBChargesProduitsClick(RxSpeedButton1);
       RxSpeedButton1.Visible:=false
     end;
   2:if RxSpeedButton1.Visible then Main.ValidationBalancedouverture1Click(Main.ValidationBalancedouverture1);
end;
end;

procedure TBilanOuverture.PatitreResize(Sender: TObject);
begin
//RxSpeedButton1.top:=12;
RxSpeedButton1.Left:=Patitre.Width-104;
//RxSpeedButton1.Height:=Patitre.Height-24;
end;

procedure TBilanOuverture.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);

WinShape(screen.ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

Function TBilanOuverture.CalculLeft (colcourante : integer) : integer;
Var
   i : integer;
Begin
     Result := 8;
     for  i:=0 to (colcourante - 1) do
     begin
          result := Result + DBGridCpt.ColWidths[i];
     end;
//     Result := Result + ExRxDBGrid1.Left + 11;
End;

procedure TBilanOuverture.PaGrilleResize(Sender: TObject);
begin
FormateTailleColonne(DBGridCpt,16,[2,3,2,2,2]);
PositionTotaux;
WinShape(screen.ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TBilanOuverture.PaBasDResize(Sender: TObject);
begin
Label4.Left:=(PaBasD.Width-192) div 3;
EdCompte.left:=Label4.Left+135;
DBCompte.Left:=EdCompte.left;
DBTextCompte.Left:=EdCompte.left+70;
WinShape(screen.ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TBilanOuverture.Aide1Click(Sender: TObject);
begin
 If activecontrol = DBGridCpt Then
  begin
   case DBGridCpt.DataSource.State of
//      dsinsert,dsedit:case DBEmprunt.SelectedIndex of
//                         1:begin
//                            DMEmprunts.FiltragesAideCompte(22);
//                            DBEmprunt.EditorMode:=true;
//                            AideCompte.InitialiseCompte;
//                            AideCompteAffiche(DBEmprunt.InplaceEditor);
//                            DBEmprunt.Columns[1].Field.AsString:=DBEmprunt.InplaceEditor.Text;
//                           end;
//                         2: ;
//                      end;
      dsbrowse:case DBGridCpt.SelectedIndex of
                  0:Rechercher(DBGridCpt,DMPlan.TaPlanBO,['Compte','Libelle'],['Compte','Désignation'],'',0);
                  1:Rechercher(DBGridCpt,DMPlan.TaPlanBO,['Libelle','Compte'],['Désignation','Compte'],'',0);
               end;
   end;
 end;

end;

procedure TBilanOuverture.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
Patitre.visible:=Main.AfficheTitre;

//DMPlan.TaCompte.OnFilterRecord:=nil;
//DMPlan.InitChampAutoriseBO(DMPlan.TaPlanBO);
DBGridCpt.ParamColor:=true;
DBGridCpt.Param:=ParamUtil.CouleurDBGrid;
DBGridCpt.UpDateColor;

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
//  TableRefresh(DMPlan.TaPlanBO,'Compte');
//  DMPlan.TaPlanBO.close;
if not (DMPlan.TaPlanBO.State in [dsEdit,dsInsert]) then
 begin
  TableRefreshSurClose(DMPlan.TaPlanBO,'Compte');
 end;
GereAccesEcran; 
end;

procedure TBilanOuverture.DBGridCptDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  holdColor: TColor;
begin
try
   if Column.Field.DataSet.FindField('Ouverture').AsBoolean then
    begin
         holdColor:=DBGridCpt.Canvas.Brush.Color;
         DBGridCpt.Canvas.Brush.Color :=clSilver;//$00808040;
         DBGridCpt.DefaultDrawColumnCell(Rect, DataCol, Column, State);
         DBGridCpt.Canvas.Brush.Color := holdColor;
    end
except
RxLabTitre.Caption:='Erreur d''affichage grille';
end;
//if DMPlan.ListeCptOkBO.IndexOf(Column.Field.DataSet.Fields[0].AsString)<>-1 then
//if ((Column.FieldName = 'Debit_Deb') or (Column.FieldName = 'Credit_Deb')) then
//    begin
//      holdColor:=DBGridCpt.Canvas.Brush.Color;
//      DBGridCpt.Canvas.Brush.Color :=$005959FF;//$00808040;
//      DBGridCpt.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//      DBGridCpt.Canvas.Brush.Color := holdColor;
//    end;

end;

procedure TBilanOuverture.DBCompteEnter(Sender: TObject);
begin
EdCompte.SetFocus;
DBCompte.SendToBack;
end;

procedure TBilanOuverture.EdCompteExit(Sender: TObject);
begin
DBCompte.BringToFront;
//DBCompte.Visible:=true;
end;

procedure TBilanOuverture.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
canclose:=true;
if DMPlan.TaPlanBO.State in [dsEdit,dsInsert] then
 begin
   self.WindowState:=wsNormal;
   self.BringToFront;
   if Messagedlg('Voulez-vous enregistrer les modifications sur ce compte ?',mtConfirmation,[mbyes,mbno],0)=mryes then
       TableGerePost(DMPlan.TaPlanBO)
       else
       DMPlan.TaPlanBO.Cancel;
 end;
if PlanBOChange=true then
 begin
 self.WindowState:=wsNormal;
 self.BringToFront;
 if Messagedlg('Voulez-vous mettre à jour la balance d''ouverture ?',mtConfirmation,[mbyes,mbno],0)=mryes then
  begin
   DMPlan.MAJBalManuBalAuto;
   MaJReportChargeEtProduit(DMRech.TaPlanCptRech);
// showmessage('Mise à jour de la balance d''ouverture non effectué dans cette version. '+#13#10#13#10+NumVersion);
   PlanBOChange:=False;
   canclose:=true;
  end
   else
   begin
    canclose:=false;
   end;
 end;
if canclose then InitialiseTable_A_Nil; { isa  le  29/01/04 } 
end;

procedure TBilanOuverture.BtnSupprimerClick(Sender: TObject);
begin
  TableGereDelete(DMPlan.TaPlanBO);
  DBGridCpt.SelectedIndex := 0;
  DBGridCpt.SetFocus;
end;

procedure TBilanOuverture.BtnInsererClick(Sender: TObject);
begin
DMPlan.TaPlanBO.Insert;
end;

procedure TBilanOuverture.PaTotauxResize(Sender: TObject);
begin
WinShape(screen.ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TBilanOuverture.BtnEnregistrerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TBilanOuverture.BtnEnregistrerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TBilanOuverture.Visualisation1Click(Sender: TObject);
begin
DetailEcritureCompte(DMPlan.TaPlanBO.FindField('Compte').AsString,true,true);
end;

procedure TBilanOuverture.BtnImprimerClick(Sender: TObject);
begin
DBGridCpt.ReportCaption:='Bilan d''ouverture';
DBGridCpt.GridPreview;
end;

procedure TBilanOuverture.RxSpeedButton3Click(Sender: TObject);
begin
 if Messagedlg('Voulez-vous mettre à jour la balance d''ouverture ?',mtConfirmation,[mbyes,mbno],0)=mryes then
  begin
   DMPlan.MAJBalManuBalAuto;
   MaJReportChargeEtProduit(DMRech.TaPlanCptRech);
   DataSource1StateChange(DBGridCpt.DataSource);
  end;
end;

procedure TBilanOuverture.BtnModifierClick(Sender: TObject);
begin
DBGridCpt.SetFocus;
if not DBGridCpt.SelectedIndex in [2..3] then
DBGridCpt.SelectedIndex:=2;
DMPlan.TaPlanBO.Edit;
end;

Procedure TBilanOuverture.PositionTotaux;
Begin
  Panel7.Width:=RenvoiTailleColonne(DBGridCpt,[0,1,2])+10;
  GrGrid1.ColWidths[0]:=RenvoiTailleColonne(DBGridCpt,[3]);
  GrGrid1.ColWidths[1]:=RenvoiTailleColonne(DBGridCpt,[4]);
  GrGrid1.ColWidths[2]:=RenvoiTailleColonne(DBGridCpt,[5]);
  GrGrid1.ColWidths[3]:=RenvoiTailleColonne(DBGridCpt,[6]);

  Panel2.Width:=RenvoiTailleColonne(DBGridCpt,[0,1,2])+10;
  GrGrid2.ColWidths[0]:=GrGrid1.ColWidths[0];
  GrGrid2.ColWidths[1]:=GrGrid1.ColWidths[1];
  GrGrid2.ColWidths[2]:=GrGrid1.ColWidths[2];
  GrGrid2.ColWidths[3]:=GrGrid1.ColWidths[3];
End;

procedure TBilanOuverture.Visualisationsurpriode1Click(Sender: TObject);
begin
e.PeriodeAutreImpression.Retour:=true;
e.PeriodeAutreImpression.DateDeb:=0;
e.PeriodeAutreImpression.DateFin:=e.DatExoFin;
DetailEcritureCompte(DMPlan.TaPlanBO.FindField('Compte').AsString,true,True,true);
end;


Procedure TBilanOuverture.GereAccesEcran;
begin
     //Grille des comptes d'emprunts utilisés
     DBGridCpt.ReadOnly := not E.AccesOuverture;
     DBGridCpt.FSauteColReadOnly := not DBGridCpt.ReadOnly;

     EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer,Twincontrol(RxSpeedButton3)],E.AccesOuverture );
     EnableItemMenu([Insrer1,Modifier1,Supprimer1],E.AccesOuverture);

     DMPlan.GestionAccesPlanBO;
end;
procedure TBilanOuverture.Exporter1Click(Sender: TObject);
begin
if Tag=1 then
  ExportDonnees(DBGridCpt.DataSource.DataSet,E.RepertoireExportDossier,'BilanOuv_'+E.NomDossier + E.NomExo + '.Txt')
else
  ExportDonnees(DBGridCpt.DataSource.DataSet,E.RepertoireExportDossier,'Ch&Prod_Ouv_'+E.NomDossier + E.NomExo + '.Txt');
end;

procedure TBilanOuverture.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(nil);
end;

end.
