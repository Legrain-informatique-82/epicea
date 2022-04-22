unit E2_InfosProtect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  LibFichRep,
  LibProtect,
  Dialogs, StdCtrls;

type
  TInfosProtect = class(TForm)
    LaNumDD: TLabel;
    Label1: TLabel;
    EdNom: TEdit;
    Label2: TLabel;
    EdPrenom: TEdit;
    EdNomSoc: TEdit;
    Edcp: TEdit;
    EdVille: TEdit;
    EdNumLic: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  InfosProtect: TInfosProtect;
  Function AfficheInfosProtect:TInfosUtilisateur;

implementation


{$R *.dfm}
Function AfficheInfosProtect:TInfosUtilisateur;
var
Utilisateur:TInfosUtilisateur;
Code1:String;
Begin
if InfosProtect = nil then InfosProtect:=TInfosProtect.create(application.MainForm);
Result.Nom:='Blanc';
Result.Prenom:='Philippe';
Result.NomSoc:='LeGrain';
Result.Adresse1Soc:='La Gare';
Result.Adresse2Soc:='La Gare';
Result.CP:='82130';
Result.Ville:='Monclar de Quercy';
Result.NumLic := '03090012';
Result.NbDossier := '01';
Result.NumDisk := '123124514';
Result.Options := '01204210';
InfosProtect.EdNom.Text := Result.Nom;
InfosProtect.EdPrenom.Text := Result.Prenom;
InfosProtect.EdNomSoc.Text := Result.NomSoc;
InfosProtect.EdNom.Text := Result.Nom;
InfosProtect.EdNom.Text := Result.Nom;
InfosProtect.EdNom.Text := Result.Nom;

InfosProtect.Showmodal;

Result.Nom:='Blanc';
Result.Prenom:='Philippe';
Result.NomSoc:='LeGrain';
Result.Adresse1Soc:='La Gare';
Result.CP:='82130';
Result.Ville:='Monclar de Quercy';
Result.NumLic := '03090012';
Result.NbDossier := '01';
Result.NumDisk := '123124514';
Result.Options := '01204210';
End;

procedure TInfosProtect.FormCreate(Sender: TObject);
begin
  LaNumDD.Caption := Inttostr(NumSerieDD('C:'));
end;

end.
