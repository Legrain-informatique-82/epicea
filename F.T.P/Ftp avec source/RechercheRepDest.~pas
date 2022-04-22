unit RechercheRepDest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ShellCtrls, StdCtrls, UDMFtp, ExtCtrls;

type
  TFormChoixRepDest = class(TForm)
    ShellTreeView1: TShellTreeView;
    ButtonOK: TButton;
    ButtonAnnuler: TButton;
    ButtonCreerRep: TButton;
    EditCreerRep: TEdit;
    Label1: TLabel;
    procedure ButtonAnnulerClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonCreerRepClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormChoixRepDest: TFormChoixRepDest;

implementation

uses ftp;
  var chemin:string;
{$R *.dfm}

  procedure TFormChoixRepDest.ButtonAnnulerClick(Sender: TObject);
      //ferme la fenêtre
  begin
      FormChoixRepDest.Close;
  end;

  procedure InitialiseChemin;
      //Ecrit dans chemin le chemin en cours dans l'arborescence
      //sans ftp://pass:util@serveur.fr
      var longueur: integer;
  begin
      longueur:=0;
      longueur:=length('ftp://');
      longueur:= longueur + length(Form1.EditUtilisateur.Text);
      longueur:= longueur + length(':');
      longueur:= longueur + length(Form1.EditUtilisateur.Text);
      longueur:= longueur + length('@');
      longueur:= longueur + length(Form1.EditServeur.Text);
      chemin:=FormChoixRepDest.ShellTreeView1.Path;
      chemin:=copy(chemin,longueur,length(chemin));
  end;

  procedure TFormChoixRepDest.ButtonOKClick(Sender: TObject);
  begin
      InitialiseChemin;
      Form1.EditDestination.Text:=chemin;
      Form1.EditDestination.SetFocus;
      FormChoixRepDest.Close;
  end;

  procedure TFormChoixRepDest.FormCreate(Sender: TObject);
      //affecte le repertoire racine de l'utilisateur sur le serveur FTP
      //à la racine de l'arborescence
  begin   
      ShellTreeView1.Root:='ftp://'+Form1.EditUtilisateur.Text+':'+Form1.EditPassWord.Text+'@'+Form1.EditServeur.Text;
  end;

  procedure TFormChoixRepDest.ButtonCreerRepClick(Sender: TObject);
      //création d'un nouveau dossier
  begin
      if EditCreerRep.Text<>'' then begin
          creation_rep:=true;
          InitialiseChemin;
          DMFtp.IdFTP1.Connect;
          try
              DMFtp.IdFTP1.ChangeDir(chemin);
              Creer_Rep(DMFtp.IdFTP1,EditCreerRep.Text);
              //DMFtp.IdFTP1.MakeDir(EditCreerRep.Text);
          except
              showmessage('Le dossier n''a pas pu être créer');
          end;
          DMFtp.IdFTP1.Quit;
          creation_rep:=false;
          ShellTreeView1.Path:=ShellTreeView1.Path+'/'+EditCreerRep.Text;
      end
      else
          showmessage('Veuillez saisir un nom de dossier');
  end;

end.
