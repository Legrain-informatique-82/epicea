unit FRPasBtnF3F4F7F11;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls;

type
  TFRPasBtn = class(TFrame)
    PaBtn: TPanel;
    BtnEnregistrer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    BtnDetail: TButton;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.dfm}

end.
