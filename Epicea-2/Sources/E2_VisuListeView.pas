unit E2_VisuListeView;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RXCtrls, ExtCtrls, StdCtrls, Grids, DBGrids, RXDBCtrl, ExRxDBGrid,
  GrDBGrid, Menus,E2_Librairie_Obj,LibZoneSaisie,Gr_Librairie_Obj,DMConstantes,
  ComCtrls,E2_Decl_Records,Lib_Chaine, LibGestionParamXML, jpeg
  ,Printers
  ,ObjetEdition;
  

type


  TVisuListeView = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaGrille: TPanel;
    PaBas: TPanel;
    PaTitrePetit: TPanel;
    PopupMenu1: TPopupMenu;
    Rglements1: TMenuItem;
    DtailsPointages1: TMenuItem;
    DtailsF71: TMenuItem;
    Imprimer1: TMenuItem;
    PaBtn: TPanel;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    BtnDetail: TButton;
    BtnEnregistrer: TButton;
    Enregister1: TMenuItem;
    ListView1: TListView;
    RxLabel1: TRxLabel;
    Panel1: TPanel;
    Panel3: TPanel;
    HeadChoixColonneRech: THeaderControl;
    Panel4: TPanel;
    Panel2: TPanel;
    PaRecherche: TPanel;
    RxLabColRech: TRxLabel;
    BtnAnnuler: TButton;
    Panel5: TPanel;
    LaInfos: TLabel;
    Imprimerlaslection1: TMenuItem;
    Exporter1: TMenuItem;
    Afficherlasynthse1: TMenuItem;
    Calculatrice1: TMenuItem;
    procedure FormDestroy(Sender: TObject);
    procedure DtailsF71Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnImprimerClick(Sender: TObject);
    procedure Imprimer1Click(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure ListView1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListView1Compare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure ListView1KeyPress(Sender: TObject; var Key: Char);
    procedure PaBtnClick(Sender: TObject);
    procedure HeadChoixColonneRechSectionClick(HeaderControl: THeaderControl;
      Section: THeaderSection);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure BtnDetailClick(Sender: TObject);
    Procedure ImprimerListe(selection:boolean=false);
    procedure RemplitParametreEdition(ParamEditionTmp:TParamEdition;
                               TabTitreColonne:array of string;
                               LargeurCol:Array of Integer;
                               TabList:array of TStringList;
                               Alignement:Array of TAlignment);
    procedure Imprimerlaslection1Click(Sender: TObject);
    procedure Exporter1Click(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);

  private
    { Déclarations privées }
    FicheModale:Boolean;
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

    Function ItemCourantViewList(Mess:String;Affich:Boolean):TListItem;
    Function ItemCourantValeurCol(IndiceCol:Integer):String;
    Function ItemCourantValeurRow:TStringList;
//    Function RetourObjet:TObject;
//    Function ExecProc(NomProc:String):TObject;
  end;

  TRetourViewListe = Record
   Retour:Boolean;
   VisuListeView: TVisuListeView;
  end;

var
  VisuListeView: TVisuListeView;
  OrdreTri:integer;

  Function AfficheVisuListView(ParamAffichage:TParamAffichage;
                               TabTitreColonne:array of string;
                               LargeurCol:Array of Integer;
                               TabList:array of TStringList;
                               Alignement:Array of TAlignment;
                               TabStr,TAbCurr,TabDate:TEnsembleByte):TRetourViewListe;

implementation

uses E2_Main,DMExports;

{$R *.DFM}

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


Function AfficheVisuListView(ParamAffichage:TParamAffichage;
                             TabTitreColonne:array of string;
                             LargeurCol:Array of Integer;
                             TabList:array of TStringList;
                             Alignement:Array of TAlignment;
                             TabStr,TAbCurr,TabDate:TEnsembleByte):TRetourViewListe;
var
i:integer;
ParametreEdition:TParametreEdition;
Begin
 if VisuListeView = nil then VisuListeView:=TVisuListeView.create(Application.MAinForm);
        ParametreEdition.ParamEdition.Titre:=ParamAffichage.Titre;
        ParametreEdition.ParamEdition.TitrePetit:=ParamAffichage.TitrePetit;
        ParametreEdition.ParamEdition.AffichDefaut:=true;
//        ParametreEdition.TabTitreColonne:=TabTitreColonne;
//        ParametreEdition.LargeurCol:=LargeurCol;
//        ParametreEdition.TabList:=TabList;
//        ParametreEdition.Alignement:=Alignement;

//    VisuListeView.RemplitParametreEdition(ParametreEdition.ParamEdition,ParametreEdition.TabTitreColonne,ParametreEdition.LargeurCol,ParametreEdition.TabList,ParametreEdition.Alignement);
 /////remplissage des variables locales en vue d'une éventuelle impression
  with VisuListeView do
    begin
//        ParamAffichage_Ecran:=ParamAffichage;

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
    end;//fin du with VisuListeView
///fin remplissage des variables locales

 VisuListeView.Caption := ParamAffichage.GestionAffichForm.Caption + ' - Recherche -';
 VisuListeView.RxLabTitre.Caption :=ParamAffichage.Titre;
 VisuListeView.PaTitrePetit.Caption :=ParamAffichage.TitrePetit;
 VisuListeView.LaInfos.Caption:=ParamAffichage.InfosSup;
 VisuListeView.TabStr := TabStr;
 VisuListeView.TabCurr := TabCurr;
 VisuListeView.TabDate := TabDate;
 VisuListeView.ListView1.Columns.Clear;
 VisuListeView.ListView1.Items.Clear;
 VisuListeView.Indicecol := 0;
 // Gestion des evenements paramétrable !
 if @ParamAffichage.EventButtonDetailClick <> nil then
 VisuListeView.BtnDetail.OnClick := ParamAffichage.EventButtonDetailClick;
 if @ParamAffichage.EventListViewDbleClick = nil then
   VisuListeView.ListView1.OnDblClick := VisuListeView.BtnDetailClick
 else
   VisuListeView.ListView1.OnDblClick :=ParamAffichage.EventListViewDbleClick;

 if (@ParamAffichage.EventSyntheseClick = nil) then
   begin
     VisuListeView.Afficherlasynthse1.OnClick := nil;
     TMenuItem(VisuListeView.FindComponent('Afficherlasynthse1')).Visible:=false;
   end
 else
   begin
     VisuListeView.Afficherlasynthse1.OnClick :=ParamAffichage.EventSyntheseClick;
     TMenuItem(VisuListeView.FindComponent('Afficherlasynthse1')).Visible:=true;
   end;

 if @ParamAffichage.EventButtonImprimerClick <> nil then
 VisuListeView.BtnImprimer.OnClick := ParamAffichage.EventButtonImprimerClick
 else
 VisuListeView.BtnImprimer.OnClick := VisuListeView.BtnImprimerClick;

 if @ParamAffichage.EventButtonValiderClick <> nil then
  VisuListeView.BtnEnregistrer.OnClick := ParamAffichage.EventButtonValiderClick;
  
 VisuListeView.ListView1.Columns.Add.Caption :=TabTitreColonne[0];
 VisuListeView.ListView1.Columns[VisuListeView.ListView1.Columns.Count-1].Width :=0;// LargeurCol[0];;
 VisuListeView.ListView1.Columns[VisuListeView.ListView1.Columns.Count-1].Alignment := Alignement[0];
// VisuListeView.ListView1.Columns.c
 VisuListeView.HeadChoixColonneRech.Sections.Clear;
 VisuListeView.RxLabColRech.Caption := TabTitreColonne[0];
 for i:=0 to high(TabTitreColonne) do
  begin
   VisuListeView.HeadChoixColonneRech.Sections.Add.Text :=TabTitreColonne[i];
   VisuListeView.ListView1.Columns.Add.Caption := TabTitreColonne[i];
   VisuListeView.ListView1.Columns[VisuListeView.ListView1.Columns.Count-1].Width := LargeurCol[i];
   VisuListeView.ListView1.Columns[VisuListeView.ListView1.Columns.Count-1].Alignment := Alignement[i];
  end;

 VisuListeView.ListeGlobal:=InitLisViewAvecListe(VisuListeView.ListView1,TabTitreColonne,TabList,True);
 if VisuListeView.ListView1.Items.Count > 0 then VisuListeView.ListView1.Selected := VisuListeView.ListView1.TopItem;
 VisuListeView.FicheModale:=ParamAffichage.AffichModal;
 Result.VisuListeView:=VisuListeView;
 if ((VisuListeView.FicheModale)and(VisuListeView.visible=false)) then
  begin
   Result.Retour:=(VisuListeView.ShowModal=mrOk);
  end
  else
  begin
   VisuListeView.Show;
   Result.Retour:=true;
  end;
  //
End;

procedure TVisuListeView.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,E.User);
VisuListeView:=nil;
end;

procedure TVisuListeView.DtailsF71Click(Sender: TObject);
begin
  if @BtnDetail.OnClick<>nil then
    BtnDetail.Click;
end;

procedure TVisuListeView.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 BtnDetail.OnClick:=nil;
 PaGrille.OnResize:=nil;
 Afficherlasynthse1.Visible:=false;
 Afficherlasynthse1.OnClick:=nil;
 PopupMenu1.OnPopup:=nil;
 canclose:=true;
end;

procedure TVisuListeView.FormActivate(Sender: TObject);
begin
//  GrDBVisu.ParamColor:=true;
//  GrDBVisu.Param:=ParamUtil.CouleurDBGrid;
//  GrDBVisu.UpDateColor;
Initialise_TParamAffichage(ParamAffichage_Ecran);
ParamEdition.AffichDefaut:=true;
ParamEdition.Titre:='';
ParamEdition.TitrePetit:='';
end;

procedure TVisuListeView.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//WinSuivPrec(Handle,key,[GrDBVisu]);
 if Key = VK_RETURN then
  begin
   BtnEnregistrer.Click;
  end;
  if Key = VK_ESCAPE then
   begin
    if not empty(PaRecherche.Caption) then
     begin
      PaRecherche.Caption :='';
     end
     else
     begin
      Key:= 0;
      if FicheModale then
       modalResult:=mrCancel
       else Self.Close;
     end;
   end;
  if Shift = [SSCtrl] then
  begin
   if key in [VK_Left] then
    begin
      if Indicecol > 0 then dec(Indicecol) else Indicecol:=(ListView1.Columns.Count-2);
      PaBtnClick(PaBtn);
    end;
   if key in [VK_Right] then
    begin
     if Indicecol < (ListView1.Columns.Count-2) then
          inc(Indicecol)
          else
          Indicecol :=0;
     PaBtnClick(PaBtn);
    end;
  end;
end;

procedure TVisuListeView.BtnImprimerClick(Sender: TObject);
begin
//Showmessage('Non implémenté dans cette version !');
ImprimerListe;
end;

procedure TVisuListeView.Imprimer1Click(Sender: TObject);
begin
BtnImprimer.Click;
end;

procedure TVisuListeView.BtnAnnulerEnter(Sender: TObject);
begin
  BouttonDiminue(sender as TButton);
end;

procedure TVisuListeView.BtnAnnulerExit(Sender: TObject);
begin
  BouttonAgrandit(sender as TButton);
  PaBtnResize(PaBtn);
//  FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnFermer,BtnImprimer,BtnDetail],PaBtn,90,0);
end;

procedure TVisuListeView.PaBtnResize(Sender: TObject);
begin
  FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnFermer,BtnImprimer,BtnDetail],PaBtn,90,0);
end;

procedure TVisuListeView.FormCreate(Sender: TObject);
begin
  try
      OrdreTri:=1;
      LibGestionParamXML.InitialiseForm(E.User,Self);
      //Initialise_TParamAffichage(ParamAffichage_Ecran);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;

procedure TVisuListeView.BtnFermerClick(Sender: TObject);
begin
   if FicheModale then
   ModalResult:=mrCancel
   else
   self.close;
end;

procedure TVisuListeView.BtnEnregistrerClick(Sender: TObject);
begin
if FicheModale then
ModalResult:=mrok
else
self.close;
end;



procedure TVisuListeView.ListView1Compare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
if DAta >= 0 then
compare:=OrdreTri*StrComp(PChar(Item1.SubItems.Strings[Data]),PChar(Item2.SubItems.Strings[Data]))
else
compare:=OrdreTri*StrComp(PChar(TListItem(Item1).Caption),PChar(TListItem(Item2).Caption));
end;

Function TVisuListeView.ItemCourantViewList(Mess:String;Affich:Boolean):TListItem;
begin
Result:=ListView1.Selected;
if result = nil then Result:= ListView1.ItemFocused;
//if result = nil then Result:= LAstItemSelected;

//affich:=true;
if ((Result = nil) and Affich) then
 begin
  if empty(Mess) then
      MessageDlg('Il n''y a aucune ligne sélectionnée !',mtWarning,[mbOK],0)
    else
      MessageDlg(Mess,mtWarning,[mbOK],0);
  end;
end;

Function TVisuListeView.ItemCourantValeurCol(IndiceCol:Integer):String;
Begin
Result:='';
if ItemCourantViewList('',false) <> nil then
 begin
 if ListView1.Selected<>nil then
   if ((IndiceCol >= 0) and (IndiceCol < ListView1.Selected.SubItems.Count)) then
      Result:=ListView1.Selected.SubItems.Strings[IndiceCol];
// if IndiceCol < 0 then Result:=ListView1.Selected.Caption
 end;
End;

Function TVisuListeView.ItemCourantValeurRow:TStringList;
var
i,IndiceRow:integer;
Begin
Result:=TStringList.Create;
Result.Clear;
if ListView1.Selected=nil then exit;
if ItemCourantViewList('',false) <> nil then
 begin
 IndiceRow := ListView1.Selected.Index;
 if ((IndiceRow >= 0) and (IndiceRow < ListView1.Items.Count)) then
  begin
//    Result.Add(ListView1.Selected.Caption);
    for i:=0 to ListView1.Selected.SubItems.Count-1 do
     //On affecte qu'une seule fois l'objet, car il n'y en a que celui du premier items qui est valide
     // Voir LibZoneSaisie.InitLisViewAvecListe
     // Pour accéder à cet objet, il faut lire la 2 ième chaine das la liste : indice 1
     if i=0 then
       Result.AddObject(ListView1.Items[IndiceRow].SubItems.Strings[i],ListView1.Items[IndiceRow].SubItems.Objects[i])
      else
      Result.Add(ListView1.Items[IndiceRow].SubItems.Strings[i]);
  end;
 end;
End;



procedure TVisuListeView.ListView1KeyPress(Sender: TObject; var Key: Char);
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
if StrAux <> ListView1.GetSearchString then StrAux:=ListView1.GetSearchString;
StrAux:=PaRecherche.Caption;
ListView1.Selected:=ListView1.FindCaption(0,StrAux,True,True,True);
end;

procedure TVisuListeView.PaBtnClick(Sender: TObject);
var
StrTmp:String;
ParcoursRow:Integer;
begin
//StrTmp:=ListView1.Column[1].Caption;
//ListView1.Column[1].Caption:=ListView1.Column[0].Caption;
//ListView1.Column[0].Caption:=StrTmp;
 RxLabColRech.Caption :=ListView1.Columns[IndiceCol+1].Caption;
 for ParcoursRow:=0 to ListView1.Items.Count-1 do
  begin
   ListView1.Items[ParcoursRow].Caption:=ListView1.Items[ParcoursRow].SubItems.Strings[IndiceCol];

  end;
PaRecherche.Caption := '';
end;

procedure TVisuListeView.HeadChoixColonneRechSectionClick(
  HeaderControl: THeaderControl; Section: THeaderSection);
begin
 IndiceCol := Section.Index;
 PaBtnClick(PaBtn);
end;

procedure TVisuListeView.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TVisuListeView.PaGrilleResize(Sender: TObject);
begin
WinShape(screen.ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);

end;

procedure TVisuListeView.BtnDetailClick(Sender: TObject);
begin
showmessage('Pas de détail disponible');
end;




Procedure TVisuListeView.ImprimerListe(selection:boolean);
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
//  if high(TabList_Ecran)<=0 then
    Begin//construction de la liste à partir de la liste de l'écran
       for i:=0 to ListView1.Items.Count-1 do
         Begin
           if selection then
             Begin
                if ListView1.Items[i].Selected then
                   Begin
                       ListeTmp.AddObject('',ListView1.Items[i]);
                       for j:=0 to ListView1.Items[i].SubItems.Count-1 do
                         Begin
                            ListeTmp.Strings[ListeTmp.count-1]:=ListeTmp.Strings[ListeTmp.count-1]+ListView1.Items[i].SubItems.Strings[j]+';';
                         end;
                   end;
             end
           else
             Begin
                 ListeTmp.AddObject('',ListView1.Items[i]);
                 for j:=0 to ListView1.Items[i].SubItems.Count-1 do
                   Begin
                      ListeTmp.Strings[ListeTmp.count-1]:=ListeTmp.Strings[ListeTmp.count-1]+ListView1.Items[i].SubItems.Strings[j]+';';
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


procedure TVisuListeView.RemplitParametreEdition(ParamEditionTmp:TParamEdition;
                               TabTitreColonne:array of string;
                               LargeurCol:Array of Integer;
                               TabList:array of TStringList;
                               Alignement:Array of TAlignment);
var
i:integer;
begin
  with VisuListeView do
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
    end;//fin du with VisuListeView

end;


procedure TVisuListeView.ListView1ColumnClick(Sender: TObject;  Column: TListColumn);
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
procedure TVisuListeView.Imprimerlaslection1Click(Sender: TObject);
begin
ImprimerListe(true);
end;

procedure TVisuListeView.Exporter1Click(Sender: TObject);
var
titre:string;
begin
titre:=str_supprespaces(ParamEdition.TitrePetit);
if titre<>'' then
  titre:=str_souschaine(titre,1,10)+'_';
// ParamEdition.TitrePetit
ExportDonnees(ListeGlobal,e.RepertoireExportDossier,titre);
end;

procedure TVisuListeView.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(nil);
end;

end.
