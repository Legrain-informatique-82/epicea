unit InputQueryFrm_F;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  LibGestionParamXML,
  StdCtrls,
  Buttons,DMConstantes,
  E2_Decl_Records,
  Gr_Librairie_Obj,
  E2_Librairie_Obj, ExtCtrls, Mask, ToolEdit, CurrEdit;

  Const C_Validate:TSysCharSet=[#45,#95, #48..#57, #65..#90, #97..#122];

type
  TInputQueryFrm = class(TForm)
    LabelErreur: TLabel;
    Panel1: TPanel;
    LaAide: TLabel;
    PaBtn: TPanel;
    BitBtnOk: TBitBtn;
    BitBtnCancel: TBitBtn;
    PaEdits: TPanel;
    DateEdit1: TDateEdit;
    CurrEd: TCurrencyEdit;
    EditInput: TEdit;
    PaLegende: TPanel;
    LabelLegende: TLabel;
    Panel2: TPanel;
    CbInput: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure EditInputChange(Sender: TObject);
    procedure EditInputKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure EditInputKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CurrEdChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DateEdit1AcceptDate(Sender: TObject; var ADate: TDateTime;
      var Action: Boolean);
    procedure DateEdit1Exit(Sender: TObject);
    procedure DateEdit1Change(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CbInputChange(Sender: TObject);
  private
    ParamAffich : TParamAffichCompte;
    ControleIntervalLocale:boolean;
    function GetInput: String;
    function GetInputMAJ: String;
    function GetInputCurr : currency;
    function GetLegende: String;
    function GetMessErreur: String;
    procedure SetInput(const Value: String);
     procedure SetInputMAJ(const Value: String);
    procedure SetInputCurr(const Value: currency);
    procedure SetLegende(const Value: String);
    procedure SetMessErreur(const Value: String);
    function ValidateInput(Value : string):boolean;
    function ValidateCurrEd(Value : currency):boolean;
    function ValidateDateEdit(Value : TDate):boolean;
    function GetParamAffichCompte : TParamAffichCompte;
    procedure SetParamAffichCompte (Value:TParamAffichCompte);
    procedure SetInputDate(const Value: TDAte);
    function GetInputDate:TDate;
    procedure SetInputCombo(const Value: TStringList);
    function GetInputCombo:TStringList;
    { Déclarations privées }
  public
    { Déclarations publiques }
    //property ParamAffichCompte:TParamAffichCompte read GetParamAffichCompte write SetParamAffichCompte;
    property Legende: String read GetLegende write SetLegende;
    property Erreur: String read GetMessErreur write SetMessErreur;
    property Input: String read GetInput write SetInput;
    property InputMAJ: String read GetInputMAJ write SetInputMAJ;
    property InputCurr: currency read GetInputCurr write SetInputCurr;
    property InputDate:TDate read GetInputDate write SetInputDate;
    property InputCombo:TStringList read GetInputCombo write SetInputCombo;
  end;

var
  InputQueryFrm: TInputQueryFrm;
  ValidateLocale : TSysCharSet;
  LongueurLocale : integer;
  ValidateChiffre : boolean;
  UpperCaseLocal:boolean ;
  validateDate:boolean;
  itemCombo:integer;


function MyInputQuery(Owner : TComponent;const _Caption, _Legende : String; var _Input : String;MessageAide:string='';Validate:TSysCharSet=[]; longueur:integer=-1): boolean;
 function MyInputQuery_F1(Owner : TComponent;const _Caption, _Legende : String; var _Input : String;ParamAffichCompte:TParamAffichCompte;MessageAide:String='';Validate:TSysCharSet=[]; longueur:integer=-1): boolean;
function MyInputQuery_Chiffre(Owner : TComponent;const _Caption, _Legende : String; var _Input : String;MessageAide:string='';Validate:TSysCharSet=[];  MinValue:currency=0;MaxValue:currency=0;ControleInterval:boolean=false): boolean;
function MyInputQuery_Date(Owner : TComponent;const _Caption, _Legende : String; var _InputDate : tDate;MessageAide:string;Validate:TSysCharSet): boolean;
function MyInputQuery_Combo(Owner : TComponent; const _Caption, _Legende : String;var _InputOut:string; var _InputIn : TStringList;MessageAide:string;Validate:TSysCharSet; longueur:integer): boolean;
function MyInputQueryMAJ(Owner : TComponent;const _Caption, _Legende : String; var _Input : String;MessageAide:string;Validate:TSysCharSet; longueur:integer): boolean;


implementation
 uses LibChoixCompte, E2_Main, lib_chaine, LibRessourceString,
  LibZoneSaisie;


{$R *.dfm}
 
function MyInputQuery(Owner : TComponent;const _Caption, _Legende : String; var _Input : String;MessageAide:string;Validate:TSysCharSet; longueur:integer): boolean;
begin
  with TInputQueryFrm.Create(Owner) do
  begin
    try
      CurrEd.Visible:=false;
      UpperCaseLocal:=false;
      EditInput.Visible:=true;
      Caption := _Caption;
      Legende := _Legende;
      ValidateChiffre:=false;
      validateDate:=false;
      LongueurLocale := longueur;
      EditInput.MaxLength := longueur;
      if(Validate=[#0])then ValidateLocale := C_Validate
      else ValidateLocale :=Validate;
      Input := _Input;


      LaAide.Caption:=MessageAide;
      InitialiseParamAffichCompte(ParamAffich);
      Result := ShowModal = BitBtnOk.ModalResult;
      if Result then
//        // Récupère la saisie si l'utilisateur confirme sa saisie
//        result:=Input<>EmptyStr;
        _Input := Input;
      // if
    finally
      Destroy;
    end; // try
  end; // with
End; // MyInputQuery


function MyInputQueryMAJ(Owner : TComponent;const _Caption, _Legende : String; var _Input : String;MessageAide:string;Validate:TSysCharSet; longueur:integer): boolean;
begin
  with TInputQueryFrm.Create(Owner) do
  begin
    try
      CurrEd.Visible:=false;
      UpperCaseLocal:=true;
      EditInput.Visible:=true;
      Caption := _Caption;
      Legende := _Legende;
      ValidateChiffre:=false;
      validateDate:=false;
      LongueurLocale := longueur;
      EditInput.MaxLength := longueur;
      if(Validate=[#0])then ValidateLocale := C_Validate
      else ValidateLocale :=Validate;
      InputMAJ := _Input;


      LaAide.Caption:=MessageAide;
      InitialiseParamAffichCompte(ParamAffich);
      Result := ShowModal = BitBtnOk.ModalResult;
      if Result then
//        // Récupère la saisie si l'utilisateur confirme sa saisie
//        result:=Input<>EmptyStr;
        _Input := InputMAJ;
      // if
    finally
      Destroy;
    end; // try
  end; // with
End; // MyInputQuery


function MyInputQuery_Chiffre(Owner : TComponent; const _Caption, _Legende : String; var _Input : String;MessageAide:string;Validate:TSysCharSet; MinValue:currency;MaxValue:currency;ControleInterval:boolean): boolean;
begin
  with TInputQueryFrm.Create(Owner) do
  begin
    try
      CurrEd.Visible:=true;
      EditInput.Visible:=false;
      UpperCaseLocal:=false;
      Caption := _Caption;
      Legende := _Legende;
      ValidateChiffre := true;
      validateDate:=false;
      LongueurLocale := -1;
     // EditInput.MaxLength := longueur;
     ControleIntervalLocale:=ControleInterval;
     CurrEd.MinValue := MinValue;
     CurrEd.MaxValue := MaxValue;
      if(Validate=[#0])then ValidateLocale := C_Validate
      else ValidateLocale :=Validate;
      InputCurr := StrToCurrDef(_Input,0);
      LaAide.Caption:=MessageAide;
      InitialiseParamAffichCompte(ParamAffich);
      Result := ShowModal = BitBtnOk.ModalResult;
      if Result then
        // Récupère la saisie si l'utilisateur confirme sa saisie
        _Input := CurrToStr(InputCurr);
      // if
    finally
      Destroy;
    end; // try
  end; // with
End; // MyInputQuery

function MyInputQuery_Date(Owner : TComponent;const _Caption, _Legende : String; var _InputDate : tDate;MessageAide:string;Validate:TSysCharSet): boolean;
begin
  with TInputQueryFrm.Create(Owner) do
  begin
    try
      CurrEd.Visible:=false;
      EditInput.Visible:=false;
      UpperCaseLocal:=false;
      DateEdit1.Visible:=true;
      Caption := _Caption;
      Legende := _Legende;
      ValidateChiffre := false;
      validateDate:=true;
      if(Validate=[#0])then ValidateLocale := C_Validate
      else ValidateLocale :=Validate;
      InputDate := _InputDate;
      LaAide.Caption:=MessageAide;
      Result := ShowModal = BitBtnOk.ModalResult;
      if Result then
        // Récupère la saisie si l'utilisateur confirme sa saisie
        result:=(InputDate<>null);
        _InputDate := DateEdit1.Date;
      // if
    finally
      Destroy;
    end; // try
  end; // with
End; // MyInputQuery

function MyInputQuery_F1(Owner : TComponent;const _Caption, _Legende : String; var _Input : String;ParamAffichCompte:TParamAffichCompte;MessageAide:string;Validate:TSysCharSet; longueur:integer): boolean;
begin
  with TInputQueryFrm.Create(Owner) do
  begin
    try
      CurrEd.Visible:=false;
      EditInput.Visible:=true;
      UpperCaseLocal:=false;
      Caption := _Caption;
      Legende := _Legende;
      ValidateChiffre := false;
      validateDate:=false;
      LongueurLocale := longueur;
      EditInput.MaxLength := longueur;
      if(Validate=[#0])then ValidateLocale := C_Validate
      else ValidateLocale :=Validate;
      Input := _Input;
      LaAide.Caption:=MessageAide;
      SetParamAffichCompte(ParamAffichCompte);
      Result := ShowModal = BitBtnOk.ModalResult;
      if Result then
        // Récupère la saisie si l'utilisateur confirme sa saisie
        result:=Input<>EmptyStr;
        _Input := Input;
      // if
    finally
      Destroy;
    end; // try
  end; // with
End; // MyInputQuery


function MyInputQuery_Combo(Owner : TComponent; const _Caption, _Legende : String;var _InputOut:string; var _InputIn : TStringList;MessageAide:string;Validate:TSysCharSet; longueur:integer): boolean;
begin
  with TInputQueryFrm.Create(Owner) do
  begin
    try
      CbInput.Visible:=true;
      CurrEd.Visible:=false;
      EditInput.Visible:=false;
      UpperCaseLocal:=false;
      Caption := _Caption;
      Legende := _Legende;
      ValidateChiffre:=false;
      validateDate:=false;
      LongueurLocale := longueur;
      EditInput.MaxLength := longueur;
      if(Validate=[#0])then ValidateLocale := C_Validate
      else ValidateLocale :=Validate;
      InputCombo := _InputIn;
      CbInput.ItemIndex:=0;
      itemCombo:=CbInput.ItemIndex;
      LaAide.Caption:=MessageAide;
      InitialiseParamAffichCompte(ParamAffich);
      Result := ShowModal = BitBtnOk.ModalResult;
      if Result then
        _InputOut := InputCombo.Strings[itemCombo];
    finally
      Destroy;
    end; // try
  end; // with
End; // MyInputQuery

{ TInputQueryFrm }
 
function TInputQueryFrm.GetInput: String;
begin
  Result := EditInput.Text;
end;

function TInputQueryFrm.GetInputMAJ: String;
begin
  Result := UpperCase(EditInput.Text);
end;

function TInputQueryFrm.GetInputCurr: currency;
begin
  Result := CurrEd.value;
end;

function TInputQueryFrm.GetInputDate: TDate;
begin
  Result := dateEdit1.Date;
end;

procedure TInputQueryFrm.SetInputCombo(const Value: TStringList);
var
i:integer;
begin
if(value<>nil)then
begin
CbInput.Items:=Value;
//  for i:=0 to value.Count-1 do
//    CbInput.AddItem(Value.strings[i],nil);
end;
end;


function TInputQueryFrm.GetInputCombo:TStringList;
var
i:integer;
begin
if(CbInput.Items.Count>0)then
begin
    result:=Tstringlist.Create;
    result.AddStrings(CbInput.Items);
end;
 //result.Assign(CbInput);
end;



function TInputQueryFrm.GetLegende: String;
begin
  Result := LabelLegende.Caption;
end;

function TInputQueryFrm.GetParamAffichCompte : TParamAffichCompte;
begin
Result :=ParamAffich;
end;

procedure TInputQueryFrm.SetParamAffichCompte (Value:TParamAffichCompte);
begin
ParamAffich:=Value;
end;

function TInputQueryFrm.GetMessErreur: String;
begin
  Result := LabelErreur.Caption;
end;

procedure TInputQueryFrm.SetInput(const Value: String);
begin
if(ValidateLocale<>[])then ValidateInput(Value);
EditInput.Text := (Value);
end;

procedure TInputQueryFrm.SetInputMAJ(const Value: String);
begin
if(ValidateLocale<>[])then ValidateInput(Value);
EditInput.Text := UpperCase(Value);
end;

procedure TInputQueryFrm.SetInputCurr(const Value: currency);
begin
ValidateCurrEd(Value);
CurrEd.value := Value;
end;

procedure TInputQueryFrm.SetInputDate(const Value: TDAte);
begin
ValidateDateEdit(Value);
DateEdit1.date := Value;
end;

procedure TInputQueryFrm.SetLegende(const Value: String);
 var
nbLigne:integer;
begin
LabelLegende.Caption := Value;
if value<>''then
  begin
    nbLigne:= monSplit(LabelLegende.Caption,RetourChariotSimple).Count-1;
    self.Height:=Self.Height+(18*nbLigne);
  end;
end;

procedure TInputQueryFrm.SetMessErreur(const Value: String);
begin
  LabelErreur.Caption := Value;
end;

procedure TInputQueryFrm.FormCreate(Sender: TObject);
begin
    try
	//LibGestionParamXML.InitialiseForm(E.User,Self);
  Position:=poScreenCenter;
    except
        Position:=poScreenCenter;
    end;
    Legende := '';
end;

function TInputQueryFrm.ValidateInput(Value : string):boolean;
var
str,Mess:String;
I:integer;
begin
  if not validateDate then
  begin
      For I := 1 To Length(Value) Do
        If not(Value[I] in ValidateLocale) Then
      Begin
        str:=str+value[i];
      end;
      if(not (str=EmptyStr))then Mess:='le(s) caractère(s) : '+#10#13+str+#10#13+'ne sont pas autorisés'
        else if(Length(value)>LongueurLocale)and(LongueurLocale<>-1)then Mess:='Vous ne devez pas dépasser '+IntToStr(LongueurLocale)+' caractères'
         else Mess:='';
      if (ValidateChiffre)and(str<>EmptyStr) then
         if not EstQueDesChiffres(Value) then Mess:='Vous ne devez saisir que des chiffres.';
      SetMessErreur(Mess) ;
      BitBtnOk.Enabled:= (Mess=EmptyStr) and (value<>EmptyStr);
      result := Mess=EmptyStr;
  end;
end;


function TInputQueryFrm.ValidateCurrEd(Value : currency):boolean;
var
str,Mess:String;
I:integer;
Continue:boolean;
begin
    if ControleIntervalLocale then
      begin
          if (value<CurrEd.MinValue) then
            Mess:='la valeur doit être comprise entre '+CurrToStr(CurrEd.MinValue)+' et '+CurrToStr(CurrEd.MaxValue)
          else
            if (value>CurrEd.MaxValue) then
              Mess:='la valeur doit être comprise entre '+CurrToStr(CurrEd.MinValue)+' et '+CurrToStr(CurrEd.MaxValue)
            else Mess:='';
      end;
  SetMessErreur(Mess) ;
  BitBtnOk.Enabled:= (Mess=EmptyStr);
  result := Mess=EmptyStr;
end;

function TInputQueryFrm.ValidateDateEdit(Value : TDate):boolean;
var
str,Mess:String;
I:integer;
Continue:boolean;
begin
Mess:='';
if Length(trim(DateEdit1.Text))<8 then mess:=' ';
if (value=null)or(value=0) then mess:=' ';
  SetMessErreur(Mess) ;
  BitBtnOk.Enabled:= (Mess=EmptyStr);
//  or(Length(trim(DateEdit1.Text))>=8);
  result := Mess=EmptyStr;
end;

procedure TInputQueryFrm.EditInputChange(Sender: TObject);
begin
if(ValidateLocale<>[])then ValidateInput(EditInput.Text);
end;

procedure TInputQueryFrm.EditInputKeyPress(Sender: TObject; var Key: Char);
begin
    if (UpperCaseLocal)then
    key:=UpCase(key);
end;

procedure TInputQueryFrm.FormDestroy(Sender: TObject);
begin
  LibGestionParamXML.DestroyForm(Self,E.USer);
  InputQueryFrm:=nil;
end;

procedure TInputQueryFrm.EditInputKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
ResultStrList:TResultStrList;
paramAfficheCompte:TParamAffichCompte;
begin
  if key=VK_F1 then
    begin
        if ParamAffich.Dataset<>nil then
        begin
        paramAfficheCompte:=GetParamAffichCompte;
          ResultStrList:=ChoixCompteAffich(paramAfficheCompte);
          if (ResultStrList.Result)and(ResultStrList.Liste.Count>0) then
            EditInput.Text := ResultStrList.Liste.Strings[ResultStrList.Liste.Count-1];
        end;
    end;
end;




procedure TInputQueryFrm.CurrEdChange(Sender: TObject);
begin
ValidateCurrEd(StrToCurrDef(CurrEd.Text,0));
end;

procedure TInputQueryFrm.FormActivate(Sender: TObject);
begin
if EditInput.Visible then  EditInput.SetFocus
  else if CurrEd.Visible then CurrEd.SetFocus
    else if DateEdit1.Visible then DateEdit1.SetFocus;
Resize;
end;

procedure TInputQueryFrm.DateEdit1AcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
begin
ValidateDateEdit(ADate);
InputDate:=ADate;
end;

procedure TInputQueryFrm.DateEdit1Exit(Sender: TObject);
var
valide:boolean;
InputDateLocale:TDateTime;
begin
valide:=true;
InputDateLocale:=DateEdit1.Date;
DateEdit1AcceptDate(DateEdit1,InputDateLocale,valide);
end;

procedure TInputQueryFrm.DateEdit1Change(Sender: TObject);
begin
ValidateDateEdit(DateEdit1.Date);
end;

procedure TInputQueryFrm.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BitBtnOk,BitBtnCancel],PaBtn,90,0);
end;

procedure TInputQueryFrm.FormResize(Sender: TObject);
begin
PaBtnResize(PaBtn);
WinShape(ActiveControl,main.Shape1,main.shape2,ParamUtil.ContourCouleur);
end;

procedure TInputQueryFrm.CbInputChange(Sender: TObject);
begin
if(CbInput.Items.Count>0)then
  itemCombo:=CbInput.ItemIndex;
end;

end.

