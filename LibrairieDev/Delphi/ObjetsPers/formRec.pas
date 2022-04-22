unit formRec;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls,stdctrls,  DBGrids,DBTables,db,Edit_PM,menus;

type
  TResultatEvent = Procedure(Sender :TObject; Valide :Boolean) of object;
  TTypeTri = (Croissant,Decroissant);
  tformRec = class(tCustomform)
  private
    { Déclarations privées }
    FOnResultat :TResultatEvent;
    FBase:TDataBase;
    FTable:TTable;
    DelayRec:TTimer;
    TmpQuery:TQuery;
    TmpDTSource:TDataSource;
//    FGRIDHelp:TDBGrid_PM;
//    FEditHelp:TEdit_PM;
    FTypeTri : TTypeTri;
    Tri:String;
    FFiltre:String;
    FChampAffiche,FChampTitre,FChampCle:string;
    PopupChamp: TPopupMenu;
    FControl:TControl;
    TmpKeyPreview:boolean;
    procedure KeyPressFEdit(Sender: TObject; var Key: Char);
    procedure DblClick(sender:TObject);
    Procedure ColEnter(sender:TObject);
    Procedure ColExit(sender:TObject);
    Procedure EnterFEdit(sender:TObject);
    Procedure ExitFEdit(sender:TObject);
    Procedure ExitFGrid(sender:TObject);
    Procedure ChangeFEdit(sender:TObject);
    Procedure KeyDownFEdit(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    Function GetStringElement(aString :String; aPos :Integer; cSep :Char) :String;
    procedure BeforeScroll(DataSet: TDataSet);
    procedure AfterScroll(DataSet: TDataSet);
    procedure DelayTimer(sender:TObject);
    function requete:string;
    function requeteLike:string;
  protected
    { Déclarations protégées }

  public
      constructor Create (Aowner: TComponent); override;
      destructor Destroy; override;
      procedure Show(Sender: TObject);
      //      procedure loaded;virtual;
    { Déclarations publiques }
  published
    { Déclarations publiées }
    Property Base:TDataBase Read FBase write FBase;
    Property Table:TTable Read FTable write FTable;
    Property Filtre  :string read FFiltre write FFiltre;
    Property TriSQL : TTypeTri read FTypeTri write FtypeTri;
    Property ChampAffiche:string read FChampAffiche write FChampAffiche;
    Property ChampTitre:string read FChampTitre write FChampTitre;
    Property ChampCle:string read FChampCle write FChampCle;
    Property ZoneAppel:TControl Read FControl Write Fcontrol;
    property OnResultat:TResultatEvent read FonResultat Write FOnREsultat;
    Property Onshow;
    Property PixelsPerInch;
  end;

//procedure Register;

implementation

uses DBGrid_PM;

var
    FGRIDHelp:TDBGrid_PM;
    FEditHelp:TEdit_PM;

procedure Register;
begin
  RegisterComponents('PBMA', [tformRec]);
end;

constructor TFormRec.Create(Aowner: TComponent);
begin
     inherited create(AOwner);
     TmpDTSource:=TDataSource.create(self);
     TmpQuery:=TQuery.Create(self);
     FEditHelp:=TEdit_PM.Create(self);
     DelayRec:=TTimer.Create(self);
     visible:=false;
end;

destructor TFormRec.Destroy;
begin
     inherited;
end;

function  TFormRec.requete:string;
begin
case TriSQL of
    croissant:Tri:=' ASC';
    Decroissant:Tri:=' DESC';
end;
if FFiltre<>'' then begin
//   result:='Select * from ' + Table.TableName + ' order by ' + GetStringElement(FChampAffiche,1,';') + tri+';';
   result:='Select * from ' + Table.TableName + ' where '+FFiltre+' order by ' + GetStringElement(FChampAffiche,1,';') + tri+';';
   end
   else
   begin
   result:='Select * from ' + Table.TableName + ' order by ' + GetStringElement(FChampAffiche,1,';') + tri+';';
   end;
end;

function  TFormRec.requeteLike:string;
var
LikeText:string;
begin
case TriSQL of
    croissant:Tri:=' ASC';
    Decroissant:Tri:=' DESC';
end;
LikeText:=copy(FEditHelp.Text,2,length(FEditHelp.Text));
if FFiltre<>'' then begin
   result:='Select * from ' + Table.TableName + ' where '+FFiltre+' and upper('+GetStringElement(FChampAffiche,1,';')+') like(upper(''%'+LikeText+'%'')) order by ' + GetStringElement(FChampAffiche,1,';') + tri+';';
   end
   else
   begin
   result:='Select * from ' + Table.TableName + ' where upper('+GetStringElement(FChampAffiche,1,';')+') like(upper(''%'+LikeText+'%'')) order by ' + GetStringElement(FChampAffiche,1,';') + tri+';';
   end;
end;

procedure TFormRec.Show(Sender: TObject);
//procedure TFormRec.loaded;
var
i,TotalLargeur,k:integer;
auxtmp:string;
begin
//inherited;
    if FGRIDHelp=nil then FGRIDHelp:=TDBGrid_PM.create(self);
//     if FGRIDHelp.Parent.Name <> self.Name then
//     if Components[ComponentIndex] = nil then
    if FGRIDHelp<>nil then
       begin
//       FGRIDHelp:=TDBGrid_PM.create(self);
       FGRIDHelp.DataSource:=nil;
       FGRIDHelp.Columns.RebuildColumns;
       TmpQuery.DatabaseName:=Base.DatabaseName;
       TmpQuery.SQL.Clear;
       TmpQuery.SQL.Add(requete);
       TmpDTSource.DataSet:=TmpQuery;
       TmpQuery.Active:=true;
       TmpQuery.FilterOptions:=[foCaseInsensitive];
       FGRIDHelp.DataSource:=TmpDTSource;
       TotalLargeur:=0;
       auxtmp:=FChampAffiche;
       if FChampAffiche<>'' then
          begin
          k:=1;
          while (pos(';',auxtmp) > 0) do
                begin
                k:=k+1;
                delete(auxtmp,1,pos(';',auxtmp));
                end;
          for i:=1 to k do
              begin
              FGRIDHelp.Columns.Add.Field:=TmpQuery.FieldByName(GetStringElement(FChampAffiche,i,';'));
              FGRIDHelp.Columns[i-1].Title.Caption:=GetStringElement(FChampTitre,i,';');
              TotalLargeur:=FGRIDHelp.Columns[i-1].Width+TotalLargeur;
              end;
          end;
       FGRIDHelp.ReadOnly:=true;
       FGRIDHelp.Height:=110;
       FGRIDHelp.BorderStyle:=bsNone;
       FGRIDHelp.Ctl3D:=false;
       FGRIDHelp.FixedColor:=clLime;
       FGRIDHelp.ColorBordure:=clred;
       FGRIDHelp.ColorFocalisation:=clLime;
       FGRIDHelp.Color:=clLime;
       if FControl.Top > (FGRIDHelp.Height + FEditHelp.height) then
          begin
          top:= FControl.top - FGRIDHelp.Height-FEditHelp.height-15;
          FGRIDHelp.Top:=3;
          FEditHelp.Top:=FGRIDHelp.Height + 8;
          end
          else
          begin
          top:= FControl.top + FControl.Height;
          FEditHelp.Top:=3;
          FGRIDHelp.Top:=FEditHelp.Height + 8;
          end;
       FEditHelp.OnKeyPress:=KeyPressFEdit;
       FEditHelp.OnEnter:=EnterFEdit;
       FEditHelp.OnExit:=ExitFEdit;
       FEditHelp.OnChange:=ChangeFEdit;
       FEditHelp.OnKeyDown:=KeyDownFEdit;
       FGRIDHelp.OnKeyPress:=KeyPressFEdit;
       FGRIDHelp.OnDblClick:=DblClick;
//               FGRIDHelp.OnColEnter:=ColEnter;
       FGRIDHelp.OnEnter:=ColEnter;
       FGRIDHelp.OnExit:=ExitFGrid;
       DelayRec.Interval:=500;
       DelayRec.Enabled:=false;
       DelayRec.OnTimer:=DelayTimer;
       FGRIDHelp.Options:=FGRIDHelp.Options+[dgAlwaysShowSelection]-[dgTabs]-[dgEditing];
       Width:=TotalLargeur +40;
       FGRIDHelp.Width:=TotalLargeur+35;
       Left:=FControl.Left -2;
       TabStop:=false;
       FGRIDHelp.Left:=2;
       FEditHelp.Left:=2;
       FEditHelp.Width:=FGRIDHelp.Columns[0].Width+10;
       Height:=FGRIDHelp.Height+FEditHelp.height+15;
//       ColorBordure:=clRed;
//       ColorFocalisation:=clLime;
       FEditHelp.ColorBordure:=clRed;
       FEditHelp.ColorFocalisation:=clLime;
       FEditHelp.AutoSelect:=true;
       visible:=true;
       FEditHelp.Parent:=Self;
       FGRIDHelp.Parent:=Self;
       Parent:=FControl.parent;
       if (FControl.Parent is TForm) then begin
          TmpKeyPreview:=(FControl.Parent as TForm).KeyPreview;
          (FControl.Parent as TForm).KeyPreview:=false;
          end;
       FEditHelp.SetFocus;
//               Canvas.TextOut(FEditHelp.Left+FEditHelp.Width+3,0,'Coucou');
       end
       else
       begin
       if (FControl.Parent is TForm) then begin
          TmpKeyPreview:=(FControl.Parent as TForm).KeyPreview;
          (FControl.Parent as TForm).KeyPreview:=false;
          end;
       visible:=true;
       TmpQuery.refresh;
       FEditHelp.SetFocus;
       end;
end;

procedure TFormRec.KeyPressFEdit(Sender: TObject; var Key: Char);
var
I,J,K:Integer;
aux,auxtmp:string;
ValeurChCle:Variant;
begin
FEditHelp.OnChange:=nil;
DelayRec.Enabled:=false;
DelayRec.Enabled:=true;
if Key = #27 then
   begin
   TmpQuery.BeforeScroll:=nil;
   TmpQuery.AfterScroll:=nil;
   DelayRec.Enabled:=false;
   Visible:=false;
       if (FControl.Parent is TForm) then begin
          (FControl.Parent as TForm).KeyPreview:=TmpKeyPreview;
          end;
   (FControl as TWincontrol).SetFocus;
   end;
if key = #13 then
   begin
   DelayRec.Enabled:=false;
   auxtmp:=FChampCle;
   if FChampCle<>'' then
      begin
      k:=0;
      while (pos(';',auxtmp) > 0) do
            begin
            k:=k+1;
            delete(auxtmp,1,pos(';',auxtmp));
            end;
      end;
   ValeurChCle:=VarArrayCreate([0, K], varVariant);
   for i:=1 to (K+1) do
      ValeurChCle[i-1]:=TmpQuery.FieldValues[GetStringElement(FChampCle,i,';')];

   if k=0 then
      Table.Locate(FChampCle,ValeurChCle[0],[])
      else
      Table.Locate(FChampCle,ValeurChCle,[]);
   TmpQuery.BeforeScroll:=nil;
   TmpQuery.AfterScroll:=nil;
       if (FControl.Parent is TForm) then begin
          (FControl.Parent as TForm).KeyPreview:=TmpKeyPreview;
          end;
   Visible:=false;
   if Assigned(FOnResultat) then FOnResultat(self,true);
   (FControl as TWincontrol).SetFocus;
   end;
end;

Procedure TFormRec.EnterFEdit(sender:TObject);
var
i:integer;
begin
if (FControl is TCustomEdit) then
   FEditHelp.Text:=(FControl as TCustomEdit).text;
if (FControl is TCustomDBGrid) then
   FEditHelp.Text:=(FControl as TCustomDBGrid).SelectedField.AsString;
FEditHelp.SelectAll;
FEditHelp.TabOrder:=0;
FGridHelp.TabOrder:=1;
end;

procedure TFormRec.DblClick(sender:TObject);
var
key:char;
begin
key:=#13;
KeyPressFEdit(Sender,key);
end;

Procedure TFormRec.KeyDownFEdit(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
MarqueFiltre:TBookmark;
begin
case Key of
 VK_UP:begin
       if TmpQuery.Filtered=true then
          begin
          TmpQuery.ControlsDisabled;
          MarqueFiltre:=TmpQuery.GetBookmark;
          TmpQuery.Filtered:=false;
          TmpQuery.GotoBookmark(MarqueFiltre);
          TmpQuery.FreeBookmark(MarqueFiltre);
          TmpQuery.EnableControls;
          end;
       TmpQuery.Prior;
       FEditHelp.OnChange:=nil;
       if FEditHelp.Text <>'' then
          begin
          if FEditHelp.Text[1]<>'*' then
             begin
             FEditHelp.Text:=FGRIDHelp.Columns.Items[0].Field.AsString;
             end;
          end
          else FEditHelp.Text:=FGRIDHelp.Columns.Items[0].Field.AsString;
       key:=0;
       end;
 VK_DOWN:begin
         if TmpQuery.Filtered=true then
            begin
            TmpQuery.ControlsDisabled;
            MarqueFiltre:=TmpQuery.GetBookmark;
            TmpQuery.Filtered:=false;
            TmpQuery.GotoBookmark(MarqueFiltre);
            TmpQuery.FreeBookmark(MarqueFiltre);
            TmpQuery.EnableControls;
            end;
         TmpQuery.Next;
         FEditHelp.OnChange:=nil;
         if FEditHelp.Text <>'' then
            begin
            if FEditHelp.Text[1]<>'*' then
               begin
               FEditHelp.Text:=FGRIDHelp.Columns.Items[0].Field.AsString;
               end;
            end
            else FEditHelp.Text:=FGRIDHelp.Columns.Items[0].Field.AsString;
         key:=0;
         end;
 end;
end;

Procedure TFormRec.ChangeFEdit(sender:TObject);
var
NomChamp:string;
begin
NomChamp:=GetStringElement(FChampAffiche,1,';');
//NomChamp:=FGRIDHelp.Columns.Items[0].Field.DisplayName;
TmpQuery.ControlsDisabled;
TmpQuery.Filtered:=false;
case FGRIDHelp.Columns.Items[0].Field.DataType of
  ftString:begin
           if FEditHelp.Text <> '' then
              begin
              if FEditHelp.Text[1]='*' then
                 begin
//                 LikeText:=copy(FEditHelp.Text,2,length(FEditHelp.Text));
                 TmpQuery.Filter:='';
                 TmpQuery.SQL.Clear;
                 TmpQuery.SQL.Add(requeteLike);
//                 TmpQuery.SQL.Add('Select * from ' + Table.TableName + ' where upper('+NomChamp+') like(upper(''%'+LikeText+'%'')) order by ' + NomChamp + tri);
                 TmpQuery.Active:=true;
                 end
                 else
                 begin
                 TmpQuery.SQL.Clear;
                 TmpQuery.SQL.Add(requete);
//                 TmpQuery.SQL.Add('Select * from ' + Table.TableName + ' order by ' + NomChamp + tri);
                 TmpQuery.Filter:=NomChamp + '='''+FEditHelp.Text+'*''';
                 TmpQuery.Active:=true;
                 end;
              end
              else
              begin
              TmpQuery.SQL.Clear;
//                 TmpQuery.SQL.Add('Select * from ' + Table.TableName + ' order by ' + NomChamp + tri);
              TmpQuery.SQL.Add(requete);
              TmpQuery.Filter:=NomChamp + '='''+FEditHelp.Text+'*''';
              TmpQuery.Active:=true;
              end;
           end;
  else TmpQuery.Filter:=NomChamp + '='''+FEditHelp.Text+'''' ;
 end;
TmpQuery.Filtered:=true;
TmpQuery.EnableControls;
end;

procedure TFormRec.BeforeScroll(DataSet: TDataSet);
begin
FEditHelp.OnChange:=nil;
end;

procedure TFormRec.AfterScroll(DataSet: TDataSet);
begin
if FEditHelp.Text <>'' then
   begin
   if FEditHelp.Text[1]<>'*' then
      begin
      FEditHelp.Text:=FGRIDHelp.Columns.Items[0].Field.AsString;
      end;
   end
   else
   FEditHelp.Text:=FGRIDHelp.Columns.Items[0].Field.AsString;
FEditHelp.OnChange:=ChangeFEdit;
end;

Procedure TFormRec.ColEnter(sender:TObject);
begin
  FEditHelp.TabOrder:=1;
  FGridHelp.TabOrder:=0;
  TmpQuery.BeforeScroll:=BeforeScroll;
  TmpQuery.AfterScroll:=AfterScroll;
end;

Procedure TFormRec.ColExit(sender:TObject);
begin
   TmpQuery.BeforeScroll:=nil;
   TmpQuery.AfterScroll:=nil;
end;

procedure TFormRec.DelayTimer(Sender: TObject);
begin
  FEditHelp.OnChange:=ChangeFEdit;
  ChangeFEdit(FeditHelp);
  DelayRec.Enabled:=false;
end;

Procedure TFormRec.ExitFEdit(sender:TObject);
begin
if (Parent as TCustomForm).ActiveControl <> FGridHelp then
   begin
   visible:=false;
   (FControl as TWincontrol).SetFocus;
   end;
end;

Procedure TFormRec.ExitFGrid(sender:TObject);
begin
Colexit(FGridHelp);
if (Parent as TCustomForm).ActiveControl <> FEditHelp then
   begin
   visible:=false;
   (FControl as TWincontrol).SetFocus;
   end;
end;


Function TFormRec.GetStringElement(aString :String; aPos :Integer; cSep :Char) :String;
// Retourne le mot dans une liste suivant la position demandée ex:
// GetStringElement('aaa;zzzz;eeee;',2,';'); retourne 'zzzz'
Var
	i, d, lg :Integer;
Begin

	lg:= Length(aString);
	d:= 1;
	i:= 1;
	While (d < aPos) And (i < lg) do
	Begin
		if (aString[i] = cSep) Then Inc(d);
		Inc(i);
	End;

	If (d = aPos) then
	Begin
		d:= i;
		While (i <= lg) do
		Begin
			if (aString[i] = cSep) Then Break;
			Inc(i);
		End;
		Result:= Copy(aString, d, (i-d));
	End
	Else Result:= '';
End;

end.
