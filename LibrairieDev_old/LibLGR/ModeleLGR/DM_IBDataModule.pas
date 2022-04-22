unit DM_IBDataModule;

interface

uses
  SysUtils, Db,Classes;

type
// A mettre ds une lib lors de la version finale');
TGEstInterfaceEvent=procedure(CCourant:Tfield;sender:TObject = nil) of object;

TDMBeforeDeleteEvent=procedure(TableName,Mess:String;sender:TObject = nil) of object;
TDMBeforePostEvent=procedure(TableName,Mess:String;sender:TObject = nil) of object;
TDMBeforeInsertEvent=procedure(TableName,Mess:String;sender:TObject = nil) of object;
TDMBeforeEditEvent=procedure(TableName,Mess:String;sender:TObject = nil) of object;
TDMBeforeOpenEvent=procedure(TableName,Mess:String;sender:TObject = nil) of object;
TDMBeforeCloseEvent=procedure(TableName,Mess:String;sender:TObject = nil) of object;
TDMBeforeCancelEvent=procedure(TableName,Mess:String;sender:TObject = nil) of object;
TDMBeforeScrollEvent=procedure(TableName,Mess:String;sender:TObject = nil) of object;

TDMStateChangeEvent=procedure(TableName,Mess:String;State:TDataSetState;sender:TObject = nil) of object;

TDMAfterDeleteEvent=procedure(TableName,Mess:String;sender:TObject = nil) of object;
TDMAfterPostEvent=procedure(TableName,Mess:String;sender:TObject = nil) of object;
TDMAfterInsertEvent=procedure(TableName,Mess:String;sender:TObject = nil) of object;
TDMAfterEditEvent=procedure(TableName,Mess:String;sender:TObject = nil) of object;
TDMAfterOpenEvent=procedure(TableName,Mess:String;sender:TObject = nil) of object;
TDMAfterCloseEvent=procedure(TableName,Mess:String;sender:TObject = nil) of object;
TDMAfterCancelEvent=procedure(TableName,Mess:String;sender:TObject = nil) of object;
TDMAfterScrollEvent=procedure(TableName,Mess:String;sender:TObject = nil) of object;

TType_Saisie=integer;

TIBDataModule = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
private
  { Déclarations privées }

protected
    FOnGEstInterfaceEvent:TGEstInterfaceEvent;

    FOnDMBeforeDeleteEvent:TDMBeforeDeleteEvent;
    FOnDMBeforePostEvent:TDMBeforePostEvent;
    FOnDMBeforeInsertEvent:TDMBeforeInsertEvent;
    FOnDMBeforeEditEvent:TDMBeforeEditEvent;
    FOnDMBeforeOpenEvent:TDMBeforeOpenEvent;
    FOnDMBeforeCloseEvent:TDMBeforeCloseEvent;
    FOnDMBeforeCancelEvent:TDMBeforeCancelEvent;
    FOnDMBeforeScrollEvent:TDMBeforeScrollEvent;

    FOnDMStateChangeEvent:TDMStateChangeEvent;

    FOnDMAfterDeleteEvent:TDMAfterDeleteEvent;
    FOnDMAfterPostEvent:TDMAfterPostEvent;
    FOnDMAfterInsertEvent:TDMAfterInsertEvent;
    FOnDMAfterEditEvent:TDMAfterEditEvent;
    FOnDMAfterOpenEvent:TDMAfterOpenEvent;
    FOnDMAfterCloseEvent:TDMAfterCloseEvent;
    FOnDMAfterCancelEvent:TDMAfterCancelEvent;
    FOnDMAfterScrollEvent:TDMAfterScrollEvent;
    FType_Saisie:TType_Saisie;
    FTableReadOnly:Boolean;
public
  { Déclarations publiques }
    property OnGEstInterfaceEvent:TGEstInterfaceEvent read FOnGEstInterfaceEvent write FOnGEstInterfaceEvent;

    property OnDMBeforeDeleteEvent:TDMBeforeDeleteEvent read FOnDMBeforeDeleteEvent write FOnDMBeforeDeleteEvent;
    property OnDMBeforePostEvent:TDMBeforePostEvent read FOnDMBeforePostEvent write FOnDMBeforePostEvent;
    property OnDMBeforeInsertEvent:TDMBeforeInsertEvent read FOnDMBeforeInsertEvent write FOnDMBeforeInsertEvent;
    property OnDMBeforeEditEvent:TDMBeforeEditEvent read FOnDMBeforeEditEvent write FOnDMBeforeEditEvent;
    property OnDMBeforeOpenEvent:TDMBeforeOpenEvent read FOnDMBeforeOpenEvent write FOnDMBeforeOpenEvent;
    property OnDMBeforeCloseEvent:TDMBeforeCloseEvent read FOnDMBeforeCloseEvent write FOnDMBeforeCloseEvent;
    property OnDMBeforeCancelEvent:TDMBeforeCancelEvent read FOnDMBeforeCancelEvent write FOnDMBeforeCancelEvent;
    property OnDMBeforeScrollEvent:TDMBeforeScrollEvent read FOnDMBeforeScrollEvent write FOnDMBeforeScrollEvent;

    property OnDMStateChangeEvent:TDMStateChangeEvent read FOnDMStateChangeEvent write FOnDMStateChangeEvent;

    property OnDMAfterDeleteEvent:TDMAfterDeleteEvent read FOnDMAfterDeleteEvent write FOnDMAfterDeleteEvent;
    property OnDMAfterPostEvent:TDMAfterPostEvent read FOnDMAfterPostEvent write FOnDMAfterPostEvent;
    property OnDMAfterInsertEvent:TDMAfterInsertEvent read FOnDMAfterInsertEvent write FOnDMAfterInsertEvent;
    property OnDMAfterEditEvent:TDMAfterEditEvent read FOnDMAfterEditEvent write FOnDMAfterEditEvent;
    property OnDMAfterOpenEvent:TDMAfterOpenEvent read FOnDMAfterOpenEvent write FOnDMAfterOpenEvent;
    property OnDMAfterCloseEvent:TDMAfterCloseEvent read FOnDMAfterCloseEvent write FOnDMAfterCloseEvent;
    property OnDMAfterCancelEvent:TDMAfterCancelEvent read FOnDMAfterCancelEvent write FOnDMAfterCancelEvent;
    property OnDMAfterScrollEvent:TDMAfterScrollEvent read FOnDMAfterScrollEvent write FOnDMAfterScrollEvent;
    Property Type_Saisie:TType_Saisie read FType_Saisie write FType_Saisie default 0;
    Property TableReadOnly:Boolean Read FTableReadOnly write FTableReadOnly default false;
  end;

var
  IBDataModule: TIBDataModule;

implementation

{$R *.dfm}

procedure TIBDataModule.DataModuleCreate(Sender: TObject);
begin
 Type_Saisie :=0;
end;

end.
