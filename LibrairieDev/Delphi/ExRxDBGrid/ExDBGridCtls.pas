{
TExDBGrid Version 2.4

Copyright (©) 1999 & 2000 by GJL Software
Updated 17th April 2000 (17/04/2000)

Email:         ExDBGrid@gjl-software.co.uk
Home Page:     http://www.gjl-software.co.uk
}

unit ExDBGridCtls;

interface

uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    Buttons, ExtCtrls, StdCtrls, Db, DbTables, ComCtrls, AdvStatusBar,
    DBCtrls, Menus, JPEG;

type
    TExDBGridCtlsForm = class(TForm)
        Memo1: TMemo;
        ScrollBox1: TScrollBox;
        DBImage: TImage;
        PopupMenu: TPopupMenu;
        Cut1: TMenuItem;
        Copy1: TMenuItem;
        Paste1: TMenuItem;
        N1: TMenuItem;
        Clear1: TMenuItem;
        OpenDialog: TOpenDialog;
        SaveDialog: TSaveDialog;
        N2: TMenuItem;
        Open1: TMenuItem;
        Save1: TMenuItem;
        procedure CancelbtnClick(Sender: TObject);
        procedure OkbtnClick(Sender: TObject);
        procedure FormActivate(Sender: TObject);
        procedure MenuClick(Sender: TObject);
        procedure FileOpen(Sender: TObject);
        procedure SaveBtnClick(Sender: TObject);
        procedure FormKeyPress(Sender: TObject; var Key: Char);
    private
        { Private declarations }
        FBlobCaption: string;
        FBlobField: TField;
        FDataSource: TDataSource;
    public
        { Public declarations }
        property BlobCaption: string read FBlobCaption write FBlobCaption;
        property BlobField: TField read FBlobField write FBlobField;
        property DataSource: TDataSource read FDataSource write FDataSource;
    end;

var
    ExDBGridCtlsForm: TExDBGridCtlsForm;

implementation

{$R *.DFM}

procedure TExDBGridCtlsForm.CancelbtnClick(Sender: TObject);
begin
    ExDBGridCtlsForm.ModalResult := mrCancel;
end;

procedure TExDBGridCtlsForm.OkbtnClick(Sender: TObject);
var
    ImageInfo: Boolean;
    BLOBStream: TBLOBStream;
begin
    if Memo1.Visible = True then
        begin
            if Assigned(FDataSource) then
                begin
                    FDataSource.DataSet.Edit;
                    FBlobField.AsString := Memo1.Lines.Text;
                end
            else
                raise(Exception.Create('Datasource Not Assigned'));
        end
    else
        begin
            if FDataSource.State in [dsEdit, dsInsert] then
                begin
                    ImageInfo := DBImage.Picture.Graphic is TJPEGImage;

                    if ImageInfo then
                        begin
                            BlobStream := TBLOBStream.Create(TBlobField(FBlobField), bmReadWrite);
                            BlobStream.Seek(0, soFromBeginning);
                            BlobStream.Truncate;
                            DBImage.Picture.Graphic.SaveToStream(BlobStream);
                            BlobStream.Free;
                        end
                    else
                        begin
                            FDataSource.DataSet.FieldByName(FBlobField.FieldName).Assign(DBImage.Picture);
                        end;
                end;
        end;

    ExDBGridCtlsForm.ModalResult := mrYes;
end;

procedure TExDBGridCtlsForm.FormActivate(Sender: TObject);
var
    JPEGStream: TBLOBStream;
    JPEGImage: TJPEGImage;
begin
    JPEGStream := nil;
    JPEGImage := nil;

    ExDBGridCtlsForm.Caption := FBlobCaption;

    if (FBlobField is TMemoField) then
        begin
            Memo1.Lines.Text := FBlobField.AsString;
            Memo1.Visible := True;
        end
    else
        if not (FBlobField is TMemoField) and (FBlobField is TBlobField) then
            begin
                try
                    try
                        DBImage.Picture.Assign(FBlobField);
                        ExDBGridCtlsForm.Caption := ExDBGridCtlsForm.Caption + ' - Bitmap Image';
                    except
                        try
                            JPEGStream := TBLOBStream.Create(TBlobField(FBlobField), bmRead);

                            JPegImage := TJPEGImage.Create;
                            JPegImage.LoadFromStream(JPegStream);

                            DBImage.Picture.Assign(JPegImage);
                            ExDBGridCtlsForm.Caption := ExDBGridCtlsForm.Caption + ' - Jpeg Image'
                        finally
                            JPEGStream.Free;
                            JPegImage.Free;
                        end;
                    end;

                    ScrollBox1.Visible := True;

                except
                    ExDBGridCtlsForm.ModalResult := mrCancel;
                end;
            end;
end;

procedure TExDBGridCtlsForm.MenuClick(Sender: TObject);
begin
    case Integer(TMenuItem(Sender).Tag) of
        1: DBImage.Perform(WM_CUT, 0, 0);
        2: DBImage.Perform(WM_COPY, 0, 0);
        3: DBImage.Perform(WM_PASTE, 0, 0);
        4: DBImage.Picture.Graphic := nil;
    end;
end;

procedure TExDBGridCtlsForm.FileOpen(Sender: TObject);
begin
    with OpenDialog do
        if Execute then DBImage.Picture.LoadFromFile(FileName);
end;

procedure TExDBGridCtlsForm.SaveBtnClick(Sender: TObject);
begin
    with SaveDialog do
        if Execute then DBImage.Picture.SaveToFile(FileName);
end;

procedure TExDBGridCtlsForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #27 then
        ExDBGridCtlsForm.ModalResult := mrCancel;
end;

end.

