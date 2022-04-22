unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ComCtrls,math, RXGrids, Db, DBTables, MemTable,emprunts,
  ExtCtrls, RXCtrls,dateutil;


type
    TCdClasse = (cdJour, cdMois, cdAnnee);
    TForm2 = class(TForm)
    StringGrid1: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Edit4: TEdit;
    Label7: TLabel;
    RembTotal: TEdit;
    Interets: TEdit;
    Label8: TLabel;
    Panel2: TPanel;
    RxSpeedButton1: TRxSpeedButton;
    DateTimePicker1: TDateTimePicker;
    RxSpeedButton2: TRxSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; Col, Row: Integer;
      var CanSelect: Boolean);
    procedure StringGrid1DrawCell(Sender: TObject; Col, Row: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure RxSpeedButton1Click(Sender: TObject);
    procedure RxSpeedButton2Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form2: TForm2;

implementation

{$R *.DFM}

procedure TForm2.FormShow(Sender: TObject);
var
I,J:integer;
Capitals:extended		;
Moiss :integer	;
DerniereMensualite:extended		;
TauxMensuel:extended	;
Mensualite:extended;
Partie1 :extended		;
Partie2:extended		;
Partie3:extended		;
capitalConstant:extended       ;
begin
 RembTotal.text:='0';
 Interets.text:='0';
if copy(Form1.SDBEdit4.Text,0,3)='Men' then
   begin
   Capitals:= StrToFloat(Form1.sDBEdit7.Text);
   TauxMensuel:=(StrToFloat(Form1.sDBEdit8.Text)/12/100);
   Moiss :=strtoint(Form1.sDBEdit9.Text);
   Partie1:=((Capitals*TauxMensuel));//(tauxs/12);
   Partie2:=((1-(Form1.puiss(1+TauxMensuel,-Moiss))));
   Mensualite:=(round((partie1/partie2*100)/100));
   DerniereMensualite:=(((partie1/partie2)*Moiss)-((partie1/partie2)*(Moiss-1)))-0.07 ;
   Partie3:=(Mensualite+DerniereMensualite*(Moiss-1));
   RembTotal.text:= FloatToStrF( Partie3,ffFixed,18,2)   ;
   Interets.Text:=FloatToStrF(strtofloat(RembTotal.text)-Capitals,ffFixed,18,2);

        with StringGrid1 do
        begin
          for i:=0 to ColCount-1 do begin ColWidths[i]:= 100 end;
          Cells[1,0]:='Mensualité' ;       Cells[2,0]:='Interets' ;
          Cells[3,0]:='Capital' ;          Cells[4,0]:='Capital restant' ;
          Cells[4,1]:=Form1.sDBEdit7.Text; Cells[5,0]:='Capital cumulé' ;
          Cells[2,2]:=FloatToStrF(Capitals*(TauxMensuel),ffFixed,18,2);
          Cells[5,1]:=FloatToStrF(0,ffFixed,18,2 );
          RowCount:=Moiss+2 ;
        end;

     with StringGrid1 do
      for J:=1  to Moiss+2 do
         begin
           Cells[0,J+1]:= datetostr(IncDate(strtodate(Form1.sDBEdit12.text),0,j-1 ,0)); //N° du mois
           Cells[1,J+1]:=FloatToStrF((partie1/partie2),ffFixed,18,2); // Mensualite
           Cells[2,J+1]:=FloatToStrF(strtofloat(Cells[4,j])*(TauxMensuel),ffFixed,18,2 ); // interets
           Cells[3,j+1]:=FloatToStrF((partie1/partie2)-(strtofloat(Cells[2,j+1])),ffFixed,18,2 );//Capital
           Cells[4,j+1]:=FloatToStrF(strtofloat(Cells[4,j])-strtofloat(Cells[3,j+1 ]) ,ffFixed,18,2 ); //Capital restant
           Cells[5,j+1]:=FloatToStrF(strtofloat(Cells[5,j])+strtofloat(Cells[3,j+1]) ,ffFixed,18,2 );
        end;
     end;

if (copy(Form1.SDBEdit4.Text,0,3)='Cap') then
   begin
   Capitals:= StrToFloat(Form1.sDBEdit7.Text);
   TauxMensuel:=(StrToFloat(Form1.sDBEdit8.Text)/12/100);
   Moiss :=strtoint(Form1.sDBEdit9.Text);
   capitalConstant:=Capitals/moiss;
    with StringGrid1 do
         begin
         for i:=0 to ColCount-1 do begin ColWidths[i]:= 100 end;
          Cells[1,0]:='Mensualité' ;          Cells[2,0]:='Interets' ;
          Cells[3,0]:='Capital' ;             Cells[4,0]:='Capital restant' ;
          Cells[4,1]:=Form1.sDBEdit7.Text;    Cells[5,1]:=FloatToStrF(0,ffFixed,18,2 );
          RowCount:=Moiss+2 ;
         end;
 with StringGrid1 do
      for J:=1  to Moiss+2 do
         begin
         Cells[0,J+1]:= datetostr(IncDate(strtodate(Form1.sDBEdit12.text),0,j-1 ,0)); //N° du mois
         Cells[3,J+1]:= floattostrf(capitalConstant,ffFixed,18,2);
         Cells[4,J+1]:= floattostrf((strtofloat(Cells[4,j]))-capitalConstant,ffFixed,18,2);
         Cells[2,J+1]:= floattostrf((strtofloat(Cells[4,j]))*TauxMensuel,ffFixed,18,2);
         Cells[1,J+1]:= floattostrf(strtofloat(Cells[2,j+1])+ strtofloat(Cells[3,j+1]),ffFixed,18,2);
          end;
//with StringGrid1 do
//       for i:=2 to Moiss+1 do
//         begin
//        RembTotal.text:= FloatToStrF(strtofloat(Cells[1,i])+strtofloat(RembTotal.text),ffFixed,18,2)   ;
//        Interets .text:= FloatToStrF(strtofloat(Cells[2,i])+strtofloat(Interets.text),ffFixed,18,2)   ;
//
//        end;
     end;
 end;

 procedure TForm2.StringGrid1SelectCell(Sender: TObject; Col, Row: Integer;
  var CanSelect: Boolean);
begin
Form2.caption:= IntToStr(col)+IntToStr(Row);
end;

procedure TForm2.StringGrid1DrawCell(Sender: TObject; Col, Row: Integer;
  Rect: TRect; State: TGridDrawState);
begin
//(Sender as TStringGrid).Canvas.Font.Color:=clred;
(Sender as TStringGrid).Canvas.DrawFocusRect(rect);
// text TextRect(rect,rect.Left ,Rect.Right,'gdSelected');

end;

procedure TForm2.RxSpeedButton1Click(Sender: TObject);
begin
Form1.Table1.Delete;
Close;
end;

procedure TForm2.RxSpeedButton2Click(Sender: TObject);
var
i:integer;
begin
if Form1.SDBEdit4.Text='Men'  then
begin
for i:=2  to StringGrid1.RowCount-1 do
           begin
           form1.Table2.Append;
           form1.Table2.FindField('CodeEmprunt').text:=Form1.SDBEdit1.Text;
           form1.Table2.FindField('DateEcheance').AsDateTime:=strtodate(StringGrid1.Cells[0,i+1]);
           form1.Table2.FindField('MontantEcheance').AsCurrency:=strtocurr(StringGrid1.Cells[1,i]);
           form1.Table2.FindField('interets').AsCurrency:=strtocurr(StringGrid1.Cells[2,i]);
           form1.Table2.FindField('Capital').AsCurrency:=strtocurr(StringGrid1.Cells[3,i]);
           form1.Table2.FindField('CapitalRestant').AsCurrency:=strtocurr(StringGrid1.Cells[4,i]) ;
           form1.Table2.FindField('CapitalCumule').AsCurrency:=strtocurr(StringGrid1.Cells[5,i]);
           form1.Table2.post;
           end;
close;
end;
if Form1.SDBEdit4.Text='Cap' then
begin
for i:=2  to StringGrid1.RowCount-1 do
           begin
           form1.Table2.Append;
           form1.Table2.FindField('CodeEmprunt').text:=Form1.SDBEdit1.Text;
           form1.Table2.FindField('DateEcheance').AsDateTime:=strtodate(StringGrid1.Cells[0,i]);
           form1.Table2.FindField('MontantEcheance').AsCurrency:=strtocurr(StringGrid1.Cells[1,i]);
           form1.Table2.FindField('interets').AsCurrency:=strtocurr(StringGrid1.Cells[2,i]);
           form1.Table2.FindField('Capital').AsCurrency:=strtocurr(StringGrid1.Cells[3,i]);
           form1.Table2.FindField('CapitalRestant').AsCurrency:=strtocurr(StringGrid1.Cells[4,i]) ;
     form1.Table2.post;
           end;
close;
end;
 end;
end.
