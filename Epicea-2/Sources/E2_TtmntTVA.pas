unit E2_TtmntTVA;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit,LibDates, Grids, DBGrids, ComCtrls,LibSQL,Gr_Librairie_Obj,
  TeeProcs, TeEngine, Chart, DBChart, ExtCtrls, CurrEdit, DBCtrls, Buttons,
  RXCtrls,E2_Librairie_Obj,E2_Decl_Records,LibZoneSaisie, RXDBCtrl,
  ExRxDBGrid, GrDBGrid,LibRessourceString, Menus,E2_LibInfosTable,DMPointages2,
  GrGrid,db,Registry,DMConstantes, LibGestionParamXML, jpeg;

type
  TTtmntTVA = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaBas: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    RxSBValidePeriode: TRxSpeedButton;
    EditDebutPer: TDateEdit;
    EditFinPer: TDateEdit;
    PageControl1: TPageControl;
    PaTTabSheet: TPanel;
    PageControl2: TPageControl;
    TabSheet1: TTabSheet;
    Label3: TLabel;
    DBText1: TDBText;
    Label4: TLabel;
    Label5: TLabel;
    RxSBCreeOD: TRxSpeedButton;
    RxSBCreeVoirOD: TRxSpeedButton;
    LaDebit: TLabel;
    LaCredit: TLabel;
    LaDate: TLabel;
    CurMontantTransDeb: TCurrencyEdit;
    EdCompte: TEdit;
    CurMontantTransCre: TCurrencyEdit;
    DateOD: TDateEdit;
    TabSheet2: TTabSheet;
    ShapeCalendrier: TShape;
    RxSpeedButton3: TRxSpeedButton;
    RxSpeedButton4: TRxSpeedButton;
    RxSpeedButton5: TRxSpeedButton;
    RxSpeedButton6: TRxSpeedButton;
    RxSpeedButton7: TRxSpeedButton;
    RxSpeedButton8: TRxSpeedButton;
    RxSpeedButton9: TRxSpeedButton;
    RxSpeedButton10: TRxSpeedButton;
    RxSpeedButton11: TRxSpeedButton;
    RxSpeedButton12: TRxSpeedButton;
    RxSpeedButton13: TRxSpeedButton;
    RxSpeedButton14: TRxSpeedButton;
    RxSpeedButton15: TRxSpeedButton;
    RxSpeedButton16: TRxSpeedButton;
    RxSpeedButton17: TRxSpeedButton;
    RxSpeedButton18: TRxSpeedButton;
    RxSpeedButton19: TRxSpeedButton;
    TabSheet3: TTabSheet;
    DBChart1: TDBChart;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    PaLeft: TPanel;
    TShCalcul: TTabSheet;
    BtnTvaDebit: TButton;
    BtnEncaissement: TButton;
    BtnTotaux: TButton;
    TShValidation: TTabSheet;
    btnValider: TButton;
    BtnJournaux: TButton;
    PopupMenu1: TPopupMenu;
    Rglements1: TMenuItem;
    DtailsPointages1: TMenuItem;
    DtailsF71: TMenuItem;
    Imprimer1: TMenuItem;
    Panel2: TPanel;
    PaBtn: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label10: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    DBText8: TDBText;
    BtnAnnuler: TButton;
    BtnReglement: TButton;
    BtnDetail: TButton;
    BtnVisu: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    RxSBAttente: TRxSpeedButton;
    RxSBDeclare: TRxSpeedButton;
    RxSBTous: TRxSpeedButton;
    RxSBCEE: TRxSpeedButton;
    BtnSupprimer: TButton;
    PaTout: TPanel;
    PaCumul1: TPanel;
    Panel8: TPanel;
    RxSBReport: TRxSpeedButton;
    PaGrille: TPanel;
    GrDBVisu: TGrDBGrid;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    GrSolde: TGrGrid;
    Panel10: TPanel;
    Panel11: TPanel;
    GrTotaux: TGrGrid;
    GrReport: TGrGrid;
    ParamArrondi: TCurrencyEdit;
    procedure BtnValidePeriodeTVAClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnTvaDebitClick(Sender: TObject);
    procedure BtnEncaissementClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    procedure RxSpeedButton3Click(Sender: TObject);
    procedure RxSpeedButton15Click(Sender: TObject);
    procedure RxSpeedButton16Click(Sender: TObject);
    procedure RxSpeedButton17Click(Sender: TObject);
    procedure RxSpeedButton18Click(Sender: TObject);
    procedure RxSpeedButton19Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnValiderClick(Sender: TObject);
    procedure RxSBValidePeriodeClick(Sender: TObject);
    procedure BtnTotauxClick(Sender: TObject);
    procedure BtnJournauxClick(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CalculSolde(Demande:boolean);
    procedure PaBtnResize(Sender: TObject);
    procedure PaToolsResize(Sender: TObject);
    procedure QuDec_TvaAfterScroll(DataSet: TDataSet);
    procedure RxSBAttenteClick(Sender: TObject);
    procedure BtnReglementClick(Sender: TObject);
    procedure BtnDetailClick(Sender: TObject);
    procedure BtnVisuClick(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure DaQuDec_TvaStateChange(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure DateEdit1AcceptDate(Sender: TObject; var ADate: TDateTime;
      var Action: Boolean);
    procedure DateEdit2AcceptDate(Sender: TObject; var ADate: TDateTime;
      var Action: Boolean);
    procedure FormShow(Sender: TObject);
    procedure RxSBReportClick(Sender: TObject);
    procedure PaToutResize(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure EtatInitial(AvecCalculSolde:boolean);
    procedure EditDebutPerAcceptDate(Sender: TObject; var ADate: TDateTime;
      var Action: Boolean);
    procedure EditFinPerAcceptDate(Sender: TObject; var ADate: TDateTime;
      var Action: Boolean);
    procedure ParamArrondiExit(Sender: TObject);

    
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    TitreForm,SousTitreForm:String;
  end;

var
  TtmntTVA: TTtmntTVA;
  List_ID_Piece,List_ID_Pointage:TStringList;
  CalculerReport:boolean;

implementation

uses
DMTva,DMTTVA, E2_Cloture_Def, E2_Main, E2_DetailEcr, DMEcriture, DMPlanCpt,
  DMRecherche, DMBalances, LibClassObjetSenders;
{$R *.DFM}

procedure TTtmntTVA.BtnValidePeriodeTVAClick(Sender: TObject);
//Var
//DateDebut,DateFin:TDate;
begin
//DateDebut:=DateDebutPeriodeTVA.date;
//if DateInfos(DateDebut).Vide then
// begin
//   DateDebutPeriodeTVA.date:=01/01/2000;
//   DateDebut:=01/01/2000;
// end;
////if DateInfos(DateDebutPeriodeTVA.date).Vide then
////DateDebutPeriodeTVA.date:=10/10/2000;
//if DateInfos(DateFinPeriodeTVA.date).Vide then
//DateFinPeriodeTVA.date:=10/10/2001;
//if DateDebutPeriodeTVA.date > DateFinPeriodeTVA.date then
//   begin
//    Showmessage('La date de fin de période ne peut être antérieure à la date de début de période !');
//    DateFinPeriodeTVA.SetFocus;
//   end
//   else
//   begin
////    CalculMontantTvaD;
////    CalculMontantTvaE;
//    //    DBGrid1.DataSource:=DMTtmntTVA.DataSource1;
////    DMTtmntTVA.CalculTVA_D_SurPeriode(DateDebutPeriodeTVA.date,DateFinPeriodeTVA.date);
////    TotauxTVASurD;
//   end;
end;

procedure TTtmntTVA.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
DMTmTVA.DaQuDec_Tva.OnStateChange:=DaQuDec_TvaStateChange;
DaQuDec_TvaStateChange(DMTmTVA.QuDec_Tva);
GrDBVisu.ParamColor:=true;
GrDBVisu.Param:=ParamUtil.CouleurDBGrid;
GrDBVisu.UpDateColor;
GrDBVisu.FSauteColReadOnly:=false;

GrTotaux.ParamColor:=true;
GrTotaux.Param:=ParamUtil.CouleurDBGrid;
GrTotaux.DessineContourLigne:=false;
GrTotaux.UpDateColor;

GrSolde.ParamColor:=true;
GrSolde.Param:=ParamUtil.CouleurDBGrid;
GrSolde.DessineContourLigne:=false;
GrSolde.UpDateColor;

GrReport.ParamColor:=true;
GrReport.Param:=ParamUtil.CouleurDBGrid;
GrReport.DessineContourLigne:=false;
GrReport.UpDateColor;

TabSheet2.TabVisible:=true;
TabSheet1.TabVisible:=false;
TabSheet3.TabVisible:=false;
TShCalcul.TabVisible:=true;
TShValidation.TabVisible:=false;

ParamArrondi.Value:=e.ParamArrondisTVA;
CalculerReport:=true;
PageControl2.ActivePage:=PageControl2.Pages[TShCalcul.PageIndex];

if DMTmTVA.TaDec_Tva.active then
  begin
  if DMTmTVA.TaDec_Tva.RecordCount<>0 then
    Begin//si Calcul déjà demandé
       EtatInitial(false);
       CalculDeclarationTva(e.DateDebutDeclarationTVA,e.DateFinDeclarationTVA);
       CalculSolde(false);
    End;//fin si Calcul déjà demandé
  end;
end;

procedure TTtmntTVA.FormCreate(Sender: TObject);
Var
	Registre :TRegistry;
Begin
 Registre:= TRegistry.Create;

   try
	   with Registre do
           begin
	      RootKey := HKEY_LOCAL_MACHINE;

         OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, false);
            try
              RxSBAttente.AllowAllUp:=true;
              RxSBDeclare.AllowAllUp:=true;
              RxSBTous.AllowAllUp:=true;
              RxSBCEE.AllowAllUp:=true;
              RxSBAttente.down:=ReadBool('RxSBAttente');
              RxSBDeclare.down:=ReadBool('RxSBDeclare');
              RxSBTous.down:=ReadBool('RxSBTous');
              RxSBCEE.down:=ReadBool('RxSBCEE');
            except
              RxSBAttente.down:=false;
              RxSBDeclare.down:=true;
              RxSBTous.down:=false;
              RxSBCEE.down:=false;
            end;
         end;
   finally
     Registre.Free;
     RxSBAttente.AllowAllUp:=false;
     RxSBDeclare.AllowAllUp:=false;
     RxSBTous.AllowAllUp:=false;
     RxSBCEE.AllowAllUp:=false;
     RxSBAttenteClick(RxSBAttente);
     CalculerReport:=true;
   end;



BtnTvaDebit.Caption:='Totaux Tva sur'+#13#10+'débit (D)';
CaptionMultiLigne(BtnTvaDebit);

BtnEncaissement.Caption:='Totaux Tva sur'+#13#10+'encaissement (E)';
CaptionMultiLigne(BtnEncaissement);

//EditDebutPer.Date:=E.DateDebutDeclarationTVA;  //transféré dans le show isa le 17-01-03
//EditFinPer.Date:=E.DateFinDeclarationTVA;


  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;

procedure TTtmntTVA.BtnTvaDebitClick(Sender: TObject);
Var
DateDebut,DateFin:TDate;
begin
EtatInitial(false);
DeclarationTVATypeD(EditDebutPer.date,EditFinPer.date);
CalculSolde(CalculerReport);
end;

procedure TTtmntTVA.BtnEncaissementClick(Sender: TObject);
Var
DateDebut,DateFin:TDate;
begin
EtatInitial(false);
DeclarationTVATypeE(EditDebutPer.date,EditFinPer.date);
CalculSolde(CalculerReport);
end;

Procedure TTtmntTVA.InitialiseTable_A_Nil;
Begin
//  DMTmTVA.QuDec_Tva.AfterScroll:=nil;
//  DMTmTVA.DaQuDec_Tva.OnStateChange:=nil;
  if DMTmTVA <>nil then
  InitDatasetEvent_A_Nil_Sur_Form([DMTmTVA.DaQuDec_Tva,DMTmTVA.QuDec_Tva]);
End;

procedure TTtmntTVA.FormDestroy(Sender: TObject);
Var
	Registre :TRegistry;
Begin
 InitialiseTable_A_Nil;
 Registre:= TRegistry.Create;

   try
	   with Registre do
           begin
	      RootKey := HKEY_LOCAL_MACHINE;

         OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, false);
            try
              WriteBool('RxSBAttente',RxSBAttente.down);
              WriteBool('RxSBDeclare',RxSBDeclare.down);
              WriteBool('RxSBTous',RxSBTous.down);
              WriteBool('RxSBCEE',RxSBCEE.down);
            except
              CloseKey
            end;
         end;
   finally
		Registre.Free;
   end;
List_ID_Piece.Free;
LibGestionParamXML.DestroyForm(self,E.User);
TtmntTVA:=nil;
end;

procedure TTtmntTVA.RxSpeedButton3Click(Sender: TObject);
var
i,mois,DerJour:integer;
begin
for i:=3 to 14 do
 Begin
  TRxSpeedButton(self.FindComponent('RxSpeedButton'+Inttostr(i))).groupindex:=1;
 End;
TRxSpeedButton(sender).AllowAllUp:=false;
if not TRxSpeedButton(sender).Down then TRxSpeedButton(sender).Down:=true;
for i:=3 to 14 do
 Begin
  if TRxSpeedButton(self.FindComponent('RxSpeedButton'+Inttostr(i))).down then
      mois:=i-2;
 End;

for i:=15 to 18 do
 Begin
TRxSpeedButton(self.FindComponent('RxSpeedButton'+Inttostr(i))).AllowAllUp:=true;
  TRxSpeedButton(self.FindComponent('RxSpeedButton'+Inttostr(i))).groupindex:=2;
  TRxSpeedButton(self.FindComponent('RxSpeedButton'+Inttostr(i))).Down:=false;
 End;
case mois of
   1..9:begin
          EditDebutPer.text:='01/0'+inttostr(mois)+'/'+DateInfos(Now).AnStr;
          DerJour:=GetNbDayOfMonth(mois,DateInfos(Now).an);
          EditFinPer.text:=Inttostr(DerJour)+'/0'+inttostr(mois)+'/'+DateInfos(Now).AnStr;
          if mois in [4,8] then
//            GrEtatVerse.Cells[4,0]:='Solde du mois d'''+MoisStr(StrToDAte(EditDebutPer.text))
           else
//            GrEtatVerse.Cells[4,0]:='Solde du mois de '+MoisStr(StrToDAte(EditFinPer.text));
        end;
   10..12:begin
           EditDebutPer.text:='01/'+inttostr(mois)+'/'+DateInfos(Now).AnStr;
           DerJour:=GetNbDayOfMonth(mois,DateInfos(Now).an);
           EditFinPer.text:=Inttostr(DerJour)+'/'+inttostr(mois)+'/'+DateInfos(Now).AnStr;
          if mois = 10 then
//            GrEtatVerse.Cells[4,0]:='Solde du mois d'''+MoisStr(StrToDAte(EditDebutPer.text))
           else
//            GrEtatVerse.Cells[4,0]:='Solde du mois de '+MoisStr(StrToDAte(EditFinPer.text));
          end;
end;

end;

procedure TTtmntTVA.RxSpeedButton15Click(Sender: TObject);
begin
if RxSpeedButton15.Down then
 Begin
  RxSpeedButton3.GroupIndex:=3;
  RxSpeedButton4.GroupIndex:=4;
  RxSpeedButton5.GroupIndex:=5;
  RxSpeedButton6.GroupIndex:=1;
  RxSpeedButton7.GroupIndex:=1;
  RxSpeedButton8.GroupIndex:=1;
  RxSpeedButton9.GroupIndex:=1;
  RxSpeedButton10.GroupIndex:=1;
  RxSpeedButton11.GroupIndex:=1;
  RxSpeedButton12.GroupIndex:=1;
  RxSpeedButton13.GroupIndex:=1;
  RxSpeedButton14.GroupIndex:=1;
  RxSpeedButton14.AllowAllUp:=true;

  RxSpeedButton3.down:=true;
  RxSpeedButton4.down:=true;
  RxSpeedButton5.down:=true;
  RxSpeedButton6.down:=False;
  RxSpeedButton7.down:=False;
  RxSpeedButton8.down:=False;
  RxSpeedButton9.down:=False;
  RxSpeedButton10.down:=False;
  RxSpeedButton11.down:=False;
  RxSpeedButton12.down:=False;
  RxSpeedButton13.down:=False;
  RxSpeedButton14.down:=False;

  RxSpeedButton15.AllowAllUp:=false;
  RxSpeedButton15.GroupIndex:=2;
  RxSpeedButton16.GroupIndex:=2;
  RxSpeedButton17.GroupIndex:=2;
  RxSpeedButton18.GroupIndex:=2;

  RxSpeedButton16.down:=False;
  RxSpeedButton17.down:=False;
  RxSpeedButton18.down:=False;
  RxSpeedButton15.down:=true;

  EditDebutPer.Date:=StrToDate('01/01/'+DateInfos(Now).AnStr);
  EditFinPer.Date:=StrToDate('30/03/'+DateInfos(Now).AnStr);

//  LaDateDeb.Caption:='01/01/'+DateInfos(Now).AnStr;
//  LaDateFin.Caption:='31/03/'+DateInfos(Now).AnStr;
//  GrEtatVerse.Cells[4,0]:='Solde du '+RxSpeedButton15.Caption;
 End;

end;

procedure TTtmntTVA.RxSpeedButton16Click(Sender: TObject);
begin
if RxSpeedButton16.Down then
 Begin
  RxSpeedButton3.GroupIndex:=1;
  RxSpeedButton4.GroupIndex:=1;
  RxSpeedButton5.GroupIndex:=1;
  RxSpeedButton6.GroupIndex:=6;
  RxSpeedButton7.GroupIndex:=7;
  RxSpeedButton8.GroupIndex:=8;
  RxSpeedButton9.GroupIndex:=1;
  RxSpeedButton10.GroupIndex:=1;
  RxSpeedButton11.GroupIndex:=1;
  RxSpeedButton12.GroupIndex:=1;
  RxSpeedButton13.GroupIndex:=1;
  RxSpeedButton14.GroupIndex:=1;
  RxSpeedButton14.AllowAllUp:=true;

  RxSpeedButton3.down:=False;
  RxSpeedButton4.down:=False;
  RxSpeedButton5.down:=False;
  RxSpeedButton6.down:=true;
  RxSpeedButton7.down:=true;
  RxSpeedButton8.down:=true;
  RxSpeedButton9.down:=False;
  RxSpeedButton10.down:=False;
  RxSpeedButton11.down:=False;
  RxSpeedButton12.down:=False;
  RxSpeedButton13.down:=False;
  RxSpeedButton14.down:=False;

  RxSpeedButton15.GroupIndex:=2;
  RxSpeedButton16.GroupIndex:=2;
  RxSpeedButton17.GroupIndex:=2;
  RxSpeedButton18.GroupIndex:=2;
  RxSpeedButton15.AllowAllUp:=false;
  RxSpeedButton17.down:=False;
  RxSpeedButton18.down:=False;
  RxSpeedButton15.down:=False;
  RxSpeedButton16.down:=True;

  EditDebutPer.Date:=StrToDate('01/04/'+DateInfos(Now).AnStr);
  EditFinPer.Date:=StrToDate('30/06/'+DateInfos(Now).AnStr);

//  LaDateDeb.Caption:='01/04/'+DateInfos(Now).AnStr;
//  LaDateFin.Caption:='30/06/'+DateInfos(Now).AnStr;
//  GrEtatVerse.Cells[4,0]:='Solde du '+RxSpeedButton16.Caption;
 End;

end;

procedure TTtmntTVA.RxSpeedButton17Click(Sender: TObject);
begin
if RxSpeedButton17.Down then
 Begin
  RxSpeedButton3.GroupIndex:=1;
  RxSpeedButton4.GroupIndex:=1;
  RxSpeedButton5.GroupIndex:=1;
  RxSpeedButton6.GroupIndex:=1;
  RxSpeedButton7.GroupIndex:=1;
  RxSpeedButton8.GroupIndex:=1;
  RxSpeedButton9.GroupIndex:=9;
  RxSpeedButton10.GroupIndex:=10;
  RxSpeedButton11.GroupIndex:=11;
  RxSpeedButton12.GroupIndex:=1;
  RxSpeedButton13.GroupIndex:=1;
  RxSpeedButton14.GroupIndex:=1;
  RxSpeedButton14.AllowAllUp:=true;

  RxSpeedButton3.down:=False;
  RxSpeedButton4.down:=False;
  RxSpeedButton5.down:=False;
  RxSpeedButton6.down:=False;
  RxSpeedButton7.down:=False;
  RxSpeedButton8.down:=False;
  RxSpeedButton9.down:=true;
  RxSpeedButton10.down:=true;
  RxSpeedButton11.down:=true;
  RxSpeedButton12.down:=False;
  RxSpeedButton13.down:=False;
  RxSpeedButton14.down:=False;

  RxSpeedButton15.GroupIndex:=2;
  RxSpeedButton16.GroupIndex:=2;
  RxSpeedButton17.GroupIndex:=2;
  RxSpeedButton18.GroupIndex:=2;
  RxSpeedButton15.AllowAllUp:=false;

  RxSpeedButton18.down:=False;
  RxSpeedButton15.down:=False;
  RxSpeedButton16.down:=False;
  RxSpeedButton17.down:=true;

  EditDebutPer.Date:=StrToDate('01/07/'+DateInfos(Now).AnStr);
  EditFinPer.Date:=StrToDate('30/09/'+DateInfos(Now).AnStr);
//  LaDateDeb.Caption:='01/07/'+DateInfos(Now).AnStr;
//  LaDateFin.Caption:='30/09/'+DateInfos(Now).AnStr;
//  GrEtatVerse.Cells[4,0]:='Solde du '+RxSpeedButton17.Caption;
 End;

end;

procedure TTtmntTVA.RxSpeedButton18Click(Sender: TObject);
begin
if RxSpeedButton18.Down then
 Begin
  RxSpeedButton3.GroupIndex:=1;
  RxSpeedButton4.GroupIndex:=1;
  RxSpeedButton5.GroupIndex:=1;
  RxSpeedButton6.GroupIndex:=1;
  RxSpeedButton7.GroupIndex:=1;
  RxSpeedButton8.GroupIndex:=1;
  RxSpeedButton9.GroupIndex:=1;
  RxSpeedButton10.GroupIndex:=1;
  RxSpeedButton11.GroupIndex:=1;
  RxSpeedButton12.GroupIndex:=12;
  RxSpeedButton13.GroupIndex:=13;
  RxSpeedButton14.GroupIndex:=14;
  RxSpeedButton11.AllowAllUp:=true;

  RxSpeedButton3.down:=False;
  RxSpeedButton4.down:=False;
  RxSpeedButton5.down:=False;
  RxSpeedButton6.down:=False;
  RxSpeedButton7.down:=False;
  RxSpeedButton8.down:=False;
  RxSpeedButton9.down:=False;
  RxSpeedButton10.down:=False;
  RxSpeedButton11.down:=False;
  RxSpeedButton12.down:=True;
  RxSpeedButton13.down:=True;
  RxSpeedButton14.down:=True;

  RxSpeedButton15.GroupIndex:=2;
  RxSpeedButton16.GroupIndex:=2;
  RxSpeedButton17.GroupIndex:=2;
  RxSpeedButton18.GroupIndex:=2;
  RxSpeedButton15.AllowAllUp:=false;

  RxSpeedButton15.down:=False;
  RxSpeedButton16.down:=False;
  RxSpeedButton17.down:=False;
  RxSpeedButton18.down:=True;

  EditDebutPer.Date:=StrToDate('01/10/'+DateInfos(Now).AnStr);
  EditFinPer.Date:=StrToDate('31/12/'+DateInfos(Now).AnStr);
//  LaDateDeb.Caption:='01/10/'+DateInfos(Now).AnStr;
//  LaDateFin.Caption:='31/12/'+DateInfos(Now).AnStr;
//  GrEtatVerse.Cells[4,0]:='Solde du '+RxSpeedButton18.Caption;
 End;

end;

procedure TTtmntTVA.RxSpeedButton19Click(Sender: TObject);
var
i,mois,DerJour:integer;
begin
for i:=3 to 18 do
 Begin
  TRxSpeedButton(self.FindComponent('RxSpeedButton'+Inttostr(i))).groupindex:=i;
  TRxSpeedButton(self.FindComponent('RxSpeedButton'+Inttostr(i))).Down:=true;
 End;
  EditDebutPer.Date:=StrToDate('01/01/'+DateInfos(Now).AnStr);
  EditFinPer.Date:=StrToDate('31/12/'+DateInfos(Now).AnStr);
//  LaDateDeb.Caption:='01/01/'+DateInfos(Now).AnStr;
//  LaDateFin.Caption:='31/12/'+DateInfos(Now).AnStr;
//  GrEtatVerse.Cells[4,0]:='Solde du '+LaDateDeb.Caption + ' au '+LaDateFin.Caption;
//CalcSolde;
end;


procedure TTtmntTVA.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
try
canClose:=true;
 if not (DMTmTVA.TaDec_Tva.Active) then DMTmTVA.TaDec_Tva.open;
 if DMTmTVA.TaDec_Tva.RecordCount<>0 then
   begin
   //if Application.messagebox(PChar('' ),'Attention',MB_ICONWARNING+MB_YESNO + MB_DEFBUTTON1) = IDYES then
   viderTable(DMTmTVA.TaDec_Tva);
   end;
  try
    if ((Cloture_Def<>nil)and(ActivationForm(Cloture_Def))) then // PB
      begin
        if Cloture_Def.EtapeSuivante>=10 then  { isa  le  09/09/03 }
          Cloture_Def.EtapeSuivante:=9;
      end;
  except
    //
  end;
except
  canclose:=false;
end;
if canclose then InitialiseTable_A_Nil;{ isa  le  29/01/04 }
end;

procedure TTtmntTVA.btnValiderClick(Sender: TObject);
var
ForceAffichage:TForceAffichage;
begin
ForceAffichage.Affiche:=true;
ForceAffichage.Force:=false;
EtatInitial(false);
CalculDeclarationTva(EditDebutPer.date,EditFinPer.date);
CalculSolde(CalculerReport);
if DMTmTVA.TaDec_Tva.RecordCount<>0 then
  begin//s'il y a des lignes pour la période à déclarer
   if Messagedlg(PChar('Êtes-vous sûr de vouloir valider la déclaration TVA pour la période : du'+
                        RetourChariotSimple+
                        DateInfos(EditDebutPer.date).DateStr+
                        RetourChariotSimple+
                        'Au'+
                        RetourChariotSimple+
                        DateInfos(EditFinPer.date).DateStr+
                        RetourChariotSimple+
                        '?'),mtconfirmation, [mbno,mbyes],0) = mryes then
      if DMTmTVA.VAliderDeclarationTVA(EditDebutPer.date,EditFinPer.date,true,ForceAffichage).retour then
      begin
        EditDebutPer.Date:=E.DateDebutDeclarationTVA;
        EditFinPer.Date:=E.DateFinDeclarationTVA;
        EtatInitial(true);
      end;
  end;//fin s'il y a des lignes pour la période à déclarer
end;

procedure TTtmntTVA.RxSBValidePeriodeClick(Sender: TObject);
Var
DateDebut,DateFin:TDate;
begin
DateDebut:=EditDebutPer.date;
if DateInfos(DateDebut).Vide then
 begin
   EditDebutPer.date:=E.DateDebutDeclarationTVA;
   DateDebut:=EditDebutPer.date;
 end;

 if DateInfos(EditFinPer.date).Vide then
    EditFinPer.date:=E.DateFinDeclarationTVA;
if EditDebutPer.date > EditFinPer.date then
   begin
    Showmessage('La date de fin de période ne peut être antérieure à la date de début de période !');
    EditFinPer.SetFocus;
    abort;
   end;
end;

procedure TTtmntTVA.BtnTotauxClick(Sender: TObject);
begin
EtatInitial(false);
CalculDeclarationTva(EditDebutPer.date,EditFinPer.date);
CalculSolde(CalculerReport);
   if DMTmTVA.QuSumParCode_Dec_Tva.Active then DMTmTVA.QuSumParCode_Dec_Tva.Close;
 DMTmTVA.QuSumParCode_Dec_Tva.Open;
end;

procedure TTtmntTVA.BtnJournauxClick(Sender: TObject);
begin
//viderTable(DMTmTVA.TaDec_Tva); //isa le 30-12-02
//CalculDeclarationTva(EditDebutPer.date,EditFinPer.date);//isa le 30-12-02
CalculSolde(false);
AffichInfoDeclarationTVA(RqDec_Tva_SommeTvaParCode_1);
end;

procedure TTtmntTVA.PaGrilleResize(Sender: TObject);
begin
//FormateTailleColonne(GrDBVisu,50,[5,5,12,3,3,6,3,6,6]);
//WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
////GrTotaux
//Panel11.Width:=RenvoiTailleColonne(GrDBVisu,[0,1,2,3,4,5])+10;
//GrTotaux.ColWidths[0]:=GrDBVisu.ColWidths[6];
//GrTotaux.ColWidths[1]:=GrDBVisu.ColWidths[7];
//GrTotaux.ColWidths[2]:=GrDBVisu.ColWidths[8];
//GrTotaux.ColWidths[3]:=GrDBVisu.ColWidths[9];
////GrSolde
//Panel7.Width:=RenvoiTailleColonne(GrDBVisu,[0,1,2,3,4,5,6,7])+12;
//GrSolde.ColWidths[0]:=GrDBVisu.ColWidths[8];
//GrSolde.ColWidths[1]:=GrDBVisu.ColWidths[9];
//
//Panel8.Width:=RenvoiTailleColonne(GrDBVisu,[0,1,2,3,4,5,6,7])+7;
//grreport.ColWidths[0]:=GrDBVisu.ColWidths[8];
//grreport.ColWidths[1]:=GrDBVisu.ColWidths[9];

end;



procedure TTtmntTVA.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
WinSuivPrec(Handle,key,[GrDBVisu]);
     If Key = VK_ESCAPE Then
     Begin
       Key:= 0;
       self.close;
     End;
end;

procedure TTtmntTVA.CalculSolde(Demande:boolean);
var
SoldeTva,TotauxHTDeclare:currency;
TotauxTvaDebit,TotauxTvaCredit:TTotauxGeneric;

Begin
GrDBVisu.DataSource.DataSet.DisableControls ;
  try
    if demande then
    begin
      InitialiseTotauxBalance(DMTmTVA.TotauxReport.Totaux);
      DMTmTVA.TotauxReport.Retour:=false;

      //DMTmTVA.TotauxReport:=CalculReport(Demande,DMTmTVA.listeReports);
      if DMTmTVA.TotauxReport.Retour then
        CalculerReport:=false;
    end;
    
    if DMTmTVA.TotauxReport.Retour then
      Begin
            GrReport.Cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ', 0);
            GrReport.Cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ', 0);

          if DMTmTVA.TotauxReport.Totaux.SoldeDebitCreditFin then
            GrReport.Cells[0,0]:='D '+FormatFloat(E.FormatMonnaie + ';; ', abs(DMTmTVA.TotauxReport.Totaux.SoldeFin))
          else
            GrReport.Cells[1,0]:='C '+FormatFloat(E.FormatMonnaie + ';; ', abs(DMTmTVA.TotauxReport.Totaux.SoldeFin));
      End;

  SoldeTva:=0;
  TotauxHTDeclare:=0;
  InitialiseTotauxGeneric(TotauxTvaDebit);
  InitialiseTotauxGeneric(TotauxTvaCredit);

  TotauxTvaDebit:=SommeTotauxGenericQuery(['TvaMontantDebit'],GrDBVisu.DataSource.DataSet);
  TotauxTvaCredit:=SommeTotauxGenericQuery(['TvaMontantCredit'],GrDBVisu.DataSource.DataSet);
  TotauxHTDeclare:=SommeTotauxGenericQuery(['HT_Declare_Credit'],GrDBVisu.DataSource.DataSet).Total1-SommeTotauxGenericQuery(['HT_Declare_Debit'],GrDBVisu.DataSource.DataSet).Total1;

  SoldeTva:=arrondi(TotauxTvaCredit.Total1-TotauxTvaDebit.Total1,2);
  if TotauxHTDeclare<0 then
    GrTotaux.Cells[0,0]:='D '+FormatFloat(E.FormatMonnaie + ';; ', abs(TotauxHTDeclare))
  else
    GrTotaux.Cells[0,0]:='C '+FormatFloat(E.FormatMonnaie + ';; ', abs(TotauxHTDeclare));
  GrTotaux.Cells[2,0]:=FormatFloat(E.FormatMonnaie + ';; ', TotauxTvaDebit.Total1);
  GrTotaux.Cells[3,0]:=FormatFloat(E.FormatMonnaie + ';; ', TotauxTvaCredit.Total1);

  Grsolde.Cells[1,0]:='';
  Grsolde.Cells[0,0]:='';

  if DMTmTVA.TotauxReport.Retour then
    begin
      if DMTmTVA.TotauxReport.Totaux.SoldeDebitCreditFin then
        SoldeTva:=SoldeTva+(-abs(DMTmTVA.TotauxReport.Totaux.SoldeFin))
      else
        soldeTva:=SoldeTva+abs(DMTmTVA.TotauxReport.Totaux.SoldeFin);
    end;

  if SoldeTva < 0 then
     begin
       Grsolde.Cells[0,0]:='D '+FormatFloat(E.FormatMonnaie + ';; ', abs(SoldeTva))
     end
   else
     begin

       Grsolde.Cells[1,0]:='C '+FormatFloat(E.FormatMonnaie + ';; ', abs(SoldeTva));
     end;
GrDBVisu.DataSource.DataSet.EnableControls;
  except
    abort;
  end;
End;

procedure TTtmntTVA.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnReglement,BtnDetail,BtnVisu,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TTtmntTVA.PaToolsResize(Sender: TObject);
begin
FormateTailleBouttonAvecEspace([RxSBAttente,RxSBDeclare,RxSBTous,RxSBCEE],PaTools,90,0,5);
end;


procedure TTtmntTVA.QuDec_TvaAfterScroll(DataSet: TDataSet);
begin
 //
end;


//procedure TTtmntTVA.Button5Click(Sender: TObject);
//begin
//calculsolde;
//end;



procedure TTtmntTVA.RxSBAttenteClick(Sender: TObject);
var
Filtre:Tfiltre;
begin
try//finally
 filtre:=DMTmTVA.RecupCodeTva_A_Exclure(nil);
      if RxSBAttente.Down then
        begin
          FiltrageDataSet(GrDBVisu.DataSource.DataSet,'En_Attente = Vrai ');
          //FiltrageDataSet(GrDBVisu.DataSource.DataSet,'En_Attente = Vrai and not ('+Filtre+') ');
        end;
      if RxSBDeclare.Down then
        begin
          FiltrageDataSet(GrDBVisu.DataSource.DataSet,'En_Attente = faux ');
//          FiltrageDataSet(GrDBVisu.DataSource.DataSet,'En_Attente = faux and not ('+Filtre+') ');
        end;
      if RxSBTous.Down then
        begin
//          FiltrageDataSet(GrDBVisu.DataSource.DataSet,'not ('+Filtre+') ');
          DeFiltrageDataSet(GrDBVisu.DataSource.DataSet);
        end;
      if RxSBCEE.Down then
        begin
          if ((Filtre.filtrer)and(not empty(filtre.filtre))) then
            FiltrageDataSet(GrDBVisu.DataSource.DataSet,filtre.filtre)
          else
            FiltrageDataSet(GrDBVisu.DataSource.DataSet,'TvaCode =''''');
        end;
      CalculSolde(false);
finally
end;//fin du try finally
end;

procedure TTtmntTVA.BtnReglementClick(Sender: TObject);
Var
//InfosJournal:TInfosModel;
ParamAffichPointage:TParamAffichPointage;
//SavePlace:TBookMark;
begin
 if ActiveControl = GrDBVisu then
        Begin
         if ((copy(GrDBVisu.DataSource.DataSet.findField('compteContrepartie').AsString,1,1)='+')or(dmplan.CptEstPointable(GrDBVisu.DataSource.DataSet.findField('compteContrepartie').AsString))) then
           begin
             Initialise_TParamAffichPointage(ParamAffichPointage);
             ParamAffichPointage.ALettrer:=true;
             ParamAffichPointage.CptTiers:=GrDBVisu.DataSource.DataSet.findField('compteContrepartie').AsString;
             ParamAffichPointage.DateDeb:=0;
             ParamAffichPointage.DateFin:=E.DatExoFin;
             ParamAffichPointage.ID_Ecriture_Appelant:=GrDBVisu.DataSource.DataSet.FindField('ID_Contrepartie').AsInteger;
             ParamAffichPointage.ID_Reste_Appelant:=0;
             ParamAffichPointage.Reste_Appelant:=Infos_TInfosResteDC(DMRech.TaResteDCRech,'ID_Ecriture',[ParamAffichPointage.ID_Ecriture_Appelant]).Reste;

             if not VerifFNumeric(GrDBVisu.DataSource.DataSet.findField('HTDebit')).VideOUZero then
               begin
                 ParamAffichPointage.SensAppelant:='D';
                 ParamAffichPointage.Montant_Appelant:=GrDBVisu.DataSource.DataSet.FindField('HTDebit').ascurrency;
               end
             else
               begin
                 ParamAffichPointage.SensAppelant:='C';
                 ParamAffichPointage.Montant_Appelant:=GrDBVisu.DataSource.DataSet.FindField('HTCredit').ascurrency;
               end;
             ParamAffichPointage.Reference:=GrDBVisu.DataSource.DataSet.FindField('Reference').AsString;
             GestionAffichagePointageSurRef(true,true,ParamAffichPointage,not e.ExerciceCloture);
           end
           else
           begin
             ShowMessage('Attention !'+RetourChariotDouble+'Seules les lignes d''écritures concernant un compte pointables peuvent être pointées !');
           end;
         EtatInitial(false);
         CalculDeclarationTva(EditDebutPer.date,EditFinPer.date);
         CalculSolde(false);
        End;
end;


procedure TTtmntTVA.BtnDetailClick(Sender: TObject);
Var
ParamAffichPointage:TParamAffichPointage;
begin
    if ((copy(GrDBVisu.DataSource.DataSet.findField('compteContrepartie').AsString,1,1)='+')or(dmplan.CptEstPointable(GrDBVisu.DataSource.DataSet.findField('compteContrepartie').AsString))) then
    begin
        Initialise_TParamAffichPointage(ParamAffichPointage);
        ParamAffichPointage.CptTiers:=GrDBVisu.DataSource.DataSet.findField('compteContrepartie').AsString;
        ParamAffichPointage.ID_Ecriture_Appelant:=GrDBVisu.DataSource.DataSet.FindField('ID_Contrepartie').AsInteger;
        DetailPointageAffich(ParamAffichPointage.CptTiers,inttostr(ParamAffichPointage.ID_Ecriture_Appelant),0,true,true);
         EtatInitial(false);
         CalculDeclarationTva(EditDebutPer.date,EditFinPer.date);
         CalculSolde(false);
    end;
end;


procedure TTtmntTVA.BtnVisuClick(Sender: TObject);
begin
if empty(DMTmTVA.QUDec_Tva.FindField('CompteHT').AsString) then abort;
if copy(DMTmTVA.QUDec_Tva.FindField('CompteHT').AsString,1,1)<> '+' then
//if DMPlan.CptTiers(DMTmTVA.TaDec_Tva.FindField('Compte').AsString) then
 begin
   if DetailEcritureCompte(DMTmTVA.QUDec_Tva.FindField('CompteHT').AsString,False,False) then
      case DetailEcr.Tag of
         1:begin
           if DMEcritures.QueryEcrCompte.Locate('ID_Piece',DMTmTVA.QUDec_Tva.FindField('ID_Piece').AsInteger,[]) then
             PieceEcritureTiers;
           end;
         2:begin
           if DMEcritures.QueryEcrCompte.Locate('ID_Piece',DMTmTVA.QUDec_Tva.FindField('ID_Piece').AsInteger,[]) then
             PieceEcritureCompte;
           end;
      end;
 end
 else
 begin
   if DetailEcritureTiers(DMTmTVA.QUDec_Tva.FindField('CompteHT').AsString,False) then
      case DetailEcr.Tag of
         1:begin
           if DMEcritures.QueryEcrTiers.Locate('ID_Piece',DMTmTVA.QUDec_Tva.FindField('ID_Piece').AsInteger,[]) then
             PieceEcritureTiers;
           end;
         2:begin
           if DMEcritures.QueryEcrCompte.Locate('ID_Piece',DMTmTVA.QUDec_Tva.FindField('ID_Piece').AsInteger,[]) then
             PieceEcritureCompte;
           end;
      end;
 end;

end;

procedure TTtmntTVA.BtnImprimerClick(Sender: TObject);
begin
GrDBVisu.ReportCaption:='Totaux TVA';
GrDBVisu.GridPreview;
end;

procedure TTtmntTVA.BtnFermerClick(Sender: TObject);
begin
self.close;
end;


procedure TTtmntTVA.DaQuDec_TvaStateChange(Sender: TObject);
begin
Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DMTmTVA.DaQuDec_Tva.DataSet);
end;


procedure TTtmntTVA.BtnSupprimerClick(Sender: TObject);
begin
  try
    if not DMTmTVA.Suppression_Derniere_Declaration_Tva_Deverrouillable('',true,true,false,false).retour then
      abort
    else
      begin
        EditDebutPer.Date:=e.DateDebutDeclarationTVA;
        EditFinPer.Date:=e.DateFinDeclarationTVA;
        EtatInitial(true);
      end;
  except
     //abort;
     //showmessage('Problème rencontré lors de la suppression de la dernière déclaration de TVA');
  end;
end;

procedure TTtmntTVA.DateEdit1AcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
begin
e.DateDebutDeclarationTVA:=Adate;
end;

procedure TTtmntTVA.DateEdit2AcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
begin
e.DatefinDeclarationTVA:=Adate;
end;

procedure TTtmntTVA.FormShow(Sender: TObject);
begin
DMTmTVA.QuDec_Tva.AfterScroll:=QuDec_TvaAfterScroll;
DMTmTVA.MAJ_DateDeclarationTVA(E.DateDebutDeclarationTVA,E.DateFinDeclarationTVA);
EditDebutPer.Date:=E.DateDebutDeclarationTVA;
EditFinPer.Date:=E.DateFinDeclarationTVA;

GrReport.Cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',0);
GrReport.Cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',0);

GrTotaux.Cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ', 0);
GrTotaux.Cells[2,0]:=FormatFloat(E.FormatMonnaie + ';; ', 0);
GrTotaux.Cells[3,0]:=FormatFloat(E.FormatMonnaie + ';; ', 0);

Grsolde.Cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ', 0);
Grsolde.Cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ', 0);

InitialiseTotauxBalance(DMTmTVA.TotauxReport.Totaux);
DMTmTVA.TotauxReport.Retour:=false;


end;


procedure TTtmntTVA.RxSBReportClick(Sender: TObject);
begin
CalculSolde(true);
end;

procedure TTtmntTVA.PaToutResize(Sender: TObject);
begin
FormateTailleColonne(GrDBVisu,50,[5,5,12,3,3,6,3,6,6]);
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
//GrTotaux
Panel11.Width:=RenvoiTailleColonne(GrDBVisu,[0,1,2,3,4,5])+10;
GrTotaux.ColWidths[0]:=GrDBVisu.ColWidths[6];
GrTotaux.ColWidths[1]:=GrDBVisu.ColWidths[7];
GrTotaux.ColWidths[2]:=GrDBVisu.ColWidths[8];
GrTotaux.ColWidths[3]:=GrDBVisu.ColWidths[9];
//GrSolde
Panel7.Width:=Panel11.Width+RenvoiTailleColonne(GrDBVisu,[6,7])+2;
GrSolde.ColWidths[0]:=GrDBVisu.ColWidths[8];
GrSolde.ColWidths[1]:=GrDBVisu.ColWidths[9];

Panel8.Width:=Panel7.Width;
grreport.ColWidths[0]:=GrDBVisu.ColWidths[8];
grreport.ColWidths[1]:=GrDBVisu.ColWidths[9];
end;

procedure TTtmntTVA.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TTtmntTVA.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;


procedure TTtmntTVA.EtatInitial(AvecCalculSolde:boolean);
Begin
viderTable(DMTmTVA.TaDec_Tva);
//DMTmTVA.QuDec_Tva.Close;
DMTmTVA.PrepareQuDec_tva;
DMTmTVA.QuDec_Tva.Open;
ParamArrondi.Value:=e.ParamArrondisTVA;
EditDebutPer.Date:=e.DateDebutDeclarationTVA;
EditFinPer.Date:=e.DateFinDeclarationTVA;
if AvecCalculSolde then
  Begin
    CalculerReport:=true;
    CalculSolde(false);
  End;
End;

procedure TTtmntTVA.EditDebutPerAcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
var
ExceptLGR_:TExceptLGR;
begin
Initialise_ExceptLGR(ExceptLGR_);
  try
     //vérifier si cohérente et si ne fait pas déjà partie d'une déclaration
     if DMTmTVA.Verif_Si_Date_HorsDeclarationExistante(adate,e.DateFinDeclarationTVA,false).retour then
       e.DateDebutDeclarationTVA:=ADate
     else
       raise ExceptLGR.Create('Cette date fait déjà partie d''une période déclarée !',101,true,mtError,ExceptLGR_);
     CalculerReport:=true;
  except
     //action:=false;
     //abort;
  end;
end;

procedure TTtmntTVA.EditFinPerAcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
var
MessageLGR:TMessageLGR;
ExceptLGR_:TExceptLGR;
begin
Initialise_ExceptLGR(ExceptLGR_);
  try
//    if DateDsIntervale(e.DatExoDebut,Adate,e.DatExoFin,MessageLGR)then
//      begin
//       //vérifier si cohérente et si ne fait pas déjà partie d'une déclaration
       if DMTmTVA.Verif_Si_Date_HorsDeclarationExistante(adate,e.DateFinDeclarationTVA,false).retour then
         e.DateFinDeclarationTVA:=ADate
       else
         raise ExceptLGR.Create('Cette date fait déjà partie d''une période déclarée !',102,true,mtError,ExceptLGR_);
//      end
//    else
//      raise ExceptLGR.Create('La date de fin de déclaration ne fait pas partie de l''exercice en cours !',103,true,mtError,ExceptLGR_);
  CalculerReport:=true;
  except
     //action:=false;
     //abort;
  end;
end;

procedure TTtmntTVA.ParamArrondiExit(Sender: TObject);
begin
e.ParamArrondisTVA:=ParamArrondi.Value;
end;


end.
