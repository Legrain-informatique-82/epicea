unit Unit1;    { ViewZip - Demo4 of Delphi Zip v1.40 }
{ This is a Delphi 3 example of how a small self-installing program might
  be written.  If it runs with an argument of /INSTALL, it automatically
  brings up the install menu.  If it runs with an argument of /UNINSTALL
  (such as when running from the Control Panel Uninstall option), it
  does the uninstall and exits.  If the argument is anything else, then
  it assumes it's a zip file and tries to open it.

  IMPORTANT!!!  The "InstUnit" is designed for Win95 Registry keys.  It
  should work on Win98, but it will likely require some tweaks for WinNT.
  YOU HAVE BEEN WARNED!

  Sorry, but this program requires Delphi v3+.  It won't work on Delphi 2
  or C++ Builder.  It requires Delphi 3's Shell Object support.
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, ExtCtrls, ZipDir, SortGrid, InstUnit;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    OpenBut: TButton;
    CancelBut: TButton;
    InstBut: TButton;
    Label1: TLabel;
    Label2: TLabel;
    ZipFName: TLabel;
    Label4: TLabel;
    ZipDir1: TZipDir;
    OpenDialog1: TOpenDialog;
    SortGrid1: TSortGrid;
    procedure FormCreate(Sender: TObject);
    procedure OpenButClick(Sender: TObject);
    procedure FillGrid;
    procedure CancelButClick(Sender: TObject);
    procedure InstButClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    AutoUninstall: Boolean;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
   with SortGrid1 do
   begin
      FixedRows:=0;
      RowCount:=1;  { first row is fixed, and used for titles }
      ColCount:=4;
      Cells[0,0] := 'File Name';
      Cells[1,0] := 'Compr Size';
      Cells[2,0] := 'Uncmpr Size';
      Cells[3,0] := 'Date/Time';
      ColWidths[0]:=310;
      ColWidths[1]:=84;
      ColWidths[2]:=84;
      ColWidths[3]:=120;
   end;

   { Allowable Command Line parameters:
       a zip filename = display it's contents
       /install = bring up install menu automatically
       /uninstall = do the uninstall and quit (no menu)
   }
   if ParamCount > 0 then
   begin
      if UpperCase(ParamStr(1)) = '/INSTALL' then
      begin
         AutoUnInstall:=False;
         InstButClick(Self);   { show install menu }
      end
      else if UpperCase(ParamStr(1)) = '/UNINSTALL' then
      begin
         AutoUnInstall:=True;
         InstButClick(Self);  { do the un-install }
      end
      else
      begin
         { someone passed us an argument that is most likely
         the name of a zip file }
         if FileExists(ParamStr(1)) then
         begin
            ZipFName.Caption:=ParamStr(1);
            { This assignment causes zipfile to be read: }
            ZipDir1.ZipFileName := ZipFName.Caption;
            FillGrid;
         end
         else
            ShowMessage('File Not Found: ' + ParamStr(1));
      end;
   end;
end;

procedure TForm1.FillGrid;
var
  i: Integer;
begin
  with SortGrid1 do
  begin
    { Empty data from string grid }
    FixedRows:=0;
    RowCount:=1; { remove everything from grid except col titles }
    if ZipDir1.Count = 0 then
       Exit;

    for i:=0 to ZipDir1.Count-1 do
    begin
       RowCount := RowCount + 1;
       { We have to set fixed rows after the rowcount is more than 1}
       FixedRows:=1;
       with ZipDirEntry(ZipDir1.ZipContents[i]^) do
       begin
          { The "-1" below is an offset for the row titles }
          Cells[0,RowCount-1] := FileName;
          Cells[1,RowCount-1] := IntToStr(CompressedSize);
          Cells[2,RowCount-1] := IntToStr(UncompressedSize);
          Cells[3,RowCount-1] := FormatDateTime('ddddd  t',FileDateToDateTime(DateTime));
       end; // end with
    end; // end for
  end; // end with
end;

procedure TForm1.OpenButClick(Sender: TObject);
begin
   with SortGrid1 do
   begin
      FixedRows:=0;
      RowCount:=1; { remove everything from grid except col titles }
      ColWidths[0]:=310;
      ColWidths[1]:=84;
      ColWidths[2]:=84;
      ColWidths[3]:=120;
   end;

   if OpenDialog1.Execute then
   begin
      ZipFName.Caption:=OpenDialog1.Filename;
      { This assignment causes zipfile to be read: }
      ZipDir1.ZipFileName := ZipFName.Caption;
      FillGrid;
   end;
end;

procedure TForm1.CancelButClick(Sender: TObject);
begin
   Close;
end;

procedure TForm1.InstButClick(Sender: TObject);
var
   InstForm: TInstForm;
begin
   InstForm:=TInstForm.Create(self);
   InstForm.ShowModal;
   InstForm.Destroy;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
   if AutoUnInstall then
      { The user just uninstalled us: either from the Control Panel, or
        from our Install Menu.  Either way, he obviously doesn't want
        us to continue running now. }
      Close;
end;

end.
