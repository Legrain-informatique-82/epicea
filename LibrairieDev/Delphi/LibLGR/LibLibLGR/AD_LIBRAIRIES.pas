{-----------------------------------------------------------------------------
 Unit Name: AD_Librairie
 Author:    Blanc Philippe
 Purpose:
 History:
-----------------------------------------------------------------------------}
{Description TAG ici la desc}

unit AD_LIBRAIRIES;

interface

uses
 SysUtils,
 Dialogs,
 DateUtils,
 Graphics,
 Windows,
 classes,
 Forms,
 Controls,
 StdCtrls,
 ComCtrls,
 db,
 IBDataBase,
 IBQuery,
 DBGrids,
 IniFiles,
 Variants,
 AppEvnts,
 GrDBGrid,
 LibSQL,
 //ILibSQL,
 Lib_Chaine,
 GR_Librairie_Obj,
 LibZoneSaisie;
 //AD_LibRessourceString;

const
ID_REFRESH = $0001;

type

// TPrometheeControl = class(TObject)
//   Protected
//    FOnDataSetNotifyEvent:TDataSetNotifyEvent;
//    FConnected:Boolean;
//   public
//    constructor Create(AOwner :TComponent);
//    destructor Destroy; override;
//    function connection:boolean;
//    function deconnection:boolean;
//    function Promethee:boolean;
//    function Connected:boolean;
//    procedure BeforeInsert(DataSet: TDataSet);
//    property OnDataSetNotifyEvent:TDataSetNotifyEvent read FOnDataSetNotifyEvent Write FonDataSetNotifyEvent default nil;
////   Property Text;
//  end;

 TModeObjet = (MoConsultation,MoEdition,MoInsertion,MoImportation,MoErreur);

 TMessCtrlLGR = record
  Msg:Integer;
  NomChamp:string;
  NomTable:string;
  NomTableChamp:string;
  Valeur:string;
  Old_Valeur:string;
  ID_Valeur:string;
  CodeErreur:Integer;
  MsgID:string;
  ModeObjet : TModeObjet;
 end;


  PAdresseTraitement = Pointer;


  TAlphaB = 'A'..'Z';
  TEnsembleAlphaB = set of TAlphaB;

  TChiffre = '0'..'9';
  TEnsembleNum = set of TChiffre;

//  TEventCtrlLgr=class(TCustomApplicationEvents)
//   Protected
//   public
//    constructor Create(AOwner :TComponent);
//    destructor Destroy; override;
//  end;

  TLGRControl = class(TControl)
   Protected
   public
   Property Text;
  end;

TLGREdit = class(TCustomEdit)
private

protected

public
 Property Onchange;
published

end;

//TGenCode = class(TObject)
//private
//   FFileName:string;
//   FIniFile:TIniFile;
//protected
//   procedure EcritFileName(Value : string);
//public
//    constructor Create(AOwner :TComponent);
//    destructor Destroy; override;
//    property FileName:string Write EcritFileName;
//    function GenereCode(LastCode,Section:string):String;
//published
//
//end;

TMsgDlgLgr =(MgWarning,MgError,MgInformation,MgConfirmation,MgCustom,MgShowmessage,MgSilencieux,MgIndefini);

TResultMessUtil = record
 Result:Integer;
 Message:string;
end;

TMessUtilisateur = class(TObject)
private
   FFileNameMsg:string;
   FFileNameIDMsg:string;
   FListeMessageMsg:TStringList;
   FListeMessageIDMsg:TStringList;
   FIniFile:TIniFile;
protected
   procedure EcritFileNameMsg(Value : string);
   procedure EcritFileNameIDMsg(Value : string);
public
    constructor Create(AOwner :TComponent);
    destructor Destroy; override;
    property FileNameMsg:string Write EcritFileNameMsg;
    property FileNameIDMsg:string Write EcritFileNameIDMsg;
    function MessageUtil(IDMsg : string;const ParamMess : array of const; MsgDlgBtn:TMsgDlgButtons):TResultMessUtil;
//    property TitreChamp[const NomChamp: string]: String read LitTitreChamp; // Contient la liste des champs ainsi que les valeurs de l'enregistrment courant
published

end;


//{L'objet TBdLgr est l'ancêtre BD qui doit être utilisé lors de la création
//d'objet gérant des tables. TBdLgr permet de disposer d'un objet IBBase
//}
//TBdLgr = class(TObject)
//  private
//    // Créé l'objet base de données ( et sa transaction) dont le nom du fichier
//    // à été affecté à la propriété DataBaseName
//    procedure CreateDataBase(DataBaseName:String);
//    function LitTitreChamp(const Value : string):string;
//  protected
//    // Contient le nom du fichier de base de données
//    FDataBaseName:String;
//    // true si c'est l'objet qui créé son propre objet IBBase et IBTransaction
//    FBaseInterne:Boolean;
//    // Contient l'objet de base de données
//    FIBBase :TIBDataBase;
//    // Contient l'objet transaction liés à la base de donnée
//    FIBTransaction : TIBTransaction;
//    // Contient l'objet table par défaut
//    FIBQuery: TIBQuery;
//    // Contient un DataSource pour utilisation interne
//    FDataSource:TDataSource;
//    //Contient la liste des correspondances Champ=Titre
//    FListeTitre:TStringList;
//    procedure EcritDataBaseName(value : string);
//    function LitDataBaseName: string;
//    procedure EcritDataBase(value : TIBDataBase);
//    function LitDataBase: TIBDataBase;
//    procedure EcritIbQuery(value : TIBQuery);
//    function LitIbQuery: TIBQuery;
////    function LitCoordonnees(Indice: Integer): Longint;
////    procedure EcritCoordonnees(Indice: Integer; Valeur: Longint);
//  public
//    ModeEcran:TModeEcran;
//    ObjetAMettreAJour:TControl;
//    NomTable:string;
//    constructor Create(AOwner :TComponent);
//    destructor Destroy; override;
//    property DataBaseName: string read LitDataBaseName write EcritDataBaseName;
//    property DataBase: TIBDataBase read LitDataBase write EcritDataBase; // Contient le database dans lequel se trouveront les tables sur lesquelles chercher
//    property IBQuery:TIBQuery read LitIBQuery write EcritIBQuery;
//    property TitreChamp[const NomChamp: string]: String read LitTitreChamp; // Contient la liste des champs ainsi que les valeurs de l'enregistrment courant
////    property DataBase: TIBDataBase read FIBBase;
//
//
////    Procedure FormAffiche(var Result:Boolean;Form:TForm);
//  published
//
//end;

// Objet de controle
// Permet d'effectuer un controle au travers d'une requete effectué par les méthodes
// Ctrl_XXXXXXXXX();
// Après avoir créé l'objet, on y affecter le DataBase, sinon ça marche pas

//TExecuteControle = procedure (Mess :string) of object;
TExecuteControle = procedure (Mess :TMessCtrlLGR) of object;

//TCtrlChamp = class(TBdLgr)
//  private
//   FValeurRetour:TFieldList;
//   FListeTableBD:TStringList;
//   FListeIDBD:TStringList;
////   FEventCtrlLgr : TEventCtrlLgr;
////   FExecuteControle:TExecuteControle;
////   FIBQuery: TIBQuery;
//   FAfficheMessage:Boolean;
//   FFichierIni_ID:string;
//  protected
//      procedure GetAllTable_View(Liste:TStrings);
//      procedure EcritFichierIni_ID(value : string);
//      function LitFichierIni_ID: string;
////      procedure EcritDataBase(value : TIBDataBase);
////      function LitDataBase: TIBDataBase;
//      function LitValeurRetour: TFieldList;
//      function LitValRetourByName(const NomChamp:string): TField;
////      procedure AppelCtrlLgr(var Msg: TMsg; var Handled: Boolean);
//      procedure CtrlSaisie(var Message: TMessCtrlLGR);virtual;
//      function ID_TABLE(NomTable:string): string;
//
//  public
//      MessUtilisateur:TMessUtilisateur;
//      constructor Create(AOwner :TComponent);
//      destructor Destroy; override;
//
//      function Ctrl_MontantPositif(Message:TMessCtrlLGR):TExceptLGR;
//      function Ctrl_Date(Message:TMessCtrlLGR):TExceptLGR;
//      function Ctrl_EstNonVide(Message:TMessCtrlLGR):TExceptLGR;
//      function Ctrl_CodePostal(Valeur:String;CodeErreur:Integer;NomChamp:String):TExceptLGR;
//      Function Ctrl_ExisteDansTable(Valeur:String;CodeErreur:Integer;NomTable,NomChamp:String):TExceptLGR;
//      function Ctrl_ExistePasDansTable(Valeur:String;CodeErreur:Integer;NomTable,NomChamp:String):TExceptLGR;
//      Function Ctrl_ExistePasDansTableEx(Valeur,ValeurExclue:String;CodeErreur:Integer;NomTable,NomChamp:String):TExceptLGR;
//
////      property DataBase: TIBDataBase read LitDataBase write EcritDataBase; // Contient le database dans lequel se trouveront les tables sur lesquelles chercher
//      property ValeurRetour : TFieldList read LitValeurRetour; // Contient la liste des champs ainsi que les valeurs de l'enregistrment courant
//      property ValRetourByName[const NomChamp: string]: TField read LitValRetourByName; // Contient la liste des champs ainsi que les valeurs de l'enregistrment courant
//      property AfficheMessage: Boolean read FAfficheMessage write FAfficheMessage; // Si vrai, alors affiche les message d'erreur généré par les fonctions Ctrl_....
//      property FichierIni_ID: string read LitFichierIni_ID write EcritFichierIni_ID;
////      procedure Refresh(var Message: TMessCtrlLGR); message ID_REFRESH;
////      property OnExecuteControle:TExecuteControle read FExecuteControle write FExecuteControle default nil;
//
//  published
//
//end;


TIBQuLgrInsertion = Procedure(DataSet: TDataSet = nil) of object;
TIBQuLgrModification = Procedure(IBQuery:TIBQuery = nil) of object;
TIBQuLgrEnregistrer = Procedure(const IBQuery:array of TIBQuery;Retaining:Boolean= False) of object;
TIBQuLgrAnnuler = Procedure(IBQuery:TIBQuery = nil;Annule:Boolean = true) of object;
TIBQuLgrSupprimer = Procedure(IBQuery:TIBQuery = nil;Supprime:Boolean = true) of object;
TCtrlChampObj = procedure (Valeur,NomChamp:String;TypeSaisie:Integer;ExceptionLGR:ExceptLGR;InfoExceptLGR:TExceptLGR) of object;
TCtrlChampIB = procedure (CCourant:TField;TypeSaisie:Integer;ExceptionLGR:ExceptLGR;InfoExceptLGR:TExceptLGR) of object;

//TIBQuLgr = class(TBdLgr)
//  private
//
//     FModeObjet:TModeObjet;
//     FAutoEdit:Boolean;
//     FIBQuLgrInsertion:TIBQuLgrInsertion;
//     FIBQuLgrModification:TIBQuLgrModification;
//     FIBQuLgrEnregistrer:TIBQuLgrEnregistrer;
//     FIBQuLgrAnnuler:TIBQuLgrAnnuler;
//     FIBQuLgrSupprimer:TIBQuLgrSupprimer;
////     FCtrlChampObj:TCtrlChampObj;
////     FCtrlChampIB:TCtrlChampIB;
//     FChamp_Query : string;
////     FExceptLGR:ExceptLGR;
////     FCtrlChamp:TCtrlChamp;
////     FListeChampValue:TStringList;
////     FCtrlChamp:TCtrlChamp;
//
//     procedure dsFDataSourceStateChange(Sender: TObject);
//     procedure EcritModeObjet(value : TModeObjet);
//     function LitModeObjet: TModeObjet;
//
//     function LitChamp_Query(const NomChamp:string): String;
//     procedure EcritChamp_Query(const NomChamp:string;value : String);
//
//     function LitQuery_Champ_Obj:TStringList;
//
//     function LitChamp_Obj(const NomChamp:string): String;
//     procedure EcritChamp_Obj(const NomChamp:string;value : String);
//
//  protected
//     FListeChampValue:TStringList;
//     Procedure AutoModeEdition(ValOrg, ValNew: variant);
//     property Champ_Query[const NomChamp: string]: string read LitChamp_Query write EcritChamp_Query;
//     property Champ_Obj[const NomChamp: string]: string read LitChamp_Obj write EcritChamp_Obj;
//     property Champ_Obj_Liste:TStringList read LitQuery_Champ_Obj;
//
//  public
//    InfoExceptLGR:TExceptLGR;
//    constructor Create(AOwner :TComponent);
//    destructor Destroy; override;
//    property AutoEdit:boolean read FAutoEdit write FAutoEdit;
//    property ModeObjet:TModeObjet read LitModeObjet write EcritModeObjet;
//    property OnIBQuLgrInsertion:TIBQuLgrInsertion read FIBQuLgrInsertion write FIBQuLgrInsertion default nil;
//    property OnIBQuLgrModification:TIBQuLgrModification read FIBQuLgrModification write FIBQuLgrModification default nil;
//    property OnIBQuLgrEnregistrer:TIBQuLgrEnregistrer read FIBQuLgrEnregistrer write FIBQuLgrEnregistrer default nil;
//    property OnIBQuLgrAnnuler:TIBQuLgrAnnuler read FIBQuLgrAnnuler write FIBQuLgrAnnuler default nil;
//    property OnIBQuLgrSupprimer:TIBQuLgrSupprimer read FIBQuLgrSupprimer write FIBQuLgrSupprimer default nil;
////    property OnCtrlChampObj:TCtrlChampObj read FCtrlChampObj write FCtrlChampObj default nil;
////    property OnCtrlChampIB:TCtrlChampIB read FCtrlChampIB write FCtrlChampIB default nil;
//    procedure EcritChamp_Obj_Query;
//
//    procedure Enregistrer;
//    procedure Supprimer;
//    procedure Modifier;
//    procedure Annuler;
//    procedure Inserer;
////    procedure Refresh(var Message: TMessCtrlLGR); message ID_REFRESH;
//  published
//
//end;
//


//TParamForm = class(TObject)
//  private
//
//  protected
//
//  public
//    FormTop:Integer;
//    FormLeft:Integer;
//    FormCaption:String;
//    FormShowModal:Boolean;
//    FormAAfficher:Boolean;
//    ModeEcran:TModeEcran;
//    ObjetAMettreAJour:TControl;
//    constructor Create(AOwner :TComponent);
//    destructor Destroy; override;
//    Procedure FormAffiche(var Result:Boolean;Form:TForm);
//  published
//
//end;

//TParamDM = class(TObject)
//  private
////    Function PResultatUnique(DataSet:TDataSet):Boolean;
//  protected
//
//  public
//    Str_Cherche:String;
//    NomTableRech:String;
//    NomChampRecherche:String;
//    NomChampResultat:String;
//    ListeChamp:TStringList;
//    ModeDM:TModeEcran;
//    ResultatUnique:Boolean;
//    constructor Create(AOwner :TComponent);
//    destructor Destroy; override;
//  published
//
//end;

TParamUtil = class(TObject)
//  Function InitParam:TPAramUtil;
//  Function InitParamDefaut:TPAramUtil;
//  Procedure EnregistrParamUtil(ParamUtil:TParamUtil);
 Public
  CouleurDBGrid:TVarColorGrid;
//  CouleurPanelCorps:TColor;
//  CouleurPanelTitre:TColor;
//  CouleurBouton:TColor;
//  MonoFenetre:Boolean;
//  AfficheTitre:Boolean;

  ContourCouleur:TColor;
  ShadowColorOn:TColor;
  TextColorOn:TColor;
  ShadowColorOff:TColor;
  TextColorOff:TColor;
  OldScreenWidth:Integer;
  OldScreenHeight:Integer;

  // ParaMetre Issue de la ligne de commande
//  ConstPosition:boolean; // True si le paramètre en ligne : "POSITION"
//  maintenance:Boolean; // True si le parametre en ligne : "Maint"
//  TypeMaintenance:String; // "Maint" ou "MaintS" si les parametres en ligne : "Maint"
//                                        // et "82+Numéro du jour courant "
//  GestionSauvegarde:Boolean; // True si le paramètre en ligne : "BACKUP"
  // Répertoire de Sauvegarde
  RepertoireSauvegarde:String;
  RepertoireApplication:String;
  RepertoireBaseDonnees:String;
  RepertoireFichierIni:String;
  RepertoireFichierBDIni:string;
  RepertoireFichierIDIni:string;
  RepertoireFichierBaseDonnees:String;
  RepertoireLibApplication:String;
  RepertoireImageFond : String;
  RepertoireImageFond2 : String;
  RepertoireAideWeb:String;
  EditFormat:String;
  DisplayFormat:String;
  IdRetourPourFiltre:integer; // est remplie lors d'une sélection dans un écran de référence
                              // appelé par CreationFiltre
  constructor Create(AOwner :TComponent);
  destructor Destroy;override;
 end;

  function MsgNonFini:Boolean;
  Function ValTypeInitForm:Integer;
  Function MsgEtatDsInsert:Boolean;
  Function MsgEtatDsEdit:Boolean;
  Function MsgAbandonDsEdit(Mess:String):Boolean;
  Function MsgAbandonDsInsert(Mess:String):Boolean;
  Function MsgSupprimer(Mess:String):Boolean;
//  Procedure AffecteEventExit(Control : array of TControl; Evenement : TNotifyEvent);overload;
//  Procedure AffecteEventChange(Control : array of TControl; Evenement : TNotifyEvent);overload;
//  Procedure AffecteEventExit(ListControl:TStringList; Evenement : TNotifyEvent);overload;
//  Procedure AffecteEventChange(ListControl:TStringList; Evenement : TNotifyEvent);overload;
//  Function ExisteDansTableau(Control : array of TControl; WinControl : TControl):Boolean;
//  Function GenereCodeDefaut(Prefixe:String;CharCompteur:Char;Compteur,LengthCompteur:integer):String;
//  Function EtatDataSet(DataState:TDataSetState):String;
//  Procedure DBGridEnLectureSeule(DBGrid:TGrDBGrid;LectureSeule:Boolean);
//  Procedure GrDBGridValideInplaEdit(DBGrid:TGrDBGrid);
//  Procedure GrDbGridInitColonne(var GrDbGrille:TGrDbGrid;DataSource:TDataSource;DataSet:TDataSet;ListeColonne,ListeChamp : TStringList;FormatMonnaie,EditFormat:String);overload;
//  procedure VideZoneSaisieTxt(Zsaisie : TStringList);
//  Procedure GrDbGridInitColonneEx(var GrDbGrille:TGrDbGrid;DataSource:TDataSource;DataSet:TDataSet;ListeTitre:TStringList;FormatMonnaie,EditFormat:String);

var

ParamUtil:TParamUtil;
//AssoDon:TBdLgr;
//CtrlChamp:TCtrlChamp;
//GenCode:TGenCode;
//Promethee:TPrometheeControl;
MessUtilisateur:TMessUtilisateur;

implementation

uses LibRessourceString;



//constructor TEventCtrlLgr.Create(AOwner :TComponent);
//Begin
// inherited Create(AOwner);
//End;
//
//destructor TEventCtrlLgr.Destroy;
//Begin
// inherited Destroy;
//End;

//constructor TPrometheeControl.Create(AOwner :TComponent);
//Begin
// inherited Create;
// FConnected := False;
// deconnection;
//// FListeMessage:=TStringList.Create;
//End;
//
//destructor TPrometheeControl.Destroy;
//Begin
//// FListeMessage.Free;
// inherited Destroy;
//End;
//
//function TPrometheeControl.connection:boolean;
//Begin
// FOnDataSetNotifyEvent := nil;
// FConnected := true;
//End;
//
//function TPrometheeControl.deconnection:boolean;
//Begin
//FOnDataSetNotifyEvent := BeforeInsert;
//while @FOnDataSetNotifyEvent = nil do
// begin
//  FOnDataSetNotifyEvent := BeforeInsert;
// end;
// Result:= (@FOnDataSetNotifyEvent <> nil);
// FConnected := False;
//End;
//
//function TPrometheeControl.Promethee:boolean;
//Begin
//if Assigned(FOnDataSetNotifyEvent) then
//  FOnDataSetNotifyEvent(nil);
//End;
//
//function TPrometheeControl.Connected:boolean;
//Begin
//Result:=FConnected;
//End;
//
//
//procedure TPrometheeControl.BeforeInsert(DataSet: TDataSet);
//begin
//MessageDlg('Vous devez être en mode connecté pour utiliser cette '+#13+#10+'fonctionnalité !', mtInformation, [mbOK], 0);
//abort;
//end;

constructor TMessUtilisateur.Create(AOwner :TComponent);
Begin
 inherited Create;
 FListeMessageMsg:=TStringList.Create;
 FListeMessageIDMsg:=TStringList.Create;
End;

destructor TMessUtilisateur.Destroy;
Begin
 FListeMessageMsg.Free;
 FListeMessageIDMsg.Free;
 inherited Destroy;
End;

procedure TMessUtilisateur.EcritFileNameMsg(Value : string);
begin
  FFileNameMsg := Value;
  if not FileExists(FFileNameMsg) then
   Begin
    MessageDlg('TMessUtilisateur : Le fichier ['+FFileNameMsg+'] n''existe pas', mtError, [mbOK], 0);
   End
  else
   begin
    FListeMessageMsg.LoadFromFile(FFileNameMsg);
   end;
End;

procedure TMessUtilisateur.EcritFileNameIDMsg(Value : string);
begin
  FFileNameIDMsg := Value;
  if not FileExists(FFileNameIDMsg) then
   Begin
    MessageDlg('TMessUtilisateur : Le fichier ['+FFileNameIDMsg+'] n''existe pas', mtError, [mbOK], 0);
   End
  else
   begin
    FListeMessageIDMsg.LoadFromFile(FFileNameIDMsg);
   end;
End;

function TMessUtilisateur.MessageUtil(IDMsg : string; const ParamMess : array of const; MsgDlgBtn:TMsgDlgButtons):TResultMessUtil;
var
i:Integer;
ValMessFichier,IndexMess:string;
MsgDlgLgr:TMsgDlgLgr;
Begin
Result.Message := '';
Result.Result:= mrIgnore;
  try
    IndexMess:=FListeMessageIDMsg.Values[IDMsg];
    i:=FListeMessageMsg.IndexOfName(IndexMess);
    ValMessFichier :='TMessUtilisateur.MessageUtil : Message' + IndexMess +' est introuvable dans la liste !';
    if i <> -1 then
      ValMessFichier := FListeMessageMsg.Values[IndexMess];
    ValMessFichier := Format(ValMessFichier,ParamMess);
    Result.Message := ValMessFichier;
    try
      case StrToInt(IndexMess) of
        10000..19999:MsgDlgLgr:=MgWarning;
        20000..29999:MsgDlgLgr:=MgError;
        30000..39999:MsgDlgLgr:=MgInformation;
        40000..49999:MsgDlgLgr:=MgConfirmation;
        50000..59999:MsgDlgLgr:=MgCustom;
        60000..69999:MsgDlgLgr:=MgShowmessage;
        70000..79999:MsgDlgLgr:=MgIndefini;
        80000..89999:MsgDlgLgr:=MgIndefini;
        90000..99999:MsgDlgLgr:=MgSilencieux;
      else MessageDlg('TMessUtilisateur.MessageUtil : Numero de type de message non défini !', mtError, [mbOK], 0);
      end;


      case MsgDlgLgr of
        MgWarning:Result.Result:= MessageDlg(ValMessFichier,mtWarning,MsgDlgBtn,0) ;
        MgError:Result.Result:= MessageDlg(ValMessFichier,mtError,MsgDlgBtn,0) ;
        MgInformation:Result.Result:= MessageDlg(ValMessFichier,mtInformation,MsgDlgBtn,0) ;
        MgConfirmation:Result.Result:= MessageDlg(ValMessFichier,mtConfirmation,MsgDlgBtn,0) ;
        MgCustom:Result.Result:= MessageDlg(ValMessFichier,MtCustom,MsgDlgBtn,0) ;
        MgShowmessage:begin
                       ShowMessageFmt(ValMessFichier,ParamMess);
                       Result.Result:= mrOk;
                      end;
        MgSilencieux:begin
                      Result.Message:=ValMessFichier;
                     end;
      else MessageDlg('TMessUtilisateur.MessageUtil : Type de message non défini !', mtError, [mbOK], 0);
      end;
    except
     MessageDlg('TMessUtilisateur.MessageUtil : Erreur MsgDlgLgr !', mtError, [mbOK], 0);
    end;
  finally

  end;

//
End;


//constructor TGenCode.Create(AOwner :TComponent);
//Begin
// inherited Create;
//End;
//
//destructor TGenCode.Destroy;
//Begin
// inherited Destroy;
//End;
//
//procedure TGenCode.EcritFileName(Value : string);
//begin
//  FFileName := Value;
//  if not FileExists(FFileName) then
//   Begin
//    MessageDlg('Le fichier ['+FFileName+'] n''existe pas', mtError, [mbOK], 0);
//   End
//  else
//   begin
//    FIniFile:=TIniFile.Create(FFileName);
//   end;
//End;
//
//function TGenCode.GenereCode(LastCode,Section:string):String;
//var
//ListeFormatCode:TStringList;
//i,j,CurseurNext,IntTmp:Integer;
//CurValue,StrTmp,DateStr:string;
//CharAlphaB:TEnsembleAlphaB;
//CharNum:TEnsembleNum;
//Retenue:Boolean;
//Begin
//Result:='';
//CurseurNext:=1;
//try
//  try
//   ListeFormatCode:=TStringList.Create;
//   ListeFormatCode.CaseSensitive := False;
//   if not FIniFile.SectionExists(Section) then
//    Section := 'DEFAUT';
//   if FIniFile.SectionExists(Section) then
//    begin
//     FIniFile.ReadSectionValues(Section,ListeFormatCode);
//     for i:=0 to ListeFormatCode.Count - 1 do
//      Begin
////     ShowMessage(ListeFormatCode.Strings[i]);
//        // Récupère la valeur d'une partie fixe du code
////        ShowMessage(ListeFormatCode.Values['FIXE']);
//        if (Pos('FIXE',ListeFormatCode.Names[i]) > 0) then
//        begin
//         try
//           CurValue := 'FIXE';
//           CurValue:=ListeFormatCode.ValueFromIndex[i];
//           Result:=Result + CurValue;
//           CurseurNext := CurseurNext + Length(ListeFormatCode.ValueFromIndex[i]);
//         except
//           MessageDlg('Erreur FormatCode sur la partie [FIXE] ['+CurValue+']', mtWarning, [mbOK], 0);
//         end;
//        end;
//
//        // Calcule la valeur d'une partie incrémentale numérique
//        if (Pos('COMPTEUR',ListeFormatCode.Names[i]) > 0) then
//        begin
//         try
//          CurValue := 'COMPTEUR';
//          CurValue:=ListeFormatCode.ValueFromIndex[i];
//          IntTmp := StrToInt_Lgr(str_souschaine(LastCode,CurseurNext,Length(CurValue)));
//          Inc(IntTmp);
//          CurValue:=StringOfChar('0',Length(CurValue) - Length(str_int2str(IntTmp))) + str_int2str(IntTmp);
//          Result:=Result + CurValue;
//         except
//           MessageDlg('Erreur FormatCode sur la partie [COMPTEUR] ['+CurValue+']', mtWarning, [mbOK], 0);
//         end;
//         CurseurNext := CurseurNext + Length(ListeFormatCode.ValueFromIndex[i]);
//        end;
//
//        if (Pos('DATE',ListeFormatCode.Names[i]) > 0) then
//        begin
//         try
//          CurValue := 'DATE';
//          CurValue:=ListeFormatCode.ValueFromIndex[i];
//          DateStr:='';
//          DateTimeToString(DateStr,CurValue,now);
//
//          Result:=Result + DateStr;
//          except
//            MessageDlg('Erreur FormatCode sur la partie [DATE] ['+CurValue+']', mtWarning, [mbOK], 0);
//          end;
//          CurseurNext := CurseurNext + Length(ListeFormatCode.ValueFromIndex[i]);
//        end;
//
//        // Compteur alphabétique
//        if (Pos('COMPTALPHAB',ListeFormatCode.Names[i]) > 0) then
//        begin
//         try
//          CharAlphaB:=['A'..'Z'];
//          CurValue := 'COMPTALPHAB';
//          CurValue:=ListeFormatCode.ValueFromIndex[i];
//          if Length(CurValue) = 0 then
//           MessageDlg('Erreur 0000 FormatCode sur la partie [COMPTALPHAB] ['+CurValue+']', mtWarning, [mbOK], 0);
//          StrTmp:=str_souschaine(LastCode,CurseurNext,Length(CurValue));
//          if Length(StrTmp) = 0 then
//           begin
//            StrTmp:=CurValue;
//           end
//          else
//           begin
//            Retenue:=True;
//            for j:=Length(CurValue) downto 1 do
//             begin
//               if (StrTmp[j] in CharAlphaB) then
//                begin
//                 if Retenue then Inc(StrTmp[j]);
//                 Retenue:=not (StrTmp[j] in CharAlphaB);
//                 if Retenue then StrTmp[j] := 'A';
//                end;
//             end;
//           end;
//          Result:=Result + StrTmp;
//         except
//           MessageDlg('Erreur FormatCode sur la partie [COMPTALPHAB] ['+CurValue+']', mtWarning, [mbOK], 0);
//         end;
//         CurseurNext := CurseurNext + Length(ListeFormatCode.ValueFromIndex[i]);
//        end;
//
//        // Compteur alphanumérique
//        if (Pos('COMPTALPHAN',ListeFormatCode.Names[i]) > 0) then
//        begin
//         try
//          CharAlphaB:=['A'..'Z'];
//          CharNum:=['0'..'9'];
//          CurValue := 'COMPTALPHAN';
//          CurValue:=ListeFormatCode.ValueFromIndex[i];
//          if Length(CurValue) = 0 then
//           MessageDlg('Erreur 0000 FormatCode sur la partie [COMPTALPHAN] ['+CurValue+']', mtWarning, [mbOK], 0);
//          StrTmp:=str_souschaine(LastCode,CurseurNext,Length(CurValue));
//          if Length(StrTmp) = 0 then
//           begin
//            StrTmp:=CurValue;
//           end
//          else
//           begin
//            Retenue:=True;
//            for j:=Length(CurValue) downto 1 do
//             begin
//
//               // Traitement des numériques
//               if (StrTmp[j] in CharNum) then
//                begin
//                 if Retenue then Inc(StrTmp[j]);
//                 Retenue:=not (StrTmp[j] in CharNum);
//                 if Retenue then
//                  begin
//                    StrTmp[j] := 'A';
//                  end;
//                 Retenue:=false;
//                 Continue;
//                end;
//
//               // Traitement des lettres
//               if (StrTmp[j] in CharAlphaB) then
//                begin
//                 if Retenue then Inc(StrTmp[j]);
//                 Retenue:=not (StrTmp[j] in CharAlphaB);
//                 if Retenue then StrTmp[j] := '0';
//                end;
//
//             end;
//           end;
//          Result:=Result + StrTmp;
//         except
//           MessageDlg('Erreur FormatCode sur la partie [COMPTALPHAN] ['+CurValue+']', mtWarning, [mbOK], 0);
//         end;
//         CurseurNext := CurseurNext + Length(ListeFormatCode.ValueFromIndex[i]);
//        end;
//      End;
//
////      ShowMessage(IntToStr(FIniFile.ReadInteger('FORMAT','FIXE',2)));
//    end;
//  except
//
//  end;
//finally
// ListeFormatCode.Free;
//// MessageDlg(Result, mtInformation, [mbOK], 0);
//end;
//
////
//End;



//constructor TCtrlChamp.Create(AOwner :TComponent);
//Begin
// inherited create(AOwner);
// FIBQuery:= TIBQuery.Create(AOwner);
// FListeTableBD:=TStringList.Create;
// FListeIDBD:=TStringList.Create;
//// FEventCtrlLgr:=TEventCtrlLgr.Create(AOwner);
//// FEventCtrlLgr.OnMessage:=AppelCtrlLgr;
//// FIBQuery.Database := FIBBase;
//// FIBQuery.Transaction := FIBTransaction;
// FAfficheMessage:=true;
//End;
//
//destructor TCtrlChamp.Destroy;
//Begin
//// if FIBQuery <> nil then
////  begin
////   FIBQuery.Close;
////   FIBQuery.Free;
////  end;
//// FIBQuery := nil;
// FListeTableBD.Free;
// FListeIDBD.Free;
// inherited Destroy;
//End;
//
////procedure TCtrlChamp.AppelCtrlLgr(var Msg: TMsg; var Handled: Boolean);
////Begin
////case Msg.message of
////  100..101:MessageDlg('message AppelCtrlLgr 100 101', mtWarning, [mbOK], 0);
////  102..103:MessageDlg('message AppelCtrlLgr 102 103', mtWarning, [mbOK], 0);
////else ;
////end;
//
////if Msg.message = 100 then
//// MessageDlg('message AppelCtrlLgr', mtWarning, [mbOK], 0);
////End;
//
//
//// Attention, ne pas appeler cette procédure lors de la construction
//// d'une requete portant sur FIBQuery
//// Construit la liste des table et vues d'une base DB
//procedure TCtrlChamp.GetAllTable_View(Liste:TStrings);
//var
//i:Integer;
//Begin
////SELECT rdb$relation_name FROM RDB$relations
////where rdb$relation_name not like('%$%')
// FIBQuery.Close;
// FIBQuery.SQL.Clear;
// FIBQuery.SQL.Add('SELECT rdb$relation_name FROM RDB$relations ');
// FIBQuery.SQL.Add(' where rdb$relation_name not like(''%$%'') ');
// FIBQuery.Open;
// FListeTableBD:=ChampTableVersListe('rdb$relation_name',FIBQuery);
// for i:=0 to FListeTableBD.Count -1 do
//     FListeTableBD.Strings[i]:=str_supprespaces(FListeTableBD.Strings[i]);
// Liste:=ChampTableVersListe('rdb$relation_name',FIBQuery);
// for i:=0 to Liste.Count -1 do
//     Liste.Strings[i]:=str_supprespaces(Liste.Strings[i]);
//
//End;
//
//
//procedure TCtrlChamp.EcritFichierIni_ID(value : string);
//var
//TmpCursor : TCursor;
//Begin
//try
//  TmpCursor :=Screen.Cursor;
//  Screen.Cursor := crSQLWait;
//  try
//    if not fileExists(value) then
//     Begin
//      MessageDlg('Le fichier IDBD.ini '+value+' est inexistant', mtError, [mbOK], 0);
//      abort;
//     end
//     else
//     begin
//      FFichierIni_ID := Value;
//      FListeIDBD.LoadFromFile(FFichierIni_ID);
//      GetAllTable_View(nil);
////      FIBBase.GetTableNames(FListeTableBD);
////      AfficheInfoObjet('',FListeTableBD,True);
//     end;
//  except
//   FFichierIni_ID := '';
//   abort;
//  end;
//finally
//  Screen.Cursor := TmpCursor;
//end;
//End;
//
//function TCtrlChamp.LitFichierIni_ID: string;
//Begin
//result := FFichierIni_ID;
//End;
//
//function TCtrlChamp.ID_TABLE(NomTable:string): string;
//Begin
//Result:=C_STR_VIDE;
//if FListeIDBD.Count = 0 then
// MessageDlg('Attention, la liste des identifiants de table est vide.', mtWarning, [mbOK], 0);
//ProtectObjetNil([FIBBase,FListeIDBD]);
//if FListeTableBD.IndexOf(NomTable) <> - 1 then
// begin
//  if FListeIDBD.IndexOfName(NomTable) <> -1 then
//   begin
//    Result:=FListeIDBD.Values[NomTable];
//   end
//  else
//   begin
//    MessageDlg('Attention, la table ['+NomTable+'] est introuvable dans la liste FListeIDBD.', mtWarning, [mbOK], 0);
//   end;
// end
//else
// begin
//  MessageDlg('Attention, la table ['+NomTable+'] est introuvable dans la liste FListeTableBD.', mtWarning, [mbOK], 0);
// end;
//End;
//
//
//
//function TCtrlChamp.LitValeurRetour: TFieldList;
//Begin
// result := FValeurRetour;
//End;
//
//function TCtrlChamp.LitValRetourByName(const NomChamp:string): TField;
//Begin
//Result := FValeurRetour[CtrlChamp.ValeurRetour.IndexOf(NomChamp)];
//End;
//
//Function TCtrlChamp.Ctrl_MontantPositif(Message:TMessCtrlLGR):TExceptLGR;
//var
//CurrTmp:Currency;
//Begin
//  try
//   CurrTmp:=StrToCurr(Message.Valeur);
//   if CurrTmp <= 0 then abort;
//  except
//   raise ExceptLGR.Create(C_MONTANT_POSITIF+C_STR_SAUT_DEUX+Message.Valeur,Message.CodeErreur,FAfficheMessage,mtError,result);
//  end;
//End;
//
//
//Function TCtrlChamp.Ctrl_Date(Message:TMessCtrlLGR):TExceptLGR;
//Begin
//  try
//   StrToDate_Lgr(Message.Valeur,date)
//  except
//   raise ExceptLGR.Create(C_DATE_MAL_SAISIE+C_STR_SAUT_DEUX+Message.Valeur,Message.CodeErreur,FAfficheMessage,mtError,result);
//  end;
//End;
//
//Function TCtrlChamp.Ctrl_EstNonVide(Message:TMessCtrlLGR):TExceptLGR;
//var
//StrMess:string;
//Begin
// if str_Empty(Message.Valeur) then
// begin
//   StrMess:='Le champ '+TitreChamp[Message.NomTable+'.'+Message.NomChamp]+' est vide.'+C_STR_SAUT_DEUX+C_CHAMP_NON_VIDE;
//   if MessUtilisateur <> nil then
//    StrMess:=MessUtilisateur.MessageUtil(Message.MsgID,[TitreChamp[Message.NomTable+'.'+Message.NomChamp]],[mbOK]).Message;
//   raise ExceptLGR.Create(StrMess,Message.CodeErreur,FAfficheMessage,mtError,result);
// end;
//End;
//
//Function TCtrlChamp.Ctrl_CodePostal(Valeur:String;CodeErreur:Integer;NomChamp:String):TExceptLGR;
//Begin
// if not Str_Ctrl_CodePostal(Valeur) then
//   raise ExceptLGR.Create('Le code postal est mal renseigné.',CodeErreur,FAfficheMessage,mtError,result);
////   raise ExceptLGR.Create('Le code postal est mal renseigné.',CodeErreur,FAfficheMessage,mtError);
//End;
//
//Function TCtrlChamp.Ctrl_ExisteDansTable(Valeur:String;CodeErreur:Integer;NomTable,NomChamp:String):TExceptLGR;
//Begin
// FIBQuery.Close;
// FIBQuery.SQL.Clear;
// FIBQuery.SQL.Add('Select * from ');
// FIBQuery.SQL.Add(NomTable);
// FIBQuery.SQL.Add(' where ');
// FIBQuery.SQL.Add(NomChamp +' like('''+Valeur+''')');
// FIBQuery.Open;
// FValeurRetour := FIBQuery.FieldList;
// if (FIBQuery.RecordCount = 0) then
//   raise ExceptLGR.Create(Format(C_VALEUR_INTROUVABLE,[Valeur]),CodeErreur,FAfficheMessage,mtError,result);
//End;
//
//// Renvoi vrai si une valeur n'existe pas déjà dans la table (utile lors de l'insertion pour préserver l'unicité)
//// A Controler
//Function TCtrlChamp.Ctrl_ExistePasDansTable(Valeur:String;CodeErreur:Integer;NomTable,NomChamp:String):TExceptLGR;
//Begin
// FIBQuery.Close;
// FIBQuery.SQL.Clear;
// FIBQuery.SQL.Add('Select * from ');
// FIBQuery.SQL.Add(NomTable);
// FIBQuery.SQL.Add(' where ');
// FIBQuery.SQL.Add(NomChamp +' like('''+Valeur+''')');
// FIBQuery.Open;
// FValeurRetour := FIBQuery.FieldList;
// if (FIBQuery.RecordCount > 0) then
//   raise ExceptLGR.Create(Format(C_VALEUR_EXISTE_DEJA,[Valeur]),CodeErreur,FAfficheMessage,mtError,result);
//End;
//
//// Renvoi vrai si une valeur n'existe pas déjà dans la table (utile lors de la modification pour préserver l'unicité)
//// A Controler
//Function TCtrlChamp.Ctrl_ExistePasDansTableEx(Valeur,ValeurExclue:String;CodeErreur:Integer;NomTable,NomChamp:String):TExceptLGR;
//Begin
// FIBQuery.Close;
// FIBQuery.SQL.Clear;
// FIBQuery.SQL.Add('Select * from ');
// FIBQuery.SQL.Add(NomTable);
// FIBQuery.SQL.Add(' where ');
// FIBQuery.SQL.Add(NomChamp +' like('''+Valeur+''') ');
// FIBQuery.SQL.Add(' and  ('+ID_TABLE(NomTable) +' <> '''+ValeurExclue+''') ');
// FIBQuery.Open;
// FValeurRetour := FIBQuery.FieldList;
// if (FIBQuery.RecordCount > 0) then
//   raise ExceptLGR.Create(Format(C_VALEUR_EXISTE_DEJA,[Valeur]),CodeErreur,FAfficheMessage,mtError,result);
//End;

//constructor TBdLgr.Create(AOwner :TComponent);
////Description ici la desc
//Begin
// inherited create;
//// FormCaption:='Sans Titre';
//// FormTop:=0;
//// FormLeft:=0;
//// FormShowModal:=False;
// FListeTitre:=TStringList.Create;
//// FListeTitre.LoadFromFile('TitreBD.lst');
// FBaseInterne:=False;
// ModeEcran := MeNormal;
// ObjetAMettreAJour:=nil;
// FDataSource := TDataSource.Create(AOwner);
//end;
//
//destructor TBdLgr.Destroy;
//Begin
//FListeTitre.Free;
//if FIBTransaction <> nil then
// begin
//  if FIBTransaction.InTransaction then
//   begin
//     try
//      FIBTransaction.CommitRetaining;
//     except
//      FIBTransaction.RollbackRetaining;
//     end;
//   end;
//  FIBTransaction:= nil;
//  if FBaseInterne then FIBTransaction.Free;
// end;
//
//if FIBBase <> nil then
// begin
//  if FBaseInterne then
//   begin
//    FIBBase.CloseDataSets;
//    FIBBase.Close;
//    FIBBase.Free;
//   end;
//  FIBBase:= nil;
// end;
// if FDataSource <> nil then FDataSource.Free;
// FDataSource:=nil;
//inherited Destroy;
//End;
//
//procedure TBdLgr.EcritDataBase(value : TIBDataBase);
//var
//TmpCursor : TCursor;
//Begin
//try
//  TmpCursor :=Screen.Cursor;
//  Screen.Cursor := crSQLWait;
////  if FIBBase <> nil then
////   begin
////     FIBBase.CloseDataSets;
////     FIBBase.Close;
////  //   FIBBase.Free;
////  //   FIBBase := nil;
////   end;
//   FBaseInterne:=False;
//   FIBBase := Value;
//   if value <> nil then
//    begin
//      FIBTransaction := Value.DefaultTransaction;
//      FDataBaseName := Value.DatabaseName;
////      FIBQuery.Database := FIBBase;
//    end
//finally
//  Screen.Cursor := TmpCursor;
//end;
//
//End;
//
//function TBdLgr.LitDataBase: TIBDataBase;
//Begin
// result := FIBBase;
//End;
//
//procedure TBdLgr.EcritDataBaseName(value : string);
//var
//TmpCursor : TCursor;
//Begin
//try
//  TmpCursor :=Screen.Cursor;
//  Screen.Cursor := crSQLWait;
//  try
//    if not fileExists(value) then
//     Begin
//      MessageDlg('La base de données '+value+' est inexistante', mtError, [mbOK], 0);
//      abort;
//     end
//     else
//     begin
//      FDataBaseName := Value;
//      CreateDataBase(FDataBaseName);
//     end;
//  except
//   FDataBaseName := '';
//   abort;
//  end;
//finally
//  Screen.Cursor := TmpCursor;
//end;
//End;
//
//function TBdLgr.LitDataBaseName: string;
//Begin
//result := FDataBaseName;
//End;
//
//procedure TBdLgr.CreateDataBase(DataBaseName:String);
//Begin
//try
//  FBaseInterne:=True;
//  if FIBBase = nil then
//    FIBBase :=TIBDataBase.Create(nil);
//  if FIBTransaction = nil then
//    FIBTransaction := TIBTransaction.Create(nil);
//  FIBBase.CloseDataSets;
//  FIBBase.Close;
//  FIBBase.DatabaseName := DataBaseName;
//  FIBBase.LoginPrompt := false;
//  FIBBase.Params.Clear;
//  FIBBase.Params.Add('user_name=SYSDBA');
//  FIBBase.Params.Add('password=masterkey');
//  FIBBase.DefaultTransaction := FIBTransaction;
//  FIBBase.Open;
//except;
// FBaseInterne:=False;
// MessageDlg('Erreur à la création de la Base de données ! ', mtError, [mbOK], 0);
// abort;
//end;
//End;
//
//
//procedure TBdLgr.EcritIbQuery(value : TIBQuery);
//Begin
//FIBQuery := Value;
//if FIBQuery <> nil then
// begin
//  FIBQuery.Open;
//  FDataSource.DataSet := FIBQuery;
// end;
//End;
//
//function TBdLgr.LitIbQuery: TIBQuery;
//Begin
// Result := FIBQuery;
//End;
//
//function TBdLgr.LitTitreChamp(const Value : string):string;
//var
//i:Integer;
//Begin
//Result:=value;
//if FListeTitre.Count = 0 then
// begin
//   if FileExists(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+'TitreBD2.lst') then
//    begin
//     FListeTitre.LoadFromFile(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+ 'TitreBD2.lst');
//     i:=FListeTitre.IndexOfName(value);
//     if i <> - 1 then
//       Result:=FListeTitre.ValueFromIndex[i];
//    end
//   else
//    begin
//     MessageDlg('le fichier n''existe pas', mtWarning, [mbOK], 0);
//    end;
// end
// else
//  begin
//   i:=FListeTitre.IndexOfName(value);
//   if i <> - 1 then
//     Result:=FListeTitre.ValueFromIndex[i];
//  end;
//End;


//constructor TIBQuLgr.Create(AOwner :TComponent);
//Begin
// inherited create(AOwner);
// FListeChampValue:=TStringList.Create;
// FDataSource.OnStateChange := dsFDataSourceStateChange;
//// FCtrlChamp:=TCtrlChamp.Create(AOwner);
//End;
//
//destructor TIBQuLgr.Destroy;
//Begin
// inherited Destroy;
// if FListeChampValue <> nil then FListeChampValue.Free;
// FListeChampValue:=nil;
//// if FCtrlChamp <> nil then FCtrlChamp.Free;
//// FCtrlChamp:=nil;
//End;
//
//procedure TIBQuLgr.dsFDataSourceStateChange(Sender: TObject);
//var
//i:Integer;
//begin
//  inherited;
//  ProtectObjetNil([FDataSource,FIBQuery]);
//  case FDataSource.State of
//   dsInsert:Begin
//             FListeChampValue.Clear;
//             for i:=0 to FIBQuery.FieldList.Count - 1 do
//              begin
//               FListeChampValue.Values[FIBQuery.FieldList.Strings[i]] := C_STR_VIDE;
//              end;
//             FModeObjet := MoInsertion;
////             MessageDlg('Etat du DataSet MoInsertion !', mtWarning, [mbOK], 0);
//            End;
//   dsEdit:Begin
//             FListeChampValue.Clear;
//             for i:=0 to FIBQuery.FieldList.Count - 1 do
//              begin
//               FListeChampValue.Values[FIBQuery.FieldList.Strings[i]] := LitChamp_Query(FIBQuery.FieldList.Strings[i]);
//              end;
//
//             FModeObjet := MoEdition;
////             MessageDlg('Etat du DataSet MoEdition !', mtWarning, [mbOK], 0);
//          End;
//   dsBrowse:Begin
//             FModeObjet := MoConsultation;
////             MessageDlg('Etat du DataSet MoConsultation !', mtWarning, [mbOK], 0);
//            End;
//   else ;//MessageDlg('Etat du DataSet inconnu !', mtWarning, [mbOK], 0);
//   end
//
//
//end;
//
//// Procedure qui fait passer l'objet en mode edition si :
////           - Objet.ModeObjet = MoConsultation
////           - Objet.AutoEdit = true
//Procedure TIBQuLgr.AutoModeEdition(ValOrg, ValNew : variant);
//Begin
//if ((FModeObjet = MoConsultation) and (FAutoEdit)) then
// begin
//  if VarCompareValue(ValOrg,ValNew) <> vrEqual then
//   ModeObjet := MoEdition;
// end;
//End;
//
//procedure TIBQuLgr.EcritModeObjet(value : TModeObjet);
//Begin
//// FModeObjet := Value;
//// // traitement liés au changement de ModeObjet
////  case FModeObjet of
////    MoConsultation:Begin
////                     if FIBQuery <> nil then
////                      begin
////                        try
//////                         FListeChampValue.Clear;
////                        except
////                         MessageDlg('Erreur lors de l''initialisation de FListeChampValue', mtWarning, [mbOK], 0);
////                        end;
////
////                      end;
////
////                   end;
////    MoEdition:Begin
////                 if FIBQuery <> nil then
////                  begin
////                   if assigned(FIBQuLgrModification) then
////                    begin
//////                       FListeChampValue.Clear;
////                       FIBQuLgrModification(FIBQuery);
////                    end;
////                  end;
////              end;
////    MoInsertion:Begin
////                 if FIBQuery <> nil then
////                  begin
////                   if assigned(FIBQuLgrInsertion) then
////                    begin
//////                      FListeChampValue.Clear;
////                      FIBQuLgrInsertion(FIBQuery);
////                    end;
////                  end;
////
////
//////                  FIBQuery.Insert;
//////                  DMTA_DONATEUR.Insertion_TA_DONATEUR(FIBQuery);
////                end;
////    MoImportation:Begin
////                  end;
////  else ;
////  end;
//// LitChamp_Obj_Liste;
//End;

//function TIBQuLgr.LitModeObjet: TModeObjet;
//Begin
//result := FModeObjet;
//End;
//
//// Méthodes de champ
//function TIBQuLgr.LitChamp_Query(const NomChamp:string): String;
//Begin
//Result:= C_STR_VIDE;
//ProtectObjetNil([FIBQuery]);
//   if not FIBQuery.Active then FIBQuery.Open;
//   if FIBQuery.findfield(NomChamp) <> nil then
//    Result:= FIBQuery.findfield(NomChamp).AsString
//   else
//    MessageDlg('Le champ ['+NomChamp+'] est introuvable !', mtError, [mbOK], 0);
//End;
//
//procedure TIBQuLgr.EcritChamp_Query(const NomChamp:string;value : String);
//Begin
//try
//  AutoModeEdition(Champ_Query[NomChamp],Value);
////  showmessage(FChamp_Donateur);
////  showmessage(Value);
// if FIBQuery <> nil then
//  begin
//   if not FIBQuery.Active then FIBQuery.Open;
//   if FIBQuery.findfield(NomChamp) <> nil then
//    begin
//    case ModeObjet of
//      MoConsultation:Begin
//                      // Pas de modification possible en mode Consultation
//                     end;
//      MoEdition:Begin
////                  if Assigned(FCtrlChampIB) then
////                   begin
////                    FCtrlChampIB(FIBQuery.FindField(NomChamp),0,FExceptLGR,InfoExceptLGR);
////                    FIBQuery.FindField(NomChamp).AsString := Value;
////                   end
////                  else
//                   begin
//                    FIBQuery.FindField(NomChamp).AsString := Value;
//                   end;
//                end;
//      MoInsertion:Begin
////                  if Assigned(FCtrlChampIB) then
////                   begin
////                    FCtrlChampIB(FIBQuery.FindField(NomChamp),0,FExceptLGR,InfoExceptLGR);
////                    FIBQuery.FindField(NomChamp).AsString := Value;
////                   end
////                  else
//                   begin
//                    FIBQuery.FindField(NomChamp).AsString := Value;
//                   end;
//                  end;
//      MoImportation:Begin
//                    end;
//    else ;
//    end;
//   end
//   else
//    begin
//    MessageDlg('Le champ ['+NomChamp+'] est introuvable !', mtError, [mbOK], 0);
//    end
//  end
//  else
//   begin
//    MessageDlg('IBQuery est nil !', mtError, [mbOK], 0);
//   end;
//
////  showmessage(FChamp_Donateur);
//except
// abort;
//end;
//End;
//
//procedure TIBQuLgr.Enregistrer;
//var
//i:Integer;
//Begin
//FListeChampValue.SaveToFile(ParamUtil.RepertoireApplication+'FListeChampValue.txt');
//  for i:=0 to FListeChampValue.Count - 1 do
//   begin
//    Champ_Query[FListeChampValue.Names[i]]:=Champ_Obj[FListeChampValue.Names[i]];
//   end;
//  ProtectObjetNil([FIBQuery,FIBBase,FIBTransaction]);
// if assigned(FIBQuLgrEnregistrer) then
//  begin
//    FIBQuLgrEnregistrer([FIBQuery]);
//  end
// else
//  begin
//   if not (FIBQuery.State in [dsInsert,dsEdit]) then
//    begin
//     MessageDlg('FIBQuery n''est ni en mode édition, ni en mode insertion !', mtError, [mbOK], 0);
//    end;
//    try
//      try
//       FIBTransaction.CommitRetaining;
//       FIBQuery.Post;
//       FIBTransaction.CommitRetaining;
//      except
//       FIBTransaction.RollbackRetaining;
//       raise;
//      end;
//    finally
//      ReEnableControls(FIBQuery);
//    end;
//  end;
////FModeObjet := MoConsultation;
//End;
//
//procedure TIBQuLgr.Supprimer;
//var
//i:Integer;
//Begin
//  try
//   ProtectObjetNil([FIBQuery]);
//   if assigned(FIBQuLgrSupprimer) then
//    begin
//      FIBQuLgrSupprimer(FIBQuery);
//    end
//   else
//    begin
//      try
//        try
//         FIBTransaction.CommitRetaining;
//         FIBQuery.Delete;
//         FIBTransaction.CommitRetaining;
//        except
//         FIBTransaction.RollbackRetaining;
//         raise;
//        end;
//      finally
//        ReEnableControls(FIBQuery);
//      end;
//    end;
//  except
//   abort;
//  end;
////for i:=0 to FListeChampValue.Count - 1 do
//// begin
////  Champ_Query[FListeChampValue.Names[i]]:=Champ_Obj[FListeChampValue.Names[i]];
//////  Champ_Query[FListeChampValue.Names[i]]:=FListeChampValue.ValueFromIndex[i];
//// end;
//// if assigned(FIBQuLgrEnregistrer) then
////  begin
////    FIBQuLgrEnregistrer([FIBQuery]);
////  end;
////
//End;
//
//procedure TIBQuLgr.Modifier;
//Begin
//  try
//   ProtectObjetNil([FIBQuery]);
//   if assigned(FIBQuLgrModification) then
//    begin
//      FIBQuLgrModification(FIBQuery);
//    end
//   else
//    begin
//      if not FIBQuery.Active then FIBQuery.Open;
//      if FIBQuery.State = dsEdit then
//       MsgEtatDsEdit;
//      if FIBQuery.State = dsBrowse then FIBQuery.Edit;
//    end;
//  except
//   abort;
//  end;
//End;
//
//procedure TIBQuLgr.Annuler;
//Begin
////
//  try
//   ProtectObjetNil([FIBQuery]);
//   if assigned(FIBQuLgrAnnuler) then
//    begin
//      FIBQuLgrAnnuler(FIBQuery);
////      FModeObjet := MoConsultation;
//    end
//   else
//    begin
//      case FIBQuery.State of
//         dsInsert:Begin
//                    if MsgAbandonDsInsert('') then
//                     begin
//                       FIBQuery.Cancel;
////                       FModeObjet := MoConsultation;
//                       if not FIBQuery.Active then FIBQuery.Open;
//                       FIBQuery.EnableControls;
//                     end;
//                  End;
//         dsEdit:Begin
//                    if MsgAbandonDsEdit('') then
//                     begin
//                       FIBQuery.Cancel;
////                       FModeObjet := MoConsultation;
//                       if not FIBQuery.Active then FIBQuery.Open;
//                          FIBQuery.EnableControls;
//                     end;
//                End;
//         dsBrowse:Begin
//
//                End;
//      end;
//    end;
//  except
////   FModeObjet := MoErreur;
//   abort;
//  end;
//End;
//
//procedure TIBQuLgr.Inserer;
//var
//i:Integer;
//Begin
////  FModeObjet := MoInsertion;
//  try
////   if Assigned(FDataSource.OnStateChange) then
////    MessageDlg('assigned', mtWarning, [mbOK], 0);
//   ProtectObjetNil([FIBQuery]);
//   FListeChampValue.Clear;
//   for i:=0 to FIBQuery.FieldList.Count - 1 do
//    begin
//     FListeChampValue.Values[FIBQuery.FieldList.Strings[i]] := C_STR_VIDE;
//    end;
//   if assigned(FIBQuLgrInsertion) then
//    begin
//      FIBQuLgrInsertion(FIBQuery);
//    end
//   else
//    begin
//      if not FIBQuery.Active then FIBQuery.Open;
//      if FIBQuery.State = dsInsert then
//       MsgEtatDsInsert;
//      if FIBQuery.State = dsBrowse then FIBQuery.Insert;
//    end;
//  except
////   FModeObjet := MoErreur;
//   abort;
//  end;
//End;



//procedure TCtrlChamp.Refresh(var Message: TMessCtrlLGR);
//Begin
////MessageDlg('IBQuLgr.Refresh', mtWarning, [mbOK], 0);
////CtrlSaisie(message);
//End;

//procedure TCtrlChamp.CtrlSaisie(var Message: TMessCtrlLGR);
//Begin
////MessageDlg('TCtrlChamp.CtrlSaisie(', mtWarning, [mbOK], 0);
//End;


//// Méthodes de champ
//procedure TIBQuLgr.EcritChamp_Obj_Query;
//var
//i:Integer;
//Begin
//  for i:=0 to FListeChampValue.Count - 1 do
//   begin
//    Champ_Query[FListeChampValue.Names[i]]:=Champ_Obj[FListeChampValue.Names[i]];
//   end;
//End;
//
//function TIBQuLgr.LitQuery_Champ_Obj:TStringList;
//var
//i:Integer;
//Begin
// Result:= nil;
//  case FModeObjet of
//    MoConsultation:Begin
//                     if FIBQuery <> nil then
//                      begin
//                        try
//                         FListeChampValue.Clear;
//                         for i:=0 to FIBQuery.FieldList.Count - 1 do
//                          begin
//                           FListeChampValue.Values[FIBQuery.FieldList.Strings[i]] := Champ_Query[FIBQuery.FieldList.Strings[i]];
////                           MessageDlg(FListeChampValue.Values[FIBQuery.FieldList.Strings[i]]+'||'+Champ_Query[FIBQuery.FieldList.Strings[i]], mtWarning, [mbOK], 0);
//                          end;
//                        except
//                         MessageDlg('Erreur lors de l''initialisation de FListeChampValue', mtWarning, [mbOK], 0);
//                        end;
//
//                      end;
//
//                   end;
//    MoEdition:Begin
//                 if FIBQuery <> nil then
//                  begin
//                   FListeChampValue.Clear;
//                   for i:=0 to FIBQuery.FieldList.Count - 1 do
//                    begin
//                     FListeChampValue.Values[FIBQuery.FieldList.Strings[i]] := Champ_Query[FIBQuery.FieldList.Strings[i]];
//                    end;
//                  end;
//              end;
//    MoInsertion:Begin
//                 if FIBQuery <> nil then
//                  begin
////                    FListeChampValue.Clear;
////                     for i:=0 to FIBQuery.FieldList.Count - 1 do
////                      begin
////                       FListeChampValue.Values[FIBQuery.FieldList.Strings[i]] := C_STR_VIDE;
////                      end;
//                  end;
//
//
////                  FIBQuery.Insert;
////                  DMTA_DONATEUR.Insertion_TA_DONATEUR(FIBQuery);
//                end;
//    MoImportation:Begin
//                  end;
//  else ;
//  end;
// Result:=FListeChampValue;
//End;
//
//function TIBQuLgr.LitChamp_Obj(const NomChamp:string): String;
//Begin
// Result:= C_STR_VIDE;
// Result:=FListeChampValue.Values[NomChamp];
//End;
//
//procedure TIBQuLgr.EcritChamp_Obj(const NomChamp:string;value : String);
//var
//Ex:TMessCtrlLGR;
//Begin
//try
//  AutoModeEdition(Champ_Obj[NomChamp],Value);
//    begin
//    case ModeObjet of
//      MoConsultation:Begin
//                      // Pas de modification possible en mode Consultation
//                     end;
//      MoEdition:begin // effectuer ici le controle sur le champ
////                  if Assigned(FCtrlChampObj) then
////                   begin
//
////                    FCtrlChampObj(NomChamp,Value,0,FExceptLGR,InfoExceptLGR);
////                    FListeChampValue.Values[NomChamp]:=Value;
////                   end
////                  else
//                   begin
//                    FListeChampValue.Values[NomChamp]:=Value;
//                   end;
//                end;
//      MoInsertion:Begin  // effectuer ici le controle sur le champ
////                  if FCtrlChamp <> nil then
////                   begin
////                     Ex.Msg := ID_REFRESH;
////                     FCtrlChamp.Dispatch(ex);
////                   end;
////                  PostMessage(0,100,0,0);
////                  if Assigned(FCtrlChampObj) then
////                   begin
////                    FCtrlChampObj(NomChamp,Value,0,FExceptLGR,InfoExceptLGR);
////                    FListeChampValue.Values[NomChamp]:=Value;
////                   end
////                  else
//                   begin
//                    FListeChampValue.Values[NomChamp]:=Value;
//                   end;
//                  end;
//      MoImportation:Begin
//                    end;
//    else ;
//    end;
//   end;
//except
// abort;
//end;
//End;


// fin des méthodes de champ

//constructor TParamForm.Create(AOwner :TComponent);
//Begin
// inherited create;
// FormCaption:='Sans Titre';
// FormTop:=0;
// FormLeft:=0;
// FormShowModal:=False;
// ModeEcran := MeNormal;
// ObjetAMettreAJour:=nil;
//end;
//
//destructor TParamForm.Destroy;
//Begin
//inherited Destroy;
//End;
//
//Procedure TParamForm.FormAffiche(var Result:Boolean;Form:TForm);
//Begin
//if self.FormShowModal then
// begin
//  if not Form.Visible then
//   result := (Form.ShowModal = mrOk);
// end
// else
//  Form.Show;
//End;

//constructor TParamDM.Create(AOwner :TComponent);
//Begin
// inherited create;
// Str_Cherche:=C_STR_VIDE;
//  NomTableRech:=C_STR_VIDE;
//  NomChampRecherche:=C_STR_VIDE;
//  NomChampResultat:=C_STR_VIDE;
//  ListeChamp:=nil;
//  ModeDM:=MeNormal;
//  ResultatUnique:=false;
////
//end;
//
//destructor TParamDM.Destroy;
//Begin
//if ListeChamp <> nil then
// begin
//  ListeChamp.Free;
//  ListeChamp:=nil;
// end;
//inherited Destroy;
//End;


constructor TParamUtil.Create(AOwner :TComponent);
var
ListeCouleurDBGrid:TStringList;
i:integer;
Begin
inherited create;
RepertoireApplication := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));
RepertoireLibApplication:= IncludeTrailingPathDelimiter(RepertoireApplication+'Lib\');
RepertoireImageFond := (RepertoireApplication+'Img\ImgFd');
RepertoireImageFond2 := (RepertoireApplication+'Img\ImgFd2');
RepertoireAideWeb:= IncludeTrailingPathDelimiter(RepertoireApplication+'Annexes\');
RepertoireBaseDonnees := IncludeTrailingPathDelimiter(RepertoireApplication+'Bd\');
RepertoireFichierBaseDonnees:= RepertoireBaseDonnees + 'AssoBD.gdb';
RepertoireFichierIni :=RepertoireApplication+'AssoDon.ini';
RepertoireFichierBDIni :=RepertoireLibApplication+'CtrlAssoBD.ini';
RepertoireFichierIDIni :=RepertoireLibApplication+'IDBD.ini';
DisplayFormat:=',0.00 '+currencyStringEpicea+';-,0.00 '+currencyStringEpicea;
//DisplayFormat:=',0.00 €;-,0.00 €';
EditFormat:=',0.00;-,0.00';
IdRetourPourFiltre:=0;
  if FileExists(RepertoireApplication + 'Datadb.dat') then
  begin
  ListeCouleurDBGrid:=TStringList.Create;
  ListeCouleurDBGrid.LoadFromFile(RepertoireApplication+ 'Datadb.dat');
  try
    for i:=0 to ListeCouleurDBGrid.Count-1 do
        begin
         case i of
            0:CouleurDBGrid.LigneContour:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            1:CouleurDBGrid.CelActiveContour:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            2:CouleurDBGrid.CelActiveColorFond:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            3:CouleurDBGrid.CelActiveColorFont:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            4:CouleurDBGrid.CelActiveSAisieColorFont:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            5:CouleurDBGrid.CelActiveSAisieColorFond:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            6:CouleurDBGrid.CelFixeColorFond:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            7:CouleurDBGrid.CelFixeColorFont:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            8:CouleurDBGrid.GrilleColorFond:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            9:CouleurDBGrid.GrilleColorFont:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
         end;
        end;
//    Panel1.Color:=CouleurDBGrid.GrilleColorFond;
    ListeCouleurDBGrid.Free;
  except
  // DBGrid
    showmessage('La lecture de certains paramètres à échouée, ceux par défaut ont été restaurés !');
    CouleurDBGrid.LigneContour:=clGreen;
    CouleurDBGrid.CelActiveContour:=$0000E600;
    CouleurDBGrid.CelActiveColorFond:=clactiveBorder;
    CouleurDBGrid.CelActiveColorFont:=clWhite;
    CouleurDBGrid.CelActiveSAisieColorFont:=clBlack;
    CouleurDBGrid.CelActiveSAisieColorFond:=$0000E600;
    CouleurDBGrid.CelFixeColorFond:=clBtnFace;
    CouleurDBGrid.CelFixeColorFont:=clWindowText;
    CouleurDBGrid.GrilleColorFond:=$00EAFAFF;
    CouleurDBGrid.GrilleColorFont:=clWindowText;
//    Panel1.Color:=CouleurDBGrid.GrilleColorFond;
    ListeCouleurDBGrid.Free;
  end;
  end
  else
  begin
    CouleurDBGrid.LigneContour:=clGreen;
    CouleurDBGrid.CelActiveContour:=$0000E600;
    CouleurDBGrid.CelActiveColorFond:=clactiveBorder;
    CouleurDBGrid.CelActiveColorFont:=clWhite;
    CouleurDBGrid.CelActiveSAisieColorFont:=clBlack;
    CouleurDBGrid.CelActiveSAisieColorFond:=$0000E600;
    CouleurDBGrid.CelFixeColorFond:=clBtnFace;
    CouleurDBGrid.CelFixeColorFont:=clWindowText;
    CouleurDBGrid.GrilleColorFond:=$00EAFAFF;
    CouleurDBGrid.GrilleColorFont:=clWindowText;
  end;
//self.ContourCouleur:=clRed;
//self.ShadowColorOn:=clRed;
//self.TextColorOn:=clRed;
//self.ShadowColorOff:=clBtnHighlight;
//self.TextColorOff:=clWindowText;
//self.CouleurPanelTitre:=$00EAFAFF;
//self.CouleurPanelCorps:=$00BADCDC;
//OldScreenWidth:=Screen.Width;
//OldScreenHeight:=Screen.Height;
//ConstPosition:=false;
//maintenance:=false;
//TypeMaintenance:='';
//GestionSauvegarde:=false;
//IcoMenuDemarrer:=False;
//IcoMenuProgramme:=True;
//IcoBureau:=False;
//AfficheTitre:=true;
//AssistantAffichageAuto:=False;
//AssistantDelaiAffichage:=60;
//RepertoireSauvegarde:=ExtractFilePath(Application.ExeName)+ 'Sauvegarde\';
//MaxDosMenu:=CT_MaxDosMenu;
//InitRepertoireCreationDossier;
////RepertoireCreationDossier:=ExtractFilePath(Application.ExeName);
//PlanDeSaisie:=False;
End;

destructor TParamUtil.Destroy;
Begin
inherited Destroy;
//if RepertoireCreationDossier <> ExtractFilePath(Application.ExeName) then
//  DMXml.ModifieItemProgramme('RepertoireCreation',RepertoireCreationDossier);
End;

function MsgNonFini:Boolean;
Begin
MessageDlg('Fonction non implémentée dans cette version !', mtInformation, [mbOK], 0);
End;

// cette fonction renvoi le parametre servant à définir les couleurs d'écran de FM_INIT_COLOR
Function ValTypeInitForm:Integer;
Begin
Result:=1;
End;

Function MsgEtatDsInsert:Boolean;
Begin
MessageDlg('Vous êtes déjà en insertion !', mtInformation, [mbOK], 0);
End;

Function MsgEtatDsEdit:Boolean;
Begin
MessageDlg('Vous êtes déjà en modification !', mtInformation, [mbOK], 0);
End;

Function MsgAbandonDsEdit(Mess:String):Boolean;
Begin
result:=MessageDlg('Voulez-Vous abandonner les modifications en cours '+Mess+' ?', mtConfirmation, [mbNo,mbYes], 0)=mrYes;
End;

Function MsgAbandonDsInsert(Mess:String):Boolean;
Begin
result:=MessageDlg('Voulez-Vous abandonner l''insertion en cours '+Mess+' ?', mtConfirmation, [mbNo,mbYes], 0)=mrYes;
End;

Function MsgSupprimer(Mess:String):Boolean;
Begin
result:=MessageDlg('Voulez-Vous supprimer l''enregistrement en cours '+Mess+' ?', mtConfirmation, [mbNo,mbYes], 0)=mrYes;
End;

//Procedure AffecteEventChange(Control : array of TControl; Evenement : TNotifyEvent);
//var
//i:integer;
//Begin
//  try
//    for I := 0 to High(Control) do
//      begin
//        case RecupClassTypeComponent(Control[i]) of
//          GTEdit:(Control[i] as TEdit).onChange:=Evenement;
//          GTCheckBox:(Control[i] as TCheckBox).OnClick:=Evenement;
//          GTRichEdit:begin
////                       AfficheInfoObjet('',Sender,true);
////                       if @(Control[i] as TRichEdit).onChange <> nil then showmessage('Non nil') else showmessage('nil');
//                       (Control[i] as TRichEdit).onChange:=Evenement;
//                     end;
//          GTMemo:(Control[i] as TMemo).onChange:=Evenement;
//        end;
//      end;
//  except
//   MessageDlg(C_ERREUR+ 'AffecteEvent', mtError, [mbOK], 0);
//  end;
//End;
//
//Procedure AffecteEventExit(Control : array of TControl; Evenement : TNotifyEvent);
//var
//i:integer;
//Begin
//  try
//    for I := 0 to High(Control) do
//      begin
//        case RecupClassTypeComponent(Control[i]) of
//          GTEdit:(Control[i] as TEdit).OnExit:=Evenement;
//  //        GTEdit:(Control[i] as TEdit).onChange:=Evenement;
//        end;
//      end;
//  except
//   MessageDlg(C_ERREUR+ 'AffecteEvent', mtError, [mbOK], 0);
//  end;
//End;
//
//Procedure AffecteEventChange(ListControl : TStringList; Evenement : TNotifyEvent);
//var
//i:integer;
//Begin
//  try
//    for I := 0 to ListControl.Count - 1 do
//      begin
//       if ListControl.Objects[i] <> nil then
//        case RecupClassTypeComponent(TComponent(ListControl.Objects[i])) of
//          GTEdit:(ListControl.Objects[i] as TEdit).onChange:=Evenement;
//          GTCheckBox:(ListControl.Objects[i] as TCheckBox).OnClick:=Evenement;
//          GTRichEdit:begin
////                       AfficheInfoObjet('',Sender,true);
////                       if @(Control[i] as TRichEdit).onChange <> nil then showmessage('Non nil') else showmessage('nil');
//                       (ListControl.Objects[i] as TRichEdit).onChange:=Evenement;
//                     end;
//          GTMemo:(ListControl.Objects[i] as TMemo).onChange:=Evenement;
//        end;
//      end;
//  except
//   MessageDlg(C_ERREUR+ 'AffecteEvent', mtError, [mbOK], 0);
//  end;
//End;
//
//Procedure AffecteEventExit(ListControl : TStringList; Evenement : TNotifyEvent);
//var
//i:integer;
//Begin
//  try
//    for I := 0 to ListControl.Count - 1 do
//      begin
//       if ListControl.Objects[i] <> nil then
//        case RecupClassTypeComponent(TComponent(ListControl.Objects[i])) of
//          GTEdit:(ListControl.Objects[i] as TEdit).OnExit:=Evenement;
//  //        GTEdit:(Control[i] as TEdit).onChange:=Evenement;
//        end;
//      end;
//  except
//   MessageDlg(C_ERREUR+ 'AffecteEvent', mtError, [mbOK], 0);
//  end;
//End;
//
//Function ExisteDansTableau(Control : array of TControl; WinControl : TControl):Boolean;
//var
//i:integer;
//Begin
//result:=false;
//  try
//    for I := 0 to High(Control) do
//      begin
//       if Control[i] = WinControl then
//        begin
//         result:=true;
//         break;
//        end;
//      end;
//  except
//
//  end;
//End;
//
//Function GenereCodeDefaut(Prefixe:String;CharCompteur:Char;Compteur,LengthCompteur:integer):String;
//Begin
//result:= Prefixe + StringOfChar(CharCompteur,LengthCompteur-length(IntToStr(Compteur)))+
//         IntToStr(Compteur);
//End;
//
//Function EtatDataSet(DataState:TDataSetState):String;
//Begin
//result:=' - Etat dataset inconnu !';
//case DataState of
//   dsInsert:Begin
//             result:=' - Insertion ';
//            End;
//   dsEdit:Begin
//             result:=' - Modification ';
//          End;
//   dsBrowse:Begin
//             result:=' - Consultation ';
//            End;
//   dsInactive:Begin
//               result:=' - Inactive ';
//              End;
//
//
//end;
//
////
//End;
//
//Procedure DBGridEnLectureSeule(DBGrid:TGrDBGrid;LectureSeule:Boolean);
//Begin
// if LectureSeule then
//  begin
//    DBGrid.EnterAsTab := false;
//    DBGrid.Options := DBGrid.Options - [dgEditing];
//    DBGrid.ReadOnly := true;
//  end
// else
//  begin
//    DBGrid.EnterAsTab := true;
//    DBGrid.Options := DBGrid.Options + [dgEditing];
//    DBGrid.ReadOnly := False;
//  end;
//
//End;
//
//Procedure GrDBGridValideInplaEdit(DBGrid:TGrDBGrid);
//var
//ch:Word;
//Begin
//ch:=VK_RETURN;
//if DBGrid.InplaceEditor <> nil then
//   if DBGrid.InplaceEditor.Visible then
//    TGrInplaceEdit(DBGrid.InplaceEditor).KeyDown(ch,[]);
//End;
//
//Procedure GrDbGridInitColonne(var GrDbGrille:TGrDbGrid;DataSource:TDataSource;DataSet:TDataSet;ListeColonne,ListeChamp : TStringList;FormatMonnaie,EditFormat:String);overload;
//var
//NotifyEvent:TNotifyEvent;
//j:integer;
//Begin
//ProtectObjetNil([ListeChamp,ListeColonne,DataSource]);
//GrDbGrille.DataSource:=nil;
//GrDbGrille.Columns.RebuildColumns;
//NotifyEvent:=DataSource.OnStateChange;
//DataSource.OnStateChange:=nil;
//
//if DataSet <> nil then
//  DataSource.DataSet:=DataSet;
//ProtectObjetNil([DataSource.DataSet]);
//if DataSource.DataSet.Active then DataSource.DataSet.Close;
//GrDbGrille.DataSource:=DataSource;
//case RecupClassTypeComponent(DataSource.DataSet) of
//   GTIBQuery:Begin
//               DataSource.DataSet.Open;
//    //           FormateMonnaieField(DataSource.DataSet,FormatMonnaie,EditFormat);
//               for j:=0 to ListeColonne.Count -1 do
//                Begin
//                if ((DataSource.DataSet.FindField(ListeChamp.Strings[j]) <> nil) and (not str_Empty(ListeColonne.Strings[j]))) then
//                 begin
//                  GrDbGrille.Columns.Add.Field:=DataSource.DataSet.FindField(ListeChamp.Strings[j]);
//                  GrDbGrille.Columns[GrDbGrille.Columns.Count-1].Title.Caption:=ListeColonne.Strings[j];
//                  case RecupClassTypeComponent(DataSource.DataSet.FindField(ListeChamp.Strings[j])) of
//                     GTFieldCurr:GrDbGrille.Columns[GrDbGrille.Columns.Count-1].Title.Alignment:=taRightJustify;
//    //                 : ;
//                  end;
//                 end;
//                End;
//
//    //           for j:=0 to ListeChamp.Count -1 do
//    //            Begin
//    //            if DataSource.DataSet.FindField(ListeChamp.Strings[j]) <> nil then
//    //             begin
//    //              GrDbGrille.Columns[j].Title.Caption:=ListeColonne.Strings[j];
//    //              case RecupClassTypeComponent(DataSource.DataSet.FindField(ListeChamp.Strings[j])) of
//    //                 GTFieldCurr:GrDbGrille.Columns[j].Title.Alignment:=taRightJustify;
//    ////                 : ;
//    //              end;
//    //
//    //             end;
//    //            End;
//    //            FormateMonnaieField(DataSet,FormatMonnaie,EditFormat);
//
//           End;
//
////   GTable: Begin
////           DataSet.Open;
////           for j:=0 to high(NomChamp) do
////            Begin
//////            showmessage(IntToSTr(j));
////            if DataSource.DataSet.FindField(NomChamp[j]) <> nil then
////             begin
////              GrDbGrille.Columns.Add.Field:=DataSource.DataSet.FindField(NomChamp[j]);
////             end;
////            End;
////
////           for j:=0 to high(NomChamp) do
////            Begin
////            if DataSource.DataSet.FindField(NomChamp[j]) <> nil then
////             begin
////              GrDbGrille.Columns[j].Title.Caption:=TitreColonne[j];
////              case RecupClassTypeComponent(DataSource.DataSet.FindField(NomChamp[j])) of
////                 GTFieldCurr:GrDbGrille.Columns[j].Title.Alignment:=taRightJustify;
//////                 : ;
////              end;
////             end;
////            End;
////            FormateMonnaieField(DataSource.DataSet,FormatMonnaie,EditFormat);
////           End;
//
//end;
//if not DataSource.DataSet.Active then DataSource.DataSet.Open;
//GrDbGrille.DataSource.Enabled:=true;
//DataSource.OnStateChange:=NotifyEvent;
////
//End;

//procedure VideZoneSaisieTxt(Zsaisie : TStringList);
//var
//i:integer;
//buf:pchar;
//begin
//  for I := 0 to Zsaisie.Count - 1 do
//   begin
//      buf:='';
//      if Zsaisie.Objects[I] <> nil then
//      begin
//        case RecupClassTypeComponent(TComponent(Zsaisie.Objects[I])) of
////          GTRichEdit:TRichEdit(ListZone[I]).Text:=(buf);
//          GTRichEdit:begin
//                     end;
//          GTEdit:TEdit(Zsaisie.Objects[I]).SetTextBuf(buf);
//
//          GTMemo:TMemo(Zsaisie.Objects[I]).SetTextBuf(buf);
//          GTInconnu: ;
//        end;
//      end;
//   end;
//end;
// ListeTitre doit être une liste de la forme : NomDuChamp=TitreDuChamp

//Procedure GrDbGridInitColonneEx(var GrDbGrille:TGrDbGrid;DataSource:TDataSource;DataSet:TDataSet;ListeTitre:TStringList;FormatMonnaie,EditFormat:String);
//var
//NotifyEvent:TNotifyEvent;
//j:integer;
//Begin
//
//ProtectObjetNil([DataSource,ListeTitre]);
//GrDbGrille.DataSource:=nil;
//GrDbGrille.Columns.RebuildColumns;
//NotifyEvent:=DataSource.OnStateChange;
//DataSource.OnStateChange:=nil;
//
//if DataSet <> nil then
//  DataSource.DataSet:=DataSet;
//ProtectObjetNil([DataSource.DataSet]);
//if DataSource.DataSet.Active then DataSource.DataSet.Close;
//GrDbGrille.DataSource:=DataSource;
//case RecupClassTypeComponent(DataSource.DataSet) of
//   GTIBQuery:Begin
//               DataSource.DataSet.Open;
//               for j:=0 to DataSource.DataSet.FieldCount -1 do
//                Begin
//
////                ShowMessage(DataSource.DataSet.Fields[j].Origin +'|'+ DataSource.DataSet.Fields[j].DisplayLabel);
////                if (DataSource.DataSet.Fields[j].Origin <> DataSource.DataSet.Fields[j].DisplayLabel) then
//                if ((true) and (not str_Empty(ListeTitre.Values[DataSource.DataSet.Fields[j].Origin]))) then
//
////                if ((DataSource.DataSet.FindField(ListeChamp.Strings[j]) <> nil) and (not str_Empty(ListeColonne.Strings[j]))) then
//                 begin
//                  GrDbGrille.Columns.Add.Field:=DataSource.DataSet.Fields[j];
//                  GrDbGrille.Columns[GrDbGrille.Columns.Count-1].Title.Caption:=ListeTitre.Values[DataSource.DataSet.Fields[j].Origin];
//                  case RecupClassTypeComponent(DataSource.DataSet.Fields[j]) of
//                     GTFieldCurr:GrDbGrille.Columns[GrDbGrille.Columns.Count-1].Title.Alignment:=taRightJustify;
//    //                 : ;
//                  end;
//                 end;
//                End;
////    //           FormateMonnaieField(DataSource.DataSet,FormatMonnaie,EditFormat);
////               for j:=0 to ListeColonne.Count -1 do
////                Begin
////                if ((DataSource.DataSet.FindField(ListeChamp.Strings[j]) <> nil) and (not str_Empty(ListeColonne.Strings[j]))) then
////                 begin
////                  GrDbGrille.Columns.Add.Field:=DataSource.DataSet.FindField(ListeChamp.Strings[j]);
////                  GrDbGrille.Columns[GrDbGrille.Columns.Count-1].Title.Caption:=ListeColonne.Strings[j];
////                  case RecupClassTypeComponent(DataSource.DataSet.FindField(ListeChamp.Strings[j])) of
////                     GTFieldCurr:GrDbGrille.Columns[GrDbGrille.Columns.Count-1].Title.Alignment:=taRightJustify;
////    //                 : ;
////                  end;
////                 end;
////                End;
//
//    //           for j:=0 to ListeChamp.Count -1 do
//    //            Begin
//    //            if DataSource.DataSet.FindField(ListeChamp.Strings[j]) <> nil then
//    //             begin
//    //              GrDbGrille.Columns[j].Title.Caption:=ListeColonne.Strings[j];
//    //              case RecupClassTypeComponent(DataSource.DataSet.FindField(ListeChamp.Strings[j])) of
//    //                 GTFieldCurr:GrDbGrille.Columns[j].Title.Alignment:=taRightJustify;
//    ////                 : ;
//    //              end;
//    //
//    //             end;
//    //            End;
//    //            FormateMonnaieField(DataSet,FormatMonnaie,EditFormat);
//
//           End;
//
//
//end;
//if not DataSource.DataSet.Active then DataSource.DataSet.Open;
//GrDbGrille.DataSource.Enabled:=true;
//DataSource.OnStateChange:=NotifyEvent;
////
//End;

end.

