unit E2_GestionSauvegarde;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  Gr_Librairie_Obj,
  E2_Librairie_Obj,
  ComCtrls,
  Lib_Chaine,
  LibRessourceString,
  E2_Decl_Records,
  shellApi,
  LibSQL,
  LibZoneSaisie,
  LibDates,
  ExtCtrls,
  FRAssistant1,
  Grids,
  Gr_Multdos,
  DMProgramme,
  LibFichRep,
  ValEdit,
  E2_Patientez,
  ZipMstr,
  registry,
  Clipbrd ,
  Menus,
  UMail,
  E2_Proprietes;

const
  VER_NT_WORKSTATION    :Integer = 1;
  VER_SUITE_ENTERPRISE  :Integer = 2;
  VER_NT_SERVER         :Integer = 3;
  VER_SUITE_DATACENTER  :Integer = 128;
  VER_SUITE_PERSONAL    :Integer = 512;

  PRODUCT_BUSINESS                      = $00000006; {Business Edition}
  PRODUCT_BUSINESS_N                    = $00000010; {Business Edition}
  PRODUCT_CLUSTER_SERVER                = $00000012; {Cluster Server Edition}
  PRODUCT_DATACENTER_SERVER             = $00000008; {Server Datacenter Edition
(full installation)}
  PRODUCT_DATACENTER_SERVER_CORE        = $0000000C; {Server Datacenter Edition
(core installation)}
  PRODUCT_ENTERPRISE                    = $00000004; {Enterprise Edition}
  PRODUCT_ENTERPRISE_N                  = $0000001B; {Enterprise Edition}
  PRODUCT_ENTERPRISE_SERVER             = $0000000A; {Server Enterprise Edition
(full installation)}
  PRODUCT_ENTERPRISE_SERVER_CORE        = $0000000E; {Server Enterprise Edition
(core installation)}
  PRODUCT_ENTERPRISE_SERVER_IA64        = $0000000F; {Server Enterprise Edition
for Itanium-based Systems}
  PRODUCT_HOME_BASIC                    = $00000002; {Home Basic Edition}
  PRODUCT_HOME_BASIC_N                  = $00000005; {Home Basic Edition}
  PRODUCT_HOME_PREMIUM                  = $00000003; {Home Premium Edition}
  PRODUCT_HOME_PREMIUM_N                = $0000001A; {Home Premium Edition}
  PRODUCT_HOME_SERVER                   = $00000013; {Home Server Edition}
  PRODUCT_SERVER_FOR_SMALLBUSINESS      = $00000018; {Server for Small Business
Edition}
  PRODUCT_SMALLBUSINESS_SERVER          = $00000009; {Small Business Server}
  PRODUCT_SMALLBUSINESS_SERVER_PREMIUM  = $00000019; {Small Business Server
Premium Edition}
  PRODUCT_STANDARD_SERVER               = $00000007; {Server Standard Edition
(full installation)}
  PRODUCT_STANDARD_SERVER_CORE          = $0000000D; {Server Standard Edition
(core installation)}
  PRODUCT_STARTER                       = $0000000B; {Starter Edition}
  PRODUCT_STORAGE_ENTERPRISE_SERVER     = $00000017; {Storage Server Enterprise
Edition}
  PRODUCT_STORAGE_EXPRESS_SERVER        = $00000014; {Storage Server Express
Edition}
  PRODUCT_STORAGE_STANDARD_SERVER       = $00000015; {Storage Server Standard
Edition}
  PRODUCT_STORAGE_WORKGROUP_SERVER      = $00000016; {Storage Server Workgroup
Edition}
  PRODUCT_UNDEFINED                     = $00000000; {An unknown product}
  PRODUCT_ULTIMATE                      = $00000001; {Ultimate Edition}
  PRODUCT_ULTIMATE_N                    = $0000001C; {Ultimate Edition}
  PRODUCT_WEB_SERVER                    = $00000011; {Web Server Edition}
  PRODUCT_UNLICENSED                    = $ABCDABCD; {Unlicensed product}

 VLENomDuDossier = 'Nom du Dossier';
 VLENomFicARestaurer = 'Nom du fichier à restaurer';
 VLESauvegardeSecours = 'Faire une sauvegarde de secours';

 type

  _OSVERSIONINFOEX = record
    dwOSVersionInfoSize : DWORD;
    dwMajorVersion      : DWORD;
    dwMinorVersion      : DWORD;
    dwBuildNumber       : DWORD;
    dwPlatformId        : DWORD;
    szCSDVersion        : array[0..127] of AnsiChar;
    wServicePackMajor   : WORD;
    wServicePackMinor   : WORD;
    wSuiteMask          : WORD;
    wProductType        : BYTE;
    wReserved           : BYTE;
  end;

  TRetour=record
    VersionOs:string;
    retour:boolean;
  end;
  TOSVERSIONINFOEX = _OSVERSIONINFOEX;


  TGestionSauvegarde = class(TForm)
    Panel1: TPanel;
    PaListe: TPanel;
    ListeSauvegarde: TListView;
    FRAssistant1: TFRAssistant;
    PaResult: TPanel;
    LaChoix: TLabel;
    VLECHoixUtil: TValueListEditor;
    OpenDialog1: TOpenDialog;
    CBSauvegardeSecours: TCheckBox;
    BtnAutre: TButton;
    BtnFTP: TButton;
    PopupMenu1: TPopupMenu;
    Listedessauvegardes1: TMenuItem;
    RinitialiserlesparamtreFTP1: TMenuItem;
    Raffrachir1: TMenuItem;
    BtnRaffraichir: TButton;
    EnvoieFichierdelogdesrestaurations1: TMenuItem;
    procedure ListeSauvegardeDblClick(Sender: TObject);
    procedure ListeSauvegardeKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);overload;
    procedure ListeSauvegardeColumnClick(Sender: TObject;
      Column: TListColumn);
    procedure ListeSauvegardeCompare(Sender: TObject; Item1,
      Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure ListeSauvegardeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SauveListViewToFile(ListeSauvegarde: TListView;NomFichier,Separateur:string;Min,Max:Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    Function  ShowModal(Type_Liste:Integer):integer;overload;
    procedure Etape0Click(Sender: TObject);
    procedure Etape1Click(Sender: TObject);
    procedure Etape2Click(Sender: TObject);
    procedure Etape3Click(Sender: TObject);
    procedure EtapeFinClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    Function ChercherSauvegarde(RepertoireDossierSauvegarde:String):Boolean;
    Procedure InitCleVLE;
    Procedure InitViewList;
    procedure FRAssistant1BtnSuivantClick(Sender: TObject);
    procedure BtnAutreClick(Sender: TObject);
    procedure FRAssistant1BtnAnnulerClick(Sender: TObject);

    function ControleVersionSauvegarde(Sauvegarde:string):boolean;
    procedure BtnFTPClick(Sender: TObject);
    procedure Collerlasauvegarde1Click(Sender: TObject);
    procedure Listedessauvegardes1Click(Sender: TObject);
    procedure RinitialiserlesparamtreFTP1Click(Sender: TObject);
    procedure Raffrachir1Click(Sender: TObject);
    procedure initCaptionBtnRaffraichir(Visible:boolean);
    procedure BtnRaffraichirClick(Sender: TObject);

    function LancementProcess(exe,param : string):boolean;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EnvoieFichierdelogdesrestaurations1Click(Sender: TObject);
  private
    { Déclarations privées }
    Type_Liste:Integer;// N'utiliser que cette variable dans cet écran pour accéder au Type_Liste du dossier
    NomDossier:String; // N'utiliser que cette variable dans cet écran pour accéder au nom du dossier
                       // Est initialisé dans la proc d'affichage
    RepNomDossAutreDossier:String;
    NomDossAutreDossier:String;
    NomFicRestauration:String;
    NomFichierSauvegardeCherche:String;
  public
    { Déclarations publiques }
       TabStr,TabCurr,TabDate : set of Byte;
       ouvertureDossier:boolean;
       Procedure FormShow(Sender: TObject;Type_Liste:Integer);overload;

  end;
    function GetVersionExA(var lpVersionInformation: TOSVersionInfoEX): BOOL;
        stdcall; external kernel32;


var
{$EXTERNALSYM GetProductInfo}
  GetProductInfo: function (dwOSMajorVersion, dwOSMinorVersion,
                            dwSpMajorVersion, dwSpMinorVersion: DWORD;
                            var pdwReturnedProductType: DWORD): BOOL stdcall = NIL;

  GestionSauvegarde: TGestionSauvegarde;
  OrdreTri:integer;

//  clipBoard : TClipboard;
  Function GestionSauvegardeAffiche(Affichage:boolean;Type_Liste:integer):boolean;
  function GetOSInfo: TRetour;
function ShellExecuteAndWait(
                             vHandle     : HWND;
                             vOperation  : string;
                             vFichier    : string;
                             vParametres : string;
                             vRepertoire : string;
                             vAffichage  : Integer;
                             vDuree      : DWORD
                            ) : Cardinal;
implementation

uses DMRecherche, DMBaseDonnee,DialogEx,DMMessagesLGR, E2_Main,DMConstantes,
  DiversProjets, E2_AutreDossier, E2_Logo, AideMontant2, E2_GestSauvegarde,
  UniteCorrection, ImportDll, RestD3, ImportReleve;

{$R *.DFM}

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

Function GestionSauvegardeAffiche(Affichage:boolean;Type_Liste:integer):boolean;
var
ouvertureDossier:boolean;
Begin
//e.ControleDuDossier:=false;
ouvertureDossier:=true;
    if not (e.TypeDossier in [VerDemoAgri,VerDemoDioc,VerDemoGeneral]) then
      begin
        try
           result:=DetruitTouteForm([main,
                       Logo,
                       GestionSauvegarde]);
           if result then
           begin
                 if Affichage then
                  begin
                    if GestionSauvegarde = nil then
                        GestionSauvegarde := TGestionSauvegarde.Create(Application.MainForm);
                    GestionSauvegarde.ouvertureDossier:=true;
                    GestionSauvegarde.NomDossier := E.NomDossier;
                    GestionSauvegarde.InitCleVLE;
                    GestionSauvegarde.InitViewList;
                    if FermerDossier(E) then
                      GestionSauvegarde.ShowModal(Type_Liste)
                      else MessageDlg('GestionSauvegardeAffiche : Erreur à la fermeture du dossier en cours !', Dialogs.mtError, [Dialogs.mbOK], 0);
                    ouvertureDossier:=GestionSauvegarde.ouvertureDossier;
                    ControleDossierApresRestauration(E.NomDossier);
                    end;
           end;
        Finally
          LitGestDossierFichier(IncludeTrailingPathDelimiter(E.RepertoireDossier) + E.NomDossier+'.epi',E,False);
          if FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileName) then
            DeleteFile(Pchar(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileName));
          if FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileNameConfirme) then
            DeleteFile(Pchar(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileNameConfirme));

          if ouvertureDossier then
            Main.OuvreExo(E.NomDossier,E.NomExo);
        //  OuvreExercice(E.NomDossier,E.NomExo);
        //  DMBD.OpenAllTAble;
         GestionSauvegarde.Free;
        end;
      end
    else showmessage('Vous êtes sur le dossier Démo');
End;


procedure TGestionSauvegarde.FormShow(Sender: TObject;Type_Liste:Integer);
Begin
//inherited;
 try
  case Type_Liste of
     CT_DOSSIER_COURANT:
              Begin
               OrdreTri:=1;
               Etape0Click(FRAssistant1.BtnSuivant);
             End;
     CT_DOSSIER_AUTRE:
             Begin

             End;

     CT_DOSSIER_IMPORTE:Begin

                        End;

  end;

 finally
  case Type_Liste of
   CT_DOSSIER_COURANT:Begin

                      End;

   CT_DOSSIER_AUTRE:Begin

                    End;

   CT_DOSSIER_IMPORTE:Begin

                      End;
  end;
 end;
End;

Function TGestionSauvegarde.ShowModal(Type_Liste:Integer):integer;
Begin
self.Type_Liste := Type_Liste;
FormShow(self,Type_Liste);
//clipBoard:=TClipboard.Create;
case Type_Liste of
 CT_DOSSIER_COURANT:Begin
                      FRAssistant1.InitScenario([Etape0Click,
                                                 Etape1Click],
                                                 EtapeFinClick);
                    End;

 CT_DOSSIER_AUTRE:Begin
                      FRAssistant1.InitScenario([Etape0Click,
                                                 Etape1Click,
                                                 Etape2Click,
                                                 Etape3Click],
                                                 EtapeFinClick);
                  End;

 CT_DOSSIER_IMPORTE:Begin

                    End;
end;

//if not self.Visible then
self.ShowModal;
End;

procedure TGestionSauvegarde.Etape0Click(Sender: TObject);
var
//F: TextFile;
TExte,Date_,Heure_,tmp:String;
J:integer;
ListeDossier,ListeExtension:TStringList;
i:integer;
valeurSelected:string;
Begin
  case Type_Liste of
   CT_DOSSIER_COURANT:Begin
   valeurSelected:='';
                     if Str_empty(VLECHoixUtil.Values[VLENomFicARestaurer]) then
                      begin
                       if ListeSauvegarde.Selected <> nil then
                         begin
                             valeurSelected := ListeSauvegarde.Items[ListeSauvegarde.ItemFocused.Index].SubItems[2];
                         end;
                      end;
                        ListeDossier:=TStringList.Create;
                        ListeExtension:=TStringList.Create;
                        ListeDossier.Clear;
                        ListeExtension.Add('*.zlg');
                        ListeDossier:=ListeFic(ListeExtension,ParamUtil.RepertoireSauvegarde+E.NomDossier+'\',faAnyFile,false,False);
                        ListeSauvegarde.Invalidate;
                        ListeSauvegarde.Items.Clear;
                        ListeSauvegarde.Columns.Clear;
                        TabDate:=[1];
                        ListeSauvegarde.Columns.Add.Caption := '';
                        ListeSauvegarde.Columns[ListeSauvegarde.Columns.Count-1].MaxWidth:=1;
                        ListeSauvegarde.Columns[ListeSauvegarde.Columns.Count-1].MinWidth:=0;
                        ListeSauvegarde.Columns[ListeSauvegarde.Columns.Count-1].Width := 0;

                        ListeSauvegarde.Columns.Add.Caption := 'Date';
                        ListeSauvegarde.Columns[ListeSauvegarde.Columns.Count-1].Width := 100;

                        ListeSauvegarde.Columns.Add.Caption := 'Heure';
                        ListeSauvegarde.Columns[ListeSauvegarde.Columns.Count-1].Width := 100;

                        ListeSauvegarde.Columns.Add.Caption := 'Nom Fichier';
                        ListeSauvegarde.Columns[ListeSauvegarde.Columns.Count-1].Width := 350;

//                        ListeSauvegarde.Columns.Add.Caption := 'Sauvegardé depuis :';
//                        ListeSauvegarde.Columns[ListeSauvegarde.Columns.Count-1].Width := 120;
                        for i:=0 to ListeDossier.Count-1 do
                         begin
                           Texte:= ListeDossier.Strings[i];
                           delete(Texte,1,length(E.NomDossier));
                           Date_:=copy(Texte,1,8);
                           delete(Texte,1,9);
                           Date_:=Str_String_To_DateString(Date_);
                           Heure_:=copy(Texte,1,6);
                           Heure_:=Str_String_To_HeureString(Heure_,' h ',' mn ',' s ');
                           ListeDossier.Strings[i]:=Date_+';'+Heure_+';'+ListeDossier.Strings[i]+';';
//                           ListeSauvegarde.Items.Add;
//                           ListeSauvegarde.Items[ListeSauvegarde.Items.Count-1].Caption:=str_getstringelement(ListeDossier.Strings[i],2,'_');
//                           ListeSauvegarde.Items[ListeSauvegarde.Items.Count-1].SubItems.Add(Date_);
//                           ListeSauvegarde.Items[ListeSauvegarde.Items.Count-1].SubItems.Add(Heure_);
//                           ListeSauvegarde.Items[ListeSauvegarde.Items.Count-1].SubItems.Add(ListeDossier.Strings[i]);
                        //   ListeSauvegarde.Items[ListeSauvegarde.Items.Count-1].SubItems.Add(TempsEcoule(now-StrToDateTime(ListeSauvegarde.Items[ListeSauvegarde.Items.Count-1].SubItems[0]+' '+ListeSauvegarde.Items[ListeSauvegarde.Items.Count-1].SubItems[1])));
                         end;
InitLisViewAvecListe(ListeSauvegarde,['Date','Heure','Nom fichier'],ListeDossier,true).free;
//                     if(valeurSelected='')and(ListeSauvegarde.Items.Count>0)
//                       then ListeSauvegarde.Items[0].Selected:=true;

                     if Str_empty(VLECHoixUtil.Values[VLENomFicARestaurer]) and (valeurSelected<>'') then
                      begin
                        for i:=0 to ListeSauvegarde.Items.Count-1 do
                          begin
                              if(valeurSelected=ListeSauvegarde.Items[i].SubItems[2])then
                                  begin
                                      ListeSauvegarde.Selected:=ListeSauvegarde.Items[i];
                                      ListeSauvegarde.ItemFocused :=ListeSauvegarde.Items[i];
                                      GestionSauvegarde.VLECHoixUtil.Values[VLENomFicARestaurer] := ParamUtil.RepertoireSauvegarde+E.NomDossier+'\'+ListeSauvegarde.Items[i].SubItems[2];
                                  end;
                          end;
                     end;


//              // Affiche le liste des sauvegarde disponible pour le dossier courant
//              // Gestion faite à partir d'un fichier d'historique
//              // A garder
//               if FileExists(ParamUtil.RepertoireSauvegarde+NomDossier+'\'+'GestSauv'+NomDossier+'.log') then
//                begin
//                  AssignFile(F, ParamUtil.RepertoireSauvegarde+NomDossier+'\'+'GestSauv'+NomDossier+'.log');
//                  reset(F);
//                  ListeSauvegarde.Clear;
//                  ListeSauvegarde.Items.Clear;
//                  ListeSauvegarde.Columns.Clear;
//
//                  ListeSauvegarde.Columns.Add.Caption := 'Nom Sauvegarde';
//                  ListeSauvegarde.Columns[ListeSauvegarde.Columns.Count-1].Width := 150;
//
//                  ListeSauvegarde.Columns.Add.Caption := 'Date';
//                  ListeSauvegarde.Columns[ListeSauvegarde.Columns.Count-1].Width := 75;
//
//                  ListeSauvegarde.Columns.Add.Caption := 'Heure';
//                  ListeSauvegarde.Columns[ListeSauvegarde.Columns.Count-1].Width := 75;
//
//                  ListeSauvegarde.Columns.Add.Caption := 'Nom Fichier';
//                  ListeSauvegarde.Columns[ListeSauvegarde.Columns.Count-1].Width := 350;
//
//                  ListeSauvegarde.Columns.Add.Caption := 'Sauvegardé depuis :';
//                  ListeSauvegarde.Columns[ListeSauvegarde.Columns.Count-1].Width := 120;
//                  while not eof(f) do
//                    begin
//                     Readln(F,Texte);
//                     ListeSauvegarde.Items.Add;
//                     ListeSauvegarde.Items[ListeSauvegarde.Items.Count-1].Caption:=str_getstringelement(Texte,1,';');
//              //          ListeAdresseMail.Items[ListeAdresseMail.Items.Count-1].Checked :=true;
//                     for j:=2 to 4 do
//                      begin
//                       tmp:=str_getstringelement(Texte,j,';');
//                       ListeSauvegarde.Items[ListeSauvegarde.Items.Count-1].SubItems.Add(tmp);
//                      end;
//                     ListeSauvegarde.Items[ListeSauvegarde.Items.Count-1].SubItems.Add(TempsEcoule(now-StrToDateTime(ListeSauvegarde.Items[ListeSauvegarde.Items.Count-1].SubItems[0]+' '+ListeSauvegarde.Items[ListeSauvegarde.Items.Count-1].SubItems[1])));
//                    end;
//                 CloseFile(F); // ferme le fichier
//                end
//              //   ListeSauvegarde.Items.LoadFromFile(ParamUtil.RepertoireSauvegarde+NomDossier+'\'+'GestSauv'+E.NomDossier+'.log')
//              else
//              //ListeSauvegarde.Items.Add('Aucune sauvegarde connu ...')
//              ;
//              OrdreTri:=-1;
//              // Fin de Affiche le liste des sauvegarde disponible pour le dossier courant
                      End;

   CT_DOSSIER_AUTRE:Begin
//                     if sender = FRAssistant1.BtnSuivant then
//                      begin
//                        if VLECHoixUtil.Values[VLENomDuDossier]='' then
//                         begin
                          ListeDossier:=TStringList.Create;
                          ListeDossier.Clear;
                          ListeDossier.Sorted := true;
                          ListeDossier.Duplicates := dupIgnore;
                          filtrageDataSet(DMREch.TaGestDossierRech,'Nom_Dossier <> '''+NomDossier+'''');
                          ChampTableVersVarListeEx(['Nom_Dossier','Dir_Dossier'],DMREch.TaGestDossierRech,ListeDossier,';',true);
            //              ListeDossier := ChampTableVersListe('Nom_Dossier',DMREch.TaGestDossierRech);
                          i:=ListeDossier.IndexOf(NomDossier);
                          While i <> -1 do
                           begin
                             ListeDossier.Delete(i);
                             i:=ListeDossier.IndexOf(NomDossier);
                           end;
                          ListeSauvegarde.Clear;
                          ListeSauvegarde.Items.Clear;
                          ListeSauvegarde.Columns.Clear;

                          ListeSauvegarde.Columns.Add.Caption := 'Nom des Dossiers';
                          ListeSauvegarde.Columns[ListeSauvegarde.Columns.Count-1].Width := 100;

                          ListeSauvegarde.Columns.Add.Caption := 'Repertoire des Dossiers';
                          ListeSauvegarde.Columns[ListeSauvegarde.Columns.Count-1].Width := self.Width-150;

                          InitLisViewAvecListe(ListeSauvegarde,['Dossiers','Repertoire'],[ListeDossier],false).free;

            //                        for i:=0 to ListeDossier.count-1 do
            //                          begin
            //                           ListeSauvegarde.Items.Add;
            //                           ListeSauvegarde.Items[ListeSauvegarde.Items.Count-1].Caption:=ListeDossier.Strings[i];
            ////                           ListeSauvegarde.Items[ListeSauvegarde.Items.Count-1].SubItems.Add(TempsEcoule(now-StrToDateTime(ListeSauvegarde.Items[ListeSauvegarde.Items.Count-1].SubItems[0]+' '+ListeSauvegarde.Items[ListeSauvegarde.Items.Count-1].SubItems[1])));
            //                          end;

    //                        GestionSauvegarde.NomDossier := ListeSauvegarde.Items[ListeSauvegarde.ItemFocused.Index].Caption;
    //                        GestionSauvegarde.Type_Liste := CT_DOSSIER_COURANT;
    //                        GestionSauvegarde.FormShow(self,GestionSauvegarde.Type_Liste);
    ////                        if Messagedlg(PChar('Voulez-vous restaurer la sauvegarde du : '+
    ////                                             ListeSauvegarde.Items[ListeSauvegarde.ItemFocused.Index].SubItems.Strings[0]+
    ////                                             ' à '+
    ////                                             ListeSauvegarde.Items[ListeSauvegarde.ItemFocused.Index].SubItems.Strings[1]+
    ////                                             '.'+
    ////                                             RetourChariotDouble+
    ////                                             'La restauration va écraser toutes les données saisies depuis '+
    ////                                             ListeSauvegarde.Items[ListeSauvegarde.ItemFocused.Index].SubItems.Strings[3]+
    ////                        //                     'La restauration va écraser toutes les données saisies depuis le : '+
    ////                        //                     ListeSauvegarde.Items[ListeSauvegarde.ItemFocused.Index].SubItems.Strings[0]+
    ////                        //                     ' à '+
    ////                        //                     ListeSauvegarde.Items[ListeSauvegarde.ItemFocused.Index].SubItems.Strings[1]+
    ////                                             '.' ),MtWarning,[mbyes,mbno],0)=mryes then
    ////                                            begin
    ////                        //if ParamCount > 0 then NomDossier:=ParamStr(1);
    ////                        //if ParamCount > 1 then RepDossier:=ParamStr(2);
    ////                        //if ParamCount > 2 then FichierZip:=ParamStr(3);
    ////                                              ShellExecute(handle,nil,PChar(E.RepertoireProgram+'RestaureD3.exe'),
    ////                                                           PChar(NomDossier+' "'+E.RepertoireDossier+'" "'+ListeSauvegarde.Items[ListeSauvegarde.ItemFocused.Index].SubItems.Strings[2]+'"'),nil,sw_show);
    ////                                            end;
//                         end // Fin de NomDuDossierVide
//                        else
//                         Begin // NomDuDossier non vide
//
//                         end;  // Fin de NomDuDossier non vide
//                      end // Fin de BtnSuivant
//                     else
//                      Begin // BtnPrecedent
//
//                      end; // Fin de BtnPrecedent
                    End;

   CT_DOSSIER_IMPORTE:Begin

                      End;
  end;
ordretri:=1;  
ListeSauvegardeColumnClick(ListeSauvegarde,ListeSauvegarde.Column[2]);
ordretri:=1;
ListeSauvegardeColumnClick(ListeSauvegarde,ListeSauvegarde.Column[1]);
ListeSauvegarde.Repaint;

End;

procedure TGestionSauvegarde.Etape1Click(Sender: TObject);
var
F: TextFile;
TExte,tmp:String;
J:integer;
ListeDossier,ListeFichierARestaurer:TStringList;
i:integer;
ProgRestauration:String;
EnDehors:boolean;
messageFichier,dateRest:string;
Begin
EnDehors:=false;
ProgRestauration:=PChar(E.RepertoireProgram+'RestaureLGR.exe');
if GetOSInfo.retour=false then
begin
//  Application.MessageBox(Pchar('Cette fonctionnalité n''est pas compatible avec votre version de Windows.'+
//  retourChariotsimple+'Vous devez vous servir de l''outil de restauration externe'+
//  retourChariotDouble+'---------------------------------------------------------'+retourChariotDouble+
//  retourChariotSimple+'"Restauration Epicea.exe"'+
//  retourChariotDouble+'---------------------------------------------------------'+retourChariotDouble+
//  retourChariotSimple+'qui se trouve sur votre bureau.'),'Attention, version windows incompatible !!!',MB_ICONERROR)
ProgRestauration:=PChar(E.RepertoireProgram+'MDCOGERE.exe');
EnDehors:=true;
end ;
//else
try //except

  case Type_Liste of
   CT_DOSSIER_COURANT:Begin
                    try
                     if Str_empty(VLECHoixUtil.Values[VLENomFicARestaurer]) then
                      begin
                       if ListeSauvegarde.Selected = nil then abort
                        else
                         GestionSauvegarde.VLECHoixUtil.Values[VLENomFicARestaurer] := ParamUtil.RepertoireSauvegarde+E.NomDossier+'\'+ListeSauvegarde.Items[ListeSauvegarde.ItemFocused.Index].SubItems.Strings[2];
                      end
                      else
                      begin
                       if ListeSauvegarde.Selected <> nil then
                        if VLECHoixUtil.Values[VLENomFicARestaurer] <> ParamUtil.RepertoireSauvegarde+E.NomDossier+'\'+ListeSauvegarde.Items[ListeSauvegarde.ItemFocused.Index].SubItems.Strings[2] then
                           GestionSauvegarde.VLECHoixUtil.Values[VLENomFicARestaurer] := ParamUtil.RepertoireSauvegarde+E.NomDossier+'\'+ListeSauvegarde.Items[ListeSauvegarde.ItemFocused.Index].SubItems.Strings[2];
                      end;
                    except
                     MessageDlg('Vous devez sélectionner une sauvegarde'+#13+#10+'dans la liste.', Dialogs.mtInformation, [Dialogs.mbOK], 0);
                     abort;
                    end;
                      ListeFichierARestaurer:=TStringList.Create;
dateRest:=DateInfos(Date).JourStr+'-'+DateInfos(Date).MoisStr+'-'+DateInfos(Date).AnStr+' à '+HeureInfos(Time,'').HeureStr+
'-'+HeureInfos(Time,'').MinuteStr+'-'+HeureInfos(Time,'').SecondeStr;
messageFichier:='Le '+dateRest+', sur le dossier '+E.NomDossier+' ,restauration de la sauvegarde : '+#10+GestionSauvegarde.VLECHoixUtil.Values[VLENomFicARestaurer];
  //                    ListeFichierARestaurer.Clear;
  //                    ListeFichierARestaurer:=ListeFic('*.zlg',ParamUtil.RepertoireSauvegarde+E.NomDossier+'\',faAnyFile,false,False);
                      if Messagedlg(PChar('Voulez-vous restaurer la sauvegarde du : '+
                                           GestionSauvegarde.VLECHoixUtil.Values[VLENomDuDossier]+
  //                                         ' à '+
  //                                         ListeSauvegarde.Items[ListeSauvegarde.ItemFocused.Index].SubItems.Strings[0]+
                                           '.'+
                                           RetourChariotDouble+
                                           'Nom du fichier : '+
                                           GestionSauvegarde.VLECHoixUtil.Values[VLENomFicARestaurer]+
                      //                     'La restauration va écraser toutes les données saisies depuis le : '+
                      //                     ListeSauvegarde.Items[ListeSauvegarde.ItemFocused.Index].SubItems.Strings[0]+
                      //                     ' à '+
                      //                     ListeSauvegarde.Items[ListeSauvegarde.ItemFocused.Index].SubItems.Strings[1]+
                                           '.' ),Dialogs.MtWarning,[Dialogs.mbyes,Dialogs.mbno],0)=mryes then
                                          begin

//                                          //controle de version   Transferé dans MDCogere uniquement
//                                          ControleVersionSauvegarde(GestionSauvegarde.VLECHoixUtil.Values[VLENomFicARestaurer]);

                                          ListeFichierARestaurer.Add(E.NomDossier+';'+
                                                                     RepertoirePere(E.RepertoireDossier)+';'+
                                                                     GestionSauvegarde.VLECHoixUtil.Values[VLENomFicARestaurer]+';'
                                                                     );

                                          NomFicRestauration:='RestaureLog'+E.NomDossier+LibDates.DateInfos(Date,'').DateStrFormat+HeureInfos(Time,'').HeureStrFormate+'.txt';
                                          ListeFichierARestaurer.SaveToFile(ParamUtil.RepertoireSauvegarde+NomFicRestauration);

                                          //  Chemin et nom du programme de sauvegarde
                                          
                                          try
                                            if FermerDossier(E) then
                                             begin
                                                 if(EnDehors)then
                                                    begin
                                                          Application.MessageBox(Pchar('Cette fonctionnalité n''est pas compatible avec votre version de Windows.'+
                                                          retourChariotsimple+'Epicéa va se fermer et '+
                                                          retourChariotsimple+'vous allez être automatiquement redirigé vers l''outil de restauration externe'+
                                                          retourChariotDouble+'---------------------------------------------------------'+retourChariotDouble+
                                                          retourChariotSimple+'"Restauration Epicea.exe"'+
                                                          retourChariotDouble+'---------------------------------------------------------'+retourChariotDouble+
                                                          retourChariotSimple+'qui se trouve sur votre bureau.'),'Attention, version windows incompatible !!!',MB_ICONERROR);
                                                           e.ControleDuDossier:=false;
                                                           e.ControleDuDossierEntrant:=false;
                                                           ShellExecute(handle,nil,PChar(ProgRestauration),
                                                               PChar(GestionSauvegarde.VLECHoixUtil.Values[VLENomFicARestaurer]),nil,SW_SHOWNORMAL);
                                                           Application.Minimize;
                                                           self.ouvertureDossier:=false;
                                                           Application.Terminate;
                                                    end
                                                  else
                                                    begin
                                                        if MessageDlg('Faire une sauvegarde de secours ?', Dialogs.mtConfirmation, [Dialogs.mbYes,Dialogs.mbNo], 0) = mrYes then
                                                        begin
                                                         if SauveDossier(nil,'','','-AvantRestauration') then
                                                            begin

                                                               if(ShellExecuteAndWait(Application.Handle,'',PChar(ProgRestauration),
                                                                     '"'+ParamUtil.RepertoireSauvegarde+NomFicRestauration+'"',PChar(ExcludeTrailingPathDelimiter(e.RepertoireProgram)),SW_SHOWNORMAL,
                                                                                          INFINITE))= NO_ERROR then
                                                                   AjouterFichierTexte(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'RestaurationSuivi.txt',messageFichier);
                                                            end ;
                                                        end
                                                       else
                                                          begin
                                                            if(ShellExecuteAndWait(Application.Handle,'',PChar(ProgRestauration),
                                                                 '"'+ParamUtil.RepertoireSauvegarde+NomFicRestauration+'"',PChar(ExcludeTrailingPathDelimiter(e.RepertoireProgram)),SW_SHOWNORMAL,
                                                                                      INFINITE))= NO_ERROR then
                                                             AjouterFichierTexte(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'RestaurationSuivi.txt',messageFichier);
                                                          end;
                                                   end;
                                                 end;
                                           Finally

                                          end;
                                          end;

                      End;

   CT_DOSSIER_AUTRE:Begin
                     CBSauvegardeSecours.Visible := False;
                     ListeSauvegarde.Visible := True;

                     if sender = FRAssistant1.BtnSuivant then
                      begin
                       If ListeSauvegarde.Selected <> nil then
                        begin
                         NomDossAutreDossier:= ListeSauvegarde.Items[ListeSauvegarde.Selected.Index].Caption;// Strings[0];
                         RepNomDossAutreDossier := ListeSauvegarde.Items[ListeSauvegarde.Selected.Index].SubItems.Strings[0];
                         VLECHoixUtil.Values[VLENomDuDossier] := NomDossAutreDossier;
                        end
                       else
                        begin
                         if VLECHoixUtil.Values[VLENomDuDossier]='' then
                          begin
                           Showmessage('Veuillez sélectionner le nom du dossier à restaurer !');
                           abort;
                          end;
                        end;



                       // Affiche le liste des sauvegarde disponible pour le dossier courant
                       if FileExists(ParamUtil.RepertoireSauvegarde+NomDossAutreDossier+'\'+'GestSauv'+NomDossAutreDossier+'.log') then
                        begin
                          AssignFile(F, ParamUtil.RepertoireSauvegarde+NomDossAutreDossier+'\'+'GestSauv'+NomDossAutreDossier+'.log');
                          reset(F);
                          ListeSauvegarde.Clear;
                          ListeSauvegarde.Items.Clear;
                          ListeSauvegarde.Columns.Clear;

                          ListeSauvegarde.Columns.Add.Caption := 'Nom Sauvegarde';
                          ListeSauvegarde.Columns[ListeSauvegarde.Columns.Count-1].Width := 150;

                          ListeSauvegarde.Columns.Add.Caption := 'Date';
                          ListeSauvegarde.Columns[ListeSauvegarde.Columns.Count-1].Width := 75;

                          ListeSauvegarde.Columns.Add.Caption := 'Heure';
                          ListeSauvegarde.Columns[ListeSauvegarde.Columns.Count-1].Width := 75;

                          ListeSauvegarde.Columns.Add.Caption := 'Nom Fichier';
                          ListeSauvegarde.Columns[ListeSauvegarde.Columns.Count-1].Width := 350;

                          ListeSauvegarde.Columns.Add.Caption := 'Sauvegardé depuis :';
                          ListeSauvegarde.Columns[ListeSauvegarde.Columns.Count-1].Width := 120;
                          while not eof(f) do
                            begin
                             Readln(F,Texte);
                             ListeSauvegarde.Items.Add;
                             ListeSauvegarde.Items[ListeSauvegarde.Items.Count-1].Caption:=str_getstringelement(Texte,1,';');
                             for j:=2 to 4 do
                              begin
                               tmp:=str_getstringelement(Texte,j,';');
                               ListeSauvegarde.Items[ListeSauvegarde.Items.Count-1].SubItems.Add(tmp);
                              end;
                             ListeSauvegarde.Items[ListeSauvegarde.Items.Count-1].SubItems.Add(TempsEcoule(now-StrToDateTime(ListeSauvegarde.Items[ListeSauvegarde.Items.Count-1].SubItems[0]+' '+ListeSauvegarde.Items[ListeSauvegarde.Items.Count-1].SubItems[1])));
                            end;
                         CloseFile(F); // ferme le fichier

                          // Gestion de la sélection auto de la listView
                          //////////////////////////////////////////////////////
                          if ListeSauvegarde.Items[0].SubItems.Count > 0 then
                           begin
                            if VLECHoixUtil.Values[VLENomFicARestaurer] = '' then
                             begin
                              ListeSauvegarde.Items[0].Selected := true;
                             end
                            else
                             begin
                              J:=ListeSauvegarde.Items[0].SubItems.IndexOf(VLECHoixUtil.Values[VLENomFicARestaurer]);
                               if J <> -1 then
                                 ListeSauvegarde.Selected := ListeSauvegarde.Items[J];
//                                 showmessage(ListeSauvegarde.Items[0].SubItems.Strings[J]);
                             end;
                           end;
                          //////////////////////////////////////////////////////

                        end
                      else
                       begin
                        if MessageDlg('Pas de fichier de sauvegarde connu pour le dossier '+NomDossAutreDossier+' !'+#13+#10+''+#13+#10+'Voulez-Vous recherchez manuellement la sauvegarde ?', Dialogs.mtConfirmation, [Dialogs.mbYes,Dialogs.mbNo], 0) = mrYes then
                         begin
                          if ChercherSauvegarde(ParamUtil.RepertoireSauvegarde) then
                           begin
                             VLECHoixUtil.Values[VLENomFicARestaurer] := self.NomFichierSauvegardeCherche;
                           end
                           else
                           begin
                            abort;
                           end;
                         end
                        else
                         begin
                          abort;
                         end;
                       end;
//                      OrdreTri:=-1;
                      end  // Fin de BtnSuivant
                     else
                      begin // BtnPrecedent

                      end;  // Fin de BtnPrecedent
                    End;

   CT_DOSSIER_IMPORTE:Begin

                      End;
  end;
except
end;  

end;

procedure TGestionSauvegarde.Etape2Click(Sender: TObject);
Begin
  case Type_Liste of
   CT_DOSSIER_COURANT:Begin

                      End;

   CT_DOSSIER_AUTRE:Begin
                     if sender = FRAssistant1.BtnSuivant then
                      begin
                       if ListeSauvegarde.Selected <> nil then
                        begin
                         VLECHoixUtil.Values[VLENomFicARestaurer] :=ListeSauvegarde.Items[ListeSauvegarde.Selected.Index].SubItems[2];
                        end
                       else
                        begin
                         if VLECHoixUtil.Values[VLENomFicARestaurer]='' then
                          begin
                           Showmessage('Veuillez sélectionner le nom de la sauvegarde à restaurer !');
                           abort;
                          end;
                        end;
                       ListeSauvegarde.Visible := false;
                       CBSauvegardeSecours.Visible := true;
                      end
                     else
                      Begin
                       CBSauvegardeSecours.Visible := TRue;
                       ListeSauvegarde.Visible := false;
                      End;
                    End;


   CT_DOSSIER_IMPORTE:Begin

                      End;
  end;
End;

procedure TGestionSauvegarde.Etape3Click(Sender: TObject);
Begin
  case Type_Liste of
   CT_DOSSIER_COURANT:Begin

                      End;

   CT_DOSSIER_AUTRE:Begin
                     if sender = FRAssistant1.BtnSuivant then
                      begin
                       VLECHoixUtil.Values[VLESauvegardeSecours] := str_bool2str_LGR(CBSauvegardeSecours.Checked,'Oui','Non');
                       CBSauvegardeSecours.Visible := false;
                      end
                     else
                      Begin
                       CBSauvegardeSecours.Visible := false;
                       ListeSauvegarde.Visible := true;
                      End;
                    End;


   CT_DOSSIER_IMPORTE:Begin

                      End;
  end;
End;

procedure TGestionSauvegarde.EtapeFinClick(Sender: TObject);
Begin
case Type_Liste of
 CT_DOSSIER_COURANT:Begin
                     self.ModalResult := mrOk;
//                     self.Close;
                    End;

 CT_DOSSIER_AUTRE:Begin
                    if Messagedlg(PChar('Vous allez restaurer la sauvegarde  : '+
                                         RetourChariotDouble+
                                         GestionSauvegarde.VLECHoixUtil.Values[VLENomFicARestaurer]+
                                         RetourChariotDouble+
                                         'pour le dossier : '+
                                         RetourChariotDouble+
                                         GestionSauvegarde.VLECHoixUtil.Values[VLENomDuDossier]+
                                         RetourChariotDouble+
                                         ' Faire une copie de secours : '+
                                         GestionSauvegarde.VLECHoixUtil.Values[VLESauvegardeSecours]+
                                         RetourChariotDouble+
                                         'Continuer ?' ),Dialogs.MtWarning,[Dialogs.mbyes,Dialogs.mbno],0)=mryes then
                                        begin
                                        if MessageDlg('Nom du rep : '+ RepNomDossAutreDossier+'\', Dialogs.mtWarning, [Dialogs.mbYes,Dialogs.mbNo], 0) = mrYes then
                                         RenomeDossierAvantRestaurationDossier('C:\PROJET\EPICEA-2\EXECUTION\D1\');
//                                         RenomeDossierAvantRestaurationDossier(RepNomDossAutreDossier+'\');
//                                          ShellExecute(handle,nil,PChar(E.RepertoireProgram+'RestaureD3.exe'),
//                                                       PChar(NomDossier+' "'+E.RepertoireDossier+'" "'+ListeSauvegarde.Items[ListeSauvegarde.ItemFocused.Index].SubItems.Strings[2]+'"'),nil,sw_show);
                                        end;


                  End;

 CT_DOSSIER_IMPORTE:Begin

                    End;
end;

End;

procedure TGestionSauvegarde.ListeSauvegardeDblClick(Sender: TObject);
begin
  Try
    case Type_Liste of
     CT_DOSSIER_COURANT:Begin
                        End;

     CT_DOSSIER_AUTRE:Begin

                      End;

     CT_DOSSIER_IMPORTE:Begin

                        End;
    end;
  except
   MessageDlg('Erreur lors de la lecture du Dossier !', Dialogs.mtError, [Dialogs.mbOK], 0);
  end;
end;

procedure TGestionSauvegarde.ListeSauvegardeKeyPress(Sender: TObject;
  var Key: Char);
begin
 if key = #13 then ListeSauvegardeDblClick(ListeSauvegarde);
end;

procedure TGestionSauvegarde.FormShow(Sender: TObject);
begin
case Type_Liste of
 CT_DOSSIER_COURANT:Begin
                      ListeSauvegarde.SetFocus;
                      if ListeSauvegarde.Items.Count > 0 then
                       begin
                        ListeSauvegarde.ItemFocused := ListeSauvegarde.Items[0];
                        ListeSauvegarde.Selected := ListeSauvegarde.Items[0];
                       end;
                    End;

 CT_DOSSIER_AUTRE:Begin

                  End;

 CT_DOSSIER_IMPORTE:Begin

                    End;
end;

end;

procedure TGestionSauvegarde.ListeSauvegardeColumnClick(Sender: TObject;
  Column: TListColumn);
var
valeurSelected:TListItem;
begin
OrdreTri:=-OrdreTri;
valeurSelected:=ListeSauvegarde.Selected;
  case Type_Liste of
   CT_DOSSIER_COURANT:Begin
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
                      End;

   CT_DOSSIER_AUTRE:Begin
                        OrdreTri:=-OrdreTri;
                        if Column.Index > 0 then
                        ListeSauvegarde.CustomSort(nil, Column.Index-1)
                        else
                        ListeSauvegarde.CustomSort(nil, Column.Index)

                    End;

   CT_DOSSIER_IMPORTE:Begin

                      End;
  end;
end;

procedure TGestionSauvegarde.ListeSauvegardeCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
case Type_Liste of
 CT_DOSSIER_COURANT:Begin
                      if DAta >= 0 then
                      compare:=OrdreTri*StrComp(PChar(Item1.SubItems.Strings[Data]),PChar(Item2.SubItems.Strings[Data]))
                      else
                      compare:=OrdreTri*StrComp(PChar(TListItem(Item1).Caption),PChar(TListItem(Item2).Caption));
                    End;

 CT_DOSSIER_AUTRE:Begin
                      if DAta >= 0 then
                      compare:=OrdreTri*StrComp(PChar(Item1.SubItems.Strings[Data]),PChar(Item2.SubItems.Strings[Data]))
                      else
                      compare:=OrdreTri*StrComp(PChar(TListItem(Item1).Caption),PChar(TListItem(Item2).Caption));

                  End;

 CT_DOSSIER_IMPORTE:Begin

                    End;
end;


end;

procedure TGestionSauvegarde.ListeSauvegardeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
IndexTmp:integer;
SuppressionOK:Boolean;
i:integer;
Texte : string;
ListeAdresse:TStringList;
begin
SuppressionOK:=false;
ListeAdresse:=TStringList.Create;
if key = vk_delete then
 begin
   try
    IndexTmp:=0;
    if ((ListeSauvegarde.Items.Count > 0) and(MessageDlg('Êtes-Vous sûr de vouloir supprimer cette sauvegarde ?',Dialogs.mtConfirmation,[Dialogs.mbYes,Dialogs.mbNo],0)=mrYes)) then
     begin
      if FileExists(ListeSauvegarde.Items[ListeSauvegarde.ItemFocused.Index].SubItems.Strings[2]) then
       begin
        SuppressionOK:=DeleteFile(ListeSauvegarde.Items[ListeSauvegarde.ItemFocused.Index].SubItems.Strings[2]);
       end
      else
       begin
        MessageDlg('Le fichier '+ListeSauvegarde.Items[ListeSauvegarde.ItemFocused.Index].SubItems.Strings[2]+' est introuvable',Dialogs.mtError,[Dialogs.mbOK],0);
        SuppressionOK:=False;
        end;
      if not SuppressionOK then
       begin
        SuppressionOK :=(MessageDlg('Le fichier '+
                      ListeSauvegarde.Items[ListeSauvegarde.ItemFocused.Index].SubItems.Strings[2]+
                      ' n''a pas pu être supprimé.'+
                     RetourChariotDouble+
                      ' Voulez-Vous le supprimer quand même de la liste ?'
                        ,Dialogs.mtError,[Dialogs.mbYes,Dialogs.mbNo],0)=mrYes);
       end;
      IndexTmp:=ListeSauvegarde.Selected.Index;
        if ((IndexTmp >= 0) and (SuppressionOK = true)) then
         begin
          ListeSauvegarde.Items[ListeSauvegarde.Selected.Index].Delete;
          SauveListViewToFile(ListeSauvegarde,E.RepertoireDossier+'\'+'GestSauv'+NomDossier+'.log',';',0,2);
//          ListeAdresse.Clear;
//          for i:=0 to ListeSauvegarde.Items.Count-1 do
//           begin
//            ListeAdresse.Add(ListeSauvegarde.Items[i].Caption+';'+
//                             ListeSauvegarde.Items[i].SubItems.Strings[0]+
//                             ';'+
//                             ListeSauvegarde.Items[i].SubItems.Strings[1]+
//                             ';'+
//                             ListeSauvegarde.Items[i].SubItems.Strings[2]+
//                             ';');
//           end;
//
//          ListeAdresse.SaveToFile(E.RepertoireDossier+'GestSauv'+NomDossier+'.log');
          if ListeSauvegarde.Items.Count > IndexTmp then
             ListeSauvegarde.Selected := ListeSauvegarde.Items[IndexTmp]
             else
             ListeSauvegarde.Selected := ListeSauvegarde.Items[ListeSauvegarde.Items.Count-1]
         end;
      end;
   except
    abort;
    ListeAdresse.Free;
   end;
   end;
ListeAdresse.Free;
end;

procedure TGestionSauvegarde.SauveListViewToFile(ListeSauvegarde: TListView;NomFichier,Separateur:string;Min,Max:Integer);
var
i,j:integer;
ListeAdresse:TStringList;
Texte:String;
Begin
  case Type_Liste of
   CT_DOSSIER_COURANT:Begin
                       ListeAdresse:=TStringList.Create;
                       ListeAdresse.Clear;
                       Texte:='';
                       for i:=0 to ListeSauvegarde.Items.Count-1 do
                        begin
                         for j:=Min to Max do
                             Texte:=Texte+ListeSauvegarde.Items[i].SubItems.Strings[j]+Separateur;
                         ListeAdresse.Add(ListeSauvegarde.Items[i].Caption+';'+Texte);
                         Texte:='';
                        end;

                       ListeAdresse.SaveToFile(NomFichier);
                       ListeAdresse.Free;
                      End;

   CT_DOSSIER_AUTRE:Begin

                    End;

   CT_DOSSIER_IMPORTE:Begin

                      End;
  end;
End;

procedure TGestionSauvegarde.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
case Type_Liste of
 CT_DOSSIER_COURANT:Begin
//                     SauveListViewToFile(ListeSauvegarde,E.RepertoireDossier+'\'+'GestSauv'+E.NomDossier+'.log',';',0,2);
                    End;

 CT_DOSSIER_AUTRE:Begin

                  End;

 CT_DOSSIER_IMPORTE:Begin

                    End;
end;

end;

procedure TGestionSauvegarde.FormDestroy(Sender: TObject);
begin
  GestionSauvegarde := nil;
end;

Function TGestionSauvegarde.ChercherSauvegarde(RepertoireDossierSauvegarde:String):Boolean;
Begin
 OpenDialog1.Title := 'Recherche une sauvegarde Epicéa';
 OpenDialog1.InitialDir := RepertoireDossierSauvegarde;
 result:=OpenDialog1.Execute ;
 if Result then
  self.NomFichierSauvegardeCherche := OpenDialog1.FileName;
End;

Procedure TGestionSauvegarde.InitCleVLE;
Begin
  case Type_Liste of
   CT_DOSSIER_COURANT:Begin
                       GestionSauvegarde.VLECHoixUtil.Values[VLENomDuDossier] := GestionSauvegarde.NomDossier;
                       GestionSauvegarde.VLECHoixUtil.Values[VLENomFicARestaurer] := '';
                       GestionSauvegarde.VLECHoixUtil.Values[VLESauvegardeSecours] := '';
                      End;

   CT_DOSSIER_AUTRE:Begin
//                      GestionSauvegarde.VLECHoixUtil.Strings.Clear;
//                      GestionSauvegarde.VLECHoixUtil.Strings.Add(VLENomDuDossier);
                      GestionSauvegarde.VLECHoixUtil.Values[VLENomDuDossier] := '';
                      GestionSauvegarde.VLECHoixUtil.Values[VLENomFicARestaurer] := '';
                      GestionSauvegarde.VLECHoixUtil.Values[VLESauvegardeSecours] := '';
                    End;

   CT_DOSSIER_IMPORTE:Begin

                      End;
  end;

End;

Procedure TGestionSauvegarde.InitViewList;
Begin
    GestionSauvegarde.ListeSauvegarde.Clear;
    GestionSauvegarde.ListeSauvegarde.Columns.Clear;
    case Type_Liste of
     CT_DOSSIER_COURANT:Begin
                         CBSauvegardeSecours.Visible := false;
                        End;

     CT_DOSSIER_AUTRE:Begin
                       ListeSauvegarde.Visible := true;
                       CBSauvegardeSecours.Visible := false;
                       ListeSauvegarde.Columns.Add;
                       ListeSauvegarde.Columns[GestionSauvegarde.ListeSauvegarde.Columns.Count-1].Width := GestionSauvegarde.Width-150;
                       ListeSauvegarde.Items.Add.Caption :='Cliquez sur le bouton Démarrer !';
                       ListeSauvegarde.Refresh;
                      End;

     CT_DOSSIER_IMPORTE:Begin

                        End;
    end;

End;


procedure TGestionSauvegarde.FRAssistant1BtnSuivantClick(Sender: TObject);
begin
  FRAssistant1.Etape0(Sender);
end;

procedure TGestionSauvegarde.BtnAutreClick(Sender: TObject);
begin
if ChercherSauvegarde(ParamUtil.RepertoireSauvegarde+E.NomDossier) then
 VLECHoixUtil.Values[VLENomFicARestaurer] := NomFichierSauvegardeCherche;
Etape0Click(self);
end;

procedure TGestionSauvegarde.FRAssistant1BtnAnnulerClick(Sender: TObject);
begin
  FRAssistant1.BtnAnnulerClick(Sender);

end;


function TGestionSauvegarde.ControleVersionSauvegarde(Sauvegarde:string):boolean;
var
cheminFichierTemp:string;
F: TextFile;
Ligne:string;
zip:TZipMaster;
trouve:boolean;
begin
try//finally
//gestion des contrôles de version
if ((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS')
  and (ParamUtil.TypeMaintenanceSpeciale=IntToSTr(LibDates.NbDeJours(StrToDate('01/01/'+LibDates.DateInfos(Date).AnStr),Date)+82+11))) then
begin
  exit;
end;
if FileExists(IncludeTrailingPathDelimiter(ParamUtil.RepertoireExtraction)+C_Version_FileName)then
  DeleteFile(IncludeTrailingPathDelimiter(ParamUtil.RepertoireExtraction)+C_Version_FileName);
zip:=TZipMaster.Create(self);
zip.ZipFilename:=Sauvegarde;
zip.FSpecArgs.Add(e.NomDossier+'/'+C_Version_FileName);
zip.FSpecArgs.Add(e.NomDossier+'/'+C_Version_FileNameConfirme);
zip.ExtrBaseDir:=ExcludeTrailingPathDelimiter(ParamUtil.RepertoireExtraction);
if not DirectoryExists(ExcludeTrailingPathDelimiter(ParamUtil.RepertoireExtraction))then
  CreateDir(ExcludeTrailingPathDelimiter(ParamUtil.RepertoireExtraction));
trouve:=false;
zip.Extract;
if FileExists(IncludeTrailingPathDelimiter(ParamUtil.RepertoireExtraction)+C_Version_FileName)then
begin
  AssignFile(F, IncludeTrailingPathDelimiter(ParamUtil.RepertoireExtraction)+C_Version_FileName);
  reset(f);
  Readln(F,Ligne);
  trouve:=Ligne<=Str_ChaineToHEXA(numVersion.Version);
  Str_ChaineToHEXA(numVersion.Version);
  CloseFile(F);
end
else
  if FileExists(IncludeTrailingPathDelimiter(ParamUtil.RepertoireExtraction)+C_Version_FileNameConfirme)then
    trouve:=false //ça veut dire qu'il manque un fichier de contrôle
  else
    trouve:=true;
if not DirectoryExists(ExcludeTrailingPathDelimiter(ParamUtil.RepertoireExtraction))then
  showmessage('Problème rencontré lors du contrôle de version de la sauvegarde');
if not trouve then
begin
   showmessage(VersionAnterieur+AppelerServiceMaintenance);
   abort;
end;
           //supprimer le fichier Locked
                cheminFichierTemp:=IncludeTrailingPathDelimiter(e.RepertoireDossier)+fileLocked;
                if(FileExists(cheminFichierTemp))then
                begin
                   DeleteFile(pchar(cheminFichierTemp));
                end;
//fin gestion des contrôles de version
finally
if FileExists(IncludeTrailingPathDelimiter(ParamUtil.RepertoireExtraction)+C_Version_FileName)then
  DeleteFile(IncludeTrailingPathDelimiter(ParamUtil.RepertoireExtraction)+C_Version_FileName);
if FileExists(IncludeTrailingPathDelimiter(ParamUtil.RepertoireExtraction)+C_Version_FileNameConfirme)then
  DeleteFile(IncludeTrailingPathDelimiter(ParamUtil.RepertoireExtraction)+C_Version_FileNameConfirme);
  zip.Free;
end;
end;

procedure TGestionSauvegarde.BtnFTPClick(Sender: TObject);
var accede:boolean;
continuer:integer;
 db : TMsgDlgParams;
 MessageLGR:TMessageLGR;
 AfficherCheck:boolean;
 retourShell:cardinal;
 i:integer;
begin
accede:=false;

   db:=initMessageLGR(self,'','RecupFTP','La récupération de la(des) sauvegarde(s) depuis l''adresse FTP : &peut-être longue.',
   'Récupération par FTP',[mbCust1, mbcancel],mbCust1,MessageLGR);
   db.CustBtnText[mbCust1] := 'Continuer';
   db.lpszText:= Pansichar(GetStringElement(MessageLGR.MessageLGR,1,'&')+
                     e.ParamFTP.Login+':'+e.ParamFTP.PassWord+'@'+e.ParamFTP.Serveur+
                     Retourchariotsimple+GetStringElement(MessageLGR.MessageLGR,2,'&'));
  try //finally
     PatienterAffich(true);
     if LitFichierParamFTP(e.ParamFTP.Fichier,e.Paramftp,true,e.NomDossier,DM_C_ServeurFTP,e.ParamFTP,e.RepertoireDossier)then
       begin
         if EssaiConnection then
           begin
               try//finally
                    if MessageLGR.Afficher then
                      continuer:=MsgDlgBox(db)
                    else continuer:=mrCust1;
                 if db.CheckBox then
                   begin
                     MessageLGR.Afficher:=not StrToBool_Lgr(IntToStr(hiWord(continuer)),true);
                     DM_EcritMessageLGR(MessageLGR);
                   end;
                if LoWord(continuer)=mrCust1 then
                 begin
                    e.ParamFTP.Source:=IncludeTrailingPathDelimiter(ParamUtil.RepertoireSauvegarde)+e.nomdossier;
                   // e.ParamFTP.Dest:='/';
                    EcritFichierParamFTP(e.ParamFTP,e.ParamFTP);
                    retourShell:=ShellExecuteAndWait(Application.Handle,'','envoi_ftp.exe',PChar('"'+e.ParamFTP.Fichier+'" ga'),
                           PChar(ExcludeTrailingPathDelimiter(e.RepertoireProgram)),SW_SHOWNORMAL,INFINITE);
                    if(retourShell = NO_ERROR )then
                      accede:=true
                    else
                      accede:=false;
                 end;

               finally
                  if accede then
                    begin
                      initCaptionBtnRaffraichir(BtnRaffraichir.Visible);
                      LitFichierParamFTP(e.ParamFTP.Fichier,e.Paramftp,true,e.NomDossier,DM_C_ServeurFTP,e.ParamFTP,e.RepertoireDossier);
                    end;
                  if(FileExists(e.Paramftp.Source))then
                    begin
                      BtnRaffraichir.Click;
                      for i:=0 to ListeSauvegarde.Items.Count-1 do
                        begin
                           if(ListeSauvegarde.Items[i].SubItems[2]=ExtractFileName(e.Paramftp.Source) )then
                           begin
                             Etape0Click(nil);;
                             ListeSauvegarde.ItemFocused := ListeSauvegarde.Items[i];
                             ListeSauvegarde.Selected := ListeSauvegarde.Items[i];
                             GestionSauvegarde.VLECHoixUtil.Values[VLENomFicARestaurer]:=ParamUtil.RepertoireSauvegarde+E.NomDossier+'\'+ListeSauvegarde.Items[i].SubItems.Strings[2];
                             ExtractFileName(e.Paramftp.Source);
                             Etape1Click(nil);
                           end;
                        end;

                    end;
               end;
           end;
       end
      else if Application.MessageBox(Pchar('Voulez-vous règler vos paramètres de connexion ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
          Main.Proprits1Click(GestionSauvegarde);
  finally
    PatienterFermer;
  end;
end;

procedure TGestionSauvegarde.Collerlasauvegarde1Click(Sender: TObject);
begin
CopyFile(PChar(ClipBoard.AsText),PChar(ClipBoard.AsText),false);
end;

procedure TGestionSauvegarde.Listedessauvegardes1Click(Sender: TObject);
begin
ShellExecuteA(handle, 'explore', Pchar(ParamUtil.RepertoireSauvegarde+E.NomDossier+'\'), NiL, NiL, SW_SHOWNORMAL);
initCaptionBtnRaffraichir(BtnRaffraichir.Visible);
BtnFTP.SetFocus;
end;

procedure TGestionSauvegarde.RinitialiserlesparamtreFTP1Click(
  Sender: TObject);
begin
//Afficher une fenêtre pour saisir les paramètres FTP
Main.Proprits1Click(GestionSauvegarde);
end;

procedure TGestionSauvegarde.Raffrachir1Click(Sender: TObject);
begin
initCaptionBtnRaffraichir(true);
end;


procedure TGestionSauvegarde.initCaptionBtnRaffraichir(Visible:boolean);
begin
  if Visible then
      begin
          Etape0Click(self);
          ListeSauvegarde.SetFocus;
          BtnRaffraichir.Visible:=false;
      end
  else
      begin
          BtnRaffraichir.Visible:=true;
          BtnRaffraichir.Font.Color:=clred;
      end;
end;


procedure TGestionSauvegarde.BtnRaffraichirClick(Sender: TObject);
begin
initCaptionBtnRaffraichir(true);
end;

function TGestionSauvegarde.LancementProcess(exe,param : string):boolean;
Var  StartInfo   : TStartupInfo;
     ProcessInfo : TProcessInformation;
     Fin         : Boolean;
begin
////if (ShellExecute(Application.Handle,nil,PChar(ProgRestauration),
////PChar('"'+ParamUtil.RepertoireSauvegarde+NomFicRestauration+'"'),nil,sw_show) > 32) then;
////
//
//  { Mise à zéro de la structure StartInfo }
//  FillChar(StartInfo,SizeOf(StartInfo),#0);
//  { Seule la taille est renseignée, toutes les autres options }
//  { laissées à zéro prendront les valeurs par défaut }
//  StartInfo.cb     := SizeOf(StartInfo);
//
//  { Lancement de la ligne de commande }
//  If CreateProcess(Nil, '"'+exe+'" '+param, Nil, Nil, False,
//                0, Nil, Nil, StartInfo,ProcessInfo) Then
//  Begin
//    { L'application est bien lancée, on va en attendre la fin }
//    { ProcessInfo.hProcess contient le handle du process principal de l'application }
//    Fin:=False;
//    Repeat
//      { On attend la fin de l'application }
//      Case WaitForSingleObject(ProcessInfo.hProcess, 200)Of
//        WAIT_OBJECT_0 :Fin:=True; { L'application est terminée, on sort }
//        WAIT_TIMEOUT  :;          { elle n'est pas terminée, on continue d'attendre }
//      End;
//      { Mise à jour de la fenêtre pour que l'application ne paraisse pas bloquée. }
//      Application.ProcessMessages;
//    Until Fin;
//    { C'est fini }
//    ShowMessage('Terminé');
//  End
//  Else RaiseLastOSError;
//  result := fin;
End;

procedure TGestionSauvegarde.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if ((Shift = [ssCtrl])and(Key=67)) then
 begin
  E.ControleDuDossier:=false;
  Application.MessageBox(Pchar('Contrôle du dossier désactivé !'),'Attention',MB_ICONEXCLAMATION );
//  MessageDlg('Contrôle du dossier désactivé !', mtWarning, [mbOK], 0);
 end;
end;

function GetOSInfo: TRetour;
var
  NTBres, BRes: Boolean;
  OSVI: TOSVERSIONINFO;
  OSVI_NT: TOSVERSIONINFOEX;
  tmpStr: string;
  dwOSMajorVersion, dwOSMinorVersion,
  dwSpMajorVersion, dwSpMinorVersion,
  pdwReturnedProductType : DWORD;
begin
  Result.VersionOs:='';
  result.retour := false;//'Error';
  NTBRes := FALSE;
  try
    OSVI_NT.dwOSVersionInfoSize := SizeOf(TOSVERSIONINFOEX);
    NTBRes := GetVersionExA(OSVI_NT);
    OSVI.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
    BRes := GetVersionEx(OSVI);
  except
    OSVI.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
    BRes := GetVersionEx(OSVI);
  end;
  if (not BRes) and (not NTBres) then
    Exit;
  Move( OSVI, OSVI_NT, SizeOf(TOSVersionInfo) );

  case OSVI_NT.dwPlatformId of
     VER_PLATFORM_WIN32_NT:
       begin
         if OSVI_NT.dwMajorVersion <= 4 then
         begin
           Result.VersionOs := 'Windows NT';//'Windows NT ';
           result.retour := false;//
         end;
         if (OSVI_NT.dwMajorVersion = 5) and (OSVI_NT.dwMinorVersion = 0) then
         begin
           Result.VersionOs := 'Windows 2000 ';
           result.retour := false;// Result := true;
         end;
         if  (OSVI_NT.dwMajorVersion = 5) and (OSVI_NT.dwMinorVersion = 1) then
         begin
           Result.VersionOs :='Windows XP ';
           result.retour := true;
         end;
         if (OSVI_NT.dwMajorVersion = 6) and (OSVI_NT.dwMinorVersion = 0) then
         begin
         begin
           Result.VersionOs := 'Windows Vista ';
           result.retour := false;
         end;
         if (OSVI_NT.dwMajorVersion > 6)then
         begin
           Result.VersionOs := 'Windows supérieure à Vista ';
           result.retour := false;
         end;
           if Assigned(GetProductInfo) then
           begin
             GetProductInfo( dwOSMajorVersion, dwOSMinorVersion,
                             dwSpMajorVersion, dwSpMinorVersion,
                             pdwReturnedProductType );
             case pdwReturnedProductType of
               PRODUCT_BUSINESS:
                 tmpStr := 'Business Edition';
               PRODUCT_BUSINESS_N:
                 tmpStr := 'Business Edition';
               PRODUCT_CLUSTER_SERVER:
                 tmpStr := 'Cluster Server Edition';
               PRODUCT_DATACENTER_SERVER:
                 tmpStr := 'Server Datacenter Edition (full installation)';
               PRODUCT_DATACENTER_SERVER_CORE:
                 tmpStr := 'Server Datacenter Edition (core installation)';
               PRODUCT_ENTERPRISE:
                 tmpStr := 'Enterprise Edition';
               PRODUCT_ENTERPRISE_N:
                 tmpStr := 'Enterprise Edition';
               PRODUCT_ENTERPRISE_SERVER:
                 tmpStr := 'Server Enterprise Edition (full installation)';
               PRODUCT_ENTERPRISE_SERVER_CORE:
                 tmpStr := 'Server Enterprise Edition (core installation)';
               PRODUCT_ENTERPRISE_SERVER_IA64:
                 tmpStr := 'Server Enterprise Edition for Itanium-based Systems';
               PRODUCT_HOME_BASIC:
                 tmpStr := 'Home Basic Edition';
               PRODUCT_HOME_BASIC_N:
                 tmpStr := 'Home Basic Edition';
               PRODUCT_HOME_PREMIUM:
                 tmpStr := 'Home Premium Edition';
               PRODUCT_HOME_PREMIUM_N:
                 tmpStr := 'Home Premium Edition';
               PRODUCT_HOME_SERVER:
                 tmpStr := 'Home Server Edition';
               PRODUCT_SERVER_FOR_SMALLBUSINESS:
                 tmpStr := 'Server for Small Business Edition';
               PRODUCT_SMALLBUSINESS_SERVER:
                 tmpStr := 'Small Business Server';
               PRODUCT_SMALLBUSINESS_SERVER_PREMIUM:
                 tmpStr := 'Small Business Server Premium Edition';
               PRODUCT_STANDARD_SERVER:
                 tmpStr := 'Server Standard Edition (full installation)';
               PRODUCT_STANDARD_SERVER_CORE:
                 tmpStr := 'Server Standard Edition (core installation)';
               PRODUCT_STARTER:
                 tmpStr := 'Starter Edition';
               PRODUCT_STORAGE_ENTERPRISE_SERVER:
                 tmpStr := 'Storage Server Enterprise Edition';
               PRODUCT_STORAGE_EXPRESS_SERVER:
                 tmpStr := 'Storage Server Express Edition';
               PRODUCT_STORAGE_STANDARD_SERVER:
                 tmpStr := 'Storage Server Standard Edition';
               PRODUCT_STORAGE_WORKGROUP_SERVER:
                 tmpStr := 'Storage Server Workgroup Edition';
               PRODUCT_UNDEFINED:
                 tmpStr := 'An unknown product';
               PRODUCT_ULTIMATE:
                 tmpStr := 'Ultimate Edition';
               PRODUCT_ULTIMATE_N:
                 tmpStr := 'Ultimate Edition';
               PRODUCT_WEB_SERVER:
                 tmpStr := 'Web Server Edition';
               PRODUCT_UNLICENSED:
                 tmpStr := 'Unlicensed product'
             else
               tmpStr := '';
             end;{ pdwReturnedProductType }
             Result.VersionOs := Result.VersionOs + tmpStr;
             NTBRes := FALSE;
           end;{ GetProductInfo<>NIL }
         end;{ Vista }
         if NTBres then
         begin
           if OSVI_NT.wProductType = VER_NT_WORKSTATION then
           begin
             if OSVI_NT.wProductType = VER_NT_WORKSTATION then
             begin
               case OSVI_NT.wSuiteMask of
                 512: Result.VersionOs := Result.VersionOs + 'Personal';
                 768: Result.VersionOs := Result.VersionOs + 'Home Premium';
               else
                 Result.VersionOs := Result.VersionOs + 'Professional';
               end;
             end
             else if OSVI_NT.wProductType = VER_NT_SERVER then
             begin
               if OSVI_NT.wSuiteMask = VER_SUITE_DATACENTER then
                 Result.VersionOs := Result.VersionOs + 'DataCenter Server'
               else if OSVI_NT.wSuiteMask = VER_SUITE_ENTERPRISE then
                 Result.VersionOs :=  Result.VersionOs + 'Advanced Server'
               else
                 Result.VersionOs := Result.VersionOs + 'Server';
             end;
           end{ wProductType=VER_NT_WORKSTATION }
           else
           begin
             with TRegistry.Create do
               try
                 RootKey := HKEY_LOCAL_MACHINE;
                 if OpenKeyReadOnly('SYSTEM\CurrentControlSet\Control\ProductOptions') then
                   try
                     tmpStr := UpperCase(ReadString('ProductType'));
                     if tmpStr = 'WINNT' then
                       Result.VersionOs := Result.VersionOs + 'Workstation';
                     if tmpStr = 'SERVERNT' then
                       Result.VersionOs := Result.VersionOs + 'Server';
                   finally
                     CloseKey;
                   end;
               finally
                 Free;
               end;
             end;{ wProductType<>VER_NT_WORKSTATION }
           end;{ NTBRes }
         end;{ VER_PLATFORM_WIN32_NT }
     VER_PLATFORM_WIN32_WINDOWS:
       begin
         if (OSVI.dwMajorVersion = 4) and (OSVI.dwMinorVersion = 0) then
         begin
         begin
           Result.VersionOs :='Windows 95 ';
           result.retour := false;
         end;
           if OSVI.szCSDVersion[1] = 'C' then
             Result.VersionOs := Result.VersionOs + 'OSR2';
         end;
         if (OSVI.dwMajorVersion = 4) and (OSVI.dwMinorVersion = 10) then
         begin
           Result.VersionOs :='Windows 98 ';
           result.retour := false;  ;

           if OSVI.szCSDVersion[1] = 'A' then
             Result.VersionOs := Result.VersionOs + 'SE';
         end;
         if (OSVI.dwMajorVersion = 4) and (OSVI.dwMinorVersion = 90) then
         begin
           Result.VersionOs :='Windows Me ';
           result.retour := false;  ;
         end;

       end;{ VER_PLATFORM_WIN32_WINDOWS }
     VER_PLATFORM_WIN32s:
         begin
           Result.VersionOs :='Microsoft Win32s ';
           result.retour := false;  ;
         end;

  else
         begin
           Result.VersionOs :='Unknown'; ;
           result.retour := false;  ;
         end;

  end;{ OSVI_NT.dwPlatformId }
   
end;{ GetOSInfo }



function ShellExecuteAndWait(
                             vHandle     : HWND;
                             vOperation  : string;
                             vFichier    : string;
                             vParametres : string;
                             vRepertoire : string;
                             vAffichage  : Integer;
                             vDuree      : DWORD
                            ) : Cardinal;
var
  vSEInfo   : TShellExecuteInfo;
begin
  //Initialisation de la structure ShellExecuteInfo
  ZeroMemory(@vSEInfo, SizeOf(vSEInfo));

  //Remplissage de la structure ShellExecuteInfo
  vSEInfo.cbSize       := SizeOf(vSEInfo);
  vSEInfo.fMask        := SEE_MASK_NOCLOSEPROCESS;
  vSEInfo.Wnd          := vHandle;
  vSEInfo.lpVerb       := PAnsiChar(vOperation);
  vSEInfo.lpFile       := PAnsiChar(vFichier);
  vSEInfo.lpParameters := PAnsiChar(vParametres);
  vSEInfo.lpDirectory  := PAnsiChar(vRepertoire);
  vSEInfo.nShow        := vAffichage;

  //Execution
  if ShellExecuteEx(@vSEInfo) then
  begin
    //ShellExecuteEx OK : attendre la fin du process
    Result := WaitForSingleObject(vSEInfo.hProcess, vDuree);
  end
  else
  begin
    //ShellExecuteEx KO : renvoyer l'erreur
    Result := GetLastError();
  end;
end;

procedure TGestionSauvegarde.EnvoieFichierdelogdesrestaurations1Click(
  Sender: TObject);
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
  end;
end;

end.
