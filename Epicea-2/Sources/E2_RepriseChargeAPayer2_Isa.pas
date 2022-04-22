unit E2_RepriseChargeAPayer2_Isa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Gr_Librairie_obj, E2_Librairie_obj, Grids, DBGrids, Db,
  DBTables, E2_AideCompte, LibSQL, Menus, Buttons, DBCtrls,DMPiece,
  DMDepenses,DMEcriture, RXDBCtrl, ExRxDBGrid, GrDBGrid,LibZoneSaisie,
  LibRessourceString,
  RXCtrls,DMConstantes,E2_AideModel, LibGestionParamXML, jpeg;

type
  TRepriseChargeAPayer2_Isa = class(TForm)
    PaBtnHaut: TPanel;
    SBPCA: TSpeedButton;
    SBCCA: TSpeedButton;
    Panel2: TPanel;
    Label2: TLabel;
    DBText1: TDBText;
    DBText2: TDBText;
    Label3: TLabel;
    DBText3: TDBText;
    Label4: TLabel;
    Label5: TLabel;
    Patitre: TPanel;
    PaGrille: TPanel;
    PaBtn: TPanel;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    PaBas: TPanel;
    DBGrid1: TGrDBGrid;
    DBGrid2: TGrDBGrid;
    BtnAnnuler: TButton;
    BtnImprimer: TButton;
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
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    procedure AideEnLigne(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1Enter(Sender: TObject);
    procedure DBGrid2ColEnter(Sender: TObject);
    procedure DBGrid2Exit(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SBCCAClick(Sender: TObject);
    procedure SBPCAClick(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure PaBtnHautResize(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure Aideenligne1Click(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Visualisation1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  RepriseChargeAPayer2_Isa: TRepriseChargeAPayer2_Isa;
  Changement: Boolean;

implementation

uses
    //UQReport,
    E2_AideAssist, DMAide, E2_Main;

{$R *.DFM}


procedure TRepriseChargeAPayer2_Isa.AideEnLigne(Sender: TObject);
var
   aa,result:boolean;
begin
try
//WinShape(ActiveControl,Shape1,shape2,Main.ContourCouleur);
if ((AideAssist <> nil) and (AideAssist.Visible)) then
Result:=DMAides.taAssist.FindKey([self.Name+inttostr(self.tag),ActiveControl.Name]);
     if not Result then
        DMAides.taAssist.FindKey(['Vide','Vide']);
except;
end;
end;

//****************************************************************************//
// Gestion de la création de la fenêtre.                                      //
//****************************************************************************//
procedure TRepriseChargeAPayer2_Isa.FormCreate(Sender: TObject);
begin
    try 
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
        InitialiseFormPosDefaut(self);
    end;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du Show de la fenêtre.                                             //
//****************************************************************************//
procedure TRepriseChargeAPayer2_Isa.FormShow(Sender: TObject);
begin
//     Indice := True;
     Changement := False;

     DBText1.DataSource := DMPieces.DataReprise1;
     DBText1.DataField := 'Reference';
     DBText2.DataSource := DMPieces.DataReprise1;
     DBText2.DataField := 'Libelle';
     DBText3.DataSource := DMPieces.DataReprise1;
     DBText3.DataField := 'Date';

if (SBCCA.Visible=true)and (SBPCA.Visible=true) then
     begin
     if SBCCA.Down= True
       then
         begin
          SBCCAClick(SBCCA);
         end
       else
         begin
           SBPCAClick(SBPCA);
         end;
     end else
     begin
      DMPieces.DataReprise1.DataSet.Close;
      DBGrid1.DataSource:=DMPieces.DataReprise1;
      DMPieces.DataReprise1.DataSet.Open;
      DMEcritures.TaEcriture2.Close;
      DBGrid2.DataSource:=DMEcritures.DataEcriture2;
      DMEcritures.TaEcriture2.MasterSource:=DMPieces.DataReprise1;
      DMEcritures.TaEcriture2.MasterFields:='ID';
      DMEcritures.TaEcriture2.open;
      DBGrid2.Refresh;
     end;


end;
//****************************************************************************//


//****************************************************************************//
// Gestion de la fermeture de la fenêtre.                                     //
//****************************************************************************//
procedure TRepriseChargeAPayer2_Isa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     If ((DBGrid2.DataSource<>nil)and(DBGrid2.DataSource.State = dsEdit)) Then
     Begin
       If Messagedlg('Voulez-vous enregistrer les modifications du libellé ?',mtconfirmation,[mbyes,mbno],0) = mryes Then
          TableGerePost(DMEcritures.TaEcriture2);
     End;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion de la mémoire.                                                     //
//****************************************************************************//
procedure TRepriseChargeAPayer2_Isa.FormDestroy(Sender: TObject);
begin


try
  try
        DBGrid1.DataSource:=nil;
        DBText1.DataSource:=nil;
        DBText2.DataSource:=nil;
        DBText3.DataSource:=nil;
        DBGrid2.DataSource:=nil;
        if DMEcritures<>nil then
          begin
              DMEcritures.TaEcriture2.close;
              DMEcritures.TaEcriture2.MasterSource:=nil;
              DMEcritures.TaEcriture2.MasterFields:='';
          end;

     LibGestionParamXML.DestroyForm(Self,E.USer);
  except
    //
  end;
finally
  RepriseChargeAPayer2_Isa := Nil;
end;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion des touches dans DBGrid1.                                          //
//****************************************************************************//
procedure TRepriseChargeAPayer2_Isa.DBGrid1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
     If ((Key = VK_RETURN) Or (Key = VK_TAB)) Then DBGrid1DblClick(Sender);
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du double click dans DBGrid1.                                      //
//****************************************************************************//
procedure TRepriseChargeAPayer2_Isa.DBGrid1DblClick(Sender: TObject);
begin
     DBGrid2.SelectedIndex := 1;
     DBGrid2.SetFocus;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion de la réception de la focalisation pour les DBGrids.               //
//****************************************************************************//
procedure TRepriseChargeAPayer2_Isa.DBGrid1Enter(Sender: TObject);
begin
     If DBGrid2.Focused Then
     Begin
          DBGrid2.SelectedIndex := 1;
     End;
end;


//****************************************************************************//
// Bloquer l'utilisateur dans la colonne 1 de DBGrid2.                        //
//****************************************************************************//
procedure TRepriseChargeAPayer2_Isa.DBGrid2ColEnter(Sender: TObject);
begin
     DBGrid2.SelectedIndex := 1;
end;
//****************************************************************************//



//****************************************************************************//
// Gestion de la sortie de DBGrid2.                                           //
//****************************************************************************//
procedure TRepriseChargeAPayer2_Isa.DBGrid2Exit(Sender: TObject);
begin
     If ((ActiveControl.Name = 'DBGrid1') Or (ActiveControl.Name = 'BtnFermer')) Then
     Begin
          If Changement Then
          Begin
               Changement := False;
          End
          Else
          Begin
               If empty(DMEcritures.TaEcriture2.FindField('Libelle').AsString) Then
               Begin
                    Messagedlg('Le libellé doit être obligatoirement renseigné !!!',MtWarning,[mbok],0);
                    DBGrid2.SetFocus;
                    Abort;
               End;
          End;
     End;
end;
//****************************************************************************//

//****************************************************************************//
// Gestion du click sur le bouton Fermer.                                     //
//****************************************************************************//
procedure TRepriseChargeAPayer2_Isa.BtnFermerClick(Sender: TObject);
begin
modalresult:=mrOk;
//     Self.Close;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion des touches dans la fenêtre.                                       //
//****************************************************************************//
procedure TRepriseChargeAPayer2_Isa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     If Key = VK_ESCAPE Then
     Begin
          If Not (DBGrid2.DataSource.State = dsEdit) Then
            modalresult:=mrOk
//             Self.Close
          Else
             DMEcritures.TaEcriture2.Cancel;
     End;
end;
//****************************************************************************//



//****************************************************************************//
// Gestion du click sur le SpeedBouton Charges à Payer.                       //
//****************************************************************************//
procedure TRepriseChargeAPayer2_Isa.SBCCAClick(Sender: TObject);
begin
     Changement := True;
     TableRefresh(DMPieces.DataReprise1.DataSet,'ID');

      { isa  le  10/10/03 }
      DMPieces.DataReprise1.DataSet.Close;
      DBGrid1.DataSource:=DMPieces.DataReprise1;
      DBText1.DataSource:=DMPieces.DataReprise1;
      DBText2.DataSource:=DMPieces.DataReprise1;
      DBText3.DataSource:=DMPieces.DataReprise1;
      DMPieces.DataReprise1.DataSet.Open;

      DMEcritures.TaEcriture2.Close;
      DBGrid2.DataSource:=DMEcritures.DataEcriture2;
      DMEcritures.TaEcriture2.MasterSource:=DBGrid1.DataSource;
      DMEcritures.TaEcriture2.MasterFields:='ID';
      DMEcritures.TaEcriture2.open;
      DBGrid2.Refresh;
      { isa  le  10/10/03 }

     DBGrid1.SetFocus;
     SBCCA.Font.Color := clRed;
     SBPCA.Font.Color := clWindowText;
     SBCCA.Down := True;
     SBPCA.Down := False;


end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click sur le SpeedBouton Produits à Recevoir.                   //
//****************************************************************************//
procedure TRepriseChargeAPayer2_Isa.SBPCAClick(Sender: TObject);
begin
     Changement := True;
     TableRefresh(DMPieces.DataReprise2.DataSet,'ID');

      { isa  le  10/10/03 }
      DMPieces.DataReprise2.DataSet.Close;
      DBGrid1.DataSource:=DMPieces.DataReprise2;
      DBText1.DataSource:=DMPieces.DataReprise2;
      DBText2.DataSource:=DMPieces.DataReprise2;
      DBText3.DataSource:=DMPieces.DataReprise2;
      DMPieces.DataReprise2.DataSet.Open;

      DMEcritures.TaEcriture2.Close;
      DBGrid2.DataSource:=DMEcritures.DataEcriture2;
      DMEcritures.TaEcriture2.MasterSource:=DBGrid1.DataSource;
      DMEcritures.TaEcriture2.MasterFields:='ID';
      DMEcritures.TaEcriture2.open;
      DBGrid2.Refresh;
      { isa  le  10/10/03 }


     DBGrid1.SetFocus;
     SBCCA.Font.Color := clWindowText;
     SBPCA.Font.Color := clRed;
     SBCCA.Down := False;
     SBPCA.Down := True;

end;
//****************************************************************************//

procedure TRepriseChargeAPayer2_Isa.PaGrilleResize(Sender: TObject);
begin

  DBGrid1.ColWidths[0]:=(DBGrid1.Width) div 9;
  DBGrid1.ColWidths[1]:=(DBGrid1.Width) div 5;
  DBGrid1.ColWidths[2]:=(DBGrid1.Width) div 2;

  DBGrid2.ColWidths[0]:=(DBGrid2.Width) div 7;
  DBGrid2.ColWidths[1]:=(DBGrid2.Width) div 2;
  DBGrid2.ColWidths[2]:=(DBGrid2.Width) div 7;
  DBGrid2.ColWidths[3]:=(DBGrid2.Width) div 7;

  WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TRepriseChargeAPayer2_Isa.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
//BtnAnnuler.Left:=(PaBtn.Width-630) div 2;
//BtnEnregistrer.Left:=BtnAnnuler.Left +89;
//BtnInserer.Left:=BtnAnnuler.Left+178;
//BtnModifier.Left:=BtnAnnuler.Left+267;
//BtnSupprimer.Left:=BtnAnnuler.Left+356;
//BtnFermer.Left:=BtnAnnuler.Left+445;
//BtnImprimer.left:=BtnAnnuler.Left+534;
end;

procedure TRepriseChargeAPayer2_Isa.PaBtnHautResize(Sender: TObject);
begin
SBCCA.left:=(PaBtnHaut.width-530) div 3;
SBPCA.Left:=(PaBtnHaut.width-265-SBCCA.left);

end;

procedure TRepriseChargeAPayer2_Isa.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TRepriseChargeAPayer2_Isa.BtnImprimerClick(Sender: TObject);
begin
MessageDlg(EditionUlterieure, mtInformation, [mbOK], 0);
//if (FPrint = nil) then FPrint:=TFPrint.Create(self);
//FPrint.SelectionEtat := 8;
//FPrint.show;
end;

procedure TRepriseChargeAPayer2_Isa.Aideenligne1Click(Sender: TObject);
begin
if AideAssist = Nil then AideAssist:= TAideAssist.Create(Self);
if AideAssist.Visible then
     begin
      AideAssist.close;
      self.show;
     end
     else begin
      AideAssist.Show;
      self.show;
     end;
end;

procedure TRepriseChargeAPayer2_Isa.Aide1Click(Sender: TObject);
begin
//begin
// If activecontrol = DBCAR Then
//  begin
//   case DBCAR.DataSource.State of
//      dsbrowse:case self.tag of
//                  1:case DBCAR.SelectedIndex of
//                     0:Rechercher(DBCAR,DMChargeRepartir.TaCar,['Designation','DateSaisie'],['Désignation',''],'',0);
////                     1:Rechercher(DBCAR,DMChargeRepartir.TaCar,['Designation','Reference','DateSaisie'],['Désignation','Références',''],'',0);
//                    end;
//                  2:case DBCAR.SelectedIndex of
////                     0:Rechercher(DBCAR,DMChargeRepartir.TaCar,['Reference','Designation','DateSaisie'],['Références','Désignation',''],'',0);
//                     1:Rechercher(DBCAR,DMChargeRepartir.TaCar,['Designation','Reference','DateSaisie'],['Désignation','Références',''],'',0);
//                    end;
//               end;
//
//
//   end;
// end;

end;

procedure TRepriseChargeAPayer2_Isa.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);

DBGrid1.ParamColor:=true;
DBGrid1.Param:=ParamUtil.CouleurDBGrid;
DBGrid1.UpDateColor;

DBGrid2.ParamColor:=true;
DBGrid2.Param:=ParamUtil.CouleurDBGrid;
DBGrid2.UpDateColor;

Patitre.visible:=Main.AfficheTitre;
DBGrid1.SetFocus;

DBGrid2.Refresh;
end;

procedure TRepriseChargeAPayer2_Isa.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TRepriseChargeAPayer2_Isa.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TRepriseChargeAPayer2_Isa.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
canclose:=true;
end;

procedure TRepriseChargeAPayer2_Isa.Visualisation1Click(Sender: TObject);
begin
if ActiveControl = DBGrid2 then
DetailEcritureCompte(DMEcritures.TaEcriture2.FindField('Compte').AsString,true,False)
else
DetailEcritureJournal(AideModelJournal(3),true);
end;

end.
