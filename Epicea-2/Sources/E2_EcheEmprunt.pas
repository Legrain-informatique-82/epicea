unit E2_EcheEmprunt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Grids, DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid, RXCtrls,
  ExtCtrls,DMEmprunt, GrGrid,LibZoneSaisie,DMConstantes,LibSQL,E2_Librairie_Obj,
  db,Gr_Librairie_Obj,E2_Recherche,E2_Decl_Records, jpeg,
  DMRecherche,
  E2_LibInfosTable,
  LibGestionParamXML, Editions;

type

TParamAfficheEcheEmprunt=record
   Affiche:Boolean;
   AffichageModal:Boolean;
   Quand:Integer;
   TitreForm:String;
   QuiAppel:TTypeFenetre;
   SousTitreForm:String;
end;

  TEcheEmprunt = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre1: TRxLabel;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    RxSBImport: TRxSpeedButton;
    PaGrille: TPanel;
    DBEcheance: TGrDBGrid;
    PaBas: TPanel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnModifier: TButton;
    BtnInserer: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
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
    Modifier1: TMenuItem;
    Insrer1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    N2: TMenuItem;
    Prcdent1: TMenuItem;
    Suivant1: TMenuItem;
    PaCumul1: TPanel;
    PaCumul: TPanel;
    GrDBGrid2: TGrDBGrid;
    Panel1: TPanel;
    RxLabTitre2: TRxLabel;
    procedure Aideenligne1Click(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
//    procedure changementEtatBoutons(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DaEcheanceStateChange(Sender: TObject);
    procedure RxSBImportClick(Sender: TObject);
    procedure EtatInitial;
    procedure PaBtnResize(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    Procedure PositionTotaux;
    procedure DBEcheanceColExit(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure DBEcheanceColEnter(Sender: TObject);
    procedure DBEcheanceDblClick(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    Procedure GestionInitDM;
    Procedure GereAccesEcran;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    TitreForm,SousTitreForm:String;
    Quand:Integer;
  end;

var
  EcheEmprunt: TEcheEmprunt;

  Function EcheEmpruntAffiche(ParamAfficheEcheEmprunt:TParamAfficheEcheEmprunt):Boolean;
  
implementation

uses DMBalances, E2_Main, E2_AideCompte, LibClassObjetSenders;

{$R *.DFM}

procedure TEcheEmprunt.Aideenligne1Click(Sender: TObject);
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

procedure TEcheEmprunt.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TEcheEmprunt.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TEcheEmprunt.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TEcheEmprunt.BtnEnregistrerClick(Sender: TObject);
begin
  try
  TableGerePost(DBEcheance.DataSource.DataSet);
  except
    abort;
  end;//fin du try
end;

procedure TEcheEmprunt.BtnFermerClick(Sender: TObject);
begin
BtnAnnulerClick(self);
Self.Close;
end;

procedure TEcheEmprunt.BtnImprimerClick(Sender: TObject);
var Site:TEditLien;
begin
//if (FPrint = nil) then FPrint:=TFPrint.Create(self);
//FPrint.SelectionEtat := ;
//FPrint.show;
// EditionEcheancier(C_EditionSimple,C_Ouverture,DMEmprunts.TaEcheanceGestion,nil,Site);
EditionEmpruntEcheancierL(C_EditionSimple,DMEmprunts.TaEcheanceGestion.findfield('id_emp').asinteger,nil)
end;

procedure TEcheEmprunt.BtnModifierClick(Sender: TObject);
begin
  DBEcheance.DataSource.DataSet.Edit;
end;

procedure TEcheEmprunt.BtnInsererClick(Sender: TObject);
begin
//  DBEcheance.DataSource.DataSet.insert;
  TableAjoute(DBEcheance.DataSource.DataSet);
end;

procedure TEcheEmprunt.BtnSupprimerClick(Sender: TObject);
begin
try
  try
    TableGereStartTransaction(DBEcheance.DataSource.DataSet);
     if application.MessageBox(Pchar('Êtes-vous sûr de vouloir supprimer cet échéance ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
       TableGereDelete(DBEcheance.DataSource.DataSet)
     else
       abort;
  except
     TableGereRollBack(DBEcheance.DataSource.DataSet);
     TableGereRollBack(DMBalance.TaBalance);
     abort;
  end;
finally
  ///
end;
end;

procedure TEcheEmprunt.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(nil);
end;





procedure TEcheEmprunt.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
GestionInitDM;

Patitre.visible:=Main.AfficheTitre;

DBEcheance.ParamColor:=true;
DBEcheance.Param:=ParamUtil.CouleurDBGrid;
DBEcheance.UpDateColor;

GrDBGrid2.ParamColor:=true;
GrDBGrid2.Param:=ParamUtil.CouleurDBGrid;
GrDBGrid2.UpDateColor;

GereAccesEcran;
end;

procedure TEcheEmprunt.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
if DMEmprunts <> nil then
 begin
  // Si l'utilisateur est en mode Insertion
     If DBEcheance.DataSource.DataSet.State = dsInsert Then
     Begin
          If BtnEnregistrer.Enabled Then
          Begin
                if application.MessageBox(Pchar('Voulez-vous enregistrer cette nouvelle échéance ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
                 begin
                   BtnEnregistrerClick(btnenregistrer);
                   canclose:=true;
                  end
                  else
                   begin
                   DBEcheance.DataSource.DataSet.Cancel;
                   canclose:=true;
                   end;
          End
          Else
          Begin
                if application.MessageBox(Pchar('Voulez-vous annuler la création cette nouvelle échéance ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
                begin
                  DBEcheance.DataSource.DataSet.Cancel;
                  canclose:=true;
                end
               Else
                 begin
                  canclose:=false;
                  end;
          End;
     End; // Fin utilisateur est en mode Insertion

     // Si l'utilisateur est en mode Modification
     If DBEcheance.DataSource.DataSet.State = dsEdit Then
     Begin
           if application.MessageBox(Pchar('Voulez-vous enregistrer les modifications de cette échéance ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
           begin
            BtnEnregistrerClick(btnenregistrer);
            canclose:=true;
             end
             else
             begin
              DBEcheance.DataSource.DataSet.Cancel;
             end;
     End; // Fin utilisateur est en mode Modification
  InitialiseTable_A_Nil;
  end;//fin si DMEmprunts <> nil
if CanClose then
 else
 begin
    if DMEmprunts=nil then
   DMEmprunts:=TDMEmprunts.Create(self);

   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(self);

 end;

end;


procedure TEcheEmprunt.FormCreate(Sender: TObject);
begin
    try
    if DMEmprunts = nil then
      DMEmprunts:=TDMEmprunts.Create(application.MainForm);

	       LibGestionParamXML.InitialiseForm(E.USer,Self);

    except
        Position:=poDesigned;
        InitialiseFormPosDefaut(self);
	//Left:= 0; Top:= 70; Width:= screen.Width; Height:= screen.Height-top;
    end;
end;

procedure TEcheEmprunt.FormDestroy(Sender: TObject);
begin
   LibGestionParamXML.DestroyForm(Self,e.user);
   InitialiseTable_A_Nil;
   EcheEmprunt:=nil;

end;

procedure TEcheEmprunt.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
KeyTmp:char;
begin
if key=vk_F1 then
  Begin
    if DBEcheance.SelectedField.DataType in [fTDate,fTDateTime] then
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
if (key = VK_RETURN)then
 WinSuivPrec(Handle,key,[DBEcheance])
else
 WinSuivPrec(Handle,key,[DBEcheance,GrDBGrid2]);
     If Key = VK_ESCAPE Then
     Begin
       If DBEcheance.DataSource.DataSet.State = dsBrowse Then
          begin
             Self.Close ;
          end;

      If DBEcheance.DataSource.DataSet.State = dsInsert Then
          Begin
//            if not VerifFNumeric(edcompte.Field).VideOUZero then
//              begin//si commencé à remplir
               If Messagedlg('Annuler la création de cette échéance ?',MtConfirmation,[mbno,mbyes],0) = mryes Then
               Begin
                    DBEcheance.DataSource.DataSet.Cancel;
                    DBEcheance.SetFocus;
               End
               Else
               Begin
                    Abort;
               End;
//              end//fin si commencé à remplir
//            else
//              begin
//                DBEcheance.DataSource.DataSet.Cancel;
//                DBEcheance.SetFocus;
//              end;
          End;


          If DBEcheance.DataSource.DataSet.State = dsEdit Then
          Begin
               If Messagedlg('Annuler les modifications de cette échéance ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    DBEcheance.DataSource.DataSet.Cancel;
                    DBEcheance.SetFocus;
               End
               Else
               Begin
                    Abort;
               End
          End;
    end;
end;


procedure TEcheEmprunt.DaEcheanceStateChange(Sender: TObject);
begin
  ChangementEtatGrille(DBEcheance);

  ChangementEtatBouttons(BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer,DBEcheance.DataSource.DataSet);
end;

procedure TEcheEmprunt.RxSBImportClick(Sender: TObject);
begin
//  DBEcheance.DataSource.DataSet.DisableControls;
//  DMImport.Import_Journaux(DBEcheance.DataSource.DataSet,True);
//  ChangementEtatBouttons(BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer,DBEcheance.DataSource.DataSet);
//  DBEcheance.DataSource.DataSet.EnableControls;
end;


procedure TEcheEmprunt.EtatInitial;
Begin
if DMEmprunts.TaEcheanceGestion.recordcount<>0 then
RxLabTitre1.Caption:='Echéancier de l''emprunt n°: '+Infos_TInfosEmprunts(DMRech.TaEmpruntsRech,'id',[DMEmprunts.TaEcheanceGestionId_Emp.AsString]).Code_Emp;

self.Caption:=RxLabTitre1.Caption+' - '+RxLabTitre2.Caption;
//pour gérer la date sur F1
 DBEcheance.DateDeb:=E.DatExoDebut;
 DBEcheance.DateFin:=E.DatExoFin;
 if now > E.DatExoFin then  DBEcheance.DateDef:=E.DatExoFin else DBEcheance.DateDef:=now;

End;
procedure TEcheEmprunt.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TEcheEmprunt.PaGrilleResize(Sender: TObject);
begin
FormateTailleColonne(DBEcheance,40,[4,4,4,4,4,4,4,1,4,4]);
PositionTotaux;
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;


Procedure TEcheEmprunt.PositionTotaux;
Begin
   Panel1.Width:=RenvoiTailleColonne(DBEcheance,[0,1])+10;
   GrDBGrid2.ColWidths[0]:=RenvoiTailleColonne(DBEcheance,[2]);
   GrDBGrid2.ColWidths[1]:=RenvoiTailleColonne(DBEcheance,[3]);
   GrDBGrid2.ColWidths[2]:=RenvoiTailleColonne(DBEcheance,[4]);
   GrDBGrid2.ColWidths[3]:=RenvoiTailleColonne(DBEcheance,[5]);
   GrDBGrid2.ColWidths[4]:=RenvoiTailleColonne(DBEcheance,[6]);
   GrDBGrid2.ColWidths[5]:=RenvoiTailleColonne(DBEcheance,[7]);
End;

procedure TEcheEmprunt.DBEcheanceColExit(Sender: TObject);
var
ExceptLGR:TExceptLGR;
begin
try
  if DBEcheance.DataSource.DataSet.State in [dsinsert,dsedit]then
    Begin
        // Vérification des données utilisateur
        try
         ExceptLGR:=DMEmprunts.CtrlSaisieEcheance(DBEcheance.SelectedField);
        except
         case ExceptLGR.NumErreur of
//            0000:begin //id_Annuite
//                   abort;
//                 End;
            1000:begin//id_Emp
                   abort;
                 end;
  2000,2001,2002:begin//Date
                   abort;
                 end;
            3000:begin//Annuite
                   abort;
                 end;
            4001:begin//Capital
                   //abort;
                 end;
            5000:begin//Interets
                   abort;
                 end;
            6000:begin//Assurances
                   abort;
                 end;
            7000:begin//Frais_Divers
                   abort;
                 end;
            8000:begin//Capital_Restant_du
                   abort;
                 end;
            9000:begin//Rembourse
                   abort;
                 end;
           10000:begin//Annule
                   abort;
                 end;
//11002,11001,
11000:begin//DateRemboursement
                   abort;
                 end;
     12001,12000:begin//Reference
                    application.Messagebox(Pchar('Cette échéance est signalée comme étant remboursée, vous devez indiquer la référence de ce remboursement'),'Erreur de saisie',0);
                 end;
         end;//fin du case
        end;//fin except
    End;//fin si modification
if self.Visible then
  ChangementEtatGrille(DBEcheance);
except
  //DBEcheance.DataSource.dataset.Fields[DBEcheance.SelectedIndex].FocusControl;
  abort;
end;
end;


procedure TEcheEmprunt.Aide1Click(Sender: TObject);
var
Reference:TReference;
keytmp:word;
begin
case DBEcheance.SelectedIndex of
9:Begin//champ reference
    //Remonter une liste de référence valide
     //Rechercher(DBEcheance,DMEmprunts.TaReferenceReglement,['Reference','Libelle','Compte','Journal'],['Référence','Libellé','Compte','Journal'],'',1);
   DMEmprunts.QuReferenceReglement.ParamByName('DateDeb').AsDate:=e.DatExoDebut;
   DMEmprunts.QuReferenceReglement.ParamByName('DateFin').AsDate:=e.DatExoFin;
   DMEmprunts.QuReferenceReglement.ParamByName('J').AsInteger:=4;
   Reference:=AffichReferenceReglement(DMEmprunts.QuReferenceReglement,DMEmprunts.DaReferenceReglement);
   if reference.retour then
     Begin
       if not(DBEcheance.DataSource.State in [dsinsert,dsedit])then
         DBEcheance.DataSource.DataSet.Edit;
       DBEcheance.DataSource.DataSet.Fields[12].AsString:=Reference.Reference;
     End;
  End;
end;//fin du case
aide1.ShortCut:=ShortCut(0,[]);
//
end;

procedure TEcheEmprunt.DBEcheanceColEnter(Sender: TObject);
begin
if self.Visible then
  ChangementEtatGrille(DBEcheance);
end;

procedure TEcheEmprunt.DBEcheanceDblClick(Sender: TObject);
begin
  DBEcheanceColExit(DBEcheance);
end;


Procedure TEcheEmprunt.InitialiseTable_A_Nil;
Begin
  if DMEmprunts<>nil then
  InitDatasetEvent_A_Nil_Sur_Form([DMEmprunts.DaEcheanceGestion]);
    //DMEmprunts.QuCptEmprunts.AfterScroll:=nil;
end;

Function EcheEmpruntAffiche(ParamAfficheEcheEmprunt:TParamAfficheEcheEmprunt):Boolean;
var
ParamDMEmprunts:TParamDMEmprunts;
Begin
 if (EcheEmprunt = nil) then EcheEmprunt:=TEcheEmprunt.Create(Application.MainForm);
 if ((ParamAfficheEcheEmprunt.Quand <> EcheEmprunt.Quand) and (EcheEmprunt.Visible=true)) then
   EcheEmprunt.Close;
 EcheEmprunt.Quand:=ParamAfficheEcheEmprunt.Quand;
 if not empty(ParamAfficheEcheEmprunt.TitreForm) then
   EcheEmprunt.TitreForm:=ParamAfficheEcheEmprunt.TitreForm;
 EcheEmprunt.SousTitreForm:=ParamAfficheEcheEmprunt.SousTitreForm;
 Initialise_ParamDMEmprunts(ParamDMEmprunts);
 ParamDMEmprunts.EcheEmpruntDataStateChange := EcheEmprunt.DaEcheanceStateChange;
 ParamDMEmprunts.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ParamDMEmprunts.Quand := EcheEmprunt.Quand;
 ParamDMEmprunts.QuiAppel:=ParamAfficheEcheEmprunt.QuiAppel;

   case EcheEmprunt.Quand of
      C_Mouvement:Begin
                   InitialiseDMEmprunts(ParamDMEmprunts);
                  End;
   end;

 if ParamAfficheEcheEmprunt.Affiche then
  begin
     //Grille des echeance d'un emprunt
     EcheEmprunt.DBEcheance.DataSource := DMEmprunts.DaEcheanceGestion;
     EcheEmprunt.GrDBGrid2.DataSource  := DMEmprunts.DATotalEcheance;
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(Application.MainForm);

     if ParamAfficheEcheEmprunt.AffichageModal then
       EcheEmprunt.ShowModal
      else
       EcheEmprunt.Show;
  End;
End;


Procedure TEcheEmprunt.GestionInitDM;
var
ParamDMEmprunts:TParamDMEmprunts;
Begin
 Initialise_ParamDMEmprunts(ParamDMEmprunts);
 ParamDMEmprunts.EcheEmpruntDataStateChange := DaEcheanceStateChange;
 ParamDMEmprunts.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ParamDMEmprunts.Quand := Quand;
 ParamDMEmprunts.QuiAppel:=F_EcheEmprunt;
 InitialiseDMEmprunts(ParamDMEmprunts);
 EtatInitial;
End;


Procedure TEcheEmprunt.GereAccesEcran;
begin
     //Grille des comptes d'emprunts utilisés
     DBEcheance.ReadOnly := E.ExerciceCloture;
     DBEcheance.FSauteColReadOnly := not DBEcheance.ReadOnly;

     EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer],not E.ExerciceCloture);
     EnableItemMenu([Insrer1,Modifier1,Supprimer1],not E.ExerciceCloture);

     DMEmprunts.GestionAccesEmprunts;
end;

end.
