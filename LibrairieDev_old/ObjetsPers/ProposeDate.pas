unit ProposeDate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, RXCtrls, ExtCtrls,PickDate;

type
  TResultPropDate = record
       retour:boolean;
       DateValide:TDateTime;
  end;
  TPropDate = class(TForm)
    Patitre: TPanel;
    RxSpeedButton1: TRxSpeedButton;
    RxLaMenu: TRxLabel;
    StringGrid1: TStringGrid;
    PaBtn: TPanel;
    BtnEnregistrer: TButton;
    BtnFermer: TButton;
    BtnClose: TButton;
    procedure FormShow(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    DateSaisie:string;
  end;

var
  PropDate: TPropDate;

function DatePropose(DateProp:string):TResultPropDate;

implementation

{$R *.DFM}


function DatePropose(DateProp:string):TResultPropDate;
Begin
   if(PropDate = Nil) then
    PropDate:= TPropDate.Create(Application.MainForm);
    PropDate.StringGrid1.RowCount:=2;
    PropDate.DateSaisie:=DateProp;
    result.retour := (PropDate.showmodal = mrOK);
    result.DateValide:=StrToDate(PropDate.StringGrid1.Cells[0,PropDate.StringGrid1.row]);
    if result.retour then
         result.DateValide:=strtodate(PropDate.StringGrid1.Cells[0,PropDate.StringGrid1.row]);
beep;
End;


procedure TPropDate.FormShow(Sender: TObject);
var
  Present: TDateTime;
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
  DateAux:string;
begin
  Present:= Now;
  DecodeDate(Present, Year, Month, Day);
  DateAux:=DateSaisie;
case length(DateSaisie) of
  0:Begin
      StringGrid1.Cells[0,1]:=DateToStr(now);
      DateSaisie:=DateToStr(now);
    End;
  1:Begin
      if DateSaisie[1] in ['1'..'3']
         then
          Begin
           insert('0',DateAux,0);
           Day:=StrToInt(DateAux);
           Present:=encodeDate(Year,Month,Day);
           DateAux:=DateToStr(Present);
//           DateSaisie:=DateSaisie+'/'+inttoStr(Month)+'/'+IntToStr(Year);
           StringGrid1.RowCount:=StringGrid1.RowCount+1;
           StringGrid1.Cells[0,StringGrid1.RowCount-1]:=DateAux;
          End;
      StringGrid1.Cells[0,1]:=DateToStr(now);
      DateSaisie:=DateToStr(now);
    End;

  2:Begin

      StringGrid1.Cells[0,1]:=DateToStr(now);
      DateSaisie:=DateToStr(now);
    End;

  3:Begin

      StringGrid1.Cells[0,1]:=DateToStr(now);
      DateSaisie:=DateToStr(now);
    End;

  4:Begin

      StringGrid1.Cells[0,1]:=DateToStr(now);
      DateSaisie:=DateToStr(now);
    End;

  5:Begin

      StringGrid1.Cells[0,1]:=DateToStr(now);
      DateSaisie:=DateToStr(now);
    End;

  6:Begin

      StringGrid1.Cells[0,1]:=DateToStr(now);
      DateSaisie:=DateToStr(now);
    End;

  7:Begin

      StringGrid1.Cells[0,1]:=DateToStr(now);
      DateSaisie:=DateToStr(now);
    End;
  else
   begin
      StringGrid1.Cells[0,1]:=DateToStr(now);
      DateSaisie:=DateToStr(now);
   end;
end;

//if length(DateSaisie) > 0 then
//   Begin
//     StringGrid1.Cells[0,1]:='Bonne Année';
//   End
//   else
//   abort;

end;

procedure TPropDate.BtnFermerClick(Sender: TObject);
begin
DateSaisie:=(StringGrid1.Cells[0,StringGrid1.Row]);
self.close;
end;

procedure TPropDate.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
DateAux:TDateTime;
begin
if key = VK_F1 then
   begin
     DateAux:=StrToDate(StringGrid1.Cells[0,StringGrid1.Row]);
     if PopupDate(DateAux,StringGrid1) then
        begin
          DateSaisie:=DateToStr(DateAux);
          BtnEnregistrer.Click;
        end;
   end;
end;

end.
