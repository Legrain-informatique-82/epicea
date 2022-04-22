unit RestD3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  //ZipMstr,
  ComCtrls,
  Lib_Chaine,
  LibRessourceString,
  shellapi,
  FileUtil,
  //LibFichRep,
  CopyFile, MyBackup, RxDUALLIST, ZipMstr19;


type



  TRest = class(TForm)
    BtnRestaure: TButton;
    BtnAnnuler: TButton;
    RETitre: TRichEdit;
    MyBackup2: TMyBackup;
    RxDualListDialog1: TRxDualListDialog;
    ZipMaster1: TZipMaster19;
    procedure BtnRestaureClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ZipMaster2DirUpdate(Sender: TObject);
    procedure ZipMaster2Message(Sender: TObject; ErrCode: Integer;
      Message: String);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
    ListeNomDeDossier,ListeRepertoireCourantDestination,ListeFichierARestaurer:TStringList;
    ListeParamRestauration,ListeParametreIn:TStringList;
    AControler:Boolean;
    Nbparametres:integer;
    EnDLL:boolean;
  end;


var
  Rest: TRest;
  NomDossier,RepDossier,FichierZip,Rep_RepDossier:String;
  RepertoireDEstinationTmp,NomFichierSauvegarde:String;
  function EffaceDossier2(Dossier: string): Boolean;
  Function ListTypeLecteur(TypeLecteur:integer):TStringList;
  function CopyAllFiles(sFrom, sTo: string; Protect: boolean): boolean;

implementation

uses R2_ListeFic, DialogEx;

{$R *.DFM}

procedure TRest.BtnRestaureClick(Sender: TObject);
var
ListLecteur,ListeFic:TStringList;
ListeFichierDossier, ListeFichierExercice:TStringList;
ListeFichierZipDossier, ListeFichierZipExercice:TStringList;
NomDossier, NomDossierEpi, CheminSansLecteur:string;
i,j,k,l,nbExo,NbFichier:integer;
 db : TMsgDlgParams;
 rang:integer;
 entry:TZMDirEntry;
begin
//if GetOSInfo.retour then
//begin
try //finally
//ShowMessage('je passe par la DLL');
    screen.Cursor := crHourGlass;
    ListeFichierExercice:= TStringList.Create;
    ListeFichierExercice.Clear;
    ListeFichierExercice.CaseSensitive := false;
    ListeFichierExercice.Sorted := true;

    ListeFichierDossier:=TStringList.Create;
    ListeFichierDossier.Clear;
    ListeFichierDossier.CaseSensitive := false;
    ListeFichierDossier.Sorted:=true;

    ListeFichierZipExercice:= TStringList.Create;
    ListeFichierZipExercice.Clear;
    ListeFichierZipExercice.CaseSensitive := false;
    ListeFichierZipExercice.Sorted := true;
    ListeFichierZipExercice.Duplicates :=dupAccept;

    ListeFichierZipDossier:=TStringList.Create;
    ListeFichierZipDossier.Clear;
    ListeFichierZipDossier.CaseSensitive := false;
    ListeFichierZipDossier.Sorted := true;
       InitMsgDlgParams(db);
if AControler then
 begin
  ListeFichierExercice.LoadFromFile(IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName))+'BkListExercice.bk');
  ListeFichierDossier.LoadFromFile(IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName))+'BkListDossier.bk');
 end;
    try //except
   // showmessage('avant param�tres : '+IntToStr(ParamCount));

       // for i:=0 to ListeParamRestauration.Count-1 do
        //for i:=0 to ListeParamRestauration.Count-1 do
         begin
              // section de recopie
              ListLecteur:=TStringList.Create;
              ListLecteur.Clear;
              ListLecteur:=ListTypeLecteur(DRIVE_REMOVABLE);
              NomFichierSauvegarde := ExtractFileName(ListeFichierARestaurer.Strings[i]);
              //showmessage('NomFichierSauvegarde : '+NomFichierSauvegarde);
              
              // Si le fichier se trouve sur un disque amovible
              // on le restaure directment dans le repertoire
              // de destination, c'est � dire la liste ListeRepertoireCourantDestination
              if ListLecteur.IndexOf(ExtractFileDrive(ListeFichierARestaurer.Strings[i])+'\') <> -1 then
               begin

                MyBackup2.DrivePath :=ExtractFileDrive(ListeFichierARestaurer.Strings[i])+'\';
                MyBackup2.FilesPath :=ListeRepertoireCourantDestination.Strings[i];
                CheminSansLecteur := IncludeTrailingPathDelimiter(ExtractFilePath(ListeFichierARestaurer.Strings[i]))+ '*.*';
                delete(CheminSansLecteur,1,3);
                MyBackup2.Filter := CheminSansLecteur;
                MyBackup2.FilesRestored.Clear;
                MyBackup2.FilesRestored.Add(ListeFichierARestaurer.Strings[i]);
                //showmessage('avant DiskInDrive ');
                While not MyBackup2.DiskInDrive(ListeFichierARestaurer.Strings[i][1]) do
                 begin
                 if Application.MessageBox(Pchar('Vous devez ins�rer une disquette dans le lecteur : '+ExtractFileDrive(ListeFichierARestaurer.Strings[i])),'Attention',MB_ICONWARNING +MB_YESNOCANCEL+MB_DEFBUTTON1)=mrcancel then
                 //if MessageDlg('Vous devez ins�rer une disquette dans le lecteur : '+ExtractFileDrive(ListeFichierARestaurer.Strings[i]), mtWarning, [mbOK,mbCancel], 0) = mrCancel then
                  begin
                   abort;
                  end;
                 end;
               try

                MyBackup2.Restore;
                //showmessage('apr�s Restore');
               except
               //showmessage('avant abort');
                abort;
               end;
               end
               else
                // Si le fichier se trouve dans un r�pertoire autre que sur un disque amovible
                // On le recopie dans le repertoire
                // de destination, c'est � dire la liste ListeRepertoireCourantDestination
               begin
                if CopyAllFiles(ListeFichierARestaurer.Strings[i],ListeRepertoireCourantDestination.Strings[i]+'\'+NomFichierSauvegarde,False) then
                 else
                  begin
                   Application.MessageBox(Pchar('Erreur survenue lors de la copie du fichier !'),'Attention',MB_ICONERROR);
                   //MessageDlg('Erreur survenue lors de la copie du fichier !', mtError, [mbOK], 0);
                   abort;
                  end;
               end;
        ZipMaster1.Verbose := true;

        ZipMaster1.ExtrOptions := ZipMaster1.ExtrOptions+[ZipMstr19.ExtrOverWrite]+[ZipMstr19.ExtrDirNames];
        //ZipMaster1.ExtrOptions := ZipMaster1.ExtrOptions+[ExtrOverWrite]+[ExtrTest]+[ExtrDirNames];
        ZipMaster1.ExtrBaseDir := ListeRepertoireCourantDestination.Strings[i];
        ZipMaster1.ZipFilename :=ListeRepertoireCourantDestination.Strings[i]+'\'+NomFichierSauvegarde;
        for j:=1 to ZipMaster1.Count do
            begin
               rang:= j-1;
               //with ZipDirEntry(ZipMaster1.ZipContents[j-1]^) do
               entry:=ZipMaster1.DirEntry[rang];
               with entry do
               begin
                  if (entry<>nil)and(str_fini_par(upperCase(FileName),uppercase('.db'))) then
                   begin

                    if ListeFichierDossier.IndexOf(upperCase(copy(FileName,LastDelimiter(PathDelim,FileName)+1,length(Filename)))) <> - 1 then
                     begin
                       ListeFichierZipDossier.Add(upperCase(copy(FileName,LastDelimiter(PathDelim,FileName)+1,length(Filename))));
                     end;

                    if ListeFichierExercice.IndexOf(upperCase(copy(FileName,LastDelimiter(PathDelim,FileName)+1,length(Filename)))) <> - 1 then
                     begin
                       ListeFichierZipExercice.Add(upperCase(copy(FileName,LastDelimiter(PathDelim,FileName)+1,length(Filename))));
                     end;
                   end;//fin si entry<>nil

                  //if str_fini_par(upperCase(FileName),upperCase('.epi')) then
                    if (entry<>nil)and(str_fini_par(upperCase(entry.FileName),uppercase('.epi'))) then
                        begin
                          NomDossier:=copy(FileName,1,LastDelimiter(PathDelim,FileName)-1);
                          NomDossierEpi:=copy(FileName,LastDelimiter(PathDelim,FileName)+1,LastDelimiter('.',FileName)-LastDelimiter(PathDelim,FileName)-1);
                           if (uppercase(ListeNomDeDossier.Strings[i]) <> uppercase(NomDossierEpi)) then
                            begin
                              Application.MessageBox(Pchar('Attention, vous essayer de restaurer '+
                                         #13+#10+
                                         ''+
                                         #13+#10+
                                         'le dossier : '+
                                         NomDossierEpi+
                                         #13+#10+#13+#10+
                                         'sur le dossier : '+
                                         ListeNomDeDossier.Strings[i]+
                                         AppelerServiceMaintenance),'Attention',MB_ICONERROR);

                              abort;
                            end;
                        end;//fin si entry<>nil
                   end;//fin du with entry
            end; // end for

      if AControler then
       begin
        if not ListeFichierDossier.Equals(ListeFichierZipDossier) then
                    begin
                      Application.MessageBox(Pchar('Attention, la sauvegarde du dossier semble incorrecte !'+
                                 AppelerServiceMaintenance),'Attention, Erreur de Restauration',MB_ICONERROR);
                      ListeVLE.SGList.Cols[0].Assign(ListeFichierDossier);
                      for k:=0 to ListeFichierDossier.Count -1 do
                       begin
                        l:=ListeFichierZipDossier.IndexOf(ListeFichierDossier.Strings[k]);
                        if l <> - 1 then
                         ListeVLE.SGList.Cols[1].Strings[k] :=ListeFichierDossier.Strings[k]
                         else
                         ListeVLE.SGList.Cols[1].Strings[k] :='????????????????';
                       end;
                      ListeVLE.Caption := 'Liste des fichiers dossier de la sauvegarde.';
                      ListeVLE.ShowModal;
                      abort;
                    end;

        if ((ListeFichierZipExercice.Count mod ListeFichierExercice.Count) <> 0) then
                    begin
                      nbExo :=(ListeFichierZipExercice.Count div ListeFichierExercice.Count) + 1;
                      Application.MessageBox(Pchar('Attention, la sauvegarde d''un de vos exercice semble incorrecte !'+
                                 AppelerServiceMaintenance),'Attention, Erreur de Restauration',MB_ICONERROR);
                      ListeVLE.SGList.Cols[0].Assign(ListeFichierExercice);
                      for k:=0 to ListeFichierExercice.Count -1 do
                       begin
                        NbFichier:=0;
                        l:=ListeFichierZipExercice.IndexOf(ListeFichierExercice.Strings[k]);
                        while l <> -1 do
                         begin
                          ListeFichierZipExercice.Delete(l);
                          inc(NbFichier);
                          l:=ListeFichierZipExercice.IndexOf(ListeFichierExercice.Strings[k]);
                         end;
                        if NbFichier = nbExo then
                         ListeVLE.SGList.Cols[1].Strings[k] :=ListeFichierExercice.Strings[k]
                         else
                         ListeVLE.SGList.Cols[1].Strings[k] :='????????????????';
                       end;
                      ListeVLE.Caption := 'Liste des fichiers exercice de la sauvegarde.';
                      ListeVLE.ShowModal;
                      abort;
                    end;
        end;

//        RenommeDossier(IncludeTrailingPathDelimiter(RepDossier)+NomDossier,IncludeTrailingPathDelimiter(RepDossier)+NomDossier+'_TMP');
//        showmessage(IncludeTrailingPathDelimiter(RepDossier)+NomDossier);
//        showmessage(IncludeTrailingPathDelimiter(RepDossier)+NomDossier+'_TMP');
        EffaceDossier2(IncludeTrailingPathDelimiter(RepDossier)+NomDossier);
       // showmessage('Avant extract');
        ZipMaster1.Extract;
       // showmessage('Apr�s extract');
        if ZipMaster1.SuccessCnt = ZipMaster1.Count then
         Application.MessageBox(Pchar('Fin de la restauration de : '+
                     NomFichierSauvegarde+
                     '.'+
                     RetourChariotDouble+
                     Str_SingulierToPluriel(ZipMaster1.SuccessCnt,'fichier')+
                     ' / '+
                     Str_SingulierToPluriel(ZipMaster1.Count,'fichier')+
                     ' restaur�s avec succ�s !'+
                     RetourChariotDouble+
                     'Manque :'+Str_SingulierToPluriel(ZipMaster1.Count-ZipMaster1.SuccessCnt,'fichier')+
                     RetourChariotDouble+
                     'Source de la sauvegarde : '+
                     ListeFichierARestaurer.Strings[i]+
                     RetourChariotDouble+
                     'R�pertoire destination : '+
                     ListeRepertoireCourantDestination.Strings[i]+
                     '\'+
                     ListeNomDeDossier.Strings[i]),'Restauration r�ussie',MB_ICONINFORMATION)

         else
         begin
    db.lpszText:= Pansichar('Attention !!!'
                         +RetourChariotDouble+'Erreur survenue lors de la restauration de : '+
                         NomFichierSauvegarde+
                         '.'+
                         RetourChariotDouble+
                         '-------------------------------------------------------------------'+RetourChariotDouble+
                         Str_SingulierToPluriel(ZipMaster1.SuccessCnt,'fichier(s)')+
                         ' restaur�(s)  / '+
                         Str_SingulierToPluriel(ZipMaster1.Count,'fichier(s)')+
                         ' !'+
                         RetourChariotDouble+
                         '-------------------------------------------------------------------'+RetourChariotDouble+
                         'il Manque :'+Str_SingulierToPluriel(ZipMaster1.Count-ZipMaster1.SuccessCnt,'fichier(s)'));
    db.CheckBox        := false;
    db.lpszCaption     := Pansichar('Attention, Erreur de restauration !!!');
    db.DlgType         :=mtError;
    db.DlgBtn          := [mbCust1];
    db.DefaultBtn      := mbCust1;
    db.CustBtnText[mbCust1] := 'Abandon de la restauration';
         MsgDlgBox(db);

          Application.MessageBox(Pchar('Attention,'+
                         RetourChariotDouble+
                         '-------------------------------------------------------------------'+RetourChariotDouble+
          'La restauration de votre sauvegarde n''a pas fonctionn�.'+
          RetourChariotsimple+
          'Si le probl�me persiste, appelez le service de maintenance'),'Attention, Abandon de la restauration !!!',MB_ICONSTOP);
         end;

        if(FileExists(ListeRepertoireCourantDestination.Strings[i]+'\'+NomFichierSauvegarde))then DeleteFile(ListeRepertoireCourantDestination.Strings[i]+'\'+NomFichierSauvegarde);
        if(FileExists(ListeRepertoireCourantDestination.Strings[i]+'\'+MyBackup2.InfosFileName))then  DeleteFile(ListeRepertoireCourantDestination.Strings[i]+'\'+MyBackup2.InfosFileName);

         end;//
     //screen.Cursor := crDefault;
     //showmessage('modalResult:=MROk');
  if EnDll then
   ModalResult:=MROk
   else
   self.Close;

     except
      //showmessage('modalResult:=mrAbort') ;
      screen.Cursor := crDefault;

   if EnDll then
   ModalResult:=mrAbort
   else
   self.Close;
       //self.Close;
     end;
finally
 //screen.Cursor := crDefault;
end;
//end
//else
//  Application.MessageBox(Pchar('Cette fonctionnalit� n''est pas compatible avec votre version de Windows.'+
//  retourChariotsimple+'Vous devez vous servir de l''outil de restauration externe'+
//  retourChariotDouble+'---------------------------------------------------------'+retourChariotDouble+
//  retourChariotSimple+'"Restauration Epicea.exe"'+
//  retourChariotDouble+'---------------------------------------------------------'+retourChariotDouble+
//  retourChariotSimple+'qui se trouve sur votre bureau.'),'Attention',MB_ICONWARNING);
end;

procedure TRest.BtnAnnulerClick(Sender: TObject);
begin
ModalResult:=mrCancel;
//self.close;
end;

procedure TRest.FormCreate(Sender: TObject);
//var
//i:integer;
begin
//AControler:=true;
//ListeNomDeDossier:=TStringList.Create;
//ListeNomDeDossier.Clear;
//
//ListeRepertoireCourantDestination:=TStringList.Create;
//ListeRepertoireCourantDestination.Clear;
//
//ListeFichierARestaurer:=TStringList.Create;
//ListeFichierARestaurer.Clear;
//
//ListeParamRestauration:=TStringList.Create;
//ListeParamRestauration.Clear;
//
//RepertoireDEstinationTmp := ExtractFilePath(Application.ExeName)+'RestoreTmp';
//if not DirectoryExists(RepertoireDEstinationTmp) then ForceDirectories(RepertoireDEstinationTmp);
////if not DirectoryExists(RepDestination) then ForceDirectories(RepDestination);
//if Nbparametres = 1 then
// begin
//  if FileExists(ListeParametreIn.Strings[0]) then
//       ListeParamRestauration.LoadFromFile(ListeParametreIn.Strings[0])
//       else
//        begin
//         Application.MessageBox(Pchar('Le nom du fichier n''est pas correct !'),'Attention',MB_ICONERROR);
////         MessageDlg('Le nom du fichier n''est pas correct !', mtError, [mbOK], 0);
//         Application.Terminate;
//         abort;
//        end;
//  For i:=0 to ListeParamRestauration.Count - 1 do
//   begin
//
//    ListeNomDeDossier.Add(str_getstringelement(ListeParamRestauration.Strings[i],1,';'));
//    NomDossier:=str_getstringelement(ListeParamRestauration.Strings[i],1,';');
//    if Str_Empty(ListeNomDeDossier.Strings[i]) then
//     begin
//     Application.MessageBox(Pchar('Le format du fichier n''est pas correct !'),'Attention',MB_ICONERROR);
////      MessageDlg('Le format du fichier n''est pas correct !', mtError, [mbOK], 0);
//      Application.Terminate;
//     end;
//
//    ListeRepertoireCourantDestination.Add(str_getstringelement(ListeParamRestauration.Strings[i],2,';'));
//    RepDossier:=str_getstringelement(ListeParamRestauration.Strings[i],2,';');
//    if Str_Empty(ListeRepertoireCourantDestination.Strings[i]) then
//     begin
//     Application.MessageBox(Pchar('Le format du fichier n''est pas correct !'),'Attention',MB_ICONERROR);
////      MessageDlg('Le format du fichier n''est pas correct !', mtError, [mbOK], 0);
//      Application.Terminate;
//     end;
//
//    ListeFichierARestaurer.Add(str_getstringelement(ListeParamRestauration.Strings[i],3,';'));
//    FichierZip:=str_getstringelement(ListeParamRestauration.Strings[i],3,';');
//    if Str_Empty(ListeFichierARestaurer.Strings[i]) then
//     begin
//      Application.MessageBox(Pchar('Le format du fichier n''est pas correct !'),'Attention',MB_ICONERROR);
////      MessageDlg('Le format du fichier n''est pas correct !', mtError, [mbOK], 0);
//      Application.Terminate;
//     end;
//
////    ListeRepertoireDEstination2.Add(str_getstringelement(ListeParamSauvegarde.Strings[i],4,';'));
////    ListeEMail.Add(str_getstringelement(ListeParamSauvegarde.Strings[i],5,';'));
//   end;
//end
//else
// begin
//    BtnRestaure.Enabled := (Nbparametres >= 3);
//    if Nbparametres > 0 then NomDossier:=ListeParametreIn.Strings[0];
//    if Nbparametres > 1 then RepDossier:=ListeParametreIn.Strings[1];
//    if Nbparametres > 2 then FichierZip:=ListeParametreIn.Strings[2];
//
//    ListeNomDeDossier.Add(ListeParametreIn.Strings[0]);
//    NomDossier:=ListeParametreIn.Strings[0];
//    if Str_Empty(ListeNomDeDossier.Strings[0]) then
//     begin
//     Application.MessageBox(Pchar('Le format du fichier n''est pas correct !'),'Attention',MB_ICONERROR);
////      MessageDlg('Le format du fichier n''est pas correct !', mtError, [mbOK], 0);
//      Application.Terminate;
//     end;
//
//    ListeRepertoireCourantDestination.Add(ListeParametreIn.Strings[1]);
//    RepDossier:=ListeParametreIn.Strings[1];
//    if Str_Empty(ListeRepertoireCourantDestination.Strings[0]) then
//     begin
//     Application.MessageBox(Pchar('Le format du fichier n''est pas correct !'),'Attention',MB_ICONERROR);
////      MessageDlg('Le format du fichier n''est pas correct !', mtError, [mbOK], 0);
//      Application.Terminate;
//     end;
//
//    ListeFichierARestaurer.Add(ListeParametreIn.Strings[2]);
//    FichierZip:=ListeParametreIn.Strings[2];
//    if Str_Empty(ListeFichierARestaurer.Strings[0]) then
//     begin
//      Application.MessageBox(Pchar('Le format du fichier n''est pas correct !'),'Attention',MB_ICONERROR);
////      MessageDlg('Le format du fichier n''est pas correct !', mtError, [mbOK], 0);
//      Application.Terminate;
//     end;
// end;
//Rep_RepDossier := copy(RepDossier,1,LastDelimiter('\',RepDossier));
//self.Caption := 'Restauration - Dossier : '+NomDossier;
//RETitre.Lines.Clear;
////RETitre.DefAttributes.Color:=clRed;
////RETitre.DefAttributes.Style:=[fsbold,fsunderline];
////RETitre.DefAttributes.Color:=clWindowText;
////RETitre.DefAttributes.Style:=[fsbold];
//RETitre.Lines.Add('');
//RETitre.Lines.Add('ATTENTION !');
//RETitre.Lines.Add('');
//RETitre.Lines.Add('Vous �tes sur le point de restaurer la sauvegarde : ');
//RETitre.Lines.Add('');
//RETitre.Lines.Add(FichierZip);
//RETitre.Lines.Add('');
//RETitre.Lines.Add('Sur le dossier : ');
//RETitre.SelStart:=RETitre.CaretPos.x + length(RETitre.Lines[RETitre.Lines.Count-1]);
////RETitre.DefAttributes.Color:=clWindowText;
////RETitre.DefAttributes.Style:=[fsbold];
//RETitre.Lines[RETitre.Lines.Count-1] := RETitre.Lines[RETitre.Lines.Count-1] + NomDossier;
////RETitre.SelLength:=length(NomDossier);
////RETitre.SelAttributes.Color:=clRed;
////RETitre.SelAttributes.Style:=[fsbold,fsunderline];
//////RETitre.SelAttributes.Color:=clRed;
//////RETitre.SelAttributes.Style:=[fsbold,fsunderline];
////RETitre.SelLength:=0;
////
////RETitre.SelAttributes.Color:=clWindowText;
////RETitre.SelAttributes.Style:=[];
//RETitre.Lines.Add('');
//RETitre.Lines.Add('dans : ');
//RETitre.Lines.Add('');
//RETitre.Lines.Add(IncludeTrailingPathDelimiter(RepDossier)+NomDossier);
////RETitre.Lines.SaveToFile('c:\test2.txt');
end;

procedure TRest.ZipMaster2DirUpdate(Sender: TObject);
begin
//showmessage('ZipMaster1DirUpdate');
//C:\Js\Epicea-2

end;

procedure TRest.ZipMaster2Message(Sender: TObject; ErrCode: Integer;
  Message: String);
begin
// Ne pas activer pour l'instant
//if message = 'no error in '+ZipMaster1.ZipFilename then
// begin
////  if MessageDlg(ExtractFilePath(Application.ExeName)+'Sauvegarde\'+NomDossier+' vers : '+Rep_RepDossier,mtInformation,[mbYes,mbNo],0)= mrYes then
//if CopyAllFilesEx(RepDossier,ExtractFilePath(Application.ExeName)+'Sauvegarde\'+NomDossier+'_R','Pr�paration de la sauvegarde ...',false) then
// begin
//  if CopyAllFilesEx(ExtractFilePath(Application.ExeName)+'Sauvegarde\'+NomDossier,Rep_RepDossier,'Restauration en cours ...',false) then
//  MessageDlg('Restauration termin�e !',mtInformation,[mbOk],0)
//  else MessageDlg('Restauration abandonn�e !',mtError,[mbOk],0);
////    ShowMessage('Restauration termin�e !');
// end
// else MessageDlg('Restauration abandonn�e lors de la pr�paration !',mtError,[mbOk],0);
// Application.Terminate;
// end;
//
////  showmessage(message+' '+Inttostr(ErrCode));
end;

procedure TRest.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Shift = [ssCtrl] then
 begin
  AControler:=false;
  Application.MessageBox(Pchar('Contr�le coh�rence sauvegarde d�sactiv� !'),'D�sactivation du contr�le de coh�rence',MB_ICONWARNING);
//  MessageDlg('Contr�le coh�rence sauvegarde d�sactiv� !', mtWarning, [mbOK], 0);
 end;
end;



function CopyAllFiles(sFrom, sTo: string; Protect: boolean): boolean;
{ Copies files or directory to another directory. }
var
  F: TShFileOpStruct;
  ResultVal: integer;
  tmp1, tmp2: string;
begin
  FillChar(F, SizeOf(F), #0);
  Screen.Cursor := crHourGlass;
  try
    F.Wnd   := 0;
    F.wFunc := FO_COPY;
    { Add an extra null char }
    tmp1    := sFrom + #0;
    tmp2    := sTo + #0;
    F.pFrom := PChar(tmp1);
    F.pTo   := PChar(tmp2);
    F.lpszProgressTitle:=PChar('Sauvegarde du dossier en cours ...');
    if Protect then
      F.fFlags := FOF_RENAMEONCOLLISION or FOF_SIMPLEPROGRESS
 //     F.fFlags := FOF_SIMPLEPROGRESS or FOF_NOCONFIRMATION
    else
      F.fFlags :=FOF_SIMPLEPROGRESS or FOF_NOCONFIRMMKDIR or FOF_NOCONFIRMATION;
//      F.fFlags :=FOF_SIMPLEPROGRESS or FOF_FILESONLY or FOF_NOCONFIRMMKDIR or FOF_NOCONFIRMATION;

    F.fAnyOperationsAborted := False;
    F.hNameMappings := nil;
    Resultval := ShFileOperation(F);
    Result := (ResultVal = 0);
  finally
    Screen.Cursor := crDefault;
  end;
end;


Function ListTypeLecteur(TypeLecteur:integer):TStringList;
var
i:integer;
Nom:PChar;
Begin
result:=TStringList.create;
for i:=0 to 31 do
  begin
	Nom:=Pchar(char(i+65)+':\');
   case GetDriveType(Nom) of
      DRIVE_FIXED: begin
                  if DRIVE_FIXED = TypeLecteur then Result.Add(nom);
                  end;
      DRIVE_REMOTE:begin
                  if DRIVE_REMOTE = TypeLecteur then Result.Add(nom);
                  end;
      DRIVE_REMOVABLE:begin
                  if DRIVE_REMOVABLE = TypeLecteur then Result.Add(nom);
                  end;
      DRIVE_CDROM:begin
                  if DRIVE_CDROM = TypeLecteur then Result.Add(nom);
                  end;
      DRIVE_RAMDISK:begin
                  if DRIVE_RAMDISK = TypeLecteur then Result.Add(nom);
                  end;
   end;
  end;
End;


function EffaceDossier2(Dossier: string): Boolean;
Begin
 cleardir(Dossier,true);
End;


 








procedure TRest.FormShow(Sender: TObject);
var
i:integer;
begin
AControler:=true;
ListeNomDeDossier:=TStringList.Create;
ListeNomDeDossier.Clear;

ListeRepertoireCourantDestination:=TStringList.Create;
ListeRepertoireCourantDestination.Clear;

ListeFichierARestaurer:=TStringList.Create;
ListeFichierARestaurer.Clear;

ListeParamRestauration:=TStringList.Create;
ListeParamRestauration.Clear;

RepertoireDEstinationTmp := ExtractFilePath(Application.ExeName)+'RestoreTmp';
if not DirectoryExists(RepertoireDEstinationTmp) then ForceDirectories(RepertoireDEstinationTmp);
//if not DirectoryExists(RepDestination) then ForceDirectories(RepDestination);
if Nbparametres = 1 then
 begin
  if FileExists(ListeParametreIn.Strings[0]) then
       ListeParamRestauration.LoadFromFile(ListeParametreIn.Strings[0])
       else
        begin
         Application.MessageBox(Pchar('Le nom du fichier n''est pas correct !'),'Attention',MB_ICONERROR);
//         MessageDlg('Le nom du fichier n''est pas correct !', mtError, [mbOK], 0);
         Application.Terminate;
         abort;
        end;
  For i:=0 to ListeParamRestauration.Count - 1 do
   begin

    ListeNomDeDossier.Add(str_getstringelement(ListeParamRestauration.Strings[i],1,';'));
    NomDossier:=str_getstringelement(ListeParamRestauration.Strings[i],1,';');
    if Str_Empty(ListeNomDeDossier.Strings[i]) then
     begin
     Application.MessageBox(Pchar('Le format du fichier n''est pas correct !'),'Attention',MB_ICONERROR);
//      MessageDlg('Le format du fichier n''est pas correct !', mtError, [mbOK], 0);
      Application.Terminate;
     end;

    ListeRepertoireCourantDestination.Add(str_getstringelement(ListeParamRestauration.Strings[i],2,';'));
    RepDossier:=str_getstringelement(ListeParamRestauration.Strings[i],2,';');
    if Str_Empty(ListeRepertoireCourantDestination.Strings[i]) then
     begin
     Application.MessageBox(Pchar('Le format du fichier n''est pas correct !'),'Attention',MB_ICONERROR);
//      MessageDlg('Le format du fichier n''est pas correct !', mtError, [mbOK], 0);
      Application.Terminate;
     end;

    ListeFichierARestaurer.Add(str_getstringelement(ListeParamRestauration.Strings[i],3,';'));
    FichierZip:=str_getstringelement(ListeParamRestauration.Strings[i],3,';');
    if Str_Empty(ListeFichierARestaurer.Strings[i]) then
     begin
      Application.MessageBox(Pchar('Le format du fichier n''est pas correct !'),'Attention',MB_ICONERROR);
//      MessageDlg('Le format du fichier n''est pas correct !', mtError, [mbOK], 0);
      Application.Terminate;
     end;

//    ListeRepertoireDEstination2.Add(str_getstringelement(ListeParamSauvegarde.Strings[i],4,';'));
//    ListeEMail.Add(str_getstringelement(ListeParamSauvegarde.Strings[i],5,';'));
   end;
end
else
 begin
    BtnRestaure.Enabled := (Nbparametres >= 3);
    if Nbparametres > 0 then NomDossier:=ListeParametreIn.Strings[0];
    if Nbparametres > 1 then RepDossier:=ListeParametreIn.Strings[1];
    if Nbparametres > 2 then FichierZip:=ListeParametreIn.Strings[2];

    ListeNomDeDossier.Add(ListeParametreIn.Strings[0]);
    NomDossier:=ListeParametreIn.Strings[0];
    if Str_Empty(ListeNomDeDossier.Strings[0]) then
     begin
     Application.MessageBox(Pchar('Le format du fichier n''est pas correct !'),'Attention',MB_ICONERROR);
//      MessageDlg('Le format du fichier n''est pas correct !', mtError, [mbOK], 0);
      Application.Terminate;
     end;

    ListeRepertoireCourantDestination.Add(ListeParametreIn.Strings[1]);
    RepDossier:=ListeParametreIn.Strings[1];
    if Str_Empty(ListeRepertoireCourantDestination.Strings[0]) then
     begin
     Application.MessageBox(Pchar('Le format du fichier n''est pas correct !'),'Attention',MB_ICONERROR);
//      MessageDlg('Le format du fichier n''est pas correct !', mtError, [mbOK], 0);
      Application.Terminate;
     end;

    ListeFichierARestaurer.Add(ListeParametreIn.Strings[2]);
    FichierZip:=ListeParametreIn.Strings[2];
    if Str_Empty(ListeFichierARestaurer.Strings[0]) then
     begin
      Application.MessageBox(Pchar('Le format du fichier n''est pas correct !'),'Attention',MB_ICONERROR);
//      MessageDlg('Le format du fichier n''est pas correct !', mtError, [mbOK], 0);
      Application.Terminate;
     end;
 end;
Rep_RepDossier := copy(RepDossier,1,LastDelimiter('\',RepDossier));
self.Caption := 'Restauration - Dossier : '+NomDossier;
RETitre.Lines.Clear;
//RETitre.DefAttributes.Color:=clRed;
//RETitre.DefAttributes.Style:=[fsbold,fsunderline];
//RETitre.DefAttributes.Color:=clWindowText;
//RETitre.DefAttributes.Style:=[fsbold];
RETitre.Lines.Add('');
RETitre.Lines.Add('ATTENTION !');
RETitre.Lines.Add('');
RETitre.Lines.Add('Vous �tes sur le point de restaurer la sauvegarde : ');
RETitre.Lines.Add('');
RETitre.Lines.Add(FichierZip);
RETitre.Lines.Add('');
RETitre.Lines.Add('Sur le dossier : ');
RETitre.SelStart:=RETitre.CaretPos.x + length(RETitre.Lines[RETitre.Lines.Count-1]);
//RETitre.DefAttributes.Color:=clWindowText;
//RETitre.DefAttributes.Style:=[fsbold];
RETitre.Lines[RETitre.Lines.Count-1] := RETitre.Lines[RETitre.Lines.Count-1] + NomDossier;
//RETitre.SelLength:=length(NomDossier);
//RETitre.SelAttributes.Color:=clRed;
//RETitre.SelAttributes.Style:=[fsbold,fsunderline];
////RETitre.SelAttributes.Color:=clRed;
////RETitre.SelAttributes.Style:=[fsbold,fsunderline];
//RETitre.SelLength:=0;
//
//RETitre.SelAttributes.Color:=clWindowText;
//RETitre.SelAttributes.Style:=[];
RETitre.Lines.Add('');
RETitre.Lines.Add('dans : ');
RETitre.Lines.Add('');
RETitre.Lines.Add(IncludeTrailingPathDelimiter(RepDossier)+NomDossier);
//RETitre.Lines.SaveToFile('c:\test2.txt');

end;

end.

