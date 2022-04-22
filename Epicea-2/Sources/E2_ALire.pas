unit E2_ALire;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, gr_Librairie_obj, Buttons, RxRichEd,LibGestionParamXML, DMConstantes;

type
  TALire = class(TForm)
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
    RxRichEdit1: TRxRichEdit;
    procedure Calculatrice1Click(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pmMenu1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  ALire: TALire;

implementation
{$R *.DFM}
Uses E2_Librairie_obj;
//, Gr_Calculatrice;

procedure TALire.Calculatrice1Click(Sender: TObject);
begin
	AfficheCalculatrice(nil);
end;

procedure TALire.Fermer1Click(Sender: TObject);
begin
	Self.Close;
end;

procedure TALire.FormCreate(Sender: TObject);
begin
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
        InitialiseFormPosDefaut(self);
    end;
   RxRichEdit1.Lines.LoadFromFile(E.RepertoireProgram+'Alire.doc');
end;

procedure TALire.FormDestroy(Sender: TObject);
begin
  	LibGestionParamXML.DestroyForm(Self,E.USer);
    ALire:=nil;
end;

procedure TALire.pmMenu1Click(Sender: TObject);
begin
	PopupMenu1.Popup(Left + 50, Top + 50);
end;

procedure TALire.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if Key = VK_ESCAPE then
        begin
   	Key:= 0;
      Self.Close;
   end;
end;

end.
