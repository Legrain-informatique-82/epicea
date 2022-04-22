unit E2_CreationJournal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, DMJournaux,
  StdCtrls, Grids, DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid, ExtCtrls,LibZoneSaisie,db,
  Menus,DMEcriture,E2_Librairie_Obj,DMConstantes,LibSQL,E2_AideModel,
  RXCtrls,LibGestionParamXML, DMImportation;

type
  TCreationJournal = class(TForm)
    PaGrille: TPanel;
    DBJournaux: TGrDBGrid;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    PaBas: TPanel;
    Patitre: TPanel;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Insrer1: TMenuItem;
    Modifier1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    N2: TMenuItem;
    Prcdent1: TMenuItem;
    Suivant1: TMenuItem;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    RxSBImport: TRxSpeedButton;
    Exporter1: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure TaJournalAfterScroll(DataSet: TDataSet);
    procedure FormDeactivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
   procedure AideEnLigne(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure DBJournauxColExit(Sender: TObject);
    procedure DBJournauxKeyPress(Sender: TObject; var Key: Char);
    procedure Aide1Click(Sender: TObject);
    procedure RxSBImportClick(Sender: TObject);
    procedure DaJournalStateChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Exporter1Click(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  CreationJournal: TCreationJournal;

implementation

uses E2_Main,GR_Librairie_obj, E2_AideAssist, DMAide, E2_AideCompte,DMExports;

{$R *.DFM}

procedure TCreationJournal.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
Patitre.visible:=Main.AfficheTitre;
  DBJournaux.ParamColor:=true;
  DBJournaux.Param:=ParamUtil.CouleurDBGrid;
  DBJournaux.UpDateColor;
  if DMJournal.TaJournal.Active then
  DMJournal.TaJournal.Refresh;
  DMJournal.TaJournal.AfterScroll:=TaJournalAfterScroll;
  DMJournal.TaJournal.AfterScroll(DMJournal.TaJournal);
  DMJournal.DaJournal.OnStateChange:=DaJournalStateChange;
//  DMJournal.DaJournal.OnStateChange:=DaJournalStateChange;
//  screen.OnActiveControlChange:=AideEnLigne;
end;

procedure TCreationJournal.AideEnLigne(Sender: TObject);
var
   aa,result:boolean;
begin
//try
//WinShape(ActiveControl,Shape1,shape2,Main.ContourCouleur);
//if ((AideAssist <> nil) and (AideAssist.Visible)) then
//Result:=DMAides.taAssist.FindKey([self.Name+inttostr(self.tag),ActiveControl.Name]);
//     if not Result then
//        DMAides.taAssist.FindKey(['Vide','Vide']);
//except
//end;
end;
//****************************************************************************//

procedure TCreationJournal.FormCreate(Sender: TObject);
begin
    try
        DMJournal.DaJournal.OnStateChange:=DaJournalStateChange;
	LibGestionParamXML.InitialiseForm(E.USer,Self);
    except
        Position:=poDesigned;
        InitialiseFormPosDefaut(self);
	//Left:= 0; Top:= 70; Width:= screen.Width; Height:= screen.Height-top;
    end;
end;

Procedure TCreationJournal.InitialiseTable_A_Nil;
Begin
 if DMJournal<>nil then
  InitDatasetEvent_A_Nil_Sur_Form([DMJournal.TaJournal,DMJournal.DaJournal]);
End;

procedure TCreationJournal.FormDestroy(Sender: TObject);
begin
  InitialiseTable_A_Nil;
  LibGestionParamXML.DestroyForm(Self,E.USer);
  CreationJournal:=nil;
end;

procedure TCreationJournal.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TCreationJournal.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TCreationJournal.TaJournalAfterScroll(DataSet: TDataSet);
begin
if DataSet.State = dsBrowse then
BtnSupprimer.Enabled:=DataSet.FindField('ID_Journal').AsInteger <> DataSet.FindField('ID').AsInteger;
if DataSet.FindField('ID').AsInteger = DataSet.FindField('ID_Journal').AsInteger then
   Begin
     DMJournal.ReadOnlyChamps(dataset,true);
   End
   else
   if DetailEcritureJournal(DataSet.FindField('Journal').AsString,false) then
       Begin
         DMJournal.ReadOnlyChamps(dataset,true);
       End
       else
            DMJournal.ReadOnlyChamps(dataset,false);
end;


procedure TCreationJournal.FormDeactivate(Sender: TObject);
begin
DMJournal.TaJournal.AfterScroll:=nil;
DMJournal.DaJournal.OnStateChange:=nil;

end;

procedure TCreationJournal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//WinSuivPrec(Handle,key,[DBJournaux,DBJournaux.InplaceEditor]);
  WinSuivPrec(Handle,key,[DBJournaux]);
     If Key = VK_ESCAPE Then
     Begin

       If DBJournaux.DataSource.State = dsBrowse Then
          begin
            if DBJournaux.Focused then Self.Close else DBJournaux.SetFocus;
          end;

      If DBJournaux.DataSource.State = dsInsert Then
          Begin
               If Messagedlg('Voulez vous annuler la création de ce journal ?',MtConfirmation,[mbno,mbyes],0) = mryes Then
               Begin
                    DBJournaux.DataSource.dataset.Cancel;
                    Abort;
               End
               Else
               Begin
                    Abort;
               End;
          End;

          If DBJournaux.DataSource.dataset.State = dsEdit Then
          Begin
               If Messagedlg('Voulez-vous annuler les modifications de ce journal ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    DBJournaux.DataSource.dataset.Cancel;
                    Abort;
               End
               Else
               Begin
                    Abort;
               End
          End;
    end;

end;

procedure TCreationJournal.PaGrilleResize(Sender: TObject);
begin
DBJournaux.ColWidths[1]:=(DBJournaux.Width) div 11;
DBJournaux.ColWidths[2]:=(DBJournaux.Width) div 11;
DBJournaux.ColWidths[3]:=(DBJournaux.Width) div 11;
DBJournaux.ColWidths[4]:=((DBJournaux.Width) div 11)*2;
DBJournaux.ColWidths[5]:=((DBJournaux.Width) div 11)*5;
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TCreationJournal.PaBtnResize(Sender: TObject);
begin
  FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TCreationJournal.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TCreationJournal.BtnEnregistrerClick(Sender: TObject);
begin
  try
  TableGerePost(DBJournaux.DataSource.DataSet);
  except
  abort;
  end;//fin du try
end;

procedure TCreationJournal.BtnInsererClick(Sender: TObject);
begin
  TableAjoute(DBJournaux.DataSource.DataSet);
end;

procedure TCreationJournal.BtnModifierClick(Sender: TObject);
begin
DBJournaux.DataSource.DataSet.Edit;
end;

procedure TCreationJournal.BtnSupprimerClick(Sender: TObject);
begin
 TableGereDelete(DBJournaux.DataSource.DataSet);
end;

procedure TCreationJournal.BtnFermerClick(Sender: TObject);
begin
self.close;
end;

procedure TCreationJournal.BtnImprimerClick(Sender: TObject);
begin
//
end;

procedure TCreationJournal.Visualisation1Click(Sender: TObject);
begin
 DetailEcritureJournal(AideModelJournal(DBJournaux.DataSource.DataSet.FindField('ID_Journal').AsInteger),true)
end;

procedure TCreationJournal.DBJournauxColExit(Sender: TObject);
var
ExceptLGR:TExceptLGR;
begin
  case DBJournaux.DataSource.DataSet.State of
     dsInsert:Begin
                // Vérification des données utilisateur
                try
                 ExceptLGR:=DMJournal.CtrlSaisieDMJournal(DBJournaux.SelectedField);
                except
                 case ExceptLGR.NumErreur of
                    1000,1001,1002,1003:begin
                               DBJournaux.DataSource.dataset.Fields[1].FocusControl;
                               abort;
                              end;
                    2000,2001:begin
                               DBJournaux.DataSource.dataset.Fields[2].FocusControl;
                               abort;
                              end;
                    4000,4001,4002,4003,4004,4005:begin
                          DBJournaux.DataSource.dataset.Fields[4].FocusControl;
                          abort;
                          end;
                    5000,5001:begin
                          DBJournaux.DataSource.dataset.Fields[5].FocusControl;
                          abort;
                          end;
                 end;
                end;
              End;
     dsEdit:Begin
              // Vérification des données utilisateur
              try
               ExceptLGR:=DMJournal.CtrlSaisieDMJournal(DBJournaux.SelectedField);
              except
               case ExceptLGR.NumErreur of
                    1000,1001,1002,1003:begin
                               DBJournaux.DataSource.dataset.Fields[1].FocusControl;
                               abort;
                              end;
                    2000,2001:begin
                               DBJournaux.DataSource.dataset.Fields[2].FocusControl;
                               abort;
                              end;
                    4000,4001,4002,4003,4004,4005:begin
                          DBJournaux.DataSource.dataset.Fields[4].FocusControl;
                          abort;
                          end;
                    5000,5001:begin
                          DBJournaux.DataSource.dataset.Fields[5].FocusControl;
                          abort;
                          end;
               end;
              end;
            End;
  end;

end;

procedure TCreationJournal.DBJournauxKeyPress(Sender: TObject;
  var Key: Char);
begin
case DBJournaux.SelectedIndex of
   0,1:key := upcase(key);
//   : ;
end;


end;

procedure TCreationJournal.Aide1Click(Sender: TObject);
begin
if ActiveControl = DBJournaux then
 begin
  DMJournal.AideDMJournal(DBJournaux.SelectedField);
 end;
end;

procedure TCreationJournal.RxSBImportClick(Sender: TObject);
begin
  DBJournaux.DataSource.DataSet.DisableControls;
  DMImport.Import_Journaux(DBJournaux.DataSource.DataSet,True);
  ChangementEtatBouttons(BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer,DBJournaux.DataSource.DataSet);
  DBJournaux.DataSource.DataSet.EnableControls;
end;

procedure TCreationJournal.DaJournalStateChange(Sender: TObject);
begin
  ChangementEtatGrille(DBJournaux);
  ChangementEtatBouttons(BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer,DBJournaux.DataSource.DataSet);
end;
procedure TCreationJournal.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
try
canclose:=true;
if DMJournal <> nil then
 begin
  // Si l'utilisateur est en mode Insertion
     If DBJournaux.DataSource.State = dsInsert Then
     Begin
          If BtnEnregistrer.Enabled Then
          Begin
                if application.MessageBox(Pchar('Voulez-vous enregistrer ce nouveau journal ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
                 begin
                   BtnEnregistrerClick(btnenregistrer);
                  end
                  else
                   begin
                   DBJournaux.DataSource.dataset.Cancel;
                   end;
          End
          Else
          Begin
                if application.MessageBox(Pchar('Voulez-vous annuler la création ce nouveau journal ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
                begin
                  DBJournaux.DataSource.dataset.Cancel;
                end
               Else
                 begin
                  canclose:=false;
                  end;
          End;
     End; // Fin utilisateur est en mode Insertion

     // Si l'utilisateur est en mode Modification
     If DBJournaux.DataSource.State = dsEdit Then
     Begin
           if application.MessageBox(Pchar('Voulez-vous enregistrer les modifications de ce journal ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
           begin
            BtnEnregistrerClick(btnenregistrer);
             end
             else
             begin
              DBJournaux.DataSource.dataset.Cancel;
             end;
     End; // Fin utilisateur est en mode Modification
  end;//fin si DMEmprunts <> nil
except
  canclose:=false;
end;
if CanClose then InitialiseTable_A_Nil{ isa  le  29/01/04 }
 else
 begin
    if DMJournal=nil then
   DMJournal:=DMJournal.Create(self);

   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(self);

 end;

end;

procedure TCreationJournal.Exporter1Click(Sender: TObject);
begin
ExportDonnees(DBJournaux.DataSource.DataSet,E.RepertoireExportDossier,'Liste_Journaux_'+E.NomDossier + E.NomExo + '.Txt');
end;

procedure TCreationJournal.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(nil);
end;

end.
