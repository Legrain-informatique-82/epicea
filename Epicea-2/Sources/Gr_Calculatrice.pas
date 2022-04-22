{***************************************************************
 *
 * Unit Name: Gr_Calculatrice
 * Purpose  :
 * Author   :  JS
 * History  :
 *
 ****************************************************************}

// Gere la calculatrice
// Tout est commenté
unit Gr_Calculatrice;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Gr_Librairie_obj,E2_Librairie_Obj,
   Grids,DMConstantes,LibGestionParamXML,GrGrid,DBGrids,DB,RXDBCtrl,LibSQL,DBCtrls;

type
  TCalculatrice = class(TForm)
    paFond: TPanel;
    btOk: TBitBtn;
    btAnnuler: TBitBtn;
    Btn0: TSpeedButton;
    BtnNeg: TSpeedButton;
    BtnPt: TSpeedButton;
    BtnPlus: TSpeedButton;
    BtnFr: TSpeedButton;
    Btn1: TSpeedButton;
    Btn2: TSpeedButton;
    Btn53: TSpeedButton;
    BtnMoi: TSpeedButton;
    BtnEu: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    Btn4: TSpeedButton;
    Btn5: TSpeedButton;
    Btn6: TSpeedButton;
    BtnMult: TSpeedButton;
    BtnHT: TSpeedButton;
    Btn7: TSpeedButton;
    Btn8: TSpeedButton;
    Btn9: TSpeedButton;
    BtnDiv: TSpeedButton;
    BtnTva: TSpeedButton;
    BtnCE: TSpeedButton;
    BtnC: TSpeedButton;
    BtnEgal: TSpeedButton;
    LaChiffre: TPanel;
    grMontant: TStringGrid;
    SpeedButton1: TSpeedButton;
    tiBouton: TTimer;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure grMontantDrawCell(Sender: TObject; Col, Row: Longint;
      Rect: TRect; State: TGridDrawState);
    procedure BtnClick(Sender: TObject);
    procedure grMontantDblClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure tiBoutonTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btAnnulerClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Déclarations private }
    lDecimal :Boolean;
    OldSigne :Char;
    PosLigne :Integer;
	 TypSuivant :String;
    FBtnActif: TSpeedButton;

    procedure MiseAZero;
	Procedure AjouteListe(Valeur :Double; Key :String);
	procedure PressBouton(Key :Char; Bouton :Boolean);
	procedure EffaceChiffre;
   Procedure SetBtnActif(Btn :TSpeedButton);

   Property BtnActif: TSpeedButton read FBtnActif write SetBtnActif;
  public
    { Déclarations public }
    Resultat, ResultatSuivant :Double;
  end;

var
  Calculatrice: TCalculatrice;
  ResultatFinal : currency ;
  Function CalculatriceAffiche(Control:TControl):Currency;

implementation

{$R *.DFM}


Function CalculatriceAffiche(Control:TControl):Currency;
begin
if Calculatrice = nil then Calculatrice := TCalculatrice.Create(application.MainForm);
if Calculatrice.ShowModal=mrok then
  result:= ResultatFinal
else result:=0;                          
if ((CurrToStr(result)<>'0')and( Control<>nil)) then
 case RecupClassTypeComponent(control)of
    GTEdit,GTCurrencyEdit:TCustomEdit(Control).Text:=CurrToStr( result);
    GTStringGrid: with TStringGrid(Control) do Cells[Col, Row]:=CurrToStr( result);
    GTGrid: with TStringGrid(Control) do Cells[Col, Row]:=CurrToStr( result);
    Gtgrgrid:with TGrgrid(Control) do Cells[col, Row]:=CurrToStr( result);
    GTDBGrid,GTGrDBGrid:begin
              if (TCustomdbgrid(control).SelectedField.DataSet.State in [dsedit,dsinsert]) then
                     TCustomdbgrid(control).selectedfield.asstring:=CurrToStr( result);
             end;
     GTDBEdit: if TDBEdit(control).Field.DataSet.State in [dsedit,dsinsert] then
              TDBEdit(control).Field.asstring :=CurrToStr( result);
    GTFieldString:begin
                  if TField(control).DataSet.State in [dsedit,dsinsert] then
                  TField(control).asstring:=CurrToStr( result);
                  end;
    GTInplaceEdit,GTGrInplaceEdit:TCustomEdit(Control).Text:=CurrToStr( result);
    GTRxDBComboEdit:TRxDBComboEdit(Control).Text:=CurrToStr( result);
 end;//fin du case

end;

//******************************************************************************
procedure TCalculatrice.FormCreate(Sender: TObject);
// Initialisation de l'écran et mise à zéro
begin
	PosLigne:= 0;
	MiseAZero;
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;        
end;

//******************************************************************************
procedure TCalculatrice.FormKeyPress(Sender: TObject; var Key: Char);
//Gestion des touches
begin
	if (Key in ['a'..'z']) then Key:= Chr(Ord(Key) - 32);

	PressBouton(Key, True);
   Key:= #0;
   btAnnuler.Caption:='RAZ';
   btOk.Caption:= '=';
end;

//******************************************************************************
Procedure TCalculatrice.AjouteListe(Valeur :Double; Key :String);
// Ajoute dans la liste mémorisant les résultats et opérations
Begin
	if (PosLigne > grMontant.RowCount -1) then
   	grMontant.RowCount:= grMontant.RowCount +1;

	grMontant.Cells[0, PosLigne]:= FormatFloat('#,###.00', Valeur);
	grMontant.Cells[1, PosLigne]:= Key;

	grMontant.Row:= PosLigne;
   PosLigne:= PosLigne +1;
End;

//******************************************************************************
procedure TCalculatrice.MiseAZero;
// Réinitialise les variables (Touches CE)
begin
	lDecimal:= False;
   OldSigne:= #0;
   Resultat:= 0;
   LaChiffre.Caption:= '';
	 grMontant.Row:= 0;
	 grMontant.RowCount:= 1;
   grMontant.Cells[0, 0]:= '';
   grMontant.Cells[1, 0]:= '';
   PosLigne:= 0;
end;

//******************************************************************************
procedure TCalculatrice.EffaceChiffre;
// Efface le dernier chiffre saisi ( Touche C)
begin
	lDecimal:= False;
   LaChiffre.Caption:= '';
end;

//******************************************************************************
procedure TCalculatrice.grMontantDrawCell(Sender: TObject; Col, Row: Longint;
  Rect: TRect; State: TGridDrawState);
// Gère l'affichage dans la liste de mémorisation
Var
	l, p :Integer;
   s :String;
begin
   s:= grMontant.Cells[col, Row];
   If (Col = 1) And (Copy(s, 1, 1) > 'Z') then
   Case s[1] of
   't': s:= 'Tva';
   'c': s:= 'Ttc';
   'h': s:= 'Ht';
   'e': s:= 'Eu';
   'f': s:= 'Fr';
   End;

   l:= grMontant.Canvas.TextWidth(s);
   if (Col = 0) then p:= Rect.right - 2 - l
   Else p:= (Rect.Left + Rect.Right - l) Div 2;

   if Not (gdselected in State) And ((grMontant.Cells[1, Row] = ' ')
      or (grMontant.Cells[1, Row] > 'Z')) then
      grMontant.Canvas.Font.Color:= clRed;
   grMontant.Canvas.TextRect(Rect, p, Rect.Top +2, s);
end;

//******************************************************************************
procedure TCalculatrice.BtnClick(Sender: TObject);
// après un clic sur un bouton de la calculatrice, appelle la fonction de màj
var Key: Char;
begin
	Key:= char(TControl(Sender).tag);
   BtnActif:= TSpeedButton(Sender);

   PressBouton(Key, False)
end;

//******************************************************************************
procedure TCalculatrice.PressBouton(Key :Char; Bouton :Boolean);
// Met à jour la zone de saisie
Var
	Valeur, OldResultat :Double;
   Typ, TypKey :String;
   i :Integer;
begin
	if (Bouton) then Begin
   	For i:= 0 to ComponentCount -1 do
		If (Components[i] is TSpeedButton) And
			(TSpeedButton(Components[i]).Tag = Ord(Key)) then Begin
        	BtnActif:= TSpeedButton(Components[i]);
         Break;
      End;
   End;

   	if (key = 'C') then EffaceChiffre
	Else if (key = 'E') then MiseaZero
	Else if (key = 'L') then Begin
		grMontant.Row:= 0;
		grMontant.RowCount:= 1;
      grMontant.Cells[0, 0]:= '';
      grMontant.Cells[1, 0]:= '';
   	PosLigne:= 0;
   End
   Else if (Key = #8) then Begin
   	if (lDecimal) then
      	if (Copy(LaChiffre.Caption, Length(LaChiffre.Caption)-1, 1) = DecimalSeparator) then
         	lDecimal:= False;
		LaChiffre.Caption:= Copy(LaChiffre.Caption, 1, Length(LaChiffre.Caption)-1);
   End
   Else if (Key in ['0'..'9']) then
   	if (oldSigne = '=') then Begin
      	LaChiffre.Caption:= Key;
         oldSigne:= #0;
      End
      Else LaChiffre.Caption:= LaChiffre.Caption + Key;
   if (Key in ['.', ',']) And Not lDecimal then Begin
		LaChiffre.Caption:= LaChiffre.Caption + DecimalSeparator;
      lDecimal:= True;
   End
   Else if (Key = '-') And (LaChiffre.Caption = '') then LaChiffre.Caption:= '-'
   Else if (Key in ['+', '-', '*', '/', '=', 'F', 'T', 'U', 'H','O']) Then Begin

		Valeur:= StrToFloat1(LaChiffre.Caption);

      Typ:= ' ';
      OldResultat:= Resultat;
      TypKey:= Key;

      if (Key = '=') And (ResultatSuivant <> 0) then Begin
      	Resultat:= ResultatSuivant;
	      Typ:= TypSuivant;
         Valeur:= 0;
      End;

      ResultatSuivant:= 0; TypSuivant:= '';
      If (valeur <> 0) then
      Case OldSigne of
      #0, '=' : Resultat:= Valeur;
      '+': Resultat:= Resultat + Valeur;
      '-': Resultat:= Resultat - Valeur;
      '*': Resultat:= Resultat * Valeur;
      '/': Resultat:= Resultat / Valeur;
      'T': Begin Resultat:= (Resultat * Valeur) / 100; Typ:= 't';
      		ResultatSuivant:= OldResultat + Resultat; TypSuivant:= 'c'; End;
      'H': Begin Resultat:= Resultat / (1 + (Valeur / 100)); Typ:= 'h';
      		ResultatSuivant:= OldResultat - Resultat; TypSuivant:= 't'; End;
      End;

      if (Key = 'F') then Begin
      	Resultat:= Valeur * 6.55957;
         TypKey:= 'Eu';
         Typ:= 'f';
			Key:= '='
      End
      Else if (Key = 'U') then Begin
      	Resultat:= Valeur / 6.55957;
         TypKey:= 'Fr';
         Typ:= 'e';
			Key:= '=';
      End;

      if (Valeur <> 0) Then Begin
			AjouteListe(Valeur, TypKey);
         EffaceChiffre;
      End;

      if (Key = '=') or (OldSigne in ['H', 'T']) then Begin
         LaChiffre.Caption:= FormatFloat('#,###.00', Resultat);
			AjouteListe(Resultat, Typ);
      End;

      if (Key = 'O')then Begin
         //Envoyer resultat
         ResultatFinal := Resultat;
			//AjouteListe(Resultat, Typ);
      End;

     	OldSigne:= Key;
   End;
End;

//******************************************************************************
procedure TCalculatrice.grMontantDblClick(Sender: TObject);
// Recopie le montant double-cliqué dans la liste de droite dans la zone de saisie
begin
	if (grMontant.Cells[0, grMontant.Row] > '') then
   	LaChiffre.Caption:= grMontant.Cells[0, grMontant.Row];
    btAnnuler.Caption := 'RAZ';
    btOk.Caption:= '=';
end;

//******************************************************************************
procedure TCalculatrice.btOkClick(Sender: TObject);
// Clic sur bouton OK
begin
  if btOk.Caption = '=' then
  begin
  	PressBouton('=', True);
    btOk.Caption:= 'OK';
  end
  else
  begin
  	PressBouton('O', True);
    ModalResult:=mrok;
    //btOk.Caption:= '=';
  end;
end;

//******************************************************************************
Procedure TCalculatrice.SetBtnActif(Btn :TSpeedButton);
// Mémorisation du bouton appuyé
Begin
	FBtnActif:= Btn;
   FBtnActif.Down:= True;
End;

//******************************************************************************
procedure TCalculatrice.tiBoutonTimer(Sender: TObject);
// Relève le bouton appuyé
begin
	if (FBtnActif <> Nil) Then FBtnActif.Down:= False;
end;

procedure TCalculatrice.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,E.User);
Calculatrice:=nil;
end;


procedure TCalculatrice.btAnnulerClick(Sender: TObject);
begin
if btAnnuler.Caption='Annuler' then
self.close
else
if btAnnuler.Caption='RAZ' then
begin
  MiseAZero;
  btAnnuler.Caption:='Annuler';
  btOk.SetFocus;
end;
end;

procedure TCalculatrice.FormActivate(Sender: TObject);
begin
btOk.SetFocus;
end;

end.

