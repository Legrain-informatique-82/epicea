unit E2_AssistantClotureDef;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RXCtrls, StdCtrls, ExtCtrls,LibZoneSaisie,Gr_Librairie_Obj,E2_Librairie_Obj
  ,DMConstantes, LibGestionParamXML, jpeg;

type

  TFeux=record
    Couleur:Tcolor;
    Messages:string;
  end;

  TAssistantClotureDef = class(TForm)
    PaTitreCol: TPanel;
    RxSpeedButton1: TRxSpeedButton;
    RxSpeedButton2: TRxSpeedButton;
    RxSpeedButton3: TRxSpeedButton;
    RxSpeedButton4: TRxSpeedButton;
    RxSpeedButton5: TRxSpeedButton;
    RxSpeedButton6: TRxSpeedButton;
    RxSpeedButton7: TRxSpeedButton;
    RxSpeedButton8: TRxSpeedButton;
    PaTaches: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    RxSpeedButton9: TRxSpeedButton;
    RxSpeedButton10: TRxSpeedButton;
    RxSpeedButton11: TRxSpeedButton;
    RxSpeedButton12: TRxSpeedButton;
    RxLabel1: TRxLabel;
    PaInfos: TPanel;
    Shape5: TShape;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    procedure PatitreResize(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    Procedure InitIndicateur(Ouv,RepOuv,Clo,RepClo:TColor);
    Procedure InitProc(P1,P2,P3,P4:TNotifyEvent);
    procedure RxSpeedButton1Click(Sender: TObject);
    procedure RxSpeedButton2Click(Sender: TObject);
    procedure RxSpeedButton3Click(Sender: TObject);
    procedure RxSpeedButton4Click(Sender: TObject);
    procedure RxSpeedButton5Click(Sender: TObject);
    procedure RxSpeedButton6Click(Sender: TObject);
    procedure RxSpeedButton7Click(Sender: TObject);
    procedure RxSpeedButton8Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RxSpeedButton9MouseEnter(Sender: TObject);
    procedure RxSpeedButton9MouseLeave(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure InitFeux;
    procedure FormDeactivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  IndexAide:integer;
  end;

var
  AssistantClotureDef: TAssistantClotureDef;
  Feux1,Feux2,Feux3,Feux4:TFeux;

procedure AssistantClotRafraichit(IndexAide:integer);

implementation

uses E2_Main, DMStocks, DMChargesRepartir, DMChargesCA, DMChargesAPayer,
  DMProvision, DMDepenses;

{$R *.DFM}

procedure AssistantClotRafraichit(IndexAide:integer);
Begin
 if (AssistantClotureDef <> nil) then
 if  AssistantClotureDef.Visible then
    begin
     AssistantClotureDef.IndexAide:=IndexAide;
     AssistantClotureDef.Activate;
    end;
End;

Procedure TAssistantClotureDef.InitIndicateur(Ouv,RepOuv,Clo,RepClo:TColor);
Begin
Shape1.Brush.Color:=Ouv;
Shape2.Brush.Color:=RepOuv;
Shape3.Brush.Color:=Clo;
Shape4.Brush.Color:=RepClo;
if Ouv=clBlack then Shape1.Visible:=False else Shape1.Visible:=true;
if RepOuv=clBlack then Shape2.Visible:=False else Shape2.Visible:=true;
if Clo=clBlack then Shape3.Visible:=False else Shape3.Visible:=true;
if RepClo=clBlack then Shape4.Visible:=False else Shape4.Visible:=true;
End;

Procedure TAssistantClotureDef.InitProc(P1,P2,P3,P4:TNotifyEvent);
begin
RxSpeedButton9.OnClick:=P1;
RxSpeedButton10.OnClick:=P2;
RxSpeedButton11.OnClick:=P3;
RxSpeedButton12.OnClick:=P4;
end;

procedure TAssistantClotureDef.PatitreResize(Sender: TObject);
begin
//BtnClose.left:=Patitre.Width-6-BtnClose.Width;
end;

procedure TAssistantClotureDef.BtnCloseClick(Sender: TObject);
begin
self.close;
end;

procedure TAssistantClotureDef.RxSpeedButton1Click(Sender: TObject);
begin
//InitFeux;
//if not VerifExistStockOuverture(feux1.Messages) then
//  Feux1.Couleur:=$000080FF
//else
//  Feux1.Couleur:=cllime;
//if not VerifRepriseStockOuverture_OK(feux2.Messages) then
//  Feux2.Couleur:=clRed
//else
//  Feux2.Couleur:=cllime;
//if not VerifExistStockCloture(feux3.Messages) then
//  Feux3.Couleur:=$000080FF
//else
//  Feux3.Couleur:=ClLime;
//Feux4.Couleur:=ClBlack;
//InitIndicateur(Feux1.Couleur,Feux2.Couleur,Feux3.Couleur,Feux4.Couleur);
//RxLabel1.Caption:=RxSpeedButton1.Caption;
//InitProc(Main.Stoks1Click,Main.RepriseStoks1Click,Main.StoksdeFin1Click,nil);
//PaInfos.Align:=alBottom;
//IndexAide:=1;
//Shape5.Visible:=true;
//Shape5.top:=(Sender as TRxSpeedButton).top-3;
//Shape5.left:=(Sender as TRxSpeedButton).left-3;
end;

procedure TAssistantClotureDef.RxSpeedButton2Click(Sender: TObject);
begin
//InitFeux;
// if DMChargeRepartir=nil then
// DMChargeRepartir:=TDMChargeRepartir.Create(self);
//
// if not VerifExistChargesARepartir(feux1.Messages,true) then
//  Feux1.Couleur:=$000080FF
//else
//  Feux1.Couleur:=ClLime;
//if not VerifExistChargesARepartirAReprendre(feux2.messages,true)then
//  Feux2.Couleur:=$000080FF
//else
//  Feux2.Couleur:=ClLime;
//Feux3:=Feux1;
//Feux4:=Feux2;
//InitIndicateur(Feux1.Couleur,Feux2.Couleur,Feux3.Couleur,Feux4.Couleur);
//RxLabel1.Caption:='Charges à répartir';
//InitProc(Main.Chargesrpartir1Click,Main.Chargesrpartir2Click,Main.Chargesrpartir2Click,Main.Chargesrpartir2Click);
//PaInfos.Align:=alBottom;
//IndexAide:=2;
//Shape5.Visible:=true;
//Shape5.top:=(Sender as TRxSpeedButton).top-3;
//Shape5.left:=(Sender as TRxSpeedButton).left-3;
end;

procedure TAssistantClotureDef.RxSpeedButton3Click(Sender: TObject);
begin
//InitFeux;
//if not VerifExistChargesCAOuverture(feux1.Messages,true) then
//  Feux1.Couleur:=$000080FF
//else
//  Feux1.Couleur:=ClLime;
//if not VerifExistChargesCAOuvertureAReprendre(feux2.messages,true)then
//  Feux2.Couleur:=ClRed
//else
//  Feux2.Couleur:=ClLime;
//if not VerifExistChargesCACloture(feux3.messages,true)then
//  Feux3.Couleur:=$000080FF
//else
//  Feux3.Couleur:=ClLime;
//Feux4.Couleur:=Clblack;
//InitIndicateur(Feux1.Couleur,Feux2.Couleur,Feux3.Couleur,Feux4.Couleur);
//RxLabel1.Caption:='Charges et produits constatés d''avance';
//InitProc(Main.Chargesetproduitsconstatsdavance1Click,Main.Chargesetproduitsconstatsdavances1Click,Main.Chargesetproduitsconstatsdavance2Click,nil);
//PaInfos.Align:=alBottom;
//IndexAide:=3;
//Shape5.Visible:=true;
//Shape5.top:=(Sender as TRxSpeedButton).top-3;
//Shape5.left:=(Sender as TRxSpeedButton).left-3;
end;

procedure TAssistantClotureDef.RxSpeedButton4Click(Sender: TObject);
begin
//InitFeux;
//if VerifExistChargesAPayerOuverture(feux1.Messages,true) then
//  Feux1.Couleur:=$000080FF
//else
//  Feux1.Couleur:=ClLime;
//if not VerifExistChargesAPayerOuvertureAReprendre(feux2.messages,true)then
//  Feux2.Couleur:=ClRed
//else
//  Feux2.Couleur:=ClLime;
//if not VerifExistChargesAPayerCloture(feux3.messages,true)then
//  Feux3.Couleur:=$000080FF
//else
//  Feux3.Couleur:=ClLime;
//Feux4.Couleur:=Clblack;
//InitIndicateur(Feux1.Couleur,Feux2.Couleur,Feux3.Couleur,Feux4.Couleur);
//RxLabel1.Caption:='Charges à payer et Produits à recevoir';
//InitProc(Main.Chargespayeretproduitsrecevoir1Click,Main.Chargespayeretproduitsrecevoir2Click,Main.Chargespayeretproduitsrecevoir3Click,nil);
//PaInfos.Align:=alBottom;
//IndexAide:=4;
//Shape5.Visible:=true;
//Shape5.top:=(Sender as TRxSpeedButton).top-3;
//Shape5.left:=(Sender as TRxSpeedButton).left-3;
end;

procedure TAssistantClotureDef.RxSpeedButton5Click(Sender: TObject);
begin
//InitFeux;
//if not VerifExistProvisions(feux1.Messages,true) then
//  Feux1.Couleur:=$000080FF
//else
//  Feux1.Couleur:=ClLime;
//if not VerifExistProvisionsAReprendre(feux2.messages,true)then
//  Feux2.Couleur:=$000080FF
//else
//  Feux2.Couleur:=ClLime;
//Feux3:=Feux1;
//Feux4:=Feux2;
//InitIndicateur(Feux1.Couleur,Feux2.Couleur,Feux3.Couleur,Feux4.Couleur);
//RxLabel1.Caption:=RxSpeedButton5.Caption;
//InitProc(Main.Provisions1Click,Main.Provisions2Click,Main.Provisions2Click,Main.Provisions2Click);
//PaInfos.Align:=alTop;
//IndexAide:=5;
//Shape5.Visible:=true;
//Shape5.top:=(Sender as TRxSpeedButton).top-3;
//Shape5.left:=(Sender as TRxSpeedButton).left-3;
end;

procedure TAssistantClotureDef.RxSpeedButton6Click(Sender: TObject);
begin
//InitFeux;
//if not DMDepenseEnt.VerifExistDepensesCloture(feux3.Messages,true) then
//  Feux3.Couleur:=$000080FF
//else
//  Feux3.Couleur:=ClLime;
////Feux4:=;
//InitIndicateur(Feux1.Couleur,Feux2.Couleur,Feux3.Couleur,Feux4.Couleur);
//RxLabel1.Caption:='Dépenses de l''Entreprise.';
//InitProc(nil,nil,Main.Dpensedelentreprise1Click,nil);
//PaInfos.Align:=alTop;
//IndexAide:=6;
//Shape5.Visible:=true;
//Shape5.top:=(Sender as TRxSpeedButton).top-3;
//Shape5.left:=(Sender as TRxSpeedButton).left-3;
end;

procedure TAssistantClotureDef.RxSpeedButton7Click(Sender: TObject);
begin
//InitFeux;
//InitIndicateur(clBlack,clBlack,clBlack,clBlack);
//RxLabel1.Caption:='';
//InitProc(nil,nil,nil,nil);
//PaInfos.Align:=alTop;
//IndexAide:=7;
//Shape5.Visible:=true;
//Shape5.top:=(Sender as TRxSpeedButton).top-3;
//Shape5.left:=(Sender as TRxSpeedButton).left-3;
end;

procedure TAssistantClotureDef.RxSpeedButton8Click(Sender: TObject);
begin
//InitFeux;
//InitIndicateur(clBlack,clBlack,clBlack,clBlack);
//RxLabel1.Caption:='';
//InitProc(nil,nil,nil,nil);
//PaInfos.Align:=alTop;
//IndexAide:=8;
//Shape5.Visible:=true;
//Shape5.top:=(Sender as TRxSpeedButton).top-3;
//Shape5.left:=(Sender as TRxSpeedButton).left-3;
end;

procedure TAssistantClotureDef.FormCreate(Sender: TObject);
begin
 if DMStock=nil then
 DMStock:=TDMStock.Create(self);

 if DMChargeCA=nil then
 DMChargeCA:=TDMChargeCA.Create(self);

 if DMChargeAPayer=nil then
 DMChargeAPayer:=TDMChargeAPayer.Create(self);

 if DMProvisions=nil then
 DMProvisions:=TDMProvisions.Create(self);

 if DMDepenseEnt=nil then
 DMDepenseEnt:=TDMDepenseEnt.Create(self);

   try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
InitFeux;
InitIndicateur(Feux1.Couleur,Feux2.Couleur,Feux3.Couleur,Feux4.Couleur);
InitProc(nil,nil,nil,nil);
IndexAide:=0;

end;

procedure TAssistantClotureDef.RxSpeedButton9MouseEnter(Sender: TObject);
Var
SousIndex,IndexTotal:integer;
begin
SousIndex:=(Sender as tRxSpeedButton).Tag;
IndexTotal:=StrToInt(inttostr(IndexAide)+inttostr(SousIndex));
case IndexTotal of
   11:PaInfos.Caption:=Feux1.Messages;
   12:PaInfos.Caption:=Feux2.Messages;
   13:PaInfos.Caption:=Feux3.Messages;
   14:PaInfos.Caption:=Feux4.Messages;

   21:PaInfos.Caption:=Feux1.Messages ;
   22:PaInfos.Caption:=Feux2.Messages ;
   23:PaInfos.Caption:=Feux3.Messages ;
   24:PaInfos.Caption:=Feux4.Messages ;

   31:PaInfos.Caption:=Feux1.Messages ;
   32:PaInfos.Caption:=Feux2.Messages ;
   33:PaInfos.Caption:=Feux3.Messages ;
   34:PaInfos.Caption:=Feux4.Messages ;

   41:PaInfos.Caption:=Feux1.Messages ;
   42:PaInfos.Caption:=Feux2.Messages ;
   43:PaInfos.Caption:=Feux3.Messages ;
   44:PaInfos.Caption:=Feux4.Messages ;

   51:PaInfos.Caption:=Feux1.Messages ;
   52:PaInfos.Caption:=Feux2.Messages ;
   53:PaInfos.Caption:=Feux3.Messages ;
   54:PaInfos.Caption:=Feux4.Messages ;

   61:PaInfos.Caption:=Feux1.Messages ;
   62:PaInfos.Caption:=Feux2.Messages ;
   63:PaInfos.Caption:=Feux3.Messages ;
   64:PaInfos.Caption:=Feux4.Messages ;

   71:PaInfos.Caption:=Feux1.Messages ;
   72:PaInfos.Caption:=Feux2.Messages ;
   73:PaInfos.Caption:=Feux3.Messages ;
   74:PaInfos.Caption:=Feux4.Messages ;

   81:PaInfos.Caption:=Feux1.Messages ;
   82:PaInfos.Caption:=Feux2.Messages ;
   83:PaInfos.Caption:=Feux3.Messages ;
   84:PaInfos.Caption:=Feux4.Messages ;
end;

PaInfos.Visible:=True;
end;

procedure TAssistantClotureDef.RxSpeedButton9MouseLeave(Sender: TObject);
begin
PaInfos.Visible:=false;
PaInfos.Caption:='';
end;

procedure TAssistantClotureDef.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 If Key = VK_ESCAPE Then
   BtnCloseClick(sender);
end;

procedure TAssistantClotureDef.FormActivate(Sender: TObject);
begin
case IndexAide of
1:RxSpeedButton1Click(RxSpeedButton1);
2:RxSpeedButton2Click(RxSpeedButton2);
3:RxSpeedButton3Click(RxSpeedButton3);
4:RxSpeedButton4Click(RxSpeedButton4);
5:RxSpeedButton5Click(RxSpeedButton5);
6:RxSpeedButton6Click(RxSpeedButton6);
7:RxSpeedButton7Click(RxSpeedButton7);
end;//fin du case
Patitre.visible:=Main.AfficheTitre;
Initialiser_ShortCut_Main(true);
end;


procedure TAssistantClotureDef.InitFeux;
Begin
Feux1.Couleur:=clBlack;
Feux2.Couleur:=clBlack;
Feux3.Couleur:=clBlack;
Feux4.Couleur:=clBlack;
Feux1.Messages:='OK';
Feux2.Messages:='OK';
Feux3.Messages:='OK';
Feux4.Messages:='OK';
End;

procedure TAssistantClotureDef.FormDeactivate(Sender: TObject);
begin
PaInfos.Visible:=false;
end;

procedure TAssistantClotureDef.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,E.User);
AssistantClotureDef:=nil;
end;

end.
