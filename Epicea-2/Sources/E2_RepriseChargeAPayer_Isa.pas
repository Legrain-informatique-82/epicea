unit E2_RepriseChargeAPayer_Isa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Gr_Librairie_obj, E2_Librairie_obj, Grids, DBGrids, Db,
  DBTables,  LibSQL, Menus, Buttons,DMChargesAPayer,DMPiece,
  RXDBCtrl, ExRxDBGrid, GrDBGrid,DMEcriture,LibZoneSaisie, RXCtrls,DMConstantes,
  lib_chaine,
  LibGestionParamXML,
  jpeg;

type
//    MaDBGrid = class (TCustomGrid)
//    public
//    property InplaceEditor;
//    end;

  TRepriseChargeAPayer_Isa = class(TForm)
    PaBtnHaut: TPanel;
    SBCAP: TSpeedButton;
    SBPAR: TSpeedButton;
    Patitre: TPanel;
    PaBas: TPanel;
    PaBtn: TPanel;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    PaTotaux: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    PaGrille: TPanel;
    DBGrid1: TGrDBGrid;
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
    procedure FormShow(Sender: TObject);
    procedure AideEnLigne(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);
    procedure DBGrid1Enter(Sender: TObject);
    procedure SBCAPClick(Sender: TObject);
    procedure SBPARClick(Sender: TObject);
    procedure DBGrid1ColExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure changementEtatBoutons(Sender: TObject);
    procedure PaBtnHautResize(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure Aideenligne1Click(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  RepriseChargeAPayer_Isa: TRepriseChargeAPayer_Isa;
  SensCourant: String;
  IndiceSpeedBouton: Integer;
  DateChange,DateVide: Boolean;

implementation

uses  E2_AideAssist, DMAide,
 ///UQReport,
 E2_Recherche,
  E2_Main;

{$R *.DFM}

procedure TRepriseChargeAPayer_Isa.AideEnLigne(Sender: TObject);
var
   aa,result:boolean;
begin
try
if ((AideAssist <> nil) and (AideAssist.Visible)) then
Result:=DMAides.taAssist.FindKey([self.Name+inttostr(self.tag),ActiveControl.Name]);
     if not Result then
        DMAides.taAssist.FindKey(['Vide','Vide']);
except;
end;
end;

procedure TRepriseChargeAPayer_Isa.changementEtatBoutons(Sender: TObject);
begin
     Case DMChargeAPayer.TaChAPayer3.State Of
          dsBrowse: Begin
                         BtnEnregistrer.Enabled := False;
                         DBGrid1.Options := [dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
                    End;
          dsEdit: Begin
                       BtnEnregistrer.Enabled := True;
                       DBGrid1.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
                  End;
     End;
end;

//****************************************************************************//
// Gestion du Show de la fenêtre.                                             //
//****************************************************************************//
procedure TRepriseChargeAPayer_Isa.FormShow(Sender: TObject);
begin
     SBCAP.Down := True;
     SBPAR.Down := False;
     SBCAP.Font.Color := clRed;
     SBPAR.Font.Color := clWindowText;
     Self.Caption := 'Reprise des Charges à Payer';
     RxLabTitre.Caption:='Reprise des charges à payer';

     SensCourant := 'C';
     DMChargeAPayer.FiltragePourOuvertureReprise1(senscourant);

     tag:=(strtoint_lgr(inttostr(self.Tag) +inttostr(SBCAP.Tag)));
     DMChargeAPayer.tag:= self.Tag;
// DMChargeAPayer.QuandQuoi:=DMChargeAPayer.tag;
     Label3.Caption := DateToStr(E.DatExoDebut - 1);

     DBGrid1.SelectedIndex := 5;
     DBGrid1.SetFocus;

     IndiceSpeedBouton := 1;

end;
//****************************************************************************//


//****************************************************************************//
// Gestion du Create de la fenêtre.                                           //
//****************************************************************************//
procedure TRepriseChargeAPayer_Isa.FormCreate(Sender: TObject);
begin
 if DMChargeAPayer=nil then
 DMChargeAPayer:=TDMChargeAPayer.Create(self);
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
        InitialiseFormPosDefaut(self);
    end;
//     DBGrid1.Columns[5].Field.EditMask := '09\/09\/0999;1;_';
     SBCAP.Tag:=1;
     SBPAR.Tag:=2;
     if now > E.DatExoFin then  DBGrid1.DateDef:=E.DatExoFin else DBGrid1.DateDef:=now;
end;
//****************************************************************************//


Procedure TRepriseChargeAPayer_Isa.InitialiseTable_A_Nil;
Begin
   //  DMChargeAPayer.DataChAPayer3.OnStateChange:=nil;
   if DMChargeAPayer<>nil then
     InitDatasetEvent_A_Nil_Sur_Form([DMChargeAPayer.DataChAPayer3]);
End;

//****************************************************************************//
// Gestion du Destroy de la fenêtre.                                          //
//****************************************************************************//
procedure TRepriseChargeAPayer_Isa.FormDestroy(Sender: TObject);
begin
     InitialiseTable_A_Nil;
     LibGestionParamXML.DestroyForm(Self,E.USer);
     DMChargeAPayer.Free;
     RepriseChargeAPayer_Isa := Nil;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion de l'entrée dans DBGrid1.                                          //
//****************************************************************************//
procedure TRepriseChargeAPayer_Isa.DBGrid1Enter(Sender: TObject);
begin
     DBGrid1.SelectedIndex := 5;
end;
//****************************************************************************//



//****************************************************************************//
// Gestion du click sur le speed bouton Reprise des Charges à Payer.          //
//****************************************************************************//
procedure TRepriseChargeAPayer_Isa.SBCAPClick(Sender: TObject);
begin
     SBCAP.Font.Color := clRed;
     SBPAR.Font.Color := clWindowText;
     SBCAP.Down := True;
     SBPAR.Down := False;
     IndiceSpeedBouton := 1;
     Self.Caption := 'Reprise des Charges à Payer';
     RxLabTitre.Caption:='Reprise des charges à payer';
     SensCourant := 'C';
     DMChargeAPayer.FiltragePourOuvertureReprise1(senscourant);
     DBGrid1.SelectedIndex := 5;
     DBGrid1.SetFocus;
//     delete(inttostr(tag),2,1);
     tag:=strtoint_lgr((copy(inttostr(tag),1,1))+inttostr(SBCAP.tag));
     DMChargeAPayer.tag:=self.Tag;
// DMChargeAPayer.QuandQuoi:=DMChargeAPayer.tag;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click sur le speed bouton Reprise des Produits A Recevoir.      //
//****************************************************************************//
procedure TRepriseChargeAPayer_Isa.SBPARClick(Sender: TObject);
begin
     SBCAP.Font.Color := clWindowText;
     SBPAR.Font.Color := clRed;
     SBCAP.Down := False;
     SBPAR.Down := True;
     IndiceSpeedBouton := 2;
     Self.Caption := 'Reprise des Produits à Recevoir';
     RxLabTitre.Caption:='Reprise des produits à recevoir';
     SensCourant := 'D';
     DMChargeAPayer.FiltragePourOuvertureReprise1(senscourant);
     DBGrid1.SelectedIndex := 5;
     DBGrid1.SetFocus;
//     delete(inttostr(tag),2,1);
     tag:=strtoint_lgr((copy(inttostr(tag),1,1))+inttostr(SBPAR.tag));
     DMChargeAPayer.tag:=self.Tag;
// DMChargeAPayer.QuandQuoi:=DMChargeAPayer.tag;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion de la sortie des colonnes dans la grille.                          //
//****************************************************************************//
procedure TRepriseChargeAPayer_Isa.DBGrid1ColExit(Sender: TObject);
begin
     If DBGrid1.DataSource.State = dsEdit Then
     Begin
     DMChargeAPayer.VerifSaisieFeuilleReprise1(DBGrid1.SelectedField);
     End;

end;
//****************************************************************************//


//****************************************************************************//
// Gestion des touches dans la fenêtre.                                       //
//****************************************************************************//
procedure TRepriseChargeAPayer_Isa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=vk_F1 then   { isa  le  22/03/04 }
  Begin
    if DBGrid1.SelectedField.DataType in [fTDate,fTDateTime] then
       begin
        if aide1.ShortCut<> ShortCut(0, []) then
          begin
            aide1.ShortCut:=ShortCut(0, []);
            aide1.Click;
          end;
       end
    else
        if aide1.ShortCut<> ShortCut(112, []) then
          begin
            aide1.ShortCut:=ShortCut(112, []);
            aide1.Click;
          end;
  End;

//if key=vk_F1 then
//  Begin
//    if DBGrid1.SelectedField.DataType in [fTDate,fTDateTime] then
//      aide1.ShortCut:=ShortCut(0, [])
//    else
//      aide1.ShortCut:=ShortCut(112, []);
//  End;

     If key = VK_ESCAPE Then
     Begin
          If Not(DBGrid1.DataSource.State = dsEdit) Then
//            modalresult:=mrOk
             Self.Close
          Else
             DMChargeAPayer.TaChAPayer3.Cancel;
     End;
end;
//****************************************************************************//



//****************************************************************************//
// Gestion des Touches dans la dbgrid1.                                       //
//****************************************************************************//
procedure TRepriseChargeAPayer_Isa.DBGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
     If Key = #13 Then
     Begin
          Key := #0;
          If DBGrid1.SelectedIndex < 5 Then
             DBGrid1.SelectedIndex := DBGrid1.SelectedIndex + 1
          Else
             If Not(DMChargeAPayer.TaChAPayer3.EOF) Then
             Begin
                  DMChargeAPayer.TaChAPayer3.Next;
                  DBGrid1.SelectedIndex := 5;
             End
             Else
             Begin
                  DMChargeAPayer.TaChAPayer3.First;
                  DBGrid1.SelectedIndex := 5;
             End;
     End;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click sur le bouton Enregistrer.                                //
//****************************************************************************//
procedure TRepriseChargeAPayer_Isa.BtnEnregistrerClick(Sender: TObject);
begin
     If BtnEnregistrer.Enabled Then
     Begin
          TableGerePost(DMChargeAPayer.TaChAPayer3);
          DBGrid1.SetFocus;
     End;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du Click sur le bouton Annuler.                                    //
//****************************************************************************//
procedure TRepriseChargeAPayer_Isa.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click sur le bouton Fermer.                                     //
//****************************************************************************//
procedure TRepriseChargeAPayer_Isa.BtnFermerClick(Sender: TObject);
begin
//modalresult:=mrOk;
     Self.Close;
end;
procedure TRepriseChargeAPayer_Isa.FormActivate(Sender: TObject);
begin
Show;
Initialiser_ShortCut_Main(true);
DMChargeAPayer.DataChAPayer3.OnStateChange:=changementEtatBoutons;
DMChargeAPayer.DataChAPayer3.OnStateChange(self);
Patitre.visible:=Main.AfficheTitre;

 DBGrid1.ParamColor:=true;
 DBGrid1.Param:=ParamUtil.CouleurDBGrid;
 DBGrid1.UpDateColor;
 DBGrid1.DateDeb:=E.DatExoDebut;
 DBGrid1.DateFin:=E.DatExoFin;
end;

procedure TRepriseChargeAPayer_Isa.PaBtnHautResize(Sender: TObject);
begin
  SBCAP.left:=(PaBtnHaut.width-530) div 3;
  SBPAR.Left:=(PaBtnHaut.width-265-SBCAP.left);
end;

procedure TRepriseChargeAPayer_Isa.PaGrilleResize(Sender: TObject);
begin
  FormateTailleColonne(DBGrid1,14,[2,3,2,2,2,2]);
  WinShape(screen.ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TRepriseChargeAPayer_Isa.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
//BtnAnnuler.Left:=(PaBtn.Width-630) div 2;
//BtnEnregistrer.Left:=BtnAnnuler.Left +89;
//BtnModifier.Left:=BtnAnnuler.Left+178;
//BtnInserer.Left:=BtnAnnuler.Left+267;
//BtnSupprimer.Left:=BtnAnnuler.Left+356;
//BtnFermer.Left:=BtnAnnuler.Left+445;
//BtnImprimer.left:=BtnAnnuler.Left+534;
end;

procedure TRepriseChargeAPayer_Isa.BtnModifierClick(Sender: TObject);
begin
DMChargeAPayer.TaChAPayer3.Edit;
end;

procedure TRepriseChargeAPayer_Isa.BtnImprimerClick(Sender: TObject);
begin
//if (FPrint = nil) then FPrint:=TFPrint.Create(self);
//FPrint.SelectionEtat := 8;
//FPrint.show;
end;

procedure TRepriseChargeAPayer_Isa.Aideenligne1Click(Sender: TObject);
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

procedure TRepriseChargeAPayer_Isa.Aide1Click(Sender: TObject);
begin
 If activecontrol = DBGrid1 Then
  begin
   case DBGrid1.DataSource.State of
      dsbrowse:case self.tag of
                  1,11:case DBGrid1.SelectedIndex of
                     0:Rechercher(DBGrid1,DMChargeAPayer.taChAPayer2,['Compte','Libelle2','Reference','Compte2','Date_Piece','DateSaisie'],['Compte','Désignation','Référence Reprise','Compte Reprise','',''],'',0);
//                     1:Rechercher(DBCAR,DMChargeRepartir.TaCar,['Designation','Reference','DateSaisie'],['Désignation','Références',''],'',0);
                    end;
                  2,12,22:case DBGrid1.SelectedIndex of
//                     0:Rechercher(DBCAR,DMChargeRepartir.TaCar,['Reference','Designation','DateSaisie'],['Références','Désignation',''],'',0);
                     1:Rechercher(DBGrid1,DMChargeAPayer.taChAPayer2,['Compte','Libelle2','Reference','Compte2','Date_Piece','DateSaisie'],['Compte','Désignation','Référence Reprise','Compte Reprise','',''],'',0);
//                     1:Rechercher(DBCAR,DMChargeRepartir.TaCar,['Designation','Reference','DateSaisie'],['Désignation','Références',''],'',0);
                    end;
               end;
      dsedit:case self.tag of
                  1,11:case DBGrid1.SelectedIndex of
                     5://;
                    end;
                  2,12,22:case DBGrid1.SelectedIndex of
                     5://;
                    end;
               end;
   end;
 end;
aide1.ShortCut:=ShortCut(0, []);
end;

procedure TRepriseChargeAPayer_Isa.Visualisation1Click(Sender: TObject);
begin
   if DBGrid1.SelectedIndex = 4 then
   begin
   DetailEcritureCompte(DMChargeAPayer.TaChAPayer3.FindField('Compte2').AsString,true,False);
   end
   else
   begin
   DetailEcritureCompte(DMChargeAPayer.taChAPayer3.FindField('Compte').AsString,true,False);
   end;
end;

procedure TRepriseChargeAPayer_Isa.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TRepriseChargeAPayer_Isa.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TRepriseChargeAPayer_Isa.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  affichage:boolean;
begin
try
canclose:=true;
affichage:=false;
if self.tag > 0 then
  begin
   If DBGrid1.DataSource.State = dsEdit Then
       Begin
            If Messagedlg('Voulez-vous enregistrer avant de fermer la fenêtre ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
               BtnEnregistrer.Click
            Else
               DMChargeAPayer.TaChAPayer3.Cancel;
       End;
       FiltrageDataSet(DMChargeAPayer.TaChAPayer3,'Date_Piece <>null and Date_Piece >= '''+DateTimeToStr(E.DatExoDebut)+''' And Date_Piece <= '''+DateTimeToStr(E.DatExoFin)+''' And DateSaisie = '''+DateTimeToStr(E.DatExoDebut - 1)+''' And Reference = ''''');
       if DMChargeAPayer.TaChAPayer3.recordcount>0 then
         begin
           try
            self.tag:=0;
            DMChargeAPayer.CreationODChargeAPayerReprise;
            affichage:=true;
           except
            showmessage('Problème à la création des OD ');
            abort;
           end;//fin du try
           if affichage then
             DMChargeAPayer.DemandeAffichageReprise;
         end;
  end;
except
  canclose:=false;
end;
if canclose then InitialiseTable_A_Nil; { isa  le  29/01/04 }
end;

end.
