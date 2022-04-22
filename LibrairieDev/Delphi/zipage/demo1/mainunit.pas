unit mainunit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, ExtCtrls, SortGrid, ZipMstr;

type
  TMainform = class(TForm)
    Panel2: TPanel;
    StringGrid1: TSortGrid;
    OpenDialog1: TOpenDialog;
    ZipMaster1: TZipMaster;
    Panel1: TPanel;
    CloseBut: TButton;
    Label1: TLabel;
    FilesLabel: TLabel;
    Bevel2: TBevel;
    Panel3: TPanel;
    DeleteZipBut: TButton;
    NewZipBut: TButton;
    ZipOpenBut: TButton;
    Panel4: TPanel;
    ZipFName: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    DeleteBut: TButton;
    AddBut: TButton;
    ExtractBut: TButton;
    TestBut: TButton;
    VerboseCB: TCheckBox;
    TraceCB: TCheckBox;
    TimeLabel: TLabel;
    Label4: TLabel;
    MsgBut: TButton;
    ConvertBut: TButton;
    ImageList1: TImageList;
    procedure ZipOpenButClick(Sender: TObject);
    procedure CloseButClick(Sender: TObject);
    procedure NewZipButClick(Sender: TObject);
    procedure DeleteZipButClick(Sender: TObject);
    procedure ExtractButClick(Sender: TObject);
    procedure ZipMaster1DirUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FillGrid;
    procedure AddButClick(Sender: TObject);
    procedure ZipMaster1Message(Sender: TObject; ErrCode: Integer;
      Message: string);
    procedure ZipMaster1Progress(Sender: TObject; ProgrType: ProgressType;
      FileName: string; FileSize: Longint);
    procedure DeleteButClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TestButClick(Sender: TObject);
    procedure MsgButClick(Sender: TObject);
    procedure ConvertButClick(Sender: TObject);
    procedure StringGrid1ClickSort(Sender: TObject; Col, Row: Longint;
      var SortOptions: TSortOptions);
    procedure StringGrid1DrawCell(Sender: TObject; Col, Row: Longint;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    DoIt: Boolean;
    GSortCol: Longint;
    GSortOptions: TSortOptions;
    procedure SetZipFName( aCaption: String );
  end;

var
  Mainform: TMainform;
  ExtractDir: String;
  ExpandDirs: Boolean;
  OverWr: Boolean;
  AllFiles: Boolean;
  Canceled: Boolean;
  MemoFull: Boolean;

implementation

uses extrunit, msgunit, addunit, sfxunit;

{$R *.DFM}

Function ShowLTime(s,f:Longint):String;
var
   min, sec,{mil,} st: Integer;
   smin, ssec{,smil}: String;
begin
   st := f-s;
   //mil := st mod 1000;
   //mil := mil mod 60;
   sec := st div 1000;
   min := sec div 60;
   sec := sec mod 60;
   //if mil > 9 then smil := inttostr(mil) else smil := '0' + inttostr(mil);
   if sec > 9 then ssec := inttostr(sec) else ssec := '0' + inttostr(sec);
   if min > 9 then smin := inttostr(min) else smin := '0' + inttostr(min);
   result := smin+':'+ssec;
end;

procedure TMainform.CloseButClick(Sender: TObject);
begin
   Close;
end;

procedure TMainform.ZipOpenButClick(Sender: TObject);
begin
   with OpenDialog1 do
   begin
      Title:='Open Existing ZIP File';
      Options:=Options+[ofHideReadOnly,ofShareAware,ofPathMustExist,ofFileMustExist];
      Filter :='ZIP Files (*.ZIP, *.EXE)|*.zip;*.exe';
      if Execute then
      begin
         try
            { assigning the filename will cause the table of contents to be read }
            Screen.Cursor := crHourglass;
            ZipMaster1.ZipFileName:=FileName;
         finally
            Screen.Cursor := crDefault;
            { Set the caption after assigning the filename. This
              way, the filename will be null if the open failed. }
            SetZipFName( ZipMaster1.ZipFileName );
         end;
      end;
   end;
end;

procedure TMainform.NewZipButClick(Sender: TObject);
var
   ans:Boolean;
begin
   with OpenDialog1 do
   begin
      Title:='Create New ZIP File';
      Options:=Options+[ofHideReadOnly,ofShareAware];
      Options:=Options-[ofPathMustExist,ofFileMustExist];
      Filter :='ZIP Files (*.ZIP)|*.zip';
      FileName:='';
      if Execute then
      begin
        if Uppercase(ExtractFileExt(Filename)) = '.EXE' then
        begin
           // user probably wants to create an SFX .EXE
           ShowMessage('Error: you must create a .ZIP file, then convert to .EXE');
           exit;
        end;
        if Pos('.', Filename) = 0 then
           // user did not specify extension
           FileName:=FileName+'.zip'
        else
           if Uppercase(ExtractFileExt(Filename)) <> '.ZIP' then
           begin
              ShowMessage('Error: your new archive must end in .ZIP');
              exit;
           end;
        if FileExists(FileName) then
        begin
           Ans:=MessageDlg('Overwrite Existing File: ' + FileName + '?',
                          mtConfirmation,[mbYes,mbNo],0)=mrYes;
           if Ans then
              DeleteFile(FileName)
           else
              Exit;  { Don't use the new name }
        end;
        SetZipFName( Filename );
        ZipMaster1.ZipFileName:=FileName; { updates the zip dir }
      end;
   end; { end with }
end;

procedure TMainform.DeleteZipButClick(Sender: TObject);
var
   ans:Boolean;
begin
   if FileExists(ZipFName.Caption) then
   begin
      Ans:=MessageDlg('Are you sure you want to delete: ' + ZipFName.Caption
            + '?', mtConfirmation,[mbYes,mbNo],0)=mrYes;
      if Ans then
      begin
         DeleteFile(ZipFName.Caption);
         SetZipFName( '<none>' );
         StringGrid1.RowCount:=2; { empty }
         StringGrid1.Rows[1].Clear;
         ZipMaster1.ZipFilename:='';
         FilesLabel.Caption:='0';
      end
      else
         Exit;  { Don't use the new name }
   end
   else
      ShowMessage('Zip file not found: ' + ZipFName.Caption);
end;

procedure TMainform.ExtractButClick(Sender: TObject);
var
   i: Integer;
   s,f:longint;
   IsOne :String;
begin
   if not FileExists(ZipFName.Caption) then
   begin
      ShowMessage('Error: file not found: ' + ZipFName.Caption);
      Exit;
   end;
   Extract.ShowModal;
   if (ExtractDir = '') or Canceled then
      Exit;

   with StringGrid1 do
   begin
      if ZipMaster1.Count < 1 then
      begin
         ShowMessage('Error - no files to extract');
         Exit;
      end;
      ZipMaster1.FSpecArgs.Clear;
      { Get fspecs of selected files, unless user wants all files extracted }
      if not AllFiles then
      begin
         for i := Selection.Top to Selection.Bottom do
         begin
            ZipMaster1.FSpecArgs.Add(Cells[0,i]);
          { ShowMessage('Selecting ' + Cells[0,i]); } { for debugging }
         end; { end for }
         if ZipMaster1.FSpecArgs.Count < 1 then
         begin
            ShowMessage('Error - no files selected');
            Exit;
         end;
      end;
   end; { end with }

   MsgForm.Memo1.Clear;
   MemoFull:=False;
   MsgForm.Show;
   { Put this message into the message form's memo }
   ZipMaster1Message(self,0,'Beginning Extract from ' + ZipMaster1.ZipFileName);

   with ZipMaster1 do
   begin
      ExtrBaseDir:=ExtractDir;
      Verbose:=VerboseCB.Checked;
      Trace:=TraceCB.Checked;
      ExtrOptions:=[];
      if ExpandDirs then
         ExtrOptions:=ExtrOptions+[ExtrDirNames];
      if Overwr then
         ExtrOptions:=ExtrOptions+[ExtrOverwrite];
      s := GetTickCount;
      try
         Extract;
      except
         ShowMessage('Error in Extract; Fatal DLL Exception in mainunit');
      end;
      f := GetTickCount;
      TimeLabel.Caption := ShowLTime(s,f);
      if SuccessCnt = 1 then
         IsOne := ' was'
      else
         IsOne := 's were';
      ShowMessage(IntToStr(SuccessCnt)+' file' + IsOne + ' extracted' );
   end; { end with }
end;

procedure TMainform.ZipMaster1DirUpdate(Sender: TObject);
begin
   FillGrid;
   FilesLabel.Caption:=IntToStr(ZipMaster1.Count);
   SetZipFName( ZipMaster1.ZipFilename );
   if UpperCase(ExtractFileExt(ZipMaster1.ZipFilename)) = '.EXE' then
      ConvertBut.Caption:='Convert to ZIP'
   else
      ConvertBut.Caption:='Convert to EXE';
end;

procedure TMainform.FormCreate(Sender: TObject);
begin
  with StringGrid1 do
  begin
    { Make sure "goColMoving" is false in object inspector. This lets the
      TSortGrid use Mouse Clicks on the col headers. }
    RowCount:=2;  { first row is fixed, and used for column headers }
    Cells[0,0] := 'File Name';
    Cells[1,0] := 'Compr Size';
    Cells[2,0] := 'Uncmpr Size';
    Cells[3,0] := 'Date/Time';
    ColWidths[0]:=316;
    ColWidths[1]:=84;
    ColWidths[2]:=94;
    ColWidths[3]:=120;
  end;
  VerboseCB.Checked:=False;
  TraceCB.Checked:=False;
  ZipMaster1.Load_Zip_Dll;
  ZipMaster1.Load_Unz_Dll;
  { If we had args on the cmd line, then try to open the first one
    as a zip/exe file.  This is most useful in case user has an association
    to ".zip" that causes this program to run when user dble clicks on a zip
    file in Explorer. }
  if ParamCount > 0 then
     ZipMaster1.ZipFilename := ParamStr(1);
   GSortOptions.SortDirection := sdAscending;
   GSortOptions.SortStyle := ssAutomatic;
   GSortOptions.SortCaseSensitive := False;
end;

procedure TMainForm.FillGrid;
var
  i: Integer;
begin
  with StringGrid1 do
  begin
   { remove everything from grid except col titles }
    RowCount:=2;
    Rows[1].Clear;
    if ZipMaster1.Count = 0 then
       Exit;

    StringGrid1.RowCount := ZipMaster1.Count + 1;
    for i:=1 to ZipMaster1.Count do
    begin
       with ZipDirEntry(ZipMaster1.ZipContents[i-1]^) do
       begin
          Cells[0,i] := FileName;
          Cells[1,i] := IntToStr(CompressedSize);
          Cells[2,i] := IntToStr(UncompressedSize);
          Cells[3,i] := FormatDateTime('ddddd  t',FileDateToDateTime(DateTime));
       end; // end with
    end; // end for
  end; // end with
  StringGrid1.SortByColumn( GSortCol, GSortOptions );
end;

procedure TMainform.AddButClick(Sender: TObject);
var
   s,f:longint;
   IsOne: String;
begin
   if ZipMaster1.ZipFileName = '' then
   begin
      ShowMessage('Error - open a zip file first');
      Exit;
   end;
   AddForm.Left:=Left;
   AddForm.Top:=Top;
   AddForm.Width:=Width;
   AddForm.Height:=Height;
   Canceled:=False;
   AddForm.ShowModal;  { let user pick filenames to add }
   if Canceled then
      Exit;
   if AddForm.SelectedList.Items.Count = 0 then
   begin
      ShowMessage('No files selected');
      Exit;
   end;
   MsgForm.Memo1.Clear;
   MemoFull:=False;
   MsgForm.Show;
   { Put this message into the message form's memo }
   ZipMaster1Message(self,0,'Beginning Add to ' + ZipMaster1.ZipFileName);

   with ZipMaster1 do
   begin
      { We want any DLL error messages to show over the top
        of the message form. }
      Verbose:=VerboseCB.Checked;
      Trace:=TraceCB.Checked;
      AddOptions:=[];
      if AddForm.RecurseCB.Checked then
         AddOptions:=AddOptions+[AddRecurseDirs];  { we want recursion }
      if AddForm.DirnameCB.Checked then
         AddOptions:=AddOptions+[AddDirNames];  { we want dirnames }
      if AddForm.EncryptCB.Checked then
      begin
         AddOptions:=AddOptions+[AddEncrypt];  { we want a password }
      // GetAddPassword;
      // if Password = '' then
            { The 2 password's entered by user didn't match. }
            { We'll give him one more try; if he still messes it
              up, the DLL itself will prompt him one final time. }
       //   GetAddPassword;
      end
      else
         AddOptions:=AddOptions-[AddEncrypt]; // don't forget to turn this off!
      FSpecArgs.Clear;
      FSpecArgs.Assign(AddForm.SelectedList.Items); { specify filenames }
      AddForm.SelectedList.Clear;
      s := GetTickCount;
      try
         Add;
      except
         ShowMessage('Error in Add; Fatal DLL Exception in mainunit');
      end;
      f := GetTickCount;
      TimeLabel.Caption := ShowLTime(s,f);
      if SuccessCnt = 1 then
         IsOne := ' was'
      else
         IsOne := 's were';
      ShowMessage(IntToStr(SuccessCnt)+' file' + IsOne + ' added' );
   end; { end with }
end;

// This is the "OnMessage" event handler
procedure TMainform.ZipMaster1Message(Sender: TObject; ErrCode: Integer;
  Message: string);
begin
   try
      MsgForm.Memo1.Lines.Add(Message);
   except
      ShowMessage('Memo Full - Updating Stopped, but your operation is continuing...');
   end;
   if ErrCode > 0 then
      ShowMessage('Error Msg from DLL: ' + Message);
end;

procedure TMainform.ZipMaster1Progress(Sender: TObject;
  ProgrType: ProgressType; FileName: string; FileSize: Longint);
begin
   if ProgrType = NewFile then
   begin
      {ShowMessage('in OnProgress type 1, size= ' + IntToStr(FileSize));}
      MsgForm.FileBeingZipped.Caption:=FileName;
      with MsgForm.ProgressBar1 do
      begin
         min:=1;    { first step }
         max:=10;   { reasonable value for now ... }
         step:=1;   { no. of steps for each "StepIt" }
         position:=min; { current position of bar }

         { Max is assigned the approximate # of callbacks }
         if (FileSize div 32768) > 1 then
            Max := FileSize div 32768  { total no of steps }
         else
            Max := 1;
         if (FileSize < 32768) then
            StepIt;   { max out progress for small files }
      end;
   end;

   if ProgrType = ProgressUpdate then
   begin
      {ShowMessage('in OnProgress type 2'); }
      with MsgForm.ProgressBar1 do
         if position < Max then
            StepIt;
   end;

   if ProgrType = EndOfBatch then
   begin
      { reset the progress bar and filename }
      { ShowMessage('In OnProgress type 3'); }
      MsgForm.FileBeingZipped.Caption:='';
      with MsgForm.ProgressBar1 do
      begin
         min:=1;
         max:=10;
         step:=1;
         position:=min;
      end;
   end;
   Application.ProcessMessages;
end;

procedure TMainform.DeleteButClick(Sender: TObject);
var
   i: Integer;
   Ans: Boolean;
   s,f:longint;
   IsOne: String;
begin
   with StringGrid1 do
   begin
      if ZipMaster1.Count < 1 then
      begin
         ShowMessage('Error - no files to delete');
         Exit;
      end;
      Ans:=MessageDlg('Delete selected files from: '
        + ZipMaster1.ZipFileName + '?',
                   mtConfirmation,[mbYes,mbNo],0)=mrYes;
      if not Ans then
         Exit;

      ZipMaster1.FSpecArgs.Clear;
      for i := Selection.Top to Selection.Bottom do
      begin
         ZipMaster1.FSpecArgs.Add(Cells[0,i]);
        { ShowMessage('Selecting ' + Cells[0,i]); for debugging }
      end; { end for }

      if ZipMaster1.FSpecArgs.Count < 1 then
      begin
         ShowMessage('Error - no files selected');
         Exit;
      end;
   end; { end with }

   MsgForm.Memo1.Clear;
   MemoFull:=False;
   MsgForm.Show;
   { Put this message into the message form's memo }
   ZipMaster1Message(self,0,'Beginning delete from ' + ZipMaster1.ZipFileName);

   ZipMaster1.Verbose:=VerboseCB.Checked;
   ZipMaster1.Trace:=TraceCB.Checked;
   s := GetTickCount;
   try
      ZipMaster1.Delete;
   except
      ShowMessage('Fatal error trying to delete');
   end;
   f := GetTickCount;
   TimeLabel.Caption := ShowLTime(s,f);
   if ZipMaster1.SuccessCnt = 1 then
      IsOne := ' was'
   else
      IsOne := 's were';
   ShowMessage(IntToStr(ZipMaster1.SuccessCnt)+' file' + IsOne + ' deleted' );
end;

procedure TMainform.FormDestroy(Sender: TObject);
begin
  ZipMaster1.Unload_Zip_Dll;
  ZipMaster1.Unload_Unz_Dll;
end;

procedure TMainform.TestButClick(Sender: TObject);
var
   s,f:longint;
begin
   if ZipMaster1.Count < 1 then
   begin
      ShowMessage('Error - nothing to Test');
      exit;
   end;
   if Zipmaster1.Zipfilename = '' then
      exit;
   ZipMaster1.Verbose:=VerboseCB.checked;
   ZipMaster1.Trace:=TraceCB.Checked;
   MsgForm.Memo1.Clear;
   MemoFull:=False;
   MsgForm.Show;
   ZipMaster1Message(self,0,'Beginning test of ' + ZipMaster1.ZipFileName);
   with ZipMaster1 do
   begin
      FSpecArgs.Clear;
      ExtrOptions := ExtrOptions+[ExtrTest];
      FSpecArgs.Add('*.*'); // Test all the files in the .zip
      // IMPORTANT: In this release, you must test all files.
      s := GetTickCount;
      Extract;  // This will really do a test
   end;
   f := GetTickCount;
   TimeLabel.Caption := ShowLTime(s,f);
   with ZipMaster1 do
      if Count = SuccessCnt then
         ShowMessage('All ' + IntToStr(Count) + ' files tested OK')
      else
         ShowMessage('ERROR: ' + IntToStr(Count-SuccessCnt)
                     + ' files tested BAD, or skipped!');
end;

procedure TMainform.MsgButClick(Sender: TObject);
begin
   MsgForm.Show;
end;

procedure TMainform.ConvertButClick(Sender: TObject);
begin
   if ZipMaster1.Count = 0 then
   begin
      ShowMessage('Error: no files in archive');
      exit;
   end;
   { determine which conversion is to be done }
   if UpperCase(ExtractFileExt(ZipMaster1.ZipFilename)) = '.EXE' then
   begin
      { Convert .EXE to .ZIP }
      if ZipMaster1.ConvertZIP = 0 then
         ShowMessage('Filename is now: ' + ZipMaster1.ZipFilename)
      else
         ShowMessage('Error occured in making .ZIP file');
   end
   else
   begin
      { Convert .ZIP to .EXE }
      { NOTE: If you put the ZIPSFX.BIN file into the WINDOWS
        or WINDOWS SYSTEM dir, then you don't need to set the
        SFXPath property below: }
      { ZipMaster1.SFXPath:='c:\windows\system\zipsfx.bin'; }
      MakeSFX.ShowModal;
      if DoIt = False then
         Exit;
      if ZipMaster1.ConvertSFX = 0 then
         ShowMessage('Filename is now: ' + ZipMaster1.ZipFilename)
      else
         ShowMessage('Error occured in making .EXE file');
   end;
end;

procedure TMainform.StringGrid1ClickSort(Sender: TObject; Col, Row: Longint; var SortOptions: TSortOptions );
begin
   if GSortOptions.SortDirection = sdAscending then
      GSortOptions.SortDirection := sdDescending
   else
      GSortOptions.SortDirection := sdAscending;
   GSortCol := Col;
   SortOptions := GSortOptions;
end;

procedure TMainform.StringGrid1DrawCell(Sender: TObject; Col, Row: Longint; Rect: TRect; State: TGridDrawState);
var
   i: Longint;
begin
   if (Row = 0) and (Col = GSortCol) then
   begin
      if GSortOptions.SortDirection = sdAscending then
         i := 0
      else
         i := 1;
      ImageList1.Draw( StringGrid1.Canvas, Rect.Right - 18, 0, i );
   end
end;

procedure TMainform.SetZipFName( aCaption: String );
begin
   ZipFName.Caption := aCaption;
   Font.Assign( ZipFName.Font );
   if Canvas.TextWidth( aCaption ) > ZipFName.Width then
   begin
      ZipFName.Hint := aCaption;
      ZipFName.ShowHint := True;
   end
   else
      ZipFName.ShowHint := False;
end;

end.
