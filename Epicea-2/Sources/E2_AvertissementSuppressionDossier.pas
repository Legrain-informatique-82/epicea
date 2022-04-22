unit E2_AvertissementSuppressionDossier;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls,  RXCtrls, jpeg, ExtCtrls, StdCtrls,
  LibZoneSaisie,
  FM_INIT_COLOR,
  LibRessourceString, Menus, ShellCtrls;

type

 TParamAfficheAvertissementSuppressionDossier=Record
   DossierACherche:String;
   Tag:Integer;
   SaisieNomDossier:Boolean;
 end;

  TAvertissementSuppressionDossier = class(TT_INIT_COLOR)
    Patitre: TPanel;
    ImEnTete: TImage;
    PaDateDeb: TPanel;
    ShellListView1: TShellListView;
    PaBtn: TPanel;
    BtnEnregistrer: TButton;
    BtnAnnuler: TButton;
    PopupMenu1: TPopupMenu;
    Annuler1: TMenuItem;
    Valider1: TMenuItem;
    RxLabel2: TRxLabel;
    RxLabel1: TRxLabel;
    RxLaDir: TRxLabel;
    RxLabel4: TRxLabel;
    RxLabel3: TRxLabel;
    Panel1: TPanel;
    RxLabTitre: TRxLabel;
    Panel2: TPanel;
    RxLabel5: TRxLabel;
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
    DossierAAtteindre:String;
    TitreForm,SousTitreForm:string;
  end;

var
  AvertissementSuppressionDossier: TAvertissementSuppressionDossier;

  Function AvertissementSuppressionDossierAffiche(ParamAfficheAvertissementSuppressionDossier:TParamAfficheAvertissementSuppressionDossier):Boolean;

implementation

{$R *.dfm}

procedure TAvertissementSuppressionDossier.BtnEnregistrerClick(
  Sender: TObject);
begin
if application.MessageBox(Pchar('Si vous confirmez la suppression de votre dossier, le r�pertoire '+ShellListView1.RootFolder.PathName+' sera compl�tement supprim�,'+RetourChariotDouble+
'Etes-vous s�r de vouloir supprim� tout ce r�pertoire ?'+RetourChariotDouble+
'Si vous avez un doute, appelez le service maintenance'),'Attention',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mrno then
modalResult:=mrno;
end;


Function AvertissementSuppressionDossierAffiche(ParamAfficheAvertissementSuppressionDossier:TParamAfficheAvertissementSuppressionDossier):Boolean;
Begin
  if (AvertissementSuppressionDossier = nil) then AvertissementSuppressionDossier:=TAvertissementSuppressionDossier.Create(Application.MainForm);
  AvertissementSuppressionDossier.Tag :=ParamAfficheAvertissementSuppressionDossier.Tag;
//  ParamAfficheAvertissementSuppressionDossier.DossierACherche:='';
//  if ParamAfficheAvertissementSuppressionDossier.SaisieNomDossier then
//   begin
//    if not InputQuery('Atteindre le dossier ...','CODE du dossier : ',ParamAfficheAvertissementSuppressionDossier.DossierACherche) then
//    ParamAfficheAvertissementSuppressionDossier.DossierACherche:='';
//   end;
  AvertissementSuppressionDossier.TitreForm := 'R�pertoire qui va �tre supprim�';
  AvertissementSuppressionDossier.SousTitreForm := 'Contenu du r�pertoire � supprimer : '+RetourChariotSimple+ParamAfficheAvertissementSuppressionDossier.DossierACherche;
  AvertissementSuppressionDossier.RxLabTitre.Caption:=AvertissementSuppressionDossier.SousTitreForm;
  AvertissementSuppressionDossier.DossierAAtteindre := uppercase(ParamAfficheAvertissementSuppressionDossier.DossierACherche);
  AvertissementSuppressionDossier.ShellListView1.Root:=AvertissementSuppressionDossier.DossierAAtteindre;
  AvertissementSuppressionDossier.RxLaDir.caption:=AvertissementSuppressionDossier.DossierAAtteindre;
  AvertissementSuppressionDossier.RxLabel5.caption:='Si vous avez un doute '+AppelerServiceMaintenanceSimple;
  Result:=AvertissementSuppressionDossier.ShowModal=MrOk;
End;
procedure TAvertissementSuppressionDossier.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
if Key = VK_ESCAPE then
      begin
    Key:= 0;
    BtnAnnuler.Click;
 end;
end;

procedure TAvertissementSuppressionDossier.BtnAnnulerClick(
  Sender: TObject);
begin
modalResult:=Mrcancel;
end;

procedure TAvertissementSuppressionDossier.PaBtnResize(Sender: TObject);
begin
   FormateTailleBoutton([BtnAnnuler,BtnEnregistrer],PaBtn,90,0);
end;

procedure TAvertissementSuppressionDossier.FormCreate(Sender: TObject);
begin
 inherited;
    TypeInitForm := C_MODELE_COLOREPI;

end;

procedure TAvertissementSuppressionDossier.FormActivate(Sender: TObject);
begin
  inherited;
BtnEnregistrer.Caption:='Continuer [F3]';
end;

end.
