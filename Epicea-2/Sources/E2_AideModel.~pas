{***************************************************************
 *
 * Unit Name: E2_AideModel
 * Purpose  :
 * Author   :  JS
 * History  :
 *
 ****************************************************************}

//Gestion de l'écran d'aide des modèles
// Tout est commenté (PB)
unit E2_AideModel;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, Gr_Librairie_obj, DBGrids,
  Db, DBTables, Menus, RXDBCtrl, ExRxDBGrid, GrDBGrid, ComCtrls ,
  Registry,GRGrid,LibZoneSaisie,Piece, RXCtrls,DMConstantes,LibSQL,
  LibGestionParamXML, jpeg,E2_Decl_Records,E2_LibInfosTable,DMRecherche;

type
	TTypeJournal =(tjAchat, tjVente, tjBanque, tjOD, tjInconue);

  TAideModel = class(TForm)
    PaBas: TPanel;
    rbCode: TRadioButton;
    rbLibelle: TRadioButton;
    PopupMenu1: TPopupMenu;
    Aideenligne1: TMenuItem;
    Visualisation1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    AjouterCode1: TMenuItem;
    Supprimer1: TMenuItem;
    Modifier1: TMenuItem;
    N2: TMenuItem;
    Fermer1: TMenuItem;
    PageControl1: TPageControl;
    TabJournal: TTabSheet;
    TabTrame: TTabSheet;
    PaJournal: TPanel;
    grModel: TGrDBGrid;
    PaTrame: TPanel;
    GrDBGrid1: TGrDBGrid;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    Valider1: TMenuItem;
    Imprimer1: TMenuItem;
    Imprimerlaslection1: TMenuItem;
    BtnImprimerSelect: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grModelDblClick(Sender: TObject);
    procedure rdIndex(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure grModelKeyPress(Sender: TObject; var Key: Char);
    procedure pmMenu1Click(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrDBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure Supprimer1Click(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure Imprimerlaslection1Click(Sender: TObject);


  private
    { Déclarations private }
    FRecherche :String;
  public
    { Déclarations public }
  end;

Var
	AideModel: TAideModel;

	Function AideModelAffiche(Edit :TCustomEdit; GrillePourTrame:TGrGRid;Trame:boolean) :TExceptLGR;
   Function AideModelExiste(Edit :TCustomEdit; AfficheAide :Boolean) :TExceptLGR;
	Function AideModelField(Champ :String) :TField;
	Function AideModelCode(ID :LongInt) :String;
	Function AideModelJournal(ID :LongInt) :String;
	Function AideModelIDJournal :LongInt;
	Function AideModelIDCompte(Compte :String) :LongInt;
	Function AideModelTypeJournal(ID_Journal, ID :LongInt) :TTypeJournal;
        Function AideModelCompteJournalBanque(Compte:string):boolean;
        Function AideModelCompteEstJournal(Compte:string):boolean;
        Function AideModelAfficheJournauxBanque(Edit:TCustomEdit;ForceAffiche:Boolean):boolean;
        Function AideModelEnteteTrame(Grille:TGrGrid;Piece:Tpiece):TExceptLGR;
        Function AideTrameExiste(Edit :TCustomEdit; AfficheAide :Boolean; Grille:TGrgrid;Piece:Tpiece) :TExceptLGR;

implementation
uses E2_Librairie_obj, DMJournaux, E2_SaisieP_3,DMEcriture, DMPiece,ModuleTrame,
  E2_Main;
{$R *.DFM}

////******************************************************************************
Function AideModelAffiche(Edit :TCustomEdit; GrillePourTrame:TGrGRid;Trame:boolean) :TExceptLGR;
// Affiche l'écran d'aide en se positionnant sur le mot le plus près
// de celui passé en param et met à jour le controle d'ou l'appel est demandé.
Begin
Initialise_ExceptLGR(result);
	if (AideModel = Nil) then
   	AideModel:= TAideModel.Create(Application.MainForm);

        if trame then
          begin
            AideModel.PageControl1.ActivePage:=AideModel.PageControl1.Pages[1];
          end
        else
          begin
            AideModel.PageControl1.ActivePage:=AideModel.PageControl1.Pages[0];
          end;
	with AideModel do begin
      if Not Empty(Edit.Text) then Begin
   	   rdIndex(rbCode);
	      DMJournal.TaJournal.FindNearest([Edit.Text]);
        dmtrame.TaTrame.FindNearest([Edit.Text]);
//        dmtrame.TaTrame.locate('Code',Edit.Text,[loCaseInsensitive,loPartialKey]);
   	End;

		FRecherche:= Edit.Text;
//		ActiveControl:= grModel;
//      Result:= (ShowModal = mrOk);
      Result.NumErreur:= ShowModal;
      if result.NumErreur<>mrok then result.retour:=false;
    if Result.retour then
      begin
        case AideModel.PageControl1.ActivePage.PageIndex of
           0:begin
              Edit.Text:= DMJournal.TaJournalCode.Value;
              DMPieces.Piece1.Journal:=DMJournal.TaJournalJournal.AsString;
              DMPieces.Piece1.idJournal:=DMJournal.TaJournalID_Journal.asinteger;
             end;
           1:Begin
               if GrillePourTrame = nil then
                Begin
                 Edit.Text:= DMJournal.TaJournalCode.Value;
                 DMPieces.Piece1.Journal:=DMJournal.TaJournalJournal.AsString;
                 DMPieces.Piece1.idJournal:=DMJournal.TaJournalID_Journal.asinteger;
                End
                else
                Begin
                  if AideModelEnteteTrame(GrillePourTrame,Dmpieces.Piece1).retour  then
                   begin
                     Edit.text:=GrillePourTrame.InplaceEditor.text;
                   end;
                End;
             End;
        end;
      end;
   end;
End;

//******************************************************************************
Function AideModelExiste(Edit :TCustomEdit; AfficheAide :Boolean) :TExceptLGR;
// Création de l'écran
// Recherche du modèle et affichage de l'écran d'aide
// Retourne la valeur sélectionnée dans l'écran d'aide dans l'objet d'où viens
// l'appel
Begin
Initialise_ExceptLGR(result);
try
	if (AideModel = Nil) then
   	AideModel:= TAideModel.Create(Application.MainForm);
//	with AideModel do begin
      if Length(Edit.Text) > 0 then
      Begin
        if DMJournal.TaJournal.Locate('Code',Edit.text,[loCaseInsensitive,loPartialKey]) then
          begin
            Edit.Text:= DMJournal.TaJournal.findfield('Code').AsString;
            DMPieces.Piece1.Journal:=DMJournal.TaJournal.findfield('Journal').AsString;
            DMPieces.Piece1.IDJournal:=DMPieces.Piece1.RenvoieIDJournal(Edit.Text);
          end
        else
        if ((length(Edit.text)<=2))and(DMJournal.TaJournal.Locate('journal',Edit.text,[])) then
          begin
            Edit.Text:= DMJournal.TaJournal.findfield('Code').AsString;
            DMPieces.Piece1.Journal:=DMJournal.TaJournal.findfield('Journal').AsString;
            DMPieces.Piece1.IDJournal:=DMPieces.Piece1.RenvoieIDJournal(Edit.Text);
          end
        else
             begin
               DMPieces.Piece1.Journal:='';
               DMPieces.Piece1.IDJournal:=0;
             end;
//         if (UpperCase(Edit.Text) = 'A') then Edit.Text:= 'Achat'
//         else if (UpperCase(Edit.Text) = 'V') then Edit.Text:= 'Vente'
//         Else if (UpperCase(Edit.Text) = 'O') then Edit.Text:= 'OD'
      End
       else
             begin
               DMPieces.Piece1.Journal:='';
               DMPieces.Piece1.IDJournal:=0;
             end;

//
//      rdIndex(rbCode);
//      Result:= DMJournal.TaJournal.FindKey([Edit.Text]);
        Result.retour:= DMPieces.Piece1.VerifJournal(DMJournal.TaJournal,'Journal',true);
      if (Not Result.retour) And (AfficheAide) and (result.NumErreur<>mrcancel) then
         Result:= AideModelAffiche(Edit,nil,false);
//   End;
except
   showmessage('Problème sur AideModelExiste');
   abort;
end;
End;

//******************************************************************************
Function AideModelTypeJournal(ID_Journal, ID :LongInt) :TTypeJournal;
// Retourne le type du journal auquel est rattaché un modèle
// type de journal : Achat, Vente, OD, Banque
// Si la fonction retourne tjInconue, erreur !!!!
Var
	oIndex :String;
Begin
	if (AideModel = Nil) then
   	AideModel:= TAideModel.Create(Application.MainForm);

	if (ID_Journal = 0) then Begin
		if (ID > 3) Then
		with DMJournal.TaJournal do begin
	   	if (FindField('ID').asInteger <> ID) then Begin
         	oIndex:= IndexName;
				IndexName:= 'ID';
            if FindKey([ID]) Then ID_Journal:= AideModelIDJournal;
   	   	IndexName:= oIndex;
	      End
      	Else ID_Journal:= AideModelIDJournal;
      End
      Else ID_Journal:= ID;
   End;

	case ID_Journal of
   	0: Result:= tjInconue;
      1: Result:= tjAchat;
      2: Result:= tjVente;
      3: Result:= tjOD;
   Else
   	Result:= tjBanque;
   end;
End;

//******************************************************************************
Function AideModelField(Champ :String) :TField;
// Raccourci de commande
// Retourne le pointeur sur l'objet champ
Begin
	Result:= DMJournal.TaJournal.FindField(Champ);
End;

//******************************************************************************
Function AideModelIDCompte(Compte :String) :LongInt;
// Retourne l'ID du journal de banque suivant le compte
Var
	oIndex :String;
Begin
	if Empty(Compte) Then Result:= 3
   Else Begin
      if (AideModel = Nil) then
         AideModel:= TAideModel.Create(Application.MainForm);

      with DMJournal.TaJournal do
      if (FindField('ID_Journal').asInteger <> 0)
      Or (Compte <> FindField('Compte').asString) then Begin
         oIndex:= IndexName;
         IndexName:='Compte_';
         if (FindKey([0, Compte])) then
               Result:= FindField('ID').asInteger
         Else	Result:= 3;
	      IndexName:= oIndex;
      End
      Else Result:= FindField('ID').asInteger;
   End;
End;

//******************************************************************************
Function AideModelCode(ID :LongInt) :String;
// Retourne le code du modèle en fonction de son ID
Var
	oIndex :String;
Begin
	if (AideModel = Nil) then
   	AideModel:= TAideModel.Create(Application.MainForm);

	with DMJournal.TaJournal do
  	if (ID >= 0) And (ID <> FindField('ID').asInteger) then Begin
   	oIndex:= IndexName;
      IndexFieldNames:='ID';
      if (FindKey([ID])) then
            Result:= FindField('Code').asString
      Else	Result:= '';
      IndexName:= oIndex;
   End
   Else Result:= FindField('Code').asString;
End;

//******************************************************************************
Function AideModelJournal(ID :LongInt) :String;
// Retourne le code du journal en fonction de son ID
Var
	oIndex :String;
Begin
	if (AideModel = Nil) then
   	AideModel:= TAideModel.Create(Application.MainForm);

	with DMJournal.TaJournal do
  	if (ID >= 0) And (ID <> FindField('ID').asInteger) then Begin
   	oIndex:= IndexName;
      IndexFieldNames:='ID';
      if (FindKey([ID])) then
            Result:= FindField('Journal').asString
      Else	Result:= '';
      IndexName:= oIndex;
   End
   Else Result:= FindField('Journal').asString;
End;

//******************************************************************************
Function AideModelIDJournal :LongInt;
// Retourne l'ID du journal de l'enregistrement courant de la table Model
Begin
	with AideModel do begin
      if (DMJournal.TaJournalID_Journal.AsInteger = 0) then
         Result:= DMJournal.TaJournalID.AsInteger
      Else Result:= DMJournal.TaJournalID_Journal.AsInteger;
   end;
End;

//******************************************************************************
Function AideModelCompteJournalBanque(Compte:string):boolean;
Begin
if (AideModel = Nil) then
AideModel:= TAideModel.Create(Application.MainForm);
result:=DMJournal.TaJournal.Locate('Compte',compte,[loPartialKey]);
End;
//******************************************************************************

Function AideModelCompteEstJournal(Compte:string):boolean;
Begin
if (AideModel = Nil) then
AideModel:= TAideModel.Create(Application.MainForm);
result:=DMJournal.TaJournal.Locate('Compte',compte,[loPartialKey]);
End;

//******************************************************************************

Function AideModelAfficheJournauxBanque(Edit:TCustomEdit;ForceAffiche:Boolean):boolean;
Begin //PB, il ne pourra pas dire que c'est Isa qui l'a fait !!!!
if (AideModel = Nil) then
AideModel:= TAideModel.Create(Application.MainForm);
FiltrageDataSet(DMJournal.TaJournal,'Id_Journal=4');
result:=DMJournal.TaJournal.Locate('Compte',Edit.Text,[]);
If ForceAffiche then
 begin
  Result:= (AideModel.ShowModal = mrOk);
  if Result then
       begin
         Edit.Text:= DMJournal.TaJournalCompte.Value;
       end;
 end
 else
 begin
  if not result then
    begin
     Result:= (AideModel.ShowModal = mrOk);
     if Result then
       begin
         Edit.Text:= DMJournal.TaJournalCompte.Value;
       end;
    end;
 end;

DeFiltrageDataSet(DMJournal.TaJournal);
End;

//******************************************************************************

Function AideModelEnteteTrame(Grille:TGrGrid;Piece:Tpiece):TExceptLGR;
Var
Texte:string;
begin
Initialise_ExceptLGR(result);
result.retour:=true;
  try
    if (AideModel = Nil) then
    AideModel:= TAideModel.Create(Application.MainForm);
    DMPieces.Piece1NewPiece(piece);
    piece.IDJournal:=DMTrame.TaTrame.FindField('ID_Journal').AsInteger;
    Piece.Journal:=DMTrame.TaTrame.FindField('Journal').Asstring;
    piece.Compte:=DMTrame.TaTrame.FindField('Compte').AsString;
    piece.Libelle:=DMTrame.TaTrame.FindField('Libelle').AsString;
    piece.trame.IDTrame:=DMTrame.TaTrame.FindField('ID').asinteger;
    piece.trame.CodeTrame:=DMTrame.TaTrame.FindField('Code').asstring;
    piece.Trame.LibelleTrame:=DMTrame.TaTrame.FindField('Libelle_Trame').asstring;
    piece.Trame.TrameACharger:=true;
    piece.Defaut:=false;
    DefiltrageDataset(dmrech.TaModelRech);
    Grille.InplaceEditor.Text:=Infos_TInfosModel(dmrech.TaModelRech,'Journal',[DMTrame.TaTrameJournal.AsString]).Code;
    Grille.Cells[0,1]:=Grille.InplaceEditor.Text;
    Grille.Cells[2,1]:=piece.Compte;
    Texte:=piece.Libelle;
    Grille.Cells[4,1]:=TraiteMotCle(Texte,['15']);
    piece.Libelle:=Grille.Cells[4,1];
  except
    result.retour:=true;
  end;
end;

//******************************************************************************
// Initialisation de l'écran et ouverture de la table Model

procedure TAideModel.FormCreate(Sender: TObject);
Var
Registre :TRegistry;
FTPage:Integer;
begin
    try


	   LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
        Width:=600;
        Height:=400;
//        InitialiseFormPosDefaut(self);
    end;
 Registre:= TRegistry.Create;
 try
  with Registre do
    begin
     RootKey := HKEY_LOCAL_MACHINE;
     OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, false);
       try
       FTPage:=ReadInteger('FTPage');
//       PageControl1.Pages.
       except
       FTPage:=0;
       end;
     end;
  finally
  PageControl1.ActivePage:=PageControl1.Pages[FTPage];
  Registre.Free;
  TabJournal.Align:=AlClient;
  TabTrame.Align:=AlClient;
  end;
end;

//******************************************************************************
// Fermeture de l'écran et fermeture de la table Model
procedure TAideModel.FormDestroy(Sender: TObject);
Var
	Registre :TRegistry;
begin
 Registre:= TRegistry.Create;
 try
  with Registre do
    begin
     RootKey := HKEY_LOCAL_MACHINE;
     OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, false);
       try
        WriteInteger('FTPage',PageControl1.ActivePage.TabIndex);
       except
       end;
     end;
  finally
  end;
   LibGestionParamXML.DestroyForm(Self,E.USer);
   AideModel:=nil;
end;

//******************************************************************************
procedure TAideModel.grModelDblClick(Sender: TObject);
// Validation du modèle avec double clic sur celui-ci
begin
	ModalResult:= mrOk;
end;

//******************************************************************************
procedure TAideModel.rdIndex(Sender: TObject);
// Change l'ordre d'affichage
begin
	FRecherche:= '';

	if (Sender = rbCode) then Begin
   	DMJournal.TaJournal.indexName:= 'Code_';
      if Not rbCode.Checked then rbCode.Checked:= True;
   End
   Else	Begin
   	DMJournal.TaJournal.indexName:= 'Libelle_';
      if Not rbLibelle.Checked then rbLibelle.Checked:= True;
   End;
end;

//******************************************************************************
procedure TAideModel.FormClose(Sender: TObject;
  var Action: TCloseAction);
// Rend invisible l'écran lors de sa fermeture
begin
	Action:= caHide;
end;

//******************************************************************************
procedure TAideModel.FormKeyPress(Sender: TObject; var Key: Char);
// Recherche dynamique dans la table
begin
	if (Key >= #32) then Begin
	   FRecherche:= UpperCase(FRecherche + Key);
      Key:= #0
   End
   Else if (Key = #08) then Begin
		FRecherche:= Copy(FRecherche, 1, Length(FRecherche) -1);
      Key:= #0
   End;
if key <> #13 then
   if Not Empty(FRecherche) or (Key = #08) then Begin
  	   DMJournal.TaJournal.FindNearest([FRecherche]);
   End
end;

//******************************************************************************
procedure TAideModel.grModelKeyPress(Sender: TObject; var Key: Char);
// Si entrée, validaton de la sélection
begin
if (Key = #13) then 
grModelDblClick(grModel);
//	if (Key = #13) then BtnEnregistrerClick(BtnEnregistrer);
end;

procedure TAideModel.pmMenu1Click(Sender: TObject);
// Touche de fonction F11, appelle le pop_up menu
begin
	PopupMenu1.Popup(Left + 50, Top + 50);
end;

procedure TAideModel.Visualisation1Click(Sender: TObject);
begin
DetailEcritureJournal(AideModelJournal(AideModelIDJournal),true);
end;

procedure TAideModel.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=Vk_F1 then
  begin
    PageControl1.SelectNextPage(PageControl1.ActivePage=TabJournal);
  end;
if shift = [ssCtrl] then
 case key of
    VK_LEFT:Begin
             PageControl1.SelectNextPage(false);
            End;

    VK_RIGHT:Begin
             PageControl1.SelectNextPage(true);
             End;

 end;

end;

procedure TAideModel.GrDBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
case key of
VK_UP,VK_PRIOR:if DMTrame.TaTrame.BOF then
       begin
       DMTrame.TaTrame.last;
       key:=VK_CANCEL;
       end;
VK_DOWN,VK_NEXT:if DMTrame.TaTrame.EOF then
       begin
        DMTrame.TaTrame.first;
        key:=VK_CANCEL;
       end;
end;

end;

procedure TAideModel.FormActivate(Sender: TObject);
begin
DMTrame.TaTrame.Refresh;
Patitre.visible:=Main.AfficheTitre;

grModel.ParamColor:=true;
grModel.Param:=ParamUtil.CouleurDBGrid;
grModel.UpDateColor;

GrDBGrid1.ParamColor:=true;
GrDBGrid1.Param:=ParamUtil.CouleurDBGrid;
GrDBGrid1.UpDateColor;

 CouleurFond([PaBtn,PaBas],ParamUtil.CouleurPanelCorps);

case PageControl1.ActivePage.TabIndex of
   0:grModel.SetFocus;
   1:GrDBGrid1.SetFocus;
end;

end;

procedure TAideModel.BtnEnregistrerClick(Sender: TObject);
begin
	ModalResult:= mrOk;
end;

procedure TAideModel.PaBtnResize(Sender: TObject);
begin

case PageControl1.ActivePage.TabIndex of
   0:FormateTailleColonne(grModel,5,[1,4]);
   1:FormateTailleColonne(GrDBGrid1,5,[1,4]);
end;


WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnFermer,BtnImprimer,BtnImprimerSelect],PaBtn,90,0);
end;

procedure TAideModel.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TAideModel.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;


Function AideTrameExiste(Edit :TCustomEdit; AfficheAide :Boolean; Grille:TGrgrid;Piece:Tpiece) :TExceptLGR;
// Création de l'écran
// Recherche du modèle et affichage de l'écran d'aide
// Retourne la valeur sélectionnée dans l'écran d'aide dans l'objet d'où vient
// l'appel
var
Trouve:boolean;
Begin
Initialise_ExceptLGR(result);
	if (AideModel = Nil) then
   	AideModel:= TAideModel.Create(Application.MainForm);
//	with AideModel do begin
      if Length(Edit.Text) > 0 then
      Begin
        //filtrageDataset(DMTrame.TaTrame,CreeFiltreOU('Journal',[Piece.Journal]));
//        if DMTrame.TaTrame.Locate('Code;Journal',VarArrayOf(piece.journal,Edit.text),[loCaseInsensitive]) then
        if not empty(piece.journal)then
          Trouve:=GrLocate(dmtrame.TaTrame,'Journal;Code',[piece.journal,Edit.text])
        else
          Trouve:=GrLocate(dmtrame.TaTrame,'Code',[Edit.text]);
        if trouve then
          begin
                if AfficheAide then
                  result:=AideModelAffiche(edit,grille,true)
                else
                  result:=AideModelEnteteTrame(grille,Piece);
                edit.text:=grille.InplaceEditor.text;

//            if DMTrame.TaTrame.Locate('Code',Edit.text,[loCaseInsensitive]) then
//              begin//si trame trouvée
//                if AfficheAide then
//                  AideModelAffiche(edit,grille,true)
//                else
//                  AideModelEnteteTrame(grille,Piece);
//                edit.text:=grille.InplaceEditor.text;
//              end//fin si trame trouvée
//            else
//              Begin//si trame pas trouvée mais début oui, affiche aide trame
//                Result:= AideModelAffiche(Edit,Grille,true);
//              End;//fin si trame pas trouvée mais début oui, affiche aide trame
          end
           else
           if AfficheAide then
             Result:= AideModelAffiche(Edit,Grille,false)
           else
             result:=aideModelexiste(edit,false);
//         if (UpperCase(Edit.Text) = 'A') then Edit.Text:= 'Achat'
//         else if (UpperCase(Edit.Text) = 'V') then Edit.Text:= 'Vente'
//         Else if (UpperCase(Edit.Text) = 'O') then Edit.Text:= 'OD'
      End
       else Piece.Journal:='';

//
//      rdIndex(rbCode);
//      Result:= DMJournal.TaJournal.FindKey([Edit.Text]);
        Result.retour:= Piece.VerifJournal(DMJournal.TaJournal,'Journal',true);
      if (Not Result.retour)and (result.NumErreur<>mrcancel) then
         Result:= AideModelAffiche(Edit,Grille,false);
//   End;
End;

procedure TAideModel.Supprimer1Click(Sender: TObject);
begin
TableGereDelete(DMTrame.TaTrame);
end;

procedure TAideModel.BtnImprimerClick(Sender: TObject);
begin
if(PageControl1.ActivePage<>TabTrame)then
  EditionDesJournauxL(C_EditionSimple,True,nil,grModel.DataSource.DataSet)
else
  EditionDesTrames(C_EditionSimple,True,nil,GrDBGrid1.DataSource.DataSet);
end;

procedure TAideModel.Imprimerlaslection1Click(Sender: TObject);
begin
if(PageControl1.ActivePage<>TabTrame)then
  EditionDesJournauxL(C_EditionSimple,True,grModel.DataSource.DataSet.findfield('Journal').asstring,nil)
else
  EditionDesTrames(C_EditionSimple,True,GrDBGrid1.DataSource.DataSet.findfield('Code').asstring,nil);
end;

end.
