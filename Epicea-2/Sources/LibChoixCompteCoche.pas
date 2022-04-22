unit LibChoixCompteCoche;

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
  TLibChoixComptesCoche = class(TForm)
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
    procedure RxChListCptMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure RxChListCptChecked(item:TListItem);
    procedure RxChListCptMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);

   procedure DeCocheAll();
   procedure DeSelectAll();
    procedure FormResize(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure cbChampSelect(Sender: TObject);
  private
    { Déclarations privées }
    procedure SetMessErreur(const Value: String);
    function ValidateInput(Value : string):boolean;

  public
    { Déclarations publiques }
    ParamAffichCompteObjet:TParamAffichCompte;
    titreListeAction:string;
  end;

var
  LibChoixComptesCoche: TLibChoixComptesCoche;
  ListeFiltreAffich : TStringList;
  ListeCpt:TStringList;
  ordretri:integer;
  ValidateLocale : TSysCharSet;
  LongueurLocale : integer;
  itemRxChListCptCoche:boolean;

  Function ChoixCompteAffichCoche(titre:string;Dataset : TDataset; ListeChamps : array of string;RetourEntier:boolean;Tiers:boolean=false):TResultStrList;overload;
  Function ChoixCompteAffichCoche(var ParamAffichCompte:TParamAffichCompte):TResultStrList;overload;
  procedure InitialiseParamAffichCompte(var Param:TParamAffichCompte);
  procedure LibereParamAffichCompte(var Param:TParamAffichCompte);
  procedure initialiseEcran;
implementation

uses TStringlistLGR;

{$R *.dfm}


Function TLibChoixComptesCoche.ChoixCompteAffich(ParamAffichCompte:TParamAffichCompte):TResultStrList;
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
  ParamAffichCompteObjet.Titre := 'Sélectionnez les comptes...';
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

Function ChoixCompteAffichCoche(titre:string;Dataset : TDataset; ListeChamps : array of string;RetourEntier:boolean;Tiers:boolean):TResultStrList;
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
LibChoixComptesCoche.Free;
LibChoixComptesCoche:=nil;
if LibChoixComptesCoche <> nil then
  LibChoixComptesCoche.Destroy;
LibChoixComptesCoche:=TLibChoixComptesCoche.Create(Application.MainForm);
initialiseEcran;
InitialiseParamAffichCompte(LibChoixComptesCoche.ParamAffichCompteObjet);
LibChoixComptesCoche.ParamAffichCompteObjet.Dataset:=CloneDataSet(Dataset,LibChoixComptesCoche.ParamAffichCompteObjet.Dataset);
LibChoixComptesCoche.ParamAffichCompteObjet.Tiers := Tiers;
LibChoixComptesCoche.ParamAffichCompteObjet.Titre := 'Sélectionnez les comptes...';
LibChoixComptesCoche.ParamAffichCompteObjet.retourEntier:=RetourEntier;
if titre<>'' then
  LibChoixComptesCoche.ParamAffichCompteObjet.Titre := titre;

for i:=0 to  high(ListeChamps) do
  LibChoixComptesCoche.ParamAffichCompteObjet.ListeChamps.Add(ListeChamps[i]);
setlength(LibChoixComptesCoche.ParamAffichCompteObjet.ListeChampsArray,high(ListeChamps)+1);
for i:=0 to  high(ListeChamps) do
  LibChoixComptesCoche.ParamAffichCompteObjet.ListeChampsArray[i] :=ListeChamps[i];
setlength(LibChoixComptesCoche.ParamAffichCompteObjet.longueurChampArray,(LibChoixComptesCoche.ParamAffichCompteObjet.ListeChamps.Count));
for i:=0 to  (LibChoixComptesCoche.ParamAffichCompteObjet.ListeChamps.Count-1) do
  LibChoixComptesCoche.ParamAffichCompteObjet.longueurChampArray[i] :=150;

ordretri:=1;
LibChoixComptesCoche.BtnAjouter.OnClick := nil;
LibChoixComptesCoche.BtnSupprimer.OnClick := nil;

LibChoixComptesCoche.initialiseCombox;

LibChoixComptesCoche.CheckBox1.Visible:=false;
LibChoixComptesCoche.CheckBox1.Checked:=false;
LibChoixComptesCoche.BtnSupprimer.Visible:= @LibChoixComptesCoche.BtnSupprimer.OnClick<>nil;
LibChoixComptesCoche.BtnAjouter.Visible:= @LibChoixComptesCoche.BtnAjouter.OnClick<>nil;



if dmrech = nil then dmrech := Tdmrech.Create(Application.MainForm);
DeFiltrageDataSet(LibChoixComptesCoche.ParamAffichCompteObjet.Dataset);
result.Result:=LibChoixComptesCoche.ShowModal = MrOk;
if result.result then result.liste:=TStringList.Create;

if (result.Result) then         //and(ListeFiltreAffich.Count<>0)
 begin
    result.Result:=ListeFiltreAffich.Count>0;
    result.Liste:=ListeFiltreAffich;
    result.Regrouper := LibChoixComptesCoche.ParamAffichCompteObjet.Regrouper;
    
 end;
finally
if(LibChoixComptesCoche.ParamAffichCompteObjet.Dataset<>nil)then
begin
  LibChoixComptesCoche.ParamAffichCompteObjet.Dataset.close;
  //LibChoixComptesCoche.ParamAffichCompteObjet.Dataset.Free;
  LibChoixComptesCoche.ParamAffichCompteObjet.Dataset:=nil;
end;
LibereParamAffichCompte(LibChoixComptesCoche.ParamAffichCompteObjet);
LibChoixComptesCoche.free;
end;


end;




Function ChoixCompteAffichCoche(var ParamAffichCompte:TParamAffichCompte):TResultStrList;
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
LibChoixComptesCoche.Free;
LibChoixComptesCoche:=nil;
if LibChoixComptesCoche <> nil then
LibChoixComptesCoche.Destroy;
LibChoixComptesCoche:=TLibChoixComptesCoche.Create(Application.MainForm);
initialiseEcran;
LibChoixComptesCoche.ParamAffichCompteObjet:=ParamAffichCompte;
LibChoixComptesCoche.ParamAffichCompteObjet.Dataset:=CloneDataSet(ParamAffichCompte.Dataset,LibChoixComptesCoche.ParamAffichCompteObjet.Dataset);
if LibChoixComptesCoche.ParamAffichCompteObjet.Titre='' then
  LibChoixComptesCoche.ParamAffichCompteObjet.Titre := 'Sélectionnez les comptes...';
ordretri:=1;

if(ParamAffichCompte.TitreChamp<>nil)and(ParamAffichCompte.TitreChamp.Count>0)then
begin
setlength(LibChoixComptesCoche.ParamAffichCompteObjet.ListeChampsArray,(ParamAffichCompte.TitreChamp.Count));
for i:=0 to  (ParamAffichCompte.TitreChamp.Count-1) do
  LibChoixComptesCoche.ParamAffichCompteObjet.ListeChampsArray[i] :=ParamAffichCompte.TitreChamp.Strings[i];
end
else
begin
setlength(LibChoixComptesCoche.ParamAffichCompteObjet.ListeChampsArray,(ParamAffichCompte.ListeChamps.Count));
for i:=0 to  (ParamAffichCompte.ListeChamps.Count-1) do
  LibChoixComptesCoche.ParamAffichCompteObjet.ListeChampsArray[i] :=ParamAffichCompte.ListeChamps.Strings[i];
end;

if(ParamAffichCompte.longueurChamp<>nil)and(ParamAffichCompte.longueurChamp.Count>0)then
begin
setlength(LibChoixComptesCoche.ParamAffichCompteObjet.longueurChampArray,(ParamAffichCompte.longueurChamp.Count));
for i:=0 to  (ParamAffichCompte.longueurChamp.Count-1) do
  LibChoixComptesCoche.ParamAffichCompteObjet.longueurChampArray[i] :=StrToInt_Lgr(ParamAffichCompte.longueurChamp.Strings[i]);
end
else
begin
setlength(LibChoixComptesCoche.ParamAffichCompteObjet.longueurChampArray,(ParamAffichCompte.ListeChamps.Count));
for i:=0 to  (ParamAffichCompte.ListeChamps.Count-1) do
  LibChoixComptesCoche.ParamAffichCompteObjet.longueurChampArray[i] :=150;
end;

if @ParamAffichCompte.EventButtonAjouterClick<>nil then
 LibChoixComptesCoche.BtnAjouter.OnClick := ParamAffichCompte.EventButtonAjouterClick
 else LibChoixComptesCoche.BtnAjouter.OnClick := nil;


if @ParamAffichCompte.EventButtonSupprimerClick<>nil then
 LibChoixComptesCoche.BtnSupprimer.OnClick := ParamAffichCompte.EventButtonSupprimerClick
 else LibChoixComptesCoche.BtnSupprimer.OnClick := nil;

LibChoixComptesCoche.initialiseCombox;
LibChoixComptesCoche.CheckBox1.Visible:=ParamAffichCompte.titreSautDePage<>'';
LibChoixComptesCoche.CheckBox1.Caption:=ParamAffichCompte.titreSautDePage;
LibChoixComptesCoche.CheckBox1.Checked:=ParamAffichCompte.sautDePage;

LibChoixComptesCoche.BtnSupprimer.Visible:= @LibChoixComptesCoche.BtnSupprimer.OnClick<>nil;
LibChoixComptesCoche.BtnAjouter.Visible:= @LibChoixComptesCoche.BtnAjouter.OnClick<>nil;

//LibChoixComptesCoche.edit1.Text := IntToStr_Lgr(LibChoixComptesCoche.ParamAffichCompteObjet.FiltreNbChiffre);
if dmrech = nil then dmrech := Tdmrech.Create(Application.MainForm);
DeFiltrageDataSet(LibChoixComptesCoche.ParamAffichCompteObjet.Dataset);
result.Result:=LibChoixComptesCoche.ShowModal = MrOk;
if (result.Result) then     //and(ListeFiltreAffich.Count<>0)
 begin
    result.Result:=ListeFiltreAffich.Count>0;
    result.Liste:=ListeFiltreAffich;
    result.Regrouper := LibChoixComptesCoche.ParamAffichCompteObjet.Regrouper;
    ParamAffichCompte:=LibChoixComptesCoche.ParamAffichCompteObjet;
 end;
finally
if(LibChoixComptesCoche.ParamAffichCompteObjet.Dataset<>nil)then
begin
  LibChoixComptesCoche.ParamAffichCompteObjet.Dataset.close;
  //LibChoixComptesCoche.ParamAffichCompteObjet.Dataset.Free;
  LibChoixComptesCoche.ParamAffichCompteObjet.Dataset:=nil;
end;
LibereParamAffichCompte(LibChoixComptesCoche.ParamAffichCompteObjet);
//LibereParamAffichCompte(ParamAffichCompte);
//LibChoixComptesCoche.Destroy;
LibChoixComptesCoche.free;
end;
End;


procedure TLibChoixComptesCoche.BtnEnregistrerClick(Sender: TObject);
var
i,j:integer;
ligne:string;
begin
ListeFiltreAffich.Clear;
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
    if RxChListCpt.items[i].Checked then
//      if ParamAffichCompteObjet.Regrouper>0 then
//        begin
//            ListeFiltreAffich.Add(str_n_prem_char(RxChListCpt.items[i].SubItems[0],ParamAffichCompteObjet.Regrouper));
//        end
//      else
ligne:='';
        if(ParamAffichCompteObjet.retourEntier)then
          begin
             for j:=0 to RxChListCpt.items[i].SubItems.Count-1 do
               ligne:=ligne+RxChListCpt.items[i].SubItems[j]+';';
             listeFiltreaffich.add(ligne);
          end
        else
        ListeFiltreAffich.Add(RxChListCpt.items[i].SubItems[0]);
   End;
ModalResult := mrOk;
end;

procedure TLibChoixComptesCoche.BtnInverserClick(Sender: TObject);
 var
i:integer;
begin
ListeFiltreAffich.Clear;
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
     RxChListCpt.items[i].Checked:=not RxChListCpt.items[i].Checked;
   RxChListCpt.items[i].Selected:= RxChListCpt.items[i].Checked;
    if RxChListCpt.items[i].Checked then
     ListeFiltreAffich.Add(ListeCpt.Strings[i]);
   End;

end;

procedure TLibChoixComptesCoche.FormDestroy(Sender: TObject);
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
LibChoixComptesCoche:=nil;
end;

procedure TLibChoixComptesCoche.BtnAnnuleSelectionClick(Sender: TObject);
var
i:integer;
begin
ListeFiltreAffich.Clear;
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
    RxChListCpt.items[i].Selected:=false;
    RxChListCpt.items[i].Checked:=false;
   End;

end;

procedure TLibChoixComptesCoche.BtnClasse1Click(Sender: TObject);
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


procedure TLibChoixComptesCoche.InitDataset(Dataset : TDataset);
var
ListeTmp:Tstringlist;
Valeur:string;
j,i:integer;
begin
Screen.Cursor := crSQLWait;
RxChListCpt.Clear;
ListeCpt.Clear;
ListeTmp:=Tstringlist.Create;
ListeTmp.Clear;
Dataset.first;
ListeTmp.Duplicates:=dupIgnore;
while not Dataset.eof do
   Begin
    i:=0;
    valeur:='';
    while (i<=ParamAffichCompteObjet.ListeChamps.Count-1)do
    begin
        if ParamAffichCompteObjet.ListeChamps.Strings[i]<>'' then
            if valeur<>'' then
              Valeur:=Valeur+';'+Dataset.findfield(ParamAffichCompteObjet.ListeChamps.Strings[i]).AsString
            else
              Valeur:=Dataset.findfield(ParamAffichCompteObjet.ListeChamps.Strings[i]).AsString;
    inc(i);
    end;
    ListeTmp.Add(Valeur+';');
    ListeCpt.add(Dataset.findfield(ParamAffichCompteObjet.ListeChamps.Strings[0]).AsString);
    Dataset.Next;
   End;
InitLisViewAvecListeCochable(RxChListCpt,ParamAffichCompteObjet.ListeChampsArray,ListeTmp,ParamAffichCompteObjet.longueurChampArray,true,true).Free;
for i:=0 to ParamAffichCompteObjet.ListeChamps.Count-1 do
  cbChamp.Items.Add(ParamAffichCompteObjet.ListeChamps.Strings[i]);
Self.FormResize(nil);
Screen.Cursor := crDefault;
end;
procedure TLibChoixComptesCoche.BtnAnnulerClick(Sender: TObject);
begin
ModalResult:=mrCancel;
end;

procedure TLibChoixComptesCoche.Tous1Click(Sender: TObject);
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

procedure TLibChoixComptesCoche.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin 
WinSuivPrec(Handle,key,[RxChListCpt,BtnAnnuler,BtnEnregistrer,BtnInverser,BtnAnnuleSelection]);
   If Key = VK_ESCAPE Then
     Begin
      ModalResult:= mrCancel;
     end;
end;

procedure TLibChoixComptesCoche.FormCreate(Sender: TObject);
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

procedure TLibChoixComptesCoche.TousSelectionner();
 var
i:integer;
begin
if ListeFiltreAffich=nil then ListeFiltreAffich :=TStringList.Create;
ListeFiltreAffich.Clear;
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
     RxChListCpt.items[i].Selected:=true;
     RxChListCpt.items[i].Checked:=true;
     ListeFiltreAffich.Add(ListeCpt.Strings[i]);
   End;
end;


procedure TLibChoixComptesCoche.FormShow(Sender: TObject);
begin
Label3.Tag:=0;
//Champrecherchesuivant1.Click;
Tous1.Click;
TousSelectionner();
cbChamp.ItemIndex:=0;
end;


procedure TLibChoixComptesCoche.EdRechChange(Sender: TObject);
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

procedure TLibChoixComptesCoche.FormActivate(Sender: TObject);
begin
RxLabTitre.Caption:=ParamAffichCompteObjet.Titre;
PaTitrePetit.Caption:=ParamAffichCompteObjet.SousTitre;
EdRech.Text:='';
EdRech.SetFocus;
Label3.Tag:=0;
//Champrecherchesuivant1.Click;
SetMessErreur('');
cbChamp.ItemIndex:=0;
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

procedure TLibChoixComptesCoche.Champrecherchesuivant1Click(Sender: TObject);
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

procedure TLibChoixComptesCoche.RxChListCptColumnClick(Sender: TObject;
  Column: TListColumn);
begin
OrdreTri:=-OrdreTri;
if Column.Index > 0 then
 RxChListCpt.CustomSort(nil, Column.Index-1)
else
 RxChListCpt.CustomSort(nil, Column.Index)
end;

procedure TLibChoixComptesCoche.RxChListCptCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
if DAta >= 0 then
compare:=OrdreTri*StrComp(PChar(Item1.SubItems.Strings[Data]),PChar(Item2.SubItems.Strings[Data]))
else
compare:=OrdreTri*StrComp(PChar(TListItem(Item1).Caption),PChar(TListItem(Item2).Caption));
end;

procedure TLibChoixComptesCoche.RxChListCptDblClick(Sender: TObject);
var
item:Tlistitem;
begin
item:=RxChListCpt.Selected;
DeCocheAll;
RxChListCpt.Selected:=item;
if(RxChListCpt.Selected<>nil)then RxChListCpt.Selected.Checked:=true;
BtnEnregistrer.Click;
end;

procedure TLibChoixComptesCoche.RxChListCptKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
if key=VK_RETURN then BtnEnregistrer.Click;
end;

function TLibChoixComptesCoche.ValidateInput(Value : string):boolean;
var
str,Mess:String;
I:integer;
begin
  For I := 1 To Length(Value) Do
    If not(Value[I] in C_Validate) Then
  Begin
    str:=str+value[i];
  end;
  if(not (str=EmptyStr))then Mess:='le caractère : "'+str+'" n''est pas autorisé'
    else if(Length(value)>C_Longueur)then Mess:='Vous ne devez pas dépasser '+IntToStr(LongueurLocale)+' caractères'
     else Mess:='';
  SetMessErreur(Mess) ;
  result := Mess=EmptyStr;
end;

procedure TLibChoixComptesCoche.SetMessErreur(const Value: String);
begin
  LabelErreur.Caption := Value;
end;





procedure TLibChoixComptesCoche.Edit1KeyPress(Sender: TObject; var Key: Char);
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
Param.TitreChamp:=TStringList.Create;
param.longueurChamp:=TStringList.Create;
SetLength(param.ListeChampsArray,0);
SetLength(param.longueurChampArray,0);
Param.FiltreNbChiffre:=3;
Param.EventButtonAjouterClick:=nil;
Param.EventButtonSupprimerClick:=nil;
Param.ListeItemAction:=TStringListLGR1.Create;
param.retourEntier:=false;
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
Initialise_TStringlist(Param.TitreChamp);
Initialise_TStringlist(Param.longueurChamp);
SetLength(param.ListeChampsArray,0);
Finalize(param.ListeChampsArray);
SetLength(param.longueurChampArray,0);
Finalize(param.longueurChampArray);
Param.FiltreNbChiffre:=3;
Param.EventButtonAjouterClick:=nil;
Param.EventButtonSupprimerClick:=nil;
end;

procedure TLibChoixComptesCoche.Edit2Change(Sender: TObject);
begin
 ValidateInput(Edit2.Text);
 ParamAffichCompteObjet.Regrouper:=StrToInt_Lgr(Edit2.text,8);
end;





procedure TLibChoixComptesCoche.ComboBox1Click(Sender: TObject);
var
ExecProcedure:TProcedure;
begin
@ExecProcedure:=ComboBox1.Items.Objects[ComboBox1.ItemIndex];
if @ExecProcedure<>nil then
  ExecProcedure;
ComboBox1.ItemIndex:=0;
end;


procedure TLibChoixComptesCoche.initialiseCombox;
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
procedure TLibChoixComptesCoche.ComboBox1DrawItem(Control: TWinControl;
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
//    //dessin des icônes
//    marge := (Rect.Bottom - Rect.Top - imageList1.Height) div 2;
//    imagelist1.Draw(ComboBox1.canvas, Rect.Left + 4, Rect.Top + marge, Index);
  end;
end;
procedure TLibChoixComptesCoche.CheckBox1Click(Sender: TObject);
begin
ParamAffichCompteObjet.sautDePage:=CheckBox1.State=cbChecked;
end;

procedure TLibChoixComptesCoche.BtnSupplTypeTiersClick(Sender: TObject);
var
ListeCpt:TResultStrList;
Requete : TQuery;
filtre:string;
ParamAffichCompte:TParamAffichCompte;
ChoixCompte:TLibChoixComptesCoche;
begin
try
    requete := TQuery.Create(application.MainForm);
    //pour récupérer les types de tiers
    ListeCpt.Liste:=TStringList.Create;
    ListeCpt.result:=true;
    requete.DatabaseName :=DM_C_NomAliasDossier;
    requete.SQL.Add(' select distinct type,compte from tiers T');
    requete.Open;
    requete.First;
    Filtre:='';
    ChoixCompte:=TLibChoixComptesCoche.Create(Application.MainForm);
                  InitialiseParamAffichCompte(ParamAffichCompte);
                  ParamAffichCompte.Titre:= 'Sélectionnez les types de tiers ...';
                  ParamAffichCompte.Tiers:=true;
                  ParamAffichCompte.Dataset:=requete;
                  ParamAffichCompte.ListeChamps.Add('type');
                  ParamAffichCompte.ListeChamps.Add('compte');

    listecpt:=ChoixCompte.ChoixCompteAffich(ParamAffichCompte);
    if(ListeCpt.Result) and (ListeCpt.Liste.Count>0)then
    begin
      filtre:=CreeFiltreOU('type',[ListeCpt.Liste]);
      LibChoixComptesCoche.ParamAffichCompteObjet.Dataset.Filtered := false;
      LibChoixComptesCoche.ParamAffichCompteObjet.Dataset.Filter :=Filtre;
      LibChoixComptesCoche.ParamAffichCompteObjet.Dataset.Filtered := True;
      LibChoixComptesCoche.InitDataset(LibChoixComptesCoche.ParamAffichCompteObjet.Dataset);
      LibChoixComptesCoche.RxChListCpt.SelectAll;
    end;
    //ChoixCompte.Destroy;
    requete.close;
    requete.SQL.Clear;
except
end;
end;

procedure TLibChoixComptesCoche.RxChListCptMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
item:TListItem;
begin
item:=RxChListCpt.GetItemAt(x,y);
if item<>nil then
  begin
      if itemRxChListCptCoche<>item.Checked then RxChListCptChecked(item);
  end;

end;

procedure TLibChoixComptesCoche.RxChListCptChecked(item:TListItem);
begin
  if item<>nil then
  begin
    item.Selected:=item.Checked;
  end;
end;



procedure TLibChoixComptesCoche.RxChListCptMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
item:Tlistitem;
begin
item:=RxChListCpt.GetItemAt(x,y);
if item<>nil then
  itemRxChListCptCoche:=item.Checked;
end;


procedure TLibChoixComptesCoche.DeCocheAll();
var
i:integer;
begin
  for i:=0 to RxChListCpt.Items.Count-1 do
  begin
     RxChListCpt.items[i].Checked:=false;
     RxChListCpt.items[i].Selected:=false;
  end;
end;

procedure TLibChoixComptesCoche.DeSelectAll();
var
i:integer;
begin
  for i:=0 to RxChListCpt.Items.Count-1 do
  begin
     RxChListCpt.items[i].Selected:=false;
  end;
end;

procedure initialiseEcran;
begin
  LibChoixComptesCoche.Width:=565;
  LibChoixComptesCoche.Height:=538;
end;
procedure TLibChoixComptesCoche.FormResize(Sender: TObject);
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

procedure TLibChoixComptesCoche.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnInverser,BtnAnnuleSelection],PaBtn,90,0);
end;

procedure TLibChoixComptesCoche.cbChampSelect(Sender: TObject);
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

end.
