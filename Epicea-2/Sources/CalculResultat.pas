unit CalculResultat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, Mask, ToolEdit, CurrEdit, ExtCtrls, RXCtrls,
  jpeg,E2_Decl_Records,E2_AideCompte,DMConstantes,LibSql,E2_LibInfosTable,
  DMRecherche,
  LibGestionParamXML,
  E2_Librairie_Obj,
  LibRessourceString,
  LibZoneSaisie;

type
  TCalcul_Resultat = class(TForm)
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    Panel4: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Shape3: TShape;
    Shape4: TShape;
    SoldeDebit1: TCurrencyEdit;
    SoldeCredit1: TCurrencyEdit;
    PaSoldeFin1: TPanel;
    Panel3: TPanel;
    Label3: TLabel;
    PaSoldeFin3: TPanel;
    Label2: TLabel;
    EdCompte: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Libelle: TLabel;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Visualisation1: TMenuItem;
    Calculatrice1: TMenuItem;
    MenuItem3: TMenuItem;
    Enregister1: TMenuItem;
    MenuItem8: TMenuItem;
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure EdCompteChange(Sender: TObject);
    procedure EdCompteExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Calcul_Resultat: TCalcul_Resultat;
  MessDerSub:boolean;

  function AffichResultat(Owner:TForm; Resultat:TTotauxBalance;Affich:boolean=true):TInfos_Piece;
implementation

uses DMPlanCpt;

{$R *.dfm}

function AffichResultat(Owner:TForm; Resultat:TTotauxBalance;Affich:boolean):TInfos_Piece;
Begin
try//finally
initialise_TInfos_Piece(result);
result.Retour:=true;
if Calcul_Resultat=nil then
  begin
    if(Owner=nil)then owner:=application.MainForm;
    Calcul_Resultat:=TCalcul_Resultat.Create(owner);
  end;
if AideCompte=nil then AideCompte:=TAideCompte.Create(Calcul_Resultat);

if (Resultat.SoldeDebitCreditFin) then//si solde au Debit =Perte
  begin
    Calcul_Resultat.EdCompte.text:=DM_C_CompteDeResultPerte;
    Calcul_Resultat.SoldeDebit1.Value:=Resultat.SoldeFin;
  end
else //si solde au crédit = Bénéfice
  begin
    Calcul_Resultat.EdCompte.text:=DM_C_CompteDeResultBenef;
    Calcul_Resultat.SoldeCredit1.Value:=Resultat.SoldeFin;
  end;

//Gérer le filtrage de aideCompte sur les comptes de perte et de bénéfice
DMPlan.FiltrageAideCompte(102,nil,DMPlan.TaCompteFilterRecord);
//Appel de la fenêtre puis récupération de la valeur de sortie d'écran
if affich then
  result.Retour:=Calcul_Resultat.ShowModal=mrok;
finally
result.Compte:=Calcul_Resultat.EdCompte.text;
result.Total.Solde:=resultat.SoldeFin;
if resultat.SoldeDebitCreditFin then
result.SensSolde:=-1
else
result.SensSolde:=1;
Calcul_Resultat.Free;
end;

end;


procedure TCalcul_Resultat.BtnEnregistrerClick(Sender: TObject);
begin
try
EdCompteExit(EdCompte);
if application.MessageBox(Pchar('Le résultat va être enregistré sur le compte '+edcompte.Text+' - '+libelle.Caption+' ? '+RetourChariotDouble+'Confirmez-vous la clôture et le changement d''exercice'),'Abandon',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON1)=mryes then
  ModalResult:=mrOk
else
  ModalResult:=mrnone;
except
end;  
end;
procedure TCalcul_Resultat.BtnAnnulerClick(Sender: TObject);
begin
if application.MessageBox(Pchar('Etes-vous sûr de vouloir abandonner le changement d''exercice ?'),'Abandon',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
  ModalResult:=mrCancel
else
  ModalResult:=mrnone;
end;

procedure TCalcul_Resultat.MenuItem2Click(Sender: TObject);
begin
//proposer aideCompte filtré en fonction des comptes de bénéfices ou de pertes
MessDerSub:=false;
AideCompteDansContexte(EdCompte.Text,EdCompte,['Rac1'],true,MessDerSub,false,true,false,true,0);
end;

procedure TCalcul_Resultat.EdCompteChange(Sender: TObject);
begin
libelle.Caption:=Infos_TInfosplancpt(dmrech.TaPlanCptRech,'compte',[edcompte.text]).Libelle;
end;

procedure TCalcul_Resultat.EdCompteExit(Sender: TObject);
begin
if ActiveControl<>BtnAnnuler then
  begin
    MessDerSub:=true;
    if not AideCompteDansContexte(EdCompte.Text,EdCompte,['Rac1'],false,MessDerSub,false,true,false,true,0)then
      begin
        edcompte.SetFocus;
        abort;
      end;
  end;
end;

procedure TCalcul_Resultat.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
WinSuivPrec(Handle,key,[nil]);
  if Key = VK_ESCAPE then
   begin
      Key:= 0;
      BtnAnnulerClick(BtnAnnuler);
   end;

end;

procedure TCalcul_Resultat.FormDestroy(Sender: TObject);
begin
  LibGestionParamXML.DestroyForm(Self,E.USer);
  Calcul_Resultat:=nil;
end;

procedure TCalcul_Resultat.FormCreate(Sender: TObject);
begin
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
      Position:=poScreenCenter;
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;

end;

end.
