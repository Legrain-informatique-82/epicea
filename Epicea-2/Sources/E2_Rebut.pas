{***************************************************************
 *
 * Unit Name: E2_Rebut
 * Purpose  :
 * Author   :  Blanchard
 * History  :
 *
 ****************************************************************}

unit E2_Rebut;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls,  Mask, DBCtrls, ComCtrls, Gr_Librairie_obj,E2_Librairie_Obj,
  Buttons, Menus, db, ToolEdit,E2_Decl_Records, RXDBCtrl,LibZoneSaisie,
  LibGestionParamXML,
  LibSQL,
  DMConstantes;

type

  TParamAffichageRebut=Record
   Affiche:Boolean;
   AffichageModal:Boolean;
   Quand:Integer;
   TitreForm:String;
   SousTitreForm:String;
   ImmoCourante:integer;
   QuiAppel:TTypeFenetre;
  end;

  TRebut = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Compte: TDBRichEdit;
    Code: TDBEdit;
    Label18: TLabel;
    Sous_code: TDBEdit;
    Libelle: TDBEdit;
    Label1: TLabel;
    Date_Acq: TDBEdit;
    Label3: TLabel;
    Val_Acq: TDBEdit;
    Label2: TLabel;
    Date_MeS: TDBEdit;
    Label4: TLabel;
    Duree_Amt: TDBEdit;
    Label20: TLabel;
    PopupMenu1: TPopupMenu;
    Aide1: TMenuItem;
    N1: TMenuItem;
    Fermer1: TMenuItem;
    Date_Rebut: TDBDateEdit;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    Label7: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Enregistrer1: TMenuItem;
    Imprimer1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Date_RebutExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Date_RebutEnter(Sender: TObject);
    Procedure GereAccesEcran;
    Procedure GestionInitDM;
  private
  public
    TitreForm,SousTitreForm:String;
    Quand:Integer;
    ImmoCourante:integer;
    { Déclarations publiques }
  end;

const
   csWidth = 488;    //Largeur de base de la feuille
   csHeight = 278;   //Hauteur de base de la feuille
var
  Rebut: TRebut;
  DateRebutTmp:Tdate;

  Function RebutAffiche(ParamAffichageRebut:TParamAffichageRebut):boolean;

  
implementation

uses DMImmos, LibDates, E2_Main, LibClassObjetSenders, E2_AideCompte;

{$R *.DFM}
Function RebutAffiche(ParamAffichageRebut:TParamAffichageRebut):boolean;
var
ParamDMImmos:TParamDMImmos;
Begin
try
///etatinitial(mise à zéro)
Initialise_ParamDMimmos(ParamDMImmos);
////fin etatInitial

 if (Rebut = nil) then Rebut:=TRebut.Create(Application.MainForm);
 if ((ParamAffichageRebut.Quand <> Rebut.Quand) and (Rebut.Visible=true)) then
   Rebut.Close;
 Rebut.Quand:=ParamAffichageRebut.Quand;
 ////
// Rebut.Tag:=ParamAffichageRebut.TypePresentation;
// {C_ACQUISITION_Terminee,C_ACQUISITION_En_Cours,C_ACQUISITION_Simple}
// {C_DESCRIPTION_terminee,C_DESCRIPTION_Simple,C_DESCRIPTION_En_Cours}
 ///
 if not empty(ParamAffichageRebut.TitreForm) then
   Rebut.TitreForm:=ParamAffichageRebut.TitreForm;
 Rebut.SousTitreForm:=ParamAffichageRebut.SousTitreForm;
 Rebut.ImmoCourante:=ParamAffichageRebut.ImmoCourante;
 ParamDMImmos.ImmoCourante:=ParamAffichageRebut.ImmoCourante;
 ParamDMImmos.ImmosDataStateChange := nil;
 ParamDMImmos.ImmosAfterScroll:=nil;
 ParamDMImmos.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
// ParamDMImmos.TypePresentation:=ParamAffichageRebut.TypePresentation;
 ParamDMImmos.Quand := Rebut.Quand;
 ParamDMImmos.QuiAppel:=ParamAffichageRebut.QuiAppel;
   case Rebut.Quand of
      C_mouvement:Begin
                   if not InitialiseDMImmos(ParamDMImmos).retour then abort;
                  End;
   end;

 if ParamAffichageRebut.Affiche then
  begin
     //differentes zones de description de l'immo selectionnée
     Rebut.Compte.DataSource := DataModuleImmos.DaImmosRebut;
     Rebut.Code.DataSource := DataModuleImmos.DaImmosRebut;
     Rebut.Sous_code.DataSource := DataModuleImmos.DaImmosRebut;
     Rebut.Libelle.DataSource := DataModuleImmos.DaImmosRebut;
     Rebut.Date_Acq.DataSource := DataModuleImmos.DaImmosRebut;
     Rebut.Date_MeS.DataSource := DataModuleImmos.DaImmosRebut;
     Rebut.Val_Acq.DataSource := DataModuleImmos.DaImmosRebut;
     Rebut.Duree_Amt.DataSource := DataModuleImmos.DaImmosRebut;
     Rebut.Date_Rebut.DataSource := DataModuleImmos.DaImmosRebut;
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(Application.MainForm);

     if ParamAffichageRebut.AffichageModal then
       Rebut.ShowModal
      else
       Rebut.Show;
  End;
except
  result:=false;
end;
End;

Procedure TRebut.GestionInitDM;
var
ParamDMImmos:TParamDMImmos;
Begin
try
///etatinitial(mise à zéro)
Initialise_ParamDMimmos(ParamDMImmos);
////fin etatInitial

 ParamDMImmos.QuiAppel:=F_Rebut;
// ParamDMImmos.TypePresentation:=Tag;

 ParamDMImmos.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ParamDMImmos.ImmosDataStateChange := nil;
 ParamDMImmos.ImmosAfterScroll:=nil;
 ParamDMImmos.CptImmosAfterOpen:=nil;
 ParamDMImmos.CptImmosAfterScroll:=nil;
 ParamDMImmos.Quand := Rebut.Quand;
 ParamDMImmos.ImmoCourante := Rebut.ImmoCourante;

 if not InitialiseDMImmos(ParamDMImmos).retour then abort;
except
  MessageDlg('Problème rencontré lors de l''initialisation du datamodule des '+#13+#10+'immobilisations', mtWarning, [mbOK], 0);
end;
End;

Procedure TRebut.GereAccesEcran;
begin
  case Quand of
     C_Mouvement:Begin
                     //differentes zones de description de l'immo selectionnée
                     Compte.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));
                     Code.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));
                     Sous_code.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));
                     Libelle.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));
                     Date_Acq.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));
                     Date_MeS.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));
                     Val_Acq.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));
                     Duree_Amt.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));
                     Date_Rebut.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));
                     // BtnSupprimer,BtnInserer ces 2 boutons sont toujours enabled=false;
                    EnableWinControl([BtnEnregistrer],not ((not E.AccesCloture)or(DataModuleImmos.verrouillage)));
                    EnableWinControl([BtnImprimer],@BtnImprimer.OnClick<>nil);
                    EnableItemMenu([Enregistrer1],not ((not E.AccesCloture)or(DataModuleImmos.verrouillage)));
                    EnableItemMenu([Imprimer1],BtnImprimer.Enabled);
                 End;
  end;
DataModuleImmos.GestionAccesImmos;
end;


procedure TRebut.FormCreate(Sender: TObject);
begin
// left:= 0; Top:= 0; Width:= csWidth; Height:= csHeight;
    try
	      LibGestionParamXML.InitialiseForm(E.User,Self);
        Width:= csWidth; Height:= csHeight;
    except
        Position:=poScreenCenter;
        //InitialiseFormPosDefaut(self);
    end;
end;

procedure TRebut.FormDestroy(Sender: TObject);
begin
 LibGestionParamXML.DestroyForm(Self,E.User);
 if DataModuleImmos<>nil then  DataModuleImmos.Free;
 Rebut := Nil;
end;


procedure TRebut.Aide1Click(Sender: TObject);
begin
Date_Rebut.DoClick;
end;

procedure TRebut.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
DateRebutTmp:=Date_Rebut.Field.AsDateTime;
Date_Rebut.SelStart := 0;
Date_Rebut.SelLength := Length(Date_Rebut.Text);
CouleurActivecontrolLabel(ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond,Label7,clRed,0);
end;



//function TRebut.CtrlSaisieRebut(EditCourant:Tfield):TErreurSaisie;
//var
//DateDefaut:Tdatetime;
//Begin
//result.CodeErreur:=0;
//result.Retour:=true;
//if DataModuleImmos.taimmosrebut.State in [dsinsert,dsedit]then
//  begin//si en insertion ou modification
//       case EditCourant.Index of
//         22:Begin //si edit dateCession
//            if now>e.DatExoFin then
//              DateDefaut:=e.DatExoFin
//            else
//              DateDefaut:=now;
//             if not DateValide(Date_Rebut.field.Asstring)then
//               Begin
//                 Date_Rebut.field.AsDateTime:=DateDefaut;
//               End
//               else
//               if ((Date_Rebut.field.AsDateTime<e.DatExoDebut)or(Date_Rebut.field.AsDateTime>e.DatExofin)) then
//                 begin
//                   showmessage('La date de cession doit faire partie de l''exercice courant.');
//                   result.CodeErreur:=23001;
//                   result.Retour:=false;
//                 end
//                 else
//                   if EditCourant.AsDateTime<Date_Acq.Field.AsDateTime then
//                     begin
//                       showmessage('La date de cession est antérieure à la date d''acquisition.');
//                       result.CodeErreur:=23002;
//                       result.Retour:=false;
//                     end;
//           end;//fin si edit dateCession
//         41:Begin //si edit ValeurNette(VNC)
//              if editcourant.AsCurrency<>0 then
//                Begin
//                  result.CodeErreur:=22001;
//                  result.Retour:=false;
//                End;
//           end;//fin si edit Montantcession(VNC)
//       end;//fin du case
//  end;
//
//end;

procedure TRebut.Date_RebutExit(Sender: TObject);
var
valide:TErreurSaisie;
begin
valide:=DataModuleImmos.CtrlSaisieRebut(Date_Rebut.Field);
if valide.Retour=false then
  Begin
//    if valide.CodeErreur= then
     abort;
  End
  else
    CouleurDeActivecontrolLabel(lastZoneEdit,ParamUtil.CouleurDBGrid.GrilleColorFond,Label7,clWindowText,0);

end;

procedure TRebut.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
KeyTmp:char;
begin
if ((((key = VK_RETURN)and (date_rebut.PopupVisible )))or(date_rebut.PopupVisible))then
 WinSuivPrec(Handle,key,[date_rebut])
else
 WinSuivPrec(Handle,key,[nil]);
try
       If ((Key = VK_ESCAPE)and(not date_rebut.PopupVisible)) Then
       Begin
         If DataModuleImmos.taimmosrebut.State = dsBrowse Then
            begin
               Self.Close ;
            end;

            if DateRebutTmp<>Date_Rebut.Field.AsDateTime then
              begin//si changement de date de cession
                  If DataModuleImmos.taimmosrebut.State = dsEdit Then
                  Begin
                       If Messagedlg('Annuler les modifications de cette immobilisation ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
                       Begin
                            DataModuleImmos.taimmosrebut.Cancel;
                            Date_Rebut.SetFocus;
                       End
                       Else
                       Begin
                            Abort;
                       End
                  End;
              end//fin si changement de date de cession
            else
              begin
                DataModuleImmos.taimmosrebut.Cancel;
                self.close;
              end;
       End;
except
   raise;
end;
end;

procedure TRebut.BtnEnregistrerClick(Sender: TObject);
begin
try
  tablegerePost(DataModuleImmos.TaImmosRebut);
  Self.close;
except
  //
end;
end;

procedure TRebut.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TRebut.BtnFermerClick(Sender: TObject);
begin
BtnAnnulerClick(self);
Self.Close;
end;

procedure TRebut.BtnModifierClick(Sender: TObject);
begin
DataModuleImmos.taimmosrebut.Edit;
end;

procedure TRebut.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TRebut.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TRebut.FormShow(Sender: TObject);
begin
  Date_Rebut.SetFocus;
end;

procedure TRebut.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
try
canclose:=true;
  If DataModuleImmos.taimmosrebut.State = dsEdit Then
  Begin
    self.WindowState:=wsNormal;
    self.BringToFront;
       If messagedlg('Voulez-vous enregistrer le rebut ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
          begin
           BtnEnregistrerClick(btnEnregistrer);
          end
        else
          begin
           DataModuleImmos.taimmosrebut.Cancel;
          end;
  End; // Fin utilisateur est en mode Modification
except
  canclose:=false;
end;
end;

procedure TRebut.Date_RebutEnter(Sender: TObject);
begin
CouleurActivecontrolLabel(ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond,Label7,clRed,0);
end;



end.
