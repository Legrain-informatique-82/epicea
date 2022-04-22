{***************************************************************
 *
 * Unit Name: E2_PlusMoinsValues
 * Purpose  :
 * Author   :  Blanchard
 * History  :
 *
 ****************************************************************}

unit E2_PlusMoinsValues;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, DMImmos, Grids, DBGrids, Db, RXCtrls,
  RXDBCtrl, ExRxDBGrid, GrDBGrid,E2_Librairie_Obj, Menus,LibZoneSaisie,
  DMEcriture,E2_Recherche,LibSQL,E2_Decl_Records, GrGrid,DMConstantes, LibGestionParamXML,
  jpeg;

type
  TPlusMoinsValues = class(TForm)
    PaGrille: TPanel;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    GrDBGrid1: TGrDBGrid;
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
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    PaCumul: TPanel;
    Panel1: TPanel;
    GrGrid2: TGrGrid;
    PaBas: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GrilleDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GrilleTitleClick(Column: TColumn);
    procedure BtnFermerClick(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Aide1Click(Sender: TObject);
    procedure PaCumulResize(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
  private
//	 function Calcule_Amo:Currency;
//	 function Amortissable(Compte:string):boolean;
//	 function Compare(Date_A, Date_B:TDateTime):TDateTime ;
//	 procedure Affiche_ligne(Codes, pvCTs, pvLTs:TStringList);
  public
    { Déclarations publiques }
  end;

const
	csWidth = 611;		//Largeur de base de la feuille
   csHeight = 375;   //Hauteur de base de la feuille
var
  PlusMoinsValues: TPlusMoinsValues;

implementation

uses Gr_Librairie_obj,  E2_Main;

{$R *.DFM}

procedure TPlusMoinsValues.FormActivate(Sender: TObject);
var
TotauxPMV:TTotauxGeneric;
begin
Initialiser_ShortCut_Main(true);
GrDBGrid1.ParamColor:=true;
GrDBGrid1.Param:=ParamUtil.CouleurDBGrid;
GrDBGrid1.UpDateColor;
GrDBGrid1.Refresh;

GrGrid2.ParamColor:=true;
GrGrid2.Param:=ParamUtil.CouleurDBGrid;
GrGrid2.DessineContourLigne:=false;
GrGrid2.UpDateColor;
GrGrid2.FixedColor:=ParamUtil.CouleurDBGrid.GrilleColorFond;

DataModuleImmos.InitFiltrePlusOuMoinsValues(DataModuleImmos.tbPMV);

TotauxPMV:=SommeTotauxGeneric(['Valeur_Nette_Calc','Mt_Cession','pvCT','pvLT'],DataModuleImmos.tbPMV);
DataModuleImmos.tbPMV.First;
DataModuleImmos.tbPMV.EnableControls;

GrGrid2.Cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ', TotauxPMV.Total1);
GrGrid2.Cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ', TotauxPMV.Total2);
GrGrid2.Cells[2,0]:=FormatFloat(E.FormatMonnaie + ';; ', TotauxPMV.Total3);
GrGrid2.Cells[3,0]:=FormatFloat(E.FormatMonnaie + ';; ', TotauxPMV.Total4);

end;

procedure TPlusMoinsValues.FormCreate(Sender: TObject);
begin
	Left:= 0; Top:= 0; Width:= csWidth; Height:= csHeight;
    try
	if DataModuleImmos = Nil then DataModuleImmos := TDataModuleImmos.Create(Self);
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
        InitialiseFormPosDefaut(self);
    end;
end;

procedure TPlusMoinsValues.FormDestroy(Sender: TObject);
begin
	LibGestionParamXML.DestroyForm(Self,E.User);
        if DataModuleImmos<>nil then  DataModuleImmos.Free;

        PlusMoinsValues := Nil;
end;


procedure TPlusMoinsValues.GrilleDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
	if DataCol >= 4 then begin
		if (gdSelected in State) then
      	GrDBGrid1.Canvas.Font.Color:= clWhite
      else
      	if (Column.Field as TCurrencyField).Value < 0 then
         	GrDBGrid1.Canvas.Font.Color:= clRed
         else
         	GrDBGrid1.Canvas.Font.Color:= clBlue;
   end;
   with (Sender as TDBGrid) do DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TPlusMoinsValues.GrilleTitleClick(Column: TColumn);
begin
//   with DataModuleImmos.tbPMV do
//      case Column.Index of
//         0:IndexName := 'idxCompte';
//         1:IndexName := 'idxLibelle';
//      end;
end;

procedure TPlusMoinsValues.BtnFermerClick(Sender: TObject);
begin
self.close;
end;

procedure TPlusMoinsValues.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TPlusMoinsValues.PaGrilleResize(Sender: TObject);
begin
FormateTailleColonne(GrDBGrid1,16,[3,3,2,2,2,2]);
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TPlusMoinsValues.Visualisation1Click(Sender: TObject);
begin
 if not empty(DataModuleImmos.tbPMV.findfield('compte').ASString) then
   DetailEcritureCompte(DataModuleImmos.tbPMV.findfield('compte').ASString,true,False)

end;

procedure TPlusMoinsValues.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue (sender as TButton);
end;

procedure TPlusMoinsValues.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit (sender as TButton);
end;

procedure TPlusMoinsValues.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (KEY = VK_ESCAPE) then
   self.close;
end;

procedure TPlusMoinsValues.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
CanClose:=true;
end;

procedure TPlusMoinsValues.Aide1Click(Sender: TObject);
begin
 case GrDBGrid1.SelectedIndex of
         0:Rechercher(GrDBGrid1,DataModuleImmos.tbPMV,['Compte','Libelle','Date_Cession','Cession_Dans_Annee'],['Compte','Libellé','Date Cession',''],'',0);
         1:Rechercher(GrDBGrid1,DataModuleImmos.tbPMV,['Libelle','Compte','Date_Cession','Cession_Dans_Annee'],['Libellé','Compte','Date Cession',''],'',0);
 end;
end;

procedure TPlusMoinsValues.PaCumulResize(Sender: TObject);
begin
Panel1.Width:=RenvoiTailleColonne(GrDBGrid1,[0,1,2])+5;
GrGrid2.ColWidths[0]:=RenvoiTailleColonne(GrDBGrid1,[3]);
GrGrid2.ColWidths[1]:=RenvoiTailleColonne(GrDBGrid1,[4]);
GrGrid2.ColWidths[2]:=RenvoiTailleColonne(GrDBGrid1,[5]);
GrGrid2.ColWidths[3]:=RenvoiTailleColonne(GrDBGrid1,[6]);
end;

procedure TPlusMoinsValues.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(nil);
end;

end.
