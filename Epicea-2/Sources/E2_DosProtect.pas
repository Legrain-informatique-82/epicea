unit E2_DosProtect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls,gr_Librairie_Obj, ExtCtrls, RXCtrls,E2_Librairie_Obj,LibZoneSaisie,
  DMProgramme,Gr_MultDos,LibGestionParamXML, DMConstantes, Gauges;

type
  TDosProtect = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TRxSpeedButton;
    Edit1: TEdit;
    Edit2: TEdit;
    SpeedButton2: TRxSpeedButton;
    SpeedButton3: TRxSpeedButton;
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure Edit2Enter(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  DosProtect: TDosProtect;

  Function DosProtectAffiche(var User: string):boolean;
implementation

uses E2_AutreDossier, E2_CreatDos,E2_Logo,  DMBaseDonnee, E2_Main,
  LibRessourceString, E2_Decl_Records, ImportDll;

{$R *.DFM}

//******************************************************************************
//******************************************************************************
//******************* DosProtectAffiche *************************
//******************************************************************************
//******************************************************************************
// Affiche l'�cran d'identification de l'user et de choix de dossier
//******************************************************************************
//******************************************************************************
//******************************************************************************
Function DosProtectAffiche(var User:string):boolean;
Begin
   result:=false;
   if (DosProtect = nil) then DosProtect:=TDosProtect.Create(Application);
   if Logo <> nil then
     begin
       DosProtect.Width:=Logo.imFond.Width+5;
       DosProtect.Height:=Logo.Height+5;
       DosProtect.SpeedButton1.Caption:='&Activer : ' + GEstDossierNomDossier(IntTostr(E.ID_Dos));
//       DosProtect.Bevel1.Top:=4;
//       DosProtect.Bevel1.Left:=4;
//       DosProtect.Bevel1.Width:=DosProtect.Width-8;
//       DosProtect.Bevel1.Height:=DosProtect.Height-8;
     end;
   DosProtect.Edit2.Text:=User;
   Repeat
     Result:= (DosProtect.ShowModal = mrOk);
   Until (((result = true) and (not empty(DosProtect.Edit2.Text)))or(result=false));
     if result then
        Begin
         User:=DosProtect.Edit2.Text;
        End
     else
       begin
         FermerDossier(e);
         application.Terminate;
       end;
End;
//******************************************************************************



procedure TDosProtect.SpeedButton2Click(Sender: TObject);
var
result:boolean;
begin
   if (AutreDossier = nil) then AutreDossier:=TAutreDossier.Create(self);
   result:=AutreDossier.showModal=mrOk;
   if result then SpeedButton1.Caption:='&Activer : ' +GEstDossierNomDossier(IntTostr(E.ID_Dos));


//self.close;
end;

procedure TDosProtect.SpeedButton3Click(Sender: TObject);
begin
	if (CreatDos = nil) then CreatDos:=TCreatDos.Create(self);
	CreatDos.showModal;
//self.close;
end;

procedure TDosProtect.SpeedButton1Click(Sender: TObject);
begin
//DMBD.InitBDDossier(DMProg.Query1.findField('Dir_Dossier').AsString);
//DMBD.InitBDExercice(DMProg.Query1.findField('Dir_Exo').AsString);
//Main.OuvreExo(DMProg.Query1.findField('Nom_Dossier').AsString,DMProg.Query1.findField('Nom_Exo').AsString);
end;

procedure TDosProtect.FormCreate(Sender: TObject);
begin
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
        InitialiseFormPosDefaut(self);
    end;
end;

procedure TDosProtect.FormDestroy(Sender: TObject);
begin
  LibGestionParamXML.DestroyForm(Self,E.USer);
   DosProtect:=nil;
end;

procedure TDosProtect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if self.ModalResult = mrok then
 begin
   OuvreExercice(E.NomDossier,E.NomExo);
//   Main.OuvreExo(E.NomDossier,E.NomExo);
//   LibGestionParamXML.DestroyForm(self,E.USer);
 end;
end;

procedure TDosProtect.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then
Begin
  key:=#0;
  SpeedButton1.Click;
End;

end;

procedure TDosProtect.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
CouleurFond([Edit1,Edit2],ParamUtil.CouleurDBGrid.GrilleColorFond);
Edit2.SetFocus;
end;

procedure TDosProtect.Edit2Enter(Sender: TObject);
begin
CouleurActivecontrolLabel(clYellow,nil,0,0);
end;

procedure TDosProtect.Edit2Exit(Sender: TObject);
begin
CouleurDeActivecontrolLabel((Sender as TEdit),ParamUtil.CouleurDBGrid.GrilleColorFond,nil,0,0);
end;

procedure TDosProtect.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key <> vk_return then
if Shift=[] then WinSuivPrec(Handle,key,[nil]);
 if Key = VK_ESCAPE then
 begin
  key:=0;
      if Messagedlg(PChar('�tes-vous s�r de vouloir quitter Epic�a ?'),mtconfirmation, [mbno,mbyes],0) = mryes then
       begin
         modalResult:=mrcancel;
       end;
 end;
if ((Shift = [ssCtrl])and(Key=67)) then
 begin
  E.ControleDuDossier:=false;
  E.ControleDuDossierEntrant:=false;
  MessageDlg('Contr�le du dossier d�sactiv� !', mtWarning, [mbOK], 0);
 end;
if (Shift = [ssCtrl,ssAlt])and(Key=89)
then
 begin
//  E.DateVersion:=C_Date+'-'+C_Version;
  E.DateVersion:=numVersion.DateVersion+'-'+numVersion.Version;
  MessageDlg('Dossier marqu� contr�l� !', mtWarning, [mbOK], 0);
 end;
end;

end.
