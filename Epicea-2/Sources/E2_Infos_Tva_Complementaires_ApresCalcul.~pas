unit E2_Infos_Tva_Complementaires_ApresCalcul;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RXCtrls, ExtCtrls, Mask, ToolEdit, CurrEdit,
  E2_Decl_Records,
  DMConstantes,
  Gr_Librairie_Obj,
  LibZoneSaisie,
  LibRessourceString,
  E2_Librairie_Obj,
  Menus,
  lib_chaine,
  LibGestionParamXML,
  jpeg;

type
  TInfos_Tva_Complementaires_ApresCalcul = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    PopupMenu1: TPopupMenu;
    Enregistrer1: TMenuItem;
    Panel4: TPanel;
    Panel1: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    SoldeADecl: TCurrencyEdit;
    Arrondis: TCurrencyEdit;
    SoldeTva: TCurrencyEdit;
    Panel3: TPanel;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    PaSoldeFin2: TPanel;
    SoldeReport: TCurrencyEdit;
    SoldeRembourse: TCurrencyEdit;

    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    function CtrlSaisieComplement(EditCourant:TCustomEdit;CtrlSuivant:twincontrol):TErreurSaisie;
    procedure SoldeADeclExit(Sender: TObject);
    procedure SoldeReportExit(Sender: TObject);
    procedure SoldeRembourseExit(Sender: TObject);
    procedure SoldeADeclChange(Sender: TObject);
    Procedure InitLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SoldeADeclEnter(Sender: TObject);
    procedure Enregistrer1Click(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure SoldeADeclKeyPress(Sender: TObject; var Key: Char);
    procedure SoldeRembourseKeyPress(Sender: TObject; var Key: Char);
    procedure SoldeReportKeyPress(Sender: TObject; var Key: Char);
    procedure BtnEnregistrerClick(Sender: TObject);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
        Panel:TPanel;
        InfosAvantValidation:PSolde_A_Declarer;
  end;

var
  Infos_Tva_Complementaires_ApresCalcul: TInfos_Tva_Complementaires_ApresCalcul;
//  Function Aff(var Parametre:TSolde_A_Traiter;ForceAffichage:boolean):PSolde_A_Declarer;
Function AffichInfoComplementairesTVA_AvantValidation(var Parametre:TSolde_A_Traiter;ForceAffichage:TForceAffichage):PSolde_A_Declarer;implementation

uses E2_Main, DMTTVA;

{$R *.DFM}
//
Function AffichInfoComplementairesTVA_AvantValidation(var Parametre:TSolde_A_Traiter;ForceAffichage:TForceAffichage):PSolde_A_Declarer;
var
i,j,NbPanelVisible:integer;
visible:boolean;
CurrencyTemp,Solde_ADecl:currency;
event:TNotifyEvent;
name,nameSolde:string;
Solde_Report,Solde_Remb,Solde_TVA,Solde_APayer:currency;
CalculDeclNonChange:Boolean;
Begin
try
if Infos_Tva_Complementaires_ApresCalcul=nil then Infos_Tva_Complementaires_ApresCalcul:=TInfos_Tva_Complementaires_ApresCalcul.Create(application.MainForm);
NbPanelVisible:=0;
//initialise_TInfos_Piece(Solde_Report);
//initialise_TInfos_Piece(Solde_Remb);
//initialise_TInfos_Piece(Solde_TVA);
//initialise_TInfos_Piece(Solde_APayer);
Solde_Report:=0;
Solde_Remb:=0;
Solde_TVA:=0;
Solde_APayer:=0;
Solde_ADecl:=0;

visible:=false;
Infos_Tva_Complementaires_ApresCalcul.Height:=370;
Infos_Tva_Complementaires_ApresCalcul.BorderStyle:=bsSizeable;
i:=1;
name:='';
nameSolde:='';
new(result);
///
   Infos_Tva_Complementaires_ApresCalcul.caption:='Informations complémentaires sur TVA pour valider la déclaration / choix par défaut';
   //initialiser result
   Result.Declaration:=0;
   Result.CompteArrondis:='';

   initialise_TInfos_Piece(result.APayer);
   initialise_TInfos_Piece(result.Remboursement);
   initialise_TInfos_Piece(result.Report);
   initialise_TInfos_Piece(result.calcul);
   initialise_TInfos_Piece(result.DeduiteAReverser);
   initialise_TInfos_Piece(result.AcompteVerse);

   result.Calcul.Retour:=true;
   result.Calcul.Compte:=Parametre.Compte;
   result.Calcul.Total.Solde:=Parametre.Total.SoldeFin;
   result.Declaration:=Parametre.Total.SoldeFin;

   if not Parametre.Total.SoldeDebitCreditFin  then
     begin//si montant total au crédit, je dois de la TVA
//      if ((Parametre.Total.SoldeDebitCreditReport)and(Parametre.Total.soldeReport<>0)) then
//        Begin //si report au débit
//           visible:=true;
//           result.Calcul.SensSolde:=-1;//Résultat au débit
//        End //fin si report au débit
//      else
        Begin //si report au Crédit
           result.Calcul.SensSolde:=1;//résultat au crédit
           Result.APayer:=result.Calcul;
        End;//fin si report au Crédit
     End//fin si montant total au Crédit, je dois de la TVA
    else
      begin//si montant total au débit, on me dois de la TVA
           visible:=true;
           result.Calcul.SensSolde:=-1;//Résultat au débit
      end;//fin si montant total au débit, on me dois de la TVA

      Result.APayer.Compte:=DM_C_CompteTVAAPayer;//  '44551';
      Result.Report.Compte:=DM_C_CompteTVAPourReport;//'44567';
      Result.Remboursement.Compte:=DM_C_CompteTVAPourRemboursement;//'44583';
   ///
     result.Remboursement.Retour:=not Result.APayer.Retour;
     result.Report.Retour:=not Result.APayer.Retour;

   if result.APayer.Retour then
     Begin
       Solde_Report:=0;
       Solde_Remb:=0;
     End
   else
     Begin
       Solde_Report:=0;
       Solde_Remb:=result.Declaration;
     End;
  Solde_TVA:=result.Calcul.Total.Solde;
  Solde_ADecl:=result.Declaration;

  result.Report.Total.Solde:=Solde_Report;
  result.Report.SensSolde:=result.Calcul.SensSolde;

  result.Remboursement.Total.Solde:=Solde_Remb;
  result.Remboursement.SensSolde:=result.Calcul.SensSolde;
  
///
CalculDeclNonChange:=DMTmTVA.Compare_Ta_H_Tva_Fin(result,C_Id_Decl_Tmp).retour;

if ((not ForceAffichage.Force)and(ForceAffichage.Affiche)) then
begin
 ForceAffichage.Affiche:=(not CalculDeclNonChange);
end;

if CalculDeclNonChange then
  Begin
    if DMTmTVA.Recup_Ta_H_Tva_Fin(result,C_Id_Decl_Tmp).retour  then
     begin
       Infos_Tva_Complementaires_ApresCalcul.caption:='Informations complémentaires sur TVA pour valider la déclaration / choix utilisateur';
       Solde_Report:=result.Report.Total.Solde;
       Solde_Remb:=result.Remboursement.Total.Solde;
       Solde_TVA:=result.Declaration;
       Solde_APayer:=result.APayer.Total.Solde;
       if result.APayer.retour then
         Solde_ADecl:=Solde_APayer
       else
         Solde_ADecl:=Solde_Report+Solde_Remb;
       //Solde_TVA:=
       result.Declaration:=Solde_ADecl;
       
          if not result.APayer.retour then
            Begin //si report au débit
               visible:=true;
               //result.Calcul.SensSolde:=-1;//Résultat au débit
            End; //fin si report au débit
    //      else
    //        Begin //si report au Crédit
    //           //result.Calcul.SensSolde:=1;//résultat au crédit
    //           Result.APayer:=result.Calcul;
    //        End;//fin si report au Crédit
    //     End//fin si montant total au Crédit, je dois de la TVA
    //    else
    //      begin//si montant total au débit, on me dois de la TVA
    //           visible:=true;
    //           result.Calcul.SensSolde:=-1;//Résultat au débit
    //      end;//fin si montant total au débit, on me dois de la TVA

          Result.APayer.Compte:=DM_C_CompteTVAAPayer;//  '44551';
     end;
  End;
if Solde_ADecl=0 then abort;
while i<=2 do
begin
  Infos_Tva_Complementaires_ApresCalcul.Panel:=(Infos_Tva_Complementaires_ApresCalcul.FindComponent('Panel'+inttostr(i)) as tpanel);
    if Infos_Tva_Complementaires_ApresCalcul.panel<>nil then
      begin//si panel <> nil
        Infos_Tva_Complementaires_ApresCalcul.panel.Align:=alNone;
        Infos_Tva_Complementaires_ApresCalcul.Panel.Visible:=((visible) or (i=1));
        if not Infos_Tva_Complementaires_ApresCalcul.Panel.Visible then Infos_Tva_Complementaires_ApresCalcul.Height:=Infos_Tva_Complementaires_ApresCalcul.Height-Infos_Tva_Complementaires_ApresCalcul.Panel.Height;

//        if Infos_Tva_Complementaires_ApresCalcul.panel.Visible then
//         begin//si panel visible
         if Infos_Tva_Complementaires_ApresCalcul.panel.Visible then inc(NbPanelVisible);
         for j:=0 to Infos_Tva_Complementaires_ApresCalcul.Panel.ControlCount-1 do
           Begin//boucle for j
             if (Infos_Tva_Complementaires_ApresCalcul.panel.Controls[j]is TcurrencyEdit) then
               Begin//si TcurrencyEdit
                  if (Infos_Tva_Complementaires_ApresCalcul.panel.Controls[j]as TcurrencyEdit).Name='SoldeTva' then
//                  (Infos_Tva_Complementaires_ApresCalcul.panel.Controls[j]as TcurrencyEdit).Value:=abs(Parametre.Total.SoldeFin);
                  (Infos_Tva_Complementaires_ApresCalcul.panel.Controls[j]as TcurrencyEdit).Value:=abs(Solde_TVA);
                    if (Infos_Tva_Complementaires_ApresCalcul.panel.Controls[j]as TcurrencyEdit).Name='SoldeADecl' then
                    begin
                      try
                        event:=(Infos_Tva_Complementaires_ApresCalcul.panel.Controls[j]as TcurrencyEdit).OnChange;
                        (Infos_Tva_Complementaires_ApresCalcul.panel.Controls[j]as TcurrencyEdit).OnChange:=nil;
                        //(Infos_Tva_Complementaires_ApresCalcul.panel.Controls[j]as TcurrencyEdit).value:=abs(Parametre.Total.SoldeFin);
                      (Infos_Tva_Complementaires_ApresCalcul.panel.Controls[j]as TcurrencyEdit).value:=abs(Solde_ADecl);
                      finally
                        (Infos_Tva_Complementaires_ApresCalcul.panel.Controls[j]as TcurrencyEdit).OnChange:=event;
                      end;//fin du try finally
                    end;
                  if (Infos_Tva_Complementaires_ApresCalcul.panel.Controls[j]as TcurrencyEdit).Name='SoldeReport' then
                    begin
                        (Infos_Tva_Complementaires_ApresCalcul.panel.Controls[j]as TcurrencyEdit).Value:=abs(Solde_Report);
//                      (Infos_Tva_Complementaires_ApresCalcul.panel.Controls[j]as TcurrencyEdit).Value:=abs(Parametre.Total.SoldeFin);
                    end;
                  if (Infos_Tva_Complementaires_ApresCalcul.panel.Controls[j]as TcurrencyEdit).Name='SoldeRembourse' then
                    begin
//                     (Infos_Tva_Complementaires_ApresCalcul.panel.Controls[j]as TcurrencyEdit).Value:=abs(Parametre.Total.SoldeFin);
                     if result.Remboursement.Retour then
                       (Infos_Tva_Complementaires_ApresCalcul.panel.Controls[j]as TcurrencyEdit).Value:=abs(Solde_Remb)
                     else
                       (Infos_Tva_Complementaires_ApresCalcul.panel.Controls[j]as TcurrencyEdit).Value:=0;
                    end;
               End;//fin si TcurrencyEdit
             if (Infos_Tva_Complementaires_ApresCalcul.panel.Controls[j]is TLabel) then
               Begin//si TLabel
                  if (Infos_Tva_Complementaires_ApresCalcul.panel.Controls[j]as TLabel).Name='Label1'then
                  if visible then
                    (Infos_Tva_Complementaires_ApresCalcul.panel.Controls[j]as TLabel).caption:='Le calcul fait apparaître un Crédit de TVA à déclarer de : '
                  else
                    (Infos_Tva_Complementaires_ApresCalcul.panel.Controls[j]as TLabel).caption:='Le calcul fait apparaître un montant de TVA due à déclarer de : '
               End;//fin si TLabel
           End;//fin boucle for j
//         end;//fin si panel visible
      end;//fin si panel <> nil
  inc(i);
end;//fin du while
Infos_Tva_Complementaires_ApresCalcul.BorderStyle:=bsSingle;
j:=NbPanelVisible;
for i:=NbPanelVisible  downto 1 do
  Begin
    Infos_Tva_Complementaires_ApresCalcul.Panel:=(Infos_Tva_Complementaires_ApresCalcul.FindComponent('Panel'+inttostr(i)) as tpanel);
    if Infos_Tva_Complementaires_ApresCalcul.Panel.Visible then
    case NbPanelVisible of
    1:Begin
       Infos_Tva_Complementaires_ApresCalcul.Panel.Align:=alclient;
      End;
    2:Begin
        if j=2 then Infos_Tva_Complementaires_ApresCalcul.Panel.Align:=alBottom
          else Infos_Tva_Complementaires_ApresCalcul.Panel.Align:=alClient;
        dec(j);
      End;
    end;//fin du case NbPanelVisible
  End;

  Infos_Tva_Complementaires_ApresCalcul.InfosAvantValidation:=result;
  with Infos_Tva_Complementaires_ApresCalcul do
    begin
        if abs(InfosAvantValidation.Calcul.total.solde)-abs(InfosAvantValidation.Declaration)<0 then
          Begin
            if InfosAvantValidation.Calcul.SensSolde=1 then
              InfosAvantValidation.CompteArrondis:='658'
            else
              if InfosAvantValidation.Calcul.SensSolde=-1 then
                InfosAvantValidation.CompteArrondis:='758';
          End
        else
          Begin
            if InfosAvantValidation.Calcul.SensSolde=1 then
              InfosAvantValidation.CompteArrondis:='758'
            else
              if InfosAvantValidation.Calcul.SensSolde=-1 then
                InfosAvantValidation.CompteArrondis:='658';
          End;
    end;

  if ((ForceAffichage.Affiche)or(ForceAffichage.Force)) then
   begin
     if not (Infos_Tva_Complementaires_ApresCalcul.Showmodal=mrok) then
       Begin
         abort;
       End
     else
       Begin
         DMTmTVA.Vide_Ta_H_Tva_Fin(C_Id_Decl_Tmp);
         DMTmTVA.Affect_Ta_H_Tva_Fin(result,C_Id_Decl_Tmp);
       End;
   end;
except
 result:=nil;
 abort;
end;//fin du try except
end;

Procedure TInfos_Tva_Complementaires_ApresCalcul.InitLabel;
Begin
Label2.Caption := 'La différence sera enregistrée sur le compte de Report de TVA '+DM_C_CompteTVAPourReport+' :';
Label3.Caption := 'Indiquez ici le remboursement de TVA demandé'+
                   RetourChariotSimple+
                   'Ce montant sera enregistré sur le compte de Remboursement de TVA '+DM_C_CompteTVAPourRemboursement+' :';
Label5.Caption := 'La différence sera enregistrée dans un compte de gestion ('+DM_C_CompteArrondiDebit+' ou '+DM_C_CompteArrondiCredit+'), soit :';
End;

procedure TInfos_Tva_Complementaires_ApresCalcul.BtnAnnulerExit(
  Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TInfos_Tva_Complementaires_ApresCalcul.BtnAnnulerEnter(
  Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TInfos_Tva_Complementaires_ApresCalcul.FormDestroy(
  Sender: TObject);
begin
 if panel<>nil then panel:=nil;
LibGestionParamXML.DestroyForm(self,E.User);
 Infos_Tva_Complementaires_ApresCalcul := Nil;
end;

procedure TInfos_Tva_Complementaires_ApresCalcul.FormActivate(
  Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
Arrondis.Value:=SoldeTva.Value-SoldeADecl.Value;
SoldeADecl.SetFocus;
SoldeADeclChange(SoldeADecl);
end;

procedure TInfos_Tva_Complementaires_ApresCalcul.FormKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 WinSuivPrec(Handle,key,[nil]);

 If (Key = VK_ESCAPE) then
   Begin
     BtnAnnuler.Click;
   End;
end;

function TInfos_Tva_Complementaires_ApresCalcul.CtrlSaisieComplement(EditCourant:TCustomEdit;CtrlSuivant:twincontrol):TErreurSaisie;
begin
try
result.CodeErreur:=0;
result.retour:=true;
case EditCourant.Tag of
1:Begin //si SoldeADecl
  if EditCourant.text<>currtostr(abs(InfosAvantValidation.Declaration)) then
    Begin//si valeur à changé
      if not VerifNumeric(EditCourant.text).VideOUZero then
        Begin// si champ Solde à décl rempli
          if StrToCurr_Lgr(EditCourant.text)+0.99<abs(InfosAvantValidation.Calcul.Total.Solde) then
            Begin
              if MessageDlg('Le montant à déclarer est inférieur au montant calculé par le programme, Voulez-vous continuer ?',mtWarning,[mbYes,mbNo],0)=mrno then
                Begin
                  result.CodeErreur:=1001;
                  result.retour:=false;
                End;
            End
          else
          if StrToCurr_Lgr(EditCourant.text)-0.99>abs(InfosAvantValidation.Calcul.Total.Solde) then
            Begin
              if MessageDlg('Le montant à déclarer est supérieur au montant calculé par le programme, Voulez-vous continuer ?',mtWarning,[mbYes,mbNo],0)=mrno then
                Begin
                  result.CodeErreur:=1002;
                  result.retour:=false;
                End;
            End
        End//fin si champ Solde à décl rempli
      else
        Begin// si champ Solde à décl vide
          editcourant.text:='0';
           if InfosAvantValidation.Calcul.Total.Solde<>0 then
             begin
               showmessage('Vous devez indiquer un montant à déclarer');
               result.CodeErreur:=1000;
               result.retour:=false;
             end;
        End;//fin si champ Solde à décl vide
    if result.retour then
      Begin
         if InfosAvantValidation.Calcul.SensSolde=1 then
           InfosAvantValidation.Declaration:=StrToCurr_Lgr(editcourant.text)
         else
           if InfosAvantValidation.Calcul.SensSolde=-1 then
             InfosAvantValidation.Declaration:=-StrToCurr_Lgr(editcourant.text);
           InfosAvantValidation.report.Total.Solde:=0;
         if InfosAvantValidation.Apayer.retour then
           begin
             InfosAvantValidation.Apayer.Total.Solde:=InfosAvantValidation.Declaration;
           end;
         if InfosAvantValidation.remboursement.retour then
           begin
             InfosAvantValidation.remboursement.Total.Solde:=InfosAvantValidation.Declaration;
           end;
             SoldeReport.Value:=abs(InfosAvantValidation.Report.Total.Solde);
             SoldeRembourse.Value:=abs(InfosAvantValidation.Remboursement.Total.Solde);

      End;
    End;//fin si valeur à changé
  end;//fin si SoldeADecl
2:Begin //si SoldeRemboursement
  if ((EditCourant.text<>currtostr(abs(InfosAvantValidation.Remboursement.Total.Solde)))and(InfosAvantValidation.Remboursement.retour)) then
    Begin//si valeur à changé
    if not VerifNumeric(EditCourant.text).VideOUZero then
      Begin// si champ Solde à décl rempli
        if StrToCurr_Lgr(EditCourant.text)>abs(InfosAvantValidation.Declaration) then
          Begin
            showmessage('Le montant à Rembourser ne peut pas être supérieur au montant à déclarer');
            result.CodeErreur:=2001;
            result.retour:=false;
          End;
      End//fin si champ Solde à décl rempli
    else
      editcourant.text:='0';
      if result.retour then
         begin
           if InfosAvantValidation.Calcul.SensSolde=1 then
             InfosAvantValidation.Remboursement.Total.Solde:=StrToCurr_Lgr(editcourant.text)
           else
           if InfosAvantValidation.Calcul.SensSolde=-1 then
             InfosAvantValidation.Remboursement.Total.Solde:=-StrToCurr_Lgr(editcourant.text);
         end;
    end;//fin si valeur à changé
  end;//fin si SoldeRembourse
3:Begin //si SoldeReport
  if ((EditCourant.text<>currtostr(abs(InfosAvantValidation.Report.Total.Solde)))and(InfosAvantValidation.Report.retour)) then
    Begin//si valeur à changé
    if not VerifNumeric(EditCourant.text).VideOUZero then
      Begin// si champ Solde à décl rempli
        if StrToCurr_Lgr(EditCourant.text)>abs(InfosAvantValidation.Declaration) then
          Begin
            showmessage('Le montant à Reporter ne peut pas être supérieur au montant à déclarer');
            result.CodeErreur:=3001;
            result.retour:=false;
          End;
      End//fin si champ Solde à décl rempli
    else
      editcourant.text:='0';
      if result.retour then
         begin
           if InfosAvantValidation.Calcul.SensSolde=1 then
             InfosAvantValidation.Report.Total.Solde:=StrToCurr_Lgr(editcourant.text)
           else
             if InfosAvantValidation.Calcul.SensSolde=-1 then
               InfosAvantValidation.Report.Total.Solde:=-StrToCurr_Lgr(editcourant.text);
         end;
    end;//fin si valeur à changé
  end;//fin si SoldeReport
end;//fin du case
except
  abort;
end;//fin du try except
end;


procedure TInfos_Tva_Complementaires_ApresCalcul.SoldeADeclExit(
  Sender: TObject);
var
Ctrl:TErreurSaisie;
begin
if ActiveControl<>BtnAnnuler then
  Begin
    ctrl:=CtrlSaisieComplement(SoldeADecl,nil);
    if not Ctrl.retour then
      begin
        SoldeADecl.setfocus;
        abort;
      end
    else
      begin
        if InfosAvantValidation.Calcul.SensSolde=1 then
          InfosAvantValidation.Declaration:=SoldeADecl.Value
        else
          if InfosAvantValidation.Calcul.SensSolde=-1 then
            InfosAvantValidation.Declaration:=-SoldeADecl.Value;
        if abs(InfosAvantValidation.Calcul.total.solde)-abs(InfosAvantValidation.Declaration)<0 then
          Begin
            if InfosAvantValidation.Calcul.SensSolde=1 then
              InfosAvantValidation.CompteArrondis:='658'
            else
              if InfosAvantValidation.Calcul.SensSolde=-1 then
                InfosAvantValidation.CompteArrondis:='758';
          End
        else
          Begin
            if InfosAvantValidation.Calcul.SensSolde=1 then
              InfosAvantValidation.CompteArrondis:='758'
            else
              if InfosAvantValidation.Calcul.SensSolde=-1 then
                InfosAvantValidation.CompteArrondis:='658';
          End;
        //Label5.Caption:='Ce montant correspond à l''arrondis qui sera'+#10#13+'déclaré dans le compte de gestion :           Compte '+InfosAvantValidation.CompteArrondis;
      end;
  End;
end;

procedure TInfos_Tva_Complementaires_ApresCalcul.SoldeReportExit(
  Sender: TObject);
var
Ctrl:TErreurSaisie;
begin
try
if ActiveControl<>BtnAnnuler then
  Begin
    ctrl:=CtrlSaisieComplement(SoldeReport,nil);
    if not Ctrl.retour then
      begin
        SoldeReport.setfocus;
        abort;
      end
    else
      begin
        try
          //InfosAvantValidation.Remboursement.Total.Solde:=0;
          if ((abs(InfosAvantValidation.Declaration)-abs(InfosAvantValidation.Report.Total.Solde)>0)or(abs(InfosAvantValidation.Declaration)-abs(InfosAvantValidation.Report.Total.Solde)=0)) then
            begin
              InfosAvantValidation.Remboursement.Total.Solde:=InfosAvantValidation.Declaration-InfosAvantValidation.Report.Total.Solde;
              if InfosAvantValidation.Remboursement.Total.Solde<0 then
                InfosAvantValidation.Remboursement.SensSolde:=-1
              else
                if InfosAvantValidation.Remboursement.Total.Solde>0 then
                  InfosAvantValidation.Remboursement.SensSolde:=1;
            end;
        finally
          SoldeRembourse.Value:=abs(InfosAvantValidation.Remboursement.Total.Solde);
        end;//fin du try finally
      end;
  end;
except
   SoldeReport.setfocus;
end;
end;

procedure TInfos_Tva_Complementaires_ApresCalcul.SoldeRembourseExit(
  Sender: TObject);
var
Ctrl:TErreurSaisie;
begin
try
if ActiveControl<>BtnAnnuler then
  Begin
    ctrl:=CtrlSaisieComplement(SoldeRembourse,nil);
    if not Ctrl.retour then
      begin
        abort;
      end
    else
      begin
        try
          //InfosAvantValidation.Report.Total.Solde:=0;
          if ((abs(InfosAvantValidation.Declaration)-abs(InfosAvantValidation.Remboursement.Total.Solde)>0)or(abs(InfosAvantValidation.Declaration)-abs(InfosAvantValidation.Remboursement.Total.Solde)=0)) then
             InfosAvantValidation.Report.Total.Solde:=InfosAvantValidation.Declaration-InfosAvantValidation.Remboursement.Total.Solde;
          if InfosAvantValidation.Report.Total.Solde<0 then
            InfosAvantValidation.Report.SensSolde:=-1
          else
            if InfosAvantValidation.Report.Total.Solde>0 then
              InfosAvantValidation.Report.SensSolde:=1;
        finally
          SoldeReport.Value:=abs(InfosAvantValidation.Report.Total.Solde);
        end;//fin du try finally
      end;
  end;
except
   SoldeRembourse.setfocus;
end;
end;

procedure TInfos_Tva_Complementaires_ApresCalcul.SoldeADeclChange(
  Sender: TObject);
begin
Arrondis.Value:=abs(InfosAvantValidation.Calcul.Total.Solde)-SoldeADecl.Value;
end;

procedure TInfos_Tva_Complementaires_ApresCalcul.FormShow(Sender: TObject);
begin
InitLabel;
end;

procedure TInfos_Tva_Complementaires_ApresCalcul.FormCreate(
  Sender: TObject);
begin
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        InitialiseFormPosDefaut(self);
	//Left:= 30; Top:= 70; Width:= screen.Width-60; Height:= screen.Height-top-30;
    end;
FormateMonnaie([SoldeTva,SoldeADecl,Arrondis,SoldeRembourse,SoldeReport],E.FormatMonnaie);
end;

procedure TInfos_Tva_Complementaires_ApresCalcul.SoldeADeclEnter(
  Sender: TObject);
begin
SoldeADecl.SelectAll;
end;

procedure TInfos_Tva_Complementaires_ApresCalcul.Enregistrer1Click(
  Sender: TObject);
begin
self.ModalResult:=mrok;
end;

procedure TInfos_Tva_Complementaires_ApresCalcul.PaBtnResize(
  Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer],PaBtn,90,0);
end;

procedure TInfos_Tva_Complementaires_ApresCalcul.SoldeADeclKeyPress(
  Sender: TObject; var Key: Char);
begin
if key=#45 then key:=#0;
end;

procedure TInfos_Tva_Complementaires_ApresCalcul.SoldeRembourseKeyPress(
  Sender: TObject; var Key: Char);
begin
if key=#45 then key:=#0;
end;

procedure TInfos_Tva_Complementaires_ApresCalcul.SoldeReportKeyPress(
  Sender: TObject; var Key: Char);
begin
if key=#45 then key:=#0;
end;

procedure TInfos_Tva_Complementaires_ApresCalcul.BtnEnregistrerClick(
  Sender: TObject);
var
Ctrl:TErreurSaisie;
begin
    try
        ctrl:=CtrlSaisieComplement(SoldeADecl,nil);
        if not Ctrl.retour then
          begin
            SoldeADecl.setfocus;
            abort;
          end;
        //
        ctrl:=CtrlSaisieComplement(SoldeRembourse,nil);
        if not Ctrl.retour then
          begin
            SoldeRembourse.setfocus;
            abort;
          end;
        //
        ctrl:=CtrlSaisieComplement(SoldeReport,nil);
        if not Ctrl.retour then
          begin
            SoldeReport.setfocus;
            abort;
          end;
    except
      ModalResult:=MrNone;
    end;
end;

end.
