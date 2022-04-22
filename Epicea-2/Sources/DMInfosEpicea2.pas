unit DMInfosEpicea2;

interface

uses
  SysUtils, Classes,
  Forms,
  E2_Decl_Records,
  DMStocks,
  DMEmprunt,
  E2_Librairie_Obj,
  DMRecherche;


type

  TParamDMInfosEpicea=Record
   Stocks:Boolean;
   Emprunts:Boolean;
   GEstInterfaceEvent:TGEstInterfaceEvent;
  end;

  TInfosDMInfosEpicea=Record
    InfosDMStocks:TInfosDMStocks;
    InfosDMEmprunts:TInfosDMEmprunts;
    InfosEntreprise:TEntreprise;
//    Stocks_ResteStocksOuvertureAReprendre:Boolean;
   end;

  TDMInfosEpicea = class(TDataModule)
  private
    { Déclarations privées }
//    InfosDMStocks:TInfosDMStocks;
//    Function Stocks_ResteStocksOuvertureAReprendre:Boolean;
  public
    { Déclarations publiques }
    ResultInfosDMInfosEpicea:TInfosDMInfosEpicea;
  end;


var

  DMInfosEpicea: TDMInfosEpicea;
  Function InitialiseDMInfosEpicea(ParamDMInfosEpicea:TParamDMInfosEpicea):TInfosDMInfosEpicea;

implementation

{$R *.dfm}

Function InitialiseDMInfosEpicea(ParamDMInfosEpicea:TParamDMInfosEpicea):TInfosDMInfosEpicea;
var
ParamDMStocks:TParamDMStocks;
ParamDMEmprunts:TParamDMEmprunts;
Begin
if DMInfosEpicea = nil then DMInfosEpicea:=TDMInfosEpicea.Create(Application.MainForm);
if ParamDMInfosEpicea.Stocks then
 begin
  ParamDMStocks.GEstInterfaceEvent := nil;
  ParamDMStocks.StocksDataStateChange := nil;
  ParamDMStocks.Quand := C_InfoEpicea;
  result.InfosDMStocks := InitialiseDMStocks(ParamDMStocks);

  ParamDMEmprunts.EcheEmpruntDataStateChange := nil;
  ParamDMEmprunts.EmpruntsDataStateChange := nil;
  ParamDMEmprunts.EmpruntsQuCptEmpruntsAfterScroll := nil;
  ParamDMEmprunts.GEstInterfaceEvent := nil;
  ParamDMEmprunts.Quand := C_InfoEpicea;
  ParamDMEmprunts.QuiAppel := F_inconnu;
  Result.InfosDMEmprunts := InitialiseDMEmprunts(ParamDMEmprunts);

  result.InfosEntreprise := E;
 end;
//result.Stocks_ResteStocksOuvertureAReprendre:=DMInfosEpicea.f
//
End;

//Function TDMInfosEpicea.Stocks_NbDeStocksOuverture:Boolean;
//Function TDMInfosEpicea.Stocks_ResteStocksOuvertureAReprendre:Boolean;
//Begin
//result := InfosDMStocks.ResteStocksOuvertureAReprendre;
//End;


end.
