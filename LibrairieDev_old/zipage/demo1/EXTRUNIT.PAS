unit extrunit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, FileCtrl;

type
  TExtract = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    OKBut: TButton;
    CancelBut: TButton;
    DirectoryListBox1: TDirectoryListBox;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    Panel3: TPanel;
    DriveComboBox1: TDriveComboBox;
    RadioGroup3: TRadioGroup;
    procedure OKButClick(Sender: TObject);
    procedure CancelButClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Extract: TExtract;

implementation

uses MainUnit;

{$R *.DFM}

procedure TExtract.OKButClick(Sender: TObject);
begin
   MainUnit.Canceled:=False;
   MainUnit.ExtractDir:=DirectoryListBox1.Directory;
   if RadioGroup1.ItemIndex = 0 then
      MainUnit.ExpandDirs:=False
   else
      MainUnit.ExpandDirs:=True;
   if RadioGroup2.ItemIndex = 0 then
      MainUnit.Overwr:=False
   else
      MainUnit.Overwr:=True;
   if RadioGroup3.ItemIndex = 0 then
      MainUnit.AllFiles:=True
   else
      MainUnit.AllFiles:=False;
   Close;
end;

procedure TExtract.CancelButClick(Sender: TObject);
begin
   MainUnit.ExtractDir:='';
   Close;
end;

procedure TExtract.FormCreate(Sender: TObject);
begin
   RadioGroup1.ItemIndex := 0;  // dflt: do not expand dirs
   RadioGroup2.ItemIndex := 1;  // dflt: overwrite existing files
   RadioGroup3.ItemIndex := 0;  // dflt: extract all files
end;

procedure TExtract.FormActivate(Sender: TObject);
begin
   MainUnit.Canceled:=True; { default }
end;

end.
