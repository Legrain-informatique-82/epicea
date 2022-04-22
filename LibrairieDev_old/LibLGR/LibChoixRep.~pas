unit LibChoixRep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, Buttons,FileUtil;

type
  TParamLibChoixRepAffiche = Record
   TitreForm:String;
   TitreDialogRep:String;
   RepDefaut:String;
   AfficheRepDefDansEdit:Boolean;
  end;

 TResultChoixRep = Record
  Retour:Boolean;
  RepChoisi:String;
 End;

  TChoixRep = class(TForm)
    EdRepertoire: TEdit;
    LaRepertoire: TLabel;
    SPParcourir: TSpeedButton;
    BtnValider: TButton;
    BtnAnnuler: TButton;
    PopupMenu1: TPopupMenu;
    Parcourir1: TMenuItem;
    procedure SPParcourirClick(Sender: TObject);
    procedure BtnValiderClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    ParamLibChoixRep:TParamLibChoixRepAffiche;
  end;

var
  ChoixRep: TChoixRep;
  Function LibChoixRepAffiche(ParamLibChoixRepAffiche:TParamLibChoixRepAffiche):TResultChoixRep;

implementation

//uses LibFichREp;
{$R *.dfm}
Function LibChoixRepAffiche(ParamLibChoixRepAffiche:TParamLibChoixRepAffiche):TResultChoixRep;
Begin
if ChoixRep = nil then ChoixRep:=TChoixRep.Create(Application.MainForm);
ChoixRep.ParamLibChoixRep:= ParamLibChoixRepAffiche;
ChoixRep.Caption := ParamLibChoixRepAffiche.TitreForm;
ChoixRep.EdRepertoire.Text := ParamLibChoixRepAffiche.RepDefaut;
Result.Retour := (ChoixRep.ShowModal=mrOk);
if Result.Retour then
 begin
  Result.RepChoisi := ChoixRep.EdRepertoire.Text;
 end;
ChoixRep.Free;
ChoixRep := nil;
//
End;


procedure TChoixRep.SPParcourirClick(Sender: TObject);
begin
if BrowseDirectory(ParamLibChoixRep.RepDefaut,ParamLibChoixRep.TitreDialogRep,0) then
 EdRepertoire.Text:=ParamLibChoixRep.RepDefaut;
end;

procedure TChoixRep.BtnValiderClick(Sender: TObject);
begin
if not DirectoryExists(EdRepertoire.Text) then
 begin
  Showmessage('Le répertoire : '+EdRepertoire.Text+' n''existe pas ! ');
  ModalResult:=mrNone;
  abort;
 end
end;

end.
