{***************************************************************
 *
 * Unit Name: E2_DetailAcquis
 * Purpose  :
 * Author   : Blanchard
 * History  :
 *
 ****************************************************************}
{//////// le 29-04-03  Modif_Isa
j'ai modifier la fonction �tatinitial et tout ce qui comporte la fonction 'Amortissable'
///////}
unit E2_DetailAcquis;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Gr_Librairie_obj, DBCtrls, ComCtrls, Db, Mask,
  DBTables, Buttons, ToolEdit, GrGrid,Lib1,LibRessourceString,
  Grids, RXDBCtrl, RXCtrls, DBGrids, ExRxDBGrid, GrDBGrid,E2_Decl_Records,
  Menus,E2_TauxAmortissement,E2_ChoixAmortissement,DMPiece,LibDates,
  DMImmo_Clot,DMConstantes,LibSQL, LibGestionParamXML, jpeg,lib_chaine,
  ShellCtrls;

type

  TParamAffichageDetailAcquis=Record
   Affiche:Boolean;
   AffichageModal:Boolean;
   Quand:Integer;
   TitreForm:String;
   SousTitreForm:String;
   TypePresentation:integer; {C_ACQUISITION_Terminee,C_ACQUISITION_En_Cours,C_ACQUISITION_Simple}
   QuiAppel:TTypeFenetre;
   Maintenance:boolean;
   end;

  TDetailAcquis = class(TForm)
    PopupMenuTAux: TPopupMenu;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    ImPrimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    MenuItem6: TMenuItem;
    Enregister1: TMenuItem;
    Insrer1: TMenuItem;
    Modifier1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    MenuItem13: TMenuItem;
    Prcdent1: TMenuItem;
    Suivant1: TMenuItem;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaDetailCorp: TPanel;
    PaEnteteDescrip: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Libelle: TDBEdit;
    Sous_Code: TDBEdit;
    Compte: TDBEdit;
    Code: TDBEdit;
    PaDescription: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    ValeurAcquis: TDBEdit;
    DureeAmo: TDBEdit;
    DeducInvest: TDBEdit;
    rgTypeAmo: TDBRadioGroup;
    DateAcquis: TDBDateEdit;
    DateDebutAmo: TDBDateEdit;
    RGChoix: TRadioGroup;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    Panel2: TPanel;
    PaCalcul: TPanel;
    GrAmort: TGrGrid;
    PaImmosEnCours: TPanel;
    GrImmosATerminer: TGrDBGrid;
    PaCptIntit: TPanel;
    Panel4: TPanel;
    Tauxamortissement1: TMenuItem;
    Label1: TLabel;
    DBChoix: TDBEdit;
    EdChoix: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    procedure FormActivate(Sender: TObject);
    procedure DureeAmoExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rgTypeAmoClick(Sender: TObject);
    procedure etatinitial;
    procedure affiche(typeAmort:integer);
    procedure DateAcquisExit(Sender: TObject);
    procedure DateDebutAmoExit(Sender: TObject);
   // function CtrlSaisieDescriptionAmort(EditCourant:Tfield;Control,CtrlSuivant:twincontrol):TErreurSaisie;
    procedure PaEnteteExit(Sender: TObject);
    procedure ValeurAcquisExit(Sender: TObject);
    procedure LibelleExit(Sender: TObject);
    procedure PaImmosEnCoursExit(Sender: TObject);
    procedure InitialiserGrille;
    procedure GrImmosATerminerCellClick(Column: TColumn);
    procedure GrImmosATerminerColExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TauxAmortissement1Click(Sender: TObject);
    procedure RGChoixClick(Sender: TObject);
    procedure DureeAmoEnter(Sender: TObject);
    procedure taDetailImmoAfterScroll(DataSet: TDataSet);
    procedure RGChoixEnter(Sender: TObject);
    procedure rgTypeAmoExit(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure CodeExit(Sender: TObject);
    procedure Sous_CodeExit(Sender: TObject);
    procedure changementEtatBoutons(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    Procedure GestionInitDM;
    Procedure GereAccesEcran;
    procedure GrImmosATerminerDblClick(Sender: TObject);
    procedure GrImmosATerminerKeyPress(Sender: TObject; var Key: Char);
    procedure GrImmosATerminerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Calculatrice1Click(Sender: TObject);
    procedure GrImmosATerminerColEnter(Sender: TObject);
  private
    { D�clarations priv�es }
    //procedure Amort_lin;
    procedure Amort_lin_SurBase360;
    procedure Amort_degr;
	 function Calcul_nb_mois(Restant : integer) : integer;
	 procedure Enregistre;
  public
    { D�clarations publiques }
   ListeValeurAmort:tstringlist;
    TitreForm,SousTitreForm:String;
    Quand:Integer;
    typeImmos:TtypeImmos;
      Maintenance: boolean;
 end;

const
   csWidth = 460;		//Largeur de base de la feuille
   csHeight = 237;   //Hauteur de base de la feuille
   CColWidths :Array[0..2] of Integer = (200,125,125);
var
  DetailAcquis: TDetailAcquis;
  nb_Exo:integer;
  Taux:currency;
  DureeTmp,ChoixEnter:integer;



  Function DetailAcquisAffiche(ParamAffichageDetailAcquis:TParamAffichageDetailAcquis):boolean;

implementation

uses DMImmos, E2_Librairie_obj, {Gr_AideDate,}LibZoneSaisie, E2_Main,
  LibClassObjetSenders, E2_AideCompte;

{$R *.DFM}
Function DetailAcquisAffiche(ParamAffichageDetailAcquis:TParamAffichageDetailAcquis):boolean;
var
ParamDMImmos:TParamDMImmos;
Begin
try
///etatinitial(mise � z�ro)
Initialise_ParamDMimmos(ParamDMImmos);
////fin etatInitial

 if (DetailAcquis = nil) then DetailAcquis:=TDetailAcquis.Create(Application.MainForm);
 if ((ParamAffichageDetailAcquis.Quand <> DetailAcquis.Quand) and (DetailAcquis.Visible=true)) then
   DetailAcquis.Close;
 DetailAcquis.Quand:=ParamAffichageDetailAcquis.Quand;
 ////
 DetailAcquis.Tag:=ParamAffichageDetailAcquis.TypePresentation;
 DetailAcquis.Maintenance:=ParamAffichageDetailAcquis.Maintenance;
 {C_ACQUISITION_Terminee,C_ACQUISITION_En_Cours,C_ACQUISITION_Simple}
 {C_DESCRIPTION_terminee,C_DESCRIPTION_Simple,C_DESCRIPTION_En_Cours}
 ///
 if not empty(ParamAffichageDetailAcquis.TitreForm) then
   DetailAcquis.TitreForm:=ParamAffichageDetailAcquis.TitreForm;
 DetailAcquis.SousTitreForm:=ParamAffichageDetailAcquis.SousTitreForm;

 ParamDMImmos.ImmosDataStateChange := DetailAcquis.changementEtatBoutons;
 ParamDMImmos.ImmosAfterScroll:=DetailAcquis.taDetailImmoAfterScroll;
 ParamDMImmos.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ParamDMImmos.TypePresentation:=ParamAffichageDetailAcquis.TypePresentation;
 ParamDMImmos.Quand := DetailAcquis.Quand;
 ParamDMImmos.QuiAppel:=ParamAffichageDetailAcquis.QuiAppel;
   case DetailAcquis.Quand of
      C_mouvement:Begin
                   if not InitialiseDMImmos(ParamDMImmos).retour then abort;
                  End;
   end;

 if ParamAffichageDetailAcquis.Affiche then
  begin
     //Grille des comptes d'immos en cours
     DetailAcquis.GrImmosATerminer.DataSource := DataModuleImmos.DaImmosEnCours;
     //differentes zones de description de l'immo selectionn�e
     DetailAcquis.Compte.DataSource := DataModuleImmos.daDetailImmo;
     DetailAcquis.Code.DataSource := DataModuleImmos.daDetailImmo;
     DetailAcquis.Sous_code.DataSource := DataModuleImmos.daDetailImmo;
     DetailAcquis.Libelle.DataSource := DataModuleImmos.daDetailImmo;
     DetailAcquis.DateAcquis.DataSource := DataModuleImmos.daDetailImmo;
     DetailAcquis.DateDebutAmo.DataSource := DataModuleImmos.daDetailImmo;
     DetailAcquis.DeducInvest.DataSource := DataModuleImmos.daDetailImmo;
     DetailAcquis.rgTypeAmo.DataSource := DataModuleImmos.daDetailImmo;
     DetailAcquis.ValeurAcquis.DataSource := DataModuleImmos.daDetailImmo;
     DetailAcquis.DureeAmo.DataSource := DataModuleImmos.daDetailImmo;

   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(Application.MainForm);

     if ParamAffichageDetailAcquis.AffichageModal then
       DetailAcquis.ShowModal
      else
       DetailAcquis.Show;
  End;
except
  result:=false ;
end;
End;



procedure TDetailAcquis.FormCreate(Sender: TObject);
var
i:integer;
begin
 if DMImmo_Clo=nil then
 DMImmo_Clo:=TDMImmo_Clo.Create(self);

if DataModuleImmos = Nil then DataModuleImmos := TDataModuleImmos.Create(Self);

GrAmort.AjoutAuto:=false;
GrAmort.RowCount:=3;
GrAmort.FixedRows:=2;
GrAmort.ColCount:=3;
GrAmort.Options:=[goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect];

GrAmort.NumDecimal:=2;

GrAmort.Champ.Add(Grtous);
GrAmort.Champ.Add(GrCurr);
GrAmort.Champ.Add(GrCurr);
//rgTypeAmo.ItemIndex:=0;
GrAmort.Rows[0].CommaText:=GrAmortissementCommaText;
for i:=0 to GrAmort.ColCount-1 do
Begin
GrAmort.ColWidths[i]:=CColWidths[i]
End;
DataModuleImmos.tauxDegressif:=DataModuleImmos.taDetailImmoTauxAmo.AsFloat;

  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;

if ListeValeurAmort=nil then
ListeValeurAmort:=tstringlist.Create;


end;

Procedure TDetailAcquis.InitialiseTable_A_Nil;
Begin
  //DataModuleImmos.taDetailImmo.AfterScroll:=nil;
  //DataModuleImmos.daDetailImmo.OnStateChange:=nil;
  if DataModuleImmos<>nil then
    InitDatasetEvent_A_Nil_Sur_Form([DataModuleImmos.taDetailImmo,DataModuleImmos.daDetailImmo]);
End;

procedure TDetailAcquis.FormDestroy(Sender: TObject);
begin
   InitialiseTable_A_Nil;
//   FreeAndNil(ListeValeurAmort);
   LibereObjet(Tobject(ListeValeurAmort),Self);
   //ListeValeurAmort.Free;
   LibGestionParamXML.DestroyForm(Self,E.User);
   if DMImmo_Clo<>nil then DMImmo_Clo.Free;
   if DataModuleImmos<>nil then  DataModuleImmos.Free;
   DetailAcquis := Nil;
end;

procedure TDetailAcquis.FormActivate(Sender: TObject);
begin
//GestionInitDM;  pas besoin car affichage en showModal { isa  le  02/02/04 }
if GrImmosATerminer.visible then GrImmosATerminer.Col:=GrImmosATerminer.ColCount-1;
GrImmosATerminer.ColEnter;
GrAmort.ParamColor:=true;
GrAmort.Param:=ParamUtil.CouleurDBGrid;
GrAmort.UpDateColor;

GrImmosATerminer.ParamColor:=true;
GrImmosATerminer.Param:=ParamUtil.CouleurDBGrid;
GrImmosATerminer.UpDateColor;

//DataModuleImmos.taDetailImmo.AfterScroll:=taDetailImmoAfterScroll;
//DataModuleImmos.daDetailImmo.OnStateChange:=changementEtatBoutons;
//DataModuleImmos.daDetailImmo.OnStateChange(DataModuleImmos.taDetailImmo);

etatinitial;
GereAccesEcran;
end;

//procedure TDetailAcquis.Amort_lin;
//var
//Duree, Restant,nb_mois,nb_annee, i ,IndexListeVal,nbJourAnnee,nbJour: integer;
//Cumul : Currency;
//Valeur : array[1..25] of Currency;
//y,m,d, yf,mf,df:word;
//datefinAmo:tdatetime;
//RapportArrondis:currency;
//begin
//   DataModuleImmos.Mini:=0;
//   IndexListeVal:=0;
//   RapportArrondis:=0;
//   Cumul:=ValeurAcquis.field.AsCurrency;
//  if not empty(DataModuleImmos.taDetailImmoDate_Cession.asstring) then
//     begin
//     if DataModuleImmos.taDetailImmoDate_Cession.AsDateTime>e.DatExoFin then
//        datefinAmo:=E.DatExoFin
//     else
//        datefinAmo:=DataModuleImmos.taDetailImmoDate_Cession.AsDateTime;
//     end
//  else
//     datefinAmo:=E.DatExoFin;
//   nb_mois:=NbMois(DateDebutAmo.Field.AsDateTime,datefinAmo);
//   nbJour:=NbDeJours(DateDebutAmo.field.AsDateTime,datefinAmo);
//   nb_annee:=DureeAmo.field.AsInteger div 12;
//   if nb_mois < 0 then nb_mois := nb_mois + 12;
//   nbJourAnnee:=nbdejours(e.DatExoDebut,e.DatExoFin);
//   if rgTypeAmo.ItemIndex=0 then
//     begin
//       Duree := nbJour;
//       if Duree < 0 then Duree := 0;
//       Taux := 12 / DureeAmo.field.AsInteger;
//       ListeValeurAmort.Strings[1]:=currtostr(taux*100);
//       RapportArrondis:=int((Duree / nbJourAnnee)*1000);//pour ramener le rapport nbjour/NbJourAnn�e � 2 chiffres
////     apr�s la virgule seulement, ceci pour ce rapprocher le plus possible du rapport a*30/360
//       RapportArrondis:=RapportArrondis/1000;
//       ListeValeurAmort.Strings[3]:=currtostr(ValeurAcquis.field.AsCurrency * Taux * RapportArrondis);
//       Cumul :=cumul-(ValeurAcquis.field.AsCurrency * Taux * RapportArrondis);
//     end
//   else
//     begin
//       Duree := nb_mois;
//       if Duree < 0 then Duree := 0;
//       Taux := 12 / DureeAmo.field.AsInteger;
//       ListeValeurAmort.Strings[1]:=currtostr(taux*100);
//       ListeValeurAmort.Strings[3]:=currtostr(ValeurAcquis.field.AsCurrency * Taux *Duree / 12 );
//       Cumul :=cumul-(ValeurAcquis.field.AsCurrency * Taux * Duree / 12);
//     end;
//
//   while (cumul>0) do
//   begin//tant que cumul sup�rieur � 0
//     inc(IndexListeVal,2);
//     if ListeValeurAmort.count-1<IndexListeVal+3 then
//       Begin
//        ListeValeurAmort.add('0');
//        ListeValeurAmort.add('');
//       End;
//   if cumul>(ValeurAcquis.field.AsCurrency * Taux) then
//      begin
//        ListeValeurAmort.Strings[3+IndexListeVal]:=currtostr(ValeurAcquis.field.AsCurrency * Taux);
//      end
//   else
//      Begin
//        ListeValeurAmort.Strings[3+IndexListeVal]:=currtostr(cumul);
//      End;
////      Restant := Restant - nb_mois;
////      nb_mois := Calcul_nb_mois(Restant);
//     Cumul := Cumul - (ValeurAcquis.field.AsCurrency * Taux);
////     dec(nb_annee);
//   end;//fin tant que cumul sup�rieur � 0
////   if nb_mois <> 0 then
////   begin {Derni�re ann�e}
////     if ValeurAcquis.field.AsCurrency - Cumul>0 then
////       begin
////       ListeValeurAmort.Strings[3+IndexListeVal]:=currtostr(ValeurAcquis.field.AsCurrency * Taux);
////
////       end;
//
////   end;
////affiche(0);
//end;

procedure TDetailAcquis.DureeAmoExit(Sender: TObject);
var
valide:TExceptLGR;
begin
  try
  if ((activeControl<>BtnAnnuler)and(ActiveControl<>BtnFermer)and(activeControl<>GrImmosATerminer))then
  if DureeAmo.Enabled then
     begin//si edit enabled
       valide:=DataModuleImmos.CtrlSaisieDescriptionAmort(DureeAmo.Field); { isa  le  26/01/04 }
     end;//fin si edit enabled
  except
    DureeAmo.SetFocus;
    abort;
  end;
end;


//procedure TDetailAcquis.Amort_degr;
//var Duree, Restant,nb_mois,i : integer;
//Coef,nb_annee : real;
//Cumul, Acq : Currency;
//begin
//   Duree := DureeAmo.field.AsInteger;
////   Acq := ValeurAcquis.field.ascurrency;
//   Restant := Duree;
//   Cumul := 0;
//   nb_annee:=duree/12;
//   if Duree < 36 then
//   begin {Lin�aire}
//   	Taux := 0;
//        ListeValeurAmort.Strings[0]:=currtostr(taux*100);
////        affiche(1);
//        exit;
//   end;
//   coef:=DataModuleImmos.RechercherCoefficient_surPeriodeValidite(DateAcquis.Field.AsDateTime);
//
//   Taux := Round(10000 * 12 * Coef / Duree) / 10000;
//   ListeValeurAmort.Strings[0]:=currtostr(taux*100);
//   while Restant > 12 do begin
//      nb_mois := Calcul_nb_mois(Restant);
//      if ((Acq - Cumul) * Taux * nb_mois /12) >0 then
//      begin
//      ListeValeurAmort.Add(currtostr((Acq - Cumul) * Taux * nb_mois /12));
//      ListeValeurAmort.Add('');
//      Cumul := Cumul + ((Acq - Cumul) * Taux * nb_mois /12);
//      end;
//      Restant := Restant - nb_mois;
//   end;
//   if (Acq - Cumul)>0 then
//     Begin
//      ListeValeurAmort.Add(currtostr(Acq - Cumul));
//      ListeValeurAmort.Add('');
//     End;
////   affiche(1);
//end;


procedure TDetailAcquis.Amort_degr;
var Duree,nb_mois,i : integer;
Coef,nb_annee : real;
Cumul, valeurrestante,valeurrestanteArrondie : Currency;
datefinAmo:Tdatetime;
begin
   Duree := DureeAmo.field.AsInteger;
   Cumul:=ValeurAcquis.field.AsCurrency;
  // nb_mois := Calcul_nb_mois(Duree);
  if not empty(DataModuleImmos.taDetailImmoDate_Cession.asstring) then
     begin
     if DataModuleImmos.taDetailImmoDate_Cession.AsDateTime>e.DatExoFin then
        datefinAmo:=E.DatExoFin
     else
        datefinAmo:=DataModuleImmos.taDetailImmoDate_Cession.AsDateTime;
     end
  else
     datefinAmo:=E.DatExoFin;
   nb_mois:=NbMois(DateDebutAmo.Field.AsDateTime,datefinAmo);
   nb_annee:=Duree div 12;
   if duree mod 12<>0 then
     nb_annee:=nb_annee+1;
   coef:=DataModuleImmos.RechercherCoefficient_surPeriodeValidite(DateAcquis.Field.AsDateTime,duree);
   if ((DataModuleImmos.tauxDegressif=0)and(DataModuleImmos.taDetailImmoTauxAmo.AsFloat<>0)) then
     DataModuleImmos.tauxDegressif:=DataModuleImmos.taDetailImmoTauxAmo.AsFloat
   else
    if DataModuleImmos.tauxDegressif=0 then
     DataModuleImmos.tauxDegressif := Round(10000 * 12 * Coef / Duree) / 10000;

   ListeValeurAmort.Strings[0]:=currtostr(DataModuleImmos.tauxDegressif*100);
   ListeValeurAmort.Add(currtostr(cumul * DataModuleImmos.tauxDegressif * nb_mois / 12));
   ListeValeurAmort.Add('');

   Cumul :=cumul-cumul * DataModuleImmos.tauxDegressif * nb_mois / 12;
   nb_annee:=nb_annee-1;
   while ((cumul>0)and(nb_annee<>0)) do
   begin//tant que cumul sup�rieur � 0
   if (cumul * DataModuleImmos.tauxDegressif)>(cumul/nb_annee) then
      begin
        ListeValeurAmort.Add(currtostr(cumul * DataModuleImmos.tauxDegressif));
        ListeValeurAmort.Add('');
//        Cumul :=cumul-ArrondiCentieme(cumul * tauxDegressif);
        Cumul :=cumul-(cumul * DataModuleImmos.tauxDegressif);
        nb_annee:=nb_annee-1;
      end
   else
      Begin
        valeurrestante:=ArrondiCentieme(cumul/nb_annee);
        while ((nb_annee>0)and(cumul>0)) do
          Begin
            if nb_annee-1<=0 then
              valeurrestante:=cumul;
            ListeValeurAmort.Add(currtostr(valeurrestante));
            ListeValeurAmort.Add('');
            nb_annee:=nb_annee-1;
            Cumul :=cumul-(valeurrestante);
          End;
      End;
   end;//fin tant que cumul sup�rieur � 0
end;


function TDetailAcquis.Calcul_nb_mois(Restant : integer) : integer;
var dt : TDateTime; Duree : integer;
	Ydeb, Mdeb, Ddeb: Word;
   Yexo, Mexo, Dexo : word;
begin
	dt := StrToDate_Lgr(DateDebutAmo.Text);
	Duree := StrToInt_Lgr(DureeAmo.Text);
   DecodeDate(dt, Ydeb, Mdeb, Ddeb);
   dt := E.DatExoFin;
   DecodeDate(dt, Yexo, Mexo, Dexo);
   if (Duree - Restant = 0) or (Restant < 12) then begin{Premi�re ou Derni�re ann�e}
		result := Mexo - Mdeb + 1;
      if result < 0 then result := result + 12;
   end
   else
      result := 12;
end;

procedure TDetailAcquis.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
KeyTmp:char;
begin
try

  if ((key = VK_RETURN)and (not DateDebutAmo.PopupVisible)) then
  begin
    WinSuivPrec(Handle,key,[nil])
  end
  else
  if not DateDebutAmo.PopupVisible then
    WinSuivPrec(Handle,key,[GrImmosATerminer,GrAmort,rgTypeAmo,RGChoix])
  else
    WinSuivPrec(Handle,key,[GrImmosATerminer,GrAmort,rgTypeAmo,RGChoix,DateDebutAmo]);

       If ((Key = VK_ESCAPE)and(not DateDebutAmo.PopupVisible)) Then
       Begin
         If DataModuleImmos.taDetailImmo.State = dsBrowse Then
            begin
               Self.Close ;
            end;

        If DataModuleImmos.taDetailImmo.State = dsInsert Then
            Begin//si en insertion
                 If Messagedlg('Annuler la Description de cette immobilisation ?',MtConfirmation,[mbno,mbyes],0) = mryes Then
                 Begin
                      DataModuleImmos.taDetailImmo.Cancel;
                      initialiserGrille;
                      //DeducInvest.SetFocus;
                      self.close;
                 End
                 Else
                 Begin
                      Abort;
                 End;
            End;//fin si en insertion


            If DataModuleImmos.taDetailImmo.State = dsEdit Then
            Begin
                 If Messagedlg('Annuler les modifications de cette immobilisation ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
                 Begin
                      DataModuleImmos.taDetailImmo.DisableControls;
                      DataModuleImmos.taDetailImmo.Cancel;
                      DataModuleImmos.taDetailImmo.EnableControls;
                      initialiserGrille;
                      DeducInvest.SetFocus;
                 End
                 Else
                 Begin
                      Abort;
                 End
            End;
      end;
except
   raise;
end;
end;


procedure TDetailAcquis.Enregistre;
begin
try
try
TableGerePost(DataModuleImmos.TaImmosEnCours);
BtnEnregistrer.SetFocus;
PaEnteteExit(PaDetailCorp);
DataModuleImmos.tag:=self.tag;
TableGerePost(DataModuleImmos.taDetailImmo);
TableGereCommit(DataModuleImmos.taDetailImmo);
except
   abort;
end;
finally
  DataModuleImmos.QuCptUtiliseImmos.EnableControls;
end;//fin du try finally
end;



procedure TDetailAcquis.rgTypeAmoClick(Sender: TObject);
begin
if ((not (DataModuleImmos.Amortissable(compte.Field.AsString)).Amortissable)and(rgTypeAmo.DataSource.State=dsinsert)) then
  begin
   rgTypeAmo.ItemIndex:=2;
  end;
if rgTypeAmo.ItemIndex=2 then
  begin
  DureeAmo.enabled:=false;
  DureeAmo.Text:='';
  RGChoix.ItemIndex:=0;
  end
else
  begin
  DureeAmo.enabled:=true;
  DureeAmo.text:=DureeAmo.field.AsString;
  end;
  if rgTypeAmo.ItemIndex=0 then
    RGChoix.ItemIndex:=0;
end;


procedure TDetailAcquis.etatinitial;
var
//immoCourante:integer;
typeAmort:Ttypeimmo;
begin
   try
//   initialise_TinfosDetailAcquis(DataModuleImmos.infosDetailAcquis);
//   DataModuleImmos.suppressionPieceDotation:=false;
   RGChoix.OnClick:=nil;
//if Type_version_execution=ct_developpement then
//  begin
       DataModuleImmos.Choix.choixDefaut:=0;
       DataModuleImmos.choix.Complementchoix:=0;
       if ((not empty(DataModuleImmos.taDetailImmoChoix.AsString))and(DataModuleImmos.taDetailImmoChoix.Ascurrency<>0)) then
         begin
         DataModuleImmos.choix.choixDefaut:=DataModuleImmos.taDetailImmoChoix.Ascurrency;
         if DataModuleImmos.choix.choixDefaut=DataModuleImmos.taDetailImmoMini.Ascurrency then
           rgchoix.ItemIndex:=0
         else
         if DataModuleImmos.choix.choixDefaut=DataModuleImmos.taDetailImmoMaxi.Ascurrency then
           rgchoix.ItemIndex:=1
         else
           rgchoix.ItemIndex:=2;
         end
       else
        rgchoix.ItemIndex:=0;
        DataModuleImmos.choix.choixDefaut:=DataModuleImmos.taDetailImmoMini.Ascurrency;
        DataModuleImmos.choix.ChoixItem:=RGChoix.ItemIndex;
//end;
   rgTypeAmo.OnClick:=nil;
   PaDetailCorp.onexit:=nil;
      case tag of
      C_ACQUISITION_Terminee,C_ACQUISITION_En_Cours,C_ACQUISITION_Simple:
           Begin
                rgTypeAmo.ReadOnly:=false;
                readOnlyWinControl([libelle,DeducInvest,DureeAmo],true);
                BtnEnregistrer.Enabled:=true;
//               if DataModuleImmos.taDetailImmo.Active=false then
//                 DataModuleImmos.taDetailImmo.open;
//                 if DataModuleImmos.taDetailImmo.State in [dsbrowse] then
//               DataModuleImmos.taDetailImmo.append;
               Compte.field.AsString:= DataModuleImmos.qryListeAcquis.findfield('Compte').asstring;
               typeAmort:=DataModuleImmos.Amortissable(Compte.field.AsString);
               if copy(Compte.Text,1,1)='2'then
                 valeurAcquis.field.Asfloat:=DataModuleImmos.qryListeAcquis.findfield('Debit').Asfloat
               else
                 valeurAcquis.field.Asfloat:=DataModuleImmos.qryListeAcquis.findfield('Credit').Asfloat;
               Code.field.AsString:= DataModuleImmos.TrouveCode(Compte.field.AsString);
               Sous_Code.field.AsString:=DataModuleImmos.Trouve_sous_code(Compte.field.AsString,Code.field.AsString);
               Libelle.field.AsString :=DataModuleImmos.qryListeAcquis.findfield('Libelle').asstring;
               DateAcquis.field.AsDateTime:=DataModuleImmos.qryListeAcquis.findfield('Date').AsDateTime;
               DateDebutAmo.field.AsDateTime :=DataModuleImmos.qryListeAcquis.findfield('Date').AsDateTime;
               DeducInvest.field.Asfloat:=0;
               DBChoix.Visible:=false;
               case tag of
               C_ACQUISITION_En_Cours:
                    Begin
                       PaImmosEnCours.Visible:=false;
                       PaImmosEnCours.Align:=alnone;
                       PaCalcul.Visible:=false;
                       DureeAmo.enabled:=false;
                       rgTypeAmo.ItemIndex:=2;
                       rgTypeAmo.Enabled:=false;
                       GrImmosATerminer.ReadOnly:=false;
                       RxLabTitre.Caption:='Acquisition d''une immobilisation ... En cours';
                       DeducInvest.SetFocus;
                    End;
               C_ACQUISITION_Terminee:
                    Begin
                       PaCalcul.Visible:=true;
                       DureeAmo.enabled:=true;
                       rgTypeAmo.Enabled:=true;
                       if typeAmort.Amortissable then
                         begin
                           if typeAmort.Degressif then
                             rgTypeAmo.ItemIndex:=1
                           else
                             rgTypeAmo.ItemIndex:=0;
                         end
                       else
                         rgTypeAmo.ItemIndex:=2;
                       PaImmosEnCours.Visible:=true;
                       GrImmosATerminer.ReadOnly:=false;
                       PaImmosEnCours.Align:=altop;
                       PaCptIntit.Caption:='Immobilisations en cours � terminer';
                       RxLabTitre.Caption:='Acquisition d''une immobilisation ... Termin�e';
                       DureeAmo.onExit:=nil;
                       GrImmosATerminer.setfocus;
                       GrImmosATerminer.col:=7;
//                       GrImmosATerminer.col:=GrImmosATerminer.ColCount-1;
                       DureeAmo.onExit:=DureeAmoExit;
                    End;
               C_ACQUISITION_Simple:
                    Begin
                       PaCalcul.Visible:=true;
                       DureeAmo.enabled:=true;
                       rgTypeAmo.Enabled:=true;
                       if typeAmort.Amortissable then
                         begin
                           if typeAmort.Degressif then
                             rgTypeAmo.ItemIndex:=1
                           else
                             rgTypeAmo.ItemIndex:=0;
                         end
                       else
                         rgTypeAmo.ItemIndex:=2;
                       PaImmosEnCours.Visible:=false;
                       GrImmosATerminer.ReadOnly:=false;
                       PaImmosEnCours.Align:=alnone;
                       RxLabTitre.Caption:='Acquisition d''une immobilisation';
                       DeducInvest.setfocus;
                       if not (VerifFNumeric(DureeAmo.Field).VideOUZero) then
                         PaEnteteExit(PaDetailCorp);
                    End;
               end;//fin du 2i�me case tag of Acquisition
           End;
      C_DESCRIPTION_terminee,C_DESCRIPTION_Simple,C_DESCRIPTION_En_Cours:
           begin //si Description
             DBChoix.Visible:=true;
             if ((DataModuleImmos.taDetailImmoCession_dans_Annee.AsBoolean) or (DataModuleImmos.taDetailImmoRebut.AsBoolean)or(DataModuleImmos.taDetailImmoDate_Achat.AsDateTime<e.DatExoDebut))then
                begin
                readOnlyWinControl([compte,Code,Sous_Code,libelle,DateAcquis,DeducInvest,DureeAmo],true);
                rgTypeAmo.ReadOnly:=true;
                BtnEnregistrer.Enabled:=false;
                end
             else
                Begin
                readOnlyWinControl([compte,Code,Sous_Code,libelle,DateAcquis,DeducInvest,DureeAmo],false);
                rgTypeAmo.ReadOnly:=false;
                BtnEnregistrer.Enabled:=true;
                End;
               case tag of
               C_DESCRIPTION_Simple:
                    Begin
                      PaImmosEnCours.Visible:=false;
                      PaImmosEnCours.Align:=alnone;
                      PaCalcul.Visible:=true;
                      DureeAmo.enabled:=true;
                      rgTypeAmo.Enabled:=true;
                      GrImmosATerminer.ReadOnly:=false;
                      RxLabTitre.Caption:='Description d''une immobilisation';
                      DeducInvest.SetFocus;
                    End;
               C_DESCRIPTION_En_Cours:
                    Begin
                      PaImmosEnCours.Visible:=false;
                      PaImmosEnCours.Align:=alnone;
                      PaCalcul.Visible:=false;
                      DureeAmo.enabled:=false;
                      rgTypeAmo.Enabled:=false;
                      PaCalcul.Visible:=false;
                      GrImmosATerminer.ReadOnly:=false;
                      RxLabTitre.Caption:='Description de l''immobilisation ... En cours';
                      DeducInvest.SetFocus;
                    End;
               C_DESCRIPTION_Terminee:
                    Begin
                       PaCalcul.Visible:=true;
                       DureeAmo.enabled:=true;
                       rgTypeAmo.Enabled:=true;
                       PaImmosEnCours.Visible:=true;
                       PaImmosEnCours.Align:=altop;
                       GrImmosATerminer.ReadOnly:=true;
                       PaCptIntit.Caption:='Immobilisations en cours Li�es � l''immobilisation Termin�e';
                       RxLabTitre.Caption:='Description d''une immobilisation ... Termin�e';
                       DureeAmo.onExit:=nil;
                       GrImmosATerminer.setfocus;
                       GrImmosATerminer.col:=7;
//                       GrImmosATerminer.col:=GrImmosATerminer.ColCount-1;
                       DureeAmo.onExit:=DureeAmoExit;
                    End;
               end;//fin du case tag of Description
//              if ((not DataModuleImmos.taDetailImmo.FindField('Achat_dans_annee').AsBoolean)or(DataModuleImmos.taDetailImmo.FindField('Cession_dans_annee').AsBoolean)) then
//                begin
//                 immoCourante:=DataModuleImmos.taDetailImmo.findfield('id').asinteger;
//                 DataModuleImmos.taDetailImmo.active:=false;
//                 DataModuleImmos.taDetailImmo.ReadOnly:=true;
//                 DataModuleImmos.taDetailImmo.active:=true;
//                 DataModuleImmos.taDetailImmo.Locate('id',immoCourante,[]);
//                end;
           end;//fin si Description
      end;//fin du case tag
   finally
   self.Caption:=RxLabTitre.Caption;
   RGChoix.OnClick:=RGChoixClick;
   rgTypeAmo.OnClick:=rgTypeAmoClick;
   PaDetailCorp.onexit:=paenteteexit;
   if rgTypeAmo.ItemIndex=2 then
     DureeAmo.Enabled:=false;
   end;

initialiserGrille;
//DureeTmp:=DureeAmo.Field.AsInteger;
//if not (VerifFNumeric(DureeAmo.Field).VideOUZero) then
//   PaEnteteExit(PaDetailCorp);
//tauxDegressif:=DataModuleImmos.taDetailImmoTauxAmo.AsFloat;
if DataModuleImmos <>nil then
  begin
    if ProtectObjetNil([DataModuleImmos.ListImmosEnCoursALier]) then
      DataModuleImmos.ListImmosEnCoursALier.Clear;
  end;
//DeducInvest.SetFocus;
End;


procedure TDetailAcquis.affiche(typeAmort:integer);
var
j,i:integer;
begin
if ((StrToInt_Lgr(DureeAmo.text)<>0)and(not empty(DureeAmo.text))) then
  begin
  GrAmort.SetFocus;
  nb_Exo:=(ListeValeurAmort.count-2)div 2;
  GrAmort.RowCount:=nb_Exo+2;
  GrAmort.rows[1].CommaText:='"Taux d''Amortissement"'+',"'+ListeValeurAmort[1]+' %"'+',"'+ ListeValeurAmort[0]+' %"';
  i:=2;
    for j:=2 to GrAmort.RowCount-1 do
      begin
           if j=2 then
            begin
             GrAmort.cells[0,j] := 'Amortissement '+inttostr(j-1)+'er exercice';
             GrAmort.cells[1,j] := FormatFloat('# ##0.00 ' + currencyStringEpicea + ';; ', StrToCurr_Lgr(ListeValeurAmort[i+1]));
             GrAmort.cells[2,j] := FormatFloat('# ##0.00 ' + currencyStringEpicea + ';; ', StrToCurr_Lgr(ListeValeurAmort[i]));
            end
           else
            begin
             GrAmort.cells[0,j] := 'Amortissement '+inttostr(j-1)+'�me exercice';
             GrAmort.cells[1,j] := FormatFloat('# ##0.00 ' + currencyStringEpicea + ';; ', StrToCurr_Lgr(ListeValeurAmort[i+1]));
             GrAmort.cells[2,j] := FormatFloat('# ##0.00 ' + currencyStringEpicea + ';; ', StrToCurr_Lgr(ListeValeurAmort[i]));
            end;
      inc(i,2);
      end;
  end;
end;


procedure TDetailAcquis.DateAcquisExit(Sender: TObject);
var
valide:TExceptLGR;
begin
try
valide:=DataModuleImmos.CtrlSaisieDescriptionAmort(DateAcquis.Field);
except
  DateAcquis.SetFocus;
  abort;
end;
end;

procedure TDetailAcquis.DateDebutAmoExit(Sender: TObject);
var
valide:TExceptLGR;
begin
try
valide:=DataModuleImmos.CtrlSaisieDescriptionAmort(DateDebutAmo.Field);
except
  DateDebutAmo.SetFocus;
  abort;
end;
end;



procedure TDetailAcquis.PaEnteteExit(Sender: TObject);
var
i:integer;
valide:TExceptLGR;
EditCourant:TWinControl;
begin
try
Initialise_ExceptLGR(valide);
//if ((ActiveControl<>BtnAnnuler)and(ActiveControl<>BtnFermer)and(ActiveControl<>GrImmosATerminer)) then
if ((ActiveControl<>BtnAnnuler)and(ActiveControl<>BtnFermer)) then
  begin //si activeControl<>BtnAnnuler
   try
       For i:=0 to PaEnteteDescrip.controlcount -1  do
       begin
         if ((PaEnteteDescrip.Controls[i] is TCustomEdit)and((PaEnteteDescrip.Controls[i] as TCustomEdit).enabled)) then
           begin
            EditCourant:=(PaEnteteDescrip.Controls[i] as TCustomEdit);
            if (EditCourant is TDBEdit)then
              valide:=DataModuleImmos.CtrlSaisieDescriptionAmort((EditCourant as TDBEdit).Field)
            else
              if (EditCourant is TDBRadioGroup)then
                valide:=DataModuleImmos.CtrlSaisieDescriptionAmort((EditCourant as TDBRadioGroup).Field);
           end;
       end;
       For i:=0 to PaDescription.controlcount -1  do
       begin
         if ((PaDescription.Controls[i] is TCustomEdit)and((PaDescription.Controls[i] as TCustomEdit).enabled)) then
           begin
            EditCourant:=(PaDescription.Controls[i] as TCustomEdit);
            if (EditCourant is TDBEdit)then
              valide:=DataModuleImmos.CtrlSaisieDescriptionAmort((EditCourant as TDBEdit).Field)
            else
              if (EditCourant is TDBRadioGroup)then
                valide:=DataModuleImmos.CtrlSaisieDescriptionAmort((EditCourant as TDBRadioGroup).Field);
           end;
       end;
     if ((rgTypeAmo.Enabled) and (not VerifFNumeric(DureeAmo.Field).VideOUZero)and (DureeAmo.Enabled)) then
       Begin //si l'immo est ammortissable
         if (rgTypeAmo.ItemIndex = 1) and (DureeAmo.Field.AsFloat < 36) then
         begin
           EditCourant:=(rgTypeAmo as TCustomRadioGroup);
           raise ExceptLGR.Create('La dur�e d''amortissement d�gressif doit �tre d''au moins 36 mois',1000,true,mtError,valide);
         end;
         InitialiserGrille;
         case rgTypeAmo.ItemIndex of
         0,1:begin
               Amort_degr;
               Amort_lin_SurBase360;
               affiche(1);
             end;
         end;//fin du case typeAmortissement
       End//fin si l'immo est ammortissable
       else
       InitialiserGrille;
   except
       EditCourant.SetFocus;
       abort;
   end;//fin du try except
 end;//fin si activeControl<>BtnAnnuler
except
  abort;
end;
end;

procedure TDetailAcquis.ValeurAcquisExit(Sender: TObject);
var
valide:TExceptLGR;
begin
try
valide:=DataModuleImmos.CtrlSaisieDescriptionAmort(ValeurAcquis.Field);
except
  ValeurAcquis.SetFocus;
  abort;
End;
end;

procedure TDetailAcquis.LibelleExit(Sender: TObject);
var
valide:TExceptLGR;
begin
try
valide:=DataModuleImmos.CtrlSaisieDescriptionAmort(Libelle.Field);
except
  Libelle.SetFocus;
  abort;
End;
end;

procedure TDetailAcquis.PaImmosEnCoursExit(Sender: TObject);
var
valide:TExceptLGR;
editcourant:TWinControl;
begin
//g�rer le libell�
  try
   editcourant:=(libelle as TCustomEdit);
   valide:=DataModuleImmos.CtrlSaisieDescriptionAmort(libelle.Field);
   if ActiveControl<>nil then
     Begin
         editcourant:=(GrImmosATerminer as TCustomDBGrid);
         if ActiveControl.Parent<>PaDetailCorp then
           PaEnteteExit(PaDetailCorp);
     End;
  except
   editcourant.SetFocus;
   abort;
  end;
end;


procedure TDetailAcquis.InitialiserGrille;
var
i:integer;
Begin
for i:=1 to GrAmort.rowcount-1 do
GrAmort.Rows[i].clear;
GrAmort.RowCount:=3;
if ListeValeurAmort=nil then
ListeValeurAmort:=TStringList.Create;
ListeValeurAmort.clear;
ListeValeurAmort.Add('');
ListeValeurAmort.Add('');
End;

procedure TDetailAcquis.GrImmosATerminerCellClick(Column: TColumn);
begin
BtnModifier.Click ;
if column.Index = 6 then
GrImmosATerminerColExit(GrImmosATerminer);
end;

procedure TDetailAcquis.GrImmosATerminerColExit(Sender: TObject);
var
Valide:TErreurSaisie;
begin
try
valide:=DataModuleImmos.CtrlSaisieImmosTerminee(GrImmosATerminer.SelectedField);
  if valide.Retour=false then
    Begin
      abort;
    End
    else
    LibelleExit(libelle);
except
 abort;
end;//
end;

procedure TDetailAcquis.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
erreur:TerreurCloture;
reference:string;
begin
//regenerer la piece de dotation si elle a �t� supprim�e
if DataModuleImmos.suppressionPieceDotation then
  begin
     erreur:=VerifGestionImmo_AvantCloture(e.DatExoDebut,e.DatExoFin);
     if ((erreur.erreur.retour)or(not (erreur.erreur.codeErreur in [1,2]))) then
       begin
        if Application.MessageBox(PChar('Voulez-vous reg�n�rer la pi�ce de dotation aux amortissements?'),'Confirmation',MB_YESNO + MB_DEFBUTTON1) = IDYES then
          DMImmo_Clo.GenererPieceDotation(reference);
        DataModuleImmos.suppressionPieceDotation:=false;
       end
     else
       Begin
         showmessage(erreur.messages.MessageErreur);
//         abort;
       End;
  end;
end;


procedure TDetailAcquis.TauxAmortissement1Click(Sender: TObject);
var
coef:real;
exception:TExceptLGR;
begin
try
Initialise_ExceptLGR(exception);
if DataModuleImmos.taDetailImmoTauxAmo.readonly then
  raise ExceptLGR.Create('Vous ne pouvez pas modifier le taux de cette immobilisation',1000,true,mtError,exception);
if TauxAmortissement=nil then TauxAmortissement:=TTauxAmortissement.Create(self);

if ((DataModuleImmos.tauxDegressif=0)and(DataModuleImmos.taDetailImmoTauxAmo.AsFloat<>0))then
DataModuleImmos.tauxDegressif:=DataModuleImmos.taDetailImmoTauxAmo.AsFloat
else
 if DataModuleImmos.tauxDegressif=0 then
 begin
  if not empty(DureeAmo.Field.AsString)then
    Begin
      coef:=DataModuleImmos.RechercherCoefficient_surPeriodeValidite(DateAcquis.Field.AsDateTime,DureeAmo.Field.AsInteger);
      TauxAmortissement.TauxDegressif:= (Round(10000 * 12 * Coef / DureeAmo.Field.AsInteger) / 10000);
      TauxAmortissement.TauxDegressif:=TauxAmortissement.TauxDegressif*100;
    End;
 end
 else
   Begin
     TauxAmortissement.TauxDegressif:=DataModuleImmos.tauxDegressif;
     TauxAmortissement.TauxDegressif:=TauxAmortissement.TauxDegressif*100;
   End;
  TauxAmortissement.TauxLineaire:= (12 / DureeAmo.field.AsInteger);
  TauxAmortissement.TauxLineaire:=TauxAmortissement.TauxLineaire*100;
  TauxAmortissement.ShowModal;
    if TauxAmortissement.ModalResult=Mrcancel then
      abort
    else
      Begin
        if TauxAmortissement.TauxDegressif<>0 then
          DataModuleImmos.tauxDegressif:=TauxAmortissement.TauxDegressif/100;
        if not (DataModuleImmos.taDetailImmo.state in [dsinsert,dsedit]) then
            DataModuleImmos.taDetailImmo.edit;
        DataModuleImmos.taDetailImmoTauxAmo.AsFloat:=DataModuleImmos.tauxDegressif;
        PaEnteteExit(sender);
      End;
except
  abort;
end;
end;

procedure TDetailAcquis.RGChoixClick(Sender: TObject);
var
ParamAffichageChoixAmortissement:TParamAffichageChoixAmortissement;
begin
try
if ((DataModuleImmos.taDetailImmoCession_dans_Annee.AsBoolean)or(DataModuleImmos.taDetailImmoRebut.AsBoolean))then
  begin
    showmessage('Cette immobilisation a �t� c�d�e, vous ne pouvez pas la modifier');
    abort;
  end;
if rgTypeAmo.ItemIndex=2 then
  RGChoix.ItemIndex:=0;
 case RGChoix.ItemIndex of
   0:begin
       DataModuleImmos.choix.choixDefaut:=DataModuleImmos.taDetailImmoMini.AsCurrency;
       DataModuleImmos.choix.ChoixItem:=0;
       if DataModuleImmos.taDetailImmo.State=dsbrowse then
          DataModuleImmos.taDetailImmo.edit;
     end;
   1:begin
       DataModuleImmos.choix.choixDefaut:=DataModuleImmos.taDetailImmoMaxi.AsCurrency;
       DataModuleImmos.choix.ChoixItem:=1;
       if DataModuleImmos.taDetailImmo.State=dsbrowse then
          DataModuleImmos.taDetailImmo.edit;
     end;
   2:Begin
         if Type_version_execution=ct_developpement then
         begin
          try
            if DataModuleImmos.taDetailImmo.state =dsinsert then
              abort
            else
           TableGerePost(DataModuleImmos.taDetailImmo);
            ParamAffichageChoixAmortissement.AffichageModal := true;
            ParamAffichageChoixAmortissement.Affiche := true;
            ParamAffichageChoixAmortissement.Quand := C_Mouvement;
            ParamAffichageChoixAmortissement.TypePresentation:=0;
            ParamAffichageChoixAmortissement.TitreForm :='Choix des amortissements';
            ParamAffichageChoixAmortissement.SousTitreForm := CMouvement;
            ParamAffichageChoixAmortissement.QuiAppel:=F_ChoixAmortissement;
            ParamAffichageChoixAmortissement.ImmoCourante:=DataModuleImmos.taDetailImmoID.Asinteger;
            if  ChoixAmortissementAffiche(ParamAffichageChoixAmortissement) then
                begin
                  if not empty(DataModuleImmos.taDetailImmoChoix.asstring) then
                     DataModuleImmos.choix.Complementchoix:=DataModuleImmos.taDetailImmoChoix.AsCurrency
                  else
                     DataModuleImmos.choix.Complementchoix:=DataModuleImmos.taDetailImmoMini.AsCurrency;
//                  if DataModuleImmos.taDetailImmo.State=dsbrowse then
//                     DataModuleImmos.taDetailImmo.edit;
                end;
          except
             abort;
          end;
         end;
     End;
 end;//fin du case
DataModuleImmos.choix.ChoixItem:=RGChoix.ItemIndex;
except
  RGChoix.OnClick:=nil;
  RGChoix.ItemIndex:=ChoixEnter;
  RGChoix.OnClick:=RGChoixClick;
end;
end;

procedure TDetailAcquis.DureeAmoEnter(Sender: TObject);
begin
DureeTmp:=DureeAmo.Field.AsInteger;
end;


procedure TDetailAcquis.taDetailImmoAfterScroll(DataSet: TDataSet);
Begin
DataModuleImmos.tauxDegressif:=DataModuleImmos.taDetailImmoTauxAmo.AsFloat;
End;


procedure TDetailAcquis.RGChoixEnter(Sender: TObject);
begin
ChoixEnter:=rgchoix.ItemIndex;
end;


procedure TDetailAcquis.Amort_lin_SurBase360;
var
Duree, Restant,nb_mois,nb_annee, i ,IndexListeVal,nbJourAnnee,nbJour: integer;
Cumul : Currency;
Valeur : array[1..25] of Currency;
y,m,d, yf,mf,df:word;
datefinAmo:tdatetime;
RapportArrondis:currency;
begin
   IndexListeVal:=0;
   Cumul:=ValeurAcquis.field.AsCurrency;
  if not empty(DataModuleImmos.taDetailImmoDate_Cession.asstring) then
     begin
     if DataModuleImmos.taDetailImmoDate_Cession.AsDateTime>e.DatExoFin then
        datefinAmo:=E.DatExoFin
     else
        datefinAmo:=DataModuleImmos.taDetailImmoDate_Cession.AsDateTime;
     end
  else
     datefinAmo:=E.DatExoFin;
   nb_annee:=DureeAmo.field.AsInteger div 12;
//   if rgTypeAmo.ItemIndex=0 then
//     begin
       Duree := NbDeJours_SurBase360(DateDebutAmo.field.AsDateTime,datefinAmo,true);
//     end
//   else
//     begin
//       Duree := NbDeJours_SurBase360(DateDebutAmo.field.AsDateTime,datefinAmo,false);
//     end;
   if Duree < 0 then Duree := 0;
   Taux := 12 / DureeAmo.field.AsInteger;
   ListeValeurAmort.Strings[1]:=currtostr(taux*100);
   ListeValeurAmort.Strings[3]:=currtostr(ArrondiCentieme(ValeurAcquis.field.AsCurrency * Taux * (duree/360)));
   Cumul :=cumul-ArrondiCentieme((ValeurAcquis.field.AsCurrency * Taux * (duree/360)));
   while (ArrondiCentieme(cumul)>0) do
   begin//tant que cumul sup�rieur � 0
     inc(IndexListeVal,2);
     if ListeValeurAmort.count-1<IndexListeVal+3 then
       Begin
        ListeValeurAmort.add('0');
        ListeValeurAmort.add('');
       End;
   if cumul>ArrondiCentieme(ValeurAcquis.field.AsCurrency * Taux) then
      begin
        ListeValeurAmort.Strings[3+IndexListeVal]:=currtostr(ArrondiCentieme(ValeurAcquis.field.AsCurrency * Taux));
      end
   else
      Begin
        ListeValeurAmort.Strings[3+IndexListeVal]:=currtostr(cumul);
      End;
     Cumul := Cumul - (ArrondiCentieme(ValeurAcquis.field.AsCurrency * Taux));
     if ArrondiCentieme(ValeurAcquis.field.AsCurrency * Taux)=0 then exit;
   end;//fin tant que cumul sup�rieur � 0

end;


procedure TDetailAcquis.rgTypeAmoExit(Sender: TObject);
begin
   if ((VerifNumeric(DureeAmo.Text).VideOUZero) and(DureeAmo.enabled )) then
   begin
     DureeAmo.SetFocus;
   end
   else
   Begin
     DureeAmoExit(dureeAmo);
   End;
end;

procedure TDetailAcquis.BtnEnregistrerClick(Sender: TObject);
begin
  try
    Enregistre;
    Close;
  except
    if formstate = [fsmodal] then ModalResult:=mrnone
    else
      abort;
  end;
end;

procedure TDetailAcquis.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TDetailAcquis.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TDetailAcquis.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TDetailAcquis.BtnModifierClick(Sender: TObject);
begin
TableGereStartTransaction(DataModuleImmos.taDetailImmo);
if DataModuleImmos.taDetailImmo.readonly=false then
  DataModuleImmos.taDetailImmo.Edit;
end;

procedure TDetailAcquis.BtnFermerClick(Sender: TObject);
begin
BtnAnnulerClick(self);
Self.Close;
end;

procedure TDetailAcquis.BtnImprimerClick(Sender: TObject);
begin
//if (FPrint = nil) then FPrint:=TFPrint.Create(self);
//FPrint.SelectionEtat := ;
//FPrint.show;
end;

procedure TDetailAcquis.Aide1Click(Sender: TObject);
begin
if activecontrol=DateDebutAmo then
  DateDebutAmo.DoClick;
end;

procedure TDetailAcquis.CodeExit(Sender: TObject);
var
valide:TExceptLGR;
begin
try
if not empty(Code.Field.asstring)then
  while length(Code.Field.asstring)<3 do
    Code.Field.asstring:='0'+Code.Field.asstring;

valide:=DataModuleImmos.CtrlSaisieDescriptionAmort(Code.Field);
except
  Code.SetFocus;
  abort;
end;
end;


procedure TDetailAcquis.Sous_CodeExit(Sender: TObject);
var
valide:TExceptLGR;
begin
try
valide:=DataModuleImmos.CtrlSaisieDescriptionAmort(Sous_Code.Field);
except
   Sous_Code.SetFocus;
   abort;
end;
end;


procedure TDetailAcquis.changementEtatBoutons(Sender: TObject);
var
i:integer;
begin
// Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DMImmos_Ouverture.taDetailImmo);
  case DataModuleImmos.taDetailImmo.state of
   dsBrowse: begin
               BtnInserer.Enabled := false;
               BtnModifier.Enabled := DataModuleImmos.taDetailImmo.RecordCount<>0;
               BtnSupprimer.Enabled :=false;
               BtnImprimer.Enabled:=true;
           End; // Fin du case sur le Tag de la fen�tre
   dsEdit:   begin
               BtnInserer.Enabled := False;
               BtnModifier.Enabled :=false;
               BtnSupprimer.Enabled := false;
               BtnImprimer.Enabled:=false;
             End; // Fin du case sur le Tag de la fen�tre
   dsInsert: begin
               BtnInserer.Enabled := False;
               BtnModifier.Enabled := False;
               BtnSupprimer.Enabled := False;
               BtnImprimer.Enabled:=false;
               End; // Fin du case sur le Tag de la fen�tre
   end;//fin du case.state$
   //Pop-up Menu
   Fermer1.Enabled:=BtnFermer.Enabled;
   Insrer1.Enabled:=BtnInserer.Enabled;
   Enregister1.Enabled:=BtnEnregistrer.Enabled;
   Modifier1.Enabled:=BtnModifier.Enabled;
   Supprimer1.Enabled:=BtnSupprimer.Enabled;
   Imprimer1.Enabled:=BtnImprimer.Enabled;
end;


procedure TDetailAcquis.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  Exception:TExceptLGR;
begin
try
Initialise_ExceptLGR(exception);
CanClose:=true ;
  If DataModuleImmos.taDetailImmo.State = dsInsert Then
      Begin//si en insertion
      self.WindowState:=wsNormal;
      self.BringToFront;
           If Messagedlg('Voulez-vous enregistrer la Description de cette immobilisation ?',MtConfirmation,[mbno,mbyes],0) = mryes Then
                enregistre
           else
             begin
                DataModuleImmos.taDetailImmo.DisableControls;
                DataModuleImmos.taDetailImmo.Cancel;
                DataModuleImmos.taDetailImmo.EnableControls;
             end;
      End;//fin si en insertion


      If DataModuleImmos.taDetailImmo.State = dsEdit Then
      Begin
      self.WindowState:=wsNormal;
      self.BringToFront;
           If Messagedlg('Voulez-vous annuler les modifications de cette immobilisation ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
           Begin
                DataModuleImmos.taDetailImmo.DisableControls;
                DataModuleImmos.taDetailImmo.Cancel;
                DataModuleImmos.taDetailImmo.EnableControls;
           End
           Else
           Begin
                raise ExceptLGR.Create('',1000,false,mtError,Exception);
           End
      End;
  If DataModuleImmos.TaImmosEnCours.State in[dsedit,dsInsert] Then
      Begin//si en insertion
          DataModuleImmos.TaImmosEnCours.DisableControls;
          DataModuleImmos.TaImmosEnCours.Cancel;
          DataModuleImmos.TaImmosEnCours.EnableControls;
      End;//fin si en insertion

initialiserGrille;
if canclose then InitialiseTable_A_Nil;{ isa  le  29/01/04 }
except
  CanClose:=false;
end;
end;


Procedure TDetailAcquis.GestionInitDM;
var
ParamDMImmos:TParamDMImmos;
Begin
try
///etatinitial(mise � z�ro)
Initialise_ParamDMimmos(ParamDMImmos);
////fin etatInitial

 ParamDMImmos.QuiAppel:=F_DetailAcquis;
 ParamDMImmos.TypePresentation:=Tag;

 ParamDMImmos.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ParamDMImmos.ImmosDataStateChange := changementEtatBoutons;
 ParamDMImmos.ImmosAfterScroll:=DetailAcquis.taDetailImmoAfterScroll;
 ParamDMImmos.Quand := DetailAcquis.Quand;

 if not InitialiseDMImmos(ParamDMImmos).retour then abort;
except
  MessageDlg('Probl�me rencontr� lors de l''initialisation du datamodule des '+#13+#10+'immobilisations', mtWarning, [mbOK], 0);
end;
End;


Procedure TDetailAcquis.GereAccesEcran;
begin
     //Grille des comptes d'immos utilis�s
     GrImmosATerminer.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));
     GrImmosATerminer.FSauteColReadOnly := not GrImmosATerminer.ReadOnly;
  case Quand of
     C_Mouvement:Begin
                     //differentes zones de description de l'immo selectionn�e
                     Compte.ReadOnly := true;
                     Code.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));;
                     Sous_code.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));;
                     Libelle.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));
                     DateAcquis.ReadOnly := true;
                     DateDebutAmo.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));
                     DeducInvest.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));
                     rgTypeAmo.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));
                     ValeurAcquis.ReadOnly := not Maintenance;
                     DureeAmo.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));
                     // BtnSupprimer,BtnInserer ces 2 boutons sont toujours enabled=false;
                    EnableWinControl([BtnModifier,BtnEnregistrer],not ((not E.AccesCloture)or(DataModuleImmos.verrouillage)));
                    EnableItemMenu([Modifier1,Tauxamortissement1,Enregister1],not ((not E.AccesCloture)or(DataModuleImmos.verrouillage)));
                 End;
  end;
DataModuleImmos.GestionAccesImmos;
end;

procedure TDetailAcquis.GrImmosATerminerDblClick(Sender: TObject);
begin
BtnModifier.Click ;
DataModuleImmos.TaImmosEnCours.Edit;
DataModuleImmos.TaImmosEnCoursTerminee.Value:=not DataModuleImmos.TaImmosEnCoursTerminee.AsBoolean;
GrImmosATerminer.SelectedIndex:=6;
GrImmosATerminerCellClick(GrImmosATerminer.Columns[6]);
end;

procedure TDetailAcquis.GrImmosATerminerKeyPress(Sender: TObject;
  var Key: Char);
begin
if key=#32 then key:=#0;
end;

procedure TDetailAcquis.GrImmosATerminerKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
if Key = VK_SPACE then
    begin
      key:=0;
      GrImmosATerminerDblClick(GrImmosATerminer);
    end;
end;

procedure TDetailAcquis.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(nil);
end;

procedure TDetailAcquis.GrImmosATerminerColEnter(Sender: TObject);
begin
if GrImmosATerminer.SelectedIndex = 6 then
    GrImmosATerminer.Fields[6].ReadOnly:=false else GrImmosATerminer.Fields[6].ReadOnly:=true;
   GrImmosATerminer.Options:=[dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgAlwaysShowSelection,dgConfirmDelete,dgCancelOnExit];
   if GrImmosATerminer.InplaceEditor <> nil then
                    GrImmosATerminer.EditorMode:=false;
end;

end.