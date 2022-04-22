unit E2_Menu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids, OleCtrls, ShockwaveFlashObjects_TLB,
  Ftpcli, registry, RXCtrls,ShlObj,ComObj,shellApi,LibFichRep, Menus, RxMenus,
  ActiveX,
  DDEMan,FileCtrl, RXClock;

Resourcestring

RepPub='0000000001\';
RepLogo='0000000000\';
//RepTools='0000000002';

const
   WM_PMESSAGE = WM_USER + 100;
type
  TAppliOne = class(TForm)
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    ShockwaveFlash1: TShockwaveFlash;
    RxSpeedButton1: TRxSpeedButton;
    EdNameProg: TEdit;
    TimerPub: TTimer;
    Timer1: TTimer;
    Timer2: TTimer;
    PopMTray: TPopupMenu;
    Quitter1: TMenuItem;
    RxPopMain: TRxPopupMenu;
    ImIcone: TImageList;
    Image11: TImage;
    ShockwaveFlash2: TShockwaveFlash;
    Image13: TImage;
    RxSBPosteTravail: TRxSpeedButton;
    RxSBReduct: TRxSpeedButton;
    RxSpeedButton4: TRxSpeedButton;
    RxSBCalculatrice: TRxSpeedButton;
    RxPopTools: TRxPopupMenu;
    Modifier1: TMenuItem;
    nonon1: TMenuItem;
    OpenDialog1: TOpenDialog;
    ImIcoDefaut: TImage;
    RxSBProg3: TRxSpeedButton;
    RxSBProg4: TRxSpeedButton;
    RxSBProg5: TRxSpeedButton;
    RxSBProg6: TRxSpeedButton;
    RxSBProg7: TRxSpeedButton;
    RxSBProg8: TRxSpeedButton;
    NavigateurInternet1: TMenuItem;
    EMail1: TMenuItem;
    N1: TMenuItem;
    RxSBLegrain: TRxSpeedButton;
    RxSBGwi: TRxSpeedButton;
    Toujoursvisible1: TMenuItem;
    Recherche1: TMenuItem;
    Explorateur1: TMenuItem;
    News1: TMenuItem;
    PetitsIconestoujoursvisible1: TMenuItem;
    Image2: TImage;
    RxSpeedButton2: TRxSpeedButton;
    ImVoyant: TImage;
    Image8: TImage;
    N2: TMenuItem;
    Image1: TImage;
    TiForm: TTimer;
    RxSBSearchWeb: TRxSpeedButton;
    RxSBSearchLocal: TRxSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Image3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image3DblClick(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure ShockwaveFlash1FSCommand(Sender: TObject; const command,
      args: WideString);
    procedure Image9Click(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FtpStateChange(sender: TObject);
    procedure FtpClient1RequestDone(Sender: TObject; RqType: TFtpRequest;
      Error: Word);
    procedure FormDestroy(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure EdNameProgKeyPress(Sender: TObject; var Key: Char);
    procedure RxSpeedButton1MouseEnter(Sender: TObject);
    procedure RxSpeedButton1MouseLeave(Sender: TObject);
    procedure EdNameProgExit(Sender: TObject);
    Procedure AjouteItem(Index:integer;Titre:string);
    Procedure SupprimeItem(Index:integer);
    procedure RxSpeedButton1Click(Sender: TObject);
//    procedure Image7Clic(Sender: TObject);
    procedure ShockwaveFlash1Progress(Sender: TObject;
      percentDone: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure AppliOneOnMinimize(Sender: TObject);
    procedure RxPopMainGetImageIndex(Sender: TMenu; Item: TMenuItem;
      State: TMenuOwnerDrawState; var ImageIndex: Integer);
    procedure ConstruitPopMenu(index:integer;Caption:string;PopMenu: TMenuItem);
    procedure RxPopMainPopup(Sender: TObject);
    procedure SupprItem1Click(Sender: TObject);
    procedure ShockwaveFlash2FSCommand(Sender: TObject; const command,
      args: WideString);
    procedure RxSBPosteTravailMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Modifier1Click(Sender: TObject);
    Procedure ConstruitListeTools(var ListeTools:TStringList);
    procedure nonon1Click(Sender: TObject);
    procedure RxSBPosteTravailMouseEnter(Sender: TObject);
    procedure RxSBPosteTravailClick(Sender: TObject);
    procedure RxSBLegrainClick(Sender: TObject);
    procedure RxSBGwiClick(Sender: TObject);
    procedure Toujoursvisible1Click(Sender: TObject);
    procedure PetitsIconestoujoursvisible1Click(Sender: TObject);
    procedure News1Click(Sender: TObject);
    procedure RxSpeedButton2Click(Sender: TObject);
    procedure Image11Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure TiFormTimer(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure RxSBSearchLocalClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
//    procedure TrayMessage(var Msg:Tmessage);message WM_PMESSAGE;
    procedure MoveMessage(var Msg:Tmessage);message WM_MOVE;
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
  public
    { Déclarations publiques }
  ListeProg,ListeIcon,ListeChe,ListePub,ListeTools,ListeToolsP:TStringList;
  protected
    procedure WMDROPFILES (var Msg: TMessage); message WM_DROPFILES;
  end;

var
  AppliOne: TAppliOne;
  IndiceItem,IndicePub:integer;
  NotifyStruc:TnotifyIconData;
  NoT2Nul:boolean;
  DsBarreTache:boolean;
  LittleTools:boolean;
  NumFrame,NbFrame,NbTours:Integer;
  HauteurRac,DernPos,DeltaX:Integer;
BottomLastImage:Integer;
i:integer;
implementation

uses E2_Main;

//uses Ftptst1, Unit2, Unit3, Unit4;

{$R *.DFM}


procedure Delay(MSecs: Integer);
var 
  FirstTickCount : LongInt; 


begin
  FirstTickCount:=GetTickCount; 
  repeat 
    SleepEX(1, false); 
  until ((GetTickCount-FirstTickCount) >= LongInt(MSecs)); 
end; 

procedure SearchInFolder(Folder : string);
begin
  with TDDEClientConv.Create(Application.MainForm) do
  begin
    ConnectMode := ddeManual;
    ServiceApplication := 'Explorer.exe';
    SetLink('Folders', 'AppProperties');
    OpenLink;
    ExecuteMacro(PChar('[FindFolder(, '+ Folder+')]'), False);
    CloseLink;
    Free;
  end;
end;

Function Detection_Connexion : Boolean;
Var
 Reg: Treginifile;
 buff : integer;
Begin
 Reg:=TreginiFile.Create('');
 Reg.rootkey:=HKEY_LOCAL_MACHINE;
 Reg.OpenKey('System\CurrentControlSet\Services\RemoteAccess', False) ;
 Reg.ReadBinaryData('Remote Connection',buff,16);
  if buff = 1 then  Detection_Connexion:=True else
  Detection_Connexion:=False;
End;

//******************************************************************************
Procedure InitialiseForm(Form :TForm);
// Regarde dans la table des registres si des paramètres de position existe
// pour l'écran passé en paramètres
Var
	Registre :TRegistry;
	FLeft, FTop, FWidth, FHeight :LongInt;
        TjVisible,TjVisibleI:boolean;

Begin
  	Registre:= TRegistry.Create;

try
 try
   with Registre do begin
      RootKey := HKEY_LOCAL_MACHINE;
         Try
         if OpenKey('\SOFTWARE\LGR\Appone\' + Form.Name, False) then
          begin
	      FLeft:= ReadInteger('Left');
   	      FTop:= ReadInteger('Top');
              Form.tag:= ReadInteger('Tag');
              TjVisible:=ReadBool('Tv');
              TjVisibleI:=ReadBool('TvI');
//              AppliOne.Toujoursvisible1.Checked:=TjVisible;
//              AppliOne.PetitsIconestoujoursvisible1.Checked:=TjVisibleI;
              Form.Left:= FLeft;
      	      Form.Top:= FTop;
          End;
         Except
             TjVisible:=true;
             TjVisibleI:=true;
	     Form.Left:= Screen.Width-193;
      	     Form.Top:= 0;
         end;
      end;
  except
     Form.Left:= Screen.Width-193;
     Form.Top:= 0;
  end;
   finally
     Registre.Free;
   end;
End;

//******************************************************************************
Procedure DestroyForm(Form :TForm);
// Ecriture de la position de l'écran en cours dans la table des registres
Var
	Registre :TRegistry;
Begin
      Registre:= TRegistry.Create;
      try
         with Registre do begin
            RootKey := HKEY_LOCAL_MACHINE;
            OpenKey('\SOFTWARE\LGR\Appone\' + Form.Name, True);
            WriteInteger('Left', Form.Left);
            WriteInteger('Top', Form.Top);
//            WriteBool('TV',AppliOne.Toujoursvisible1.Checked);
//            WriteBool('TVI',AppliOne.PetitsIconestoujoursvisible1.Checked);
            if form.tag=1 then
            writeInteger('Tag',2)
            else writeInteger('Tag',1);
            CloseKey;
         end;
      finally
         Registre.Free;
      end;
End;

procedure TAppliOne.ConstruitPopMenu(index:integer;Caption:string;PopMenu: TMenuItem);
var
ItemAux:TMenuItem;
begin
ItemAux:=TMenuItem.Create(self);
ItemAux.Caption:=Caption;
ItemAux.Tag:=index;
ItemAux.Checked:=true;
ItemAux.OnClick:=SupprItem1Click;
PopMenu.Add(ItemAux);
end;


//procedure TAppliOne.TrayMessage(var Msg:Tmessage);
//var
//pt:Tpoint;
//begin
//if Msg.LParam=WM_RBUTTONDOWN then
//	begin
//      GetCursorPos(pt);
//      SetForegroundWindow(handle);
//   	PopMTray.Popup(pt.x,pt.Y);
//	end;
//if Msg.LParam=WM_LBUTTONDOWN then
//	begin
//   if (self.visible=false) then
//     	begin
//      self.visible:=true;
//      showwindow(application.Handle,SW_HIDE); {Cache l'appli dans la barre des taches}
//      SetForegroundWindow(handle);
//      end
//     else
//      begin
//       if DsBarreTache=true then
//       begin
//        application.Restore;
//        self.visible:=true;
//        self.show;
//        showwindow(application.Handle,SW_HIDE); {Cache l'appli dans la barre des taches}
//        SetForegroundWindow(handle);
//        DsBarreTache:=false;
//       end
//       else
//       Image3Click(Image5);
//      end;
//   end;
//end;

Procedure TAppliOne.SupprimeItem(Index:integer);
var
RxSB : TRxSpeedButton;
BouttonImage:TImage;
Rgn : THandle;
selftagTmp:integer;
begin
FindComponent('IM'+Inttostr(Index)).Free;
FindComponent('SB'+Inttostr(Index)).Free;
if ListeProg.Count >0 then
ListeProg.Delete(Index);
if ListeChe.Count >0 then
ListeChe.Delete(Index);
if ListeIcon.Count >0 then
ListeIcon.Delete(Index);
if RxPopMain.Items.Count >0 then
RxPopMain.Items.Delete(Index);
if ImIcone.Count >0 then
ImIcone.Delete(index);
if FileExists(ExtractFilePath(Application.ExeName)+RepLogo+'Icone'+inttostr(Index)+'.Ico') then DeleteFile(ExtractFilePath(Application.ExeName)+RepLogo+'Icone'+inttostr(Index)+'.Ico');
inc(Index);
HauteurRac:=40;// espace entre les raccourcis
if ListeProg.Count > 0 then
begin     //148 + (Index*HauteurRac);//BottomLastImage+13+69+28
  HauteurRac:=22;
  while ((screen.Height > (148+(ListeProg.Count*HauteurRac)+ 13+69+28)) and (HauteurRac<40)) do
               inc(HauteurRac);
end;

while FindComponent('SB'+Inttostr(Index)) <> nil do
      begin
        RenameFile(ExtractFilePath(Application.ExeName)+RepLogo+'Icone'+inttostr(Index)+'.Ico',ExtractFilePath(Application.ExeName)+RepLogo+'Icone'+inttostr(Index-1)+'.Ico');
        RxPopMain.items.items[Index-1].Tag:=RxPopMain.Items.items[Index-1].Tag-1;
        (FindComponent('SB'+Inttostr(Index)) as TRxSpeedButton).Top:=(FindComponent('SB'+Inttostr(Index)) as TRxSpeedButton).Top-HauteurRac;
        FindComponent('SB'+Inttostr(Index)).Name:='SB'+Inttostr(Index-1);
        (FindComponent('IM'+Inttostr(Index)) as TImage).Top:=(FindComponent('IM'+Inttostr(Index)) as TImage).Top-HauteurRac;
        FindComponent('IM'+Inttostr(Index)).Name:='IM'+Inttostr(Index-1);
//        ListeIcon.Strings[index-1]:=ExtractFilePath(Application.ExeName)+RepLogo+'Icone'+inttostr(Index-1)+'.Ico';
        inc(Index);
      end;
      case self.tag of
         1:self.tag:=2;
         2:self.tag:=1;
      end;
      Image3DblClick(Image5);
end;

Procedure TAppliOne.AjouteItem(Index:integer;Titre:string);
var
RxSB : TRxSpeedButton;
BouttonImage:TImage;
icone:TIcon;
Nom:String;
begin
   BouttonImage:=TImage.Create(self);
   BouttonImage.Parent:=self;
   BouttonImage.BringToFront;
   BouttonImage.Top:=148 + (Index*HauteurRac);
   BouttonImage.Left:=12+DeltaX;
   BouttonImage.Height:=26;
   BouttonImage.Picture:=Image8.Picture;
   BouttonImage.Transparent:=false;
   BouttonImage.AutoSize:=true;
   BouttonImage.Visible:=false;
   BouttonImage.Cursor:=crHandPoint;
   BouttonImage.Name:='IM'+Inttostr(Index);
   BouttonImage.DragMode:=dmManual;
   BouttonImage.DragCursor:=crArrow;

   BouttonImage.OnClick:=Image8Click;

   // Creation SpeedButton
   RxSB:=TRxSpeedButton.create(self);
   RxSB.Parent:=self;
   RxSB.Alignment:=taLeftJustify;
   RxSB.AllowAllUp:=False;
   RxSB.Left:=41+DeltaX;
   RxSB.Top:=BouttonImage.Top-5;
   RxSB.Height:=22;
   RxSB.Width:=137;
   RxSB.GroupIndex:=0;
   RxSB.Transparent:=true;
   RxSB.BringToFront;
   RxSB.Cursor:=crHandPoint;
   RxSB.Flat:=true;
   RxSB.Caption:=Titre;
   RxSB.Font.Color:=clblack;
   Nom:='SB'+inttostr(Index);
   RxSB.Name:=Nom;
   RxSB.Visible:=false;
   RxSB.OnClick:=TMenuItem(Main.ListForm.Objects[index]).OnClick;
//   RxSB.OnClick:=RxSpeedButton1Click;
   RxSB.OnMouseEnter:=RxSpeedButton1MouseEnter;
   RxSB.OnMouseLeave:=RxSpeedButton1MouseLeave;

   ConstruitPopMenu(index,listeprog.Strings[index],RxPopMain.items);
//   Icone:=TIcon.Create;
//   Icone.LoadFromFile(ListeIcon.strings[index]);
//   ImIcone.AddImages(icone);
//   ImIcone.AddIcon(icone);
//   icone.free;
End;

procedure TAppliOne.WMDROPFILES (var Msg: TMessage);
var
  i,anzahl,
  size : integer;
  k,j:integer;
  kk:word;
  Dateiname,NomExe,DateinameBis : PChar;
  Icone:TIcon;
  extension,aux,NomRep,NomFic:string;
  NomProg:PChar;
  MySLink : IShellLink;
  MyObject : IUnknown;
  F:TWin32FindDataA;
  MaxPAth,Flags:integer;
  PersistFile : IPersistFile;
 res:array[1..250] of char;
 l:Integer;
begin
  inherited;

  MyObject := CreateComObject(CLSID_ShellLink);
  MySLink := MyObject as IShellLink;

  anzahl := DragQueryFile(Msg.WParam, $FFFFFFFF, Dateiname, 255);
  MySLink.QueryInterface(IPersistFile, PersistFile);
  aux:='';
  icone:=TIcon.Create;
 if self.tag=2 then self.tag:=1;
  for i := 0 to (anzahl - 1) do begin
    size := DragQueryFile(Msg.WParam, i , nil, 0) + 1;
    Dateiname:= StrAlloc(size);
    DragQueryFile(Msg.WParam,i , Dateiname, size);
    RxSpeedButton1.Caption:=StrPas(Dateiname);
    extension:=ExtractFileExt(StrPas(Dateiname));
    if uppercase(extension)='.LNK' then
      begin
        PersistFile.Load(PWideChar(Dateiname),Flags);
        MySLink.setPath(Pchar(Dateiname));
       icone.Handle:=ExtractAssociatedIcon(hInstance,Dateiname,kk);
       NomRep:=ExtractFilePath(StrPas(DateIName));
       NomFic:=extractFilename(StrPas(DateIName));
       NomFic:=copy(NomFic,1,length(NomFic)-4);
//       ImIco.Picture.Icon:=icone;
       end
       else
    if uppercase(extension)='.EXE' then
      begin
       NomRep:=ExtractFilePath(StrPas(DateIName));
       NomFic:=extractFilename(StrPas(DateIName));
       NomFic:=copy(NomFic,1,length(NomFic)-4);
       icone.Handle:=ExtractIcon(hInstance,PChar(Dateiname),0);
//       ImIco.Picture.Icon:=icone;
     end
    else
    begin
     try
       NomRep:=ExtractFilePath(StrPas(DateIName));
       NomFic:=extractFilename(StrPas(DateIName));
 fillchar(res,sizeof(res),' ');
 res[250]:=#13;
 l:=FindExecutable(@NomFic[1],@NomRep[1],@res[1]);
 if l <=32 then
 begin
  If Application.messagebox(PChar('Ce fichier n''a pas d''application associée'+#10#13+'Voulez-vous en choisir une ?'),'Attention',MB_ICONWARNING+MB_YESNO + MB_DEFBUTTON1) = IDYES then
        begin
         ShellExecute(Application.Handle, 'open', PChar('rundll32.exe'),
         PChar('shell32.dll,OpenAs_RunDLL ' + NomFic), nil,SW_SHOWNORMAL);
          exit;
          end
          else exit;
 end
 else
 begin  If Application.messagebox(PChar('Voulez-vous créer un raccourci vers ce document :'+#10#13+Dateiname+' ?'),'Attention',MB_ICONWARNING+MB_YESNO + MB_DEFBUTTON1) = IDYES then
        begin
          icone.Handle:=ExtractIcon(hInstance,(@res[1]),0);
//          ImIco.Picture.Icon:=icone;
        end
        else
        begin
          icone.Handle:=ExtractIcon(hInstance,(@res[1]),0);
//          ImIco.Picture.Icon:=icone;
         DateinameBis:= StrAlloc(size);
         DateinameBis:=@res;
         aux:=PChar(DateinameBis);
         NomFic:=extractFilename(aux);
         NomFic:=copy(NomFic,1,length(NomFic)-4);
        end;
 end;
     except;
     exit;
     end;
    end;
    if aux='' then
    aux:=StrPas(Dateiname);
    ListeProg.Append(NomFic);
    try
    Icone.SaveToFile(ExtractFilePath(Application.ExeName)+RepLogo+'Icone'+inttostr(ListeProg.count-1)+'.Ico');
    except
     Showmessage('Ce fichier ne peut-être accepté !');

     if not DirectoryExists(ExtractFilePath(Application.ExeName)+RepLogo) then
        ForceDirectories(ExtractFilePath(Application.ExeName)+RepLogo);

     if FileExists(ExtractFilePath(Application.ExeName)+RepLogo+'Icone'+inttostr(ListeProg.count-1)+'.Ico') then
        deleteFile(ExtractFilePath(Application.ExeName)+RepLogo+'Icone'+inttostr(ListeProg.count-1)+'.Ico');
     ListeProg.Delete(ListeProg.Count-1);
     icone.Free;
     DragFinish(Msg.WParam);
     exit;
    end;
    ListeIcon.AddObject(ExtractFilePath(Application.ExeName)+RepLogo+'Icone'+inttostr(ListeProg.count-1)+'.Ico',Icone);
    ListeChe.Append(aux);
    ConstruitPopMenu(ListeProg.count-1,aux,RxPopMain.items);
    ImIcone.AddIcon(icone);
//    GetIcon((ListeProg.count-1),);
    AjouteItem(ListeProg.count-1,NomFic);
    Image3DblClick(Image5);
  end;
icone.Free;
DragFinish(Msg.WParam);

end;

Procedure  TAppliOne.ConstruitListeTools(var ListeTools:TStringList);
var
i:integer;
begin
if not DirectoryExists(ExtractFilePath(Application.ExeName)+RepLogo) then
        ForceDirectories(ExtractFilePath(Application.ExeName)+RepLogo);

if FileExists(ExtractFilePath(Application.ExeName)+RepLogo+'fileTH.dat') and FileExists(ExtractFilePath(Application.ExeName)+RepLogo+'fileTP.dat') then
  begin
   ListeTools.LoadFromFile(ExtractFilePath(Application.ExeName)+RepLogo+'fileTH.dat');
   ListeToolsP.LoadFromFile(ExtractFilePath(Application.ExeName)+RepLogo+'fileTP.dat');
  end;
if not ((ListeTools.Count=ListeToolsP.Count) and (ListeToolsP.Count=8))then
  begin
   ListeTools.Add('Explorateur');
   ListeTools.Add('Rechercher ...');
   ListeTools.Add('E-Mail');
   ListeTools.Add('Navigateur Internet');
   ListeTools.Add('News');
   ListeTools.Add('Lecteur CD Audio');
   ListeTools.Add('Calculatrice');
   ListeTools.Add('Commande MSDos');

   ListeToolsP.Add('');//C:\WINDOWS\EXPLORER.EXE
   ListeToolsP.Add('');
   ListeToolsP.Add('');
   ListeToolsP.Add('');
   ListeToolsP.Add('');
   ListeToolsP.Add('C:\WINDOWS\CDPLAYER.EXE');
   ListeToolsP.Add('C:\WINDOWS\calc.exe');
   ListeToolsP.Add('C:\WINDOWS\COMMAND.COM');
  end;
for i:=0 to 4 do
    begin
      RxPopTools.Items[i+3].Checked:=ListeToolsP.Strings[i]='';
    end;
//
end;
procedure TAppliOne.AppliOneOnMinimize(Sender: TObject);
begin
//self.Caption:='Appli-One'+inttostr(self.ClientToScreen(P).y);
end;


procedure TAppliOne.FormCreate(Sender: TObject);
VAR Rgn : THandle;
i:integer;
ListeOK:boolean;
BEGIN
try
//Application.ShowHint:=true;
//Application.OnMessage := AppMessage;
//Application.OnMinimize:=AppliOneOnMinimize;
//with Tregistry.create do
//  begin
//	RootKey:=HKEY_LOCAL_MACHINE;
//   openKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run',true);
//   writestring('Appli-One',Application.ExeName);
//   free;
//  end;
InitialiseForm(self);
self.FormStyle:=fsStayOnTop;
//if Toujoursvisible1.Checked then self.FormStyle:=fsStayOnTop
//   else self.FormStyle:=fsNormal;
//
//ShowWindow(Application.handle,SW_HIDE);
//NotifyStruc.cbSize:=sizeOf(NotifyStruc);
//NotifyStruc.Wnd:=Handle;
//NotifyStruc.uID:=1;
//NotifyStruc.uFlags:=NIF_ICON or NIF_TIP or NIf_MESSAGE;
//NotifyStruc.uCallbackMessage:=WM_PMESSAGE;
//NotifyStruc.hIcon:=AppliOne.Icon.Handle;
//NotifyStruc.szTip:='Appli-One';
//Shell_NotifyIcon(Nim_add,@NotifyStruc);
//NoT2Nul:=false;

//if not DirectoryExists(ExtractFilePath(Application.ExeName)+RepPub) then
//        ForceDirectories(ExtractFilePath(Application.ExeName)+RepPub);

//if not DirectoryExists(ExtractFilePath(Application.ExeName)+RepLogo) then
//        ForceDirectories(ExtractFilePath(Application.ExeName)+RepLogo);

if DirectoryExists(ExtractFilePath(Application.ExeName)+RepPub) then
        ForceDirectories(ExtractFilePath(Application.ExeName)+RepPub);

HauteurRac:=22;// espace entre les raccourcis
IndicePub:=0;

//DragAcceptFiles(AppliOne.Handle, true);

InitialiseForm(self);
ListePub:=TStringList.Create;
ListePub:=ListeFic('*.swf',ExtractFilePath(Application.ExeName)+RepPub,faAnyFile,False,False);
NumFrame:=0;
ListeProg:=TStringList.Create;
ListeIcon:=TStringList.Create;
ListeChe:=TStringList.Create;
ListeTools:=TStringList.Create;
ListeToolsP:=TStringList.Create;

Image7Click(TimerPub);

ConstruitListeTools(ListeTools);

ImIcone.Clear;
ImVoyant.left:=12;
DeltaX:=13;

////PaIcone.Left:=11;
//try
//   ListeOK:=False;
////   la liste des icone doit être chargée en premier;
//   if FileExists(ExtractFilePath(Application.ExeName)+RepLogo+'fileI.dat') and FileExists(ExtractFilePath(Application.ExeName)+RepLogo+'fileP.dat') and FileExists(ExtractFilePath(Application.ExeName)+RepLogo+'fileC.dat') then
//   begin
//     ListeIcon.LoadFromFile(ExtractFilePath(Application.ExeName)+RepLogo+'fileI.dat');
//     ListeProg.LoadFromFile(ExtractFilePath(Application.ExeName)+RepLogo+'fileP.dat');
//     ListeChe.LoadFromFile(ExtractFilePath(Application.ExeName)+RepLogo+'fileC.dat');
//     if ((ListeProg.Count=ListeIcon.Count) and (ListeIcon.Count=ListeChe.count)and(ListeProg.Count > 0)) then
//      begin
//       HauteurRac:=40;// espace entre les raccourcis
//           if ListeProg.Count > 0 then
//           begin     //148 + (Index*HauteurRac);//BottomLastImage+13+69+28
//             HauteurRac:=22;
//             while ((screen.Height > (148+(ListeProg.Count*HauteurRac)+ 13+69+28)) and (HauteurRac<40)) do
//                          inc(HauteurRac);
//           end;
//        for i:=0 to ListeProg.Count-1 do AjouteItem(i,ListeProg.Strings[i]);
//        ListeOK:=true;
//      end
//        else
//      begin
//         ListeProg.Clear;
//         ListeIcon:=ListeFic('*.ICO',ExtractFilePath(Application.ExeName)+RepLogo,faAnyFile,true,true);
//         if ListeIcon.Count > 0 then
//            for i:=0 to ListeIcon.Count-1 do
//               if FileExists(ListeIcon.Strings[i]) then
//                deleteFile(ListeIcon.Strings[i]);
//
//         ListeIcon.Clear;
//         ListeChe.Clear;
//         if FileExists(ExtractFilePath(Application.ExeName)+RepLogo+'fileI.dat') then
//          deleteFile(ExtractFilePath(Application.ExeName)+RepLogo+'fileI.dat');
//         if FileExists(ExtractFilePath(Application.ExeName)+RepLogo+'fileP.dat') then
//          deleteFile(ExtractFilePath(Application.ExeName)+RepLogo+'fileP.dat');
//         if FileExists(ExtractFilePath(Application.ExeName)+RepLogo+'fileC.dat') then
//          deleteFile(ExtractFilePath(Application.ExeName)+RepLogo+'fileC.dat');
////         ShowMEssage('Une erreur est survenu lors de la récupération des informations !');
//      end;
//   end;
//if not ((ListeIcon.Count=ListeProg.count) and (ListeProg.count=ListeChe.Count) and (ListeOk=true)) then
//   begin
//    if ListeProg.Count > 0 then
//     for i:=0 to ListeProg.count-1 do SupprimeItem(i);
//     ListeProg.Clear;
//     if ListeIcon.Count > 0 then
//        for i:=0 to ListeIcon.Count-1 do
//           if FileExists(ListeIcon.Strings[i]) then
//            deleteFile(ListeIcon.Strings[i]);
//
//     ListeIcon.Clear;
//     ListeChe.Clear;
//     if FileExists(ExtractFilePath(Application.ExeName)+RepLogo+'fileI.dat') then
//      deleteFile(ExtractFilePath(Application.ExeName)+RepLogo+'fileI.dat');
//     if FileExists(ExtractFilePath(Application.ExeName)+RepLogo+'fileP.dat') then
//      deleteFile(ExtractFilePath(Application.ExeName)+RepLogo+'fileP.dat');
//     if FileExists(ExtractFilePath(Application.ExeName)+RepLogo+'fileC.dat') then
//      deleteFile(ExtractFilePath(Application.ExeName)+RepLogo+'fileC.dat');
////     ShowMEssage('Une erreur est survenu lors de la récupération des informations !');
//   end;
////   if FileExists(ExtractFilePath(Application.ExeName)+RepLogo+'fileP.dat') then
////   begin
////     ListeProg.LoadFromFile(ExtractFilePath(Application.ExeName)+RepLogo+'fileP.dat');
////     for i:=0 to ListeProg.Count-1 do AjouteItem(i,ListeProg.Strings[i]);
////   end;
////
////   if FileExists(ExtractFilePath(Application.ExeName)+RepLogo+'fileC.dat') then
////   begin
////     ListeChe.LoadFromFile(ExtractFilePath(Application.ExeName)+RepLogo+'fileC.dat');
////   end;
//except
//
//end;
ShockwaveFlash2.EmbedMovie:=false;
ShockwaveFlash2.Refresh;
ShockwaveFlash2.Update;
ShockwaveFlash2.Movie:=ExtractFilePath(Application.ExeName)+RepLogo+'logo2.swf';
ShockwaveFlash2.Play;
ShockwaveFlash2.EmbedMovie:=true;
LittleTools:=false;
//LittleTools:=PetitsIconestoujoursvisible1.Checked;
//HauteurRac:=40;// espace entre les raccourcis
//    if ListeProg.Count > 0 then
//    begin     //148 + (Index*HauteurRac);//BottomLastImage+13+69+28
//      HauteurRac:=22;
//      while ((screen.Height > (148+(ListeProg.Count*HauteurRac)+ 13+69+28)) and (HauteurRac<40)) do
//                   inc(HauteurRac);
////      if (148+(ListeProg.Count*HauteurRac)+ 13+69+28> screen.Height then
////         HauteurRac:=22;// espace entre les raccourcis
//    end
//    else
//    begin
//    end;
//Image3DblClick(Image5);

//ShockwaveFlash1.Movie:=ExtractFilePath(Application.ExeName)+'applipub.swf';
//ShockwaveFlash1.EmbedMovie:=true;
//ShockwaveFlash1.Play;
except
      Showmessage('L''assistant n''est pas disponible.');
      AppliOne.Release;
      AppliOne:=nil;
      abort;
end;
END;

procedure TAppliOne.Button1Click(Sender: TObject);
begin
self.close;
end;

procedure TAppliOne.Image3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
VAR Rgn : THandle;
begin
if shift=[ssleft] then
   begin
//   if Form2 <> nil then
//      if Form2.visible then
//         begin
//      Form2.top:=self.Top+25;
//      Form2.Left:=self.Left-Form2.width+12;
////      Form2.Memo1.SetFocus;
////    Form2.perform(WM_SYSCOMMAND, $F012, 0);
//         end;
    ReLeaseCapture;
    perform(WM_SYSCOMMAND, $F012, 0);
end;

end;

procedure TAppliOne.MoveMessage(var Msg:Tmessage);
begin
//if Form2 <> nil then
//   if Form2.visible then
//      begin
//   Form2.top:=self.Top+25;
//   Form2.Left:=self.Left-Form2.width+12;
//   Form2.Memo1.SetFocus;
//      end;
end;
procedure TAppliOne.AppMessage(var Msg: TMsg; var Handled: Boolean);
begin
////   Form4.Memo1.Lines.Add(inttostr(Msg.message));
//  if Msg.message = WM_CAPTURECHANGED then
//  begin
//
//    Form2.top:=Form2.Top;
////    Memo1.Lines.LoadFromFile(StrPas(PChar(Msg.lParam)));
////    Handled := True;
//  end;
//  { Pour tous les autres messages, cette gestion est inactive}
//  { les gestionnaires des autres messages peuvent répondre }
end;

procedure TAppliOne.Image3DblClick(Sender: TObject);
VAR
Rgn,Rgn2,rgn3,Rond : THandle;
index,delta,Arrondi,i:integer;
TriangleG,TriangleD,TriangleL:array [0..2] of TPoint;
begin
      //P1
      TriangleG[0].x:=0+DeltaX;
      TriangleG[0].y:=84;
      //P2
      TriangleG[1].x:=7+DeltaX;
      TriangleG[1].y:=91;
      //P3
      TriangleG[2].x:=0+DeltaX;
      TriangleG[2].y:=98;
      //P4
      TriangleD[0].x:=193+DeltaX;
      TriangleD[0].y:=80;
      //P5
      TriangleD[1].x:=186+DeltaX;
      TriangleD[1].y:=91;
      //P6
      TriangleD[2].x:=193+DeltaX;
      TriangleD[2].y:=98;
      Arrondi:=28;
//    combineRgn(region2, region2, region1, RGN_DIFF);
case self.Tag of
   1:Begin
//     AppliOne.Invalidate;
      HauteurRac:=40;// espace entre les raccourcis
        if ListeProg.Count > 0 then
        begin     //148 + (Index*HauteurRac);//BottomLastImage+13+69+28
          HauteurRac:=26;
          while ((screen.Height > (148+(ListeProg.Count*HauteurRac)+ 13+69+28)) and (HauteurRac<40)) do
                       inc(HauteurRac);
        end;
      BottomLastImage:=148;
      index:=0;
      if ((FindComponent('SB'+Inttostr(Index)) as TRxSpeedButton)<>nil)
      then
      repeat
      (FindComponent('SB'+Inttostr(Index)) as TRxSpeedButton).top:=148+(Index*HauteurRac)+24;
      (FindComponent('SB'+Inttostr(Index)) as TRxSpeedButton).Visible:=true;
      (FindComponent('IM'+Inttostr(Index)) as TImage).top:=148+(Index*HauteurRac)+22;
      (FindComponent('IM'+Inttostr(Index)) as TImage).Visible:=true;
      BottomLastImage:=(FindComponent('IM'+Inttostr(Index)) as TImage).Top+(FindComponent('IM'+Inttostr(Index)) as TImage).Height;
      inc(index);
      until ((FindComponent('SB'+Inttostr(Index)) as TRxSpeedButton)=nil);

      Image13.Visible:=true;
//      Image5.Top:=77;
      Image5.Visible:=true;
//      Image5.Visible:=true;
//      Image5.top:=BottomLastImage+7; // Top ancien reducteur
      Image11.top:=BottomLastImage+11;
      Image6.Visible:=true;
      Image6.Top:=87;
      Image6.Height:=BottomLastImage+20;
      //AppliOne.Height-Image6.Top-53;
      //Image6.Height+Image6.Top-10;
      //Image7.Height+(HauteurRac*ListeProg.Count)+48;
//      Image5.top:=AppliOne.Height-75;
//      RxSBReleveurBas.top:=Image5.top+3;
      //166+(HauteurRac*ListeProg.Count);
      Image2.Visible:=False;
      Image2.top:=155;
      RxSBLegrain.Top:=BottomLastImage+28;
      RxSBGwi.top:=BottomLastImage+28;
      Image13.Top:=BottomLastImage+62;
      Image13.Left:=10+DeltaX;
      Image13.Width:=175;
      RxSBPosteTravail.Top:=BottomLastImage+61;
      RxSBPosteTravail.Left:=19+DeltaX;
      RxSBCalculatrice.Top:=BottomLastImage+61;
      RxSBCalculatrice.Left:=40+DeltaX;
      RxSBProg3.Top:=BottomLastImage+61;
      RxSBProg3.Left:=61+DeltaX;
      RxSBProg4.Top:=BottomLastImage+61;
      RxSBProg4.Left:=82+DeltaX;
      RxSBProg5.Top:=BottomLastImage+61;
      RxSBProg5.Left:=103+DeltaX;
      RxSBProg6.Top:=BottomLastImage+61;
      RxSBProg6.Left:=124+DeltaX;
      RxSBProg7.Top:=BottomLastImage+61;
      RxSBProg7.Left:=145+DeltaX;
      RxSBProg8.Top:=BottomLastImage+61;
      RxSBProg8.Left:=166+DeltaX;

//      ShockwaveFlash1.Visible:= true;
//      ShockwaveFlash2.Visible:= true;

      self.tag:=2;

      self.Width:=193+DeltaX;
      self.Height:=BottomLastImage+13+69;
      if self.Height+self.top > Screen.height then
       begin
       DernPos:=self.top;
        if (((self.Height+self.top-Screen.height) > 0) and (self.Height < screen.Height)) then
         self.top:=(self.top-(self.Height+self.top-Screen.height)) else self.top:=0;
       end;
//       else AppliOne.top:=DernPos;
      //(HauteurRac*ListeProg.Count);
      //CreateRoundRectRgn(début,début,largeur,hauteur,angle,angle); //carre debut
//      i:=(BottomLastImage+13+69);
//      i:=375;
//      Rgn:=CreateRoundRectRgn(0,0,193+DeltaX,i,28,28); //carre ouvert
//      while i < 400 do
//      begin
//      delay(1000);
//      inc(i);
//////      showmessage('ee');
//      Rgn2:=CreateRoundRectRgn(0,0,193+DeltaX,i,28,28); //carre ouvert
//      CombineRgn(Rgn,Rgn,Rgn2,RGN_OR);
//      SetWindowRgn(Handle,Rgn,TRUE);
//      end;
      Rgn2:=CreateRoundRectRgn(13,0,193+DeltaX,94,27,27); //carre debut
      Rgn:=CreateRoundRectRgn(13,93,193+DeltaX,(BottomLastImage+13+69),27,27); //carre debut
//      Rgn:=CreateRoundRectRgn(13,0,193+DeltaX,(BottomLastImage+13+69),27,27); //carre debut
      CombineRgn(Rgn,Rgn,Rgn2,RGN_OR);
//      Rond:=createEllipticRgn(-Arrondi-13, -Arrondi-11, Arrondi-3, Arrondi-1);
                              //                         bas
      Rond:=createEllipticRgn(-Arrondi-1, -Arrondi-1, Arrondi+9, Arrondi);
      CombineRgn(Rgn,Rgn,Rond,RGN_DIFF);
//      Rgn2:=CreatePolygonRgn(TriangleG,3,WINDING);
//      CombineRgn(Rgn,Rgn,Rgn2,RGN_DIFF);
//      Rgn2:=CreatePolygonRgn(TriangleD,3,WINDING);
//      CombineRgn(Rgn,Rgn,Rgn2,RGN_DIFF);
      Rgn2:=CreateRectRgn(1,28,10,78); //carre debut
      CombineRgn(Rgn,Rgn,Rgn2,RGN_OR);
//      Rgn2:=CreateRectRgn(17,26,178,67); //carre debut
//      CombineRgn(Rgn,Rgn,Rgn2,RGN_DIFF);
      SetWindowRgn(Handle,Rgn,TRUE);
     End;

   2:Begin
////      PaIcone.Visible:=False;
//      Delta:=20;
//      AppliOne.Height:=130-Delta;//old
//      if AppliOne.Height+AppliOne.top > Screen.height then
//       begin
//        if (((AppliOne.Height+AppliOne.top-Screen.height) > 0) and (AppliOne.Height < screen.Height)) then
//         AppliOne.top:=(AppliOne.top-(AppliOne.Height+AppliOne.top-Screen.height)) else AppliOne.top:=DernPos;
//       end;
////         else AppliOne.top:=DernPos;
//      //P7
//      TriangleL[0].x:=18;
//      TriangleL[0].y:=72;
//      //P8
//      TriangleL[1].x:=70;
//      TriangleL[1].y:=8;
//      //P9
//      TriangleL[2].x:=18;
//      TriangleL[2].y:=86;
//      if LittleTools=true then
//         begin
//           Rgn:=CreateRoundRectRgn(0,0,193+DeltaX,130-Delta,27,27); //carre debut
//           Rgn2:=CreatePolygonRgn(TriangleG,3,WINDING);
//           CombineRgn(Rgn,Rgn,Rgn2,RGN_DIFF);
//           Rgn2:=CreatePolygonRgn(TriangleD,3,WINDING);
//           CombineRgn(Rgn,Rgn,Rgn2,RGN_DIFF);
////           Rgn2:=CreatePolygonRgn(TriangleL,3,WINDING);
////           CombineRgn(Rgn,Rgn,Rgn2,RGN_DIFF);
////           Rond:=createEllipticRgn(-Arrondi, -Arrondi, Arrondi, Arrondi);
//           Rond:=createEllipticRgn(-Arrondi-13+DeltaX, -Arrondi-11+DeltaX, Arrondi-3+DeltaX, Arrondi-1+DeltaX);
//           CombineRgn(Rgn,Rgn,Rond,RGN_DIFF);
//           Image13.Visible:=true;
//         end
//         else
//         begin
//           Rgn:=CreateRoundRectRgn(0,0,193+DeltaX,130-Delta,27,27); //carre debut
//           Rond:=createEllipticRgn(-Arrondi-13+DeltaX, -Arrondi-11+DeltaX, Arrondi-3+DeltaX, Arrondi-1+DeltaX);
//           CombineRgn(Rgn,Rgn,Rond,RGN_DIFF);
////           Rond:=createEllipticRgn(-Arrondi, -Arrondi, Arrondi, Arrondi);
////           CombineRgn(Rgn,Rgn,Rond,RGN_DIFF);
//           Rgn2:=CreateRectRgn(17+DeltaX,26,178+DeltaX,67); //carre debut
//           CombineRgn(Rgn,Rgn,Rgn2,RGN_DIFF);
//           Rgn2:=CreatePolygonRgn(TriangleG,3,WINDING);
//           CombineRgn(Rgn,Rgn,Rgn2,RGN_DIFF);
//           Rgn2:=CreatePolygonRgn(TriangleD,3,WINDING);
//           CombineRgn(Rgn,Rgn,Rgn2,RGN_DIFF);
//           Image13.Visible:=false;
//         end;
////      Rgn2:=CreateRectRgn(2,15,190,33); //carre debut
////      Rgn:=CreateRoundRectRgn(0,0,193,130-Delta,27,27); //carre debut
////      Rgn:=CreateRoundRectRgn(0,0,193,130,27,27); //carre debut
////    combineRgn(region2, region2, region1, RGN_DIFF);
////      CombineRgn(Rgn,Rgn,Rgn2,RGN_DIFF);
//      SetWindowRgn(Handle,Rgn,TRUE);

// gestion de l'affichage replié
//      Image5.Top:=77-Delta;
//      Image5.Visible:=true;
//      Image6.Visible:=true;
//      Image6.Top:=87-Delta;
//      Image6.Height:=AppliOne.Height-Image6.Top-55-Delta;
//      Image5.top:=111-Delta+1;
////      RxSBReleveurBas.top:=Image5.top+3-Delta;
//      Image11.top:=59;
//      RxSBLegrain.Top:=200;
//      RxSBGwi.top:=200;
//      Image13.Top:=58-Delta;
//      Image13.Left:=17+DeltaX;
//      Image13.Width:=161;
//      RxSBPosteTravail.Top:=58-Delta;
//      RxSBPosteTravail.Left:=25+DeltaX;
//      RxSBCalculatrice.Top:=58-Delta;
//      RxSBCalculatrice.Left:=44+DeltaX;
//      RxSBProg3.Top:=58-Delta;
//      RxSBProg3.Left:=64+DeltaX;
//      RxSBProg4.Top:=58-Delta;
//      RxSBProg4.Left:=83+DeltaX;
//      RxSBProg5.Top:=58-Delta;
//      RxSBProg5.Left:=103+DeltaX;
//      RxSBProg6.Top:=58-Delta;
//      RxSBProg6.Left:=123+DeltaX;
//      RxSBProg7.Top:=58-Delta;
//      RxSBProg7.Left:=142+DeltaX;
//      RxSBProg8.Top:=58-Delta;
//      RxSBProg8.Left:=162+DeltaX;
      Image1Click(Image1);
      ShockwaveFlash1.Visible:= false;
      ShockwaveFlash2.Visible:= false;
//      index:=0;
//      if ((FindComponent('SB'+Inttostr(Index)) as TRxSpeedButton)<>nil)
//      then
//      repeat
//      (FindComponent('SB'+Inttostr(Index)) as TRxSpeedButton).Visible:=false;
//      (FindComponent('IM'+Inttostr(Index)) as TImage).Visible:=false;
//      inc(index);
//      until ((FindComponent('SB'+Inttostr(Index)) as TRxSpeedButton)=nil);
      self.tag:=1;
     End;
end;

end;

procedure TAppliOne.Image4Click(Sender: TObject);
VAR Rgn : THandle;
begin
application.Minimize;
self.WindowState:=wsMinimized;
DsBarreTache:=true;
end;

procedure TAppliOne.ShockwaveFlash1FSCommand(Sender: TObject; const command,
  args: WideString);
//var
//NumFrame,NbFrame,NbTours:integer;
begin
//if command='debut' then
//   begin
//   NbFrame:=25;
////   StrToInt(args);
//   NumFrame:=NumFrame+NbFrame;
////   showmessage(args);
//   end;
//if command='fin' then
//   begin
//        NbTours:=1;//StrToInt(args);
////        showmessage('Fin  ' +args);
//   end;
////   else NbTours:=-1;
//if NumFrame=NbFrame*NbTours then Image7Click(TimerPub);
////inc(IndicePub);
//
////showmessage(args);
////inc(IndicePub);
////ShellExecute(handle, 'explore', 'C:\', NiL, NiL, SW_SHOWNORMAL);
end;

procedure TAppliOne.FtpStateChange(sender: TObject);
begin

//case FtpClient1.State of
//   ftpConnected:Begin
////                 FtpClient1.HostDirName     := '\';
////                 FtpClient1.HostFileName    := 'FTPdir.TXT';
////                 FtpClient1.LocalFileName   := 'C:\temp\FTPdir.TXT';
////                 FtpClient1.Passive         := false;
////                 FtpReceiveForm.ExecuteCmd(FtpClient1.Get, FtpClient1.GetAsync);
//                End;
//
//   ftpWaitingResponse:Begin
////                      FtpClient1.HostDirName     := '\';
////                      FtpClient1.HostFileName    := 'FTPdir.TXT';
////                      FtpClient1.LocalFileName   := 'C:\temp\FTPdir.TXT';
////                      FtpClient1.Passive         := false;
////                      FtpReceiveForm.ExecuteCmd(FtpClient1.Get, FtpClient1.GetAsync);
//                      End;
//  ftpReady:Begin
//            case FtpClient1.StatusCode of
//              230:Begin
////                 sleep(10000);
////                 FtpClient1.HostDirName     := '\';
////                 FtpClient1.HostFileName    := 'FTPdir.TXT';
////                 FtpClient1.LocalFileName   := 'C:\temp\FTPdir.TXT';
////                 FtpClient1.Passive         := false;
////                 FtpReceiveForm.ExecuteCmd(FtpClient1.Get, FtpClient1.GetAsync);
//                End;
//               226:Begin
//                   FtpClient1.Quit;
//                   End;
//
//            end;
//
//           End;
//
//
//end;
//
end;

procedure TAppliOne.Image9Click(Sender: TObject);
begin
//Ftp OK
////    while not (FtpClient1.State=ftpConnected) do;
//    FtpClient1.HostDirName     := '\';
//    FtpClient1.HostFileName    := 'FTPdir.TXT';
//    FtpClient1.LocalFileName   := 'C:\temp\FTPdir.TXT';
//    FtpClient1.Passive         := false;
//    FtpReceiveForm.ExecuteCmd(FtpClient1.Get, FtpClient1.GetAsync);
////    while FtpClient1.State=ftpWaitingResponse do;


//    FtpReceiveForm.ExecuteCmd(FtpClient1.Quit, FtpClient1.QuitAsync);
//    FtpClient1.HostDirName     := '\';
//    FtpClient1.HostFileName    := 'FTPdir.TXT';
//    FtpClient1.LocalFileName   := 'C:\temp\FTPdir.TXT';
//    FtpClient1.Passive         := false;
//    FtpClient1.GetAsync;
//    if FtpClient1.Get then
//       showmessage('ok') else showmessage('Non');
////    ExecuteCmd(FtpClient1.Get, FtpClient1.GetAsync);
//
//    FtpClient1.Quit;
//ShellExecute(handle, nil, 'http://www.gwi.fr', NiL, NiL, SW_SHOWNORMAL);
end;

procedure TAppliOne.Image10Click(Sender: TObject);
begin
//ShellExecute(handle, 'printer', 'regfile:', NiL, NiL, SW_SHOWNORMAL);
//HTML1.RequestDoc('http://www.legrain.fr/UntitledFrame-3.php?ValId=0&NomFic=tototo.txt');
//HTML1.RequestDoc('http://www.legrain.fr');

//ShellExecute(handle, 'open', 'mailto:', NiL, NiL, SW_SHOWNORMAL);
//ShellExecute(handle, 'open', 'telnet:', NiL, NiL, SW_SHOWNORMAL);
//ShellExecute(handle, 'open', 'news:', NiL, NiL, SW_SHOWNORMAL);
//ShellExecute(handle, 'open', 'callto:', NiL, NiL, SW_SHOWNORMAL);
//ShellExecute(handle, 'open', 'ftp:', NiL, NiL, SW_SHOWNORMAL);

//ShellExecute(handle, nil, 'http://www.legrain.fr/UntitledFrame-3.php?ValId=0&NomFic=titi.txt', NiL, NiL, SW_SHOWNORMAL);
//******************************************************************************
// Connection OK
//    FtpClient1.OnStateChange:=FtpStateChange;
//    FtpClient1.HostName        := 'gwi.fr';
//    FtpClient1.Port            := '21';
//    FtpClient1.UserName        := 'ftpgwi';
//    FtpClient1.Password        := 'siLsont';
//    FtpClient1.DisplayFileFlag := False;
//    FtpReceiveForm.ExecuteCmd(FtpClient1.Connect, FtpClient1.ConnectAsync);
//******************************************************************************
// Connection OK
//    FtpClient1.OnStateChange:=FtpStateChange;
//    FtpClient1.HostName        := 'ftp.legrain.fr';
//    FtpClient1.Port            := '21';
//    FtpClient1.UserName        := 'legrains';
//    FtpClient1.Password        := 'tXvyCtWt';
//    FtpClient1.DisplayFileFlag := False;
//    FtpReceiveForm.ExecuteCmd(FtpClient1.Connect, FtpClient1.ConnectAsync);
//******************************************************************************


//ShellExecute(handle, nil, 'http://www.legrain.fr', NiL, NiL, SW_SHOWNORMAL);

//ShockwaveFlash1.StopPlay;
//ShockwaveFlash1.EmbedMovie:=false;
//ShockwaveFlash1.Movie:=ExtractFilePath(Application.ExeName)+'essai.swf';
//ShockwaveFlash1.EmbedMovie:=true;
//ShockwaveFlash1.Play;

//    FtpClient1.HostName        := 'ftp.legrain.fr';
//    FtpClient1.Port            := '21';
//    FtpClient1.UserName        := 'legrains';
//    FtpClient1.Password        := 'tXvyCtWt';
//    FtpClient1.DisplayFileFlag := False;
//    FtpClient1.Connect;

//    FtpClient1.HostDirName     := '\';
//    FtpClient1.HostFileName    := 'FTPdir.TXT';
//    FtpClient1.LocalFileName   := 'C:\temp\FTPdir.TXT';
//    FtpClient1.Passive         := true;
//    FtpClient1.GetAsync;
//    if FtpClient1.Get then
//       showmessage('ok') else showmessage('Non');
////    ExecuteCmd(FtpClient1.Get, FtpClient1.GetAsync);
//
//    FtpClient1.Quit;

//FTP1.GetFile('FTPdir.TXT','C:\temp\FTPdir.TXT');

//    FtpClient1.OnDisplay       := Display;
//    ExecuteCmd(FtpClient1.Connect, FtpClient1.ConnectAsync);
end;

procedure TAppliOne.FormClose(Sender: TObject; var Action: TCloseAction);
begin
ShockwaveFlash1.StopPlay;
//if (@NotifyStruc <> nil) then Shell_NotifyIcon(NIM_DELETE,@NotifyStruc);
end;

procedure TAppliOne.FtpClient1RequestDone(Sender: TObject;
  RqType: TFtpRequest; Error: Word);
begin
// FTP OK
//case FtpClient1.StatusCode of
//  230:Begin
//     FtpClient1.HostDirName     := '\web\pub\';
//     FtpClient1.HostFileName    := 'pub8.swf';
//     FtpClient1.LocalFileName   := ExtractFilePath(Application.ExeName)+'pub8.swf';
//     FtpClient1.Passive         := false;
//     FtpReceiveForm.ExecuteCmd(FtpClient1.Get, FtpClient1.GetAsync);
////******************************************************************************
////     FtpClient1.HostDirName     := '\';
////     FtpClient1.HostFileName    := 'FTPdir.TXT';
////     FtpClient1.LocalFileName   := 'C:\temp\FTPdir.TXT';
////     FtpClient1.Passive         := false;
////     FtpReceiveForm.ExecuteCmd(FtpClient1.Get, FtpClient1.GetAsync);
////******************************************************************************
//    End;
//end;

end;

procedure TAppliOne.FormDestroy(Sender: TObject);
begin
DestroyForm(self);
if not DirectoryExists(ExtractFilePath(Application.ExeName)+RepPub) then
        ForceDirectories(ExtractFilePath(Application.ExeName)+RepPub);

if not DirectoryExists(ExtractFilePath(Application.ExeName)+RepLogo) then
        ForceDirectories(ExtractFilePath(Application.ExeName)+RepLogo);

 ListeProg.SaveToFile(ExtractFilePath(Application.ExeName)+RepLogo+'fileP.dat');
 ListeProg.Free;
// ListeIcon.SaveToFile(ExtractFilePath(Application.ExeName)+RepLogo+'fileI.dat');
 ListeIcon.Free;
// ListeChe.SaveToFile(ExtractFilePath(Application.ExeName)+RepLogo+'fileC.dat');
 ListeChe.Free;
 ListeTools.SaveToFile(ExtractFilePath(Application.ExeName)+RepLogo+'fileTH.dat');
 ListeTools.Free;
 ListeToolsP.SaveToFile(ExtractFilePath(Application.ExeName)+RepLogo+'fileTP.dat');
 ListeToolsP.Free;
ListePub.Free;
end;

procedure TAppliOne.Image8Click(Sender: TObject);
var
i:integer;
ch:char;
begin
if EdNameProg.Visible then
   begin
    ch:=#13;
    EdNameProgKeyPress(EdNameProg,ch);
   end
   else
   begin
    i:=strtoint(copy((Sender as TImage).Name,3,3));
    IndiceItem:=i;
    EdNameProg.Top:=(Sender as TImage).top+7;
    EdNameProg.left:=47;
    EdNameProg.Text:=(FindComponent('SB'+inttostr(i)) as TRxSpeedButton).Caption;
    EdNameProg.Visible:=true;
    EdNameProg.SetFocus;
   end;
end;

procedure TAppliOne.EdNameProgKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
   Begin
    (FindComponent('SB'+inttostr(IndiceItem)) as TRxSpeedButton).Caption:=EdNameProg.Text;
    ListeProg.Strings[IndiceItem]:=EdNameProg.Text;
    RxPopMain.Items[indiceItem].Caption:=EdNameProg.Text;
    EdNameProg.Visible:=False;
   End;
end;

procedure TAppliOne.RxSpeedButton1MouseEnter(Sender: TObject);
var
i:integer;
begin
i:=strtoint(copy((Sender as TRxSpeedButton).Name,3,3));
//try
// ImIco.Picture.LoadFromFile(ListeIcon.Strings[i]);
//except
// ImIco.Picture:=ImIcoDefaut.Picture;
//end;
ImVoyant.Top:=(Sender as TRxSpeedButton).top+5;
ImVoyant.Left:=(Sender as TRxSpeedButton).left-19;
ImVoyant.Visible:=true;
ImVoyant.BringToFront;
//PaIcone.top:=(Sender as TRxSpeedButton).top-7;
//PaIcone.Visible:=true;
end;

procedure TAppliOne.RxSpeedButton1MouseLeave(Sender: TObject);
begin
//PaIcone.Visible:=false;
ImVoyant.Visible:=false;
end;

procedure TAppliOne.EdNameProgExit(Sender: TObject);
begin
    RxSpeedButton1.Caption:=EdNameProg.Text;
    EdNameProg.Visible:=False;
end;

procedure TAppliOne.RxSpeedButton1Click(Sender: TObject);
var
i:integer;
s,Chemin,Prog:string;
Pchemin,PProg:array[0..255] of Char;
begin
i:=strtoint(copy((Sender as TRxSpeedButton).Name,3,3));
Prog:=copy(ListeChe.Strings[i],LastDelimiter('\',ListeChe.Strings[i])+1,length(ListeChe.Strings[i]));
Chemin:=copy(ListeChe.Strings[i],1,LastDelimiter('\',ListeChe.Strings[i]));
StrPCopy(PProg,Prog);
StrPCopy(PChemin,Chemin);
ShellExecute(0, nil, PProg, nil, Pchemin,SW_SHOWNORMAL);
end;

procedure TAppliOne.ShockwaveFlash1Progress(Sender: TObject;
  percentDone: Integer);
begin
//ShockwaveFlash1.Stop;
//ShockwaveFlash1.EmbedMovie:=false;
//ShockwaveFlash1.Movie:=ExtractFilePath(Application.ExeName)+'applipub1.swf';
//ShockwaveFlash1.EmbedMovie:=true;
//ShockwaveFlash1.Play;
end;

procedure TAppliOne.Timer1Timer(Sender: TObject);
begin
if Detection_Connexion= true then
   begin {Connecté}
   // vérifiez si fournisseur mise à jour
   Timer1.Enabled:=false;
   Timer2.Enabled:=true;
//   Image10Click(Image10);
//   MessageBox(0,'Voulez-vous mettre à jour les catalogues ?','Confirmation',MB_YESNO);
   end
   else
   begin {Non Connecté}
//   beep;
   end;
end;

procedure TAppliOne.Timer2Timer(Sender: TObject);
begin
//if (0=(InternetgetConnectedState($0,$0))) then
if Detection_Connexion= false then
   begin {Déconnecté}
      Timer1.Enabled:=true;
      Timer2.Enabled:=false;
   end;
end;

procedure TAppliOne.Quitter1Click(Sender: TObject);
begin
self.close;
end;

procedure TAppliOne.Image3Click(Sender: TObject);
begin
//if Form2 <> nil then
//  begin
//   if Form2.visible then
//      begin
//    Form2.visible:=false;
//      end;
//  end;
self.visible:=false;
//ShowWindow(Application.handle,SW_HIDE);
end;

procedure TAppliOne.FormActivate(Sender: TObject);
begin
//if Form2 <> nil then
//  begin
//   if Form2.visible then
//      begin
//   Form2.top:=self.Top+25;
//   Form2.Left:=self.Left-Form2.width+12;
//   Form2.Memo1.SetFocus;
//      end;
//  end;
////if self.WindowState=wsMinimized then SetForegroundWindow(handle);
end;

procedure TAppliOne.RxPopMainGetImageIndex(Sender: TMenu; Item: TMenuItem;
  State: TMenuOwnerDrawState; var ImageIndex: Integer);
begin
  if Item.Tag >= 0 then ImageIndex := Item.Tag;
end;

procedure TAppliOne.RxPopMainPopup(Sender: TObject);
begin
if RxPopMain.Items.Count=0 then abort;
end;

procedure TAppliOne.SupprItem1Click(Sender: TObject);
begin
SupprimeItem((Sender as TMenuItem).Tag);
end;

procedure TAppliOne.ShockwaveFlash2FSCommand(Sender: TObject; const command,
  args: WideString);
begin
//if command='gwi' then showmessage(args);
end;

procedure TAppliOne.RxSBPosteTravailMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//   ListeTools.Add('Explorateur');
//   ListeTools.Add('Rechercher ...');
//   ListeTools.Add('Courrier');
//   ListeTools.Add('Internet');
//   ListeTools.Add('News');

RxPopTools.Items[0].Caption:='Changer le raccourci de : '+ListeTools.Strings[(sender as TRxSpeedButton).tag];
RxPopTools.Items[0].tag:=(sender as TRxSpeedButton).tag;
RxPopTools.Items[1].Caption:='Changer le libellé de : '+ListeToolsP.Strings[(sender as TRxSpeedButton).tag]; ;
RxPopTools.Items[1].tag:=(sender as TRxSpeedButton).tag;
RxPopTools.Items[2].Visible:=False;// -
RxPopTools.Items[3].Visible:=False;// Explorateur
RxPopTools.Items[4].Visible:=False;// Rechercher
RxPopTools.Items[5].Visible:=False;// Courrier
RxPopTools.Items[6].Visible:=False;// Internet
RxPopTools.Items[7].Visible:=False;// News
case (sender as TRxSpeedButton).tag of
   0:begin
      RxPopTools.Items[0].Caption:='Changer le raccourci de : '+ListeToolsP.Strings[(sender as TRxSpeedButton).tag];
      RxPopTools.Items[1].Caption:='Changer le libellé de : '+ListeTools.Strings[(sender as TRxSpeedButton).tag];
      RxPopTools.Items[2].Visible:=true;// -
      RxPopTools.Items[3].Visible:=True;// Explorateur
      RxPopTools.Items[4].Visible:=False;// Rechercher
      RxPopTools.Items[5].Visible:=False;// Courrier
      RxPopTools.Items[6].Visible:=False;// Internet
      RxPopTools.Items[7].Visible:=False;// News
     end;
   1:begin
      RxPopTools.Items[0].Caption:='Changer le raccourci de : '+ListeToolsP.Strings[(sender as TRxSpeedButton).tag];
      RxPopTools.Items[1].Caption:='Changer le libellé de : '+ListeTools.Strings[(sender as TRxSpeedButton).tag];
      RxPopTools.Items[2].Visible:=true;// -
      RxPopTools.Items[3].Visible:=False;// Explorateur
      RxPopTools.Items[4].Visible:=true;// Rechercher
      RxPopTools.Items[5].Visible:=False;// Courrier
      RxPopTools.Items[6].Visible:=False;// Internet
      RxPopTools.Items[7].Visible:=False;// News
     end;
   2:begin
      RxPopTools.Items[0].Caption:='Changer le raccourci de : '+ListeToolsP.Strings[(sender as TRxSpeedButton).tag];
      RxPopTools.Items[1].Caption:='Changer le libellé de : '+ListeTools.Strings[(sender as TRxSpeedButton).tag];
      RxPopTools.Items[2].Visible:=true;// -
      RxPopTools.Items[3].Visible:=False;// Explorateur
      RxPopTools.Items[4].Visible:=False;// Rechercher
      RxPopTools.Items[5].Visible:=true;// Courrier
      RxPopTools.Items[6].Visible:=False;// Internet
      RxPopTools.Items[7].Visible:=False;// News
     end;
   3:begin
      RxPopTools.Items[0].Caption:='Changer le raccourci de : '+ListeToolsP.Strings[(sender as TRxSpeedButton).tag];
      RxPopTools.Items[1].Caption:='Changer le libellé de : '+ListeTools.Strings[(sender as TRxSpeedButton).tag];
      RxPopTools.Items[2].Visible:=true;// -
      RxPopTools.Items[3].Visible:=False;// Explorateur
      RxPopTools.Items[4].Visible:=False;// Rechercher
      RxPopTools.Items[5].Visible:=False;// Courrier
      RxPopTools.Items[6].Visible:=true;// Internet
      RxPopTools.Items[7].Visible:=False;// News
     end;
   4:begin
      RxPopTools.Items[0].Caption:='Changer le raccourci de : '+ListeToolsP.Strings[(sender as TRxSpeedButton).tag];
      RxPopTools.Items[1].Caption:='Changer le libellé de : '+ListeTools.Strings[(sender as TRxSpeedButton).tag];
      RxPopTools.Items[2].Visible:=true;// -
      RxPopTools.Items[3].Visible:=False;// Explorateur
      RxPopTools.Items[4].Visible:=False;// Rechercher
      RxPopTools.Items[5].Visible:=False;// Courrier
      RxPopTools.Items[6].Visible:=False;// Internet
      RxPopTools.Items[7].Visible:=True;// News
     end;
   5:begin
      RxPopTools.Items[0].Caption:='Changer le raccourci de : '+ListeToolsP.Strings[(sender as TRxSpeedButton).tag];
      RxPopTools.Items[1].Caption:='Changer le libellé de : '+ListeTools.Strings[(sender as TRxSpeedButton).tag];
     end;
   6:begin
      RxPopTools.Items[0].Caption:='Changer le raccourci de : '+ListeToolsP.Strings[(sender as TRxSpeedButton).tag];
      RxPopTools.Items[1].Caption:='Changer le libellé de : '+ListeTools.Strings[(sender as TRxSpeedButton).tag];
     end;
   7:begin
      RxPopTools.Items[0].Caption:='Changer le raccourci de : '+ListeToolsP.Strings[(sender as TRxSpeedButton).tag];
      RxPopTools.Items[1].Caption:='Changer le libellé de : '+ListeTools.Strings[(sender as TRxSpeedButton).tag];
     end;
end;
if Button in [mbRight] then RxPopTools.Popup(self.left+X,self.top+self.height-y);
end;

procedure TAppliOne.Modifier1Click(Sender: TObject);
begin
OpenDialog1.InitialDir:=ExtractFileDir(ListeToolsP.Strings[(sender as TMenuItem).tag]);
OpenDialog1.Title:=(sender as TMenuItem).Caption;
if OpenDialog1.Execute then
 begin
 case (sender as TMenuItem).tag of
    0..4:Begin
          ListeToolsP.Strings[(sender as TMenuItem).tag]:=OpenDialog1.FileName;
          ListeTools.Strings[(sender as TMenuItem).tag]:='';
          RxPopTools.Items[(sender as TMenuItem).tag+3].Checked:=false;
         End;

    5..7:Begin
          ListeToolsP.Strings[(sender as TMenuItem).tag]:=OpenDialog1.FileName;
          ListeTools.Strings[(sender as TMenuItem).tag]:='';
         End;
 end;
 end;
end;

procedure TAppliOne.nonon1Click(Sender: TObject);
var
NewCaption:string;
begin
NewCaption:=ListeTools.Strings[(sender as TMenuItem).tag];
if InputQuery('Nouveau libellé','Changer le libellé pour : '+ListeToolsP.Strings[(sender as TMenuItem).tag],NewCaption) then
       ListeTools.Strings[(sender as TMenuItem).tag]:=NewCaption;
end;

procedure TAppliOne.RxSBPosteTravailMouseEnter(Sender: TObject);
begin
 (sender as TRxSpeedButton).Hint:=ListeTools.Strings[(sender as TRxSpeedButton).tag];
 RxPopTools.Items[0].tag:=(sender as TRxSpeedButton).tag;
end;

procedure TAppliOne.RxSBPosteTravailClick(Sender: TObject);
var
i:integer;
s,Chemin,Prog:string;
Pchemin,PProg:array[0..255] of Char;
ProgDefaut:boolean;
begin
//   ListeTools.Add('Explorateur');
//   ListeTools.Add('Rechercher ...');
//   ListeTools.Add('Courrier');
//   ListeTools.Add('Internet');
//   ListeTools.Add('News');
ProgDefaut:=true;
i:=(Sender as TRxSpeedButton).tag;
case i of
   0..4:ProgDefaut:=RxPopTools.Items[i+3].Checked;
   5..7:ProgDefaut:=False;
end;
if ProgDefaut=true then
begin
case i of
//ShellExecute(handle, 'open', 'telnet:', NiL, NiL, SW_SHOWNORMAL);
   0:Begin
          ShellExecute(handle, 'explore', 'c:\', NiL, NiL, SW_SHOWNORMAL);
     End;
   1:Begin
          SearchInFolder('c:\');
     End;
   2:Begin
          ShellExecute(handle, 'open', 'mailto:', NiL, NiL, SW_SHOWNORMAL);
     End;
   3:Begin
          ShellExecute(handle, 'open', 'http:', NiL, NiL, SW_SHOWNORMAL);
     End;
   4:Begin
          ShellExecute(handle, 'open', 'news:', NiL, NiL, SW_SHOWNORMAL);
     End;
  end;
  end
  else
  begin
    Prog:=copy(ListeToolsP.Strings[i],LastDelimiter('\',ListeToolsP.Strings[i])+1,length(ListeToolsP.Strings[i]));
    Chemin:=copy(ListeToolsP.Strings[i],1,LastDelimiter('\',ListeToolsP.Strings[i]));
    StrPCopy(PProg,Prog);
    StrPCopy(PChemin,Chemin);
    if copy(Prog,length(prog)-3,4)='.cpl' then
      WinExec(PChar('rundll32.exe shell32.dll,'+'Control_RunDLL '+Prog),SW_SHOWNORMAL)
      else
    ShellExecute(0, nil, PProg, nil, Pchemin,SW_SHOWNORMAL);
  end;

end;

procedure TAppliOne.RxSBLegrainClick(Sender: TObject);
begin
ShellExecute(handle, nil, 'http://www.legrain.fr/', NiL, NiL, SW_SHOWNORMAL);
end;

procedure TAppliOne.RxSBGwiClick(Sender: TObject);
begin
ShellExecute(handle, nil, 'http://www.gwi.fr/', NiL, NiL, SW_SHOWNORMAL);
end;

procedure TAppliOne.Toujoursvisible1Click(Sender: TObject);
VAR Rgn : THandle;
begin
if Toujoursvisible1.Checked then
   Begin
    Toujoursvisible1.Checked:=false;
    self.FormStyle:=fsNormal;
    ShowWindow(Application.handle,SW_HIDE);
    if (@NotifyStruc <> nil) then Shell_NotifyIcon(NIM_DELETE,@NotifyStruc);
    NotifyStruc.cbSize:=sizeOf(NotifyStruc);
    NotifyStruc.Wnd:=Handle;
    NotifyStruc.uID:=1;
    NotifyStruc.uFlags:=NIF_ICON or NIF_TIP or NIf_MESSAGE;
    NotifyStruc.uCallbackMessage:=WM_PMESSAGE;
    NotifyStruc.hIcon:=AppliOne.Icon.Handle;
    NotifyStruc.szTip:='Appli-One';
    Shell_NotifyIcon(Nim_add,@NotifyStruc);
    NoT2Nul:=false;
      case self.tag of
         1:self.tag:=2;
         2:self.tag:=1;
      end;
      Image3DblClick(Image5);
   End
    else
   Begin
    Toujoursvisible1.Checked:=true;
    self.FormStyle:=fsStayOnTop;
    ShowWindow(Application.handle,SW_HIDE);
    if (@NotifyStruc <> nil) then Shell_NotifyIcon(NIM_DELETE,@NotifyStruc);
    NotifyStruc.cbSize:=sizeOf(NotifyStruc);
    NotifyStruc.Wnd:=Handle;
    NotifyStruc.uID:=1;
    NotifyStruc.uFlags:=NIF_ICON or NIF_TIP or NIf_MESSAGE;
    NotifyStruc.uCallbackMessage:=WM_PMESSAGE;
    NotifyStruc.hIcon:=AppliOne.Icon.Handle;
    NotifyStruc.szTip:='Appli-One';
    Shell_NotifyIcon(Nim_add,@NotifyStruc);
    NoT2Nul:=false;
      case self.tag of
         1:self.tag:=2;
         2:self.tag:=1;
      end;
      Image3DblClick(Image5);
   End;


end;

procedure TAppliOne.PetitsIconestoujoursvisible1Click(Sender: TObject);
begin
PetitsIconestoujoursvisible1.Checked:= not PetitsIconestoujoursvisible1.Checked;
LittleTools:=PetitsIconestoujoursvisible1.Checked;
      case self.tag of
         1:self.tag:=2;
         2:self.tag:=1;
      end;
      Image3DblClick(Image5);
end;

procedure TAppliOne.News1Click(Sender: TObject);
begin
if not (Sender as TMenuItem).Checked then
begin
(Sender as TMenuItem).Checked:=not (Sender as TMenuItem).Checked;
ListeToolsP.Strings[(Sender as TMenuItem).MenuIndex-3]:='' ;
ListeTools.Strings[(Sender as TMenuItem).MenuIndex-3]:=(Sender as TMenuItem).Caption;
//case (Sender as TMenuItem).MenuIndex of
//   3:ListeToolsP.Strings[(Sender as TMenuItem).MenuIndex-3]:='' ;
//   ListeTools.Strings[(Sender as TMenuItem).MenuIndex-3]:=(Sender as TMenuItem).Caption;
//   4:ListeToolsP.Strings[(Sender as TMenuItem).MenuIndex-3]:='' ;
//   5:ListeToolsP.Strings[(Sender as TMenuItem).MenuIndex-3]:='' ;
//   6:ListeToolsP.Strings[(Sender as TMenuItem).MenuIndex-3]:='' ;
//   7:ListeToolsP.Strings[(Sender as TMenuItem).MenuIndex-3]:='' ;
//end;
end;
end;
//RxLabel1.caption:='Déplacement';
//RxLabel1.caption:='';
procedure TAppliOne.RxSpeedButton2Click(Sender: TObject);
begin
ShellExecute(handle, nil, 'http://www.gwi.fr/', NiL, NiL, SW_SHOWNORMAL);
end;

procedure TAppliOne.Image11Click(Sender: TObject);
begin
////form4.Show;
//form2.show;
//Form2.top:=self.Top+25;
//Form2.Left:=self.Left-Form2.width+12;
////    ReLeaseCapture;
////    perform(WM_SYSCOMMAND, SC_MOVE, 0);

end;

procedure TAppliOne.Image1Click(Sender: TObject);
begin
//if Form3 = nil then Form3:=TForm3.create(self);
////Image11.BoundsRect.Bottom
//Form3.Height:=15;
//i:=Image11.BoundsRect.Bottom;
////(BottomLastImage+13+69);
//Form3.left:=left+12;
//Form3.Top:=Image11.BoundsRect.Bottom+self.top-17;
////(BottomLastImage+13+69)+Form3.Height+70;
//Form3.show;
////Form3.FormStyle:=fsStayOnTop;
////Form3.BringToFront;
////ImCache.Visible:=true;
////ImCache.BringToFront;
//TiForm.Enabled:=true;
TiFormTimer(TiForm);
////Form2.Top:=i;
end;

procedure TAppliOne.TiFormTimer(Sender: TObject);
var
Rgn,Rgn2,rgn3,Rond : THandle;
begin
////ImCache.Visible:=true;
////ImCache.BringToFront;
////Image3.visible:=false;
////Image3.Top:=i-10;
////Image3.visible:=true;
////Image3.BringToFront;
////ImCache.Visible:=false;
////      i:=(BottomLastImage+13+69);
////      Rgn:=CreateRoundRectRgn(0,0,193+DeltaX,i,28,28); //carre ouvert
////      while i > 375 do
////      begin
////      if i-40<113 then
//      dec(i,15);
//////      showmessage('ee');
////      ImCache.BringToFront;
      Height:=94;
      Rgn:=CreateRoundRectRgn(13,0,193+DeltaX,94,27,27); //carre debut
//      Rgn:=CreateRoundRectRgn(13,93,193+DeltaX,(BottomLastImage+13+69),27,27); //carre debut
//      Rgn:=CreateRoundRectRgn(12,0,193+DeltaX,i,28,28); //carre ouvert
      Rond:=createEllipticRgn(-28-1, -28-1, 28+9, 28);
      CombineRgn(Rgn,Rgn,Rond,RGN_DIFF);
      Rgn2:=CreateRectRgn(30,26,191,67); //carre vide
//      Rgn2:=CreateRectRgn(1,28,10,78); //carre debut
//////      ExtSelectClipRgn(Handle,Rgn,RGN_DIFF)
      CombineRgn(Rgn,Rgn,Rgn2,RGN_DIFF);
//////      CombineRgn(Rgn,Rgn,Rgn2,RGN_OR);
      SetWindowRgn(Handle,Rgn,TRUE);

////ImCache.Visible:=false;
//      Form3.Top:=i+self.top-17;
////      ImCache.Top:=i-17;
////      Rgn:=Handle;
////      if offsetRgn(Rgn,0,5)=ERROR then showmessage('ee');
////      SetWindowRgn(Handle,Rgn,TRUE);
//      if i<113 then
//      begin
//      TiForm.Enabled:=false;
////      Rgn:=Handle;
////      Rgn2:=Form2.Handle;
////      CombineRgn(Rgn,Rgn,Rgn2,RGN_DIFF);
////      SetWindowRgn(Handle,Rgn,TRUE);
////        Form3.FormStyle:=fsNormal;
//      Form3.Close;
////      ImCache.Visible:=false;
////      showmessage('ee');
//      end;
end;

procedure TAppliOne.Image7Click(Sender: TObject);
begin
//NbFrame:=0;
//NbTours:=-1;
//NumFrame:=0;
//if IndicePub = ListePub.count then IndicePub:=0;
//ShockwaveFlash1.Stop;
////ShockwaveFlash1.Update;
////ShockwaveFlash1.Repaint;
////ShockwaveFlash1.Refresh;
//ShockwaveFlash1.EmbedMovie:=false;
////ShockwaveFlash1.LoadMovie(IndicePub,ExtractFilePath(Application.ExeName)+ListePub.Strings[IndicePub]);
//if ListePub.count > 0 then
//ShockwaveFlash1.Movie:=ExtractFilePath(Application.ExeName)+RepPub+ListePub.Strings[IndicePub];
////ShockwaveFlash1.Update;
////ShockwaveFlash1.Repaint;
////ShockwaveFlash1.Refresh;
//ShockwaveFlash1.EmbedMovie:=true;
//ShockwaveFlash1.Play;
//IndicePub:=IndicePub+1;
Image3DblClick(Image7);
end;

procedure TAppliOne.RxSBSearchLocalClick(Sender: TObject);
begin
SearchInFolder('c:');
end;

procedure TAppliOne.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if shift = [ssctrl,ssShift] then
   if self.visible then
    self.Hide;// else AppliOne.Show;
end;

procedure TAppliOne.FormShow(Sender: TObject);
var
i:integer;
begin
if ListeProg <> nil then
 begin
  while ListeProg.Count > 0 do
//  for i:=0 to ListeProg.Count-1 do
   begin
    SupprimeItem(ListeProg.Count-1);
   end;
  ListeProg.Clear;
  for i:=0 to Main.ListForm.Count-1 do
  if i <= 15 then
   Begin
    self.Invalidate;
      ListeProg.Insert(0,Main.ListForm.Strings[i]);
      ConstruitPopMenu(0,Main.ListForm.Strings[i],RxPopMain.items);
      AjouteItem(0,Main.ListForm.Strings[i]);
   End;
  self.Invalidate;
  if Main.ListForm.Count > 0 then Image3DblClick(Image5);
 end;
end;

end.



// Code de Image5Clic
//VAR
//Rgn : THandle;
//index:integer;
//      case self.tag of
//         1:begin
//            AppliOne.Width:=193;
//            AppliOne.Height:=120;
//            //CreateRoundRectRgn(début,début,largeur,hauteur,angle,angle); //carre debut
//            Rgn:=CreateRoundRectRgn(0,0,193,120,27,27); //carre debut
//            SetWindowRgn(Handle,Rgn,TRUE);
//            Image2.Top:=77;
//            Image5.Visible:=true;
//            Image6.Visible:=true;
//            Image6.Top:=90;
//            Image5.top:=103;
////            RxSBReleveurBas.top:=Image5.top+3;
//            Image11.top:=148;
//            ShockwaveFlash1.Visible:= false;
//            index:=0;
//            if ((FindComponent('SB'+Inttostr(Index)) as TRxSpeedButton)<>nil)
//            then
//            repeat
//            (FindComponent('SB'+Inttostr(Index)) as TRxSpeedButton).Visible:=false;
//            (FindComponent('IM'+Inttostr(Index)) as TImage).Visible:=false;
//            inc(index);
//            until ((FindComponent('SB'+Inttostr(Index)) as TRxSpeedButton)=nil);
//            self.tag:=1;
//           end;
//
//         2:begin
//            ShockwaveFlash1.Visible:= true;
//            index:=0;
//            if ((FindComponent('SB'+Inttostr(Index)) as TRxSpeedButton)<>nil)
//            then
//            repeat
//            (FindComponent('SB'+Inttostr(Index)) as TRxSpeedButton).Visible:=true;
//            (FindComponent('IM'+Inttostr(Index)) as TImage).Visible:=true;
//            inc(index);
//            until ((FindComponent('SB'+Inttostr(Index)) as TRxSpeedButton)=nil)
//           end ;
//      end;
//
//      if self.tag = 1 then
//      begin
//        ShockwaveFlash1.Visible:= false;
//        index:=0;
//        if ((FindComponent('SB'+Inttostr(Index)) as TRxSpeedButton)<>nil)
//        then
//        repeat
//        (FindComponent('SB'+Inttostr(Index)) as TRxSpeedButton).Visible:=false;
//        (FindComponent('IM'+Inttostr(Index)) as TImage).Visible:=false;
//        inc(index);
//        until ((FindComponent('SB'+Inttostr(Index)) as TRxSpeedButton)=nil);
//        self.tag:=1;
//      end
//      else
//      begin
//        index:=0;
//        if ((FindComponent('SB'+Inttostr(Index)) as TRxSpeedButton)<>nil)
//        then
//        repeat
//        (FindComponent('SB'+Inttostr(Index)) as TRxSpeedButton).Visible:=true;
//        (FindComponent('IM'+Inttostr(Index)) as TImage).Visible:=true;
//        inc(index);
//        until ((FindComponent('SB'+Inttostr(Index)) as TRxSpeedButton)=nil)
//      end;
//

