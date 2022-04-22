unit E2_ChoixAmortissement;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, RXCtrls, ExtCtrls,DMImmos, RXDBCtrl,
  ExRxDBGrid, GrDBGrid,db,LibZoneSaisie,Gr_Librairie_Obj,E2_Decl_Records,registry,DMPiece,E2_Librairie_Obj,
  Menus,DMEcriture,DMConstantes, GrGrid,LibSQL, Mask, ToolEdit,LibDates,
  LibGestionParamXML,
  jpeg;

type

  TParamAffichageChoixAmortissement=Record
   Affiche:Boolean;
   AffichageModal:Boolean;
   Quand:Integer;
   TitreForm:String;
   SousTitreForm:String;
   ImmoCourante:integer;
   QuiAppel:TTypeFenetre;
   TypePresentation:integer;
  end;



  TChoixAmortissement = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaGrille: TPanel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    GrDBGrid1: TGrDBGrid;
    PaCumul: TPanel;
    PaTools: TPanel;
    Panel1: TPanel;
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
    GrGrid4: TGrGrid;
    PaEntete: TPanel;
    PaLibelle: TPanel;
    PaImmoIntit: TPanel;
    PaCptIntit: TPanel;
    PaSelectCpt: TPanel;
    RxSBClose: TRxSpeedButton;
    RxSBValider: TRxSpeedButton;
    RxSBInverse: TRxSpeedButton;
    RxSBAnnuleSel: TRxSpeedButton;
    EdRech: TEdit;
    RxChListCpt: TListBox;
    CheckBox1: TCheckBox;
    PaSelectImmos: TPanel;
    RxSBCloseImmos: TRxSpeedButton;
    RxSBValiderImmos: TRxSpeedButton;
    RxSBInverseImmos: TRxSpeedButton;
    RxSBAnnuleSelImmos: TRxSpeedButton;
    EdRechImmos: TEdit;
    RxChListImmos: TListBox;
    CheckBox2: TCheckBox;
    TiModifCalcul: TTimer;
    PaToolsCB: TPanel;
    CbSubventions: TCheckBox;
    CbDegressif: TCheckBox;
    cbImmos: TCheckBox;
    PaToolsBouton: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    BtnRestaurer: TButton;
    BtnInitMini: TButton;
    BtnInitMaxi: TButton;
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrDBGrid1ColExit(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure TaImmosChoixAfterScroll(DataSet: TDataSet);
    procedure PaGrilleResize(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure CalculSolde(Sender: TObject);
    procedure RxSBRestaurerClick(Sender: TObject);
    procedure PaCptIntitClick(Sender: TObject);
    procedure PaSelectCptResize(Sender: TObject);
    procedure RxSBValiderClick(Sender: TObject);
    procedure RxSBInverseClick(Sender: TObject);
    procedure RxSBAnnuleSelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure RxSBCloseClick(Sender: TObject);
    procedure GrDBGrid1TitleBtnClick(Sender: TObject; ACol: Integer;
      Field: TField);
    procedure Initialisation_selection(liste:tstringlist;ChampFiltre:string;Dataset:Tdataset);
    procedure PaSelectImmosResize(Sender: TObject);
    procedure PaImmoIntitClick(Sender: TObject);
    procedure RxSBValiderImmosClick(Sender: TObject);
    procedure RxSBInverseImmosClick(Sender: TObject);
    procedure RxSBAnnuleSelImmosClick(Sender: TObject);
    procedure RxSBCloseImmosClick(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure changementEtatBoutons(Sender: TObject);
    procedure GrDBGrid1Exit(Sender: TObject);
    procedure TiModifCalculTimer(Sender: TObject);
    Procedure GereAccesEcran;
    Procedure GestionInitDM;
    Procedure TimerDisabled(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
    procedure PaToolsBoutonResize(Sender: TObject);
    procedure PaToolsCBResize(Sender: TObject);
    procedure cbImmosClick(Sender: TObject);
    procedure GestionCheckBox(Refresh:boolean);
    procedure CbSubventionsClick(Sender: TObject);
    procedure CbDegressifClick(Sender: TObject);
    procedure BtnRestaurerClick(Sender: TObject);
    procedure BtnInitMiniClick(Sender: TObject);
    procedure BtnInitMaxiClick(Sender: TObject);
  private
    { Déclarations privées }

  public
    { Déclarations publiques }
    TitreForm,SousTitreForm:String;
    Quand:Integer;
    ImmoCourante:integer;
    TypeModif:TTypeModif;
    typeImmos:TtypeImmos;
    typeAmort:TTypeAmort;
  end;

var
  ChoixAmortissement: TChoixAmortissement;
  ListeCpt:TStringList;
  ListeTmp:TStringList;
  ListeImmo:TStringList;
  ListeID:TStringList;
  //ListeRestaure,ListeModif:TstringList;

  Function ChoixAmortissementAffiche(ParamAffichageChoixAmortissement:TParamAffichageChoixAmortissement):boolean;

implementation

uses E2_Main, DMImmo_Clot, E2_AideCompte, LibClassObjetSenders;

{$R *.DFM}

Function ChoixAmortissementAffiche(ParamAffichageChoixAmortissement:TParamAffichageChoixAmortissement):boolean;
var
ParamDMImmos:TParamDMImmos;
Begin
try
///etatinitial(mise à zéro)
Initialise_ParamDMimmos(ParamDMImmos);
////fin etatInitial

 if (ChoixAmortissement = nil) then ChoixAmortissement:=TChoixAmortissement.Create(Application.MainForm);
 if ((ParamAffichageChoixAmortissement.Quand <> ChoixAmortissement.Quand) and (ChoixAmortissement.Visible=true)) then
   ChoixAmortissement.Close;
 ChoixAmortissement.Quand:=ParamAffichageChoixAmortissement.Quand;
 ////
 ChoixAmortissement.Tag:=ParamAffichageChoixAmortissement.TypePresentation;
 ///
 if not empty(ParamAffichageChoixAmortissement.TitreForm) then
   ChoixAmortissement.TitreForm:=ParamAffichageChoixAmortissement.TitreForm;
 ChoixAmortissement.SousTitreForm:=ParamAffichageChoixAmortissement.SousTitreForm;
 ChoixAmortissement.ImmoCourante:=ParamAffichageChoixAmortissement.ImmoCourante;

 ParamDMImmos.TimerDisabled:=ChoixAmortissement.TimerDisabled;
 ParamDMImmos.ImmoCourante:=ParamAffichageChoixAmortissement.ImmoCourante;
 ParamDMImmos.ImmosDataStateChange := ChoixAmortissement.changementEtatBoutons;
 ParamDMImmos.TimerEvent:= ChoixAmortissement.CalculSolde;
 ParamDMImmos.ImmosAfterScroll:=ChoixAmortissement.TaImmosChoixAfterScroll;
 ParamDMImmos.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ParamDMImmos.TypePresentation:=ParamAffichageChoixAmortissement.TypePresentation;
 ParamDMImmos.Quand := ChoixAmortissement.Quand;
 ParamDMImmos.QuiAppel:=ParamAffichageChoixAmortissement.QuiAppel;
 ChoixAmortissement.GestionCheckBox(false);
 ParamDMImmos.typeImmos:=ChoixAmortissement.typeImmos;
 ParamDMImmos.typeAmort:=ChoixAmortissement.typeAmort;

////pour le moment, je restaure toujours par défaut //isa le 06-05-03
//  ChoixAmortissement.RxSBNonModifies.AllowAllUp:=true;
//  ChoixAmortissement.RxSBNonModifies.down:=true;
//  ChoixAmortissement.RxSBMini.down:=false;
//  ChoixAmortissement.RxSBMaxi.down:=false;
//  ChoixAmortissement.RxSBInitMini.down:=false;
//  ChoixAmortissement.RxSBInitMaxi.down:=false;
//  ChoixAmortissement.RxSBNonModifies.AllowAllUp:=false;

  ParamDMImmos.TypeModif:=RxNonModifies;
  ChoixAmortissement.TypeModif:=ParamDMImmos.TypeModif;

   case ChoixAmortissement.Quand of
      C_mouvement:Begin
                   if not InitialiseDMImmos(ParamDMImmos).retour then abort;
                  End;
   end;

 if ParamAffichageChoixAmortissement.Affiche then
  begin
     //differentes zones de description de l'immo selectionnée
     ChoixAmortissement.GrDBGrid1.DataSource := DataModuleImmos.DaImmosChoix;

   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(Application.MainForm);

     if ParamAffichageChoixAmortissement.AffichageModal then
       ChoixAmortissement.ShowModal
      else
       ChoixAmortissement.Show;
  End;
except
  result:=false;
end;
End;


Procedure TChoixAmortissement.GestionInitDM;
var
ParamDMImmos:TParamDMImmos;
Begin
try
///etatinitial(mise à zéro)
Initialise_ParamDMimmos(ParamDMImmos);
////fin etatInitial

 ParamDMImmos.QuiAppel:=F_ChoixAmortissement;
 ParamDMImmos.TypePresentation:=Tag;

 ParamDMImmos.TimerDisabled:=ChoixAmortissement.TimerDisabled;
 ParamDMImmos.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ParamDMImmos.ImmosDataStateChange := changementEtatBoutons;
 ParamDMImmos.TimerEvent:= ChoixAmortissement.CalculSolde;
 ParamDMImmos.ImmosAfterScroll:=TaImmosChoixAfterScroll;
 ParamDMImmos.CptImmosAfterOpen:=nil;
 ParamDMImmos.CptImmosAfterScroll:=nil;
 ParamDMImmos.Quand := ChoixAmortissement.Quand;
 ParamDMImmos.ImmoCourante := ChoixAmortissement.ImmoCourante;
 ParamDMImmos.typeImmos := ChoixAmortissement.typeImmos;
 ParamDMImmos.typeAmort := ChoixAmortissement.typeAmort;
 
//pour le moment, je restaure toujours par défaut //isa le 06-05-03
////  ChoixAmortissement.RxSBRestaurer.AllowAllUp:=true;
//  ChoixAmortissement.RxSBRestaurer.down:=true;
//  ChoixAmortissement.RxSBInitMini.down:=false;
//  ChoixAmortissement.RxSBInitMaxi.down:=false;
////  ChoixAmortissement.RxSBRestaurer.AllowAllUp:=false;

  ParamDMImmos.TypeModif:=RxNonModifies;
  ChoixAmortissement.TypeModif:=ParamDMImmos.TypeModif;

 if not InitialiseDMImmos(ParamDMImmos).retour then abort;
except
  MessageDlg('Problème rencontré lors de l''initialisation du datamodule des '+#13+#10+'immobilisations', mtWarning, [mbOK], 0);
end;
End;

Procedure TChoixAmortissement.GereAccesEcran;
begin
  case Quand of
     C_Mouvement:Begin
                     //differentes zones de description de l'immo selectionnée
                    GrDBGrid1.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));
                    GrDBGrid1.FSauteColReadOnly := not GrDBGrid1.ReadOnly;

                    EnableWinControl([BtnEnregistrer,BtnModifier],not ((not E.AccesCloture)or(DataModuleImmos.verrouillage)));
                    if BtnEnregistrer.Enabled then
                      EnableWinControl([BtnEnregistrer,BtnModifier],DataModuleImmos.ModificationImmos);
                    EnableWinControl([BtnImprimer],@BtnImprimer.OnClick<>nil);
                    EnableItemMenu([Enregister1,Modifier1],not ((not E.AccesCloture)or(DataModuleImmos.verrouillage)));
                    EnableItemMenu([Imprimer1],BtnImprimer.Enabled);
                 End;
  end;
DataModuleImmos.GestionAccesImmos;
end;




procedure TChoixAmortissement.BtnFermerClick(Sender: TObject);
begin
self.Close;
//regenerer la piece de dotation
//DataModuleImmos.suppressionPieceDotation:=false;
end;

procedure TChoixAmortissement.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TChoixAmortissement.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TChoixAmortissement.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TChoixAmortissement.FormCreate(Sender: TObject);
//var
//Registre :TRegistry;
Begin
// Registre:= TRegistry.Create;
//   try
          if DataModuleImmos=nil then
        DataModuleImmos:=TDataModuleImmos.Create(self);

//     with Registre do
//       begin
//       RootKey := HKEY_LOCAL_MACHINE;
//       OpenKey('\SOFTWARE\LGR\Epicea2\' + e.User+ '\' + self.Name, false);
////          try
////            RxSBRestaurer.AllowAllUp:=true;
//            RxSBInitMini.down:=ReadBool('RxSBInitMini');
//            RxSBInitMaxi.down:=ReadBool('RxSBInitMaxi');
//            RxSBRestaurer.down:=ReadBool('RxSBNonModifies');
////            RxSBRestaurer.AllowAllUp:=false;
//          except
//            RxSBMini.down:=false;
//            RxSBMaxi.down:=false;
//            RxSBInitMini.down:=false;
//            RxSBInitMaxi.down:=false;
//            RxSBRestaurer.down:=true;
//          end;
//       end;//fin du with
//   finally
//     Registre.Free;
//   end;

    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poDesigned;
        InitialiseFormPosDefaut(self);
	//Left:= 0; Top:= 70; Width:= screen.Width; Height:= screen.Height-top;
    end;
ListeCpt:=TStringList.Create;
Listetmp:=TStringList.Create;
ListeImmo:=TStringList.Create;
ListeID:=TStringList.Create;
end;

Procedure TChoixAmortissement.InitialiseTable_A_Nil;
Begin
if DataModuleImmos<>nil then
Begin
 InitDatasetEvent_A_Nil_Sur_Form([DataModuleImmos.DaImmosChoix,DataModuleImmos.taImmosChoix]);
 DataModuleImmos.taImmosChoix.OnFilterRecord:=nil;
End;
End;

procedure TChoixAmortissement.FormDestroy(Sender: TObject);
//Var
//  Registre :TRegistry;
Begin
  InitialiseTable_A_Nil;
//  Registre:= TRegistry.Create;
  try
//     with Registre do begin
//        RootKey := HKEY_LOCAL_MACHINE;
//        OpenKey('\SOFTWARE\LGR\Epicea2\' + e.User+ '\' + self.Name, True);
//        begin
//          WriteBool('RxSBMini',RxSBMini.down);
//          WriteBool('RxSBMaxi',RxSBMaxi.down);
//          WriteBool('RxSBInitMini',RxSBInitMini.down);
//          WriteBool('RxSBInitMaxi',RxSBInitMaxi.down);
//          WriteBool('RxSBRestaurer',RxSBRestaurer.down);
//        end;
//        CloseKey;
//     end;
  finally
//     Registre.Free;
    ListeCpt.Free;
    Listetmp.Free;
    ListeImmo.Free;
    ListeID.Free;
    LibGestionParamXML.DestroyForm(Self,E.User);
    try
     if DataModuleImmos<>nil then  DataModuleImmos.Free;
    except
     Showmessage('Erreur ChoixAmortissement');
    end;
    ChoixAmortissement:=nil;
  end;
end;

procedure TChoixAmortissement.FormActivate(Sender: TObject);
var
i:integer;
begin
Initialiser_ShortCut_Main(true);

GestionInitDM;

GrDBGrid1.ParamColor:=true;
GrDBGrid1.Param:=ParamUtil.CouleurDBGrid;
GrDBGrid1.UpDateColor;
//GrDBGrid1.Columns[6].Color:=$0099E5FF;

GrGrid4.ParamColor:=true;
GrGrid4.Param:=ParamUtil.CouleurDBGrid;
GrGrid4.DessineContourLigne:=false;
GrGrid4.UpDateColor;

calculSolde(nil);
GereAccesEcran;
end;

procedure TChoixAmortissement.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
KeyTmp:char;
begin
   if Key = VK_RETURN then
   begin
     WinSuivPrec(Handle,key,[GrDBGrid1]);
   end;
     If Key = VK_ESCAPE Then
     Begin
      if PaSelectCpt.Visible then
         begin
           PaSelectCpt.Visible:=false;
           key:=0;
         end;
      if PaSelectImmos.Visible then
         begin
           PaSelectImmos.Visible:=false;
           key:=0;
         end;

       If DataModuleImmos.TaImmosChoix.State = dsBrowse Then
          begin
             if BtnEnregistrer.Enabled then
               begin
               if Application.MessageBox(PChar('Voulez-vous Sauvegarder ces choix ?'),'Confirmation',MB_YESNO + MB_DEFBUTTON1) = IDYES then
                  BtnEnregistrerClick(self)
               else
                  //DataModuleImmos.RestaurerChoixAvantModif(DataModuleImmos.ListeRestaure);
                  TableGereRollBack(DataModuleImmos.TaImmosChoix);
                  BtnEnregistrer.Enabled:=false;
               end;
             Self.Close ;
          end;

          If DataModuleImmos.TaImmosChoix.State = dsEdit Then
          Begin
               If Messagedlg('Annuler les modifications de cette immobilisation ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    DataModuleImmos.TaImmosChoix.Cancel;
                    GrDBGrid1.SetFocus;
                    Abort;
               End
               Else
               Begin
                    Abort;
               End
          End;
     End;
end;




procedure TChoixAmortissement.GrDBGrid1ColExit(Sender: TObject);
var
valide:TExceptLGR;
begin
valide:=DataModuleImmos.CtrlInfosChoixAmortissement(GrDBGrid1.SelectedField);
if not valide.Retour then
  abort;
end;

procedure TChoixAmortissement.BtnEnregistrerClick(Sender: TObject);
var
reference:string;
begin
try
if VerificationSiPieceDeDotation(reference)then
   if Application.MessageBox(PChar('Si vous enregister ce nouveau choix, la pièce de dotation sera supprimée, voulez-vous continuer ?'),'Confirmation',MB_YESNO + MB_DEFBUTTON1) = IDYES then
     begin
     if DMImmo_Clo.SuppressionPieceDeDotationAmortissement(reference,false)then
       DataModuleImmos.suppressionPieceDotation:=true;
     end
   else
     abort;
//DataModuleImmos.ListeRestaure.Clear;
//DataModuleImmos.SauvegardeChoixAvantModif(DataModuleImmos.ListeRestaure);
TableGereCommit(DataModuleImmos.TaImmosChoix);
BtnEnregistrer.Enabled:=false;
DataModuleImmos.ModificationImmos:=false;
except
 abort;
end;//fin du try except
end;


procedure TChoixAmortissement.TaImmosChoixAfterScroll(DataSet: TDataSet);
begin
 BtnEnregistrer.Enabled:=DataModuleImmos.ModificationImmos;
   cbImmos.Enabled:=not (DataModuleImmos.TaImmosChoix.State in [dsinsert,dsedit]);
   CbSubventions.Enabled:=not (DataModuleImmos.TaImmosChoix.State in [dsinsert,dsedit]);
   CbDegressif.Enabled:=not (DataModuleImmos.TaImmosChoix.State in [dsinsert,dsedit]);
//   cbImmos.Enabled:=not DataModuleImmos.ModificationImmos;
//   CbSubventions.Enabled:=not DataModuleImmos.ModificationImmos;
//   CbDegressif.Enabled:=not DataModuleImmos.ModificationImmos;
end;


procedure TChoixAmortissement.PaGrilleResize(Sender: TObject);
begin
  WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
  FormateTailleColonne(GrDBGrid1,26,[2,4,1,3,3,3,3,3]);
  Panel1.Width:=RenvoiTailleColonne(GrDBGrid1,[0,1,2,3])+10;
  GrGrid4.ColWidths[0]:=RenvoiTailleColonne(GrDBGrid1,[4]);
  GrGrid4.ColWidths[1]:=RenvoiTailleColonne(GrDBGrid1,[5]);
  GrGrid4.ColWidths[2]:=RenvoiTailleColonne(GrDBGrid1,[6]);
  GrGrid4.ColWidths[3]:=RenvoiTailleColonne(GrDBGrid1,[7]);
  GrGrid4.ColWidths[4]:=RenvoiTailleColonne(GrDBGrid1,[8]);
  PaSelectCpt.Width:=PaCptIntit.Width-10;
  PaSelectImmos.Width:=PaImmoIntit.Width-10;
end;

procedure TChoixAmortissement.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TChoixAmortissement.Visualisation1Click(Sender: TObject);
begin
 if not empty(DataModuleImmos.TaImmosChoix.findfield('compte').ASString) then
   DetailEcritureCompte(DataModuleImmos.TaImmosChoix.findfield('compte').ASString,true,false)
end;

procedure TChoixAmortissement.Aide1Click(Sender: TObject);
begin
//
end;

procedure TChoixAmortissement.CalculSolde(Sender: TObject);
var
Totaux:TTotauxGeneric;
Begin
GrDBGrid1.DataSource.DataSet.DisableControls ;
  InitialiseTotauxGeneric(Totaux);
  Totaux:=SommeTotauxGenericQuery(['Eco','Mini','Maxi','Choix','Derog'],GrDBGrid1.DataSource.DataSet);
  GrGrid4.Cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ', Totaux.Total1);
  GrGrid4.Cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',Totaux.Total5 );
  GrGrid4.Cells[2,0]:=FormatFloat(E.FormatMonnaie + ';; ', Totaux.Total2);
  GrGrid4.Cells[3,0]:=FormatFloat(E.FormatMonnaie + ';; ', Totaux.Total3);
  GrGrid4.Cells[4,0]:=FormatFloat(E.FormatMonnaie + ';; ', Totaux.Total4);
GrDBGrid1.DataSource.DataSet.EnableControls;
End;



procedure TChoixAmortissement.RxSBRestaurerClick(Sender: TObject);
begin
try
//tout sera initialisé au maxi
if DataModuleImmos.TaImmosChoix.State in [dsinsert,dsedit] then
  TableGerePost(DataModuleImmos.TaImmosChoix);
DataModuleImmos.ModificationImmos:=false;
//activer le timer et lui passer le choix par l'intermédiaire de son tag
//TiModifCalcul.tag:=0;
TypeModif:=RxNonModifies;
TiModifCalcul.Enabled:=true;
except
  TiModifCalcul.Enabled:=false;
end;

end;

procedure TChoixAmortissement.PaCptIntitClick(Sender: TObject);
var
id_depart,i:integer;
begin
if not PaSelectCpt.Visible then
   Begin
   PaSelectImmos.Visible:=false;
   rxchlistImmos.clear;
    if RxChListCpt.Items.Count =0 then
       Begin
         ListeCpt.Clear;
         ListeImmo.Clear;
         ListeID.clear;
         RxChListCpt.Tag:=1;
         DataModuleImmos.taImmosChoix.DisableControls;
         id_depart:=DataModuleImmos.taImmosChoixid.AsInteger;
         FiltrageDataSet(DataModuleImmos.TaImmosChoix,'');//je filtre à vide car les conditions du filter record suffisent
         DataModuleImmos.taImmosChoix.First;
         for i:=0 to DataModuleImmos.taImmosChoix.RecordCount-1 do
             Begin
              if ListeCpt.IndexOf(DataModuleImmos.taImmosChoix.findfield('Compte').AsString)=-1 then
              begin
              RxChListCpt.Items.Add(DataModuleImmos.taImmosChoix.findfield('Compte').AsString);
                ListeCpt.Add(DataModuleImmos.taImmosChoix.findfield('Compte').AsString);
                ListeImmo.Add(DataModuleImmos.taImmosChoix.findfield('immobilisation').AsString);
              end;
              DataModuleImmos.taImmosChoix.Next;
             End;
         DataModuleImmos.taImmosChoix.locate('id',id_depart,[]);
         DataModuleImmos.taImmosChoix.EnableControls;
       End;
PaSelectCpt.Top:=PaGrille.top+18;
PaSelectCpt.Width:=PaCptIntit.Width-10;
EdRech.Visible:=false;
RxChListCpt.Width:=PaSelectCpt.Width;
PaSelectCpt.Height:=PaGrille.Height-20;
RxChListCpt.Height:=PaSelectCpt.Height-69;// 298;
RxSBValider.Top:=PaSelectCpt.Height-47;
CheckBox1.Top:=RxSBValider.Top+5;
RxSBInverse.Top:=PaSelectCpt.Height-47;
RxSBAnnuleSel.Top:=PaSelectCpt.Height-22;
PaSelectCpt.Left:=PaCptIntit.left+5;
PaSelectCpt.Visible:=not PaSelectCpt.Visible;
RxChListCpt.SetFocus;
   End;
end;

procedure TChoixAmortissement.PaSelectCptResize(Sender: TObject);
begin
RxChListCpt.Width:=PaSelectCpt.Width-8;
EdRech.Width:=PaSelectCpt.Width-8;
RxSBClose.Width:=PaSelectCpt.Width;
RxSBAnnuleSel.Width:=PaSelectCpt.Width;
RxSBValider.Width:=PaSelectCpt.Width div 2;
RxSBInverse.Left:=RxSBValider.Width-1;
RxSBInverse.Width:=PaSelectCpt.Width-RxSBInverse.Left;
end;

procedure TChoixAmortissement.RxSBValiderClick(Sender: TObject);
var
i:integer;
begin
ListeTmp.Clear;
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
    if RxChListCpt.Selected[i] then
      ListeTmp.Add(ListeCpt.Strings[i]);
   End;
//initialiser la nouvelle sélection
Initialisation_selection(listetmp,'Compte',GrDBGrid1.DataSource.DataSet);

if CheckBox1.Checked then
 begin
  GrDBGrid1.SetFocus;
  PaSelectCpt.Visible:=false;
 end
 else
 begin
  GrDBGrid1.SetFocus;
 end;
end;


procedure TChoixAmortissement.RxSBInverseClick(Sender: TObject);
var
i:integer;
begin
ListeTmp.Clear;
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
    RxChListCpt.Selected[i]:=not RxChListCpt.Selected[i];
    if RxChListCpt.Selected[i] then
     ListeTmp.Add(ListeCpt.Strings[i]);
   End;

//initialiser la nouvelle sélection
Initialisation_selection(listetmp,'Compte',GrDBGrid1.DataSource.DataSet);
end;

procedure TChoixAmortissement.RxSBAnnuleSelClick(Sender: TObject);
var
i:integer;
begin
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
    RxChListCpt.Selected[i]:=false;
   End;
//initialiser la nouvelle sélection
Initialisation_selection(nil,'Compte',GrDBGrid1.DataSource.DataSet);
end;

procedure TChoixAmortissement.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
Filtre:TFiltre;
begin
try
canclose:=true;
       If DataModuleImmos.TaImmosChoix.State = dsBrowse Then
          begin
             if BtnEnregistrer.Enabled then
               begin
              self.WindowState:=wsNormal;
              self.BringToFront;
               if Application.MessageBox(PChar('Voulez-vous Sauvegarder ces choix ?'),'Confirmation',MB_YESNO + MB_DEFBUTTON1) = IDYES then
                  BtnEnregistrerClick(self)
               else
                  //DataModuleImmos.RestaurerChoixAvantModif(DataModuleImmos.ListeRestaure);
                  Filtre.filtrer:=DataModuleImmos.TaImmosChoix.Filtered;
                  DataModuleImmos.TaImmosChoix.Filtered:=false;
                  TableGereRollBack(DataModuleImmos.TaImmosChoix);
                  DataModuleImmos.TaImmosChoix.Filtered:=Filtre.filtrer;
                  BtnEnregistrer.Enabled:=false;
               end;
          end;

          If DataModuleImmos.TaImmosChoix.State = dsEdit Then
          Begin
              self.WindowState:=wsNormal;
              self.BringToFront;
               If Messagedlg('Voulez-vous enregistrer les modifications de cette immobilisation ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    TableGerePost(DataModuleImmos.TaImmosChoix);
               End
               Else
               Begin
                    DataModuleImmos.TaImmosChoix.Cancel;
               End
          End;
if PaSelectCpt.Visible then PaSelectCpt.Visible:=false;
if PaSelectImmos.Visible then PaSelectImmos.Visible:=false;
TableGereCommit(DataModuleImmos.TaImmosChoix);
if canclose then InitialiseTable_A_Nil;{ isa  le  29/01/04 }
except
  TableGereRollBack(DataModuleImmos.TaImmosChoix);
  canclose:=false;
  abort;
end;
end;

procedure TChoixAmortissement.RxSBCloseClick(Sender: TObject);
begin
PaSelectCpt.Visible:=false;
end;

procedure TChoixAmortissement.GrDBGrid1TitleBtnClick(Sender: TObject;
  ACol: Integer; Field: TField);
begin
if acol=1 then
  PaCptIntitClick(PaCptIntit);
end;


procedure TChoixAmortissement.Initialisation_selection(liste:tstringlist;ChampFiltre:string;Dataset:Tdataset);
begin
if liste <> nil then
 Begin
 if liste.Count > 0 then
  begin
    FiltrageDataSet(Dataset,CreeFiltreOU(champfiltre,[liste]));
  end;
 End
 else
   DeFiltrageDataSet(dataset);
calculSolde(nil);
end;


procedure TChoixAmortissement.PaSelectImmosResize(Sender: TObject);
begin
RxChListImmos.Width:=PaSelectImmos.Width-8;
EdRechImmos.Width:=PaSelectImmos.Width-8;
RxSBCloseImmos.Width:=PaSelectImmos.Width;
RxSBAnnuleSelImmos.Width:=PaSelectImmos.Width;
RxSBValiderImmos.Width:=PaSelectImmos.Width div 2;
RxSBInverseImmos.Left:=RxSBValiderImmos.Width-1;
RxSBInverseImmos.Width:=PaSelectImmos.Width-RxSBInverse.Left;
end;

procedure TChoixAmortissement.PaImmoIntitClick(Sender: TObject);
var
id_depart,i:integer;
begin
if not PaSelectImmos.Visible then
   Begin
   PaSelectCpt.Visible:=false;
   rxchlistCpt.clear;
    if RxChListImmos.Items.Count =0 then
       Begin
         ListeCpt.Clear;
         ListeImmo.Clear;
         ListeID.clear;
         RxChListImmos.Tag:=1;
         DataModuleImmos.taImmosChoix.DisableControls;
         id_depart:=DataModuleImmos.taImmosChoixid.AsInteger;
         FiltrageDataSet(DataModuleImmos.TaImmosChoix,'');//je filtre à vide car les conditions du filter record suffisent
         DataModuleImmos.taImmosChoix.First;
         for i:=0 to DataModuleImmos.taImmosChoix.RecordCount-1 do
             Begin
              if ListeImmo.IndexOf(DataModuleImmos.taImmosChoix.findfield('Immobilisation').AsString)=-1 then
              begin
                RxChListImmos.Items.Add(DataModuleImmos.taImmosChoix.findfield('Immobilisation').AsString);
                ListeID.Add(DataModuleImmos.taImmosChoix.findfield('ID').AsString);
                ListeCpt.Add(DataModuleImmos.taImmosChoix.findfield('Compte').AsString);
                ListeImmo.Add(DataModuleImmos.taImmosChoix.findfield('Immobilisation').AsString);
              end;
              DataModuleImmos.taImmosChoix.Next;
             End;
         DataModuleImmos.taImmosChoix.locate('id',id_depart,[]);
         DataModuleImmos.taImmosChoix.EnableControls;
       End;
PaSelectImmos.Top:=PaGrille.top+18;
PaSelectImmos.Width:=PaImmoIntit.Width-10;
EdRechImmos.Visible:=false;
RxChListImmos.Width:=PaSelectImmos.Width;
PaSelectImmos.Height:=PaGrille.Height-20;
RxChListImmos.Height:=PaSelectImmos.Height-69;// 298;
RxSBValiderImmos.Top:=PaSelectImmos.Height-47;
CheckBox2.Top:=RxSBValiderImmos.Top+5;
RxSBInverseImmos.Top:=PaSelectImmos.Height-47;
RxSBAnnuleSelImmos.Top:=PaSelectImmos.Height-22;
PaSelectImmos.Left:=PaImmoIntit.left+5;
PaSelectImmos.Visible:=not PaSelectImmos.Visible;
RxChListImmos.SetFocus;
   End;
end;

procedure TChoixAmortissement.RxSBValiderImmosClick(Sender: TObject);
var
i:integer;
begin
ListeTmp.Clear;
for i:=0  to RxChListImmos.Items.Count-1 do
   Begin
    if RxChListImmos.Selected[i] then
      ListeTmp.Add(ListeID.Strings[i]);
   End;
//initialiser la nouvelle sélection
Initialisation_selection(listetmp,'id',GrDBGrid1.DataSource.DataSet);

if CheckBox1.Checked then
 begin
  GrDBGrid1.SetFocus;
  PaSelectIMMOS.Visible:=false;
 end
 else
 begin
  GrDBGrid1.SetFocus;
 end;
end;

procedure TChoixAmortissement.RxSBInverseImmosClick(Sender: TObject);
var
i:integer;
begin
ListeTmp.Clear;
for i:=0  to RxChListImmos.Items.Count-1 do
   Begin
    RxChListImmos.Selected[i]:=not RxChListImmos.Selected[i];
    if RxChListImmos.Selected[i] then
     ListeTmp.Add(ListeID.Strings[i]);
   End;

//initialiser la nouvelle sélection
Initialisation_selection(listetmp,'id',GrDBGrid1.DataSource.DataSet);
end;

procedure TChoixAmortissement.RxSBAnnuleSelImmosClick(Sender: TObject);
var
i:integer;
begin
for i:=0  to RxChListImmos.Items.Count-1 do
   Begin
    RxChListImmos.Selected[i]:=false;
   End;
//initialiser la nouvelle sélection
Initialisation_selection(nil,'',GrDBGrid1.DataSource.DataSet);
end;

procedure TChoixAmortissement.RxSBCloseImmosClick(Sender: TObject);
begin
PaSelectImmos.Visible:=false;
end;

procedure TChoixAmortissement.BtnImprimerClick(Sender: TObject);
begin
EditionListeDesChoixAmortissementL(C_EditionSimple,false,nil,DataModuleImmos.TaImmosChoix);
//GrDBGrid1.ReportCaption:='Liste des Choix d''amortissement';
//GrDBGrid1.GridPreview;
end;

procedure TChoixAmortissement.BtnModifierClick(Sender: TObject);
begin
GrDBGrid1.DataSource.DataSet.Edit;
end;


procedure TChoixAmortissement.changementEtatBoutons(Sender: TObject);
begin
    case GrDBGrid1.DataSource.DataSet.state of
     dsBrowse: begin
                 BtnModifier.Enabled := GrDBGrid1.DataSource.DataSet.RecordCount<>0;
                 End; // Fin du case sur le Tag de la fenêtre
     dsEdit:   begin
                 BtnModifier.Enabled :=false;
                 End; // Fin du case sur le Tag de la fenêtre
     dsInsert: begin
                 BtnModifier.Enabled := False;
                 End; // Fin du case sur le Tag de la fenêtre
     end;//fin du case.state$

   //Pop-up Menu
   cbImmos.Enabled:=not DataModuleImmos.ModificationImmos;
   CbSubventions.Enabled:=not DataModuleImmos.ModificationImmos;
   CbDegressif.Enabled:=not DataModuleImmos.ModificationImmos;
   BtnEnregistrer.Enabled:=DataModuleImmos.ModificationImmos;
   Fermer1.Enabled:=BtnFermer.Enabled;
   Insrer1.Enabled:=BtnInserer.Enabled;
   Enregister1.Enabled:=BtnEnregistrer.Enabled;
   Modifier1.Enabled:=BtnModifier.Enabled;
   Supprimer1.Enabled:=BtnSupprimer.Enabled;
   Imprimer1.Enabled:=BtnImprimer.Enabled;
end;



procedure TChoixAmortissement.GrDBGrid1Exit(Sender: TObject);
begin
TableGerePost(DataModuleImmos.TaImmosChoix);
end;

procedure TChoixAmortissement.TiModifCalculTimer(Sender: TObject);
begin
try
Screen.Cursor := crSQLWait;
DataModuleImmos.initialiserChoix_Choix(TypeModif,nil);
calculSolde(nil);
finally
TiModifCalcul.Enabled:=false;
  Screen.Cursor := crDefault;
end;
end;


Procedure TChoixAmortissement.TimerDisabled(Sender: TObject);
begin
  TiModifCalcul.Enabled:=false;
end;
procedure TChoixAmortissement.Calculatrice1Click(Sender: TObject);
begin
if GrDBGrid1.Col in [6] then
  AfficheCalculatrice(GrDBGrid1)
else
  AfficheCalculatrice(nil);
end;

procedure TChoixAmortissement.PaToolsBoutonResize(Sender: TObject);
begin
  FormateTailleBouttonAvecEspace([BtnInitMini,BtnInitMaxi,BtnRestaurer],PaToolsBouton,100,0,5);
end;

procedure TChoixAmortissement.PaToolsCBResize(Sender: TObject);
begin
FormateTailleBouttonAvecEspace([cbImmos,CbSubventions,CbDegressif],PaToolsCB,100,0,5);
end;

procedure TChoixAmortissement.cbImmosClick(Sender: TObject);
begin
if(not cbimmos.Checked)and(not CbSubventions.Checked)then
  CbSubventions.Checked:=true;
GestionCheckBox(true);
end;

procedure TChoixAmortissement.GestionCheckBox(Refresh:boolean);
begin
  try
    if DataModuleImmos.TaImmosChoix.State in [dsinsert,dsedit] then
      TableGerePost(DataModuleImmos.TaImmosChoix);
    if not (DataModuleImmos.TaImmosChoix.State in [dsinsert,dsedit])then
      begin
          if(cbImmos.Checked)and (CbSubventions.Checked)then
            typeImmos:=C_Toutes
          else
            if cbImmos.Checked then typeImmos:=C_Immo
            else
              if CbSubventions.Checked then typeImmos:=C_Sub;
          if(CbDegressif.Checked) then
            typeAmort:=C_Degessif
          else
            typeAmort:=C_Tout;
          DataModuleImmos.typeImmos:=typeImmos;
          DataModuleImmos.typeAmort:=typeAmort;
          if Refresh then
            DataModuleImmos.TaImmosChoix.refresh;
      end;
  except
  end;
calculSolde(nil);  
end;


procedure TChoixAmortissement.CbSubventionsClick(Sender: TObject);
begin
if(not cbimmos.Checked)and(not CbSubventions.Checked)then
  cbimmos.Checked:=true;
GestionCheckBox(true);
end;

procedure TChoixAmortissement.CbDegressifClick(Sender: TObject);
begin
GestionCheckBox(true);
end;

procedure TChoixAmortissement.BtnRestaurerClick(Sender: TObject);
begin
try
//tout sera initialisé au maxi
if DataModuleImmos.TaImmosChoix.State in [dsinsert,dsedit] then
  TableGerePost(DataModuleImmos.TaImmosChoix);
DataModuleImmos.ModificationImmos:=false;
//activer le timer et lui passer le choix par l'intermédiaire de son tag
//TiModifCalcul.tag:=0;
TypeModif:=RxNonModifies;
TiModifCalcul.Enabled:=true;
except
  TiModifCalcul.Enabled:=false;
end;
end;

procedure TChoixAmortissement.BtnInitMiniClick(Sender: TObject);
begin
try
//tout sera initialisé au mini
if DataModuleImmos.TaImmosChoix.State in [dsinsert,dsedit] then
  TableGerePost(DataModuleImmos.TaImmosChoix);
//activer le timer et lui passer le choix par l'intermédiaire de son tag
//TiModifCalcul.tag:=3;
TypeModif:=RxInitMini;
TiModifCalcul.Enabled:=true;
except
  TiModifCalcul.Enabled:=false;
end;
end;

procedure TChoixAmortissement.BtnInitMaxiClick(Sender: TObject);
begin
try
//tout sera initialisé au maxi
if DataModuleImmos.TaImmosChoix.State in [dsinsert,dsedit] then
  TableGerePost(DataModuleImmos.TaImmosChoix);
//activer le timer et lui passer le choix par l'intermédiaire de son tag
//TiModifCalcul.tag:=4;
TypeModif:=RxInitMaxi;
TiModifCalcul.Enabled:=true;
except
  TiModifCalcul.Enabled:=false;
end;
end;

end.
