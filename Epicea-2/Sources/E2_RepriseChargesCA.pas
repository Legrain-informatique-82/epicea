unit E2_RepriseChargesCA;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Gr_Librairie_obj, E2_Librairie_obj, Grids, DBGrids, Db,
  DBTables,  LibSQL, Menus, Buttons,DMChargesCA,
  E2_RepriseChargeAPayer2_Isa, RXDBCtrl, ExRxDBGrid, GrDBGrid,LibZoneSaisie,DMEcriture,
  lib_chaine,
  RXCtrls,DMConstantes, LibGestionParamXML, jpeg;

type
  TRepriseChargeCA = class(TForm)
    PanBtnHaut: TPanel;
    SBCCA: TSpeedButton;
    SBPCA: TSpeedButton;
    Patitre: TPanel;
    PopupMenu1: TPopupMenu;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    PaBas: TPanel;
    PaBtn: TPanel;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    PaTotaux: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    PaGrille: TPanel;
    DBGrid1: TGrDBGrid;
    Visualisation1: TMenuItem;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);
    procedure DBGrid1Enter(Sender: TObject);
    procedure SBCCAClick(Sender: TObject);
    procedure SBPCAClick(Sender: TObject);
    procedure DBGrid1ColExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure changementEtatBoutons(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure PanBtnHautResize(Sender: TObject);
    procedure BtnEnregistrerEnter(Sender: TObject);
    procedure BtnEnregistrerExit(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  RepriseChargeCA: TRepriseChargeCA;
  IndiceSpeedBouton: Integer;
  DateChange: Boolean;
  DateVide: Boolean;
  Sens: Boolean;
  SensCourant:string;

implementation

uses E2_Main;

{$R *.DFM}


//****************************************************************************//
// Gestion du Show de la fenêtre.                                             //
//****************************************************************************//
procedure TRepriseChargeCA.FormShow(Sender: TObject);
begin
try
     SBCCA.Down := True;
     SBPCA.Down := False;
     SBCCA.Font.Color := clRed;
     SBPCA.Font.Color := clWindowText;
     Self.Caption := 'Reprise des Charges Constatées d''Avance';
     RxLabTitre.Caption:='Reprise des charges constatées d''avance';


     SensCourant := 'D';
     DMChargeCA.FiltragePourOuvertureReprise1(senscourant);
     tag:=(strtoint_lgr(inttostr(self.Tag) +inttostr(SBCCA.Tag)));
     DMChargeCA.tag:= self.Tag;

     DBGrid1.SelectedIndex := 5;
     DBGrid1.SetFocus;

     Label3.Caption := DateToStr(E.DatExoDebut - 1);
     IndiceSpeedBouton := 1;
except
abort;
end;

end;
//****************************************************************************//


//****************************************************************************//
// Gestion du changement de l'état de la table.                               //
//****************************************************************************//
procedure TRepriseChargeCA.changementEtatBoutons(Sender: TObject);
begin
     Case DMChargeCA.TaPCA3.State Of
          dsBrowse: Begin
                         BtnEnregistrer.Enabled := False;
                         DBGrid1.Options := [dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
                    End;
          dsEdit: Begin
                       BtnEnregistrer.Enabled := True;
                       DBGrid1.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
                   End;
     End; // Fin du Case
end;
//****************************************************************************//


//****************************************************************************//
// Gestion de la création de la fenêtre.                                      //
//****************************************************************************//
procedure TRepriseChargeCA.FormCreate(Sender: TObject);
begin
 if DMChargeCA=nil then
 DMChargeCA:=TDMChargeCA.Create(self);
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poDesigned;
        InitialiseFormPosDefaut(self);
	//Left:= 0; Top:= 70; Width:= screen.Width; Height:= screen.Height-top;
    end;
//     DBGrid1.Columns[5].Field.EditMask := '09\/09\/0999;1;_';
     SBCCA.Tag:=1;
     SBPCA.Tag:=2;
     if now > E.DatExoFin then  DBGrid1.DateDef:=E.DatExoFin else DBGrid1.DateDef:=now;
end;
//****************************************************************************//




Procedure TRepriseChargeCA.InitialiseTable_A_Nil;
Begin
   //  DMChargeCA.DataPCA3.OnStateChange:=nil;
   if DMChargeCA<>nil then
     InitDatasetEvent_A_Nil_Sur_Form([DMChargeCA.DataPCA3]);
End;


//****************************************************************************//
// Gestion du Destroy de la fenêtre.                                          //
//****************************************************************************//
procedure TRepriseChargeCA.FormDestroy(Sender: TObject);
begin
     InitialiseTable_A_Nil;
     LibGestionParamXML.DestroyForm(Self,E.USer);
     DMChargeCA.free;
     RepriseChargeCA:=nil;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion de l'entrée dans Dbgrid1.                                          //
//****************************************************************************//
procedure TRepriseChargeCA.DBGrid1Enter(Sender: TObject);
begin
     DBGrid1.SelectedIndex := 5;
end;


//****************************************************************************//
// Gestion du click sur le Speed Bouton Charge Constatée d'Avance.            //
//****************************************************************************//
procedure TRepriseChargeCA.SBCCAClick(Sender: TObject);
begin

     SBCCA.Font.Color := clRed;
     SBPCA.Font.Color := clWindowText;
     SBCCA.Down := True;
     SBPCA.Down := False;

     IndiceSpeedBouton := 1;
     Self.Caption := 'Reprise des Charges Constatées d''Avance';
     RxLabTitre.Caption:='Reprise des charges constatées d''avance';

     SensCourant := 'D';
     DMChargeCA.FiltragePourOuvertureReprise1(senscourant);
     DBGrid1.SelectedIndex := 5;
     DBGrid1.SetFocus;
     tag:=strtoint_lgr((copy(inttostr(tag),1,1))+inttostr(SBCCA.tag));
     DMChargeCA.tag:=self.Tag;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click sur le Speed Bouton Produit Constaté d'Avance.            //
//****************************************************************************//
procedure TRepriseChargeCA.SBPCAClick(Sender: TObject);
begin
     SBPCA.Font.Color := clRed;
     SBCCA.Font.Color := clWindowText;
     SBCCA.Down := False;
     SBPCA.Down := True;

     IndiceSpeedBouton := 2;
     Self.Caption := 'Reprise des Produits Constatés d''Avance';
     RxLabTitre.Caption:='Reprise des produits constatés d''avance';
     SensCourant := 'C';
     DMChargeCA.FiltragePourOuvertureReprise1(senscourant);
     DBGrid1.SelectedIndex := 5;
     DBGrid1.SetFocus;
//     delete(inttostr(tag),2,1);
     tag:=strtoint_lgr((copy(inttostr(tag),1,1))+inttostr(SBPCA.tag));
     DMChargeCA.tag:=self.Tag;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion de la sortie des colonnes dans la grille.                          //
//****************************************************************************//
procedure TRepriseChargeCA.DBGrid1ColExit(Sender: TObject);
begin
   If DBGrid1.DataSource.State = dsEdit Then
     Begin
     DMChargeCA.VerifSaisieFeuilleReprise1(DBGrid1.SelectedField);
     End;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion des touches dans la fenêtre.                                       //
//****************************************************************************//
procedure TRepriseChargeCA.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     If Key = VK_ESCAPE Then
     Begin
          If Not(DBGrid1.DataSource.State = dsEdit) Then
//            modalresult:=mrOk
             Self.Close
          Else
             DMChargeCA.TaPCA3.Cancel;
     End;
end;
//****************************************************************************//



//****************************************************************************//
// Gestion des touches dans la DBGrid1.                                       //
//****************************************************************************//
procedure TRepriseChargeCA.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
//     If Key = #13 Then
//     Begin
//          Key := #0;
//          If DBGrid1.SelectedIndex < 5 Then
//             DBGrid1.SelectedIndex := DBGrid1.SelectedIndex + 1
//          Else
//             If Not(DMChargeCA.TaPCA3.EOF) Then
//             Begin
//                  DMChargeCA.TaPCA3.Next;
//                  DBGrid1.SelectedIndex := 5;
//             End
//             Else
//             Begin
//                  DMChargeCA.TaPCA3.First;
//                  DBGrid1.SelectedIndex := 5;
//             End;
//     End;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click sur le bouton Enregistrer.                                //
//****************************************************************************//
procedure TRepriseChargeCA.BtnEnregistrerClick(Sender: TObject);
begin
     If BtnEnregistrer.Enabled Then
     Begin
          TableGerePost(DMChargeCA.TaPCA3);
          DBGrid1.SetFocus;
     End;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du ckick sur le bouton Annuler.                                    //
//****************************************************************************//
procedure TRepriseChargeCA.BtnAnnulerClick(Sender: TObject);
begin
//     If BtnAnnuler.Enabled Then
//     Begin
//          DMChargeCA.TaPCA.Cancel;
//          DBGrid1.SetFocus;
//     End;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click sur le bouton Fermer.                                     //
//****************************************************************************//
procedure TRepriseChargeCA.BtnFermerClick(Sender: TObject);
begin
//modalresult:=mrOk;
     Self.Close;
end;
//****************************************************************************//

procedure TRepriseChargeCA.FormActivate(Sender: TObject);
begin
Show;
Initialiser_ShortCut_Main(true);
DMChargeCA.DataPCA3.OnStateChange:=changementEtatBoutons;
DMChargeCA.DataPCA3.OnStateChange(self);
Patitre.visible:=Main.AfficheTitre;
 DBGrid1.ParamColor:=true;
 DBGrid1.Param:=ParamUtil.CouleurDBGrid;
 DBGrid1.UpDateColor;
 DBGrid1.DateDeb:=E.DatExoDebut;
 DBGrid1.DateFin:=E.DatExoFin;

end;

procedure TRepriseChargeCA.PaBtnResize(Sender: TObject);
begin
BtnEnregistrer.Left:=(PaBtn.Width-450) div 2;
BtnInserer.Left:=BtnEnregistrer.Left+89;
BtnModifier.Left:=BtnEnregistrer.Left+178;
BtnSupprimer.Left:=BtnEnregistrer.Left+267;
BtnFermer.Left:=BtnEnregistrer.Left+356;

end;

procedure TRepriseChargeCA.PaGrilleResize(Sender: TObject);
begin
DBGrid1.ColWidths[1]:=(DBGrid1.Width) div 8;
DBGrid1.ColWidths[2]:=(DBGrid1.Width) div 3;
DBGrid1.ColWidths[3]:=(DBGrid1.Width) div 8;
DBGrid1.ColWidths[4]:=(DBGrid1.Width) div 8;
DBGrid1.ColWidths[5]:=(DBGrid1.Width) div 8;
DBGrid1.ColWidths[6]:=(DBGrid1.Width) div 8;
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TRepriseChargeCA.PanBtnHautResize(Sender: TObject);
begin
SBCCA.left:=(PanBtnHaut.width-530) div 3;
SBPCA.Left:=(PanBtnHaut.width-265-SBCCA.left);
end;

procedure TRepriseChargeCA.BtnEnregistrerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TRepriseChargeCA.BtnEnregistrerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TRepriseChargeCA.Visualisation1Click(Sender: TObject);
begin
   if DBGrid1.SelectedIndex = 4 then
   begin
   DetailEcritureCompte(DMChargeCA.taPCA3.FindField('Compte2').AsString,true,False);
   end
   else
   begin
   DetailEcritureCompte(DMChargeCA.taPCA3.FindField('Compte').AsString,true,False);
   end;

end;

procedure TRepriseChargeCA.BtnModifierClick(Sender: TObject);
begin
DMChargeCA.TaPCA3.Edit;
end;

procedure TRepriseChargeCA.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
affichage:boolean;
begin
try
canclose:=true;
affichage:=false;
  if self.tag > 0 then
  begin
     If DMChargeCA.TaPCA3.State = dsEdit Then
          Begin
               If Messagedlg('Voulez-vous enregistrer avant de fermer la fenêtre ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                  BtnEnregistrer.Click
               Else
                  DMChargeCA.TaPCA3.Cancel;
          End;
          FiltrageDataSet(DMChargeCA.TaPCA2,'Date_Piece <>null and Date_Piece >= '''+DateTimeToStr(E.DatExoDebut)+''' And Date_Piece <= '''+DateTimeToStr(E.DatExoFin)+''' And DateSaisie = '''+DateTimeToStr(E.DatExoDebut - 1)+''' And Reference = ''''');
          if DMChargeCA.TaPCA2.recordcount>0 then
          begin
            self.tag:=0;
            try
             DMChargeCA.CreationODChargeCAReprise;
             affichage:=true;
            except
             showmessage('Problème à la création des OD ');
             abort;
            end;//fin du try
          if affichage then
          DMChargeCA.DemandeAffichageReprise;
          end;
  end;
except
   canclose:=false;
end;
if canclose then InitialiseTable_A_Nil; { isa  le  29/01/04 }
end;

end.
