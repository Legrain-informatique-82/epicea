{***************************************************************
 *
 * Unit Name: E2_BalanceTiers
 * Purpose  :
 * Author   :  Assemat, BP
 * History  :
 *
 ****************************************************************}

unit E2_BalanceTiers;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, Db, DBTables, E2_Librairie_obj,
  Gr_Librairie_obj, LibSQL, Menus, RXDBCtrl, ExRxDBGrid, GrDBGrid,
  RXCtrls,DMTier,DMEcriture, Mask, ToolEdit, CurrEdit, DBCtrls,registry,AideMontant2,DMTVA,
  LibZoneSaisie,LibRessourceString,E2_Decl_Records,DMConstantes, LibGestionParamXML, jpeg;

type
  TBalanceTiers = class(TForm)
    PaBtnHaut: TPanel;
    ListeCompte: TListBox;
    Label1: TLabel;
    PaBas: TPanel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    Patitre: TPanel;
    Label3: TLabel;
    Query1: TQuery;
    Query1Tiers: TStringField;
    Query1Nom: TStringField;
    Query2: TQuery;
    Query2Tiers: TStringField;
    Query2Nom: TStringField;
    DataSource2: TDataSource;
    PaGrille: TPanel;
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
    PaEntreGriille: TPanel;
    Panel2: TPanel;
    BtnAnnulerT: TButton;
    BtnEnregistrerT: TButton;
    BtnInsererT: TButton;
    BtnModifierT: TButton;
    BtnSupprimerT: TButton;
    BtnFermerT: TButton;
    BtnImprimerT: TButton;
    GridBalanceT: TGrDBGrid;
    SBClients: TRxSpeedButton;
    SBFournisseurs: TRxSpeedButton;
    SBClientsFournisseurs: TRxSpeedButton;
    SBPersonnel: TRxSpeedButton;
    SBOrgSociaux: TRxSpeedButton;
    SBAssocies: TRxSpeedButton;
    SBTous: TRxSpeedButton;
    EdTotalCred: TEdit;
    ModifierTiers1: TMenuItem;
    PaTotauxH: TPanel;
    PaTotauxBas: TPanel;
    EdTotalDebit: TCurrencyEdit;
    EdTotalCredit: TCurrencyEdit;
    Label2: TLabel;
    EdTotalDeb: TCurrencyEdit;
    DBEdit1: TDBEdit;
    EdSoldeDebut: TCurrencyEdit;
    RxLabel1: TRxLabel;
    N2: TMenuItem;
    Prcdent1: TMenuItem;
    Suivant1: TMenuItem;
    PaTools: TPanel;
    RxSpeedButton3: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    RxSpeedButton1: TRxSpeedButton;
    RxSpeedButton2: TRxSpeedButton;
    PaGrilleTiers: TPanel;
    DBGridTiers: TGrDBGrid;
    PaReport: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SBClientsClick(Sender: TObject);
    procedure ListeCompteClick(Sender: TObject);
    Procedure InitTotaux;
    procedure TaTiersBalBeforeInsert(DataSet: TDataSet);
    procedure ListeCompteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DaTiersBalStateChange(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);
    procedure ListeCompteExit(Sender: TObject);
    procedure EdCodeChange(Sender: TObject);
    procedure BtnInsererTClick(Sender: TObject);
    procedure BtnModifierTClick(Sender: TObject);
    procedure PatitreResize(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure Insrer1Click(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure DBGridTiersEnter(Sender: TObject);
    procedure GridBalanceTEnter(Sender: TObject);
    procedure Modifier1Click(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ModifierTiers1Click(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure GridBalanceTColExit(Sender: TObject);
    procedure GridBalanceTExit(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure TaTiersBalAfterScroll(DataSet: TDataSet);
    procedure FormActivate(Sender: TObject);
    procedure GridBalanceTKeyPress(Sender: TObject; var Key: Char);
    procedure Supprimer1Click(Sender: TObject);
    procedure BtnSupprimerTClick(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure BtnAnnulerTEnter(Sender: TObject);
    procedure BtnAnnulerTExit(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure RxSpeedButton2Click(Sender: TObject);
    procedure RxSpeedButton1Click(Sender: TObject);
    procedure RxSBInfoVersionClick(Sender: TObject);
    procedure PaBtnHautResize(Sender: TObject);
    procedure Panel2Resize(Sender: TObject);
    procedure BtnImprimerTClick(Sender: TObject);
    procedure PaTotauxHResize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
    TitreForm,SousTitreForm:String;
  end;

var
  BalanceTiers: TBalanceTiers;

  Mark: TBookMark;
  Aide : THintWindow;
  C:TPoint;
  rec:TRect;
  IndexShowHint:Integer;
  TabShowHint:array[0..19] of TControl;

implementation
{$R *.DFM}
Uses
    //Gr_Calculatrice,
    E2_AideAssist,  E2_Tiers,
  E2_AideCompte,E2_Recherche,DMPlanCpt, E2_Main, DMBalances, ImportDll;



//****************************************************************************//
// Initialisation des totaux.                                                 //
//****************************************************************************//
Procedure TBalanceTiers.InitTotaux;
var
TotauxBalance:TTotauxBalance;
begin
//if not DMBalance.TaBalanceT_Aux.Active
// then DMBalance.TaBalanceT_Aux.Open else
//DMBalance.TaBalanceT_Aux.refresh;
//DMBalance.TaBalanceT_Aux.Filter:=DMBalance.TaBalanceT.Filter;
//DMBalance.TaBalanceT_Aux.Filtered:=DMBalance.TaBalanceT.Filtered;
//TotauxBalance:=DMBalance.SommeTotauxBalance(DMBalance.TaBalanceT_Aux);
//EdTotalDebit.Value:=TotauxBalance.TotalDebitReport;
//EdTotalCredit.Value:=TotauxBalance.TotalCreditReport;
//if TotauxBalance.SoldeDebitCreditReport then
// begin
//   EdSoldeDebut.Value:=TotauxBalance.SoldeReport;
// end
// else
// begin
//  EdSoldeDebut.Value:=abs(TotauxBalance.SoldeReport);
// end;
end;

//****************************************************************************//
// Gestion de la cr�ation de la fen�tre.                                      //
//****************************************************************************//
procedure TBalanceTiers.FormCreate(Sender: TObject);
Var
	Registre :TRegistry;
begin
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poDesigned;
        InitialiseFormPosDefaut(self);
       //	Left:= 0; Top:= 70; Width:= screen.Width; Height:= screen.Height-top;
    end;
//   showmessage('-1');
 DBGridTiersEnter(DBGridTiers);
//   showmessage('0');
 if AideCompte=nil then
 AideCompte:=TAideCompte.Create(self);

 Registre:= TRegistry.Create;
 try
  with Registre do
    begin
     RootKey := HKEY_LOCAL_MACHINE;
     OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, false);
       try
        case ReadInteger('SBBT') of
          0:Begin
             ListeCompte.Tag:=0;
             DMTiers.TaTiersBal.Filter := CreeFiltreOU('Compte',['41*']);
             SBClients.Font.Color:=clRed;
             SBClients.Down:=true;
             SBFontColor([SBFournisseurs,SBClientsFournisseurs,SBPersonnel,SBOrgSociaux,SBAssocies,SBTous],clWindowText);
//             SBDown([SBFournisseurs,SBClientsFournisseurs,SBPersonnel,SBOrgSociaux,SBAssocies,SBTous],False);
            End;
          1:Begin
             ListeCompte.Tag:=1;
             DMTiers.TaTiersBal.Filter := CreeFiltreOU('Compte',['40*']);
             SBFournisseurs.Font.Color:=clRed;
             SBFournisseurs.Down:=true;
             SBFontColor([SBClients,SBClientsFournisseurs,SBPersonnel,SBOrgSociaux,SBAssocies,SBTous],clWindowText);
//             SBDown([SBClients,SBClientsFournisseurs,SBPersonnel,SBOrgSociaux,SBAssocies,SBTous],False);
            End;
          2:Begin
             ListeCompte.Tag:=2;
             DMTiers.TaTiersBal.Filter := CreeFiltreOU('Compte',['46*','472*']);
             SBClientsFournisseurs.Font.Color:=clRed;
             SBClientsFournisseurs.Down:=true;
             SBFontColor([SBClients,SBFournisseurs,SBPersonnel,SBOrgSociaux,SBAssocies,SBTous],clWindowText);
//             SBDown([SBClients,SBFournisseurs,SBPersonnel,SBOrgSociaux,SBAssocies,SBTous],False);
            End;
          3:Begin
             ListeCompte.Tag:=3;
             DMTiers.TaTiersBal.Filter := CreeFiltreOU('Compte',['42*']);
             SBPersonnel.Font.Color:=clRed;
             SBPersonnel.Down:=true;
             SBFontColor([SBClients,SBFournisseurs,SBClientsFournisseurs,SBOrgSociaux,SBAssocies,SBTous],clWindowText);
//             SBDown([SBClients,SBFournisseurs,SBClientsFournisseurs,SBOrgSociaux,SBAssocies,SBTous],False);
            End;
          4:Begin
             ListeCompte.Tag:=4;
             DMTiers.TaTiersBal.Filter := CreeFiltreOU('Compte',['43*']);
             SBOrgSociaux.Font.Color:=clRed;
             SBOrgSociaux.Down:=true;
             SBFontColor([SBClients,SBFournisseurs,SBClientsFournisseurs,SBPersonnel,SBAssocies,SBTous],clWindowText);
//             SBDown([SBClients,SBFournisseurs,SBClientsFournisseurs,SBPersonnel,SBAssocies,SBTous],False);
            End;
          5:Begin
             ListeCompte.Tag:=5;
             DMTiers.TaTiersBal.Filter := CreeFiltreOU('Compte',['45*']);
             SBAssocies.Font.Color:=clRed;
             SBAssocies.Down:=true;
             SBFontColor([SBClients,SBFournisseurs,SBClientsFournisseurs,SBPersonnel,SBOrgSociaux,SBTous],clWindowText);
//             SBDown([SBClients,SBFournisseurs,SBClientsFournisseurs,SBPersonnel,SBOrgSociaux,SBTous],False);
            End;
          6:Begin
             ListeCompte.Tag:=6;
             DMTiers.TaTiersBal.Filter := CreeFiltreOU('Compte',['40*','41*','42*','43*','44*','45*','46*','472*']);
             SBTous.Font.Color:=clRed;
             SBTous.Down:=true;
             SBFontColor([SBClients,SBFournisseurs,SBClientsFournisseurs,SBPersonnel,SBOrgSociaux,SBAssocies],clWindowText);
//             SBDown([SBClients,SBFournisseurs,SBClientsFournisseurs,SBPersonnel,SBOrgSociaux,SBAssocies],False);
            End;
        end;
       except
        Begin
             ListeCompte.Tag:=6;
             DMTiers.TaTiersBal.Filter := CreeFiltreOU('Compte',['40*','41*','42*','43*','44*','45*','46*','472*']);
             SBTous.Font.Color:=clRed;
             SBTous.Down:=true;
             SBFontColor([SBClients,SBFournisseurs,SBClientsFournisseurs,SBPersonnel,SBOrgSociaux,SBAssocies],clWindowText);
//             SBDown([SBFournisseurs,SBClientsFournisseurs,SBPersonnel,SBOrgSociaux,SBAssocies,SBTous],False);
            End;
       end;
    end;
   finally
    Registre.Free;
   end;
//   showmessage('1');
 DMTiers.TaTiersBal.Filtered:=true;
EdTotalDebit.DisplayFormat:=E.FormatMonnaie;
EdTotalCredit.DisplayFormat:=E.FormatMonnaie;
EdTotalDeb.DisplayFormat:=E.FormatMonnaie;
EdSoldeDebut.DisplayFormat:=',0.00 '+E.DeviseSigle+' Cr�dit;,0.00 '+E.DeviseSigle+'  D�bit;,0.00 '+E.DeviseSigle+'    Null';
end;
//****************************************************************************//


//****************************************************************************//
// Gestion de l'�v�nement OnShow de la fen�tre.                               //
//****************************************************************************//
procedure TBalanceTiers.FormShow(Sender: TObject);
begin
//   showmessage('15');
 DMTiers.TaTiersBal.AfterScroll:=TaTiersBalAfterScroll;    { isa  le  29/01/04 }
 DMTiers.TaTiersBal.BeforeInsert:=TaTiersBalBeforeInsert;

     Patitre.Color:=$00ADEBFF;
     PaTools.Color:=$00ADEBFF;
     InitTotaux;

     DBGridTiers.SetFocus;
     DBGridTiers.SelectedIndex := 3;

     Label2.Caption := 'Total des Dettes et Cr�ances';
     Label3.Caption := 'Solde';

    RxSpeedButton2.Hint:='Saisie des Dettes et Cr�ances � l''ouverture.'+HintRaccourciCtrlP;
    RxSpeedButton1.Hint:='Charges � r�partir � l''ouverture.'+HintRaccourciCtrlS;
    RxSBGraphe.Hint:=RxSBGraphe.Hint+HintRaccourciAucun;
    BtnAnnuler.Hint:=BtnAnnuler.Hint+HintRaccourciEsc;
    BtnEnregistrer.Hint:=BtnEnregistrer.Hint+HintRaccourciF3;
    BtnInserer.Hint:=BtnInserer.Hint+HintRaccourciF6;
    BtnModifier.Hint:=BtnModifier.Hint+HintRaccourciF8;
    BtnSupprimer.Hint:=BtnSupprimer.Hint+HintRaccourciF10;
    BtnFermer.Hint:=BtnFermer.Hint+HintRaccourciEsc;
    BtnImprimer.Hint:=BtnImprimer.Hint+HintRaccourciF11;

    BtnAnnulerT.Hint:=BtnAnnulerT.Hint+HintRaccourciEsc;
    BtnEnregistrerT.Hint:=BtnEnregistrerT.Hint+HintRaccourciF3;
    BtnInsererT.Hint:=BtnInsererT.Hint+HintRaccourciF6;
    BtnModifierT.Hint:=BtnModifierT.Hint+HintRaccourciF8;
    BtnSupprimerT.Hint:=BtnSupprimerT.Hint+HintRaccourciF10;
    BtnFermerT.Hint:=BtnFermerT.Hint+HintRaccourciEsc;
    BtnImprimerT.Hint:=BtnImprimerT.Hint+HintRaccourciF11;
    IndexShowHint:=1;
    TabShowHint[0]:=RxSpeedButton2;
    TabShowHint[1]:=RxSpeedButton1;
    TabShowHint[2]:=RxSBGraphe;
    TabShowHint[3]:=DBGridTiers;
    TabShowHint[4]:=BtnAnnulerT;
    TabShowHint[5]:=BtnEnregistrerT;
    TabShowHint[6]:=BtnInsererT;
    TabShowHint[7]:=BtnModifierT;
    TabShowHint[8]:=BtnSupprimerT;
    TabShowHint[9]:=BtnFermerT;
    TabShowHint[10]:=BtnImprimerT;
    TabShowHint[11]:=GridBalanceT;
    TabShowHint[12]:=BtnAnnuler;
    TabShowHint[13]:=BtnEnregistrer;
    TabShowHint[14]:=BtnInserer;
    TabShowHint[15]:=BtnModifier;
    TabShowHint[16]:=BtnSupprimer;
    TabShowHint[17]:=BtnFermer;
    TabShowHint[18]:=BtnImprimer;

     Mark := Nil;
//   showmessage('16');

end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click sur le SpeedBouton Clients.                               //
//****************************************************************************//
procedure TBalanceTiers.SBClientsClick(Sender: TObject);
begin
     DMTiers.TaTiersBal.DisableControls;
     DMTiers.TaTiersBal.AfterScroll:=nil;
     Label2.Caption := 'Total des Charges et Produits';
     Label3.Caption := 'Solde';
     With Sender as TRxSpeedButton Do
     Begin
          DMTiers.TaTiersBal.Filtered := False;
          Label1.Caption:='Comptes Collectifs ' + (Sender as TRxSpeedButton).caption + ' : < Tous > ';
          ListeCompte.Left := Left;
          ListeCompte.Width:=Width;
          Case Tag Of
          0 : Begin
                   DMTiers.TaTiersBal.Filter := CreeFiltreOU('Compte',['41*']);
                   ListeCompte.Tag:=Tag;

                   Font.Color := clRed;
                   SBFontColor([SBFournisseurs,SBClientsFournisseurs,SBPersonnel,SBOrgSociaux,SBAssocies,SBTous],clWindowText);

//                   Down := True;
//                   SBDown([SBFournisseurs,SBClientsFournisseurs,SBPersonnel,SBOrgSociaux,SBAssocies,SBTous],False);
              End;
          1 : Begin
                   DMTiers.TaTiersBal.Filter := CreeFiltreOU('Compte',['40*']);
                   ListeCompte.Tag:=Tag;

                   Font.Color := clRed;
                   SBFontColor([SBClients,SBClientsFournisseurs,SBPersonnel,SBOrgSociaux,SBAssocies,SBTous],clWindowText);

//                   Down := True;
//                   SBDown([SBClients,SBClientsFournisseurs,SBPersonnel,SBOrgSociaux,SBAssocies,SBTous],False);
              End;
          2 : Begin
                   DMTiers.TaTiersBal.Filter := CreeFiltreOU('Compte',['46*','472*']);
                   ListeCompte.Tag:=Tag;

                   Font.Color := clRed;
                   SBFontColor([SBClients,SBFournisseurs,SBPersonnel,SBOrgSociaux,SBAssocies,SBTous],clWindowText);

//                   Down := True;
//                   SBDown([SBClients,SBFournisseurs,SBPersonnel,SBOrgSociaux,SBAssocies,SBTous],False);

              End;
          3 : Begin
                   DMTiers.TaTiersBal.Filter := CreeFiltreOU('Compte',['42*']);
                   ListeCompte.Tag:=Tag;

                   Font.Color := clRed;
                   SBFontColor([SBClients,SBFournisseurs,SBClientsFournisseurs,SBOrgSociaux,SBAssocies,SBTous],clWindowText);

//                   Down := True;
//                   SBDown([SBClients,SBFournisseurs,SBClientsFournisseurs,SBOrgSociaux,SBAssocies,SBTous],False);

              End;
          4 : Begin
                   DMTiers.TaTiersBal.Filter := CreeFiltreOU('Compte',['43*']);
                   ListeCompte.Tag:=Tag;

                   Font.Color := clRed;
                   SBFontColor([SBClients,SBFournisseurs,SBClientsFournisseurs,SBPersonnel,SBAssocies,SBTous],clWindowText);

//                   Down := True;
//                   SBDown([SBClients,SBFournisseurs,SBClientsFournisseurs,SBPersonnel,SBAssocies,SBTous],False);

              End;
          5 : Begin
                   DMTiers.TaTiersBal.Filter := CreeFiltreOU('Compte',['45*']);
                   ListeCompte.Tag:=Tag;

                   Font.Color := clRed;
                   SBFontColor([SBClients,SBFournisseurs,SBClientsFournisseurs,SBPersonnel,SBOrgSociaux,SBTous],clWindowText);

//                   Down := True;
//                   SBDown([SBClients,SBFournisseurs,SBClientsFournisseurs,SBPersonnel,SBOrgSociaux,SBTous],False);

              End;
          6 : Begin
                   ListeCompte.Left := Left-58;
                   ListeCompte.Width:=Width+48;

                   DMTiers.TaTiersBal.Filter := CreeFiltreOU('Compte',['40*','41*','42*','43*','44*','45*','46*','472*']);
                   ListeCompte.Tag:=Tag;

                   Font.Color := clRed;
                   SBFontColor([SBClients,SBFournisseurs,SBClientsFournisseurs,SBPersonnel,SBOrgSociaux,SBAssocies],clWindowText);

//                   Down := True;
//                   SBDown([SBClients,SBFournisseurs,SBClientsFournisseurs,SBPersonnel,SBOrgSociaux,SBAssocies],False);
              End;
          End; // Fin du Case

          DMTiers.TaTiersBal.Filtered := True;
          InitTotaux;
          ListeCompte.Clear;
          DMTiers.TaTiersBal.First;
          ListeCompte.Items.Add(' < Tous > ');
          While not DMTiers.TaTiersBal.EOF do
          Begin
               If ListeCompte.Items.IndexOf(DMTiers.TaTiersBalCompte.AsString) = -1 Then
                  ListeCompte.Items.Add(DMTiers.TaTiersBalCompte.AsString);
               DMTiers.TaTiersBal.Next;
          End;
          DMTiers.TaTiersBal.EnableControls;
          ListeCompte.Visible := True;
          ListeCompte.Sorted := True;
          ListeCompte.ItemIndex := 0;
          ListeCompte.SetFocus;
     End;
end;
//****************************************************************************//
// Gestion du click dans la liste des comptes.                                //
//****************************************************************************//
procedure TBalanceTiers.ListeCompteClick(Sender: TObject);
var
   Titre,Titre1 : string;
begin
//     DMTiers.TaTiersBal.DisableControls;
     DMTiers.TaTiersBal.Filtered:=false;
     if ListeCompte.ItemIndex > 0 then
     Begin
          DMTiers.TaTiersBal.Filter := CreeFiltreOU('Compte',[ListeCompte.items[ListeCompte.itemindex]]);
          Case ListeCompte.tag Of
          0:Titre:='Clients';
          1:Titre:='Fournisseurs';
          2:Titre:='Clients Fournisseurs Divers';
          3:Titre:='Personnel';
          4:Titre:='Organismes Sociaux';
          5:Titre:='Associ�s';
          6:Titre:='Tous les Tiers';
          end; // Fin du Case
    End
    Else
    Begin
         Case ListeCompte.tag Of
          0:Begin
             DMTiers.TaTiersBal.Filter := CreeFiltreOU('Compte',['41*']);
             Titre:='Clients';
            End;
          1:Begin
             DMTiers.TaTiersBal.Filter := CreeFiltreOU('Compte',['40*']);
             Titre:='Fournisseurs';
            End;
          2:Begin
             DMTiers.TaTiersBal.Filter := CreeFiltreOU('Compte',['46*','472*']);
             Titre:='Clients Fournisseurs Divers';
            End;
          3:Begin
             DMTiers.TaTiersBal.Filter := CreeFiltreOU('Compte',['42*']);
             Titre:='Personnel';
            End;
          4:Begin
             DMTiers.TaTiersBal.Filter := CreeFiltreOU('Compte',['43*']);
             Titre:='Organismes Sociaux';
            End;
          5:Begin
             DMTiers.TaTiersBal.Filter := CreeFiltreOU('Compte',['45*']);
             Titre:='Associ�s';
            End;
          6:Begin
             DMTiers.TaTiersBal.Filter := CreeFiltreOU('Compte',['40*','41*','42*','43*','44*','45*','46*','472*']);
             Titre:='Tous les Tiers';
            End;
         End; // Fin du Case
    End;

    Label1.Caption:='Comptes Collectifs ' + Titre + ' : ' + ListeCompte.items[ListeCompte.itemindex];

    InitTotaux;
    DMTiers.TaTiersBal.Filtered:=true;
//    DMTiers.TaTiersBal.EnableControls;
    ListeCompte.Visible:=false;
    DBGridTiers.SetFocus;

end;
//****************************************************************************//

//****************************************************************************//
// Emp�cher l'utilisateur d'ins�rer un nouvel enregistrement dans la grille.  //
//****************************************************************************//

procedure TBalanceTiers.TaTiersBalBeforeInsert(DataSet: TDataSet);
begin
DMTiers.TaTiersBal.AfterScroll:=nil;
BalanceTiers.BtnInsererTClick(BalanceTiers.BtnInsererT);
Abort;
end;

//****************************************************************************//
// Gestion des Touches dans la liste des comptes.                             //
//****************************************************************************//

procedure TBalanceTiers.ListeCompteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     If Key = VK_UP Then
     Begin
          ListeCompte.ItemIndex := Listecompte.ItemIndex - 1 ;
          Abort;
     End;
     If Key = VK_DOWN Then
     Begin
          ListeCompte.ItemIndex := Listecompte.ItemIndex + 1 ;
          Abort;
     End;
     If Key = VK_RETURN Then
     Begin
          ListeCompteClick(Listecompte);
     End;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion de la fermeture de la fen�tre.                                     //
//****************************************************************************//
procedure TBalanceTiers.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//     If Mark <> Nil Then
//        TaTiers.FreeBookmark(Mark);
//
//     If TaTiers.State in [dsEdit] Then
//     Begin
//          If Messagedlg('Voulez-vous enregistrer avant de Fermer la fen�tre',mtconfirmation,[mbyes,mbno],0) = mryes Then
//             BtnEnregistrer.Click
//          Else
//             BtnAnnuler.Click;
//     End;
//
//     TaTiers.Close;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion de l'appuie sur la touche ENTER quand l'utilisateur est dans       //
// la grille.                                                                 //
//****************************************************************************//
procedure TBalanceTiers.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
     if Key = '+' then begin
            Key := #0;
//            EdCOde.SetFocus;
     end;

//     If Key = #13 Then
//     Begin
//          Key := #0;
//          If DBGrid1.SelectedIndex < 4 Then
//             DBGrid1.SelectedIndex := DBGrid1.SelectedIndex + 1
//          Else
//             If not TaTiers.EOF Then
//             Begin
//                  TaTiers.Next;
//                  DBGrid1.SelectedIndex := 3;
//             End
//             Else
//             Begin
//                  TaTiers.First;
//                  DBGrid1.SelectedIndex := 3;
//             End;
//     End;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du changement de l'�tat de la table.                               //
//****************************************************************************//
procedure TBalanceTiers.DaTiersBalStateChange(Sender: TObject);
begin
Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DMTiers.DaTiersBal.DataSet);
     Case DMTiers.TaTiersBal.State Of
          dsBrowse : Begin
//                      EnableWinControl([BtnAnnulerT,BtnInsererT,BtnModifierT,BtnFermerT,BtnImprimerT],True);
//                      BtnSupprimerT.Enabled:=(DMTiers.TaTiersBal.RecordCount>0);
//                      BtnEnregistrerT.Enabled := False;
                     End;

          dsEdit : Begin
//                      EnableWinControl([BtnAnnulerT,BtnEnregistrerT,BtnSupprimerT,BtnFermerT],True);
//                      EnableWinControl([BtnInsererT,BtnModifierT,BtnImprimerT],False);
                   End;

          dsInsert : Begin
//                      EnableWinControl([BtnAnnulerT,BtnEnregistrerT,BtnFermerT],True);
//                      EnableWinControl([BtnInsererT,BtnModifierT,BtnSupprimerT,BtnImprimerT],False);
//                        BtnEnregistrer.Enabled := True;
//                        BtnAnnuler.Enabled := True;

                   End;
     End; // Fin du Case

end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click sur le bouton Enregistrer.                                //
//****************************************************************************//
procedure TBalanceTiers.BtnEnregistrerClick(Sender: TObject);
begin
//     If BtnEnregistrer.Enabled Then
//     Begin
//          TaTiers.Post;
//          DBGrid1.SetFocus;
//     End;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click sur le bouton Annuler.                                    //
//****************************************************************************//
procedure TBalanceTiers.BtnAnnulerClick(Sender: TObject);
begin
DMEcritures.TaEcritureT.Cancel;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click sur le bouton Fermer.                                     //
//****************************************************************************//
procedure TBalanceTiers.BtnFermerClick(Sender: TObject);
begin
     Self.Close;
end;
//****************************************************************************//


Procedure TBalanceTiers.InitialiseTable_A_Nil;
Begin
     if DMTiers<>nil then
     InitDatasetEvent_A_Nil_Sur_Form([DMTiers.TaTiersBal]);
End;

//****************************************************************************//
// Gestion du Destroy de la fen�tre.                                          //
//****************************************************************************//
procedure TBalanceTiers.FormDestroy(Sender: TObject);
Var
	Registre :TRegistry;
Begin
      InitialiseTable_A_Nil;
      Registre:= TRegistry.Create;

      try
         with Registre do begin
            RootKey := HKEY_LOCAL_MACHINE;
            OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, True);
            WriteInteger('SBBT',ListeCompte.Tag);
            CloseKey;
         end;
      finally
         Registre.Free;
      end;

     LibGestionParamXML.DestroyForm(Self,E.USer);
     BalanceTiers:=nil;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du Exit de la Liste des Comptes.                                   //
//****************************************************************************//
procedure TBalanceTiers.ListeCompteExit(Sender: TObject);
begin
     ListeCompte.Visible := False;
end;
//****************************************************************************//


//****************************************************************************//
// Permet de s�lectionner dans la grille le code Tiers saisie par             //
// l'utilisateur.                                                             //
//****************************************************************************//
procedure TBalanceTiers.EdCodeChange(Sender: TObject);
begin
//     TaTiers.FindNearest(['+'+EdCode.Text]);
//     // Lib�ration du dernier marqueur s'il le faut
//     if (Mark <> nil) and (EdCode.Text <> '') then
//        TaTiers.Freebookmark(Mark);
//     if EdCode.Text <> '' then
//        Mark := TaTiers.GetBookmark;
//     if (EdCode.Text = '') and (Mark <> Nil) then
//        TaTiers.GotoBookmark(Mark);

end;
//****************************************************************************//
procedure TBalanceTiers.BtnInsererTClick(Sender: TObject);
var
Coordonnees:TPoint;
KeyP:string;
begin
 if (Tiers = nil) then
       Tiers:=TTiers.Create(self);
  Tiers.Close;
  Tiers.tag:=0;

{ case ListeCompte.Tag of
    0:Begin
       Tiers.TextListBox1.ItemIndex:=0;
       keyP:=copy(Tiers.TextListBox1.Items[Tiers.TextListBox1.ItemIndex],1,1);
       Tiers.ComboEdit1KeyPress(Tiers.ComboEdit1,keyP[1]);
       Tiers.ComboEdit1.Enabled:=false;
       case ListeCompte.ItemIndex of
        -1:Tiers.ComboEdit2.Text:='';
         0:Tiers.ComboEdit2.Text:='';
         else Tiers.ComboEdit2.Text:=ListeCompte.Items[ListeCompte.ItemIndex];
       end;


//       Tiers.
//       Tiers.ComboEdit1.Text:=
      End;

    1:Begin
       Tiers.TextListBox1.ItemIndex:=1;
       keyP:=copy(Tiers.TextListBox1.Items[Tiers.TextListBox1.ItemIndex],1,1);
       Tiers.ComboEdit1KeyPress(Tiers.ComboEdit1,keyP[1]);
       Tiers.ComboEdit1.Enabled:=false;
       case ListeCompte.ItemIndex of
        -1:Tiers.ComboEdit2.Text:='';
         0:Tiers.ComboEdit2.Text:='';
         else Tiers.ComboEdit2.Text:=ListeCompte.Items[ListeCompte.ItemIndex];
       end;
      End;

    2:Begin
       Tiers.TextListBox1.ItemIndex:=2;
       keyP:=copy(Tiers.TextListBox1.Items[Tiers.TextListBox1.ItemIndex],1,1);
       Tiers.ComboEdit1KeyPress(Tiers.ComboEdit1,keyP[1]);
       Tiers.ComboEdit1.Enabled:=false;
       case ListeCompte.ItemIndex of
        -1:Tiers.ComboEdit2.Text:='';
         0:Tiers.ComboEdit2.Text:='';
         else Tiers.ComboEdit2.Text:=ListeCompte.Items[ListeCompte.ItemIndex];
       end;
      End;

    3:Begin
       Tiers.TextListBox1.ItemIndex:=3;
       keyP:=copy(Tiers.TextListBox1.Items[Tiers.TextListBox1.ItemIndex],1,1);
       Tiers.ComboEdit1KeyPress(Tiers.ComboEdit1,keyP[1]);
       Tiers.ComboEdit1.Enabled:=false;
       case ListeCompte.ItemIndex of
        -1:Tiers.ComboEdit2.Text:='';
         0:Tiers.ComboEdit2.Text:='';
         else Tiers.ComboEdit2.Text:=ListeCompte.Items[ListeCompte.ItemIndex];
       end;
      End;

    4:Begin
       Tiers.TextListBox1.ItemIndex:=4;
       keyP:=copy(Tiers.TextListBox1.Items[Tiers.TextListBox1.ItemIndex],1,1);
       Tiers.ComboEdit1KeyPress(Tiers.ComboEdit1,keyP[1]);
       Tiers.ComboEdit1.Enabled:=false;
       case ListeCompte.ItemIndex of
        -1:Tiers.ComboEdit2.Text:='';
         0:Tiers.ComboEdit2.Text:='';
         else Tiers.ComboEdit2.Text:=ListeCompte.Items[ListeCompte.ItemIndex];
       end;
      End;

    5:Begin
       Tiers.TextListBox1.ItemIndex:=5;
       keyP:=copy(Tiers.TextListBox1.Items[Tiers.TextListBox1.ItemIndex],1,1);
       Tiers.ComboEdit1KeyPress(Tiers.ComboEdit1,keyP[1]);
       Tiers.ComboEdit1.Enabled:=false;
       case ListeCompte.ItemIndex of
        -1:Tiers.ComboEdit2.Text:='';
         0:Tiers.ComboEdit2.Text:='';
         else Tiers.ComboEdit2.Text:=ListeCompte.Items[ListeCompte.ItemIndex];
       end;
      End;

    6:Begin
       Tiers.TextListBox1.ItemIndex:=0;
       Tiers.ComboEdit1.Text:='';
       Tiers.ComboEdit1.Enabled:=true;
      End;

 end;}

 Coordonnees.y:=DBGridTiers.TopRow+0;
 Coordonnees.x:=DBGridTiers.Left;
 Coordonnees:=Clienttoscreen(Coordonnees);
 Tiers.top:=Coordonnees.x;

 if Tiers.showModal = mrOk then
    Begin
     DMTiers.TaTiersBal.GotoCurrent(DMTiers.TaTiersGest);
    End;

end;

procedure TBalanceTiers.BtnModifierTClick(Sender: TObject);
begin
GridBalanceT.SetFocus;
end;

procedure TBalanceTiers.PatitreResize(Sender: TObject);
begin
//RxSpeedButton1.top:=13;
RxSpeedButton1.Left:=Patitre.Width-104;
//RxSpeedButton1.Height:=Patitre.Height-24;
end;

procedure TBalanceTiers.PaGrilleResize(Sender: TObject);
begin
//DMTiers.TaTiersBal.DisableControls;
FormateTailleColonne(DBGridTiers,28,[3,5,3,4,4,4]);


//GridBalanceT.ColWidths[1]:=(GridBalanceT.Width) div 14;
//GridBalanceT.ColWidths[2]:=(GridBalanceT.Width) div 3;
//GridBalanceT.ColWidths[3]:=(GridBalanceT.Width) div 11;
//GridBalanceT.ColWidths[4]:=(GridBalanceT.Width) div 11;
//GridBalanceT.ColWidths[5]:=(GridBalanceT.Width) div 10;
//GridBalanceT.ColWidths[6]:=(GridBalanceT.Width) div 24;
//GridBalanceT.ColWidths[7]:=(GridBalanceT.Width) div 24;
//GridBalanceT.ColWidths[8]:=(GridBalanceT.Width) div 13;
//GridBalanceT.ColWidths[9]:=(GridBalanceT.Width) div 10;
WinShape(screen.ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
//DMTiers.TaTiersBal.EnableControls;
end;

procedure TBalanceTiers.Insrer1Click(Sender: TObject);
begin
if BtnInserer.Enabled then
   BtnInsererClick(BtnInserer)
   else
   BtnInsererTClick(BtnInsererT);
end;

procedure TBalanceTiers.BtnInsererClick(Sender: TObject);
begin
DMEcritures.TaEcritureT.Insert;
end;

procedure TBalanceTiers.DBGridTiersEnter(Sender: TObject);
begin
//EnableWinControl([BtnAnnulerT,BtnInsererT,BtnModifierT,BtnSupprimerT,BtnFermerT,BtnImprimerT],True);
//BtnEnregistrerT.Enabled := False;
//EnableWinControl([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnFermer,BtnImprimer],False);
end;

procedure TBalanceTiers.GridBalanceTEnter(Sender: TObject);
begin
//EnableWinControl([BtnAnnulerT,BtnEnregistrerT,BtnInsererT,BtnModifierT,BtnSupprimerT,BtnFermerT,BtnImprimerT],False);
//EnableWinControl([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnFermer,BtnImprimer],True);
end;

procedure TBalanceTiers.GridBalanceTExit(Sender: TObject);
begin
//DBGridTiers.Enabled:=true;
end;

procedure TBalanceTiers.Modifier1Click(Sender: TObject);
begin
if BtnModifierT.Enabled then
   BtnModifierTClick(BtnModifierT)
   else
   BtnModifierClick(BtnModifier);
end;

procedure TBalanceTiers.BtnModifierClick(Sender: TObject);
begin
DMEcritures.TaEcritureT.Edit;
end;

procedure TBalanceTiers.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     If Key = VK_ESCAPE Then
     Begin

       If ((DMTiers.TaTiersBal.State = dsBrowse) and (DMEcritures.TaEcritureT.State = dsBrowse)) Then
          begin
            if DBGridTiers.Focused then Self.Close else DBGridTiers.SetFocus;
          end;

     end;
     If Key = VK_ESCAPE Then
     Begin
          Key := 0;
          If Not(DMTiers.TaTiersBal.State In [dsEdit]) Then
          Begin
               Self.Close;
          End
          Else
          Begin
               DMTiers.TaTiersBal.Cancel;
          End;
     End;
end;

procedure TBalanceTiers.ModifierTiers1Click(Sender: TObject);
begin
ShowMEssage('Modification du tiers : '+ DMTiers.TaTiersBalTiers.AsString +' prochainement !');
end;

procedure TBalanceTiers.BtnSupprimerClick(Sender: TObject);
begin
ShowMEssage('Traitement balance non trait�');
TableGereDelete(DMEcritures.TaEcritureT);
end;

procedure TBalanceTiers.GridBalanceTColExit(Sender: TObject);
var
controleSaisie:TErreurSaisie;
begin
      if GridBalanceT.DataSource.State in [dsinsert,dsEdit] then
      begin// si table en insertion ou modif
      controleSaisie:=DMEcritures.CtrlSaisieEcritureBOTiers(GridBalanceT.SelectedField);
       if controleSaisie.Retour=false then
           case controleSaisie.CodeErreur of
           1000:begin
                  GridBalanceT.SelectedIndex:=0;
                  abort;//
                end;
           5100:begin
                  GridBalanceT.SelectedIndex:=4;
                  abort;//
                end;
           7000:GridBalanceT.SelectedIndex:=2;
           7100:GridBalanceT.SelectedIndex:=4;
           7200:GridBalanceT.SelectedIndex:=2;
           7300:GridBalanceT.SelectedIndex:=3;
           10100:GridBalanceT.SelectedIndex:=4;
           16100:begin
                  GridBalanceT.Columns[6].ReadOnly:=true;
                  GridBalanceT.Columns[7].ReadOnly:=true;
                  GridBalanceT.SelectedIndex:=7;
                end;
           end;//fin du case
//      if GridBalanceT.SelectedIndex=1 then
//      BtnEnregistrer.Enabled:=true;
      end;//fin si table en insertion ou modif
end;



procedure TBalanceTiers.Aide1Click(Sender: TObject);
var
Key:word;
resultat:TAideMontantTTC2RetFunction;
Enregistrement:TEnregistrementComplet;
RetourTva:TRecupMiniMaxTva;
MontantHT:Currency;
ChampHT:Integer;
begin
 If activecontrol = DBGridTiers Then
  begin
   case DBGridTiers.DataSource.State of
//      dsinsert,dsedit:case DBGridTiers.SelectedIndex of
//                         1:begin
//                            DBGridTiers.EditorMode:=true;
//                            AideCompte.InitialiseCompte;
//                            AideCompteAffiche(DBGridTiers.InplaceEditor);
//                            DBGridTiers.Columns[1].Field.AsString:=DBGridTiers.InplaceEditor.Text;
//                           end;
//                         2: ;
//                      end;
      dsbrowse:case DBGridTiers.SelectedIndex of
                  0:Rechercher(DBGridTiers,DMTiers.TaTiersBal,['Tiers','Nom','Compte'],['Tiers','Nom','Compte'],'',0);
                  1:Rechercher(DBGridTiers,DMTiers.TaTiersBal,['Nom','Tiers','Compte'],['Nom','Tiers','Compte'],'',0);
               end;
   end;
 end;

 If activecontrol = GridBalanceT Then
  begin
   case GridBalanceT.DataSource.State of
      dsinsert,dsedit:case GridBalanceT.SelectedIndex of
                         0:begin
                            GridBalanceT.EditorMode:=true;
                            AideCompte.InitialiseCompte;
                            AideCompteDansContexte(GridBalanceT.InplaceEditor.Text,GridBalanceT.InplaceEditor,['Rac1'],true,MessDerSub,False,true,false,true,0);
//                            AideCompteAffiche(GridBalanceT.InplaceEditor);
                            GridBalanceT.Columns[0].Field.AsString:=GridBalanceT.InplaceEditor.Text;
                           end;
                         4:begin
                            GridBalanceT.EditorMode:=true;
                            Enregistrement:=DmPlanRecupEnregistrementComplet(GridBalanceT.Columns[0].Field.AsString);
                            if ((Enregistrement.CodeRetour) and  (not empty(Enregistrement.TvaCode))) then
                               begin
                                RetourTva:=FTvaRecupMiniMaxTva(Enregistrement.TvaCode);
                                if Enregistrement.SensCredit=C_True then ChampHT:=3 else ChampHT:=2;
                                if not VerifFNumeric(GridBalanceT.Columns[2].Field).VideOUZero
                                   then ChampHT:=2 else GridBalanceT.Columns[2].Field.AsCurrency:=0;
//                                MontantHT:=GridBalanceT.Columns[2].Field.AsCurrency;
                                if not VerifFNumeric(GridBalanceT.Columns[3].Field).VideOUZero
                                   then ChampHT:=3 else GridBalanceT.Columns[3].Field.AsCurrency:=0;
//                                MontantHT:=GridBalanceT.Columns[3].Field.AsCurrency;
                                if empty(GridBalanceT.InplaceEditor.Text) then GridBalanceT.InplaceEditor.Text:='0'; 
//                                case retourtva.CodeRetour of
//                                  1:resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,GridBalanceT.Columns[ChampHT].Field,GridBalanceT.InplaceEditor]);
//                                  2:resultat:=AideMontantAffiche([0,retourtva.Taux_Supp,GridBalanceT.Columns[ChampHT].Field,GridBalanceT.InplaceEditor]);
//                                 12:resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,GridBalanceT.Columns[ChampHT].Field,GridBalanceT.InplaceEditor,retourtva.Taux_Supp,0,GridBalanceT.Columns[ChampHT].Field,GridBalanceT.InplaceEditor]);
//                                end;
                                if resultat.Retour then
                                   Begin
                                    GridBalanceT.Columns[ChampHT].Field.AsCurrency:=arrondicentieme(resultat.HT);
                                    GridBalanceT.Columns[4].Field.AsCurrency:=arrondicentieme(resultat.TVA);
                                   End;
                               end;
                           end;
                         7:begin
                            GridBalanceT.EditorMode:=true;
                            Key:=VK_F1;
                            GridBalanceT.InplaceEditor.Perform(WM_KEYDOWN,key,0);
                           end;
                      end;
      dsbrowse:case GridBalanceT.SelectedIndex of
                  0:Rechercher(GridBalanceT,DMEcritures.TaEcritureT,['Compte','Libelle','TvaDate','ID_Piece'],['Compte','Libell�','Date de Livraison','Piece'],'',0);
                  1:Rechercher(GridBalanceT,DMEcritures.TaEcritureT,['Libelle','Compte','TvaDate','ID_Piece'],['Libell�','Compte','Date de Livraison','Piece'],'',0);
                  2:Rechercher(GridBalanceT,DMEcritures.TaEcritureT,['TvaDate','Compte','Libelle','ID_Piece'],['Date de Livraison','Compte','Libell�','Piece'],'',0);
               end;
   end;
 end;

end;

procedure TBalanceTiers.TaTiersBalAfterScroll(DataSet: TDataSet);
begin
if DMEcritures.TaEcritureT.recordCount > 0 then
   Begin
    DBGridTiers.Columns[3].ReadOnly:=true;
    DBGridTiers.Columns[4].ReadOnly:=true;
   End
   else
   Begin
    DBGridTiers.Columns[3].ReadOnly:=False;
    DBGridTiers.Columns[4].ReadOnly:=False;
   End;
DMEcritures.TaEcritureT.AfterPost(DMEcritures.TaEcritureT);
DMEcritures.TaEcritureT.FlushBuffers;
end;

procedure TBalanceTiers.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
Patitre.visible:=Main.AfficheTitre;
//DMPlan.TaCompte.OnFilterRecord:=nil;
//   showmessage('12');
DMEcritures.FiltragesAideCompteBOT;

ListeCompte.Color:=ParamUtil.CouleurDBGrid.GrilleColorFond;

DBGridTiers.ParamColor:=true;
DBGridTiers.Param:=ParamUtil.CouleurDBGrid;
DBGridTiers.UpDateColor;

GridBalanceT.ParamColor:=true;
GridBalanceT.Param:=ParamUtil.CouleurDBGrid;
GridBalanceT.UpDateColor;
if not (DMTiers.TaTiersBal.State in [dsinsert,dsedit]) then
   Begin
     DMTiers.TaTiersBal.Refresh;
   End;
//   showmessage('13');

end;

procedure TBalanceTiers.GridBalanceTKeyPress(Sender: TObject;
  var Key: Char);
begin
if ((GridBalanceT.SelectedIndex=6)) then // and (GridBalanceT.DataSource.State in [dsInsert,dsEdit])
  begin
   if key=#100 then key:=#68;
   if key=#101 then key:=#69;
  end;
end;

procedure TBalanceTiers.Supprimer1Click(Sender: TObject);
begin
if BtnSupprimer.Enabled then
   BtnSupprimerClick(BtnSupprimer)
   else
   BtnSupprimerTClick(BtnSupprimerT);
end;

procedure TBalanceTiers.BtnSupprimerTClick(Sender: TObject);
begin
Showmessage('Pour supprimer un tiers, vous devez aller dans la gestion des Tiers.');
end;

procedure TBalanceTiers.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
//WinShape(screen.ActiveControl,Main.Shape1,Main.shape2,Main.ContourCouleur);
end;

procedure TBalanceTiers.BtnAnnulerTEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TBalanceTiers.BtnAnnulerTExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TBalanceTiers.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TBalanceTiers.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TBalanceTiers.Visualisation1Click(Sender: TObject);
begin
if ActiveControl = DBGridTiers then
begin
 if DBGridTiers.SelectedIndex = 0 then
  begin
   if DBGridTiers.InplaceEditor <> nil then
    begin
       if DBGridTiers.InplaceEditor.Visible then
         DetailEcritureTiers(DBGridTiers.InplaceEditor.Text,true)
          else
          DetailEcritureTiers(DMTiers.TaTiersBal.FindField('Tiers').AsString,true);
    end
    else
     DetailEcritureTiers(DMTiers.TaTiersBal.FindField('Tiers').AsString,true);
  end;
//  else DetailEcritureTiers(DMTiers.TaTiersBal.FindField('Tiers').AsString,true);

  if DBGridTiers.SelectedIndex = 2 then
   begin
    if DBGridTiers.InplaceEditor <> nil then
     begin
        if DBGridTiers.InplaceEditor.Visible then
          DetailEcritureCompte(DBGridTiers.InplaceEditor.Text,true,False)
           else
           DetailEcritureCompte(DMTiers.TaTiersBal.FindField('Compte').AsString,true,False);
     end
     else
      DetailEcritureCompte(DMTiers.TaTiersBal.FindField('Compte').AsString,true,False);
   end;
//   else DetailEcritureTiers(DMTiers.TaTiersBal.FindField('Compte').AsString,true);

end
else
begin
if GridBalanceT.SelectedIndex = 0 then
 begin
  if GridBalanceT.InplaceEditor <> nil then
   begin
      if GridBalanceT.InplaceEditor.Visible then
        DetailEcritureCompte(GridBalanceT.InplaceEditor.Text,true,False)
         else
         DetailEcritureCompte(DMEcritures.TaEcritureT.FindField('Compte').AsString,true,False);
   end
   else DetailEcritureCompte(DMEcritures.TaEcritureT.FindField('Compte').AsString,true,False);
 end
 else DetailEcritureCompte(DMEcritures.TaEcritureT.FindField('Compte').AsString,true,False);
end;
end;

procedure TBalanceTiers.RxSpeedButton2Click(Sender: TObject);
begin
Main.SaisieAnneeAnterieurClick(Main.SaisieAnneeAnterieur);
end;

procedure TBalanceTiers.RxSpeedButton1Click(Sender: TObject);
begin
Main.Chargesrpartir1Click(Main.Chargesrpartir1);
end;

procedure TBalanceTiers.RxSBInfoVersionClick(Sender: TObject);
begin
Showmessage(BalanceTiersRxSBInfoVersionWarning+numVersion.messageVersion);
end;

procedure TBalanceTiers.PaBtnHautResize(Sender: TObject);
var
ListeVisible:boolean;
begin
ListeVisible:=ListeCompte.Visible;
ListeCompte.Visible:=false;

FormateTailleBoutton([SBClients,SBFournisseurs,SBClientsFournisseurs,SBOrgSociaux,SBPersonnel,SBAssocies,SBTous],PaBtnHaut,PaBtnHaut.width div 7,0);

// Gestion de la liste de choix si visible ListeCompte.Tag
//if ListeVisible then
//   case ListeCompte.Tag of
//      0:SBClientsClick(SBClients);
//      1:SBClientsClick(SBFournisseurs);
//      2:SBClientsClick(SBClientsFournisseurs);
//      3:SBClientsClick(SBPersonnel);
//      4:SBClientsClick(SBOrgSociaux);
//      5:SBClientsClick(SBAssocies);
//      6:SBClientsClick(SBTous);
//   end;

ListeCompte.Visible:=ListeVisible;
end;

procedure TBalanceTiers.Panel2Resize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnulerT,BtnEnregistrerT,BtnInsererT,BtnModifierT,BtnSupprimerT,BtnFermerT,BtnImprimerT],Panel2,90,0);
end;

procedure TBalanceTiers.BtnImprimerTClick(Sender: TObject);
begin
DBGridTiers.ReportCaption:='Balance des Tiers � l''ouverture';
DBGridTiers.GridPreview;
end;

procedure TBalanceTiers.PaTotauxHResize(Sender: TObject);
begin
EdTotalDebit.Left:=DBGridTiers.ColWidths[1]+DBGridTiers.ColWidths[2]+DBGridTiers.ColWidths[3]+13;
EdTotalDebit.Width:=DBGridTiers.ColWidths[4]+1;

EdTotalCredit.Left:=DBGridTiers.ColWidths[1]+DBGridTiers.ColWidths[2]+DBGridTiers.ColWidths[3]+DBGridTiers.ColWidths[4]+16;
EdTotalCredit.Width:=DBGridTiers.ColWidths[5]+1;

EdSoldeDebut.Left:=DBGridTiers.ColWidths[1]+DBGridTiers.ColWidths[2]+DBGridTiers.ColWidths[3]+DBGridTiers.ColWidths[4]+DBGridTiers.ColWidths[5]+16;
EdSoldeDebut.Width:=DBGridTiers.ColWidths[6]+1;
end;

procedure TBalanceTiers.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
canclose:=true;
if CanClose then InitialiseTable_A_Nil { isa  le  29/01/04 }
 else
 begin
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(self);

 end;
end;

end.