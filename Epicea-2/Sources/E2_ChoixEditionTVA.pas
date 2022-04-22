unit E2_ChoixEditionTVA;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RXCtrls, StdCtrls, ExtCtrls,E2_Decl_Records;

type
  TChoixEditionTVA = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    PaCentre: TPanel;
    RxCheckListBox1: TRxCheckListBox;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  ChoixEditionTVA: TChoixEditionTVA;
  Function ChoixEditionTVAAffiche(ParamAfficheChoixEditionTVA : TParamAfficheChoixEditionTVA):Boolean;

implementation

{$R *.DFM}

Function ChoixEditionTVAAffiche(ParamAfficheChoixEditionTVA : TParamAfficheChoixEditionTVA):Boolean;
Begin
if ChoixEditionTVA = nil then ChoixEditionTVA:=TChoixEditionTVA.Create(Application.MainForm);
ChoixEditionTVA.RxCheckListBox1.Items.Assign(TStrings(ParamAfficheChoixEditionTVA.ListeCodeTVA));
ChoixEditionTVA.Show;
End;


end.
