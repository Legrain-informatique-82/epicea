{
***********************************************************************
**                                                                   **
**        QSStrings.PAS - Last modified: 18. October 1997            **
**                                                                   **
***********************************************************************
**                                                                   **
**   This unit contains the declaration of string constants used     **
**   by the TQuickSelect component.                                  **
**                                                                   **
**   This unit is also used to determine the language for the        **
**   component. Se below for further instructions.                   **
**                                                                   **
***********************************************************************
}

unit QSStrings;

interface
{
Put a $ on the line with the resourcefile you want to include.
Remove the $ from all other lines.
}

{R QSNor.RES}  {Use this line if you want Norwegian language}
{$R QSEng.RES}  {Use this line if you want English language}
{R QSSpa.RES}  {Use this line if you want Spanish language}
{R QSGer.RES}  {Use this line if you want German language}
{R QSFre.RES}  {Use this line if you want French language}


const
  StrReportName       = 0;
  StrReportType       = 1;
  StrSaveBtn          = 2;
  StrDeleteBtn        = 3;
  StrSortMethodBtn    = 4;
  StrVisualTab        = 5;
  StrSQLTab           = 6;
  StrWaitMsg          = 7;
  StrPreviewBtn       = 8;
  StrOKBtn            = 9;
  StrCancelBtn        = 10;
  StrHelpBtn          = 11;
  StrDefTitle         = 12;
  StrIncludeLbl       = 13;
  StrDefEntityNameLbl = 14;
  StrWhereLbl         = 15;
  StrAllLbl           = 16;
  StrCriteriaLbl      = 17;
  StrAll              = 21;
  StrAny              = 22;
  StrNone             = 23;
  StrStart1           = 24;
  StrStart2           = 25;
  StrStart3           = 26;
  StrCompare1         = 27;  
  StrCompare2         = 28;
  StrCompare3         = 29;
  StrCompare4         = 30;
  StrCompare5         = 31;
  StrCompare6         = 32;
  StrCompare7         = 33;
  StrCompare8         = 34;
  StrCompare9         = 35;
  StrListTop1         = 36;
  StrListTop2         = 37;
  StrListTop3         = 38;
  StrListTop4         = 39;
  StrListTop5         = 40;
  StrCriterion1       = 41;
  StrCriterion2       = 42;
  StrCriterion3       = 43;
  StrAnd              = 44;
  StrDeleteAllWarning = 45;
  StrReportNameLbl    = 46;
  StrMakeNewReport    = 47;
  StrCustom           = 48;
  StrRTTitle          = 49;
  StrRTReportTypes    = 50;
  StrRTReportName     = 51;
  StrRTAdd            = 52;
  StrRTDelete         = 53;
  StrAvailFields      = 54;
  StrSelectedfields   = 55;
  StrFieldsBtn        = 58;
  StrRTUntitled       = 59;
  StrReportNameTitle  = 60;
  StrConfirmDelete    = 61;
  StrDeleteEmptyRep   = 62;
  StrSortDlgCaption   = 63;
  StrInvalidField     = 64;
  StrRTDeleteMsg      = 65;
  StrReportNotFound   = 66;
  StrReportFileNotFound = 67;             

implementation

end.
