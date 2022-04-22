{***************************************************************
 *
 * Unit Name: E2_Division
 * Purpose  :
 * Author   :  Blanchard
 * History  :
 *
 ****************************************************************}

unit E2_Division;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {EditAlign,} StdCtrls, Mask, DBCtrls, ComCtrls, Buttons, ExtCtrls, DB,
  E2_Librairie_Obj,
  ToolEdit,
  CurrEdit,
  LibZoneSaisie,
  E2_Decl_Records,
  Menus,
  DMEcriture,
  LibGestionParamXML,
  LibDates,
  lib_chaine,
  DMConstantes;

type
  TParamAffichageDivision=record
   Affiche:Boolean;
   AffichageModal:Boolean;
   Quand:Integer;
   TitreForm:String;
   SousTitreForm:String;
   ImmoCourante:integer;
   QuiAppel:TTypeFenetre;
  end;


  TDivision = class(TForm)
    PaEntete: TPanel;
    PaImmo1: TPanel;
    PaImmo2: TPanel;
    Label19: TLabel;
    Label18: TLabel;
    Compte: TDBRichEdit;
    Code: TDBEdit;
    Sous_code: TDBEdit;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    Val_Acq: TDBEdit;
    Label13: TLabel;
    VNC: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    txtNom1: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    txtNom2: TEdit;
    Label11: TLabel;
    EdCompte1: TEdit;
    EdCompte2: TEdit;
    EdCode1: TEdit;
    EdCode2: TEdit;
    Sous_code1: TEdit;
    Sous_code2: TEdit;
    txtValeur1: TCurrencyEdit;
    txtValeur2: TCurrencyEdit;
    Label12: TLabel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    PaPTitre1: TPanel;
    PaPTitre2: TPanel;
    PaPTitre3: TPanel;
    procedure btAnnulerClick(Sender: TObject);
    procedure btOKClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure txtValeur1Exit(Sender: TObject);
    procedure txtValeur2Exit(Sender: TObject);
    function CtrlSaisieDivision(EditCourant:TCustomEdit):TErreurSaisie;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtNom1Exit(Sender: TObject);
    procedure txtNom2Exit(Sender: TObject);
    procedure txtValeur2Enter(Sender: TObject);
    procedure txtValeur1Enter(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure txtNom1Enter(Sender: TObject);
    procedure txtNom2Enter(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    Procedure GestionInitDM;
    Procedure GereAccesEcran;
    procedure Calculatrice1Click(Sender: TObject);
  private
    
  public
    { Déclarations publiques }
    TitreForm,SousTitreForm:String;
    Quand:Integer;
    ImmoCourante:integer;
  end;

const
csWidth = 467;		//Largeur de base de la feuille
   csHeight = 431;   //Hauteur de base de la feuille


var
  Division: TDivision;

  Function DivisionAffiche(ParamAffichageDivision:TParamAffichageDivision):boolean;

implementation

uses DMImmos, Gr_Librairie_obj, E2_Main, E2_AideCompte,
  LibClassObjetSenders,LibSql;

{$R *.DFM}
Function DivisionAffiche(ParamAffichageDivision:TParamAffichageDivision):boolean;
var
ParamDMImmos:TParamDMImmos;
Begin
try
///etatinitial(mise à zéro)
Initialise_ParamDMimmos(ParamDMImmos);
////fin etatInitial

 if (Division = nil) then Division:=TDivision.Create(Application.MainForm);
 if ((ParamAffichageDivision.Quand <> Division.Quand) and (Division.Visible=true)) then
   Division.Close;
 Division.Quand:=ParamAffichageDivision.Quand;
 ////
// Rebut.Tag:=ParamAffichageRebut.TypePresentation;
// {C_ACQUISITION_Terminee,C_ACQUISITION_En_Cours,C_ACQUISITION_Simple}
// {C_DESCRIPTION_terminee,C_DESCRIPTION_Simple,C_DESCRIPTION_En_Cours}
 ///
 if not empty(ParamAffichageDivision.TitreForm) then
   Division.TitreForm:=ParamAffichageDivision.TitreForm;
 Division.SousTitreForm:=ParamAffichageDivision.SousTitreForm;
 Division.ImmoCourante:=ParamAffichageDivision.ImmoCourante;
 ParamDMImmos.ImmoCourante:=ParamAffichageDivision.ImmoCourante;
 ParamDMImmos.ImmosDataStateChange := nil;
 ParamDMImmos.ImmosAfterScroll:=nil;
 ParamDMImmos.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
// ParamDMImmos.TypePresentation:=ParamAffichageRebut.TypePresentation;
 ParamDMImmos.Quand := Division.Quand;
 ParamDMImmos.QuiAppel:=ParamAffichageDivision.QuiAppel;
   case Division.Quand of
      C_mouvement:Begin
                   if not InitialiseDMImmos(ParamDMImmos).retour then abort;
                  End;
   end;

 if ParamAffichageDivision.Affiche then
  begin
     //differentes zones de description de l'immo selectionnée
     Division.Compte.DataSource := DataModuleImmos.daDivision;
     Division.Code.DataSource := DataModuleImmos.daDivision;
     Division.Sous_code.DataSource := DataModuleImmos.daDivision;
     Division.DBEdit1.DataSource := DataModuleImmos.daDivision;
     Division.Val_Acq.DataSource := DataModuleImmos.daDivision;
     Division.VNC.DataSource := DataModuleImmos.daDivision;
     
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(Application.MainForm);

     if ParamAffichageDivision.AffichageModal then
       Division.ShowModal
      else
       Division.Show;
  End;
except
  result:=false;
end;
End;

Procedure TDivision.GestionInitDM;
var
ParamDMImmos:TParamDMImmos;
Begin
try
///etatinitial(mise à zéro)
Initialise_ParamDMimmos(ParamDMImmos);
////fin etatInitial

 ParamDMImmos.QuiAppel:=F_Division;
// ParamDMImmos.TypePresentation:=Tag;

 ParamDMImmos.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ParamDMImmos.ImmosDataStateChange := nil;
 ParamDMImmos.ImmosAfterScroll:=nil;
 ParamDMImmos.CptImmosAfterOpen:=nil;
 ParamDMImmos.CptImmosAfterScroll:=nil;
 ParamDMImmos.Quand := Division.Quand;
 ParamDMImmos.ImmoCourante := Division.ImmoCourante;

 if not InitialiseDMImmos(ParamDMImmos).retour then abort;
except
  MessageDlg('Problème rencontré lors de l''initialisation du datamodule des '+#13+#10+'immobilisations', mtWarning, [mbOK], 0);
end;
End;

Procedure TDivision.GereAccesEcran;
begin
  case Quand of
     C_Mouvement:Begin
                     //differentes zones de description de l'immo selectionnée
                     Compte.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));
                     Code.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));
                     Sous_code.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));
                     DBEdit1.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));
                     Val_Acq.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));
                     VNC.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));

                    EnableWinControl([BtnEnregistrer],not ((not E.AccesCloture)or(DataModuleImmos.verrouillage)));
                    EnableItemMenu([Enregister1],not ((not E.AccesCloture)or(DataModuleImmos.verrouillage)));
                    EnableItemMenu([Imprimer1],not ((not E.AccesCloture)or(DataModuleImmos.verrouillage)));
                 End;
  end;
DataModuleImmos.GestionAccesImmos;
end;



procedure TDivision.btAnnulerClick(Sender: TObject);
begin
 Close;
end;

procedure TDivision.btOKClick(Sender: TObject);
var
valAcq1, valAcq2, valacInit, valnet, valamo, eco, derog : Currency;
Newvalamo, Neweco, Newderog : Currency;
cpt, cde, scde : string;
i:integer;
EditCourant:TCustomEdit;
valide:TErreurSaisie;
choixTmp:Tchoix;
begin
//Vérifier que les infos soient cohérentes
valide.retour:=true;
valide.CodeErreur:=0;
initialiserChoix(choixTmp);
try
  try
   if ActiveControl<>BtnAnnuler then
     begin //si activeControl<>btannuler
//Vérif pour 2ième Immo
       For i:=0 to PaImmo1.controlcount -1  do
       begin //début boucle for
         if ((PaImmo1.Controls[i] is TCustomEdit)and((PaImmo1.Controls[i] as TCustomEdit).enabled)) then
           begin //si control est un customedit enabled
            EditCourant:=(PaImmo1.Controls[i] as TCustomEdit);
            if (EditCourant is TEdit)then
              valide:=CtrlSaisieDivision((EditCourant as TEdit));
            if (EditCourant is TcurrencyEdit)then
              valide:=CtrlSaisieDivision((EditCourant as TcurrencyEdit));
            if not valide.retour then
              begin
              EditCourant.SetFocus;
              abort;
              end;
           end;//fin si control est un customedit enabled
       end;//fin boucle for
//Vérif pour 2ième Immo
valide.retour:=true;
valide.CodeErreur:=0;
       For i:=0 to PaImmo2.controlcount -1  do
       begin //début boucle for
         if ((PaImmo2.Controls[i] is TCustomEdit)and((PaImmo2.Controls[i] as TCustomEdit).enabled)) then
           begin //si control est un customedit enabled
            EditCourant:=(PaImmo2.Controls[i] as TCustomEdit);
            if (EditCourant is TEdit)then
              valide:=CtrlSaisieDivision((EditCourant as TEdit));
            if (EditCourant is TcurrencyEdit)then
              valide:=CtrlSaisieDivision((EditCourant as TcurrencyEdit));
            if not valide.retour then
              begin
              EditCourant.SetFocus;
              abort;
              end;
           end;//fin si control est un customedit enabled
       end;//fin boucle for
     end;//fin si activecontrol<>btnAnnuler
  except
   abort;
  end;//fin du try except
// Enregistrer
   try
      TableGereStartTransaction(DataModuleImmos.TaDivision);
      with DMImmos.DataModuleImmos.taDivision do
      begin
      open;
         valAcq1 := StrToFloat1(txtValeur1.Text);
         valAcq2 := StrToFloat1(txtValeur2.Text);
         valacInit :=  StrToFloat1(Val_Acq.Text);
         valnet :=  StrToFloat1(VNC.Text);
         valamo := FindField('valeur_a_amortir').AsCurrency;
         eco := FindField('Amort_eco').AsCurrency;
         derog := FindField('Amort_Derog').AsCurrency;
         cpt := FindField('Compte').AsString;
         cde := FindField('Code').AsString;
         scde := FindField('Sous_code').AsString;
         //Edit;

         Newvalamo:=arrondi(valamo * valAcq1 / valacInit,2);
         Neweco:=arrondi(eco * valAcq1 / valacInit,2);
         Newderog:=arrondi(derog * valAcq1 / valacInit,2);

         DataModuleImmos.Choix_Division:=DataModuleImmos.RemplirChoixAvantModif(DataModuleImmos.TaDetailImmo,ImmosEnCours);
         choixTmp:=DataModuleImmos.Choix_Division;
         if DataModuleImmos.Choix_Division.ChoixItem=2 then
            DataModuleImmos.Choix_Division.choixDefaut:=DataModuleImmos.Choix_Division.choixDefaut*( valAcq1 / valacInit);
         //travail sur TaDetailImmo pour mettre à jour l'immo de départ
         DataModuleImmos.UpdateImmosSurValeurs(DataModuleImmos.TaDetailImmo,['Libelle','Valeur_Org',
         'Amort_Eco','Amort_Derog','valeur_a_amortir'],[txtNom1.Text,valAcq1,
         Neweco,Newderog,Newvalamo],dsedit,FindField('ID').Asinteger);
         DataModuleImmos.TaDetailImmo.Refresh;
         //Post;

         // insère un nouvel enreg dans TaDivision pour créer la nouvelle immo
         DataModuleImmos.TaDivision.Append;
         DataModuleImmos.Choix_Division:=DataModuleImmos.RemplirChoixAvantModif(DataModuleImmos.TaDetailImmo,ImmosEnCours);
         if DataModuleImmos.Choix_Division.ChoixItem=2 then
            DataModuleImmos.Choix_Division.choixDefaut:=choixTmp.choixDefaut-(choixTmp.choixDefaut*( valAcq1 / valacInit));
         with DataModuleImmos do begin
            FiltrageQuRecImmos_ParamDivers('select * from Immos.DB where Compte="' + cpt + '" and Code="' + Cde + '" and Sous_code="' + scde + '"');
            if empty(sous_code2.Text) then
              sous_code2.Text:=Trouve_sous_code(Cpt,Cde);
         if DataModuleImmos.QuRecImmos_ParamDivers.FindField('Date_Org').AsDateTime<>0 then
           DataModuleImmos.TaDivision.findfield('Date_Org').asdatetime:=DataModuleImmos.QuRecImmos_ParamDivers.FindField('Date_Org').AsDateTime;
            UpdateImmosSurValeurs(DataModuleImmos.TaDivision,['Ecriture_Achat','Compte','Code','Sous_Code','Libelle',
            'Valeur_Org','Valeur_a_Amortir','Duree_Amt','Type_Amt','Amort_Eco',
            'Amort_Derog','Mt_Cession','Rebut','Achat_dans_Annee','Cession_dans_Annee','Date_Mise_en_Service',
            'Date_Achat'],[QuRecImmos_ParamDivers.FindField('Ecriture_Achat').AsInteger,cpt,cde,Sous_Code2.text,txtNom2.text,
            valAcq2,valamo - Newvalamo,
            QuRecImmos_ParamDivers.FindField('Duree_Amt').AsInteger,QuRecImmos_ParamDivers.FindField('Type_Amt').AsString,
            eco - Neweco,derog - Newderog,0,
            QuRecImmos_ParamDivers.FindField('Rebut').AsBoolean,DMImmos.DataModuleImmos.QuRecImmos_ParamDivers.FindField('Achat_dans_Annee').AsBoolean,
            DataModuleImmos.QuRecImmos_ParamDivers.FindField('Cession_dans_Annee').AsBoolean,QuRecImmos_ParamDivers.FindField('Date_Mise_en_Service').AsDateTime,
            DataModuleImmos.QuRecImmos_ParamDivers.FindField('Date_Achat').AsDateTime],dsinsert,-1);
         end;	//with DMImmos.DataModuleImmos
             //	Post;  QuRecImmos_ParamDivers.FindField('Date_Org').AsDateTime 
      end;
   except
     TableGereRollBack(DataModuleImmos.TaDivision);
     abort;
   end;//fin du try except

   Close;
except
  abort;
end;//fin du 1er try except
end;

procedure TDivision.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
GestionInitDM;
Initialise_TinfosDivision(DataModuleImmos.Infosdivision);
CouleurFond([txtNom1,txtValeur1,txtNom2,txtValeur2],ParamUtil.CouleurDBGrid.GrilleColorFond);
CouleurActivecontrolLabel(ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond,nil,0,0);

   edCode1.text:=code.Text;
   edCompte1.text:=compte.Text;
   edCode2.text:=code.Text;
   edCompte2.text:=compte.Text;
   Sous_code1.Text := Sous_code.Text;
   Sous_code2.Text := DataModuleImmos.Trouve_sous_code(Compte.Text,Code.Text);
   txtNom1.Text := DBEdit1.Field.AsString;
   txtNom2.Text := DBEdit1.Field.AsString;
   txtValeur1.Text := '';
   txtValeur2.Text := '';
   txtValeur1.SetFocus;

GereAccesEcran;
end;

procedure TDivision.FormCreate(Sender: TObject);
begin
    try
//               if DataModuleImmos=nil then
//        DataModuleImmos:=TDataModuleImmos.Create(self);

	LibGestionParamXML.InitialiseForm(E.User,Self);
	//Left:= 0; Top:= 0; Width:= csWidth; Height:= csHeight;
        //Height:=476;
        txtValeur1.DisplayFormat:=E.FormatMonnaie;
        txtValeur2.DisplayFormat:=E.FormatMonnaie;
    except
        Position:=poScreenCenter;
        //InitialiseFormPosDefaut(self);
    end;
//   DMImmos.DataModuleImmos.taDetailImmo.Open;
end;

procedure TDivision.FormDestroy(Sender: TObject);
begin
//   DMImmos.DataModuleImmos.taDetailImmo.close;
   LibGestionParamXML.DestroyForm(Self,E.USer);
   if DataModuleImmos<>nil then  DataModuleImmos.Free;
   Division := Nil;
end;



procedure TDivision.txtValeur1Exit(Sender: TObject);
var
valide:TErreurSaisie;
begin
if ActiveControl <> BtnAnnuler then
 begin
   valide:=CtrlSaisieDivision(txtValeur1);
    if not valide.Retour then
      begin
        txtValeur1.SetFocus;
        abort;
      end
      else
     CouleurDeActivecontrolLabel(lastZoneEdit,ParamUtil.CouleurDBGrid.GrilleColorFond,Label9,clWindowText,0);
 end;
end;

procedure TDivision.txtValeur2Exit(Sender: TObject);
var
valide:TErreurSaisie;
begin
if ActiveControl <> BtnAnnuler then
 begin
   valide:=CtrlSaisieDivision(txtValeur2);
    if not valide.Retour then
      begin
        txtValeur2.SetFocus;
        abort;
      end
      else
     CouleurDeActivecontrolLabel(lastZoneEdit,ParamUtil.CouleurDBGrid.GrilleColorFond,Label11,clWindowText,0);
 end;
end;


function TDivision.CtrlSaisieDivision(EditCourant:TCustomEdit):TErreurSaisie;
begin
result.CodeErreur:=0;
result.retour:=true;
  case EditCourant.Tag of
  1:Begin //si EditLibelle1
      if empty(editcourant.text)then
        Begin
          editcourant.text:=dbedit1.Field.AsString;
        End;
      if empty(editcourant.text)then
        Begin
          showmessage('Vous devez saisir un Libellé.');
          result.CodeErreur:=1000;
          result.retour:=false;
        End;
    end;//fin si EditLibelle1
  2:Begin //si Edit valeur1
      if VerifNumeric(editcourant.text).VideOUZero then
        Begin
          showmessage('Vous devez saisir une valeur.');
          result.CodeErreur:=2000;
          result.retour:=false;
        End
      else
        Begin
        if VerifNumeric(txtValeur2.text).VideOUZero then
          begin//si la valeur 2 est vide
          if StrToCurr_lgr(editcourant.text) > Val_Acq.Field.AsCurrency then
            Begin
            showmessage('La valeur doit obligatoirement être inférieure à la valeur d''acquisition !');
            result.CodeErreur:=2001;
            result.retour:=false;
            End;
          end//fin si la valeur 2 est vide
        else
          Begin//si la valeur 2 est remplie
             if StrToCurr_lgr(editcourant.text)+StrToCurr_lgr(txtValeur2.text) <> Val_Acq.Field.AsCurrency then
                begin
                showmessage('Le Total des 2 valeurs doit obligatoirement être égal à la valeur d''acquisition !');
                result.CodeErreur:=2002;
                result.retour:=false;
                End;
          End;//fin si la valeur 2 est remplie
        End;
    end;//fin si Edit valeur1
  3:Begin //si EditLibelle2
      if empty(editcourant.text)then
        Begin
          editcourant.text:=dbedit1.Field.AsString;
        End;  
      if empty(editcourant.text)then
        Begin
          showmessage('Vous devez saisir un Libellé.');
          result.CodeErreur:=3000;
          result.retour:=false;
        End;
    end;//fin si EditLibelle2
  4:Begin //si Edit valeur2
      if VerifNumeric(editcourant.text).VideOUZero then
        Begin //si valeur 2 vide
          showmessage('Vous devez saisir une valeur.');
          result.CodeErreur:=4000;
          result.retour:=false;
        End//fin si valeur 2 vide
      else
        Begin//si valeur 2 remplie
        if VerifNumeric(txtValeur1.text).VideOUZero then
          begin//si la valeur 1 est vide
          if StrToCurr_lgr(editcourant.text) > Val_Acq.Field.AsCurrency then
            Begin
            showmessage('La valeur doit obligatoirement être inférieure à la valeur d''acquisition !');
            result.CodeErreur:=4001;
            result.retour:=false;
            End;
          end//fin si la valeur 1 est vide
        else
          Begin//si la valeur 1 est remplie, vérifier total des 2 valeurs
             if StrToCurr_lgr(editcourant.text)+StrToCurr_lgr(txtValeur1.text) <>  Val_Acq.Field.AsCurrency then
                begin
                showmessage('Le Total des 2 valeurs doit obligatoirement être égal à la valeur d''acquisition !');
                result.CodeErreur:=4002;
                result.retour:=false;
                End;
          End;//fin si la valeur 1 est remplie
        End;//fin si valeur 2 remplie
    end;//fin si Edit valeur2
  end;//fin du case tag
end;


procedure TDivision.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Shift=[] then WinSuivPrec(Handle,key,[nil]);
end;

procedure TDivision.txtNom1Exit(Sender: TObject);
var
valide:TErreurSaisie;
begin
if ActiveControl <> BtnAnnuler then
 begin
  valide:=CtrlSaisieDivision(txtNom1);
   if not valide.Retour then
     begin
       txtNom1.SetFocus;
       abort;
     end else
     CouleurDeActivecontrolLabel(lastZoneEdit,ParamUtil.CouleurDBGrid.GrilleColorFond,Label8,clWindowText,0);
  end;
end;

procedure TDivision.txtNom2Exit(Sender: TObject);
var
valide:TErreurSaisie;
begin
if ActiveControl <> BtnAnnuler then
 begin
  valide:=CtrlSaisieDivision(txtNom2);
   if not valide.Retour then
     begin
       txtNom2.SetFocus;
       abort;
     end
     else
      CouleurDeActivecontrolLabel(lastZoneEdit,ParamUtil.CouleurDBGrid.GrilleColorFond,Label10,clWindowText,0);
 end; 
end;

procedure TDivision.txtValeur2Enter(Sender: TObject);
begin
CouleurActivecontrolLabel(ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond,Label11,clRed,0);
if not VerifNumeric(txtValeur1.text).VideOUZero then
  txtValeur2.Text:=currtostr(Val_Acq.Field.AsCurrency-StrToCurr_lgr(txtValeur1.text));
end;

procedure TDivision.txtValeur1Enter(Sender: TObject);
begin
CouleurActivecontrolLabel(ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond,Label9,clRed,0);
if not VerifNumeric(txtValeur2.text).VideOUZero then
  txtValeur1.Text:=currtostr(Val_Acq.Field.AsCurrency-StrToCurr_lgr(txtValeur2.text));
end;

procedure TDivision.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TDivision.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TDivision.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer],PaBtn,90,0);
end;

procedure TDivision.txtNom1Enter(Sender: TObject);
begin
CouleurActivecontrolLabel(ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond,Label8,clRed,0);
end;

procedure TDivision.txtNom2Enter(Sender: TObject);
begin
CouleurActivecontrolLabel(ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond,Label10,clRed,0);
end;

procedure TDivision.Visualisation1Click(Sender: TObject);
begin
 if not empty(EdCompte1.Text) then
   DetailEcritureCompte(EdCompte1.Text,true,False)
end;

procedure TDivision.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
canClose:=true;
end;

procedure TDivision.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(ActiveControl);
end;

end.
