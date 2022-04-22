unit sfxunit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ZipMstr;

type
  TMakeSFX = class(TForm)
    Panel1: TPanel;
    CmdLineCB: TCheckBox;
    FileListCB: TCheckBox;
    HideOverWriteCB: TCheckBox;
    Panel2: TPanel;
    DfltOverWriteGrp: TRadioGroup;
    CaptionEdit: TEdit;
    Label1: TLabel;
    DirectoryEdit: TEdit;
    Label2: TLabel;
    CommandEdit: TEdit;
    Label3: TLabel;
    ExecBut: TButton;
    CancelBut: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure ExecButClick(Sender: TObject);
    procedure CancelButClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MakeSFX: TMakeSFX;

implementation

uses mainunit;

{$R *.DFM}

procedure TMakeSFX.ExecButClick(Sender: TObject);
begin
   with Mainform.ZipMaster1 do
   begin
      if CmdLineCB.Checked then
         SFXOptions := SFXOptions + [SFXAskCmdLine]
      else
         SFXOptions := SFXOptions - [SFXAskCmdLine];
      if FileListCB.Checked then
         SFXOptions := SFXOptions + [SFXAskFiles]
      else
         SFXOptions := SFXOptions - [SFXAskFiles];
      if HideOverWriteCB.Checked then
         SFXOptions := SFXOptions + [SFXHideOverWriteBox]
      else
         SFXOptions := SFXOptions - [SFXHideOverWriteBox];

      if DfltOverWriteGrp.ItemIndex = 0 then
         SFXOverWriteMode:=ovrConfirm;
      if DfltOverWriteGrp.ItemIndex = 1 then
         SFXOverWriteMode:=ovrAlways;
      if DfltOverWriteGrp.ItemIndex = 2 then
         SFXOverWriteMode:=ovrNever;

      SFXCaption:=CaptionEdit.Text;
      SFXDefaultDir:=DirectoryEdit.Text;
      SFXCommandLine:=CommandEdit.Text;
   end;
   Mainform.DoIt:=True;
   Close;
end;

procedure TMakeSFX.CancelButClick(Sender: TObject);
begin
   Mainform.DoIt:=False;
   Close;
end;

procedure TMakeSFX.FormCreate(Sender: TObject);
begin
   CaptionEdit.Text:='Self-extracting Archive';
   DirectoryEdit.Text:='C:\';
   CommandEdit.Text:='';
   DfltOverWriteGrp.ItemIndex:=0;
   CmdLineCB.Checked:=False;
   FileListCB.Checked:=False;
   HideOverWriteCB.Checked:=False;
end;

end.
