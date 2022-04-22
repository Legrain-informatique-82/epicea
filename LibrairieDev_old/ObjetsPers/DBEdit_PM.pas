unit DBEdit_PM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls,extctrls,DBGrids,DBTables,db,Edit_PM,menus,Panel_PM,
  DBGrid_PM,PanelAide_PM;

type
  TMyCustomControl = class(TCustomControl)
  public
  property Canvas;
  end;
  TTypeTri = (Croissant,Decroissant);
  TDBEdit_PM = class(TDBEdit)
  private
    { Déclarations privées }
    FTypeColorBord : TColor;
    FTypeColorFocalisation : TColor;
    Color1: TColor;
    FPolicePlus:integer;
    FTPanelAide:TPanelAide_PM;
//    FPanelHelp:TPanel_PM;
//    TmpTable:TTable;
//    TmpQuery:TQuery;
//    TmpDTSource:TDataSource;
//    FGRIDHelp:TDBGrid_PM;
//    FEditHelp:TEdit_PM;
//    FTypeTri : TTypeTri;
//    Tri:String;
//    FSQLQuery:String;
//    FChampAffiche,FChampTitre:string;
//    PopupChamp: TPopupMenu;
//    MemeTable:boolean;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    Procedure CWPaint(var Message:TWMPaint);message WM_PAINT;
//    procedure KeyPressFEdit(Sender: TObject; var Key: Char);
//    Procedure EnterFEdit(sender:TObject);
//    Procedure ChangeFEdit(sender:TObject);
//    Procedure KeyDownFEdit(Sender: TObject; var Key: Word;
//      Shift: TShiftState);
//    Function GetStringElement(aString :String; aPos :Integer; cSep :Char) :String;
  protected
    { Déclarations protégées }
  public
    { Déclarations publiques }
      constructor Create (Aowner: TComponent); override;
      destructor Destroy; override;
//      procedure KeyPress(var Key: Char); override;
      procedure KeyDown(var Key: Word; Shift: TShiftState);override;
  published
    { Déclarations publiées }
    Property ColorBordure : TColor read FTypeColorBord Write FTypeColorBord Default clWindow;
    Property ColorFocalisation : TColor read FTypeColorFocalisation Write FTypeColorFocalisation Default clWindow;
    Property PolicePlus : integer read FPolicePlus write FPolicePlus Default 0;
    Property AideTable : TPanelAide_PM read FTPanelAide write FTPanelAide;
//    Property AideTable : Boolean read FTableHelp write FTableHelp Default False;
//    Property SQLQuery  :string read FSQLQuery write FSQLQuery;
//    Property TriSQL : TTypeTri read FTypeTri write FtypeTri;
//    Property ChampAffiche:string read FChampAffiche write FChampAffiche;
//    Property ChampTitre:string read FChampTitre write FChampTitre;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('PBMA', [TDBEdit_PM]);
end;

constructor TDBEdit_PM.Create(Aowner: TComponent);
begin
     inherited create(AOwner);
     FTypeColorFocalisation:=clWindow;
     FTypeColorBord:=clWindow;
//     MemeTable:=false;
end;

destructor TDBEdit_PM.Destroy;
begin
     inherited;
end;

procedure TDBEdit_PM.KeyDown(var Key: Word; Shift: TShiftState);
var
KeyTmp:Word;
//i,TotalLargeur,k:integer;
//auxtmp:string;
begin
if Ismasked then KeyTmp:=Key;
inherited KeyDown(Key,Shift);
if Ismasked then Key:=Keytmp;
case Key of
 VK_UP:begin
         TControl(Owner).Perform(WM_NEXTDLGCTL, -1, 0);
         key:=0;
       end;
 VK_DOWN,VK_RETURN:begin
           TControl(Owner).Perform(WM_NEXTDLGCTL, 0, 0);
           key:=0;
         end;
 VK_F1:begin
         if FTPanelAide <> nil then FTPanelAide.loaded;
//            if FTableHelp then
//            if FPanelHelp = nil then
//               begin
//               case TriSQL of
//                    croissant:Tri:=' ASC';
//                    Decroissant:Tri:=' DESC';
//               end;
//               FGRIDHelp:=TDBGrid_PM.create(self);
//               FPanelHelp:=TPanel_PM.Create(self);
//               TmpDTSource:=TDataSource.create(self);
//                TmpQuery:=TQuery.Create(self);
//                TmpQuery.DatabaseName:=(DataSource.DataSet as TTable).DatabaseName;
//                TmpQuery.SQL.Clear;
//                if FSQLQuery<>'' then TmpQuery.SQL.Add(FSQLQuery) else
//                begin
//               if DataSource.DataSet.ClassNameIs('TTable') then begin
//                  TmpQuery.SQL.Add('Select * from ' + (DataSource.DataSet as TTable).TableName + ' order by ' + Field.DisplayName + tri);
//                  MemeTable:=true;
//                  end;
//               if DataSource.DataSet.ClassNameIs('TQuery') then
//                  TmpQuery.SQL.Add((DataSource.DataSet as TQuery).SQL.Text);
//                end;
//                TmpDTSource.DataSet:=TmpQuery;
//                TmpQuery.Active:=true;
//                TmpQuery.FilterOptions:=[foCaseInsensitive];
//               FGRIDHelp.DataSource:=TmpDTSource;
////               FGRIDHelp.Columns.Add.Field:=Field;
////               FGRIDHelp.Columns[0].Width:=Field.DataSize;
//               TotalLargeur:=0;
//               auxtmp:=FChampAffiche;
//               k:=0;
//               repeat
//               k:=k+1;
//               delete(auxtmp,1,pos(';',auxtmp));
//               until not(pos(';',auxtmp) > 0);
//               if FChampAffiche<>'' then
//               for i:=1 to k do
//               begin
//                 FGRIDHelp.Columns.Add.Field:=(DataSource.DataSet as TTable).FieldByName(GetStringElement(FChampAffiche,i,';'));
//                 FGRIDHelp.Columns[i-1].Title.Caption:=GetStringElement(FChampTitre,i,';');
//                 TotalLargeur:=FGRIDHelp.Columns[i-1].Width+TotalLargeur;
//
//               end;
////               FGRIDHelp.Columns.Add.Field:=Field;
//               FGRIDHelp.ReadOnly:=true;
//               FGRIDHelp.Height:=110;
//               FGRIDHelp.BorderStyle:=bsNone;
//               FGRIDHelp.Ctl3D:=false;
//               FGRIDHelp.FixedColor:=clLime;
//               FGRIDHelp.ColorBordure:=clred;
//               FGRIDHelp.ColorFocalisation:=clLime;
//               FGRIDHelp.Color:=clLime;
//               FEditHelp:=Tedit_PM.Create(self);
//               if top > (FGRIDHelp.Height + FEditHelp.height) then begin
//                      FPanelHelp.top:= top - FGRIDHelp.Height-FEditHelp.height-15;
//                      FGRIDHelp.Top:=3;
//                      FEditHelp.Top:=FGRIDHelp.Height + 8;
////                      FGRIDHelp.Top:=top - FGRIDHelp.Height-FEditHelp.height-12;
////                      FEditHelp.Top:=top - FEditHelp.height - 6;
//                      end else begin
//                      FPanelHelp.top:= top + FGRIDHelp.Height+FEditHelp.height-15;
//                      FGRIDHelp.Top:=3;
//                      FEditHelp.Top:=FGRIDHelp.Height + 6;
////                      FGRIDHelp.Top:=top + Height + FEditHelp.height+6;
////                      FEditHelp.top:=top + Height;
//                      end;
//               FEditHelp.OnKeyPress:=KeyPressFEdit;
//               FEditHelp.OnEnter:=EnterFEdit;
//               FEditHelp.OnChange:=ChangeFEdit;
//               FEditHelp.OnKeyDown:=KeyDownFEdit;
//               FGRIDHelp.OnKeyPress:=KeyPressFEdit;
//               FGRIDHelp.Options:=FGRIDHelp.Options+[dgAlwaysShowSelection]-[dgTabs];
//               FPanelHelp.Width:=TotalLargeur +40;
//               FGRIDHelp.Width:=TotalLargeur+35;
//               FPanelHelp.Left:=Left -2;
//               FPanelHelp.TabStop:=false;
//               FGRIDHelp.Left:=2;
//               FEditHelp.Left:=2;
//               FEditHelp.Width:=FGRIDHelp.Columns[0].Width+10;
//               FPanelHelp.Height:=FGRIDHelp.Height+FEditHelp.height+15;
//               FPanelHelp.ColorBordure:=clRed;
//               FPanelHelp.ColorFocalisation:=clLime;
//               FEditHelp.ColorBordure:=clRed;
//               FEditHelp.ColorFocalisation:=clLime;
//               FEditHelp.AutoSelect:=true;
////               if FEditHelp.Text ='' then
////               FEditHelp.Text:=Field.DisplayText;
//               FEditHelp.Parent:=FPanelHelp;
//               FGRIDHelp.Parent:=FPanelHelp;
//               FPanelHelp.Parent:=parent;
////               FEditHelp.Parent:=parent;
////               FGRIDHelp.Parent:=parent;
//               FEditHelp.SetFocus;
//               end
//               else
//               begin
////               TmpTable.Open;
////               if DataSource.DataSet.ClassNameIs('TTable') then
////               TmpTable.GotoCurrent(DataSource.DataSet as TTable);
//               FPanelHelp.Visible:=true;
//               FEditHelp.Visible:=true;
//               FGRIDHelp.Visible:=true;
//               FEditHelp.SetFocus;
//               end;
       end;
 end;
end;

procedure TDBEdit_PM.CMEnter(var Message: TCMEnter);
Begin
     inherited;
     beep;
     Color1 := Color;
     Color := ColorFocalisation;
     if (parent is TPanel) then begin
               TMyCustomControl(Parent).Canvas.Pen.Color:=ColorBordure;
               TMyCustomControl(Parent).Canvas.Pen.Width:=5;
               TMyCustomControl(Parent).Canvas.Rectangle(left-1,top-1,left+Width+1,top+Height+1);
               Font.Size:=Font.size+FPolicePlus;
     end;
     if (parent is TForm) then begin
               (parent as TForm).Canvas.Pen.Color:=ColorBordure;
               (parent as TForm).Canvas.Pen.Width:=5;
               (parent as TForm).Canvas.Rectangle(left-1,top-1,left+Width+1,top+Height+1);
               Font.Size:=Font.size+FPolicePlus;
     end;
end;

procedure TDBEdit_PM.CMExit(var Message: TCMExit);
begin
     inherited;
     Color :=  Color1;
     if (parent is TPanel) then begin
               TMyCustomControl(Parent).Canvas.Pen.Color:=TMyCustomControl(Parent).Color;
               TMyCustomControl(Parent).Canvas.Pen.Width:=5;
               TMyCustomControl(Parent).Canvas.Rectangle(left-1,top-1,left+Width+1,top+Height+1);
               Font.Size:=Font.size-FPolicePlus;
     end;
     if (parent is TForm) then begin
               (parent as TForm).Canvas.Pen.Color:=(parent as TForm).Color;
               (parent as TForm).Canvas.Pen.Width:=5;
               (parent as TForm).Canvas.Rectangle(left-1,top-1,left+Width+1,top+Height+1);
               Font.Size:=Font.size-FPolicePlus;
     end;
End;

procedure TDBEdit_PM.CWPaint(var Message: TWMPaint);
Begin
     inherited;
     if focused then
      begin
       if (parent is TPanel) then
        begin
         TMyCustomControl(Parent).Canvas.Pen.Color:=ColorBordure;
         TMyCustomControl(Parent).Canvas.Pen.Width:=5;
         TMyCustomControl(Parent).Canvas.Rectangle(left-1,top-1,left+Width+1,top+Height+1);
        end;
       if (parent is TForm) then
        begin
         (parent as TForm).Canvas.Pen.Color:=ColorBordure;
         (parent as TForm).Canvas.Pen.Width:=5;
         (parent as TForm).Canvas.Rectangle(left-1,top-1,left+Width+1,top+Height+1);
        end;
      end;
end;

//procedure TDBEdit_PM.KeyPressFEdit(Sender: TObject; var Key: Char);
//var
//I,J,K:Integer;
//aux,auxtmp:string;
//ValeurChCle:Variant;
//begin
////if FEditHelp.OnChange=nil then
//FEditHelp.OnChange:=ChangeFEdit;
//if Key = #27 then begin
//   FPanelHelp.Visible:=false;
////   FEditHelp.Visible:=false;
////   FGRIDHelp.Visible:=false;
//   setfocus;
//   end;
//if key = #13 then begin
//   if MemeTable then begin
//   { Extrait les indices disponibles en cours }
//   (DataSource.DataSet as TTable).IndexDefs.Update;
//   { En trouve un qui combine le numéro client ('CustNo') et le numéro de commande ('OrderNo') }
//   J:=0;
//   for I := 0 to (DataSource.DataSet as TTable).IndexDefs.Count - 1 do
//       if (DataSource.DataSet as TTable).IndexDefs.Items[I].Options = [ixPrimary	] then J:=I;
//     if (DataSource.DataSet as TTable).IndexDefs.Items[J].Fields <> '' then
//      begin
//         { initialise cet index comme index courant de la table }
////         (DataSource.DataSet as TTable).SetFie
//         aux:=(DataSource.DataSet as TTable).IndexDefs.Items[J].Fields;
//         auxtmp:=aux;
//         k:=1;
//         repeat
//         k:=k+1;
//         delete(auxtmp,1,pos(';',auxtmp));
//         until not(pos(';',auxtmp) > 0);
//         ValeurChCle:=VarArrayCreate([0, K], varVariant);
//         for i:=0 to K -1 do begin
//             if pos(';',aux) > 0 then ValeurChCle[i]:=TmpQuery.FieldValues[copy(aux,1,pos(';',aux)-1)]
//             else ValeurChCle[i]:=TmpQuery.FieldValues[copy(aux,1,length(aux))];
//             delete(aux,1,pos(';',aux));
//             end;
//         ValeurChCle[K]:=TmpQuery.FieldValues[Field.FieldName];
//         aux:=(DataSource.DataSet as TTable).IndexDefs.Items[J].Fields+';'+Field.FieldName;
////         (DataSource.DataSet as TTable).Locate('idcli;cli_cod;cli_cod',VarArrayOf(['P00007']),[loPartialKey]);
////         (DataSource.DataSet as TTable).Locate('idcli;cli_cod;cli_cod',VarArrayOf([Null,'P00007','P00007']),[]);
//        (DataSource.DataSet as TTable).Locate(aux,ValeurChCle,[]);
////        (DataSource.DataSet as TTable).MasterFields
////         (DataSource.DataSet as TTable).Locate((DataSource.DataSet as TTable).IndexDefs.Items[J].Fields+';'+Field.FieldName,VarArrayOf([TmpQuery.FieldValues[(DataSource.DataSet as TTable).IndexDefs.Items[J].Fields],TmpQuery.FieldValues[Field.FieldName]]),[]);
////             Table1.IndexName := Table1.IndexDefs.Items[I].Name;
//      end
//      else
//   (DataSource.DataSet as TTable).Locate(Field.FieldName,TmpQuery.FieldValues[Field.FieldName],[]);
////      (DataSource.DataSet as TTable).IndexDefs
//   end;
////   (DataSource.DataSet as TTable).Locate(Field.FieldName,TmpQuery.FieldValues[Field.FieldName],[]);
////   (DataSource.DataSet as TTable).GotoCurrent(TmpTable);
//   FPanelHelp.Visible:=false;
//   setfocus;
//   end;
//end;
//
//Procedure TDBEdit_PM.EnterFEdit(sender:TObject);
//begin
////if Field.AsString <>'' then
//FEditHelp.Text:=Field.Text;
//FEditHelp.SelectAll;
//end;
//
//Procedure TDBEdit_PM.KeyDownFEdit(Sender: TObject; var Key: Word;
//  Shift: TShiftState);
//var
//MarqueFiltre:TBookmark;
//begin
//case Key of
// VK_UP:begin
//          if TmpQuery.Filtered=true then begin
//                                    TmpQuery.ControlsDisabled;
//                                    MarqueFiltre:=TmpQuery.GetBookmark;
//                                    TmpQuery.Filtered:=false;
//                                    TmpQuery.GotoBookmark(MarqueFiltre);
//                                    TmpQuery.FreeBookmark(MarqueFiltre);
//                                    TmpQuery.EnableControls;
//                                    end;
//         TmpQuery.Prior;
////         TmpTable.Prior;
//         FEditHelp.OnChange:=nil;
//         if FEditHelp.Text <>'' then begin
//            if FEditHelp.Text[1]<>'*' then begin
//         FEditHelp.Text:=FGRIDHelp.Columns.Items[0].Field.AsString;
//           end;
//           end
//           else FEditHelp.Text:=FGRIDHelp.Columns.Items[0].Field.AsString;
//         key:=0;
//       end;
// VK_DOWN:begin
//          if TmpQuery.Filtered=true then begin
//                                    TmpQuery.ControlsDisabled;
//                                    MarqueFiltre:=TmpQuery.GetBookmark;
//                                    TmpQuery.Filtered:=false;
//                                    TmpQuery.GotoBookmark(MarqueFiltre);
//                                    TmpQuery.FreeBookmark(MarqueFiltre);
//                                    TmpQuery.EnableControls;
//                                    end;
//
//           TmpQuery.Next;
////           TmpTable.Next;
//         FEditHelp.OnChange:=nil;
//         if FEditHelp.Text <>'' then begin
//            if FEditHelp.Text[1]<>'*' then begin
//           FEditHelp.Text:=FGRIDHelp.Columns.Items[0].Field.AsString;
//           end;
//           end
//           else FEditHelp.Text:=FGRIDHelp.Columns.Items[0].Field.AsString;
//           key:=0;
//         end;
// end;
//end;
//
//Procedure TDBEdit_PM.ChangeFEdit(sender:TObject);
//var
//LikeText:string;
//begin
//TmpQuery.ControlsDisabled;
//TmpQuery.Filtered:=false;
////TmpQuery.Filter:=Field.FieldName + '='''+FEditHelp.Text+'''';
//case Field.DataType of
//  ftString:begin
//           if FEditHelp.Text <> '' then begin
//             if FEditHelp.Text[1]='*' then
//                 begin
//                 LikeText:=copy(FEditHelp.Text,2,length(FEditHelp.Text));
////                 TmpQuery.ControlsDisabled;
//                 TmpQuery.Filter:='';
//                 TmpQuery.SQL.Clear;
//                if FSQLQuery<>'' then TmpQuery.SQL.Add(FSQLQuery) else
//                begin
//                 if DataSource.DataSet.ClassNameIs('TTable') then
//                    TmpQuery.SQL.Add('Select * from ' + (DataSource.DataSet as TTable).TableName + ' where '+Field.DisplayName+' like(''%'+LikeText+'%'') order by ' + Field.DisplayName + tri);
//                end;
//                 TmpQuery.Active:=true;
////                 TmpQuery.EnableControls;
//                 end
//                 else begin
////                 TmpQuery.ControlsDisabled;
//                 TmpQuery.SQL.Clear;
//                if FSQLQuery<>'' then TmpQuery.SQL.Add(FSQLQuery) else
//                begin
//                 if DataSource.DataSet.ClassNameIs('TTable') then
//                   TmpQuery.SQL.Add('Select * from ' + (DataSource.DataSet as TTable).TableName + ' order by ' + Field.DisplayName + tri);
//                end;
//                 TmpQuery.Active:=true;
//                 TmpQuery.Filter:=Field.FieldName + '='''+FEditHelp.Text+'*''';
////                 TmpQuery.EnableControls;
//                 end;
//                 end else
//                 begin
////                 TmpQuery.ControlsDisabled;
//                 TmpQuery.SQL.Clear;
//                if FSQLQuery<>'' then TmpQuery.SQL.Add(FSQLQuery) else
//                begin
//                 if DataSource.DataSet.ClassNameIs('TTable') then
//                   TmpQuery.SQL.Add('Select * from ' + (DataSource.DataSet as TTable).TableName + ' order by ' + Field.DisplayName + tri);
//                 end;
//                 TmpQuery.Active:=true;
//                 TmpQuery.Filter:='';
////                 TmpQuery.Filter:=Field.FieldName + '='''+FEditHelp.Text+'*''';
////                 TmpQuery.EnableControls;
//                 end;
//           end;
////  : ;
//else TmpQuery.Filter:=Field.FieldName + '='''+FEditHelp.Text+'''' ;
//end;
//
////if Field.DataType = ftString	then
////TmpQuery.Filter:=Field.FieldName + '='''+FEditHelp.Text+'*'''
////else TmpQuery.Filter:=Field.FieldName + '='''+FEditHelp.Text+'''';
//TmpQuery.Filtered:=true;
//TmpQuery.EnableControls;
//end;
//
//Function TDBEdit_PM.GetStringElement(aString :String; aPos :Integer; cSep :Char) :String;
//// Retourne le mot dans une liste suivant la position demandée ex:
//// GetStringElement('aaa;zzzz;eeee;',2,';'); retourne 'zzzz'
//Var
//	i, d, lg :Integer;
//Begin
//
//	lg:= Length(aString);
//	d:= 1;
//	i:= 1;
//	While (d < aPos) And (i < lg) do
//	Begin
//		if (aString[i] = cSep) Then Inc(d);
//		Inc(i);
//	End;
//
//	If (d = aPos) then
//	Begin
//		d:= i;
//		While (i <= lg) do
//		Begin
//			if (aString[i] = cSep) Then Break;
//			Inc(i);
//		End;
//		Result:= Copy(aString, d, (i-d));
//	End
//	Else Result:= '';
//End;

end.
