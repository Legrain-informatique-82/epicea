unit FM_INIT_EVENT_AFFICH;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls,
  Dialogs, FM_INIT_COLOR,db;

type
//  TDMStateChangeEvent=procedure(TableName,Mess:String;sender:TObject = nil) of object;
//  TDMStateChangeEvent=procedure(sender:TObject) of object;
  TT_INIT_EVENT_AFFICH = class(TT_INIT_COLOR)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
//    Procedure DMStateChange(Sender: TObject);
  protected
//    FOnDMStateChangeEvent:TDMStateChangeEvent;
//   property OnDMStateChangeEvent:TDMStateChangeEvent read FOnDMStateChangeEvent write FOnDMStateChangeEvent;
  private
    { Déclarations privées }
//    BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer : TButton;
//    Procedure DataSetPiloteDataStateChange(Sender: TObject);
  public
    { Déclarations publiques }
//   DataSourcePilote:TDataSource;
  end;

var
  T_INIT_EVENT_AFFICH: TT_INIT_EVENT_AFFICH;

//    procedure ChangementEtatBouttons(BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer : TButton; DataSet:TDataSet);
//    Function EnableWinControl(ListControl : array of Twincontrol;Actif:Boolean):boolean;
implementation

{$R *.dfm}

//procedure ChangementEtatBouttons(BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer : TButton; DataSet:TDataSet);
//begin
// try
//  case DataSet.state of
//   dsBrowse: begin
//               BtnInserer.Enabled := True;
//               BtnEnregistrer.Enabled := False;
//               BtnModifier.Enabled := Not(DataSet.RecordCount = 0);
//               BtnSupprimer.Enabled := Not(DataSet.RecordCount = 0);
//               BtnImprimer.Enabled:=true;
//             end;
//
//   dsEdit:   begin
//               EnableWinControl([BtnAnnuler,BtnEnregistrer,BtnFermer],True);
//               EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer,BtnImprimer],False);
//             end;
//
//   dsInsert: begin
//               EnableWinControl([BtnAnnuler,BtnFermer],True);
//               EnableWinControl([BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnImprimer],False);
//
////               ComboCompte.Enabled := False;
//             end;
//   end;//fin du case.state
//   //Pop-up Menu
////   Fermer1.Enabled:=BtnFermer.Enabled;
////   Insrer1.Enabled:=BtnInserer.Enabled;
////   Enregister1.Enabled:=BtnEnregistrer.Enabled;
////   Modifier1.Enabled:=BtnModifier.Enabled;
////   Supprimer1.Enabled:=BtnSupprimer.Enabled;
////   Imprimer1.Enabled:=BtnImprimer.Enabled;
// except
//  showmessage('ChangementEtatBouttons : Erreur lors de l''initialisation des bouttons !');
// end;
//end;
//
//Function EnableWinControl(ListControl : array of Twincontrol;Actif:Boolean):boolean;
//var
//i:integer;
//begin
//result:=true;
//for I := 0 to High(ListControl) do
// if ListControl[i] <> nil then ListControl[i].Enabled:=Actif;
//end;
//
//Procedure TT_INIT_EVENT_AFFICH.DataSetPiloteDataStateChange(Sender: TObject);
//Begin
//showmessage('oo');
//if DataSourcePilote.DataSet <> nil then
//ChangementEtatBouttons(BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer,DataSourcePilote.DataSet);
//End;

procedure TT_INIT_EVENT_AFFICH.FormCreate(Sender: TObject);
begin
  inherited;
//  DataSourcePilote:=TDataSource.Create(nil);
//  OnDMStateChangeEvent := DataSetPiloteDataStateChange;
//  DataSourcePilote.OnStateChange := OnDMStateChangeEvent;
//  DataSourcePilote.OnStateChange := DataSetPiloteDataStateChange;
//DataSetPilote:= nil;
end;

procedure TT_INIT_EVENT_AFFICH.FormDestroy(Sender: TObject);
begin
  inherited;
//  DataSourcePilote.Free;
end;

//Procedure TT_INIT_EVENT_AFFICH.DMStateChange(Sender: TObject);
//begin
// Try
//   inherited;
//    showmessage('oo');
//    if (Sender is TDataSet) then
//    ChangementEtatBouttons(BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer,(Sender as TDataSet));
//   if assigned(FOnDMStateChangeEvent) then
//     FOnDMStateChangeEvent(Sender);
// Except
//  abort
// End;// Fin du Try
//End;
end.
