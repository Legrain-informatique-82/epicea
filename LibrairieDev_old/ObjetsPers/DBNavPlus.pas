unit DBNavPlus;
(*
version 1.0
	- For Delphi 2.0
	- This VCL was inspired by an article in "Delphi Delvelopers Journal"
Version 1.1 - 2/17/97
	- Well first version did not work during runtime! It seem that
      SetCaptions does not get called during loading even though
      FCaptions is set!  Any way force it to always call SetMargin
      and put call there.  Also switch to using Buttons[x] rather than
      trying to find the buttons.
Version 1.2	- 3-8-97
	- Captions removed at design time were not set back to default values
    - Added version constant
===============================================================================
V 2.0
Passage des touches
Ex: if ExRxDBGrid1.Focused then DBNavPlus2.EventClavier(Key);
dans TForm1.FormKeyDown
===============================================================================
*)
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DBCtrls,ExRxDBGrid, Buttons,db,dbtables;

const
     DBNavPlusVersion = '2.0';
type
  TDBNavPlus = class(TDBNavigator)
  private
    { Private declarations }
    DoCaptions: boolean;
    FCaptions: TStrings;
    FLayout: TButtonLayout;
    FSpacing: Integer;
    FMargin: Integer;
    FdBgrid:TExRXdbgrid;
    FAutoInsert:boolean;
//    mark1: TBookMark;
  public
    procedure ClickHandler(Sender: TObject);
 protected
    { Protected declarations }
    procedure SetLayout(value: TButtonLayout);
    procedure SetSpacing(value: integer);
    procedure SetMargin(value: integer);
    procedure SetCaptions(value: TStrings);

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure EventClavier(key:word);
    procedure BtnClick(Index: TNavigateBtn);

  published
    { Published declarations }
		property Captions: TStrings read FCaptions write SetCaptions;
		property Layout: TButtonLayout read FLayout write SetLayout default blGlyphTop;
		property Spacing: Integer read FSpacing write SetSpacing default 2;
    {if we dont set default, the SetMargin is called}
    {this will allow us to put the SetCaptions in as it is not called!}
		property Margin: Integer read FMargin write SetMargin;
		property Font;
      property Grille:TExRXdbgrid read Fdbgrid write Fdbgrid ;
      property AutoInsert:boolean read FAutoInsert write FAutoInsert default True;
  end;

procedure Register;

implementation

const
	DefaultCaption: array[0..9] of string =
  	('Début','Précédent','Suivant','Fin','F6 Ajouter',
         'F10 Supprimer','F2 Modifier','F3 Enregistrer','Annuler','Refresh');

{******************************************************************************}
//******************* TDBNavPlus.Create *************************
constructor TDBNavPlus.Create(AOwner: TComponent);
var
  I: TNavigateBtn;
  Btn: TNavButton;
  X: Integer;
//  ResName: string;
      MinBtnSize: TPoint;

begin
Inherited create(AOwner);
  MinBtnSize := Point(20, 18);
  X := 0;
  for I := Low(Buttons) to High(Buttons) do
  begin
    Btn := TNavButton.Create (Self);
    Btn.Flat := Flat;
    Btn.Index := I;
//  Btn.Visible := I in FVisibleButtons;
    Btn.Visible :=true;
    Btn.Enabled := True;
    Btn.SetBounds (X, 0, MinBtnSize.X, MinBtnSize.Y);
//  FmtStr(ResName, 'dbn_%s', [BtnTypeName[I]]);
//  Btn.Glyph.LoadFromResourceName(HInstance, ResName);
//  Btn.NumGlyphs := 2;
    Btn.Enabled := False;
    Btn.Enabled := True;
    Btn.OnClick := ClickHandler;
//  Btn.OnMouseDown := BtnMouseDown;
    Btn.Parent := Self;
    Buttons[I] := Btn;
    X := X + MinBtnSize.X;
  end;
//  InitHints;
  Buttons[nbPrior].NavStyle := Buttons[nbPrior].NavStyle + [nsAllowTimer];
  Buttons[nbNext].NavStyle  := Buttons[nbNext].NavStyle + [nsAllowTimer];

  {initialize values}
  FCaptions := TStringList.create;
  DoCaptions := True;
  FSpacing := 0;
  SetSpacing(2);
  FMargin := 0;
  SetMargin(-1);
  FLayout := blGlyphBottom;
  SetLayout(blGlyphTop);
  FCaptions.Clear;
  for x := 0 to 9 do FCaptions.Add(DefaultCaption[x]);
  SetCaptions(FCaptions);

end; {of Create}

{******************************************************************************}
destructor TDBNavPlus.Destroy;
begin
	FCaptions.Free;
	inherited Destroy;
end; {of destroy}

procedure TDBNavPlus.ClickHandler(Sender: TObject);
begin
  BtnClick (TNavButton (Sender).Index);
end;

{******************************************************************************}
//******************* TDBNavPlus.SetCaptions *************************
procedure TDBNavPlus.SetCaptions(Value: TStrings);
var
  t: TNavigateBtn;
begin
	{set captions or default if not assigned}
	if Value <> FCaptions  then FCaptions.Assign(Value);

	for t:= low(TNavigateBtn) to high(TNavigateBtn) do begin
		if ord(t) < Value.Count
                    then Buttons[t].caption := Value[ord(t)]
                    else Buttons[t].caption := DefaultCaption[ord(t)];
                end;
  Invalidate;
end; {of setCaptions}

{******************************************************************************}
//******************* TDBNavPlus.SetLayout *************************
procedure TDBNavPlus.SetLayout(value: TButtonLayout);
var
  t: TNavigateBtn;
begin
	if (value = Flayout) and  not (csLoading in ComponentState) then exit;
	FLayout := value;
	for t:= low(TNavigateBtn) to high(TNavigateBtn)
  do Buttons[t].Layout := value;
  Invalidate;
end; {of SetLayout}

{******************************************************************************}
//******************* TDBNavPlus.SetSpacing *************************
procedure TDBNavPlus.SetSpacing(value: integer);
var
  t: TNavigateBtn;
begin
	if (value = FSpacing) and not (csLoading in ComponentState) then exit;
	FSpacing := value;
	for t:= low(TNavigateBtn) to high(TNavigateBtn)
  do Buttons[t].Spacing := value;
  Invalidate;
end; {of SetSpacing}

{******************************************************************************}
procedure TDBNavPlus.SetMargin(value: integer);
var
  t: TNavigateBtn;
begin
	if (value = FMargin) and not (csLoading in ComponentState) then exit;
  if (csLoading in ComponentState) then SetCaptions(FCaptions);
	FMargin := value;
	for t:= low(TNavigateBtn) to high(TNavigateBtn)
  do Buttons[t].margin := value;
  Invalidate;
end; {of SetMargin}
{******************************************************************************}
//******************* TDBNavPlus.EventClavier *************************

procedure TDBNavPlus.EventClavier(key:word);
var
  T: TNavigateBtn;
  Btn: TNavButton;
begin
  if (DataSource <> nil) then
     case key of
      VK_F3:begin      //Enregistrer
              if DataSource.DataSet.State in [DsInsert,DsEdit] then
              begin
//                 mark1 := DataSource.DataSet.GetBookmark;
              BtnClick(nbPost);
              end;
            end;
//     VK_F9:begin    //annuler
//              if Btn.Enabled then
//                 begin
//                 BtnClick(nbcancel);
//                 end;
//            end;

      VK_F6:begin           // Ajouter
                 grille.SetFocus;
                 BtnClick(nbInsert);
            end;

//    VK_F8:begin           //Modif
//             if DataSource.DataSet.State in [DsBrowse] then
//                begin
//                grille.SetFocus;
//                BtnClick(nbEdit);
//                end;
//           end;
      VK_F10:begin
             if DataSource.DataSet.State in [DsBrowse] then
                begin
                  BtnClick(nbDelete);
                end;
              end;

      VK_RETURN:begin   //Si l'index de la colonne=nombre total de colonnes et la table en insertion

                 if FAutoInsert then
                    case datasource.State  of
                      dsinsert :begin

                                if ((grille.SelectedIndex+1)< (grille.Columns.Count)) then
                                   begin
                                  grille.SelectedIndex:=grille.SelectedIndex +1; //Cellule +1
                                   end
                                else
                                   begin
                                    BtnClick(nbPost)  ;
                                    BtnClick(nbInsert);       // et on ajoute un autre
                                   end;
                                end;
                      dsedit :begin
                                if ((grille.SelectedIndex+1)< (grille.Columns.Count) ) then
                                   begin
                                 grille.SelectedIndex:=(grille.SelectedIndex +1); //Cellule +1
                                   end
                                else
                                   begin
                                       BtnClick(nbPost)  ;
                                       grille.InplaceEditor.Deselect;
                                   end;
                                end;
                      dsbrowse:begin
                               if ((grille.Columns.Count -1)=(grille.SelectedIndex)) then
                                   begin
                                     BtnClick(nbnext);
                                     Grille.InplaceEditor.Deselect;
                                   end
                               else
                                   begin
                                   grille.SelectedIndex:=grille.SelectedIndex +1; //Cellule +1
                                   Grille.InplaceEditor.Deselect;
                                   end;
                               end;
                    end;
                    end;
                   end;
                end;

//******************* TDBNavPlus.BtnClick *************************
procedure TDBNavPlus.BtnClick(Index: TNavigateBtn);

begin
if (DataSource <> nil) then
  begin
    Grille.EditorMode:=true;
//    Grille.InplaceEdit.SelectAll;
    begin
      case Index of
        nbInsert: begin
                  grille.SelectedIndex:=0 ; //colonne 0
                  DataSource.DataSet.Insert;
                  end;
        nbEdit:begin
                 Grille.InplaceEdit.deselect;
                 DataSource.DataSet.Edit;
               end;
        nbCancel:begin
                 DataSource.DataSet.Cancel;
                 end;
        nbPost:begin

//                 mark := DataSource.DataSet.GetBookmark;
                 DataSource.DataSet.post;
            //      BtnClick(nbRefresh);
  //               DataSource.DataSet.GotoBookmark(mark);
   //              DataSource.DataSet.FreeBookmark(mark) ;
              end;
       nbNext:begin
               DataSource.DataSet.Next;
//               grille.SelectedIndex:=0  ;//colonne 0
               Grille.InplaceEditor.Deselect;

               end;
        nbPrior: DataSource.DataSet.Prior;
        nbFirst: DataSource.DataSet.First;
        nbLast:  DataSource.DataSet.Last;
        nbRefresh: DataSource.DataSet.Refresh;
        nbDelete:begin
                  DataSource.DataSet.delete;
                 grille.SelectedIndex:=0  //colonne 0
                 end;
     end;
    end;
  end;
end;
{******************************************************************************}
//******************* Unknown *************************
procedure Register;
begin
  RegisterComponents('Perso', [TDBNavPlus]);
end; {of Register}
end. {of uniut}
