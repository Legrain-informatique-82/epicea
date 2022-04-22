unit ChoixPeriode;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,E2_DEcl_Records,LibDates,LibZoneSaisie,Gr_Librairie_Obj,
  E2_Librairie_Obj,DMConstantes,PickDate, Menus, LibGestionParamXML, RXCtrls,
  ExtCtrls, jpeg,lib_chaine;

type

TParamAffichPeriode=record
  PreAffichage:boolean;
  AffichDateDeb:boolean;
  AffichDateFin:boolean;
  Titre:string;
  SousTitre:string;
  DateDebDefaut:Tdate;
  DateFinDefaut:Tdate;
  RenvoieDateDefaut:boolean;
  DateDansExercice:boolean;
end;


  TChoix_Periode = class(TForm)
    PaBas: TPanel;
    PopupMenu1: TPopupMenu;
    AideDate1: TMenuItem;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaTitrePetit: TPanel;
    PaBtn: TPanel;
    BtnEnregistrer: TButton;
    BtnAnnuler: TButton;
    Panel1: TPanel;
    PaDateFin: TPanel;
    Label2: TLabel;
    RxLabel1: TRxLabel;
    EdDateFin: TEdit;
    RSBDateFin: TRxSpeedButton;
    PaDateDeb: TPanel;
    Label1: TLabel;
    RxLabel3: TRxLabel;
    EdDateDeb: TEdit;
    RSBDateDeb: TRxSpeedButton;
    Annuler1: TMenuItem;
    Valider1: TMenuItem;
    procedure EdDateDebKeyPress(Sender: TObject; var Key: Char);
    procedure EdDateFinKeyPress(Sender: TObject; var Key: Char);
    procedure EdDateDebExit(Sender: TObject);
    procedure EdDateFinExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AideDate1Click(Sender: TObject);
    procedure RSBDateDebClick(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure Annuler1Click(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure Valider1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure RSBDateFinClick(Sender: TObject);

  private
    { Déclarations privées }
    DateDebDefautSurValidation,DateFinDefautSurValidation:TDate;
  public
    { Déclarations publiques }
    ParamAffichPeriodeObjet:TParamAffichPeriode;
  end;

var
  Choix_Periode: TChoix_Periode;

  Procedure Initialise_ParamAffichPeriode(Var ParamAffichPeriode:TParamAffichPeriode);
//  Function ChoixPeriodeAffich(ParametreAffichage:TParamAffichPeriode):TPeriode;
Function ChoixPeriodeAffich(DateDebDefautSurValidation,DateFinDefautSurValidation:TDate;Titre:String;ParametreAffichage:TParamAffichPeriode):TPeriode;

implementation

uses DMRecherche;

//uses DMCorrection;

{$R *.DFM}

//Function ChoixPeriodeAffich(ParametreAffichage:TParamAffichPeriode):TPeriode;
//Begin
//result.Retour:=false;
//result.DateDeb:=now;
//result.DateFin:=result.DateDeb;
//if Choix_Periode = nil then Choix_Periode:=TChoix_Periode.Create(Application.MainForm);
//if not empty(ParametreAffichage.Titre) then
//   Choix_Periode.Caption := ParametreAffichage.Titre
//   else
//   Choix_Periode.Caption := 'Choisir une période.';
//if not empty(ParametreAffichage.SousTitre) then
//   Choix_Periode.PaTitrePetit.Caption := ParametreAffichage.SousTitre
//   else
//   Choix_Periode.PaTitrePetit.Caption := Choix_Periode.Caption;
//if ParametreAffichage.DateDebDefaut = 0 then
//  ParametreAffichage.DateDebDefaut:=date;
//if ParametreAffichage.DateFinDefaut = 0 then
//  ParametreAffichage.DateFinDefaut:=date;
//Choix_Periode.DateDebDefautSurValidation:=ParametreAffichage.DateDebDefaut;
//Choix_Periode.DateFinDefautSurValidation:=ParametreAffichage.DateFinDefaut;
//if ParametreAffichage.PreAffichage then
// begin
//  Choix_Periode.EdDateDeb.Text:=DateToStr(Choix_Periode.DateDebDefautSurValidation);
//  Choix_Periode.EdDateFin.text:=DateToStr(Choix_Periode.DateFinDefautSurValidation);
// end;
//Choix_Periode.EdDateDeb.visible:=ParametreAffichage.AffichDateDeb;
//Choix_Periode.EdDateFin.visible:=ParametreAffichage.AffichDateFin;
//
//Result.Retour:=Choix_Periode.ShowModal = MrOk;
//if Result.Retour then
// begin
//  result.DateDeb:=StrToDate(Choix_Periode.EdDateDeb.text);
//  result.DateFin:=StrToDate(Choix_Periode.EdDateFin.text);
// end;
//End;
Function ChoixPeriodeAffich(DateDebDefautSurValidation,DateFinDefautSurValidation:TDate;Titre:String;ParametreAffichage:TParamAffichPeriode):TPeriode;
Begin
result.Retour:=false;
result.DateDeb:=now;
result.DateFin:=result.DateDeb;
if Choix_Periode = nil then Choix_Periode:=TChoix_Periode.Create(Application.MainForm);
Choix_Periode.ParamAffichPeriodeObjet:=ParametreAffichage;

if not empty(Titre) then
   Choix_Periode.Caption := Titre
   else
   Choix_Periode.Caption := 'Choisir une période.';
if not empty(ParametreAffichage.Titre)then
   Choix_Periode.Caption := ParametreAffichage.Titre;
if not empty(ParametreAffichage.SousTitre) then
   Choix_Periode.PaTitrePetit.Caption := ParametreAffichage.SousTitre
   else
   Choix_Periode.PaTitrePetit.Caption := Choix_Periode.Caption;
if ((DateDebDefautSurValidation = 0)and(ParametreAffichage.RenvoieDateDefaut)) then 
  DateDebDefautSurValidation:=date;
if ((DateFinDefautSurValidation = 0)and(ParametreAffichage.RenvoieDateDefaut)) then
  DateFinDefautSurValidation:=date;

Choix_Periode.DateDebDefautSurValidation:=DateDebDefautSurValidation;
Choix_Periode.DateFinDefautSurValidation:=DateFinDefautSurValidation;

if ParametreAffichage.PreAffichage then
 begin
  Choix_Periode.EdDateDeb.Text:=DateToStr(Choix_Periode.DateDebDefautSurValidation);
  Choix_Periode.EdDateFin.text:=DateToStr(Choix_Periode.DateFinDefautSurValidation);
 end;
Choix_Periode.PaDateDeb.visible:=ParametreAffichage.AffichDateDeb;
Choix_Periode.PaDateFin.visible:=ParametreAffichage.AffichDateFin;

Result.Retour:=Choix_Periode.ShowModal = MrOk;
if Result.Retour then
 begin
  result.DateDeb:=StrToDate_lgr(Choix_Periode.EdDateDeb.text);
  result.DateFin:=StrToDate_lgr(Choix_Periode.EdDateFin.text);
 end;
End;

procedure TChoix_Periode.EdDateDebKeyPress(Sender: TObject; var Key: Char);
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

procedure TChoix_Periode.EdDateFinKeyPress(Sender: TObject; var Key: Char);
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

procedure TChoix_Periode.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer],PaBtn,90,0);
end;

procedure TChoix_Periode.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TChoix_Periode.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;


procedure TChoix_Periode.EdDateDebExit(Sender: TObject);
begin
if ((empty(EdDateDeb.text))and (DateDebDefautSurValidation<>0)) then
  begin
    EdDateDeb.text:=DAteInfos(DateDebDefautSurValidation).DateStr;
    EdDateDeb.text:=AnneeDefaut(0,0,EdDateDeb.text).DateStr;
  end;
end;

procedure TChoix_Periode.EdDateFinExit(Sender: TObject);
begin
if ((empty(EdDateFin.text))and (DateDebDefautSurValidation<>0)) then
  begin
    EdDateFin.text:=DAteInfos(DateFinDefautSurValidation).DateStr;
    EdDateFin.text:=AnneeDefaut(0,0,EdDateFin.text).DateStr;
  end;
end;
procedure TChoix_Periode.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_CANCEL then ModalResult:= mrCancel;
WinSuivPrec(Handle,key,[nil]);
end;

procedure TChoix_Periode.FormShow(Sender: TObject);
begin
if Choix_Periode.EdDateDeb.CanFocus then Choix_Periode.EdDateDeb.SetFocus
else
  if Choix_Periode.EdDateFin.CanFocus then Choix_Periode.EdDateFin.SetFocus
end;

procedure TChoix_Periode.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,E.User);
Choix_Periode:=nil;
end;

procedure TChoix_Periode.FormCreate(Sender: TObject);
begin
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
      Initialise_ParamAffichPeriode(ParamAffichPeriodeObjet);
  except
      Position:=poScreenCenter;
      //InitialiseFormPosDefaut(self);
  end;
end;

procedure TChoix_Periode.AideDate1Click(Sender: TObject);
begin
if activeControl = EdDateDeb then
  if PopupDate(TDateTime(DateDebDefautSurValidation),ActiveControl) then
    EdDateDeb.text:=DAteInfos(DateDebDefautSurValidation).DateStr;

if activeControl = EdDateFin then
  if PopupDate(TDateTime(DateFinDefautSurValidation),ActiveControl) then
    EdDateFin.text:=DAteInfos(DateFinDefautSurValidation).DateStr;
end;

procedure TChoix_Periode.RSBDateDebClick(Sender: TObject);
begin
EdDateDeb.SetFocus;
AideDate1Click(AideDate1);
end;

procedure TChoix_Periode.BtnEnregistrerClick(Sender: TObject);
begin
EdDateDebExit(EdDateDeb);
EdDateFinExit(EdDateFin);
if ((ParamAffichPeriodeObjet.AffichDateDeb)and(ParamAffichPeriodeObjet.AffichDateFin)) then
  begin
    case CompareDate(StrToDate_lgr(EdDateDeb.text),StrToDate_lgr(EdDateFin.text)) of
       -1:begin
           showmessage('Attention, les dates saisies sont inversées !');
           modalResult:=mrNone;
          end;
       0:begin
    //      showmessage('Attention, les dates saisies sont égales !');
    //       modalResult:=mrNone;
         end;
    end;//fin du case
       if(ParamAffichPeriodeObjet.DateDansExercice)and ( not(DateDsIntervale(e.DatExoDebut,StrToDate_Lgr(EdDateDeb.Text),e.DatExoFin))
            and(DateDsIntervale(e.DatExoDebut,StrToDate_Lgr(EdDateFin.Text),e.DatExoFin)))then
          begin
             showmessage('les dates de début et de fin doivent faire partie de l''exercice courant');
             modalResult:=mrNone;
          end;
  end;//fin si les 2 dates servent
if (ModalResult=mrOk) and (PeriodeEpure(StrToDate_lgr(EdDateDeb.text),StrToDate_lgr(EdDateFin.text))) then
    Application.MessageBox(Pchar('Attention !!! votre recherche porte sur une période épurée !!!'),'Attention',MB_ICONWARNING);
end;

Procedure Initialise_ParamAffichPeriode(Var ParamAffichPeriode:TParamAffichPeriode);
begin
  ParamAffichPeriode.PreAffichage:=true;
  ParamAffichPeriode.AffichDateDeb:=true;
  ParamAffichPeriode.AffichDateFin:=true;
  ParamAffichPeriode.Titre:='';
  ParamAffichPeriode.SousTitre:='';
  ParamAffichPeriode.DateDebDefaut:=0;
  ParamAffichPeriode.DateFinDefaut:=0;
  ParamAffichPeriode.RenvoieDateDefaut:=true;
  ParamAffichPeriode.DateDansExercice:=false;
end;

procedure TChoix_Periode.Annuler1Click(Sender: TObject);
begin
//ModalResult:=mrcancel;
BtnAnnulerClick(BtnAnnuler);
end;

procedure TChoix_Periode.BtnAnnulerClick(Sender: TObject);
begin
//ModalResult:=Mrcancel;
end;

procedure TChoix_Periode.Valider1Click(Sender: TObject);
begin
//ModalResult:=mrOk;
BtnEnregistrer.Click;
end;

procedure TChoix_Periode.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key = #27 then ModalResult:= mrCancel;
end;

procedure TChoix_Periode.RSBDateFinClick(Sender: TObject);
begin
EdDateFin.SetFocus;
AideDate1Click(AideDate1);
end;

end.
