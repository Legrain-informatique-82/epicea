unit DMRecherche_Obj;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,
  E2_Librairie_Obj,
  LibSQL;

type
  TDMRech_Obj = class(TDataModule)
    TaTiers_Obj: TTable;
    TaTvaCode_Obj: TTable;
    TaPlanCpt_Obj: TTable;
    Ta_InfosDiverses: TTable;
    TaParamcpt_Obj: TTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  DMRech_Obj: TDMRech_Obj;

implementation

{$R *.dfm}

procedure TDMRech_Obj.DataModuleCreate(Sender: TObject);
begin
OuvreTables('',[]);
end;

procedure TDMRech_Obj.DataModuleDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
DMRech_Obj:=nil;
end;

end.
