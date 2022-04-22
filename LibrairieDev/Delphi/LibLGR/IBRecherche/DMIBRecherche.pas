unit DMIBRecherche;

interface

uses
  SysUtils, Classes,
  Forms,
  Controls,
  StdCtrls,
  IBQuery,
  GrDBGrid,
  Db,
  Dialogs,
  AD_Librairie_Obj,
  AD_Librairie;

type

  PEventAfficheEcran=pointer;
  TEventAfficheEcran=PEventAfficheEcran;

TIBRechLgr = class(TBdLgr)
  private
     FListeTitreBD:TStringList;
     FNomRepertoireFichierTitreBDChamp:string;
//     FModeObjet:TModeObjet;
//     FAutoEdit:Boolean;
//     FIBQuLgrInsertion:TIBQuLgrInsertion;
//     FIBQuLgrModification:TIBQuLgrModification;
//     FIBQuLgrEnregistrer:TIBQuLgrEnregistrer;
//     FIBQuLgrAnnuler:TIBQuLgrAnnuler;
//     FIBQuLgrSupprimer:TIBQuLgrSupprimer;
//     FCtrlChampObj:TCtrlChampObj;
//     FCtrlChampIB:TCtrlChampIB;
//     FChamp_Query : string;
//     FExceptLGR:ExceptLGR;
//     FCtrlChamp:TCtrlChamp;
////     FListeChampValue:TStringList;
////     FCtrlChamp:TCtrlChamp;
//
//     procedure dsFDataSourceStateChange(Sender: TObject);
//     procedure EcritModeObjet(value : TModeObjet);
//     function LitModeObjet: TModeObjet;
//
     function LitTitreChampAide(const Value : string):string;
     function LitChamp_Query(const NomChamp:string): String;
//     procedure EcritChamp_Query(const NomChamp:string;value : String);
//
//     function LitQuery_Champ_Obj:TStringList;
//
//     function LitChamp_Obj(const NomChamp:string): String;
//     procedure EcritChamp_Obj(const NomChamp:string;value : String);

  protected
     FListeChampValue:TStringList;
     procedure EcritRepertoireFichierTitreBDChamp(Value : string);
//     Procedure AutoModeEdition(ValOrg, ValNew: variant);
//     property Champ_Obj[const NomChamp: string]: string read LitChamp_Obj write EcritChamp_Obj;
//     property Champ_Obj_Liste:TStringList read LitQuery_Champ_Obj;

  public
//    InfoExceptLGR:TExceptLGR;
    FListeChamp:TStringList;
    FDbGrid:TGrDbGrid;
    FListeRech:TStringList;
    FListeEvent:TStringList;
//    FListeRechSurChamp:TStringList; // Contient la liste des
//    FDataSource:TDataSource;
    constructor Create(AOwner :TComponent);
    destructor Destroy; override;
    procedure AjouteRech(NomRech,NomChampRech:string;SQL:TStrings;NotifyEvent:TNotifyEvent);
    procedure ActiverRech(NomRech:string;ControlClick:TControl);
    procedure SupprimeRech(NomRech:string);
    property Champ_Query[const NomChamp: string]: string read LitChamp_Query;
    property RepertoireFichierTitreBDChamp:string read FNomRepertoireFichierTitreBDChamp Write EcritRepertoireFichierTitreBDChamp;
    property TitreChampAide[const NomChamp: string]: String read LitTitreChampAide; // Contient la liste des champs ainsi que les titres associé
//    property AutoEdit:boolean read FAutoEdit write FAutoEdit;
//    property ModeObjet:TModeObjet read LitModeObjet write EcritModeObjet;
//    property OnIBQuLgrInsertion:TIBQuLgrInsertion read FIBQuLgrInsertion write FIBQuLgrInsertion default nil;
//    property OnIBQuLgrModification:TIBQuLgrModification read FIBQuLgrModification write FIBQuLgrModification default nil;
//    property OnIBQuLgrEnregistrer:TIBQuLgrEnregistrer read FIBQuLgrEnregistrer write FIBQuLgrEnregistrer default nil;
//    property OnIBQuLgrAnnuler:TIBQuLgrAnnuler read FIBQuLgrAnnuler write FIBQuLgrAnnuler default nil;
//    property OnCtrlChampObj:TCtrlChampObj read FCtrlChampObj write FCtrlChampObj default nil;
//    property OnCtrlChampIB:TCtrlChampIB read FCtrlChampIB write FCtrlChampIB default nil;
//    procedure EcritChamp_Obj_Query;
//
//    procedure Enregistrer;
//    procedure Supprimer;
//    procedure Modifier;
//    procedure Annuler;
//    procedure Inserer;
//    procedure Refresh(var Message: TMessCtrlLGR); message ID_REFRESH;
  published

end;

  TDMIBRech = class(TDataModule)
    ds_Rech: TDataSource;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

//var
//  DMIBRech: TDMIBRech;
//  IBRechLgr: TIBRechLgr;
//  Function Initialise_DMIBRech:Boolean;

implementation

{$R *.dfm}

//Function Initialise_DMIBRech:Boolean;
//Begin
////  if DMIBRech = nil then DMIBRech:=TDMIBRech.Create(Application.MainForm);
////  if IBRechLgr = nil then IBRechLgr:=TIBRechLgr.Create(Application.MainForm);
//End;

constructor TIBRechLgr.Create(AOwner :TComponent);
Begin
 inherited create(AOwner);

 FListeChampValue:=TStringList.Create;
 FListeChamp:=TStringList.Create;
 FListeRech:=TStringList.Create;
 FListeTitreBD:=TStringList.Create;
 FListeEvent:=TStringList.Create;
// ShowMessage('TIBRechLgr.Create');
// FListeTitreBD.LoadFromFile('C:\Projet\AssoDons\Execution\Bd\Lib\TitreBD.lst');
// FDataSource.OnStateChange := dsFDataSourceStateChange;
// FCtrlChamp:=TCtrlChamp.Create(AOwner);
End;

destructor TIBRechLgr.Destroy;
Begin
 inherited Destroy;
 if FListeChampValue <> nil then FListeChampValue.Free;
 FListeChampValue:=nil;
 if FListeChamp <> nil then FListeChamp.Free;
 FListeChamp:=nil;
 if FListeRech <> nil then FListeRech.Free;
 FListeRech:=nil;
 if FListeEvent <> nil then FListeEvent.Free;
 FListeEvent:=nil;
 if FListeTitreBD <> nil then FListeTitreBD.Free;
 FListeTitreBD:=nil;
// if FCtrlChamp <> nil then FCtrlChamp.Free;
// FCtrlChamp:=nil;
End;

procedure TIBRechLgr.AjouteRech(NomRech,NomChampRech:string;SQL:TStrings;NotifyEvent:TNotifyEvent);
var
FIBQu:TIbQuery;
Begin
FIBQu:=TIBQuery.Create(nil);
FIBQu.Database:=FIBBase;
FIBQu.SQL:=SQL;
FIBQu.Open;
FListeRech.AddObject(NomRech,FIBQu);
FListeEvent.AddObject(NomRech,TEventAfficheEcran(@NotifyEvent));
FListeChamp:=FIBQu.FieldList;
End;

procedure TIBRechLgr.ActiverRech(NomRech:string;ControlClick:TControl);
var
i:Integer;
Begin
i:=FListeRech.IndexOf(NomRech);
if i <> -1 then
 begin
  if FListeRech.Objects[i] <> nil then
   begin
//    TIBQuery(FListeRech.Objects[i]).Close;
    if FListeTitreBD.Count = 0 then
     begin
        try
         FListeTitreBD.LoadFromFile(FNomRepertoireFichierTitreBDChamp);
        except
         MessageDlg('le fichier ['+FNomRepertoireFichierTitreBDChamp+'] est introuvable', mtWarning, [mbOK], 0);
        end;
     end;
    FDataSource.DataSet:=TIBQuery(FListeRech.Objects[i]);
    FIBQuery := TIBQuery(FListeRech.Objects[i]);
    TIBQuery(FListeRech.Objects[i]).Open;
    if FDbGrid <> nil then
    GrDbGridInitColonneEx(FDbGrid,FDataSource,FDataSource.DataSet,FListeTitreBD,'','');
    FListeChamp:=TIBQuery(FListeRech.Objects[i]).FieldList;
   end;
 end;
i:=FListeEvent.IndexOf(NomRech);
if i <> -1 then
 begin
  if ((FListeEvent.Objects[i] <> nil) and (ControlClick <> nil)) then
   begin
    @TButton(ControlClick).OnClick:=TEventAfficheEcran(FListeEvent.Objects[i]);
   end;
 end;
End;

function ExtractTitreSQL(SQL:TStrings):TStringList;
var
i:Integer;
Begin
for i:=0 to SQL.Count - 1 do
 begin
  
 end;
End;


procedure TIBRechLgr.SupprimeRech(NomRech:string);
var
i:Integer;
Begin
i:=FListeRech.IndexOf(NomRech);
if i <> -1 then
 begin
  if FListeRech.Objects[i] <> nil then
   begin
    TIBQuery(FListeRech.Objects[i]).Close;
    TIBQuery(FListeRech.Objects[i]).Free;
   end;
  FListeRech.Delete(i);
 end;
 // Permet de détruire toutes les recherches d'un coup
if ((i=-1) and (NomRech='*')) then
 begin
  while FListeRech.Count > 0 do
    begin
      if FListeRech.Objects[0] <> nil then
       begin
        TIBQuery(FListeRech.Objects[0]).Close;
        TIBQuery(FListeRech.Objects[0]).Free;
       end;
      FListeRech.Delete(0);
    end;

 end;
End;

function TIBRechLgr.LitChamp_Query(const NomChamp:string): String;
Begin
Result:= '';
ProtectObjetNil([FDataSource,FDataSource.DataSet]);
   if not FDataSource.DataSet.Active then FDataSource.DataSet.Open;
   if FDataSource.DataSet.findfield(NomChamp) <> nil then
    Result:= FDataSource.DataSet.findfield(NomChamp).AsString
   else
    MessageDlg('Le champ ['+NomChamp+'] est introuvable !', mtError, [mbOK], 0);
End;

// Lit et charge la liste des noms des champs avec leurs titres respectif.
// les éléments du fichier sont de la forme : NOMTABLE.NOMCHAMP=TITRECHAMP
// pour actidons, le fichier est : TitreBD2.lst
// Si la fonction ne trouve pas de titre correspondant à value, qui contient une
// valeur de type : NOMTABLE.NOMCHAMP, elle retourne value.
function TIBRechLgr.LitTitreChampAide(const Value : string):string;
var
i:Integer;
Begin
Result:=value;
if FListeTitreBD.Count = 0 then
 begin
//   if FileExists(FNomFichierTitreChamp+'TitreBD2.lst') then
//   if FileExists(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+'TitreBD2.lst') then
//    begin
    try
     FListeTitreBD.LoadFromFile(FNomRepertoireFichierTitreBDChamp);
    except
     MessageDlg('le fichier ['+FNomRepertoireFichierTitreBDChamp+'] est introuvable', mtWarning, [mbOK], 0);
    end;
//     FListeTitre.LoadFromFile(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+ 'TitreBD2.lst');
     i:=FListeTitreBD.IndexOfName(value);
     if i <> - 1 then
       Result:=FListeTitreBD.ValueFromIndex[i];
//    end
//   else
//    begin
//     MessageDlg('le fichier TitreBD2.lst est introuvable', mtWarning, [mbOK], 0);
//    end;
 end
 else
  begin
   i:=FListeTitreBD.IndexOfName(value);
   if i <> - 1 then
     Result:=FListeTitreBD.ValueFromIndex[i];
  end;
End;

procedure TIBRechLgr.EcritRepertoireFichierTitreBDChamp(Value : string);
Begin
  if not FileExists(Value) then
   Begin
    MessageDlg('Le fichier ['+Value+'] n''existe pas', mtError, [mbOK], 0);
   End
  else
   begin
    FNomRepertoireFichierTitreBDChamp:=value;
   end;
End;


end.
