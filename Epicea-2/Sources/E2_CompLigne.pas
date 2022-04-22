{***************************************************************
 *
 * Unit Name: E2_SaisieCompLigne
 * Purpose  :
 * Author   : JS
 * History  :
 *
 ****************************************************************}

// Gere la saisie complémentaire d'une ligne d'écriture
// Tout est commenté
unit E2_CompLigne;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, gr_Librairie_obj,
  Buttons, DBTables,E2_Decl_Records,
  Mask, ToolEdit, CurrEdit,DMTva, RXCtrls, ExtCtrls,E2_Librairie_obj,{Gr_AideDate,}
  E2_AideTva,LibZoneSaisie,DMConstantes,LibDates, jpeg,LibGestionParamXML, lib_chaine,
  E2_LibInfosTable;

type

  TSaisieComplementLigne = class(TForm)
    PopupMenu1: TPopupMenu;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    pmMenu1: TMenuItem;
    Fermer1: TMenuItem;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaEntete: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EdTvaCode: TEdit;
    EdTvaType: TEdit;
    EdTvaDate: TDateEdit;
    EdTvaTaux: TCurrencyEdit;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    PaListTypeTVA: TPanel;
    Panel7: TPanel;
    PaList: TPanel;
    lbTvaType: TListBox;
    edMontantTva: TCurrencyEdit;
    Label5: TLabel;
    procedure Aide1Click(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
    procedure edTvaCodeChange(Sender: TObject);
    procedure lbTvaTypeExit(Sender: TObject);
    procedure lbTvaTypeDblClick(Sender: TObject);
    procedure lbTvaTypeKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pmMenu1Click(Sender: TObject);
    function CtrlSaisieComplement(EditCourant:TCustomEdit;CtrlSuivant:twincontrol):TErreurSaisie;
    procedure EdTvaCodeExit(Sender: TObject);
    procedure EdTvaTypeExit(Sender: TObject);
    procedure EdTvaDateExit(Sender: TObject);
    procedure EdTvaTauxExit(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    procedure EdTvaTypeChange(Sender: TObject);
    procedure EdTvaCodeKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure lbTvaTypeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edMontantTvaExit(Sender: TObject);
    procedure EdTvaTauxEnter(Sender: TObject);
    procedure EdTvaCodeEnter(Sender: TObject);
    procedure EdTvaTypeEnter(Sender: TObject);
    procedure EdTvaDateEnter(Sender: TObject);
    procedure edMontantTvaEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure EdTvaDateAcceptDate(Sender: TObject; var ADate: TDateTime;
      var Action: Boolean);
  private
    { Déclarations privées }
    FCompte,FTvaDate,FTvaCode,FTvaType :String;
    FLigne :Integer;
    FDatePiece:string;
    fTvaTaux:currency;
    FMontantHT:currency;
    fMontantTva:currency;
    FTypeLigne :String[1];
    FEtatModif :Boolean;


    TvaTaux_Tmp:real;
    TvaCode_Tmp:string;
    TvaType_Tmp:string;
    TvaDate_Tmp:Tdate;
    MontantTva_Tmp:currency;

    Procedure TypeValide;
    Procedure SetTvaType(aType :String);
    Procedure SetTvaDate(dDate :TDateTime);
    Procedure SetTvaTaux(Taux : Currency);
    Procedure SetMontantTva(MontantTva : Currency);

  public
    { Déclarations publiques }

   end;
var
  SaisieComplementLigne: TSaisieComplementLigne;

  function ComplementLigneAffiche(Id_Ligne:integer;TypeLigne,compte,DatePiece:string;var TvaCode:string;var TvaType:string;var tvaDate:string;HT:currency;var TvaTaux:real;var MontantTva:currency):boolean;

implementation

uses DMPiece, DMRecherche;
{$R *.DFM}

//******************************************************************************

function TSaisieComplementLigne.CtrlSaisieComplement(EditCourant:TCustomEdit;CtrlSuivant:twincontrol):TErreurSaisie;
var
Date_:TDetailDate;
TauxTmp:real;
MontantTVATmp:currency;
begin
try
result.CodeErreur:=0;
result.retour:=true;
if ((EditCourant.Enabled)and (ActiveControl<>btnAnnuler)) then
  begin // si EditCourant.enabled=true
    case EditCourant.Tag of
    1:Begin //si edTvaCode
       if TvaCode_Tmp<>edTvaCode.text then
         begin//si changement de code
         if not empty(edTvaCode.text) then
           begin //si code rempli
             if not AideTvaExiste(edTvaCode.Text, FCompte, edTvaCode)then
             begin
               result.CodeErreur:=1001;
               result.retour:=false;
               Application.Messagebox(Pchar('Le code Tva choisi n''est pas cohérent dans ce contexte !!!'),'Erreur de saisie',0);
             end
             else
             Begin
              edTvaType.ReadOnly:=false;
              if empty(edTvaType.Text)then
                edTvaType.Text:=FTvaTypeTva(Fcompte);
              if empty(edTvaType.Text)then edTvaType.Text:='D';
              //SetTvaTaux(FTvaRecupMiniMaxTva(edTvaCode.Text).Taux_Supp);
//              if Infos_TInfosplancpt(Dmrech.TaPlanCptRech,'Compte',[FCompte]).taux<>0 then
//                EdTvaTaux.Value:= Infos_TInfosplancpt(Dmrech.TaPlanCptRech,'Compte',[]).taux
//              else
                EdTvaTaux.Value:=FTvaTauxTva(edTvaCode.text);
              edMontantTva.value:=FMontantHT*edTvaTaux.Value/100;
             End;
           end//fin si code rempli
           else
           Begin//si code vide
            edTvaType.Text:='';
            edTvaType.ReadOnly:=true;
            edTvaDate.date:=0;
            EdTvaTaux.Value:=0;
            edMontantTva.value:=0;
           End;//fin si code vide
         end;//fin si changement de code
      End;//fin si edTvaCode
    2:Begin //si edTvaDate
       if TvaDate_Tmp<>edTvaDate.Date then
        begin//si changement de date        
          if empty(edTvaDate.Text)then
            begin
            result.CodeErreur:=2001;
            result.retour:=false;
            Application.Messagebox(Pchar('La zone date doit être remplie !!!'),'Erreur de saisie',0);
            end
          else
            begin
              if EdTvaDate.Text<>'  /  /    ' then
                Begin
                  Date_:=DateInfos(strtodate_lgr(EdTvaDate.Text));
                  EdTvaDate.Text:=date_.DateStr;
                  EdTvaDate.date:=date_.Date_;
                End;
            end;
        end;//fin si changement de date
      End;//fin si edTvaDate
    3:Begin //si edTvaType
        if  TvaType_Tmp<>edTvaType.text then
          begin//si changement de type
            if Not AideTvaTypeValide(edTvaCode.Text, edTvaType.Text) then
            Begin
            result.CodeErreur:=3001;
            result.retour:=false;
            Application.Messagebox(Pchar('Le Type de Tva choisi n''est pas cohérent dans ce contexte !!!'),'Erreur de saisie',0);
            end;
          end;//fin si changement de type
      End;//fin si edTvaType
    4:Begin //si edTvaTaux
        if arrondi(TvaTaux_Tmp,3)<>arrondi(edTvaTaux.Value,3) then
          begin//si changement de taux
            if not AideTvaTauxValide(edTvaCode.Text,FCompte, edTvaTaux.Value)then
              begin
              result.CodeErreur:=4001;
              result.retour:=false;
              end
            else
              Begin
                     if VerifNumeric(edTvaTaux.Text).VideOUZero then
                       Begin
                          edTvaTaux.Value:=0;
                          edMontantTva.value:=0;
                       End
                     else
                       Begin
                          edMontantTva.value:=FMontantHT*edTvaTaux.Value/100;
                          MontantTva_Tmp:=edMontantTva.value;
                       End;
              End;
          end;//fin si changement de taux
          if ((edTvaTaux.Value=0)and(copy(EdTvaCode.text,1,1)='C')or(copy(EdTvaCode.text,1,1)='M')) then
            Begin
              if VerifNumeric(edTvaTaux.Text).VideOUZero then
                Begin
                  try
                    Raise ExceptLGR.Create('Vous devez indiquer un taux de tva',0,true,mtError);
                  except
                    result.CodeErreur:=4001;
                    result.retour:=false;
                  end;
                End;
            End
      End;//fin si edTvaTaux
    5:Begin //si edMontantTva
        if arrondi(MontantTva_Tmp,2)<>arrondi(edMontantTva.value,2) then
          begin//si changement de montant tva
          if VerifNumeric(edMontantTva.Text).VideOUZero then
            Begin
              if not AideTvaTauxValide(edTvaCode.Text,FCompte, 0)then
                if application.MessageBox(Pchar('Le Montant de Tva choisi n''est pas cohérent dans ce contexte, voulez-vous le conserver ?'),'Erreur de saisie',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
                  begin
                    edTvaTaux.Text:='0';
                    edMontantTva.Text:='0';
                  end
                else
                  Begin
                    result.CodeErreur:=5001;
                    result.retour:=false;
                  End;
            End
          else
            Begin
              if FMontantHT<>0 then
                TauxTmp:=arrondi(edMontantTva.Value*100/FMontantHT,3)
              else
                TauxTmp:=0;
              if TvaTaux_Tmp<>TauxTmp then
                begin
                  if not AideTvaTauxValide(edTvaCode.Text,FCompte, TauxTmp)then
                     begin
                        result.CodeErreur:=5001;
                        result.retour:=false;
                        edMontantTva.Value:=MontantTva_Tmp;
                     End
                  else
                     Begin
                       edTvaTaux.Value:=TauxTmp;
                       TvaTaux_Tmp:= TauxTmp;
                     End;
                end;
            End;
          end;//fin si changement de montant tva
      End;//fin si edMontantTva
    end;//fin du case Editcourant.tag
  end;//fin si EditCourant.enabled=true
except
  result.CodeErreur:=0;
  result.retour:=false;
  abort;
end;
end;


//******************************************************************************
function ComplementLigneAffiche(Id_Ligne:integer;TypeLigne,compte,DatePiece:string;var TvaCode:string;var TvaType:string;var tvaDate:string;HT:currency;var TvaTaux:real;var MontantTva:currency):boolean;
// Initialise l'écran avec les valeurs de la ligne d'écriture
Begin
    if SaisieComplementLigne=nil then
    SaisieComplementLigne:=TSaisieComplementLigne.Create(Application.MainForm);

   with SaisieComplementLigne do
   begin
   FCompte:= compte;
   FLigne:= Id_Ligne;
   FTypeLigne:= TypeLigne;
   FEtatModif:= (FTypeLigne = 'H');
   FDatePiece:=DatePiece;
   edTvaCode.Text:= TvaCode;
   TvaCode_Tmp:=TvaCode;
   edTvaType.Text:= TvaType;
   edTvaDate.text:= tvaDate;
   edTvaDate.Date:=strtodate_lgr(tvaDate,strtodate_lgr(fdatePiece));
   edTvaTaux.Value:=TvaTaux;
   FMontantHT:=HT;
   edMontantTva.value:=MontantTva;
   edTvaCodeChange(edTvaCode);

   Result:= (SaisieComplementLigne.ShowModal = mrOk);
   if result then
   Begin
     //Récupérer les valeurs dans les var
     SetTvaType(SaisieComplementLigne.edTvaType.Text);

     if edTvaDate.text<>'  /  /    '  then
     SetTvaDate(StrToDate_Lgr(edTvaDate.text,strtodate_lgr(fdatePiece)))
     else
     SetTvaDate(0);
     SetTvaTaux(edTvaTaux.Value);
     SetMontantTva(SaisieComplementLigne.edMontantTva.Value);

     //remplir les variable à renvoyer
     TvaCode:=SaisieComplementLigne.FTvaCode;
     TvaType:=SaisieComplementLigne.FTvaType;
     tvaDate:=SaisieComplementLigne.FTvaDate;
     TvaTaux:=SaisieComplementLigne.fTvaTaux;
     MontantTva:=SaisieComplementLigne.fMontantTva;
   End;

   end;//fin du with SaisieComplementLigne
End;

procedure TSaisieComplementLigne.Calculatrice1Click(Sender: TObject);
// Affiche calculatrice F12
begin
	AfficheCalculatrice(nil);
end;


//******************************************************************************
procedure TSaisieComplementLigne.edTvaCodeChange(Sender: TObject);
var
CodeTva:string;
// Change la propriété enable des autres zones suivant le code TVA
begin
   edTvaCode.Enabled:= FEtatModif;
   edTvaType.Enabled:= FEtatModif And Not Empty(edTvaCode.Text);
   edTvaType.Text:=UpperCase(edTvaType.Text);
   edTvaType.SelStart:=length(edTvaType.text);
   edTvaDate.Enabled:= edTvaType.Enabled;
   edtvacode.Text:=UpperCase(edtvacode.Text);
   edtvacode.SelStart:=length(edtvacode.text);
   CodeTva:=edtvacode.Text;
//   edTvaTaux.Enabled:= ((copy(CodeTva,1,1)<>'V')and(FMontantHT<>0)and (edTvaType.Enabled));   edMontantTva.Enabled:= ((copy(CodeTva,1,1)<>'V')and(FMontantHT<>0)and (edTvaType.Enabled));
   edTvaTaux.Enabled:= not(not((copy(CodeTva,1,1)='A')or(copy(CodeTva,1,1)='I')or(copy(CodeTva,1,1)='C')or(copy(CodeTva,1,1)='M')or (edTvaType.Enabled=false)));
   if ((not edTvaTaux.Enabled)and(edTvaType.Enabled)) then
      edTvaTaux.Enabled:=((ParamUtil.maintenance)and (ParamUtil.TypeMaintenance='MaintS'));
   //   edTvaTaux.Enabled:= not(not((copy(CodeTva,1,1)='A')or(copy(CodeTva,1,1)='C')or (edTvaType.Enabled=false)));
   edMontantTva.Enabled:= edTvaTaux.Enabled;
   EdTvaDate.Enabled:= ((not empty(edTvaType.Text))and(edTvaType.Text<>'E')and(edTvaType.Enabled));
   EdTvaTypeChange(edTvaCode);
end;

//******************************************************************************
procedure TSaisieComplementLigne.lbTvaTypeExit(Sender: TObject);
// Jacques n'en est pas fier, ne pas commenter
// Gere la sortie de la liste des types de TVA
begin
        edTvaType.setfocus;
 	PaListTypeTVA.Visible:= False;
//   if Not (AideTvaTypeValide(edTvaCode.Text, edTvaType.Text)) then Begin
//   	Refocusing:= edTvaType;
//   End;
end;

//******************************************************************************
procedure TSaisieComplementLigne.lbTvaTypeDblClick(Sender: TObject);
// Valide le type TVA
begin
	TypeValide;
end;

//******************************************************************************
procedure TSaisieComplementLigne.lbTvaTypeKeyPress(Sender: TObject;
  var Key: Char);
// Valide le type TVA avec #13
begin
if not(key in [#9,#8,#13,#68,#69,#100,#101])then
  key:=#0;
//if ((key = #13)and(lbTvaType.Visible)) then
// begin
//  (sender as TCustomEdit).SelectAll;
// end;
end;

//******************************************************************************
Procedure TSaisieComplementLigne.TypeValide;
// Sélection le type TVA et valide
Begin
  if (lbTvaType.ItemIndex >= 0) then
  Begin
   SetTvaType(Copy(lbTvaType.Items.Strings[lbTvaType.ItemIndex],1, 1));
   //EdTvaType.SetFocus;

//   	Perform(WM_NEXTDLGCTL, 0, 0);
  End;
End;

procedure TSaisieComplementLigne.FormCreate(Sender: TObject);
begin
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
//        InitialiseFormPosDefaut(self); // PB 15-06-03
    end;
end;

//******************************************************************************
procedure TSaisieComplementLigne.FormDestroy(Sender: TObject);
begin
	LibGestionParamXML.DestroyForm(Self,E.USer);
   SaisieComplementLigne:=nil;
end;

Procedure TSaisieComplementLigne.SetTvaType(aType :String);
// Modif le type TVA dans la ligne d'écriture
Begin
	edTvaType.Text:= aType;
	If (FEtatModif) then
        //Récupérer la valeur dans la variable globale
        fTvaType:=SaisieComplementLigne.edTvaType.Text;
End;

//******************************************************************************
Procedure TSaisieComplementLigne.SetTvaDate(dDate :TDateTime);
// Modif la date TVA dans la ligne d'écriture
Begin
        if dDate<>0 then
	edTvaDate.text:= datetostr(dDate)
        else
        edTvaDate.text:='';
	If (FEtatModif) then
        //Récupérer la valeur dans la variable globale
        if edTvaDate.text<>'  /  /    ' then
          FTvaDate:=edTvaDate.text
        else
          FTvaDate:='';
End;

//******************************************************************************
Procedure TSaisieComplementLigne.SetTvaTaux(Taux : Currency);
// Modifie le taux TVA dans la ligne d'écriture
Begin
	edTvaTaux.value:= Taux;
	If (FEtatModif) then
        //Récupérer la valeur dans la variable globale
        fTvaTaux:=edTvaTaux.Value;
//        fTvaTaux:= StrToCurr_Lgr(edTvaTaux.text);
End;

procedure TSaisieComplementLigne.Aide1Click(Sender: TObject);
// Gestion de F1 suivant la zone active
begin
	if (ActiveControl = edTvaTaux) then
   	AfficheCalculatrice(ActiveControl)
   Else if (ActiveControl = edTvaCode) then
        begin
   	  AideTvaAffiche(edTvaCode, FCompte);
        end
   Else if (ActiveControl = edTvaType) then Begin
   	PaListTypeTVA.Visible:= true;
        lbTvaType.SetFocus;
        lbTvaType.ItemIndex:=0;
   End
   Else if (ActiveControl = edTvaDate) then
        edTvaDate.doclick;
   	//AideDateAffiche(edTvaDate,0)
end;




//******************************************************************************
procedure TSaisieComplementLigne.pmMenu1Click(Sender: TObject);
// F11
begin
//	PopupMenu1.Popup(Left + 50, Top + 50);
end;



procedure TSaisieComplementLigne.EdTvaCodeExit(Sender: TObject);
var
Valide:TErreurSaisie;
begin
	Valide:=CtrlSaisieComplement(EdTvaCode,nil);
        edTvaCodeChange(edTvaCode);
   if  Valide.retour then
   Begin//si code tva valide
   	If (FEtatModif) then
	//Récupérer la valeur dans la variable globale
        FTvaCode:=EdTvaCode.Text;
        TvaCode_Tmp:=EdTvaCode.Text;
      if Empty(edTvaCode.Text) then
      Begin {Pas de code}
      	SetTvaType('');
        SetTvaDate(0);
        SetTvaTaux(0);
        SetMontantTva(0);
      End {fin Pas de code}
      Else {si code rempli}
        if ((empty(EdTvaDate.Text))or(EdTvaDate.Text='  /  /    ')) then
          EdTvaDate.Text:=FDatePiece;
        edtvadate.Date:=strtodate_lgr(EdTvaDate.Text,strtodate_lgr(fdatepiece));
         if ((copy(edTvaCode.Text,1,1)='C')or (copy(edTvaCode.Text,1,1)='M')) then
         Begin {si Tva Acquisition CEE}
           if FTvaRecupMiniMaxTva(edTvaCode.Text).CodeRetour > 1 then
            if ((edTvaTaux.Value < FTvaRecupMiniMaxTva(edTvaCode.Text).Taux_Inf)
             or (edTvaTaux.Value > FTvaRecupMiniMaxTva(edTvaCode.Text).Taux_Supp)) Then
               begin
                 if Application.MessageBox(PChar('Êtes-vous sûr de vouloir utiliser le taux de : '+
                                      CurrToStr(edTvaTaux.Value)+
                                      ' % ? '+#10#13+
                                      'NOTE : Les Taux de Tva par défaut de ce compte sont soit : ' + CurrToStr(FTvaRecupMiniMaxTva(edTvaCode.Text).Taux_Inf)+ ' soit : '+CurrToStr(FTvaRecupMiniMaxTva(edTvaCode.Text).Taux_Supp)),'Confirmation',MB_YESNO+MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO
                 then
                  begin
                   SetTvaTaux(FTvaRecupMiniMaxTva(edTvaCode.Text).Taux_Supp);
                   showmessage('Attention, le taux de Tva a été ajusté en fonction de vos paramètres!');
                  end;
               end;
         End {fin Tva Acquisition CEE}
         Else
         Begin
           //SetTvaTaux(FTvaRecupMiniMaxTva(edTvaCode.Text).Taux_Supp);
//           if ((copy(edTvaCode.Text,1,1)='C')and(fTvaTaux=0)) then
//             EdTvaTaux.SetFocus;
         End;
//    TvaCode_Tmp:=EdTvaCode.text;
   End//fin si code tva valide
   else
   if (( ActiveControl<>BtnEnregistrer)and(ActiveControl<>btnAnnuler))then
     Begin//si
       EdTvaCode.OnEnter:=nil;
       EdTvaCode.SetFocus;
       EdTvaCode.OnEnter:=EdTvaCodeEnter;
     End;//fin si
end;

procedure TSaisieComplementLigne.EdTvaTypeExit(Sender: TObject);
var
valide:TErreurSaisie;
begin
 if (ActiveControl <> lbTvaType) then
  begin
     Valide:=CtrlSaisieComplement(EdTvaType,nil);
       if Not valide.retour then
       begin
           if ((ActiveControl<>BtnEnregistrer)and( ActiveControl<>btnAnnuler))then
           Begin
             EdTvaType.OnEnter:=nil;
             EdTvaType.setfocus;
             EdTvaType.OnEnter:=EdTvaTypeEnter;
//             PaListTypeTVA.Visible:= true;
//             lbTvaType.SetFocus;
           End;
       end
       Else If (FEtatModif) then
       //Récupérer valeur dans la liste
       begin
         fTvaType:=EdTvaType.text;
//         EdTvaDate.Enabled:= ((not empty(edTvaType.Text))and(edTvaType.Text<>'E'));
         TvaType_Tmp:=EdTvaType.text;
       end;
  end;
end;

procedure TSaisieComplementLigne.EdTvaDateExit(Sender: TObject);
var
valide:TErreurSaisie;
Date_:TDetailDate;
begin
try
    if datevalide(EdTvaDate.Text)then
      Begin
        Valide:=CtrlSaisieComplement(EdTvaDate,nil);
      end
    else
      Begin
        valide.retour:=true;
        if edtvadate.text='  /  /    ' then
           edtvadate.text:=fdatepiece;
        Date_.DateStr:=Str_QueDesChiffre_Integer(EdTvaDate.Text);
        Date_:=AnneeDefaut(DMPieces.Piece1.DateDebutExo,DMPieces.Piece1.DateFinExo,Date_.DateStr);
        EdTvaDate.Text:=date_.DateStr;
        EdTvaDate.date:=date_.Date_;
        Valide:=CtrlSaisieComplement(EdTvaDate,nil);
      end;

    if not valide.retour then
    begin
      abort;
    end
    else
      begin
      If (FEtatModif) then
       //Récupérer valeur dans la variable globale
       FTvaDate:=EdTvaDate.Text;
      TvaDate_Tmp:=EdTvaDate.Date;
      end;
except
   if ((ActiveControl<>BtnEnregistrer)and( ActiveControl<>btnAnnuler))then
     begin
       EdTvaDate.OnEnter:=nil;
       EdTvaDate.SetFocus;
       EdTvaDate.OnEnter:=EdTvaDateEnter;
     end;
end;
end;

procedure TSaisieComplementLigne.EdTvaTauxExit(Sender: TObject);
var
valide:TErreurSaisie;
begin
   Valide:=CtrlSaisieComplement(EdTvaTaux,nil);
     if (Valide.retour) And (FEtatModif) then
       begin
         //Récupérer valeur dans la variable globale
         fTvaTaux:=EdTvaTaux.Value;
         TvaTaux_Tmp:=EdTvaTaux.value;
       end
     else
       if ((ActiveControl<>BtnEnregistrer)and( ActiveControl<>btnAnnuler))then
       begin
         EdTvaTaux.onenter:=nil;
         EdTvaTaux.SetFocus;
         EdTvaTaux.onenter:=EdTvaTauxenter;
       end;
end;

procedure TSaisieComplementLigne.Fermer1Click(Sender: TObject);
begin
close;
end;

procedure TSaisieComplementLigne.EdTvaTypeChange(Sender: TObject);
begin
edTvaType.Text:=UpperCase(edTvaType.Text);
EdTvaDate.Enabled:= ((not empty(edTvaType.Text))and(edTvaType.Text<>'E'));
if BtnEnregistrer <> nil then
 if (sender as TWincontrol)= ActiveControl then
 begin
  BtnEnregistrer.Caption:='Valider';
 end;
end;

procedure TSaisieComplementLigne.EdTvaCodeKeyPress(Sender: TObject;
  var Key: Char);
begin
if (key in [#32])then
  key:=#0;
if key = #13 then
 begin
  (sender as TCustomEdit).SelectAll;
 end;
end;

procedure TSaisieComplementLigne.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
if key = VK_RETURN then
WinSuivPrec(Handle,key,[nil]);
if ((ActiveControl = edTvaType)and(key=vk_down)) then
  Begin
    PaListTypeTVA.Visible:= true;
    lbTvaType.SetFocus;
    lbTvaType.ItemIndex:=0;
  end;
if activeControl <> lbTvaType then
 begin
  if Key = VK_ESCAPE then
   begin
    Key:= 0;
    Self.Close;
   end;
 end;
end;

procedure TSaisieComplementLigne.BtnEnregistrerClick(Sender: TObject);
////// Fermeture
var
valide:TErreurSaisie;
i:integer;
count:integer;
begin
ModalResult:= mrOk;
if ActiveControl<>btnAnnuler then
   begin
     EdTvaCodeExit(EdTvaTaux);
     For i:=0 to PaEntete.ControlCount-1 do
       begin
         if (PaEntete.Controls[i] is TCustomEdit) then
           begin
             valide:=CtrlSaisieComplement((PaEntete.Controls[i] as TCustomEdit),nil);
              if not valide.retour then
                begin
                (PaEntete.Controls[i] as TCustomEdit).SetFocus;
                 self.ModalResult:=mrnone;
                 abort;
                end;
          end;
       end;
   end;
end;

procedure TSaisieComplementLigne.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
canclose:=true;
end;

procedure TSaisieComplementLigne.lbTvaTypeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
case key of
   VK_ESCAPE:begin
              key:=VK_CANCEL;
              EdTvaType.SetFocus;
             end;
   VK_RETURN:begin
              key:=0;
              lbTvaTypeDblClick(lbTvaType);
             end;
    VK_UP:begin
            key:=VK_CANCEL;
            if lbTvaType.ItemIndex>0 then
             lbTvaType.ItemIndex:=lbTvaType.ItemIndex-1;
          end;
    VK_DOWN:begin
            key:=VK_CANCEL;
            if (lbTvaType.ItemIndex < (lbTvaType.Items.Count-1)) then
               lbTvaType.ItemIndex:=lbTvaType.ItemIndex+1;
            end;
//    else begin
//         keyP:=chr(key);
//         ComboEdit1KeyPress(ComboEdit1,keyP[1]);
//         ComboEdit1.SetFocus;
//         end;
end;


end;

Procedure TSaisieComplementLigne.SetMontantTva(MontantTva : Currency);
// Modifie le taux TVA dans la ligne d'écriture
Begin
	edMontantTva.value:= MontantTva;
	If (FEtatModif) then
        //Récupérer la valeur dans la variable globale
        fMontantTva:=edMontantTva.Value;
End;

procedure TSaisieComplementLigne.edMontantTvaExit(Sender: TObject);
var
valide:TErreurSaisie;
begin
   Valide:=CtrlSaisieComplement(edMontantTva,nil);
     if (Valide.retour) And (FEtatModif) then
       begin
         //Récupérer valeur dans la variable globale
         fMontantTva:=edMontantTva.Value;
         MontantTva_Tmp:=edMontantTva.value;
       end
     else
       if ((ActiveControl<>BtnEnregistrer)and( ActiveControl<>btnAnnuler))then
       begin
         edMontantTva.onenter:=nil;
         edMontantTva.SetFocus;
         edMontantTva.OnEnter:=edMontantTvaenter;
       end;
end;

procedure TSaisieComplementLigne.EdTvaTauxEnter(Sender: TObject);
begin
TvaTaux_Tmp:=EdTvaTaux.value;
end;

procedure TSaisieComplementLigne.EdTvaCodeEnter(Sender: TObject);
begin
TvaCode_Tmp:=EdTvaCode.text;
end;

procedure TSaisieComplementLigne.EdTvaTypeEnter(Sender: TObject);
begin
TvaType_Tmp:=EdTvaType.text;
end;

procedure TSaisieComplementLigne.EdTvaDateEnter(Sender: TObject);
begin
TvaDate_Tmp:=EdTvaDate.Date;
end;

procedure TSaisieComplementLigne.edMontantTvaEnter(Sender: TObject);
begin
MontantTva_Tmp:=edMontantTva.value;
end;

procedure TSaisieComplementLigne.FormShow(Sender: TObject);
begin
edMontantTva.DisplayFormat:=E.FormatMonnaie;
EdTvaCode.SetFocus;
end;

procedure TSaisieComplementLigne.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TSaisieComplementLigne.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TSaisieComplementLigne.EdTvaDateAcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
begin
try
  EdTvaDateExit(edTvaDate);
except
  action:=false;
  abort;
end;
end;

end.
