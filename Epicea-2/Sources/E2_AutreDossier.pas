unit E2_AutreDossier;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, gr_Librairie_obj, Buttons, DBCtrls,
  Db, DBTables, Grids, DBGrids, Mask, ExtCtrls,LibSQL,
   RXDBCtrl, ExRxDBGrid, GrDBGrid, RXSplit, RXCtrls,LibZoneSaisie,DMProgramme,
   E2_Recherche,
   Lib_Chaine,
   ShlObj,
   InputQueryFrm_F,
   SHFolder,
  ComCtrls,LibRessourceString,DMConstantes,LibFichRep,Gr_MultDos, LibGestionParamXML, jpeg,
  E2_AvertissementSuppressionDossier ;

type
  TParamAfficheAutreDossier = record
   DossierACherche:String;
   Tag:Integer;
   SaisieNomDossier:Boolean;
   end;

  TAutreDossier = class(TForm)
    PaExo: TPanel;
    PaGrilleExo: TPanel;
    DBGrid2: TGrDBGrid;
    PaDossier: TPanel;
    PaGrilleNomDossier: TPanel;
    DBGrid1: TGrDBGrid;
    PaCptIntit: TPanel;
    Panel1: TPanel;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    RxSplitter1: TRxSplitter;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    PaBas: TPanel;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    Supprimer1: TMenuItem;
    RxSplitter2: TRxSplitter;
    ScrollBox1: TScrollBox;
    Panel4: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    PaInfoDos: TPanel;
    MemoInfDof: TRichEdit;
    Renommer1: TMenuItem;
    Crerunnouveaudossier1: TMenuItem;
    Renommerexercice1: TMenuItem;
    procedure Calculatrice1Click(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    Procedure initialiseTableEvent;
    procedure FormDestroy(Sender: TObject);
    procedure pmMenu1Click(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid2KeyPress(Sender: TObject; var Key: Char);
    procedure StaticText2Click(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure PaExoResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    Procedure TaGestDosAfterScroll(DataSet: TDataSet);
    procedure DBEdit1Enter(Sender: TObject);
    procedure DBEdit1Exit(Sender: TObject);
    procedure BtnAnnulerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure PaCptIntitClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Supprimer1Click(Sender: TObject);
    procedure DBRadioGroup1Enter(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure PaGrilleNomDossierResize(Sender: TObject);
    procedure Renommer1Click(Sender: TObject);
    procedure Crerunnouveaudossier1Click(Sender: TObject);
    procedure Renommerexercice1Click(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
    DossierAAtteindre:String;
    TitreForm,SousTitreForm:string;
  end;

var
  AutreDossier: TAutreDossier;
  Croissant:boolean;

  Function AutreDossierAffiche(ParamAfficheAutreDossier:TParamAfficheAutreDossier):Boolean;

implementation
{$R *.DFM}
Uses E2_Librairie_obj,
     //Gr_Calculatrice,
     E2_Main, DMXMLs, DiversProjets, DMRecherche, LibDates;

Function AutreDossierAffiche(ParamAfficheAutreDossier:TParamAfficheAutreDossier):Boolean;
Begin
  if (AutreDossier = nil) then AutreDossier:=TAutreDossier.Create(Application.MainForm);
  AutreDossier.Tag :=ParamAfficheAutreDossier.Tag;
  ParamAfficheAutreDossier.DossierACherche:='';
  if ParamAfficheAutreDossier.SaisieNomDossier then
   begin
    if not InputQuery('Atteindre le dossier ...','CODE du dossier : ',ParamAfficheAutreDossier.DossierACherche) then
    ParamAfficheAutreDossier.DossierACherche:='';
   end;
  AutreDossier.TitreForm := 'Autres Dossiers';
  AutreDossier.SousTitreForm := 'Gestion Dossiers';
  AutreDossier.DossierAAtteindre := uppercase(ParamAfficheAutreDossier.DossierACherche);
  AutreDossier.ShowModal;
End;


procedure TAutreDossier.Calculatrice1Click(Sender: TObject);
begin
	AfficheCalculatrice(nil);
end;

procedure TAutreDossier.Fermer1Click(Sender: TObject);
begin
	Self.Close;
end;

procedure TAutreDossier.FormCreate(Sender: TObject);
begin
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
        InitialiseFormPosDefaut(self);
    end;
end;
//******************************************************************************
Procedure TAutreDossier.InitialiseTable_A_Nil;
Begin
if DMProg<>nil then
 DMProg.TaGestDos.AfterScroll:=nil;
End;

Procedure TAutreDossier.initialiseTableEvent;
Begin
 DMProg.TaGestDos.AfterScroll:=TaGestDosAfterScroll;
End;

procedure TAutreDossier.FormDestroy(Sender: TObject);
begin
  LibGestionParamXML.DestroyForm(Self,E.USer);
  AutreDossier:=nil;
end;

procedure TAutreDossier.pmMenu1Click(Sender: TObject);
begin
	PopupMenu1.Popup(Left + 50, Top + 50);
end;

procedure TAutreDossier.DBGrid2DblClick(Sender: TObject);
begin
  // Avant d'ouvrir un nouveau dossier, on sauve les param�tres du dossier en cours
  DMProg.SauveGestDossierFichier(E.NomDossier);
  if Main.OuvreExo(DMProg.daGestDos.DataSet.findField('Nom_Dossier').AsString,DMProg.DataSource1.DataSet.findField('Nom_Exo').AsString) then
      messagedlg_lgr('Vous venez d''activer le dossier :'+RetourChariotDouble+E.NomDossier+RetourChariotDouble+'Exercice : '+RetourChariotDouble+E.NomExo);
//      ShowMessage('Vous venez d''activer le dossier :'+RetourChariotDouble+E.NomDossier+RetourChariotDouble+'Exercice : '+RetourChariotDouble+E.NomExo);
end;

procedure TAutreDossier.FormShow(Sender: TObject);
begin
DBGrid1.SetFocus;
//DBRadioGroup1.it
   DMProg.TaGestDos.Close;
   DMProg.Query1.Active:=false;
//   TaGestDos.Filtered:=false;
if self.tag=1 then
  begin
    if E.NomDossier <> DM_C_NomAliasDemo then
     begin
      DMProg.Query1.SQL.Clear;
      DMProg.Query1.SQL.Add('select Id_Dossier,Nom_Dossier,ID_Table,Nom_Exo,Dir_Dossier,Dir_Exo, DESIGNATION_DOSSIER from GestDossier.db  where Nom_Dossier ='''+E.NomDossier+''' group by Id_Dossier,Nom_Dossier,ID_Table,Nom_Exo,Dir_Dossier,Dir_Exo,DESIGNATION_DOSSIER order by Nom_Dossier;');
      TitreForm:='Autres exercices du Dossier : ' + E.NomDossier;
     end
     else
     begin
      DMProg.Query1.SQL.Clear;
      DMProg.Query1.SQL.Add('select Id_Dossier,Nom_Dossier,ID_Table,Nom_Exo,Dir_Dossier,Dir_Exo,DESIGNATION_DOSSIER from GestDossier.db group by Id_Dossier,Nom_Dossier,ID_Table,Nom_Exo,Dir_Dossier,Dir_Exo,DESIGNATION_DOSSIER order by Nom_Dossier;');
      TitreForm:='Autres Dossiers ';
     end;
   end;

DMProg.TaGestDos.Open;
DMProg.Query1.Active:=true;
Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DMProg.Query1)+' - '+Str_SingulierToPluriel(DMProg.Query1.RecordCount,'dossier');
DMProg.Query1.Locate('Nom_Dossier',DossierAAtteindre,[loPartialKey]);
//
Croissant:=true;
DMProg.Query1.Fields[0];
DMProg.TaGestDos.Fields[0];
end;

procedure TAutreDossier.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
DMProg.TaGestDos.AfterScroll:=nil;
DMProg.TaGestDos.Close;
//   DMProg.Query1.Active:=false;
if self.tag=1 then
   begin
    DMProg.Query1.Close;
    DMProg.Query1.SQL.Clear;
    DMProg.Query1.SQL.Add('select Id_Dossier,Nom_Dossier,ID_Table,Nom_Exo,Dir_Dossier,Dir_Exo,DESIGNATION_DOSSIER from GestDossier.db group by Id_Dossier,Nom_Dossier,ID_Table,Nom_Exo,Dir_Dossier,Dir_Exo,DESIGNATION_DOSSIER order by Nom_Dossier;');
    DMProg.Query1.Open;
    TitreForm:='Autres Dossiers ...';
   end;
   self.tag:=0;

 Main.Menu.Items[0].delete(0);
 Main.Menu.Items[0].Insert(0,NewItem('Nouveau Dossier ...',0,false,true,Main.CreationNewDossierClick,0,'DosCourant'));
 Gr_MultDos.AjoutMenu(Main.Multidossier);
// Main.mnMethodesClick(Main.mnDossiers);
Initialiser_ShortCut_Main(false);
end;

procedure TAutreDossier.DBGrid2KeyPress(Sender: TObject; var Key: Char);
begin
if Key = #13 then begin
   DBGrid2DblClick(DBGrid2);
   end;
end;

procedure TAutreDossier.StaticText2Click(Sender: TObject);
begin
//DMProg.Query1.DisableControls;
//Croissant:=not Croissant;
//DMProg.Query1.Active:=false;
//DMProg.Query1.SQL.Clear;
//if Croissant then DMProg.Query1.SQL.Add('select Id_Dossier,Nom_Dossier from GestDossier.db group by Id_Dossier,Nom_Dossier order by Nom_Dossier;')
//   else DMProg.Query1.SQL.Add('select Id_Dossier,Nom_Dossier from GestDossier.db group by Id_Dossier,Nom_Dossier order by Nom_Dossier desc;');
//DMProg.Query1.Active:=True;
//DMProg.Query1.EnableControls;
end;

procedure TAutreDossier.BtnFermerClick(Sender: TObject);
begin
self.close;
end;

procedure TAutreDossier.PaBtnResize(Sender: TObject);
begin
   FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TAutreDossier.PaExoResize(Sender: TObject);
begin
Label1.Width:=PaExo.Width-10;
Label2.Width:=PaExo.Width-10;
Label5.Width:=PaExo.Width-10;
DBEdit1.Width:=Label1.Width-90;
DBEdit2.Width:=Label1.Width-90;
DBRadioGroup1.Width:=Label1.Width-130;
end;

procedure TAutreDossier.FormActivate(Sender: TObject);
begin

initialiseTableEvent;
TaGestDosAfterScroll(DMProg.TaGestDos);

CouleurFond([DBEdit1,DBEdit2,DBRadioGroup1],$00BDD8DF);

DBGrid1.ParamColor:=true;
DBGrid1.Param:=ParamUtil.CouleurDBGrid;
DBGrid1.UpDateColor;

DBGrid2.ParamColor:=true;
DBGrid2.Param:=ParamUtil.CouleurDBGrid;
DBGrid2.UpDateColor;

Initialiser_ShortCut_Main(true);
end;

Procedure TAutreDossier.TaGestDosAfterScroll(DataSet: TDataSet);
var
Debut,longueur:integer;
Texte:String;
begin
  MemoInfDof.Clear;
  Debut:=0;
  longueur:=17;
  Texte:='Dates d''exercice :'+ #13#10 +'D�but : ' + DMProg.TaGestDos.FindField('DATE_DEB_EXO').AsString + #13#10 + 'Fin : ' + DMProg.TaGestDos.FindField('DATE_FIN_EXO').AsString;
  MemoInfDof.Lines.Add(texte);
  MemoInfDof.SelStart:=Debut;
  MemoInfDof.SelLength:=longueur;
  MemoInfDof.SelAttributes.Color:=clRed;
  MemoInfDof.SelAttributes.Style:=[fsbold,fsunderline];
  Debut:=longueur+1;
  longueur:=length(texte)+1;
  MemoInfDof.SelStart:=Debut;
  texte:= 'Derni�re utilisation le : ' + DateToStr(DMProg.TaGestDos.FindField('DateUtil').asdateTime)+' � '+TimeToStr(DMProg.TaGestDos.FindField('DateUtil').asdateTime);
  MemoInfDof.SelLength:=longueur+length(texte);
  MemoInfDof.SelAttributes.Color:=clWindowText;
  MemoInfDof.SelAttributes.Style:=[];
  debut:=longueur+length(texte)+1;
  MemoInfDof.Lines.Add(texte );
  if(not DirectoryExists(DMProg.TaGestDos.FindField('Dir_Dossier').AsString))then
    begin
    MemoInfDof.SelStart:=debut;
    texte:='Attention !!! Ce dossier n''existe pas dans le r�pertoire : '+ExtractFileDir(DMProg.TaGestDos.FindField('Dir_Dossier').AsString);
    MemoInfDof.SelLength:=length(texte);
    MemoInfDof.SelAttributes.Color:=clRed;
    MemoInfDof.SelAttributes.Style:=[fsbold,fsunderline];
    MemoInfDof.Lines.Add(texte);
    debut:=debut+length(texte)+1;
  end;
  if(FileExists(DMProg.TaGestDos.FindField('Dir_Exo').AsString+'\Epure.txt'))then
  begin
    MemoInfDof.SelStart:=debut;
    texte:='Attention !!! Exercice Epur�.';
    MemoInfDof.SelLength:=length(texte);
    MemoInfDof.SelAttributes.Color:=clRed;
    MemoInfDof.SelAttributes.Style:=[fsbold,fsunderline];
    MemoInfDof.Lines.Add(texte);
    debut:=debut+length(texte)+1;
  end;
  
  //permet de rajouter du texte format�e normalement
  MemoInfDof.SelStart:=debut;
  texte:='';
  MemoInfDof.SelLength:=length(texte);
  MemoInfDof.SelAttributes.Color:=clWindowText;
  MemoInfDof.SelAttributes.Style:=[];
  MemoInfDof.Lines.Add(texte);

   Crerunnouveaudossier1.Enabled:=lowercase(IncludeTrailingPathDelimiter(e.RepertoireDossier))<>
     lowercase(IncludeTrailingPathDelimiter(DMProg.TaGestDos.FindField('Dir_Dossier').AsString));
  Renommer1.Enabled:=lowercase(IncludeTrailingPathDelimiter(e.RepertoireDossier))<>
     lowercase(IncludeTrailingPathDelimiter(DMProg.TaGestDos.FindField('Dir_Dossier').AsString));
  Renommerexercice1.Enabled:=lowercase(IncludeTrailingPathDelimiter(e.RepertoireDossier))<>
     lowercase(IncludeTrailingPathDelimiter(DMProg.TaGestDos.FindField('Dir_Dossier').AsString));
end;

procedure TAutreDossier.DBEdit1Enter(Sender: TObject);
begin
 CouleurActivecontrolLabel(ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond,nil,0,0)
end;

procedure TAutreDossier.DBEdit1Exit(Sender: TObject);
begin
 CouleurDeActivecontrolLabel((Sender as TDBEdit),ParamUtil.CouleurDBGrid.GrilleColorFond,nil,0,0)
end;

procedure TAutreDossier.BtnAnnulerKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 If Key = VK_ESCAPE then Self.Close;
end;

procedure TAutreDossier.BtnAnnulerEnter(Sender: TObject);
begin
 BouttonDiminue(sender as TButton);
end;

procedure TAutreDossier.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TAutreDossier.PaCptIntitClick(Sender: TObject);
begin
DMProg.Query1.DisableControls;
Croissant:=not Croissant;
DMProg.Query1.Active:=false;
DMProg.Query1.SQL.Clear;
//select Id_Dossier,Nom_Dossier,ID_Table,Nom_Exo,Dir_Dossier,Dir_Exo from GestDossier.db group by Id_Dossier,Nom_Dossier,ID_Table,Nom_Exo,Dir_Dossier,Dir_Exo order by Nom_Dossier;
if Croissant then DMProg.Query1.SQL.Add('select Id_Dossier,Nom_Dossier,ID_Table,Nom_Exo,Dir_Dossier,Dir_Exo,DESIGNATION_DOSSIER from GestDossier.db group by Id_Dossier,Nom_Dossier,ID_Table,Nom_Exo,Dir_Dossier,Dir_Exo,DESIGNATION_DOSSIER order by Nom_Dossier;')
   else DMProg.Query1.SQL.Add('select Id_Dossier,Nom_Dossier,ID_Table,Nom_Exo,Dir_Dossier,Dir_Exo,DESIGNATION_DOSSIER from GestDossier.db group by Id_Dossier,Nom_Dossier,ID_Table,Nom_Exo,Dir_Dossier,Dir_Exo,DESIGNATION_DOSSIER order by Nom_Dossier desc;');
DMProg.Query1.Active:=True;
DMProg.Query1.EnableControls;

end;

procedure TAutreDossier.FormResize(Sender: TObject);
begin
if Main <> nil then
  WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TAutreDossier.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_RETURN then
WinSuivPrec(Handle,key,[]);
	if Key = VK_ESCAPE then
        begin
   	Key:= 0;
      Self.Close;
   end;
if ((Shift = [ssCtrl])and(Key=67)) then
 begin
  E.ControleDuDossier:=false;
  MessageDlg('Contr�le du dossier d�sactiv� !', mtWarning, [mbOK], 0);
 end;
end;

procedure TAutreDossier.Supprimer1Click(Sender: TObject);
var
NomDos:String;
ParamAfficheAvertissementSuppressionDossier:TParamAfficheAvertissementSuppressionDossier;
ListeTypeRepertoire:TstringList;
i:integer;
begin
try//finally
    try//except    
      ListeTypeRepertoire:=TStringList.Create;
      ListeTypeRepertoire:=RecupListeRepertoireWindows;//r�cup�re tous les r�pertoires cr��s par windows qu'il ne faut pas
      //supprimer en automatique
      for i:=0 to ListeTypeRepertoire.count-1 do
        begin
        if AnsiCompareFileName(DMProg.daGestDos.DataSet.FindField('Dir_Dossier').AsString,TypeRepertoirePath(strtoint_lgr(str_getstringelement(ListeTypeRepertoire.strings[i],2,';'))))=0 then
               raise ExceptLGR.Create('Vous ne pouvez pas supprimer le dossier : '+DMProg.daGestDos.DataSet.FindField('Nom_Dossier').AsString+RetourChariotSimple+' car il a �t� cr�� directement dans le r�pertoire : '+TypeRepertoirePath(strtoint_lgr(str_getstringelement(ListeTypeRepertoire.strings[i],2,';')))+AppelerServiceMaintenance,0,true,mtError);
        end;
      if ((AnsiCompareFileName(DMProg.daGestDos.DataSet.FindField('Dir_Dossier').AsString,copy(DMProg.daGestDos.DataSet.FindField('Dir_Dossier').AsString,1,3))=0)
          and ((ListTypeLecteur(DRIVE_FIXED).IndexOf(copy(DMProg.daGestDos.DataSet.FindField('Dir_Dossier').AsString,1,3))<>-1)
          or(ListTypeLecteur(DRIVE_REMOTE).IndexOf(copy(DMProg.daGestDos.DataSet.FindField('Dir_Dossier').AsString,1,3))<>-1))) then
        raise ExceptLGR.Create('Vous ne pouvez pas supprimer le dossier : '+DMProg.daGestDos.DataSet.FindField('Nom_Dossier').AsString+RetourChariotSimple+' car il a �t� cr�� directement sur un r�pertoire racine '+AppelerServiceMaintenance,0,true,mtError);
      if E.NomDossier = DMProg.daGestDos.DataSet.FindField('Nom_Dossier').AsString then
       begin
         MessageDlg('Vous ne pouvez pas supprimer un dossier en cours d''utilisation !',mtWarning,[mbOK],0);
       end
       else
       begin
        if MessageDlg('ATTENTION, Vous �tes sur le point de supprimer un dossier.'+#13+#10+'�tes-Vous s�r de vouloir continuer ?',mtWarning,[mbNo,mbYes],0)=mrYes then
         begin
          try
            NomDos:=DMProg.daGestDos.DataSet.FindField('Nom_Dossier').AsString;
            ParamAfficheAvertissementSuppressionDossier.DossierACherche:=DMProg.daGestDos.DataSet.FindField('Dir_Dossier').AsString;
            if AvertissementSuppressionDossierAffiche(ParamAfficheAvertissementSuppressionDossier) then
              begin
                  if EffaceDossier2(DMProg.daGestDos.DataSet.FindField('Dir_Dossier').AsString) then
                   begin
          //           DMXml.SupprimeDossier(NomDos);
                     GEstDossierSuppressionDossier(NomDos);
                     DMProg.Query1.Close;
                     DMProg.Query1.Open;
                   end
                   else
                   begin
          //           DMXml.SupprimeDossier(NomDos);
                     GEstDossierSuppressionDossier(NomDos);
                     DMProg.Query1.Close;
                     DMProg.Query1.Open;
                     MessageDlg('Le dossier n''a pas pu �tre supprim�, vous devrez le faire par l''explorateur !',mtWarning,[mbOK],0);
                   end;
              end;
          except
             showmessage('Probl�me lors de la suppression du dossier '+ NomDos);
          end;

         end;
       end;
    except

    end;//fin du try except
Finally
Main.InitGestListMenu(Main.Menu.Items);
Initialise_TStringlist(ListeTypeRepertoire,self);
end;//fin du try finally
end;

procedure TAutreDossier.DBRadioGroup1Enter(Sender: TObject);
var
key:Word;
begin
Key := VK_RETURN;
FormKeyDown(self,key,[]);
end;

procedure TAutreDossier.Aide1Click(Sender: TObject);
begin
 If activecontrol = DBGrid1 Then
  begin
   case DBGrid1.DataSource.State of
      dsbrowse:case DBGrid1.SelectedIndex of
                  0:RechercherQu(DBGrid1,DMProg.Query1,['Nom_Dossier','DESIGNATION_DOSSIER','Dir_Dossier'],['Nom dossier','Raison Sociale','R�pertoire'],'',0,'GestDossier');
                  1:RechercherQu(DBGrid1,DMProg.Query1,['DESIGNATION_DOSSIER','Nom_Dossier','Dir_Dossier'],['Raison Sociale','Nom dossier','R�pertoire'],'',0,'GestDossier');
               end;
   end;
 end;
 If activecontrol = DBGrid2 Then
  begin
   try
     FiltrageDataSet(DMProg.TaGestDos,'Nom_Dossier='''+DMProg.daGestDos.DataSet.FindField('Nom_Dossier').AsString+'''');
     case DBGrid2.DataSource.State of
        dsbrowse:case DBGrid2.SelectedIndex of
  //                  0:Rechercher(DBGrid2,DMProg.TaGestDos,['Nom_Exo','Dir_Exo'],['Nom Exercice','R�pertoire'],'Nom_Dossier='''+DMProg.Query1.findfield('Nom_Dossier').AsString+'''',0);
  //                  1:Rechercher(DBGrid2,DMProg.TaGestDos,['Nom_Exo','Dir_Exo'],['Nom Exercice','R�pertoire'],'Nom_Dossier='''+DMProg.Query1.findfield('Nom_Dossier').AsString+'''',0);

                    0:Rechercher(DBGrid2,DMProg.TaGestDos,['Nom_Exo','Dir_Exo','Nom_Dossier'],['Nom Exercice','R�pertoire',''],'',0);
                    1:Rechercher(DBGrid2,DMProg.TaGestDos,['Nom_Exo','Dir_Exo','Nom_Dossier'],['Nom Exercice','R�pertoire',''],'',0);
                 end;
     end;
  finally
   DeFiltrageDataSet(DMProg.TaGestDos);
  end;
 end;

end;

procedure TAutreDossier.PaGrilleNomDossierResize(Sender: TObject);
begin
FormateTailleColonne(DBGrid1,12,[3,7]);
end;


// Fonction "CallBack" appel�e par CopyFileEx pour signaler l'avancement de la copie
Function CopyCallBack(
  TotalFileSize: LARGE_INTEGER;          // Taille totale du fichier en octets
  TotalBytesTransferred: LARGE_INTEGER;  // Nombre d'octets d�j�s transf�r�s
  StreamSize: LARGE_INTEGER;             // Taille totale du flux en cours
  StreamBytesTransferred: LARGE_INTEGER; // Nombre d'octets d�j� tranf�r�s dans ce flus
  dwStreamNumber: DWord;                 // Num�ro de flux actuel
  dwCallbackReason: DWord;               // Raison de l'appel de cette fonction
  hSourceFile: THandle;                  // handle du fichier source
  hDestinationFile: THandle;             // handle du fichier destination
  ProgressBar : TProgressBar             // param�tre pass� � la fonction qui est une
                                         // recopie du param�tre pass� � CopyFile Ex
                                         // Il sert � passer l'adresse du progress bar �
                                         // mettre � jour pour la copie. C'est une
                                         // excellente id�e de DelphiProg
  ): DWord; far; stdcall;
Var
  EnCours: Int64;
Begin
  // Calcul de la position du progresbar en pourcent, le calcul doit �tre effectu� dans
  // une variable interm�diaire de type Int64. Pour �viter les d�bordement de calcul
  // dans la propri�t� Position de type integer.
  EnCours := TotalBytesTransferred.QuadPart * 100 Div TotalFileSize.QuadPart;
  If ProgressBar<>Nil Then ProgressBar.Position := EnCours;
  // La fonction doit d�finir si la copie peut �tre continu�e.
  Result := PROGRESS_CONTINUE;
End;

procedure TAutreDossier.Renommer1Click(Sender: TObject);
var
NewCode,OldCode,Chemin,Direxo:String;
id_dossier : String;
querySelect,QueryUpdate:TQuery;
Var Retour: LongBool;
begin
try//finally
  try//except
  //Permet de renommer un dossier existant
  //doit v�rifier l''existance du nouveau nom
  //si c'est le cas, renommer le dossier existant en rajoutant "legrain" en prefixe
  //supprimer le .epi
  //modifier le nom du dossier dans table GestDossier

  Retour := False;
  querySelect := TQuery.Create(self);
  QueryUpdate := TQuery.Create(self);
  Chemin :=RepertoirePere(DMProg.daGestDos.DataSet.FindField('Dir_Dossier').AsString);
 // ShowMessage('RepertoirePere : '+chemin);
  NewCode:=DMProg.daGestDos.DataSet.FindField('Nom_Dossier').AsString;
  OldCode:=DMProg.daGestDos.DataSet.FindField('Nom_Dossier').AsString;
  id_dossier:=DMProg.daGestDos.DataSet.FindField('id_Dossier').AsString;
  if(MyInputQueryMAJ(self,'Changement de code dossier','Indiquer le nouveau nom du dossier',
      NewCode,'',[#45,#95, #48..#57, #65..#90, #97..#122],10)) then
    begin
    querySelect.DatabaseName := DM_C_NomAliasProgram;

    querySelect.SQL.Add('select Dir_dossier from GestDossier.db where Dir_dossier = '''+IncludeTrailingPathDelimiter(Chemin)+NewCode+'''');
    querySelect.Open;
    if(querySelect.RecordCount>0)then
      begin
        //le nouveau code existe d�j� dans la gestion des dossier
        Application.MessageBox(Pchar('Ce code dossier existe d�j�.'),'Attention',MB_ICONWARNING);
      end
    else
      begin
        if(DirectoryExists(IncludeTrailingPathDelimiter(Chemin)+NewCode))then
          begin
            if(DirectoryExists(IncludeTrailingPathDelimiter(Chemin)+NewCode+'_LeGrain'))then
               DeleteFile(IncludeTrailingPathDelimiter(Chemin)+NewCode+'_LeGrain');
            RenameFile(IncludeTrailingPathDelimiter(Chemin)+NewCode,IncludeTrailingPathDelimiter(Chemin)+NewCode+'_LeGrain');
              if(not DirectoryExists(IncludeTrailingPathDelimiter(Chemin)+NewCode+'_LeGrain'))
                     then abort;
          end;
        if (RenommeFolder(PChar(DMProg.daGestDos.DataSet.FindField('Dir_Dossier').AsString),     // Nom du fichier d'origine
    PChar(IncludeTrailingPathDelimiter(Chemin)+NewCode))) then
        //if (DirectoryExists(IncludeTrailingPathDelimiter(Chemin)+NewCode))then
        begin
        //showmessage('file rename : '+IncludeTrailingPathDelimiter(Chemin)+NewCode);

           QueryUpdate.close;
           QueryUpdate.SQL.Clear;
           QueryUpdate.SQL.Add('update "'+IncludeTrailingPathDelimiter(e.RepertoireProgram)+'GestDossier.db" set'+
            ' Dir_dossier ='''+IncludeTrailingPathDelimiter(Chemin)+NewCode+
          ''' ,Dir_exo ='''+IncludeTrailingPathDelimiter(Chemin)+IncludeTrailingPathDelimiter(NewCode)+'''||nom_Exo'+
          ' , Nom_Dossier ='''+NewCode+
          ''' where id_dossier = '+id_dossier);
           QueryUpdate.ExecSQL;
        showmessage('Mise � jour de la gestion des dossiers');
        DMProg.SauveGestDossierFichier(NewCode);
       Application.MessageBox(Pchar('Le dossier a �t� renomm�.'),'Confirmation',MB_ICONEXCLAMATION );
        DMProg.daGestDos.DataSet.close;
        DMProg.daGestDos.DataSet.Open;
        if(FileExists(IncludeTrailingPathDelimiter(Chemin)+NewCode+'\'+OldCode+'.epi'))then DeleteFile(IncludeTrailingPathDelimiter(Chemin)+NewCode+'\'+OldCode+'.epi');
        end
        else Application.MessageBox(Pchar('Le dossier n''a pas pu �tre renomm�.'),'Attention',MB_ICONWARNING );
      end;
    end;
  except
      Application.MessageBox(Pchar('Le dossier n''a pas pu �tre renomm�.'),'Attention',MB_ICONWARNING );
  end;
finally
   querySelect.Free;
   QueryUpdate.Free;
   DMProg.daGestDos.DataSet.Locate('id_dossier',id_dossier,[]);
end;
end;


procedure TAutreDossier.Crerunnouveaudossier1Click(Sender: TObject);
var
NewCode,OldCode,Chemin,Direxo:String;
id_dossier : String;
querySelect,QueryUpdate:TQuery;
Var Retour: LongBool;
listeFichier:Tstringlist;
cheminNewDossier:string;
dateJour:Tdate;
effacerDossier:boolean;
begin
{
* saisir le code du nouveau dossier
* puis le code du 1er exercice
* Copier les tables du dossier :

- Model
- ModelL
- Plancpt
- Ta_activite
- Ta_Affect_Atelier
- Ta_Atelier
- Tiers
- Trame
- TrameL
- TvaCode

* puis copier les tables de l'exercice N vers l'exercice N du nouveau dossier
- Ta_Atelier_Activite
- Ta_Compte_Atelier

* puis mettre � 0 les colonnes "debit_deb" et "credit_deb" de la table plancpt
}
try//finally
  try//except
  //Permet de renommer un dossier existant
  //doit v�rifier l''existance du nouveau nom
  //si c'est le cas, renommer le dossier existant en rajoutant "legrain" en prefixe
  //supprimer le .epi
  //modifier le nom du dossier dans table GestDossier
listeFichier:=Tstringlist.create;

  Retour := False;
  effacerDossier:=false;
  querySelect := TQuery.Create(self);
  QueryUpdate := TQuery.Create(self);
  Chemin :=RepertoirePere(DMProg.daGestDos.DataSet.FindField('Dir_Dossier').AsString);
 // ShowMessage('RepertoirePere : '+chemin);
  NewCode:=DMProg.daGestDos.DataSet.FindField('Nom_Dossier').AsString;
  OldCode:=DMProg.daGestDos.DataSet.FindField('Nom_Dossier').AsString;
  id_dossier:=DMProg.daGestDos.DataSet.FindField('id_Dossier').AsString;
  Direxo:='';
  if(MyInputQuery(self,'code du nouveau dossier','Indiquez le code du nouveau dossier',
      NewCode,'',[#45,#95, #48..#57, #65..#90, #97..#122],10)) then
    begin
    cheminNewDossier:='';
      cheminNewDossier:=IncludeTrailingPathDelimiter(Chemin)+NewCode;
      if(DirectoryExists(cheminNewDossier))then
        begin
          showmessage('Ce dossier existe d�j� dans "'+Chemin+'"');
          abort;
        end;
      if(MyInputQuery(self,'code du premier exercice','Indiquer le code du premier exercice',
        Direxo,'',[#45,#95, #48..#57, #65..#90, #97..#122],10)) then
         begin
            querySelect.DatabaseName := DM_C_NomAliasProgram;
            querySelect.SQL.Add('select Dir_dossier from GestDossier.db where Dir_dossier = '''+IncludeTrailingPathDelimiter(Chemin)+NewCode+'''');
            querySelect.Open;
            if(querySelect.RecordCount>0)then
              begin
                //le nouveau code existe d�j� dans la gestion des dossier
                Application.MessageBox(Pchar('Ce code dossier existe d�j�.'),'Attention',MB_ICONWARNING);
              end
            else
              begin
                listeFichier.Add(Direxo);
                listeFichier.Add('model');
                listeFichier.Add('modelL');
                listeFichier.Add('plancpt');
                listeFichier.Add('ta_activite');
                listeFichier.Add('ta_Affect_Atelier');
                listeFichier.Add('ta_Atelier');
                listeFichier.Add('tiers');
                listeFichier.Add('trame');
                listeFichier.Add('trameL');
                listeFichier.Add('tvaCode');
                listeFichier.Add('ta_atelier_activite');
                listeFichier.Add('ta_compte_atelier');

                CopyAllFilesListe(IncludeTrailingPathDelimiter(Chemin)+OldCode,cheminNewDossier,listeFichier);

                if(DirectoryExists(cheminNewDossier))then
                begin
                 // showmessage('dossier cr�� : '+IncludeTrailingPathDelimiter(Chemin)+NewCode);
                 DeFiltrageDataSet(DMRech.TaGestDossierRech);
                 id_dossier:=IntToStr_Lgr(MaxId_Query(DMRech.TaGestDossierRech,'ID_Dossier'));
                  if (id_dossier<>'')and CreeNouveauDossier(cheminNewDossier,false,true) then
                    begin
                       effacerDossier:=true;
                       CreeNouveauExo(IncludeTrailingPathDelimiter(cheminNewDossier)+Direxo,
                          false,true);

                       QueryUpdate.close;
                       QueryUpdate.SQL.Clear;
                       QueryUpdate.SQL.Add('insert into "'+IncludeTrailingPathDelimiter(e.RepertoireProgram)+'GestDossier.db" ');
                       QueryUpdate.SQL.Add('(id_dossier,id_table,nom_dossier,dir_dossier,nom_exo,dir_exo,annee_dossier,dateUtil,cloture)');
                       QueryUpdate.SQL.Add('values('+id_dossier+','+'1,'''+newCode+''','''+cheminNewDossier+''','''+Direxo+''','''+
                            IncludeTrailingPathDelimiter(cheminNewDossier)+Direxo+''','''+libdates.DateInfos(now).DatePourSQLStr+
                            ''','''+libdates.DateInfos(now).DatePourSQLStr+''',''false'')');
                       QueryUpdate.ExecSQL;

                       QueryUpdate.close;
                       QueryUpdate.SQL.Clear;
                       QueryUpdate.SQL.Add('update "'+IncludeTrailingPathDelimiter(cheminNewDossier)+'plancpt.db"');
                       QueryUpdate.SQL.Add(' set debit_deb=0,credit_deb=0');
                       QueryUpdate.ExecSQL;

                    //showmessage('Mise � jour de la gestion des dossiers');
                    DMProg.SauveGestDossierFichier(NewCode);
                   Application.MessageBox(Pchar('Le dossier a �t� cr�� correctement.'),'Confirmation',MB_ICONEXCLAMATION );
                    DMProg.daGestDos.DataSet.close;
                    DMProg.daGestDos.DataSet.Open;
                    end;
                end
                else Application.MessageBox(Pchar('Le dossier n''a pas pu �tre cr��.'),'Attention',MB_ICONWARNING );
              end;
         end;
    end;
  except
      Application.MessageBox(Pchar('Le dossier n''a pas pu �tre cr��.'),'Attention',MB_ICONWARNING );
      if (effacerDossier)then EffaceDossier(cheminNewDossier);
  end;
finally
   Initialise_TStringlist(listeFichier,self,true);
   querySelect.Free;
   QueryUpdate.Free;
   DMProg.daGestDos.DataSet.Locate('id_dossier',id_dossier,[]);
end;
end;


procedure TAutreDossier.Renommerexercice1Click(Sender: TObject);
var
Dossier,
NewExo,OldExo,Chemin,Direxo:String;
id_dossier,id_exo : String;
querySelect,QueryUpdate:TQuery;
Var Retour: LongBool;
begin
try//finally
  try//except
  //Permet de renommer un dossier existant
  //doit v�rifier l''existance du nouveau nom
  //si c'est le cas, renommer le dossier existant en rajoutant "legrain" en prefixe
  //supprimer le .epi
  //modifier le nom du dossier dans table GestDossier

  Retour := False;
  querySelect := TQuery.Create(self);
  QueryUpdate := TQuery.Create(self);
  Chemin :=RepertoirePere(DMProg.DataSource1.DataSet.FindField('Dir_Exo').AsString);
 // ShowMessage('RepertoirePere : '+chemin);
  Dossier:=DMProg.DataSource1.DataSet.FindField('Nom_Dossier').AsString;
  NewExo:=DMProg.DataSource1.DataSet.FindField('Nom_Exo').AsString;
  OldExo:=DMProg.DataSource1.DataSet.FindField('Nom_Exo').AsString;
  id_dossier:=DMProg.DataSource1.DataSet.FindField('id_Dossier').AsString;
  id_exo:=DMProg.DataSource1.DataSet.FindField('id_table').AsString;
  if(MyInputQueryMAJ(self,'Changement du nom d''exercice','Indiquer le nouveau nom d''exercice',
      NewExo,'',[#45,#95, #48..#57, #65..#90, #97..#122],10)) then
    begin
    querySelect.DatabaseName := DM_C_NomAliasProgram;

    querySelect.SQL.Add('select Nom_Exo from GestDossier.db where Dir_dossier = '''+IncludeTrailingPathDelimiter(Chemin)+''' and Dir_Exo = '''+IncludeTrailingPathDelimiter(Chemin)+NewExo+'''');
    querySelect.Open;
    if(querySelect.RecordCount>0)then
      begin
        //le nouveau code existe d�j� dans la gestion des dossier
        Application.MessageBox(Pchar('Ce nom d''exercice existe d�j� dans le dossier : '+Dossier+'.'),'Attention',MB_ICONWARNING);
      end
    else
      begin
        if(DirectoryExists(IncludeTrailingPathDelimiter(Chemin)))and((DirectoryExists(IncludeTrailingPathDelimiter(Chemin)+NewExo)))then
          begin
            if(DirectoryExists(IncludeTrailingPathDelimiter(Chemin)+NewExo+'_LeGrain'))then
               DeleteFile(IncludeTrailingPathDelimiter(Chemin)+NewExo+'_LeGrain');
            RenameFile(IncludeTrailingPathDelimiter(Chemin)+NewExo,IncludeTrailingPathDelimiter(Chemin)+NewExo+'_LeGrain');
              if(not DirectoryExists(IncludeTrailingPathDelimiter(Chemin)+NewExo+'_LeGrain'))
                     then abort;
          end;
        if (RenommeFolder(PChar(IncludeTrailingPathDelimiter(chemin)+OldExo),     // Nom du fichier d'origine
                   PChar(IncludeTrailingPathDelimiter(Chemin)+NewExo))) then
        //if (DirectoryExists(IncludeTrailingPathDelimiter(Chemin)+NewCode))then
        begin
        //showmessage('file rename : '+IncludeTrailingPathDelimiter(Chemin)+NewCode);

           QueryUpdate.close;
           QueryUpdate.SQL.Clear;
           QueryUpdate.SQL.Add('update "'+IncludeTrailingPathDelimiter(e.RepertoireProgram)+'GestDossier.db" set'+
           ' Dir_exo ='''+IncludeTrailingPathDelimiter(Chemin)+NewExo+''''+
          ' , Nom_Exo ='''+NewExo+
          ''' where id_dossier = '+id_dossier+' and id_table = '+id_exo);
           QueryUpdate.ExecSQL;
        showmessage('Mise � jour de la gestion des dossiers');
        DMProg.SauveGestDossierFichier(Dossier);
       Application.MessageBox(Pchar('L''exercice a �t� renomm�.'),'Confirmation',MB_ICONEXCLAMATION );
        DMProg.daGestDos.DataSet.close;
        DMProg.daGestDos.DataSet.Open;
        if(FileExists(IncludeTrailingPathDelimiter(Chemin)+'.epi'))then DeleteFile(IncludeTrailingPathDelimiter(Chemin)+'.epi');
        end
        else Application.MessageBox(Pchar('L''exercice n''a pas pu �tre renomm�.'),'Attention',MB_ICONWARNING );
      end;
    end;
  except
      Application.MessageBox(Pchar('Le dossier n''a pas pu �tre renomm�.'),'Attention',MB_ICONWARNING );
  end;
finally
   querySelect.Free;
   QueryUpdate.Free;
   DMProg.DataSource1.DataSet.Locate('id_dossier',id_dossier,[]);
end;
end;

end.