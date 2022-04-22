unit E2_RelanceTiers;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RxRichEd, ExtCtrls,
  //RpDefine, RpRender, RpRenderRTF,
  //RpRenderCanvas, RpRenderPreview, RpRenderPrinter, RpBase, RpSystem,RpFiler,
  StdConvs,
  DMTier,
  Buttons,
  //RichPrint,
  ComCtrls;

type
  TRelanceTiers = class(TForm)
    ScrollBox1: TScrollBox;
    PaLettre: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    //RichPrinter1: TRichPrinter;
    RxRichEditLettre: TRichEdit;
    Button1: TButton;
    RichEdit1: TRichEdit;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  RelanceTiers: TRelanceTiers;

implementation

uses ConvUtils;

{$R *.DFM}

procedure TRelanceTiers.FormShow(Sender: TObject);
var
tmpmm:double;
begin
 RxRichEditLettre.Lines.LoadFromFile('C:\Projet\RichEdit\Execution\test4.MDL');
// #12 --> pour changer de page inch   duInches
//tmpmm:=Convert(RxRichEditLettre.PageRect.Right,duPoints,duMillimeters);
//self.Caption := floattostr(tmpmm);
//RichPrinter1.PrintRichEditPreview(RxRichEditLettre);
end;

procedure TRelanceTiers.Button1Click(Sender: TObject);
begin
EditionTiers(CT_IMP_TIERS_TOUS,RxRichEditLettre,RichEdit1);
//RichPrinter1.PrintRichEditPreview(RichEdit1);
end;

procedure TRelanceTiers.FormDestroy(Sender: TObject);
begin
RelanceTiers := nil;
end;

end.
