unit MessageLgr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RXCtrls, ExtCtrls, jpeg;

type
TParamAffichageMessageLGR=record
TitreForm:string;
SousTitreForm:string;
Affiche:string;
end;

type
  TMessagesLgr = class(TForm)
    PaMessage: TPanel;
    PaBtn: TPanel;
    BtnOui: TButton;
    BtnAnnuler: TButton;
    PaCorps: TPanel;
    BtnNon: TButton;
    PaTitre: TPanel;
    ImEnTete: TImage;
    RxLabel4: TRxLabel;
    RxLabel3: TRxLabel;
    RxLabel5: TRxLabel;
    RxLabel1: TRxLabel;
    procedure PaBtnResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  MessagesLgr: TMessagesLgr;


  function MessageLGRAffiche(ParamAffichageMessageLGR:TParamAffichageMessageLGR):integer;

implementation

uses LibZoneSaisie;

{$R *.dfm}

function MessageLGRAffiche(ParamAffichageMessageLGR:TParamAffichageMessageLGR):integer;
Begin
 if (MessagesLgr = nil) then MessagesLgr:=TMessagesLgr.Create(Application.MainForm);
// if not empty(ParamAffichageMessageLGR.TitreForm) then
//   MessagesLgr.TitreForm:=ParamAffichageMessageLGR.TitreForm;
// MessagesLgr.SousTitreForm:=ParamAffichageMessageLGR.SousTitreForm;

// if ParamAffichageMessageLGR.Affiche then
//  begin
//     result:=MessagesLgr.ShowModal;
//  end;
end;

procedure TMessagesLgr.PaBtnResize(Sender: TObject);
begin
  FormateTailleBoutton([BtnOui,BtnNon,BtnAnnuler],PaBtn,90,0);
end;

procedure TMessagesLgr.FormCreate(Sender: TObject);
begin
//
end;

procedure TMessagesLgr.FormDestroy(Sender: TObject);
begin
//
end;

end.
