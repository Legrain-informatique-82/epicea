unit E2_RegulTva;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RXCtrls, ExtCtrls, StdCtrls, Grids, DBGrids, RXDBCtrl, ExRxDBGrid,
  GrDBGrid, Menus,E2_Librairie_Obj,LibZoneSaisie,Gr_Librairie_Obj,DMConstantes,
  ComCtrls,E2_Decl_Records,Lib_Chaine, LibGestionParamXML, jpeg,
  Printers,
  ObjetEdition,
  E2_LibInfosTable,
  LibSQL,
  LibRessourceString,
  DB,DBTables,
  DMTTVA,
  E2_VisuListeView,
  LibDates;

type
  TRegulTVA = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaTitrePetit: TPanel;
    PaBtn: TPanel;
    BtnImprimer: TButton;
    BtnEnregistrer: TButton;
    PaGrille: TPanel;
    ListViewResult: TListView;
    PopupMenu1: TPopupMenu;
    DtailsF71: TMenuItem;
    Imprimer1: TMenuItem;
    Enregister1: TMenuItem;
    Imprimerlaselection1: TMenuItem;
    BtnDetail: TButton;
    PaBas: TPanel;
    RxLabel1: TRxLabel;
    Panel1: TPanel;
    Panel3: TPanel;
    HeadChoixColonneRech: THeaderControl;
    Panel4: TPanel;
    Panel2: TPanel;
    RxLabColRech: TRxLabel;
    PaRecherche: TPanel;
    BtnAnnuler: TButton;
    Exporter1: TMenuItem;
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure RemplitParametreEdition(ParamEditionTmp:TParamEdition;
                               TabTitreColonne:array of string;
                               LargeurCol:Array of Integer;
                               TabList:array of TStringList;
                               Alignement:Array of TAlignment);
    Procedure ImprimerListe(selection:boolean=false);
    procedure BtnImprimerClick(Sender: TObject);
    procedure ListViewResultChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure DtailsF71Click(Sender: TObject);
    procedure ListViewResultCompare(Sender: TObject; Item1,
      Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure ListViewResultColumnClick(Sender: TObject;
      Column: TListColumn);
    procedure Imprimerlaselection1Click(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure PaBtnClick(Sender: TObject);
    procedure ListViewResultKeyPress(Sender: TObject; var Key: Char);
    procedure HeadChoixColonneRechSectionClick(
      HeaderControl: THeaderControl; Section: THeaderSection);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure Exporter1Click(Sender: TObject);
  private
    { Déclarations privées }
    FState:Tdatasetstate;
  public
    { Déclarations publiques }
    TabStr,TabCurr,TabDate : set of Byte;
    IndiceCol:Integer;

    ParamAffichage_Ecran:TParamAffichage;
    ParamEdition:TParamEdition;
    TabTitreColonne_Ecran:array of string;
    LargeurCol_Ecran:TabInteger;
    TabList_Ecran:TabStringList;
    Alignement_Ecran:TabAlignment;
    TabStr_Ecran,TAbCurr_Ecran,TabDate_Ecran:TEnsembleByte;
    ListeGlobal:Tstringlist;

    property State:Tdatasetstate read FState;

  end;

var
  RegulTVA: TRegulTVA;
  Function AffichInfoControleTVA_En_Attente(Affiche:boolean=true):boolean;
  Function AffichDetailJustifieControleTVA_En_Attente(Affiche:boolean;CodeTva:string;DatefinPeriode:Tdate):boolean;

implementation
uses dmrecherche ,dmcorrection, E2_Main,DMExports;
{$R *.dfm}
function CustomSortFloatProcAsc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
result := 0;
if StrToFloat(TListItem(Item1).SubItems.Strings[ParamSort]) < StrToFloat(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=-1;
if StrToFloat(TListItem(Item1).SubItems.Strings[ParamSort]) > StrToFloat(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=1;
end;

function CustomSortFloatProcDesc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
result := 0;
if StrToFloat(TListItem(Item1).SubItems.Strings[ParamSort]) < StrToFloat(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=-1;
if StrToFloat(TListItem(Item1).SubItems.Strings[ParamSort]) > StrToFloat(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=1;
result:=-result;
end;

function CustomSortDateProcAsc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
result := 0;
if StrToDate(TListItem(Item1).SubItems.Strings[ParamSort]) < StrToDate(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=-1;
if StrToDate(TListItem(Item1).SubItems.Strings[ParamSort]) > StrToDate(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=1;
end;

function CustomSortDateProcDesc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
result := 0;
if StrToDate(TListItem(Item1).SubItems.Strings[ParamSort]) < StrToDate(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=-1;
if StrToDate(TListItem(Item1).SubItems.Strings[ParamSort]) > StrToDate(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=1;
result:=-result;
end;

function CustomSortCurrProcAsc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
result := 0;
if StrToCurr_lgr(TListItem(Item1).SubItems.Strings[ParamSort]) < StrToFloat(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=-1;
if StrToFloat(TListItem(Item1).SubItems.Strings[ParamSort]) > StrToFloat(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=1;
end;

function CustomSortCurrProcDesc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
result := 0;
if StrToFloat(TListItem(Item1).SubItems.Strings[ParamSort]) < StrToFloat(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=-1;
if StrToFloat(TListItem(Item1).SubItems.Strings[ParamSort]) > StrToFloat(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=1;
result:=-result;
end;

Function AffichInfoControleTVA_En_Attente(Affiche:boolean):boolean;
var
List1:TStringList;
i,id,id_Decl:integer;
solde,TauxTva,HTRecup:currency;
CodeTva:string;
begin
try
List1:=TStringList.Create;
if FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'ControleTvaEnAttente.txt') then
  List1.LoadFromFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'ControleTvaEnAttente.txt')
else
    showmessage('Le fichier n''existe pas.');
result:= List1.Count<>0;
if result then
  begin
     if RegulTVA= nil then RegulTVA:=TRegulTVA.Create(application.MainForm);
     RegulTVA.ListeGlobal:=InitLisViewAvecListe(RegulTVA.ListViewResult,['Code tva','Compte tva','Déclaré','En attente','Total','Solde balance','Différence','Justifié','Pris'],[List1],true);
     RegulTVA.TabStr:=[1,2,8];
RegulTVA.TabCurr:=[3..7,9];
RegulTVA.TabDate:=[];

     result:=RegulTVA.ShowModal=mrok;
     if result then
       Begin
              ReinitialisationH_Tva_AvantControle;
              for i:=0 to RegulTVA.ListViewResult.Items.Count-1 do
                Begin
                   id_Decl:=strtoint_lgr(RegulTVA.ListViewResult.Items[i].SubItems.Strings[RegulTVA.ListViewResult.Items[i].SubItems.Count-1]);
                   //on transforme la liste initiale pour récupérer l'id déclaration éventuellement modifiés!!!
                   list1.Strings[i]:=str_Setstringelement(list1.Strings[i],9,';',inttostr_lgr(id_decl));
                   solde:=strtocurr_lgr(RegulTVA.ListViewResult.Items[i].SubItems.Strings[RegulTVA.ListViewResult.Items[i].SubItems.Count-3]);
                   if ((abs(solde)>0)and(id_Decl=-3)) then
                     begin//si solde <>0
                         DeFiltrageDataSet(DMRech.TaH_TVARech);
                         DMRech.TaH_TVARech.Refresh;
                         id:=MaxId_Query(DMRech.TaH_TVARech,'ID');
                         DeFiltrageDataSet(dmrech.TaH_TVARech);
                         DeFiltrageDataSet(DMRech.TaTvaCodeRech);
                         TauxTva:=Infos_TInfosTvaCode(dmrech.TaTvaCodeRech,'TvaCode',[RegulTVA.ListViewResult.Items[i].SubItems.Strings[0]]).Taux_Supp;
                         HTRecup:=0;
                         if TauxTva<>0 then
                            HTRecup:= (solde*100)/TauxTva;
                         HTRecup:=arrondi(HTRecup,2);
                         DMcorrections.QuCorrectionInsert.Close;
                         DMcorrections.QuCorrectionInsert.DatabaseName:=DM_C_NomAliasDossier;                                           //  Debut_Periode,Fin_Periode,
                         DMcorrections.QuCorrectionInsert.SQL.Clear;
                         DMcorrections.QuCorrectionInsert.SQL.add('insert into H_Tva');
                         DMcorrections.QuCorrectionInsert.SQL.add('(Part_declaree,Taux,id,id_Ecriture,ID_Declaration,verrouillee,deverrouillable,en_attente,Montanttva,HTDeclare,Divers,CodeCompensation)');
                         DMcorrections.QuCorrectionInsert.SQL.add('values(1,'+str_QueDesChiffresCurr_SQL(Floattostr(TauxTva))+','+inttostr(ID)+','+inttostr_lgr(id_Decl)+','+inttostr_lgr(id_Decl)+',''True'',''True'',''false'','
                                                                  +str_QueDesChiffresCurr_SQL(currtostr(solde))+','+str_QueDesChiffresCurr_SQL(currtostr(HTRecup))+','''+
                                                                  RegulTVA.ListViewResult.Items[i].SubItems.Strings[0]+'_'
                                                                  +RegulTVA.ListViewResult.Items[i].SubItems.Strings[1]+'_'
                                                                  +inttostr_lgr(id_Decl)
                                                                  +' _'+inttostr(ID)+''','''+RegulTVA.ListViewResult.Items[i].SubItems.Strings[0]+''')');
                         DMcorrections.QuCorrectionInsert.ExecSQL;
                     end;//fin si solde <>0
                end;
       end;
  End;
finally
  DeleteFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'ControleTvaEnAttente.txt');
  list1.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'ControleTvaEnAttente.txt');
  if list1<>nil then list1.free;
  RegulTVA.free;
end;//fin du try finally
End;

procedure TRegulTVA.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,E.User);
RegulTVA:=nil;
end;

procedure TRegulTVA.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
if not(fstate = dsedit) then ModalResult :=mrCancel;
if ((ModalResult <>mrok)and(Fstate = dsedit)) then
  Begin
    if Application.MessageBox(Pchar('Voulez-vous prendre en compte les modifications ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
      ModalResult:=mrok;
  end;
 BtnDetail.OnClick:=nil;
 PaGrille.OnResize:=nil;
 RegulTVA.ListViewResult.OnChange:=nil;
 RegulTVA.ListViewResult.OnChanging:=nil;
 canclose:=true;
end;

procedure TRegulTVA.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
WinSuivPrec(Handle,key,[ListViewResult]);
  if Key = VK_ESCAPE then
   begin
      Key:= 0;                   
      Self.Close;
   end;
end;

procedure TRegulTVA.BtnAnnulerEnter(Sender: TObject);
begin
  BouttonDiminue(sender as TButton);
end;

procedure TRegulTVA.BtnAnnulerExit(Sender: TObject);
begin
  BouttonAgrandit(sender as TButton);
  PaBtnResize(PaBtn);
end;


procedure TRegulTVA.PaBtnResize(Sender: TObject);
begin
  FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnImprimer,BtnDetail],PaBtn,90,0);
end;

procedure TRegulTVA.FormCreate(Sender: TObject);
begin
  try
      OrdreTri:=1;
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;

procedure TRegulTVA.FormShow(Sender: TObject);
begin
  if @PaGrille.OnResize <> nil then
  PaGrille.OnResize(pagrille);
end;

procedure TRegulTVA.FormActivate(Sender: TObject);
var
i:integer;
begin
try
RegulTVA.ListViewResult.OnChange:=nil;
ListViewResult.SetFocus;
for i:=0 to ListViewResult.Items.Count-1 do
  Begin
    if ListViewResult.items[i].SubItems.Strings[8]='-3'then
      ListViewResult.items[i].Checked:=true
    else
      ListViewResult.items[i].Checked:=false;
  end;
finally
  RegulTVA.ListViewResult.OnChange:=RegulTVA.ListViewResultChange;
end;
end;


Procedure TRegulTVA.ImprimerListe(selection:boolean);
var
	x,i,j: integer;
  TimerPrn:TObjetEdition;//The TimerPrn is used for displaying the image at the top of the form
  Prn: TObjetEdition;	// The Prn object is used to print the examples
  imagelogo:Timage;
  ListeTmp:Tstringlist;
begin
//Showmessage('Non implémenté dans cette version !');
//imagelogo:=timage.Create(self);
//imagelogo.Picture.LoadFromFile(e.RepertoireProgram+'Logo.bmp');
////
try
TimerPrn := TObjetEdition.Create(application.MainForm);
ListeTmp:=Tstringlist.Create;
  with TimerPrn do
   begin
    AutomaticPaging := false;
    Name := 'TimerPrn';
    PrintPageNumbers := false;
//    Title := 'Test 2';
  end;
///

  Prn := TObjetEdition.Create(application.MainForm);

//Prn.EditionListe(ParamAffichage_Ecran,TabTitreColonne_Ecran,LargeurCol_Ecran,
//              TabList_Ecran,Alignement_Ecran,TabStr_Ecran,TAbCurr_Ecran,TabDate_Ecran,imagelogo);

  //si on veut initialiser nous même l'impression (ex: Portrait ou paysage), il faut mettre false dans
  //AffichDefaut
  ParamEdition.AffichDefaut:=False;
  prn.Orientation:=poPortrait;
  if high(TabList_Ecran)<=0 then
    Begin//construction de la liste à partir de la liste de l'écran
       for i:=0 to ListViewResult.Items.Count-1 do
         Begin
           if selection then
             Begin
                if ListViewResult.Items[i].Selected then
                   Begin
                       ListeTmp.AddObject('',ListViewResult.Items[i]);
                       for j:=0 to ListViewResult.Items[i].SubItems.Count-1 do
                         Begin
                            ListeTmp.Strings[ListeTmp.count-1]:=ListeTmp.Strings[ListeTmp.count-1]+ListViewResult.Items[i].SubItems.Strings[j]+';';
                         end;
                   end;
             end
           else
             Begin
                 ListeTmp.AddObject('',ListViewResult.Items[i]);
                 for j:=0 to ListViewResult.Items[i].SubItems.Count-1 do
                   Begin
                      ListeTmp.Strings[ListeTmp.count-1]:=ListeTmp.Strings[ListeTmp.count-1]+ListViewResult.Items[i].SubItems.Strings[j]+';';
                   end;
             end;
         end;
      SetLength(TabList_Ecran,1);
      TabList_Ecran[0]:=ListeTmp ;
    end;
Prn.EditionListe(ParamEdition,TabTitreColonne_Ecran,LargeurCol_Ecran,
              TabList_Ecran,Alignement_Ecran,TabStr_Ecran,TAbCurr_Ecran,TabDate_Ecran,nil);
finally
  ListeTmp.Free;
  TimerPrn.destroy;
  Prn.destroy;
end;
end;


procedure TRegulTVA.RemplitParametreEdition(ParamEditionTmp:TParamEdition;
                               TabTitreColonne:array of string;
                               LargeurCol:Array of Integer;
                               TabList:array of TStringList;
                               Alignement:Array of TAlignment);
var
i:integer;
begin
        ParamEdition.Titre:=ParamEditionTmp.Titre;
        ParamEdition.TitrePetit:=ParamEditionTmp.TitrePetit;
        ParamEdition.AffichDefaut:=ParamEditionTmp.AffichDefaut;
        if high(TabTitreColonne)>-1 then
          begin
            SetLength(TabTitreColonne_Ecran,high(TabTitreColonne)+1);
            for i:=0 to high(TabTitreColonne) do TabTitreColonne_Ecran[i]:= TabTitreColonne[i];
          end;
        if high(LargeurCol)>-1 then
          begin
            SetLength(LargeurCol_Ecran,high(LargeurCol)+1);
            for i:=0 to high(LargeurCol) do LargeurCol_Ecran[i]:= LargeurCol[i];
          end;
        if high(TabList)>-1 then
          begin
            SetLength(TabList_Ecran,high(TabList)+1);
            for i:=0 to high(TabList) do TabList_Ecran[i]:= TabList[i];
          end;
        if high(Alignement)>-1 then
          begin
            SetLength(Alignement_Ecran,high(Alignement)+1);
            for i:=0 to high(Alignement) do Alignement_Ecran[i]:= Alignement[i];
          end;
        TabStr_Ecran:= TabStr;
        TAbCurr_Ecran:= TAbCurr;
        TabDate_Ecran:= TabDate;

end;


procedure TRegulTVA.BtnImprimerClick(Sender: TObject);
var
ListeTmp:Tstringlist;
i:integer;
ParametreEdition:TParametreEdition;
begin
ListeTmp := Tstringlist.Create;
try//finally
ListeTmp.LoadFromFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'ControleTvaEnAttente.txt');
if ListeTmp.Count<>0 then
  begin
     ParametreEdition.ParamEdition.AffichDefaut:=true;
     ParametreEdition.ParamEdition.Titre:='Listes des régularisations de TVA';
     ParametreEdition.ParamEdition.TitrePetit:='';
     RemplitParametreEdition(ParametreEdition.ParamEdition,
                             ['Code tva','Compte tva','Déclaré','En attente','Total','Solde balance','Différence','Justifié','type'],
                             [70,60,60,50,50,50,70,40,50],
                             [],
                             [taLeftJustify,taLeftJustify,taRightJustify,taRightJustify,taRightJustify,taRightJustify,taRightJustify,taRightJustify,taRightJustify]);
     ImprimerListe;
  end;

finally
  if ListeTmp<>nil then ListeTmp.Free;
end;//fin finally


end;

procedure TRegulTVA.ListViewResultChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
AllowChange:boolean;
changement:boolean;
begin
AllowChange:=true;
if Item<>nil then
  Begin
    if Item.SubItems.Count<>0 then
      Begin
        changement:=((Item.checked)and(Item.SubItems.Strings[8]='-4'))or((Item.checked=false)and(Item.SubItems.Strings[8]='-3'));
        if changement then
            begin
               AllowChange:=((Item.SubItems.Strings[7]='')or((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS')));
               if ((Item.SubItems.Strings[7]='*')and AllowChange and(Item.Checked)) then
                AllowChange:=Application.MessageBox(Pchar('Etes-vous sûr de vouloir prendre en compte cette régularisation dans votre déclaration de TVA ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes;
             if  AllowChange then
               if change=ctstate then FState:=dsedit;
            end;//si changement
       if  AllowChange then
         Begin
             if Item.Checked then Item.SubItems.Strings[8]:='-3'
             else Item.SubItems.Strings[8]:='-4';
         end
       else
         Begin
            if Item.SubItems.Strings[8]='-3'then
              Item.Checked:=true
            else
              Item.Checked:=false;
         end;
      end;
  end;
end;

procedure TRegulTVA.DtailsF71Click(Sender: TObject);
begin
if ListViewResult.selected<>nil then
  Begin
      if ListViewResult.selected.SubItems.Strings[ListViewResult.selected.SubItems.Count-2]='*' then
        AffichDetailJustifieControleTVA_En_Attente(true,ListViewResult.selected.SubItems.Strings[0],e.DateFinDeclarationTVA)
      else
        showmessage(Desole);
  end;
end;


Function AffichDetailJustifieControleTVA_En_Attente(Affiche:boolean;CodeTva:string;DatefinPeriode:Tdate):boolean;
var
ParamAffichage:TParamAffichage;
List1:TStringList;
i,id,id_Decl:integer;
solde,TauxTva,HTRecup:currency;
QuDetailJustifie:TQuery;
begin
try//finally
FiltrageDataSet(DMTmTVA.QuDec_Tva,'datePiece >'''+dateinfos(DatefinPeriode).DateStr+''' and tvadate <= '''+dateinfos(DatefinPeriode).DateStr+''' and tvatype = ''D''');
List1:=ChampTableVersListeEx(['TvaCode','TvaType','Part_declaration','TvaDate','Reference','CompteHT','Libelle','En_Attente','HT_Declare','TvaMontantDebit','TvaMontantCredit','Taux'],DMTmTVA.QuDec_Tva,';',true);

result:= List1.Count<>0;
if result then
  begin
     if RegulTVA= nil then RegulTVA:=TRegulTVA.Create(application.MainForm);
Initialise_TParamAffichage(ParamAffichage);
        ParamAffichage.AffichModal := true;
        ParamAffichage.EventButtonDetailClick:= DMTmTVA.Visualisation_DeclarationTVAClick;
        ParamAffichage.EventButtonValiderClick:=DMTmTVA.Visualisation_DeclarationTVAClick ;
        ParamAffichage.EventListViewDbleClick:=DMTmTVA.Visualisation_DeclarationTVAClick ;
        ParamAffichage.EventButtonImprimerClick:=DMTmTVA.Impression_DeclarationTVAClick;
        ParamAffichage.TitrePetit:='DU '+datetostr(DMTmTVA.DetailTVAAffichGlobal.Periode.DateDeb)+' AU '+datetostr(DMTmTVA.DetailTVAAffichGlobal.Periode.DateFin);

//     InitLisViewAvecListe(RegulTVA.ListViewResult,['Code tva','Compte tva','Déclaré','En attente','Total','Solde balance','Différence','Pris','Justifié'],[List1],true);
        result:=AfficheVisuListView(ParamAffichage,['Code','Type','Part','Date Tva','Piece','Compte','Libellé','Declare','HT Déclaré','Tva Débit','Tva Crédit','Taux'],
                                            [40,20,30,70,70,70,100,60,70,70,70,50],
                                            [List1],
                                            [taLeftJustify,taLeftJustify,taRightJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taRightJustify,taRightJustify,taRightJustify,taRightJustify],
                                            [1..3,5..8],
                                            [9..12],[4]).Retour;

  end;
finally
DeFiltrageDataSet(DMTmTVA.QuDec_Tva);
DMTmTVA.QuDec_Tva.close;
List1.Free;
end;//fin finally
end;


procedure TRegulTVA.ListViewResultCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
if DAta >= 0 then
compare:=OrdreTri*StrComp(PChar(Item1.SubItems.Strings[Data]),PChar(Item2.SubItems.Strings[Data]))
else
compare:=OrdreTri*StrComp(PChar(TListItem(Item1).Caption),PChar(TListItem(Item2).Caption));
end;

procedure TRegulTVA.ListViewResultColumnClick(Sender: TObject;
  Column: TListColumn);
begin
OrdreTri:=-OrdreTri;
  if Column.Index in TabStr  then
   begin
     if Column.Index > 0 then
        (sender as TListView).CustomSort(nil, Column.Index-1)
        else
        (sender as TListView).CustomSort(nil, -1)
  end;

  if OrdreTri > 0 then
  if Column.Index in TabCurr  then
   begin
     if Column.Index > 0 then
        (sender as TListView).CustomSort(@CustomSortFloatProcAsc, Column.Index-1)
        else
        (sender as TListView).CustomSort(@CustomSortFloatProcAsc, -1)
  end;

  if OrdreTri < 0 then
  if Column.Index in TabCurr  then
   begin
     if Column.Index > 0 then
        (sender as TListView).CustomSort(@CustomSortFloatProcDesc, Column.Index-1)
        else
        (sender as TListView).CustomSort(@CustomSortFloatProcDesc, -1)
  end;


  if OrdreTri > 0 then
  if Column.Index in TabDate  then
   begin
     if Column.Index > 0 then
        (sender as TListView).CustomSort(@CustomSortDateProcAsc, Column.Index-1)
        else
        (sender as TListView).CustomSort(@CustomSortDateProcAsc, -1)
  end;

  if OrdreTri < 0 then
  if Column.Index in TabDate  then
   begin
     if Column.Index > 0 then
        (sender as TListView).CustomSort(@CustomSortDateProcDesc, Column.Index-1)
        else
        (sender as TListView).CustomSort(@CustomSortDateProcDesc, -1)
  end;
end;



procedure TRegulTVA.Imprimerlaselection1Click(Sender: TObject);
var
ListeTmp:Tstringlist;
i:integer;
ParametreEdition:TParametreEdition;
begin
ListeTmp := Tstringlist.Create;
try//finally
ListeTmp.LoadFromFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'ControleTvaEnAttente.txt');
if ListeTmp.Count<>0 then
  begin
     ParametreEdition.ParamEdition.AffichDefaut:=true;
     ParametreEdition.ParamEdition.Titre:='Listes des régularisations de TVA';
     ParametreEdition.ParamEdition.TitrePetit:='';
     RemplitParametreEdition(ParametreEdition.ParamEdition,
                             ['Code tva','Compte tva','Déclaré','En attente','Total','Solde balance','Différence','Justifié','type'],
                             [70,60,60,50,50,50,70,40,50],
                             [],
                             [taLeftJustify,taLeftJustify,taRightJustify,taRightJustify,taRightJustify,taRightJustify,taRightJustify,taRightJustify,taRightJustify]);
     ImprimerListe(true);
  end;

finally
  if ListeTmp<>nil then ListeTmp.Free;
end;//fin finally


end;

procedure TRegulTVA.BtnEnregistrerClick(Sender: TObject);
begin
if self.FormState = [fsModal] then
ModalResult:=mrok
else
self.close;
end;

procedure TRegulTVA.PaGrilleResize(Sender: TObject);
begin
WinShape(screen.ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TRegulTVA.PaBtnClick(Sender: TObject);
var
StrTmp:String;
ParcoursRow:Integer;
begin
 RxLabColRech.Caption :=ListViewResult.Columns[IndiceCol+1].Caption;
 for ParcoursRow:=0 to ListViewResult.Items.Count-1 do
  begin
   ListViewResult.Items[ParcoursRow].Caption:=ListViewResult.Items[ParcoursRow].SubItems.Strings[IndiceCol];

  end;
PaRecherche.Caption := '';
end;

procedure TRegulTVA.ListViewResultKeyPress(Sender: TObject; var Key: Char);
var
StrAux,StrTmp,StrTmp2:String;
begin
StrTmp:=key;
if key <> #8 then
 PaRecherche.Caption := PaRecherche.Caption+key
 else
  begin
    StrAux:=PaBas.Caption;
    StrTmp2:=str_Suppr_N_Car_ADroite(StrAux,1);

    PaRecherche.Caption :=StrTmp2;
  end;
if StrAux <> ListViewResult.GetSearchString then StrAux:=ListViewResult.GetSearchString;
StrAux:=PaRecherche.Caption;
ListViewResult.Selected:=ListViewResult.FindCaption(0,StrAux,True,True,True);
end;

procedure TRegulTVA.HeadChoixColonneRechSectionClick(
  HeaderControl: THeaderControl; Section: THeaderSection);
begin
 IndiceCol := Section.Index;
 PaBtnClick(PaBtn);
end;

procedure TRegulTVA.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TRegulTVA.Exporter1Click(Sender: TObject);
begin
ExportDonnees(ListeGlobal,E.RepertoireExportDossier,'RegulTVA_');
end;

end.
