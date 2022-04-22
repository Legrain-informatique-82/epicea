unit E2_RepartitionResult;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CurrEdit, Grids, GrGrid, Mask, ToolEdit, StdCtrls, RXCtrls, ExtCtrls,
  Menus,
  LibZoneSaisie,
  E2_Librairie_obj,
  Gr_Librairie_obj,
  Lib1,
  DMBalances,
  DMClotures,
  DMPiece,
  DMPlanCpt,
  LibDates,
  DB,
  E2_Decl_Records,
  DMConstantes,
  LibSQL,
  LibGestionParamXML,
  lib_chaine,
  jpeg;

type


  TParamAfficheRepartitionResult=record
    Affiche:Boolean;
    AffichageModal:Boolean;
    TitreForm:String;
    SousTitreForm:String;
    ListeCompte:TStringlist;
  end;

//    TErreurRepartition=record
//       CodeErreur:integer;
//       Retour:boolean;
//    end;


  TRepartitionResult = class(TForm)
    PaGrille: TPanel;
    GrRepartition: TGrGrid;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Insrer1: TMenuItem;
    Modifier1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    N2: TMenuItem;
    Precdant1: TMenuItem;
    Suivant1: TMenuItem;
    N3: TMenuItem;
    Affecter1: TMenuItem;
    PaTools: TPanel;
    RxSpeedButton5: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    Panel2: TPanel;
    Label2: TLabel;
    RxSpeedButton1: TRxSpeedButton;
    NumCpt: TEdit;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxSpeedButton2: TRxSpeedButton;
    RxLaMenu: TRxLabel;
    RxLabTitre: TRxLabel;
    RxSpeedButton3: TRxSpeedButton;
    Label1: TLabel;
    Label5: TLabel;
    LaDebitCredit: TLabel;
    Label3: TLabel;
    DateOP: TDateEdit;
    Panel1: TPanel;
    PaBas: TPanel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    Label4: TLabel;
    Label7: TLabel;
    CurSoldeCompteResultat: TCurrencyEdit;
    CurMontantRestant: TCurrencyEdit;
    procedure PaBtnResize(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    Function SommeColonne(Grille:TStringGrid;Col,RowDeb,RowFin:Integer):Variant;
    procedure GrRepartitionRowExit(sender: TObject; LastRow: Integer);
    procedure GrRepartitionColExit(OldColonne, LastRow: Integer);
    procedure DateOPAcceptDate(Sender: TObject; var ADate: TDateTime;
      var Action: Boolean);
    procedure GrRepartitionRowValidate(Sender: TObject; var Valide,
      Action: Boolean; LastCol: Integer);
    procedure GrRepartitionExit(Sender: TObject);
    procedure EnregistrementComplet;
    procedure Aide1Click(Sender: TObject);
    function CtrlSaisieRepartition(Champ:string;FRow,Acol:integer;ColonneSuivante:integer):TErreurSaisie;
    procedure GrRepartitionEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Etatinitial;
    procedure FormDestroy(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure ChangementEtatBoutonsMenu(Etat:Tdatasetstate);
    procedure Calculatrice1Click(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure GrRepartitionStateChange(EtatGrille: TDataSetState);
    procedure GrRepartitionSupprLigne(sender: TObject; Arow: Integer;
      var NewRow: Integer);
    procedure GrRepartitionColEnter(OldColonne, NewColonne,
      NewRow: Integer);
    procedure Affecter1Click(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
    TitreForm:String;
    SousTitreForm:String;
    ListeCompte:TStringlist;
  end;

var
  RepartitionResult: TRepartitionResult;
  MontantTotalAAffecter,MontantTotalDejaAffecte:currency;
  TotauxBalance:TTotauxBalance;
  ColonneMontantRepartition:Integer;
  MessDerSub:boolean;
  LigneCurr:integer;
  LastLibEcriture:string;
  NewLibEcriture:string;
//  ObjetOD:PObjetOD;
  ListeRepartition:Tlist;
  ListOD:Tstringlist;

//procedure ListRepartitionAdd(Valeur:array of const);
function AideRepartitionAffiche(ParamAfficheRepartitionResult:TParamAfficheRepartitionResult):Boolean;

implementation

uses E2_Main, E2_AideCompte, DMDiocEtatBalance, DMImmos, DMImportation,
  E2_Cloture_Def;

{$R *.DFM}

function AideRepartitionAffiche(ParamAfficheRepartitionResult:TParamAfficheRepartitionResult):Boolean;
begin
  if RepartitionResult=nil then
    RepartitionResult:=tRepartitionResult.Create(application.MainForm);
 if not empty(ParamAfficheRepartitionResult.TitreForm) then
   RepartitionResult.TitreForm:=ParamAfficheRepartitionResult.TitreForm;
 RepartitionResult.SousTitreForm:=ParamAfficheRepartitionResult.SousTitreForm;
 
 if ParamAfficheRepartitionResult.ListeCompte<> nil then
   begin
     if RepartitionResult.ListeCompte=nil then RepartitionResult.ListeCompte:=Tstringlist.create;
     RepartitionResult.ListeCompte.Assign(ParamAfficheRepartitionResult.ListeCompte);
   end;
// RepartitionResult.Etatinitial;
 
 if ParamAfficheRepartitionResult.Affiche then
  begin
   if ParamAfficheRepartitionResult.AffichageModal then
     RepartitionResult.ShowModal
    else
     RepartitionResult.Show;
  end;
End;


Function TRepartitionResult.SommeColonne(Grille:TStringGrid;Col,RowDeb,RowFin:Integer):Variant;
Var
i:Integer;
Total:Extended;
Begin
Total:=0;
for i:=RowDeb to RowFin do
 Begin
  try
   if not empty(Grille.Cells[Col,i]) then
   Total:=Total+StrToFloat_Lgr(Grille.Cells[Col,i]);
  except
  end;
 End;
Result:=Total;
//
End;

procedure TRepartitionResult.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TRepartitionResult.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TRepartitionResult.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TRepartitionResult.PaGrilleResize(Sender: TObject);
begin
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TRepartitionResult.FormCreate(Sender: TObject);
begin
 if AideCompte=nil then
 AideCompte:=TAideCompte.Create(self);
ColonneMontantRepartition:=3;
if ListeRepartition=nil then
ListeRepartition:=TList.Create;
GrRepartition.Rows[0].CommaText:=',Compte,Libelle,"Montant Affect�"';//,"  % Affect�"';
GrRepartition.Champ.Add(Grtous);
GrRepartition.Champ.Add(Grcompte);
GrRepartition.Champ.Add(Grtous);
GrRepartition.Champ.Add(GrCurr);
CurSoldeCompteResultat.DisplayFormat:=E.FormatMonnaie;
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;

procedure TRepartitionResult.FormActivate(Sender: TObject);
begin
//DMPlan.TaCompte.OnFilterRecord:=nil;
Initialiser_ShortCut_Main(true);
GrRepartition.ParamColor:=true;
GrRepartition.Param:=ParamUtil.CouleurDBGrid;
GrRepartition.UpDateColor;
Etatinitial;
end;

procedure TRepartitionResult.GrRepartitionRowExit(sender: TObject;
  LastRow: Integer);
var
act,valide:boolean;
begin
act:=true;
valide:=true;
  try
   GrRepartitionRowValidate(btnenregistrer,valide,act,GrRepartition.col);
  except
   abort;
  end;//fin du 1er try except
end;

procedure TRepartitionResult.GrRepartitionColExit(OldColonne,
  LastRow: Integer);
var
CtrlRepartition:TErreurSaisie;
begin
try
if not GrRepartition.lignevide(LastRow)then
   begin //si ligne n'est pas vide
//   if GrRepartition.EtatGrille in [dsinsert,dsEdit] then
//     Begin //si etatpiece in [dsinsert,dsEdit]

     CtrlRepartition:=CtrlSaisieRepartition(GrRepartition.Cells[GrRepartition.OldColonne,LastRow],LastRow,GrRepartition.OldColonne,GrRepartition.newcolonne);
        if  CtrlRepartition.retour=false then
          case CtrlRepartition.CodeErreur of
          1001:begin //compte pas valide
               abort;
               end;
//          2001:begin //Libell� pas valide
//               abort;
//               end;

          3001:begin //Montant sup�rieur
               abort;
               end;
//          3002:begin //Montant pas rempli
//               abort;
//               end;

          end;//fin du case codeErreur
//     End;//Fin si etatgrille in [dsinsert,dsEdit]
   end;//fin si ligne n'est pas vide
except
GrRepartition.SetFocus;
abort;
end;
//if OldColonne=ColonneMontantRepartition then
//begin
// if CurSoldeCompteResultat.Value-SommeColonne(GrRepartition,ColonneMontantRepartition,1,GrRepartition.RowCount-1) >= 0 then
//  CurMontantRestant.Value:=CurSoldeCompteResultat.Value-SommeColonne(GrRepartition,ColonneMontantRepartition,1,GrRepartition.RowCount-1)
//  else
// begin
//  if CurSoldeCompteResultat.Value-SommeColonne(GrRepartition,ColonneMontantRepartition,1,GrRepartition.RowCount-1) < 0 then
//   showmessage('Le montant � affecter ne peut d�passer le solde du compte de r�sultat');
//  abort;
// end;
//end;
end;

procedure TRepartitionResult.DateOPAcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
begin
if DateInfos(ADate).Vide then
   begin
     showmessage('Vous devez saisir une date pour cette Op�ration Diverse');
     DateOP.SetFocus;
     action:=false;
   end;
if (ADate<E.DatExoDebut)then
ADate:=E.DatExoDebut;
if (ADate>E.DatExoFin) then
ADate:=E.DatExoFin;
end;

procedure TRepartitionResult.GrRepartitionRowValidate(Sender: TObject;
  var Valide, Action: Boolean; LastCol: Integer);
var
i:integer;
CtrlRepartition:TErreurSaisie;
begin
try
   try
   if not GrRepartition.lignevide(GrRepartition.row)then
      begin //si ligne n'est pas vide
         for i:=1 to GrRepartition.ColCount-1 do
         Begin
           MessDerSub:=false;
           CtrlRepartition:=CtrlSaisieRepartition(GrRepartition.Cells[i,GrRepartition.row],GrRepartition.row,i,i+1);
           if CtrlRepartition.Retour=false then
           case CtrlRepartition.CodeErreur of
           1001:Begin
                   valide:=false;
                   abort;
                End;
           2001:Begin
                   valide:=false;
                   abort;
                End;
           3001:Begin
                   valide:=false;
                   abort;
                End;
           3002:Begin
                   valide:=false;
                   abort;
                End;
           end;//fin du case CtrlRepartition.codeerreur
         End;
//      if valide then
//        btnenregistrer.Enabled:=true
//      else
//        btnenregistrer.Enabled:=false;

      end//fin si ligne n'est pas vide
      else
      valide:=true;
   finally
   if ((not valide)or(CurMontantRestant.Value = 0)) then
      GrRepartition.AjoutAuto:=false
   else
      GrRepartition.AjoutAuto:=true;
   MessDerSub:=true;
   end;//fin du try finally
except
 GrRepartition.SetFocus;
 abort;
end;

end;

procedure TRepartitionResult.GrRepartitionExit(Sender: TObject);
var
act,valide:boolean;
begin
act:=true;
valide:=true;
GrRepartition.SupprimeLigne(GrRepartition.RechercheLigneVide);
GrRepartitionRowValidate(GrRepartition,valide,Act,GrRepartition.col);
end;


procedure TRepartitionResult.EnregistrementComplet;
var
i:integer;
SourceEcriture:TRecordEcriture;
SourcePiece:TRecordPiece;
listeFactice:Tlist;
rang:integer;
ValPieceAutoGen:TValPieceAutoGenere;
compteComptable:TCompteAmortissement;
ListOD:TStringList;
CumulDerog:currency;
Tab:variant;
Begin
  try
     try
       listeFactice:=nil;
       DMPieces.Piece1.initialiseValPieceAutoGen(ValPieceAutoGen);
       SourcePiece.IDJournal:=3;
       SourcePiece.Date:=e.DatExoFin;
       SourcePiece.Validation:=SourcePiece.Date;
       SourcePiece.Libelle:=Label2.Caption;
       SourcePiece.Compte:=NumCpt.Text;
       SourcePiece.Journal:='OD';
       SourcePiece.Reference:='';
       DMImport.VerifCreationPieceEcriture;
       DMImport.Piece_Import.NouvellePiece(false);

       if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
       DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
       rang:=1;
       //remplissage ligne vide
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H'],true,false,-1);
       MontantTotalDejaAffecte:=SommeColonne(GrRepartition,ColonneMontantRepartition,1,GrRepartition.RowCount-1);
       for i:=0 to GrRepartition.RowCount-1 do
       begin
        if not GrRepartition.LigneVide(i) then
           begin
            if not TotauxBalance.SoldeDebitCreditReport then//d�bit Contrepartie, Cr�dit pour les autres lignes
               begin
                 if i=0 then
                 DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',NumCpt.Text,'',label2.caption,0,0,-MontantTotalDejaAffecte,0,'','',0,'',''],true,false,-1)
                 else
                 DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',GrRepartition.Cells[1,i],'',GrRepartition.Cells[2,i],0,0,StrToCurr_Lgr(GrRepartition.Cells[3,i]),0,'','',0,'',''],true,false,-1)
               end
            else //cr�dit Contrepartie, D�bit pour les autres lignes
               begin
                 if i=0 then
                 DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',NumCpt.Text,'',label2.caption,0,0,MontantTotalDejaAffecte,0,'','',0,'',''],true,false,-1)
                 else
                 DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',GrRepartition.Cells[1,i],'',GrRepartition.Cells[2,i],0,0,-StrToCurr_Lgr(GrRepartition.Cells[3,i]),0,'','',0,'',''],true,false,-1)
               end;
           end;//fin si ligne remplie
       end;
//   OD:=CreationODSurListe(Label2.Caption,NumCpt.Text,'',ListeRepartition,DateOP.Date,nil);
     DMImport.RecupPieceEcriture_SurRecords(true,SourcePiece,DMImport.Ecriture_Import.ListeEcriturePiece,ValPieceAutoGen,'','',0);
     ListOD:=TStringList.Create;
     DMImport.EnregistrementPiece(false,nil,ListOD,listeFactice);
     DMPieces.AffichageFeuilleReprise(0,ListOd,nil,'Affichage de l''OD de Resultat','','',false);
     TableGereCommit(dmpieces.Piece1.TablePiece);
     TableGereCommit(DMBalance.TaBalance);
     except
      showmessage('Probl�me � l''enregistrement de l''Op�ration Diverse !');
      abort;
     end;//fin du try except
  finally
  Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,RepartitionResult,false);
//    if ListOD<>nil then
//      ListOD.free;
//   if DMImport.Ecriture_Import.ListeEcriturePiece<>nil then
//     Begin
//        DMImport.Ecriture_Import.ListeEcriturePiece.Free;
//        DMImport.Ecriture_Import.ListeEcriturePiece:=nil;
//     End;
  end;//fin du try finally
End;


procedure TRepartitionResult.Aide1Click(Sender: TObject);
begin

If activecontrol = GrRepartition Then
  begin //si on est sur la grille
   case GrRepartition.col of
      1:Begin
        //Afficher aidecompte filtr� en fonction du journal
        if E.TypeEntreprise='IND' then
          AideCompte.FiltrageAideCompte(34)
        else
        if E.TypeEntreprise='SOC' then
          AideCompte.FiltrageAideCompte(35);
        MessDerSub:=false;
        AideCompteDansContexte(GrRepartition.Cells[1,GrRepartition.row],GrRepartition,['Rac1'],true,MessDerSub,false,true,true,true,0);
        MessDerSub:=true;
        End;
   end;//fin du case
  end;//fin si on est sur la grille
end;


function TRepartitionResult.CtrlSaisieRepartition(Champ:string;FRow,Acol:integer;ColonneSuivante:integer):TErreurSaisie;
Begin
result.CodeErreur:=0;
result.retour:=true;
  case Acol of
  1:begin//si colonne compte
      if E.TypeEntreprise='IND' then
        AideCompte.FiltrageAideCompte(34)
      else
      if E.TypeEntreprise='SOC' then
        AideCompte.FiltrageAideCompte(35);
      if AideCompteDansContexte(GrRepartition.Cells[1,FRow],GrRepartition,['Rac1'],false,MessDerSub,true,true,true,true,0)=false then
         Begin //si compte pas rempli ou pas correct
         Application.Messagebox(Pchar('La saisie du compte est obligatoire !!!'),'Erreur de saisie',0);
         result.CodeErreur:=1001;//compte pas rempli ou pas valide
         result.retour:=false;
         End; //fin si compte pas rempli ou pas correct
      if not empty(GrRepartition.cells[1,FRow])then
         Begin
            NewLibEcriture:=DMPlan.LibelleDuNumCptPCU(GrRepartition.Cells[1,FRow]);
            GrRepartition.cells[2,FRow]:=NewLibEcriture;
         End;
      MessDerSub:=true;
    end;
  2:begin//si colonne Libelle
      if ((not empty(GrRepartition.Cells[1,FRow]))or (ColonneSuivante<>1))then
         begin //si compte rempli
           //Si Libell� vide, remplie par d�faut
           if empty(champ)then //si champ libelle vide
              begin
              GrRepartition.Cells[2,FRow]:=NewLibEcriture;
              LastLibEcriture:=NewLibEcriture;
              end
           else //si champ libelle rempli
              Begin //si champ libelle rempli avec une *
              if trim(champ)='*' then
                 Begin
                 GrRepartition.Cells[2,FRow]:=NewLibEcriture;
                 LastLibEcriture:=NewLibEcriture;
                 End
              else
                 Begin //si champ libelle rempli sans *
                 if ((LastLibEcriture=champ)and (NewLibEcriture<>champ)) then
                   begin
                     GrRepartition.Cells[2,FRow]:=NewLibEcriture;
                     LastLibEcriture:=NewLibEcriture;
                   end;
                 End;
              End;//fin si champ libelle rempli
           if empty(GrRepartition.Cells[2,FRow]) then
             Begin //si libelle vide
             Application.Messagebox(Pchar('La saisie du Libell� est obligatoire !!!'),'Erreur de saisie',0);
             result.CodeErreur:=2001;//Libell� pas rempli
             result.retour:=false;
             End; //fin si libelle vide
           end; //fin si compte rempli
    end ;//fin si champ libelle
  3:begin//si colonne Montant
      if not VerifNumeric(champ).VideOUZero then
         begin
            if CurSoldeCompteResultat.Value-SommeColonne(GrRepartition,ColonneMontantRepartition,1,GrRepartition.RowCount-1) >= 0 then
             CurMontantRestant.Value:=CurSoldeCompteResultat.Value-SommeColonne(GrRepartition,ColonneMontantRepartition,1,GrRepartition.RowCount-1)
             else
             begin
              if CurSoldeCompteResultat.Value-SommeColonne(GrRepartition,ColonneMontantRepartition,1,GrRepartition.RowCount-1) < 0 then
                Application.Messagebox(Pchar('Le montant � affecter ne peut d�passer le solde du compte de r�sultat'),'Erreur de saisie',0);
             result.CodeErreur:=3002;//Montant sup�rieur
             result.Retour:=false;
             end;
          end
       else
          Begin
           Application.Messagebox(Pchar('Le montant � affecter doit �tre renseign� !'),'Erreur de saisie',0);
           result.CodeErreur:=3001;
           result.Retour:=false;
          End;
     MontantTotalAAffecter:=CurSoldeCompteResultat.Value-SommeColonne(GrRepartition,ColonneMontantRepartition,1,GrRepartition.RowCount-1);
    end;
  end;//fin du case Acol
End;

procedure TRepartitionResult.GrRepartitionEnter(Sender: TObject);
begin
GrRepartition.col:=1;
end;

procedure TRepartitionResult.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Shift=[] then WinSuivPrec(Handle,key,[GrRepartition]);
 If Key = VK_ESCAPE Then
 Begin
   BtnAnnulerClick(btnannuler);
 end;
end;

procedure TRepartitionResult.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
canclose:=true;

if CanClose then
 else
 begin
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(self);

 end;
//Etatinitial;
  try
//    if ((Cloture_Def<>nil)and(ActivationForm(Cloture_Def))) then // PB
//      begin
//        if Cloture_Def.EtapeSuivante>=9 then  { isa  le  09/09/03 }
//          Cloture_Def.EtapeSuivante:=8;
//      end;
  except
    //
  end;
end;


procedure TRepartitionResult.Etatinitial;
var
i:integer;
Begin
DateOP.Date:=now;
if (StrToDate_Lgr(DateOP.Text)<E.DatExoDebut)then
DateOP.Text:=datetostr(E.DatExoDebut);
if (StrToDate_Lgr(DateOP.Text)>E.DatExoFin) then
DateOP.Text:=datetostr(E.DatExoFin);
MessDerSub:=true;
GrRepartition.RowCount:=2;
GrRepartition.Rows[1].Clear;
GrRepartition.Row:=1;
ListeRepartition.clear;
CurSoldeCompteResultat.value:=0;
InitialiseTotauxBalance(TotauxBalance);
if ListeCompte=nil then ListeCompte:=TStringList.Create;
if ListeCompte.Count<>0 then
  begin
      i:=0;
      while ((TotauxBalance.SoldeFin=0)and(i<ListeCompte.Count)) do
        begin
          TotauxBalance:=DMDiocEtatBal.SommeTotauxBalanceParCompte(E.DatExoDebut,E.DatExoFin,ListeCompte.Strings[i]);
          inc(i);
        end;

     if TotauxBalance.soldefin <> 0 then
       begin
       NumCpt.Text:=ListeCompte.Strings[i-1];
       Label2.Caption:=DMPlan.LibelleDuNumCptPCU(ListeCompte.Strings[i-1]);
       end;
     CurSoldeCompteResultat.Value:=abs(TotauxBalance.soldefin);
     CurMontantRestant.Value:=CurSoldeCompteResultat.Value-SommeColonne(GrRepartition,ColonneMontantRepartition,1,GrRepartition.RowCount-1);
     if TotauxBalance.SoldeDebitCreditFin then
       LaDebitCredit.Caption:=' Au d�bit.'
     else
       LaDebitCredit.Caption:=' Au cr�dit.';
  end;//fin si liste compte remplie

if canfocus then numcpt.SetFocus;
ChangementEtatBoutonsMenu(GrRepartition.EtatGrille);
btnenregistrer.Enabled:=false;
MontantTotalDejaAffecte:=SommeColonne(GrRepartition,ColonneMontantRepartition,1,GrRepartition.RowCount-1);
MontantTotalAAffecter:=CurSoldeCompteResultat.Value-SommeColonne(GrRepartition,ColonneMontantRepartition,1,GrRepartition.RowCount-1);
if MontantTotalAAffecter <=0 then
  begin
    MontantTotalAAffecter:=0;
    BtnFermer.Click;
  end;
End;

procedure TRepartitionResult.FormDestroy(Sender: TObject);
begin
LibereObjet(Tobject(ListeRepartition),Self);
LibereObjet(Tobject(ListOD),Self);
LibereObjet(Tobject(ListeCompte),Self);
LibGestionParamXML.DestroyForm(self,E.User);
RepartitionResult:=nil;
end;

procedure TRepartitionResult.BtnEnregistrerClick(Sender: TObject);
begin
   try
     GrRepartitionRowExit(btnenregistrer,GrRepartition.Row);
     EnregistrementComplet;
     Etatinitial;
   except
     abort;
   end;//fin du try except
end;

procedure TRepartitionResult.BtnAnnulerClick(Sender: TObject);
begin
   try
     if GrRepartition.LigneVide(1)then
       BtnFermerClick(sender)
     else
       Begin
         if Application.MessageBox(Pchar(' Voulez-vous enregistrer cette pi�ce ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
           BtnEnregistrerClick(btnannuler)
         else
           BtnFermerClick(sender);  
       End;
   except
     abort;
   end;//fin du try except
end;


procedure TRepartitionResult.ChangementEtatBoutonsMenu(Etat:Tdatasetstate);
Begin
//changement d'�tat des boutons et menu apr�s chaque changemement d'�tatPiece
  case Etat of
  dsbrowse:Begin//d�but etat=DsBrowse
            //Boutons
            EnableWinControl([BtnAnnuler,BtnInserer,BtnFermer,BtnImprimer],true);
            EnableWinControl([BtnEnregistrer],False);
            BtnSupprimer.Enabled:=((not GrRepartition.LigneVide(1))or(GrRepartition.RowCount>2));
            BtnModifier.Enabled:=((not GrRepartition.LigneVide(1))or(GrRepartition.RowCount>2));
            //Pop menu grille
            EnableItemMenu([Aideenligne1,Aide1,Visualisation1,Calculatrice1,Annuler1,Fermer1],true);
            end;//fin etat=DsBrowse
  dsinsert:Begin//d�but etat=dsinsert
            //Boutons
            EnableWinControl([BtnEnregistrer,BtnAnnuler,BtnFermer,BtnImprimer],true);
            EnableWinControl([BtnInserer,BtnSupprimer,BtnModifier],False);
            //Pop menu grille
            EnableItemMenu([Aideenligne1,Aide1,Visualisation1,Calculatrice1,Annuler1,Fermer1],true);
            //EnableItemMenu([],false);
            end;//fin etat=dsinsert
  dsEdit:Begin//d�but etat=dsEdit
            //Boutons
            EnableWinControl([BtnEnregistrer,BtnAnnuler,BtnFermer,BtnImprimer],true);
            EnableWinControl([BtnInserer,BtnSupprimer,BtnModifier],False);
            //Pop menu grille
            EnableItemMenu([Aideenligne1,Aide1,Visualisation1,Calculatrice1,Annuler1,Fermer1],true);
            //EnableItemMenu([],false);
            end;//fin etat=dsEdit
  end;//fin du case Etat
Enregister1.Enabled:=BtnEnregistrer.Enabled;
Imprimer1.Enabled:=BtnImprimer.Enabled;
Insrer1.Enabled:=BtnInserer.Enabled;
Supprimer1.Enabled:=BtnSupprimer.Enabled;
Modifier1.Enabled:=BtnModifier.Enabled;
end;


procedure TRepartitionResult.Calculatrice1Click(Sender: TObject);
begin
if GrRepartition.Col in [3] then
  AfficheCalculatrice(GrRepartition)
else
  AfficheCalculatrice(nil);
end;

procedure TRepartitionResult.BtnInsererClick(Sender: TObject);
var
rang:integer;
begin
   try
     rang:=GrRepartition.RechercheLigneVide;
     if rang=-1 then
     GrRepartition.GenereLigne(true,GrRepartition.Row,1);
   except
     abort;
   end;
end;

procedure TRepartitionResult.BtnSupprimerClick(Sender: TObject);
Begin
lignecurr:=GrRepartition.Row;
   if GrRepartition.RowCount-1=1 then
   begin
    if not empty(GrRepartition.Rows[1].Text)then
      GrRepartition.Rows[1].Clear;
   GrRepartitionSupprLigne(sender,1,lignecurr);
   end
   else
   GrRepartition.SupprimeLigne(lignecurr);
end;

procedure TRepartitionResult.BtnFermerClick(Sender: TObject);
begin
self.close;
end;

procedure TRepartitionResult.GrRepartitionStateChange(
  EtatGrille: TDataSetState);
begin
ChangementEtatBoutonsMenu(GrRepartition.EtatGrille);
if ((not GrRepartition.LigneVide(1))or(GrRepartition.RowCount>2)) then
  btnenregistrer.Enabled:=true
else
  btnenregistrer.Enabled:=false;
Enregister1.Enabled:=BtnEnregistrer.Enabled;
end;

procedure TRepartitionResult.GrRepartitionSupprLigne(sender: TObject;
  Arow: Integer; var NewRow: Integer);
begin
GrRepartitionStateChange(GrRepartition.EtatGrille);
end;

procedure TRepartitionResult.GrRepartitionColEnter(OldColonne, NewColonne,
  NewRow: Integer);
begin
case GrRepartition.col of
 2:begin
     if ((VerifNumeric(GrRepartition.Cells[3,NewRow]).Vide)and(not GrRepartition.LigneVide(NewRow))) then
       GrRepartition.Cells[3,NewRow]:=currtostr(MontantTotalAAffecter);
   end;
end;//fin du case
end;

procedure TRepartitionResult.Affecter1Click(Sender: TObject);
begin
case GrRepartition.Col of
  3:begin
     GrRepartition.cells[3,GrRepartition.row]:='0';//j'initialise pour ne pas que la valeur existante soit prise en compte dans le calcul
     GrRepartition.cells[3,GrRepartition.row]:=currtostr(CurSoldeCompteResultat.Value-SommeColonne(GrRepartition,ColonneMontantRepartition,1,GrRepartition.RowCount-1));
     if VerifNumeric(GrRepartition.cells[3,GrRepartition.row]).Neg then
     GrRepartition.cells[3,GrRepartition.row]:='0'; //je r�initialise car si valeur n�gative, �a veut dire qu'il ne reste plus rien � affecter.
    end;
end;//fin du case
end;

end.
