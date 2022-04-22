unit ComptesBancaires;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid, StdCtrls,
  RXCtrls, jpeg, ExtCtrls,DB, Menus,DBTables,E2_Decl_Records;

type



  TE2_ComptesBancaires = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    Panel2: TPanel;
    PaBas: TPanel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    PaGrille: TPanel;
    grComptesBancaires: TGrDBGrid;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    Exporter1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Modifier1: TMenuItem;
    Insrer1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    BtnInserer: TButton;
    procedure PaGrilleResize(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure changementEtatBoutons(Sender: TObject);
    Procedure DaComptesBancairesStateChange(sender:TObject);
    procedure Aide1Click(Sender: TObject);
    procedure grComptesBancairesColExit(Sender: TObject);
    procedure grComptesBancairesKeyPress(Sender: TObject; var Key: Char);
    procedure grComptesBancairesColEnter(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure grComptesBancairesDblClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
        TitreForm,SousTitreForm:String;
        modification:boolean;
        compte,journal,login,pwd,site:string;
  end;

var
  E2_ComptesBancaires: TE2_ComptesBancaires;

  Function AfficheCompteBanque(EditCompte:TCustomEdit;ForceAffiche:Boolean=false):retourCompteBancaire;

implementation

uses DmImportReleves, E2_Main, LibZoneSaisie, E2_Librairie_Obj,
  LibGestionParamXML, DMConstantes, LibSQL, E2_LibInfosTable,
   LibChoixCompte, Gr_Librairie_Obj;

{$R *.dfm}

Function AfficheCompteBanque(EditCompte:TCustomEdit;ForceAffiche:Boolean):retourCompteBancaire;
Begin
if (E2_ComptesBancaires = Nil) then
E2_ComptesBancaires:= TE2_ComptesBancaires.Create(Application.MainForm);


DeFiltrageDataSet(DMImportReleve.TaComptesBancaire);
result.retour:=DMImportReleve.TaComptesBancaire.Locate('CodeBancaire',EditCompte.Text,[]);
Result.Arecupere:=false;
If ForceAffiche then
 begin
  result.retour:= (E2_ComptesBancaires.ShowModal = mrOk);
  if result.retour then
       begin
         EditCompte.Text:= E2_ComptesBancaires.grComptesBancaires.DataSource.DataSet.findfield('codeBancaire').AsString;
         result.compte:=E2_ComptesBancaires.grComptesBancaires.DataSource.DataSet.findfield('codeBancaire').AsString;
         result.journal:=E2_ComptesBancaires.grComptesBancaires.DataSource.DataSet.findfield('journal').AsString;
         result.login:=E2_ComptesBancaires.grComptesBancaires.DataSource.DataSet.findfield('login').AsString;
         result.password:=E2_ComptesBancaires.grComptesBancaires.DataSource.DataSet.findfield('password').AsString;
          result.site:=E2_ComptesBancaires.grComptesBancaires.DataSource.DataSet.findfield('site').AsString;
          Result.Arecupere:=true;
       end;
 end
else
 begin
  if not result.retour then
    begin
     result.retour:= (E2_ComptesBancaires.ShowModal = mrOk);
     if result.retour then
       begin
//         EditCompte.Text:= E2_ComptesBancaires.compte;
//         result.compte:=E2_ComptesBancaires.compte;
//         result.journal:=E2_ComptesBancaires.journal;
         EditCompte.Text:= E2_ComptesBancaires.grComptesBancaires.DataSource.DataSet.findfield('codeBancaire').AsString;
         result.compte:=E2_ComptesBancaires.grComptesBancaires.DataSource.DataSet.findfield('codeBancaire').AsString;
         result.journal:=E2_ComptesBancaires.grComptesBancaires.DataSource.DataSet.findfield('journal').AsString;
         result.login:=E2_ComptesBancaires.grComptesBancaires.DataSource.DataSet.findfield('login').AsString;
         result.password:=E2_ComptesBancaires.grComptesBancaires.DataSource.DataSet.findfield('password').AsString;
          result.site:=E2_ComptesBancaires.grComptesBancaires.DataSource.DataSet.findfield('site').AsString;
          Result.Arecupere:=true;
        end;
    end;
 end;

End;

procedure TE2_ComptesBancaires.PaGrilleResize(Sender: TObject);
begin
FormateTailleColonne(grComptesBancaires,15,[2,1,3,3,6]);
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TE2_ComptesBancaires.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer],PaBtn,90,0);
end;

procedure TE2_ComptesBancaires.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
grComptesBancaires.ParamColor:=true;
grComptesBancaires.Param:=ParamUtil.CouleurDBGrid;
grComptesBancaires.UpDateColor;
Patitre.visible:=Main.AfficheTitre;
DMImportReleve.DaComptesBancaires.DataSet.Open;
DMImportReleve.DaComptesBancaires.DataSet.Refresh;
DMImportReleve.DaComptesBancaires.OnStateChange:=DaComptesBancairesStateChange;
end;

procedure TE2_ComptesBancaires.FormCreate(Sender: TObject);
begin
    try
	   LibGestionParamXML.InitialiseForm(E.User,Self);
     if DMImportReleve=nil then DMImportReleve:=TDMImportReleve.Create(self);
    except
        Position:=poScreenCenter;
        InitialiseFormPosDefaut(self);
    end;
end;

procedure TE2_ComptesBancaires.FormDestroy(Sender: TObject);
begin
DMImportReleve.DaComptesBancaires.OnStateChange:=nil;
 TableGereClose(DMImportReleve.TaComptesBancaire);
 LibGestionParamXML.DestroyForm(Self,E.USer);
 E2_ComptesBancaires:=nil;
end;

procedure TE2_ComptesBancaires.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
WinSuivPrec(Handle,key,[grComptesBancaires,grComptesBancaires.InplaceEditor]);
     If Key = VK_ESCAPE Then
     Begin
       If DMImportReleve.DaComptesBancaires.State = dsBrowse Then
          begin
            if grComptesBancaires.Focused then Self.Close else grComptesBancaires.SetFocus;
          end;

          If DMImportReleve.DaComptesBancaires.State = dsEdit Then
          Begin
               If Messagedlg('Annuler les modifications de ce paramètrage de compte ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    DMImportReleve.TaComptesBancaire.Cancel;
                    Abort;
               End
               Else
               Begin
                    Abort;
               End
          End;
     End;

end;

procedure TE2_ComptesBancaires.FormShow(Sender: TObject);
begin
PaTitre.Visible:=Main.AfficheTitre;
DaComptesBancairesStateChange(DMImportReleve.DaComptesBancaires);
end;

procedure TE2_ComptesBancaires.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TE2_ComptesBancaires.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TE2_ComptesBancaires.BtnEnregistrerClick(Sender: TObject);
begin
try
grComptesBancairesColExit(grComptesBancaires);
TableGerePost(DMImportReleve.TaComptesBancaire);
changementEtatBoutons(nil);
grComptesBancaires.SetFocus;
except
   ModalResult:=mrNone;
end;
end;

procedure TE2_ComptesBancaires.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TE2_ComptesBancaires.BtnModifierClick(Sender: TObject);
begin
DMImportReleve.TaComptesBancaire.Edit;
end;


procedure TE2_ComptesBancaires.changementEtatBoutons(Sender: TObject);
begin
  case  DMImportReleve.DaComptesBancaires.state of
   dsBrowse: begin
                 BtnEnregistrer.Enabled := false;
                 BtnModifier.Enabled := Not( DMImportReleve.TaComptesBancaire.RecordCount = 0);
                 BtnSupprimer.Enabled := Not( DMImportReleve.TaComptesBancaire.RecordCount = 0);
             end;

   dsEdit,dsInsert:   begin
               BtnEnregistrer.Enabled := True;
               BtnModifier.Enabled := false;
               BtnSupprimer.Enabled := False;
             end;
   end;//fin du case.state$
   //Pop-up Menu
   Fermer1.Enabled:=BtnFermer.Enabled;
   Enregister1.Enabled:=BtnEnregistrer.Enabled;
   Modifier1.Enabled:=BtnModifier.Enabled;
   Supprimer1.Enabled:=BtnSupprimer.Enabled;
end;

Procedure TE2_ComptesBancaires.DaComptesBancairesStateChange(sender:TObject);
begin
// Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DMImportReleve.DaComptesBancaires.DataSet);
case DMImportReleve.DaComptesBancaires.State of
   dsEdit:Begin
             grComptesBancaires.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
             grComptesBancaires.SetFocus;
             grComptesBancaires.TitreColor(true);
             modification:=true;
          End;
   dsbrowse:Begin
             grComptesBancaires.Options := [dgediting,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
             if grComptesBancaires.Visible then grComptesBancaires.SetFocus;
             if grComptesBancaires.InplaceEditor <> nil then
                grComptesBancaires.EditorMode:=false;
             grComptesBancaires.TitreColor(true);
          End;
end;
changementEtatBoutons(Sender);
if(grComptesBancaires.DataSource.DataSet.RecordCount>0)then
  begin
    compte:=grComptesBancaires.DataSource.DataSet.findfield('codeBancaire').AsString;
    journal:=grComptesBancaires.DataSource.DataSet.findfield('journal').AsString;
    login:=grComptesBancaires.DataSource.DataSet.findfield('login').AsString;
    pwd:=grComptesBancaires.DataSource.DataSet.findfield('password').AsString;
    site:=grComptesBancaires.DataSource.DataSet.findfield('site').AsString;
  end;
end;


procedure TE2_ComptesBancaires.Aide1Click(Sender: TObject);
var
requete:TQuery;
infosJournal:TInfosModel;
ParamAffichCompte:TParamAffichCompte;
ResultStrList:TResultStrList;
begin
try//finally
                  InitialiseParamAffichCompte(ParamAffichCompte);
                  ParamAffichCompte.Titre:='Sélectionnez un journal de banque';
                  ParamAffichCompte.Tiers:=false;
                  requete:=TQuery.create(self);
                  requete.close;
                  requete.SQL.Clear;
                  requete.DatabaseName := DM_C_NomAliasDossier;
                  requete.SQL.Add('select code,libelle_model,journal,compte from model.db');
                  requete.Open;
                  ParamAffichCompte.Dataset:=requete;

                  ParamAffichCompte.Filtrer:=false;
                  ParamAffichCompte.FiltreNbChiffre := 0;
                  ParamAffichCompte.ListeChamps.Add('code');
                  ParamAffichCompte.ListeChamps.Add('libelle_model');
                  ParamAffichCompte.ListeChamps.Add('journal');
                  ParamAffichCompte.ListeChamps.Add('compte');
                  ParamAffichCompte.EventButtonAjouterClick:=nil;
                  ParamAffichCompte.EventButtonSupprimerClick:=nil;
          ResultStrList:=ChoixCompteAffich(ParamAffichCompte);
          if (ResultStrList.Result)and(ResultStrList.Liste.Count>0) then
          begin
             TableGereEdit(DMImportReleve.TaComptesBancaire);
             DMImportReleve.TaComptesBancaire.FindField('Journal').AsString :=
              ResultStrList.Liste.Strings[ResultStrList.Liste.Count-1];
          end;
finally
  requete.close;
  requete.Free;
  if ResultStrList.Liste<>nil then Initialise_TStringlist(ResultStrList.Liste,self);
  LibereParamAffichCompte(ParamAffichCompte);
end;
end;

procedure TE2_ComptesBancaires.grComptesBancairesColExit(Sender: TObject);
var
Erreur:TErreurSaisie;
begin
  case grComptesBancaires.DataSource.State of
     dsEdit:Begin
              Erreur:=DMImportReleve.CtrlSaisieComptesBancaires(grComptesBancaires.SelectedField);
              if Erreur.Retour= false then
                 begin
                  case Erreur.CodeErreur of
                     1000:begin
                            showmessage('Ce journal n''est pas valide');
                            grComptesBancaires.SelectedField.FocusControl;
                            abort;
                          end;
                  end;
                 end;
              End;
  end;
end;

procedure TE2_ComptesBancaires.grComptesBancairesKeyPress(Sender: TObject;
  var Key: Char);
begin
	if (Key = #13) then BtnEnregistrer.Click;
end;

procedure TE2_ComptesBancaires.grComptesBancairesColEnter(Sender: TObject);
begin
//if grComptesBancaires.Col=1 then grComptesBancaires.Col:=2;
end;

procedure TE2_ComptesBancaires.BtnFermerClick(Sender: TObject);
begin
ModalResult:=mrOk;
end;

procedure TE2_ComptesBancaires.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
try//finally
canclose:=true;
  try//except
      if DMImportReleve <> nil then
       begin
           If DMImportReleve.TaComptesBancaire.State = dsEdit Then
           Begin
             self.WindowState:=wsNormal;
             self.BringToFront;
                If Messagedlg('Voulez-vous enregistrer les modifications de ce compte ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                 begin
                  BtnEnregistrer.click;
                   end
                   else
                   begin
                    DMImportReleve.TaComptesBancaire.Cancel;
                   end;
           End; // Fin utilisateur est en mode Modification
       end;
  except
    canclose:=false;
    ModalResult:=mrnone;
  end;
if(canclose)then DMImportReleve.DaComptesBancaires.OnStateChange:=nil;
//  ModalResult:=mrOk;
finally
    //DMImportReleve.DaComptesBancaires.DataSet.close;
end;

end;

procedure TE2_ComptesBancaires.BtnSupprimerClick(Sender: TObject);
begin
if application.MessageBox(Pchar('Etes-vous sûr de vouloir supprimer le paramètrage en cours ?')
  ,'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
  begin
      TableGereDelete(grComptesBancaires.DataSource.DataSet);
      modification:=true;
  end;
end;

procedure TE2_ComptesBancaires.BtnInsererClick(Sender: TObject);
begin
TableAjoute(DMImportReleve.TaComptesBancaire);
DMImportReleve.TaComptesBancaire.FindField('id').AsInteger:=MaxId_Query(DMImportReleve.TaCompteBancaireTemp,'id');
end;

procedure TE2_ComptesBancaires.grComptesBancairesDblClick(Sender: TObject);
begin
BtnFermer.Click;
end;

end.
