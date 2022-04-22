{***************************************************************
 *
 * Unit Name: E2_DescEmp
 * Purpose  :
 * Author   :  BP
 * History  :
 *
 ****************************************************************}

unit E2_DescEmp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, gr_Librairie_obj,  Buttons,LibZoneSaisie,db,LibSQL,
  GrDBGrid, DMEmprunt, ToolEdit, RXDBCtrl, Mask, DBCtrls, ExtCtrls,
  ComCtrls, Grids, DBGrids, ExRxDBGrid, RXCtrls, RXSplit,DMConstantes,
  RXSpin, LibGestionParamXML, jpeg,
  lib_chaine,Registry,
  E2_Decl_Records;
type

  TParamAfficheDescEmprunts = Record
   Affiche:Boolean;
   AffichageModal:Boolean;
   Quand:Integer;
   TitreForm:String;
   SousTitreForm:String;
   QuiAppel:TTypeFenetre;
   end;

  TDescEmp = class(TForm)
    PaGrille: TPanel;
    RxSplitter1: TRxSplitter;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    RxSBImport: TRxSpeedButton;
    Panel12: TPanel;
    PaCptImmo: TPanel;
    PaGrilleCpt: TPanel;
    Panel1: TPanel;
    Panel14: TPanel;
    RxSBEcheance: TRxSpeedButton;
    GrDBGrid1: TGrDBGrid;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Modifier1: TMenuItem;
    Insrer1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    N2: TMenuItem;
    Precdant1: TMenuItem;
    Suivant1: TMenuItem;
    N4: TMenuItem;
    VoirEchancier1: TMenuItem;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnModifier: TButton;
    BtnInserer: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    Pabas: TPanel;
    PaDetailCorp: TPanel;
    Panel8: TPanel;
    Panel2: TPanel;
    Panel7: TPanel;
    Label25: TLabel;
    Label26: TLabel;
    Label24: TLabel;
    Panel10: TPanel;
    edDatePE: TDBDateEdit;
    edCapiRbPE: TDBEdit;
    edInteretPE: TDBEdit;
    Panel4: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edNumEmp: TDBEdit;
    edCompte: TDBEdit;
    edDesignation: TDBEdit;
    edGroupe: TDBEdit;
    edBanque: TDBEdit;
    edDateReal: TDBDateEdit;
    edMontantEmp: TDBEdit;
    Panel3: TPanel;
    Panel6: TPanel;
    LabNbPeriode: TLabel;
    Label27: TLabel;
    LabPeriode1: TLabel;
    LabPeriode2: TLabel;
    LabPeriode3: TLabel;
    Label8: TLabel;
    LabTauxP1: TLabel;
    LabTauxP2: TLabel;
    LabTauxP3: TLabel;
    LabP1: TLabel;
    LabP2: TLabel;
    LabP3: TLabel;
    edNbPeriode: TDBEdit;
    edP1: TDBEdit;
    edP2: TDBEdit;
    edP3: TDBEdit;
    edPP1: TDBEdit;
    edPP2: TDBEdit;
    edPP3: TDBEdit;
    Panel9: TPanel;
    Label20: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label11: TLabel;
    Panel11: TPanel;
    DBRadioTypeRemb: TDBRadioGroup;
    DBRadioPeriodicite: TDBRadioGroup;
    RbDif: TDBEdit;
    edFraisAnnexe: TDBEdit;
    PaDetailEnTete: TPanel;
    PaGrilleEnTete: TPanel;
    GrDBEmprunt: TGrDBGrid;
    PaCumul: TPanel;
    GrDBGrid2: TGrDBGrid;
    Panel5: TPanel;
    RxSplitter2: TRxSplitter;
    PaCptIntit: TPanel;
    Panel13: TPanel;
    CBEnCours: TCheckBox;
    CBFinis: TCheckBox;
    CBTous: TCheckBox;
    procedure Calculatrice1Click(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pmMenu1Click(Sender: TObject);
//    procedure ChangeLibPeriode(Sender : TLabel; DbleFleche : TUpDown);
    procedure ChangeLibPeriode(Sender : TLabel; DbleFleche : integer);
    procedure edP1Change(Sender: TObject);
    procedure edP2Change(Sender: TObject);
    procedure edP3Change(Sender: TObject);
    procedure edNbPeriodeChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Aide1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure Enregistre;
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure edNumEmpExit(Sender: TObject);
    procedure edCompteExit(Sender: TObject);
    function CtrlChamp(Sender: TObject):TExceptLGR;
    procedure edDesignationExit(Sender: TObject);
    procedure Insrer1Click(Sender: TObject);
    procedure Modifier1Click(Sender: TObject);
    procedure Enregister1Click(Sender: TObject);
    procedure Supprimer1Click(Sender: TObject);
    procedure Annuler1Click(Sender: TObject);
    procedure ChangementEtatBoutons(Sender: TObject);
    procedure RxSBEcheanceClick(Sender: TObject);
    procedure RxSBEcheanceMouseLeave(Sender: TObject);
    procedure PaGrilleEnTeteResize(Sender: TObject);
    Procedure PositionTotaux;
    Procedure InitialiseTable_A_Nil;
    procedure PaDetailCorpExit(Sender: TObject);
    Procedure GestionInitDM;
    Procedure GereAccesEcran;
    procedure edGroupeKeyPress(Sender: TObject; var Key: Char);
    procedure edPP1KeyPress(Sender: TObject; var Key: Char);
    procedure edPP2KeyPress(Sender: TObject; var Key: Char);
    procedure edPP3KeyPress(Sender: TObject; var Key: Char);
    procedure edFraisAnnexeKeyPress(Sender: TObject; var Key: Char);
    procedure RxSBEnCoursClick(Sender: TObject);
    procedure PaToolsResize(Sender: TObject);
    procedure CBEnCoursClick(Sender: TObject);
    procedure GestionBoutonCheck();
    procedure CBFinisClick(Sender: TObject);
    procedure CBTousClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    TitreForm,SousTitreForm:String;
    Quand:Integer;
    typeEmprunts:TtypeEmprunts;
  end;

var
  DescEmp: TDescEmp;
  Changement:boolean;

  Function DescEmpruntsAffiche(ParamAfficheDescEmprunts:TParamAfficheDescEmprunts):Boolean;

implementation
{$R *.DFM}
Uses E2_Librairie_obj,
 //Gr_Calculatrice,
 QR_ECheancier, E2_Main,
  E2_AideCompte, DMBalances, E2_EcheEmprunt, LibClassObjetSenders;

Const
	TypRemb : Array [0..3] of String = ('A','S','T','M');
   PerRemb : Array [0..2] of String = ('A','C','M');


Function DescEmpruntsAffiche(ParamAfficheDescEmprunts:TParamAfficheDescEmprunts):Boolean;
var
ParamDMEmprunts:TParamDMEmprunts;
Begin
 if (DescEmp = nil) then DescEmp:=TDescEmp.Create(Application.MainForm);
 if ((ParamAfficheDescEmprunts.Quand <> DescEmp.Quand) and (DescEmp.Visible=true)) then
   DescEmp.Close;
 DescEmp.Quand:=ParamAfficheDescEmprunts.Quand;
 if not empty(ParamAfficheDescEmprunts.TitreForm) then
   DescEmp.TitreForm:=ParamAfficheDescEmprunts.TitreForm;
 DescEmp.SousTitreForm:=ParamAfficheDescEmprunts.SousTitreForm;
 Initialise_ParamDMEmprunts(ParamDMEmprunts);
 ParamDMEmprunts.EmpruntsDataStateChange := DescEmp.changementEtatBoutons;
 ParamDMEmprunts.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ParamDMEmprunts.Quand := DescEmp.Quand;
 ParamDMEmprunts.QuiAppel:=ParamAfficheDescEmprunts.QuiAppel;
   case DescEmp.Quand of
      C_Mouvement:Begin
                   InitialiseDMEmprunts(ParamDMEmprunts);

                  End;
   end;

 if ParamAfficheDescEmprunts.Affiche then
  begin
     //Grille des comptes d'emprunts utilisés
     DescEmp.GrDBGrid1.DataSource := DMEmprunts.DaCptEmprunts;
     //Grille des emprunts existants pour le compte sélectionné
     DescEmp.GrDBEmprunt.DataSource := DMEmprunts.DaRecupEmpruntsSurCpt;
     //differentes zones de description de l'emprunt selectionné
     DescEmp.edNumEmp.DataSource := DMEmprunts.DaEmpruntGestion;
     DescEmp.edCompte.DataSource := DMEmprunts.DaEmpruntGestion;
     DescEmp.edDesignation.DataSource := DMEmprunts.DaEmpruntGestion;
     DescEmp.edGroupe.DataSource := DMEmprunts.DaEmpruntGestion;
     DescEmp.edBanque.DataSource := DMEmprunts.DaEmpruntGestion;
     DescEmp.edDateReal.DataSource := DMEmprunts.DaEmpruntGestion;
     DescEmp.edMontantEmp.DataSource := DMEmprunts.DaEmpruntGestion;
     DescEmp.edNbPeriode.DataSource := DMEmprunts.DaEmpruntGestion;
     DescEmp.edP1.DataSource := DMEmprunts.DaEmpruntGestion;
     DescEmp.edP2.DataSource := DMEmprunts.DaEmpruntGestion;
     DescEmp.edP3.DataSource := DMEmprunts.DaEmpruntGestion;
     DescEmp.edPP1.DataSource := DMEmprunts.DaEmpruntGestion ;
     DescEmp.edPP2.DataSource := DMEmprunts.DaEmpruntGestion ;
     DescEmp.edPP3.DataSource := DMEmprunts.DaEmpruntGestion ;
     DescEmp.DBRadioTypeRemb.DataSource := DMEmprunts.DaEmpruntGestion;
     DescEmp.DBRadioPeriodicite.DataSource := DMEmprunts.DaEmpruntGestion ;
     DescEmp.RbDif.DataSource := DMEmprunts.DaEmpruntGestion;
     DescEmp.edFraisAnnexe.DataSource := DMEmprunts.DaEmpruntGestion ;
     DescEmp.edDatePE.DataSource := DMEmprunts.DaEmpruntGestion;
     DescEmp.edCapiRbPE.DataSource := DMEmprunts.DaEmpruntGestion ;
     DescEmp.edInteretPE.DataSource := DMEmprunts.DaEmpruntGestion ;

   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(Application.MainForm);
    DescEmp.RxSBEnCoursClick(nil);
     if ParamAfficheDescEmprunts.AffichageModal then
       DescEmp.ShowModal
      else
       DescEmp.Show;
  End;
End;

procedure TDescEmp.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(ActiveControl);
end;

procedure TDescEmp.Fermer1Click(Sender: TObject);
begin
	Self.Close;
end;

procedure TDescEmp.FormCreate(Sender: TObject);
var
Registre :TRegistry;
begin
 Registre:= TRegistry.Create;
try//finally
    try//except
        LibGestionParamXML.InitialiseForm(E.USer,Self);
    except
//        Position:=poDesigned;
        InitialiseFormPosDefaut(self);
	//Left:= 0; Top:= 70; Width:= screen.Width; Height:= screen.Height-top;
    end;
   edNbPeriode.OnChange:=nil;
   edP1.OnChange:=nil;
   edP2.OnChange:=nil;
   edP3.OnChange:=nil;
finally
   Changement:=false;
   edNbPeriode.OnChange:=edNbPeriodeChange;
   edP1.OnChange:=edP1Change;
   edP2.OnChange:=edP2Change;
   edP3.OnChange:=edP3Change;
end;
 Registre:= TRegistry.Create;
   try
     with Registre do
       begin
          try
              RootKey := HKEY_LOCAL_MACHINE;
              OpenKey('\SOFTWARE\LGR\Epicea2\' + e.User+ '\' + self.Name, false);
            if ReadBool('CBEnCours') then CBEnCours.state:= cbChecked;
            if ReadBool('CBFinis') then CBFinis.state:= cbChecked;
            if ReadBool('CBTous') then CBTous.state:= cbChecked;
          except
            CBEnCours.state:=cbUnchecked;
            CBFinis.state:=cbUnchecked;
            CBTous.state:=cbchecked;
          end;
       end;//fin du with
   finally
     Registre.Free;
   end;

end;

procedure TDescEmp.FormDestroy(Sender: TObject);
Var
  Registre :TRegistry;
Begin
  Registre:= TRegistry.Create;
  try
     with Registre do begin
        RootKey := HKEY_LOCAL_MACHINE;
        OpenKey('\SOFTWARE\LGR\Epicea2\' + e.User+ '\' + self.Name, True);
        begin
          if CBEnCours.state = cbchecked then WriteBool('CBEnCours',true)
          else WriteBool('CBEnCours',false);
           if CBFinis.state = cbchecked then WriteBool('CBFinis',true)
           else WriteBool('CBFinis',false);
            if CBTous.state = cbchecked then WriteBool('CBTous',true)
            else WriteBool('CBTous',false);
        end;
        CloseKey;
     end;
  finally
     Registre.Free;
  end;
   LibGestionParamXML.DestroyForm(Self,e.user);
   InitialiseTable_A_Nil;
   if DMEmprunts <> nil then
     begin
       DeFiltrageDataSet(DMEmprunts.TAEmprunts);
       DMEmprunts.Free;
     end;
   DescEmp:=nil;
end;

procedure TDescEmp.pmMenu1Click(Sender: TObject);
begin
	PopupMenu1.Popup(Left + 50, Top + 50);
end;








//procedure TDescEmp.ChangeLibPeriode(Sender : TLabel; DbleFleche : TUpDown);
procedure TDescEmp.ChangeLibPeriode(Sender : TLabel; DbleFleche : integer);
var
AN,NbAN,mois:string;
begin
mois:=IntToStr((DbleFleche) mod 12);
NbAN:=IntToStr((DbleFleche) div 12);
case ((DbleFleche) div 12) of
   0:begin
   	NbAn:='' ;
      end;
   1:NbAn:='1 An' ;
   else NbAn:=IntToStr((DbleFleche) div 12)+' Ans';
end;

if (((DbleFleche) mod 12) = 0) then
	mois:='' else
   if NbAn='' then mois:=IntToStr((DbleFleche) mod 12) + ' mois' else
   mois:=' et '+ IntToStr((DbleFleche) mod 12) + ' mois';

sender.caption:=NbAN+mois ;
end;

procedure TDescEmp.edP1Change(Sender: TObject);
begin
if edP1.Field <> nil then
  begin
  if edP1.Field.DataSet.State in [dsinsert,dsedit] then
    Begin
      edP1.Field.AsString:=edP1.Text;
    End;
    ChangeLibPeriode(LabP1,edP1.Field.asinteger);
    LabPeriode1.caption:='Période 1';
    LabPeriode1.Tag:=1;
  end;
end;

procedure TDescEmp.edP2Change(Sender: TObject);
begin
if edP2.Field <> nil then
  begin
    if edP2.Field.DataSet.State in [dsinsert,dsedit] then
      Begin
         edP2.Field.AsString:=edP2.Text;
      End;
         ChangeLibPeriode(LabP2,edP2.Field.asinteger);
         LabPeriode2.caption:='Période 2';
         LabPeriode2.Tag:=2;
  end;
end;

procedure TDescEmp.edP3Change(Sender: TObject);
begin
if edP3.Field <> nil then
  begin
  if edP3.Field.DataSet.State in [dsinsert,dsedit] then
    Begin
       edP3.Field.AsString:=edP3.Text;
    End;
      ChangeLibPeriode(LabP3,edP3.Field.asinteger);
      LabPeriode3.Caption:='Période 3';
      LabPeriode3.Tag:=3;
  end;
end;



procedure TDescEmp.edNbPeriodeChange(Sender: TObject);
begin
if edNbPeriode.Field <> nil then
  begin
      if edNbPeriode.field.DataSet.State in [dsinsert,dsedit] then
      Begin////si en modification
      If edNbPeriode.Text='' then edNbPeriode.Text:='1';
      edNbPeriode.field.Asstring:=edNbPeriode.Text;
         case edNbPeriode.Field.AsInteger of
            1:begin
                //Periode 2
                edP2.text:='0';
                edPP2.Text:='0';
                //Periode 3
                edP3.text:='0';
                edPP3.Text:='0';
              end ;
            2:begin
                //Periode 3
                edP3.text:='0';
                edPP3.Text:='0';
              end ;
         end;//fin du case
      End;//fin si en modification
         case edNbPeriode.Field.AsInteger of
            1:begin
                //Periode 2
                LabPeriode2.Enabled:=false;
                LabP2.Enabled:=false;
                LabTauxP2.Enabled:=false;
                EnableWinControl([edP2,edPP2],false);
                //Periode 3
                LabPeriode3.Enabled:=false;
                LabP3.Enabled:=false;
                LabTauxP3.Enabled:=false;
                EnableWinControl([edP3,edPP3],false);
              end ;
            2:begin
                //Periode 2
                LabPeriode2.Enabled:=true;
                LabP2.Enabled:=true;
                LabTauxP2.Enabled:=true;
                EnableWinControl([edP2,edPP2],true);
                //Periode 3
                LabPeriode3.Enabled:=false;
                LabP3.Enabled:=false;
                LabTauxP3.Enabled:=false;
                EnableWinControl([edP3,edPP3],false);
              end ;
            3:begin
                //Periode 2
                LabPeriode2.Enabled:=true;
                LabP2.Enabled:=true;
                LabTauxP2.Enabled:=true;
                EnableWinControl([edP2,edPP2],true);
                //Periode 3
                LabPeriode3.Enabled:=true;
                LabP3.Enabled:=true;
                LabTauxP3.Enabled:=true;
                EnableWinControl([edP3,edPP3],true);
              end ;
         end;//fin du case
  end;//fin si dataset branché
end;

procedure TDescEmp.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
KeyTmp:char;
begin
if Shift=[] then  WinSuivPrec(Handle,key,[GrDBEmprunt,GrDBGrid2,GrDBGrid1]);
     If Key = VK_ESCAPE Then
     Begin
       If DMEmprunts.TaEmpruntGestion.State = dsBrowse Then
          begin
             Self.Close ;
          end;
      If DMEmprunts.TaEmpruntGestion.State = dsInsert Then
          Begin
            if not VerifFNumeric(edcompte.Field).VideOUZero then
              begin//si commencé à remplir
               If Messagedlg('Annuler la création de cet Emprunt ?',MtConfirmation,[mbno,mbyes],0) = mryes Then
               Begin
                    DMEmprunts.TaEmpruntGestion.Cancel;
                   edNumEmp.SetFocus;
               End
               Else
               Begin
                    Abort;
               End;
              end//fin si commencé à remplir
            else
              begin
                    DMEmprunts.TaEmpruntGestion.Cancel;
                edNumEmp.SetFocus;
              end;
          End;


          If DMEmprunts.TaEmpruntGestion.State = dsEdit Then
          Begin
               If Messagedlg('Annuler les modifications de cet Emprunt ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    DMEmprunts.TaEmpruntGestion.Cancel;
                    edNumEmp.SetFocus;
               End
               Else
               Begin
                    Abort;
               End
          End;
    end;
end;


//procedure TDescEmp.ListBox1MouseMove(Sender: TObject; Shift: TShiftState;
//  X, Y: Integer);
//begin
//ListBox1.ItemIndex:=Y div ListBox1.ItemHeight;
//end;


//procedure TDescEmp.ListBox1Click(Sender: TObject);
//begin
//case ListBox1.ItemIndex of
//   0:begin
//   	DMEmprunts.CalculEcheancier;
////      QuickReport1.Preview;
//      end;
//   1:begin
//    	   if (QREcheancier = nil) then
//	   QREcheancier:=TQREcheancier.Create(self);
//   	QREcheancier.Show ;
//     end;
//   2:beep ;
//end;
//
//end;





//procedure TDescEmp.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
//  Y: Integer);
//begin
//ListBox1.ItemIndex:=-1;
//end;

procedure TDescEmp.Aide1Click(Sender: TObject);
var
inplaceTmp:TInplaceEdit;
begin
 If activecontrol = edCompte Then
  //Afficher aidecompte filtré
  begin
    inplaceTmp:=TInplaceEdit.Create(self);
    DMEmprunts.MessDerSub:=false;
//
    AideCompte.FiltrageAideCompte(22);
//
    inplaceTmp.Text:=edCompte.field.asstring;
    AideCompteDansContexte(inplaceTmp.Text,inplaceTmp,['Rac1'],true,DMEmprunts.MessDerSub,false,true,true,true,0);
    if not (DMEmprunts.TaEmpruntGestion.State in [dsinsert,dsedit,dsinactive]) then
       DMEmprunts.TaEmpruntGestion.Append;
    edcompte.Field.AsString:=inplaceTmp.Text;
    edcompte.Text:=inplaceTmp.Text;
    DMEmprunts.MessDerSub:=true;
    inplaceTmp.Free;
  end;//fin si activecontrol = edCompte
//*********************
 If activecontrol = edBanque Then
  //Afficher aidecompte filtré
  begin
//    inplaceTmp:=TInplaceEdit.Create(self);
//    DMEmprunts.MessDerSub:=false;
////
//    AideCompte.FiltrageAideCompte(101);
////
//    inplaceTmp.Text:=edBanque.field.asstring;
//    AideCompteDansContexte(inplaceTmp.Text,inplaceTmp,['Rac1'],true,DMEmprunts.MessDerSub,false,true,true,true,0);
//    edBanque.Field.AsString:=inplaceTmp.Text;
//    edBanque.Text:=inplaceTmp.Text;
//    DMEmprunts.MessDerSub:=true;
//    inplaceTmp.Free;
  end;//fin si activecontrol = edCompte
//*********************

 If activecontrol = edDateReal Then
  //Afficher aidedate filtré
  begin
    edDateReal.DoClick;
  end;//fin si activecontrol = edDateReal
  //*************************
 If ActiveControl=edDatePE  Then
  //Afficher aidedate filtré
  begin
  edDatePE.DoClick;
  end;//fin si activecontrol = edDatePE
  //*************************
  //
end;


procedure TDescEmp.FormActivate(Sender: TObject);
begin
GestionInitDM;
Initialiser_ShortCut_Main(true);

Patitre.visible:=Main.AfficheTitre;

GrDBGrid1.ParamColor:=true;
GrDBGrid1.Param:=ParamUtil.CouleurDBGrid;
GrDBGrid1.UpDateColor;

GrDBGrid2.ParamColor:=true;
GrDBGrid2.Param:=ParamUtil.CouleurDBGrid;
GrDBGrid2.UpDateColor;

GrDBEmprunt.ParamColor:=true;
GrDBEmprunt.Param:=ParamUtil.CouleurDBGrid;
GrDBEmprunt.UpDateColor;

GereAccesEcran;
if edNumEmp.CanFocus then edNumEmp.SetFocus;

end;


procedure TDescEmp.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
try//finally
    try//except
    if DMEmprunts <> nil then
     begin
      // Si l'utilisateur est en mode Insertion
         If DMEmprunts.TaEmpruntGestion.State = dsInsert Then
         Begin
              If BtnEnregistrer.Enabled Then
              Begin
                   self.WindowState:=wsNormal;
                   self.BringToFront;
                    if application.MessageBox(Pchar('Voulez-vous enregistrer ce nouvel emprunt ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
                     begin
                       BtnEnregistrerClick(btnenregistrer);
                       canclose:=true;
                      end
                      else
                       begin
                       DMEmprunts.TaEmpruntGestion.Cancel;
                       canclose:=true;
                       end;
              End
              Else
              Begin
                   self.WindowState:=wsNormal;
                   self.BringToFront;
                    if application.MessageBox(Pchar('Voulez-vous annuler la création ce nouvel emprunt ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
                    begin
                      DMEmprunts.TaEmpruntGestion.Cancel;
                      canclose:=true;
                    end
                   Else
                     begin
                      canclose:=false;
                      end;
              End;
         End; // Fin utilisateur est en mode Insertion

         // Si l'utilisateur est en mode Modification
         If DMEmprunts.TaEmpruntGestion.State = dsEdit Then
         Begin
                   self.WindowState:=wsNormal;
                   self.BringToFront;
               if application.MessageBox(Pchar('Voulez-vous enregistrer les modifications de cet emprunt ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
               begin
                BtnEnregistrerClick(btnenregistrer);
                canclose:=true;
                 end
                 else
                 begin
                  DMEmprunts.TaEmpruntGestion.Cancel;
                 end;
         End; // Fin utilisateur est en mode Modification
      ReEnableControls(DMEmprunts.TaEmpruntGestion);
      InitialiseTable_A_Nil;
      end;//fin si DMEmprunts <> nil
    except
       CanClose:=false;
    end;
finally
if CanClose=false then
 begin
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(self);
 end;
end;//fin du finally
end;


procedure TDescEmp.BtnEnregistrerClick(Sender: TObject);
begin
  try
    try
       Enregistre;
       edcompte.SetFocus;
    except
      TableGereRollBack(DMEmprunts.TaEmpruntGestion);
      TableGereRollBack(DMBalance.TaBalance);
      abort;
    end;//fin du try
  finally

  end;//fin du try finally
end;


procedure TDescEmp.Enregistre;
begin
//vérifier que tout soit bien rempli avant de poster
try
  try
      if DMEmprunts.TaEmpruntGestion.State in [dsinsert,dsedit]then
      begin //si table en insertion ou modification
        TableGereStartTransaction(DMEmprunts.TaEmpruntGestion);
        TableGerePost(DMEmprunts.TaEmpruntGestion);
        //edCompte.DataSource.OnStateChange(edCompte.DataSource.DataSet);
      end;//fin si table en insertion ou modification
  except
//      showmessage('Problème rencontré lors de l''enregistrement de l''immobilisation');
      TableGereRollBack(DMEmprunts.TaEmpruntGestion);
      TableGereRollBack(DMBalance.TaBalance);
      abort;
  end;//fin du try except
finally
// DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.EnableControls;
end;//fin du try finally
end;


procedure TDescEmp.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TDescEmp.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TDescEmp.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TDescEmp.BtnModifierClick(Sender: TObject);
begin
edCompte.DataSource.DataSet.Edit;
end;

procedure TDescEmp.BtnInsererClick(Sender: TObject);
begin
edCompte.DataSource.DataSet.Insert;
if ActiveControl=edcompte then
  edcompte.SelLength:=length(edcompte.Text);
end;

procedure TDescEmp.BtnSupprimerClick(Sender: TObject);
begin
try
   if (ActiveControl<>GrDBGrid1)then
   begin
      try
        TableGereStartTransaction(edCompte.DataSource.DataSet);
         if application.MessageBox(Pchar('Êtes-vous sûr de vouloir supprimer cet emprunt ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
           TableGereDelete(edCompte.DataSource.DataSet)
         else
           abort;
         DMEmprunts.QuCptEmpruntsAfterScroll(DMEmprunts.QuCptEmprunts);
         edCompte.DataSource.OnStateChange(edCompte.DataSource.DataSet);
//         GrDBGrid1.DataSource.DataSet.Close;
//         GrDBGrid1.DataSource.DataSet.Open;
      except
         TableGereRollBack(edCompte.DataSource.DataSet);
         TableGereRollBack(DMBalance.TaBalance);
         abort;
      end;
   end;
finally
  //DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.EnableControls;
end;
end;

procedure TDescEmp.BtnFermerClick(Sender: TObject);
begin
BtnAnnulerClick(self);
Self.Close;
end;

procedure TDescEmp.BtnImprimerClick(Sender: TObject);
begin
//if (FPrint = nil) then FPrint:=TFPrint.Create(self);
//FPrint.SelectionEtat := ;
//FPrint.show;
end;

function TDescEmp.CtrlChamp(Sender: TObject):TExceptLGR;
var
valide:TExceptLGR;
begin
if ((Sender is TDBEdit)and((Sender as TDBEdit).Field<>nil))then
  Begin
     try
     valide:=DMEmprunts.CtrlSaisieEmprunt((Sender as TDBEdit).Field);
     except
        valide.retour:=false;
     end;
     if valide.retour=false then
       Begin
          (Sender as TDBEdit).SetFocus;
          result:=valide;
          abort;
       End;
  End;
if ((Sender is TDBDateEdit)and((Sender as TDBDateEdit).Field<>nil)) then
  Begin
     try
     valide:=DMEmprunts.CtrlSaisieEmprunt((Sender as TDBDateEdit).Field);
     except
        valide.retour:=false;
     end;
     if valide.retour=false then
       Begin
          (Sender as TDBDateEdit).SetFocus;
          result:=valide;
          abort;
       End;
  End;
if ((sender is TDBRadioGroup)and((Sender as TDBRadioGroup).Field<>nil)) then
  Begin
     try
     valide:=DMEmprunts.CtrlSaisieEmprunt((Sender as TDBRadioGroup).Field);
     except
        valide.retour:=false;
     end;
if valide.retour=false then
       Begin
          (Sender as TDBRadioGroup).SetFocus;
          result:=valide;
          abort;
       End;
  End;
end;


procedure TDescEmp.edNumEmpExit(Sender: TObject);
begin
try
CtrlChamp(sender);
except
 abort;
end;
end;

procedure TDescEmp.edCompteExit(Sender: TObject);
begin
 try
   CtrlChamp(sender);
   BtnEnregistrer.Enabled:=not VerifFNumeric(edCompte.Field).VideOUZero
 except
   abort;
 end;//fin du try except
end;




procedure TDescEmp.edDesignationExit(Sender: TObject);
begin
 try
   CtrlChamp(sender);
 except
   abort;
 end;//fin du try except
end;

procedure TDescEmp.Insrer1Click(Sender: TObject);
begin
BtnInsererClick(sender);
end;

procedure TDescEmp.Modifier1Click(Sender: TObject);
begin
BtnModifierClick(sender);
end;

procedure TDescEmp.Enregister1Click(Sender: TObject);
begin
BtnEnregistrerClick(sender);
end;

procedure TDescEmp.Supprimer1Click(Sender: TObject);
begin
BtnSupprimerClick(sender);
end;

procedure TDescEmp.Annuler1Click(Sender: TObject);
begin
BtnAnnulerClick(sender);
end;


procedure TDescEmp.ChangementEtatBoutons(Sender: TObject);
begin
  //ChangementEtatGrille(DBEcheance);
  ChangementEtatBouttons(BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer,edCompte.DataSource.DataSet);

  if edCompte.DataSource.DataSet.State = dsedit then
   begin
     if ((activecontrol = GrDBGrid1) or (activecontrol =GrDBEmprunt)) then
       begin
         if edNumEmp.canfocus then edNumEmp.SetFocus;
         WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
       end
     else
        WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
   end
  else
    WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
  Init_TabStop_Controls([edCompte,edDesignation,edGroupe,edBanque,edDateReal,edMontantEmp,edDatePE,edCapiRbPE,edInteretPE,edNbPeriode,edP1,edP2,edP3,edPP1,edPP2,edPP3,DBRadioTypeRemb,DBRadioPeriodicite,RbDif,edFraisAnnexe,btnAnnuler,BtnFermer,BtnEnregistrer,BtnImprimer,
               BtnInserer,BtnModifier,BtnSupprimer],(edCompte.DataSource.DataSet.State in [dsedit,dsinsert]));
end;

procedure TDescEmp.RxSBEcheanceClick(Sender: TObject);
var
ParamAfficheEcheEmprunt:TParamAfficheEcheEmprunt;
begin
if edCompte.DataSource.DataSet.RecordCount<>0 then
  Begin
    ParamAfficheEcheEmprunt.AffichageModal:=true;
    ParamAfficheEcheEmprunt.Affiche:=true;
    ParamAfficheEcheEmprunt.Quand:=C_Mouvement;
    ParamAfficheEcheEmprunt.QuiAppel:=F_EcheEmprunt;
    RxSBEcheanceMouseLeave(sender);
    EcheEmpruntAffiche(ParamAfficheEcheEmprunt);
  End;
end;

procedure TDescEmp.RxSBEcheanceMouseLeave(Sender: TObject);
begin
if (sender is TRxSpeedButton) then
(Sender as TRxSpeedButton).Font.Color:=clWindowText;
//(Sender as TRxSpeedButton).Font.Style:=[fsBold];
end;




procedure TDescEmp.PaGrilleEnTeteResize(Sender: TObject);
begin
FormateTailleColonne(GrDBEmprunt,160,[2,10,20,20,20,20,20,20,20,20]);
PositionTotaux;
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;


Procedure TDescEmp.PositionTotaux;
Begin
   Panel5.Width:=RenvoiTailleColonne(GrDBEmprunt,[0,1,2,3,4])+10;
   GrDBGrid2.ColWidths[0]:=RenvoiTailleColonne(GrDBEmprunt,[5]);
   GrDBGrid2.ColWidths[1]:=RenvoiTailleColonne(GrDBEmprunt,[6]);
   GrDBGrid2.ColWidths[2]:=RenvoiTailleColonne(GrDBEmprunt,[7]);
   GrDBGrid2.ColWidths[3]:=RenvoiTailleColonne(GrDBEmprunt,[8]);
//   GrDBGrid2.ColWidths[4]:=RenvoiTailleColonne(GrDBEmprunt,[8]);
//   GrDBGrid2.ColWidths[5]:=RenvoiTailleColonne(GrDBEmprunt,[9]);
End;




Procedure TDescEmp.InitialiseTable_A_Nil;
Begin
  if DMEmprunts<>nil then
  InitDatasetEvent_A_Nil_Sur_Form([DMEmprunts.QuCptEmprunts,DMEmprunts.DaEmpruntGestion]);
    //DMEmprunts.QuCptEmprunts.AfterScroll:=nil;
end;
procedure TDescEmp.PaDetailCorpExit(Sender: TObject);
begin
try
//si dataset en insertion ou modif, poster
if edCompte.DataSource.DataSet.State in [dsinsert,dsedit]then
   tablegerePost(edCompte.DataSource.DataSet);
except
  abort;
end;
end;


Procedure TDescEmp.GestionInitDM;
var
ParamDMEmprunts:TParamDMEmprunts;
Begin
 ParamDMEmprunts.EmpruntsDataStateChange := changementEtatBoutons;
 ParamDMEmprunts.Quand := Quand;
 ParamDMEmprunts.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ParamDMEmprunts.QuiAppel:=F_DescEmp;
 InitialiseDMEmprunts(ParamDMEmprunts);
End;


Procedure TDescEmp.GereAccesEcran;
begin
     //Grille des comptes d'emprunts utilisés
     GrDBGrid1.ReadOnly := E.ExerciceCloture;
     GrDBGrid1.FSauteColReadOnly := not GrDBGrid1.ReadOnly;
     //Grille des emprunts existants pour le compte sélectionné
     GrDBEmprunt.ReadOnly := E.ExerciceCloture;
     GrDBEmprunt.FSauteColReadOnly := not GrDBEmprunt.ReadOnly;

  case Quand of
     C_Mouvement:Begin
                     //differentes zones de description de l'emprunt selectionné
                     edNumEmp.ReadOnly := E.ExerciceCloture;
                     edCompte.ReadOnly := E.ExerciceCloture;
                     edDesignation.ReadOnly := E.ExerciceCloture;
                     edGroupe.ReadOnly := E.ExerciceCloture;
                     edBanque.ReadOnly := E.ExerciceCloture;
                     edDateReal.ReadOnly := E.ExerciceCloture;
                     edMontantEmp.ReadOnly := E.ExerciceCloture;
                     edNbPeriode.ReadOnly := E.ExerciceCloture;
                     edP1.ReadOnly := E.ExerciceCloture;
                     edP2.ReadOnly := E.ExerciceCloture;
                     edP3.ReadOnly := E.ExerciceCloture;
                     edPP1.ReadOnly := E.ExerciceCloture;
                     edPP2.ReadOnly := E.ExerciceCloture;
                     edPP3.ReadOnly := E.ExerciceCloture;
                     DBRadioTypeRemb.ReadOnly := E.ExerciceCloture;
                     DBRadioPeriodicite.ReadOnly := E.ExerciceCloture;
                     RbDif.ReadOnly := E.ExerciceCloture;
                     edFraisAnnexe.ReadOnly := E.ExerciceCloture;
                     edDatePE.ReadOnly := E.ExerciceCloture;
                     edCapiRbPE.ReadOnly := E.ExerciceCloture;
                     edInteretPE.ReadOnly := E.ExerciceCloture;

                    EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer],not E.ExerciceCloture);
                    EnableItemMenu([Insrer1,Modifier1,Supprimer1],not E.ExerciceCloture);
                 End;
  end;
DMEmprunts.GestionAccesEmprunts;
end;
procedure TDescEmp.edGroupeKeyPress(Sender: TObject; var Key: Char);
begin
 key:=uppercase(key)[1];
end;

procedure TDescEmp.edPP1KeyPress(Sender: TObject; var Key: Char);
begin
if ((key in ['0'..'9',DecimalSeparator])and(edPP1.SelLength=0))then
  PrecisionFloat(edPP1.EditText,key);
end;

procedure TDescEmp.edPP2KeyPress(Sender: TObject; var Key: Char);
begin
if ((key in ['0'..'9',DecimalSeparator])and(edPP2.SelLength=0))then
  PrecisionFloat(edPP2.EditText,key);

end;

procedure TDescEmp.edPP3KeyPress(Sender: TObject; var Key: Char);
begin
if ((key in ['0'..'9',DecimalSeparator])and(edPP3.SelLength=0))then
  PrecisionFloat(edPP3.EditText,key);
end;

procedure TDescEmp.edFraisAnnexeKeyPress(Sender: TObject; var Key: Char);
begin
if ((key in ['0'..'9',DecimalSeparator])and(edFraisAnnexe.SelLength=0)) then
  PrecisionFloat(edFraisAnnexe.EditText,key);
end;

procedure TDescEmp.RxSBEnCoursClick(Sender: TObject);
var
ParamDMEmprunts:TParamDMEmprunts;
begin
if CBEnCours.State = cbchecked  then
 begin //si enCours est enfoncé
    typeEmprunts:=C_EnCours;
    CBFinis.State:=cbUnchecked;
    CBTous.State:=cbUnchecked;
 end //fin si enCours est enfoncé
else //si sub est enfoncé
   if CBFinis.State = cbchecked  then
      Begin //si Finis est enfoncé
        typeEmprunts:=C_Finis;
        CBEnCours.State:=cbUnchecked;
        CBTous.State:=cbUnchecked;
      End
     else
        Begin //si Tous est enfoncé
          typeEmprunts:=C_Tous;
          CBFinis.State:=cbUnchecked;
          CBEnCours.State:=cbUnchecked;
        End;
 Initialise_ParamDMEmprunts(ParamDMEmprunts);
 ParamDMEmprunts.EmpruntsDataStateChange := DescEmp.changementEtatBoutons;
 ParamDMEmprunts.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ParamDMEmprunts.Quand := DescEmp.Quand;
 ParamDMEmprunts.QuiAppel :=F_DescEmp;
 ParamDMEmprunts.typeEmprunt := typeEmprunts;
InitialiseDMEmprunts(ParamDMEmprunts);
end;

procedure TDescEmp.GestionBoutonCheck();
var
ParamDMEmprunts:TParamDMEmprunts;
begin
if(DescEmp<>nil)then
  begin
   Initialise_ParamDMEmprunts(ParamDMEmprunts);
   ParamDMEmprunts.EmpruntsDataStateChange := DescEmp.changementEtatBoutons;
   ParamDMEmprunts.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
   ParamDMEmprunts.Quand := DescEmp.Quand;
   ParamDMEmprunts.QuiAppel :=F_DescEmp;
   ParamDMEmprunts.typeEmprunt := typeEmprunts;
  InitialiseDMEmprunts(ParamDMEmprunts);
  end;
end;

procedure TDescEmp.PaToolsResize(Sender: TObject);
begin
FormateTailleBouttonAvecEspace([CBEnCours,CBFinis,CBTous],PaTools,110,0,5);
end;

procedure TDescEmp.CBEnCoursClick(Sender: TObject);
begin
if CBEnCours.State = cbchecked  then
 begin //si enCours est enfoncé
    typeEmprunts:=C_EnCours;
    CBFinis.State:=cbUnchecked;
    CBTous.State:=cbUnchecked;
 end //fin si enCours est enfoncé
else
if(CBEnCours.State=cbunchecked)and (CBFinis.State=cbunchecked)and (CBTous.state=cbunchecked) then
  CBEnCours.State:=cbchecked;
GestionBoutonCheck;
end;

procedure TDescEmp.CBFinisClick(Sender: TObject);
begin
   if CBFinis.State = cbchecked  then
      Begin //si Finis est enfoncé
        typeEmprunts:=C_Finis;
        CBEnCours.State:=cbUnchecked;
        CBTous.State:=cbUnchecked;
      End
else
if(CBEnCours.State=cbunchecked)and (CBFinis.State=cbunchecked)and (CBTous.state=cbunchecked) then
  CBFinis.State:=cbchecked;
GestionBoutonCheck;      
end;

procedure TDescEmp.CBTousClick(Sender: TObject);
begin
if CBTous.State = cbchecked then
  Begin //si Tous est enfoncé
    typeEmprunts:=C_Tous;
    CBFinis.State:=cbUnchecked;
    CBEnCours.State:=cbUnchecked;
  End
  else
if(CBEnCours.State=cbunchecked)and (CBFinis.State=cbunchecked)and (CBTous.state=cbunchecked) then
  CBTous.State:=cbchecked;
GestionBoutonCheck;
end;

end.





