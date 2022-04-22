unit PrintDrv;
{
	Version 3.4
  Last Modified: 7/15/2000

	Created by: James "Woody" Woodard
  						2/24/99

  The origins of this component came from the Inprise site and contained most
  of the functionality. I don't remember who the author was but thank him for
  the insight and the main procedures for printing and calculating printer
  metrics. The rest of the implementation is my own and some of the original
  procedures were changed to reflect the addition of the preview mode.

	This component is used as a reporting tool when standard report generators
  don't allow you the flexibility needed for more complex printing. You can
  use this component to provide a more robust method of generating reports.
  Though the amount of work involved in creating a report requires more coding
  than using a report generator, the amount of control you have far outweighs
  the hassles, in my opinion.

  I built this component because I have written several programs that needed to
  be flexible in not only what was printed but where depending on certain criteria
  selectable by the user. Also, most report generators don't allow you to expand
  or contract sections unless you use grids, etc.

  The way this component works is this:
  	Initially, when you issue all of the print commands from start to finish, they
    are stored in an object called Pages. This stores all print commands in lists,
    one list per page. This list of pages and commands is then replayed either to
    the printer or to the preview screen. By capturing the commands this way, it is
    possible for the user to select a printing range of pages instead of the complete
    job if desired.

  Now there is built in support for printing to any TCanvas object. Assign the
  PrinterCanvas property a valid TCanvas object and you can print to it using
  almost all of the print commands. Some of them are not used for obvious reasons
  such as a NewPage.

  Also added is the ability to use either pixels, inches or millimeters for all commands.
  This allows you to structure your printing more to your standards without worrying
  about the conversions of units from one to the other.

}
interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Printers, PrintDr1{, PrintDr2}, ShellAPI,
  ComCtrls;

const
  HeaderLines = 10;             { Number of allowable header lines }
  FooterLines = 10;             { Number of allowable footer lines }
  Columns = 50;                 { Number of allowable columns }
  wtLeft = 0;      							{ Left justify constant }
  wtCenter = 1;                 { Center justify constant }
  wtRight = 2;                  { Right justify constant }
  wtDecimal = 3;                { Decimal align constant }
  wtIndent = 4;									{ Use indent for text }

  wtLeftX:double = -2.0;				{ Print from left margin }
  wtLastX:double = -1.0;        { Print at end of text last printed }
  wtThisY:double = -2.0;        { Print on same line }
  wtNextY:double = -1.0;        { Start printing on new line }
  wtVertical = 0;								{ Designates needing vertical calculation }
  wtHorizontal = 1;             { Designates needing horizontal calculation }
  mmConvert:double = 25.4;      { Conversion from/to inches and mm }
  wtMargins = 0;
  wtDetailArea = 1;
  wtHeaderArea = 2;
  wtFooterArea = 3;
  wtTopBottom = 0; 							{ gradient fill from top to bottom }
  wtBottomTop = 1;              { gradient fill from bottom to top }
  wtLeftRight = 2;              { gradient fill from left to right }
  wtRightLeft = 3;              { gradient fill from right to left }

type
	{ Preview size percentages. }
  Percentages = (P2_Sixty,P3_Seventy,P4_Eighty,P5_Ninety,P6_Full);
  { Set of measurement type available. }
	MeasureType = (mtInches, mtMM, mtPixels);
  { Set of styles that can be used }
  StyleTypes = (stTitle1, stTitle2, stTitle3, stColumnHeader, stDetail);

  { These should include most, if not all, of the various paper sizes used. }
  PaperSizes =
  	(PAPER_LETTER, PAPER_LETTERSMALL, PAPER_TABLOID, PAPER_LEDGER,
     PAPER_LEGAL, PAPER_STATEMENT, PAPER_EXECUTIVE, PAPER_A3,
     PAPER_A4, TBA1, PAPER_A5, PAPER_B4, PAPER_B5, PAPER_FOLIO, PAPER_QUARTO,
     PAPER_10X14, PAPER_11X17, PAPER_NOTE, PAPER_ENV_9, PAPER_ENV_10,
     PAPER_ENV_11, PAPER_ENV_12, PAPER_ENV_14, TBA2, TBA3, TBA4, PAPER_ENV_DL,
     PAPER_ENV_C3, PAPER_ENV_C4, PAPER_ENV_C5, PAPER_ENV_C6, PAPER_ENV_C65,
     PAPER_ENV_B4, PAPER_ENV_B5, PAPER_ENV_B6, PAPER_ENV_ITALY, PAPER_ENV_MONARCH,
     PAPER_ENV_PERSONAL);

  PrintQualities = (pqHIGH, pqMEDIUM, pqLOW, pqDRAFT);

  { This pallette structure is used in the bitmap printing routine. }
  PPalEntriesArray = ^TPalEntriesArray; {for palette re-construction}
  TPalEntriesArray = array[0..0] of TPaletteEntry;

  { The TMWPrintObject declaration. Most everything is published or protected
  	to allow for easier derivation. }
  TMWPrintObject = class(TComponent)
  private

  	CompVersion: string;
    PixelsPerInchVertical: integer;   { Number of pixels per inch
    																		along Y axis }
    PixelsPerInchHorizontal: integer; { Number of pixels per inch
                                        along X axis }
    TotalPageWidthPixels: integer;    { Full width of page in pixels
                                        includes gutters }
    TotalPageHeightPixels: integer;   { Full height of page in pixels
                                        includes gutters }
    TotalPageHeightInches: double;    { Height of page in inches }
    TotalPageWidthInches: double;     { Width of page in inches }
    GutterLeft: integer;              { Unprintable area on left }
    GutterRight: integer;             { Unprintable area on right }
    GutterTop: integer;               { Unprintable area on top }
    GutterBottom: integer;            { Unprintable area on bottom }
    LastYPosition: double;            { The Y position where the last
                                        write occurred }
    LastXPosition: double;
    AutoPaging: boolean;              { Are new pages automatically generated? }
    CurrentTab: double;               { The value of the current tab }
    CurrentIndent: double;						{ The value of the current indention amount }
    RotateFont: hFont; 								{ Added to allow rotated fonts }
    OriginalFont: hFont;              { To keep track of original font for restoring
    																		after rotating fonts are created and used }
    RotateAngle: integer;             { Text rotation angle }
    CurrentFonts: array [1..10] of TFontInformationRecord; { Stack to track font saves }
    CurrentYPosition: array [1..10] of double; { Stack to track vertical position saves}
    CurrentFontRecord: integer; { Current font index being stored or recalled }
    CurrentYRecord: integer; { Current vertical position index being stored or recalled }
    TextMetrics: TTextMetric; { for determining printer specific information }
    Header: Array[1..HeaderLines] of THeaderRecord; { Stores each header command }
    Footer: Array[1..FooterLines] of TFooterRecord; { Stores each footer command }
    ColumnInformation: Array[1..Columns] of TColumnInformationRecord; {Column information}
    PageNumber: TPageNumberRecord; { Current printing page }
    HeaderCoordinates: THeaderCoordinates; { Upper left to lower right coordinates of header }
    FooterCoordinates: TFooterCoordinates; { Upper left to lower right coordinates of footer }
		ThePrinter: TImage; {Used for current canvas during print preview mode}
    TheCanvas: TCanvas; {This is set to current drawing canvas}
    DryRun,	{used for counting total pages before actually printing report}
    PreviewMode: boolean; {Used to set internal preview mode to build pages}
    ActualPreview: boolean; {Used to control users choice of preview mode}
    ScaleByValue: double; {Used to scale the pixels per inch for scaling}
    UseProgress: boolean; {Shows progress bar if set to true}
//    TMWProgressBar: TPrintBarForm; {Progress bar form}
    DocumentTitle: string; {Title to show in print manager for current job}
    PageOrientation: TPrinterOrientation; {Keep track of orientation}
    ShowDialog: boolean; {True to allow print dialog box to show}
    ShowCancel: boolean; {True will show a cancel button while printing}
    PageFeeding: boolean; { To determine whether actual page feed
    											{ command is sent to printer }
    PageNumbering: boolean; {True if page numbering is desired}
    BarShowing: boolean; {In case we abort, need a way to know if progress
    											bar is showing or not to destroy it.}
    ProgressMax: word; {Sets the progress bar maximum}
    ProgressInc: word; {Sets the progress bar increment}
    PrintTransparent: boolean; {True to print transparent text for backgrounds}
    PrintingInternal: boolean; {Flag to control cancelling printing}
    FPageChange: TNotifyEvent; {Event for user to put any specific printing to
    														be done for every page.}
    FAPageChange: TNotifyEvent; {Event for user to put any specific printing to
    														be done for every page.}
    FLastPage,            		{Event called when last page completes printing.}
    FFirstPage,            		{Event called before first page starts printing.}
    FStartPrint,            	{Event called before printing starts.}
    FEndPrint: TNotifyEvent;	{Event called after printing stops.}
    FOnCancelPrint: TNotifyEvent; {Event to cancel printing during processing.}
    FPrintDone: TNotifyEvent; {Event to call after all cleanup is done.}
    PreviewPercent: Percentages; { Starting preview size }
    PaperDimension: PaperSizes; { Current paper size setting }
    PrintingOK: boolean; {Flag to determine if print object has been initialized
    											and the print job is not aborted.}
    ImageCanvas: TCanvas; {Use this to print to something other than a printer. This
    													allows you to print to an image canvas on a form, etc.}
    ImagePrinting: boolean; {Flag to tell whether we are going to print to a printer
    														 or a regular canvas for output.}
    IsColor: boolean; {used to determine if color printer is being used}
    IsPrinting: boolean; {used to test with IsColor so we don't change color if the
    	the printer we are using does not support it}
    OrigPaperSize,            {used to store the values of the printer before printing}
    OrigPaperOrient: integer; {so we can restore the printer back to original when done}
    Measure: MeasureType; {used to set either inches or millimeters to work with}
    BarFormColor: TColor; {used to set the background color of the progress bar form}
    BarTextColor: TColor; {used to set the color of the text of the progress bar form}
    fUseLargeFontAdjust: boolean; { Used to adjust for large font if desired }
    fProgressX, { Used to set the upper left coordinates of the progress box }
    fProgressY: integer;
		fCopies: integer;			{ number of copies to print }
    fProgressBar: TProgressBar; { This is assigned a TProgressBar of your choice }
    fProgressCaption: TControl; { This can either be assigned a TEdit or a TLabel }
		fColumnClipping: boolean; { Used to determine whether text is clipped on the
    														right hand side of a column if it extends to far }
    { Snaking column support was submitted by Elliot Shevin. My thanks to him
    	for his effort in helping make this component better. Snaking will allow
      you to use the column printing methods to print down one column and continue
      printing into the next one if the bottom of the page is encountered. This
      does not effect the column methods which print multiple columns, only those
      which deal with single column printing. Use the SnakeColumnsOn and
      SnakeColumnsOff methods to start and stop the snaking columns mode.
      Using equal width columns will produce the best output. }
    fSnakeColumns  : boolean; { determines whether in snaking mode }
    SnakeColumns : TStringList; { holds the columns to snake in }
    fSnakeCurrentColumn : integer; { current column number being printed in }
    fSnakeCurrentIndex: integer; { index into the SnakeColumns string list for which
    																column is currently being printed }
    fShowPercent: boolean; { this is used to display the progress bar percentage
    													behind the progress caption text if used }
    fCurrentCaption: string; { current progress caption text }
    fQuality: PrintQualities; { setting to control print quality such as for dot matrix }
    fUseQuality: boolean; { setting to control whether to use the PrintQualities setting }

    procedure VersionKill(s: string);
	protected
  	TopMargin: integer;               { Top margin in pixels }
    BottomMargin: integer;            { Bottom margin in pixels }
    LeftMargin: integer;              { Left margin in pixels }
    RightMargin: integer;             { Right margin in pixels }
    DetailTop: double;                { Inches from the top where the
                                        detail section starts }
    DetailBottom: double;             { Inches from the top where the
                                        detail section ends }
    { Occurs just before issuing a new/next page command }
    procedure OnPageChange; virtual;
    { Occurs just after issuing a new/next page command }
    procedure AfterPageChange; virtual;
    { Set preview or print mode }
    procedure SetPreviewMode(Mode: boolean);
    { Call ShowPreview to see the actual report on screen }
    procedure ShowPreview;
    { set whether to display page number with total pages (ex. 1 of 26) }
    procedure SetShowTotalPages(Mode: boolean);
    { Cleanup will reset the headers, footers, columns, etc. so there
    	is no lingering remnants the next time we print }
    procedure Cleanup;
    { returns current setting of show total pages }
    function GetShowTotalPages: boolean;
    { CalculateLineHeight returns the line height in pixels }
		function CalculateLineHeight: integer;
    { Picked off the Borland site for printing bitmaps }
		procedure BltTBitmapAsDib(DestDc : hdc;   {Handle of where to blt}
                          		x,       				{Bit at x}
                          		y,       				{Blt at y}
                          		Width,   				{Width to stretch}
                          		Height: integer;{Height to stretch}
                          		bm : TBitmap);  {the TBitmap to Blt}
//    procedure SetStyle(Style: TMWStyles);
//    procedure GetStyle(var Style: TMWStyles);

	public
  	{ Because of some problems, I have moved the Pages structure variable here.
    	I made it public in case anyone wants to write their own routines for handling
      it. By moving the variable here instead of having it global from the PrintDr1
      unit, I eliminated the conflict when multiple TMWPrintobjects are used such as in
      the demo program. }
    Pages: TMWPages;


  	{ Constructor/Destructor - self explanatory }
		constructor Create(AOwner: TComponent); override;{need to initialize some default values}
    destructor Destroy; override;

    { Start is used to initialize the printing object. It must be
    	called before setting any margins, headers, footers, etc. so
      that it can set up the component. Properties can be set at
      any time although some properties only take effect within the
      Start routine and are then subsequently ignored such as the
      paper size }
		function Start: boolean;
    { The normal way to stop the print job so that either the
    	preview is shown or the commands are sent to the printer }
    procedure Quit;
    { Abort should be called when you want to terminate a print
    	job prematurely. This is only available during your generation
      of the report, not when it is being sent to the printer. }
    procedure Abort;
    { CancelPrintJob will set the PrintingStatus flag to false to
    	let the print object know that the current print job is aborted }
		procedure CancelPrintJob;
    { ClearPageInfo will clear the current page commands that are stored.
    	This will allow you to start a page over in case of any errors or
      you just want to change something on the page. }
    procedure ClearPageInfo;
    { The following routine is designed to replace all of the other
    	conversion routines. By passing the from/to units, it will
      convert the value and return it. VertHoriz should be passed
      either wtVertical or wtHorizontal (0,1 respectively) }
    function ConvertMeasure(Value: double; mFrom, mTo: MeasureType;
    														VertHoriz: word): double;

    { The following are conversion routines. The names should be
    	enough to identify their purpose }
    function InchesToPixelsHorizontal( Inches: double ): integer;
    function InchesToPixelsVertical( Inches: double ): integer;
    function MMToPixelsHorizontal( MM: double ): integer;
    function MMToPixelsVertical( MM: double ): integer;
    function PixelsToInchesHorizontal( Pixels: double ): double;
    function PixelsToInchesVertical( Pixels: double ): double;
    function PixelsToMMHorizontal( Pixels: double ): double;
    function PixelsToMMVertical( Pixels: double ): double;
    function PixelsToMeasurementH( Pixels: double ): double;
    function PixelsToMeasurementV( Pixels: double ): double;
    function LinesToPixels( Line:integer ): integer;
    function MMToInches(mm: double): double;
    function InchesToMM(inches: double): double;

		{ The following routines are used for printing text. Remember that
    	the vertical coordinate for text is used as the uppermost
      measurement and text is printed down and to the right. }
    { WrapText is used internally to take a string and
    	wrap it in a given set of margins. The text is placed
      in a TStringList }
		procedure WrapText(Text: string; var theText: TStringList; X,Y: double);
    { WriteLine is the basic form for printing text. The Text will
    	be printed starting at horizontal X and vertical Y }
    procedure WriteLine( X:double; Y:double; Text:string );
    { The WriteLineRightToX, WriteLineCenterToX,WriteLineDecimal and
    	WriteLineColumnDecimal enable you to justify Text at
      the given location X, Y }
		procedure WriteLineRightToX(X,Y:double; Text:string );
		procedure WriteLineCenterToX(X,Y:double; Text:string );
    procedure WriteLineDecimal(X,Y: double; Text: string);
    { WriteLineAlign can be used to print the Text at Y using
    	either left, center of right justification based on the
      current margin settings }
    procedure WriteLineAlign( Y: double; Text: string; Align: word);
    { WriteLineRight and WriteLineCenter are replaced by the
    	WriteLineAlign method above but still here for compatibility }
    procedure WriteLineRight( Y:double; Text:string );
    procedure WriteLineCenter( Y:double; Text:string );
    { WriteLineWrap will print the Text starting at position Y and
    	word wrapping it withing the XL, XR margin given. KeepY and
      SamePage are used to determine whether the vertical position
      is restored after printing and whether the Text should be kept
      on the same page, respectively }
    procedure WriteLineWrap(XL,XR,Y: double; Text: string; KeepY,SamePage:boolean);

    { The following group of methods deal specifically with printing
    	columns of information }

		{ CreateColumn is used to create each column's starting
    	position and width. The maximum number of columns is
      defined by the Columns constant }
    procedure CreateColumn( Number:word; XPosition:double; Length:double );
    { WriteLineColumn will print the Text, left justified beginning
    	at the left of column ColumnNumber }
    procedure WriteLineColumn( ColumnNumber:word; Y:double; Text:string );
    { WriteLineColumnAlign is used to send a left, right or center
    	justification code to print the Text in column ColumnNumber }
    procedure WriteLineColumnAlign( ColumnNumber: word; Y: double; Text: string;
    														Align: word);
    { WriteLineColumnRight, WriteLineColumnCenter and WriteLineColumnDecimal
    	are replaced by WriteLineColumnAlign above }
    procedure WriteLineColumnRight( ColumnNumber:word; Y:double; Text:string );
    procedure WriteLineColumnCenter( ColumnNumber:word; Y:double; Text:string );
    procedure WriteLineColumnDecimal( ColumnNumber: word; X,Y: double; Text: string);
    { WriteLineColumnWrap is used to wrap text within a given column.
    	It also uses the KeepY and SamePage boolean flags like WriteLineWrap }
    procedure WriteLineColumnWrap(ColumnNumber:word; Y:double; Text:string;
    														KeepY,SamePage:boolean);
    { WriteLineColWrapJust will do the same thing as WriteLineColumnWrap
    	with the addition of being able to specify the alignment of Text.
      This routine will eventually eliminate the need for the previous one }
    procedure WriteLineColWrapJust(ColumnNumber:word; Y:double; Text:string;
    														KeepY,SamePage:boolean; Just: integer);
    { WriteLineColumnArray and WriteLineColumnArrayTest are used to
    	print a series of columnar information. The WriteLineColumnArray
      function returns the number of lines printed and the
      WriteLineColumnArrayText function returns true if all column
      text will fit on the current page }
    function WriteLineColumnArray(Y: double; Cols: array of variant;
    														Justif: array of variant;	Strings: array of variant;
                                KeepY, SamePage: boolean): integer;
    function WriteLineColumnArrayTest(Y: double; Cols: array of variant;
    														Justif: array of variant;	Strings: array of variant;
                                KeepY, SamePage: boolean): boolean;
    { TextColumnBox allows you to draw a box around the column given
    	the bounds specified. The Text is printed in the given column
      but this doesn't mean the box is limited to that column. You can
      actually define the box for anywhere on the page }
    procedure TextColumnBox( XTop,YTop,XBottom,YBottom:double; LineWidth:word;
    											 	 Shading:TColor; Text: string; Column: integer;
                             Alignment: word );
    { GetColumnLeft returns the start of the column in the current
    	measurement units }
    function GetColumnLeft(Number:Word): double;
    { GetColumnRight returns the rightmost horizontal position of
    	the column in the current measurement units }
    function GetColumnRight(Number:Word): double;
    { GetColumnWidth returns the width of the column in the
    	current measurement units }
    function GetColumnWidth(Number: Word): double;
    { GetColumnsPerLine will return the maximum number of columns
    	on the page each having a one character width }
    function  GetColumnsPerLine: integer;

    { The following are routines which deal with the progress bar
    	that may be displayed. There have been lots of discussion on
      this and so I have decided to eliminate the progress bar in
      future versions. However, I am going to transform these routines
      into generic methods which you can use to control your own
      progress bar. By assigning the ProgressBar to a TProgressBar,
      such as on a TStatusPanel or something, the TMWPrintObject will
      control it instead of creating it's own. At this time, if there
      is nothing assigned, it will create the standard progress bar.
      In the next version, I will remove the internal progress bar and
      so there will be no errors but nothing shown either. That should
      allow for an easier transistion. }
    { UpdateBar will set the progress bar value to X }
    procedure UpdateBar(x: integer);
    { IncBar will increment the progress bar by X amount }
    procedure IncBar(x: integer);
    { SetProgressIncrement allows you to specify the maximum
    	range for the progress bar being used }
    procedure SetProgressIncrement(x: integer);
    { Increment will use the default increment of the progress bar
    	for stepping }
    procedure Increment;
    { SetProgressMax will set the maximum value of the progress bar }
    procedure SetProgressMax(Max: integer);
    { SetProgressText will set the caption assign to ProgressCaption
    	which is a TCaption and then call SetTheProgressCaption }
    procedure SetProgressText(s: string);
    { SetTheProgressCaption is used to set the actual progress caption
    	text. This is done so that the added progress percent can be
      added if ShowProgressPercent is true }
    procedure SetTheProgressCaption;
    { SetProgressPosition is used to now set the position of the
    	internal progress bar. This method will be useless in the
      next version as being unnecessary }
    procedure SetProgressPosition(X,Y: integer);
    { ProgressBar can be assigned to your own TProgressBar to be used
    	for tracking printing progress. All positioning and incrementing
      is controlled by your code using the methods above }
    property ProgressBar: TProgressBar read fProgressBar write fProgressBar;
    { The ProgressCaption property allows you to set up a progress bar
    	and text for more control over visual feedback during report
      generation. At the moment, only TCaption and TEdits may be used
      but more choices may be added in the future }
		property ProgressCaption: TControl read fProgressCaption write fProgressCaption;

    { The following are the graphics routines that are available.
    	These routines allow you to print images and run-time
      created drawings using the standard-type Delphi drawing
      routines. }

    { SetLineWidth sets the pen line width for drawing }
    procedure SetLineWidth( Width:word );
    { GetLineWidth returns the current line width setting }
    function  GetLineWidth: word;
    { PrintGraphic allows you to place a bitmap within the
    	coordinates given, stretching the bitmap to fit }
    procedure PrintGraphic(X,Y,W,H: double;thePicture: TImage);
    { DrawLine draws a line from TopX,TopY to BottomX, BottomY with
    	a line width of LineWidth }
    procedure DrawLine( TopX,TopY,BottomX,BottomY:double; LineWidth:word );
    { DrawLine draws a box from TopX,TopY to BottomX, BottomY with
    	a line width of LineWidth }
    procedure DrawBox( XTop,YTop,XBottom,YBottom:double; LineWidth:word );
    { DrawTheBox is actually used internally to draw the box outline.
    	It is called by every other drawing routine which needs a box.
      That allows me to have one place to change or revise code. }
    procedure DrawTheBox( TopX,TopY,BottomX,BottomY:double; LineWidth:word );
    { DrawBoxShade draws a standard box and shades it with Shading }
    procedure DrawBoxShade( XTop,YTop,XBottom,YBottom:double; LineWidth:word;
    												 Shading:TColor );
    { The following are standard Delphi drawing commands so you can use the
    	help file for explanations }
		procedure Arc(X1,Y1,X2,Y2,X3,Y3,X4,Y4: double);
    procedure LineTo(X1,Y1: double);
    procedure MoveTo(X1,Y1: double);
    procedure Ellipse(X1,Y1,X2,Y2: double);
    procedure FillRect(X1, Y1, X2, Y2: double);
    procedure FloodFill(X,Y: double;Color: TColor;FillStyle: TFillStyle);
    procedure FrameRect(X1,Y1,X2,Y2: double);
		procedure Pie(X1,Y1,X2,Y2,X3,Y3,X4,Y4: double);
    procedure GradientFill(X1, Y1, X2, Y2: double; begColor, endColor: TColor;
    													Direction: integer);
    { The PolyLine and Polygon methods differ slightly from the
    	Delphi version because I found it easier to just pass an
      array of double values instead of casting pairs as TPoints
      into an array }
    procedure PolyLine(Points: array of double);
    procedure Polygon(Points: array of double);
    { The canvas methods are used when directing the print object
    	to your own canvas. You can use them to clear the canvas area
      before or during printing }
    procedure ClearCanvas(iColor: TColor);
    procedure ClearCanvasArea(XTop,YTop,XBottom,YBottom: integer; iColor: TColor);

    { SetPageMargins was implemented to correct the problem
    	with the SetMargins method because it uses a different
      parameter scheme. This was my fault for leaving it this
      way in the very beginnings of this component. It also
      changes the way you declare the margins. This method
      expects the measurements to be from the corresponding
      edge of the page. For example, the bottom margin would
      be set to 10.5" on a 8.5" X 11.0" letter size paper if you
      passed it 0.5 (half an inch) for a margin. The same method
      is used for the top, left and right margins }
    procedure SetPageMargins(XTop, YTop, XBottom, YBottom: double);
    { Use to set the page margins for printing. This is the
    	old style and should be avoided. Use the above SetPageMargins }
    procedure SetMargins( Top,Bottom,Left,Right:double );
    { Set the top and bottom range of the detail area. This is used
    	in the line calculations for instance, with the GetLinesLeft funxtion }
    procedure SetDetailTopBottom( Top: double; Bottom: double );
    { SetHeaderDim is used to set the actual header dimensions including
    	whether to draw a box around the area and also the shade color. }
    procedure SetHeaderDim( XTop,YTop,XBottom,YBottom:double; Boxed: boolean;
    															 LineWidth:word; Shading:TColor );
    { SetFooterDim is used to set the actual footer dimensions including
    	whether to draw a box around the area and also the shade color. }
    procedure SetFooterDim( XTop,YTop,XBottom,YBottom:double; Boxed: boolean;
    															 LineWidth:word; Shading:TColor );
    { The SetHeaderInfo, SetFooterInfo and SetPageNumberInfo allow you
    	to set up the corresponding sections. For headers and footers, use
      the Line parameter to specify which header/footer line is being
      set. I am looking into allowing macro substition to a limited
      degree within these so suggestions are welcome along those lines }
    procedure SetHeaderInfo( Line:integer; YPosition: double;Text:string;
    												 Alignment:word; Font: TFont );
    procedure SetFooterInfo( Line:integer; YPosition: double; Text:string;
                             Alignment:word; Font: TFont );
    procedure SetPageNumberInfo( YPosition:double; Text:string;
                   						 	 Alignment:word; IncludeTotal: boolean;
                                 Font:TFont );
    { You can force the header, footer and page numbering lines to
    	print by calling these methods. They are called internally when
      each page is complete as well }
    procedure WriteHeader;
    procedure WriteFooter;
    procedure WritePageNumber;

    { You can use the GetScale and SetScale to adjust the printing scale
    	when printing to a canvas, otherwise, it is used internally for the
      preview form }
    function GetScale: double;
    procedure SetScale(ScaleFactor: double);

		{ The SetTab method will be phased out as I add in support for
    	multiple tab positions and alignment. As it is now, it allows
      you to set an offset that is added to the position of the printed
      text }
    procedure SetTab( Inches:double );

    { The following are miscellaneous methods which should be self-
    	explanatory based on their names. }
		procedure SetFontInfo( fFont: TFont );
    procedure SetIndent( Indent: double);
    procedure GetPixelsPerInch( var X:word; var Y:word );
    procedure GetPixelsPerMM( var X:word; var Y:word );
    procedure GetPixelsPerPage( var X:word; var Y:word );
    { The "Gutter" is the area that is unprintable on the
    	page based on the selected printer driver }
    procedure GetGutter( var Top:word; var Bottom:word; var Left:word;
                         var Right:word );
    function  GetIndent: double;
    function  GetTab: double;
    function  GetLinesPerPage: integer;
    { GetWidthOfText was added in order to get the text width
    	without regard for the units. It returns the width of the
      given text in the current measurement units being used }
    function 	GetWidthOfText( Text: string): double;
    { ClipText is used to truncate, if needed, a string to fit
    	into a column }
		function ClipText(ColumnNumber: word; Text: string): string;
    { GetTextWidth returns the pixel width of the Text }
    function  GetTextWidth( Text:string ): integer;
    { Text width in MM }
    function  GetTextWidthMM( Text:string ): double;
    { Text width in inches }
    function 	GetTextWidthInches( Text:string): double;
    function  GetLineHeightPixels: word;
    function  GetLineHeightInches: double;
    function  GetLineHeightMM: double;
    function  GetLineHeight: double;
    function  GetPageWidth: double;
    function  GetPageHeight: double;
    function  GetPageNumber:integer;
    function  GetGutterLeft: double;
    function  GetGutterRight: double;
    function  GetGutterTop: double;
    function  GetGutterBottom: double;
    procedure SaveCurrentFont;
    procedure RestoreCurrentFont;
    procedure SaveCurrentY;
    procedure RestoreCurrentY;
    procedure SetYPosition( YPosition:double );
    function  GetYPosition: double;
    function  GetLinesLeft: word;
    function  GetLinesInDetailArea: word;
    procedure SetTopOfPage;
    procedure SetOrientation(Orient: TPrinterOrientation);
    procedure SetPaperSize(Size: PaperSizes);
    function GetFont: TFont;
    function GetFontName: string;
    function GetFontSize: word;
    function GetFontStyle: TFontStyles;
    function GetFontColor: TColor;
    procedure SetFontName(Name: string);
    procedure SetFontSize(Size: word);
    procedure SetFontStyle(Style: TFontStyles);
    procedure SetFontColor(iColor: TColor);
    procedure SetFontAngle(Angle: integer);
    function GetFontAngle: word;
    procedure SetBrushColor(iColor: TColor);
    function GetBrushColor: TColor;
    procedure SetPenColor(iColor: TColor);
    function GetPenColor: TColor;
    procedure SetPenWidth(iWidth: integer);
    function GetPenWidth: integer;
    procedure SetBrushStyle(Style: TBrushStyle);
    procedure SetPenStyle(Style: TPenStyle);
    procedure SetPenMode(Mode: TPenMode);
    function GetBrushStyle: TBrushStyle;
    function GetPenStyle: TPenStyle;
    function GetPenMode: TPenMode;
    procedure SetMeasure(Meas: MeasureType);
    procedure CalculateMeasurements;
    procedure NewPage;
    procedure PageFeed;
    procedure NextLine;
    procedure NewLines( Number:word );
    procedure OnCancelPrint;
    procedure SetAutoPaging( Value: boolean );
    procedure SetTransparent(Flag: boolean);
    { Returns the current page number being printed to }
    function CurrentPageNumber: integer;

    {Used to coordinate the TMWPrintObject and the Printer so that you can code your
     own printer setup routine. After setting up the printer like you want it, Call
     GetPrinterSpecs to update the TMWPrintObject with the new settings.}
    procedure SetPrinterSpecs;
    procedure GetPrinterSpecs;

    { This will set the current printer driver according to the
    	print object settings. The RestoreState flag is used to
      restore the initial printer specifications that were
      stored using ReadPrinterSpecs }
    procedure WritePrinterSpecs(RestoreState: boolean);
    { ReadPrinterSpecs is initially called when the Start method
    	is called in order to save the state of the printer. It is
      later restored using the WritePrinterSpecs method when
      printing is complete }
    procedure ReadPrinterSpecs(SaveState: boolean);

		{ SetPrnPrinter is used by the preview form to assign the
    	current image for display of the print commands }
    procedure SetPrnPrinter(Current: TImage);
    { PrintPage is the internal method used to play out the commands
    	for each stored page of the report }
    procedure PrintPage(Page: TMWPageList;iPage: integer);
    { PrintFromPreview is the controlling method which loops through
    	the stored pages and calls PrintPage with each one }
    procedure PrintFromPreview;
    { PrintingStatus returns true during normal printing but will
    	return false if the print job has been cancelled. This allows
      you to test during long reports to determine if the user has
      cancelled their request }
    property PrintingStatus: boolean read PrintingOK;
    { PrinterCanvas is used to redirect the printing commands to
    	your own image canvas }
    property PrinterCanvas: TCanvas read ImageCanvas write ImageCanvas;
    { SnakeCurrentColumn is the current column being printed to during
    	the snaking columns printing }
    property SnakeCurrentColumn: integer read fSnakeCurrentColumn;
    { The SnakeColumnsOn and SnakeColumnsOff turn on/off snaking columns.
    	SnakeColumnsOn accepts an array of col numbers to use as the
      snaking columns. This allows you to use non-contiguous columns. It
      also takes a starting column number. This is the the actual column
      number within the passed array of columns to start in. Using the
      SnakeCurrentColumn property, this allows you to continue snaking
      in the column you stopped in. }
    procedure SnakeColumnsOn(Cols: array of integer; StartCol: integer);
    procedure SnakeColumnsOff;
    { WriteSnakeColumn is used to snake the Text after setting SnakeColumnsOn }
    procedure WriteSnakeColumn(Y: double; Text: string);
    { The UseQualitySetting property is used to turn off the use of the
    	print quality setting PrintQuality. I have found some printers that
      react with errors when it is used so until I have it worked out, this
      allows you to turn it off if you don't need it or it causes problems. }
    property UseQualitySetting: boolean read fUseQuality write fUseQuality;

{Added Published properties for ease of setting certain properties at design time.}

	published
  	{Properties:
    	AutomaticPaging: can be used to automatically do NewPage when printing.
      Title: this text becomes the title of the print job in printer manager
      Preview: whether to print directly to printer of show preview of job
      ShowProgress: display a progress bar or not
      ShowPrintDialog: whether to show print dialog to allow user to select
      								 printer, pages to print, etc.
      Orientation: set page orientation (can only be set for all pages)
      ShowTotalPages: sets whether to display page number as 1 of x or not
      ProgressBarMax: sets the maximum progress bar value
      ProgressBarInc: sets the increment for the progress bar
      Transparent: if you want a background image, this sets the text to print
      						 transparently so it shows through
      StartPercent: sets the beginning scale factor for viewing previews
      PaperSize: sets either legal or letter size paper
      ShowCancelBtn: determines whether to display a cancel button for longer
      							print jobs
      Measurement: used to determine whether you are giving value in pixels,
      							inches or millimeters
      ProgressFormColor: sets the progress bar form background color
      ProgressTextColor: sets the color of the text for the messages on the
      									progress bar form
      Version: property to display the version of this component
      AutoPageFeed: determines whether to actually issue a page feed command to the printer
      UseLargeFontAdjust: enables/disables preview form scaling when user has large fonts
      Copies: allows you to set the number of copies to print
      ClipColumns: when true, text is clipped at the right edge when column printing
    }
  	property AutomaticPaging: boolean read AutoPaging write AutoPaging;
  	property Title: string read DocumentTitle write DocumentTitle;
  	property Preview: boolean read ActualPreview write ActualPreview;
    property ShowProgress: boolean read UseProgress write UseProgress;
    property ShowProgressPercent: boolean read fShowPercent write fShowPercent;
    property ShowPrintDialog: boolean read ShowDialog write ShowDialog;
    property Orientation: TPrinterOrientation read PageOrientation write PageOrientation;
    property ShowTotalPages: boolean read GetShowTotalPages write SetShowTotalPages;
    property PrintPageNumbers: boolean read PageNumbering write PageNumbering;
    property ProgressBarMax: word read ProgressMax write ProgressMax;
    property ProgressBarInc: word read ProgressInc write ProgressInc;
    property Transparent: boolean read PrintTransparent write PrintTransparent;
    property StartPercent: Percentages read PreviewPercent write PreviewPercent;
    property PaperSize: PaperSizes read PaperDimension write PaperDimension;
    property ShowCancelBtn: boolean read ShowCancel write ShowCancel;
    property Measurement: MeasureType read Measure write Measure;
    property ProgressFormColor: TColor read BarFormColor write BarFormColor;
    property ProgressTextColor: TColor read BarTextColor write BarTextColor;
    property Version: string read CompVersion write VersionKill;
    property AutoPageFeed: boolean read PageFeeding write PageFeeding;
    property UseLargeFontAdjust: boolean read fUseLargeFontAdjust write fUseLargeFontAdjust;
    property Copies: integer read fCopies write fCopies;
    property ClipColumns: boolean read fColumnClipping write fColumnClipping;
    property PrintQuality: PrintQualities read fQuality write fQuality;

		{Events:
      OnNewPage: event for any printing to occur for every page
      	(I use this to put a bitmap on every page like a company logo)
      AfterNewPage: event to print after the page has been advanced
      	(I use this for things to occur on all but the first page like
        	a continuation header or something)
      OnCancel: event to execute in the case that the cancel button is
      					displayed and the user clicks it
      BeforePrint: event used to signal the start of printing
      AfterPrint: event to signal that the last page has been printed
      OnLastPage: event to execute only when printing the last page of report
      OnFirstPage: event to execute only when printing the first page of report
      PrintDone: event to execute at completion of printing
    }
    property OnNewPage: TNotifyEvent read FPageChange write FPageChange;
    property AfterNewPage: TNotifyEvent read FAPageChange write FAPageChange;
    property OnCancel: TNotifyEvent read FOnCancelPrint write FOnCancelPrint;
    property BeforePrint: TNotifyEvent read FStartPrint write FStartPrint;
    property AfterPrint: TNotifyEvent read FEndPrint write FEndPrint;
    property OnLastPage: TNotifyEvent read FLastPage write FLastPage;
    property OnFirstPage: TNotifyEvent read FFirstPage write FFirstPage;
    property PrintDone: TNotifyEvent read FPrintDone write FPrintDone;
	end;

  { used to store the actual paper sizes in inches for quick retrieval }
  PrnSizeArray = array [1..38] of PrnPaperRec;

procedure Register;

implementation

{$R PRDRVSTR.RES}

const
	PrinterSizes: PrnSizeArray =
  	((pType:1;Width:8.5;Height:11.0),(pType:2;Width:8.5;Height:11.0),
     (pType:3;Width:11.0;Height:17.0),(pType:4;Width:17.0;Height:11.0),
     (pType:5;Width:8.5;Height:14.0),(pType:6;Width:5.5;Height:8.5),
     (pType:7;Width:7.5;Height:10.5),(pType:8;Width:11.7;Height:16.5),
     (pType:9;Width:8.3;Height:11.7),(pType:10;Width:0.0;Height:0.0),
     (pType:11;Width:5.9;Height:8.3),
     (pType:12;Width:9.9;Height:14.0),(pType:13;Width:7.2;Height:10.1),
     (pType:14;Width:8.5;Height:13.0),(pType:15;Width:8.5;Height:10.8),
     (pType:16;Width:10.0;Height:14.0),(pType:17;Width:11.0;Height:17.0),
     (pType:18;Width:8.5;Height:11.0),(pType:19;Width:3.875;Height:8.9),
     (pType:20;Width:4.1;Height:9.5),(pType:21;Width:4.5;Height:10.4),
     (pType:22;Width:4.1;Height:9.5),(pType:23;Width:5.0;Height:11.5),
     (pType:24;Width:0.0;Height:0.0),(pType:25;Width:0.0;Height:0.0),
     (pType:26;Width:0.0;Height:0.0),
     (pType:27;Width:4.3;Height:8.7),(pType:29;Width:12.8;Height:18.0),
     (pType:30;Width:9.0;Height:12.0),(pType:28;Width:6.4;Height:9.0),
     (pType:31;Width:4.5;Height:6.4),(pType:32;Width:4.5;Height:9.0),
     (pType:33;Width:9.8;Height:14.0),(pType:34;Width:7.0;Height:9.8),
     (pType:35;Width:7.0;Height:5.0),(pType:36;Width:4.3;Height:9.1),
     (pType:37;Width:3.9;Height:7.5),(pType:38;Width:3.6;Height:6.5));

var
	PointArray: array [0..99] of TPoint;

constructor TMWPrintObject.Create(AOwner: TComponent);
{Create TMWPrintObject and set default values}
var
	x: integer;

begin
	inherited Create(AOwner);

  CompVersion := 'Version 3.4';
  for x := 1 to HeaderLines do
  begin
  	CurrentFonts[x].Font := nil;
    Header[x].Font := nil;
    Footer[x].Font := nil;
  end;
  PageNumber.Font := nil;
  PreviewMode := true;
  ActualPreview := false;
  ScaleByValue := 1.0;
  DocumentTitle := '';
  AutomaticPaging := false;
  ShowProgress := false;
  ShowDialog := true;
  ShowCancel := false;
  ProgressMax := 100;
  ProgressInc := 1;
  ProgressFormColor := clInfoBk;
  AutoPageFeed := true;
  PageNumbering := false;
  PrintTransparent := false;
  PageNumber.ShowTotalPages := true;
  PreviewPercent := P6_Full;
  UseLargeFontAdjust := true;
  UseQualitySetting := false;
  CurrentFontRecord := 0;
  CurrentYRecord := 0;
  PrintingInternal := false;
  fProgressX := -1;
  fProgressY := -1;
  fCopies := 1;
  Measure := mtInches;
  FPageChange := nil;
  FAPageChange := nil;
  FOnCancelPrint := nil;
  FStartPrint := nil;
  FEndPrint := nil;
  FFirstPage := nil;
  FLastPage := nil;
  FPrintDone := nil;
  ImageCanvas := nil;
  ImagePrinting := false;
  PrintingOK := false;
  IsColor := false;
  IsPrinting := false;
  LargeFontsOn := false;
  fProgressBar := nil;
  fProgressCaption := nil;
  fSnakeColumns := false;
  fColumnClipping := false;
  fUseQuality := true;
  RotateAngle := 0;
  Pages := nil;
  PrintQuality := pqHIGH;
  // here we need to check printer status.......
//  if Not (csDesigning in ComponentState) then
//  	if Printer.Printers.Count > 0 then
//  		Printer.PrinterIndex := -1;
end;

destructor TMWPrintObject.Destroy;
{ Destroy TMWPrintObject and call TComponent destructor}
{ If printing was performed, the other objects created for it
	should have already been destroyed after the print job.}
begin
	Cleanup;
	if Pages <> nil then
  	Pages.Destroy;
	FPageChange := nil;
  FAPageChange := nil;
  FOnCancelPrint := nil;
  FStartPrint := nil;
  FEndPrint := nil;
  FFirstPage := nil;
  FLastPage := nil;
  inherited Destroy;
end;

procedure TMWPrintObject.Abort;
{Used to abort the print job in progress}
begin
	PrintingOK := false;
  Quit;
end;

procedure TMWPrintObject.AfterPageChange;
{Event that occurs after a new page is issued}
var
	oldPage: boolean;

begin
	oldPage := AutomaticPaging;
  SetAutoPaging(false);
	if assigned(FAPageChange) then FAPageChange(self);
  SetAutoPaging(oldPage);
end;

procedure TMWPrintObject.Arc(X1,Y1,X2,Y2,X3,Y3,X4,Y4: double);
var
	ScreenToPrinter: double;

begin
  if DryRun or ImagePrinting then
  case Measure of
  	mtInches:
    	begin
      	X1 := InchesToPixelsHorizontal(X1); Y1 := InchesToPixelsVertical(Y1);
      	X2 := InchesToPixelsHorizontal(X2); Y2 := InchesToPixelsVertical(Y2);
      	X3 := InchesToPixelsHorizontal(X3); Y3 := InchesToPixelsVertical(Y3);
      	X4 := InchesToPixelsHorizontal(X4); Y4 := InchesToPixelsVertical(Y4);
      end;
    mtMM:
    	begin
      	X1 := InchesToPixelsHorizontal(MMToInches(X1)); Y1 := InchesToPixelsVertical(MMToInches(Y1));
      	X2 := InchesToPixelsHorizontal(MMToInches(X2)); Y2 := InchesToPixelsVertical(MMToInches(Y2));
      	X3 := InchesToPixelsHorizontal(MMToInches(X3)); Y3 := InchesToPixelsVertical(MMToInches(Y3));
      	X4 := InchesToPixelsHorizontal(MMToInches(X4)); Y4 := InchesToPixelsVertical(MMToInches(Y4));
      end;
  end;
	if DryRun then
  	Pages.StoreArc(X1,Y1,X2,Y2,X3,Y3,X4,Y4);
  if PixelsPerInchHorizontal > PixelsPerInchVertical then
  	ScreenToPrinter := PixelsPerInchHorizontal / Screen.PixelsPerInch
  else
  	ScreenToPrinter := PixelsPerInchVertical / Screen.PixelsPerInch;
	TheCanvas.Arc(Round(X1*ScreenToPrinter*ScaleByValue)-GutterLeft,
  							Round(Y1*ScreenToPrinter*ScaleByValue)-GutterTop,
  							Round(X2*ScreenToPrinter*ScaleByValue)-GutterLeft,
                Round(Y2*ScreenToPrinter*ScaleByValue)-GutterTop,
  							Round(X3*ScreenToPrinter*ScaleByValue)-GutterLeft,
                Round(Y3*ScreenToPrinter*ScaleByValue)-GutterTop,
                Round(X4*ScreenToPrinter*ScaleByValue)-GutterLeft,
                Round(Y4*ScreenToPrinter*ScaleByValue)-GutterTop);
end;

{ The following code was pulled off of the Inprise site. }
procedure TMWPrintObject.BltTBitmapAsDib(DestDc : hdc;   {Handle of where to blt}
                          x,       				{Bit at x}
                          y,       				{Blt at y}
                          Width,   				{Width to stretch}
                          Height: integer;{Height to stretch}
                          bm : TBitmap);  {the TBitmap to Blt}
var
  OriginalWidth :LongInt;               {width of BM}
  dc : hdc;                             {screen dc}
  IsPaletteDevice : bool;               {if the device uses palettes}
  IsDestPaletteDevice : bool;           {if the device uses palettes}
  BitmapInfoSize : integer;             {sizeof the bitmapinfoheader}
  lpBitmapInfo : PBitmapInfo;           {the bitmap info header}
  hBm : hBitmap;                        {handle to the bitmap}
  hPal : hPalette;                      {handle to the palette}
  OldPal : hPalette;                    {temp palette}
  hBits : THandle;                      {handle to the DIB bits}
  pBits : pointer;                      {pointer to the DIB bits}
  lPPalEntriesArray : PPalEntriesArray; {palette entry array}
  NumPalEntries : integer;              {number of palette entries}
  i : integer;                          {looping variable}
begin
{If range checking is on - lets turn it off for now}
{we will remember if range checking was on by defining}
{a define called CKRANGE if range checking is on.}
{We do this to access array members past the arrays}
{defined index range without causing a range check}
{error at runtime. To satisfy the compiler, we must}
{also access the indexes with a variable. ie: if we}
{have an array defined as a: array[0..0] of byte,}
{and an integer i, we can now access a[3] by setting}
{i := 3; and then accessing a[i] without error}
{$IFOPT R+}
  {$DEFINE CKRANGE}
  {$R-}
{$ENDIF}

 {Save the original width of the bitmap}
  OriginalWidth := bm.Width;

 {Get the screen's dc to use since memory dc's are not reliable}
  dc := GetDc(0);
 {Are we a palette device?}
  IsPaletteDevice :=
    GetDeviceCaps(dc, RASTERCAPS) and RC_PALETTE = RC_PALETTE;
 {Give back the screen dc}
  dc := ReleaseDc(0, dc);

 {Allocate the BitmapInfo structure}
  if IsPaletteDevice then
    BitmapInfoSize := sizeof(TBitmapInfo) + (sizeof(TRGBQUAD) * 255)
  else
    BitmapInfoSize := sizeof(TBitmapInfo);
  GetMem(lpBitmapInfo, BitmapInfoSize);

 {Zero out the BitmapInfo structure}
  FillChar(lpBitmapInfo^, BitmapInfoSize, #0);

 {Fill in the BitmapInfo structure}
  lpBitmapInfo^.bmiHeader.biSize := sizeof(TBitmapInfoHeader);
  lpBitmapInfo^.bmiHeader.biWidth := OriginalWidth;
  lpBitmapInfo^.bmiHeader.biHeight := bm.Height;
  lpBitmapInfo^.bmiHeader.biPlanes := 1;
  if IsPaletteDevice then
    lpBitmapInfo^.bmiHeader.biBitCount := 8
  else
    lpBitmapInfo^.bmiHeader.biBitCount := 24;
  lpBitmapInfo^.bmiHeader.biCompression := BI_RGB;
  lpBitmapInfo^.bmiHeader.biSizeImage :=
    ((lpBitmapInfo^.bmiHeader.biWidth *
      longint(lpBitmapInfo^.bmiHeader.biBitCount)) div 8) *
      lpBitmapInfo^.bmiHeader.biHeight;
  lpBitmapInfo^.bmiHeader.biXPelsPerMeter := 0;
  lpBitmapInfo^.bmiHeader.biYPelsPerMeter := 0;
  if IsPaletteDevice then begin
    lpBitmapInfo^.bmiHeader.biClrUsed := 256;
    lpBitmapInfo^.bmiHeader.biClrImportant := 256;
  end else begin
    lpBitmapInfo^.bmiHeader.biClrUsed := 0;
    lpBitmapInfo^.bmiHeader.biClrImportant := 0;
  end;

 {Take ownership of the bitmap handle and palette}
  hBm := bm.ReleaseHandle;
  hPal := bm.ReleasePalette;

 {Get the screen's dc to use since memory dc's are not reliable}
  dc := GetDc(0);

  if IsPaletteDevice then begin
   {If we are using a palette, it must be}
   {selected into the dc during the conversion}
    OldPal := SelectPalette(dc, hPal, TRUE);
   {Realize the palette}
    RealizePalette(dc);
  end;
 {Tell GetDiBits to fill in the rest of the bitmap info structure}
  GetDiBits(dc,
            hBm,
            0,
            lpBitmapInfo^.bmiHeader.biHeight,
            nil,
            TBitmapInfo(lpBitmapInfo^),
            DIB_RGB_COLORS);

 {Allocate memory for the Bits}
  hBits := GlobalAlloc(GMEM_MOVEABLE,
                       lpBitmapInfo^.bmiHeader.biSizeImage);
  pBits := GlobalLock(hBits);
 {Get the bits}
  GetDiBits(dc,
            hBm,
            0,
            lpBitmapInfo^.bmiHeader.biHeight,
            pBits,
            TBitmapInfo(lpBitmapInfo^),
            DIB_RGB_COLORS);


  if IsPaletteDevice then begin
   {Lets fix up the color table for buggy video drivers}
    GetMem(lPPalEntriesArray, sizeof(TPaletteEntry) * 256);
   {$IFDEF VER100}
      NumPalEntries := GetPaletteEntries(hPal,
                                         0,
                                         256,
                                         lPPalEntriesArray^);
   {$ELSE}
      NumPalEntries := GetSystemPaletteEntries(dc,
                                               0,
                                               256,
                                               lPPalEntriesArray^);
   {$ENDIF}
    for i := 0 to (NumPalEntries - 1) do begin
      lpBitmapInfo^.bmiColors[i].rgbRed :=
        lPPalEntriesArray^[i].peRed;
      lpBitmapInfo^.bmiColors[i].rgbGreen :=
        lPPalEntriesArray^[i].peGreen;
      lpBitmapInfo^.bmiColors[i].rgbBlue :=
        lPPalEntriesArray^[i].peBlue;
    end;
    FreeMem(lPPalEntriesArray, sizeof(TPaletteEntry) * 256);
  end;

  if IsPaletteDevice then begin
   {Select the old palette back in}
    SelectPalette(dc, OldPal, TRUE);
   {Realize the old palette}
    RealizePalette(dc);
  end;

 {Give back the screen dc}
  dc := ReleaseDc(0, dc);

 {Is the Dest dc a palette device?}
  IsDestPaletteDevice :=
    GetDeviceCaps(DestDc, RASTERCAPS) and RC_PALETTE = RC_PALETTE;


  if IsPaletteDevice then begin
   {If we are using a palette, it must be}
   {selected into the dc during the conversion}
    OldPal := SelectPalette(DestDc, hPal, TRUE);
   {Realize the palette}
    RealizePalette(DestDc);
  end;

 {Do the blt}
  StretchDiBits(DestDc,
                x,
                y,
                Width,
                Height,
                0,
                0,
                OriginalWidth,
                lpBitmapInfo^.bmiHeader.biHeight,
                pBits,
                lpBitmapInfo^,
                DIB_RGB_COLORS,
                SrcCopy);

  if IsDestPaletteDevice then begin
   {Select the old palette back in}
    SelectPalette(DestDc, OldPal, TRUE);
   {Realize the old palette}
    RealizePalette(DestDc);
  end;

 {De-Allocate the Dib Bits}
  GlobalUnLock(hBits);
  GlobalFree(hBits);

 {De-Allocate the BitmapInfo}
  FreeMem(lpBitmapInfo, BitmapInfoSize);

 {Set the ownership of the bimap handles back to the bitmap}
  bm.Handle := hBm;
  bm.Palette := hPal;

  {Turn range checking back on if it was on when we started}
{$IFDEF CKRANGE}
  {$UNDEF CKRANGE}
  {$R+}
{$ENDIF}
end;

function TMWPrintObject.CalculateLineHeight: integer;
   { Calculate the height of a line plus the normal amount of space between
     each line }
begin
	Result := Round(TheCanvas.TextHeight('A') / ScaleByValue);

  if LargeFontsOn then
  	result := Round(Result / 2);
end;

procedure TMWPrintObject.CalculateMeasurements;
   { Calculate some necessary measurements.  Thanks to Robert Fabiszak
     CompuServe: 70304,2047 for the Escape() Windows API calls. }
var
	pt: TPoint;

begin
   { Call the Windows API function GetTextMetrics() to get the specifics
     of the particular font. }
	GetTextMetrics( TheCanvas.Handle,TextMetrics );

   { Calculate the number of pixels per inch vertical and horizontal.
     'GetDeviceCaps' is a Windows API call. }
  PixelsPerInchVertical := GetDeviceCaps( TheCanvas.Handle,LOGPIXELSY );
  PixelsPerInchHorizontal := GetDeviceCaps( TheCanvas.Handle,LOGPIXELSX );
  LargeFontsOn := fUseLargeFontAdjust and (DryRun or PreviewMode) and
  								(PixelsPerInchHorizontal > 96);
  if LargeFontsOn then
  begin
  	PixelsPerInchVertical := Round(PixelsPerInchVertical / 1.25);
    PixelsPerInchHorizontal := Round(PixelsPerInchHorizontal / 1.25);
  end;
   { Get the gutter on the left and top.  'Escape' is a Windows API
     call. }
  Escape( TheCanvas.Handle,GETPRINTINGOFFSET,0,Nil,@pt );

  if ImagePrinting or PreviewMode then
  begin
   	GutterLeft := 0;
    GutterTop := 0;
  end
  else
  begin
   	GutterLeft := pt.X;
   	GutterTop := pt.Y;
  end;
  Escape( TheCanvas.Handle,GETPHYSPAGESIZE,0,Nil,@pt );
   {If printing to a TImage, the size doesn't come back as expected so we get the
    size of the preview image}
  if PreviewMode then
  begin
  	pt.X := PreviewForm.GetWidth;
    pt.Y := PreviewForm.GetHeight;
    if LargeFontsOn then
    begin
    	pt.X := Round(pt.X / 1.25);
      pt.Y := Round(pt.Y / 1.25);
    end;
  end
  else if ImagePrinting then
  begin
  	pt.X := RightMargin - LeftMargin;
    pt.Y := BottomMargin - TopMargin;
  end;
  TotalPageWidthPixels := pt.X;
  TotalPageHeightPixels := pt.Y;
  if LargeFontsOn then
  begin
  	TotalPageWidthInches := pt.X / (PixelsPerInchHorizontal / 1.25);
  	TotalPageHeightInches := pt.Y / (PixelsPerInchVertical / 1.25);
  end
  else
  begin
  	TotalPageWidthInches := pt.X / PixelsPerInchHorizontal;
  	TotalPageHeightInches := pt.Y / PixelsPerInchVertical;
  end;
   {Need to set these using the scaling value if in preview mode}
  if ImagePrinting or PreviewMode then
  begin
   	GutterRight := 0;
    GutterBottom := 0;
  end
  else
  begin
 		GutterRight := TotalPageWidthPixels - GutterLeft - Printer.PageWidth;
 		GutterBottom := TotalPageHeightPixels - GutterTop - Printer.PageHeight;
  end;
  if ( TopMargin < GutterTop ) then
  	TopMargin := GutterTop;
  if ( BottomMargin > TotalPageHeightPixels - GutterBottom ) then
  	BottomMargin := TotalPageHeightPixels - GutterBottom;
  if ( LeftMargin < GutterLeft ) then
  	LeftMargin := GutterLeft;
  if ( RightMargin > TotalPageWidthPixels - GutterRight ) then
  	RightMargin := TotalPageWidthPixels - GutterRight;
end;

procedure TMWPrintObject.CancelPrintJob;
begin
	PrintingOK := false;
end;

procedure TMWPrintObject.Cleanup;
var
	x: integer;

begin
	for x := 1 to HeaderLines do
  begin
  	Header[x].Text := '';
    Header[x].Font.Free;
    Header[x].Font := nil;
    CurrentFonts[x].Font.Free;
    CurrentFonts[x].Font := nil;
  end;
  for x := 1 to FooterLines do
  begin
  	Footer[x].Text := '';
    Footer[x].Font.Free;
    Footer[x].Font := nil;
  end;
  for x := 1 to Columns do
  begin
  	ColumnInformation[x].XPosition := 0.0;
    ColumnInformation[x].Length := 0.0;
  end;
  PageNumber.Text := '';
  if PageNumber.Font <> nil then
  begin
  	PageNumber.Font.Free;
  	PageNumber.Font := nil;
  end;
  SetTab(0.0);
  fProgressBar := nil;
  fProgressCaption := nil;
  try
  	if PreviewForm <> nil then
  		PreviewForm.Close;
  except
  	ShowMessage('Error closing preview form.');
  end;
end;

{ The ClearCanvas and ClearCanvasArea are only used for drawing/printing to
	an image or canvas other than the printer. }
procedure TMWPrintObject.ClearCanvas(iColor: TColor);
var
	oldColor: TColor;

begin
	if not ImagePrinting then
  	exit;
  oldColor := TheCanvas.Brush.Color;
  TheCanvas.Brush.Color := iColor;
	TheCanvas.FillRect(rect(LeftMargin, TopMargin, RightMargin, BottomMargin));
  TheCanvas.Brush.Color := oldColor;
end;

procedure TMWPrintObject.ClearCanvasArea(XTop,YTop,XBottom,YBottom: integer; iColor: TColor);
var
	oldColor: TColor;

begin
	if not ImagePrinting then
  	exit;
  case Measure of
  	mtInches:
    	begin
      	XTop := InchesToPixelsHorizontal(XTop); YTop := InchesToPixelsVertical(YTop);
      	XBottom := InchesToPixelsHorizontal(XBottom); YBottom := InchesToPixelsVertical(YBottom);
      end;
    mtMM:
    	begin
      	XTop := InchesToPixelsHorizontal(MMToInches(XTop));
        YTop := InchesToPixelsVertical(MMToInches(YTop));
      	XBottom := InchesToPixelsHorizontal(MMToInches(XBottom));
        YBottom := InchesToPixelsVertical(MMToInches(YBottom));
      end;
  end;
  oldColor := TheCanvas.Brush.Color;
  TheCanvas.Brush.Color := iColor;
	TheCanvas.FillRect(rect(XTop,YTop,XBottom,YBottom));
  TheCanvas.Brush.Color := oldColor;
end;

procedure TMWPrintObject.ClearPageInfo;
{ ClearPageInfo will clear the commands stored for the current page }
begin
	Pages.ClearPage;
end;

function TMWPrintObject.ConvertMeasure(Value: double; mFrom, mTo: MeasureType;
					VertHoriz: word): double;
{This function is used to be able to convert between any two MeasureTypes}
begin
	result := Value;
  case VertHoriz of
  	wtVertical: // vertical resolution conversion calculations...
    	case mFrom of
				mtInches:
        	case mTo of
          	mtMM: result := InchesToMM(Value);
            mtPixels: result := InchesToPixelsVertical(Value);
          end;
        mtMM:
        	case mTo of
          	mtInches: result := MMToInches(Value);
            mtPixels: result := MMToPixelsVertical(Value);
          end;
        mtPixels:
        	case mTo of
          	mtInches: result := PixelsToInchesVertical(Value);
            mtMM: result := PixelsToMMVertical(Value);
          end;
      end;
    wtHorizontal: // horizontal resolution conversion calculations...
    	case mFrom of
      	mtInches:
        	case mTo of
          	mtMM: result := InchesToMM(Value);
            mtPixels: result := InchesToPixelsHorizontal(Value);
          end;
        mtMM:
        	case mTo of
          	mtInches: result := MMToInches(Value);
            mtPixels: result := MMToPixelsHorizontal(Value);
          end;
        mtPixels:
        	case mTo of
          	mtInches: result := PixelsToInchesHorizontal(Value);
            mtMM: result := PixelsToMMHorizontal(Value);
          end;
      end;
  end;
end;

procedure TMWPrintObject.CreateColumn( Number:word; XPosition:double; Length:double );
{Stores the column information. There is a maximum of 20 columns}
begin
	if Not PrintingOK then
  	exit;
	if (Number > Columns) or (Number < 1) then
  begin
  	ShowMessage('Column value must be between 1 and ' + IntToStr(Columns) + '.');
    exit;
  end;
  if DryRun or ImagePrinting then
  	case Measure of
    	mtPixels:
      	begin
        	XPosition := PixelsToInchesHorizontal(Round(XPosition));
          Length := PixelsToInchesHorizontal(Round(Length));
        end;
      mtMM:
      	begin
        	XPosition := MMToInches(XPosition);
          Length := MMToInches(Length);
        end;
    end;
	ColumnInformation[Number].XPosition := XPosition;
  ColumnInformation[Number].Length := Length;
	if DryRun then
  	Pages.StoreColumn(Number,XPosition,Length);
end;

function TMWPrintObject.GetFont: TFont;
begin
	result := TheCanvas.Font;
end;

function TMWPrintObject.GetFontName: string;
begin
	result := TheCanvas.Font.Name;
end;

function TMWPrintObject.GetFontSize: word;
begin
	result := TheCanvas.Font.Size;
end;

function TMWPrintObject.GetFontStyle: TFontStyles;
begin
	result := TheCanvas.Font.Style;
end;

function TMWPrintObject.CurrentPageNumber: integer;
begin
	if PreviewMode then
  	result := PreviewForm.GetPageNumber
  else
  	result := Printer.PageNumber;
end;

procedure TMWPrintObject.DrawBox( XTop,YTop,XBottom,YBottom:double;
																LineWidth:word );
   { Draw a box at the X,Y coordinates passed in the parameters.
   	 The box is drawn using Line commands because certain printers
     such as HP Laserjets tend to fill the block overwriting
     any text inside a printed box. }
var
  oldWidth: integer;
  oldColor: TColor;

begin
	if Not PrintingOK then
  	exit;
  oldColor := TheCanvas.Brush.Color;
  SetBrushColor(GetPenColor);
	if LineWidth > 0 then
		DrawTheBox(XTop,YTop,XBottom,YBottom,LineWidth);
  SetBrushColor(oldColor);
end;

procedure TMWPrintObject.DrawBoxShade( XTop,YTop,XBottom,YBottom:double;
																			LineWidth:word; Shading:TColor );
   { Draw a box at the X,Y coordinates passed in the parameters }
var
  oldX,oldY,oldWidth: integer;
  oldBColor: TColor;

begin
	if Not PrintingOK then
  	exit;
  oldBColor := TheCanvas.Brush.Color;
  SetBrushColor(Shading);
  FillRect(XTop,YTop,XBottom,YBottom);
  SetBrushColor(GetPenColor);
	if LineWidth > 0 then
		DrawTheBox(XTop,YTop,XBottom,YBottom,LineWidth);
  SetBrushColor(oldBColor);
end;

procedure TMWPrintObject.DrawTheBox( TopX,TopY,BottomX,BottomY:double; LineWidth:word );
{This method is called by all the boxing routines for the outside lines}
begin
	if LineWidth > 0 then
  begin
		LineWidth := Round(LineWidth * ScaleByValue);
    if LineWidth < 1 then
    	LineWidth := 1;
  end;
	DrawLine(TopX, TopY, BottomX, TopY, LineWidth);
  DrawLine(BottomX, TopY, BottomX, BottomY, LineWidth);
  DrawLine(BottomX, BottomY, TopX, BottomY, LineWidth);
  DrawLine(TopX, BottomY, TopX, TopY, LineWidth);
end;

procedure TMWPrintObject.DrawLine( TopX,TopY,BottomX,BottomY:double; LineWidth:word );
   { Draw a line beginning at a particular X,Y coordinate and ending at a
     particular X,Y coordinate. }
var
	TopXPixels, BottomXPixels, TopYPixels, BottomYPixels: integer;
  oldWidth: integer;

begin
	if Not PrintingOK then
  	exit;
  if DryRun or ImagePrinting then
  	case Measure of
    	mtPixels:
      	begin
        	TopX := PixelsToInchesHorizontal(Round(TopX));
          TopY := PixelsToInchesVertical(Round(TopY));
          BottomX := PixelsToInchesHorizontal(Round(BottomX));
          BottomY := PixelsToInchesVertical(Round(BottomY));
        end;
      mtMM:
      	begin
        	TopX := MMToInches(TopX);
          TopY := MMToInches(TopY);
          BottomX := MMToInches(BottomX);
          BottomY := MMToInches(BottomY);
        end;
    end;
	if DryRun then
  	Pages.StoreLine(TopX,TopY,BottomX,BottomY,LineWidth);
	TopXPixels := InchesToPixelsHorizontal( TopX );
  BottomXPixels := InchesToPixelsHorizontal( BottomX);

  TopYPixels := InchesToPixelsVertical( TopY );
  BottomYPixels := InchesToPixelsVertical( BottomY );
 	Dec( TopXPixels,GutterLeft );
 	Dec( BottomXPixels,GutterLeft );
 	Dec( TopYPixels,GutterTop );
 	Dec( BottomYPixels,GutterTop );
  oldWidth := TheCanvas.Pen.Width;
  if ImagePrinting then
  	TheCanvas.Pen.Width := LineWidth
  else
		TheCanvas.Pen.Width := Round(LineWidth * ScaleByValue);
  TheCanvas.MoveTo( TopXPixels,TopYPixels );
	TheCanvas.LineTo( BottomXPixels,BottomYPixels );
  TheCanvas.Pen.Width := oldWidth;
end;

procedure TMWPrintObject.TextColumnBox( XTop,YTop,XBottom,YBottom:double;
																		LineWidth:word; Shading:TColor; Text: string;
                                    Column: integer; Alignment: word );
{Routine to draw a shaded box with text printed inside. Added this to make it easier
 than drawing the box and then writing the text.}
var
  ColorTmp: TColor;

begin
	if Not PrintingOK then
  	exit;
  ColorTmp := TheCanvas.Brush.Color;
  SetBrushColor(Shading);
  FillRect(XTop,YTop,XBottom,YBottom);
  SetBrushColor(GetPenColor);
	DrawTheBox(XTop,YTop,XBottom,YBottom,LineWidth);
  SetBrushColor(ColorTmp);
  case Alignment of
  	0: WriteLineColumn(Column,-2,Text);
   	1: WriteLineColumnCenter(Column,-2,Text);
   	2: WriteLineColumnRight(Column,-2,Text);
  end;
end;

procedure TMWPrintObject.Ellipse(X1,Y1,X2,Y2: double);
var
	ScreenToPrinter: double;

begin
	if DryRun or ImagePrinting then
  case Measure of
  	mtInches:
    	begin
      	X1 := InchesToPixelsHorizontal(X1); Y1 := InchesToPixelsVertical(Y1);
      	X2 := InchesToPixelsHorizontal(X2); Y2 := InchesToPixelsVertical(Y2);
      end;
    mtMM:
    	begin
      	X1 := InchesToPixelsHorizontal(MMToInches(X1)); Y1 := InchesToPixelsVertical(MMToInches(Y1));
      	X2 := InchesToPixelsHorizontal(MMToInches(X2)); Y2 := InchesToPixelsVertical(MMToInches(Y2));
      end;
  end;
	if DryRun then
  	Pages.StoreEllipse(X1,Y1,X2,Y2);
  if PixelsPerInchHorizontal > PixelsPerInchVertical then
  	ScreenToPrinter := PixelsPerInchHorizontal / Screen.PixelsPerInch
  else
  	ScreenToPrinter := PixelsPerInchVertical / Screen.PixelsPerInch;
	TheCanvas.Ellipse(Round(X1*ScreenToPrinter*ScaleByValue)-GutterLeft,
  									Round(Y1*ScreenToPrinter*ScaleByValue)-GutterTop,
  									Round(X2*ScreenToPrinter*ScaleByValue)-GutterLeft,
                    Round(Y2*ScreenToPrinter*ScaleByValue)-GutterTop);
end;

procedure TMWPrintObject.FillRect(X1, Y1, X2, Y2: double);
var
	ScreenToPrinter: double;

begin
	if DryRun or ImagePrinting then
  	case Measure of
    	mtInches:
      	begin
        	X1 := InchesToPixelsHorizontal(X1); Y1 := InchesToPixelsVertical(Y1);
          X2 := InchesToPixelsHorizontal(X2); Y2 := InchesToPixelsVertical(Y2);
        end;
      mtMM:
      	begin
        	X1 := MMToPixelsHorizontal(X1); Y1 := MMToPixelsVertical(Y1);
          X2 := MMToPixelsHorizontal(X2); Y2 := MMToPixelsVertical(Y2);
        end;
    end;
	if DryRun then
    Pages.StoreFillRect(X1,Y1,X2,Y2);
  if LargeFontsOn then
  begin
  	X1 := X1 * 1.25; X2 := X2 * 1.25;
    Y1 := Y1 * 1.25; Y2 := Y2 * 1.25;
  end;
  if PixelsPerInchHorizontal > PixelsPerInchVertical then
  	ScreenToPrinter := PixelsPerInchHorizontal / Screen.PixelsPerInch
  else
  	ScreenToPrinter := PixelsPerInchVertical / Screen.PixelsPerInch;
  TheCanvas.FillRect(Rect(Round(X1*ScreenToPrinter*ScaleByValue)-GutterLeft,
  												Round(Y1*ScreenToPrinter*ScaleByValue)-GutterTop,
                          Round(X2*ScreenToPrinter*ScaleByValue)-GutterLeft,
                          Round(Y2*ScreenToPrinter*ScaleByValue)-GutterTop));
end;

procedure TMWPrintObject.FloodFill(X,Y: double;Color: TColor;FillStyle: TFillStyle);
var
	ScreenToPrinter: double;

begin
	if DryRun or ImagePrinting then
  	case Measure of
    	mtInches:
      	begin
        	X := InchesToPixelsHorizontal(X); Y := InchesToPixelsVertical(Y);
        end;
      mtMM:
      	begin
        	X := MMToPixelsHorizontal(X); Y := MMToPixelsVertical(Y);
        end;
    end;
	if DryRun then
  	Pages.StoreFloodFill(X,Y,Color,FillStyle);
  if LargeFontsOn then
  begin
  	X := X * 1.25;
    Y := Y * 1.25;
  end;
  if PixelsPerInchHorizontal > PixelsPerInchVertical then
  	ScreenToPrinter := PixelsPerInchHorizontal / Screen.PixelsPerInch
  else
  	ScreenToPrinter := PixelsPerInchVertical / Screen.PixelsPerInch;
  TheCanvas.FloodFill(Round(X*ScreenToPrinter*ScaleByValue)-GutterLeft,
  										Round(Y*ScreenToPrinter*ScaleByValue)-GutterTop,Color,FillStyle);
end;

procedure TMWPrintObject.GradientFill(X1, Y1, X2, Y2: double;
									begColor, endColor: TColor;	Direction: integer);
var
  r1,b1,g1,
  r2,b2,g2: integer;
  r,g,b,
  r3,g3,b3: real;
  w,x,y,z,lh: double;
  tmpColor: TColor;

begin
    case Direction of
    	wtTopBottom:
      	begin
        	lh := ((Y2 - Y1) / 100);
          w := X1;
          x := Y1;
          y := Y2;
          z := X2;
        end;
      wtLeftRight:
      	begin
        	lh := ((X2 - X1) / 100);
          w := Y1;
          x := X1;
          y := X2;
          z := Y2;
        end;
      wtBottomTop:
      	begin
        	lh := ((Y2 - Y1) / 100);
          w := X1;
          x := Y1;
          y := Y2;
          z := X2;
          tmpColor := begColor;
          begColor := endColor;
          endColor := tmpColor;
        end;
      wtRightLeft:
      	begin
        	lh := ((X2 - X1) / 100);
          w := Y1;
          x := X1;
          y := X2;
          z := Y2;
          tmpColor := begColor;
          begColor := endColor;
          endColor := tmpColor;
        end;
    end;
    r1 := GetRValue(begColor);
    b1 := GetBValue(begColor);
    g1 := GetGValue(begColor);
    r2 := GetRValue(endColor);
    b2 := GetBValue(endColor);
    g2 := GetGValue(endColor);
    r := (r2 - r1) / 100;
    g := (g2 - g1) / 100;
    b := (b2 - b1) / 100;
    r3 := r1;
    b3 := b1;
    g3 := g1;
    while x < y do
    begin
    	r3 := r3 + r;
      g3 := g3 + g;
      b3 := b3 + b;
      if (r3 < 0) then
      	r3 := 0
      else if (r3 > 255) then
      	r3 := 255;
      if (g3 < 0) then
      	g3 := 0
      else if (g3 > 255) then
      	g3 := 255;
      if (b3 < 0) then
      	b3 := 0
      else if (b3 > 255) then
      	b3 := 255;
      SetPenColor(RGB(Round(r3),round(g3),round(b3)));
      case Direction of
      	wtTopBottom,
        wtBottomTop: DrawBoxShade(w,x,z,x+lh,1, RGB(Round(r3),round(g3),round(b3)));
        wtLeftRight,
        wtRightLeft: DrawBoxShade(x,w,x+lh,z,1, RGB(Round(r3),round(g3),round(b3)));
      end;
      x := x + lh;
    end;
end;

procedure TMWPrintObject.FrameRect(X1, Y1, X2, Y2: double);
var
	ScreenToPrinter: double;

begin
	if DryRun or ImagePrinting then
  	case Measure of
    	mtInches:
      	begin
        	X1 := InchesToPixelsHorizontal(X1); Y1 := InchesToPixelsVertical(Y1);
          X2 := InchesToPixelsHorizontal(X2); Y2 := InchesToPixelsVertical(Y2);
        end;
      mtMM:
      	begin
        	X1 := MMToPixelsHorizontal(X1); Y1 := MMToPixelsVertical(Y1);
          X2 := MMToPixelsHorizontal(X2); Y2 := MMToPixelsVertical(Y2);
        end;
    end;
	if DryRun then
    Pages.StoreFrameRect(X1,Y1,X2,Y2);
  if LargeFontsOn then
  begin
  	X1 := X1 * 1.25; X2 := X2 * 1.25;
    Y1 := Y1 * 1.25; Y2 := Y2 * 1.25;
  end;
  if PixelsPerInchHorizontal > PixelsPerInchVertical then
  	ScreenToPrinter := PixelsPerInchHorizontal / Screen.PixelsPerInch
  else
  	ScreenToPrinter := PixelsPerInchVertical / Screen.PixelsPerInch;
  TheCanvas.FrameRect(Rect(Round(X1*ScreenToPrinter*ScaleByValue)-GutterLeft,
  												Round(Y1*ScreenToPrinter*ScaleByValue)-GutterTop,
                          Round(X2*ScreenToPrinter*ScaleByValue)-GutterLeft,
                          Round(Y2*ScreenToPrinter*ScaleByValue)-GutterTop));
end;

function TMWPrintObject.GetBrushColor: TColor;
begin
	result := TheCanvas.Brush.Color;
end;

function TMWPrintObject.GetBrushStyle: TBrushStyle;
begin
	result := TheCanvas.Brush.Style;
end;

function TMWPrintObject.GetColumnLeft( Number:word): double;
{Function to return the left X coordinate of the desired column.}
begin
	if DryRun or ImagePrinting then
  	case Measure of
    	mtPixels: result := InchesToPixelsHorizontal(ColumnInformation[Number].XPosition);
      mtMM: result := InchesToMM(ColumnInformation[Number].XPosition);
      mtInches: result := ColumnInformation[Number].XPosition;
    end
  else
		result := ColumnInformation[Number].XPosition;
end;

function TMWPrintObject.GetColumnRight( Number:word): double;
{Function to return the Right X coordinate of the desired column.}
begin
	if DryRun or ImagePrinting then
  	case Measure of
    	mtPixels: result := InchesToPixelsHorizontal(
      	ColumnInformation[Number].XPosition + ColumnInformation[Number].Length);
      mtMM: result := InchesToMM(ColumnInformation[Number].XPosition +
      	ColumnInformation[Number].Length);
      mtInches: result := ColumnInformation[Number].XPosition +
      	ColumnInformation[Number].Length;
    end
  else
		result := ColumnInformation[Number].XPosition + ColumnInformation[Number].Length;
end;

function TMWPrintObject.GetColumnWidth( Number:word): double;
{Function to return the Right X coordinate of the desired column.}
begin
	if DryRun or ImagePrinting then
  	case Measure of
    	mtPixels: result := InchesToPixelsHorizontal(
      	ColumnInformation[Number].Length);
      mtMM: result := InchesToMM(ColumnInformation[Number].Length);
      mtInches: result := ColumnInformation[Number].Length;
    end
  else
		result := ColumnInformation[Number].Length;
end;

function TMWPrintObject.GetColumnsPerLine: integer;
   { How many columns are there in a Line? }
var
	Pixels: integer;

begin
	Pixels := TotalPageWidthPixels - LeftMargin - RightMargin;
  Result := Pixels div GetTextWidth( 'B' );
end;

function TMWPrintObject.GetFontAngle: word;
var
	lf: TLogFont;

begin
	GetObject(TheCanvas.Handle,SizeOf(lf),@lf);
  result := Round(lf.lfEscapement/10);
end;

function TMWPrintObject.GetFontColor: TColor;
begin
	result := TheCanvas.Font.Color;
end;

procedure TMWPrintObject.GetGutter( var Top:word; var Bottom:word; var Left:word;
            											var Right:word );
{ Returns the gutter (non-printable) setting of the page }
begin
	Top := GutterTop;
  Bottom := GutterBottom;
  Left := GutterLeft;
  Right := GutterRight;
end;

function TMWPrintObject.GetGutterBottom: double;
begin
	result := PixelsToMeasurementV( GutterBottom );
end;

function TMWPrintObject.GetGutterLeft: double;
begin
	result := PixelsToMeasurementH( GutterLeft );
end;

function TMWPrintObject.GetGutterRight: double;
begin
	result := PixelsToMeasurementH( GutterRight );
end;

function TMWPrintObject.GetGutterTop: double;
begin
	result := PixelsToMeasurementV( GutterTop );
end;

function TMWPrintObject.GetIndent: double;
begin
	case Measurement of
  	mtMM: result := InchesToMM(CurrentIndent);
    mtPixels: result := InchesToPixelsHorizontal(CurrentIndent);
    mtInches: result := CurrentIndent;
  end;
end;

function  TMWPrintObject.GetLineHeight: double;
begin
	result := PixelsToMeasurementV( CalculateLineHeight );
end;

function TMWPrintObject.GetLineHeightMM: double;
begin
	result := PixelsToMMVertical( GetLineHeightPixels );
end;

function TMWPrintObject.GetLineHeightInches: double;
{ Returns the height of current line in inches }
begin
	Result := PixelsToInchesVertical( GetLineHeightPixels );
end;

function TMWPrintObject.GetLineHeightPixels: word;
{ Returns the height of current line in pixels }
begin
	Result := CalculateLineHeight;
end;

function TMWPrintObject.GetLinesInDetailArea: word;
   { Return the number of lines in the detail area }
begin
  Result := InchesToPixelsVertical( DetailBottom - DetailTop ) div CalculateLineHeight;
end;

function TMWPrintObject.GetLinesLeft: word;
   { Return the number of lines left in the detail area }
var
	Lines: double;

begin
	if LastYPosition > DetailBottom then
  	Lines := 0
  else
		Lines := (DetailBottom - LastYPosition) / GetLineHeightInches;
  Result := Round(Lines);
end;

function TMWPrintObject.GetLinesPerPage: integer;
   { Return the number of lines on the entire page }
begin
	Result := (TotalPageHeightPixels - GutterTop - GutterBottom) div CalculateLineHeight;
end;

function TMWPrintObject.GetLineWidth: word;
{ Returns the current drawing width of the pen }
begin
	Result := TheCanvas.Pen.Width;
end;

function  TMWPrintObject.GetPageWidth: double;
begin
	result := PixelsToMeasurementH( TotalPageWidthPixels );
end;

function  TMWPrintObject.GetPageHeight: double;
begin
	result := PixelsToMeasurementV( TotalPageHeightPixels );
end;

function TMWPrintObject.GetPageNumber;
   { Return the current page number }
begin
	if ImagePrinting or Not PrintingOK then
  begin
  	result := -1;
  	exit;
  end;
	if PreviewMode then
   	Result := PreviewForm.GetPageNumber
  else
   	Result := Printer.PageNumber;
end;

function TMWPrintObject.GetPenColor: TColor;
begin
	result := TheCanvas.Pen.Color;
end;

function TMWPrintObject.GetPenMode: TPenMode;
begin
	result := TheCanvas.Pen.Mode;
end;

function TMWPrintObject.GetPenStyle: TPenStyle;
begin
	result := TheCanvas.Pen.Style;
end;

function TMWPrintObject.GetPenWidth: integer;
begin
	result := TheCanvas.Pen.Width;
end;

procedure TMWPrintObject.GetPixelsPerMM( var X: word; var Y: word );
begin
	X := Round(PixelsPerInchHorizontal / 25.4);
  Y := Round(PixelsPerInchVertical / 25.4);
end;

procedure TMWPrintObject.GetPixelsPerInch( var X:word; var Y:word );
{ Returns the current pixels per inch of the canvas }
begin
	X := PixelsPerInchHorizontal;
  Y := PixelsPerInchVertical;
end;

procedure TMWPrintObject.GetPixelsPerPage( var X:word; var Y:word );
{ Returns the number of pixels across the printable area of the page }
begin
	X := TotalPageWidthPixels - GutterLeft - GutterRight;
  Y := TotalPageHeightPixels - GutterTop - GutterBottom;
end;

function TMWPrintObject.GetScale: double;
{Returns to current scale multiplier}
begin
	result := ScaleByValue;
end;

function TMWPrintObject.GetShowTotalPages: boolean;
{ Function to return the setting of showing total page numbers }
begin
	result := PageNumber.ShowTotalPages;
end;

function TMWPrintObject.GetTab: double;
begin
	case Measurement of
  	mtMM: result := InchesToMM(CurrentTab);
    mtPixels: result := InchesToPixelsHorizontal(CurrentTab);
    mtInches: result := CurrentTab;
  end;
end;

function TMWPrintObject.GetWidthOfText(Text: string): double;
{ This function will return the width of the Text in the current measurement units }
begin
	case Measure of
  	mtPixels: result := GetTextWidth(Text);
    mtInches: result := GetTextWidthInches(Text);
    mtMM: result := GetTextWidthMM(Text);
  else
  	result := 0.0;
  end;
end;

function TMWPrintObject.GetTextWidth( Text:string ): integer;
   { Return the width of the text contained in 'Text' in pixels }
begin
	if Length(Text) <> 0 then
		Result := Round(TheCanvas.TextWidth( Text ) / ScaleByValue)
  else
  	Result := 0;
  if LargeFontsOn then
  	Result := Round(Result / 1.25);
end;

function TMWPrintObject.GetTextWidthInches( Text:string ): double;
   { Return the width of the text contained in 'Text' in inches }
begin
	Result := PixelsToInchesHorizontal(GetTextWidth( Text ));
//  if LargeFontsOn then
//  	Result := Round(Result / 1.25);
end;

function TMWPrintObject.GetTextWidthMM( Text: string ): double;
   { Return the width of the text contained in 'Text' in mm }
begin
	result := PixelsToMMHorizontal(GetTextWidth( Text ));
end;

function TMWPrintObject.GetYPosition: double;
{ Returns the current vertical position of pen on the canvas }
begin
	case Measure of
  	mtInches: result := LastYPosition;
    mtPixels: result := InchesToPixelsVertical(LastYPosition);
    mtMM: result := InchesToMM(LastYPosition);
  else
  	result := 0.0;
  end;
end;

procedure TMWPrintObject.IncBar(x: integer);
{ Increments the progress bar value by X }
begin
	if Not PrintingOK then
  	exit;
//	if UseProgress then
//		TMWProgressBar.IncBar(x);
  if fProgressBar <> nil then
  	fProgressBar.Position := fProgressBar.Position + x;
end;

function TMWPrintObject.InchesToPixelsHorizontal( Inches: double ): integer;
   { Convert the horizontal inches represented in 'Inches' to pixels }
var
	Value: double;

begin
	Value := Inches * PixelsPerInchHorizontal * ScaleByValue;
  Result := Round(Value);
end;

function TMWPrintObject.InchesToPixelsVertical( Inches: double ): integer;
   { Convert the vertical inches represented in 'Inches' to pixels }
var
	Value: double;

begin
	Value := Inches * PixelsPerInchVertical * ScaleByValue;
  Result := Round(Value);
end;

procedure TMWPrintObject.Increment;
{ Increment the progress bar with the value of ProgressInc }
begin
	if Not PrintingOK then
  	exit;
//	if UseProgress then
//  	TMWProgressBar.IncBar(ProgressInc);
  if fProgressBar <> nil then
  	fProgressBar.StepIt;
  SetTheProgressCaption;
end;

function TMWPrintObject.LinesToPixels( Line:integer ): integer;
   { Calculate the number of vertical pixels in 'Line' }
begin
	if ( Line <= 0 ) then
  	Line := 1;
  Result := (Line-1) * CalculateLineHeight;
end;

procedure TMWPrintObject.LineTo(X1,Y1: double);
var
	ScreenToPrinter: double;

begin
	if DryRun or ImagePrinting then
  case Measure of
  	mtInches:
    	begin
      	X1 := InchesToPixelsHorizontal(X1); Y1 := InchesToPixelsVertical(Y1);
      end;
    mtMM:
    	begin
      	X1 := InchesToPixelsHorizontal(MMToInches(X1)); Y1 := InchesToPixelsVertical(MMToInches(Y1));
      end;
  end;
	if DryRun then
		Pages.StoreLineTo(X1,Y1);
  if PixelsPerInchHorizontal > PixelsPerInchVertical then
  	ScreenToPrinter := PixelsPerInchHorizontal / Screen.PixelsPerInch
  else
  	ScreenToPrinter := PixelsPerInchVertical / Screen.PixelsPerInch;
	TheCanvas.LineTo(Round(X1*ScreenToPrinter*ScaleByValue)-GutterLeft,
  								 Round(Y1*ScreenToPrinter*ScaleByValue)-GutterTop);
end;

function TMWPrintObject.MMToPixelsHorizontal( MM: double): integer;
begin
	result := InchesToPixelsHorizontal(MMToInches(MM));
end;

function TMWPrintObject.MMToPixelsVertical( MM: double): integer;
begin
	result := InchesToPixelsVertical(MMToInches(MM));
end;

procedure TMWPrintObject.MoveTo(X1,Y1: double);
var
	ScreenToPrinter: double;

begin
	if DryRun or ImagePrinting then
  case Measure of
  	mtInches:
    	begin
      	X1 := InchesToPixelsHorizontal(X1); Y1 := InchesToPixelsVertical(Y1);
      end;
    mtMM:
    	begin
      	X1 := InchesToPixelsHorizontal(MMToInches(X1)); Y1 := InchesToPixelsVertical(MMToInches(Y1));
      end;
  end;
	if DryRun then
		Pages.StoreMoveTo(X1,Y1);
  if PixelsPerInchHorizontal > PixelsPerInchVertical then
  	ScreenToPrinter := PixelsPerInchHorizontal / Screen.PixelsPerInch
  else
  	ScreenToPrinter := PixelsPerInchVertical / Screen.PixelsPerInch;
	TheCanvas.MoveTo(Round(X1*ScreenToPrinter*ScaleByValue)-GutterLeft,
  								 Round(Y1*ScreenToPrinter*ScaleByValue)-GutterTop);
end;

procedure TMWPrintObject.NewLines( Number:word );
   { Generate the number of line feeds represented in 'Number' }
var
	I: word;

begin
	if Not PrintingOK then
  	exit;
	for I := 1 to Number do
	begin
  	NextLine;
    if (abs(LastYPosition - DetailTop) < 0.001) then
    	break;
  end;
end;

procedure TMWPrintObject.NewPage;
   { Issue a new page }
var
	oldY: double;

begin
	if ImagePrinting or Not PrintingOK then
  	exit;
  oldY := LastYPosition;
  SaveCurrentFont;
	WriteHeader;
  WriteFooter;
  WritePageNumber;
  OnPageChange;
  if DryRun then
  begin
 		Pages.NewPage;
   	inc(Pages.TotalPages);
 		LastYPosition := DetailTop - GetLineHeightInches;
  	LastXPosition := LeftMargin;
  end
  else if not PreviewMode then
  begin
  	if PageFeeding then
    begin
  		Printer.NewPage;
  		LastYPosition := DetailTop - GetLineHeightInches;
  		LastXPosition := LeftMargin;
    end;
  end;
  if DryRun or AutomaticPaging then
 		SetTopOfPage
  else
	  SetYPosition(oldY);
  AfterPageChange;
  RestoreCurrentFont;
end;

procedure TMWPrintObject.NextLine;
{ Advances pen pos to next line on canvas }
begin
	if Not PrintingOK then
  	exit;
  LastYPosition := LastYPosition + GetLineHeightInches;
 	if DryRun and AutoPaging and ( LastYPosition + GetLineHeightInches > (DetailBottom / ScaleByValue)) then
   	NewPage
  else
  if DryRun then
  	Pages.StoreGeneral(commNewLine);
  LastXPosition := LeftMargin;
end;

procedure TMWPrintObject.OnCancelPrint;
begin
//	TMWProgressBar.Hide;
	if MessageDlg('Abort printing?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
  	PrintingOK := false;
		if Not PrintingInternal then
			if assigned(FOnCancelPrint) then
    		FOnCancelPrint(self);
  end;
//  TMWProgressBar.Show;
end;

procedure TMWPrintObject.OnPageChange;
var
	oldPage: boolean;

begin
	oldPage := AutomaticPaging;
  SetAutoPaging(false);
	if assigned(FPageChange) then FPageChange(self);
  SetAutoPaging(oldPage);
end;

procedure TMWPrintObject.PageFeed;
begin
  if DryRun then
  begin
 		Pages.NewPage;
    inc(Pages.TotalPages);
  end
  else if not PreviewMode then
 		Printer.NewPage;
end;

procedure TMWPrintObject.Pie(X1,Y1,X2,Y2,X3,Y3,X4,Y4: double);
var
	ScreenToPrinter: double;

begin
  if DryRun or ImagePrinting then
  case Measure of
  	mtInches:
    	begin
      	X1 := InchesToPixelsHorizontal(X1); Y1 := InchesToPixelsVertical(Y1);
      	X2 := InchesToPixelsHorizontal(X2); Y2 := InchesToPixelsVertical(Y2);
      	X3 := InchesToPixelsHorizontal(X3); Y3 := InchesToPixelsVertical(Y3);
      	X4 := InchesToPixelsHorizontal(X4); Y4 := InchesToPixelsVertical(Y4);
      end;
    mtMM:
    	begin
      	X1 := InchesToPixelsHorizontal(MMToInches(X1)); Y1 := InchesToPixelsVertical(MMToInches(Y1));
      	X2 := InchesToPixelsHorizontal(MMToInches(X2)); Y2 := InchesToPixelsVertical(MMToInches(Y2));
      	X3 := InchesToPixelsHorizontal(MMToInches(X3)); Y3 := InchesToPixelsVertical(MMToInches(Y3));
      	X4 := InchesToPixelsHorizontal(MMToInches(X4)); Y4 := InchesToPixelsVertical(MMToInches(Y4));
      end;
  end;
	if DryRun then
  	Pages.StorePie(X1,Y1,X2,Y2,X3,Y3,X4,Y4);
  if PixelsPerInchHorizontal > PixelsPerInchVertical then
  	ScreenToPrinter := PixelsPerInchHorizontal / Screen.PixelsPerInch
  else
  	ScreenToPrinter := PixelsPerInchVertical / Screen.PixelsPerInch;
	TheCanvas.Pie(Round(X1*ScreenToPrinter*ScaleByValue)-GutterLeft,
  							Round(Y1*ScreenToPrinter*ScaleByValue)-GutterTop,
  							Round(X2*ScreenToPrinter*ScaleByValue)-GutterLeft,
                Round(Y2*ScreenToPrinter*ScaleByValue)-GutterTop,
  							Round(X3*ScreenToPrinter*ScaleByValue)-GutterLeft,
                Round(Y3*ScreenToPrinter*ScaleByValue)-GutterTop,
                Round(X4*ScreenToPrinter*ScaleByValue)-GutterLeft,
                Round(Y4*ScreenToPrinter*ScaleByValue)-GutterTop);
end;

function TMWPrintObject.PixelsToMeasurementH( Pixels: double ): double;
begin
	case Measurement of
  	mtMM: Pixels := PixelsToMMHorizontal( Pixels );
    mtInches: Pixels := PixelsToInchesHorizontal( Pixels );
  end;
  result := Pixels;
end;

function TMWPrintObject.PixelsToMeasurementV( Pixels: double ): double;
begin
	case Measurement of
  	mtMM: Pixels := PixelsToMMVertical( Pixels );
    mtInches: Pixels := PixelsToInchesVertical( Pixels );
  end;
  result := Pixels;
end;

function TMWPrintObject.PixelsToMMHorizontal( Pixels: double): double;
begin
	result := InchesToMM(PixelsToInchesHorizontal(Pixels));
end;

function TMWPrintObject.PixelsToMMVertical( Pixels: double): double;
begin
	result := InchesToMM(PixelsToInchesVertical(Pixels));
end;

function TMWPrintObject.PixelsToInchesHorizontal( Pixels: double ): double;
{ Converts "Pixels" to inches using horizontal resolution }
begin
	Result := Pixels / PixelsPerInchHorizontal;
end;

function TMWPrintObject.PixelsToInchesVertical( Pixels: double ): double;
{ Converts "Pixels" to inches using vertical resolution }
begin
	Result := Pixels / PixelsPerInchVertical;
end;

procedure TMWPrintObject.PrintFromPreview;
{ Used to print the actual commands that were stored either from the preview
  form or directly when Quit is called to end the print job. }
var
	x: integer;
  xrInc, xrCurrent: double;
  oldCanvas: TCanvas;

begin
	{ the following code checks to see if you are printing to a file
  	this is still work in progress.}
{
	if fSaveToFile then
  begin
  	if (fFileName <> '') then
  		Pages.TMWSaveToFile(fFileName)
    else
    	ShowMessage('Must have valid filename to file.');
  	PreviewMode := true;
 		BarShowing := false;
 		ImagePrinting := false;
 		IsPrinting := false;
 		exit;
  end;
}
try
	AutomaticPaging := false;
	WritePrinterSpecs(false);
	if ShowDialog then
		if not Pages.SetPrintOptions then
  		exit;
	PreviewMode := false;
  xrInc := 100 / ((Pages.ToPage + 1) - Pages.FromPage);
  xrCurrent := 0.0;
  if fProgressBar <> nil then
  begin
  	fProgressBar.Position := 0;
  	fProgressBar.Max := abs(Pages.FromPage - Pages.ToPage) + 1;
    fProgressBar.Step := 1;
  end;
  if fProgressCaption <> nil then
  	if fProgressCaption is TLabel then
    	TLabel(fProgressCaption).Caption := LoadStr(PRINTCAPTIONTEXT)
    else if fProgressCaption is TEdit then
    	TEdit(fProgressCaption).Text := LoadStr(PRINTCAPTIONTEXT);
  IsPrinting := true;
  oldCanvas := TheCanvas;
  if assigned(FStartPrint) then
  	FStartPrint(self);
  with Printer do
  begin
  	if DocumentTitle <> '' then
 			Title := DocumentTitle
    else
    	Title := '***';
 		BeginDoc;
  end;
 	TheCanvas := Printer.Canvas;
  OriginalFont := SelectObject(TheCanvas.Handle,OriginalFont);
 	CalculateMeasurements;
  if assigned(FFirstPage) then
  	FFirstPage(self);
 	for x := Pages.FromPage to Pages.ToPage do
 	begin
 		PrintPage(Pages.Get(x),x);
   	if (x < Pages.ToPage) and PageFeeding then
   	begin
 			Printer.NewPage;
   		SetTopOfPage;
   	end;
   	xrCurrent := xrCurrent + xrInc;
    if fProgressBar <> nil then
    	fProgressBar.StepIt;
   	Application.ProcessMessages;
   	if Not PrintingOK then
   		break;
 	end;
  if assigned(FLastPage) then
  	FLastPage(self);
  if fProgressBar <> nil then
  	fProgressBar.StepIt;
  SetFontAngle(0);
 	Printer.EndDoc;
  if assigned(FEndPrint) then
  	FEndPrint(self);
  TheCanvas := oldCanvas;
  if fProgressCaption <> nil then
  	if fProgressCaption is TLabel then
    	TLabel(fProgressCaption).Caption := ''
    else if fProgressCaption is TEdit then
    	TEdit(fProgressCaption).Text := '';
  PreviewMode := true;
  BarShowing := false;
  ImagePrinting := false;
  IsPrinting := false;
except
	on E: Exception do
  	ShowMessage('Error: ' + E.Message);
end;
end;

procedure TMWPrintObject.PrintGraphic(X,Y,W,H: double;thePicture: TImage);
{ Used to copy contents of TImage to printing canvas }
var
  x1,x2,y1,y2: integer;
  ScreenToPrinter: double;

begin
	if Not PrintingOK then
  	exit;
  if DryRun or ImagePrinting then
  	case Measure of
    	mtPixels:
      	begin
        	X := PixelsToInchesHorizontal(Round(X)); Y := PixelsToInchesVertical(Round(Y));
          W := PixelsToInchesHorizontal(Round(W)); H := PixelsToInchesVertical(Round(H));
        end;
      mtMM:
      	begin
        	X := MMToInches(X); Y := MMToInches(Y);
          W := MMToInches(W); H := MMToInches(H);
        end;
    end;
	if DryRun then
  begin
  	Pages.StoreGraphic(X,Y,W,H,thePicture);
    exit;
  end;
  if PixelsPerInchHorizontal > PixelsPerInchVertical then
  	ScreenToPrinter := PixelsPerInchHorizontal / Screen.PixelsPerInch
  else
  	ScreenToPrinter := PixelsPerInchVertical / Screen.PixelsPerInch;
  if W = -1.0 then
  	x2 := Round(thePicture.Width * ScreenToPrinter * ScaleByValue)
  else
  	x2 := Round(InchesToPixelsHorizontal(W));
  W := PixelsToInchesHorizontal(x2)/ScaleByValue;
  if X = -1.0 then
  	if TotalPageWidthPixels > InchesToPixelsHorizontal(W) then
    	x1 := Round(((TotalPageWidthPixels*ScaleByValue) -
      							InchesToPixelsHorizontal(W))-GutterLeft) div 2
    else
    	x1 := 0
  else
		x1 := Round(InchesToPixelsHorizontal(X) - GutterLeft);
  if H = -1.0 then
  	y2 := Round(thePicture.Height * ScreenToPrinter * ScaleByValue)
  else
  	y2 := Round(InchesToPixelsVertical(H));
  H := PixelsToInchesVertical(y2)/ScaleByValue;
  if Y = -1.0 then
  	if TotalPageHeightPixels > InchesToPixelsVertical(H) then
    	y1 := Round(((TotalPageHeightPixels*ScaleByValue) -
      							InchesToPixelsVertical(H))-GutterTop) div 2
    else
     	y1 := 0
  else
  	y1 := Round(InchesToPixelsVertical(Y) - GutterTop);
	if ImagePrinting or (thePicture.Picture.Graphic.ClassName = 'TIcon') then
		TheCanvas.StretchDraw(rect(x1,y1,x1+x2,y1+y2),thePicture.Picture.Graphic)
  else if thePicture.Picture.Graphic.ClassName = 'TBitmap' then
  	BltTBitmapAsDib(TheCanvas.Handle,x1,y1,x2,y2,thePicture.Picture.Bitmap);
end;

procedure TMWPrintObject.PrintPage(Page: TMWPageList;iPage: integer);
{ This procedure will loop through a given pages command list and output that
  information to the current printing canvas }
var
	x,y: integer;
  oldColor: TColor;
  tCommand: TMWPrintCommand;
  Buffer: string;
  SkipNext: integer;

begin
	SkipNext := 0;
  if PageFeeding then
  	SetTopOfPage;
  for x := 1 to Page.Count do
  begin
  	if SkipNext = 0 then
    begin
  	tCommand := Page.Get(x);
    case tCommand.Command of
      commLine:
      	try
      	with tCommand as TMWLine do
        	DrawLine(X1,Y1,X2,Y2,LineWidth);
        except
        	ShowMessage('Error in Line Drawing command.');
        end;
      commNewLine:
      	try
        	NextLine;
        except
        	ShowMessage('Error in Next Line command.');
        end;
      commFColor:
      	try
        with tCommand as TMWFColor do
        	SetFontColor(Color);
        except
        	ShowMessage('Error in Font Color change.');
        end;
      commBColor:
      	try
        with tCommand as TMWBColor do
        	SetBrushColor(Color);
        except
        	ShowMessage('Error in Brush Color change.');
        end;
      commPColor:
      	try
        with tCommand as TMWPColor do
        	SetPenColor(Color);
        except
        	ShowMessage('Error in Pen Color change.');
        end;
      commGraphic:
      	try
      	with tCommand as TMWGraphic do
        	PrintGraphic(X,Y,Height,Width,Bitmap);
        except
        	ShowMessage('Error in Graphics Drawing routine.');
        end;
      commDetailArea:
      	try
      	with tCommand as TMWDetail do
        	SetDetailTopBottom(X,Y);
        except
        	ShowMessage('Error in Setting Detail Top/Bottom settings.');
        end;
      commFont:
      	try
      	with tCommand as TMWFont do
        	SetFontInfo(Font);
        except
        	ShowMessage('Error in Changing Font information');
        end;
      commFooterDim:
      	try
      	with tCommand as TMWFooterDim do
        	SetFooterDim(X1,Y1,X2,Y2,Boxed,LineWidth,Shading);
        except
        	ShowMessage('Error in Setting Footer Dimensions.');
        end;
      commFooterInf:
      	try
      	with tCommand as TMWFooterInf do
        	SetFooterInfo(Line,yPosition,Text,Alignment,Font);
        except
        	ShowMessage('Error in Setting Footer Information.');
        end;
      commHeaderDim:
      	try
      	with tCommand as TMWHeaderDim do
        	SetHeaderDim(X1,Y1,X2,Y2,Boxed,LineWidth,Shading);
        except
        	ShowMessage('Error in Setting Header Dimensions.');
        end;
      commHeaderInf:
      	try
      	with tCommand as TMWHeaderInf do
        	SetHeaderInfo(Line,yPosition,Text,Alignment,Font);
        except
        	ShowMessage('Error in Setting Header Information.');
        end;
      commLineWidth:
      	try
      	with tCommand as TMWLineWidth do
        	SetLineWidth(LineWidth);
        except
        	ShowMessage('Error in Setting Line Width.');
        end;
      commMargins:
      	try
      	with tCommand as TMWMargins do
        	SetMargins(X1,Y1,X2,Y2);
        except
        	ShowMessage('Error in Setting Margins.');
        end;
      commOrient:
      	try
      	with tCommand as TMWOrient do
        	PageOrientation := Orientation;
        except
        	ShowMessage('Error in Setting Page Orientation.');
        end;
      commWritePage:
      	try
        	y := 1;
          tCommand := Page.Get(x+y);
          inc(y);
          while tCommand.Command <> commText do
          begin
          	if tCommand.Command = commTab then
      				with tCommand as TMWTab do
        				SetTab(Tab);
          	if tCommand.Command = commWriteRight then
          		with tCommand as TMWWriteRight do
          			self.WriteLineRight(Y, Text);
          	if tCommand.Command = commMeasure then
	          	with tCommand as TMWMeasure do
  	          	SetMeasure(MeasureType(Measure));
            if tCommand.Command = commSetY then
          		with tCommand as TMWSetY do
          			SetYPosition(YPosition);
          	if tCommand.Command = commMeasure then
          		with tCommand as TMWMeasure do
            		SetMeasure(MeasureType(Measure));
            tCommand := Page.Get(x+y);
            inc(SkipNext);
            inc(y);
          end;
          with tCommand as TMWText do
          begin
						Buffer := Format( PageNumber.Text,[iPage] );
  					if PageNumber.ShowTotalPages then
  						Buffer := Buffer + ' sur ' + IntToStr(Pages.TotalPages);
            WriteLine(X,Y,Buffer);
          end;
          inc(SkipNext);
        except
        	ShowMessage('Error writing page number information.');
				end;
      commPageNumber:
      	try
      	with tCommand as TMWPageNumber do
        	SetPageNumberInfo(yPosition,Text,Alignment,IncludeTotal,Font);
        except
        	ShowMessage('Error Setting Page Number Information.');
        end;
      commTab:
      	try
      	with tCommand as TMWTab do
        	SetTab(Tab);
        except
        	ShowMessage('Error Setting Tab.');
        end;
      commTopOfPage:
      	try
      		SetTopOfPage;
        except
        	ShowMessage('Error Setting Top of Page.');
        end;
      commSetY:
      	try
      	with tCommand as TMWSetY do
        	SetYPosition(yPosition);
        except
        	ShowMessage('Error Setting Vertical Position.');
        end;
      commText:
      	try
      	with tCommand as TMWText do
        begin
        	oldColor := TheCanvas.Brush.Color;
        	TheCanvas.Brush.Color := BrushColor;
        	WriteLine(X,Y,Text);
          TheCanvas.Brush.Color := oldColor;
        end;
      	except
        	ShowMessage('Error Writing Line of Text.');
        end;
      commColumn:
      	try
      	with tCommand as TMWColumn do
        	CreateColumn(Number,XPosition,Length);
        except
        	ShowMessage('Error Creating Column Setting.');
        end;
      commAutoPageTrue:
      	SetAutoPaging(true);
      commAutoPageFalse:
      	SetAutoPaging(false);
      commSaveY:
      	SaveCurrentY;
      commRestoreY:
      	RestoreCurrentY;
      commMoveTo:
      	try
        	with tCommand as TMWGraphicPoint do
          	MoveTo(X1,Y1);
        except
        	ShowMessage('Error in MoveTo command.');
        end;
      commLineTo:
      	try
        	with tCommand as TMWGraphicPoint do
          	LineTo(X1,Y1);
        except
        	ShowMessage('Error in LineTo command.');
        end;
      commEllipse:
      	try
        	with tCommand as TMWEllipse do
          	Ellipse(X1,Y1,X2,Y2);
        except
        	ShowMessage('Error in Ellipse command.');
        end;
			commBrushStyle:
      	try
        	with tCommand as TMWBrushStyle do
          	SetBrushStyle(Style);
        except
        	ShowMessage('Error Setting Brush Style.');
        end;
      commFillRect:
      	try
        	with tCommand as TMWFillRect do
          	FillRect(X1,Y1,X2,Y2);
        except
        	ShowMessage('Error in FillRect command.');
        end;
      commFloodFill:
      	try
        	with tCommand as TMWFloodFill do
          	FloodFill(X,Y,Color,FillStyle);
        except
        	ShowMessage('Error in FloodFill command.');
      	end;
      commFrameRect:
      	try
        	with tCommand as TMWFrameRect do
          	FrameRect(X1, Y1, X2, Y2);
        except
        	ShowMessage('Error in FrameRect command.');
        end;
      commPie:
      	try
        	with tCommand as TMWPieArc do
          	Pie(X1,Y1,X2,Y2,X3,Y3,X4,Y4);
        except
        	ShowMessage('Error in Pie command.');
        end;
      commArc:
      	try
        	with tCommand as TMWPieArc do
          	Arc(X1,Y1,X2,Y2,X3,Y3,X4,Y4);
        except
        	ShowMessage('Error in Arc command.');
        end;
      commPolyLine:
      	try
        	with tCommand as TMWPolygon do
          	PolyLine(slice(Points,Num));
        except
        	ShowMessage('Error in PolyLine command.');
        end;
      commPolygon:
      	try
        	with tCommand as TMWPolygon do
          	Polygon(slice(Points,Num));
        except
        	ShowMessage('Error in Polygon command.');
        end;
      commPStyle:
      	try
        	with tCommand as TMWPStyle do
          	self.SetPenStyle(Style);
        except
        	ShowMessage('Error setting pen style.');
        end;
      commPMode:
      	try
        	with tCommand as TMWPMode do
          	self.SetPenMode(Mode);
        except
        	ShowMessage('Error setting pen mode.');
        end;
      commFontAngle:
      	try
        	with tCommand as TMWFontAngle do
          	self.SetFontAngle(Angle);
        except
        	ShowMessage('Error setting font angle.');
        end;
      commColRight:
      	try
        	with tCommand as TMWColRight do
          	self.WriteLineColumnRight(ColumnNumber, Y, Text);
        except
        	ShowMessage('Error writing right justified column text.');
        end;
      commWriteRight:
      	try
        	with tCommand as TMWWriteRight do
          	self.WriteLineRight(Y, Text);
        except
        	ShowMessage('Error writing right justified text.');
        end;
      commIndent:
      	try
        	with tCommand as TMWIndent do
          	self.SetIndent(Indent);
        except
        	ShowMessage('Error setting indent value.');
        end;
      commTransparent:
      	try
        	with tCommand as TMWTransparent do
          	self.SetTransparent(OnOff);
        except
        	ShowMessage('Error setting transparent mode.');
        end;
    end
    end
    else
    	dec(SkipNext);
  end;
end;

procedure TMWPrintObject.PolyLine(Points: array of double);
var
	x,y: integer;
  ScreenToPrinter: double;

begin
	if DryRun or ImagePrinting then
  	for x := low(Points) to High(Points) do
  		case Measure of
    		mtInches: Points[x] := InchesToPixelsHorizontal(Points[x]);
        mtMM: Points[x] := MMToPixelsHorizontal(Points[x]);
      end;
	if DryRun then
  	Pages.StorePolyLine(Points);
  if PixelsPerInchHorizontal > PixelsPerInchVertical then
  	ScreenToPrinter := PixelsPerInchHorizontal / Screen.PixelsPerInch
  else
  	ScreenToPrinter := PixelsPerInchVertical / Screen.PixelsPerInch;
  for x := low(Points) to high(Points) do
  	Points[x] := Round(Points[x] * ScaleByValue*ScreenToPrinter) - GutterLeft;
	y := 0;
  x := low(Points);
  while x < high(Points) do
  begin
		PointArray[y].X := Round(Points[x]);
    PointArray[y].Y := Round(Points[x+1]);
    inc(x,2);
    inc(y);
  end;
  TheCanvas.PolyLine(slice(PointArray,y));
end;

procedure TMWPrintObject.Polygon(Points: array of double);
var
	x,y: integer;
  ScreenToPrinter: double;

begin
	if DryRun or ImagePrinting then
  	for x := low(Points) to High(Points) do
  		case Measure of
    		mtInches: Points[x] := InchesToPixelsHorizontal(Points[x]);
        mtMM: Points[x] := MMToPixelsHorizontal(Points[x]);
      end;
	if DryRun then
  	Pages.StorePolygon(Points);
  if PixelsPerInchHorizontal > PixelsPerInchVertical then
  	ScreenToPrinter := PixelsPerInchHorizontal / Screen.PixelsPerInch
  else
  	ScreenToPrinter := PixelsPerInchVertical / Screen.PixelsPerInch;
  for x := low(Points) to high(Points) do
  	Points[x] := Round(Points[x]*ScreenToPrinter*ScaleByValue)-GutterLeft;
	y := 0;
  x := low(Points);
  while x < high(Points) do
  begin
		PointArray[y].X := Round(Points[x]);
    PointArray[y].Y := Round(Points[x+1]);
    inc(x,2);
    inc(y);
  end;
  TheCanvas.Polygon(slice(PointArray,y));
end;

procedure TMWPrintObject.Quit;
   { 'Quit' must always be called when printing is completed. If preview
   		mode is set, then it displays the preview form. }
var
	oldPaging: boolean;
  oldMeasure: MeasureType;

begin
	if fSnakeColumns then
  	SnakeColumnsOff;
	if ImagePrinting then
  begin
  	PrinterCanvas := nil;
  	PrintingOK := false;
  	exit;
  end;
	if PrintingOK then
  begin
		try
			WriteHeader;
  		WriteFooter;
  		WritePageNumber;
  		OnPageChange;
  	except
  		ShowMessage('Error in completing last page.');
  	end;
  	DryRun := false;
  	try
  		if UseProgress then
  		begin
      	if fProgressBar <> nil then
        	fProgressBar.Hide;
        if fProgressCaption <> nil then
        	fProgressCaption.Hide;
        Application.ProcessMessages;
  		end;
    	BarShowing := false;
  		Pages.FromPage := 1;
  		Pages.ToPage := Pages.Count;
  	except
  		ShowMessage('Error preparing final report.');
  	end;
    oldPaging := AutomaticPaging;
    AutomaticPaging := false;
    SetFontAngle(0);
    oldMeasure := Measure;
    Measure := mtInches;
		try
  		if ActualPreview then
    		ShowPreview
  		else
  			PrintFromPreview;
  	except
  		ShowMessage('Error showing/printing final report.');
  	end;
    Measure := oldMeasure;
    AutomaticPaging := oldPaging;
  end
  else
  begin
    BarShowing := false;
    if UseProgress then
    begin
    	if fProgressBar <> nil then
      	fProgressBar.Hide;
      if fProgressCaption <> nil then
      	fProgressCaption.Hide;
      Application.ProcessMessages;
    end;
  end;
  try
  	Cleanup;
    if Pages <> nil then
  		Pages.Destroy;
    Pages := nil;
  except
  	on E: Exception do
  		ShowMessage('Error cleaning up report pages.' + chr(10) + E.Message);
  end;
  PrintingOK := false;
  WritePrinterSpecs(true);
  if Assigned(FPrintDone) then
  	FPrintDone(self);
end;

procedure TMWPrintObject.ReadPrinterSpecs(SaveState: boolean);
var
	MyHandle: THandle;
  MyDevMode: pDevMode;
  MyDevice,
  MyDriver,
  MyPort: array [0..255] of char;

begin
	if Not PrintingOK or ImagePrinting then
  	exit;
	Printer.GetPrinter(MyDevice,MyDriver,MyPort,MyHandle);
  MyDevMode := GlobalLock(MyHandle);
  try
  	IsColor := (MyDevMode^.dmFields and DM_COLOR) <> 0;
  	MyDevMode^.dmFields := MyDevMode^.dmFields or (DM_PAPERSIZE or DM_ORIENTATION or DM_COLOR);
    if Not SaveState then
    begin
    	PaperSize := PaperSizes(MyDevMode^.dmPaperSize-1);
    	if MyDevMode^.dmOrientation = DMORIENT_LANDSCAPE then
    		Orientation := poLandscape
    	else
    		Orientation := poPortrait;
    end
    else
    begin
    	OrigPaperSize := MyDevMode^.dmPaperSize;
      OrigPaperOrient := MyDevMode^.dmOrientation;
    end;
  finally
  	GlobalUnLock(MyHandle);
  end;
end;


procedure Register;
{ Register this component under the System Tab }
begin
  RegisterComponents('System', [TMWPrintObject]);
end;

procedure TMWPrintObject.RestoreCurrentFont;
{ Restores the font information after being saved }
begin
	if Not PrintingOK then
  	exit;
  if (CurrentFontRecord in [1..HeaderLines]) then
  begin
		SetFontInfo( CurrentFonts[CurrentFontRecord].Font );
    CurrentFonts[CurrentFontRecord].Font.Free;
    CurrentFonts[CurrentFontRecord].Font := nil;
		dec(CurrentFontRecord);
  end;
end;

procedure TMWPrintObject.RestoreCurrentY;
begin
	if CurrentYRecord in [1..10] then
  	LastYPosition := CurrentYPosition[CurrentYRecord];
  if DryRun then
  	Pages.StoreGeneral(commRestoreY);
  if CurrentYRecord > 0 then
  	dec(CurrentYRecord);
end;

procedure TMWPrintObject.SaveCurrentFont;
{ Saves the current font information }
begin
	if Not PrintingOK then
  	exit;
	inc(CurrentFontRecord);
  if CurrentFontRecord in [1..HeaderLines] then
  begin
  	if CurrentFonts[CurrentFontRecord].Font = nil then
    	CurrentFonts[CurrentFontRecord].Font := TFont.Create;
  	with CurrentFonts[CurrentFontRecord].Font do
    begin
  		Name := TheCanvas.Font.Name;
      Size := TheCanvas.Font.Size;
      Style := TheCanvas.Font.Style;
      Color := TheCanvas.Font.Color;
    end;
  end;
end;

procedure TMWPrintObject.SaveCurrentY;
begin
	inc(CurrentYRecord);
  if CurrentYRecord in [1..10] then
  	CurrentYPosition[CurrentYRecord] := LastYPosition;
  if DryRun then
  	Pages.StoreGeneral(commSaveY);
end;

procedure TMWPrintObject.SetAutoPaging( Value: boolean );
{ Controls whether automatic paging is used when reaching the end
  of the detail area of the page }
begin
	if DryRun then
  	if Value then
    	Pages.StoreGeneral(commAutoPageTrue)
    else
    	Pages.StoreGeneral(commAutoPageFalse);
	AutoPaging := Value;
end;

procedure TMWPrintObject.SetBrushColor(iColor: TColor);
begin
	if DryRun then
  	Pages.StoreBColor(iColor);
	TheCanvas.Brush.Color := iColor;
end;

procedure TMWPrintObject.SetBrushStyle(Style: TBrushStyle);
begin
	if DryRun then
  	Pages.StoreBStyle(Style);
	TheCanvas.Brush.Style := Style;
end;

procedure TMWPrintObject.SetDetailTopBottom( Top: double; Bottom: double );
{ Sets the top and bottom margins of the detail printing area of the
  report }
begin
	if Not PrintingOK then
  	exit;
  if DryRun or ImagePrinting then
  	case Measure of
    	mtPixels:
      	begin
        	Top := PixelsToInchesHorizontal(Round(Top));
          Bottom := PixelsToInchesVertical(Round(Bottom));
        end;
      mtMM:
      	begin
        	Top := MMToInches(Top);
          Bottom := MMToInches(Bottom);
        end;
    end;
	if DryRun then
  	Pages.StoreDetailArea(Top,Bottom);
	DetailTop := Top;
  DetailBottom := Bottom;
  LastYPosition := Top - GetLineHeightInches;
end;

procedure TMWPrintObject.SetFontAngle(Angle: integer);
// Angle is specified in degrees, not radians....
// Negative angles go clock-wise, positive angles go counter-clockwise...
begin
	if Not PrintingOK then
  	exit;
	if DryRun then
  	Pages.StoreFontAngle(Angle);
  RotateAngle := Angle;
  exit;
end;

procedure TMWPrintObject.SetFontColor(iColor: TColor);
begin
	if DryRun then
  	Pages.StoreFColor(iColor);
	TheCanvas.Font.Color := iColor;
end;

procedure TMWPrintObject.SetFontInfo( fFont: TFont );
   { Change the current font information }
begin
	if Not PrintingOK then
  	exit;
	if DryRun then
  	Pages.StoreFontChange(fFont);
  TheCanvas.Font.Assign(fFont);
  CalculateMeasurements;
end;

procedure TMWPrintObject.SetFontName(Name: string);
begin
	if Not PrintingOK then
  	exit;
	TheCanvas.Font.Name := Name;
	if DryRun then
  	Pages.StoreFontChange(TheCanvas.Font);
end;

procedure TMWPrintObject.SetFontSize(Size: word);
begin
	if Not PrintingOK then
  	exit;
	TheCanvas.Font.Size := Size;
	if DryRun then
  	Pages.StoreFontChange(TheCanvas.Font);
end;

procedure TMWPrintObject.SetFontStyle(Style: TFontStyles);
begin
	if Not PrintingOK then
  	exit;
	TheCanvas.Font.Style := Style;
	if DryRun then
  	Pages.StoreFontChange(TheCanvas.Font);
end;

procedure TMWPrintObject.SetFooterDim( XTop,YTop,XBottom,YBottom:double;
																						Boxed: boolean; LineWidth:word;
                                            Shading:TColor );
{ Sets the area of the page footer and whether it should be boxed and shaded }
begin
	if Not PrintingOK then
  	exit;
	FooterCoordinates.XTop := XTop;
  FooterCoordinates.XBottom := XBottom;
  FooterCoordinates.YTop := YTop;
  FooterCoordinates.YBottom := YBottom;
  FooterCoordinates.Boxed := Boxed;
  FooterCoordinates.LineWidth := LineWidth;
  FooterCoordinates.Shading := Shading;
  if DryRun or ImagePrinting then
  	case Measure of
    	mtPixels:
      	begin
        	XTop := PixelsToInchesHorizontal(Round(XTop));
          YTop := PixelsToInchesVertical(Round(YTop));
          XBottom := PixelsToInchesHorizontal(Round(XBottom));
          YBottom := PixelsToInchesVertical(Round(YBottom));
        end;
      mtMM:
      	begin
        	XTop := MMToInches(XTop); YTop := MMToInches(YTop);
          XBottom := MMToInches(XBottom); YBottom := MMToInches(YBottom);
        end;
    end;
	if DryRun then
  	Pages.StoreFooterDim(XTop,YTop,XBottom,YBottom,Boxed,LineWidth,Shading);
end;

procedure TMWPrintObject.SetFooterInfo( Line:integer; YPosition: double;
            Text:string; Alignment:word; Font: TFont );
{ Sets the footer information to be printed }
begin
	if Not PrintingOK then
  	exit;
	if ( Line > FooterLines ) then
  	Exit;
  Footer[Line].Text := Text;
  Footer[Line].YPosition := YPosition;
  Footer[Line].Alignment := Alignment;
  if Footer[Line].Font = nil then
  	Footer[Line].Font := TFont.Create;
  Footer[Line].Font.Assign(Font);
  if DryRun or ImagePrinting then
  	case Measure of
    	mtPixels: YPosition := PixelsToInchesVertical(Round(YPosition));
      mtMM: YPosition := MMToInches(YPosition);
  	end;
  if DryRun then
  	Pages.StoreFooterInf(Line,YPosition,Text,Alignment,Font.Name,Font.Size,Font.Style,Font.Color);
end;

procedure TMWPrintObject.SetHeaderDim( XTop,YTop,XBottom,YBottom:double;
																						Boxed: boolean; LineWidth:word;
                                            Shading:TColor );
{ Sets the area of the header for the page }
begin
	if Not PrintingOK then
  	exit;
	HeaderCoordinates.XTop := XTop;
  HeaderCoordinates.XBottom := XBottom;
  HeaderCoordinates.YTop := YTop;
  HeaderCoordinates.YBottom := YBottom;
  HeaderCoordinates.Boxed := Boxed;
  HeaderCoordinates.LineWidth := LineWidth;
  HeaderCoordinates.Shading := Shading;
  if DryRun or ImagePrinting then
  	case Measure of
    	mtPixels:
      	begin
        	XTop := PixelsToInchesHorizontal(Round(XTop));
          YTop := PixelsToInchesVertical(Round(YTop));
          XBottom := PixelsToInchesHorizontal(Round(XBottom));
          YBottom := PixelsToInchesVertical(Round(YBottom));
        end;
      mtMM:
      	begin
        	XTop := MMToInches(XTop); YTop := MMToInches(YTop);
          XBottom := MMToInches(XBottom); YBottom := MMToInches(YBottom);
        end;
    end;
	if DryRun then
  	Pages.StoreHeaderDim(XTop,YTop,XBottom,YBottom,Boxed,LineWidth,Shading);
end;

procedure TMWPrintObject.SetHeaderInfo( Line:integer; YPosition: double;
            Text:string; Alignment:word; Font: TFont );
{ Sets the header information to be printed }
begin
	if Not PrintingOK then
  	exit;
	if ( Line > HeaderLines ) then
		Exit;
  Header[Line].Text := Text;
  Header[Line].YPosition := YPosition;
  Header[Line].Alignment := Alignment;
  if Header[Line].Font = nil then
  	Header[Line].Font := TFont.Create;
  Header[Line].Font.Assign(Font);
  if DryRun or ImagePrinting then
  	case Measure of
    	mtPixels: YPosition := PixelsToInchesVertical(Round(YPosition));
      mtMM: YPosition := MMToInches(YPosition);
  	end;
  if DryRun then
  	Pages.StoreHeaderInf(Line,YPosition,Text,Alignment,Font.Name,Font.Size,Font.Style,Font.Color);
end;

procedure TMWPrintObject.SetIndent( Indent: double);
begin
	if DryRun then
  begin
		case Measurement of
  		mtMM: Indent := MMToInches(Indent);
    	mtPixels: Indent := PixelsToInchesHorizontal(Round(Indent));
  	end;
  	Pages.StoreIndent(Indent);
  end;
  CurrentIndent := Indent;
end;

procedure TMWPrintObject.SetLineWidth( Width:word );
{ Sets the current pen width for drawing }
begin
	if DryRun then
  	Pages.StoreLineWidth(Width);
  if ImagePrinting then
  	TheCanvas.Pen.Width := Width
  else
		TheCanvas.Pen.Width := Round(((Width * TotalPageWidthPixels) /
    																Printer.PageWidth) * ScaleByValue);
end;

procedure TMWPrintObject.SetPageMargins(XTop, YTop, XBottom, YBottom: double);
begin
	case Measure of
  	mtPixels:
    	SetMargins(YTop, TotalPageHeightPixels-YBottom,
      						XTop,TotalPageWidthPixels-XBottom);
  	mtMM:
    	SetMargins(YTop, ConvertMeasure(TotalPageHeightPixels,mtPixels,mtMM,
      						wtVertical)-YBottom,XTop,ConvertMeasure(TotalPageWidthPixels,
                  mtPixels,mtMM,wtHorizontal)-XBottom);
  	mtInches:
    	SetMargins(YTop, ConvertMeasure(TotalPageHeightPixels,mtPixels,mtInches,
      						wtHorizontal)-YBottom,XTop,ConvertMeasure(TotalPageWidthPixels,
                  mtPixels,mtInches,wtHorizontal)-XBottom);
  end;
end;

procedure TMWPrintObject.SetMargins( Top,Bottom,Left,Right:double );
   { Set the top, bottom, left and right margins in inches }
begin
   { If the sum of the left and right margins exceeds the width of the page,
     set the left margin to the value of 'GutterLeft' and set the right
     margin to the value of 'GutterRight' }
	if Not PrintingOK then
  	exit;
  if LargeFontsOn then
  begin
  	Top := Top * sqr(1.25);
    Bottom := Bottom * sqr(1.25);
    Left := Left * sqr(1.25);
    Right := Right * sqr(1.25);
  end;
  if DryRun or ImagePrinting then
  	case Measure of
    	mtPixels:
      	begin
        	Top := PixelsToInchesVertical(Round(Top));
          Bottom := PixelsToInchesVertical(Round(Bottom));
          Left := PixelsToInchesHorizontal(Round(Left));
          Right := PixelsToInchesHorizontal(Round(Right));
        end;
      mtMM:
      	begin
        	Top := MMToInches(Top); Bottom := MMToInches(Bottom);
          Left := MMToInches(Left); Right := MMToInches(Right);
        end;
    end;
  if ImagePrinting then
  begin
    TopMargin := InchesToPixelsVertical(Top);
    BottomMargin := InchesToPixelsVertical(Bottom);
    LeftMargin := InchesToPixelsHorizontal(Left);
    RightMargin := InchesToPixelsHorizontal(Right);
    CalculateMeasurements;
    exit;
  end;
	if DryRun then
  	Pages.StoreMargins(Top,Bottom,Left,Right);
	if ( Left + Right > TotalPageWidthInches ) then
  begin
  	Left := PixelsToInchesHorizontal(GutterLeft);
    Right := TotalPageWidthInches - PixelsToInchesHorizontal(GutterRight);
  end;
  if ( Left <= 0 ) then
  	Left := PixelsToInchesHorizontal(GutterLeft);
  if ( Right <= 0 ) then
  	Right := TotalPageWidthInches - PixelsToInchesHorizontal(GutterRight);
   { If the sum of the top and bottom margins exceeds the height of the
     page, set the top margin to the value of 'GutterTop' and set the
     bottom margin to the value of 'GutterBottom' }
  if ( Top + Bottom >= TotalPageHeightInches ) then
  begin
  	Top := PixelsToInchesVertical(GutterTop);
    Bottom := TOtalPageHeightInches - PixelsToInchesVertical(GutterBottom);
  end;
  if ( Top <= 0 ) then
  	Top := PixelsToInchesVertical(GutterTop);
  if ( Bottom <= 0 ) then
  	Bottom := TotalPageHeightInches - PixelsToInchesVertical(GutterBottom);
   { Convert everything to pixels }
  TopMargin := Round(InchesToPixelsVertical( Top ) * ScaleByValue);
  if ( TopMargin < GutterTop ) then
  	TopMargin := GutterTop;
  BottomMargin := Round(InchesToPixelsVertical( Bottom ) * ScaleByValue);
  if ( BottomMargin > TotalPageHeightPixels - GutterBottom ) then
  	BottomMargin := TotalPageHeightPixels - GutterBottom;
  LeftMargin := Round(InchesToPixelsHorizontal( Left ) * ScaleByValue);
  if ( LeftMargin < GutterLeft ) then
  	LeftMargin := GutterLeft;
  RightMargin := Round(InchesToPixelsHorizontal( Right ) * ScaleByValue);
  if ( RightMargin > TotalPageWidthPixels - GutterRight ) then
  	RightMargin := TotalPageWidthPixels - GutterRight;
end;

procedure TMWPrintObject.SetOrientation(Orient: TPrinterOrientation);
begin
	Orientation := Orient;
end;

procedure TMWPrintObject.SetPageNumberInfo( YPosition:double;
   Text:string; Alignment:word; IncludeTotal: boolean; Font:TFont );
{ Sets the manner of printing the page number. The "Text" parameter should be in
  the form of a format string }
begin
	if Not PrintingOK then
  	exit;
	PageNumber.Text := Text;
  PageNumber.YPosition := YPosition;
  PageNumber.Alignment := Alignment;
  if PageNumber.Font = nil then
  	PageNumber.Font := TFont.Create;
  PageNumber.Font.Assign(Font);
  PageNumber.ShowTotalPages := IncludeTotal;
  if DryRun or ImagePrinting then
  	case Measure of
    	mtPixels: YPosition := PixelsToInchesVertical(Round(YPosition));
      mtMM: YPosition := MMToInches(YPosition);
    end;
	if DryRun then
  	Pages.StorePageNumber(YPosition,Text,Alignment,IncludeTotal,
    											Font.Name,Font.Size,Font.Style,Font.Color);
end;

procedure TMWPrintObject.SetPaperSize(Size: PaperSizes);
begin
  PaperDimension := Size;
end;

procedure TMWPrintObject.SetPenColor(iColor: TColor);
begin
	if DryRun then
  	Pages.StorePColor(iColor);
	TheCanvas.Pen.Color := iColor;
end;

procedure TMWPrintObject.SetPenStyle(Style: TPenStyle);
begin
	if DryRun then
  	Pages.StorePStyle(Style);
	TheCanvas.Pen.Style := Style;
end;

procedure TMWPrintObject.SetPenMode(Mode: TPenMode);
begin
	if DryRun then
  	Pages.StorePMode(Mode);
	TheCanvas.Pen.Mode := Mode;
end;

procedure TMWPrintObject.SetPenWidth(iWidth: integer);
begin
	if DryRun then
  	Pages.StoreLineWidth(iWidth);
  TheCanvas.Pen.Width := iWidth;
end;

procedure TMWPrintObject.SetPreviewMode(Mode: boolean);
{ Sets the preview mode and canvas }
begin
	if Not PrintingOK then
  	exit;
	Case Mode of
  True:
  	begin
      ThePrinter := PreviewForm.GetCurrentPage;
    	TheCanvas := ThePrinter.Canvas;
    end;
  end;
  PreviewMode := Mode;
end;

procedure TMWPrintObject.SetPrnPrinter(Current: TImage);
{ Sets the current printing canvas of the preview form }
begin
	ThePrinter := Current;
  TheCanvas := ThePrinter.Canvas;
end;

procedure TMWPrintObject.SetProgressIncrement(x: integer);
{ Sets the progress bar increment to x }
begin
	if fProgressBar <> nil then
  	fProgressBar.Step := x;
end;

procedure TMWPrintObject.SetProgressMax(Max: integer);
{ Sets the progress bar max value to Max and resets the position to 0 }
begin
	ProgressBarMax := Max;
  if fProgressBar <> nil then
  begin
  	fProgressBar.Max := Max;
    fProgressBar.Position := 0;
  end;
end;

procedure TMWPrintObject.SetProgressPosition(X, Y: integer);
{ Sets the progress bar form to a set X,Y location on screen.
	This is an obsolete method and is no longer used. }
begin
	fProgressX := X;
  fProgressY := Y;
end;

procedure TMWPrintObject.SetTheProgressCaption;
{ Internal routine to set the text of the progress caption if
	enabled. It will add on the percentage done if ShowPercent is true }
var
	s: string;

begin
  s := fCurrentCaption;
  if fShowPercent and (fProgressBar <> nil) and (fProgressBar.Max <> 0) then
  	s := s + '  ' +	formatfloat('##0 %',
    			(fProgressBar.Position / fProgressBar.Max) * 100);
  if fProgressCaption <> nil then
  begin
  	if fProgressCaption is TLabel then
    	TLabel(fProgressCaption).Caption := s
    else if fProgressCaption is TEdit then
    	TEdit(fProgressCaption).Text := s;
  	Application.ProcessMessages;
  end;
end;

procedure TMWPrintObject.SetProgressText(s: string);
{ Sets the progress caption text by calling the internal SetTheProgressCaption }
begin
  if fProgressCaption <> nil then
  begin
  	fCurrentCaption := s;
    SetTheProgressCaption;
  end;
end;

procedure TMWPrintObject.SetScale(ScaleFactor: double);
{Sets the current scale multiplier}
begin
	ScaleByValue := ScaleFactor;
  CalculateMeasurements;
end;

procedure TMWPrintObject.SetShowTotalPages(Mode: boolean);
{ Sets whether total page numbers appears in page numbering }
begin
	PageNumber.ShowTotalPages := Mode
end;

procedure TMWPrintObject.SetTab( Inches:double );
{ Set a tab location on the page }
begin
	if Not PrintingOK then
  	exit;
 	if DryRun then
  begin
  	case Measurement of
    	mtMM: Inches := MMToInches(Inches);
      mtPixels: Inches := PixelsToInchesHorizontal(Round(Inches));
    end;
  	Pages.StoreTab(Inches);
  end;
  CurrentTab := Inches;
end;

procedure TMWPrintObject.SetTopOfPage;
{ Sets the printing canvas to the top of the detail area on the page }
begin
	if Not PrintingOK then
  	exit;
	if DryRun then
  	Pages.StoreGeneral(commTopOfPage);
  LastYPosition := DetailTop;
	LastXPosition := LeftMargin;
end;

procedure TMWPrintObject.SetYPosition( YPosition:double );
{ Sets the current line position on the printing canvas }
begin
	if Not PrintingOK then
  	exit;
  if DryRun or ImagePrinting then
  	case Measure of
    	mtPixels: YPosition := PixelsToInchesVertical(Round(YPosition));
      mtMM: YPosition := MMToInches(YPosition);
    end;
	if DryRun then
  	Pages.StoreSetY(YPosition);
	LastYPosition := YPosition;
end;

procedure TMWPrintObject.ShowPreview;
{ Displays the preview form }
{ This function is obsolete and should not be called. It is invoked internally
  now through the call to Quit. }
begin
	If not PreviewMode then
  	exit;
  PreviewForm.StartPercent := ord(PreviewPercent);
  PreviewForm.ShowModal;
end;


function TMWPrintObject.Start: boolean;
   { This function MUST be called first before any other printing function }
var
	Top,Bottom,Left,Right: double;
  I: integer;
  lf: TLogFont;

Begin
{Added this to implement the stored commands procedures. We force the printing to
 run through first in DryRun mode. This gives us the ability to store all print
 commands and then replay them when the Quit command is executed. If the preview
 mode is set, then we need to pass control to the preview form. It will drive the
 page printing through a procedure call hook that we set with OnPrintPage event of
 the preview object.}

  fCurrentCaption := '';
 	ImagePrinting := ImageCanvas <> nil;
  if not ImagePrinting and (Printer.Printers.Count = 0) then
  begin
  	ShowMessage('There are no printers installed.');
  	result := false;
    exit;
  end;
  result := true;
	PrintingOK := true;
  if not ImagePrinting then
  begin
  	PreviewForm := TPreviewForm.Create(nil);
    with PreviewForm do
    begin
    	Caption := LoadStr(PREVIEWFORMCAPTION);
    	CloseBtn.Caption := LoadStr(CLOSETEXT);
    	CloseBtn.Hint := LoadStr(CLOSEHINT);
      PrintBtn.Caption := LoadStr(PRINTTEXT);
      PrintBtn.Hint := LoadStr(PRINTHINT);
      ZoomLabel.Caption := LoadStr(ZOOMTEXT);
      FirstPage.Hint := LoadStr(FIRSTPAGEHINT);
      PrevPage.Hint := LoadStr(PREVPAGEHINT);
      NextPage.Hint := LoadStr(NEXTPAGEHINT);
      LastPage.Hint := LoadStr(LASTPAGEHINT);
    end;
  end;
  ReadPrinterSpecs(true); {first save the current printer specs to restore later}
  WritePrinterSpecs(false); {now set them to what we need}
	SetPreviewMode(not ImagePrinting);
 	Pages := TMWPages.Create;
 	Pages.NewPage;
 	Pages.FromPage := 1;
 	Pages.ToPage := 1;
  Pages.tPageHeight := PrinterSizes[ord(PaperDimension)+1].Height;
  Pages.tPageWidth := PrinterSizes[ord(PaperDimension)+1].Width;
	Pages.TotalPages := 1;
  DryRun := not ImagePrinting;
  ScaleByValue := 1.0;
  if fProgressBar <> nil then
  	fProgressBar.Step := ProgressInc;
  if UseProgress then
  begin
  	if fProgressBar <> nil then
    	fProgressBar.Show;
    if fProgressCaption <> nil then
    	fProgressCaption.Show;
  end;
  PrintingInternal := false;
  if not ImagePrinting then
  begin
 		PreviewForm.SetOrient(PageOrientation);
		PreviewForm.SetPreviewPrn(self);
 		SetPrnPrinter(PreviewForm.GetCurrentPage);
  end
  else
  	TheCanvas := ImageCanvas;
  CalculateMeasurements;
  PageNumber.Text := '';
  { The next section of code sets the default page margins and printing area. This is
  	done so that you can print without having to explicitly set them. }
  case Measure of
  	mtPixels:
    	begin
      	SetPageMargins(GutterLeft, GutterTop, GutterRight, GutterBottom);
        SetDetailTopBottom(GutterTop, TotalPageHeightPixels - GutterBottom);
      end;
    mtMM:
    	begin
      	SetPageMargins(PixelsToMMHorizontal(GutterLeft), PixelsToMMVertical(GutterTop),
    										PixelsToMMHorizontal(GutterRight), PixelsToMMVertical(GutterBottom));
        SetDetailTopBottom(PixelsToMMVertical(GutterTop),
        								PixelsToMMVertical(TotalPageHeightPixels - GutterBottom));
      end;
    mtInches:
    	begin
      	SetPageMargins(PixelsToInchesHorizontal(GutterLeft),
    										PixelsToInchesVertical(GutterTop),
                        PixelsToInchesHorizontal(GutterRight),
                        PixelsToInchesVertical(GutterBottom));
        SetDetailTopBottom(PixelsToInchesVertical(GutterTop),
        								PixelsToInchesVertical(TotalPageHeightPixels - GutterBottom));
      end;
  end;
  for I := 1 to HeaderLines do
  	Header[I].Text := '';
  HeaderCoordinates.Boxed := False;
  HeaderCoordinates.Shading := 0;
  for I := 1 to FooterLines do
  	Footer[I].Text := '';
  FooterCoordinates.Boxed := False;
  FooterCoordinates.Shading := 0;
  CurrentTab := 0.0;
  LastYPosition := 0.0;
  LastXPosition := 0.0;
  SetAutoPaging(AutoPaging);
  SetOrientation(Orientation);
  SetPaperSize(PaperDimension);
  OriginalFont := GetObject(TheCanvas.Handle,SizeOf(lf),@lf);
end;

procedure TMWPrintObject.SnakeColumnsOn(Cols: array of integer; StartCol: integer);
var
	x: integer;

begin
	// if 0 or 1 columns then no snaking needed...
	if High(Cols) = Low(Cols) then
  	exit;
  SnakeColumns := TStringList.Create;
  SnakeColumns.Sorted := false;
  for x := low(Cols) to high(Cols) do
  begin
  	if Cols[x] = StartCol then
    	fSnakeCurrentIndex := x;
  	SnakeColumns.Add(IntToStr(Cols[x]));
  end;
  fSnakeCurrentColumn := StartCol;
  fSnakeColumns := true;
end;

procedure TMWPrintObject.SnakeColumnsOff;
begin
	fSnakeColumns := false;
  SnakeColumns.Free;
end;

procedure TMWPrintObject.UpdateBar(x: integer);
{ Sets the current progress bar value }
begin
	if ImagePrinting then
  	exit;
	if Not PrintingOK then
  	exit;
  if fProgressBar <> nil then
  	fProgressBar.Position := x;
end;

procedure TMWPrintObject.WrapText(Text: string; var theText: TStringList; X,Y: double);
const
	CR = #13;
  LF = #10;
  CRLF = CR+LF;
var
	s: string;
  LastX, LastSpace,
  TextLength,
  CurrentX: integer;

begin
	s := '';
  LastX := 1;
  LastSpace := 0;
  Case Measure of
  	mtPixels:
    	begin
      	X := PixelsToInchesHorizontal(Round(X));
        Y := PixelsToInchesHorizontal(Round(Y));
      end;
    mtMM:
    	begin
      	X := MMToInches(X);
        Y := MMToInches(Y);
      end;
  end;
  X := X + PixelsToInchesHorizontal(4); // add some spacing...
  Y := Y - PixelsToInchesHorizontal(4);; // same as X...
  // put 2 spaces in place of TAB characters if any...
  while pos(chr(VK_TAB),Text) <> 0 do
  begin
  	Insert('  ',Text,pos(chr(VK_TAB),Text));
    Delete(Text,pos(chr(VK_TAB),Text),1);
  end;
  // replace carriage return/line feed pairs with just line feed...
  while pos(CRLF,Text) <> 0 do
  	delete(Text,pos(CRLF,Text)+1,1);
  // replace any stand alone carriage returns with line feeds...
  while pos(CR,Text) <> 0 do
  	Text[pos(CR,Text)] := LF;
  // remove any ending characters less than a space...
  while (Text <> '') and (Text[length(Text)] < #32) do
  	delete(Text,length(Text),1);
  TextLength := Length(Text);
  for CurrentX := 1 to TextLength do
  begin
  	if Text[CurrentX] in [LF] then
    	LastSpace := CurrentX
    else
    	s := s + Text[CurrentX];
  	if Text[CurrentX] = ' ' then
    	LastSpace := CurrentX;
    if (GetTextWidthInches(s) > (Y-X)) or (Text[CurrentX] in [LF]) then
    begin
    	s := copy(Text,LastX,LastSpace-LastX);
      if (s = '') and not (Text[CurrentX] in [LF]) then
      begin
      	s := copy(Text,LastX, CurrentX-1);
        LastSpace := CurrentX-1;
      end;
      theText.Add(s);
      LastX := LastSpace + 1;
      s := copy(Text,LastX,CurrentX - LastX);
    end;
  end;
  if theText.Count = 0 then
  	theText.Add(Text)
  else
  	theText.Add(copy(Text,LastX,TextLength));
end;

procedure TMWPrintObject.WriteFooter;
   { If any footers are defined, write them }
var
	I: integer;
  Temp: boolean;

begin
	if Not PrintingOK then
  	exit;
	SaveCurrentFont;
   { Set 'AutoPaging' off.  Otherwise the footer will not get written
     correctly. }
  Temp := AutoPaging;
   { Does the user desire a box around the footer? }
  if ( FooterCoordinates.Boxed = True ) then
  begin
  	if ( FooterCoordinates.Shading > 0 ) then
    	DrawBoxShade( FooterCoordinates.XTop,FooterCoordinates.YTop,
      	FooterCoordinates.XBottom,FooterCoordinates.YBottom,
      	FooterCoordinates.LineWidth,FooterCoordinates.Shading)
    else
    	DrawBox( FooterCoordinates.XTop,FooterCoordinates.YTop,
      	FooterCoordinates.XBottom,FooterCoordinates.YBottom,
        FooterCoordinates.LineWidth );
  end;
  AutoPaging := False;
  for I := 1 to FooterLines do
  begin
  	if ( Length(Footer[I].Text) > 0 ) then
    begin
    	with Footer[I] do
      begin
      	SetFontInfo( Font );
        if ( Alignment = wtLeft ) then
        	WriteLine( FooterCoordinates.XTop, YPosition, Text );
        if ( Alignment = wtCenter ) then
        	case Measure of
          	mtMM: WriteLine( (FooterCoordinates.XTop + ((FooterCoordinates.XBottom -
            		FooterCoordinates.XTop) / 2)) - PixelsToMMHorizontal(
                GetTextWidth(Text) div 2),
                YPosition, Text);
          	mtPixels: WriteLine( Round((FooterCoordinates.XTop + ((FooterCoordinates.XBottom -
            		FooterCoordinates.XTop) / 2))) - (GetTextWidth(Text) / 2),
                YPosition, Text);
          	mtInches: WriteLine( (FooterCoordinates.XTop + ((FooterCoordinates.XBottom -
            		FooterCoordinates.XTop) / 2)) - PixelsToInchesHorizontal(
                GetTextWidth(Text) div 2),
                YPosition, Text);
          end;
        if ( Alignment = wtRight ) then
        	case Measure of
          	mtMM: WriteLine( FooterCoordinates.XBottom -
            					PixelsToMMHorizontal(GetTextWidth( Text )), YPosition, Text );
            mtPixels: WriteLine( FooterCoordinates.XBottom - GetTextWidth( Text ),
            					YPosition, Text );
            mtInches: Writeline( FooterCoordinates.XBottom -
            					PixelsToInchesHorizontal(GetTextWidth( Text )), YPosition, Text );
          end;
      end;
    end;
  end;
  RestoreCurrentFont;
  AutoPaging := Temp;
end;

procedure TMWPrintObject.WriteHeader;
   { If any headers are defined, write them }
var
	I: Integer;

begin
	if Not PrintingOK then
  	exit;
   { Does the user desire a box around the header? }
  if ( HeaderCoordinates.Boxed = True ) then
  begin
  	if ( HeaderCoordinates.Shading > 0 ) then
    	DrawBoxShade( HeaderCoordinates.XTop,HeaderCoordinates.YTop,
      	HeaderCoordinates.XBottom,HeaderCoordinates.YBottom,
        HeaderCoordinates.LineWidth,HeaderCoordinates.Shading)
    Else
    	DrawBox( HeaderCoordinates.XTop,HeaderCoordinates.YTop,
      	HeaderCoordinates.XBottom,HeaderCoordinates.YBottom,
        HeaderCoordinates.LineWidth );
  End;
	SaveCurrentFont;
  for I := 1 to HeaderLines do
  begin
  	if ( Length(Header[I].Text) > 0 ) then
    begin
    	with Header[I] do
      begin
      	SetFontInfo( Font );
        if ( Alignment = wtLeft ) then
        	WriteLine( HeaderCoordinates.XTop, YPosition, Text );
        if ( Alignment = wtCenter ) then
        	case Measure of
          	mtMM: WriteLine( (HeaderCoordinates.XTop + ((HeaderCoordinates.XBottom -
            		HeaderCoordinates.XTop) / 2)) - PixelsToMMHorizontal(
                GetTextWidth(Text) div 2),
                YPosition, Text);
          	mtPixels: WriteLine( Round((HeaderCoordinates.XTop + ((HeaderCoordinates.XBottom -
            		HeaderCoordinates.XTop) / 2))) - (GetTextWidth(Text) / 2),
                YPosition, Text);
          	mtInches: WriteLine( (HeaderCoordinates.XTop + ((HeaderCoordinates.XBottom -
            		HeaderCoordinates.XTop) / 2)) - PixelsToInchesHorizontal(
                GetTextWidth(Text) div 2),
                YPosition, Text);
          end;
        if ( Alignment = wtRight ) then
        	case Measure of
          	mtMM: WriteLine( HeaderCoordinates.XBottom -
            					PixelsToMMHorizontal(GetTextWidth( Text )), YPosition, Text );
            mtPixels: WriteLine( HeaderCoordinates.XBottom - GetTextWidth( Text ),
            					YPosition, Text );
            mtInches: Writeline( HeaderCoordinates.XBottom -
            					PixelsToInchesHorizontal(GetTextWidth( Text )), YPosition, Text );
          end;
      end;
    end;
  end;
  RestoreCurrentFont;
End;

procedure TMWPrintObject.WriteLine( X:double; Y:double; Text:string );
   { Write some text.  The parameters represent inches from the left ('X')
     and top ('Y') margins. }
var
	xFor,
	XPixels,
  YPixels: integer;
  oldStyle: TBrushStyle;
  oldColor: TColor;
  oldMeasure: MeasureType;
  lf: TLogFont;
  OEMText: string;

begin
	if Not PrintingOK then
  	exit;
   { How many pixels are there in the inches represented by 'X'? }
  if DryRun or ImagePrinting then
  begin
  	case Measure of
    	mtPixels:
      	begin
        	if X > -0.01 then
        		X := PixelsToInchesHorizontal(X);
          if Y > -0.01 then
          	Y := PixelsToInchesVertical(Y);
        end;
      mtMM:
      	begin
        	if X > -0.01 then
        		X := MMToInches(X);
          if Y > -0.01 then
          	Y := MMToInches(Y);
        end;
    end;
  end;
	if ( X >= 0.0 ) then
  	XPixels := InchesToPixelsHorizontal( X )
  else
  	if ( X = -1 ) then
    	XPixels := InchesToPixelsHorizontal(LastXPosition)
    else
  		XPixels := LeftMargin;
  if ( XPixels < GutterLeft ) then
  	XPixels := GutterLeft;
   { If there is a tab set, increase 'XPixels' by the amount of the tab }
  if ( CurrentTab > 0.0 ) then
  	Inc( XPixels,InchesToPixelsHorizontal(CurrentTab) );
   { How many pixels are there in the inches represented by 'Y'? }
  YPixels := 0;
  if ( Y > -0.01 ) then
   { Printing will occur at an absolute location from the top of the
     page. }
  begin
  	YPixels := InchesToPixelsVertical( Y );
    if ( YPixels < GutterTop ) then
    	YPixels := GutterTop;
    if ( YPixels > TotalPageHeightPixels - GutterBottom) then
    	YPixels := TotalPageHeightPixels - GutterBottom;
    LastYPosition := Y;
  end;
  if ( Y = -1 ) then
   { Write the text at the next line }
  begin
  	if DryRun and AutoPaging then
    begin
     { If the next line we're going to write to exceeds beyond the
       bottom of the detail section, issue a new page }
     	if ( LastYPosition + GetLineHeightInches > (DetailBottom / ScaleByValue)) then
      	NewPage;
    end;
    LastYPosition := LastYPosition + GetLineHeightInches;
    YPixels := InchesToPixelsVertical( LastYPosition );
  end;
  if ( Y = -2 ) then
   { Write the text on the current line }
  begin
  	if DryRun and AutoPaging then
    begin
     	if ( LastYPosition > (DetailBottom / ScaleByValue)) then
      	NewPage;
    end;
    YPixels := InchesToPixelsVertical( LastYPosition );
  end;
  oldStyle := TheCanvas.Brush.Style;
  oldColor := TheCanvas.Brush.Color;
  if PrintTransparent then
  	TheCanvas.Brush.Style := bsClear
  else
  	TheCanvas.Brush.Style := bsSolid;
  oldMeasure := Measure;
  Measure := mtInches;
  SetYPosition(LastYPosition);
  Measure := oldMeasure;
	if RotateAngle <> 0 then // added to allow for rotating of fonts...
	begin
  	GetObject(TheCanvas.Font.Handle,SizeOf(lf),@lf);
  	lf.lfEscapement := RotateAngle * 10;
  	lf.lfOrientation := RotateAngle * 10;
		lf.lfHeight := Round(GetLineHeightPixels * ScaleByValue);
  	RotateFont := CreateFontIndirect(lf);
  	OriginalFont := SelectObject(TheCanvas.Handle,RotateFont);
    CalculateMeasurements;
  end
  else
  	if LargeFontsOn then
 			LastXPosition := PixelsToInchesHorizontal(Round(XPixels/ScaleByValue) +
    																					Round(GetTextWidth(Text)*1.25))
    else
 			LastXPosition := PixelsToInchesHorizontal(Round(XPixels/ScaleByValue) +
    																					GetTextWidth(Text));
  if not DryRun then
   	TheCanvas.TextOut( XPixels-GutterLeft, YPixels-GutterTop, Text )
  else if not ImagePrinting then
  	Pages.StoreText(X,LastYPosition,Text,TheCanvas.Brush.Color);
  if RotateAngle <> 0 then
  begin
  	SelectObject(TheCanvas.Handle,OriginalFont);
    DeleteObject(RotateFont);
    CalculateMeasurements;
	end;
  TheCanvas.Brush.Style := oldStyle;
  TheCanvas.Brush.Color := oldColor;
end;

procedure TMWPrintObject.WriteLineAlign( Y: double; Text: string; Align: word);
begin
	Case Align of
  	wtLeft:
    	case Measurement of
      	mtMM: WriteLine(PixelsToMMHorizontal(LeftMargin), Y, Text);
        mtPixels: WriteLine(LeftMargin, Y, Text);
        mtInches: WriteLine(PixelsToInchesHorizontal(LeftMargin), Y, Text);
      end;
    wtCenter: WriteLineCenter( Y, Text);
    wtRight: WriteLineRight( Y, Text);
    wtDecimal:
    	case Measurement of
      	mtMM: WriteLineDecimal(PixelsToMMHorizontal(RightMargin)-
        				GetTextWidth(copy(Text,pos('.',Text),length(Text))+'W'), // add W for space
                Y, Text);
        mtPixels: WriteLineDecimal(RightMargin -
        				GetTextWidth(copy(Text,pos('.',Text),length(Text))+'W'), // add W for space
                Y, Text);
      	mtInches: WriteLineDecimal(PixelsToInchesHorizontal(RightMargin)-
        				GetTextWidth(copy(Text,pos('.',Text),length(Text))+'W'), // add W for space
                Y, Text);
      end;
  	wtIndent:
    	case Measurement of
      	mtMM: WriteLine(GetIndent+PixelsToMMHorizontal(LeftMargin), Y, Text);
        mtPixels: WriteLine(GetIndent+LeftMargin, Y, Text);
        mtInches: WriteLine(GetIndent+PixelsToInchesHorizontal(LeftMargin), Y, Text);
      end;
  end;
end;

procedure TMWPrintObject.WriteLineCenter( Y:double; Text:string );
   { Print a line of text centered at Y inches from the top }
var
	PixelLength: integer;
  StartPixel: integer;

begin
	if Not PrintingOK then
  	exit;
   { How many pixels does the text in 'Text' require? }
	PixelLength := GetTextWidth(Text);
  if LargeFontsOn then
  	PixelLength := Round(PixelLength / 1.25);
   { Calculate where printing should start }
 	StartPixel := (((RightMargin - LeftMargin) - PixelLength) div 2) + LeftMargin;
  SetTab( 0.0 );
  if LargeFontsOn then
  	StartPixel := Round(StartPixel * 1.25);
  if DryRun or Imageprinting then
  begin
  	if Measure = mtMM then
    	WriteLine( PixelsToMMHorizontal(StartPixel),Y,Text)
    else if Measure = mtPixels then
    	WriteLine( StartPixel, Y, Text)
  	else WriteLine( PixelsToInchesHorizontal(StartPixel),Y,Text );
  end
  else
  	WriteLine( PixelsToInchesHorizontal(StartPixel),Y,Text );
  SetTab( CurrentTab );
end;

procedure TMWPrintObject.WriteLineCenterToX(X, Y:double; Text:string );
{ Print a line of text centered at X, Y units from the top }
{ Thanks to Tomasz Waraksa of Poland for this }
var
 PixelLength : Integer;
 StartPixel : Integer;

begin
  if Not PrintingOK then Exit;
  { How many pixels does the text in 'Text' require? }
  PixelLength := GetTextWidth(Text);
  if LargeFontsOn then
  	PixelLength := Round(PixelLength / 1.25);

  { Calculate where printing should start }
  case Measure of
   mtMM : X := MMToPixelsHorizontal(X);
   mtInches : X := InchesToPixelsHorizontal(X);
  end;

  StartPixel := Round(X) - (PixelLength div 2);
  SetTab( 0.0 );
  if LargeFontsOn then
  	StartPixel := Round(StartPixel * 1.25);

  if Measure = mtMM then
   WriteLine(InchesToMM(PixelsToInchesHorizontal(StartPixel)),Y,Text)
    else if Measure = mtPixels then
      WriteLine(StartPixel, Y, Text)
      else WriteLine(PixelsToInchesHorizontal(StartPixel),Y,Text);

  SetTab( CurrentTab );
end;

function TMWPrintObject.ClipText(ColumnNumber: word; Text: string): string;
var
	x: integer;
  s: string;

begin
	for x := 1 to length(Text) do
  	if GetWidthOfText(s + Text[x]) < GetColumnWidth(ColumnNumber) then
    	s := s + Text[x];
  result := s;
end;

procedure TMWPrintObject.WriteLineColumn( ColumnNumber:word; Y:double; Text:string );
   { Write text, left aligned against the column represented by
     'ColumnInformation[ColumnNumber]' }
begin
	if Not PrintingOK then
  	exit;
  if fColumnClipping then
  	Text := ClipText(ColumnNumber, Text);
	WriteLine( GetColumnLeft(ColumnNumber)+PixelsToInchesHorizontal(4),Y,Text );
end;

procedure TMWPrintObject.WriteLineColumnAlign( ColumnNumber: word; Y: double; Text: string;
																Align: word);
var
	tmpTab: double;

begin
	case Align of
  	wtLeft: WriteLineColumn(ColumnNumber, Y, Text);
    wtCenter: WriteLineColumnCenter(ColumnNumber, Y, Text);
    wtRight: WriteLineColumnRight(ColumnNumber, Y, Text);
    wtDecimal:
    	begin
      	tmpTab := GetWidthOfText('.0000');
      	WriteLineColumnDecimal(ColumnNumber, (GetColumnRight(ColumnNumber)-
       				tmpTab) - GetColumnLeft(ColumnNumber), Y, Text);
      end;
  	wtIndent:
    	begin
      	tmpTab := GetTab;
      	SetTab(0.0);
    		case Measurement of
      		mtMM: WriteLine(GetIndent+GetColumnLeft(ColumnNumber), Y, Text);
        	mtPixels: WriteLine(GetIndent+GetColumnLeft(ColumnNumber),Y, Text);
        	mtInches: WriteLine(GetIndent+GetColumnLeft(ColumnNumber), Y, Text);
      	end;
        SetTab(tmpTab);
      end;
  end;
end;

function TMWPrintObject.WriteLineColumnArray(Y: double;Cols: array of variant;
																Justif: array of variant;Strings: array of variant;
                                KeepY, SamePage: boolean): integer;
	 { This will allow you to print an array of columns and have them all start
     on the next page if any of them will extend to another page.
     It will also return the number of lines printed.}
var
	x,w,z: integer;
  oldPage: integer;
  theText: array [0..Columns-1] of TStringList;

begin
{ test to make sure all arrays are same size....}
	if (High(Cols) <> High(Justif)) or (High(Cols) <> High(Strings)) then
  begin
  	ShowMessage('TMWPrintObject Error: array sizes different.');
  	exit;
  end;
  w := 0;
{ Set up a TStringList object for each column we need to print....}
  for x := 0 to High(Cols) do
  begin
  	theText[x] := TStringList.Create;
    WrapText(Strings[x],theText[x],GetColumnLeft(Cols[x]),GetColumnRight(Cols[x]));
    if theText[x].Count > w then
    	w := theText[x].Count;
  end;
  if KeepY then
  	SaveCurrentY;
  if Y = -1 then
  	NextLine
  else if Y <> -2 then
  	SetYPosition(Y);
  if (w > GetLinesLeft) and SamePage then
  begin
  	if KeepY then
    	RestoreCurrentY;
  	NewPage;
    if KeepY then
    	SaveCurrentY;
  end;
  oldPage := Pages.TotalPages;
{ now we need to loop through the columns and print each line....}
	result := 0;
  for z := 0 to w-1 do
  begin
  	for x := 0 to High(Cols) do
  	begin
    	if (theText[x].Count > (z)) then
	    	Case Justif[x] of
  	    	0: WriteLineColumn(Cols[x],-2.0,theText[x].Strings[z]);
      		1: WriteLineColumnCenter(Cols[x],-2.0,theText[x].Strings[z]);
	      	2: WriteLineColumnRight(Cols[x],-2.0,theText[x].Strings[z]);
    	  end;
  	end;
    if z < (w-1) then
    	NextLine;
    inc(result);
    if Not AutomaticPaging and (GetYPosition{ + GetLineHeightInches} > DetailBottom) then
    begin
    	if KeepY then
      	RestoreCurrentY;
    	NewPage;
    	if KeepY then
      	SaveCurrentY;
    end;
  end;
  if KeepY then
  	if oldPage <> Pages.TotalPages then
    begin
    	RestoreCurrentY;
    	SetTopOfPage;
    end
    else
    	RestoreCurrentY;
{ Now clean up the memos we created....}
	for x := 0 to High(Cols) do
  	theText[x].Destroy;
end;

function TMWPrintObject.WriteLineColumnArrayTest(Y: double;Cols: array of variant;
																Justif: array of variant;Strings: array of variant;
                                KeepY, SamePage: boolean): boolean;
	 { This will allow you to test print an array of columns and it will return
     true if there is enough room on the page to print all columns.}
var
	origY: double;
	x,w,z: integer;
  oldPage: integer;
  theText: array [0..Columns-1] of TStringList;

begin
{ test to make sure all arrays are same size....}
  result := true;
	if (High(Cols) <> High(Justif)) or (High(Cols) <> High(Strings)) then
  begin
  	ShowMessage('TMWPrintObject Error: array sizes different.');
  	exit;
  end;
  w := 0;
{ Set up a TStringList object for each column we need to print....}
  for x := 0 to High(Cols) do
  begin
  	theText[x] := TStringList.Create;
    WrapText(Strings[x],theText[x],GetColumnLeft(Cols[x]),GetColumnRight(Cols[x]));
    if theText[x].Count > w then
    	w := theText[x].Count;
  end;
	origY := GetYPosition;
  if Y = -1 then
  	result := not SamePage or ((w+1) <= GetLinesLeft)
  else
  	result := not SamePage or ((w) <= GetLinesLeft);
{ Now clean up the memos we created....}
	for x := 0 to High(Cols) do
  	theText[x].Destroy;
end;

procedure TMWPrintObject.WriteLineColumnCenter( ColumnNumber:word; Y:double; Text:string );
   { Print a line of text centered within the column number represented by
     'ColumnNumber', at Y inches from the top }
var
	PixelLength: Integer;
  StartPixel: Integer;

begin
	if Not PrintingOK then
  	exit;
  if fColumnClipping then
  	Text := ClipText(ColumnNumber, Text);
   { How many pixels does the text in 'Text' require? }
	PixelLength := GetTextWidth( Text );
   { Calculate where printing should start }
	 { Pixels := InchesToPixelsHorizontal( ColumnInformation[ColumnNumber].Length );}
  if DryRun or ImagePrinting then
  	case Measure of
    	mtPixels: StartPixel := Round((GetColumnWidth(ColumnNumber) - PixelLength)/2) +
      	Round(GetColumnLeft(ColumnNumber));
      mtMM: StartPixel := ((MMToPixelsHorizontal(GetColumnWidth(ColumnNumber)) -
      	PixelLength) div 2) + MMToPixelsHorizontal(GetColumnLeft(ColumnNumber));
      mtInches: StartPixel := ((InchesToPixelsHorizontal(GetColumnWidth(ColumnNumber)) -
      	PixelLength) div 2) + InchesToPixelsHorizontal(GetColumnLeft(ColumnNumber));
  	end
  else
  	StartPixel := (InchesToPixelsHorizontal( ColumnInformation[ColumnNumber].Length )
  		div 2) + InchesToPixelsHorizontal(ColumnInformation[ColumnNumber].XPosition) -
    	(PixelLength div 2);
  SetTab( 0.0 );
  if DryRun or Imageprinting then
  begin
  	if Measure = mtMM then
    	WriteLine( PixelsToMMHorizontal(StartPixel),Y,Text)
    else if Measure = mtPixels then
    	WriteLine( StartPixel, Y, Text)
  	else WriteLine( PixelsToInchesHorizontal(StartPixel),Y,Text );
  end
  else
  	WriteLine( PixelsToInchesHorizontal(StartPixel),Y,Text );
  SetTab( CurrentTab );
end;

procedure TMWPrintObject.WriteLineColumnDecimal( ColumnNumber: word; X,Y: double; Text: string);
var
	DotPos: integer;

begin
  if fColumnClipping then
  	Text := ClipText(ColumnNumber, Text);
  if pos('.',Text) > 0 then
  	DotPos := pos('.',Text) - 1
  else
  	DotPos := Length(Text);
	case Measurement of
  	mtMM: WriteLine((GetColumnLeft(ColumnNumber) + X) -
    										GetTextWidthMM(copy(Text,1,DotPos)), Y, Text);
  	mtPixels: WriteLine((GetColumnLeft(ColumnNumber) + X) -
    										GetTextWidth(copy(Text,1,DotPos)), Y, Text);
  	mtInches: WriteLine((GetColumnLeft(ColumnNumber) + X) -
    										GetTextWidthInches(copy(Text,1,DotPos)), Y, Text);
	end;
end;

procedure TMWPrintObject.WriteLineColumnRight( ColumnNumber:word; Y:double; Text:string );
   { Write text, right aligned against the column represented by
     'ColumnInformation[ColumnNumber]' }
var
	PixelLength: word;
  StartPixel: word;

begin
	if Not PrintingOK then
  	exit;
  if fColumnClipping then
  	Text := ClipText(ColumnNumber, Text);
   { How many pixels does the text in 'Text' require? }
   { Calculate where printing should start }
  PixelLength := GetTextWidth(Text);
  if LargeFontsOn then
  	PixelLength := Round(PixelLength * 1.25);
  PixelLength := PixelLength + 4; // add 4 pixels for spacing...
  if LargeFontsOn then
  	ScaleByValue := ScaleByValue / 1.25;
  if DryRun or ImagePrinting then
  	case Measure of
    	mtPixels: StartPixel := Round(GetColumnRight(ColumnNumber)/ScaleByValue) - PixelLength;
      mtMM: StartPixel := (MMToPixelsHorizontal(GetColumnRight(ColumnNumber)/ScaleByValue)) -
      	PixelLength;
      mtInches: StartPixel :=
      	(InchesToPixelsHorizontal(GetColumnRight(ColumnNumber)/ScaleByValue)) - PixelLength;
    end
  else
  	StartPixel := InchesToPixelsHorizontal((GetColumnRight(ColumnNumber)/ScaleByValue)) -
    	PixelLength;
  if LargeFontsOn then
  	ScaleByValue := ScaleByValue * 1.25;
  if DryRun then
  begin
  	if ( Y < 0) then
    begin
  		if ( Y = -1.0) then
      	NextLine;
      Y := GetYPosition;
    end;
   	if Measure = mtMM then
     	Pages.StoreColRight(ColumnNumber, MMtoInches(Y), Text)
    else if Measure = mtPixels then
     	Pages.StoreColRight(ColumnNumber, PixelsToInchesVertical(Round(Y)), Text)
    else
   		Pages.StoreColRight(ColumnNumber, Y, Text);
  end;
  SetTab( 0.0 );
  if Not DryRun or ImagePrinting then
  	case Measure of
    	mtPixels: WriteLine(StartPixel, Y, Text);
      mtMM: WriteLine(PixelsToMMHorizontal(StartPixel), Y, Text);
      mtInches: WriteLine(PixelsToInchesHorizontal(StartPixel), Y, Text);
    end;
  SetTab( CurrentTab );
end;

procedure TMWPrintObject.WriteSnakeColumn(Y: double; Text: string);
begin
	WriteLineColWrapJust(StrToInt(SnakeColumns[fSnakeCurrentIndex]),
  		Y, Text, false, false, wtLeft);
end;

procedure TMWPrintObject.WriteLineColumnWrap(ColumnNumber:word; Y:double;
																						Text:string; KeepY,SamePage:boolean);
   { Word wrap text in a given column starting at Y inches from the top }
begin
	if Not PrintingOK then
  	exit;
  WriteLineColWrapJust(ColumnNumber, Y, Text, KeepY, SamePage, wtLeft);
end;

procedure TMWPrintObject.WriteLineColWrapJust(ColumnNumber:word; Y:double;
																						Text:string; KeepY,SamePage:boolean; Just: integer);
   { Word wrap text in a given column starting at Y inches from the top }
var
  x: integer;
  theText: TStringList;

begin
	if Not PrintingOK then
  	exit;
	theText := TStringList.Create;
  WrapText(Text,theText,GetColumnLeft(ColumnNumber),GetColumnRight(ColumnNumber));
  { remove excess blank lines on bottom if any..}
  while (theText.Count > 0) and (trim(theText.Strings[theText.Count-1]) = '') do
  	theText.Delete(theText.Count-1);
  if KeepY then
  	SaveCurrentY;
	if (Y = -1.0) then
	begin
		NextLine;
	end
  else if (Y <> -2.0) then
  	SetYPosition(Y);
  if SamePage and (theText.Count > GetLinesLeft) then
  begin
  	RestoreCurrentY;
    NewPage;
    SaveCurrentY;
  end;
  for x := 0 to theText.Count-1 do
  begin
  	case Just of
    	wtLeft: WriteLineColumn(ColumnNumber, -2.0, theText[x]);
      wtCenter: WriteLineColumnCenter(ColumnNumber, -2.0, theText[x]);
      wtRight: WriteLineColumnRight(ColumnNumber, -2.0, theText[x]);
    end;
    if x < theText.Count-1 then
    	if fSnakeColumns then
      begin
      	if GetLinesLeft = 1 then
        begin
          if fSnakeCurrentIndex = (SnakeColumns.Count-1) then
          begin
          	NewPage;
            fSnakeCurrentIndex := 0;
          end
          else
          begin
          	inc(fSnakeCurrentIndex);
          end;
          SetTopOfPage;
        end
        else
        	NextLine;
        fSnakeCurrentColumn := StrToInt(SnakeColumns[fSnakeCurrentIndex]);
        ColumnNumber := fSnakeCurrentColumn;
      end
      else
    		NextLine;
  end;
  theText.Free;
  if KeepY then
  	RestoreCurrentY;
end;

procedure TMWPrintObject.WriteLineDecimal( X,Y: double; Text: string);
var
	DotPos: integer;

begin
	if pos('.',Text) > 0 then
  	DotPos := pos('.',Text) - 1
  else
  	DotPos := Length(Text);
	case Measurement of
  	mtMM: 	WriteLine( X - GetTextWidthMM(copy(Text, 1, DotPos)), Y, Text);
    mtPixels: 	WriteLine( X - GetTextWidth(copy(Text, 1, DotPos)), Y, Text);
    mtInches: 	WriteLine( X - GetTextWidthInches(copy(Text, 1, DotPos)), Y, Text);
  end;
end;

procedure TMWPrintObject.WriteLineRight( Y:double; Text:string );
   { Print a line of text right justified 'Y' inches from the top }
var
	PixelLength: word;
  StartPixel: word;

begin
	if Not PrintingOK then
  	exit;
   { How many pixels does the text in 'Text' require? }
  PixelLength := GetTextWidth(Text);
  if LargeFontsOn then
  	PixelLength := Round(PixelLength / 1.25);
  PixelLength := PixelLength + 4; // add 4 pixels for spacing...
   { Calculate where printing should start }
  StartPixel := Round((RightMargin/Sqr(ScaleByValue))) - PixelLength;
  SetTab( 0.0 );
  if DryRun then
  begin
  	if ( Y < 0.0) then
    begin
    	if ( Y = -1) then
      	NextLine;
      Y := GetYPosition;
    end;
   	if Measure = mtMM then
     	Pages.StoreWriteLineRight(MMtoInches(Y), Text)
    else if Measure = mtPixels then
     	Pages.StoreWriteLineRight(PixelsToInchesVertical(Round(Y)), Text)
    else
   		Pages.StoreWriteLineRight(Y, Text);
  end;
  if Not DryRun or ImagePrinting then
  	case Measure of
    	mtPixels: WriteLine(StartPixel, Y, Text);
      mtMM: WriteLine(PixelsToMMHorizontal(StartPixel), Y, Text);
      mtInches: WriteLine(PixelsToInchesHorizontal(StartPixel), Y, Text);
    end;
  SetTab( CurrentTab );
end;

procedure TMWPrintObject.WriteLineRightToX(X,Y:double; Text:string );
{ Print a line of text right justified to X, Y units from the top }
{ Thanks to Tomasz Waraksa of Poland for this }
var
 PixelLength : Integer;
 StartPixel : Integer;

begin
  if Not PrintingOK then Exit;
  { How many pixels does the text in 'Text' require? }
  PixelLength := GetTextWidth(Text);

  { Calculate where printing should start }
  case Measure of
   mtMM : X := MMToPixelsHorizontal(X);
   mtInches : X := InchesToPixelsHorizontal(X);
  end;

  StartPixel := Round(X)-PixelLength;
  SetTab(0.0);

  if Measure = mtMM then
   WriteLine(InchesToMM(PixelsToInchesHorizontal(StartPixel)),Y,Text)
    else if Measure = mtPixels then
      WriteLine(StartPixel, Y, Text)
      else WriteLine(PixelsToInchesHorizontal(StartPixel),Y,Text);

  SetTab( CurrentTab );
end;

procedure TMWPrintObject.WriteLineWrap(XL,XR,Y:double; Text:string; KeepY,SamePage: boolean);
	 { Word wrap text within the bounds set by XR and XL at Y inches from top }
var
  x: integer;
  theText: TStringList;

begin
	if Not PrintingOK then
  	exit;
	theText := TStringList.Create;
  WrapText(Text,theText,XL,XR);
  { remove excess blank lines on bottom if any..}
  while (theText.Count > 0) and (trim(theText.Strings[theText.Count-1]) = '') do
  	theText.Delete(theText.Count-1);
  if KeepY then
  	SaveCurrentY;
	if (Y = -1.0) then
	begin
		NextLine;
	end
  else if (Y <> -2.0) then
  	SetYPosition(Y);
  if SamePage and (theText.Count > GetLinesLeft) then
  begin
    RestoreCurrentY;
  	NewPage;
    SaveCurrentY;
  end;
  for x := 0 to theText.Count-1 do
  begin
  	if GetLinesLeft < 1 then
    begin
    	if KeepY then
      	RestoreCurrentY;
    	NewPage;
    	if KeepY then
      	SaveCurrentY;
    end;
  	WriteLine(XL,-2.0,theText.Strings[x]);
    if x < theText.Count-1 then
    	NextLine;
  end;
  theText.Free;
  if KeepY then
  	RestoreCurrentY;
end;

procedure TMWPrintObject.WritePageNumber;
{ Print the current page number on page if page numbering is set }
var
	Buffer: string;
  Temp: boolean;
  yNew: double;

begin
	if Not PrintingOK then
  	exit;
	if Not PageNumbering  or (PageNumber.Text = '') then
  	exit;
  try
		if PreviewMode then
  		Buffer := Format( PageNumber.Text,[PreviewForm.GetPageNumber] )
  	else
  		Buffer := Format( PageNumber.Text,[Printer.PageNumber] );
  except
  	ShowMessage('Error in page number formatting.');
    exit;
  end;
  if PageNumber.ShowTotalPages then
  	Buffer := Buffer + ' sur ' + IntToStr(Pages.TotalPages);
  SaveCurrentFont;
  SetFontInfo( PageNumber.Font );
  Temp := AutoPaging;
	SetAutoPaging(false);
	if DryRun then
  	Pages.StoreGeneral(commWritePage);
  case PageNumber.Alignment of
  	0:
    	case Measure of
      	mtPixels: WriteLine(LeftMargin, PageNumber.YPosition,Buffer);
        mtMM: WriteLine(PixelsToMMHorizontal(LeftMargin),PageNumber.YPosition,Buffer);
        mtInches: WriteLine(PixelsToInchesHorizontal(LeftMargin),PageNumber.YPosition,Buffer);
      end;
    1:WriteLineCenter( PageNumber.YPosition, Buffer );
  	2:
    	case Measure of
      	mtPixels:	WriteLine(RightMargin-GetTextWidth(Buffer),PageNumber.YPosition, Buffer);
        mtMM:	WriteLine(PixelsToMMHorizontal(RightMargin)-GetTextWidthMM(Buffer),
        								PageNumber.YPosition, Buffer);
        mtInches:	WriteLine(PixelsToInchesHorizontal(RightMargin)-GetTextWidthInches(Buffer),
    												PageNumber.YPosition, Buffer);
    	end;
  end;
  SetAutoPaging(temp);
  RestoreCurrentFont;
end;

procedure TMWPrintObject.WritePrinterSpecs(RestoreState: boolean);
var
	MyHandle: THandle;
  MyDevMode: pDevMode;
  MyDevice,
  MyDriver,
  MyPort: array [0..255] of char;

begin
	if Not (PrintingOK or RestoreState) or ImagePrinting then
  	exit;
	Printer.GetPrinter(MyDevice,MyDriver,MyPort,MyHandle);
  MyDevMode := GlobalLock(MyHandle);
  try
  	try
  		MyDevMode^.dmFields := MyDevMode^.dmFields or
    		(DM_PAPERSIZE or DM_ORIENTATION or DM_COPIES or DM_PRINTQUALITY);
    	if Not RestoreState then
    	begin
    		MyDevMode^.dmPaperSize := ord(PaperSize)+1;
    		if Orientation = poLandscape then
    			MyDevMode^.dmOrientation := DMORIENT_LANDSCAPE
    		else
    			MyDevMode^.dmOrientation := DMORIENT_PORTRAIT;
      	MyDevMode^.dmCopies := fCopies;
        if UseQualitySetting then
      		case ord(fQuality) of
      			0: MyDevMode^.dmPrintQuality := DMRES_HIGH;
      			1: MyDevMode^.dmPrintQuality := DMRES_MEDIUM;
      			2: MyDevMode^.dmPrintQuality := DMRES_LOW;
      			3: MyDevMode^.dmPrintQuality := DMRES_DRAFT;
      		end;
    	end
    	else
    	begin
    		MyDevMode^.dmPaperSize := OrigPaperSize;
      	MyDevMode^.dmOrientation := OrigPaperOrient;
      	MyDevMode^.dmCopies := 1;
        if UseQualitySetting then
      		MyDevMode^.dmPrintQuality := DMRES_HIGH;
    	end;
    	Printer.SetPrinter(MyDevice,MyDriver,MyPort,MyHandle);
    except
    	on E: Exception do
      	ShowMessage('Error setting printer properties for printing.');
    end;
  finally
  	GlobalUnLock(MyHandle);
  end;
end;

function TMWPrintObject.MMToInches(mm: double): double;
begin
	result := (mm / mmConvert);
end;

function TMWPrintObject.InchesToMM(inches: double): double;
begin
	result := (inches * mmConvert);
end;

procedure TMWPrintObject.GetPrinterSpecs;
var
	oldOK: boolean;

begin
	oldOK := PrintingOK;
	PrintingOK := true;
  ReadPrinterSpecs(false);
  PrintingOK := oldOK;
end;

procedure TMWPrintObject.SetPrinterSpecs;
var
	oldOK: boolean;

begin
	oldOK := PrintingOK;
	PrintingOK := true;
  WritePrinterSpecs(false);
  PrintingOK := oldOK;
end;

procedure TMWPrintObject.SetMeasure(Meas: MeasureType);
begin
	if DryRun then
  	Pages.StoreMeasure(ord(Meas));
  Measurement := Meas;
end;

procedure TMWPrintObject.SetTransparent(Flag: boolean);
begin
	if DryRun then
  	Pages.StoreTransparent(Flag);
  Transparent := Flag;
end;

procedure TMWPrintObject.VersionKill(s: string);
begin
{	Procedure to kill any input into the Version property...
	This is because I'm too lazy to write a property editor to
  display the information in an about box.}
end;

end.

