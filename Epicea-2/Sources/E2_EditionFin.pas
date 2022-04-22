unit E2_EditionFin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, GrGrid, ExtCtrls, ComCtrls,
  Db, DBTables,LibSQL,E2_Librairie_Obj,E2_Decl_records,Gr_Librairie_Obj,
  LibDates,
  LibFichRep,TStringlistLGR,
  LibZoneSaisie,DMConstantes,ShellApi, DBGrids, LibGestionParamXML, Menus,
  Buttons, DBCtrls,ObjetEdition, dbcgrids, Mask, RXCtrls,DMRepartition;

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
  TEditionFin = class(TForm)
    PCLiasseFiscale: TPageControl;
    TbShDoc2144: TTabSheet;
    PaGrGrandLivre: TPanel;
    GrBilanActif: TGrGrid;
    PaMouv: TPanel;
    TbShDoc2145: TTabSheet;
    PaGrilleBilanPassif: TPanel;
    GrBilanPassif: TGrGrid;
    PaBtn: TPanel;
    BtnCalculer: TButton;
    BtnModifier: TButton;
    BtnImprimerDetail: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    BtnDetail: TButton;
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
    TbShDoc2146: TTabSheet;
    Panel4: TPanel;
    GrCptResultat: TGrGrid;
    Panel5: TPanel;
    TbShDoc21462: TTabSheet;
    Panel6: TPanel;
    GrCptResultatBis: TGrGrid;
    Panel7: TPanel;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    RxSBDetailPointage: TRxSpeedButton;
    CBEditionCentime: TCheckBox;
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
  EditionFin: TEditionFin;

  function retrouveLigne(ListeValeur:Tstringlist;repere:string;separateur:char):integer;
  //function retrouveLibelle(ListeValeur:Tstringlist;repere:string;separateur:char):integer;
 procedure rempliColonneMontant(var Col1,Col2,Col3,Col4 : currency ; Colonne:integer ; ligne:string
   ;montantAAffecter:currency;separateur:char;arrondi_in:integer=2;initialise:boolean=true);
  function rechercheSiMontantRempli(Repartition:TRepartition):boolean;

  procedure rempliEditionListe(listeComptesIn:Tstringlist;Var ListeValeur : Tstringlist ; separateur : char);
    function rempliListeAvantEdition(listeComptesIn:Tstringlist ; separateur : char) : Tstringlist;
   function copyFichierAvantUtilisation(nomFichierOrigine, repertoireOrigine :String):string;
   function CustomSortCompteProcAsc(List: TStringlist; Index1, Index2: Integer): Integer;
implementation



uses DMRecherche, DMLiasseFiscale, DMPlanCpt, DMDiocEtatBalance,
  UBilanActif, UBilanPassif,
  //E2_VisuEditFisc
   lib_chaine, DMProgramme, E2_LibInfosTable;

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

procedure TEditionFin.BtnCalculerClick(Sender: TObject);
var
i,j:integer;
Debit,Credit:Currency;
begin
 try
    Screen.Cursor := crSQLWait;
    if DMRepart = nil then DMRepart:=TDMRepart.Create(Application.MainForm);
    //DMDiocEtatBal.TaBalanceaffich.Refresh;
//    DMDiocEtatBal.SommeTotauxBalanceCalc(E.DatExoDebut,E.DatExoFin,nil,'Compte');
    liste_cellule(DMDiocEtatBal.TaBalanceCalc,DMRepart.Repartition,E.Regime);
    SommeCellule(nil);

    // Remplissage de la grille

    //if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2144' then
     begin
       DMLiasseFisc.InitTableSurNumLiasse('2144');
    //   GrDBGridTmp:=GrBilanActif;
       GrBilanActif.RowCount := DMLiasseFisc.QuParamLia.RecordCount+1;// 38;
       i:=1;
       DMLiasseFisc.QuParamLia.First;

       while not DMLiasseFisc.QuParamLia.EOF do
         begin
    //     if i = 27 then showmessage('top');
           GrBilanActif.Cells[0,i]:=DMLiasseFisc.QuParamLia.FindField('Libelle').AsString;
           GrBilanActif.Cells[1,i]:=DMLiasseFisc.QuParamLia.FindField('Col1').AsString;
    //       GrBilanActif.Cells[2,i]:='0'+DecimalSeparator+'00';
           GrBilanActif.Cells[3,i]:=DMLiasseFisc.QuParamLia.FindField('Col3').AsString;

           // Colonne 2
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col2').AsString);
           if j <> -1 then
             begin
//               GrBilanActif.Cells[2,i]:=FormatCurr(E.EditFormat,TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrBilanActif.Cells[2,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrBilanActif.Objects[2,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;

           // Colonne 4
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col4').AsString);
           if j <> -1 then
             begin
               GrBilanActif.Cells[4,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrBilanActif.Objects[4,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;

           // Colonne 5
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col5').AsString);
           if j <> -1 then
             begin
               GrBilanActif.Cells[5,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrBilanActif.Objects[5,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;

           // Colonne 6
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col6').AsString);
           if j <> -1 then
             begin
               GrBilanActif.Cells[6,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrBilanActif.Objects[6,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;

           DMLiasseFisc.QuParamLia.Next;
           inc(i);
         end;
       DefiltrageDataSet(DMRech.TaPlanCptRech);
       filtrageDataSet(DMRech.TaBalanceRech,'Compte < 6');
     end;

    //if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2145' then
     begin
       DMLiasseFisc.InitTableSurNumLiasse('2145');
       GrBilanPassif.RowCount := DMLiasseFisc.QuParamLia.RecordCount+1;//34;
       i:=1;

       DMLiasseFisc.QuParamLia.First;

       while not DMLiasseFisc.QuParamLia.EOF do
         begin

           GrBilanPassif.Cells[0,i]:=DMLiasseFisc.QuParamLia.FindField('Libelle').AsString;
           if i = 1 then
            begin
             j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col1').AsString);
             if j <> -1 then
               begin
                 GrBilanPassif.Cells[1,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
                 GrBilanPassif.Objects[1,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
               end;
            end;

//            ////////////// Calcul du resultat
//           if i = 8 then
//            begin
//              DMDiocEtatBal.ResultatExercice(Debit,Credit,E.DatExoDebut,E.DatExoFin);
//              GrBilanPassif.Cells[3,i]:=E.FormatCurr(Debit+Credit);
//            end;

           GrBilanPassif.Cells[2,i]:=DMLiasseFisc.QuParamLia.FindField('Col2').AsString;

           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col3').AsString);
           if j <> -1 then
             begin
               GrBilanPassif.Cells[3,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrBilanPassif.Objects[3,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;

           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col4').AsString);
           if j <> -1 then
             begin
               GrBilanPassif.Cells[4,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrBilanPassif.Objects[4,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;
    //       for j:=4 to 4 do
    //               GrBilanPassif.Cells[j,i]:='0'+DecimalSeparator+'00';
           DMLiasseFisc.QuParamLia.Next;
           inc(i);
         end;
       DefiltrageDataSet(DMRech.TaPlanCptRech);
       filtrageDataSet(DMRech.TaBalanceRech,'Compte < 6');
     end;

    //if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2146' then
     begin
      filtrageDataSet(DMRech.TaBalanceRech,'Compte >= 6');
       DMLiasseFisc.InitTableSurNumLiasse('2146');
       GrCptResultat.RowCount := DMLiasseFisc.QuParamLia.RecordCount+1;//41;
       i:=1;
       DMLiasseFisc.QuParamLia.First;

       while not DMLiasseFisc.QuParamLia.EOF do
         begin
    //     if i = 27 then showmessage('top');
           GrCptResultat.Cells[0,i]:=DMLiasseFisc.QuParamLia.FindField('Libelle').AsString;
           GrCptResultat.Cells[1,i]:=DMLiasseFisc.QuParamLia.FindField('Col1').AsString;
           if i < 6 then
            begin
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col2').AsString);
           if j <> -1 then
             begin
               GrCptResultat.Cells[2,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrCptResultat.Objects[2,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col4').AsString);
           if j <> -1 then
             begin
               GrCptResultat.Cells[4,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrCptResultat.Objects[4,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;
    //         GrCptResultat.Cells[2,i]:='0'+DecimalSeparator+'00';
    //         GrCptResultat.Cells[4,i]:='0'+DecimalSeparator+'00';
            end;
           GrCptResultat.Cells[3,i]:=DMLiasseFisc.QuParamLia.FindField('Col3').AsString;
           GrCptResultat.Cells[5,i]:=DMLiasseFisc.QuParamLia.FindField('Col5').AsString;

           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col6').AsString);
           if j <> -1 then
             begin
               GrCptResultat.Cells[6,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrCptResultat.Objects[6,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;

           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col7').AsString);
           if j <> -1 then
             begin
               GrCptResultat.Cells[7,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrCptResultat.Objects[7,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;
    //       GrCptResultat.Cells[6,i]:='0'+DecimalSeparator+'00';
    //       GrCptResultat.Cells[7,i]:='0'+DecimalSeparator+'00';
    //       j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col2').AsString);
    //       if j <> -1 then
    //         begin
    //           GrBilanActif.Cells[2,i]:=FormatCurr(E.EditFormat,TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
    //           GrBilanActif.Objects[2,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
    //         end;
    //       for j:=4 to 6 do
    //               GrBilanActif.Cells[j,i]:='0'+DecimalSeparator+'00';
           DMLiasseFisc.QuParamLia.Next;
           inc(i);
         end;
     end;

    //if PCLiasseFiscale.ActivePage.Name = 'TbShDoc21462' then
     begin
       filtrageDataSet(DMRech.TaBalanceRech,'Compte >= 6');
       DMLiasseFisc.InitTableSurNumLiasse('21462');
    //   GrDBGridTmp:=GrCptResultat;
       GrCptResultatBis.RowCount := DMLiasseFisc.QuParamLia.RecordCount+1;//41;
       i:=1;
       DMLiasseFisc.QuParamLia.First;

       while not DMLiasseFisc.QuParamLia.EOF do
         begin
    //     if i = 27 then showmessage('top');
           GrCptResultatBis.Cells[0,i]:=DMLiasseFisc.QuParamLia.FindField('Libelle').AsString;
           GrCptResultatBis.Cells[1,i]:=DMLiasseFisc.QuParamLia.FindField('Col1').AsString;

           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col2').AsString);
           if j <> -1 then
             begin
               GrCptResultatBis.Cells[2,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrCptResultatBis.Objects[2,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col3').AsString);
           if j <> -1 then
             begin
               GrCptResultatBis.Cells[3,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrCptResultatBis.Objects[3,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;

           DMLiasseFisc.QuParamLia.Next;
           inc(i);
         end;

       DefiltrageDataSet(DMRech.TaPlanCptRech);
     end;
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

procedure TEditionFin.FormActivate(Sender: TObject);
var
k:Integer;
begin
if DMRepart=nil then DMRepart:=TDMRepart.Create(application.MainForm);
for k:=0 to GrBilanActif.rowcount-1 do
  GrBilanActif.rows[k].clear;
GrBilanActif.Cells[1,0] := '';
GrBilanActif.Cells[2,0] := 'Brut';
GrBilanActif.Cells[4,0] := 'Amort. Prov.';
GrBilanActif.Cells[5,0] := 'Net N';
GrBilanActif.Cells[6,0] := 'Net N-1';
GrBilanActif.ParamColor:=true;
GrBilanActif.Param:=ParamUtil.CouleurDBGrid;
GrBilanActif.DessineContourLigne:=false;
GrBilanActif.UpDateColor;
GrBilanActif.JustifieChampCurr :=true;

// GrBilanPassif : Bilan Passif 2145
for k:=0 to GrBilanPassif.rowcount-1 do
  GrBilanPassif.rows[k].clear;
GrBilanPassif.Cells[1,0] := '';
GrBilanPassif.Cells[3,0] := 'Exercice N';
GrBilanPassif.Cells[4,0] := 'Exercice N-1';
GrBilanPassif.ParamColor:=true;
GrBilanPassif.Param:=ParamUtil.CouleurDBGrid;
GrBilanPassif.DessineContourLigne:=false;
GrBilanPassif.UpDateColor;


// GrCptResultat : Compte Résultat 2146
for k:=0 to GrCptResultat.rowcount-1 do
  GrCptResultat.rows[k].clear;
GrCptResultat.Cells[1,0] := '';
GrCptResultat.Cells[2,0] := 'France ';
GrCptResultat.Cells[4,0] := 'Export. ';
GrCptResultat.Cells[6,0] := 'TOTAL ';
GrCptResultat.Cells[7,0] := 'N-1 ';
GrCptResultat.ParamColor:=true;
GrCptResultat.Param:=ParamUtil.CouleurDBGrid;
GrCptResultat.DessineContourLigne:=false;
GrCptResultat.UpDateColor;

// GrCptResultatBis : Compte Résultat 21462
for k:=0 to GrCptResultatBis.rowcount-1 do
  GrCptResultatBis.rows[k].clear;
GrCptResultatBis.Cells[1,0] := '';
GrCptResultatBis.Cells[2,0] := 'Exercice N';
GrCptResultatBis.Cells[3,0] := 'Exercice N-1';
GrCptResultatBis.ParamColor:=true;
GrCptResultatBis.Param:=ParamUtil.CouleurDBGrid;
GrCptResultatBis.DessineContourLigne:=false;
GrCptResultatBis.UpDateColor;

EditionFin.PCLiasseFiscaleChange(nil);
PaBtnResize(PaBtn);
end;

procedure TEditionFin.FormDestroy(Sender: TObject);
begin
if DMLiasseFisc <> nil then DMLiasseFisc.Free;
LibGestionParamXML.DestroyForm(Self,E.User);
EditionFin:=nil;
end;

procedure TEditionFin.BtnImprimerClick(Sender: TObject);
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
  ListePdf2.Add(' << /V ('+Copy(IntToStr(i),1,1)+') /T (PC_2)>>'); //
  ListePdf2.Add(' << /V ('+Copy(IntToStr(i),2,1)+') /T (PC_1)>>'); //
 end
else
 begin
  ListePdf2.Add(' << /V (0) /T (PC_2)>>'); //
  ListePdf2.Add(' << /V ('+IntToStr(i)+') /T (PC_1)>>'); //
 end;

i := NbMois(ExoNMoins1.DATE_DEB_EXO,ExoNMoins1.DATE_FIN_EXO);
if  i > 9 then
 begin
  ListePdf2.Add(' << /V ('+Copy(IntToStr(i),1,1)+') /T (PCB_2)>>'); //
  ListePdf2.Add(' << /V ('+Copy(IntToStr(i),2,1)+') /T (PCB_1)>>'); //
 end
else
 begin
  ListePdf2.Add(' << /V (0) /T (PCB_2)>>'); //
  ListePdf2.Add(' << /V ('+IntToStr(i)+') /T (PCB_1)>>'); //
 end;

ListePdf2.Add(' << /V ('+str_souschaine(DateToStr_Lgr(e.DatExoFin),1,1)+') /T (RN_ZRL_51_8)>>');
ListePdf2.Add(' << /V ('+str_souschaine(DateToStr_Lgr(e.DatExoFin),2,1)+') /T (RN_ZRL_51_7)>>');
ListePdf2.Add(' << /V ('+str_souschaine(DateToStr_Lgr(e.DatExoFin),4,1)+') /T (RN_ZRL_51_6)>>');
ListePdf2.Add(' << /V ('+str_souschaine(DateToStr_Lgr(e.DatExoFin),5,1)+') /T (RN_ZRL_51_5)>>');
ListePdf2.Add(' << /V ('+str_souschaine(DateToStr_Lgr(e.DatExoFin),7,1)+') /T (RN_ZRL_51_4)>>');
ListePdf2.Add(' << /V ('+str_souschaine(DateToStr_Lgr(e.DatExoFin),8,1)+') /T (RN_ZRL_51_3)>>');
ListePdf2.Add(' << /V ('+str_souschaine(DateToStr_Lgr(e.DatExoFin),9,1)+') /T (RN_ZRL_51_2)>>');
ListePdf2.Add(' << /V ('+str_souschaine(DateToStr_Lgr(e.DatExoFin),10,1)+') /T (RN_ZRL_51_1)>>');

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
  EditionPartBilanActif:
  begin
  //ListePdf2.Add('/F ('+DM_C_NomBilanAGRReel2144+')/ID [ <387aec558f007ac48b5052a725e4afd1><7040395dab48dfebccddc82ce39a75f8>');
  nomProvisoire:= copyFichierAvantUtilisation(DM_C_NomBilanAGRReel2144,E.REpertoireFiscal);
  end;
  EditionPartBilanPassif:
  begin
  //ListePdf2.Add('/F ('+DM_C_NomBilanAGRReel2145+')/ID [ <387aec558f007ac48b5052a725e4afd1><7040395dab48dfebccddc82ce39a75f8>');
  nomProvisoire:= copyFichierAvantUtilisation(DM_C_NomBilanAGRReel2145,E.REpertoireFiscal);
  end;
  EditionPartCptResult1:
  begin
  //ListePdf2.Add('/F ('+DM_C_NomBilanAGRReel2146+')/ID [ <387aec558f007ac48b5052a725e4afd1><7040395dab48dfebccddc82ce39a75f8>');
  nomProvisoire:= copyFichierAvantUtilisation(DM_C_NomBilanAGRReel2146,E.REpertoireFiscal);
  end;
  EditionPartCptResult2:
  begin
  //ListePdf2.Add('/F ('+DM_C_NomBilanAGRReel21462+')/ID [ <387aec558f007ac48b5052a725e4afd1><7040395dab48dfebccddc82ce39a75f8>');
  nomProvisoire:= copyFichierAvantUtilisation(DM_C_NomBilanAGRReel21462,E.REpertoireFiscal);
  end;
 else
 begin
   //ListePdf2.Add('/F ('+DM_C_NomBilanAGRReel+')/ID [ <387aec558f007ac48b5052a725e4afd1><7040395dab48dfebccddc82ce39a75f8>');
   nomProvisoire:= copyFichierAvantUtilisation(DM_C_NomBilanAGRReel,E.REpertoireFiscal);
   end;
 end;


 end;

if Sender = BtnImprimer then
 begin
  //ListePdf2.Add('/F ('+DM_C_NomBilanAGRReel+')/ID [ <387aec558f007ac48b5052a725e4afd1><7040395dab48dfebccddc82ce39a75f8>');
  nomProvisoire:= copyFichierAvantUtilisation(DM_C_NomBilanAGRReel,E.REpertoireFiscal);
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

ListePdf2.SaveToFile(E.REpertoireFiscal+'BILAN AGRICOLE REEL.fdf');
ListePdf2.Free;

if DMRepart.ListeCell.Count > 0 then
 begin
    ShellExecute(handle,nil,PChar('"'+E.REpertoireFiscal+'BILAN AGRICOLE REEL.fdf"'),nil,PChar(E.REpertoireFiscal),SW_SHOWNORMAL);
 end;
end;

procedure TEditionFin.BtnDetailClick(Sender: TObject);
var
i,j:integer;
ExercicePrecedent:Boolean;
begin
//DMDiocEtatBal.SommeTotauxBalanceCalc(E.DatExoDebut,E.DatExoFin,nil,'Compte');
//liste_cellule(DMDiocEtatBal.TaBalanceCalc,DMRepart.Repartition,E.Regime);
//SommeCellule(nil);
if DMRepart.ListeCell<>nil then
  Begin
      if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2144' then
       begin
         if GrBilanActif.col > 0 then
          begin
           DMLiasseFisc.InitTableSurNumLiasse('2144');
           j:=DMRepart.ListeCell.IndexOfObject(TRepartition(GrBilanActif.Objects[GrBilanActif.Col,GrBilanActif.Row]));
           if j <> -1 then
            begin
             ExercicePrecedent:= (GrBilanActif.Col =6); // Indicateur si N-1
             VisuListeCompteDeZoneAffich(DMRepart.ListeCell.Strings[j],ExercicePrecedent);
            end
            else
            ShowMessage('Pas de détail pour cette ligne');
          end;
       end;

      if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2145' then
       begin
         if GrBilanPassif.col > 0 then
          begin
           DMLiasseFisc.InitTableSurNumLiasse('2145');
           j:=DMRepart.ListeCell.IndexOfObject(TRepartition(GrBilanPassif.Objects[GrBilanPassif.Col,GrBilanPassif.Row]));
           if j <> -1 then
            begin
             ExercicePrecedent:= (GrBilanPassif.Col =4); // Indicateur si N-1
             VisuListeCompteDeZoneAffich(DMRepart.ListeCell.Strings[j],ExercicePrecedent);
            end
            else
            ShowMessage('Pas de détail pour cette ligne');
          end;
       end;
      if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2146' then
       begin
         if GrCptResultat.col > 0 then
          begin
           DMLiasseFisc.InitTableSurNumLiasse('2146');
           j:=DMRepart.ListeCell.IndexOfObject(TRepartition(GrCptResultat.Objects[GrCptResultat.Col,GrCptResultat.Row]));
           if j <> -1 then
            begin
             ExercicePrecedent:= (GrCptResultat.Col =7); // Indicateur si N-1
             VisuListeCompteDeZoneAffich(DMRepart.ListeCell.Strings[j],ExercicePrecedent);
            end
            else
            ShowMessage('Pas de détail pour cette ligne');
          end;
       end;

      if PCLiasseFiscale.ActivePage.Name = 'TbShDoc21462' then
       begin
         if GrCptResultatBis.col > 0 then
          begin
           DMLiasseFisc.InitTableSurNumLiasse('21462');
           j:=DMRepart.ListeCell.IndexOfObject(TRepartition(GrCptResultatBis.Objects[GrCptResultatBis.Col,GrCptResultatBis.Row]));
           if j <> -1 then
            begin
             ExercicePrecedent:= (GrCptResultatBis.Col =3); // Indicateur si N-1
             VisuListeCompteDeZoneAffich(DMRepart.ListeCell.Strings[j],ExercicePrecedent);
            end
            else
            ShowMessage('Pas de détail pour cette ligne');
          end;
       end;
  end;//fin si non nil
end;

procedure TEditionFin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
   begin
    Key:= 0;
    Self.Close;
   end;
end;

procedure TEditionFin.BtnAnnulerEnter(Sender: TObject);
begin
  BouttonDiminue(sender as TButton);
end;

procedure TEditionFin.BtnAnnulerExit(Sender: TObject);
begin
  BouttonAgrandit(sender as TButton);
end;

procedure TEditionFin.BtnModifierClick(Sender: TObject);
begin
//if not PaModifZone.Visible then PaModifZone.Visible := true;
end;

procedure TEditionFin.FormCreate(Sender: TObject);
begin
  try
      if DMLiasseFisc = nil then DMLiasseFisc := TDMLiasseFisc.Create(Application.MainForm);
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;


procedure TEditionFin.BtnInsererClick(Sender: TObject);
begin
//if DMRepart = nil then DMRepart:=TDMRepart.Create(Application.MainForm);
//DMRepart.MAJParamLia;
end;


procedure TEditionFin.SBFermerClick(Sender: TObject);
begin
PaModifZone.Visible := false;
end;

procedure TEditionFin.SBEnleverClick(Sender: TObject);
begin
//if REListeCompte.SetTextBuf();
end;

procedure TEditionFin.Panel1Click(Sender: TObject);
begin
//SommeCellule(nil);
end;

procedure TEditionFin.Imprimer1Click(Sender: TObject);
begin
BtnImprimer.Click;
end;

procedure TEditionFin.PCLiasseFiscaleChange(Sender: TObject);
begin
if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2144' then
 Begin
  BtnImprimerDetail.Tag := EditionPartBilanActif;
  BtnImprimerDetail.Caption := TitreBouttonImprimerDetail +'2144';
 End;


if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2145' then
 Begin
  BtnImprimerDetail.Tag := EditionPartBilanPassif;
  BtnImprimerDetail.Caption := TitreBouttonImprimerDetail +'2145';
 End;

if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2146' then
 Begin
  BtnImprimerDetail.Tag := EditionPartCptResult1;
  BtnImprimerDetail.Caption := TitreBouttonImprimerDetail +'2146';
 End;

if PCLiasseFiscale.ActivePage.Name = 'TbShDoc21462' then
 Begin
  BtnImprimerDetail.Tag := EditionPartCptResult2;
  BtnImprimerDetail.Caption := TitreBouttonImprimerDetail +'21462';
 End;
 

end;

procedure TEditionFin.ImprimerDetail1Click(Sender: TObject);
begin
BtnImprimerDetail.Click;
end;

procedure TEditionFin.BtnFermerClick(Sender: TObject);
begin
  self.close;
end;

procedure TEditionFin.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(nil);
end;






function TEditionFin.DetailGeneral():Tstringlist;
var
i,j:integer;
Debit,Credit:Currency;
libelle,numFeuille,titre,soustitre:string;                                // ,listeCompte21462
listeCompte2144,listeCompte2145,listeCompte2146:TStringList;
begin
 try
 listeCompte2144:=TStringList.create;
 listeCompte2145:=TStringList.create;
 listeCompte2146:=TStringList.create;
 //listeCompte21462:=TStringList.create;
    Screen.Cursor := crSQLWait;
    if DMRepart = nil then DMRepart:=TDMRepart.Create(Application.MainForm);
    liste_cellule(DMDiocEtatBal.TaBalanceCalc,DMRepart.Repartition,E.Regime);
    SommeCellule(nil);

     begin
       numFeuille:='2144';
       DMLiasseFisc.InitTableSurNumLiasse(numFeuille);
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
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col2').AsString);
           if j <> -1 then
             begin
               TRepartition(DMRepart.ListeCell.Objects[j]).libelleBilan:=libelle;
                TRepartition(DMRepart.ListeCell.Objects[j]).titre:=titre;
                 TRepartition(DMRepart.ListeCell.Objects[j]).soustitre:=soustitre;
               TRepartition(DMRepart.ListeCell.Objects[j]).colBilan:='1';
               TRepartition(DMRepart.ListeCell.Objects[j]).cellule:=DMRepart.ListeCell.Strings[j];
               TRepartition(DMRepart.ListeCell.Objects[j]).Feuille:=numFeuille;
               listeCompte2144.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
             end;

           // Colonne 4
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col4').AsString);
           if j <> -1 then
             begin
               TRepartition(DMRepart.ListeCell.Objects[j]).libelleBilan:=libelle;
                               TRepartition(DMRepart.ListeCell.Objects[j]).titre:=titre;
                 TRepartition(DMRepart.ListeCell.Objects[j]).soustitre:=soustitre;
               TRepartition(DMRepart.ListeCell.Objects[j]).colBilan:='2';
               TRepartition(DMRepart.ListeCell.Objects[j]).Feuille:=numFeuille;
               TRepartition(DMRepart.ListeCell.Objects[j]).cellule:=DMRepart.ListeCell.Strings[j];
               listeCompte2144.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
             end;

           // Colonne 5
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col5').AsString);
           if j <> -1 then
             begin
               TRepartition(DMRepart.ListeCell.Objects[j]).libelleBilan:=libelle;
                               TRepartition(DMRepart.ListeCell.Objects[j]).titre:=titre;
                 TRepartition(DMRepart.ListeCell.Objects[j]).soustitre:=soustitre;
               TRepartition(DMRepart.ListeCell.Objects[j]).colBilan:='3';
               TRepartition(DMRepart.ListeCell.Objects[j]).Feuille:=numFeuille;
               TRepartition(DMRepart.ListeCell.Objects[j]).cellule:=DMRepart.ListeCell.Strings[j];
               listeCompte2144.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
             end;

           // Colonne 6
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col6').AsString);
           if j <> -1 then
             begin
               TRepartition(DMRepart.ListeCell.Objects[j]).libelleBilan:=libelle;
                               TRepartition(DMRepart.ListeCell.Objects[j]).titre:=titre;
                 TRepartition(DMRepart.ListeCell.Objects[j]).soustitre:=soustitre;
               TRepartition(DMRepart.ListeCell.Objects[j]).colBilan:='4';
               TRepartition(DMRepart.ListeCell.Objects[j]).Feuille:=numFeuille;
               TRepartition(DMRepart.ListeCell.Objects[j]).cellule:=DMRepart.ListeCell.Strings[j];
               listeCompte2144.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
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
       numFeuille:='2145';
       DMLiasseFisc.InitTableSurNumLiasse(numFeuille);
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
             j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col1').AsString);
             if j <> -1 then
               begin
                 TRepartition(DMRepart.ListeCell.Objects[j]).libelleBilan:=libelle;
                                 TRepartition(DMRepart.ListeCell.Objects[j]).titre:=titre;
                 TRepartition(DMRepart.ListeCell.Objects[j]).soustitre:=soustitre;
                 TRepartition(DMRepart.ListeCell.Objects[j]).colBilan:='0';
                 TRepartition(DMRepart.ListeCell.Objects[j]).Feuille:=numFeuille;
                 TRepartition(DMRepart.ListeCell.Objects[j]).cellule:=DMRepart.ListeCell.Strings[j];
                 listeCompte2145.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
               end;
            end;


           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col3').AsString);
           if j <> -1 then
             begin
               TRepartition(DMRepart.ListeCell.Objects[j]).libelleBilan:=libelle;
                               TRepartition(DMRepart.ListeCell.Objects[j]).titre:=titre;
                 TRepartition(DMRepart.ListeCell.Objects[j]).soustitre:=soustitre;
               TRepartition(DMRepart.ListeCell.Objects[j]).colBilan:='1';
               TRepartition(DMRepart.ListeCell.Objects[j]).Feuille:=numFeuille;
               TRepartition(DMRepart.ListeCell.Objects[j]).cellule:=DMRepart.ListeCell.Strings[j];
               listeCompte2145.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
             end;

           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col4').AsString);
           if j <> -1 then
             begin
               TRepartition(DMRepart.ListeCell.Objects[j]).libelleBilan:=libelle;
                               TRepartition(DMRepart.ListeCell.Objects[j]).titre:=titre;
                 TRepartition(DMRepart.ListeCell.Objects[j]).soustitre:=soustitre;
               TRepartition(DMRepart.ListeCell.Objects[j]).colBilan:='4';
               TRepartition(DMRepart.ListeCell.Objects[j]).Feuille:=numFeuille;
               TRepartition(DMRepart.ListeCell.Objects[j]).cellule:=DMRepart.ListeCell.Strings[j];
               listeCompte2145.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
             end;
           end;
           DMLiasseFisc.QuParamLia.Next;
           inc(i);
         end;
       DefiltrageDataSet(DMRech.TaPlanCptRech);
       filtrageDataSet(DMRech.TaBalanceRech,'Compte < 6');
     end;

    //if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2146' then
     begin
      filtrageDataSet(DMRech.TaBalanceRech,'Compte >= 6');

       numFeuille:='2146';
       DMLiasseFisc.InitTableSurNumLiasse(numFeuille);
       //DMLiasseFisc.InitTableSurNumLiasse('2146');

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
               listeCompte2146.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
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
               listeCompte2146.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
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
               listeCompte2146.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
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
               listeCompte2146.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
             end;
           end;
           DMLiasseFisc.QuParamLia.Next;
           inc(i);
         end;
     end;

     begin
       filtrageDataSet(DMRech.TaBalanceRech,'Compte >= 6');
       numFeuille:='21462';
       DMLiasseFisc.InitTableSurNumLiasse(numFeuille);
       //DMLiasseFisc.InitTableSurNumLiasse('21462');
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

           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col2').AsString);
           if j <> -1 then
             begin
               TRepartition(DMRepart.ListeCell.Objects[j]).libelleBilan:=libelle;
                               TRepartition(DMRepart.ListeCell.Objects[j]).titre:=titre;
                 TRepartition(DMRepart.ListeCell.Objects[j]).soustitre:=soustitre;
               TRepartition(DMRepart.ListeCell.Objects[j]).colBilan:='1';
               TRepartition(DMRepart.ListeCell.Objects[j]).Feuille:=numFeuille;
               TRepartition(DMRepart.ListeCell.Objects[j]).cellule:=DMRepart.ListeCell.Strings[j];
               listeCompte2146.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
             end;
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col3').AsString);
           if j <> -1 then
             begin
               TRepartition(DMRepart.ListeCell.Objects[j]).libelleBilan:=libelle;
                               TRepartition(DMRepart.ListeCell.Objects[j]).titre:=titre;
                 TRepartition(DMRepart.ListeCell.Objects[j]).soustitre:=soustitre;
               TRepartition(DMRepart.ListeCell.Objects[j]).colBilan:='4';
               TRepartition(DMRepart.ListeCell.Objects[j]).Feuille:=numFeuille;
               TRepartition(DMRepart.ListeCell.Objects[j]).cellule:=DMRepart.ListeCell.Strings[j];
               listeCompte2146.AddObject(libelle,TRepartition(DMRepart.ListeCell.Objects[j]));
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
  DetailGeneral.AddObject('2144',listeCompte2144);
  DetailGeneral.AddObject('2145',listeCompte2145);
  DetailGeneral.AddObject('2146',listeCompte2146);
  //DetailGeneral.AddObject('21462',listeCompte21462);
 end;
end;





procedure TEditionFin.BtnEditionRepartitionClick(Sender: TObject);
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


rempliColonneMontant(tot1,tot2,tot3,tot4,-1,'',0,separateur,0,true); //initialisation
rempliColonneMontant(totSSTitre1,totSSTitre2,totSSTitre3,totSSTitre4,-1,'',0,separateur,0,true); //initialisation
rempliColonneMontant(totTitre1,totTitre2,totTitre3,totTitre4,-1,'',0,separateur,0,true); //initialisation
rempliColonneMontant(totGen1,totGen2,totGen3,totGen4,-1,'',0,separateur,0,true); //initialisation
ListeValeur.clear;
     titre:='';
     soustitre:='';
ListeValeur.add('10'+separateur+'DETAIL DU BILAN ACTIF');
listeCompte2144:=rempliListeAvantEdition(listeCompte2144 , separateur);
rempliEditionListe(listeCompte2144,ListeValeur, separateur);
//rempliEditionListe(listeCompte2144,ListeValeur);

ListeValeur.add('20');
ListeValeur.add('10'+separateur+'DETAIL DU BILAN PASSIF');
rempliColonneMontant(tot1,tot2,tot3,tot4,-1,'',0,separateur,0,true); //initialisation
rempliColonneMontant(totSSTitre1,totSSTitre2,totSSTitre3,totSSTitre4,-1,'',0,separateur,0,true); //initialisation
rempliColonneMontant(totTitre1,totTitre2,totTitre3,totTitre4,-1,'',0,separateur,0,true); //initialisation
rempliColonneMontant(totGen1,totGen2,totGen3,totGen4,-1,'',0,separateur,0,true); //initialisation
titre:='';
soustitre:='';
listeCompte2145:=rempliListeAvantEdition(listeCompte2145, separateur);
rempliEditionListe(listeCompte2145,ListeValeur, separateur);
//rempliEditionListe(listeCompte2145,ListeValeur);

ListeValeur.add('20');
ListeValeur.add('10'+separateur+'DETAIL DU COMPTE DE RESULTAT');
rempliColonneMontant(tot1,tot2,tot3,tot4,-1,'',0,separateur,0,true); //initialisation
rempliColonneMontant(totSSTitre1,totSSTitre2,totSSTitre3,totSSTitre4,-1,'',0,separateur,0,true); //initialisation
rempliColonneMontant(totTitre1,totTitre2,totTitre3,totTitre4,-1,'',0,separateur,0,true); //initialisation
rempliColonneMontant(totGen1,totGen2,totGen3,totGen4,-1,'',0,separateur,0,true); //initialisation
titre:='';
soustitre:='';
listeCompte2146:=rempliListeAvantEdition(listeCompte2146, separateur);
rempliEditionListe(listeCompte2146,ListeValeur, separateur);
//rempliEditionListe(listeCompte2146,ListeValeur);
ListeValeur.Delete(ListeValeur.Count-1);//pour enlever le total général final


                   ObjPrn.FTitreEdition := 'EDITION DETAILLE DU BILAN ACTIF, PASSIF ET COMPTE DE RESULTAT';
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
//            if( str_getstringelement(listevaleur.Strings[i],2,separateur)=repere)then
//               retour:=i;
//            inc(i);
//         end;
//     end;
// retrouveLibelle:=retour;
//end;

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
//                    ListeValeur.Add('3'+separateur+separateur+' @'+soustitre+separateur+e.FormatCurrSansDevise(Arrondi(totSSTitre3,0))+separateur+e.FormatCurrSansDevise(Arrondi(totSSTitre4,0))
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
//                     ListeValeur.Add('1'+separateur+separateur+' @'+titre+separateur+e.FormatCurrSansDevise(Arrondi(totTitre3,0))+separateur+e.FormatCurrSansDevise(Arrondi(totTitre4,0))
//                     +separateur+e.FormatCurrSansDevise(Arrondi(totdif,0))+separateur+e.FormatCurrSansDevise(totpg));
//                     rempliColonneMontant(totTitre1,totTitre2,totTitre3,totTitre4,-1,'',0,separateur,0,true); //initialisation
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
//
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
//                       dif:=col3-col4;
//                       if(col4<>0)then pg:=Arrondi((dif*100)/col4,1) else pg:=0;
//                       ListeValeur.Strings[LigneExiste]:=('0'+separateur+libelle+separateur+compte
//                       +separateur+e.FormatCurrSansDevise(col3)
//                       +separateur+e.FormatCurrSansDevise(col4)
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
//                       dif:=col3-col4;
//                       if(col4<>0)then pg:=Arrondi((dif*100)/col4,1) else pg:=0;
//                      ListeValeur.add('0'+separateur+libelle+separateur+compte
//                       +separateur+e.FormatCurrSansDevise(col3)
//                       +separateur+e.FormatCurrSansDevise(col4)
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
//                       dif:=col3-col4;
//                       if(col4<>0)then pg:=Arrondi((dif*100)/col4,1) else pg:=0;
//                       ListeValeur.Strings[LigneExiste]:=(numligne+separateur+libelle+separateur+compte
//                       +separateur+e.FormatCurrSansDevise(col3)
//                       +separateur+e.FormatCurrSansDevise(col4)
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
//                       dif:=col3-col4;
//                       if(col4<>0)then pg:=Arrondi((dif*100)/col4,1) else pg:=0;
//
//                      ListeValeur.Add(numligne+separateur+libelle+separateur+compte
//                      +separateur+e.FormatCurrSansDevise(col3)
//                       +separateur+e.FormatCurrSansDevise(col4)
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
//        rempliColonneMontant(totSSTitre1,totSSTitre2,totSSTitre3,totSSTitre4,-1,'',0,separateur,0,true); //initialisation
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
procedure rempliEditionListe(listeComptesIn:Tstringlist;Var ListeValeur : Tstringlist ; separateur : char);
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
//separateur:char;
numligne:string;
ligne:string;
nbArrondi:integer;
begin
if EditionFin.CBEditionCentime.Checked then nbArrondi:=2 else nbArrondi:=0;
 for i:=0 to listeComptesIn.Count-1 do
  begin
  ligne:=listeComptesIn.Strings[i];

          if(libelle<>str_getstringelement(ligne,2,separateur))and(not str_commence_par(soustitre,'@'))then
             begin
                 //coupure
                 if(not empty(libelle))then
                 begin
                    dif:=tot1-tot2-tot4;
                    pg:=0;
                    if(tot4<>0)then pg:=Arrondi((dif*100)/abs(tot4),2)
                    else if(dif<>0)then pg:=100;
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
                    pg:=0;
                    if(totSSTitre4<>0)then pg:=Arrondi((dif*100)/abs(totSSTitre4),2)
                    else if(dif<>0)then pg:=100;
                    ListeValeur.Add('1'+separateur+separateur+' @'+soustitre+separateur+e.FormatCurrSansDevise(Arrondi(totSSTitre1-totSSTitre2,nbArrondi))
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
                    pg:=0;
                    if(totTitre4<>0)then pg:=Arrondi((dif*100)/abs(totTitre4),2)
                    else if(dif<>0)then pg:=100;
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
                       pg:=0;
                       if(col4<>0)then pg:=Arrondi((dif*100)/abs(col4),2)
                    else if(dif<>0)then pg:=100;
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
     pg:=0;
     if(tot4<>0)then pg:=Arrondi((dif*100)/abs(tot4),2)
                    else if(dif<>0)then pg:=100;
        ListeValeur.Add('1'+separateur+separateur+' @Total'+separateur+e.FormatCurrSansDevise(Arrondi(tot1-tot2,nbArrondi))
        +separateur+e.FormatCurrSansDevise(Arrondi(tot4,nbArrondi))
          +separateur+e.FormatCurrSansDevise(Arrondi(dif,nbArrondi))+separateur+e.FormatCurrSansDevise(pg));
        rempliColonneMontant(tot1,tot2,tot1,tot4,-1,'',0,separateur,0,true); //initialisation
     end;


  if(not empty(soustitre))and(not str_commence_par(soustitre,'@'))then
     begin
     dif:=totSSTitre1-totSSTitre2-totSSTitre4;
     pg:=0;
     if(totSSTitre4<>0)then pg:=Arrondi((dif*100)/abs(totSSTitre4),2)
                    else if(dif<>0)then pg:=100;
        ListeValeur.Add('1'+separateur+separateur+' @'+soustitre+separateur+e.FormatCurrSansDevise(Arrondi(totSSTitre1-totSSTitre2,nbArrondi))
        +separateur+e.FormatCurrSansDevise(Arrondi(totSSTitre4,nbArrondi))
          +separateur+e.FormatCurrSansDevise(Arrondi(dif,nbArrondi))+separateur+e.FormatCurrSansDevise(pg));
        rempliColonneMontant(totSSTitre1,totSSTitre2,totSSTitre1,totSSTitre4,-1,'',0,separateur,0,true); //initialisation
     end;


     //coupure
     if(not empty(titre))then
     begin
     dif:=totTitre1-totTitre2-totTitre4;
     pg:=0;
     if(totTitre4<>0)then pg:=Arrondi((dif*100)/abs(totTitre4),2)
                    else if(dif<>0)then pg:=100;
         ListeValeur.Add('1'+separateur+separateur+' @'+titre+separateur+e.FormatCurrSansDevise(Arrondi(totTitre1-totTitre2,nbArrondi))
         +separateur+e.FormatCurrSansDevise(Arrondi(totTitre4,nbArrondi))
         +separateur+e.FormatCurrSansDevise(Arrondi(dif,nbArrondi))+separateur+e.FormatCurrSansDevise(pg));
         rempliColonneMontant(totTitre1,totTitre2,totTitre3,totTitre4,-1,'',0,separateur,0,true); //initialisation
     end;
     dif:=totGen1-totGen2-totGen4;
     pg:=0;
     if(totGen4<>0)then pg:=Arrondi((dif*100)/abs(totGen4),2)
                    else if(dif<>0)then pg:=100;
      ListeValeur.Add('1'+separateur+separateur+'@TOTAL GENERAL'
      +separateur+e.FormatCurrSansDevise(Arrondi(totGen1-totGen2,nbArrondi))+separateur+e.FormatCurrSansDevise(Arrondi(totGen4,nbArrondi))
           +separateur+e.FormatCurrSansDevise(Arrondi(dif,nbArrondi))
           +separateur+e.FormatCurrSansDevise(pg));

end;


function rempliListeAvantEdition(listeComptesIn:Tstringlist; separateur : char) : Tstringlist;                      //
var
i,j,rang:integer;  //
Repartition:TRepartition;
compte:string;
montant:currency;
Feuille:string;
col1,col2,col3,col4,dif,pg:currency;
libelle,cellule,titre,soustitre:string;
Nbtrouve:integer;
LigneExiste,colonne:integer;
ListeRetour : TStringlistLGR1;
//separateur:char;
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
           titre:= Repartition.titre;
           soustitre := Repartition.soustitre;

          Feuille:=Repartition.Feuille;
           colonne:= StrToInt_Lgr(Repartition.colBilan);
           Nbtrouve:=0;
           compte:='';
           //if(str_commence_par(lowercase(libelle),'resultat'))then showmessage('ok');
           for j:=0 to Repartition.compte.Count-1 do
             begin
                 compte:='';
                 montant:=0;
                 compte:=Repartition.compte.Strings[j];
                 if(str_commence_par(lowercase(libelle),'resultat'))then compte:='';
                 colonne:=StrToInt_Lgr(Repartition.colBilan);
                 if(Repartition.compte.Objects[j]<>nil) then
                 begin
                   montant:=TMontant(Repartition.compte.Objects[j]).MontantCpt;

                 LigneExiste:= retrouveLigne(ListeRetour,libelle+compte,separateur);
                 if(LigneExiste>-1)then
                    begin
                       rempliColonneMontant(col1,col2,col3,col4,colonne,ListeRetour.Strings[LigneExiste],montant,separateur);
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
                         rempliColonneMontant(col1,col2,col3,col4,colonne,ListeRetour.Strings[LigneExiste],Repartition.MontantTotal,separateur,0);
                      end
                      else
                      begin
                       rempliColonneMontant(col1,col2,col3,col4,colonne,ListeRetour.Strings[LigneExiste],Repartition.MontantTotal,separateur);
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
                end;//fin Nbtrouve=0
            end;//si montant rempli
       end;//fin listeComptesIn.Objects[i]<>nil
  end;//fin for
//finally
ListeRetour.CustomSort(CustomSortCompteProcAsc);
rempliListeAvantEdition:=ListeRetour;
//end;
end;

procedure TEditionFin.PaBtnResize(Sender: TObject);
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

