{***************************************************************
 *
 * Unit Name: E2_ChangementcodeTva
 * Purpose  :
 * Author   : JS
 * History  :
 *
 ****************************************************************}

// Gere le changement de code tva ou taux par défaut dans plan comptable et trame
unit E2_ChangementTva;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, gr_Librairie_obj,
  Buttons, DBTables,E2_Decl_Records,
  Mask, ToolEdit, CurrEdit,DMTva, RXCtrls, ExtCtrls,E2_Librairie_obj,
  E2_AideTva,LibZoneSaisie,DMConstantes,LibDates, jpeg,LibGestionParamXML, lib_chaine,
  E2_LibInfosTable,ZoneDeSaisie;

type

  TParamAfficheChangementCodeTva=record
     OldTvaCode:string;
     newTvaCode:string;
     OldTvaTaux:real;
     NewTvaTaux:real;
     plancpt :boolean;
     trame : boolean;
     filtreTaux : boolean;
     ModifTaux : boolean;
  end;

  TE2_ChangementcodeTva = class(TForm)
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
    EdTvaCode: TEdit;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    EdNewcode: TEdit;
    GroupBox1: TGroupBox;
    cbPlanCpt: TCheckBox;
    cbTrame: TCheckBox;
    GroupBox2: TGroupBox;
    cbFiltre: TCheckBox;
    OldTauxTva: TCurrencyEdit;
    PaMessage: TPanel;
    MemoMessage: TMemo;
    procedure Aide1Click(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
    procedure edTvaCodeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EdTvaCodeExit(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    procedure EdTvaCodeKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EdTvaCodeEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure EdNewcodeEnter(Sender: TObject);
    procedure EdNewcodeChange(Sender: TObject);
    procedure EdNewcodeExit(Sender: TObject);
//    procedure remplirTauxSurCode(sender:TObject;Code:string);
    procedure InitialiseEcran;
    procedure OldTauxTvaExit(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
  private
    { Déclarations privées }
    FCompte : string;
    FOldTvaCode :String;
    fOldTvaTaux:currency;
    FNewTvaCode :String;
    fNewTvaTaux:currency;
    //FEtatModif :Boolean;


    TvaTaux_Tmp:real;
    NewTvaTaux_Tmp:real;
    TvaCode_Tmp:string;
    newTvaCode_Tmp:string;

//    Procedure SetTvaTaux(Taux : Currency);
    Procedure SetOldTvaTaux(Taux : Currency);

  public
    { Déclarations publiques }

   end;
var
  E2_ChangementcodeTva: TE2_ChangementcodeTva;

function ChangementCodeTvaAffiche(var ParamAfficheChangementTva:TParamAfficheChangementCodeTva):boolean;

implementation

uses DMPiece, DMRecherche, LibRessourceString;
{$R *.DFM}



//******************************************************************************
  function ChangementCodeTvaAffiche(var ParamAfficheChangementTva:TParamAfficheChangementCodeTva):boolean;
// Initialise l'écran avec les valeurs de la ligne d'écriture
Begin
    if E2_ChangementcodeTva=nil then
    E2_ChangementcodeTva:=TE2_ChangementcodeTva.Create(Application.MainForm);

   with E2_ChangementcodeTva do
   begin
   InitialiseEcran;
   edTvaCode.Text:= ParamAfficheChangementTva.OldTvaCode;
   edTvaCodeChange(edTvaCode);
   TvaCode_Tmp:=ParamAfficheChangementTva.OldTvaCode;
   MemoMessage.Lines.Text:=(MessageChangementCodeTva);

   Result:= (E2_ChangementcodeTva.ShowModal = mrOk);
   if result then
   Begin
     //Récupérer les valeurs dans les var
     //SetTvaTaux(StrToFloat_Lgr(OldTauxTva.Text));
     SetOldTvaTaux(StrToFloat_Lgr(OldTauxTva.Text));
     //remplir les variable à renvoyer
     ParamAfficheChangementTva.OldTvaCode:=E2_ChangementcodeTva.FOldTvaCode;
     ParamAfficheChangementTva.newTvaCode:=E2_ChangementcodeTva.FNewTvaCode;
     ParamAfficheChangementTva.OldTvaTaux:=E2_ChangementcodeTva.fOldTvaTaux;
     ParamAfficheChangementTva.newTvaTaux:=0;
     ParamAfficheChangementTva.plancpt:=cbPlanCpt.Checked;
     ParamAfficheChangementTva.trame:=cbTrame.Checked;
     ParamAfficheChangementTva.filtreTaux:=cbFiltre.Checked;
     ParamAfficheChangementTva.ModifTaux:=true;
   End;

   end;//fin du with E2_ChangementcodeTva
End;


procedure TE2_ChangementcodeTva.InitialiseEcran;
begin
E2_ChangementcodeTva.FOldTvaCode:='';
E2_ChangementcodeTva.FNewTvaCode:='';
E2_ChangementcodeTva.fOldTvaTaux:=0;
E2_ChangementcodeTva.fNewTvaTaux:=0;
EdNewcode.text:='';
EdTvaCode.text:='';
OldTauxTva.text:='';
//cbOldTaux.Clear;
//cbNewTaux.Clear;
cbFiltre.Checked:=false;
TvaCode_Tmp:='';
TvaTaux_Tmp:=0;
NewTvaTaux_Tmp:=0;
newTvaCode_Tmp:='';
end;
procedure TE2_ChangementcodeTva.Calculatrice1Click(Sender: TObject);
// Affiche calculatrice F12
begin
	AfficheCalculatrice(nil);
end;


//******************************************************************************
procedure TE2_ChangementcodeTva.edTvaCodeChange(Sender: TObject);
var
CodeTva:string;
// Change la propriété enable des autres zones suivant le code TVA
begin
   if(TvaCode_Tmp<>EdTvaCode.text)then
   begin
     edtvacode.Text:=UpperCase(edtvacode.Text);
     edtvacode.SelStart:=length(edtvacode.text);
     CodeTva:=edtvacode.Text;
     //remplirTauxSurCode(cbOldTaux,CodeTva);
   end;
end;

//procedure TE2_ChangementcodeTva.remplirTauxSurCode(sender:TObject;Code:string);
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

procedure TE2_ChangementcodeTva.FormCreate(Sender: TObject);
begin
    try
	      LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
//        InitialiseFormPosDefaut(self); // PB 15-06-03
    end;
end;

//******************************************************************************
procedure TE2_ChangementcodeTva.FormDestroy(Sender: TObject);
begin
  	LibGestionParamXML.DestroyForm(Self,E.USer);
    E2_ChangementcodeTva:=nil;
end;





//******************************************************************************
//Procedure TE2_ChangementcodeTva.SetTvaTaux(Taux : Currency);
//// Modifie le taux TVA dans la ligne d'écriture
//Begin
//        cbNewTaux.ItemIndex:=cbNewTaux.Items.IndexOf(FloatToStr_Lgr(Taux));
//        //Récupérer la valeur dans la variable globale
//        fNewTvaTaux:=Taux;
//End;

//******************************************************************************
Procedure TE2_ChangementcodeTva.SetOldTvaTaux(Taux : Currency);
// Modifie le taux TVA dans la ligne d'écriture
Begin
       OldTauxTva.text:=FloatToStr_Lgr(Taux);
        //Récupérer la valeur dans la variable globale
        foldTvaTaux:=Taux;
End;

procedure TE2_ChangementcodeTva.Aide1Click(Sender: TObject);
// Gestion de F1 suivant la zone active
begin
//	if (ActiveControl = edTvaTaux) then
//   	 AfficheCalculatrice(ActiveControl)
//   else 	if (ActiveControl = EdNewTvaTaux) then
//   	 AfficheCalculatrice(ActiveControl)
   //Else
    if (ActiveControl = edTvaCode) then
   	       AideTvaAfficheTous(edTvaCode)
   Else if (ActiveControl = EDNEWCODE) then
   	       AideTvaAfficheTous(EDNEWCODE)
end;



procedure TE2_ChangementcodeTva.EdTvaCodeExit(Sender: TObject);
var
Valide:TErreurSaisie;
recup:TRecupMiniMaxTva;
begin
valide.retour:=(FCodeTvaExist(EdTvacode.Text)) or (EdTvacode.Text='');
if(not valide.retour)and( ActiveControl<>btnAnnuler) then
 begin
    showmessage('Ce code tva n''existe pas');
    EdTvacode.SetFocus;
    abort;
 end
else
 begin
    edTvaCodeChange(edTvaCode);
    FOldTvaCode:=EdTvaCode.Text;
    TvaCode_Tmp:=EdTvaCode.Text;
end;    
end;



procedure TE2_ChangementcodeTva.Fermer1Click(Sender: TObject);
begin
close;
end;



procedure TE2_ChangementcodeTva.EdTvaCodeKeyPress(Sender: TObject;
  var Key: Char);
begin
if (key in [#32])then
  key:=#0;
if key = #13 then
 begin
  (sender as TCustomEdit).SelectAll;
 end;
end;

procedure TE2_ChangementcodeTva.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
if key = VK_RETURN then
WinSuivPrec(Handle,key,[nil]);
if key = vk_escape then
  BtnAnnuler.Click;
end;

procedure TE2_ChangementcodeTva.BtnEnregistrerClick(Sender: TObject);
////// Fermeture
var
valide:TErreurSaisie;
i:integer;
count:integer;
begin
BtnEnregistrer.SetFocus;
ModalResult:= mrOk;
if ActiveControl<>btnAnnuler then
   begin
     EdTvaCodeExit(EDNEWCODE);
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

procedure TE2_ChangementcodeTva.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
canclose:=true;
end;









procedure TE2_ChangementcodeTva.EdTvaCodeEnter(Sender: TObject);
begin
TvaCode_Tmp:=EdTvaCode.text;
end;







procedure TE2_ChangementcodeTva.FormShow(Sender: TObject);
begin
EdTvaCode.SetFocus;
end;

procedure TE2_ChangementcodeTva.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TE2_ChangementcodeTva.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;



procedure TE2_ChangementcodeTva.EdNewcodeEnter(Sender: TObject);
begin
newTvaCode_Tmp:=EDNEWCODE.text;
end;

procedure TE2_ChangementcodeTva.EdNewcodeChange(Sender: TObject);
var
CodeTva:string;
// Change la propriété enable des autres zones suivant le code TVA
begin
   if(newTvaCode_Tmp<>EdNewcode.text)then
   begin
       EdNewcode.Text:=UpperCase(EdNewcode.Text);
       EdNewcode.SelStart:=length(EdNewcode.text);
       CodeTva:=EdNewcode.Text;
      // remplirTauxSurCode(cbNewTaux,CodeTva);
   end;
end;

procedure TE2_ChangementcodeTva.EdNewcodeExit(Sender: TObject);
var
Valide:TErreurSaisie;
begin
valide.retour:=(FCodeTvaExist(EdNewcode.Text)) or (EdNewcode.Text='');
if(not valide.retour)and( ActiveControl<>btnAnnuler) then
 begin
    showmessage('Ce code tva n''existe pas');
    EdNewcode.SetFocus;
    abort;
 end
else
 begin
  EdNewcodeChange(EdNewcode);
  FNewTvaCode:=EdNewcode.Text;
  newTvaCode_Tmp:=EdNewcode.Text;
end;  
end;











procedure TE2_ChangementcodeTva.OldTauxTvaExit(Sender: TObject);
begin
cbFiltre.Checked:=(OldTauxTva.Value<>0);
SetOldTvaTaux(OldTauxTva.Value);
end;

procedure TE2_ChangementcodeTva.BtnAnnulerClick(Sender: TObject);
begin
InitialiseEcran;
self.ModalResult:=mrCancel;
end;

end.
