unit E2_EditionBilanOuverture;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, GrGrid, ExtCtrls, ComCtrls,
  Db, DBTables,LibSQL,E2_Librairie_Obj,E2_Decl_records,Gr_Librairie_Obj,
  LibDates,
  LibFichRep,
  LibZoneSaisie,DMConstantes,ShellApi, DBGrids, LibGestionParamXML, Menus,
  Buttons, DBCtrls, dbcgrids, Mask, RXCtrls;

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
  TEditionOuverture = class(TForm)
    PCLiasseFiscale: TPageControl;
    TbShDoc2144: TTabSheet;
    PaGrGrandLivre: TPanel;
    GrBilanActif: TGrGrid;
    PaMouv: TPanel;
    TbShDoc2145: TTabSheet;
    PaGrilleBilanPassif: TPanel;
    GrBilanPassif: TGrGrid;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
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
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    RxSBDetailPointage: TRxSpeedButton;
    CBEditionCentime: TCheckBox;
    procedure BtnCalculerClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure BtnDetailClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SBFermerClick(Sender: TObject);
    procedure Imprimer1Click(Sender: TObject);
    procedure PCLiasseFiscaleChange(Sender: TObject);
    procedure ImprimerDetail1Click(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);

  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  EditionOuverture: TEditionOuverture;
   function copyFichierAvantUtilisation(nomFichierOrigine, repertoireOrigine :String):string;
implementation

uses DMRecherche, DMLiasseFiscale, DMPlanCpt, DMDiocEtatBalance,
  UBilanActif, UBilanPassif,lib_chaine,
  //E2_VisuEditFisc,
  DMRepartition;

{$R *.DFM}


procedure TEditionOuverture.BtnCalculerClick(Sender: TObject);
var
i,j:integer;
Debit,Credit:Currency;
begin
 try
    Screen.Cursor := crSQLWait;
    if DMRepart = nil then DMRepart:=TDMRepart.Create(Application.MainForm);
    //DMDiocEtatBal.TaBalanceaffich.Refresh;
//    DMDiocEtatBal.SommeTotauxBalanceCalc(E.DatExoDebut,E.DatExoFin,nil,'Compte');
    liste_cellule(DMDiocEtatBal.TaBalanceCalc,DMRepart.RepartitionOuverture,E.Regime);
    SommeCellule(nil,true);

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
           if ((j <> -1)and(not empty(DMLiasseFisc.QuParamLia.FindField('Col2').AsString))) then
             begin
//               GrBilanActif.Cells[2,i]:=FormatCurr(E.EditFormat,TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrBilanActif.Cells[2,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrBilanActif.Objects[2,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;

           // Colonne 4
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col4').AsString);
           if ((j <> -1)and(not empty(DMLiasseFisc.QuParamLia.FindField('Col4').AsString))) then
             begin
               GrBilanActif.Cells[4,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrBilanActif.Objects[4,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;

           // Colonne 5
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col5').AsString);
           if ((j <> -1 )and(not empty(DMLiasseFisc.QuParamLia.FindField('Col5').AsString))) then
             begin
               GrBilanActif.Cells[5,i]:=E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[j]).MontantTotal);
               GrBilanActif.Objects[5,i]:=TRepartition(DMRepart.ListeCell.Objects[j]);
             end;

           // Colonne 6
           j:=DMRepart.ListeCell.IndexOf(DMLiasseFisc.QuParamLia.FindField('Col6').AsString);
           if ((j <> -1)and(not empty(DMLiasseFisc.QuParamLia.FindField('Col6').AsString))) then
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
    DefiltrageDataSet(DMRech.TaBalanceRech);
 Finally
  Screen.Cursor := crDefault;
 end;
end;

procedure TEditionOuverture.FormActivate(Sender: TObject);
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
//GrBilanActif.Cells[6,0] := 'Net N-1';
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
//GrBilanPassif.Cells[4,0] := 'Exercice N-1';
GrBilanPassif.ParamColor:=true;
GrBilanPassif.Param:=ParamUtil.CouleurDBGrid;
GrBilanPassif.DessineContourLigne:=false;
GrBilanPassif.UpDateColor;

EditionOuverture.PCLiasseFiscaleChange(nil);
end;

procedure TEditionOuverture.FormDestroy(Sender: TObject);
begin
if DMLiasseFisc <> nil then DMLiasseFisc.Free;
LibGestionParamXML.DestroyForm(Self,E.User);
EditionOuverture:=nil;
end;

procedure TEditionOuverture.BtnImprimerClick(Sender: TObject);
var
ListePdf2:TStringList;
i:integer;
Debit,Credit:Currency;
dateEdition,nomProvisoire,extensionProvisoire:String;
begin
ListePdf2:=TStringList.Create;
ListePdf2.Add('%FDF-1.2');
ListePdf2.Add('%����');
ListePdf2.Add('1 0 obj');
ListePdf2.Add('<<');
ListePdf2.Add('/FDF << /Fields [');


ListePdf2.Add(' << /V ('+DateInfos(E.DatExoDebut-1).DateStr+') /T (Date_anterieure)>>');
ListePdf2.Add(' << /V (Edit� le '+DateInfos(NOW).DateStr+') /T (DATE_EDITION)>>');
ListePdf2.Add(' << /V ('+DateInfos(E.DatExoDebut).DateStr+') /T (A1_2_1)>>');
ListePdf2.Add(' << /V ('+DateInfos(E.DatExoFin).DateStr+') /T (A1_2_2)>>'); //
ListePdf2.Add(' << /V ('+' - Dossier : '+E.NomDossier+' - BILAN D''OUVERTURE AU : '+DateInfos(E.DatExoDebut).DateStrFormat+') /T (RN_ZRL_1)>>');
ListePdf2.Add(' << /V ('+'- RaisonSociale : '+E.RaisonSociale+') /T (RN_ZRL_2)>>');

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

//DMDiocEtatBal.ResultatExercice(Debit,Credit,E.DatExoDebut,E.DatExoFin);
//ListePdf2.Add(' << /V ('+CurrToStr(Debit+Credit)+') /T (RN_B1_8_1)>>');


// Recalcul et r�affectation, cela permet
// de ne pas perdre les r�f�rence des objets de chaque cellule
// par rapport � DMRepart.ListeCell
BtnCalculer.Click;

if DMRepart.ListeCell.Count > 0 then
 begin
     // Remplissage de la liste servant � g�n�rer le PDF
     for  i:=0  to DMRepart.ListeCell.Count-1 do
       begin
//          ListePdf2.Add(' << /V ('+E.FormatCurrSansDevise(TRepartition(DMRepart.ListeCell.Objects[i]).MontantTotal)+')/T ('+DMRepart.ListeCell.Strings[i]+')>>');
//          if DMRepart.ListeCell.Strings[i]='RN_B1_8_1' then showmessage(CurrToStr(TRepartition(DMRepart.ListeCell.Objects[i]).MontantTotal));
          if CBEditionCentime.Checked then
            ListePdf2.Add(' << /V ('+CurrToStr(TRepartition(DMRepart.ListeCell.Objects[i]).MontantTotal)+')/T ('+DMRepart.ListeCell.Strings[i]+')>>')
          else
           ListePdf2.Add(' << /V ('+CurrToStr(Round(TRepartition(DMRepart.ListeCell.Objects[i]).MontantTotal))+')/T ('+DMRepart.ListeCell.Strings[i]+')>>');
       end;
 end;
ListePdf2.Add(' ]');

if Sender = BtnImprimerDetail then
 begin
// case BtnImprimerDetail.Tag of
//
//  EditionPartBilanActif: ListePdf2.Add('/F ('+DM_C_NomBilanAGRReelOuverture+')/ID [ <387aec558f007ac48b5052a725e4afd1><7040395dab48dfebccddc82ce39a75f8>');
//  EditionPartBilanPassif: ListePdf2.Add('/F ('+DM_C_NomBilanAGRReelOuverture+')/ID [ <387aec558f007ac48b5052a725e4afd1><7040395dab48dfebccddc82ce39a75f8>');
//
// else
    nomProvisoire:= copyFichierAvantUtilisation(DM_C_NomBilanAGRReelOuverture,E.REpertoireFiscal);
    //ListePdf2.Add('/F ('+DM_C_NomBilanAGRReelOuverture+')/ID [ <387aec558f007ac48b5052a725e4afd1><7040395dab48dfebccddc82ce39a75f8>');
// end;


 end;

if Sender = BtnImprimer then
 begin
  //ListePdf2.Add('/F ('+DM_C_NomBilanAGRReelOuverture+')/ID [ <387aec558f007ac48b5052a725e4afd1><7040395dab48dfebccddc82ce39a75f8>');
  nomProvisoire:= copyFichierAvantUtilisation(DM_C_NomBilanAGRReelOuverture,E.REpertoireFiscal);
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
//     ShellExecute(handle,'open','AcroRd32.exe',PChar('"'+E.REpertoireFiscal+'BILAN AGRICOLE REEL.fdf"'),PChar(E.REpertoireFiscal),SW_SHOWNORMAL);
    ShellExecute(handle,nil,PChar('"'+E.REpertoireFiscal+'BILAN AGRICOLE REEL.fdf"'),nil,PChar(E.REpertoireFiscal),SW_SHOWNORMAL);
 end;
end;


procedure TEditionOuverture.BtnDetailClick(Sender: TObject);
var
i,j:integer;
ExercicePrecedent:Boolean;
begin
//DMDiocEtatBal.SommeTotauxBalanceCalc(E.DatExoDebut,E.DatExoFin,nil,'Compte');
//liste_cellule(DMDiocEtatBal.TaBalanceCalc,DMRepart.RepartitionOuverture,E.Regime);
//SommeCellule(nil);
if DMRepart.ListeCell<>nil then
begin
if PCLiasseFiscale.ActivePage.Name = 'TbShDoc2144' then
 begin
   if GrBilanActif.col > 0 then
    begin
     DMLiasseFisc.InitTableSurNumLiasse('2144');
     j:=DMRepart.ListeCell.IndexOfObject(TRepartition(GrBilanActif.Objects[GrBilanActif.Col,GrBilanActif.Row]));
     if j <> -1 then
      begin
//       ExercicePrecedent:= (GrBilanActif.Col =6); // Indicateur si N-1
       ExercicePrecedent:= true; // Indicateur si N-1
       VisuListeCompteDeZoneAffich(DMRepart.ListeCell.Strings[j],ExercicePrecedent);
      end
      else
      ShowMessage('Pas de d�tail pour cette ligne');
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
//       ExercicePrecedent:= (GrBilanPassif.Col =4); // Indicateur si N-1
       ExercicePrecedent:= true; // Indicateur si N-1
       VisuListeCompteDeZoneAffich(DMRepart.ListeCell.Strings[j],ExercicePrecedent);
      end
      else
      ShowMessage('Pas de d�tail pour cette ligne');
    end;
 end;
end;//fin si non nil
end;

procedure TEditionOuverture.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
   begin
    Key:= 0;
    Self.Close;
   end;
end;

procedure TEditionOuverture.BtnAnnulerEnter(Sender: TObject);
begin
  BouttonDiminue(sender as TButton);
end;

procedure TEditionOuverture.BtnAnnulerExit(Sender: TObject);
begin
  BouttonAgrandit(sender as TButton);
end;

procedure TEditionOuverture.FormCreate(Sender: TObject);
begin
  try
      if DMLiasseFisc = nil then DMLiasseFisc := TDMLiasseFisc.Create(Application.MainForm);
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;


procedure TEditionOuverture.SBFermerClick(Sender: TObject);
begin
PaModifZone.Visible := false;
end;

procedure TEditionOuverture.Imprimer1Click(Sender: TObject);
begin
BtnImprimer.Click;
end;

procedure TEditionOuverture.PCLiasseFiscaleChange(Sender: TObject);
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
end;

procedure TEditionOuverture.ImprimerDetail1Click(Sender: TObject);
begin
BtnImprimerDetail.Click;
end;

procedure TEditionOuverture.BtnFermerClick(Sender: TObject);
begin
  self.close;
end;

procedure TEditionOuverture.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(nil);
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

