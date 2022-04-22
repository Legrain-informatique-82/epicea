unit ZoneDeSaisie;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, CurrEdit,LibZoneSaisie;

type

  TInfosZoneSaisie = record
   CaptionForm:String;
   CaptionLib:String;
   Affich:Boolean;
   ValeurDefaut:Currency;
   DisplayFormat:String;
   FormatOnEditing:Boolean;
   MaxValue:Currency;
   MinValue:Currency;
   BloquerBorne:Boolean;
  end;

  TRetourZoneSaisie = record
   Retour:Boolean;
   MontantSaisieCurr:Currency;
   MontantSaisieStr:String;
  end;

  TZoneSaisie = class(TForm)
    CurrEdit: TCurrencyEdit;
    LibIntitule: TLabel;
    BtnValider: TButton;
    BtnAnnuler: TButton;
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnValiderClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  ZoneSaisie: TZoneSaisie;
  Function AffichZoneSaisie(InfosZoneSaisie:TInfosZoneSaisie):TRetourZoneSaisie;
implementation

{$R *.DFM}

Function AffichZoneSaisie(InfosZoneSaisie:TInfosZoneSaisie):TRetourZoneSaisie;
Begin
ZoneSaisie := nil;
ZoneSaisie:=TZoneSaisie.Create(Application.MainForm);
ZoneSaisie.Caption := InfosZoneSaisie.CaptionForm;
ZoneSaisie.CurrEdit.DisplayFormat := InfosZoneSaisie.DisplayFormat;
ZoneSaisie.CurrEdit.Value := InfosZoneSaisie.ValeurDefaut;
ZoneSaisie.LibIntitule.Caption := InfosZoneSaisie.CaptionLib;
if InfosZoneSaisie.Affich then
 begin
  result.Retour := ZoneSaisie.ShowModal = mrOk;
  if result.Retour then
   begin
//    if ZoneSaisie.CurrEdit.Value
    result.MontantSaisieCurr := ZoneSaisie.CurrEdit.Value;
    result.MontantSaisieStr := CurrToStr(result.MontantSaisieCurr);
   end;
 end;
End;

procedure TZoneSaisie.BtnAnnulerClick(Sender: TObject);
begin
self.Close;
end;

procedure TZoneSaisie.BtnValiderClick(Sender: TObject);
begin
modalResult := mrOk;
end;

end.
