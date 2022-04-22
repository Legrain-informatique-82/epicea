unit E2_ModifEcriture;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid, StdCtrls,
  RXCtrls, jpeg, ExtCtrls,
  Lib1,
  E2_Librairie_Obj,
  Gr_Librairie_Obj,
  LibGestionParamXML,
  DMConstantes,
  DB,
  lib_chaine,
  LibRessourceString,
  LibZoneSaisie,
  DMModifEcritures, GrGrid, Menus, Gauges;

type
  TParamAfficheModifEcriture=record
   Affiche:Boolean;
   AffichageModal:Boolean;
   TitreForm:String;
   SousTitreForm:String;
   ecritureEnCours:integer;
   PieceEnCours:integer;
  end;

  TModifEcriture = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaGrille: TPanel;
    PaBtn: TPanel;
    BtnEnregistrer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    PaBas: TPanel;
    GrGrid1: TGrGrid;
    BtnAnnuler: TButton;
    BtnInserer: TButton;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Insrer1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    N2: TMenuItem;
    Prcdent1: TMenuItem;
    Suivant1: TMenuItem;
    BtnSupprimer: TButton;
    Complmentligne1: TMenuItem;
    AidesaisiemontantRestant: TMenuItem;
    infoscomplmentaires1: TMenuItem;
    PaCumul1: TPanel;
    Panel6: TPanel;
    GrGrid3: TGrGrid;
    PaCumul2: TPanel;
    Panel7: TPanel;
    Gauge1: TGauge;
    GrGrid2: TGrGrid;
    Panel1: TPanel;
    Label17: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LaCode: TLabel;
    LaType: TLabel;
    Label7: TLabel;
    LaDateTva: TLabel;
    Label8: TLabel;
    LaTaux: TLabel;
    Label2: TLabel;
    LaComptePlan: TLabel;
    Label11: TLabel;
    LaTiers: TLabel;
    Panel3: TPanel;
    Label1: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    LaPointee: TLabel;
    LaDeclaree: TLabel;
    LaDecrite: TLabel;
    Label3: TLabel;
    Panel2: TPanel;
    Label19: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure GrGrid1ColExit(OldColonne, LastRow: Integer);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrGrid1RowExit(sender: TObject; LastRow: Integer);
    procedure Aide1Click(Sender: TObject);
    procedure Complmentligne1Click(Sender: TObject);
    procedure MontantRestantClick(Sender: TObject);
    procedure GrGrid1Change(Sender: TObject);
    procedure infoscomplmentaires1Click(Sender: TObject);
    Procedure CalculSolde;
    procedure GrGrid1RowEnter(sender: TObject; NewRow: Integer);
    Procedure InfosLigne(Ligne:integer);
    procedure PaGrilleResize(Sender: TObject);
    Procedure ReactualiserInterface(rowgrille:integer);
    Procedure changementEtatBoutons(Etat : TDataSetState);
    procedure GrGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure GrGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Calculatrice1Click(Sender: TObject);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    TitreForm,SousTitreForm:String;
    ecritureEnCours:integer;
    PieceEnCours:integer;
  end;

var
  ModifEcriture: TModifEcriture;
  RetourDM:TinfosDMModifEcriture;
  Function ModifEcritureAffiche(ParamAfficheModifEcriture:TParamAfficheModifEcriture):TinfosDMModifEcriture;

implementation

uses LibClassObjetSenders, E2_Decl_Records;

{$R *.dfm}

procedure TModifEcriture.FormCreate(Sender: TObject);
begin
    try
      LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        InitialiseFormPosDefaut(self);
	//Left:= 30; Top:= 70; Width:= screen.Width-60; Height:= screen.Height-top-30;
    end;

GrGrid1.ParamColor:=true;
GrGrid1.Param:=ParamUtil.CouleurDBGrid;
GrGrid1.UpDateColor;

  GrGrid2.ParamColor:=true;
  GrGrid2.Param:=ParamUtil.CouleurDBGrid;
  GrGrid2.DessineContourLigne:=false;
  GrGrid2.UpDateColor;

  GrGrid3.ParamColor:=true;
  GrGrid3.Param:=ParamUtil.CouleurDBGrid;
  GrGrid3.DessineContourLigne:=false;
  GrGrid3.UpDateColor;

GrGridInitColonne(grgrid1,['Compte','Désignation','Qté1','Qté2','Débit    (Charges)','Crédit    (Produits)','Mt TVA'],[grtous,grcompte,Grtous,grcurr,grcurr,grcurr,grcurr,grcurr],[True,false,false,True,true,false,false,true],E.FormatMonnaie,E.EditFormat);

grgrid1.TextADroite:=false;
grgrid1.AjoutAuto:=false;
GrGrid1.ColCount:=8;
GrGrid1.Align:=alClient;
//GrGrid1.Options:=[goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,goEditing, goTabs,goDrawFocusSelected];
GrGrid1.Options:=[goVertLine, goHorzLine,goEditing, goTabs,goDrawFocusSelected];
GrGrid1.RowCount:=2;
GrGrid1.NumDecimal:=2;
end;


Function ModifEcritureAffiche(ParamAfficheModifEcriture:TParamAfficheModifEcriture):TinfosDMModifEcriture;
var
ParamDMModifEcriture:TParamDMModifEcriture;
Begin
try
 if (ModifEcriture = nil) then ModifEcriture:=TModifEcriture.Create(Application.MainForm);
 if not empty(ParamAfficheModifEcriture.TitreForm) then
   ModifEcriture.TitreForm:=ParamAfficheModifEcriture.TitreForm;
 ModifEcriture.SousTitreForm:=ParamAfficheModifEcriture.SousTitreForm;
 if ParamAfficheModifEcriture.ecritureEnCours<=0 then   raise ExceptLGR.Create('Ecriture non modifiable',0,false,mtError);
 ModifEcriture.ecritureEnCours:=ParamAfficheModifEcriture.ecritureEnCours;
 ModifEcriture.PieceEnCours:=ParamAfficheModifEcriture.PieceEnCours;
 ParamDMModifEcriture.ModifEcritureDataStateChange :=ModifEcriture.changementEtatBoutons;
 ParamDMModifEcriture.ModifInterfaceObjet:= ModifEcriture.ReactualiserInterface;
 ParamDMModifEcriture.EcritureEnCours:=ModifEcriture.ecritureEnCours;
 RetourDM:=InitialiseDMModifEcriture(ParamDMModifEcriture);

 if ParamAfficheModifEcriture.Affiche then
  begin
//   if ParamAfficheModifEcriture.AffichageModal then
       if RetourDM.retour then result.retour:=ModifEcriture.ShowModal=mrok;
//    else
//     ModifEcriture.Show;
  end;
  
if result.retour then
  Begin
      result.Compte:=Tecriture(DMListeEcriture.ListeEcriture.Items[0]).CompteAffiche;
      result.Libelle:=Tecriture(DMListeEcriture.ListeEcriture.Items[0]).Libelle;
      result.Qt1:=Tecriture(DMListeEcriture.ListeEcriture.Items[0]).Qt1;
      result.Qt2:=Tecriture(DMListeEcriture.ListeEcriture.Items[0]).Qt2;
      result.Debit:=Tecriture(DMListeEcriture.ListeEcriture.Items[0]).Debit;
      result.Credit:=Tecriture(DMListeEcriture.ListeEcriture.Items[0]).Credit;
  end;
finally
if DMModifEcriture<>nil then
 DMModifEcriture.Free;
if ModifEcriture<>nil then ModifEcriture.free;
end;
End;

procedure TModifEcriture.FormActivate(Sender: TObject);
begin
ReactualiserInterface(grgrid1.Row);
end;

procedure TModifEcriture.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnInserer,BtnEnregistrer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TModifEcriture.BtnEnregistrerClick(Sender: TObject);
begin
  try//except
    GrGrid1ColExit(grgrid1.Col,grgrid1.Row);
    DMListeEcriture.EnregistrementListeEcriture;
    modalresult:=Mrok;
  except
    modalresult:=Mrnone;
//    raise;
  end;
end;

procedure TModifEcriture.FormDestroy(Sender: TObject);
begin
     LibGestionParamXML.DestroyForm(Self,E.USer);
     ModifEcriture:=Nil;
end;

procedure TModifEcriture.BtnInsererClick(Sender: TObject);
var
i,j,RangVide:integer;
newEcriture:Tecriture;
begin
  try //except
//      if Tecriture(DMListeEcriture.ListeEcriture.Items[0]).MontantDisponible.Solde>0 then
//      begin//si montant disponible
          GrGrid1ColExit(grgrid1.Col,grgrid1.Row);
          RangVide:=-1;
          for i:=0 to DMListeEcriture.ListeEcriture.count-1 do
            begin
                if Tecriture(DMListeEcriture.ListeEcriture.Items[i]).RowGrille=Grgrid1.Row then
                  begin
                   newEcriture:=Tecriture(DMListeEcriture.ListeEcriture.Items[i]).Division;
                   ///ajout de la ligne
                    //grgrid1.ajouteLigne;
                    grgrid1.InsertLigne(grgrid1.rowcount);
                    j:=0;
                    while ((RangVide=-1) and (J<grgrid1.RowCount))do
                      begin
                        if grgrid1.LigneVide(j) then
                          RangVide:=j;
                        inc(j);
                      end;
                    if RangVide=-1 then
                      raise ExceptLGR.Create('Erreur à la création de la ligne',0,true,mtError);
                     //fin ajout de la ligne
                    newEcriture.RowGrille:=RangVide;
                    DMListeEcriture.AjoutEcriture(newEcriture);
                    if not empty(newEcriture.Tiers) then
                      Grgrid1.cells[1,RangVide]:=newEcriture.Tiers
                    else
                      Grgrid1.cells[1,RangVide]:=newEcriture.CompteAffiche;
                    Grgrid1.cells[2,RangVide]:=newEcriture.Libelle;
                    Grgrid1.cells[3,RangVide]:=currtostr_lgr(newEcriture.Qt1);
                    Grgrid1.cells[4,RangVide]:=currtostr_lgr(newEcriture.Qt2);
                    Grgrid1.cells[5,RangVide]:=currtostr_lgr(newEcriture.Debit);
                    Grgrid1.cells[6,RangVide]:=currtostr_lgr(newEcriture.Credit);
               end;
        end;
//      end;//fin si montant disponible
//    else
DMListeEcriture.DispatcherTVA;
ModifEcriture.changementEtatBoutons(newEcriture.Etat);
CalculSolde;
InfosLigne(Grgrid1.Row);
  except
//    raise;
  end;
end;

procedure TModifEcriture.GrGrid1ColExit(OldColonne, LastRow: Integer);
var
valeurRetour:string;
RangListeCourant:integer;
begin
try
RangListeCourant:=DMListeEcriture.CorrespondanceRangListe(LastRow) ;
if RangListeCourant<>-1 then
with Tecriture(DMListeEcriture.ListeEcriture.items[RangListeCourant]) do
  case OldColonne of
    1:begin//col compte
          valeurRetour:=CompteAffiche;
          CompteAffiche:=grgrid1.Cells[OldColonne,LastRow];
      end;
    2:begin//col Libelle
        valeurRetour:=Libelle;
        Libelle:=grgrid1.Cells[OldColonne,LastRow];
      end;
    3:begin//col Qt1
        valeurRetour:=currtostr_lgr(Qt1);
        Qt1:=strtocurr_lgr(grgrid1.Cells[OldColonne,LastRow]);
      end;
    4:begin//col Qt2
        valeurRetour:=currtostr_lgr(Qt2);
        Qt2:=strtocurr_lgr(grgrid1.Cells[OldColonne,LastRow]);
      end;
    5:begin//col Debit
        valeurRetour:=currtostr_lgr(Debit);
        Debit:=strtocurr_lgr(grgrid1.Cells[OldColonne,LastRow]);
      end;
    6:begin//col Credit
        valeurRetour:=currtostr_lgr(Credit);
        Credit:=strtocurr_lgr(grgrid1.Cells[OldColonne,LastRow]);
      end;
  end;//fin du case Acol
if OldColonne in [5,6]then
    begin
      DMListeEcriture.DispatcherTVA;
      CalculSolde;
      InfosLigne(grgrid1.Row);
    end;

except
  grgrid1.Cells[OldColonne,LastRow]:=valeurRetour;
  raise;
end;


end;

procedure TModifEcriture.BtnAnnulerClick(Sender: TObject);
begin
ModalResult:=mrcancel;
end;

procedure TModifEcriture.BtnFermerClick(Sender: TObject);
begin
ModalResult:=mrcancel;
end;

procedure TModifEcriture.BtnSupprimerClick(Sender: TObject);
var
valeurRetour:string;
RangListeCourant:integer;
begin
  try//except
    RangListeCourant:=DMListeEcriture.CorrespondanceRangListe(Grgrid1.Row) ;
    if RangListeCourant<>-1 then
       DMListeEcriture.SuppressionEcriture(RangListeCourant);
    grgrid1.SupprimeLigne(Grgrid1.Row);
    DMListeEcriture.DispatcherTVA;
    ModifEcriture.changementEtatBoutons(Tecriture(DMListeEcriture.ListeEcriture.Items[RangListeCourant]).Etat);
    CalculSolde;
    InfosLigne(Grgrid1.Row);
  except

  end;//fin except
end;

procedure TModifEcriture.BtnImprimerClick(Sender: TObject);
begin
showmessage('à implémenter !!!');
end;

procedure TModifEcriture.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
If Key = VK_ESCAPE Then
  BtnAnnuler.Click;
end;

procedure TModifEcriture.GrGrid1RowExit(sender: TObject; LastRow: Integer);
begin
GrGrid1ColExit(grgrid1.col,LastRow);
end;

procedure TModifEcriture.Aide1Click(Sender: TObject);
var
CompteTmp:string;
RangListeCourant:integer;
begin
try
RangListeCourant:=DMListeEcriture.CorrespondanceRangListe(Grgrid1.Row) ;
if RangListeCourant<>-1 then
case grgrid1.Col of
    1:begin//col compte
          CompteTmp:=Tecriture(DMListeEcriture.ListeEcriture.items[RangListeCourant]).CompteAffiche;
          Tecriture(DMListeEcriture.ListeEcriture.items[RangListeCourant]).AffichageAideCompte(true,CompteTmp);
          Tecriture(DMListeEcriture.ListeEcriture.items[RangListeCourant]).CompteAffiche:=CompteTmp;
      end;
    2:begin//col Libelle
      end;
    3:begin//col Qt1
      end;
    4:begin//col Qt2
      end;
    5:begin//col Debit
        if not empty(grgrid1.Cells[grgrid1.Col,Grgrid1.Row]) then
          Tecriture(DMListeEcriture.ListeEcriture.items[RangListeCourant]).AffichageAideMontantTVA;
//        //si ok, remplissage de la zone avec valeur de l'objet
//        grgrid1.Cells[grgrid1.Col,Grgrid1.Row]:=currtostr_lgr(Tecriture(DMListeEcriture.ListeEcriture.items[RangListeCourant]).Debit);
      end;
    6:begin//col Credit
        if not empty(grgrid1.Cells[grgrid1.Col,Grgrid1.Row]) then
          Tecriture(DMListeEcriture.ListeEcriture.items[RangListeCourant]).AffichageAideMontantTVA;
//        //si ok, remplissage de la zone avec valeur de l'objet
//        grgrid1.Cells[grgrid1.Col,Grgrid1.Row]:=currtostr_lgr(Tecriture(DMListeEcriture.ListeEcriture.items[RangListeCourant]).Credit);
      end;
  end;//fin du case col
DMListeEcriture.DispatcherTVA;
ModifEcriture.changementEtatBoutons(Tecriture(DMListeEcriture.ListeEcriture.Items[RangListeCourant]).Etat);
CalculSolde;
InfosLigne(Grgrid1.Row);
except
end;
end;

procedure TModifEcriture.Complmentligne1Click(Sender: TObject);
var
valeurRetour:string;
RangListeCourant:integer;
begin
try
RangListeCourant:=DMListeEcriture.CorrespondanceRangListe(Grgrid1.Row) ;
if RangListeCourant<>-1 then
  with Tecriture(DMListeEcriture.ListeEcriture.items[RangListeCourant]) do
    begin
      AffichageDuComplementLigne;
//      DMListeEcriture.DispatcherTVA;
      CalculSolde;
      InfosLigne(grgrid1.Row);
    end;
except
end;
end;

procedure TModifEcriture.MontantRestantClick(Sender: TObject);
var
valeurRetour:string;
RangListeCourant:integer;
begin
try
RangListeCourant:=DMListeEcriture.CorrespondanceRangListe(Grgrid1.Row) ;
if RangListeCourant<>-1 then
case grgrid1.Col of
    1:begin//col compte
      end;
    2:begin//col Libelle
      end;
    3:begin//col Qt1
      end;
    4:begin//col Qt2
      end;
    5:begin//col Debit
        valeurRetour:=currtostr_lgr(Tecriture(DMListeEcriture.ListeEcriture.items[RangListeCourant]).Debit);
        Tecriture(DMListeEcriture.ListeEcriture.items[RangListeCourant]).Debit:=Tecriture(DMListeEcriture.ListeEcriture.items[RangListeCourant]).Debit+Tecriture(DMListeEcriture.ListeEcriture.items[RangListeCourant]).MontantDisponible.Debit;
//        //si ok, remplissage de la zone avec valeur de l'objet
//        grgrid1.Cells[grgrid1.Col,Grgrid1.Row]:=currtostr_lgr(Tecriture(DMListeEcriture.ListeEcriture.items[RangListeCourant]).Debit);
      end;
    6:begin//col Credit
        valeurRetour:=currtostr_lgr(Tecriture(DMListeEcriture.ListeEcriture.items[RangListeCourant]).Credit);
        Tecriture(DMListeEcriture.ListeEcriture.items[RangListeCourant]).Credit:=Tecriture(DMListeEcriture.ListeEcriture.items[RangListeCourant]).Credit+Tecriture(DMListeEcriture.ListeEcriture.items[RangListeCourant]).MontantDisponible.Credit;
//        //si ok, remplissage de la zone avec valeur de l'objet
//        grgrid1.Cells[grgrid1.Col,Grgrid1.Row]:=currtostr_lgr(Tecriture(DMListeEcriture.ListeEcriture.items[RangListeCourant]).Credit);
      end;
  end;//fin du case col
DMListeEcriture.DispatcherTVA;
ModifEcriture.changementEtatBoutons(Tecriture(DMListeEcriture.ListeEcriture.Items[RangListeCourant]).Etat);
CalculSolde;
InfosLigne(Grgrid1.Row);
except
end;
end;

procedure TModifEcriture.GrGrid1Change(Sender: TObject);
var
valeurRetour:string;
RangListeCourant:integer;
begin
try
RangListeCourant:=DMListeEcriture.CorrespondanceRangListe(grgrid1.Row) ;
if RangListeCourant<>-1 then
with Tecriture(DMListeEcriture.ListeEcriture.items[RangListeCourant]) do
  case grgrid1.col of
    1:begin//col compte
        valeurRetour:=CompteAffiche;
        if (MF_Compte in ChampsNotModifiable ) then
          raise ExceptLGR.Create(ChampNonModifiable,0,true,mtError);
      end;
    2:begin//col Libelle
      end;
    3:begin//col Qt1
        valeurRetour:=currtostr_lgr(Qt1);
        if (MF_Qt1 in ChampsNotModifiable ) then
          raise ExceptLGR.Create(ChampNonModifiable,0,true,mtError);
      end;
    4:begin//col Qt2
        valeurRetour:=currtostr_lgr(Qt2);
        if (MF_Qt2 in ChampsNotModifiable ) then
          raise ExceptLGR.Create(ChampNonModifiable,0,true,mtError);
      end;
    5:begin//col Debit
        valeurRetour:=currtostr_lgr(Debit);
        if (MF_Debit in ChampsNotModifiable ) then
          raise ExceptLGR.Create(ChampNonModifiable,0,true,mtError);
      end;
    6:begin//col Credit
        valeurRetour:=currtostr_lgr(Credit);
        if (MF_Credit in ChampsNotModifiable ) then
          raise ExceptLGR.Create(ChampNonModifiable,0,true,mtError);
      end;
  end;//fin du case Acol

except
  grgrid1.Cells[grgrid1.col,grgrid1.Row]:=valeurRetour;
  raise;
end;

end;

procedure TModifEcriture.infoscomplmentaires1Click(Sender: TObject);
var
RangListeCourant:integer;
begin
RangListeCourant:=DMListeEcriture.CorrespondanceRangListe(grgrid1.row) ;
if RangListeCourant<>-1 then

AfficheInfoComposant('Infos complémentaire sur l''écriture',Tecriture(DMListeEcriture.ListeEcriture.items[RangListeCourant]),true);
end;


Procedure TModifEcriture.CalculSolde;
var
Solde:TTotaux;
begin
if Tecriture(DMListeEcriture.ListeEcriture.Items[0]).Debit > 0 then
  GrGrid3.Cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ', abs(currtostr_lgr(Tecriture(DMListeEcriture.ListeEcriture.Items[0]).Debit_Old)))
else
  GrGrid3.Cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ', abs(currtostr_lgr(Tecriture(DMListeEcriture.ListeEcriture.Items[0]).Credit_Old)));
if Tecriture(DMListeEcriture.ListeEcriture.Items[0]).ComplementLigne_Old.MontantTva<>0 then
  GrGrid3.Cells[2,0]:=FormatFloat(E.FormatMonnaie + ';; ', abs(currtostr_lgr(Tecriture(DMListeEcriture.ListeEcriture.Items[0]).ComplementLigne_Old.MontantTva)));

Solde:=DMListeEcriture.TotauxEcriture;

if Solde.Debit > 0 then
  GrGrid2.Cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ', abs(Solde.Debit))
else
  GrGrid2.Cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ', abs(solde.Credit));
if solde.solde<>0 then
  GrGrid2.Cells[2,0]:=FormatFloat(E.FormatMonnaie + ';; ', abs(Solde.solde));
end;


procedure TModifEcriture.GrGrid1RowEnter(sender: TObject; NewRow: Integer);
begin
ModifEcriture.InfosLigne(NewRow);
end;


Procedure TModifEcriture.InfosLigne(Ligne:integer);
var
RangListeCourant:integer;
begin
RangListeCourant:=DMListeEcriture.CorrespondanceRangListe(Ligne) ;
if RangListeCourant<>-1 then
with Tecriture(DMListeEcriture.ListeEcriture.items[RangListeCourant]) do
  begin
    lacode.Caption:=ComplementLigne.CodeTvaCompl;
    LaType.Caption:=ComplementLigne.TvaType;
    LaDateTva.Caption:=ComplementLigne.TvaDate;
    LaTaux.Caption:=e.FormatCurrSansDevise(complementligne.TvaTaux);
    LaDecrite.Caption:=str_bool2str_LGR(Immobilise,'Oui','Non');
    LaPointee.Caption:=str_bool2str_LGR(Pointage.Pointee,'Oui','Non');
    LaDeclaree.Caption:=str_bool2str_LGR(Declaree,'Oui','Non');
    lacomptePlan.Caption:=compteplan;
    latiers.Caption:=tiers;
    grgrid1.Champ_Readonly.bits[3]:=(MF_Qt1 in ChampsNotModifiable);
    grgrid1.Champ_Readonly.bits[4]:=(MF_Qt2 in ChampsNotModifiable);
     //rempli le titre des Quantités
      if empty(Unite1) then
          GrGrid1.cells[3,0]:=''
      else
          GrGrid1.cells[3,0]:=Unite1;
      if empty(Unite2) then
          GrGrid1.cells[4,0]:=''
      else
          GrGrid1.cells[4,0]:=Unite2;
     //fin du remplissage le titre des Quantités
  end;
end;


procedure TModifEcriture.PaGrilleResize(Sender: TObject);
begin
GrGrid1.ColWidths[0]:=10;
GrGrid1.ColWidths[1]:=(GrGrid1.Width) div 6;
GrGrid1.ColWidths[2]:=(GrGrid1.Width) div 3;
GrGrid1.ColWidths[3]:=(GrGrid1.Width) div 21;
GrGrid1.ColWidths[4]:=(GrGrid1.Width) div 21;
GrGrid1.ColWidths[5]:=(GrGrid1.Width) div 8;
GrGrid1.ColWidths[6]:=(GrGrid1.Width) div 8;
GrGrid1.ColWidths[7]:=(GrGrid1.Width) div 8;

Panel7.Width:=GrGrid1.ColWidths[0]+GrGrid1.ColWidths[1]+GrGrid1.ColWidths[2]+GrGrid1.ColWidths[3]+GrGrid1.ColWidths[4]+10;
Panel6.Width:=Panel7.Width;
Gauge1.width:=Panel7.Width-50;

GrGrid2.ColWidths[0]:=GrGrid1.ColWidths[5];
GrGrid2.ColWidths[1]:=GrGrid1.ColWidths[6];
GrGrid2.ColWidths[2]:=GrGrid1.ColWidths[7];

GrGrid3.ColWidths[0]:=GrGrid1.ColWidths[5];
GrGrid3.ColWidths[1]:=GrGrid1.ColWidths[6];
GrGrid3.ColWidths[2]:=GrGrid1.ColWidths[7];
end;

Procedure TModifEcriture.ReactualiserInterface(rowgrille:integer);
var
RangListeCourant:integer;
begin
RangListeCourant:=DMListeEcriture.CorrespondanceRangListe(rowgrille) ;
if RangListeCourant<>-1 then
with Tecriture(DMListeEcriture.ListeEcriture.items[RangListeCourant]) do
  begin
      Grgrid1.cells[1,rowgrille]:=Tecriture(DMListeEcriture.ListeEcriture.Items[RangListeCourant]).CompteAffiche;
      Grgrid1.cells[2,rowgrille]:=Tecriture(DMListeEcriture.ListeEcriture.Items[RangListeCourant]).Libelle;
      Grgrid1.cells[3,rowgrille]:=currtostr_lgr(Tecriture(DMListeEcriture.ListeEcriture.Items[RangListeCourant]).Qt1);
      Grgrid1.cells[4,rowgrille]:=currtostr_lgr(Tecriture(DMListeEcriture.ListeEcriture.Items[RangListeCourant]).Qt2);
      Grgrid1.cells[5,rowgrille]:=currtostr_lgr(Tecriture(DMListeEcriture.ListeEcriture.Items[RangListeCourant]).Debit);
      Grgrid1.cells[6,rowgrille]:=currtostr_lgr(Tecriture(DMListeEcriture.ListeEcriture.Items[RangListeCourant]).Credit);
      Grgrid1.cells[7,rowgrille]:=currtostr_lgr(Tecriture(DMListeEcriture.ListeEcriture.Items[RangListeCourant]).ComplementLigne.MontantTva);
      Tecriture(DMListeEcriture.ListeEcriture.Items[RangListeCourant]).RowGrille:=rowgrille;

     //rendre les champs readonly
     grgrid1.Champ_Readonly.bits[1]:=(MF_compte in ChampsNotModifiable);
//     grgrid1.Champ_Readonly.bits[2]:=false;
     grgrid1.Champ_Readonly.bits[3]:=(MF_Qt1 in ChampsNotModifiable);
     grgrid1.Champ_Readonly.bits[4]:=(MF_Qt2 in ChampsNotModifiable);
     grgrid1.Champ_Readonly.bits[5]:=((MF_Debit in ChampsNotModifiable)or(Tecriture(DMListeEcriture.ListeEcriture.Items[RangListeCourant]).Credit>0));
     grgrid1.Champ_Readonly.bits[6]:=((MF_Credit in ChampsNotModifiable)or(Tecriture(DMListeEcriture.ListeEcriture.Items[RangListeCourant]).Debit>0));
     grgrid1.Champ_Readonly.bits[7]:=true;
     //rempli le titre des Quantités
      if empty(Tecriture(DMListeEcriture.ListeEcriture.Items[RangListeCourant]).Unite1) then
          GrGrid1.cells[3,0]:=''
      else
          GrGrid1.cells[3,0]:=Tecriture(DMListeEcriture.ListeEcriture.Items[RangListeCourant]).Unite1;
      if empty(Tecriture(DMListeEcriture.ListeEcriture.Items[RangListeCourant]).Unite2) then
          GrGrid1.cells[4,0]:=''
      else
          GrGrid1.cells[4,0]:=Tecriture(DMListeEcriture.ListeEcriture.Items[RangListeCourant]).Unite2;
     //fin du remplissage du titre des Quantités
     
     while ((grgrid1.Champ_Readonly.bits[grgrid1.col])and(grgrid1.col<grgrid1.colcount-1))do
       grgrid1.col:=grgrid1.col+1;
    if rowgrille=grgrid1.row then
        begin
          ModifEcriture.InfosLigne(grgrid1.row);
          ModifEcriture.CalculSolde;
        end;
  end;

end;
Procedure TModifEcriture.changementEtatBoutons(Etat : TDataSetState);
begin
case Etat of
   dsBrowse: begin
               if DMListeEcriture.ListeEcriture.count>0 then
                 BtnInserer.Enabled := Tecriture(DMListeEcriture.ListeEcriture.items[0]).MontantDisponible.solde<>0
               else
                 BtnInserer.Enabled :=false;
               BtnEnregistrer.Enabled := False;
               BtnSupprimer.Enabled := DMListeEcriture.ListeEcriture.Count>1;
               BtnImprimer.Enabled:=false;
             end;

   dsEdit,
   dsinsert:   begin
               if DMListeEcriture.ListeEcriture.count>0 then
                 BtnInserer.Enabled := Tecriture(DMListeEcriture.ListeEcriture.items[0]).MontantDisponible.solde<>0
               else
                 BtnInserer.Enabled :=false;
               BtnSupprimer.Enabled := DMListeEcriture.ListeEcriture.Count>1;
               EnableWinControl([BtnAnnuler,BtnEnregistrer,BtnFermer],True);
               //EnableWinControl([BtnInserer,BtnSupprimer,BtnImprimer],False);
             end;
end;//fin du case Etat
   //Pop-up Menu
   Fermer1.Enabled:=BtnFermer.Enabled;
   Insrer1.Enabled:=BtnInserer.Enabled;
   Enregister1.Enabled:=BtnEnregistrer.Enabled;
   Supprimer1.Enabled:=BtnSupprimer.Enabled;
   Imprimer1.Enabled:=BtnImprimer.Enabled;
end;
procedure TModifEcriture.GrGrid2DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
if Acol=0 then
  if Tecriture(DMListeEcriture.ListeEcriture.Items[0]).Debit_Old<>strtocurr_lgr(QueDesChiffres(grgrid2.Cells[Acol,Arow])) then
    begin
      grgrid2.Canvas.Font.Color:=clred;
    end
  else
    begin
      grgrid2.Canvas.Font.Color:=clblack;
    end;

if Acol=1 then
  if Tecriture(DMListeEcriture.ListeEcriture.Items[0]).Credit_Old<>strtocurr_lgr(QueDesChiffres(grgrid2.Cells[Acol,Arow])) then
    begin
      grgrid2.Canvas.Font.Color:=clred;
    end
  else
    begin
      grgrid2.Canvas.Font.Color:=clblack;
    end;

if Acol=2 then
  if Tecriture(DMListeEcriture.ListeEcriture.Items[0]).ComplementLigne_Old.MontantTva<>strtocurr_lgr(QueDesChiffres(grgrid2.Cells[Acol,Arow])) then
    begin
      grgrid2.Canvas.Font.Color:=clred;
    end
  else
    begin
      grgrid2.Canvas.Font.Color:=clblack;
    end;
end;

procedure TModifEcriture.GrGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
HoldColor:TColor;
begin
try
if ((Arow=0)and(Acol<>0)) then
  Begin
    if grgrid1.Cells[Acol,Arow]='ND'then
        Begin
            HoldColor:=grgrid1.Font.Color;
            grgrid1.Canvas.Font.Color :=clRed;
            grgrid1.Canvas.FillRect(Rect);
            grgrid1.Canvas.TextRect(Rect,Rect.TopLeft.x,Rect.TopLeft.y+3,grgrid1.Cells[Acol,Arow]);
            grgrid1.Canvas.Font.Color:=HoldColor;
        end;
  end;
if ((Arow<>0)and(Acol<>0)) then
  if grgrid1.Champ_Readonly.bits[Acol]=true then
    Begin
        HoldColor:=grgrid1.Brush.Color;
        grgrid1.Canvas.Brush.Color :=clWhite;
        grgrid1.Canvas.FillRect(Rect);
        if Acol in [1,2]then
          grgrid1.Canvas.TextRect(Rect,Rect.TopLeft.X+2,Rect.TopLeft.y+3,grgrid1.Cells[Acol,Arow])
        else
          grgrid1.Canvas.TextRect(Rect,Rect.BottomRight.x-4-grgrid1.Canvas.TextWidth(grgrid1.Cells[Acol,Arow]),Rect.TopLeft.y+3,grgrid1.Cells[Acol,Arow]);
        grgrid1.Brush.Color:=HoldColor;
    end;
finally
end;
end;

procedure TModifEcriture.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(GrGrid1);
end;

end.
