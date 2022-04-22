{***************************************************************
 *
 * Unit Name: E2_DetailImmo
 * Purpose  :
 * Author   : Blanchard
 * History  :
 *
 ****************************************************************}

unit E2_DetailImmo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, {EpiceaControl, }ExtCtrls, Db, DBTables, Gr_Librairie_obj,
  Mask, DBCtrls, Grids, DBGrids, {EditVert, }ComCtrls,E2_Librairie_Obj;

type
  TDetailImmo = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Panel2: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Panel3: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Val_Acq: TDBEdit;
    Date_MeS: TDBEdit;
    Duree_Amt: TDBEdit;
    Deduc_Invest: TDBEdit;
    Amo_Eco: TDBEdit;
    Amo_Derog: TDBEdit;
    VNC: TDBEdit;
    Date_Reelle_Acq: TDBEdit;
    Val_Reelle_Acq: TDBEdit;
    Val_Venale: TDBEdit;
    Date_Acq: TDBEdit;
    Panel4: TPanel;
    DBEdit1: TDBEdit;
    Code: TDBEdit;
    Sous_code: TDBEdit;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    DBRadioGroup1: TDBRadioGroup;
    Compte: TDBRichEdit;
    Label6: TLabel;
    Repr_Deduc_Invest: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CompteEnter(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

const
	csWidth = 465;		//Largeur de base de la feuille
   csHeight = 439;   //Hauteur de base de la feuille
var
  DetailImmo: TDetailImmo;

implementation
uses DMImmos;
{$R *.DFM}

procedure TDetailImmo.FormCreate(Sender: TObject);
begin
	Left:= 0; Top:= 0; Width:= csWidth; Height:= csHeight;
    try
	InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
    end;
//   DMImmos.DataModuleImmos.taDetailImmo.Open;
end;

procedure TDetailImmo.FormDestroy(Sender: TObject);
begin
	DestroyForm(Self,E.USer);
   DetailImmo := Nil;
end;

procedure TDetailImmo.CompteEnter(Sender: TObject);
begin
   Compte.SelStart := 0;
   Compte.SelLength := length(Compte.text);
end;

end.
