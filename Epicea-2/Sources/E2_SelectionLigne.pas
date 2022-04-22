unit E2_SelectionLigne;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,DMImmo_Clot,
  Grids, DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid, StdCtrls,LibSql,db,GR_Librairie_Obj,
  Mask, ToolEdit, CurrEdit, RXCtrls, ExtCtrls, Menus,E2_Librairie_Obj,DMConstantes,
  lib_chaine,
  LibGestionParamXML,
  Variants;

type
  TSelectionLigne = class(TForm)
    Patitre: TPanel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    PaBas: TPanel;
    CurrencyEdit1: TCurrencyEdit;
    Label1: TLabel;
    PaFond: TPanel;
    PaListe: TPanel;
    PaGrille: TPanel;
    GrDBGrid1: TGrDBGrid;
    ListLigneSelect: TListBox;
    PaBtnSelection: TPanel;
    RxSpeedButton1: TRxSpeedButton;
    RxSpeedButton2: TRxSpeedButton;
    RxSpeedButton3: TRxSpeedButton;
    RxSpeedButton4: TRxSpeedButton;
    CBoxCompte: TComboBox;
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
    Label2: TLabel;
    procedure GrDBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListLigneSelectDblClick(Sender: TObject);
    procedure ListLigneSelectEnter(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure RxSpeedButton3Click(Sender: TObject);
    procedure RxSpeedButton4Click(Sender: TObject);
    procedure RxSpeedButton2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CBoxCompteChange(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    Compte:string;
    DateExoDebut,DateExoFin:Tdatetime;
  end;

var
  SelectionLigne: TSelectionLigne;
  ListeSelection:TStringList;
  ListeValeur:TListInteger;

Function AideSelectionImmoEnCours(DataSet:TDataSet;Cpt:string;DateDebut,DateFin:Tdatetime):Boolean;
implementation

uses E2_Main, LibRessourceString;

{$R *.DFM}
Function AideSelectionImmoEnCours(DataSet:TDataSet;Cpt:string;DateDebut,DateFin:Tdatetime):Boolean;
var
i:integer;
NewCode,ID:integer;
Begin
if not dataSet.Active then DataSet.Open;
   if Dataset.State in [dsInsert,dsEdit] then
   begin
    TableGerePost(Dataset);
   end;

if SelectionLigne=nil then SelectionLigne:=TSelectionLigne.create(Application.MainForm);
  SelectionLigne.Compte:=Cpt;
  SelectionLigne.DateExoDebut:=DateDebut;
  SelectionLigne.DateExoFin:=DateFin;

result:=SelectionLigne.ShowModal=mrOk;
if result then
 Begin
   if Dataset.State in [dsBrowse] then
   begin
    NewCode:=DMImmo_Clo.MaxCode;
    DMImmo_Clo.InitTotauxCompteSelectionne(ListeSelection);
    DMImmo_Clo.QuTotauxCompte.DisableControls;
    DMImmo_Clo.QuTotauxCompte.First;
    if ListeSelection.Count > 0 then
    while not DMImmo_Clo.QuTotauxCompte.EOF do
     Begin
     ID:=MaxId_Query(DMImmo_clo.TaImmo_Clo,'ID');
      DataSet.AppendRecord([ID,NewCode,null,DMImmo_clo.QuTotauxCompteCompte.AsString,'',
                            'Immo Code : ' + inttostr(NewCode),0,DMImmo_clo.QuTotauxCompteTotalDebit.AsCurrency,
                            null,E.DatExoFin,1]);
      DMImmo_Clo.QuTotauxCompte.Next;
     End;
   end;
 End;
DMImmo_Clo.QuListeCharge.EnableControls;
End;

procedure TSelectionLigne.GrDBGrid1DblClick(Sender: TObject);
var
Valeur:integer;
ValCurr:currency;
begin
if DMImmo_Clo.QuListeCharge.RecordCount > 0 then
  Begin
    ListLigneSelect.Items.Add(DMImmo_Clo.QuListeCharge.findfield('Reference').AsString + '  ' +
                              DMImmo_Clo.QuListeCharge.findfield('Compte').AsString + '  ' +
                              DMImmo_Clo.QuListeCharge.findfield('Date').AsString + '  ' +
                              FormatFloat('# ##0.00 ' + currencyStringEpicea + ';; ',DMImmo_Clo.QuListeCharge.findfield('DebitSaisie').Ascurrency));
    ListeSelection.Add(DMImmo_Clo.QuListeCharge.findfield('ID').AsString);
    ValCurr:=DMImmo_Clo.QuListeCharge.findfield('DebitSaisie').AsCurrency*100;
    Valeur:=strtoint_lgr(CurrToStr(ValCurr));
    ListeValeur.Add(Valeur);
    DMImmo_Clo.QuListeCharge.Filter:='not ('+CreeFiltreOU('ID',[ListeSelection])+')';
    CurrencyEdit1.Value:=SommeListeInt(ListeValeur,0,ListeValeur.Count-1) / 100;
  End
 else showmessage('Pas de charges disponibles!');
end;

procedure TSelectionLigne.FormCreate(Sender: TObject);
begin
 if DMImmo_Clo=nil then
 DMImmo_Clo:=TDMImmo_Clo.Create(self);

ListeValeur:=TListInteger.Create;
ListeSelection:=TStringList.Create;
//ListeSelection.Sorted:=true;
//ListeSelection.Duplicates:=dupIgnore;
//DMImmo_Clo.QuListeCharge.ParamByName('Cpt').AsString:=Compte;
//DMImmo_Clo.QuListeCharge.ParamByName('DateDebut').Asdatetime:=DateExoDebut;
//DMImmo_Clo.QuListeCharge.ParamByName('DateFin').Asdatetime:=DateExoFin;
//DMImmo_Clo.QuListeCharge.Open;
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;

procedure TSelectionLigne.FormDestroy(Sender: TObject);
begin
ListeSelection.Free;
ListeValeur.Free;
LibGestionParamXML.DestroyForm(Self,E.User);
if DMImmo_Clo<>nil then DMImmo_Clo.Free;
SelectionLigne:=nil;
end;

procedure TSelectionLigne.ListLigneSelectDblClick(Sender: TObject);
var
i:integer;
begin
i:=ListLigneSelect.ItemIndex;
//i:=ListeSelection.IndexOf(ListLigneSelect.Items.Strings[ListLigneSelect.ItemIndex]);
//i:=ListeSelection.IndexOf(TStringField(ListLigneSelect.Items.Objects[ListLigneSelect.ItemIndex]).AsString);
if i <> -1 then begin
 ListeSelection.Delete(i);
 ListLigneSelect.Items.Delete(i);
 ListeValeur.Delete(i);
 CurrencyEdit1.Value:=SommeListeInt(ListeValeur,0,ListeValeur.Count-1)/ 100;
 DMImmo_Clo.QuListeCharge.Filter:='not ('+CreeFiltreOU('ID',[ListeSelection])+')';
 end
 else showmessage('La sélection est vide !');
end;

procedure TSelectionLigne.ListLigneSelectEnter(Sender: TObject);
begin
if ListLigneSelect.ItemIndex = -1 then
 if ListLigneSelect.Items.Count > 0 then
  ListLigneSelect.ItemIndex:=0;
end;

procedure TSelectionLigne.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key = #43 then   // +
 begin
 GrDBGrid1DblClick(GrDBGrid1);
 key:=#0;
 end;
if key = #45 then  // -
 begin
 ListLigneSelect.SetFocus;
 if ListLigneSelect.ItemIndex = -1 then
    if ListLigneSelect.Items.Count > 0 then
      begin
  ListLigneSelect.ItemIndex:=ListLigneSelect.Items.Count-1;
         key:=#0;
         exit;
      end;
 ListLigneSelectDblClick(ListLigneSelect);
 if ListLigneSelect.Items.Count > 0 then
  ListLigneSelect.ItemIndex:=ListLigneSelect.Items.Count-1;
 key:=#0;
 end;
end;

procedure TSelectionLigne.RxSpeedButton3Click(Sender: TObject);
Var
ch:char;
begin
ch:=#45;
FormKeyPress(self,ch);
end;

procedure TSelectionLigne.RxSpeedButton4Click(Sender: TObject);
begin
while ListLigneSelect.Items.Count > 0 do RxSpeedButton3Click(RxSpeedButton3);
end;

procedure TSelectionLigne.RxSpeedButton2Click(Sender: TObject);
begin
DMImmo_Clo.QuListeCharge.DisableControls;
while DMImmo_Clo.QuListeCharge.RecordCount > 0 do GrDBGrid1DblClick(GrDBGrid1);
DMImmo_Clo.QuListeCharge.EnableControls;
end;

procedure TSelectionLigne.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
DMImmo_Clo.QuListeCharge.close;
DMImmo_Clo.QuListeCharge.ParamByName('Cpt').AsString:=Compte;
DMImmo_Clo.QuListeCharge.ParamByName('DebutExo').Asdatetime:=DateExoDebut;
DMImmo_Clo.QuListeCharge.ParamByName('FinExo').Asdatetime:=DateExoFin;
DMImmo_Clo.QuListeCharge.Open;
CBoxCompte.Items:=ListeCompteCharge(compte,DateExoDebut,DateExoFin);
CBoxCompte.Items.Insert(0,'    <<        Tous        >>  ');
CBoxCompte.ItemIndex:=0;
end;

procedure TSelectionLigne.CBoxCompteChange(Sender: TObject);
begin
if CBoxCompte.ItemIndex=0 then
    Begin
     DMImmo_Clo.QuListeCharge.DisableControls;
     DMImmo_Clo.QuListeCharge.ParamByName('Cpt').AsString:=Compte;
     DMImmo_Clo.QuListeCharge.ParamByName('DateDebut').Asdatetime:=DateExoDebut;
     DMImmo_Clo.QuListeCharge.ParamByName('DateFin').Asdatetime:=DateExoFin;
     DMImmo_Clo.QuListeCharge.Close;
     DMImmo_Clo.QuListeCharge.Open;
     DMImmo_Clo.QuListeCharge.EnableControls;
    End
     else
    if CBoxCompte.ItemIndex > 0 then
    Begin
     DMImmo_Clo.QuListeCharge.DisableControls;
     DMImmo_Clo.QuListeCharge.ParamByName('Cpt').AsString:=CBoxCompte.Items[CBoxCompte.ItemIndex];
     DMImmo_Clo.QuListeCharge.ParamByName('DateDebut').Asdatetime:=DateExoDebut;
     DMImmo_Clo.QuListeCharge.ParamByName('DateFin').Asdatetime:=DateExoFin;
     DMImmo_Clo.QuListeCharge.Close;
     DMImmo_Clo.QuListeCharge.Open;
     DMImmo_Clo.QuListeCharge.EnableControls;
     End;
end;

procedure TSelectionLigne.BtnEnregistrerClick(Sender: TObject);
begin
//self.ModalResult:=mrOk;
//self.Close;
end;

procedure TSelectionLigne.BtnFermerClick(Sender: TObject);
begin
self.close;
//showmessage(inttostr(DMImmo_Clo.MaxCode));
end;

end.
