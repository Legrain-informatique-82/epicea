unit LibChoixCompte;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, RXCtrls, jpeg, ExtCtrls, ComCtrls,DMRecherche,LibSQL,
  LibZoneSaisie, Buttons,DB,Registry,E2_Librairie_Obj,LibGestionParamXML,
  lib_chaine,E2_Decl_Records,Gr_Librairie_Obj,InputQueryFrm_F,DMConstantes,
  Mask, ToolEdit,DBTables, ActnList, ImgList;

  Const C_Validate:TSysCharSet=[#49..#56,#0..#31];
  Const C_Longueur:integer=1;

//type
//  TParamAffichCompte=record
//  //Tous : boolean;
//  ListeClasse:array of integer;
//  Tiers : boolean;
//  Dataset:TDataset;
//  ListeChamps: TStringList;
//  ListeChampsArray: Array of string;
//  Titre:string;
//  SousTitre:string;
//  FiltreNbChiffre:integer;
//  EventButtonAjouterClick:TNotifyEvent;
//  EventButtonSupprimerClick:TNotifyEvent;
//end;

type
  TLibChoixComptes = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaTitrePetit: TPanel;
    PaBas: TPanel;
    PaDateDeb: TPanel;
    PaBtn: TPanel;
    BtnEnregistrer: TButton;
    BtnAnnuler: TButton;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    Annuler1: TMenuItem;
    Valider1: TMenuItem;
    RxChListCpt: TListView;
    BtnInverser: TButton;
    BtnAnnuleSelection: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    BtnClasse1: TSpeedButton;
    BtnClasse2: TSpeedButton;
    BtnClasse3: TSpeedButton;
    BtnClasse4: TSpeedButton;
    BtnClasse5: TSpeedButton;
    BtnClasse6: TSpeedButton;
    BtnClasse7: TSpeedButton;
    BtnClasse8: TSpeedButton;
    BtnClasse9: TSpeedButton;
    Inverser: TMenuItem;
    AnnulerSelection1: TMenuItem;
    Tous1: TMenuItem;
    Panel3: TPanel;
    EdRech: TEdit;
    Champrecherchesuivant1: TMenuItem;
    Label3: TLabel;
    LabelErreur: TLabel;
    BtnAjouter: TButton;
    BtnSupprimer: TButton;
    Edit2: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    ComboBox1: TComboBox;
    CheckBox1: TCheckBox;
    cbChamp: TComboBox;
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnInverserClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnAnnuleSelectionClick(Sender: TObject);
    procedure BtnClasse1Click(Sender: TObject);
    procedure InitDataset(Dataset : TDataset);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure Tous1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure TousSelectionner();
    procedure FormShow(Sender: TObject);
    procedure EdRechChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Champrecherchesuivant1Click(Sender: TObject);
    procedure RxChListCptColumnClick(Sender: TObject; Column: TListColumn);
    procedure RxChListCptCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure RxChListCptDblClick(Sender: TObject);
    procedure RxChListCptKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    Function ChoixCompteAffich(ParamAffichCompte:TParamAffichCompte):TResultStrList;
    procedure Edit2Change(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure initialiseCombox;
    procedure ComboBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure CheckBox1Click(Sender: TObject);
    procedure BtnSupplTypeTiersClick(Sender: TObject);
    procedure cbChampSelect(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { D�clarations priv�es }
    procedure SetMessErreur(const Value: String);
    function ValidateInput(Value : string):boolean;

  public
    { D�clarations publiques }
    ParamAffichCompteObjet:TParamAffichCompte;
    titreListeAction:string;
  end;

var
  LibChoixComptes: TLibChoixComptes;
  ListeFiltreAffich : TStringList;
  ListeCpt:TStringList;
  ordretri:integer;
  ValidateLocale : TSysCharSet;
  LongueurLocale : integer;


  Function ChoixCompteAffich(titre:string;Dataset : TDataset; ListeChamps : array of string;Tiers:boolean=false):TResultStrList;overload;
  Function ChoixCompteAffich(var ParamAffichCompte:TParamAffichCompte):TResultStrList;overload;
  procedure InitialiseParamAffichCompte(var Param:TParamAffichCompte);
  procedure LibereParamAffichCompte(var Param:TParamAffichCompte);
implementation

uses TStringlistLGR;

{$R *.dfm}


Function TLibChoixComptes.ChoixCompteAffich(ParamAffichCompte:TParamAffichCompte):TResultStrList;
var
i:integer;
S:String;
begin
try
result.Result:=false;
ListeCpt:=TStringList.Create;
result.Liste:=nil;
result.regrouper := 0;
ListeFiltreAffich :=TStringList.Create;

ParamAffichCompteObjet:=ParamAffichCompte;
ParamAffichCompteObjet.Dataset:=CloneDataSet(ParamAffichCompte.Dataset,ParamAffichCompteObjet.Dataset);
if ParamAffichCompteObjet.Titre='' then
  ParamAffichCompteObjet.Titre := 'S�lectionnez les comptes...';
ordretri:=1;

setlength(ParamAffichCompteObjet.ListeChampsArray,(ParamAffichCompte.ListeChamps.Count));
for i:=0 to  (ParamAffichCompte.ListeChamps.Count-1) do
  ParamAffichCompteObjet.ListeChampsArray[i] :=ParamAffichCompte.ListeChamps.Strings[i];

if @ParamAffichCompte.EventButtonAjouterClick<>nil then
 BtnAjouter.OnClick := ParamAffichCompte.EventButtonAjouterClick
 else BtnAjouter.OnClick := nil;


if @ParamAffichCompte.EventButtonSupprimerClick<>nil then
 BtnSupprimer.OnClick := ParamAffichCompte.EventButtonSupprimerClick
 else BtnSupprimer.OnClick := nil;

BtnSupprimer.Visible:= @ParamAffichCompteObjet.EventButtonSupprimerClick<>nil;
BtnAjouter.Visible:= @ParamAffichCompteObjet.EventButtonAjouterClick<>nil;

initialiseCombox;
CheckBox1.Visible:=ParamAffichCompte.sautDePage;
CheckBox1.Caption:=ParamAffichCompte.titreSautDePage;
CheckBox1.Checked:=ParamAffichCompte.sautDePage;

if dmrech = nil then dmrech := Tdmrech.Create(Application.MainForm);
DeFiltrageDataSet(ParamAffichCompteObjet.Dataset);
result.Result:=ShowModal = MrOk;
if (result.Result)and(ListeFiltreAffich.Count<>0) then
 begin
    result.Liste:=ListeFiltreAffich;
 end;
finally

end;
End;



Function ChoixCompteAffich(titre:string;Dataset : TDataset; ListeChamps : array of string;Tiers:boolean):TResultStrList;
var
i:integer;
S:String;
begin
try
result.Result:=false;
ListeCpt:=TStringList.Create;
result.regrouper := 0;
result.Liste:=nil;
ListeFiltreAffich :=TStringList.Create;
if LibChoixComptes <> nil then
  LibChoixComptes.Destroy;
LibChoixComptes:=TLibChoixComptes.Create(Application.MainForm);

InitialiseParamAffichCompte(LibChoixComptes.ParamAffichCompteObjet);
LibChoixComptes.ParamAffichCompteObjet.Dataset:=CloneDataSet(Dataset,LibChoixComptes.ParamAffichCompteObjet.Dataset);
LibChoixComptes.ParamAffichCompteObjet.Tiers := Tiers;
LibChoixComptes.ParamAffichCompteObjet.Titre := 'S�lectionnez les comptes...';
if titre<>'' then
  LibChoixComptes.ParamAffichCompteObjet.Titre := titre;

for i:=0 to  high(ListeChamps) do
  LibChoixComptes.ParamAffichCompteObjet.ListeChamps.Add(ListeChamps[i]);
setlength(LibChoixComptes.ParamAffichCompteObjet.ListeChampsArray,high(ListeChamps)+1);
for i:=0 to  high(ListeChamps) do
  LibChoixComptes.ParamAffichCompteObjet.ListeChampsArray[i] :=ListeChamps[i];
ordretri:=1;
LibChoixComptes.BtnAjouter.OnClick := nil;
LibChoixComptes.BtnSupprimer.OnClick := nil;

LibChoixComptes.initialiseCombox;

LibChoixComptes.CheckBox1.Visible:=false;
LibChoixComptes.CheckBox1.Checked:=false;
LibChoixComptes.BtnSupprimer.Visible:= @LibChoixComptes.BtnSupprimer.OnClick<>nil;
LibChoixComptes.BtnAjouter.Visible:= @LibChoixComptes.BtnAjouter.OnClick<>nil;



if dmrech = nil then dmrech := Tdmrech.Create(Application.MainForm);
DeFiltrageDataSet(LibChoixComptes.ParamAffichCompteObjet.Dataset);
result.Result:=LibChoixComptes.ShowModal = MrOk;
if result.result then result.liste:=TStringList.Create;

if (result.Result) then                      //and(ListeFiltreAffich.Count<>0)
 begin
         result.Result:=ListeFiltreAffich.Count>0;
    result.Liste:=ListeFiltreAffich;
    result.Regrouper := LibChoixComptes.ParamAffichCompteObjet.Regrouper;
    
 end;
finally
if(LibChoixComptes.ParamAffichCompteObjet.Dataset<>nil)then
begin
  LibChoixComptes.ParamAffichCompteObjet.Dataset.close;
  //LibChoixComptes.ParamAffichCompteObjet.Dataset.Free;
  LibChoixComptes.ParamAffichCompteObjet.Dataset:=nil;
end;
//LibChoixComptes.Destroy;
LibChoixComptes.free;
end;
End;


Function ChoixCompteAffich(var ParamAffichCompte:TParamAffichCompte):TResultStrList;
var
i:integer;
S:String;
begin
try
result.Result:=false;
ListeCpt:=TStringList.Create;
result.Liste:=nil;
result.regrouper := 0;
ListeFiltreAffich :=TStringList.Create;

if LibChoixComptes <> nil then
  LibChoixComptes.Destroy;
LibChoixComptes:=TLibChoixComptes.Create(Application.MainForm);

LibChoixComptes.ParamAffichCompteObjet:=ParamAffichCompte;
LibChoixComptes.ParamAffichCompteObjet.Dataset:=CloneDataSet(ParamAffichCompte.Dataset,LibChoixComptes.ParamAffichCompteObjet.Dataset);
if LibChoixComptes.ParamAffichCompteObjet.Titre='' then
  LibChoixComptes.ParamAffichCompteObjet.Titre := 'S�lectionnez les comptes...';
ordretri:=1;

setlength(LibChoixComptes.ParamAffichCompteObjet.ListeChampsArray,(ParamAffichCompte.ListeChamps.Count));
for i:=0 to  (ParamAffichCompte.ListeChamps.Count-1) do
  LibChoixComptes.ParamAffichCompteObjet.ListeChampsArray[i] :=ParamAffichCompte.ListeChamps.Strings[i];

if @ParamAffichCompte.EventButtonAjouterClick<>nil then
 LibChoixComptes.BtnAjouter.OnClick := ParamAffichCompte.EventButtonAjouterClick
 else LibChoixComptes.BtnAjouter.OnClick := nil;


if @ParamAffichCompte.EventButtonSupprimerClick<>nil then
 LibChoixComptes.BtnSupprimer.OnClick := ParamAffichCompte.EventButtonSupprimerClick
 else LibChoixComptes.BtnSupprimer.OnClick := nil;

LibChoixComptes.initialiseCombox;
LibChoixComptes.CheckBox1.Visible:=ParamAffichCompte.titreSautDePage<>'';
LibChoixComptes.CheckBox1.Caption:=ParamAffichCompte.titreSautDePage;
LibChoixComptes.CheckBox1.Checked:=ParamAffichCompte.sautDePage;

LibChoixComptes.BtnSupprimer.Visible:= @LibChoixComptes.BtnSupprimer.OnClick<>nil;
LibChoixComptes.BtnAjouter.Visible:= @LibChoixComptes.BtnAjouter.OnClick<>nil;

//LibChoixComptes.edit1.Text := IntToStr_Lgr(LibChoixComptes.ParamAffichCompteObjet.FiltreNbChiffre);
if dmrech = nil then dmrech := Tdmrech.Create(Application.MainForm);

DeFiltrageDataSet(LibChoixComptes.ParamAffichCompteObjet.Dataset);

result.Result:=LibChoixComptes.ShowModal = MrOk;

if (result.Result) then  //and(ListeFiltreAffich.Count<>0)
 begin
     result.Result:=ListeFiltreAffich.Count>0;
    result.Liste:=ListeFiltreAffich;
    result.Regrouper := LibChoixComptes.ParamAffichCompteObjet.Regrouper;
    ParamAffichCompte:=LibChoixComptes.ParamAffichCompteObjet;
 end;
finally
if(LibChoixComptes.ParamAffichCompteObjet.Dataset<>nil)then
begin
  LibChoixComptes.ParamAffichCompteObjet.Dataset.close;
  //LibChoixComptes.ParamAffichCompteObjet.Dataset.Free;
  LibChoixComptes.ParamAffichCompteObjet.Dataset:=nil;
end;
//LibChoixComptes.Destroy;
LibChoixComptes.free;
end;
End;


procedure TLibChoixComptes.BtnEnregistrerClick(Sender: TObject);
var
i:integer;
begin
ListeFiltreAffich.Clear;
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
    if RxChListCpt.items[i].Selected then
//      if ParamAffichCompteObjet.Regrouper>0 then
//        begin
//            ListeFiltreAffich.Add(str_n_prem_char(RxChListCpt.items[i].SubItems[0],ParamAffichCompteObjet.Regrouper));
//        end
//      else
        ListeFiltreAffich.Add(RxChListCpt.items[i].SubItems[0]);
   End;
ModalResult := mrOk;
end;

procedure TLibChoixComptes.BtnInverserClick(Sender: TObject);
 var
i:integer;
begin
ListeFiltreAffich.Clear;
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
    RxChListCpt.items[i].Selected:=not RxChListCpt.items[i].Selected;
    if RxChListCpt.items[i].Selected then
     ListeFiltreAffich.Add(ListeCpt.Strings[i]);
   End;

end;

procedure TLibChoixComptes.FormDestroy(Sender: TObject);
Var
	Registre :TRegistry;
Begin
        Begin
          Registre:= TRegistry.Create;

         try
         with Registre do begin
            RootKey := HKEY_LOCAL_MACHINE;

            OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, True);
            WriteBool('C1',BtnClasse1.down);
            WriteBool('C2',BtnClasse2.down);
            WriteBool('C3',BtnClasse3.down);
            WriteBool('C4',BtnClasse4.down);
            WriteBool('C5',BtnClasse5.down);
            WriteBool('C6',BtnClasse6.down);
            WriteBool('C7',BtnClasse7.down);
            WriteBool('C8',BtnClasse8.down);
            WriteBool('C9',BtnClasse9.down);
            CloseKey;
         end;
      finally
         Registre.Free;
      end;
   End;
//ParamAffichCompteObjet.Dataset.close;
//ParamAffichCompteObjet.Dataset.Free;
//ListeCpt.Free;
LibGestionParamXML.DestroyForm(Self,E.User);
LibChoixComptes:=nil;
end;

procedure TLibChoixComptes.BtnAnnuleSelectionClick(Sender: TObject);
var
i:integer;
begin
ListeFiltreAffich.Clear;
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
    RxChListCpt.items[i].Selected:=false;
   End;

end;

procedure TLibChoixComptes.BtnClasse1Click(Sender: TObject);
var
V:array[1..9] of string[2];
i:integer;
begin
if (not ParamAffichCompteObjet.Tiers)and(ParamAffichCompteObjet.filtrer) then
  begin
     for i:=1 to 9 do V[i]:=inttostr(ord((FindComponent('BtnClasse'+inttostr(i)) as TSpeedButton).Down)*i)+'*';

      ParamAffichCompteObjet.Dataset.Filtered := false;
      ParamAffichCompteObjet.Dataset.Filter :=CreeFiltreOU(ParamAffichCompteObjet.ListeChamps.Strings[0],[v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8],v[9]]);
      ParamAffichCompteObjet.Dataset.Filtered := True;
      //ParamAffichCompteObjet.Dataset.OnFilterRecord := FilterRecordNombreCaracteres;
  end;
InitDataset(ParamAffichCompteObjet.Dataset);
TousSelectionner;
end;


procedure TLibChoixComptes.InitDataset(Dataset : TDataset);
var
ListeTmp:Tstringlist;
Valeur,recup:string;
j,i:integer;
begin
Screen.Cursor := crSQLWait;
RxChListCpt.Clear;
ListeCpt.Clear;
ListeTmp:=Tstringlist.Create;
ListeTmp.Clear;
Dataset.first;
cbChamp.Clear;
while not Dataset.eof do
   Begin
    i:=0;
    valeur:='';
    while (i<=ParamAffichCompteObjet.ListeChamps.Count-1)do
    begin

        if ParamAffichCompteObjet.ListeChamps.Strings[i]<>'' then
          begin
            if(Dataset.findfield(ParamAffichCompteObjet.ListeChamps.Strings[i]).DataType in [ftCurrency,ftFloat])then
                recup:= CurrToStr_Lgr(Dataset.findfield(ParamAffichCompteObjet.ListeChamps.Strings[i]).AsCurrency,'0','0')
            else
            recup:=Dataset.findfield(ParamAffichCompteObjet.ListeChamps.Strings[i]).AsString;
            if valeur<>'' then
              Valeur:=Valeur+';'+recup
            else
              Valeur:=recup;
          end;
    inc(i);
    end;
    ListeTmp.Add(Valeur+';');
    ListeCpt.add(Dataset.findfield(ParamAffichCompteObjet.ListeChamps.Strings[0]).AsString);
    Dataset.Next;
   End;

for i:=0 to ParamAffichCompteObjet.ListeChamps.Count-1 do
  cbChamp.Items.Add(ParamAffichCompteObjet.ListeChamps.Strings[i]);

InitLisViewAvecListe(RxChListCpt,ParamAffichCompteObjet.ListeChampsArray,ListeTmp,true,true).Free;
Self.FormResize(nil);
Screen.Cursor := crDefault;
end;
procedure TLibChoixComptes.BtnAnnulerClick(Sender: TObject);
begin
ModalResult:=mrCancel;
end;

procedure TLibChoixComptes.Tous1Click(Sender: TObject);
var i:integer;
begin
BtnClasse1.Down:=true;
BtnClasse2.Down:=true;
BtnClasse3.Down:=true;
BtnClasse4.Down:=true;
BtnClasse5.Down:=true;
BtnClasse6.Down:=true;
BtnClasse7.Down:=true;
BtnClasse8.Down:=true;
BtnClasse9.Down:=true;
for i:=1 to high(ParamAffichCompteObjet.ListeClasse)do
begin
(FindComponent('BtnClasse'+inttostr(ParamAffichCompteObjet.ListeClasse[i])) as TSpeedButton).Down:=false;
end;
BtnClasse1.Click;
end;

procedure TLibChoixComptes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin 
WinSuivPrec(Handle,key,[RxChListCpt,BtnAnnuler,BtnEnregistrer,BtnInverser,BtnAnnuleSelection]);
   If Key = VK_ESCAPE Then
     Begin
      ModalResult:= mrCancel;
     end;
end;

procedure TLibChoixComptes.FormCreate(Sender: TObject);
Var
	Registre :TRegistry;
begin
  	Registre:= TRegistry.Create;
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
    end;
   try
	   with Registre do begin
	      RootKey := HKEY_LOCAL_MACHINE;

         OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, False);

         Try
            BtnClasse1.down:=ReadBool('C1');
            BtnClasse2.down:=ReadBool('C2');
            BtnClasse3.down:=ReadBool('C3');
            BtnClasse4.down:=ReadBool('C4');
            BtnClasse5.down:=ReadBool('C5');
            BtnClasse6.down:=ReadBool('C6');
            BtnClasse7.down:=ReadBool('C7');
            BtnClasse8.down:=ReadBool('C8');
            BtnClasse9.down:=ReadBool('C9');

         Except
            BtnClasse1.down:=true;
            BtnClasse2.down:=true;
            BtnClasse3.down:=true;
            BtnClasse4.down:=true;
            BtnClasse5.down:=true;
            BtnClasse6.down:=true;
            BtnClasse7.down:=true;
            BtnClasse8.down:=true;
            BtnClasse9.down:=true;
         	{}
         End;
      end;
   finally
		Registre.Free;
    titreListeAction:='Liste des actions disponibles'
   end;

end;

procedure TLibChoixComptes.TousSelectionner();
 var
i:integer;
begin
if ListeFiltreAffich=nil then ListeFiltreAffich :=TStringList.Create;
ListeFiltreAffich.Clear;
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
     RxChListCpt.items[i].Selected:=true;
     ListeFiltreAffich.Add(ListeCpt.Strings[i]);
   End;
end;


procedure TLibChoixComptes.FormShow(Sender: TObject);
begin
Label3.Tag:=0;
//Champrecherchesuivant1.Click;
Tous1.Click;
TousSelectionner();
cbChamp.ItemIndex:=0;
end;


procedure TLibChoixComptes.EdRechChange(Sender: TObject);
var
i:integer;
Pos:integer;
begin
pos:=-1;
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin                                                       
      RxChListCpt.Items[i].Selected:=str_commence_par(UpperCase(RxChListCpt.Items[i].Caption),UpperCase(EdRech.Text));
      if (RxChListCpt.Items[i].Selected)and(pos=-1) then pos:=i;
   End;
if pos>-1 then RxChListCpt.ItemIndex:=pos;
if(RxChListCpt.Selected<>nil)then RxChListCpt.Selected.MakeVisible(false);  
end;

procedure TLibChoixComptes.FormActivate(Sender: TObject);
begin
RxLabTitre.Caption:=ParamAffichCompteObjet.Titre;
PaTitrePetit.Caption:=ParamAffichCompteObjet.SousTitre;
EdRech.Text:='';
EdRech.SetFocus;
Label3.Tag:=0;
//Champrecherchesuivant1.Click;
cbChamp.ItemIndex:=0;
SetMessErreur('');

//Label4.Visible:=ParamAffichCompteObjet.Filtrer;
//Label5.Visible:=ParamAffichCompteObjet.Filtrer;
//Edit1.Visible:=ParamAffichCompteObjet.Filtrer;

Label6.Visible:=ParamAffichCompteObjet.Regrouper>0;
Label7.Visible:=ParamAffichCompteObjet.Regrouper>0;
Edit2.Visible:=ParamAffichCompteObjet.Regrouper>0;

edit2.OnChange:=nil;
if ParamAffichCompteObjet.Regrouper>0 then edit2.Text:=IntToStr_Lgr(ParamAffichCompteObjet.Regrouper);
edit2.OnChange:=Edit2Change;

BtnSupprimer.Visible:= @ParamAffichCompteObjet.EventButtonSupprimerClick<>nil;
BtnAjouter.Visible:= @ParamAffichCompteObjet.EventButtonAjouterClick<>nil;
end;

procedure TLibChoixComptes.Champrecherchesuivant1Click(Sender: TObject);
var
i:integer;
begin
EdRech.Text:='';
if(cbChamp.ItemIndex<cbChamp.Items.Count-1)then
cbChamp.ItemIndex:=cbChamp.ItemIndex+1
else cbChamp.ItemIndex:=0;

for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
      RxChListCpt.Items[i].Caption:=RxChListCpt.Items[i].SubItems[cbChamp.ItemIndex];
   End;
end;

procedure TLibChoixComptes.RxChListCptColumnClick(Sender: TObject;
  Column: TListColumn);
begin
OrdreTri:=-OrdreTri;
if Column.Index > 0 then
 RxChListCpt.CustomSort(nil, Column.Index-1)
else
 RxChListCpt.CustomSort(nil, Column.Index)
end;

procedure TLibChoixComptes.RxChListCptCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
if DAta >= 0 then
compare:=OrdreTri*StrComp(PChar(Item1.SubItems.Strings[Data]),PChar(Item2.SubItems.Strings[Data]))
else
compare:=OrdreTri*StrComp(PChar(TListItem(Item1).Caption),PChar(TListItem(Item2).Caption));
end;

procedure TLibChoixComptes.RxChListCptDblClick(Sender: TObject);
begin
BtnEnregistrer.Click;
end;

procedure TLibChoixComptes.RxChListCptKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
if key=VK_RETURN then BtnEnregistrer.Click;
end;

function TLibChoixComptes.ValidateInput(Value : string):boolean;
var
str,Mess:String;
I:integer;
begin
  For I := 1 To Length(Value) Do
    If not(Value[I] in C_Validate) Then
  Begin
    str:=str+value[i];
  end;
  if(not (str=EmptyStr))then Mess:='le caract�re : "'+str+'" n''est pas autoris�'
    else if(Length(value)>C_Longueur)then Mess:='Vous ne devez pas d�passer '+IntToStr(LongueurLocale)+' caract�res'
     else Mess:='';
  SetMessErreur(Mess) ;
  result := Mess=EmptyStr;
end;

procedure TLibChoixComptes.SetMessErreur(const Value: String);
begin
  LabelErreur.Caption := Value;
end;





procedure TLibChoixComptes.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if(not ValidateInput(Key))then Key:=#0;
end;


procedure InitialiseParamAffichCompte(var Param:TParamAffichCompte);
begin
Param.Regrouper:=0;
Param.Filtrer:=true;
Param.ListeClasse:=nil;
Param.Tiers :=false;
Param.Dataset:=nil;
Param.sautDePage:=false;
param.titreSautDePage:='';
Param.ListeChamps:=TStringList.Create;
Param.Titre:='';
Param.SousTitre:='';
Param.FiltreNbChiffre:=3;
Param.EventButtonAjouterClick:=nil;
Param.EventButtonSupprimerClick:=nil;
Param.ListeItemAction:=TStringListLGR1.Create;

end;

procedure LibereParamAffichCompte(var Param:TParamAffichCompte);
begin
Param.Regrouper:=0;
Param.Filtrer:=true;
Param.ListeClasse:=nil;
Param.Tiers :=false;
Param.Dataset:=nil;
Initialise_TStringlist(Param.ListeChamps);
Param.Titre:='';
Param.SousTitre:='';
Param.FiltreNbChiffre:=3;
Param.EventButtonAjouterClick:=nil;
Param.EventButtonSupprimerClick:=nil;
end;

procedure TLibChoixComptes.Edit2Change(Sender: TObject);
begin
 ValidateInput(Edit2.Text);
 ParamAffichCompteObjet.Regrouper:=StrToInt_Lgr(Edit2.text,8);
end;





procedure TLibChoixComptes.ComboBox1Click(Sender: TObject);
var
ExecProcedure:TProcedure;
begin
@ExecProcedure:=ComboBox1.Items.Objects[ComboBox1.ItemIndex];
if @ExecProcedure<>nil then
  ExecProcedure;
ComboBox1.ItemIndex:=0;
end;


procedure TLibChoixComptes.initialiseCombox;
var
i:integer;
begin
ComboBox1.clear;
ComboBox1.Text:=titreListeAction;
ComboBox1.AddItem(titreListeAction,nil);
for i:=0 to ParamAffichCompteObjet.ListeItemAction.Count-1 do
   ComboBox1.AddItem(ParamAffichCompteObjet.ListeItemAction.Strings[i],
     ParamAffichCompteObjet.ListeItemAction.Objects[i]);
ComboBox1.Visible:=ComboBox1.Items.Count>1;
ComboBox1.ItemIndex:=0;
end;
procedure TLibChoixComptes.ComboBox1DrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var marge:integer;
  begin
//on dessine le fond des lignes en alternant les couleurs
//  if index mod 2<>1 then begin
//                          //ComboBox1.canvas.brush.color:=clwhite;
//                          //ComboBox1.canvas.fillrect(rect);
//                          end else begin
//                                   ComboBox1.canvas.brush.color:=$00F4F3EE;
//                                   ComboBox1.canvas.fillrect(rect);
//                                   end;
//   //on affiche le texte
  ComboBox1.canvas.textout(rect.left+30,rect.top+2,ComboBox1.items[index]);
  if (index<>0) then
  begin
  if (odSelected in state) then begin
                                ComboBox1.canvas.brush.color:=$00F8D1C5;
                                ComboBox1.canvas.fillrect(rect);
                                ComboBox1.canvas.font.color:=clblue;
                                ComboBox1.canvas.font.style:=ComboBox1.canvas.font.style +[fsbold]+[fsitalic];
                                ComboBox1.canvas.textout(rect.left+30,rect.top+2,ComboBox1.items[index]);
                                end;
//    //dessin des ic�nes
//    marge := (Rect.Bottom - Rect.Top - imageList1.Height) div 2;
//    imagelist1.Draw(ComboBox1.canvas, Rect.Left + 4, Rect.Top + marge, Index);
  end;
end;
procedure TLibChoixComptes.CheckBox1Click(Sender: TObject);
begin
ParamAffichCompteObjet.sautDePage:=CheckBox1.State=cbChecked;
end;

procedure TLibChoixComptes.BtnSupplTypeTiersClick(Sender: TObject);
var
ListeCpt:TResultStrList;
Requete : TQuery;
filtre:string;
ParamAffichCompte:TParamAffichCompte;
ChoixCompte:TLibChoixComptes;
begin
try
    requete := TQuery.Create(application.MainForm);
    //pour r�cup�rer les types de tiers
    ListeCpt.Liste:=TStringList.Create;
    ListeCpt.result:=true;
    requete.DatabaseName :=DM_C_NomAliasDossier;
    requete.SQL.Add(' select distinct type,compte from tiers T');
    requete.Open;
    requete.First;
    Filtre:='';
    ChoixCompte:=TLibChoixComptes.Create(Application.MainForm);
                  InitialiseParamAffichCompte(ParamAffichCompte);
                  ParamAffichCompte.Titre:= 'S�lectionnez les types de tiers ...';
                  ParamAffichCompte.Tiers:=true;
                  ParamAffichCompte.Dataset:=requete;
                  ParamAffichCompte.ListeChamps.Add('type');
                  ParamAffichCompte.ListeChamps.Add('compte');

    listecpt:=ChoixCompte.ChoixCompteAffich(ParamAffichCompte);
    if(ListeCpt.Result) and (ListeCpt.Liste.Count>0)then
    begin
      filtre:=CreeFiltreOU('type',[ListeCpt.Liste]);
      LibChoixComptes.ParamAffichCompteObjet.Dataset.Filtered := false;
      LibChoixComptes.ParamAffichCompteObjet.Dataset.Filter :=Filtre;
      LibChoixComptes.ParamAffichCompteObjet.Dataset.Filtered := True;
      LibChoixComptes.InitDataset(LibChoixComptes.ParamAffichCompteObjet.Dataset);
      LibChoixComptes.RxChListCpt.SelectAll;
    end;
    //ChoixCompte.Destroy;
    requete.close;
    requete.SQL.Clear;
except
end;
end;

procedure TLibChoixComptes.cbChampSelect(Sender: TObject);
var
i:integer;
begin
EdRech.Text:='';

//label3.Caption:='sur le champ : '+cbChamp.Items[cbChamp.ItemIndex];
////Recopier les infos du champs suivant dans le caption de l'item
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
      RxChListCpt.Items[i].Caption:=RxChListCpt.Items[i].SubItems[cbChamp.ItemIndex];
   End;
end;

procedure TLibChoixComptes.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnInverser,BtnAnnuleSelection],PaBtn,90,0);
end;

procedure TLibChoixComptes.FormResize(Sender: TObject);
var
widthFenetre,j:integer;
begin
widthFenetre:=0;
//
if(sender=nil)then
  begin
      self.Width:=565;
      widthFenetre:=0;
      if(RxChListCpt.Columns<>nil)then
        begin
          for j:=0 to RxChListCpt.Columns.Count-1 do
          begin
             widthFenetre:=widthFenetre+RxChListCpt.Column[j].Width;
          end;
          self.Width:=widthFenetre+50;
        end;
      if(self.Width<565)then self.Width:=565;
  end;
end;

end.