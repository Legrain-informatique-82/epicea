unit E2_ParamParoisse;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RXCtrls, StdCtrls, Mask, ToolEdit, CurrEdit, Menus, ExtCtrls,DMParamTaxes,LibZoneSaisie,GR_Librairie_Obj,
  E2_Main,E2_Librairie_Obj,registry,DMConstantes, LibGestionParamXML, jpeg;

type
  TParamParoisse = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Insrer1: TMenuItem;
    Modifier1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    Pafond: TPanel;
    RxLabel1: TRxLabel;
    RxLabel3: TRxLabel;
    CurrencyEdit1: TCurrencyEdit;
    CurrencyEdit3: TCurrencyEdit;
    CurrencyEdit2: TCurrencyEdit;
    RxLabel2: TRxLabel;
    PaAide: TPanel;
    MemoAide: TMemo;
    PaCptIntit: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure CurrencyEdit1Enter(Sender: TObject);
    procedure CurrencyEdit1Exit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CurrencyEdit1Change(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;
const
 MessParamParoisseCurrencyEdit1='Saisissez le montant de la contribution par habitant au Diocèse';
 MessParamParoisseCurrencyEdit2='Saisissez le nombre d''habitant de la Paroisse';
 MessParamParoisseCurrencyEdit3='Saisissez le montant de la pastorale des Jeunes';
 MessParamParoisseGeneral='Ci-contre les différents paramètres de votre Paroisse';

var
  ParamParoisse: TParamParoisse;

implementation

{$R *.DFM}

procedure TParamParoisse.FormActivate(Sender: TObject);
begin

CouleurFond([CurrencyEdit1,CurrencyEdit2,CurrencyEdit3],ParamUtil.CouleurDBGrid.GrilleColorFond);

if DMParamTaxe = nil then DMParamTaxe:=TDMParamTaxe.Create(Application.MainForm);
if not DMParamTaxe.TaParamTaxe.Active then DMParamTaxe.TaParamTaxe.Open;
DMParamTaxe.TaParamTaxe.First;
CurrencyEdit1.Value:=DMParamTaxe.TaParamTaxe.findField('Montant').AsCurrency;
DMParamTaxe.TaParamTaxe.Next;
CurrencyEdit3.Value:=DMParamTaxe.TaParamTaxe.findField('Montant').AsCurrency;
CurrencyEdit1.OnChange:=CurrencyEdit1Change;
CurrencyEdit2.OnChange:=CurrencyEdit1Change;
CurrencyEdit3.OnChange:=CurrencyEdit1Change;
end;

procedure TParamParoisse.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TParamParoisse.BtnAnnulerEnter(Sender: TObject);
begin
  BouttonDiminue(sender as TButton);
  MemoAide.Lines.Add('');
  MemoAide.Lines.Add(MessParamParoisseGeneral);
end;

procedure TParamParoisse.BtnAnnulerExit(Sender: TObject);
begin
  BouttonAgrandit(sender as TButton);
  MemoAide.Lines.Clear;
end;

procedure TParamParoisse.CurrencyEdit1Enter(Sender: TObject);
begin
CouleurActivecontrolLabel(ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond,nil,0,0);
//MessParamParoisseCurrencyEdit3
if (sender as TCurrencyEdit).Name = 'CurrencyEdit1' then
 begin
  MemoAide.Lines.Add('');
  MemoAide.Lines.Add(MessParamParoisseCurrencyEdit1);
 end;
if (sender as TCurrencyEdit).Name = 'CurrencyEdit2' then
 begin
  MemoAide.Lines.Add('');
  MemoAide.Lines.Add(MessParamParoisseCurrencyEdit2);
 end;
if (sender as TCurrencyEdit).Name = 'CurrencyEdit3' then
 begin
  MemoAide.Lines.Add('');
  MemoAide.Lines.Add(MessParamParoisseCurrencyEdit3);
 end;
end;

procedure TParamParoisse.CurrencyEdit1Exit(Sender: TObject);
begin
CouleurDeActivecontrolLabel(lastZoneEdit,ParamUtil.CouleurDBGrid.GrilleColorFond,nil,0,0);
  MemoAide.Lines.Clear;
end;

procedure TParamParoisse.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Shift=[] then WinSuivPrec(Handle,key,[nil]);
if (KEY = VK_ESCAPE) then
   begin
     if BtnEnregistrer.Enabled then
      begin
       If Messagedlg('Voulez-vous annuler les modifications de vos paramètres ?',mtconfirmation,[mbyes,mbno],0) = mryes Then
         begin
          BtnEnregistrer.Enabled:=false;
          
          exit;
         End
         Else
         Begin
          abort;
         End;
      end
       else
      Begin
       if not activeControl.ClassNameIs('TCurrencyEdit') then
         CurrencyEdit1.SetFocus else
       self.close;
      End;
   end;
end;

procedure TParamParoisse.BtnEnregistrerClick(Sender: TObject);
Var
  Registre :TRegistry;
Begin
  Registre:= TRegistry.Create;
  try
     with Registre do begin
        RootKey := HKEY_LOCAL_MACHINE;
        OpenKey('\SOFTWARE\LGR\Epicea2\' + self.Name, True);
        begin
          WriteInteger('NbHabitant',CurrencyEdit2.AsInteger);
        end;
        CloseKey;
     end;
  finally
     Registre.Free;
  end;
BtnFermer.SetFocus;
BtnEnregistrer.Enabled:=false;
Enregister1.Enabled:=false;
end;

procedure TParamParoisse.FormCreate(Sender: TObject);
var
Registre :TRegistry;
Begin
CurrencyEdit1.OnChange:=nil;
CurrencyEdit2.OnChange:=nil;
CurrencyEdit3.OnChange:=nil;
 Registre:= TRegistry.Create;
   try
     with Registre do
       begin
       RootKey := HKEY_LOCAL_MACHINE;
       OpenKey('\SOFTWARE\LGR\Epicea2\'+ self.Name, false);
          try
            CurrencyEdit2.Value:=ReadInteger('NbHabitant');
          except
            CurrencyEdit2.Value:=0;
          end;
       end;//fin du with
   finally
     Registre.Free;
   end;
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;

end;

procedure TParamParoisse.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(self,E.User);
ParamParoisse:=nil;
end;

procedure TParamParoisse.CurrencyEdit1Change(Sender: TObject);
begin
BtnEnregistrer.Enabled:=true;
Enregister1.Enabled:=true;
end;

procedure TParamParoisse.BtnFermerClick(Sender: TObject);
begin
self.Close;
end;

procedure TParamParoisse.BtnAnnulerClick(Sender: TObject);
begin
self.close;
end;

end.
