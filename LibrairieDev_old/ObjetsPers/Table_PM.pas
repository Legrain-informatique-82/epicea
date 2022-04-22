unit Table_PM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,MesTable;
const
Tm_InsertStocks = wm_User + 200;
type
  TMoment = (Aucun,Ouverture,Cloture,Reprise);
//  TInsertStocks = Procedure(Sender :TObject; Var Valide :Boolean) of object;
  TTable_PM = class(TMesTable)
  private
    { Déclarations privées }
 //       FMesMessage:TMesMessage;

//    FInsertStocks:TInsertStocks;
//    Procedure DoInsertStocks(var M: TMessage); message Tm_InsertStocks;
//      Procedure EnvoiMes(var Msg: TMessage);message Tm_InsertStocks;

  protected
    { Déclarations protégées }
       Procedure DoInsertStocks(var M: TMessage); message Tm_InsertStocks;
//       Function Traitement(Var M:TMessage):TMessage;

//      FOuvert:TDataSetNotifyEvent;
//      FMoment:TMoment;
//      procedure AfterPost(DataSet: TDataSet);
//      procedure AfterOpen(DataSet: TDataSet);
  public
    { Déclarations publiques }
      constructor Create (Aowner: TComponent); override;
      destructor Destroy; override;
      procedure DoBeforeOpen;override;
      Procedure DoBeforeInsert;override;
      Procedure DoAfterPost;override;
//      Procedure AppMessage(var Msg: TMsg; var Handled: Boolean);override;
      //      procedure CreateWnd(Aowner: TComponent); over
  published
    { Déclarations publiées }
//    Property Ouverture : TDataSetNotifyEvent read FOuvert write Fouvert;
//    Property Moment:TMoment Read FMoment write FMoment;
  end;

//procedure Register;

implementation

//uses DMAide;
procedure Register;
begin
  RegisterComponents('PBMA', [TTable_PM]);
end;

constructor TTable_PM.Create(Aowner: TComponent);
var
ms:TMesMessage;
begin
     inherited create(AOwner);
//     OnMessage:=Self.
//     TableName:='Stocks.db';
end;

destructor TTable_PM.Destroy;
begin
     inherited;
end;

//Procedure TTable_PM.EnvoiMes(var Msg: TMessage);
//Var
//	Valide :Boolean;
//begin
//Valide:= True;
//   	TMesTable(Owner).OnMessage(TObject(Owner), Valide);
//end;
procedure TTable_PM.DoBeforeOpen;
begin
inherited DoBeforeOpen;
//beep;
end;

Procedure TTable_PM.DoBeforeInsert;
begin
inherited DoBeforeInsert;
end;

Procedure TTable_PM.DoAfterPost;
var
ms:TMessage;
//OK:Boolean;
begin

//SendAppMessage(Tm_InsertStocks,0,0);
//ms:=Tm_InsertStocks;

DoInsertStocks(ms);
//msg.LParam:=0;
//Dispatch(ms);
//Dispatch(WM_USER);
//SendMessage(0
//Owner.ClassParent.
//  EnvoiMes(Ms);
//AppMessage(ms,ok);
//(TMesTable.Create).AppMessage(msg,OK);
//(TMesTable.Create).AppMessage(msg,OK);
//TDataModuleAide(Owner).AppMessage(msg,OK);
//PostMessage(TControl(Owner).Parent.Parent.ParentWindow,Tm_InsertStocks,0,0);
//TControl(Owner).Perform(Tm_InsertStocks,0,0);
inherited DoAfterPost;
end;

//Procedure TTable_PM.AppMessage(var Msg: TMsg; var Handled: Boolean);
//begin
////AppMessage(msg,Handled);
//
//     inherited AppMessage(Msg,Handled);
////     ShowMessage('Matthias');
////     Handled:=true;
//
//end;

//Function TTable_PM.Traitement(Var M:TMessage);
//begin
//end;

//procedure CreateWnd(Aowner: TComponent);
//begin
//inherited Createwnd;
//Name:='TaStocks_PM'
//end;

{procedure TTable_PM.AfterPost(DataSet: TDataSet);
begin
AfterPost(DataSet);
beep;
end;

procedure TTable_PM.AfterOpen(DataSet: TDataSet);
var
i:integer;
begin
//inherited AfterOpen;
ShowMessage('Recouc');
if active then Fouvert:='Ouvert' else FOuvert:='Ferme';
for i:=1 to 20 do
beep;
end;}
Procedure TTable_PM.DoInsertStocks(var M: TMessage);

begin
showmessage('hello');
inherited;
end;
end.
