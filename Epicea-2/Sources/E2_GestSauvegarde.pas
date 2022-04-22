unit E2_GestSauvegarde;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  FileUtil,
  LibZoneSaisie,
  E2_Librairie_Obj,
  E2_Decl_Records,
  Lib_Chaine,
  Gr_MultDos,
  LibSQL,
  LibFichRep,
  Gr_Librairie_Obj,
  LibDates,
  ShellAPI,
  Umail,
  LibRessourceString,
  StdCtrls, Grids, ValEdit, ComCtrls, ExtCtrls, Buttons, Menus,
  DialogEx,
  E2_Proprietes, RXCtrls;

const

 VLERepDuDossier = 'Répertoire du Dossier';
 VLERepDeSauvegarde = 'Répertoire de Sauvegarde';
 VLERepDblSauvegarde = 'Répertoire de la double Sauvegarde';
 VLEAdresseMail = 'Adresse E-Mail de votre destinataire';
 VLETexteSauvegarde = 'Texte à ajouter au nom de la sauvegarde';
 VLENbrDeSauvegarde = 'Nombre de sauvegarde à conserver';
 NbMaxListeAffiche = 12;

 C_Validate:TSysCharSet=[#45,#95, #48..#57, #65..#90, #97..#122,#8];

type
  TGestSauvegarde = class(TForm)
    PaListe: TPanel;
    ListeSauvegarde: TListView;
    Panel1: TPanel;
    PaLeft: TPanel;
    BtnSauver: TButton;
    BtnSauveEtMail: TButton;
    PaResult: TPanel;
    LaChoix: TLabel;
    VLECHoixUtil: TValueListEditor;
    BtnDblSauver: TButton;
    BtnPurge: TButton;
    PopupMenu1: TPopupMenu;
    Renommerlasauvegarde1: TMenuItem;
    Listedessauvegardes1: TMenuItem;
    EnvoieFTP1: TMenuItem;
    RinitialiserlesparamtreFTP1: TMenuItem;
    Raffrachir1: TMenuItem;
    BtnRaffraichir: TButton;
    ChDossierTransmis: TCheckBox;
    RxSBInfoVersion: TRxSpeedButton;
    EnvoieFichierlogparEmail1: TMenuItem;
    Ouvrirlefichierdelog1: TMenuItem;
    ransfererlefichierdelogdansdossier1: TMenuItem;
    procedure BtnSauverClick(Sender: TObject);
    procedure BtnSauveEtMailClick(Sender: TObject);
    procedure VLECHoixUtilEditButtonClick(Sender: TObject);
    procedure VLECHoixUtilKeyPress(Sender: TObject; var Key: Char);
    procedure VLECHoixUtilKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    function AffecteDoubleSauvegarde(Verif:Boolean):boolean;
    Procedure InitListView;
    procedure BtnPurgeClick(Sender: TObject);
    procedure BtnDblSauverClick(Sender: TObject);
    procedure VLECHoixUtilValidate(Sender: TObject; ACol, ARow: Integer;
      const KeyName, KeyValue: String);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Listedessauvegardes1Click(Sender: TObject);
    procedure Renommerlasauvegarde1Click(Sender: TObject);
    procedure ListeSauvegardeColumnClick(Sender: TObject;
      Column: TListColumn);
    procedure ListeSauvegardeCompare(Sender: TObject; Item1,
      Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure EnvoieFTP1Click(Sender: TObject);
    procedure RinitialiserlesparamtreFTP1Click(Sender: TObject);
    procedure Raffrachir1Click(Sender: TObject);

    procedure initCaptionBtnRaffraichir(Visible:boolean);
    procedure BtnRaffraichirClick(Sender: TObject);
    procedure ChDossierTransmisClick(Sender: TObject);
    procedure RxSBInfoVersionClick(Sender: TObject);
    function ValidateInput(Key: Char):boolean;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EnvoieFichierlogparEmail1Click(Sender: TObject);
    procedure ransfererlefichierdelogdansdossier1Click(Sender: TObject);
    procedure Ouvrirlefichierdelog1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
       TabStr,TabCurr,TabDate : set of Byte;
    { Déclarations publiques }
  end;

var
  GestSauvegarde: TGestSauvegarde;
    OrdreTri:integer;


  Function GestSauvegardeAffiche(Affichage:boolean;Type_Liste:integer):boolean;

implementation

uses DMBaseDonnee, E2_Main, E2_AutreDossier, DMMessagesLGR
//,LibConvertisseur
, E2_Logo,
  AideMontant2, Lib1, DMConstantes, DiversProjets, UniteCorrection,
  E2_GestionSauvegarde;

{$R *.dfm}

function CustomSortDateProcAsc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
result := 0;
if StrToDate(TListItem(Item1).SubItems.Strings[ParamSort]) < StrToDate(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=-1;
if StrToDate(TListItem(Item1).SubItems.Strings[ParamSort]) > StrToDate(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=1;
end;

function CustomSortDateProcDesc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
result := 0;
if StrToDate(TListItem(Item1).SubItems.Strings[ParamSort]) < StrToDate(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=-1;
if StrToDate(TListItem(Item1).SubItems.Strings[ParamSort]) > StrToDate(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=1;
result:=-result;
end;

Function GestSauvegardeAffiche(Affichage:boolean;Type_Liste:integer):boolean;
var
cheminFichierTemp:string;
Begin
result:=true;
 if Affichage then
  begin
    if not (e.TypeDossier in [VerDemoAgri,VerDemoDioc,VerDemoGeneral]) then
      begin
         try
         try
           result:=DetruitTouteForm([main,
                       Logo,
                       GestSauvegarde]);
           if result then
           begin
           //supprimer le fichier Locked
                cheminFichierTemp:=IncludeTrailingPathDelimiter(e.RepertoireDossier)+fileLocked;
                if(FileExists(cheminFichierTemp))then
                begin
                   DeleteFile(pchar(cheminFichierTemp));
                end;
            if GestSauvegarde = nil then
                GestSauvegarde := TGestSauvegarde.Create(Application.MainForm);
                GestSauvegarde.ChDossierTransmis.OnClick:=nil;
                GestSauvegarde.ChDossierTransmis.Checked :=FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileNameEnCoursTraitementComptable);
                GestSauvegarde.ChDossierTransmis.OnClick:=GestSauvegarde.ChDossierTransmisClick;
                GestSauvegarde.VLECHoixUtil.ItemProps[VLERepDblSauvegarde].EditStyle := (esEllipsis);
                if str_fini_par(E.RepertoireDossier,'\') then
                    GestSauvegarde.VLECHoixUtil.Values[VLERepDuDossier]:=str_Suppr_N_Car_ADroite(E.RepertoireDossier,1)
                    else
                GestSauvegarde.VLECHoixUtil.Values[VLERepDuDossier] := E.RepertoireDossier;
                GestSauvegarde.VLECHoixUtil.Values[VLERepDeSauvegarde] := ParamUtil.RepertoireSauvegarde+E.NomDossier;
                GestSauvegarde.VLECHoixUtil.Values[VLERepDblSauvegarde] := E.RepertoireDblSauvegarde;
                GestSauvegarde.VLECHoixUtil.Values[VLETexteSauvegarde]:= E.NomSauvegarde;

                GestSauvegarde.ChDossierTransmis.Caption := 'Dossier transmis '+#13+'au comptable';
                GestSauvegarde.VLECHoixUtil.Values[VLENbrDeSauvegarde] :='3';
                OrdreTri:=1;
                GestSauvegarde.InitListView;
                result:=GestSauvegarde.ShowModal=mrOk;
           end;
         except
           result:=false;
         end;
         Finally
          OuvreExercice(E.NomDossier,E.NomExo,Main.Gauge1,false);
          Main.InitMain(Type_version_execution);
          GestSauvegarde.Free;
      //      DMBD.OpenAllTAble;
         end;
      end
    else showmessage('Vous êtes sur le dossier Démo');
  end;
End;


procedure TGestSauvegarde.BtnSauverClick(Sender: TObject);
var
verrou:boolean;
texte:string;
begin
texte:='-'+VLECHoixUtil.Values[VLETexteSauvegarde];
if texte='-' then texte:='';
if (ChDossierTransmis.Checked) and (not FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileNameEnCoursTraitementComptable))then
   texte:='-Sauvegarde-Envoyée-Au-Comptable';
    if FermerDossier(E) then
//    if true then
      begin
      verrou:=ChDossierTransmis.Checked and FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileNameEnCoursTraitementComptable);
      if not verrou then verrou := ChDossierTransmis.Checked;
        if SauveDossier(nil,'','',texte,verrou) then
         InitListView;
      end
    else
     begin
      Dialogs.MessageDlg('Une erreur s''est produite lors de la fermeture du dossier.', Dialogs.mtError, [Dialogs.mbOK], 0);
     end;
end;

procedure TGestSauvegarde.BtnSauveEtMailClick(Sender: TObject);
var
texte:string;
begin
texte:='-'+VLECHoixUtil.Values[VLETexteSauvegarde];
if texte='-' then texte:='';
if (ChDossierTransmis.Checked) and (not FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileNameEnCoursTraitementComptable))then
  texte:='-Sauvegarde-Envoyée-Au-Comptable';
if empty(VLECHoixUtil.Values[VLEAdresseMail])then
begin
  MessageDlg('Indiquez une adresse Email valide pour l''envoi de votre dossier.', Dialogs.mtError, [Dialogs.mbOK], 0);
  exit;
end;
    if FermerDossier(E) then
      begin
        if SauveDossier(nil,'',VLECHoixUtil.Values[VLEAdresseMail],texte,ChDossierTransmis.Checked) then
         InitListView;
      end
    else
     begin
      MessageDlg('Une erreur s''est produite lors de la fermeture du dossier.', Dialogs.mtError, [Dialogs.mbOK], 0);
     end;

end;

procedure TGestSauvegarde.VLECHoixUtilEditButtonClick(Sender: TObject);
begin
  AffecteDoubleSauvegarde(False);
end;

procedure TGestSauvegarde.VLECHoixUtilKeyPress(Sender: TObject;
  var Key: Char);
begin
if VLECHoixUtil.Row in [0..2] then key:=#0;

if(VLECHoixUtil.Cells[0,VLECHoixUtil.row]=VLETexteSauvegarde)then
    if(not ValidateInput(key))then key:=#0;

end;
function TGestSauvegarde.ValidateInput(Key: Char):boolean;
begin
 If not(Key in C_Validate) Then
  Begin
    result:=false;
  end;
end;


procedure TGestSauvegarde.VLECHoixUtilKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
if VLECHoixUtil.Row in [0..2] then
 if not (key in [VK_DOWN,VK_UP,VK_ESCAPE]) then
    key:=0;
if ((VLECHoixUtil.Row = 3) and (key = VK_F1)) then
 begin
  AffecteDoubleSauvegarde(false);
 end;
end;

function TGestSauvegarde.AffecteDoubleSauvegarde(Verif:Boolean):boolean;
var
RepDblSauv:String;
Accept,test:Boolean;
Mess:String;
Begin
try
result:=true;
  Mess:='Indiquez un répertoire pour la double sauvegarde.';

  if Verif then
   begin
   if not str_empty(VLECHoixUtil.Values[VLERepDblSauvegarde]) then
    begin
     test:=DirectoryExists(VLECHoixUtil.Values[VLERepDblSauvegarde]);
     if test then test:=str_commence_par(UpperCase(IncludeTrailingPathDelimiter(VLECHoixUtil.Values[VLERepDblSauvegarde])),UpperCase(IncludeTrailingPathDelimiter(E.RepertoireDossier)))=false;
     if ((GetDriveType(PChar(ExtractFileDrive(RepDblSauv)+'\')) in [0,1,DRIVE_CDROM]) or (not test)) then
       begin
       MessageDlg('Le nom du répertoire  pour la double sauvegarde '+#13+#10+'n''est pas valide !', Dialogs.mtError, [Dialogs.mbOK], 0);
       result:=false;
       end
       else
       begin
         E.RepertoireDblSauvegarde:=GestSauvegarde.VLECHoixUtil.Values[VLERepDblSauvegarde];
         exit;
       end;
     end
     else
     begin
       MessageDlg(Mess, Dialogs.mtError, [Dialogs.mbOK], 0);
       result:=false;
     end;
     if not result then exit;
   end;
  Mess:='Indiquez un répertoire.'+
        RetourChariotSimple+
        'Si vous choisissez un lecteur de disquette ou zip,'+
        RetourChariotSimple+
        'Veillez à ce que la disquette soit insérée dans le lecteur.';
  RepDblSauv:=VLECHoixUtil.Values[VLERepDblSauvegarde];
  Accept:=BrowseDirectory(RepDblSauv,Mess,0);
  //ne pas accepter le répertoire du dossier ou un des ses petits
  Accept:= str_commence_par(UpperCase(IncludeTrailingPathDelimiter(RepDblSauv)),UpperCase(IncludeTrailingPathDelimiter(E.RepertoireDossier)))=false;
//  VLECHoixUtil.Values[VLERepDblSauvegarde] := RepDblSauv;
//  showmessage(RepDblSauv);
  if accept and (GetDriveType(PChar(ExtractFileDrive(RepDblSauv)+'\')) in [0,1,DRIVE_CDROM]) then
   begin
      Showmessage('Répertoire ou lecteur non valide');
   end;
  while accept and ((GetDriveType(PChar(ExtractFileDrive(RepDblSauv)+'\')) in [0,1,DRIVE_CDROM])) do
   begin
     Accept:=BrowseDirectory(RepDblSauv,Mess,0);

    if accept and not (GetDriveType(PChar(ExtractFileDrive(RepDblSauv)+'\')) in [0,1,DRIVE_CDROM]) then
     begin
       VLECHoixUtil.Values[VLERepDblSauvegarde] := IncludeTrailingPathDelimiter(RepDblSauv);
     end;

    if accept and (GetDriveType(PChar(ExtractFileDrive(RepDblSauv)+'\')) in [0,1,DRIVE_CDROM]) then
     begin
        Showmessage('Répertoire ou lecteur non valide');
     end;
   end;
  if accept and not (GetDriveType(PChar(ExtractFileDrive(RepDblSauv)+'\')) in [0,1,DRIVE_CDROM]) then
   begin
       VLECHoixUtil.Values[VLERepDblSauvegarde] := IncludeTrailingPathDelimiter(RepDblSauv);
   end;

if not str_empty(VLECHoixUtil.Values[VLERepDblSauvegarde]) then
 begin
    if not (GetDriveType(PChar(ExtractFileDrive(VLECHoixUtil.Values[VLERepDblSauvegarde])+'\')) in [0,1,DRIVE_CDROM]) then
     begin
      VLECHoixUtil.Values[VLERepDblSauvegarde]:=IncludeTrailingPathDelimiter(VLECHoixUtil.Values[VLERepDblSauvegarde]);
//      if not str_fini_par(ExtractFileDrive(VLECHoixUtil.Values[VLERepDblSauvegarde]),'\') then
//          VLECHoixUtil.Values[VLERepDblSauvegarde]:=ExtractFileDrive(VLECHoixUtil.Values[VLERepDblSauvegarde])+'\';
     end
    else
    begin
     VLECHoixUtil.Values[VLERepDblSauvegarde] :='';
    end;

    if not DirectoryExists(VLECHoixUtil.Values[VLERepDblSauvegarde]) then
     VLECHoixUtil.Values[VLERepDblSauvegarde] :='';

    if VLECHoixUtil.Values[VLERepDblSauvegarde] = '\' then
     VLECHoixUtil.Values[VLERepDblSauvegarde] :='';
 end;
E.RepertoireDblSauvegarde:=GestSauvegarde.VLECHoixUtil.Values[VLERepDblSauvegarde];
except
result:=false;
end;
End;



Procedure TGestSauvegarde.InitListView;
var
ListeFichier,ListeExtension:TStringList;
i,j:Integer;
dateTmp:Tdatetime;
Texte,Date_,Heure_:String;
F:TSearchRec;
Begin
try//finally
ListeFichier:=TStringList.Create;
ListeFichier.Clear;
ListeExtension:=TStringList.Create;
ListeExtension.Add('*.zlg');
ListeFichier:=ListeFic(ListeExtension,ParamUtil.RepertoireSauvegarde+E.NomDossier+'\',faAnyFile,false,False);
//AjouterFichierTexte(E2_Librairie_Obj.E.RepertoireProgram+'Error.txt','Avant ListeSauvegarde.Invalidate');
ListeSauvegarde.Invalidate;
//AjouterFichierTexte(E2_Librairie_Obj.E.RepertoireProgram+'Error.txt','Après ListeSauvegarde.Invalidate');
ListeSauvegarde.Items.Clear;
TabDate:=[1];
for i:=0 to ListeFichier.Count-1 do
 begin
   Texte:= ListeFichier.Strings[i];
   delete(Texte,1,length(E.NomDossier));
   Date_:=copy(Texte,1,8);
   delete(Texte,1,9);
   Date_:=Str_String_To_DateString(Date_);
   Heure_:=copy(Texte,1,6);
   Heure_:=Str_String_To_HeureString(Heure_,' h ',' mn ',' s ');
   ListeFichier.Strings[i]:=Date_+';'+Heure_+';'+ListeFichier.Strings[i]+';';
 end;
ordretri:=1;
InitLisViewAvecListe(ListeSauvegarde,['Date','Heure','Nom fichier'],ListeFichier,true).free;
ListeSauvegardeColumnClick(ListeSauvegarde,ListeSauvegarde.Column[2]);
ordretri:=1;
ListeSauvegardeColumnClick(ListeSauvegarde,ListeSauvegarde.Column[1]);
ListeSauvegarde.Repaint;
finally
  Initialise_TStringlist(ListeFichier,self,true);
  Initialise_TStringlist(ListeExtension,self,true);
end;
End;

procedure TGestSauvegarde.BtnDblSauverClick(Sender: TObject);
var
texte:string;
begin
texte:='-'+VLECHoixUtil.Values[VLETexteSauvegarde];
if texte='-' then texte:='';
if (ChDossierTransmis.Checked) and (not FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileNameEnCoursTraitementComptable))then
  texte:='-Sauvegarde-Envoyée-Au-Comptable';
if AffecteDoubleSauvegarde(true)then
  begin
  //if MessageDlg('Vous n''avez pas indiqué de répertoire ou'+#13+#10+'de lecteur valide pour la double sauvegarde.'+#13+#10+'Voulez-vous continuer ?', mtConfirmation, [mbYes,mbNo], 0) = mrNo then
  //  abort;
      if FermerDossier(E) then
        begin
          if SauveDossier(nil,VLECHoixUtil.Values[VLERepDblSauvegarde],'',texte,ChDossierTransmis.Checked) then
           InitListView;
        end
      else
       begin
        MessageDlg('Une erreur s''est produite lors de la fermeture du dossier.', Dialogs.mtError, [Dialogs.mbOK], 0);
       end;
  end;
end;


procedure TGestSauvegarde.BtnPurgeClick(Sender: TObject);
var
i,nbreste:integer;
ListeFichier:TStringList;
MessListeSuppresion,FinMessage:String;
begin
try//finally
MessListeSuppresion:='';
nbreste:=ListeSauvegarde.Items.Count;
//if MessageDlg('ATTENTION'+#13+#10+'Vous êtes sur le point de supprimer des sauvegardes !'+#13+#10+''+#13+#10+'Êtes-vous sûr de vouloir les supprimer définitivement ?', mtWarning, [mbYes,mbNo], 0) = mrYes then
// begin
  ListeFichier:=TStringList.Create;
  for i:=0 to ListeSauvegarde.Items.Count-1 do
   begin
    if ListeSauvegarde.Items[i].Checked then
     begin
      ListeFichier.Add(ParamUtil.RepertoireSauvegarde+'\'+E.NomDossier+'\'+ListeSauvegarde.Items[i].SubItems.Strings[2]);
      if ListeFichier.Count <= NbMaxListeAffiche then
      MessListeSuppresion:=MessListeSuppresion+' - '+ListeSauvegarde.Items[i].SubItems.Strings[2]+RetourChariotDouble;
      dec(nbreste);
      if nbReste < StrToInt(VLECHoixUtil.Values[VLENbrDeSauvegarde]) then
       begin
        MessageDlg('Opération annulée !'+#13+#10+'Le nombre de sauvegarde à conserver'+#13+#10+'n''est pas respecté !', Dialogs.mtWarning, [Dialogs.mbOK], 0);
        abort;
       end;
     end;
   end;
  FinMessage := '';
  if  ListeFichier.Count > NbMaxListeAffiche then
   FinMessage := '+'+Str_SingulierToPluriel(ListeFichier.Count-NbMaxListeAffiche,'sauvegarde')+'...';
  if nbreste=ListeSauvegarde.Items.Count then
   begin
     MessageDlg('Vous devez cocher les sauvegardes '+#13+#10+'que vous voulez supprimer !', Dialogs.mtConfirmation, [Dialogs.mbOK], 0);
     abort;
   end;

 if MessageDlg('                       ATTENTION'+
               RetourChariotDouble+
               'Vous êtes sur le point de supprimer '+
               Str_SingulierToPluriel(ListeFichier.Count,'sauvegarde')+
               '!'+
               RetourChariotDouble+'Êtes-vous sûr de vouloir supprimer définitivement : '+
               RetourChariotDouble+
               MessListeSuppresion+
               FinMessage
               , Dialogs.mtConfirmation, [Dialogs.mbYes,Dialogs.mbNo], 0) = mrYes then
 begin
  DeleteListFile(ListeFichier);
  InitListView;
 end;
finally
Initialise_TStringlist(ListeFichier,self,true);
end;
end;

procedure TGestSauvegarde.VLECHoixUtilValidate(Sender: TObject; ACol,
  ARow: Integer; const KeyName, KeyValue: String);
begin
 VLECHoixUtil.Values[VLENbrDeSauvegarde]:=Str_QueDesChiffre_Integer(VLECHoixUtil.Values[VLENbrDeSauvegarde]);
 if VerifNumeric(VLECHoixUtil.Values[VLENbrDeSauvegarde]).Vide then
   VLECHoixUtil.Values[VLENbrDeSauvegarde]:='0';

 if (VLECHoixUtil.Row=3)then
 begin
 if(not str_empty(VLECHoixUtil.Values[VLERepDblSauvegarde]))  then
   AffecteDoubleSauvegarde(true)
   else E.RepertoireDblSauvegarde:='';
end;
end;

procedure TGestSauvegarde.FormDestroy(Sender: TObject);
begin
GestSauvegarde := nil;
end;

procedure TGestSauvegarde.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
WinSuivPrec(Handle,key,[ListeSauvegarde]);
  if Key = VK_ESCAPE then
   begin
      Key:= 0;
      Self.Close;
   end;

end;

procedure TGestSauvegarde.Listedessauvegardes1Click(Sender: TObject);
begin
ShellExecute(handle, 'explore', Pchar(ParamUtil.RepertoireSauvegarde+E.NomDossier+'\'), NiL, NiL, SW_SHOWNORMAL);
initCaptionBtnRaffraichir(BtnRaffraichir.Visible);
end;

procedure TGestSauvegarde.Renommerlasauvegarde1Click(Sender: TObject);
var
NomFichierTmp,NomFichier:String;
extension:string;
begin
if ((ListeSauvegarde.Selected<>nil)and(activeControl=ListeSauvegarde)) then
  Begin
    if ListeSauvegarde.Selected.SubItems<>nil then
      Begin
          NomFichierTmp:=ListeSauvegarde.Selected.SubItems.Strings[2];
          if FileExists(ParamUtil.RepertoireSauvegarde+E.NomDossier+'\'+NomFichierTmp)then
            begin
//                NomFichier:=str_getstringelement(NomFichierTmp,1,'.')+'_';
                NomFichier:=str_getstringelement(NomFichierTmp,1,'.');
                if ((InputQuery('Renommer la sauvegarde','Ex: '+NomFichier+'_AvantClôture',NomFichier))and (NomFichier<>'')) then
                  Begin
                    extension:=ExtractFileExt(NomFichier);
                    if extension='' then NomFichier:=NomFichier+'.Zlg';
                    if AnsiCompareFileName(NomFichierTmp,NomFichier)<>0 then
                      begin
                      if messagedlg_lgr('Etes-vous sûr de vouloir renommer la sauvegarde : '+RetourChariotDouble+
                                        NomFichierTmp+RetourChariotSimple+
                                        '------------------------------------------------------------------------------------------------------------'+ RetourChariotSimple+
                                        'par : '+NomFichier+RetourChariotSimple,
                                        Dialogs.mtConfirmation,[Dialogs.mbYes,Dialogs.mbNo])=mryes then
                                        begin
                                           RenameFile(ParamUtil.RepertoireSauvegarde+E.NomDossier+'\'+NomFichierTmp,ParamUtil.RepertoireSauvegarde+E.NomDossier+'\'+NomFichier);
                                           initCaptionBtnRaffraichir(true);
                                        end;
                      end;
                  end;
            end;
      end;
  end;
end;

procedure TGestSauvegarde.ListeSauvegardeColumnClick(Sender: TObject;
  Column: TListColumn);
begin
OrdreTri:=-OrdreTri;
if Column.Index in TabDate  then
begin
if OrdreTri > 0 then
  begin
    if Column.Index > 0 then
     ListeSauvegarde.CustomSort(@CustomSortDateProcAsc, Column.Index-1)
    else
     ListeSauvegarde.CustomSort(@CustomSortDateProcAsc, Column.Index)
  end
else
  begin
     if Column.Index > 0 then
        ListeSauvegarde.CustomSort(@CustomSortDateProcDesc, Column.Index-1)
        else
        ListeSauvegarde.CustomSort(@CustomSortDateProcDesc, Column.Index)
  end
end
else
  Begin
    if Column.Index > 0 then
      ListeSauvegarde.CustomSort(nil, Column.Index-1)
    else
      ListeSauvegarde.CustomSort(nil, Column.Index)
  end;
end;

procedure TGestSauvegarde.ListeSauvegardeCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
if DAta >= 0 then
compare:=OrdreTri*StrComp(PChar(Item1.SubItems.Strings[Data]),PChar(Item2.SubItems.Strings[Data]))
else
compare:=OrdreTri*StrComp(PChar(TListItem(Item1).Caption),PChar(TListItem(Item2).Caption));

end;

procedure TGestSauvegarde.EnvoieFTP1Click(Sender: TObject);
var
FichierSource,RepDest:string;
//fichierParam:TextFile;
Param:string;
continuer:integer;
 db_FTP,db_Email : TMsgDlgParams;
  MessageLGR_FTP,MessageLGR_Email:TMessageLGR;
//  AfficherCheck:boolean;
begin
try//finally
try//except

db_FTP:=initMessageLGR(self,'','EnvoieFTP','Votre adresse FTP va être vidée avant l''envoi de cette sauvegarde ',
      'Suppression avant envoie',[mbCust1,mbcancel],mbCust1,MessageLGR_FTP);
db_FTP.CustBtnText[mbCust1] := 'Continuer';

continuer:=-1;
if LitFichierParamFTP(e.ParamFTP.Fichier,e.ParamFTP,true,e.NomDossier,DM_C_ServeurFTP,e.ParamFTP,e.RepertoireDossier)then
  begin
  if EssaiConnection then
      begin
      RepDest:='/sauvegarde_epicea/'+e.NomDossier;
          if ((ListeSauvegarde.Selected<>nil)and(activeControl=ListeSauvegarde)) then
            Begin
              if ListeSauvegarde.Selected.SubItems<>nil then
                Begin
                    FichierSource:=IncludeTrailingPathDelimiter(ParamUtil.RepertoireSauvegarde+E.NomDossier)+ListeSauvegarde.Selected.SubItems.Strings[2];
                    if FileExists(FichierSource)then
                      begin
                          if uppercase(e.ParamFTP.Effacer)='O' then
                              if MessageLGR_FTP.Afficher then
                                continuer:=MsgDlgBox(db_FTP)
                              else continuer:=MAKELong(mrCust1,1);
                               if db_FTP.CheckBox then
                                 begin
                                   MessageLGR_FTP.Afficher:=not StrToBool_Lgr(IntToStr(hiWord(continuer)),true);
                                   DM_EcritMessageLGR(MessageLGR_FTP);
                                 end;

                          case LoWord(continuer) of
                           mrCust1: begin
                                e.ParamFTP.Source:=FichierSource;
                                //e.ParamFTP.Dest:='/';
                                EcritFichierParamFTP(e.ParamFTP,e.ParamFTP);
                                if not empty(VLECHoixUtil.Values[VLEAdresseMail])then
                                begin
                                    db_Email:=initMessageLGR(self,'','EnvoieEmailFTP2','Voulez-vous envoyer un Email au '+
                                      'destinataire de la sauvegarde','Envoie d''un Email',[mbYes,mbNo],mbYes,MessageLGR_Email);
                                    continuer:=MAKELong(0,1);
                                    if(MessageLGR_Email.Afficher)then
                                         continuer:=MsgDlgBox(db_Email);
                                      if (LoWord(continuer)=mryes) then
                                         begin
                                         SendMail('Maintenance Epicéa-2 - '+E.NomDossier,
                                                'Envoi de mon dossier : '+E.NomDossier+', "par FTP, sur le compte : '+e.ParamFTP.Login+'", pour le programme Epicéa-2 Win '+retourchariotsimple+
                                                'Nom de la sauvegarde : '+ExtractFileName(e.ParamFTP.Source),
                                                '',
                                                '',
                                                '',
                                                '',
                                                VLECHoixUtil.Values[VLEAdresseMail]);
                                        end;
                               if db_Email.CheckBox then
                                 begin
                                   MessageLGR_Email.Afficher:=not StrToBool_Lgr(IntToStr(hiWord(continuer)),true);
                                   DM_EcritMessageLGR(MessageLGR_Email);
                                 end;

                                end;

                                ShellExecute(handle,nil,'envoi_ftp.exe',PChar('"'+e.ParamFTP.Fichier+'" a'),
                                       PChar(ExcludeTrailingPathDelimiter(e.RepertoireProgram)),SW_SHOW);
                                //demander si on veut envoyer un email

                            end;
                            mrCust2:
                            begin
                                Main.Proprits1Click(GestSauvegarde);
                            end;
                          end;//fin du case
                      end; //
                end;
            end
          else Application.MessageBox(Pchar('Vous devez sélectionner une sauvegarde !!!'),'Attention',MB_ICONWARNING);
      end;//fin test connection
  end
else if Application.MessageBox(Pchar('Voulez-vous règler vos paramètres de connexion ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
    Main.Proprits1Click(GestSauvegarde);
except
  //ShowMessage('problème d''exécution');
end;
finally
//
end;
end;

procedure TGestSauvegarde.RinitialiserlesparamtreFTP1Click(
  Sender: TObject);
begin
//Afficher une fenêtre pour saisir les paramètres FTP
Main.Proprits1Click(GestSauvegarde);
end;

procedure TGestSauvegarde.Raffrachir1Click(Sender: TObject);
begin
initCaptionBtnRaffraichir(true);
end;


procedure TGestSauvegarde.initCaptionBtnRaffraichir(Visible:boolean);
begin
  if Visible then
      begin
          InitListView;
          ListeSauvegarde.SetFocus;
          BtnRaffraichir.Visible:=false;
      end
  else
      begin
          BtnRaffraichir.Visible:=true;
          BtnRaffraichir.Font.Color:=clred;
      end;
end;
procedure TGestSauvegarde.BtnRaffraichirClick(Sender: TObject);
begin
initCaptionBtnRaffraichir(true);
end;



procedure TGestSauvegarde.ChDossierTransmisClick(Sender: TObject);
begin
if ChDossierTransmis.Checked then
  GestSauvegarde.VLECHoixUtil.Values[VLETexteSauvegarde]:='-Sauvegarde-Envoyée-Au-Comptable';

if(ChDossierTransmis.Checked=false )then
  if Application.MessageBox(Pchar('Si vous décochez cette case, le programme considère que vous avez récupèré votre dossier'+
     RetourChariotSimple+'Et par conséquent, que vous pouvez désormais le modifier.'+RetourChariotDouble+
     'Si c''est bien le cas, cliquez sur "Oui", sinon cliquez sur "Non"'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno then
    ChDossierTransmis.Checked:=true;
if(ChDossierTransmis.Checked=false)and(FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileNameEnCoursTraitementComptable))then
    DeleteFile(Pchar(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileNameEnCoursTraitementComptable));
end;

procedure TGestSauvegarde.RxSBInfoVersionClick(Sender: TObject);
begin
Showmessage(ChDossierTransmis.Hint);
end;

procedure TGestSauvegarde.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
//VLECHoixUtilValidate(VLECHoixUtil,VLECHoixUtil.Col,VLECHoixUtil.Row,'','');
end;

procedure TGestSauvegarde.EnvoieFichierlogparEmail1Click(Sender: TObject);
begin
if (FileExists(IncludeTrailingPathDelimiter(E.RepertoireProgram)+'Error.TXT'))then
  begin
   SendMail('Rapport de log des restaurations',
            'Saisissez ici vos commentaires : ',
            IncludeTrailingPathDelimiter(e.RepertoireProgram)+'RestaurationSuivi.txt',
            E.NomDossier,
            '',
            '',
            'support@legrain.fr');
//   SendMail2('Rapport de log des restaurations',
//            'Saisissez ici vos commentaires : ',
//            '',
//            '',
//            '',
//            'support@legrain.fr',
//            [IncludeTrailingPathDelimiter(e.RepertoireProgram)+'RestaurationSuivi.txt'],0);
  end;


end;

procedure TGestSauvegarde.ransfererlefichierdelogdansdossier1Click(
  Sender: TObject);
begin
CopyFile(PChar(E.RepertoireProgram+'RestaurationSuivi.txt'),PChar(E.RepertoireDossier+'RestaurationSuivi.txt'),nil);
end;

procedure TGestSauvegarde.Ouvrirlefichierdelog1Click(Sender: TObject);
begin
ShellExecute(Handle, 'open', PChar(E.RepertoireProgram+'RestaurationSuivi.txt'), nil, nil, SW_SHOWNORMAL);
end;

end.
