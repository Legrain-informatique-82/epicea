unit E2_Infos_Tva_Complementaires;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ToolEdit, RXDBCtrl, Mask, DBCtrls, ComCtrls, ExtCtrls, CurrEdit,
  RXCtrls,LibZoneSaisie,Gr_Librairie_Obj,E2_Librairie_Obj,E2_Decl_Records,DMConstantes,
  Menus, LibGestionParamXML, jpeg;

type
  TInfos_Tva_Complementaire = class(TForm)
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    Panel4: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Shape3: TShape;
    Shape4: TShape;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    SoldeDebit1: TCurrencyEdit;
    SoldeCredit1: TCurrencyEdit;
    PaSoldeFin1: TPanel;
    Panel2: TPanel;
    Label2: TLabel;
    Label22: TLabel;
    Label21: TLabel;
    Shape5: TShape;
    Shape6: TShape;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    SoldeDebit2: TCurrencyEdit;
    SoldeCredit2: TCurrencyEdit;
    CheckBox21: TCheckBox;
    CheckBox22: TCheckBox;
    CheckBox23: TCheckBox;
    PaSoldeFin2: TPanel;
    Panel3: TPanel;
    Label3: TLabel;
    Label32: TLabel;
    Label31: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    SoldeDebit3: TCurrencyEdit;
    SoldeCredit3: TCurrencyEdit;
    CheckBox31: TCheckBox;
    CheckBox32: TCheckBox;
    CheckBox33: TCheckBox;
    PaSoldeFin3: TPanel;
    PopupMenu1: TPopupMenu;
    Enregistrer1: TMenuItem;
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure CheckBox11Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Enregistrer1Click(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    InfosSoldeCompte:Tlist;
    Panel:TPanel;
  end;

var
  Infos_Tva_Complementaire: TInfos_Tva_Complementaire;
  Function AffichInfoComplementairesTVA(var Parametre:Tlist;ForceAffich:boolean):Tlist;

implementation

uses E2_Main, DMDiocEtatBalance, DMTTVA;

{$R *.DFM}

procedure TInfos_Tva_Complementaire.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TInfos_Tva_Complementaire.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TInfos_Tva_Complementaire.FormDestroy(Sender: TObject);
begin
 if panel<>nil then panel:=nil;
 if Infos_Tva_Complementaire.InfosSoldeCompte<>nil then Infos_Tva_Complementaire.InfosSoldeCompte:=nil;
LibGestionParamXML.DestroyForm(self,E.User);
 Infos_Tva_Complementaire := Nil;
end;

procedure TInfos_Tva_Complementaire.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
end;

procedure TInfos_Tva_Complementaire.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 WinSuivPrec(Handle,key,[nil]);
 If (Key = VK_ESCAPE) then
   Begin
     BtnAnnuler.Click; 
   End;
end;

procedure TInfos_Tva_Complementaire.BtnEnregistrerClick(Sender: TObject);
begin
//
end;

procedure TInfos_Tva_Complementaire.CheckBox11Click(Sender: TObject);
var
i:integer;
begin
if not(sender as TCheckBox).Checked then
  begin
    (sender as TCheckBox).Checked:=true;
  end
else
  Begin
    for i:=0 to ActiveControl.Parent.ControlCount-1 do
      Begin
        if (ActiveControl.Parent.Controls[i] is TCheckBox) then
          begin//si objet=Tcheckbox
            if (ActiveControl.Parent.Controls[i] as TCheckBox).Tag<>(sender as TCheckBox).Tag then
               begin //si Tcheckbox n'est pas celui sur lequel on click
                  try
                   (ActiveControl.Parent.Controls[i] as TCheckBox).OnClick:=nil;
                   (ActiveControl.Parent.Controls[i] as TCheckBox).Checked:=not (sender as TCheckBox).Checked;
                 finally
                   (ActiveControl.Parent.Controls[i] as TCheckBox).OnClick:=CheckBox11Click;
                 end;//fin du try finally
               end;//fin si Tcheckbox n'est pas celui sur lequel on click
          end;//fin si objet=Tcheckbox
      End;
    for i:=0 to Infos_Tva_Complementaire.InfosSoldeCompte.count-1 do
    Begin
    if PSolde_A_Traiter(Infos_Tva_Complementaire.InfosSoldeCompte.Items[i])^.NomPanel=ActiveControl.Parent.Name then
       PSolde_A_Traiter(Infos_Tva_Complementaire.InfosSoldeCompte.Items[i])^.Code:=(sender as TCheckBox).Tag;
    End;
  End;
end;


Function AffichInfoComplementairesTVA(var Parametre:Tlist{PParam_InfosComplTva};ForceAffich:boolean):Tlist;{PSolde_A_Traiter}
var
i,j,NbPanelVisible:integer;
Totaux:TTotauxBalance;
Solde_A_Traiter:PSolde_A_Traiter;
InfosComplTva:PParam_InfosComplTva;
event:TNotifyEvent;
name,nameSolde:string;
ListeFiltre:Tstringlist;
ReportNonChange,ForceAffich_Local:Boolean;
Begin
try
try
if Infos_Tva_Complementaire=nil then Infos_Tva_Complementaire:=TInfos_Tva_Complementaire.Create(application.MainForm);
ListeFiltre:=TStringList.Create;
result:=TList.Create;
NbPanelVisible:=0;
  for i:=0 to Parametre.count-1 do
    Begin
     //Totaux:=DMDiocEtatBal.SommeTotauxBalanceParCompte(E.DatExoDebut,e.DatExoFin,PParam_InfosComplTva(Parametre.items[i])^.Compte_A_Traiter);
     ListeFiltre.Clear;
     ListeFiltre.add(PParam_InfosComplTva(Parametre.items[i])^.Compte_A_Traiter);
     //Totaux:=DMDiocEtatBal.SommeTotauxBalanceCalc(E.DateDebutDeclarationTVA,e.DateFinDeclarationTVA,ListeFiltre,'Compte');
     Totaux:=DMDiocEtatBal.SommeTotauxBalanceCalc(E.DatExoDebut,e.DateFinDeclarationTVA,ListeFiltre,'Compte');
     new(Solde_A_Traiter);
     Solde_A_Traiter.ATraiter:=Totaux.SoldeFin <>0;
     if ((not ForceAffich_Local)and(Totaux.SoldeFin <>0)) then ForceAffich_Local:=true;
     Solde_A_Traiter.Compte:=PParam_InfosComplTva(Parametre.items[i])^.Compte_A_Traiter;
     Solde_A_Traiter.Total:=Totaux;
//     if totaux.
     Solde_A_Traiter.Code:=PParam_InfosComplTva(Parametre.items[i])^.codedefaut;
     result.Add(Solde_A_Traiter);
     Infos_Tva_Complementaire.Caption:='Informations Complémentaires sur la TVA / Choix par défaut';
End;
  ReportNonChange:=DMTmTVA.Compare_Ta_H_Tva_Report(result,C_Id_Decl_Tmp).retour;
  ForceAffich:=ForceAffich_Local;
  if not ForceAffich then
    ForceAffich:=((not ReportNonChange)and(ForceAffich_Local));
if ReportNonChange then
 begin
  if DMTmTVA.Recup_Ta_H_Tva_Report(result,C_Id_Decl_Tmp).retour then
    Begin
      Infos_Tva_Complementaire.Caption:='Informations Complémentaires sur la TVA / Choix utilisateur';
    End;
 end;
Infos_Tva_Complementaire.Height:=447;
Infos_Tva_Complementaire.BorderStyle:=bsSizeable;
for i:=result.Count-1 downto 0 do
  Begin
    Infos_Tva_Complementaire.Panel:=(Infos_Tva_Complementaire.FindComponent('Panel'+inttostr(i+1)) as tpanel);
    if Infos_Tva_Complementaire.panel<>nil then
      begin//si panel <> nil
        Infos_Tva_Complementaire.panel.Align:=albottom;
         if not PSolde_A_Traiter(result.Items[i])^.ATraiter then
           begin//si A traiter
              Infos_Tva_Complementaire.Panel.Visible:=false;
              Infos_Tva_Complementaire.Height:=Infos_Tva_Complementaire.Height-Infos_Tva_Complementaire.Panel.Height;
           End//fin si A traiter
          else
            Infos_Tva_Complementaire.panel.Visible:=true;
        Infos_Tva_Complementaire.panel.Align:=alnone;
         if Infos_Tva_Complementaire.panel.Visible then
         begin//si panel visible
         inc(NbPanelVisible);
         PSolde_A_Traiter(result.Items[i])^.NomPanel:=Infos_Tva_Complementaire.panel.Name;
         for j:=0 to Infos_Tva_Complementaire.Panel.ControlCount-1 do
           Begin//boucle for j
             if (Infos_Tva_Complementaire.panel.Controls[j]is TCheckBox) then
               Begin//si tcheckbox
                  event:=(Infos_Tva_Complementaire.panel.Controls[j]as TCheckBox).OnClick;
                  (Infos_Tva_Complementaire.panel.Controls[j]as TCheckBox).OnClick:=nil;
                  (Infos_Tva_Complementaire.panel.Controls[j]as TCheckBox).Checked:=PSolde_A_Traiter(result.Items[i])^.Code=(Infos_Tva_Complementaire.panel.Controls[j]as TCheckBox).Tag;
                  (Infos_Tva_Complementaire.panel.Controls[j]as TCheckBox).OnClick:=event;
               End;//fin si tcheckbox
             if (Infos_Tva_Complementaire.panel.Controls[j]is TcurrencyEdit) then
               Begin//si TcurrencyEdit
                 name:='';
                 nameSolde:='';
                if PSolde_A_Traiter(result.Items[i])^.Total.SoldeDebitCreditFin then
                  begin
                    nameSolde:='SoldeDebit'+inttostr(i+1);
                    name:='SoldeCredit'+inttostr(i+1);
                  end
                else
                  begin
                    nameSolde:='SoldeCredit'+inttostr(i+1);
                    name:='SoldeDebit'+inttostr(i+1);
                  end;
                  if (Infos_Tva_Complementaire.panel.Controls[j]as TcurrencyEdit).Name=nameSolde then
                  (Infos_Tva_Complementaire.panel.Controls[j]as TcurrencyEdit).Value:=abs(PSolde_A_Traiter(result.Items[i])^.Total.SoldeFin);
                  if (Infos_Tva_Complementaire.panel.Controls[j]as TcurrencyEdit).Name=name then
                  (Infos_Tva_Complementaire.panel.Controls[j]as TcurrencyEdit).Value:=0;
               End;//fin si TcurrencyEdit
             if (Infos_Tva_Complementaire.panel.Controls[j]is TLabel) then
               Begin//si TLabel
                  if (Infos_Tva_Complementaire.panel.Controls[j]as TLabel).Name='Label'+inttostr(i+1)then
                  (Infos_Tva_Complementaire.panel.Controls[j]as TLabel).caption:='Vous avez un solde  sur le compte '+PSolde_A_Traiter(result.Items[i])^.Compte+'.'+#10#13+'Que voulez-vous en faire ?';
               End;//fin si TLabel
             if (Infos_Tva_Complementaire.panel.Controls[j]is TPanel) then
               Begin//si TPanel
                  if (Infos_Tva_Complementaire.panel.Controls[j]as TPanel).Name='PaSoldeFin'+inttostr(i+1)then
                  (Infos_Tva_Complementaire.panel.Controls[j]as TPanel).caption:='Solde Fin du compte :'+PSolde_A_Traiter(result.Items[i])^.Compte;
               End;//fin si TPanel
           End;//fin boucle for j
         end;//fin si panel visible
      end;//fin si panel <> nil
  End;
Infos_Tva_Complementaire.BorderStyle:=bsSingle;
j:=NbPanelVisible;
for i:=result.Count-1  downto 0 do
  Begin
    Infos_Tva_Complementaire.Panel:=(Infos_Tva_Complementaire.FindComponent('Panel'+inttostr(i+1)) as tpanel);
    if Infos_Tva_Complementaire.Panel.Visible then
    case NbPanelVisible of
    1:Begin
       Infos_Tva_Complementaire.Panel.Align:=alclient;
      End;
    2:Begin

        if j=2 then Infos_Tva_Complementaire.Panel.Align:=alBottom
          else Infos_Tva_Complementaire.Panel.Align:=alClient;
        dec(j);
      End;
    3:Begin
        if j=3 then Infos_Tva_Complementaire.Panel.Align:=alBottom;
        if j=2 then Infos_Tva_Complementaire.Panel.Align:=alBottom;
        if j=1 then Infos_Tva_Complementaire.Panel.Align:=alclient;
        dec(j);
      End;
    end;//fin du case NbPanelVisible
  End;
if ForceAffich then
  begin
    Infos_Tva_Complementaire.InfosSoldeCompte:=result;
    if not (Infos_Tva_Complementaire.Showmodal=mrok) then
      begin
       abort;
      end
    else
      Begin
        DMTmTVA.Vide_Ta_H_Tva_Report(C_Id_Decl_Tmp);
        DMTmTVA.Affect_Ta_H_Tva_Report(result,C_Id_Decl_Tmp);
      End;
  end;
//else
//  abort;
except
 result:=nil;
end;
finally
Application.MainForm.SetFocus;
 Infos_Tva_Complementaire.Destroy;
end;//fin du try finally
End;

procedure TInfos_Tva_Complementaire.FormCreate(Sender: TObject);
begin
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        InitialiseFormPosDefaut(self);
	//Left:= 30; Top:= 70; Width:= screen.Width-60; Height:= screen.Height-top-30;
    end;

FormateMonnaie([SoldeDebit1,SoldeCredit1,SoldeDebit2,SoldeCredit2,SoldeDebit3,SoldeCredit3],E.FormatMonnaie);
end;

procedure TInfos_Tva_Complementaire.Enregistrer1Click(Sender: TObject);
begin
self.ModalResult:=mrok;
end;

procedure TInfos_Tva_Complementaire.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer],PaBtn,90,0);
end;

end.
