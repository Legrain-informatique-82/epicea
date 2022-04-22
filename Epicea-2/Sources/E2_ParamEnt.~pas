{*******************************************************************************
 * Unit Name: E2_ParamEnt
 * Purpose  :
 * Author   :  PB
 * History  :
 * Autre Modif : GR_Librairie : Function ActiveBouton
*******************************************************************************}

unit E2_ParamEnt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Db, DBTables, Buttons, ExtCtrls,
  Gr_Librairie_obj,DMAide, RXSwitch,LibZoneSaisie,E2_Recherche,LibRessourceString,
  ToolEdit, RXDBCtrl,LibDates, RXCtrls, CustomStaticText_PM,DMParamEnt,
  FM_INIT_COLOR,
  lib_chaine,
  DMCorrection,
  CurrEdit,Libsql,DMREcherche;

type
  TParamEntAffichage=record
    ParamEntAcces:TParamEntAcces;
    Tag:Integer;
  end;
  TParamEnt = class(TT_INIT_COLOR)
    Label1: TLabel;
    edNom_Doss: TDBEdit;
    edCle: TDBEdit;
    edEXO_SAISIE: TDBEdit;
    edAdr1: TDBEdit;
    edAdr2: TDBEdit;
    edCp: TDBEdit;
    edVille: TDBEdit;
    Panel_PM1: TPanel;
    Bevel6: TBevel;
    RxSwitchAgri1: TRxSwitch;
    Panel_PM2: TPanel;
    Bevel7: TBevel;
    RxSwitch2: TRxSwitch;
    Panel_PM3: TPanel;
    Bevel8: TBevel;
    RxSwitch3: TRxSwitch;
    Panel_PM4: TPanel;
    Bevel9: TBevel;
    RxSwitch4: TRxSwitch;
    btFermer: TButton;
    btOk: TButton;
    edDATE_DEB_EXO: TDBDateEdit;
    edDATE_FIN_EXO: TDBDateEdit;
    RxSwitchInd1: TRxSwitch;
    RxLabNomSoc: TRxLabel;
    RxLabAdresse: TRxLabel;
    RxLabCP: TRxLabel;
    RxLabVille: TRxLabel;
    RxLabel5: TRxLabel;
    RxLabDebExo: TRxLabel;
    RxLabDebFin: TRxLabel;
    RxLabCodeExo: TRxLabel;
    LabActivite: TRxLabel;
    LabPlanAux: TRxLabel;
    LabTVACollectee: TRxLabel;
    LabTypeEnt: TRxLabel;
    Panel_PM5: TPanel;
    Bevel1: TBevel;
    RxLabPerTVA: TRxLabel;
    RxSwitchTVAM: TRxSwitch;
    RxSwitchTVAT: TRxSwitch;
    RxSwitchTVAA: TRxSwitch;
    RxLabel10: TRxLabel;
    RxLabel11: TRxLabel;
    RxLabel12: TRxLabel;
    RxLabel13: TRxLabel;
    RxLabel14: TRxLabel;
    RxLabel15: TRxLabel;
    RxLabel16: TRxLabel;
    RxLabel17: TRxLabel;
    RxLabel18: TRxLabel;
    RxLabel19: TRxLabel;
    RxLabel20: TRxLabel;
    RxLabel21: TRxLabel;
    CurrencyEdit1: TCurrencyEdit;
    RxSBInfoVersion: TRxSpeedButton;
    Button1: TButton;
    Button2: TButton;
    DBCB_Derogatoire: TDBCheckBox;
    RxLabDerog: TRxLabel;
    RxLabDateTVA: TRxLabel;
    edDATE_PREM_DECL_TVA: TDBDateEdit;
    RxLabRegAuto: TRxLabel;
    ChbxReglAuto: TCheckBox;
    BtnJuridique: TButton;
    RxLabel1: TRxLabel;
    DBEdit1: TDBEdit;
    RxLabel2: TRxLabel;
    DBEdit2: TDBEdit;
    RxSwitchAsso1: TRxSwitch;
    RxLabel3: TRxLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure edExit(Sender: TObject);
    Procedure InitTagEdit(ZoneSaisie:array of TDBEdit);
    procedure edDATEChange(Sender: TObject);
    procedure edKeyPress(Sender: TObject; var Key: Char);
    procedure btFermerClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edEXO_SAISIEEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Panel_PM1Click(Sender: TObject);
    procedure Panel_PM2Click(Sender: TObject);
    procedure Panel_PM3Click(Sender: TObject);
    procedure Panel_PM4Click(Sender: TObject);
    procedure AideEnLigne(Sender: TObject);
    procedure btOkEnter(Sender: TObject);
    procedure btOkExit(Sender: TObject);
    procedure RxSwitchAgri1On(Sender: TObject);
    procedure RxSwitchInd1On(Sender: TObject);
    procedure RxSwitchAgri1Off(Sender: TObject);
    procedure RxSwitchInd1Off(Sender: TObject);
    procedure edNom_DossExit(Sender: TObject);
    procedure edNom_DossEnter(Sender: TObject);
    procedure RxSwitchTVAMMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CurrencyEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure RxSBInfoVersionClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    Procedure EnvoieValeurADataSet;
    Procedure OnParamEntStateChange(Sender: TObject);
    procedure DBCB_DerogatoireClick(Sender: TObject);
    procedure ChbxReglAutoClick(Sender: TObject);
    procedure edNom_DossKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edNom_DossKeyPress(Sender: TObject; var Key: Char);
    Procedure GestionRxLabelEnter;
    Procedure GestionAccesEcran;
    procedure BtnJuridiqueClick(Sender: TObject);
    procedure RxSwitchAsso1Off(Sender: TObject);
    procedure RxSwitchAsso1On(Sender: TObject);
    procedure initRxSwitchToutesActivites(bouton : TRxSwitch ; Etat:boolean);
  private
    { Déclarations privées }
    NewBase:TDataBase;
  public
    { Déclarations publiques }
    DirNewDos:string;
  end;

var
  ParamEnt: TParamEnt;
  Function InfoClasseControl(Control: TObject;ClasseCherche:String):Boolean;
  Function ParamEntrepriseAffiche(ParamEntAffichage:TParamEntAffichage):Boolean;
//  LastZoneEdit:TWincontrol;
implementation

{$R *.DFM}
Uses E2_Librairie_obj,E2_Main, E2_FinCreat, E2_CreatDos, DMBaseDonnee,
  DiversProjets, E2_Decl_Records, ImportDll, juridique;

Function ParamEntrepriseAffiche(ParamEntAffichage:TParamEntAffichage):Boolean;
Begin
 if ParamEnt = nil then ParamEnt:=TParamEnt.Create(Application.MainForm);
 if DMParamEntreprise = nil then DMParamEntreprise:=TDMParamEntreprise.Create(Application.MainForm);

 ParamEntAffichage.ParamEntAcces:=DMParamEntreprise.ModifParamEntAcces(ParamEntAffichage.ParamEntAcces,E.TypeDossier);

 ParamEnt.edDATE_DEB_EXO.ReadOnly := ParamEntAffichage.ParamEntAcces.DATE_DEB_EXOReadOnly;
 ParamEnt.edNom_Doss.ReadOnly := ParamEntAffichage.ParamEntAcces.NOM_DOSSReadOnly;
 ParamEnt.edDATE_PREM_DECL_TVA.ReadOnly := ParamEntAffichage.ParamEntAcces.DATE_PREM_DECL_TVAReadOnly;
 ParamEnt.edEXO_SAISIE.ReadOnly := ParamEntAffichage.ParamEntAcces.EXO_SAISIEReadOnly;
 ParamEnt.Panel_PM1.Enabled := ParamEntAffichage.ParamEntAcces.PLAN_AUXReadOnly;
 ParamEnt.edCle.ReadOnly := ParamEntAffichage.ParamEntAcces.CLEReadOnly;
 ParamEnt.Tag := ParamEntAffichage.Tag;
 ParamEnt.ShowModal;
 ParamEnt.Release;
//
End;


procedure TParamEnt.AideEnLigne(Sender: TObject);
var
   result:boolean;
   ControlTmp:TCustomControl;
begin

//     if ((AideAssist <> nil) and (AideAssist.Visible)) Then
//        Result := AideAssist.taAssist.FindKey([self.name,ActiveControl.name]);
//     If Not Result Then AideAssist.taAssist.FindKey(['Vide','Vide']);
//WinShape(ActiveControl,Shape1,shape2,Main.ContourCouleur);
//     BtnEnregistrer.Enabled := ActiveBouton([EdCode,EdNom,ComboType,ComboCompte]);
//Label2.Caption:=ActiveControl.Name;
//LastZoneEdit:=ActiveControl;
end;
//****************************************************************************//
procedure TParamEnt.FormCreate(Sender: TObject);
Var
MaxiDep:Integer;
begin
inherited;
TypeInitForm:=C_MODELE_COLOREPI;
//InitialiseForm(Self);
MaxiDep:=((78945*152)+4457*758)*100+92;
//Label2.Caption:=inttostr(MaxiDep);
end;

//****************************************************************************//
Procedure TParamEnt.InitTagEdit(ZoneSaisie:array of TDBEdit);
var
i:integer;
begin
for i:=0 to high(ZoneSaisie) do
   if ZoneSaisie[i].GetTextLen>0 then ZoneSaisie[i].tag:=1;
btOk.Enabled:=ActiveBouton([edNom_Doss,edCle,edDATE_DEB_EXO,edDATE_FIN_EXO]);
end;

//****************************************************************************//
procedure TParamEnt.FormDestroy(Sender: TObject);
begin
//DestroyForm(Self);
ParamEnt:=nil;
end;

//****************************************************************************//
procedure TParamEnt.btOkClick(Sender: TObject);
var
DateValide1,DateValide2: boolean;
Deb,Fin:TdateTime;
Variable:String;
i,Ch,Index:integer;
begin
//// Utilisé pour code protection de la cle de déprotection
//Randomize;
//ch:=Random(10);
//Index:=length(CurrencyEdit1.Text);
//for i:=0 to 240 do
// begin
//  if (i mod Decalage)=0 then
//    begin
//     if Index > 0 then
//      begin
//       Variable:=Variable+CurrencyEdit1.Text[Index];
//       dec(Index);
//      end
//      else
//       Variable:=Variable+chr(ch+48);
//    end
//    else
//      Variable:=Variable+chr(ch+48);
//  ch:=Random(10);
// end;
//
case DMParamEntreprise.dbParam_Dos.State of
   dsInsert:Begin
             EnvoieValeurADataSet;
             TableGerePost(DMParamEntreprise.taParamDoss);
            End;
   dsEdit:Begin
             EnvoieValeurADataSet;
             TableGerePost(DMParamEntreprise.taParamDoss);
          End;
end;
//DMParamEntreprise.taParamDoss.DisableControls;
//DMParamEntreprise.taParamDoss.Close;
//DMParamEntreprise.taParamDoss.ReadOnly:=false;
//DMParamEntreprise.taParamDoss.Open;
//if DMParamEntreprise.taParamDoss.RecordCount = 1 then
// begin
//   DMParamEntreprise.taParamDoss.Edit;
//   DMParamEntreprise.taParamDoss.FindField('Div').AsVariant:=Variable;
//   EnvoieValeurADataSet;
//   TableGerePost(DMParamEntreprise.taParamDoss);
// end;
//DMParamEntreprise.taParamDoss.EnableControls;
////////////****************************fin**********************************//


////case DMParamEntreprise.taParamDoss.State of
////   1:Begin
////
////     End;
////
////   2:Begin
////
////     End;
////
////end;
//
//Deb:=StrToDate(edDATE_DEB_EXO.Text);
//Fin:=StrToDate(edDATE_FIN_EXO.Text);
//DateValide1:=StrToDate(edDATE_DEB_EXO.Text) < StrToDate(edDATE_FIN_EXO.Text);
//DateValide2:=((StrToDate(edDATE_FIN_EXO.Text) - StrToDate(edDATE_DEB_EXO.Text)) <= 366) and DateValide1;
//if not DateValide1 then
//   begin
//     Application.MessageBox(Pchar('LA date de début d''exercice doit être antérieure à celle de la fin de l''exercice.'),'Erreur de saisie',0);
////     Erreur('Param Ent','edDate');
//     if year(Deb)<>year(date) then edDATE_DEB_EXO.SelectAll else edDATE_FIN_EXO.SelectAll ;
//     abort;
//   end
//   else
//   begin
//    if not DateValide2 then
//      begin
//        if Question('Param Ent','Intervalle') then
//       	  if DMParamEntreprise.taParamDoss.RecordCount=1 then
//               	DMParamEntreprise.taParamDoss.First else DMParamEntreprise.taParamDoss.Post;
//      end
//      else
//      if DMParamEntreprise.taParamDoss.RecordCount=1 then DMParamEntreprise.taParamDoss.First else DMParamEntreprise.taParamDoss.Post;
//   end;
//If self.tag=1 then begin
//      main.gestDos.Close;
//      main.gestDos.Filtered:=false;
////      main.gestDos.IndexName:='IdDosExo';
//      main.gestDos.Open;
//      main.gestDos.refresh;
//      main.gestDos.Last;
//      if main.gestDos.FindField('ID_Dossier').AsString+main.gestDos.FindField('ID_Table').AsString = Main.IdDosExo then begin
////   if main.gestDos.FindKey([Main.IdDosExo]) then begin
//      main.gestDos.Edit;
//      main.gestDos.SetFields([nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,deb,fin]);
//      main.gestDos.Post;
//      main.gestDos.FlushBuffers;
//      end;
//   if (FinCreat = nil) Then FinCreat:= TFinCreat.Create(self);
//   FinCreat.Show;
//   end;
end;

//****************************************************************************//
procedure TParamEnt.edExit(Sender: TObject);
begin
if activeControl.Name <>'btFermer' then begin
with sender as TDBEdit do
if GetTextLen=0 then begin
					Tag:=0;
               if Question('Param Ent','Obligatoire') then
		FocusControl(FindNextControl(sender as TWinControl,true,true,true)) else
   	focusControl(sender as TWincontrol);
               end
                else Tag:=1;
//btOk.Enabled:=ActiveBouton([edNom_Doss,edCle,edDATE_DEB_EXO,edDATE_FIN_EXO]);
btOk.Enabled:=ActiveBouton([edNom_Doss,edDATE_DEB_EXO,edDATE_FIN_EXO]);
		end;
end;

//****************************************************************************//
procedure TParamEnt.edDATEChange(Sender: TObject);
var
annee, mois, jour:word;
s:string;
i:boolean;
begin

//
with sender as TDBEdit do begin

end;
//s:=text;
////try
//if strToDate2(s) <> 0 then
//edExit(sender)
//else
//begin
////except
////on EConvertError do
//   if length(s)=0 then begin
//   if Question('Param Ent','Obligatoire') then
//	FocusControl(FindNextControl(sender as TWinControl,true,true,true)) else
//   focusControl(sender as TWincontrol);
//   end;
//
//   MessageDlg('La date saisie n''est pas correcte !!!',mtWarning,[MBOK],0);
//   focusControl(sender as TWincontrol);
//   end;
//end;
//end;
end;

//****************************************************************************//
procedure TParamEnt.edKeyPress(Sender: TObject; var Key: Char);
begin
//if key = #13 then FindNextControl(sender as TWinControl,true,true,false).SetFocus;
//if key = #9 then FocusControl(FindNextControl(sender as TWinControl,true,true,true));
end;

//****************************************************************************//
procedure TParamEnt.btFermerClick(Sender: TObject);
begin
case DMParamEntreprise.dbParam_Dos.State of
   dsInsert:Begin
              if Messagedlg(PChar('Voulez-vous enregistrer la description de votre entreprise?'),mtconfirmation, [mbno,mbyes],0) = mrYes then
              begin
                EnvoieValeurADataSet;
                TableGerePost(DMParamEntreprise.taParamDoss);
                ModalResult:=mrOK;
//                close;
              end
              else
              begin
                DMParamEntreprise.taParamDoss.Cancel;
                ModalResult:=mrOK;
//                close;
              end;
            End;
   dsEdit:Begin
              if Messagedlg(PChar('Voulez-vous enregistrer les modifications de la description de votre entreprise?'),mtconfirmation, [mbno,mbyes],0) = mrYes then
              begin
                EnvoieValeurADataSet;
                TableGerePost(DMParamEntreprise.taParamDoss);
                ModalResult:=mrOK;
//                close;
              end
              else
              begin
                DMParamEntreprise.taParamDoss.Cancel;
                ModalResult:=mrOK;
//                close;
              end;
          End;
   else
   ModalResult:=mrOK;
//   close;
end;
end;

//****************************************************************************//
procedure TParamEnt.FormActivate(Sender: TObject);
var
DateAux:TDateTime;
typeRegimeDossier:string;
begin
inherited;
try//finally
RxSwitchAsso1.OnOn:=nil;
RxSwitchAgri1.OnOn:=nil;
RxSwitchInd1.OnOn:=nil;

RxSwitchAsso1.OnOff:=nil;
RxSwitchAgri1.OnOff:=nil;
RxSwitchInd1.OnOff:=nil;

GestMessageLGR.Enregistrement := true;
self.Caption := 'Paramètres Entreprise ' + E.User;
Initialiser_ShortCut_Main(true);
if not self.Visible then self.Visible:=true; 
DAteAux:=CalculDate(now,-1,cdjour,31);
//Main.ContourCouleur
//ShadowColor
//screen.OnActiveControlChange:=AideEnligne;
if DMParamEntreprise = nil then DMParamEntreprise:=TDMParamEntreprise.Create(application);
DMParamEntreprise.taParamDoss.close;
if Self.tag=1 then begin
   NewBase:=TDataBase.Create(self);
   NewBase.DatabaseName:=DirNewDos;
   NewBase.Params.Add('PATH='+DirNewDos);
   NewBase.Params.Add('ENABLE BCD=FALSE');
   NewBase.Params.Add('DEFAULT DRIVER=PARADOX');
   NewBase.Open;
   DMParamEntreprise.taParamDoss.DatabaseName:=NewBase.DatabaseName;
   DMParamEntreprise.TaParamDoss.ReadOnly:=false;
//   DMParamEntreprise.TaParamDoss.Open;
   end;
if Self.tag=0 then DMParamEntreprise.taParamDoss.DatabaseName:=DMBD.dbNameDossier.DatabaseName;
if not DMParamEntreprise.taParamDoss.Active then DMParamEntreprise.taParamDoss.Open;
if DMParamEntreprise.taParamDoss.RecordCount=1 then
  begin
//   DMParamEntreprise.taParamDossCLE.ReadOnly;

     edNom_Doss.Enabled :=not DMParamEntreprise.taParamDossNOM_DOSS.ReadOnly;
     edAdr1.Enabled :=not DMParamEntreprise.taParamDossAdr1.ReadOnly;
     edAdr2.Enabled :=not DMParamEntreprise.taParamDossAdr2.ReadOnly;
     edCp.Enabled :=not DMParamEntreprise.taParamDossCP.ReadOnly;
     edVille.Enabled :=not DMParamEntreprise.taParamDossVILLE.ReadOnly;

     Panel_PM1.Enabled := not DMParamEntreprise.taParamDossREGIME_Agr.ReadOnly;
//   DMParamEntreprise.taParamDossTYPE_SOC.ReadOnly;
//   DMParamEntreprise.taParamDossTYPE_FISC.ReadOnly;
     Panel_PM5.Enabled := not DMParamEntreprise.taParamDossPERIODE_TVA.ReadOnly;
//   DMParamEntreprise.taParamDossTVA_DEBIT.ReadOnly;
     Panel_PM2.Enabled := not DMParamEntreprise.taParamDossPLAN_AUX.ReadOnly;
//   DMParamEntreprise.taParamDossPERIODE.ReadOnly;
//   DMParamEntreprise.taParamDossTYPE_IMPOT.ReadOnly;
//   DMParamEntreprise.taParamDossTYPE_DEC_FISC.ReadOnly;
     edDATE_DEB_EXO.Enabled := not DMParamEntreprise.taParamDossDATE_DEB_EXO.ReadOnly;
     edDATE_FIN_EXO.Enabled := not DMParamEntreprise.taParamDossDATE_FIN_EXO.ReadOnly;
     edEXO_SAISIE.Enabled := not DMParamEntreprise.taParamDossEXO_SAISIE.ReadOnly;
//   DMParamEntreprise.taParamDossEXO_BASE.ReadOnly;
//   DMParamEntreprise.taParamDossDEVISE_EXO.ReadOnly;
//   DMParamEntreprise.taParamDossDIV.ReadOnly;
     edDATE_PREM_DECL_TVA.Enabled := not DMParamEntreprise.taParamDossDATE_PREM_DECL_TVA.ReadOnly;
     DBCB_Derogatoire.Enabled := not DMParamEntreprise.taParamDossDEROGATOIRE.ReadOnly;
     { isa avec Phil à l'arrache le  15/03/04 }
     if (VerifSiReportDerogatoire(e.DatExoDebut,e.DatExoFin).retour) then DBCB_Derogatoire.Enabled:=false;
     { isa  le  15/03/04 }
//   DMParamEntreprise.taParamDossDATE_PASSAGE_REEL.ReadOnly;
//   DMParamEntreprise.taParamDossAU_REEL.ReadOnly;
//   DMParamEntreprise.taParamDossPARAM_DIV.ReadOnly;
//   DMParamEntreprise.taParamDossUTILISATEUR.ReadOnly;
//   Panel_PM1.Enabled:=not DMParamEntreprise.taParamDoss.ReadOnly;
//   Panel_PM1.Enabled:=not DMParamEntreprise.taParamDoss.ReadOnly;
   DMParamEntreprise.taParamDoss.First;
//   edCle.ReadOnly:=true;
   edCle.color:=clSilver;
   edCle.TabStop:=false;
   // Type de Régime
   typeRegimeDossier:=DossierTypeRegime;
   if (typeRegimeDossier='A')or(e.TypeDossierdemo=VerDemoAgri ) then
      begin
       DeFiltrageDataSet(DMRech.TaBalanceRech);
       Panel_PM1.Enabled:=(DMRech.TaBalanceRech.RecordCount = 0);
       RxSwitchInd1.StateOn:=True;
       RxSwitchAsso1.StateOn:=true;
       if(e.TypeClient=Cl_Association)then
       begin
          RxSwitchAsso1.StateOn:=false;
          RxSwitchAsso1.Enabled:=true;
       end
       else
         begin
            RxSwitchAgri1.StateOn:=False;
            RxSwitchAsso1.Enabled:=false;
         end;
      end;
   if (typeRegimeDossier='I')or  (e.TypeDossierdemo=VerDemoGeneral) then
      begin
       DeFiltrageDataSet(DMRech.TaBalanceRech);
       Panel_PM1.Enabled:=(DMRech.TaBalanceRech.RecordCount = 0);
       RxSwitchAgri1.StateOn:=True;
       RxSwitchAgri1.enabled:=false;
       if(e.TypeClient=Cl_Association)then
       begin
         RxSwitchAsso1.StateOn:=false;
         RxSwitchAsso1.Enabled:=true;
         RxSwitchInd1.Enabled:=false;
       end
       else
       begin
         RxSwitchInd1.StateOn:=False;
         RxSwitchAsso1.Enabled:=false;
       end;
      end;
   RxSwitch2.StateOn:=not PlanAuxT;
   edDATE_DEB_EXO.ReadOnly:=not Panel_PM1.Enabled;
   edDATE_FIN_EXO.ReadOnly:=not Panel_PM1.Enabled;
   edEXO_SAISIE.ReadOnly:=not Panel_PM1.Enabled;
   DeFiltrageDataSet(DMRech.TaTiersRech);
   Panel_PM2.Enabled:=(DMRech.TaTiersRech.RecordCount = 0);

//                              if DMParamEntreprise.taParamDossPLAN_AUX.Value='O' then
//                                 begin
//                                  RxSwitch2.StateOn:=False;
//                                 end
//                                 else
//                                 begin
//                                  RxSwitch2.StateOn:=True;
//                                 end;
                              if DMParamEntreprise.taParamDossTVA_DEBIT.Value='E' then
                                 begin
                                  RxSwitch3.StateOn:=False;
                                 end
                                 else
                                 begin
                                  RxSwitch3.StateOn:=True;
                                 end;
                              if DMParamEntreprise.taParamDossTYPE_SOC.Value='IND' then
                                 begin
                                  RxSwitch4.StateOn:=False;
                                 end
                                 else
                                 begin
                                  RxSwitch4.StateOn:=True;
                                 end;//taParamDossPERIODE_TVA
                              if DMParamEntreprise.taParamDossPERIODE_TVA.Value='M' then
                                 begin // TVA Mensuelle
                                   RxSwitchTVAM.StateOn:=false;
                                   RxSwitchTVAT.StateOn:=true;
                                   RxSwitchTVAA.StateOn:=true;
                                 end
                                 else if DMParamEntreprise.taParamDossPERIODE_TVA.Value='T' then
                                 begin // TVA Trimestrielle
                                   RxSwitchTVAM.StateOn:=true;
                                   RxSwitchTVAT.StateOn:=false;
                                   RxSwitchTVAA.StateOn:=true;
                                 end
                                 else // TVA Annuelle
                                 begin
                                   RxSwitchTVAM.StateOn:=true;
                                   RxSwitchTVAT.StateOn:=true;
                                   RxSwitchTVAA.StateOn:=false;
                                 end;
  end
  else
  begin
    Panel_PM1.Enabled:=true;
    DMParamEntreprise.taParamDoss.Edit;
    RxSwitchAsso1.Enabled:=false;
//  edCle.ReadOnly:=false;
//  edCle.color:=clWindow;
//  edCle.TabStop:=true;
  end;
//InitTagEdit([edNom_Doss,edCle,edDATE_DEB_EXO,edDATE_FIN_EXO]);
//edDATE_DEB_EXO.Field.EditMask:='09\/09\/0999;1;_';
//edDATE_FIN_EXO.Field.EditMask:='09\/09\/0999;1;_';
if ((self.tag=1) or (DMParamEntreprise.taParamDoss.RecordCount = 0)) then
 begin
   DMParamEntreprise.taParamDoss.Edit;
   DMParamEntreprise.taParamDossNOM_DOSS.AsString:=Label1.Caption;
   DMParamEntreprise.taParamDoss.FindField('CREATION').AsString:=typeUtilisateurtoStr(e.TypeUtilisateur);
   DMParamEntreprise.taParamDoss.FindField('FORCE').AsBoolean:=false;
//   DMParamEntreprise.taParamDossDATE_DEB_EXO.Value:=calculdate(now,-1,CdMois,1);
//   DMParamEntreprise.taParamDossDATE_FIN_EXO.Value:=Calculdate(now,11,cdmois,31);
{ isa  le  26/05/04 }
   DMParamEntreprise.taParamDoss.FindField('DATE_DEB_EXO').Value:=encodeDate(Dateinfos(now).an,1,1);{ isa  le  26/05/04 }
   DMParamEntreprise.taParamDoss.FindField('DATE_FIN_EXO').Value:=Calculdate(DMParamEntreprise.taParamDoss.FindField('DATE_DEB_EXO').Value,11,cdmois,31);

//   edEXO_SAISIE.Text:=copy(edDATE_FIN_EXO.Text,length(edDATE_FIN_EXO.Text)-1,2);
   edEXO_SAISIE.Field.AsString:=copy(edDATE_FIN_EXO.Text,length(edDATE_FIN_EXO.Text)-1,2);  { isa  le  26/05/04 }
 end;
if edNom_Doss.Enabled then edNom_Doss.SetFocus
 else btOk.SetFocus;
    if DBCB_Derogatoire.Field.AsBoolean then
       DBCB_Derogatoire.Caption := DBCB_Derogatoire.ValueChecked
    else DBCB_Derogatoire.Caption := DBCB_Derogatoire.ValueUnchecked;
ChbxReglAuto.Checked:=E.Possibilite_Affectation;
finally
GestionAccesEcran;
RxSwitchAsso1.OnOn:=RxSwitchAsso1On;
RxSwitchAgri1.OnOn:=RxSwitchAgri1On;
RxSwitchInd1.OnOn:=RxSwitchInd1On;

RxSwitchAsso1.OnOff:=RxSwitchAsso1Off;
RxSwitchAgri1.OnOff:=RxSwitchAgri1Off;
RxSwitchInd1.OnOff:=RxSwitchInd1Off;
end;
end;

//****************************************************************************//
procedure TParamEnt.FormClose(Sender: TObject; var Action: TCloseAction);
begin
case DMParamEntreprise.dbParam_Dos.State of
   dsInsert:Begin
               if Messagedlg(PChar('Voulez-vous enregistrer la description de votre entreprise ?'),mtconfirmation, [mbno,mbyes],0) = mrYes then
               begin
                 EnvoieValeurADataSet;
                 TableGerePost(DMParamEntreprise.taParamDoss);
               end
               else
               begin
                 DMParamEntreprise.taParamDoss.Cancel;
               end;
            End;
   dsEdit:Begin
              if Messagedlg(PChar('Voulez-vous enregistrer les modifications de la description de votre entreprise ?'),mtconfirmation, [mbno,mbyes],0) = mrYes then
              begin
                EnvoieValeurADataSet;
                TableGerePost(DMParamEntreprise.taParamDoss);
              end
              else
              begin
                DMParamEntreprise.taParamDoss.Cancel;
              End;
          End;
end;
DMParamEntreprise.taParamDoss.close;
if NewBase <> nil then
 Begin
   NewBase.Close;
   NewBase.Free;
 End;

DMParamEntreprise.taParamDoss.DatabaseName:=DMBD.dbNameDossier.DatabaseName;
GestMessageLGR.Enregistrement := false;
end;

//****************************************************************************//
procedure TParamEnt.edEXO_SAISIEEnter(Sender: TObject);
begin
if self.Tag=1 then
edEXO_SAISIE.Text:=copy(edDATE_FIN_EXO.Text,length(edDATE_FIN_EXO.Text)-1,2);
end;

//****************************************************************************//
procedure TParamEnt.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
i:integer;
Rang:string;
begin
//if ((Shift=[]) and (Key <> VK_RETURN)) then WinSuivPrec(Handle,key,[nil]);
if (Shift=[]) then WinSuivPrec(Handle,key,[nil]);

if key in [VK_SPACE] then
   begin
   if ActiveControl.ClassNameIs('TPanel') then
      begin
      if DMParamEntreprise.taParamDoss.State = dsBrowse then DMParamEntreprise.taParamDoss.Edit;

      rang:=copy(activecontrol.name,length(activecontrol.name),1);
      case strtoint_lgr(rang) of
         0..4:Begin
               (self.FindComponent('RxSwitch'+rang) as TRxSwitch).StateOn:=not (self.FindComponent('RxSwitch'+rang) as TRxSwitch).StateOn;
               if(activecontrol.name = RxSwitchAgri1.Name)then RxSwitchAgri1.StateOn:= not RxSwitchAgri1.StateOn;
               if(activecontrol.name = RxSwitchInd1.Name)then RxSwitchInd1.StateOn:= not RxSwitchInd1.StateOn;
               if(activecontrol.name = RxSwitchAsso1.Name)then RxSwitchAsso1.StateOn:= not RxSwitchAsso1.StateOn;
              End;
         5:Begin
            if not RxSwitchTVAM.StateOn then
            begin
               RxSwitchTVAM.StateOn:=true;
               RxSwitchTVAT.StateOn:=false;
               RxSwitchTVAA.StateOn:=true;
            end
            else
            if not RxSwitchTVAT.StateOn then
            begin
               RxSwitchTVAT.StateOn:=true;
               RxSwitchTVAM.StateOn:=true;
               RxSwitchTVAA.StateOn:=false;
            end
            else
            if not RxSwitchTVAA.StateOn then
            begin
              RxSwitchTVAA.StateOn:=true;
               RxSwitchTVAT.StateOn:=true;
               RxSwitchTVAM.StateOn:=false;
            end
            else
            if RxSwitchTVAM.StateOn then
            begin
              RxSwitchTVAA.StateOn:=false;
               RxSwitchTVAT.StateOn:=false;
               RxSwitchTVAM.StateOn:=true;
            end
            else
            if RxSwitchTVAT.StateOn then
            begin
              RxSwitchTVAA.StateOn:=false;
               RxSwitchTVAT.StateOn:=false;
               RxSwitchTVAM.StateOn:=true;
            end
            else
            if RxSwitchTVAA.StateOn then
            begin
              RxSwitchTVAA.StateOn:=false;
               RxSwitchTVAT.StateOn:=false;
               RxSwitchTVAM.StateOn:=true;
            end;

           End;

      end;

       end;
   end;
if key= VK_ESCAPE then
 Begin
 case DMParamEntreprise.taParamDoss.State of
    dsEdit:Begin
               key :=0;
               if Messagedlg(PChar('Voulez-vous annuler les modifications de la description de votre entreprise?'),mtconfirmation, [mbno,mbyes],0) = mrYes then
               begin
                 DMParamEntreprise.taParamDoss.Cancel;
               end;
           End;
    dsInsert:Begin
               key :=0;
               if Messagedlg(PChar('Voulez-vous abandonner la description de votre entreprise?'),mtconfirmation, [mbno,mbyes],0) = mrYes then
               begin
                 DMParamEntreprise.taParamDoss.Cancel;
               end;
             End;
    dsbrowse:Begin
               ModalResult:=mrOk;
               key:=0;
             End;
 end;

 End;

end;

//****************************************************************************//
procedure TParamEnt.Panel_PM1Click(Sender: TObject);
begin
if Panel_PM1.Enabled then Panel_PM1.SetFocus;
end;

//****************************************************************************//
procedure TParamEnt.Panel_PM2Click(Sender: TObject);
begin
if Panel_PM2.Enabled then Panel_PM2.SetFocus;
end;

//****************************************************************************//
procedure TParamEnt.Panel_PM3Click(Sender: TObject);
begin
if Panel_PM3.Enabled then Panel_PM3.SetFocus;
MessageDlg('Pour gérer vos ventes en tva sur débit, allez dans :'+#13+#10+''+#13+#10+'Plan Comptable '+#13+#10+''+#13+#10+'puis cliquez sur :'+#13+#10+''+#13+#10+'Tva Débit.', mtInformation, [mbOK], 0);
end;

//****************************************************************************//
procedure TParamEnt.Panel_PM4Click(Sender: TObject);
begin
if Panel_PM4.Enabled then Panel_PM4.SetFocus;
end;

procedure TParamEnt.btOkEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TParamEnt.btOkExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;


procedure TParamEnt.initRxSwitchToutesActivites(bouton : TRxSwitch ; Etat:boolean);
begin
try//finally
RxSwitchAsso1.OnOn:=nil;
RxSwitchAgri1.OnOn:=nil;
RxSwitchInd1.OnOn:=nil;

RxSwitchAsso1.OnOff:=nil;
RxSwitchAgri1.OnOff:=nil;
RxSwitchInd1.OnOff:=nil;
    if(bouton.Name=RxSwitchAgri1.Name)then
    begin
       if (RxSwitchAgri1.Enabled=false )then  abort
       else
       if (RxSwitchAsso1.Enabled or RxSwitchInd1.Enabled)then
         begin
         if(etat=false)then
           begin
             if(RxSwitchAsso1.Enabled)then RxSwitchAsso1.StateOn:=true;
             if(RxSwitchInd1.Enabled)then RxSwitchInd1.StateOn:=true;
           end
         else
           begin
             if(RxSwitchInd1.Enabled)then RxSwitchInd1.StateOn:=false else RxSwitchAsso1.StateOn:=false;
             if(RxSwitchAsso1.Enabled)then RxSwitchAsso1.StateOn:=not(RxSwitchInd1.StateOn);
           end;
         end else begin
                    RxSwitchAgri1.StateOn :=not RxSwitchAgri1.StateOn;
                  end;
    end;
    if(bouton.Name=RxSwitchAsso1.Name)then
    begin
       if (RxSwitchAsso1.Enabled=false )then  abort
       else
       if(RxSwitchAgri1.Enabled or RxSwitchInd1.Enabled) then
         begin
         if(etat=false)then
           begin
             if(RxSwitchAgri1.Enabled)then RxSwitchAgri1.StateOn:=true;
             if(RxSwitchInd1.Enabled)then RxSwitchInd1.StateOn:=true;
           end
         else
           begin
             if(RxSwitchAgri1.Enabled)then RxSwitchAgri1.StateOn:=false else RxSwitchInd1.StateOn:=false;
             if(RxSwitchInd1.Enabled)then RxSwitchInd1.StateOn:=not(RxSwitchAgri1.StateOn);
           end;
         end else begin
                    RxSwitchAsso1.StateOn :=not RxSwitchAsso1.StateOn;
                  end;
    end;
    if(bouton.Name=RxSwitchInd1.Name)then
    begin
       if (RxSwitchInd1.Enabled=false )then  abort
       else
       if (RxSwitchAsso1.Enabled or RxSwitchAgri1.Enabled)then
         begin
         if(etat=false)then
           begin
             if(RxSwitchAsso1.Enabled)then RxSwitchAsso1.StateOn:=true;
             if(RxSwitchAgri1.Enabled)then RxSwitchAgri1.StateOn:=true;
           end
         else
           begin
             if(RxSwitchAsso1.Enabled)then RxSwitchAsso1.StateOn:=false else RxSwitchAgri1.StateOn:=false;
             if(RxSwitchAgri1.Enabled)then RxSwitchAgri1.StateOn:=not(RxSwitchAsso1.StateOn);
           end;
         end else begin
                    RxSwitchInd1.StateOn :=not RxSwitchInd1.StateOn;
                  end;
    end;
    DMParamEntreprise.taParamDoss.Edit;
finally
RxSwitchAsso1.OnOn:=RxSwitchAsso1On;
RxSwitchAgri1.OnOn:=RxSwitchAgri1On;
RxSwitchInd1.OnOn:=RxSwitchInd1On;

RxSwitchAsso1.OnOff:=RxSwitchAsso1Off;
RxSwitchAgri1.OnOff:=RxSwitchAgri1Off;
RxSwitchInd1.OnOff:=RxSwitchInd1Off;
end;
end;


procedure TParamEnt.RxSwitchAgri1On(Sender: TObject);
begin
initRxSwitchToutesActivites(RxSwitchAgri1,true);
end;

procedure TParamEnt.RxSwitchInd1On(Sender: TObject);
begin
initRxSwitchToutesActivites(RxSwitchInd1,true);

end;

procedure TParamEnt.RxSwitchAgri1Off(Sender: TObject);
begin
initRxSwitchToutesActivites(RxSwitchAgri1,false);

end;

procedure TParamEnt.RxSwitchInd1Off(Sender: TObject);
begin
initRxSwitchToutesActivites(RxSwitchInd1,false);

end;

procedure TParamEnt.edNom_DossExit(Sender: TObject);
var
ExceptLGR:TExceptLGR;
begin
//if Main.lastZoneEdit = edNom_Doss then
//   WinRxLab(RxLabel1,Main.textColorOff,Main.ShadowColorOff);
//if Main.LastZoneEdit = edAdr1 then
//   WinRxLab(RxLabel2,Main.textColorOff,Main.ShadowColorOff);
//if Main.LastZoneEdit = edAdr2 then
//   WinRxLab(RxLabel2,Main.textColorOff,Main.ShadowColorOff);
//if Main.LastZoneEdit = edCp then
//   WinRxLab(RxLabel3,Main.textColorOff,Main.ShadowColorOff);
//if Main.LastZoneEdit = edVille then
//   WinRxLab(RxLabel4,Main.textColorOff,Main.ShadowColorOff);
//if Main.LastZoneEdit = edCle then
//   WinRxLab(RxLabel5,Main.textColorOff,Main.ShadowColorOff);
//if Main.LastZoneEdit = edDATE_DEB_EXO then
//   WinRxLab(RxLabel6,Main.textColorOff,Main.ShadowColorOff);
//if Main.LastZoneEdit = edDATE_FIN_EXO then
//   WinRxLab(RxLabel7,Main.textColorOff,Main.ShadowColorOff);
//if Main.LastZoneEdit = edEXO_SAISIE then
//   WinRxLab(RxLabel8,Main.textColorOff,Main.ShadowColorOff);
//if Main.LastZoneEdit = Panel_PM1 then
//   WinRxLab(Label7,Main.textColorOff,Main.ShadowColorOff);
//if Main.LastZoneEdit = Panel_PM2 then
//   WinRxLab(Label8,Main.textColorOff,Main.ShadowColorOff);
//if Main.LastZoneEdit = Panel_PM3 then
//   WinRxLab(Label9,Main.textColorOff,Main.ShadowColorOff);
//if Main.LastZoneEdit = Panel_PM4 then
//   WinRxLab(Label10,Main.textColorOff,Main.ShadowColorOff);
//if Main.LastZoneEdit = Panel_PM5 then
//   WinRxLab(RxLabel9,Main.textColorOff,Main.ShadowColorOff);

if ((InfoClasseControl(Sender,'TDBEdit'))or(InfoClasseControl(Sender,'TDBDateEdit'))) then
 begin
  try
     if InfoClasseControl(Sender,'TDBDateEdit') then
       ExceptLGR:=DMParamEntreprise.CtrlSaisieDossier(TDBDateEdit(Sender).Field)
     else
       ExceptLGR:=DMParamEntreprise.CtrlSaisieDossier(TDBEdit(Sender).Field);
  except
   case ExceptLGR.NumErreur of
      1..7000:begin
//                TDBEdit(Sender).Field.FocusControl;
             (Sender as Twincontrol).SetFocus;
              abort;
              end;
      8000..16002:Begin
             (Sender as Twincontrol).SetFocus;
             abort;
                  end;
      17000:Begin
             (Sender as Twincontrol).SetFocus;
             abort;
            end;
      18000..20000:Begin
                  end;
      21000:Begin
             (Sender as Twincontrol).SetFocus;
             abort;
            End;
      22000..26000:Begin

                  End;
   end;

  end;

 end;
if ((ActiveControl = edDATE_DEB_EXO)or(ActiveControl = edDATE_FIN_EXO)) then
 begin
   if DateInfos(edDATE_DEB_EXO.Field.AsDateTime).Valide then
      Begin
      if DateInfos(edDATE_FIN_EXO.Field.AsDateTime).Valide then
       begin
       case CompareDate(edDATE_DEB_EXO.Field.AsDateTime,edDATE_FIN_EXO.Field.AsDateTime) of
          -1:if not DateInfos(edDATE_FIN_EXO.Field.AsDateTime).Vide then
                showmessage('Attention, la date de début d''exercice doit être antérieure à la date de fin d''exercice');
          0:if not DateInfos(edDATE_FIN_EXO.Field.AsDateTime).Vide then
                showmessage('Attention, la date de début d''exercice doit être antérieure à la date de fin d''exercice');
          1: ;
       end;


       end;
      End;
 end;

if not edDATE_PREM_DECL_TVA.ReadOnly then
 if DateInfos(edDATE_PREM_DECL_TVA.Date).Valide then
  if DateInfos(edDATE_PREM_DECL_TVA.Date).Vide then
   begin
    if not (edDATE_PREM_DECL_TVA.DataSource.State in [dsEdit,dsInsert]) then
       edDATE_PREM_DECL_TVA.DataSource.DataSet.Edit;
    edDATE_PREM_DECL_TVA.Date:=edDATE_DEB_EXO.Field.AsDateTime;
   end;
CouleurDeActivecontrolLabel(lastZoneEdit,ParamUtil.CouleurDBGrid.GrilleColorFond,nil,0,0);
end;

Function InfoClasseControl(Control: TObject;ClasseCherche:String):Boolean;
var
  ClassRef: TClass;
  StringList:TStringList;
begin
  StringList:=TStringList.Create;
  ClassRef := Control.ClassType;
  while ClassRef <> nil do
  begin
    StringList.Add(ClassRef.ClassName);
    ClassRef := ClassRef.ClassParent;
  end;
result:=(StringList.IndexOf(ClasseCherche)<>-1);
StringList.Free;
end;

procedure TParamEnt.edNom_DossEnter(Sender: TObject);
begin
GestionRxLabelEnter;
end;

procedure TParamEnt.RxSwitchTVAMMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
if Panel_PM5.Enabled then
 begin
  Panel_PM5.SetFocus;
  if (sender is TRxSwitch) then
  begin
    if (sender as TComponent).Name='RxSwitchTVAM' then
       Begin
         (sender as TRxSwitch).StateOn:=false;
          RxSwitchTVAT.StateOn:=true;
          RxSwitchTVAA.StateOn:=true;
         abort;
       End;
    if (sender as TComponent).Name='RxSwitchTVAT' then
       Begin
         (sender as TRxSwitch).StateOn:=false;
          RxSwitchTVAM.StateOn:=true;
          RxSwitchTVAA.StateOn:=true;
         abort;
       End;
    if (sender as TComponent).Name='RxSwitchTVAA' then
       Begin
         (sender as TRxSwitch).StateOn:=false;
          RxSwitchTVAT.StateOn:=true;
          RxSwitchTVAM.StateOn:=true;
         abort;
       End;
  end;
end;

end;

procedure TParamEnt.CurrencyEdit1KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in [#8,#48..#57]) then key:=#0;
end;

procedure TParamEnt.RxSBInfoVersionClick(Sender: TObject);
begin
Showmessage(ParamEntRxSBInfoVersionWarning+numVersion.messageVersion);
end;

procedure TParamEnt.Button1Click(Sender: TObject);
var
Variable,Aux:String;
i,Ch,Index:integer;
begin
DMParamEntreprise.taParamDoss.Close;
//DMParamEntreprise.taParamDoss.ReadOnly:=false;
DMParamEntreprise.taParamDoss.Open;
//DMParamEntreprise.taParamDoss.Edit;
Variable:=DMParamEntreprise.taParamDoss.FindField('Div').AsVariant;
//DMParamEntreprise.taParamDoss.Post;
Randomize;
ch:=Random(10);
Index:=0;
//length(CurrencyEdit1.Text);
Aux:='';
for i:=0 to 240 do
 begin
  if (i mod Decalage)=0 then
    begin
     if Index < 9 then
      begin
       Aux:=Variable[I+1]+Aux;
//       CurrencyEdit1.Text:=Variable[I+1]+CurrencyEdit1.Text;
//       Variable:=Variable+CurrencyEdit1.Text[Index];
       inc(Index);
      end;
//      else
//       Variable:=Variable+chr(ch+48);
    end;
//    else
//      Variable:=Variable+chr(ch+48);
  ch:=Random(10);
 end;
CurrencyEdit1.Text:=Aux;
end;

procedure TParamEnt.Button2Click(Sender: TObject);
begin
showmessage(inttostr(CalC(DMParamEntreprise.taParamDoss)));
end;

Procedure TParamEnt.EnvoieValeurADataSet;
Begin
// Domaine d'activité
if RxSwitchAgri1.StateOn = False then
   AffectValeurAChamp(DMParamEntreprise.taParamDossREGIME_Agr,'A')
 else
   AffectValeurAChamp(DMParamEntreprise.taParamDossREGIME_Agr,'I');

// Periodicité TVA Mensuelle
if RxSwitchTVAM.StateOn = False then
   AffectValeurAChamp(DMParamEntreprise.taParamDossPERIODE_TVA,'M');

// Periodicité TVA Trimestrielle
if RxSwitchTVAT.StateOn = False then
   AffectValeurAChamp(DMParamEntreprise.taParamDossPERIODE_TVA,'T');

// Periodicité TVA Annuelle
if RxSwitchTVAA.StateOn = False then
   AffectValeurAChamp(DMParamEntreprise.taParamDossPERIODE_TVA,'A');


// Plan Auxiliaire
if RxSwitch2.StateOn = False then
   AffectValeurAChamp(DMParamEntreprise.taParamDossPLAN_AUX,'T')
   Else
   AffectValeurAChamp(DMParamEntreprise.taParamDossPLAN_AUX,'');

// Type TVA
if RxSwitch3.StateOn = False then
   AffectValeurAChamp(DMParamEntreprise.taParamDossTVA_DEBIT,'E')
   else
   AffectValeurAChamp(DMParamEntreprise.taParamDossTVA_DEBIT,'D');

// TypeEntreprise
if RxSwitch4.StateOn = False then
   AffectValeurAChamp(DMParamEntreprise.taParamDossTYPE_SOC,'IND')
   else
   AffectValeurAChamp(DMParamEntreprise.taParamDossTYPE_SOC,'SOC');

//
if not empty(DMParamEntreprise.taParamDossEXO_SAISIE.AsString) then
 if not DMParamEntreprise.taParamDossEXO_SAISIE.ReadOnly then
    DMParamEntreprise.taParamDossEXO_BASE.AsString:=DMParamEntreprise.taParamDossEXO_SAISIE.AsString;
End;

Procedure TParamEnt.OnParamEntStateChange(Sender: TObject);
Begin
    if DBCB_Derogatoire.Field.AsBoolean then
       DBCB_Derogatoire.Caption := DBCB_Derogatoire.ValueChecked
    else DBCB_Derogatoire.Caption := DBCB_Derogatoire.ValueUnchecked;
End;

procedure TParamEnt.DBCB_DerogatoireClick(Sender: TObject);
begin
//if DBCB_Derogatoire.Field <> nil then
//  begin
//    if ((VerifSiReportDerogatoire(e.DatExoDebut,e.DatExoFin).retour)and(DBCB_Derogatoire.Checked=false)) then
//    begin
//      MessageDlg('Une ou plusieurs de vos immobilisations ont un report de dérogatoire.'+#13+#10+'Vous devez solder ce report de dérogatoire avant '+#13+#10+'de demander à ne plus gérer.', mtWarning, [mbOK], 0);
//      if DBCB_Derogatoire. then
//        DBCB_Derogatoire.Checked:=true;
//    end;
//    if DBCB_Derogatoire.Checked then
//      DBCB_Derogatoire.Caption := DBCB_Derogatoire.ValueChecked;
//  end
//    else DBCB_Derogatoire.Caption := DBCB_Derogatoire.ValueUnchecked;
if DBCB_Derogatoire.Field <> nil then
  begin
      if DBCB_Derogatoire.Checked then
        DBCB_Derogatoire.Caption := DBCB_Derogatoire.ValueChecked
      else DBCB_Derogatoire.Caption := DBCB_Derogatoire.ValueUnchecked;
  end;
end;

procedure TParamEnt.ChbxReglAutoClick(Sender: TObject);
begin
E.Possibilite_Affectation := ChbxReglAuto.Checked;
end;

procedure TParamEnt.edNom_DossKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key= VK_ESCAPE then
 Begin
  key := 0;
 end;
end;

procedure TParamEnt.edNom_DossKeyPress(Sender: TObject; var Key: Char);
begin
if key= #27 then
 Begin
  key := #0;
 end;
end;

Procedure TParamEnt.GestionRxLabelEnter;
Begin
CouleurActivecontrolLabel(ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond,nil,0,0);
// initialise tous les labels à la couleur d'origine
WinRxLabTab([RxLabNomSoc,RxLabAdresse,RxLabCP,RxLabVille,
             RxLabDebExo,RxLabDebFin,RxLabCodeExo,
             RxLabDerog,RxLabDateTVA,RxLabRegAuto,
             LabActivite,LabPlanAux,RxLabPerTVA,
             LabTVACollectee,LabTypeEnt],ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if activeControl = edNom_Doss then
   WinRxLab(RxLabNomSoc,ParamUtil.TextColorOn,ParamUtil.ShadowColorOn);
if activeControl = edAdr1 then
   WinRxLab(RxLabAdresse,ParamUtil.TextColorOn,ParamUtil.ShadowColorOn);
if activeControl = edAdr2 then
   WinRxLab(RxLabAdresse,ParamUtil.TextColorOn,ParamUtil.ShadowColorOn);
if activeControl = edCp then
   WinRxLab(RxLabCP,ParamUtil.TextColorOn,ParamUtil.ShadowColorOn);
if activeControl = edVille then
   WinRxLab(RxLabVille,ParamUtil.TextColorOn,ParamUtil.ShadowColorOn);
if activeControl = edCle then
   WinRxLab(RxLabel5,ParamUtil.TextColorOn,ParamUtil.ShadowColorOn);
if activeControl = edDATE_DEB_EXO then
   WinRxLab(RxLabDebExo,ParamUtil.TextColorOn,ParamUtil.ShadowColorOn);
if activeControl = edDATE_FIN_EXO then
   WinRxLab(RxLabDebFin,ParamUtil.TextColorOn,ParamUtil.ShadowColorOn);
if activeControl = edEXO_SAISIE then
   WinRxLab(RxLabCodeExo,ParamUtil.TextColorOn,ParamUtil.ShadowColorOn);
if activeControl = DBCB_Derogatoire then
   WinRxLab(RxLabDerog,ParamUtil.TextColorOn,ParamUtil.ShadowColorOn);
if activeControl = ChbxReglAuto then
   WinRxLab(RxLabRegAuto,ParamUtil.TextColorOn,ParamUtil.ShadowColorOn);

if activeControl = Panel_PM1 then
   WinRxLab(LabActivite,ParamUtil.TextColorOn,ParamUtil.ShadowColorOn);
if activeControl = Panel_PM2 then
   WinRxLab(LabPlanAux,ParamUtil.TextColorOn,ParamUtil.ShadowColorOn);
if activeControl = Panel_PM3 then
   WinRxLab(LabTVACollectee,ParamUtil.TextColorOn,ParamUtil.ShadowColorOn);
if activeControl = Panel_PM4 then
   WinRxLab(LabTypeEnt,ParamUtil.TextColorOn,ParamUtil.ShadowColorOn);
if activeControl = Panel_PM5 then
   WinRxLab(RxLabPerTVA,ParamUtil.TextColorOn,ParamUtil.ShadowColorOn);
end;


Procedure TParamEnt.GestionAccesEcran;
var
Accept:boolean;
begin
DeFiltrageDataSet(DMRech.TaBalanceRech);
Accept:=((DMRech.TaBalanceRech.RecordCount = 0)and(e.AccesOuverture));
//if accept then//ne peut être modifié si clôture déjà effectuée
//  Accept:=e.AccesOuverture;
if not accept then//même si déjà commencé, on laisse la modif possible si maintenance
//à condition qu'on ai accès à l'ouverture
  Accept:=((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'));
EnableWinControl([edDATE_DEB_EXO,edDATE_FIN_EXO,edDATE_PREM_DECL_TVA,edEXO_SAISIE],Accept);
EnableWinControl([RxSwitchAgri1,RxSwitchInd1,RxSwitchAsso1,RxSwitch2,RxSwitch3,RxSwitch4],Accept);
   RxLabNomSoc.Caption:='Nom Société :' ;
if(e.TypeClient=Cl_Association)then
begin
   RxSwitchAsso1.StateOn:=false;
   RxSwitchAgri1.StateOn:=true;
   RxSwitchInd1.StateOn:=true;
   
   Panel_PM5.enabled:=false;
   //Panel_PM1.enabled:=false;
   Panel_PM3.enabled:=false;
   Panel_PM4.enabled:=false;
   edDATE_PREM_DECL_TVA.Enabled:=false;
   DBCB_Derogatoire.Enabled:=false;
   RxSwitchAgri1.Enabled:=false;
   RxSwitchInd1.Enabled:=false;
   RxSwitchTVAM.Enabled:=false;
   RxSwitchTVAT.Enabled:=false;
   RxSwitchTVAA.Enabled:=false;
   RxSwitch3.Enabled:=false;
   RxSwitch4.Enabled:=false;
   RxLabNomSoc.Caption:='Nom association :' ;
end
else RxSwitchAsso1.enabled:=false;
end;


procedure TParamEnt.BtnJuridiqueClick(Sender: TObject);
begin
 AfficheInfosJuridique;

end;

procedure TParamEnt.RxSwitchAsso1Off(Sender: TObject);
begin
initRxSwitchToutesActivites(RxSwitchAsso1,false);

end;

procedure TParamEnt.RxSwitchAsso1On(Sender: TObject);
begin
initRxSwitchToutesActivites(RxSwitchAsso1,true);

end;

end.
