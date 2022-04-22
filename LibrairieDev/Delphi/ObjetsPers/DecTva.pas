unit DecTva;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,Ecriture_Isa;

type
  PInfoLignePourDecTVA = ^TInfoLignePourDecTVA;
  TDecTva = class(TComponent)
  private
    { Déclarations privées }
  FEcriture:TEcriture_Isa;
  FListePointage:TList;
  FPointage:PInfoLignePourDecTVA;
  FDateDebutPeriodeTva:TDate;
  FDateFinPeriodeTva:TDate;
  protected
    { Déclarations protégées }
  public
    { Déclarations publiques }
    Constructor Create(AOwner :TComponent); override;
    Destructor Destroy;override;
  published
    { Déclarations publiées }
   property Ecriture:TEcriture_Isa read FEcriture write FEcriture;
   property DateDebutPeriodeTva:TDate read FDateDebutPeriodeTva write FDateDebutPeriodeTva;
   property DateFinPeriodeTva:TDate read FDateFinPeriodeTva write FDateFinPeriodeTva;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Epicea', [TDecTva]);
end;

Constructor TDecTva.Create(AOwner :TComponent);
begin
inherited create(AOwner);
end;

Destructor TDecTva.Destroy;
begin
inherited destroy;
end;

end.
