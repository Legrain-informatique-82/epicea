unit E2_EtatGestAnal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,DMDiocEtatGestionAnalytique,
  Grids, DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid, StdCtrls, RXCtrls,
  ExtCtrls, RxDBComb,LibDates, quickrpt, Qrctrls,DMDiocEtatBalance,LibZoneSaisie,
  Menus,GR_Librairie_Obj,DMEcriture, GrGrid,E2_Librairie_Obj,db, ComCtrls,DMConstantes,
  LibGestionParamXML, jpeg;

type
  TEtatGestAnal = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxSpeedButton2: TRxSpeedButton;
    RxSpeedButton1: TRxSpeedButton;
    RxLabTitre: TRxLabel;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    PaBas: TPanel;
    PaEntete: TPanel;
    PaGrille: TPanel;
    GrDBEtatAnal: TGrDBGrid;
    RxDBTrame: TComboBox;
    Label1: TLabel;
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
    LaDateDeb: TLabel;
    Label2: TLabel;
    LaDateFin: TLabel;
    RxSpeedButton19: TRxSpeedButton;
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
    PaCumul2: TPanel;
    Panel7: TPanel;
    GrGrid2: TGrGrid;
    ShapeCalendrier: TShape;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure RxDBTrameChange(Sender: TObject);
    procedure RxSpeedButton15Click(Sender: TObject);
    procedure RxSpeedButton3Click(Sender: TObject);
    procedure RxSpeedButton16Click(Sender: TObject);
    procedure RxSpeedButton17Click(Sender: TObject);
    procedure RxSpeedButton18Click(Sender: TObject);
    procedure RxSpeedButton19Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    Procedure CalcSolde;
    procedure BtnImprimerClick(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure TaTrameAfterScroll(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PaCumul2Resize(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  EtatGestAnal: TEtatGestAnal;

implementation

uses UEtatGestAnal, E2_Main;

{$R *.DFM}

procedure TEtatGestAnal.FormCreate(Sender: TObject);
begin
if DMDiocEtatGestionAnal = nil then DMDiocEtatGestionAnal:=TDMDiocEtatGestionAnal.Create(application.MainForm);
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
DMDiocEtatGestionAnal.QuEtatAnal.Close;
DMDiocEtatGestionAnal.QuEtatAnal.ParamByName('DateDeb').AsDate:=Strtodate('01/01/'+DateInfos(Now).AnStr);
DMDiocEtatGestionAnal.QuEtatAnal.ParamByName('DateFin').AsDate:=Strtodate('31/12/'+DateInfos(Now).AnStr);
DMDiocEtatGestionAnal.QuEtatAnal.Close;
DMDiocEtatGestionAnal.QuEtatAnal.Open;
DMDiocEtatGestionAnal.TaTrame.Filtered:=false;
DMDiocEtatGestionAnal.TaTrame.Open;
DMDiocEtatGestionAnal.TaTrameL.Open;
DMDiocEtatGestionAnal.TaTrame.First;
while not DMDiocEtatGestionAnal.TaTrame.EOF do
 Begin
  RxDBTrame.Items.Add(DMDiocEtatGestionAnal.TaTrame.findfield('Libelle_trame').AsString);
  DMDiocEtatGestionAnal.TaTrame.Next;
 End;
RxDBTrame.ItemIndex:=-1;
DMDiocEtatGestionAnal.TaTrame.Filtered:=true;
DMDiocEtatGestionAnal.TaTrame.AfterScroll:=TaTrameAfterScroll;

end;

procedure TEtatGestAnal.RxDBTrameChange(Sender: TObject);
var
I:Integer;
begin
i:=3;
while ((not TRxSpeedButton(self.FindComponent('RxSpeedButton'+Inttostr(i))).Down) and (i<15)) do
 inc(i);
if i = 15 then
 begin
  RxSpeedButton19Click(RxSpeedButton19);
 end else
CalcSolde;
end;


procedure TEtatGestAnal.RxSpeedButton3Click(Sender: TObject);
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
          LaDateDeb.Caption:='01/0'+inttostr(mois)+'/'+DateInfos(Now).AnStr;
          DerJour:=GetNbDayOfMonth(mois,DateInfos(Now).an);
          LaDateFin.Caption:=Inttostr(DerJour)+'/0'+inttostr(mois)+'/'+DateInfos(Now).AnStr;
          if mois in [4,8] then
            GrDBEtatAnal.Columns[2].Title.Caption:='Solde du mois d'''+MoisStr(StrToDAte(LaDateDeb.Caption))+ ' ' + DateInfos(StrToDAte(LaDateDeb.Caption)).AnStr
           else
            GrDBEtatAnal.Columns[2].Title.Caption:='Solde du mois de '+MoisStr(StrToDAte(LaDateDeb.Caption))+ ' ' + DateInfos(StrToDAte(LaDateDeb.Caption)).AnStr;
        end;
   10..12:begin
           LaDateDeb.Caption:='01/'+inttostr(mois)+'/'+DateInfos(Now).AnStr;
           DerJour:=GetNbDayOfMonth(mois,DateInfos(Now).an);
           LaDateFin.Caption:=Inttostr(DerJour)+'/'+inttostr(mois)+'/'+DateInfos(Now).AnStr;
          if mois = 10 then
            GrDBEtatAnal.Columns[2].Title.Caption:='Solde du mois d'''+MoisStr(StrToDAte(LaDateDeb.Caption)) + ' ' + DateInfos(StrToDAte(LaDateDeb.Caption)).AnStr
           else
            GrDBEtatAnal.Columns[2].Title.Caption:='Solde du mois de '+MoisStr(StrToDAte(LaDateDeb.Caption)) + ' ' + DateInfos(StrToDAte(LaDateDeb.Caption)).AnStr;
          end;
end;
//GrDBEtatAnal.Columns[2].Title.Caption:='Solde du mois de '+MoisStr(StrToDAte(LaDateDeb.Caption))+ ' ' + DateInfos(StrToDAte(LaDateDeb.Caption)).AnStr;;
CalcSolde;
end;

procedure TEtatGestAnal.RxSpeedButton15Click(Sender: TObject);
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

  LaDateDeb.Caption:='01/01/'+DateInfos(Now).AnStr;
  LaDateFin.Caption:='31/03/'+DateInfos(Now).AnStr;
  GrDBEtatAnal.Columns[2].Title.Caption:='Solde du '+RxSpeedButton15.caption+ ' ' + DateInfos(StrToDAte(LaDateDeb.Caption)).AnStr;
 End;
CalcSolde;
end;

procedure TEtatGestAnal.RxSpeedButton16Click(Sender: TObject);
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
  LaDateDeb.Caption:='01/04/'+DateInfos(Now).AnStr;
  LaDateFin.Caption:='30/06/'+DateInfos(Now).AnStr;
  GrDBEtatAnal.Columns[2].Title.Caption:='Solde du '+RxSpeedButton16.caption+ ' ' + DateInfos(StrToDAte(LaDateDeb.Caption)).AnStr;
 End;
CalcSolde;
end;

procedure TEtatGestAnal.RxSpeedButton17Click(Sender: TObject);
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

  LaDateDeb.Caption:='01/07/'+DateInfos(Now).AnStr;
  LaDateFin.Caption:='30/09/'+DateInfos(Now).AnStr;
  GrDBEtatAnal.Columns[2].Title.Caption:='Solde du '+RxSpeedButton17.caption+ ' ' + DateInfos(StrToDAte(LaDateDeb.Caption)).AnStr;
 End;
CalcSolde;
end;

procedure TEtatGestAnal.RxSpeedButton18Click(Sender: TObject);
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

  LaDateDeb.Caption:='01/10/'+DateInfos(Now).AnStr;
  LaDateFin.Caption:='31/12/'+DateInfos(Now).AnStr;
  GrDBEtatAnal.Columns[2].Title.Caption:='Solde du '+RxSpeedButton18.caption+ ' ' + DateInfos(StrToDAte(LaDateDeb.Caption)).AnStr;
 End;
CalcSolde;
end;

procedure TEtatGestAnal.RxSpeedButton19Click(Sender: TObject);
var
i,mois,DerJour:integer;
begin
for i:=3 to 18 do
 Begin
  TRxSpeedButton(self.FindComponent('RxSpeedButton'+Inttostr(i))).groupindex:=i;
  TRxSpeedButton(self.FindComponent('RxSpeedButton'+Inttostr(i))).Down:=true;
 End;
  LaDateDeb.Caption:='01/01/'+DateInfos(Now).AnStr;
  LaDateFin.Caption:='31/12/'+DateInfos(Now).AnStr;
  GrDBEtatAnal.Columns[2].Title.Caption:='Solde du '+LaDateDeb.Caption + ' au '+LaDateFin.Caption;
CalcSolde;

end;

procedure TEtatGestAnal.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
//GrDBEtatAnal.SetFocus;
GrDBEtatAnal.ParamColor:=true;
GrDBEtatAnal.Param:=ParamUtil.CouleurDBGrid;
GrDBEtatAnal.UpDateColor;

GrGrid2.ParamColor:=true;
GrGrid2.Param:=ParamUtil.CouleurDBGrid;
GrGrid2.DessineContourLigne:=false;
GrGrid2.UpDateColor;
GrGrid2.FixedColor:=ParamUtil.CouleurDBGrid.GrilleColorFond;

DMDiocEtatGestionAnal.QuEtatAnal.Close;
DMDiocEtatGestionAnal.QuEtatAnal.Open;
end;

Procedure TEtatGestAnal.CalcSolde;
Begin
//DMDiocEtatBal.QuEcritureReport.Close;
//DMDiocEtatBal.QuEcritureReport.ParamByName('DateDeb').AsDate:=Strtodate(LaDateDeb.Caption);
////DMDiocEtatBal.QuEcritureReport.ParamByName('DateFin').AsDate:=Strtodate(LaDateFin.Caption);
//DMDiocEtatBal.QuEcritureReport.Open;
//
//DMDiocEtatBal.QuEcritureBase.Close;
//DMDiocEtatBal.QuEcritureBase.ParamByName('DateDeb').AsDate:=Strtodate(LaDateDeb.Caption);
//DMDiocEtatBal.QuEcritureBase.ParamByName('DateFin').AsDate:=Strtodate(LaDateFin.Caption);
//DMDiocEtatBal.QuEcritureBase.Open;

//DMDiocEtatBal.TaBalanceAffich.Refresh;
DMDiocEtatGestionAnal.QuEtatAnal.ParamByName('DateDeb').AsDate:=Strtodate(LaDateDeb.Caption);
DMDiocEtatGestionAnal.QuEtatAnal.ParamByName('DateFin').AsDate:=Strtodate(LaDateFin.Caption);
DMDiocEtatGestionAnal.QuEtatAnal.Close;
DMDiocEtatGestionAnal.QuEtatAnal.Open;
//DMDiocEtatGestionAnal.TaTrameL.Filtered:=false;
//DMDiocEtatGestionAnal.TaTrameL.ControlsDisabled;
if DMDiocEtatGestionAnal.TaTrame.Locate('Libelle_trame',RxDBTrame.Items[RxDBTrame.ItemIndex],[]) then
 begin
  GrDBEtatAnal.Visible:=true;
  DMDiocEtatGestionAnal.TaTrameL.Filtered:=false;
  DMDiocEtatGestionAnal.TaTrameL.DisableControls;
  DMDiocEtatGestionAnal.TaTrameL.Refresh;
  DMDiocEtatGestionAnal.TaTrameL.EnableControls;
 end
 else
 Begin
  DMDiocEtatGestionAnal.TaTrameL.Filtered:=true;
  GrDBEtatAnal.Visible:=False;
 End;

ShapeCalendrier.Left:=round((StrToDAte(LaDateDeb.Caption)-E.DatExoDebut)*1.1561643835616438356164383561644)+365;
ShapeCalendrier.Width:=round((StrToDAte(LaDateFin.Caption) - StrToDAte(LaDateDeb.Caption))*1.1561643835616438356164383561644)+1;

//DMDiocEtatGestionAnal.TaTrame.Filter:='Libelle_trame='''+ RxDBTrame.Items[RxDBTrame.ItemIndex]+''''
// else DMDiocEtatGestionAnal.TaTrame.Filter:='Libelle_trame=''''';
//if DMDiocEtatGestionAnal.TaTrame.Locate('Libelle_trame',RxDBTrame.Items[RxDBTrame.ItemIndex],[]) then
//DMDiocEtatGestionAnal.TaTrameL.Filter:='ID_Trame='+ DMDiocEtatGestionAnal.TaTrame.findfield('ID').AsString
//else DMDiocEtatGestionAnal.QuEtatAnal.Filter:='ID_Trame=0';
//DMDiocEtatGestionAnal.QuEtatAnal.Filter:='ID_Trame='+ DMDiocEtatGestionAnal.TaTrame.findfield('ID').AsString
//else DMDiocEtatGestionAnal.QuEtatAnal.Filter:='ID_Trame=0';
//DMDiocEtatGestionAnal.TaTrameL.Filtered:=true;
//DMDiocEtatGestionAnal.TaTrameL.EnableControls;
End;

procedure TEtatGestAnal.BtnImprimerClick(Sender: TObject);
begin
FEtatGestAnal.PrintIfEmpty:=true;
FEtatGestAnal.QRTotal.Caption:=GrGrid2.cells[0,0];
FEtatGestAnal.QRLaPeriode.Caption:='Du  '+ LaDateDeb.Caption + '  Au  ' + LaDateFin.Caption;
//FEtatGestAnal.QRExpr1.Caption:=FormatFloat(E.FormatMonnaie + ';; ', StrToCurr(trim(FEtatGestAnal.QRExpr1.Caption)));
FEtatGestAnal.Preview;
end;

procedure TEtatGestAnal.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TEtatGestAnal.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue (sender as TButton);
end;

procedure TEtatGestAnal.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit (sender as TButton);
end;

procedure TEtatGestAnal.Visualisation1Click(Sender: TObject);
begin
 if not empty(DMDiocEtatGestionAnal.TaTrameL.findfield('compte').ASString) then
   DetailEcritureCompte(DMDiocEtatGestionAnal.TaTrameL.findfield('compte').ASString,true,False)
end;

procedure TEtatGestAnal.BtnFermerClick(Sender: TObject);
begin
self.close;
end;

procedure TEtatGestAnal.TaTrameAfterScroll(DataSet: TDataSet);
begin
GrGrid2.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ', DiocTotauxTrame(StrToDate(LaDateDeb.Caption),StrToDAte(LaDateFin.Caption),DataSet['Code']).Solde);//
end;
procedure TEtatGestAnal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
If (key = VK_ESCAPE) then self.close;
end;

procedure TEtatGestAnal.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
canclose:=true;
end;

procedure TEtatGestAnal.PaCumul2Resize(Sender: TObject);
begin
Panel7.Width:=RenvoiTailleColonne(GrDBEtatAnal,[0,1,2]);
GrGrid2.ColWidths[0]:=RenvoiTailleColonne(GrDBEtatAnal,[3]);
end;

procedure TEtatGestAnal.PaGrilleResize(Sender: TObject);
begin
FormateTailleColonne(GrDBEtatAnal,10,[1,3,4]);
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TEtatGestAnal.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,E.User);
EtatGestAnal:=nil;
end;

end.
