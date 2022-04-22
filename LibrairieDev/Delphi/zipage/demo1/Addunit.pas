unit Addunit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl, ExtCtrls;

type
  TAddForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DriveComboBox1: TDriveComboBox;
    FileListBox1: TFileListBox;
    Panel4: TPanel;
    DirectoryListBox1: TDirectoryListBox;
    Panel5: TPanel;
    AddFileBut: TButton;
    RemoveBut: TButton;
    OKBut: TButton;
    CancelBut: TButton;
    Panel6: TPanel;
    SelectedList: TListBox;
    Panel7: TPanel;
    Label1: TLabel;
    SortBut: TButton;
    DirNameCB: TCheckBox;
    RecurseCB: TCheckBox;
    Bevel1: TBevel;
    Panel8: TPanel;
    SelectAllBut: TButton;
    Label2: TLabel;
    AddDirBut: TButton;
    EncryptCB: TCheckBox;
    procedure OKButClick(Sender: TObject);
    procedure CancelButClick(Sender: TObject);
    procedure AddFileButClick(Sender: TObject);
    procedure SortButClick(Sender: TObject);
    procedure RemoveButClick(Sender: TObject);
    procedure SelectAllButClick(Sender: TObject);
    function  AppendSlash(const sDir : String): String;
    procedure FormCreate(Sender: TObject);
    procedure AddDirButClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddForm: TAddForm;
  InMouseClick: Boolean;

implementation

uses mainunit;

{$R *.DFM}

procedure TAddForm.OKButClick(Sender: TObject);
begin
   MainUnit.Canceled:=False;
   Close;
end;

procedure TAddForm.CancelButClick(Sender: TObject);
begin
  MainUnit.Canceled:=True;
  Close;
end;

procedure TAddForm.SortButClick(Sender: TObject);
begin
  SelectedList.Sorted:=True;
  SortBut.Enabled:=False;  { list will remain sorted }
end;

procedure TAddForm.RemoveButClick(Sender: TObject);
var
   i: Integer;
begin
   for i:=SelectedList.Items.Count-1 downto 0 do
   begin
      if SelectedList.Selected[i] then
         SelectedList.Items.Delete(i);
   end;
end;

procedure TAddForm.SelectAllButClick(Sender: TObject);
var
   i: Integer;
begin
   for i := 0 to FileListBox1.Items.Count - 1 do
      FileListBox1.Selected[i]:=True;
end;

function TAddForm.AppendSlash(const sDir : String): String;
begin
  Result := sDir;
  if (Length(sDir)>0) and (sDir[Length(sDir)]<>'\') then
     Result := Result+'\';
end;

procedure TAddForm.FormCreate(Sender: TObject);
begin
   DirNameCB.Checked:=False;
   RecurseCB.Checked:=False;
   EncryptCB.Checked:=False;
   InMouseClick:=False;
end;

procedure TAddForm.AddDirButClick(Sender: TObject);
var
   i: Integer;
   FullName: String;
begin
   MainUnit.Canceled:=True;  // default
   for i := 0 to DirectoryListBox1.Items.Count - 1 do
   begin
      if DirectoryListBox1.Selected[i] then
      begin
         // Add this file if it isn't already in listbox
         FullName:=AppendSlash(DirectoryListBox1.Directory)+'*.*';

         if SelectedList.Items.IndexOf(FullName) < 0 then
            SelectedList.Items.Add(FullName);
      { Never de-select dirnames from the DirectoryList! }
      {  DirectoryListBox1.Selected[i]:=False; }
      end;
   end;
   { Position the "SelectedList" listbox at the bottom }
   with SelectedList do
   begin
      Selected[Items.Count-1]:=True;
      Selected[Items.Count-1]:=False;
   end;
end;

procedure TAddForm.AddFileButClick(Sender: TObject);
var
   i: Integer;
   FullName: String;
begin
   MainUnit.Canceled:=True;  // default
   for i := 0 to FileListBox1.Items.Count - 1 do
   begin
      if FileListBox1.Selected[i] then
      begin
         // Add this file if it isn't already in listbox
         FullName:=AppendSlash(DirectoryListBox1.Directory)
                                 + FileListBox1.Items[i];
         if SelectedList.Items.IndexOf(FullName) < 0 then
            SelectedList.Items.Add(FullName);
         FileListBox1.Selected[i]:=False;
      end;
   end;
   { Position the "SelectedList" listbox at the bottom }
   with SelectedList do
   begin
      Selected[Items.Count-1]:=True;
      Selected[Items.Count-1]:=False;
   end;
end;

end.
