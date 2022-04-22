unit E2_DepensesEntreprise;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Gr_Librairie_obj, E2_Librairie_obj, Grids, DBGrids, Db, Gr_MiseAJourBalance,
  DBTables, E2_AideCompte, LibSQL, Menus, Buttons, DBCtrls,DMDepenses,
  RXDBCtrl, ExRxDBGrid,Registry,AideMontant2,DMTVA,DMPlanCpt, RXCtrls,
  GrDBGrid,E2_AssistantClotureDef,LibZoneSaisie,DMEcriture,E2_Decl_Records,
  E2_Cloture_Def,
  DMConstantes,
  LibGestionParamXML,
  lib_chaine,
  jpeg;

type
  TDepensesEntreprise = class(TForm)
    Patitre: TPanel;
    PaBas: TPanel;
    SBEntreprise: TRxSpeedButton;
    SBPrive: TRxSpeedButton;
    PaLabel: TPanel;
    PaGrille: TPanel;
    PaTitreD: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    PaTitreG: TPanel;
    Label1: TLabel;
    NumCpt: TEdit;
    Label2: TLabel;
    DBGridDepense: TGrDBGrid;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
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
    Precdant1: TMenuItem;
    Suivant1: TMenuItem;
    RxSpeedButton3: TRxSpeedButton;
    RxSpeedButton2: TRxSpeedButton;
    RxSpeedButton1: TRxSpeedButton;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaTools: TPanel;
    RxSpeedButton4: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure EnregistrementAutomatique;
    procedure changementEtatBoutons(Sender: TObject);
    procedure ChangementEtatGrille(Sender: TObject);
    procedure DBGridDepenseColExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure GestionSelectionCompte(compte:tedit;texte:boolean);
    procedure GestionBoutonsSpeed;
    procedure SBEntrepriseClick(Sender: TObject);
    procedure NumCptExit(Sender: TObject);
    procedure RxSpeedButton1Click(Sender: TObject);
    procedure RxSpeedButton2Click(Sender: TObject);
    procedure PatitreResize(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    Procedure AppelAideCompte(Grille:boolean);
    procedure TraitementAideTVA;
    procedure DBGridDepenseColEnter(Sender: TObject);
    procedure NumCptKeyPress(Sender: TObject; var Key: Char);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure RxSpeedButton3Click(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  DepensesEntreprise: TDepensesEntreprise;
  Mark: TBookMark;
  TmpMontant: Currency;
  LastSize:integer;
  SpeedButtonDown:TComponentName;
  CompteParDefaut:string;
  MessDerSub:boolean;
  DernierCompte:string;
implementation

uses E2_RepriseChargeAPayer2_Isa,E2_Main,E2_Recherche, DMRecherche;

{$R *.DFM}



procedure TDepensesEntreprise.GestionBoutonsSpeed;
var
   Colonne: TColumn;
   I,J: Integer;
begin
if SBEntreprise.Down=true then
     begin
      Self.Caption := 'Dépenses de l''Entreprise';
      if DBGridDepense.FieldCount<6 then
           begin
           Colonne := DBGridDepense.Columns.Add;
           Colonne.FieldName := 'TVA';
           Colonne.Title.Caption := 'TVA';
           end;
     DBGridDepense.Width := 570;
     DBGridDepense.Left := 40;
     end
     else
        begin
        Self.Caption := 'Dépenses du Privé';
          if DBGridDepense.FieldCount>5 then
            begin
            DBGridDepense.Columns[5].Free;// la dernière
            DBGridDepense.Width := 470;
            DBGridDepense.Left := 60;
            end;
        end;
Label4.Caption := DateToStr(E.DatExoFin);
end;



//****************************************************************************//
// Gestion du Show de la fenêtre.                                             //
//****************************************************************************//
procedure TDepensesEntreprise.FormShow(Sender: TObject);
begin
  DBGridDepense.Color := clWindow;
  DBGridDepense.SelectedIndex := 1;
    Mark := Nil;
GestionBoutonsSpeed;
if SBEntreprise.Down
 then tag:=1
 else
    tag:=2;
 case self.tag of
    1:begin
       DBGridDepense.ColWidths[1]:=(DBGridDepense.Width) div 7;
       DBGridDepense.ColWidths[2]:=(DBGridDepense.Width) div 8;
       DBGridDepense.ColWidths[3]:=(DBGridDepense.Width) div 3;
       DBGridDepense.ColWidths[4]:=(DBGridDepense.Width) div 13;
       DBGridDepense.ColWidths[5]:=(DBGridDepense.Width) div 6;
      end;
    2:Begin
       DBGridDepense.ColWidths[1]:=(DBGridDepense.Width) div 7;
       DBGridDepense.ColWidths[2]:=(DBGridDepense.Width) div 8;
       DBGridDepense.ColWidths[3]:=(DBGridDepense.Width) div 3;
       DBGridDepense.ColWidths[4]:=(DBGridDepense.Width) div 13;
       DBGridDepense.ColWidths[5]:=(DBGridDepense.Width) div 6;
       DBGridDepense.ColWidths[6]:=(DBGridDepense.Width) div 6;
      End;
 end;
DMDepenseEnt.tag:=self.Tag;
  DMDepenseEnt.DataDepense.OnStateChange:=changementEtatBoutons;
  DMDepenseEnt.DataDepense.OnStateChange(DMDepenseEnt.TaDepense);
end;
//****************************************************************************//





//****************************************************************************//
// Gestion de la création de la fenêtre.                                      //
//****************************************************************************//
procedure TDepensesEntreprise.FormCreate(Sender: TObject);
Var
	Registre :TRegistry;
Begin
 if DMDepenseEnt=nil then
 DMDepenseEnt:=TDMDepenseEnt.Create(self);

CompteParDefaut:='';
 if AideCompte=nil then
 AideCompte:=TAideCompte.Create(self);

  	Registre:= TRegistry.Create;

   try
	   with Registre do
           begin
	      RootKey := HKEY_LOCAL_MACHINE;

         OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, false);
            try
              SBEntreprise.down:=ReadBool('SBEntreprise');
              SBPrive.down:=ReadBool('SBPrive');
              NumCpt.Text:=ReadString('NumCpt');
              label2.Caption:=ReadString('label4');
            except
              SBEntreprise.down:=true;
              SBPrive.down:=false;
              NumCpt.Text:='';
              label2.Caption:='';
            end;
         end;
   finally
		Registre.Free;
   end;
     SBEntreprise.Tag:=1;
     SBPrive.Tag:=2;
     if SBEntreprise.Down then
     SpeedButtonDown:=SBEntreprise.Name
     else
     SpeedButtonDown:=SBPrive.Name;
     CompteParDefaut:=NumCpt.Text;
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poDesigned;
        InitialiseFormPosDefaut(self);
	//Left:= 0; Top:= 70; Width:= screen.Width; Height:= screen.Height-top;
    end;
 LastSize:=0;
 MessDerSub:=true;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click sur le bouton Insérer.                                    //
//****************************************************************************//
procedure TDepensesEntreprise.BtnInsererClick(Sender: TObject);
begin
TableAjoute(DMDepenseEnt.TaDepense);
end;
//****************************************************************************//



//****************************************************************************//
// Gestion des touches dans la fenêtre.                                       //
//****************************************************************************//
procedure TDepensesEntreprise.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     // Si appui sur la touche ESC
     If Key = VK_ESCAPE Then
     Begin
          // Si l'utilisateur est en mode Insertion
          If DMDepenseEnt.TaDepense.State = dsInsert Then
          Begin
               If Messagedlg('Annuler la création de cette dépense de l''entreprise ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    DMDepenseEnt.TaDepense.Cancel;

                    Abort;
               End
               Else
               Begin
                    Abort;
               End;
          End; // Fin utilisateur est en mode Insertion
          // Si l'utilisateur est en mode Modification
          If DMDepenseEnt.TaDepense.State = dsEdit Then
          Begin
               If Messagedlg('Annuler les modifications de cette dépense de l''entreprise',MtConfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    DMDepenseEnt.TaDepense.Cancel;
//                    ModificationOk := False;

                    DBGridDepense.SelectedIndex := 2;
                    DBGridDepense.SelectedIndex := 1;
                    Abort;
               End
               Else
               Begin
                    Abort;
               End;
          End; // Fin utilisateur est en mode Modification

          If DMDepenseEnt.TaDepense.State = dsBrowse Then
             Self.Close;
     End; // Fin appui sur la touche ESC
end;
//****************************************************************************//


//****************************************************************************//
// Libération de la mémoire.                                                  //
//****************************************************************************//
Procedure TDepensesEntreprise.InitialiseTable_A_Nil;
Begin
  if DMDepenseEnt<>nil then
  InitDatasetEvent_A_Nil_Sur_Form([DMDepenseEnt.DataDepense]);
End;

procedure TDepensesEntreprise.FormDestroy(Sender: TObject);
     Var
	Registre :TRegistry;
Begin
      Registre:= TRegistry.Create;

      try
       InitialiseTable_A_Nil;
         with Registre do begin
            RootKey := HKEY_LOCAL_MACHINE;

            OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, True);
            WriteBool('SBEntreprise',SBEntreprise.down);
            WriteBool('SBPrive',SBPrive.down);
            WriteString('NumCpt',NumCpt.Text);
            WriteString('label2',label2.Caption);
            CloseKey;
         end;
      finally
         Registre.Free;
      end;
//   End;
     LibGestionParamXML.DestroyForm(Self,E.USer);
     DMDepenseEnt.free;
     DepensesEntreprise := Nil;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click sur le bouton Enregistrer.                                //
//****************************************************************************//
procedure TDepensesEntreprise.BtnFermerClick(Sender: TObject);
begin
     Self.Close;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click sur le bouton Enregistrer.                                //
//****************************************************************************//
procedure TDepensesEntreprise.BtnEnregistrerClick(Sender: TObject);
begin
  try
     EnregistrementAutomatique;
  except
  abort;
  end;//fin du try
end;
//****************************************************************************//

procedure TDepensesEntreprise.EnregistrementAutomatique;
begin
if DMDepenseEnt.TaDepense.State in [dsinsert,dsEdit] then
  try
  TableGerePost(DMDepenseEnt.TaDepense);
  except
  abort;
  end;//fin du try
end;



//****************************************************************************//
// Gestion du click sur le bouton Modifier.                                   //
//****************************************************************************//
procedure TDepensesEntreprise.BtnModifierClick(Sender: TObject);
begin
DMDepenseEnt.TaDepense.Edit;
end;
//****************************************************************************//




//************************************************************************************
procedure TDepensesEntreprise.changementEtatBoutons(Sender: TObject);
begin
  case DMDepenseEnt.TaDepense.state of
   dsBrowse: begin
               BtnInserer.Enabled := True;
               BtnEnregistrer.Enabled := False;
               BtnModifier.Enabled := Not(DMDepenseEnt.TaDepense.RecordCount = 0);
               BtnSupprimer.Enabled := Not(DMDepenseEnt.TaDepense.RecordCount = 0);
               BtnImprimer.Enabled:=true;
               SBEntreprise.Enabled := True;
               SBPrive.Enabled := True;
             end;

   dsEdit:   begin
               BtnInserer.Enabled := False;
               BtnEnregistrer.Enabled := True;
               BtnModifier.Enabled :=false;
               BtnSupprimer.Enabled := false;
               BtnImprimer.Enabled:=false;
               SBEntreprise.Enabled := False;
               SBPrive.Enabled := False;
             end;

   dsInsert: begin
               BtnInserer.Enabled := False;
               BtnEnregistrer.Enabled := False;
               BtnModifier.Enabled := False;
               BtnSupprimer.Enabled := False;
               BtnImprimer.Enabled:=false;
               SBEntreprise.Enabled := False;
               SBPrive.Enabled := False;
             end;
   end;//fin du case.state$
   Fermer1.Enabled:=BtnFermer.Enabled;
   Insrer1.Enabled:=BtnInserer.Enabled;
   Enregister1.Enabled:=BtnEnregistrer.Enabled;
   Modifier1.Enabled:=BtnModifier.Enabled;
   Supprimer1.Enabled:=BtnSupprimer.Enabled;
   Imprimer1.Enabled:=BtnImprimer.Enabled;
   ChangementEtatGrille(DMDepenseEnt.TaDepense);
end;

procedure TDepensesEntreprise.ChangementEtatGrille(Sender: TObject);
begin
   case DMDepenseEnt.TaDepense.state of
   dsBrowse: begin
               DBGridDepense.Options := [dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               DBGridDepense.SelectedIndex := 1;
               DBGridDepense.SetFocus;
             end;

   dsEdit:   begin
               DBGridDepense.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               DBGridDepense.SetFocus;
             end;

   dsInsert: begin
               DBGridDepense.Options := [dgediting,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               DBGridDepense.SelectedIndex := 1;
               DBGridDepense.SetFocus;

             end;
   end;//fin du case.state
end;


procedure TDepensesEntreprise.BtnSupprimerClick(Sender: TObject);
begin

   try
   TableGereDelete(DMDepenseEnt.TaDepense);
   except
      abort;
   end;
end;


procedure TDepensesEntreprise.DBGridDepenseColExit(Sender: TObject);
var
controleSaisie:TErreurSaisie;
begin
      if DBGridDepense.DataSource.State in [dsinsert,dsEdit] then
      begin // si table en insertion ou modif
      controleSaisie:=DMDepenseEnt.CtrlSaisieDepenses(DBGridDepense.SelectedField);
         if controleSaisie.Retour=false then
           case controleSaisie.CodeErreur of
           8101,8100:begin
                  DBGridDepense.SelectedIndex:=1;
                  abort;//champ code emprunt
                end;
           5100:begin
                  DBGridDepense.SelectedIndex:=4;
                  abort;//champ code emprunt
                end;
           end;//fin du case
      if DBGridDepense.SelectedIndex=1 then
      BtnEnregistrer.Enabled:=true;
      end;//fin si table en insertion ou modif
end;


procedure TDepensesEntreprise.GestionSelectionCompte(compte:tedit;texte:boolean);
var
cpt:string;
begin
//DMPlan.FiltrageAideCompte(16,nil,nil);
AideCompte.FiltrageAideCompte(16);
if not(empty(compte.text)) then
begin
cpt:=compte.Text+'0';
   if AideCompteExiste(compte.Text,nil) then
       begin//si le compte existe
          while length(cpt)>0 do
          begin //debut du while
          delete(cpt,length(cpt),1);
            if DMPlan.TaParamCpt.Locate('Rac1',cpt,[]) then
            begin //si on trouve la racine dans paramcpt
               while DMPlan.PossedeFils(compte.Text)do
               begin
                   AideCompteAffiche(compte,True,False,True,True,0);
               end;
            DMDepenseEnt.FiltrageAffichageGrille(self.tag);
            abort;
            end //fin si on trouve la racine dans paramcpt
            else
            begin
           MessageDlg('Vous n'+#39+'avez pas utilisé la dernière subdivision,'+#13+#10+'vous devez resélectionner un compte',mtError,[],0);            end;
           AideCompteAffiche(compte,True,False,True,True,0);
           DMDepenseEnt.FiltrageAffichageGrille(self.tag);
           abort;
          end;//fin du while
          Application.MessageBox(Pchar('Ce compte n''est pas prévu dans ce contexte.'),'Erreur de saisie',0);
          //erreur('GrPlan','NonPrevuContext');
          AideCompteAffiche(compte,True,False,True,True,0);
       end//fin de compte Existe
       else
       begin //si le compte n'existe pas
          while length(cpt)>0 do
          begin //début du while
          delete(cpt,length(cpt),1);
          DeFiltrageDataSet(DMRech.TaPlanCptRech);
          if DMRech.TaPlanCptRech.Locate('Compte',cpt,[]) then
            if AideCompteExiste(compte.text,nil) then
            //si le père existe dans aideCompte
            begin
            DMPlan.DemandeCreation(compte.Text,compte,true);
            DMDepenseEnt.FiltrageAffichageGrille(self.tag);
            abort;
            end;
          end; //fin du while
          Application.MessageBox(Pchar('Ce compte n''est pas prévu dans ce contexte.'),'Erreur de saisie',0);
//          erreur('GrPlan','NonPrevuContext');
          AideCompteAffiche(compte,True,False,True,True,0);
          DMDepenseEnt.FiltrageAffichageGrille(self.tag);
          abort;
       end;// fin si compte n'existe pas
   end//fin de edit numcpt rempli
   else
   begin//si edit numcpt vide
   if texte=true then
          Application.MessageBox(Pchar('Le compte est obligatoire.'),'Erreur de saisie',0);
   AideCompteAffiche(compte,True,False,True,True,0);
   end;//fin edit numcpt vide
end;


procedure TDepensesEntreprise.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
//DMPlan.TaCompte.OnFilterRecord:=nil;
if not NumCpt.Focused and empty(NumCpt.Text) then
    begin
    GestionSelectionCompte(numcpt,true);
    AideCompteAffiche(NumCpt,True,False,True,True,0);    
    end;

DeFiltrageDataSet(DMRech.TaPlanCptRech);
if DMRech.TaPlanCptRech.Locate('Compte',numcpt.text,[]) then
Label2.Caption:=DMRech.TaPlanCptRech.findfield('Libelle').AsString;
if SBEntreprise.Down then
tag:=1
else
tag:=2;
DMDepenseEnt.tag:=self.Tag;
DMDepenseEnt.FiltrageAffichageGrille(self.tag);
DMDepenseEnt.CompteExploitant:= NumCpt.Text;
end;

procedure TDepensesEntreprise.SBEntrepriseClick(Sender: TObject);
begin
// Initialisation des SpeedsBoutons
if ((Sender as TRxSpeedButton).Name<>SpeedButtonDown) then
     begin
        
        numcpt.Text:='';
        numcpt.setfocus;
        AideCompteDansContexte(NumCpt.text,NumCpt,['Rac1'],false,MessDerSub,true,true,false,true,0);
//        GestionSelectionCompte(numcpt,false);
//        while empty(numcpt.text)do
         if empty(numcpt.text)then
         Begin
         NumCpt.Text:=DernierCompte;
         abort;
         End
         else
         Begin
           if AideCompteDansContexte(NumCpt.text,NumCpt,['Rac1'],false,MessDerSub,true,true,false,true,0)=true then
//             if AideCompteExiste(NumCpt.text,nil)then
             begin
             GestionBoutonsSpeed;
             tag:=0;
             tag:=(Sender as TRxSpeedButton).tag;
             DMDepenseEnt.tag:=self.Tag;
             DMDepenseEnt.FiltrageAffichageGrille(self.tag);
             Mark := Nil;
             DMDepenseEnt.DataDepense.OnStateChange(DMDepenseEnt.TaDepense);
             end
             else
             Begin
             NumCpt.Text:=DernierCompte;
             abort;
             End;
         End;
     end;
SpeedButtonDown:=(sender as TRxSpeedButton).Name;
MessDerSub:=true;
end;

procedure TDepensesEntreprise.NumCptExit(Sender: TObject);
var
Enregistrement:TEnregistrementComplet;
begin
DernierCompte:='';

if AideCompteDansContexte(NumCpt.text,NumCpt,['Rac1'],false,MessDerSub,true,true,false,true,0)=false then
// abort;
NumCpt.SetFocus
else
 begin
  DMDepenseEnt.FiltrageAffichageGrille(self.Tag);
  Enregistrement:=DmPlanRecupEnregistrementComplet(numcpt.text);
  if enregistrement.CodeRetour then
  Label2.Caption:=enregistrement.Libelle;
  DMDepenseEnt.CompteExploitant:=numcpt.Text;
 end;

//AideCompteDansContexte(NumCpt.text,NumCpt,['Rac1']);
////GestionSelectionCompte(numcpt,true);
//
//  if not empty(numcpt.Text)then
//  begin
//    if AideCompteExiste(numcpt.Text,nil) then
//       begin
//       DMDepenseEnt.FiltrageAffichageGrille(self.tag);
//       if DMPlan.TaPlanCpt.Locate('Compte',numcpt.text,[]) then
//       Label2.Caption:=dmplan.TaPlanCpt.findfield('Libelle').AsString;
//       DMDepenseEnt.CompteExploitant:=numcpt.Text;
//
//       end
//       else
//       begin
//       numcpt.SetFocus;
//       abort;
//       end;
//  end
//  else
//    Begin
//    NumCpt.SetFocus;
//    abort;
//    End;
DernierCompte:=NumCpt.Text;
end;

procedure TDepensesEntreprise.RxSpeedButton1Click(Sender: TObject);
begin
Main.Provisions2Click(Main.Provisions2);
end;

procedure TDepensesEntreprise.RxSpeedButton2Click(Sender: TObject);
begin
Main.Chargesrpartir2Click(Main.Chargesrpartir2);
end;

procedure TDepensesEntreprise.PatitreResize(Sender: TObject);
begin
//RxSpeedButton1.top:=13;
RxSpeedButton1.Left:=Patitre.Width-104;
//RxSpeedButton1.Height:=Patitre.Height-24;

//SBPrive.top:=13;
SBPrive.Left:=Patitre.Width-289;
//SBPrive.Height:=Patitre.Height-24;
end;

procedure TDepensesEntreprise.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
//BtnEnregistrer.Left:=(PaBtn.Width-450) div 2;
//BtnInserer.Left:=BtnEnregistrer.Left+89;
//BtnModifier.Left:=BtnEnregistrer.Left+178;
//BtnSupprimer.Left:=BtnEnregistrer.Left+267;
//BtnFermer.Left:=BtnEnregistrer.Left+356;
end;

procedure TDepensesEntreprise.PaGrilleResize(Sender: TObject);
begin
 case self.tag of
    1:begin
       DBGridDepense.ColWidths[1]:=(DBGridDepense.Width) div 7;
       DBGridDepense.ColWidths[2]:=(DBGridDepense.Width) div 8;
       DBGridDepense.ColWidths[3]:=(DBGridDepense.Width) div 3;
       DBGridDepense.ColWidths[4]:=(DBGridDepense.Width) div 13;
       DBGridDepense.ColWidths[5]:=(DBGridDepense.Width) div 6;
      end;
    2:Begin
       DBGridDepense.ColWidths[1]:=(DBGridDepense.Width) div 7;
       DBGridDepense.ColWidths[2]:=(DBGridDepense.Width) div 8;
       DBGridDepense.ColWidths[3]:=(DBGridDepense.Width) div 3;
       DBGridDepense.ColWidths[4]:=(DBGridDepense.Width) div 13;
       DBGridDepense.ColWidths[5]:=(DBGridDepense.Width) div 6;
       DBGridDepense.ColWidths[5]:=(DBGridDepense.Width) div 6;
      End;
 end;
end;

procedure TDepensesEntreprise.FormResize(Sender: TObject);
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

procedure TDepensesEntreprise.Aide1Click(Sender: TObject);
begin
 If activecontrol = DBGridDepense Then
  begin
   case DBGridDepense.DataSource.State of
      dsinsert,dsedit:case self.tag of
                          1:case DBGridDepense.SelectedIndex of
                                   1:AppelAideCompte(true);
                                   5:if  DBGridDepense.SelectedField.ReadOnly=false then
                                         TraitementAideTVA;
                            end;//fin case selectedindex
                          2:case DBGridDepense.SelectedIndex of
                                   1:AppelAideCompte(true);
                                   5:if  DBGridDepense.SelectedField.ReadOnly=false then
                                         TraitementAideTVA;
                            end;//fin case selectedindex
                      end;//fin du case tag
      dsbrowse:case self.tag of
                  1:case DBGridDepense.SelectedIndex of
                            0:Rechercher(DBGridDepense,DMDepenseent.TaDepense,['Reference','Compte2','Libelle2','ID','Compte','DateSaisie','Sens'],['Références','Compte','Libellé','','','',''],'',0);
                            1:Rechercher(DBGridDepense,DMDepenseent.TaDepense,['Compte2','Libelle2','Reference','ID','Compte','DateSaisie','Sens'],['Compte','Libelle','Références','','','',''],'',0);
                            2:Rechercher(DBGridDepense,DMDepenseent.TaDepense,['Libelle2','Compte2','Reference','ID','Compte','DateSaisie','Sens'],['Libellé','Compte','Références','','','',''],'',0);
                           end;
                  2:case DBGridDepense.SelectedIndex of
                            0:Rechercher(DBGridDepense,DMDepenseent.TaDepense,['Reference','Compte2','Libelle2','ID','Compte','DateSaisie','Sens'],['Références','Compte','Libellé','','','',''],'',0);
                            1:Rechercher(DBGridDepense,DMDepenseent.TaDepense,['Libelle2','Compte2','Reference','ID','Compte','DateSaisie','Sens'],['Libellé','Compte','Références','','','',''],'',0);
                            2:Rechercher(DBGridDepense,DMDepenseent.TaDepense,['Libelle2','Compte2','Reference','Compte2','ID','Compte','DateSaisie','Sens'],['Libellé','Compte','Références','','','',''],'',0);
                    end;
               end;
   end;
 end;
 If activecontrol = NumCpt Then
  begin
   case DMDepenseEnt.DataDepense.State of
      dsbrowse:case self.tag of
                  1: AppelAideCompte(false);

                  2: AppelAideCompte(false);
               end;//fin du case tag
   end;//fin du case state
 end;//fin si activecontrol = numcpt
end;


procedure TDepensesEntreprise.FormDeactivate(Sender: TObject);
begin
// Si utilisateur en mode Insertion
     If DMDepenseEnt.TaDepense.State = dsInsert Then
     Begin
          If BtnEnregistrer.Enabled Then
          Begin
               If Messagedlg('Voulez-vous enregistrer cette dépense de l''entreprise ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                begin
                  TableGerePost(DMDepenseEnt.TaDepense);
                end;
          End
          Else
          Begin
               If Messagedlg(' Voulez-vous annuler la création de cette dépense de l''entreprise ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                  DMDepenseEnt.TaDepense.Cancel
               Else
                  Abort;
          End;
     End; // Fin utilisateur en mode Insertion

     // Si utilisateur en mode modification
     If DMDepenseEnt.TaDepense.State = dsEdit Then
     Begin
          If Messagedlg('Voulez-vous enregistrer les modifications de cette dépense de l''entreprise ?',mtconfirmation,[mbyes,mbno],0) = mryes Then
           begin
             TableGerePost(DMDepenseEnt.TaDepense);
           end;
     End; // Fin utilisateur en mode modification

     DMDepenseEnt.TaDepense.Filtered:=false;
     
     if DMDepenseEnt.FiltragePourAffichageODCloture=true then
        begin//si on a trouvé des Depenses
            try
            DMDepenseEnt.CreationODChargeAPayerCloture;
           except
              begin
              showmessage('Problème à la création des OD ');
       //       DMPieces.TaPiece.Database.Rollback;
              abort;
              end;
           end;
        DMDepenseEnt.DemandeAffichageReprise;
        end;
if empty(NumCpt.Text) then
NumCpt.Text:=CompteParDefaut;
end;


procedure TDepensesEntreprise.AppelAideCompte(Grille:boolean);
begin
if grille then
   begin
   if DBGridDepense.SelectedIndex = 1 then
     begin //si colonne 1 (compte) selectionnée
     DMPlan.FiltrageAideCompteSurCompte(16,numcpt.Text,nil,nil);
     DBGridDepense.EditorMode:=true;
     AideCompteDansContexte(DBGridDepense.InplaceEditor.Text,DBGridDepense.InplaceEditor,['Rac2','Rac3','Rac4','Rac5'],false,MessDerSub,true,true,false,true,0);
     DBGridDepense.Columns[1].Field.AsString:=DBGridDepense.InplaceEditor.Text;
     end;// fin si colonne compte selectionnée
   end
else
   begin
//   DMPlan.FiltrageAideCompte(16,nil,nil);
   AideCompte.FiltrageAideCompte(16);
   AideCompteDansContexte('',NumCpt,['Rac1'],false,MessDerSub,true,true,false,true,0)
   end;
MessDerSub:=true;
end;

procedure TDepensesEntreprise.TraitementAideTVA;
var
resultat:TAideMontantTTC2RetFunction;
Enregistrement:TEnregistrementComplet;
RetourTva:TRecupMiniMaxTva;
begin//si colonne 4 ou 5 selectionnee
        Enregistrement:=DmPlanRecupEnregistrementComplet(DBGridDepense.Columns[1].Field.AsString);
              if Enregistrement.CodeRetour then
                begin//si le compte a été trouvé
                   if not(empty(Enregistrement.TvaCode))then
                   RetourTva:=FTvaRecupMiniMaxTva(Enregistrement.TvaCode);
                end;
        if DBGridDepense.InplaceEditor=nil then  DBGridDepense.InplaceEditor.Create(DBGridDepense);
        if true then
        begin //si editeur deja crée
           DBGridDepense.EditorMode:=true;
           if DBGridDepense.EditorMode then
           begin //si editeur mode =true
              if DBGridDepense.SelectedIndex = 4 then
              begin
              if (empty(DBGridDepense.InplaceEditor.Text))  then
              DBGridDepense.InplaceEditor.Text:='0';
              if StrToFloat_Lgr(DBGridDepense.InplaceEditor.text)=0 then
              DBGridDepense.InplaceEditor.Text:='0';
              if empty(DBGridDepense.Columns[5].Field.Asstring)then
              DBGridDepense.Columns[5].Field.Asinteger:=0;
//                   case retourtva.CodeRetour of
//                   1:resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,DBGridDepense.InplaceEditor,DBGridDepense.Columns[5].Field]);
//                   2:resultat:=AideMontantAffiche([retourtva.Taux_Supp,0,DBGridDepense.InplaceEditor,DBGridDepense.Columns[5].Field]);
//                  12:resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,DBGridDepense.InplaceEditor,DBGridDepense.Columns[5].Field,retourtva.Taux_Supp,0,DBGridDepense.InplaceEditor,DBGridDepense.Columns[5].Field]);
//
//                   end;//fin du case retourTva
              end;
              if DBGridDepense.SelectedIndex = 5 then
              begin
              if empty(DBGridDepense.Columns[4].Field.Asstring)then
              DBGridDepense.Columns[4].Field.Ascurrency:=0;
               if (empty(DBGridDepense.InplaceEditor.Text))  then
              DBGridDepense.InplaceEditor.Text:='0';
              if StrToFloat_Lgr(DBGridDepense.InplaceEditor.text)=0 then
              DBGridDepense.InplaceEditor.Text:='0';
//                case retourtva.CodeRetour of
//                   1:resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,DBGridDepense.Columns[4].Field,DBGridDepense.InplaceEditor]);
//                   2:resultat:=AideMontantAffiche([retourtva.Taux_Supp,0,DBGridDepense.Columns[4].Field,DBGridDepense.InplaceEditor]);
//                  12:resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,DBGridDepense.Columns[4].Field,DBGridDepense.InplaceEditor,retourtva.Taux_Supp,0,DBGridDepense.Columns[4].Field,DBGridDepense.InplaceEditor]);
//                end;//fin du case retourTva
              end;
           end
           else //si editeur mode =false
           begin
           if currtostr(DBGridDepense.Columns[4].Field.Ascurrency)='' then
           DBGridDepense.Columns[4].Field.Ascurrency:=0;
           if inttostr(DBGridDepense.Columns[5].Field.asinteger)='' then
           DBGridDepense.Columns[5].Field.asinteger:=0;
//               case retourtva.CodeRetour of
//                   1:resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,DBGridDepense.Columns[4].Field,DBGridDepense.Columns[5].Field]);
//                   2:resultat:=AideMontantAffiche([retourtva.Taux_Supp,0,DBGridDepense.Columns[4].Field,DBGridDepense.Columns[5].Field]);
//                  12:resultat:=AideMontantAffiche([retourtva.Taux_Inf,retourtva.Taux_Supp,DBGridDepense.Columns[4].Field,DBGridDepense.Columns[5].Field]);
//                end;//fin du case retourTva
           end;
        end // fin si editeur deja crée
        else
        begin //si editeur pas crée
        if currtostr(DBGridDepense.Columns[4].Field.Ascurrency)='' then
        DBGridDepense.Columns[4].Field.Ascurrency:=0;
        if inttostr(DBGridDepense.Columns[5].Field.asinteger)='' then
        DBGridDepense.Columns[5].Field.asinteger:=0;
//                case retourtva.CodeRetour of
//                   1:resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,DBGridDepense.Columns[4].Field,DBGridDepense.Columns[5].Field]);
//                   2:resultat:=AideMontantAffiche([retourtva.Taux_Supp,0,DBGridDepense.Columns[4].Field,DBGridDepense.Columns[5].Field]);
//                  12:resultat:=AideMontantAffiche([retourtva.Taux_Inf,retourtva.Taux_Supp,DBGridDepense.Columns[4].Field,DBGridDepense.Columns[5].Field]);
//                end;//fin du case retourTva
        end;

       if resultat.Retour then
       begin
       DBGridDepense.Columns[4].Field.AsCurrency:=resultat.HT;
       DBGridDepense.Columns[5].Field.AsCurrency:=resultat.TVA;
       end;
End;



procedure TDepensesEntreprise.DBGridDepenseColEnter(Sender: TObject);
begin
if  DBGridDepense.DataSource.State in [dsinsert,dsedit] then
   if  DBGridDepense.SelectedIndex in [3,5] then
     DMDepenseEnt.RecupInfoApresVerif(false);
end;

procedure TDepensesEntreprise.NumCptKeyPress(Sender: TObject;
  var Key: Char);
begin
if not (key in [#48..#57,#13,#8,#9]) then
key:=#0;
if key=#13 then
 begin
   DBGridDepense.SetFocus;
 end;
end;

procedure TDepensesEntreprise.BtnAnnulerClick(Sender: TObject);
begin
//
end;

procedure TDepensesEntreprise.BtnImprimerClick(Sender: TObject);
begin
//
end;

procedure TDepensesEntreprise.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
CanClose:=true;
if CanClose then InitialiseTable_A_Nil{ isa  le  29/01/04 }
 else
 begin
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(self);

 end;
AssistantClotRafraichit(6);
//    if ((Cloture_Def<>nil)and(ActivationForm(Cloture_Def))) then // PB
    
end;

procedure TDepensesEntreprise.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TDepensesEntreprise.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TDepensesEntreprise.RxSpeedButton3Click(Sender: TObject);
begin
DetailEcritureCompte(NumCpt.text,true,False);
end;

procedure TDepensesEntreprise.Visualisation1Click(Sender: TObject);
begin
if ActiveControl = DBGridDepense then
 begin
  if DBGridDepense.SelectedIndex = 1 then
   begin
    if DBGridDepense.InplaceEditor <> nil then
     begin
        if DBGridDepense.InplaceEditor.Visible then
          DetailEcritureCompte(DBGridDepense.InplaceEditor.Text,true,False)
           else
           DetailEcritureCompte(DMDepenseEnt.taDepense.FindField('Compte2').AsString,true,False);
     end
     else
      DetailEcritureCompte(DMDepenseEnt.taDepense.FindField('Compte2').AsString,true,False);
   end
   else DetailEcritureCompte(DMDepenseEnt.taDepense.FindField('Compte2').AsString,true,False);
  end;
if ActiveControl = NumCpt then
   Begin
     DetailEcritureCompte(NumCpt.text,true,False);
   End;
end;

procedure TDepensesEntreprise.Calculatrice1Click(Sender: TObject);
begin
if DBGridDepense.Col in [4,5] then
  AfficheCalculatrice(DBGridDepense)
else
  AfficheCalculatrice(nil);
end;

end.
