library LancementTomcat;

{ Remarque importante à propos de la gestion mémoire des DLL : ShareMem doit
  être la première unité dans la clause USES de votre bibliothèque,
  ET dans la clause USES de votre projet (sélectionnez Voir-Source du projet)
  si vos DLLs exportent des procédures ou des fonctions passant en paramètre
  des chaînes ou des résultats de fonction.
  Ceci s'applique à toutes les chaînes passées par ou à vos DLLs - mêmes celles
  qui sont imbriquées dans des enregistrements ou des classes. ShareMem est
  l'unité d'interface au gestionnaire de mémoire partagée DELPHIMM.DLL, qui
  doit être déployé avec vos propres DLLs. Pour éviter l'emploi de DELPHIMM.DLL,
  passez vos chaînes en utilisant des paramètres PChar ou ShortString. }


uses
  SysUtils,
  Classes,
  Forms,
  Dialogs,
  Controls,
  StdCtrls,
  Graphics,
  DLL_Form_A_Propos in 'DLL_Form_A_Propos.pas' {Form_A_Propos},
  DLL_Form_AvertDemo in 'DLL_Form_AvertDemo.pas' {AvertDemo},
  S2_Sauv in 'S2_Sauv.pas' {Sauv},
  RessourceString in 'RessourceString.pas',
  libLocale in 'libLocale.pas',
  R2_ListeFic in 'R2_ListeFic.pas' {ListeVLE},
  S2_Sauv_old in 'S2_Sauv_old.pas' {Sauv_old};

//E2_Decl_Records in 'E2_Decl_Records.pas';

Const

C_ToutesForm = -1;
C_A_Propos = 0;
C_AvertDemo = 1;
C_Sauvegarde = 2;
//C_Restauration = 3;



{=~=~=~=~=~=:  :=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=}
Procedure AfficheAPropos(HandleParent:Integer;Titre,TypeClient:PChar);
begin
   if Form_A_Propos=nil then Form_A_Propos:=TForm_A_Propos.Create(Application);
//   Form_A_Propos.ParentWindow := handleParent;
   Form_A_Propos.Icon := Application.Icon;
//   showmessage(titre);
//   showmessage(TypeClient);
   Form_A_Propos.Caption := Titre;
   Form_A_Propos.TypeClient:=TypeClient;
//   Application.CreateForm(TForm_A_Propos, Form_A_Propos);
   Form_A_Propos.ShowModal;
end;

Procedure AfficheAvertDemo;
begin
   if AvertDemo=nil then AvertDemo:=TAvertDemo.Create(Application);
   AvertDemo.Caption := 'Dossier : DEMO - Exercice : ExoDemo';
   AvertDemo.BtnAnnuler.Visible := False;
   AvertDemo.BtnImprimer.Visible := False;
   AvertDemo.BtnValider.Visible := True;
   AvertDemo.NomDuFichier:=IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+ 'Demo.rtf';
   AvertDemo.Width := 530;
   AvertDemo.Height := 280;
   AvertDemo.REAvertissement.ScrollBars := ssNone;
   AvertDemo.REAvertissement.Lines.Clear;
//   Form_A_Propos.ParentWindow := handleParent;
//   Form_A_Propos.Icon := Application.Icon;
//   showmessage(titre);
//   showmessage(TypeClient);
//   Application.CreateForm(TForm_A_Propos, Form_A_Propos);
   AvertDemo.ShowModal;
end;

Function AfficheReport(NomFichier,TitreForm,Titre2Edition,Titre3Edition:PChar;HeigthForm,WitdthForm,BtnImprimer,BtnAnnuler:Integer):integer;
Begin
   if AvertDemo=nil then AvertDemo:=TAvertDemo.Create(Application);
   AvertDemo.Caption := TitreForm;
   AvertDemo.BtnAnnuler.Visible := ( BtnAnnuler> 0) ;
   AvertDemo.BtnImprimer.Visible := (BtnImprimer > 0) ;
   AvertDemo.BtnValider.Visible := True;
//   showmessage(NomFichier);
   AvertDemo.NomDuFichier:=NomFichier;
   AvertDemo.Width := WitdthForm;
   AvertDemo.Height := HeigthForm;
   AvertDemo.REAvertissement.ScrollBars := ssBoth;
   AvertDemo.REAvertissement.Lines.Clear;
   AvertDemo.REAvertissement.DefAttributes.Color:=clWindowText;
   AvertDemo.REAvertissement.DefAttributes.Style := [];
   AvertDemo.REAvertissement.Alignment := taLeftJustify;
   AvertDemo.REAvertissement.Font.Style := [];
   AvertDemo.Titre2Edition := Titre2Edition;
   AvertDemo.Titre3Edition := Titre3Edition;
   result:=AvertDemo.ShowModal;
//   AvertDemo.Show;
End;

Function AfficheSauvegardeFermeture(EnDLL:Boolean;ParamSauvegarde:PChar):Integer;
var
 cheminFichierlog:string;
Begin
try
if Sauv = nil then Sauv:=TSauv.Create(Application);
  cheminFichierlog:=IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName))+'RestaurationSuivi.txt';
Sauv.FormStyle := fsNormal;
Sauv.EnDLL:=True;
Sauv.ParamSauvegarde := ParamSauvegarde;
Sauv.Animate1.Visible := false;
Sauv.Button1.Enabled := true;
Sauv.Button2.Enabled := true;
Sauv.Caption:='Sauvegarde de vos données';
Sauv.DateHeureDansNom:=false;
//ShowMessage(ParamSauvegarde);
Result:= Sauv.ShowModal;
except
//on E:Exception do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EInvalidOperation do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EThread do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EOutOfMemory do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EInvalidPointer do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EAccessViolation do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EFOpenError do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EReadError do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EAbort do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
end;
End;

Function AfficheSauvegarde(EnDLL:Boolean;ParamSauvegarde:PChar):Integer;
var
 cheminFichierlog:string;
Begin
try
if Sauv = nil then Sauv:=TSauv.Create(Application);
  cheminFichierlog:=IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName))+'RestaurationSuivi.txt';
Sauv.FormStyle := fsNormal;
Sauv.EnDLL:=True;
Sauv.ParamSauvegarde := ParamSauvegarde;
Sauv.Animate1.Visible := false;
Sauv.Button1.Enabled := true;
Sauv.Button2.Enabled := true;
Sauv.Caption:='Sauvegarde de vos données';
Sauv.DateHeureDansNom:=true;
//ShowMessage(ParamSauvegarde);
Result:= Sauv.ShowModal;
except
//on E:Exception do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EInvalidOperation do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EThread do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EOutOfMemory do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EInvalidPointer do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EAccessViolation do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EFOpenError do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EReadError do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EAbort do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
end;
End;


Function AfficheSauvegarde_ancienne(EnDLL:Boolean;ParamSauvegarde:PChar):Integer;
var
 cheminFichierlog:string;
Begin
try
if Sauv_old = nil then Sauv_old:=TSauv_old.Create(Application);
  cheminFichierlog:=IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName))+'RestaurationSuivi.txt';
Sauv_old.FormStyle := fsNormal;
Sauv_old.EnDLL:=True;
Sauv_old.ParamSauvegarde := ParamSauvegarde;
Sauv_old.Animate1.Visible := false;
Sauv_old.Button1.Enabled := true;
Sauv_old.Button2.Enabled := true;
Sauv_old.Caption:='Sauvegarde de vos données';
//ShowMessage('sauvegarde ancienne');
Result:= Sauv_old.ShowModal;
except
//on E:Exception do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EInvalidOperation do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EThread do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EOutOfMemory do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EInvalidPointer do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EAccessViolation do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EFOpenError do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EReadError do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EAbort do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
end;
End;


//Function AfficheRestauration(EnDLL:Boolean;ParamSauvegarde:PChar):Integer;
//var
// cheminFichierlog:string;
//Begin
//try
//if Rest = nil then Rest:=TRest.Create(Application);
//  cheminFichierlog:=IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName))+'RestaurationSuivi.txt';
//
//Rest.FormStyle := fsNormal;
//Rest.EnDLL:=True;
//Rest.ListeParametreIn :=   monSplit(ParamSauvegarde,';');
//Rest.Nbparametres:=Rest.ListeParametreIn.Count;
//Rest.BtnRestaure.Enabled := true;
//Rest.BtnAnnuler.Enabled := true;
//Rest.Caption:='Restauration de vos données';
////ShowMessage(ParamSauvegarde);
//Result:= Rest.ShowModal;
//except
//on E:Exception do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EInvalidOperation do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EThread do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EOutOfMemory do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EInvalidPointer do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EAccessViolation do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EFOpenError do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EReadError do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//on E:EAbort do begin AjouterFichierTexte(cheminFichierlog,E.Message); end;
//end;
//end;


Function RenvoieNumVersion():PChar;
Begin
result:=PChar(C_Version+'¤'+C_Date+'¤'+NumVersion);
End;






Procedure Free_form(IndexForm:Integer);
begin
case IndexForm of
  C_ToutesForm:Begin
              if Form_A_Propos <> nil then
               begin
                Form_A_Propos.Destroy;
                Form_A_Propos:=nil;
               end;
              if AvertDemo <> nil then
               begin
                AvertDemo.Destroy;
                AvertDemo:=nil;
               end;
              if Sauv <> nil then
               begin
                Sauv.Destroy;
                Sauv:=nil;
               end;
             End;

  C_A_Propos:Begin
              if Form_A_Propos <> nil then
               begin
                Form_A_Propos.Destroy;
                Form_A_Propos:=nil;
               end;
             End;

  C_AvertDemo:Begin
              if AvertDemo <> nil then
               begin
                AvertDemo.Destroy;
                AvertDemo:=nil;
               end;
              End;

  C_Sauvegarde:Begin
                if Sauv <> nil then
                 begin
                  Sauv.Destroy;
                  Sauv:=nil;
                 end;
                End;
else Begin
      MessageDlg('LGRLib.Free_Form : IndexForm inexistant.', mtError, [mbOK], 0);
      if Form_A_Propos <> nil then
       begin
        Form_A_Propos.Destroy;
        Form_A_Propos:=nil;
       end;
      if AvertDemo <> nil then
       begin
        AvertDemo.Destroy;
        AvertDemo:=nil;
       end;
      if Sauv <> nil then
       begin
        Sauv.Destroy;
        Sauv:=nil;
       end;
     End;
end;

end;

exports AfficheAPropos,
        Free_form,
        AfficheAvertDemo,
        AfficheReport,
        RenvoieNumVersion,
        AfficheSauvegarde_ancienne,
        AfficheSauvegarde,
        AfficheSauvegardeFermeture;
begin
end.
