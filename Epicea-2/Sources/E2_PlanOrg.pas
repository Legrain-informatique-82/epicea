unit E2_PlanOrg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, gr_Librairie_obj, Buttons, DBTables,
  RxQuery, ExtCtrls, Grids, DBGrids, RXDBCtrl, ExRxDBGrid, Db, GrDBGrid,LibZoneSaisie,
  RXCtrls, Mask, DBCtrls,DMEcriture,LibRessourceString,LibSQL,DMConstantes,
  LibGestionParamXML, jpeg;

type
  TPlanCptbase = class(TForm)
    PopupMenu1: TPopupMenu;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    pmMenu1: TMenuItem;
    TaPlanCPTE: TTable;
    DaPlanCPTE: TDataSource;
    TaPlanCPTERegime: TStringField;
    TaPlanCPTECompte: TStringField;
    TaPlanCPTELibelle: TStringField;
    RxQuPlanCPTE: TRxQuery;
    Imprimer1: TMenuItem;
    Patitre: TPanel;
    PaBtn: TPanel;
    Button3: TButton;
    Button1: TButton;
    Button2: TButton;
    PaBas: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    PaGrille: TPanel;
    DBGridPlanOrg: TGrDBGrid;
    Edit_PM1: TEdit;
    Edit_PM2: TEdit;
    RxSBPlanAgri: TRxSpeedButton;
    RxSBPlanGene: TRxSpeedButton;
    DBEdCompte: TDBEdit;
    DBEdLibelle: TDBEdit;
    RxSBInfoVersion: TRxSpeedButton;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    procedure AideEnLigne(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pmMenu1Click(Sender: TObject);
    procedure Edit_PM1Enter(Sender: TObject);
    procedure Edit_PM2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit_PM2Change(Sender: TObject);
    procedure Edit_PM1Exit(Sender: TObject);
    function gerecroche(texte:string):string;
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit_PM1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit_PM1Change(Sender: TObject);
    procedure Edit_PM2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Enregister1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button3Enter(Sender: TObject);
    procedure Button3Exit(Sender: TObject);
    procedure PatitreResize(Sender: TObject);
    procedure RxSBPlanAgriMouseEnter(Sender: TObject);
    procedure RxSBPlanAgriMouseLeave(Sender: TObject);
    procedure RxSBPlanGeneMouseEnter(Sender: TObject);
    procedure RxSBPlanGeneMouseLeave(Sender: TObject);
    procedure RxSBPlanAgriClick(Sender: TObject);
    procedure RxSBPlanGeneClick(Sender: TObject);
    procedure DBGridPlanOrgKeyPress(Sender: TObject; var Key: Char);
    procedure RxQuPlanCPTEAfterScroll(DataSet: TDataSet);
    procedure DBEdCompteEnter(Sender: TObject);
    procedure DBEdLibelleEnter(Sender: TObject);
    procedure Edit_PM2Exit(Sender: TObject);
    procedure Edit_PM2Enter(Sender: TObject);
    procedure DBGridPlanOrgColExit(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure RxSBInfoVersionClick(Sender: TObject);
    procedure DaPlanCPTEDataChange(Sender: TObject; Field: TField);
  private
    { D�clarations priv�es }
  public
    FNumCompte:string;
    AffichePlanDefaut:boolean;
    TitreForm,SousTitreForm:String;
    { D�clarations publiques }
  published
    property NumCompte:string read FNumCompte write FNumCompte;
  end;

var
  PlanCptbase: TPlanCptbase;
  function PlanOrgCompte(var Compte:string):boolean;
implementation
{$R *.DFM}
Uses E2_Librairie_obj,
//Gr_Calculatrice,
E2_Main, DMAide, E2_AideAssist, E2_Decl_Records, ImportDll;


function PlanOrgCompte(var Compte:string):boolean;

begin
if (PlanCptbase = nil)
   then PlanCptbase:=TPlanCptbase.Create(Application.MainForm);

with PlanCptbase do
     begin
     WindowState:=wsNormal;
     position:=poScreenCenter;
     Width:=454;
     Height:=558;
     AffichePlanDefaut:=true;
     PlanCptbase.FNumCompte:=Compte;
     PlanOrgCompte := (showmodal = mrOK);
     end;
if result then Compte:=PlanCptbase.RxQuPlanCPTE.findfield('Compte').AsString;
end;

//****************************************************************************//
// Proc�dure AideEnLigne.                                                     //
//****************************************************************************//
procedure TPlanCptbase.AideEnLigne(Sender: TObject);
var
   aa,result:boolean;
begin
try
//WinShape(ActiveControl,Shape1,shape2,Main.ContourCouleur);
if ((AideAssist <> nil) and (AideAssist.Visible)) then
Result:=DMAides.taAssist.FindKey([self.Name+inttostr(self.tag),ActiveControl.Name]);
     if not Result then
        DMAides.taAssist.FindKey(['Vide','Vide']);
except
end;
end;
//****************************************************************************//

procedure TPlanCptbase.Calculatrice1Click(Sender: TObject);
begin
	AfficheCalculatrice(nil);
end;

procedure TPlanCptbase.Fermer1Click(Sender: TObject);
begin
	Self.Close;
end;

procedure TPlanCptbase.FormCreate(Sender: TObject);
begin
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
        InitialiseFormPosDefaut(self);
    end;
end;

procedure TPlanCptbase.FormDestroy(Sender: TObject);
begin
  	LibGestionParamXML.DestroyForm(Self,E.USer);
        PlanCptBase:=nil;
end;

procedure TPlanCptbase.pmMenu1Click(Sender: TObject);
begin
	PopupMenu1.Popup(Left + 50, Top + 50);
end;

procedure TPlanCptbase.Edit_PM1Enter(Sender: TObject);
begin
RxQuPlanCPTE.Locate('Compte',Edit_PM1.Text,[loPartialKey]);
Edit_PM1.SelStart:=length(Edit_PM1.Text)+1;
DBEdCompte.Hide;
end;

procedure TPlanCptbase.Edit_PM2KeyPress(Sender: TObject; var Key: Char);
begin
//RxQuPlanCPTE.DisableControls;
//RxQuPlanCPTE.SQL.Clear;
end;

function TPlanCptbase.gerecroche(texte:string):string;
var
i:integer;
begin
result:='';
for i:=1 to length(texte) do
    begin
     if texte[i]='''' then result:=result+'''''' else result:=result + texte[i];
    end;
end;

procedure TPlanCptbase.Edit_PM2Change(Sender: TObject);
var
Recherche:string;
begin
RxQuPlanCPTE.DisableControls;
RxQuPlanCPTE.Active:=false;
RxQuPlanCPTE.ParamByName('Libel').AsString:='%'+Edit_PM2.Text+'%';
//RxQuPlanCPTE.Params[0].AsString:='%'+Edit_PM2.Text+'%';
//RxQuPlanCPTE.SQL.Clear;
RxQuPlanCPTE.SQL.Add('select * from PlanCPTE.db where regime = '''+E.Regime+'''upper(libelle) like(upper(''%'+gerecroche(Edit_PM2.Text)+'%''))');
RxQuPlanCPTE.Active:=true;
RxQuPlanCPTE.EnableControls;
end;

procedure TPlanCptbase.Edit_PM1Exit(Sender: TObject);
begin
Edit_PM1.text:='';
DBEdCompte.show;
end;

procedure TPlanCptbase.Button3Click(Sender: TObject);
begin
if RxQuPlanCPTE.ParamByName('Regime').AsString ='A' then DBGridPlanOrg.ReportCaption:='Edition du plan comptable de base Agricole';
if RxQuPlanCPTE.ParamByName('Regime').AsString ='I' then DBGridPlanOrg.ReportCaption:='Edition du plan comptable de base Industriel';
DBGridPlanOrg.GridPreview;
end;

procedure TPlanCptbase.FormShow(Sender: TObject);
begin
if AffichePlanDefaut then
   begin
    if E.Regime='A' then
       begin
        RxSBPlanGene.Enabled:=false;
        RxSBPlanAgri.Enabled:=true;
        RxSBPlanGene.Down:=False;
        RxSBPlanAgri.Down:=true;
       end
       else
       begin
        RxSBPlanGene.Enabled:=true;
        RxSBPlanAgri.Enabled:=false;
        RxSBPlanGene.Down:=True;
        RxSBPlanAgri.Down:=False;
       end;
   end
   else
   Begin
     RxSBPlanGene.Enabled:=true;
     RxSBPlanAgri.Enabled:=true;
   End;


RxQuPlanCPTE.DisableControls;
RxQuPlanCPTE.Active:=false;
RxQuPlanCPTE.ParamByName('Regime').AsString:=E.Regime;
RxQuPlanCPTE.Active:=true;
RxQuPlanCPTE.EnableControls;
RxQuPlanCPTE.Locate('Compte',FNumCompte,[]);
end;

procedure TPlanCptbase.Button1Click(Sender: TObject);
begin
FNumCompte:=RxQuPlanCPTE.findfield('Compte').AsString;
ModalResult:=mrok;
//self.Close;
end;

procedure TPlanCptbase.Button2Click(Sender: TObject);
begin
self.close;
end;

procedure TPlanCptbase.Edit_PM1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//case key of
//   VK_UP:begin
//           Edit_PM1.OnChange:=nil;
//           key:=VK_CANCEL ;
//           RxQuPlanCPTE.Prior;
//           Edit_PM1.Text:=PlanCptbase.RxQuPlanCPTE.findfield('Compte').AsString;
//           Edit_PM1.OnChange:=Edit_PM1Change;
//         end;
//   VK_DOWN:begin
//           Edit_PM1.OnChange:=nil;
//            key:=VK_CANCEL ;
//            RxQuPlanCPTE.Next;
//           Edit_PM1.Text:=PlanCptbase.RxQuPlanCPTE.findfield('Compte').AsString;
//           Edit_PM1.OnChange:=Edit_PM1Change;
//           end;
//end;

end;

procedure TPlanCptbase.Edit_PM1Change(Sender: TObject);
begin
RxQuPlanCPTE.Locate('Compte',Edit_PM1.Text,[loPartialKey]);
end;

procedure TPlanCptbase.Edit_PM2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//case key of
//   VK_UP:begin
//           Edit_PM1.OnChange:=nil;
//           key:=VK_CANCEL ;
//           RxQuPlanCPTE.Prior;
//           Edit_PM1.Text:=PlanCptbase.RxQuPlanCPTE.findfield('Compte').AsString;
//           Edit_PM1.OnChange:=Edit_PM1Change;
//         end;
//   VK_DOWN:begin
//           Edit_PM1.OnChange:=nil;
//            key:=VK_CANCEL ;
//            RxQuPlanCPTE.Next;
//           Edit_PM1.Text:=PlanCptbase.RxQuPlanCPTE.findfield('Compte').AsString;
//           Edit_PM1.OnChange:=Edit_PM1Change;
//           end;
//end;

end;

procedure TPlanCptbase.Enregister1Click(Sender: TObject);
begin
Button1Click(Button1);
end;

procedure TPlanCptbase.FormActivate(Sender: TObject);
begin
//Screen.OnActiveControlChange:=AideEnLigne;
Initialiser_ShortCut_Main(true);
Patitre.visible:=Main.AfficheTitre;
DBGridPlanOrg.ParamColor:=true;
DBGridPlanOrg.Param:=ParamUtil.CouleurDBGrid;
DBGridPlanOrg.UpDateColor;
end;

procedure TPlanCptbase.PaGrilleResize(Sender: TObject);
begin
 DBGridPlanOrg.ColWidths[1]:=((DBGridPlanOrg.Width) div 6);
 DBGridPlanOrg.ColWidths[2]:=((DBGridPlanOrg.Width) div 6)*4;
 WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TPlanCptbase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
WinSuivPrec(Handle,key,[DBGridPlanOrg,DBGridPlanOrg.InplaceEditor]);
if Key = VK_ESCAPE then
   begin
    if activeControl = DBGridPlanOrg then
    Begin
      Key:= 0;
      Self.Close;
    End;
    if activeControl <> DBGridPlanOrg then DBGridPlanOrg.SetFocus;
   end;
if Key = vk_return then
   begin
    if AffichePlanDefaut then
       Button1.Click;
   end;
end;

procedure TPlanCptbase.Button3Enter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TPlanCptbase.Button3Exit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TPlanCptbase.PatitreResize(Sender: TObject);
begin
FormateTailleBoutton([RxSBPlanAgri,RxSBPlanGene],Patitre,((Patitre.Width-48) div 2),-23);
//RxSBPlanGene.Caption:='G�n�ral';
end;

procedure TPlanCptbase.RxSBPlanAgriMouseEnter(Sender: TObject);
begin
RxSBPlanAgri.Font.Color:=clRed;
RxSBPlanAgri.Font.Style:=[fsBold];
end;

procedure TPlanCptbase.RxSBPlanAgriMouseLeave(Sender: TObject);
begin
RxSBPlanAgri.Font.Color:=clWindowText;
RxSBPlanAgri.Font.Style:=[fsBold];
end;

procedure TPlanCptbase.RxSBPlanGeneMouseEnter(Sender: TObject);
begin
RxSBPlanGene.Font.Color:=clRed;
RxSBPlanGene.Font.Style:=[fsBold];
end;

procedure TPlanCptbase.RxSBPlanGeneMouseLeave(Sender: TObject);
begin
RxSBPlanGene.Font.Color:=clWindowText;
RxSBPlanGene.Font.Style:=[fsBold];
end;

procedure TPlanCptbase.RxSBPlanAgriClick(Sender: TObject);
begin
if RxSBPlanAgri.Down then
   Begin
    RxQuPlanCPTE.DisableControls;
    RxQuPlanCPTE.Close;
    RxQuPlanCPTE.ParamByName('Regime').AsString:='A';
    RxQuPlanCPTE.Open;
    RxQuPlanCPTE.EnableControls;
   End;


end;

procedure TPlanCptbase.RxSBPlanGeneClick(Sender: TObject);
begin
if RxSBPlanGene.Down then
   Begin
    RxQuPlanCPTE.DisableControls;
    RxQuPlanCPTE.Close;
    RxQuPlanCPTE.ParamByName('Regime').AsString:='I';
    RxQuPlanCPTE.Open;
    RxQuPlanCPTE.EnableControls;
   End;
end;

procedure TPlanCptbase.DBGridPlanOrgKeyPress(Sender: TObject;
  var Key: Char);
begin
case DBGridPlanOrg.SelectedIndex of
   0:Begin
      Edit_PM1.SelStart:=length(Edit_PM1.Text)+1;
      Edit_PM1.Perform(WM_CHAR,ord(Key),0);
      DBEdCompte.Hide;
     End;
   1:Begin
      Edit_PM2.SelStart:=length(Edit_PM2.Text)+1;
      Edit_PM2.Perform(WM_CHAR,ord(Key),0);
      DBEdLibelle.Hide;
     End;

end;

end;

procedure TPlanCptbase.RxQuPlanCPTEAfterScroll(DataSet: TDataSet);
begin
//Edit_PM1.text:='';
DBEdCompte.show;
DBEdLibelle.Show;
end;

procedure TPlanCptbase.DBEdCompteEnter(Sender: TObject);
begin
Edit_PM1.SetFocus;
DBEdCompte.Hide;
end;

procedure TPlanCptbase.DBEdLibelleEnter(Sender: TObject);
begin
Edit_PM2.SetFocus;
DBEdLibelle.Hide;
end;

procedure TPlanCptbase.Edit_PM2Exit(Sender: TObject);
begin
DBEdLibelle.Show;
end;

procedure TPlanCptbase.Edit_PM2Enter(Sender: TObject);
begin
DBEdLibelle.Hide;
end;

procedure TPlanCptbase.DBGridPlanOrgColExit(Sender: TObject);
begin
case DBGridPlanOrg.SelectedIndex of
   0:if not DBEdCompte.Visible then DBEdCompte.Show;
   1:if not DBEdLibelle.Visible then DBEdLibelle.Show;
end;

end;

procedure TPlanCptbase.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([Button3,Button2,Button1],PaBtn,90,0);
end;

procedure TPlanCptbase.Visualisation1Click(Sender: TObject);
begin
DetailEcritureCompte(RxQuPlanCPTE.FindField('Compte').AsString,true,False);
end;

procedure TPlanCptbase.RxSBInfoVersionClick(Sender: TObject);
begin
Showmessage(PlanCptbaseRxSBInfoVersionWarning+numVersion.messageVersion);
end;

procedure TPlanCptbase.DaPlanCPTEDataChange(Sender: TObject;
  Field: TField);
begin
Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DaPlanCPTE.DataSet);
end;

end.
