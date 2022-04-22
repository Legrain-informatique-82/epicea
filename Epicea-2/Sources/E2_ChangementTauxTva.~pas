{***************************************************************
 *
 * Unit Name: E2_ChangementTauxTva
 * Purpose  :
 * Author   : JS
 * History  :
 *
 ****************************************************************}

// Gere le changement de code tva ou taux par défaut dans plan comptable et trame
unit E2_ChangementTauxTva;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, gr_Librairie_obj,
  Buttons, DBTables,E2_Decl_Records,
  Mask, ToolEdit, CurrEdit,DMTva, RXCtrls, ExtCtrls,E2_Librairie_obj,
  E2_AideTva,LibZoneSaisie,DMConstantes,LibDates, jpeg,LibGestionParamXML, lib_chaine,
  E2_LibInfosTable,ZoneDeSaisie;

type

  TParamAfficheChangementTauxTva=record
     OldTvaCode:string;
     newTvaCode:string;
     OldTvaTaux:real;
     NewTvaTaux:real;
     plancpt :boolean;
     trame : boolean;
     filtreTaux : boolean;
     ModifTaux : boolean;
     //NePasprendreOldTaux:boolean;
  end;

  TE2_ChangementtauxDeTva = class(TForm)
    PopupMenu1: TPopupMenu;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    pmMenu1: TMenuItem;
    Fermer1: TMenuItem;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaEntete: TPanel;
    oldcode: TLabel;
    newcode: TLabel;
    EdTvacode: TEdit;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    GroupBox1: TGroupBox;
    cbPlanCpt: TCheckBox;
    cbTrame: TCheckBox;
    PaMessage: TPanel;
    MemoMessage: TMemo;
    Label1: TLabel;
    OldTauxTva: TCurrencyEdit;
    NewTvaTaux: TCurrencyEdit;
    cbPrendreTousTaux: TCheckBox;
    procedure Aide1Click(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
    procedure EdTvacodeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EdTvacodeExit(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    procedure EdTvacodeKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EdTvacodeEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure EdNewTvaTauxExit(Sender: TObject);
//    procedure remplirTauxSurCode(sender:TObject;Code:string);
    procedure InitialiseEcran;
    procedure OldTauxTvaExit(Sender: TObject);
    procedure OldTauxTvaKeyPress(Sender: TObject; var Key: Char);
    procedure EdNewTvaTauxKeyPress(Sender: TObject; var Key: Char);
    procedure NewTvaTauxKeyPress(Sender: TObject; var Key: Char);
    procedure NewTvaTauxExit(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure cbPrendreTousTauxClick(Sender: TObject);
  private
    { Déclarations privées }

    FOldTvaCode :String;
    fOldTvaTaux:currency;
    fNewTvaTaux:currency;


    TvaTaux_Tmp:real;
    NewTvaTaux_Tmp:real;
    TvaCode_Tmp:string;

    Procedure SetTvaTaux(Taux : Currency);
    Procedure SetOldTvaTaux(Taux : Currency);

  public
    { Déclarations publiques }

   end;
var
  E2_ChangementtauxDeTva: TE2_ChangementtauxDeTva;

  function ChangementTauxTvaAffiche(var ParamAfficheChangementTva:TParamAfficheChangementTauxTva):boolean;

implementation

uses DMPiece, DMRecherche, LibRessourceString;
{$R *.DFM}



//******************************************************************************
  function ChangementTauxTvaAffiche(var ParamAfficheChangementTva:TParamAfficheChangementTauxTva):boolean;
// Initialise l'écran avec les valeurs de la ligne d'écriture
Begin
    if E2_ChangementtauxDeTva=nil then
    E2_ChangementtauxDeTva:=TE2_ChangementtauxDeTva.Create(Application.MainForm);

   with E2_ChangementtauxDeTva do
   begin
   InitialiseEcran;
   edTvaCode.Text:= ParamAfficheChangementTva.OldTvaCode;
   edTvaCodeChange(edTvaCode);
   E2_ChangementtauxDeTva.cbPrendreTousTaux.Checked:=false;
   TvaCode_Tmp:=ParamAfficheChangementTva.OldTvaCode;
   E2_ChangementtauxDeTva.OldTauxTva.Enabled:=not E2_ChangementtauxDeTva.cbPrendreTousTaux.Checked;
   MemoMessage.Lines.Text:=(MessageChangementTauxTva);

   Result:= (E2_ChangementtauxDeTva.ShowModal = mrOk);
   if result then
   Begin
     //Récupérer les valeurs dans les var
     SetTvaTaux(NewTvaTaux.Value);
     SetOldTvaTaux(OldTauxTva.value);
     //remplir les variable à renvoyer
     ParamAfficheChangementTva.OldTvaCode:=E2_ChangementtauxDeTva.FOldTvaCode;
     ParamAfficheChangementTva.newTvaCode:=E2_ChangementtauxDeTva.FOldTvaCode;
     ParamAfficheChangementTva.OldTvaTaux:=E2_ChangementtauxDeTva.fOldTvaTaux;
     ParamAfficheChangementTva.newTvaTaux:=E2_ChangementtauxDeTva.fNewTvaTaux;
     ParamAfficheChangementTva.plancpt:=cbPlanCpt.Checked;
     ParamAfficheChangementTva.trame:=cbTrame.Checked;
     ParamAfficheChangementTva.filtreTaux:=not cbPrendreTousTaux.Checked;
     ParamAfficheChangementTva.ModifTaux:=true;
   End;

   end;//fin du with E2_ChangementTauxTva
End;


procedure TE2_ChangementtauxDeTva.InitialiseEcran;
begin
FOldTvaCode:='';
fOldTvaTaux:=0;
fNewTvaTaux:=0;
EdTvaCode.text:='';
OldTauxTva.value:=0;
NewTvaTaux.value:=0;
TvaCode_Tmp:='';
TvaTaux_Tmp:=0;
NewTvaTaux_Tmp:=0;
BtnEnregistrer.Enabled:=false;
end;
procedure TE2_ChangementtauxDeTva.Calculatrice1Click(Sender: TObject);
// Affiche calculatrice F12
begin
	AfficheCalculatrice(nil);
end;


//******************************************************************************
procedure TE2_ChangementtauxDeTva.EdTvacodeChange(Sender: TObject);
// Change la propriété enable des autres zones suivant le code TVA
begin
   if(TvaCode_Tmp<>EdTvaCode.text)then
   begin
     edtvacode.Text:=UpperCase(edtvacode.Text);
     edtvacode.SelStart:=length(edtvacode.text);
   end;
end;

//procedure TE2_ChangementTauxTva.remplirTauxSurCode(sender:TObject;Code:string);
//var
//recup:TRecupMiniMaxTva;
//begin
//(sender as TComboBox).Clear;
//recup:=FTvaRecupMiniMaxTva(Code);
//if(recup.CodeRetour > 1 )then
//  begin
//      (sender as TComboBox).AddItem(FloatToStr_Lgr(recup.Taux_Inf),nil);
//      if(recup.Taux_Inf<>recup.Taux_Supp)then
//          begin
//             (sender as TComboBox).AddItem(FloatToStr_Lgr(recup.Taux_Supp),nil);
//             (sender as TComboBox).AddItem('Autre',nil);
//          end;
//      (sender as TComboBox).ItemIndex:=0;
//  end;
//end;

procedure TE2_ChangementtauxDeTva.FormCreate(Sender: TObject);
begin
    try
	      LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
//        InitialiseFormPosDefaut(self); // PB 15-06-03
    end;
end;

//******************************************************************************
procedure TE2_ChangementtauxDeTva.FormDestroy(Sender: TObject);
begin
  	LibGestionParamXML.DestroyForm(Self,E.USer);
    E2_ChangementtauxDeTva:=nil;
end;





//******************************************************************************
Procedure TE2_ChangementtauxDeTva.SetTvaTaux(Taux : Currency);
// Modifie le taux TVA dans la ligne d'écriture
Begin
        NewTvaTaux.value:=Taux;
        //Récupérer la valeur dans la variable globale
        fNewTvaTaux:=Taux;
End;

//******************************************************************************
Procedure TE2_ChangementtauxDeTva.SetOldTvaTaux(Taux : Currency);
// Modifie le taux TVA dans la ligne d'écriture
Begin
       OldTauxTva.value:=Taux;
        //Récupérer la valeur dans la variable globale
        foldTvaTaux:=Taux;
End;

procedure TE2_ChangementtauxDeTva.Aide1Click(Sender: TObject);
// Gestion de F1 suivant la zone active
begin
    if (ActiveControl = edTvaCode) then
   	       AideTvaAfficheTous(edTvaCode);
end;



procedure TE2_ChangementtauxDeTva.EdTvacodeExit(Sender: TObject);
var
Valide:TErreurSaisie;
recup:TRecupMiniMaxTva;
begin

valide.retour:=(FCodeTvaExist(EdTvacode.Text))or (EdTvacode.Text='');
BtnEnregistrer.Enabled:=(valide.retour) and (EdTvacode.Text<>'');
if(not valide.retour)and( ActiveControl<>btnAnnuler) then
 begin
    showmessage('Ce code tva n''existe pas');
    EdTvacode.SetFocus;
    abort;
 end
else
begin
recup:=FTvaRecupMiniMaxTva(EdTvacode.Text);
    edTvaCodeChange(edTvaCode);
    FOldTvaCode:=EdTvaCode.Text;
    TvaCode_Tmp:=EdTvaCode.Text;
    if recup.Taux_Inf=recup.Taux_Supp then
      NewTvaTaux.value:=recup.Taux_Supp;
    NewTvaTaux.Enabled:=not (recup.Taux_Inf=recup.Taux_Supp);
end;
end;



procedure TE2_ChangementtauxDeTva.Fermer1Click(Sender: TObject);
begin
close;
end;



procedure TE2_ChangementtauxDeTva.EdTvacodeKeyPress(Sender: TObject;
  var Key: Char);
begin
if (key in [#32])then
  key:=#0;
if key = #13 then
 begin
  (sender as TCustomEdit).SelectAll;
 end;
end;

procedure TE2_ChangementtauxDeTva.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
if key = VK_RETURN then
WinSuivPrec(Handle,key,[nil]);
if key = vk_escape then
  BtnAnnuler.Click;
end;

procedure TE2_ChangementtauxDeTva.BtnEnregistrerClick(Sender: TObject);
////// Fermeture
var
valide:TErreurSaisie;
i:integer;
count:integer;
begin
if(BtnEnregistrer.Enabled)then BtnEnregistrer.SetFocus;
if(BtnEnregistrer.Enabled=false)then abort;
ModalResult:= mrOk;
if ActiveControl<>btnAnnuler then
   begin
     For i:=0 to PaEntete.ControlCount-1 do
       begin
         if (PaEntete.Controls[i] is TCustomEdit) then
           begin
           valide.retour:=true;
             //valide:=CtrlSaisieComplement((PaEntete.Controls[i] as TCustomEdit),nil);
              if not valide.retour then
                begin
                (PaEntete.Controls[i] as TCustomEdit).SetFocus;
                 self.ModalResult:=mrnone;
                 abort;
                end;
          end;
       end;
   end;
end;

procedure TE2_ChangementtauxDeTva.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
canclose:=true;
end;









procedure TE2_ChangementtauxDeTva.EdTvacodeEnter(Sender: TObject);
begin
TvaCode_Tmp:=EdTvaCode.text;
end;







procedure TE2_ChangementtauxDeTva.FormShow(Sender: TObject);
begin
EdTvaCode.SetFocus;
end;

procedure TE2_ChangementtauxDeTva.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TE2_ChangementtauxDeTva.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;



procedure TE2_ChangementtauxDeTva.EdNewTvaTauxExit(Sender: TObject);
var
Valide:TErreurSaisie;
begin
  fNewTvaTaux:=NewTvaTaux.value;
  NewTvaTaux_Tmp:=NewTvaTaux.value;
end;











procedure TE2_ChangementtauxDeTva.OldTauxTvaExit(Sender: TObject);
begin
SetOldTvaTaux(OldTauxTva.Value);
end;

procedure TE2_ChangementtauxDeTva.OldTauxTvaKeyPress(Sender: TObject;
  var Key: Char);
begin
if (key in [#32])then
  key:=#0;
if key = #13 then
 begin
  (sender as TCustomEdit).SelectAll;
 end;
end;

procedure TE2_ChangementtauxDeTva.EdNewTvaTauxKeyPress(Sender: TObject;
  var Key: Char);
begin
if (key in [#32])then
  key:=#0;
if key = #13 then
 begin
  (sender as TCustomEdit).SelectAll;
 end;
end;

procedure TE2_ChangementtauxDeTva.NewTvaTauxKeyPress(Sender: TObject;
  var Key: Char);
begin
if (key in [#32])then
  key:=#0;
if key = #13 then
 begin
  (sender as TCustomEdit).SelectAll;
 end;
end;

procedure TE2_ChangementtauxDeTva.NewTvaTauxExit(Sender: TObject);
var
valide:boolean;
recup:TRecupMiniMaxTva;
begin
recup:=FTvaRecupMiniMaxTva(EdTvacode.Text);
//valide:= (NewTvaTaux.Value=0)or((recup.Taux_Inf<=NewTvaTaux.Value) and (recup.Taux_Supp>=NewTvaTaux.Value));
//if not valide then
//begin
//  ShowMessage('Le nouveau taux de tva doit être compris entre '+FloatToStr_Lgr(recup.Taux_Supp)+' et '+FloatToStr_Lgr(recup.Taux_Supp));
//  NewTvaTaux.SetFocus;
//  abort;
//end;
SetTvaTaux(NewTvaTaux.Value);
end;

procedure TE2_ChangementtauxDeTva.BtnAnnulerClick(Sender: TObject);
begin
InitialiseEcran;
self.ModalResult:=mrCancel;
end;

procedure TE2_ChangementtauxDeTva.cbPrendreTousTauxClick(Sender: TObject);
begin
OldTauxTva.Enabled:=not cbPrendreTousTaux.Checked;
OldTauxTva.value:=0;
end;

end.
