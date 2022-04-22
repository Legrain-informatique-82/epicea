{ unit1.pas   a demo of freeware ZIP/UNZIP DLLs for Delphi v2 / v3
  This is the main unit of the advanced Zip/Unzip Demo projoect, zipdemo3.
  Both of these DLLs are required to run this program: ZIPDLL.DLL, UNZDLL.DLL.
  Also, both of these VCL's must be installed before opening this
  project in Delphi: ZipDir and SortGrid.
  See README.TXT for more info. }

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ZIPDLL, UNZDLL, ZCallBck, StdCtrls, ExtCtrls, TZipList, Extrunit, ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    RadioTraceOpt: TRadioGroup;
    Panel2: TPanel;
    RadioVerboseOpt: TRadioGroup;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    RadioRecurse: TRadioGroup;
    Panel3: TPanel;
    Panel4: TPanel;
    ProgressBar1: TProgressBar;
    FileBeingZipped: TLabel;
    Memo1: TMemo;
    NewBut: TButton;
    OpenBut: TButton;
    ZipFName: TLabel;
    OpenDialog: TOpenDialog;
    VersionBut: TButton;
    ListBut: TButton;
    AddBut: TButton;
    DeleteBut: TButton;
    ExtractBut: TButton;
    AbortBut: TButton;
    ExitBut: TButton;
    procedure FormCreate(Sender: TObject);
    procedure VersionButClick(Sender: TObject);
    procedure ExitButClick(Sender: TObject);
    procedure ListButClick(Sender: TObject);
    procedure AddButClick(Sender: TObject);
    procedure DeleteButClick(Sender: TObject);
    procedure AbortButClick(Sender: TObject);
    procedure SetZipSwitches(Opt: ZipOpt);
    procedure SetUnZipSwitches;
    procedure AddToMemo(s: String);
    procedure ResetProgressBar;
    procedure ExtractButClick(Sender: TObject);
    procedure OpenButClick(Sender: TObject);
    procedure NewButClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    ZipParms1: ZipParms;     { declare an instance of ZipParms }
    UnZipParms1: UnZipParms; { declare an instance of UnZipParms }
    procedure SetNewZipFile(FName: String; NewFile: Boolean);
    procedure Load_Zip_Dll;
    procedure Load_Unz_Dll;
    procedure Unload_Zip_Dll;
    procedure Unload_Unz_Dll;
  public
    { Public declarations }
    ExtractDir: String;
    ExpandDirs: Boolean;
    Overwrite: Boolean;
end;

var
  Form1: TForm1;
  AbortRequested: Boolean;
  { The callback function must NOT be a member of a class }
  { I'm going to use the same callback function for ZIP and UNZIP }
  function ZCallback(ZCallBackRec: PZCallBackStruct): LongBool; stdcall; export;

implementation

{$R *.DFM}

{ Notes on the types of callbacks we'll get form the DLL.
   This provides the calling program with updated info on what the DLL
   is doing.  Regardless of the type of call being made, the user's
   function must end with a spin of the message loop.  In fact, even
   if user isn't using a progress bar, then he should still spin the msg
   loop upon getting these callbacks (but he doesn't need to do anything
   else).  Here are the types of call backs:

     ActionCode = 1, we're starting a zip operation on a new file
        ErrorCode = not used yet
        fsize = filesize of file we're going to operate on
        name = pathname of file
     IMPORTANT: The user's function must do the math for the progress
     bar upon getting this call.

     ActionCode = 2, increment the progress bar
        These calls will occur after every 32K of input file has been
        processed. One additional call is made at the end of each file,
        just to make sure the progress bar is max'ed out - this is also
        critical for files less than 32K in size (this last one will be
        their only one).
        ErrorCode = N/A
        fsize = N/A
        name = N/A

     ActionCode = 3, we're done with a batch of files - program flow
     will quickly return to the user's program.
     NOTE: the end of a every file will always be followed by an
           action of 1 or 3, so a separate call for end of one file
           isn't needed.
        ErrorCode = N/A
        fsize = N/A
        name = N/A

     ActionCode = 4, a routine status message has been issued by the DLL.
     It is in the NameOrMsg field.
}
function ZCallback(ZCallBackRec: PZCallBackStruct): LongBool; stdcall; export;
var
   FSize: LongInt;
begin
   with ZCallBackRec^, (TObject(Caller) as TForm1) do
   begin
      if ActionCode = 1 then
      begin
         { starting any ZIP operation on a new file }
         FileBeingZipped.Caption:=StrPas(FileNameOrMsg);
         FSize:=FileSize;
         with ProgressBar1 do
         begin
            if (not visible) then
               visible:=true;
            { Max is assigned the approximate # of callbacks }
            if (FSize div 32768) > 1 then
               Max := FSize div 32768  { total no of steps }
            else
               Max := 1;
            Min:=1;      { first step }
            Step := 1;   { no. of steps for each "StepIt" }
            Position:=1; { current position of bar }
            if (FSize < 32768) then
               StepIt;   { max out progress for small files }
         end;
      end;

      { increment the progress bar }
      if (ActionCode = 2) then
      begin
         with ProgressBar1 do
         begin
           { By making sure that you're not already at maximum, you
             can avoid problems in case the callback signaling the
             end is redundant with the last increment message }
           { if given too many steps, the progress bar wraps around }
           if Position < Max then
              StepIt;
         end;
      end;

      { end of a batch of 1 or more files }
      if (ActionCode = 3) Then
      begin
         ResetProgressBar;
      end;

      { show a routine status message }
      if (ActionCode = 4) Then
      begin
         AddToMemo(StrPas(FileNameOrMsg));
         if not (ErrorCode = 0) then
            { We got a serious error - give user a dialog box }
            ShowMessage('ERROR: ' + FileNameOrMsg
                 + '   code=' + IntToStr(ErrorCode));
      end;
   end; { end with }

   { This call is mandatory here (even if no progress bar is used): }
   Application.ProcessMessages;

   { If you return TRUE, then the DLL will abort it's current
     batch job as soon as it can. }
   if AbortRequested then
      result:=True
   else
      result:=False;
end;

{----------------------------------------------------------------}

procedure TForm1.AddToMemo(s: String);
var
   EndPos: Integer;
begin
   { Remove possible trailing CR or LF }
   EndPos:=Length(s);
   if ((s[EndPos] = #13)
    or (s[EndPos] = #10)) then
       s[EndPos] := #0;
   if EndPos > 1 then
   begin
      if ((s[EndPos-1] = #13)
       or (s[EndPos-1] = #10)) then
          s[EndPos-1] := #0;
   end;
   Memo1.Lines.Add(s);
end;

procedure TForm1.ResetProgressBar;
begin
   FileBeingZipped.Caption:='';
   with ProgressBar1 do
   begin   { reset the bar: make it empty }
      min:=1;
      max:=10;
      step:=1;
      position:=min;
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   RadioTraceOpt.ItemIndex:=0;  { default to no tracing }
   RadioVerboseOpt.ItemIndex:=1;{ default to show verbose msgs }
   RadioRecurse.ItemIndex:=0;   { dflt to no recursive adds of files }
   AbortRequested:=False;
   AbortBut.Enabled:=False;
   ResetProgressBar;
   { IMPORTANT!  Either make sure you're in the same dir as all your
     files, or else use full pathnames on all your files. }
   Caption:='ZIP Demo - ' + GetCurrentDir;
   Load_Zip_Dll;
   Load_Unz_Dll;
end;

procedure TForm1.VersionButClick(Sender: TObject);
var
   ZipVers, UnzVers: Integer;
   ZipGood, UnzGood: Boolean;
begin
   ZipVers:=0;
   UnzVers:=0;
   try
      ZipVers:=GetZipDLLVersion;
      ZipGood:=True;  { no exception - the call worked }
   except
      ShowMessage('Error talking to ZIPDLL.DLL');
      ZipGood:=False;
   end;

   try
      { notice the trailing U on function name below }
      UnzVers:=GetUnzDLLVersion;
      UnzGood:=True;  { no exception - the call worked }
   except
      ShowMessage('Error talking to UNZDLL.DLL');
      UnzGood:=False;
   end;

   if ZipGood and UnzGood then
      ShowMessage('ZIPDLL.DLL version is '
       + IntToStr(ZipVers) + #13#10#13#10
       + 'UNZDLL.DLL version is '
       + IntToStr(UnzVers));
end;

procedure TForm1.ExitButClick(Sender: TObject);
begin
   Close;
end;

procedure TForm1.ListButClick(Sender: TObject);
begin
   { I'm making this modal bec. I don't want the zipfile to be
     changed while it's contents are being viewed. }
   if not FileExists(ZipFName.Caption) then
   begin
      ShowMessage('Error: file not found: ' + ZipFName.Caption);
      exit;
   end;
   VersionBut.Enabled:=False;
   DeleteBut.Enabled:=False;
   AddBut.Enabled:=False;
   ExitBut.Enabled:=False;
   ListBut.Enabled:=False;
   ExtractBut.Enabled:=False;

   ZipForm.ShowModal;  { we're using a separate form for the List function }

   VersionBut.Enabled:=True;
   DeleteBut.Enabled:=True;
   AddBut.Enabled:=True;
   ExitBut.Enabled:=True;
   ListBut.Enabled:=True;
   ExtractBut.Enabled:=True;
end;

procedure TForm1.AddButClick(Sender: TObject);
var
   i, return_code: Integer;
begin
   if ((Length(ZipFName.Caption) = 0) or (Length(Edit1.Text) = 0)) then
   begin
      ShowMessage('Error: you need at least name of zip, and 1st filespec to add');
      exit;
   end;
   VersionBut.Enabled:=False;
   DeleteBut.Enabled:=False;
   AddBut.Enabled:=False;
   ExitBut.Enabled:=False;
   ListBut.Enabled:=False;
   ExtractBut.Enabled:=False;

   SetZipSwitches(ZipAdd);

   with ZipParms1 do
   begin
      PZipFN := StrAlloc(256);  { allocate room for null terminated string }
      StrPCopy(PZipFN, ZipFName.Caption);   { name of zip file }
      argc:=0;  { init to zero }

      if Length(Edit1.Text) > 0 then
      begin
         PFileNames[argc]:=StrAlloc(256);  { alloc room for the filespec }
         StrPCopy(PFileNames[argc], Edit1.Text);  { first file to add to archive }
         argc:=argc+1;
      end;

      if Length(Edit2.Text) > 0 then
      begin
         PFileNames[argc]:=StrAlloc(256);
         StrPCopy(PFileNames[argc], Edit2.Text);
         argc:=argc+1;
      end;
      { argc is now the no. of filespecs we want added/deleted }
   end;  { end with }
   return_code:=0;
   Cursor:=crHourGlass;
   AbortBut.Enabled:=True;
   try
     return_code:=ZipDllExec(@ZipParms1);  { pass in a ptr to parms }
   finally
     Cursor:=crDefault;
     if (return_code < 0) then
        ShowMessage('Fatal error in DLL');
     ShowMessage('DONE: Number of files zipped up: ' + IntToStr(return_code));
     with ZipParms1 do
     begin
        StrDispose(PZipFN);
        for i := 0 to argc - 1 do
           StrDispose(PFileNames[i]);
     end;
   end;

   if AbortRequested then
   begin
      { The "add" was aborted by the user. }
      AbortRequested:=False;
      { IMPORTANT!  If an "add" is aborted, it is possible that
        the ZIP file is now corrupted.  If you especially concerned
        about this, make a backup copy of the ZIP file before an "add"
        operation , and if you detect that the "add" was aborted, then
        copy your backup over the top of the current ZIP file.
        The "delete" is non-abortable, since it executes quickly.}
   end;
   ResetProgressBar;
   VersionBut.Enabled:=True;
   DeleteBut.Enabled:=True;
   AddBut.Enabled:=True;
   ExitBut.Enabled:=True;
   ListBut.Enabled:=True;
   AbortBut.Enabled:=False;
   ExtractBut.Enabled:=True;
end;

procedure TForm1.DeleteButClick(Sender: TObject);
var
   i, return_code: Integer;
begin
   VersionBut.Enabled:=False;
   DeleteBut.Enabled:=False;
   AddBut.Enabled:=False;
   ExitBut.Enabled:=False;
   ListBut.Enabled:=False;
   ExtractBut.Enabled:=False;

   if ((Length(ZipFName.Caption) = 0) or (Length(Edit1.Text) = 0)) then
   begin
      ShowMessage('Error: you need at least name of zip, and 1st filespec to add');
      exit;
   end;
   if not FileExists(ZipFName.Caption) then
   begin
      ShowMessage('Error: file not found: ' + ZipFName.Caption);
      exit;
   end;

   SetZipSwitches(ZipDelete);

   with ZipParms1 do
   begin
      PZipFN := StrAlloc(256);  { allocate room for null terminated string }
      StrPCopy(PZipFN, ZipFName.Caption);   { name of zip file }
      argc:=0;  { init to zero }

      if Length(Edit1.Text) > 0 then
      begin
         PFileNames[argc]:=StrAlloc(256);  { alloc room for the filespec }
         StrPCopy(PFileNames[argc], Edit1.Text);  { first file to add to archive }
         argc:=argc+1;
      end;

      if Length(Edit2.Text) > 0 then
      begin
         PFileNames[argc]:=StrAlloc(256);
         StrPCopy(PFileNames[argc], Edit2.Text);
         argc:=argc+1;
      end;
      { argc is now the no. of filespecs we want added/deleted }
   end;  { end with }

   return_code:=0;
   Cursor:=crHourGlass;
   AbortBut.Enabled:=False;  { The DELETE option doesn't support abort }
   try
     return_code:=ZipDllExec(@ZipParms1);  { pass in a ptr to parms }
   finally
     Cursor:=crDefault;
     if (return_code < 0) then
        ShowMessage('Fatal error in DLL');
     ShowMessage('DONE: Number of files deleted: ' + IntToStr(return_code));
     with ZipParms1 do
     begin
        StrDispose(PZipFN);
        for i := 0 to argc - 1 do
           StrDispose(PFileNames[i]);
     end;
   end;
   AbortRequested:=False;
   ResetProgressBar;
   VersionBut.Enabled:=True;
   DeleteBut.Enabled:=True;
   AddBut.Enabled:=True;
   ExitBut.Enabled:=True;
   ListBut.Enabled:=True;
   AbortBut.Enabled:=False;
   ExtractBut.Enabled:=True;
end;

procedure TForm1.SetZipSwitches(Opt: ZipOpt);
begin
   Memo1.Lines.Clear;
   with ZipParms1 do
   begin
      Version:=140;    // version we expect the DLL to be
      Caller := Self;  // point to our Form instance
      ZipParms1.Handle:=Form1.Handle; // pass window handle
      ZCallbackFunc:=ZCallback; // pass addr of function to be called from DLL

      if RadioTraceOpt.ItemIndex = 0 then
         fTraceEnabled:=false
      else
         fTraceEnabled:=true;
      if RadioVerboseOpt.ItemIndex = 0 then
         fVerboseEnabled:=false
      else
         fVerboseEnabled:=true;
      if ((RadioRecurse.ItemIndex = 1) and (Opt = ZipAdd)) then
         fRecurse:=true
      else
         fRecurse:=false;


      fEncrypt:=false;       { not supported }
      fQuiet:=true;  { we report errors upon notification in our callback }

      fNoDirEntries:=True;  { don't store dirnames by themselves }
      fJunkDir:=False;      { if true, junk directory names }

      fJunkSFX:=false;      { if true, convert input .EXE file to .ZIP }
      fLatestTime:=false;   { if true, make zipfile's timestamp same as newest file }
      fComprSpecial:=false; { if true, try to compr already compressed files }
      fSystem:=false;    { if true, include system and hidden files }
      fVolume:=false;    { if true, include volume label from root dir }
      fExtra:=false;     { if true, include extended file attributes }
      fDate:=false;      { if true, exclude files earlier than specified date }
      { Date:= '100592'; } { Date to include files after; only used if fDate=TRUE }

      fLevel:=9;        { Compression level (0 - 9, 0=none and 9=best) }
      fCRLF_LF:=false;  { if true, translate text file CRLF to LF (if dest is Unix) }

      fForce:=false;    { if true, convert all filenames to 8x3 format }
      fMove:=false;     { if true, Delete orig files that were added or updated }
      { if opt=add (dflt), and update and freshen are both false,
        you get unconditional add/overwrite }
      fUpdate:=false;   { if true, rezip changed, and add new files in fspec }
      fFreshen:=false;  { if true, rezip all changed files in fspec }

      fDeleteEntries:=false;  { override later, if needed. }

      { Grow has to be true to create a new ZIP file }
      fGrow:=false;     { if true, Allow appending to a zip file  (-g)}

      { NOTE: Freshen, Update, and Move are only variations of Add }
      { The LIST function is being handled by the TZReader Delphi VCL }
      case Opt of
         ZipAdd:    fGrow := True;  { if true, Allow appending to a zip file (-g)}
         ZipDelete: fDeleteEntries := True; { allow deletions from ZIPFILE }
      end; { end case }
      seven:=7;
   end; { end with }
end;

procedure TForm1.SetUnZipSwitches;
begin
   Memo1.Lines.Clear;
   with UnZipParms1 do
   begin
      Version:=140;    // version we expect the DLL to be
      Caller := Self;  // set our form instance
      ZipParms1.Handle:=Form1.Handle; // pass window handle
      ZCallbackFunc:=ZCallback; // pass addr of function to be called from DLL

      if RadioTraceOpt.ItemIndex = 0 then
         fTraceEnabled:=false
      else
         fTraceEnabled:=true;
      if RadioVerboseOpt.ItemIndex = 0 then
         fVerboseEnabled:=false
      else
         fVerboseEnabled:=true;

      fQuiet:=true;   { we report errors upon notification in our callback }
      fOverwrite:=Overwrite;    { if true, overwrite existing files }
      fDirectories:=ExpandDirs; { if ture, recreate zip dir structure }
      fUpdate:=false;   { if true, unzip if file in ZIP has a newer date/time, or is totally new }
      fFreshen:=false;  { if true, unzip if file in ZIP has a newer date/time }

      fComments:=false; { zipfile comments - not supported }
      fConvert:=false;  { ascii/EBCDIC conversion - not supported }
      fTest:=false;     { test zipfile - not supported }
      seven:=7;
   end; { end with }
end;

procedure TForm1.AbortButClick(Sender: TObject);
begin
   { This will be passed back to the DLL upon finishing processing
     of the next callback }
   AbortRequested:=True;
   AbortBut.Enabled:=False;
end;

procedure TForm1.ExtractButClick(Sender: TObject);
var
   i, return_code: Integer;
   SaveDir: String;
begin
   if (Length(ZipFName.Caption) = 0) then
   begin
      ShowMessage('Error: you need name of zipfile');
      exit;
   end;
   ExtractDir:='';
   SaveDir:=GetCurrentDir;
   { let user select extract directory,
     whether to expand the zip file's dir's,
     and whether to overwrite existing files }
   Extract.ShowModal;
   if Length(ExtractDir) = 0 then
      exit;

   SetCurrentDir(ExtractDir);
   if (GetCurrentDir <> ExtractDir) then
   begin
      ShowMessage('Error selecting dir: ' + ExtractDir);
      Exit;
   end;

   VersionBut.Enabled:=False;
   DeleteBut.Enabled:=False;
   AddBut.Enabled:=False;
   ExitBut.Enabled:=False;
   ListBut.Enabled:=False;
   ExtractBut.Enabled:=False;

   SetUnZipSwitches;

   with UnZipParms1 do
   begin
      PZipFN := StrAlloc(256);  { allocate room for null terminated string }
      StrPCopy(PZipFN, ZipFName.Caption);   { name of zip file }
      argc:=0;  { init to zero }

      if Length(Edit1.Text) > 0 then
      begin
         PFileNames[argc]:=StrAlloc(256);  { alloc room for the filespec }
         StrPCopy(PFileNames[argc], Edit1.Text);  { first file to add to archive }
         argc:=argc+1;
      end;

      if Length(Edit2.Text) > 0 then
      begin
         PFileNames[argc]:=StrAlloc(256);
         StrPCopy(PFileNames[argc], Edit2.Text);
         argc:=argc+1;
      end;
      { argc is now the no. of filespecs we want added/deleted }
   end;  { end with }

   Cursor:=crHourGlass;
   AbortBut.Enabled:=True;
   Memo1.Lines.Add('Unzip base directory: ' + ExtractDir);
   return_code:=0;
   try
     return_code:=UnzDllExec(@UnZipParms1);  { pass in a ptr to parms }
   finally
     Cursor:=crDefault;
     ShowMessage('DONE: Number of files Unzipped: ' + IntToStr(return_code));
     with UnZipParms1 do
     begin
        StrDispose(PZipFN);
        for i := 0 to argc - 1 do
           StrDispose(PFileNames[i]);
     end;
   end;

   if AbortRequested then
   begin
      AbortRequested:=False;
      { IMPORTANT!  If a ZIP "Extract" is aborted, it is possible that
        the file just expanded is now corrupted. Perhaps we should delete it?}
   end;
   VersionBut.Enabled:=True;
   DeleteBut.Enabled:=True;
   AddBut.Enabled:=True;
   ExitBut.Enabled:=True;
   ListBut.Enabled:=True;
   AbortBut.Enabled:=False;
   ExtractBut.Enabled:=True;

   SetCurrentDir(SaveDir);
   if (GetCurrentDir <> SaveDir) then
      ShowMessage('Error re-selecting dir: ' + SaveDir);
end;

procedure TForm1.OpenButClick(Sender: TObject);
begin
   with OpenDialog do
   begin
      Title:='Open Existing ZIP File';
      Options:=Options+[ofHideReadOnly,ofShareAware,ofPathMustExist,ofFileMustExist];
      Filter :='ZIP Files (*.ZIP)|*.zip';
      if Execute then
         SetNewZipFile(Filename, False);
   end;
end;

procedure TForm1.SetNewZipFile(FName: String; NewFile: Boolean);
var
   Ans: Boolean;
   i: Integer;
   Extension: String;
begin
   { get the extension of the filename }
   for i:=Length(FName)-1 downto 0 do
      if FName[i] = '.' then
      begin
         Extension:=Copy(FName, i, Length(FName) - i + 1);
         break;
      end;
   { if the extension isn't ZIP, then append a .zip extension onto it }
   if (CompareText(Extension,'.zip') <> 0) then
      FName:=FName+'.zip';

   { see if user wants a new zipfile, and if it already exists }
   if NewFile and FileExists(FName) then
   begin
      Ans:=MessageDlg('Overwrite Existing File: ' + FName + '?',
                          mtConfirmation,[mbYes,mbNo],0)=mrYes;
      if Ans then
         DeleteFile(FName)
      else
         Exit;  { Don't use the new name }
   end;

   ZipFName.Caption:=FName;
   { Change to the new drive/directory, so all filespecs will
     be relative to the directory of the ZIP file. This is
     very important for most ZIP application programs!  A
     failure to do this will cause files and directories to
     become all mixed up. }
   SetCurrentDir(ExtractFileDir(FName));
   Caption:='ZIP Demo3 - ' + GetCurrentDir;

   VersionBut.Enabled:=True;
   DeleteBut.Enabled:=True;
   AddBut.Enabled:=True;
   ExitBut.Enabled:=True;
   ListBut.Enabled:=True;
   AbortBut.Enabled:=False;
   ExtractBut.Enabled:=True;
   Memo1.Lines.Clear;
end;

procedure TForm1.NewButClick(Sender: TObject);
begin
   with OpenDialog do
   begin
      Title:='Create New ZIP File';
      Options:=Options+[ofHideReadOnly,ofShareAware];
      Options:=Options-[ofPathMustExist,ofFileMustExist];
      Filter :='ZIP Files (*.ZIP)|*.zip';
      if Execute then
         SetNewZipFile(Filename, True);
   end; { end with }
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
   Unload_Zip_Dll;
   Unload_Unz_Dll;
end;

procedure TForm1.Load_Zip_Dll;
begin
   SetErrorMode(SEM_FAILCRITICALERRORS or SEM_NOGPFAULTERRORBOX);
   try
      ZipDllHandle := LoadLibrary('ZIPDLL.DLL');
      if ZipDllHandle > HInstance_Error then
      begin
         @ZipDllExec := GetProcAddress(ZipDllHandle,'ZipDllExec');
         @GetZipDllVersion := GetProcAddress(ZipDllHandle,'GetZipDllVersion');
         if @ZipDllExec = nil then
            ShowMessage('ZipDllExec function not found in ZIPDLL.DLL');
         if @GetZipDllVersion = nil then
            ShowMessage('GetZipDllVersion function not found in ZIPDLL.DLL');
      end
      else
      begin
         ZipDllHandle := 0; {reset}
         ShowMessage('ZIPDLL.DLL not found');
      end;
   finally
      SetErrorMode(0);
   end;
end;

procedure TForm1.Load_Unz_Dll;
begin
   SetErrorMode(SEM_FAILCRITICALERRORS or SEM_NOGPFAULTERRORBOX);
   try
      UnzDllHandle := LoadLibrary('UNZDLL.DLL');
      if UnzDllHandle > HInstance_Error then
      begin
         @UnzDllExec := GetProcAddress(UnzDllHandle,'UnzDllExec');
         @GetUnzDllVersion := GetProcAddress(UnzDllHandle,'GetUnzDllVersion');
         if @UnzDllExec = nil then
            ShowMessage('UnzDllExec function not found in UNZDLL.DLL');
         if @GetUnzDllVersion = nil then
            ShowMessage('GetZipDllVersion function not found in UNZDLL.DLL');
      end
      else
      begin
         UnzDllHandle := 0; {reset}
         ShowMessage('UNZDLL.DLL not found');
      end;
   finally
      SetErrorMode(0);
   end;
end;

procedure TForm1.Unload_Zip_Dll;
begin
   if ZipDllHandle <> 0 then
      freeLibrary(ZipDllHandle);
   ZipDllHandle:=0;
end;

procedure TForm1.Unload_Unz_Dll;
begin
   if UnzDllHandle <> 0 then
      freeLibrary(UnzDllHandle);
   UnzDllHandle:=0;
end;

end.

