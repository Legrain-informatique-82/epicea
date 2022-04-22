unit E2_EtatVerse;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,DMDiocEtatVersements,
  Grids, DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid, StdCtrls, RXCtrls,
  ExtCtrls, GrGrid,Lib1,LibDates,GR_Librairie_Obj,LibZoneSaisie,LibSQL,Ecriture_Isa,
  Menus,E2_Librairie_Obj,DMEcriture,Registry,DMParamTaxes,DMDiocEtatGestionAnalytique
  ,DMConstantes, LibGestionParamXML, jpeg;
  //,E2_FormContainers;

type
  TEtatVerse = class(TForm)
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
    PaEntete: TPanel;
    PaGrille: TPanel;
    GrEtatVerse: TGrGrid;
    PaBas: TPanel;
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
    BtnCreationEtat: TButton;
    ShapeCalendrier: TShape;
    Etatdeversement1: TMenuItem;
    N2: TMenuItem;
    N1Trimestre1: TMenuItem;
    N2Trimestre1: TMenuItem;
    N3Trimestre1: TMenuItem;
    N4Trimestre1: TMenuItem;
    LaTotalTrimPrec: TLabel;
    Label4: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GrEtatVerseKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrEtatVerseKeyPress(Sender: TObject; var Key: Char);
    procedure BtnImprimerClick(Sender: TObject);
    procedure RxSpeedButton3Click(Sender: TObject);
    procedure RxSpeedButton15Click(Sender: TObject);
    procedure RxSpeedButton16Click(Sender: TObject);
    procedure RxSpeedButton17Click(Sender: TObject);
    procedure RxSpeedButton18Click(Sender: TObject);
    procedure RxSpeedButton19Click(Sender: TObject);
    Procedure CalcSolde;
    Procedure RempliGrlle(NumTrimestre:Integer);
    procedure GrEtatVerseRowValidate(Sender: TObject; var Valide,
      Action: Boolean; LastCol: Integer);
    procedure PaBtnResize(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure CreerODDeVersement(VoirOD:boolean);
    procedure Visualisation1Click(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure PaCumul2Resize(Sender: TObject);
    procedure BtnCreationEtatClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure N1Trimestre1Click(Sender: TObject);
    procedure N2Trimestre1Click(Sender: TObject);
    procedure N3Trimestre1Click(Sender: TObject);
    procedure N4Trimestre1Click(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  EtatVerse: TEtatVerse;
  SommeColonne:currency;

implementation

uses UEtatVerse, DMImportation,E2_Decl_Records, DMPiece, E2_Main, DMPlanCpt;

{$R *.DFM}

procedure TEtatVerse.FormActivate(Sender: TObject);
Var
i:integer;
begin
//if FormContainers= nil then FormContainers:=TFormContainers.Create(Application.mainForm);
//PaTools.Parent:=FormContainers;
//PaBas.Parent:=FormContainers;
//Patitre.Parent:=FormContainers;
//PaEntete.Parent:=FormContainers;
//PaGrille.Parent:=FormContainers;
//PaCumul2.Parent:=FormContainers;
//PaBtn.Parent:=FormContainers;
//FormContainers.Show;
Initialiser_ShortCut_Main(true);
GrEtatVerse.SetFocus;
if not empty(LaDateDeb.Caption) then CalcSolde;

GrEtatVerse.ParamColor:=true;
GrEtatVerse.Param:=ParamUtil.CouleurDBGrid;
GrEtatVerse.UpDateColor;

GrGrid2.ParamColor:=true;
GrGrid2.Param:=ParamUtil.CouleurDBGrid;
GrGrid2.DessineContourLigne:=false;
GrGrid2.UpDateColor;
GrGrid2.FixedColor:=ParamUtil.CouleurDBGrid.GrilleColorFond;
end;

procedure TEtatVerse.FormCreate(Sender: TObject);
begin
//GrEtatVerse.Rows[0].CommaText:='," ",Compte,Libellé,"Solde Trimestre Précédent"';
GrEtatVerse.Rows[0].CommaText:='," ",Compte,Libellé';
GrEtatVerse.Champ.Add(Grtous);
GrEtatVerse.Champ.Add(Grtous);
GrEtatVerse.Champ.Add(Grtous);
//GrEtatVerse.Champ.Add(Grtous);
GrEtatVerse.Champ.Add(GrCurr);
//RxSpeedButton19Click(RxSpeedButton19);
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;

procedure TEtatVerse.GrEtatVerseKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//if (GrEtatVerse.col in [1,2,3]) then
  Begin
  if not (key in [VK_RETURN,VK_TAB,VK_UP,VK_DOWN,VK_CANCEL,VK_END,VK_HOME,VK_PRIOR,VK_NEXT,VK_LEFT,VK_RIGHT]) then
   begin
   key:=0;
   abort;
//   exit;
   end;
  End;

end;

procedure TEtatVerse.GrEtatVerseKeyPress(Sender: TObject; var Key: Char);
begin
//if (GrEtatVerse.col in [1,2,3]) then
  Begin
  if key <> #13 then
   begin
     key:=#0;
     exit;
   end;
  End;

end;

procedure TEtatVerse.BtnImprimerClick(Sender: TObject);
var
i:integer;
InfoEtatVers:TInfosEtatVersement;
begin
//for i:=1 to GrEtatVerse.RowCount-1 do
//if empty(GrEtatVerse.Cells[3,i]) then GrEtatVerse.Cells[3,i]:='0'+DecimalSeparator+'00';
//
//FEtatVers.PrintIfEmpty:=true;
//FEtatVers.QRLabel8.Font.Style:=[fsBold,fsStrikeOut];
//FEtatVers.QRLaPeriode.Caption:='Pas d''Etat de Versement pour la période du  '+ LaDateDeb.Caption + '  Au  ' + LaDateFin.Caption;
//FEtatVers.QRTotal.Caption:=GrGrid2.cells[0,0];
//if not (RxSpeedButton15.down and RxSpeedButton16.down) then
//if RxSpeedButton15.down then
// begin
//   InfoEtatVers:=EtatDeVersementGenere_Num(1);
//   if InfoEtatVers.Existe then
//    begin
//      FEtatVers.QRLaPeriode.Caption:='Du  '+ LaDateDeb.Caption + '  Au  ' + LaDateFin.Caption+' ( Réf : '+InfoEtatVers.NumOD+' du '+DateToStr(InfoEtatVers.DatePiece)+' )';
//      FEtatVers.QRLabel8.Font.Style:=[fsBold];
//    end;
// end
//else
//if RxSpeedButton16.down then
// begin
//   InfoEtatVers:=EtatDeVersementGenere_Num(2);
//   if InfoEtatVers.Existe then
//    begin
//      FEtatVers.QRLaPeriode.Caption:='Du  '+ LaDateDeb.Caption + '  Au  ' + LaDateFin.Caption+' ( Réf : '+InfoEtatVers.NumOD+' du '+DateToStr(InfoEtatVers.DatePiece)+' )';
//      FEtatVers.QRLabel8.Font.Style:=[fsBold];
//    end;
// end
//else
//if RxSpeedButton17.down then
// begin
//   InfoEtatVers:=EtatDeVersementGenere_Num(3);
//   if InfoEtatVers.Existe then
//    begin
//      FEtatVers.QRLaPeriode.Caption:='Du  '+ LaDateDeb.Caption + '  Au  ' + LaDateFin.Caption+' ( Réf : '+InfoEtatVers.NumOD+' du '+DateToStr(InfoEtatVers.DatePiece)+' )';
//      FEtatVers.QRLabel8.Font.Style:=[fsBold];
//    end;
// end
//else
//if RxSpeedButton18.down then
// begin
//   InfoEtatVers:=EtatDeVersementGenere_Num(4);
//   if InfoEtatVers.Existe then
//    begin
//      FEtatVers.QRLaPeriode.Caption:='Du  '+ LaDateDeb.Caption + '  Au  ' + LaDateFin.Caption+' ( Réf : '+InfoEtatVers.NumOD+' du '+DateToStr(InfoEtatVers.DatePiece)+' )';
//      FEtatVers.QRLabel8.Font.Style:=[fsBold];
//    end;
// end;
//
//FEtatVers.Preview;
end;

procedure TEtatVerse.RxSpeedButton3Click(Sender: TObject);
var
i,mois,DerJour:integer;
begin
BtnCreationEtat.Enabled:=false;
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
            GrEtatVerse.Cells[3,0]:='Solde du mois d'''+MoisStr(StrToDAte(LaDateDeb.Caption))+ ' ' + DateInfos(StrToDAte(LaDateDeb.Caption)).AnStr
           else
            GrEtatVerse.Cells[3,0]:='Solde du mois de '+MoisStr(StrToDAte(LaDateDeb.Caption))+ ' ' + DateInfos(StrToDAte(LaDateDeb.Caption)).AnStr;
        end;
   10..12:begin
           LaDateDeb.Caption:='01/'+inttostr(mois)+'/'+DateInfos(Now).AnStr;
           DerJour:=GetNbDayOfMonth(mois,DateInfos(Now).an);
           LaDateFin.Caption:=Inttostr(DerJour)+'/'+inttostr(mois)+'/'+DateInfos(Now).AnStr;
          if mois = 10 then
            GrEtatVerse.Cells[3,0]:='Solde du mois d'''+MoisStr(StrToDAte(LaDateDeb.Caption)) + ' ' + DateInfos(StrToDAte(LaDateDeb.Caption)).AnStr
           else
            GrEtatVerse.Cells[3,0]:='Solde du mois de '+MoisStr(StrToDAte(LaDateDeb.Caption)) + ' ' + DateInfos(StrToDAte(LaDateDeb.Caption)).AnStr;
          end;
end;

//GrDBEtatAnal.Columns[2].Title.Caption:='Solde du mois de '+MoisStr(StrToDAte(LaDateDeb.Caption));
CalcSolde;

end;

procedure TEtatVerse.RxSpeedButton15Click(Sender: TObject);
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

  N1Trimestre1.Checked:=RxSpeedButton15.down;
  N2Trimestre1.Checked:=RxSpeedButton16.down;
  N3Trimestre1.Checked:=RxSpeedButton17.down;
  N4Trimestre1.Checked:=RxSpeedButton18.down;

  LaDateDeb.Caption:='01/01/'+DateInfos(Now).AnStr;
  LaDateFin.Caption:='31/03/'+DateInfos(Now).AnStr;
  GrEtatVerse.Cells[3,0]:='Solde du '+RxSpeedButton15.Caption +' ' + DateInfos(StrToDAte(LaDateDeb.Caption)).AnStr;
 End;
CalcSolde;
BtnCreationEtat.Enabled:=true;

end;

procedure TEtatVerse.RxSpeedButton16Click(Sender: TObject);
begin
BtnCreationEtat.Enabled:=true;
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

  N1Trimestre1.Checked:=RxSpeedButton15.down;
  N2Trimestre1.Checked:=RxSpeedButton16.down;
  N3Trimestre1.Checked:=RxSpeedButton17.down;
  N4Trimestre1.Checked:=RxSpeedButton18.down;

  LaDateDeb.Caption:='01/04/'+DateInfos(Now).AnStr;
  LaDateFin.Caption:='30/06/'+DateInfos(Now).AnStr;
  GrEtatVerse.Cells[3,0]:='Solde du '+RxSpeedButton16.Caption + ' ' + DateInfos(StrToDAte(LaDateDeb.Caption)).AnStr;;
 End;
CalcSolde;

end;

procedure TEtatVerse.RxSpeedButton17Click(Sender: TObject);
begin
BtnCreationEtat.Enabled:=true;
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

  N1Trimestre1.Checked:=RxSpeedButton15.down;
  N2Trimestre1.Checked:=RxSpeedButton16.down;
  N3Trimestre1.Checked:=RxSpeedButton17.down;
  N4Trimestre1.Checked:=RxSpeedButton18.down;

  LaDateDeb.Caption:='01/07/'+DateInfos(Now).AnStr;
  LaDateFin.Caption:='30/09/'+DateInfos(Now).AnStr;
  GrEtatVerse.Cells[3,0]:='Solde du '+RxSpeedButton17.Caption + ' ' + DateInfos(StrToDAte(LaDateDeb.Caption)).AnStr;;
 End;
CalcSolde;

end;

procedure TEtatVerse.RxSpeedButton18Click(Sender: TObject);
begin
BtnCreationEtat.Enabled:=true;
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

  N1Trimestre1.Checked:=RxSpeedButton15.down;
  N2Trimestre1.Checked:=RxSpeedButton16.down;
  N3Trimestre1.Checked:=RxSpeedButton17.down;
  N4Trimestre1.Checked:=RxSpeedButton18.down;

  LaDateDeb.Caption:='01/10/'+DateInfos(Now).AnStr;
  LaDateFin.Caption:='31/12/'+DateInfos(Now).AnStr;
  GrEtatVerse.Cells[3,0]:='Solde du '+RxSpeedButton18.Caption+ ' ' + DateInfos(StrToDAte(LaDateDeb.Caption)).AnStr;
 End;
CalcSolde;

end;

procedure TEtatVerse.RxSpeedButton19Click(Sender: TObject);
var
i,mois,DerJour:integer;
begin
BtnCreationEtat.Enabled:=false;
for i:=3 to 18 do
 Begin
  TRxSpeedButton(self.FindComponent('RxSpeedButton'+Inttostr(i))).groupindex:=i;
  TRxSpeedButton(self.FindComponent('RxSpeedButton'+Inttostr(i))).Down:=true;
 End;
  LaDateDeb.Caption:='01/01/'+DateInfos(Now).AnStr;
  LaDateFin.Caption:='31/12/'+DateInfos(Now).AnStr;
  GrEtatVerse.Cells[3,0]:='Solde du '+LaDateDeb.Caption + ' au '+LaDateFin.Caption;
CalcSolde;
end;

Procedure TEtatVerse.CalcSolde;
var
DateDebTrim,DateFinTrim,DateDebTrimPrec,DateFinTrimPrec:TDate;
SommeColonne:currency;
begin
LaTotalTrimPrec.Caption:='< INCONNU >';
if TrimestreEnCours(StrToDAte(LaDateDeb.Caption),DateDebTrim,DateFinTrim) > 1 then
 Begin

    DMDiocEtatVersement.QuEcritureTrimPrec.Close;
    if TrimestrePrec(StrToDAte(LaDateDeb.Caption),DateDebTrimPrec,DateFinTrimPrec) then
     Begin
//       Label3.Caption:=DateToStr(DateDebTrimPrec);
//       Label4.Caption:=DateToStr(DateFinTrimPrec);
       DMDiocEtatVersement.QuEcritureTrimPrec.ParamByName('DAteDeb').AsDate:=DateDebTrimPrec;
       DMDiocEtatVersement.QuEcritureTrimPrec.ParamByName('DAteFin').AsDate:=DateFinTrimPrec;
       DMDiocEtatVersement.QuEcritureTrimPrec.ParamByName('RacCpt').AsString:='7545%';
       DMDiocEtatVersement.QuEcritureTrimPrec.Open;
//       Label3.Caption:=FormatFloat(E.FormatMonnaie + ';; ', DMDiocEtatVersement.QuEcritureTrimPrecDebit.AsCurrency);
//       Label3.Caption:=FormatFloat(E.FormatMonnaie + ';; ', DMDiocEtatVersement.QuEcritureTrimPrecCredit.AsCurrency);
       DMDiocEtatVersement.QuEcritureTrimPrec.First;
       SommeColonne:=0;
       while not DMDiocEtatVersement.QuEcritureTrimPrec.EOF do
         begin
           if DMPlan.TypeCompteCrediteur(DMDiocEtatVersement.QuEcritureTrimPrecCompte.AsString) then
           begin
            SommeColonne:=SommeColonne+DMDiocEtatVersement.QuEcritureTrimPrecCredit.AsCurrency;
           end
            else
            begin
              SommeColonne:=SommeColonne+DMDiocEtatVersement.QuEcritureTrimPrecDebit.AsCurrency;
            end;
            DMDiocEtatVersement.QuEcritureTrimPrec.Next;
         end;
       LaTotalTrimPrec.Caption:=FormatFloat(E.FormatMonnaie + ';; ', SommeColonne);

     end;
    //StrToDate(LaDateDeb.Caption);
//    DMDiocEtatVersement.QuEcritureTrimPrec.ParamByName('DAteFin').AsDate:=StrToDate(LaDateFin.Caption);

    DMDiocEtatVersement.QuEcriture.Close;
    DMDiocEtatVersement.QuEcriture.ParamByName('DAteDeb').AsDate:=StrToDate(LaDateDeb.Caption);
    DMDiocEtatVersement.QuEcriture.ParamByName('DAteFin').AsDate:=StrToDate(LaDateFin.Caption);
    DMDiocEtatVersement.QuEcriture.ParamByName('RacCpt').AsString:='7545%';
    DMDiocEtatVersement.QuEcriture.Open;
    DMDiocEtatVersement.QuEcriture.First;
    RempliGrlle(2);
 End
 else
 begin
    DMDiocEtatVersement.QuEcriture.Close;
    DMDiocEtatVersement.QuEcriture.ParamByName('DAteDeb').AsDate:=StrToDate(LaDateDeb.Caption);
    DMDiocEtatVersement.QuEcriture.ParamByName('DAteFin').AsDate:=StrToDate(LaDateFin.Caption);
    DMDiocEtatVersement.QuEcriture.ParamByName('RacCpt').AsString:='7545%';
    DMDiocEtatVersement.QuEcriture.Open;
    DMDiocEtatVersement.QuEcriture.First;
    RempliGrlle(1);
 end;
ShapeCalendrier.Left:=round((StrToDAte(LaDateDeb.Caption)-E.DatExoDebut)*1.1561643835616438356164383561644)+365;
ShapeCalendrier.Width:=round((StrToDAte(LaDateFin.Caption) - StrToDAte(LaDateDeb.Caption))*1.1561643835616438356164383561644)+1;
End;


Procedure TEtatVerse.RempliGrlle(NumTrimestre:Integer);
var
i:integer;
Begin
SommeColonne:=0;
case NumTrimestre of
   1:Begin
      for i:=1 to GrEtatVerse.RowCount-1 do
       GrEtatVerse.SupprimeLigne(i);
       GrEtatVerse.Row:=GrEtatVerse.RowCount-1;
       GrEtatVerse.Cells[1,GrEtatVerse.Row]:=DMDiocEtatVersement.QuEcritureCompte.AsString;
       GrEtatVerse.Cells[2,GrEtatVerse.Row]:=TraiteMotCle(DMDiocEtatVersement.QuEcritureLibelle.AsString,['']);
       if DMPlan.TypeCompteCrediteur(DMDiocEtatVersement.QuEcritureCompte.AsString) then
       begin
        GrEtatVerse.Cells[3,GrEtatVerse.Row]:=FormatFloat(E.FormatMonnaie + ';; ', DMDiocEtatVersement.QuEcritureCredit.AsCurrency);
        SommeColonne:=SommeColonne+DMDiocEtatVersement.QuEcritureCredit.AsCurrency;
       end
        else
        begin
          SommeColonne:=SommeColonne+DMDiocEtatVersement.QuEcritureDebit.AsCurrency;
          GrEtatVerse.Cells[3,GrEtatVerse.Row]:=FormatFloat(E.FormatMonnaie + ';; ', DMDiocEtatVersement.QuEcritureDebit.AsCurrency);
        end;

       for i:= 2 to DMDiocEtatVersement.QuEcriture.RecordCount do
        Begin
          GrEtatVerse.AjouteLigne;
          GrEtatVerse.Row:=GrEtatVerse.RowCount-1;
          DMDiocEtatVersement.QuEcriture.Next;
          GrEtatVerse.Cells[1,GrEtatVerse.Row]:=DMDiocEtatVersement.QuEcritureCompte.AsString;
          GrEtatVerse.Cells[2,GrEtatVerse.Row]:=TraiteMotCle(DMDiocEtatVersement.QuEcritureLibelle.AsString,['']);

          if DMPlan.TypeCompteCrediteur(DMDiocEtatVersement.QuEcritureCompte.AsString) then
          begin
           SommeColonne:=SommeColonne+DMDiocEtatVersement.QuEcritureCredit.AsCurrency;
           GrEtatVerse.Cells[3,GrEtatVerse.Row]:=FormatFloat(E.FormatMonnaie + ';; ', DMDiocEtatVersement.QuEcritureCredit.AsCurrency);
          end
           else
           begin
             SommeColonne:=SommeColonne+DMDiocEtatVersement.QuEcritureDebit.AsCurrency;
             GrEtatVerse.Cells[3,GrEtatVerse.Row]:=FormatFloat(E.FormatMonnaie + ';; ', DMDiocEtatVersement.QuEcritureDebit.AsCurrency);
           end;
        End;
     End;

   2:Begin
       for i:=1 to GrEtatVerse.RowCount-1 do
        GrEtatVerse.SupprimeLigne(i);
        GrEtatVerse.Row:=GrEtatVerse.RowCount-1;
        GrEtatVerse.Cells[1,GrEtatVerse.Row]:=DMDiocEtatVersement.QuEcritureCompte.AsString;
        GrEtatVerse.Cells[2,GrEtatVerse.Row]:=TraiteMotCle(DMDiocEtatVersement.QuEcritureLibelle.AsString,['']);

        if DMPlan.TypeCompteCrediteur(DMDiocEtatVersement.QuEcritureCompte.AsString) then
        begin
         GrEtatVerse.Cells[3,GrEtatVerse.Row]:=FormatFloat(E.FormatMonnaie + ';; ', DMDiocEtatVersement.QuEcritureCredit.AsCurrency);
         SommeColonne:=SommeColonne+DMDiocEtatVersement.QuEcritureCredit.AsCurrency;
        end
         else
         begin
           SommeColonne:=SommeColonne+DMDiocEtatVersement.QuEcritureDebit.AsCurrency;
           GrEtatVerse.Cells[3,GrEtatVerse.Row]:=FormatFloat(E.FormatMonnaie + ';; ', DMDiocEtatVersement.QuEcritureDebit.AsCurrency);
         end;

        for i:= 2 to DMDiocEtatVersement.QuEcriture.RecordCount do
         Begin
           GrEtatVerse.AjouteLigne;
           GrEtatVerse.Row:=GrEtatVerse.RowCount-1;
           DMDiocEtatVersement.QuEcriture.Next;
           GrEtatVerse.Cells[1,GrEtatVerse.Row]:=DMDiocEtatVersement.QuEcritureCompte.AsString;
           GrEtatVerse.Cells[2,GrEtatVerse.Row]:=TraiteMotCle(DMDiocEtatVersement.QuEcritureLibelle.AsString,['']);

           if DMPlan.TypeCompteCrediteur(DMDiocEtatVersement.QuEcritureCompte.AsString) then
           begin
            SommeColonne:=SommeColonne+DMDiocEtatVersement.QuEcritureCredit.AsCurrency;
            GrEtatVerse.Cells[3,GrEtatVerse.Row]:=FormatFloat(E.FormatMonnaie + ';; ', DMDiocEtatVersement.QuEcritureCredit.AsCurrency);
           end
            else
            begin
              SommeColonne:=SommeColonne+DMDiocEtatVersement.QuEcritureDebit.AsCurrency;
              GrEtatVerse.Cells[3,GrEtatVerse.Row]:=FormatFloat(E.FormatMonnaie + ';; ', DMDiocEtatVersement.QuEcritureDebit.AsCurrency);
            end;
         End;
     End;

end;
GrGrid2.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ', SommeColonne);
End;

procedure TEtatVerse.GrEtatVerseRowValidate(Sender: TObject; var Valide,
  Action: Boolean; LastCol: Integer);
begin
if empty(GrEtatVerse.Cells[3,GrEtatVerse.Row]) then GrEtatVerse.Cells[4,GrEtatVerse.Row]:='0'+DecimalSeparator+'00';

end;

procedure TEtatVerse.PaBtnResize(Sender: TObject);
var
TopBoutton,WidthButton:integer;
begin
TopBoutton:=0;
if (ActiveControl.ClassNameIs('TButton') and (ActiveControl <>BtnCreationEtat)) then TopBoutton:=ActiveControl.Top;
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,-TopBoutton);
end;

procedure TEtatVerse.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TEtatVerse.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TEtatVerse.BtnFermerClick(Sender: TObject);
begin
self.close;
end;


procedure TEtatVerse.CreerODDeVersement(VoirOD:boolean);
var
OD:string;
ListeOd:TStringList;
SourceEcriture:TRecordEcriture;
SourcePiece:TRecordPiece;
listeFactice:Tlist;
rang:integer;
tab:variant;
MontantServices,MontantHabitant:currency;
NBHabitant:integer;
Registre :TRegistry;
ValPieceAutoGen:TValPieceAutoGenere;
DateDeb,DAteFin:TDate;
Begin
//     OD:=CreationOD('Etat de versement','Compte de la pièce','',2,['H','H'],['Compte1',
//     'Compte2'],[0,0],[0,0],[0,CurMontantTransDeb.value],[CurMontantTransDeb.value,0],[0,CurMontantTransDeb.value],
//     [CurMontantTransDeb.value,0],[E.Devise,E.Devise],DateOD.Date,nil);

   try
     try
       listeFactice:=nil;
       DMPieces.Piece1.initialiseValPieceAutoGen(ValPieceAutoGen);
       ValPieceAutoGen.Champ_Gen:=E.ExerciceBase+'V'+Inttostr(TrimestreEnCours(StrToDAte(LaDateDeb.caption),DateDeb,DAteFin));
       TrimestreEnCours(StrToDAte(LaDateDeb.caption),DateDeb,DAteFin);
       ValPieceAutoGen.Val_Champ_Gen:='Etat de versement du '+LaDateDeb.Caption+' Au '+LaDateFin.Caption;
       SourcePiece.IDJournal:=3;
       SourcePiece.Date:=StrToDAte(LaDateFin.caption);
       SourcePiece.Validation:=now;
       SourcePiece.Libelle:='Etat de Versement du '+LaDateDeb.Caption+' Au '+LaDateFin.Caption;
       SourcePiece.Compte:=RenvoieInfoSurTableDiverse('4',DMPieces.Piece1.TableJournal,'ID_Journal',['Compte'],tab);
       SourcePiece.Journal:='OD';
       SourcePiece.TotalPiece:=-SommeColonne;
       DMImport.VerifCreationPieceEcriture;
       DMImport.Piece_Import.NouvellePiece(false);

       //SourcePiece.TotalPiece:=-SommeColonne(GrEtatVerse,3,1,GrEtatVerse.RowCount-1);
       if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
       DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
       rang:=1;
       //remplissage ligne vide
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H'],true,false,-1);
       //remplissage ligne de contrepartie
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',SourcePiece.Compte,'',SourcePiece.Libelle,0,0,SourcePiece.TotalPiece,0,'','',0,'',''],true,false,-1);
       While rang<=GrEtatVerse.RowCount-1 do
       Begin
        //remplissage des lignes de la grille
//        DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',GrEtatVerse.cells[1,rang],GrEtatVerse.cells[2,rang],0,0,strtocurr(copy(GrEtatVerse.cells[3,rang],1,length(GrEtatVerse.cells[3,rang])-2)),0,'','',0,'',''],true,false,-1);
        DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',GrEtatVerse.cells[1,rang],'',TraiteMotCle(GrEtatVerse.cells[2,rang],['']),0,0,strtocurr(QueDesChiffres(GrEtatVerse.cells[3,rang])),0,'','',0,'',''],true,false,-1);
       inc(rang);
       End;

        // Calcul du montant des services
        MontantServices:=DiocTaxePastorale * DiocTotauxTrame(StrToDate(LaDateDeb.caption),StrToDate(LaDateFin.caption),'SERVICES').debit;
        // Au credit
        DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H','7545232','',TraiteMotCle(DMPlan.LibelleDuNumCptPCU('7545232'),[Currtostr(DiocTaxePastorale*100)]),0,0,MontantServices,0,'','',0,'',''],true,false,-1);
        // Au debit
        DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H','65232','',TraiteMotCle(DMPlan.LibelleDuNumCptPCU('65232'),[Currtostr(DiocTaxePastorale*100)]),0,0,-MontantServices,0,'','',0,'',''],true,false,-1);

        inc(rang);

        NBHabitant:=0;
        // Calcul de la contribution totale fonction du nombre d'habitant
        Registre:= TRegistry.Create;
          try
            with Registre do
              begin
              RootKey := HKEY_LOCAL_MACHINE;
              OpenKey('\SOFTWARE\LGR\Epicea2\ParamParoisse', false);
                 try
                   NBHabitant:=ReadInteger('NbHabitant');
                 except
                   NBHabitant:=0;
                   if Application.MessageBox(PChar('Le nombre d''habitant pour votre paroisse n''a pas été enregistré.'+#10#13#10#13+'Voulez-vous le faire maintenant ?'),'Attention !!',MB_YESNO+MB_ICONWARNING + MB_DEFBUTTON2) = IDYES then
                   begin
                     Main.InformationsParoisse1Click(Main.InformationsParoisse1);
                     abort;
                   end
                   else
                   Begin
                     abort;
                   End;
                 end;
              end;//fin du with
          finally
            Registre.Free;
          end;
        if NBHabitant<=0 then
         Begin
          if Application.MessageBox(PChar('Le nombre d''habitant pour votre paroisse n''est pas cohérent :'+#10#13#10#13+'Ce nombre est : '+inttostr(NBHabitant)+#10#13#10#13+'Voulez-vous le corriger maintenant ?'),'Attention !!',MB_YESNO+MB_ICONWARNING + MB_DEFBUTTON2) = IDYES then
          begin
            Main.InformationsParoisse1Click(Main.InformationsParoisse1);
            abort;
          end
          else
          Begin
            abort;
          End;

         End;


        MontantHabitant:=NBHabitant * DiocTaxeContributionHabitant;
        // Au credit
        DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H','7545233','',TraiteMotCle(DMPlan.LibelleDuNumCptPCU('7545233'),[CurrToStr(DiocTaxeContributionHabitant),IntToStr(NBHabitant)]),0,0,MontantHabitant,0,'','',0,'',''],true,false,-1);
        // Au debit
        DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H','65233','',TraiteMotCle(DMPlan.LibelleDuNumCptPCU('65233'),[CurrToStr(DiocTaxeContributionHabitant),IntToStr(NBHabitant)]),0,0,-MontantHabitant,0,'','',0,'',''],true,false,-1);

       DMImport.RecupPieceEcriture_SurRecords(true,SourcePiece,DMImport.Ecriture_Import.ListeEcriturePiece,ValPieceAutoGen,'','',0);
       ListeOd:=TStringList.Create;
       DMImport.EnregistrementPiece(false,nil,ListeOd,listeFactice);
     except
       if DMImport.messageTmp then
         showmessage('Problème lors de l''enregistrement d''une pièce');
       abort;
     end;//fin du try except
   finally
   Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,EtatVerse,false);
//   if DMImport.Ecriture_Import.ListeEcriturePiece<>nil then
//     Begin
//        DMImport.Ecriture_Import.ListeEcriturePiece.Free;
//        DMImport.Ecriture_Import.ListeEcriturePiece:=nil;
//     End;
   end;//fin du try finally

     if VoirOD then
       Begin
//       ListeOd:=TStringList.Create;
//       ListeOd.Add(OD);
       DMPieces.AffichageFeuilleReprise(0,ListeOd,nil,'Affichage de l''OD de Versement','','',false);
//       ListeOd.Free;
       End;
//     FormActivate(self);
End;


procedure TEtatVerse.Visualisation1Click(Sender: TObject);
begin
if not empty(GrEtatVerse.Cells[1,GrEtatVerse.Row]) then
DetailEcritureCompte(GrEtatVerse.Cells[1,GrEtatVerse.Row],true,False)
end;

procedure TEtatVerse.PaGrilleResize(Sender: TObject);
begin
GrEtatVerse.ColWidths[0]:=10;
GrEtatVerse.ColWidths[1]:=(GrEtatVerse.Width) div 6;
GrEtatVerse.ColWidths[2]:=(GrEtatVerse.Width) div 3;
GrEtatVerse.ColWidths[3]:=(GrEtatVerse.Width) div 4;
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TEtatVerse.PaCumul2Resize(Sender: TObject);
begin
Panel7.Width:=GrEtatVerse.ColWidths[0]+GrEtatVerse.ColWidths[1]+GrEtatVerse.ColWidths[2]+10;
GrGrid2.ColWidths[0]:=GrEtatVerse.ColWidths[3];

end;

procedure TEtatVerse.BtnCreationEtatClick(Sender: TObject);
var
EtatVers:TDernierEtatValide;
DateDeb,DAteFin:TDate;
begin
EtatVers:=EtatDeVersementExiste(E.ExerciceSaisie);
// if EtatVers.Valide then
//  begin
   if EtatVers.RangSuivantACreer = TrimestreEnCours(StrToDAte(LaDateDeb.caption),DateDeb,DAteFin) then
   begin
     if Application.MessageBox(PChar('Êtes-vous sûr de vouloir créer l''Etat de Versement pour la période du '+LaDateDeb.Caption+' au '+LaDateFin.Caption+' ?'),'Confirmation',MB_YESNO+MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
       begin
          CreerODDeVersement(true);
       end;
   end
//  end;
  else
  Begin
   if ((EtatVers.Valide=true) and (EtatVers.CreationSuivantPossible=true)) then
    begin
      Application.MessageBox(PChar('Le dernier Etat de Versement est  : '+#10#13#10#13+EtatVers.Valeur_Champ_Gener),'Attention',MB_OK+MB_ICONWARNING + MB_DEFBUTTON2);
    end;
   if ((EtatVers.Valide=true) and (EtatVers.CreationSuivantPossible=False)) then
    begin
          Application.MessageBox(PChar('Aucun Etat de Versement possible, une erreur est intervenu !!'),'Attention',MB_OK+MB_ICONWARNING + MB_DEFBUTTON2);
    end;
   End;

end;

procedure TEtatVerse.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
If (key = VK_ESCAPE) then self.close;
end;

procedure TEtatVerse.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
//
//Patitre.Parent:=self;
//PaEntete.Parent:=self;
//PaGrille.Parent:=self;
//PaCumul2.Parent:=self;
//PaBtn.Parent:=self;
//PaBas.Parent:=self;
//PaTools.Parent:=self;
//FormContainers.Release;
//FormContainers:=nil;
CanClose:=true;
end;

procedure TEtatVerse.N1Trimestre1Click(Sender: TObject);
begin
  RxSpeedButton15.down:=true;
  RxSpeedButton15.Click;

end;

procedure TEtatVerse.N2Trimestre1Click(Sender: TObject);
begin
  RxSpeedButton16.down:=true;
  RxSpeedButton16.Click;
end;

procedure TEtatVerse.N3Trimestre1Click(Sender: TObject);
begin
  RxSpeedButton17.down:=true;
  RxSpeedButton17.Click;
end;

procedure TEtatVerse.N4Trimestre1Click(Sender: TObject);
begin
  RxSpeedButton18.down:=true;
  RxSpeedButton18.Click;
end;

procedure TEtatVerse.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);

end;

procedure TEtatVerse.Aide1Click(Sender: TObject);
begin
// If activecontrol = GrEtatVerse Then
//  begin
//    case GrEtatVerse.Col of
//                  0:Rechercher(GrEtatVerse,,['Compte','Designation','Actif','Date_Saisie'],['Compte','Désignation','',''],'',0);
//                  1:Rechercher(GrEtatVerse,,['Designation','Compte','Actif','Date_Saisie'],['Désignation','Compte','',''],'',0);
//    end;
//  end;
end;

procedure TEtatVerse.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,E.User);
EtatVerse:=nil;
end;

end.
