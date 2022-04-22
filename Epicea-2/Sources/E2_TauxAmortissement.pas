unit E2_TauxAmortissement;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, RXCtrls, ExtCtrls,
  Mask, ToolEdit, CurrEdit,
  E2_Decl_Records,
  Gr_Librairie_Obj,
  E2_Librairie_Obj,
  DMConstantes,
  LibGestionParamXML,
  lib_chaine,
  jpeg;

type
  TTauxAmortissement = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaTauxAmortissement: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    BtnAnnuler: TBitBtn;
    btnEnregister: TBitBtn;
    EditTauxDegressif: TCurrencyEdit;
    EditTauxLineaire: TCurrencyEdit;
    procedure btnEnregisterClick(Sender: TObject);
    function CtrlInfosTauxAmortissement(EditCourant:TCustomEdit;CtrlSuivant:twincontrol):TErreurSaisie;
    procedure EditTauxDegressifExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    TauxDegressif,TauxLineaire:currency;
  end;

var
  TauxAmortissement: TTauxAmortissement;

implementation

uses E2_Main;

{$R *.DFM}

function TTauxAmortissement.CtrlInfosTauxAmortissement(EditCourant:TCustomEdit;CtrlSuivant:twincontrol):TErreurSaisie;
var
tab:variant;
begin
result.CodeErreur:=0;
result.retour:=true;
  case EditCourant.Tag of
  2:Begin //si EditLibelleTrame
      if empty(editcourant.text)then
        Begin
          showmessage('Vous devez saisir un Taux.');
          result.CodeErreur:=2000;
          result.retour:=false;
        End
      else
        if editcourant.Text<EditTauxLineaire.Text then
          begin
          application.MessageBox(Pchar('Ce Taux ne peut être inférieur au Taux Linéaire.'),'Erreur de saisie',0);
          result.CodeErreur:=2001;
          result.Retour:=false;
          end;
        if result.Retour then

          TauxDegressif:=StrToCurr_Lgr(editcourant.Text);
    end;
  end;//fin du case tag
end;


procedure TTauxAmortissement.btnEnregisterClick(Sender: TObject);
var
i:integer;
EditCourant:TCustomEdit;
valide:TErreurSaisie;
begin
//Vérifier que les infos soit cohérentes
  try
   if ActiveControl<>btnAnnuler then
     begin //si activeControl<>btannuler
       For i:=0 to PaTauxAmortissement.controlcount -1  do
       begin //début boucle for
         if ((PaTauxAmortissement.Controls[i] is TCustomEdit)and((PaTauxAmortissement.Controls[i] as TCustomEdit).enabled)) then
           begin //si control est un customedit enabled
            EditCourant:=(PaTauxAmortissement.Controls[i] as TCustomEdit);
            if (EditCourant is TcurrencyEdit)then
              valide:=CtrlInfosTauxAmortissement((EditCourant as TcurrencyEdit),nil);
            if not valide.retour then
              begin
              EditCourant.SetFocus;
              abort;
              end;
           end;//fin si control est un customedit enabled
       end;//fin boucle for
     end;//fin si activecontrol<>btnAnnuler
  except
   abort;
  end;//fin du try except

end;

procedure TTauxAmortissement.EditTauxDegressifExit(Sender: TObject);
var
valide:TErreurSaisie;
begin
valide:=CtrlInfosTauxAmortissement(EditTauxDegressif,nil);
 if not valide.Retour then
   begin
     EditTauxDegressif.SetFocus;
     abort;
   end;
end;

procedure TTauxAmortissement.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
EditTauxLineaire.Text:=floattostr(TauxLineaire);
EditTauxDegressif.Text:=floattostr(TauxDegressif);
EditTauxDegressif.SetFocus;
end;

procedure TTauxAmortissement.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_RETURN then
   begin
   ActiveControl := FindNextControl(ActiveControl, true, true, false);
   end;
end;

procedure TTauxAmortissement.FormCreate(Sender: TObject);
begin
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      //InitialiseFormPosDefaut(self);
  end;
end;

procedure TTauxAmortissement.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,E.User);
TauxAmortissement:=nil;
end;

end.
