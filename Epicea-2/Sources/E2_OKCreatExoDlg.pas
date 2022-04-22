unit E2_OKCreatExoDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,Gr_Librairie_obj,
  Buttons, ExtCtrls, Dialogs,Mask,E2_Librairie_Obj, ToolEdit,Gr_MultDos,LibDates,LibZoneSaisie,
  LibRessourceString,LibSQL ,E2_LibInfosTable,db,lib_chaine,LibGestionParamXML, DMConstantes;

type
  TOKCreatExoDlg = class(TForm)
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    EdDateExoDeb: TDateEdit;
    EdDateExoFin: TDateEdit;
    LaCodeExo: TLabel;
    EdCodeExo: TEdit;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure OKBtnClick(Sender: TObject);
    procedure MaskEdit1Exit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1Exit(Sender: TObject);
    procedure EdDateExoFinAcceptDate(Sender: TObject; var ADate: TDateTime;
      var Action: Boolean);
    procedure EdDateExoFinExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdDateExoFinKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdDateExoFinEnter(Sender: TObject);
    procedure EdDateExoFinChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdCodeExoKeyPress(Sender: TObject; var Key: Char);
    procedure EdCodeExoExit(Sender: TObject);
    procedure EdCodeExoEnter(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  WinControlExcept:TWinControl;
  DateFinValidee:Boolean;
  DirDossierEnCours:String;
  ListeCodeExoDejaUtilise:TStringList;
  public
    { Public declarations }
  end;

var
  OKCreatExoDlg: TOKCreatExoDlg;
  Function CreationNewExoAffich(NomDossier,DirDossier:String;DateDebExoCourant,DateFinExoCourant:TDate):Boolean;


implementation

uses DMProgramme, DMRecherche;

{$R *.DFM}

Function CreationNewExoAffich(NomDossier,DirDossier:String;DateDebExoCourant,DateFinExoCourant:TDate):Boolean;
var
InfosGestDossier:TInfosGestDossier;
Begin
try
//  if (OKCreatExoDlg = nil) then OKCreatExoDlg:=TOKCreatExoDlg.Create(Application.MainForm);
//  OKCreatExoDlg.EdDateExoDeb.Date:=JourSuivant(DateFinExoCourant,1).Date_;
//  OKCreatExoDlg.EdDateExoFin.Date:=MoisOffset(DateFinExoCourant,11).Date_;
//  OKCreatExoDlg.OKBtn.Enabled:=false;
//  OKCreatExoDlg.DirDossierEnCours:=DirDossier;
//  OKCreatExoDlg.Edit1.Text:='';
//  OKCreatExoDlg.Caption:='Création d''un nouvel Exercice pour le Dossier : '+NomDossier+'.';
//  OKCreatExoDlg.ListeCodeExoDejaUtilise:=ListeCodeExoDejaUtilisePourDossier(NomDossier);
  //

  FiltrageDataSet(DMRech.TaGestDossierRech,CreeFiltreET(['Nom_Dossier','Cloture'],[NomDossier,false]));
  InfosGestDossier:=Infos_TInfosGestDossier(DMRech.TaGestDossierRech,'Nom_Dossier',[NomDossier]);
  if ((DMRech.TaGestDossierRech.RecordCount < 2) and (InfosGestDossier.ResultInfos)) then
  begin
    if (OKCreatExoDlg = nil) then
      OKCreatExoDlg:=TOKCreatExoDlg.Create(Application.MainForm);
    OKCreatExoDlg.EdDateExoDeb.Date:=JourSuivant(InfosGestDossier.DATE_FIN_EXO,1).Date_;
    OKCreatExoDlg.EdDateExoFin.Date:=MoisOffset(InfosGestDossier.DATE_FIN_EXO,11).Date_;
    OKCreatExoDlg.OKBtn.Enabled:=false;
    OKCreatExoDlg.DirDossierEnCours:=InfosGestDossier.Dir_Dossier;
    OKCreatExoDlg.Edit1.Text:='';
    OKCreatExoDlg.Caption:='Création d''un nouvel Exercice pour le Dossier : '+NomDossier+'.';
    OKCreatExoDlg.ListeCodeExoDejaUtilise:=ListeCodeExoDejaUtilisePourDossier(NomDossier);
    OKCreatExoDlg.showModal;
    if OKCreatExoDlg.ModalResult = mrOk then
      begin
       FiltrageDataSet(DMRech.TaGestDossierRech,'Nom_Dossier = '''+NomDossier+''' and Cloture = Faux');
       InfosGestDossier:=Infos_TInfosGestDossier(DMRech.TaGestDossierRech,'Nom_Dossier',[NomDossier]);
       if InfosGestDossier.ResultInfos then
        begin
//          DirDossier := IncludeTrailingPathDelimiter(DirDossier);
          //if CreeNouveauExo(DirDossier+'\'+OKCreatExoDlg.Edit1.Text,true,False) then
          if CreeNouveauExo(IncludeTrailingPathDelimiter(OKCreatExoDlg.DirDossierEnCours)+OKCreatExoDlg.Edit1.Text,false,False) then
           begin
            try
             DMProg.TaGestDosModif.Insert;
             DMProg.TaGestDosModif.BeforePost:=nil;

             InitChampAfterInsert([InfosGestDossier.ID_Dossier,MaxId_Query(DMProg.TaGestDosModif,'ID_Table;Where GestDossier.db.id_dossier = '+IntToStr(InfosGestDossier.ID_Dossier)),InfosGestDossier.Nom_Dossier,InfosGestDossier.Dir_Dossier,
                                   OKCreatExoDlg.Edit1.Text,InfosGestDossier.Dir_Dossier+'\'+OKCreatExoDlg.Edit1.Text,DAte,InfosGestDossier.DateUtil-1,False,
                                   InfosGestDossier.EXO_BASE,OKCreatExoDlg.EdCodeExo.Text,
                                   DateToStr(OKCreatExoDlg.EdDateExoDeb.Date),DateToStr(OKCreatExoDlg.EdDateExoFin.Date),False],
                                   DMProg.TaGestDosModif);
             TableGerePost(DMProg.TaGestDosModif);
             DMProg.TaGestDosModif.BeforePost:=DMProg.TaGestDosModifBeforePost;
             result:=true;
             MessageDlg('Fin de la création de l''exercice : '+OKCreatExoDlg.Edit1.Text, mtInformation, [mbOK], 0);
            except
              if DMProg.TaGestDosModif.State = dsInsert then
                          DMProg.TaGestDosModif.Cancel;
               DMProg.TaGestDosModif.BeforePost:=DMProg.TaGestDosModifBeforePost;
               ShowMessage('Attention, Le repertoire : '+DirDossier+'\'+OKCreatExoDlg.Edit1.Text+' à été créé, pour utilisez à nouveau ce nom, vous devez le supprimer !');
            end;
           end;// Fin si cree nouvel exo

          end;// Fin si dossier trouvé
        end;
    end
  else
   begin
    MessageDlg('Vous ne pouvez pas créer de nouvel exercice', mtInformation, [mbOK], 0);
    abort;
   end;
except

end;
End;

procedure TOKCreatExoDlg.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in [#8,#48..#57,#65..#90,#97..#122]) then
 Begin
   Key:=#0;
   abort;
 End;
if ((Length(Edit1.Text) = Edit1.MaxLength) and (key <> #8)) then
 showmessage('Le nom des exercices ne peut dépasser 10 caractères !');
//if Key in [#42,#46,#47,#58,#60,#62,#63,#92,#124] then
//  begin
//   if ((Key=#46) and ((sender as TEdit).SelStart = 0)) then
//    begin
//	 Key:=#0;
//	 beep;
//    end;
//   if (Key <> #46) then
//    begin
//	 Key:=#0;
//	 beep;
//    end;
//  end;

//if Key = #32 then
//   if (sender as TEdit).SelStart = 0 then begin
//      Key:=#0;
//      Beep;
//      end;
//if (sender as TEdit).SelStart = 0 then
//           if Key in [#97..#122] then Key:=char(ord(Key) - 32);

end;

procedure TOKCreatExoDlg.OKBtnClick(Sender: TObject);
begin
//if ((Edit1.text <>'') and (MaskEdit2.EditText <> '')) then
//self.ModalResult:=mrOk else
//                       begin
//                       self.modalResult:=0;
//                       if MaskEdit2.EditText = '' then MaskEdit2.SetFocus;
//                       if Edit1.text='' then Edit1.SetFocus;
//                       abort;
//                       end;
//self.Close;
end;

procedure TOKCreatExoDlg.MaskEdit1Exit(Sender: TObject);
begin
//try
//MaskEdit2.ValidateEdit;
//except
//on EDBEditError do  MaskEdit2.SetFocus;
//end;
end;

procedure TOKCreatExoDlg.FormDestroy(Sender: TObject);
begin
ListeCodeExoDejaUtilise.Free;
LibGestionParamXML.DestroyForm(self,E.USer);
OKCreatExoDlg:=nil;
end;

procedure TOKCreatExoDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
WinSuivPrec(Handle,key,[WinControlExcept]);
  if Key = VK_ESCAPE then
   begin
    Key:= 0;
    Self.Close;
   end;

end;

procedure TOKCreatExoDlg.Edit1Exit(Sender: TObject);
var
RepExo:String;
begin
if ActiveControl <> CancelBtn then
 begin
   RepExo:=Edit1.Text;
   OKBtn.Enabled:=CreeNomValide_RepSimple(IncludeTrailingPathDelimiter(DirDossierEnCours),RepExo) and DateFinValidee;
   if empty(Edit1.Text) then Edit1.SetFocus;
 end;
end;

procedure TOKCreatExoDlg.EdDateExoFinAcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
var
DateMax:TDate;
RepExo:String;
begin
RepExo:=Edit1.Text;
// On verifie que la longueur de l'exercice est de 12 mois
// Si ce n'est pas le cas, message d'alerte, mais non bloquant, juste confirmation
// On ne peut pas avoir un exercice de 0 jour
case CompareDate(EdDateExoDeb.Date,EdDateExoFin.Date) of
   -2:begin
       Showmessage('Attention, la date saisie pour la fin d''exercice n''est pas correcte');
       action:=false;
      end;
   -1:begin
       MessageDlg('La fin de l''exercice : '+EdDateExoFin.Text+RetourChariotDouble+UpperCase(' ne peut Être antÉrieure ')+RetourChariotDouble+'au début de l''exercice : '+EdDateExoDeb.Text,mtError,[mbOK],0);
//       Showmessage('Attention, la fin de l''exercice : '+EdDateExoFin.Text+RetourChariotDouble+' ne peut être antérieure '+RetourChariotDouble+'au début de l''exercice : '+EdDateExoDeb.Text);
       action:=false;
      end;
   0:begin
       MessageDlg('La fin de l''exercice : '+EdDateExoFin.Text+RetourChariotDouble+UpperCase(' ne peut Être Égale ')+RetourChariotDouble+'au début de l''exercice : '+EdDateExoDeb.Text,mtError,[mbOK],0);
//       Showmessage('Attention, la fin de l''exercice ne peut être égale au début de l''exercice');
       action:=false;
      end;
   1:action:=true;
end;
OKBtn.Enabled:=CreeNomValide_RepSimple(IncludeTrailingPathDelimiter(DirDossierEnCours),RepExo) and action;
if OKBtn.Enabled then EdCodeExoExit(EdCodeExo);

//DateDsIntervale(
//if DateInfos(EdDateExoFin.Date).  EdDateExoDeb.
end;

procedure TOKCreatExoDlg.EdDateExoFinExit(Sender: TObject);
var
accept:boolean;
DateAux:TDateTime;
begin
DateAux:=EdDateExoFin.Date;
EdDateExoFinAcceptDate(sender,DateAux,accept);
   if accept then
        WinControlExcept:=nil
      else
        WinControlExcept:=EdDateExoFin;
//if not accept then abort;
end;

procedure TOKCreatExoDlg.FormShow(Sender: TObject);
begin
Edit1.SetFocus;
DateFinValidee:=false;
WinControlExcept:=EdDateExoFin;
end;

procedure TOKCreatExoDlg.EdDateExoFinKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
accept:boolean;
DateAux:TDateTime;
begin
if key = VK_RETURN then
 begin
   DateAux:=EdDateExoFin.Date;
   EdDateExoFinAcceptDate(sender,DateAux,accept);
   DateFinValidee:=accept;
   if accept then
        WinControlExcept:=nil
      else
        WinControlExcept:=EdDateExoFin;
 end;
end;

procedure TOKCreatExoDlg.EdDateExoFinEnter(Sender: TObject);
begin
 WinControlExcept:=EdDateExoFin;
end;

procedure TOKCreatExoDlg.EdDateExoFinChange(Sender: TObject);
begin
DateFinValidee:=false;
end;

procedure TOKCreatExoDlg.FormCreate(Sender: TObject);
begin
ListeCodeExoDejaUtilise:=TStringList.Create;
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
  end;
end;

procedure TOKCreatExoDlg.EdCodeExoKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in [#8,#48..#57]) then
 Begin
   Key:=#0;
   abort;
 End;
end;

procedure TOKCreatExoDlg.EdCodeExoExit(Sender: TObject);
var
DateAux:TDate;
begin
if empty(EdCodeExo.Text) then
 begin
   if DateInfos(EdDateExoFin.Date).Valide then
    begin
     EdCodeExo.Text:=Copy(DateInfos(EdDateExoFin.Date).AnStr,3,4);
     while ListeCodeExoDejaUtilise.IndexOf(EdCodeExo.Text) <> -1 do
      begin
        DateAux:=MoisOffset(DateAux,12).Date_;
        EdCodeExo.Text:=Copy(DateInfos(EdDateExoFin.Date).AnStr,3,4);
      end;
    end;
 end
 else
 begin
  if ListeCodeExoDejaUtilise.IndexOf(EdCodeExo.Text) <> -1 then
   begin
    showmessage('Attention, ce code est déjà utilisé.'+RetourChariotDouble+'Veuillez en choisir un autre !');
    EdCodeExo.SetFocus;
    abort;
   end;
  if length(EdCodeExo.Text) < 2  then
   Begin
    showmessage('Attention, les codes exercices doivent être sur 2 caractères !'+RetourChariotDouble+'Veuillez compléter !');
    EdCodeExo.SetFocus;
    abort;
   End;

 end;
end;

procedure TOKCreatExoDlg.EdCodeExoEnter(Sender: TObject);
begin
EdCodeExoExit(Sender);
end;

procedure TOKCreatExoDlg.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
canclose:=true;
end;

end.
