unit E2_ChoixReglementAuto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, RXGrids, ExtCtrls, Mask, ToolEdit, RXDBCtrl,
  E2_Decl_Records,
  E2_LibInfosTable,
  E2_AideModel,
  LibDates,
  E2_Librairie_Obj,
  Gr_Librairie_Obj,
  LibZoneSaisie,
  RXCtrls,
  DMRecherche,
  CurrEdit,
  Menus,
  DMConstantes,
  LibGestionParamXML,
  lib_chaine,
  jpeg;

type
  TChoixReglementAuto = class(TForm)
    PaAide: TPanel;
    PaChoix: TPanel;
    BtnRefLigne: TButton;
    BtnTiersNonDetaille: TButton;
    BtnRemiseCheque: TButton;
    PaDescription: TPanel;
    Label1: TLabel;
    EdCompteReglement: TEdit;
    Label2: TLabel;
    DateReglement: TDateEdit;
    EdLibelle: TEdit;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    RxSpeedButton1: TRxSpeedButton;
    Panel7: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    EdReference: TEdit;
    MemoAide: TMemo;
    Label5: TLabel;
    EdMontant: TCurrencyEdit;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    PopupMenuChoix: TPopupMenu;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    DtailPointages1: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    Centraliser: TMenuItem;
    Decentraliser1: TMenuItem;
    RefLigne: TMenuItem;
    procedure Button1Enter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnRefLigneClick(Sender: TObject);
    function CtrlSaisieChoixReglement(EditCourant:tedit):TExceptLGR;
    procedure EdCompteReglementEnter(Sender: TObject);
    procedure DateReglementEnter(Sender: TObject);
    procedure EdCompteReglementExit(Sender: TObject);
    procedure DateReglementExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DateReglementAcceptDate(Sender: TObject;
      var ADate: TDateTime; var Action: Boolean);
    procedure BtnRemiseChequeEnter(Sender: TObject);
    procedure BtnTiersNonDetailleEnter(Sender: TObject);
    procedure EdLibelleExit(Sender: TObject);
    procedure EdLibelleEnter(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure BtnRefLigneEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure EtatInitial;
    procedure GestionFiltrageParamCpt;
    procedure EdCompteReglementKeyPress(Sender: TObject; var Key: Char);
    procedure EdCompteReglementChange(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  ChoixReglementAuto: TChoixReglementAuto;
  compteReglementTmp,LibelleTmp:string;
  DateReglementTmp:tdatetime;
  TvaSurE,SupprDeclaration:boolean;
  MessDerSub,initialisation:boolean;
  CompteAppelant_:Tstringlist;

  Function ChoixReglementAffiche(CompteAppelant:Tstringlist;var Date_:tdateTime; Var Compte_,Reference_,Libelle_:string; Var Montant_:currency;TvaSurE_AGerer:boolean; var SupprODDecl:boolean) :Integer;

implementation

uses E2_AideCompte, DMImportation, DMPlanCpt;

{$R *.DFM}
Function ChoixReglementAffiche(CompteAppelant:Tstringlist;var Date_:tdateTime; Var Compte_,Reference_,Libelle_:string; Var Montant_:currency;TvaSurE_AGerer:boolean; var SupprODDecl:boolean) :Integer;
begin
result:=0;
if ChoixReglementAuto = nil then ChoixReglementAuto:=TChoixReglementAuto.Create(Application.MainForm);
TvaSurE:=TvaSurE_AGerer;
SupprDeclaration:=false;
ChoixReglementAuto.EtatInitial;
with  ChoixReglementAuto do
Begin//si
CompteAppelant_.Assign(CompteAppelant);
EdCompteReglement.text:=compte_;
EdMontant.Value:=Montant_;
EdLibelle.text:=Libelle_;
DateReglement.Date:=Date_;
EdReference.Text:=Reference_;
Aide1.Enabled:=EdCompteReglement.ReadOnly=false;
RefLigne.Enabled:=BtnRefLigne.Visible;
Centraliser.Enabled:=BtnRefLigne.Visible;
Decentraliser1.Enabled:=BtnRefLigne.Visible;

End;//fin si
if ChoixReglementAuto.ShowModal = mrOk then
 begin

  result:=ChoixReglementAuto.Tag;
  date_:=ChoixReglementAuto.DateReglement.date;
  compte_:=ChoixReglementAuto.EdCompteReglement.text;
  Libelle_:=ChoixReglementAuto.EdLibelle.text;
  Reference_:=ChoixReglementAuto.edReference.text;
  SupprODDecl:=SupprDeclaration;
 end;
end;

procedure TChoixReglementAuto.Button1Enter(Sender: TObject);
begin
  MemoAide.Lines.Clear;
  MemoAide.Lines.Add('');
end;

procedure TChoixReglementAuto.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,E.User);
LibereObjet(Tobject(CompteAppelant_),Self);
//FreeAndNil(CompteAppelant_);
ChoixReglementAuto:=nil;
end;

procedure TChoixReglementAuto.BtnRefLigneClick(Sender: TObject);
begin
  try
    EdCompteReglementexit(EdCompteReglement);
    DateReglementExit(DateReglement);
    EdLibelleExit(edLibelle);
    if ((sender is Tbutton))then
      self.tag:=(sender as Tbutton).Tag
    else
      if (sender is TMenuItem )then
        begin
          self.tag:=(sender as TMenuItem).Tag;
          case self.tag of //déclencher le enter dans bouton correspondant
            1:BtnRefLigneEnter(BtnRefLigne);
            2:BtnTiersNonDetailleEnter(BtnTiersNonDetaille);
            3:BtnRemiseChequeEnter(BtnRemiseCheque);
          end;//fin du case
        end;
    BtnEnregistrer.setfocus;
  except
    abort;
  end;
end;


function TChoixReglementAuto.CtrlSaisieChoixReglement(EditCourant:tedit):TExceptLGR;
var
i,rang:integer;
infosModel:TInfosModel;
infosVerrouillage:TVerrouillage;
Journal:TInfosModel;
ReferenceTmp:string;
Begin
try
Initialise_ExceptLGR(result);
result.NumErreur:=0;
result.retour:=true;
MessDerSub:=true;
if not initialisation then
 case EditCourant.tag of
   1:begin//si colonne compteReglement
//     if ((EditCourant.text<>compteReglementTmp)or(empty(EditCourant.text))) then
       begin//si le compte a changé
         if AideModelCompteJournalBanque(EditCourant.Text) then
            Begin//si le compte fait partie d'un journal
             if not AideModelAfficheJournauxBanque(EditCourant,False) then
               Begin//si le compte ne fait pas partie d'un journal de banque
                 raise ExceptLGR.Create('le compte '+EditCourant.Text+' ne fait pas partie d''un journal de banque',1001,true,mtError,result);
               End;//fin si le compte ne fait pas partie d'un journal de banque
            End//fin si le compte fait partie d'un journal
         else
            Begin //sinon, verifier si le compte fait partie du contexte
              //DMPlan.FiltrageAideCompte(101,nil,nil);
              GestionFiltrageParamCpt;
              if ((not AideCompteDansContexte(EditCourant.Text,EditCourant,['rac1'],false,MessDerSub,true,true,false,true,0))or(Dmplan.CptEstCollectif(EditCourant.Text))or(TypeCptTiers(EditCourant.Text))) then
                raise ExceptLGR.Create('le compte '+EditCourant.Text+' n''est pas cohérent dans ce contexte',1002,true,mtError,Result);
              if CompteAppelant_.IndexOf(EditCourant.Text)<>-1 then
                  raise ExceptLGR.Create('le compte '+EditCourant.Text+' n''est pas cohérent dans ce contexte',1003,True,mtError,Result);
            End;//fin sinon, verifier si le compte fait partie du contexte
         if result.retour then
           Begin//si le compte est ok
             //récupérer la nouvelle référence si nécessaire
             Journal:=Infos_TInfosModel(DMrech.TaModelRech,'Compte',[EditCourant.text]);
             if empty(Journal.Journal)then
             Journal.Journal:='OD';
             //à partir du journal créer la nouvelle et unique référence
             EdReference.text:=DMImport.Piece_Import.NewReference(dmrech.TaPieceRech,'Reference',journal.journal,e.ExerciceSaisie,'');
           End;//fin si le compte est ok
       end;//fin si le compte a changé
     end;//fin si colonne compteReglement
   2:begin//si colonne DateReglement
//       if ((datetostr(DateReglementTmp)<>EditCourant.Text)or(empty(EditCourant.text))) then
//         begin //si la date a changé
           if ((not empty(EditCourant.Text))and (EditCourant.Text<>'  /  /  '))then
             EditCourant.Text:=AnneeDefaut(E.DatExoDebut,E.DatExoFin,EditCourant.Text).DateStr;
           if DateValide(EditCourant.Text) then
               Begin //si la date est remplie
                 if not (DMImport.Piece_Import.VerifDateSaisie(StrToDate_Lgr(EditCourant.Text)))then
                   Begin //si référence pas correct
//                   Application.MessageBox(Pchar('La date doit faire partie de l''exercice en cours !!!'),'Erreur de saisie',0);
                     raise ExceptLGR.Create('La date doit faire partie de l''exercice en cours !!!',4002,true,mtError,Result);
                   End; //fin si compte pas correct
               End //fin si la date est remplie
             else
               Begin //si pas remplie
               // remplir par défaut avec date du jour
                   EditCourant.Text:=datetostr(now);
                   raise ExceptLGR.Create('',4001,false,mtError,Result);
               End; //fin si pas remplie
//          if ((result.retour)or(result.CodeErreur:=4001)) then
        if result.retour then
          Begin
            if ((TvaSurE)and(not SupprDeclaration)) then
              begin
              infosVerrouillage:=DMImport.Piece_Import.RetourneInfosVerrouillageSurPiece(nil,0,StrToDate_Lgr(EditCourant.Text));
              if infosVerrouillage.PeriodeVerrouillee then
                begin//si periode verrouillée
                if infosVerrouillage.PeriodeDeverrouillable then
                  Begin//si deverrouillable
                    if Application.MessageBox(PChar('Cette date fait partie d''une période de TVA déclarée. Si vous la conservez, la dernière déclaration Tva sera supprimer. Voulez-vous continuer ?'),'Confirmation',MB_YESNO+MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
                       Begin//si
                         //supprimer la dernière od de déclaration tva
                         SupprDeclaration:=true;
                       End//fin si
                    else
                       begin
                         raise ExceptLGR.Create('',4001,false,mtError,Result);
                       end;
                  End//fin si deverrouillable
                else
                  Begin//si non deverrouillable
//                    Application.MessageBox(Pchar('Cette date fait partie d''une période de TVA déclarée non déverrouillable !!!'),'Erreur de saisie',0);
                     raise ExceptLGR.Create('Cette date fait partie d''une période de TVA déclarée non déverrouillable !!!',4001,true,mtError,Result);
                  End;//fin si non deverrouillable
                end;//fin si periode verrouillée
              end;
          End;
//         end;//fin si la date a changé
     end;//fin si colonne DateReglement
   3:begin//si colonne Libelle
//     if ((EditCourant.text<>LibelleTmp)or(empty(EditCourant.text))) then
       begin//si le Libelle a changé
         if empty(editcourant.text)then
           Begin//si vide remplir par défaut
              editcourant.text:=Infos_TInfosplancpt(dmrech.TaPlanCptRech,'Compte',[edcomptereglement.text]).Libelle;
           End//fin si vide remplir par défaut
         else
         if editcourant.text='*'then
           Begin//si remplie avec une *
               editcourant.text:=Infos_TInfosplancpt(dmrech.TaPlanCptRech,'Compte',[edcomptereglement.text]).Libelle;
           End;//fin si remplie avec une *
       if empty(editcourant.text)then
         Begin//si vide malgré tout
//           Application.Messagebox(Pchar('Le libellé doit être renseigné !'),'Erreur de saisie',0);
             raise ExceptLGR.Create('Le libellé doit être renseigné !',3001,true,mtError,Result);
         End;//fin si vide malgré tout
       end;//fin si le Libelle a changé
     end;//fin si colonne Libelle
 end;//fin du case editcourant
except
  //
end;
end;
procedure TChoixReglementAuto.EdCompteReglementEnter(Sender: TObject);
begin
compteReglementTmp:=EdCompteReglement.text;
end;

procedure TChoixReglementAuto.DateReglementEnter(Sender: TObject);
begin
DateReglementTmp:=DateReglement.Date;
end;

procedure TChoixReglementAuto.EdCompteReglementExit(Sender: TObject);
var
valide:TExceptLGR;
begin
if ActiveControl<>btnannuler then
  begin
  valide:=CtrlSaisieChoixReglement(EdCompteReglement);
  if not valide.retour then
    begin
      EdCompteReglement.setfocus;
      abort;
    end;
  end;
end;


procedure TChoixReglementAuto.DateReglementExit(Sender: TObject);
var
valide:TExceptLGR;
editdate:tedit;
DateValide:Tdate;
begin
  try
    try
      editdate:=tedit.Create(self);
      dateValide:=now;
      if DateValide<e.DatExoDebut then DateValide:=e.DatExoDebut;
      if DateValide>e.DatExoFin then DateValide:=e.DatExoFin;
      DateReglement.Date:=AnneeDefaut_SurDerniereDateSaisie_Modifie(e.DatExoDebut,e.DatExoFin,DateValide,DateReglement.Text).Date_;
      editdate.Text:=DateReglement.Text;
      editdate.tag:=DateReglement.tag;
      valide:=CtrlSaisieChoixReglement(editdate);
      if valide.NumErreur<>4002 then
        DateReglement.text:=editdate.Text;
      if not valide.retour then
        abort;
    finally
      editdate.free;
    end;
  except
    DateReglement.SetFocus;
    abort;
  end;
end;

procedure TChoixReglementAuto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_RETURN then
WinSuivPrec(Handle,key,[nil]);
if key=vk_escape then
   Begin//si
     BtnAnnulerClick(btnannuler);
   End;//fin si
end;

procedure TChoixReglementAuto.BtnAnnulerClick(Sender: TObject);
begin
self.ModalResult:=mrcancel;
end;

procedure TChoixReglementAuto.FormActivate(Sender: TObject);
begin
EdCompteReglement.setfocus;
EdMontant.DisplayFormat:=E.FormatMonnaie;
initialisation:=false;
end;

procedure TChoixReglementAuto.DateReglementAcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
var
valide:TExceptLGR;
editdate:tedit;
begin
  try
    editdate:=tedit.Create(self);
    editdate.Text:=datetostr(ADate);
    editdate.tag:=DateReglement.tag;
    valide:=CtrlSaisieChoixReglement(editdate);
    Action:=valide.retour;
    if action then
      DateReglement.text:=editdate.Text;
  finally
    if editdate<>nil then editdate.free;
  end;
end;

procedure TChoixReglementAuto.BtnRemiseChequeEnter(Sender: TObject);
begin
  MemoAide.Lines.Clear;
  MemoAide.Lines.Add('il sera créé une ligne d''écriture par tiers ');
end;

procedure TChoixReglementAuto.BtnTiersNonDetailleEnter(Sender: TObject);
begin
  MemoAide.Lines.Clear;
  MemoAide.Lines.Add('Il sera créé une ligne d"écriture par ligne réglée');
end;

procedure TChoixReglementAuto.EdLibelleExit(Sender: TObject);
var
valide:TExceptLGR;
begin
valide:=CtrlSaisieChoixReglement(EdLibelle);
if not valide.retour then
  begin
    EdLibelle.setfocus;
    abort;
  end;
end;

procedure TChoixReglementAuto.EdLibelleEnter(Sender: TObject);
begin
LibelleTmp:=edlibelle.text;
end;

procedure TChoixReglementAuto.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TChoixReglementAuto.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TChoixReglementAuto.BtnEnregistrerClick(Sender: TObject);
begin
self.ModalResult:=mrok;
end;

procedure TChoixReglementAuto.Aide1Click(Sender: TObject);
begin
//si on est sur l'entete de la pièce
///////////////////
 If activecontrol = EdCompteReglement Then
  //Afficher aidecompte filtré
  begin
    MessDerSub:=false;
    GestionFiltrageParamCpt;
    AideCompteDansContexte(EdCompteReglement.Text,EdCompteReglement,['Rac1'],true,MessDerSub,false,true,false,true,0);
    MessDerSub:=true;
  end;//fin si activecontrol = edCompte
///////////////////
end;

procedure TChoixReglementAuto.BtnRefLigneEnter(Sender: TObject);
begin
  MemoAide.Lines.Clear;
  MemoAide.Lines.Add('il sera créé une Pièce par ligne réglée');
end;

procedure TChoixReglementAuto.FormCreate(Sender: TObject);
begin
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;

procedure TChoixReglementAuto.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer],PaBtn,90,0);
end;


procedure TChoixReglementAuto.EtatInitial;
Begin
  try
  if CompteAppelant_=nil then CompteAppelant_:=Tstringlist.create;
  CompteAppelant_.Clear;
  EdCompteReglement.text:='';
  EdMontant.Value:=0;
  EdLibelle.text:='';
  DateReglement.Date:=0;
  EdReference.Text:='';
  compteReglementTmp:='';
  LibelleTmp:='';
  DateReglementTmp:=0;
  initialisation:=true;
  if ChoixReglementAuto.Visible then EdCompteReglement.SetFocus;
  finally

  end;
End;


procedure TChoixReglementAuto.GestionFiltrageParamCpt;
begin
if DMPlan=nil then DMPlan:=TDMPlan.Create(Application.MainForm);
DMPlan.TaCompte.OnFilterRecord:= DMPlan.TaCompteFilterRecord;
//AideCompte.FiltrageAideCompte(101);
AideCompte.FiltrageAideCompte(28);  { isa  le  29/06/05 }
End;


procedure TChoixReglementAuto.EdCompteReglementKeyPress(Sender: TObject;
  var Key: Char);
begin
key:=str_majusculeschar(key);
end;

procedure TChoixReglementAuto.EdCompteReglementChange(Sender: TObject);
begin
EdCompteReglement.Text:=str_majuscule(EdCompteReglement.Text);
end;

procedure TChoixReglementAuto.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(nil);
end;

end.
