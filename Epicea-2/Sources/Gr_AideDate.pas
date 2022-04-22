{***************************************************************
 *
 * Unit Name: Gr_AideDate
 * Purpose  :
 * Author   :  JS
 * History  :
 *
 ****************************************************************}

// Gestion de l'aide date (calendrier)
// A commenter plus tard
unit Gr_AideDate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, Buttons, StdCtrls, Menus, Grids,E2_Librairie_Obj;

type
  TAideDate = class(TForm)
    paFond: TPanel;
    pbDate: TPaintBox;
    paHaut: TPanel;
    laMois: TLabel;
    laAnnee: TLabel;
    spMoins: TSpeedButton;
    spPlus: TSpeedButton;
    paBas: TPanel;
    pmMois: TPopupMenu;
    lbDate: TListBox;
    procedure pbDatePaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pbDateMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure spPlusClick(Sender: TObject);
    procedure spMoinsClick(Sender: TObject);
    procedure laMoisMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MoisClick(Sender: TObject);
    procedure lbDateClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbDateMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
  private
    { Déclarations privées }
    FLargCol, FHautLig, FPremJourMois, FDernJourMois :Integer;
    FJJ, FMM, FAA :Word;
    FGrille :Array[1..42] of Integer;
    FSelect :Word;

	Procedure SetDate(NewValue :TDateTime);
   Function GetDate :TDateTime;
   Function GetDateString :String;

	Procedure SetSelect(NewValue :Word);
	Procedure SetMois(NewValue :Word);
   Function GetNomMois(Index :Integer) :String;

	Procedure RempliGrille;
  	Property Select :Word Read FSelect Write SetSelect;
  	Property Mois :Word Read FMM Write SetMois;
  public
    { Déclarations publiques }
    NomJours :Array[1..7] of String[5];
  	Property NomMois[Index :Integer] :String Read GetNomMois;
  	Property Date :TDateTime Read GetDate Write SetDate;
  	Property DateString :String Read GetDateString;
  end;

var
  AideDate: TAideDate;
	Function AideDateAffiche(Control :TWinControl;DateDefaut :TDateTime) :Boolean;
	Function AideDateDerniere :TDateTime;
	Function AideDateValide(Date,DateDefaut :TDateTime; Control :TWinControl) :Boolean;

implementation
Uses Gr_Librairie_obj;
{$R *.DFM}

//******************************************************************************
Function AideDateAffiche(Control :TWinControl;DateDefaut :TDateTime) :Boolean;
Var   i :LongInt;
		ControlParent :TWinControl;
Begin
	if (AideDate = Nil) then
   	AideDate:= TAideDate.Create(Application.MainForm);

	with AideDate do begin
   	try
	      if (Control is TCustomEdit) then Begin
         	{Initialisation si CustomEdit}
		      Top:= Control.Top + Control.Height;
      		Left:= Control.Left;
             if ((trim(TCustomEdit(Control).Text)='/  /')or(empty(TCustomEdit(Control).Text))) then
               Date:= datedefaut
             else
               Date:= StrToDate(TCustomEdit(Control).Text);
         End
	      Else if (Control is TStringGrid) then Begin
            {Initialisation de la date si StringGrid}
  		      Top:= Control.Top;
            for i:= TStringGrid(Control).TopRow to TStringGrid(Control).Row do
            	Top:= Top + TStringGrid(Control).RowHeights[i];

      		Left:= Control.Left;
            for i:= TStringGrid(Control).LeftCol to TStringGrid(Control).Col -1 do
            	Top:= Top + TStringGrid(Control).ColWidths[i];

	        	Date:= StrToDate(TStringGrid(Control).Cells[TStringGrid(Control).Col,
            	TStringGrid(Control).Row]);
         End;
      except
      	Date:= 0;
      end;

		if (Date = 0) then Begin
      	{Si Vide Date = Dernier Date}
      	Date:= StrToDate(GetStringElement(lbDate.Items[0], 2, ':'));
         lbDate.ItemIndex:= 0;
      End;

      if (Control <> Nil) then Begin
      	{Recherche de la Position Left et Top}
			ControlParent:= Control.Parent;
         While ControlParent <> Nil Do Begin
         	if (ControlParent is TForm) then Begin
            	if (TForm(ControlParent).BorderStyle <> bsNone) then
               Begin
               	Top:= Top + 27;
                  Left:= Left + 3;
               End;
            End;
				Top:= Top + ControlParent.Top;
         	Left:= Left + ControlParent.Left;
				ControlParent:= ControlParent.Parent;
         End;
      End;

		Result:= (ShowModal = mrOk);
      if (Result) then Begin
      	{Selection Ok, Maj e la valeur du control}
         if (Control is TCustomEdit) then
            TCustomEdit(Control).text:= DateString
         Else if (Control is TStringGrid) then
            with TStringGrid(Control) do Cells[Col, Row]:= DateString;


        	lbDate.Items[0]:= 'Dernière date : ' + DateString;
      End;
   end;
End;

//******************************************************************************
Function AideDateDerniere :TDateTime;
Begin
	if (AideDate = Nil) then
   	AideDate:= TAideDate.Create(Application.MainForm);

	try
		Result:= StrToDate(GetStringElement(AideDate.lbDate.Items[0], 2, ':'));
   Except
   	Result:= SysUtils.Date;
   End;
End;

//******************************************************************************
Function AideDateValide(Date,DateDefaut :TDateTime; Control :TWinControl) :Boolean;
Begin
	if (AideDate = Nil) then
   	AideDate:= TAideDate.Create(Application.MainForm);

	Result:= Date > 0;

   If Not Result And (Control <> Nil) then
		Result:= AideDateAffiche(Control,DateDefaut);
End;

//******************************************************************************
Function TAideDate.GetNomMois(Index :Integer) :String;
Begin
	if (Index >= 1) And (Index <= 12) then
		Result:= pmMois.Items[Index -1].Caption;
End;

//******************************************************************************
procedure TAideDate.FormCreate(Sender: TObject);
Var
	i :Integer;
   p :Array[0..15] of char;
   Item: TMenuItem;
begin
	for i:= LOCALE_SABBREVDAYNAME1 to LOCALE_SABBREVDAYNAME7 do Begin
      GetLocaleInfo(LOCALE_USER_DEFAULT, i, p, 10);

      NomJours[i - LOCALE_SABBREVDAYNAME1 +1]:= StrPas(p);
   End;

	for i:= LOCALE_SMONTHNAME1 to LOCALE_SMONTHNAME12 do Begin
      GetLocaleInfo(LOCALE_USER_DEFAULT, i, p, 14);

      Item:= TMenuItem.Create(Self);
      Item.Caption:= StrPas(p);
      Item.OnClick:= MoisClick;
   	pmMois.Items.Add(Item);
   End;

	with pbDate.Canvas do Begin
      Font.Size:= 8;

     	FHautLig:= TextHeight(NomJours[1]) + 4;
      FLargCol:= TextWidth(NomJours[6]) + 4;
	End;

   Date:= SysUtils.Date;

	lbDate.Items.Add('Dernière date : ' + DateToStr(SysUtils.Date));
	lbDate.Items.Add('Aujourd''hui : ' + DateToStr(SysUtils.Date));

	lbDate.Items.Add('Date debut exercice : ' + DateToStr(E.DatExoDebut));
	lbDate.Items.Add('Date fin exercice : '+DateToStr(E.DatExoFin));

	Self.Width:= FLargCol * 7 + 10;
	Self.Height:= (FHautLig * 7) + PaHaut.Height + PaBas.Height + 10;
end;

//******************************************************************************
procedure TAideDate.RempliGrille;
Var l :Integer;
	MaxJourMoisAvant :Integer;
Begin
	FPremJourMois:= DayOfWeek(EnCodeDate(Faa, Fmm, 1)) -1;
   if (FPremJourMois =0) then FPremJourMois:= 7;
   if (FPremJourMois =1) then FPremJourMois:= 8;
   FDernJourMois:= GetMaxJourMois(Fmm, Faa);

   if (Fmm = 1) then MaxJourMoisAvant:= GetMaxJourMois(12, Faa -1)
   Else MaxJourMoisAvant:= GetMaxJourMois(Fmm -1, Faa);

	for l := 1 to 42 do
  	if (l < FPremJourMois) then
     	FGrille[l]:= MaxJourMoisAvant - FPremJourMois + l +1
   Else Begin
     	FGrille[l]:= l - FPremJourMois + 1;
      if (FGrille[l] > FDernJourMois) then
       	FGrille[l]:= FGrille[l] - FDernJourMois;
   End;

   FSelect:= FPremJourMois + Fjj -1;
   laMois.Caption:= NomMois[FMM];
   laAnnee.Caption:= IntToStr(FAA);
End;

//******************************************************************************
procedure TAideDate.pbDatePaint(Sender: TObject);
Var
	Rect :TRect;
   Col, Lig :Integer;
   PosG, PosX :Integer;
   Chaine :String;
begin
	with pbDate.Canvas do Begin
		Brush.Color:= clWindow;
      Rect.Left:= 0; Rect.Top:= 0;
      Rect.Right:= pbDate.Width; Rect.Bottom:= pbDate.Height;
      FillRect(Rect);

      for Col:= 1 to 7 do Begin
	      Rect.Top:= 0;
   	   Rect.Bottom:= FHautLig;

         Brush.Color:= clWindow;
	      Pen.Color:= clWindowText;
   	   Font.Color:= clWindowText;

         Rect.Left:= FLargCol * (Col - 1);
	      Rect.Right:= Rect.Left + FLargCol;
			TextRect(Rect, Rect.Left + 2, 2, NomJours[Col]);

         For Lig:= 1 to 6 do Begin
            Rect.Top:= FHautLig * Lig;
            Rect.Bottom:= Rect.Top + FHautLig;
            PosG:= ((Lig-1) * 7) + Col;
            Chaine:= IntToStr(FGrille[PosG]);
            PosX:= (FLargCol - TextWidth(Chaine)) Div 2;

            if (PosG = FSelect) then Begin
               Brush.Color:= clHighlight;
               Pen.Color:= clHighlight;
               Ellipse(Rect.left, Rect.Top, Rect.Right, Rect.Bottom);
               Font.Color:= clWhite;
               TextOut(Rect.Left + PosX, Rect.Top + 2, Chaine);
            End
            Else Begin
               Brush.Color:= clWindow;
               Pen.Color:= clWindowText;
               if (PosG < FPremJourMois)
                  or (PosG >= (FDernJourMois + FPremJourMois)) then
                     Font.Color:= clGrayText
               Else Font.Color:= clWindowText;
               TextRect(Rect, Rect.Left + PosX, Rect.Top + 2, Chaine);
            End;
      	End;
   	End;
   End;
end;

//******************************************************************************
procedure TAideDate.pbDateMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
	Lig, Col :Integer;
begin
	if (Button = mbLeft) then Begin
		Col:= (x Div FLargCol) +1;
      Lig:= (y Div FHautLig) -1;

      if (Lig >= 0)then Begin
      	Select:= (Lig * 7) + Col;
         ModalResult:= MrOk;
      End;
   End;
end;

//******************************************************************************
procedure TAideDate.FormKeyPress(Sender: TObject; var Key: Char);
begin
	if (Key = '+') then Begin
		Select:= Select - 1;
   	Key:= #0;
   End
   else if (Key = '-') then Begin
		Select:= Select + 1;
		Key:= #0;
   End
   else if (Key = #27) then ModalResult:= mrCancel
   else if (Key = #13) then ModalResult:= mrOk;
end;

//******************************************************************************
procedure TAideDate.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (Key = vk_Right) then Begin
   	Select:= Select + 1;
      Key:= 0;
   End
   Else if (Key = vk_Left) then Begin
   	Select:= Select -1;
      Key:= 0;
   End
   Else if Key = vk_Next then Begin
      Mois:= Mois +1;
      Key:= 0;
   End
   Else if Key = vk_Prior then Begin
      Mois:= Mois -1;
      Key:= 0;
	End;
end;

//******************************************************************************
procedure TAideDate.spPlusClick(Sender: TObject);
begin
	Mois:= Mois +1;
end;

//******************************************************************************
procedure TAideDate.spMoinsClick(Sender: TObject);
begin
	Mois:= Mois -1;
end;

//******************************************************************************
procedure TAideDate.SetMois(NewValue :Word);
Begin
	if (NewValue <> FMM) then Begin
   	FMM:= NewValue;

      if (Fmm <= 0) then Begin
        	FMM:= 12;
         FAA:= FAA -1;
      End
      Else if (Fmm > 12) then Begin
      	FMM:= 1;
         FAA:= FAA +1;
      End;
		FDernJourMois:= GetMaxJourMois(Fmm, Faa);
      if (FJJ > FDernJourMois) Then FJJ:= FDernJourMois;

		RempliGrille;
		pbDate.Repaint;
      lbDate.ItemIndex:= -1;
   End;
End;

//******************************************************************************
procedure TAideDate.SetSelect(NewValue :Word);
Begin
	if (NewValue <> FSelect) then Begin
   	FJJ:= FGrille[NewValue];
      if (NewValue < FPremJourMois) then Mois:= Mois -1
      Else if (NewValue >= FPremJourMois + FDernJourMois) then Mois:= Mois +1
      Else pbDate.Repaint;

      lbDate.ItemIndex:= -1;
   End;
End;

//******************************************************************************
procedure TAideDate.laMoisMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	if (Button = mbLeft) then
     	pmMois.Popup(Self.Left + laMois.Left + x, Self.Top + laMois.Top + y);
end;

//******************************************************************************
procedure TAideDate.MoisClick(Sender: TObject);
begin
	{}
   Mois:= TMenuItem(Sender).MenuIndex +1;
end;

//******************************************************************************
Procedure TAideDate.SetDate(NewValue :TDateTime);
Begin
	if (NewValue <> Date) then Begin
	   DecodeDate(NewValue, FAA, FMM, FJJ);
		RempliGrille;

      pbDate.Repaint;
   End;
End;

//******************************************************************************
Function TAideDate.GetDate :TDateTime;
Begin
	if (FJJ = 0) then Result:= 0
   Else
	try
     Result:= EnCodeDate(FAA, FMM, FJJ);
   except
		Result:= 0;
   end;
End;

//******************************************************************************
Function TAideDate.GetDateString :String;
Begin
	try
     	Result:= FormatDateTime('dd/mm/yyyy', Date);
   except
		Result:= '';
   end;
End;

//******************************************************************************
procedure TAideDate.lbDateClick(Sender: TObject);
begin
	Date:= StrToDate(GetStringElement(lbDate.Items[lbDate.ItemIndex], 2, ':'));
end;

//******************************************************************************
procedure TAideDate.lbDateMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	if (Button = mbLeft) then Begin
		Date:= StrToDate(GetStringElement(lbDate.Items[lbDate.ItemIndex], 2, ':'));
		ModalResult:= MrOk;
   End;
end;

procedure TAideDate.FormDestroy(Sender: TObject);
begin
AideDate:=nil;
end;

end.
