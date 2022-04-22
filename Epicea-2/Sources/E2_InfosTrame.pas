unit E2_InfosTrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RXCtrls, ExtCtrls,E2_Decl_Records, Buttons,Gr_Librairie_Obj,E2_SaisieP_3,
  Piece,DMEcriture,DMPiece,ModuleTrame,E2_Librairie_Obj,LibZoneSaisie,DMConstantes,LibSQL,LibRessourceString,
  LibGestionParamXML,
  jpeg;

type
  TInfosTrame = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaTrame: TPanel;
    Label1: TLabel;
    EditCodeTrame: TEdit;
    Label2: TLabel;
    EdLibellePiece: TEdit;
    ConserverMontants: TCheckBox;
    BtnAnnuler: TBitBtn;
    btnEnregister: TBitBtn;
    Label3: TLabel;
    EdLibelleTrame: TEdit;
    procedure btnEnregisterClick(Sender: TObject);
    function CtrlInfosTrame(EditCourant:TCustomEdit;CtrlSuivant:twincontrol):Texceptlgr;
    procedure EditCodeTrameExit(Sender: TObject);
    procedure EdLibellePieceExit(Sender: TObject);
    procedure ConserverMontantsExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EditCodeTrameChange(Sender: TObject);
    procedure EdLibelleTrameExit(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    VerifExistence:boolean;
  end;

var
  InfosTrame: TInfosTrame;


  function CreationTrameAffiche(LibellePiece:string):boolean;
implementation

uses DMRecherche;

{$R *.DFM}

procedure TInfosTrame.btnEnregisterClick(Sender: TObject);
var
i:integer;
EditCourant:TCustomEdit;
valide:TExceptLGR;
begin
//Vérifier que les infos soit cohérentes
ConserverMontantsExit(self);
  try
   if ActiveControl<>btnAnnuler then
     begin //si activeControl<>btannuler
       For i:=0 to PaTrame.controlcount -1  do
       begin //début boucle for
         if ((PaTrame.Controls[i] is TCustomEdit)and((PaTrame.Controls[i] as TCustomEdit).enabled)) then
           begin //si control est un customedit enabled
            EditCourant:=(PaTrame.Controls[i] as TCustomEdit);
            if (EditCourant is TEdit)then
              valide:=CtrlInfosTrame((EditCourant as TEdit),nil);
            if not valide.retour then
              begin
              EditCourant.SetFocus;
              abort;
              end;
           end;//fin si control est un customedit enabled
       end;//fin boucle for
     end;//fin si activecontrol<>btnAnnuler
  except
//   btnEnregister.ModalResult:=mrnone;
   ModalResult:=mrnone;
   abort;
  end;//fin du try except
end;

function TInfosTrame.CtrlInfosTrame(EditCourant:TCustomEdit;CtrlSuivant:twincontrol):Texceptlgr;
var
tab:variant;
begin
try//finally
try//except
// result.GestMessageLGR:=GestMessageLGR;
Initialise_ExceptLGR(result,GestMessageLGR);
 result.NomModule:='CtrlInfosTrame';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 
  case EditCourant.Tag of
  1:Begin //si EditCodeTrame
      if empty(editcourant.text)then
        Begin
          showmessage('Vous devez saisir le code de la Trame.');
          result.NumErreur:=1000;
          result.retour:=false;
        End
      else
      //vérifier si la trame n'existe pas déjà
        if DMTrame.VerifExistenceTrame(['Code'],[editcourant.text])then
          begin
            if application.MessageBox(Pchar('Ce code existe déjà dans une trame, voulez-vous modifier la trame existante ?'),'Abandon',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mrno then
                raise ExceptLGR.Create('',1001,false,mtError);
//            result.CodeErreur:=1001;
//            result.Retour:=false;
          end;
      //vérifier si code trame n'est pas déjà employé dans les codes de journaux
       FiltrageDataSet(DMRech.TaModelRech,'Code = '''+editcourant.text+'''');
       if DMRech.TaModelRech.RecordCount > 0 then
          begin
//            application.MessageBox(Pchar(''),'Erreur de saisie',0);
            raise ExceptLGR.Create('Ce code existe déjà dans les journaux, vous devez en saisir un autre ?',1002,true,mtError,Result);
//            result.CodeErreur:=1002;
//            result.Retour:=false;
          end;
        if result.Retour then
       DMTrame.Trame1.CodeTrame:=editcourant.text;
    end;
  2:Begin //si EdLibelleTrame
      if empty(editcourant.text)then
        Begin
          showmessage('Vous devez saisir le Libelle de la Trame.');
          result.NumErreur:=2000;
          result.retour:=false;
        End
      else
        if ((DMTrame.VerifExistenceTrame(['Libelle_Trame'],[editcourant.text]))and(not DMTrame.VerifExistenceTrame(['Code'],[DMTrame.Trame1.CodeTrame])))then
          begin
          if application.MessageBox(Pchar('Ce Libellé existe déjà dans une trame, voulez-vous le conserver ?'),'Erreur de saisie',0)=mrno then
            begin
            result.NumErreur:=2001;
            result.Retour:=false;
            end
          else
            EdLibellePiece.SetFocus;
          end;
        if result.Retour then
          DMTrame.Trame1.LibelleTrame:=editcourant.text;
    end;
  3:Begin //si EdLibellePiece
      if empty(editcourant.text)then
        Begin
          showmessage('Vous devez saisir le Libelle de la Pièce.');
          result.NumErreur:=2000;
          result.retour:=false;
        End;
        if result.Retour then
          DMTrame.Trame1.LibellePiece:=editcourant.text;
    end;
  end;//fin du case tag
except
  EditCourant.SetFocus;
  abort;
end;
finally
  result.GestMessageLGR.Enregistrement:=false;
end;//fin finally
end;


procedure TInfosTrame.EditCodeTrameExit(Sender: TObject);
var
valide:TExceptLGR;
begin
if ActiveControl<>BtnAnnuler then
  begin//si on ne veut pas annuler
  valide:=CtrlInfosTrame(EditCodeTrame,nil);
   if not valide.Retour then
     begin
       EditCodeTrame.SetFocus;
       abort;
     end;
  end;//fin si on ne veut pas annuler
end;

procedure TInfosTrame.EdLibellePieceExit(Sender: TObject);
var
valide:TExceptLGR;
begin
if ActiveControl<>BtnAnnuler then
  begin//si on ne veut pas annuler
  valide:=CtrlInfosTrame(EdLibellePiece,nil);
   if not valide.Retour then
     begin
       EdLibellePiece.SetFocus;
       abort;
     end;
  end;//fin si on ne veut pas annuler
end;


procedure TInfosTrame.ConserverMontantsExit(Sender: TObject);
begin
DMTrame.trame1.ConserveMontant:=ConserverMontants.Checked;
end;

procedure TInfosTrame.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Shift=[] then WinSuivPrec(Handle,key,[nil]);
//   if Key = VK_RETURN then
//   begin
//   ActiveControl := FindNextControl(ActiveControl, true, true, false);
//   end;
end;

procedure TInfosTrame.FormCreate(Sender: TObject);
begin
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      //InitialiseFormPosDefaut(self);
  end;
end;

procedure TInfosTrame.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,E.User);
InfosTrame:=nil;
end;

procedure TInfosTrame.FormActivate(Sender: TObject);
begin
VerifExistence:=true;
EditCodeTrame.text:='';
EditCodeTrame.Text:=DMTrame.Trame1.CodeTrame;
if DMTrame.TaTrame_Obj.Locate('code',DMTrame.Trame1.CodeTrame,[])then
begin
DMTrame.Trame1.LibellePiece:=DMTrame.TaTrame_Obj.findfield('Libelle').asstring;
DMTrame.Trame1.LibelleTrame:=DMTrame.TaTrame_Obj.findfield('Libelle_trame').asstring;
end;
EdLibellePiece.text:=DMTrame.Trame1.LibellePiece;
EdLibelleTrame.text:=DMTrame.Trame1.LibelleTrame;
ConserverMontants.Checked:=false;
EditCodeTrame.setfocus;
end;

procedure TInfosTrame.EditCodeTrameChange(Sender: TObject);
begin
EditCodeTrame.Text:=uppercase(EditCodeTrame.Text);
EditCodeTrame.SelStart:=length(EditCodeTrame.text);
end;

procedure TInfosTrame.EdLibelleTrameExit(Sender: TObject);
var
valide:TExceptLGR;
begin
if ActiveControl<>BtnAnnuler then
  begin//si on ne veut pas annuler
  valide:=CtrlInfosTrame(EdLibelleTrame,nil);
   if not valide.Retour then
     begin
       EdLibelleTrame.SetFocus;
       abort;
     end;
  end;//fin si on ne veut pas annuler
end;


function CreationTrameAffiche(LibellePiece:string):boolean;
// Initialise l'écran avec les valeurs de la ligne d'écriture
Begin
   if InfosTrame=nil then InfosTrame:=TInfosTrame.Create(application.MainForm);
   DMTrame.Trame1.LibelleTrame:=LibellePiece;
   DMTrame.Trame1.LibellePiece:=LibellePiece;
   Result:= (InfosTrame.ShowModal = mrOk);
   if result then
   Begin
     //Récupérer les valeurs dans les var

   End;
End;


end.
