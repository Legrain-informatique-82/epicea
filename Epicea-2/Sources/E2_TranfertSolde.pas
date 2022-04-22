unit E2_TranfertSolde;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolEdit, StdCtrls, Buttons, RXCtrls, ExtCtrls, Mask, CurrEdit, Grids,
  DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid,DBCtrls,Gr_Librairie_Obj,
  E2_Librairie_Obj,LibGestionParamXML, DMConstantes,Db;

type
  TTranfertSolde = class(TForm)
    Patitre: TPanel;
    PaGrilleFond: TPanel;
    PaGrilleDroit: TPanel;
    GrDBGridDroite: TGrDBGrid;
    PaGrilleGauche: TPanel;
    GrDBGridGauche: TGrDBGrid;
    PaCentre: TPanel;
    PaTitreGrille: TPanel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    BtnJournal: TButton;
    PaBas: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Panel1: TPanel;
    BtnClasse1: TSpeedButton;
    BtnClasse2: TSpeedButton;
    BtnClasse3: TSpeedButton;
    BtnClasse4: TSpeedButton;
    BtnClasse5: TSpeedButton;
    BtnClasse6: TSpeedButton;
    BtnClasse7: TSpeedButton;
    BtnClasse8: TSpeedButton;
    BtnClasse9: TSpeedButton;
    EdCompte: TEdit;
    Panel2: TPanel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Shape7: TShape;
    Shape2: TShape;
    CurMontantCptGDeb: TCurrencyEdit;
    CurMontantCptGCre: TCurrencyEdit;
    Shape5: TShape;
    Shape1: TShape;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Shape3: TShape;
    Shape4: TShape;
    CurMontantCptDDeb: TCurrencyEdit;
    CurMontantCptDCre: TCurrencyEdit;
    Shape8: TShape;
    Label15: TLabel;
    DateEdit1: TDateEdit;
    Label16: TLabel;
    Edit1: TEdit;
    RxSpeedButton1: TRxSpeedButton;
    DBTextGauche: TDBText;
    DBTextDroite: TDBText;
    procedure CurMontantCptGDebChange(Sender: TObject);
    procedure CurMontantCptGCreChange(Sender: TObject);
    procedure CurMontantCptDDebChange(Sender: TObject);
    procedure CurMontantCptDCreChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure DaPlanCptTrans1DataChange(Sender: TObject;
      Field: TField);
    procedure DaPlanCptTrans2DataChange(Sender: TObject;
      Field: TField);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  TranfertSolde: TTranfertSolde;

implementation

uses E2_Main,DMPlanCpt;

{$R *.DFM}

procedure TTranfertSolde.CurMontantCptGDebChange(Sender: TObject);
begin
if CurMontantCptGDeb.Value <> 0 then
   Begin
     CurMontantCptGCre.Value:=0;
     CurMontantCptDDeb.Value:=0;
     CurMontantCptDCre.Value:=CurMontantCptGDeb.Value;
   End;

end;

procedure TTranfertSolde.CurMontantCptGCreChange(Sender: TObject);
begin
if CurMontantCptGCre.Value <> 0 then
   Begin
     CurMontantCptGDeb.Value:=0;
     CurMontantCptDDeb.Value:=CurMontantCptGCre.Value;
     CurMontantCptDCre.Value:=0;
   End;
end;

procedure TTranfertSolde.CurMontantCptDDebChange(Sender: TObject);
begin
if CurMontantCptDDeb.Value <> 0 then
   Begin
     CurMontantCptGDeb.Value:=0;
     CurMontantCptGCre.Value:=CurMontantCptDDeb.Value;
     CurMontantCptDCre.Value:=0;
   End;
end;

procedure TTranfertSolde.CurMontantCptDCreChange(Sender: TObject);
begin
if CurMontantCptDCre.Value <> 0 then
   Begin
     CurMontantCptGDeb.Value:=CurMontantCptDCre.Value;
     CurMontantCptDDeb.Value:=0;
     CurMontantCptGCre.Value:=0;
   End;
end;

procedure TTranfertSolde.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
Patitre.visible:=Main.AfficheTitre;
DMPlan.DaPlanCptTrans1.OnDataChange:=DaPlanCptTrans1DataChange;
DMPlan.DaPlanCptTrans2.OnDataChange:=DaPlanCptTrans2DataChange;
end;

procedure TTranfertSolde.FormCreate(Sender: TObject);
begin
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
  //DMPlanCpt.DaPlanCptTrans2
end;

procedure TTranfertSolde.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,E.User);
TranfertSolde:=nil;
end;


procedure TTranfertSolde.DaPlanCptTrans1DataChange(Sender: TObject;
  Field: TField);
begin
CurMontantCptGDeb.Value:=GrDBGridGauche.DataSource.DataSet.findfield('Debit_Deb').AsCurrency;
CurMontantCptGCre.Value:=GrDBGridGauche.DataSource.DataSet.findfield('Credit_Deb').AsCurrency;
end;

procedure TTranfertSolde.DaPlanCptTrans2DataChange(Sender: TObject;
  Field: TField);
begin
CurMontantCptDDeb.Value:=GrDBGridDroite.DataSource.DataSet.findfield('Debit_Deb').AsCurrency;
CurMontantCptDCre.Value:=GrDBGridDroite.DataSource.DataSet.findfield('Credit_Deb').AsCurrency;
end;
end.
