unit ObjetEdition;

interface

uses
  SysUtils,
  Classes,
  PrintDrv,
  Printers,
  E2_Decl_Records,
  Windows,
  Lib_Chaine,
  Dialogs,
  Graphics,
  LibRessourceString,
  GR_Librairie_Obj,
  LibZoneSaisie,
  ExtCtrls;

type
  TParamEdit = record
  end;

  TParamLigneFormatee = record
   Alignement : Word;
   Taille:Integer;
   Valeur:String;
   Style : TFontStyles;
   Position:Integer;
  end;
//  TabString=array of string;
//  TabInteger=array of integer;
//  TabStringList=array of TStringList;
//  TabAlignment=Array of TAlignment;
//  TTypeEnsemble=TEnsembleByte;

  TObjetEdition = class(TMWPrintObject)
  private
    { Déclarations privées }
  TopMargin_Objet:Double ;
  BottomMargin_Objet:Double ;

  FLeftMargin_Objet:Double ;
  FRightMargin_Objet:Double ;


  LetterBottomMargin:Double;
  LegalBottomMargin:Double ;
    procedure LignesClassiqueBox(Valeurs, ValeursType: String;
      Gris: Boolean);
//  TheCanvas:TCanvas;
  protected
    { Déclarations protégées }
  public
    { Déclarations publiques }
  LeftMargin_Objet:Double ;
  RightMargin_Objet:Double ;
  //FParamAffichage:TParamAffichage;
  FParamEdition:TParamEdition;
  FDelimiteur:Char; //permet de délimiter les entrées de texte à tous niveaux
  FTitres:String; // Chaine représentant les titres séparé par des ';'  //par un Delimiteur
  FSousTitre:String; // Chaine représentant les SoustitresTAbleaux séparé par des ';' //par un Delimiteur
  FSurTitre1:String; // Chaine représentant les SurtitresTAbleaux séparé par des ';' //par un Delimiteur
  FSurTitre1Double:boolean; //boolean servant à indiquer si un surtitre est formatée sur 2 lignes
  FSurTitre2:String; // Chaine représentant les SurtitresTAbleaux2  séparé par des ';'  //par un Delimiteur
  FSurTitre2Double:boolean; //boolean servant à indiquer si un surtitre est formatée sur 2 lignes
  FLargeurSOusTitre:String; // Chaine représentant les largeur des Soustitres séparé par des ';' Format : n.x (1.1) //par un Delimiteur
  FLargeurTitre:String; // Chaine représentant les largeur des titres séparé par des ';' Format : n.x (1.1)    //par un Delimiteur
  FLargeurSurTitre1:String; // Chaine représentant les largeur des Surtitres séparé par des ';' Format : n.x (1.1)   //par un Delimiteur
  FLargeurSurTitre2:String; // Chaine représentant les largeur des Surtitres séparé par des ';' Format : n.x (1.1) //par un Delimiteur
  FTypeCol:String; // Chaine représentant le type des colonnes séparé par des ';'  //par un Delimiteur
                   // tout en minuscule : 'texte'
                   //                     'float'
                   //                     'curr'
                   //                     'bool'
  FSigleMonnaie:String;
  FFormatMonnaie:String;
  FTitreEdition:String;
  FSousTitreEdition:String;
  FTitre2Edition:String;
  FTitre3Edition:String;
  FNomDossier:string;
  FTabTitreColonne:array of string;
  FLargeurCol:array of integer;
  FTabList:array of TStringList;
  FAlignement:array of TAlignment;
  FTabStr:TEnsembleByte;
  FTAbCurr:TEnsembleByte;
  FTabDate:TEnsembleByte;
  Flogo:TImage;
  FontLigneSeule:TFont;

		constructor Create(AOwner: TComponent); override;{need to initialize some default values}
    destructor Destroy; override;
    Function ChangePointEnDecimalSeparator(Valeur:String):String;
    procedure EditionListe(ParamEditionTmp:TParamEdition;
                                         TabTitreColonneTmp:array of string;
                                         LargeurColTmp:array of integer;
                                         TabListTmp:array of TStringList;
                                         AlignementTmp:array of TAlignment;
                                         TabStrTmp,TAbCurrTmp,TabDateTmp:TEnsembleByte;LogoTmp:TImage);
    //Edition
    procedure SetPageDefaults;
    procedure SetPageDefaultsLGR;
    procedure PrnNewPage(Sender: TObject);
    procedure PrnAfterNewPage(Sender: TObject);
    procedure PrnSetupBtnClick(Sender: TObject);
    procedure GetPropertyDisplay;
    procedure SetPropertyDisplay;
    procedure SetFormatColonne;
    procedure SetFormatColonneLGR;
    Procedure LignesClassique(Valeurs,ValeursType:String;Gris:Boolean); // Type = 0
    Procedure TotalSeul(Valeurs:String);                                // Type = 1
    Procedure TotalPremier(Valeurs:String);                             // Type = 2
    Procedure TotalMilieu(Valeurs:String;AvecEspaces:boolean=false);// Type = 3 (sans espaces) ou 11 (avec espace)
    Procedure TotalDernier(Valeurs:String);                             // Type = 4
    Procedure LigneSimpleSeule(Valeurs:String;Align:Word);              // Type = 5
    Procedure LigneSimplePremiere(Valeurs:String;Align:Word);           // Type = 6
    Procedure LigneSimpleMilieu(Valeurs:String;Align:Word);    // Type = 7
    Procedure LigneSimpleDerniere(Valeurs:String;Align:Word);           // Type = 8
    Function ValeurType(Valeurs:string;Col:Integer):Integer;
    Procedure LigneSimpleDerniereFormatee(Valeurs:String;Align:Word); // Type = 9 ou 10 suivant centrage
    Procedure DessineLigne(X:Integer;Couleur:TColor); // Type 12
    Procedure LigneSimpleFormatee(ParamLigneFormatee:TParamLigneFormatee); // Type = 13
    Procedure LigneCompteBal(Valeurs:String;Align:Word);//14
    Procedure LignePlanCpt(Valeurs:String;DeltaColor:Integer); // Type 16
    Procedure LigneSautDePage;// Type 20
    Procedure TotalSeulLibelle(Valeurs:String);                                // Type = 1
    Procedure TotalPremierLibelle(Valeurs:String);                             // Type = 2
    Procedure TotalMilieuLibelle(Valeurs:String;AvecEspaces:boolean=false);// Type = 3 (sans espaces) ou 11 (avec espace)
    Procedure TotalDernierLibelle(Valeurs:String);                             // Type = 4

    //fin Edition

  Procedure AffichageImp(ListValue:TStringList);
  published
    { Déclarations publiées }
//  property ParamAffichage:TParamAffichage read FParamAffichage write FParamAffichage;
//  property TabTitreColonne:TabString read FTabTitreColonne write FTabTitreColonne;
//  property LargeurCol:TabInteger  read FLargeurCol write FLargeurCol;
//  property TabList:TabStringList  read FTabList write FTabList;
//  property Alignement:TabAlignment  read FAlignement write FAlignement;
//  property TabStr: TEnsembleByte  read FTabStr write FTabStr;
//  property TAbCurr: TEnsembleByte  read FTAbCurr write FTAbCurr;
//  property TabDate: TEnsembleByte  read FTabDate write FTabDate;

  end;

procedure Register;

implementation

uses Epicea2_TLB;

procedure Register;
begin
  RegisterComponents('Epicea', [TObjetEdition]);
end;

constructor TObjetEdition.Create(AOwner: TComponent);
begin
	inherited Create(AOwner);
    LeftMargin_Objet:=-1;
    RightMargin_Objet:=-1;
    AutomaticPaging := true;
    AutoPageFeed := true;
    SetMeasure(mtInches);
    Name := 'Prn';
    Orientation := poPortrait;
    PaperSize := PAPER_A4;
    Preview := true;
    PrintPageNumbers := true;
    ShowTotalPages := true;
   	ClipColumns := true;
    Transparent := true;
    ShowCancelBtn := true;
    ShowPrintDialog := true;
    ShowProgress := true;
    ShowProgressPercent := true;
    UseLargeFontAdjust := false;
    Title := 'Edition Epicea-2 - Logiciel de comptabilité - ';
    OnNewPage := PrnNewPage;
    AfterNewPage := PrnAfterNewPage;
    AfterPrint := nil;
    BeforePrint := nil;
    //FSigleMonnaie:= '€';
    FSigleMonnaie:= currencyStringEpicea;
//    FFormatMonnaie:=',0'+DecimalSeparator+'00 ;-,0'+DecimalSeparator+'00 ';
    FFormatMonnaie:=',0.00 ;-,0.00 ';
    FontLigneSeule:=TFont.Create;
end;

destructor TObjetEdition.Destroy;
begin
  inherited Destroy;
end;

procedure TObjetEdition.EditionListe(ParamEditionTmp:TParamEdition;
                                         TabTitreColonneTmp:array of string;
                                         LargeurColTmp:array of integer;
                                         TabListTmp:array of TStringList;
                                         AlignementTmp:array of TAlignment;
                                         TabStrTmp,TAbCurrTmp,TabDateTmp:TEnsembleByte;LogoTmp:TImage);

// TextAndBoxes uses 3 columns to produce a similated report something
// like a simplified purchase order might have in it.
var
	x,i,j,k,NbString,NbLignes: integer;
  Tmp1:string;
Begin
if FDelimiteur='' then FDelimiteur:=';';
    if logotmp<>nil then
      Flogo:=logotmp;
    FParamEdition:=ParamEditionTmp;
    if high(TabTitreColonnetmp)>-1 then
      begin
        SetLength(FTabTitreColonne,high(TabTitreColonnetmp)+1);
        For i:=0 to high(TabTitreColonnetmp) do FTabTitreColonne[i]:=TabTitreColonnetmp[i];
      end;
    if high(LargeurColTmp)>-1 then
      Begin
        SetLength(FLargeurCol,high(LargeurColTmp)+1);
        For i:=0 to high (LargeurColTmp) do FLargeurCol[i]:=LargeurColTmp[i];
      end;
    if high(TabListTmp)>-1 then
      Begin
        SetLength(FTabList,high(TabListTmp)+1);
        For i:=0 to high (TabListTmp) do FTabList[i]:=TabListTmp[i];
      end;
    if high(AlignementTmp)>-1 then
      begin
        SetLength(FAlignement,high(AlignementTmp)+1);
        For i:=0 to high (AlignementTmp) do FAlignement[i]:=AlignementTmp[i];
    Start;
//    SetProgressMax(13);
//    SetProgressText('TextBox Printing');
     SetPageDefaultslgr;
  case Orientation of
    poLandscape:begin
                   SetPageMargins(0.3, 0.3, 0.8, 0.3);
                end;
     poPortrait:begin
                   SetPageMargins(0.36, 0.36, 0.8, 0.36);
                end;
  end;
     SetFormatColonne;
     SetTopOfPage;

   //remplissage du corps de l'impression
   NbLignes:=0;
   for i:=0 to high(FTabList) do
    begin
     for j:=0 to FTabList[i].Count-1 do
      begin
        NbString := Str_Count_Str(FDelimiteur,(FTabList[i]).Strings[j]);
        x:=1;
        for k:=1 to NbString do
          begin
            Tmp1 :=str_getstringelement((FTabList[i]).Strings[j],k,FDelimiteur);
            WriteLineColumnAlign(x, -2.0, Tmp1, wtLeft);
            inc(x);
          end;
      if NbLignes>30 then
        begin/// si on veut rajouter une page
          NbLignes:=0;
          NewPage;
        end
      else
      begin
        NextLine;
        inc(NbLignes);
      end;
      end;
    end;
    ///fin du remplissage du corps de l'impression

    
///    DrawBoxShade(1, GetYPosition, 1.1,
///    							 GetYPosition+0.1, 1, $00FFFF80);

    { now, let's do some simple stuff like moving around
      and drawing some lines in arbitrary locations}
//    SetPenColor(clBlue);
//    MoveTo(6.5, 2.0);
//    LineTo(6.5, 3.5);
//    MoveTo(6.0, 2.75);
//    LineTo(7.0, 2.75);
//    SetPenColor(clBlack);

//    for i := 1 to 10 do
//    begin
//    	WriteLineColumnAlign(1, -2.0, 'Item #' + IntToStr(x), wtLeft);
//      WriteLineColumnAlign(2, -2.0, 'Description of Item #' + IntToStr(x), wtCenter);
//      WriteLineColumnAlign(3, -2.0, FormatFloat('##0.00', (100 * Random)), wtDecimal);
//      NextLine;
//    	Increment; sleep(200);
//    end;
    { here we can demonstrate the ability to turn on/off the transparent
    	printing of text on a background }
//    WriteLine(1.5, 3.5 - GetLineHeightInches, 'Transparent = false');
//    WriteLine(6.5, 3.5 - GetLineHeightInches, 'Transparent = true');
//    SetTransparent(false); // turn off transparency
//    DrawBoxShade(1.2, 3.5, 2.7, 4.5, 1, clSilver);
//    DrawBoxShade(6.2, 3.5, 7.7, 4.5, 1, clSilver);
//		WriteLine(1.6, 3.8, 'Hello There!');
//    SetTransparent(true); // turn on transparency
//    WriteLine(6.6, 3.8, 'Hello There!');

    { now we'll just draw a 2 color box and put some text in it
      first, we draw a box 3 inches wide by 2 inches high
      then, we use WriteLine to position text in the upper left corner,
      WriteLineCenterToX to position text in the center of the box,
      and WriteLineRightToX to position text in the lower right hand corner}
//    SetPenColor(clBlue);
//    DrawBox(3.0, 6.0, 6.0, 8.0, 2);
//    SetPenColor(clRed);
//    DrawBox(2.97, 5.97, 6.03, 8.03, 2);
//    SetPenColor(clBlack);
//    WriteLine(3.0, 6.0, 'Upper left corner of box');
//    WriteLineCenterToX(4.5, 7.0, 'Centered in box!');
//    WriteLineRightToX(6.0, 8.0 - GetLineHeightInches, 'Lower right corner of box ');
//    SetProgressText('Printing Complete'); sleep(500);
  	Quit;
  end;
end;

////Edition
// préparation des titres, du haut de page et du Pied de page
procedure TObjetEdition.SetPageDefaults;
// I usually create separate default routines so that I can call them separately
// based on the type of report I want to perform. This serves as a generic
// procedure to set up intial header, footers and page number display.
var
  Font: TFont;
begin
try//finally
  TopMargin_Objet:= 1.5;
  case Orientation of
     poLandscape:BottomMargin_Objet:= 8.5;
     poPortrait:BottomMargin_Objet:= 11;
  end;

  FLeftMargin_Objet:= 0.5;
  FRightMargin_Objet:= 0.5;

  LetterBottomMargin:= 1.5;
  LegalBottomMargin:= 1.5;


    SetMeasure(mtInches);
    if FParamEdition.AffichDefaut then
      Orientation := poLandscape;
    //SetMeasure(mtPixels);
    Font := TFont.Create;
    Font.Name := 'Times New Roman';
    Font.Size := 8;
    Font.Style := [];
    Font.Color := clBlack;
    SetFontInfo(Font);
    SetPageMargins(FLeftMargin_Objet, TopMargin_Objet, FLeftMargin_Objet, TopMargin_Objet);
    //Font.Color := clBlue;
    Font.Size := 12;
    Font.Style := [fsBold];


    SetHeaderInfo(1, 0.6, FParamEdition.Titre, wtCenter, Font);
    //Font.Color := clRed;
//    SetHeaderInfo(2, 0.9, 'Déclaration du  au ', wtCenter, Font);
    SaveCurrentFont;
    Font.Size := 16;
    Font.Style := [fsBold];
    SetFontInfo(Font);
    SetHeaderDim(FLeftMargin_Objet, TopMargin_Objet, FRightMargin_Objet, TopMargin_Objet + (GetLineHeightInches * 1.5),
    							false, 1, RGB(255, 255, 255));
    SetDetailTopBottom(TopMargin_Objet + (GetLineHeightInches * 1.5), BottomMargin_Objet - 0.5);
    Font.Name := 'Times New Roman';
    Font.Size := 8;
    Font.Style := [fsitalic];
    //Font.Color := clAqua;
    SetFooterDim(FLeftMargin_Objet, BottomMargin_Objet - 0.4, FRightMargin_Objet, BottomMargin_Objet, false, 1,
      RGB(255, 255, 255));
    SetFooterInfo(1, BottomMargin_Objet - 0.5, 'Page Footer Line #1.', 1, Font);
    if PrintPageNumbers then
    	SetPageNumberInfo(BottomMargin_Objet - 0.3, 'page %d', wtLeft, ShowTotalPages, Font);
    Font.Name := 'Times New Roman';
    Font.Size := 8;
    Font.Style := [];
    Font.Color := clBlack;
    SetFontInfo(Font);
//    Font.Free;

finally
  LibereObjet(Tobject(font));
end;

    ///
end;


procedure TObjetEdition.SetPageDefaultsLGR;
// I usually create separate default routines so that I can call them separately
// based on the type of report I want to perform. This serves as a generic
// procedure to set up intial header, footers and page number display.
var
  Font: TFont;
begin
try//finally
  TopMargin_Objet:= 1.2;  // Taille de l'entête
//  TopMargin_Objet:= 1;  // Taille de l'entête
  case Orientation of
//     poLandscape:BottomMargin_Objet:= 8.5;
    poLandscape:begin
                   BottomMargin_Objet:= 7.25;  { isa  le  09/02/04 }
                   if LeftMargin_Objet<>-1 then FLeftMargin_Objet:=LeftMargin_Objet else FLeftMargin_Objet:= 0.3;
                   if RightMargin_Objet<>-1 then FRightMargin_Objet:=RightMargin_Objet else FRightMargin_Objet:= 0.5;
                end;
     poPortrait:begin
                   BottomMargin_Objet:= 10.65;
                   if LeftMargin_Objet<>-1 then FLeftMargin_Objet:=LeftMargin_Objet else FLeftMargin_Objet:= 0.3;
                   if RightMargin_Objet<>-1 then FRightMargin_Objet:=RightMargin_Objet else FRightMargin_Objet:= 0.5;
                end;
  end;

//  LeftMargin_Objet:= 0.36;
//  RightMargin_Objet:= 0.36;
  LetterBottomMargin:= 1.5;
  LegalBottomMargin:= 1.5;

    SetMeasure(mtInches);
    if FParamEdition.AffichDefaut then
      Orientation := poLandscape;
//    FParamEdition.AffichDefaut := false;
//      Orientation := poPortrait;
    //SetMeasure(mtPixels);
    Font := TFont.Create;
    Font.Name := 'Times New Roman';
    Font.Size := 8;
    Font.Style := [];
    Font.Color := clBlack;
    SetFontInfo(Font);
    SetPageMargins(FLeftMargin_Objet, TopMargin_Objet, FLeftMargin_Objet, TopMargin_Objet);
    //Font.Color := clBlue;
    Font.Size := 12;
    Font.Style := [fsBold];


//    SetHeaderInfo(1, 0.6, FParamEdition.Titre, wtCenter, Font);
    //Font.Color := clRed;
    SetHeaderInfo(1, 0.1, FTitreEdition+' - '+FSousTitreEdition , wtCenter, Font);


    Font.Size := 10;
    Font.Style := [fsBold];
    SetFontInfo(Font);

    SetHeaderInfo(2, GetLineHeight*3, FNomDossier, wtCenter, Font);

    Font.Style := [];

    SetHeaderInfo(3, GetLineHeight*4, FTitre2Edition, wtCenter, Font);
    SetHeaderInfo(4, GetLineHeight*5, FTitre3Edition, wtCenter, Font);
    SaveCurrentFont;
    Font.Size := 16;
    Font.Style := [fsBold];
    SetFontInfo(Font);
    SetHeaderDim(FLeftMargin_Objet, TopMargin_Objet, FRightMargin_Objet, TopMargin_Objet ,
    							false, 1, RGB(255, 255, 255));
//    SetHeaderDim(LeftMargin_Objet, TopMargin_Objet, RightMargin_Objet, TopMargin_Objet + (GetLineHeightInches * 1.5),
//    							false, 1, RGB(255, 255, 255));
    SetDetailTopBottom(TopMargin_Objet, BottomMargin_Objet);
//    SetDetailTopBottom(TopMargin_Objet, BottomMargin_Objet - 0.5);
//    SetDetailTopBottom(TopMargin_Objet + (GetLineHeightInches * 1.5), BottomMargin_Objet - 0.5);
    Font.Name := 'Times New Roman';
    Font.Size := 8;
    Font.Style := [fsitalic];
    //Font.Color := clAqua;
//    SetFooterDim(LeftMargin_Objet, BottomMargin_Objet - 0.4, RightMargin_Objet, BottomMargin_Objet, false, 1,
//      RGB(255, 255, 255));
    SetFooterDim(FLeftMargin_Objet, BottomMargin_Objet - 0.0, FRightMargin_Objet, BottomMargin_Objet, false, 1,
      RGB(255, 255, 255));
    SetFooterInfo(1, BottomMargin_Objet + 0.2, 'Edité le '+DateToStr(Now)+' à '+TimeToStr(Now) , 1, Font);
    if PrintPageNumbers then
    	SetPageNumberInfo(BottomMargin_Objet + 0.2, 'Page %d', wtRight, ShowTotalPages, Font);
    Font.Name := 'Times New Roman';
    Font.Size := 8;
    Font.Style := [];
    Font.Color := clBlack;
    SetFontInfo(Font);
//    Font.Free;

finally
  LibereObjet(Tobject(font));
end;
    ///
end;


procedure TObjetEdition.SetPropertyDisplay;
// Procedure to intialize the property display components to the current
// settings of the Prn object being used by this program.
begin
// 	AutoPaging.ItemIndex := AutoPaging.Items.IndexOf(BooleanString(Prn.AutomaticPaging));
// 	AutoFeed.ItemIndex := AutoFeed.Items.IndexOf(BooleanString(Prn.AutoPageFeed));
// 	Clipping.ItemIndex := Clipping.Items.IndexOf(BooleanString(Prn.ClipColumns));
//  NumCopies.Text := IntToStr(Prn.Copies);
//  if Prn.Orientation = poPortrait then
//  	Layout.ItemIndex := Layout.Items.IndexOf('Portrait')
//  else
//  	Layout.ItemIndex := Layout.Items.IndexOf('Landscape');
//  Size.ItemIndex := Size.Items.IndexOf(getEnumName(typeInfo(PaperSizes), ord(Prn.PaperSize)));
// 	LookFirst.ItemIndex := LookFirst.Items.IndexOf(BooleanString(Prn.Preview));
//  PrintPgNum.ItemIndex := PrintPgNum.Items.IndexOf(BooleanString(Prn.PrintPageNumbers));
//  Quality.ItemIndex := Quality.Items.IndexOf(getEnumName(typeInfo(PrintQualities),
//  											ord(Prn.PrintQuality)));
//  Progress.ItemIndex := Progress.Items.IndexOf(BooleanString(Prn.ShowProgress));
//  ProgPercent.ItemIndex := ProgPercent.Items.IndexOf(BooleanString(Prn.ShowProgressPercent));
//  ShowPages.ItemIndex := ShowPages.Items.IndexOf(BooleanString(Prn.ShowTotalPages));
//  PrevPercent.ItemIndex := PrevPercent.Items.IndexOf(getEnumName(typeInfo(Percentages),
//  											ord(Prn.StartPercent)));
//  Transparency.ItemIndex := Transparency.Items.IndexOf(BooleanString(Prn.Transparent));
//  LargeFonts.ItemIndex := LargeFonts.Items.IndexOf(BooleanString(Prn.UseLargeFontAdjust));
end;

procedure TObjetEdition.GetPropertyDisplay;
// Procedure to transfer the settings from the display components to
// the Prn object.
begin
//	Prn.AutomaticPaging := ANSICompareText(AutoPaging.Text, 'true') = 0;
//  Prn.AutoPageFeed := ANSICompareText(AutoFeed.Text, 'true') = 0;
//  Prn.ClipColumns := ANSICompareText(Clipping.Text, 'true') = 0;
//  Prn.Copies := StrToInt(NumCopies.Text);
//  if ANSICompareText(Layout.Text, 'Portrait') = 0 then
//  	Prn.Orientation := poPortrait
//  else
//  	Prn.Orientation := poLandscape;
//  Prn.PaperSize := PaperSizes(getEnumValue(typeInfo(PaperSizes), Size.Text));
//  Prn.Preview := ANSICompareText(LookFirst.Text, 'true') = 0;
//  Prn.PrintPageNumbers := ANSICompareText(PrintPgNum.Text, 'true') = 0;
//  Prn.PrintQuality := PrintQualities(getEnumValue(typeInfo(PrintQualities), Quality.Text));
//  Prn.ShowProgress := ANSICompareText(Progress.Text, 'true') = 0;
//  Prn.ShowProgressPercent := ANSICompareText(ProgPercent.Text, 'true') = 0;
//	Prn.ShowTotalPages := ANSICompareText(ShowPages.Text, 'true') = 0;
//  Prn.StartPercent := Percentages(getEnumValue(typeInfo(Percentages), PrevPercent.Text));
//  Prn.Transparent := ANSICompareText(Transparency.Text, 'true') = 0;
//  Prn.UseLargeFontAdjust := ANSICompareText(LargeFonts.Text, 'true') = 0;
end;


procedure TObjetEdition.PrnSetupBtnClick(Sender: TObject);
// used to first set the Prn object to the values in the properties display
// then display the Windows printer setup dialog and finally to transfer
// the settings back to the properties display in case of changes
var
	PSD: TPrinterSetupDialog;

begin
try
	GetPropertyDisplay;
	SetPrinterSpecs;
  PSD := TPrinterSetupDialog.Create(nil);
  PSD.Execute;
  GetPrinterSpecs;
  SetPropertyDisplay;
finally
  PSD.Free;
//  LibereObjet(Tobject(PSD));
end;
end;

procedure TObjetEdition.PrnNewPage(Sender: TObject);
// This routine is called in the OnNewPage event to place my graphic
// at the top of each page.
begin
  if Flogo<> nil then
    PrintGraphic(0.25, 0.25, -1.0, -1.0, Flogo);
  if Pages.Count>1 then
    begin
//      SetPageDefaults;
//      SetFormatColonne;
//      SetPageDefaultsLGR;
      SetFormatColonneLGR;
//      NewLines(2);
//      SetYPosition(DEtailTop+5);

//      NextLine;
    end;
end;

procedure TObjetEdition.PrnAfterNewPage(Sender: TObject);
begin
if FSurTitre1 <> '' then
  begin         { isa  le  09/02/04 }
      if FSurTitre2 <> '' then
        begin
          if FSurTitre2Double then
            NewLines(6) //si surtitre2 double
          else
            NewLines(5)// si surtitre2 normal
        end
      else //si que surtitre 1
        NewLines(4)
 end //si surtitre 1
else
  NewLines(3);
end;

procedure TObjetEdition.SetFormatColonne;
var
Taille:Double;
i:integer;
begin
    ///construction des colonnes
    SetPageMargins(0.5, 0.5, 0.1, 0.5);
    //SetPageMargins(LeftMargin_Objet, TopMargin_Objet, LeftMargin_Objet, TopMargin_Objet);
    //création des colonnes
    Taille:=(Pages.tPageWidth-1)/(high(FTabTitreColonne)+1);
    //création des colonnes
    for i:=0 to high(FTabTitreColonne) do
      Begin
        if i=0 then
          CreateColumn(i+1, 0.30, Taille)
        else
          begin
            CreateColumn(i+1, GetColumnRight(i),Taille );
          end;
        //titre des colonnes
        TextColumnBox(GetColumnLeft(i+1), GetYPosition, GetColumnRight(i+1),
    							GetYPosition + GetLineHeightInches, round(GetTextWidthInches(FTabTitreColonne[i])),
                  RGB(255,255,255), FTabTitreColonne[i], i+1, wtLeft);
      end;

//    Increment; sleep(200);

end;
///fin Edition

Function TObjetEdition.ChangePointEnDecimalSeparator(Valeur:String):String;
var
i:integer;
Begin
result := '';
for i:=1 to length(Valeur) do
 begin
  Result:=Result + valeur[i];
  if result[i] in ['.',','] then
   result[i] := DecimalSeparator;
 end;
End;

procedure TObjetEdition.SetFormatColonneLGR;
var
Taille:Double;
i,NbCol:integer;
Font:TFont;
NbDESurTitre:Double;
Text1,Text2:string;
Retour:RetourPosition;
LigneCourante:double;
Left:double;
begin
try//finally
    ///construction des colonnes
//    SetPageDefaultsLGR;
//    SetPageMargins(0.5, 0.5, 0.5, 0.5);
    //SetPageMargins(LeftMargin_Objet, TopMargin_Objet, LeftMargin_Objet, TopMargin_Objet);
    //création des colonnes
//    Taille:=(Pages.tPageWidth-1)/(high(FTabTitreColonne)+1);

    Font := TFont.Create;
    Font.Name := 'Times New Roman';
    Font.Size := 10;
    Font.Style := [fsBold];
    Font.Color := clBlack;
    SetFontInfo(Font);
    NbDESurTitre:=0;
  case Orientation of
//     poLandscape:BottomMargin_Objet:= 8.5;
    poLandscape:begin
                   Left:= 0.3;
                end;
     poPortrait:begin
                   Left:= 0.36;
                end;
  end;

    if not empty(FSurTitre1) then
      begin
       if not empty(FSurTitre2) then
         NbDESurTitre:=2
       else
         NbDESurTitre:=1;
        NbCol:=Str_Count_Str(FDelimiteur,FSurTitre1);

        // Section des SurTitres
        //création des colonnes
        for i:=0 to NbCol-1 do
          Begin
            if i=0 then
              CreateColumn(i+1, Left, StrToFloat_Lgr(ChangePointEnDecimalSeparator(str_getstringelement(FLargeurSurTitre1,i+1,FDelimiteur))))
            else
              begin
                CreateColumn(i+1, GetColumnRight(i),StrToFloat(ChangePointEnDecimalSeparator(str_getstringelement(FLargeurSurTitre1,i+1,FDelimiteur))));
              end;
          end;
          SetTopOfPage;

            //Surtitre des colonnes
        for i:=0 to NbCol-1 do
          Begin
            if FSurTitre1Double then
              begin
              text2:='';
              Text1:=str_getstringelement(FSurTitre1,i+1,FDelimiteur);
              Retour:=str_recherchesouschaine(Text1,'*&*');
              if retour.retour then
                begin
                  text1:=copy(text1,1,retour.Position-1);
                  text2:=str_getstringelement(FSurTitre1,i+1,FDelimiteur);
                  text2:=copy(text2,length(text1)+2,length(text2)-length(text1)-1);
                  //str_position
                end;
              ligneCourante:=GetYPosition;
              TextColumnBox(GetColumnLeft(i+1), GetYPosition, GetColumnRight(i+1),
                      GetYPosition + GetLineHeightInches+GetLineHeightInches, 1,
                      RGB(255,255,255), Text1,  i+1, wtCenter);
              if not empty(text2) then
                 WriteLineColumnCenter(i+1,GetYPosition + GetLineHeightInches,Text2);
              SetYPosition(lignecourante);
              end
            else
              TextColumnBox(GetColumnLeft(i+1), GetYPosition, GetColumnRight(i+1),
                      GetYPosition + GetLineHeightInches, 1,
                      RGB(255,255,255), str_getstringelement(FSurTitre1,i+1,FDelimiteur), i+1, wtCenter);
          end;
         if FSurTitre1Double then
           SetYPosition(GetYPosition+GetLineHeight+GetLineHeight);
        // Fin Section des SurTitres
      end;


    if not empty(FSurTitre2) then
      begin
       NbDESurTitre:=2;
       NbCol:=Str_Count_Str(FDelimiteur,FSurTitre2);
        // Section des SurTitres
        //création des colonnes
        for i:=0 to NbCol-1 do
          Begin
            if i=0 then
              CreateColumn(i+1, Left, StrToFloat(ChangePointEnDecimalSeparator(str_getstringelement(FLargeurSurTitre2,i+1,FDelimiteur))))
            else
              begin
                CreateColumn(i+1, GetColumnRight(i),StrToFloat(ChangePointEnDecimalSeparator(str_getstringelement(FLargeurSurTitre2,i+1,FDelimiteur))));
              end;
          end;
        if ((NbDESurTitre > 0)and(FSurTitre1Double=false)) then
          SetYPosition(GetYPosition+GetLineHeight)
        else
          if NbDESurTitre = 0 then
            SetTopOfPage;

            //Surtitre des colonnes
        for i:=0 to NbCol-1 do
          Begin
            if FSurTitre2Double then
              begin
              text2:='';
              Text1:=str_getstringelement(FSurTitre2,i+1,FDelimiteur);
              Retour:=str_recherchesouschaine(Text1,'*&*');
              if retour.retour then
                begin
                  text1:=copy(text1,1,retour.Position-1);
                  text2:=str_getstringelement(FSurTitre2,i+1,FDelimiteur);
                  text2:=copy(text2,length(text1)+2,length(text2)-length(text1)-1);
                  //str_position
                end;
              ligneCourante:=GetYPosition;
              TextColumnBox(GetColumnLeft(i+1), GetYPosition, GetColumnRight(i+1),
                      GetYPosition + GetLineHeightInches+GetLineHeightInches, 1,
                      RGB(255,255,255), Text1,  i+1, wtCenter);
              if not empty(text2) then
                 WriteLineColumnCenter(i+1,GetYPosition + GetLineHeightInches,Text2);
              SetYPosition(lignecourante);
              end
            else
            TextColumnBox(GetColumnLeft(i+1), GetYPosition, GetColumnRight(i+1),
                      GetYPosition + GetLineHeightInches, 1,
                      RGB(255,255,255), str_getstringelement(FSurTitre2,i+1,FDelimiteur), i+1, wtCenter);
          end;
         if FSurTitre2Double then
           SetYPosition(GetYPosition+GetLineHeight+GetLineHeight);
        // Fin Section des SurTitres
      end;


    if not empty(FTitres) then
      begin
        NbCol:=Str_Count_Str(FDelimiteur,FTitres);

        //création des colonnes
        for i:=0 to NbCol do
          Begin
            if i=0 then
              CreateColumn(i+1, Left, StrToFloat(ChangePointEnDecimalSeparator(str_getstringelement(FLargeurTitre,i+1,FDelimiteur))))
            else
              begin
                CreateColumn(i+1, GetColumnRight(i),StrToFloat(ChangePointEnDecimalSeparator(str_getstringelement(FLargeurTitre,i+1,FDelimiteur))));
              end;
          end;
//        if NbDESurTitre > 0 then
//        SetYPosition(GetYPosition+GetLineHeight)
//        else SetTopOfPage;
        if ((NbDESurTitre > 0)and(FSurTitre2Double=false)) then
          SetYPosition(GetYPosition+GetLineHeight)
        else
          if NbDESurTitre = 0 then
            SetTopOfPage;
            //titre des colonnes
        for i:=0 to NbCol do
          Begin
            TextColumnBox(GetColumnLeft(i+1), GetYPosition, GetColumnRight(i+1),
                      GetYPosition + GetLineHeightInches, 1,
                      RGB(255,255,255), str_getstringelement(FTitres,i+1,FDelimiteur), i+1, wtCenter);
          end;
      end;

//    Increment; sleep(200);
    Font.Name := 'Times New Roman';
    Font.Size := 8;
    Font.Style := [];
    Font.Color := clBlack;
    SetFontInfo(Font);
//    Font.Free;
    NewLines(2);
finally
  LibereObjet(Tobject(font));
end;
end;


Procedure TObjetEdition.AffichageImp(ListValue:TStringList);
var
x,i,j,NbCol,DepartBoucle,Max:Integer;
Taille:Double;
ParamLigneFormatee:TParamLigneFormatee;
Begin
try
if FDelimiteur='' then Fdelimiteur:=';';
    if ListValue.Count = 0 then
     begin
      showmessage('Il n''y a pas de données à imprimer !');
      exit;
     end;
    Start;

    SetPageDefaultsLGR;
  case Orientation of
    poLandscape:begin
                   SetPageMargins(0.3, 0.3, 0.8, 0.3);
                end;
     poPortrait:begin
                   SetPageMargins(0.36, 0.36, 0.8, 0.36);
                end;
  end;

    //SetPageMargins(strtoint_lgr(inputbox('','','0.30')),strtoint_lgr(inputbox('','','1.2')),strtoint_lgr(inputbox('','','0.30')),strtoint_lgr(inputbox('','','1.2')));
    NewLines(2);
    FTitres:=ListValue.Strings[0];
    FLargeurTitre :=ListValue.Strings[1];
    FTypeCol:=ListValue.Strings[2];
    
//    ListValue.Strings[3]
   if ListValue.Count >4 then
   begin
    Max:=Str_Count_Str(FDelimiteur,ListValue.Strings[3])+1;
    if copy(UPPERCASE(str_getstringelement(ListValue.Strings[3],Max,FDelimiteur)),1,8) = 'SURTITRE' then
     begin
        FSurTitre1 := ListValue.Strings[3];
        FLargeurSurTitre1 := ListValue.Strings[4];
        FSurTitre1Double:=UPPERCASE(str_getstringelement(ListValue.Strings[3],Max,FDelimiteur)) = 'SURTITREDOUBLE' ;
     end;
   end;

   if ListValue.Count >6 then //si 2ième surTitre
   begin
    Max:=Str_Count_Str(FDelimiteur,ListValue.Strings[5])+1;
    if copy(UPPERCASE(str_getstringelement(ListValue.Strings[5],Max,FDelimiteur)),1,8) = 'SURTITRE' then
     begin
        FSurTitre2 := ListValue.Strings[5];
        FLargeurSurTitre2 := ListValue.Strings[6];
        FSurTitre2Double:=UPPERCASE(str_getstringelement(ListValue.Strings[5],Max,FDelimiteur)) = 'SURTITREDOUBLE';
     end;
   end;
    SetFormatColonneLGR;
//    NewPage;
    { create 3 columns to print text in }
//    Taille:=(Pages.tPageWidth-1)/(NbCol+1);
////    // creation des titre de colonnes
//    for i:=0 to NbCol do
//      Begin
//        if i=0 then
//          CreateColumn(i+1, 0.5, Taille)
//        else
//          begin
//            CreateColumn(i+1, GetColumnRight(i),Taille );
//          end;
//      end;
//    for i :=1 to NbCol do
//     begin
//     if i=1 then
//      CreateColumn(i, 0.5, 1.5)
//      else
//      CreateColumn(i, GetColumnRight(i-1), 2.0);
////      CreateColumn(3, GetColumnRight(2), 3.0);
//     end;
////    Increment;
//    SetTopOfPage;
//    { here we print boxed column headers using TextColumnBox }
//    TextColumnBox(GetColumnLeft(1), GetYPosition, GetColumnRight(1),
//    							GetYPosition + GetLineHeightInches, 1,
//                  RGB(255,255,255), 'Column 1', 1, wtLeft);
//    TextColumnBox(GetColumnLeft(2), GetYPosition, GetColumnRight(2),
//    							GetYPosition + GetLineHeightInches, 1,
//                  RGB(220,220,220), 'Column 2', 2, wtCenter);
//    TextColumnBox(GetColumnLeft(3), GetYPosition, GetColumnRight(3),
//    							GetYPosition + GetLineHeightInches, 1,
//                  RGB(240,240,240), 'Column 3', 3, wtRight);
////    Increment;
//		{ now we need to print a few lines of information in the columns
//    	using left justification for column 1, center justification for
//      column 2 and decimal alignment for column 3 }
//    NewLines(2);
    DepartBoucle:=3;
    if FSurTitre2 <> '' then DepartBoucle:=7
    else
      if FSurTitre1 <> '' then DepartBoucle:=5;
    for x := DepartBoucle to ListValue.Count-1 do
    begin
      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '-1' then
       LignesClassiqueBox(ListValue.Strings[x],FTypeCol,(x mod 2)=0);

      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '0' then
       LignesClassique(ListValue.Strings[x],FTypeCol,(x mod 2)=0);

      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '1' then
         TotalSeul(ListValue.Strings[x]);

      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '2' then
         TotalPremier(ListValue.Strings[x]);

      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '3' then
         TotalMilieu(ListValue.Strings[x]);

      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '4' then
         TotalDernier(ListValue.Strings[x]);

      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '1+' then
         TotalSeul(ListValue.Strings[x]);

      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '2+' then
         TotalPremier(ListValue.Strings[x]);

      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '3+' then
         TotalMilieu(ListValue.Strings[x]);

      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '4+' then
         TotalDernier(ListValue.Strings[x]);

      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '5' then
         LigneSimpleSeule(ListValue.Strings[x],wtLeft);

      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '6' then
         LigneSimplePremiere(ListValue.Strings[x],wtLeft);

      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '7' then
         LigneSimpleMilieu(ListValue.Strings[x],wtLeft);

      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '8' then
         LigneSimpleDerniere(ListValue.Strings[x],wtLeft);

      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '9' then
         LigneSimpleDerniereFormatee(ListValue.Strings[x],wtLeft);

      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '10' then
         LigneSimpleDerniereFormatee(ListValue.Strings[x],wtCenter); //ligne idem que la 9 mais centrée

      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '11' then
         TotalMilieuLibelle(ListValue.Strings[x],true);

      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '12' then
             DessineLigne(50,0);

      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '13' then
       begin
         ParamLigneFormatee.Valeur := str_getstringelement(ListValue.Strings[x],2,FDelimiteur);
         ParamLigneFormatee.Alignement := StrToInt(str_getstringelement(ListValue.Strings[x],3,FDelimiteur));
         ParamLigneFormatee.Taille := StrToInt(str_getstringelement(ListValue.Strings[x],4,FDelimiteur));
         ParamLigneFormatee.Style := [fsBold];
//         ParamLigneFormatee.Style := str_getstringelement(ListValue.Strings[x],5,FDelimiteur);
         ParamLigneFormatee.Position := StrToInt(str_getstringelement(ListValue.Strings[x],6,FDelimiteur));
         LigneSimpleFormatee(ParamLigneFormatee);
       end;

      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '14' then
           LigneCompteBal(ListValue.Strings[x],wtLeft);

      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '15' then
           NewPage;
      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '16' then
         LignePlanCpt(ListValue.Strings[x],15 * (x mod 2));

      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '20' then
       LigneSautDePage;

//      if str_getstringelement(ListValue.Strings[x],1,FDelimiteur) = '21' then
//       NextLine;
      NextLine;
//    	Increment;
    end;
except
   abort;
   //showmessage('Problème sur la ligne X = '+inttostr(x));
end;
  quit;
End;

Procedure TObjetEdition.LignesClassique(Valeurs,ValeursType:String;Gris:Boolean);//0
var
i,NbCol:integer;
Font:Tfont;
Begin
//Font.
//can
//self.Pages.StoreBColor(clGray);
//     with TFont.Create do
//      begin
//        if Gris then setBrushColor(clred);
//        if Gris then self.Pages.StoreFColor(clred);
//        if Gris then TheCanvas.Brush.Color := clgray;
        //if Gris then SetBrushColor(clgray);
        NbCol:=Str_Count_Str(FDelimiteur,Valeurs);
         for i:=1 to NbCol do
          begin
           case ValeurType(ValeursType,i) of
             wtLeft:WriteLineColumnAlign(i, -2.0, str_getstringelement(Valeurs,i+1,FDelimiteur), wtLeft);
             wtRight:WriteLineColumnAlign(i, -2.0, str_getstringelement(Valeurs,i+1,FDelimiteur), wtRight);
             wtDecimal:WriteLineColumnAlign(i, -2.0, str_QueDesChiffresCurr(str_getstringelement(Valeurs,i+1,FDelimiteur),FFormatMonnaie), wtRight);
//             wtDecimal:WriteLineColumnAlign(i, -2.0, str_QueDesChiffresCurr(str_getstringelement(Valeurs,i+1,FDelimiteur))+' '+FSigleMonnaie, wtDecimal);
else WriteLineColumnAlign(i, -2.0, str_getstringelement(Valeurs,i+1,FDelimiteur), ValeurType(ValeursType,i));
           end;

         end;
//        TheCanvas.Brush.Color := clBlack;
//        SetBrushColor(clblack);
//       free;
//       end;
//      NextLine;
End;

Procedure TObjetEdition.LignesClassiqueBox(Valeurs,ValeursType:String;Gris:Boolean);//-1
var
i,NbCol:integer;
Font:Tfont;
PosColLeft,PosColRight:Double;
Begin

      PosColLeft:=GetColumnLeft(1);
      PosColRight:=GetColumnRight(1);
    NbCol:=Str_Count_Str(FDelimiteur,Valeurs);
     for i:=1 to NbCol do
      begin
        case ValeurType(ValeursType,i) of
               wtLeft:          TextColumnBox(PosColLeft, GetYPosition, PosColRight,
                        GetYPosition + GetLineHeightInches, 1,
                        RGB(255,255,255), str_getstringelement(Valeurs,i+1,FDelimiteur), i, wtLeft);
               wtRight:          TextColumnBox(PosColLeft, GetYPosition, PosColRight,
                        GetYPosition + GetLineHeightInches, 1,
                        RGB(255,255,255), str_getstringelement(Valeurs,i+1,FDelimiteur), i, wtRight);
               wtDecimal:          TextColumnBox(PosColLeft, GetYPosition, PosColRight,
                        GetYPosition + GetLineHeightInches, 1,
                        RGB(255,255,255), str_QueDesChiffresCurr(str_getstringelement(Valeurs,i+1,FDelimiteur),FFormatMonnaie), i, wtRight);
              else TextColumnBox(PosColLeft, GetYPosition, PosColRight,
                        GetYPosition + GetLineHeightInches, 1,
                        RGB(255,255,255), str_getstringelement(Valeurs,i+1,FDelimiteur), i, ValeurType(ValeursType,i));
        end;



          if i < NbCol then
           begin
            PosColLeft:=GetColumnLeft(i+1);
            PosColRight:=GetColumnRight(i+1);
           end;
     end;
End;

Procedure TObjetEdition.TotalSeulLibelle(Valeurs:String); //1+
var
i,NbCol:integer;
PosColLeft,PosColRight:Double;
TextTmp:string;
Font:TFont;
Begin
try//finally
Font:=TFont.Create;
TextTmp:=C_StrVide;
    NewLines(2);
      if GetYPosition+1 >= BottomMargin_Objet then
           NewLines(2);
      NbCol:=Str_Count_Str(FDelimiteur,Valeurs);
      PosColLeft:=GetColumnLeft(1);
      PosColRight:=GetColumnRight(1);
       for i:=1 to NbCol do
        begin
        if str_getstringelement(Valeurs,i+1,FDelimiteur) <> '' then
         begin
          if str_recherchesouschaine(str_getstringelement(Valeurs,i+1,FDelimiteur),'*@*').retour then
            begin
              Font:=TFont.Create;
              Font.Name := 'Times New Roman';
              Font.Style := [fsBold]; // ,
              SetFontInfo(Font);
              TextTmp:=str_remplacesouschaine(str_getstringelement(Valeurs,i+1,FDelimiteur),'@','');
              WriteLineRightToX(PosColRight,GetYPosition,TextTmp);
              Font.Style := [];
              SetFontInfo(Font);
            end
          else
          TextColumnBox(PosColLeft, GetYPosition, PosColRight,
                        GetYPosition + GetLineHeightInches, 1,
                        RGB(220,220,220), str_getstringelement(Valeurs,i+1,FDelimiteur), i, wtRight);
           if i < NbCol then
           begin
            PosColLeft:=GetColumnLeft(i+1);
            PosColRight:=GetColumnRight(i+1);
           end;
         end
         else
          begin
           if i < NbCol then
            PosColRight:=GetColumnRight(i+1);
          end;
       end;
      NextLine;
finally
  LibereObjet(Tobject(font));
end;
End;
Procedure TObjetEdition.TotalPremierLibelle(Valeurs:String);//2+
var
i,NbCol:integer;
PosColLeft,PosColRight:Double;
TextTmp:string;
Font:TFont;
Begin
try//finally
Font:=TFont.Create;
TextTmp:=C_StrVide;
    NewLines(2);
      if GetYPosition+1 >= BottomMargin_Objet then
           NewLines(2);
      NbCol:=Str_Count_Str(FDelimiteur,Valeurs);
      PosColLeft:=GetColumnLeft(1);
      PosColRight:=GetColumnRight(1);
       for i:=1 to NbCol do
        begin
        if str_getstringelement(Valeurs,i+1,FDelimiteur) <> '' then
         begin
          if str_recherchesouschaine(str_getstringelement(Valeurs,i+1,FDelimiteur),'*@*').retour then
            begin
              Font:=TFont.Create;
              Font.Name := 'Times New Roman';
              Font.Style := [fsBold]; // ,
              SetFontInfo(Font);
              TextTmp:=str_remplacesouschaine(str_getstringelement(Valeurs,i+1,FDelimiteur),'@','');
              WriteLineRightToX(PosColRight,GetYPosition,TextTmp);
              Font.Style := [];
              SetFontInfo(Font);
            end
          else
          TextColumnBox(PosColLeft, GetYPosition, PosColRight,
                        GetYPosition + GetLineHeightInches, 1,
                        RGB(255,255,255), str_getstringelement(Valeurs,i+1,FDelimiteur), i, wtRight);
           if i < NbCol then
           begin
            PosColLeft:=GetColumnLeft(i+1);
            PosColRight:=GetColumnRight(i+1);
           end;
         end
         else
          begin
           if i < NbCol then
            PosColRight:=GetColumnRight(i+1);
          end;
       end;
finally
  LibereObjet(Tobject(font));
end;
End;
Procedure TObjetEdition.TotalMilieuLibelle(Valeurs:String;AvecEspaces:boolean=false);//3+
var
i,j,NbCol:integer;
PosColLeft,PosColRight:Double;
TextTmp:string;
Font:TFont;
Begin
try//finally
Font:=TFont.Create;
TextTmp:=C_StrVide;
if AvecEspaces then NewLines(1);
      if GetYPosition+1 >= BottomMargin_Objet then
           NewLines(2);
      NbCol:=Str_Count_Str(FDelimiteur,Valeurs);
      PosColLeft:=GetColumnLeft(1);
      PosColRight:=GetColumnRight(1);
       for i:=1 to NbCol do
        begin
        if str_getstringelement(Valeurs,i+1,FDelimiteur) <> '' then
         begin
          if str_recherchesouschaine(str_getstringelement(Valeurs,i+1,FDelimiteur),'*@*').retour then
            begin
              Font:=TFont.Create;
              Font.Name := 'Times New Roman';
              Font.Style := [fsBold]; // ,
              SetFontInfo(Font);
              TextTmp:=str_remplacesouschaine(str_getstringelement(Valeurs,i+1,FDelimiteur),'@','');
              WriteLineRightToX(PosColRight,GetYPosition,TextTmp);
              Font.Style := [];
              SetFontInfo(Font);
            end
          else
            begin
             if AvecEspaces then
                TextColumnBox(PosColLeft, GetYPosition, PosColRight,
                            GetYPosition + GetLineHeightInches, 1,
                            RGB(240,240,240), str_getstringelement(Valeurs,i+1,FDelimiteur), i, wtRight)
             else
                TextColumnBox(PosColLeft, GetYPosition, PosColRight,
                            GetYPosition + GetLineHeightInches, 1,
                            RGB(255,255,255), str_getstringelement(Valeurs,i+1,FDelimiteur), i, wtRight);
            end;
           if i < NbCol then
           begin
            PosColLeft:=GetColumnLeft(i+1);
            PosColRight:=GetColumnRight(i+1);
           end;
         end
         else
          begin
           if i < NbCol then
            PosColRight:=GetColumnRight(i+1);
          end;
       end;
finally
  LibereObjet(Tobject(font));
end;
End;
Procedure TObjetEdition.TotalDernierLibelle(Valeurs:String);//4+
var
i,NbCol:integer;
PosColLeft,PosColRight:Double;
TextTmp:string;
Font:TFont;
Begin
try//finally
Font:=TFont.Create;
TextTmp:=C_StrVide;
      if GetYPosition+1 >= BottomMargin_Objet then
           NewLines(2);
      NbCol:=Str_Count_Str(FDelimiteur,Valeurs);
      PosColLeft:=GetColumnLeft(1);
      PosColRight:=GetColumnRight(1);
       for i:=1 to NbCol do
        begin
        if str_getstringelement(Valeurs,i+1,FDelimiteur) <> '' then
         begin
          if str_recherchesouschaine(str_getstringelement(Valeurs,i+1,FDelimiteur),'*@*').retour then
            begin
              Font:=TFont.Create;
              Font.Name := 'Times New Roman';
              Font.Style := [fsBold]; // ,
              SetFontInfo(Font);
              TextTmp:=str_remplacesouschaine(str_getstringelement(Valeurs,i+1,FDelimiteur),'@','');
              WriteLineRightToX(PosColRight,GetYPosition,TextTmp);
              Font.Style := [];
              SetFontInfo(Font);
            end
          else
          TextColumnBox(PosColLeft, GetYPosition, PosColRight,
                        GetYPosition + GetLineHeightInches, 1,
                        RGB(255,255,255), str_getstringelement(Valeurs,i+1,FDelimiteur), i, wtRight);
           if i < NbCol then
           begin
            PosColLeft:=GetColumnLeft(i+1);
            PosColRight:=GetColumnRight(i+1);
           end;
         end
         else
          begin
           if i < NbCol then
            PosColRight:=GetColumnRight(i+1);
          end;
       end;
      NextLine;
finally
  LibereObjet(Tobject(font));
end;
End;


Procedure TObjetEdition.TotalSeul(Valeurs:String);//1
var
i,NbCol:integer;
PosColLeft,PosColRight:Double;
TextTmp:string;
Font:TFont;
Begin
try//finally
Font:=TFont.Create;
TextTmp:=C_StrVide;
    NewLines(2);
      if GetYPosition+1 >= BottomMargin_Objet then
           NewLines(2);
      NbCol:=Str_Count_Str(FDelimiteur,Valeurs);
      PosColLeft:=GetColumnLeft(1);
      PosColRight:=GetColumnRight(1);
       for i:=1 to NbCol do
        begin
        if str_getstringelement(Valeurs,i+1,FDelimiteur) <> '' then
         begin
          if str_recherchesouschaine(str_getstringelement(Valeurs,i+1,FDelimiteur),'*@*').retour then
            begin
              Font:=TFont.Create;
              Font.Name := 'Times New Roman';
              Font.Style := [fsBold]; // ,
              SetFontInfo(Font);
              TextTmp:=str_remplacesouschaine(str_getstringelement(Valeurs,i+1,FDelimiteur),'@','');
              WriteLineRightToX(PosColRight,GetYPosition,TextTmp);
              Font.Style := [];
              SetFontInfo(Font);
            end
          else
          TextColumnBox(PosColLeft, GetYPosition, PosColRight,
                        GetYPosition + GetLineHeightInches, 1,
                        RGB(220,220,220), str_QueDesChiffresCurr(str_getstringelement(Valeurs,i+1,FDelimiteur),FFormatMonnaie), i, wtRight);
           if i < NbCol then
           begin
            PosColLeft:=GetColumnLeft(i+1);
            PosColRight:=GetColumnRight(i+1);
           end;
         end
         else
          begin
           if i < NbCol then
            PosColRight:=GetColumnRight(i+1);
          end;
       end;
      NextLine;
finally
  LibereObjet(Tobject(font));
end;
End;

Procedure TObjetEdition.TotalPremier(Valeurs:String);//2
var
i,NbCol:integer;
PosColLeft,PosColRight:Double;
TextTmp:string;
Font:TFont;
Begin
try//finally
Font:=TFont.Create;
TextTmp:=C_StrVide;
    NewLines(2);
      if GetYPosition+1 >= BottomMargin_Objet then
           NewLines(2);
      NbCol:=Str_Count_Str(FDelimiteur,Valeurs);
      PosColLeft:=GetColumnLeft(1);
      PosColRight:=GetColumnRight(1);
       for i:=1 to NbCol do
        begin
        if str_getstringelement(Valeurs,i+1,FDelimiteur) <> '' then
         begin
          if str_recherchesouschaine(str_getstringelement(Valeurs,i+1,FDelimiteur),'*@*').retour then
            begin
              Font:=TFont.Create;
              Font.Name := 'Times New Roman';
              Font.Style := [fsBold]; // ,
              SetFontInfo(Font);
              TextTmp:=str_remplacesouschaine(str_getstringelement(Valeurs,i+1,FDelimiteur),'@','');
              WriteLineRightToX(PosColRight,GetYPosition,TextTmp);
              Font.Style := [];
              SetFontInfo(Font);
            end
          else
          TextColumnBox(PosColLeft, GetYPosition, PosColRight,
                        GetYPosition + GetLineHeightInches, 1,
                        RGB(255,255,255), str_QueDesChiffresCurr(str_getstringelement(Valeurs,i+1,FDelimiteur),FFormatMonnaie), i, wtRight);
           if i < NbCol then
           begin
            PosColLeft:=GetColumnLeft(i+1);
            PosColRight:=GetColumnRight(i+1);
           end;
         end
         else
          begin
           if i < NbCol then
            PosColRight:=GetColumnRight(i+1);
          end;
       end;
finally
  LibereObjet(Tobject(font));
end;
End;

//Procedure TObjetEdition.TotalMilieu(Valeurs:String);
//var
//i,NbCol:integer;
//PosColLeft,PosColRight:Double;
//PosColLeftSpecial:Double;
//Begin
//PosColLeftSpecial:=-1;
//      if GetYPosition+1 >= BottomMargin_Objet then
//           NewLines(2);
//      NbCol:=Str_Count_Str(FDelimiteur,Valeurs);
//      PosColLeft:=GetColumnLeft(1);
//      PosColRight:=GetColumnRight(1);
//       for i:=1 to NbCol do
//        begin
//        if str_getstringelement(Valeurs,i+1,FDelimiteur) <> '' then
//         begin
//          if str_getstringelement(Valeurs,i+1,FDelimiteur) <> '@' then
//              begin
//                  if PosColLeftSpecial<>-1 then
//                    begin
//                      PosColLeft:=PosColLeftSpecial;
//                      PosColLeftSpecial:=-1;
//                    end;
//                  TextColumnBox(PosColLeft, GetYPosition, PosColRight,
//                                GetYPosition + GetLineHeightInches, 1,
//                                RGB(255,255,255), str_getstringelement(Valeurs,i+1,FDelimiteur), i, wtRight);
//                   if i < NbCol then
//                   begin
//                    PosColLeft:=GetColumnLeft(i+1);
//                    PosColRight:=GetColumnRight(i+1);
//                   end;
//              end
//          else
//            begin
//                if PosColLeftSpecial=-1 then
//                  PosColLeftSpecial:=GetColumnLeft(i+1);
//                if i < NbCol then
//                  PosColRight:=GetColumnRight(i+1);
//            end;
//         end
//         else
//          begin
//           if i < NbCol then
//            PosColRight:=GetColumnRight(i+1);
//          end;
//       end;
//End;


Procedure TObjetEdition.TotalMilieu(Valeurs:String;AvecEspaces:boolean);//3(sans espaces) ou 11(avec espaces)
var
i,j,NbCol:integer;
PosColLeft,PosColRight:Double;
TextTmp:string;
Font:TFont;
Begin
try//finally
Font:=TFont.Create;
TextTmp:=C_StrVide;
if AvecEspaces then NewLines(1);
      if GetYPosition+1 >= BottomMargin_Objet then
           NewLines(2);
      NbCol:=Str_Count_Str(FDelimiteur,Valeurs);
      PosColLeft:=GetColumnLeft(1);
      PosColRight:=GetColumnRight(1);
       for i:=1 to NbCol do
        begin
        if str_getstringelement(Valeurs,i+1,FDelimiteur) <> '' then
         begin
          if str_recherchesouschaine(str_getstringelement(Valeurs,i+1,FDelimiteur),'*@*').retour then
            begin
              Font:=TFont.Create;
              Font.Name := 'Times New Roman';
              Font.Style := [fsBold]; // ,
              SetFontInfo(Font);
              TextTmp:=str_remplacesouschaine(str_getstringelement(Valeurs,i+1,FDelimiteur),'@','');
              WriteLineRightToX(PosColRight,GetYPosition,TextTmp);
              Font.Style := [];
              SetFontInfo(Font);
            end
          else
            begin
             if AvecEspaces then
                TextColumnBox(PosColLeft, GetYPosition, PosColRight,
                            GetYPosition + GetLineHeightInches, 1,
                            RGB(240,240,240), str_QueDesChiffresCurr(str_getstringelement(Valeurs,i+1,FDelimiteur),FFormatMonnaie), i, wtRight)
             else
                TextColumnBox(PosColLeft, GetYPosition, PosColRight,
                            GetYPosition + GetLineHeightInches, 1,
                            RGB(255,255,255), str_QueDesChiffresCurr(str_getstringelement(Valeurs,i+1,FDelimiteur),FFormatMonnaie), i, wtRight);
            end;
           if i < NbCol then
           begin
            PosColLeft:=GetColumnLeft(i+1);
            PosColRight:=GetColumnRight(i+1);
           end;
         end
         else
          begin
           if i < NbCol then
            PosColRight:=GetColumnRight(i+1);
          end;
       end;
finally
  LibereObjet(Tobject(font));
end;
End;



Procedure TObjetEdition.TotalDernier(Valeurs:String);//4
var
i,NbCol:integer;
PosColLeft,PosColRight:Double;
TextTmp:string;
Font:TFont;
Begin
try//finally
Font:=TFont.Create;
TextTmp:=C_StrVide;
      if GetYPosition+1 >= BottomMargin_Objet then
           NewLines(2);
      NbCol:=Str_Count_Str(FDelimiteur,Valeurs);
      PosColLeft:=GetColumnLeft(1);
      PosColRight:=GetColumnRight(1);
       for i:=1 to NbCol do
        begin
        if str_getstringelement(Valeurs,i+1,FDelimiteur) <> '' then
         begin
          if str_recherchesouschaine(str_getstringelement(Valeurs,i+1,FDelimiteur),'*@*').retour then
            begin
              Font:=TFont.Create;
              Font.Name := 'Times New Roman';
              Font.Style := [fsBold]; // ,
              SetFontInfo(Font);
              TextTmp:=str_remplacesouschaine(str_getstringelement(Valeurs,i+1,FDelimiteur),'@','');
              WriteLineRightToX(PosColRight,GetYPosition,TextTmp);
              Font.Style := [];
              SetFontInfo(Font);
            end
          else
          TextColumnBox(PosColLeft, GetYPosition, PosColRight,
                        GetYPosition + GetLineHeightInches, 1,
                        RGB(255,255,255), str_QueDesChiffresCurr(str_getstringelement(Valeurs,i+1,FDelimiteur),FFormatMonnaie), i, wtRight);
           if i < NbCol then
           begin
            PosColLeft:=GetColumnLeft(i+1);
            PosColRight:=GetColumnRight(i+1);
           end;
         end
         else
          begin
           if i < NbCol then
            PosColRight:=GetColumnRight(i+1);
          end;
       end;
      NextLine;
finally
  LibereObjet(Tobject(font));
end;
End;

Procedure TObjetEdition.LigneSimpleSeule(Valeurs:String;Align:Word);//5
var
i:integer;
Text:String;
Fonttmp:TFont;
Begin
text:='';
if GetYPosition+1 >= BottomMargin_Objet then
     NewLines(2);
for i:=1 to Str_Count_Str(FDelimiteur,Valeurs) do
 Text := text + str_getstringelement(Valeurs,i+1,FDelimiteur);
NextLine;
NextLine;

    SetFontInfo(FontLigneSeule);
    SaveCurrentFont;
    WriteLineAlign(GetYPosition,Text,Align);

try//finally
    Fonttmp:=TFont.Create;
    Fonttmp.Name := 'Times New Roman';
    Fonttmp.Size := 8;
    Fonttmp.Style := [];
    Fonttmp.Color := clBlack;
    SetFontInfo(Fonttmp);
    SaveCurrentFont;
//    Fonttmp.Free;

    NextLine;
finally
  LibereObjet(Tobject(fontTmp));
end;
End;

Procedure TObjetEdition.LigneSimplePremiere(Valeurs:String;Align:Word);//
var
i:integer;
Text:String;
Font:TFont;
Begin
try//finally
Font:=TFont.Create;
Font.Name := 'Times New Roman';
Font.Style := [fsBold,fsUnderline]; // ,
SetFontInfo(Font);

text:='';
for i:=1 to Str_Count_Str(FDelimiteur,Valeurs) do
 Text := text + str_getstringelement(Valeurs,i+1,FDelimiteur);
NextLine;
NextLine;
WriteLineAlign(GetYPosition,Text,Align);

Font.Style := [];
SetFontInfo(Font);
//NextLine;
//
finally
  LibereObjet(Tobject(font));
end;
End;

Procedure TObjetEdition.LigneSimpleMilieu(Valeurs:String;Align:Word);//7
var
i:integer;
Text:String;
//Font:TFont;
Begin
//Font:=TFont.Create;
//Font.Name := 'Times New Roman';
//Font.Style := [fsBold,fsUnderline]; // ,
//SetFontInfo(Font);


text:='';
for i:=1 to Str_Count_Str(FDelimiteur,Valeurs) do
 Text := text + str_getstringelement(Valeurs,i+1,FDelimiteur);
//NextLine;
//NextLine;
WriteLineAlign(GetYPosition,Text,Align);
//NextLine;

//Font.Style := [];
//SetFontInfo(Font);
//
End;

Procedure TObjetEdition.LigneSimpleDerniere(Valeurs:String;Align:Word);//8
var
i:integer;
Text:String;
//Font:TFont;
Begin
//Font:=TFont.Create;
//Font.Name := 'Times New Roman';
//Font.Style := [fsBold,fsUnderline]; // ,
//SetFontInfo(Font);

text:='';
for i:=1 to Str_Count_Str(FDelimiteur,Valeurs) do
 Text := text + str_getstringelement(Valeurs,i+1,FDelimiteur);
NextLine;
WriteLineAlign(GetYPosition,Text,Align);
NextLine;

//Font.Style := [];
//SetFontInfo(Font);

//
End;

Procedure TObjetEdition.LigneSautDePage;
Begin
NewPage;
End;

Procedure TObjetEdition.LigneCompteBal(Valeurs:String;Align:Word);//14
var
i:integer;
Text:String;
Font:TFont;
Begin
try//finally
Font:=TFont.Create;
Font.Name := 'Times New Roman';
Font.Style := [fsBold]; // ,
Font.Size := 12;
SetFontInfo(Font);

text:='';
for i:=1 to Str_Count_Str(FDelimiteur,Valeurs) do
 Text := text + str_getstringelement(Valeurs,i+1,FDelimiteur);
//NextLine;
WriteLineAlign(GetYPosition,Text,Align);

Font.Style := [];
SetFontInfo(Font);
//Font.Free;
finally
  LibereObjet(Tobject(font));
end;
End;

Procedure TObjetEdition.LigneSimpleDerniereFormatee(Valeurs:String;Align:Word);//9 ou 10 suivant centrage
var
i:integer;
Text:String;
Font:TFont;
Begin
try//finally
Font:=TFont.Create;
Font.Name := 'Times New Roman';
Font.Style := [fsBold,fsUnderline]; // ,
SetFontInfo(Font);

text:='';
for i:=1 to Str_Count_Str(FDelimiteur,Valeurs) do
 Text := text + str_getstringelement(Valeurs,i+1,FDelimiteur);
NextLine;
WriteLineAlign(GetYPosition,Text,Align);
NextLine;

Font.Style := [];
SetFontInfo(Font);
finally
  LibereObjet(Tobject(font));
end;
End;

Procedure TObjetEdition.LigneSimpleFormatee(ParamLigneFormatee:TParamLigneFormatee);//13
var
i:integer;
Text:String;
Font:TFont;
Begin
try//finally
Font:=TFont.Create;
Font.Name := 'Times New Roman';
Font.Style := ParamLigneFormatee.Style;
Font.Size := ParamLigneFormatee.Taille;
SetFontInfo(Font);

text:=ParamLigneFormatee.Valeur;
//for i:=1 to Str_Count_Str(FDelimiteur,ParamLigneFormatee.Valeur) do
// Text := text + str_getstringelement(ParamLigneFormatee.Valeur,i+1,FDelimiteur);
if ParamLigneFormatee.Position = 0 then
NextLine;
if ParamLigneFormatee.Position = 2 then
NextLine;

WriteLineAlign(GetYPosition,Text,ParamLigneFormatee.Alignement);

if ParamLigneFormatee.Position = 2 then
NextLine;

Font.Style := [];
SetFontInfo(Font);
finally
  LibereObjet(Tobject(font));
end;
End;

Procedure TObjetEdition.DessineLigne(X:Integer;Couleur:TColor); // Type 12
Begin
 //SetPenColor(clBlue);                             
 DrawBox(FLeftMargin_Objet, GetYPosition, GetPageWidth-FRightMargin_Objet, GetYPosition, 3);
End;

Procedure TObjetEdition.LignePlanCpt(Valeurs:String;DeltaColor:Integer); // Type 16
var
i,j,NbCol:integer;
PosColLeft,PosColRight:Double;
TextTmp:string;
Font:TFont;
Begin
try//finally
Font:=TFont.Create;
TextTmp:=C_StrVide;
//NewLines(1);
//      if GetYPosition+1 >= BottomMargin_Objet then
//           NewLines(2);
      NbCol:=Str_Count_Str(FDelimiteur,Valeurs);
      PosColLeft:=GetColumnLeft(1);
      PosColRight:=GetColumnRight(1);
       for i:=1 to NbCol do
        begin
//        if str_getstringelement(Valeurs,i+1,FDelimiteur) <> '' then
//         begin
//          if str_recherchesouschaine(str_getstringelement(Valeurs,i+1,FDelimiteur),'*@*').retour then
//            begin
//              Font:=TFont.Create;
//              Font.Name := 'Times New Roman';
//              Font.Style := [fsBold]; // ,
//              SetFontInfo(Font);
//              TextTmp:=str_remplacesouschaine(str_getstringelement(Valeurs,i+1,FDelimiteur),'@','');
//              WriteLineRightToX(PosColRight,GetYPosition,TextTmp);
//              Font.Style := [];
//              SetFontInfo(Font);
//            end
//          else
            begin
//             if AvecEspaces then
//                TextColumnBox(PosColLeft, GetYPosition, PosColRight,
//                            GetYPosition + GetLineHeightInches, 1,
//                            RGB(240,240,240), str_getstringelement(Valeurs,i+1,FDelimiteur), i, wtRight)
//             else
            case i of
              1,2:TextColumnBox(PosColLeft, GetYPosition, PosColRight,
                            GetYPosition + GetLineHeightInches, 1,
                            RGB(255-DeltaColor,255-DeltaColor,255-DeltaColor), str_getstringelement(Valeurs,i+1,FDelimiteur), i, wtLeft);
              3..12:TextColumnBox(PosColLeft, GetYPosition, PosColRight,
                            GetYPosition + GetLineHeightInches, 1,
                            RGB(255-DeltaColor,255-DeltaColor,255-DeltaColor), str_getstringelement(Valeurs,i+1,FDelimiteur), i, wtCenter);
            else
             TextColumnBox(PosColLeft, GetYPosition, PosColRight,
                            GetYPosition + GetLineHeightInches, 1,
                            RGB(255-DeltaColor,255-DeltaColor,255-DeltaColor), str_getstringelement(Valeurs,i+1,FDelimiteur), i, wtCenter);
            end;

            end;
           if i < NbCol then
           begin
            PosColLeft:=GetColumnLeft(i+1);
            PosColRight:=GetColumnRight(i+1);
           end;
//         end
//         else
//          begin
//           if i < NbCol then
//            PosColRight:=GetColumnRight(i+1);
//          end;
       end;
finally
  LibereObjet(Tobject(font));
end;
End;

Function TObjetEdition.ValeurType(Valeurs:string;Col:Integer):Integer;
Begin
result:=wtLeft;
if lowercase(str_getstringelement(Valeurs,col,FDelimiteur)) = 'texte' then result:=wtLeft;
if lowercase(str_getstringelement(Valeurs,col,FDelimiteur)) = 'float' then result:=wtRight;
if lowercase(str_getstringelement(Valeurs,col,FDelimiteur)) = 'curr' then result:=wtDecimal;
if lowercase(str_getstringelement(Valeurs,col,FDelimiteur)) = 'texteright' then result:=wtRight;
if lowercase(str_getstringelement(Valeurs,col,FDelimiteur)) = 'textecenter' then result:=wtCenter;
//if str_getstringelement(Valeurs,col,FDelimiteur) = 'bool' then result:=wtLeft;
End;


end.
