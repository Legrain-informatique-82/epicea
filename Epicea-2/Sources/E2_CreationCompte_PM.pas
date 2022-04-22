unit E2_CreationCompte_PM;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,Dialogs,
//  E2_Librairie_obj,
//  Gr_Librairie_obj,
  StdCtrls,
  Forms,
  DBCtrls,
  DB,
  DBTables,
  Mask,
  ExtCtrls,
//  DBEdit_PM,
  Menus,
//  DMPlanCpt,
  RXCtrls,
//  LibZoneSaisie,
//  E2_AideTva,
//  LibSQL,
//  E2_Decl_Records,
//  DMConstantes,
//  LibGestionParamXML,
  jpeg;

type
  TCreationCompte_PM = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    PopupMenu1: TPopupMenu;
    Button3: TButton;
    Enregistrer1: TMenuItem;
    Fermer1: TMenuItem;
    Annuler1: TMenuItem;
    Label1: TRxLabel;
    EditCompte: TDBEdit;
    Label2: TRxLabel;
    EditLibelle: TDBEdit;
    Label10: TRxLabel;
    EditTvaCode: TDBEdit;
    Label12: TRxLabel;
    EditTvaType: TDBEdit;
    Label13: TRxLabel;
    CheckBoxSensCredit: TDBCheckBox;
    Label14: TRxLabel;
    CheckBoxCollectif: TDBCheckBox;
    Label5: TRxLabel;
    EditUn: TDBEdit;
    Label6: TRxLabel;
    EditUn2: TDBEdit;
    Label17: TRxLabel;
    CheckBoxRapprochement: TDBCheckBox;
    Label18: TRxLabel;
    CheckBoxImmobilisation: TDBCheckBox;
    Label9: TRxLabel;
    CheckBoxPlanSaisie: TDBCheckBox;
    DBTypeTva: TDBCheckBox;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    procedure FormCreate(Sender: TObject);
    procedure CheckBoxSensCreditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBoxPlanSaisieExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditCompteExit(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);
    procedure AideEnLigne(Sender: TObject);
    procedure EditCompteEnter(Sender: TObject);
    procedure Button2Enter(Sender: TObject);
    procedure Button2Exit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TaPlanCptAfterScroll(DataSet: TDataSet);
    procedure ActiveChanged;override;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Panel1Click(Sender: TObject);
  private
    { déclarations privées }
  public
    { déclarations publiques }
    CompteACreer:String;
  end;

var
  CreationCompte_PM: TCreationCompte_PM;
  AideCompteVisible:boolean;
  RetCre:TErreurSaisie;
//  LastZoneEdit:TWincontrol;
  Function CreationCompteAffiche(Compte:String;Control:TComponent):boolean;

implementation

//uses E2_Main, E2_AideCompte;

{$R *.DFM}

Function CreationCompteAffiche(Compte:String;Control:TComponent):boolean;
begin
if (CreationCompte_PM = nil) then
      CreationCompte_PM:=TCreationCompte_PM.Create(screen.ActiveForm);
with CreationCompte_PM do
     Begin
     CompteACreer:=Compte;
//      EditCompte.DataSource.DataSet.AfterScroll(DMPlan.TaPlanCptCreat);
      DMPlan.TaPlanCptCreat.AfterScroll:=TaPlanCptAfterScroll;
////      DMPlan.TaPlanCptCreat.AfterScroll(DMPlan.TaPlanCptCreat);

//      TaPlanCptAfterScroll(DMPlan.TaPlanCptCreat);
      result:=(showmodal=mrOk);
      if result then
        BEGIN
//        if DMPlan.TaPlanCptCreat.Active then
//         begin
//         DMPlan.TaPlanCptCreat.Post;
//         DMPlan.TaPlanCptCreat.FlushBuffers;
//         end;
        if DMPlan.Tacompte.Active then
        begin
         DMPlan.Tacompte.DisableControls;
         DMPlan.Tacompte.refresh;
         DMPlan.Tacompte.EnableControls;
        end;
        if DMPlan.TaPlanCpt.Active then
        begin
         DMPlan.TaPlanCpt.DisableControls;
         DMPlan.TaPlanCpt.refresh;
         DMPlan.TaPlanCpt.EnableControls;
        end;
        if DMPlan.TaPlanBO.Active then
        begin
         DMPlan.TaPlanBO.DisableControls;
         DMPlan.TaPlanBO.refresh;
         DMPlan.TaPlanBO.EnableControls;
        end;
        if DMPlan.TaCptImmos.Active then
        begin
         DMPlan.TaCptImmos.DisableControls;
         DMPlan.TaCptImmos.refresh;
         DMPlan.TaCptImmos.EnableControls;
        end;
        END;
     End;

end;

procedure TCreationCompte_PM.ActiveChanged;
Begin
//inherited;
//WinShape(ActiveControl,Shape1,shape2,Main.ContourCouleur);
//LastZoneEdit:=ActiveControl;
End;

procedure TCreationCompte_PM.AideEnLigne(Sender: TObject);
begin
//WinShape(ActiveControl,Shape1,shape2,Main.ContourCouleur);
//     BtnEnregistrer.Enabled := ActiveBouton([EdCode,EdNom,ComboType,ComboCompte]);
//Label2.Caption:=ActiveControl.Name;
//LastZoneEdit:=ActiveControl;
end;

procedure TCreationCompte_PM.FormCreate(Sender: TObject);
begin
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
        InitialiseFormPosDefaut(self);
    end;
if AideCompte=nil then
 AideCompte:=TAideCompte.Create(self);
//  TaPlanCreer.AfterScroll:=
//  Table1.Open;
end;

procedure TCreationCompte_PM.CheckBoxSensCreditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
//case key of
//   VK_UP:PostMessage(handle,WM_NEXTDLGCTL,0,0);
//   VK_DOWN:PostMessage(handle,WM_NEXTDLGCTL,0,-1);
//end;

end;

procedure TCreationCompte_PM.FormActivate(Sender: TObject);
begin
main.Initialiser_ShortCut_Main(true);
Patitre.visible:=Main.AfficheTitre;
//DMPlan.TaCompte.OnFilterRecord:=nil;
DMPlan.TaPlanCptCreat.Insert;
if length(CompteACreer)<>0 then
 begin
  EditCompte.ReadOnly:=false;
  DMPlan.TaPlanCptCreat.FindField('Compte').ReadOnly:=false;
  DMPlan.TaPlanCptCreat.FindField('Compte').Value:=CompteACreer;
  EditCompte.ReadOnly:=true;
 end;
//screen.OnActiveControlChange:=AideEnligne;
//EditCompte.ReadOnly:=length(CompteACreer)<>0;
//EditCompte.ReadOnly:=length(DMPlan.TaPlanCptCreat.FindField('Compte').AsString)<>0;
EditCompte.SetFocus;
self.tag:=1;
//EditCompte.DataSource.DataSet.AfterScroll:=CreationCompte_PM.TaPlanCptAfterScroll;
end;

procedure TCreationCompte_PM.Button1Click(Sender: TObject);
begin
EditCompteExit(ActiveControl);
if RetCre.Retour then
 begin
   self.tag:=1;
   modalResult:=mrOk;
end;
//self.close;
end;

procedure TCreationCompte_PM.Button2Click(Sender: TObject);
begin
self.tag:=2;
modalResult:=mrCancel;
//self.close;
end;

procedure TCreationCompte_PM.CheckBoxPlanSaisieExit(Sender: TObject);
begin
EditCompte.setfocus;
end;

procedure TCreationCompte_PM.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Shift=[] then WinSuivPrec(Handle,key,[nil]);
case key of
   VK_ESCAPE:if DMPlan.TaPlanCptCreat.State = dsInsert then
                begin
                if messagedlg(PChar('Voulez-vous annuler la création de ce compte ?'),mtconfirmation, [mbno,mbyes],0) = mryes then
               Button2Click(Button2);
               end
                else
               Button1Click(Button1);
//   : ;
end;

end;

procedure TCreationCompte_PM.EditCompteExit(Sender: TObject);
var
i:integer;
begin
if activeControl <> Button2 then
//if DaPlanCpt.State in [dsInsert] then
if DMPlan.DaPlanCptCreat.State in [dsInsert] then
begin
if (sender is TDBEdit) then
 begin
 retCre:=DMPlan.CreationCpt((sender as TDBEdit).Field);
 if (sender as TDBEdit) = EditCompte then 
 for i:=0 to Panel2.ControlCount -1 do begin
  if (Panel2.Controls[i] is TDBEdit) then
      if DMPlan.ListeChampOblig.IndexOf((Panel2.Controls[i] as TDBEdit).DataField) <> -1 then
         begin
        (Panel2.Controls[i] as TDBEdit).TabStop:=true;
        (Panel2.Controls[i] as TDBEdit).Enabled:=true;
        (Panel2.Controls[i] as TDBEdit).readonly:=false;
        end
         else
         begin
         (Panel2.Controls[i] as TDBEdit).TabStop:=false;
        (Panel2.Controls[i] as TDBEdit).Enabled:=False;
        (Panel2.Controls[i] as TDBEdit).readonly:=true;
        end;
  if (Panel2.Controls[i] is TDBCheckBox) then
      if DMPlan.ListeChampOblig.IndexOf((Panel2.Controls[i] as TDBCheckBox).DataField) <> -1 then
      begin
        (Panel2.Controls[i] as TDBCheckBox).TabStop:=true;
        (Panel2.Controls[i] as TDBCheckBox).Enabled:=true;
        (Panel2.Controls[i] as TDBCheckBox).ReadOnly:=false;
      end
       else
      begin
      (Panel2.Controls[i] as TDBCheckBox).TabStop:=false;
      (Panel2.Controls[i] as TDBCheckBox).Enabled:=false;
      (Panel2.Controls[i] as TDBCheckBox).ReadOnly:=true;
      end;
 end;
 end;
 if (sender is TDBCheckBox) then
 retCre:=DMPlan.CreationCpt((sender as TDBCheckBox).Field);
 if not retCre.Retour then
 case retCre.CodeErreur of
//    2000     :exit;//abort;
    1000,1001:begin
               EditCompte.SetFocus;
//               abort;
               exit;
              end;
    1002     :begin
               DMPlan.DaPlanCptCreat.DataSet.Cancel;
               self.ModalResult:=mrCancel;
//               DaPlanCpt.DataSet.Cancel;
               self.tag:=2;
//               self.close;
              end;
      4001,4002:begin
                 if not AideTvaAffiche(EditTvaCode,EditCompte.Field.AsString)
                    then EditTvaCode.SetFocus;
//                if not empty(EditCompte.Field.AsString) then
//                 begin
//                 if not AideTvaAffiche(EditTvaCode,EditCompte.Field.AsString)
//                    then abort;
//                 end
//                 else
//                 begin
//                  EditCompte.SetFocus;
//                  abort;
//                 end;
                end;
 end;
end;
if LastZoneEdit = EditCompte then
   WinRxLab(Label1,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = EditLibelle then
   WinRxLab(Label2,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = EditTvaCode then
   WinRxLab(Label10,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = EditTvaType then
   WinRxLab(Label12,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = CheckBoxSensCredit then
   WinRxLab(Label13,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = CheckBoxCollectif then
   WinRxLab(Label14,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = EditUn then
   WinRxLab(Label5,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = EditUn2 then
   WinRxLab(Label6,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = CheckBoxRapprochement then
   WinRxLab(Label17,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = CheckBoxImmobilisation then
   WinRxLab(Label18,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = CheckBoxPlanSaisie then
   WinRxLab(Label9,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
end;

procedure TCreationCompte_PM.Button3Click(Sender: TObject);
begin
self.close;
end;

Procedure TCreationCompte_PM.InitialiseTable_A_Nil;
Begin
     //DMPlan.TaPlanCptCreat.AfterScroll:=nil;
InitDatasetEvent_A_Nil_Sur_Form([DMPlan.TaPlanCptCreat]);
End;

procedure TCreationCompte_PM.FormDestroy(Sender: TObject);
begin
     InitialiseTable_A_Nil;
     LibGestionParamXML.DestroyForm(Self,E.USer);
     CreationCompte_PM:=nil;

end;

procedure TCreationCompte_PM.EditCompteEnter(Sender: TObject);
begin
if activeControl = EditCompte then
   WinRxLab(Label1,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = EditLibelle then
   WinRxLab(Label2,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = EditTvaCode then
   WinRxLab(Label10,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = EditTvaType then
   WinRxLab(Label12,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = CheckBoxSensCredit then
   WinRxLab(Label13,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = CheckBoxCollectif then
   WinRxLab(Label14,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = EditUn then
   WinRxLab(Label5,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = EditUn2 then
   WinRxLab(Label6,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = CheckBoxRapprochement then
   WinRxLab(Label17,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = CheckBoxImmobilisation then
   WinRxLab(Label18,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = CheckBoxPlanSaisie then
   WinRxLab(Label9,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
end;

procedure TCreationCompte_PM.Button2Enter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TCreationCompte_PM.Button2Exit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TCreationCompte_PM.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
CanClose:=true;

if CanClose then
 else
 begin
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(self);

 end;
end;

procedure TCreationCompte_PM.TaPlanCptAfterScroll(DataSet: TDataSet);
var
i:integer;
CptTmp:string;
begin
CptTmp:=DataSet.Fields[0].AsString;
//DMPlan.CompteAJournal:=false;
case Dataset.State
 of
   dsBrowse:begin
             DMPlan.ChampObligatoire(CptTmp,DMPlan.ListeChampOblig);
             for i:=0 to DataSet.FieldCount - 1 do
                 begin
                  DataSet.Fields[i].ReadOnly:=(DMPlan.ListeChampOblig.IndexOf(DataSet.Fields[i].FieldName) = - 1);
                 end;
            DataSet.FindField('Compte').ReadOnly:=true;
            end;
   dsEdit:begin
            DMPlan.ChampObligatoire(CptTmp,DMPlan.ListeChampOblig);
             for i:=0 to DataSet.FieldCount - 1 do
                 begin
                  DataSet.Fields[i].ReadOnly:=(DMPlan.ListeChampOblig.IndexOf(DataSet.Fields[i].FieldName) = - 1);
                 end;
            DataSet.FindField('Compte').ReadOnly:=true;
          end;
   dsInsert:begin
//               if not empty(CptTmp) then
//               begin
                DMPlan.ChampObligatoire(CptTmp,DMPlan.ListeChampOblig);
                for i:=0 to DataSet.FieldCount - 1 do
                    begin
                     DataSet.Fields[i].ReadOnly:=(DMPlan.ListeChampOblig.IndexOf(DataSet.Fields[i].FieldName) = - 1);
                    end;
                 DataSet.FindField('Compte').ReadOnly:=false;
                 InitChampAfterInsert([nil,nil,nil,nil,nil,nil,nil,nil,False,nil,nil,False,false,false,false,false,false,false,false,false,false,false,E.User,now,0,'',false,0,nil],Dataset);
                 // EditCompte.ReadOnly:=true;
//               end
//               else
//                begin
//                InitChampAfterInsert([nil,nil,nil,nil,nil,nil,nil,nil,False,nil,nil,False,false,false,false,false,false,false,false,false,false,false,E.User,now],Dataset);
//               end;
            end;
 end;
end;
procedure TCreationCompte_PM.FormShow(Sender: TObject);
begin
AideCompteVisible:=AideCompte.visible;
if AideCompte <> nil then
   if AideCompteVisible then AideCompte.Hide;
end;

procedure TCreationCompte_PM.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
if AideCompte <> nil then
   if AideCompteVisible then AideCompte.visible:=true;;
end;

procedure TCreationCompte_PM.Panel1Click(Sender: TObject);
begin
main.AffichInfoComposant1Click(main.AffichInfoComposant1);
end;

end.
