{$IMPORTEDDATA ON}
Unit DialogEx;
Interface
Uses Windows, Graphics;
Const
  IDI_PERSO         = MakeIntResource(44555);
  mrCust1           = IdNo + 4;
  mrCust2           = IdNo + 5;
  mrCust3           = IdNo + 6;
  mrCust4           = IdNo + 7;
{  DB_BtnOui         = $00000001;
  DB_BtnNon         = $00000002;
  DB_BtnOk          = $00000004;
  DB_BtnAnnuler     = $00000008;
  DB_BtnAbandonner  = $00000010;
  DB_BtnReessayer   = $00000020;
  DB_BtnIgnorer     = $00000040;
  DB_BtnTous        = $00000080;
  DB_BtnNonpourTous = $00000100;
  DB_BtnOuipourTous = $00000200;
  DB_BtnAide        = $00000400;
  DB_BtnCust1       = $00000800;
  DB_BtnCust2       = $00001000;
  DB_BtnCust3       = $00002000;
  DB_BtnCust4       = $00004000;
 }DB_BtnCheckBox    = $00008000;
Type
  TMsgDlgTypeEx = (mtWarning, mtError, mtInformation, mtConfirmation, mtCustom,
    mtPerso);
  TMsgDlgBtnEx = (mbYes, mbNo, mbOK, mbCancel, mbAbort, mbRetry, mbIgnore,
    mbAll, mbNoToAll, mbYesToAll, mbHelp, mbCust1, mbCust2, mbCust3, mbCust4);
  TMsgDlgButtonsEx = Set Of TMsgDlgBtnEx;
  PCustBtnText = ^TCustBtnText;
  TCustBtnText = Array[mbCust1..mbCust4] Of String;
  tagMSGDLGPARAMS = Packed Record
    CheckBox        : Boolean;
    BoxCaption      : String;
    StrRessource    : String;
    lpszText        : PAnsiChar;
    lpszCaption     : PAnsiChar;
    DlgType         : TMsgDlgTypeEx;
    DlgBtn          : TMsgDlgButtonsEx;
    DefaultBtn      : TMsgDlgBtnEx;
    IconNbr         : Integer;
    dwContextHelpId : LongInt;
    CustBtnText     : TCustBtnText;
  End;
  TMSGDLGPARAMS = tagMSGDLGPARAMS;

//  TBoolIntRec = Packed Record Int: Integer; Bool: Boolean;
//  End;
Var
//  CustBtnText : TCustBtnText;
  CustCaption       : String;
Const
  TMsgDlgBtnFlagsEx : Array[TMsgDlgBtnEx] Of Integer = ($00000001,
    $00000002,
    $00000004,
    $00000008,
    $00000010,
    $00000020,
    $00000040,
    $00000080,
    $00000100,
    $00000200,
    $00000400,
    $00000800,
    $00001000,
    $00002000,
    $00004000);

Function MsgDlgBox(DlgParam: TMsgDlgParams): Integer;
Function MessageDlgEx(Const Msg: String; DlgType: TMsgDlgTypeEx;
  Buttons: TMsgDlgButtonsEx; HelpCtx: Longint; Const DefBtn: TMsgDlgBtnEx =
    mbYes; Const DlgIcon: TIcon = Nil; Const CustBtnText:
  PCustBtnText = Nil): Integer;
Function MessageDlgBoxEx(Const Msg: String; DlgType: TMsgDlgTypeEx;
  Buttons: TMsgDlgButtonsEx; HelpCtx: Longint; Const DefBtn: TMsgDlgBtnEx =
    mbYes; Const ShowBox: Boolean = False;
  Const BoxTxt: String = ''; Const DlgIcon: TIcon = Nil; Const CustBtnText:
    PCustBtnText = Nil): Integer;
Procedure InitMsgDlgParams(Var MsgDlgParams:TMsgDlgParams);


Resourcestring
  SMsgPerso         = 'Custom DlgBox by Cirec';
  SMsgDlgWarning = 'Avertissement';
  SMsgDlgError = 'Erreur';
  SMsgDlgInformation = 'Information';
  SMsgDlgConfirm = 'Confirmation';
  SMsgDlgYes = '&Oui';
  SMsgDlgNo = '&Non';
  SMsgDlgOK = 'OK';
  SMsgDlgCancel = 'Annuler';
  SMsgDlgHelp = '&Aide';
  SMsgDlgHelpNone = 'Aucune aide disponible';
  SMsgDlgHelpHelp = 'Aide';
  SMsgDlgAbort = '&Abandonner';
  SMsgDlgRetry = '&Retenter';
  SMsgDlgIgnore = '&Ignorer';
  SMsgDlgAll = '&Tous';
  SMsgDlgNoToAll = 'Non &pour tout';
  SMsgDlgYesToAll = 'O&ui pour tout';
  Cust1             = '';


Implementation
Uses Consts, Math, Extctrls, Controls,
  Forms, StdCtrls, SysUtils, Classes;

Function GetAveCharSizeEx(Canvas: TCanvas): TPoint;
Var
  I                 : Integer;
  Buffer            : Array[0..51] Of Char;
Begin
  For I := 0 To 25 Do Buffer[I] := Chr(I + Ord('A'));
  For I := 0 To 25 Do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X Div 52;
End;
Type
  TMessageFormEx = Class(TForm)
    Procedure CreateParams(Var Params: TCreateParams); override;
  Private
    Message: TLabel;
    Procedure HelpButtonClick(Sender: TObject);
  Protected
    Procedure CustomKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
    Procedure WriteToClipBoard(Text: String);
    Function GetFormText: String;
  Public
    Constructor CreateNew(AOwner: TComponent); Reintroduce;
  End;

Constructor TMessageFormEx.CreateNew(AOwner: TComponent);
Var
  NonClientMetrics  : TNonClientMetrics;
//  Params: TCreateParams
Begin
  Inherited CreateNew(AOwner);
  NonClientMetrics.cbSize := sizeof(NonClientMetrics);
  If SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) Then
    Font.Handle := CreateFontIndirect(NonClientMetrics.lfMessageFont);
//    CreateParams(Params);
End;

Procedure TMessageFormEx.HelpButtonClick(Sender: TObject);
Begin
  Application.HelpContext(HelpContext);
End;

Procedure TMessageFormEx.CustomKeyDown(Sender: TObject; Var Key: Word; Shift:
  TShiftState);
Begin
  If (Shift = [ssCtrl]) And (Key = Word('C')) Then
    Begin
      Beep;
      WriteToClipBoard(GetFormText);
    End;
End;

Procedure TMessageFormEx.WriteToClipBoard(Text: String);
Var
  Data              : THandle;
  DataPtr           : Pointer;
Begin
  If OpenClipBoard(0) Then
    Begin
      Try
        Data := GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, Length(Text) + 1);
        Try
          DataPtr := GlobalLock(Data);
          Try
            Move(PChar(Text)^, DataPtr^, Length(Text) + 1);
            EmptyClipBoard;
            SetClipboardData(CF_TEXT, Data);
          Finally
            GlobalUnlock(Data);
          End;
        Except
          GlobalFree(Data);
          Raise;
        End;
      Finally
        CloseClipBoard;
      End;
    End
  Else
    Raise Exception.CreateRes(@SCannotOpenClipboard);
End;

Function TMessageFormEx.GetFormText: String;
Var
  DividerLine, ButtonCaptions: String;
  I                 : integer;
Begin
  DividerLine := StringOfChar('-', 27) + sLineBreak;
  For I := 0 To ComponentCount - 1 Do
    If Components[I] Is TButton Then
      ButtonCaptions := ButtonCaptions + TButton(Components[I]).Caption +
        StringOfChar(' ', 3);
  ButtonCaptions := StringReplace(ButtonCaptions, '&', '', [rfReplaceAll]);
  Result := Format('%s%s%s%s%s%s%s%s%s%s', [DividerLine, Caption, sLineBreak,
    DividerLine, Message.Caption, sLineBreak, DividerLine, ButtonCaptions,
      sLineBreak, DividerLine]);
End;

Var
  CaptionsEx        : Array[TMsgDlgTypeEx] Of Pointer = (@SMsgDlgWarning,
    @SMsgDlgError,
    @SMsgDlgInformation, @SMsgDlgConfirm, Nil, @SMsgPerso);

  IconIDsEx         : Array[TMsgDlgTypeEx] Of PChar = (IDI_EXCLAMATION,
    IDI_HAND,
    IDI_ASTERISK, IDI_QUESTION, Nil, IDI_PERSO);
  ButtonCaptionsEx  : Array[TMsgDlgBtnEx] Of Pointer = (
    @SMsgDlgYes, @SMsgDlgNo, @SMsgDlgOK, @SMsgDlgCancel, @SMsgDlgAbort,
    @SMsgDlgRetry, @SMsgDlgIgnore, @SMsgDlgAll, @SMsgDlgNoToAll,
    @SMsgDlgYesToAll,
    @SMsgDlgHelp, @Cust1, @Cust1, @Cust1, @Cust1);
  ButtonNamesEx     : Array[TMsgDlgBtnEx] Of String = (
    'Yes', 'No', 'OK', 'Cancel', 'Abort', 'Retry', 'Ignore', 'All', 'NoToAll',
    'YesToAll', 'Help', 'Cust1', 'Cust2', 'Cust3', 'Cust4');
  ModalResults      : Array[TMsgDlgBtnEx] Of Integer = (
    mrYes, mrNo, mrOk, mrCancel, mrAbort, mrRetry, mrIgnore, mrAll, mrNoToAll,
    mrYesToAll, 0, mrCust1, mrCust2, mrCust3, mrCust4);
  ButtonWidths      : Array[TMsgDlgBtnEx] Of integer; // initialized to zero

Function CreateMessageDialogEx(Const Msg: String; DlgType: TMsgDlgTypeEx;
  Buttons: TMsgDlgButtonsEx; DefBtn: TMsgDlgBtnEx; ShowCheckBox: Boolean; BoxTxt: String; DlgIcon:
  TIcon; CustBtnText: TCustBtnText): TForm;
Const
  mcHorzMargin      = 8;
  mcVertMargin      = 8;
  mcHorzSpacing     = 10;
  mcVertSpacing     = 10;
  mcButtonWidth     = 50;
  mcButtonHeight    = 14;
  mcButtonSpacing   = 4;
Var
  DialogUnits       : TPoint;
  HorzMargin, VertMargin, HorzSpacing, VertSpacing, ButtonWidth,
    ButtonHeight, ButtonSpacing, ButtonCount, ButtonGroupWidth,
    IconTextWidth, IconTextHeight, X, ALeft, BoxTextWidth, CaptionWidth:
      Integer;
  B, DefaultButton, CancelButton: TMsgDlgBtnEx;
  IconID            : PChar;
  TextRect          : TRect;
  TmpBtnStr         : String;
Begin
  Result := TMessageFormEx.CreateNew(Application);
  With Result Do
    Begin
      BiDiMode := Application.BiDiMode;
      BorderStyle := bsSingle; // bsSizeable ; //;    bsDialog
      BorderIcons := [biSystemMenu];//**********************************
      Canvas.Font := Font;
      KeyPreview := True;
      Position := poDesigned;
      OnKeyDown := TMessageFormEx(Result).CustomKeyDown;
      DialogUnits := GetAveCharSizeEx(Canvas);
      HorzMargin := MulDiv(mcHorzMargin, DialogUnits.X, 4);
      VertMargin := MulDiv(mcVertMargin, DialogUnits.Y, 8);
      HorzSpacing := MulDiv(mcHorzSpacing, DialogUnits.X, 4);
      VertSpacing := MulDiv(mcVertSpacing, DialogUnits.Y, 8);
      ButtonWidth := MulDiv(mcButtonWidth, DialogUnits.X, 4);
      //Calcule la taille de la CheckBox
      BoxTextWidth := 0;
      If ShowCheckBox Then
        Begin
          DrawText(Canvas.Handle, PChar(BoxTxt), -1, TextRect,
            DT_CALCRECT Or DT_LEFT Or DT_SINGLELINE Or
            DrawTextBiDiModeFlagsReadingOnly);
          BoxTextWidth := TextRect.Right - TextRect.Left + 20;
        End;
      For B := Low(TMsgDlgBtnEx) To High(TMsgDlgBtnEx) Do
        Begin
          If B In Buttons Then
            Begin
              If ButtonWidths[B] = 0 Then
                Begin
                  TextRect := Rect(0, 0, 0, 0);
                  If B >= mbCust1 Then TmpBtnStr := CustBtnText[B] // AJouté
                  Else // AJouté
                    TmpBtnStr := LoadResString(ButtonCaptionsEx[B]);
                  Windows.DrawText(canvas.handle,
                    PChar(TmpBtnStr + '  '), -1,
                    TextRect, DT_CALCRECT Or DT_LEFT Or DT_SINGLELINE Or
                    DrawTextBiDiModeFlagsReadingOnly);
                  With TextRect Do ButtonWidths[B] := Right - Left + 8;
                End;
              If ButtonWidths[B] > ButtonWidth Then
                ButtonWidth := ButtonWidths[B];
            End;
          ButtonWidths[B] := 0;
        End;
      ButtonHeight := MulDiv(mcButtonHeight, DialogUnits.Y, 8);
      ButtonSpacing := MulDiv(mcButtonSpacing, DialogUnits.X, 4);
      SetRect(TextRect, 0, 0, Screen.Width Div 2, 0);
      DrawText(Canvas.Handle, PChar(Msg), Length(Msg) + 1, TextRect,
        DT_EXPANDTABS Or DT_CALCRECT Or DT_WORDBREAK Or
        DrawTextBiDiModeFlagsReadingOnly);
      IconID := IconIDsEx[DlgType];
      IconTextWidth := TextRect.Right;
      IconTextHeight := TextRect.Bottom;
      If IconID <> Nil Then
        Begin
          Inc(IconTextWidth, 32 + HorzSpacing);
          If IconTextHeight < 32 Then IconTextHeight := 32;
        End;
      ButtonCount := 0;
      For B := Low(TMsgDlgBtnEx) To High(TMsgDlgBtnEx) Do
        If B In Buttons Then Inc(ButtonCount);
      ButtonGroupWidth := 0;
      If ButtonCount <> 0 Then
        ButtonGroupWidth := ButtonWidth * ButtonCount +
          ButtonSpacing * (ButtonCount - 1);
      If ShowCheckBox Then // mise a jour de la largeur de la DlgBox
        Begin
          ClientWidth := Max(BoxTextWidth, ButtonGroupWidth) + HorzMargin * 2;
          If ClientWidth < IconTextWidth Then
            ClientWidth := IconTextWidth + HorzMargin * 2;
        End
      Else
        ClientWidth := Max(IconTextWidth, ButtonGroupWidth) + HorzMargin * 2;
      ClientHeight := IconTextHeight + ButtonHeight + VertSpacing +
        VertMargin * 2;
      Left := (Screen.Width Div 2) - (Width Div 2);
      Top := (Screen.Height Div 2) - (Height Div 2);

      If (DlgType <> mtCustom) And (DlgType <> mtPerso) Then
        if CustCaption='' then
          Caption := LoadResString(CaptionsEx[DlgType]) Else
             Caption :=CustCaption
        else
        If (DlgType = mtPerso) And (CustCaption <> '') Then
          Caption := CustCaption Else
          Caption := Application.Title;

          //**************************************************
      SetRect(TextRect, 0, 0, Screen.Width Div 2, 0);
      DrawText(Canvas.Handle, PChar(Caption), -1, TextRect,
        DT_CALCRECT Or DT_LEFT Or DT_SINGLELINE Or
        DrawTextBiDiModeFlagsReadingOnly);
      CaptionWidth := TextRect.Right - TextRect.Left + 50;
      If ClientWidth < CaptionWidth Then
        ClientWidth := CaptionWidth;

      SetRect(TextRect, 0, 0, Screen.Width Div 2, 0);
      DrawText(Canvas.Handle, PChar(Msg), Length(Msg) + 1, TextRect,
        DT_EXPANDTABS Or DT_CALCRECT Or DT_WORDBREAK Or
        DrawTextBiDiModeFlagsReadingOnly);


      If IconID <> Nil Then
        With TImage.Create(Result) Do
          Begin
            Name := 'Image';
            Parent := Result;
            If IconID <> IDI_PERSO Then // AJouté
              Picture.Icon.Handle := LoadIcon(0, IconID)
            Else // AJouté
              Picture.Icon.Assign(DlgIcon); // AJouté
        //Picture.Icon.LoadFromResourceName(hInstance,'MAINICON');
        //Picture.Icon.LoadFromFile('codecs.ico');
            SetBounds(HorzMargin, VertMargin, 32, 32);
          End;
      TMessageFormEx(Result).Message := TLabel.Create(Result);
      With TMessageFormEx(Result).Message Do
        Begin
          Name := 'Message';
          Parent := Result;
//          Alignment := taRightJustify;
//      BiDiMode := bdRightToLeft;
      //Width := Result.Width;
          WordWrap := True;
          BoundsRect := TextRect;
          Caption := Msg;
          BiDiMode := Result.BiDiMode;
          ALeft := HorzMargin * 2 + 32;
//          ALeft := IconTextWidth - TextRect.Right + HorzMargin;
          TextRect.Right := Result.ClientWidth - ALeft; // AJouté
          If UseRightToLeftAlignment Then
            ALeft := Result.ClientWidth - ALeft - Width;
          SetBounds(ALeft, VertMargin,
            TextRect.Right, TextRect.Bottom);
        End;
      If mbYesToAll In Buttons Then DefaultButton := mbYesToAll Else // AJouté
        If mbOk In Buttons Then DefaultButton := mbOk Else
          If mbYes In Buttons Then DefaultButton := mbYes Else
            DefaultButton := mbRetry;
      If DefBtn In Buttons Then DefaultButton := DefBtn ; // AJouté

      If mbNoToAll In Buttons Then CancelButton := mbNoToAll Else // AJouté


        If mbCancel In Buttons Then CancelButton := mbCancel Else
          If mbNo In Buttons Then CancelButton := mbNo Else
         //CancelButton := mbCancel;
            CancelButton := mbOk;
        //DefaultButton := mbRetry;
      X := (ClientWidth - ButtonGroupWidth) Div 2;
      For B := Low(TMsgDlgBtnEx) To High(TMsgDlgBtnEx) Do
        If B In Buttons Then
          With TButton.Create(Result) Do
            Begin
              Name := ButtonNamesEx[B];
              Parent := Result;
              If B >= mbCust1 Then Caption := CustBtnText[B] // AJouté
              Else
                Caption := LoadResString(ButtonCaptionsEx[B]);
              ModalResult := ModalResults[B];
              If B = DefaultButton Then
              Begin
              TabOrder := 0;
              Default := True;
              End;
              If B = CancelButton Then Cancel := True;
              SetBounds(X, IconTextHeight + VertMargin + VertSpacing,
                ButtonWidth, ButtonHeight);
              Inc(X, ButtonWidth + ButtonSpacing);
              If B = mbHelp Then
                OnClick := TMessageFormEx(Result).HelpButtonClick;
            End;
       // on crée la CheckBox
      If ShowCheckBox Then
        With TCheckBox.Create(Result) Do
          Begin
            Result.Height := Result.Height + 16;
            Name := 'DlgCBox';
            parent := Result;
            Caption := BoxTxt;
            SetBounds(8, Result.ClientHeight - 24, BoxTextWidth, 17);
          End;
    End;
End;

Function MessageDlgPosHelpEx(Const Msg: String; DlgType: TMsgDlgTypeEx;
  Buttons: TMsgDlgButtonsEx; HelpCtx: Longint; DefBtn: TMsgDlgBtnEx; X, Y:
    Integer;
  Const HelpFileName: String; ShowCheckBox: Boolean; BoxTxt: String; DlgIcon:
  TIcon; CustBtnText: PCustBtnText): Integer;
Var
  FXMsg             : TForm;
  ModRslt           : Integer;
  BoxCheck,
    LocalPointer    : Boolean;
Begin
  LocalPointer := CustBtnText = Nil;
  BoxCheck := False;
  If LocalPointer Then
    New(CustBtnText);
  With FXMsg Do
    Begin
      If ShowCheckBox Then // Ajout de la CheckBox
        If BoxTxt = '' Then BoxTxt := '&Ne plus afficher ce message';
      FxMsg := CreateMessageDialogEx(Msg, DlgType, Buttons,DefBtn, ShowCheckBox,
        BoxTxt, DlgIcon, CustBtnText^);
      Try
//        Icon.Assign(Application.MainForm.Icon);//**************************
//        Icon := Nil;
        HelpContext := HelpCtx;
        HelpFile := HelpFileName;
        If X >= 0 Then Left := X;
        If Y >= 0 Then Top := Y;
        If (Y < 0) And (X < 0) Then Position := poScreenCenter;
        ModRslt := ShowModal;
        If ModRslt <> mrCancel Then
          If ShowCheckBox Then
            With TCheckBox(FindComponent('DlgCBox')) Do
              BoxCheck := Checked;
        Result := MAKELong(ModRslt, Integer(BoxCheck));
      Finally
        Free;
      End;
    End;
  If LocalPointer Then
    Dispose(CustBtnText);
End;

Function MessageDlgBoxEx(Const Msg: String; DlgType: TMsgDlgTypeEx;
  Buttons: TMsgDlgButtonsEx; HelpCtx: Longint; Const DefBtn: TMsgDlgBtnEx; Const
    ShowBox: Boolean;
  Const BoxTxt: String; Const DlgIcon: TIcon; Const CustBtnText: PCustBtnText):
    Integer;
Begin
  Result := MessageDlgPosHelpEx(Msg, DlgType, Buttons,
    HelpCtx, DefBtn, -1, -1, '', ShowBox, BoxTxt, DlgIcon, CustBtnText);
End;




Function MessageDlgEx(Const Msg: String; DlgType: TMsgDlgTypeEx;
  Buttons: TMsgDlgButtonsEx; HelpCtx: Longint; Const DefBtn: TMsgDlgBtnEx; Const
    DlgIcon: TIcon;
  Const CustBtnText: PCustBtnText): Integer;
Begin
  Result := MessageDlgPosHelpEx(Msg, DlgType, Buttons,
    HelpCtx, DefBtn, -1, -1, '', False, '', DlgIcon, CustBtnText);
End;

Function MsgDlgBox(DlgParam: TMsgDlgParams): Integer;
Var DlgIcon         : TIcon;
  hLib              : THandle;
Begin
  hLib := 0;
  With DlgParam Do
    Begin
    CustCaption := lpszCaption;
      If DlgType <> mtPerso Then
        DlgIcon := Nil
      Else
        Begin
          DlgIcon := TIcon.Create;
          CustCaption := lpszCaption;
          If AnsiSameText(StrRessource, '') Then
            DlgIcon.Handle := LoadIcon(hInstance, 'MAINICON')
          Else
            Begin
              hLib := LoadLibrary(PChar(StrRessource));
              DlgIcon.Handle := LoadIcon(hLib,
                MakeIntResource(IconNbr));
            End;
        End;
      Result := MessageDlgPosHelpEx(lpszText, DlgType, DlgBtn,
        dwContextHelpId, DefaultBtn, -1, -1, '', CheckBox, BoxCaption, DlgIcon,
        @CustBtnText);
    End;
  If DlgIcon <> Nil Then FreeAndNil(DlgIcon);
  If hLib > 0 Then FreeLibrary(hLib);
End;


procedure TMessageFormEx.CreateParams(var Params: TCreateParams);
begin
  Inherited CreateParams(Params);
  With Params Do
    Begin
      //Style := WS_DLGFRAME;             //  WS_Border or     or   WS_EX_DLGMODALFRAME
//      BorderIcons := [biSystemMenu];
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
      If NewStyleControls Then ExStyle := WS_EX_TOPMOST;
    if CheckWin32Version(5, 1) then
    WindowClass.Style := (WindowClass.Style Or
      CS_DROPSHADOW);
    End;
end;

Procedure InitMsgDlgParams(Var MsgDlgParams:TMsgDlgParams);
begin
 MsgDlgParams.CheckBox:=true;
 MsgDlgParams.BoxCaption :='Ne plus afficher ce message';
 MsgDlgParams.StrRessource :='c:\Windows\System32\Shell32.dll';
 MsgDlgParams.lpszText :='';
 MsgDlgParams.lpszCaption :='';
 MsgDlgParams.DlgType :=mtWarning;
 MsgDlgParams.DlgBtn :=[];
 MsgDlgParams.DefaultBtn :=mbOK;
 MsgDlgParams.IconNbr :=19;
 MsgDlgParams.dwContextHelpId :=0;

 MsgDlgParams.CustBtnText[mbCust1]:='';
 MsgDlgParams.CustBtnText[mbCust2]:='';
 MsgDlgParams.CustBtnText[mbCust3]:='';
 MsgDlgParams.CustBtnText[mbCust4]:='';
end;
End.

