{***************************************************************
 *
 * Unit Name: E2_TransFond
 * Purpose  :
 * Author   :  BP
 * History  :
 *
 ****************************************************************}

unit E2_TransFond;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, gr_Librairie_obj,  Buttons, ExtCtrls,
  Db, DBTables;

type
  TTransFond = class(TForm)
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
    CptDeb: TPanel;
    CptCre: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edMontant: TEdit;
    Image1: TImage;
    Image2: TImage;
    Label5: TLabel;
    btTranfert: TBitBtn;
    btFermer: TBitBtn;
    procedure Calculatrice1Click(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure pmMenu1Click(Sender: TObject);
    procedure AfficheCpt;
    procedure SpeedButton1Click(Sender: TObject);
	 procedure SpeedButton2Click(Sender: TObject);
    procedure AfficheEdMontant;
	 procedure dessineLignes;
    procedure FormPaint(Sender: TObject);
    procedure edMontantChange(Sender: TObject);
    procedure btTranfertClick(Sender: TObject);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  TransFond: TTransFond;
  OKDeb,OKCre : boolean;
  TopCre, TopDeb : Integer;
  CptCrPr,CptDePr : string;
//  OD:TPieceSaisie;
implementation
{$R *.DFM}
Uses E2_Librairie_obj, Gr_Calculatrice, E2_Main, DMBaseDonnee;

procedure TTransFond.Calculatrice1Click(Sender: TObject);
begin
	AfficheCalculatrice(ActiveControl);
end;

procedure TTransFond.Fermer1Click(Sender: TObject);
begin
	Self.Close;
end;

procedure TTransFond.FormCreate(Sender: TObject);
begin
    try
	InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
    end;
   AfficheCpt;
   OKDeb:=false;
   OKCre:=false;
   TopDeb:=0;
   TopCre:=0;
   CptCrPr:='';
   CptDePr:='';
end;

procedure TTransFond.FormDestroy(Sender: TObject);
begin
  	DestroyForm(Self,E.USer);
   TransFond:=nil;
end;

procedure TTransFond.FormKeyPress(Sender: TObject; var Key: Char);
begin
	if Key = #27 then begin
   	Key:= #0;
      Self.Close;
   end;
end;

procedure TTransFond.pmMenu1Click(Sender: TObject);
begin
	PopupMenu1.Popup(Left + 50, Top + 50);
end;

procedure TTransFond.AfficheCpt;
var
i, NbCpt:integer;
Cptd, Cptc : TSpeedButton;
begin

  NbCpt:=5;
  CptDeb.Height:=10+50*NbCpt;
  CptCre.Height:=10+50*NbCpt;
  for i:=0 to NbCpt-1 do begin

  	Cptd:=TSpeedButton.create(self);
   Cptd.Parent:=CptDeb;
   Cptd.AllowAllUp:=True;
	Cptd.Left:=10;
   Cptd.Top:=10+50*i;
   Cptd.Height:=20;
   Cptd.Width:=110;
   Cptd.GroupIndex:=1;
   Cptd.Caption:='Compte ' + IntToStr(i);

   Cptd.OnClick:=SpeedButton1Click;
   cptd.Name:='DCompte_' + IntToStr(i);

  	Cptc:=TSpeedButton.create(self);
   Cptc.Parent:=CptCre;
   Cptc.AllowAllUp:=True;
	Cptc.Left:=40;
   Cptc.Top:=10+50*i;
   Cptc.Height:=20;
   Cptc.Width:=110;
   Cptc.GroupIndex:=2;
   Cptc.Caption:='Compte ' + IntToStr(i);
   Cptc.OnClick:=SpeedButton2Click;
   cptc.Name:='CCompte_' + IntToStr(i);

  	end;
btFermer.top:=CptDeb.top + CptDeb.Height + 20;
btTranfert.top:=CptDeb.top + CptDeb.Height + 20;
end;

procedure TTransFond.SpeedButton1Click(Sender: TObject);
var
Cptenable, CptPre : TComponent;
s:string;
begin
	s:=(Sender as TSpeedButton).name;
   s:=copy(S,2,length(s));
   s:='C'+s;
  Cptenable:=TransFond.FindComponent(s);
  (Cptenable as TSpeedButton).Enabled:=false;
  if CptCrPr <>'' then begin
  	CptPre:=TransFond.findComponent(CptCrPr);
	(CptPre as TSpeedButton).Enabled:=true;
  		end;
  CptCrPr:=s;
  Label3.caption:='Le Compte : '+(Sender as TSpeedButton).Caption+' sera débité de : ';
  Image1.visible:=(Sender as TSpeedButton).Down;
  Image1.top:=(Sender as TSpeedButton).top;
  OKDeb:=true;
  TopDeb:=(Sender as TSpeedButton).top;
  AfficheEdMontant;
end;

procedure TTransFond.SpeedButton2Click(Sender: TObject);
var
Cptenable, CptPre : TComponent;
s:string;
begin
	s:=(Sender as TSpeedButton).name;
   s:=copy(S,2,length(s));
   s:='D'+s;
  Cptenable:=TransFond.FindComponent(s);
  (Cptenable as TSpeedButton).Enabled:=false;
  if CptDePr <>'' then begin
  	CptPre:=TransFond.findComponent(CptDePr);
	(CptPre as TSpeedButton).Enabled:=true;
  		end;
  CptDePr:=s;
  Label4.caption:='au profit du compte : '+(Sender as TSpeedButton).Caption;
  Image2.visible:=(Sender as TSpeedButton).Down;
  Image2.top:=(Sender as TSpeedButton).top;
  OKCre:=true;
  TopCre:=(Sender as TSpeedButton).top;
  AfficheEdMontant;
end;

procedure TTransFond.AfficheEdMontant;
var
rec: TRect;
begin
with TransFond do begin
  if TopDeb < TopCre then
  edMontant.top:=TopDeb + Round(Abs(TopDeb-TopCre)/2)+ CptDeb.top
  	else
   edMontant.top:=TopCre + Round(Abs(TopDeb-TopCre)/2)+ CptDeb.top;
  edMontant.visible:=(OkDeb and OKCre);
  if (OkDeb and OKCre) then begin
               SetRect(rec,CptDeb.left+CptDeb.width,CptDeb.top,
               			CptCre.left+Cptcre.width,CptCre.top+Cptcre.Height);
               InvalidateRect(Transfond.handle,@rec,true);
               updateWindow(Transfond.handle);
               dessineLignes;
  					edMontant.SetFocus;
               end;
  end;
end;

procedure TTransFond.dessineLignes;
begin
with TransFond do begin
   	canvas.Pen.Color:=clRed;
      canvas.Pen.Width:=2;
		canvas.moveto(CptDeb.left+CptDeb.Width,TopDeb+CptDeb.top+5);
      Canvas.lineto(edMontant.left,edMontant.top+12);
      canvas.Moveto(edMontant.left+edMontant.width,edMontant.top+12);
      canvas.LineTo(CptCre.left,TopCre+CptCre.top+4);
	end;

end;
procedure TTransFond.FormPaint(Sender: TObject);
begin
if edMontant.Visible then dessineLignes;
end;

procedure TTransFond.edMontantChange(Sender: TObject);
begin
Label5.caption:=edMontant.text;
end;

procedure TTransFond.btTranfertClick(Sender: TObject);
var
i:integer;
ID :LongInt;
DateOd:TDateTime;
begin
//TaPiece.Close;
//TaPiece.Open;
//OD:=TPieceSaisie.Create(Self);
//OD.Database:=DMBD.dbNameExo;
//od.PieceNouvelle;
//i:=OD.PieceID;
//DateOd:=now;
////od.PieceJournal
////Id:=od.NouvelleReference(3,false);
//od.PieceModifier(i,'Journal',3);
//od.PieceModifier(i,'Date',DateOd);
//od.PieceModifier(i,'Compte',5120);
//od.PieceModifier(i,'Libelle','aaaaaaaaaaa');
//
//od.EcritureInsererer(i, 'H', 1);
//od.EcritureModifier(i,'H',1,'Date',DateOd);
//od.EcritureModifier(i,'H',1,'Compte',5120);
//od.EcritureModifier(i,'H',1,'Libelle','aaaaaaaaa');
//od.EcritureModifier(i,'H',1,'DebitSaisie',4001);
//od.EcritureModifier(i,'H',1,'Id_Devise',1);
//od.EcritureModifier(i,'H',1,'Debit',4001);
//
//od.EcritureInsererer(i, 'H', 2);
//od.EcritureModifier(i,'H',2,'Date',DateOd);
//od.EcritureModifier(i,'H',2,'Compte',5120);
//od.EcritureModifier(i,'H',2,'Libelle','aaaaaaaaa');
//od.EcritureModifier(i,'H',2,'CreditSaisie',4001);
//od.EcritureModifier(i,'H',2,'Id_Devise',1);
//od.EcritureModifier(i,'H',2,'Credit',4001);
////od.EcritureModifier(
//od.PieceEnregistrer(od.NewReference,true);
//OD.Free;
end;

end.
