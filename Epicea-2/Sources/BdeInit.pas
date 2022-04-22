// MFDev - 03/2006 - v0.8
// Gestion du BDE
UNIT BdeInit;
 
INTERFACE
 uses
	SysUtils, StrUtils, Dialogs, Forms, ShellAPI,Registry, Windows,bde, Classes, DbTables,DB;

	function Test_BDE(sDirEXE: string; Table: TTable): boolean;
  function VerifBDE(const sDirExe: string): boolean;
 function BDE_ReInitLocalShare: boolean;
  function BDE_InitComplet(sDir: string): boolean;
  function BDE_Exist: string;
  function LocalShareIsTrue : Boolean;
  procedure DLLSetConfigParameter32(DLLHandle:THandle; Param: string; Value: string);
  procedure SetConfigParameter32(Param: PChar; Value: PChar);
  procedure SetConfigParameter(Param: PChar; Value: PChar);
  
IMPLEMENTATION
 const
	csBDEDir = 'SOFTWARE\Borland\Database Engine';  // HKLM
	csBDEDirFormat = 'Software\Borland\Database Engine\Settings\System\FORMATS';
	csBDEDirSystem = 'Software\Borland\Database Engine\Settings\System';
	csBDEDirDriver = 'Software\Borland\Database Engine\Settings\DRIVERS\PARADOX';
	csNetDir = 'NET DIR';
	csCfg = 'IDAPI32.CFG';
	csHKU = 'HKU';
  PARADOXNETDIR = '\DRIVERS\PARADOX\INIT\;NET DIR';
   LOCALSHARE = '\SYSTEM\INIT\;LOCAL SHARE';
type
 TSetConfigParameter32=procedure(Param:PChar;Value:PChar);
 EBBDBDBDEError=class(Exception);

// write Key in Registry
function bWriteStringReg(const csRoot, csClef, csSection: string; sValeur: string): boolean;
 var
	Reg: TRegistry;
 begin
// ex: bEcrireString('\Demarrage', 'Tranche', sChaine)
	Result := false;
	Reg := TRegistry.Create;
	TRY
		if csRoot <> csHKU then
			Reg.RootKey := HKEY_LOCAL_MACHINE;
		// true pour la créer si elle n'existe pas
		if Reg.OpenKey(csClef, true) then begin
			Reg.WriteString(csSection, sValeur);
			Result := true;
		end;
	FINALLY
		Reg.CloseKey;
		Reg.Free;
	END;
 end;
 
// Exist BDE in Registry
function BDEExist: boolean;
 var
	Reg: TRegistry;
	sFileIdapi: string;
 begin
	Result := false;
	Reg := TRegistry.Create;
	with Reg do begin
		RootKey := HKEY_LOCAL_MACHINE;
		OpenKey('SOFTWARE\Borland\Database Engine', False);
		TRY
			sFileIdapi := ReadString('CONFIGFILE01');
			// BDE installed
			if sFileIdapi <> '' then begin
				if FileExists(sFileIdapi) then
					Result := true;
					// force NetDir = Dir BDE
					sFileIdapi := ReadString('DLLPATH');
					bWriteStringReg('', csBDEDirDriver + '\INIT', csNetDir, sFileIdapi);

			end;
		FINALLY
			CloseKey;
			Free;
		END;
	end;  // with
 end;
 
// Init Registry
function BDE_ReInitLocalShare: boolean;
begin
	TRY
    SetConfigParameter32(LOCALSHARE, 'false');
    Session.SaveConfigFile;
		Result := true;     
	EXCEPT
		Result := false;
    showmessage('La mise à jour du Bde ne s''est pas déroulée correctement');
	END;
 end;

function BDE_InitComplet(sDir: string): boolean;
 begin
	Session.NetFiledir := sDir;	// sNetDir;
	TRY
//		bWriteStringReg('', csBDEDir, 'DLLPATH', sDir);
//		bWriteStringReg('', csBDEDir, 'CONFIGFILE01', sDir + '\' + csCfg);
//		bWriteStringReg('', csBDEDir, 'SAVECONFIG', 'WIN32');
//		bWriteStringReg('', csBDEDir, 'UseCount', '1');
//		bWriteStringReg('', csBDEDir, 'RESOURCE', '000C');
    ShellExecute(application.Handle,nil,Pchar(ExtractFileDir(Application.ExeName)+'\BDE.reg'), nil,
            NiL, SW_SHOWNORMAL);
//		bWriteStringReg('', csBDEDirSystem + '\INIT', 'LOCAL SHARE', 'FALSE');
//		bWriteStringReg('', csBDEDirSystem + '\INIT', 'VERSION', '4.0');
//		bWriteStringReg('', csBDEDirSystem + '\INIT', 'MINBUFSIZE', '2048');
//		bWriteStringReg('', csBDEDirSystem + '\INIT', 'MAXBUFSIZE', '4096');
//		bWriteStringReg('', csBDEDirSystem + '\INIT', 'LANGDRIVER', 'Pdox ANSI Intl');
//		bWriteStringReg('', csBDEDirSystem + '\INIT', 'MAXFILEHANDLES', '100');
//		bWriteStringReg('', csBDEDirSystem + '\INIT', 'SYSFLAGS', '0');
//		bWriteStringReg('', csBDEDirSystem + '\INIT', 'LOW MEMORY USAGE LIMIT', '64');
//		bWriteStringReg('', csBDEDirSystem + '\INIT', 'AUTO ODBC', 'FALSE');
//		bWriteStringReg('', csBDEDirSystem + '\INIT', 'DEFAULT DRIVER', 'PARADOX');
//		bWriteStringReg('', csBDEDirSystem + '\INIT', 'SHAREDMEMSIZE', '4096');
//		bWriteStringReg('', csBDEDirSystem + '\INIT', 'SHAREDMEMLOCATION', '');
//		bWriteStringReg('', csBDEDirSystem + '\INIT', 'DATA REPOSITORY', '');
//		bWriteStringReg('', csBDEDirSystem + '\INIT', 'MEMSIZE', '32');
//		bWriteStringReg('', csBDEDirSystem + '\INIT', 'SQLQRYMODE', '');
//		bWriteStringReg('', csBDEDirSystem + '\INIT', 'MTS POOLING', 'FALSE');
// 
//		bWriteStringReg('', csBDEDirFormat + '\DATE', 'MTS POOLING', 'FALSE');
//		bWriteStringReg('', csBDEDirFormat + '\DATE', 'SEPARATOR', '/');
//		bWriteStringReg('', csBDEDirFormat + '\DATE', 'MODE', '1');
//		bWriteStringReg('', csBDEDirFormat + '\DATE', 'FOURDIGITYEAR', 'TRUE');
//		bWriteStringReg('', csBDEDirFormat + '\DATE', 'YEARBIASED', 'FALSE');
//		bWriteStringReg('', csBDEDirFormat + '\DATE', 'LEADINGZEROM', 'TRUE');
//		bWriteStringReg('', csBDEDirFormat + '\DATE', 'LEADINGZEROD', 'TRUE');
// 
//		bWriteStringReg('', csBDEDirFormat + '\TIME', 'TWELVEHOUR', 'FALSE');
//		bWriteStringReg('', csBDEDirFormat + '\TIME', 'AMSTRING', 'AM');
//		bWriteStringReg('', csBDEDirFormat + '\TIME', 'PMSTRING', 'PM');
//		bWriteStringReg('', csBDEDirFormat + '\TIME', 'SECONDS', 'TRUE');
//		bWriteStringReg('', csBDEDirFormat + '\TIME', 'MILSECONDS', 'FALSE');
// 
//		bWriteStringReg('', csBDEDirFormat + '\NUMBER', 'DECIMALSEPARATOR', ',');
//		bWriteStringReg('', csBDEDirFormat + '\NUMBER', 'THOUSANDSEPARATOR', '.');
//		bWriteStringReg('', csBDEDirFormat + '\NUMBER', 'DECIMALDIGITS', '2');
//		bWriteStringReg('', csBDEDirFormat + '\NUMBER', 'LEADINGZERON', 'TRUE');
//
//		bWriteStringReg('', csBDEDirDriver + '\INIT', csNetDir, sDir);
//		bWriteStringReg('', csBDEDirDriver + '\INIT', 'VERSION', '4.0');
//		bWriteStringReg('', csBDEDirDriver + '\INIT', 'TYPE', 'FILE');
//		bWriteStringReg('', csBDEDirDriver + '\INIT', 'LANGDRIVER', 'Pdox ANSI Intl');
//
//		bWriteStringReg('', csBDEDirDriver + '\TABLE CREATE', 'LEVEL', '7');
//		bWriteStringReg('', csBDEDirDriver + '\TABLE CREATE', 'BLOCK SIZE', '4096');
//		bWriteStringReg('', csBDEDirDriver + '\TABLE CREATE', 'FILL FACTOR', '95');
//		bWriteStringReg('', csBDEDirDriver + '\TABLE CREATE', 'STRICTINTEGRTY', 'FALSE');		Result := true;
	EXCEPT
		Result := false;
	END;
 end;

// Install BDE Default
// disk:
//  \
//  |
//  Dir x
//   |
//   |- Rep EXE
//   |- Rep BDE
function VerifBDE(const sDirExe: string): boolean;
 var
	i: integer;
	sDirBde: string;
	Opendialog: TOpenDialog;
 begin
	Result := false;
	if not BDEExist then begin
		if Length(sDirExe) > 3 then begin
			for i := Length(sDirEXE) - 1 downto 1 do begin
				if Copy(sDirEXE, i, 1) <> '\' then
					Continue;
				sDirBde := Copy(sDirEXE, 1, i);	// rep -1
				Break;
			end;
		end
		else
			sDirBde := sDirExe;
		sDirBde := sDirBde + 'DBD\';
		TRY
			ChDir(sDirBde);
		EXCEPT
			on E:EInOutError do begin
				ShowMessage('STOP: Moteur de bases de données non trouvé. Définir le chemin...');
				OpenDialog := TOpenDialog.Create(nil);
				with OpenDialog do begin
					InitialDir := sDirExe;
					Filter := ' Fichiers config BDE|' + csCfg;
					Title := 'Sélectionner le Fichier Config du BDE: ' + csCfg;
					if OpenDialog.Execute then begin
						sDirBde := FileName;
						OpenDialog.Free;
						// Extrait Dir BDE
						i := PosEx('\', sDirBde, Length(sDirBde) - Length(csCfg) - 1);
						if i > 3 then
							sDirBde := Copy(sDirBde, 1, i);	// rep BDE
					end
					else begin
						OpenDialog.Free;
						Exit;
					end;
				end;	// with
			end;	// on
		END;
		TRY
			ChDir(sDirBde);
		EXCEPT
			on E:EInOutError do
				Exit;
		END;
		if IOResult = 0 then	// Dir existe
			sDirBde := GetCurrentDir;
		if not FileExists(sDirBde + '\' + csCfg) then begin
			// a priori BDE inexistant
			ShowMessage('STOP: Moteur de bases de données non trouvé. L''application ne peut continuer...');
			Exit;
		end;
		// BDE trouvé, màj Base de Registre
		if BDE_InitComplet(sDirBde) then // init Dir BDE
			ShowMessage('Moteur de Base de Données inialisé ...');
		ChDir(sDirEXE);	// restore Dir demarrage EXE
	end;	// if
	Result := true;
 end;
// Test BDE Registry
function BDE_Exist: string;
 var
	Reg: TRegistry;
	sFileIdapi: string;
 begin
	Result := '';
	Reg := TRegistry.Create;
	with Reg do begin
		RootKey := HKEY_LOCAL_MACHINE;
		OpenKey(csBDEDir, false);
		TRY
			sFileIdapi := ReadString('CONFIGFILE01');
			// BDE installed
			if sFileIdapi <> '' then begin
				if FileExists(sFileIdapi) then
					Result := ReadString('DLLPATH');
					// force NetDir = Dir du BDE
					bWriteStringReg('', csBDEDirDriver + '\INIT', csNetDir, Result);
			end;
		FINALLY
			CloseKey;
		END;
	end;  // with
 end;
// Test, clear, delete, create Alias
function InitAlias(Session: TSession; csTypeTable: string; Table: TTable; var sBDDir: string): boolean;
 var
	sAlias: string;
 begin
	Result := false;
	sAlias := Table.DatabaseName;	// Alias
	with Session do begin
		if IsAlias(sAlias) then begin	// Exist = delete
			DeleteAlias(sAlias);
			SaveConfigFile;
		end;
		ConfigMode := cmAll;
		if not IsAlias(sAlias) then begin	// création
			AddStandardAlias(sAlias, sBDDir, csTypeTable);	// crée en memoire le nouvel Alias
		end;
		SaveConfigFile;
	end;	// with
	TRY
		// vérification
		Table.Open;
		Table.Close;
		Result := true;
	EXCEPT
		on E:EDBEngineError do
			if (E.Errors[0].ErrorCode = 11011) then begin
				ShowMessage('Les bases de données n''existent pas dans <' + sAlias + '>. Application indisponible !');
			end;
	END;
 end;
 
function Test_BDE(sDirEXE: string; Table: TTable): boolean;
 var
	i: integer;
	sBDDir: string;
	Opendialog: TOpenDialog;
 begin
	Result := false;
	TRY
		Table.Open;
	EXCEPT
		// vérif si BDE installé
		if not VerifBDE(sDirExe) then begin
			ShowMessage('Moteur Base de donnée non trouvé ... cela ne sert à rien de continuer !');
			Exit;
		end;
	END;
	sBDDir := sDirExe;
	if not FileExists(sDirExe + Table.TableName) then begin
		OpenDialog := TOpenDialog.Create(nil);
		with OpenDialog do begin
			InitialDir := sDirExe;
			Filter := ' Fichiers Base de donnée|' + Table.TableName;
			Title := 'Sélectionner la Base de donnée: ' + Table.TableName;
			if OpenDialog.Execute then begin
				sBDDir := FileName;
				OpenDialog.Free;
				i := PosEx('\', sBDDir, Length(sBDDir) - Length(Table.TableName) - 1);
				if i > 3 then
					sBDDir := Copy(sBDDir, 1, i);	// rep BDE
			end
			else begin
				OpenDialog.Free;
				ShowMessage('BD inaccessible. Terminé');
				Exit;
			end;
		end;	// with
	end;
	ChDir(sBDDir);
	sBDDir := GetCurrentDir;	// format standard
	if not InitAlias(Session, 'PARADOX', Table, sBDDir) then begin
		ShowMessage('Impossible de trouver les Bases de données ... cela ne sert à rien de continuer !');
		Exit;
	end;	// if
	Result := true;
 end;


procedure config;
 var
  hCur : hDBICur;
  Config : CFGDesc;
  ContinueIt: boolean;
 begin
  if DbiInit(nil) = DBIERR_NONE then
  begin
    hCur := nil;
    if DbiOpenCfgInfoList(nil, dbiREADWRITE, cfgPersistent,
        '\\DRIVERS\\PARADOX\\INIT', hCur) = DBIERR_NONE then
    begin
      if DbiSetToBegin(hCur) = DBIERR_NONE then
      begin
        ContinueIt := true;
        while ContinueIt do
        begin
          if(DbiGetNextRecord(hCur, dbiWRITELOCK, @Config, nil)
                 <> DBIERR_NONE) then
            ContinueIt := false
          else
            if StrIComp(Config.szNodeName, 'NET DIR') = 0 then
            begin
              StrCopy(Config.szValue, 'servervolumemydir');
              DbiModifyRecord(hCur, @Config, true);
              ContinueIt := false
            end;
        end;
      end;
    end;
    DbiExit();
  end;
  END;


function LocalShareIsTrue : Boolean;
var
  SL : TStringList;
begin
  { Ensure BDE is initialised }
  Session.Open;
  SL := TStringList.Create;
  //bWriteStringReg('', csBDEDir, 'CONFIGFILE01', ExtractFileDir(Application.ExeName) + '\' + csCfg);
  Session.GetConfigParams('\System\Init','',SL);
  result := ('TRUE' = SL.Values['LOCAL SHARE']);
  SL.Free;
end;



//******************************************************************************
// Name:          SetConfigParameter32
// Beschreibung:  Set a particular value in the IDAPI.CFG configuration file
//                (32-Bit Only, All Versions)
//
//                You must use this procedure version if you are using
//                BDE v4.50 and earlier
//
//
// Datum:         22.04.1999
// Programmierer: Pascal Berger
// Version:       1.0.1
// Parameter:
//   Input:       Param:
//                Value:
//   Output:      Kein
//
// History:       1.0.1     Exception der DLL wird ausgegeben               //BP
//
//******************************************************************************
procedure DLLSetConfigParameter32(DLLHandle:THandle; Param: string; Value: string);
var MyFunction:TSetConfigParameter32;
    FuncPtr:TFarProc;
const FuncName='SetConfigParameter32';
begin
  FuncPtr:=GetProcAddress(DLLHandle,FuncName);
  if FuncPtr<>nil then begin
    @MyFunction:=FuncPtr;
    try
      MyFunction(PChar(Param),PChar(Value));
    except
      on E: Exception do
        raise EBBDBDBDEError.Create(
          'Exception EBBDBDBDEError: Error at function '+FuncName+' '+#13+#13+
          'Error message: '+E.Message);
    end;
  end
  else raise EBBDBDBDEError.Create(
   'Exception EBBDBDBDEError: Could not load function '+FuncName);
end;

//******************************************************************************
// Name:          SetConfigParameter32
// Descrioption:  Set a particular value in the IDAPI.CFG configuration file
//                (32-Bit Only, All Versions)
//
//                You must use this procedure version if you are using
//                BDE v4.50 and earlier
//
//
// Datum:         01.04.1999
// Programmer: Pascal Berger
// Parameter:
//   Input:       Param:
//                Value:
//   Output:      none
//
// History:
//
// To Do:
//
// #ToDo1 Not Tested
//
//******************************************************************************

procedure SetConfigParameter32(Param: PChar; Value: PChar);
var hCfg: hDBICfg;
    Config: SYSConfig;
    Path, Option: string;
    ParamCount, I: word;
    pFields, pFld: pFLDDesc;
    pRecBuf, pRec: pBYTE;
    Found, SelfInitialized: boolean;
    rslt: DBIResult;
begin
  {$Ifdef WIN32}
    hCfg := nil; pFld := nil; pRec := nil; Found := False; SelfInitialized := False;
    try
      if Pos(';', Param) = 0 then
        raise EDatabaseError.Create('Invalid parameter passed. '+
          'Need a semicolon seperated string');
      Path := Copy(Param, 0, Pos(';', Param) - 1);
      Option := Copy(Param, Pos(';', Param) + 1, Length(Param) - Pos(';', Param));
      rslt := DbiGetSysConfig(Config);
      if rslt <> DBIERR_NONE then begin
        if rslt = DBIERR_NOTINITIALIZED  then begin// Engine not initialized error...
          SelfInitialized := True;
          DbiInit(nil);
          Check(DbiGetSysConfig(Config));
        end
        else
          Check(rslt);
      end;
      (* DbiOpenConfigFile is defined as such:
         function DbiOpenConfigFile (            { Open/Create configuration }
               pszDirPath    : PChar;            { Directory }
               bCreate       : Bool;             { TRUE to create/overwrite }
         var   hCfg          : hDBICfg           { Handle to config }
                            ): DBIResult stdcall; *)
      Check(DbiOpenConfigFile(Config.szIniFile, FALSE, hCfg));

      (* DbiCfgGetRecord is defined as such:
         function DbiCfgGetRecord (              { Get a record }
               hCfg          : hDBICfg;          { Config Handle/NULL }
               pszCfgPath    : PChar;            { Path }
         var   iFields       : Word;             { Returned nbr of fields }
               pfldDesc      : pFLDDesc;         { Field descriptors }
               pRec          : Pointer           { Field values }
                            ): DBIResult stdcall; *)
      { Call it without the field and record buffer to get the count... }
      Check(DbiCfgGetRecord(hCfg, PChar(Path), ParamCount, nil, nil));

      pFields := AllocMem(ParamCount * sizeof(FLDDesc));
      pFld := pFields;
      pRecBuf := AllocMem(10000);
      pRec := pRecBuf;

      { Get the node values... }
      Check(DbiCfgGetRecord(hCfg, PChar(Path), ParamCount, pFields, pRecBuf));

      for I := 0 to ParamCount - 1 do begin
        if pFields^.szName = Option then begin
          StrPCopy(PChar(pRecBuf), Value);

          (* DbiCfgModifyRecord is defines as such:
             function DbiCfgModifyRecord (           { Modify a record }
                     Cfg          : hDBICfg;          { Config Handle/NULL }
                    pszCfgPath    : PChar;            { Path }
                    iFields       : Word;             { Nbr of fields }
                    pfldDesc      : pFLDDesc;         { Field descriptors }
                    pRec          : Pointer           { Data values }
             ): DBIResult stdcall; *)
          Check(DbiCfgModifyRecord(hCfg,  PChar(Path), ParamCount, pFld, pRec));

          Found := True;
        end;
        Inc(pFields);
        Inc(pRecBuf, 128);
      end;
      if Found = False then
        raise EDatabaseError.CreateFmt('Could not find %s '+
          'in the configfile',[param]);

    finally
      if pFld <> nil then
        FreeMem(pFld);
      if pRec <> nil then
        FreeMem(pRec);
      if hCfg <> nil then

      (* DbiCloseConfigFile is defined as such:
         function DbiCloseConfigFile (           { Close the config file }
         var   hCfg          : hDBICfg;          { Handle }
               bSave         : Bool;             { To save the changes }
               bDefault      : Bool;             { To make this file the default }
               bSaveAs16     : Bool              { To save as a 16-bit config file }
         ): DBIResult stdcall; *)
      { Close and save the config file... }
      Check(DbiCloseConfigFile(hCfg, TRUE, TRUE, FALSE));
      if SelfInitialized = True then
        DbiExit;
    end;
  {$Else}
    raise EDatabaseError.Create('Not a supported 16-Bit function');
  {$EndIf}
end;

procedure SetConfigParameter(Param: PChar; Value: PChar);
var hCur: hDBICur;
    rslt: DBIResult;
    Config: CFGDesc;
    Path, Option: string;
    Found: boolean;
    Temp: array[0..255] of char;
begin
  hCur := nil;
  Found := False;
  try
    if Pos(';', Param) = 0 then
      raise EDatabaseError.Create('Invalid parameter passed. '+
        'Need a semicolon seperated string');
    Path := Copy(Param, 0, Pos(';', Param) - 1);
    Option := Copy(Param, Pos(';', Param) + 1, Length(Param) - Pos(';', Param));
    Check(DbiOpenCfgInfoList(nil, dbiREADWRITE, cfgPERSISTENT, StrPCopy(Temp, Path), hCur));
    repeat
      rslt := DbiGetNextRecord(hCur, dbiNOLOCK, @Config, nil);
      if rslt = DBIERR_NONE then begin
        if StrPas(Config.szNodeName) = Option then begin
          StrPCopy(Config.szValue, Value);
          Check(DbiModifyRecord(hCur, @Config, FALSE));
          Found := True;
          break;
        end;
      end
      else
        if rslt <> DBIERR_EOF then Check(rslt);
    until rslt <> DBIERR_NONE;
    if Found = False then
      raise EDatabaseError.CreateFmt('Could not find %s '+
        'in the configfile',[param]);
  finally
    if hCur <> nil then Check(DbiCloseCursor(hCur));
  end;
end;


END.
