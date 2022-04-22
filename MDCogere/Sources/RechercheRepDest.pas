unit RechercheRepDest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ShellCtrls, StdCtrls,  ExtCtrls;

type
  TFormChoixRepDest = class(TForm)
    Panel2: TPanel;
    ShellTreeView1: TShellTreeView;
    ButtonOK: TButton;
    ButtonAnnuler: TButton;
    laMessageTitre: TLabel;
    procedure ButtonAnnulerClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonCreerRepClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    chemin:string;
    RepInitial:string;
    messageTitre:string;
    FontTitre:TFont;
  end;

var
  FormChoixRepDest: TFormChoixRepDest;
  //chemin:string;

implementation



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
//      longueur:=0;
//      longueur:=length('ftp://');
//      longueur:= longueur + length(Form1.EditUtilisateur.Text);
//      longueur:= longueur + length(':');
//      longueur:= longueur + length(Form1.EditUtilisateur.Text);
//      longueur:= longueur + length('@');
//      longueur:= longueur + length(Form1.EditServeur.Text);
      FormChoixRepDest.chemin:=FormChoixRepDest.ShellTreeView1.Path;
      //chemin:=copy(chemin,longueur,length(chemin));
  end;

  procedure TFormChoixRepDest.ButtonOKClick(Sender: TObject);
  begin
      InitialiseChemin;
//      Form1.EditDestination.Text:=chemin;
//      Form1.EditDestination.SetFocus;
      FormChoixRepDest.Close;
  end;

  procedure TFormChoixRepDest.ButtonCreerRepClick(Sender: TObject);
      //création d'un nouveau dossier
  begin
      //if EditCreerRep.Text<>'' then begin
//          creation_rep:=true;
//          InitialiseChemin;
//          DMFtp.IdFTP1.Connect;
//          try
//              DMFtp.IdFTP1.ChangeDir(chemin);
//              Creer_Rep(DMFtp.IdFTP1,EditCreerRep.Text);
//              //DMFtp.IdFTP1.MakeDir(EditCreerRep.Text);
//          except
//              showmessage('Le dossier n''a pas pu être créer');
//          end;
//          DMFtp.IdFTP1.Quit;
//          creation_rep:=false;
//          ShellTreeView1.Path:=ShellTreeView1.Path+'/'+EditCreerRep.Text;
//      end
//      else
//          showmessage('Veuillez saisir un nom de dossier');
  end;

procedure TFormChoixRepDest.FormActivate(Sender: TObject);
begin
      ShellTreeView1.Path:=RepInitial;
end;

end.
