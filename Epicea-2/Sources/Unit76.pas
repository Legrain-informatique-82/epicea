unit Unit76;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Gauges,  Dialogs,
 StrUtils,
  dbiprocs,
  bde,
  dbitypes,
  dbierrs, DB,
  DBTables,
  Gr_MultDos,
  E2_Librairie_Obj,
  Gr_Librairie_Obj,
  lib_chaine,
  TUtil32,
  DMConstantes,
  LibRessourceString,
  ReindexationTable;


type

    TBDEUtil = class;

  Tregeneration = class(TForm)
    Gauge: TGauge;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    Image1: TImage;
    BitBtn2: TBitBtn;
    Table1: TTable;
    MessageLB: TLabel;
    ChProgramme: TCheckBox;
    ChDossier: TCheckBox;
    ChExerciceCourant: TCheckBox;
    ChExerciceTous: TCheckBox;

    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RebuildTable(tableName:String);
    procedure ChExerciceCourantClick(Sender: TObject);
    procedure ChExerciceTousClick(Sender: TObject);
  private
    { Private declarations }
    BDEUtil: TBDEUtil;
    Stop : Boolean;
  public
    { Public declarations }
  end;
    TBDEUtil = class
    CbInfo: TUVerifyCallback;
    TUProps: CURProps;
    hDb: hDBIDb;
    vhTSes: hTUSes;
    constructor Create;
    destructor Destroy; override;
    function GetTCursorProps(szTable: String): Boolean;
    procedure RegisterCallBack;
    procedure UnRegisterCallBack;
  end;
var
  regeneration: Tregeneration;
  function SauvegardeTable(DestPath:string;SourcePath:string;Table:TTable):TexceptLGR;

implementation

uses E2_Main, DMRecherche, LibSQL, DMCorrection, LibFichRep;


{$R *.dfm}

constructor TBDEUtil.Create;
begin
  Check(TUInit(vhtSes));
end;

destructor TBDEUtil.Destroy;
begin
  Check(TUExit(vhtSes));
  inherited Destroy;
end;

function TBDEUtil.GetTCursorProps(szTable: String): Boolean;
begin
  if TUFillCURProps(vHtSes, PChar(szTable), TUProps) = DBIERR_NONE then
    Result := True
  else Result := False;
end;

procedure TBDEUtil.RegisterCallback;
begin
 Check(DbiRegisterCallBack(nil, cbGENPROGRESS, 0,
            sizeof(TUVerifyCallBack), @CbInfo, nil));
end;

procedure TBDEUtil.UnRegisterCallback;
begin
  Check(DbiRegisterCallBack(nil, cbGENPROGRESS, 0,
           sizeof(TUVerifyCallBack), @CbInfo, nil));
end;


procedure Tregeneration.BitBtn1Click(Sender: TObject);
var
Liste,ListeBackup,ListeDelete:Tstringlist;
i,j:integer;
ParamAffichageReindexation:TParamAffichageReindexation;
confirmation:boolean;
RepSauvProgramme:string;
ListeExercices:Tstringlist;
RepertoireExercice:string;
begin
try//except
//faire une copie des tables programme, dossier et exercice

if DMcorrections=nil then DMcorrections := TDMcorrections.Create(application.MainForm);

ParamAffichageReindexation.AffichageModal:=true;
ParamAffichageReindexation.Affiche:=true;
ParamAffichageReindexation.SelectionListeTable:=nil;  //DM_C_NomAliasExercice
ParamAffichageReindexation.SelectionListeTable:=TStringList.Create;
Liste := TStringList.Create;
ListeDelete:=TStringList.Create;
RepertoireExercice:='';

RepSauvProgramme:=IncludeTrailingPathDelimiter(E.RepertoireProgram)+'Sauve_Prog_Epicea\';
//Programme
if(ChProgramme.Checked)then
begin
Liste.Clear;

Session.GetTableNames(DM_C_NomAliasProgram, '*.db',true, false, Liste);
for i:=0 to Liste.count-1 do
  if str_position_caseInsensitive('_QSQ',Liste.Strings[i])=0 then
    begin
      ParamAffichageReindexation.SelectionListeTable.Add(E.RepertoireProgram+';'+Liste.Strings[i]+'; 1');
      if not DirectoryExists(RepSauvProgramme)then
        begin
            if CreateDir(RepSauvProgramme)  then
              begin
                  Showmessage('La création du répertoire de sauvegarde des tables du programme '+retourchariotsimple
                    +' n''a pas pu se faire, la régénération ne peut donc pas se poursuivre.');
                  SysUtils.abort;
              end;
        end;
      SauvegardeTable(RepSauvProgramme+Liste.Strings[i],IncludeTrailingPathDelimiter(E.RepertoireProgram)+Liste.Strings[i],nil);
    end;
end;

//Dossiers
if(ChDossier.Checked)then
begin
Liste.Clear;
Session.GetTableNames(DM_C_NomAliasDossier, '*.db',true, False, Liste);
for i:=0 to Liste.count-1 do
  if str_position_caseInsensitive('_QSQ',Liste.Strings[i])=0 then
    ParamAffichageReindexation.SelectionListeTable.Add(E.RepertoireDossier+';'+Liste.Strings[i]+'; 1');
end;


// Exercice courant
if(ChExerciceCourant.Checked)then
begin
Liste.Clear;
Session.GetTableNames(DM_C_NomAliasExercice, '*.db',true, False, Liste);
for i:=0 to Liste.count-1 do
  if str_position_caseInsensitive('_QSQ',Liste.Strings[i])=0 then
    ParamAffichageReindexation.SelectionListeTable.Add(E.RepertoireExercice+';'+Liste.Strings[i]+'; 1');
end;

// Tous les Exercices
if(ChExerciceTous.Checked)then
begin
  ListeExercices:=RecupExerciceDossier_Tous(E.ID_Dos);
  for j:=0 to ListeExercices.Count-1 do
    begin
     Liste.Clear;
     RepertoireExercice:=str_getstringelement(ListeExercices.Strings[j],1,';');
     Session.GetTableNames(RepertoireExercice, '*.db',true, False, Liste);
     for i:=0 to Liste.count-1 do
      if str_position_caseInsensitive('_QSQ',Liste.Strings[i])=0 then
        ParamAffichageReindexation.SelectionListeTable.Add(RepertoireExercice+';'+Liste.Strings[i]+'; 1');
    end;
end;
//ShowMessage(ParamAffichageReindexation.SelectionListeTable.Text);

if FermerDossier(E) then
  begin
       if(ChDossier.Checked)or(ChExerciceCourant.Checked)or(ChExerciceTous.Checked)then
         if not SauveDossier(nil,'','','-AvantRegenerationDesTables')then SysUtils.abort;

  confirmation:=(ParamAffichageReindexation.SelectionListeTable<>nil)and(ParamAffichageReindexation.SelectionListeTable.Count>0);
    if confirmation then
      begin
//        if (Application.MessageBox(Pchar('Une sauvegarde de votre dossier va être lancée.'+
//              retourchariotsimple+'Il est fortement conseillée de la faire afin de pouvoir' +
//              retourchariotsimple+'revenir sur la situation de votre comptabilité avant restructuration.'+
//              retourChariotDouble+'Toutefois, si vous ne souhaitez pas la faire, Cliquez sur "Non", sinon cliquez sur "Oui"'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes) then
//              begin
//                confirmation:=SauveDossier(nil,'','','_SauvegardeAvantRestructuration');
//              end;
              if confirmation then
              begin
                  try//finally
                      GestionGauge(1,Gauge,(ParamAffichageReindexation.SelectionListeTable.Count-1),1);
                        for i:=0 to ParamAffichageReindexation.SelectionListeTable.Count-1 do
                          begin
                                 if trim(str_getstringelement(ParamAffichageReindexation.SelectionListeTable.Strings[i],3,';'))='1'then
                                        begin //on ne travaille que sur les tables cochées
                                            //Table1.close;
                                            //Table1.databasename:=str_getstringelement(ParamAffichageReindexation.SelectionListeTable.Strings[i],1,';');
                                            //Table1.Tablename:=str_getstringelement(ParamAffichageReindexation.SelectionListeTable.Strings[i],2,';');
                                            RebuildTable(IncludeTrailingPathDelimiter(str_getstringelement(ParamAffichageReindexation.SelectionListeTable.Strings[i],1,';'))+str_getstringelement(ParamAffichageReindexation.SelectionListeTable.Strings[i],2,';'));
                                            //Table1.Open;
                                            //dbipacktable(Table1.DBHandle,Table1.Handle,Pchar(Table1.Tablename),szPARADOX,True);
                                            sleep(100);
                                            GestionGauge(1,Gauge);
                                        end;
                          end;
                  Finally
                  Application.MessageBox(Pchar('La restructuration c''est bien déroulée.'+retourChariotDouble+
                  'Epicéa va être fermé automatiquement.'+retourChariotDouble+'Vous pourrez le réouvrir pour continuer à travailler'),'Attention',MB_ICONEXCLAMATION );
                  Application.Terminate;
                  end;
              end;
      end;
  end;
except
  Application.MessageBox(Pchar('La restructuration ne c''est pas correctement déroulée.'+retourChariotDouble+
  AppelerServiceMaintenanceSimple),'Erreur',MB_ICONWARNING );
end;
close;
end;

procedure Tregeneration.FormActivate(Sender: TObject);
begin
Gauge.Progress:=0;
end;

procedure Tregeneration.FormDestroy(Sender: TObject);
begin
regeneration:=nil;
end;


procedure Tregeneration.RebuildTable(tableName:String);
var
  iFld, iIdx, iSec, iVal, iRI, iOptP, iOptD: word;
  szTable: String;
  rslt: DBIResult;
  Msg: Integer;
  TblDesc: CRTBlDesc;
  Backup: String;
  password : PAnsiChar;
begin
  Screen.Cursor := crHourGlass;
  try
  BDEUtil := TBDEUtil.Create;
    //ClearBars;
    Check(TUExit(BDEUtil.vHtSes));
    Check(TUInit(BDEUtil.vHtSes));
    szTable := tableName;
    BDEUtil.GetTCursorProps(tableName);
//  Session.AddPassword('lepelet');
    BDEUtil.RegisterCallBack;
    if(BDEUtil.TUProps.bProtected)then password := 'lepelet' else password:='';
    try
      Check(TUVerifyTable(BDEUtil.vHtSes, PChar(szTable), szPARADOX, 'VERIFY.DB',
           password, 0, Msg));
      rslt := TUGetCRTblDescCount(BDEUtil.vhTSes, PChar(szTable), iFld,
            iIdx, iSec, iVal, iRI, iOptP, iOptD);
      if rslt = DBIERR_NONE then begin
        FillChar(TblDesc, SizeOf(CRTBlDesc), 0);
        StrPCopy(TblDesc.szTblName, szTable);
        TblDesc.szTblType := szParadox;
        TblDesc.szErrTblName := 'Rebuild.DB';

        TblDesc.iFldCount := iFld;
        GetMem(TblDesc.pFldDesc, (iFld * SizeOf(FldDesc)));

        TblDesc.iIdxCount := iIdx;
        GetMem(TblDesc.pIdxDesc, (iIdx * SizeOf(IdxDesc)));

        TblDesc.iSecRecCount := iSec;
        GetMem(TblDesc.pSecDesc, (iSec * SizeOf(SecDesc)));

        TblDesc.iValChkCount := iVal;
        GetMem(TblDesc.pvchkDesc, (iVal * SizeOf(VCHKDesc)));

        TblDesc.iRintCount := iRI;
        GetMem(TblDesc.printDesc, (iRI * SizeOf(RINTDesc)));

        TblDesc.iOptParams := iOptP;
        GetMem(TblDesc.pfldOptParams, (iOptP * sizeOf(FLDDesc)));

        GetMem(TblDesc.pOptData, (iOptD * DBIMAXSCFLDLEN));
        try
           rslt := TUFillCRTblDesc(BDEUtil.vhTSes, @TblDesc, PChar(szTable), password);
           if rslt = DBIERR_NONE then begin
             Backup := 'Backup_lgr.Db';
             if TURebuildTable(BDEUtil.vhTSes, PChar(szTable), szPARADOX,
                 PChar(Backup), 'KEYVIOL.DB', 'PROBLEM.DB', @TblDesc) = DBIERR_NONE
             then MessageLB.Caption := 'Rebuild was successful.'
             else MessageLB.Caption := 'Rebuild was not successful.';
           end
           else
           Application.MessageBox(Pchar('Problème rencontré lors de la restructuration des tables'),'Attention',MB_ICONEXCLAMATION);

        finally
          FreeMem(TblDesc.pFldDesc, (iFld * SizeOf(FldDesc)));
          FreeMem(TblDesc.pIdxDesc, (iIdx * SizeOf(IdxDesc)));
          FreeMem(TblDesc.pSecDesc, (iSec * SizeOf(SecDesc)));
          FreeMem(TblDesc.pvchkDesc, (iVal * SizeOf(VCHKDesc)));
          FreeMem(TblDesc.printDesc, (iRI * SizeOf(RINTDesc)));
          FreeMem(TblDesc.pfldOptParams, (iOptP * sizeOf(FLDDesc)));
          FreeMem(TblDesc.pOptData, (iOptD * DBIMAXSCFLDLEN));
        end;
      end;
    finally
      BDEUtil.UnRegisterCallBack;
    end;
  finally
    Screen.Cursor := crDefault;
    BDEUtil.Free;
    //Session.RemoveAllPasswords;
  end;
end;


// Pack a Paradox or dBASE table
// The table must be opened execlusively before calling this function...
procedure PackTable(Table: TTable);
var
  Props: CURProps;
  hDb: hDBIDb;
  TableDesc: CRTblDesc;

begin
  // Make sure the table is open exclusively so we can get the db handle...
  if Table.Active = False then
    raise EDatabaseError.Create('Table must be opened to pack');
  if Table.Exclusive = False then
    raise EDatabaseError.Create('Table must be opened exclusively to pack');

  // Get the table properties to determine table type...
  Check(DbiGetCursorProps(Table.Handle, Props));

  // If the table is a Paradox table, you must call DbiDoRestructure...
  if Props.szTableType = szPARADOX then
  begin
    // Blank out the structure...
    FillChar(TableDesc, sizeof(TableDesc), 0);
    //  Get the database handle from the table's cursor handle...
    Check(DbiGetObjFromObj(hDBIObj(Table.Handle), objDATABASE, hDBIObj(hDb)));
    // Put the table name in the table descriptor...
    StrPCopy(TableDesc.szTblName, Table.TableName);
    // Put the table type in the table descriptor...
    StrPCopy(TableDesc.szTblType, Props.szTableType);
    // Set the Pack option in the table descriptor to TRUE...
    TableDesc.bPack := True;
    // Close the table so the restructure can complete...
    Table.Close;
    // Call DbiDoRestructure...
    Check(DbiDoRestructure(hDb, 1, @TableDesc, nil, nil, nil, FALSE));
  end
  else
    // If the table is a dBASE table, simply call DbiPackTable...
    if Props.szTableType = szDBASE then
      Check(DbiPackTable(Table.DBHandle, Table.Handle, nil, szDBASE, TRUE))
    else
      // Pack only works on PAradox or dBASE; nothing else...
      raise EDatabaseError.Create('Table must be either of Paradox or dBASE ' +
               'type to pack');

  Table.Open;
end;


//Procedure CreationTableRestructuration;
//begin
//if not FileExists(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'VERIFY.DB') then
////begin
////  DMcorrections.QuCorrectionDossier.close;
////  DMcorrections.QuCorrectionDossier.SQL.Clear;
////  DMcorrections.QuCorrectionDossier.sql.Add('create table VERIFY.DB (Drive varchar(2),Directory varchar(255),'+
////  'Table Name varchar(255),Extension varchar(4),Error Code short,Error Level short,Error Message varchar(150),Date DATE,Time TIME');
////  DMcorrections.QuCorrectionDossier.ExecSQL;
////  TableGereCommit(DMcorrections.QuCorrectionDossier);
////end;
//end;



function SauvegardeTable(DestPath:string;SourcePath:string;Table:TTable):TexceptLGR;
begin
  try
     CopyAllFiles(PChar(str_remplacesouschaine(SourcePath,ExtractFileExt(SourcePath),'.*')),
     pchar(IncludeTrailingPathDelimiter(ExtractFilePath(PChar(DestPath)))),false,'Sauvegarde des tables du programme en cours');
  except
     result.retour:=false;
  end;
end;


procedure Tregeneration.ChExerciceCourantClick(Sender: TObject);
begin
if ChExerciceCourant.Checked then
  ChExerciceTous.Checked:=false;
end;

procedure Tregeneration.ChExerciceTousClick(Sender: TObject);
begin
if  ChExerciceTous.Checked then
  ChExerciceCourant.Checked:=false;
end;

end.
