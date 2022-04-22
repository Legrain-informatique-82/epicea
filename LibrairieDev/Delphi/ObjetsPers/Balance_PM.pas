unit Balance_PM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,MesTable;

const
Tm_InsertStocks = wm_User + 200;

type
//TMesMessage = Procedure(Sender :TObject; Var Valide :Boolean) of object;

  TBalance_PM = class(TMesTable)
  private
    { Déclarations privées }
//    property OnMessage: TInsertStocks read FInsertStocks write FInsertStocks;
       Procedure InsertStocks(var M: TMessage); message Tm_InsertStocks;
//    FMesMessage:TMesTable;
  protected
    { Déclarations protégées }
  public
    { Déclarations publiques }
      constructor Create (Aowner: TComponent); override;
      destructor Destroy; override;
      Procedure DoBeforeInsert;override;

//      Procedure AppMessage(var Msg: TMesMessage; var Handled: Boolean);override;
//      Procedure MesMessage
//    Procedure InsertStocks(var M: TMsg); message Tm_InsertStocks;
  published
    { Déclarations publiées }
//    Property MesMessage : TMesTable read FMesMessage
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('PBMA', [TBalance_PM]);
end;

constructor TBalance_PM.Create(Aowner: TComponent);
var
ms:TMesMessage;
begin
     inherited create(AOwner);
//     OnMessage:=ms;

//     TableName:='Stocks.db';
end;

destructor TBalance_PM.Destroy;
begin
     inherited;
end;

Procedure TBalance_PM.InsertStocks(var M: TMessage);

begin
showmessage('hello Balance');
//inherited;
end;
Procedure TBalance_PM.DoBeforeInsert;
var
//msg:TMesMessage;
OK:Boolean;
begin
//msg:=Tm_InsertStocks;

//(TMesTable.Create).AppMessage(msg,OK);
inherited DoBeforeInsert;
end;

//Procedure TBalance_PM.InsertStocks(var M: TMsg);
////Procedure TBalance_PM.AppMessage(var Msg: TMesMessage; var Handled: Boolean);
//begin
////AppMessage(msg,Handled);
////     inherited AppMessage(Msg,Handled);
//     ShowMessage('Matthias');
////     Handled:=true;
//
//end;

end.
