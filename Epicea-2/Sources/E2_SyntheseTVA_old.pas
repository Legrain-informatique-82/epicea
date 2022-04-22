unit E2_SyntheseTVA;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,E2_Decl_Records,ChoixPeriode
  ,E2_Librairie_Obj,DMTTVA,DMTVA,LibSQL,E2_Patientez,LibRessourceString, StdCtrls,
  RXCtrls, ExtCtrls, Grids, GrGrid,LibZoneSaisie,E2_ChoixEditionTVA,DMConstantes,
  DMDiocEtatBalance,Gr_Librairie_Obj, Menus,ShellApi,
  LibGestionParamXML,
  DMCorrection,
  E2_RegulTva,
  jpeg;

type
  TSyntheseTVA = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaCentre: TPanel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnModifier: TButton;
    BtnInserer: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    PaCHaut: TPanel;
    PaGaucheH: TPanel;
    PaGHaut: TPanel;
    PaGCentre: TPanel;
    PaTitre2: TPanel;
    PaTitre1: TPanel;
    GrGrid2: TGrGrid;
    PaCentreH: TPanel;
    PaDroitH: TPanel;
    PaCH1: TPanel;
    PaCH2: TPanel;
    PaTitre4: TPanel;
    PaTitre3: TPanel;
    GrGrid3: TGrGrid;
    GrGrid4: TGrGrid;
    BtnPieceTVA: TButton;
    BtnEditionTVA: TButton;
    BtnEditionetPieceTVA: TButton;
    BtnChReport: TButton;
    BtnChADecl: TButton;
    BtnJournaux: TButton;
    PopupMenu1: TPopupMenu;
    DtailsF71: TMenuItem;
    Imprimer1: TMenuItem;
    BtnDetail: TButton;
    Button2: TButton;
    ExporterSynthese1: TMenuItem;
    Versionimprimable1: TMenuItem;
    Versionsimple1: TMenuItem;
    Calculatrice1: TMenuItem;
    GrGrid1: TGrGrid;
    Procedure InitGrille;
    Procedure InitEdition;
    procedure PaDroitHResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnPieceTVAClick(Sender: TObject);
    procedure BtnEditionTVAClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnChReportClick(Sender: TObject);
    procedure BtnChADeclClick(Sender: TObject);
    procedure GrGrid1DrawCell(Sender: TObject; Col, Row: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure GrGrid2DrawCell(Sender: TObject; Col, Row: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure GrGrid4DrawCell(Sender: TObject; Col, Row: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnEditionetPieceTVAClick(Sender: TObject);
    procedure BtnJournauxClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnDetailClick(Sender: TObject);
    procedure GrGrid1DblClick(Sender: TObject);
    procedure GrGrid2DblClick(Sender: TObject);
    procedure GrGrid3DblClick(Sender: TObject);
    procedure DtailsF71Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Versionimprimable1Click(Sender: TObject);
    procedure Versionsimple1Click(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);


  private
    { Déclarations privées }
  procedure EtatInitial;
  public
    { Déclarations publiques }
   Periode:TPeriode;
   PieceTVANonPassee:texceptlgr;
  end;

var
  SyntheseTVA: TSyntheseTVA;

Function SyntheseTVAAffiche(demandePeriode:boolean=true):boolean;

implementation

uses DMRecherche, LibClassObjetSenders, E2_Main;

{$R *.DFM}

Function SyntheseTVAAffiche(demandePeriode:boolean):boolean;
var
Debut1,Debut2,Debut3,Fin:TTime;
ForceAffichage:TForceAffichage;
ParamAffichPeriode:TParamAffichPeriode;
begin
ForceAffichage.Affiche:=false;
ForceAffichage.Force:=false;
 if SyntheseTVA = nil then SyntheseTVA:=TSyntheseTVA.Create(Application.MainForm);
 if DMTmTVA = nil then DMTmTVA:=TDMTmTVA.Create(Application.MainForm);
//initialisation de la variable
 SyntheseTVA.PieceTVANonPassee.retour:=true;
 SyntheseTVA.PieceTVANonPassee.NumErreur:=0;
///
 DMTmTVA.MAJ_DateDeclarationTVA(SyntheseTVA.Periode.DateDeb,SyntheseTVA.Periode.DateFin);
 e.DateDebutDeclarationTVA:=SyntheseTVA.Periode.DateDeb;
 e.DateFinDeclarationTVA:=SyntheseTVA.Periode.DateFin;
 try
   if Choix_Periode = nil then Choix_Periode:=TChoix_Periode.Create(Application.MainForm);
   Choix_Periode.EdDateDeb.OnExit:=LibClassObjetSender.SenderOnDateDebExit;
   Choix_Periode.EdDateFin.OnExit:=LibClassObjetSender.SenderOnDateFinExit;
   Initialise_ParamAffichPeriode(ParamAffichPeriode);
   if demandeperiode then
     SyntheseTVA.Periode:=ChoixPeriodeAffich(SyntheseTVA.Periode.DateDeb,SyntheseTVA.Periode.DateFin,'Dates de votre prochaine déclaration TVA !',ParamAffichPeriode);
 finally
   Choix_Periode.EdDateDeb.OnExit:=Choix_Periode.EdDateDebExit;
   Choix_Periode.EdDateFin.OnExit:= Choix_Periode.EdDateFinExit;
 end;//fin du try finally
// SyntheseTVA.Button2.Visible:=e.TypeClient=cl_isa;
 SyntheseTVA.Button2.Visible:=true;
 SyntheseTVA.Caption:= 'Synthèse TVA - Période du : '+datetostr(SyntheseTVA.Periode.DateDeb)+' au '+datetostr(SyntheseTVA.Periode.DateFin);
 SyntheseTVA.RxLabTitre.caption:=SyntheseTVA.caption;
 if SyntheseTVA.Periode.Retour then
  begin
   PatienterAffich;
   E.DateDebutDeclarationTVA :=SyntheseTVA.Periode.DateDeb;
   E.DateFinDeclarationTVA := SyntheseTVA.Periode.DateFin;
   ViderTable(DMTmTVA.TaDec_Tva);
   DMTmTVA.TotauxReport:=CalculReport(False,DMTmTVA.listeReports,SyntheseTVA.Periode.DateDeb,SyntheseTVA.Periode.DateFin);
   //C_Id_Decl_Tmp
   //sauvegarder historique des reports
   Debut1:=Time;
   CalculDeclarationTva(SyntheseTVA.Periode.DateDeb,SyntheseTVA.Periode.DateFin,demandePeriode);
   Debut2:=Time;
   PatienterFermer;
   DMTmTVA.VAliderDeclarationTVA(SyntheseTVA.Periode.DateDeb,SyntheseTVA.Periode.DateFin,false,ForceAffichage);
   PatienterAffich;
   Debut3:=Time;
   SyntheseTVA.EtatInitial;
   SyntheseTVA.InitGrille;
   PatienterFermer;
   Fin:=Time;
//   showmessage('DebutCalcul : '+timetostr(debut1)+ ' - DebutValidation : '+timetostr(debut2)+ ' - DebutAffichage : '+timetostr(debut3)+ ' - Fin : '+timetostr(fin));
   SyntheseTVA.ShowModal;
  end
 else
  begin

  end;



End;

procedure TSyntheseTVA.EtatInitial;
Begin
button2.enabled:=FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'ControleTvaEnAttente.txt');
BtnChADecl.Enabled:=((PieceTVANonPassee.retour) and (((DMTmTVA.InfosAvantValidation<>nil)or(((DMTmTVA.Soldearrondi_Imposable<>0)and(DMTmTVA.Soldearrondi_Deductible<>0))))));
BtnPieceTVA.Enabled:=((PieceTVANonPassee.retour) and (((DMTmTVA.InfosAvantValidation<>nil)or(((DMTmTVA.Soldearrondi_Imposable<>0)and(DMTmTVA.Soldearrondi_Deductible<>0))))));
BtnChReport.Enabled:=((PieceTVANonPassee.retour) and (((DMTmTVA.InfosAvantValidation<>nil)or(((DMTmTVA.Soldearrondi_Imposable<>0)and(DMTmTVA.Soldearrondi_Deductible<>0))))));
BtnEditionetPieceTVA.Enabled:=((PieceTVANonPassee.retour) and (((DMTmTVA.InfosAvantValidation<>nil)or(((DMTmTVA.Soldearrondi_Imposable<>0)and(DMTmTVA.Soldearrondi_Deductible<>0))))));
BtnEditionTVA.Enabled:=(((DMTmTVA.InfosAvantValidation<>nil)or(((DMTmTVA.Soldearrondi_Imposable<>0)and(DMTmTVA.Soldearrondi_Deductible<>0)))));
//BtnJournaux.Enabled:=(((DMTmTVA.InfosAvantValidation<>nil)or(((DMTmTVA.Soldearrondi_Imposable<>0)and(DMTmTVA.Soldearrondi_Deductible<>0)))));
//BtnDetail.Enabled:=(((DMTmTVA.InfosAvantValidation<>nil)or(((DMTmTVA.Soldearrondi_Imposable<>0)and(DMTmTVA.Soldearrondi_Deductible<>0)))));
End;

Procedure TSyntheseTVA.InitGrille;
var
ListeCodeTVA,ListeCodeTVATmp,ListeTmp,ListeTmp2:TStringList;
i,j,k:integer;
StrTmp:String;
totauxbalance:Ttotauxbalance;
solde,Soldearrondi:currency;
// TVA DEDUCTIBLE
TotTVADeductibleL1,TotTVADeductibleL2,TotTVADeductibleL3:currency;
TotHTDeductibleL1,TotHTDeductibleL2,TotHTDeductibleL3:currency;
TotReportL4:currency;
// OPERATION NON IMPOSABLE
TotOpNonImposableL1,TotOpNonImposableL2,TotOpNonImposableL3,TotOpNonImposableL4:currency;
ListeObjet:Tstringlist;
rang:integer;
Begin
 try
TotTVADeductibleL1:=0;
TotTVADeductibleL2:=0;
TotTVADeductibleL3:=0;
TotHTDeductibleL1:=0;
TotHTDeductibleL2:=0;
TotHTDeductibleL3:=0;
TotReportL4:=0;
// OPERATION NON IMPOSABLE
TotOpNonImposableL1:=0;
TotOpNonImposableL2:=0;
TotOpNonImposableL3:=0;
TotOpNonImposableL4:=0;


  // GrGrid1 : OPERATIONS IMPOSABLES
    for k:=0 to GrGrid1.rowcount-1 do
      GrGrid1.rows[k].clear;
    GrGrid1.RowCount := 2;
    GrGrid1.ParamColor:=true;
    GrGrid1.Param:=ParamUtil.CouleurDBGrid;
    GrGrid1.DessineContourLigne:=false;
    GrGrid1.UpDateColor;
    GrGrid1.Cells[1,0] := 'HT';
    GrGrid1.Cells[2,0] := 'TVA';
    ListeCodeTVA:=TStringList.Create;
    ListeCodeTVATmp:=TStringList.Create;

    ListeCodeTVATmp.clear;
    ListeCodeTVA.Clear;
  //  ListeCodeTVA:=ChampTableVersListe('TvaCode',DMREch.TaTvaCodeRech);
    ListeCodeTVA:=ChampTableVersListeEx(['TvaCode','Libelle'],DMREch.TaTvaCodeRech,' - ',FAlse);

    if DMTmTVA = nil then DMTmTVA:=TDMTmTVA.Create(application.MainForm);
    if DMTmTVA.QuDec_Tva_VisuListe.Active then DMTmTVA.QuDec_Tva_VisuListe.Close;
    if DMTmTVA.QuDec_Tva.Active then DMTmTVA.QuDec_Tva.Close;
    DMTmTVA.QuDec_Tva_VisuListe.SQL.Clear;
    DMTmTVA.QuDec_Tva_VisuListe.SQL.Add(RqDec_Tva_SommeTvaParCode_1);
    DMTmTVA.QuDec_Tva_VisuListe.Open;
    if DMTmTVA.QuSumParCode_Dec_Tva.Active then
      DMTmTVA.QuSumParCode_Dec_Tva.Close;
    DMTmTVA.QuSumParCode_Dec_Tva.open;
    ListeTmp:=TStringList.Create;
    ListeTmp.Clear;
    ListeTmp :=DM_C_ListeCTVAVente;
    ListeTmp2:=TStringList.Create;
    ListeTmp2.Clear;
    ListeTmp2 :=DM_C_ListeCTVAImposeDeduite;
    j:=2;
    for i:=0 to ListeCodeTVA.Count -1 do
     begin
       StrTmp:=Copy(ListeCodeTVA.Strings[i],1,1);
       // Si le Code de TVA est dans la liste des classes TVA de Ventes
       if ListeTmp.IndexOf(StrTmp) <> -1 then
        begin
         if i > 0 then GrGrid1.AjouteLigne;
         // Si le code de TVA est dans la liste des classes TVA ImposeDeduite (Cf classe C et CodeTva C1(Acquisition CEE))
         // Ce cas inverse le signe des montant à déclarer car c'est une acquisition parmi les ventes !!!
         if ListeTmp2.IndexOf(StrTmp) <> -1 then
           begin
             GrGrid1.Cells[0,GrGrid1.RowCount-1] := ListeCodeTVA.Strings[i];
             ListeObjet:=TStringList.Create;
             ListeObjet.Add(copy(ListeCodeTVA.Strings[i],1,2)+';0');
             GrGrid1.Objects[0,GrGrid1.RowCount-1]:=ListeObjet;
             if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
              Begin
               if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
                GrGrid1.Cells[1,GrGrid1.RowCount-1] := FormatFloat(E.FormatMonnaie + ';; ', (arrondi(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency,2)-arrondi(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency,2)))
               else
                GrGrid1.Cells[1,GrGrid1.RowCount-1] := FormatFloat(E.FormatMonnaie + ';; ', 0);
              //Soldearrondi:=(arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency,2)-arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2));
              Soldearrondi:=(arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency-DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2));
              GrGrid1.Cells[2,GrGrid1.RowCount-1] := FormatFloat(E.FormatMonnaie + ';; ',Soldearrondi );
              End
              else
              Begin
               GrGrid1.Cells[2,GrGrid1.RowCount-1] := FormatFloat(E.FormatMonnaie + ';; ', 0);
              end;
           end
           else
           begin
             GrGrid1.Cells[0,GrGrid1.RowCount-1] := ListeCodeTVA.Strings[i];
             ListeObjet:=TStringList.Create;
             ListeObjet.Add(copy(ListeCodeTVA.Strings[i],1,2)+';1');
             GrGrid1.Objects[0,GrGrid1.RowCount-1]:=ListeObjet;
             if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
              Begin
               if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
                GrGrid1.Cells[1,GrGrid1.RowCount-1] := FormatFloat(E.FormatMonnaie + ';; ', (arrondi(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency,2)-arrondi(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency,2)))
               else
                GrGrid1.Cells[1,GrGrid1.RowCount-1] := FormatFloat(E.FormatMonnaie + ';; ', 0);
              //Soldearrondi:=(arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2)-arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency,2));
              Soldearrondi:=(arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency-DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency,2));
              GrGrid1.Cells[2,GrGrid1.RowCount-1] := FormatFloat(E.FormatMonnaie + ';; ',Soldearrondi );
              End
              else
              Begin
               GrGrid1.Cells[2,GrGrid1.RowCount-1] := FormatFloat(E.FormatMonnaie + ';; ', 0);
              end;
           end;
         end;
      end;
      GrGrid1.AjouteLigne;
      GrGrid1.Cells[0,GrGrid1.RowCount-1] := 'TVA antérieurement déduite à reverser ('+DM_C_CompteTVADeduiteAReverser+')';
//      totauxbalance:=DMDiocEtatBal.SommeTotauxBalanceParCompte(e.DatExoDebut-1,SyntheseTVA.Periode.DateFin,DM_C_CompteTVADeduiteAReverser);
      totauxbalance:=DMDiocEtatBal.SommeTotauxBalanceParCompte(e.DatExoDebut,SyntheseTVA.Periode.DateFin,DM_C_CompteTVADeduiteAReverser);
      if totauxbalance.SoldeDebitCreditFin then
        GrGrid1.Cells[2,GrGrid1.RowCount-1] := FormatFloat(E.FormatMonnaie + ';; ',-totauxbalance.SoldeFin )
      else
        GrGrid1.Cells[2,GrGrid1.RowCount-1] := FormatFloat(E.FormatMonnaie + ';; ',totauxbalance.SoldeFin );
     GrGrid1.AjouteLigne;
     GrGrid1.Cells[0,GrGrid1.RowCount-1] :='Total de la TVA brute due';
     GrGrid1.Cells[1,GrGrid1.RowCount-1] :=FormatFloat(E.FormatMonnaie + ';; ',SommeColonneFormate(GrGrid1,1,1,GrGrid1.RowCount-2));
     GrGrid1.Cells[2,GrGrid1.RowCount-1] :=FormatFloat(E.FormatMonnaie + ';; ',SommeColonneFormate(GrGrid1,2,1,GrGrid1.RowCount-2));


  // GrGrid2 : TVA DEDUCTIBLE
    for k:=0 to GrGrid2.rowcount-1 do
      GrGrid2.rows[k].clear;
    GrGrid2.RowCount := 6;
    GrGrid2.ParamColor:=true;
    GrGrid2.Param:=ParamUtil.CouleurDBGrid;
    GrGrid2.DessineContourLigne:=false;
    GrGrid2.UpDateColor;
    GrGrid2.Cells[1,0] := 'HT';
    GrGrid2.Cells[2,0] := 'TVA';
    GrGrid2.Cells[0,1] := 'Biens constituant des immobilisations';
    //créer et remplir la liste des codes tva correspondant aux immos
    ListeObjet:=TStringList.Create;
    ListeObjet.Add('I*;0');
    GrGrid2.Objects[0,1]:=ListeObjet;

    GrGrid2.Cells[0,2] := 'Autres biens et services';
    //créer et remplir la liste des codes tva correspondant aux Autres biens et services
    ListeObjet:=TStringList.Create;
    FiltrageDataSet(DMREch.TaTvaCodeRech,CreeFiltreOU('TvaCode',['C*']));
    ListeCodeTVATmp:=ChampTableVersListe('TvaCode',DMREch.TaTvaCodeRech);
    for i:=0 to ListeCodeTVATmp.Count-1 do
       begin
          ListeCodeTVATmp[i]:=ListeCodeTVATmp[i]+';0';
       end;
    ListeObjet:=ListeCodeTVATmp;
    ListeObjet.Add(DM_C_CodeTVADefautBienEtService+';0');
    GrGrid2.Objects[0,2]:=ListeObjet;

    GrGrid2.Cells[0,3] := 'Ommissions ou compléments de déductions';
    //rajouter les code A* sauf CodeTVADefautBienEtService
    FiltrageDataSet(DMREch.TaTvaCodeRech,CreeFiltreOU('TvaCode',['A*']));
    ListeCodeTVATmp:=ChampTableVersListe('TvaCode',DMREch.TaTvaCodeRech);
    rang:=ListeCodeTVATmp.IndexOf(DM_C_CodeTVADefautBienEtService);
    if rang<>-1 then  ListeCodeTVATmp.Delete(rang);
    DeFiltrageDataSet(DMREch.TaTvaCodeRech);
    //créer et remplir la liste des codes tva correspondant aux Ommissions ou compléments de déductions
    for i:=0 to ListeCodeTVATmp.Count-1 do
       begin
          ListeCodeTVATmp[i]:=ListeCodeTVATmp[i]+';0';
       end;
    ListeObjet:=TStringList.Create;
    ListeObjet.Assign(ListeCodeTVATmp);
    GrGrid2.Objects[0,3]:=ListeObjet;

    GrGrid2.Cells[0,4] := 'Report du Crédit antérieur ('+DM_C_CompteTVAPourReport+' ; '+DM_C_CompteTVAPourRemboursement+')';
    GrGrid2.Cells[0,5] := 'Total de la TVA déductible';
    GrGrid2.Cells[1,5] := '______________';

    ListeTmp.Clear;
    ListeTmp :=DM_C_ListeCTVAAchat;
    for i:=0 to ListeCodeTVA.Count -1 do
     begin
       StrTmp:=Copy(ListeCodeTVA.Strings[i],1,1);
       if ListeTmp.IndexOf(StrTmp) <> -1 then
        begin
         if StrTmp = 'I' then
          Begin
            if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
               //TotTVADeductibleL1:=TotTVADeductibleL1+arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency,2) - arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2);
               TotTVADeductibleL1:=TotTVADeductibleL1+arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency - DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2);
            if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotHTDeductibleL1:=TotHTDeductibleL1+(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency);
          End;
         if StrTmp = 'A' then
          Begin
           if Copy(ListeCodeTVA.Strings[i],1,2) = DM_C_CodeTVADefautBienEtService then
            Begin
            if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             //TotTVADeductibleL2:=TotTVADeductibleL2+(arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency,2) - arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2));
             TotTVADeductibleL2:=TotTVADeductibleL2+(arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency - DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2));
            if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotHTDeductibleL2:=TotHTDeductibleL2+(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency);
            End
            else
            Begin
            if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             //TotTVADeductibleL3:=TotTVADeductibleL3+(arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency,2) - arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2));
             TotTVADeductibleL3:=TotTVADeductibleL3+(arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency - DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2));
            if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotHTDeductibleL3:=TotHTDeductibleL3+(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency);
            End;
          End;
         if StrTmp = 'C' then
          Begin
            if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             //TotTVADeductibleL2:=TotTVADeductibleL2+(arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency,2) - arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2));
             TotTVADeductibleL2:=TotTVADeductibleL2+(arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency - DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2));
            if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotHTDeductibleL2:=TotHTDeductibleL2+(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency);
          End;
        end;
     end;
    // Col HT
    GrGrid2.Cells[1,1] := FormatFloat(E.FormatMonnaie + ';; ', TotHTDeductibleL1);
    GrGrid2.Cells[1,2] := FormatFloat(E.FormatMonnaie + ';; ', TotHTDeductibleL2);
    GrGrid2.Cells[1,3] := FormatFloat(E.FormatMonnaie + ';; ', TotHTDeductibleL3);
    // Col TVA
    GrGrid2.Cells[2,1] := FormatFloat(E.FormatMonnaie + ';; ', TotTVADeductibleL1);
    GrGrid2.Cells[2,2] := FormatFloat(E.FormatMonnaie + ';; ', TotTVADeductibleL2);
    GrGrid2.Cells[2,3] := FormatFloat(E.FormatMonnaie + ';; ', TotTVADeductibleL3);


    for i:=0 to DMTmTVA.ListeReports.Count-1  do
      Begin
        if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Compte=DM_C_CompteTVAPourReport then
         if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.ATraiter then
           begin
             if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.SoldeDebitCreditFin then
               TotReportL4:=PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.Soldefin
             else
               TotReportL4:=-PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.Soldefin;
           end;

        if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Compte=DM_C_CompteTVAPourRemboursement then
         if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.ATraiter then
           begin
             if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.SoldeDebitCreditFin then
               TotReportL4:=TotReportL4+PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.Soldefin
             else
               TotReportL4:=TotReportL4-PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.Soldefin;
           end;
      End;
   GrGrid2.Cells[2,4] := FormatFloat(E.FormatMonnaie + ';; ',TotReportL4 );
   GrGrid2.Cells[1,GrGrid2.RowCount-1] :=FormatFloat(E.FormatMonnaie + ';; ',SommeColonneFormate(GrGrid2,1,1,GrGrid2.RowCount-2));
   GrGrid2.Cells[2,GrGrid2.RowCount-1] :=FormatFloat(E.FormatMonnaie + ';; ',SommeColonneFormate(GrGrid2,2,1,GrGrid2.RowCount-2));


  // GrGrid3 : OPERATIONS NON IMPOSABLES
    for k:=0 to GrGrid3.rowcount-1 do
      GrGrid3.rows[k].clear;
    GrGrid3.RowCount := 5;
    GrGrid3.RowHeights[0] := 0;
    GrGrid3.ParamColor:=true;
    GrGrid3.Param:=ParamUtil.CouleurDBGrid;
    GrGrid3.DessineContourLigne:=false;
    GrGrid3.Cells[0,0] := '';
    GrGrid3.Cells[0,1] := 'Achats en franchise';
    //créer et remplir la liste des codes tva correspondant aux Achats en franchise
    ListeObjet:=TStringList.Create;
    ListeObjet.Add(DM_C_CodeTVADefautFranchise+';0');
    GrGrid3.Objects[0,1]:=ListeObjet;

    GrGrid3.Cells[0,2] := 'Exportations hors CEE';
    //créer et remplir la liste des codes tva correspondant aux Exportations hors CEE
    ListeObjet:=TStringList.Create;
    ListeObjet.Add('E*;1');
    GrGrid3.Objects[0,2]:=ListeObjet;

    GrGrid3.Cells[0,3] := 'Autres opérations non imposables';
    //créer et remplir la liste des codes tva correspondant aux Autres opérations non imposables
    FiltrageDataSet(DMREch.TaTvaCodeRech,CreeFiltreOU('TvaCode',['N*','F*']));
    ListeCodeTVATmp:=ChampTableVersListe('TvaCode',DMREch.TaTvaCodeRech);
    rang:=ListeCodeTVATmp.IndexOf(DM_C_CodeTVADefautFranchise);
    if rang<>-1 then  ListeCodeTVATmp.Delete(rang);
    for i:=0 to ListeCodeTVATmp.Count-1 do
       begin
          ListeCodeTVATmp[i]:=ListeCodeTVATmp[i]+';1';
       end;
    DeFiltrageDataSet(DMREch.TaTvaCodeRech);
    ListeObjet:=TStringList.Create;
    ListeObjet.Assign(ListeCodeTVATmp);
    GrGrid3.Objects[0,3]:=ListeObjet;

    GrGrid3.Cells[0,4] := 'Dont ventes en Franchise';
    //créer et remplir la liste des codes tva correspondant aux Livraisons intracommunautaires
    ListeObjet:=TStringList.Create;
    ListeObjet.Add('L*;1');
    GrGrid3.Objects[0,4]:=ListeObjet;

    GrGrid3.Cells[0,5] := 'Livraisons intracommunautaires';
    //créer et remplir la liste des codes tva correspondant aux Livraisons intracommunautaires
    ListeObjet:=TStringList.Create;
    ListeObjet.Add('L*;1');
    GrGrid3.Objects[0,5]:=ListeObjet;

    //    GrGrid3.Cells[1,3] := '______________';
    GrGrid3.UpDateColor;

     ListeTmp.Clear;
     ListeTmp :=DM_C_ListeCTVANonImposable;
     TotOpNonImposableL1:=0;
     TotOpNonImposableL2:=0;
     TotOpNonImposableL3:=0;
     TotOpNonImposableL4:=0;


    for i:=0 to ListeCodeTVA.Count -1 do
     begin
       StrTmp:=Copy(ListeCodeTVA.Strings[i],1,1);
//TotOpNonImposableL1,TotOpNonImposableL2,TotOpNonImposableL3,TotOpNonImposableL4:
       if ListeTmp.IndexOf(StrTmp) <> -1 then
        begin
         if StrTmp = 'L' then
          Begin
//            if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
//             TotTVADeductibleL1:=TotTVADeductibleL1+Abs(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency - DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency);
            if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotOpNonImposableL4:=TotOpNonImposableL4+(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency);
          End;
         if (StrTmp = 'N') or (StrTmp = 'F')  then
          Begin
           if Copy(ListeCodeTVA.Strings[i],1,2) = DM_C_CodeTVADefautFranchise then
            Begin
//            if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
//             TotTVADeductibleL2:=TotTVADeductibleL2+Abs(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency - DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency);
            if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             //Debit - crédit (est inversé par rapport aux autres lignes voir contraintes Declaration tva)
             TotOpNonImposableL1:=TotOpNonImposableL1+(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency);
            End
            else
            Begin
//            if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
//             TotTVADeductibleL3:=TotTVADeductibleL3+Abs(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency - DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency);
            if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotOpNonImposableL3:=TotOpNonImposableL3+(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency);
            if(StrTmp='F')then
              begin

              end;
            End;
          End;
         if StrTmp = 'E' then
          Begin
//            if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
//             TotTVADeductibleL2:=TotTVADeductibleL2+Abs(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency - DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency);
            if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotOpNonImposableL2:=TotOpNonImposableL2+(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency);
          End;
        end;
     end;
    GrGrid3.Cells[1,1] := FormatFloat(E.FormatMonnaie + ';; ', TotOpNonImposableL1);
    GrGrid3.Cells[1,2] := FormatFloat(E.FormatMonnaie + ';; ', TotOpNonImposableL2);
    GrGrid3.Cells[1,3] := FormatFloat(E.FormatMonnaie + ';; ', TotOpNonImposableL3);
    GrGrid3.Cells[1,4] := FormatFloat(E.FormatMonnaie + ';; ', TotOpNonImposableL4);

  // GrGrid4 : CALCUL DE LA TVA DUE OU DU CREDIT
    for k:=0 to GrGrid4.rowcount-1 do
      GrGrid4.rows[k].clear;

    GrGrid4.RowCount := 8;
    GrGrid4.RowHeights[0] := 0;
    GrGrid4.ParamColor:=true;
    GrGrid4.Param:=ParamUtil.CouleurDBGrid;
    GrGrid4.DessineContourLigne:=false;
    GrGrid4.Cells[0,0] := '';
    GrGrid4.Cells[0,1] := 'TVA Due';
    GrGrid4.Cells[0,2] := '- TVA déductible';
    GrGrid4.Cells[0,3] := '- Acomptes versés ('+DM_C_CompteTVAAcompteVerse+')';
    GrGrid4.Cells[0,4] := '+ TVA à payer de la période précédente ('+DM_C_CompteTVAAPayer+')';
    GrGrid4.Cells[0,5] := '___________________________________________________';
    GrGrid4.Cells[0,6] := 'Solde à payer';
    GrGrid4.Cells[0,7] := 'ou crédit de TVA';
    GrGrid4.UpDateColor;

    GrGrid4.Cells[1,1] := GrGrid1.cells[2,GrGrid1.rowcount-1];
    GrGrid4.Cells[1,2] := GrGrid2.cells[2,GrGrid2.rowcount-1];
    GrGrid4.Cells[1,3] :=FormatFloat(E.FormatMonnaie + ';; ',0);
    GrGrid4.Cells[1,4] :=FormatFloat(E.FormatMonnaie + ';; ',0);
    GrGrid4.Cells[1,5] := '______________';
    GrGrid4.Cells[1,6] :=FormatFloat(E.FormatMonnaie + ';; ',0);
    GrGrid4.Cells[1,7] :=FormatFloat(E.FormatMonnaie + ';; ',0);

    ///Ligne acompte verses 44581
//     totauxbalance:=DMDiocEtatBal.SommeTotauxBalanceParCompte(e.DatExoDebut-1,SyntheseTVA.Periode.DateFin,DM_C_CompteTVAAcompteVerse);
     totauxbalance:=DMDiocEtatBal.SommeTotauxBalanceParCompte(e.DatExoDebut,SyntheseTVA.Periode.DateFin,DM_C_CompteTVAAcompteVerse);
     if totauxbalance.SoldeDebitCreditFin then
       GrGrid4.Cells[1,3] :=FormatFloat(E.FormatMonnaie + ';; ', totauxbalance.SoldeFin)
     else
       GrGrid4.Cells[1,3] :=FormatFloat(E.FormatMonnaie + ';; ', -totauxbalance.SoldeFin);

    for i:=0 to DMTmTVA.ListeReports.Count-1  do
      Begin
        ///Ligne Tva à payer période précédente 44551
        if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Compte=DM_C_CompteTVAAPayer then
         if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.ATraiter then
           begin
              if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.SoldeDebitCreditFin then
                GrGrid4.Cells[1,4] :=FormatFloat(E.FormatMonnaie + ';; ', -PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.SoldeFin)
              else
                GrGrid4.Cells[1,4] :=FormatFloat(E.FormatMonnaie + ';; ', PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.SoldeFin);
           end;
      end;

//        solde:=SommeColonneFormate(GrGrid4,1,0,3);
        solde:=(SommeColonneFormate(GrGrid4,1,1,1))-(SommeColonneFormate(GrGrid4,1,2,2))-(SommeColonneFormate(GrGrid4,1,3,3))+(SommeColonneFormate(GrGrid4,1,4,4));
        if solde>0 then
          ///Ligne solde à payer
          GrGrid4.Cells[1,6] :=FormatFloat(E.FormatMonnaie + ';; ',abs(solde))
        else
          ///Ligne Crédit de TVA
          GrGrid4.Cells[1,7] :=FormatFloat(E.FormatMonnaie + ';; ',abs(solde));


  Finally
  if ListeTmp <> nil then ListeTmp.Free;
  if ListeTmp2 <> nil then ListeTmp2.Free;
  end;
End;


procedure TSyntheseTVA.PaDroitHResize(Sender: TObject);
begin
BtnPieceTVA.Width := PaDroitH.Width;
end;

procedure TSyntheseTVA.FormCreate(Sender: TObject);
begin
    try
       if DMTmTVA=nil then DMTmTVA:=TDMTmTVA.Create(self);
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        //InitialiseFormPosDefaut(self);
	//Left:= 30; Top:= 70; Width:= screen.Width-60; Height:= screen.Height-top-30;
    end;

BtnEditionetPieceTVA.Caption:='Passer la pièce de TVA'+RetourChariotSimple+ '&&'+RetourChariotSimple+'Editions TVA ...';
CaptionMultiLigne(BtnEditionetPieceTVA);
BtnChADecl.Caption :='Choix du montant'+RetourChariotSimple+ 'à'+RetourChariotSimple+' déclarer';
CaptionMultiLigne(BtnChADecl);

end;

procedure TSyntheseTVA.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TSyntheseTVA.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TSyntheseTVA.BtnPieceTVAClick(Sender: TObject);
var
DateDebTmp,dateFinTmp:TDateTime;
ForceAffichage:TForceAffichage;
begin
try
ForceAffichage.Affiche:=true;
ForceAffichage.Force:=true;
DateDebTmp:=SyntheseTVA.Periode.DateDeb;
dateFinTmp:=SyntheseTVA.Periode.DateFin;
///
//if DMTmTVA.InfosAvantValidation<>nil then
     PieceTVANonPassee:=DMTmTVA.Verif_Si_Date_HorsDeclarationExistante(SyntheseTVA.Periode.DateDeb,SyntheseTVA.Periode.DateFin,false);
     if PieceTVANonPassee.retour then
       begin
         case Messagedlg(PChar('Clôture de la période Tva du '+datetostr(e.DateDebutDeclarationTVA)+' au '+datetostr(e.DateFinDeclarationTVA)+
                                RetourChariotDouble+
                                'Confirmez la génération de la pièce de centralisation TVA pour cette période'
                                ),mtconfirmation, [mbno,mbyes,mbCancel],0) of
            mrno:abort ;
            mryes:begin
                   PieceTVANonPassee.retour:=not DMTmTVA.VAliderDeclarationTVA(SyntheseTVA.Periode.DateDeb,SyntheseTVA.Periode.DateFin,true,ForceAffichage).retour;
                   EditionSyntheseTVAL(C_ExportationImprimable,false,SyntheseTVA.Periode,nil,nil,true);
                  end;
            mrcancel:abort ;
         end;
       end;
///
if not PieceTVANonPassee.retour then
begin
  EtatInitial;
end;
except
  //
end;
end;

procedure TSyntheseTVA.BtnEditionTVAClick(Sender: TObject);
begin
EditionSyntheseTVAL(C_EditionSimple,false,SyntheseTVA.Periode,nil,nil);
end;

procedure TSyntheseTVA.BtnFermerClick(Sender: TObject);
begin
self.close;
end;

procedure TSyntheseTVA.BtnChReportClick(Sender: TObject);
var
ForceAffichage:TForceAffichage;
ReportTmp:TReport;
ListeReportTmp:Tlist;
begin
try
ForceAffichage.Affiche:=false;
ForceAffichage.Force:=false;
   ViderTable(DMTmTVA.TaDec_Tva);

   ListeReportTmp:=TList.Create;
   AssignListe(DMTmTVA.ListeReports,ListeReportTmp);
   ReportTmp:=DMTmTVA.TotauxReport;
   DMTmTVA.TotauxReport:=CalculReport(true,DMTmTVA.listeReports,SyntheseTVA.Periode.DateDeb,SyntheseTVA.Periode.DateFin);
   if not DMTmTVA.TotauxReport.Retour then
     begin //si echap, réinitialiser avec anciens reports
       DMTmTVA.TotauxReport:=ReportTmp;
       AssignListe(ListeReportTmp,DMTmTVA.ListeReports);
     end;
   //sauvegarder historique des reports
   PatienterAffich;
   CalculDeclarationTva(SyntheseTVA.Periode.DateDeb,SyntheseTVA.Periode.DateFin);
   PatienterFermer;
   DMTmTVA.VAliderDeclarationTVA(SyntheseTVA.Periode.DateDeb,SyntheseTVA.Periode.DateFin,false,ForceAffichage);
   SyntheseTVA.InitGrille;
finally
  if ListeReportTmp<>nil then ListeReportTmp.free;
end;
end;

procedure TSyntheseTVA.BtnChADeclClick(Sender: TObject);
var
ForceAffichage:TForceAffichage;
begin
ForceAffichage.Affiche:=true;
ForceAffichage.Force:=true;
   ViderTable(DMTmTVA.TaDec_Tva);
   //sauvegarder historique des reports
   PatienterAffich;
   CalculDeclarationTva(SyntheseTVA.Periode.DateDeb,SyntheseTVA.Periode.DateFin);
   PatienterFermer;
   DMTmTVA.VAliderDeclarationTVA(SyntheseTVA.Periode.DateDeb,SyntheseTVA.Periode.DateFin,false,ForceAffichage);
   SyntheseTVA.InitGrille;
end;

procedure TSyntheseTVA.GrGrid1DrawCell(Sender: TObject; Col, Row: Integer;
  Rect: TRect; State: TGridDrawState);
var
HoldColor:TColor;
begin
if ((col in [1,2] )and(row=grgrid1.RowCount-1))  then
 begin
      HoldColor:=grgrid1.Canvas.Brush.Color;
      grgrid1.Canvas.Brush.Color :=$00ADEBFF;
      grgrid1.Canvas.FillRect(Rect);
      grgrid1.Canvas.TextRect(Rect,Rect.BottomRight.x-4-grgrid1.Canvas.TextWidth(grgrid1.Cells[col,row]),Rect.TopLeft.y+3,grgrid1.Cells[col,row]);
      grgrid1.Canvas.Brush.Color:=HoldColor;
 end;
end;

procedure TSyntheseTVA.GrGrid2DrawCell(Sender: TObject; Col, Row: Integer;
  Rect: TRect; State: TGridDrawState);
var
HoldColor:TColor;
begin
if ((col in [1,2] )and(row=grgrid2.RowCount-1))  then
 begin
      HoldColor:=grgrid2.Canvas.Brush.Color;
      grgrid2.Canvas.Brush.Color :=$00ADEBFF;
      grgrid2.Canvas.FillRect(Rect);
      grgrid2.Canvas.TextRect(Rect,Rect.BottomRight.x-4-grgrid2.Canvas.TextWidth(grgrid2.Cells[col,row]),Rect.TopLeft.y+3,grgrid2.Cells[col,row]);
      grgrid2.Canvas.Brush.Color:=HoldColor;
 end;
end;


procedure TSyntheseTVA.GrGrid4DrawCell(Sender: TObject; Col, Row: Integer;
  Rect: TRect; State: TGridDrawState);
var
HoldColor:TColor;
begin
if ((col in [0,1] )and(row in [grgrid4.RowCount-1,grgrid4.RowCount-2]))  then
 begin
      HoldColor:=grgrid4.Canvas.Brush.Color;
      grgrid4.Canvas.Brush.Color :=$00ADEBFF;
      grgrid4.Canvas.FillRect(Rect);
      if col = 0 then
         grgrid4.Canvas.TextRect(Rect,Rect.Left+2,Rect.TopLeft.y+3,grgrid4.Cells[col,row])
      else
         grgrid4.Canvas.TextRect(Rect,Rect.BottomRight.x-4-grgrid4.Canvas.TextWidth(grgrid4.Cells[col,row]),Rect.TopLeft.y+3,grgrid4.Cells[col,row]);
      grgrid4.Canvas.Brush.Color:=HoldColor;
 end;
end;





procedure TSyntheseTVA.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  WinSuivPrec(Handle,key,[nil]);
     If Key = VK_ESCAPE Then
     Begin
       Key:= 0;
       self.close;
     End;
end;

procedure TSyntheseTVA.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TSyntheseTVA.BtnEditionetPieceTVAClick(Sender: TObject);
begin
BtnEditionTVAClick(BtnEditionTVA);
BtnPieceTVAClick(BtnPieceTVA);
//+ rajouter l'édition de cette tva
end;

procedure TSyntheseTVA.BtnJournauxClick(Sender: TObject);
begin
AffichInfoDeclarationTVA(RqDec_Tva_SommeTvaParCode_1);
end;

procedure TSyntheseTVA.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(self,E.User);
//if DMTmTVA<>nil then DMTmTVA.free;
SyntheseTVA:=nil;
end;

procedure TSyntheseTVA.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
button2.enabled:=FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'ControleTvaEnAttente.txt');
end;

procedure TSyntheseTVA.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if not CanClose then
 begin
    if DMTmTVA=nil then
   DMTmTVA:=DMTmTVA.Create(self);

//   if AideCompte=nil then
//   AideCompte:=TAideCompte.Create(self);
 end;

end;
procedure TSyntheseTVA.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
TotauxGeneric:TTotauxGeneric;
ForceAffichage:TForceAffichage;
begin
try
ForceAffichage.Affiche:=true;
ForceAffichage.Force:=false;
//if DMTmTVA.InfosAvantValidation<>nil then
if BtnPieceTVA.Enabled then
  begin
     PieceTVANonPassee:=DMTmTVA.Verif_Si_Date_HorsDeclarationExistante(SyntheseTVA.Periode.DateDeb,SyntheseTVA.Periode.DateFin,false);
     if PieceTVANonPassee.retour then
       begin
         case Messagedlg(PChar('Vous venez de calculer la déclaraton Tva pour la période du '+datetostr(e.DateDebutDeclarationTVA)+' au '+datetostr(e.DateFinDeclarationTVA)+
                                RetourChariotDouble+
                                'Voulez-vous générez la pièce de centralisation TVA et ainsi clôturer cette période ?'
                                ),mtconfirmation, [mbno,mbyes,mbCancel],0) of
            //mrno:Action := caHide ;
            mryes:begin
                    DMTmTVA.VAliderDeclarationTVA(SyntheseTVA.Periode.DateDeb,SyntheseTVA.Periode.DateFin,true,ForceAffichage);
                    EditionSyntheseTVAL(C_ExportationImprimable,false,SyntheseTVA.Periode,nil,nil,true);
                  end;
            mrcancel:Action := caNone ;
         end;
       end
      else
       begin
     //    case PieceTVANonPassee.NumErreur of
     //      101:;//
     //      102:;
     //    end;

       end;
  end;
except
   abort;
end;

end;

procedure TSyntheseTVA.BtnDetailClick(Sender: TObject);
var
DetailTVAAffich:TDetailTVAAffich;
begin
initialise_TDetailTVAAffich(DetailTVAAffich);
DetailTVAAffich.Periode.DateDeb:=Self.Periode.DateDeb;
DetailTVAAffich.Periode.Datefin:=Self.Periode.DateFin;
AffichDetailDeclarationTVA(DetailTVAAffich);
end;

procedure TSyntheseTVA.GrGrid1DblClick(Sender: TObject);
begin
DtailsF71Click(DtailsF71);
end;


procedure TSyntheseTVA.GrGrid2DblClick(Sender: TObject);
begin
DtailsF71Click(dtailsF71);
end;

procedure TSyntheseTVA.GrGrid3DblClick(Sender: TObject);
begin
DtailsF71Click(DtailsF71);
end;

procedure TSyntheseTVA.DtailsF71Click(Sender: TObject);
var
DetailTVAAffich:TDetailTVAAffich;
begin
if ((activecontrol = GrGrid1)or(activecontrol = GrGrid2)or(activecontrol = GrGrid3)) then
  begin
    if ActiveControl=GrGrid1 then
        Sender:=GrGrid1;
    if ActiveControl=GrGrid2 then
        Sender:=GrGrid2;
    if ActiveControl=GrGrid3 then
        Sender:=GrGrid3;

      if (Sender as TGrGrid).Objects[0,(Sender as TGrGrid).row]<>nil then
        begin//si colonne remplie
         if ((Sender as TGrGrid).Objects[0,(Sender as TGrGrid).row] as Tstringlist).Count<>0 then
           begin
              initialise_TDetailTVAAffich(DetailTVAAffich);
              DetailTVAAffich.Periode.DateDeb:=e.DateDebutDeclarationTVA;
              DetailTVAAffich.Periode.DateFin:=e.DateFinDeclarationTVA;
              DetailTVAAffich.Calculer:=AffichCalcul;
              DetailTVAAffich.ListeCodes.Clear;
              DetailTVAAffich.ListeCodes.Assign(((Sender as TGrGrid).Objects[0,(Sender as TGrGrid).row] as Tstringlist));
              DetailTVAAffich.En_Attente:=Pas_En_Attente;
              AffichDetailDeclarationTVA(DetailTVAAffich);
              //AffichDeclarationTVASurPeriode(DetailTVAAffich);
           end;
        end;//fin si colonne remplie
  end;
end;

Procedure TSyntheseTVA.InitEdition;
var
ListeCodeTVA,ListeCodeTVATmp,ListeTmp,ListeTmp2:TStringList;
i,j,k:integer;
StrTmp:String;
ListeObjet:TStringList;
totauxbalance:Ttotauxbalance;
solde,Soldearrondi:currency;
// TVA DEDUCTIBLE
TotTVADeductibleL1,TotTVADeductibleL2,TotTVADeductibleL3:currency;
TotHTDeductibleL1,TotHTDeductibleL2,TotHTDeductibleL3:currency;
TotReportL4:currency;
// OPERATION NON IMPOSABLE
TotOpNonImposableL1,TotOpNonImposableL2,TotOpNonImposableL3,TotOpNonImposableL4:currency;
rang:integer;
Begin
 try
TotTVADeductibleL1:=0;
TotTVADeductibleL2:=0;
TotTVADeductibleL3:=0;
TotHTDeductibleL1:=0;
TotHTDeductibleL2:=0;
TotHTDeductibleL3:=0;
TotReportL4:=0;
// OPERATION NON IMPOSABLE
TotOpNonImposableL1:=0;
TotOpNonImposableL2:=0;
TotOpNonImposableL3:=0;
TotOpNonImposableL4:=0;



  // GrGrid2 : TVA DEDUCTIBLE
    for k:=0 to GrGrid2.rowcount-1 do
      GrGrid2.rows[k].clear;
    GrGrid2.RowCount := 6;
    GrGrid2.ParamColor:=true;
    GrGrid2.Param:=ParamUtil.CouleurDBGrid;
    GrGrid2.DessineContourLigne:=false;
    GrGrid2.UpDateColor;
    GrGrid2.Cells[1,0] := 'HT';
    GrGrid2.Cells[2,0] := 'TVA';
    GrGrid2.Cells[0,1] := 'Biens constituant des immobilisations';
    //créer et remplir la liste des codes tva correspondant aux immos
    ListeObjet:=TStringList.Create;
    ListeObjet.Add('I*');
    GrGrid2.Objects[0,1]:=ListeObjet;

    GrGrid2.Cells[0,2] := 'Autres biens et services';
    //créer et remplir la liste des codes tva correspondant aux Autres biens et services
    ListeObjet:=TStringList.Create;
    ListeObjet.Add(DM_C_CodeTVADefautBienEtService);
    GrGrid2.Objects[0,2]:=ListeObjet;

    GrGrid2.Cells[0,3] := 'Ommissions ou compléments de déductions';
    //rajouter les code A* sauf CodeTVADefautBienEtService
    FiltrageDataSet(DMREch.TaTvaCodeRech,CreeFiltreOU('TvaCode',['A*']));
    ListeCodeTVATmp:=ChampTableVersListe('TvaCode',DMREch.TaTvaCodeRech);
    rang:=ListeCodeTVATmp.IndexOf(DM_C_CodeTVADefautBienEtService);
    if rang<>-1 then  ListeCodeTVATmp.Delete(rang);
    DeFiltrageDataSet(DMREch.TaTvaCodeRech);
    //créer et remplir la liste des codes tva correspondant aux Ommissions ou compléments de déductions
    ListeObjet:=TStringList.Create;
    ListeObjet.Assign(ListeCodeTVATmp);
    GrGrid2.Objects[0,3]:=ListeObjet;

    GrGrid2.Cells[0,4] := 'Report du Crédit antérieur ('+DM_C_CompteTVAPourReport+' ; '+DM_C_CompteTVAPourRemboursement+')';
    GrGrid2.Cells[0,5] := 'Total de la TVA déductible';
    GrGrid2.Cells[1,5] := '______________';

    ListeTmp.Clear;
    ListeTmp :=DM_C_ListeCTVAAchat;
    for i:=0 to ListeCodeTVA.Count -1 do
     begin
       StrTmp:=Copy(ListeCodeTVA.Strings[i],1,1);
       if ListeTmp.IndexOf(StrTmp) <> -1 then
        begin
         if StrTmp = 'I' then
          Begin
            if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
               //TotTVADeductibleL1:=TotTVADeductibleL1+arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency,2) - arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2);
               TotTVADeductibleL1:=TotTVADeductibleL1+arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency - DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2);
            if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotHTDeductibleL1:=TotHTDeductibleL1+(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency);
          End;
         if StrTmp = 'A' then
          Begin
           if Copy(ListeCodeTVA.Strings[i],1,2) = DM_C_CodeTVADefautBienEtService then
            Begin
            if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             //TotTVADeductibleL2:=TotTVADeductibleL2+(arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency,2) - arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2));
             TotTVADeductibleL2:=TotTVADeductibleL2+(arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency - DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2));
            if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotHTDeductibleL2:=TotHTDeductibleL2+(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency);
            End
            else
            Begin
            if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             //TotTVADeductibleL3:=TotTVADeductibleL3+(arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency,2) - arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2));
             TotTVADeductibleL3:=TotTVADeductibleL3+(arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency - DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2));
            if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotHTDeductibleL3:=TotHTDeductibleL3+(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency);
            End;
          End;
         if StrTmp = 'C' then
          Begin
            if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             //TotTVADeductibleL2:=TotTVADeductibleL2+(arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency,2) - arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2));
             TotTVADeductibleL2:=TotTVADeductibleL2+(arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency - DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2));
            if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotHTDeductibleL2:=TotHTDeductibleL2+(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency);
          End;
        end;
     end;
    // Col HT
    GrGrid2.Cells[1,1] := FormatFloat(E.FormatMonnaie + ';; ', TotHTDeductibleL1);
    GrGrid2.Cells[1,2] := FormatFloat(E.FormatMonnaie + ';; ', TotHTDeductibleL2);
    GrGrid2.Cells[1,3] := FormatFloat(E.FormatMonnaie + ';; ', TotHTDeductibleL3);
    // Col TVA
    GrGrid2.Cells[2,1] := FormatFloat(E.FormatMonnaie + ';; ', TotTVADeductibleL1);
    GrGrid2.Cells[2,2] := FormatFloat(E.FormatMonnaie + ';; ', TotTVADeductibleL2);
    GrGrid2.Cells[2,3] := FormatFloat(E.FormatMonnaie + ';; ', TotTVADeductibleL3);


    for i:=0 to DMTmTVA.ListeReports.Count-1  do
      Begin
        if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Compte=DM_C_CompteTVAPourReport then
         if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.ATraiter then
           begin
             if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.SoldeDebitCreditFin then
               TotReportL4:=PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.Soldefin
             else
               TotReportL4:=-PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.Soldefin;
           end;

        if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Compte=DM_C_CompteTVAPourRemboursement then
         if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.ATraiter then
           begin
             if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.SoldeDebitCreditFin then
               TotReportL4:=TotReportL4+PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.Soldefin
             else
               TotReportL4:=TotReportL4-PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.Soldefin;
           end;
      End;
   GrGrid2.Cells[2,4] := FormatFloat(E.FormatMonnaie + ';; ',TotReportL4 );
   GrGrid2.Cells[1,GrGrid2.RowCount-1] :=FormatFloat(E.FormatMonnaie + ';; ',SommeColonneFormate(GrGrid2,1,1,GrGrid2.RowCount-2));
   GrGrid2.Cells[2,GrGrid2.RowCount-1] :=FormatFloat(E.FormatMonnaie + ';; ',SommeColonneFormate(GrGrid2,2,1,GrGrid2.RowCount-2));


  // GrGrid3 : OPERATIONS NON IMPOSABLES
    for k:=0 to GrGrid3.rowcount-1 do
      GrGrid3.rows[k].clear;
    GrGrid3.RowCount := 5;
    GrGrid3.RowHeights[0] := 0;
    GrGrid3.ParamColor:=true;
    GrGrid3.Param:=ParamUtil.CouleurDBGrid;
    GrGrid3.DessineContourLigne:=false;
    GrGrid3.Cells[0,0] := '';
    GrGrid3.Cells[0,1] := 'Achats en franchise';
    //créer et remplir la liste des codes tva correspondant aux Achats en franchise
    ListeObjet:=TStringList.Create;
    ListeObjet.Add(DM_C_CodeTVADefautFranchise);
    GrGrid3.Objects[0,1]:=ListeObjet;

    GrGrid3.Cells[0,2] := 'Exportations hors CEE';
    //créer et remplir la liste des codes tva correspondant aux Exportations hors CEE
    ListeObjet:=TStringList.Create;
    ListeObjet.Add('E*');
    GrGrid3.Objects[0,2]:=ListeObjet;

    GrGrid3.Cells[0,3] := 'Autres opérations non imposables';
    //créer et remplir la liste des codes tva correspondant aux Autres opérations non imposables
    FiltrageDataSet(DMREch.TaTvaCodeRech,CreeFiltreOU('TvaCode',['N*']));
    ListeCodeTVATmp:=ChampTableVersListe('TvaCode',DMREch.TaTvaCodeRech);
    rang:=ListeCodeTVATmp.IndexOf(DM_C_CodeTVADefautFranchise);
    if rang<>-1 then  ListeCodeTVATmp.Delete(rang);
    DeFiltrageDataSet(DMREch.TaTvaCodeRech);
    ListeObjet:=TStringList.Create;
    ListeObjet.Assign(ListeCodeTVATmp);
    GrGrid3.Objects[0,3]:=ListeObjet;

    GrGrid3.Cells[0,4] := 'Livraisons intracommunautaires';
    //créer et remplir la liste des codes tva correspondant aux Livraisons intracommunautaires
    ListeObjet:=TStringList.Create;
    ListeObjet.Add('L*');
    GrGrid3.Objects[0,4]:=ListeObjet;

    //    GrGrid3.Cells[1,3] := '______________';
    GrGrid3.UpDateColor;

     ListeTmp.Clear;
     ListeTmp :=DM_C_ListeCTVANonImposable;
     TotOpNonImposableL1:=0;
     TotOpNonImposableL2:=0;
     TotOpNonImposableL3:=0;
     TotOpNonImposableL4:=0;

    for i:=0 to ListeCodeTVA.Count -1 do
     begin
       StrTmp:=Copy(ListeCodeTVA.Strings[i],1,1);
//TotOpNonImposableL1,TotOpNonImposableL2,TotOpNonImposableL3,TotOpNonImposableL4:
       if ListeTmp.IndexOf(StrTmp) <> -1 then
        begin
         if StrTmp = 'L' then
          Begin
//            if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
//             TotTVADeductibleL1:=TotTVADeductibleL1+Abs(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency - DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency);
            if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotOpNonImposableL4:=TotOpNonImposableL4+(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency);
          End;
         if (StrTmp = 'N')or(StrTmp = 'F') then
          Begin
           if Copy(ListeCodeTVA.Strings[i],1,2) = DM_C_CodeTVADefautFranchise then
            Begin
//            if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
//             TotTVADeductibleL2:=TotTVADeductibleL2+Abs(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency - DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency);
            if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             //Debit - crédit (est inversé par rapport aux autres lignes voir contraintes Declaration tva)
             TotOpNonImposableL1:=TotOpNonImposableL1+(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency);
            End
            else
            Begin
//            if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
//             TotTVADeductibleL3:=TotTVADeductibleL3+Abs(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency - DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency);
            if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotOpNonImposableL3:=TotOpNonImposableL3+(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency);
            if(StrTmp = 'F')then
              begin

              end;
            End;
          End;
         if StrTmp = 'E' then
          Begin
//            if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
//             TotTVADeductibleL2:=TotTVADeductibleL2+Abs(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency - DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency);
            if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotOpNonImposableL2:=TotOpNonImposableL2+(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency);
          End;
        end;
     end;
    GrGrid3.Cells[1,1] := FormatFloat(E.FormatMonnaie + ';; ', TotOpNonImposableL1);
    GrGrid3.Cells[1,2] := FormatFloat(E.FormatMonnaie + ';; ', TotOpNonImposableL2);
    GrGrid3.Cells[1,3] := FormatFloat(E.FormatMonnaie + ';; ', TotOpNonImposableL3);
    GrGrid3.Cells[1,4] := FormatFloat(E.FormatMonnaie + ';; ', TotOpNonImposableL4);

  // GrGrid4 : CALCUL DE LA TVA DUE OU DU CREDIT
    for k:=0 to GrGrid4.rowcount-1 do
      GrGrid4.rows[k].clear;

    GrGrid4.RowCount := 8;
    GrGrid4.RowHeights[0] := 0;
    GrGrid4.ParamColor:=true;
    GrGrid4.Param:=ParamUtil.CouleurDBGrid;
    GrGrid4.DessineContourLigne:=false;
    GrGrid4.Cells[0,0] := '';
    GrGrid4.Cells[0,1] := 'TVA Due';
    GrGrid4.Cells[0,2] := '- TVA déductible';
    GrGrid4.Cells[0,3] := '- Acomptes versés ('+DM_C_CompteTVAAcompteVerse+')';
    GrGrid4.Cells[0,4] := '+ TVA à payer de la période précédente ('+DM_C_CompteTVAAPayer+')';
    GrGrid4.Cells[0,5] := '________________________________';
    GrGrid4.Cells[0,6] := 'Solde à payer';
    GrGrid4.Cells[0,7] := 'ou crédit de TVA';
    GrGrid4.UpDateColor;

    GrGrid4.Cells[1,1] := GrGrid1.cells[2,GrGrid1.rowcount-1];
    GrGrid4.Cells[1,2] := GrGrid2.cells[2,GrGrid2.rowcount-1];
    GrGrid4.Cells[1,3] :=FormatFloat(E.FormatMonnaie + ';; ',0);
    GrGrid4.Cells[1,4] :=FormatFloat(E.FormatMonnaie + ';; ',0);
    GrGrid4.Cells[1,5] := '______________';
    GrGrid4.Cells[1,6] :=FormatFloat(E.FormatMonnaie + ';; ',0);
    GrGrid4.Cells[1,7] :=FormatFloat(E.FormatMonnaie + ';; ',0);

    ///Ligne acompte verses 44581
//     totauxbalance:=DMDiocEtatBal.SommeTotauxBalanceParCompte(e.DatExoDebut-1,SyntheseTVA.Periode.DateFin,DM_C_CompteTVAAcompteVerse);
     totauxbalance:=DMDiocEtatBal.SommeTotauxBalanceParCompte(e.DatExoDebut,SyntheseTVA.Periode.DateFin,DM_C_CompteTVAAcompteVerse);
     if totauxbalance.SoldeDebitCreditFin then
       GrGrid4.Cells[1,3] :=FormatFloat(E.FormatMonnaie + ';; ', totauxbalance.SoldeFin)
     else
       GrGrid4.Cells[1,3] :=FormatFloat(E.FormatMonnaie + ';; ', -totauxbalance.SoldeFin);

    for i:=0 to DMTmTVA.ListeReports.Count-1  do
      Begin
        ///Ligne Tva à payer période précédente 44551
        if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Compte=DM_C_CompteTVAAPayer then
         if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.ATraiter then
           begin
              if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.SoldeDebitCreditFin then
                GrGrid4.Cells[1,4] :=FormatFloat(E.FormatMonnaie + ';; ', -PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.SoldeFin)
              else
                GrGrid4.Cells[1,4] :=FormatFloat(E.FormatMonnaie + ';; ', PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.SoldeFin);
           end;
      end;

//        solde:=SommeColonneFormate(GrGrid4,1,0,3);
        solde:=(SommeColonneFormate(GrGrid4,1,1,1))-(SommeColonneFormate(GrGrid4,1,2,2))-(SommeColonneFormate(GrGrid4,1,3,3))+(SommeColonneFormate(GrGrid4,1,4,4));
        if solde>0 then
          ///Ligne solde à payer
          GrGrid4.Cells[1,6] :=FormatFloat(E.FormatMonnaie + ';; ',abs(solde))
        else
          ///Ligne Crédit de TVA
          GrGrid4.Cells[1,7] :=FormatFloat(E.FormatMonnaie + ';; ',abs(solde));


  //// GrGrid5 : CREDIT DE TVA
  //  GrGrid5.RowCount := 2;
  //  GrGrid5.ParamColor:=true;
  //  GrGrid5.Param:=ParamUtil.CouleurDBGrid;
  //  GrGrid5.DessineContourLigne:=false;
  //  GrGrid5.Cells[0,0] := 'Remboursement demandé';
  //  GrGrid5.Cells[0,1] := 'Crédit à reporter sur la prochaine déclaration';
  //  GrGrid5.UpDateColor;
  //
  //// GrGrid6 : TAXES A PAYER
  //  GrGrid6.RowCount := 3;
  //  GrGrid6.ParamColor:=true;
  //  GrGrid6.Param:=ParamUtil.CouleurDBGrid;
  //  GrGrid6.DessineContourLigne:=false;
  //  GrGrid6.Cells[0,0] := 'Solde à payer';
  //  GrGrid6.Cells[0,1] := 'Taxes (fiscales, parafiscales, assimilées)';
  //  GrGrid6.Cells[0,2] := 'Total à payer';
  //  GrGrid6.UpDateColor;
  //
  //// GrGrid7 : AUTRES INFORMATIONS
  //  GrGrid7.RowCount := 2;
  //  GrGrid7.ParamColor:=true;
  //  GrGrid7.Param:=ParamUtil.CouleurDBGrid;
  //  GrGrid7.DessineContourLigne:=false;
  //  GrGrid7.Cells[0,0] := 'En cas de franchise, montant du chiffre d''affaire TTC';
  //  GrGrid7.Cells[0,1] := 'Pourcentage de déduction si différent de 100%';
  //  GrGrid7.UpDateColor;
  //
  //// GrGrid8 : AUTRES INFORMATIONS SUR LES TAXES
  //  GrGrid8.RowCount := 6;
  //  GrGrid8.ParamColor:=true;
  //  GrGrid8.Param:=ParamUtil.CouleurDBGrid;
  //  GrGrid8.DessineContourLigne:=false;
  //  GrGrid8.Cells[0,0] := 'Taxes forfaitaire au profit de l''ANDA';
  //  GrGrid8.Cells[0,1] := 'Taxes sur les produits de l''horticulture et des pépinières';
  //  GrGrid8.Cells[0,2] := 'Taxes sur certaines dépenses de publicité';
  //  GrGrid8.Cells[0,3] := 'Taxes sur les huiles alimentaire BAPSA';
  //  GrGrid8.Cells[0,4] := 'Total des taxes';
  //  GrGrid8.UpDateColor;
  //
  Finally
  if ListeTmp <> nil then ListeTmp.Free;
  if ListeTmp2 <> nil then ListeTmp2.Free;
  end;
End;


procedure TSyntheseTVA.FormShow(Sender: TObject);
begin
BtnFermer.SetFocus;
end;

procedure TSyntheseTVA.Button2Click(Sender: TObject);
var
ForceAffichage:TForceAffichage;
begin
  try
      ForceAffichage.Affiche:=false;
      ForceAffichage.Force:=false;
      if AffichInfoControleTVA_En_Attente then
        Begin
          PatienterAffich;
          ViderTable(DMTmTVA.TaDec_Tva);
          //calcul déclaration sans contrôle puisqu'il est déjà fait
          CalculDeclarationTva(e.DateDebutDeclarationTVA,e.DateFinDeclarationTVA,false);
          DMTmTVA.VAliderDeclarationTVA(e.DateDebutDeclarationTVA,e.DateFinDeclarationTVA,false,ForceAffichage);
          SyntheseTVA.EtatInitial;
          SyntheseTVA.InitGrille;
        end;
//      else
//
  finally
    PatienterFermer;
  end;
end;

procedure TSyntheseTVA.Versionimprimable1Click(Sender: TObject);
begin
EditionSyntheseTVAL(C_ExportationImprimable,false,SyntheseTVA.Periode,nil,nil);
end;

procedure TSyntheseTVA.Versionsimple1Click(Sender: TObject);
begin
EditionSyntheseTVAL(C_Exportation,false,SyntheseTVA.Periode,nil,nil);
end;

procedure TSyntheseTVA.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(nil);
end;

end.
