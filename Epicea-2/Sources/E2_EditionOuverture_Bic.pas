unit E2_EditionOuverture_Bic;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, GrGrid, ExtCtrls, ComCtrls,
  Db, DBTables,LibSQL,E2_Librairie_Obj,E2_Decl_records,Gr_Librairie_Obj,
  LibDates, lib_chaine,
  LibFichRep,
  LibZoneSaisie,DMConstantes,ShellApi, DBGrids, LibGestionParamXML, Menus,
  Buttons, DBCtrls, dbcgrids, Mask, RXCtrls, OleCtrls, AcroPDFLib_TLB,
  SHDocVw;

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
  TEditionOuverture_Bic = class(TForm)
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
    Panel12: TPanel;
    GrBilanActif_Bic: TGrGrid;
    GrBilanPassif_Bic: TGrGrid;
    TbShDoc2051: TTabSheet;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnCalculer: TButton;
    BtnModifier: TButton;
    BtnImprimerDetail: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    BtnDetail: TButton;
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
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  EditionOuverture_Bic: TEditionOuverture_Bic;
    function copyFichierAvantUtilisation(nomFichierOrigine, repertoireOrigine :String):string;
implementation

uses DMRecherche, DMLiasseFiscale, DMPlanCpt, DMDiocEtatBalance,
  UBilanActif, UBilanPassif,
  //E2_VisuEditFisc,
  DMRepartition, AfficheWeb;

{$R *.DFM}


procedure TEditionOuverture_Bic.BtnCalculerClick(Sender: TObject);
var
i,j:integer;
Debit,Credit:Currency;
begin
 try
    Screen.Cursor := crSQLWait;
    if DMRepart = nil then DMRepart:=TDMRepart.Create(Application.MainForm);
    //DMDiocEtatBal.TaBalanceaffich.Refresh;
//    DMDiocEtatBal.SommeTotauxBalanceCalc(E.DatExoDebut,E.DatExoFin,nil,'Compte');
    liste_cellule(DMDiocEtatBal.TaBalanceCalc,DMRepart.RepartitionOuverture_Bic,E.Regime);
    SommeCellule_Bic(nil,true);

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

    DefiltrageDataSet(DMRech.TaBalanceRech);
 Finally
  Screen.Cursor := crDefault;
 end;
end;

procedure TEditionOuverture_Bic.FormActivate(Sender: TObject);
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
GrBilanPassif_Bic.ParamColor:=true;
GrBilanPassif_Bic.Param:=ParamUtil.CouleurDBGrid;
GrBilanPassif_Bic.DessineContourLigne:=false;
GrBilanPassif_Bic.UpDateColor;

//
EditionOuverture_Bic.PCLiasseFiscaleChange(nil);
end;

procedure TEditionOuverture_Bic.FormDestroy(Sender: TObject);
begin
if DMLiasseFisc <> nil then DMLiasseFisc.Free;
LibGestionParamXML.DestroyForm(Self,E.User);
EditionOuverture_Bic:=nil;
end;

procedure TEditionOuverture_Bic.BtnImprimerClick(Sender: TObject);
var
ListePdf2:TStringList;
i:integer;
Debit,Credit:Currency;
dateEdition,nomProvisoire,extensionProvisoire:String;


  s, result:String;
    path: array[0..250] of char ;

begin
ListePdf2:=TStringList.Create;
ListePdf2.Add('%FDF-1.2');
ListePdf2.Add('%âãÏÓ');
ListePdf2.Add('1 0 obj');
ListePdf2.Add('<<');
ListePdf2.Add('/FDF << /Fields [');

ListePdf2.Add(' << /V ('+DateInfos(E.DatExoDebut-1).DateStr+') /T (Date_anterieure)>>');
ListePdf2.Add(' << /V (Edité le '+DateInfos(NOW).DateStr+') /T (DATE_EDITION)>>');

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
            ListePdf2.Add(' << /V ('+CurrToStr(TRepartition(DMRepart.ListeCell.Objects[i]).MontantTotal)+')/T ('+DMRepart.ListeCell.Strings[i]+')>>')
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
  //ListePdf2.Add('/F ('+DM_C_NomBilanBICReelOuverture+')/ID [ <387aec558f007ac48b5052a725e4afd1><7040395dab48dfebccddc82ce39a75f8>');
  nomProvisoire:= copyFichierAvantUtilisation(DM_C_NomBilanBICReelOuverture,E.REpertoireFiscal);
  end;
  EditionPartBilanPassif_Bic:
  begin
  //ListePdf2.Add('/F ('+DM_C_NomBilanBICReelOuverture+')/ID [ <387aec558f007ac48b5052a725e4afd1><7040395dab48dfebccddc82ce39a75f8>');
  nomProvisoire:= copyFichierAvantUtilisation(DM_C_NomBilanBICReelOuverture,E.REpertoireFiscal);
  end;
 else
   begin
   //ListePdf2.Add('/F ('+DM_C_NomBilanBICReelOuverture+')/ID [ <387aec558f007ac48b5052a725e4afd1><7040395dab48dfebccddc82ce39a75f8>');
   nomProvisoire:= copyFichierAvantUtilisation(DM_C_NomBilanBICReelOuverture,E.REpertoireFiscal);
   end;
 end;


 end;

if Sender = BtnImprimer then
 begin
 nomProvisoire:= copyFichierAvantUtilisation(DM_C_NomBilanBICReelOuverture,E.REpertoireFiscal);
  //ListePdf2.Add('/F ('+DM_C_NomBilanBICReelOuverture+')/ID [ <387aec558f007ac48b5052a725e4afd1><7040395dab48dfebccddc82ce39a75f8>');
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



//       s:='/A nameddest=somePlaceInPDF "'+E.REpertoireFiscal+'BILAN BIC REEL.fdf"';
//       FindExecutable(PChar(E.REpertoireFiscal+'BILAN BIC REEL.fdf'),nil,path);
//       result := trim(StrPas(path));
//       ShellExecute(handle,nil,pchar(result),pchar(s),nil,sw_show);


 //ChoixParamAffichePageWeb;
//ShellExecute(Handle,'open',PChar(sExe),PChar(' /p /h "C:\Test.pdf"'),Nil,SW_HIDE);
     //ShellExecute(handle,nil,'AcroRd32.exe',PChar('"'+E.REpertoireFiscal+'BILAN BIC REEL.fdf"'),nil,SW_SHOWNORMAL);
    ShellExecute(handle,nil,PChar('"'+E.REpertoireFiscal+'BILAN BIC REEL.fdf"'),nil,PChar(E.REpertoireFiscal),SW_SHOWNORMAL);
 end;
end;

procedure TEditionOuverture_Bic.BtnDetailClick(Sender: TObject);
var
i,j:integer;
ExercicePrecedent:Boolean;
begin
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
           ExercicePrecedent:=true;// (GrBilanActif_Bic.Col =6); // Indicateur si N-1
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
           ExercicePrecedent:=true;// (GrBilanPassif_Bic.Col =5); // Indicateur si N-1
           VisuListeCompteDeZoneAffich(DMRepart.ListeCell.Strings[j],ExercicePrecedent);
          end
          else
          ShowMessage('Pas de détail pour cette ligne');
        end;
     end;
  end;//fin si non nil

end;

procedure TEditionOuverture_Bic.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
   begin
    Key:= 0;
    Self.Close;
   end;
end;

procedure TEditionOuverture_Bic.BtnAnnulerEnter(Sender: TObject);
begin
  BouttonDiminue(sender as TButton);
end;

procedure TEditionOuverture_Bic.BtnAnnulerExit(Sender: TObject);
begin
  BouttonAgrandit(sender as TButton);
end;

procedure TEditionOuverture_Bic.FormCreate(Sender: TObject);
begin
  try
      if DMLiasseFisc = nil then DMLiasseFisc := TDMLiasseFisc.Create(Application.MainForm);
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;


procedure TEditionOuverture_Bic.SBFermerClick(Sender: TObject);
begin
PaModifZone.Visible := false;
end;

procedure TEditionOuverture_Bic.Imprimer1Click(Sender: TObject);
begin
BtnImprimer.Click;
end;

procedure TEditionOuverture_Bic.PCLiasseFiscaleChange(Sender: TObject);
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
end;

procedure TEditionOuverture_Bic.ImprimerDetail1Click(Sender: TObject);
begin
BtnImprimerDetail.Click;
end;

procedure TEditionOuverture_Bic.BtnFermerClick(Sender: TObject);
begin
  self.close;
end;

procedure TEditionOuverture_Bic.Calculatrice1Click(Sender: TObject);
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

