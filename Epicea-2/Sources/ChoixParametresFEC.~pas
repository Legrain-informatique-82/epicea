unit ChoixParametresFEC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RXCtrls, jpeg, ExtCtrls,E2_Decl_Records;

type






  TU_ChoixParametreFEC = class(TForm)
    PaBas: TPanel;
    PaDateDeb: TPanel;
    PaBtn: TPanel;
    BtnEnregistrer: TButton;
    BtnAnnuler: TButton;
    Patitre: TPanel;
    ImEnTete: TImage;
    PaTitrePetit: TPanel;
    RxLabTitre: TRxLabel;
    LaRepertoire: TLabel;
    Label1: TLabel;
    CheckBoxDatePiece: TCheckBox;
    CbSeparteur: TComboBox;
    CbExtension: TComboBox;
    btnSauverParam: TButton;
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure btnSauverParamClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  U_ChoixParametreFEC: TU_ChoixParametreFEC;
  Function ChoixParamFECAffiche():TResultChoixParamFEC;

implementation

uses E2_Librairie_Obj, LibGestionParamXML, DMXMLs, lib_chaine;

{$R *.dfm}

procedure TU_ChoixParametreFEC.BtnEnregistrerClick(Sender: TObject);
begin
ModalResult:=mrOk;
end;

Function ChoixParamFECAffiche():TResultChoixParamFEC;
Begin
RecupXmlDossier(E.NomDossier);
if U_ChoixParametreFEC = nil then U_ChoixParametreFEC:=TU_ChoixParametreFEC.Create(Application.MainForm);
U_ChoixParametreFEC.CbExtension.ItemIndex:=U_ChoixParametreFEC.CbExtension.Items.IndexOf(E.ExtensionFEC);
U_ChoixParametreFEC.CbSeparteur.ItemIndex := U_ChoixParametreFEC.CbSeparteur.Items.IndexOf(E.SeparateurFEC);
if(E.DatePieceFEC)then
U_ChoixParametreFEC.CheckBoxDatePiece.State := cbChecked
else
U_ChoixParametreFEC.CheckBoxDatePiece.State := cbUnchecked;
Result.Retour := (U_ChoixParametreFEC.ShowModal=mrOk);
if Result.Retour then
 begin
  Result.Extension := U_ChoixParametreFEC.CbExtension.Text;
  if(U_ChoixParametreFEC.CbSeparteur.Text='Tab') then
     Result.Separateur := #09
  else
  Result.Separateur := U_ChoixParametreFEC.CbSeparteur.Text;
  Result.DatePieceDansDateEcriture := U_ChoixParametreFEC.CheckBoxDatePiece.State=cbChecked;
 end;
U_ChoixParametreFEC.Free;
U_ChoixParametreFEC := nil;
//
End;

procedure TU_ChoixParametreFEC.BtnAnnulerClick(Sender: TObject);
begin
ModalResult := mrCancel;
end;

procedure TU_ChoixParametreFEC.btnSauverParamClick(Sender: TObject);
begin
DMXml.ModifieVarDos(E.NomDossier,CXML_ExtensionFEC,U_ChoixParametreFEC.CbExtension.Text);
DMXml.ModifieVarDos(E.NomDossier,CXML_SeparateurFEC,U_ChoixParametreFEC.CbSeparteur.Text);
DMXml.ModifieVarDos(E.NomDossier,CXML_DatePieceFEC,str_bool2str(U_ChoixParametreFEC.CheckBoxDatePiece.State=cbChecked));
end;

end.
