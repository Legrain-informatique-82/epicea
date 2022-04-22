{ IMPORTANT!!!  The "InstUnit" is designed for Win95 Registry keys.  It
  should work on Win98, but it will likely require some tweaks for WinNT.
  YOU HAVE BEEN WARNED!
}
unit InstUnit;

interface

uses
  { these modules are for Delphi 3 shell links: ComObj, ActiveX, ShlObj }
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Registry, ComObj, ActiveX, ShlObj;

type
  TInstForm = class(TForm)
    InstBut: TButton;
    StartMenuCB: TCheckBox;
    DesktopCB: TCheckBox;
    RegistryCB: TCheckBox;
    GroupBox1: TGroupBox;
    UninstBut: TButton;
    CancelBut: TButton;
    AssocCB: TCheckBox;
    Label1: TLabel;
    SendToCB: TCheckBox;
    Label2: TLabel;
    ProgramNameLabel: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure InstButClick(Sender: TObject);
    procedure SetValInReg(RKey:HKey; KeyPath: String;
                          ValName: String; NewVal: String);
    procedure MakeAssociation(Ext: String; PgmToLinkTo: String);
    procedure MakeLink(PgmPath, PgmArgs, LinkPath, Descr: String);
    procedure CancelButClick(Sender: TObject);
    procedure UninstButClick(Sender: TObject);
    procedure RegDeleteKey(RKey:HKey; KeyPath: String);
    procedure RemoveAssociation(Ext: String);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InstForm: TInstForm;
  WinDir, EXEName, EXETitle: String;

implementation

uses unit1;

{$R *.DFM}

procedure TInstForm.FormCreate(Sender: TObject);
var
   tmp: array [0..1024] of char;
begin
   GetWindowsDirectory(tmp,1023);
   WinDir:=String(tmp);
   if Length(WinDir) > 3 then
      WinDir:=WinDir+'\';
   EXEName:=ExtractFileName(ParamStr(0));
   EXETitle:='ViewZip - Auto Install Application Example';
   ProgramNameLabel.Caption:=ParamStr(0);
   
   StartMenuCB.Checked:=True;
   DesktopCB.Checked:=True;
   SendToCB.Checked:=True;
   RegistryCB.Checked:=True;
   AssocCB.Checked:=True;

   if Form1.AutoUninstall then
   begin
      ShowMessage('Now beginning ViewZip auto uninstall');
      UnInstButClick(self);
   end;
end;

procedure TInstForm.InstButClick(Sender: TObject);
var
   path: String;
begin
   Screen.Cursor:=crHourGlass;
   if StartMenuCB.Checked then
      MakeLink(ParamStr(0),   // the full pathname of this executable program
            '',               // no arguments
            WinDir+'Start Menu\Programs\'+EXETitle+'.lnk',
            'Sample Self-install Program');

   if DesktopCB.Checked then
      MakeLink(ParamStr(0),   // the full pathname of this executable program
            '',               // no arguments
            WinDir+'Desktop\'+EXETitle+'.lnk',
            'Sample Install Program');

   if SendToCB.Checked then
      MakeLink(ParamStr(0),   // the full pathname of this executable program
            '',               // no arguments
            WinDir+'SendTo\'+EXETitle+'.lnk',
            'Sample Install Program');

   if RegistryCB.Checked then
   begin
      { define the application path }
      SetValInReg(HKEY_LOCAL_MACHINE,
               'SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\'+EXEName,
               '',                 { specify the default data item }
               ParamStr(0));       { Full pathname with program name }
      path:=ExtractFilePath(ParamStr(0));
      SetValInReg(HKEY_LOCAL_MACHINE,
               'SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\'+EXEName,
               'Path',                 { specify the Path data item }
               Copy(path,1,Length(path)-1)); { Full pathname without end slash }

      { define the un-install command line }
      SetValInReg(HKEY_LOCAL_MACHINE,
               'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\'+EXEName,
               'DisplayName',
               EXETitle); { show user this name in control panel }
      SetValInReg(HKEY_LOCAL_MACHINE,
               'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\'+EXEName,
               'UninstallString',
               ParamStr(0) + ' /UNINSTALL'); { pgm name and parameter }


      { define the main application program settings key }
      SetValInReg(HKEY_LOCAL_MACHINE,
               'SOFTWARE\'+EXEName,
               'InstalledVersion',
               '1.40');

      { these are settings that only apply to the current logged-in user }
      SetValInReg(HKEY_CURRENT_USER,
               'SOFTWARE\'+EXEName,
               'InstalledVersion',
               '1.40');
      SetValInReg(HKEY_CURRENT_USER,
               'SOFTWARE\'+EXEName,
               'Setting1',
               'y');
      SetValInReg(HKEY_CURRENT_USER,
               'SOFTWARE\'+EXEName,
               'Setting2',
               'n');
   end;

   if AssocCB.Checked then
      MakeAssociation('zip', ParamStr(0));

   Screen.Cursor:=crDefault;
   Close;
end;

{ Create a Win95 file association in the registry.  This uses the Quick-and-
  Dirty method used by Explorer when you right click on a file and choose
  "Open With...".  Basically, the file extension is created as a class, and
  a dummy file type is created for that class to tell Win95 which program to
  run.  Once this is done, you can easily test it from a DOS Shell by typing:
  START FILENAME.EXT
    Be advised: This is where I expected file associations to be (because
  there are already some associations there), but they seem to have no effect:
    HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Extensions'
}
procedure TInstForm.MakeAssociation(Ext: String; PgmToLinkTo: String);
begin
   { ALL extensions must be in lowercase to avoid trouble! }
   Ext:=LowerCase(Ext);
   if FileExists(PgmToLinkTo) then
   begin
      SetValInReg(HKEY_CLASSES_ROOT,
             '.'+ext,           { extension we want to define }
             '',                { specify the default data item }
             ext+'_auto_file'); { This is the value of the default data item -
                                 this referances our new type to be defined  }
      SetValInReg(HKEY_CLASSES_ROOT,
            ext+'_auto_file',   { this is the type we want to define }
            '',                 { specify the default data item }
            ext+' Files');   { This is the value of the default data item -
                              this is the English description of the file type }

//    SetValInReg(HKEY_CLASSES_ROOT,
//          ext+'_auto_file\QuickView', { create a key for QuickView compat. }
//          '',                 { specify the default data item }
//          '*');               { flag to tell Explorer that QuickView is OK }
      SetValInReg(HKEY_CLASSES_ROOT,
            ext+'_auto_file\shell\open\command', { create a file...open key }
            '',                   { specify the default data item }
            PgmToLinkTo + ' %1'); { command line to open file with }
   end
   else
      ShowMessage('Error: Program not found: ' + PgmToLinkTo);
end;

procedure TInstForm.RemoveAssociation(Ext: String);
begin
   Ext:=LowerCase(Ext);
   RegDeleteKey(HKEY_CLASSES_ROOT,
                '.'+ext);     { extension we want to undefine }
   RegDeleteKey(HKEY_CLASSES_ROOT,
                ext+'_auto_file\shell\open\command');
   RegDeleteKey(HKEY_CLASSES_ROOT,
                ext+'_auto_file');
end;

procedure TInstForm.RegDeleteKey(RKey:HKey; KeyPath: String);
begin
   with TRegistry.Create do
   try
      RootKey := RKey;
      // Under Win95, all keys under this one are auto. deleted also.
      // But, under WinNT, the keys under this one will be left alone.
      DeleteKey(KeyPath);
   finally
      Free;
   end;
end;

{ Set a value in the registry. This is NOT related to the .LNK code.
  This will create a new registry key if it doesn't already exist. }
procedure TInstForm.SetValInReg(RKey:HKey; KeyPath: String;
                            ValName: String; NewVal: String);
begin
   with TRegistry.Create do
   try
      RootKey := RKey;
      OpenKey(KeyPath, True);
      WriteString(ValName,NewVal);
   finally
      Free;
   end;
end;

{ Make a Shell Link, also called a "shortcut" }
procedure TInstForm.MakeLink(PgmPath, PgmArgs, LinkPath, Descr: String);
var
  AnObj: IUnknown;
  ShLink: IShellLink;
  PFile: IPersistFile;
  WFileName: WideString;
begin
  if UpperCase(ExtractFileExt(LinkPath)) <> '.LNK' then
  begin
     ShowMessage('Error: link path extension must be .LNK');
     exit;
  end;

  // access to the two interfaces of the object
  AnObj := CreateComObject(CLSID_ShellLink);
  ShLink := AnObj as IShellLink;
  PFile := AnObj as IPersistFile;

  // NOTE: We're using a COM Object, so all string args must be PChar

  // set the link properties
  ShLink.SetPath(PChar(PgmPath));   // also called the link target
  ShLink.SetArguments(PChar(PgmArgs));
  ShLink.SetWorkingDirectory(PChar(ExtractFilePath(PgmPath)));
  ShLink.SetDescription(PChar(Descr));

  // Save with a WideString filename
  WFileName := LinkPath;
  PFile.Save(PWChar(WFileName), False);
end;

procedure TInstForm.CancelButClick(Sender: TObject);
begin
   Close;
end;

procedure TInstForm.UninstButClick(Sender: TObject);
begin
   Screen.Cursor:=crHourGlass;
   if StartMenuCB.Checked then
      DeleteFile(WinDir+'Start Menu\Programs\'+EXETitle+'.lnk');

   if DesktopCB.Checked then
      DeleteFile(WinDir+'Desktop\'+EXETitle+'.lnk');

   if SendToCB.Checked then
      DeleteFile(WinDir+'SendTo\'+EXETitle+'.lnk');

   if RegistryCB.Checked then
   begin
      RegDeleteKey(HKEY_LOCAL_MACHINE,
               'SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\'+EXEName);
      RegDeleteKey(HKEY_LOCAL_MACHINE,
               'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\'+EXEName);
      RegDeleteKey(HKEY_LOCAL_MACHINE,
               'SOFTWARE\'+EXEName);
      RegDeleteKey(HKEY_CURRENT_USER,
               'SOFTWARE\'+EXEName);
   end;

   if AssocCB.Checked then
      RemoveAssociation('zip');

   Screen.Cursor:=crDefault;

   if NOT Form1.AutoUnInstall then
      { if we are auto-uninstalling, then we are still in OnCreate,
        so we can't close this form yet. }
      Close;
end;

procedure TInstForm.FormActivate(Sender: TObject);
begin
   if Form1.AutoUnInstall then
      PostMessage(Handle, WM_CLOSE, 0, 0);
end;

end.
