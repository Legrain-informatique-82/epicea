{***************************************************************
 *
 * Unit Name: E2_AideTva
 * Purpose  :
 * Author   :  JS
 * History  :
 *
 ****************************************************************}

// Aide le choix des codes  TVA
// Tout est commenté
unit E2_AideTva;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Gr_Librairie_Obj, Buttons, Db, DBTables,
  ExtCtrls, Grids, DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid,LibSQL,LibZoneSaisie,
  RXCtrls,LibRessourceString,E2_Decl_Records,DMConstantes, LibGestionParamXML, jpeg;

type
  TAideTva = class(TForm)
    PaGrille: TPanel;
    grTva: TGrDBGrid;
    Patitre: TPanel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    PaBas: TPanel;
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
    Panel2: TPanel;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    RxSBImport: TRxSpeedButton;
    Exporter1: TMenuItem;
    procedure Calculatrice1Click(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);
    procedure rbClick(Sender: TObject);
    procedure grTvaTitleClick(Column: TColumn);
    procedure grTvaDblClick(Sender: TObject);
    procedure grTvaKeyPress(Sender: TObject; var Key: Char);
    procedure pmMenu1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure AideEnLigne(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure grTvaColExit(Sender: TObject);
    Procedure DataTvaCodeStateChange(sender:TObject);
    procedure changementEtatBoutons(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure RxSBInfoVersionClick(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure RxSBImportClick(Sender: TObject);
    procedure Exporter1Click(Sender: TObject);
  private
    { Déclarations privées }
    FRecherche :String;
    FCompte :String;
  public
    { Déclarations publiques }
    TitreForm,SousTitreForm:String;
  end;

var
  AideTva: TAideTva;
  Function AideTvaAfficheTous(Control :Tcomponent):Boolean;
  Function AideTvaAffiche(Control :Tcomponent; Compte :String) :Boolean;
  Function AideTvaExiste(TvaCode :String; Compte :String; Control :TWinControl) :Boolean;
  Function AideTvaCodeValide(TvaCode :String; Compte :String) :Boolean;
  Function AideTvaTypeValide(TvaCode :String; TvaType :String) :Boolean;
  Function AideTvaTauxValide(TvaCode,Compte :String; TvaTaux :Currency) :Boolean;
  Function AideTvaField(Champ :String) :TField;
  Function AideTvaTvaType(TvaCode :String):boolean;

implementation
{$R *.DFM}
Uses E2_Librairie_obj, DMTVA, E2_Main, E2_AideAssist, DMAide,
  DMPlanCpt,DMEcriture, DMImportation,DMExports, ImportDll;
//  E2_ObjetParam,
//****************************************************************************//
// Procédure AideEnLigne.                                                     //
//****************************************************************************//
procedure TAideTva.AideEnLigne(Sender: TObject);
var
   result:boolean;
begin
try
if ((AideAssist <> nil) and (AideAssist.Visible)) then
Result:=DMAides.taAssist.FindKey([self.Name+inttostr(self.tag),ActiveControl.Name]);
     if not Result then
        DMAides.taAssist.FindKey(['Vide','Vide']);
except
end;
end;
//****************************************************************************//
//******************************************************************************
procedure TAideTva.Calculatrice1Click(Sender: TObject);
// Affichage de la calculatrice sur F12
begin
	AfficheCalculatrice(nil);
end;

//******************************************************************************
procedure TAideTva.Fermer1Click(Sender: TObject);
// Fermeture de l'écran
begin
	Self.Close;
end;

//******************************************************************************
procedure TAideTva.FormCreate(Sender: TObject);
// Création de l'écran et ouverture de la table
begin
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
        InitialiseFormPosDefaut(self);
    end;
   if DMPlan = nil then
      DMPlan:=TDMPlan.Create(application.MainForm);
   if DMTVACode = nil then DMTVACode:=TDMTVACode.Create(application.MainForm);
end;

//******************************************************************************
Procedure TAideTva.InitialiseTable_A_Nil;
Begin
if DMTVACode<>nil then
 DMTVACode.DataTvaCode.OnStateChange:=nil;
// InitDatasetEvent_A_Nil_Sur_Form([DMTVACode.DataTvaCode]);
End;

procedure TAideTva.FormDestroy(Sender:TObject);
// Destruction de l'écran et fermeture de la table
begin
 InitialiseTable_A_Nil;
 LibGestionParamXML.DestroyForm(Self,E.USer);
 AideTVa:=nil;
end;

//******************************************************************************
Function AideTvaAffiche(Control :Tcomponent; Compte :String):Boolean;
// Affiche la liste des codes TVA dans l'écran d'aide
// Retourne vrai si le code TVA est valide pour le compte en cours
// Mise à jour du contrôle d'appel
var
TvaCodePourCpt:TTvaCodePourCompte;
Begin
	if (AideTva = Nil) then
   	AideTva:= TAideTva.Create(Application.MainForm);
        AideTva.Tag:=2;
        AideTva.FCompte:= Compte;
        TvaCodePourCpt:=DMPlan.TvaCodePourCompte(31,E.Regime,Compte);
        if TvaCodePourCpt.Retour then
          begin
           DMTVACode.TaTvaCode.Filter:=CreeFiltreOU('Classe',[TvaCodePourCpt.ListeClasse]);
           DMTVACode.TaTvaCode.Filtered:=true;
           DMTVACode.TaTvaCode.Open;
          end;

      if (Control <> Nil) then Begin
        case RecupClassTypeComponent(control)of
        GTEdit:AideTva.FRecherche:=TCustomEdit(Control).Text;
        GTStringGrid: with TStringGrid(Control) do AideTva.FRecherche:=Cells[Col, Row];
        GTGrid: with TStringGrid(Control) do AideTva.FRecherche:=Cells[Col, Row];
        GTDBGrid:     begin
                      if TCustomdbgrid(control).SelectedField.DataSet.State in [dsedit,dsinsert] then
                      AideTva.FRecherche:=TCustomdbgrid(control).selectedfield.asstring;
                      end;
        GTFieldString:begin
                      if TField(control).DataSet.State in [dsedit,dsinsert] then
                      AideTva.FRecherche:=TField(control).asstring;
                      end;
        end;//fin du case
      end;
      DMTVACode.TaTvaCode.Locate('TvaCode',AideTva.FRecherche,[loPartialKey]);
      AideTva.ActiveControl:= AideTva.grTva;
      AideTva.TitreForm:='Code TVA';
      AideTva.SousTitreForm:=CAide;

      Result:= (AideTva.ShowModal = mrOk);
      AideTva.FRecherche:=DMTVACode.TaTvaCode.findfield('TvaCode').AsString;
      if result and (control <> nil) then
         begin
          case RecupClassTypeComponent(control)of
          GTEdit:TCustomEdit(Control).Text:=AideTva.FRecherche;
          GTStringGrid: with TStringGrid(Control) do Cells[Col, Row]:=AideTva.FRecherche;
          GTGrid: with TStringGrid(Control) do Cells[Col, Row]:=AideTva.FRecherche;
          GTDBGrid:     begin
                        if TCustomdbgrid(control).SelectedField.DataSet.State in [dsedit,dsinsert] then
                        TCustomdbgrid(control).selectedfield.asstring:=AideTva.FRecherche;
                        end;
          GTFieldString:begin
                        if TField(control).DataSet.State in [dsedit,dsinsert] then
                        TField(control).asstring:=AideTva.FRecherche;
                        end;
          end;//fin du case
        end;

//   with AideTva do begin
//	   FRecherche:= '';
//      FCompte:= Compte;
//      if (Control <> Nil) then Begin
//         if (Control is TCustomEdit) then
//				FRecherche:= TCustomEdit(Control).Text
//         Else if (Control is TStringGrid) then
//            with TStringGrid(Control) do FRecherche:= Cells[Col, Row]
//         Else FRecherche:= '';
//      End;
//
//      if Not Empty(FRecherche) Then Begin
//	      if not rbCode.Checked then rbClick(rbCode);
//
//   	   AideTva.TaTva.FindKey([FRecherche]);
//      End;
//
//      ActiveControl:= grTva;
//   	Result:= (ShowModal = mrOk);
//
//      if (Control <> Nil) then Begin
//         if (Control is TCustomEdit) then
//				TCustomEdit(Control).Text:= AideTvaField('TvaCode').AsString
//         Else if (Control is TStringGrid) then
//            with TStringGrid(Control) do Cells[Col, Row]:= AideTvaField('TvaCode').AsString;
//      End;
//   end;
End;

//******************************************************************************
Function AideTvaAfficheTous(Control :Tcomponent):Boolean;
// Affiche la liste des codes TVA dans l'écran d'aide
// Retourne vrai si le code TVA est valide pour le compte en cours
// Mise à jour du contrôle d'appel
var
TvaCodePourCpt:TTvaCodePourCompte;
Begin
	if (AideTva = Nil) then
   	AideTva:= TAideTva.Create(Application.MainForm);
        AideTva.Tag:=2;
        AideTva.FCompte:= '';
//        TvaCodePourCpt:=DMPlan.TvaCodePourCompte(31,E.Regime,Compte);
        //if TvaCodePourCpt.Retour then
          begin
           //DMTVACode.TaTvaCode.Filter:=CreeFiltreOU('Classe',[TvaCodePourCpt.ListeClasse]);
           DMTVACode.TaTvaCode.Filtered:=false;
           DMTVACode.TaTvaCode.Open;
          end;

      if (Control <> Nil) then Begin
        case RecupClassTypeComponent(control)of
        GTEdit:AideTva.FRecherche:=TCustomEdit(Control).Text;
        GTStringGrid: with TStringGrid(Control) do AideTva.FRecherche:=Cells[Col, Row];
        GTGrid: with TStringGrid(Control) do AideTva.FRecherche:=Cells[Col, Row];
        GTDBGrid:     begin
                      if TCustomdbgrid(control).SelectedField.DataSet.State in [dsedit,dsinsert] then
                      AideTva.FRecherche:=TCustomdbgrid(control).selectedfield.asstring;
                      end;
        GTFieldString:begin
                      if TField(control).DataSet.State in [dsedit,dsinsert] then
                      AideTva.FRecherche:=TField(control).asstring;
                      end;
        end;//fin du case
      end;
      DMTVACode.TaTvaCode.Locate('TvaCode',AideTva.FRecherche,[loPartialKey]);
      AideTva.ActiveControl:= AideTva.grTva;
      AideTva.TitreForm:='Code TVA';
      AideTva.SousTitreForm:=CAide;

      Result:= (AideTva.ShowModal = mrOk);
      AideTva.FRecherche:=DMTVACode.TaTvaCode.findfield('TvaCode').AsString;
      if result and (control <> nil) then
         begin
          case RecupClassTypeComponent(control)of
          GTEdit:TCustomEdit(Control).Text:=AideTva.FRecherche;
          GTStringGrid: with TStringGrid(Control) do Cells[Col, Row]:=AideTva.FRecherche;
          GTGrid: with TStringGrid(Control) do Cells[Col, Row]:=AideTva.FRecherche;
          GTDBGrid:     begin
                        if TCustomdbgrid(control).SelectedField.DataSet.State in [dsedit,dsinsert] then
                        TCustomdbgrid(control).selectedfield.asstring:=AideTva.FRecherche;
                        end;
          GTFieldString:begin
                        if TField(control).DataSet.State in [dsedit,dsinsert] then
                        TField(control).asstring:=AideTva.FRecherche;
                        end;
          end;//fin du case
        end;
End;

//******************************************************************************
Function AideTvaExiste(TvaCode :String; Compte :String; Control :TWinControl) :Boolean;
// Le passage du contrôle d'appel est facultatif
// Contrôle la cohérence du code saisi / Compte en cours
// Si non cohérent, affichage de l'aide
Begin
try
//      if (AideTva = Nil) then
//         AideTva:= TAideTva.Create(Application.MainForm);
//      if DMTVACode = nil then DMTVACode:=TDMTVACode.Create(application.MainForm);
      result:=AideTvaCodeValide(TvaCode, Compte);
      if Not Result And (Control <> Nil) then
         Result:= AideTvaAffiche(Control, Compte);


//	if Empty(TvaCode) Then Result:= True
//   Else Begin
//      if (AideTva = Nil) then
//         AideTva:= TAideTva.Create(Application.MainForm);
//
//      if not AideTva.rbCode.Checked then AideTva.rbClick(AideTva.rbCode);
//
//      Result:= AideTva.TaTva.FindKey([TvaCode]);
//
//      if Not Result And (Control <> Nil) then
//         Result:= AideTvaAffiche(Control, Compte);
//
//      if (Result) And Not Empty(Compte) then Begin
//      	{Controle la cohérence Compte/Code}
//         Result:= AideTvaCodeValide(TvaCode, Compte);
//      End;
//   End;
except
  result:=false;
end;
End;

//******************************************************************************
Function AideTvaCodeValide(TvaCode :String; Compte :String) :Boolean;
//Controle la cohérence Compte/Code
var
TvaCodePourCpt:TTvaCodePourCompte;
Begin
try
//      if (AideTva = Nil) then
//         AideTva:= TAideTva.Create(Application.MainForm);
//      if DMPlan = nil then DMPlan:=TDMPlan.Create(application.MainForm);
//      if DMTVACode = nil then DMTVACode:=TDMTVACode.Create(application.MainForm);
      result:=false;
      TvaCodePourCpt:=DMPlan.TvaCodePourCompte(31,E.Regime,Compte);
      if TvaCodePourCpt.Retour then
         result:=TvaCodePourCpt.ListeCode.IndexOf(TvaCode) <> -1;
//	if ExisteRacine(31, Compte) then Begin
//   	if (AideTvaField('Classe').asString = 'I') then
//   	{Immobilisation}
//			Result:= (FieldParam('Rac4').asString = '*')
//      Else if (AideTvaField('Classe').asString = 'A') then
//      {Bien et Service}
//      	Result:= (FieldParam('Rac3').asString = '*')
//      Else if (AideTvaField('Classe').asString = 'C') Then
//      {Acquisition CEE, Bien et Service et Immobilisation}
//      	Result:= (FieldParam('Rac3').asString = '*')
//         	Or (FieldParam('Rac4').asString = '*')
//      Else
//      	{Vente}
//      	Result:= (FieldParam('Rac2').asString = '*')
//
//   End
//   Else Result:= False;
except
  result:=false;
end;
End;

//******************************************************************************
Function AideTvaTvaType(TvaCode :String):boolean;
// Retourne le type TVA ( Vrai= D ou False=E) / TvaCode
Begin
      if (AideTva = Nil) then
         AideTva:= TAideTva.Create(Application.MainForm);

//	if Empty(TvaCode) then Result:= Empty(TvaType)
//   Else Result:= (TvaType = 'E') Or (TvaType = 'D');
End;

//******************************************************************************
Function AideTvaTypeValide(TvaCode :String; TvaType :String) :Boolean;
// Contrôle le type TVA / Code
Begin
//      if (AideTva = Nil) then
//         AideTva:= TAideTva.Create(Application.MainForm);
	if Empty(TvaCode) then Result:= Empty(TvaType)
   Else Result:= (TvaType = 'E') Or (TvaType = 'D');
End;

//******************************************************************************
Function AideTvaTauxValide(TvaCode,Compte :String; TvaTaux :Currency) :Boolean;
Var
RecupMiniMaxTva:TRecupMiniMaxTva;
// Contrôle le taux de TVA / Code TVA
Begin
//      if (AideTva = Nil) then
//         AideTva:= TAideTva.Create(Application.MainForm);
   if AideTvaExiste(TvaCode, Compte, Nil) then
    Begin
    RecupMiniMaxTva:=FTvaRecupMiniMaxTva(TvaCode);
    if ((copy(TvaCode,1,1)='C') or (copy(TvaCode,1,1)='M')or (copy(TvaCode,1,1)='A')) then
     begin
       case RecupMiniMaxTva.CodeRetour of
         0:begin
            result:= (TvaTaux <> 0);
             if not result then
                  Begin
                   result:=Application.MessageBox(PChar('Êtes-vous sûr de vouloir utiliser le taux de : '+
                                      CurrToStr(TvaTaux)+
                                      ' % ? '+#10#13+
                                      'NOTE : Le Taux de Tva par defaut de ce compte est de : ' + CurrToStr(RecupMiniMaxTva.Taux_Inf)),'Confirmation',MB_YESNO+MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES;

                  end;
           end;
         1:begin
//             Result:= (((TvaTaux > 0) and (TvaTaux <> RecupMiniMaxTva.Taux_Inf))
//                       And ((TvaTaux > RecupMiniMaxTva.Taux_Inf)and(TvaTaux < 100)));
             Result:= not ((TvaTaux > 0) and (TvaTaux <> RecupMiniMaxTva.Taux_Inf)
                       and (TvaTaux < 100));
             if not result then
                  Begin
                   result:=Application.MessageBox(PChar('Êtes-vous sûr de vouloir utiliser le taux de : '+
                                      CurrToStr(TvaTaux)+
                                      ' % ? '+#10#13+
                                      'NOTE : Le Taux de Tva par defaut de ce compte est de : ' + CurrToStr(RecupMiniMaxTva.Taux_Inf)),'Confirmation',MB_YESNO+MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES;

                  end;
           end;
         2:begin
//             Result:= (((TvaTaux > 0) and (TvaTaux <> RecupMiniMaxTva.Taux_Inf))
//                       And ((TvaTaux > RecupMiniMaxTva.Taux_Inf)and(TvaTaux < 100)));
             Result:= not ((TvaTaux > 0) and (TvaTaux <> RecupMiniMaxTva.Taux_Supp)
                       and (TvaTaux < 100));
             if not result then
                  Begin
                   result:=Application.MessageBox(PChar('Êtes-vous sûr de vouloir utiliser le taux de : '+
                                      CurrToStr(TvaTaux)+
                                      ' % ? '+#10#13+
                                      'NOTE : Le Taux de Tva par defaut de ce compte est de : ' + CurrToStr(RecupMiniMaxTva.Taux_Supp)),'Confirmation',MB_YESNO+MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES;

                  end;
           end;
         12:begin
//             Result:= ((TvaTaux > 0) and (TvaTaux <> RecupMiniMaxTva.Taux_Inf)
//                       And (TvaTaux <> RecupMiniMaxTva.Taux_Supp)and(TvaTaux < 100));
             Result:= ((TvaTaux = RecupMiniMaxTva.Taux_Inf) or (TvaTaux = RecupMiniMaxTva.Taux_Supp));
             if not result then
                  Begin
                   result:=Application.MessageBox(PChar('Êtes-vous sûr de vouloir utiliser le taux de : '+
                                      CurrToStr(TvaTaux)+
                                      ' % ? '+#10#13+
                                      'NOTE : Les Taux de Tva par défaut de ce compte sont soit : ' + CurrToStr(RecupMiniMaxTva.Taux_inf)+ ' soit : '+CurrToStr(RecupMiniMaxTva.Taux_Supp)),'Confirmation',MB_YESNO+MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES;

                  end;
           end;
       end;
    end
    else
    Begin
       case RecupMiniMaxTva.CodeRetour of
         0:result:= (TvaTaux = 0);
         1:Result:= (TvaTaux > 0) And (TvaTaux < 100);
         2: ;
         12: ;
         -1:result:=true;//code N
       end;
    End;


//     if Empty(TvaCode) Or Not ((AideTvaField('Classe').asString = 'C') and (AideTvaField('Classe').asString = 'A')) then
//   	Result:= (TvaTaux = 0)
//   	Else Result:= (TvaTaux > 0) And (TvaTaux < 100);
   End
   Else Result:= False;
End;

//******************************************************************************
Function AideTvaField(Champ :String) :TField;
// Raccourci de commande
// Retourne le poiteur sur l'objet champ
Begin
//
////******************************************************************************
//Function AideTvaField(Champ :String) :TField;
End;

procedure TAideTva.rbClick(Sender: TObject);
// Change l'ordre d'affichage des codes TVA
begin
//	FRecherche:= '';
//
//	if (Sender = rbCode) then Begin
//   	taTva.indexFieldNames:= 'TvaCode';
//      if Not rbCode.Checked then rbCode.Checked:= True;
//   End
//   Else Begin
//   	taTva.indexFieldNames:= 'Compte';
//      if Not rbCompte.Checked then rbCompte.Checked:= True;
//   End;
end;



//******************************************************************************
procedure TAideTva.grTvaTitleClick(Column: TColumn);
// Sur clic entête colonne, changement de l'ordre d'affichage
begin
//	if (Column.Index = 0) then rbClick(rbCode)
//   Else if (Column.Index = 2) then rbClick(rbCompte)
end;

//******************************************************************************
procedure TAideTva.grTvaDblClick(Sender: TObject);
// Validation
begin
  case self.tag of
     1:Begin
        Visualisation1.Click;
       End;

     2:Begin
        BtnEnregistrer.Click;
       End;
  end;
end;

//******************************************************************************
procedure TAideTva.grTvaKeyPress(Sender: TObject; var Key: Char);
// Si entrée, validaton de la sélection
begin
	if (Key = #13) then BtnEnregistrer.Click;
end;

//******************************************************************************
procedure TAideTva.pmMenu1Click(Sender: TObject);
// Touche de fonction F11, appelle le pop_up menu
begin
	PopupMenu1.Popup(Left + 50, Top + 50);
end;

procedure TAideTva.FormShow(Sender: TObject);
begin
PaTitre.Visible:=Main.AfficheTitre;
  case self.tag of
     1:Begin
        //RxSBImport.Visible := ((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'));
        caption:='Gestion des codes de TVA';
        Patitre.Caption:=caption;
        BtnEnregistrer.Caption:='Enregistrer [F3]';
        BtnInserer.visible:=true;
        BtnModifier.visible:=true;
        BtnSupprimer.visible:=true;
        FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
        BtnEnregistrer.ModalResult:=mrNone;
        EnableItemMenu([Insrer1,Modifier1,Supprimer1],false);
        grTva.Options:=grTva.Options - [dgRowSelect];
        grTva.ReadOnly:=False;
       End;

     2:Begin
        RxSBImport.Visible := false;
        caption:='Sélection des codes de TVA';
        Patitre.Caption:=caption;
        BtnEnregistrer.Caption:='Valider [F3]';
        BtnInserer.visible:=False;
        BtnModifier.visible:=False;
        BtnSupprimer.visible:=False;
        FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnFermer,BtnImprimer],PaBtn,90,0);
        BtnEnregistrer.ModalResult:=mrOK;
        grTva.Options:=grTva.Options + [dgRowSelect];
        EnableItemMenu([Insrer1,Modifier1,Supprimer1],false);
        VisibleItemMenu([Insrer1,Modifier1,Supprimer1],false);
        EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer],False);
        grTva.ReadOnly:=true;
       End;
  end;
DataTvaCodeStateChange(DMTVACode.DataTvaCode);
end;

procedure TAideTva.PaBtnResize(Sender: TObject);
begin
  case self.tag of
     1:Begin
        FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
       End;

     2:Begin
        FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnFermer,BtnImprimer],PaBtn,90,0);
       End;
  end;

end;

procedure TAideTva.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TAideTva.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TAideTva.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
grTva.ParamColor:=true;
grTva.Param:=ParamUtil.CouleurDBGrid;
grTva.UpDateColor;
Patitre.visible:=Main.AfficheTitre;
DMTVACode.DataTvaCode.OnStateChange:=DataTvaCodeStateChange;
end;

procedure TAideTva.PaGrilleResize(Sender: TObject);
begin
FormateTailleColonne(grTva,14,[1,2,2,5,1,1]);
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TAideTva.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
WinSuivPrec(Handle,key,[grTva,grTva.InplaceEditor]);
     If Key = VK_ESCAPE Then
     Begin
       If DMTVACode.DataTvaCode.State = dsBrowse Then
          begin
            if grTva.Focused then Self.Close else grTva.SetFocus;
          end;

      If DMTVACode.DataTvaCode.State = dsInsert Then
          Begin
               If Messagedlg('Annuler la création de ce code TVA ?',MtConfirmation,[mbno,mbyes],0) = mryes Then
               Begin
                    DMTVACode.taTvaCode.Cancel;
                    Abort;
               End
               Else
               Begin
                    Abort;
               End;
          End;

          If DMTVACode.DataTvaCode.State = dsEdit Then
          Begin
               If Messagedlg('Annuler les modifications de ce code TVA ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    DMTVACode.taTvaCode.Cancel;
                    Abort;
               End
               Else
               Begin
                    Abort;
               End
          End;
     End;
end;

procedure TAideTva.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
if DMTVACode <> nil then
 begin
  // Si l'utilisateur est en mode Insertion
     If DMTVACode.taTvaCode.State = dsInsert Then
     Begin
        if self.WindowState <> wsNormal then
          self.WindowState:=wsNormal;
        if screen.ActiveForm <> self then
          self.BringToFront;
          If BtnEnregistrer.Enabled Then
          Begin
               If Messagedlg('Voulez-vous enregistrer ce nouveau code TVA ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                 begin
                   TableGerePost(DMTVACode.taTvaCode);
                   canclose:=true;
                  end
                  else
                   begin
                   DMTVACode.taTvaCode.Cancel;
                   canclose:=true;
                   end;
          End
          Else
          Begin
               If Messagedlg('Voulez-vous annuler la création de ce code TVA ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                begin
                  DMTVACode.taTvaCode.Cancel;
                  canclose:=true;
                end
               Else
                 begin
                  canclose:=false;
                  end;
          End;
     End; // Fin utilisateur est en mode Insertion

     // Si l'utilisateur est en mode Modification
     If DMTVACode.taTvaCode.State = dsEdit Then
     Begin
        if self.WindowState <> wsNormal then
          self.WindowState:=wsNormal;
        if screen.ActiveForm <> self then
          self.BringToFront;
          If Messagedlg('Voulez-vous enregistrer les modifications de ce code TVA ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
           begin
            TableGerePost(DMTVACode.taTvaCode);
             end
             else
             begin
              DMTVACode.taTvaCode.Cancel;
             end;
     End; // Fin utilisateur est en mode Modification
  end;
if canclose then InitialiseTable_A_Nil;{ isa  le  29/01/04 }
end;

procedure TAideTva.grTvaColExit(Sender: TObject);
var
ErreurCodeTVA:TErreurSaisie;
begin
case grTva.DataSource.State of
   dsInsert:Begin
            ErreurCodeTVA:=DMTVACode.CtrlSaisieCodeTva(grTva.SelectedField);
            if ErreurCodeTVA.Retour= false then
               begin
                case ErreurCodeTVA.CodeErreur of
                   1000:Begin
                        messagedlg('LA classe de TVA est obligatoire.',MtWarning,[mbok],0);
                        abort;
                        End;

                   1001:Begin
                        messagedlg('Cette classe de TVA n''existe pas.',MtWarning,[mbok],0);
                        abort;
                        End;
                   100:Begin
                        messagedlg('Veuillez saisr un code de TVA valide.',MtWarning,[mbok],0);
                        abort;
                        End;
                   101:Begin
                        messagedlg('Ce code de Tva ne correspond à la classe de TVA choisie.',MtWarning,[mbok],0);
                        abort;
                        End;
                   102:Begin
                        messagedlg('Ce code de TVA existe déjà.',MtWarning,[mbok],0);
                        abort;
                        End;
                   3002:Begin
                        abort;
                        End;
                   3003:Begin
                        abort;
                        End;
                   3004:Begin
                        abort;
                        End;
                end;
               end;
            End;
   dsEdit:Begin
            ErreurCodeTVA:=DMTVACode.CtrlSaisieCodeTva(grTva.SelectedField);
            if ErreurCodeTVA.Retour= false then
               begin
                case ErreurCodeTVA.CodeErreur of
                   1000,1001:abort;
                   100:abort;
                   101:abort;
                   102:abort;
                   103:abort;
                end;
               end;
            End;
//            End;
end;
end;


procedure TAideTva.changementEtatBoutons(Sender: TObject);
begin
  case  DMTVACode.DataTvaCode.state of
   dsBrowse: begin
              case self.tag of
                 1:Begin
                    EnableItemMenu([Insrer1,Modifier1,Supprimer1],true);
                    VisibleItemMenu([Insrer1,Modifier1,Supprimer1],true);
                    EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer],true);
                     BtnInserer.Enabled := True;
                     if self.tag = 1 then
                     BtnEnregistrer.Enabled := False
                     else
                     BtnEnregistrer.Enabled := true;
                     BtnModifier.Enabled := Not( DMTVACode.taTvaCode.RecordCount = 0);
                     BtnSupprimer.Enabled := Not( DMTVACode.taTvaCode.RecordCount = 0);
                     BtnImprimer.Enabled:=true;
                   End;

                 2:Begin
                    grTva.Options:=grTva.Options + [dgRowSelect];
                    EnableItemMenu([Insrer1,Modifier1,Supprimer1],false);
                    VisibleItemMenu([Insrer1,Modifier1,Supprimer1],false);
                    EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer],False);
                   End;
              end;
             end;

   dsEdit:   begin
               BtnInserer.Enabled := False;
               BtnEnregistrer.Enabled := True;
               BtnModifier.Enabled := false;
               BtnSupprimer.Enabled := False;
               BtnImprimer.Enabled:=false;
             end;

   dsInsert: begin
               BtnInserer.Enabled := False;
               BtnEnregistrer.Enabled := False;
               BtnModifier.Enabled := False;
               BtnSupprimer.Enabled := False;
               BtnImprimer.Enabled:=false;
             end;
   end;//fin du case.state$
   //Pop-up Menu
   Fermer1.Enabled:=BtnFermer.Enabled;
   Insrer1.Enabled:=BtnInserer.Enabled;
   Enregister1.Enabled:=BtnEnregistrer.Enabled;
   Modifier1.Enabled:=BtnModifier.Enabled;
   Supprimer1.Enabled:=BtnSupprimer.Enabled;
   Imprimer1.Enabled:=BtnImprimer.Enabled;
end;

Procedure TAideTva.DataTvaCodeStateChange(sender:TObject);
begin
 Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DMTVACode.DataTvaCode.DataSet);
case DMTVACode.DataTvaCode.State of
   dsInsert:Begin
             DMTVACode.DataTvaCode.DataSet.FindField('Classe').ReadOnly:=false;
             DMTVACode.DataTvaCode.DataSet.FindField('TVACode').ReadOnly:=false;
             DMTVACode.DataTvaCode.DataSet.FindField('Compte').ReadOnly:=false;
             grTva.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
             grTva.SetFocus;
//             self.caption:='Gestion des Codes de TVA - Insertion';
             grTva.TitreColor(true);
            End;
   dsEdit:Begin
             DMTVACode.DataTvaCode.DataSet.FindField('Classe').ReadOnly:=True;
             DMTVACode.DataTvaCode.DataSet.FindField('TVACode').ReadOnly:=True;
             DMTVACode.DataTvaCode.DataSet.FindField('Compte').ReadOnly:=True;
             grTva.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
             grTva.SetFocus;
             grTva.TitreColor(true);
//             self.caption:='Gestion des Codes de TVA - Modification';
             if grTva.SelectedIndex < 3 then grTva.SelectedIndex:=3;
          End;
   dsbrowse:Begin
             DMTVACode.DataTvaCode.DataSet.FindField('Classe').ReadOnly:=True;
             DMTVACode.DataTvaCode.DataSet.FindField('TVACode').ReadOnly:=True;
             DMTVACode.DataTvaCode.DataSet.FindField('Compte').ReadOnly:=True;
             grTva.Options := [dgediting,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
             if grTva.Visible then grTva.SetFocus;
             if grTva.InplaceEditor <> nil then
                grTva.EditorMode:=false;
             grTva.TitreColor(true);
//             self.caption:='Gestion des Codes de TVA - Consultation';
          End;
end;
changementEtatBoutons(Sender);
end;
procedure TAideTva.Visualisation1Click(Sender: TObject);
begin
DetailEcritureCompteTVA(DMTVACode.TaTvaCode.FindField('Compte').AsString,DMTVACode.TaTvaCode.FindField('TvaCode').AsString,true)
end;

procedure TAideTva.BtnSupprimerClick(Sender: TObject);
begin
TableGereDelete(DMTVACode.TaTvaCode);
end;

procedure TAideTva.BtnModifierClick(Sender: TObject);
begin
DMTVACode.taTvaCode.Edit;
end;

procedure TAideTva.BtnInsererClick(Sender: TObject);
begin
DMTVACode.taTvaCode.Insert;
end;

procedure TAideTva.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TAideTva.RxSBInfoVersionClick(Sender: TObject);
begin
Showmessage(AideTvaRxSBInfoVersionWarning+numVersion.messageVersion);
end;

procedure TAideTva.Aide1Click(Sender: TObject);
begin
case grTva.DataSource.DataSet.State of
   dsInsert:Begin
             case grTva.SelectedIndex of
                0:Begin
                    showmessage('Les Lettres désignant les classes sont : '+ #13#10#13#10+
                                'A : Achats.'+ #13#10#13#10+
                                'C : Acquisition CEE.'+ #13#10#13#10+
                                'I : Immobilisations.'+ #13#10#13#10+
                                'V : Ventes.'+ #13#10#13#10+
                                'E : Exportations Hors CEE.'+ #13#10#13#10+
                                'L : Livraisons.'+ #13#10#13#10+
                                'F : Franchise.'+ #13#10#13#10+
                                'M : Autoliquidée.'+ #13#10#13#10+
                                'N : Exonéré.');
                  End;
                2:Begin
                    showmessage('Pas d''aide disponible pour l''instant.'+ #13#10#13#10+
                                'Vous devez choisir un compte de Tva qui soit en'+ #13#10#13#10+
                                'relation avec la classe de Code que vous avez sélectionné.'+ #13#10#13#10+numVersion.messageVersion);
                  End;
             end;
            End;
   dsEdit:Begin
             case grTva.SelectedIndex of
                1:Begin

                  End;
                2:Begin

                  End;
             end;
          End;
   dsBrowse:Begin
             case grTva.SelectedIndex of
                1:Begin

                  End;
                2:Begin

                  End;
             end;
            End;
end;

end;

procedure TAideTva.BtnImprimerClick(Sender: TObject);
begin
grTva.ReportCaption:='Paramètres TVA';
grTva.GridPreview;
end;

procedure TAideTva.BtnEnregistrerClick(Sender: TObject);
begin
ModalResult:= mrOk;
//self.close;
//	if AideTvaCodeValide(AideTvaField('TvaCode').asString, FCompte) then
//		ModalResult:= mrOk
//   Else
//		Erreur('Tva', 'Code/Compte');
end;

procedure TAideTva.RxSBImportClick(Sender: TObject);
begin
DMImport.Import_CodeTva(grTva.DataSource.DataSet,True);
end;







procedure TAideTva.Exporter1Click(Sender: TObject);
begin
ExportDonnees(grTva.DataSource.DataSet,E.RepertoireExportDossier,'CodesTva_'+E.NomDossier + E.NomExo + '.Txt');
end;

end.
