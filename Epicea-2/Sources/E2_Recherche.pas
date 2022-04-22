unit E2_Recherche;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids, DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid, Db,
  DBTables,
  Lib_Chaine,
  RxQuery, RXCtrls,LibDates, Menus;

type
  TTypeChampRequete=(fCNormal,fcSum,fcInconnu);
  TMyCustomGrid = class(TCustomGrid)
//  property cellRect;
  property row;
  property Col;
   end;
  TRecherche = class(TForm)
    PaFond: TPanel;
    Patitre: TPanel;
    BtnClose: TButton;
    PaGrille: TPanel;
    DBGrille: TGrDBGrid;
    PaBas: TPanel;
    EdRec: TEdit;
    RxQueryRec: TRxQuery;
    DaRec: TDataSource;
    Button1: TButton;
    RxLabel1: TRxLabel;
    PopupMenu1: TPopupMenu;
    Champsuivant1: TMenuItem;
    procedure PatitreResize(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure AfficheAvecParentGrid(Hote:TCustomGrid);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure EdRecChange(Sender: TObject);
    procedure EdRecKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AfficheAvecParentEdit(Hote:TCustomEdit);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure EdRecKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrilleDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Champsuivant1Click(Sender: TObject);
    procedure initWhere(texte:string);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    TypeSaisieDate:Boolean;
    ChampCourant:integer;
    champType:array[0..20] of Tfieldtype;
    TypeChampRequete:array [0..20] of TTypeChampRequete;
  end;

var
  Recherche: TRecherche;
  champRecherche:TField;

Function Rechercher(Hote:Tcomponent;Table:TDataSet;Champs,titre : array of string;Texte:string;DelFilter:integer):boolean;
Function RechercherQu(Hote:Tcomponent;Query:TDataSet;Champs,titre : array of string;Texte:string;DelFilter:integer;NomTable:String):boolean;
Function Rechercher_AvecJointure(Hote:Tcomponent;Table:TDataSet;Jointure,GroupBy,Champs,titre : array of string;Texte:string;DelFilter:integer):boolean;


implementation
uses Gr_Librairie_obj;

{$R *.DFM}


Function Rechercher(Hote:Tcomponent;Table:TDataSet;Champs,titre : array of string;Texte:string;DelFilter:integer):boolean;
//Sous fonction d'initialisation de la grille
Function InitGrille(Table:TDataSet;Champs,titre : array of string;texte:string):boolean;
var
i:integer;
ChampSansNomDeTable:string;
begin
if Recherche = nil then Recherche:=TRecherche.Create(Application.MainForm);
 Recherche.RxQueryRec.Active:=false;
 Recherche.RxQueryRec.DatabaseName:=TTable(Table).DatabaseName;
 Recherche.RxQueryRec.SQL.Clear;
 Recherche.RxQueryRec.SQL.Add('Select ');
 Recherche.RxQueryRec.SQL.Add(Champs[0]);
 for i:= 1 to high(Champs) do
  Begin
    if Uppercase(Champs[i])='DATE' then
      begin
        Recherche.RxQueryRec.SQL.Add(', ('+TTable(Table).TableName+'."'+Champs[i]+'") as Date_');
        Champs[i]:='Date_';
      end
    else
      Recherche.RxQueryRec.SQL.Add(', '+Champs[i]);
  end;
 Recherche.RxQueryRec.SQL.Add(' from ');
 Recherche.RxQueryRec.SQL.Add(TTable(Table).TableName);
 champRecherche:=Table.findfield(Champs[0]);
 Recherche.initWhere(texte);
// if(texte<>'')then
//   begin
//     Recherche.RxQueryRec.SQL.Add(' where ');
//     case (Table.findfield(Champs[0]).DataType)of
//        ftString:begin
//                       Recherche.RxQueryRec.SQL.Add('upper('+Champs[0]+') like(upper(:Valeurs))');
//                       Recherche.RxQueryRec.SQL.Add(';');
//                       Recherche.RxQueryRec.Params[0].DataType:=Table.findfield(Champs[0]).DataType;
//                       Recherche.RxQueryRec.ParamByName('Valeurs').AsString:='%'+texte+'%';
//                 end;
//        ftInteger,ftCurrency,ftFloat:
//                 begin
//                      Recherche.RxQueryRec.SQL.Add(Champs[0]+'=:Valeurs');
//                      Recherche.RxQueryRec.SQL.Add(';');
//                      Recherche.RxQueryRec.Params[0].DataType:=Table.findfield(Champs[0]).DataType;
//                      Recherche.RxQueryRec.ParamByName('Valeurs').AsFloat:=StrToFloat_Lgr(texte);
//                 end;
//        ftDate,ftTimeStamp:
//                 begin
//                     Recherche.RxQueryRec.SQL.Add(Champs[0]+'=:Valeurs');
//                      Recherche.RxQueryRec.SQL.Add(';');
//                      Recherche.RxQueryRec.Params[0].DataType:=Table.findfield(Champs[0]).DataType;
//                      Recherche.RxQueryRec.ParamByName('Valeurs').AsDateTime:=StrToDate_Lgr(texte);
//                 end;
//     end;//fin case
//   end;
// Recherche.RxQueryRec.SQL.Add('upper('+Champs[0]+') like(upper(:Valeurs))');
// Recherche.RxQueryRec.SQL.Add(';');
//Recherche.RxQueryRec.Params[0].DataType:=Table.findfield(Champs[0]).DataType;
// Recherche.RxQueryRec.ParamByName('Valeurs').AsString:='%'+texte+'%';
 Recherche.RxQueryRec.Filter:=table.Filter;
 Recherche.RxQueryRec.Filtered:=table.Filtered;
 if @table.OnFilterRecord <> nil then
       Recherche.RxQueryRec.OnFilterRecord :=table.OnFilterRecord;
 Recherche.DBGrille.DataSource:=nil;
 Recherche.RxQueryRec.Active:=true;
 Recherche.DBGrille.Columns.RebuildColumns;
 Recherche.DBGrille.DataSource:=Recherche.DaRec;
 for i:=0 to high(Titre) do
   if not empty(titre[i]) then
     begin
      if  str_getstringelement(Champs[i],2,'.')='' then
        ChampSansNomDeTable:=Champs[i]
      else
        ChampSansNomDeTable:=str_getstringelement(Champs[i],2,'.');
      Recherche.DBGrille.Columns.Add.Field:=Recherche.RxQueryRec.FieldByName(ChampSansNomDeTable);
      Recherche.champType[i]:=(Recherche.RxQueryRec.FieldByName(ChampSansNomDeTable).DataType);
      Recherche.TypeChampRequete[i]:=fcNormal;
      Recherche.DBGrille.Columns[i].Title.Caption:=Titre[i];
      if Recherche.DBGrille.Columns[i].Width > 200 then Recherche.DBGrille.Columns[i].Width:=200;
     end;
Recherche.RxLabel1.Caption:= 'Saisissez ici votre '+Recherche.DBGrille.Columns[0].Title.Caption;
Recherche.Patitre.Caption:= 'Recherche sur '+Recherche.DBGrille.Columns[0].Title.Caption;
//upper(PlanCPTE.Libelle) like(upper(:Libel))
end;

begin
if(Recherche = Nil) then
    Recherche:= TRecherche.Create(Application.MainForm);
if Hote <> nil then
 case RecupClassTypeComponent(Hote) of
   GTDBGrid,GTGrid,GTGrDBGrid,GTGrGrid:begin
              Recherche.AfficheAvecParentGrid(Hote as TCustomGrid);
              InitGrille(Table,Champs,titre,Recherche.EdRec.text);
              Recherche.EdRec.Text:=Texte;
              Recherche.EdRec.SelectAll;
            end;
   GTEdit:Begin
              Recherche.AfficheAvecParentEdit(Hote as TCustomEdit);
              InitGrille(Table,Champs,titre,Recherche.EdRec.text);
              Recherche.EdRec.Text:=Texte;
              Recherche.EdRec.SelectAll;
          End;

   GTDBEdit:Begin
              Recherche.AfficheAvecParentEdit(Hote as TCustomEdit);
              InitGrille(Table,Champs,titre,Recherche.EdRec.text);
              Recherche.EdRec.Text:=Texte;
              Recherche.EdRec.SelectAll;
          End;

   GTInconnu:beep;
 end;
Recherche.EdRec.Width:=Recherche.DBGrille.Columns[0].Width;
result:=(Recherche.Showmodal=mrOk);
if result then Table.Locate(Champs[0],Recherche.RxQueryRec.findfield(Champs[0]).AsString,[]);
Recherche.RxQueryRec.OnFilterRecord := nil;
end;


Function Rechercher_AvecJointure(Hote:Tcomponent;Table:TDataSet;Jointure,GroupBy,Champs,titre : array of string;Texte:string;DelFilter:integer):boolean;
//Sous fonction d'initialisation de la grille
Function InitGrille(Table:TDataSet;Champs,titre : array of string;texte:string):boolean;
var
i:integer;
NomTableSansExt:string;
begin
if Recherche = nil then Recherche:=TRecherche.Create(Application.MainForm);
 NomTableSansExt:=str_getstringelement(TTable(Table).TableName,1,'.');

 Recherche.RxQueryRec.Active:=false;
 Recherche.RxQueryRec.DatabaseName:=TTable(Table).DatabaseName;
 Recherche.RxQueryRec.SQL.Clear;
 Recherche.RxQueryRec.SQL.Add('Select ');
 Recherche.RxQueryRec.SQL.Add(Champs[0]);
 for i:=1 to high(Champs)do
   Recherche.RxQueryRec.SQL.Add(', '+Champs[i]);
 Recherche.RxQueryRec.SQL.Add(' from ');
 Recherche.RxQueryRec.SQL.Add(TTable(Table).TableName);
 for i:=0 to high(Jointure)do
     recherche.RxQueryRec.sql.Add(' '+jointure[i]);
 Recherche.RxQueryRec.SQL.Add(' Where ');
 Recherche.RxQueryRec.SQL.Add(' upper('+Champs[0]+') like(upper(:Valeurs))');
 for i:=0 to high(GroupBy)do
    recherche.RxQueryRec.sql.Add(' '+GroupBy[i]);
 Recherche.RxQueryRec.SQL.Add(';');
 for i:=1 to high(Champs)do
  Begin
    if str_position_caseInsensitive('sum',champs[i])>0 then Recherche.TypeChampRequete[i]:=fcsum;
    if str_getstringelement(Champs[i],2,'.')<>'' then
     Champs[i]:=str_getstringelement(Champs[i],2,'.');
    Champs[i]:=str_remplacesouschaine(Champs[i],'"','');
    Champs[i]:=str_remplacesouschaine(Champs[i],'(','');
    Champs[i]:=str_remplacesouschaine(Champs[i],')','');
  end;
 Recherche.RxQueryRec.Params[0].DataType:=Table.findfield(Champs[0]).DataType;
 Recherche.RxQueryRec.Params[0].AsString:='%'+texte+'%';
 Recherche.RxQueryRec.Filter:=table.Filter;
 Recherche.RxQueryRec.Filtered:=table.Filtered;
 if @table.OnFilterRecord <> nil then
       Recherche.RxQueryRec.OnFilterRecord :=table.OnFilterRecord;
 Recherche.DBGrille.DataSource:=nil;
 Recherche.RxQueryRec.Active:=true;
 Recherche.DBGrille.Columns.RebuildColumns;
 Recherche.DBGrille.DataSource:=Recherche.DaRec;
 for i:=0 to high(Titre) do
   if not empty(titre[i]) then
     begin
      if str_getstringelement(Champs[i],2,'.')='' then
        begin
          Recherche.DBGrille.Columns.Add.Field:=Recherche.RxQueryRec.FieldByName(champs[i]);
          Recherche.champType[i]:=(Recherche.RxQueryRec.FieldByName(champs[i]).DataType);
        end
      else
        begin
          Recherche.DBGrille.Columns.Add.Field:=Recherche.RxQueryRec.FieldByName(str_getstringelement(Champs[i],2,'.'));
          Recherche.champType[i]:=( Recherche.RxQueryRec.FieldByName(str_getstringelement(Champs[i],2,'.')).DataType);
        end;
      Recherche.DBGrille.Columns[i].Title.Caption:=Titre[i];
      if Recherche.DBGrille.Columns[i].Width > 200 then Recherche.DBGrille.Columns[i].Width:=200;
     end;
Recherche.RxLabel1.Caption:= 'Saisissez ici votre '+Recherche.DBGrille.Columns[0].Title.Caption;
Recherche.Patitre.Caption:= 'Recherche sur '+Recherche.DBGrille.Columns[0].Title.Caption;
end;

begin
if(Recherche = Nil) then
    Recherche:= TRecherche.Create(Application.MainForm);
if Hote <> nil then
 case RecupClassTypeComponent(Hote) of
   GTDBGrid,GTGrid,GTGrDBGrid,GTGrGrid:begin
              Recherche.AfficheAvecParentGrid(Hote as TCustomGrid);
              InitGrille(Table,Champs,titre,Recherche.EdRec.text);
              Recherche.EdRec.Text:=Texte;
              Recherche.EdRec.SelectAll;
            end;
   GTEdit:Begin
              Recherche.AfficheAvecParentEdit(Hote as TCustomEdit);
              InitGrille(Table,Champs,titre,Recherche.EdRec.text);
              Recherche.EdRec.Text:=Texte;
              Recherche.EdRec.SelectAll;
          End;

   GTDBEdit:Begin
              Recherche.AfficheAvecParentEdit(Hote as TCustomEdit);
              InitGrille(Table,Champs,titre,Recherche.EdRec.text);
              Recherche.EdRec.Text:=Texte;
              Recherche.EdRec.SelectAll;
          End;

   GTInconnu:beep;
 end;
Recherche.EdRec.Width:=Recherche.DBGrille.Columns[0].Width;
result:=(Recherche.Showmodal=mrOk);
if result then Table.Locate(Champs[0],Recherche.RxQueryRec.findfield(Champs[0]).AsString,[]);
Recherche.RxQueryRec.OnFilterRecord := nil;
end;



Function RechercherQu(Hote:Tcomponent;Query:TDataSet;Champs,titre : array of string;Texte:string;DelFilter:integer;NomTable:String):boolean;
//Sous fonction d'initialisation de la grille
Function InitGrille(Query:TDataSet;Champs,titre : array of string;texte:string;NomTable:String):boolean;
var
i:integer;
begin
if Recherche = nil then Recherche:=TRecherche.Create(Application.MainForm);
 Recherche.RxQueryRec.Active:=false;
 Recherche.RxQueryRec.DatabaseName:=TQuery(Query).DatabaseName;
 Recherche.RxQueryRec.SQL.Clear;
 Recherche.RxQueryRec.SQL.Add('Select ');
 if UpperCase(Champs[0])='DATE' then
   Recherche.RxQueryRec.SQL.Add(NomTable+'."'+Champs[0]+'"')
  else
  Recherche.RxQueryRec.SQL.Add(Champs[0]);
 for i:= 1 to high(Champs) do
     begin
      if UpperCase(Champs[i])='DATE' then
        Recherche.RxQueryRec.SQL.Add(', '+NomTable+'."'+Champs[i]+'"')
       else
        Recherche.RxQueryRec.SQL.Add(', '+Champs[i]);
     end;
 Recherche.RxQueryRec.SQL.Add(' from ');
 Recherche.RxQueryRec.SQL.Add(NomTable+' where ');

 if UpperCase(Champs[0])='DATE' then
  begin
   Recherche.TypeSaisieDate:=True;
   Recherche.RxQueryRec.SQL.Add(' '+NomTable+'."'+Champs[0]+'"=(:Valeurs)');
   Recherche.RxQueryRec.SQL.Add(';');
   Recherche.RxQueryRec.Params[0].DataType:=Query.findfield(Champs[0]).DataType;
//   Recherche.RxQueryRec.ParamByName('Valeurs').AsDate:=texte;
   end
  else
   begin
     case Query.findfield(Champs[0]).DataType of
        ftString:begin
                  Recherche.RxQueryRec.SQL.Add('upper('+Champs[0]+') like(upper(:Valeurs))');
                  Recherche.RxQueryRec.Params[0].DataType:=Query.findfield(Champs[0]).DataType;
                  Recherche.RxQueryRec.ParamByName('Valeurs').AsString:='%'+texte+'%';
                 end;
        ftCurrency:begin
                    Recherche.RxQueryRec.SQL.Add(' '+Champs[0]+'=:Valeurs');
                    Recherche.RxQueryRec.Params[0].DataType:=Query.findfield(Champs[0]).DataType;
                    if empty(texte) then texte := '0';
                    Recherche.RxQueryRec.ParamByName('Valeurs').AsCurrency:=StrToCurr_lgr(QueDesChiffres(Texte));
                   end;
     end;
     Recherche.RxQueryRec.SQL.Add(';');
   end;

// Recherche.RxQueryRec.SQL.SaveToFile('TestSQL.txt');
 Recherche.RxQueryRec.Filter:=Query.Filter;
 Recherche.RxQueryRec.Filtered:=Query.Filtered;
 Recherche.DBGrille.DataSource:=nil;
 Recherche.RxQueryRec.Active:=true;
 Recherche.DBGrille.Columns.RebuildColumns;
 Recherche.DBGrille.DataSource:=Recherche.DaRec;
 for i:=0 to high(Titre) do
   if not empty(titre[i]) then
     begin
      Recherche.DBGrille.Columns.Add.Field:=Recherche.RxQueryRec.FieldByName(Champs[i]);
      Recherche.champType[i]:=(Recherche.RxQueryRec.FieldByName(champs[i]).DataType);
      Recherche.TypeChampRequete[i]:=fcNormal;
      Recherche.DBGrille.Columns[i].Title.Caption:=Titre[i];
      if Recherche.DBGrille.Columns[i].Width > 200 then Recherche.DBGrille.Columns[i].Width:=200;
     end;
Recherche.RxLabel1.Caption:= 'Saisissez ici votre '+Recherche.DBGrille.Columns[0].Title.Caption;
Recherche.Patitre.Caption:= 'Recherche sur '+Recherche.DBGrille.Columns[0].Title.Caption;
//upper(PlanCPTE.Libelle) like(upper(:Libel))
end;

begin
if(Recherche = Nil) then
    Recherche:= TRecherche.Create(Application.MainForm);
if Hote <> nil then
 case RecupClassTypeComponent(Hote) of
   GTDBGrid,GTGrid,GTGrDBGrid,GTGrGrid:begin
              Recherche.AfficheAvecParentGrid(Hote as TCustomGrid);
              InitGrille(Query,Champs,titre,Recherche.EdRec.text,NomTable);
              Recherche.EdRec.Text:=Texte;
              Recherche.EdRec.SelectAll;
            end;
   GTEdit:Begin
              Recherche.AfficheAvecParentEdit(Hote as TCustomEdit);
              InitGrille(Query,Champs,titre,Recherche.EdRec.text,NomTable);
              Recherche.EdRec.Text:=Texte;
              Recherche.EdRec.SelectAll;
          End;

   GTInconnu:beep;
 end;
Recherche.EdRec.Width:=Recherche.DBGrille.Columns[0].Width;
result:=(Recherche.Showmodal=mrOk);
Recherche.TypeSaisieDate:=False;
if result then Query.Locate(Champs[0],Recherche.RxQueryRec.findfield(Champs[0]).AsString,[]);
end;

procedure TRecherche.AfficheAvecParentEdit(Hote:TCustomEdit);
var
Rect:TRect;
begin
Rect:=Hote.ClientRect;
//Rect:=TMyCustomGrid(Hote).CellRect(TMyCustomGrid(Hote).Col,TMyCustomGrid(Hote).row);
Recherche.Top:=Hote.ClientToScreen(Rect.TopLeft).y-218;
Recherche.Left:=Hote.ClientToScreen(Rect.TopLeft).x-5;
if Recherche.Top < 0 then
   begin
     Recherche.Top:=Hote.ClientToScreen(Rect.TopLeft).y+Rect.Bottom-Rect.top;
     Recherche.Patitre.Align:=alBottom;
     Recherche.PaBas.Align:=alTop;
   end
   else
   begin
     Recherche.Patitre.Align:=alTop;
     Recherche.PaBas.Align:=alBottom;
   end;
end;


procedure TRecherche.AfficheAvecParentGrid(Hote:TCustomGrid);
var
Rect:TRect;
begin
Rect:=TMyCustomGrid(Hote).CellRect(TMyCustomGrid(Hote).Col,TMyCustomGrid(Hote).row);
Recherche.Top:=Hote.ClientToScreen(Rect.TopLeft).y-213;
Recherche.Left:=Hote.ClientToScreen(Rect.TopLeft).x;
if Recherche.Top < 0 then
   begin
     Recherche.Top:=Hote.ClientToScreen(Rect.TopLeft).y+Rect.Bottom-Rect.top;
     Recherche.Patitre.Align:=alBottom;
     Recherche.PaBas.Align:=alTop;
   end
   else
   begin
     Recherche.Patitre.Align:=alTop;
     Recherche.PaBas.Align:=alBottom;
   end;
end;

procedure TRecherche.PatitreResize(Sender: TObject);
begin
BtnClose.left:=Patitre.Width-2-BtnClose.Width;
RxLabel1.Left:=EdRec.Width+30;
end;

procedure TRecherche.BtnCloseClick(Sender: TObject);
begin
self.close;
end;

procedure TRecherche.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//Recherche.RxQueryRec.Active:=false;
EdRec.OnChange:=nil;
edrec.Text:='';
end;

procedure TRecherche.FormShow(Sender: TObject);
begin
ChampCourant:=0;
EdRec.SetFocus;
EdRec.OnChange:=EdRecChange;
end;

procedure TRecherche.EdRecChange(Sender: TObject);
begin
RxQueryRec.DisableControls;
RxQueryRec.Active:=false;
try
if(RxQueryRec.ParamByName('Valeurs')=nil )then
  initWhere(EdRec.Text);
except
  initWhere(EdRec.Text);
end;
case champType[ChampCourant] of
  ftString:RxQueryRec.ParamByName('Valeurs').AsString:='%'+EdRec.Text+'%';
  ftDate,ftDateTime:Begin
                       if DateValide(EdRec.Text) then
                         RxQueryRec.ParamByName('Valeurs').AsDate:=StrToDate_lgr(EdRec.Text);
                    end;
  ftBoolean:RxQueryRec.ParamByName('Valeurs').AsBoolean:=StrToBool_Lgr(EdRec.Text,false);
  ftCurrency:RxQueryRec.ParamByName('Valeurs').Ascurrency:=StrToCurr_Lgr(EdRec.Text);
  ftFloat:RxQueryRec.ParamByName('Valeurs').Asfloat:=StrToFloat_Lgr(EdRec.Text);
  ftInteger:RxQueryRec.ParamByName('Valeurs').Asinteger:=StrToInt_Lgr(EdRec.Text);
end;//fin case
RxQueryRec.Active:=true;
RxQueryRec.EnableControls;
end;

procedure TRecherche.EdRecKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
case key of
   VK_UP:begin
           RxQueryRec.Prior;
           key:=0;
         end;
   VK_down:begin
            RxQueryRec.Next;
            key:=0;
         end;
end;

end;

procedure TRecherche.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = VK_ESCAPE then
   begin
    Key:= 0;
    modalresult:=mrCancel;
//    Self.Close;
   end;
end;

procedure TRecherche.FormDestroy(Sender: TObject);
begin
if RxQueryRec<>nil then
  RxQueryRec.OnFilterRecord :=nil;
Recherche:=nil;
end;

procedure TRecherche.EdRecKeyPress(Sender: TObject; var Key: Char);
var
Texte:String;
SelStart:Integer;
begin
if TypeSaisieDate then
 begin
   Texte:=EdRec.Text;
   SelStart:=EdRec.SelStart;
   KeyPressDate(key,Texte,SelStart,EdRec.SelLength);
   EdRec.Text:=Texte;
   EdRec.SelStart:=SelStart;
 end;
if key = #13 then key := #0;
end;

procedure TRecherche.DBGrilleDblClick(Sender: TObject);
begin
ModalResult:=MrOk;
end;

procedure TRecherche.FormCreate(Sender: TObject);
var
i:integer;
begin
for i:=1 to high(champtype)do champtype[i]:=ftUnknown;
end;

procedure TRecherche.Champsuivant1Click(Sender: TObject);
var
rang:integer;
begin
try
RxQueryRec.DisableControls;
RxQueryRec.Active:=false;
EdRec.Text:='';
if DBGrille.Columns.Count-1>ChampCourant then
  champcourant:=champcourant+1
else
  champcourant:=0;
rang:=RxQueryRec.SQL.Count-2;
if str_position_caseInsensitive('group by',RxQueryRec.SQL.text)>0 then
 rang:=RxQueryRec.SQL.Count-3;
case champType[ChampCourant] of
  ftString:begin
              RxQueryRec.SQL.Strings[rang]:='Upper('+DBGrille.Columns[ChampCourant].FieldName+') like(Upper(:Valeurs))';
              RxQueryRec.ParamByName('Valeurs').AsString:='%'+EdRec.Text+'%';
           end;
 ftBoolean:begin
              RxQueryRec.SQL.Strings[rang]:=DBGrille.Columns[ChampCourant].FieldName+'=:Valeurs';
              RxQueryRec.ParamByName('Valeurs').AsBoolean:=StrToBool_Lgr(EdRec.Text,false);
           end;
ftDate,
ftDateTime:begin
              RxQueryRec.SQL.Strings[rang]:=DBGrille.Columns[ChampCourant].FieldName+'>=:Valeurs';
              RxQueryRec.ParamByName('Valeurs').AsDate:=StrToDate_lgr(EdRec.Text);
           end;
  ftCurrency:begin
              RxQueryRec.SQL.Strings[rang]:=DBGrille.Columns[ChampCourant].FieldName+'>=:Valeurs';
              RxQueryRec.ParamByName('Valeurs').Ascurrency:=StrToCurr_Lgr(EdRec.Text);
           end;
  ftFloat:begin
              RxQueryRec.SQL.Strings[rang]:=DBGrille.Columns[ChampCourant].FieldName+'>=:Valeurs';
              RxQueryRec.ParamByName('Valeurs').Asfloat:=StrToFloat_Lgr(EdRec.Text);
           end;
  ftInteger:begin
              RxQueryRec.SQL.Strings[rang]:=DBGrille.Columns[ChampCourant].FieldName+'>=:Valeurs';
              RxQueryRec.ParamByName('Valeurs').Asinteger:=StrToInt_Lgr(EdRec.Text);
           end;
end;//fin case
RxQueryRec.Params[0].DataType:=champType[ChampCourant];
RxQueryRec.Active:=true;
RxQueryRec.EnableControls;
Patitre.Caption:= 'Recherche sur '+Recherche.DBGrille.Columns[ChampCourant].Title.Caption;
RxLabel1.Caption:= 'Saisissez ici votre '+Recherche.DBGrille.Columns[ChampCourant].Title.Caption;
except
end;

end;


procedure TRecherche.initWhere(texte:string);
begin
 if(texte<>'')then
   begin
     Recherche.RxQueryRec.SQL.Add(' where ');
     case (champRecherche.DataType)of
        ftString:begin
                       Recherche.RxQueryRec.SQL.Add('upper('+champRecherche.FieldName+') like(upper(:Valeurs))');
                       Recherche.RxQueryRec.SQL.Add(';');
                       Recherche.RxQueryRec.Params[0].DataType:=champRecherche.DataType;
                       Recherche.RxQueryRec.ParamByName('Valeurs').AsString:='%'+texte+'%';
                 end;
        ftInteger,ftCurrency,ftFloat:
                 begin
                      Recherche.RxQueryRec.SQL.Add(champRecherche.FieldName+'=:Valeurs');
                      Recherche.RxQueryRec.SQL.Add(';');
                      Recherche.RxQueryRec.Params[0].DataType:=champRecherche.DataType;
                      Recherche.RxQueryRec.ParamByName('Valeurs').AsFloat:=StrToFloat_Lgr(texte);
                 end;
        ftDate,ftTimeStamp:
                 begin
                     Recherche.RxQueryRec.SQL.Add(champRecherche.FieldName+'=:Valeurs');
                      Recherche.RxQueryRec.SQL.Add(';');
                      Recherche.RxQueryRec.Params[0].DataType:=champRecherche.DataType;
                      Recherche.RxQueryRec.ParamByName('Valeurs').AsDateTime:=StrToDate_Lgr(texte);
                 end;
     end;//fin case
   end;

end;
end.
