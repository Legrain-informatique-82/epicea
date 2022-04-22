unit Model;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, gr_Librairie, EpiceaControl, Buttons;

type
  TModel = class(TForm)
    PopupMenu1: TPopupMenu;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    pmMenu1: TMenuItem;
    procedure Calculatrice1Click(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure pmMenu1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Model: TModel;

implementation
{$R *.DFM}
Uses E2_Librairie, Gr_Calculatrice;

procedure TModel.Calculatrice1Click(Sender: TObject);
begin
	AfficheCalculatrice(ActiveControl);
end;

procedure TModel.Fermer1Click(Sender: TObject);
begin
	Self.Close;
end;

procedure TModel.FormCreate(Sender: TObject);
begin
   InitialiseForm(Self);
end;

procedure TModel.FormDestroy(Sender: TObject);
begin
  	DestroyForm(Self);
end;

procedure TModel.FormKeyPress(Sender: TObject; var Key: Char);
begin
	if Key = #27 then begin
   	Key:= #0;
      Self.Close;
   end;
end;

procedure TModel.pmMenu1Click(Sender: TObject);
begin
	PopupMenu1.Popup(Left + 50, Top + 50);
end;

end.
