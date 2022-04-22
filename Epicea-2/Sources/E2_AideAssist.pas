{***************************************************************
 *
 * Unit Name: E2_AideAssist
 * Purpose  :
 * Author   :  BP
 * History  :
 *
 ****************************************************************}

unit E2_AideAssist;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, Db, DBTables, ExtCtrls, RxRichEd, DBRichEd,LibSQL,
  Gr_Librairie_Obj,E2_Librairie_Obj,LibGestionParamXML, DiversProjets,
  E2_Decl_Records,
   DMConstantes;

type

  TParamAideEnLigne=Record
    Unite:string;
    control:string;
    Etat:TDatasetstate;
    Affiche:Boolean;
    AffichageModal:Boolean;
    TitreForm:String;
    SousTitreForm:String;
  end;

  TAideAssist = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnModifier: TButton;
    DBMemo1: TDBMemo;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    TitreForm,SousTitreForm:String;
  end;

var
  AideAssist: TAideAssist;


  Function AideEnLigneAffich(ParamAideEnLigne:TParamAideEnLigne):boolean;
implementation

uses DMAide;

{$R *.DFM}

procedure TAideAssist.FormShow(Sender: TObject);
begin
 self.top:=0;
 self.Left:=0;
 self.Width:=screen.Width;
 DMAides.taAssist.Open;
end;

procedure TAideAssist.FormClose(Sender: TObject; var Action: TCloseAction);
begin
DMAides.taAssist.Close;
end;

procedure TAideAssist.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,E.User);
AideAssist:=nil;
end;

procedure TAideAssist.Button1Click(Sender: TObject);
begin
if self.Height<=110
   then
   begin
    self.Height:=450;
    Button1.Caption:='-';
   end
   else
   begin
    self.Height:=110;
    Button1.Caption:='+';
   end;
end;

procedure TAideAssist.Button2Click(Sender: TObject);
begin
if DMAides.taAssist.State in [dsInsert,dsedit] then
   TableGerePost(DMAides.taAssist);
end;

procedure TAideAssist.FormCreate(Sender: TObject);
begin
if DMAides = nil then
 DMAides := TDMAides.Create(Application.MainForm);
if not DMAides.taAssist.Active then DMAides.taAssist.Open;
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;

procedure TAideAssist.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if (Key = VK_ESCAPE) then
  begin
    if DBMemo1.DataSource.DataSet.State in [dsinsert,dsedit] then
      TableGereCancel(DBMemo1.DataSource.DataSet)
    else
      Self.Hide;
 end;
end;

procedure TAideAssist.BtnModifierClick(Sender: TObject);
begin
if e.TypeClient=cl_isa then
  Begin
    TableGereEdit(DBMemo1.DataSource.DataSet);
  end;
end;

procedure TAideAssist.BtnEnregistrerClick(Sender: TObject);
begin
if e.TypeClient=cl_isa then
  Begin
    TableGerePost(DBMemo1.DataSource.DataSet);
  end;
end;

procedure TAideAssist.FormActivate(Sender: TObject);
begin
PaBtn.visible:=e.TypeClient=cl_isa;
end;

procedure TAideAssist.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);

end;

Function AideEnLigneAffich(ParamAideEnLigne:TParamAideEnLigne):boolean;
var
ParamDMAideEnLigne:TParamDMAideEnLigne;
Begin
try
///etatinitial(mise à zéro)
Initialise_ParamDMAideEnLigne(ParamDMAideEnLigne);
////fin etatInitial

 if (AideAssist = nil) then AideAssist:=TAideAssist.Create(Application.MainForm);
 if AideAssist.Visible then AideAssist.close;
 if not empty(ParamAideEnLigne.TitreForm) then
   AideAssist.TitreForm:=ParamAideEnLigne.TitreForm;
 AideAssist.SousTitreForm:=ParamAideEnLigne.SousTitreForm;
 if ParamAideEnLigne.Affiche then
  begin
     //differentes zones de description de l'immo selectionnée
     AideAssist.DBMemo1.DataSource := DMAides.daAssist;

     if ParamAideEnLigne.AffichageModal then
       AideAssist.ShowModal
      else
       AideAssist.Show;
  End;
except
  result:=false;
end;
End;

end.
