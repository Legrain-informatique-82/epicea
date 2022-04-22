unit E2_CumulImmos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, StdCtrls, ExtCtrls, Gr_Librairie_obj,E2_Librairie_Obj;

type
  TCumulImmos = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    DBGrid2: TDBGrid;
    Label1: TLabel;
    Panel3: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    procedure ResizeForm;
  public
    { Déclarations publiques }
  end;

const MaxLignes = 15;
var
  CumulImmos: TCumulImmos;

implementation

uses DMImmos;

{$R *.DFM}

procedure TCumulImmos.FormCreate(Sender: TObject);
begin
//	Left:= 0; Top:= 0; Width:= csWidth; Height:= csHeight;
	InitialiseForm(E.User,Self);
end;

procedure TCumulImmos.FormDestroy(Sender: TObject);
begin
	DestroyForm(Self,E.User);
   CumulImmos := Nil;
end;

procedure TCumulImmos.FormActivate(Sender: TObject);
begin
	if DataModuleImmos = Nil then DataModuleImmos := TDataModuleImmos.Create(Self);
   ResizeForm;
end;

procedure TCumulImmos.ResizeForm;
var Lignes : integer;
begin
   Lignes := DMImmos.DataModuleImmos.qryCumulImmosChoix.RecordCount;
   if Lignes > MaxLignes then Lignes := MaxLignes;
	Self.Height := 39 + (Lignes-1) * 18 + 105;
end;

end.
