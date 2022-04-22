unit juridique;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, Mask, DBCtrls,db, RXCtrls;

type
  TInfosJuridiques = class(TForm)
    RxLabNomSoc: TRxLabel;
    RxLabel1: TRxLabel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    PaBas: TPanel;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    RxLabel2: TRxLabel;
    DBEdit3: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  InfosJuridiques: TInfosJuridiques;


  function AfficheInfosJuridique:boolean;


implementation

uses DMParamEnt, LibSQL, E2_Librairie_Obj;

{$R *.dfm}


function AfficheInfosJuridique:boolean;
begin
 if(DMParamEntreprise=nil )then DMParamEntreprise:=TDMParamEntreprise.Create(application.MainForm);
 if(InfosJuridiques=nil) then InfosJuridiques:=TInfosJuridiques.Create(application.MainForm);

 result:=InfosJuridiques.ShowModal=mrOk;
end;
procedure TInfosJuridiques.FormShow(Sender: TObject);
begin
if(DMParamEntreprise.Ta_infosJuridique.RecordCount=0)then
   DMParamEntreprise.Ta_infosJuridique.insert;
end;

procedure TInfosJuridiques.BtnAnnulerClick(Sender: TObject);
begin
if(DMParamEntreprise.Ta_infosJuridique.State in [dsInsert,dsEdit])then
  begin
      TableGereCancel(DMParamEntreprise.Ta_infosJuridique);
  end;
end;

procedure TInfosJuridiques.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
BtnAnnuler.Click;
end;

procedure TInfosJuridiques.BtnEnregistrerClick(Sender: TObject);
begin
if(DMParamEntreprise.Ta_infosJuridique.State in [dsInsert,dsEdit])then
begin
     TableGerePost(DMParamEntreprise.Ta_infosJuridique);
     Init_E_Entreprise_Avec_TaParamEntreprise;
end;
end;

procedure TInfosJuridiques.FormDestroy(Sender: TObject);
begin
if(DMParamEntreprise.Ta_infosJuridique.State in [dsInsert,dsEdit])then
  begin
      TableGereCancel(DMParamEntreprise.Ta_infosJuridique);
  end;
InfosJuridiques:=nil;
end;

end.
