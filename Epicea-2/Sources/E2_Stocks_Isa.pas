{-----------------------------------------------------------------------------
 Unit Name: E2_Stocks_Isa
 Author:    Blanc Philippe
 Purpose:
 History:
 Initialisation de la fonction StocksAffiche avec TParamAffichage
 Affiche:Boolean; : D�termine si l'on veut afficher ou non l'�cran de stock
 AffichageModal:Boolean; D�termine si l'on veut afficher ou non l'�cran de stock en modal
 Quand:Integer;   : D�termine si l'on est en Ouverture ou en Cloture, elle
                    affecte la variable Stocks.Quand (remplace l'utilisation de Tag)
 TitreForm:String; : Titre de la form
 SousTitreForm:String; : SousTitre de la form
-----------------------------------------------------------------------------}



unit E2_Stocks_Isa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables, StdCtrls, Mask, DBCtrls, ExtCtrls,
  E2_Librairie_obj,E2_Decl_Records,
  Gr_Librairie_obj,
  Menus,
  LibSQL,
  RXDBCtrl,
  ExRxDBGrid,
  RXCtrls,
  GrDBGrid,
  LibZoneSaisie,
  E2_AssistantClotureDef,
  LibRessourceString,
  E2_Graphes,E2_Cloture_Def, GrGrid,DMRecherche,
  //OleCtrls,
  //ASControls_TLB,
  DMConstantes,LibImport,LibFichRep,
  DMImportation,Editions,shellApi,E2_VisuListeView, jpeg,
  ObjetEdition,
  LibDates,
  FM_INIT_COLOR,
  FM_INIT_EVENT_AFFICH,
  LibGestionParamXML;

type
  TParamAffichageStock = Record
   Affiche:Boolean;
   AffichageModal:Boolean;
   Quand:Integer;
   TitreForm:String;
   SousTitreForm:String;
   end;
//  TStocks = class(TForm)
//  TStocks = class(TT_INIT_COLOR)
  TStocks = class(TT_INIT_EVENT_AFFICH)
    PopupMenu1: TPopupMenu;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    pmMenu1: TMenuItem;
    Insrer1: TMenuItem;
    Modifier1: TMenuItem;
    Supprimer1: TMenuItem;
    PaGrille: TPanel;
    PaBtn: TPanel;
    PaBas: TPanel;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    DBStocks: TGrDBGrid;
    Imprimer1: TMenuItem;
    BtnAnnuler: TButton;
    BtnImprimer: TButton;
    N2: TMenuItem;
    Prcdent1: TMenuItem;
    Suivant1: TMenuItem;
    PaTools: TPanel;
    PaTitre: TPanel;
    RxSpeedButton1: TRxSpeedButton;
    RxSpeedButton2: TRxSpeedButton;
    RxLaMenu: TRxLabel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    TiShowHint: TTimer;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    Button1: TButton;
    PaPTitre: TPanel;
    PaCumul1: TPanel;
    PaTotal: TPanel;
    GrGrid1: TGrGrid;
    RxSBImport: TRxSpeedButton;
    Imprimerstockcourant1: TMenuItem;
    RxMAJ_Balance: TRxSpeedButton;
    Exporter1: TMenuItem;
    procedure Calculatrice1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pmMenu1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AideEnLigne(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure DBStocksColExit(Sender: TObject);
    procedure DBStocksColEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Aide1Click(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure DBStocksKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ChangementEtatGrille(Sender: TObject);
    procedure changementEtatBoutons(Sender: TObject);
    procedure EnregistrementAutomatique;
    procedure FormActivate(Sender: TObject);
    procedure RxSpeedButton2Click(Sender: TObject);
    procedure RxSpeedButton1Click(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PaToolsResize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnImprimerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure Aideenligne1Click(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure RxSBInfoVersionClick(Sender: TObject);
    procedure RxSBGrapheClick(Sender: TObject);
    procedure RxSBInfoVersionMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure RxSBInfoVersionMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TiShowHintTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBStocksDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    Procedure InitialiseTable_A_Nil;
    Procedure PositionTotaux;
    procedure RxSBImportClick(Sender: TObject);
    Procedure GereAccesEcran;
    procedure Imprimerstockcourant1Click(Sender: TObject);
    Procedure GestionInitDM;
    procedure PopupMenu1Popup(Sender: TObject);
    procedure RxMAJ_BalanceClick(Sender: TObject);
    procedure RxMAJ_BalanceMouseEnter(Sender: TObject);
    procedure RxMAJ_BalanceMouseLeave(Sender: TObject);
    procedure RxMAJ_BalanceMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure FormDeactivate(Sender: TObject);
    procedure Exporter1Click(Sender: TObject);
//    Procedure DataSetPiloteDataStateChange(Sender: TObject);
//    Procedure OnDMStateChangeEvent(Sender: TObject);

  private
    { D�clarations priv�es }
//    property OnDMStateChangeEvent;
  public
    { D�clarations publiques }
    TitreForm,SousTitreForm:String;
    Quand:Integer;
  end;

var

  Stocks: TStocks;
  Mark : TBookMark;
  Selection : String;
  CpteTmp: String;
  LastSize:integer;

  Aide : THintWindow;
  C:TPoint;
  rec:TRect;
  IndexShowHint:Integer;
  TabShowHint:array[0..10] of TControl;
  FlagStockCourant:Boolean;
  Function StocksAffiche(ParamAfficheStock:TParamAffichageStock):Boolean;

implementation

Uses
     E2_AideCompte,
     E2_AideAssist,
//     E2_RepriseStockDeb,
//     DMPlanCpt,
     DMStocks,
     DMAide,
     E2_Main,
     E2_Recherche,
//     UQReport,
     DMEcriture,
     DMPlanCpt, LibClassObjetSenders,
     DMCorrection,
     DMExports, ImportDll;

{$R *.DFM}

Function StocksAffiche(ParamAfficheStock:TParamAffichageStock):Boolean;
var
ParamDMStocks:TParamDMStocks;
Begin
 if (Stocks = nil) then Stocks:=TStocks.Create(Application.MainForm);
 if ((ParamAfficheStock.Quand <> stocks.Quand) and (Stocks.Visible=true)) then
   Stocks.Close;
 Stocks.Quand:=ParamAfficheStock.Quand;
 if not empty(ParamAfficheStock.TitreForm) then
   Stocks.TitreForm:=ParamAfficheStock.TitreForm;
 Stocks.SousTitreForm:=ParamAfficheStock.SousTitreForm;

 ParamDMStocks.StocksDataStateChange := Stocks.changementEtatBoutons;
 ParamDMStocks.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ParamDMStocks.Quand := Stocks.Quand;

   case Stocks.Quand of
      C_Ouverture:Begin
                   InitialiseDMStocks(ParamDMStocks);
                  End;

      C_Cloture:Begin
                  if InitialiseDMStocks(ParamDMStocks).ResteStocksOuvertureAReprendre then
                   begin
                    if MessageDlg('Tous vos Stocks d''Ouverture n''ont pas �t� repris !!!'+
                                   RetourChariotDouble+
                                   'Voulez-Vous faire la reprise maintenant ?', mtWarning, [mbYes,mbNo], 0) = mrYes then
                     begin
                      try
                        Main.RepriseStoks1Click(Main.RepriseStoks1);
                      except
                        ParamAfficheStock.Affiche := false;
                        MessageDlg('Une erreur s''est produite lors de la reprise de vos stocks '+#13+#10+'d''ouverture !', mtError, [mbOK], 0);
                      end;
                     end
                    else
                     begin
                      ParamAfficheStock.Affiche := false;
                     end;
//                    Messagedlg('Op�ration impossible !!! Tous vos Stocks d''Ouverture n''ont pas �t� repris !!!',MtWarning,[mbok],0);
                   end;

                End;
   end;

 if ParamAfficheStock.Affiche then
  begin
   Stocks.DBStocks.DataSource := DMStock.DataStock;
//   Stocks.DataSourcePilote := DMStock.DataStock;
//   Stocks.OnDMStateChangeEvent:= Stocks.changementEtatBoutons;
//   Stocks.DataSourcePilote.OnStateChange:= Stocks.OnDMStateChangeEvent;
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(Application.MainForm);

   if ParamAfficheStock.AffichageModal then
     Stocks.ShowModal
    else
     Stocks.Show;
  end;
// GestListForm(Stocks.TitreForm+' - '+Stocks.SousTitreForm,Stoks1);
// AffichageForm(Monofenetrage,Stocks);
End;


//****************************************************************************//
// Proc�dure AideEnLigne.                                                     //
//****************************************************************************//
procedure TStocks.AideEnLigne(Sender: TObject);
var
   aa,result:boolean;
begin
try
result:=false;
//WinShape(ActiveControl,Shape1,shape2,Main.ContourCouleur);
if ((AideAssist <> nil) and (AideAssist.Visible)) then
Result:=DMAides.taAssist.FindKey([self.Name+inttostr(Quand),ActiveControl.Name]);
     if not Result then
        DMAides.taAssist.FindKey(['Vide','Vide']);
except;
end;
end;
//****************************************************************************//


//****************************************************************************//
// Initialisation � la cr�ation de la fen�tre.                                //
//****************************************************************************//
procedure TStocks.FormCreate(Sender: TObject);
begin
inherited;
TypeInitForm:=C_MODELE_COLOREPI;

// if DMStock=nil then
// DMStock:=TDMStock.Create(self);

//if DMStock.EssaiStock = nil then
//     DMStock.EssaiStock := TEssaiStock.CreateNew(self);
// DMStock.EssaiStock.ControleSaisie:=DMStock.CtrlSaisieStock;

// Affectation par code du datasource � la grille sinon il se produit une exception
// DBStocks.DataSource := DMStock.DataStock;
// if AideCompte=nil then
// AideCompte:=TAideCompte.Create(self);
    try
	     LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        InitialiseFormPosDefaut(self);
    end;
 LastSize:=0;
 DBStocks.FSauteColReadOnly:=true;
 FlagStockCourant:=false;
end;
//****************************************************************************//


//****************************************************************************//
// Initialisation � l'affichage de la fen�tre.                                //
//****************************************************************************//
procedure TStocks.FormShow(Sender: TObject);
begin

     // Traitements communs � l'ouverture et � la clot�re des Stocks

     Case Quand Of
          C_Ouverture : begin
               Patitre.Caption:='';
//               Patitre.Color:=$00ADEBFF;
               RxLabTitre.Caption:='Ouverture : Stocks';
               PaPTitre.Caption:='Liste de vos stocks en fin d''exercice pr�c�dent';
               RxSpeedButton2.Visible:=true and (not main.Monofenetrage);
//               Prcdent1.Visible:=true;
//               Prcdent1.Enabled:=true;
               RxSpeedButton1.Hint:='Saisie des Dettes et Cr�ances � l''ouverture.'+HintRaccourciCtrlS;
               RxSpeedButton2.Hint:='Saisie des Emprunts � l''ouverture'+HintRaccourciCtrlP;
               RxSBGraphe.Hint:='Graphiques ...' + HintRaccourciAucun;
               DBStocks.Hint:='Ajoutez, modifiez, supprimez vos stoks � l''ouverture.'+HintRaccourciF1F7;
               BtnAnnuler.Hint:='Annule les modifications du stock en cours.'+ HintRaccourciEsc;
               BtnEnregistrer.Hint:='Enregistre les modifications du stock en cours'+HintRaccourciF3;
               BtnInserer.Hint:='Ajoute un nouveau stock.'+HintRaccourciF6;
               BtnModifier.Hint:='Modifie le stock en cours.'+HintRaccourciF8;
               BtnSupprimer.Hint:='Supprime le stock en cours.'+HintRaccourciF10;
               BtnFermer.Hint:='Ferme la fen�tre en cours.'+HintRaccourciESC;
               BtnImprimer.Hint:='Edition de vos stocks.'+HintRaccourciF11;

               IndexShowHint:=0;

               TabShowHint[0]:=RxSpeedButton2;
               TabShowHint[1]:=RxSpeedButton1;
               TabShowHint[2]:=RxSBGraphe;
               TabShowHint[3]:=DBStocks;
               TabShowHint[4]:=BtnAnnuler;
               TabShowHint[5]:=BtnEnregistrer;
               TabShowHint[6]:=BtnInserer;
               TabShowHint[7]:=BtnModifier;
               TabShowHint[8]:=BtnSupprimer;
               TabShowHint[9]:=BtnFermer;
               TabShowHint[10]:=BtnImprimer;

               //RxSBImport.Visible := ((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'));
              end;
          C_Cloture : begin
               RxLabTitre.Caption:='Cl�ture : Stocks';
               PaPTitre.Caption:='Liste de vos stocks en fin d''exercice courant';
//               Patitre.Color:=$0033CCFF;
//               Prcdent1.Visible:=false;
//               Prcdent1.Enabled:=false;

               RxSpeedButton2.Visible:=false;
               RxSpeedButton1.Hint:='Saisie des Charges � r�partir � la cl�ture.'+HintRaccourciCtrlS;
               RxSBGraphe.Hint:='Graphiques ...' + HintRaccourciAucun;
               DBStocks.Hint:='Ajoutez, modifiez, supprimez vos stoks � la clot�re.'+HintRaccourciF1F7;
               BtnAnnuler.Hint:='Annule les modifications du stock en cours.'+ HintRaccourciEsc;
               BtnEnregistrer.Hint:='Enregistre les modifications du stock en cours'+HintRaccourciF3;
               BtnInserer.Hint:='Ajoute un nouveau stock.'+HintRaccourciF6;
               BtnModifier.Hint:='Modifie le stock en cours.'+HintRaccourciF8;
               BtnSupprimer.Hint:='Supprime le stock en cours.'+HintRaccourciF10;
               BtnFermer.Hint:='Ferme la fen�tre en cours.'+HintRaccourciESC;
               BtnImprimer.Hint:='Edition de vos stocks.'+HintRaccourciF11;

               IndexShowHint:=1;

               TabShowHint[0]:=RxSpeedButton2;
               TabShowHint[1]:=RxSpeedButton1;
               TabShowHint[2]:=RxSBGraphe;
               TabShowHint[3]:=DBStocks;
               TabShowHint[4]:=BtnAnnuler;
               TabShowHint[5]:=BtnEnregistrer;
               TabShowHint[6]:=BtnInserer;
               TabShowHint[7]:=BtnModifier;
               TabShowHint[8]:=BtnSupprimer;
               TabShowHint[9]:=BtnFermer;
               TabShowHint[10]:=BtnImprimer;

               RxSBImport.Visible:=False;
              end;
     End; // Fin du Case

     Mark := Nil;

      // Fin des traitements communs � l'ouverture et � la clot�re des Stocks



//Main.Claude.Show(False); //on affiche Claude
//Main.Claude.MoveTo(self.left,self.top,1000);
//Main.Claude.Play('GestureLeft');
////Main.Claude.Speak('Bonjour, je suis votre aide permanente. Si vous d�sirez me posez une question, appelez moi !','');
//Main.Claude.Speak('Cet �cran vous permet de saisir les stocks que vous constatez � l''ouverture de votre exercice.','');
//Main.Claude.Play('GestureRight');
//Main.Claude.Play('Alert');
//Main.Claude.Speak('En maintenant appuy�e votre souris sur le point d''interrogation, vous aurez une description sur chaque fonction.','');

end;
//****************************************************************************//


//****************************************************************************//
// Permet l'affichage du Menu.                                                //
//****************************************************************************//
procedure TStocks.pmMenu1Click(Sender: TObject);
begin
     PopupMenu1.Popup(Left + 50, Top + 50);
end;

//****************************************************************************//


//****************************************************************************//
// Lib�ration de  m�moire.                                                    //
//****************************************************************************//
//****************************************************************************//
procedure TStocks.FormDestroy(Sender: TObject);
begin
       InitialiseTable_A_Nil;
  	   LibGestionParamXML.DestroyForm(Self,E.USer);
        if DMStock<>nil then
          DMStock.Free;
        Stocks := Nil;
end;


//****************************************************************************//
// Affichage de la calculatrice.                                              //
//****************************************************************************//
procedure TStocks.Calculatrice1Click(Sender: TObject);
begin
if DBStocks.Col in [2,3,4,5] then
  AfficheCalculatrice(DBStocks)
else
  AfficheCalculatrice(nil);
//AideCreaMessage(self.name,ActiveControl.name);
end;
//****************************************************************************//




//****************************************************************************//
// Permet d'ins�rer un nouveau Stock.                                         //
//****************************************************************************//
procedure TStocks.BtnInsererClick(Sender: TObject);
begin
  TableAjoute(DBStocks.DataSource.DataSet);
end;
//****************************************************************************//


//****************************************************************************//
// Permet de quitter la fen�tre des Stocks et fermer la table des stocks.     //
//****************************************************************************//
procedure TStocks.BtnFermerClick(Sender: TObject);
begin
     Self.Close;
end;

//****************************************************************************//
// Permet de se placer en modification sur le compte courant.                 //
//****************************************************************************//
procedure TStocks.BtnModifierClick(Sender: TObject);
begin
DMStock.TaStock.Edit;
end;
//****************************************************************************//




//****************************************************************************//
// Gestion du click sur le bouton Enregistrer.                                //
//****************************************************************************//
procedure TStocks.BtnEnregistrerClick(Sender: TObject);
begin
  try
     EnregistrementAutomatique;
  except
  abort;
  end;//fin du try
end;
//****************************************************************************//





//****************************************************************************//
// Permet de contr�ler la saisie de l'utilisateur dans les diff�rentes        //
// colonnes de la grille.                                                     //
//****************************************************************************//
procedure TStocks.DBStocksColExit(Sender: TObject);
var
ControlSaisie:TErreurSaisie;
begin
      if DBStocks.DataSource.State in [dsinsert,dsEdit] then
      begin// si table en insertion ou modif
//      DMStock.EssaiStock.ControleSaisie(DBStocks.SelectedField,1);
//
      ControlSaisie:=DMStock.CtrlSaisieStock(DBStocks.SelectedField,1);
//if not DMStock.EssaiStock.ResultControleSaisie then
//begin
//case DMStock.EssaiStock.CodeResultControleSaisie of
        if  ControlSaisie.Retour=false then
        begin
          case  ControlSaisie.CodeErreur of
          1001:  Begin//si
                   DBStocks.DataSource.DataSet.Fields[1].FocusControl;//isa 5-11-02
                   abort;
                 End;//fin si
          end;//fin du case
        end
        else
        begin
         if DBStocks.DataSource <> nil then
          if DBStocks.DataSource.DataSet.State in [dsEdit,dsInsert] then
             if DBStocks.SelectedIndex = 0 then
             begin
              DMPlan.GestionCompteEnCoursDeSaisie(DBStocks.SelectedField.AsString,DMStock,true);
             end;

        end;
     if DBStocks.SelectedIndex=0 then
        begin
        BtnEnregistrer.Enabled:=true;
        Enregister1.Enabled:=true;
        end;

      end;//fin si table en insertion ou modif
end;
//****************************************************************************//


//****************************************************************************//
// Permet de g�rer le changement de colonne.                                  //
//****************************************************************************//
procedure TStocks.DBStocksColEnter(Sender: TObject);
begin
try
  DMStock.DernierChampSaisi:=DBStocks.SelectedField.Index;
  if DBStocks.DataSource <> nil then
   if DBStocks.DataSource.DataSet.State in [dsEdit,dsInsert] then
      if DBStocks.SelectedIndex = 0 then
      begin
       DMPlan.GestionCompteEnCoursDeSaisie(DBStocks.SelectedField.AsString,DMStock,false);
      end;
except

end;
end;
//****************************************************************************//



//****************************************************************************//
// Gestion des touches alphanum�riques.                                       //
//****************************************************************************//
procedure TStocks.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
FlagStockCourant:=(ssCtrl in Shift);
WinSuivPrec(Handle,key,[DBStocks,DBStocks.InplaceEditor]);
     If Key = VK_ESCAPE Then
     Begin

       If DMStock.TaStock.State = dsBrowse Then
          begin
            if DBStocks.Focused then Self.Close else DBStocks.SetFocus;
          end;

      If DMStock.TaStock.State = dsInsert Then
          Begin
               If Messagedlg('Annuler la cr�ation de ce stock ?',MtConfirmation,[mbno,mbyes],0) = mryes Then
               Begin
                    DMStock.TaStock.Cancel;
                    Abort;
               End
               Else
               Begin
                    Abort;
               End;
          End;


          If DMStock.TaStock.State = dsEdit Then
          Begin
               If Messagedlg('Annuler les modifications de ce stock ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    DMStock.TaStock.Cancel;
                    Abort;
               End
               Else
               Begin
                    Abort;
               End
          End;
     End;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click dans l'aide.                                              //
//****************************************************************************//
procedure TStocks.Aide1Click(Sender: TObject);
begin
 If activecontrol = DBStocks Then
  begin
   case DBStocks.DataSource.State of
      dsinsert,dsedit:case DBStocks.SelectedIndex of
                         0:begin
                           DMStock.GestionFiltrageParamCpt;
                           DBStocks.EditorMode:=true;
                           //AideCompteDansContexte(CCourant.AsString,ccourant,['Rac1'],false,MessDerSub,true,true,false,true,0)
                           AideCompteAffiche(DBStocks.InplaceEditor,True,False,True,True,0);
                           DBStocks.Columns[0].Field.AsString:=DBStocks.InplaceEditor.Text;
                           end;
                         2: ;
                      end;
      dsbrowse:case DBStocks.SelectedIndex of
                  0:Rechercher(DBStocks,DMStock.TaStock,['Compte','Designation','Actif','Date_Saisie'],['Compte','D�signation','Actif','Date Saisie'],'',0);
                  1:Rechercher(DBStocks,DMStock.TaStock,['Designation','Compte','Actif','Date_Saisie'],['D�signation','Compte','Actif','Date Saisie'],'',0);
               end;
   end;
 end;
end;
//****************************************************************************//


//****************************************************************************//
// Permet de supprimer le stock s�lectionn� par l'utilisateur.                //
//****************************************************************************//
procedure TStocks.BtnSupprimerClick(Sender: TObject);
begin
   try
   TableGereDelete(DMStock.TaStock);
   except
      begin
      abort;
      end;
   end;
end;

//Procedure TStocks.DataSetPiloteDataStateChange(Sender: TObject);
//Begin
//inherited ;
////
//End;

//Procedure TStocks.OnDMStateChangeEvent(Sender: TObject);
//Begin
//inherited ;
////
//End;

//****************************************************************************//
procedure TStocks.changementEtatBoutons(Sender: TObject);
begin
  case DMStock.TaStock.state of
   dsBrowse: begin
               BtnInserer.Enabled := True;
               BtnEnregistrer.Enabled := False;
               BtnModifier.Enabled := Not(DMStock.TaStock.RecordCount = 0);
               BtnSupprimer.Enabled := Not(DMStock.TaStock.RecordCount = 0);
               BtnImprimer.Enabled:=true;
               FiltrageDataSet(DMRech.TaStockRech,DBStocks.DataSource.DataSet.Filter);
               GrGrid1.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',SommeTotauxGeneric(['MontantTotalHT'],DMRech.TaStockRech).Total1);
               DeFiltrageDataSet(DMRech.TaStockRech);
//               GestMessageLGR.Enregistrement :=False;
//               ComboCompte.Enabled := True;
             end;

   dsEdit:   begin
//               GestMessageLGR.Enregistrement :=true;
               EnableWinControl([BtnAnnuler,BtnEnregistrer,BtnFermer],True);
               EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer,BtnImprimer],False);
//               ComboCompte.Enabled := False;
             end;

   dsInsert: begin
//               GestMessageLGR.Enregistrement :=true;
               EnableWinControl([BtnAnnuler,BtnFermer],True);
               EnableWinControl([BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnImprimer],False);

//               ComboCompte.Enabled := False;
             end;
   end;//fin du case.state
   //Pop-up Menu
   Fermer1.Enabled:=BtnFermer.Enabled;
   Insrer1.Enabled:=BtnInserer.Enabled;
   Enregister1.Enabled:=BtnEnregistrer.Enabled;
   Modifier1.Enabled:=BtnModifier.Enabled;
   Supprimer1.Enabled:=BtnSupprimer.Enabled;
   Imprimer1.Enabled:=BtnImprimer.Enabled;

if Stocks.canfocus then  Stocks.ChangementEtatGrille(DMStock.TaStock);
end;


procedure TStocks.ChangementEtatGrille(Sender: TObject);
begin
 Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DMStock.TaStock)+NBRecord_Str(DMStock.DataStock.DataSet);
   case DMStock.TaStock.state of
   dsBrowse: begin
               DBStocks.Options := [dgediting,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               DBStocks.SetFocus;
               if DBStocks.InplaceEditor <> nil then
                  DBStocks.EditorMode:=false;
               DBStocks.TitreColor(true);
             end;

   dsEdit:   begin
               DBStocks.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               DBStocks.SetFocus;
               DBStocks.TitreColor(true);
             end;

   dsInsert: begin
               DBStocks.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               DBStocks.SetFocus;
               DBStocks.TitreColor(true);
             end;
   end;//fin du case.state
end;


procedure TStocks.EnregistrementAutomatique;
begin
  try
  TableGerePost(DMStock.TaStock);
  except
  abort;
  end;//fin du try
end;




//****************************************************************************//
// Gestion des touches dans la grille.                                        //
//****************************************************************************//
procedure TStocks.DBStocksKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if DMStock.DataStock.State in [dsBrowse] then
 if not DBStocks.ReadOnly then
    if ((key=VK_INSERT) and (Shift=[ssCtrl])) then BtnInserer.Click;
if ((key=VK_INSERT) and (Shift=[])) then key:=0; 
end;
//****************************************************************************//

procedure TStocks.FormActivate(Sender: TObject);
begin
  case self.Quand of
     C_Ouverture:Begin
                  ColorPaTitre:=$00EAFAFF;
                 End;

     C_Cloture:Begin
                  ColorPaTitre:=$0070DBFF;
               End;
  end;

inherited;
GestionInitDM;
initialisationMAJ_Balance(RxMAJ_Balance);
 Initialiser_ShortCut_Main(true);
// if DMStock=nil then
// DMStock:=TDMStock.Create(self);

 if AideCompte=nil then
 AideCompte:=TAideCompte.Create(self);

DeFiltrageDataSet(DMRech.TaStockRech);
AideCompte.ListeCompteUtiliseEcranAppelant:=ChampTableVersListe('Compte',DMRech.TaStockRech);

 DBStocks.ParamColor:=true;
 DBStocks.Param:=ParamUtil.CouleurDBGrid;
 DBStocks.UpDateColor;
 Patitre.visible:=ParamUtil.AfficheTitre;
// CouleurFond([PaTools,PaBas],ParamUtil.CouleurPanelCorps);
// CouleurFond([PaTools,PaBtn,PaBas],ParamUtil.CouleurPanelCorps);

  GrGrid1.ParamColor:=true;
  GrGrid1.Param:=ParamUtil.CouleurDBGrid;
  GrGrid1.DessineContourLigne:=false;
  GrGrid1.UpDateColor;
  GrGrid1.FixedColor:=ParamUtil.CouleurDBGrid.GrilleColorFond;

// DMPlan.TaCompte.OnFilterRecord:=nil;
if Patitre.visible then
 begin
  VisibleItemMenu([N2,Prcdent1,Suivant1],true);
  EnableItemMenu([Prcdent1,Suivant1],true);
 end
 else
 begin
  VisibleItemMenu([N2,Prcdent1,Suivant1],False);
  EnableItemMenu([Prcdent1,Suivant1],False);
 end;

case DMStock.DataStock.State of
  dsBrowse:Begin
//            DMStock.Tag:=self.Tag;
//            case Quand of
//                C_Ouverture : FiltrageDataSet(DBStocks.DataSource.DataSet,CreeFiltreET(['Actif','Date_Saisie'],['true',datetostr(E.DatExoDebut-1)]));
//                C_Cloture : FiltrageDataSet(DBStocks.DataSource.DataSet,CreeFiltreET(['Actif','Date_Saisie'],['true',datetostr(E.DatExoFin)]));
//            end;//fin du case
//            DMStock.DataStock.OnStateChange:=changementEtatBoutons;
            DMStock.DataStock.OnStateChange(DMStock.TaStock);
           End;
  dsInsert,dsEdit:Begin

                  End;

end;
GereAccesEcran;
end;

procedure TStocks.RxSpeedButton2Click(Sender: TObject);
begin
Main.Emprunts1Click(Main.Emprunts1);
end;

procedure TStocks.RxSpeedButton1Click(Sender: TObject);
begin
 Case Quand Of
      C_Ouverture : begin
           Main.SaisieAnneeAnterieurClick(Main.SaisieAnneeAnterieur);
//           Main.Chargesrpartir1Click(Main.Chargesrpartir1);
          end;
      C_Cloture : begin
            Main.Chargesetproduitsconstatsdavance2Click(Main.Chargesetproduitsconstatsdavance2);
          end;
 End; // Fin du Case
end;

procedure TStocks.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TStocks.PaGrilleResize(Sender: TObject);
begin
FormateTailleColonne(DBStocks,16,[2,4,1,2,2,2]);
PositionTotaux;
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TStocks.FormResize(Sender: TObject);
begin
if self.Width < 450 then
     if LastSize > self.Width
       then
           begin
          LastSize:=self.Width;
           abort;
           end;
LastSize:=self.Width;
end;

procedure TStocks.PaToolsResize(Sender: TObject);
begin
//RxSpeedButton1.top:=12;
RxSpeedButton1.Left:=Patitre.Width-104;
//RxSpeedButton1.Height:=Patitre.Height-24;
RxLaMenu.top:=53;
RxLaMenu.left:=Patitre.Width-102;
//Patitre.Font.Size:=(Patitre.Width div 40)-1;
end;

procedure TStocks.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
try
canclose:=true;
if DMStock <> nil then
 begin
  // Si l'utilisateur est en mode Insertion
     If DMStock.TaStock.State = dsInsert Then
     Begin
          self.WindowState:=wsNormal;
          self.BringToFront;
          If BtnEnregistrer.Enabled Then
          Begin
               If Messagedlg('Voulez-vous enregistrer le nouveau stock ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                 begin
//                   self.BringToFront;
                   EnregistrementAutomatique;
                  end
                  else
                   begin
//                   DMStock.TaStock.BeforeCancel:=nil;
                   DMStock.TaStock.Cancel;
//                   DMStock.TaStock.BeforeCancel:=DMStock.TaStockBeforeCancel;
                   end;
          End
          Else
          Begin
               If Messagedlg('Voulez-vous annuler la cr�ation de ce stock ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                begin
//                   DMStock.TaStock.BeforeCancel:=nil;
                   DMStock.TaStock.Cancel;
//                   DMStock.TaStock.BeforeCancel:=DMStock.TaStockBeforeCancel;
                end
               Else
                 begin
                  canclose:=false;
//                  self.BringToFront;
                  end;
          End;
     End; // Fin utilisateur est en mode Insertion

     // Si l'utilisateur est en mode Modification
     If dMStock.TaStock.State = dsEdit Then
     Begin
       self.WindowState:=wsNormal;
       self.BringToFront;
          If Messagedlg('Voulez-vous enregistrer les modifications de ce stock ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
           begin
            EnregistrementAutomatique;
             end
             else
             begin
//              DMStock.TaStock.BeforeCancel:=nil;
              DMStock.TaStock.Cancel;
//              DMStock.TaStock.BeforeCancel:=DMStock.TaStockBeforeCancel;
             end;
     End; // Fin utilisateur est en mode Modification

     // Si l'utilisateur est en train de cl�turer ses stocks
     If Quand = C_Cloture Then
      begin
       if DMStock.FiltragePourAffichageOD(e.DatExoFin)=true then
       begin
           try
           DMStock.CreationODStockCloture;
           except
             begin
             showmessage('Probl�me � la cr�ation des OD ');
             abort;
             end;
           end;
          DMStock.DemandeAffichageReprise(e.DatExoFin,'OD des Stocks de Cl�ture');
          Quand:=-1; // initialisation du tag sinon plusieurs passage
        end;
     end;
  end;
AssistantClotRafraichit(1);
  try
//    if ((Cloture_Def<>nil)and(ActivationForm(Cloture_Def))) then // PB
//      begin
//          Cloture_Def.EtapeSuivante:=0;
//      end;
  except
    //
  end;
except
  canclose:=false;
end;
if CanClose then
 begin
//   case DMStock.DataStock.State of
//     dsBrowse:Begin
//               DMStock.DataStock.OnStateChange:=nil;
//              End;
//     dsInsert,dsEdit:Begin
//
//                     End;
//   end;
//  DBStocks.DataSource.DataSet.AfterScroll:=nil;
  InitialiseTable_A_Nil; { isa  le  29/01/04 }
 end
 else
 begin
    if DMStock=nil then
   DMStock:=TDMStock.Create(self);

   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(self);

 end;
end;

procedure TStocks.BtnImprimerClick(Sender: TObject);
var
Site:TEditLien;
//ObjPrn:TObjetEdition;
ListeValeur:TStringList;
i:integer;
begin
case Quand of
   C_Ouverture:begin
               case E.Type_Edition of
                   C_IMP_MOZiLLA_LOCAL:Begin
                         EditionStock(C_EditionSimple,C_Ouverture,DMStock.TaStock,nil,Site);

                                       End;

                   C_IMP_NORMAL:Begin
                                 if FlagStockCourant then
                                 EditionStockL(C_EditionSimple,C_Ouverture,nil,DMStock.TaStock.FindField('Compte').AsString)
                                 else
                                 EditionStockL(C_EditionSimple,C_Ouverture,nil,nil);
                                 FlagStockCourant:=False;
                                End;

                   C_IMP_MOZiLLA_WEB:Begin

                                     End;

                   else showmessage('Type_Edition non d�fini');
                 end;
             end;
   C_Cloture:begin
                case E.Type_Edition of
                   C_IMP_MOZiLLA_LOCAL:Begin
      //                   EditionStock(C_EditionSimple,C_Ouverture,DMStock.TaStock,nil);
                         //EditionStock(C_EditionSimple,C_Cloture,DMStock.TaStock,nil,site);
                                       End;

                   C_IMP_NORMAL:Begin
                                 if FlagStockCourant then
                                 EditionStockL(C_EditionSimple,C_Cloture,nil,DMStock.TaStock.FindField('Compte').AsString)
                                 else
                                 EditionStockL(C_EditionSimple,C_Cloture,nil,nil);
                                 FlagStockCourant:=False;
                                End;

                   C_IMP_MOZiLLA_WEB:Begin

                                     End;

                   else showmessage('Type_Edition non d�fini');
                   end;
              end;
//
end;
end;

procedure TStocks.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TStocks.Aideenligne1Click(Sender: TObject);
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

procedure TStocks.Visualisation1Click(Sender: TObject);
begin
if DBStocks.SelectedIndex = 0 then
 begin
  if DBStocks.InplaceEditor <> nil then
   begin
      if DBStocks.InplaceEditor.Visible then
        DetailEcritureCompte(DBStocks.InplaceEditor.Text,true,False)
         else
         DetailEcritureCompte(DMStock.TaStock.FindField('Compte').AsString,true,False);
   end
   else
    DetailEcritureCompte(DMStock.TaStock.FindField('Compte').AsString,true,False);
 end
  else DetailEcritureCompte(DMStock.TaStock.FindField('Compte').AsString,true,False);

end;

procedure TStocks.RxSBInfoVersionClick(Sender: TObject);
begin
Showmessage(StocksRxSBInfoVersionWarning+numVersion.messageVersion);
end;

procedure TStocks.RxSBGrapheClick(Sender: TObject);
begin
case Quand of
   C_Ouverture:AfficheGraphe(DMStock.TaStock,'ID','Compte','MontantTotalHT','Les Stocks � l''ouverture');
   C_Cloture:AfficheGraphe(DMStock.TaStock,'ID','Compte','MontantTotalHT','Les Stocks � la cl�ture');
end;
end;

procedure TStocks.RxSBInfoVersionMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
TiShowHint.Enabled:=true;
TiShowHintTimer(TiShowHint);
end;

procedure TStocks.RxSBInfoVersionMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
if Button = mbLeft then
begin
  TiShowHint.Enabled:=false;
  Aide.ReleaseHandle;
end;
end;

procedure TStocks.TiShowHintTimer(Sender: TObject);
begin
if aide = nil then
 Aide:=THintWindow.Create(self);
 Aide.Canvas.Brush.Color:=clInfoBk;
 Aide.Color:=clInfoBk;
 C:=TabShowHint[IndexShowHint].ClientOrigin;
 Rec:=Aide.CalcHintRect(length(TabShowHint[IndexShowHint].hint)*5,RxSpeedButton1.hint,@(TabShowHint[IndexShowHint].hint));
 rec.Left:=C.x+20;
 Rec.Top:=C.y+20;
 Rec.Right:=Rec.Right + C.x+20;
 Rec.Bottom:=Rec.Bottom + C.y+20;
 Aide.ActivateHint(Rec,TabShowHint[IndexShowHint].hint);
 inc(IndexShowHint);
 if IndexShowHint > 10 then
 if Quand = c_ouverture then
    IndexShowHint:=0
    else IndexShowHint:=1;


end;

procedure TStocks.Button1Click(Sender: TObject);
var
 i:integer;
 Liste:TList;
 Compte,Designation:String;
 ParamAffichage:TParamAffichage;
 List1:TStringList;
 RetourViewListe:TRetourViewListe;
begin
  List1:=TStringList.Create;
  List1:=ChampTableVersListeEx(['Compte','Designation','Qte','Prix_Unitaire','Decote','MontantTotalHT'],DMStock.TaStock,';',true);
  ReEnableControls(DMStock.TaStock);
  Initialise_TParamAffichage(ParamAffichage);
  ParamAffichage.AffichModal := true;
  ParamAffichage.Titre:=self.Caption;
  ParamAffichage.GestionAffichForm.Caption := self.Caption;
  //Compte:=
  RetourViewListe:=AfficheVisuListView(ParamAffichage,['Compte','D�signation','Qt�','Prix Unitaire','D�cote','Montant Total HT'],
                                     [200,250,40,150,40,150],
                                     [List1],
                                     [taLeftJustify,taLeftJustify,taRightJustify,taRightJustify,taRightJustify,taRightJustify],
                                     [1..2],
                                     [3..6],[0]);
                                     //ItemCourantValeurRow
  if RetourViewListe.Retour then
   List1:=RetourViewListe.VisuListeView.ItemCourantValeurRow
   else showmessage('FAlse');
   if List1.Count > 0 then
  ShowMessage(List1.Strings[0]+' - '+List1.Strings[1]);
  Compte:=RetourViewListe.VisuListeView.ItemCourantValeurCol(1);
  ShowMessage(Compte);
  List1.Free;
//  MessageSilencieux('Messagerie Epic�a-2','Bienvenue dans Epic�a-2',Main.PaMessageSilencieux,0,self.Width,self.Left,80,self);

//for i:=0 to 5 do
// begin
//ImportTable([0,'3011','',1.00,100.00,0,0],DMStock.TaStock);
////   DMStock.ImportStocks([0,'3011','',0,i+100.0,0,0],DMStock.TaStock);
//   caption:=IntToStr(i);
// end;

//Liste:=TList.Create;
//if FileExistDialog(E.RepertoireImportEPI_DOS+'E3-CDIV.TXT',true) then
// begin
//   ImportationStockEPI_D(E.RepertoireImportEPI_DOS+'E3-CDIV.TXT',Liste);
//   for i:=0 to Liste.Count-1 do
//    begin
//    Compte:=PImport_Stock(Liste.Items[i])^.Compte;
//    Designation:=PImport_Stock(Liste.Items[i])^.Designation;
//   //  ShowMessage(PImport_Sotck(Liste.Items[i])^.Compte+'|'+PImport_Sotck(Liste.Items[i])^.Designation
//   //                        +'|'+CurrToStr(PImport_Sotck(Liste.Items[i])^.Qte)+'|'+CurrToStr(PImport_Sotck(Liste.Items[i])^.PrixUnitaire)+'|'+
//   //                        IntToStr(PImport_Sotck(Liste.Items[i])^.Decote)+'|'+CurrToStr(PImport_Sotck(Liste.Items[i])^.PrixTHT));
//     DMStock.ImportStocks([0,Compte,Designation
//                           ,PImport_Stock(Liste.Items[i])^.Qte,PImport_Stock(Liste.Items[i])^.PrixUnitaire,
//                           PImport_Stock(Liste.Items[i])^.Decote,0],DMStock.TaStock);
//   //                        PImport_Sotck(Liste.Items[i])^.Decote,PImport_Sotck(Liste.Items[i])^.PrixTHT],DMStock.TaStock);
//    end;
// end;
//Liste.Free;
end;

procedure TStocks.DBStocksDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
HoldColor:TColor;
begin
//if Column.Field.DataSet.State = dsInsert
//then
// Column.Title.Font.Style:=[fsBold,fsItalic];
//Field.DataSet.RecNo = (Column.Field.DataSet.RecordCount-1) then
//begin
////if DMPlan.ListeCptOkBO.IndexOf(Column.Field.DataSet.Fields[0].AsString)<>-1 then
////if ((Column.FieldName = 'Debit_Deb') or (Column.FieldName = 'Credit_Deb')) then
////    begin
//      holdColor:=DBStocks.Canvas.Brush.Color;
//      DBStocks.Canvas.Brush.Color :=clBlack;//$005959FF;//$00808040;
//      DBStocks.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//      DBStocks.Canvas.Brush.Color := holdColor;
////    end;

//end;
//DBStocks.SelectedIndex
end;

Procedure TStocks.InitialiseTable_A_Nil;
Begin
if DMStock <>nil then
  InitDatasetEvent_A_Nil_Sur_Form([DMStock.DataStock,DMStock.TaStock]);
End;

Procedure TStocks.PositionTotaux;
Begin
   PaTotal.Width:=RenvoiTailleColonne(DBStocks,[0,1,2,3,4,5])+10;
   GrGrid1.ColWidths[0]:=RenvoiTailleColonne(DBStocks,[6]);
End;

procedure TStocks.RxSBImportClick(Sender: TObject);
begin
  DMStock.TaStock.DisableControls;
  DMImport.Import_Stocks(DMStock.TaStock,True);
  changementEtatBoutons(DMStock.TaStock);
  DMStock.TaStock.EnableControls;
end;

Procedure TStocks.GereAccesEcran;
begin
  case Quand of
     C_Ouverture:Begin
                  DBStocks.ReadOnly := not E.AccesOuverture;
                  DBStocks.FSauteColReadOnly := not DBStocks.ReadOnly;
                  EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer],E.AccesOuverture);
                  EnableItemMenu([Insrer1,Modifier1,Supprimer1],E.AccesOuverture);
                 End;

     C_Cloture:Begin
                  DBStocks.ReadOnly := not E.AccesCloture;
                  DBStocks.FSauteColReadOnly := not DBStocks.ReadOnly;
                  EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer],E.AccesCloture);
                  EnableItemMenu([Insrer1,Modifier1,Supprimer1],E.AccesCloture);
               End;
  end;
DMStock.GestionAccesStocks;
end;
procedure TStocks.Imprimerstockcourant1Click(Sender: TObject);
begin
FlagStockCourant:=true;
BtnImprimer.Click;
end;

Procedure TStocks.GestionInitDM;
var
ParamDMStocks:TParamDMStocks;
Begin
 ParamDMStocks.StocksDataStateChange := changementEtatBoutons;
 ParamDMStocks.Quand := Quand;
 ParamDMStocks.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 InitialiseDMStocks(ParamDMStocks);
End;

procedure TStocks.PopupMenu1Popup(Sender: TObject);
begin
Imprimerstockcourant1.Caption := 'Imprimer le compte : '+ DBStocks.DataSource.DataSet.findField('Compte').AsString;
end;

procedure TStocks.RxMAJ_BalanceClick(Sender: TObject);
begin
Activation_Desactivation_MAJ_Balance;
initialisationMAJ_Balance(RxMAJ_Balance);
end;

procedure TStocks.RxMAJ_BalanceMouseEnter(Sender: TObject);
begin
(Sender as TRxSpeedButton).Font.Color:=clREd;
(Sender as TRxSpeedButton).Font.Style:=[fsBold];
end;

procedure TStocks.RxMAJ_BalanceMouseLeave(Sender: TObject);
begin
(Sender as TRxSpeedButton).Font.Color:=clWindowText;
(Sender as TRxSpeedButton).Font.Style:=[];
end;

procedure TStocks.RxMAJ_BalanceMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
initialisationMAJ_Balance(RxMAJ_Balance);
end;

procedure TStocks.FormDeactivate(Sender: TObject);
begin
e.TypeMAJBalance:=MAJ_Normal;
initialisationMAJ_Balance(RxMAJ_Balance);
end;

procedure TStocks.Exporter1Click(Sender: TObject);
begin
  inherited;
ExportDonnees(DBStocks.DataSource.DataSet,E.RepertoireExportDossier,'Stocks_'+E.NomDossier + E.NomExo + '.Txt');
end;

end.