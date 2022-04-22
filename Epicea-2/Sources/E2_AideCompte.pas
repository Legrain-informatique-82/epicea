{***************************************************************
 *
 * Unit Name: E2_AideCompte
 * Purpose  :
 * Author   :  JS
 * History  :
 *
 ****************************************************************}

// Gestion de l'aide à la recherche de compte suivant
// le plan comptable, plan auxiliaire et libellé regroupant
// les comptes compta géné, plan aux et répertoire
// Tout est commenté
unit E2_AideCompte;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, ExtCtrls, Gr_Librairie_obj, Db, DBTables, Grids,
  DBGrids, E2_AideModel, Menus, GestPlan,GrGrid,LibZoneSaisie, RXDBCtrl,
  Lib_Chaine,
  Editions,
  ExRxDBGrid, GrDBGrid, RXCtrls,E2_Decl_Records,E2_LibInfosTable,LIBSQL,DMConstantes,E2_Recherche,
  jpeg;

type
 TTypePlan = (tpNone, tpComptable, tpTiers, tpLibelle);
 TCompteValide = (tcvEntete, tcvCorp, tcvReglement);

  TAideCompte = class(TForm)
    paBtn: TPanel;
    pcCompte: TPageControl;
    tsCompte: TTabSheet;
    tsTiers: TTabSheet;
    tsLibelle: TTabSheet;
    dsTiers: TDataSource;
    dsLibelle: TDataSource;
    quLibelle: TQuery;
    pa: TPanel;
    Label1: TLabel;
    edMot: TEdit;
    quLibelleCompte: TStringField;
    laRecherche: TLabel;
    PopMenuCompte: TPopupMenu;
    pmNouveauT: TMenuItem;
    NouveauxCompte1: TMenuItem;
    Pop1: TMenuItem;
    N1: TMenuItem;
    TaTiers: TTable;
    TaTiersTiers: TStringField;
    TaTiersCompte: TStringField;
    TaTiersType: TStringField;
    TaTiersSensCredit: TBooleanField;
    TaTiersRapprochement: TBooleanField;
    TaTiersTvaDebit: TBooleanField;
    TaTiersAbandonne: TBooleanField;
    TaTiersDebit_Deb: TFloatField;
    TaTiersCredit_Deb: TFloatField;
    TaTiersPoste: TStringField;
    TaTiersVille: TStringField;
    TaTiersPays: TStringField;
    TaTiersLivr_Poste: TStringField;
    TaTiersLivr_Ville: TStringField;
    TaTiersLivr_Pays: TStringField;
    TaTiersTelephone1: TStringField;
    TaTiersTelephone2: TStringField;
    TaTiersTelecopie: TStringField;
    TaTiersMel: TStringField;
    TaTiersQui: TStringField;
    TaTiersQuand: TDateTimeField;
    TaTiersActif: TBooleanField;
    Visualisation1: TMenuItem;
    TaTiersNom: TStringField;
    quLibelleLib2: TStringField;
    TaTiersAdresse1: TStringField;
    TaTiersAdresse2: TStringField;
    TaTiersLivr_Adr1: TStringField;
    TaTiersLivr_Adr2: TStringField;
    PaGrille: TPanel;
    tvCompte: TTreeView;
    PaGrilleT: TPanel;
    grTiers: TGrDBGrid;
    Panel1: TPanel;
    quLibelleLibelle: TStringField;
    Pabas: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    Label2: TLabel;
    LaCodeTva: TLabel;
    Label3: TLabel;
    LaTypeTva: TLabel;
    LaEcritures: TLabel;
    btOk: TButton;
    btAnnuler: TButton;
    Valider1: TMenuItem;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    TabSheet1: TTabSheet;
    tsCptUtil: TTabSheet;
    PaGrilleLCpt: TPanel;
    GrDBListeCompte: TGrDBGrid;
    GrDBTsCompte: TGrDBGrid;
    grLibelle: TGrDBGrid;
    Aide1: TMenuItem;
    LaCodeTVADef: TLabel;
    Timer1: TTimer;
    ChBPlanDeSaisie: TCheckBox;
    BtnImprimer: TButton;
    Imprimer1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tvCompteExpanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure tvKeyPress(Sender: TObject; var Key: Char);
    procedure grTiersCellClick(Column: TColumn);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edMotKeyPress(Sender: TObject; var Key: Char);
    procedure tsLibelleEnter(Sender: TObject);
    procedure pcCompteChanging(Sender: TObject; var AllowChange: Boolean);
    procedure pmNouveauTClick(Sender: TObject);
    procedure InitialiseCompte;
    procedure FormShow(Sender: TObject);
    procedure DefiltrageAideCompte;
    procedure NouveauxCompte1Click(Sender: TObject);
    procedure Pop1Click(Sender: TObject);
    procedure pcCompteChange(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure PaGrilleTResize(Sender: TObject);
    procedure TaTiersBeforeInsert(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tvCompteChange(Sender: TObject; Node: TTreeNode);
    procedure paBtnResize(Sender: TObject);
    procedure edMotEnter(Sender: TObject);
    procedure edMotExit(Sender: TObject);
    procedure FiltrageAideCompte(Famille:integer);
    procedure FiltrageAideCompteSurCompte(Famille:integer;Cpt:string);
    procedure GrDBListeCompteDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure TaCompteAfterScroll(DataSet: TDataSet);
    Procedure TaCompteBeforeScroll(DataSet: TDataSet);
    procedure GrDBTsCompteKeyPress(Sender: TObject; var Key: Char);
    procedure edMotChange(Sender: TObject);
    procedure edMotKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btAnnulerEnter(Sender: TObject);
    procedure btAnnulerExit(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    Procedure initialiseTableEvent;
    procedure Timer1Timer(Sender: TObject);
    procedure ChBPlanDeSaisieClick(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure Imprimer1Click(Sender: TObject);

  private
    { Déclarations privées }
    FChaineRecherche :String;
    FTypePlan :TTypePlan;

  Procedure ActualiseLibelle(Limite :String);
  procedure AjouteSubdivision(Node :TTreeNode);
  Function RechercheSubdivision(Node :TTreeNode; Index :Char) :TTreeNode;
  Function GetCompte :String;
  Procedure SetChaineRecherche(Value :String);
  Property ChaineRecherche :String Read FChaineRecherche Write SetChaineRecherche;
  public
    { Déclarations publiques }
    Page1,Page2,Page3,Page4:boolean;
    IndexPage:Integer;
    ControleTmp:TComponent;
    ListeCompteUtiliseEcranAppelant:TStringList;
    procedure Recherche(Compte :String);
    Property DernierCompte :String Read GetCompte;
    Property TypePlan :TTypePlan Read FTypePlan;

  end;

Const C_NO_CONTROL = 100;     //BR
Var
 AideCompte: TAideCompte;
{Aide Compte}
   Procedure AideCompteFiltreTaCompte(Filtre:string;Filtered:Boolean);
   Function AideCompteDansContexte(Compte:String;Control:TComponent;Const Racx:array of string;ForceAffiche:boolean;var MessDSub:boolean;MessNumCpt,Cpt,Tiers,Lib:boolean;Index:Integer):Boolean;
   Function AideCompteLibelle(Compte :String) :String;
   Function AideCompteAffiche(Control :Tcomponent;Cpt,Tiers,Lib,CptList:boolean;Index:Integer) :Boolean;
   Function AideCompteExiste(Compte :String; Control :Tcomponent) :Boolean;
   Function AideCompteTypePlan(Compte :String) :TTypePlan;
   Function AideCompteField(Champ :String) :TField;
   Function AideCompteValeurTiers(Var Compte, Tiers :String) :Boolean;
   Function AideCompteComptePointable(Compte :String) :Boolean;
   Function AideCompteValide(Compte :String; Control :Tcomponent;
    Classe :TCompteValide; IDJournal :LongInt; CompteCPartie :String) :Boolean;
   Function AideCompteDansContexte_LaisserPasser(Compte:String;Control:TComponent;Const Racx:array of string;ForceAffiche,Affich:boolean;var MessDSub,Laisser_Passer:boolean;MessNumCpt,Cpt,Tiers,Lib:boolean;Index:Integer):Boolean;
implementation

{$R *.DFM}
Uses E2_Librairie_obj, DMPlanCpt,DMEcriture, E2_Main,
  DMRecherche, E2_Tiers, DMTier,DMTva;

Procedure AideCompteFiltreTaCompte(Filtre:string;Filtered:Boolean);
Begin
   if(AideCompte = Nil) then
    AideCompte:= TAideCompte.Create(Application.MainForm);
if not DMPlan.TaCompte.Active then DMPlan.TaCompte.open;
DMPlan.TaCompte.Filtered:=false;
DMPlan.TaCompte.Filter:=Filtre;
DMPlan.TaCompte.Filtered:=Filtered;
//AideCompte.InitialiseCompte;
End;



Function AideCompteDansContexte(Compte:String;Control:TComponent;Const Racx:array of string;ForceAffiche:boolean;var MessDSub:boolean;MessNumCpt,Cpt,Tiers,Lib:boolean;Index:Integer):Boolean;
var
FirstCar:string;
CptTiers:Boolean;
InfosTiersSaisie:TInfosTiersSaisie;
EtatFiltreAideCompte,EtatFiltreParamCpt:TEtatFiltre;
Begin
try
result:=false;
if(AideCompte = Nil) then
 AideCompte:= TAideCompte.Create(Application.MainForm);
 AideCompte.ControleTmp:=control;
// AideCompte.Page1:=Cpt;
// AideCompte.Page2:=Tiers;
// AideCompte.Page3:=Lib;
// AideCompte.Pa+ge4:=true;
// AideCompte.IndexPage:=Index;
// AideCompte.pcCompteChange(AideCompte.pcCompte);
CptTiers:=false;
if not empty(Compte) then CptTiers:=copy(compte,1,1)='+';
if Not CptTiers then // Pas Tiers
 Begin
 If Empty(Compte) then
 Begin
  if MessNumCpt then application.Messagebox(Pchar('Le Numéro de Compte est Obligatoire !'),'Erreur de saisie',0);
   result:=AideCompteAffiche(Control,Cpt,Tiers,Lib,True,Index);
 End
 else
  if DMPlan.CompteValideDansParamContexte(Compte,not ForceAffiche,Racx,nil) then  // Si le compte est valide dans contexte
   Begin
   if DMPlan.CompteExistePCU(compte) then //alors s'il existe
          begin
              if DMPlan.PossedeFils(Compte) then
                 Begin
                   if MessDSub=true then
                    begin
                      if Application.MessageBox(Pchar('Le compte '+Compte+' n''est pas la dernière subdivision !'+#10#13 + 'Confirmez-vous votre choix ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
//                      if (MessageDlg('Le compte '+Compte+' n''est pas la dernière subdivision !'+#10#13 + 'Confirmez-vous votre choix ?', mtConfirmation, mbYesNo, 0) = mrYes) then
//                      if Question('AideCompte', 'Subdivision') then
                      begin
                       MessDSub:=false;
                       case RecupClassTypeComponent(control)of
                          GTEdit:TCustomEdit(Control).Text:=Compte;
                          GTStringGrid: with TStringGrid(Control) do Cells[Col, Row]:=Compte;
                          GTGrid: with TStringGrid(Control) do Cells[Col, Row]:=Compte;
                          Gtgrgrid:with TGrgrid(Control) do Cells[col, Row]:=Compte;
                          GTDBGrid:begin
                                    if TCustomdbgrid(control).SelectedField.DataSet.State in [dsedit,dsinsert] then
                                    TCustomdbgrid(control).selectedfield.asstring:=Compte;
                                   end;
                          GTFieldString:begin
                                        if TField(control).DataSet.State in [dsedit,dsinsert] then
                                        TField(control).asstring:=Compte;
                                        end;
                          GTInplaceEdit,GTGrInplaceEdit:TCustomEdit(Control).Text:=Compte;
                          GTRxDBComboEdit:TRxDBComboEdit(Control).Text:=Compte;
                       end;//fin du case
                      result:=true;
                      end
                      else
                      begin
                           result:=AideCompteAffiche(Control,Cpt,Tiers,Lib,True,Index);
                      end;
                    end
                    else
                    begin
                     if ForceAffiche then
                        result:=AideCompteAffiche(Control,Cpt,Tiers,Lib,True,Index) else
                      result:=true;//On ne repose pas la question sur l'utilisation
                                   //de la dernière subdivision
                    end;
                 End
                 else
                 Begin
                 if ForceAffiche then
                  result:=AideCompteAffiche(Control,Cpt,Tiers,Lib,True,Index) else
                 result:=true;//le Compte ne possede pas de Fils
                 End;

          end
          else // sinon, s'il n'existe pas, demande de création
          begin
           if DMPlan.DemandeCreation(Compte,Control,true).retour then
             result:=AideCompteDansContexte(Compte,Control,Racx,true,MessDSub,MessNumCpt,Cpt,Tiers,Lib,Index)
           else
             result:=AideCompteExiste(Compte,Control)
//           result:=true; A verifier si ca marche lors de la creation d'un cpt hors contexte
          end;
   End
   else
   Begin
     result:=AideCompteAffiche(Control,Cpt,Tiers,Lib,True,Index)
   End;
 end
 else // Tiers
 begin
 If Empty(Compte) then
  Begin
   if MessNumCpt then Application.Messagebox(Pchar('Le Numéro de Compte est Obligatoire !'),'Erreur de saisie',0);
     AideCompte.Page2:=true;
     AideCompte.IndexPage:=1;
     AideCompte.pcCompte.ActivePage:=AideCompte.tsTiers;
     AideCompte.pcCompteChange(AideCompte.pcCompte);
    result:=AideCompteAffiche(Control,Cpt,Tiers,Lib,True,Index);
  End
 else
  begin
   DeFiltrageDataSet(DMrech.TaTiersRech);
   // 05/11/2002 : ce bout de code permet de gérer la création d'un tiers en cours saisie
   result := Infos_TInfosTiers(DMrech.TaTiersRech,'Tiers',[Compte]).ResultInfos;
   if ((not result) and (not ForceAffiche)) then  // Si le compte est valide dans contexte
    Begin                                                     // mais n'existe pas
     InfosTiersSaisie.Retour := false;
     AideCompte.Page2:=true;
     AideCompte.IndexPage:=1;
     AideCompte.pcCompte.ActivePage:=AideCompte.tsTiers;
     AideCompte.pcCompteChange(AideCompte.pcCompte);
     if compte <> '+' then
      if MessageDlg('Le compte : '+Compte+' n''existe pas ! '+#10#13#10#13+'Voulez-vous le créer ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
//      if Application.MessageBox(PChar('Le compte : '+Compte+' n''existe pas ! '+#10#13#10#13+'Voulez-vous le créer ?'),'Confirmation',MB_YESNO + MB_DEFBUTTON1) = IDYES then
       begin
        InfosTiersSaisie:=AideTiersAfficheEnSaisie(Compte);
       end;
       result:=InfosTiersSaisie.Retour;
       // annulation de la création du Tiers
       if not InfosTiersSaisie.Retour then
        begin
         result:=AideCompteAffiche(Control,Cpt,Tiers,Lib,True,Index);
        end
        else
       // Validation de la création du Tiers
        begin
          DMrech.TaTiersRech.Refresh;                           
          result:=Infos_TInfosTiers(DMrech.TaTiersRech,'Tiers',[InfosTiersSaisie.CodeTiers]).ResultInfos;
          // Si le nouveau code de Tiers est validé, On vérifie si c'est le même qui
          // a été créé que celui qui à été saisie dans le controle d'appel
          if result then
           begin
            if InfosTiersSaisie.CodeTiers <> Compte then
             begin
              AideCompte.TaTiers.Refresh;
              result:=AideCompteAffiche(Control,Cpt,Tiers,Lib,True,Index);
             end;
           end
        end;
    end
    else
    begin
     if ForceAffiche then
      result:=AideCompteAffiche(Control,Cpt,Tiers,Lib,True,Index) else
    result:=true;
    end;
  end;
 end;
except
  showMessage('AideCompteDansContexte : Erreur d''Affichage des comptes !');
end;
End;

//******************************************************************************
Function AideCompteComptePointable(Compte :String) :Boolean;
// Retourne vrai si le compte est un compte de tiers ou un compte
// de classe 4 pointable
Begin
   if(AideCompte = Nil) then
    AideCompte:= TAideCompte.Create(Application.MainForm);

 if (Compte[1] = '+') Then Result:= True
   Else if (AideCompteTypePlan(Compte) = tpComptable)
    And (AideCompteField('Tiers').asBoolean) then Result:=True
   Else Result:= False;
End;

//******************************************************************************
Function AideCompteValeurTiers(Var Compte, Tiers :String) :Boolean;
// Met à jour compte et tiers suivant le type de plan
Var
 typePlan :TTypePlan;
Begin
   if(AideCompte = Nil) then
    AideCompte:= TAideCompte.Create(Application.MainForm);

 TypePlan:= AideCompteTypePlan(Compte);

   if (TypePlan = tpComptable) then Begin
    Result:= True;
      Compte:= AideCompteField('Compte').AsString;
      Tiers:= '';
   End
   Else if (TypePlan = tpTiers) then Begin
    Result:= True;
      Compte:= AideCompteField('Compte').AsString;
      Tiers:= AideCompteField('Tiers').AsString;
   End
   Else Result:= False;
End;

//******************************************************************************
Function AideCompteLibelle(Compte :String) :String;
// Retourne le libellé du compte suivant le code de Compte
Begin
   if(AideCompte = Nil) then
    AideCompte:= TAideCompte.Create(Application.MainForm);

 if Not Empty(Compte) Then AideCompteTypePlan(Compte);

 with AideCompte do
 case FTypePlan of
     tpComptable: Result:=DMPlan.taCompte.FindField('Libelle').AsString;
     tpTiers: Result:= taTiers.FindField('Nom').AsString;
     tpLibelle: Result:= quLibelle.FindField('Libellé').AsString;
   else Result:= '';
   end;
End;

//******************************************************************************
Function AideCompteField(Champ :String) :TField;
// Retourne le pointeur sur un champ suivant Champ
Begin
   if(AideCompte = Nil) then
    AideCompte:= TAideCompte.Create(Application.MainForm);

 with AideCompte do
 case FTypePlan of
     tpComptable: Result:= DMPlan.taCompte.FindField(Champ);
     tpTiers: Result:= taTiers.FindField(Champ);
     tpLibelle: Result:= quLibelle.FindField(Champ);
   else Result:= Nil;
   end;
End;

//******************************************************************************
Function AideCompteAffiche(Control :Tcomponent;Cpt,Tiers,Lib,CptList:boolean;Index:Integer) :Boolean;
var
WinControlAux:TWincontrol;
Accept:Boolean;
// Affiche l'écran d'aide et màj le contrôle d'appel
Begin
 DMPlan.AideCompteVisible := true;
 DMPlan.TaCompte.Filtered:=false;
 DMPlan.TaCompte.Filtered:=True;

   if(AideCompte = Nil) then
    AideCompte:= TAideCompte.Create(Application.MainForm);
 AideCompte.InitialiseCompte;
 AideCompte.ControleTmp:=control;
 WinControlAux:=screen.ActiveControl;
 AideCompte.Page1:=Cpt;
 AideCompte.Page2:=Tiers;
{**** à remettre dès que arrangé **** isa le 27/11/02}
 AideCompte.tsLibelle.TabVisible:=false;
 AideCompte.tsCptUtil.TabVisible:=false;
// AideCompte.Page3:=Lib;
// AideCompte.Page4:=true;
{********}
 AideCompte.IndexPage:=Index;
 AideCompte.pcCompteChange(AideCompte.pcCompte);

with AideCompte do
   begin
      case RecupClassTypeComponent(control)of
        GTEdit:Recherche(TCustomEdit(Control).Text);
        GTGrGrid:with TGrgrid(Control) do Recherche(Cells[Col, Row]);
        GTStringGrid: with TStringGrid(Control) do Recherche(Cells[Col, Row]);
        GTDBGrid:recherche(TCustomdbgrid(Control).SelectedField.AsString);
        GTFieldString:recherche(TField(control).AsString);
        GTGrid:with TGrgrid(Control) do Recherche(Cells[Col, Row]);
        GTInplaceEdit,GTGrInplaceEdit:Recherche(TCustomEdit(Control).Text);
        GTRxDBComboEdit:Recherche(TRxDBComboEdit(Control).Text);
      end;//fin du case
   TaTiers.Refresh;
   if AideCompte.Visible then
    begin
      AideCompte.Close;
      DMPlan.AideCompteVisible := False;
//      showmessage('3'+str_bool2str(DMPLAn.AideCompteVisible));

    end
   else
    begin

//     showmessage(str_bool2str(DMPLAn.AideCompteVisible));
//     showmessage(str_bool2str(ParamUtil.PlanDeSaisie));
     ChBPlanDeSaisie.Checked:=ParamUtil.PlanDeSaisie;
     Result:= (ShowModal = mrOk);
     DMPlan.AideCompteVisible := False;
//     showmessage('1'+str_bool2str(DMPLAn.AideCompteVisible));
    end;

      if (Result) then
         Begin
           if (pcCompte.ActivePage = tsCompte) then
           FTypePlan:= tpComptable
            Else if (pcCompte.ActivePage = tsTiers) then
              FTypePlan:= tpTiers
              Else FTypePlan:= tpLibelle;
           try
               case RecupClassTypeComponent(control)of
               GTEdit:begin
                        TCustomEdit(Control).Text:=DernierCompte;
                        TCustomEdit(Control).SetFocus;
                      end;
               GTStringGrid:with TStringGrid(Control) do
                              begin
                               Cells[Col, Row]:=DernierCompte;
                               SetFocus;
                              end;
               GTGrid: with TStringGrid(Control) do
                         begin
                          Cells[Col, Row]:=DernierCompte;
                          setFocus;
                         end;
               GTGrGrid:with TGrgrid(Control) do
                         begin
                          Cells[Col, Row]:=DernierCompte;
//                          Cells[OldColonne, Row]:=DernierCompte;
                          setFocus;
                         end;
               GTDBGrid: begin
                             if TCustomdbgrid(control).SelectedField.DataSet.State in [dsedit,dsinsert] then
                             TCustomdbgrid(control).selectedfield.asstring:=DernierCompte;
                             TCustomdbgrid(control).SetFocus;
                             end;
               GTFieldString:begin
                             if TField(control).DataSet.State in [dsedit,dsinsert] then
                             TField(control).asstring:=DernierCompte;
                             TField(control).FocusControl;
                             end;
               GTInplaceEdit,GTGrInplaceEdit:begin
                               TCustomEdit(Control).Text:=DernierCompte;
//                               TCustomEdit(Control).SetFocus;
                             end;
               GTRxDBComboEdit:TRxDBComboEdit(Control).Text:=DernierCompte;
               end;//fin du case
           except
           WinControlAux.SetFocus;
           end;
         End;
   end;
End;

//******************************************************************************
Function AideCompteValide(Compte :String; Control :Tcomponent;
    Classe :TCompteValide; IDJournal :LongInt; CompteCPartie :String) :Boolean;
// Vérifie si le compte existe
// Si oui, vérifie si on peut l'utiliser dans le contexte
Begin
   if(AideCompte = Nil) then
    AideCompte:= TAideCompte.Create(Application.MainForm);
 AideCompte.ControleTmp:=control;

 Result:= AideCompteExiste(Compte, Control);

   if (Classe = tcvEntete) And (IdJournal > 0) Then Begin
    {Controle du Compte d'entete}
  case AideModelTypeJournal(0, IDJournal) of
      tjAchat, tjVente: Result:= (Result And AideCompteComptePointable(Compte));
      tjBanque: Result:= (Result And (Compte  = AideModelField('Compte').AsString));
      tjOD: Result:= (Result Or Empty(Compte));
    else
     Result:= False;
    end;
   End
   Else if (Result) And (Classe > tcvEntete) Then Begin
    if Not Empty(CompteCPartie) And (CompteCPartie = Compte) Then
    Begin
         {Dans les lignes de saisie, on ne peut pas utilise
         le compte de comptrepartie automatique}
         Result:= False;
         if (Control <> Nil) Then Erreur('Compte', 'ContrePartie');
      End
      Else Begin
         {Autres controle de validité, A faire}
         {case Classe of
         tcvReglement: Result:= ;
         end;}
      End;

   End;
End;

//******************************************************************************
Function AideCompteExiste(Compte :String; Control :Tcomponent) :Boolean;
// Vérifie si le compte existe, sinon affichage de l'aide
Begin
   if(AideCompte = Nil) then
    AideCompte:= TAideCompte.Create(Application.MainForm);
 AideCompte.ControleTmp:=control;

 Result:= (AideCompteTypePlan(Compte) <> tpNone);

 if Not (Result) And (Control <> Nil) then
         Result:= AideCompteAffiche(Control,true,true,true,True,0);
End;

//******************************************************************************
Function AideCompteTypePlan(Compte :String) :TTypePlan;
// Retourne le type du plan / Compte
// Initialisation de FTypePlan (var globale unité)
Begin
   if(AideCompte = Nil) then
    AideCompte:= TAideCompte.Create(Application.MainForm);

   Result:= tpNone;

 with AideCompte do begin
      if Empty(Compte) Or (Compte[1] in ['1'..'7']) then
      Begin
         if (DMPlan.taCompte.FindField('Compte').AsString = Compte) then
            Result:= tpComptable
         Else if(DMPlan.taCompte.FindKey([Compte])) then Result:= tpComptable;
      End
      Else if (Compte[1] = '+') then Begin
         if (taTiers.FindField('Tiers').AsString = Compte) then
            Result:= tpTiers
         Else Begin
            if taTiers.FindKey([Compte]) then Result:= tpTiers;
         End;
      End;
      FTypePlan:= Result;
   End;
End;

//******************* DefiltrageAideCompte *************************
procedure TAideCompte.DefiltrageAideCompte;
begin
if DMplan <> nil then
 Begin
 DMPlan.taCompte.Filtered:=false;
 DMPlan.tacompte.filter:='';
 InitialiseCompte;
 End;
end;

//******************************************************************************
Function TAideCompte.GetCompte :String;
// Retourne le code du compte courant
Begin
 if pcCompte.ActivePage.Name='tsCompte' then
    begin
     result:=DMPlan.TaCompte.FindField('Compte').AsString;
    end
  else
 if pcCompte.ActivePage.Name='tsTiers' then
    Begin
    Result:= taTiers.FindField('Tiers').asString;
    End
  else
 if pcCompte.ActivePage.Name='tsLibelle' then
    Begin
     Result:= quLibelle.FindField('Compte').AsString;
    End
  else
 if pcCompte.ActivePage.Name='tsCptUtil' then
    begin
     result:=DMPlan.TaCompteListeUtil.FindField('Compte').AsString;
    end
// if (FTypePlan = tpComptable) then
////    And (tvCompte.Selected <> Nil) then
//    result:=DMPlan.TaCompte.FindField('Compte').AsString
////    Result:= GetStringElement(tvCompte.Selected.Text, 1, ' ')
//   Else if (FTypePlan = tpTiers) then
//    Result:= taTiers.FindField('Tiers').asString
//   Else Result:= quLibelle.FindField('Compte').AsString;
End;

//******************************************************************************
Procedure TAideCompte.ActualiseLibelle(Limite :String);
// Modification de la requête dans la recherche par libellé
Begin
 quLibelle.Params[0].AsString:= '%' + Limite + '%';
 quLibelle.DisableControls;
// quLibelle.Refresh;
 if (quLibelle.Active) then quLibelle.Close;
   quLibelle.Open;
 quLibelle.EnableControls;
End;

//******************************************************************************
procedure TAideCompte.InitialiseCompte;
// Initialise l'arborescence du plan comptable général
Var
 i:Integer;
   Node :TTreeNode;
Begin
// tvCompte.Items.Clear;
 if DMPlan.TaCompte.Active then close;
   DMPlan.TaCompte.Open;
   TaTiers.Open;
//   TaParam.Open;

// for i:= 1 to 7 do Begin
//    if (DMPlan.taCompte.FindKey([IntToStr(i)])) then Begin
//   Node:= tvCompte.Items.Add(Nil, DMPlan.taCompte.FindField('Compte').AsString
//          + ' - ' + DMPlan.taCompte.FindField('Libelle').AsString);
//
//       tvCompte.Items.AddChild(Node, '');
//       End;
//   End;
End;

//******************************************************************************
procedure TAideCompte.Recherche(Compte :String);
// Gestion du déroulement de l'arbre suivant saisie
Var
 i:Integer;
   Node, NodeC :TTreeNode;
Begin
 try
   if Empty(Compte) Or (Compte[1] in ['0'..'9']) then
   Begin
      pcCompte.ActivePage:= tsCompte;
      DMPlan.TaCompte.Locate('Compte',Compte,[loPartialkey]);


//      NodeC:= tvCompte.Items[0];
//      While NodeC <> Nil do Begin
//         if (Copy(NodeC.Text, 1, 1) = Copy(Compte, 1, 1)) then Break;
//         NodeC:= NodeC.GetNextSibling;
//      End;
//
//      if (NodeC <> Nil) then Begin
//         if Not (NodeC.Expanded) then NodeC.Expand(Faux);
//
//         For i:= 2 To Length(Compte) do Begin
//            Node:= RechercheSubdivision(NodeC, Compte[i]);
//            if (Node = Nil) then Break
//            Else Begin
//               NodeC:= Node;
//               if Not (NodeC.Expanded) then NodeC.Expand(Faux);
//            End;
//         End;
//
//         tvCompte.Selected:= NodeC;
//      End;
//
      ChaineRecherche:= Compte;
   End
   Else if (Compte[1] = '+') then Begin
      pcCompte.ActivePage:= tsTiers;
      taTiers.FindNearest([Compte]);
      ChaineRecherche:= Compte;
   End
   Else Begin
  ChaineRecherche:= '';
      edMot.Text:= Compte;
  ActualiseLibelle(Compte);
     pcCompte.ActivePage:= tsLibelle;
   End;
 except
  showMessage('AideCompte.Recherche : Erreur d''Affichage des comptes !');
 end;
End;

//******************************************************************************
Function TAideCompte.RechercheSubdivision(Node :TTreeNode; Index :Char) :TTreeNode;
// Déroulement des enfants du noeuds cliqué ou en cours
Var
 Compte :String;
   i :Integer;
Begin
 Result:= Nil;
 If (Node <> Nil) then Begin
    Compte:= GetStringElement(Node.Text, 1, ' ') + index;
      For i:= 0 to Node.Count -1 do
      if (Compte = GetStringElement(Node.Item[i].Text, 1, ' ')) Then Begin
       Result:= Node.Item[i];
       Break;
      End;
   End;
End;

//******************************************************************************
procedure TAideCompte.FormCreate(Sender: TObject);
// Création de la fenêtre
// ouverture des tables
// Init de l'arborescence
begin
    try
        if dmplan<>nil then dmplan.tacompte.afterscroll:=nil;
        if dmplan<>nil then dmplan.tacompte.BeforeScroll:=nil;
        ListeCompteUtiliseEcranAppelant:=TStringList.Create;
//	InitialiseForm(E.User,Self);
    except
//        Position:=poScreenCenter;
//        InitialiseFormPosDefaut(self);
    end;
   quLibelle.Open;
   DMPlan.TaCompte.Open;
   TaTiers.Open;
//   TaParam.Open;

//   InitialiseCompte;
end;

//******************************************************************************
procedure TAideCompte.FormDestroy(Sender: TObject);
// Fermeture des tables et destruction de l'écran
begin
InitialiseTable_A_Nil;
// taParam.Close;
//if aidecompte<>nil then
//  begin
LibereObjet(TObject(ListeCompteUtiliseEcranAppelant),Self);{ isa  le  02/12/04 }
//  ListeCompteUtiliseEcranAppelant.Free;
//if taTiers<>nil then
// taTiers.Close;
TableGereClose(taTiers);
//   if DMPlan <> nil then DMPlan.TaCompte.Close;
TableGereClose(quLibelle);{ isa  le  02/12/04 }
//if quLibelle<>nil then
// quLibelle.Close;
//   DestroyForm(Self,E.user);
AideCompte:=nil;
//  end;
end;

//******************************************************************************
procedure TAideCompte.FormClose(Sender: TObject;
  var Action: TCloseAction);
// Rend invisible l'écran à la fermeture
begin
if dmplan<>nil then dmplan.tacompte.afterscroll:=nil;
if dmplan<>nil then dmplan.tacompte.BeforeScroll:=nil;
ListeCompteUtiliseEcranAppelant.Clear;
// Action:= caFree;  //PB
// Action:= caHide; //JS
 Self.Tag := 0;     //BR
 laRecherche.Caption:='';
 edMot.Text:='';
//DMPlan.AideCompteVisible := False;
//showmessage('2'+str_bool2str(DMPLAn.AideCompteVisible));
//DefiltrageAideCompte;
end;

//******************************************************************************
procedure TAideCompte.tvCompteExpanding(Sender: TObject;
  Node: TTreeNode; var AllowExpansion: Boolean);
// Détruit les enfants, et les réaffichent
Var i :Integer;
begin
try
   for i:= 0 to Node.Count -1 do Begin
  Node.DeleteChildren;
  AjouteSubdivision(Node);
 End;
except
  showMessage('AideCompte.tvCompteExpanding : Erreur d''Affichage des comptes !');
end;
end;

//******************************************************************************
Procedure TAideCompte.AjouteSubdivision(Node :TTreeNode);
// Recherche dans le plan comptable s'il existe des subdivisions
// et met à jour l'arbre
Var
 d, LongCompte :Integer;
   lNode: TTreeNode;
   Compte, CompteSub :String;
Begin
try
 if (Node <> Nil) then
   Begin
      Compte:= GetStringElement(Node.Text, 1, ' ');

      LongCompte:= Length(Compte) + 1;
      for d:= 0 to 9 do Begin
       CompteSub:= Compte + IntToStr(d);
       if (DMPlan.taCompte.FindKey([CompteSub])) then Begin
          lNode:= tvCompte.Items.AddChild(Node, DMPlan.taCompte.FindField('Compte').AsString
              + ' - ' + DMPlan.taCompte.FindField('Libelle').AsString);

          DMPlan.taCompte.Next;
          if (Not DMPlan.taCompte.Eof)
             And (Copy(DMPlan.taCompte.FindField('Compte').AsString, 1, LongCompte) = CompteSub)then

           tvCompte.Items.AddChild(lNode, '');
         End;
      End;
   End;
except
  showMessage('AideCompte.AjouteSubdivisions : Erreur d''Affichage des comptes !');
end;
End;


//******************************************************************************
procedure TAideCompte.FormActivate(Sender: TObject);
// Positionne le focus à l'affichage de l'écran
begin
 if (pcCompte.ActivePage = tsCompte) then GrDBTsCompte.SetFocus
   Else if (pcCompte.ActivePage = tsTiers) then grTiers.SetFocus
    else if (pcCompte.ActivePage = tsCptUtil) then GrDBListeCompte.SetFocus;


grTiers.ParamColor:=true;
grTiers.Param:=ParamUtil.CouleurDBGrid;
grTiers.UpDateColor;

GrDBListeCompte.ParamColor:=true;
GrDBListeCompte.Param:=ParamUtil.CouleurDBGrid;
GrDBListeCompte.UpDateColor;

GrDBTsCompte.ParamColor:=true;
GrDBTsCompte.Param:=ParamUtil.CouleurDBGrid;
GrDBTsCompte.UpDateColor;

grLibelle.ParamColor:=true;
grLibelle.Param:=ParamUtil.CouleurDBGrid;
grLibelle.UpDateColor;

Patitre.visible:=main.AfficheTitre;


CouleurFond([PaBtn,PaBas],ParamUtil.CouleurPanelCorps);
CouleurFond([grLibelle],grTiers.Color);
grLibelle.Color:=grTiers.Color;

initialiseTableEvent;
DMPlan.TaCompte.AfterScroll(DMPlan.TaCompte);
DMPlan.TaCompte.BeforeScroll(DMPlan.TaCompte);
//if tvCompte <> nil then
//tvCompte.Color:=grTiers.Color;
//InitialiseCompte;

end;

//******************************************************************************
procedure TAideCompte.btOkClick(Sender: TObject);
// Validation de la sélection
begin
GetCompte;
 if (pcCompte.ActivePage = tsCompte){ And (tvCompte.Selected <> Nil) }then
 Begin
//    if (Self.Tag = C_NO_CONTROL) or         //BR
//       Not (tvCompte.Selected.HasChildren)
      if  not DMPLan.PossedeFils(DernierCompte)
           or Question('AideCompte', 'Subdivision') then
           begin
//         if (pcCompte.ActivePage = tsCompte) then
//          FTypePlan:= tpComptable
//          Else if (pcCompte.ActivePage = tsTiers) then
//            FTypePlan:= tpTiers
//            Else FTypePlan:= tpLibelle;

          if DMPlan.CompteValideDansParamContexte(DernierCompte,true,['Rac1','Rac2','Rac3','Rac4','Rac5','Rac6'],nil) then
           begin
              ModalResult:= mrOk;
            end
            else
             begin
              ModalResult:=mrCancel;
              abort;
             end;
          end;
//       or Question('AideCompte', 'Subdivision') then
//         ModalResult:= mrOk;
   End
 else
  if (pcCompte.ActivePage = tsTiers) then
   begin
    ModalResult:= mrOk;
   end
 else
  if (pcCompte.ActivePage = tsLibelle) then
   begin
    if not DMPLan.PossedeFils(DernierCompte) or Question('AideCompte', 'Subdivision') then
       begin
        if DMPlan.CompteValideDansParamContexte(DernierCompte,true,['Rac1','Rac2','Rac3','Rac4','Rac5','Rac6'],nil) then
         begin
          ModalResult:= mrOk;
         end
        else
         begin
          ModalResult:=mrCancel;
          abort;
         end;
      end;
   end
 else
   if (pcCompte.ActivePage = tsCptUtil) then
    begin
    if not DMPLan.PossedeFils(DernierCompte) or Question('AideCompte', 'Subdivision') then
       begin
        if DMPlan.CompteValideDansParamContexte(DernierCompte,true,['Rac1','Rac2','Rac3','Rac4','Rac5','Rac6'],nil) then
         begin
          ModalResult:= mrOk;
         end
        else
         begin
          ModalResult:=mrCancel;
          abort;
         end;
      end;
    end;
//   Else if (pcCompte.ActivePage = tsTiers) And (Not (taTiers.Eof)
//    Or not (TaTiers.Bof)) then ModalResult:= mrOk
//   Else if (pcCompte.ActivePage = tsLibelle) And (Not (quLibelle.Eof)
//    Or not (quLibelle.Bof)) then
//    Begin
//
//      if (AideCompteTypePlan(quLibelle.FindField('Compte').asString) in [tpComptable, tpTiers]) then
//       ModalResult:= mrOk
//      Else Erreur('AideCompte', 'Compte Inexistant');
//   End;

end;

//******************************************************************************
procedure TAideCompte.tvKeyPress(Sender: TObject; var Key: Char);
// Ouverture d'un noeud et passage au suivant avec #13
// Si dernier niveau, valide le compte en cours
Var
   lNode: TTreeNode;
begin
 if (Key = #13) then
       btOkClick(btOk);
//   if (pcCompte.ActivePage = tsCompte) And (tvCompte.Selected <> Nil) then
//   Begin
//    if (tvCompte.Selected.HasChildren) then
//    Begin
//      tvCompte.Selected.Expand(False);
//       lNode:= tvCompte.Selected.GetFirstChild;
//         tvCompte.Selected:= lNode;
//      End
//      Else btOkClick(Sender);
//
//      Key:= #0;
//   End
//   Else if (pcCompte.ActivePage <> tsCompte) then Begin
//      btOkClick(Sender);
//      Key:= #0;
//   End
end;

//******************************************************************************
procedure TAideCompte.grTiersCellClick(Column: TColumn);
// Validation sur clic souris
begin
 btOkClick(grTiers);
end;

//******************************************************************************
procedure TAideCompte.FormKeyPress(Sender: TObject; var Key: Char);
// Recherche dynamique suivant le contexte
begin
 {Recherche donnees}
   if (ActiveControl <> edMot) then Begin
      if (Key in ['A'..'Z', 'a'..'z', '0'..'9']) then Begin
         ChaineRecherche:= UpperCase(ChaineRecherche + Key);
         Key:= #0
      End
      Else if (Key = #08) then ChaineRecherche:= Copy(ChaineRecherche, 1, Length(ChaineRecherche) -1);

      if (Not Empty(ChaineRecherche) And (Key = #0)) or (Key = #08) then Begin
         if (pcCompte.ActivePage = tsCompte) then begin
            Recherche(ChaineRecherche)
         End
         Else if (pcCompte.ActivePage = tsTiers)
         And (Length(ChaineRecherche) > 0) then begin
            if (ChaineRecherche[1] <> '+') then ChaineRecherche:= '+' + ChaineRecherche;

            taTiers.FindNearest([ChaineRecherche]);
         end
         Else Begin
    quLibelle.Locate('Libelle', ChaineRecherche, [loCaseInsensitive]);
         End;
      End;
   End;
end;

//******************************************************************************
procedure TAideCompte.edMotKeyPress(Sender: TObject; var Key: Char);
// Valide le libellé recherché
begin
 if (Key = #13) then
   Begin
      btOkClick(btOk);
      Key:= #0;
   End;
end;

//******************************************************************************
procedure TAideCompte.tsLibelleEnter(Sender: TObject);
// Ouvre la requête si jamais exécuter
begin
 if Not (quLibelle.Active) then ActualiseLibelle('');
end;

//******************************************************************************
procedure TAideCompte.pcCompteChanging(Sender: TObject;
  var AllowChange: Boolean);
// Initialise la chaine de recherche des comptes en cas de changement d'ongles
begin
    laRecherche.Caption:= '';
    FChaineRecherche:='';
    LaCodeTva.Caption:='- -';
    LaTypeTva.Caption:='- -';
    LaEcritures.Caption:='';
    LaCodeTVADef.Caption := '';

 if pcCompte.ActivePage=tsTiers then
   TaCompteAfterScroll(GrDBTsCompte.DataSource.DataSet);
end;

//******************************************************************************
Procedure TAideCompte.SetChaineRecherche(Value :String);
// Affiche et actualise la chaine de recherche en cours
Begin
 if (Value <> FChaineRecherche) then Begin
    FChaineRecherche:= Value;
    if Empty(FChaineRecherche) then
        laRecherche.Caption:= ''
    else laRecherche.Caption:= 'Rechercher : ' + FChaineRecherche;
   End;
End;


procedure TAideCompte.pmNouveauTClick(Sender: TObject);
var
InfosTiersSaisie:TInfosTiersSaisie;
begin
//showmessage('Pour créer un nouveaux Tiers, vous devez aller dans la gestion des Tiers !');
//self.ModalResult := mrCancel;
//self.RecreateWnd;
//self.close;
InfosTiersSaisie:=AideTiersAfficheEnSaisie('');
if InfosTiersSaisie.Retour then
 begin
   Recherche(InfosTiersSaisie.CodeTiers);
 end;
end;

procedure TAideCompte.FormShow(Sender: TObject);
var
Accept:Boolean;
begin
DMPlan.AideCompteVisible := true;
initialiseTableEvent;

if not DMPlan.TaCompte.Active then DMPlan.TaCompte.open;

 TaTiers.Open;
// TaParam.Open;
 quLibelle.Filter:=DMPlan.TaCompte.Filter;
  quLibelle.Filtered:=false;
 //DMPlan.TaCompteListeUtil.Filter;
// quLibelle.Filtered:=DMPlan.TaCompte.Filtered;
 //DMPlan.DaCompteListeUtil.DataSet.OnFilterRecord;
 if quLibelle.Active then quLibelle.Close;
 quLibelle.Open;
 quLibelle.OnFilterRecord:=DMPlan.TaCompte.OnFilterRecord;
 quLibelle.Filtered:=true;
 pcCompte.Pages[0].TabVisible:=Page1;
 pcCompte.Pages[1].TabVisible:=Page2;
 pcCompte.Pages[2].TabVisible:=Page3;
 pcCompte.Pages[3].TabVisible:=Page4;
 PopMenuCompte.Items[0].Enabled:=pcCompte.Pages[0].TabVisible;
// PopMenuCompte.Items[1].Enabled:=pcCompte.Pages[1].TabVisible; PB le 05/11/2002
 PopMenuCompte.Items[2].visible:=pcCompte.Pages[2].TabVisible;
 PopMenuCompte.Items[3].visible:=pcCompte.Pages[2].TabVisible;
 if IndexPage <> -1 then
    if pcCompte.Pages[IndexPage].Tabvisible then
     begin
       pcCompte.ActivePage:=pcCompte.Pages[IndexPage];
       pcCompteChange(pcCompte);
     end;
// if true then
//  begin
//   if (@DMPlan.TaCompte.OnFilterRecord <> nil ) then
//        showmessage('OK0');
//
//   showmessage(DMPlan.TaCompte.MethodName(@DMPlan.TaCompte.OnFilterRecord));
//   if (@DMPlan.TaCompte.OnFilterRecord = DMPlan.MethodAddress('TaCompteFilterRecord')) then
//    begin
//     showmessage('OK');
//    end;
//  end;
//  DMPlan.TaCompteFilterRecord(DMPlan.TaCompte,Accept);
end;

procedure TAideCompte.NouveauxCompte1Click(Sender: TObject);
begin
DMPlan.DemandeCreation('',controletmp,false);
end;

procedure TAideCompte.Pop1Click(Sender: TObject);
begin
PopMenuCompte.Popup(AideCompte.Left+30,AideCompte.Top+30);
end;

procedure TAideCompte.pcCompteChange(Sender: TObject);
begin
 if pcCompte.ActivePage.Name='tsCompte' then
    begin
        PopMenuCompte.Items[0].Enabled:=true;
        PopMenuCompte.Items[0].ShortCut:=ShortCut(VK_F6,[]);
        PopMenuCompte.Items[1].Enabled:=false;
        PopMenuCompte.Items[1].ShortCut:=0;
        PopMenuCompte.Items[2].Visible:=false;
        PopMenuCompte.Items[3].Visible:=false;
      end
      else
 if pcCompte.ActivePage.Name='tsTiers' then
    Begin
        PopMenuCompte.Items[0].Enabled:=false;
        PopMenuCompte.Items[0].ShortCut:=0;
        PopMenuCompte.Items[1].Enabled:=true ; //PB le 05/11/2002
        PopMenuCompte.Items[1].ShortCut:=ShortCut(VK_F6,[]); //PB le 05/11/2002
        PopMenuCompte.Items[2].Visible:=false;
        PopMenuCompte.Items[3].Visible:=false;
      End
      else
 if pcCompte.ActivePage.Name='tsLibelle' then
    Begin
        PopMenuCompte.Items[0].Enabled:=true;
        PopMenuCompte.Items[0].ShortCut:=0;
        PopMenuCompte.Items[1].Enabled:=true; //PB le 05/11/2002
        PopMenuCompte.Items[1].ShortCut:=0; //PB le 05/11/2002
        PopMenuCompte.Items[2].Visible:=true;
        PopMenuCompte.Items[3].Visible:=true;
      End;

end;

procedure TAideCompte.Visualisation1Click(Sender: TObject);
begin
if (pcCompte.ActivePage = tsCompte) then
FTypePlan:= tpComptable
 Else if (pcCompte.ActivePage = tsTiers) then
   FTypePlan:= tpTiers
   Else FTypePlan:= tpLibelle;
 if pcCompte.ActivePage.Name='tsCompte' then
    begin
      DetailEcritureCompte(GetCompte,true,true);
      end
      else
 if pcCompte.ActivePage.Name='tsTiers' then
    Begin
      DetailEcritureTiers(GetCompte,true);
      End
      else
 if pcCompte.ActivePage.Name='tsLibelle' then
    Begin
      DetailEcritureCompte(GetCompte,true,true);
      End;
end;

procedure TAideCompte.PaGrilleResize(Sender: TObject);
begin
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TAideCompte.PaGrilleTResize(Sender: TObject);
begin
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
//FormateTailleColonne(grTiers,12,[3,3,3,1]);
end;

procedure TAideCompte.TaTiersBeforeInsert(DataSet: TDataSet);
begin
abort;
end;

procedure TAideCompte.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if shift = [ssCtrl] then
 case key of
    VK_LEFT:Begin
             pcCompte.SelectNextPage(false);
            End;

    VK_RIGHT:Begin
             pcCompte.SelectNextPage(true);
             End;
 end;

end;

procedure TAideCompte.tvCompteChange(Sender: TObject; Node: TTreeNode);
var
Infosplancpt:TInfosplancpt;
begin
  try
  if aidecompte<>nil then
    begin
      DeFiltrageDataSet(DMRech.TaPlanCptRech);
      Infosplancpt:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[GetStringElement(Node.Text, 1, ' ')]);
//      Infosplancpt:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[GetStringElement(tvCompte.Selected.Text, 1, ' ')]);
      laRecherche.Caption:= '';
      FChaineRecherche:='';

      if empty(Infosplancpt.TvaCode) then
       LaCodeTva.Caption:='- -'
        else
       LaCodeTva.Caption:=Infosplancpt.TvaCode;

      if empty(Infosplancpt.TvaType) then
       LaTypeTva.Caption:='- -'
        else
       LaTypeTva.Caption:=Infosplancpt.TvaType;

// PB le 19/02/04
//      if DetailEcritureCompte(Infosplancpt.Compte,false,False) then
//      LaEcritures.Caption:='Nombre d''écritures du compte '+Infosplancpt.Compte+' : '+inttostr(DMEcritures.QueryEcrCompte.RecordCount)
//      else LaEcritures.Caption:='';
    end;
  except
    showMessage('AideCompte.tvCompteChange : Erreur d''Affichage des comptes !');
  end;
end;

procedure TAideCompte.paBtnResize(Sender: TObject);
begin
FormateTailleBoutton([btAnnuler,btOk,BtnImprimer],PaBtn,90,0);
end;

procedure TAideCompte.edMotEnter(Sender: TObject);
begin
CouleurActivecontrolLabel(ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond,Label1,clREd,0);
end;

procedure TAideCompte.edMotExit(Sender: TObject);
begin
  CouleurDeActivecontrolLabel(lastZoneEdit,ParamUtil.CouleurDBGrid.GrilleColorFond,Label1,clWindowText,0);
end;

procedure TAideCompte.FiltrageAideCompte(Famille:integer);
Begin
  DMPlan.FiltrageAideCompte(Famille,nil,DMPlan.TaCompteFilterRecord);
End;


procedure TAideCompte.FiltrageAideCompteSurCompte(Famille:integer;Cpt:string);
Begin
  DMPlan.FiltrageAideCompteSurCompte(Famille,Cpt,nil,DMPlan.TaCompteFilterRecord);
End;


procedure TAideCompte.GrDBListeCompteDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  holdColor: TColor;
begin
if ListeCompteUtiliseEcranAppelant.IndexOf(Column.Field.DataSet.FindField('Compte').AsString) <> -1 then
//if Column.Field.DataSet.FindField('Ouverture').AsBoolean then
 begin
      holdColor:=(Sender as TGrDBGrid).Canvas.Brush.Color;
      (Sender as TGrDBGrid).Canvas.Brush.Color :=clSilver;//$00808040;
      (Sender as TGrDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
      (Sender as TGrDBGrid).Canvas.Brush.Color := holdColor;
 end
end;

Procedure TAideCompte.TaCompteBeforeScroll(DataSet: TDataSet);
Begin
Timer1.Enabled := False;
End;

procedure TAideCompte.TaCompteAfterScroll(DataSet: TDataSet);
begin
try
if aidecompte<>nil then
  begin
    laRecherche.Caption:= '';
    FChaineRecherche:='';

    LaCodeTva.Caption:='- -';
    if not empty(DMPlan.TaCompte.FindField('TVaCode').AsString) then
           LaCodeTva.Caption:=DMPlan.TaCompte.FindField('TVaCode').AsString;

    LaTypeTva.Caption:='- -';
    if not empty(DMPlan.TaCompte.FindField('TVaType').AsString) then
     LaTypeTva.Caption:=DMPlan.TaCompte.FindField('TVaType').AsString;

// PB le 19/02/04
// Nouveau code
    LaEcritures.Caption:='';
    Timer1.Enabled := true;

// Ancien code
//    LaEcritures.Caption:='';
//    if DetailEcritureCompte(DMPlan.TaCompte.FindField('Compte').AsString,false,False) then
//     LaEcritures.Caption:='Nombre d''écritures du compte '+DMPlan.TaCompte.FindField('Compte').AsString+' : '+inttostr(DMEcritures.QueryEcrCompte.RecordCount);
// Fin PB le 19/02/04
    LaCodeTVADef.Caption := '';
    if Not VerifFNumeric(DMPlan.TaCompte.FindField('Taux')).VideOUZero then
           LaCodeTVADef.Caption := 'Taux de TVA par défaut utilisé pour ce compte : ' + DMPlan.TaCompte.FindField('Taux').AsString + ' %'
          else
          begin
           if not empty(DMPlan.TaCompte.FindField('TVaCode').AsString) then
           LaCodeTVADef.Caption := 'Taux de TVA par défaut utilisé pour ce compte : ' + CurrToStr(FTvaRecupMiniMaxTva(DMPlan.TaCompte.FindField('TVaCode').AsString).Taux_Supp) + ' %';
          end;

  end;
except
    showMessage('AideCompte.tvCompteChange : Erreur d''Affichage des comptes !');
end;
end;
procedure TAideCompte.GrDBTsCompteKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then
btOkClick(btOk);
end;

procedure TAideCompte.edMotChange(Sender: TObject);
begin
    ActualiseLibelle(edMot.Text);
end;

procedure TAideCompte.edMotKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
case key of
   vk_down:begin
            if not quLibelle.EOF then
            quLibelle.Next
            else
            quLibelle.First;
           end;
   vk_up:begin
            if not quLibelle.EOF then
            quLibelle.prior
            else
            quLibelle.Last;
           end;
end;

end;

procedure TAideCompte.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
canclose:=true;
InitialiseTable_A_Nil;{ isa  le  29/01/04 }
end;


Function AideCompteDansContexte_LaisserPasser(Compte:String;Control:TComponent;Const Racx:array of string;ForceAffiche,Affich:boolean;var MessDSub,Laisser_Passer:boolean;MessNumCpt,Cpt,Tiers,Lib:boolean;Index:Integer):Boolean;
var
FirstCar:string;
CptTiers:Boolean;
InfosTiersSaisie:TInfosTiersSaisie;
Begin
try
result:=false;
if(AideCompte = Nil) then
 AideCompte:= TAideCompte.Create(Application.MainForm);
 AideCompte.ControleTmp:=control;
CptTiers:=false;
if not empty(Compte) then CptTiers:=copy(compte,1,1)='+';
if Not CptTiers then // Pas Tiers
 Begin
 If Empty(Compte) then
 Begin
  if MessNumCpt then application.Messagebox(Pchar('Le Numéro de Compte est Obligatoire !'),'Erreur de saisie',0);
   result:=AideCompteAffiche(Control,Cpt,Tiers,Lib,True,Index);
 End
 else
  if DMPlan.CompteValideDansParamContexte(Compte,not ForceAffiche,Racx,nil) then  // Si le compte est valide dans contexte
   Begin
   if DMPlan.CompteExistePCU(compte) then //alors s'il existe
          begin
              if DMPlan.PossedeFils(Compte) then
                 Begin
                   if MessDSub=true then
                    begin
                      if Question('AideCompte', 'Subdivision') then
                      begin
                       MessDSub:=false;
                       case RecupClassTypeComponent(control)of
                          GTEdit:TCustomEdit(Control).Text:=Compte;
                          GTStringGrid: with TStringGrid(Control) do Cells[Col, Row]:=Compte;
                          GTGrid: with TStringGrid(Control) do Cells[Col, Row]:=Compte;
                          Gtgrgrid:with TGrgrid(Control) do Cells[col, Row]:=Compte;
                          GTDBGrid:begin
                                    if TCustomdbgrid(control).SelectedField.DataSet.State in [dsedit,dsinsert] then
                                    TCustomdbgrid(control).selectedfield.asstring:=Compte;
                                   end;
                          GTFieldString:begin
                                        if TField(control).DataSet.State in [dsedit,dsinsert] then
                                        TField(control).asstring:=Compte;
                                        end;
                          GTInplaceEdit,GTGrInplaceEdit:TCustomEdit(Control).Text:=Compte;
                          GTRxDBComboEdit:TRxDBComboEdit(Control).Text:=Compte;
                       end;//fin du case
                      result:=true;
                      end
                      else
                      begin
                           result:=AideCompteAffiche(Control,Cpt,Tiers,Lib,True,Index);
                      end;
                    end
                    else
                    begin
                     if ForceAffiche then
                        result:=AideCompteAffiche(Control,Cpt,Tiers,Lib,True,Index) else
                      result:=true;//On ne repose pas la question sur l'utilisation
                                   //de la dernière subdivision
                    end;
                 End
                 else
                 Begin
                 if ForceAffiche then
                  result:=AideCompteAffiche(Control,Cpt,Tiers,Lib,True,Index) else
                 result:=true;//le Compte ne possede pas de Fils
                 End;

          end
          else // sinon, s'il n'existe pas, demande de création
          begin
           if DMPlan.DemandeCreation(Compte,Control,true).retour then
             result:=AideCompteDansContexte(Compte,Control,Racx,true,MessDSub,MessNumCpt,Cpt,Tiers,Lib,Index)
           else
             result:=AideCompteExiste(Compte,Control)
////           result:=true; A verifier si ca marche lors de la creation d'un cpt hors contexte
          end;
   End
   else
   Begin
   //result:=AideCompteAffiche(Control,Cpt,Tiers,Lib,True,Index)**** isa le 27/11/02
    if Affich then
      result:=AideCompteAffiche(Control,Cpt,Tiers,Lib,True,Index)
    else
//      if DMPlan.CompteExistePCU(compte) then
      if (DMPlan.CompteExistePCU(compte)) and(Length(compte)>2) and(not DMPlan.CptEstCollectif(compte))and(not FTvaCompteDeTva(compte))then
        begin
        if application.MessageBox(Pchar('Voulez-vous le conserver ?'),'Erreur de saisie',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON1)=mrno then
          result:=AideCompteAffiche(Control,Cpt,Tiers,Lib,True,Index)
        else
          Laisser_Passer:=true;
        end
      else
        result:=AideCompteAffiche(Control,Cpt,Tiers,Lib,True,Index);
   End;
 end
 else // Tiers
 begin
 If Empty(Compte) then
  Begin
   if MessNumCpt then Application.Messagebox(Pchar('Le Numéro de Compte est Obligatoire !'),'Erreur de saisie',0);
     AideCompte.Page2:=true;
     AideCompte.IndexPage:=1;
     AideCompte.pcCompte.ActivePage:=AideCompte.tsTiers;
     AideCompte.pcCompteChange(AideCompte.pcCompte);
    result:=AideCompteAffiche(Control,Cpt,Tiers,Lib,True,Index);
  End
 else
  begin
   DeFiltrageDataSet(DMrech.TaTiersRech);
   // 05/11/2002 : ce bout de code permet de gérer la création d'un tiers en cours saisie
   result := Infos_TInfosTiers(DMrech.TaTiersRech,'Tiers',[Compte]).ResultInfos;
   if ((not result) and (not ForceAffiche)) then  // Si le compte est valide dans contexte
    Begin                                                     // mais n'existe pas
     InfosTiersSaisie.Retour := false;
     AideCompte.Page2:=true;
     AideCompte.IndexPage:=1;
     AideCompte.pcCompte.ActivePage:=AideCompte.tsTiers;
     AideCompte.pcCompteChange(AideCompte.pcCompte);
     if compte <> '+' then
      if MessageDlg('Le compte : '+Compte+' n''existe pas ! '+#10#13#10#13+'Voulez-vous le créer ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
//      if Application.MessageBox(PChar('Le compte : '+Compte+' n''existe pas ! '+#10#13#10#13+'Voulez-vous le créer ?'),'Confirmation',MB_YESNO + MB_DEFBUTTON1) = IDYES then
       begin
        InfosTiersSaisie:=AideTiersAfficheEnSaisie(Compte);
       end;
       result:=InfosTiersSaisie.Retour;
       // annulation de la création du Tiers
       if not InfosTiersSaisie.Retour then
        begin
         result:=AideCompteAffiche(Control,Cpt,Tiers,Lib,True,Index);
        end
        else
       // Validation de la création du Tiers
        begin
          DMrech.TaTiersRech.Refresh;                           
          result:=Infos_TInfosTiers(DMrech.TaTiersRech,'Tiers',[InfosTiersSaisie.CodeTiers]).ResultInfos;
          // Si le nouveau code de Tiers est validé, On vérifie si c'est le même qui
          // a été créé que celui qui à été saisie dans le controle d'appel
          if result then
           begin
            if InfosTiersSaisie.CodeTiers <> Compte then
             begin
              AideCompte.TaTiers.Refresh;
              result:=AideCompteAffiche(Control,Cpt,Tiers,Lib,True,Index);
             end;
           end
        end;
    end
    else
    begin
     if ForceAffiche then
      result:=AideCompteAffiche(Control,Cpt,Tiers,Lib,True,Index) else
    result:=true;
    end;
  end;

 end;
except
  showMessage('AideCompteDansContexte : Erreur d''Affichage des comptes !');
end;
End;


procedure TAideCompte.btAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TAideCompte.btAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TAideCompte.Aide1Click(Sender: TObject);
begin
if ActiveControl=grTiers then
   Rechercher(grTiers,TaTiers,['Nom','Tiers','Compte','Actif','Type'],['Nom','Tiers','Compte','Actif','Type'],'',0);
   //Rechercher_AvecJointure(grTiers,TaTiers,[' join Ecriture E on (E.Tiers=Tiers)'],[' group by Nom,Tiers,Compte,Actif,Type'],['Nom','Tiers','Compte','Actif','Type'],['Nom','Tiers','Compte','Actif','Type'],'',0);

if ActiveControl=GrDBTsCompte then
   Rechercher(GrDBTsCompte,DMPlan.TaCompte,
              ['Libelle','Compte','TvaCode','Taux','Pointable','Collectif','Immobilisation','PlanSaisie'],
              ['Libellé','Compte','Code TVA','Taux','Pointable','Collectif','Immobilisation','PlanSaisie'],'',0);
end;


Procedure TAideCompte.InitialiseTable_A_Nil;
Begin
 if dmplan<>nil then DMPlan.TaCompte.AfterScroll:=nil;
 if dmplan<>nil then dmplan.tacompte.BeforeScroll:=nil;
// InitDatasetEvent_A_Nil_Sur_Form([DMPlan.TaCompte]);
End;

Procedure TAideCompte.initialiseTableEvent;
Begin
 if dmplan<>nil then
    begin
      DMPlan.TaCompte.AfterScroll:=TaCompteAfterScroll;
      DMPlan.TaCompte.BeforeScroll:=TaCompteBeforeScroll;
    end;
End;

procedure TAideCompte.Timer1Timer(Sender: TObject);
begin
   Timer1.Enabled := False;
   LaEcritures.Caption:='';
   if DetailEcritureCompte(DMPlan.TaCompte.FindField('Compte').AsString,false,False) then
     LaEcritures.Caption:='Nombre d''écritures du compte '+DMPlan.TaCompte.FindField('Compte').AsString+' : '+inttostr(DMEcritures.QueryEcrCompte.RecordCount);

end;

procedure TAideCompte.ChBPlanDeSaisieClick(Sender: TObject);
begin
 ParamUtil.PlanDeSaisie := ChBPlanDeSaisie.Checked;
 DMPlan.TaCompte.Filtered:=false;
 DMPlan.TaCompte.Filtered:=True;

end;

procedure TAideCompte.BtnImprimerClick(Sender: TObject);
var
Site:TEditLien;
NomMenuSiteWeb:TFileStream;
begin
EditionPlanCptL(C_EditionSimple,GrDBTsCompte.DataSource.DataSet,nil,NomMenuSiteWeb,Site);
end;

procedure TAideCompte.Imprimer1Click(Sender: TObject);
begin
BtnImprimer.Click;
end;

end.

