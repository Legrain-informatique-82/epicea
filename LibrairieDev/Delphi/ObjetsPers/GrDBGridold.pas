unit GrDBGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, RXDBCtrl, ExRxDBGrid,CurrEdit,StrUtils,db,PickDate,ProposeDate,
  Lib1;

Const
   CDateIll :TDateTime = 401768.00; {= 31/12/2999 }
   CdQuinzaine :Integer = 32;
   CdDizaine :Integer = 33;
   CdDebutMois :Integer = 1;
   CdFinMois :Integer = 31;
Type

TVarColorGrid= Record
    LigneContour:TColor;
    CelActiveContour:TColor;
    CelActiveColorFond:TColor;
    CelActiveColorFont:TColor;
    CelActiveSAisieColorFont:TColor;
    CelActiveSAisieColorFond:TColor;
    CelFixeColorFond:TColor;
    CelFixeColorFont:TColor;
    GrilleColorFond:TColor;
    GrilleColorFont:TColor;
    end;
  TCdClasse = (cdJour, cdMois, cdAnnee);
TMyCustomGrid = class(TCustomGrid)
   private

   protected
         property row;
         property RowCount;
         property col;

   public

   published

   end;


  TGrDBGrid = class(TExRxDBGrid)
  private
    { Déclarations privées }
   FInplaceEditColor:TColor;
   FInplaceEditColorFont:TColor;
   FNumDecimal:integer;
   FDateDef:TDateTime;
   FMesExitInInsert:string;
   FMesExitInEdit:string;
   FParamColor:boolean;
   FParam:TVarColorGrid;
//   procedure DrawColumnCell(const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState); override;

//   procedure CMEXIT(var Message: TCMExit); message CM_EXIT;
  protected
    { Déclarations protégées }
//    FInplaceGrainEdit: TInplaceEdit;
    function CreateEditor: TInplaceEdit; override;
    procedure DrawColumnCell(const Rect: TRect; DataCol: Integer; Column: TColumn;State: TGridDrawState);override;
//    procedure ApplyCellAttribute(Field: TField; Canvas: TCanvas; State: TGridDrawState);override;
  public
    { Déclarations publiques }
//        procedure CMMouseEnter(var Msg: TMessage); message cm_MouseEnter;
//        procedure CMMouseLeave(var Msg: TMessage); message cm_MouseLeave;
      constructor Create (Aowner: TComponent); override;
      destructor Destroy; override;
      procedure loaded;override;
      procedure KeyDown(var Key: Word; Shift: TShiftState);override;
      property MesExitInInsert:string read FMesExitInInsert write FMesExitInInsert ;
      property MesExitInEdit:string read FMesExitInEdit write FMesExitInEdit;
      property InplaceEditColor:TColor read FInplaceEditColor write FInplaceEditColor;
      property InplaceEditColorFont:TColor read FInplaceEditColorFont write FInplaceEditColorFont;
      property ParamColor:boolean read FParamColor write FParamColor default false;
      property Param:TVarColorGrid read FParam write FParam;
      procedure ColEnter;override;
      procedure colexit;override;
      Procedure TitreColor(Enter:boolean);
      Procedure UpDateColor;


//      procedure Exit(Sender: TObject);override;
//      property InplaceGrainEdit: TInplaceEdit read FInplaceGrainEdit;

  published
    { Déclarations publiées }
    property NumDecimal:integer read FNumDecimal write FNumDecimal ;
    property DateDef:TDateTime read FDateDef write FDateDef;
  end;

   TGrInplaceEdit = class(TInplaceEdit)
    private
      FDateDef:TDateTime;
      FMonnaie:string;
      FAffMonnaie:TCurrencyEdit;
      FNumDecimal:integer;
      FValeurCellule:string;
    function DisplayMonnaie(var Montant:string): string;
    function IsValidChar(Key: Char): Boolean;
    function TextToValText(const AValue: string): string;
    function IsValidFloat(const Value: string; var RetValue: Extended): Boolean;
    Function DatePreference(Text :String) :TDateTime;
    Function KeyPressDate(var Key: Char) :boolean;
    Function GetMaxJourMois(Mm, Aa :Word):Word;
    Function StrToInt1(Text :String) :LongInt;
    Function GetStringElement(aString :String; aPos :Integer; cSep :Char) :String;
    Function CalculDate(dDate :TDateTime; Plus :Integer; Classe :TcdClasse;
      jourduMois :LongInt) :TDateTime;
      Function StrToDate2(Const Text :String) :TDateTime;
    protected
      procedure UpdateContents ; override;
      property grid;
    public
      constructor Create (Aowner: TComponent); override;
      destructor Destroy; override;
      property Color;
      property font;
      property FormatMonnaie: string read FMonnaie write FMonnaie;
      property DateDef:TDateTime read FDateDef write FDateDef;
      procedure KeyUp(var Key: Word; Shift: TShiftState); override;
      procedure KeyPress(var Key: char); override;
      procedure KeyDown(var Key: Word; Shift: TShiftState);override;
      property NumDecimal:integer read FNumDecimal write FNumDecimal ;
//      Property DisplayFormat;
      property ValeurCellule:string read FValeurCellule write FValeurCellule;

    end;

procedure Register;

implementation
uses GrGrid;


procedure Register;
begin
  RegisterComponents('PBMA', [TGrDBGrid]);
end;

constructor TGrInplaceEdit.Create(Aowner: TComponent);
begin
     inherited create(AOwner);
//     color:=claqua;
//     FNumDecimal:=grid.NumDecimal;

end;

function TGrInplaceEdit.IsValidFloat(const Value: string; var RetValue: Extended): Boolean;
var
  I: Integer;
  Buffer: array[0..63] of Char;
begin
  Result := False;
  for I := 1 to Length(Value) do
    if not (Value[I] in [DecimalSeparator, '-', '+', '0'..'9', 'e', 'E']) then
      Exit;
  Result := TextToFloat(StrPLCopy(Buffer, Value,
    SizeOf(Buffer) - 1), RetValue {$IFDEF WIN32}, fvExtended {$ENDIF});
end;

function TGrInplaceEdit.TextToValText(const AValue: string): string;
begin
  Result := DelRSpace(AValue);
  if DecimalSeparator <> ThousandSeparator then begin
    Result := DelChars(Result, ThousandSeparator);
  end;
  if (DecimalSeparator <> '.') and (ThousandSeparator <> '.') then
    Result := ReplaceStr(Result, '.', DecimalSeparator);
  if (DecimalSeparator <> ',') and (ThousandSeparator <> ',') then
    Result := ReplaceStr(Result, ',', DecimalSeparator);
  if Result = '' then Result := '0'
  else if Result = '-' then Result := '-0';
end;

function TGrInplaceEdit.IsValidChar(Key: Char): Boolean;
var
  S: string;
  SelStart, SelStop, DecPos: Integer;
  RetValue: Extended;
begin
  Result := False;
  S := EditText;
  GetSel(SelStart, SelStop);
  System.Delete(S, SelStart + 1, SelStop - SelStart);
  System.Insert(Key, S, SelStart + 1);
  S := TextToValText(S);
  DecPos := Pos(DecimalSeparator, S);
  if (DecPos > 0) then begin
    SelStart := Pos('E', UpperCase(S));
    if (SelStart > DecPos) then DecPos := SelStart - DecPos
    else DecPos := Length(S) - DecPos;
    if DecPos > FNumDecimal then Exit;
  end;
  Result := IsValidFloat(S, RetValue);
  if Result and  (RetValue < 0) then
    Result := False;
end;

//******************************************************************************
Function TGrInplaceEdit.DatePreference(Text :String) :TDateTime;
Var
   jj, mm, aa :Word;
   dj, dm, da :Word;
Begin
   if (Pos(DateSeparator, Text) = 0) then Begin
      jj:= StrToInt1(Copy(Text, 1, 2));
      mm:= StrToInt1(Copy(Text, 3, 2));
      aa:= StrToInt1(Copy(Text, 5, Length(Text) - 4));
   End
   Else Begin
      jj:= StrToInt1(GetStringElement(Text, 1, DateSeparator));
      mm:= StrToInt1(GetStringElement(Text, 2, DateSeparator));
      aa:= StrToInt1(GetStringElement(Text, 3, DateSeparator));
   End;
   DecodeDate(Date, da, dm, dj);
   If (aa = 0) then aa:= da
   Else if (aa < 40) then aa:= aa + 2000
   Else if (aa < 100) then aa:= aa + 1900;
   if (mm = 0) Or (mm > 12) then mm:= dm;
   if (jj < 0) or (jj > GetMaxJourMois(Mm, Aa)) then jj:= 1;
   Try
    Result:=EncodeDate(aa,mm,jj);
   Except
    Result:= 0;
   End;
End;

//******************************************************************************
Function TGrInplaceEdit.GetMaxJourMois(Mm, Aa :Word):Word;
// Donne le nombre de jour dans un mois
Begin
	Case Mm of
   4, 6, 9, 11: Result:= 30;
   2: if ((aa Div 4) = aa / 4) then Result:= 29
   	else		Result:= 28;
   Else Result:= 31;
	End;
End;

//******************************************************************************
Function TGrInplaceEdit.StrToInt1(Text :String) :LongInt;
// Gere l'erreur pour StrToInt
Begin
	Try
   	Result:= StrToInt(Text);
   Except
   	Result:= 0;
	End;
End;
//******************************************************************************
Function TGrInplaceEdit.CalculDate(dDate :TDateTime; Plus :Integer; Classe :TcdClasse;
      jourduMois :LongInt) :TDateTime;
Var aa, mm, jj, jm :Word;
Begin
	Try
		DecodeDate(dDate, aa, mm, jj);
      case Classe of
         cdJour: jj:= jj + Plus;
         CdMois: mm:= mm + Plus;
         cdAnnee: aa:= aa + Plus;
      end;

		if Plus > 0 then
      while (mm > 12) Or (jj > GetMaxJourMois(mm, aa)) do Begin
	     	if mm > 12 then begin
   	   	mm:= mm -12;
      	   inc(aa);
	      end
   	   else begin
      	   jj:= jj - GetMaxJourMois(mm, aa);
         	inc(mm)
	      end;
      End;

      if Plus < 0 Then
      while (mm < 0) or (JJ < 0) do
      if (mm <= 1) then begin
			mm:= mm + 12;
         Dec(aa);
      end
      else begin
         dec(mm);
         jm:= GetMaxJourMois(mm, aa);
         jj:= jj + jm;
      end;

		jm:= GetMaxJourMois(mm, aa);
      case JourduMois of
      1..31: Begin
      	if (JourduMois < JJ) And (JourDuMois < jm)then Begin
            if (mm = 12) then Begin
            	Inc(aa);
               mm:= 1
            End
            Else Inc(mm);
            jm:= GetMaxJourMois(mm, aa);
         End;
      	if (JourduMois < jm) then
         		jj:= JourduMois
        	else 	jj:= jm;
      End;
      1531:
      	if (jj <= 15) then jj:= 15
        	else jj:= jm;
      101531:
      	if (jj <= 10) then jj:= 10
      	else if (jj <= 20) then jj:= 20
        	else jj:= jm;
      end;

		result:= EnCodeDate(aa, mm, jj);
	Except
		result:= 0;
	End;
End;

//******************************************************************************
Function TGrInplaceEdit.GetStringElement(aString :String; aPos :Integer; cSep :Char) :String;
// Retourne le mot dans une liste suivant la position demandée ex:
// GetStringElement('aaa;zzzz;eeee;',2,';'); retourne 'zzzz'
Var
	i, d, lg :Integer;
Begin

	lg:= Length(aString);
	d:= 1;
	i:= 1;
	While (d < aPos) And (i < lg) do
	Begin
		if (aString[i] = cSep) Then Inc(d);
		Inc(i);
	End;

	If (d = aPos) then
	Begin
		d:= i;
		While (i <= lg) do
		Begin
			if (aString[i] = cSep) Then Break;
			Inc(i);
		End;
		Result:= Copy(aString, d, (i-d));
	End
	Else Result:= '';
End;

//******************************************************************************
Function TGrInplaceEdit.StrToDate2(Const Text :String) :TDateTime;
Var
   jj, mm, aa :Word;
   dj, dm, da :Word;
Begin
   if (Pos(DateSeparator, Text) = 0) then Begin
      jj:= StrToInt1(Copy(Text, 1, 2));
      mm:= StrToInt1(Copy(Text, 3, 2));
      aa:= StrToInt1(Copy(Text, 5, Length(Text) - 4));
   End
   Else Begin
      jj:= StrToInt1(GetStringElement(Text, 1, DateSeparator));
      mm:= StrToInt1(GetStringElement(Text, 2, DateSeparator));
      aa:= StrToInt1(GetStringElement(Text, 3, DateSeparator));
   End;

   DecodeDate(Date, da, dm, dj);
   If (aa = 0) then aa:= da
   Else if (aa < 40) then aa:= aa + 2000
   Else if (aa < 100) then aa:= aa + 1900;

   if (mm = 0) Or (mm > 12) then mm:= dm;

   if (jj < 0) or (jj > GetMaxJourMois(Mm, Aa)) then jj:= 1;

   Try
        Result:=EncodeDate(aa,mm,jj);
   Except
   	Result:= 0;
   End;
End;
//******************************************************************************
function TGrInplaceEdit.KeyPressDate(var Key: Char) :boolean;
Var
 dt :TDateTime;
 texte:string;
Begin
   if (key = #32) or (key = '.') then Begin
      key:= DateSeparator;
      Result:= True;
   End
   Else if (Key In ['-', '+']) then Begin
//      if (Control is TCustomEdit) then
         dt:= StrToDate2(Text);
      if (Dt = 0) then Dt:= SysUtils.Date
      Else if (Key = '-') then
           begin
           dt:= Dt -1;
           text:=DateToStr(dt);
           end
           Else
           begin
           Dt:= Dt +1;
           text:=DateToStr(dt);
           end;
//      if (Control is TCustomEdit) then Begin
//         TCustomEdit(Control).Text:= DateToStr(Dt);
//         TCustomEdit(Control).SelectAll;
//      End;
      Key:= #0;
      Result:= False;
   End
   Else if not (Key in [#0..#31, '0'..'9', DateSeparator]) then Begin
      messagebeep(0);
      Key:= #0;
      Result:= False;
   End
   Else Result:= True;
         if length(text)=7 then
            if pos('/',text) = 0 then
                             Begin
                              texte:=text;
                              insert('/',texte,3);
                              insert('/',texte,6);
                              text:=texte+key;
                              key:=#0;
                              UpdateContents;
                              selstart:=length(text);
                             End;

End;

procedure TGrInplaceEdit.KeyDown(var Key: Word; Shift: TShiftState);
var
Date:TDateTime;
texte:string;
ret:TResultPropDate;
ToutSelect:Boolean;
ISelect:integer;
//Mark : TBookMark;
//StateTmp,stateaux:TDatasetState;
//AjoutAuto:boolean;
begin
//AjoutAuto:=((Key = VK_DOWN) or (Key=VK_UP));
//if (grid is TCustomDBGrid) then
//   StateTmp:=(grid as TCustomDBGrid).SelectedField.DataSet.State;
      
ToutSelect:=false;
if ((Key = VK_RETURN) and (grid is TCustomDBGrid)) then
   begin
   if (grid as TCustomDBGrid).SelectedField.DataType in [fTDate]
        then
         begin
            if (grid as TCustomDBGrid).SelectedField.DataSet.State in [dsedit,dsinsert] then
             if length(text) > 0 then
               try
                (grid as TCustomDBGrid).SelectedField.AsDateTime:=StrToDate(text);

               except
               // abort;
               on EConvertError do
                                Begin
                                 ret:=DatePropose(text);
                                 if Ret.retour then
                                    begin
                                     text:=DateToStr(Ret.DateValide);
//                                    (grid as TCustomDBGrid).SelectedField.AsDateTime:=ret.DateValide;
                                    end
                                  else
                                   reset;
                                End;
               end;
        end;
   ISelect:=(grid as TCustomDBGrid).FieldCount-1;
   if ISelect=(grid as TCustomDBGrid).SelectedIndex then
    Begin
           if (grid as TCustomDBGrid).SelectedField.DataSet.State in [dsInsert] then
            begin
              (grid as TCustomDBGrid).editorMode:=false;
              if not (grid as TCustomDBGrid).SelectedField.ReadOnly then
              (grid as TCustomDBGrid).SelectedField.Text:=text;
            end;
           if (grid as TCustomDBGrid).SelectedField.DataSet.State in [dsedit] then
            begin
              if visible then hide;
              (grid as TCustomDBGrid).editorMode:=false;
            end;
    End;
   if visible then
      begin
       try
      (grid as TCustomDBGrid).SelectedIndex:=(grid as TCustomDBGrid).SelectedIndex+1;
       except
       end;
      end;
   end;
if ((Key = VK_RIGHT) and (grid is TCustomDBGrid)) then
   begin
   if visible then
    if SelStart= SelLength
      then
       (grid as TCustomDBGrid).SelectedIndex:=(grid as TCustomDBGrid).SelectedIndex+1;
   end;
if ((Key = VK_LEFT) and (grid is TCustomDBGrid)) then
   begin
   if visible then
    if SelStart= 0
     then
      begin
       deselect;
     end;
   end;
if ((Key = VK_RETURN) and (grid is TCustomGrid)) then
   begin
   Key:=VK_TAB;
   end;

inherited KeyDown(key,Shift);
//stateaux:=(grid as TCustomDBGrid).SelectedField.DataSet.State;
////if (((Key = VK_DOWN) or (Key=VK_UP)) and (grid is TCustomDBGrid)) then
//if AjoutAuto=true then
//if (grid is TCustomDBGrid) then
//   Begin
//    if ((StateTmp = dsInsert) and ((grid as TCustomDBGrid).SelectedField.DataSet.State = dsBrowse)) then
//       Begin
//         (grid as TCustomDBGrid).SelectedField.DataSet.Append;
//       End;
//    if ((StateTmp <> dsInsert) and ((grid as TCustomDBGrid).SelectedField.DataSet.State = dsBrowse)) then
//       Begin
//        if TMyCustomGrid(grid).row = TMyCustomGrid(grid).RowCount-1 then
//           Begin
//             (grid as TCustomDBGrid).SelectedField.DataSet.Append;
//           End;
//       End;
//   End;
if ((Key = VK_F1) and (grid is TCustomDBGrid)) then
   begin
     if (grid as TCustomDBGrid).SelectedField.DataType in [fTDate]
        then
         begin
            if FDateDef = 0 then
            Date:=Now else Date:=FDateDef;
            if PopupDate(Date,self) then text:=DateToStr(Date);
            if (grid as TCustomDBGrid).SelectedField.DataSet.State in [dsedit,dsinsert] then
               try
//                if length(text)=8 then
//                   if pos('/',text) = 0 then
//                                    Begin
//                                     texte:=text;
//                                     insert('/',texte,3);
//                                     insert('/',texte,6);
//                                     text:=texte;
//                                    End;
                (grid as TCustomDBGrid).SelectedField.AsDateTime:=StrToDate(text);

               except
               // abort;
//               on EConvertError do
//               showmessage('ee');
                //(grid as TCustomDBGrid).SelectedField.AsDateTime:=StrToDate();
               end;


         end;
   end;
end;

procedure TGrInplaceEdit.KeyUp(var Key: Word; Shift: TShiftState);
Begin
   try
   if (grid is TGrGrid) then
      if Modified then
      begin
      (grid as TGrGrid).Change((grid as TGrGrid));
       if not ((grid as TGrGrid).EtatGrille in [dsEdit,dsInsert]) then
       (grid as TGrGrid).EtatGrille:=dsEdit;
       (grid as TGrGrid).StateChange((grid as TGrGrid));
      end;
   except
   Key:=0;
   abort;
   end;
End;


procedure TGrInplaceEdit.KeyPress(var Key: char);
var
texte:string;
KeyTmp:char;
begin
      
KeyTmp:=key;
inherited KeyPress(key);
if KeyTmp=#13 then SelectAll;
if (grid is TCustomDBGrid) then
   begin
     if (grid as TCustomDBGrid).SelectedField.DataType in [ftCurrency,ftFloat]
        then
        begin
        if Key in ['.', ','] then Key := DecimalSeparator;
        if (Key in [#32..#255]) and not IsValidChar(Key) then
           begin
           Key := #0;
           end
           else
           if Key = #27 then
              begin
              Reset;
              Key := #0;
              end;
        end;
     if (grid as TCustomDBGrid).SelectedField.DataType in [fTDate]
        then
        begin
//         if length(text)=8 then
//            if pos('/',text) = 0 then
//                             Begin
//                              texte:=text;
//                              insert('/',texte,3);
//                              insert('/',texte,6);
//                              text:=texte;
//                             End;
         KeyPressDate(key);
        end;
   end;
if (grid is TGrGrid) then
 if (grid as TGrGrid).Champ <> nil then
    if (grid as TGrGrid).Champ.Count > 0 then
   begin
//   if Modified then
////   if text <> (grid as TGrGrid).Cells[(grid as TGrGrid).col,(grid as TGrGrid).row] then
//    if (grid as TGrGrid).EtatGrille=dsBrowse then
//    (grid as TGrGrid).EtatGrille:=dsEdit;
   with (grid as TGrGrid) do
   case (grid as TGrGrid).champ.items[(grid as TGrGrid).col-1] of
   GrCompte:Begin
            if not (key  in [#8,#9,#13,#43,#48..#57]) then
              key:=#0;
            End;
      GrNum:Begin
            if not(key in [#9,#8,#13,#48..#57,DecimalSeparator])then
              key:=#0;
            End;
     GrCurr:Begin
             if not(key in [#9,#8,#13,#43,#45,#48..#57,DecimalSeparator])then
              key:=#0;
            End;
     GrDate:Begin

            End;
     GrBool:Begin

            End;
   end;
   end;
end;

procedure TGrInplaceEdit.UpdateContents;
begin
 inherited ;

end;

function TGrInplaceEdit.DisplayMonnaie(var Montant:string): string;
var
  CurrStr: string;
  I: Integer;
  C: Char;
begin
//  result:='';
//  for i:=1 to length(montant) do
//      begin
//        if montant[i] <>' ' then result:=montant[i]+result;
//      end;
//        montant:=result;
//        montant:=trim(montant);
//        Montant:=QuedesChiffres(Montant);
////        if montant <> '' then
//        result:=Formatcurr('# ###.00',strtocurr(Montant));
//        Format('%m',[montant]);
//  Result := ',0.' + MakeStr('0', CurrencyDecimals);
//  CurrStr := '';
//  for I := 1 to Length(CurrencyString) do begin
//    C := CurrencyString[I];
//    if C in [',', '.'] then CurrStr := CurrStr + '''' + C + ''''
//    else CurrStr := CurrStr + C;
//  end;
//  if Length(CurrStr) > 0 then
//    case CurrencyFormat of
//      0: Result := CurrStr + Result; { '$1' }
//      1: Result := Result + CurrStr; { '1$' }
//      2: Result := CurrStr + ' ' + Result; { '$ 1' }
//      3: Result := Result + ' ' + CurrStr; { '1 $' }
//    end;
//  Result := Format('%s;-%s', [Result, Result]);
//  edittext:=result;
//    result:='ftrejjjj';
end;

destructor TGrInplaceEdit.Destroy;
begin
     inherited;
end;

constructor TGrDBGrid.Create(Aowner: TComponent);
begin
inherited create(AOwner);
//DefaultDrawing:=true;
//     FCurrency:=TCurrencyEdit.
//     FCurrency.
//     FTypeColorFocalisation:=clWindow;
//     FTypeColorBord:=clWindow;
end;

destructor TGrDBGrid.Destroy;
begin
     inherited destroy;
end;

procedure TGrDBGrid.loaded;
begin
inherited;
if FParamColor then
   Begin
     HighlightColor:=Param.CelActiveColorFond;
     HighlightFontColor:=Param.CelActiveColorFont;
     // Param.CelActiveContour;
     InplaceEditColor:=Param.CelActiveSAisieColorFond;
     InplaceEditColorFont:=Param.CelActiveSAisieColorFont;
     FixedColor:=Param.CelFixeColorFond;
     TitleFont.Color:=Param.CelFixeColorFont;
     Color:=Param.GrilleColorFond;
     Font.Color:=Param.GrilleColorFont;
   end
   else
   begin
    InplaceEditColor:=clWindow;
    InplaceEditColorFont:=clWindowText;
   end;
end;

procedure TGrDBGrid.KeyDown(var Key: Word; Shift: TShiftState);
var
Mark : TBookMark;
StateTmp,stateaux:TDatasetState;
AjoutAuto:boolean;
KeyTmp:Word;
begin
//if not (SelectedField.DataType in [ftBoolean]) then
//   begin
KeyTmp:=Key;
AjoutAuto:=((Key = VK_DOWN) or (Key=VK_UP));
StateTmp:=SelectedField.DataSet.State;
if (KeyTmp = VK_RETURN) then
   begin
    if SelectedIndex = (FieldCount-1) then
       Begin
         if SelectedField.DataSet.State in [dsinsert] then
            Begin
             try
              SelectedField.DataSet.Post;
//              Mark :=(SelectedField.DataSet.GetBookmark);
                  SelectedField.DataSet.Next;
              if SelectedField.DataSet.eof then
                 begin
                  SelectedField.DataSet.Append;
                 end
                 else
                 begin
                  SelectedField.DataSet.Insert;
              end;
//              SelectedField.DataSet.GotoBookmark(mark);
//              SelectedField.DataSet.FreeBookmark(mark);
              Key:=VK_CANCEL;
              abort;
              except
//              SelectedField.DataSet.FreeBookmark(mark);
              Key:=VK_CANCEL;
              abort;
             end;
            End;
         if SelectedField.DataSet.State in [dsedit] then
            Begin
             try
              SelectedField.DataSet.Post;
             except
            end;
            end;
       End;
   end;
stateaux:=SelectedField.DataSet.State;
inherited KeyDown(key,Shift);
if ((AjoutAuto=true) and (KeyTmp = VK_DOWN)) then
   Begin
    if ((StateTmp = dsInsert) and (selectedField.DataSet.State = dsBrowse)) then
       Begin
         SelectedField.DataSet.insert;
       End;
    if ((StateTmp <> dsInsert) and (SelectedField.DataSet.State = dsBrowse)) then
       Begin
        if SelectedField.DataSet.EOF then
           Begin
             SelectedField.DataSet.Append;
             abort;
           End;
       End;
   End;
//   end // Fin si type field = boolean
//   else
//   inherited KeyDown(key,Shift);
End;

procedure TGrDBGrid.DrawColumnCell(const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  RectLine:TRect;
begin
inherited ;
//DrawColumnCell(Rect, DataCol, Column, State);
if FParamColor then
   Begin
     //                 Param.LigneContour;
     HighlightColor:=Param.CelActiveColorFond;
     HighlightFontColor:=Param.CelActiveColorFont;
    Canvas.Pen.Color:=Param.LigneContour;
    Canvas.Pen.Width:=2;
    RectLine:=Boxrect(0,Row,ColCount,Row);
    Canvas.Polyline([Point(RectLine.Left+1,RectLine.Top+1),Point(RectLine.Right-1,RectLine.Top+1),Point(RectLine.Right-1,RectLine.Bottom-1),point(RectLine.Left+1,RectLine.Bottom-1),Point(RectLine.Left+1,RectLine.Top+1)]);
    RectLine:=CellRect(Col,Row);
//    DBEmprunt.Canvas.Polyline([Point(RectLine.Left+1,0),Point(RectLine.Left+1,RectLine.Top+1)]);
//    GrDBGridExemple.Canvas.Pen.Color:=$0000E600;Main.ContourCelActive;
    Canvas.Pen.Color:=Param.CelActiveContour;
    Canvas.Polyline([Point(RectLine.Left+1,RectLine.Top+2),Point(RectLine.Right-1,RectLine.Top+2),Point(RectLine.Right-1,RectLine.Bottom-2),point(RectLine.Left+1,RectLine.Bottom-2),Point(RectLine.Left+1,RectLine.Top+2)]);
   End;
if FParamColor then
   Begin
if (not (gdFocused in State)) and (gdSelected in State) then
    if not (dgRowSelect in Options) then
        begin
    RectLine:=CellRect(Col,Row);
//    DBEmprunt.Canvas.Polyline([Point(RectLine.Left+1,0),Point(RectLine.Left+1,RectLine.Top+1)]);
//    GrDBGridExemple.Canvas.Pen.Color:=$0000E600;Main.ContourCelActive;
    Canvas.Pen.Color:=clInactiveBorder;
    Canvas.Polyline([Point(RectLine.Left+1,RectLine.Top+2),Point(RectLine.Right-1,RectLine.Top+2),Point(RectLine.Right-1,RectLine.Bottom-2),point(RectLine.Left+1,RectLine.Bottom-2),Point(RectLine.Left+1,RectLine.Top+2)]);
//            canvas.Brush.Color:= clred;
//            Canvas.Brush.Style:=bsClear;
///            Canvas.FrameRect(Rect);
//            canvas.TextRect(rect,2,2,'eeeeeee');
        end;
end;

//
end;

procedure TGrDBGrid.ColEnter;
begin
inherited;
TitreColor(true);
end;

procedure TGrDBGrid.ColExit;
begin
inherited;
if FAcquireFocus then
TitreColor(false);
end;

Procedure TGrDBGrid.TitreColor(Enter:boolean);
begin
if FParamColor then
  if enter then
   begin
    Columns[SelectedIndex].Title.Font.Style:=[fsbold];
    Columns[SelectedIndex].Title.Font.Color:=clRed;
    if DataSource <> nil then
    if DataSource.State in [dsedit,dsInsert] then
    Columns[SelectedIndex].Title.Font.Style:=Columns[SelectedIndex].Title.Font.Style+[fsItalic];
   end
   else
   begin
    Columns[SelectedIndex].Title.Font.Style:=[];
    Columns[SelectedIndex].Title.Font.Color:=param.CelFixeColorFont;
   end;
end;

Procedure TGrDBGrid.UpDateColor;
begin
if FParamColor then
   Begin
     HighlightColor:=Param.CelActiveColorFond;
     HighlightFontColor:=Param.CelActiveColorFont;
     // Param.CelActiveContour;
     InplaceEditColor:=Param.CelActiveSAisieColorFond;
     InplaceEditColorFont:=Param.CelActiveSAisieColorFont;
     FixedColor:=Param.CelFixeColorFond;
     TitleFont.Color:=Param.CelFixeColorFont;
     Color:=Param.GrilleColorFond;
     Font.Color:=Param.GrilleColorFont;
   end
   else
   begin
    InplaceEditColor:=clWindow;
    InplaceEditColorFont:=clWindowText;
   end;
   refresh;
   Repaint;

end;
//procedure TGrDBGrid.CMMouseEnter(var Msg: TMessage);
//var
//    Pt: TPoint;
//    Can:TCanvas;
//begin
//Can:=TCanvas.Create;
//can.Font.Color:=clred;
////Columns[MouseCoord(Pt.x,Pt.y).X].Field
//if ((MouseCoord(Pt.x,Pt.y).X > 0) and (MouseCoord(Pt.x,Pt.y).Y>0)) then
////cellAttribute(Columns[MouseCoord(Pt.x,Pt.y).X].Field,can,[]);
//showmessage(Columns[1].Field.AsString);
////CellRect
////CellAttribute(Columns[1].Field,can,[]);
////    if FCellHints = True then
////        begin
////            GetCursorPos(Pt);
////            Pt := ScreenToClient(Pt);
////            DoHint(Pt.X, Pt.Y);
////        end;
////
////    if FHotTrack = True then
////        begin
////            Font.Color := FHotTrackColor;
////        end;
//Can.Free;
//end;
//
//procedure TGrDBGrid.CMMouseLeave(var Msg: TMessage);
//begin
//    inherited;
//
////    if FCellHints = True then
////        if Assigned(FHintWnd) then
////            begin
////                FHintWnd.Destroy;
////                FHintWnd := nil;
////            end;
////
////    if FHotTrack = True then
////        begin
////            Font.Color := FOrigColor;
////        end;
//end;


//procedure TGrDBGrid.ApplyCellAttribute(Field: TField; Canvas: TCanvas; State: TGridDrawState);
//begin
//canvas.Font.Color:=clred;
////
//end;
//
//procedure TGrDBGrid.CMEXIT(var Message: TCMExit);
//Begin
//inherited ;//exit(sender);
////if not (csDesigning in self.ComponentState) then
////begin
//if SelectedField.DataSet.State in [dsinsert] then
//     If Messagedlg(FMesExitInInsert,MtConfirmation,[mbyes,mbno],0) = mryes Then
//   Begin
//     SelectedField.DataSet.Cancel;
//     End
//     Else
//     Begin
//       SetFocus;
//     End;
////     End; // Fin utilisateur est en mode Insertion
//
//if SelectedField.DataSet.State in [dsEdit] then
//          If Messagedlg(FMesExitInEdit,MtConfirmation,[mbyes,mbno],0) = mryes
//          Then
//       Begin
//        SelectedField.DataSet.Cancel;
//     End
//     Else
//     Begin
//       SetFocus;
//     End;
////   End; // Fin utilisateur est en mode Edition
////end;
////inherited ;//exit(sender);
//End;

function TGrDBGrid.CreateEditor: TInplaceEdit;
var
  RectLine:TRect;
begin
//    Result := inherited CreateEditor;
    Result :=TGrInplaceEdit.Create(self) ;
//    result.BoundsRect;
//    TGrInplaceEdit(Result).Color := $00E8FFFF;//$0000A400
//    TGrInplaceEdit(Result).Color := $0000E600;InplaceEditColorFont
   if FParamColor then begin
     InplaceEditColor:=Param.CelActiveSAisieColorFond;
     InplaceEditColorFont:=Param.CelActiveSAisieColorFont;
    TGrInplaceEdit(Result).Color := InplaceEditColor;
    TGrInplaceEdit(Result).Font.Color:=InplaceEditColorFont;
    end;
//    TGrInplaceEdit(Result).Font.Color:=clWhite;
    TGrInplaceEdit(Result).NumDecimal:=NumDecimal;
    TGrInplaceEdit(Result).DateDef:=DateDef;
//    TGrInplaceEdit(Result).canvas.Pen.Color:=clRed;

//    (DBEmprunt.InplaceEditor as TMyCustControl).Canvas.Pen.Color:=Clred;
//    TGrInplaceEdit(Result).Canvas.Pen.Width:=2;
//////    Canvas.Font.Size:=font.size+1;
//    (DBEmprunt.InplaceEditor as TMyCustControl).Canvas.Font.Size:=font.size;
////    Canvas.Font.Color:=Font.color;
//RectLine:=TGrInplaceEdit(Result).BoundsRect;
////TMyCustControl(DBEmprunt.InplaceEditor).Canvas
////    RectLine:=DBEmprunt.e
////    (TMyCustGrid(DBEmprunt)).Boxrect(0,DBEmprunt.Row,DBEmprunt.VisibleColCount,DBEmprunt.Row);
//    TGrInplaceEdit(Result).Canvas.Polyline([Point(RectLine.Left+1,RectLine.Top+1),Point(RectLine.Right-1,RectLine.Top+1),Point(RectLine.Right-1,RectLine.Bottom-2),point(RectLine.Left+1,RectLine.Bottom-2)]);



//    (Result as TCustomControl).
//    TGrInplaceEdit(Result).grid.c
////     FAffMonnaie:=TCurrencyEdit.Create(AOwner);
//     TGrInplaceEdit(Result).FAffMonnaie.Parent:=self;
//     TGrInplaceEdit(Result).FAffMonnaie.DisplayFormat:=',0.00 F;-,0.00 F';
//     TGrInplaceEdit(Result).FAffMonnaie.BoundsRect:=CellRect(SelectedIndex+1,Row);
//
//
////     TGrInplaceEdit(Result).FAffMonnaie.SendToBack;
//     TGrInplaceEdit(Result).FAffMonnaie.Visible:=true;
//     TGrInplaceEdit(Result).FAffMonnaie.FormatOnEditing:=true;
//     TGrInplaceEdit(Result).FAffMonnaie.Color:=claqua;
//////     InsertControl(FAffMonnaie);
//     TGrInplaceEdit(Result).FAffMonnaie.Text:=text;
//     TGrInplaceEdit(Result).FAffMonnaie.SetFocus;
//    TGrInplaceEdit(Result).FAffMonnaie.SetFocus;
//    TInplaceEditGrainCracker(Result).KeyDown:=KeyDown;
//    TInplaceEditGrainCracker(Result).FormatMonnaie:=text;
//        TCurrencyEdit(Result).DisplayFormat:=',0.00 F;-,0.00 F';
//    TCustomNumEdit(Result).SelLength:=2;
    //FCurrency.DisplayFormat:=',0.00 F;-,0.00 F';
//    FInplaceGrainEdit := Result;
//    FInplaceGrainEdit.fo
end;

end.
