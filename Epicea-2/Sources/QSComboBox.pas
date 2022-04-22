{
***********************************************************************
**                                                                   **
**        QSComboBox.PAS - Last modified: 18. October 1997           **
**                                                                   **
***********************************************************************
**                                                                   **
**  This is a component which enables the user to select from the    **
**  reports without launching the TQuickSelect dialog. It is         **
**  supplied with TQuickSelect as a demonstration on how to access   **
**  the saved reports without having to launch the TQuickSelect      **
**  dialog.                                                          **
**                                                                   **
**  You may use this source in any way you want, but please          **
**  include a note telling where you originally got it from.         **
**                                                                   **
***********************************************************************
}

unit QSComboBox;

interface

uses QuickSelect, SysUtils, StdCtrls, Classes, Forms;


type
{ TQSComboBox }
  ENoSource = class (Exception);
  EInvalidQSComp = class (Exception);

  TQSComboBox = class (TCustomComboBox)
  private
    FQSelectSource : TQuickSelect;
  protected
    { Overrides Change to update the QSelectSource.ActiveReport when the user selects an item }
    procedure Change; override;
    { Overrides DoEnter to update the list of available reportnames when the user enters the ComboBox }
    procedure DoEnter; override;
  public
    constructor Create (AOwner : TComponent); override;
    destructor Destroy; override;

    { Updates the list of available reportnames }
    procedure UpdateReportNames;
  published
    { Refers to a TQuickSelect component. The user may select from the reports saved with
    { this component. The ActiveReport of this component is updated when the user selects
    { a report. }
    property QSelectSource : TQuickSelect read FQSelectSource write FQSelectSource;

    { Inherited properties }
    property Color;
    property Ctl3D;
    property DragMode;
    property DragCursor;
    property DropDownCount;
    property Enabled;
    property Font;
    property ItemHeight;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnStartDrag;
  end;


{ Declaration of propertyeditors }

  { The TQSDropDownStringProperty class is defined in QuickSelect.pas }
  TQSQSelectSourceProperty = class (TQSDropDownStringProperty)
  public
    procedure GetValueList (List : TStrings); override; { Get a list of possible values }
    procedure SetValue (const Value : String); override;
    function GetValue : String; override;
  end;


implementation


{*
 *  Constructor and Destructor
 *}

constructor TQSComboBox.Create (AOwner : TComponent);
begin
  inherited Create (AOwner);

  FQSelectSource := nil;

  Style := csDropDownList;
end;

destructor TQSComboBox.Destroy;
begin
  inherited Destroy;
end;


{*
 *  Dispatch methods
 *}

procedure TQSComboBox.Change;
begin
  if ItemIndex > -1 then
  begin
    if (FQSelectSource <> nil) and (FQSelectSource is TQuickSelect)
      then QSelectSource.ActiveReport := Items[ItemIndex]
      else raise ENoSource.Create ('The QSelectSource property does not reference a TQuickSelect object');
  end else QSelectSource.ActiveReport := '';

  inherited Change;
end;

procedure TQSComboBox.DoEnter;
begin
  UpdateReportNames;

  inherited DoEnter;
end;


{*
 *  Public methods
 *}

procedure TQSComboBox.UpdateReportNames;
begin
  if (FQSelectSource <> nil) and (FQSelectSource is TQuickSelect)
    then Items := FQSelectSource.ReportNames
    else raise ENoSource.Create ('The QSelectSource property does not reference a TQuickSelect object');
end;


{*
 *  Implementation of propertyeditors
 *}

procedure TQSQSelectSourceProperty.GetValueList (List : TStrings);
var
  QSComboBox : TQSComboBox;
  CompCnt : Integer;
begin
  QSComboBox := (GetComponent (0) as TQSComboBox);
  for CompCnt := 0 to QSComboBox.Owner.ComponentCount - 1 do
    if QSComboBox.Owner.Components[CompCnt] is TQuickSelect
      then List.Add (QSComboBox.Owner.Components[CompCnt].Name);
end;

procedure TQSQSelectSourceProperty.SetValue (const Value : String);
var
  QSComboBox : TQSComboBox;
  CompCnt : Integer;
  Found : Boolean;
begin
  QSComboBox := (GetComponent (0) as TQSComboBox);

  Found := False;
  for CompCnt := 0 to QSComboBox.Owner.ComponentCount - 1 do
    if (QSComboBox.Owner.Components[CompCnt] is TQuickSelect) and
       (AnsiUpperCase (QSComboBox.Owner.Components[CompCnt].Name) = AnsiUpperCase (Value)) then
    begin
      SetOrdValue (LongInt (QSComboBox.Owner.Components[CompCnt]));
      Found := True;
      Break;
    end;

  if (not Found) and (Value <> '')
    then raise EInvalidQSComp.Create ('This is not a valid TQuickSelect component');

  if Value = '' then SetOrdValue (0);
end;

function TQSQSelectSourceProperty.GetValue : String;
begin
  if (GetOrdValue <> 0) and (TObject (GetOrdValue) is TQuickSelect)
    then Result := TQuickSelect (GetOrdValue).Name
    else Result := '';
end;

end.
