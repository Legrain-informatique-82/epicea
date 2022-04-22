unit AffectImmoCptCOGERE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, StdCtrls, RXCtrls, jpeg, ExtCtrls,
  LibZoneSaisie,
  E2_Librairie_Obj,
  GR_Librairie_Obj,
  lib1,
  LibDates,
  LibImport,
  Lib_Chaine,
  E2_Decl_REcords,
  DMPlanCpt,
  E2_AideCompte,
  E2_LibInfosTable,
  ComCtrls,
  GrGrid,
  Editions,
  ObjetEdition,
  Menus,
  LibfichRep,
  LibRessourceString,
  E2_VisuListeView,
  LibSQL;

type
  TAffectImmosCptCOGERE = class(TForm)
    PaFond: TPanel;
    PaTitrePetit: TPanel;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaBtn: TPanel;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    BtnDetail: TButton;
    BtnEnregistrer: TButton;
    PaBas: TPanel;
    PaGauche: TPanel;
    PaGhaut: TPanel;
    PaTitre1: TPanel;
    PaListeCodeCompte: TPanel;
    VLECodeCompte: TValueListEditor;
    PaListeImmo: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    LVImmos: TListView;
    PaCentre: TPanel;
    PaDroit: TPanel;
    GrListeImmos: TGrGrid;
    Patitre2: TPanel;
    PopupMenu1: TPopupMenu;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Verifier1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    BtnVerification: TButton;
    procedure FormCreate(Sender: TObject);
    procedure VLECodeCompteSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    Function InitListView(CodeImmo:String;AffMess:Boolean):Boolean;
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    Function InitGrListeImmo:Boolean;
    procedure BtnDetailClick(Sender: TObject);
    Function AffectationDesLignes:Boolean;
    procedure GrListeImmosRowValidate(Sender: TObject; var Valide,
      Action: Boolean; LastCol: Integer);
    Function CtrlSaisieCompte(var Compte:String):TExceptLGR;
    Function CtrlToutesLignesCompte(Compte:String):TExceptLGR;
    procedure GrListeImmosDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Aide1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnVerificationClick(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);

  private
    { D�clarations priv�es }
    ListLigneNonOk:TStringList;
    ParametreFichierImmos:TParamFichier;

     function CalculSoldeCompte(Compte:Tstringlist;Source:TGrGrid;CellCpt,CellTotaux:integer):Tstringlist;overload;
     function CalculSoldeCompte(Compte:string;Source:TGrGrid;CellCpt,CellTotaux:integer):Tstringlist;overload;
     Function CtrlSoldeCompte(Compte:TListview):TExceptLGR;overload;
     Function CtrlSoldeCompte(Compte:String):TExceptLGR;overload;

  public
    { D�clarations publiques }
    ListeImmos:TList;
  end;

var
  AffectImmosCptCOGERE: TAffectImmosCptCOGERE;
  ModeVerif:Boolean;

  Function AffichAffectImmosCptCOGERE(Liste:TList;ParamFichierImmos:TParamFichier):Boolean;

//  Function AffichAffectImmosCptCOGERE(var Liste:TList):Boolean;

implementation

uses DMImmosOuverture, DMRecherche,DMImportation;


{$R *.dfm}

Function AffichAffectImmosCptCOGERE(Liste:TList;ParamFichierImmos:Tparamfichier):Boolean;
var
i:integer;
Begin
 if AffectImmosCptCOGERE = nil then AffectImmosCptCOGERE:=TAffectImmosCptCOGERE.Create(Application.MainForm);
 AffectImmosCptCOGERE.ListeImmos.Assign(Liste);
 AffectImmosCptCOGERE.ParametreFichierImmos:=ParamFichierImmos;
 AffectImmosCptCOGERE.InitGrListeImmo;
 if AffectImmosCptCOGERE.ShowModal = mrOk then
   begin
      for i:=0 to AffectImmosCptCOGERE.ListeImmos.Count-1 do
       Begin
        PImport_CIMO_SIEA2I(AffectImmosCptCOGERE.ListeImmos.Items[i])^.NumCpt := AffectImmosCptCOGERE.GrListeImmos.Cells[3,i+1];
        Liste.Assign(AffectImmosCptCOGERE.ListeImmos);
       End;
     result:=true;
   end
  else
   begin
     result:=False;
   end;

End;


procedure TAffectImmosCptCOGERE.FormCreate(Sender: TObject);
begin
  try
    try
     VLECodeCompte.Strings.LoadFromFile(E.RepertoireProgram+'defImmos.txt');
    except
     showmessage('Fichier defImmos.txt introuvable !');
    end;
  Finally
    ListeImmos:=TList.Create;
    ListLigneNonOk:=TStringList.Create;
  end;
end;

procedure TAffectImmosCptCOGERE.VLECodeCompteSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
//showmessage(VLECodeCompte.Cells[ACol,ARow]);
end;

Function TAffectImmosCptCOGERE.InitListView(CodeImmo:String;AffMess:Boolean):Boolean;
var
ListImmosStr:TStringList;
i:integer;
Begin
try
ListImmosStr:=TStringList.Create;
ListImmosStr.Clear;
//le remplissage de la liste doit se faire � partir de la balance SIEA2
ListImmosStr:=DMImport.Import_SoldeCptImmos_SIEA_DOS(ParametreFichierImmos.Repertoire,ParametreFichierImmos.NomFichierBal,dmplan.TaPlanCpt);////
ListImmosStr:=CalculSoldeCompte(ListImmosStr,GrListeImmos,3,1);
LVImmos.Clear;
//if VisuListeView=nil then VisuListeView:=TVisuListeView.Create(application.MainForm);
if ListImmosStr.Count<>0 then
  InitLisViewAvecListe(LVImmos,['compte','Balance D�bit','Balance Cr�dit','Immo D�bit','Immo Cr�dit'],[ListImmosStr],false);

// VisuListeView.TabStr := [1];
// VisuListeView.TabCurr := [2..5];
// VisuListeView.TabDate := [];
//LVImmos.OnColumnClick:=VisuListeView.ListView1ColumnClick;
//LVImmos.OnColumnClick(LVImmos,LVImmos.Column[1]);
if not CtrlSoldeCompte(LVImmos).retour then
 begin
  if AffMess then
   showmessage('Pas �quilibr�');
 end;
except
  abort;
end;//fin du try except
//
End;

procedure TAffectImmosCptCOGERE.FormDestroy(Sender: TObject);
begin
Initialise_TList(ListeImmos,self);
//ListeImmos.Free;
//ListLigneNonOk.Free; { isa  le  02/12/04 }
Initialise_TStringlist(ListLigneNonOk,self);
AffectImmosCptCOGERE:=nil;
end;

procedure TAffectImmosCptCOGERE.FormShow(Sender: TObject);
begin
GrGridInitColonne(GrListeImmos,['Immobilisations','Montant','Code SIEA2I','Compte'],[grtous,grcurr,grtous,grcompte],[True,true,True,false],E.FormatMonnaie,E.EditFormat);
GrListeImmos.TextADroite := false;
GrListeImmos.JustifieChampCurr := true;
ModeVerif:=false;
AffectImmosCptCOGERE.InitGrListeImmo;
//AffectationDesLignes;
InitListView('',false);
GrListeImmos.Col := GrListeImmos.ColCount-1;

//GrListeImmos.Champ_Readonly.Bits[0] := true;
//GrListeImmos.Champ_Readonly.Bits[1] := true;
//GrListeImmos.Champ_Readonly.Bits[2] := true;
end;

procedure TAffectImmosCptCOGERE.BtnEnregistrerClick(Sender: TObject);
begin
if not CtrlSoldeCompte(LVImmos).retour then
 begin
  showmessage('Il y a un d�s�quilibre entre les soldes de la balance et les comptes d''immobilisation');
  BtnImprimer.Click;
  ModalResult:=mrOK;
 end;
if not CtrlToutesLignesCompte('').retour then
  Begin
    showmessage('Toutes les immobilisations ne sont pas correctement affect�es');
    ModalResult:=mrOK;
  end;
Screen.Cursor := crHourGlass;
end;

procedure TAffectImmosCptCOGERE.BtnFermerClick(Sender: TObject);
begin
 ModalResult:=mrCancel;
//  AffectImmosCptCOGERE.InitGrListeImmo;
end;

Function TAffectImmosCptCOGERE.InitGrListeImmo:Boolean;
var
i:integer;
begin
 for i:=1 to GrListeImmos.rowcount-1 do
    GrListeImmos.rows[i].clear;
  GrListeImmos.RowCount := 2;
  GrListeImmos.ParamColor:=true;
  GrListeImmos.Param:=ParamUtil.CouleurDBGrid;
  GrListeImmos.DessineContourLigne:=false;
  GrListeImmos.UpDateColor;

  for i:=0 to ListeImmos.Count-1 do
   Begin
    if i > 0 then
    GrListeImmos.AjouteLigne;
    GrListeImmos.Cells[0,i+1] := PImport_CIMO_SIEA2I(ListeImmos.Items[i])^.Designation;
    GrListeImmos.Cells[1,i+1] := str_QueDesChiffresCurr(PImport_CIMO_SIEA2I(ListeImmos.Items[i])^.ValeurAAmortir);
    GrListeImmos.Cells[2,i+1] := PImport_CIMO_SIEA2I(ListeImmos.Items[i])^.CodeCompte;
   End;
//  GrListeImmos.SupprimeLigne(GrListeImmos.RowCount-1);
End;

procedure TAffectImmosCptCOGERE.BtnDetailClick(Sender: TObject);
var
StrTmp:String;
begin
try
  Screen.Cursor := crHourGlass;
  StrTmp:= self.Caption;
  self.Caption := 'Affectation en cours ....';
  AffectImmosCptCOGERE.InitGrListeImmo;
  AffectationDesLignes;
  InitListView('',true);
  GrListeImmos.Col := GrListeImmos.ColCount-1;
finally
 Screen.Cursor := crDefault;
 self.Caption := StrTmp;
end;
end;

Function TAffectImmosCptCOGERE.AffectationDesLignes:Boolean;
var
i,j:integer;
ErreurSaisie:TExceptLGR;
compte:string;
Begin
try
  ModeVerif:=true;
  GrListeImmos.Col := 3;
  GrListeImmos.Row:=1;
  for i:=1 to GrListeImmos.RowCount-1 do
   Begin
     if VLECodeCompte.FindRow(GrListeImmos.Cells[2,i],J) then
      begin
       compte := VLECodeCompte.Cells[1,J];
       ErreurSaisie:=CtrlSaisieCompte(compte);
       if ErreurSaisie.retour then
         GrListeImmos.Cells[3,i] := compte
         else
         GrListeImmos.Cells[3,i] := '';
      end;
   End;
finally
ModeVerif:=false;
end;
End;

procedure TAffectImmosCptCOGERE.GrListeImmosRowValidate(Sender: TObject;
  var Valide, Action: Boolean; LastCol: Integer);
var
ErreurSaisie:TExceptLGR;
compte:string;
begin
try
compte:=GrListeImmos.Cells[3,GrListeImmos.Row];
ErreurSaisie:=CtrlSaisieCompte(Compte);
InitListView('',true);
except
//  case ErreurSaisie.NumErreur of
//  1001,
//  1002,
//  1003,
//  1004:
        Begin
          abort;
        End;
//  end;//fin du case
end;//fin du try except
end;

Function TAffectImmosCptCOGERE.CtrlSaisieCompte(var Compte:String):TExceptLGR;
var
MessDerSub:Boolean;
_1002:Boolean;
InplaceEdit:TinplaceEdit;
Begin
try//finally
Try//except
Initialise_ExceptLGR(result);
 InplaceEdit:=TInplaceEdit.Create(self);
 MessDerSub:=not ModeVerif;
 if empty(Compte) then
    raise ExceptLGR.Create('Le num�ro de compte est obligatoire !',1001,not ModeVerif,mtError,result);
// _1002 := VerifSiCompteSaisieDsBO(Compte,FAlse,DMImmos_Ouverture.taDetailImmo);


 DMImmos_Ouverture.GestionFiltrageAideCompte('%');
  InplaceEdit.Text:=Compte;
  if not AideCompteDansContexte(Compte,InplaceEdit,['Rac1'],false,MessDerSub,not ModeVerif,true,false,false,0) then
   raise ExceptLGR.Create('Pas de message',1003,False,mtError,result);
  compte:=InplaceEdit.Text;
//  GrListeImmos.Cells[3,GrListeImmos.row]:=InplaceEdit.Text;
//  if result.retour then result.retour:=((ListeExclus.IndexOf(copy(editcourant.asstring,1,3))=-1) and (ListeExclus.IndexOf(copy(editcourant.asstring,1,2))=-1));
//  Infosplancpt:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[Compte]);
//  result.retour:=Infosplancpt.Immobilisation;
  DeFiltrageDataSet(DMRech.TaPlanCptRech);
  if not Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[Compte]).Immobilisation then
   raise ExceptLGR.Create('Le compte '+Compte+' n''est pas un compte marqu� comme immobilisable.',1004,not ModeVerif,mtError,result);

{ isa  le  18/02/04 }
// if VerifSiCompteSaisieDsBO(Compte,true,DMImmos_Ouverture.taDetailImmo) then
//    raise ExceptLGR.Create('Le compte '+Compte+' est utilis� dans le Bilan d''Ouverture.',1002,not ModeVerif,mtError,result);
{ isa  le  18/02/04 }

//  if _1002 then
//    raise ExceptLGR.Create('Le compte '+Compte+' est utilis� dans le Bilan d''Ouverture.',1002,False,mtError,result);
 result.retour := true;
except
result.retour := false;
if not ModeVerif then abort;
end;
finally
  InplaceEdit.free;
end;
End;

Function TAffectImmosCptCOGERE.CtrlToutesLignesCompte(Compte:String):TExceptLGR;
var
i,j:integer;
Begin
try
  ModeVerif:=true;
  ListLigneNonOk.Clear;
  for i:=1 to GrListeImmos.RowCount-1 do
   Begin
       Compte:=GrListeImmos.Cells[3,i];
       if not CtrlSaisieCompte(Compte).retour then
        ListLigneNonOk.Add(IntToStr(i));
   End;
  GrListeImmos.Refresh;
Finally
  result.retour:=ListLigneNonOk.Count=0;
  ModeVerif:=False;
end;
End;

procedure TAffectImmosCptCOGERE.GrListeImmosDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
HoldColor:TColor;
begin
 if ModeVerif then
  if ((Arow > 1) and (ACol=3)) then
    if ListLigneNonOk.IndexOf(IntTosTr(ARow)) <> -1 then
     begin
//  HoldColor:=GrGrandLivre.Brush.Color;
//  GrGrandLivre.Canvas.Brush.Color :=clWhite;
////  GrGrandLivre.Canvas.Brush.Color :=cl3DLight;
//  GrGrandLivre.Canvas.FillRect(Rect);
//  GrGrandLivre.Canvas.TextRect(Rect,Rect.BottomRight.x-4-GrGrandLivre.Canvas.TextWidth(GrGrandLivre.Cells[col,row]),Rect.TopLeft.y+3,GrGrandLivre.Cells[col,row]);
//  GrGrandLivre.Brush.Color:=HoldColor;

        HoldColor:=GrListeImmos.Brush.Color;
        GrListeImmos.Canvas.Brush.Color :=cl3DLight;
        GrListeImmos.Canvas.FillRect(Rect);
        GrListeImmos.Canvas.TextRect(Rect,Rect.BottomRight.x-4-GrListeImmos.Canvas.TextWidth(GrListeImmos.Cells[Acol,Arow]),Rect.TopLeft.y+3,GrListeImmos.Cells[Acol,Arow]);
        GrListeImmos.Brush.Color:=HoldColor;
       end;
end;

procedure TAffectImmosCptCOGERE.Aide1Click(Sender: TObject);
var
MessDerSub:boolean;
begin
if ActiveControl = GrListeImmos then
 begin
    MessDerSub:=false;
    //DMImmos_Ouverture.FiltrageAideCompte(36);
    DMImmos_Ouverture.GestionFiltrageAideCompte('%');

    AideCompteDansContexte(GrListeImmos.Cells[3,GrListeImmos.row],GrListeImmos,['Rac1'],true,MessDerSub,false,true,false,false,0);
//    AideCompteDansContexte(GrListeImmos.Cells[3,GrListeImmos.row],GrListeImmos,['Rac1'],true,MessDerSub,false,true,false,false,0);
    MessDerSub:=true;
 end;
end;

procedure TAffectImmosCptCOGERE.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = VK_ESCAPE then
 self.ModalResult := mrCancel;
end;

procedure TAffectImmosCptCOGERE.BtnVerificationClick(Sender: TObject);
begin
if not CtrlSoldeCompte(LVImmos).retour then
 begin
  showmessage('Il y a un d�s�quilibre entre les soldes de la balance et les comptes d''immobilisation');
 end;
if not CtrlToutesLignesCompte('').retour then
  Begin
    showmessage('Toutes les immobilisations ne sont pas correctement affect�es');
  end;
end;


function TAffectImmosCptCOGERE.CalculSoldeCompte(Compte:Tstringlist;Source:TGrGrid;CellCpt,CellTotaux:integer):Tstringlist;
var
i,j:integer;
exceptLGR_:TexceptLGR;
SoldeDebit,SoldeCredit:currency;
Trouve:boolean;
begin
try
Initialise_ExceptLGR(exceptLGR_);
if Compte=nil then raise ExceptLGR.Create('La liste des comptes est nil',1003,False,mtError,exceptLGR_);
if Source=nil then raise ExceptLGR.Create('La Source est nil',1003,False,mtError,exceptLGR_);
result:=TStringList.Create;
//rajouter dans liste tous les comptes de la grille source qui n''existent pas dans la liste
for j:=1 to source.rowcount-1 do
  Begin
    i:=0;
    trouve:=false;
    if not empty(source.Cells[CellCpt,j])then
        begin//si compte rempli
            while ((i<=compte.Count-1)and(not Trouve)) do
              Begin
                Trouve:=str_getstringelement(compte.Strings[i],1,';')=source.Cells[CellCpt,j];
                inc(i);
              end;
            if not trouve then compte.add(source.Cells[CellCpt,j]+';0;0;');
        end;//fin si compte rempli
  end;
///
for i:=0 to Compte.Count-1 do
  Begin
    SoldeDebit:=0;
    SoldeCredit:=0;
    for j:=1 to source.rowcount-1 do
      Begin
        if str_getstringelement(compte.Strings[i],1,';')=source.Cells[CellCpt,j] then
          begin
            if copy(source.Cells[CellCpt,j],1,2)='13'then
              SoldeCredit:=SoldeCredit+ StrToCurr_lgr(source.Cells[CellTotaux,j])
            else
              SoldeDebit:=SoldeDebit+ StrToCurr_lgr(source.Cells[CellTotaux,j]);
          end;
      end;
    result.Add(compte.Strings[i]+currtostr(SoldeDebit)+';'+currtostr(SoldeCredit)+';');
  end;//fin boucle for
except
  result.Free;
  abort;
end;
end;

function TAffectImmosCptCOGERE.CalculSoldeCompte(Compte:string;Source:TGrGrid;CellCpt,CellTotaux:integer):Tstringlist;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(retour);
  try
   Maliste:=TStringList.Create;
   if not empty (Compte)then
     Maliste.Add(Compte)
   else
     raise ExceptLGR.Create('Aucun compte n''est defini !',1000,true,mtError,Retour);
   Result:=CalculSoldeCompte(Maliste,Source,CellCpt,CellTotaux);
  except
     abort;
  end;
end;

Function TAffectImmosCptCOGERE.CtrlSoldeCompte(Compte:TListview):TExceptLGR;
var
i:integer;
SoldeImmos,SoldeBalance:currency;
Begin
try
result.retour:=true;
i:=0;
while ((i<=Compte.Items.Count-1)and(result.retour)) do
  Begin
    if ((compte.items[i].SubItems.Strings[0]<>'0')or   //
        (compte.items[i].SubItems.Strings[1]<>'0')or
        (compte.items[i].SubItems.Strings[2]<>'0')or
        (compte.items[i].SubItems.Strings[3]<>'0')) then
      Begin//s'il y a un solde, je rentre dans la condition
        SoldeBalance:=StrToCurr_lgr(compte.items[i].SubItems.Strings[0])-StrToCurr_lgr(compte.items[i].SubItems.Strings[1]);
        SoldeImmos:=StrToCurr_lgr(compte.items[i].SubItems.Strings[2])-StrToCurr_lgr(compte.items[i].SubItems.Strings[3]);
        result.retour:=((soldebalance=SoldeImmos)or(abs(soldebalance-SoldeImmos)<0.05));
      end;
    inc(i);
  end;
except
  result.retour:=false;
end;
End;

Function TAffectImmosCptCOGERE.CtrlSoldeCompte(Compte:String):TExceptLGR;
var
Maliste:TListview;
Retour:TExceptLGR;
begin
  try
   Maliste:=TListview.Create(self);
   if not empty (Compte)then
     Maliste.Items.Add.Caption:=compte
   else
     raise ExceptLGR.Create('Aucun compte n''est defini !',1000,true,mtError,Retour);
   Result:=CtrlSoldeCompte(Maliste);
  except
     abort;
  end;
End;

procedure TAffectImmosCptCOGERE.BtnImprimerClick(Sender: TObject);
var
ListeValeur:TStringList;
i:integer;
ObjPrn:TObjetEdition;
begin
try//finally
ListeValeur:=TStringList.Create;
ObjPrn:=TObjetEdition.Create(self);
for i:=0 to LVImmos.Items.Count-1 do
 Begin
   ListeValeur.Add('0'+
               ';'+
               GereLibelle(LVImmos.Items[i].Caption)+
               ';'+
               GereLibelle(LVImmos.Items[i].SubItems.Strings[0])+
               ';'+
               GereLibelle(LVImmos.Items[i].SubItems.Strings[1])+
               ';'+
               GereLibelle(LVImmos.Items[i].SubItems.Strings[2])+
               ';'+
               GereLibelle(LVImmos.Items[i].SubItems.Strings[3])
               );
 End;
 ObjPrn.FTitreEdition := 'Etat des Immobilisations Import�es � l''ouverture';
 ObjPrn.FTitre2Edition :='P�riode du '+DateInfos(E.DatExoDebut).DateStr+' au '+DateInfos(E.DatExoFin).DateStr;
 ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
 ListeValeur.Insert(0,' Compte ; Balance D�bit ; Balance Cr�dit ; Immos D�bit ; Immos Cr�dit ');
 ListeValeur.Insert(1,'0.6;0.8;0.8;0.8;0.8');
 ListeValeur.Insert(2,'texte;curr;curr;curr;curr');
 ObjPrn.AffichageImp(ListeValeur);
// if not DirectoryExists(E.RepertoireImportEPI_DOS) then ForceDirectories(E.RepertoireImportEPI_DOS);
// ListeValeur.SaveToFile(E.RepertoireImportEPI_DOS+'\JOURN_IMMOS_'+E.NomDossier+'.txt');
// if not DirectoryExists(E.RepertoireImportEPI_DOS) then ForceDirectories(E.RepertoireImportEPI_DOS);
   ListeValeur.SaveToFile(CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_SIEA)+'Edition_'+ChangeExtensionFichier(ParametreFichierImmos.NomFichier,'txt'));

finally
     LibereObjet(Tobject(ObjPrn),Self);
//   ObjPrn.destroy;
end;
end;




end.
