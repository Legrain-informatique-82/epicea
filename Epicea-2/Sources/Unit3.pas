unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, ComCtrls, StdCtrls, ExtCtrls, Mask, DBCtrls;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    DBGrid3: TDBGrid;
    Panel2: TPanel;
    CompteB: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    Edit3: TEdit;
    Edit4: TEdit;
    Panel3: TPanel;
    Edit2: TEdit;
    Button2: TButton;
    Panel4: TPanel;
    DBGrid4: TDBGrid;
    Label2: TLabel;
    Label3: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    DBGrid5: TDBGrid;
    DBGrid6: TDBGrid;
    Panel5: TPanel;
    Label6: TLabel;
    Edit7: TEdit;
    Button3: TButton;
    Panel6: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Edit8: TEdit;
    Edit9: TEdit;
    DBGrid7: TDBGrid;
    DBGrid8: TDBGrid;
    DBGrid9: TDBGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

uses dmComptesA, dmComptesB, dmCdps;

{$R *.DFM}

//******************************************************************************
procedure TForm1.FormShow(Sender: TObject);
begin
     With dmCompteA, dmCompteB, dmCdp do
     begin
          TaCompteA.Open;
          TaCpt_CptA.Open;
          TaCompteB.Open;
          TaCpt_CptB.Open;
          TaCdp.Open;
          TaCptAB_Cdp.Open;
     end;
end;

//******************************************************************************
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     with dmCompteA, dmCompteB, dmCdp do
     begin
          qEcritureCompteA.Close;
          qSumEcritureCompteA.Close;
          TaCompteA.Close;
          TaCpt_CptA.Close;
          TaCompteB.Close;
          TaCpt_CptB.Close;
          TaCdp.Close;
          TaCptAB_Cdp.Close;
     end;
end;

//******************************************************************************
//** Analytique du CompteA                                                    **
//******************************************************************************
procedure TForm1.Button1Click(Sender: TObject);
begin
     with dmCompteA do
     begin
          ListeEcritureCompteA(Edit1.text);
          CalculDebitCreditCompteA(Edit1.Text, -1);
          Edit3.Text := FloatToStr(Credit);
          Edit4.Text := FloatToStr(Debit);
     end;
end;

//******************************************************************************
//** Analytique du Cdp                                                        **
//******************************************************************************
procedure TForm1.Button2Click(Sender: TObject);
begin
     With dmCdp do
     begin
          dmCdp.TraiteCdp(Edit2.text);
          Edit5.Text := FloatToStr(Credit);
          Edit6.text := FloatToStr(Debit);
     end;
end;

//******************************************************************************
//** Analytique du CompteB                                                    **
//******************************************************************************
procedure TForm1.Button3Click(Sender: TObject);
begin
     with dmCompteB do
     begin
          ListeEcritureCompteB(Edit7.text);
          CalculDebitCreditCompteB(Edit7.Text, 1);
          Edit8.Text := FloatToStr(Credit);
          Edit9.Text := FloatToStr(Debit);
     end;
end;

end.
