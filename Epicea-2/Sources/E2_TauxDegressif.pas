unit E2_TauxDegressif;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, RXCtrls, ExtCtrls, Mask, ToolEdit, CurrEdit;

type
  TTauxDegressif = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaTrame: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    BtnAnnuler: TBitBtn;
    btnEnregister: TBitBtn;
    EditTauxLineaire: TCurrencyEdit;
    EditTauxDegressif: TCurrencyEdit;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  TauxDegressif: TTauxDegressif;

implementation

{$R *.DFM}

end.
