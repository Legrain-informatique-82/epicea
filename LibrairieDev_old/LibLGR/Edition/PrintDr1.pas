unit PrintDr1;
{
	This unit contains the preview form which will allow you to view a preview of
  the printed output. It also contains the declarations that store the print commands
  from the PrintDrv module. These commands are stored in a PageList for easy viewing
  and switching between pages. During preview mode, the current PageList of commands
  is sent to the PrintDrv module and "played back" to the preview canvas for viewing.
  Each of the classes of print commands descends from a base class called
  TMWPrintCommand. (I call my company TMW Software, so all the classes start with TMW)
}
interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Spin, Mask, SysUtils, Dialogs, Printers, Messages;

const
	iBitmap = 1;
  { string constants to use. allows you to use your own language }
  PREVIEWFORMCAPTION = 1001;
  CANCELBTNTEXT = 1002;
  CLOSETEXT = 1003;
  CLOSEHINT = 1004;
  PRINTTEXT = 1005;
  PRINTHINT = 1006;
  ZOOMTEXT = 1007;
  FIRSTPAGEHINT = 1008;
  PREVPAGEHINT = 1009;
  NEXTPAGEHINT = 1010;
  LASTPAGEHINT = 1011;
  PRINTCAPTIONTEXT = 1012;
  PREPARETEXT = 1013;


type

  THeaderRecord = record
  	Text: string[240];                   { Header text }
    YPosition: double;                   { Inches from the top }
    Alignment: word;                  { 0:Left 1:Center 2:Right }
    Font: TFont;												 { Current font information }
  end;

  TFooterRecord = record
    Text: string[240];                   { Footer text }
    YPosition: double;                   { Inches from the top }
    Alignment: word;                  { 0:Left 1:Center 2:Right }
    Font: TFont;												 { Current font information }
  end;

  THeaderCoordinates = record
  	XTop: double;
    YTop: double;
    XBottom: double;
    YBottom: double;
    Boxed: boolean;
    Shading: TColor;
    LineWidth: word;
  end;

  TFooterCoordinates = record
    XTop: double;
    YTop: double;
    XBottom: double;
    YBottom: double;
    Boxed: boolean;
    Shading: TColor;
    LineWidth: word;
  end;

  TPageNumberRecord = record
    YPosition: double;
    Text: string[240];
    Alignment: word;
    Font: TFont;												 { Current font information }
    ShowTotalPages: boolean;
  end;

  TColumnInformationRecord = record
    XPosition: double;
    Length: double;
  end;

  TFontInformationRecord = record
  	Font: TFont;
  end;

  inTPoint = record
  	X,Y: double;
  end;

  Percentages = ({P1_Fifty,}P2_Sixty,P3_Seventy,P4_Eighty,P5_Ninety,P6_Full);

  PrnPaperRec = Record
  	pType: integer;
    Width,
    Height: double;
  end;

  RTRect = record
  	Left,Top,
    Right,Bottom: double;
  end;

  TMWPoint = record
  	X,Y: double;
  end;

  {The CommandSet contains the print commands that can be stored in the TMWPrintCommand
   object list.}
	CommandSet = (commLine,commNewLine,commNewPage,commGraphic,commWritePage,
  							commDetailArea,commFont,commFooterDim,commFooterInf,commGraphicFile,
                commHeaderDim,commHeaderInf,commLineWidth,commMargins,commOrient,
                commPageNumber,commTab,commTopOfPage,commSetY,commText,commColumn,
                commSetPrint,commGetPrint,commSizeLetter,commSizeLegal,commAutoPageTrue,
                commAutoPageFalse,commSaveY,commRestoreY,commFColor,commBColor,commPColor,
                commMoveTo,commLineTo,commEllipse,commBrushStyle,commFloodFill,commFillRect,
                commFrameRect,commArc,commPie,commPolyLine,commPolygon,commMeasure,commPStyle,
                commPMode,commFontAngle,commColRight,commWriteRight,commIndent,commTransparent);

	{ Base class for all print command objects. It simply contains the type of command
    that the object contains so that the appropriate cast can be performed.}
	TMWPrintCommand = class
  private
    fCommand: CommandSet;
  public
  	constructor Create(commCommand: CommandSet);
    destructor Destroy; override;
    property Command: CommandSet read fCommand write fCommand;
  end;

  {The following declarations are the print command classes descended from
   TMWPrintCommand. Each one stores the necessary information to execute
   the printing when played back. This allows the component to make any
   adjustments needed at run-time depending on the printing device it is
   using.}

  TMWLine = class(TMWPrintCommand)
  private
  	xTop,yTop,xBottom,yBottom: double;
    lWidth,shade: word;
  public
  	constructor Create(x,y,x1,y1: double;LineWidth: word); virtual;
    destructor Destroy; override;
    property X1: double read xTop;
    property Y1: double read yTop;
    property X2: double read xBottom;
    property Y2: double read yBottom;
    property LineWidth: word read lWidth;
  end;

  TMWGraphic = class(TMWPrintCommand)
  private
  	xTop,yTop,xHeight,yWidth: double;
    image: TImage;
    iType: integer;
  public
  	constructor Create(x,y,x1,y1: double;Bitmap: TImage;OfType: integer);virtual;
    destructor Destroy; override;
    property X: double read xTop;
    property Y: double read yTop;
    property Height: double read xHeight;
    property Width: double read yWidth;
    property BitMap: TImage read image;
    property ImageType: integer read iType;
  end;

  TMWDetail = class(TMWPrintCommand)
  private
  	xTop,xBottom: double;
  public
  	constructor Create(x,y: double);virtual;
    destructor Destroy; override;
    property X: double read xTop;
    property Y: double read xBottom;
  end;

  TMWFont = class(TMWPrintCommand)
  private
  	fFont: TFont;
    function GetFontName: string;
    function GetFontSize: integer;
    function GetFontStyle: TFontStyles;
    function GetFontColor: TColor;
  public
  	constructor Create(pFont: TFont);virtual;
    destructor Destroy; override;
    property Font: TFont read fFont write fFont;
    property Name: string read GetFontName;
    property Size: integer read GetFontSize;
    property Style: TFontStyles read GetFontStyle;
    property Color: TColor read GetFontColor;
  end;

  TMWFooterDim = class(TMWPrintCommand)
  private
  	xTop,yTop,xBottom,yBottom: double;
    isBox: boolean;
    lWidth: word;
    shade: TColor;
  public
  	constructor Create(x,y,x1,y1: double;Boxed: boolean;LineWidth: word;Shading: TColor);virtual;
    destructor Destroy; override;
    property X1: double read xTop;
    property Y1: double read yTop;
    property X2: double read xBottom;
    property Y2: double read yBottom;
    property Boxed: boolean read isBox;
    property LineWidth: word read lWidth;
    property Shading: TColor read shade;
  end;

  TMWFooterInf = class(TMWPrintCommand)
  private
  	iLine: integer;
    yBottom: double;
    sText: string;
    wAlign: word;
    fFont: TFont;
    function GetFontName: string;
    function GetFontSize: integer;
    function GetFontStyle: TFontStyles;
    function GetFontColor: TColor;
  public
  	constructor Create(Line: integer;y: double;Text: string;Alignment: word;
  				FontName: string;Size: word;Style: TFontStyles; Color: TColor);virtual;
    destructor Destroy; override;
    property Line: integer read iLine;
    property yPosition: double read yBottom;
    property Text: string read sText;
    property Alignment: word read wAlign;
    property Font: TFont read fFont;
    property FontName: string read GetFontName;
    property Size: integer read GetFontSize;
    property Style: TFontStyles read GetFontStyle;
    property Color: TColor read GetFontColor;
  end;

  TMWHeaderDim = class(TMWPrintCommand)
  private
  	xTop,yTop,xBottom,yBottom: double;
    isBox: boolean;
    lWidth: word;
    shade: TColor;
  public
  	constructor Create(x,y,x1,y1: double;Boxed: boolean;LineWidth: word;Shading: TColor);virtual;
    destructor Destroy; override;
    property X1: double read xTop;
    property Y1: double read yTop;
    property X2: double read xBottom;
    property Y2: double read yBottom;
    property Boxed: boolean read isBox;
    property LineWidth: word read lWidth;
    property Shading: TColor read shade;
  end;

  TMWHeaderInf = class(TMWPrintCommand)
  private
  	iLine: integer;
    yBottom: double;
    sText: string;
    wAlign: word;
    fFont: TFont;
    function GetFontName: string;
    function GetFontSize: integer;
    function GetFontStyle: TFontStyles;
    function GetFontColor: TColor;
  public
  	constructor Create(Line: integer;y: double;Text: string;Alignment: word;
  				FontName: string;Size: word;Style: TFontStyles; Color: TColor);virtual;
    destructor Destroy; override;
    property Line: integer read iLine;
    property yPosition: double read yBottom;
    property Text: string read sText;
    property Alignment: word read wAlign;
    property Font: TFont read fFont;
    property FontName: string read GetFontName;
    property Size: integer read GetFontSize;
    property Style: TFontStyles read GetFontStyle;
    property Color: TColor read GetFontColor;
  end;

  TMWLineWidth = class(TMWPrintCommand)
  private
  	lWidth: word;
  public
  	constructor Create(LineWidth: word);virtual;
    destructor Destroy; override;
    property LineWidth: word read lWidth;
  end;

  TMWMargins = class(TMWPrintCommand)
  private
  	xTop,yTop,xBottom,yBottom: double;
  public
  	constructor Create(x,y,x1,y1: double);
    destructor Destroy; override;
    property X1: double read xTop;
    property Y1: double read yTop;
    property X2: double read xBottom;
    property Y2: double read yBottom;
  end;

  TMWOrient = class(TMWPrintCommand)
  private
  	pOrient: TPrinterOrientation;
  public
  	constructor Create(Orientation: TPrinterOrientation);virtual;
    destructor Destroy; override;
    property Orientation: TPrinterOrientation read pOrient;
  end;

  TMWPageNumber = class(TMWPrintCommand)
  private
  	yBottom: double;
    sText: string;
    wAlign: word;
    fFont: TFont;
    DoTotal: boolean;
    function GetFontName: string;
    function GetFontSize: integer;
    function GetFontStyle: TFontStyles;
    function GetFontColor: TColor;
  public
  	constructor Create(y: double;Text: string;Alignment: word;PageTotal: boolean;
    		FontName: string;Size: word;Style:TFontStyles; Color: TColor);virtual;
    destructor Destroy; override;
    property yPosition: double read yBottom;
    property Text: string read sText;
    property Alignment: word read wAlign;
    property Font: TFont read fFont;
    property FontName: string read GetFontName;
    property Size: integer read GetFontSize;
    property Style: TFontStyles read GetFontStyle;
    property Color: TColor read GetFontColor;
    property IncludeTotal: boolean read DoTotal;
  end;

  TMWTab = class(TMWPrintCommand)
  private
  	sTab: double;
  public
  	constructor Create(Tab: double);virtual;
    destructor Destroy; override;
    property Tab: double read sTab;
  end;

  TMWIndent = class(TMWPrintCommand)
  private
  	sIndent: double;
  public
  	constructor Create(Indent: double);virtual;
    destructor Destroy; override;
    property Indent: double read sIndent;
  end;

  TMWSetY = class(TMWPrintCommand)
  private
  	yBottom: double;
  public
  	constructor Create(y: double);virtual;
    destructor Destroy; override;
    property yPosition: double read yBottom;
  end;

  TMWFColor = class(TMWPrintCommand)
  private
  	iColor: TColor;
  public
  	constructor Create(iC: TColor);virtual;
    destructor Destroy; override;
    property Color: TColor read iColor;
  end;

  TMWBColor = class(TMWPrintCommand)
  private
  	iColor: TColor;
  public
  	constructor Create(iC: TColor);virtual;
    destructor Destroy; override;
    property Color: TColor read iColor;
  end;

  TMWPColor = class(TMWPrintCommand)
  private
  	iColor: TColor;
  public
  	constructor Create(iC: TColor);virtual;
    destructor Destroy; override;
    property Color: TColor read iColor;
  end;

  TMWPStyle = class(TMWPrintCommand)
  private
  	penStyle: TPenStyle;
  public
  	constructor Create(Style: TPenStyle);virtual;
    destructor Destroy; override;
    property Style: TPenStyle read penStyle write penStyle;
  end;

  TMWPMode = class(TMWPrintCommand)
  private
  	penMode: TPenMode;
  public
  	constructor Create(Mode: TPenMode);virtual;
    destructor Destroy; override;
    property Mode: TPenMode read penMode write penMode;
  end;

  TMWPWidth = class(TMWPrintCommand)
  private
  	lWidth: word;
  public
  	constructor Create(iWidth: word);virtual;
    destructor Destroy; override;
    property Width: word read lWidth write lWidth;
  end;

  TMWText = class(TMWPrintCommand)
  private
  	xTop,yTop: double;
    sText: string;
    bColor: TColor;
  public
  	constructor Create(x,y: double; Text: string;BrushColor: TColor);virtual;
    destructor Destroy; override;
    property X: double read xTop;
    property Y: double read yTop;
    property Text: string read sText;
    property BrushColor: TColor read bColor;
  end;

  TMWColRight = class(TMWPrintCommand)
  private
  	yTop: double;
    sText: string;
    Column: integer;
  public
  	constructor Create(col: integer; y: double; s: string);virtual;
    destructor Destroy; override;
    property ColumnNumber: integer read Column write Column;
    property Y: double read yTop write yTop;
    property Text: string read sText write sText;
  end;

  TMWWriteRight = class(TMWPrintCommand)
  private
  	yTop: double;
    sText: string;
  public
  	constructor Create(y: double; s: string);virtual;
    destructor Destroy; override;
    property Y: double read yTop write yTop;
    property Text: string read sText write sText;
  end;

  TMWColumn = class(TMWPrintCommand)
  private
  	Numb: word;
    sPosition,sLength: double;
  public
  	constructor Create(Number: word;XPosition,Length: double);virtual;
    destructor Destroy; override;
    property Number: word read Numb;
    property XPosition: double read sPosition;
    property Length: double read sLength;
  end;

  TMWGraphicPoint = class(TMWPrintCommand)
  private
  	lPoint: TMWPoint;
    function GetX1: double;
    function GetY1: double;
  public
  	constructor Create(x,y: double;gType: CommandSet);virtual;
    destructor Destroy;override;
    property X1: double read GetX1;
    property Y1: double read GetY1;
  end;

  TMWPieArc = class(TMWPrintCommand)
  private
  	Point1,
    Point2,
    Point3,
    Point4: TMWPoint;
    function GetX1: double;
    function GetX2: double;
    function GetX3: double;
    function GetX4: double;
    function GetY1: double;
    function GetY2: double;
    function GetY3: double;
    function GetY4: double;
  public
  	constructor Create(x1,y1,x2,y2,x3,y3,x4,y4: double;gType: CommandSet);virtual;
    destructor Destroy;override;
    property X1: double read GetX1;
    property X2: double read GetX2;
    property X3: double read GetX3;
    property X4: double read GetX4;
    property Y1: double read GetY1;
    property Y2: double read GetY2;
    property Y3: double read GetY3;
    property Y4: double read GetY4;
  end;

  TMWEllipse = class(TMWPrintCommand)
  private
  	Point1,
    Point2: TMWPoint;
  	function GetX1: double;
    function GetX2: double;
    function GetY1: double;
    function GetY2: double;
  public
  	constructor Create(x1,y1,x2,y2: double);virtual;
    destructor Destroy;override;
    property X1: double read GetX1;
    property X2: double read GetX2;
    property Y1: double read GetY1;
    property Y2: double read GetY2;
  end;

  TMWBrushStyle = class(TMWPrintCommand)
  private
  	fStyle: TBrushStyle;
  public
  	constructor Create(bStyle: TBrushStyle);virtual;
    destructor Destroy;override;
    property Style: TBrushStyle read fStyle;
  end;

  TMWFloodFill = class(TMWPrintCommand)
  private
    lX,
    lY: double;
    lColor: TColor;
    lFill: TFillStyle;
  public
  	constructor Create(X1,Y1: double;iColor: TColor;iFillStyle: TFillStyle);virtual;
    destructor Destroy;override;
    property X: double read lX;
    property Y: double read lY;
    property Color: TColor read lColor;
    property FillStyle: TFillStyle read lFill;
  end;

  TMWFillRect = class(TMWPrintCommand)
  private
  	Point1,
    Point2: TMWPoint;
  public
  	constructor Create(X1, Y1, X2, Y2: double);virtual;
    destructor Destroy;override;
    property X1: double read Point1.X;
    property Y1: double read Point1.Y;
    property X2: double read Point2.X;
    property Y2: double read Point2.Y;
  end;

  TMWFrameRect = class(TMWPrintCommand)
  private
  	Point1,
    Point2: TMWPoint;
  public
  	constructor Create(X1, Y1, X2, Y2: double);virtual;
    destructor Destroy;override;
    property X1: double read Point1.X;
    property Y1: double read Point1.Y;
    property X2: double read Point2.X;
    property Y2: double read Point2.Y;
  end;

  TMWPolygon = class(TMWPrintCommand)
  public
  	Points: array [0..99] of double;
    Num: integer;
  	constructor Create(iPoints: array of double;gType: CommandSet);virtual;
    destructor Destroy;override;
  end;

  TMWMeasure = class(TMWPrintCommand)
  public
  	Measure: integer;
  	constructor Create(Meas: integer);virtual;
    destructor Destroy;override;
  end;

  TMWFontAngle = class(TMWPrintCommand)
  public
  	Angle: integer;
    constructor Create(Ang: integer);virtual;
    destructor Destroy;override;
  end;

	TMWTransparent = class(TMWPrintCommand)
  public
  	OnOff: boolean;
  	constructor Create(Flag: boolean);virtual;
    destructor Destroy;override;
  end;

  {	The TMWPageList object contains the list of page objects created during printing.}

  TMWPageList = class
  private
  	Items: TList;
  	function GetCount: integer;
  public
  	constructor Create;
    destructor Destroy; override;
    procedure Add(PrintCommand: TMWPrintCommand);
    function Get(Number: integer): TMWPrintCommand;
    procedure Clear;
    property Count: integer read GetCount;
  end;

  {	The TMWPages object contains the list of commands for a page created
  	during printing. These commands are then played back either by the preview
    form or by printing to the printer.}

  TMWPages = class
  private
  	PageList: TList;
    CurrentPage: integer;
    FirstPage,
    LastPage: integer;
    function GetCount: integer;
  public
  	TotalPages: integer;
  	ScaleAmount: array [0..5] of integer;
  	tPageHeight,
  	tPageWidth: double;

  	constructor Create;
    destructor Destroy; override;
    procedure NewPage;
    procedure Add(PrintCommand: TMWPrintCommand);
    function Get(Number: integer): TMWPageList;
    procedure ClearPage;
//    procedure StoreBox(x,y,x1,y1: double;Width,Shading: word);
    procedure StoreColumn(Number: word; Position,Length: double);
    procedure StoreFColor(iColor: TColor);
    procedure StoreBColor(iColor: TColor);
    procedure StoreBStyle(bStyle: TBrushStyle);
    procedure StorePColor(iColor: TColor);
    procedure StorePStyle(Style: TPenStyle);
    procedure StorePMode(Mode: TPenMode);
    procedure StoreLine(x,y,x1,y1: double;Width: word);
    procedure StoreGeneral(Command: CommandSet);
    procedure StoreGraphic(x,y,h,w: double;Bitmap: TImage);
    procedure StoreDetailArea(x,x1: double);
    procedure StoreFontChange(fFont: TFont);
    procedure StoreFooterDim(x,y,x1,y1: double;Boxed: boolean;Width: word;Shading: TColor);
    procedure StoreFooterInf(Line: integer;y: double;Text: string;Alignment: word;
    													FontName: string;FontSize: word;FontStyle: TFontStyles;
                              FontColor: TColor);
    procedure StoreHeaderDim(x,y,x1,y1: double;Boxed: boolean;Width: word;Shading: TColor);
    procedure StoreHeaderInf(Line: integer;y: double;Text: string;Alignment: word;
    													FontName: string;FontSize: word;FontStyle: TFontStyles;
                              FontColor: TColor);
    procedure StoreLineWidth(Width: word);
    procedure StoreMargins(t,b,l,r: double);
    procedure StoreOrient(Orient: TPrinterOrientation);
    procedure StorePageNumber(y: double;Text: string;Alignment: word;TotalPage: boolean;
    													FontName: string;FontSize: word;FontStyle: TFontStyles;
                              FontColor: TColor);
    procedure StoreTab(Inches: double);
    procedure StoreSetY(y: double);
    procedure StoreText(x,y: double;Text: string;BrushColor: TColor);
    procedure StoreLineTo(x,y: double);
    procedure StoreMoveTo(x,y: double);
    procedure StoreEllipse(x1,y1,x2,y2: double);
    procedure StoreFillRect(X1, Y1, X2, Y2: double);
    procedure StoreFloodFill(x1,y1: double;iColor: TColor;iFillStyle: TFillStyle);
    procedure StoreFrameRect(X1, Y1, X2, Y2: double);
    procedure StoreArc(x1,y1,x2,y2,x3,y3,x4,y4: double);
    procedure StorePie(x1,y1,x2,y2,x3,y3,x4,y4: double);
    procedure StorePolyLine(iPoints: array of double);
    procedure StorePolygon(iPoints: array of double);
    procedure StoreMeasure(Meas: integer);
    procedure StoreFontAngle(Angle: integer);
    procedure StoreColRight(Col: integer; y: double; Text: string);
    procedure StoreWriteLineRight(y: double; Text: string);
    procedure StoreIndent(x: double);
    procedure StoreTransparent(Flag: boolean);
    function SetPrintOptions: boolean;
    procedure ClearAll;
    function CountCommands: integer;
    property FromPage: integer read FirstPage write FirstPage;
    property ToPage: integer read LastPage write LastPage;
    property Count: integer read GetCount;
  end;

  TPreviewForm = class(TForm)
    Panel2: TPanel;
    CloseBtn: TBitBtn;
    PreviewPane: TScrollBox;
    ZoomFactor: TComboBox;
    ZoomLabel: TLabel;
    PrintBtn: TBitBtn;
    PrintDialog1: TPrintDialog;
    FirstPage: TSpeedButton;
    PrevPage: TSpeedButton;
    NextPage: TSpeedButton;
    LastPage: TSpeedButton;
    PgNumb: TEdit;
    TMWPanelLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ZoomFactorChange(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PgNumbKeyPress(Sender: TObject; var Key: Char);
    procedure PgNumbExit(Sender: TObject);
    procedure FirstPageClick(Sender: TObject);
    procedure LastPageClick(Sender: TObject);
    procedure PrevPageClick(Sender: TObject);
    procedure NextPageClick(Sender: TObject);
    procedure PgNumbKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    CurrentPage: integer; {Used to know which page the preview is viewing}
    NormalPixelsPerInch: word;
    NormalFontSize: integer;
    CanvasOrient: TPrinterOrientation;
    procedure ClearDisplayCanvas;
		procedure SetPageButtons;
  public
    { Public declarations }
    StartPercent: integer;
		function GetCurrentPage: TImage;
		function GetPageNumber: integer;
    procedure CopyCurrentCanvas;
    procedure Abort;
    procedure SetPreviewPrn(Prn: TObject);
    procedure SetOrient(Orient: TPrinterOrientation);
    function GetHeight: integer;
    function GetWidth: integer;
  end;


var
  PreviewForm: TPreviewForm;
	NewImage: TImage; {The canvas used for preview modes}
  LargeFontsOn: boolean; {set to determine if large fonts are bring used in Windows}

implementation

{$R *.DFM}
uses PrintDrv;

var
	PPrn: TMWPrintObject;

constructor TMWPages.Create;
begin
	PageList := TList.Create;
  CurrentPage := 0;
  ScaleAmount[0] := 52;
  ScaleAmount[1] := 64;
  ScaleAmount[2] := 78;
  ScaleAmount[3] := 94;
  ScaleAmount[4] := 100;
end;

destructor TMWPages.Destroy;
var
	x: integer;

begin
	for x := 0 to PageList.Count - 1 do
  	TMWPageList(PageList[x]).Free;
	PageList.Free;
  inherited Destroy;
end;

procedure TMWPages.Add(PrintCommand: TMWPrintCommand);
begin
	if CurrentPage = 0 then
  	exit;
  TMWPageList(PageList[CurrentPage-1]).Add(PrintCommand);
end;

function TMWPages.Get(Number: integer): TMWPageList;
begin
	if Number > PageList.Count then
  	Result := nil
  else
  	Result := TMWPageList(PageList[Number-1]);
end;

procedure TMWPages.NewPage;
begin
  inc(CurrentPage);
  PageList.Add(TMWPageList.Create);
end;

procedure TMWPages.ClearPage;
begin
	TMWPageList(PageList[CurrentPage-1]).Clear;
end;

procedure TMWPages.StoreFColor(iColor: TColor);
begin
	Add(TMWFColor.Create(iColor));
end;

procedure TMWPages.StoreBColor(iColor: TColor);
begin
	Add(TMWBColor.Create(iColor));
end;

procedure TMWPages.StoreBStyle(bStyle: TBrushStyle);
begin
	Add(TMWBrushStyle.Create(bStyle));
end;

procedure TMWPages.StorePColor(iColor: TColor);
begin
	Add(TMWPColor.Create(iColor));
end;

procedure TMWPages.StorePStyle(Style: TPenStyle);
begin
	Add(TMWPStyle.Create(Style));
end;

procedure TMWPages.StorePMode(Mode: TPenMode);
begin
	Add(TMWPMode.Create(Mode));
end;

procedure TMWPages.StoreColumn(Number: word; Position,Length: double);
begin
	Add(TMWColumn.Create(Number,Position,Length));
end;

procedure TMWPages.StoreColRight(col: integer; y: double; Text: string);
begin
	Add(TMWColRight.Create(col,y,Text));
end;

procedure TMWPages.StoreWriteLineRight(y: double; Text: string);
begin
	Add(TMWWriteRight.Create(y,Text));
end;

procedure TMWPages.StoreLine(x,y,x1,y1: double;Width: word);
begin
	Add(TMWLine.Create(x,y,x1,y1,Width));
end;

procedure TMWPages.StoreGeneral(Command: CommandSet);
begin
	if Command = commNewPage then
  	NewPage
  else
		Add(TMWPrintCommand.Create(Command));
end;

procedure TMWPages.StoreGraphic(x,y,h,w: double;Bitmap: TImage);
begin
	Add(TMWGraphic.Create(x,y,h,w,BitMap,iBitmap));
end;

procedure TMWPages.StoreDetailArea(x,x1: double);
begin
	Add(TMWDetail.Create(x,x1));
end;

procedure TMWPages.StoreFontChange(fFont: TFont);
begin
	Add(TMWFont.Create(fFont));
end;

procedure TMWPages.StoreFooterDim(x,y,x1,y1: double;Boxed: boolean;Width: word;Shading: TColor);
begin
	Add(TMWFooterDim.Create(x,y,x1,y1,Boxed,Width,Shading));
end;

procedure TMWPages.StoreFooterInf(Line: integer;y: double;Text: string;Alignment: word;
    													FontName: string;FontSize: word;FontStyle: TFontStyles;
                              FontColor: TColor);
begin
	Add(TMWFooterInf.Create(Line,y,Text,Alignment,FontName,FontSize,FontStyle,FontColor));
end;

procedure TMWPages.StoreHeaderDim(x,y,x1,y1: double;Boxed: boolean;Width: word;Shading: TColor);
begin
	Add(TMWHeaderDim.Create(x,y,x1,y1,Boxed,Width,Shading));
end;

procedure TMWPages.StoreHeaderInf(Line: integer;y: double;Text: string;Alignment: word;
    													FontName: string;FontSize: word;FontStyle: TFontStyles;
                              FontColor: TColor);
begin
	Add(TMWHeaderInf.Create(Line,y,Text,Alignment,FontName,FontSize,FontStyle,FontColor));
end;

procedure TMWPages.StoreLineWidth(Width: word);
begin
	Add(TMWLineWidth.Create(Width));
end;

procedure TMWPages.StoreMargins(t,b,l,r: double);
begin
	Add(TMWMargins.Create(t,b,l,r));
end;

procedure TMWPages.StoreOrient(Orient: TPrinterOrientation);
begin
	Add(TMWOrient.Create(Orient));
end;

procedure TMWPages.StorePageNumber(y: double;Text: string;Alignment: word;TotalPage: boolean;
    													FontName: string;FontSize: word;FontStyle: TFontStyles;
                              FontColor: TColor);
begin
	Add(TMWPageNumber.Create(y,Text,Alignment,TotalPage,FontName,FontSize,FontStyle,FontColor));
end;

procedure TMWPages.StoreTab(Inches: double);
begin
	Add(TMWTab.Create(Inches));
end;

procedure TMWPages.StoreSetY(y: double);
begin
	Add(TMWSetY.Create(y));
end;

procedure TMWPages.StoreText(x,y: double;Text: string;BrushColor: TColor);
begin
	Add(TMWText.Create(x,y,Text,BrushColor));
end;

procedure TMWPages.StoreMoveTo(x,y: double);
begin
	Add(TMWGraphicPoint.Create(x,y,commMoveTo));
end;

procedure TMWPages.StoreLineTo(x,y: double);
begin
	Add(TMWGraphicPoint.Create(x,y,commLineTo));
end;

procedure TMWPages.StoreEllipse(x1,y1,x2,y2: double);
begin
	Add(TMWEllipse.Create(x1,y1,x2,y2));
end;

procedure TMWPages.StoreFillRect(X1, Y1, X2, Y2: double);
begin
	Add(TMWFillRect.Create(X1, Y1, X2, Y2));
end;

procedure TMWPages.StoreFloodFill(x1,y1: double;iColor: TColor;iFillStyle: TFillStyle);
begin
	Add(TMWFloodFill.Create(x1,y1,iColor,iFillStyle));
end;

procedure TMWPages.StoreFrameRect(X1, Y1, X2, Y2: double);
begin
	Add(TMWFrameRect.Create(X1,Y1,X2,Y2));
end;

procedure TMWPages.StoreArc(x1,y1,x2,y2,x3,y3,x4,y4: double);
begin
	Add(TMWPieArc.Create(x1,y1,x2,y2,x3,y3,x4,y4,commArc));
end;

procedure TMWPages.StorePie(x1,y1,x2,y2,x3,y3,x4,y4: double);
begin
	Add(TMWPieArc.Create(x1,y1,x2,y2,x3,y3,x4,y4,commPie));
end;

procedure TMWPages.StorePolyLine(iPoints: array of double);
begin
	Add(TMWPolygon.Create(iPoints,commPolyLine));
end;

procedure TMWPages.StorePolygon(iPoints: array of double);
begin
	Add(TMWPolygon.Create(iPoints,commPolygon));
end;

procedure TMWPages.StoreMeasure(Meas: integer);
begin
	Add(TMWMeasure.Create(Meas));
end;

procedure TMWPages.StoreFontAngle(Angle: integer);
begin
	Add(TMWFontAngle.Create(Angle));
end;

procedure TMWPages.StoreTransparent(Flag: boolean);
begin
	Add(TMWTransparent.Create(Flag));
end;

procedure TMWPages.StoreIndent(x: double);
begin
	Add(TMWIndent.Create(x));
end;

function TMWPages.GetCount: integer;
begin
	result := PageList.Count;
end;

procedure TMWPages.ClearAll;
begin
  while PageList.Count > 0 do
  begin
  	TMWPageList(PageList[PageList.Count - 1]).Destroy;
    PageList.Delete(PageList.Count - 1);
  end;
  CurrentPage := 0;
  FirstPage := 0;
  LastPage := 0;
end;

function TMWPages.CountCommands: integer;
var
	x,
	TotalCommands: integer;

begin
	TotalCommands := 0;
	for x := FromPage to ToPage do
  	inc(TotalCommands,TMWPageList(PageList[x]).Count);
  Result := TotalCommands;
end;

constructor TMWPageList.Create;
begin
	Items := TList.Create;
end;

destructor TMWPageList.Destroy;
var
	x: integer;

begin
	for x := 0 to Items.Count-1 do
  	TMWPrintCommand(Items[x]).Free;
  Items.Free;
  inherited Destroy;
end;

procedure TMWPageList.Clear;
var
	x: integer;

begin
	for x := Items.Count-1 downto 0 do
  begin
  	TMWPrintCommand(Items[x]).Free;
    Items.Delete(x);
  end;
end;

procedure TMWPageList.Add(PrintCommand: TMWPrintCommand);
begin
	Items.Add(PrintCommand);
end;

function TMWPageList.Get(Number: integer): TMWPrintCommand;
begin
	if Number > Items.Count then
  	result := nil
  else
  	result := TMWPrintCommand(Items[Number-1]);
end;

function TMWPageList.GetCount: integer;
begin
	result := Items.Count;
end;

constructor TMWPrintCommand.Create(commCommand: CommandSet);
begin
	Command := commCommand;
end;

destructor TMWPrintCommand.Destroy;
begin
	inherited Destroy;
end;

constructor TMWLine.Create(x,y,x1,y1: double;LineWidth: word);
begin
	inherited Create(commLine);
  xTop := x;
  yTop := y;
  xBottom := x1;
  yBottom := y1;
  lWidth := LineWidth;
end;

destructor TMWLine.Destroy;
begin
	inherited Destroy;
end;

constructor TMWGraphic.Create(x,y,x1,y1: double;Bitmap: TImage;OfType: integer);
begin
	inherited Create(commGraphic);
  try
  xTop := x;
  yTop := y;
  xHeight := x1;
  yWidth := y1;
  image := TImage.Create(nil);
  if image = nil then
  	raise Exception.Create('Not enough memory for graphic.');
 	image.AutoSize := BitMap.AutoSize;
 	image.Stretch := BitMap.Stretch;
 	image.Height := BitMap.Height;
 	image.Width := BitMap.Width;
  if Bitmap.Picture.Graphic.ClassName = 'TBitmap' then
  begin
  	image.Picture.Bitmap := TBitmap.Create;
  end
  else if Bitmap.Picture.Graphic.ClassName = 'TIcon' then
  	image.Picture.Icon := TIcon.Create
  else exit;
  image.Picture.Graphic.Assign(BitMap.Picture.Graphic);
  iType := OfType;
  except
  	on e: exception do
    	showmessage('Error in TMWGrphic: ' + e.message);
  end;
end;

destructor TMWGraphic.Destroy;
begin
  image.Destroy;
	inherited Destroy;
end;

constructor TMWDetail.Create(x,y: double);
begin
	inherited Create(commDetailArea);
  xTop := x;
  xBottom := y;
end;

destructor TMWDetail.Destroy;
begin
	inherited Destroy;
end;

constructor TMWFont.Create(pFont: TFont);
begin
	inherited Create(commFont);
  fFont := TFont.Create;
  fFont.Assign(pFont);
end;

destructor TMWFont.Destroy;
begin
	fFont.Free;
	inherited Destroy;
end;

function TMWFont.GetFontName: string;
begin
	result := fFont.Name;
end;

function TMWFont.GetFontSize: integer;
begin
	result := fFont.Size;
end;

function TMWFont.GetFontStyle: TFontStyles;
begin
	result := fFont.Style;
end;

function TMWFont.GetFontColor: TColor;
begin
	result := fFont.Color;
end;

constructor TMWFooterDim.Create(x,y,x1,y1: double;Boxed: boolean;LineWidth:word; Shading: TColor);
begin
	inherited Create(commFooterDim);
  xTop := x;
  yTop := y;
  xBottom := x1;
  yBottom := y1;
  isBox := Boxed;
  lWidth := LineWidth;
  shade := Shading;
end;

destructor TMWFooterDim.Destroy;
begin
	inherited Destroy;
end;

constructor TMWFooterInf.Create(Line: integer;y: double;Text: string;Alignment: word;
  									FontName: string;Size: word;Style: TFontStyles; Color: TColor);
begin
	inherited Create(commFooterInf);
  iLine := Line;
  yBottom := y;
  sText := Text;
  wAlign := Alignment;
  fFont := TFont.Create;
  fFont.Name := FontName;
  fFont.Size := Size;
  fFont.Style := Style;
  fFont.Color := Color;
end;

destructor TMWFooterInf.Destroy;
begin
	fFont.Free;
	inherited Destroy;
end;

function TMWFooterInf.GetFontName: string;
begin
	result := fFont.Name;
end;

function TMWFooterInf.GetFontSize: integer;
begin
	result := fFont.Size;
end;

function TMWFooterInf.GetFontStyle: TFontStyles;
begin
	result := fFont.Style;
end;

function TMWFooterInf.GetFontColor: TColor;
begin
	result := fFont.Color;
end;

constructor TMWHeaderDim.Create(x,y,x1,y1: double;Boxed: boolean;LineWidth: word; Shading: TColor);
begin
	inherited Create(commHeaderDim);
  xTop := x;
  yTop := y;
  xBottom := x1;
  yBottom := y1;
  isBox := Boxed;
  lWidth := LineWidth;
  shade := Shading;
end;

destructor TMWHeaderDim.Destroy;
begin
	inherited Destroy;
end;

constructor TMWHeaderInf.Create(Line: integer;y: double;Text: string;Alignment: word;
  									FontName: string;Size: word;Style: TFontStyles; Color: TColor);
begin
	inherited Create(commHeaderInf);
  iLine := Line;
  yBottom := y;
  sText := Text;
  wAlign := Alignment;
  fFont := TFont.Create;
  fFont.Name := FontName;
  fFont.Size := Size;
  fFont.Style := Style;
  fFont.Color := Color;
end;

destructor TMWHeaderInf.Destroy;
begin
	fFont.Free;
	inherited Destroy;
end;

function TMWHeaderInf.GetFontName: string;
begin
	result := fFont.Name;
end;

function TMWHeaderInf.GetFontSize: integer;
begin
	result := fFont.Size;
end;

function TMWHeaderInf.GetFontStyle: TFontStyles;
begin
	result := fFont.Style;
end;

function TMWHeaderInf.GetFontColor: TColor;
begin
	result := fFont.Color;
end;

constructor TMWLineWidth.Create(LineWidth: word);
begin
	inherited Create(commLineWidth);
  lWidth := LineWidth;
end;

destructor TMWLineWidth.Destroy;
begin
	inherited Destroy;
end;

constructor TMWMargins.Create(x,y,x1,y1: double);
begin
	inherited Create(commMargins);
  xTop := x;
  yTop := y;
  xBottom := x1;
  yBottom := y1;
end;

destructor TMWMargins.Destroy;
begin
	inherited Destroy;
end;

constructor TMWOrient.Create(Orientation: TPrinterOrientation);
begin
	inherited Create(commOrient);
  pOrient := Orientation;
end;

destructor TMWOrient.Destroy;
begin
	inherited Destroy;
end;

constructor TMWPageNumber.Create(y: double;Text: string;Alignment: word;PageTotal: boolean;
																	FontName: string;Size: word;Style:TFontStyles; Color: TColor);
begin
	inherited Create(commPageNumber);
  yBottom := y;
  sText := Text;
  wAlign := Alignment;
  fFont := TFont.Create;
  fFont.Name := FontName;
  fFont.Size := Size;
  fFont.Style := Style;
  fFont.Color := Color;
  DoTotal := PageTotal;
end;

destructor TMWPageNumber.Destroy;
begin
	fFont.Free;
	inherited Destroy;
end;

function TMWPageNumber.GetFontName: string;
begin
	result := fFont.Name;
end;

function TMWPageNumber.GetFontSize: integer;
begin
	result := fFont.Size;
end;

function TMWPageNumber.GetFontStyle: TFontStyles;
begin
	result := fFont.Style;
end;

function TMWPageNumber.GetFontColor: TColor;
begin
	result := fFont.Color;
end;

constructor TMWTab.Create(Tab: double);
begin
	inherited Create(commTab);
  sTab := Tab;
end;

destructor TMWTab.Destroy;
begin
	inherited Destroy;
end;

constructor TMWIndent.Create(Indent: double);
begin
	inherited Create(commIndent);
  sIndent := Indent;
end;

destructor TMWIndent.Destroy;
begin
	inherited Destroy;
end;

constructor TMWSetY.Create(y: double);
begin
	inherited Create(commSetY);
  yBottom := y;
end;

destructor TMWSetY.Destroy;
begin
	inherited Destroy;
end;

constructor TMWFColor.Create(iC: TColor);
begin
	inherited Create(commFColor);
  iColor := iC;
end;

destructor TMWFColor.Destroy;
begin
	inherited Destroy;
end;

constructor TMWBColor.Create(iC: TColor);
begin
	inherited Create(commBColor);
  iColor := iC;
end;

destructor TMWBColor.Destroy;
begin
	inherited Destroy;
end;

constructor TMWPColor.Create(iC: TColor);
begin
	inherited Create(commPColor);
  iColor := iC;
end;

destructor TMWPColor.Destroy;
begin
	inherited Destroy;
end;

constructor TMWPStyle.Create(Style: TPenStyle);
begin
	inherited Create(commPStyle);
  penStyle := Style;
end;

destructor TMWPStyle.Destroy;
begin
	inherited Destroy;
end;

constructor TMWPMode.Create(Mode: TPenMode);
begin
	inherited Create(commPMode);
  penMode := Mode;
end;

destructor TMWPMode.Destroy;
begin
	inherited Destroy;
end;

constructor TMWPWidth.Create(iWidth: word);
begin
	inherited Create(commLineWidth);
  lWidth := iWidth;
end;

destructor TMWPWidth.Destroy;
begin
	inherited Destroy;
end;

constructor TMWText.Create(x,y: double;Text: string;BrushColor: TColor);
begin
	inherited Create(commText);
  xTop := x;
  yTop := y;
  sText := Text;
  bColor := BrushColor;
end;

destructor TMWText.Destroy;
begin
	inherited Destroy;
end;

constructor TMWColumn.Create(Number: word;XPosition,Length: double);
begin
	inherited Create(commColumn);
  Numb := Number;
  sPosition := XPosition;
  sLength := Length;
end;

destructor TMWColumn.Destroy;
begin
	inherited Destroy;
end;

constructor TMWColRight.Create(col: integer; y: double; s: string);
begin
	inherited Create(commColRight);
  Column := col;
  yTop := y;
  sText := s;
end;

destructor TMWColRight.Destroy;
begin
	inherited Destroy;
end;

constructor TMWWriteRight.Create(y: double; s: string);
begin
	inherited Create(commWriteRight);
  yTop := y;
  sText := s;
end;

destructor TMWWriteRight.Destroy;
begin
	inherited Destroy;
end;

constructor TMWMeasure.Create(Meas: integer);
begin
	inherited Create(commMeasure);
	Measure := Meas;
end;

destructor TMWMeasure.Destroy;
begin
	inherited Destroy;
end;

constructor TMWGraphicPoint.Create(x,y: double;gType: CommandSet);
begin
	inherited Create(gType);
	lPoint.X := x;
  lPoint.Y := y;
end;

destructor TMWGraphicPoint.Destroy;
begin
  inherited Destroy;
end;

function TMWGraphicPoint.GetX1: double;
begin
	result := lPoint.X;
end;

function TMWGraphicPoint.GetY1: double;
begin
	result := lPoint.Y;
end;

constructor TMWEllipse.Create(x1,y1,x2,y2: double);
begin
	inherited Create(commEllipse);
  Point1.X := x1; Point1.Y := y1;
  Point2.X := x2; Point2.Y := y2;
end;

destructor TMWEllipse.Destroy;
begin
  inherited Destroy;
end;

function TMWEllipse.GetX1: double;
begin
	result := Point1.X;
end;

function TMWEllipse.GetX2: double;
begin
	result := Point2.X;
end;

function TMWEllipse.GetY1: double;
begin
	result := Point1.Y;
end;

function TMWEllipse.GetY2: double;
begin
	result := Point2.Y;
end;

constructor TMWBrushStyle.Create(bStyle: TBrushStyle);
begin
	inherited Create(commBrushStyle);
  fStyle := bStyle;
end;

destructor TMWBrushStyle.Destroy;
begin
	inherited Destroy;
end;

constructor TMWFillRect.Create(X1,Y1, X2, Y2: double);
begin
	inherited Create(commFillRect);
  Point1.X := X1;
  Point1.Y := Y1;
  Point2.X := X2;
  Point2.Y := Y2;
end;

destructor TMWFillRect.Destroy;
begin
	inherited Destroy;
end;

constructor TMWFloodFill.Create(x1,y1: double;iColor: TColor;iFillStyle: TFillStyle);
begin
	inherited Create(commFloodFill);
  lX := x1;
  lY := y1;
  lColor := iColor;
  lFill := iFillStyle;
end;

destructor TMWFloodFill.Destroy;
begin
	inherited Destroy;
end;

constructor TMWFontAngle.Create(Ang: integer);
begin
	inherited Create(commFontAngle);
	Angle := Ang;
end;

destructor TMWFontAngle.Destroy;
begin
	inherited Destroy;
end;

constructor TMWFrameRect.Create(X1, Y1, X2, Y2: double);
begin
	inherited Create(commFrameRect);
  Point1.X := X1;
  Point1.Y := Y1;
  Point2.X := X2;
  Point2.Y := Y2;
end;

destructor TMWFrameRect.Destroy;
begin
	inherited Destroy;
end;

constructor TMWPieArc.Create(x1,y1,x2,y2,x3,y3,x4,y4: double;gType: CommandSet);
begin
	inherited Create(gType);
  Point1.X := x1; Point1.Y := y1;
  Point2.X := x2; Point2.Y := y2;
  Point3.X := x3; Point3.Y := y3;
  Point4.X := x4; Point4.Y := y4;
end;

destructor TMWPieArc.Destroy;
begin
  inherited Destroy;
end;

function TMWPieArc.GetX1: double;
begin
	result := Point1.X;
end;

function TMWPieArc.GetX2: double;
begin
	result := Point2.X;
end;

function TMWPieArc.GetX3: double;
begin
	result := Point3.X;
end;

function TMWPieArc.GetX4: double;
begin
	result := Point4.X;
end;

function TMWPieArc.GetY1: double;
begin
	result := Point1.Y;
end;

function TMWPieArc.GetY2: double;
begin
	result := Point2.Y;
end;

function TMWPieArc.GetY3: double;
begin
	result := Point3.Y;
end;

function TMWPieArc.GetY4: double;
begin
	result := Point4.Y;
end;

constructor TMWPolygon.Create(iPoints: array of double;gType: CommandSet);
var
	x: integer;

begin
	inherited Create(gType);
  for x := low(iPoints) to high(iPoints) do
  	Points[x] := iPoints[x];
  Num := high(iPoints) + 1;
end;

destructor TMWPolygon.Destroy;
begin
	inherited Destroy;
end;

constructor TMWTransparent.Create(Flag: boolean);
begin
	inherited Create(commTransparent);
  OnOff := Flag;
end;

destructor TMWTransparent.Destroy;
begin
	inherited Destroy;
end;

{ Preview Form declarations.....}

procedure TPreviewForm.Abort;
begin
 	CurrentPage := 0;
	PPrn.Pages.TotalPages := 0;
 	ClearDisplayCanvas;
end;

procedure TPreviewForm.ClearDisplayCanvas;
{ Procedure to clean off the preview canvas such as when changing pages.}
var
  cTemp: TColor;

begin
  cTemp := NewImage.Canvas.Brush.Color;
  NewImage.Canvas.Brush.Color := clWhite;
  NewImage.Canvas.FillRect(rect(0,0,NewImage.Width,NewImage.Height));
  NewImage.Canvas.Brush.Color := cTemp;
  if (PreviewPane.Width > NewImage.Width) then
  	NewImage.Left := ((PreviewPane.Width - NewImage.Width) div 2)
  else
  	NewImage.Left := 0;
end;

procedure TPreviewForm.CopyCurrentCanvas;
{This procedure sets the current printing canvas to the preview canvas and
 calls the procedure to play out the page commands.}
begin
	try
  	ClearDisplayCanvas;
  	PPrn.SetPrnPrinter(NewImage);
  	PPrn.PrintPage(PPrn.Pages.Get(CurrentPage),CurrentPage);
  except
  	ShowMessage('There was an error displaying the page.');
    raise;
  end;
end;

procedure TPreviewForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  try
  	NewImage.Free;
  finally
		Action := caFree;
    PreviewForm := nil;
  end;
end;

procedure TPreviewForm.FormCreate(Sender: TObject);
begin
  CurrentPage := 1;
	CanvasOrient := poPortrait;
	NewImage := TImage.Create(Self);
  NewImage.Name := 'DisplayPage';
  NewImage.Parent := PreviewPane;
  NewImage.Top := 10;
  NewImage.Left := 10;
  NewImage.Height := 2000;
  NewImage.Width := 2000;
  NormalPixelsPerInch := NewImage.Canvas.Font.PixelsPerInch;
//	NormalPixelsPerInch := 96;
  NewImage.Visible := true;
end;

procedure TPreviewForm.FormShow(Sender: TObject);
begin
  ZoomFactor.ItemIndex := StartPercent;
	CurrentPage := 1;
  PgNumb.Text := '1';
  LastPage.Hint := LoadStr(LASTPAGEHINT) + ' (' + IntToStr(PPrn.Pages.Count) + ')';
  ZoomFactorChange(ZoomFactor);
  SetPageButtons;
  Caption := PPrn.Title + ' [' + IntToStr(PPrn.Pages.Count) + ' pages]';
  PostMessage(Handle, WM_SHOWWINDOW, 0, 0);
end;

function TPreviewForm.GetCurrentPage: TImage;
{ Function to return instance of the preview canvas. Originally, I was working
 with multiple images, one for each page, but this proved to be much more costly.
 That's when I decided to go with storing the print commands. I left this function
 in just in case there is a need for it later. Besides, the PrintDrv module
 already uses it and so it was just easier to leave it.}
begin
	try
		result := NewImage;
  except
  	ShowMessage('Error finding preview image.');
    raise;
  end;
end;

function TPreviewForm.GetPageNumber: integer;
{ Returns the current page number.}
begin
	Result := CurrentPage;
end;

procedure TPreviewForm.SetPreviewPrn(Prn: TObject);
{This procedure allows the PrintDrv unit to pass the current TMWPrintObject instance
 in order for the preview module to work with it.}
begin
	PPrn := TMWPrintObject(Prn);
end;

procedure TPreviewForm.ZoomFactorChange(Sender: TObject);
{This procedure adjusts the size of the preview canvas depending on the
 scale value selected.}
var
	Scalefactor: double;
  x: integer;

begin
	x := NormalPixelsPerInch;
	if LargeFontsOn then
  	x := Round( x / 1.25 );
	Scalefactor := PPrn.Pages.ScaleAmount[ZoomFactor.ItemIndex] / 100;
	NewImage.Hide;
  case CanvasOrient of
  	poPortrait:
    	begin
  			NewImage.Width := round(PPrn.Pages.tPageWidth * x * Scalefactor);
  			NewImage.Height := round(PPrn.Pages.tPageHeight * x * Scalefactor);
      end;
    poLandscape:
    	begin
  			NewImage.Width := round(PPrn.Pages.tPageHeight * x * Scalefactor);
  			NewImage.Height := round(PPrn.Pages.tPageWidth * x * Scalefactor);
      end;
  end;
  NewImage.Canvas.Font.PixelsPerInch := trunc(NormalPixelsPerInch * Scalefactor);
  PPrn.SetScale(Scalefactor);
  if CurrentPage = 1 then
  	CopyCurrentCanvas
  else
  begin
    PrevPageClick(PrevPage);
    NextPageClick(NextPage);
  end;
  NewImage.show;
  FormResize(self);
end;

procedure TPreviewForm.PrintBtnClick(Sender: TObject);
{Print from the preview form when user click Print button.}
var
	CurrentScale: double;

begin
	try
  	Screen.Cursor := crHourGlass;
  	CurrentScale := PPrn.GetScale;
  	PPrn.SetScale(1.0);
		PPrn.PrintFromPreview;
  	PPrn.SetScale(CurrentScale);
  finally
  	Screen.Cursor := crDefault;
  end;
end;

procedure TPreviewForm.SetOrient(Orient: TPrinterOrientation);
{ Set the orientation of the preview canvas.}
begin
	CanvasOrient := Orient;
end;

{Since the preview canvas must be set to maximum height and width when created,
 the standard Width and Height properties always return the maximum amount so
 they had to be circumvented with the following two functions:
 GetHeight and GetWidth}
function TPreviewForm.GetHeight: integer;
var
	x : integer;

begin
	result := 0; { just here to eliminate warning message when compiling....}
	try
  	x := NormalPixelsPerInch;
  	if LargeFontsOn then
    	x := Round(x / 1.25);
  	if CanvasOrient = poLandscape then
			Result := Trunc(PPrn.Pages.tPageWidth * x)
  	else
  		Result := Trunc(PPrn.Pages.tPageHeight * x);
 	except
 		Showmessage('An error ocurred in the TPreviewForm.GetWidth function.');
  end;
end;

function TPreviewForm.GetWidth: integer;
var
	x : integer;

begin
	result := 0; { just here to eliminate warning message when compiling....}
	try
  	x := NormalPixelsPerInch;
  	if LargeFontsOn then
    	x := Round(x / 1.25);
  	if CanvasOrient = poLandscape then
			Result := Trunc(PPrn.Pages.tPageHeight * x)
  	else
  		Result := Trunc(PPrn.Pages.tPageWidth * x);
	except
  	Showmessage('An error ocurred in the TPreviewForm.GetWidth function.');
  end;
end;

function TMWPages.SetPrintOptions: boolean;
{This function displays the print dialog box after setting the pages available.
 If the users cancels the dialog box, the function returns false, otherwise it
 sets the values for printing a range of pages which default to all pages.}
var
	MyHandle: THandle;
  MyDevMode: pDevMode;
  MyDevice,
  MyDriver,
  MyPort: array [0..255] of char;
begin
	Result := true;
	with PreviewForm.PrintDialog1 do
  begin
  	Options := [poPageNums];
  	MinPage := 1;
    FromPage := 1;
    ToPage := Count;
    MaxPage := Count;
    Copies := PPrn.Copies;
		if Not Execute then
    begin
  		Result := false;
      exit;
    end;
  	FirstPage := FromPage;
    LastPage := ToPage;
  end;
	Printer.GetPrinter(MyDevice,MyDriver,MyPort,MyHandle);
  MyDevMode := GlobalLock(MyHandle);
  try
  	if MyDevMode^.dmOrientation = DMORIENT_PORTRAIT then
  		PPrn.Orientation := poPortrait
  	else
  		PPrn.Orientation := poLandscape;
		PPrn.PaperSize := PaperSizes(MyDevMode^.dmPaperSize - 1);
    PPrn.Copies := MyDevMode^.dmCopies;
  finally
  	GlobalUnlock(MyHandle);
  end;
end;

procedure TPreviewForm.FormResize(Sender: TObject);
var
	x: integer;
  oldX,oldY: integer;

begin
	x := 30;
	if Width < 480 then
  	Width := 480;
  oldY := PreviewPane.VertScrollBar.Position;
  oldX := PreviewPane.HorzScrollBar.Position;
  PreviewPane.VertScrollBar.Position := 0;
  PreviewPane.HorzScrollBar.Position := 0;
	PreviewPane.VertScrollBar.Range := NewImage.Height + x;
	PreviewPane.HorzScrollBar.Range := NewImage.Width + x;
  if (PreviewPane.Width > NewImage.Width) then
  	NewImage.Left := ((PreviewPane.Width - NewImage.Width) div 2)
  else
  	NewImage.Left := 5;
  PreviewPane.VertScrollBar.Position := oldY;
  PreviewPane.HorzScrollBar.Position := oldX;
end;

procedure TPreviewForm.PgNumbKeyPress(Sender: TObject; var Key: Char);
begin
	if not (Key in ['0'..'9']) then
  	Key := chr(0);
end;

procedure TPreviewForm.PgNumbExit(Sender: TObject);
var
	xPage: integer;

begin
	try
		with Sender as TEdit do
  	begin
			if Text = '' then
  			Text := '1';
  		xPage := StrToInt(Text);
      if xPage > PPrn.Pages.TotalPages then
      	xPage := PPrn.Pages.TotalPages
      else if xPage < 1 then
      	xPage := 1;
      PgNumb.Text := IntToStr(xPage);
  		CurrentPage := xPage;
  		CopyCurrentCanvas;
      FormResize(self);
    end;
  except
  	on E: Exception do
  		ShowMessage('Error in page number.' + chr(10) + E.Message);
  end;
end;

procedure TPreviewForm.SetPageButtons;
var
	x: integer;

begin
  x := StrToInt(PgNumb.Text);
  FirstPage.Enabled := (x > 1);
  PrevPage.Enabled := (x > 1);
  NextPage.Enabled := (x < PPrn.Pages.Count);
  LastPage.Enabled := (x < PPrn.Pages.Count);
end;

procedure TPreviewForm.FirstPageClick(Sender: TObject);
begin
	PgNumb.Text := '1';
  PgNumbExit(PgNumb);
  SetPageButtons;
end;

procedure TPreviewForm.LastPageClick(Sender: TObject);
begin
	PgNumb.Text := IntToStr(PPrn.Pages.Count);
  PgNumbExit(PgNumb);
  SetPageButtons;
end;

procedure TPreviewForm.PrevPageClick(Sender: TObject);
begin
	if StrToInt(PgNumb.Text) > 1 then
  begin
  	PgNumb.Text := IntToStr(StrToInt(PgNumb.Text)-1);
    PgNumbExit(PgNumb);
  end;
  SetPageButtons;
end;

procedure TPreviewForm.NextPageClick(Sender: TObject);
begin
	if StrToInt(PgNumb.Text) < PPrn.Pages.Count then
  begin
  	PgNumb.Text := IntToStr(StrToInt(PgNumb.Text)+1);
    PgNumbExit(PgNumb);
  end;
  SetPageButtons;
end;

procedure TPreviewForm.PgNumbKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if Key = 13 then
  	postmessage(handle,WM_KEYDOWN,9,1);
end;

procedure TPreviewForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  cTemp,PenTemp: TColor;

begin
//if key = VK_DOWN then
// begin
//  cTemp := NewImage.Canvas.Brush.Color;
//  PenTemp:= NewImage.Canvas.Pen.Color;
////  NewImage.Canvas.Brush.Color := clRed;
//  NewImage.Canvas.Pen.Color := clRed;
////  NewImage.Canvas.FillRect(rect(10,10,NewImage.Width,NewImage.Height));
////  NewImage.Canvas.LineTo(100,100);
////  NewImage.Canvas.Polygon([Point(10,10),Point(30,10),
////        Point(130,30),Point(240,120)]);
//  NewImage.Canvas.Polyline([Point(40,100),Point(750,100)]);
//  NewImage.Canvas.Brush.Color := cTemp;
//  NewImage.Canvas.Pen.Color := PenTemp;
// end;
	case Key of
    VK_PRIOR:
    	PrevPage.Click;
    VK_NEXT:
    	NextPage.Click;
    VK_UP:
    	if PreviewPane.VertScrollBar.Position > 10 then
				PreviewPane.VertScrollBar.Position := PreviewPane.VertScrollBar.Position - 10
      else
      	PreviewPane.VertScrollBar.Position := 0;
    VK_DOWN:
    	if PreviewPane.VertScrollBar.Position <
      		(PreviewPane.VertScrollBar.Range - PreviewPane.Height) - 10 then
				PreviewPane.VertScrollBar.Position := PreviewPane.VertScrollBar.Position + 10
      else
      	PreviewPane.VertScrollBar.Position := (PreviewPane.VertScrollBar.Range - PreviewPane.Height);
    VK_ESCAPE:
    	CloseBtn.Click;
  end;
  if Key in [VK_PRIOR,VK_NEXT,VK_UP,VK_DOWN,VK_ESCAPE] then
  	Key := 0;
end;

procedure TPreviewForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
	case Key of
  	'-' :
    	begin
      	if ZoomFactor.ItemIndex > 0 then
        	ZoomFactor.ItemIndex := ZoomFactor.ItemIndex - 1;
        ZoomFactorChange(ZoomFactor);
      end;
  	'+' :
    	begin
      	if ZoomFactor.ItemIndex < ZoomFactor.Items.Count-1 then
        	ZoomFactor.ItemIndex := ZoomFactor.ItemIndex + 1;
        ZoomFactorChange(ZoomFactor);
      end;
  end;
end;

end.
