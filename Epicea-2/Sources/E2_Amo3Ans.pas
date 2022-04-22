{***************************************************************
 *
 * Unit Name: E2_Amo3Ans
 * Purpose  :
 * Author   :  Blanchard
 * History  :
 *
 ****************************************************************}

unit E2_Amo3Ans;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, Buttons, Grids, RXCtrls,E2_Decl_Records,
  LibDates,db,LibZoneSaisie, Placemnt,registry,DMConstantes,
  Mask,
  DBCtrls,
  LibSQL,
  E2_LibInfosTable,
  DMImmos,
    E2_Patientez,
  LibGestionParamXML, jpeg, Menus;


type
  TAmort5Ans = class(TForm)
    Entete: THeaderControl;
    ScrollBox1: TScrollBox;
    lbAn0: TListBox;
    lbAn1: TListBox;
    lbAn2: TListBox;
    lbAn3: TListBox;
    lbAn4: TListBox;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaTools: TPanel;
    RxSpeedButton1: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    Panel2: TPanel;
    RxSBImmoEnCours: TRxSpeedButton;
    RxSBToutes: TRxSpeedButton;
    PaBas: TPanel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    FormPlacement1: TFormPlacement;
    Label6: TLabel;
    Label2: TLabel;
    PaEntete: TPanel;
    DBLibelle: TDBEdit;
    Code: TDBEdit;
    Sous_Code: TDBEdit;
    Compte: TDBEdit;
    Label1: TLabel;
    Amort: TDBEdit;
    Label3: TLabel;
    Duree: TDBEdit;
    Label4: TLabel;
    DBTaux: TDBEdit;
    PaCptIntit: TPanel;
    PaImmoIntit: TPanel;
    PaSelectCpt: TPanel;
    RxSBClose: TRxSpeedButton;
    RxSBValider: TRxSpeedButton;
    RxSBInverse: TRxSpeedButton;
    RxSBAnnuleSel: TRxSpeedButton;
    EdRech: TEdit;
    RxChListCpt: TListBox;
    CheckBox1: TCheckBox;
    PaSelectImmos: TPanel;
    RxSBCloseImmos: TRxSpeedButton;
    RxSBValiderImmos: TRxSpeedButton;
    RxSBInverseImmos: TRxSpeedButton;
    RxSBAnnuleSelImmos: TRxSpeedButton;
    EdRechImmos: TEdit;
    RxChListImmos: TListBox;
    CheckBox2: TCheckBox;
    RxSBImmos: TRxSpeedButton;
    RxSBSub: TRxSpeedButton;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure lbAn0DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure RxSBImmoEnCoursClick(Sender: TObject);
    procedure RxSBToutesClick(Sender: TObject);
    procedure PaToolsResize(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure lbAn0MeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure ScrollBox1Resize(Sender: TObject);
    procedure EnteteSectionResize(HeaderControl: THeaderControl;
      Section: THeaderSection);
    procedure lbAn1MeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure lbAn2MeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure lbAn3MeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure lbAn4MeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
//    procedure CalculAmortissementSurSelection(DatasetCalcul:Tdataset);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PaCptIntitClick(Sender: TObject);
    procedure PaSelectCptResize(Sender: TObject);
    procedure RxSBValiderClick(Sender: TObject);
    procedure RxSBInverseClick(Sender: TObject);
    procedure RxSBAnnuleSelClick(Sender: TObject);
    procedure PaSelectImmosResize(Sender: TObject);
    procedure PaImmoIntitClick(Sender: TObject);
    procedure RxSBValiderImmosClick(Sender: TObject);
    procedure RxSBInverseImmosClick(Sender: TObject);
    procedure RxSBAnnuleSelImmosClick(Sender: TObject);
    procedure RxSBCloseImmosClick(Sender: TObject);
    procedure RxSBCloseClick(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
//    Function CalculAmortissementSurSelection_2(DatasetCalcul:Tdataset):Tvaleur;
    procedure RxSBImmosClick(Sender: TObject);
    procedure RxSBSubClick(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
  private
//    function Calcul_nb_mois(DateDebutAmo:TDateTime;dateFinAmo:string;DureeAmo, Restant:integer) : integer;
//    function Min(Val1, Val2 : Currency) : Currency;
//    function Max(Val1, Val2 : Currency) : Currency;
//	 procedure Calcule_taux(DureeAmo:integer; DateDebutAmo,DateAcquisition:TDateTime; var TauxLin, TauxDeg : single;TauxDefaut:single);
//	 function Calcule_VNC(j:integer; Valeur:TValeur; VNC:currency):Currency;
//   function Calcule_Valeur_Ancetre(j:integer; Valeur:TValeur; var ImmosCourante:TinfosImmos):TinfosImmos;
//    procedure raz(var Valeur:TValeur);
//    procedure ajoute(var Valeur, cumul:TValeur);
    procedure affiche(cumul:TValeur);
    procedure afficheSimplifie(cumul:TValeurSimplifie);
    Procedure Texte(Canvas :TCanvas; x1, y1, lx, Hy :Integer; Text :String);
    procedure Initialisation_selection(liste:tstringlist;ChampFiltre:string;Dataset:Tdataset);
//    function CalculMini(CumulMini,CumulAmort,VNC:currency):currency;
  public
    { Déclarations publiques }
  end;

const
	csWidth = 520;		//Largeur de base de la feuille
   csHeight = 387;   //Hauteur de base de la feuille
var
  Amort5Ans: TAmort5Ans;
  DateDebutAmo:TDateTime;
  ValeurAcquis,MiniAnnee,MiniCumule:Currency;
  TauxLin, TauxDeg:Extended;
  ListeCpt:TStringList;
  ListeTmp:TStringList;
  ListeImmo:TStringList;
  ListeID:TStringList;
  DatasetEnCours:TDataSet;


implementation

uses Gr_Librairie_obj, E2_Librairie_obj,  {dbugintf,} E2_Main;

{$R *.DFM}

procedure TAmort5Ans.FormResize(Sender: TObject);
var x, i : integer;
begin
   x := (ScrollBox1.Width - 15) div 5;
   lbAn0.Width := x;
   lbAn0.Left := 0;
   lbAn1.Width := x;
   lbAn1.Left := x;
   lbAn2.Width := x;
   lbAn2.Left := 2 * x;
   lbAn3.Width := x;
   lbAn3.Left := 3 * x;
   lbAn4.Width := x;
   lbAn4.Left := 4 * x;
   for i := 0 to 4 do
   	Entete.Sections[i].Width := x;
   Entete.Sections[0].Width := Entete.Sections[0].Width + 2;
  PaSelectCpt.Width:=PaCptIntit.Width-10;
  PaSelectImmos.Width:=PaImmoIntit.Width-10;
end;

procedure TAmort5Ans.FormCreate(Sender: TObject);
begin
	Left:= 0; Top:= 0; Width:= csWidth; Height:= csHeight;
	if DataModuleImmos = Nil then DataModuleImmos := TDataModuleImmos.Create(Self);
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
        InitialiseFormPosDefaut(self);
    end;
ListeCpt:=TStringList.Create;
Listetmp:=TStringList.Create;
ListeImmo:=TStringList.Create;
ListeID:=TStringList.Create;

end;

procedure TAmort5Ans.FormDestroy(Sender: TObject);
begin
Initialise_TStringlist(ListeCpt,Amort5Ans);
Initialise_TStringlist(Listetmp,Amort5Ans);
Initialise_TStringlist(ListeImmo,Amort5Ans);
Initialise_TStringlist(ListeID,Amort5Ans);

   LibGestionParamXML.DestroyForm(Self,E.User);
   if DataModuleImmos<>nil then  DataModuleImmos.Free;
   Amort5Ans := Nil;
end;

procedure TAmort5Ans.FormActivate(Sender: TObject);
var
    DatasetCalcul:Tdataset;
      Registre :TRegistry;
      //cumul:TValeur;
      cumulSimplifie:TValeurSimplifie;
begin
 Registre:= TRegistry.Create;
 Initialiser_ShortCut_Main(true);
   try
	   with Registre do
           begin
	   RootKey := HKEY_LOCAL_MACHINE;
           OpenKey('\SOFTWARE\LGR\Epicea2\' + e.User+ '\' + self.Name, false);
              try
                //self.Tag:=Readinteger('self.tag');
                //RxSBImmoEnCours.AllowAllUp:=true;
                //RxSBImmoEnCours.down:=ReadBool('RxSBImmoEnCours.down');
//                RxSBToutes.down:=ReadBool('RxSBToutes.down');
                //RxSBImmos.down:=ReadBool('RxSBImmos.down');
                //RxSBSub.down:=ReadBool('RxSBSub.down');
                //RxSBImmoEnCours.AllowAllUp:=false;
              except
                self.Tag:=0;
                RxSBImmoEnCours.down:=true;
                RxSBImmos.down:=false;
                RxSBSub.down:=false;
//                RxSBToutes.down:=false
              end;
           end;
   finally
      Registre.Free;
   end;
case self.tag of
 0:DatasetCalcul:=DataModuleImmos.taDetailImmo;
 1,2,3:begin
        DatasetCalcul:=DataModuleImmos.QuSelectionCalculAmort;
        DataModuleImmos.Filtrage_QuSelectionCalculAmort_SurTag(DataModuleImmos.QuSelectionCalculAmort,self.tag,false,-1,'');
       end;
end;//fin du case
DatasetEnCours:= DatasetCalcul;
//    raz(cumul);
//    cumul:=CalculAmortissementSurSelection_2(DatasetCalcul);
//    affiche(cumul);
    razSimplifie(cumulSimplifie);
    cumulSimplifie:=CalculAmortissementSurSelection_Simplifie(DatasetCalcul);
    afficheSimplifie(cumulSimplifie);

Compte.Visible:=RxSBImmoEnCours.down;
Code.Visible:=RxSBImmoEnCours.down;
Sous_Code.Visible:=RxSBImmoEnCours.down;
Amort.Visible:=RxSBImmoEnCours.down;
Duree.Visible:=RxSBImmoEnCours.down;
DBLibelle.Visible:=RxSBImmoEnCours.down;
Compte.datasource.DataSet:=DatasetCalcul;
Compte.DataField:='Compte';
Code.datasource.DataSet:=DatasetCalcul;
Code.DataField:='Code';
Sous_Code.datasource.DataSet:=DatasetCalcul;
Sous_Code.DataField:='Sous_Code';
Amort.datasource.DataSet:=DatasetCalcul;
Amort.DataField:='Type_Amt';
Duree.datasource.DataSet:=DatasetCalcul;
Duree.DataField:='Duree_Amt';
DBLibelle.datasource.DataSet:=DatasetCalcul;
DBLibelle.DataField:='Libelle';
end;

//function TAmort5Ans.Calcul_nb_mois(DateDebutAmo:TDateTime;dateFinAmo:string;DureeAmo, Restant:integer) : integer;
//var dt : TDateTime; Ydeb, Mdeb, Ddeb, Yexo, Mexo, Dexo : word;
//begin
//   if Restant = 0 then
//   begin
//   	Result := 0;
//      exit;
//   end;
//   dt := DateDebutAmo;
//   DecodeDate(dt, Ydeb, Mdeb, Ddeb);
//   if not empty(dateFinAmo)then
//     dt := strtodate(dateFinAmo)
//   else
//     dt := E.DatExoFin;
//   DecodeDate(dt, Yexo, Mexo, Dexo);
//   if DureeAmo = Restant then
//     begin {Première année}
//       result := Mexo - Mdeb + 1;
//       if result <= 0 then
//         result := result + 12;
//     end
//   else
//     begin
//        if Restant>=12 then
//          result := 12
//        else
//          result:=Restant;
//     end;
//end;

//function TAmort5Ans.Min(Val1, Val2 : Currency) : Currency;
//begin
//   if Val1 > Val2 then Result := Val2
//   else Result := Val1;
//end;


//function TAmort5Ans.Max(Val1, Val2 : Currency) : Currency;
//begin
//   if Val1 > Val2 then Result := Val1
//   else Result := Val2;
//end;





//function TAmort5Ans.Calcule_VNC(j:integer; Valeur:TValeur; VNC:currency):Currency;
//var ancetre:integer; VN:Currency;
//begin
//// retourne la VNC en fonction des choix déjà effectués
//   ancetre := j div 2;
//   VN := VNC;
//	if ancetre > 1 then VN := Calcule_VNC(ancetre, Valeur, VNC);
//   if odd(j) then
//      Result := VN - arrondicentieme(Valeur[ancetre].Maxi)
//   else
//      Result := VN - arrondicentieme(Valeur[ancetre].Mini);
//end;





procedure TAmort5Ans.affiche(cumul:TValeur);
var i,K:integer;
begin
// Calcule les valeurs et les affiche
Screen.Cursor := crSQLWait;
try
// Affiche les années dans les colonnes
k := year(E.DatExoDebut);
for i := 0 to 4 do
Entete.Sections[i].Text := IntToStr(k + i);
// Affichage du résultat
	lbAn0.Items.Clear;
	lbAn1.Items.Clear;
	lbAn2.Items.Clear;
	lbAn3.Items.Clear;
	lbAn4.Items.Clear;
	for i := 1 to 31 do begin
      with cumul[i] do begin
         case annee of
         	1:begin
            	lbAn0.Items.Add('Mini' + FormatFloat('# ##0.00', mini));
               lbAn0.Items.Add('Maxi' + FormatFloat('# ##0.00', maxi));
            end;
            2:begin
            	lbAn1.Items.Add('Mini' + FormatFloat('# ##0.00', mini));
               lbAn1.Items.Add('Maxi' + FormatFloat('# ##0.00', maxi));
            end;
            3:begin
            	lbAn2.Items.Add('Mini' + FormatFloat('# ##0.00', mini));
               lbAn2.Items.Add('Maxi' + FormatFloat('# ##0.00', maxi));
            end;
            4:begin
            	lbAn3.Items.Add('Mini' + FormatFloat('# ##0.00', mini));
               lbAn3.Items.Add('Maxi' + FormatFloat('# ##0.00', maxi));
            end;
            5:begin
            	lbAn4.Items.Add('Mini' + FormatFloat('# ##0.00', mini));
               lbAn4.Items.Add('Maxi' + FormatFloat('# ##0.00', maxi));
            end;
         end;
      end;
   end;
finally
Screen.Cursor := crDefault;
end;
end;


procedure TAmort5Ans.afficheSimplifie(cumul:TValeurSimplifie);
var i,K:integer;
begin
// Calcule les valeurs et les affiche
Screen.Cursor := crSQLWait;
try
// Affiche les années dans les colonnes
k := year(E.DatExoDebut);
for i := 0 to 4 do
Entete.Sections[i].Text := IntToStr(k + i);
// Affichage du résultat
	lbAn0.Items.Clear;
	lbAn1.Items.Clear;
	lbAn2.Items.Clear;
	lbAn3.Items.Clear;
	lbAn4.Items.Clear;
	for i := 1 to 5 do begin
      with cumul[i] do begin
         case annee of
         	1:begin
            	lbAn0.Items.Add('Mini' + FormatFloat('# ##0.00', mini));
               lbAn0.Items.Add('Maxi' + FormatFloat('# ##0.00', maxi));
            end;
            2:begin
            	lbAn1.Items.Add('Mini' + FormatFloat('# ##0.00', mini));
               lbAn1.Items.Add('Maxi' + FormatFloat('# ##0.00', maxi));
            end;
            3:begin
            	lbAn2.Items.Add('Mini' + FormatFloat('# ##0.00', mini));
               lbAn2.Items.Add('Maxi' + FormatFloat('# ##0.00', maxi));
            end;
            4:begin
            	lbAn3.Items.Add('Mini' + FormatFloat('# ##0.00', mini));
               lbAn3.Items.Add('Maxi' + FormatFloat('# ##0.00', maxi));
            end;
            5:begin
            	lbAn4.Items.Add('Mini' + FormatFloat('# ##0.00', mini));
               lbAn4.Items.Add('Maxi' + FormatFloat('# ##0.00', maxi));
            end;
         end;
      end;
   end;
finally
Screen.Cursor := crDefault;
end;
end;



procedure TAmort5Ans.lbAn0DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var s:string; x, y, l, h:integer;  couleur:boolean;
begin
	couleur := not odd(index);
   with (Control as TListBox) do begin
      if couleur then Canvas.Brush.Color := $00ADEBFF
      else Canvas.Brush.Color := $00D6F5FF;
      s := Items[Index];
      Canvas.FillRect(Rect);
      x := Rect.Left + 3;
      y := Rect.Top;
      l := Rect.Right - x - 3;
      h := Rect.Bottom - Rect.Top;
      Texte(Canvas, x, y, l , h, s);
   end;
end;

Procedure TAmort5Ans.Texte(Canvas :TCanvas; x1, y1, lx, Hy :Integer; Text :String);
Var
 ly, px, py :Integer; s1, s2:string;
Begin
   s1 := copy(Text, 1, 4);
   s2 := copy(Text, 5, 30);
   px:= x1 + lx - Canvas.TextWidth(S2);
   if (hy = 0) then hy := -Canvas.Font.Height;
   py:= y1+ trunc((hy - Canvas.TextHeight(Text)) / 2);
   ly:= y1 + hy;
   Canvas.TextRect(Rect(x1, y1, x1 + lx, ly), x1, py, S1);
   Canvas.TextRect(Rect(x1 + Canvas.TextWidth(s1), y1, x1 + lx, ly), px, py, S2);
End;


//function TAmort5Ans.CalculMini(CumulMini,CumulAmort,VNC:currency):currency;
//Begin
//  result:=0;
//  if CumulMini-CumulAmort>0 then
//    result:=CumulMini-CumulAmort;
//  if result>vnc then result:=VNC;
//End;




procedure TAmort5Ans.RxSBImmoEnCoursClick(Sender: TObject);
begin
self.Tag:=C_ImmoCourante;
Compte.Visible:=RxSBImmoEnCours.down;
Code.Visible:=RxSBImmoEnCours.down;
Sous_Code.Visible:=RxSBImmoEnCours.down;
Amort.Visible:=RxSBImmoEnCours.down;
Duree.Visible:=RxSBImmoEnCours.down;
DBLibelle.Visible:=RxSBImmoEnCours.down;
DBTaux.Visible:=RxSBImmoEnCours.down;

//recalculer l'amortissement
DatasetEnCours:= DataModuleImmos.taDetailImmo;
afficheSimplifie(CalculAmortissementSurSelection_Simplifie(DataModuleImmos.taDetailImmo));
//affiche(CalculAmortissementSurSelection_2(DataModuleImmos.taDetailImmo));
end;

procedure TAmort5Ans.RxSBToutesClick(Sender: TObject);
begin
self.Tag:=C_SelectionSurToutes;
Compte.Visible:=RxSBImmoEnCours.down;
Code.Visible:=RxSBImmoEnCours.down;
Sous_Code.Visible:=RxSBImmoEnCours.down;
Amort.Visible:=RxSBImmoEnCours.down;
Duree.Visible:=RxSBImmoEnCours.down;
DBLibelle.Visible:=RxSBImmoEnCours.down;
DBTaux.Visible:=RxSBImmoEnCours.down;

DatasetEnCours:= DataModuleImmos.QuSelectionCalculAmort;
DeFiltrageDataSet(DataModuleImmos.QuSelectionCalculAmort);
DataModuleImmos.Filtrage_QuSelectionCalculAmort_SurTag(DataModuleImmos.QuSelectionCalculAmort,self.tag,false,-1,'');
////recalculer l'amortissement
//affiche(CalculAmortissementSurSelection_2(DataModuleImmos.QuSelectionCalculAmort));
afficheSimplifie(CalculAmortissementSurSelection_Simplifie(DataModuleImmos.QuSelectionCalculAmort));
end;

procedure TAmort5Ans.PaToolsResize(Sender: TObject);
begin
//  FormateTailleBoutton([RxSBImmoEnCours,RxSBToutes,RxSBImmos,RxSBSub],PaTools,100,-1);
  FormateTailleBouttonAvecEspace([RxSBImmoEnCours,RxSBImmos,RxSBSub],PaTools,100,-1,5);
end;

procedure TAmort5Ans.PaBtnResize(Sender: TObject);
begin
  FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
//BtnFermer.Top:=BtnFermer.Top+2;
//BtnFermer.Left:=BtnFermer.left+2;
//BtnFermer.Width:=BtnFermer.Width-4;
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TAmort5Ans.lbAn0MeasureItem(Control: TWinControl; Index: Integer;
  var Height: Integer);
begin
height:=((lbAn0.Height-2) div 2);
end;

procedure TAmort5Ans.ScrollBox1Resize(Sender: TObject);
var
i,j:integer;
begin
FormActivate(self);
//TCustomListBox(lbAn0).dra;
//MeasureItem(lbAn0,0,j);
end;

procedure TAmort5Ans.EnteteSectionResize(HeaderControl: THeaderControl;
  Section: THeaderSection);
begin
lbAn0.Width:=HeaderControl.Sections[0].Width;
lbAn1.Width:=HeaderControl.Sections[1].Width;
lbAn2.Width:=HeaderControl.Sections[2].Width;
lbAn3.Width:=HeaderControl.Sections[3].Width;
lbAn4.Width:=HeaderControl.Sections[4].Width;
end;

procedure TAmort5Ans.lbAn1MeasureItem(Control: TWinControl; Index: Integer;
  var Height: Integer);
begin
// height:=((lbAn1.Height-2) div 4);
end;

procedure TAmort5Ans.lbAn2MeasureItem(Control: TWinControl; Index: Integer;
  var Height: Integer);
begin
//height:=((lbAn2.Height-2) div 8);
end;

procedure TAmort5Ans.lbAn3MeasureItem(Control: TWinControl; Index: Integer;
  var Height: Integer);
begin
//height:=((lbAn3.Height-2) div 16);
//height:=height+(i ((lbAn3.Height-2) mod 16)
end;

procedure TAmort5Ans.lbAn4MeasureItem(Control: TWinControl; Index: Integer;
  var Height: Integer);
begin
//height:=((lbAn4.Height-2) div 32);
end;

procedure TAmort5Ans.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TAmort5Ans.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TAmort5Ans.BtnFermerClick(Sender: TObject);
begin
self.Close;
end;

procedure TAmort5Ans.FormClose(Sender: TObject; var Action: TCloseAction);
Var
  Registre :TRegistry;
begin
  Registre:= TRegistry.Create;

    try
     try
       with Registre do begin
          RootKey := HKEY_LOCAL_MACHINE;
          OpenKey('\SOFTWARE\LGR\Epicea2\' + e.User+ '\' + self.Name, True);
          begin
            WriteInteger('self.tag',self.tag);
            WriteBool('RxSBImmoEnCours.down',RxSBImmoEnCours.down);
//            WriteBool('RxSBToutes.down',RxSBToutes.down);
            WriteBool('RxSBImmos.down',RxSBImmos.down);
            WriteBool('RxSBSub.down',RxSBSub.down);
          end;
          CloseKey;
       end;
     except
     //
     end;
    finally
       Registre.Free;
    end;
end;



//procedure TAmort5Ans.CalculAmortissementSurSelection(DatasetCalcul:Tdataset);
//var ValMini, ValMaxi, VNC, VNC_org,{ReportDerog_,}MiniCumuleReport : Currency;
//    DatefinAmo,dateDebutExo,DateFinExo:TDateTime;
//    DureeAmo, nb_mois,Nb_Jour, Restant,AnneeRestantes,reste, i, j, k,L,conteneur:integer;
//    Valeur, cumul:TValeur;
//    Derniere_Annee:boolean;
//begin
//// Calcule les valeurs et les affiche
//   Screen.Cursor := crHourGlass;
//   try
//   // Affiche les années dans les colonnes
//   k := year(E.DatExoDebut);
//   for i := 0 to 4 do
//   	Entete.Sections[i].Text := IntToStr(k + i);
////	with DMImmos.DataModuleImmos.taDetailImmo do begin
//      with DatasetCalcul do begin
//      First;
//      raz(cumul);
//      while not eof do begin
//      	raz(Valeur);
//        DateFinExo:=e.DatExoFin;
//        dateDebutExo:=e.DatExoDebut;
//
//        ///****cette variable est à revoir quand je reverrai cet écran *****
//        //elle sert pour le calcul du linéaire
//        Derniere_Annee:=false;
//
////        MiniCumule:=FindField('Amort_Eco').AsCurrency;
//        MiniCumuleReport:=FindField('Amort_Eco').AsCurrency+FindField('Amort_Derog').AsCurrency;
////        MiniCumule:=DataModuleImmos.Amort_lin_SurBase360(FindField('date_mise_en_service').AsDateTime,e.DatExoDebut-1, ValeurAcquis,0, TauxLin,'L',Nb_jour);
//        MiniCumule:=DataModuleImmos.Amort_lin_SurBase360(FindField('date_mise_en_service').AsDateTime,e.DatExoDebut-1,e.DatExoDebut-1, ValeurAcquis,0, TauxLin,'L',Nb_jour,FindField('date_cession').AsDateTime<>0,Derniere_Annee,true);
//
//        //ReportDerog_:=MiniCumuleReport-MiniCumule;
//        Miniannee:=0;
//        reste:=0;
//        Nb_Jour:=0;
//        Nb_Mois:=0;
//        //debut:=true;
//         DureeAmo := FindField('Duree_Amt').AsInteger;
//         DateDebutAmo := FindField('date_mise_en_service').AsDateTime;
//
//         DataModuleImmos.Calcule_taux(DureeAmo, DateDebutAmo,FindField('Date_Achat').AsDateTime, TauxLin,tauxDeg ,FindField('TauxAmo').Asfloat);
//         //corriger duree d'amo en fonction de la date de mise en service
//         //si elle est inférieure à la date de début d'exo courant,
//         //on enlève le nb de mois entre ces deux dates
////         if DateDebutAmo<e.DatExoDebut then
//         if DateDebutAmo<dateDebutExo then
//           Begin
////             conteneur:=NbMois(DateDebutAmo,e.DatExoDebut)-1;
//             conteneur:=NbMois(DateDebutAmo,e.DatExoDebut);
//             if conteneur<=DureeAmo then
//               DureeAmo:=DureeAmo-conteneur
//             else
//               DureeAmo:=0;
////             if DateDebutAmo<e.DatExoDebut then
//             DateDebutAmo:=dateDebutExo;
//           End;
//
//         if not empty(FindField('date_cession').Asstring) then
//           DatefinAmo:=FindField('date_cession').AsDateTime
//           else
//             begin
//               if dureeAmo>0 then
//                 DatefinAmo:=MoisSuivant(DateDebutAmo,DureeAmo-1).Date_-1
//               else
//                 DatefinAmo:=DateDebutAmo-1;
//             end;
////         debut:=DateDebutAmo>e.DatExoDebut;
////        ReportDerog_:=MiniCumuleReport-MiniCumule;
//         VNC_org := ((FindField('Valeur_a_Amortir').AsCurrency)-(FindField('Amort_Eco').AsCurrency+FindField('Amort_Derog').AsCurrency));
//         ValeurAcquis := FindField('Valeur_a_Amortir').AsCurrency;
//         reste:=DureeAmo mod 12;
//         if reste>0 then
//           AnneeRestantes:=(DureeAmo div 12)+1
//         else
//           AnneeRestantes:=DureeAmo div 12;
//
//         Restant := DureeAmo;
//// traiter les 5 années
//         for i := 1 to 5 do begin
//            L:=0;
////            nb_mois := Calcul_nb_mois(DateDebutAmo,FindField('Date_Cession').Asstring, DureeAmo, Restant);
//         //   DateDebutAmo:=JourOffset(DateDebutAmo,Nb_Jour).Date_;
//            if DateDebutAmo<dateDebutExo then
//            DateDebutAmo:=dateDebutExo;
//            MiniCumule:=MiniCumule+Miniannee;
//            k := 1 shl (i - 1);
//            for j := 1 to k do
//            begin  // de 1 à 2^(i-1)
//               if ((datefinamo>datedebutamo)and(DateDebutAmo<DateFinExo)) then
//                  begin
//                      if i = 1 then VNC := VNC_org
//                      else VNC := Calcule_VNC(k + j - 1, Valeur, VNC_org);
//                      if (DateFinExo<DatefinAmo) then
//                        MiniAnnee:=DataModuleImmos.Amort_lin_SurBase360(DateDebutAmo,DateFinExo,DateFinExo, ValeurAcquis,Minicumule, TauxLin,'L',Nb_jour,FindField('date_cession').AsDateTime<>0,Derniere_Annee,false)
//                      else
//                        if not empty(FindField('date_cession').Asstring) then
//                          MiniAnnee:=DataModuleImmos.Amort_lin_SurBase360(DateDebutAmo,DatefinAmo,DatefinAmo, ValeurAcquis,Minicumule, TauxLin,'L',Nb_jour,FindField('date_cession').AsDateTime<>0,Derniere_Annee,false)
//                           else
//                           MiniAnnee:=DataModuleImmos.Amort_lin_SurBase360(DateDebutAmo,DateFinExo,DateFinExo, ValeurAcquis,Minicumule, TauxLin,'L',Nb_jour,FindField('date_cession').AsDateTime<>0,Derniere_Annee,false);
//                         if i=1 then
//                           Begin
//                             if (k + j - 1) > 1 then
//                               valeur[k + j - 1].MiniCumul:=valeur[(k + j - 1) div 2].MiniCumul+Miniannee
//                               else valeur[k + j - 1].MiniCumul:=Minicumule+Miniannee; // PB
//                           End
//                         else
//                           Begin
//                             if (k + j - 1) > 1 then
//                               valeur[k + j - 1].MiniCumul:=valeur[(k + j - 1) div 2].MiniCumul+Miniannee
//                               else valeur[k + j - 1].MiniCumul:=Miniannee; // PB
//                           End;
//                      if ((FindField('Type_Amt').AsString = 'L')or(MiniAnnee=0)) then
//                        ValMini :=MiniAnnee
//                      else
//                        if odd((k + j - 1))then
//                         begin
//                          if (k + j - 1) > 1 then // PB
//                            ValMini :=DataModuleImmos.CalculMini(valeur[k + j - 1].MiniCumul,Valeur[(k + j - 1) div 2].AmortCumulMaxi,VNC)
////                            ValMini :=DataModuleImmos.CalculMini(MiniCumule,Valeur[(k + j - 1) div 2].AmortCumulMaxi,VNC)
//                            else
//                              ValMini :=DataModuleImmos.CalculMini(valeur[k + j - 1].MiniCumul,MiniCumuleReport,VNC);// PB
////                            ValMini :=DataModuleImmos.CalculMini(MiniCumule,ReportDerog,VNC);// PB
//                         end
//                        else
//                         begin
//
//                          if (k + j - 1) > 1 then // PB
//                           ValMini :=DataModuleImmos.CalculMini(valeur[k + j - 1].MiniCumul,Valeur[(k + j - 1) div 2].AmortCumulMini,VNC)
//                           else
//                             ValMini :=DataModuleImmos.CalculMini(valeur[k + j - 1].MiniCumul,MiniCumuleReport,VNC); // PB
//                         end;
//                      if FindField('Type_Amt').AsString = 'D' then
//                       begin
//                         if DateFinExo<DatefinAmo then
////                           ValMaxi := DataModuleImmos.Amort_degr(DateDebutAmo,DateFinExo,VNC,MiniAnnee, TauxDeg,Nb_Mois,AnneeRestantes)
////                         else
////                           ValMaxi := DataModuleImmos.Amort_degr(DateDebutAmo,DatefinAmo,VNC,MiniAnnee, TauxDeg,Nb_Mois,AnneeRestantes);
//                           ValMaxi := DataModuleImmos.Amort_degr(DateDebutAmo,DateFinExo,DateFinExo,VNC,MiniAnnee, TauxDeg,Nb_Mois,AnneeRestantes,Restant,FindField('date_cession').AsDateTime<>0)
//                         else
//                           ValMaxi := DataModuleImmos.Amort_degr(DateDebutAmo,DatefinAmo,DatefinAmo,VNC,MiniAnnee, TauxDeg,Nb_Mois,AnneeRestantes,Restant,FindField('date_cession').AsDateTime<>0);
//                       end
//                      else ValMaxi := ValMini;
//                  end
//               else
//                  Begin
//                    ValMini:=0;
//                    ValMaxi:=0;
//                  End;
//
//                with Valeur[k + j - 1] do begin
//                  Mini := ValMini;
//                  Maxi := ValMaxi;
////                  Mini := arrondi(ValMini,0);
////                  Maxi := arrondi(ValMaxi,0);
//                  pere := (k + j - 1) div 2;
//                  annee := i;
//                  if (k + j - 1) > 1 then // PB
//                   begin
//                     if L mod 2=0 then
//                       begin
//                         AmortCumulMini:=valeur[(k + j - 1) div 2].AmortCumulMini+Mini;
//                         AmortCumulMaxi:=valeur[(k + j - 1) div 2].AmortCumulMini+Maxi;
//                       end
//                     else
//                       Begin
//                         AmortCumulMini:=valeur[(k + j - 1) div 2].AmortCumulMaxi+Mini;
//                         AmortCumulMaxi:=valeur[(k + j - 1) div 2].AmortCumulMaxi+Maxi;
//                       End;
//                   end
//                   else
//                   begin
//                         AmortCumulMini:=Mini+MiniCumuleReport;
//                         AmortCumulMaxi:=maxi+MiniCumuleReport;
//
//                   end;
//                  inc(L);
//               end;
//            end;
//            Restant := Restant - nb_mois;
//            AnneeRestantes:=AnneeRestantes-1;
//            DateFinExo:=MoisSuivant(DateFinExo,11).Date_;
//            dateDebutExo:=MoisSuivant(dateDebutExo,11).Date_;
//            //Debut:=false;
//            //ReportDerog_:=0;
//            MiniCumuleReport:=0;
//         end;
//         ajoute(Valeur, cumul);
//      	next;
//      end;
//   end;
//   affiche(cumul);
//   finally
//   Screen.Cursor := crDefault;
//   end;
//end;

procedure TAmort5Ans.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
canclose:=true;
if PaSelectCpt.Visible then PaSelectCpt.Visible:=false;
if PaSelectImmos.Visible then PaSelectImmos.Visible:=false;
end;

procedure TAmort5Ans.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = VK_RETURN then
   begin
     WinSuivPrec(Handle,key,[nil]);
   end;
 If Key = VK_ESCAPE Then
   Begin
    if PaSelectCpt.Visible then
       begin
         PaSelectCpt.Visible:=false;
         key:=0;
       end
    else
    if PaSelectImmos.Visible then
       begin
         PaSelectImmos.Visible:=false;
         key:=0;
       end
    else
      self.close;   
   end;
end;

procedure TAmort5Ans.PaCptIntitClick(Sender: TObject);
var
id_depart,i:integer;
begin
if not PaSelectCpt.Visible then
   Begin
   PaSelectImmos.Visible:=false;
   rxchlistImmos.clear;
   DataModuleImmos.QuSelectionCalculAmort.DisableControls;
   id_depart:=compte.DataSource.DataSet.findfield('id').AsInteger;
   DataModuleImmos.Filtrage_QuSelectionCalculAmort_SurTag(DataModuleImmos.QuSelectionCalculAmort,1,false,-1,'');
    if RxChListCpt.Items.Count =0 then
       Begin
         ListeCpt.Clear;
         ListeImmo.Clear;
         ListeID.clear;
         RxChListCpt.Tag:=1;
         DeFiltrageDataSet(DataModuleImmos.QuSelectionCalculAmort);
         DataModuleImmos.QuSelectionCalculAmort.First;
         for i:=0 to DataModuleImmos.QuSelectionCalculAmort.RecordCount-1 do
             Begin
              if ListeCpt.IndexOf(DataModuleImmos.QuSelectionCalculAmort.findfield('Compte').AsString)=-1 then
              begin
                RxChListCpt.Items.Add(DataModuleImmos.QuSelectionCalculAmort.findfield('Compte').AsString);
                ListeCpt.Add(DataModuleImmos.QuSelectionCalculAmort.findfield('Compte').AsString);
                //ListeImmo.Add(DataModuleImmos.QuSelectionCalculAmort.findfield('immobilisation').AsString);
              end;
              DataModuleImmos.QuSelectionCalculAmort.Next;
             End;
         DataModuleImmos.QuSelectionCalculAmort.locate('id',id_depart,[]);
         DataModuleImmos.QuSelectionCalculAmort.EnableControls;
       End;
PaSelectCpt.Top:=PaEntete.top;
PaSelectCpt.Width:=PaCptIntit.Width-10;
EdRech.Visible:=false;
RxChListCpt.Width:=PaSelectCpt.Width;
PaSelectCpt.Height:=ScrollBox1.Height-20;
RxChListCpt.Height:=PaSelectCpt.Height-69;// 298;
RxSBValider.Top:=PaSelectCpt.Height-47;
CheckBox1.Top:=RxSBValider.Top+5;
RxSBInverse.Top:=PaSelectCpt.Height-47;
RxSBAnnuleSel.Top:=PaSelectCpt.Height-22;
PaSelectCpt.Left:=PaCptIntit.left+5;
PaSelectCpt.Visible:=not PaSelectCpt.Visible;
RxChListCpt.SetFocus;
   End;
end;


procedure TAmort5Ans.PaSelectCptResize(Sender: TObject);
begin
RxChListCpt.Width:=PaSelectCpt.Width-8;
EdRech.Width:=PaSelectCpt.Width-8;
RxSBClose.Width:=PaSelectCpt.Width;
RxSBAnnuleSel.Width:=PaSelectCpt.Width;
RxSBValider.Width:=PaSelectCpt.Width div 2;
RxSBInverse.Left:=RxSBValider.Width-1;
RxSBInverse.Width:=PaSelectCpt.Width-RxSBInverse.Left;
end;


procedure TAmort5Ans.RxSBValiderClick(Sender: TObject);
var
i:integer;
begin
ListeTmp.Clear;
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
    if RxChListCpt.Selected[i] then
      ListeTmp.Add(ListeCpt.Strings[i]);
   End;
//initialiser la nouvelle sélection
Initialisation_selection(listetmp,'Compte',DataModuleImmos.QuSelectionCalculAmort);

if CheckBox1.Checked then
 begin
//  GrDBGrid1.SetFocus;
  PaSelectCpt.Visible:=false;
 end
 else
 begin
//  GrDBGrid1.SetFocus;
 end;
end;


procedure TAmort5Ans.RxSBInverseClick(Sender: TObject);
var
i:integer;
begin
ListeTmp.Clear;
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
    RxChListCpt.Selected[i]:=not RxChListCpt.Selected[i];
    if RxChListCpt.Selected[i] then
     ListeTmp.Add(ListeCpt.Strings[i]);
   End;

//initialiser la nouvelle sélection
Initialisation_selection(listetmp,'Compte',DataModuleImmos.QuSelectionCalculAmort);
end;


procedure TAmort5Ans.RxSBAnnuleSelClick(Sender: TObject);
var
i:integer;
begin
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
      RxChListCpt.Selected[i]:=false;
   End;
//initialiser la nouvelle sélection
Initialisation_selection(nil,'Compte',DataModuleImmos.QuSelectionCalculAmort);
end;

procedure TAmort5Ans.Initialisation_selection(liste:tstringlist;ChampFiltre:string;Dataset:Tdataset);
begin

if liste <> nil then
 Begin
 if liste.Count > 0 then
  begin
    DeFiltrageDataSet(dataset);
    FiltrageDataSet(Dataset,CreeFiltreOU(champfiltre,[liste]));
  end;
 End
 else
   DeFiltrageDataSet(dataset);
Compte.Visible:=false;
Code.Visible:=false;
Sous_Code.Visible:=false;
Amort.Visible:=false;
Duree.Visible:=false;
DBLibelle.Visible:=false;
DBTaux.Visible:=false;
DatasetEnCours:= Dataset;
afficheSimplifie(CalculAmortissementSurSelection_Simplifie(Dataset));
end;

procedure TAmort5Ans.PaSelectImmosResize(Sender: TObject);
begin
RxChListImmos.Width:=PaSelectImmos.Width-8;
EdRechImmos.Width:=PaSelectImmos.Width-8;
RxSBCloseImmos.Width:=PaSelectImmos.Width;
RxSBAnnuleSelImmos.Width:=PaSelectImmos.Width;
RxSBValiderImmos.Width:=PaSelectImmos.Width div 2;
RxSBInverseImmos.Left:=RxSBValiderImmos.Width-1;
RxSBInverseImmos.Width:=PaSelectImmos.Width-RxSBInverse.Left;
end;


procedure TAmort5Ans.PaImmoIntitClick(Sender: TObject);
var
id_depart,i:integer;
begin
if not PaSelectImmos.Visible then
   Begin
   PaSelectCpt.Visible:=false;
   rxchlistCpt.clear;
   DataModuleImmos.QuSelectionCalculAmort.DisableControls;
   id_depart:=compte.DataSource.DataSet.findfield('id').AsInteger;
   DataModuleImmos.Filtrage_QuSelectionCalculAmort_SurTag(DataModuleImmos.QuSelectionCalculAmort,1,false,-1,'');
   DataModuleImmos.Filtrage_QuSelectionCalculAmort_SurTag(DataModuleImmos.QuSelectionCalculAmort,1,false,-1,'');
    if RxChListImmos.Items.Count =0 then
       Begin
         ListeCpt.Clear;
         ListeImmo.Clear;
         ListeID.clear;
         RxChListImmos.Tag:=1;
         DeFiltrageDataSet(DataModuleImmos.QuSelectionCalculAmort);
         DataModuleImmos.QuSelectionCalculAmort.First;
         for i:=0 to DataModuleImmos.QuSelectionCalculAmort.RecordCount-1 do
             Begin
              if ListeImmo.IndexOf(DataModuleImmos.QuSelectionCalculAmort.findfield('Immobilisation').AsString)=-1 then
              begin
                RxChListImmos.Items.Add(DataModuleImmos.QuSelectionCalculAmort.findfield('Immobilisation').AsString);
                ListeID.Add(DataModuleImmos.QuSelectionCalculAmort.findfield('ID').AsString);
                ListeCpt.Add(DataModuleImmos.QuSelectionCalculAmort.findfield('Compte').AsString);
                ListeImmo.Add(DataModuleImmos.QuSelectionCalculAmort.findfield('Immobilisation').AsString);
              end;
              DataModuleImmos.QuSelectionCalculAmort.Next;
             End;
         DataModuleImmos.QuSelectionCalculAmort.locate('id',id_depart,[]);
         DataModuleImmos.QuSelectionCalculAmort.EnableControls;
       End;
PaSelectImmos.Top:=PaEntete.top;
PaSelectImmos.Width:=PaImmoIntit.Width-10;
EdRechImmos.Visible:=false;
RxChListImmos.Width:=PaSelectImmos.Width;
PaSelectImmos.Height:=ScrollBox1.Height-20;
RxChListImmos.Height:=PaSelectImmos.Height-69;// 298;
RxSBValiderImmos.Top:=PaSelectImmos.Height-47;
CheckBox2.Top:=RxSBValiderImmos.Top+5;
RxSBInverseImmos.Top:=PaSelectImmos.Height-47;
RxSBAnnuleSelImmos.Top:=PaSelectImmos.Height-22;
PaSelectImmos.Left:=PaImmoIntit.left+5;
PaSelectImmos.Visible:=not PaSelectImmos.Visible;
RxChListImmos.SetFocus;
   End;
end;


procedure TAmort5Ans.RxSBValiderImmosClick(Sender: TObject);
var
i:integer;
begin
ListeTmp.Clear;
for i:=0  to RxChListImmos.Items.Count-1 do
   Begin
    if RxChListImmos.Selected[i] then
      ListeTmp.Add(ListeID.Strings[i]);
   End;
//initialiser la nouvelle sélection
Initialisation_selection(listetmp,'id',DataModuleImmos.QuSelectionCalculAmort);

if CheckBox1.Checked then
 begin
//  GrDBGrid1.SetFocus;
  PaSelectIMMOS.Visible:=false;
 end
 else
 begin
//  GrDBGrid1.SetFocus;
 end;
end;


procedure TAmort5Ans.RxSBInverseImmosClick(Sender: TObject);
var
i:integer;
begin
ListeTmp.Clear;
for i:=0  to RxChListImmos.Items.Count-1 do
   Begin
    RxChListImmos.Selected[i]:=not RxChListImmos.Selected[i];
    if RxChListImmos.Selected[i] then
     ListeTmp.Add(ListeID.Strings[i]);
   End;

//initialiser la nouvelle sélection
Initialisation_selection(listetmp,'id',DataModuleImmos.QuSelectionCalculAmort);
end;


procedure TAmort5Ans.RxSBAnnuleSelImmosClick(Sender: TObject);
var
i:integer;
begin
for i:=0  to RxChListImmos.Items.Count-1 do
   Begin
    RxChListImmos.Selected[i]:=false;
   End;
//initialiser la nouvelle sélection
Initialisation_selection(nil,'',DataModuleImmos.QuSelectionCalculAmort);
end;


procedure TAmort5Ans.RxSBCloseImmosClick(Sender: TObject);
begin
PaSelectImmos.Visible:=false;
end;

procedure TAmort5Ans.RxSBCloseClick(Sender: TObject);
begin
PaSelectCpt.Visible:=false;
end;

Procedure TAmort5Ans.InitialiseTable_A_Nil;
Begin
//
End;




procedure TAmort5Ans.RxSBImmosClick(Sender: TObject);
begin
self.Tag:=C_SelectionSurImmo;
Compte.Visible:=RxSBImmoEnCours.down;
Code.Visible:=RxSBImmoEnCours.down;
Sous_Code.Visible:=RxSBImmoEnCours.down;
Amort.Visible:=RxSBImmoEnCours.down;
Duree.Visible:=RxSBImmoEnCours.down;
DBLibelle.Visible:=RxSBImmoEnCours.down;
DBTaux.Visible:=RxSBImmoEnCours.down;
//je ne passe pas par defiltrageDataset car il n'y a pas forcement d'instruction Sql à ce moment là
DatasetEnCours:= DataModuleImmos.QuSelectionCalculAmort;
DeFiltrageDataSet(DataModuleImmos.QuSelectionCalculAmort);
DataModuleImmos.Filtrage_QuSelectionCalculAmort_SurTag(DataModuleImmos.QuSelectionCalculAmort,self.tag,false,-1,'');
////recalculer l'amortissement
//affiche(CalculAmortissementSurSelection_2(DataModuleImmos.QuSelectionCalculAmort));
afficheSimplifie(CalculAmortissementSurSelection_Simplifie(DataModuleImmos.QuSelectionCalculAmort));
end;

procedure TAmort5Ans.RxSBSubClick(Sender: TObject);
begin
self.Tag:=C_SelectionSurSub;
Compte.Visible:=RxSBImmoEnCours.down;
Code.Visible:=RxSBImmoEnCours.down;
Sous_Code.Visible:=RxSBImmoEnCours.down;
Amort.Visible:=RxSBImmoEnCours.down;
Duree.Visible:=RxSBImmoEnCours.down;
DBLibelle.Visible:=RxSBImmoEnCours.down;
DBTaux.Visible:=RxSBImmoEnCours.down;

DatasetEnCours:= DataModuleImmos.QuSelectionCalculAmort;
DeFiltrageDataSet(DataModuleImmos.QuSelectionCalculAmort);
DataModuleImmos.Filtrage_QuSelectionCalculAmort_SurTag(DataModuleImmos.QuSelectionCalculAmort,self.tag,false,-1,'');
////recalculer l'amortissement
//affiche(CalculAmortissementSurSelection_2(DataModuleImmos.QuSelectionCalculAmort));
afficheSimplifie(CalculAmortissementSurSelection_Simplifie(DataModuleImmos.QuSelectionCalculAmort));
end;


procedure TAmort5Ans.BtnImprimerClick(Sender: TObject);
begin
//if (RxSBImmoEnCours.Down)then
//EditionAmort5AnsSimplifieL(C_EditionSimple,false,nil,DataModuleImmos.taDetailImmo,'')
//else
EditionAmort5AnsSimplifieL(C_EditionSimple,false,nil,DatasetEnCours,'');
end;

procedure TAmort5Ans.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(nil);
end;

end.
