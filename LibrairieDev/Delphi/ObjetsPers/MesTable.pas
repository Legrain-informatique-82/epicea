unit MesTable;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

const
Tm_InsertStocks = wm_User + 200;

type
 TMesMessage = Procedure(Sender :TObject) of object;

  TMesTable = class(TTable)
private
//    Handled:Boolean;
    FOnMesMessage:TMesMessage;
       Procedure InsertStocks(var M: TMessage); message Tm_InsertStocks;
protected

public

//      Procedure AppMessage(var Msg: TMsg; var Handled: Boolean);virtual;
      constructor Create (Aowner: TComponent); override;
      destructor Destroy; override;
    property OnMessage: TMesMessage read FOnMesMessage write FOnMesMessage;
published

end;

implementation

//uses  Balance_PM;

constructor TMesTable.Create(Aowner: TComponent);
begin
     inherited create(AOwner);
//     OnMessage:=Self.
//     Application.OnMessage:=AppMessage;
//     Onmessage:=AppMessage( FMesmessage, Handled);
//     TableName:='Stocks.db';
end;

destructor TMesTable.Destroy;
begin
     inherited;
end;

Procedure TMesTable.InsertStocks(var M: TMessage);

begin
//showmessage('hello');
FOnMesMessage(Owner);
//Dispatch(M);
//inherited;
end;

//Procedure TMesTable.AppMessage(var Msg: TMsg; var Handled: Boolean);
//begin
//if Msg.message = Tm_InsertStocks then
////PostMessage(,Tm_InsertStocks,0).
////InsertStocks(Msg);
////AppMessage(msg,Handled);
////     ShowMessage('Matthias');
////     Handled:=true;
////TObject(Owner).
////find
////Dispatch(Msg);
//end;
end.
