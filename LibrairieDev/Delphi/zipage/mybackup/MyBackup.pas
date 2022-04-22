unit MyBackup;

{
  This component are freeware. You may use it, distribute it and modify it, but
you may not charge for it.
In case of modifications you must mail me (mmm@imaginet.fr) a copy of
the modifications. The reason are simple: Any changes that improve this free-
ware component should be to benefit for everybody, not only you. That way you
can be pretty sure, that this component has few errors and much functionality.
In case of modifications, you will be on the credits list beneath:}

{ Version 1.0 (25/06/97) by Morgan Martinet (France):

          This version is the base version.
  This Component let you backup/restore a set of files in a directory. It will
  split the files if they don't fit in the Backup unit. I use this component
  with the Delphi Zip component that implements PK(UN)ZIP v2.04g, and it works
  perfectly ! So I first make a zipped archive of my directories and then
  I use MyBackup to to put this archives on disks because DelphiZip doesn't
  implement segmented archives.

  Properties:
    DrivePath = sets the path of the backup unit (by default it is A:\)
    FilesPath = sets the path from where the files will be backed up
                or to where the files will be restored.
    BackupCaption = sets a title for the Backup operation
    RestoreCaption = sets a title for the Restore operation
    ConfirmDelete = lets you specify if the user will be warned when the component
                    will need to erase the files of DrivePath
    Version = sets the Version of your software that did the
              backup, in order to update your files if the backup is older
              than the current version.
    ID = sets a personal ID in order to identify the product
         that did the backup and avoid restoring the backup of
         another product.
    IdLabel = sets a label for the Id of the Backup. This label will
              be displayed when an Id's disk does not match the Id of this
              component (cf. ID).
    BackupName = sets a name for the backup.
    UserName = sets the name of the registered user of your
               software in order to check the origin of a backup.
    UserCompany = sets the company of the registered user of your
                  software in order to check the origin of a backup.
    UserLicence = sets the licence of the registered user of your
                  software in order to check the origin of a backup.
    InfosFileName = sets the name of the file that contains
                    the informations about the backup and that will be
                    written on each disk.

  For this properties look at the comments in the CopyFile component
    Progress
    OnStartOperation
    OnFinishOperation
    OnOperationProgress
    OnEachFile

  Methods:
    Backup = start the backup process
    Restore = start the restore process
    CheckFirstDisk = check if the disk inserted contains
                     the first disk of a backup
    GetInfos = get the file that contains the informations
               about the backup into a list of strings (TStrings).
               You can then get the informations like:
               var
                 SL : TStringList;
               begin
                 SL := TStringList.Create;
                 try
                   if GetInfos( SL ) then
                     begin
                       version := SL.Values['Version'];
                       disk_num := StrToInt(SL.Values['Disk#']);
                       name := SL.Values['Backup.Name'];
                     end
                   else
                     // error !
                 finally
                   SL.Free;
                 end;
               end;
}

{ Version 1.1 (09/10/97) Morgan Martinet (France):
  Added property Filter in order to filter the files of the FilesPath to be backed up.
  Added property FilesToBackup (StringList) in order to backup a list of files
        instead of the content of the FilesPath directory.
  Added property FilesRestored (StringList) in order to know which files
        were restored.
  Modified Backup procedure: if the FilesToBackup list is not empty, we use this list
        in order to do the backup, otherwise we use the files of the FilesPath directory.
  Modified Restore procedure: we update the FilesRestored list, as we restore a new file.
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CopyFile;

const
  kMinDiskSpace = 1024*8;
  kInfosFile = 'infos.txt';
  // French constants
  sSystemMessage            = 'Message syst�me';
  sNeedValidDrivePath       = 'Vous devez fournir un chemin d''acc�s valide pour l''unit� de sauvegarde';
  sInsertDiskXInUnit        = 'Veuillez ins�rer la disquette n� %d dans l''unit� %s:';
  sDeletingFilesOfDrivePath = 'Suppression des fichiers sur l''unit� de sauvegarde...';
  sAskForDeletionOfFiles    = 'L''unit� de sauvegarde contient un ou plusieurs fichiers. D�sirez-vous les supprimer ?';
  sCouldNotDeleteAllFiles   = 'Impossible de supprimer tous les fichiers !';
  sThisDiskIsNotTheFirstOne = 'Cette disquette n''est pas la premi�re du jeu de sauvegarde.';
  sThePathDoesNotExist      = 'Le chemin "%s" n''existe pas';
  sCopyOf                   = 'Copie de %s';
  sCouldNotWriteInFile      = 'Impossible d''�crire dans le fichier %s';
  sThisDiskContainsNoBackup = 'Cette disquette ne contient pas de sauvegarde';
  sWrongBackupSet           = 'Cette disquette n''appartient pas au jeu de sauvegardes: %s';
  sWrongBackupName          = 'Cette disquette contient une sauvegarde de "%s" au lieu de "%s".';

  // English constants
{
  sSystemMessage            = 'System message';
  sNeedValidDrivePath       = 'You must give a valid path to the backup drive';
  sInsertDiskXInUnit        = 'Please, insert disk #%d in drive %s:';
  sDeletingFilesOfDrivePath = 'Deleting files of backup drive...';
  sAskForDeletionOfFiles    = 'Backup drive contains files. Do you want to delete them ?';
  sCouldNotDeleteAllFiles   = 'Could not delete all files !';
  sThisDiskIsNotTheFirstOne = 'This disk is not the first of the backup disks set.';
  sThePathDoesNotExist      = 'The path "%s" does not exist';
  sCopyOf                   = 'Copy of %s';
  sCouldNotWriteInFile      = 'Could not write in file %s';
  sThisDiskContainsNoBackup = 'This disk does not contain any backup.';
  sWrongBackupSet           = 'This disk does not belong to the backup set: %s';
  sWrongBackupName          = 'This disk contains a backup of "%s" instead of "%s".';
 }
type
  TOperation = (opBackup, opRestore, opNone);

  TMyBackup = class(TCustomCopyFile)
  private
    { D�clarations priv�es }
  protected
    { D�clarations prot�g�es }
    FDrivePath : String;
    FFilesPath : String;
    FBackupCaption : String;
    FRestoreCaption : String;
    FConfirmDelete : Boolean;
    FOperation : TOperation;
    FVersion : String;
    FID : String;
    FIdLabel : String;
    FBackupName : String;
    FDrive : Char;
    FUserName : String;
    FUserCompany : String;
    FUserLicence : String;
    FDiskCount : Integer;
    FCurrentFile : String;
    FInfosFileName : String;
    FOneMoreDisk : Boolean;
    FCurBackup : String;
    FFilesToBackup : TStringList; // Contains the list of the files to be backed up.
    FFilesRestored : TStringList; // Contains the list of the files restored.

    procedure SetFilesToBackup( val : TStringList );
    procedure SetFilesRestored( val : TStringList );
    procedure CheckDrive;
    procedure NextDisk;
    function  CheckDiskContent : Boolean;
    procedure CheckPath;
    procedure WriteFiles;
    procedure WriteFile( const FileName : String );
    procedure WriteInfos;
    procedure ReadFiles;
    procedure ReadFile( const FileName : String );

  public
    { D�clarations publiques }
    constructor Create( AOwner : TComponent ); override;
    destructor  Destroy; override;

    procedure Backup;
    procedure Restore;

    function  CheckFirstDisk : Boolean;
    function  GetInfos( SL : TStringList ) : Boolean;

  published
    { D�clarations publi�es }
    property DrivePath : String read FDrivePath write FDrivePath;
    property FilesPath : String read FFilesPath write FFilesPath;
    property FilesToBackup : TStringList read FFilesToBackup write SetFilesToBackup;
    property FilesRestored : TStringList read FFilesRestored write SetFilesRestored;
    property BackupCaption : String read FBackupCaption write FBackupCaption;
    property RestoreCaption : String read FRestoreCaption write FRestoreCaption;
    property ConfirmDelete : Boolean read FConfirmDelete write FConfirmDelete default True;
    property Version : String read FVersion write FVersion;
    property ID : String read FID write FID;
    property IdLabel : String read FIdLabel write FIdLabel;
    property BackupName : String read FBackupName write FBackupName;
    property UserName : String read FUserName write FUserName;
    property UserCompany : String read FUserCompany write FUserCompany;
    property UserLicence : String read FUserLicence write FUserLicence;
    property InfosFileName : String read FInfosFileName write FInfosFileName;

    // Properties herited and moved in the published section
    property Filter;
    property Progress;
    property OnStartOperation;
    property OnFinishOperation;
    property OnOperationProgress;
    property OnEachFile;
  end;

procedure Register;

implementation
uses FileCtrl, consts;

procedure Register;
begin
  RegisterComponents('MMM Misc', [TMyBackup]);
end;

constructor TMyBackup.Create( AOwner : TComponent );
begin
  inherited;
  FConfirmDelete    := True;
  FDrivePath        := 'A:\';
  FFilesPath        := 'C:\';
  ShowFileNames     := True;
  FInfosFileName    := kInfosFile;
  FOperation        := opNone;
  FDiskCount        := 1;
  FFilesToBackup    := TStringList.Create;
  FFilesRestored    := TStringList.Create;
  FFilesToBackup.Duplicates := dupIgnore;
  FFilesRestored.Duplicates := dupIgnore;
end;

destructor  TMyBackup.Destroy;
begin
  FFilesToBackup.Free;
  FFilesRestored.Free;
  inherited;
end;

procedure TMyBackup.SetFilesToBackup( val : TStringList );
begin
  FFilesToBackup.Assign( val );
end;

procedure TMyBackup.SetFilesRestored( val : TStringList );
begin
  FFilesRestored.Assign( val );
end;

procedure TMyBackup.Backup;
begin
  FDiskCount := 1;
  FOperation := opBackup;
  Start;
  try
    SetCaption( BackupCaption );
    WriteFileName('');
    CheckPath;
    CheckDrive;
    PrecalcDirSize( FFilesPath );
    WriteFiles;
  finally
    FOperation := opNone;
    Finish;
  end;
end;

procedure TMyBackup.Restore;
begin
  FDiskCount := 1;
  FOperation := opRestore;
  Start;
  try
    SetCaption( RestoreCaption );
    WriteFileName('');
    CheckPath;
    CheckDrive;
    ReadFiles;
  finally
    FOperation := opNone;
    Finish;
  end;
end;

procedure TMyBackup.CheckDrive;
  procedure AskForDisk;
  var
    msg : String;
  begin
    msg := Format(sInsertDiskXInUnit, [FDiskCount, FDrive]);
    if not InputQuery(sSystemMessage, msg, FDrivePath ) then
      Abort;
  end;
begin
  while True do
    begin
      if length(FDrivePath) < 2 then
        raise Exception.Create(sNeedValidDrivePath);
      if (UpperCase(FDrivePath)[1] in ['A'..'Z']) and (FDrivePath[2]=':') then
        begin
          FDrive := UpperCase(FDrivePath)[1];
          if not DiskInDrive(FDrive) then
            AskForDisk
          else
            begin
              if FOperation = opBackup then
                begin
                  if CheckDiskContent then
                    Break
                  else
                    AskForDisk;
                end
              else if FOperation = opRestore then
                begin
                  if CheckFirstDisk then
                    Break;
                end
              else
                Break;
            end;
        end
      else
        raise Exception.Create(sNeedValidDrivePath);
  end;
end;

procedure TMyBackup.NextDisk;
  procedure AskForDisk;
  begin
    if not InputQuery('Message syst�me', Format(sInsertDiskXInUnit,[FDiskCount, FDrive]), FDrivePath ) then
      Abort;
  end;
var
  SL : TStringList;
  i : Integer;
begin
  while True do
    begin
      AskForDisk;
      if length(FDrivePath) < 2 then
        raise Exception.Create(sNeedValidDrivePath);
      if (UpperCase(FDrivePath)[1] in ['A'..'Z']) and (FDrivePath[2]=':') then
        begin
          FDrive := UpperCase(FDrivePath)[1];
          if DiskInDrive(FDrive) then
            begin
              if (FOperation = opBackup) then
                begin
                  if CheckDiskContent then
                    Break;
                end
              else if (FOperation = opRestore) then
                begin
                  SL := TStringList.Create;
                  try
                    GetInfos( SL );
                    i := 0;
                    if (SL.Values['Disk#'] <> '') then
                      i := StrToInt(SL.Values['Disk#']);
                    if (SL.Values['Backup.Name'] <> FCurBackup) then
                      begin
                        i := 0;
                        MessageDlg( Format(sWrongBackupName, [SL.Values['Backup.Name'], FCurBackup]),
                                    mtError, [mbOk], 0 );
                      end;
                    if (SL.Values['Id'] <> Id) then
                      begin
                        i := 0;
                        MessageDlg( Format(sWrongBackupSet, [IdLabel]), mtError, [mbOk], 0 );
                      end;
                  finally
                    SL.Free;
                  end;
                  if i = FDiskCount then
                    Break;
                end;
            end;
        end
      else
        raise Exception.Create(sNeedValidDrivePath);
  end;
end;

function TMyBackup.CheckDiskContent : Boolean;
  function DeleteFiles : Boolean;
  var
    SR : TSearchRec;
    Found : Integer;
    path : String;
  begin
    result := True;
    path := RemoveSlash( FDrivePath );
    // Remove the files in the directory
    WriteFileName( sDeletingFilesOfDrivePath );
    SendEvents := False;
    Found := FindFirst( path+'\*.*', faAnyFile, SR );
    try
      while Result and (Found = 0)  do
        begin
          if (SR.Name<>'.') and (SR.Name <> '..') then
            begin
              if (SR.Attr and faDirectory) <> 0 then
                begin
                  // Delete subdirectory
                  result := result and DeleteDirectory( path+'\'+SR.Name );
                end
              else
                begin
                  // Remove attributes that could prevent us from deleting the file
                  FileSetAttr( path+'\'+SR.Name, FileGetAttr(path+'\'+SR.Name) and
                                                   not (faReadOnly or faHidden) );
                  // Delete file
                  if not DeleteFile( path+'\'+SR.Name ) then
                    result := False;
                end;
            end;
          Found := FindNext( SR );
        end;
    finally
      SendEvents := True;
      FindClose(SR);
    end;
  end;
begin
  result := True;
  if not IsDirectoryEmpty( FDrivePath ) then
    begin
      if ConfirmDelete and
         (MessageDlg( sAskForDeletionOfFiles, mtConfirmation, [mbYes, mbNo], 0 ) = mrNo) then
        begin
          result := False;
          Exit;
        end;
      if not DeleteFiles then
        begin
          result := False;
          MessageDlg( sCouldNotDeleteAllFiles, mtError, [mbOk], 0 );
        end;
    end;
end;

function TMyBackup.CheckFirstDisk : Boolean;
  function AskForDisk : Boolean;
  var
    msg : String;
  begin
    msg := Format(sInsertDiskXInUnit, [1, FDrive]);
    result := InputQuery(sSystemMessage, msg, FDrivePath );
  end;
var
  old : TOperation;
  SL : TStringList;
begin
  result := False;
  old := FOperation;
  FOperation := opNone;
  try
    while not Result do
      begin
        CheckDrive;
        SL := TStringList.Create;
        try
          if GetInfos(SL) then
            begin
              if (SL.Values['Id'] <> Id) then
                begin
                  MessageDlg( Format(sWrongBackupSet, [IdLabel]), mtError, [mbOk], 0 );
                end
              else
                begin
                  FCurBackup := SL.Values['Backup.Name'];
                  if (SL.Values['Disk#'] <> '') and
                     (StrToInt(SL.Values['Disk#']) = 1) then
                    begin
                      result := True;
                      if (SL.Values['ArchiveSize'] <> '') then
                        FBytesToCopy := StrToInt(SL.Values['ArchiveSize'])
                      else
                        FBytesToCopy := 0;
                    end
                  else
                    begin
                      MessageDlg( sThisDiskIsNotTheFirstOne, mtWarning, [mbOk], 0);
                    end;
                end;
            end;
        finally
          SL.Free;
        end;
        if not Result then
          if not AskForDisk then
             Break;
      end;
  finally
    FOperation := old;
  end;
end;

procedure TMyBackup.CheckPath;
begin
  case FOperation of
    opBackup:
      begin
        if not DirectoryExists( FFilesPath ) then
          raise Exception.CreateFmt(sThePathDoesNotExist, [FFilesPath]);
      end;
    opRestore:
      begin
        ForceDirectories(FFilesPath);
      end;
  end;
end;

procedure TMyBackup.WriteFiles;
var
  SR : TSearchRec;
  Found : Integer;
  path : String;
  i : Integer;
begin
  // Use first the list of files for backup
  if FilesToBackup.Count > 0 then
    begin
      for i := 0 to FilesToBackup.Count - 1 do
        begin
          FCurrentFile := ExtractFileName(FilesToBackup.Strings[i]);
          WriteFile( FilesToBackup.Strings[i] );
        end;
      FCurrentFile := '';
      WriteInfos;
      Exit;
    end;
  // Otherwise, backup all the filtered file from
  // the FilesPath directory
  path := RemoveSlash(FilesPath);
  Found := FindFirst( path+'\'+Filter, faAnyFile, SR );
  try
    while (Found = 0) do
      begin
        if (SR.Name<>'.') and (SR.Name <> '..') then
          begin
            if (SR.Attr and faDirectory) = 0 then
              begin
                FCurrentFile := SR.Name;
                WriteFile( path + '\' + SR.Name );
              end;
          end;
        Found := FindNext( SR );
      end;
      FCurrentFile := '';
      WriteInfos;
  finally
    FindClose(SR);
  end;
end;

procedure TMyBackup.WriteFile( const FileName : String );
  procedure ChangeDisk;
  begin
    WriteInfos;
    Inc( FDiskCount );
    NextDisk;
  end;

  function ComputeDiskSpace : Integer;
  begin
    result := DiskFree(Ord(FDrive) - $40) - kMinDiskSpace;
  end;

var
  Copybuffer     : Pointer;
  BytesCopied    : Longint;
  Source, Dest   : Integer;
  size           : Longint;
  DestFileName   : String;
  DiskSpace      : Integer;
  ChangingDest   : Boolean;
  Processed      : Integer;
const
  ChunkSize : Integer = 8192;
begin
  ChangingDest := False;
  { compute the freespace left on the dest disk }
  DiskSpace := ComputeDiskSpace;
  Size := FBytesToCopy;
  WriteFileName( Format( sCopyOf, [ExtractFilename(FileName)]));

  GetMem(Copybuffer, Chunksize);
  try
    source := FileOpen(FileName, fmShareDenyWrite);
    if Source<0 then raise EFOpenError.CreateFmt(SFCreateError, [FileName]);
    try
      DestFileName := RemoveSlash(FDrivePath)+'\'+ExtractFileName(FileName);
      Dest := FileCreate(DestFileName);
      if Dest<0 then raise EFCreateError.CreateFmt(SFCreateError,[DestFileName]);
      try
        repeat
          if FCancelOperation then
            Abort;
          BytesCopied := FileRead(Source, Copybuffer^, ChunkSize);
          if BytesCopied>0 then
          begin
            // if there's not enough space
            if DiskSpace < BytesCopied then
              begin
                ChangingDest := True;
                // close previous file
                FileClose(Dest);
                // change the disk
                ChangeDisk;
                // reopen previous file on new disk
                Dest := FileCreate(DestFileName);
                if Dest<0 then
                  raise EFCreateError.CreateFmt(SFCreateError,[DestFileName]);
                ChangingDest := False;
                DiskSpace := ComputeDiskSpace;
              end;
            if FileWrite(Dest, Copybuffer^, BytesCopied) <> BytesCopied then
              raise Exception.CreateFmt(sCouldNotWriteInFile, [DestFileName]);
            Inc( FBytesCopied, bytescopied );
            Processed := Round(FBytesCopied/Size*100);
            SetProgress( Round(Processed) );
            Dec( DiskSpace, BytesCopied );
          end;
        until BytesCopied<ChunkSize;
      finally
        if not ChangingDest then
          FileClose(Dest);
      end;
    finally
      FileClose(Source);
    end;
  finally
    freemem(Copybuffer, Chunksize);
  end;
end;

procedure TMyBackup.WriteInfos;
begin
  with TStringList.Create do
    begin
      try
        Values['User.Name'] := UserName;
        Values['User.Company'] := UserCompany;
        Values['User.Licence'] := UserLicence;
        Values['Version'] := Version;
        Values['ID'] := ID;
        Values['Date'] := DateToStr(Now);
        Values['Time'] := TimeToStr(Now);
        Values['Backup.Name'] := BackupName;
        Values['Disk#'] := IntToStr(FDiskCount);
        Values['ArchiveSize'] := IntToStr(FBytesToCopy);
        if FCurrentFile <> '' then
          Values['FileIncompletelySaved'] := FCurrentFile;
        SaveToFile( RemoveSlash(DrivePath)+'\'+InfosFileName );
      finally
        Free;
      end;
    end;
end;

procedure TMyBackup.ReadFiles;
var
  SR : TSearchRec;
  Found : Integer;
  path : String;
begin
  if not CheckFirstDisk then
    Exit;
  FilesRestored.Clear;
  while True do
    begin
      path := RemoveSlash(DrivePath);
      Found := FindFirst( path+'\'+Filter, faAnyFile, SR );
      try
        while (Found = 0) do
          begin
            if (SR.Name<>'.') and (SR.Name <> '..') then
              begin
                if (SR.Attr and faDirectory) = 0 then
                  begin
                    FCurrentFile := SR.Name;
                    ReadFile( path + '\' + SR.Name );
                    FilesRestored.Add( path + '\' + SR.Name );
                  end;
              end;
            Found := FindNext( SR );
          end;
          FCurrentFile := '';
      finally
        FindClose(SR);
      end;
      if FOneMoreDisk then
        begin
          Inc(FDiskCount);
          NextDisk;
        end
      else
        Break;
    end;
end;

procedure TMyBackup.ReadFile( const FileName : String );
var
  Copybuffer     : Pointer;
  BytesCopied    : Longint;
  Source, Dest   : Integer;
  size           : Longint;
  F              : File of Byte;
  DestFileName   : String;
  Processed      : Integer;
const
  ChunkSize : Integer = 8192;
begin
  if FBytesToCopy = 0 then
    begin
      { Compute the length of the FCopyFrom file }
      assignfile(F,FileName);
      try
        FileMode := 0;{ <- This line was suggested by Jinsuck, Choi, South Korea }
        reset(F);
        Size := FileSize(F); {The length of the file}
        FBytesCopied := 0;
      finally
        closefile(F);
      end;
    end
  else
    Size := FBytesToCopy;
  WriteFileName( Format(sCopyOf, [ExtractFilename(FileName)]));

  GetMem(Copybuffer, Chunksize);
  try
    source := FileOpen(FileName, fmShareDenyWrite);
    if Source<0 then raise EFOpenError.CreateFmt(SFCreateError, [FileName]);
    try
      DestFileName := RemoveSlash(FFilesPath)+'\'+ExtractFileName(FileName);
      if FileExists(DestFileName) then
        Dest := FileOpen(DestFileName, fmOpenWrite or fmShareDenyRead or fmShareDenyWrite)
      else
        Dest := FileCreate(DestFileName);
      if Dest<0 then
        raise EFCreateError.CreateFmt(SFCreateError,[DestFileName]);
      try
        if FileSeek(Dest,0,2) = HFILE_ERROR then  // go to the end of file
          raise EFCreateError.CreateFmt(SFCreateError,[DestFileName]);
        repeat
          if FCancelOperation then
            Abort;
          BytesCopied := FileRead(Source, Copybuffer^, ChunkSize);
          if BytesCopied>0 then
          begin
            FileWrite(Dest, Copybuffer^, BytesCopied);
            Inc( FBytesCopied, bytescopied );
            Processed := Round(FBytesCopied/Size*100);
            SetProgress( Round(Processed) );
          end;
        until BytesCopied<ChunkSize;
      finally
        FileClose(Dest);
      end;
    finally
      FileClose(Source);
    end;
  finally
    freemem(Copybuffer, Chunksize);
  end;
end;

function TMyBackup.GetInfos( SL : TStringList ) : Boolean;
var
  tmp : String;
  old : TOperation;
begin
  result := False;
  old := FOperation;
  FOperation := opNone;
  try
    CheckDrive;
    tmp := RemoveSlash(FDrivePath)+'\'+InfosFileName;
    if FileExists(tmp) then
      begin
        with SL do
          begin
            LoadFromFile( tmp );
            result := True;
            FOneMoreDisk := Values['FileIncompletelySaved'] <> '';
          end;
      end
    else
      MessageDlg(sThisDiskContainsNoBackup, mtWarning, [mbOk], 0 );
  finally
    FOperation := old;
  end;
end;

end.
