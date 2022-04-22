unit UMail;

interface

uses Windows, Forms, Dialogs;

function SendMail(const Subject, Body, FileName,
                   SenderName, SenderEMail,
                   RecipientName, RecipientEMail: string): Integer;

function SendMail2(const Subject, MessageText, MailFromName, MailFromAddress,
  MailToName, MailToAddress: String; const attachments: array of String; WinHandle: THandle = 0):boolean;

implementation

uses SysUtils, Mapi;

function SendMail(const Subject, Body, FileName,
                   SenderName, SenderEMail,
                   RecipientName, RecipientEMail: string): Integer;
var
   i: integer;
   Message: TMapiMessage;
   lpSender, lpRecipient: TMapiRecipDesc;
   FileAttach: TMapiFileDesc;

   SM: TFNMapiSendMail;
   MAPIModule: HModule;
begin
   FillChar(Message, SizeOf(Message), 0);
   with Message do
   begin
     if (Subject <> '') then
       lpszSubject := PChar(Subject);

     if (Body <> '') then
       lpszNoteText := PChar(Body);

     if (SenderEmail <> '') then
     begin
       lpSender.ulRecipClass := MAPI_ORIG;
       if (SenderName = '') then
         lpSender.lpszName := PChar(SenderEMail)
       else
         lpSender.lpszName := PChar(SenderName);
       lpSender.lpszAddress := PChar(SenderEmail);
       lpSender.ulReserved := 0;
       lpSender.ulEIDSize := 0;
       lpSender.lpEntryID := nil;
       lpOriginator := @lpSender;
     end;

     if (RecipientEmail <> '') then
     begin
       lpRecipient.ulRecipClass := MAPI_TO;
       if (RecipientName = '') then
         lpRecipient.lpszName := PChar(RecipientEMail)
       else
         lpRecipient.lpszName := PChar(RecipientName);
       lpRecipient.lpszAddress := PChar(RecipientEmail);
       lpRecipient.ulReserved := 0;
       lpRecipient.ulEIDSize := 0;
       lpRecipient.lpEntryID := nil;
       nRecipCount := 1;
       lpRecips := @lpRecipient;
     end
     else
       lpRecips := nil;

     if (FileName = '') then
     begin
       nFileCount := 0;
       lpFiles := nil;
     end
     else
     begin
       FillChar(FileAttach, SizeOf(FileAttach), 0);
       FileAttach.nPosition := Cardinal($FFFFFFFF);
       FileAttach.lpszPathName := PChar(FileName);
       nFileCount := 1;
       lpFiles := @FileAttach;
     end;
   end;

   MAPIModule := LoadLibrary(PChar(MAPIDLL));
   if MAPIModule = 0 then
     Result := -1
   else
     try
       @SM := GetProcAddress(MAPIModule, 'MAPISendMail');
       if @SM <> nil then
       begin
         Result := SM(0, Application.Handle, Message, MAPI_DIALOG or 
MAPI_LOGON_UI, 0);
       end
       else
         Result := 1;
     finally
       FreeLibrary(MAPIModule);
     end;

   if Result <> 0 then
     MessageDlg('Error sending mail (' + IntToStr(Result) + ').', mtError, 
[mbOK], 0);
end;


function SendMail2(const Subject, MessageText, MailFromName, MailFromAddress,
  MailToName, MailToAddress: String; const attachments: array of String; WinHandle: THandle = 0):

boolean; 
var 
  MAPIError: DWord; 
  MapiMessage: TMapiMessage; 
  Originator, Recipient: TMapiRecipDesc; 
  Files, FilesTmp: PMapiFileDesc; 
  FilesCount: Integer; 
begin 
  FillChar(MapiMessage, Sizeof(TMapiMessage), 0); 
  MapiMessage.lpszSubject := PChar(Subject); 
  MapiMessage.lpszNoteText := PChar(MessageText); 
  FillChar(Originator, Sizeof(TMapiRecipDesc), 0); 
  Originator.lpszName := PChar(MailFromName); 
  Originator.lpszAddress := PChar(MailFromAddress); 
  MapiMessage.lpOriginator := @Originator; 
  MapiMessage.nRecipCount := 1; 
  FillChar(Recipient, Sizeof(TMapiRecipDesc), 0); 
  Recipient.ulRecipClass := MAPI_TO; 
  Recipient.lpszName := PChar(MailToName); 
  Recipient.lpszAddress := PChar(MailToAddress); 
  MapiMessage.lpRecips := @Recipient; 
  MapiMessage.nFileCount := High(attachments) - Low(attachments) + 1; 
  Files := AllocMem(SizeOf(TMapiFileDesc) * MapiMessage.nFileCount); 
  MapiMessage.lpFiles := Files; 
  FilesTmp := Files; 
  for FilesCount := Low(attachments) to High(attachments) do 
  begin 
    FilesTmp.nPosition := $FFFFFFFF; 
    FilesTmp.lpszPathName := PChar(attachments[FilesCount]);
    Inc(FilesTmp) 
  end; 
  try 
    MAPIError := MapiSendMail(0, 0, 
      MapiMessage, MAPI_DIALOG or MAPI_LOGON_UI or MAPI_NEW_SESSION, 0); 
    result:= MAPIError = 0; 
  finally 
    FreeMem(Files) 
  end 
end;

end.

