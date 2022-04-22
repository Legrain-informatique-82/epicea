unit LibClassObjetSenders;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,Db,
  extctrls, stdctrls, ToolEdit,
  LibZoneSaisie,
  Gr_Librairie_Obj,
  LibDates,
  lib_chaine,
  E2_Librairie_Obj;

type
//  TExeProc = Procedure(Sender: TObject) of object;
  TLibClassObjetSender = class(TDataModule)
    Procedure SenderOnClick(sender: TObject);
    Procedure SenderOnPanelResize(sender: TObject);
    procedure SenderOnDateDebExit(Sender: TObject);
    procedure SenderOnDateFinExit(Sender: TObject);
    Procedure GestInterfaceEvent(CCourant:Tfield;sender:TObject = nil);
  private
//   FOnExecute:TExeProc;
   FOnExecute :TNotifyEvent;
   FOnPanelResize :TNotifyEvent;
   FOnDateExit:TNotifyEvent;
    { Déclarations privées }
    Procedure ExecProc(sender:TObject);
    Procedure ExecPanel(sender:TObject);
  public
    { Déclarations publiques }
//   Property OnExecProc :TExeProc Read FOnExecute Write FOnExecute;
   Property OnExecProc :TNotifyEvent Read FOnExecute Write FOnExecute;
   Property OnPanelResize:TNotifyEvent Read FOnPanelResize Write FOnPanelResize;
   Procedure InitPanelResize(sender: TObject);
  end;

var
  LibClassObjetSender: TLibClassObjetSender;

implementation

uses //E2_Main,
E2_Tiers, DMTTVA;

{$R *.DFM}

Procedure TLibClassObjetSender.SenderOnClick(sender: TObject);
begin
@LibClassObjetSender.OnExecProc:=Screen.ActiveForm.MethodAddress(TControl(sender).Name+('DblClick'));
LibClassObjetSender.OnExecProc(sender);
//LibClassObjetSender.ExecProc(sender);
//@self.OnExecProc:=Screen.ActiveForm.MethodAddress(TControl(sender).Name+('DblClick'));
//ExecProc(sender);
showmessage('Bonjour');
end;

Procedure TLibClassObjetSender.ExecProc(sender:TObject);
begin
//
end;

Procedure TLibClassObjetSender.SenderOnPanelResize(sender: TObject);
Begin
//@LibClassObjetSender.OnPanelResize:=Screen.ActiveForm.MethodAddress(TControl(sender).Name+('Resize'));
//Tiers.PaGrilleGrilleResize(sender);
//TPanel(sender).OnResize(sender);
//LibClassObjetSender.OnPanelResize(sender);
execPanel(sender);
End;

Procedure TLibClassObjetSender.ExecPanel(sender:TObject);
begin
//WinShape(Main.ListMenu,Main.Shape1,Main.shape2,Main.ContourCouleur);
end;

Procedure TLibClassObjetSender.InitPanelResize(sender: TObject);
Begin
@LibClassObjetSender.OnPanelResize:=Screen.ActiveForm.MethodAddress(TControl(sender).Name+('Resize'));
End;


procedure TLibClassObjetSender.SenderOnDateDebExit(Sender: TObject);
var
Valide:boolean;
Date:TdateTime;
ExceptLGR_:TExceptLGR;
begin
  try
     if screen.ActiveControl.Name <> 'BtnAnnuler' then // PB le 02/04/04
//     if ((Sender as TEdit).Parent as Tform).ActiveControl.Name <> 'BtnAnnuler' then
       begin
          if empty((Sender as TEdit).text) then
            (Sender as TEdit).text:=DAteInfos(e.DateDebutDeclarationTVA).DateStr;
          (Sender as TEdit).text:=AnneeDefaut(0,0,(Sender as TEdit).text).DateStr;
          //vérifier si cohérente et si ne fait pas déjà partie d'une déclaration
          if DMTmTVA.Verif_Si_Date_HorsDeclarationExistante(StrToDate_Lgr((Sender as TEdit).Text),e.DateFinDeclarationTVA,false).retour then
            e.DateDebutDeclarationTVA:=StrToDate_Lgr((Sender as TEdit).Text)
          else
             Begin
     //           if MessageBox((sender as Tedit).parent.handle,PChar('Cette date fait déjà partie d''une période déclarée !, voulez-vous continuer ?'),'Confirmation',MB_YESNO + MB_DEFBUTTON2) = IDNo then
              if MessageDlg('Cette date fait déjà partie d''une période déclarée !, voulez-vous continuer ?',mtWarning,[mbNo,mbYes],0)=mrNo then
               begin
                    (sender as Tedit).SetFocus;
                    abort;
                  end
                else
                  begin
                    e.DateDebutDeclarationTVA:=StrToDate_Lgr((Sender as TEdit).Text);
                  end;
            end;
       End;
  except
    abort;
    //raise ExceptLGR.Create('',101,false,mtError,ExceptLGR_);
  end;
end;

procedure TLibClassObjetSender.SenderOnDateFinExit(Sender: TObject);
var
Valide:boolean;
Date:TdateTime;
ExceptLGR_:TExceptLGR;
begin
  try
     if ((Sender as TEdit).Parent as Tform).ActiveControl.Name <> 'BtnAnnuler' then
       begin
          if empty((Sender as TEdit).text) then
            (Sender as TEdit).text:=DAteInfos(e.DateFinDeclarationTVA).DateStr;
          (Sender as TEdit).text:=AnneeDefaut(0,0,(Sender as TEdit).text).DateStr;
          //vérifier si cohérente et si ne fait pas déjà partie d'une déclaration
          if DMTmTVA.Verif_Si_Date_HorsDeclarationExistante(e.DateDebutDeclarationTVA,StrToDate_Lgr((Sender as TEdit).Text),false).retour then
            e.DateFinDeclarationTVA:=StrToDate_Lgr((Sender as TEdit).Text)
          else
             Begin
               //if Application.MessageBox(PChar('Cette date fait déjà partie d''une période déclarée !, voulez-vous continuer ?'),'Confirmation',MB_YESNO + MB_DEFBUTTON2) = IDNo then
               if MessageDlg('Cette date fait déjà partie d''une période déclarée !, voulez-vous continuer ?',mtWarning,[mbNo,mbYes],0)=mrNo then
                 begin
                   (sender as Tedit).SetFocus;
                   abort;
                 end
               else
                 begin
                   e.DateFinDeclarationTVA:=StrToDate_Lgr((Sender as TEdit).Text);
                 end;
             End;
       end;
   except
      abort;
      //raise ExceptLGR.Create('',101,false,mtError,ExceptLGR_);
  end;
end;

Procedure TLibClassObjetSender.GestInterfaceEvent(CCourant:Tfield;sender:TObject = nil);
Begin
 CCourant.FocusControl;
End;

end.
