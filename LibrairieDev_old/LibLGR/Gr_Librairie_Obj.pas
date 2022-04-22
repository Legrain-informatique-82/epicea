unit Gr_Librairie_Obj;

interface

Uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics,ToolEdit,
     Controls, Dialogs, Forms, Db, DBTables, dbctrls,Registry, Math,

     stdctrls,dbgrids,grids,menus,buttons,RXCtrls,comctrls,
     LibRessourceString,
     Variants,
       Gauges,
     lib_chaine;

Const
  Vrai = True;
  Faux = False;
  mbYesNo = [mbYes, mbNo];
  mbOkIgnore = [mbOk, mbIgnore];
   CDateIll :TDateTime = 401768.00; {= 31/12/2999 }
   CdQuinzaine :Integer = 32;
   CdDizaine :Integer = 33;
   CdDebutMois :Integer = 1;
   CdFinMois :Integer = 31;

   GTInconnu=0;
   GTFieldBoolean=101;
   GTFieldString=102;
   GtFieldInteger=103;
   GTFieldDate=104;
   GTFieldFloat=105;
   GTFieldCurr=106;
   GTEcriture=107;
   GTEdit=2;
   GTStringGrid=3;
   GTDBGrid=4;
   GTGrid=5;
   GTGrGrid=6;
   GTDBEdit=7;
   GTDBRadioGroup=8;
   GTGrDBGrid=9;
   GTLabel=10;
   GTRxDBComboEdit=11;
   GTDBCheckBox=12;
   GTCurrencyEdit=13;
   GTRxLabel=14;
   GTPanel=15;
   GTDateEdit = 16;
   GTInplaceEdit = 17;
   GTGrInplaceEdit = 18;
   GTable=19;
   GTQuery = 20;
   GTDataSource = 21;
   GTPiece = 22;
   GTEcriture_Isa = 23;
   GTColumn = 24;
   GTDBDateEdit=25;
   GTButton=26;
   GTForm=27;
   GTEntreprise=28;
   GTParamUtil=29;
   GTStringList=30;
   GTTimer=31;
   GSimpleDataset=32;
Type

  TTypeTranstypage=record
    retour:boolean;
    valeur:string;
  end;

  TRetourBool=record
    retour:boolean;
    valeur:boolean;
  end;

TCdClasse = (cdJour, cdMois, cdAnnee);

//TListBool = Class(TList)
//
//Private
//   Function GetItems(Index :Integer) :Boolean;
//   Procedure SetItems(Index :Integer; NewValue :Boolean);
//Public
//	Destructor Destroy; override;
//	function Add(Valeur :Boolean): Integer;
//	Procedure Insert(Index: Integer; Valeur :Boolean);
//	procedure Delete(Index: Integer);
//	procedure Clear;
//        property Items[Index: Integer]: Boolean Read GetItems Write SetItems;
//End;

type

 TMessageLGR = record
  MessAffiche:boolean;
  Mess:string;
  GenererException:boolean;
 end;

  TGestMessageLGR =class(TObject)
   private
    FEnregistrement:Boolean;
    FRepertoire:String;
    FFichier:String;
    FModeTrace:Boolean;
    Function LitRepertoire:String;
    Procedure EcritRepertoire(NomRep:String);
    Function LitFichier:String;
    Procedure EcritFichier(NomFichier:String);
    Function LitEnregistrer:Boolean;
    Procedure EcritEnregistrer(Enregistre:Boolean);
    Function LitModeTrace:Boolean;
    Procedure EcritModeTrace(Tracer:Boolean);
   protected

   public
     ModulePrincipal:String;
     Separateur:String;
     constructor Create(Aowner:TComponent);
     destructor Destroy; override;
     Property RepertoireMessage:String Read LitRepertoire write EcritRepertoire;
     Property FichierMessage:String Read LitFichier write EcritFichier;
     Property Enregistrement:Boolean Read LitEnregistrer write EcritEnregistrer;
     Property ModeTrace:Boolean Read LitModeTrace write EcritModeTrace;
     Procedure EnregistreFichier(Texte:String);
     Function CopieContenu_GestMEssageLGR(Source,Dest:TGestMEssageLGR):boolean;


   published


   end;


 TExceptLGR = record
   retour:boolean;
   NumErreur:integer;
   Mess:String;
   NomModule:String;
   NomDossier:string;
   GestMessageLGR:TGestMessageLGR;
  end;


  TExceptLGRJournal = Record
     ExceptLGR:TExceptLGR;
     MaxJournal:Boolean;
     CodeGenere:string;
  end;

ExceptLGR = class(Exception)
   Private
//     FCodeErreur:Integer;
   public
     constructor Create(Msg:String;CodeErreur:Integer;Mess:boolean;AType:TMsgDlgType);overload;
     constructor Create(Msg:String;CodeErreur:Integer;Mess:boolean;AType:TMsgDlgType;var ErreurSaisie:TExceptLGR);overload;
     destructor Destroy; override;
//     Function ECodeErreur:Integer;
//     Property CodeErreur : integer read FCodeErreur write FCodeErreur;
//     procedure creation(msg:String;CodeErreur:Integer);
   end;

TListInteger = Class(TList)

Private
   Function GetItems(Index :Integer) :LongInt;
   Procedure SetItems(Index :Integer; NewValue :LongInt);
Public
	Destructor Destroy; override;

	function Add(Valeur :LongInt): Integer;
	Procedure Insert(Index: Integer; Valeur :LongInt);
	procedure Delete(Index: Integer);
	procedure Clear;
   property Items[Index: Integer]: LongInt Read GetItems Write SetItems;
End;

Procedure InitialiseListView(CleRegistre:string;ListView:TListView;ListeImage:TImageList;CheminIcones:string);
Procedure InitialiseForm(User:string;Form :TForm);
Procedure DestroyListView(CleRegistre:string;ListView:TListView;ListeImage:TImageList;CheminIcones:string);
Procedure DestroyForm(Form :TForm;User:string);
Function RegistreReadString(Registre :TRegistry; Key :String; ValeurDefaut :String) :String;
Function RegistreReadInteger(Registre :TRegistry; Key :String; ValeurDefaut :LongInt) :LongInt;
Function RegistreReadBool(Registre :TRegistry; Key :String; ValeurDefaut :Boolean) :Boolean;
Function Arrondi(Value :real; Decimale :Integer) :real;
//Function Arrondi(Value :currency; Decimale :Integer) :real;
Function ArrondiCentieme(Value : Currency) :Currency;
Function Abs(Value :Variant) :Variant;
Function QueDesChiffres(s :String) :String;
Function EstQueDesChiffres ( s : String ) : boolean;
Function StrToFloat1(Chaine :String) :Double;
Function Empty(Const Value :String) :Boolean;
Function StrToDate1(Const Value :String) :TDateTime;
Function StrToDate2(Const Text :String) :TDateTime;
Function Year(Dt :TDateTime) :Integer;
Function TelephoneA10Chiffre(AncienTel,aPoste :String) :String;
Function AllTrim(Chaine :String) :String;
Function GetStringElement(aString :String; aPos :Integer; cSep :Char) :String;
Function GetValeurList(aList: TStrings; aCle :String) :String;
Function GetMaxJourMois(Mm, Aa :Word):Word;
Function StrToInt1(Text :String) :LongInt;
Function BoolToStr(Value :Boolean) :String;
Function BoolToInt(Value :Boolean) :Integer;
Function BoolToStrEnglish(Value :Boolean) :String;
Function CalculDate(dDate :TDateTime; Plus :Integer; Classe :TcdClasse;
	 JourduMois :LongInt) :TDateTime;
Function iif(Condition :Boolean; Valeur1, Valeur2 :Variant) :Variant;
Function ActiveBouton(Condition : array of Twincontrol):boolean;  //PB
procedure AfficheBulle(Objet : array of Tcontrol ; Page : TForm); //PB
Procedure DetruitBulle (Page : TForm); // PB
//Function ValExiste(Table,Champ : string ; NewValeur : variant):Boolean;
//Function ValExisteDos(Table,Champ : string ; NewValeur : variant):Boolean;
//Function ValExisteProg(Table,Champ : string ; NewValeur : variant):Boolean;
Function Tooltips (page :Tform) :boolean ;
Function CalculDebCol (Grille:TcustomDBGrid;colonne : integer) : integer;
function RecupClassTypeComponent(control:Tcomponent):integer;
function RecupClassTypeObjet(Objet:TObject):integer;
Function EnregEmpty(const Champ:array of const):boolean;
Function IncMaxi(Var i:integer;Max:integer):boolean;
Function ValeurZero(S:string):boolean;
Function RechercheDsTableAnd(Table:TTable;Query:TQuery;Champs,Valeurs:Array of String;ChampRetour:String):string;
Function ValeurDsChamp(Valeur:string):Boolean;
Function EnableWinControl(ListControl : array of Twincontrol;Actif:Boolean):boolean;
Function EnableRxButton(ListButton : array of TGraphicControl;Actif:Boolean):boolean;
Function VisibleControl(ListControl : array of Tcontrol;visible:Boolean):boolean;
Function ReadOnlyWinControl(ListControl : array of TCOntrol;Actif:Boolean):boolean;
Function EnableItemMenu(Listmenu : array of TMenuItem;Actif:Boolean):boolean;
Function VisibleItemMenu(Listmenu : array of TMenuItem;Visible:Boolean):boolean;
Function VisibleItemMenu_SiDejaVisible(Listmenu : array of TMenuItem;Visible:Boolean):boolean;
Function SBDown(ListSB : array of TGraphicControl;Enfonce:Boolean):boolean;
Function SBFontColor(ListSB : array of TGraphicControl;Couleur:TColor):boolean;
Function FormEtat(Form:TForm):integer;
Function FormEtatStr(Form:TForm):String;
Function FormEtatStrToWState(FormEtatStr:String):TWindowState;
Function StrToBool(Valeur:string):TRetourBool;
function VTypeTranstypage(const Valeurs:array of const;TypeValeurs:byte):TTypeTranstypage;
Function SommeListeInt(ListeValeur:TListInteger;IDepart,IFin:Integer):Currency;
procedure TriListeInteger(var Liste:tstringlist);
Function ProtectObjetNil(Objet:array of TObject):Boolean;
procedure LibereObjet(var objet:Tobject;Appelant:Tcomponent=nil);

function AssignListe(ListeSource:Tlist;var ListeDest:Tlist):TExceptLGR;
//function AssignListeEX(ListeSource:Tlist;ListeDest:Tlist;P:Pointer):TExceptLGR;
function AssignStringListeEX(ListeSource:TStringlist;ListeDest:TStringlist):TExceptLGR;
function Min(Val1, Val2 : Currency) : Currency;
function Max(Val1, Val2 : Currency) : Currency;
Function EgaliteMontant(ListeA,ListeB:TStringList):TStringList;

Procedure Initialise_ExceptLGR(var ExceptLGR:TExceptLGR;Obj_GestMessageLGR:TGestMessageLGR=nil);
procedure DisposeTlist(MyList:TList);
procedure DisposeTStringlist(MyList:TStringlist);
procedure Initialise_TStringlist(MyList:Tstringlist;Appelant:Tcomponent=nil;AvecLiberation:boolean=true);
procedure Initialise_TList(MyList:TList;Appelant:Tcomponent=nil;AvecLiberation:boolean=true);

Procedure GestionGauge(Progession:integer;Gauge:TGauge=nil;Maxi:integer=-1;Mini:integer=-1;Titre:string='';Visible:Boolean=true);
function GereDivision(Dividende,Diviseur: Currency; const QuotienDefault: Currency=0): Currency;
function  ConversionTlistToTStringlit(ListeOrg:Tlist;TypeRecord:string):Tstringlist;


function MessageDlg_lgr(Msg:string; MsgDlgType:TMsgDlgType=mtInformation;MsgDlgBtn:TMsgDlgButtons=[]; HelpCtx: Longint=0;DefautFocus:integer=-1):integer;overload;



implementation


uses  LibFichRep,LibDates,LibZoneSaisie,E2_Decl_Records, Windows;


//Function ExceptLGR.ECodeErreur:Integer;
//Begin
//result:=FCodeErreur;
//End;
constructor TGestMEssageLGR.Create(Aowner:TComponent);
Begin
inherited create;
Separateur := ';';
FModeTrace := false;
FEnregistrement := false;
End;

destructor TGestMEssageLGR.Destroy;
Begin
inherited;
End;

Function TGestMEssageLGR.LitRepertoire:String;
var
ParamChoixRep:TParamChoixRep;
ResultChoisirRep:TResultChoisirRep;
Begin
if empty(FRepertoire) then
 begin
  ParamChoixRep.AfficheRepDefDansEdit := true;
  ParamChoixRep.RepDefaut:=ExtractFileDrive(Application.ExeName);
  ParamChoixRep.TitreForm := 'Choisissez un répertoire pour l''enregistrement des messages d''erreurs.';
  ParamChoixRep.TitreDialogRep := 'Choisissez un répertoire pour l''enregistrement des messages d''erreurs.';
  FRepertoire:=ChoisirRepertoire(ParamChoixRep).RepChoisi;
 end;
Result := FRepertoire;
End;

Procedure TGestMEssageLGR.EcritRepertoire(NomRep:String);
Begin
if empty(NomRep) then Showmessage('Le nom du répertoire est vide.');
FRepertoire := NomRep;
if not DirectoryExists(FRepertoire) then
    ForceDirectories(FRepertoire);
End;

Function TGestMEssageLGR.LitFichier:String;
Begin
Result := FFichier;
End;

Procedure TGestMEssageLGR.EcritFichier(NomFichier:String);
Begin
FFichier := NomFichier;
End;

Function TGestMEssageLGR.LitEnregistrer:Boolean;
Begin
Result:= FEnregistrement;
End;


Procedure TGestMEssageLGR.EcritEnregistrer(Enregistre:Boolean);
Begin
// Si ModeTrace est false, on autorise le changement d'enregistrement
// Si modeTrace est true, il est prioritaire sur Enregistrement 
if not FModeTrace then
 begin
  FEnregistrement := Enregistre;
  if not Enregistre then Separateur := ';';
 end;
End;

Procedure TGestMEssageLGR.EnregistreFichier(Texte:String);
Begin
if empty(RepertoireMessage) then RepertoireMessage := ExtractFilePath(Application.ExeName);
if empty(FFichier) then FFichier := 'error.txt';
if empty(Texte) then Texte := 'LGR_TRACE : Erreur Inconnu : '+dateInfos(now).DateStrFormat;
if not DirectoryExists(RepertoireMessage) then
    ForceDirectories(RepertoireMessage);
AjouterFichierTexte(IncludeTrailingPathDelimiter(RepertoireMessage)+FFichier,TExte);
End;

Function TGestMEssageLGR.LitModeTrace:Boolean;
Begin
Result:= FModeTrace;
End;

Procedure TGestMEssageLGR.EcritModeTrace(Tracer:Boolean);
Begin
FModeTrace := Tracer;
FEnregistrement := FModeTrace;
End;

Function TGestMEssageLGR.CopieContenu_GestMEssageLGR(Source,Dest:TGestMEssageLGR):boolean;
Begin
if Source<>nil then
  begin
      if Dest=nil then Dest:=TGestMEssageLGR.Create(application.MainForm);
      Dest.Enregistrement:=Source.Enregistrement;
      Dest.FRepertoire:= Source.FRepertoire;
      Dest.FFichier:=Source.FFichier;
      Dest.ModeTrace:=Source.ModeTrace;
  end;
end;


constructor ExceptLGR.Create(Msg:String;CodeErreur:Integer;Mess:boolean;AType:TMsgDlgType;var ErreurSaisie:TExceptLGR);
var
AtypeTmp:integer;
handleCourant:HWND;
Begin
case Atype of
    mtWarning:AtypeTmp :=MB_ICONWARNING;
    mtError:AtypeTmp :=MB_ICONERROR;
    mtInformation:AtypeTmp :=MB_ICONINFORMATION;
    mtConfirmation:AtypeTmp :=MB_ICONINFORMATION;
    mtCustom:AtypeTmp :=MB_ICONHAND;
    else AtypeTmp :=MB_ICONINFORMATION;
end;
  ErreurSaisie.retour:=false;
  ErreurSaisie.NumErreur:=CodeErreur;
  ErreurSaisie.Mess := Msg;
 // if mess then MessageDlg(Msg,AType,[mbok],0);
handleCourant:=GetActiveWindow;
if(handleCourant=null)then handleCourant:=Application.MainForm.Handle ;
  if mess then MessageBox( handleCourant,Pchar(Msg),'Attention',MB_TASKMODAL+AtypeTmp);

//  if mess then Application.MessageBox( Pchar(Msg),'Attention',MB_TASKMODAL+AtypeTmp);
  if ErreurSaisie.GestMessageLGR <> nil then
   begin
    if ErreurSaisie.GestMessageLGR.Enregistrement then
       ErreurSaisie.GestMessageLGR.EnregistreFichier('LGR_TRACE : '+dateInfos(now).DateStrFormat+
                                                     ErreurSaisie.GestMessageLGR.Separateur+
                                                     HeureInfos(time,'.').HeureStrFormate+
                                                     ErreurSaisie.GestMessageLGR.Separateur+
                                                     'Dossier : '+ErreurSaisie.NomDossier+
                                                     ErreurSaisie.GestMessageLGR.Separateur+
                                                     ErreurSaisie.GestMessageLGR.ModulePrincipal +
                                                     ErreurSaisie.GestMessageLGR.Separateur+
                                                     IntToStr(CodeErreur)+
                                                     ErreurSaisie.GestMessageLGR.Separateur+
                                                     ErreurSaisie.NomModule+
                                                     ErreurSaisie.GestMessageLGR.Separateur +
                                                     ErreurSaisie.Mess+
                                                     RetourChariotSimple);
   end;
End;

constructor ExceptLGR.Create(Msg:String;CodeErreur:Integer;Mess:boolean;AType:TMsgDlgType);
var
AtypeTmp:integer;
handleCourant:HWND;
Begin
case Atype of
    mtWarning:AtypeTmp :=MB_ICONWARNING;
    mtError:AtypeTmp :=MB_ICONERROR;
    mtInformation:AtypeTmp :=MB_ICONINFORMATION;
    mtConfirmation:AtypeTmp :=MB_ICONINFORMATION;
    mtCustom:AtypeTmp :=MB_ICONHAND;
end;//  ErreurSaisie.retour:=false;
//  ErreurSaisie.NumErreur:=CodeErreur;
//  ErreurSaisie.Mess := Msg;
//  if mess then MessageDlg(Msg,AType,[mbok],0);
handleCourant:=GetActiveWindow;
if(handleCourant=null)then handleCourant:=Application.MainForm.Handle ;
  if mess then MessageBox( handleCourant,Pchar(Msg),'Attention',MB_TASKMODAL+AtypeTmp);
  //  if ErreurSaisie.GestMessageLGR <> nil then
//   begin
//    if ErreurSaisie.GestMessageLGR.Enregistrement then
//       ErreurSaisie.GestMessageLGR.EnregistreFichier(ErreurSaisie.GestMessageLGR.ModulePrincipal +
//                                                     ErreurSaisie.GestMessageLGR.Separateur+
//                                                     IntToStr(CodeErreur)+
//                                                     ErreurSaisie.GestMessageLGR.Separateur+
//                                                     ErreurSaisie.NomModule+
//                                                     ErreurSaisie.GestMessageLGR.Separateur +
//                                                     ErreurSaisie.Mess);
//   end;
End;


destructor ExceptLGR.Destroy;
Begin
   Inherited Destroy;
End;

//******************* RecupClassTypeComponent *************************
function RecupClassTypeComponent(control:Tcomponent):integer;
begin
result:=GTInconnu;
if Control <> nil then
   begin
      if control.ClassNameIs('TCustomEdit')then result:=GTEdit;

      if control.ClassNameIs('TBooleanField')then result:=GTFieldBoolean;
      if control.ClassNameIs('TStringField')then result:=GTFieldString;
      if control.ClassNameIs('TIntegerField')then result:=GtFieldInteger;
      if control.ClassNameIs('TFloatField')then result:=GTFieldFloat;
      if control.ClassNameIs('TDateField')then result:=GTFieldDate;
      if control.ClassNameIs('TCurrencyField')then result:=GTFieldCurr;
      if control.ClassNameIs('TEcriture')then result:=GTEcriture;
      if control.ClassNameIs('TStringGrid')then result:=GTStringGrid;
      if control.ClassNameIs('TCustomGrid')then result:=GTGrid;
      if control.ClassNameIs('TCustomDBGrid')then result:=GTDBGrid;

      if control.ClassNameIs('TGrGrid')then result:=GTGrGrid;
      if control.ClassNameIs('TGrDBGrid')then result:=GTGrDBGrid;

      if control.ClassNameIs('TDBEdit')then result:=GTDBEdit;
      if control.ClassNameIs('TDBRadioGroup')then result:=GTDBRadioGroup;
      if control.ClassNameIs('TLabel')then result:=GTLabel;
      if control.ClassNameIs('TRxDBComboEdit')then result:=GTRxDBComboEdit;
      if control.ClassNameIs('TDBCheckBox')then result:=GTDBCheckBox;

      if control.ClassNameIs('TCurrencyEdit')then result:=GTCurrencyEdit;
      if control.ClassNameIs('TEdit')then result:=GTEdit;
      if control.ClassNameIs('TRxLabel')then result:=GTRxLabel;
      if control.ClassNameIs('TPanel')then result:=GTPanel;
      if control.ClassNameIs('TDateEdit')then result:=GTDateEdit;
      if control.ClassNameIs('TInplaceEdit')then result:=GTInplaceEdit;
      if control.ClassNameIs('TGrInplaceEdit')then result:=GTGrInplaceEdit;
      if control.ClassNameIs('TTable')then result:=GTable;
      if control.ClassNameIs('TsimpleDataset')then result:=GSimpleDataset;
      if control.ClassNameIs('TQuery')then result:=GTQuery;
      if control.ClassNameIs('TDataSource')then result:=GTDataSource;
      if control.ClassNameIs('TPiece')then result:=GTPiece;
      if control.ClassNameIs('TEcriture_Isa')then result:=GTEcriture_Isa;
      if control.ClassNameIs('TColumn')then result:=GTColumn;
      if control.ClassNameIs('TDBDateEdit')then result:=GTDBDateEdit;
      if control.ClassNameIs('TButton')then result:=GTButton;
      if control.ClassParent = TForm then result:=GTForm;
      if control.ClassNameIs('TEntreprise')then result:=GTEntreprise;
      if control.ClassNameIs('TParamUtil')then result:=GTParamUtil;
      if control.ClassNameIs('TTimer')then result:=GTTimer;


      //ClassNameIs('TForm')then result:=GTForm;
   end;
end;

//******************* RecupClassTypeObjet *************************
function RecupClassTypeObjet(Objet:TObject):integer;
begin
result:=GTInconnu;
if Objet <> nil then
   begin
      if Objet.ClassNameIs('TEntreprise')then result:=GTEntreprise;
      if Objet.ClassNameIs('TParamUtil')then result:=GTParamUtil;
      if Objet.ClassNameIs('TStringList')then result:=GTStringList;
      if Objet.ClassNameIs('TTable')then result:=GTable;
      if Objet.ClassNameIs('TQuery')then result:=GTQuery;
      if Objet.ClassNameIs('TDataSource')then result:=GTDataSource;
   end;
end;

Function FormEtat(Form:TForm):integer;
begin
result:=0;
case Form.WindowState of
   wsNormal:result:=0;
   wsMinimized:result:=-1 ;
   wsMaximized:result:=1;
end;
end;

Function FormEtatStr(Form:TForm):String;
begin
result:='';
case Form.WindowState of
   wsNormal:result:='wsNormal';
   wsMinimized:result:='wsMinimized';
   wsMaximized:result:='wsMaximized';
end;
end;
Function FormEtatStrToWState(FormEtatStr:String):TWindowState;
begin
result:=wsNormal;
if uppercase(FormEtatStr) = 'WSMINIMIZED' then
 result:=wsMinimized;
if uppercase(FormEtatStr) = 'WSMAXIMIZED' then
 result:=wsMaximized;
end;
//******************************************************************************
Procedure InitialiseListView(CleRegistre:string;ListView:TListView ;ListeImage:TImageList;CheminIcones:string);
var
IndexCle:Integer;
Registre :TRegistry;
StopLecture:Boolean;
NomClePRog:string;
IconeTmp:TIcon;
Begin
Registre:= TRegistry.Create;
IconeTmp:=TIcon.Create;
Registre.RootKey := HKEY_LOCAL_MACHINE;
IndexCle:=2;
StopLecture:=true;
if ListView <> nil
  then NomClePRog:=ListView.Name+'\'
  else NomClePRog:='Erreur_ListeOutils\';

while StopLecture do
   Begin
     try
      with Registre do
        begin
    //         if OpenKey('\SOFTWARE\LGR\Epicea2\' + Form.Name, False) then begin
             Try
              if OpenKey(CleRegistre+NomClePRog+IntTostr(IndexCle-1), False) then
               begin
              ListView.Items.Add.Caption:=REadString('Intitule');
              ListView.Items.Item[ListView.Items.Count-1].SubItems.Text:=REadString('Raccourci');
//              Extr

              ListView.Items.Item[ListView.Items.Count-1].Selected:=ReadBool('Select');
              try
               IconeTmp.LoadFromFile(CheminIcones+'Icone'+IntToStr(IndexCle)+'.Ico');
               ListeImage.AddIcon(IconeTmp);
              except;
               ListeImage.GetIcon(1,IconeTmp);
               ListeImage.AddIcon(IconeTmp);
              end;

              ListView.Items.Item[ListView.Items.Count-1].ImageIndex:=ReadInteger('ImageIndex');
              inc(IndexCle);
              end
              else
              StopLecture :=false;
             except;
             if ListView.Items.Count > IndexCle then
                   ListView.Items.Delete(ListView.Items.Count-1);
              StopLecture:=false;
              IconeTmp.Free;
             end;
        end;
     except;
      StopLecture:=false;
      IconeTmp.Free;
     end;
   End;
IconeTmp.Free;
//r
End;

Procedure InitialiseForm(User:string;Form :TForm);
// Regarde dans la table des registres si des paramètres de position existe
// pour l'écran passé en paramètres
Var
	Registre :TRegistry;
	FLeft, FTop, FWidth, FHeight :LongInt;
        FWState:integer;
Begin
    Showmessage('Faire Changement de Destroy');
  	Registre:= TRegistry.Create;
   try
    with Registre do begin
     RootKey := HKEY_LOCAL_MACHINE;
         Try
          OpenKey('\SOFTWARE\LGR\Epicea2\' + User+ '\' + Form.Name, False);
          FWState:=0;
          FLeft:= ReadInteger('Left');
          FTop:= ReadInteger('Top');
      	  FWidth:= ReadInteger('Width');
          FHeight:= ReadInteger('Height');
          FWState:= ReadInteger('WState');

	  Form.Left:= FLeft;
      	  Form.Top:= FTop;
          if Form.BorderStyle <> bsDialog then
           begin
	    Form.Width:= FWidth;
      	    Form.Height:= FHeight;
           end;

          if ((FWstate=-1) or (FWState=0)) then
             Form.WindowState:=WsNormal
             else
             Form.WindowState:=WsMaximized;
         Except
          Form.Position:=poScreenCenter;
          abort;
         end;
      end;
   finally
     Registre.Free;
   end;
End;

//******************************************************************************
//******************************************************************************
Procedure DestroyListView(CleRegistre:string;ListView:TListView;ListeImage:TImageList;CheminIcones:string);
var
IndexCle:Integer;
Registre :TRegistry;
StopLecture:Boolean;
NomClePRog:string;
IconeTmp:TIcon;
Begin
Registre:= TRegistry.Create;
IconeTmp:=TIcon.Create;

Registre.RootKey := HKEY_LOCAL_MACHINE;
IndexCle:=0;
StopLecture:=true;
if ListView <> nil
  then NomClePRog:=ListView.Name+'\'
  else NomClePRog:='Erreur_ListeOutils\';
Registre.DeleteKey(CleRegistre+NomClePRog);
for IndexCle:=1 to ListView.Items.Count - 1 do
   Begin
      with Registre do
        begin
          Try
           OpenKey(CleRegistre+NomClePRog+IntTostr(IndexCle), True);
           WriteString('Intitule',ListView.Items.Item[IndexCle].Caption);
           WriteInteger('ImageIndex',ListView.Items.Item[IndexCle].ImageIndex);
           WriteBool('Select',ListView.Items.Item[IndexCle].Selected);
           WriteString('Raccourci',ListView.Items.Item[IndexCle].SubItems.Text);//Raccourci du Prog
//           ListeImage.GetIcon(IndexCle+2,IconeTmp);
//           try
//           IconeTmp.SaveToFile(CheminIcones+'Icone'+IntTOstr(IndexCle)+'.Ico');
//           except;
//            ListeImage.GetIcon(1,IconeTmp);
//           IconeTmp.SaveToFile(CheminIcones+'Icone'+IntTOstr(IndexCle)+'.Ico');
//           end;
          except;
           DeleteKey(CleRegistre+NomClePRog);
           IconeTmp.Free;
           abort;
          end;
        end;
   End;
if IconeTmp <> nil then
IconeTmp.Free;
//r
End;

Procedure DestroyForm(Form :TForm;User:string);
// Ecriture de la position de l'écran en cours dans la table des registres
Var
	Registre :TRegistry;
        FWstate:integer;
Begin
Showmessage('Faire Changement de Destroy');
//	if Form.WindowState = wsnormal then Begin
           Registre:= TRegistry.Create;
        try
         with Registre do begin
            RootKey := HKEY_LOCAL_MACHINE;
            OpenKey('\SOFTWARE\LGR\Epicea2\' + User+ '\' + Form.Name, True);
            FWstate:=FormEtat(form);
            case FWstate of
               -1,1: ;
               0:Begin
                  WriteInteger('Left', Form.Left);
                  WriteInteger('Top', Form.Top);
                  WriteInteger('Width', Form.Width);
                  WriteInteger('Height', Form.Height);
                 End;
            end;
            WriteInteger('Wstate',FormEtat(form));
            CloseKey;
         end;
      finally
         Registre.Free;
      end;
//   End;
End;

//******************************************************************************
Function RegistreReadString(Registre :TRegistry; Key :String; ValeurDefaut :String) :String;
// Lit un string dans la table des registres
// Si erreur, retourne ValeurDefaut
Begin
	Try
   	Result:= Registre.ReadString(Key);
   Except
   	Result:= ValeurDefaut;
   End;
End;

//******************************************************************************
Function RegistreReadInteger(Registre :TRegistry; Key :String; ValeurDefaut :LongInt) :LongInt;
// Lit un entier dans la table des registres
// Si erreur, retourne ValeurDefaut
Begin
	Try
   	Result:= Registre.ReadInteger(Key);
   Except
   	Result:= ValeurDefaut;
   End;
End;

//******************************************************************************
Function RegistreReadBool(Registre :TRegistry; Key :String; ValeurDefaut :Boolean) :Boolean;
// Lit un booleen dans la table des registres
// Si erreur, retourne ValeurDefaut
Begin
	Try
   	Result:= Registre.ReadBool(Key);
   Except
   	Result:= ValeurDefaut;
   End;
End;

//******************************************************************************
Function Arrondi(Value :real; Decimale :Integer) :real;
Var
Coef :extended;
valeurTmp:string;
Negatif:boolean;
//format : TFormatSettings;
Begin
    //format.CurrencyDecimals:=2;
    result:=0;
    Negatif:=value<0;
    Coef:= Power(10, Decimale);
    if pos(DecimalSeparator,floattostr(abs(value) * Coef))<>0 then
      begin
        valeurTmp:= FloatToStr(frac(abs(value) * Coef));
        //valeurTmp:= FloatToStrF(frac(abs(value) * Coef),ffGeneral,Decimale,0);
        if strtofloat_lgr(copy(valeurTmp,pos(DecimalSeparator,valeurtmp)+1,1))>=5 then
          begin
            Result:= (int(abs(value) * Coef)+1)/coef;
          end
        else
          Result:= round(abs(value) * Coef)/coef;
      end
    else
      Result:= round(abs(value) * Coef)/coef;
    if negatif then
      result:=result*-1;
end;

//******************************************************************************
Function ArrondiCentieme(Value :Currency) :Currency;
Begin
	Result:= Round(Value * 100) ;
        result:=result/100;
end;


//Function ArrondiCentieme_Extended(Value :extended) :Currency;
//Begin
//	Result:= Round(Value * 100) ;
//        result:=result/100;
//end;


//******************************************************************************
Function Abs(Value :Variant) :Variant;
Begin
	Try
		if (Value <0) then
   			Result:= -Value
	   Else	Result:= Value;
   Except
   	Result:= Value;
   End;
End;


//****************************************************************************
// Accepte que des chiffres et - . si - en premier caractère on ajoute 0 = 0.121
// Si un 1er caractère est un - et le 2ème un . on ajoute 0 entre deux = -0.121
// Si le dernier caractère est un . on l'efface
// Si il y a plus d'un separateur Decimal on efface 0..22 ou 0.2.2 =0.22
// Ex: Edit1.text:= QueDesChiffres(Edit1.text); 18/04/00
//**************************************************************************
Function QueDesChiffres(s :String) :String;
Var i :Integer;
Unpoint:boolean;
Begin
   Result:= '';
try
   Unpoint:=False ;
   if Length(s)=0 then exit;

   if length(s) > 1 then
    begin
     while ((s[1]='0')and(s[2] <> DecimalSeparator)) do
      begin
       if length(s) > 1 then
             if s[2] <> DecimalSeparator then
                 delete(s,1,1);
       if length(s)<=1 then break;
      end;
    end;
   For i:= 1 to Length(s) do
       begin              // Accepte de 0 à 9 et - .
       if (s[i] in ['0'..'9', DecimalSeparator]) or
           ((i = 1) And (s[i] = '-')) then Result:= Result + s[i] ;
       end;
            // Si un 1er caractère est un . on ajoute 0 avant
        if copy(result,1,1)=DecimalSeparator then insert('0',result,1) ;
           // Si un 1er caractère est un - et le 2ème un . on ajoute 0 entre deux -0.2
        if(copy(result,1,1)='-') and (copy(result,2,1)=DecimalSeparator) then insert('0',result,2);
           // Si le dernier caractère est un . on l'efface
        if length(result) > 0 then
        if  (result[Length(result)] = DecimalSeparator) then   Delete(result,Length(result),1);
            // Si il y a plus d'un DecimalSeparator on efface
        for i :=1 to length(result) do
            begin
                if (Unpoint=true) and (result[i]=DecimalSeparator) then delete(result,i,1);
                if (Unpoint=False) and (result[i]=DecimalSeparator) then Unpoint:=true ;
            End;
except;
result:='';
abort;
end;
End;


Function EstQueDesChiffres ( s : String ) : boolean;
// Accepte que des chiffres et - . si - en premier caractère on ajoute 0 = 0.121
// Si un 1er caractère est un - et le 2ème un . on ajoute 0 entre deux = -0.121
// Si le dernier caractère est un . on l'efface
// Si il y a plus d'un separateur Decimal on efface 0..22 ou 0.2.2 =0.22
// Ex: Edit1.text:= QueDesChiffres(Edit1.text); 18/04/00
Var
   i : Integer;
   Value : String;
Begin
   Result := false;
   Value := '';
   if str_Lg ( s ) = 0 then exit;
   For i := 1 to str_lg ( s ) do
      // Accepte de 0 à 9 et - .
      if ( s [ i ] in [ '0' .. '9', DecimalSeparator ] ) or
         ( ( i = 1 ) And ( s [ i ] = '-' ) ) then
         Value := Value + s [ i ];
   // Si un 1er caractère est un . on ajoute 0 avant
   if str_souschaine ( Value, 1, 1 ) = DecimalSeparator then
      insert ( '0', Value, 1 );
   // Si un 1er caractère est un - et le 2ème un . on ajoute 0 entre deux -0.2
   if ( str_souschaine ( Value, 1, 1 ) = '-' ) and ( str_souschaine ( Value, 2, 1 ) = DecimalSeparator ) then
      insert ( '0', Value, 2 );
result:=Value=S;
End;
//******************************************************************************
Function StrToFloat1(Chaine :String) :Double;
Begin
	If Chaine > '' then
	Begin
		try
			Result:= StrToFloat(QueDesChiffres(trim(Chaine)));
		Except
			On E: EInvalidOperation Do result:= 0;
			Else result:= 0;
		End;
	End
	Else result:= 0;

End;

//******************************************************************************
Function StrToDate1(Const Value :String) :TDateTime;
Begin
	If (Value > '') then
	Begin
		try
			Result:= StrToDate(Value);
		Except
         Result:= 0;
		End;
	End
	Else result:= 0;
End;

//******************************************************************************
Function Empty(Const Value : String) :Boolean;
// Retourne vrai si la valeur est vide ou pleine d'espace
Var i :Integer;
Begin
	Result:= True;
	i:= 1;
	While Result And (i <= Length(Value)) Do
	Begin
		Result:= ((Value[i] <= #32) or (Value[i] >= #126));
                if result then result:=(Value[i] <> #128);

		Inc(i);
	End;
End;

//******************************************************************************
Function Year(Dt :TDateTime) :Integer;
Var aa, mm, jj :Word;
Begin
	DecodeDate(dt, aa, mm, jj);
	result:= aa;
End;

//******************************************************************************
Function TelephoneA10Chiffre(AncienTel,aPoste :String):String;
// Transforme un num de tel à 8 chiffres en 10 chiffres avec mise en forme
Var
	l, d, n, p, TypeNumero :Integer;
	Chiffres :Array[1..20] of Char;
	Tel8 :String[12];
Begin
	l:= Length(AncienTel);

	N:= l; p:= 0;
	While (n > 0) And (p < 20) Do
	Begin
		If (AncienTel[n] in ['0'..'9']) Then
		Begin
			Inc(p);
			Chiffres[p]:= AncienTel[n];
		End;
		Dec(n);
	End;

	if (p >=8) then
	Begin
		If (p = 8) Then TypeNumero:= 1
		else Begin
			if (p = 9) then n:= strtoint_lgr(Chiffres[9])
			else if (p = 10) then n:= strtoint_lgr(Chiffres[10] + Chiffres[9])
			else n:= strtoint_lgr(Chiffres[11] + Chiffres[10] + Chiffres[9]);

			If (p = 10) And (n in [1..6, 8]) then TypeNumero:= 3
			Else if ((p = 9) And (Chiffres[9] = '1')) Or ((p = 11) And (n = 161)) then
				TypeNumero:= 2
			Else Begin
				n:= strtoint_lgr(Chiffres[p] + Chiffres[p -1]);
				if (n = 19) then
				Begin
					if (p = 11) and ((n  = 590) or (n  = 594) or (n  = 596)
						or (n  = 262) or (n  = 508) or (n  = 269)) then TypeNumero:= 4
					else 					TypeNumero:= 5
				End
				Else	TypeNumero:= 6;
			End
		End;

		Tel8:= Chiffres[8] + Chiffres[7] + ' ' + Chiffres[6] + Chiffres[5] + ' '
					+ Chiffres[4] + Chiffres[3] + ' ' + Chiffres[2] + Chiffres[1];
	End
	Else TypeNumero:= 6;

	If TypeNumero = 1 then
	Begin
		{Province}
		n:= strtoint_lgr(Chiffres[8] + Chiffres[7]);

		If (n = 9) Then Result:= '06 ' + Tel8
		else If (n = 5) Then Result:= '08 00 ' + Copy(Tel8, 4, 8)
		else If (n = 36) Then
		Begin
			if (Chiffres[8] = '6')And (Chiffres[7] = '3') Then Result:= '08  ' + Tel8
			Else			Result:= '08 ' + Tel8;
		End
		else Begin
			Try
				d:= strtoint_lgr(Copy(aPoste, 1, 2)); {Departement}
			Except
				d:= 0
			End;

			If (d in [75, 78, 91..95])then Result:= '01 ' + Tel8
			Else If (n in [31..33, 35..41, 43, 47, 48, 51, 54, 96..99]) Then Result:= '02 ' + Tel8
			else If (n in [20..29, 44, 60, 80..89]) Then Result:= '03 ' + Tel8
			else If (n in [42, 50, 66..79, 90..95]) Then Result:= '04 ' + Tel8
			else If (n in [34, 45, 46, 49, 53, 55..59, 61..65]) Then Result:= '05 ' + Tel8;
		End;
	End
	{Ile de France }
	Else If (TypeNumero = 2) then Result:= '01 ' + Tel8
	{Numero déjat a 10 chiffres}
	Else If (TypeNumero = 3) then Result:=  Chiffres[10] + Chiffres[9] + ' ' + Tel8
	{DOM}
	Else If (TypeNumero = 4) then Result:=  '0' + Chiffres[9] + ' ' + Tel8
	Else Begin
		{TOM ou Etranger}
		If (TypeNumero = 5) then Result:=  '00' + Copy(AncienTel, 3, l)
		{?}
		else Result:=  AncienTel;
		For n:= 1 to l do If Not (Result[n] in ['0'..'9']) Then Result[n]:= ' ';
	End;
End;

//******************************************************************************
Function AllTrim(Chaine :String) :String;
// Supprime les espaces avant et après une chaine de caractère
Var
	Deb, Fin : Integer;
Begin
	Fin:= Length(Chaine);

	if (Fin > 0) Then
	Begin
		Deb:= 1;

		While  (Chaine[Deb] = ' ') And (Deb <= Fin) Do Inc(Deb);
		While  (Chaine[Fin] = ' ') And (Fin >= 1) Do Dec(Fin);

		Result:= Copy(Chaine, Deb, Fin - Deb +1);
	End
	Else Result:= '';
End;

//******************************************************************************
Function GetStringElement(aString :String; aPos :Integer; cSep :Char) :String;
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
Function GetValeurList(aList: TStrings; aCle :String) :String;
// Sans doute spéciale à Epicéa
Var
	i :Integer;
Begin
	Result:= '';

	For i:= 0 to (aList.Count -1) do
	Begin
		if CompareText(GetStringElement(aList.Strings[i], 1, '='), aCle) = 0 Then
		Begin
			Result:= GetStringElement(aList.Strings[i], 2, '=');
			Break;
		End;
	End;
End;

//******************************************************************************
Function GetMaxJourMois(Mm, Aa :Word):Word;
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
Function StrToInt1(Text :String) :LongInt;
// Gere l'erreur pour StrToInt
Begin
	Try
   	Result:= strtoint(Text);
   Except
   	Result:= 0;
	End;
End;

//******************************************************************************
Function BoolToStr(Value :Boolean) :String;
Begin
	if Value then  Result:= 'Vrai'
   Else				Result:= 'Faux';
End;

Function BoolToInt(Value :Boolean) :Integer;
Begin
	if Value then  Result:= 1
   Else				Result:= 0;
End;

Destructor TListInteger.Destroy;
Begin
	Clear;
   Inherited Destroy;
End;

//******************************************************************************
Function BoolToStrEnglish(Value :Boolean) :String;
Begin
	if Value then  Result:= 'True'
   Else				Result:= 'False';
End;

//******************************************************************************
Function TListInteger.GetItems(Index :Integer) :LongInt;
Var
	i :^LongInt;
Begin
	i:= Inherited Items[Index];
	Result:= i^;
End;

//******************************************************************************
Procedure TListInteger.SetItems(Index :Integer; NewValue :LongInt);
Var
	i :^LongInt;
Begin
	i:= Inherited Items[Index];
   i^:= NewValue;
End;

//******************************************************************************
function TListInteger.Add(Valeur :LongInt): Integer;
Var
	i :^LongInt;
Begin
	New(i);
   i^:= Valeur;
	Result:= Inherited Add(i);
End;

//******************************************************************************
Procedure TListInteger.Insert(Index: Integer; Valeur :LongInt);
Var
	i :^LongInt;
Begin
	New(i);
   i^:= Valeur;
	Inherited Insert(Index, i);
End;

//******************************************************************************
procedure TListInteger.Delete(Index: Integer);
Var
	i :^LongInt;
Begin
	i:= Inherited Items[Index];
   Dispose(i);
	Inherited Delete(Index);
End;

//******************************************************************************
procedure TListInteger.Clear;
Var
	i :^LongInt;
   Index :Integer;
Begin
	for index:= 0 to Count -1 do Begin
		i:= Inherited Items[Index];
   	Dispose(i);
   End;
	Inherited Clear;
End;

//******************************************************************************
Function CalculDate(dDate :TDateTime; Plus :Integer; Classe :TcdClasse;
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
      if mm=0 then mm:=12;
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
      0:Begin
//        ddate:=dec(ddate);
        End;
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
Function StrToDate2(Const Text :String) :TDateTime;
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
Function iif(Condition :Boolean; Valeur1, Valeur2 :Variant) :Variant;
Begin
	if Condition then Result:= Valeur1
   Else Result:= Valeur2;
End;

//*****************************PB***********************************************
//Cette fonction retourne vrai si le tag des composant passé en parametre
// est différent de zero
//**************************************************************************
Function ActiveBouton(Condition : array of Twincontrol):boolean;
var
i:integer;
begin
result:=true;
for I := 0 to High(Condition) do if Condition[i].tag=0 then result:=false;
end;

//*****************************PB***********************************************
Function Tooltips (page :Tform):boolean ;
var
i:integer;
C:TPoint;
rec:TRect;
Aide : THintWindow;
begin
Result:=true;
    for i:=0 to page.ControlCount do
        If (Page.Controls[i] is  TWinControl) then
           begin
             	 Aide:=THintWindow.Create(Page);
                 C:=Page.Controls[i].ClientOrigin;
                 Rec:=Aide.CalcHintRect(length(Page.Controls[i].hint)*5,Page.Controls[i].hint,@(Page.Controls[i].hint));
                 rec.Left:=C.x;
                 Rec.Top:=C.y;
                 Rec.Right:=Rec.Right + C.x;
                 Rec.Bottom:=Rec.Bottom + C.y;
                 Aide.ActivateHint(Rec,Page.Controls[i].hint);
                 aide.Parent:=page;
                 result:=false ;
           end;

end;

procedure AfficheBulle(Objet : array of Tcontrol ; Page : TForm);
 procedure ReccurAfficheBulle(Controle:TControl; Page : TForm);
 var
 i:integer;
 C:TPoint;
 rec:TRect;
 nom:string;
 Aide : THintWindow;
 begin
  i:=0;
  if (controle is TWincontrol) then
   begin
  While i<(controle as TWincontrol).ControlCount do
        begin
            ReccurAfficheBulle((controle as TWincontrol).Controls[i],page);
            inc(i);
        end;
 if (controle as Tcontrol).ShowHint then
     begin
       Aide:=THintWindow.Create(Page);
       C:=controle.ClientOrigin;
       Rec:=Aide.CalcHintRect(length(controle.hint)*5,controle.hint,@(controle.hint));
       rec.Left:=C.x;
       Rec.Top:=C.y;
       Rec.Right:=Rec.Right + C.x;
       Rec.Bottom:=Rec.Bottom + C.y;
       Aide.ActivateHint(Rec,controle.hint);
       aide.Parent:=Page;
     end;

  end;
//  repeat
////  nom:=controle.components[i].Name;
//  if (controle is TWincontrol) then
//   begin
//    if not (controle as TWincontrol).ShowHint then
//     begin
//      if (controle as TWincontrol).ControlCount > 0 then
//            ReccurAfficheBulle((controle as TWincontrol).Controls[1]);
//     end
//    else
//    begin
////for I := 0 to High(Objet) do begin
//       Aide:=THintWindow.Create(Page);
//       C:=controle.ClientOrigin;
//       Rec:=Aide.CalcHintRect(length(controle.hint)*5,controle.hint,@(controle.hint));
//       rec.Left:=C.x;
//       Rec.Top:=C.y;
//       Rec.Right:=Rec.Right + C.x;
//       Rec.Bottom:=Rec.Bottom + C.y;
//       Aide.ActivateHint(Rec,controle.hint);
//       aide.Parent:=Screen.ActiveForm;
//     end;
//  end;
//  inc(i);
//  until i=controle.ComponentCount-1;
// Controle.g

  //
 end;
var
i:integer;
C:TPoint;
rec:TRect;
Aide : THintWindow;
 nom:string;
begin
//screen.com
for i:=page.ControlCount-1 downto 0 do
 Begin
  nom:=page.Controls[i].Name;
  if (page.Controls[i] is TWincontrol) then
  begin
   if (page.Controls[i] as TWincontrol).ShowHint then
    begin
//for I := 0 to High(Objet) do begin
       Aide:=THintWindow.Create(Page);
       C:=page.Controls[i].ClientOrigin;
       Rec:=Aide.CalcHintRect(length(page.Controls[i].hint)*5,page.Controls[i].hint,@(page.Controls[i].hint));
       rec.Left:=C.x;
       Rec.Top:=C.y;
       Rec.Right:=Rec.Right + C.x;
       Rec.Bottom:=Rec.Bottom + C.y;
       Aide.ActivateHint(Rec,page.Controls[i].hint);
       aide.Parent:=page;
     end
     else
//     (page.Controls[i] as TWincontrol).c
     ReccurAfficheBulle(page.Controls[i],page)
   end;
 end;
end;

//*****************************PB***********************************************
Procedure DetruitBulle (Page : TForm);
var
i,nbControl:integer;
Aide : THintWindow;
begin
for i:=page.ControlCount-1 downto 0 do
 Begin
  if (page.Controls[i] is THintWindow) then
   begin
   page.Controls[i].Free;
//   page.Controls[i]:=nil;
 End;

//  for i:=0 to page.ControlCount-1 do
                          //  I:=9;
//     nbControl:= (Page.ControlCount-1);
       //    for i:=Page.ControlCount-1 downto 0 do
//                 while  (Page.Controls[i] is  TWinControl) do
//		     if (page.Controls[i] is THintWindow) then
       //            If (Page.Controls[i] is  TWinControl) then
//                     begin
//                     page.Controls[5].Hint;
//                     page.Controls[i].ShowHint:=false ;
  end;
end;

////*****************************PB***********************************************
//Function ValExiste(Table,Champ : string ; NewValeur : variant):Boolean;
//var
//SearchOptions: TLocateOptions;
//begin
//	with Main.TaId do begin
//	SearchOptions:=[loCaseInsensitive];
//   	IndexFieldNames:=Champ;
//   	TableName:= Table;
//      if not active then Open;
//	result:=Locate(Champ,Newvaleur,SearchOptions);
//      Close;
//   end;
//
//end;
//
////*****************************PB***********************************************
//Function ValExisteDos(Table,Champ : string ; NewValeur : variant):Boolean;
//var
//SearchOptions: TLocateOptions;
//begin
//	with Main.TaIdDos do begin
//		SearchOptions:=[loCaseInsensitive];
//   	IndexFieldNames:=Champ;
//   	TableName:= Table;
//      if not active then Open;
//		result:=Locate(Champ,Newvaleur,SearchOptions);
//      Close;
//   end;
//
//end;
////*****************************PB***********************************************
//Function ValExisteProg(Table,Champ : string ; NewValeur : variant):Boolean;
//var
//SearchOptions: TLocateOptions;
//begin
//	with Main.TaIdProg do begin
//		SearchOptions:=[loCaseInsensitive];
//   	IndexFieldNames:=Champ;
//   	TableName:= Table;
//      if not active then Open;
//		result:=Locate(Champ,Newvaleur,SearchOptions);
//      Close;
//   end;
//end;

Function CalculDebCol (Grille:TcustomDBGrid;colonne : integer) : integer;
Var
   i : integer;
Begin
     Result := 2;
     if (Grille is TCustomDBGrid) then
        with (Grille as TCustomDBGrid) do
             begin
              for  i:=0 to (colonne - 1) do
              begin
//                   result := Result + (Grille as TCustomDBGrid).Columns[i].width
              end;
              Result := Result + Grille.Left + 11;
             end;
End;

Function ValeurZero(S:string):boolean;
var
Aux:Double;
begin
result:=false;
 try
  Aux:=StrToFloat1(S);
  result:=((int(Aux)=0) and (frac(Aux)=0));
 except;
  result:=false;
 end;

end;

// Si un des champs n'est pas vide, retourne vrai
Function EnregEmpty(const Champ:array of const):boolean;
var
i:integer;
begin
result:=false;
for I := 0 to High(Champ) do
  begin
    case Champ[I].VType of
        vtObject:begin
                  if (Champ[I].VObject is TField) then
                     begin
                       result:=not empty(VarTostr(((Champ[I].VObject as TField).Value)));
//                       if not result then
//                          result:=ValeurZero(VarTostr(((Champ[I].VObject as TField).Value)));
//                       if (result and not ValeurZero(VarTostr(((Champ[I].VObject as TField).Value))))
                       if result
                          then exit;
                     end;
                 end;
    end;
  end;
end;

function IncMaxi(Var i:integer;Max:integer):boolean;
Begin
if i < Max then
   Begin
    inc(i);
    result:=true;
   End
   else result:=false;
End;

Function RechercheDsTableAnd(Table:TTable;Query:TQuery;Champs,Valeurs:Array of String;ChampRetour:String):string;
Var
i:integer;
QuRecherche:TQuery;
begin
if ((Table <> nil) and (Query=nil)) then
 begin
 QuRecherche:=TQuery.Create(Application.MainForm);
 QuRecherche.DatabaseName:=Table.DatabaseName;
 QuRecherche.SQL.Clear;
 QuRecherche.SQL.Add('Select ');
 QuRecherche.SQL.Add(Champs[0]);
 for i:= 1 to high(Champs)
    do QuRecherche.SQL.Add(', '+Champs[i]);
 QuRecherche.SQL.Add(' from ');
 QuRecherche.SQL.Add(Table.TableName+' where ');
 QuRecherche.SQL.Add('upper('+Champs[0]+') like(upper(:Valeur0)) ');
 QuRecherche.Params[0].DataType:=Table.findfield(Champs[0]).DataType;
 QuRecherche.ParamByName('Valeur0').AsString:='%'+Valeurs[0]+'%';

 for i:= 1 to high(Champs) do
  Begin
    if not empty(Valeurs[i]) then
       Begin
        QuRecherche.SQL.Add(' and upper('+Champs[i]+') like(upper(:Valeur'+IntToStr(i)+')) ');
        QuRecherche.Params[i].DataType:=Table.findfield(Champs[i]).DataType;
        QuRecherche.ParamByName('Valeur'+inttostr(i)).AsString:='%'+Valeurs[i]+'%';
       End;
  End;
 QuRecherche.SQL.Add(';');
 QuRecherche.Filter:=table.Filter;
 QuRecherche.Filtered:=table.Filtered;
 QuRecherche.Active:=true;
 result:='';
 if Table.Locate(ChampRetour,QuRecherche.FindField(ChampRetour).AsString,[])
    then result:=Table.FindField(ChampRetour).AsString;
 QuRecherche.Close;
 QuRecherche.Free;
 QuRecherche:=nil;
 end;

if ((Table <> nil) and (Query<>nil)) then
 begin
 Query.Close;
 Query.SQL.Clear;
 Query.SQL.Add('Select ');
 Query.SQL.Add(Champs[0]);
 for i:= 1 to high(Champs)
    do QuRecherche.SQL.Add(', '+Champs[i]);
 Query.SQL.Add(' from ');
 Query.SQL.Add(Table.TableName+' where ');
 Query.SQL.Add('upper('+Champs[0]+') like(upper(:Valeur0)) ');
 Query.Params[0].DataType:=Table.findfield(Champs[0]).DataType;
 Query.ParamByName('Valeur0').AsString:='%'+Valeurs[0]+'%';

 for i:= 1 to high(Champs) do
  Begin
    if not empty(Valeurs[i]) then
       Begin
        Query.SQL.Add(' and upper('+Champs[i]+') like(upper(:Valeur'+IntToStr(i)+')) ');
        Query.Params[i].DataType:=Table.findfield(Champs[i]).DataType;
        Query.ParamByName('Valeur'+inttostr(i)).AsString:='%'+Valeurs[i]+'%';
       End;
  End;
 Query.SQL.Add(';');
 Query.Filter:=table.Filter;
 Query.Filtered:=table.Filtered;
 Query.Active:=true;
 end;

End;

//******************************************************************************
Function ValeurDsChamp(Valeur:string):Boolean;
Begin
Result:=((not empty(Valeur)) and (valeur<>'0'));
End;


//******************************************************************************
Function ReadOnlyWinControl(ListControl : array of TCOntrol;Actif:Boolean):boolean;
var
i:integer;
begin
result:=true;
for I := 0 to High(ListControl) do
 begin
 case RecupClassTypeComponent(ListControl[i]) of
    GTEdit:(ListControl[i] as TEdit).ReadOnly:=Actif;
    GTDBEdit:(ListControl[i] as TDBEdit).ReadOnly:=Actif;
    GTDateEdit:(ListControl[i]as TDateEdit).ReadOnly :=Actif;
    GTColumn :TColumn(ListControl[i]).ReadOnly:=Actif;
 end;
 end;
end;

//******************************************************************************
Function EnableWinControl(ListControl : array of Twincontrol;Actif:Boolean):boolean;
var
i:integer;
begin
result:=true;
for I := 0 to High(ListControl) do
 if ListControl[i] <> nil then ListControl[i].Enabled:=Actif;
end;

//******************************************************************************

Function EnableRxButton(ListButton : array of TGraphicControl;Actif:Boolean):boolean;
var
i:integer;
begin
result:=true;
for I := 0 to High(ListButton) do
 if ListButton[i] <> nil then ListButton[i].Enabled:=Actif;
end;



//******************************************************************************
Function VisibleControl(ListControl : array of Tcontrol;visible:Boolean):boolean;
var
i:integer;
begin
result:=true;
for I := 0 to High(ListControl) do
  if ListControl[i] <> nil then ListControl[i].visible:=visible;
end;


//******************************************************************************
Function EnableItemMenu(Listmenu : array of TMenuItem;Actif:Boolean):boolean;
var
i:integer;
begin
result:=true;
for I := 0 to High(Listmenu) do
  if Listmenu[i] <> nil then Listmenu[i].Enabled:=Actif;
end;

//******************************************************************************
Function VisibleItemMenu(Listmenu : array of TMenuItem;Visible:Boolean):boolean;
var
i:integer;
begin
result:=true;
for I := 0 to High(Listmenu) do
  if Listmenu[i] <> nil then
    Listmenu[i].Visible:=Visible;
end;

//******************************************************************************
Function VisibleItemMenu_SiDejaVisible(Listmenu : array of TMenuItem;Visible:Boolean):boolean;
var
i:integer;
begin
result:=true;
for I := 0 to High(Listmenu) do
  if (Listmenu[i] <> nil)and(Listmenu[i].Visible) then
    Listmenu[i].Visible:=Visible;
end;

//******************************************************************************
Function SBDown(ListSB : array of TGraphicControl;Enfonce:Boolean):boolean;
var
i:integer;
begin
result:=true;
if ListSB[0].ClassNameIs('TRxSpeedButton') then
   for I := 0 to High(ListSB) do (ListSB[i] as TRxSpeedButton).Down:=Enfonce;

if ListSB[0].ClassNameIs('TSpeedButton') then
   for I := 0 to High(ListSB) do (ListSB[i] as TSpeedButton).Down:=Enfonce;
end;

Function SBFontColor(ListSB : array of TGraphicControl;Couleur:TColor):boolean;
var
i:integer;
begin
result:=true;
if ListSB[0].ClassNameIs('TRxSpeedButton') then
   for I := 0 to High(ListSB) do (ListSB[i] as TRxSpeedButton).Font.Color:=Couleur;

if ListSB[0].ClassNameIs('TSpeedButton') then
   for I := 0 to High(ListSB) do (ListSB[i] as TSpeedButton).Font.Color:=Couleur;
end;
////******************************************************************************
//Destructor TListBool.Destroy;
//Begin
//	Clear;
//   Inherited Destroy;
//End;
//
//
////******************************************************************************
//Function TListBool.GetItems(Index :Integer) :Boolean;
//Var
//	i :^Boolean;
//Begin
//	i:= Inherited Items[Index];
//	Result:= i^;
//End;
//
////******************************************************************************
//Procedure TListBool.SetItems(Index :Integer; NewValue :Boolean);
//Var
//	i :^Boolean;
//Begin
//	i:= Inherited Items[Index];
//   i^:= NewValue;
//End;
//
////******************************************************************************
//function TListBool.Add(Valeur :Boolean): Integer;
//Var
//	i :^Boolean;
//Begin
//	New(i);
//   i^:= Valeur;
//	Result:= Inherited Add(i);
//End;
//
////******************************************************************************
//Procedure TListBool.Insert(Index: Integer; Valeur :Boolean);
//Var
//	i :^Boolean;
//Begin
//	New(i);
//   i^:= Valeur;
//	Inherited Insert(Index, i);
//End;
//
////******************************************************************************
//procedure TListBool.Delete(Index: Integer);
//Var
//	i :^Boolean;
//Begin
//	i:= Inherited Items[Index];
//   Dispose(i);
//	Inherited Delete(Index);
//End;
//
////******************************************************************************
//procedure TListBool.Clear;
//Var
//	i :^Boolean;
//   Index :Integer;
//Begin
//	for index:= 0 to Count -1 do Begin
//		i:= Inherited Items[Index];
//   	Dispose(i);
//   End;
//	Inherited Clear;
//End;



function VTypeTranstypage(const Valeurs:array of const;TypeValeurs:byte):TTypeTranstypage;
begin
result.retour:=true;
result.valeur:='';
  try
    case TypeValeurs of
      VtInteger:    result.valeur:=inttostr(valeurs[0].VInteger);
      VtBoolean:    result.valeur:=booltostr(valeurs[0].Vboolean);
      VtChar:       result.valeur:=valeurs[0].VChar;
      VtExtended:   result.valeur:=FormatFloat('0.00',(valeurs[0].VExtended^));
      VtString:     result.valeur:=valeurs[0].VString^;
      VtPointer:    result.retour:=false;
      VtPChar:      result.valeur:=valeurs[0].VPChar;
      VtObject:     result.retour:=false;
      VtClass:      result.retour:=false;
      VtWideChar:   result.retour:=false;
      VtPWideChar:  result.retour:=false;
      VtAnsistring: result.valeur:=String(valeurs[0].VAnsiString);
      VtCurrency:   result.valeur:=currtostr(valeurs[0].VCurrency^);
      VtVariant:    result.retour:=false;
   end;
  except
  result.retour:=false;
  result.valeur:='';
  abort;
  end;//fin du try except
end;

Function StrToBool(Valeur:string):TRetourBool;
begin
result.retour:=true;
result.valeur:=false;

  if ((AnsiStrIComp('True',Pchar(valeur))=0)or(AnsiStrIComp('Vrai',PChar(valeur))=0)) then
  result.valeur:=true
   else
     if ((AnsiStrIComp('False',Pchar(valeur))=0)or(AnsiStrIComp('Faux',Pchar(valeur))=0)) then
     result.valeur:=false
      else
      result.retour:=false;
end;

Function SommeListeInt(ListeValeur:TListInteger;IDepart,IFin:Integer):Currency;
var
TypeListe,i:Integer;
Begin
//TypeListe
result:=0;
if ListeValeur.ClassNameIs('TListInteger') then TypeListe:=0;
case TypeListe of
   0:Begin
       for i:=IDepart to IFin do result:=result + ListeValeur.Items[i];
     End;
end;

End;


procedure TriListeInteger(var Liste:tstringlist);
var
i,j,rangExchange:integer;
valeurtmp:real;
Begin
rangExchange:=-1;
 for i:=0 to liste.Count-1 do
    Begin
      valeurtmp:=StrToCurr_lgr(liste.Strings[i]);
        for j:=i+1 to liste.Count-1 do
           Begin
              if valeurtmp<StrToCurr_lgr(liste.Strings[j]) then
                begin
                valeurtmp:=StrToCurr_lgr(liste.Strings[j]);
                rangExchange:=j;
                end;
           End;
    if rangExchange<>-1 then
    liste.exchange(i,rangExchange);
    rangExchange:=-1;
    End;
End;

// Retourne faux si un élément du tableau objet est nil avec un message d'ereur
// Utilisé pour débugger ou pour augmenter les protections
Function ProtectObjetNil(Objet:array of TObject):Boolean;
var
i:integer;
Begin
result:=true;
for i:=0 to high(Objet) do
if Objet[i] = nil then
 begin
  Showmessage(ErrInterne+'Objet[ '+IntToStr(i)+' ] nil');
  result:=false;
  Abort;
 end;
End;


//récupère le contenue d'une liste sans prendre l'adresse de celle-ci
function AssignListe(ListeSource:Tlist;var ListeDest:Tlist):TExceptLGR;
var
i:integer;
Begin
try
Initialise_ExceptLGR(result);
if ListeSource= nil then abort;
if ListeDest= nil then ListeDest:=TList.Create;

   for i:=0 to ListeSource.count-1 do
     ListeDest.Add(ListeSource.Items[i]);
except
   raise ExceptLGR.Create('L"objet source est nil !!!',1,true,mtError,result)
end;
End;



function AssignStringListeEX(ListeSource:TStringlist;ListeDest:TStringlist):TExceptLGR;
var
i:integer;
Begin
try
Initialise_ExceptLGR(result);
//result.retour:=true;
if ListeDest= nil then ListeDest:=TStringlist.Create;
Initialise_TStringlist(ListeDest,nil,false);
if ListeSource= nil then abort;

   for i:=0 to ListeSource.count-1 do
     ListeDest.AddObject(ListeSource.Strings[i],ListeSource.Objects[i]);

except
   raise ExceptLGR.Create('L"objet source est nil !!!',1,true,mtError,result)
end;
End;


procedure LibereObjet(var objet:Tobject;Appelant:Tcomponent);
var
Nom:string;
NomAppelant:string;
Begin
try
  if (objet as Tobject)<>nil then
    if ProtectObjetNil([objet as Tobject]) then
      Begin
         objet.Free;
         objet :=nil;
      End;
except
   try
//   if (objet is TWinControl)then Nom:=TWinControl(objet).Name;
   if Appelant<>nil then NomAppelant:=Appelant.Name;
   Nom:=objet.ClassName;
   except
   end;
   showmessage('Erreur Interne sur LibereObjet : '+Nom +' Appelé par : '+NomAppelant);
   //abort;
end;
End;

function Min(Val1, Val2 : Currency) : Currency;
begin
   if Val1 > Val2 then Result := Val2
   else Result := Val1;
end;

function Max(Val1, Val2 : Currency) : Currency;
begin
   if Val1 > Val2 then Result := Val1
   else Result := Val2;
end;

// Met en vis a vis les index correspondant aux montants de la listeA égaux à ceux de la listeB
Function EgaliteMontant(ListeA,ListeB:TStringList):TStringList;
var
i,j,k:Integer;
ListeIDListeA,ListeIDListeB:TStringList;
ListeIdTmpA,ListeIdTmpB:TStringList;
Debuggage:Boolean;
CurrTmpPourCouple:Currency;
Begin
Result:=TStringList.Create;
result.Clear;
ListeIDListeA:=TStringList.Create;
ListeIDListeA.Clear;
ListeIDListeB:=TStringList.Create;
ListeIDListeB.Clear;

if ListeA = nil then
 begin
  ListeA:=TStringList.Create;
  ListeA.Clear;
 end;
if ListeB = nil then
 begin
  ListeB:=TStringList.Create;
  ListeB.Clear;
 end;

Debuggage:=false;
if Debuggage then
 begin
  ListeA.LoadFromFile(C_RepertoireDebuggage+'ListeA.txt');
  ListeB.LoadFromFile(C_RepertoireDebuggage+'ListeB.txt');
 end;
//Formation des couples dont les montants sont égaux
for i:=0 to ListeA.Count-1 do
begin
  if ListeIDListeA.IndexOf(IntTostr(i)) = -1 then
  begin
    for j:=0 to ListeB.Count-1 do
    begin
     if ListeIDListeB.IndexOf(IntTostr(j)) = -1 then
     begin
       if ListeA.Strings[i] = ListeB.Strings[j] then
        begin
         if Result.IndexOf('A'+IntToStr(i)+';B'+IntToStr(j)+';') = -1 then
           result.Add('A'+IntToStr(i)+';B'+IntToStr(j)+';')
           else
            begin
             MessageDlg('EgaliteMontant : Ajout de doublon interdit. ['+'A'+IntToStr(i)+';B'+IntToStr(j)+';'+']', mtError, [mbOK], 0);
             abort;
            end;
         ListeIDListeA.Add(IntToStr(i));
         ListeIDListeB.Add(IntToStr(j));
         break;
        end;// Fin de : if ListeA.Strings[i] = ListeB.Strings[j] then
     end; // Fin de : if ListeIDListeB.IndexOf(IntTostr(j)) = -1 then
    end;// Fin de : for j:=0 to ListeB.Count-1 do
  end;// Fin de : if ListeIDListeA.IndexOf(ListeA.Strings[j]) <> -1 then
end;

//Formation des couples dont les montants de ListeA sont égaux à une somme de2 éléments de ListeB
ListeIdTmpA:=TStringList.Create;
ListeIdTmpB:=TStringList.Create;

for i:=0 to ListeA.Count-1 do
begin
  if ListeIDListeA.IndexOf(IntTostr(i)) = -1 then
  begin
    for j:=0 to ListeB.Count-2 do
    begin
     if ListeIDListeB.IndexOf(IntTostr(j)) = -1 then
     begin
       if StrToCurr_lgr(ListeA.Strings[i]) > StrToCurr_lgr(ListeB.Strings[j]) then
        begin
          CurrTmpPourCouple:=StrToCurr_lgr(ListeA.Strings[i]) - StrToCurr_lgr(ListeB.Strings[j]);
//          ListeIdTmpB.Add(IntToStr(j));
        end;// Fin de : if StrToCurr_lgr(ListeA.Strings[i]) > StrToCurr_lgr(ListeB.Strings[j]) then
       k:=j;
       Repeat
        inc(k);
       Until ((CurrTmpPourCouple - StrToCurr_lgr(ListeB.Strings[k]) = 0) or (k=(ListeB.Count-1)));
       if (CurrTmpPourCouple - StrToCurr_lgr(ListeB.Strings[k]) = 0) then
        begin
         if Result.IndexOf('A'+IntToStr(i)+';B'+IntToStr(j)+';B'+IntToStr(k)+';') = -1 then
           result.Add('A'+IntToStr(i)+';B'+IntToStr(j)+';B'+IntToStr(k)+';')
           else
            begin
             MessageDlg('EgaliteMontant : Ajout de doublon interdit. ['+'A'+IntToStr(i)+';B'+IntToStr(j)+';B'+IntToStr(k)+';'+']', mtError, [mbOK], 0);
             abort;
            end;
         ListeIDListeA.Add(IntToStr(i));
         ListeIDListeB.Add(IntToStr(j));
         ListeIDListeB.Add(IntToStr(k));
         break;
//          ListeIdTmpB.Add(IntToStr(j));
//          ListeIdTmpB.Add(IntToStr(k));
        end;

     end; // Fin de : if ListeIDListeB.IndexOf(IntTostr(j)) = -1 then
    end;// Fin de : for j:=0 to ListeB.Count-1 do
  end;// Fin de : if ListeIDListeA.IndexOf(ListeA.Strings[j]) <> -1 then
end;

//Formation des couples dont les montants de ListeA sont égaux à une somme de2 éléments de ListeB
ListeIdTmpA:=TStringList.Create;
ListeIdTmpB:=TStringList.Create;

for i:=0 to ListeB.Count-1 do
begin
  if ListeIDListeB.IndexOf(IntTostr(i)) = -1 then
  begin
    for j:=0 to ListeA.Count-2 do
    begin
     if ListeIDListeA.IndexOf(IntTostr(j)) = -1 then
     begin
       if StrToCurr_lgr(ListeB.Strings[i]) > StrToCurr_lgr(ListeA.Strings[j]) then
        begin
          CurrTmpPourCouple:=StrToCurr_lgr(ListeB.Strings[i]) - StrToCurr_lgr(ListeA.Strings[j]);
//          ListeIdTmpB.Add(IntToStr(j));
        end;// Fin de : if StrToCurr_lgr(ListeA.Strings[i]) > StrToCurr_lgr(ListeB.Strings[j]) then
       k:=j;
       Repeat
        inc(k);
       Until ((CurrTmpPourCouple - StrToCurr_lgr(ListeA.Strings[k]) = 0) or (k=(ListeA.Count-1)));
       if (CurrTmpPourCouple - StrToCurr_lgr(ListeA.Strings[k]) = 0) then
        begin
         if Result.IndexOf('A'+IntToStr(j)+';A'+IntToStr(k)+';B'+IntToStr(i)+';') = -1 then
           result.Add('A'+IntToStr(j)+';A'+IntToStr(k)+';B'+IntToStr(i)+';')
           else
            begin
             MessageDlg('EgaliteMontant : Ajout de doublon interdit. ['+'A'+IntToStr(j)+';A'+IntToStr(k)+';B'+IntToStr(i)+';'+']', mtError, [mbOK], 0);
             abort;
            end;
         ListeIDListeB.Add(IntToStr(i));
         ListeIDListeA.Add(IntToStr(j));
         ListeIDListeA.Add(IntToStr(k));
         break;
//          ListeIdTmpB.Add(IntToStr(j));
//          ListeIdTmpB.Add(IntToStr(k));
        end;

     end; // Fin de : if ListeIDListeA.IndexOf(IntTostr(j)) = -1 then
    end;// Fin de : for j:=0 to ListeA.Count-1 do
  end;// Fin de : if ListeIDListeB.IndexOf(ListeB.Strings[j]) <> -1 then
end;

if Debuggage then
 begin
  Result.SaveToFile(C_RepertoireDebuggage+'ListeResult.txt');
  ListeIDListeA.SaveToFile(C_RepertoireDebuggage+'ListeIDListeA.txt');
  ListeIDListeB.SaveToFile(C_RepertoireDebuggage+'ListeIDListeB.txt');
  ListeIdTmpB.SaveToFile(C_RepertoireDebuggage+'ListeIdTmpB.txt');
 end;// Fin de : if Debuggage then

End;


procedure DisposeTlist(MyList:TList);
var
i:integer;
Begin
try
  if MyList<>nil then
  for i:=0 to Mylist.Count-1 do
    if Mylist[i]<>nil then
      dispose(Mylist[i]);
except
   showmessage('Erreur Interne sur DisposeTlist : ');
   //abort;
end;
End;


procedure Initialise_TList(MyList:TList;Appelant:Tcomponent;AvecLiberation:boolean);
var
Nom:string;
NomAppelant:string;
Begin
try
  if MyList<>nil then
    begin
      DisposeTlist(MyList);
      MyList.Clear;
      if AvecLiberation then
        LibereObjet(tobject(MyList),Appelant);
    end;
except
   try
   if Appelant<>nil then NomAppelant:=Appelant.Name;{ isa  le  02/12/04 }
   Nom:=MyList.ClassName;
   except
   end;
  // showmessage('Erreur Interne sur Initialise_TList : ');
   showmessage('Erreur Interne sur Initialise_TList : '+Nom +' Appelé par : '+NomAppelant);
   //abort;
end;
End;


procedure DisposeTStringlist(MyList:TStringlist);
var
i:integer;
nom:string;
Begin
try
  if MyList<>nil then
  for i:=0 to Mylist.Count-1 do
   begin
    if Mylist.Objects[i]<>nil then
      begin
        if(Mylist.Objects[i] is TStringList)then
            DisposeTStringlist(TStringList(Mylist.Objects[i]));
        if Mylist.Objects[i]<>nil then
          begin
              nom:=Mylist.Objects[i].MethodName(Mylist.Objects[i]);
              dispose(Mylist.Objects[i].MethodAddress(nom));
             // Mylist.Objects[i].Free;
              Mylist.Objects[i]:=nil;
          end;
      end;
   end;
except
   showmessage('Erreur Interne sur DisposeTStringlist : ');
   //abort;
end;
End;


procedure Initialise_TStringlist(MyList:Tstringlist;Appelant:Tcomponent;AvecLiberation:boolean);
var
Nom:string;
NomAppelant:string;
Begin
try
  if MyList<>nil then
    begin
      DisposeTStringlist(MyList);
      MyList.Clear;
      if AvecLiberation then
        FreeAndNil(MyList);
        //LibereObjet(tobject(MyList),Appelant);
    end;
except
   try
   if Appelant<>nil then NomAppelant:=Appelant.Name;{ isa  le  02/12/04 }
   Nom:=MyList.ClassName;
   except
   end;
   showmessage('Erreur Interne sur Initialise_TStringlist : '+Nom +' Appelé par : '+NomAppelant);
//   showmessage('Erreur Interne sur Initialise_TStringlist : ');
   //abort;
end;
End;


Procedure Initialise_ExceptLGR(var ExceptLGR:TExceptLGR;Obj_GestMessageLGR:TGestMessageLGR);
begin
ExceptLGR.GestMessageLGR:=nil;
if Obj_GestMessageLGR<>nil then
  begin
    ExceptLGR.GestMessageLGR:=TGestMessageLGR.Create(application.MainForm);
    ExceptLGR.GestMessageLGR.CopieContenu_GestMEssageLGR(Obj_GestMessageLGR,ExceptLGR.GestMessageLGR);
  end;
ExceptLGR.Mess:='';
ExceptLGR.NomDossier:='';
ExceptLGR.NomModule:='';
ExceptLGR.NumErreur:=0;
ExceptLGR.retour:=true;
end;


Procedure GestionGauge(Progession:integer;Gauge:TGauge;Maxi:integer;Mini:integer;Titre:string;Visible:boolean);
begin
  if Gauge<>nil then
    begin
      Gauge.Visible:=Visible;
      if Mini<>-1 then Gauge.MinValue:=Mini;
      if Maxi<>-1 then Gauge.MaxValue:=Maxi;
      if Gauge.Visible then
        Begin
           Gauge.Progress:=Gauge.Progress+Progession;
           if titre<>'' then
             Gauge.text:=Titre;
        end;
    end;
end;



function GereDivision(Dividende,Diviseur: Currency; const QuotienDefault: Currency): Currency;
begin
if Diviseur =0 then result:=QuotienDefault
else
result:=Dividende/diviseur;
end;

function  ConversionTlistToTStringlit(ListeOrg:Tlist;TypeRecord:string):Tstringlist;
var
i:integer;
begin
  try
    result:=Tstringlist.Create;
    result.Clear;
    if TypeRecord = 'TListErreur' then  //si type
      begin
        for i:=0 to ListeOrg.count-1 do
          begin
              with PListErreur(ListeOrg.Items[i])^ do
                result.Add(CompteImmo+';'+currtostr(SoldeImmo)+';'+ComptePlan+';'+currtostr(SoldePlan)+';')
          end;
      end;
  except
    if result<>nil then result.free;
  end;//fin du except
end;




function MessageDlg_lgr(Msg:string; MsgDlgType:TMsgDlgType;MsgDlgBtn:TMsgDlgButtons; HelpCtx: Longint;DefautFocus:integer):integer;
var
MsgDlgType_TMP:integer;
MsgDlgBtn_TMP:integer;
DefautFocus_Tmp:integer;
handleCourant:HWND;
begin
Case MsgDlgType of
  mtWarning:MsgDlgType_TMP:=MB_ICONWARNING;
  mtError:MsgDlgType_TMP:=MB_ICONERROR;
  mtInformation:MsgDlgType_TMP:=MB_ICONINFORMATION;
  mtConfirmation:MsgDlgType_TMP:=MB_ICONQUESTION;
  mtCustom:MsgDlgType_TMP:=MB_ICONHAND;
  else MsgDlgType_TMP:=MB_ICONINFORMATION;
end;//fin du case
// defaut bouton 1
DefautFocus_Tmp:=DefautFocus;
if DefautFocus=-1 then DefautFocus_Tmp:=MB_DEFBUTTON1;
if MsgDlgBtn =[] then MsgDlgBtn_TMP:=MB_OK+DefautFocus_Tmp;
if MsgDlgBtn =[mbYes] then MsgDlgBtn_TMP:=MB_OK+DefautFocus_Tmp;
if MsgDlgBtn =[mbOK] then MsgDlgBtn_TMP:=MB_OK+DefautFocus_Tmp;
if MsgDlgBtn =[mbAbort] then MsgDlgBtn_TMP:=MB_ABORTRETRYIGNORE+DefautFocus_Tmp;
if MsgDlgBtn =[mbAll] then MsgDlgBtn_TMP:=MB_OK+DefautFocus_Tmp;
if MsgDlgBtn =[mbNoToAll] then MsgDlgBtn_TMP:=MB_OK+DefautFocus_Tmp;
if MsgDlgBtn =[mbYesToAll] then MsgDlgBtn_TMP:=MB_OK+DefautFocus_Tmp;
if MsgDlgBtn =[mbHelp] then MsgDlgBtn_TMP:=MB_OK+DefautFocus_Tmp;
if MsgDlgBtn = mbYesNoCancel then MsgDlgBtn_TMP:=MB_YESNOCANCEL+DefautFocus_Tmp;
if MsgDlgBtn = mbYesAllNoAllCancel then MsgDlgBtn_TMP:=MB_YESNOCANCEL+DefautFocus_Tmp;
if MsgDlgBtn = mbOKCancel then MsgDlgBtn_TMP:=MB_YESNOCANCEL+DefautFocus_Tmp;
if MsgDlgBtn = mbAbortRetryIgnore then MsgDlgBtn_TMP:=MB_ABORTRETRYIGNORE+DefautFocus_Tmp;
if MsgDlgBtn = mbAbortIgnore then MsgDlgBtn_TMP:=MB_ABORTRETRYIGNORE+DefautFocus_Tmp;
if MsgDlgBtn =[mbYes,mbno] then MsgDlgBtn_TMP:=MB_YESNO+DefautFocus_Tmp;
// defaut bouton 2
if DefautFocus=-1 then DefautFocus_Tmp:=MB_DEFBUTTON2;
if MsgDlgBtn =[mbNo] then MsgDlgBtn_TMP:=MB_YESNO+DefautFocus_Tmp;
if MsgDlgBtn =[mbCancel] then MsgDlgBtn_TMP:=MB_OKCANCEL+DefautFocus_Tmp;
if MsgDlgBtn =[mbRetry] then MsgDlgBtn_TMP:=MB_ABORTRETRYIGNORE+DefautFocus_Tmp;


// defaut bouton 3
if DefautFocus=-1 then DefautFocus_Tmp:=MB_DEFBUTTON3;
if MsgDlgBtn =[mbIgnore] then MsgDlgBtn_TMP:=MB_ABORTRETRYIGNORE+DefautFocus_Tmp;
// if(Application.Handle = null)then Result:=MessageBoxA(Application.MainForm.Handle,Pchar(Msg),'Attention',MsgDlgType_TMP + MsgDlgBtn_TMP)
// else Result:=Application.MessageBox(Pchar(Msg),'Attention',MsgDlgType_TMP + MsgDlgBtn_TMP);
handleCourant:=GetActiveWindow;
if(handleCourant=null)then handleCourant:=Application.MainForm.Handle ;
Result:=MessageBox(handleCourant,Pchar(Msg),'Attention',MB_TASKMODAL+MsgDlgType_TMP + MsgDlgBtn_TMP);


//Result:=Application.MessageBox(Pchar(Msg),'Attention',MB_TASKMODAL+MsgDlgType_TMP + MsgDlgBtn_TMP);
end;


end.

