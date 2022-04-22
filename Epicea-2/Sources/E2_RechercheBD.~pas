unit E2_RechercheBD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, RXCtrls, ExtCtrls, Mask, ToolEdit, CurrEdit, checklst,DMRecherche,
  LibSQL,LibZoneSaisie,Gr_Librairie_Obj,E2_Librairie_Obj,E2_LibInfosTable,E2_Patientez,
  DBTables,
  ObjetEdition,
  Lib_Chaine,
  LibDates,
  Printers,
  E2_SaisieP_3,
  E2_decl_records,
  E2_AideCompte,
  Menus,DMConstantes, jpeg,LibressourceString,LibGestionParamXML, E2_Immo_Ouverture,
  DB, Grids, DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid, GrGrid;

const

 PasDeResultat = 'Aucune information ne réponds à votre demande !';
type

TParamRechercheBD = record
 Recherche : Boolean;
 Ouverture:Boolean;
 Ecriture:Boolean;
 CompteDep:String;
 CompteFin:String;
 end;

  TRechercheBD = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    PaTables: TPanel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnChercher: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    PaResult: TPanel;
    LVResult: TListView;
    PaTable: TPanel;
    Label1: TLabel;
    ChLBTableRech: TCheckListBox;
    PaCriteres: TPanel;
    PopupMenu1: TPopupMenu;
    Chercher1: TMenuItem;
    Modifier1: TMenuItem;
    Imprimer1: TMenuItem;
    Query1: TQuery;
    PaGauche: TPanel;
    Pa1: TPanel;
    Label3: TLabel;
    EdCptDeb: TEdit;
    EdCptFin: TEdit;
    Label4: TLabel;
    Pa2: TPanel;
    EdDateFin: TEdit;
    EdDateDeb: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Pa3: TPanel;
    EdRefDeb: TEdit;
    EdRefFin: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Pa4: TPanel;
    CuMontantDeb: TCurrencyEdit;
    CuMontantFin: TCurrencyEdit;
    Label9: TLabel;
    Label10: TLabel;
    Pa5: TPanel;
    EdLibelle: TEdit;
    Label12: TLabel;
    N1: TMenuItem;
    Critres1: TMenuItem;
    Compte1: TMenuItem;
    Date1: TMenuItem;
    Rfrences1: TMenuItem;
    Montant1: TMenuItem;
    Libell1: TMenuItem;
    N2: TMenuItem;
    ParDfaut1: TMenuItem;
    PaDroit: TPanel;
    LVRecherche: TListView;
    Aide1: TMenuItem;
    N3: TMenuItem;
    Visualisation1: TMenuItem;
    Modifierpice1: TMenuItem;
    PaCumul: TPanel;
    Panel1: TPanel;
    GrGrid1: TGrGrid;
    Rinitialiser1: TMenuItem;
    Label11: TLabel;
    Label2: TLabel;
    Dtailspointages1: TMenuItem;
    Pointage1: TMenuItem;
    Panel2: TPanel;
    Panel3: TPanel;
    GrGrid2: TGrGrid;
    Calculatrice1: TMenuItem;
    Imprimerlaslection1: TMenuItem;
    procedure LVResultColumnClick(Sender: TObject; Column: TListColumn);
    procedure BtnInsererClick(Sender: TObject);
    procedure LVResultCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure FormCreate(Sender: TObject);
    procedure BtnChercherClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure LVResultDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdCptDebKeyPress(Sender: TObject; var Key: Char);
    procedure PaBtnResize(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure EdCptDebExit(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure BtnImprimerSelectionClick(Sender: TObject);    
    Procedure QuRechercheStocksOuv(Query:TQuery);
    Procedure QuRechercheImmosOuv(Query:TQuery);
    Procedure QuRechercheEmpruntsOuv(Query:TQuery);
    Procedure QuRechercheChargeARepartirOuv(Query:TQuery);
    Procedure QuRecherchePCADebitOuv(Query:TQuery);
    Procedure QuRecherchePCACreditOuv(Query:TQuery);
    Procedure QuRechercheChargesAPayerDebitOuv(Query:TQuery);
    Procedure QuRechercheChargesAPayerCreditOuv(Query:TQuery);
    Procedure QuRechercheProvisionsOuv(Query:TQuery);
    Procedure QuRechercheEcrituresOuverture(Query:TQuery);
    Procedure QuRechercheEcritures(Query:TQuery);
    Procedure QuRechercheBalanceOuv(Query:TQuery);
//    Procedure QuRechercheEcriturePeriode(Query:TQuery);
    procedure EdDateDebExit(Sender: TObject);
    procedure EdDateDebKeyPress(Sender: TObject; var Key: Char);
    procedure EdDateFinExit(Sender: TObject);
    procedure EdDateFinKeyPress(Sender: TObject; var Key: Char);
    procedure PaGaucheDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure PaGaucheDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Panel1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Compte1Click(Sender: TObject);
    procedure Date1Click(Sender: TObject);
    procedure Rfrences1Click(Sender: TObject);
    procedure Montant1Click(Sender: TObject);
    procedure Libell1Click(Sender: TObject);
    Procedure EnvoiNextControlKeyDownForm(Form:TForm);
    procedure ParDfaut1Click(Sender: TObject);
    procedure Critres1Click(Sender: TObject);
    Procedure SauveRechCouranteDsViewList;
    Procedure InitZoneRechAvecTVRecherche;
    procedure LVRechercheDblClick(Sender: TObject);
    procedure LVRechercheKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Aide1Click(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure Modifierpice1Click(Sender: TObject);
    procedure GestionCaptionBtnChercher(chercher:boolean=true);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure LVResultResize(Sender: TObject);
    procedure InitSousTotaux(Debit,Credit:currency;Libelle:string);
    procedure FormShow(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure Pointage1Click(Sender: TObject);
    procedure Dtailspointages1Click(Sender: TObject);
    procedure GestionDernierSelectionne(Repositionnement:boolean=false);
    procedure EdCptDebChange(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
    procedure Imprimerlaslection1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    TabStr,TabCurr,TabDate : set of Byte;
  end;

  Function RechercheBDAffiche(ParamRechercheBD:TParamRechercheBD):Boolean;
var
  RechercheBD: TRechercheBD;
  OrdreTri:integer;
  Dernier:integer;
implementation

uses E2_Main, E2_DetailEcr, DMEcriture, DMPlanCpt,DMPointages2,
  DMCorrection;

{$R *.DFM}
function CustomSortDateProcAsc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
result := 0;
if StrToDate(TListItem(Item1).SubItems.Strings[ParamSort]) < StrToDate(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=-1;
if StrToDate(TListItem(Item1).SubItems.Strings[ParamSort]) > StrToDate(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=1;
end;

function CustomSortDateProcDesc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
result := 0;
if StrToDate(TListItem(Item1).SubItems.Strings[ParamSort]) < StrToDate(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=-1;
if StrToDate(TListItem(Item1).SubItems.Strings[ParamSort]) > StrToDate(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=1;
result:=-result;
end;


function CustomSortCurrProcAsc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
result := 0;
if StrToCurr_Lgr(TListItem(Item1).SubItems.Strings[ParamSort]) < StrToCurr_Lgr(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=-1;
if StrToCurr_Lgr(TListItem(Item1).SubItems.Strings[ParamSort]) > StrToCurr_Lgr(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=1;
end;

function CustomSortCurrProcDesc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
result := 0;
if StrToCurr_Lgr(TListItem(Item1).SubItems.Strings[ParamSort]) < StrToCurr_Lgr(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=-1;
if StrToCurr_Lgr(TListItem(Item1).SubItems.Strings[ParamSort]) > StrToCurr_Lgr(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=1;
result:=-result;
end;
// Aconserver pour exemple
// Appel : LVResult.CustomSort(@CustomSortProc,Column.Index-1)
function CustomSortProc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
  Result := -lstrcmp(PChar(TListItem(Item1).Caption),
                     PChar(TListItem(Item2).Caption));
end;


Function RechercheBDAffiche(ParamRechercheBD:TParamRechercheBD):Boolean;
Begin
 if RechercheBD = nil then RechercheBD:=TRechercheBD.create(Application.MainForm);
 RechercheBD.EdCptDeb.Text := ParamRechercheBD.CompteDep;
// RechercheBD.ChLBTableRech.Checked[0] := ParamRechercheBD.Ouverture = true;
 RechercheBD.ChLBTableRech.Checked[1] := ParamRechercheBD.Ouverture = true;
 if not empty(ParamRechercheBD.CompteDep)then
   RechercheBD.BtnChercherClick(nil);
 RechercheBD.EdCptDeb.Text := ParamRechercheBD.CompteDep;
 RechercheBD.LVResult.Column[0].Width := 0; // A enlever sitot que les intitullé seront bon !!! // PB le 17/06/04
RechercheBD.TabStr:=[0,1,2,3,4,8];
RechercheBD.TabCurr:=[6,7];
RechercheBD.TabDate:=[5];

  RechercheBD.GrGrid1.ParamColor:=true;
  RechercheBD.GrGrid1.Param:=ParamUtil.CouleurDBGrid;
  RechercheBD.GrGrid1.DessineContourLigne:=false;
  RechercheBD.GrGrid1.UpDateColor;

  RechercheBD.GrGrid2.ParamColor:=true;
  RechercheBD.GrGrid2.Param:=ParamUtil.CouleurDBGrid;
  RechercheBD.GrGrid2.DessineContourLigne:=false;
  RechercheBD.GrGrid2.UpDateColor;

 RechercheBD.ShowModal;
End;


procedure TRechercheBD.LVResultColumnClick(Sender: TObject;
  Column: TListColumn);
begin
OrdreTri:=-OrdreTri;
  if Column.Index in TabStr  then
   begin
     if Column.Index > 0 then
        (sender as TListView).CustomSort(nil, Column.Index-1)
        else
        (sender as TListView).CustomSort(nil, -1)
  end;

  if OrdreTri > 0 then
  if Column.Index in TabCurr  then
   begin
     if Column.Index > 0 then
        (sender as TListView).CustomSort(@CustomSortCurrProcAsc, Column.Index-1)
        else
        (sender as TListView).CustomSort(@CustomSortCurrProcAsc, -1)
  end;

  if OrdreTri < 0 then
  if Column.Index in TabCurr  then
   begin
     if Column.Index > 0 then
        (sender as TListView).CustomSort(@CustomSortCurrProcDesc, Column.Index-1)
        else
        (sender as TListView).CustomSort(@CustomSortCurrProcDesc, -1)
  end;


  if OrdreTri > 0 then
  if Column.Index in TabDate  then
   begin
     if Column.Index > 0 then
        (sender as TListView).CustomSort(@CustomSortDateProcAsc, Column.Index-1)
        else
        (sender as TListView).CustomSort(@CustomSortDateProcAsc, -1)
  end;

  if OrdreTri < 0 then
  if Column.Index in TabDate  then
   begin
     if Column.Index > 0 then
        (sender as TListView).CustomSort(@CustomSortDateProcDesc, Column.Index-1)
        else
        (sender as TListView).CustomSort(@CustomSortDateProcDesc, -1)
  end;end;


procedure TRechercheBD.BtnInsererClick(Sender: TObject);
begin
//LVResult.AllocBy
end;

procedure TRechercheBD.LVResultCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
if DAta >= 0 then
compare:=OrdreTri*StrComp(PChar(Item1.SubItems.Strings[Data]),PChar(Item2.SubItems.Strings[Data]))
else
compare:=OrdreTri*StrComp(PChar(TListItem(Item1).Caption),PChar(TListItem(Item2).Caption));

end;

procedure TRechercheBD.FormCreate(Sender: TObject);
begin
OrdreTri:=1;
EdCptDeb.Text:=C_StrVide;
EdCptFin.Text:=C_StrVide;
EdRefDeb.Text:=C_StrVide;
EdRefFin.Text:=C_StrVide;
EdLibelle.Text:=C_StrVide;
EdDateDeb.Text := C_StrVide;
EdDateFin.Text := C_StrVide;

GestionCaptionBtnChercher;
FormateMonnaie([CuMontantDeb,CuMontantFin],E.FormatMonnaie);
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
ChLBTableRech.Items.Add('L'' ouverture');
//ChLBTableRech.Items.Add('Les pièces');
ChLBTableRech.Items.Add('Les écritures');
//ChLBTableRech.Items.Add('Les pointages');
//ChLBTableRech.Items.Add('La balance');
//ChLBTableRech.Items.Add('La clôture');

end;

procedure TRechercheBD.BtnChercherClick(Sender: TObject);
const
Tirets ='--------------';
FlecheG=' <-- ';
var
i:integer;
Sens:String;
MontantDebit,MontantCredit,Debit,Credit:Currency;
Libelle:string;
begin
//Patientez.show;
try
MontantDebit:=0;
MontantCredit:=0;
Screen.Cursor := crSQLWait;
LVResult.Hide;
LVResult.Items.Clear;
GestionCaptionBtnChercher;
for i:=0 to ChLBTableRech.Items.Count - 1 do
 begin
  if ChLBTableRech.Checked[i] then
   begin
   case i of
       // TAbles de l'ouverture
      0:Begin
          // Table Immos
          QuRechercheImmosOuv(Query1);
          Query1.First;
          debit:=0;
          credit:=0;
          Libelle:='';
          while not Query1.EOF do
           Begin
             Libelle:=DM_C_ListeFenetre.Strings[0];
             LVResult.Items.Add.Caption:=libelle;
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Compte').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Code').AsString+
                                                                 '  '+
                                                                 Query1.FindField('Sous_Code').AsString+
                                                                 '  '+
                                                                 Query1.FindField('Libelle').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Date_Achat').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(Query1.FindField('Valeur_a_amortir').AsCurrency-Query1.FindField('Amort_Eco').AsCurrency-Query1.FindField('Amort_Derog').AsCurrency));
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(0));
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FlecheG+'Valeur Nette');
             MontantDebit:=MontantDebit+ Query1.FindField('Valeur_a_amortir').AsCurrency-Query1.FindField('Amort_Eco').AsCurrency-Query1.FindField('Amort_Derog').AsCurrency;
             debit:=debit+Query1.FindField('Valeur_a_amortir').AsCurrency-Query1.FindField('Amort_Eco').AsCurrency-Query1.FindField('Amort_Derog').AsCurrency;
             Query1.Next;
           End;
           if libelle<>'' then InitSousTotaux(Debit,Credit,libelle);

//          // Table Immos
//          if Empty(EdCptDeb.Text) then
//            FiltrageDataSet(DMRech.TaImmosRech,CreeFiltreET(['Achat_dans_Annee'],['False']))
//          else
//            FiltrageDataSet(DMRech.TaImmosRech,CreeFiltreET(['Compte','Achat_dans_Annee'],[EdCptDeb.Text,'False']));
//          DMRech.TaImmosRech.First;
//          while not DMRech.TaImmosRech.EOF do
//           Begin
//             LVResult.Items.Add.Caption:=DM_C_ListeFenetre.Strings[0];
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaImmosRech.FindField('Compte').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaImmosRech.FindField('Compte').AsString+
//                                                                 '  '+
//                                                                 DMRech.TaImmosRech.FindField('Code').AsString+
//                                                                 '  '+
//                                                                 DMRech.TaImmosRech.FindField('Sous_Code').AsString+
//                                                                 '  '+
//                                                                 DMRech.TaImmosRech.FindField('Libelle').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaImmosRech.FindField('Date_Achat').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FormatFloat(E.FormatMonnaie + ';; ',DMRech.TaImmosRech.FindField('Valeur_a_amortir').AsCurrency-DMRech.TaImmosRech.FindField('Amort_Eco').AsCurrency-DMRech.TaImmosRech.FindField('Amort_Derog').AsCurrency));
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FlecheG+'Valeur Nette');
//             DMRech.TaImmosRech.Next;
//           End;
//           DeFiltrageDataSet(DMRech.TaImmosRech);
//

          // Table Emprunts
          QuRechercheEmpruntsOuv(Query1);
          Query1.First;
          debit:=0;
          credit:=0;
          Libelle:='';
          while not Query1.EOF do
           Begin
             Libelle:=DM_C_ListeFenetre.Strings[1];
             LVResult.Items.Add.Caption:=libelle;
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Compte_Emp').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Designation_Emp').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('DateRealisation').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(Query1.FindField('CapiTotal_Emp').AsCurrency));
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(0));
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FlecheG+'Capital Total');
             MontantDebit:=MontantDebit+Query1.FindField('CapiTotal_Emp').AsCurrency;
             debit:=debit+Query1.FindField('CapiTotal_Emp').AsCurrency;
             Query1.Next;
           End;
           if libelle<>'' then InitSousTotaux(Debit,Credit,libelle);

//          // Table Emprunts
//          if Empty(EdCptDeb.Text) then
//            DeFiltrageDataSet(DMRech.TaEmpruntsRech)
//          else
//            FiltrageDataSet(DMRech.TaEmpruntsRech,CreeFiltreET(['Compte_emp'],[EdCptDeb.Text]));
//          DMRech.TaEmpruntsRech.First;
//          while not DMRech.TaEmpruntsRech.EOF do
//           Begin
//             LVResult.Items.Add.Caption:=DM_C_ListeFenetre.Strings[1];
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaEmpruntsRech.FindField('Compte_Emp').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaEmpruntsRech.FindField('Designation_Emp').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaEmpruntsRech.FindField('DateRealisation').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FormatFloat(E.FormatMonnaie + ';; ',DMRech.TaEmpruntsRech.FindField('CapiTotal_Emp').AsCurrency));
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FlecheG+'Capital Total');
//             DMRech.TaEmpruntsRech.Next;
//           End;
//           DeFiltrageDataSet(DMRech.TaEmpruntsRech);

          // Table Stocks
          QuRechercheStocksOuv(Query1);
          Query1.First;
          debit:=0;
          credit:=0;
          Libelle:='';
          while not Query1.EOF do
           Begin
             Libelle:=DM_C_ListeFenetre.Strings[2];
             LVResult.Items.Add.Caption:=libelle;
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Compte').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Reference').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Designation').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Date_Saisie').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(Query1.FindField('MontantTotalHT').AsCurrency));
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(0));
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FlecheG+'Montant Total HT');
             MontantDebit:=MontantDebit+Query1.FindField('MontantTotalHT').AsCurrency;
             debit:=debit+Query1.FindField('MontantTotalHT').AsCurrency;
             Query1.Next;
           End;
           if libelle<>'' then InitSousTotaux(Debit,Credit,libelle);

//          if Empty(EdCptDeb.Text) then
//            FiltrageDataSet(DMRech.TaStockRech,CreeFiltreET(['Actif','Date_Saisie'],['true',datetostr(E.DatExoDebut-1)]))
//           else
//            FiltrageDataSet(DMRech.TaStockRech,CreeFiltreET(['Actif','Date_Saisie','Compte'],['true',datetostr(E.DatExoDebut-1),EdCptDeb.Text]));
//          DMRech.TaStockRech.First;
//          while not DMRech.TaStockRech.EOF do
//           Begin
//             LVResult.Items.Add.Caption:=DM_C_ListeFenetre.Strings[2];
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaStockRech.FindField('Compte').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaStockRech.FindField('Reference').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaStockRech.FindField('Designation').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaStockRech.FindField('Date_Saisie').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FormatFloat(E.FormatMonnaie + ';; ',DMRech.TaStockRech.FindField('MontantTotalHT').AsCurrency));
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FlecheG+'Montant Total HT');
//             DMRech.TaStockRech.Next;
//           End;
//           DeFiltrageDataSet(DMRech.TaStockRech);
//

          // Table ChargeARepartir
          QuRechercheChargeARepartirOuv(Query1);
          Query1.First;
          Libelle:='';
          debit:=0;
          credit:=0;
          while not Query1.EOF do
           Begin
             Libelle:=DM_C_ListeFenetre.Strings[3];
             LVResult.Items.Add.Caption:=libelle;
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Compte').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Reference').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Designation').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('DateSaisie').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(Query1.FindField('MtBilanOuverture').AsCurrency));
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(0));
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FlecheG+'Mt Bilan Ouverture');
             MontantDebit:=MontantDebit+Query1.FindField('MtBilanOuverture').AsCurrency;
             debit:=debit+Query1.FindField('MtBilanOuverture').AsCurrency;
             Query1.Next;
           End;
           if libelle<>'' then InitSousTotaux(Debit,Credit,libelle);

//          // Table ChargeARepartir
//          if Empty(EdCptDeb.Text) then
//            FiltrageDataSet(DMRech.TaChargesRepartirRech,CreeFiltreET(['Compte','DateSaisie'],[EdCptDeb.Text,datetostr(E.DatExoDebut-1)]))
//           else
//            FiltrageDataSet(DMRech.TaChargesRepartirRech,CreeFiltreET(['DateSaisie'],[datetostr(E.DatExoDebut-1)]));
//
//          DMRech.TaChargesRepartirRech.First;
//          while not DMRech.TaChargesRepartirRech.EOF do
//           Begin
//             LVResult.Items.Add.Caption:=DM_C_ListeFenetre.Strings[3];
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaChargesRepartirRech.FindField('Compte').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaChargesRepartirRech.FindField('Reference').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaChargesRepartirRech.FindField('Designation').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaChargesRepartirRech.FindField('DateSaisie').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FormatFloat(E.FormatMonnaie + ';; ',DMRech.TaChargesRepartirRech.FindField('MtBilanOuverture').AsCurrency));
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FlecheG+'Mt Bilan Ouverture');
//             DMRech.TaChargesRepartirRech.Next;
//           End;
//           DeFiltrageDataSet(DMRech.TaChargesRepartirRech);

          // Table PCA
          QuRecherchePCADebitOuv(Query1);
          Libelle:='';
          Query1.First;
          debit:=0;
          credit:=0;
          while not Query1.EOF do
           Begin
             Libelle:=DM_C_ListeFenetre.Strings[4];
             LVResult.Items.Add.Caption:=libelle;
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Compte').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Reference').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Libelle').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('DateSaisie').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(Query1.FindField('MontantHT').AsCurrency));
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(0));
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FlecheG+'MontantHT');
             MontantDebit:=MontantDebit+Query1.FindField('MontantHT').AsCurrency;
             debit:=debit+Query1.FindField('MontantHT').AsCurrency;
             Query1.Next;
           End;
           if libelle<>'' then InitSousTotaux(Debit,Credit,libelle);

//          // Table PCA
//          Sens:='D';
//          if Empty(EdCptDeb.Text) then
//            FiltrageDataSet(DMRech.TaPCARech,CreeFiltreET(['DateSaisie','Sens'],[datetostr(E.DatExoDebut-1),Sens]))
//           else
//            FiltrageDataSet(DMRech.TaPCARech,CreeFiltreET(['Compte','DateSaisie','Sens'],[EdCptDeb.Text,datetostr(E.DatExoDebut-1),Sens]));
//
//          DMRech.TaPCARech.First;
//          while not DMRech.TaPCARech.EOF do
//           Begin
//             LVResult.Items.Add.Caption:=DM_C_ListeFenetre.Strings[4];
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaPCARech.FindField('Compte').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaPCARech.FindField('Reference').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaPCARech.FindField('Libelle').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaPCARech.FindField('DateSaisie').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FormatFloat(E.FormatMonnaie + ';; ',DMRech.TaPCARech.FindField('MontantHT').AsCurrency));
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FlecheG+'MontantHT');
//             DMRech.TaPCARech.Next;
//           End;
//           DeFiltrageDataSet(DMRech.TaPCARech);

          // Table PCA
          QuRecherchePCACreditOuv(Query1);
          Libelle:='';
          Query1.First;
          debit:=0;
          credit:=0;
          while not Query1.EOF do
           Begin
             libelle:=DM_C_ListeFenetre.Strings[5];
             LVResult.Items.Add.Caption:=libelle;
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Compte').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Reference').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Libelle').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('DateSaisie').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(0));
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(Query1.FindField('MontantHT').AsCurrency));
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FlecheG+'MontantHT');
             MontantCredit:=MontantCredit+ Query1.FindField('MontantHT').AsCurrency;
             credit:=credit+Query1.FindField('MontantHT').AsCurrency;
             Query1.Next;
           End;
           if libelle<>'' then InitSousTotaux(Debit,Credit,libelle);

//          // Table PCA
//          Sens:='C';
//          if Empty(EdCptDeb.Text) then
//            FiltrageDataSet(DMRech.TaPCARech,CreeFiltreET(['DateSaisie','Sens'],[datetostr(E.DatExoDebut-1),Sens]))
//           else
//            FiltrageDataSet(DMRech.TaPCARech,CreeFiltreET(['Compte','DateSaisie','Sens'],[EdCptDeb.Text,datetostr(E.DatExoDebut-1),Sens]));
//          DMRech.TaPCARech.First;
//          while not DMRech.TaPCARech.EOF do
//           Begin
//             LVResult.Items.Add.Caption:=DM_C_ListeFenetre.Strings[5];
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaPCARech.FindField('Compte').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaPCARech.FindField('Reference').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaPCARech.FindField('Libelle').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaPCARech.FindField('DateSaisie').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FormatFloat(E.FormatMonnaie + ';; ',DMRech.TaPCARech.FindField('MontantHT').AsCurrency));
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FlecheG+'MontantHT');
//             DMRech.TaPCARech.Next;
//           End;
//           DeFiltrageDataSet(DMRech.TaPCARech);
          // Table Produits A Recevoir
          QuRechercheChargesAPayerDebitOuv(Query1);
          Query1.First;
          Libelle:='';
          debit:=0;
          credit:=0;
          while not Query1.EOF do
           Begin
             libelle:=DM_C_ListeFenetre.Strings[7];
             LVResult.Items.Add.Caption:=libelle;
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Compte').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Reference').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Libelle').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('DateSaisie').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(Query1.FindField('MontantHT').AsCurrency));
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(0));
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FlecheG+'MontantHT');
             MontantDebit:=MontantDebit+Query1.FindField('MontantHT').AsCurrency;
             debit:=debit+Query1.FindField('MontantHT').AsCurrency;
             Query1.Next;
           End;
           if libelle<>'' then InitSousTotaux(Debit,Credit,libelle);

//          // Table Produits A Recevoir
//          Sens:='D';
//          if Empty(EdCptDeb.Text) then
//             FiltrageDataSet(DMRech.TaChargeAPayerRech,CreeFiltreET(['DateSaisie','Sens'],[datetostr(E.DatExoDebut-1),Sens]))
//           else
//            FiltrageDataSet(DMRech.TaChargeAPayerRech,CreeFiltreET(['Compte','DateSaisie','Sens'],[EdCptDeb.Text,datetostr(E.DatExoDebut-1),Sens]));
//          DMRech.TaChargeAPayerRech.First;
//          while not DMRech.TaChargeAPayerRech.EOF do
//           Begin
//             LVResult.Items.Add.Caption:=DM_C_ListeFenetre.Strings[7];
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaChargeAPayerRech.FindField('Compte').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaChargeAPayerRech.FindField('Reference').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaChargeAPayerRech.FindField('Libelle').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaChargeAPayerRech.FindField('DateSaisie').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FormatFloat(E.FormatMonnaie + ';; ',DMRech.TaChargeAPayerRech.FindField('MontantHT').AsCurrency));
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FlecheG+'MontantHT');
//             DMRech.TaChargeAPayerRech.Next;
//           End;
//           DeFiltrageDataSet(DMRech.TaChargeAPayerRech);
//

          // Table ChargeAPayer
          QuRechercheChargesAPayerCreditOuv(Query1);
          Query1.First;
          Libelle:='';
          debit:=0;
          credit:=0;
          while not Query1.EOF do
           Begin
            libelle:=DM_C_ListeFenetre.Strings[6];
             LVResult.Items.Add.Caption:=libelle;
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Compte').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Reference').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Libelle').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('DateSaisie').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(0));
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(Query1.FindField('MontantHT').AsCurrency));
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FlecheG+'MontantHT');
             MontantCredit:=MontantCredit+Query1.FindField('MontantHT').AsCurrency;
             credit:=credit+Query1.FindField('MontantHT').AsCurrency;
             Query1.Next;
           End;
           if libelle<>'' then InitSousTotaux(Debit,Credit,libelle);

//          // Table ChargeAPayer
//          Sens:='C';
//          if Empty(EdCptDeb.Text) then
//            FiltrageDataSet(DMRech.TaChargeAPayerRech,CreeFiltreET(['DateSaisie','Sens'],[datetostr(E.DatExoDebut-1),Sens]))
//           else
//            FiltrageDataSet(DMRech.TaChargeAPayerRech,CreeFiltreET(['Compte','DateSaisie','Sens'],[EdCptDeb.Text,datetostr(E.DatExoDebut-1),Sens]));
//          DMRech.TaChargeAPayerRech.First;
//          while not DMRech.TaChargeAPayerRech.EOF do
//           Begin
//             LVResult.Items.Add.Caption:=DM_C_ListeFenetre.Strings[6];
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaChargeAPayerRech.FindField('Compte').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaChargeAPayerRech.FindField('Reference').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaChargeAPayerRech.FindField('Libelle').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaChargeAPayerRech.FindField('DateSaisie').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FormatFloat(E.FormatMonnaie + ';; ',DMRech.TaChargeAPayerRech.FindField('MontantHT').AsCurrency));
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FlecheG+'MontantHT');
//             DMRech.TaChargeAPayerRech.Next;
//           End;
//           DeFiltrageDataSet(DMRech.TaChargeAPayerRech);

          // Table Provisions
          QuRechercheProvisionsOuv(Query1);
          Query1.First;
          Libelle:='';
          debit:=0;
          credit:=0;
          while not Query1.EOF do
           Begin
             libelle:=DM_C_ListeFenetre.Strings[8];
             LVResult.Items.Add.Caption:=libelle;
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Compte').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Reference').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Designation').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('DateSaisie').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(Query1.FindField('MtBilanOuverture').AsCurrency));
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(0));
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FlecheG+'Mt Bilan Ouverture');
             MontantDebit:=MontantDebit+Query1.FindField('MtBilanOuverture').AsCurrency;
             debit:=debit+Query1.FindField('MtBilanOuverture').AsCurrency;
             Query1.Next;
           End;
           if libelle<>'' then InitSousTotaux(Debit,Credit,libelle);

//          // Table Provisions
//          if Empty(EdCptDeb.Text) then
//             FiltrageDataSet(DMRech.TaProvisionsRech,CreeFiltreET(['DateSaisie'],[datetostr(E.DatExoDebut-1)]))
//           else
//             FiltrageDataSet(DMRech.TaProvisionsRech,CreeFiltreET(['Compte','DateSaisie'],[EdCptDeb.Text,datetostr(E.DatExoDebut-1)]));
//
//          DMRech.TaProvisionsRech.First;
//          while not DMRech.TaProvisionsRech.EOF do
//           Begin
//             LVResult.Items.Add.Caption:=DM_C_ListeFenetre.Strings[8];
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaProvisionsRech.FindField('Compte').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaProvisionsRech.FindField('Reference').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaProvisionsRech.FindField('Designation').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaProvisionsRech.FindField('DateSaisie').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FormatFloat(E.FormatMonnaie + ';; ',DMRech.TaProvisionsRech.FindField('MtBilanOuverture').AsCurrency));
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FlecheG+'Mt Bilan Ouverture');
//             DMRech.TaProvisionsRech.Next;
//           End;
//           DeFiltrageDataSet(DMRech.TaProvisionsRech);


//          // Table Ecriture

          QuRechercheEcrituresOuverture(Query1);
          Query1.First;
          Libelle:='';
          debit:=0;
          credit:=0;
          while not Query1.EOF do
           Begin
             libelle:=DM_C_ListeFenetre.Strings[9];
             LVResult.Items.Add.Caption:=Query1.FindField('id').AsString;
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Compte').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('tiers').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Reference').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Libelle').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Date').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(Query1.FindField('DebitSaisie').AsCurrency));
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(Query1.FindField('CreditSaisie').AsCurrency));
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets);
             MontantDebit:=MontantDebit+Query1.FindField('DebitSaisie').AsCurrency;
             MontantCredit:=MontantCredit+Query1.FindField('CreditSaisie').AsCurrency ;
             Debit:=Debit+Query1.FindField('DebitSaisie').AsCurrency;
             Credit:=Credit+Query1.FindField('CreditSaisie').AsCurrency ;
//             Montant:=Montant+(Query1.FindField('DebitSaisie').AsCurrency-Query1.FindField('CreditSaisie').AsCurrency);
             Query1.Next;
           End;
           if libelle<>'' then InitSousTotaux(Debit,Credit,libelle);

////          // Table Ecriture
//
//          FiltrageDataSet(DMRech.TaPieceRech,'Compte='''+EdCptDeb.Text+''' and Date <'''+datetostr(E.DatExoDebut)+'''');
////          FiltrageDataSet(DMRech.TaEcritureRech(['Compte','DateSaisie'],[EdCptDeb.Text,datetostr(E.DatExoDebut-1)]));
//          DMRech.TaPieceRech.First;
//          while not DMRech.TaPieceRech.EOF do
//           Begin
//             LVResult.Items.Add.Caption:=DM_C_ListeFenetre.Strings[9];
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaPieceRech.FindField('Compte').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaPieceRech.FindField('Reference').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaPieceRech.FindField('Libelle').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaPieceRech.FindField('Date').AsString);
////             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FormatFloat(E.FormatMonnaie + ';; ',TaEcritureRech.FindField('MtBilanOuverture').AsCurrency));
////             LVResult.Items[LVResult.Items.Count-1].SubItems.Add('< -- Mt Bilan Ouverture');
//             DMRech.TaPieceRech.Next;
//           End;
//           DeFiltrageDataSet(DMRech.TaPieceRech);


            // Table Balance
            QuRechercheBalanceOuv(Query1);
           Libelle:='';
           Query1.First;
          debit:=0;
          credit:=0;
            while not Query1.EOF do
             Begin
             libelle:=DM_C_ListeFenetre.Strings[11];
             LVResult.Items.Add.Caption:=libelle;
               LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Compte').AsString);
               LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('tiers').AsString);
               LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets);
               LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('libelle').AsString);
               LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DateInfos(E.DatExoDebut-1).DateStrFormat);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(Query1.FindField('Debit_Report').AsCurrency));
               LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(Query1.FindField('Credit_Report').AsCurrency));
               LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets);
               MontantDebit:=MontantDebit+Query1.FindField('Debit_Report').AsCurrency;
               MontantCredit:=MontantCredit+Query1.FindField('Credit_Report').AsCurrency ;
               Debit:=Debit+Query1.FindField('Debit_Report').AsCurrency;
               Credit:=Credit+Query1.FindField('Credit_Report').AsCurrency ;
               //Montant:=Montant+ (Query1.FindField('Debit_Report').AsCurrency-Query1.FindField('Credit_Report').AsCurrency);
               Query1.Next;
             End;
             if libelle<>'' then InitSousTotaux(Debit,Credit,libelle);

////          // Table Ecriture
//          FiltrageDataSet(DMRech.TaEcritureRech,'Compte='''+EdCptDeb.Text+''' and DateSaisie <'''+datetostr(E.DatExoDebut)+'''');
////          FiltrageDataSet(DMRech.TaEcritureRech(['Compte','DateSaisie'],[EdCptDeb.Text,datetostr(E.DatExoDebut-1)]));
//          DMRech.TaEcritureRech.First;
//          while not DMRech.TaEcritureRech.EOF do
//           Begin
//             LVResult.Items.Add.Caption:=DM_C_ListeFenetre.Strings[9];
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaEcritureRech.FindField('Compte').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaEcritureRech.FindField('Reference').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaEcritureRech.FindField('Libelle').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaEcritureRech.FindField('Date').AsString);
////             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FormatFloat(E.FormatMonnaie + ';; ',TaEcritureRech.FindField('MtBilanOuverture').AsCurrency));
////             LVResult.Items[LVResult.Items.Count-1].SubItems.Add('< -- Mt Bilan Ouverture');
//             DMRech.TaEcritureRech.Next;
//           End;
//           DeFiltrageDataSet(DMRech.TaEcritureRech);
//
//          // Table PlanCpt ( bilan d'ouverture )
//          FiltrageDataSet(DMRech.TaPlanCptRech,'Compte='''+EdCptDeb.Text+''' and Date <'''+datetostr(E.DatExoDebut)+'''');
//          DMRech.TaProvisionsRech.First;
//          while not DMRech.TaProvisionsRech.EOF do
//           Begin
//             LVResult.Items.Add.Caption:=DM_C_ListeFenetre.Strings[8];
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaProvisionsRech.FindField('Compte').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaProvisionsRech.FindField('Reference').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaProvisionsRech.FindField('Designation').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaProvisionsRech.FindField('DateSaisie').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FormatFloat(E.FormatMonnaie + ';; ',DMRech.TaProvisionsRech.FindField('MtBilanOuverture').AsCurrency));
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add('< -- Mt Bilan Ouverture');
//             DMRech.TaProvisionsRech.Next;
//           End;
//           DeFiltrageDataSet(DMRech.TaProvisionsRech);

        end;
      2:Begin
          FiltrageDataSet(DMRech.TaPieceRech,'');
          Libelle:='';
          DMRech.TaPieceRech.First;
          while not DMRech.TaPieceRech.EOF do
           Begin
             libelle:='Pièce';
             LVResult.Items.Add.Caption:=libelle;
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaPieceRech.FindField('Compte').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaPieceRech.FindField('Reference').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaPieceRech.FindField('Libelle').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaPieceRech.FindField('Date').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add('--------------------');
             DMRech.TaPieceRech.Next;
           End;
           DeFiltrageDataSet(DMRech.TaPieceRech);

        End;

      1:Begin
//          // Table Ecriture

          QuRechercheEcritures(Query1);
          Query1.First;
          Libelle:='';
          debit:=0;
          credit:=0;
          while not Query1.EOF do
           Begin
             libelle:=DM_C_ListeFenetre.Strings[12];
             LVResult.Items.Add.Caption:=Query1.FindField('id').AsString;
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Compte').AsString) ;
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('tiers').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Reference').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Libelle').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Query1.FindField('Date').AsString);
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(Query1.FindField('DebitSaisie').AsCurrency));
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(Query1.FindField('CreditSaisie').AsCurrency));
             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets);
             MontantDebit:=MontantDebit+Query1.FindField('DebitSaisie').AsCurrency;
             MontantCredit:=MontantCredit+Query1.FindField('CreditSaisie').AsCurrency ;
             Debit:=Debit+Query1.FindField('DebitSaisie').AsCurrency;
             Credit:=Credit+Query1.FindField('CreditSaisie').AsCurrency ;
//             Montant:=Montant+(Query1.FindField('DebitSaisie').AsCurrency-Query1.FindField('CreditSaisie').AsCurrency);
             Query1.Next;
           End;
           if libelle<>'' then InitSousTotaux(Debit,Credit,libelle);

//          FiltrageDataSet(DMRech.TaEcritureRech,'');
//          DMRech.TaEcritureRech.First;
//          while not DMRech.TaEcritureRech.EOF do
//           Begin
//
//             LVResult.Items.Add.Caption:='Ecriture';
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaEcritureRech.FindField('Compte').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Infos_TInfosPiece(DMRech.TaPieceRech,'ID',[DMRech.TaEcritureRech.FindField('ID_Piece').AsString]).Reference);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaEcritureRech.FindField('Libelle').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaEcritureRech.FindField('Date').AsString);
//             if not VerifFNumeric(DMRech.TaEcritureRech.FindField('DebitSaisie')).VideOUZero then
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FormatFloat(',0.00 '+E.DeviseSigle + '" | D";; ',DMRech.TaEcritureRech.FindField('DebitSaisie').AsCurrency))
//             else
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FormatFloat(',0.00 '+E.DeviseSigle + '" | C";; ',DMRech.TaEcritureRech.FindField('CreditSaisie').AsCurrency));
//             DMRech.TaEcritureRech.Next;
//           End;
//           DeFiltrageDataSet(DMRech.TaEcritureRech);

        End;

      4:Begin
//          FiltrageDataSet(DMRech.TaEcritureRech,'');
//          DMRech.TaEcritureRech.First;
//          while not DMRech.TaEcritureRech.EOF do
//           Begin
//
//             LVResult.Items.Add.Caption:='Ecriture';
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaEcritureRech.FindField('Compte').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Infos_TInfosPiece(DMRech.TaPieceRech,'ID',[DMRech.TaEcritureRech.FindField('ID_Piece').AsString]).Reference);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaEcritureRech.FindField('Libelle').AsString);
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(DMRech.TaEcritureRech.FindField('Date').AsString);
//             if not VerifFNumeric(DMRech.TaEcritureRech.FindField('DebitSaisie')).VideOUZero then
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FormatFloat(',0.00 '+E.DeviseSigle + '" | D";; ',DMRech.TaEcritureRech.FindField('DebitSaisie').AsCurrency))
//             else
//             LVResult.Items[LVResult.Items.Count-1].SubItems.Add(FormatFloat(',0.00 '+E.DeviseSigle + '" | C";; ',DMRech.TaEcritureRech.FindField('CreditSaisie').AsCurrency));
//             DMRech.TaEcritureRech.Next;
//           End;
//           DeFiltrageDataSet(DMRech.TaEcritureRech);

        End;
   end; // fin du CAse

   end; // fin du if ChLBTableRech.Checked[i] then
 end; //Fin du for i:=0 to ChLBTableRech.Items.Count - 1 do
if LVResult.Items.Count = 0 then
 LVResult.Items.Add.Caption:=PasDeResultat;
LVResult.Show;
if ((LVResult.Visible) and (self.Visible)) then
 begin
   LVResult.SetFocus;
   if LVResult.Items.Count > 0 then
    LVResult.Selected := LVResult.Items.Item[0];
 end;
SauveRechCouranteDsViewList;
Finally
GrGrid1.Cells[2,0]:='';

GrGrid2.Cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',MontantDebit);
GrGrid2.Cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',MontantCredit);

DetermineSolde(MontantDebit,MontantCredit);
if MontantDebit<MontantCredit then
  GrGrid1.Cells[2,0]:='Solde Créditeur'
else
  if MontantDebit>MontantCredit then
    GrGrid1.Cells[2,0]:='Solde Débiteur';
GrGrid1.Cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',MontantDebit);
GrGrid1.Cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',MontantCredit);
Screen.Cursor := crDefault;
self.Caption := 'Résultat de la recherche : ' + Str_SingulierToPluriel(LVResult.Items.Count,'Ligne')+ Str_SingulierToPluriel(LVResult.Items.Count,'trouvée',false)+'.'
end;
//Patientez.close;
end;

procedure TRechercheBD.FormResize(Sender: TObject);
begin
//InfoTailleForm(self);
end;

procedure TRechercheBD.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,E.User);
RechercheBD:=nil;
end;

procedure TRechercheBD.FormActivate(Sender: TObject);
begin
LVResult.Color :=ParamUtil.CouleurDBGrid.GrilleColorFond;
end;

procedure TRechercheBD.LVResultDblClick(Sender: TObject);
var
ParamImmo_Ouverture:TParamAfficheImmo_Ouverture;
begin
//   Result.Add('Ouverture - Emprunts'); //1
//   Result.Add('Ouverture - Stocks');   //2
//   Result.Add('Ouverture - Charges A Répartir');  //3
//   Result.Add('Ouverture - Charges Constatées d''Avance');  //4
//   Result.Add('Ouverture - Produits Constatés d''Avance'); //5
//   Result.Add('Ouverture - Charges A Payer');  //6
//   Result.Add('Ouverture - Produits A Recevoir');  //7
//   Result.Add('Ouverture - Provisions');  //8
if LVResult.Selected = nil then
 begin
  if LVResult.Items.Count > 0 then
   LVResult.Selected := LVResult.Items.Item[0];
 end;
if LVResult.Selected <> nil then
begin
    case DM_C_ListeFenetre.IndexOf(LVResult.Selected.Caption) of
    //  0:Main.Immobilisations1.Click;
      0:begin
         ///{ isa  le  18/02/04 }
        ParamImmo_Ouverture.TypePresentation:=1;
        ParamImmo_Ouverture.AffichageModal := true;
        ParamImmo_Ouverture.Affiche := true;
        ParamImmo_Ouverture.Quand := C_Ouverture;
        ParamImmo_Ouverture.typeImmos:=C_toutes;
         ///{ isa  le  18/02/04 }

         ParamImmo_Ouverture.Compte :=LVResult.Selected.SubItems[0];
      // Compte + '  ' + Code + '  ' + Sous_Code + '  ' + Libelle
         ParamImmo_Ouverture.LibImmo :=LVResult.Selected.SubItems[2];
         ParamImmo_Ouverture.Locate:=true;
         AfficheImmo_Ouverture(ParamImmo_Ouverture);
        end;
      1:Main.Emprunts1.Click;
      2:Main.Stoks1.Click;
      3:Main.Chargesrpartir1.Click;
      4:Main.Cetpconstatsdavance1.Click;
      5:Main.Cetpconstatsdavance1.Click;
      6:Main.Cetprecevoir1.Click;
      7:Main.Cetprecevoir1.Click;
      8:Main.Provisions1.Click;
   9,10,12:Visualisation1.Click;
    else
     begin
        if LVResult.Selected.Caption = PasDeResultat then
        else
         MessageDlg(AccesEcranRefuse_General,mtInformation,[mbOK],0);
     end;
     if LVResult.Selected.Caption <> PasDeResultat then
     GestionCaptionBtnChercher(false);
    end;
end;
end;

procedure TRechercheBD.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
WinSuivPrec(Handle,key,[LVResult,BtnAnnuler,BtnChercher,BtnModifier,BtnFermer,BtnImprimer]);
   If Key = VK_ESCAPE Then
     Begin
      if (ActiveControl = ChLBTableRech) or (ActiveControl = EdCptDeb)  then
         Self.Close
         //else ChLBTableRech.SetFocus;
         else EdCptDeb.SetFocus;
     end;
end;

procedure TRechercheBD.EdCptDebKeyPress(Sender: TObject; var Key: Char);
begin
//if key = #13 then
// begin
//  BtnChercherClick(BtnChercher);
//  key := #0;
// end;
if(Sender is TEdit)then
  begin
     if key in [#65..#90,#97..#122] then
       begin
              if not str_commence_par((Sender as TEdit).Text,'+') then
                   (Sender as TEdit).Text:='+';
              (Sender as TEdit).SelStart:=length((Sender as TEdit).Text);
       end;
  end;
key:=str_majusculeschar(key);
end;

procedure TRechercheBD.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnChercher,BtnModifier,BtnSupprimer, BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TRechercheBD.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TRechercheBD.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TRechercheBD.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TRechercheBD.BtnFermerClick(Sender: TObject);
begin
self.Close;
end;
procedure TRechercheBD.EdCptDebExit(Sender: TObject);
begin
if activecontrol = BtnAnnuler then
 if LVResult.Visible then
  LVResult.SetFocus;
end;

procedure TRechercheBD.BtnImprimerSelectionClick(Sender: TObject);
var
ListeValeur:TStringList;
ObjPrn:TObjetEdition;
i:integer;
debit,credit:currency;
begin
try//finally
 ListeValeur:=TStringList.Create;
 ObjPrn:=TObjetEdition.Create(application.MainForm);
 for i:=0 to LVResult.Items.Count-1 do
  Begin
            if (LVResult.Items[i].Selected) then
                begin
                   ListeValeur.Add('0'+
                                    ';'+
                                    GereLibelle(LVResult.Items[i].SubItems.Strings[4])+
                                    ';'+
                                    GereLibelle(LVResult.Items[i].SubItems.Strings[2])+
                                    ';'+
                                    GereLibelle(LVResult.Items[i].SubItems.Strings[0])+
                                    ';'+
                                    GereLibelle(LVResult.Items[i].SubItems.Strings[1])+
                                    ';'+
                                    GereLibelle(LVResult.Items[i].SubItems.Strings[3])+
                                    ';'+
                                    GereLibelle(LVResult.Items[i].SubItems.Strings[5])+
                                    ';'+
                                    GereLibelle(LVResult.Items[i].SubItems.Strings[6]));
                 debit:=debit + StrToCurr_Lgr(LVResult.Items[i].SubItems.Strings[5]);
                 credit:=credit + StrToCurr_Lgr(LVResult.Items[i].SubItems.Strings[6]);
       end; //fin si ligne selectionnée
  End;

   ListeValeur.Add('1;;;;;@Total des mouvements :  ;'+FormatFloat(e.FormatMonnaie + ';; ',debit)+';'+FormatFloat(e.FormatMonnaie + ';; ',credit));
   DetermineSolde(debit,credit);
   ListeValeur.Add('1;;;;;@Soldes :  ;'+FormatFloat(e.FormatMonnaie + ';; ',debit)+';'+FormatFloat(e.FormatMonnaie + ';; ',credit));
   ObjPrn.FTitreEdition := 'Etat de la recherche';
   ObjPrn.FTitre2Edition :='Période du '+DateInfos(E.DatExoDebut).DateStr+' au '+DateInfos(E.DatExoFin).DateStr;
   ObjPrn.FTitre3Edition := 'Dossier : '+E.NomDossier;
   //ListeValeur.Insert(0,' Compte 0; Tiers 1; Référence 2; Libellé 3; Date 4; Débit ; Crédit ');
   ListeValeur.Insert(0,' Date ; Référence ; Compte ; Tiers; Libellé ; Débit ; Crédit ');
   ListeValeur.Insert(1,'0.8;0.8;0.6;1.2;2;1.0;1.0');
   ListeValeur.Insert(2,'texte;texte;texte;texte;texte;curr;curr');
   ObjPrn.Orientation := poPortrait;
   ObjPrn.AffichageImp(ListeValeur);
finally
     LibereObjet(Tobject(ObjPrn),Self);
//   ObjPrn.destroy;
end;
end;

procedure TRechercheBD.BtnImprimerClick(Sender: TObject);
var
ListeValeur:TStringList;
ObjPrn:TObjetEdition;
i:integer;
debit,credit:currency;
begin
try//finally
 ListeValeur:=TStringList.Create;
 ObjPrn:=TObjetEdition.Create(application.MainForm);
 for i:=0 to LVResult.Items.Count-1 do
  Begin
     ListeValeur.Add('0'+
                      ';'+
                      GereLibelle(LVResult.Items[i].SubItems.Strings[4])+
                      ';'+
                      GereLibelle(LVResult.Items[i].SubItems.Strings[2])+
                      ';'+
                      GereLibelle(LVResult.Items[i].SubItems.Strings[0])+
                      ';'+
                      GereLibelle(LVResult.Items[i].SubItems.Strings[1])+
                      ';'+
                      GereLibelle(LVResult.Items[i].SubItems.Strings[3])+
                      ';'+
                      GereLibelle(LVResult.Items[i].SubItems.Strings[5])+
                      ';'+
                      GereLibelle(LVResult.Items[i].SubItems.Strings[6]));
   debit:=debit + StrToCurr_Lgr(LVResult.Items[i].SubItems.Strings[5]);
   credit:=credit + StrToCurr_Lgr(LVResult.Items[i].SubItems.Strings[6]);

  End;
   debit:=StrToCurr_Lgr(GrGrid2.Cells[0,0]);
   credit:=StrToCurr_Lgr(GrGrid2.Cells[1,0]);

   ListeValeur.Add('1;;;;;@Total des mouvements :  ;'+FormatFloat(e.FormatMonnaie + ';; ',debit)+';'+FormatFloat(e.FormatMonnaie + ';; ',credit));
   DetermineSolde(debit,credit);
   ListeValeur.Add('1;;;;;@Soldes :  ;'+FormatFloat(e.FormatMonnaie + ';; ',debit)+';'+FormatFloat(e.FormatMonnaie + ';; ',credit));
   ObjPrn.FTitreEdition := 'Etat de la recherche';
//   ObjPrn.FTitre2Edition :='Période du '+DateInfos(E.DatExoDebut).DateStr+' au '+DateInfos(E.DatExoFin).DateStr;
   ObjPrn.FTitre2Edition :='Période du '+EdDateDeb.Text+' au '+EdDateFin.Text;
   ObjPrn.FTitre3Edition := 'Dossier : '+E.NomDossier;
   //ListeValeur.Insert(0,' Compte 0; Tiers 1; Référence 2; Libellé 3; Date 4; Débit ; Crédit ');
   ListeValeur.Insert(0,' Date ; Référence ; Compte ; Tiers; Libellé ; Débit ; Crédit ');
   ListeValeur.Insert(1,'0.8;0.8;0.6;1.2;2;1.0;1.0');
   ListeValeur.Insert(2,'texte;texte;texte;texte;texte;curr;curr');
   ObjPrn.Orientation := poPortrait;
   ObjPrn.AffichageImp(ListeValeur);
finally
     LibereObjet(Tobject(ObjPrn),Self);
//   ObjPrn.destroy;
end;
end;

Procedure TRechercheBD.QuRechercheStocksOuv(Query:TQuery);
var
Tmp:String;
Begin
ProtectObjetNil([Query]);
Query.Close;
Query.DatabaseName := DM_C_NomAliasExercice;
Query.SQL.Clear;
Query.Params.Clear;
Query.SQL.Add(' select * from stock ');
Query.SQL.Add(' where actif = true ');

// Section recherche sur compte //////////////////////////////
Tmp:=EdCptDeb.Text;
Tmp:=Str_UpperSQL(Tmp);
if empty(EdCptDeb.Text) then Tmp:= '%';
if empty(EdCptFin.Text) then
   Query.SQL.Add(' and upper(compte) like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
  else
   Query.SQL.Add(' and upper(compte) >='''+Tmp+'''');

Tmp:=EdCptFin.Text;
Tmp:=Str_UpperSQL(Tmp);
if not empty(EdCptFin.Text) then
 begin
  Query.SQL.Add(' and upper(compte) <='''+Tmp+'''');
 end;
//////////////////////////////////////////////////////////////

// Section recherche sur Référence //////////////////////////////
Tmp:=EdRefDeb.Text;
Tmp:=Str_UpperSQL(Tmp);
//if empty(EdRefDeb.Text) then Tmp:= '%';
if empty(EdRefFin.Text) then
 begin
   if empty(EdRefDeb.Text) then
    Query.SQL.Add(' and (Reference is null or upper(Reference) like('''+'%'+'''))')
    else
     Query.SQL.Add(' and upper(Reference) like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
  end
  else
   begin
   if empty(EdRefDeb.Text) then
     Query.SQL.Add(' and (Reference is null or upper(Reference) like('''+'%'+'''))')
    else
     Query.SQL.Add(' and upper(Reference) >='''+Tmp+'''');
   end;

Tmp:=EdRefFin.Text;
Tmp:=Str_UpperSQL(Tmp);
if not empty(EdRefFin.Text) then
 begin
   if empty(EdRefDeb.Text) then
     Query.SQL.Add(' and (Reference is null or upper(Reference) <='''+Tmp+''')')
    else
     Query.SQL.Add(' and upper(Reference) <='''+Tmp+'''');
 end;
//////////////////////////////////////////////////////////////
//// Section recherche sur Référence //////////////////////////////
//Tmp:=EdRefDeb.Text;
//if empty(EdRefDeb.Text) then Tmp:= '%';
//if empty(EdRefFin.Text) then
//   Query.SQL.Add(' and Reference like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
//  else
//   Query.SQL.Add(' and Reference >='''+Tmp+'''');
//
//Tmp:=EdRefFin.Text;
//if not empty(EdRefFin.Text) then
// begin
//  Query.SQL.Add(' and Reference <='''+Tmp+'''');
// end;
////////////////////////////////////////////////////////////////

// Section recherche sur Montant //////////////////////////////
Tmp:=CuMontantDeb.Text;
if ((not empty(CuMontantDeb.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantDeb.Text) <> '0.00')) then
  begin
    if ((empty(CuMontantFin.Text)) or (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) = '0.00')) then
       Query.SQL.Add(' and MontantTotalHT ='''+str_QueDesChiffresCurr_SQL(Tmp)+'''')
      else
       Query.SQL.Add(' and MontantTotalHT >='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');

    Tmp:=CuMontantFin.Text;
    if ((not empty(CuMontantFin.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) <> '0.00')) then
     begin
      Query.SQL.Add(' and MontantTotalHT <='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');
     end;
  end;
//////////////////////////////////////////////////////////////

//Section Date de Saisie //////////////////////////////
Query.SQL.Add(' and Date_Saisie <'''+ DateInfos(E.DatExoDebut).DatePourSQLStr+''' ');
//////////////////////////////////////////////////////////////

//Section Libellé //////////////////////////////
if not empty(EdLibelle.Text) then
   Query.SQL.Add(' and upper(designation) like(''%'+Str_UpperSQL(EdLibelle.Text)+'%'')');
//////////////////////////////////////////////////////////////

//showmessage(Query.SQL.Text);
Query.Open;
End;

Procedure TRechercheBD.QuRechercheImmosOuv(Query:TQuery);
var
Tmp:String;
Begin
ProtectObjetNil([Query]);
Query.Close;
Query.DatabaseName := DM_C_NomAliasDossier;
Query.SQL.Clear;
Query.Params.Clear;
Query.SQL.Add(' select * from immos ');
Query.SQL.Add(' where Achat_dans_Annee = False ');

// Section recherche sur compte //////////////////////////////
Tmp:=EdCptDeb.Text;
if empty(EdCptDeb.Text) then Tmp:= '%';
if empty(EdCptFin.Text) then
   Query.SQL.Add(' and upper(compte) like('''+str_remplacesouschaine(Str_UpperSQL(Tmp),'*','%')+''')')
  else
   Query.SQL.Add(' and upper(compte) >='''+Str_UpperSQL(Tmp)+'''');

Tmp:=EdCptFin.Text;
if not empty(EdCptFin.Text) then
 begin
  Query.SQL.Add(' and upper(compte) <='''+Str_UpperSQL(Tmp)+'''');
 end;
//////////////////////////////////////////////////////////////

//// Section recherche sur Référence //////////////////////////////
//Tmp:=EdRefDeb.Text;
////if empty(EdRefDeb.Text) then Tmp:= '%';
//if empty(EdRefFin.Text) then
//   if empty(EdRefDeb.Text) then
//    Query.SQL.Add(' and (Reference is null or Reference like('''+'%'+'''))')
//    else
//     Query.SQL.Add(' and Reference like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
//  else
//   Query.SQL.Add(' and Reference >='''+Tmp+'''');
//
//Tmp:=EdRefFin.Text;
//if not empty(EdRefFin.Text) then
// begin
//  Query.SQL.Add(' and Reference <='''+Tmp+'''');
// end;
////////////////////////////////////////////////////////////////

// Section recherche sur Montant //////////////////////////////
//Valeur_a_amortir-Amort_Eco-Amort_Derog
Tmp:=CuMontantDeb.Text;
if ((not empty(CuMontantDeb.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantDeb.Text) <> '0.00')) then
  begin
    //travail sur valeur nette
    if ((empty(CuMontantFin.Text)) or (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) = '0.00')) then
       Query.SQL.Add(' and( (Valeur_a_amortir-Amort_Eco-Amort_Derog) ='''+str_QueDesChiffresCurr_SQL(Tmp)+''')')
      else
       Query.SQL.Add(' and( (Valeur_a_amortir-Amort_Eco-Amort_Derog) >='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');

    Tmp:=CuMontantFin.Text;
    if ((not empty(CuMontantFin.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) <> '0.00')) then
     begin
      Query.SQL.Add(' and (Valeur_a_amortir-Amort_Eco-Amort_Derog) <='''+str_QueDesChiffresCurr_SQL(Tmp)+''')');
     end;
//    //travail sur Valeur à amortir
//    if ((empty(CuMontantFin.Text)) or (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) = '0.00')) then
//       Query.SQL.Add(' or( (Valeur_a_amortir) ='''+str_QueDesChiffresCurr_SQL(Tmp)+''')')
//      else
//       Query.SQL.Add(' or( (Valeur_a_amortir) >='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');
//
//    Tmp:=CuMontantFin.Text;
//    if ((not empty(CuMontantFin.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) <> '0.00')) then
//     begin
//      Query.SQL.Add(' and (Valeur_a_amortir) <='''+str_QueDesChiffresCurr_SQL(Tmp)+''')');
//     end;
  end;
//////////////////////////////////////////////////////////////

//Section Date de Saisie //////////////////////////////
//Query.SQL.Add(' and Date_Saisie <'''+ DateInfos(E.DatExoDebut).DatePourSQLStr+''' ');
//////////////////////////////////////////////////////////////

//Section Libellé //////////////////////////////
if not empty(EdLibelle.Text) then
   Query.SQL.Add(' and upper(code+sous_code+Libelle) like(''%'+Str_UpperSQL(EdLibelle.Text)+'%'')');
//////////////////////////////////////////////////////////////

//showmessage(Query.SQL.Text);
Query.Open;
//DMRech.TaImmosRech.FindField('Valeur_a_amortir').AsCurrency-DMRech.TaImmosRech.FindField('Amort_Eco').AsCurrency-DMRech.TaImmosRech.FindField('Amort_Derog').AsCurrency));

End;

Procedure TRechercheBD.QuRechercheEmpruntsOuv(Query:TQuery);
var
Tmp:String;
Begin
ProtectObjetNil([Query]);
Query.Close;
Query.DatabaseName := DM_C_NomAliasDossier;
Query.SQL.Clear;
Query.Params.Clear;
Query.SQL.Add(' select * from Emprunts where');
Query.SQL.Add(' actif = false  ');

// Section recherche sur compte //////////////////////////////
Tmp:=EdCptDeb.Text;
Tmp:=Str_UpperSQL(Tmp);
if empty(EdCptDeb.Text) then Tmp:= '%';
if empty(EdCptFin.Text) then
   Query.SQL.Add(' and upper(compte_emp) like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
  else
   Query.SQL.Add(' and upper(compte_emp) >='''+Tmp+'''');

Tmp:=EdCptFin.Text;
Tmp:=Str_UpperSQL(Tmp);
if not empty(EdCptFin.Text) then
 begin
  Query.SQL.Add(' and upper(compte_emp) <='''+Tmp+'''');
 end;
//////////////////////////////////////////////////////////////

//// Section recherche sur Référence //////////////////////////////
//Tmp:=EdRefDeb.Text;
////if empty(EdRefDeb.Text) then Tmp:= '%';
//if empty(EdRefFin.Text) then
//   if empty(EdRefDeb.Text) then
//    Query.SQL.Add(' and (Reference is null or Reference like('''+'%'+'''))')
//    else
//     Query.SQL.Add(' and Reference like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
//  else
//   Query.SQL.Add(' and Reference >='''+Tmp+'''');
//
//Tmp:=EdRefFin.Text;
//if not empty(EdRefFin.Text) then
// begin
//  Query.SQL.Add(' and Reference <='''+Tmp+'''');
// end;
////////////////////////////////////////////////////////////////

// Section recherche sur Montant //////////////////////////////
Tmp:=CuMontantDeb.Text;
if ((not empty(CuMontantDeb.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantDeb.Text) <> '0.00')) then
  begin
    if ((empty(CuMontantFin.Text)) or (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) = '0.00')) then
       Query.SQL.Add(' and CapiResteDu_Emp ='''+str_QueDesChiffresCurr_SQL(Tmp)+'''')
      else
       Query.SQL.Add(' and CapiResteDu_Emp >='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');

    Tmp:=CuMontantFin.Text;
    if ((not empty(CuMontantFin.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) <> '0.00')) then
     begin
      Query.SQL.Add(' and CapiResteDu_Emp <='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');
     end;
  end;
//////////////////////////////////////////////////////////////

//Section Date de Saisie //////////////////////////////
//Query.SQL.Add(' and Date_Saisie <'''+ DateInfos(E.DatExoDebut).DatePourSQLStr+''' ');
//////////////////////////////////////////////////////////////

//Section Libellé //////////////////////////////
if not empty(EdLibelle.Text) then
   Query.SQL.Add(' and upper(designation_emp) like(''%'+Str_UpperSQL(EdLibelle.Text)+'%'')');
//////////////////////////////////////////////////////////////

//showmessage(Query.SQL.Text);
Query.Open;
End;

Procedure TRechercheBD.QuRechercheChargeARepartirOuv(Query:TQuery);
var
Tmp:String;
Begin
ProtectObjetNil([Query]);
Query.Close;
Query.DatabaseName := DM_C_NomAliasExercice;
Query.SQL.Clear;
Query.Params.Clear;
Query.SQL.Add(' select * from ChargesRepartir where');

// Section recherche sur compte //////////////////////////////
Tmp:=EdCptDeb.Text;
Tmp:=Str_UpperSQL(Tmp);
if empty(EdCptDeb.Text) then Tmp:= '%';
if empty(EdCptFin.Text) then
   Query.SQL.Add(' upper(compte) like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
  else
   Query.SQL.Add(' upper(compte) >='''+Tmp+'''');

Tmp:=EdCptFin.Text;
Tmp:=Str_UpperSQL(Tmp);
if not empty(EdCptFin.Text) then
 begin
if empty(EdCptFin.Text) then
    Query.SQL.Add(' upper(compte) <='''+Tmp+'''')
  else
   Query.SQL.Add(' and upper(compte) <='''+Tmp+'''');
 end;
//////////////////////////////////////////////////////////////

// Section recherche sur Référence //////////////////////////////
Tmp:=EdRefDeb.Text;
Tmp:=Str_UpperSQL(Tmp);
//if empty(EdRefDeb.Text) then Tmp:= '%';
if empty(EdRefFin.Text) then
 begin
   if empty(EdRefDeb.Text) then
    Query.SQL.Add(' and (Reference is null or upper(Reference) like('''+'%'+'''))')
    else
     Query.SQL.Add(' and upper(Reference) like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
  end
  else
   begin
   if empty(EdRefDeb.Text) then
     Query.SQL.Add(' and (Reference is null or upper(Reference) like('''+'%'+'''))')
    else
     Query.SQL.Add(' and upper(Reference) >='''+Tmp+'''');
   end;

Tmp:=EdRefFin.Text;
Tmp:=Str_UpperSQL(Tmp);
if not empty(EdRefFin.Text) then
 begin
   if empty(EdRefDeb.Text) then
     Query.SQL.Add(' and (Reference is null or upper(Reference) <='''+Tmp+''')')
    else
     Query.SQL.Add(' and upper(Reference) <='''+Tmp+'''');
 end;
 
// Section recherche sur Montant //////////////////////////////
Tmp:=CuMontantDeb.Text;
if ((not empty(CuMontantDeb.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantDeb.Text) <> '0.00')) then
  begin
    if ((empty(CuMontantFin.Text)) or (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) = '0.00')) then
       Query.SQL.Add(' and MtBilanOuverture ='''+str_QueDesChiffresCurr_SQL(Tmp)+'''')
      else
       Query.SQL.Add(' and MtBilanOuverture >='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');

    Tmp:=CuMontantFin.Text;
    if ((not empty(CuMontantFin.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) <> '0.00')) then
     begin
      Query.SQL.Add(' and MtBilanOuverture <='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');
     end;
  end;
//////////////////////////////////////////////////////////////

//Section Date de Saisie //////////////////////////////
Query.SQL.Add(' and DateSaisie <'''+ DateInfos(E.DatExoDebut).DatePourSQLStr+''' ');
//////////////////////////////////////////////////////////////

//Section Libellé //////////////////////////////
if not empty(EdLibelle.Text) then
   Query.SQL.Add(' and upper(designation) like(''%'+Str_UpperSQL(EdLibelle.Text)+'%'')');
//////////////////////////////////////////////////////////////

//showmessage(Query.SQL.Text);
Query.Open;
End;

Procedure TRechercheBD.QuRechercheProvisionsOuv(Query:TQuery);
var
Tmp:String;
Begin
ProtectObjetNil([Query]);
Query.Close;
Query.DatabaseName := DM_C_NomAliasExercice;
Query.SQL.Clear;
Query.Params.Clear;
Query.SQL.Add(' select * from Provisions where');

// Section recherche sur compte //////////////////////////////
Tmp:=EdCptDeb.Text;
Tmp:=Str_UpperSQL(Tmp);
if empty(EdCptDeb.Text) then Tmp:= '%';
if empty(EdCptFin.Text) then
   Query.SQL.Add(' upper(compte) like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
  else
   Query.SQL.Add(' upper(compte) >='''+Tmp+'''');

Tmp:=EdCptFin.Text;
Tmp:=Str_UpperSQL(Tmp);
if not empty(EdCptFin.Text) then
 begin
if empty(EdCptFin.Text) then
    Query.SQL.Add(' upper(compte) <='''+Tmp+'''')
  else
   Query.SQL.Add(' and upper(compte) <='''+Tmp+'''');
 end;
//////////////////////////////////////////////////////////////

// Section recherche sur Référence //////////////////////////////
Tmp:=EdRefDeb.Text;
Tmp:=Str_UpperSQL(Tmp);
//if empty(EdRefDeb.Text) then Tmp:= '%';
if empty(EdRefFin.Text) then
 begin
   if empty(EdRefDeb.Text) then
    Query.SQL.Add(' and (Reference is null or upper(Reference) like('''+'%'+'''))')
    else
     Query.SQL.Add(' and upper(Reference) like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
  end
  else
   begin
   if empty(EdRefDeb.Text) then
     Query.SQL.Add(' and (Reference is null or upper(Reference) like('''+'%'+'''))')
    else
     Query.SQL.Add(' and upper(Reference) >='''+Tmp+'''');
   end;

Tmp:=EdRefFin.Text;
Tmp:=Str_UpperSQL(Tmp);
if not empty(EdRefFin.Text) then
 begin
   if empty(EdRefDeb.Text) then
     Query.SQL.Add(' and (Reference is null or upper(Reference) <='''+Tmp+''')')
    else
     Query.SQL.Add(' and upper(Reference) <='''+Tmp+'''');
 end;

// Section recherche sur Montant //////////////////////////////
Tmp:=CuMontantDeb.Text;
if ((not empty(CuMontantDeb.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantDeb.Text) <> '0.00')) then
  begin
    if ((empty(CuMontantFin.Text)) or (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) = '0.00')) then
       Query.SQL.Add(' and MtBilanOuverture ='''+str_QueDesChiffresCurr_SQL(Tmp)+'''')
      else
       Query.SQL.Add(' and MtBilanOuverture >='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');

    Tmp:=CuMontantFin.Text;
    if ((not empty(CuMontantFin.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) <> '0.00')) then
     begin
      Query.SQL.Add(' and MtBilanOuverture <='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');
     end;
  end;
//////////////////////////////////////////////////////////////

//Section Date de Saisie //////////////////////////////
Query.SQL.Add(' and DateSaisie <'''+ DateInfos(E.DatExoDebut).DatePourSQLStr+''' ');
//////////////////////////////////////////////////////////////

//Section Libellé //////////////////////////////
if not empty(EdLibelle.Text) then
   Query.SQL.Add(' and upper(designation) like(''%'+Str_UpperSQL(EdLibelle.Text)+'%'')');
//////////////////////////////////////////////////////////////

//showmessage(Query.SQL.Text);
Query.Open;
End;

Procedure TRechercheBD.QuRecherchePCADebitOuv(Query:TQuery);
var
Tmp:String;
Begin
ProtectObjetNil([Query]);
Query.Close;
Query.DatabaseName := DM_C_NomAliasExercice;
Query.SQL.Clear;
Query.Params.Clear;
Query.SQL.Add(' select * from Pca where');
Query.SQL.Add(' sens =''D'' ');

// Section recherche sur compte //////////////////////////////
Tmp:=EdCptDeb.Text;
Tmp:=Str_UpperSQL(Tmp);
if empty(EdCptDeb.Text) then Tmp:= '%';
if empty(EdCptFin.Text) then
   Query.SQL.Add(' and upper(compte) like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
  else
   Query.SQL.Add(' and upper(compte) >='''+Tmp+'''');

Tmp:=EdCptFin.Text;
Tmp:=Str_UpperSQL(Tmp);
if not empty(EdCptFin.Text) then
 begin
if empty(EdCptFin.Text) then
    Query.SQL.Add(' and upper(compte) <='''+Tmp+'''')
  else
   Query.SQL.Add(' and upper(compte) <='''+Tmp+'''');
 end;
//////////////////////////////////////////////////////////////

// Section recherche sur Référence //////////////////////////////
Tmp:=EdRefDeb.Text;
Tmp:=Str_UpperSQL(Tmp);
//if empty(EdRefDeb.Text) then Tmp:= '%';
if empty(EdRefFin.Text) then
 begin
   if empty(EdRefDeb.Text) then
    Query.SQL.Add(' and (Reference is null or upper(Reference) like('''+'%'+'''))')
    else
     Query.SQL.Add(' and upper(Reference) like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
  end
  else
   begin
   if empty(EdRefDeb.Text) then
     Query.SQL.Add(' and (Reference is null or upper(Reference) like('''+'%'+'''))')
    else
     Query.SQL.Add(' and upper(Reference) >='''+Tmp+'''');
   end;

Tmp:=EdRefFin.Text;
Tmp:=Str_UpperSQL(Tmp);
if not empty(EdRefFin.Text) then
 begin
   if empty(EdRefDeb.Text) then
     Query.SQL.Add(' and (Reference is null or upper(Reference) <='''+Tmp+''')')
    else
     Query.SQL.Add(' and upper(Reference) <='''+Tmp+'''');
 end;

// Section recherche sur Montant //////////////////////////////
Tmp:=CuMontantDeb.Text;
if ((not empty(CuMontantDeb.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantDeb.Text) <> '0.00')) then
  begin
    if ((empty(CuMontantFin.Text)) or (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) = '0.00')) then
       Query.SQL.Add(' and MontantHT ='''+str_QueDesChiffresCurr_SQL(Tmp)+'''')
      else
       Query.SQL.Add(' and MontantHT >='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');

    Tmp:=CuMontantFin.Text;
    if ((not empty(CuMontantFin.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) <> '0.00')) then
     begin
      Query.SQL.Add(' and MontantHT <='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');
     end;
  end;
//////////////////////////////////////////////////////////////

//Section Date de Saisie //////////////////////////////
Query.SQL.Add(' and DateSaisie <'''+ DateInfos(E.DatExoDebut).DatePourSQLStr+''' ');
//////////////////////////////////////////////////////////////

//Section Libellé //////////////////////////////
if not empty(EdLibelle.Text) then
   Query.SQL.Add(' and upper(Libelle) like(''%'+Str_UpperSQL(EdLibelle.Text)+'%'')');
//////////////////////////////////////////////////////////////

//showmessage(Query.SQL.Text);
Query.Open;
End;

Procedure TRechercheBD.QuRecherchePCACreditOuv(Query:TQuery);
var
Tmp:String;
Begin
ProtectObjetNil([Query]);
Query.Close;
Query.DatabaseName := DM_C_NomAliasExercice;
Query.SQL.Clear;
Query.Params.Clear;
Query.SQL.Add(' select * from Pca where');
Query.SQL.Add(' sens =''C'' ');

// Section recherche sur compte //////////////////////////////
Tmp:=EdCptDeb.Text;
Tmp:=Str_UpperSQL(Tmp);
if empty(EdCptDeb.Text) then Tmp:= '%';
if empty(EdCptFin.Text) then
   Query.SQL.Add(' and upper(compte) like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
  else
   Query.SQL.Add(' and upper(compte) >='''+Tmp+'''');

Tmp:=EdCptFin.Text;
Tmp:=Str_UpperSQL(Tmp);
if not empty(EdCptFin.Text) then
 begin
if empty(EdCptFin.Text) then
    Query.SQL.Add(' and upper(compte) <='''+Tmp+'''')
  else
   Query.SQL.Add(' and upper(compte) <='''+Tmp+'''');
 end;
//////////////////////////////////////////////////////////////

// Section recherche sur Référence //////////////////////////////
Tmp:=EdRefDeb.Text;
Tmp:=Str_UpperSQL(Tmp);
//if empty(EdRefDeb.Text) then Tmp:= '%';
if empty(EdRefFin.Text) then
 begin
   if empty(EdRefDeb.Text) then
    Query.SQL.Add(' and (Reference is null or upper(Reference) like('''+'%'+'''))')
    else
     Query.SQL.Add(' and upper(Reference) like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
  end
  else
   begin
   if empty(EdRefDeb.Text) then
     Query.SQL.Add(' and (Reference is null or upper(Reference) like('''+'%'+'''))')
    else
     Query.SQL.Add(' and upper(Reference) >='''+Tmp+'''');
   end;

Tmp:=EdRefFin.Text;
Tmp:=Str_UpperSQL(Tmp);
if not empty(EdRefFin.Text) then
 begin
   if empty(EdRefDeb.Text) then
     Query.SQL.Add(' and (Reference is null or upper(Reference) <='''+Tmp+''')')
    else
     Query.SQL.Add(' and upper(Reference) <='''+Tmp+'''');
 end;

// Section recherche sur Montant //////////////////////////////
Tmp:=CuMontantDeb.Text;
if ((not empty(CuMontantDeb.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantDeb.Text) <> '0.00')) then
  begin
    if ((empty(CuMontantFin.Text)) or (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) = '0.00')) then
       Query.SQL.Add(' and MontantHT ='''+str_QueDesChiffresCurr_SQL(Tmp)+'''')
      else
       Query.SQL.Add(' and MontantHT >='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');

    Tmp:=CuMontantFin.Text;
    if ((not empty(CuMontantFin.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) <> '0.00')) then
     begin
      Query.SQL.Add(' and MontantHT <='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');
     end;
  end;
//////////////////////////////////////////////////////////////

//Section Date de Saisie //////////////////////////////
Query.SQL.Add(' and DateSaisie <'''+ DateInfos(E.DatExoDebut).DatePourSQLStr+''' ');
//////////////////////////////////////////////////////////////

//Section Libellé //////////////////////////////
if not empty(EdLibelle.Text) then
   Query.SQL.Add(' and upper(Libelle) like(''%'+Str_UpperSQL(EdLibelle.Text)+'%'')');
//////////////////////////////////////////////////////////////

//showmessage(Query.SQL.Text);
Query.Open;
End;


Procedure TRechercheBD.QuRechercheChargesAPayerDebitOuv(Query:TQuery);
var
Tmp:String;
Begin
ProtectObjetNil([Query]);
Query.Close;
Query.DatabaseName := DM_C_NomAliasExercice;
Query.SQL.Clear;
Query.Params.Clear;
Query.SQL.Add(' select * from ChargeAPayer where');
Query.SQL.Add(' sens =''D'' ');

// Section recherche sur compte //////////////////////////////
Tmp:=EdCptDeb.Text;
Tmp:=Str_UpperSQL(Tmp);
if empty(EdCptDeb.Text) then Tmp:= '%';
if empty(EdCptFin.Text) then
   Query.SQL.Add(' and upper(compte) like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
  else
   Query.SQL.Add(' and upper(compte) >='''+Tmp+'''');

Tmp:=EdCptFin.Text;
Tmp:=Str_UpperSQL(Tmp);
if not empty(EdCptFin.Text) then
 begin
if empty(EdCptFin.Text) then
    Query.SQL.Add(' and upper(compte) <='''+Tmp+'''')
  else
   Query.SQL.Add(' and upper(compte) <='''+Tmp+'''');
 end;
//////////////////////////////////////////////////////////////

// Section recherche sur Référence //////////////////////////////
Tmp:=EdRefDeb.Text;
Tmp:=Str_UpperSQL(Tmp);
//if empty(EdRefDeb.Text) then Tmp:= '%';
if empty(EdRefFin.Text) then
 begin
   if empty(EdRefDeb.Text) then
    Query.SQL.Add(' and (Reference is null or upper(Reference) like('''+'%'+'''))')
    else
     Query.SQL.Add(' and upper(Reference) like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
  end
  else
   begin
   if empty(EdRefDeb.Text) then
     Query.SQL.Add(' and (Reference is null or upper(Reference) like('''+'%'+'''))')
    else
     Query.SQL.Add(' and upper(Reference) >='''+Tmp+'''');
   end;

Tmp:=EdRefFin.Text;
Tmp:=Str_UpperSQL(Tmp);
if not empty(EdRefFin.Text) then
 begin
   if empty(EdRefDeb.Text) then
     Query.SQL.Add(' and (Reference is null or upper(Reference) <='''+Tmp+''')')
    else
     Query.SQL.Add(' and upper(Reference) <='''+Tmp+'''');
 end;

// Section recherche sur Montant //////////////////////////////
Tmp:=CuMontantDeb.Text;
if ((not empty(CuMontantDeb.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantDeb.Text) <> '0.00')) then
  begin
    if ((empty(CuMontantFin.Text)) or (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) = '0.00')) then
       Query.SQL.Add(' and MontantHT ='''+str_QueDesChiffresCurr_SQL(Tmp)+'''')
      else
       Query.SQL.Add(' and MontantHT >='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');

    Tmp:=CuMontantFin.Text;
    if ((not empty(CuMontantFin.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) <> '0.00')) then
     begin
      Query.SQL.Add(' and MontantHT <='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');
     end;
  end;
//////////////////////////////////////////////////////////////
//Section Date de Saisie //////////////////////////////
Query.SQL.Add(' and DateSaisie <'''+ DateInfos(E.DatExoDebut).DatePourSQLStr+''' ');
//////////////////////////////////////////////////////////////

//Section Libellé //////////////////////////////
if not empty(EdLibelle.Text) then
   Query.SQL.Add(' and upper(Libelle) like(''%'+Str_UpperSQL(EdLibelle.Text)+'%'')');
//////////////////////////////////////////////////////////////

//showmessage(Query.SQL.Text);
Query.Open;
End;

Procedure TRechercheBD.QuRechercheChargesAPayerCreditOuv(Query:TQuery);
var
Tmp:String;
Begin
ProtectObjetNil([Query]);
Query.Close;
Query.DatabaseName := DM_C_NomAliasExercice;
Query.SQL.Clear;
Query.Params.Clear;
Query.SQL.Add(' select * from ChargeAPayer where');
Query.SQL.Add(' sens =''C'' ');

// Section recherche sur compte //////////////////////////////
Tmp:=EdCptDeb.Text;
Tmp:=Str_UpperSQL(Tmp);
if empty(EdCptDeb.Text) then Tmp:= '%';
if empty(EdCptFin.Text) then
   Query.SQL.Add(' and upper(compte) like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
  else
   Query.SQL.Add(' and upper(compte) >='''+Tmp+'''');

Tmp:=EdCptFin.Text;
Tmp:=Str_UpperSQL(Tmp);
if not empty(EdCptFin.Text) then
 begin
  if empty(EdCptFin.Text) then
      Query.SQL.Add(' and upper(compte) <='''+Tmp+'''')
    else
     Query.SQL.Add(' and upper(compte) <='''+Tmp+'''');
 end;
//////////////////////////////////////////////////////////////

// Section recherche sur Référence //////////////////////////////
Tmp:=EdRefDeb.Text;
Tmp:=Str_UpperSQL(Tmp);
//if empty(EdRefDeb.Text) then Tmp:= '%';
if empty(EdRefFin.Text) then
 begin
   if empty(EdRefDeb.Text) then
    Query.SQL.Add(' and (Reference is null or upper(Reference) like('''+'%'+'''))')
    else
     Query.SQL.Add(' and upper(Reference) like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
  end
  else
   begin
   if empty(EdRefDeb.Text) then
     Query.SQL.Add(' and (Reference is null or upper(Reference) like('''+'%'+'''))')
    else
     Query.SQL.Add(' and upper(Reference) >='''+Tmp+'''');
   end;

Tmp:=EdRefFin.Text;
Tmp:=Str_UpperSQL(Tmp);
if not empty(EdRefFin.Text) then
 begin
   if empty(EdRefDeb.Text) then
     Query.SQL.Add(' and (Reference is null or upper(Reference) <='''+Tmp+''')')
    else
     Query.SQL.Add(' and upper(Reference) <='''+Tmp+'''');
 end;

// Section recherche sur Montant //////////////////////////////
Tmp:=CuMontantDeb.Text;
if ((not empty(CuMontantDeb.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantDeb.Text) <> '0.00')) then
  begin
    if ((empty(CuMontantFin.Text)) or (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) = '0.00')) then
       Query.SQL.Add(' and MontantHT ='''+str_QueDesChiffresCurr_SQL(Tmp)+'''')
      else
       Query.SQL.Add(' and MontantHT >='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');

    Tmp:=CuMontantFin.Text;
    if ((not empty(CuMontantFin.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) <> '0.00')) then
     begin
      Query.SQL.Add(' and MontantHT <='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');
     end;
  end;
//////////////////////////////////////////////////////////////

//Section Date de Saisie //////////////////////////////
Query.SQL.Add(' and DateSaisie <'''+ DateInfos(E.DatExoDebut).DatePourSQLStr+''' ');
//////////////////////////////////////////////////////////////

//Section Libellé //////////////////////////////
if not empty(EdLibelle.Text) then
   Query.SQL.Add(' and upper(Libelle) like(''%'+Str_UpperSQL(EdLibelle.Text)+'%'')');
//////////////////////////////////////////////////////////////

//showmessage(Query.SQL.Text);
Query.Open;
End;

Procedure TRechercheBD.QuRechercheEcrituresOuverture(Query:TQuery);
var
Tmp:String;
DateDebTmp,DateFinTmp:TDate;
Begin
ProtectObjetNil([Query]);
Query.Close;
Query.DatabaseName := DM_C_NomAliasDossier;
Query.SQL.Clear;
Query.Params.Clear;

Query.SQL.Add(' select E.*,P.Reference from ecriture E ');
Query.SQL.Add(' join Piece P on (P.Id = E.Id_Piece) where ');

// Section recherche sur compte //////////////////////////////
// Compte comptable
if not TypeCptTiers(EdCptDeb.Text) then
 begin
    Tmp:=EdCptDeb.Text;
    Tmp:=Str_UpperSQL(Tmp);
    if empty(EdCptDeb.Text) then Tmp:= '%';
    if empty(EdCptFin.Text) then
       Query.SQL.Add(' upper(E.compte) like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
      else
       Query.SQL.Add(' upper(E.compte) >='''+Tmp+'''');
 end;
// Compte du plan auxiliaire
if TypeCptTiers(EdCptDeb.Text) then
 begin
    Tmp:=EdCptDeb.Text;
    Tmp:=Str_UpperSQL(Tmp);
    if empty(EdCptDeb.Text) then Tmp:= '%';
    if empty(EdCptFin.Text) then
       Query.SQL.Add(' upper(E.tiers) like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
      else
       Query.SQL.Add(' upper(E.tiers) >='''+Tmp+'''');
 end;
// Compte comptable
if not TypeCptTiers(EdCptDeb.Text) then
 begin
    Tmp:=EdCptFin.Text;
    Tmp:=Str_UpperSQL(Tmp);
    if not empty(EdCptFin.Text) then
     begin
    if empty(EdCptFin.Text) then
        Query.SQL.Add(' and upper(E.compte) <='''+Tmp+'''')
      else
       Query.SQL.Add(' and upper(E.compte) <='''+Tmp+'''');
     end;
 end;

// Compte tiers
if  TypeCptTiers(EdCptFin.Text) then
 begin
    Tmp:=EdCptFin.Text;
    Tmp:=Str_UpperSQL(Tmp);
    if not empty(EdCptFin.Text) then
     begin
    if empty(EdCptFin.Text) then
        Query.SQL.Add(' and upper(E.tiers) <='''+Tmp+'''')
      else
       Query.SQL.Add(' and upper(E.tiers) <='''+Tmp+'''');
     end;
 end;
//////////////////////////////////////////////////////////////

// Section recherche sur Référence //////////////////////////////
Tmp:=EdRefDeb.Text;
Tmp:=Str_UpperSQL(Tmp);
//if empty(EdRefDeb.Text) then Tmp:= '%';
if empty(EdRefFin.Text) then
 begin
   if empty(EdRefDeb.Text) then
    Query.SQL.Add(' and (P.Reference is null or upper(P.Reference) like('''+'%'+'''))')
    else
     Query.SQL.Add(' and upper(P.Reference) like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
  end
  else
   begin
   if empty(EdRefDeb.Text) then
     Query.SQL.Add(' and (P.Reference is null or upper(P.Reference) like('''+'%'+'''))')
    else
     Query.SQL.Add(' and upper(P.Reference) >='''+Tmp+'''');
   end;

Tmp:=EdRefFin.Text;
Tmp:=Str_UpperSQL(Tmp);
if not empty(EdRefFin.Text) then
 begin
   if empty(EdRefDeb.Text) then
     Query.SQL.Add(' and (P.Reference is null or upper(P.Reference) <='''+Tmp+''')')
    else
     Query.SQL.Add(' and upper(P.Reference) <='''+Tmp+'''');
 end;

// Section recherche sur Montant //////////////////////////////
Tmp:=CuMontantDeb.Text;
if ((not empty(CuMontantDeb.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantDeb.Text) <> '0.00')) then
  begin
    if ((empty(CuMontantFin.Text)) or (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) = '0.00')) then
       Query.SQL.Add(' and (E.Debit+E.Credit) ='''+str_QueDesChiffresCurr_SQL(Tmp)+'''')
      else
       Query.SQL.Add(' and (E.Debit+E.Credit) >='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');

    Tmp:=CuMontantFin.Text;
    if ((not empty(CuMontantFin.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) <> '0.00')) then
     begin
      Query.SQL.Add(' and (E.Debit+E.Credit) <='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');
     end;
  end;
//////////////////////////////////////////////////////////////

//Section Date de Saisie //////////////////////////////
//if empty(EdDateDeb.Text) then
//DateDebTmp := E.DatExoDebut
//else
//DateDebTmp :=StrToDateDef(EdDateDeb.Text,E.DatExoDebut);
DateDebTmp :=StrToDateDef(EdDateDeb.Text,E.DatExoDebut);

//if empty(EdDateFin.Text) then
//DateFinTmp := E.DatExoFin
//else
//DateFinTmp := DateToStr(EdDateFin.Text);
DateFinTmp := StrToDateDef(EdDateFin.Text,E.DatExoFin);
EdDateDeb.Text := DateInfos(DateDebTmp).DateStr;
EdDateFin.Text := DateInfos(DateFinTmp).DateStr;
if PeriodeEpure(DateInfos(0).Date_,DateDebTmp-1)then
     Application.MessageBox(Pchar('Attention !!! votre recherche porte sur une période épurée !!!'),'Attention',MB_ICONWARNING);
if (empty(EdRefDeb.Text)and empty(EdRefFin.Text))then
  Query.SQL.Add(' and E."Date" between '''+ DateInfos(0).DatePourSQLStr+''' and '''+ DateInfos(DateDebTmp-1).DatePourSQLStr+''' ');
//Query.SQL.Add(' and E."Date" <'''+ DateInfos(E.DatExoDebut).DatePourSQLStr+''' ');
//////////////////////////////////////////////////////////////

//Section Libellé //////////////////////////////
if not empty(EdLibelle.Text) then
   Query.SQL.Add(' and upper(E.Libelle) like(''%'+Str_UpperSQL(EdLibelle.Text)+'%'')');
//////////////////////////////////////////////////////////////
Query.SQL.Add(' order by E."date",P.reference,E.id_ligne ');
//showmessage(Query.SQL.Text);
Query.Open;
End;


Procedure TRechercheBD.QuRechercheEcritures(Query:TQuery);
var
Tmp:String;
DateDebTmp,DateFinTmp:TDate;
Begin
ProtectObjetNil([Query]);
Query.Close;
Query.DatabaseName := DM_C_NomAliasDossier;
Query.SQL.Clear;
Query.Params.Clear;

Query.SQL.Add(' select E.*,P.Reference from ecriture E ');
Query.SQL.Add(' join Piece P on (P.Id = E.Id_Piece) where ');

// Section recherche sur compte //////////////////////////////
// Compte comptable
if not TypeCptTiers(EdCptDeb.Text) then
 begin
    Tmp:=EdCptDeb.Text;
    Tmp:=Str_UpperSQL(Tmp);
    if empty(EdCptDeb.Text) then Tmp:= '%';
    if empty(EdCptFin.Text) then
       Query.SQL.Add(' upper(E.compte) like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
      else
       Query.SQL.Add(' upper(E.compte) >='''+Tmp+'''');
 end;
// Compte du plan auxiliaire
if TypeCptTiers(EdCptDeb.Text) then
 begin
    Tmp:=EdCptDeb.Text;
    Tmp:=Str_UpperSQL(Tmp);
    if empty(EdCptDeb.Text) then Tmp:= '%';
    if empty(EdCptFin.Text) then
       Query.SQL.Add(' upper(E.tiers) like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
      else
       Query.SQL.Add(' upper(E.tiers) >='''+Tmp+'''');
 end;
// Compte comptable
if not TypeCptTiers(EdCptDeb.Text) then
 begin
    Tmp:=EdCptFin.Text;
    Tmp:=Str_UpperSQL(Tmp);
    if not empty(EdCptFin.Text) then
     begin
    if empty(EdCptFin.Text) then
        Query.SQL.Add(' and upper(E.compte) <='''+Tmp+'''')
      else
       Query.SQL.Add(' and upper(E.compte) <='''+Tmp+'''');
     end;
 end;

// Compte tiers
if  TypeCptTiers(EdCptFin.Text) then
 begin
    Tmp:=EdCptFin.Text;
    Tmp:=Str_UpperSQL(Tmp);
    if not empty(EdCptFin.Text) then
     begin
    if empty(EdCptFin.Text) then
        Query.SQL.Add(' and upper(E.tiers) <='''+Tmp+'''')
      else
       Query.SQL.Add(' and upper(E.tiers) <='''+Tmp+'''');
     end;
 end;
//////////////////////////////////////////////////////////////

// Section recherche sur Référence //////////////////////////////
Tmp:=EdRefDeb.Text;
Tmp:=Str_UpperSQL(Tmp);
if(Length(Tmp)<9)then tmp:=tmp+'%';

//if empty(EdRefDeb.Text) then Tmp:= '%';
if empty(EdRefFin.Text) then
 begin
   if empty(EdRefDeb.Text) then
    Query.SQL.Add(' and (P.Reference is null or upper(P.Reference) like('''+'%'+'''))')
    else
     Query.SQL.Add(' and upper(P.Reference) like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
  end
  else
   begin
   if empty(EdRefDeb.Text) then
     Query.SQL.Add(' and (P.Reference is null or upper(P.Reference) like('''+'%'+'''))')
    else
     Query.SQL.Add(' and upper(P.Reference) >='''+Tmp+'''');
   end;

Tmp:=EdRefFin.Text;
Tmp:=Str_UpperSQL(Tmp);
if(Length(Tmp)<9)then tmp:=tmp+'%';
if not empty(EdRefFin.Text) then
 begin
   if empty(EdRefDeb.Text) then
     Query.SQL.Add(' and (P.Reference is null or upper(P.Reference) <='''+Tmp+''')')
    else
     Query.SQL.Add(' and upper(P.Reference) <='''+Tmp+'''');
 end;

// Section recherche sur Montant //////////////////////////////
Tmp:=CuMontantDeb.Text;
if ((not empty(CuMontantDeb.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantDeb.Text) <> '0.00')) then
  begin
    if ((empty(CuMontantFin.Text)) or (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) = '0.00')) then
       Query.SQL.Add(' and (E.Debit+E.Credit) ='''+str_QueDesChiffresCurr_SQL(Tmp)+'''')
      else
       Query.SQL.Add(' and (E.Debit+E.Credit) >='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');

    Tmp:=CuMontantFin.Text;
    if ((not empty(CuMontantFin.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) <> '0.00')) then
     begin
      Query.SQL.Add(' and (E.Debit+E.Credit) <='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');
     end;
  end;
//////////////////////////////////////////////////////////////

//Section Date de Saisie //////////////////////////////
//if empty(EdDateDeb.Text) then
//DateDebTmp := E.DatExoDebut
//else
//DateDebTmp :=StrToDateDef(EdDateDeb.Text,E.DatExoDebut);
DateDebTmp :=StrToDateDef(EdDateDeb.Text,E.DatExoDebut);

//if empty(EdDateFin.Text) then
//DateFinTmp := E.DatExoFin
//else
//DateFinTmp := DateToStr(EdDateFin.Text);
DateFinTmp := StrToDateDef(EdDateFin.Text,E.DatExoFin);
EdDateDeb.Text := DateInfos(DateDebTmp).DateStr;
EdDateFin.Text := DateInfos(DateFinTmp).DateStr;
if PeriodeEpure(DateDebTmp,DateFinTmp)then
     Application.MessageBox(Pchar('Attention !!! votre recherche porte sur une période épurée'),'Attention',MB_ICONWARNING);

if (empty(EdRefDeb.Text)and empty(EdRefFin.Text))then
  Query.SQL.Add(' and E."Date" between '''+ DateInfos(DateDebTmp).DatePourSQLStr+''' and '''+ DateInfos(DateFinTmp).DatePourSQLStr+''' ');
//Query.SQL.Add(' and E."Date" <'''+ DateInfos(E.DatExoDebut).DatePourSQLStr+''' ');
//////////////////////////////////////////////////////////////

//Section Libellé //////////////////////////////
if not empty(EdLibelle.Text) then
   Query.SQL.Add(' and upper(E.Libelle) like(''%'+Str_UpperSQL(EdLibelle.Text)+'%'')');
//////////////////////////////////////////////////////////////
Query.SQL.Add(' order by E."date",P.reference,E.id_ligne ');
//showmessage(Query.SQL.Text);
Query.Open;
End;


Procedure TRechercheBD.QuRechercheBalanceOuv(Query:TQuery);
var
Tmp:String;
Begin
ProtectObjetNil([Query]);
Query.Close;
Query.DatabaseName := DM_C_NomAliasExercice;
Query.SQL.Clear;
Query.Params.Clear;
//Query.SQL.Add(' select * from Balance where');
Query.SQL.Add(' select B.*,P.Libelle from balance B ');

Query.SQL.Add(' join "'+E.RepertoireDossier+'PlanCpt" P on (P.Compte = B.Compte ) where ');
// Section recherche sur compte //////////////////////////////
Tmp:=EdCptDeb.Text;
Tmp:=Str_UpperSQL(Tmp);
if empty(EdCptDeb.Text) then Tmp:= '%';
if empty(EdCptFin.Text) then
   Query.SQL.Add(' upper(B.compte) like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
  else
   Query.SQL.Add(' upper(B.compte) >='''+Tmp+'''');

Tmp:=EdCptFin.Text;
Tmp:=Str_UpperSQL(Tmp);
if not empty(EdCptFin.Text) then
 begin
  if empty(EdCptFin.Text) then
      Query.SQL.Add(' and upper(B.compte) <='''+Tmp+'''')
    else
     Query.SQL.Add(' and upper(B.compte) <='''+Tmp+'''');
 end;
//////////////////////////////////////////////////////////////

//// Section recherche sur Référence //////////////////////////////
//Tmp:=EdRefDeb.Text;
////if empty(EdRefDeb.Text) then Tmp:= '%';
//if empty(EdRefFin.Text) then
// begin
//   if empty(EdRefDeb.Text) then
//    Query.SQL.Add(' and (P.Libelle is null or P.Libelle like('''+'%'+'''))')
//    else
//     Query.SQL.Add(' and P.Libelle like('''+str_remplacesouschaine(Tmp,'*','%')+''')')
//  end
//  else
//   begin
//   if empty(EdRefDeb.Text) then
//     Query.SQL.Add(' and (P.Libelle is null or P.Libelle like('''+'%'+'''))')
//    else
//     Query.SQL.Add(' and P.Libelle >='''+Tmp+'''');
//   end;
//
//Tmp:=EdRefFin.Text;
//if not empty(EdRefFin.Text) then
// begin
//   if empty(EdRefDeb.Text) then
//     Query.SQL.Add(' and (P.Libelle is null or P.Libelle <='''+Tmp+''')')
//    else
//     Query.SQL.Add(' and P.Libelle <='''+Tmp+'''');
// end;

// Section recherche sur Montant //////////////////////////////
Tmp:=CuMontantDeb.Text;
if ((not empty(CuMontantDeb.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantDeb.Text) <> '0.00')) then
  begin
    if ((empty(CuMontantFin.Text)) or (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) = '0.00')) then
       Query.SQL.Add(' and (B.Debit_Report + B.Credit_Report) ='''+str_QueDesChiffresCurr_SQL(Tmp)+'''')
      else
       Query.SQL.Add(' and (B.Debit_Report + B.Credit_Report) >='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');

    Tmp:=CuMontantFin.Text;
    if ((not empty(CuMontantFin.Text)) and (str_QueDesChiffresCurr_SQL(CuMontantFin.Text) <> '0.00')) then
     begin
      Query.SQL.Add(' and (B.Debit_Report + B.Credit_Report) <='''+str_QueDesChiffresCurr_SQL(Tmp)+'''');
     end;
  end;
//////////////////////////////////////////////////////////////

//Section Date de Saisie //////////////////////////////
//Query.SQL.Add(' and DateSaisie <'''+ DateInfos(E.DatExoDebut).DatePourSQLStr+''' ');
//////////////////////////////////////////////////////////////

//Section Libellé //////////////////////////////
if not empty(EdLibelle.Text) then
   Query.SQL.Add(' and upper(P.Libelle) like(''%'+Str_UpperSQL(EdLibelle.Text)+'%'')');
//////////////////////////////////////////////////////////////

//showmessage(Query.SQL.Text);
Query.Open;
End;

procedure TRechercheBD.EdDateDebExit(Sender: TObject);
begin
if empty(EdDateDeb.text) then
 EdDateDeb.text:=DAteInfos(E.DatExoDebut).DateStr;
EdDateDeb.text:=AnneeDefaut(0,0,EdDateDeb.text).DateStr;
end;

procedure TRechercheBD.EdDateDebKeyPress(Sender: TObject; var Key: Char);
var
Texte:String;
SelStart:Integer;
begin
Texte:=EdDateDeb.Text;
SelStart:=EdDateDeb.SelStart;
KeyPressDate(key,Texte,SelStart,EdDateDeb.SelLength);
EdDateDeb.Text:=Texte;
EdDateDeb.SelStart:=SelStart;
if key = #13 then key:=#0;
end;

procedure TRechercheBD.EdDateFinExit(Sender: TObject);
begin
if empty(EdDateFin.text) then
 EdDateFin.text:=DAteInfos(E.DatExoFin).DateStr;
EdDateFin.text:=AnneeDefaut(0,0,EdDateFin.text).DateStr;
end;

procedure TRechercheBD.EdDateFinKeyPress(Sender: TObject; var Key: Char);
var
Texte:String;
SelStart:Integer;
begin
Texte:=EdDateFin.Text;
SelStart:=EdDateFin.SelStart;
KeyPressDate(key,Texte,SelStart,EdDateFin.SelLength);
EdDateFin.Text:=Texte;
EdDateFin.SelStart:=SelStart;
if key = #13 then key:=#0;
end;

procedure TRechercheBD.PaGaucheDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
accept:=(Source is TPanel);
end;

procedure TRechercheBD.PaGaucheDragDrop(Sender, Source: TObject; X,
  Y: Integer);
//var
//IndexMenu:Integer;
begin
 if (Source is TPanel) then
  begin
//  if (Sender as TPanel).Top > 0 then
  (Source as TPanel).Top := (Sender as TPanel).Top + Y;
//  IndexMenu:=(Source as TPanel).TabOrder;
  (Source as TPanel).TabOrder := ((Sender as TPanel).Top div 24)+1;
//  Critres1.Items[IndexMenu].MenuIndex := (Source as TPanel).TabOrder;

//  else
//   begin
//    if
//    (Source as TPanel).Top := 0;
//   end;
//  Panel1.Caption := (Source as TPanel).Name+' '+ Inttostr(((Sender as TPanel).Top div 24)+1);
  end;
end;

procedure TRechercheBD.Panel1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
accept:=(Sender is TPanel);
end;

procedure TRechercheBD.Compte1Click(Sender: TObject);
begin
pa1.Visible := (sender as TMenuItem).Checked;
EnvoiNextControlKeyDownForm(self);
if not pa1.Visible then VideZoneSaisieTxt([EdCptDeb,EdCptFin]);
end;

procedure TRechercheBD.Date1Click(Sender: TObject);
begin
pa2.Visible := (sender as TMenuItem).Checked;
EnvoiNextControlKeyDownForm(self);
if not pa2.Visible then VideZoneSaisieTxt([EdDateDeb,EdDateFin]);
end;

procedure TRechercheBD.Rfrences1Click(Sender: TObject);
begin
pa3.Visible := (sender as TMenuItem).Checked;
EnvoiNextControlKeyDownForm(self);
if not pa3.Visible then VideZoneSaisieTxt([EdRefDeb,EdRefFin]);
end;

procedure TRechercheBD.Montant1Click(Sender: TObject);
begin
pa4.Visible := (sender as TMenuItem).Checked;
EnvoiNextControlKeyDownForm(self);
if not pa4.Visible then
 begin
  CuMontantDeb.Value := 0;
  CuMontantFin.Value := 0;
  end;
end;

procedure TRechercheBD.Libell1Click(Sender: TObject);
begin
pa5.Visible := (sender as TMenuItem).Checked;
EnvoiNextControlKeyDownForm(self);
if not pa5.Visible then VideZoneSaisieTxt([EdLibelle]);
end;

Procedure TRechercheBD.EnvoiNextControlKeyDownForm(Form:TForm);
var
i,j:integer;
begin
for i:=1 to 5 do
 begin
  if (FindComponent('Pa'+Inttostr(i)) as TPanel).Visible  = true then
    begin
      for j:=0 to ((FindComponent('Pa'+Inttostr(i)) as TPanel).ControlCount - 1) do
       if ((FindComponent('Pa'+Inttostr(i)) as TPanel).Controls[j] is TWinControl) then
        begin
         ((FindComponent('Pa'+Inttostr(i)) as TPanel).Controls[j] as TWinControl).SetFocus;
         exit;
        end;
    end;
 end;
ChLBTableRech.SetFocus;
End;


procedure TRechercheBD.ParDfaut1Click(Sender: TObject);
var
i:integer;
begin
for i:=1 to 5 do
 begin
  (FindComponent('Pa'+Inttostr(i)) as TPanel).Visible := true;
  (FindComponent('Pa'+Inttostr(i)) as TPanel).top := (i-1)*24;
  (FindComponent('Pa'+Inttostr(i)) as TPanel).TabOrder := i-1;
  Critres1.Items[i-1].Checked := true;
   if i=1 then
    begin
     EdCptDeb.SetFocus;
    end;
   end;
  Compte1.MenuIndex := 0;
  Date1.MenuIndex := 1;
  Rfrences1.MenuIndex := 2;
  Montant1.MenuIndex := 3;
  Libell1.MenuIndex := 4;
end;

procedure TRechercheBD.Critres1Click(Sender: TObject);
var
i,j:integer;
begin
Compte1.MenuIndex := Pa1.TabOrder;
Date1.MenuIndex := Pa2.TabOrder;
Rfrences1.MenuIndex := Pa3.TabOrder;
Montant1.MenuIndex := Pa4.TabOrder;
Libell1.MenuIndex := Pa5.TabOrder;

end;

Procedure TRechercheBD.SauveRechCouranteDsViewList;
Begin
LVRecherche.AddItem(DateInfos(Date).DateStrFormat+' '+HeureInfos(Time,':').HeureStrFormate,nil);
LVRecherche.Items[LVRecherche.Items.Count-1].SubItems.Add(EdCptDeb.Text);
LVRecherche.Items[LVRecherche.Items.Count-1].SubItems.Add(EdCptFin.Text);

LVRecherche.Items[LVRecherche.Items.Count-1].SubItems.Add(EdDateDeb.Text);
LVRecherche.Items[LVRecherche.Items.Count-1].SubItems.Add(EdDateFin.Text);

LVRecherche.Items[LVRecherche.Items.Count-1].SubItems.Add(EdRefDeb.Text);
LVRecherche.Items[LVRecherche.Items.Count-1].SubItems.Add(EdRefFin.Text);

LVRecherche.Items[LVRecherche.Items.Count-1].SubItems.Add(CuMontantDeb.Text);
LVRecherche.Items[LVRecherche.Items.Count-1].SubItems.Add(CuMontantFin.Text);

LVRecherche.Items[LVRecherche.Items.Count-1].SubItems.Add(EdLibelle.Text);
End;

Procedure TRechercheBD.InitZoneRechAvecTVRecherche;
Begin
if LVRecherche.Selected <> nil then
 begin
  EdCptDeb.Text:=LVRecherche.Items[LVRecherche.ItemIndex].SubItems.Strings[0];
  EdCptFin.Text:=LVRecherche.Items[LVRecherche.ItemIndex].SubItems.Strings[1];
  EdDateDeb.Text := LVRecherche.Items[LVRecherche.ItemIndex].SubItems.Strings[2];
  EdDateFin.Text := LVRecherche.Items[LVRecherche.ItemIndex].SubItems.Strings[3];
  EdRefDeb.Text:=LVRecherche.Items[LVRecherche.ItemIndex].SubItems.Strings[4];
  EdRefFin.Text:=LVRecherche.Items[LVRecherche.ItemIndex].SubItems.Strings[5];
  CuMontantDeb.Text := LVRecherche.Items[LVRecherche.ItemIndex].SubItems.Strings[6];
  CuMontantFin.Text := LVRecherche.Items[LVRecherche.ItemIndex].SubItems.Strings[7];
  EdLibelle.Text:=LVRecherche.Items[LVRecherche.ItemIndex].SubItems.Strings[8];
 end;
End;


procedure TRechercheBD.LVRechercheDblClick(Sender: TObject);
begin
InitZoneRechAvecTVRecherche;
end;

procedure TRechercheBD.LVRechercheKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = vk_delete then
if LVRecherche.Selected <> nil then
 begin
  LVRecherche.DeleteSelected;
 end;
end;

procedure TRechercheBD.Aide1Click(Sender: TObject);
var
MessDerSub,LaisserPasser:Boolean;
Tmp:String;
begin
MessDerSub := False;
LaisserPasser:=True;
if AideCompte = nil then AideCompte:=TAideCompte.Create(Application.MainForm);

if ActiveControl = EdCptDeb then
 begin
  AideCompte.FiltrageAideCompte(25);
  AideCompte.InitialiseCompte;
  Tmp:=EdCptDeb.Text;
  if empty(Tmp) then Tmp:='1';
  if str_commence_par(Tmp,'+')then
    AideCompteDansContexte(Tmp,EdCptDeb,['Rac1'],true,MessDerSub,false,true,true,false,1)
  else
    AideCompteDansContexte(Tmp,EdCptDeb,['Rac1'],true,MessDerSub,false,true,true,false,0);
//  AideCompteAffiche(EdCptDeb,true,true,false,false,0);
 end;

if ActiveControl = EdCptFin then
 begin
  AideCompte.FiltrageAideCompte(25);
  AideCompte.InitialiseCompte;
  Tmp:=EdCptFin.Text;
  if empty(Tmp) then Tmp:='79';
  if str_commence_par(Tmp,'+')then
     AideCompteDansContexte(tmp,EdCptFin,['Rac1'],true,MessDerSub,false,true,true,false,1)
  else
     AideCompteDansContexte(tmp,EdCptFin,['Rac1'],true,MessDerSub,false,true,true,false,0);

 end;
end;

procedure TRechercheBD.Visualisation1Click(Sender: TObject);
var
 PeriodeAutre_Tmp:TPeriode;
begin
try//finally
GestionDernierSelectionne;
e.PeriodeAutreImpression.Retour:=true;
E.PeriodeAutreImpression.DateDeb:=0;
E.PeriodeAutreImpression.DateFin:=e.DatExoFin;
PeriodeAutre_Tmp:=E.PeriodeAutre;
e.AutrePeriode:=true;
E.PeriodeAutre:=E.PeriodeAutreImpression;
    if DetailEcritureCompte(trim(str_getstringelement(LVResult.Items[LVResult.ItemIndex].SubItems.Strings[0],1,'-')),False,False) then
      begin //si on trouve des pièces dans la période pour ce compte
       case DetailEcr.Tag of
          1:begin
            if DMEcritures.QueryEcrCompte.Locate('ID_Piece',Infos_TInfosPiece(dmrech.TaPieceRech,'Reference',[LVResult.Items[LVResult.ItemIndex].SubItems.Strings[2]]).ID,[]) then
              PieceEcritureTiers(true);
            end;
          2:begin
            if DMEcritures.QueryEcrCompte.Locate('ID_Piece',Infos_TInfosPiece(dmrech.TaPieceRech,'Reference',[LVResult.Items[LVResult.ItemIndex].SubItems.Strings[2]]).ID,[]) then
              PieceEcritureCompte(true);
            end;
       end;
      end;//fin si on trouve des pièces dans la période pour ce compte
      GestionCaptionBtnChercher(false);
GestionDernierSelectionne(true);
finally
    E.PeriodeAutre:=PeriodeAutre_Tmp;
    E.AutrePeriode:=PeriodeAutre_Tmp.Retour;
end;
end;


procedure TRechercheBD.Modifierpice1Click(Sender: TObject);
begin
GestionDernierSelectionne;
   ModificationPieceExistante(LVResult.Selected.SubItems[2],'');
   GestionCaptionBtnChercher(false);
GestionDernierSelectionne(true);   
end;


procedure TRechercheBD.GestionCaptionBtnChercher(chercher:boolean);
begin
if chercher then
  BtnChercher.Caption:='Chercher [F3]'
else
  BtnChercher.Caption:='Raffraîchir [F3]';
end;
procedure TRechercheBD.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
Initialiser_ShortCut_Main(false);
end;

procedure TRechercheBD.LVResultResize(Sender: TObject);
begin
   WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
   Panel1.Width:=RenvoiTailleColonneListView(LVResult,[1,2,3,4,5])+1;
   GrGrid1.ColWidths[0]:=RenvoiTailleColonneListView(LVResult,[6]);
   GrGrid1.ColWidths[1]:=RenvoiTailleColonneListView(LVResult,[7]);
   GrGrid1.ColWidths[2]:=RenvoiTailleColonneListView(LVResult,[8]);

   Panel3.Width:=RenvoiTailleColonneListView(LVResult,[1,2,3,4,5])+1;
   GrGrid2.ColWidths[0]:=RenvoiTailleColonneListView(LVResult,[6]);
   GrGrid2.ColWidths[1]:=RenvoiTailleColonneListView(LVResult,[7]);
   GrGrid2.ColWidths[2]:=RenvoiTailleColonneListView(LVResult,[8]);
end;


procedure TRechercheBD.InitSousTotaux(Debit,Credit:currency;Libelle:string);
Const
Tirets2 ='--------------';
begin

if (ChLBTableRech.Items.Count > 1) and (ChLBTableRech.Checked[0])then
    begin
        LVResult.Items.Add.Caption:='';
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);

        LVResult.Items.Add.Caption:='';
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(' ');
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(' ');
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(' ');
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Libelle);
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add('Sous Total');
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(Debit));
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(e.FormatCurrSansDevise(Credit));
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(' ');


        LVResult.Items.Add.Caption:='';
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);
        LVResult.Items.Add.Caption:='';
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);
        LVResult.Items[LVResult.Items.Count-1].SubItems.Add(Tirets2);
    end;
end;
procedure TRechercheBD.FormShow(Sender: TObject);
begin
RechercheBD.EdCptDeb.SetFocus;
end;

procedure TRechercheBD.BtnSupprimerClick(Sender: TObject);
begin
  EdCptDeb.Text:='';
  EdCptFin.Text:='';
  EdDateDeb.Text := '';
  EdDateFin.Text := '';
  EdRefDeb.Text:='';
  EdRefFin.Text:='';
  CuMontantDeb.Text := '';
  CuMontantFin.Text := '';
  EdLibelle.Text:='';
  LVResult.Clear;
  GrGrid1.Cells[0,0]:='';
  GrGrid1.Cells[1,0]:='';
  GrGrid1.Cells[2,0]:='';
  GrGrid2.Cells[0,0]:='';
  GrGrid2.Cells[1,0]:='';
  GrGrid1.Cells[2,0]:='';
  EdCptDeb.SetFocus;
end;

procedure TRechercheBD.Pointage1Click(Sender: TObject);
var
ParamAffichPointage:TParamAffichPointage;
begin
GestionDernierSelectionne;
    Initialise_TParamAffichPointage(ParamAffichPointage);
    if not Empty(str_getstringelement(LVResult.Items[LVResult.ItemIndex].SubItems.Strings[1],1,'-'))then
      ParamAffichPointage.CptTiers:=str_getstringelement(LVResult.Items[LVResult.ItemIndex].SubItems.Strings[1],1,'-')
    else
      if dmplan.CptEstPointable(str_getstringelement(LVResult.Items[LVResult.ItemIndex].SubItems.Strings[0],1,'-'))then
        ParamAffichPointage.CptTiers:=str_getstringelement(LVResult.Items[LVResult.ItemIndex].SubItems.Strings[0],1,'-');
    if not empty(ParamAffichPointage.CptTiers) then
      begin                                         
         ParamAffichPointage.ALettrer:=true;
         ParamAffichPointage.DateDeb:=0;
         ParamAffichPointage.DateFin:=E.DatExoFin;
         ParamAffichPointage.ID_Ecriture_Appelant:=StrToInt_Lgr(str_getstringelement(LVResult.Items[LVResult.ItemIndex].Caption,1,'-'));
         ParamAffichPointage.ID_Reste_Appelant:=0;
         ParamAffichPointage.Reste_Appelant:=Infos_TInfosResteDC(DMRech.TaResteDCRech,'ID_Ecriture',[ParamAffichPointage.ID_Ecriture_Appelant]).Reste;

         //if not VeriffNumeric(GrDBVisuEcriture.DataSource.DataSet.FindField('debitSaisie')).VideOUZero then
         if not str_Empty_Numeric_Format(str_getstringelement(LVResult.Items[LVResult.ItemIndex].SubItems.Strings[5],1,'-'),e.FormatMonnaie)then
           begin
             ParamAffichPointage.SensAppelant:='D';
             ParamAffichPointage.Montant_Appelant:=StrToCurr_Lgr(str_getstringelement(LVResult.Items[LVResult.ItemIndex].SubItems.Strings[5],1,'-'));
           end
         else
           begin
             ParamAffichPointage.SensAppelant:='C';
             ParamAffichPointage.Montant_Appelant:=StrToCurr_Lgr(str_getstringelement(LVResult.Items[LVResult.ItemIndex].SubItems.Strings[6],1,'-'));
           end;
         ParamAffichPointage.Reference:=(str_getstringelement(LVResult.Items[LVResult.ItemIndex].SubItems.Strings[2],1,'-'));
         GestionAffichagePointageSurRef(true,true,ParamAffichPointage,not e.ExerciceCloture);
      end;
      GestionCaptionBtnChercher(false);
GestionDernierSelectionne(true);      
end;

procedure TRechercheBD.Dtailspointages1Click(Sender: TObject);
var
ParamAffichPointage:TParamAffichPointage;
begin
GestionDernierSelectionne;
       Initialise_TParamAffichPointage(ParamAffichPointage);
        if not empty(str_getstringelement(LVResult.Items[LVResult.ItemIndex].SubItems.Strings[1],1,'-'))then
          ParamAffichPointage.CptTiers:=str_getstringelement(LVResult.Items[LVResult.ItemIndex].SubItems.Strings[1],1,'-')
        else
          ParamAffichPointage.CptTiers:=str_getstringelement(LVResult.Items[LVResult.ItemIndex].SubItems.Strings[0],1,'-');
        ParamAffichPointage.ID_Ecriture_Appelant:=StrToInt_Lgr(str_getstringelement(LVResult.Items[LVResult.ItemIndex].Caption,1,'-'));
        DetailPointageAffich(ParamAffichPointage.CptTiers,inttostr(ParamAffichPointage.ID_Ecriture_Appelant),0,true,true);
        GestionCaptionBtnChercher(false);
GestionDernierSelectionne(true);
end;


procedure TRechercheBD.GestionDernierSelectionne(Repositionnement:boolean);
begin
if Repositionnement then
 begin
   LVResult.ItemIndex:=dernier;
 end
else
    Dernier:=LVResult.ItemIndex;
end;

procedure TRechercheBD.EdCptDebChange(Sender: TObject);
begin
if (Sender is Tedit) then
  (Sender as Tedit).Text:=str_majuscule((Sender as Tedit).Text);
end;

procedure TRechercheBD.Calculatrice1Click(Sender: TObject);
begin
if (ActiveControl = CuMontantDeb)or (ActiveControl = CuMontantFin) then
  AfficheCalculatrice(ActiveControl)
else
  AfficheCalculatrice(nil);
end;

procedure TRechercheBD.Imprimerlaslection1Click(Sender: TObject);
begin
BtnImprimerSelectionClick(BtnImprimer);
end;

end.
