unit E2_Cloture_Def;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RXCtrls, StdCtrls, ExtCtrls,E2_Decl_Records,DMBaseDonnee,DMBalances,DMPiece,
  Gr_Librairie_Obj,{Gr_MultDos,} Grids, GrGrid,E2_Librairie_Obj,DMProgramme,DMRecherche,
  LibSQL,DMConstantes, ComCtrls, jpeg,DMTTVA,E2_LibInfosTable,
  LibRessourceString,
  LibGestionParamXML,
  LibZoneSaisie,
  LibDates,
  Variants,
  LibFichRep,
  E2_VisuListeView,
  Menus, Buttons;


type
TGEstInterfaceEvent=procedure(sender:TObject = nil) of object;

  TAppel=(F_VerifCloture,F_ChangtExo);

  TParamAfficheCloture=Record
    Affiche:Boolean;
    AffichageModal:Boolean;
    TypeAppel:TAppel;
    TitreForm:String;
    SousTitreForm:String;
  end;


  TCloture_Def = class(TForm)
    PaBtn: TPanel;
    PaBas: TPanel;
    BtnCloture: TButton;
    ProgressBar1: TProgressBar;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    Panel2: TPanel;
    Panel1: TPanel;
    BtnVerif: TButton;
    Panel3: TPanel;
    PaLeft: TPanel;
    PaAide: TPanel;
    MemoAide: TMemo;
    BtnResolution: TButton;
    BtnContinuer: TButton;
    Paclient: TPanel;
    RxCheckListBox1: TRxCheckListBox;
    BtnAnnuler: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    paverif: TPanel;
    PopupMenu1: TPopupMenu;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    Imprimer1: TMenuItem;
    Panel4: TPanel;
    Button1: TButton;
    procedure BtnVerifClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtnContinuerClick(Sender: TObject);
    procedure BtnClotureClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure etatinitial;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure PaAideResize(Sender: TObject);
    procedure Panel3Resize(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure BtnResolutionClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
  Protected
    { Déclarations protégées }
         FOnGEstInterfaceEvent:TGEstInterfaceEvent;
  public
    { Déclarations publiques }
    EtapeSuivante:integer;
    listeRetour:TRetourListeErreur;
    TypeAppel:TAppel;
    TitreForm:String;
    SousTitreForm:String;
    property OnGEstInterfaceEvent:TGEstInterfaceEvent read FOnGEstInterfaceEvent write FOnGEstInterfaceEvent;
  end;

var
  Cloture_Def: TCloture_Def;
  VerifEnCours:boolean;
  {EtapeSuivante,}etapeExit:integer;
  
    procedure InitialiseTableauEcart(ErreurCloture:Tlist);
  procedure ClotureDefActivate;

  Function ClotureAffiche(ParamAfficheCloture:TParamAfficheCloture):Boolean;

implementation
uses DMClotures, E2_Main{,DMImmo_Clot},DMParamEnt, DMImportation,
  DMImmo_Clot;
{$R *.DFM}

procedure TCloture_Def.BtnVerifClick(Sender: TObject);
var
listeRetourTmp:TRetourListeErreur;
i,j:integer;
EtapeSuivanteTmp:integer;
begin
try//finally
 listeRetourTmp.ListErreur:=Tlist.Create;
 listeRetour.ListErreur:=Tlist.Create;
// if sender<>nil then
//   EtapeSuivante:=0;
if ((sender<>nil)or(not VerifEnCours)) then
   etatinitial;
 VerifEnCours:=true;
 BtnContinuer.Enabled:=true;
 BtnContinuer.SetFocus;
 EtapeSuivanteTmp:=EtapeSuivante;
 listeRetour:=DMCloture.VerifAvantCloture(100);
 EtapeSuivante:=EtapeSuivanteTmp;
 for i:=EtapeSuivante to listeRetour.NbProcedure do
   Begin
    listeRetourTmp:=DMCloture.VerifAvantCloture(i);
    if RxCheckListBox1.Items.IndexOf(PListCloture(listeRetourTmp.ListErreur.items[0])^.TitreListe)=-1 then
      begin
        //alimenter la checklist des vérifs effectuées
        RxCheckListBox1.items.Add(PListCloture(listeRetourTmp.ListErreur.items[0])^.TitreListe);
        RxCheckListBox1.EnabledItem[RxCheckListBox1.items.count-1]:=false;
      end;
     if not PListCloture(listeRetourTmp.ListErreur.items[0])^.erreur.retour then
       begin
       @OnGEstInterfaceEvent:=PListCloture(listeRetourTmp.ListErreur.items[0])^.AdresseTraitement;
       
//       @BtnResolution.OnClick:=PListCloture(listeRetourTmp.ListErreur.items[0])^.AdresseTraitement;
       BtnResolution.Caption:=PListCloture(listeRetourTmp.ListErreur.items[0])^.TitreBouton;
       BtnResolution.Enabled:=true;
       MemoAide.Lines.Text:=PListCloture(listeRetourTmp.ListErreur.items[0])^.messages.MessageErreur;
       if TypeAppel=F_VerifCloture then
         MemoAide.Lines.Text:=MemoAide.Lines.Text+PListCloture(listeRetourTmp.ListErreur.items[0])^.messages.MessageQuestion;
       j:=RxCheckListBox1.Items.IndexOf(PListCloture(listeRetourTmp.ListErreur.items[0])^.TitreListe);
       if j<>-1 then
          RxCheckListBox1.Checked[j]:=PListCloture(listeRetourTmp.ListErreur.items[0])^.erreur.CodeErreur=4;
       DMCloture.JournalErreur.Add(PListCloture(listeRetourTmp.ListErreur.items[0])^.TitreListe);
       if RxCheckListBox1.Checked[j]=true then DMCloture.JournalErreur.Add('OK') else
         DMCloture.JournalErreur.Add(MemoAide.Lines.Text);
       DMCloture.JournalErreur.Add(LigneSeparation);
       if not (PListCloture(listeRetourTmp.ListErreur.items[0])^.erreur.CodeErreur=4) then
         begin
           etapeExit:=i;
           BtnCloture.Enabled:=false;
           etapeSuivante:=etapeExit;
           exit;
         end;
       end
     else
       Begin //si pas de problème
           //BtnResolution.OnClick:=nil;
           OnGEstInterfaceEvent:=nil;
           BtnResolution.Caption:='';
           BtnResolution.Enabled:=false;
           MemoAide.Lines.Text:='';
           j:=RxCheckListBox1.Items.IndexOf(PListCloture(listeRetourTmp.ListErreur.items[0])^.TitreListe);
           if j<>-1 then
             RxCheckListBox1.Checked[j]:=true;
           DMCloture.JournalErreur.Add(PListCloture(listeRetourTmp.ListErreur.items[0])^.TitreListe);
           DMCloture.JournalErreur.Add('OK') ;
       DMCloture.JournalErreur.Add(LigneSeparation);
       End;
   End;
listeRetour:=DMCloture.VerifAvantCloture;
 for i:=0 to listeRetour.ListErreur.Count-1 do
   Begin
     if ((not PListCloture(listeRetour.ListErreur.items[i])^.erreur.retour)and(PListCloture(listeRetour.ListErreur.items[i])^.Obligatoire)) then
       begin
//       @BtnResolution.OnClick:=PListCloture(listeRetour.ListErreur.items[i])^.AdresseTraitement;
       @OnGEstInterfaceEvent:=PListCloture(listeRetour.ListErreur.items[i])^.AdresseTraitement;
       BtnResolution.Caption:=PListCloture(listeRetour.ListErreur.items[i])^.TitreBouton;
       BtnResolution.Enabled:=true;
       BtnCloture.Enabled:=false;
       MemoAide.Lines.Text:=PListCloture(listeRetour.ListErreur.items[i])^.messages.MessageErreur;
       if TypeAppel=F_VerifCloture then
         MemoAide.Lines.Text:=MemoAide.Lines.Text+PListCloture(listeRetour.ListErreur.items[i])^.messages.MessageQuestion;
       etapeExit:=i;
       etapeSuivante:=etapeExit;
       exit;
       end;
   end;
 MemoAide.Lines.Text:='La véfification de vos opérations de clôture est terminée';
 if TypeAppel=F_ChangtExo then
   MemoAide.Lines.Text:=MemoAide.Lines.Text+ RetourChariotDouble+ 'Vous pouvez maintenant changer d''exercice en cliquant sur le bouton "Clôture définitive"';
 BtnCloture.Enabled:=true;
 BtnContinuer.Enabled:=false;
 if BtnCloture.CanFocus then
   BtnCloture.SetFocus
 else
   BtnFermer.SetFocus;
finally
  //creer le journal de cloture comprenant toutes les erreurs rencontrées dans le changement d''exercice
    DMCloture.JournalErreur.SaveToFile(e.RepertoireDossier+C_Cloture_Exercice+e.NomExo+'.TXT');
end;//fin finally
end;

procedure TCloture_Def.FormCreate(Sender: TObject);
begin

  if DMCloture=nil then
  DMCloture:=TDMCloture.Create(application.MainForm);
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
etatinitial;
end;

procedure TCloture_Def.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
caption:=TitreForm;
RxLabTitre.caption:=SousTitreForm;

  if VerifEnCours then
    BtnVerifClick(nil);//je mets nil pour differencier l'appel de la procédure par l'utilisation
    //ou par une autre procedure
end;

procedure TCloture_Def.BtnContinuerClick(Sender: TObject);
begin
if EtapeSuivante=etapeExit then
  EtapeSuivante:=etapeExit+1
else
  EtapeSuivante:=etapeExit;
 if VerifEnCours then
   begin
      MemoAide.Clear;
      //ListViewResult.Visible:=false;
      BtnVerifClick(nil);
   end;
end;

procedure TCloture_Def.BtnClotureClick(Sender: TObject);
begin
if(DMCloture.ClotureDefinitiveExercice(e.RepertoireDossier,e.NomDossier,e.NomExo).retour=true)then
  ModalResult:=mrOk
  else ModalResult:=mrcancel;
end;
procedure TCloture_Def.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
etatinitial;
canclose:=true;
end;


procedure TCloture_Def.etatinitial;
Begin
if DMCloture.JournalErreur=nil then DMCloture.JournalErreur:=Tstringlist.Create
else DMCloture.JournalErreur.clear;
caption:=TitreForm;
BtnContinuer.Enabled:=false;
RxLabTitre.caption:=SousTitreForm;
RxCheckListBox1.Clear;
OnGEstInterfaceEvent:=nil;
//BtnResolution.OnClick:=nil;
BtnResolution.Caption:='';
BtnResolution.Enabled:=false;
EtapeSuivante:=0;
etapeExit:=0;
VerifEnCours:=false;
BtnContinuer.Enabled:=false;
BtnCloture.Enabled := false;
BtnResolution.Visible:=TypeAppel=F_VerifCloture;
BtnCloture.Visible:=TypeAppel=F_ChangtExo;
if listeRetour.ListErreur=nil then
  listeRetour.ListErreur:=Tlist.Create
else
  listeRetour.ListErreur.clear;

MemoAide.Clear;
MemoAide.Lines.Add('Avant de faire le changement d''exercice, Epicéa va');
MemoAide.Lines.Add('vérifier votre dossier.');
MemoAide.Lines.Add('');
MemoAide.Lines.Add('');
MemoAide.Lines.Add('Pour commencer la vérification, cliquez sur le bouton');
MemoAide.Lines.Add('ci-dessus, puis suivez les instructions unes à unes');
 if visible then
   BtnVerif.SetFocus;

//ListViewResult.Clear;
//ListViewResult.Visible:=false;
End;


procedure TCloture_Def.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
If Key = VK_ESCAPE Then
   Begin
      close;
   end;
end;


procedure ClotureDefActivate;
Begin
 if (Cloture_Def <> nil) then
 if  Cloture_Def.Visible then
    begin
     Cloture_Def.Activate;
    end;
End;

procedure InitialiseTableauEcart(ErreurCloture:Tlist);
var
i:integer;
fichierTmp:Tstringlist;
ParamAffichage:TParamAffichage;
Begin
try
fichierTmp:=conversionTlistToTStringlit(ErreurCloture,'TListErreur');
                      Initialise_TParamAffichage(ParamAffichage);
                      ParamAffichage.AffichModal := true;
                      ParamAffichage.Titre:='Tableau de comparaison ';
                      ParamAffichage.GestionAffichForm.Caption := ParamAffichage.Titre;
                      AfficheVisuListView(ParamAffichage,['Compte','Solde Immos','compte','solde balance'],
                                                         [200,150,200,150],
                                                         [fichierTmp],
                                                         [taLeftJustify,taRightJustify,taLeftJustify,taRightJustify],
                                                         [1,3],
                                                         [2,4],[0]);
finally
   if fichierTmp<>nil then fichierTmp.Free;
end;


//GrGridCloture.rowcount:=ErreurCloture.count+1;
//
//GrGridCloture.Visible:=true;
//GrGridCloture.Align:=alClient;
//
//GrGridCloture.Cells[0,0]:='Compte dans immo';
//GrGridCloture.Cells[1,0]:='solde dans immo';
//GrGridCloture.Cells[2,0]:='compte dans compta';
//GrGridCloture.Cells[3,0]:='solde dans balance';
//
//for i:=0 to ErreurCloture.count-1 do
//  Begin
//    GrGridCloture.Cells[0,i+1]:=PListErreur(ErreurCloture.Items[i])^.CompteImmo;
//    GrGridCloture.Cells[1,i+1]:=currtostr(PListErreur(ErreurCloture.Items[i])^.SoldeImmo);
//    GrGridCloture.Cells[2,i+1]:=PListErreur(ErreurCloture.Items[i])^.ComptePlan;
//    GrGridCloture.Cells[3,i+1]:=currtostr(PListErreur(ErreurCloture.Items[i])^.SoldePlan);
//  End;

//PaAideResize(PaAide);

End;


procedure TCloture_Def.FormDestroy(Sender: TObject);
begin
  LibGestionParamXML.DestroyForm(Self,E.USer);
    LibereObjet(Tobject(listeRetour.ListErreur),Self);
  Cloture_Def:=nil;
end;

procedure TCloture_Def.PaAideResize(Sender: TObject);
begin
//if GrGridCloture.Visible then
//  Begin
//     FormateTailleColonne_GrGrid(GrGridCloture,17,[4,4,4,4]);
//  end
//else
//  Begin
//
//  end;
end;



procedure TCloture_Def.Panel3Resize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TCloture_Def.BtnAnnulerEnter(Sender: TObject);
begin
 BouttonDiminue(sender as TButton);
end;

procedure TCloture_Def.BtnAnnulerExit(Sender: TObject);
begin
 BouttonAgrandit(sender as TButton);
end;

procedure TCloture_Def.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TCloture_Def.BtnFermerClick(Sender: TObject);
begin
self.close;
end;

procedure TCloture_Def.BtnImprimerClick(Sender: TObject);
var
ListeTmp:Tstringlist;
i:integer;
ParametreEdition:TParametreEdition;
begin
ListeTmp := Tstringlist.Create;
try//finally
  for i:=0 to RxCheckListBox1.Items.Count-1 do
    ListeTmp.add(RxCheckListBox1.Items[i]);
if ListeTmp.Count<>0 then
  begin
     if VisuListeView = nil then VisuListeView:=TVisuListeView.create(Application.MAinForm);

     ParametreEdition.ParamEdition.AffichDefaut:=true;
     ParametreEdition.ParamEdition.Titre:='Listes des vérifications';
     ParametreEdition.ParamEdition.TitrePetit:='';

     SetLength(ParametreEdition.TabTitreColonne,1);
     ParametreEdition.TabTitreColonne[0]:='Ecran vérifié';

     SetLength(ParametreEdition.LargeurCol,1);
     ParametreEdition.LargeurCol[0]:=500;

     SetLength(ParametreEdition.TabList,1);
     ParametreEdition.TabList[0]:=ListeTmp;

     SetLength(ParametreEdition.Alignement,1);
     ParametreEdition.Alignement[0]:=taLeftJustify;
     
     VisuListeView.RemplitParametreEdition(ParametreEdition.ParamEdition,ParametreEdition.TabTitreColonne,ParametreEdition.LargeurCol,ParametreEdition.TabList,ParametreEdition.Alignement);
     VisuListeView.ImprimerListe;
  end;


 // VisuListeView.Caption := 'Listes des vérifications ';
// VisuListeView.RxLabTitre.Caption :='Listes des vérifications ';;
// VisuListeView.PaTitrePetit.Caption :='Listes des vérifications ';
//  VisuListeView.ListView1.Columns.Clear;
// VisuListeView.ListView1.Items.Clear;
//
// VisuListeView.ListView1.Columns.add.Caption :='Vérifications';
// VisuListeView.ListView1.Checkboxes:=true;
//
//  InitLisViewAvecListe(VisuListeView.ListView1,[''],[ListeTmp],True);
// VisuListeView.ShowModal;

finally
  if ListeTmp<>nil then ListeTmp.Free;
end;//fin finally


end;


Function ClotureAffiche(ParamAfficheCloture:TParamAfficheCloture):Boolean;
//var
//ParamDMCloture:TParamDMCloture;
Begin
 if (Cloture_Def = nil) then Cloture_Def:=TCloture_Def.Create(Application.MainForm);
 Cloture_Def.Close;
 Cloture_Def.TypeAppel:=ParamAfficheCloture.TypeAppel;
 if not empty(ParamAfficheCloture.TitreForm) then
   Cloture_Def.TitreForm:=ParamAfficheCloture.TitreForm;
 Cloture_Def.SousTitreForm:=ParamAfficheCloture.SousTitreForm;
 Cloture_Def.OnGEstInterfaceEvent:=Cloture_Def.BtnResolutionClick;
 Cloture_Def.etatinitial;

 Cloture_Def.Button1.Visible:=Type_version_execution=CT_DEVELOPPEMENT;

 if ParamAfficheCloture.Affiche then
  begin
   if ParamAfficheCloture.AffichageModal then
     begin
     Cloture_Def.ShowModal;
     Initialiser_ShortCut_Main(false);
     end
    else
     Cloture_Def.Show;
  end;
End;

procedure TCloture_Def.BtnResolutionClick(Sender: TObject);
var
MonoFenetreTmp:boolean;
Reinitialiser:boolean;
begin
Reinitialiser:=true;
try//finally
 Try//except
   MonoFenetreTmp:=Main.Monofenetrage;
   Main.Monofenetrage:=true;
   inherited;
   //Reinitialiser:=not (DMCloture.MethodName(@Cloture_Def.OnGEstInterfaceEvent)='TraitementCloture7002');
   if Reinitialiser then Reinitialiser:=not (DMImmo_Clo.MethodName(@Cloture_Def.OnGEstInterfaceEvent)='TraitementCloture2');
   if assigned(FOnGEstInterfaceEvent) then
     begin
     FOnGEstInterfaceEvent;
     end;
 Except
  abort
 End;// Fin du Try
finally
Main.Monofenetrage:=MonoFenetreTmp;
if ((TypeAppel=F_ChangtExo)and(Reinitialiser)) then
etatinitial
else
Cloture_Def.Activate;
end;//fin finally
end;

procedure TCloture_Def.Button1Click(Sender: TObject);
begin
//VerrouillageDeclaration_Exercice(strtodate('31/12/03'));
end;

end.
