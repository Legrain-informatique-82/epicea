unit ListeEditions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, RXCtrls,DBTables, Db, jpeg, Buttons, Etat,
  Menus,Registry,ShellAPI;

type



  TParamAfficheListeEdition=record
    Titrefenetre:string;
    Titre:string;
    ParametreVisible:boolean;
    ModuleVisible:boolean;
  end;


  TE2_ListeEdition = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    LaTitre: TRxLabel;
    PaTitrePetit: TPanel;
    PaBtn: TPanel;
    Panel1: TPanel;
    PaModule: TPanel;
    PaEtats: TPanel;
    PaParam: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    BtnImprimer: TButton;
    btnFermer: TButton;
    PopupMenu1: TPopupMenu;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Fermer1: TMenuItem;
    RxTresorerie: TRxSpeedButton;
    RxDettes: TRxSpeedButton;
    RxCharges: TRxSpeedButton;
    RxTableauDeBord: TRxSpeedButton;
    RadioGroup1: TRadioGroup;
    btnAdobe: TButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);

    procedure ImprimerTresorerie(Sender: TObject);
    procedure ImprimerDettesEtCreances(Sender: TObject);
    procedure ImprimerChargesEtProduits(Sender: TObject);
    procedure btnFermerClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Enregister1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RxTresorerieClick(Sender: TObject);
    procedure RxDettesClick(Sender: TObject);
    procedure RxChargesClick(Sender: TObject);
    procedure RxTableauDeBordClick(Sender: TObject);
    procedure Panel8Resize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAdobeClick(Sender: TObject);
   // function verifExistenceAdobeReader(Affichemess:boolean=false):boolean;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
        TitreForm,SousTitreForm:String;
        EventButtonImprimerClick:TNotifyEvent;
  end;

var
  E2_ListeEdition: TE2_ListeEdition;

    ListeBoutons: array of TButton;
    Nombre: integer = 0;
    FormatEdition:string = 'pdf';
    Etat1:TEtat;
    function ListeEditionAffiche(ParamAfficheListeEdition:TParamAfficheListeEdition):boolean;
implementation

uses LibGestionParamXML, E2_Librairie_Obj, DMDiocEtatBalance,
  DmTableauBord, TableauDeBord, E2_Decl_Records, DMCorrection,
  LibChoixCompte, E2_Main, DMConstantes, DMProgramme, LibZoneSaisie,
  LibRessourceString, lib_chaine;

{$R *.dfm}
function ListeEditionAffiche(ParamAfficheListeEdition:TParamAfficheListeEdition):boolean;
begin
main.initialisationBirt;
if(E2_ListeEdition=nil)then E2_ListeEdition:=TE2_ListeEdition.Create(Application.MainForm);
E2_ListeEdition.LaTitre.Caption:=ParamAfficheListeEdition.Titre;
E2_ListeEdition.Caption:=ParamAfficheListeEdition.Titrefenetre;
E2_ListeEdition.PaModule.Visible:=ParamAfficheListeEdition.ModuleVisible;
E2_ListeEdition.PaParam.Visible:=ParamAfficheListeEdition.ParametreVisible;

result:=E2_ListeEdition.ShowModal=mrok;
end;

procedure TE2_ListeEdition.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,E.User);
E2_ListeEdition:=nil;
end;

procedure TE2_ListeEdition.FormCreate(Sender: TObject);
begin
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
    end;
end;





procedure TE2_ListeEdition.RadioGroup1Click(Sender: TObject);
begin
case RadioGroup1.ItemIndex of
 0:begin
    //verifExistenceAdobeReader(true);
    FormatEdition:='pdf';
   end;
 1:FormatEdition:='html';
 2:FormatEdition:='html';
 3:FormatEdition:='doc';
 4:FormatEdition:='xls';
end;//fin du case
end;








procedure TE2_ListeEdition.ImprimerTresorerie(Sender: TObject);
var
listeExo:Tstringlist;
ListeCpt:TResultStrList;
EtatFiltre:TEtatFiltre;
requete : TQuery;
ParamAffichCompte:TParamAffichCompte;
ParamAffiche:TParamAfficheTableauDeBord;
exercice1,exercice2,exercice3:TExercice;
motCle:string;
begin
if(e.ID_Dos=0)then
  showmessage(EditionDossierDemo)
else
begin
try
CoherenceBalance(nil);
ListeCpt.Liste:=TStringList.Create;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.DatabaseName :=DMDiocEtatBal.TaBalanceCalc.DatabaseName;

listeExo:=liste3DerniersExercices(listeExercice(e.ID_Dos,false));
if(listeExo.Count>0)then exercice1:=TExercice(listeExo.Objects[0]) else exercice1:=nil;
if(listeExo.Count>1)then exercice2:=TExercice(listeExo.Objects[1])else exercice2:=nil;
if(listeExo.Count>2)then exercice3:=TExercice(listeExo.Objects[2])else exercice3:=nil;
////requete.SQL.Add(' select * from balance b');
//requete.SQL.Add(' select * from "'+e.RepertoireDossier+'plancpt" P ');//on(P.compte = B.compte)
//requete.SQL.Add(' where p.compte like(''5%'') and substring(p.compte from 3)<>''''');

        requete.DatabaseName :=DM_C_NomAliasDossier;
        motCle:=' where (';
        requete.SQL.Add(' select distinct(P.compte),P.libelle,P.collectif,P.pointable from plancpt P ');
        if(Exercice1<>nil)then
          begin
            requete.SQL.Add(motCle+' exists(select * from "'+IncludeTrailingPathDelimiter(Exercice1.dir_exo)+'balance" b1 where b1.compte=P.compte) ');
            motCle:=' or';
          end;
        if(Exercice2<>nil)then
          begin
            requete.SQL.Add(motCle+' exists(select * from "'+IncludeTrailingPathDelimiter(Exercice2.dir_exo)+'balance" b2 where b2.compte=P.compte)');
            motCle:=' or';
          end;
        if(Exercice3<>nil)then
          begin
            requete.SQL.Add(motCle+' exists(select * from "'+IncludeTrailingPathDelimiter(Exercice3.dir_exo)+'balance" b3 where b3.compte=P.compte)');
            motCle:=' or';
          end;
        requete.SQL.Add(')');
        if(str_position('where',lowercase(requete.Text))<>-1) then motCle:=' and ' else motCle:=' where ';
        requete.SQL.Add(motCle+' p.compte like(''5%'')');
        requete.Open;

InitialiseParamAffichCompte(ParamAffichCompte);
ParamAffichCompte.Regrouper:=8;
ParamAffichCompte.Tiers:=false;
ParamAffichCompte.Dataset:=requete;
ParamAffichCompte.Titre:='Sélectionnez les comptes...';
ParamAffichCompte.ListeChamps.Add('compte');
ParamAffichCompte.ListeChamps.Add('libelle');
ParamAffichCompte.ListeChamps.Add('Collectif');
ParamAffichCompte.ListeChamps.Add('Pointable');

listecpt:=ChoixCompteAffich(ParamAffichCompte);
if ListeCpt.Result then
  begin
    ParamAffiche.navigation:=false;
  ParamAffiche.Nomfichier:=IncludeTrailingPathDelimiter(e.RepertoireDossier)+'test.xml';
  ParamAffiche.NomEdition:='Tresorerie.rptdesign';;
  ParamAffiche.FormatEdition := FormatEdition;
  if(DmTableauDeBord=nil)then DmTableauDeBord:=TDmTableauDeBord.Create(E2_TableauDeBord);

  DmTableauDeBord.InitialiseXML(ParamAffiche.Nomfichier);
  DmTableauDeBord.rempliXML_Tresorerie(listecpt.Liste,ParamAffichCompte.Regrouper);
  DmTableauDeBord.rempliXML_TresorerieMensuelle(listecpt.Liste,ParamAffichCompte.Regrouper);
  DmTableauDeBord.SauveXML(ParamAffiche.Nomfichier);

  TableauDeBordAffiche(ParamAffiche);
  end;

finally
  requete.close;
  requete.free;
end;
end;
end;

procedure TE2_ListeEdition.ImprimerDettesEtCreances(Sender: TObject);
var ParamAffichCompte:TParamAffichCompte;
ListeCpt:TResultStrList;
ParamAffiche:TParamAfficheTableauDeBord;
begin

  if(e.ID_Dos=0)then
  showmessage(EditionDossierDemo)
else
begin
  try
  InitialiseParamAffichCompte(ParamAffichCompte);
  ParamAffichCompte.Regrouper:=3;
  ListeCpt:=main.SelectionListeComptePourDettesEtCreances(ParamAffichCompte);
  if ListeCpt.Result then
    begin
    ParamAffiche.navigation:=false;
    ParamAffiche.Nomfichier:=IncludeTrailingPathDelimiter(e.RepertoireDossier)+'test.xml';
    ParamAffiche.NomEdition:='DettesEtCreances.rptdesign';
    ParamAffiche.FormatEdition := FormatEdition;
    if(DmTableauDeBord=nil)then DmTableauDeBord:=TDmTableauDeBord.Create(self);

    DmTableauDeBord.InitialiseXML(ParamAffiche.Nomfichier);
    DmTableauDeBord.rempliXML_DettesEtCreances(ListeCpt.Liste,ParamAffichCompte.Regrouper);
    DmTableauDeBord.SauveXML(ParamAffiche.Nomfichier);

    TableauDeBordAffiche(ParamAffiche);
   end;
  finally
  end;
end;  
end;


procedure TE2_ListeEdition.ImprimerChargesEtProduits(Sender: TObject);
var
ListeCpt:TResultStrList;
ParamAffiche:TParamAfficheTableauDeBord;
ParamAffichCompte:TParamAffichCompte;
requete:Tquery;
listeEx0:Tstringlist;
motCle:string;
begin

if(e.ID_Dos=0)then
  showmessage(EditionDossierDemo)
else
begin
try
CoherenceBalance(nil);
ListeCpt.Liste:=TStringList.Create;
ListeCpt.result:=true;
requete := TQuery.Create(self);



listeEx0:=liste3DerniersExercices(listeExercice(e.ID_Dos,false));

        requete.DatabaseName :=DM_C_NomAliasDossier;
//        motCle:=' where (';
        requete.SQL.Add(' select distinct(P.compte),P.libelle,P.collectif,P.pointable from plancpt P ');
//        if(listeEx0.Count>0)then
//          begin
//            requete.SQL.Add(motCle+' exists(select * from "'+IncludeTrailingPathDelimiter(TExercice(listeEx0.objects[0]).dir_exo)+'balance" b1 where b1.compte=P.compte) ');
//            motCle:=' or';
//          end;
//        if(listeEx0.Count>1)then
//          begin
//            requete.SQL.Add(motCle+' exists(select * from "'+IncludeTrailingPathDelimiter(TExercice(listeEx0.objects[1]).dir_exo)+'balance" b2 where b2.compte=P.compte)');
//            motCle:=' or';
//          end;
//        if(listeEx0.Count>2)then
//          begin
//            requete.SQL.Add(motCle+' exists(select * from "'+IncludeTrailingPathDelimiter(TExercice(listeEx0.objects[2]).dir_exo)+'balance" b3 where b3.compte=P.compte)');
//            motCle:=' or';
//          end;

requete.SQL.Add(' where( P.compte like(''6%'') or P.compte like(''7%'')) and substring(p.compte from 3)<>''''');
//requete.SQL.Add(' ) and P.compte like(''6%'') or P.compte like(''7%'') ');
requete.Open;



InitialiseParamAffichCompte(ParamAffichCompte);
ParamAffichCompte.Regrouper:=3;
ParamAffichCompte.Tiers:=false;
ParamAffichCompte.Dataset:=requete;
ParamAffichCompte.Titre:='Sélectionnez les comptes...';
ParamAffichCompte.ListeChamps.Add('compte');
ParamAffichCompte.ListeChamps.Add('libelle');
ParamAffichCompte.ListeChamps.Add('Collectif');
ParamAffichCompte.ListeChamps.Add('Pointable');

listecpt:=ChoixCompteAffich(ParamAffichCompte);

  if ListeCpt.Result then
    begin
    ParamAffiche.navigation:=false;
    ParamAffiche.Nomfichier:=IncludeTrailingPathDelimiter(e.RepertoireDossier)+'test.xml';
    ParamAffiche.NomEdition:='ChargesProduisResultat.rptdesign';
    ParamAffiche.FormatEdition := FormatEdition;
    if(DmTableauDeBord=nil)then DmTableauDeBord:=TDmTableauDeBord.Create(E2_TableauDeBord);

    DmTableauDeBord.InitialiseXML(ParamAffiche.Nomfichier);
    DmTableauDeBord.rempliXML_ChargesProduitsResultat(ListeCpt.Liste,ParamAffichCompte.Regrouper);
    DmTableauDeBord.SauveXML(ParamAffiche.Nomfichier);

    TableauDeBordAffiche(ParamAffiche);
   end;

finally
  requete.close;
  requete.free;
end;
end; 
end;



procedure TE2_ListeEdition.btnFermerClick(Sender: TObject);
begin
Self.Close;
end;

procedure TE2_ListeEdition.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
CanClose:=true;
end;

procedure TE2_ListeEdition.Enregister1Click(Sender: TObject);
begin
BtnImprimer.Click;
end;

procedure TE2_ListeEdition.FormActivate(Sender: TObject);
var
i:integer;
begin
//for i:=0 to PaEtats.ControlCount-1 do
//begin
//   if(PaEtats.Controls[i] is TRXSpeedButton)then
//   begin
//      if(TRXSpeedButton(PaEtats.Controls[i]).Down)then
//      begin
//        TRXSpeedButton(PaEtats.Controls[i]).Click;
//        exit;
//      end;
//   end;
//end;
end;

procedure TE2_ListeEdition.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if(key=vk_escape)then BtnFermer.Click();
end;

procedure TE2_ListeEdition.RxTresorerieClick(Sender: TObject);
begin
BtnImprimer.OnClick:=ImprimerTresorerie;
BtnImprimer.Click;
end;

procedure TE2_ListeEdition.RxDettesClick(Sender: TObject);
begin
BtnImprimer.OnClick:=ImprimerDettesEtCreances;
BtnImprimer.Click;
end;

procedure TE2_ListeEdition.RxChargesClick(Sender: TObject);
begin
BtnImprimer.OnClick:=ImprimerChargesEtProduits;
BtnImprimer.Click;
end;

procedure TE2_ListeEdition.RxTableauDeBordClick(Sender: TObject);
begin
//  inc(Nombre);
//  SetLength(ListeBoutons, Nombre+1);
//  ListeBoutons[Nombre] := TButton.Create(self);
//  with ListeBoutons[Nombre] do
//  begin
//    Parent := GroupBox2;
//    Left := Nombre*100+5;
//    Width := 100;
//    Caption := 'Bouton '+IntToStr(Nombre);
//  end;
Etat1:=TEtat.Create;
Etat1.EventButtonImprimerClick:=RxTresorerieClick;
end;

procedure TE2_ListeEdition.Panel8Resize(Sender: TObject);
begin
FormateTailleBoutton([btnFermer],PaBtn,90,0);
end;

procedure TE2_ListeEdition.FormShow(Sender: TObject);
begin
//if not verifExistenceAdobeReader then RadioGroup1.ItemIndex:=1
//else RadioGroup1.ItemIndex:=0;
end;

//function TE2_ListeEdition.verifExistenceAdobeReader(Affichemess:boolean):boolean;
//var
//Registre :TRegistry;
//begin
//try
//btnAdobe.visible:=false;
////interoger base de registre pour détecter adobe reader
// Registre:= TRegistry.Create;
// with Registre do
//   begin
//    RootKey := HKEY_LOCAL_MACHINE;
//    if not OpenKey('\SOFTWARE\Adobe\Acrobat Reader', false)then
//      begin
//        btnAdobe.visible:=true;
//        verifExistenceAdobeReader:=false;
//        if(Affichemess)then
//          Application.MessageBox(Pchar('Pour lire des fichiers pdf, il vous faut installer le logiciel Adobe Reader ou un logiciel équivalent'+
//          retourChariotSimple+'Vous pouvez le télécharger en cliquant sur le bouton installer Adobe.'),'Attention',MB_ICONEXCLAMATION +MB_OK+MB_DEFBUTTON1);
//      end;
//   end;
//except
//  verifExistenceAdobeReader:=false;
//end;
//end;

procedure TE2_ListeEdition.btnAdobeClick(Sender: TObject);
begin
//ShellExecute(0, 'open', 'http://get.adobe.com/fr/reader', NiL, NiL, SW_SHOWNORMAL);
end;

end.
