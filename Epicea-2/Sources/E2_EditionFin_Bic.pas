unit E2_EditionFin_Bic;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, GrGrid, ExtCtrls, ComCtrls,
  Db, DBTables,LibSQL,E2_Librairie_Obj,E2_Decl_records,Gr_Librairie_Obj,
  LibDates,
  LibFichRep,TStringlistLGR,
  LibZoneSaisie,DMConstantes,ShellApi, DBGrids, LibGestionParamXML, Menus,
  Buttons, DBCtrls,ObjetEdition, RXCtrls, dbcgrids, Mask,DMRepartition;

Const

EditionPartBilanActif = 1;
EditionPartBilanPassif = 2;
EditionPartCptResult1 = 3;
EditionPartCptResult2 = 4;
//Bic
EditionPartBilanActif_Bic = 5;
EditionPartBilanPassif_Bic = 6;
EditionPartCptResult1_Bic = 7;
EditionPartCptResult2_Bic = 8;

TitreBouttonImprimerDetail = 'Imprimer [F8] - ';

type
  TEditionFin_Bic = class(TForm)
    PCLiasseFiscale: TPageControl;
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
    ImprimerDetail1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    N2: TMenuItem;
    Prcdent1: TMenuItem;
    Suivant1: TMenuItem;
    PaModifZone: TPanel;
    Panel2: TPanel;
    PaGrilleCpt: TPanel;
    PaDetailZone: TPanel;
    GrGrid1: TGrGrid;
    PaOutils: TPanel;
    SBAjouter: TSpeedButton;
    Panel3: TPanel;
    PaDetail: TPanel;
    SBEnlever: TSpeedButton;
    SBFermer: TSpeedButton;
    GrGrid2: TGrGrid;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    RxSBDetailPointage: TRxSpeedButton;
    CBEditionCentime: TCheckBox;
    TbShDoc2050: TTabSheet;
    GrGrid3: TGrGrid;
    Panel8: TPanel;
    Panel9: TPanel;
    TbShDoc2052: TTabSheet;
    Panel11: TPanel;
    GrCptResultat_Bic: TGrGrid;
    Panel12: TPanel;
    Panel13: TPanel;
    TbShDoc2053: TTabSheet;
    Panel14: TPanel;
    Panel15: TPanel;
    GrCptResultatBis_Bic: TGrGrid;
    GrBilanActif_Bic: TGrGrid;
    GrBilanPassif_Bic: TGrGrid;
    TbShDoc2051: TTabSheet;
    PaBtn: TPanel;
    BtnCalculer: TButton;
    BtnModifier: TButton;
    BtnImprimerDetail: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    BtnDetail: TButton;
    BtnEditionRepartition: TButton;
    procedure BtnCalculerClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure BtnDetailClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure SBFermerClick(Sender: TObject);
    procedure SBEnleverClick(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Imprimer1Click(Sender: TObject);
    procedure PCLiasseFiscaleChange(Sender: TObject);
    procedure ImprimerDetail1Click(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
    procedure BtnEditionRepartitionClick(Sender: TObject);
    function DetailGeneral():Tstringlist;
    procedure PaBtnResize(Sender: TObject);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  EditionFin_Bic: TEditionFin_Bic;
    function retrouveLigne(ListeValeur:Tstringlist;repere:string;separateur:char):integer;
//    function retrouveLibelle(ListeValeur:Tstringlist;repere:string;separateur:char):integer;
 procedure rempliColonneMontant(var Col1,Col2,Col3,Col4 : currency ; Colonne:integer ; ligne:string
   ;montantAAffecter:currency;separateur:char;arrondi_in:integer=2;initialise:boolean=true);
  function rechercheSiMontantRempli(Repartition:TRepartition):boolean;
  procedure rempliEditionListe(listeComptesIn:Tstringlist;Var ListeValeur : Tstringlist);
  function rempliListeAvantEdition(listeComptesIn:Tstringlist) : Tstringlist;
  function copyFichierAvantUtilisation( nomFichierOrigine, repertoireOrigine :String):string;

  function CustomSortCompteProcAsc(List: TStringlist; Index1, Index2: Integer): Integer;

implementation






uses DMRecherche, DMLiasseFiscale, DMPlanCpt, DMDiocEtatBalance,
  UBilanActif, UBilanPassif,
  //E2_VisuEditFisc,
   E2_LibInfosTable, DMProgramme, lib_chaine;




{$R *.DFM}


function CustomSortCompteProcAsc(List: TStringlist; Index1, Index2: Integer): Integer;
var
cpt1,cpt2:string;
Item1,Item2:string;
separateur:char;
begin
result := 0;
if(index1>index2)then result:=1 else if(index1<index2)then result:=-1;
separateur:=char('¤');
item1:=List.Strings[index1];
item2:=List.Strings[index2];
if(GetStringElement(Item1,2,separateur)=GetStringElement(Item2,2,separateur))
and (GetStringElement(Item1,4,separateur)=GetStringElement(Item2,4,separateur))
and (GetStringElement(Item1,5,separateur)=GetStringElement(Item2,5,separateur)) then
  begin
      cpt1:=GetStringElement(Item1,3,separateur);
      cpt2:=GetStringElement(Item2,3,separateur);
      if(cpt1<cpt2)then result:=-1;
      if(cpt1>cpt2)then result:=1;
  end;
end;


procedure TEditionFin_Bic.BtnCalculerClick(Sender: TObject);
var
i,j:integer;
Debit,Credit:Currency;
begin
 try
    Screen.Cursor := crSQLWait;
    if DMRepart = nil then DMRepart:=TDMRepart.Create(Application.MainForm);
    //DMDiocEtatBal.TaBalanceaffich.Refresh;
//    DMDiocEtatBal.SommeTotauxBalanceCalc(E.DatExoDebut,E.DatExoFin,nil,'Compte');
    liste_cellule(DMDiocEtatBal.TaBalanceCalc,DMRepart.Repartition_Bic,E.Regime);
    SommeCellule_Bic(nil);

    // Remplissage de la grille

////////*************** Si BIC **************//////////////////////////

     //if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2050' then
     //begin
       DMLiasseFisc.InitTableSurNumLiasse_Bic('2150');
    //   GrDBGridTmp:=GrBilanActif;
       GrBilanActif_Bic.RowCount := DMLiasseFisc.QuParamLia.RecordCount+1;// 38;
       i:=1;
       DMLiasseFisc.QuParamLia.First;

       while not DMLiasseFisc.QuParamLia.EOF do
         begin
    //     if i = 27 then showmessage('top');
           GrBilanActif_Bic.Cells[0,i]:=DMLiasseFisc.QuParamLia.FindField('Libelle').AsString;
           GrBilanActif_Bic.Cells[2,i]:=DMLiasseFisc.QuParamLia.FindField('Col2').AsString;
           GrBilanActif_Bic.Cells[4,i]:=DMLiasseFisc.QuParamLia.FindField('Col4').AsString;

           // Colonne 1
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col1').AsString);
           if j <> -1 then
             begin
//               GrBilanActif_Bic.Cells[1,i]:=FormatCurr(E.EditFormat,TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrBilanActif_Bic.Cells[1,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrBilanActif_Bic.Objects[1,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;

           // Colonne 3
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col3').AsString);
           if j <> -1 then
             begin
//               GrBilanActif_Bic.Cells[3,i]:=FormatCurr(E.EditFormat,TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrBilanActif_Bic.Cells[3,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrBilanActif_Bic.Objects[3,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;

           // Colonne 5
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col5').AsString);
           if j <> -1 then
             begin
               GrBilanActif_Bic.Cells[5,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrBilanActif_Bic.Objects[5,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;

           // Colonne 6
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col6').AsString);
           if j <> -1 then
             begin
               GrBilanActif_Bic.Cells[6,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrBilanActif_Bic.Objects[6,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;

           // Colonne 7
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col7').AsString);
           if j <> -1 then
             begin
               GrBilanActif_Bic.Cells[7,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrBilanActif_Bic.Objects[7,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;

           DMLiasseFisc.QuParamLia.Next;
           inc(i);
         end;
       DefiltrageDataSet(DMRech.TaPlanCptRech);
       filtrageDataSet(DMRech.TaBalanceRech,'Compte < 6');
     //end;

    //if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2051' then
     //begin
       DMLiasseFisc.InitTableSurNumLiasse_Bic('2151');
       GrBilanPassif_Bic.RowCount := DMLiasseFisc.QuParamLia.RecordCount+1;//34;
       i:=1;

       DMLiasseFisc.QuParamLia.First;

       while not DMLiasseFisc.QuParamLia.EOF do
         begin

           GrBilanPassif_Bic.Cells[0,i]:=DMLiasseFisc.QuParamLia.FindField('Libelle').AsString;
           if i <> 1 then
             GrBilanPassif_Bic.Cells[1,i]:=DMLiasseFisc.QuParamLia.FindField('Col1').AsString;

           if i = 1 then
            begin
             j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col2').AsString);
             if j <> -1 then
               begin
                 GrBilanPassif_Bic.Cells[2,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
                 GrBilanPassif_Bic.Objects[2,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
               end;
            end;

           GrBilanPassif_Bic.Cells[3,i]:=DMLiasseFisc.QuParamLia.FindField('Col3').AsString;

           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col4').AsString);
           if j <> -1 then
             begin
               GrBilanPassif_Bic.Cells[4,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrBilanPassif_Bic.Objects[4,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;

           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col5').AsString);
           if j <> -1 then
             begin
               GrBilanPassif_Bic.Cells[5,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrBilanPassif_Bic.Objects[5,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;
    //       for j:=4 to 4 do
    //               GrBilanPassif.Cells[j,i]:='0'+DecimalSeparator+'00';
           DMLiasseFisc.QuParamLia.Next;
           inc(i);
         end;
       DefiltrageDataSet(DMRech.TaPlanCptRech);
       filtrageDataSet(DMRech.TaBalanceRech,'Compte < 6');
     //end;

    //if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2052' then
     //begin
       filtrageDataSet(DMRech.TaBalanceRech,'Compte >= 6');
       DMLiasseFisc.InitTableSurNumLiasse_Bic('2152');
       GrCptResultat_Bic.RowCount := DMLiasseFisc.QuParamLia.RecordCount+1;//41;
       i:=1;
       DMLiasseFisc.QuParamLia.First;

       while not DMLiasseFisc.QuParamLia.EOF do
         begin
    //     if i = 27 then showmessage('top');
           GrCptResultat_Bic.Cells[0,i]:=DMLiasseFisc.QuParamLia.FindField('Libelle').AsString;
           GrCptResultat_Bic.Cells[1,i]:=DMLiasseFisc.QuParamLia.FindField('Col1').AsString;
           if i < 6 then
            begin
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col2').AsString);
           if j <> -1 then
             begin
               GrCptResultat_Bic.Cells[2,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrCptResultat_Bic.Objects[2,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col4').AsString);
           if j <> -1 then
             begin
               GrCptResultat_Bic.Cells[4,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrCptResultat_Bic.Objects[4,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;
            end;
           GrCptResultat_Bic.Cells[3,i]:=DMLiasseFisc.QuParamLia.FindField('Col3').AsString;
           GrCptResultat_Bic.Cells[5,i]:=DMLiasseFisc.QuParamLia.FindField('Col5').AsString;

           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col6').AsString);
           if j <> -1 then
             begin
               GrCptResultat_Bic.Cells[6,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrCptResultat_Bic.Objects[6,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;

           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col7').AsString);
           if j <> -1 then
             begin
               GrCptResultat_Bic.Cells[7,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrCptResultat_Bic.Objects[7,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;
           DMLiasseFisc.QuParamLia.Next;
           inc(i);
         end;
     //end;

    //if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2053' then
     //begin
       filtrageDataSet(DMRech.TaBalanceRech,'Compte >= 6');
       DMLiasseFisc.InitTableSurNumLiasse_Bic('2153');
    //   GrDBGridTmp:=GrCptResultat;
       GrCptResultatBis_Bic.RowCount := DMLiasseFisc.QuParamLia.RecordCount+1;//41;
       i:=1;
       DMLiasseFisc.QuParamLia.First;

       while not DMLiasseFisc.QuParamLia.EOF do
         begin
    //     if i = 27 then showmessage('top');
           GrCptResultatBis_Bic.Cells[0,i]:=DMLiasseFisc.QuParamLia.FindField('Libelle').AsString;
           GrCptResultatBis_Bic.Cells[1,i]:=DMLiasseFisc.QuParamLia.FindField('Col1').AsString;
           GrCptResultatBis_Bic.Cells[4,i]:=DMLiasseFisc.QuParamLia.FindField('Col4').AsString;
           GrCptResultatBis_Bic.Cells[6,i]:=DMLiasseFisc.QuParamLia.FindField('Col6').AsString;

           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col2').AsString);
           if j <> -1 then
             begin
               GrCptResultatBis_Bic.Cells[2,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrCptResultatBis_Bic.Objects[2,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col3').AsString);
           if j <> -1 then
             begin
               GrCptResultatBis_Bic.Cells[3,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrCptResultatBis_Bic.Objects[3,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;

           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col5').AsString);
           if j <> -1 then
             begin
               GrCptResultatBis_Bic.Cells[5,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrCptResultatBis_Bic.Objects[5,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;

           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col7').AsString);
           if j <> -1 then
             begin
               GrCptResultatBis_Bic.Cells[7,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrCptResultatBis_Bic.Objects[7,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;

           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col8').AsString);
           if j <> -1 then
             begin
               GrCptResultatBis_Bic.Cells[8,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrCptResultatBis_Bic.Objects[8,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;
           DMLiasseFisc.QuParamLia.Next;
           inc(i);
         end;//fin du while
       //end;
    DefiltrageDataSet(DMRech.TaBalanceRech);
 Finally
  Screen.Cursor := crDefault;
//  for i:=0 to DMRepart.ListeCell.Count-1 do
//   begin
//     TRepartition(DMRepart.ListeCell.Objects[i]).compte.SaveToFile(E.REpertoireFiscal+DMRepart.ListeCell.Strings[i]+'.txt');
//     For j:=0 to TRepartition(DMRepart.ListeCell.Objects[i]).compte.Count - 1 do
//      begin
//       AjouterFichierTexte(E.REpertoireFiscal+DMRepart.ListeCell.Strings[i]+'.txt',CurrToStr(TMontant(TRepartition(DMRepart.ListeCell.Objects[i]).compte.Objects[j]).MontantCpt));
//      end;
//   end;
//  DMRepart.ListeCell.SaveToFile(E.REpertoireFiscal+'ListeCell.txt');

 end;
end;

procedure TEditionFin_Bic.FormActivate(Sender: TObject);
var
k:Integer;
begin
if DMRepart=nil then DMRepart:=TDMRepart.Create(application.MainForm);
for k:=0 to GrBilanActif_Bic.rowcount-1 do
  GrBilanActif_Bic.rows[k].clear;
GrBilanActif_Bic.Cells[1,0] := '';
GrBilanActif_Bic.Cells[2,0] := 'Brut';
GrBilanActif_Bic.Cells[4,0] := 'Amort. Prov.';
GrBilanActif_Bic.Cells[6,0] := 'Net N';
GrBilanActif_Bic.Cells[7,0] := 'Net N-1';
GrBilanActif_Bic.ParamColor:=true;
GrBilanActif_Bic.Param:=ParamUtil.CouleurDBGrid;
GrBilanActif_Bic.DessineContourLigne:=false;
GrBilanActif_Bic.UpDateColor;
GrBilanActif_Bic.JustifieChampCurr :=true;

// GrBilanPassif_Bic : Bilan Passif Bic 2051
for k:=0 to GrBilanPassif_Bic.rowcount-1 do
  GrBilanPassif_Bic.rows[k].clear;
GrBilanPassif_Bic.Cells[1,0] := '';
GrBilanPassif_Bic.Cells[4,0] := 'Exercice N';
GrBilanPassif_Bic.Cells[5,0] := 'Exercice N-1';
GrBilanPassif_Bic.ParamColor:=true;
GrBilanPassif_Bic.Param:=ParamUtil.CouleurDBGrid;
GrBilanPassif_Bic.DessineContourLigne:=false;
GrBilanPassif_Bic.UpDateColor;

// GrCptResultat_Bic : Compte Résultat Bic 2052
for k:=0 to GrCptResultat_Bic.rowcount-1 do
  GrCptResultat_Bic.rows[k].clear;
GrCptResultat_Bic.Cells[1,0] := '';
GrCptResultat_Bic.Cells[2,0] := 'France ';
GrCptResultat_Bic.Cells[4,0] := 'Export. ';
GrCptResultat_Bic.Cells[6,0] := 'TOTAL ';
GrCptResultat_Bic.Cells[7,0] := 'N-1 ';
GrCptResultat_Bic.ParamColor:=true;
GrCptResultat_Bic.Param:=ParamUtil.CouleurDBGrid;
GrCptResultat_Bic.DessineContourLigne:=false;
GrCptResultat_Bic.UpDateColor;
//
// GrCptResultatBis_Bic : Compte Résultat Bis Bic 2053
for k:=0 to GrCptResultatBis_Bic.rowcount-1 do
  GrCptResultatBis_Bic.rows[k].clear;
GrCptResultatBis_Bic.Cells[1,0] := '';
GrCptResultatBis_Bic.Cells[7,0] := 'Exercice N';
GrCptResultatBis_Bic.Cells[8,0] := 'Exercice N-1';
GrCptResultatBis_Bic.ParamColor:=true;
GrCptResultatBis_Bic.Param:=ParamUtil.CouleurDBGrid;
GrCptResultatBis_Bic.DessineContourLigne:=false;
GrCptResultatBis_Bic.UpDateColor;
//
EditionFin_Bic.PCLiasseFiscaleChange(nil);
PaBtnResize(PaBtn)
end;

procedure TEditionFin_Bic.FormDestroy(Sender: TObject);
begin
if DMLiasseFisc <> nil then DMLiasseFisc.Free;
LibGestionParamXML.DestroyForm(Self,E.User);
EditionFin_Bic:=nil;
end;

procedure TEditionFin_Bic.BtnImprimerClick(Sender: TObject);
var
ExoNMoins1:TInfosGestDossier;
ListePdf2:TStringList;
i:integer;
Debit,Credit:Currency;
dateEdition,nomProvisoire,extensionProvisoire:String;
begin
ListePdf2:=TStringList.Create;
ListePdf2.Add('%FDF-1.2');
ListePdf2.Add('%âãÏÓ');
ListePdf2.Add('1 0 obj');
ListePdf2.Add('<<');
ListePdf2.Add('/FDF << /Fields [');

 ExoNMoins1:=ChercheInfos_ExoMoinsN1(e.NomDossier);

ListePdf2.Add(' << /V ('+DateInfos(E.DatExoDebut).DateStr+') /T (A1_2_1)>>');
ListePdf2.Add(' << /V ('+DateInfos(E.DatExoFin).DateStr+') /T (A1_2_2)>>'); //
ListePdf2.Add(' << /V ('+' - DOSSIER : '+E.NomDossier+' - EXERCICE : '+E.NomExo+' - '+E.RaisonSociale+') /T (RN_ZRL_1)>>');
ListePdf2.Add(' << /V ('+' Raison sociale : '+E.RaisonSociale+') /T (RN_ZRL_2)>>');
i := NbMois(E.DatExoDebut,E.DatExoFin);
if  i > 9 then
 begin
  ListePdf2.Add(' << /V ('+Copy(IntToStr(i),1,1)+') /T (RN_A1_1_11)>>'); //
  ListePdf2.Add(' << /V ('+Copy(IntToStr(i),2,1)+') /T (RN_A1_1_10)>>'); //
 end
else
 begin
  ListePdf2.Add(' << /V (0) /T (RN_A1_1_11)>>'); //
  ListePdf2.Add(' << /V ('+IntToStr(i)+') /T (RN_A1_1_10)>>'); //
 end;

i := NbMois(ExoNMoins1.DATE_DEB_EXO,ExoNMoins1.DATE_FIN_EXO);
if  i > 9 then
 begin
  ListePdf2.Add(' << /V ('+Copy(IntToStr(i),1,1)+') /T (RN_A1_2_11)>>'); //
  ListePdf2.Add(' << /V ('+Copy(IntToStr(i),2,1)+') /T (RN_A1_2_10)>>'); //
 end
else
 begin
  ListePdf2.Add(' << /V (0) /T (RN_A1_2_11)>>'); //
  ListePdf2.Add(' << /V ('+IntToStr(i)+') /T (RN_A1_2_10)>>'); //
 end;

ListePdf2.Add(' << /V ('+str_souschaine(DateToStr_Lgr(e.DatExoFin),1,1)+') /T (RN_ZRL_52_8)>>');
ListePdf2.Add(' << /V ('+str_souschaine(DateToStr_Lgr(e.DatExoFin),2,1)+') /T (RN_ZRL_52_7)>>');
ListePdf2.Add(' << /V ('+str_souschaine(DateToStr_Lgr(e.DatExoFin),4,1)+') /T (RN_ZRL_52_6)>>');
ListePdf2.Add(' << /V ('+str_souschaine(DateToStr_Lgr(e.DatExoFin),5,1)+') /T (RN_ZRL_52_5)>>');
ListePdf2.Add(' << /V ('+str_souschaine(DateToStr_Lgr(e.DatExoFin),7,1)+') /T (RN_ZRL_52_4)>>');
ListePdf2.Add(' << /V ('+str_souschaine(DateToStr_Lgr(e.DatExoFin),8,1)+') /T (RN_ZRL_52_3)>>');
ListePdf2.Add(' << /V ('+str_souschaine(DateToStr_Lgr(e.DatExoFin),9,1)+') /T (RN_ZRL_52_2)>>');
ListePdf2.Add(' << /V ('+str_souschaine(DateToStr_Lgr(e.DatExoFin),10,1)+') /T (RN_ZRL_52_1)>>');

ListePdf2.Add(' << /V ('+str_souschaine(DateToStr_Lgr(ExoNMoins1.DATE_FIN_EXO),1,1)+') /T (RN_A1_2_2_6)>>');
ListePdf2.Add(' << /V ('+str_souschaine(DateToStr_Lgr(ExoNMoins1.DATE_FIN_EXO),2,1)+') /T (RN_A1_2_2_5)>>');
ListePdf2.Add(' << /V ('+str_souschaine(DateToStr_Lgr(ExoNMoins1.DATE_FIN_EXO),4,1)+') /T (RN_A1_2_2_4)>>');
ListePdf2.Add(' << /V ('+str_souschaine(DateToStr_Lgr(ExoNMoins1.DATE_FIN_EXO),5,1)+') /T (RN_A1_2_2_3)>>');
ListePdf2.Add(' << /V ('+str_souschaine(DateToStr_Lgr(ExoNMoins1.DATE_FIN_EXO),9,1)+') /T (RN_A1_2_2_2)>>');
ListePdf2.Add(' << /V ('+str_souschaine(DateToStr_Lgr(ExoNMoins1.DATE_FIN_EXO),10,1)+') /T (RN_A1_2_2_1)>>');

//DMDiocEtatBal.ResultatExercice(Debit,Credit,E.DatExoDebut,E.DatExoFin);
//ListePdf2.Add(' << /V ('+CurrToStr(Debit+Credit)+') /T (RN_B1_8_1)>>');


// Recalcul et réaffectation, cela permet
// de ne pas perdre les référence des objets de chaque cellule
// par rapport à DMRepart.ListeCell
BtnCalculer.Click;

if DMRepart.ListeCell.Count > 0 then
 begin
     // Remplissage de la liste servant à générer le PDF
     for  i:=0  to DMRepart.ListeCell.Count-1 do
       begin
//          ListePdf2.Add(' << /V ('+E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[i]).MontantTotal)+')/T ('+DMRepart.ListeCell.Strings[i]+')>>');
          if CBEditionCentime.Checked then
            ListePdf2.Add(' << /V ('+E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[i]).MontantTotal)+')/T ('+DMRepart.ListeCell.Strings[i]+')>>')
          else
           ListePdf2.Add(' << /V ('+CurrToStr(Round(TRepartition(DMRepart.ListeCell.Objects[i]).MontantTotal))+')/T ('+DMRepart.ListeCell.Strings[i]+')>>');
       end;
 end;
ListePdf2.Add(' ]');

if Sender = BtnImprimerDetail then
 begin
 case BtnImprimerDetail.Tag of
  EditionPartBilanActif_Bic:
  begin
    nomProvisoire:= copyFichierAvantUtilisation(DM_C_NomBilanBICReel2050,E.REpertoireFiscal);
    //ListePdf2.Add('/F ('+DM_C_NomBilanBICReel2050+')/ID [ <387aec558f007ac48b5052a725e4afd1><7040395dab48dfebccddc82ce39a75f8>');
  end;
  EditionPartBilanPassif_Bic:
  begin
    nomProvisoire:= copyFichierAvantUtilisation(DM_C_NomBilanBICReel2051,E.REpertoireFiscal);
   // ListePdf2.Add('/F ('+DM_C_NomBilanBICReel2051+')/ID [ <387aec558f007ac48b5052a725e4afd1><7040395dab48dfebccddc82ce39a75f8>');
  end;
  EditionPartCptResult1_Bic:
  begin
    nomProvisoire:= copyFichierAvantUtilisation(DM_C_NomBilanBICReel2052,E.REpertoireFiscal);
    //ListePdf2.Add('/F ('+DM_C_NomBilanBICReel2052+')/ID [ <387aec558f007ac48b5052a725e4afd1><7040395dab48dfebccddc82ce39a75f8>');
  end;
  EditionPartCptResult2_Bic:
  begin
    nomProvisoire:= copyFichierAvantUtilisation(DM_C_NomBilanBICReel2053,E.REpertoireFiscal);
    //ListePdf2.Add('/F ('+DM_C_NomBilanBICReel2053+')/ID [ <387aec558f007ac48b5052a725e4afd1><7040395dab48dfebccddc82ce39a75f8>');
  end;
 else
   begin
    nomProvisoire:= copyFichierAvantUtilisation(DM_C_NomBilanBICReel,E.REpertoireFiscal);
    //ListePdf2.Add('/F ('+DM_C_NomBilanBICReel+')/ID [ <387aec558f007ac48b5052a725e4afd1><7040395dab48dfebccddc82ce39a75f8>');
   end;
 end;


 end;

if Sender = BtnImprimer then
 begin
    nomProvisoire:= copyFichierAvantUtilisation(DM_C_NomBilanBICReel2050,E.REpertoireFiscal);
  //ListePdf2.Add('/F ('+DM_C_NomBilanBICReel+')/ID [ <387aec558f007ac48b5052a725e4afd1><7040395dab48dfebccddc82ce39a75f8>');
 end;

   ListePdf2.Add('/F ('+nomProvisoire+')/ID [ <387aec558f007ac48b5052a725e4afd1><7040395dab48dfebccddc82ce39a75f8>');


ListePdf2.Add('] >>');
ListePdf2.Add('>>');
ListePdf2.Add('endobj');
ListePdf2.Add('trailer');
ListePdf2.Add('<<');
ListePdf2.Add('/Root 1 0 R');
ListePdf2.Add('');
ListePdf2.Add('>>');
ListePdf2.Add('%%EOF');
ListePdf2.Add('');

//ListePdf.Add(' ]/F (BILAN AGRICOLE REEL.pdf)/ID [ <387aec558f007ac48b5052a725e4afd1><3bb486fc2b40ae11aed9513545836321>');
//ListePdf.Add('] >>>>endobjtrailer<</Root 1 0 R>>%%EOF');

ListePdf2.SaveToFile(E.REpertoireFiscal+'BILAN BIC REEL.fdf');
ListePdf2.Free;

if DMRepart.ListeCell.Count > 0 then
 begin
    ShellExecute(handle,nil,PChar('"'+E.REpertoireFiscal+'BILAN BIC REEL.fdf"'),nil,PChar(E.REpertoireFiscal),SW_SHOWNORMAL);
 end;
end;

procedure TEditionFin_Bic.BtnDetailClick(Sender: TObject);
var
i,j:integer;
ExercicePrecedent:Boolean;
begin
//DMDiocEtatBal.SommeTotauxBalanceCalc(E.DatExoDebut,E.DatExoFin,nil,'Compte');
//liste_cellule(DMDiocEtatBal.TaBalanceCalc,DMRepart.Repartition_Bic,E.Regime);
//SommeCellule(nil);

if DMRepart.ListeCell<>nil then
  Begin
      if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2050' then
       begin
         if GrBilanActif_Bic.col > 0 then
          begin
           DMLiasseFisc.InitTableSurNumLiasse_Bic('2050');
           j:=DMRepart.ListeCell.IndexOfObject(TRepartition(GrBilanActif_Bic.Objects[GrBilanActif_Bic.Col,GrBilanActif_Bic.Row]));
           if j <> -1 then
            begin
             ExercicePrecedent:= (GrBilanActif_Bic.Col =6); // Indicateur si N-1
             VisuListeCompteDeZoneAffich(DMRepart.ListeCell.Strings[j],ExercicePrecedent);
            end
            else
            ShowMessage('Pas de détail pour cette ligne');
          end;
       end;

      if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2051' then
       begin
         if GrBilanPassif_Bic.col > 0 then
          begin
           DMLiasseFisc.InitTableSurNumLiasse_Bic('2051');
           j:=DMRepart.ListeCell.IndexOfObject(TRepartition(GrBilanPassif_Bic.Objects[GrBilanPassif_Bic.Col,GrBilanPassif_Bic.Row]));
           if j <> -1 then
            begin
             ExercicePrecedent:= (GrBilanPassif_Bic.Col =5); // Indicateur si N-1
             VisuListeCompteDeZoneAffich(DMRepart.ListeCell.Strings[j],ExercicePrecedent);
            end
            else
            ShowMessage('Pas de détail pour cette ligne');
          end;
       end;

      if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2052' then
       begin
         if GrCptResultat_Bic.col > 0 then
          begin
           DMLiasseFisc.InitTableSurNumLiasse_Bic('2052');
           j:=DMRepart.ListeCell.IndexOfObject(TRepartition(GrCptResultat_Bic.Objects[GrCptResultat_Bic.Col,GrCptResultat_Bic.Row]));
           if j <> -1 then
            begin
             ExercicePrecedent:= (GrCptResultat_Bic.Col =7); // Indicateur si N-1
             VisuListeCompteDeZoneAffich(DMRepart.ListeCell.Strings[j],ExercicePrecedent);
            end
            else
            ShowMessage('Pas de détail pour cette ligne');
          end;
       end;

      if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2053' then
       begin
         if GrCptResultatBis_Bic.col > 0 then
          begin
           DMLiasseFisc.InitTableSurNumLiasse_Bic('2053');
           j:=DMRepart.ListeCell.IndexOfObject(TRepartition(GrCptResultatBis_Bic.Objects[GrCptResultatBis_Bic.Col,GrCptResultatBis_Bic.Row]));
           if j <> -1 then
            begin
             ExercicePrecedent:= (GrCptResultatBis_Bic.Col =8); // Indicateur si N-1
             VisuListeCompteDeZoneAffich(DMRepart.ListeCell.Strings[j],ExercicePrecedent);
            end
            else
            ShowMessage('Pas de détail pour cette ligne');
          end;
       end;
  end;//fin si non nil
end;

procedure TEditionFin_Bic.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
   begin
    Key:= 0;
    Self.Close;
   end;
end;

procedure TEditionFin_Bic.BtnAnnulerEnter(Sender: TObject);
begin
  BouttonDiminue(sender as TButton);
end;

procedure TEditionFin_Bic.BtnAnnulerExit(Sender: TObject);
begin
  BouttonAgrandit(sender as TButton);
end;

procedure TEditionFin_Bic.BtnModifierClick(Sender: TObject);
begin
//if not PaModifZone.Visible then PaModifZone.Visible := true;
end;

procedure TEditionFin_Bic.FormCreate(Sender: TObject);
begin
  try
      if DMLiasseFisc = nil then DMLiasseFisc := TDMLiasseFisc.Create(Application.MainForm);
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;


procedure TEditionFin_Bic.BtnInsererClick(Sender: TObject);
begin
//if DMRepart = nil then DMRepart:=TDMRepart.Create(Application.MainForm);
//DMRepart.MAJParamLia;
end;


procedure TEditionFin_Bic.SBFermerClick(Sender: TObject);
begin
PaModifZone.Visible := false;
end;

procedure TEditionFin_Bic.SBEnleverClick(Sender: TObject);
begin
//if REListeCompte.SetTextBuf();
end;

procedure TEditionFin_Bic.Panel1Click(Sender: TObject);
begin
//SommeCellule(nil);
end;

procedure TEditionFin_Bic.Imprimer1Click(Sender: TObject);
begin
BtnImprimer.Click;
end;

procedure TEditionFin_Bic.PCLiasseFiscaleChange(Sender: TObject);
begin
 
//bic
if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2050' then
 Begin
  BtnImprimerDetail.Tag := EditionPartBilanActif_Bic;
  BtnImprimerDetail.Caption := TitreBouttonImprimerDetail +'2050';
 End;

if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2051' then
 Begin
  BtnImprimerDetail.Tag := EditionPartBilanPassif_Bic;
  BtnImprimerDetail.Caption := TitreBouttonImprimerDetail +'2051';
 End;

if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2052' then
 Begin
  BtnImprimerDetail.Tag := EditionPartCptResult1_Bic;
  BtnImprimerDetail.Caption := TitreBouttonImprimerDetail +'2052';
 End;

if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2053' then
 Begin
  BtnImprimerDetail.Tag := EditionPartCptResult2_Bic;
  BtnImprimerDetail.Caption := TitreBouttonImprimerDetail +'2053';
 End;

end;

procedure TEditionFin_Bic.ImprimerDetail1Click(Sender: TObject);
begin
BtnImprimerDetail.Click;
end;

procedure TEditionFin_Bic.BtnFermerClick(Sender: TObject);
begin
  self.close;
end;

procedure TEditionFin_Bic.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(nil);
end;


procedure TEditionFin_Bic.BtnEditionRepartitionClick(Sender: TObject);
var
i,j,rang:integer;  //
listeComptes:Tstringlist;
Repartition:TRepartition;
compte:string;
montant:currency;
Feuille:string;
col1,col2,col3,col4,dif,pg:currency;
tot1,tot2,tot3,tot4,totdif,totpg:currency;
totTitre1,totTitre2,totTitre3,totTitre4,totTitredif,totTitrepg:currency;
totSSTitre1,totSSTitre2,totSSTitre3,totSSTitre4,totSSdif,totSSpg:currency;
totGen1,totGen2,totGen3,totGen4,totGendif,totGenpg:currency;
libelle,cellule,titre,soustitre:string;
Nbtrouve:integer;
ListeValeur,ListeValeurTemp:TStringList;
LigneExiste,colonne:integer;
ObjPrn:TObjetEdition;
separateur:char;
listeCompte2144,listeCompte2145:TStringList;
listeCompte2146:TStringList;       //,listeCompte21462
numligne:string;
ExoNMoins1:TInfosGestDossier;
begin
try
  ObjPrn:=TObjetEdition.Create(application.MainForm);
  ExoNMoins1:=ChercheInfos_ExoMoinsN1(e.NomDossier);
 separateur:='¤';
 ListeValeur:=TStringList.Create;
 ListeValeurTemp:=TStringList.Create;
 ObjPrn.FontLigneSeule.Style := [fsBold];
numligne:='1';
listeComptes:=DetailGeneral()  ;

if(listeComptes<>nil)then
listeCompte2144:=TStringList(listeComptes.Objects[0]);
listeCompte2145:=TStringList(listeComptes.Objects[1]);
listeCompte2146:=TStringList(listeComptes.Objects[2]);



rempliColonneMontant(col1,col2,col3,col4,-1,'',0,separateur,0,true); //initialisation
rempliColonneMontant(tot1,tot2,tot3,tot4,-1,'',0,separateur,0,true); //initialisation
rempliColonneMontant(totSSTitre1,totSSTitre2,totSSTitre3,totSSTitre4,-1,'',0,separateur,0,true); //initialisation
rempliColonneMontant(totTitre1,totTitre2,totTitre3,totTitre4,-1,'',0,separateur,0,true); //initialisation
rempliColonneMontant(totGen1,totGen2,totGen3,totGen4,-1,'',0,separateur,0,true); //initialisation
ListeValeur.clear;
     titre:='';
     soustitre:='';
ListeValeur.add('10'+separateur+'DETAIL DU BILAN ACTIF');
listeCompte2144:=rempliListeAvantEdition(listeCompte2144);
rempliEditionListe(listeCompte2144,ListeValeur);

ListeValeur.add('20');
ListeValeur.add('10'+separateur+'DETAIL DU BILAN PASSIF');
rempliColonneMontant(col1,col2,col3,col4,-1,'',0,separateur,0,true); //initialisation
rempliColonneMontant(tot1,tot2,tot3,tot4,-1,'',0,separateur,0,true); //initialisation
rempliColonneMontant(totSSTitre1,totSSTitre2,totSSTitre3,totSSTitre4,-1,'',0,separateur,0,true); //initialisation
rempliColonneMontant(totTitre1,totTitre2,totTitre3,totTitre4,-1,'',0,separateur,0,true); //initialisation
rempliColonneMontant(totGen1,totGen2,totGen3,totGen4,-1,'',0,separateur,0,true); //initialisation
titre:='';
soustitre:='';
listeCompte2145:=rempliListeAvantEdition(listeCompte2145);
rempliEditionListe(listeCompte2145,ListeValeur);
//rempliEditionListe(listeCompte2145,ListeValeur);

ListeValeur.add('20');
ListeValeur.add('10'+separateur+'DETAIL DU COMPTE DE RESULTAT');
rempliColonneMontant(col1,col2,col3,col4,-1,'',0,separateur,0,true); //initialisation
rempliColonneMontant(tot1,tot2,tot3,tot4,-1,'',0,separateur,0,true); //initialisation
rempliColonneMontant(totSSTitre1,totSSTitre2,totSSTitre3,totSSTitre4,-1,'',0,separateur,0,true); //initialisation
rempliColonneMontant(totTitre1,totTitre2,totTitre3,totTitre4,-1,'',0,separateur,0,true); //initialisation
rempliColonneMontant(totGen1,totGen2,totGen3,totGen4,-1,'',0,separateur,0,true); //initialisation
titre:='';
soustitre:='';
listeCompte2146:=rempliListeAvantEdition(listeCompte2146);
rempliEditionListe(listeCompte2146,ListeValeur);
//rempliEditionListe(listeCompte2146,ListeValeur);
ListeValeur.Delete(ListeValeur.Count-1);//pour enlever le total général final


                   ObjPrn.FTitreEdition := 'EDITION DETAILLE DU BILAN';
                 ObjPrn.FTitre2Edition :='Exercice clos le '+DateInfos(E.DatExoFin).DateStr;
                 ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
                 ObjPrn.FDelimiteur:=separateur;
                 ListeValeur.Insert(0,' Désignation '+separateur+' Compte '+separateur+' Net '+separateur+' Net '+separateur+' Montant '+separateur+' % ');
                // ListeValeur.Insert(0,' Désignation '+separateur+' Compte '+separateur+' Brut '+separateur+' Amort.dépréciat. '+separateur+' Net '+separateur+' Net -1 ');
                 ListeValeur.Insert(1,'2.2'+separateur+'0.6'+separateur+'1'+separateur+'1'+separateur+'1'+separateur+'1');
                 ListeValeur.Insert(2,'texte'+separateur+'texte'+separateur+'curr'+separateur+'curr'+separateur+'curr'+separateur+'curr');
                 ListeValeur.Insert(3,' '+separateur+DateInfos(E.DatExoFin).DateStr+separateur+DateInfos(ExoNMoins1.DATE_FIN_EXO).DateStr+separateur+' Variation '+separateur+'SURTITRE');
                 ListeValeur.Insert(4,'2.8'+separateur+'1'+separateur+'1'+separateur+'2');

  ObjPrn.AffichageImp(ListeValeur);
finally
   ListeValeur.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireExportation)+'BilanDetaille.txt');
   //showmessage(listeFinale.GetText);
   if(listeComptes<>nil)then listeComptes.Free;
   ListeValeur.free;
   ListeValeurTemp.Free;
   LibereObjet(Tobject(ObjPrn));
end;
//
end;

//function retrouveLibelle(ListeValeur:Tstringlist;repere:string;separateur:char):integer;
//var
//i:integer;
//retour:integer;
//begin
//retour:=-1;
//   if(ListeValeur<>nil)then
//     begin
//     i:=0;
//         while ((i<=ListeValeur.Count-1)and(retour=-1))do
//         begin
//            if( str_commence_par(LowerCase(str_getstringelement(listevaleur.Strings[i],2,separateur)),LowerCase(repere)))then
//               retour:=i;
//            inc(i);
//         end;
//     end;
// retrouveLibelle:=retour;
//end;

function retrouveLigne(ListeValeur:Tstringlist;repere:string;separateur:char):integer;
var
i:integer;
retour:integer;
begin
retour:=-1;
   if(ListeValeur<>nil)then
     begin
     i:=0;
         while ((i<=ListeValeur.Count-1)and(retour=-1))do
         begin
            if( str_getstringelement(listevaleur.Strings[i],2,separateur)+
            str_getstringelement(listevaleur.Strings[i],3,separateur)=repere)then
               retour:=i;
            inc(i);
         end;
     end;
 retrouveLigne:=retour;
end;



procedure rempliColonneMontant(var Col1,Col2,Col3,Col4 : currency ; Colonne:integer ; ligne:string
   ;montantAAffecter:currency;separateur:char;arrondi_in:integer;initialise:boolean);
var
montantArrondi:currency;
begin
montantArrondi:=arrondi(montantAAffecter,2);
if(initialise)then
begin
 col1:=0 ;
 col2:=0;
 col3:=0;
 col4:=0;
end;
   if(not empty(ligne))then
     begin
         case colonne of
          1:begin
               col1:=col1+StrToCurr_Lgr(str_getstringelement(ligne,6,separateur))+montantArrondi ;
               col2:=col2+StrToCurr_Lgr(str_getstringelement(ligne,7,separateur));
               col3:=col3+StrToCurr_Lgr(str_getstringelement(ligne,8,separateur));
               col4:=col4+StrToCurr_Lgr(str_getstringelement(ligne,9,separateur));
            end;
          2:begin
               col1:=col1+StrToCurr_Lgr(str_getstringelement(ligne,6,separateur)); ;
               col2:=col2+StrToCurr_Lgr(str_getstringelement(ligne,7,separateur))+montantArrondi;
               col3:=col3+StrToCurr_Lgr(str_getstringelement(ligne,8,separateur));
               col4:=col4+StrToCurr_Lgr(str_getstringelement(ligne,9,separateur));
            end;
          3:begin
               col1:=col1+StrToCurr_Lgr(str_getstringelement(ligne,6,separateur)); ;
               col2:=col2+StrToCurr_Lgr(str_getstringelement(ligne,7,separateur));
               col3:=col3+StrToCurr_Lgr(str_getstringelement(ligne,8,separateur))+montantArrondi;
               col4:=col4+StrToCurr_Lgr(str_getstringelement(ligne,9,separateur));
            end;
          4:begin
               col1:= col1+StrToCurr_Lgr(str_getstringelement(ligne,6,separateur));;
               col2:=col2+StrToCurr_Lgr(str_getstringelement(ligne,7,separateur));
               col3:=col3+StrToCurr_Lgr(str_getstringelement(ligne,8,separateur));
               col4:=col4+StrToCurr_Lgr(str_getstringelement(ligne,9,separateur))+montantArrondi;
            end;
       end;
     end
   else
     begin
         case colonne of
          1:begin
               col1:=col1+montantArrondi ;
            end;
          2:begin
               col2:=col2+montantArrondi;
            end;
          3:begin
               col3:=col3+montantArrondi;
            end;
          4:begin
               col4:=col4+montantArrondi;
            end;
       end;
     end;

end;

function rechercheSiMontantRempli(Repartition:TRepartition):boolean;
var
montant:currency;
i:integer;
begin
   rechercheSiMontantRempli:=(repartition.MontantTotal<>0) and (Repartition.colBilan<>'3');
   if(repartition.MontantTotal=0)and (repartition.compte<>nil)and(repartition.compte.Count>1)and (Repartition.colBilan<>'3')then
   begin
      for i:=0 to repartition.compte.Count-1 do
        begin
           if(Repartition.compte.Objects[i]<>nil)and
           (TMontant(Repartition.compte.Objects[i]).MontantCpt<>0) then
             rechercheSiMontantRempli:=true;
        end;
   end;
end;

function rempliListeAvantEdition(listeComptesIn:Tstringlist) : Tstringlist;
var
i,j,rang:integer;  //
Repartition:TRepartition;
compte:string;
montant:currency;
Feuille:string;
col1,col2,col3,col4,dif,pg:currency;
Tot1,Tot2,Tot3,Tot4:currency;
libelle,cellule,titre,soustitre:string;
Nbtrouve:integer;
LigneExiste,colonne:integer;
ListeRetour : TStringlistLGR1;
separateur:char;
numligne:string;
begin
//try
ListeRetour:=TStringlistLGR1.create;
 for i:=0 to listeComptesIn.Count-1 do
  begin
     Feuille:='';
     colonne:=0;
     if(listeComptesIn.Objects[i]<>nil)then
       begin
           Repartition:= TRepartition(listeComptesIn.Objects[i]);
           if(rechercheSiMontantRempli(Repartition))then
           begin
           rempliColonneMontant(col1,col2,col3,col4,-1,'',0,separateur,0,true); //initialisation
            cellule:=Repartition.cellule;
           libelle:= Repartition.libelleBilan;
//           if(libelle='RÉSULTAT DE L’EXERCICE (bénéfice ou perte)')then
//             showmessage('');
           titre:= Repartition.titre;
           soustitre := Repartition.soustitre;

          Feuille:=Repartition.Feuille;
           colonne:= StrToInt_Lgr(Repartition.colBilan);
           Nbtrouve:=0;
           compte:='';
           for j:=0 to Repartition.compte.Count-1 do
             begin
                 compte:='';
                 montant:=0;
                 compte:=Repartition.compte.Strings[j];
                 colonne:=StrToInt_Lgr(Repartition.colBilan);
                 if(Repartition.compte.Objects[j]<>nil) then
                 begin
                   montant:=TMontant(Repartition.compte.Objects[j]).MontantCpt;

//                 if(compte='')then
//                    LigneExiste:= retrouveLibelle(ListeRetour,libelle,separateur)
//                 else
                   LigneExiste:= retrouveLigne(ListeRetour,libelle+compte,separateur);
                 if(LigneExiste>-1)then
                    begin
                       rempliColonneMontant(col1,col2,col3,col4,colonne,ListeRetour.Strings[LigneExiste],montant,separateur);
                       rempliColonneMontant(tot1,tot2,tot3,tot4,colonne,'',montant,separateur);
                       ListeRetour.Strings[LigneExiste]:=('0'+separateur+libelle+separateur+compte
                       +separateur+titre+separateur+soustitre
                       +separateur+e.FormatCurrSansDevise(col1)
                       +separateur+e.FormatCurrSansDevise(col2)
                       +separateur+e.FormatCurrSansDevise(col3)
                       +separateur+e.FormatCurrSansDevise(col4));

                    end
                 else
                   begin
                      rempliColonneMontant(col1,col2,col3,col4,colonne,'',montant,separateur);
                      rempliColonneMontant(tot1,tot2,tot3,tot4,colonne,'',montant,separateur);
                      ListeRetour.add('0'+separateur+libelle+separateur+compte
                      +separateur+titre+separateur+soustitre
                       +separateur+e.FormatCurrSansDevise(col1)
                       +separateur+e.FormatCurrSansDevise(col2)
                       +separateur+e.FormatCurrSansDevise(col3)
                       +separateur+e.FormatCurrSansDevise(col4));
                   end;
                 end;//<>nil
                 inc(Nbtrouve);
             end;//end for
             if(Nbtrouve=0)then
               begin
//                 if(compte='')then
//                    LigneExiste:= retrouveLibelle(ListeRetour,libelle,separateur)
//                 else
                   LigneExiste:= retrouveLigne(ListeRetour,libelle+compte,separateur);
                 if(str_commence_par(lowercase(soustitre),'@')) then
                    begin
                         numligne:='1';
                         compte:='';
                    end
                  else
                  numligne:='0';
                 if(LigneExiste>-1)then
                    begin
                     if(numligne<>'0')then
                      begin
                         rempliColonneMontant(col1,col2,col3,col4,colonne,ListeRetour.Strings[LigneExiste],Repartition.MontantTotal,separateur,0,false);
                      end
                      else
                      begin
                       rempliColonneMontant(col1,col2,col3,col4,colonne,ListeRetour.Strings[LigneExiste],Repartition.MontantTotal,separateur,2,false);
                      end;
                       ListeRetour.Strings[LigneExiste]:=(numligne+separateur+libelle+separateur+compte
                       +separateur+titre+separateur+soustitre
                       +separateur+e.FormatCurrSansDevise(col1)
                       +separateur+e.FormatCurrSansDevise(col2)
                       +separateur+e.FormatCurrSansDevise(col3)
                       +separateur+e.FormatCurrSansDevise(col4));

                    end
                 else
                   begin
                      if(numligne<>'0')then
                      begin
                        rempliColonneMontant(col1,col2,col3,col4,colonne,'',Repartition.MontantTotal,separateur,0);
                      end
                      else
                      begin
                      rempliColonneMontant(col1,col2,col3,col4,colonne,'',Repartition.MontantTotal,separateur);
                      end;
                      ListeRetour.Add(numligne+separateur+libelle+separateur+compte
                      +separateur+titre+separateur+soustitre
                       +separateur+e.FormatCurrSansDevise(col1)
                       +separateur+e.FormatCurrSansDevise(col2)
                       +separateur+e.FormatCurrSansDevise(col3)
                       +separateur+e.FormatCurrSansDevise(col4));
                   end;
               //end;
                end//fin Nbtrouve=0
                else
                begin

                end;//fin si nbtrouve<>0
            end;//si montant rempli
       end;//fin listeComptesIn.Objects[i]<>nil
  end;//fin for
//finally
ListeRetour.CustomSort(CustomSortCompteProcAsc);

rempliListeAvantEdition:=ListeRetour;
//end;
end;


//procedure rempliEditionListe(listeComptesIn:Tstringlist;Var ListeValeur : Tstringlist);
//var
//i,j,rang:integer;  //
//Repartition:TRepartition;
//compte:string;
//montant:currency;
//Feuille:string;
//col1,col2,col3,col4,dif,pg:currency;
//tot1,tot2,tot3,tot4,totdif,totpg:currency;
//totTitre1,totTitre2,totTitre3,totTitre4,totTitredif,totTitrepg:currency;
//totSSTitre1,totSSTitre2,totSSTitre3,totSSTitre4,totSSdif,totSSpg:currency;
//totGen1,totGen2,totGen3,totGen4,totGendif,totGenpg:currency;
//libelle,cellule,titre,soustitre:string;
//Nbtrouve:integer;
//LigneExiste,colonne:integer;
////ObjPrn:TObjetEdition;
//separateur:char;
//numligne:string;
//begin
// for i:=0 to listeComptesIn.Count-1 do
//  begin
//     Feuille:='';
//     colonne:=0;
//     if(listeComptesIn.Objects[i]<>nil)then
//       begin
//       rempliColonneMontant(col1,col2,col3,col4,-1,'',0,separateur,0,true); //initialisation
//           Repartition:= TRepartition(listeComptesIn.Objects[i]);
//           if(rechercheSiMontantRempli(Repartition))then
//           begin
////           if (i=1)then
////             begin
////                 if(not empty(Repartition.titre))then ListeValeur.add('9'+separateur+Repartition.titre);
////                 if(not empty(Repartition.soustitre))then ListeValeur.add('9'+separateur+Repartition.soustitre);
////             end;
////          if(not empty(libelle))and (libelle<>Repartition.libelleBilan)and (Nbtrouve>1)then
////             begin
////                 //coupure
////                 ListeValeur.Add('3'+separateur+separateur+' @'+libelle+separateur+e.FormatCurrSansDevise(tot1)
////                 +separateur+e.FormatCurrSansDevise(tot2)+separateur+e.FormatCurrSansDevise(tot3)+separateur+e.FormatCurrSansDevise(tot4));
////             end;
//          if(soustitre<>Repartition.soustitre)then
//             begin
//                 //coupure
//                 if(not empty(soustitre))then
//                 begin
//                    totSSdif:=totSSTitre3-totSSTitre4;
//                    if(totSSTitre4<>0)then totSSpg:=Arrondi((totSSdif*100)/totSSTitre4,1)else totSSpg:=0;
//                    ListeValeur.Add('3'+separateur+separateur+' @'+soustitre+separateur+e.FormatCurrSansDevise(Arrondi(totSSTitre3,0))
//                    +separateur+e.FormatCurrSansDevise(Arrondi(totSSTitre4,0))
//                      +separateur+e.FormatCurrSansDevise(Arrondi(totSSdif,0))+separateur+e.FormatCurrSansDevise(totSSpg));
//                    rempliColonneMontant(totSSTitre1,totSSTitre2,totSSTitre3,totSSTitre4,-1,'',0,separateur,0,true); //initialisation
//                 end;
//             end;
//          if(titre<>Repartition.titre)then
//             begin
//                 //coupure
//                 if(not empty(titre))then
//                 begin
//                    totdif:=totTitre3-totTitre4;
//                    if(totTitre4<>0)then totpg:=Arrondi((totdif*100)/totTitre4,1)else totpg:=0;
//                     ListeValeur.Add('1'+separateur+separateur+' @'+titre+separateur+e.FormatCurrSansDevise(Arrondi(totTitre3,0))
//                     +separateur+e.FormatCurrSansDevise(Arrondi(totTitre4,0))
//                     +separateur+e.FormatCurrSansDevise(Arrondi(totdif,0))+separateur+e.FormatCurrSansDevise(totpg));
//                     rempliColonneMontant(totTitre1,totTitre2,totTitre1,totTitre4,-1,'',0,separateur,0,true); //initialisation
//                 end;
//             end;
//
//          if(titre<>Repartition.titre)then
//             begin
//                 //coupure
//                 if(not empty(Repartition.titre))then
//                   ListeValeur.add('9'+separateur+Repartition.titre);
//
//             end;
//
//          if(soustitre<>Repartition.soustitre)then
//             begin
//                 //coupure
//                 if(not empty(Repartition.soustitre))then
//                   ListeValeur.add('9'+separateur+Repartition.soustitre);
//
//             end;
//             rempliColonneMontant(tot1,tot2,tot3,tot4,-1,'',0,separateur,0,true); //initialisation
//            cellule:=Repartition.cellule;
//           libelle:= Repartition.libelleBilan;
//           titre:= Repartition.titre;
//           soustitre := Repartition.soustitre;
//            //ListeValeur.add('9'+separateur+libelle);
//          Feuille:=Repartition.Feuille;
//           colonne:= StrToInt_Lgr(Repartition.colBilan);
//           Nbtrouve:=0;
//           compte:='';
//
//           if(Repartition.compte.Count>1) then ListeValeur.add('0'+separateur+separateur);
//           for j:=0 to Repartition.compte.Count-1 do
//             begin
//                 compte:='';
//                 montant:=0;
//                 compte:=Repartition.compte.Strings[j];
//                 colonne:=StrToInt_Lgr(Repartition.colBilan);
//                 if(Repartition.compte.Objects[j]<>nil) then
//                 begin
//                   montant:=TMontant(Repartition.compte.Objects[j]).MontantCpt;
//
//                 LigneExiste:= retrouveLigne(ListeValeur,libelle+compte,separateur);
//                 if(LigneExiste>-1)then
//                    begin
//                       rempliColonneMontant(col1,col2,col3,col4,colonne,ListeValeur.Strings[LigneExiste],montant,separateur);
//                       rempliColonneMontant(tot1,tot2,tot3,tot4,colonne,'',montant,separateur,0,false);
//                       rempliColonneMontant(totTitre1,totTitre2,totTitre3,totTitre4,colonne,'',montant,separateur,0,false);
//                       rempliColonneMontant(totSSTitre1,totSSTitre2,totSSTitre3,totSSTitre4,colonne,'',montant,separateur,0,false);
//                       rempliColonneMontant(totGen1,totGen2,totGen3,totGen4,colonne,'',montant,separateur,0,false);
//                       dif:=col1-col2-col3;
//                       if(col3<>0)then pg:=Arrondi((dif*100)/col3,1) else pg:=0;
//                       ListeValeur.Strings[LigneExiste]:=('0'+separateur+libelle+separateur+compte
//                       +separateur+e.FormatCurrSansDevise(col1-col2)
//                       +separateur+e.FormatCurrSansDevise(col3)
//                       +separateur+e.FormatCurrSansDevise(dif)
//                       +separateur+e.FormatCurrSansDevise(pg));
//
//                    end
//                 else
//                   begin
//                      rempliColonneMontant(col1,col2,col3,col4,colonne,'',montant,separateur);
//                      rempliColonneMontant(tot1,tot2,tot3,tot4,colonne,'',montant,separateur,0,false);
//                      rempliColonneMontant(totTitre1,totTitre2,totTitre3,totTitre4,colonne,'',montant,separateur,0,false);
//                       rempliColonneMontant(totSSTitre1,totSSTitre2,totSSTitre3,totSSTitre4,colonne,'',montant,separateur,0,false);
//                       rempliColonneMontant(totGen1,totGen2,totGen3,totGen4,colonne,'',montant,separateur,0,false);
//                       dif:=col1-col2-col3;
//                       if(col3<>0)then pg:=Arrondi((dif*100)/col3,1) else pg:=0;
//                      ListeValeur.add('0'+separateur+libelle+separateur+compte
//                       +separateur+e.FormatCurrSansDevise(col1-col2)
//                       +separateur+e.FormatCurrSansDevise(col3)
//                       +separateur+e.FormatCurrSansDevise(dif)
//                       +separateur+e.FormatCurrSansDevise(pg));
//                   end;
//                 end;//<>nil
//                 inc(Nbtrouve);
//             end;//end for
//             if(Nbtrouve=0)then
//               begin
//                 LigneExiste:= retrouveLigne(ListeValeur,libelle+compte,separateur);
//                 if(str_commence_par(lowercase(libelle),'-')) then
//                    begin
//                         numligne:='1';
//                         compte:='';
//                    end
//                  else
//                  numligne:='0';
//                 if(LigneExiste>-1)then
//                    begin
//                     if(numligne<>'0')then
//                      begin
//                         rempliColonneMontant(col1,col2,col3,col4,colonne,ListeValeur.Strings[LigneExiste],Repartition.MontantTotal,separateur,0);
//                      end
//                      else
//                      begin
//                       rempliColonneMontant(col1,col2,col3,col4,colonne,ListeValeur.Strings[LigneExiste],Repartition.MontantTotal,separateur);
//                       rempliColonneMontant(tot1,tot2,tot3,tot4,colonne,'',Repartition.MontantTotal,separateur,0,false);
//                       rempliColonneMontant(totTitre1,totTitre2,totTitre3,totTitre4,colonne,'',Repartition.MontantTotal,separateur,0,false);
//                       rempliColonneMontant(totSSTitre1,totSSTitre2,totSSTitre3,totSSTitre4,colonne,'',Repartition.MontantTotal,separateur,0,false);
//                       rempliColonneMontant(totGen1,totGen2,totGen3,totGen4,colonne,'',Repartition.MontantTotal,separateur,0,false);
//                      end;
//                       dif:=col1-col2;
//                       if(col3<>0)then pg:=Arrondi((dif*100)/col3,1) else pg:=0;
//                       ListeValeur.Strings[LigneExiste]:=(numligne+separateur+libelle+separateur+compte
//                       +separateur+e.FormatCurrSansDevise(col1-col2)
//                       +separateur+e.FormatCurrSansDevise(col3)
//                       +separateur+e.FormatCurrSansDevise(dif)
//                       +separateur+e.FormatCurrSansDevise(pg));
//
//                    end
//                 else
//                   begin
//                      if(numligne<>'0')then
//                      begin
//                        rempliColonneMontant(col1,col2,col3,col4,colonne,'',Repartition.MontantTotal,separateur,0);
//                      end
//                      else
//                      begin
//                      rempliColonneMontant(col1,col2,col3,col4,colonne,'',Repartition.MontantTotal,separateur);
//                      rempliColonneMontant(tot1,tot2,tot3,tot4,colonne,'',Repartition.MontantTotal,separateur,0,false);
//                      rempliColonneMontant(totTitre1,totTitre2,totTitre3,totTitre4,colonne,'',Repartition.MontantTotal,separateur,0,false);
//                      rempliColonneMontant(totSSTitre1,totSSTitre2,totSSTitre3,totSSTitre4,colonne,'',Repartition.MontantTotal,separateur,0,false);
//                      rempliColonneMontant(totGen1,totGen2,totGen3,totGen4,colonne,'',Repartition.MontantTotal,separateur,0,false);
//                      end;
//                       dif:=col1-col2-col3;
//                       if(col3<>0)then pg:=Arrondi((dif*100)/col3,1) else pg:=0;
//
//                      ListeValeur.Add(numligne+separateur+libelle+separateur+compte
//                      +separateur+e.FormatCurrSansDevise(col1-col2)
//                       +separateur+e.FormatCurrSansDevise(col3)
//                       +separateur+e.FormatCurrSansDevise(dif)
//                       +separateur+e.FormatCurrSansDevise(pg));
//                   end;
//               //end;
//                end;//fin Nbtrouve=0
//              end;// si montant rempli
//       end; //fin si listeComptesIn.Objects[i]<>nil
//  end;// fin for i:=0 to listeComptesIn.Count-1
////coupure
//  if(not empty(soustitre))then
//     begin
//     totSSdif:=totSSTitre3-totSSTitre4;
//     if(totSSTitre3<>0)then totSSpg:=Arrondi((totssdif*100)/totSSTitre3,1) else totSSpg:=0;
//        ListeValeur.Add('3'+separateur+separateur+' @'+soustitre+separateur+e.FormatCurrSansDevise(Arrondi(totSSTitre3,0))
//        +separateur+e.FormatCurrSansDevise(Arrondi(totSSTitre4,0))
//          +separateur+e.FormatCurrSansDevise(Arrondi(totSSdif,0))+separateur+e.FormatCurrSansDevise(totSSpg));
//        rempliColonneMontant(totSSTitre1,totSSTitre2,totSSTitre1,totSSTitre4,-1,'',0,separateur,0,true); //initialisation
//     end;
//
//
//     //coupure
//     if(not empty(titre))then
//     begin
//     totdif:=totTitre3-totTitre4;
//     if(totTitre3<>0)then totpg:=Arrondi((totdif*100)/totTitre3,1)else totpg:=0;
//         ListeValeur.Add('1'+separateur+separateur+' @'+titre+separateur+e.FormatCurrSansDevise(Arrondi(totTitre3,0))
//         +separateur+e.FormatCurrSansDevise(Arrondi(totTitre4,0))
//         +separateur+e.FormatCurrSansDevise(Arrondi(totdif,0))+separateur+e.FormatCurrSansDevise(totpg));
//         rempliColonneMontant(totTitre1,totTitre2,totTitre3,totTitre4,-1,'',0,separateur,0,true); //initialisation
//     end;
//     totGendif:=totGen3-totGen4;
//     if(totGen3<>0)then totGenpg:=Arrondi((totGendif*100)/totGen3,1)else totGenpg:=0;
//      ListeValeur.Add('4'+separateur+separateur+'@TOTAL GENERAL'
//      +separateur+e.FormatCurrSansDevise(Arrondi(totGen3,0))+separateur+e.FormatCurrSansDevise(Arrondi(totGen4,0))
//           +separateur+e.FormatCurrSansDevise(Arrondi(totGendif,0))
//           +separateur+e.FormatCurrSansDevise(totGenpg));
//
//end;
procedure rempliEditionListe(listeComptesIn:Tstringlist;Var ListeValeur : Tstringlist);
var
i,j,rang:integer;  //
Repartition:TRepartition;
compte:string;
montant:currency;
Feuille:string;
col1,col2,col3,col4,dif,pg:currency;
tot1,tot2,tot3,tot4:currency;
totTitre1,totTitre2,totTitre3,totTitre4:currency;
totSSTitre1,totSSTitre2,totSSTitre3,totSSTitre4:currency;
totGen1,totGen2,totGen3,totGen4:currency;
libelle,libelleCpt,cellule,titre,soustitre:string;
Nbtrouve:integer;
LigneExiste,colonne:integer;
//ObjPrn:TObjetEdition;
separateur:char;
numligne:string;
ligne:string;
nbArrondi:integer;
begin
if EditionFin_Bic.CBEditionCentime.Checked then nbArrondi:=2 else nbArrondi:=0;
 for i:=0 to listeComptesIn.Count-1 do
  begin

  ligne:=listeComptesIn.Strings[i];

          if(libelle<>str_getstringelement(ligne,2,separateur))and(not str_commence_par(soustitre,'@'))then
             begin
                 //coupure
                 if(not empty(libelle))then
                 begin
                    dif:=tot1-tot2-tot4;
                    if(tot4<>0)then pg:=Arrondi((dif*100)/abs(tot4),2)else pg:=0;
                     ListeValeur.Add('1'+separateur+separateur+' @Total'+separateur+e.FormatCurrSansDevise(Arrondi(tot1-tot2,nbArrondi))
                     +separateur+e.FormatCurrSansDevise(Arrondi(tot4,nbArrondi))
                     +separateur+e.FormatCurrSansDevise(Arrondi(dif,nbArrondi))+separateur+e.FormatCurrSansDevise(pg));
                     rempliColonneMontant(tot1,tot2,tot1,tot4,-1,'',0,separateur,0,true); //initialisation
                 end;
             end;  
          if(soustitre<>str_getstringelement(ligne,5,separateur))and(not str_commence_par(soustitre,'@'))then
             begin
                 //coupure
                 if(not empty(soustitre))then
                 begin
                    dif:=totSSTitre1-totSSTitre2-totSSTitre4;
                    if(totSSTitre4<>0)then pg:=Arrondi((dif*100)/abs(totSSTitre4),2)else pg:=0;
                    ListeValeur.Add('3'+separateur+separateur+' @'+soustitre+separateur+e.FormatCurrSansDevise(Arrondi(totSSTitre1-totSSTitre2,nbArrondi))
                    +separateur+e.FormatCurrSansDevise(Arrondi(totSSTitre4,nbArrondi))
                      +separateur+e.FormatCurrSansDevise(Arrondi(dif,nbArrondi))+separateur+e.FormatCurrSansDevise(pg));
                    rempliColonneMontant(totSSTitre1,totSSTitre2,totSSTitre3,totSSTitre4,-1,'',0,separateur,0,true); //initialisation
                 end;
             end;
          if(titre<>str_getstringelement(ligne,4,separateur))then
             begin
                 //coupure
                 if(not empty(titre))then
                 begin
                    dif:=totTitre1-totTitre2-totTitre4;
                    if(totTitre4<>0)then pg:=Arrondi((dif*100)/abs(totTitre4),2)else pg:=0;
                     ListeValeur.Add('1'+separateur+separateur+' @'+titre+separateur+e.FormatCurrSansDevise(Arrondi(totTitre1-totTitre2,nbArrondi))
                     +separateur+e.FormatCurrSansDevise(Arrondi(totTitre4,nbArrondi))
                     +separateur+e.FormatCurrSansDevise(Arrondi(dif,nbArrondi))+separateur+e.FormatCurrSansDevise(pg));
                     rempliColonneMontant(totTitre1,totTitre2,totTitre1,totTitre4,-1,'',0,separateur,0,true); //initialisation
                 end;
             end;

          if(titre<>str_getstringelement(ligne,4,separateur))then
             begin
                 //coupure
                 if(not empty(str_getstringelement(ligne,4,separateur)))then
                   ListeValeur.add('9'+separateur+str_getstringelement(ligne,4,separateur));

             end;

          if(soustitre<>str_getstringelement(ligne,5,separateur))and(not str_commence_par(str_getstringelement(ligne,5,separateur),'@'))then
             begin
                 //coupure
                 if(not empty(str_getstringelement(ligne,5,separateur)))then
                   ListeValeur.add('9'+separateur+str_getstringelement(ligne,5,separateur));

             end;

          if(libelle<>str_getstringelement(ligne,2,separateur))and(not str_commence_par(str_getstringelement(ligne,5,separateur),'@'))then
             begin
                 //coupure
                 if(not empty(str_getstringelement(ligne,2,separateur)))then
                   ListeValeur.add('9'+separateur+str_getstringelement(ligne,2,separateur));

             end;

  libelleCpt:='';
  libelle:=str_getstringelement(ligne,2,separateur);
  if(str_getstringelement(ligne,1,separateur)<>'0')then
  begin
      libelleCpt:='';
      compte:='@'+str_getstringelement(ligne,2,separateur);
      col1:=arrondi(StrToCurr_Lgr(str_getstringelement(ligne,6,separateur)),nbArrondi);
      col2:=arrondi(StrToCurr_Lgr(str_getstringelement(ligne,7,separateur)),nbArrondi);
      col3:=arrondi(StrToCurr_Lgr(str_getstringelement(ligne,8,separateur)),nbArrondi);
      col4:=arrondi(StrToCurr_Lgr(str_getstringelement(ligne,9,separateur)),nbArrondi);
  end
  else
  begin
      compte:=str_getstringelement(ligne,3,separateur);
      if(compte<>'')then libelleCpt:=DMPlan.LibelleDuNumCptPCU(compte);
      col1:=StrToCurr_Lgr(str_getstringelement(ligne,6,separateur));
      col2:=StrToCurr_Lgr(str_getstringelement(ligne,7,separateur));
      col3:=StrToCurr_Lgr(str_getstringelement(ligne,8,separateur));
      col4:=StrToCurr_Lgr(str_getstringelement(ligne,9,separateur));
  end;
  titre:=str_getstringelement(ligne,4,separateur);
  soustitre:=str_getstringelement(ligne,5,separateur);

                       dif:=col1-col2-col4;
                       if(col4<>0)then pg:=Arrondi((dif*100)/abs(col4),2) else pg:=0;
                      ListeValeur.add(str_getstringelement(ligne,1,separateur)+separateur+libelleCpt+separateur+compte
                       +separateur+e.FormatCurrSansDevise(arrondi(col1-col2,nbArrondi))
                       +separateur+e.FormatCurrSansDevise(arrondi(col4,nbArrondi))
                       +separateur+e.FormatCurrSansDevise(arrondi(dif,nbArrondi))
                       +separateur+e.FormatCurrSansDevise(pg));
                       if(str_getstringelement(ligne,1,separateur)='0')then
                       begin

                        tot1:=tot1+col1;
                        tot2:=tot2+col2;
                        tot3:=tot3+col3;
                        tot4:=tot4+col4;


                        totTitre1:=totTitre1+col1;
                        totTitre2:=totTitre2+col2;
                        totTitre3:=totTitre3+col3;
                        totTitre4:=totTitre4+col4;

                        totssTitre1:=totssTitre1+col1;
                        totssTitre2:=totssTitre2+col2;
                        totssTitre3:=totssTitre3+col3;
                        totssTitre4:=totssTitre4+col4;

                        totGen1:=totGen1+col1;
                        totGen2:=totGen2+col2;
                        totGen3:=totGen3+col3;
                        totGen4:=totGen4+col4;
                        end;

  end;// fin for i:=0 to listeComptesIn.Count-1
//coupure


  if(not empty(libelle))and(not str_commence_par(soustitre,'@'))then
     begin
     dif:=tot1-tot2-tot4;
     if(tot4<>0)then pg:=Arrondi((dif*100)/abs(tot4),2) else pg:=0;
        ListeValeur.Add('3'+separateur+separateur+' @Total'+separateur+e.FormatCurrSansDevise(Arrondi(tot1-tot2,nbArrondi))
        +separateur+e.FormatCurrSansDevise(Arrondi(tot4,nbArrondi))
          +separateur+e.FormatCurrSansDevise(Arrondi(dif,nbArrondi))+separateur+e.FormatCurrSansDevise(pg));
        rempliColonneMontant(tot1,tot2,tot1,tot4,-1,'',0,separateur,0,true); //initialisation
     end;

     
  if(not empty(soustitre))and(not str_commence_par(soustitre,'@'))then
     begin
     dif:=totSSTitre1-totSSTitre2-totSSTitre4;
     if(totSSTitre4<>0)then pg:=Arrondi((dif*100)/abs(totSSTitre4),2) else pg:=0;
        ListeValeur.Add('3'+separateur+separateur+' @'+soustitre+separateur+e.FormatCurrSansDevise(Arrondi(totSSTitre1-totSSTitre2,nbArrondi))
        +separateur+e.FormatCurrSansDevise(Arrondi(totSSTitre4,nbArrondi))
          +separateur+e.FormatCurrSansDevise(Arrondi(dif,nbArrondi))+separateur+e.FormatCurrSansDevise(pg));
        rempliColonneMontant(totSSTitre1,totSSTitre2,totSSTitre1,totSSTitre4,-1,'',0,separateur,0,true); //initialisation
     end;


     //coupure
     if(not empty(titre))then
     begin
     dif:=totTitre1-totTitre2-totTitre4;
     if(totTitre4<>0)then pg:=Arrondi((dif*100)/abs(totTitre4),2)else pg:=0;
         ListeValeur.Add('1'+separateur+separateur+' @'+titre+separateur+e.FormatCurrSansDevise(Arrondi(totTitre1-totTitre2,nbArrondi))
         +separateur+e.FormatCurrSansDevise(Arrondi(totTitre4,nbArrondi))
         +separateur+e.FormatCurrSansDevise(Arrondi(dif,nbArrondi))+separateur+e.FormatCurrSansDevise(pg));
         rempliColonneMontant(totTitre1,totTitre2,totTitre3,totTitre4,-1,'',0,separateur,0,true); //initialisation
     end;
     dif:=totGen1-totGen2-totGen4;
     if(totGen4<>0)then pg:=Arrondi((dif*100)/abs(totGen4),2)else pg:=0;
      ListeValeur.Add('4'+separateur+separateur+'@TOTAL GENERAL'
      +separateur+e.FormatCurrSansDevise(Arrondi(totGen1-totGen2,nbArrondi))+separateur+e.FormatCurrSansDevise(Arrondi(totGen4,nbArrondi))
           +separateur+e.FormatCurrSansDevise(Arrondi(dif,nbArrondi))
           +separateur+e.FormatCurrSansDevise(pg));

end;


function TEditionFin_Bic.DetailGeneral():Tstringlist;
var
i,j:integer;
Debit,Credit:Currency;
libelle,numFeuille,titre,soustitre:string;                                // ,listeCompte2153
listeCompte2150,listeCompte2151,listeCompte2152:TStringList;
begin
 try
 listeCompte2150:=TStringList.create;
 listeCompte2151:=TStringList.create;
 listeCompte2152:=TStringList.create;
 //listeCompte2153:=TStringList.create;
    Screen.Cursor := crSQLWait;
    if DMRepart = nil then DMRepart:=TDMRepart.Create(Application.MainForm);
    liste_cellule(DMDiocEtatBal.TaBalanceCalc,DMRepart.Repartition_Bic,E.Regime);
    SommeCellule_Bic(nil);

     begin
       numFeuille:='2150';
       DMLiasseFisc.InitTableSurNumLiasse_Bic(numFeuille);
       i:=1;
       DMLiasseFisc.QuParamLia.First;

       while not DMLiasseFisc.QuParamLia.EOF do
         begin
    //     if i = 27 then showmessage('top');
           libelle:=DMLiasseFisc.QuParamLia.FindField('Libelle').AsString;
            titre:=  DMLiasseFisc.QuParamLia.FindField('titre').AsString;
           soustitre:=  DMLiasseFisc.QuParamLia.FindField('soustitre').AsString;

           if(not str_commence_par(LowerCase(soustitre),'*'))then
           begin
           // Colonne 2
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col3').AsString);
           if j <> -1 then
             begin
               TRepartition(DMRepart.ListeCell.Objects[j]).libelleBilan:=libelle;
                TRepartition(DMRepart.ListeCell.Objects[j]).titre:=titre;
                 TRepartition(DMRepart.ListeCell.Objects[j]).soustitre:=soustitre;
               TRepartition(DMRepart.ListeCell.Objects[j]).colBilan:='1';
               TRepartition(DMRepart.ListeCell.Objects[j]).cellule:=DMRepart.ListeCell.Strings[j];
               TRepartition(DMRepart.ListeCell.Objects[j]).Feuille:=numFeuille;
               listeCompte2150.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
             end;

           // Colonne 4
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col5').AsString);
           if j <> -1 then
             begin
               TRepartition(DMRepart.ListeCell.Objects[j]).libelleBilan:=libelle;
                               TRepartition(DMRepart.ListeCell.Objects[j]).titre:=titre;
                 TRepartition(DMRepart.ListeCell.Objects[j]).soustitre:=soustitre;
               TRepartition(DMRepart.ListeCell.Objects[j]).colBilan:='2';
               TRepartition(DMRepart.ListeCell.Objects[j]).Feuille:=numFeuille;
               TRepartition(DMRepart.ListeCell.Objects[j]).cellule:=DMRepart.ListeCell.Strings[j];
               listeCompte2150.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
             end;

           // Colonne 5
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col6').AsString);
           if j <> -1 then
             begin
               TRepartition(DMRepart.ListeCell.Objects[j]).libelleBilan:=libelle;
                               TRepartition(DMRepart.ListeCell.Objects[j]).titre:=titre;
                 TRepartition(DMRepart.ListeCell.Objects[j]).soustitre:=soustitre;
               TRepartition(DMRepart.ListeCell.Objects[j]).colBilan:='3';
               TRepartition(DMRepart.ListeCell.Objects[j]).Feuille:=numFeuille;
               TRepartition(DMRepart.ListeCell.Objects[j]).cellule:=DMRepart.ListeCell.Strings[j];
               listeCompte2150.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
             end;

           // Colonne 6
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col7').AsString);
           if j <> -1 then
             begin
               TRepartition(DMRepart.ListeCell.Objects[j]).libelleBilan:=libelle;
                               TRepartition(DMRepart.ListeCell.Objects[j]).titre:=titre;
                 TRepartition(DMRepart.ListeCell.Objects[j]).soustitre:=soustitre;
               TRepartition(DMRepart.ListeCell.Objects[j]).colBilan:='4';
               TRepartition(DMRepart.ListeCell.Objects[j]).Feuille:=numFeuille;
               TRepartition(DMRepart.ListeCell.Objects[j]).cellule:=DMRepart.ListeCell.Strings[j];
               listeCompte2150.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
             end;
           end;
           DMLiasseFisc.QuParamLia.Next;
           inc(i);
         end;
       DefiltrageDataSet(DMRech.TaPlanCptRech);
       filtrageDataSet(DMRech.TaBalanceRech,'Compte < 6');
     end;

    //if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2145' then
     begin
       numFeuille:='2151';
       DMLiasseFisc.InitTableSurNumLiasse_Bic(numFeuille);
//       DMLiasseFisc.InitTableSurNumLiasse('2145');
       i:=1;

       DMLiasseFisc.QuParamLia.First;

       while not DMLiasseFisc.QuParamLia.EOF do
         begin
           titre:=  DMLiasseFisc.QuParamLia.FindField('titre').AsString;
           soustitre:=  DMLiasseFisc.QuParamLia.FindField('soustitre').AsString;
           libelle:=DMLiasseFisc.QuParamLia.FindField('Libelle').AsString;
           if(not str_commence_par(LowerCase(soustitre),'*'))then
           begin
           if i = 1 then
            begin
             j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col2').AsString);
             if j <> -1 then
               begin
                 TRepartition(DMRepart.ListeCell.Objects[j]).libelleBilan:=libelle;
                                 TRepartition(DMRepart.ListeCell.Objects[j]).titre:=titre;
                 TRepartition(DMRepart.ListeCell.Objects[j]).soustitre:=soustitre;
                 TRepartition(DMRepart.ListeCell.Objects[j]).colBilan:='0';
                 TRepartition(DMRepart.ListeCell.Objects[j]).Feuille:=numFeuille;
                 TRepartition(DMRepart.ListeCell.Objects[j]).cellule:=DMRepart.ListeCell.Strings[j];
                 listeCompte2151.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
               end;
            end;


           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col4').AsString);
           if j <> -1 then
             begin
               TRepartition(DMRepart.ListeCell.Objects[j]).libelleBilan:=libelle;
                               TRepartition(DMRepart.ListeCell.Objects[j]).titre:=titre;
                 TRepartition(DMRepart.ListeCell.Objects[j]).soustitre:=soustitre;
               TRepartition(DMRepart.ListeCell.Objects[j]).colBilan:='1';
               TRepartition(DMRepart.ListeCell.Objects[j]).Feuille:=numFeuille;
               TRepartition(DMRepart.ListeCell.Objects[j]).cellule:=DMRepart.ListeCell.Strings[j];
               listeCompte2151.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
             end;

           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col5').AsString);
           if j <> -1 then
             begin
               TRepartition(DMRepart.ListeCell.Objects[j]).libelleBilan:=libelle;
                               TRepartition(DMRepart.ListeCell.Objects[j]).titre:=titre;
                 TRepartition(DMRepart.ListeCell.Objects[j]).soustitre:=soustitre;
               TRepartition(DMRepart.ListeCell.Objects[j]).colBilan:='4';
               TRepartition(DMRepart.ListeCell.Objects[j]).Feuille:=numFeuille;
               TRepartition(DMRepart.ListeCell.Objects[j]).cellule:=DMRepart.ListeCell.Strings[j];
               listeCompte2151.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
             end;
           end;
           DMLiasseFisc.QuParamLia.Next;
           inc(i);
         end;
       DefiltrageDataSet(DMRech.TaPlanCptRech);
       filtrageDataSet(DMRech.TaBalanceRech,'Compte < 6');
     end;


     begin
      filtrageDataSet(DMRech.TaBalanceRech,'Compte >= 6');

       numFeuille:='2152';
       DMLiasseFisc.InitTableSurNumLiasse_Bic(numFeuille);


       i:=1;
       DMLiasseFisc.QuParamLia.First;

       while not DMLiasseFisc.QuParamLia.EOF do
         begin
    //     if i = 27 then showmessage('top');
           libelle:=DMLiasseFisc.QuParamLia.FindField('Libelle').AsString;
           titre:=  DMLiasseFisc.QuParamLia.FindField('titre').AsString;
           soustitre:=  DMLiasseFisc.QuParamLia.FindField('soustitre').AsString;
           if(not str_commence_par(LowerCase(soustitre),'*'))then
           begin

           if i < 6 then
            begin
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col2').AsString);
           if j <> -1 then
             begin
               TRepartition(DMRepart.ListeCell.Objects[j]).libelleBilan:=libelle;
                               TRepartition(DMRepart.ListeCell.Objects[j]).titre:=titre;
                 TRepartition(DMRepart.ListeCell.Objects[j]).soustitre:=soustitre;
               TRepartition(DMRepart.ListeCell.Objects[j]).colBilan:='-1';
               TRepartition(DMRepart.ListeCell.Objects[j]).Feuille:=numFeuille;
               TRepartition(DMRepart.ListeCell.Objects[j]).cellule:=DMRepart.ListeCell.Strings[j];
               listeCompte2152.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
             end;
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col4').AsString);
           if j <> -1 then
             begin
               TRepartition(DMRepart.ListeCell.Objects[j]).libelleBilan:=libelle;
               TRepartition(DMRepart.ListeCell.Objects[j]).colBilan:='-2';
                               TRepartition(DMRepart.ListeCell.Objects[j]).titre:=titre;
                 TRepartition(DMRepart.ListeCell.Objects[j]).soustitre:=soustitre;
               TRepartition(DMRepart.ListeCell.Objects[j]).Feuille:=numFeuille;
               TRepartition(DMRepart.ListeCell.Objects[j]).cellule:=DMRepart.ListeCell.Strings[j];
               listeCompte2152.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
             end;

            end;


           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col6').AsString);
           if j <> -1 then
             begin
               TRepartition(DMRepart.ListeCell.Objects[j]).libelleBilan:=libelle;
                               TRepartition(DMRepart.ListeCell.Objects[j]).titre:=titre;
                 TRepartition(DMRepart.ListeCell.Objects[j]).soustitre:=soustitre;
               TRepartition(DMRepart.ListeCell.Objects[j]).colBilan:='1';
               TRepartition(DMRepart.ListeCell.Objects[j]).Feuille:=numFeuille;
               TRepartition(DMRepart.ListeCell.Objects[j]).cellule:=DMRepart.ListeCell.Strings[j];
               listeCompte2152.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
             end;

           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col7').AsString);
           if j <> -1 then
             begin
               TRepartition(DMRepart.ListeCell.Objects[j]).libelleBilan:=libelle;
                               TRepartition(DMRepart.ListeCell.Objects[j]).titre:=titre;
                 TRepartition(DMRepart.ListeCell.Objects[j]).soustitre:=soustitre;
               TRepartition(DMRepart.ListeCell.Objects[j]).colBilan:='4';
               TRepartition(DMRepart.ListeCell.Objects[j]).Feuille:=numFeuille;
               TRepartition(DMRepart.ListeCell.Objects[j]).cellule:=DMRepart.ListeCell.Strings[j];
               listeCompte2152.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
             end;
           end;
           DMLiasseFisc.QuParamLia.Next;
           inc(i);
         end;
     end;

     begin
       filtrageDataSet(DMRech.TaBalanceRech,'Compte >= 6');
       numFeuille:='2153';
       DMLiasseFisc.InitTableSurNumLiasse_Bic(numFeuille);

       i:=1;
       DMLiasseFisc.QuParamLia.First;

       while not DMLiasseFisc.QuParamLia.EOF do
         begin
    //     if i = 27 then showmessage('top');
           libelle:=DMLiasseFisc.QuParamLia.FindField('Libelle').AsString;

           titre:=  DMLiasseFisc.QuParamLia.FindField('titre').AsString;
           soustitre:=  DMLiasseFisc.QuParamLia.FindField('soustitre').AsString;
           if(not str_commence_par(LowerCase(soustitre),'*'))then
           begin
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col7').AsString);
           if j <> -1 then
             begin
               TRepartition(DMRepart.ListeCell.Objects[j]).libelleBilan:=libelle;
               TRepartition(DMRepart.ListeCell.Objects[j]).titre:=titre;
               TRepartition(DMRepart.ListeCell.Objects[j]).soustitre:=soustitre;
               TRepartition(DMRepart.ListeCell.Objects[j]).colBilan:='1';
               TRepartition(DMRepart.ListeCell.Objects[j]).Feuille:=numFeuille;
               TRepartition(DMRepart.ListeCell.Objects[j]).cellule:=DMRepart.ListeCell.Strings[j];
               listeCompte2152.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
             end;

           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col8').AsString);
           if j <> -1 then
             begin
               TRepartition(DMRepart.ListeCell.Objects[j]).libelleBilan:=libelle;
               TRepartition(DMRepart.ListeCell.Objects[j]).titre:=titre;
               TRepartition(DMRepart.ListeCell.Objects[j]).soustitre:=soustitre;
               TRepartition(DMRepart.ListeCell.Objects[j]).colBilan:='4';
               TRepartition(DMRepart.ListeCell.Objects[j]).Feuille:=numFeuille;
               TRepartition(DMRepart.ListeCell.Objects[j]).cellule:=DMRepart.ListeCell.Strings[j];
               listeCompte2152.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
             end;
           end;
           DMLiasseFisc.QuParamLia.Next;
           inc(i);
         end;

       DefiltrageDataSet(DMRech.TaPlanCptRech);
     end;
    DefiltrageDataSet(DMRech.TaBalanceRech);
 Finally
  Screen.Cursor := crDefault;
  DetailGeneral:=Tstringlist.Create;
  DetailGeneral.AddObject('2150',listeCompte2150);
  DetailGeneral.AddObject('2151',listeCompte2151);
  DetailGeneral.AddObject('2152',listeCompte2152);
  //DetailGeneral.AddObject('2153',listeCompte2153);
 end;
end;





procedure TEditionFin_Bic.PaBtnResize(Sender: TObject);
var
Boutton:array[1..7] of TControl ;
LargeurBoutton:integer;
HauteurBoutton:integer;
i:integer;
begin
//FormateTailleBoutton([BtnCalculer,BtnModifier,BtnImprimerDetail,BtnFermer,BtnImprimer,BtnDetail,BtnEditionRepartition],PaBtn,110,0);
boutton[1]:=BtnCalculer;
boutton[2]:=BtnModifier;
boutton[3]:=BtnImprimerDetail;
boutton[4]:=BtnFermer;
boutton[5]:=BtnImprimer;
boutton[6]:=BtnDetail;
boutton[7]:=BtnEditionRepartition;
LargeurBoutton:=110;
HauteurBoutton:=0;

Boutton[1].Cursor:=crHandPoint;

Boutton[1].Left:=((PaBtn.Width-((High(Boutton)+1)*LargeurBoutton)) div 2)+30;
if Boutton[1].ClassNameIs('TButton') then LargeurBoutton:=LargeurBoutton-1;

Boutton[1].Width:=LargeurBoutton;
if HauteurBoutton > 0 then
   Boutton[1].Height:=HauteurBoutton
   else
   if HauteurBoutton < 0 then
   Boutton[1].Top:=-HauteurBoutton;
For I := 2 to High(Boutton) do
    begin
     if(Boutton[I]=BtnEditionRepartition)then Boutton[I].Width:=160 else Boutton[I].Width:=110;
     Boutton[I].Cursor:=crHandPoint;
//     Boutton[I].Width:=LargeurBoutton;
     Boutton[I].Left:=Boutton[1].Left + ((LargeurBoutton) *(I-1));
     if HauteurBoutton > 0 then
        Boutton[I].Height:=HauteurBoutton
        else
        if HauteurBoutton < 0 then
             Boutton[I].Top:=-HauteurBoutton;
    end;
end;

function copyFichierAvantUtilisation(nomFichierOrigine, repertoireOrigine :String):string;
var
nomProvisoire,extensionProvisoire:String;
begin
//faire une copie du fichier original avant de le remplir
extensionProvisoire :=ExtractFileExt(nomFichierOrigine);
nomProvisoire:= str_souschaine(nomFichierOrigine,1,length(nomFichierOrigine)-length(extensionProvisoire));
nomProvisoire:= nomProvisoire+' TRAVAIL'+extensionProvisoire;
CopyFile(PChar(repertoireOrigine+nomFichierOrigine),PChar(repertoireOrigine+nomProvisoire), False);
result:= nomProvisoire;
end;


end.

