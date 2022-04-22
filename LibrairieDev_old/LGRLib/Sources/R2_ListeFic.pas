unit R2_ListeFic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, ValEdit, StdCtrls, ComCtrls;

type
  TListeVLE = class(TForm)
    Pabas: TPanel;
    SGList: TStringGrid;
    Panel1: TPanel;
    HeaderControl1: THeaderControl;
    Button1: TButton;
    Button2: TButton;
    
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  ListeVLE: TListeVLE;

implementation

{$R *.dfm}

end.
