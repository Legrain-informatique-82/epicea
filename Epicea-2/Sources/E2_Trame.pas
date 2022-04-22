
unit E2_Trame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, RXDBCtrl, ExRxDBGrid, Mask, DBCtrls, ExtCtrls, ModuleTrame,
  Gr_Librairie_obj, E2_Librairie_obj, ExDBGrid,db, Menus,DBTables,
  quickrpt, Buttons;

type
  TTrame = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ExDBGTrameL: TExRxDBGrid;
    Edit1: TEdit;
    Edit2: TEdit;
    Label6: TLabel;
    ExDBGTrame: TExDBGrid;
    Panel3: TPanel;
    BtnInsert: TButton;
    BtnSupr: TButton;
    BtnNew: TButton;
    BtnEnregistrer: TButton;
    BtnFermer: TButton;
    BtnModifier: TButton;
    PopupMenu1: TPopupMenu;
    Nouveau1: TMenuItem;
    Inserer1: TMenuItem;
    Modifier1: TMenuItem;
    Enregistrer1: TMenuItem;
    Fermer1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Panel2: TPanel;
    BtnAnnuler: TButton;
    Label7: TLabel;
    SpeedButton1: TSpeedButton;
    Edit_PMJournal: TEdit;
    Edit_PMNom: TEdit;
    Edit_PMCode: TEdit;
    Edit_PMBanque: TEdit;
    Edit_PMTiers: TEdit;

//*****************             Ouverture                    *******************
    procedure FormActivate(Sender: TObject);
    procedure initialisation;
//*****************               divers                     *******************
    procedure GererBoutons(selection: integer);
    procedure initBooleen(selection : integer);
    procedure RemplirChamps;
    procedure RemplirParDefaut;
    procedure viderChamps;
    procedure ChampsAccessibles;
    procedure champsNonAccessibles;
//*****************       Vérification des saisies           *******************
//                  et conditions pour l'enregistrement :
// champs(en-tête de trame)  
    function validation : boolean;
    function ChampsVides : boolean;
    procedure VerifSaisieTiers;
    procedure VerifSaisieJournal;
    procedure VerifSaisieBanque;
    procedure Edit_PMTiersEnter(Sender: TObject);
    procedure Edit_PMCodeEnter(Sender: TObject);
    procedure Edit_PMNomEnter(Sender: TObject);
    procedure Edit_PMJournalEnter(Sender: TObject);
    procedure Edit_PMBanqueEnter(Sender: TObject);
    procedure Edit_PMTiersExit(Sender: TObject);
    procedure Edit_PMBanqueExit(Sender: TObject);
    procedure Edit_PMJournalExit(Sender: TObject);
    procedure Panel1Exit(Sender: TObject);
//*****************      grille :(lignes)                    *******************
    procedure ExDBGTrameLColExit(Sender: TObject);
//******************* évènements grille trame et lignes ************************
    procedure ExDBGTrameLEnter(Sender: TObject);
    procedure ExDBGTrameLExit(Sender: TObject);
    procedure ExDBGTrameEnter(Sender: TObject);
//*****************           procedures/boutons        ************************
    procedure nouvelleTrame;
    procedure enregistrer;
    procedure modifier;
    procedure supprimer;
    procedure inserer;
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnSuprClick(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure BtnNewClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
//***********************       fermeture      ********************************
    procedure FormClose(Sender: TObject; var Action: TCloseAction);   
//***********     raccourcis clavier (popup menu)     **************************
    procedure Nouveau1Click(Sender: TObject);
    procedure Inserer1Click(Sender: TObject);
    procedure Modifier1Click(Sender: TObject);
    procedure Enregistrer1Click(Sender: TObject);
    procedure Supprimer1Click(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    procedure Annuler1Click(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure ExDBGTrameLKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }

//****************      lien avec DMTrame (data module)       ******************
  TrameEnrg,LigneEnrg,modif,ajout,SLigne: boolean;
  end;
  function SortirCar(chaine,car:string): string;
  function maj(chaine:string): string;
  //***************************************************************************
var
  Trame: TTrame;
  ChampsVides,Rempli,T : boolean;
//
implementation

uses E2_Tiers,DMPlanCpt, E2_Main, UQReport;

{$R *.DFM}

//*****************************************************************************
//                            ouverture et initialisations
//*****************************************************************************
procedure TTrame.FormActivate(Sender: TObject);
begin
  initBooleen(1);
  initialisation;
  DMTrame.automatique := true;//gestion des numeros de ligne auto ou non
  BtnSupr.caption := 'Supprimer Trame';
  DMTrame.DaTrameL.onStateChange:= DMTrame.DaTrameLStateChange;
  DMTrame.DaTrame.onStateChange:= DMTrame.DaTrameStateChange;
  DMTrame.DaTrameLStateChange(self);
  DMTrame.DaTrameStateChange(self);
  DMTrame.TaTrame.AfterScroll := DMTrame.TaTrameAfterScroll;
  DMTrame.TaTrameL.AfterScroll := DMTrame.TaTrameLAfterScroll;  
end;

procedure TTrame.initialisation;
begin
  Rempli:= false;
  T:=false;
  RemplirChamps;
  champsNonAccessibles;
end;

procedure TTrame.GererBoutons(selection: integer);
begin
  case selection of
    1:
    begin
    if DMTrame.TaTrame.State=dsbrowse then
    begin
      BtnEnregistrer.enabled := false;
      Enregistrer1.Enabled   := false;
      BtnSupr.enabled        := true;
      Supprimer1.Enabled     := true;
      BtnInsert.enabled      := true;
      Inserer1.enabled       := true;
      BtnModifier.enabled    := true;
      Modifier1.Enabled      := true;
      BtnNew.enabled         := true;
      Nouveau1.Enabled       := true;
      BtnFermer.enabled      := true;
      Fermer1.Enabled        := true;
      BtnAnnuler.enabled     := false;
      Annuler1.Enabled       := false;
    end
    else
    begin
      BtnEnregistrer.enabled := true;
      Enregistrer1.Enabled   := true;
      BtnSupr.enabled        := false;
      Supprimer1.Enabled     := false;
      BtnInsert.enabled      := false;
      Inserer1.enabled       := false;
      BtnModifier.enabled    := false;
      Modifier1.Enabled      := false;
      BtnNew.enabled         := false;
      Nouveau1.Enabled       := false;
      BtnFermer.enabled      := true;
      Fermer1.Enabled        := true;
      BtnAnnuler.enabled     := true;
      Annuler1.Enabled       := true;
    end;
    end;
    2:
    begin
      if DMTrame.TaTrameL.State=dsbrowse then
      begin
      BtnEnregistrer.enabled := false;
      Enregistrer1.Enabled   := false;
      BtnSupr.enabled        := true;
      Supprimer1.Enabled     := true;
      BtnInsert.enabled      := true;
      Inserer1.enabled       := true;
      BtnModifier.enabled    := true;
      Modifier1.Enabled      := true;
      BtnNew.enabled         := true;
      Nouveau1.Enabled       := true;
      BtnFermer.enabled      := true;
      Fermer1.Enabled        := true;
      BtnAnnuler.enabled     := false;
      Annuler1.Enabled       := false;
      end
      else
      begin
      BtnEnregistrer.enabled := true;
      Enregistrer1.Enabled   := true;
      BtnSupr.enabled        := false;
      Supprimer1.Enabled     := false;
      BtnInsert.enabled      := false;
      Inserer1.enabled       := false;
      BtnModifier.enabled    := false;
      Modifier1.Enabled      := false;
      BtnNew.enabled         := false;
      Nouveau1.Enabled       := false;
      BtnFermer.enabled      := true;
      Fermer1.Enabled        := true;
      BtnAnnuler.enabled     := true;
      Annuler1.Enabled       := true;
      end;
    end;
//    3:
//    begin
//      BtnEnregistrer.enabled := true;
//      Enregistrer1.Enabled   := true;
//      BtnAnnuler.enabled     := true;
//      Annuler1.Enabled       := true;
//    end;
  end;
end;

procedure TTrame.initBooleen(selection : integer);
begin
  case selection of
  1: //initialisation (tout à faux) ou insertion
    begin
      modif     := false;
      ajout     := false;
    end;
  2: //nouvelle trame
    begin
      modif     := false;
      ajout     := true;
    end;
  4: // modification
    begin
      modif     := true;
      ajout     := false;
    end;
  end;// fin cas
  trameEnrg := false;
  ligneEnrg := false;
  SLigne    := false;
end;

//******************  affichages par défaut/divers           *******************
procedure TTrame.RemplirChamps;
//renseigne en fonction de la trame
begin
  Edit_PMTiers.Text := SortirCar(DMTrame.Tableau[0],'+');
  Edit_PMJournal.Text := DMTrame.Tableau[3];
  Edit2.Text := DMTrame.Tableau[5];
  Edit_PMCode.Text := DMTrame.Tableau[1];
  Edit_PMNom.Text := DMTrame.Tableau[2];
  Edit_PMBanque.Text := DMTrame.Tableau[4];
end;

procedure TTrame.RemplirParDefaut;
//le tiers existe: on affiche le libellé et le code trame par défaut
begin
  DMTrame.chercherlibDefaut(DMTrame.tiers);
  Edit_PMCode.Text := DMTrame.CodeTrame;
  Edit_PMNom.Text :=  DMTrame.LibelleCodeTrame;
end;

function maj(chaine:string): string;
var
  i: integer;
begin
  for i := 0 to length(chaine) do
    chaine[i] := upcase(chaine[i]);
  result := chaine;
end;

function SortirCar(chaine,car:string): string;
begin
  result:='';
  if pos(car,chaine) <> 0 then
    delete(chaine,1,1);
  result := chaine; 
end;

procedure TTrame.viderChamps;
begin
  Edit_PMTiers.Text := '';
  Edit_PMJournal.Text := '';
  Edit2.Text := '';
  Edit_PMCode.Text := '';
  Edit_PMNom.Text := '';
  Edit_PMBanque.Text := '';
end;

procedure TTrame.ChampsAccessibles;
begin
  Edit_PMTiers.Enabled := true;
  Edit_PMJournal.Enabled := true;
  Edit2.Enabled := true;
  Edit_PMCode.Enabled := true;
  Edit_PMNom.Enabled := true;
  Edit_PMBanque.Enabled := true;
end;

procedure TTrame.champsNonAccessibles;
begin
  Edit_PMTiers.Enabled := false;
  Edit_PMJournal.Enabled := false;
  Edit2.Enabled := false;
  Edit_PMCode.Enabled := false;
  Edit_PMNom.Enabled := false;
  Edit_PMBanque.Enabled := false;
end;

//*****************************************************************************
//            vérification des saisies dans les champs
//               et vérifications de validation
//*****************************************************************************
function TTrame.validation : boolean;
begin
  result := false;
  if  (Edit_PMJournal.Text <> '') then
     result := true;
end;

function TTrame.ChampsVides : boolean;
begin
  result := false;
  if ((Edit_PMTiers.Text = '') and  (Edit_PMJournal.Text = '')and
      (Edit2.Text = '')and (Edit_PMCode.Text = '')and
      (Edit_PMNom.Text = '')and (Edit_PMBanque.Text = '')) then
    result := true;
end;

procedure TTrame.Edit_PMTiersEnter(Sender: TObject);
begin
  T:=true;
//  BtnAnnuler.enabled:= true;
end;

procedure TTrame.Edit_PMCodeEnter(Sender: TObject);
begin
  T:=true;
//  BtnAnnuler.enabled:= true;
end;

procedure TTrame.Edit_PMNomEnter(Sender: TObject);
begin
  T:=true;
//  BtnAnnuler.enabled:= true;
end;

procedure TTrame.Edit_PMJournalEnter(Sender: TObject);
begin
  T:=true;
//  BtnAnnuler.enabled:= true;
end;

procedure TTrame.Edit_PMBanqueEnter(Sender: TObject);
begin
  T:=true;
//  BtnAnnuler.enabled:= true;
end;

procedure TTrame.Edit_PMTiersExit(Sender: TObject);
begin
  if Edit_PMTiers.text <>'' then
    VerifSaisieTiers;
end;

procedure TTrame.Edit_PMBanqueExit(Sender: TObject);
begin
  if Edit_PMBanque.text <>'' then
    VerifSaisieBanque;
end;

procedure TTrame.Edit_PMJournalExit(Sender: TObject);
begin
  if Edit_PMJournal.text <>'' then
    VerifSaisieJournal;
end;

procedure TTrame.VerifSaisieTiers;
begin
  DMTrame.tiers := Edit1.text + SortirCar(Edit_PMTiers.text,'+');
  if not DMTrame.verifierTiers(DMTrame.tiers)then
  begin
    Edit_PMTiers.Text := '';
    Edit_PMTiers.setfocus; 
    exit;
  end;
  if modif = true then rempli := true;
  if Rempli = false then
  begin
    RemplirParDefaut;
    rempli := true;
  end; 
end;

procedure TTrame.VerifSaisieJournal;
var
  codeJournal: string;
begin
  if Edit_PMJournal.text='' then
  begin
    Application.Messagebox(Pchar('Voulez-vous le créer ?'),'code journal obligatoire !',MB_YesNo);
    Edit_PMJournal.text := '';
    Edit_PMJournal.setfocus;
  end
  else
  begin
    codeJournal:= maj(Edit_PMJournal.text);
    if not DMTrame.verifierJournal(codeJournal)then
    begin
      Edit_PMJournal.text := '';
      Edit_PMJournal.setfocus;
    end
    else
    begin
      Edit2.text:= DMTrame.oper;
      Edit_PMJournal.text:=DMTrame.journal;
    end;
  end;
end;

procedure TTrame.VerifSaisieBanque;
begin
  if not DMTrame.verifierBanque(Edit_PMBanque.text)then
  begin
    Edit_PMBanque.Text := '';
    Edit_PMBanque.setfocus;
  end;
end;

//*****************************************************************************
//                 sortie des champs de saisie  trame
//*****************************************************************************
procedure TTrame.Panel1Exit(Sender: TObject);
begin
  if activecontrol.name<>'BtnAnnuler'  then
  begin
    DMTrame.TaTrame.AfterScroll := Nil;
    DMTrame.TaTrameL.AfterScroll := Nil;
    if (ChampsVides = false) then
    begin
      if  validation then
      begin
        if TrameEnrg = false then
        begin
          BtnEnregistrerClick(self);
        end;
      end
      else
      begin
      VerifSaisieTiers;
      VerifSaisieJournal;
      VerifSaisieBanque;
      end;
    end
    else
    begin
      DMTrame.TaTrame.Cancel;
      DMTrame.TaTrameL.Cancel;
      initialisation;
    end;
    T:= false;
  end;
end;

//*************************************************************************
//                   grille : lignes
//*************************************************************************
procedure TTrame.ExDBGTrameLColExit(Sender: TObject);
//appel à la fontion de vérification (module)
begin    
    if DMTrame.verifLigne(ExDBGTrameL.SelectedField).retour=false then
    DMTrame.TraitementVerifLigne; //traitement si besoin
end;

//******************************************************************************
//             évènements grille trame et lignes
//******************************************************************************
procedure TTrame.ExDBGTrameLEnter(Sender: TObject);
begin
  SLigne := true;
  TrameEnrg := true;
  btnSupr.Caption := 'Supprimer Ligne';
  ExDBGTrameL.SelectedIndex := 0;
  ExDBGTrameL.SetFocus;
end;

procedure TTrame.ExDBGTrameLExit(Sender: TObject);
begin
//if activecontrol.name='PopUpMenu1' then
//    DMTrame.DaTrameL.OnStateChange:= nil;
end;

procedure TTrame.ExDBGTrameEnter(Sender: TObject);
begin
  btnSupr.Caption := 'Supprimer Trame';
  SLigne := false;
  initBooleen(1);
  initialisation;
  DMTrame.TaTrame.AfterScroll := DMTrame.TaTrameAfterScroll;
  DMTrame.TaTrameL.AfterScroll := DMTrame.TaTrameLAfterScroll;
end;

//******************************************************************************
//                     procedures / boutons
//******************************************************************************
procedure TTrame.nouvelleTrame;
begin
  DMTrame.TaTrame.AfterScroll := Nil;
  DMTrame.TaTrameL.AfterScroll := Nil;
  initBooleen(2);
  viderChamps;
  ChampsAccessibles;
  Edit_PMTiers.Setfocus;
  ExDBGTrame.Enabled := true;
  DMTrame.TaTrame.append ;
  DMTrame.TaTrame.AfterScroll := DMTrame.TaTrameAfterScroll;
  DMTrame.TaTrameL.AfterScroll:= DMTrame.TaTrameLAfterScroll;
end;

procedure TTrame.inserer;
begin
  initialisation;
  initBooleen(1);
  DMTrame.TaTrameL.AfterScroll := nil;
  DMTrame.TaTrameL.insert;
  ExDBGTrameL.SelectedIndex := 0;
  ExDBGTrameL.SetFocus;
  DMTrame.TaTrameL.AfterScroll:= DMTrame.TaTrameLAfterScroll;
end;

procedure TTrame.enregistrer;
begin
  DMTrame.TaTrame.AfterScroll := Nil;
  DMTrame.TaTrameL.AfterScroll := Nil;
  DMTrame.TaTrameL.BeforeScroll := Nil;
//*************************trame pas enregistrée********************************
  if DMTrame.TaTrame.State in [dsInsert,dsEdit] then
  begin
  DMTrame.TaTrame.post;
  DMTrame.TaTrame.FlushBuffers;
  Rempli := false;
  champsNonAccessibles;
  if ajout = true then
    DMTrame.TaTrameL.append;
  end
  else
//******************************enregistrement des lignes***********************
  begin
    if DMTrame.TaTrameL.State in [dsInsert,dsEdit] then
     begin
      DMTrame.TaTrameL.post;
      DMTrame.TaTrameL.FlushBuffers;
     end;
  end;
//**********************************fin lignes*********************************
  ExDBGTrame.Enabled := true;
  DMTrame.TaTrame.AfterScroll := DMTrame.TaTrameAfterScroll;
  DMTrame.TaTrameL.AfterScroll := DMTrame.TaTrameLAfterScroll;
  DMTrame.TaTrameL.BeforeScroll :=DMTrame.TaTrameLBeforeScroll;
  ExDBGTrameL.SelectedIndex := 0;
  ExDBGTrameL.SetFocus; 
end;

procedure TTrame.modifier;
begin
  DMTrame.TaTrame.AfterScroll := Nil;
  DMTrame.TaTrameL.AfterScroll := Nil;
  initBooleen(4);
  DMTrame.TaTrame.Edit ;
  ChampsAccessibles;
  Edit_PMTiers.Setfocus;       
  DMTrame.TaTrame.AfterScroll := DMTrame.TaTrameAfterScroll;
  DMTrame.TaTrameL.AfterScroll:= DMTrame.TaTrameLAfterScroll;
end;

procedure TTrame.supprimer;
var ligne: integer;
begin
  DMTrame.TaTrame.AfterScroll := Nil;
  DMTrame.TaTrameL.AfterScroll := Nil;
  modif     := false;
  ajout     := false;
  if SLigne = true then
  begin
    if DMTrame.ligne <> 0 then
     begin
      DMTrame.TaTrameL.delete;
      DMTrame.TaTrameL.FlushBuffers;
     end;
  end
  else
  begin
    while ((DMTrame.TaTrameL.FieldByName('ID_Trame').asInteger = DMTrame.id_trame)and
            (DMTrame.TaTrameL.FieldByName('ID_Trame').asInteger<>0)) do
      begin
        ligne := DMTrame.TaTrameL.fieldbyname('Ligne').asinteger;
        if ligne <> 0 then
         begin
          DMTrame.TaTrameL.delete;
          DMTrame.TaTrameL.FlushBuffers;
         end;
      end;
    DMTrame.TaTrame.delete;
    DMTrame.TaTrame.FlushBuffers;
  end;
  DMTrame.TaTrame.AfterScroll := DMTrame.TaTrameAfterScroll;
  DMTrame.TaTrameL.AfterScroll:= DMTrame.TaTrameLAfterScroll;  
  ExDBGTrame.enabled := true;
  initialisation; 
end;

procedure TTrame.BtnNewClick(Sender: TObject);
begin
  nouvelleTrame;
//  BtnAnnuler.enabled:= true;
end;

procedure TTrame.BtnInsererClick(Sender: TObject);
begin
  inserer;
//  BtnAnnuler.enabled:= true;
end;

procedure TTrame.BtnEnregistrerClick(Sender: TObject);
begin
  enregistrer;
end;

procedure TTrame.BtnFermerClick(Sender: TObject);
begin
  close ;
end;

procedure TTrame.BtnModifierClick(Sender: TObject);
begin
  modifier;
//  BtnAnnuler.enabled:= true;
end;

procedure TTrame.BtnSuprClick(Sender: TObject);
begin
  supprimer;
end;

//**************************************************************************************
//                                fermeture
//**************************************************************************************
procedure TTrame.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DMTrame.TaTrame.State in [dsInsert,dsEdit] then
    if MessageDlg('Voulez-vous enregistrer?',mtConfirmation,[mbYes, mbNo],0) = mrYes then
    begin
      DMTrame.TaTrame.post;
      DMTrame.TaTrame.FlushBuffers;
    end
    else
      DMTrame.TaTrame.Cancel;
  if DMTrame.TaTrameL.State in [dsInsert,dsEdit]then
    if MessageDlg('Voulez-vous enregistrer?',mtConfirmation,[mbYes, mbNo],0) = mrYes then
     begin
       DMTrame.TaTrameL.post;
       DMTrame.TaTrameL.FlushBuffers;
     end
    else
      DMTrame.TaTrameL.Cancel;
end;

procedure TTrame.Annuler1Click(Sender: TObject); // annule la saisie en cours
begin
  DMTrame.TaTrameL.BeforeScroll := nil;
  DMTrame.TaTrameL.AfterScroll := nil;
//  if T = true then  // on est en saisie trame
  if DMTrame.TaTrame.state = dsInsert then
  begin
    viderChamps;
    edit_pmTiers.setfocus;
    Rempli:= false;
    T:=false;
  end;
  if DMTrame.TaTrame.state = dsEdit then
    RemplirChamps;
  if DMTrame.TaTrameL.state in [dsEdit,dsInsert] then //on est sur les lignes
  begin
    DMTrame.TaTrameL.Cancel;
    ExDBGTrameL.SelectedIndex := 0;
    ExDBGTrameL.SetFocus;
  end;
  DMTrame.TaTrameL.BeforeScroll := DMTrame.TaTrameLBeforeScroll;
  DMTrame.TaTrameL.AfterScroll := DMTrame.TaTrameLAfterScroll;
end;
//*****************************************************************************************
//                          touches de raccourci (popup menu)
//*****************************************************************************************
procedure TTrame.Nouveau1Click(Sender: TObject);
begin
  nouvelleTrame;
end;

procedure TTrame.Inserer1Click(Sender: TObject);
begin
  inserer;
end;

procedure TTrame.Modifier1Click(Sender: TObject);
begin
  if SLigne = false then
    modifier;
end;

procedure TTrame.Enregistrer1Click(Sender: TObject);
begin
    enregistrer;
end;

procedure TTrame.Supprimer1Click(Sender: TObject);
begin
  supprimer;
end;

procedure TTrame.Fermer1Click(Sender: TObject);
begin
  BtnFermerClick(self);
end;


procedure TTrame.BtnAnnulerClick(Sender: TObject);
begin
   Annuler1Click(self);
end;


procedure TTrame.PopupMenu1Popup(Sender: TObject);
begin
  DMTrame.DaTrameStateChange(self);
  DMTrame.DaTrameLStateChange(self);
end;

procedure TTrame.ExDBGTrameLKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//showmessage(inttostr(key));
  sLigne := true; 
  if DMTrame.TaTrameL.State in [dsinsert,dsedit] then
  begin
    if key in [27] then
    begin
      Annuler1Click(self);
    end;
  end;
  if key = VK_RETURN then
  begin
    if ExDBGTrameL.SelectedIndex<>ExDBGTrameL.ColCount-2 then
       ExDBGTrameL.SelectedIndex := ExDBGTrameL.SelectedIndex+1
    else
    begin
      enregistrer;
      ExDBGTrameL.row := ExDBGTrameL.row+1;
      // voir si fin table mettre en insert...
    end;
  end;
end;

procedure TTrame.SpeedButton1Click(Sender: TObject);
begin
 If (FPrint = nil) then FPrint:=TFPrint.Create(self);
  FPrint.SelectionEtat:=1;
  FPrint.show;
end;

Procedure TTrame.InitialiseTable_A_Nil;
Begin
  DMTrame.TaTrame.AfterScroll := Nil;
  DMTrame.TaTrameL.AfterScroll := Nil;
  DMTrame.DaTrameL.onStateChange:= nil;
  DMTrame.DaTrame.onStateChange:= nil;
End;

procedure TTrame.FormDestroy(Sender: TObject);
begin
  DestroyForm(self,E.User);
  Trame:=nil;
end;

end.
