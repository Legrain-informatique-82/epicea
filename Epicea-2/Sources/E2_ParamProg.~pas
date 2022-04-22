unit E2_ParamProg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, checklst, ExtCtrls, Buttons,
  Gr_Librairie_obj,
  Db,
  DBTables,
  E2_Librairie_Obj,
  LibGestionParamXML,
  E2_Decl_Records,
  DMConstantes, RXCtrls, jpeg;

type
  TParamProg = class(TForm)
    Panel2: TPanel;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaBtn: TPanel;
    BtnEnregistrer: TButton;
    BtnAnnuler: TButton;
    RadioGroup1: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure BtAnnulClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  ParamProg: TParamProg;

implementation

uses DiversProjets;

{$R *.DFM}

procedure TParamProg.FormCreate(Sender: TObject);
begin
    try
     LibGestionParamXML.InitialiseForm(E.User,Self);
    except
     Position:=poScreenCenter;

    end;

end;

procedure TParamProg.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(self,E.USer);
ParamProg:=nil;
end;

procedure TParamProg.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if (sender as TEdit).SelStart = 0 then
           if Key = #48 then Key:=#49;

end;

procedure TParamProg.BtAnnulClick(Sender: TObject);
var
key:word;
begin
  key:=vk_cancel;
  formKeyDown(self,key,[]);
end;

procedure TParamProg.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  canclose:=true;
end;

procedure TParamProg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = VK_ESCAPE then
 begin
  key:=0;
      if Messagedlg(PChar('Êtes-vous sûr de vouloir quitter Epicéa ?'),mtconfirmation, [mbno,mbyes],0) = mryes then
       begin
         modalResult:=mrcancel;
       end;
 end;
end;

procedure TParamProg.BtnAnnulerClick(Sender: TObject);
var
key:word;
begin
  key:=vk_cancel;
  formKeyDown(self,key,[]);
  Application.Terminate;
end;

procedure TParamProg.FormActivate(Sender: TObject);
begin
if(e.TypeUtilisateur=U_Demo)then RxLabTitre.Caption := 'Version Démo' else RxLabTitre.Caption :='Dossier Démo';
  case e.TypeDossier of
    VerGeneral,VerDemoGeneral:Begin
                                  if(e.TypeClient=CL_Association) then
                                  begin
                                    RadioGroup1.Buttons[0].Checked:=false; RadioGroup1.Buttons[0].Enabled:=true;
                                    RadioGroup1.Buttons[1].Checked:=false; RadioGroup1.Buttons[1].Enabled:=false;
                                    RadioGroup1.Buttons[2].Checked:=true;  RadioGroup1.Buttons[2].Enabled:=false;
                                  end
                                  else
                                  begin
                                    RadioGroup1.Buttons[0].Checked:=true;  RadioGroup1.Buttons[0].Enabled:=e.TypeDossier=VerDemoGeneral;
                                    RadioGroup1.Buttons[1].Checked:=false; RadioGroup1.Buttons[1].Enabled:=true;
                                    RadioGroup1.Buttons[2].Checked:=false; RadioGroup1.Buttons[2].Enabled:=false;
                                  end;
                              end;
    VerAgricole,VerDemoAgri:Begin
                                  if(e.TypeClient=CL_Association) then
                                  begin
                                    RadioGroup1.Buttons[0].Checked:=false; RadioGroup1.Buttons[0].Enabled:=false;
                                    RadioGroup1.Buttons[1].Checked:=false; RadioGroup1.Buttons[1].Enabled:=false;
                                    RadioGroup1.Buttons[2].Checked:=true; RadioGroup1.Buttons[2].Enabled:=true;
                                  end
                                  else
                                  begin
                                    RadioGroup1.Buttons[0].Checked:=false;RadioGroup1.Buttons[0].Enabled:=true;
                                    RadioGroup1.Buttons[1].Checked:=true; RadioGroup1.Buttons[1].Enabled:=true;
                                    RadioGroup1.Buttons[2].Checked:=false; RadioGroup1.Buttons[2].Enabled:=false;
                                  end;
                              end;
  end;//fin du case
end;

end.
