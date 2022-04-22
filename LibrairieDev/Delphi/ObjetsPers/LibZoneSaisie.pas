unit LibZoneSaisie;

interface

Uses
SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics,
Controls, Dialogs, Forms, Registry, Db, DBTables, Math, stdctrls, ExtCtrls,dbgrids,
RXCtrls,grids,GrDBGrid, GrGrid, comctrls, GR_Librairie_Obj, menus,LibDates,dbctrls,RXDBCtrl,
 CurrEdit,
 E2_Librairie_Obj,
 Lib_Chaine,
 LibRessourceString,
 E2_Decl_Records,
// E2_InfoComposant,
 Piece,
 LibSql,
 Lib1,
 ToolEdit,
 Variants;


type
TFormLocale = class(TForm)
   Procedure FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
protected
public
end;

TVarFNumeric = Record
     Ent:boolean;
     Decimal:boolean;
     Curr:Boolean;
     Vide:boolean;
     Zero:boolean;
     Pos:Boolean;
     Neg:Boolean;
     TypeChamp:TFieldType;
     VideETZero:Boolean;
     VideOUZero:Boolean;
  end;

TVarNumeric = Record
     Ent:boolean;
     Decimal:boolean;
     Curr:Boolean;
     Vide:boolean;
     Zero:boolean;
     Pos:Boolean;
     Neg:Boolean;
     VideETZero:Boolean;
     VideOUZero:Boolean;
  end;

TNumCompte = Record
     vide:boolean;
     Classe:integer;
     CptBon:string;
   end;

TMControl = class(TControl)
public
  property Text;

end;


//******************************************************************************
// Vide tous les controles de saisie
// ZSaisie : tableau de zone de saisie
//******************************************************************************
procedure VideZoneSaisieTxt(Zsaisie : array of TControl);

//******************************************************************************
// Initialise tous les controles de saisie avec la valeur '0' Zero
// ZSaisie : tableau de zone de saisie
//******************************************************************************
procedure VideZoneSaisieInt(ZSaisie : array of TCustomEdit);

//******************************************************************************
// Rempli tous les controles avec les valeurs du tableau Valeurs
// ZSaisie : tableau de zone de saisie
// Valeurs : tableau des valeurs affecté dans les controles
//******************************************************************************
Procedure RempliChamp(Zsaisie : array of TControl; Valeurs : array of string);

//******************************************************************************
// Verifie si les TWinControl ont une valeur
// Retourne nil s'ils possèdent tous une valeur
// Si un WinControle n'a pas de valeur, la fonction le renvoi
// ZSaisie : tableau de zone de saisie
// Focus : si vrai, cela permet d'affecter automatiquement le focus au premier
// WinControle qui n'a pas de valeur, si Faux: Rien ne se passe
//******************************************************************************
function VerifZoneSaisie(ZSaisie : array of TWinControl;Focus:boolean):TWinControl;
//******************************************************************************
Function GestionAutomatisationDuPlusCompteTiers(Automatique,Defaut:boolean):boolean;

//******************************************************************************
// Retourne des informations sur un champ numerique
// sous le format TVarFNumeric
//******************************************************************************
Function VerifFNumeric(Champ:TField):TVarFNumeric;

//******************************************************************************
// Retourne des informations sur une valeur numerique
// sous le format TVarNumeric
//******************************************************************************
Function VerifNumeric(Valeur:string):TVarNumeric;

//******************************************************************************
// Vérifie si un compte est vide ou pas, s'il a bonne syntaxe
// sous le format TNumCompte
// Deux message possible :
//              mes1 : indique qu'un compte ne peut pas commencer par zero
//              mes2 : indique qu'un compte ne peut pas commencer par 8 ou 9
//******************************************************************************
Function VerifNumCptIntegrite(cpt:string;mes1,mes2:boolean):TNumCompte;

//******************************************************************************
//Permet de se déplacer au controle suivant
// Suivant : boolean, si vrai, controle suivant, sinon, controle précédent
//******************************************************************************
Procedure WinSuivPrec(Handle:integer;key:word;WExclus : array of TWinControl);

//******************************************************************************
//Positionne Shape1 et Shape autour du controle
// key : VK_DOWN,VK_RETURN, controle suivant, key : VK_UP, controle précédent
//******************************************************************************
Procedure WinShape(WinControl:TWincontrol;Shape1,Shape2:TShape;Couleur:TColor);overload;
Procedure WinShape(WinControl:TWincontrol;Shape1,Shape2:TShape;Couleur:TColor;TabStopParam:boolean);overload;
Procedure BouttonAgrandit(Boutton:TButton);
Procedure BouttonDiminue(Boutton:TButton);
Procedure BoutonRXAgrandit(Boutton:TRxSpeedButton);
Procedure BoutonRXDiminue(Boutton:TRxSpeedButton);
Procedure WinRxLabTab(Labels: array of TGraphicControl;CouleurLabel,CouleurShadow:TColor);
Procedure WinRxLab(Labels:TGraphicControl;CouleurLabel,CouleurShadow:TColor);
Procedure GrDbGridInitColonne(var GrDbGrille:TGrDbGrid;DataSource:TDataSource;DataSet:TDataSet;TitreColonne,NomChamp : array of String;FormatMonnaie,EditFormat:String);
Procedure GrDbGridInitCouleur(GrDbGrille:TGrDbGrid;Param:TVarColorGrid);
Function RenvoiTailleColonne(GrDbGrille:TGrDbGrid;IndexColonnes:array of Integer):Integer;
Function RenvoiTailleColonne_GrGrid(GrGrille:TGrGrid;IndexColonnes:array of Integer):Integer;
Function RenvoiTailleColonneListView(ListView:TListView;IndexColonnes:array of Integer):Integer;
Procedure FormateTailleColonne(GrDbGrille:TGrDbGrid;NombreDePartie:Integer;ProportionPartie:array of Integer);
Procedure FormateTailleBoutton(Boutton:array of TControl;PanelPere:TPanel;LargeurBoutton,HauteurBoutton:integer);
Procedure FormateTailleBouttonAvecEspace(Boutton:array of TControl;PanelPere:TPanel;LargeurBoutton,HauteurBoutton:integer;EspaceBouton:integer);

Procedure PopMenuVersPopUpMenu(PopMenu:TMenuItem;PopUpMenu:TPopUpMenu);
procedure ConstruitPopMenu(index:integer;Caption:string;PopMenu: TMenuItem;Form:TForm;NotifyEvent:TNotifyEvent);
Function ModifiePopMenu(IndexPosition:Integer;Libelle:String;IdImage:Integer;ImageList:TImageList;MenuPere:TMenuItem):TMenuItem;
Function SommeColonne(Grille:TStringGrid;Col,RowDeb,RowFin:Integer):Variant;
Function SommeColonneListView(Grille:TListView;Col,RowDeb,RowFin:Integer):Variant;
Function SommeColonneFormate(Grille:TStringGrid;Col,RowDeb,RowFin:Integer):Variant;
Function TraiteMotCle(TexteATraiter:string;const DonneesVar:array of string):string;
Procedure CouleurFond(Zsaisie : array of TControl;CouleurFond:TColor);
Procedure CouleurActivecontrolLabel(CouleurFondActiveControl:TColor;LabelAssocie:TGraphicControl;CouleurLabel,CouleurShadow:TColor);
Procedure CouleurDeActivecontrolLabel(Control:TControl;CouleurFondActiveControl:TColor;LabelAssocie:TGraphicControl;CouleurLabel,CouleurShadow:TColor);
Function DetruitTouteForm(FormExclu:Array of TForm):boolean;
Function DetruitTouteFormNonShowModal(FormExclu:Array of TForm):boolean;
Function DetruitTousDataModule(DMExclu:Array of TDataModule):boolean;
Procedure FormateMonnaie(CurrEdit:Array of TCurrencyEdit;FormatMonnaie:string);
Function AfficheInfoComposant(Mess:string;composant:TComponent;Affiche:boolean):TstringList;
Function AfficheInfoComposantInput:string;
//Function AfficheInfoComposantForm(Maintenance:boolean;TypeMaintenance:string):string;
Function AfficheInfoObjet(Mess:string;Objet:TOBJECT;Affiche:boolean):TStringList;
Procedure MessageSilencieux(MessTitre,Mess:string;PanelMessage:TPanel;PaTop,PaWidth,PaLeft,PaHeigth:Integer;Form:TForm);
Procedure MessageSilencieuxEfface(PanelMessage:TPanel;Form,FormOrg:TForm);
Function ActivationForm(Form:TForm):Boolean;
procedure ChangementEtatGrille(GrDBGrid:TGrDBGrid);
procedure ChangementEtatBouttons(BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer : TButton; DataSet:TDataSet);
Procedure InfoTailleForm(Form:TForm);
Procedure GrGridInitColonne(var GrGrille:TGrGrid;TitreColonne : array of String;ChampGrille:array of tchamp;ChampReadOnly:array of boolean; FormatMonnaie,EditFormat:String);
Procedure FormateTailleColonne_GrGrid(GrGrille:TGrGrid;NombreDePartie:Integer;ProportionPartie:array of Integer);
Function SauveEtatFiche(var EtatFiche:TEtatFiche;Form:TForm):Boolean;
Function RestaureEtatFiche(EtatFiche:TEtatFiche;Form:TForm):Boolean;
procedure Init_TabStop_Controls(ListControl:array of tcontrol;TabStop:boolean);
Procedure CaptionMultiLigne(WinControl:TWincontrol);
Function ScreenAjuste800600_DefinitionCourante_Horizon(Pos:Integer):Integer;
Function ScreenAjuste800600_DefinitionCourante_Vertical(Pos:Integer):Integer;
Function ScreenAjuste_OldDef_DefinitionCourante_Horizon(OldScW,Pos:Integer):Integer;
Function ScreenAjuste_OldDef_DefinitionCourante_Vertical(OldScH,Pos:Integer):Integer;
Procedure ScreenAjuste_OldDef_DefinitionCourant(OldScw,OldSch:Integer;Form:TForm);
function GetCaptionSousSouris(CrPos: TPoint): string;
Function InitLisViewAvecListe(ListView:TListView ;TabTitreColonne:array of string;TabList:array of TStringList;ColonneRecherche:Boolean;Effacer:boolean=false):TStringList;
Function RemplitListEvenement(var ListeEvent:TStringList;Objet:TObject;ViderEvenement:Boolean):Boolean;
Function InitLisViewAvecListeCochable(ListView:TListView ;TabTitreColonne:array of string;TabList:array of TStringList;ListeLongueurChamp:array of integer;ColonneRecherche:Boolean;Effacer:boolean=false):TStringList;
implementation
uses
Ecriture_Isa,DMModifEcritures, DiversProjets;

var
Form:TFormLocale;

// PB le 15/06/04 Form1:TInfoComposant;
//******************************************************************************
// Vide tous les controles de saisie
// ZSaisie : tableau de zone de saisie
//******************************************************************************
procedure VideZoneSaisieTxt(Zsaisie : array of TControl);
var
i:integer;
buf:pchar;
begin
for I := 0 to High(Zsaisie) do begin
    buf:='';
    Zsaisie[i].SetTextBuf(buf);
    end;
end;

//******************************************************************************
// Initialise tous les controles de saisie avec la valeur '0' Zero
// ZSaisie : tableau de zone de saisie
//******************************************************************************
procedure VideZoneSaisieInt(Zsaisie : array of TCustomEdit);
var
i:integer;
begin
for I := 0 to High(Zsaisie) do Zsaisie[i].Text:='0';
end;

//******************************************************************************
// Rempli tous les controles avec les valeurs du tableau Valeurs
// ZSaisie : tableau de zone de saisie
// Valeurs : tableau des valeurs affecté dans les controles
//******************************************************************************
Procedure RempliChamp(Zsaisie : array of TControl; Valeurs : array of string);
var
i:integer;
Begin
    for I := 0 to High(Zsaisie) do Zsaisie[i].SetTextBuf(PChar(Valeurs[i]));
End;

//******************************************************************************
// Verifie si les TWinControl ont une valeur
// Retourne nil s'ils possèdent tous une valeur
// Si un WinControle n'a pas de valeur, la fonction le renvoi
// ZSaisie : tableau de zone de saisie
// Focus : si vrai, cela permet d'affecter automatiquement le focus au premier
// WinControle qui n'a pas de valeur, si Faux: Rien ne se passe
//******************************************************************************
function VerifZoneSaisie(ZSaisie : array of TWinControl;Focus:boolean):TWinControl;
Var
i:integer;
begin
result:=nil;
for I := 0 to High(Zsaisie) do
    begin
    if (trim((ZSaisie[i] as TCustomEdit).Text)='') then
       begin
       result :=(ZSaisie[i] as TWinControl);
       if Focus then (ZSaisie[i] as TWinControl).SetFocus;
       break;
       end;
    end;
end;

//******************************************************************************
// gère l'automatisation du + pour la saisie des comptes de tiers en fonction des options
// récupérées
//******************************************************************************
Function GestionAutomatisationDuPlusCompteTiers(Automatique,Defaut:boolean):boolean;
begin
///
end;

//******************************************************************************
// Retourne des informations sur un champ numerique
// sous le format TVarFNumeric
//******************************************************************************
Function VerifFNumeric(Champ:TField):TVarFNumeric;
Begin
if Champ = nil then
 begin
  showmessage('VerifFNumeric : Le champ est nil');
  abort;
 end;
result.TypeChamp:=Champ.DataType;
result.Vide:=false;
result.Zero:=False;
if champ.AsString='0' then
   Begin
    result.Vide:=false;
    result.Zero:=true;
    result.Pos:=false;
    result.neg:=false;
   End;
if champ.AsString='' then
   Begin
    result.Vide:=true;
    result.Zero:=False;
    result.Pos:=false;
    result.neg:=false;
   End;

if champ.AsString<>'' then
   Begin
    result.Vide:=False;
    if Champ.AsFloat=0 then result.Zero:=true else result.Zero:=false;
    if Champ.AsFloat>0 then
    Begin
    result.Pos:=True;
    result.neg:=false;
    End
     else
    Begin
    result.Pos:=false;
    result.neg:=True;
    End;
   End;

  case result.TypeChamp of
    ftInteger:Begin
               result.Ent:=true;
               result.Decimal:=false;
               result.Curr:=false;
              End;

    ftFloat:Begin
               result.Ent:=False;
               result.Decimal:=True;
               result.Curr:=false;
              End;

    ftCurrency:Begin
               result.Ent:=false;
               result.Decimal:=false;
               result.Curr:=true;
              End;
  else ;
  end;
Result.VideETZero:=((Result.Vide) and (Result.Zero));
Result.VideOUZero:=((Result.Vide) or (Result.Zero));
End;

//******************************************************************************
// Retourne des informations sur un champ numerique
// sous le format TVarFNumeric
//******************************************************************************
Function VerifNumeric(valeur:string):TVarNumeric;
var
valeurTrim:string;
Begin
result.Vide:=false;
result.Zero:=False;
valeurTrim:=StringReplace(valeur,#32,'',[rfReplaceAll]);
if valeur='0' then
   Begin
    result.Vide:=false;
    result.Zero:=true;
    result.Pos:=false;
    result.neg:=false;
   End;
if empty(valeur) then
   Begin
    result.Vide:=true;
    result.Zero:=False;
    result.Pos:=false;
    result.neg:=false;
   End;

if not empty(valeur) then
   Begin
    result.Vide:=False;
    try

      if StrToFloat(valeurTrim)=0 then result.Zero:=true else result.Zero:=false;
        if StrToFloat(valeurTrim)>0 then
          Begin
          result.Pos:=True;
          result.neg:=false;
          End
       else
          Begin
          result.Pos:=false;
          result.neg:=True;
          End;
    except
      try
        if StrToDate(valeur)=0 then result.zero:=true else result.zero:=false;
      except
        //
      end;
    end;//fin du try except
   End;

//  case result.TypeChamp of
//    ftInteger:Begin
//               result.Ent:=true;
//               result.Decimal:=false;
//               result.Curr:=false;
//              End;
//
//    ftFloat:Begin
//               result.Ent:=False;
//               result.Decimal:=True;
//               result.Curr:=false;
//              End;
//
//    ftCurrency:Begin
//               result.Ent:=false;
//               result.Decimal:=false;
//               result.Curr:=true;
//              End;
//  else ;
//  end;
Result.VideETZero:=((Result.Vide) and (Result.Zero));
Result.VideOUZero:=((Result.Vide) or (Result.Zero));
End;

//******************************************************************************
// Vérifie si un compte est vide ou pas, s'il a bonne syntaxe
// sous le format TNumCompte
// Deux message possible :
//              mes1 : indique qu'un compte ne peut pas commencer par zero
//              mes2 : indique qu'un compte ne peut pas commencer par 8 ou 9
//******************************************************************************
Function VerifNumCptIntegrite(cpt:string;mes1,mes2:boolean):TNumCompte;
Var
i :Integer;
CptAux:string;
Begin
Result.CptBon:= '';
Result.vide:=(cpt='');
Result.Classe:=0;
// Verification qu'il n'y ait que des chiffres
CptAux:='';
if not Result.vide then For i:= 1 to Length(Cpt) do if (Cpt[i] in ['0'..'9']) then CptAux:=CptAux + Cpt[i];
if cpt<>cptAux then
   begin
    Result.vide:=true;
    showmessage('La valeur saisie "'+ Cpt + '" ne peut pas être un numéro de compte !');
    abort;
   end;
// Verification que les chiffres soit correct (ne commence ni par 0, 8, 9)
   if cpt<>'' then
   For i:= 1 to Length(Cpt) do begin
      case i of
         1:begin
            Result.Classe:=StrToInt(cpt[i]);
            case ord(cpt[i]) of
           {0}48:begin
                 if mes1 then Application.messagebox(Pchar('Vous avez saisi : '+cpt+' .'+#10#13#10#13+'Les numéros du plan comptable ne peuvent pas commencer par 0.'),'Erreur de saisie',0);
                end ;
      {8,9}56,57:begin
                 if mes2 then Application.messagebox(Pchar('Vous avez saisi : '+cpt+' .'+#10#13#10#13+'Ces numéros du plan comptable ne sont pas encore prévu.'),'Erreur de saisie',0);
                end  ;
            else begin
                   if (Cpt[i] in ['0'..'9']) then Result.CptBon:= Result.CptBon + Cpt[i];
                 end;
            end;
           end;
      else
   	  if (Cpt[i] in ['0'..'9']) then Result.CptBon:= Result.CptBon + Cpt[i];
      end;
   end;

end;

//******************************************************************************
//Permet de se déplacer au controle suivant
// Suivant : boolean, si vrai, controle suivant, sinon, controle précédent
//******************************************************************************
Procedure WinSuivPrec(Handle:integer;key:word;WExclus : array of TWinControl);
var
i:integer;
Begin
for i:=0 to high(WExclus) do
  if WExclus[i] <> nil then
     begin
       if WExclus[i].Focused then exit;
       if (WExclus[i]=screen.ActiveControl) then exit;
     end;

   case Key of
     VK_DOWN,VK_RETURN:begin
                         PostMessage(Handle,WM_NEXTDLGCTL,0,0);
                       end;

     VK_UP:begin
             PostMessage(Handle,WM_NEXTDLGCTL,-1,0);
          end;
   end;
End;

Procedure WinShape(WinControl:TWincontrol;Shape1,Shape2:TShape;Couleur:TColor);
Begin
if (WinControl as TWincontrol)=nil then exit;
WinShape(WinControl,Shape1,Shape2,Couleur,(WinControl as TWincontrol).TabStop);
end;

Procedure WinShape(WinControl:TWincontrol;Shape1,Shape2:TShape;Couleur:TColor;TabStopParam:boolean);
Begin
//if(not ParamUtil.FocusDesactive)then
//  begin
//    if (WinControl as TWincontrol)=nil then exit;
//    //if (WinControl.ClassNameIs('TGroupButton')) then exit;
//    //if (WinControl as TWincontrol).parent=nil then exit;
//    if Shape1=nil then exit;
//    if Shape2=nil then exit;
//    if Shape1.ControlState =[csDestroyingHandle] then exit;
//    if Shape2.ControlState =[csDestroyingHandle] then exit;
//    //if Shape1=nil then Shape1:=TShape.Create(Application.MainForm);
//    //if Shape2=nil then Shape2:=TShape.Create(Application.MainForm);
//    with (WinControl as TWincontrol) do
//     begin
//         //if TabStopParam=false then exit;
//         try
//            Shape1.Parent:=Parent;
//            Shape2.Parent:=Parent;
//         except
//         on EInvalidPointer do
//         begin
//             try
//            Shape1.Parent:=Application.MainForm;
//            Shape2.Parent:=Application.MainForm;
//             except
//              on EInvalidPointer do
//              begin
//                Shape1.Free;
//                Shape1:=nil;
//                Shape2.Free;
//                Shape2:=nil;
//                 abort;
//              end;
//             end;
//          end;
//         end;
//    //     Shape1.Parent:=Parent;
//         Shape1.Brush.Style:=bsClear;
//         Shape1.Pen.Color:=Couleur;
//         Shape1.Pen.Style:=psSolid;
//         Shape1.Pen.Width:=2;
//         Shape1.Shape:=stRoundRect;
//         if (WinControl IS TTreeView) then Shape1.Shape:=stRectangle;
//         if (WinControl IS TGrGrid) then Shape1.Shape:=stRectangle;
//         if (WinControl IS TCustomDBGrid) then Shape1.Shape:=stRectangle;
//         if (WinControl IS TCustomPanel) then Shape1.Shape:=stRectangle;
//         if (WinControl IS TListBox) then Shape1.Shape:=stRectangle;
//         if (WinControl IS TCustomTabControl) then Shape1.Shape:=stRectangle;
//         if (WinControl IS TListView) then Shape1.Shape:=stRectangle;
//         if (WinControl IS TDBRadioGroup) then Shape1.Shape:=stRectangle;
//         if (WinControl.ClassNameIs('TGroupButton')) then Shape1.Shape:=stRectangle;
//         if (WinControl.ClassNameIs('TRxCheckListBox')) then Shape1.Shape:=stRectangle;
//         Shape1.Left:=left-2;
//         Shape1.top:=Top-2;
//         Shape1.Height:=Height+4;
//         Shape1.Width:=Width+4;
//    //     try
//    //     Shape2.Parent:=Parent;
//    //     except
//    //      try
//    //     Shape2.Parent:=Application.MainForm;
//    //      except
//    //      Shape1.Free;
//    //      Shape1:=nil;
//    //      Shape2.Free;
//    //      Shape2:=nil;
//    //       abort;
//    //      end;
//    //     end;
//         Shape2.Brush.Style:=bsClear;
//         Shape2.Pen.Color:=clBlack;
//         Shape2.Pen.Style:=psSolid;
//         Shape2.Pen.Width:=1;
//         Shape2.Shape:=stRoundRect;
//         Shape2.Left:=left-3;
//         Shape2.top:=Top-3;
//         Shape2.Height:=Height+6;
//         Shape2.Width:=Width+6;
//         if (WinControl IS TTreeView) then Shape2.Shape:=stRectangle;
//         if (WinControl IS TGrGrid) then Shape2.Shape:=stRectangle;
//         if (WinControl IS TCustomDBGrid) then Shape2.Shape:=stRectangle;
//         if (WinControl IS TCustomPanel) then Shape2.Shape:=stRectangle;
//         if (WinControl IS TListBox) then Shape2.Shape:=stRectangle;
//         if (WinControl IS TCustomTabControl) then Shape2.Shape:=stRectangle;
//         if (WinControl IS TListView) then Shape2.Shape:=stRectangle;
//         if (WinControl IS TDBRadioGroup) then Shape2.Shape:=stRectangle;
//         if (WinControl.ClassNameIs('TGroupButton')) then Shape2.Shape:=stRectangle;
//         if (WinControl.ClassNameIs('TRxCheckListBox')) then Shape2.Shape:=stRectangle;
//     end;
//  end;
End;

Procedure BoutonRXAgrandit(Boutton:TRxSpeedButton);
Begin
with (Boutton as TRxSpeedButton) do
 begin
  top:=top-3;
  left:=left-3;
  width:=width+6;
  height:=height+6;
 end;
End;

Procedure BoutonRXDiminue(Boutton:TRxSpeedButton);
Begin
with (Boutton as TRxSpeedButton) do
 begin
  top:=top+3;
  left:=left+3;
  width:=width-6;
  height:=height-6;
 end;
end;

Procedure BouttonAgrandit(Boutton:TButton);
Begin
with (Boutton as tbutton) do
 begin
  top:=top-3;
  left:=left-3;
  width:=width+6;
  height:=height+6;
 end;
End;

Procedure BouttonDiminue(Boutton:TButton);
Begin
with (Boutton as tbutton) do
 begin
  top:=top+3;
  left:=left+3;
  width:=width-6;
  height:=height-6;
 end;

End;

Procedure WinRxLabTab(Labels: array of TGraphicControl;CouleurLabel,CouleurShadow:TColor);
var
i:integer;
Begin
for i:=0 to high(Labels) do
  WinRxLab(Labels[i],CouleurLabel,CouleurShadow);
End;


Procedure WinRxLab(Labels:TGraphicControl;CouleurLabel,CouleurShadow:TColor);
Begin
if Labels <> nil then
 begin
    if labels.ClassNameIs('TLabel') then
       Begin
    //    if CouleurLabel <> nil then
        (Labels as TLabel).Font.Color:=CouleurLabel;
       End;

    if labels.ClassNameIs('TRxLabel') then
       Begin
    //    if CouleurLabel <> nil then
        (Labels as TRxLabel).Font.Color:=CouleurLabel;
    //    if CouleurSHadow <> nil then
        (Labels as TRxLabel).ShadowColor:=CouleurSHadow;
       End;
end;

End;

// Initialise les colonnes d'une grille
Procedure GrDbGridInitColonne(var GrDbGrille:TGrDbGrid;DataSource:TDataSource;DataSet:TDataSet;TitreColonne,NomChamp : array of String;FormatMonnaie,EditFormat:String);
var
NotifyEvent:TNotifyEvent;
j:integer;
Begin
GrDbGrille.DataSource:=nil;
GrDbGrille.Columns.RebuildColumns;
NotifyEvent:=DataSource.OnStateChange;
DataSource.OnStateChange:=nil;
if DataSet.Active then DataSet.Close;
DataSource.DataSet:=DataSet;
GrDbGrille.DataSource:=DataSource;
case RecupClassTypeComponent(DataSet) of
   GTQuery:Begin
           //DataSet.Open; { isa  le  20/08/04 }
           DataSet.Open; { isa  le  01/06/05 }
           FormateMonnaieField(DataSource.DataSet,FormatMonnaie,EditFormat);
           for j:=0 to high(NomChamp) do
            Begin
            if DataSource.DataSet.FindField(NomChamp[j]) <> nil then
             begin
              GrDbGrille.Columns.Add.Field:=DataSource.DataSet.FindField(NomChamp[j]);
             end;
            End;

           for j:=0 to high(NomChamp) do
            Begin
            if DataSource.DataSet.FindField(NomChamp[j]) <> nil then
             begin
              GrDbGrille.Columns[j].Title.Caption:=TitreColonne[j];
              case RecupClassTypeComponent(DataSource.DataSet.FindField(NomChamp[j])) of
                 GTFieldCurr:GrDbGrille.Columns[j].Title.Alignment:=taRightJustify;
//                 : ;
              end;

             end;
            End;
            FormateMonnaieField(DataSet,FormatMonnaie,EditFormat);

           End;

   GTable: Begin
           //DataSet.Open; { isa  le  20/08/04 }
           for j:=0 to high(NomChamp) do
            Begin
//            showmessage(IntToSTr(j));
            if DataSource.DataSet.FindField(NomChamp[j]) <> nil then
             begin
              GrDbGrille.Columns.Add.Field:=DataSource.DataSet.FindField(NomChamp[j]);
             end;
            End;

           for j:=0 to high(NomChamp) do
            Begin
            if DataSource.DataSet.FindField(NomChamp[j]) <> nil then
             begin
              GrDbGrille.Columns[j].Title.Caption:=TitreColonne[j];
              case RecupClassTypeComponent(DataSource.DataSet.FindField(NomChamp[j])) of
                 GTFieldCurr:GrDbGrille.Columns[j].Title.Alignment:=taRightJustify;
//                 : ;
              end;
             end;
            End;
            FormateMonnaieField(DataSource.DataSet,FormatMonnaie,EditFormat);
           End;

end;
if not DataSource.DataSet.Active then DataSource.DataSet.Open;
GrDbGrille.DataSource.Enabled:=true;
DataSource.OnStateChange:=NotifyEvent;
//
End;

Procedure GrDbGridInitCouleur(GrDbGrille:TGrDbGrid;Param:TVarColorGrid);
Begin
GrDbGrille.HighlightColor:=Param.CelActiveColorFond;
GrDbGrille.HighlightFontColor:=Param.CelActiveColorFont;
// Param.CelActiveContour;
GrDbGrille.InplaceEditColor:=Param.CelActiveSAisieColorFond;
GrDbGrille.InplaceEditColorFont:=Param.CelActiveSAisieColorFont;
GrDbGrille.FixedColor:=Param.CelFixeColorFond;
GrDbGrille.TitleFont.Color:=Param.CelFixeColorFont;
GrDbGrille.Color:=Param.GrilleColorFond;
GrDbGrille.Font.Color:=Param.GrilleColorFont;
//                 Param.LigneContour;

//
End;

Function RenvoiTailleColonne(GrDbGrille:TGrDbGrid;IndexColonnes:array of Integer):Integer;
var
i:integer;
Begin
result:=0;
try
For I := 0 to High(IndexColonnes) do
    begin
     result:=GrDbGrille.ColWidths[IndexColonnes[I]]+result;
    end;
except
abort;
end;
End;



Function RenvoiTailleColonne_GrGrid(GrGrille:TGrGrid;IndexColonnes:array of Integer):Integer;
var
i:integer;
Begin
result:=0;
try
For I := 0 to High(IndexColonnes) do
    begin
     result:=GrGrille.ColWidths[IndexColonnes[I]]+result;
    end;
except
abort;
end;
End;


Function RenvoiTailleColonneListView(ListView:TListView;IndexColonnes:array of Integer):Integer;
var
i:integer;
Begin
result:=0;
try
For I := 0 to High(IndexColonnes) do
    begin
     result:=ListView.Column[IndexColonnes[I]].Width+result;
    end;
except
abort;
end;
End;

Procedure FormateTailleColonne(GrDbGrille:TGrDbGrid;NombreDePartie:Integer;ProportionPartie:array of Integer);
var
i:integer;
Begin
  try
    if GrDbGrille.Columns.Count > 0 then
    For I := 0 to High(ProportionPartie) do
        begin
         GrDbGrille.ColWidths[I+1]:=(((GrDbGrille.Width) div NombreDePartie)*ProportionPartie[I]);
        end;
  except
    abort;
  end;
End;

Procedure FormateTailleBoutton(Boutton:array of TControl;PanelPere:TPanel;LargeurBoutton,HauteurBoutton:integer);
var
i:integer;
Begin
Boutton[0].Cursor:=crHandPoint;
Boutton[0].Left:=(PanelPere.Width-((High(Boutton)+1)*LargeurBoutton)) div 2;
if Boutton[0].ClassNameIs('TButton') then LargeurBoutton:=LargeurBoutton-1;
Boutton[0].Width:=LargeurBoutton;
if HauteurBoutton > 0 then
   Boutton[0].Height:=HauteurBoutton
   else
   if HauteurBoutton < 0 then
   Boutton[0].Top:=-HauteurBoutton;
For I := 1 to High(Boutton) do
    begin
    Boutton[I].Cursor:=crHandPoint;
     Boutton[I].Width:=LargeurBoutton;
     Boutton[I].Left:=Boutton[0].Left + ((LargeurBoutton) *I);
     if HauteurBoutton > 0 then
        Boutton[I].Height:=HauteurBoutton
        else
        if HauteurBoutton < 0 then
             Boutton[I].Top:=-HauteurBoutton;
    end;
End;


Procedure FormateTailleBouttonAvecEspace(Boutton:array of TControl;PanelPere:TPanel;LargeurBoutton,HauteurBoutton:integer;EspaceBouton:integer);
var
i:integer;
Begin
Boutton[0].Cursor:=crHandPoint;
Boutton[0].Left:=(PanelPere.Width-((High(Boutton)+1)*LargeurBoutton+EspaceBouton)) div 2;
if Boutton[0].ClassNameIs('TButton') then LargeurBoutton:=LargeurBoutton-1;
Boutton[0].Width:=LargeurBoutton;
if HauteurBoutton > 0 then
   Boutton[0].Height:=HauteurBoutton
   else
   if HauteurBoutton < 0 then
   Boutton[0].Top:=-HauteurBoutton;
For I := 1 to High(Boutton) do
    begin
     Boutton[I].Cursor:=crHandPoint;
     Boutton[I].Width:=LargeurBoutton;
     Boutton[I].Left:=Boutton[0].Left + ((LargeurBoutton+EspaceBouton) *I);
     if HauteurBoutton > 0 then
        Boutton[I].Height:=HauteurBoutton
        else
        if HauteurBoutton < 0 then
             Boutton[I].Top:=-HauteurBoutton;
    end;
End;


procedure ConstruitPopMenu(index:integer;Caption:string;PopMenu: TMenuItem;Form:TForm;NotifyEvent:TNotifyEvent);
var
ItemAux:TMenuItem;
begin
//if(Form<>nil)then
//  begin
//      ItemAux:=TMenuItem.Create(Form);
//      ItemAux.Caption:=Caption;
//      ItemAux.Tag:=index;
//      ItemAux.Name:=inttostr(PopMenu.Count);
//      //ItemAux.Checked:=true;
//      ItemAux.OnClick:=NotifyEvent;
//      PopMenu.Insert(index,ItemAux);
//  end;
end;

Function ModifiePopMenu(IndexPosition:Integer;Libelle:String;IdImage:Integer;ImageList:TImageList;MenuPere:TMenuItem):TMenuItem;
Begin
MenuPere.Items[IndexPosition].Caption :=Libelle;
MenuPere.Items[IndexPosition].SubMenuImages := ImageList;
MenuPere.Items[IndexPosition].ImageIndex :=IdImage;
End;



Procedure PopMenuVersPopUpMenu(PopMenu:TMenuItem;PopUpMenu:TPopUpMenu);
var
i:integer;
MenuAux:TMenuItem;
begin
while PopUpMenu.Items.Count > 0 do
PopUpMenu.Items.Delete(0);
for i:=0 to PopMenu.Count-1 do
 begin
  MenuAux:=TMenuItem.Create(application.MainForm);
  MenuAux.Caption:=PopMenu.Items[i].Caption;
  MenuAux.OnClick:=PopMenu.Items[i].OnClick;
  PopUpMenu.Items.Add(MenuAux);
 end;

HiliteMenuItem(PopUpMenu.WindowHandle,PopUpMenu.Handle,PopMenu.Items[0].Handle,MF_BYPOSITION and MF_HILITE);
//PopUpMenu.Items.MenuIndex:=0;
end;

Function SommeColonne(Grille:TStringGrid;Col,RowDeb,RowFin:Integer):Variant;
Var
i:Integer;
Total:Extended;
Begin
Total:=0;
for i:=RowDeb to RowFin do
 Begin
  try
   if not empty(Grille.Cells[Col,i]) then
   Total:=Total+StrToCurr_Lgr(Grille.Cells[Col,i]);
  except
  end;
 End;
Result:=Total;
//
End;

Function SommeColonneListView(Grille:TListView;Col,RowDeb,RowFin:Integer):Variant;
Var
i:Integer;
Total:Extended;
Begin
Total:=0;
for i:=RowDeb to RowFin do
 Begin
  try
   if not empty(Grille.Items[i].SubItems[col]) then
   Total:=Total+StrToCurr_Lgr(Grille.Items[i].SubItems[col]);
  except
  end;
 End;
Result:=Total;
//
End;

Function SommeColonneFormate(Grille:TStringGrid;Col,RowDeb,RowFin:Integer):Variant;
Var
i:Integer;
Total:Extended;
TotTmp:string;
Begin
Total:=0;
for i:=RowDeb to RowFin do
 Begin
  try
   if not empty(Grille.Cells[Col,i]) then
     Begin
        TotTmp:=QueDesChiffres(trim(Grille.Cells[Col,i]));
       Total:=Total+StrToFloat(TotTmp);
     End;
  except
  end;
 End;
Result:=Total;
//
End;

Function TraiteMotCle(TexteATraiter:string;const DonneesVar:array of string):string;
Var
MotClef,SubString:String;
I:integer;
begin
Result:='';
i:=0;
while pos('<',TexteATraiter) > 0 do
 Begin
   MotClef:=copy(TexteATraiter,pos('<',TexteATraiter)+1,pos('>',TexteATraiter)-pos('<',TexteATraiter)-1);
   SubString:=MotClef;
   MotClef:=allTrim(MotClef);
   IF UpperCase(MotClef)='DATE' then
                     Begin
                      Result:=Result+Copy(TexteATraiter,1,pos('<',TexteATraiter)-1)+ DateToStr(Date);
                     End;
   IF UpperCase(MotClef)='MOIS' then
                     Begin
                      Result:=Result+Copy(TexteATraiter,1,pos('<',TexteATraiter)-1)+ DAteInfos(DAte).MoisStr;
                     End;
   IF UpperCase(MotClef)='JOUR' then
                     Begin
                      Result:=Result+Copy(TexteATraiter,1,pos('<',TexteATraiter)-1)+ DAteInfos(DAte).JourStr;
                     End;
   IF UpperCase(MotClef)='ANNEE' then
                     Begin
                      Result:=Result+Copy(TexteATraiter,1,pos('<',TexteATraiter)-1)+ DAteInfos(DAte).AnStr;
                     End;
   IF UpperCase(MotClef)='LMOIS' then
                     Begin
                      Result:=Result+Copy(TexteATraiter,1,pos('<',TexteATraiter)-1)+ MoisStr(DAte);
                     End;
   IF UpperCase(MotClef)='LJOUR' then
                     Begin
                      Result:=Result+Copy(TexteATraiter,1,pos('<',TexteATraiter)-1)+ JourStr(DAyOfWeek(DAte));
                     End;
   IF UpperCase(MotClef)='LANNEE' then
                     Begin
                      Result:=Result+Copy(TexteATraiter,1,pos('<',TexteATraiter)-1)+ DAteInfos(DAte).AnStr;
                     End;
   IF UpperCase(MotClef)='NOMBRE' then
                     Begin
//                      if High(DonneesVar) >0 then
                       if DonneesVar[0] <> NULL then
                        begin
                          Result:=Result+Copy(TexteATraiter,1,pos('<',TexteATraiter)-1)+ DonneesVar[i];
                          inc(i);
                        end;
                     End;
   IF UpperCase(MotClef)='MONTANT' then
                     Begin
//                      if High(DonneesVar) >0 then
                       if DonneesVar[0] <> NULL then
                        begin
                          Result:=Result+Copy(TexteATraiter,1,pos('<',TexteATraiter)-1)+ DonneesVar[i]+' '+E.DeviseSigle;
                          inc(i);
                        end;
                     End;

   delete(TexteATraiter,1,pos('>',TexteATraiter));
 End;
Result:=Result+TexteATraiter;
end;

PRocedure CouleurFond(Zsaisie : array of TControl;CouleurFond:TColor);
var
i:integer;
begin
for I := 0 to High(Zsaisie) do
 begin
      case RecupClassTypeComponent(TControl(Zsaisie[i]))of
//      0:if (Zsaisie[i] is TWincontrol) then (Zsaisie[i] as TWincontrol).color:=CouleurFond;

      GTDBEdit:(Zsaisie[i] as TDBEdit).color:=CouleurFond;
      GTGrGrid:TGrgrid(Zsaisie[i]).color:=CouleurFond;
      GTStringGrid:TStringGrid(Zsaisie[i]).color:=CouleurFond;
      GTGrDBGrid:TGrDBGrid(Zsaisie[i]).color:=CouleurFond;
      GTLabel:TLabel(Zsaisie[i]).color:=CouleurFond;
      GTDBRadioGroup:TDBRadioGroup(Zsaisie[i]).color:=CouleurFond;
      GTRxDBComboEdit:TRxDBComboEdit(Zsaisie[i]).color:=CouleurFond;
      GTDBCheckBox:TDBCheckBox(Zsaisie[i]).color:=CouleurFond;
      GTCurrencyEdit:TCurrencyEdit(Zsaisie[i]).color:=CouleurFond;
      GTEdit:TEdit(Zsaisie[i]).color:=CouleurFond;
      GTRxLabel:TRxLabel(Zsaisie[i]).color:=CouleurFond;
      GTPanel:TPanel(Zsaisie[i]).color:=CouleurFond;
      end;//fin du case
 end;
end;

Procedure CouleurActivecontrolLabel(CouleurFondActiveControl:TColor;LabelAssocie:TGraphicControl;CouleurLabel,CouleurShadow:TColor);
Begin
CouleurFond([Screen.ActiveControl],CouleurFondActiveControl);
WinRxLab(LabelAssocie,CouleurLabel,CouleurShadow);
End;

Procedure CouleurDeActivecontrolLabel(Control:TControl;CouleurFondActiveControl:TColor;LabelAssocie:TGraphicControl;CouleurLabel,CouleurShadow:TColor);
Begin
CouleurFond([Control],CouleurFondActiveControl);
WinRxLab(LabelAssocie,CouleurLabel,CouleurShadow);
End;

Function DetruitTouteForm(FormExclu:Array of TForm):boolean;
var
i,j:integer;
EstExclu:boolean;
ListeForm:TStringList;
Begin
 result:=true;
 ListeForm:=TStringList.Create;

 //Construction de la liste des forms actuellement créées
 for i:=0 to screen.FormCount-1 do
          ListeForm.AddObject(Screen.Forms[i].Name,Screen.Forms[i]);
 //suppression de la liste des forms à exclure de la destruction.
 for i:=0 to high(FormExclu) do
  begin
   j:=-1;
   j:=ListeForm.IndexOfObject(FormExclu[i]);
   if j <> - 1 then ListeForm.Delete(j);
  end;

 i:=ListeForm.Count-1;

 // Tant qu'il reste des forms à détruire dans la liste ...
 while ListeForm.Count > 0 do
   Begin
    try
     // Traite l'évènement CloseQuery de la form parcourue
     // Si CloseQuery est défini
     if @(ListeForm.Objects[ListeForm.Count-1] as TForm).OnCloseQuery <> nil then
       begin
        // Si CloseQuery renvoi true
        if (ListeForm.Objects[ListeForm.Count-1] as TForm).CloseQuery then
          begin
            (ListeForm.Objects[ListeForm.Count-1] as TForm).Release;
            ListeForm.Delete(ListeForm.Count-1);
          end
           else
          // Si CloseQuery renvoi false
          begin
           //showmessage('L''objet : ' + ListeForm.Strings[ListeForm.Count-1]+' à mal été libéré !');
           result:=false;
           exit;
           ListeForm.Free;
          end;
       end
        else
     // Si CloseQuery n'est pas défini
       begin
//         showmessage('Erreur interne : L''objet : ' + ListeForm.Strings[ListeForm.Count-1]+' n''a pas de CloseQuery !');
        (ListeForm.Objects[ListeForm.Count-1] as TForm).Release;
        ListeForm.Delete(ListeForm.Count-1);
       end;
    except
     showmessage('Erreur interne : L''objet : ' + ListeForm.Strings[ListeForm.Count-1]+' à mal été libéré !');
     result:=false;
     exit;
     ListeForm.Free;
    end;
  End;
ListeForm.Free;
End;


Function DetruitTouteFormNonShowModal(FormExclu:Array of TForm):boolean;
var
i,j:integer;
EstExclu:boolean;
ListeForm:TStringList;
Begin
 result:=true;
 ListeForm:=TStringList.Create;

 //Construction de la liste des forms actuellement créées
 for i:=0 to screen.FormCount-1 do
 if not(fsModal in Screen.Forms[i].FormState )then
          ListeForm.AddObject(Screen.Forms[i].Name,Screen.Forms[i]);
 //suppression de la liste des forms à exclure de la destruction.
 for i:=0 to high(FormExclu) do
  begin
   j:=-1;
   j:=ListeForm.IndexOfObject(FormExclu[i]);
   if j <> - 1 then ListeForm.Delete(j);
  end;

 i:=ListeForm.Count-1;

 // Tant qu'il reste des forms à détruire dans la liste ...
 while ListeForm.Count > 0 do
   Begin
    try
     // Traite l'évènement CloseQuery de la form parcourue
     // Si CloseQuery est défini
     if @(ListeForm.Objects[ListeForm.Count-1] as TForm).OnCloseQuery <> nil then
       begin
        // Si CloseQuery renvoi true
        if (ListeForm.Objects[ListeForm.Count-1] as TForm).CloseQuery then
          begin
            (ListeForm.Objects[ListeForm.Count-1] as TForm).Release;
          (ListeForm.Objects[ListeForm.Count-1] as TForm).Free;
            ListeForm.Delete(ListeForm.Count-1);
          end
           else
          // Si CloseQuery renvoi false
          begin
           //showmessage('L''objet : ' + ListeForm.Strings[ListeForm.Count-1]+' à mal été libéré !');
           result:=false;
           exit;
           ListeForm.Free;
          end;
       end
        else
     // Si CloseQuery n'est pas défini
       begin
//         showmessage('Erreur interne : L''objet : ' + ListeForm.Strings[ListeForm.Count-1]+' n''a pas de CloseQuery !');
        (ListeForm.Objects[ListeForm.Count-1] as TForm).Release;
        (ListeForm.Objects[ListeForm.Count-1] as TForm).Free;
        ListeForm.Delete(ListeForm.Count-1);
       end;
    except
     showmessage('Erreur interne : L''objet : ' + ListeForm.Strings[ListeForm.Count-1]+' à mal été libéré !');
     result:=false;
     exit;
     ListeForm.Free;
    end;
  End;
ListeForm.Free;
End;


// Detruit tout les datamodule appartenant TScreen
Function DetruitTousDataModule(DMExclu:Array of TDataModule):boolean;
var
i,j:integer;
EstExclu:boolean;
ListeDM:TStringList;
Begin
 result:=true;
 ListeDM:=TStringList.Create;

 //Construction de la liste des DataModules actuellement créées
 for i:=0 to screen.DataModuleCount-1 do
          ListeDM.AddObject(Screen.DataModules[i].Name,Screen.DataModules[i]);
 //suppression de la liste des DataModules à exclure de la destruction.
 for i:=0 to high(DMExclu) do
  begin
   j:=-1;
   j:=ListeDM.IndexOfObject(DMExclu[i]);
   if j <> - 1 then ListeDM.Delete(j);
  end;

 i:=ListeDM.Count-1;

 // Tant qu'il reste des forms à détruire dans la liste ...
 while ListeDM.Count > 0 do
   Begin
    try
      (ListeDM.Objects[ListeDM.Count-1] as TDataModule).Free;
      ListeDM.Delete(ListeDM.Count-1);
    except
     result:=false;
     exit;
     ListeDM.Free;
    end;
   end;
ListeDM.Free;
End;

Function CreationDataModule(TabDataModule:Array of TDataModule;TabClasse:array of TClass):boolean;
var
i,j:integer;
Begin
 for i:=0 to high(TabDataModule) do
  begin
//     Application.CreateForm((TabClasse[i] as TClass), (TabDataModule[i] as TDataModule));
//   (ListeDM.Objects[ListeDM.Count-1] as TDataModule):=(ListeDM.Objects[ListeDM.Count-1] as TDataModule).
  end;
End;

Procedure FormateMonnaie(CurrEdit:Array of TCurrencyEdit;FormatMonnaie:string);
var
i:integer;
Begin
for i:=0 to high(CurrEdit) do
 begin
  CurrEdit[i].DisplayFormat:=FormatMonnaie;
 end;
End;



Function AfficheInfoComposant(Mess:string;composant:TComponent;Affiche:boolean):TStringList;
var
i,Index:integer;
ChaineInfos:TstringList;
ListeBox:TListBox;
RetourChar:string;
Classes:TClass;
Begin
//TControl(Zsaisie[i]);Zsaisie[i]
result:=TStringList.Create;
RetourChar:='';
//RetourChar:=RetourChariotSimple;
ListeBox:=TListBox.Create(Form);
   if form = nil then
      Form:=TFormLocale.CreateNew(application.MainForm);
      Form.OnKeyDown:=Form.FormKeyDown;
      Form.Position:=poScreenCenter;
      Form.KeyPreview:=true;
      Form.Height:=screen.Height-50;
      ListeBox.Align:=alClient;
      ListeBox.Parent:=form;
i:=0;
ChaineInfos:=TstringList.Create;
ChaineInfos.Clear;//
ChaineInfos.Add(Mess+RetourChar);
i:=RecupClassTypeComponent(TControl(composant));
case i of
//      GTDBEdit:(Zsaisie[i] as TDBEdit).color:=CouleurFond;
//      GTGrGrid:TGrgrid(Zsaisie[i]).color:=CouleurFond;
   GTEcriture:begin
                (composant as Tecriture).RemplissageListeSurEcriture(ListeBox);
              end;
   GTTimer:begin
             ListeBox.items.add('Infos Timer'+RetourChar);
             ListeBox.items.add('Nom = '+(composant as TTimer).Name+RetourChar);
             ListeBox.items.add('Enabled = '+str_bool2str((composant as TTimer).enabled)+RetourChar);
             ListeBox.items.add('Interval = '+inttostr((composant as TTimer).Interval)+RetourChar);
             ListeBox.items.add('Tag = '+inttostr((composant as TTimer).Tag)+RetourChar);
           end;
   GTable:Begin
             ListeBox.items.add('Infos TABLE'+RetourChar);
             ListeBox.items.add('Nom = '+(composant as TTable).Name+RetourChar);
             ListeBox.items.add('DataBaseName = '+(composant as TTable).DatabaseName+RetourChar);
             ListeBox.items.add('Active = '+str_bool2str((composant as TTable).Active)+RetourChar);
             if (composant as TTable).DataSource <> nil then
             ListeBox.items.add('DataSource = '+(composant as TTable).DataSource.Name+RetourChar)
             else ListeBox.items.add('DataSource = Nil'+RetourChar);
             ListeBox.items.add('Table Name = '+ (composant as TTable).TableName);
             if (composant as TTable).Active
                 then
                  ListeBox.items.add('RecordCount = '+ IntTostr((composant as TTable).RecordCount)+RetourChar)
                 else
                  ListeBox.items.add('RecordCount = Table Inactive'+RetourChar);

             ListeBox.items.add('Filtre = '+(composant as TTable).Filter+RetourChar);
             ListeBox.items.add('Filtrée = '+str_bool2str((composant as TTable).Filtered)+RetourChar);
             case (composant as TTable).State of
                dsinactive:ListeBox.items.add('Etat = dsinactive'+RetourChar);
                dsBrowse:ListeBox.items.add('Etat = dsBrowse'+RetourChar);
                dsEdit:ListeBox.items.add('Etat = dsEdit'+RetourChar);
                dsInsert:ListeBox.items.add('Etat = dsInsert'+RetourChar);
             end;
             ListeBox.items.add('NOM ET VALEUR DES CHAMPS : ');
             ListeBox.items.add('------------------------------');
             if (composant as TTable).Active
                 then
                 begin
                 for Index:=0 to (composant as TTable).FieldCount-1 do
                  begin
                    ListeBox.items.add('NOM CHAMP = '+ (composant as TTable).Fields[Index].FieldName+RetourChar);
                    ListeBox.items.add('VALEUR = '+(composant as TTable).Fields[Index].Text+RetourChar);
                    ListeBox.items.add('READONLY = '+str_bool2str((composant as TTable).Fields[Index].ReadOnly)+RetourChar);
                 end;
                 end
                 else
                  ListeBox.items.add('NOM ET VALEUR DES CHAMPS : Table Inactive'+RetourChar);

                  ListeBox.items.add('LISTE DES EVENEMENTS'+RetourChar);

                  ListeBox.items.add('AfterCancel = '+(composant as TTable).Owner.MethodName(@(composant as TTable).AfterCancel));
                  ListeBox.items.add('AfterClose = '+(composant as TTable).Owner.MethodName(@(composant as TTable).AfterClose));
                  ListeBox.items.add('AfterDelete = '+(composant as TTable).Owner.MethodName(@(composant as TTable).AfterDelete));
                  ListeBox.items.add('AfterEdit = '+(composant as TTable).Owner.MethodName(@(composant as TTable).AfterEdit));
                  ListeBox.items.add('AfterInsert = '+(composant as TTable).Owner.MethodName(@(composant as TTable).AfterInsert));
                  ListeBox.items.add('AfterOpen = '+(composant as TTable).Owner.MethodName(@(composant as TTable).AfterOpen));
                  ListeBox.items.add('AfterPost = '+(composant as TTable).Owner.MethodName(@(composant as TTable).AfterPost));
                  ListeBox.items.add('AfterScroll = '+(composant as TTable).Owner.MethodName(@(composant as TTable).AfterScroll));
                  ListeBox.items.add('BeforeCancel = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforeCancel));
                  ListeBox.items.add('BeforeClose = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforeClose));
                  ListeBox.items.add('BeforeDelete = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforeDelete));
                  ListeBox.items.add('BeforeEdit = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforeEdit));
                  ListeBox.items.add('BeforeInsert = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforeInsert));
                  ListeBox.items.add('BeforeOpen = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforeOpen));
                  ListeBox.items.add('BeforePost = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforePost));
                  ListeBox.items.add('BeforeScroll = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforeScroll));
                  ListeBox.items.add('OnCalcFields = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnCalcFields));
                  ListeBox.items.add('OnDeleteError = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnDeleteError));
                  ListeBox.items.add('OnEditError = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnEditError));
                  ListeBox.items.add('OnFilterRecord = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnFilterRecord));
                  ListeBox.items.add('OnNewRecord = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnNewRecord));
                  ListeBox.items.add('OnPostError = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnPostError));
//                  ListeBox.items.add('OnServerYield = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnServerYield));
//                  ListeBox.items.add('OnUpdateError = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnUpdateError));
//                  ListeBox.items.add('OnUpdateRecord = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnUpdateRecord));

                End;
   GTQuery:Begin
             ListeBox.items.add('Infos Query'+RetourChar);
             ListeBox.items.add('Nom = '+(composant as TQuery).Name+RetourChar);
             ListeBox.items.add('DataBaseName = '+(composant as TQuery).DatabaseName+RetourChar);
             if (composant as TQuery).Database<>nil then
               ListeBox.items.add('DataBase Chemin = '+(composant as TQuery).Database.Directory+RetourChar);
             ListeBox.items.add('Active = '+str_bool2str((composant as TQuery).Active)+RetourChar);

             if (composant as TQuery).DataSource <> nil
                 then
                  ListeBox.items.add('DataSource = '+(composant as TQuery).DataSource.Name+RetourChar)
                 else
                  ListeBox.items.add('DataSource = Nil'+RetourChar);

             if (composant as TQuery).Active
                 then
                  ListeBox.items.add('RecordCount = '+ IntTostr((composant as TQuery).RecordCount)+RetourChar)
                 else
                  ListeBox.items.add('RecordCount = Query Inactive'+RetourChar);

             ListeBox.items.add('Filtre = '+(composant as TQuery).Filter+RetourChar);
             ListeBox.items.add('Filtrée = '+str_bool2str((composant as TQuery).Filtered)+RetourChar);
             ListeBox.items.add('REQUETE = '+(composant as TQuery).SQL.Text+RetourChar);

             case (composant as TQuery).State of
                dsinactive:ListeBox.items.add('Etat = dsinactive'+RetourChar);
                dsBrowse:ListeBox.items.add('Etat = dsBrowse'+RetourChar);
                dsEdit:ListeBox.items.add('Etat = dsEdit'+RetourChar);
                dsInsert:ListeBox.items.add('Etat = dsInsert'+RetourChar);
             end;
             for Index:=0 to (composant as TQuery).Params.Count-1 do
              begin
               ListeBox.items.add('NOM PARAMETRE = '+ (composant as TQuery).Params[Index].Name);
               try
                 ListeBox.items.add('VALEUR = '+(composant as TQuery).Params[Index].Text);
               except;
                 ListeBox.items.add('VALEUR = Query Inactive'+RetourChar);
               end;
              end;
             ListeBox.items.add('NOM ET VALEUR CHAMP');
             ListeBox.items.add('-------------------');
             if (composant as TQuery).Active
                 then
                 begin
                 for Index:=0 to (composant as TQuery).FieldCount-1 do
                  begin
                    ListeBox.items.add('NOM CHAMP = '+ (composant as TQuery).Fields[Index].FieldName);
                    ListeBox.items.add('VALEUR = '+(composant as TQuery).Fields[Index].Text);
                    ListeBox.items.add('READONLY = '+str_bool2str((composant as TQuery).Fields[Index].ReadOnly)+RetourChar);
                 end;
                 end
                 else
                  ListeBox.items.add('NOM ET VALEUR CHAMP = Query Inactive'+RetourChar);

                  ListeBox.items.add('LISTE DES EVENEMENTS'+RetourChar);

                  ListeBox.items.add('AfterCancel = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).AfterCancel));
                  ListeBox.items.add('AfterClose = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).AfterClose));
                  ListeBox.items.add('AfterDelete = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).AfterDelete));
                  ListeBox.items.add('AfterEdit = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).AfterEdit));
                  ListeBox.items.add('AfterInsert = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).AfterInsert));
                  ListeBox.items.add('AfterOpen = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).AfterOpen));
                  ListeBox.items.add('AfterPost = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).AfterPost));
                  ListeBox.items.add('AfterScroll = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).AfterScroll));
                  ListeBox.items.add('BeforeCancel = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).BeforeCancel));
                  ListeBox.items.add('BeforeClose = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).BeforeClose));
                  ListeBox.items.add('BeforeDelete = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).BeforeDelete));
                  ListeBox.items.add('BeforeEdit = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).BeforeEdit));
                  ListeBox.items.add('BeforeInsert = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).BeforeInsert));
                  ListeBox.items.add('BeforeOpen = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).BeforeOpen));
                  ListeBox.items.add('BeforePost = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).BeforePost));
                  ListeBox.items.add('BeforeScroll = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).BeforeScroll));
                  ListeBox.items.add('OnCalcFields = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).OnCalcFields));
                  ListeBox.items.add('OnDeleteError = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).OnDeleteError));
                  ListeBox.items.add('OnEditError = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).OnEditError));
                  ListeBox.items.add('OnFilterRecord = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).OnFilterRecord));
                  ListeBox.items.add('OnNewRecord = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).OnNewRecord));
                  ListeBox.items.add('OnPostError = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).OnPostError));
//                  ListeBox.items.add('OnServerYield = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).OnServerYield));
//                  ListeBox.items.add('OnUpdateError = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).OnUpdateError));
                  ListeBox.items.add('OnUpdateRecord = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).OnUpdateRecord));
           End;
     GTDataSource:Begin
                   ListeBox.items.add('Infos DATA SOURCE'+RetourChar);
                   ListeBox.items.add('Nom = '+(composant as TDataSource).Name+RetourChar);
                   if (composant as TDataSource).DataSet <> nil then
                   ListeBox.items.add('DataSet = '+(composant as TDataSource).DataSet.Name+RetourChar)
                   else
                   ListeBox.items.add('DataSet = Nil'+RetourChar);
                   case (composant as TDataSource).State of
                      dsinactive:ListeBox.items.add('Etat = dsinactive'+RetourChar);
                      dsBrowse:ListeBox.items.add('Etat = dsBrowse'+RetourChar);
                      dsEdit:ListeBox.items.add('Etat = dsEdit'+RetourChar);
                      dsInsert:ListeBox.items.add('Etat = dsInsert'+RetourChar);
                   end;

                  ListeBox.items.add('LISTE DES EVENEMENTS'+RetourChar);
//(composant as TDataSource).OnDataChange
                  ListeBox.items.add('OnDataChange = '+((composant as TDataSource).MethodName(@(composant as TDataSource).OnDataChange)));
                  if (composant as TDataSource).MethodAddress('OnStateChange') = nil then
                                                    ListeBox.items.add('OnStateChange = nil');
                  ListeBox.items.add('OnStateChange = '+((composant as TDataSource).MethodName(@(composant as TDataSource).OnStateChange)));
                  ListeBox.items.add('OnUpdateData = '+((composant as TDataSource).MethodName(@(composant as TDataSource).OnUpdateData)));

//                   (composant as TDataSource).State
                  End;
                  GTEdit:Begin
                          ListeBox.items.add('Infos TEdit'+RetourChar);
                          ListeBox.items.add('Nom = '+(composant).Name+RetourChar);
                          ListeBox.items.add('Valeur = '+(composant as TEdit).Text+RetourChar);
                          ListeBox.items.add('LISTE DES EVENEMENTS'+RetourChar);
                          ListeBox.items.add('OnChange = '+(composant as TEdit).Owner.MethodName(@(composant as TEdit).OnChange));
                          ListeBox.items.add('OnClick = '+(composant as TEdit).Owner.MethodName(@(composant as TEdit).OnClick));
                          ListeBox.items.add('OnDblClick = '+(composant as TEdit).Owner.MethodName(@(composant as TEdit).OnDblClick));
                          ListeBox.items.add('OnEnter = '+(composant as TEdit).Owner.MethodName(@(composant as TEdit).OnEnter));
                          ListeBox.items.add('OnExit = '+(composant as TEdit).Owner.MethodName(@(composant as TEdit).OnExit));
                          ListeBox.items.add('OnKeyDown = '+(composant as TEdit).Owner.MethodName(@(composant as TEdit).OnKeyDown));
                          ListeBox.items.add('OnKeyPress = '+(composant as TEdit).Owner.MethodName(@(composant as TEdit).OnKeyPress));
                          ListeBox.items.add('OnKeyUp = '+(composant as TEdit).Owner.MethodName(@(composant as TEdit).OnKeyUp));
                          ListeBox.items.add('OnMouseDown = '+(composant as TEdit).Owner.MethodName(@(composant as TEdit).OnMouseDown));
                          ListeBox.items.add('OnMouseMove = '+(composant as TEdit).Owner.MethodName(@(composant as TEdit).OnMouseMove));
                          ListeBox.items.add('OnMouseUp = '+(composant as TEdit).Owner.MethodName(@(composant as TEdit).OnMouseUp));
                         End;


                  GTFieldBoolean:;
                  GTFieldString:;
                  GtFieldInteger:;
                  GTFieldFloat:;
                  GTFieldDate:;
                  GTFieldCurr:;

                  GTStringGrid:;
                  GTGrid:;
                  GTDBGrid:;

                  GTGrGrid:;
                  GTGrDBGrid:Begin
                               ListeBox.items.add('Infos GrDBGrid'+RetourChar);
                               ListeBox.items.add('Nom = '+(composant as TGrDBGrid).DataSource.Name+RetourChar);
                             end;

                  GTDBEdit:;
                  GTDBRadioGroup:;
                  GTLabel:;
                  GTRxDBComboEdit:;
                  GTDBCheckBox:;
                  GTCurrencyEdit:;
                  GTRxLabel:;
                  GTPanel:;
                  GTDateEdit:;
                  GTInplaceEdit:;
                  GTGrInplaceEdit:;
                  GTParamUtil:Begin
                               ListeBox.items.add('Infos TParamUtil'+RetourChar);
                               ListeBox.items.add('Nom = '+(composant).Name+RetourChar);
                              end;
                  GTEntreprise:Begin
                               ListeBox.items.add('Infos TEntreprise'+RetourChar);
                               ListeBox.items.add('Nom = '+(composant).Name+RetourChar);
                              end;
                  GTPiece:Begin
                           ListeBox.items.add('Infos TPiece'+RetourChar);
                           ListeBox.items:=CopieContenuPiece_DansFichier((composant as TPiece));
                           ListeBox.items.add('LISTE DES EVENEMENTS'+RetourChar);
                          End;
//
                  GTEcriture_Isa:Begin
                               ListeBox.items.add('Infos TEcriture_isa'+RetourChar);
                               ListeBox.items:=CopieContenuEcriture_Isa_DansFichier((composant as TEcriture_Isa));
                             end;

     else
       begin
         ListeBox.items.add('COMPOSANT NON TRAITE'+RetourChar);
         ListeBox.items.add('Nom = '+(composant).Name+RetourChar);
         ListeBox.items.add('Nom de Classe = '+(composant).ClassName+RetourChar);
       end;

end;
//ChaineInfos.Strings:=ListeBox.Items;
//str_remplacesouschaine(ListeBox.Items.Text,RetourChariotSimple,'');
//str_remplacesouschaine(ListeBox.Items.Text,RetourChariotDouble,'');
//Index:=pos(#10#13,ListeBox.Items.Text);
//while Index > 0 do
//  begin
//   delete(ListeBox.Items.Text,Index,2);
//   Index:=pos(#10#13,ListeBox.Items.Text);
//  end;
if affiche then Form.ShowModal;
result.AddStrings(ListeBox.Items);
ListeBox.Free;
   Form.Free;
   Form:=nil;
//Showmessage(ChaineInfos.Text);
ChaineInfos.Free;
End;



Function AfficheInfoObjet(Mess:string;Objet:TOBJECT;Affiche:boolean):TStringList;
var
i,Index:integer;
ChaineInfos:TstringList;
ListeBox:TListBox;
RetourChar:string;
Classes:TClass;
Begin
//TControl(Zsaisie[i]);Zsaisie[i]
result:=TStringList.Create;
RetourChar:='';
//RetourChar:=RetourChariotSimple;
ListeBox:=TListBox.Create(Form);
   if form = nil then
      Form:=TFormLocale.CreateNew(application.MainForm);
      Form.OnKeyDown:=Form.FormKeyDown;
      Form.Position:=poScreenCenter;
      Form.KeyPreview:=true;
      Form.Height:=screen.Height;
      ListeBox.Align:=alClient;
      ListeBox.Parent:=form;
i:=0;
ChaineInfos:=TstringList.Create;
ChaineInfos.Clear;//
ChaineInfos.Add(Mess+RetourChar);
i:=RecupClassTypeObjet(Objet);
case i of
//   GTable:Begin
//             ListeBox.items.add('Infos TABLE'+RetourChar);
//             ListeBox.items.add('Nom = '+(composant as TTable).Name+RetourChar);
//             ListeBox.items.add('DataBaseName = '+(composant as TTable).DatabaseName+RetourChar);
//             ListeBox.items.add('Active = '+str_bool2str((composant as TTable).Active)+RetourChar);
//             if (composant as TTable).DataSource <> nil then
//             ListeBox.items.add('DataSource = '+(composant as TTable).DataSource.Name+RetourChar)
//             else ListeBox.items.add('DataSource = Nil'+RetourChar);
//             if (composant as TTable).Active
//                 then
//                  ListeBox.items.add('RecordCount = '+ IntTostr((composant as TTable).RecordCount)+RetourChar)
//                 else
//                  ListeBox.items.add('RecordCount = Table Inactive'+RetourChar);
//
//             ListeBox.items.add('Filtre = '+(composant as TTable).Filter+RetourChar);
//             ListeBox.items.add('Filtrée = '+str_bool2str((composant as TTable).Filtered)+RetourChar);
//             case (composant as TTable).State of
//                dsinactive:ListeBox.items.add('Etat = dsinactive'+RetourChar);
//                dsBrowse:ListeBox.items.add('Etat = dsBrowse'+RetourChar);
//                dsEdit:ListeBox.items.add('Etat = dsEdit'+RetourChar);
//                dsInsert:ListeBox.items.add('Etat = dsInsert'+RetourChar);
//             end;
//             ListeBox.items.add('NOM ET VALEUR DES CHAMPS : ');
//             ListeBox.items.add('------------------------------');
//             if (composant as TTable).Active
//                 then
//                 begin
//                 for Index:=0 to (composant as TTable).FieldCount-1 do
//                  begin
//                    ListeBox.items.add('NOM CHAMP = '+ (composant as TTable).Fields[Index].FieldName+RetourChar);
//                    ListeBox.items.add('VALEUR = '+(composant as TTable).Fields[Index].Text+RetourChar);
//                    ListeBox.items.add('READONLY = '+str_bool2str((composant as TTable).Fields[Index].ReadOnly)+RetourChar);
//                 end;
//                 end
//                 else
//                  ListeBox.items.add('NOM ET VALEUR DES CHAMPS : Table Inactive'+RetourChar);
//
//                  ListeBox.items.add('LISTE DES EVENEMENTS'+RetourChar);
//
//                  ListeBox.items.add('AfterCancel = '+(composant as TTable).Owner.MethodName(@(composant as TTable).AfterCancel));
//                  ListeBox.items.add('AfterClose = '+(composant as TTable).Owner.MethodName(@(composant as TTable).AfterClose));
//                  ListeBox.items.add('AfterDelete = '+(composant as TTable).Owner.MethodName(@(composant as TTable).AfterDelete));
//                  ListeBox.items.add('AfterEdit = '+(composant as TTable).Owner.MethodName(@(composant as TTable).AfterEdit));
//                  ListeBox.items.add('AfterInsert = '+(composant as TTable).Owner.MethodName(@(composant as TTable).AfterInsert));
//                  ListeBox.items.add('AfterOpen = '+(composant as TTable).Owner.MethodName(@(composant as TTable).AfterOpen));
//                  ListeBox.items.add('AfterPost = '+(composant as TTable).Owner.MethodName(@(composant as TTable).AfterPost));
//                  ListeBox.items.add('AfterScroll = '+(composant as TTable).Owner.MethodName(@(composant as TTable).AfterScroll));
//                  ListeBox.items.add('BeforeCancel = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforeCancel));
//                  ListeBox.items.add('BeforeClose = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforeClose));
//                  ListeBox.items.add('BeforeDelete = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforeDelete));
//                  ListeBox.items.add('BeforeEdit = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforeEdit));
//                  ListeBox.items.add('BeforeInsert = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforeInsert));
//                  ListeBox.items.add('BeforeOpen = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforeOpen));
//                  ListeBox.items.add('BeforePost = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforePost));
//                  ListeBox.items.add('BeforeScroll = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforeScroll));
//                  ListeBox.items.add('OnCalcFields = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnCalcFields));
//                  ListeBox.items.add('OnDeleteError = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnDeleteError));
//                  ListeBox.items.add('OnEditError = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnEditError));
//                  ListeBox.items.add('OnFilterRecord = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnFilterRecord));
//                  ListeBox.items.add('OnNewRecord = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnNewRecord));
//                  ListeBox.items.add('OnPostError = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnPostError));
//                  ListeBox.items.add('OnServerYield = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnServerYield));
//                  ListeBox.items.add('OnUpdateError = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnUpdateError));
//                  ListeBox.items.add('OnUpdateRecord = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnUpdateRecord));
//
//                End;
//   GTQuery:Begin
//             ListeBox.items.add('Infos Query'+RetourChar);
//             ListeBox.items.add('Nom = '+(composant as TQuery).Name+RetourChar);
//             ListeBox.items.add('DataBaseName = '+(composant as TQuery).DatabaseName+RetourChar);
//             ListeBox.items.add('Active = '+str_bool2str((composant as TQuery).Active)+RetourChar);
//
//             if (composant as TQuery).DataSource <> nil
//                 then
//                  ListeBox.items.add('DataSource = '+(composant as TQuery).DataSource.Name+RetourChar)
//                 else
//                  ListeBox.items.add('DataSource = Nil'+RetourChar);
//
//             if (composant as TQuery).Active
//                 then
//                  ListeBox.items.add('RecordCount = '+ IntTostr((composant as TQuery).RecordCount)+RetourChar)
//                 else
//                  ListeBox.items.add('RecordCount = Query Inactive'+RetourChar);
//
//             ListeBox.items.add('Filtre = '+(composant as TQuery).Filter+RetourChar);
//             ListeBox.items.add('Filtrée = '+str_bool2str((composant as TQuery).Filtered)+RetourChar);
//             ListeBox.items.add('REQUETE = '+(composant as TQuery).SQL.Text+RetourChar);
//
//             case (composant as TQuery).State of
//                dsinactive:ListeBox.items.add('Etat = dsinactive'+RetourChar);
//                dsBrowse:ListeBox.items.add('Etat = dsBrowse'+RetourChar);
//                dsEdit:ListeBox.items.add('Etat = dsEdit'+RetourChar);
//                dsInsert:ListeBox.items.add('Etat = dsInsert'+RetourChar);
//             end;
//             for Index:=0 to (composant as TQuery).Params.Count-1 do
//              begin
//               ListeBox.items.add('NOM PARAMETRE = '+ (composant as TQuery).Params[Index].Name);
//               try
//                 ListeBox.items.add('VALEUR = '+(composant as TQuery).Params[Index].Text);
//               except;
//                 ListeBox.items.add('VALEUR = Query Inactive'+RetourChar);
//               end;
//              end;
//             ListeBox.items.add('NOM ET VALEUR CHAMP');
//             ListeBox.items.add('-------------------');
//             if (composant as TQuery).Active
//                 then
//                 begin
//                 for Index:=0 to (composant as TQuery).FieldCount-1 do
//                  begin
//                    ListeBox.items.add('NOM CHAMP = '+ (composant as TQuery).Fields[Index].FieldName);
//                    ListeBox.items.add('VALEUR = '+(composant as TQuery).Fields[Index].Text);
//                    ListeBox.items.add('READONLY = '+str_bool2str((composant as TQuery).Fields[Index].ReadOnly)+RetourChar);
//                 end;
//                 end
//                 else
//                  ListeBox.items.add('NOM ET VALEUR CHAMP = Query Inactive'+RetourChar);
//
//                  ListeBox.items.add('LISTE DES EVENEMENTS'+RetourChar);
//
//                  ListeBox.items.add('AfterCancel = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).AfterCancel));
//                  ListeBox.items.add('AfterClose = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).AfterClose));
//                  ListeBox.items.add('AfterDelete = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).AfterDelete));
//                  ListeBox.items.add('AfterEdit = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).AfterEdit));
//                  ListeBox.items.add('AfterInsert = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).AfterInsert));
//                  ListeBox.items.add('AfterOpen = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).AfterOpen));
//                  ListeBox.items.add('AfterPost = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).AfterPost));
//                  ListeBox.items.add('AfterScroll = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).AfterScroll));
//                  ListeBox.items.add('BeforeCancel = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).BeforeCancel));
//                  ListeBox.items.add('BeforeClose = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).BeforeClose));
//                  ListeBox.items.add('BeforeDelete = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).BeforeDelete));
//                  ListeBox.items.add('BeforeEdit = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).BeforeEdit));
//                  ListeBox.items.add('BeforeInsert = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).BeforeInsert));
//                  ListeBox.items.add('BeforeOpen = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).BeforeOpen));
//                  ListeBox.items.add('BeforePost = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).BeforePost));
//                  ListeBox.items.add('BeforeScroll = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).BeforeScroll));
//                  ListeBox.items.add('OnCalcFields = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).OnCalcFields));
//                  ListeBox.items.add('OnDeleteError = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).OnDeleteError));
//                  ListeBox.items.add('OnEditError = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).OnEditError));
//                  ListeBox.items.add('OnFilterRecord = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).OnFilterRecord));
//                  ListeBox.items.add('OnNewRecord = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).OnNewRecord));
//                  ListeBox.items.add('OnPostError = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).OnPostError));
//                  ListeBox.items.add('OnServerYield = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).OnServerYield));
//                  ListeBox.items.add('OnUpdateError = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).OnUpdateError));
//                  ListeBox.items.add('OnUpdateRecord = '+(composant as TQuery).Owner.MethodName(@(composant as TQuery).OnUpdateRecord));
//           End;
//     GTDataSource:Begin
//                   ListeBox.items.add('Infos DATA SOURCE'+RetourChar);
//                   ListeBox.items.add('Nom = '+(composant as TDataSource).Name+RetourChar);
//                   if (composant as TDataSource).DataSet <> nil then
//                   ListeBox.items.add('DataSet = '+(composant as TDataSource).DataSet.Name+RetourChar)
//                   else
//                   ListeBox.items.add('DataSet = Nil'+RetourChar);
//                   case (composant as TDataSource).State of
//                      dsinactive:ListeBox.items.add('Etat = dsinactive'+RetourChar);
//                      dsBrowse:ListeBox.items.add('Etat = dsBrowse'+RetourChar);
//                      dsEdit:ListeBox.items.add('Etat = dsEdit'+RetourChar);
//                      dsInsert:ListeBox.items.add('Etat = dsInsert'+RetourChar);
//                   end;
//
//
////                   (composant as TDataSource).State
//                  End;
//                  GTEdit:Begin
//                          ListeBox.items.add('Infos TEdit'+RetourChar);
//                          ListeBox.items.add('Nom = '+(composant).Name+RetourChar);
//                          ListeBox.items.add('Valeur = '+(composant as TEdit).Text+RetourChar);
//                          ListeBox.items.add('LISTE DES EVENEMENTS'+RetourChar);
//                          ListeBox.items.add('OnChange = '+(composant as TEdit).Owner.MethodName(@(composant as TEdit).OnChange));
//                          ListeBox.items.add('OnClick = '+(composant as TEdit).Owner.MethodName(@(composant as TEdit).OnClick));
//                          ListeBox.items.add('OnDblClick = '+(composant as TEdit).Owner.MethodName(@(composant as TEdit).OnDblClick));
//                          ListeBox.items.add('OnEnter = '+(composant as TEdit).Owner.MethodName(@(composant as TEdit).OnEnter));
//                          ListeBox.items.add('OnExit = '+(composant as TEdit).Owner.MethodName(@(composant as TEdit).OnExit));
//                          ListeBox.items.add('OnKeyDown = '+(composant as TEdit).Owner.MethodName(@(composant as TEdit).OnKeyDown));
//                          ListeBox.items.add('OnKeyPress = '+(composant as TEdit).Owner.MethodName(@(composant as TEdit).OnKeyPress));
//                          ListeBox.items.add('OnKeyUp = '+(composant as TEdit).Owner.MethodName(@(composant as TEdit).OnKeyUp));
//                          ListeBox.items.add('OnMouseDown = '+(composant as TEdit).Owner.MethodName(@(composant as TEdit).OnMouseDown));
//                          ListeBox.items.add('OnMouseMove = '+(composant as TEdit).Owner.MethodName(@(composant as TEdit).OnMouseMove));
//                          ListeBox.items.add('OnMouseUp = '+(composant as TEdit).Owner.MethodName(@(composant as TEdit).OnMouseUp));
//                         End;
//
//
//                  GTFieldBoolean:;
//                  GTFieldString:;
//                  GtFieldInteger:;
//                  GTFieldFloat:;
//                  GTFieldDate:;
//                  GTFieldCurr:;
//
//                  GTStringGrid:;
//                  GTGrid:;
//                  GTDBGrid:;
//
//                  GTGrGrid:;
//                  GTGrDBGrid:;
//
//                  GTDBEdit:;
//                  GTDBRadioGroup:;
//                  GTLabel:;
//                  GTRxDBComboEdit:;
//                  GTDBCheckBox:;
//                  GTCurrencyEdit:;
//                  GTRxLabel:;
//                  GTPanel:;
//                  GTDateEdit:;
//                  GTInplaceEdit:;
//                  GTGrInplaceEdit:;
                  GTStringList:Begin
                               if empty(Mess) then
                                ListeBox.items.add('Infos TStringList'+RetourChar)
                               else
                                ListeBox.items.Add(Mess+RetourChar);
                               for Index := 0 to TStringList(Objet).Count-1 do
                                begin
                                 ListeBox.items.add('Items['+IntTostr(Index)+'] = '+TStringList(Objet).Strings[Index]);
                                end;
//                               ListeBox.items.add('ClassName = '+(Objet).ClassName+RetourChar);
//                               ListeBox.items.add('Text = '+TStringList(Objet).Text+RetourChar);
                               end;
                  GTParamUtil:Begin
                               ListeBox.items.add('Infos TParamUtil'+RetourChar);
                               ListeBox.items.add('ClassName = '+(Objet).ClassName+RetourChar);
                              end;
                  GTEntreprise:Begin
                               ListeBox.items.add('Infos TEntreprise'+RetourChar);
                               ListeBox.items.add('ClassName = '+TEntreprise(Objet).ClassName+RetourChar);
                               ListeBox.items.add('NomUtilisateur = '+TEntreprise(Objet).NomUtilisateur+RetourChar);
                               ListeBox.items.add('Regime = '+TEntreprise(Objet).Regime+RetourChar);
                               ListeBox.items.add('ExerciceBase = '+TEntreprise(Objet).ExerciceBase+RetourChar);
                               ListeBox.items.add('ExerciceSaisie = '+TEntreprise(Objet).ExerciceSaisie+RetourChar);

                               ListeBox.items.add('IDDevise_ParDefaut = '+IntToStr(TEntreprise(Objet).IDDevise_ParDefaut)+RetourChar);
                               ListeBox.items.add('IDDevise = '+IntToStr(TEntreprise(Objet).Devise)+RetourChar);
                               ListeBox.items.add('DeviseSigle = '+TEntreprise(Objet).DeviseSigle+RetourChar);
                               ListeBox.items.add('FormatMonnaie = '+TEntreprise(Objet).FormatMonnaie+RetourChar);
                               ListeBox.items.add('EditFormat = '+TEntreprise(Objet).EditFormat+RetourChar);
                               ListeBox.items.add('ArrondiDebit = '+TEntreprise(Objet).ArrondiDebit+RetourChar);
                               ListeBox.items.add('ArrondiCredit = '+TEntreprise(Objet).ArrondiCredit+RetourChar);
                               ListeBox.items.add('ArrondiMontant = '+CurrToStr(TEntreprise(Objet).ArrondiMontant)+RetourChar);
                               ListeBox.items.add('ParamArrondisTVA = '+CurrToStr(TEntreprise(Objet).ParamArrondisTVA)+RetourChar);

                               ListeBox.items.add('DatExoDebut = '+DateToStr(TEntreprise(Objet).DatExoDebut)+RetourChar);
                               ListeBox.items.add('DatExoFin = '+DateToStr(TEntreprise(Objet).DatExoFin)+RetourChar);
                               ListeBox.items.add('DatExoDemoDebut = '+DateToStr(TEntreprise(Objet).DatExoDemoDebut)+RetourChar);
                               ListeBox.items.add('DateExoDemoFin = '+DateToStr(TEntreprise(Objet).DateExoDemoFin)+RetourChar);
                               ListeBox.items.add('RepertoireDossier = '+TEntreprise(Objet).RepertoireDossier+RetourChar);
                               ListeBox.items.add('RepertoireExercice = '+TEntreprise(Objet).RepertoireExercice+RetourChar);
                               ListeBox.items.add('RepertoireProgram = '+TEntreprise(Objet).RepertoireProgram+RetourChar);
                               ListeBox.items.add('RepertoireImportEPI_DOS = '+TEntreprise(Objet).RepertoireImportEPI_DOS+RetourChar);
                               ListeBox.items.add('NomExo = '+TEntreprise(Objet).NomExo+RetourChar);
                               ListeBox.items.add('NomDossier = '+TEntreprise(Objet).NomDossier+RetourChar);
                               ListeBox.items.add('TypeEntreprise = '+TEntreprise(Objet).TypeEntreprise+RetourChar);
                               ListeBox.items.add('User = '+TEntreprise(Objet).User+RetourChar);
                               ListeBox.items.add('DateDebutDeclarationTVA = '+DateToStr(TEntreprise(Objet).DateDebutDeclarationTVA)+RetourChar);
                               ListeBox.items.add('DateFinDeclarationTVA= '+DateToStr(TEntreprise(Objet).DateFinDeclarationTVA)+RetourChar);
                               ListeBox.items.add('PremiereDateDeclaration= '+DateToStr(TEntreprise(Objet).PremiereDateDeclaration)+RetourChar);
                               ListeBox.items.add('DatePassageReel= '+DateToStr(TEntreprise(Objet).DatePassageReel)+RetourChar);
                               ListeBox.items.add('ID_Dos = '+IntToStr(TEntreprise(Objet).ID_Dos)+RetourChar);
                               ListeBox.items.add('ID_Exo = '+IntToStr(TEntreprise(Objet).ID_Exo)+RetourChar);
                               ListeBox.items.add('TypeDossier = '+TypeDossierToStr(TEntreprise(Objet).TypeDossier)+RetourChar);
                               ListeBox.items.add('TypeDossierdemo = '+TypeDossierToStr(TEntreprise(Objet).TypeDossierdemo)+RetourChar);
                               ListeBox.items.add('PlanAuxT = '+str_bool2str(TEntreprise(Objet).PlanAuxT)+RetourChar);
                               ListeBox.items.add('Derogatoire = '+str_bool2str(TEntreprise(Objet).Derogatoire)+RetourChar);
                               ListeBox.items.add('ExerciceCloture = '+str_bool2str(TEntreprise(Objet).ExerciceCloture)+RetourChar);
                               ListeBox.items.add('TypeClient = '+TypeClientToStr(TEntreprise(Objet).TypeClient)+RetourChar);
                              end;
//                  GTPiece:Begin
//                           ListeBox.items.add('Infos TPiece'+RetourChar);
//                           ListeBox.items.add('Nom = '+(composant).Name+RetourChar);
//                           ListeBox.items.add('AnneePiece.ExoAnterieure = '+(composant as TPiece).AnneePiece.ExoAnterieure+RetourChar);
//                           ListeBox.items.add('AnneePiece.ExoAnterieure = '+str_bool2str((composant as TPiece).AnneePiece.PieceAnterieure)+RetourChar);
//                           ListeBox.items.add('CodeExo = '+(composant as TPiece).CodeExo+RetourChar);
//                           ListeBox.items.add('CodeGestCo = '+(composant as TPiece).CodeGestCo+RetourChar);
//                           ListeBox.items.add('Compte = '+(composant as TPiece).Compte+RetourChar);
//                           ListeBox.items.add('ComptePlan = '+(composant as TPiece).ComptePlan+RetourChar);
//                           //if
//                           //ListeBox.items.add('ListeContrePartieTiers = '+IntToStr((composant as TPiece).ListeContrePartieTiers)+RetourChar);
//
//                           ListeBox.items.add('ContrePartieTiers = '+(composant as TPiece).ContrePartieTiers+RetourChar);
//                           ListeBox.items.add('DateDebutExo = '+DateToStr((composant as TPiece).DateDebutExo)+RetourChar);
//                           ListeBox.items.add('DateFinExo = '+DateToStr((composant as TPiece).DateFinExo)+RetourChar);
//                           ListeBox.items.add('DateLivraison = '+DateToStr((composant as TPiece).DateLivraison)+RetourChar);
//                           ListeBox.items.add('DateSaisie = '+DateToStr((composant as TPiece).DateSaisie)+RetourChar);
//                           ListeBox.items.add('DernierLibelleSaisi = '+(composant as TPiece).DernierLibelleSaisi+RetourChar);
//                           ListeBox.items.add('EmptyCompte = '+str_bool2str((composant as TPiece).EmptyCompte)+RetourChar);
//                           ListeBox.items.add('EmptyLibelle = '+str_bool2str((composant as TPiece).EmptyLibelle)+RetourChar);
//                           ListeBox.items.add('EmptyReference = '+str_bool2str((composant as TPiece).EmptyReference)+RetourChar);
//                           case (composant as TPiece).EtatPiece of
//                              dsinactive:ListeBox.items.add('Etat = dsinactive'+RetourChar);
//                              dsBrowse:ListeBox.items.add('Etat = dsBrowse'+RetourChar);
//                              dsEdit:ListeBox.items.add('Etat = dsEdit'+RetourChar);
//                              dsInsert:ListeBox.items.add('Etat = dsInsert'+RetourChar);
//                           end;
//                           ListeBox.items.add('FirstIDPiece = '+IntToStr((composant as TPiece).FirstIDPiece)+RetourChar);
//                           ListeBox.items.add('ICompteTiers = '+(composant as TPiece).DernierLibelleSaisi+RetourChar);
//
//                           ListeBox.items.add('ICompteTiers = '+IntToStr((composant as TPiece).ICompteTiers) + RetourChar);
//                           ListeBox.items.add('IDContrepartie = '+IntToStr((composant as TPiece).IDContrepartie)+RetourChar);
//                           ListeBox.items.add('IDGestCo = '+IntToStr((composant as TPiece).IDGestCo)+RetourChar);
//                           ListeBox.items.add('IDJournal = '+IntToStr((composant as TPiece).IDJournal)+RetourChar);
//                           ListeBox.items.add('ILibTaPlan = '+IntToStr((composant as TPiece).ILibTaPlan)+RetourChar);
//                           ListeBox.items.add('ILibTiers = '+IntToStr((composant as TPiece).ILibTiers)+RetourChar);
//                           ListeBox.items.add('IndexCompte = '+IntToStr((composant as TPiece).IndexCompte)+RetourChar);
//                           ListeBox.items.add('IndexJournal = '+IntToStr((composant as TPiece).IndexJournal)+RetourChar);
//                           if (composant as TPiece).InfosPointage.infosPointage.Dataset <> nil
//                               then
//                                ListeBox.items.add('infosPointage.Dataset.Name = '+(composant as TPiece).InfosPointage.infosPointage.Dataset.Name+RetourChar)
//                               else
//                                ListeBox.items.add('infosPointage.Dataset.Name = Nil'+RetourChar);
//
//                           ListeBox.items.add('infosPointage.NbLignePointee = '+IntToStr((composant as TPiece).InfosPointage.infosPointage.NbLignePointee)+RetourChar);
//                           ListeBox.items.add('infosPointage.Pointee = '+str_bool2str((composant as TPiece).InfosPointage.infosPointage.Pointee)+RetourChar);
//                           ListeBox.items.add('InfosPointage.InfosReste.Reste = '+CurrToStr((composant as TPiece).InfosPointage.InfosReste.Reste)+RetourChar);
//                           ListeBox.items.add('InfosPointage.InfosReste.ResteInitial = '+CurrToStr((composant as TPiece).InfosPointage.InfosReste.ResteInitial)+RetourChar);
//                           ListeBox.items.add('InfosPointage.InfosReste.SensReste = '+str_bool2str((composant as TPiece).InfosPointage.InfosReste.SensReste)+RetourChar);
//                           ListeBox.items.add('InfosVerrouillage.Deverrouillable = '+str_bool2str((composant as TPiece).InfosVerrouillage.Deverrouillable)+RetourChar);
//                           ListeBox.items.add('InfosVerrouillage.PeriodeVerrouillee = '+str_bool2str((composant as TPiece).InfosVerrouillage.PeriodeVerrouillee)+RetourChar);
//                           ListeBox.items.add('InfosVerrouillage.PieceVerrouillee = '+str_bool2str((composant as TPiece).InfosVerrouillage.PieceVerrouillee)+RetourChar);
//                           ListeBox.items.add('IRefTaPiece = '+IntToStr((composant as TPiece).IRefTaPiece)+RetourChar);
//                           ListeBox.items.add('Journal = '+(composant as TPiece).Journal+RetourChar);
//                           ListeBox.items.add('Libelle = '+(composant as TPiece).Libelle+RetourChar);
//                           ListeBox.items.add('Modifier_Confirmer = '+str_bool2str((composant as TPiece).Modifier_Confirmer)+RetourChar);
//                           ListeBox.items.add('Modifier_EnAttente = '+str_bool2str((composant as TPiece).Modifier_EnAttente)+RetourChar);
//                           ListeBox.items.add('Montant = '+CurrToStr((composant as TPiece).Montant)+RetourChar);
//                           ListeBox.items.add('MontantPourReglement = '+CurrToStr((composant as TPiece).MontantPourReglement)+RetourChar);
//                           ListeBox.items.add('NbrPointage = '+IntToStr((composant as TPiece).NbrPointage)+RetourChar);
//                           ListeBox.items.add('NumCheque = '+(composant as TPiece).NumCheque+RetourChar);
//                           ListeBox.items.add('PieceModifiable = '+str_bool2str((composant as TPiece).PieceModifiable)+RetourChar);
//                           ListeBox.items.add('Quand = '+DateToSTr((composant as TPiece).Quand)+RetourChar);
//                           ListeBox.items.add('Qui = '+(composant as TPiece).Qui+RetourChar);
//                           ListeBox.items.add('Reference = '+(composant as TPiece).Reference+RetourChar);
//                           ListeBox.items.add('Reglement = '+str_bool2str((composant as TPiece).Reglement)+RetourChar);
//                           ListeBox.items.add('Sens = '+str_bool2str((composant as TPiece).Sens)+RetourChar);
//                           ListeBox.items.add('SensPourReglement = '+str_bool2str((composant as TPiece).SensPourReglement)+RetourChar);
//
//                           if (composant as TPiece).TableJournal <> nil
//                               then
//                                 ListeBox.items.add('TableJournal = '+(composant as TPiece).TableJournal.Name+RetourChar)
//                               else
//                                ListeBox.items.add('TableJournal = Nil'+RetourChar);
//
//                           if (composant as TPiece).TablePiece <> nil
//                               then
//                           ListeBox.items.add('TablePiece = '+(composant as TPiece).TablePiece.Name+RetourChar)
//                               else
//                                ListeBox.items.add('TablePiece = Nil'+RetourChar);
//
//                           if (composant as TPiece).TablePlan <> nil
//                               then
//                           ListeBox.items.add('TablePlan = '+(composant as TPiece).TablePlan.Name+RetourChar)
//                               else
//                                ListeBox.items.add('TablePlan = Nil'+RetourChar);
//
//                           if (composant as TPiece).TableTiers <> nil
//                               then
//                           ListeBox.items.add('TableTiers = '+(composant as TPiece).TableTiers.Name+RetourChar)
//                               else
//                                ListeBox.items.add('TableTiers = Nil'+RetourChar);
//
//                           ListeBox.items.add('Tag = '+IntToStr((composant as TPiece).Tag)+RetourChar);
//                           ListeBox.items.add('Tiers = '+(composant as TPiece).Tiers+RetourChar);
//                           ListeBox.items.add('Trame = '+(composant as TPiece).Trame.CodeTrame+RetourChar);
//                           ListeBox.items.add('Trame.ConserveMontant = '+str_bool2str((composant as TPiece).Trame.ConserveMontant)+RetourChar);
//                           ListeBox.items.add('Trame.IDTrame = '+IntToStr((composant as TPiece).Trame.IDTrame)+RetourChar);
//                           ListeBox.items.add('Trame.IDTrame_Ligne = '+IntToStr((composant as TPiece).Trame.IDTrame_Ligne)+RetourChar);
//                           ListeBox.items.add('Trame.LibelleTrame = '+(composant as TPiece).Trame.LibelleTrame+RetourChar);
//
//                           if (composant as TPiece).Trame.TableTrame <> nil
//                               then
//                                ListeBox.items.add('Trame.TableTrame = '+(composant as TPiece).Trame.TableTrame.Name+RetourChar)
//                               else
//                                ListeBox.items.add('Trame.TableTrame = Nil'+RetourChar);
//
//                           if (composant as TPiece).Trame.TableTrame_Ligne <> nil
//                               then
//                                 ListeBox.items.add('Trame.TableTrame_Ligne = '+(composant as TPiece).Trame.TableTrame_Ligne.Name+RetourChar)
//                               else
//                                ListeBox.items.add('Trame.TableTrame_Ligne = Nil'+RetourChar);
//
//                           ListeBox.items.add('Trame.TrameACharger = '+str_bool2str((composant as TPiece).Trame.TrameACharger)+RetourChar);
//                           ListeBox.items.add('TVA_A_Gerer = '+str_bool2str((composant as TPiece).TVA_A_Gerer)+RetourChar);
//                           ListeBox.items.add('TypeTvaE = '+str_bool2str((composant as TPiece).TypeTvaE)+RetourChar);
//                           ListeBox.items.add('ValPieceAutoGen.Champ_Gen = '+(composant as TPiece).ValPieceAutoGen.Champ_Gen+RetourChar);
//                           ListeBox.items.add('ValPieceAutoGen.Table_Gen = '+(composant as TPiece).ValPieceAutoGen.Table_Gen+RetourChar);
//                           ListeBox.items.add('ValPieceAutoGen.TableGen = '+str_bool2str((composant as TPiece).ValPieceAutoGen.TableGen)+RetourChar);
//                           ListeBox.items.add('ValPieceAutoGen.Val_Champ_Gen = '+(composant as TPiece).ValPieceAutoGen.Val_Champ_Gen+RetourChar);
//
//
//                           ListeBox.items.add('LISTE DES EVENEMENTS'+RetourChar);
//                          End;

     else
       begin
         ListeBox.items.add('OBJET NON TRAITE'+RetourChar);
         ListeBox.items.add('Nom de Classe = '+(objet).ClassName+RetourChar);
       end;

end;
//ChaineInfos.Strings:=ListeBox.Items;
//str_remplacesouschaine(ListeBox.Items.Text,RetourChariotSimple,'');
//str_remplacesouschaine(ListeBox.Items.Text,RetourChariotDouble,'');
//Index:=pos(#10#13,ListeBox.Items.Text);
//while Index > 0 do
//  begin
//   delete(ListeBox.Items.Text,Index,2);
//   Index:=pos(#10#13,ListeBox.Items.Text);
//  end;
if affiche then Form.ShowModal;
result.AddStrings(ListeBox.Items);
ListeBox.Free;
   Form.Free;
   Form:=nil;
//Showmessage(ChaineInfos.Text);
ChaineInfos.Free;
End;

Function AfficheInfoComposantInput:string;
var
Comp:string;
Form:TCustomForm;
DAtaM:TDataModule;
Composant:TComponent;
i:integer;
Begin
Form:=nil;
DAtaM:=nil;
Composant:=nil;

InputQuery('Nom de la Form','Saisissez ici le nom du module : ',result);
for i:=0 to screen.FormCount - 1 do
 begin
  if StrIComp(PChar(screen.Forms[i].Name),PCHar(result))=0 then Form:=screen.Forms[i];
 end;
for i:=0 to screen.DataModuleCount - 1 do
 begin
  if StrIComp(PChar(screen.DataModules[i].Name),PChar(result))=0 then DataM:=screen.DataModules[i];
 end;

InputQuery('Nom du composant','Saisissez ici le nom du composant : ',comp);
if form <> nil then
   for i:=0 to form.ComponentCount - 1 do
    Begin
     if StrIComp(PChar(form.Components[i].Name),PChar(Comp))=0 then Composant:=form.Components[i];
    End;
if DataM <> nil then
   for i:=0 to DataM.ComponentCount - 1 do
    Begin
     if StrIComp(PChar(DataM.Components[i].Name),PChar(Comp))=0 then Composant:=DataM.Components[i];
    End;
if composant <> nil then
AfficheInfoComposant('',Composant,true)
else
showmessage('Ce composant n''a pas été trouvé !');
End;

//Function AfficheInfoComposantForm(Maintenance:boolean;TypeMaintenance:string):string;
//Begin
//// PB le 15/06/04 //if Maintenance then
//// begin
////    if form1 = nil then
////    Application.CreateForm(TInfoComposant,Form1);
////    //Form1:=TInfoComposant.CreateNew(application.MainForm);
////    Form1.Maintenance:=true;
////    Form1.NomMaint:=TypeMaintenance;
////    Form1.Maintenance:=Maintenance;
////    if maintenance then
////     if TypeMaintenance = 'Maint' then
////       Form1.ListBox3.OnClick:=Form1.ListBox3Click_Maint
////     else
////     if TypeMaintenance = 'MaintS' then
////       Form1.ListBox3.OnClick:=Form1.ListBox3Click
////     else Form1.ListBox3.OnClick:=nil;
////
////    Form1.Visible:=false;
////    Form1.showmodal;
////    Form1.free;
////    Form1:=nil;
//// end
//// else
//// begin
////  Showmessage('Vous devez être en Maintenance pour accéder à cette fonctionnalité !');
//// end;
//End;

Procedure TFormLocale.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Sender is TForm then
 begin
  if Key = VK_ESCAPE then
   begin
    Key:= 0;
    self.close;
   end;
  end;
end;

Procedure MessageSilencieux(MessTitre,Mess:string;PanelMessage:TPanel;PaTop,PaWidth,PaLeft,PaHeigth:Integer;Form:TForm);
Begin
With PanelMessage do
 begin
   PanelMessage.Top:=PaTop;
   PanelMessage.Width:=PaWidth;
   PanelMessage.Left:=PaLeft;
   PanelMessage.Height:=PaHeigth;
   PanelMessage.Caption:=Mess;
   TPanel(PanelMessage.Parent.FindComponent('PaTitre')).Caption:=MessTitre;
   TPanel(PanelMessage.Parent.FindComponent('PaMessage')).Caption:=Mess;
   PanelMessage.Parent:=Form;
   PanelMessage.BringToFront;
   PanelMessage.Visible:=true;
 end;
End;

Procedure MessageSilencieuxEfface(PanelMessage:TPanel;Form,FormOrg:TForm);
Begin
if Form.FindComponent('PaMessageSilencieux') <> nil then
 begin
   if PanelMessage.Visible then PanelMessage.Visible:=false;
   PanelMessage.Parent:=FormOrg;
 end;
if FormOrg.FindComponent('PaMessageSilencieux') <> nil then
 begin
   if PanelMessage.Visible then PanelMessage.Visible:=false;
   PanelMessage.Parent:=FormOrg;
 end;
End;

Function ActivationForm(Form:TForm):Boolean;
Begin
result:=false;
 if (Form <> nil) then
 if  Form.Visible then
    begin
      try
       Form.SetFocus;
       result:=true;
      except
       result:=false;
      end;
    end;
End;

procedure ChangementEtatGrille(GrDBGrid:TGrDBGrid);
begin
if GrDBGrid <> nil then
 try
   case  GrDBGrid.DataSource.DataSet.state of
   dsBrowse: begin
               case GrDBGrid.SelectedField.DataType of
  { isa  le  22/03/04 }ftBoolean:GrDBGrid.Options := [dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
                 else GrDBGrid.Options := [dgediting,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];;
               end;//fin du case
//               GrDBGrid.Options := [dgediting,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               try
               if GrDBGrid.CanFocus then
                 GrDBGrid.SetFocus;
               if GrDBGrid.InplaceEditor <> nil then
                  GrDBGrid.EditorMode:=false;
               GrDBGrid.TitreColor(true);
               except
               end;
             end;

   dsEdit:   begin
               case GrDBGrid.SelectedField.DataType of
//                 ftBoolean:GrDBGrid.Options := [dgediting,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs,dgAlwaysShowSelection];
  { isa  le  22/03/04 }ftBoolean:GrDBGrid.Options := [dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs,dgAlwaysShowSelection];
                 else GrDBGrid.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs,dgAlwaysShowSelection];
//  PB le 25-06-03               else GrDBGrid.Options := [dgediting,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs,dgAlwaysShowSelection];
               end;//fin du case
               try
               if GrDBGrid.CanFocus then
                 GrDBGrid.SetFocus;
               GrDBGrid.TitreColor(true);
               except
               end;
             end;

   dsInsert: begin
               case GrDBGrid.SelectedField.DataType of
//                 ftBoolean:GrDBGrid.Options := [dgediting,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs,dgAlwaysShowSelection];
{ isa  le  30/03/04 }ftBoolean:GrDBGrid.Options := [dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs,dgAlwaysShowSelection];
                 else GrDBGrid.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs,dgAlwaysShowSelection];
//  PB le 25-06-03                  else GrDBGrid.Options := [dgediting,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs,dgAlwaysShowSelection];
               end;//fin du case
               try
               if GrDBGrid.CanFocus then
                 GrDBGrid.SetFocus;
               GrDBGrid.TitreColor(true);
               except
               end;
             end;
   end;//fin du case.state
 except
  showmessage(ErrInterne+' : Objet Grille Mal Libéré !'+GrDBGrid.Name);
 end;
end;

procedure ChangementEtatBouttons(BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer : TButton; DataSet:TDataSet);
begin
 try
  case DataSet.state of
   dsBrowse: begin
               BtnInserer.Enabled := True;
               BtnEnregistrer.Enabled := False;
               BtnModifier.Enabled := Not(DataSet.RecordCount = 0);
               BtnSupprimer.Enabled := Not(DataSet.RecordCount = 0);
               BtnImprimer.Enabled:=true;
             end;

   dsEdit:   begin
               EnableWinControl([BtnAnnuler,BtnEnregistrer,BtnFermer],True);
               EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer,BtnImprimer],False);
             end;

   dsInsert: begin
               EnableWinControl([BtnAnnuler,BtnFermer],True);
               EnableWinControl([BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnImprimer],False);

//               ComboCompte.Enabled := False;
             end;
   end;//fin du case.state
   //Pop-up Menu
//   Fermer1.Enabled:=BtnFermer.Enabled;
//   Insrer1.Enabled:=BtnInserer.Enabled;
//   Enregister1.Enabled:=BtnEnregistrer.Enabled;
//   Modifier1.Enabled:=BtnModifier.Enabled;
//   Supprimer1.Enabled:=BtnSupprimer.Enabled;
//   Imprimer1.Enabled:=BtnImprimer.Enabled;
 except
  showmessage(ErrInterne+' : Erreur lors de l''initialisation des boutons !');
 end;
end;

Procedure InfoTailleForm(Form:TForm);
Begin
Form.caption:='Largeur : '+ IntToStr(Form.width)+ ' - Hauteur : '+ IntToStr(Form.Height);
End;


Procedure GrGridInitColonne(var GrGrille:TGrGrid;TitreColonne : array of String;ChampGrille:array of tchamp;ChampReadOnly:array of boolean; FormatMonnaie,EditFormat:String);
var
i:integer;

Begin
  try
  if high(TitreColonne)<>0 then
    Begin
       GrGrille.RowCount:=GrGrille.FixedRows+1;
       for i:=0 to GrGrille.RowCount-1 do
           GrGrille.rows[i].clear;
       GrGrille.ColCount:=high(TitreColonne)+1+GrGrille.FixedCols;
    End;
     for i:=0 to high(TitreColonne) do
      Begin
        if GrGrille.FixedRows>0 then
          GrGrille.cells[i+GrGrille.FixedCols,GrGrille.FixedRows-1]:=TitreColonne[i]
        else
          GrGrille.cells[i+GrGrille.FixedCols,0]:=TitreColonne[i];
      End;
     for i:=0 to high(ChampGrille) do
      Begin
        GrGrille.Champ.Add(ChampGrille[i]);
        GrGrille.Champ_Readonly.Bits[i]:=ChampReadOnly[i];
      End;

      //FormateMonnaieField(DataSet,FormatMonnaie,EditFormat);
  except
    showmessage('problème rencontré à l''initialisation de la grille '+GrGrille.Name+'.');
    raise
  end;
End;

Procedure FormateTailleColonne_GrGrid(GrGrille:TGrGrid;NombreDePartie:Integer;ProportionPartie:array of Integer);
var
i:integer;
Begin
  try
  if GrGrille.ColCount > 0 then
  For I := 0 to High(ProportionPartie) do
      begin
       GrGrille.ColWidths[I+1]:=((GrGrille.Width) div NombreDePartie)*ProportionPartie[I];
      end;
  except
  abort;
  end;
End;

Function SauveEtatFiche(var EtatFiche:TEtatFiche;Form:TForm):Boolean;
Begin

   result:=false;
   try
     EtatFiche.Height:=Form.Height;
     EtatFiche.Left:=Form.Left;
     EtatFiche.Position:=Form.Position;
     EtatFiche.Top:=Form.Top;
     EtatFiche.Width:=Form.Width;
     EtatFiche.WindowState:=Form.WindowState;
     result:=true;
   except

   end;
End;

Function RestaureEtatFiche(EtatFiche:TEtatFiche;Form:TForm):Boolean;
Begin

   result:=false;
   try
     Form.Height:=EtatFiche.Height;
     Form.Left:=EtatFiche.Left;
     Form.Position:=EtatFiche.Position;
     Form.Top:=EtatFiche.Top;
     Form.Width:=EtatFiche.Width;
     Form.WindowState:=EtatFiche.WindowState;
     result:=true;
   except

   end;
End;

procedure Init_TabStop_Controls(ListControl:array of tcontrol;TabStop:boolean);
var
i:integer;
Begin
  for I := 0 to High(ListControl) do
    begin
      case RecupClassTypeComponent(ListControl[i]) of
         GTEdit:(ListControl[i] as TEdit).TabStop:=TabStop;
         GTDBEdit:(ListControl[i] as TDBEdit).TabStop:=TabStop;
         GTDateEdit:(ListControl[i]as TDateEdit).TabStop :=TabStop;
         GTGrGrid:(ListControl[i]as TGrGrid).TabStop :=TabStop;
         GTDBRadioGroup:(ListControl[i]as TDBRadioGroup).TabStop :=TabStop;
         GTGrDBGrid:(ListControl[i]as TGrDBGrid).TabStop :=TabStop;
         GTRxDBComboEdit:(ListControl[i]as TRxDBComboEdit).TabStop :=TabStop;
         GTDBCheckBox:(ListControl[i]as TDBCheckBox).TabStop :=TabStop;
         GTCurrencyEdit:(ListControl[i]as TCurrencyEdit).TabStop :=TabStop;
         GTPanel:(ListControl[i]as TPanel).TabStop :=TabStop;
         GTDBDateEdit:(ListControl[i]as TDBDateEdit).TabStop :=TabStop;
         GTButton:(ListControl[i]as TButton).TabStop :=TabStop;
      end;//fin du case
    end;//fin boucle for
End;

Procedure CaptionMultiLigne(WinControl:TWincontrol);
var
i:integer;
Caption:string;
Begin
Caption:=(Wincontrol as TButton).Caption;
i:=GetWindowLong(Wincontrol.Handle,GWL_STYLE );
SetWindowLong (Wincontrol.Handle,GWL_STYLE , i or BS_MULTILINE);
(Wincontrol as TButton).Caption:=Caption;
End;


Function ScreenAjuste800600_DefinitionCourante_Horizon(Pos:Integer):Integer;
var
ProRata:Currency;
NewPos:Real;
Aux:String;
Begin
Result:=Pos;
ProRata:=1;
if Screen.Width / 800 > 1 then
 begin
   ProRata:=Screen.Width / 800;
   NewPos:=Int(Pos * ProRata);
   Aux:=FloatToStr(NewPos);
   Result:=StrToInt(Aux);
 end;
End;

Function ScreenAjuste800600_DefinitionCourante_Vertical(Pos:Integer):Integer;
var
ProRata:Currency;
NewPos:Real;
Aux:String;
Begin
Result:=Pos;
ProRata:=1;
if Screen.Height / 600 > 1 then
 begin
   ProRata:=Screen.Height / 600;
   NewPos:=Int(Pos * ProRata);
   Aux:=FloatToStr(NewPos);
   Result:=StrToInt(Aux);
 end;
End;

Function ScreenAjuste_OldDef_DefinitionCourante_Horizon(OldScW,Pos:Integer):Integer;
var
ProRata:Currency;
NewPos:Real;
Aux:String;
Begin
Result:=Pos;
ProRata:=1;
if Screen.Width / OldScW <> 1 then
 begin
   ProRata:=Screen.Width / OldScW;
   NewPos:=Int(Pos * ProRata);
   Aux:=FloatToStr(NewPos);
   Result:=StrToInt(Aux);
 end;
End;

Function ScreenAjuste_OldDef_DefinitionCourante_Vertical(OldScH,Pos:Integer):Integer;
var
ProRata:Currency;
NewPos:Real;
Aux:String;
Begin
Result:=Pos;
ProRata:=1;
if Screen.Height / OldScH <> 1 then
 begin
   ProRata:=Screen.Height / OldScH;
   NewPos:=Int(Pos * ProRata);
   Aux:=FloatToStr(NewPos);
   Result:=StrToInt(Aux);
 end;
End;

Procedure ScreenAjuste_OldDef_DefinitionCourant(OldScw,OldSch:Integer;Form:TForm);
Begin
  Form.Top:=ScreenAjuste_OldDef_DefinitionCourante_Vertical(OldScH,Form.Top);
  Form.Height:=ScreenAjuste_OldDef_DefinitionCourante_Vertical(OldScH,Form.Height);
  Form.Left:=ScreenAjuste_OldDef_DefinitionCourante_Horizon(OldScW,Form.Left);
  Form.Width:=ScreenAjuste_OldDef_DefinitionCourante_Horizon(OldScW,Form.Width);
End;

function GetCaptionSousSouris(CrPos: TPoint): string;
var
  textlength: integer;
  Text: PChar;
  handle,handle2: HWND;
  Texte:string;
begin
  Result := 'Empty';
  handle := WindowFromPoint(CrPos);
  if handle = 0 then exit;
  GetWindowText(handle,PChar(Texte),255);
  result:=Texte;
//  Handle2:=ChildWindowFromPoint(handle,CrPos);
//  if handle2 = 0 then handle2:=handle;
//  textlength := SendMessage(handle2, WM_GETTEXTLENGTH, 0, 0);
//  if textlength <> 0 then
//  begin
//    getmem(Text, textlength + 1);
//    SendMessage(handle2, WM_GETTEXT, textlength + 1, integer(Text));
//    Result := Text;
//    freemem(Text);
//  end;
end;

// On parcours d'abord le tableau de TStringlist
Function InitLisViewAvecListe(ListView:TListView ;TabTitreColonne:array of string;TabList:array of TStringList;ColonneRecherche:Boolean;Effacer:boolean):TStringList;
var
i,j,k,L, NbString:integer;
Tmp1,Tmp2:String;
Begin
result:=TStringList.Create;
if Effacer then
  begin
  ListView.Clear;
  ListView.Columns.Clear;
  ListView.Columns.Add;
  ListView.Columns[0].Width := 0;//la colonne 0 reste invisible et de taille 0
  end;
for i:=0 to high(TabTitreColonne)do
begin
    if effacer then
    begin
    ListView.Columns.Add.Caption:=TabTitreColonne[i];
    ListView.Columns[i+1].Width := 150;
    end;
 if i>0 then
   tmp1:=tmp1+';'+TabTitreColonne[i]
 else
   tmp1:=TabTitreColonne[i];
end;
result.Add(tmp1);
if ColonneRecherche then
 begin
   for i:=0 to high(TabList) do
    begin
   //  ListView.Columns.Add.Caption :=TabTitreColonne[i];
     L:=(ListView.Columns.count-1)-high(TabTitreColonne);
     for j:=0 to TabList[i].Count-1 do
      begin
        Tmp1 :=str_getstringelement((TabList[i]).Strings[j],1,';');
        ListView.Items.Add.Caption:=Tmp1;
        NbString := Str_Count_Str(';',(TabList[i]).Strings[j]);
        result.Add((TabList[i]).Strings[j]);
        for k:=1 to NbString do
         begin
         if k = 1 then
           ListView.Items[ListView.Items.Count-1].SubItems.AddObject(str_getstringelement((TabList[i]).Strings[j],k,';'),TabList[i].Objects[j])
          else
           ListView.Items[ListView.Items.Count-1].SubItems.Add(str_getstringelement((TabList[i]).Strings[j],k,';'));
         end;
      end;
    end;
 end
 else
 begin
   for i:=0 to high(TabList) do
    begin
   //  ListView.Columns.Add.Caption :=TabTitreColonne[i];
     for j:=0 to TabList[i].Count-1 do
      begin
        Tmp1 :=str_getstringelement((TabList[i]).Strings[j],1,';');
        ListView.Items.Add.Caption:=Tmp1;
        NbString := Str_Count_Str(';',(TabList[i]).Strings[j]);
        result.Add((TabList[i]).Strings[j]);
        for k:=2 to NbString do
         begin
         if k = 2 then
           ListView.Items[ListView.Items.Count-1].SubItems.AddObject(str_getstringelement((TabList[i]).Strings[j],k,';'),TabList[i].Objects[j])
          else
           ListView.Items[ListView.Items.Count-1].SubItems.Add(str_getstringelement((TabList[i]).Strings[j],k,';'));
         end;
      end;
    end;
 end;
End;



Function InitLisViewAvecListeCochable(ListView:TListView ;TabTitreColonne:array of string;TabList:array of TStringList;ListeLongueurChamp:array of integer;ColonneRecherche:Boolean;Effacer:boolean):TStringList;
var
i,j,k,L, NbString:integer;
Tmp1,Tmp2:String;
longueurChamp:array of integer;
Begin
result:=TStringList.Create;
if Effacer then
  begin
  ListView.Clear;
  ListView.Columns.Clear;
  ListView.Columns.Add;
  ListView.Columns[0].Width := 20;//la colonne 0 reste invisible et de taille 0
  end;

SetLength(longueurChamp,length(TabTitreColonne));

if(high(TabTitreColonne)<>high(ListeLongueurChamp))then
  begin
    for i:=0 to high(TabTitreColonne)do
      begin
        longueurChamp[i]:=150;
      end;
  end
else
    for i:=0 to high(ListeLongueurChamp)do
      begin
        longueurChamp[i]:=ListeLongueurChamp[i];
      end;

for i:=0 to high(TabTitreColonne)do
begin
    if effacer then
    begin
    ListView.Columns.Add.Caption:=TabTitreColonne[i];
    ListView.Columns[i+1].Width := longueurChamp[i];
    end;
 if i>0 then
   tmp1:=tmp1+';'+TabTitreColonne[i]
 else
   tmp1:=TabTitreColonne[i];
end;

result.Add(tmp1);
if ColonneRecherche then
 begin
   for i:=0 to high(TabList) do
    begin
   //  ListView.Columns.Add.Caption :=TabTitreColonne[i];
     L:=(ListView.Columns.count-1)-high(TabTitreColonne);
     for j:=0 to TabList[i].Count-1 do
      begin
        Tmp1 :=str_getstringelement((TabList[i]).Strings[j],1,';');
        ListView.Items.Add.Caption:=Tmp1;
        NbString := Str_Count_Str(';',(TabList[i]).Strings[j]);
        result.Add((TabList[i]).Strings[j]);
        for k:=1 to NbString do
         begin
         if k = 1 then
           ListView.Items[ListView.Items.Count-1].SubItems.AddObject(str_getstringelement((TabList[i]).Strings[j],k,';'),TabList[i].Objects[j])
          else
           ListView.Items[ListView.Items.Count-1].SubItems.Add(str_getstringelement((TabList[i]).Strings[j],k,';'));
         end;
      end;
    end;
 end
 else
 begin
   for i:=0 to high(TabList) do
    begin
   //  ListView.Columns.Add.Caption :=TabTitreColonne[i];
     for j:=0 to TabList[i].Count-1 do
      begin
        Tmp1 :=str_getstringelement((TabList[i]).Strings[j],1,';');
        ListView.Items.Add.Caption:=Tmp1;
        NbString := Str_Count_Str(';',(TabList[i]).Strings[j]);
        result.Add((TabList[i]).Strings[j]);
        for k:=2 to NbString do
         begin
         if k = 2 then
           ListView.Items[ListView.Items.Count-1].SubItems.AddObject(str_getstringelement((TabList[i]).Strings[j],k,';'),TabList[i].Objects[j])
          else
           ListView.Items[ListView.Items.Count-1].SubItems.Add(str_getstringelement((TabList[i]).Strings[j],k,';'));
         end;
      end;
    end;
 end;
End;

Function RemplitListEvenement(var ListeEvent:TStringList;Objet:TObject;ViderEvenement:Boolean):Boolean;
Begin
case RecupClassTypeObjet(Objet) of
  GTable:Begin
          ListeEvent.AddObject('AfterCancel',(Objet as TTable).Owner.MethodAddress('AfterCancel'));
          ListeEvent.AddObject('AfterClose',(Objet as TTable).Owner.MethodAddress('AfterClose'));
          ListeEvent.AddObject('AfterDelete',(Objet as TTable).Owner.MethodAddress('AfterDelete'));
          ListeEvent.AddObject('AfterEdit',(Objet as TTable).Owner.MethodAddress('AfterEdit'));
          ListeEvent.AddObject('AfterInsert',(Objet as TTable).Owner.MethodAddress('AfterInsert'));
          ListeEvent.AddObject('AfterOpen',(Objet as TTable).Owner.MethodAddress('AfterOpen'));
          ListeEvent.AddObject('AfterPost',(Objet as TTable).Owner.MethodAddress('AfterPost'));
          ListeEvent.AddObject('AfterCancel',(Objet as TTable).Owner.MethodAddress('AfterCancel'));
          ListeEvent.AddObject('AfterCancel',(Objet as TTable).Owner.MethodAddress('AfterCancel'));
          ListeEvent.AddObject('AfterCancel',(Objet as TTable).Owner.MethodAddress('AfterCancel'));
          ListeEvent.AddObject('AfterCancel',(Objet as TTable).Owner.MethodAddress('AfterCancel'));
          ListeEvent.AddObject('AfterCancel',(Objet as TTable).Owner.MethodAddress('AfterCancel'));
          ListeEvent.AddObject('AfterCancel',(Objet as TTable).Owner.MethodAddress('AfterCancel'));
          ListeEvent.AddObject('AfterCancel',(Objet as TTable).Owner.MethodAddress('AfterCancel'));
          ListeEvent.AddObject('AfterCancel',(Objet as TTable).Owner.MethodAddress('AfterCancel'));
          ListeEvent.AddObject('AfterCancel',(Objet as TTable).Owner.MethodAddress('AfterCancel'));
          ListeEvent.AddObject('AfterCancel',(Objet as TTable).Owner.MethodAddress('AfterCancel'));
          ListeEvent.AddObject('AfterCancel',(Objet as TTable).Owner.MethodAddress('AfterCancel'));
          ListeEvent.AddObject('AfterCancel',(Objet as TTable).Owner.MethodAddress('AfterCancel'));
          ListeEvent.AddObject('AfterCancel',(Objet as TTable).Owner.MethodAddress('AfterCancel'));
          ListeEvent.AddObject('AfterCancel',(Objet as TTable).Owner.MethodAddress('AfterCancel'));
          ListeEvent.AddObject('AfterCancel',(Objet as TTable).Owner.MethodAddress('AfterCancel'));
          ListeEvent.AddObject('AfterCancel',(Objet as TTable).Owner.MethodAddress('AfterCancel'));
          ListeEvent.AddObject('AfterCancel',(Objet as TTable).Owner.MethodAddress('AfterCancel'));
          ListeEvent.AddObject('AfterCancel',(Objet as TTable).Owner.MethodAddress('AfterCancel'));
          ListeEvent.AddObject('AfterCancel',(Objet as TTable).Owner.MethodAddress('AfterCancel'));
//                  ListeBox.items.add('AfterClose = '+(composant as TTable).Owner.MethodName(@(composant as TTable).AfterClose));
//                  ListeBox.items.add('AfterDelete = '+(composant as TTable).Owner.MethodName(@(composant as TTable).AfterDelete));
//                  ListeBox.items.add('AfterEdit = '+(composant as TTable).Owner.MethodName(@(composant as TTable).AfterEdit));
//                  ListeBox.items.add('AfterInsert = '+(composant as TTable).Owner.MethodName(@(composant as TTable).AfterInsert));
//                  ListeBox.items.add('AfterOpen = '+(composant as TTable).Owner.MethodName(@(composant as TTable).AfterOpen));
//                  ListeBox.items.add('AfterPost = '+(composant as TTable).Owner.MethodName(@(composant as TTable).AfterPost));
//                  ListeBox.items.add('AfterScroll = '+(composant as TTable).Owner.MethodName(@(composant as TTable).AfterScroll));
//                  ListeBox.items.add('BeforeCancel = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforeCancel));
//                  ListeBox.items.add('BeforeClose = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforeClose));
//                  ListeBox.items.add('BeforeDelete = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforeDelete));
//                  ListeBox.items.add('BeforeEdit = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforeEdit));
//                  ListeBox.items.add('BeforeInsert = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforeInsert));
//                  ListeBox.items.add('BeforeOpen = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforeOpen));
//                  ListeBox.items.add('BeforePost = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforePost));
//                  ListeBox.items.add('BeforeScroll = '+(composant as TTable).Owner.MethodName(@(composant as TTable).BeforeScroll));
//                  ListeBox.items.add('OnCalcFields = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnCalcFields));
//                  ListeBox.items.add('OnDeleteError = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnDeleteError));
//                  ListeBox.items.add('OnEditError = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnEditError));
//                  ListeBox.items.add('OnFilterRecord = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnFilterRecord));
//                  ListeBox.items.add('OnNewRecord = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnNewRecord));
//                  ListeBox.items.add('OnPostError = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnPostError));
//                  ListeBox.items.add('OnServerYield = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnServerYield));
//                  ListeBox.items.add('OnUpdateError = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnUpdateError));
//                  ListeBox.items.add('OnUpdateRecord = '+(composant as TTable).Owner.MethodName(@(composant as TTable).OnUpdateRecord));
//
         End;
  GTQuery: ;
else
 begin
  Showmessage('Cet Objet n''est pas traité par RemplitListEvenement!');
 end;
end;

End;


END.

