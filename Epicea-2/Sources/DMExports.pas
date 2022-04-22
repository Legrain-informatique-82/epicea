unit DMExports;

interface

uses
  SysUtils,
  Classes,
  Controls,
  DB,
  Forms,
  LibFichRep,
  E2_Librairie_Obj,
  Gr_Librairie_Obj,
  LibRessourceString,
  LibSQL,
  DBTables,
  Windows,
   IniFiles,
  DMRecherche,
  DMDiocEtatBalance,
  DMDiocEtatBalanceT,
  E2_LibInfosTable,DiversProjets,
  Lib_Chaine,
  XLSFile,
  Dialogs,
  FileCtrl ,
  E2_Decl_Records,
     Messages,  Graphics, ComObj,
  StdCtrls, ExtCtrls,XLSFormat ;

type
  TDMExport = class(TDataModule)
    SaveDialog1: TSaveDialog;
    Requete: TQuery;
    RequeteCompte: TStringField;
    RequeteDebit_Report: TCurrencyField;
    RequeteCredit_Report: TCurrencyField;
    RequeteDebit_base: TCurrencyField;
    RequeteCredit_base: TCurrencyField;
    Requetedebit_total: TCurrencyField;
    Requetecredit_total: TCurrencyField;
    RequeteReport_Mouv_debit: TCurrencyField;
    RequeteReport_Mouv_Credit: TCurrencyField;
    RequeteMouv_Debit: TCurrencyField;
    RequeteMouv_Credit: TCurrencyField;
    ReqControl: TQuery;
    ReqPointage: TQuery;
    TableControlFiscal: TTable;
    ReqEcriture: TQuery;
    TableEcritureLettreTemp: TTable;
    ReqEcriture2: TQuery;
    Requete2: TQuery;
    RequeteDebit: TQuery;
    RequeteCredit: TQuery;
    procedure RequeteCalcFields(DataSet: TDataSet);

  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;


  //*********   TDatasetExport  ***********///
  type
  TDatasetExport = class(TObject)
  private
    { D�clarations priv�es }
    FListeChamps: TStringList;
    FDatasetExport:TDataSet;
    FTypeData : String;
    FListeParams:  TStringList;
    function GetListeChamps :Tstringlist;
    procedure SetListeChamps(ListeChamps : Tstringlist);
    function GetListeParams :Tstringlist;
    procedure SetListeParams(ListeParams : Tstringlist);
    function  GetDatasetExport : TDataset;
    procedure  SetDatasetExport(DatasetExport:Tdataset);
    function GetTypeData : string;
    procedure SetTypeData(TypeData : string);
  public
    { D�clarations publiques }
    property ListeChamps : TstringList read GetListeChamps write SetListeChamps;
    property ListeParams : TstringList read GetListeParams write SetListeParams;
    property DatasetExport : TDataset read GetDatasetExport write SetDatasetExport;
    property TypeData : String read GetTypeData write SetTypeData;
    constructor Create(AOwner :TComponent);
    destructor Destroy; override;
  end;
var
  DMExport: TDMExport;

   Procedure ExportBalanceCOGEREFiscal(TableBalance:TDataSet);
   Procedure ExportBalanceCOGEREFiscal_Liasse(TableBalance:TDataSet);
   Procedure ExportBalanceCOGEREFiscal_LiasseAsc(TableBalance:TDataSet);
   Procedure ExportBalanceNormale(TableBalance:TDataSet);
   Procedure ExportRelanceDesTiers(listeRelance:TStringlist);
   procedure CreateTableRelanceTiers(NomTable,Path : String;ListeRelance:Tstringlist);


   Function ExportDonnees(Dataset:TDataset;var Dir:string;NomExport:string=''):TStringList;overload;
   Function ExportDonnees(Liste:TStringlist;var Dir:string;NomExport:string=''):TStringList;overload;
   Function ExportDonnees(var Dir:string;NomExport:string=''):TStringList;overload;
   Procedure ExportDonnees(TabDataset:array of TDatasetExport;var Dir:string;NomExport:string='';FichierIni:string='');overload;
   function ExportDataset(Dataset : Tdataset; CheminFichier : string; ListeChamp : TStringList=nil;AvecChamps:boolean=true):TStringList;
   Procedure RecupDataset(ListeProperties : TStringList;Dataset : TDatasetExport);
   function recupListeEdition():Tstringlist;
   Procedure ExportEcriturePourControlFiscal(debControl,finControl:TDate; siren:string; constNomFichier:string; resultChoixParamFEC:TResultChoixParamFEC);

   function recuperePointagesLies_A_EcritureControlFiscal(idEcriture : integer ;debit,credit:currency):Tstringlist;
   procedure enregistreLettrage(idEcriture:integer;lettre:string;debit,credit:currency;datelettrage:Tdate;commit:boolean);
   procedure enregistreListeLettrage(ListeEcriture:Tstringlist;num:integer);
   procedure LettrageTraitee(idEcriture:integer);
//   procedure LettrageTraitee(idEcriture:integer; commit:boolean=true);
   
implementation
uses E2_Patientez, DMImmos,DMEmprunt, DMRepartition,DMAnalytique,
DMStocks,DMEcriture,  DMCorrection, XLSWorkbook, LibDates, DMConstantes,
  DMBalances, LibChoixRep, ChoixParametresFEC;
{$R *.dfm}

Procedure ExportBalanceCOGEREFiscal_LiasseAsc(TableBalance:TDataSet);
Var
Text:String;
CheminFichier:String;
IDCompte:String;
Affichage:boolean;
Begin
try
 try
  if DMExport = nil then DMExport:=TDMExport.Create(Application.MainForm);
  Affichage:=true;
  DMExport.SaveDialog1.DefaultExt:='asc';
  DMExport.SaveDialog1.FileName := 'Bal_'+E.NomDossier + E.NomExo + '_CF.asc';
  DMExport.SaveDialog1.InitialDir := E.RepertoireExportBalance;

  DMExport.SaveDialog1.Title := 'Sauvegarde de la balance pour la Liasse Fiscale';
  if DMExport.SaveDialog1.Execute then CheminFichier:= DMExport.SaveDialog1.FileName
  else abort;
//  CheminFichier:=E.RepertoireExport+ 'Balance.asc';
  TableBalance.DisableControls;
  CoherenceBalance(nil);
  if not TableBalance.Active then TableBalance.Open;

  IDCompte := TableBalance.FindField('Compte').AsString;

  TableBalance.First;
  if FileExists(CheminFichier) then
   DeleteFile(PChar(CheminFichier));
  while not TableBalance.Eof do
  begin
   // Pour le champ compte on ajoute des 0 en fin de compte
   // Pour les champs de valeurs des espaces en d�but de valeur !
   Text:=str_ajouteAdroite(TableBalance.FindField('Compte').AsString,'0000000',(8-length(TableBalance.FindField('Compte').AsString)))+
         ';'+
         str_QueDesChiffresCurr(TableBalance.FindField('Solde_Debit_Report_Calc').AsString)+
         ';'+
         str_QueDesChiffresCurr(TableBalance.FindField('Solde_Credit_Report_Calc').AsString)+
         ';'+
         str_QueDesChiffresCurr(TableBalance.FindField('Debit_Base_Calc').AsString) +
         ';'+
         str_QueDesChiffresCurr(TableBalance.FindField('Credit_Base_Calc').AsString) +
         ';'+
         TableBalance.FindField('ComptePlanCpt').AsString+
         ';'+
         str_QueDesChiffresCurr(TableBalance.FindField('Solde_Debit_Total_Calc').AsString)+
         ';'+
         str_QueDesChiffresCurr(TableBalance.FindField('Solde_Credit_Total_Calc').AsString);
   AjouterFichierTexte(CheminFichier,Text);
   TableBalance.Next;
  end;
 except
  Affichage:=False;
  Showmessage('Erreur lors de l''exportation de la balance !');
  abort;
 end;
finally
 TableBalance.Locate('Compte',IDCompte,[]);
 ReEnableControls(TableBalance);
 if Affichage then
  begin
   Showmessage('Fin de l''exportation de la balance !');
//   Showmessage(E.RepertoireExportBalance);
//   Showmessage(ExtractFileDir(DMExport.SaveDialog1.FileName));
   if AnsiCompareFileName(ExcludeTrailingPathDelimiter(E.RepertoireExportBalance),ExcludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName)))<>0 then
    begin
     if MessageDlg('Le r�pertoire par d�faut d''exportation de la balance � chang�.'+
                    RetourChariotDouble+
                    'Ancien : '+
                    RetourChariotDouble+
                    ExcludeTrailingPathDelimiter(E.RepertoireExportBalance)+
                    RetourChariotDouble+
                    'Nouveau : '+
                    RetourChariotDouble+
                    ExcludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName))+
                    RetourChariotDouble+
                    'Voulez-Vous conserver ce changement ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
             E.RepertoireExportBalance:=IncludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName));
    end;
  end;
end;
end;


//
//End;
Procedure ExportBalanceCOGEREFiscal(TableBalance:TDataSet);
Var
Text:String;
CheminFichier:String;
IDCompte:String;
Affichage:boolean;
Begin
try
 try
  if DMExport = nil then DMExport:=TDMExport.Create(Application.MainForm);
  Affichage:=true;
  DMExport.SaveDialog1.DefaultExt:='asc';
  DMExport.SaveDialog1.FileName := 'Bal_'+E.NomDossier + E.NomExo + '.asc';
  DMExport.SaveDialog1.InitialDir := E.RepertoireExportBalance;

  DMExport.SaveDialog1.Title := 'Sauvegarde de la balance SAMADE';
  if DMExport.SaveDialog1.Execute then CheminFichier:= DMExport.SaveDialog1.FileName
  else abort;
  CoherenceBalance(nil);
//  CheminFichier:=E.RepertoireExport+ 'Balance.asc';
  if not TableBalance.Active then TableBalance.Open;

  TableBalance.DisableControls;
  IDCompte := TableBalance.FindField('Compte').AsString;

  TableBalance.First;
  if FileExists(CheminFichier) then
   DeleteFile(PChar(CheminFichier));
  while not TableBalance.Eof do
  begin
   // Pour le champ compte on ajoute des 0 en fin de compte
   // Pour les champs de valeurs des espaces en d�but de valeur !
   Text:=str_ajouteAdroite(TableBalance.FindField('Compte').AsString,'0000000',(8-length(TableBalance.FindField('Compte').AsString)))+
         ','+
         StringOfChar(' ',(12-length(Str_ChangeDecimalSeparatorEx(str_QueDesChiffresCurr(TableBalance.FindField('Solde_Debit_Report_Calc').AsString),'.'))))+
         Str_ChangeDecimalSeparatorEx(str_QueDesChiffresCurr(TableBalance.FindField('Solde_Debit_Report_Calc').AsString),'.') +
         ','+
         StringOfChar(' ',(12-length(Str_ChangeDecimalSeparatorEx(str_QueDesChiffresCurr(TableBalance.FindField('Solde_Credit_Report_Calc').AsString),'.'))))+
         Str_ChangeDecimalSeparatorEx(str_QueDesChiffresCurr(TableBalance.FindField('Solde_Credit_Report_Calc').AsString),'.') +
         ','+
         StringOfChar(' ',(12-length(Str_ChangeDecimalSeparatorEx(str_QueDesChiffresCurr(TableBalance.FindField('Debit_Base_Calc').AsString),'.'))))+
         Str_ChangeDecimalSeparatorEx(str_QueDesChiffresCurr(TableBalance.FindField('Debit_Base_Calc').AsString),'.') +
         ','+
         StringOfChar(' ',(12-length(Str_ChangeDecimalSeparatorEx(str_QueDesChiffresCurr(TableBalance.FindField('Credit_Base_Calc').AsString),'.'))))+
         Str_ChangeDecimalSeparatorEx(str_QueDesChiffresCurr(TableBalance.FindField('Credit_Base_Calc').AsString),'.') +

//         str_ajouteAGauche(Str_ChangeDecimalSeparatorEx(str_QueDesChiffresCurr(TableBalance.FindField('Solde_Debit_Report_Calc').AsString),'.'),'            ',(12-length(str_QueDesChiffresCurr(TableBalance.FindField('Debit_Base_Calc').AsString))))+
//         ','+
//         str_ajouteAGauche(Str_ChangeDecimalSeparatorEx(str_QueDesChiffresCurr(TableBalance.FindField('Solde_Credit_Report_Calc').AsString),'.'),'            ',(12-length(str_QueDesChiffresCurr(TableBalance.FindField('Credit_Base_Calc').AsString))))+
//         ','+
//         str_ajouteAGauche(Str_ChangeDecimalSeparatorEx(str_QueDesChiffresCurr(TableBalance.FindField('Debit_Base_Calc').AsString),'.'),'            ',(12-length(str_QueDesChiffresCurr(TableBalance.FindField('Solde_Debit_Total_Calc').AsString))))+
//         ','+
//         str_ajouteAGauche(Str_ChangeDecimalSeparatorEx(str_QueDesChiffresCurr(TableBalance.FindField('Credit_Base_Calc').AsString),'.'),'            ',(12-length(str_QueDesChiffresCurr(TableBalance.FindField('Solde_Credit_Total_Calc').AsString))))+
         ','+
         TableBalance.FindField('ComptePlanCpt').AsString;
   AjouterFichierTexte(CheminFichier,Text);
   TableBalance.Next;
  end;
 except
  Affichage:=False;
  Showmessage('Erreur lors de l''exportation de la balance !');
  abort;
 end;
finally
 TableBalance.Locate('Compte',IDCompte,[]);
 ReEnableControls(TableBalance);
 if Affichage then
  begin
   Showmessage('Fin de l''exportation de la balance !');
//   Showmessage(E.RepertoireExportBalance);
//   Showmessage(ExtractFileDir(DMExport.SaveDialog1.FileName));
   if AnsiCompareFileName(ExcludeTrailingPathDelimiter(E.RepertoireExportBalance),ExcludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName)))<>0 then
    begin
     if MessageDlg('Le r�pertoire par d�faut d''exportation de la balance � chang�.'+
                    RetourChariotDouble+
                    'Ancien : '+
                    RetourChariotDouble+
                    ExcludeTrailingPathDelimiter(E.RepertoireExportBalance)+
                    RetourChariotDouble+
                    'Nouveau : '+
                    RetourChariotDouble+
                    ExcludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName))+
                    RetourChariotDouble+
                    'Voulez-Vous conserver ce changement ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
             E.RepertoireExportBalance:=IncludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName));
    end;
  end;
end;
end;

Procedure ExportBalanceCOGEREFiscal_Liasse(TableBalance:TDataSet);
Var
  //xf: TXLSFile;
    I: Integer;
Text:String;
CheminFichier:String;
IDCompte:String;
Affichage:boolean;
vMSExcel : variant;
vXLWorkbook, vXLWorkbooks : variant;
vWorksheet : variant;
cellule:string;
Begin
try
 try
     vMSExcel := CreateOleObject('Excel.Application');
    vMSExcel.Visible := false;
    vXLWorkbooks := vMSExcel.Workbooks;
    vXLWorkbook := vXLWorkbooks.Add;
    
    vWorksheet := vXLWorkbook.WorkSheets['Feuil1'];
    //vWorksheet.Range[aRange]
   //xf:= TXLSFile.Create;
  if DMExport = nil then DMExport:=TDMExport.Create(Application.MainForm);
  Affichage:=true;
  DMExport.SaveDialog1.DefaultExt:='xls';
  DMExport.SaveDialog1.FileName := 'Bal_'+E.NomDossier + E.NomExo + '_CF.xls';
  DMExport.SaveDialog1.InitialDir := E.RepertoireExportBalance;

  DMExport.SaveDialog1.Title := 'Sauvegarde de la balance pour la Liasse Fiscale';
  if DMExport.SaveDialog1.Execute then CheminFichier:= DMExport.SaveDialog1.FileName
  else abort;
//  CheminFichier:=E.RepertoireExport+ 'Balance.asc';
  TableBalance.DisableControls;
  CoherenceBalance(nil);
  if not TableBalance.Active then TableBalance.Open;


//   vWorksheet.Columns[0].FormatStringIndex:=0;
//   vWorksheet.Columns[1].FormatStringIndex:=2;
//   vWorksheet.Columns[2].FormatStringIndex:=2;
//   vWorksheet.Columns[3].FormatStringIndex:=2;
//   vWorksheet.Columns[4].FormatStringIndex:=2;
//   vWorksheet.Columns[5].FormatStringIndex:=0;
//   vWorksheet.Columns[6].FormatStringIndex:=2;
//   vWorksheet.Columns[7].FormatStringIndex:=2;
//
//   vWorksheet.Columns[0].HAlign:=xlHAlignGeneral;
//   //xf.Workbook.Sheets[0].Columns[0].FontBold:=true;
//
//   vWorksheet.Columns[1].HAlign:=xlHAlignRight;
//   vWorksheet.Columns[2].HAlign:=xlHAlignRight;
//   vWorksheet.Columns[3].HAlign:=xlHAlignRight;
//   vWorksheet.Columns[4].HAlign:=xlHAlignRight;
//   vWorksheet.Columns[5].HAlign:=xlHAlignGeneral;
//   vWorksheet.Columns[6].HAlign:=xlHAlignRight;
//   vWorksheet.Columns[7].HAlign:=xlHAlignRight;

  IDCompte := TableBalance.FindField('Compte').AsString;
  i:=1;
  TableBalance.First;
  if FileExists(CheminFichier) then
   DeleteFile(PChar(CheminFichier));
  //vXLWorkbook.SaveAs(CheminFichier);
  while not TableBalance.Eof do
  begin

 //******************
   // Voir exemple dans  "C:\Program Files\TXLSFile\UNREG_D7\Help"
//******************
   // Pour le champ compte on ajoute des 0 en fin de compte
   // Pour les champs de valeurs des espaces en d�but de valeur !

  // cellule:=int
   vWorksheet.range['A'+IntToStr(I)].Value:=str_ajouteAdroite(TableBalance.FindField('Compte').AsString,'0000000',(8-length(TableBalance.FindField('Compte').AsString)));
   vWorksheet.range['B'+IntToStr(I)].Value:=str_QueDesChiffresCurr(TableBalance.FindField('Solde_Debit_Report_Calc').AsString);
   vWorksheet.range['C'+IntToStr(I)].Value:=str_QueDesChiffresCurr(TableBalance.FindField('Solde_Credit_Report_Calc').AsString) ;
   vWorksheet.range['D'+IntToStr(I)].Value:=str_QueDesChiffresCurr(TableBalance.FindField('Debit_Base_Calc').AsString);
   vWorksheet.range['E'+IntToStr(I)].Value:=str_QueDesChiffresCurr(TableBalance.FindField('Credit_Base_Calc').AsString);
   vWorksheet.range['F'+IntToStr(I)].Value:=TableBalance.FindField('ComptePlanCpt').AsString;

   vWorksheet.range['G'+IntToStr(I)].Value:=str_QueDesChiffresCurr(TableBalance.FindField('Solde_Debit_Total_Calc').AsString);
   vWorksheet.range['H'+IntToStr(I)].Value:=str_QueDesChiffresCurr(TableBalance.FindField('Solde_Credit_Total_Calc').AsString);
//   // Pour le champ compte on ajoute des 0 en fin de compte
//   // Pour les champs de valeurs des espaces en d�but de valeur !
//   Text:=str_ajouteAdroite(TableBalance.FindField('Compte').AsString,'0000000',(8-length(TableBalance.FindField('Compte').AsString)))+
//         ';'+
//         str_QueDesChiffresCurr(TableBalance.FindField('Solde_Debit_Report_Calc').AsString)+
//         ';'+
//         str_QueDesChiffresCurr(TableBalance.FindField('Solde_Credit_Report_Calc').AsString)+
//         ';'+
//         str_QueDesChiffresCurr(TableBalance.FindField('Debit_Base_Calc').AsString) +
//         ';'+
//         str_QueDesChiffresCurr(TableBalance.FindField('Credit_Base_Calc').AsString) +
//         ';'+
//         TableBalance.FindField('ComptePlanCpt').AsString+
//         ';'+
//         str_QueDesChiffresCurr(TableBalance.FindField('Solde_Debit_Total_Calc').AsString)+
//         ';'+
//         str_QueDesChiffresCurr(TableBalance.FindField('Solde_Credit_Total_Calc').AsString);
//   AjouterFichierTexte(CheminFichier,Text);
   TableBalance.Next;
      inc(i);
  end;
    vXLWorkbook.SaveAs(CheminFichier);
//      xf.SaveAs(CheminFichier);
 except
  Affichage:=False;
  Showmessage('Erreur lors de l''exportation de la balance !');
  abort;
 end;
finally
    vMSExcel.Quit;
   // vMSExcel := nil;
 TableBalance.Locate('Compte',IDCompte,[]);
 ReEnableControls(TableBalance);
 if Affichage then
  begin
   Showmessage('Fin de l''exportation de la balance !');
//   Showmessage(E.RepertoireExportBalance);
//   Showmessage(ExtractFileDir(DMExport.SaveDialog1.FileName));
   if AnsiCompareFileName(ExcludeTrailingPathDelimiter(E.RepertoireExportBalance),ExcludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName)))<>0 then
    begin
     if MessageDlg('Le r�pertoire par d�faut d''exportation de la balance � chang�.'+
                    RetourChariotDouble+
                    'Ancien : '+
                    RetourChariotDouble+
                    ExcludeTrailingPathDelimiter(E.RepertoireExportBalance)+
                    RetourChariotDouble+
                    'Nouveau : '+
                    RetourChariotDouble+
                    ExcludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName))+
                    RetourChariotDouble+
                    'Voulez-Vous conserver ce changement ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
             E.RepertoireExportBalance:=IncludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName));
    end;
  end;

end;

//
End;
Procedure ExportBalanceNormale(TableBalance:TDataSet);
Var
Text:String;
CheminFichier:String;
IDCompte:String;
Affichage:boolean;
listeEdition:Tstringlist;
Begin
try
 try
  if DMExport = nil then DMExport:=TDMExport.Create(Application.MainForm);
  Affichage:=true;
  DMExport.SaveDialog1.DefaultExt:='Txt';
  DMExport.SaveDialog1.Filter:='Fichier texte (*.txt)';
  DMExport.SaveDialog1.FileName := 'Bal_'+E.NomDossier + E.NomExo + '.Txt';
  DMExport.SaveDialog1.InitialDir := E.RepertoireExportDossier;

  DMExport.SaveDialog1.Title := 'Sauvegarde de la balance ...';
  if DMExport.SaveDialog1.Execute then CheminFichier:= DMExport.SaveDialog1.FileName
  else abort;
CoherenceBalance(nil);  
  if not TableBalance.Active then TableBalance.Open;

  TableBalance.DisableControls;
  IDCompte := TableBalance.FindField('Compte').AsString;

  TableBalance.First;
  if FileExists(CheminFichier) then
   DeleteFile(PChar(CheminFichier));
  listeEdition:=ChampTableVersListeEx(['Compte','Solde_Debit_Report_Calc','Solde_Credit_Report_Calc','Debit_Base_Calc','Credit_Base_Calc','Solde_Debit_Total_Calc','Solde_Credit_Total_Calc','ComptePlanCpt'],TableBalance,';',false);
  if listeEdition<>nil then
  begin
    listeEdition.Insert(0,'Compte;Solde_Debit_Report;Solde_Credit_Report;Mouv_Debit;Mouv_Credit;Solde_Debit_Total;Solde_Credit_Total;Libell�');
    listeEdition.SaveToFile(CheminFichier)
  end;
 except
  Affichage:=False;
  Showmessage('Erreur lors de l''exportation de la balance !');
  abort;
 end;
finally
 TableBalance.Locate('Compte',IDCompte,[]);
 ReEnableControls(TableBalance);
 if Affichage then
  begin
   Showmessage('Fin de l''exportation de la balance !');
   if AnsiCompareFileName(ExcludeTrailingPathDelimiter(E.RepertoireExportDossier),ExcludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName)))<>0 then
    begin
     if MessageDlg('Le r�pertoire par d�faut d''exportation de la balance � chang�.'+
                    RetourChariotDouble+
                    'Ancien : '+
                    RetourChariotDouble+
                    ExcludeTrailingPathDelimiter(E.RepertoireExportDossier)+
                    RetourChariotDouble+
                    'Nouveau : '+
                    RetourChariotDouble+
                    ExcludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName))+
                    RetourChariotDouble+
                    'Voulez-Vous conserver ce changement ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
             E.RepertoireExportDossier:=IncludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName));
    end;
  end;

end;

//
End;

Procedure ExportRelanceDesTiers(listeRelance:TSTringlist);
Var
Text:String;
CheminFichier:String;
FichierSansExt:string;
IDCompte:String;
Affichage:boolean;
Begin
try
 try
  if DMExport = nil then DMExport:=TDMExport.Create(Application.MainForm);
  Affichage:=true;

//creation fichier relanceTiers
  DMExport.SaveDialog1.DefaultExt:='Txt';
  DMExport.SaveDialog1.FileName := 'RelanceTiers_'+E.NomDossier + E.NomExo + '.Txt';
  DMExport.SaveDialog1.InitialDir := E.RepertoireRelanceTiers;
  DMExport.SaveDialog1.Filter:='Fichier texte (*.Txt)';
  DMExport.SaveDialog1.Title := 'Edition de la relance des tiers ...';
  if DMExport.SaveDialog1.Execute then CheminFichier:= DMExport.SaveDialog1.FileName
  else abort;
  E.RepertoireRelanceTiers:= ExtractFileDir(CheminFichier);
  if listeRelance=nil then   raise ExceptLGR.Create('Le fichier de relance est nil',0,true,mtError);
  listeRelance.SaveToFile(dmexport.SaveDialog1.FileName);
  listeRelance.Delete(0);
  //fin creation fichier relanceTiers

//creation table relanceTiers
  DMExport.SaveDialog1.DefaultExt:='DBF';
  DMExport.SaveDialog1.FileName := 'RelanceTiers_'+E.NomDossier + E.NomExo + '.DBF';
  DMExport.SaveDialog1.InitialDir := E.RepertoireRelanceTiers;
  DMExport.SaveDialog1.Filter:='Table DBase (*.DBF)';
  DMExport.SaveDialog1.Title := 'Edition de la relance des tiers ...';
  if DMExport.SaveDialog1.Execute then CheminFichier:= DMExport.SaveDialog1.FileName
  else abort;
  E.RepertoireRelanceTiers:= ExtractFileDir(CheminFichier);
  if listeRelance=nil then   raise ExceptLGR.Create('Le fichier de relance est nil',0,true,mtError);
  FichierSansExt:=str_remplacesouschaine(CheminFichier,ExtractFileExt(CheminFichier),'');
  if FileExists(FichierSansExt+'.DBF') then
   DeleteFile(PChar(FichierSansExt+'.DBF'));
  CreateTableRelanceTiers(ExtractFileName(CheminFichier),CheminFichier,listeRelance);
//fin creation table relanceTiers

 except
  Affichage:=False;
  Showmessage('Erreur lors de l''exportation de la relance des tiers !');
  abort;
 end;
finally
// if Affichage then
//  begin
//   Showmessage('Fin de l''exportation de la balance !');
//   if AnsiCompareFileName(ExcludeTrailingPathDelimiter(E.RepertoireExportBalance),ExcludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName)))<>0 then
//    begin
//     if MessageDlg('Le r�pertoire par d�faut d''exportation de la balance � chang�.'+
//                    RetourChariotDouble+
//                    'Ancien : '+
//                    RetourChariotDouble+
//                    ExcludeTrailingPathDelimiter(E.RepertoireExportBalance)+
//                    RetourChariotDouble+
//                    'Nouveau : '+
//                    RetourChariotDouble+
//                    ExcludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName))+
//                    RetourChariotDouble+
//                    'Voulez-Vous conserver ce changement ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
//             E.RepertoireExportBalance:=IncludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName));
//    end;
//  end;
end;
end;


procedure CreateTableRelanceTiers(NomTable,Path : String;ListeRelance:Tstringlist);
var
  table: TTable;
  DBAux:TDataBase;
  i:integer;
Begin
  Try
      DBAux:=TDataBase.Create(Application);
      DBAux.DatabaseName:='Tmp';
      DBAux.Params.Add('PATH=' + ExtractFileDir(Path));
      DBAux.Params.Add('ENABLE BCD=FALSE');
      DBAux.Params.Add('DEFAULT DRIVER=DBASE');
      DBAux.TransIsolation:=tiDirtyRead;
      DBAux.DriverName:='Microsoft dBase Driver (*.dbf)';
      DBAux.DriverName:='Standard';
      DBAux.open;
      table := TTable.Create(Application);
      Try
            table.DataBaseName := 'Tmp';
            if not empty(NomTable)then
              table.TableName := NomTable
            else
              table.TableName := 'RelanceTiers.DBF';
            with table.FieldDefs do
            begin
              Clear;
              Add('ID', ftAutoInc, 0, False);
              Add('ID_Ecrit', ftInteger, 0, False);
              Add('ID_Piece', ftInteger, 0, False);
              Add('Echeance', ftDate, 0, False);
              Add('Date', ftDate, 0, False);
              Add('Reference', ftString, 9, False);
              Add('Tiers', ftString, 8, False);
              Add('Libelle', ftString, 100, False);
              Add('Sens', ftString, 1, False);
              Add('MontantTot', ftCurrency, 0, False);
              Add('DejaRegle', ftCurrency, 0, False);
              Add('Creance', ftCurrency, 0, False);
              Add('Dette', ftCurrency, 0, False);
              Add('Nom', ftString, 100, False);
              Add('Adresse1', ftString, 100, False);
              Add('Adresse2', ftString, 100, False);
              Add('Poste', ftString, 5, False);
              Add('Ville', ftString, 25, False);
              Add('Pays', ftString, 20, False);
            end; { FieldDefs }
            with table.IndexDefs do
            begin
              Clear;
              Add('', 'ID', [ixPrimary, ixUnique]);
            end; { IndexDefs }
    Try table.CreateTable;
    Except
       ShowMessage('Impossible de cr�er la table: '+table.TableName);
       abort;
    End;
          table.open;
          for i:=0 to ListeRelance.count-1 do
            Begin
              table.AppendRecord([nil,+
                            strtoint_lgr(str_getstringelement(ListeRelance.strings[i],1,';')),
                            strtoint_lgr(str_getstringelement(ListeRelance.strings[i],2,';')),
                            strtodate_lgr(str_getstringelement(ListeRelance.strings[i],3,';')),
                            strtodate_lgr(str_getstringelement(ListeRelance.strings[i],4,';')),
                            str_getstringelement(ListeRelance.strings[i],5,';'),
                            str_getstringelement(ListeRelance.strings[i],6,';'),
                            str_getstringelement(ListeRelance.strings[i],7,';'),
                            str_getstringelement(ListeRelance.strings[i],8,';'),
                            strtoCurr_lgr(str_getstringelement(ListeRelance.strings[i],9,';')),
                            strtoCurr_lgr(str_getstringelement(ListeRelance.strings[i],10,';')),
                            strtoCurr_lgr(str_getstringelement(ListeRelance.strings[i],11,';')),
                            strtoCurr_lgr(str_getstringelement(ListeRelance.strings[i],12,';')),
                            str_getstringelement(ListeRelance.strings[i],13,';'),
                            str_getstringelement(ListeRelance.strings[i],14,';'),
                            str_getstringelement(ListeRelance.strings[i],15,';'),
                            str_getstringelement(ListeRelance.strings[i],16,';'),
                            str_getstringelement(ListeRelance.strings[i],17,';'),
                            str_getstringelement(ListeRelance.strings[i],18,';')]);
            end;
      except
        Application.MessageBox('Erreur lors de l''initialisation de la table des relances de tiers !','Attention');
      end;
  except
        Application.MessageBox('Erreur lors de l''initialisation de la table des relances de tiers !','Attention');
  end;
Table.Close;
Table.Free;
DBAux.Close;
DBAux.Free;
End;



Procedure ExportDonnees(TabDataset:array of TDatasetExport;var Dir:string;NomExport:string;FichierIni:string);
Var
i,j:integer;
CheminFichier:String;
Affichage:boolean;
Dataset:TDatasetExport;
FIniFile : TIniFile;
Section : string;
//FFileName : string;
value : string;
Liste : TStringList;
ListeFinale : Tstringlist;
fichier : TextFile;
continuer:boolean;
tvaIntra,siret:string;
Begin
try
 try
  if DMExport = nil then DMExport:=TDMExport.Create(Application.MainForm);
  Affichage:=true;
  //demande et sauvegarde du chemin du fichier final
  if NomExport='' then NomExport:='ExportLiasse_'+E.NomDossier + E.NomExo + '.Txt';
  DMExport.SaveDialog1.DefaultExt:='Txt';
  DMExport.SaveDialog1.Filter:='Fichier texte (*.txt)';
  DMExport.SaveDialog1.FileName := NomExport;
  if empty(E.RepertoireExPortDossier)then E.RepertoireExPortDossier:=IncludeTrailingPathDelimiter(E.RepertoireDossier)+C_RepExportation;
  if empty(Dir)then Dir := E.RepertoireExPortDossier;
  DMExport.SaveDialog1.InitialDir := Dir;

  if not DirectoryExists(DMExport.SaveDialog1.InitialDir) then
    begin
      if not CreateDir(DMExport.SaveDialog1.InitialDir) then
        Raise exception.CreateFmt('Erreur lors de la tentative de cr�ation du dossier '+DMExport.SaveDialog1.InitialDir,['']);
    end;
  DMExport.SaveDialog1.Title := 'Exportation des donn�es ...';
  if DMExport.SaveDialog1.Execute then CheminFichier:= DMExport.SaveDialog1.FileName
  else abort;
 PatienterAffich(false);

  if FileExists(CheminFichier) then
  begin
      //if MessageDlg('Voulez-vous supprimer le fichier ['+CheminFichier+'] existant ?', mtError, [mbYes, mbNo ], 0)=mryes then
       DeleteFile(PChar(CheminFichier));
  end;

  AssignFile(fichier,cheminFichier);

  Liste := TStringList.Create;

  //ouverture du fichier ini
  FichierIni := FichierIni;
  if (not empty(FichierIni))and (not FileExists(FichierIni)) then
   Begin
    MessageDlg('Le fichier ['+FichierIni+'] n''existe pas', mtError, [mbOK], 0);
    abort;
   End
  else
   begin
    FIniFile:=TIniFile.Create(FichierIni);
   end;
continuer:=true;
          DeFiltrageDataSet(DMRech.TaParam_DossierRech);
          DeFiltrageDataSet(DMRech.TaJuridiqueRech);
          DMRech.TaParam_DossierRech.Open;
          DMRech.TaJuridiqueRech.Open;
          tvaIntra:='';
          siret:='';
          if(DMRech.TaJuridiqueRech.RecordCount<>0)then
          begin
              siret:=DMRech.TaJuridiqueRech.FindField('siret').AsString;
              tvaIntra:=DMRech.TaJuridiqueRech.FindField('tva_intra').AsString;
          end;
          if(siret='')and(tvaIntra='')then begin
              continuer:=Application.MessageBox(Pchar('Les num�ros siret et de tva intracommunautaire ne sont pas renseign�s.'+RetourChariotdouble+
              'Pour les renseigner, vous devez aller dans M�thodes/Description entreprise'+RetourChariotSimple+
              'et cliquer  en bas � gauche sur le bouton "modifier les infos juridiques"'+RetourChariotDouble+
              'Voulez-vous abandonner la proc�dure d''exportation ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mrno ;
          end;
          if not continuer then exit;
       //remplir les param�tres entreprise
        if FileExists(CheminFichier) then
          append(fichier)
        else
          Rewrite(fichier);
        Writeln(fichier,'InfosDossier');
        Writeln(fichier,'InfosDossier;Dossier;'+e.NomDossier);
        Writeln(fichier,'InfosDossier;Code_Exercice;'+e.ExerciceSaisie);
        Writeln(fichier,'InfosDossier;Nom_Exercice;'+e.NomExo);
        Writeln(fichier,'InfosDossier;Raison sociale;'+e.RaisonSociale);
        Writeln(fichier,'InfosDossier;Debut;'+DateToStr_Lgr( e.DatExoDebut));
        Writeln(fichier,'InfosDossier;Fin;'+ DateToStr_Lgr( e.DatExoFin));
        Writeln(fichier,'InfosDossier;Adresse1;'+DMRech.TaParam_DossierRech.FindField('adr1').AsString);
        Writeln(fichier,'InfosDossier;Adresse2;'+DMRech.TaParam_DossierRech.FindField('adr2').AsString);
        Writeln(fichier,'InfosDossier;cp;'+DMRech.TaParam_DossierRech.FindField('CP').AsString);
        Writeln(fichier,'InfosDossier;ville;'+DMRech.TaParam_DossierRech.FindField('ville').AsString);
        Writeln(fichier,'InfosDossier;Gestion derog;'+BoolToStr(e.Derogatoire));
        Writeln(fichier,'InfosDossier;siret;'+siret);
        Writeln(fichier,'InfosDossier;tva_intra;'+tvaintra);


        CloseFile(fichier); // ferme le fichier

   //
  //parcourir le fichier ini pour r�cup�rer tous les datasets �
  //enregistrer
    Section := '1';
   while FIniFile.SectionExists(Section) do
    begin
        Dataset:= TDatasetExport.Create(Application.MainForm);
        FIniFile.ReadSectionValues(Section,Liste);
        RecupDataset(Liste,Dataset);
        ListeFinale:=ExportDataset(Dataset.DatasetExport,CheminFichier,Dataset.ListeChamps);
      //
        if FileExists(CheminFichier) then
          append(fichier)
        else
          Rewrite(fichier);

        for j:=0 to ListeFinale.Count-1 do
        begin
//            if j=0 then
              value:=ListeFinale.Strings[j];
//            else
//              value:=Dataset.TypeData+';'+ListeFinale.Strings[j];
            Writeln(fichier,value);
        end;
        CloseFile(fichier); // ferme le fichier
        Dataset.free;
      //
        section:=IntToStr_Lgr(StrToInt_Lgr(section)+1);
    end;

   //on traite le tableau de dataset
   i:=0;
   while i<=high(TabDataset) do
    begin
        if((TabDataset[i]).DatasetExport<>nil)then
          begin
              ListeFinale:=ExportDataset((TabDataset[i]).DatasetExport,CheminFichier,(TabDataset[i]).ListeChamps);
            //
              if FileExists(CheminFichier) then
                append(fichier)
              else
                Rewrite(fichier);
              for j:=0 to ListeFinale.Count-1 do
              begin
                  ListeFinale.strings[j]:=(TabDataset[i]).TypeData+';'+ListeFinale.strings[j];
                  Writeln(fichier,ListeFinale.strings[j]);
              end;
              CloseFile(fichier); // ferme le fichier
          end;
      inc(i);
      //
    end;


    //on traite la liste d'Edition
        ListeFinale:=recupListeEdition();
        if FileExists(CheminFichier) then
          append(fichier)
        else
          Rewrite(fichier);
    for j:=0 to ListeFinale.Count-1 do
    begin
        Writeln(fichier,ListeFinale.strings[j]);
    end;
        CloseFile(fichier); // ferme le fichier

 except
  Affichage:=False;
  Showmessage('Erreur lors de l''exportation des donn�es !');
  abort;
 end;
finally
 if Affichage then
  begin
   Showmessage('Fin de l''exportation des donn�es !');
   if (AnsiCompareFileName(ExcludeTrailingPathDelimiter(Dir),ExcludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName)))<>0) then
    begin
     if MessageDlg('Le r�pertoire par d�faut de l''exportation des donn�es � chang�.'+
                    RetourChariotDouble+
                    'Ancien : '+
                    RetourChariotDouble+
                    ExcludeTrailingPathDelimiter(dir)+
                    RetourChariotDouble+
                    'Nouveau : '+
                    RetourChariotDouble+
                    ExcludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName))+
                    RetourChariotDouble+
                    'Voulez-Vous conserver ce changement ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
             dir:=IncludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName));
    end;
  end;
Liste.Free;
FIniFile.Free;
PatienterFermer;
end;

//
End;

Function ExportDonnees(Dataset:TDataset;var Dir:string;NomExport:string):TStringList;
Var
CheminFichier:String;
Affichage:boolean;
FFileName : string;
Begin
try
 try
  if DMExport = nil then DMExport:=TDMExport.Create(Application.MainForm);
  Affichage:=true;
  if NomExport='' then NomExport:='Export_'+E.NomDossier + E.NomExo + '.Txt';
  //demande et sauvegarde du chemin du fichier final
  DMExport.SaveDialog1.DefaultExt:='Txt';
  DMExport.SaveDialog1.Filter:='Fichier texte (*.txt)';
  DMExport.SaveDialog1.FileName := NomExport;
  if empty(E.RepertoireExPortDossier)then E.RepertoireExPortDossier:=IncludeTrailingPathDelimiter(E.RepertoireDossier)+C_RepExportation;
  if empty(Dir)then Dir := E.RepertoireExPortDossier;
  DMExport.SaveDialog1.InitialDir := Dir;

  if not DirectoryExists(DMExport.SaveDialog1.InitialDir) then
    begin
      if not CreateDir(DMExport.SaveDialog1.InitialDir) then
        Raise exception.CreateFmt('Erreur lors de la tentative de cr�ation du dossier '+DMExport.SaveDialog1.InitialDir,['']);
    end;
  DMExport.SaveDialog1.Title := 'Exportation des donn�es ...';

  if DMExport.SaveDialog1.Execute then CheminFichier:= DMExport.SaveDialog1.FileName
  else abort;

  PatienterAffich(false);

  result:=exportdataset(dataset,CheminFichier);
  result.SaveToFile(CheminFichier);

 except
  Affichage:=False;
  Showmessage('Erreur lors de l''exportation des donn�es !');
  abort;
 end;
finally
 if Affichage then
  begin
   Showmessage('Fin de l''exportation des donn�es !');
   if (AnsiCompareFileName(ExcludeTrailingPathDelimiter(Dir),ExcludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName)))<>0) then
    begin
     if MessageDlg('Le r�pertoire par d�faut de l''exportation des donn�es � chang�.'+
                    RetourChariotDouble+
                    'Ancien : '+
                    RetourChariotDouble+
                    ExcludeTrailingPathDelimiter(dir)+
                    RetourChariotDouble+
                    'Nouveau : '+
                    RetourChariotDouble+
                    ExcludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName))+
                    RetourChariotDouble+
                    'Voulez-Vous conserver ce changement ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
             dir:=IncludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName));
    end;
  end;
PatienterFermer;
end;
End;

Function ExportDonnees(Liste:TStringlist;var Dir:string;NomExport:string):TStringList;
Var
CheminFichier:String;
Affichage:boolean;
FFileName : string;
Begin
try
 try
  if DMExport = nil then DMExport:=TDMExport.Create(Application.MainForm);
  Affichage:=true;
  if NomExport='' then NomExport:='Export_'+E.NomDossier + E.NomExo + '.Txt';
  //demande et sauvegarde du chemin du fichier final
  DMExport.SaveDialog1.DefaultExt:='Txt';
  DMExport.SaveDialog1.Filter:='Fichier texte (*.txt)';
  DMExport.SaveDialog1.FileName := NomExport;
  if empty(E.RepertoireExPortDossier)then E.RepertoireExPortDossier:=IncludeTrailingPathDelimiter(E.RepertoireDossier)+C_RepExportation;
  if empty(Dir)then Dir := E.RepertoireExPortDossier;
  DMExport.SaveDialog1.InitialDir := Dir;

  if not DirectoryExists(DMExport.SaveDialog1.InitialDir) then
    begin
      if not CreateDir(DMExport.SaveDialog1.InitialDir) then
        Raise exception.CreateFmt('Erreur lors de la tentative de cr�ation du dossier '+DMExport.SaveDialog1.InitialDir,['']);
    end;
  DMExport.SaveDialog1.Title := 'Exportation des donn�es ...';

  if DMExport.SaveDialog1.Execute then CheminFichier:= DMExport.SaveDialog1.FileName
  else abort;

 PatienterAffich(false);

  if liste=nil then abort;
  Liste.SaveToFile(CheminFichier);

 except
  Affichage:=False;
  Showmessage('Erreur lors de l''exportation des donn�es !');
  abort;
 end;
finally
 if Affichage then
  begin
   Showmessage('Fin de l''exportation des donn�es !');
   if (AnsiCompareFileName(ExcludeTrailingPathDelimiter(Dir),ExcludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName)))<>0) then
    begin
     if MessageDlg('Le r�pertoire par d�faut de l''exportation des donn�es � chang�.'+
                    RetourChariotDouble+
                    'Ancien : '+
                    RetourChariotDouble+
                    ExcludeTrailingPathDelimiter(dir)+
                    RetourChariotDouble+
                    'Nouveau : '+
                    RetourChariotDouble+
                    ExcludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName))+
                    RetourChariotDouble+
                    'Voulez-Vous conserver ce changement ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
             dir:=IncludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName));
    end;
  end;
PatienterFermer;
end;
//
End;

Procedure RecupDataset(ListeProperties : TStringList ; Dataset : TDatasetExport);
var
Query : TQuery;
i,j,tmp : integer;
Repertoire:String;
begin
i:=0;
j:=1;
Repertoire:='';
   while i<=ListeProperties.Count-1 do
   begin
   //on traite les champs
       if str_recherchesouschaine(UpperCase(ListeProperties.Names[i]),'TYPE').retour then
         begin
           Dataset.TypeData:=ListeProperties.ValueFromIndex[i];
         end;
   //on traite les champs
       if str_recherchesouschaine(UpperCase(ListeProperties.Names[i]),'CHAMPS.'+IntToStr_Lgr(j)).retour then
         begin
           Dataset.ListeChamps.Add(ListeProperties.ValueFromIndex[i]);
           inc(j);
         end;
    //on traite le r�pertoire
       if str_recherchesouschaine(UpperCase(ListeProperties.Names[i]),'REPERTOIRE.'+IntToStr_Lgr(j)).retour then
         begin
           if UpperCase(ListeProperties.ValueFromIndex[i]) = 'DOSSIER' then
              Repertoire:= E.RepertoireDossier;
           if UpperCase(ListeProperties.ValueFromIndex[i]) = 'PROGRAM' then
              Repertoire:= E.RepertoireProgram;
           if UpperCase(ListeProperties.ValueFromIndex[i]) = 'EXERCICE' then
              Repertoire:= E.RepertoireExercice;
           inc(j);
         end;

   //on traite les param�tres
       if str_recherchesouschaine(UpperCase(ListeProperties.Names[i]),'PARAM.'+IntToStr_Lgr(j)).retour then
         begin
             Dataset.ListeParams.Add(UpperCase(ListeProperties.ValueFromIndex[i]));
           inc(j);
         end;

   //on traite la requete
       if str_recherchesouschaine(UpperCase(ListeProperties.Names[i]),'REQUETE.'+IntToStr_Lgr(j)).retour then
         begin
            Query := TQuery.Create(application.MainForm);
            query.close;
            query.SQL.Clear;
            if empty(Repertoire)then
              query.DatabaseName:= DMRech.TaBalanceRech.DatabaseName
            else
              query.DatabaseName:= Repertoire;
            tmp:=i;
            while (tmp<=ListeProperties.Count-1)and str_recherchesouschaine(UpperCase(ListeProperties.Names[tmp]),'REQUETE.'+IntToStr_Lgr(j)).retour do
              begin
                Query.SQL.Add(ListeProperties.ValueFromIndex[tmp]);
                inc(j);
                inc(tmp);
              end;
            i:=tmp-1;
            Dataset.DatasetExport:=query;
         end;
   inc(i);
   end;
   for i:=0 to Dataset.ListeParams.Count-1 do
     begin
          if UpperCase(Dataset.ListeParams.Strings[i]) = 'DEBUTEXO' then
             (Dataset.DatasetExport as  TQuery).Params[i].AsDate:=e.DatExoDebut;
          if UpperCase(Dataset.ListeParams.Strings[i]) = 'FINEXO' then
             (Dataset.DatasetExport as  TQuery).Params[i].AsDate:=e.DatExoFin;
     end;
end;


function ExportDataset(Dataset : Tdataset; CheminFichier : string; ListeChamp : TStringList;AvecChamps:boolean):TStringList;
begin
if not Dataset.Active then Dataset.Open;
Dataset.First;
if ListeChamp = nil then
  result:=ChampTableVersListeEx(dataset,';',false,AvecChamps)
else
  result:=ChampTableVersListeEx(ListeChamp,Dataset,';',false,AvecChamps);
end;


Function ExportDonnees(var Dir:string;NomExport:string):TStringList;
var
DatasetExport : TDatasetExport;
Tableau : array[1..1] of TDatasetExport;
begin
DatasetExport:=TDatasetExport.Create(application.MainForm);

//if DMRepart = nil then DMRepart:=TDMRepart.Create(Application.MainForm);
if DMExport =nil then DMExport := TDMExport.Create(Application.MainForm);
if DMDiocEtatBal= nil then DMDiocEtatBal := TDMDiocEtatBal.Create(application.MainForm);
DMExport.Requete.close;
DMExport.Requete.Open;

DatasetExport.DatasetExport:=DMExport.Requete;
DatasetExport.ListeChamps.Add('Compte');
DatasetExport.ListeChamps.Add('Debit_Report');
DatasetExport.ListeChamps.Add('Credit_Report');
DatasetExport.ListeChamps.Add('Debit_base');
DatasetExport.ListeChamps.Add('Credit_base');
DatasetExport.ListeChamps.Add('debit_total');
DatasetExport.ListeChamps.Add('credit_total');
DatasetExport.ListeChamps.Add('Report_Mouv_debit');
DatasetExport.ListeChamps.Add('Report_Mouv_Credit');
DatasetExport.ListeChamps.Add('Mouv_Debit');
DatasetExport.ListeChamps.Add('Mouv_Credit');

DatasetExport.TypeData:='Bilan';
////DatasetExport.DatasetExport:=DMDiocEtatBal.TaBalanceaffich;
////DatasetExport.ListeChamps.Add('Compte');
////DatasetExport.ListeChamps.Add('Solde_Debit_Report_Calc');
////DatasetExport.ListeChamps.Add('Solde_Credit_Report_Calc');
////DatasetExport.ListeChamps.Add('Debit_Base_Calc');
////DatasetExport.ListeChamps.Add('Credit_Base_Calc');
////DatasetExport.ListeChamps.Add('Solde_Debit_Total_Calc');
////DatasetExport.ListeChamps.Add('Solde_Credit_Total_Calc');
////DatasetExport.ListeChamps.Add('ComptePlanCpt');
////DatasetExport.TypeData:='Balance';
Tableau[1]:=DatasetExport;

ExportDonnees(tableau,Dir,NomExport,e.RepertoireProgram+'ExportationDeDonnees.ini');
DMExport.Requete.Close;

end;




function recupListeEdition():Tstringlist;
var
liste,ListeAtelier,ListeCpt:Tstringlist;
i:integer;
begin
try

liste := TStringList.Create;
result:=  TStringList.Create;


//exportation des acquisitions
liste:=EditionDesAcquisitionsL(C_EditionSimple,'2*',false,nil,'Immobilisations',true); // 5A3
for i:=0 to liste.Count-1 do
  begin
     result.Add(liste.Strings[i]) ;
  end;
//fin exportation des Acquisitions
liste.Clear;
//exportation des emprunts mouvements
liste:=EditionEmpruntMouvExerciceL(C_EditionSimple,false,nil,nil,true);  // 8B1VS et 8B1VT
for i:=0 to liste.Count-1 do
  begin
     result.Add(liste.Strings[i]) ;
  end;
//fin exportation des emprunts mouvements

//exportation des Repartition des annuit�s (emprunts)
liste:=EditionEmpruntRepartitionL(C_EditionSimple,false,nil,nil,true); // 8B2VC et 8B2VD et 8B3VC et 8B3VD et 8B4VC et 8B4VD
for i:=0 to liste.Count-1 do
  begin
     result.Add(liste.Strings[i]) ;
  end;
//fin exportation des Repartition des annuit�s (emprunts)

//exportation des Plus et Moins values fiscales L/Terme
liste:=EditionPMValuesFiscalesL(C_EditionSimple,false,nil,nil,'',true); // 9WM
for i:=0 to liste.Count-1 do
  begin
     result.Add(liste.Strings[i]) ;
  end;
//fin exportation des Plus et Moins values fiscales L/Terme

if (e.TypeClient=CL_Cogere)then       //or(e.TypeClient=CL_Saisie_Cogere)
    begin
        //exportation de la r�partition analytique
        liste:=EditionBalanceAnalytiqueAtelierL(C_EditionSimple,false,nil,nil,nil,2); //analytique
        if(liste<>nil)then
          for i:=0 to liste.Count-1 do
            begin
               result.Add(liste.Strings[i]) ;
            end;
        //fin exportation de la r�partition analytique

        //exportation des stocks de cl�ture
        if DMStock = nil then DMStock := TDMStock.Create(Application.MainForm);
        liste:=EditionStockL(C_EditionSimple,C_Cloture,nil,nil,true);          // Stocks
        for i:=0 to liste.Count-1 do
          begin
             result.Add(liste.Strings[i]) ;
          end;
        //fin exportation des stocks de cl�ture

        //exportation du Glivre des Qt�s pour compte 64111* et 64115*
        if DMEcritures = nil then DMEcritures := TDMEcritures.Create(Application.MainForm);
        ListeCpt:=TStringList.Create;
        DeFiltrageDataSet(DMRech.TaBalanceRech);
        FiltrageDataSet(DMRech.TaBalanceRech,CreeFiltreOU('compte',['64111*','64115*'])) ;
        ListeCpt:=ChampTableVersListe('Compte',DMRech.TaBalanceRech);
        liste:=EditionEcritureL(C_ExportationLiasse,C_TypeEditionLigneComplet,true,ListeCpt,nil,nil,false);
        for i:=0 to liste.Count-1 do
          begin
             result.Add(liste.Strings[i]) ;
          end;
        //fin exportation du Glivre des Qt�s pour compte 64111* et 64115*
    end;                                                                 
finally
liste.Free;
end;
end;

//Procedure ExportDonnees(Dataset:TDataset;NomExport:string);
//var
//DatasetExport : TDatasetExport;
//Tableau : array[1..2] of TDatasetExport;
//i:integer;
//begin
//DatasetExport:=TDatasetExport.Create(application.MainForm);
//for i:=0 to Dataset.FieldList.Count-1 do
//begin
//  DatasetExport.ListeChamps.Add(Dataset.Fields[i].Name);
//end;
//if (Dataset is TTable)then
//DatasetExport.TypeData:=(Dataset as TTable).TableName;
//Tableau[1]:=DatasetExport;
//ExportDonnees(tableau,NomExport);
//end;


//*** objet  TDatasetExport ***//

constructor TDatasetExport.Create(AOwner :TComponent);
    //constructeur
begin
  inherited Create;
  ListeChamps := TStringList.Create;
  ListeParams := TStringList.Create;
  //DatasetExport := TDataSet.Create(AOwner);
  DatasetExport := nil;
  TypeData := '';
end;

destructor TDatasetExport.Destroy;
//destructeur
begin
  ListeChamps.Free;
  ListeParams.Free;
  DatasetExport.Free;
  inherited Destroy;
end;

function TDatasetExport.GetListeChamps: TstringList;
begin
result:=FlisteChamps;
end;

procedure TDatasetExport.SetListeChamps(ListeChamps : Tstringlist);
begin
FlisteChamps:=ListeChamps;
end;

function TDatasetExport.GetListeParams: TstringList;
begin
result:=FListeParams;
end;

procedure TDatasetExport.SetListeParams(ListeParams : Tstringlist);
begin
FListeParams:=ListeParams;
end;

function  TDatasetExport.GetDatasetExport : TDataset;
begin
result := FDatasetExport;
end;

procedure  TDatasetExport.SetDatasetExport(DatasetExport:Tdataset);
begin
FDatasetExport := DatasetExport;
end;

function TDatasetExport.GetTypeData : string;
begin
result:=FTypeData;
end;

procedure TDatasetExport.SetTypeData(TypeData : string);
begin
FTypeData := TypeData;
end;


procedure TDMExport.RequeteCalcFields(DataSet: TDataSet);
var
TotauxBalance:TTotauxBalance;
InfosReport:TInfosReport;
debit,credit:currency;
begin
  DataSet.FindField('Debit_Report').AsCurrency:=0;
  DataSet.FindField('Credit_Report').AsCurrency:=0;
  DataSet.FindField('Debit_base').AsCurrency:=0;
  DataSet.FindField('Credit_base').AsCurrency:=0;
  DataSet.FindField('debit_total').AsCurrency:=0;
  DataSet.FindField('credit_total').AsCurrency:=0;
  DataSet.FindField('Report_Mouv_debit').AsCurrency:=0;
  DataSet.FindField('Report_Mouv_Credit').AsCurrency:=0;
  DataSet.FindField('Mouv_Debit').AsCurrency:=0;
  DataSet.FindField('Mouv_Credit').AsCurrency:=0;

  TotauxBalance:=DMDiocEtatBal.SommeTotauxBalanceParCompte(E.DatExoDebut,E.DatExoFin,DataSet.FindField('Compte').AsString);
  //Solde fin
  debit:=Arrondi(TotauxBalance.TotalSoldeDebitTotal,2);
  credit:=Arrondi(TotauxBalance.TotalSoldeCreditTotal,2);
  DetermineSolde(debit,credit);
  DataSet.FindField('debit_total').AsCurrency:=debit;
  DataSet.FindField('credit_total').AsCurrency:=credit;
  //solde mouvements
  debit:=Arrondi(TotauxBalance.TotalDebitBase,2);
  credit:=Arrondi(TotauxBalance.TotalCreditBase,2);
  DetermineSolde(debit,credit);
  DataSet.FindField('Debit_base').AsCurrency:=debit;
  DataSet.FindField('Credit_base').AsCurrency:=credit;
  //solde reports
  debit:=Arrondi(TotauxBalance.TotalSoldeDebitReport,2);
  credit:=Arrondi(TotauxBalance.TotalSoldeCreditReport,2);
  DetermineSolde(debit,credit);
  DataSet.FindField('Debit_Report').AsCurrency:=debit;
  DataSet.FindField('Credit_Report').AsCurrency:=credit;

  //Report_Mouve
  debit:=Arrondi(TotauxBalance.TotalDebitReport,2);
  credit:=Arrondi(TotauxBalance.TotalCreditReport,2);
  DataSet.FindField('Report_Mouv_debit').AsCurrency:=debit;
  DataSet.FindField('Report_Mouv_Credit').AsCurrency:=credit;

  //Mouvements
  debit:=Arrondi(TotauxBalance.TotalDebitBase,2);
  credit:=Arrondi(TotauxBalance.TotalCreditBase,2);
  DataSet.FindField('Mouv_Debit').AsCurrency:=debit;
  DataSet.FindField('Mouv_Credit').AsCurrency:=credit;

  if ((copy(DataSet.FindField('Compte').AsString,1,1) ='6') or (copy(DataSet.FindField('Compte').AsString,1,1) ='7')) then
    begin
     InfosReport:=Infos_TInfosReport(DMRech.TaReportRech,'Compte',[DataSet.FindField('Compte').AsString]);
     if InfosReport.ResultInfos then
      begin
        debit:=Arrondi(InfosReport.Debit_Report,2);
        credit:=Arrondi(InfosReport.Credit_Report,2);
        DetermineSolde(debit,credit);
        DataSet.FindField('Debit_Report').AsCurrency:=debit;
        DataSet.FindField('Credit_Report').AsCurrency:=credit;
      end
     else
      begin
        DataSet.FindField('Debit_Report').AsCurrency:=0;
        DataSet.FindField('Credit_Report').AsCurrency:=0;
      end;
    end;
end;


Procedure ExportEcriturePourControlFiscal(debControl,finControl:TDate; siren:string; constNomFichier:string; resultChoixParamFEC:TResultChoixParamFEC);

Var
Text,titreListeFinale:String;
CheminFichier,repertoireFichier:String;
IDCompte:String;
Affichage:boolean;
datefin,dateTmp:TDetailDate;
annee,mois,jour:word;
listeExo,listeEcriture,listeTemp,listeEcriturePointee,listeTempDebug:TStringList;
dateDebEnCours,dateFinEnCours:Tdate;
i,j,k,l,num,idEcriture,idPieceOld,commitLgr,valeurId:integer;
ReqEcritureControlFiscal,RequeteBalance:TQuery;
tableUpdate,tableLecture:TTable;
DirExoBalance,codeExo,ligneControl:string;
listeLongue:boolean;
debit,credit:currency;

//ParamLibChoixRepAffiche:TParamLibChoixRepAffiche;
//ResultChoixRep:TResultChoixRep;
Begin
try
 try
   DecimalSeparator:=',';
  if DMExport = nil then DMExport:=TDMExport.Create(Application.MainForm);
  if(DMDiocEtatBal=nil)then DMDiocEtatBal:=TDMDiocEtatBal.Create(Application.MainForm);
  if(DMDiocEtatBalT=nil)then DMDiocEtatBalT:=TDMDiocEtatBalT.Create(Application.MainForm);



//  repertoireFichier:=IncludeTrailingPathDelimiter(E.RepertoireExportDossier)+'controleFiscal';
  repertoireFichier:=IncludeTrailingPathDelimiter(E.RepertoireExportDossier)+'';
  if SelectDirectory(repertoireFichier,[sdAllowCreate, sdPerformCreate, sdPrompt],0 )=false then abort;

//ParamLibChoixRepAffiche.AfficheRepDefDansEdit := true;
//ParamLibChoixRepAffiche.RepDefaut := IncludeTrailingPathDelimiter(E.RepertoireExportDossier)+'controleFiscal';
//ParamLibChoixRepAffiche.TitreForm := 'Exportation des �critures pour la p�riode du '+DateToStr_Lgr(debControl)+' au '+DateToStr_Lgr(finControl);
//ParamLibChoixRepAffiche.TitreDialogRep := 'Choix du r�pertoire de l''exportation.';
//ResultChoixRep:=LibChoixRepAffiche(ParamLibChoixRepAffiche);
//if(ResultChoixRep.Retour=false) then abort;

  Affichage:=true;
  tableUpdate:=TTable.Create(DMExport);
  tableLecture:=TTable.Create(DMExport);
  listeEcriture:=TStringList.Create;
  listeExo:=TStringList.Create;
  listeTemp:=TStringList.create;
  listeEcriturePointee:=TStringList.Create;
  listeEcriturePointee.Duplicates:=dupIgnore;
  listeTempDebug:=TStringList.Create;
  ReqEcritureControlFiscal:=TQuery.Create(DMExport);
  RequeteBalance:=TQuery.Create(DMExport);



  commitLgr:=0;
  num:=0;
  idPieceOld:=0;
  CoherenceBalance(nil);

    // d�coupage de la p�riode totale en p�riode cl�tur�e
                  DMExport.ReqControl.close;
                  DMExport.ReqControl.SQL.Clear;
                  DMExport.ReqControl.DatabaseName := DM_C_NomAliasProgram;
                  DMExport.ReqControl.SQL.Add('select nom_exo,Date_deb_exo,date_fin_exo,cloture,exo_saisie,dir_exo from GestDossier where nom_dossier='''+E.NomDossier+''' and ');

                  DMExport.ReqControl.SQL.Add(' ((cast(Date_deb_exo as date)>= cast(:deb as date) or cast(date_fin_exo as date)>=cast(:deb as date)) '+
                  ' and(cast(Date_deb_exo as date)<= cast(:fin as date) or cast(date_fin_exo as date)<=cast(:fin as date))) ');

//                  DMExport.ReqControl.SQL.Add(' ((cast(Date_deb_exo as date)<= cast(:deb as date) and cast(date_fin_exo as date)>=cast(:deb as date)) '+
//                  ' or(cast(Date_deb_exo as date)<= cast(:fin as date) and cast(date_fin_exo as date)>=cast(:fin as date))) ');



                  DMExport.ReqControl.ParamByName('deb').AsDate:=debControl;
                  DMExport.ReqControl.ParamByName('fin').AsDate:=finControl;

                  DMExport.ReqControl.Open;
                  listeExo:=ChampTableVersListeEx(DMExport.ReqControl,';',false,false);
   //S�l�ction de toutes les �critures de la p�riode en cours
   for i:=0 to listeExo.Count-1 do
   begin
      dateDebEnCours:=StrToDate_Lgr(str_getstringelement(listeExo[i],2,';'));
      dateFinEnCours:=StrToDate_Lgr(str_getstringelement(listeExo[i],3,';'));
      DirExoBalance:=str_getstringelement(listeExo[i],6,';');
      codeExo:=str_getstringelement(listeExo[i],5,';');
      if(CompareDate(debControl,dateDebEnCours)<0)then dateDebEnCours:=debControl;
      if(CompareDate(finControl,dateFinEnCours)>0)then dateFinEnCours:=finControl;
      DecodeDate(dateFinEnCours,annee,mois,jour);
      datefin.AnStr:=IntToStr(annee);
      datefin.MoisStr:=IntToStr(mois);
      datefin.JourStr:=IntToStr(jour);
      while(length(datefin.AnStr)<4)do datefin.AnStr:='20'+datefin.AnStr;
      while(length(datefin.MoisStr)<2)do datefin.MoisStr:='0'+datefin.MoisStr;
      while(length(datefin.JourStr)<2)do datefin.JourStr:='0'+datefin.JourStr;
      datefin.DateStrFormat:=datefin.AnStr+datefin.MoisStr+datefin.JourStr;

//cr�ation d'une table temporaire
  if  FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'EcritureControleFiscal.db') then
     DeleteFile(Pchar(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'EcritureControleFiscal.db'));

  if  FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'EcritureLettreTemp.db') then
      DeleteFile(Pchar(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'EcritureLettreTemp.db'));

  if  FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'PointagePeriode.db') then
      DeleteFile(Pchar(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'PointagePeriode.db'));

    DMExport.ReqControl.close;
    DMExport.ReqControl.SQL.Clear;
    DMExport.ReqControl.DatabaseName:=DM_C_NomAliasDossier;
    DMExport.ReqControl.sql.Add(' create table EcritureControleFiscal (idEcriture integer,JournalCode varchar(2), ');
    DMExport.ReqControl.sql.Add(' JournalLib varchar(100),EcritureNum varchar(25),EcritureDate date,compteNum varchar(8),');
    DMExport.ReqControl.sql.Add(' CompteLib varchar(100),CompAuxNum varchar(8),CompAuxLib varchar(100),PieceRef varchar(9),');
    DMExport.ReqControl.sql.Add(' PieceDate date,EcritureLib varchar(100),');
    DMExport.ReqControl.sql.Add(' Debit float,Credit float,EcritureLet varchar(25),DateLet date,validDate date,Montantdevise float,idevise varchar(2),traite boolean,id_ligne integer ');
    DMExport.ReqControl.sql.Add(' ,PRIMARY KEY (idEcriture))');
    DMExport.ReqControl.ExecSQL;

    DMExport.ReqControl.close;
    DMExport.ReqControl.SQL.Clear;
    DMExport.ReqControl.sql.Add(' create table EcritureLettreTemp (idEcriture integer, lettre varchar(25),debit float,credit float,dateLettrage date,traite boolean,PRIMARY KEY (idEcriture))');
    DMExport.ReqControl.ExecSQL;

//       DMExport.ReqControl.close;
//    DMExport.ReqControl.SQL.Clear;
//    DMExport.ReqControl.sql.Add(' create table PointagePeriode (id number,id_debit integer,id_credit integer, dateTva date,montant currency, Tvadate date, validation date,qui varchar(10),quand timestamp,PRIMARY KEY (id))');
//    DMExport.ReqControl.ExecSQL;
      TableDuplique(DMRech.TaPointageRech,e.RepertoireDossier,'PointagePeriode.DB',e.RepertoireDossier,false);

//  DMExport.SaveDialog1.DefaultExt:='csv';
//  DMExport.SaveDialog1.FileName := siren+constNomFichier+datefin.DateStrFormat+'.csv';
//  DMExport.SaveDialog1.InitialDir := E.RepertoireExportDossier;
//
//  DMExport.SaveDialog1.Title := 'Exportation des �critures pour la p�riode du '+DateToStr_Lgr(deb)+' au '+DateToStr_Lgr(fin);
//  if DMExport.SaveDialog1.Execute then CheminFichier:= DMExport.SaveDialog1.FileName

  CheminFichier:= IncludeTrailingPathDelimiter(repertoireFichier)+siren+constNomFichier+datefin.DateStrFormat+resultChoixParamFEC.Extension;
  if FileExists(CheminFichier) then
   DeleteFile(PChar(CheminFichier));
      //cr�ation d'une pi�ce fictive reprenant tous les reports des comptes de 1 � 599 de la balance
//      if ListeCompte = nil then ListeCompte:=ChampTableVersListe('Compte',DMDiocEtatBal.TaBalanceCalc);
//      DMDiocEtatBal.ListeFiltreEdit.Assign(ListeCompte);
         RequeteBalance.close;
         RequeteBalance.SQL.Clear;
//         RequeteBalance.Filtered := true;
//         RequeteBalance.OnFilterRecord:=DMDiocEtatBal.TaBalanceCalcFilterRecord;
         RequeteBalance.DatabaseName:=DM_C_NomAliasDossier;

         RequeteBalance.SQL.Add('select p.libelle,P.compte,bt.tiers,t.nom, (b.Debit_Report)as Debit_Report_bal,(b.Credit_Report)as Credit_Report_bal, (bt.Debit_Report)as Debit_Report_balT,(bt.Credit_Report)as Credit_Report_balT ');
         RequeteBalance.SQL.Add(' from plancpt P');
         RequeteBalance.SQL.Add(' join  "'+IncludeTrailingPathDelimiter(DirExoBalance)+'balance" b on p.compte=b.compte');
         RequeteBalance.SQL.Add(' left join  "'+IncludeTrailingPathDelimiter(DirExoBalance)+'balanceTiers" bt on b.compte=bt.compte');
         RequeteBalance.SQL.Add(' left join  Tiers t on bt.tiers=t.tiers');
         RequeteBalance.SQL.Add(' where cast(p.compte as integer) between 1 and 599999999 and ( ((b.Debit_Report<>0 or b.Credit_Report<>0)and bt.tiers is null )');
         RequeteBalance.SQL.Add('  or ( (bt.Debit_Report<>0 or bt.Credit_Report<>0)) )');
         RequeteBalance.SQL.Add(' order by P.compte,bt.tiers');
//         RequeteBalance.Prepare;
         RequeteBalance.Open;
         RequeteBalance.First;
      k:=0;
      idEcriture:=501;
      num:=1;
           DMExport.TableControlFiscal.TableName:='EcritureControleFiscal.db';
           TableGereStartTransaction(DMExport.TableControlFiscal);
           TableGereOpen(DMExport.TableControlFiscal);

      while not RequeteBalance.Eof do
      begin

           TableGereInsert(DMExport.TableControlFiscal);
           DMExport.TableControlFiscal.FindField('JournalCode').AsString:='AN';
           DMExport.TableControlFiscal.FindField('JournalLib').AsString:='A Nouveaux';
           DMExport.TableControlFiscal.FindField('idEcriture').AsInteger:=idEcriture;
           DMExport.TableControlFiscal.FindField('EcritureNum').AsInteger:=num;
           DMExport.TableControlFiscal.FindField('compteNum').AsString:=RequeteBalance.findfield('compte').AsString;
           DMExport.TableControlFiscal.FindField('CompteLib').AsString:=RequeteBalance.findfield('Libelle').AsString;
           DMExport.TableControlFiscal.FindField('CompAuxNum').AsString:=RequeteBalance.findfield('tiers').AsString;
           DMExport.TableControlFiscal.FindField('CompAuxLib').AsString:=RequeteBalance.findfield('nom').AsString;
           DMExport.TableControlFiscal.FindField('PieceRef').AsString:='AN'+codeExo+'00000';
           DMExport.TableControlFiscal.FindField('EcritureLib').AsString:='A.N au '+str_getstringelement(listeExo[i],2,';');
           DMExport.TableControlFiscal.FindField('PieceDate').AsDateTime:=dateDebEnCours;
           DMExport.TableControlFiscal.FindField('EcritureDate').AsDateTime:=dateDebEnCours;
           if(RequeteBalance.findfield('tiers').AsString<>'')then
           begin
             DMExport.TableControlFiscal.FindField('Debit').AsCurrency:=RequeteBalance.findfield('Debit_Report_balT').AsCurrency;
             DMExport.TableControlFiscal.FindField('Credit').AsCurrency:=RequeteBalance.findfield('Credit_Report_balT').AsCurrency;
             debit:=RequeteBalance.findfield('Debit_Report_balT').AsCurrency;
             credit:=RequeteBalance.findfield('Credit_Report_balT').AsCurrency;
           end
           else
           begin
             DMExport.TableControlFiscal.FindField('Debit').AsCurrency:=RequeteBalance.findfield('Debit_Report_bal').AsCurrency;
             DMExport.TableControlFiscal.FindField('Credit').AsCurrency:=RequeteBalance.findfield('Credit_Report_bal').AsCurrency;
             debit:=RequeteBalance.findfield('Debit_Report_bal').AsCurrency;
             credit:=RequeteBalance.findfield('Credit_Report_bal').AsCurrency;
           end;
            //pour ne pas qu'il y ai de montant dans les 2 colonnes � la fois
           DetermineSolde(debit,credit);
           DMExport.TableControlFiscal.FindField('Debit').AsCurrency:=debit;
           DMExport.TableControlFiscal.FindField('Credit').AsCurrency:=credit;

          DMExport.TableControlFiscal.FindField('traite').AsBoolean:=true;
           DMExport.TableControlFiscal.FindField('ValidDate').AsDateTime:=dateDebEnCours;


           TableGerePost(DMExport.TableControlFiscal);
           if(k=50)then
             begin
               TableGereCommit(DMExport.TableControlFiscal);
               TableGereStartTransaction(DMExport.TableControlFiscal);
               k:=0;
             end;
          RequeteBalance.Next;
          inc(k);
          inc(idEcriture);
      end;
       TableGereCommit(DMExport.TableControlFiscal);

      DMExport.ReqControl.close;
      DMExport.ReqControl.SQL.Clear;
      DMExport.ReqControl.DatabaseName := DM_C_NomAliasDossier;

      DMExport.ReqControl.SQL.Add(' select (substring(cast(p.reference as char(9)) from 1 for 2)) as JournalCode,m.libelle_model as JournalLib, ');
      DMExport.ReqControl.SQL.Add(' e.id as idEcriture,p.id as idPiece,p."Quand" as EcritureDate,e.compte AS compteNum ');
      DMExport.ReqControl.SQL.Add(' ,pl.libelle AS CompteLib,e.tiers AS CompAuxNum,t.nom as CompAuxLib, ');
      DMExport.ReqControl.SQL.Add(' p.reference AS PieceRef,p."date" AS PieceDate,e.libelle AS EcritureLib,e.debit AS Debit,e.credit AS Credit,e.typeLigne,e.id_ligne ');
      DMExport.ReqControl.SQL.Add(' from piece p ');
      DMExport.ReqControl.SQL.Add(' join ecriture e on(e.id_piece=p.id) ');
      DMExport.ReqControl.SQL.Add(' left join plancpt pl on (pl.compte=e.compte) ');
      DMExport.ReqControl.SQL.Add(' left join tiers t on t.tiers=e.tiers ');
      DMExport.ReqControl.SQL.Add(' join model m on m.journal=substring(cast(p.reference as char(9)) from 1 for 2) ');
      DMExport.ReqControl.SQL.Add(' where p."date" between :deb and :fin ');
//      DMExport.ReqControl.SQL.Add(' and p.reference=''AC0''');
//      DMExport.ReqControl.SQL.Add(' and (p.reference=''AC1100015'' or p.reference=''AC1100016'' or p.reference=''AC1100017'' or p.reference=''AC1100024'' ');
//      DMExport.ReqControl.SQL.Add(' or p.reference=''AC1100054'' or p.reference=''AC1100097'' or p.reference=''AC1100055'' or p.reference=''AC1100046'' or p.reference=''AC1100068'' or p.reference=''OD1100010'')');        // )
      DMExport.ReqControl.SQL.Add(' order by p."Quand",e.typeLigne,e.id');

      DMExport.ReqControl.ParamByName('deb').AsDate:=dateDebEnCours;
      DMExport.ReqControl.ParamByName('fin').AsDate:=dateFinEnCours;
//      DMExport.ReqControl.Prepare;
      DMExport.ReqControl.Open;
      DMExport.ReqControl.first;
//      ChampTableVersVarListeEx(['JournalCode','JournalLib','idEcriture'],DMExport.ReqControl,listeEcriturePointee,resultChoixParamFEC.Separateur,false,true);
//      listeEcriturePointee.SaveToFile(CheminFichier);
      DMExport.ReqControl.first;
      
      k:=0;

      while not DMExport.ReqControl.Eof do
      begin
          if(DMExport.ReqControl.findfield('idPiece').AsInteger<>idPieceOld)then
           inc(num);
           DMExport.TableControlFiscal.TableName:='EcritureControleFiscal.db';
           TableGereStartTransaction(DMExport.TableControlFiscal);
           TableGereOpen(DMExport.TableControlFiscal);
           TableGereInsert(DMExport.TableControlFiscal);
           DMExport.TableControlFiscal.FindField('JournalCode').AsString:=DMExport.ReqControl.findfield('JournalCode').AsString;
           DMExport.TableControlFiscal.FindField('JournalLib').AsString:=DMExport.ReqControl.findfield('JournalLib').AsString;
           DMExport.TableControlFiscal.FindField('idEcriture').AsInteger:=DMExport.ReqControl.findfield('idEcriture').AsInteger;
           DMExport.TableControlFiscal.FindField('EcritureNum').AsInteger:=num;
           DMExport.TableControlFiscal.FindField('compteNum').AsString:=DMExport.ReqControl.findfield('compteNum').AsString;
           DMExport.TableControlFiscal.FindField('CompteLib').AsString:=DMExport.ReqControl.findfield('CompteLib').AsString;
           DMExport.TableControlFiscal.FindField('CompAuxNum').AsString:=DMExport.ReqControl.findfield('CompAuxNum').AsString;
           DMExport.TableControlFiscal.FindField('CompAuxLib').AsString:=DMExport.ReqControl.findfield('CompAuxLib').AsString;
           DMExport.TableControlFiscal.FindField('PieceRef').AsString:=DMExport.ReqControl.findfield('PieceRef').AsString;
           DMExport.TableControlFiscal.FindField('EcritureLib').AsString:=DMExport.ReqControl.findfield('EcritureLib').AsString;
           DMExport.TableControlFiscal.FindField('PieceDate').AsDateTime:=DMExport.ReqControl.findfield('PieceDate').AsDateTime;
           DMExport.TableControlFiscal.FindField('EcritureDate').AsDateTime:=DMExport.ReqControl.findfield('EcritureDate').AsDateTime;
           DMExport.TableControlFiscal.FindField('Debit').AsCurrency:=DMExport.ReqControl.findfield('Debit').AsCurrency;
           DMExport.TableControlFiscal.FindField('Credit').AsCurrency:=DMExport.ReqControl.findfield('Credit').AsCurrency;
           DMExport.TableControlFiscal.FindField('traite').AsBoolean:=false;
           DMExport.TableControlFiscal.FindField('ValidDate').AsDateTime:=DMExport.ReqControl.findfield('EcritureDate').AsDateTime;
           DMExport.TableControlFiscal.FindField('id_ligne').AsInteger:=DMExport.ReqControl.findfield('id_ligne').AsInteger;

           idPieceOld:=DMExport.ReqControl.findfield('idPiece').AsInteger;
           TableGerePost(DMExport.TableControlFiscal);
           if(k=50)then
             begin
               TableGereCommit(DMExport.TableControlFiscal);
               k:=0;
             end;
          DMExport.ReqControl.Next;
          inc(k);

      end;
       TableGereCommit(DMExport.TableControlFiscal);

//       ReqEcritureControlFiscal.close;
//      ReqEcritureControlFiscal.sql.Clear;
//      ReqEcritureControlFiscal.DatabaseName:=DM_C_NomAliasDossier;
//      ReqEcritureControlFiscal.SQL.add(' insert into PointagePeriode select * from Pointage');
//      ReqEcritureControlFiscal.ExecSQL;



       ReqEcritureControlFiscal.close;
      ReqEcritureControlFiscal.sql.Clear;
      ReqEcritureControlFiscal.DatabaseName:=DM_C_NomAliasDossier;
      ReqEcritureControlFiscal.SQL.add(' delete from PointagePeriode p2 where p2.id not in(select p.id from pointage p join EcritureControleFiscal ecf on ecf.idEcriture=p.id_debit ');
      ReqEcritureControlFiscal.SQL.add('  or ecf.idEcriture=p.id_credit where cast("p.date" as date) <=cast(:fin as date) and cast("p.tvaDate" as date) <=cast(:fin as date)   and ecf.traite=false)');
      ReqEcritureControlFiscal.ParamByName('fin').AsDateTime:=dateFinEnCours;
      ReqEcritureControlFiscal.ExecSQL;


      //r�cup�rer les pointages pour chaque ligne de la table
       ReqEcritureControlFiscal.close;
      ReqEcritureControlFiscal.sql.Clear;
      ReqEcritureControlFiscal.DatabaseName:=DM_C_NomAliasDossier;
      ReqEcritureControlFiscal.SQL.add(' select ecf.idEcriture,ecf.debit,ecf.credit,p.quand,ecf.EcritureLet from pointage p join EcritureControleFiscal ecf on ecf.idEcriture=p.id_debit ');
      ReqEcritureControlFiscal.SQL.add(' or ecf.idEcriture=p.id_credit where cast("p.date" as date) <=cast(:fin as date) and cast("p.tvaDate" as date) <=cast(:fin as date)   and ecf.traite=false');
      ReqEcritureControlFiscal.ParamByName('fin').AsDateTime:=dateFinEnCours;
//      ReqEcritureControlFiscal.ParamByName('fin2').AsDateTime:=fin;
//      ReqEcritureControlFiscal.Filtered:=true;
//      ReqEcritureControlFiscal.Filter:='EcritureLet = ''''';
//      ReqEcritureControlFiscal.Prepare;
      ReqEcritureControlFiscal.Open;
       ReqEcritureControlFiscal.First;
      num:=1;
      while (not ReqEcritureControlFiscal.eof)do
      begin

        DMExport.ReqEcriture.Close;
        DMExport.ReqEcriture.DatabaseName:=DM_C_NomAliasDossier;
        DMExport.ReqEcriture.SQL.Clear;
        //if(ReqEcritureControlFiscal.findfield('idEcriture').AsString='')then showmessage('id vide');
        DMExport.ReqEcriture.SQL.Add(' select ecf.EcritureLet from EcritureControleFiscal ecf where idEcriture='''+ReqEcritureControlFiscal.findfield('idEcriture').AsString+'''');
//        DMExport.ReqEcriture.Prepare;
        DMExport.ReqEcriture.open;
        DMExport.ReqEcriture.first;
        if(DMExport.ReqEcriture.recordcount>0)then
          if(DMExport.ReqEcriture.findfield('EcritureLet').AsString='')then
          begin
          listeEcriture:=recuperePointagesLies_A_EcritureControlFiscal(ReqEcritureControlFiscal.findfield('idEcriture').AsInteger,ReqEcritureControlFiscal.findfield('debit').AsCurrency,
          ReqEcritureControlFiscal.findfield('credit').AsCurrency);
          if(listeEcriture.count<>0)then
               enregistreLettrage(ReqEcritureControlFiscal.findfield('idEcriture').AsInteger,IntToStr_Lgr(num),ReqEcritureControlFiscal.findfield('debit').AsCurrency,
                   ReqEcritureControlFiscal.findfield('credit').AsCurrency,ReqEcritureControlFiscal.findfield('quand').AsDateTime,true);

          DMExport.TableControlFiscal.close;
          DMExport.TableControlFiscal.TableName:='EcritureLettreTemp.db';
          TableGereStartTransaction(DMExport.TableControlFiscal);

          tableLecture.DatabaseName:=DM_C_NomAliasDossier;
          tableLecture.TableName:='EcritureLettreTemp.db';
          tableLecture.Filtered:=true;
          tableLecture.Filter:=' traite=faux or traite = null ';
          TableGereOpen(tableLecture);
          tableLecture.First;

          while(not tableLecture.eof)or((listeEcriture<>nil)and(listeEcriture.count>0))do
              begin 

                  if(listeEcriture<>nil)and (listeEcriture.Count<>0)then
                     enregistreListeLettrage(listeEcriture,num)
                  else
                  tableLecture.Refresh;

                  tableLecture.first;
                  listeEcriture.Clear;
                  listeEcriture:=recuperePointagesLies_A_EcritureControlFiscal(tableLecture.findfield('idEcriture').AsInteger,tableLecture.findfield('debit').AsCurrency,
                  tableLecture.findfield('credit').AsCurrency);
                  LettrageTraitee(tableLecture.findfield('idEcriture').AsInteger);

              end;//fin while not tableLecture.eof
              TableGereCommit(DMExport.TableControlFiscal);
          inc(num);

//          DMExport.UpdateControlFiscal.Close;

            tableUpdate.Close;
            tableUpdate.DatabaseName:=DM_C_NomAliasDossier;
             tableUpdate.tableName:='EcritureControleFiscal';
            TableGereOpen(tableUpdate);
            tableUpdate.FlushBuffers;
            TableGereStartTransaction(tableUpdate);
          DMExport.ReqControl.close;
          DMExport.ReqControl.sql.Clear;
          DMExport.ReqControl.sql.Add('select idEcriture,lettre,max(dateLettrage) as dateLettrage from EcritureLettreTemp group by idEcriture,lettre');
//           DMExport.ReqControl.Prepare;
          DMExport.ReqControl.open();
          DMExport.ReqControl.First;
//          listeTempDebug.Clear;
//          ChampTableVersVarListeEx(['idEcriture','lettre','dateLettrage'],DMExport.ReqControl,listeTempDebug,resultChoixParamFEC.Separateur,false,true);
//          listeLongue:=listeTempDebug.Count>10;
////          if(listeLongue)then
////            showmessage('liste longue - num :'+IntToStr_Lgr(num));
//
//          listeTempDebug.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'listeTempDebug.txt');
          DMExport.ReqControl.First;
          commitLgr:=0;
          while (not DMExport.ReqControl.eof)do
          begin
          try
//            if(FiltrageDataSet(tableUpdate,'idEcriture='+DMExport.ReqControl.findfield('idEcriture').AsString))then
            DeFiltrageDataSet(tableUpdate);
            valeurId:=0;
            if(DMExport.ReqControl.findfield('idEcriture')<>nil)then valeurId:=DMExport.ReqControl.findfield('idEcriture').AsInteger;
            if((valeurId<>0) and (tableUpdate.Locate('idEcriture',DMExport.ReqControl.findfield('idEcriture').AsString,[])))then
            begin
              TableGereEdit(tableUpdate);
              tableUpdate.FindField('EcritureLet').AsString:=DMExport.ReqControl.findfield('lettre').AsString;
              tableUpdate.FindField('DateLet').AsDateTime:=DMExport.ReqControl.findfield('dateLettrage').AsDateTime;
              TableGerePost(tableUpdate);
              inc(commitLgr);
            end;
            DMExport.ReqControl.next;
          if(commitLgr=50)then
             begin
               TableGereCommit(tableUpdate);
               TableGereStartTransaction(tableUpdate);
               commitLgr:=0;
             end;
          except
            showmessage(DMExport.ReqControl.findfield('idEcriture').AsString);
          end;
          end;
           TableGereCommit(tableUpdate);
          tableUpdate.FlushBuffers;
          DMExport.ReqControl.sql.Clear;
          DMExport.ReqControl.sql.Add(' delete  from EcritureLettreTemp');
          DMExport.ReqControl.Prepare;
          DMExport.ReqControl.ExecSQL();
          end;
          ReqEcritureControlFiscal.next;
      end;

      ReqEcritureControlFiscal.Close;
      ReqEcritureControlFiscal.SQL.Clear;
      


      ReqEcritureControlFiscal.SQL.Add('select * from EcritureControleFiscal order by EcritureDate,EcritureNum,id_ligne');
      ReqEcritureControlFiscal.open;

//      DMExport.TableControlFiscal.close;
//      DMExport.TableControlFiscal.TableName:='EcritureControleFiscal';
//      DeFiltrageDataSet(DMExport.TableControlFiscal);
//      TableGereOpen(DMExport.TableControlFiscal);
      listeEcriturePointee.Clear;
      
      if(resultChoixParamFEC.DatePieceDansDateEcriture)then
        ChampTableVersVarListeEx(['JournalCode','JournalLib','EcritureNum','PieceDate','CompteNum','CompteLib','CompAuxNum','CompAuxLib','PieceRef','PieceDate',
        'EcritureLib','Debit','Credit','EcritureLet','DateLet','ValidDate','MontantDevise','IDevise'],ReqEcritureControlFiscal,listeEcriturePointee,resultChoixParamFEC.Separateur[1],false)
      else
        ChampTableVersVarListeEx(['JournalCode','JournalLib','EcritureNum','EcritureDate','CompteNum','CompteLib','CompAuxNum','CompAuxLib','PieceRef','PieceDate',
        'EcritureLib','Debit','Credit','EcritureLet','DateLet','ValidDate','MontantDevise','IDevise'],ReqEcritureControlFiscal,listeEcriturePointee,resultChoixParamFEC.Separateur[1],false);

      titreListeFinale:='JournalCode'+resultChoixParamFEC.Separateur[1]+'JournalLib'+resultChoixParamFEC.Separateur[1]+'EcritureNum'+resultChoixParamFEC.Separateur[1]+
      'EcritureDate'+resultChoixParamFEC.Separateur[1]+'CompteNum'+resultChoixParamFEC.Separateur[1]+'CompteLib'+resultChoixParamFEC.Separateur[1]+
      'CompAuxNum'+resultChoixParamFEC.Separateur[1]+'CompAuxLib'+resultChoixParamFEC.Separateur[1]+'PieceRef'+resultChoixParamFEC.Separateur[1]+
      'PieceDate'+resultChoixParamFEC.Separateur[1]+'EcritureLib'+resultChoixParamFEC.Separateur[1]+'Debit'+resultChoixParamFEC.Separateur[1]+
      'Credit'+resultChoixParamFEC.Separateur[1]+'EcritureLet'+resultChoixParamFEC.Separateur[1]+'DateLet'+resultChoixParamFEC.Separateur[1]+
      'ValidDate'+resultChoixParamFEC.Separateur[1]+'MontantDevise'+resultChoixParamFEC.Separateur[1]+'IDevise';
      listeEcriturePointee.Insert(0,titreListeFinale);

      for l:=1 to  listeEcriturePointee.count-1 do
      begin
          ligneControl:=listeEcriturePointee.Strings[l];
          //EcritureDate
          dateTmp.Date_:=StrToDate1(GetStringElement(ligneControl,4,(resultChoixParamFEC.Separateur[1])));
          if(dateTmp.Date_<>0)then
            begin
                DecodeDate(dateTmp.Date_,annee,mois,jour);
                dateTmp.AnStr:=IntToStr(annee);
                dateTmp.MoisStr:=IntToStr(mois);
                dateTmp.JourStr:=IntToStr(jour);
                while(length(dateTmp.AnStr)<4)do dateTmp.AnStr:='20'+dateTmp.AnStr;
                while(length(dateTmp.MoisStr)<2)do dateTmp.MoisStr:='0'+dateTmp.MoisStr;
                while(length(dateTmp.JourStr)<2)do dateTmp.JourStr:='0'+dateTmp.JourStr;
                dateTmp.DateStrFormat:=dateTmp.AnStr+dateTmp.MoisStr+dateTmp.JourStr;
                ligneControl:=str_Setstringelement(ligneControl,4,resultChoixParamFEC.Separateur[1],dateTmp.DateStrFormat);
            end;
          //PieceDate
          dateTmp.Date_:=StrToDate1(GetStringElement(ligneControl,10,resultChoixParamFEC.Separateur[1]));
           if(dateTmp.Date_<>0)then
            begin
               DecodeDate(dateTmp.Date_,annee,mois,jour);
                dateTmp.AnStr:=IntToStr(annee);
                dateTmp.MoisStr:=IntToStr(mois);
                dateTmp.JourStr:=IntToStr(jour);
                while(length(dateTmp.AnStr)<4)do dateTmp.AnStr:='20'+dateTmp.AnStr;
                while(length(dateTmp.MoisStr)<2)do dateTmp.MoisStr:='0'+dateTmp.MoisStr;
                while(length(dateTmp.JourStr)<2)do dateTmp.JourStr:='0'+dateTmp.JourStr;
                dateTmp.DateStrFormat:=dateTmp.AnStr+dateTmp.MoisStr+dateTmp.JourStr;
                ligneControl:=str_Setstringelement(ligneControl,10,resultChoixParamFEC.Separateur[1],dateTmp.DateStrFormat);
            end;

          //DateLet
          dateTmp.Date_:=StrToDate1(GetStringElement(ligneControl,15,resultChoixParamFEC.Separateur[1]));
          if(dateTmp.Date_<>0)then
            begin
                DecodeDate(dateTmp.Date_,annee,mois,jour);
                dateTmp.AnStr:=IntToStr(annee);
                dateTmp.MoisStr:=IntToStr(mois);
                dateTmp.JourStr:=IntToStr(jour);
                while(length(dateTmp.AnStr)<4)do dateTmp.AnStr:='20'+dateTmp.AnStr;
                while(length(dateTmp.MoisStr)<2)do dateTmp.MoisStr:='0'+dateTmp.MoisStr;
                while(length(dateTmp.JourStr)<2)do dateTmp.JourStr:='0'+dateTmp.JourStr;
                dateTmp.DateStrFormat:=dateTmp.AnStr+dateTmp.MoisStr+dateTmp.JourStr;
                ligneControl:=str_Setstringelement(ligneControl,15,resultChoixParamFEC.Separateur[1],dateTmp.DateStrFormat);
            end;
          //validDate
          dateTmp.Date_:=StrToDate1(GetStringElement(ligneControl,16,resultChoixParamFEC.Separateur[1]));
          if(dateTmp.Date_<>0)then
            begin
                DecodeDate(dateTmp.Date_,annee,mois,jour);
                dateTmp.AnStr:=IntToStr(annee);
                dateTmp.MoisStr:=IntToStr(mois);
                dateTmp.JourStr:=IntToStr(jour);
                while(length(dateTmp.AnStr)<4)do dateTmp.AnStr:='20'+dateTmp.AnStr;
                while(length(dateTmp.MoisStr)<2)do dateTmp.MoisStr:='0'+dateTmp.MoisStr;
                while(length(dateTmp.JourStr)<2)do dateTmp.JourStr:='0'+dateTmp.JourStr;
                dateTmp.DateStrFormat:=dateTmp.AnStr+dateTmp.MoisStr+dateTmp.JourStr;
                ligneControl:=str_Setstringelement(ligneControl,16,resultChoixParamFEC.Separateur[1],dateTmp.DateStrFormat);
            end;
          listeEcriturePointee.Strings[l]:=ligneControl;
      end;
      listeEcriturePointee.SaveToFile(CheminFichier);
      listeEcriturePointee.Clear;
      tableUpdate.Close;
      tableLecture.close;
      DMExport.TableControlFiscal.Close;
      RequeteBalance.close;
      ReqEcritureControlFiscal.Close;
      DMExport.Requete.Close;
      DMExport.ReqControl.Close;
      DMExport.ReqPointage.Close;
      DMExport.ReqEcriture.Close;
  end;

 except
 TableGereRollBack(DMExport.TableControlFiscal);
 TableGereRollBack(DMExport.TableControlFiscal);
 ReqEcritureControlFiscal.Close;
 DMExport.ReqControl.Close;
 DMExport.ReqPointage.Close;
  Affichage:=False;
  Showmessage('Attention !!! Erreur lors de l''exportation de la balance !');
  abort;
 end;
finally
  DecimalSeparator:='.';
tableUpdate.Close;
tableLecture.close;
Initialise_TStringlist(listeEcriture);
Initialise_TStringlist(listeExo);
Initialise_TStringlist(listeTemp);
Initialise_TStringlist(listeEcriturePointee);
Initialise_TStringlist(listeTempDebug);
      tableUpdate.Close;
      tableLecture.close;
      DMExport.TableControlFiscal.Close;
      RequeteBalance.close;
      ReqEcritureControlFiscal.Close;
      DMExport.Requete.Close;
      DMExport.ReqControl.Close;
      DMExport.ReqPointage.Close;
      DMExport.ReqEcriture.Close;

 if Affichage then
  begin
   Showmessage('l''exportation des �critures pour le contr�le fiscal s''est bien termin�e !');

//   if AnsiCompareFileName(ExcludeTrailingPathDelimiter(E.RepertoireExportBalance),ExcludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName)))<>0 then
//    begin
//     if MessageDlg('Le r�pertoire par d�faut d''exportation de la balance � chang�.'+
//                    RetourChariotDouble+
//                    'Ancien : '+
//                    RetourChariotDouble+
//                    ExcludeTrailingPathDelimiter(E.RepertoireExportBalance)+
//                    RetourChariotDouble+
//                    'Nouveau : '+
//                    RetourChariotDouble+
//                    ExcludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName))+
//                    RetourChariotDouble+
//                    'Voulez-Vous conserver ce changement ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
//             E.RepertoireExportBalance:=IncludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName));
//    end;
  end;
end;
end;

//Procedure ExportEcriturePourControlFiscal(debControl,finControl:TDate; siren:string; constNomFichier:string);
//Var
//Text:String;
//CheminFichier,repertoireFichier:String;
//IDCompte:String;
//Affichage:boolean;
//datefin,dateTmp:TDetailDate;
//annee,mois,jour:word;
//listeExo,listeEcriture,listeTemp,listeEcriturePointee:TStringList;
//dateDebEnCours,dateFinEnCours:Tdate;
//i,j,k,l,num,idEcriture,idPieceOld:integer;
//ReqEcritureControlFiscal,RequeteBalance:TQuery;
//tableUpdate,tableLecture:TTable;
//DirExoBalance,codeExo,ligneControl:string;
////ParamLibChoixRepAffiche:TParamLibChoixRepAffiche;
////ResultChoixRep:TResultChoixRep;
//Begin
//try
// try
//   DecimalSeparator:=',';
//  if DMExport = nil then DMExport:=TDMExport.Create(Application.MainForm);
//  if(DMDiocEtatBal=nil)then DMDiocEtatBal:=TDMDiocEtatBal.Create(Application.MainForm);
//  if(DMDiocEtatBalT=nil)then DMDiocEtatBalT:=TDMDiocEtatBalT.Create(Application.MainForm);
//
//
//
////  repertoireFichier:=IncludeTrailingPathDelimiter(E.RepertoireExportDossier)+'controleFiscal';
//  repertoireFichier:=IncludeTrailingPathDelimiter(E.RepertoireExportDossier)+'';
//  if SelectDirectory(repertoireFichier,[sdAllowCreate, sdPerformCreate, sdPrompt],0 )=false then abort;
//
////ParamLibChoixRepAffiche.AfficheRepDefDansEdit := true;
////ParamLibChoixRepAffiche.RepDefaut := IncludeTrailingPathDelimiter(E.RepertoireExportDossier)+'controleFiscal';
////ParamLibChoixRepAffiche.TitreForm := 'Exportation des �critures pour la p�riode du '+DateToStr_Lgr(debControl)+' au '+DateToStr_Lgr(finControl);
////ParamLibChoixRepAffiche.TitreDialogRep := 'Choix du r�pertoire de l''exportation.';
////ResultChoixRep:=LibChoixRepAffiche(ParamLibChoixRepAffiche);
////if(ResultChoixRep.Retour=false) then abort;
//
//  Affichage:=true;
//  tableUpdate:=TTable.Create(DMExport);
//  tableLecture:=TTable.Create(DMExport);
//  listeEcriture:=TStringList.Create;
//  listeExo:=TStringList.Create;
//  listeTemp:=TStringList.create;
//  listeEcriturePointee:=TStringList.Create;
//  listeEcriturePointee.Duplicates:=dupIgnore;
//  ReqEcritureControlFiscal:=TQuery.Create(DMExport);
//  RequeteBalance:=TQuery.Create(DMExport);
//
//
//
//
//  num:=0;
//  idPieceOld:=0;
//  CoherenceBalance(nil);
//
//    // d�coupage de la p�riode totale en p�riode cl�tur�e
//                  DMExport.ReqControl.close;
//                  DMExport.ReqControl.SQL.Clear;
//                  DMExport.ReqControl.DatabaseName := DM_C_NomAliasProgram;
//                  DMExport.ReqControl.SQL.Add('select nom_exo,Date_deb_exo,date_fin_exo,cloture,exo_saisie,dir_exo from GestDossier where nom_dossier='''+E.NomDossier+''' and ');
//
//                  DMExport.ReqControl.SQL.Add(' ((cast(Date_deb_exo as date)>= cast(:deb as date) or cast(date_fin_exo as date)>=cast(:deb as date)) '+
//                  ' and(cast(Date_deb_exo as date)<= cast(:fin as date) or cast(date_fin_exo as date)<=cast(:fin as date))) ');
//
////                  DMExport.ReqControl.SQL.Add(' ((cast(Date_deb_exo as date)<= cast(:deb as date) and cast(date_fin_exo as date)>=cast(:deb as date)) '+
////                  ' or(cast(Date_deb_exo as date)<= cast(:fin as date) and cast(date_fin_exo as date)>=cast(:fin as date))) ');
//
//
//
//                  DMExport.ReqControl.ParamByName('deb').AsDate:=debControl;
//                  DMExport.ReqControl.ParamByName('fin').AsDate:=finControl;
//
//                  DMExport.ReqControl.Open;
//                  listeExo:=ChampTableVersListeEx(DMExport.ReqControl,';',false,false);
//   //S�l�ction de toutes les �critures de la p�riode en cours
//   for i:=0 to listeExo.Count-1 do
//   begin
//      dateDebEnCours:=StrToDate_Lgr(str_getstringelement(listeExo[i],2,';'));
//      dateFinEnCours:=StrToDate_Lgr(str_getstringelement(listeExo[i],3,';'));
//      DirExoBalance:=str_getstringelement(listeExo[i],6,';');
//      codeExo:=str_getstringelement(listeExo[i],5,';');
//      if(CompareDate(debControl,dateDebEnCours)<0)then dateDebEnCours:=debControl;
//      if(CompareDate(finControl,dateFinEnCours)>0)then dateFinEnCours:=finControl;
//      DecodeDate(dateFinEnCours,annee,mois,jour);
//      datefin.AnStr:=IntToStr(annee);
//      datefin.MoisStr:=IntToStr(mois);
//      datefin.JourStr:=IntToStr(jour);
//      while(length(datefin.AnStr)<4)do datefin.AnStr:='20'+datefin.AnStr;
//      while(length(datefin.MoisStr)<2)do datefin.MoisStr:='0'+datefin.MoisStr;
//      while(length(datefin.JourStr)<2)do datefin.JourStr:='0'+datefin.JourStr;
//      datefin.DateStrFormat:=datefin.AnStr+datefin.MoisStr+datefin.JourStr;
//
////cr�ation d'une table temporaire
//  if  FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'EcritureControleFiscal.db') then
//     DeleteFile(Pchar(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'EcritureControleFiscal.db'));
//
//  if  FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'EcritureLettreTemp.db') then
//      DeleteFile(Pchar(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'EcritureLettreTemp.db'));
//
//    DMExport.ReqControl.close;
//    DMExport.ReqControl.SQL.Clear;
//    DMExport.ReqControl.DatabaseName:=DM_C_NomAliasDossier;
//    DMExport.ReqControl.sql.Add(' create table EcritureControleFiscal (idEcriture integer,JournalCode varchar(2), ');
//    DMExport.ReqControl.sql.Add(' JournalLib varchar(100),EcritureNum varchar(25),EcritureDate date,compteNum varchar(8),');
//    DMExport.ReqControl.sql.Add(' CompteLib varchar(100),CompAuxNum varchar(8),CompAuxLib varchar(100),PieceRef varchar(9),');
//    DMExport.ReqControl.sql.Add(' PieceDate date,EcritureLib varchar(100),');
//    DMExport.ReqControl.sql.Add(' Debit float,Credit float,EcritureLet varchar(25),DateLet date,validDate date,Montantdevise float,idevise varchar(2),traite boolean,id_ligne integer ');
//    DMExport.ReqControl.sql.Add(' ,PRIMARY KEY (idEcriture))');
//    DMExport.ReqControl.ExecSQL;
//
//    DMExport.ReqControl.close;
//    DMExport.ReqControl.SQL.Clear;
//    DMExport.ReqControl.sql.Add(' create table EcritureLettreTemp (idEcriture integer, lettre varchar(25),debit float,credit float,dateLettrage date,traite boolean,PRIMARY KEY (idEcriture))');
//    DMExport.ReqControl.ExecSQL;
//
//    DMExport.ReqControl.close;
//    DMExport.ReqControl.SQL.Clear;
//    DMExport.ReqControl.sql.Add(' create table PointagePeriodeTemp (idEcriture integer, lettre varchar(25),debit float,credit float,dateLettrage date,traite boolean,PRIMARY KEY (idEcriture))');
//    DMExport.ReqControl.ExecSQL;
//
//
////  DMExport.SaveDialog1.DefaultExt:='csv';
////  DMExport.SaveDialog1.FileName := siren+constNomFichier+datefin.DateStrFormat+'.csv';
////  DMExport.SaveDialog1.InitialDir := E.RepertoireExportDossier;
////
////  DMExport.SaveDialog1.Title := 'Exportation des �critures pour la p�riode du '+DateToStr_Lgr(deb)+' au '+DateToStr_Lgr(fin);
////  if DMExport.SaveDialog1.Execute then CheminFichier:= DMExport.SaveDialog1.FileName
//
//  CheminFichier:= IncludeTrailingPathDelimiter(repertoireFichier)+siren+constNomFichier+datefin.DateStrFormat+'.csv';
//  if FileExists(CheminFichier) then
//   DeleteFile(PChar(CheminFichier));
//      //cr�ation d'une pi�ce fictive reprenant tous les reports des comptes de 1 � 599 de la balance
////      if ListeCompte = nil then ListeCompte:=ChampTableVersListe('Compte',DMDiocEtatBal.TaBalanceCalc);
////      DMDiocEtatBal.ListeFiltreEdit.Assign(ListeCompte);
//         RequeteBalance.close;
//         RequeteBalance.SQL.Clear;
////         RequeteBalance.Filtered := true;
////         RequeteBalance.OnFilterRecord:=DMDiocEtatBal.TaBalanceCalcFilterRecord;
//         RequeteBalance.DatabaseName:=DM_C_NomAliasDossier;
//
//         RequeteBalance.SQL.Add('select p.libelle,P.compte,bt.tiers,t.nom, (b.Debit_Report)as Debit_Report_bal,(b.Credit_Report)as Credit_Report_bal, (bt.Debit_Report)as Debit_Report_balT,(bt.Credit_Report)as Credit_Report_balT ');
//         RequeteBalance.SQL.Add(' from plancpt P');
//         RequeteBalance.SQL.Add(' join  "'+IncludeTrailingPathDelimiter(DirExoBalance)+'balance" b on p.compte=b.compte');
//         RequeteBalance.SQL.Add(' left join  "'+IncludeTrailingPathDelimiter(DirExoBalance)+'balanceTiers" bt on b.compte=bt.compte');
//         RequeteBalance.SQL.Add(' left join  Tiers t on bt.tiers=t.tiers');
//         RequeteBalance.SQL.Add(' where cast(p.compte as integer) between 1 and 599999999 and ( ((b.Debit_Report<>0 or b.Credit_Report<>0)and bt.tiers is null )');
//         RequeteBalance.SQL.Add('  or ( (bt.Debit_Report<>0 or bt.Credit_Report<>0)) )');
//         RequeteBalance.SQL.Add(' order by P.compte,bt.tiers');
//         RequeteBalance.Open;
//         RequeteBalance.First;
//      k:=0;
//      idEcriture:=1;
//      num:=1;
//           DMExport.TableControlFiscal.TableName:='EcritureControleFiscal.db';
//           TableGereStartTransaction(DMExport.TableControlFiscal);
//           TableGereOpen(DMExport.TableControlFiscal);
//
//      while not RequeteBalance.Eof do
//      begin
//
//           TableGereInsert(DMExport.TableControlFiscal);
//           DMExport.TableControlFiscal.FindField('JournalCode').AsString:='AN';
//           DMExport.TableControlFiscal.FindField('JournalLib').AsString:='A Nouveaux';
//           DMExport.TableControlFiscal.FindField('idEcriture').AsInteger:=idEcriture;
//           DMExport.TableControlFiscal.FindField('EcritureNum').AsInteger:=num;
//           DMExport.TableControlFiscal.FindField('compteNum').AsString:=RequeteBalance.findfield('compte').AsString;
//           DMExport.TableControlFiscal.FindField('CompteLib').AsString:=RequeteBalance.findfield('Libelle').AsString;
//           DMExport.TableControlFiscal.FindField('CompAuxNum').AsString:=RequeteBalance.findfield('tiers').AsString;
//           DMExport.TableControlFiscal.FindField('CompAuxLib').AsString:=RequeteBalance.findfield('nom').AsString;
//           DMExport.TableControlFiscal.FindField('PieceRef').AsString:='AN'+codeExo+'00000';
//           DMExport.TableControlFiscal.FindField('EcritureLib').AsString:='A.N au '+str_getstringelement(listeExo[i],2,';');
//           DMExport.TableControlFiscal.FindField('PieceDate').AsDateTime:=dateDebEnCours;
//           DMExport.TableControlFiscal.FindField('EcritureDate').AsDateTime:=dateDebEnCours;
//           if(RequeteBalance.findfield('tiers').AsString<>'')then
//           begin
//             DMExport.TableControlFiscal.FindField('Debit').AsCurrency:=RequeteBalance.findfield('Debit_Report_balT').AsCurrency;
//             DMExport.TableControlFiscal.FindField('Credit').AsCurrency:=RequeteBalance.findfield('Credit_Report_balT').AsCurrency;
//           end
//           else
//           begin
//             DMExport.TableControlFiscal.FindField('Debit').AsCurrency:=RequeteBalance.findfield('Debit_Report_bal').AsCurrency;
//             DMExport.TableControlFiscal.FindField('Credit').AsCurrency:=RequeteBalance.findfield('Credit_Report_bal').AsCurrency;
//           end;
//          DMExport.TableControlFiscal.FindField('traite').AsBoolean:=true;
//           DMExport.TableControlFiscal.FindField('ValidDate').AsDateTime:=dateDebEnCours;
//
//
//           TableGerePost(DMExport.TableControlFiscal);
//           if(k=50)then
//             begin
//               TableGereCommit(DMExport.TableControlFiscal);
//               TableGereStartTransaction(DMExport.TableControlFiscal);
//               k:=0;
//             end;
//          RequeteBalance.Next;
//          inc(k);
//          inc(idEcriture);
//      end;
//       TableGereCommit(DMExport.TableControlFiscal);
//
//      DMExport.ReqControl.close;
//      DMExport.ReqControl.SQL.Clear;
//      DMExport.ReqControl.DatabaseName := DM_C_NomAliasDossier;
//
//      DMExport.ReqControl.SQL.Add(' select (substring(cast(p.reference as char(9)) from 1 for 2)) as JournalCode,m.libelle_model as JournalLib, ');
//      DMExport.ReqControl.SQL.Add(' e.id as idEcriture,p.id as idPiece,p."Quand" as EcritureDate,e.compte AS compteNum ');
//      DMExport.ReqControl.SQL.Add(' ,pl.libelle AS CompteLib,e.tiers AS CompAuxNum,t.nom as CompAuxLib, ');
//      DMExport.ReqControl.SQL.Add(' p.reference AS PieceRef,p."date" AS PieceDate,e.libelle AS EcritureLib,e.debit AS Debit,e.credit AS Credit,e.typeLigne,e.id_ligne ');
//      DMExport.ReqControl.SQL.Add(' from piece p ');
//      DMExport.ReqControl.SQL.Add(' join ecriture e on(e.id_piece=p.id) ');
//      DMExport.ReqControl.SQL.Add(' left join plancpt pl on (pl.compte=e.compte) ');
//      DMExport.ReqControl.SQL.Add(' left join tiers t on t.tiers=e.tiers ');
//      DMExport.ReqControl.SQL.Add(' join model m on m.journal=substring(cast(p.reference as char(9)) from 1 for 2) ');
//      DMExport.ReqControl.SQL.Add(' where p."date" between :deb and :fin ');
////      DMExport.ReqControl.SQL.Add(' and p.reference=''AC0''');
////      DMExport.ReqControl.SQL.Add(' and (p.reference=''AC1100015'' or p.reference=''AC1100016'' or p.reference=''AC1100017'' or p.reference=''AC1100024'' ');
////      DMExport.ReqControl.SQL.Add(' or p.reference=''AC1100054'' or p.reference=''AC1100097'' or p.reference=''AC1100055'' or p.reference=''AC1100046'' or p.reference=''AC1100068'' or p.reference=''OD1100010'')');        // )
//      DMExport.ReqControl.SQL.Add(' order by p."Quand",e.typeLigne,e.id');
//
//      DMExport.ReqControl.ParamByName('deb').AsDate:=dateDebEnCours;
//      DMExport.ReqControl.ParamByName('fin').AsDate:=dateFinEnCours;
//
//      DMExport.ReqControl.Open;
//      DMExport.ReqControl.first;
//      k:=0;
//
//      while not DMExport.ReqControl.Eof do
//      begin
//          if(DMExport.ReqControl.findfield('idPiece').AsInteger<>idPieceOld)then
//           inc(num);
//           DMExport.TableControlFiscal.TableName:='EcritureControleFiscal.db';
//           TableGereStartTransaction(DMExport.TableControlFiscal);
//           TableGereOpen(DMExport.TableControlFiscal);
//           TableGereInsert(DMExport.TableControlFiscal);
//           DMExport.TableControlFiscal.FindField('JournalCode').AsString:=DMExport.ReqControl.findfield('JournalCode').AsString;
//           DMExport.TableControlFiscal.FindField('JournalLib').AsString:=DMExport.ReqControl.findfield('JournalLib').AsString;
//           DMExport.TableControlFiscal.FindField('idEcriture').AsInteger:=DMExport.ReqControl.findfield('idEcriture').AsInteger;
//           DMExport.TableControlFiscal.FindField('EcritureNum').AsInteger:=num;
//           DMExport.TableControlFiscal.FindField('compteNum').AsString:=DMExport.ReqControl.findfield('compteNum').AsString;
//           DMExport.TableControlFiscal.FindField('CompteLib').AsString:=DMExport.ReqControl.findfield('CompteLib').AsString;
//           DMExport.TableControlFiscal.FindField('CompAuxNum').AsString:=DMExport.ReqControl.findfield('CompAuxNum').AsString;
//           DMExport.TableControlFiscal.FindField('CompAuxLib').AsString:=DMExport.ReqControl.findfield('CompAuxLib').AsString;
//           DMExport.TableControlFiscal.FindField('PieceRef').AsString:=DMExport.ReqControl.findfield('PieceRef').AsString;
//           DMExport.TableControlFiscal.FindField('EcritureLib').AsString:=DMExport.ReqControl.findfield('EcritureLib').AsString;
//           DMExport.TableControlFiscal.FindField('PieceDate').AsDateTime:=DMExport.ReqControl.findfield('PieceDate').AsDateTime;
//           DMExport.TableControlFiscal.FindField('EcritureDate').AsDateTime:=DMExport.ReqControl.findfield('EcritureDate').AsDateTime;
//           DMExport.TableControlFiscal.FindField('Debit').AsCurrency:=DMExport.ReqControl.findfield('Debit').AsCurrency;
//           DMExport.TableControlFiscal.FindField('Credit').AsCurrency:=DMExport.ReqControl.findfield('Credit').AsCurrency;
//           DMExport.TableControlFiscal.FindField('traite').AsBoolean:=false;
//           DMExport.TableControlFiscal.FindField('ValidDate').AsDateTime:=DMExport.ReqControl.findfield('EcritureDate').AsDateTime;
//           DMExport.TableControlFiscal.FindField('id_ligne').AsInteger:=DMExport.ReqControl.findfield('id_ligne').AsInteger;
//
//           idPieceOld:=DMExport.ReqControl.findfield('idPiece').AsInteger;
//           TableGerePost(DMExport.TableControlFiscal);
//           if(k=50)then
//             begin
//               TableGereCommit(DMExport.TableControlFiscal);
//               k:=0;
//             end;
//          DMExport.ReqControl.Next;
//          inc(k);
//
//      end;
//       TableGereCommit(DMExport.TableControlFiscal);
//
//      //r�cup�rer les pointages pour chaque ligne de la table
//       ReqEcritureControlFiscal.close;
//      ReqEcritureControlFiscal.sql.Clear;
//      ReqEcritureControlFiscal.DatabaseName:=DM_C_NomAliasDossier;
//      ReqEcritureControlFiscal.SQL.add(' select ecf.idEcriture,ecf.debit,ecf.credit,p.quand,ecf.EcritureLet from pointage p join EcritureControleFiscal ecf on ecf.idEcriture=p.id_debit ');
//      ReqEcritureControlFiscal.SQL.add(' or ecf.idEcriture=p.id_credit where cast("p.date" as date) <=cast(:fin as date) and cast("p.tvaDate" as date) <=cast(:fin as date)   and ecf.traite=false');
//      ReqEcritureControlFiscal.ParamByName('fin').AsDateTime:=dateFinEnCours;
////      ReqEcritureControlFiscal.ParamByName('fin2').AsDateTime:=fin;
////      ReqEcritureControlFiscal.Filtered:=true;
////      ReqEcritureControlFiscal.Filter:='EcritureLet = ''''';
//      ReqEcritureControlFiscal.Open;
//       ReqEcritureControlFiscal.First;
//      num:=1;
//      while (not ReqEcritureControlFiscal.eof)do
//      begin
//
//        DMExport.ReqEcriture.Close;
//        DMExport.ReqEcriture.DatabaseName:=DM_C_NomAliasDossier;
//        DMExport.ReqEcriture.SQL.Clear;
//        DMExport.ReqEcriture.SQL.Add(' select ecf.EcritureLet from EcritureControleFiscal ecf where idEcriture='''+ReqEcritureControlFiscal.findfield('idEcriture').AsString+'''');
//        DMExport.ReqEcriture.open;
//        DMExport.ReqEcriture.first;
//        if(DMExport.ReqEcriture.recordcount>0)then
//          if(DMExport.ReqEcriture.findfield('EcritureLet').AsString='')then
//          begin
//          listeEcriture:=recuperePointagesLies_A_EcritureControlFiscal(ReqEcritureControlFiscal.findfield('idEcriture').AsInteger,ReqEcritureControlFiscal.findfield('debit').AsCurrency,
//          ReqEcritureControlFiscal.findfield('credit').AsCurrency);
//          if(listeEcriture.count<>0)then
//               enregistreLettrage(ReqEcritureControlFiscal.findfield('idEcriture').AsInteger,IntToStr_Lgr(num),ReqEcritureControlFiscal.findfield('debit').AsCurrency,
//                   ReqEcritureControlFiscal.findfield('credit').AsCurrency,ReqEcritureControlFiscal.findfield('quand').AsDateTime,true);
//
//          DMExport.TableControlFiscal.close;
//          DMExport.TableControlFiscal.TableName:='EcritureLettreTemp.db';
//          TableGereStartTransaction(DMExport.TableControlFiscal);
//
//          tableLecture.DatabaseName:=DM_C_NomAliasDossier;
//          tableLecture.TableName:='EcritureLettreTemp.db';
//          tableLecture.Filtered:=true;
//          tableLecture.Filter:=' traite=faux or traite = null ';
//          TableGereOpen(tableLecture);
//          tableLecture.First;
//
//          while(not tableLecture.eof)or((listeEcriture<>nil)and(listeEcriture.count>0))do
//              begin
//                  if(listeEcriture<>nil)and (listeEcriture.Count<>0)then
//                     enregistreListeLettrage(listeEcriture,num)
//                  else
//
//                  tableLecture.Refresh;
//                  tableLecture.first;
//
//
//                  listeEcriture.Clear;
//                  listeEcriture:=recuperePointagesLies_A_EcritureControlFiscal(tableLecture.findfield('idEcriture').AsInteger,tableLecture.findfield('debit').AsCurrency,
//                  tableLecture.findfield('credit').AsCurrency);
//                  LettrageTraitee(tableLecture.findfield('idEcriture').AsInteger);
//              end;//fin while not tableLecture.eof
//              TableGereCommit(DMExport.TableControlFiscal);
//          inc(num);
//
////          DMExport.UpdateControlFiscal.Close;
//
//            tableUpdate.Close;
//            tableUpdate.DatabaseName:=DM_C_NomAliasDossier;
//             tableUpdate.tableName:='EcritureControleFiscal';
//            TableGereOpen(tableUpdate);
//            tableUpdate.FlushBuffers;
//            TableGereStartTransaction(tableUpdate);
//
//          DMExport.ReqControl.sql.Clear;
//          DMExport.ReqControl.sql.Add('select idEcriture,lettre,max(dateLettrage) as dateLettrage from EcritureLettreTemp group by idEcriture,lettre');
//          DMExport.ReqControl.open();
//          DMExport.ReqControl.First;
//          while (not DMExport.ReqControl.eof)do
//          begin
////            if(FiltrageDataSet(tableUpdate,'idEcriture='+DMExport.ReqControl.findfield('idEcriture').AsString))then
//            DeFiltrageDataSet(tableUpdate);
//            if(tableUpdate.Locate('idEcriture',DMExport.ReqControl.findfield('idEcriture').AsString,[]))then
//            begin
//              TableGereEdit(tableUpdate);
//              tableUpdate.FindField('EcritureLet').AsString:=DMExport.ReqControl.findfield('lettre').AsString;
//              tableUpdate.FindField('DateLet').AsDateTime:=DMExport.ReqControl.findfield('dateLettrage').AsDateTime;
//              TableGerePost(tableUpdate);
//            end;
//            DMExport.ReqControl.next;
//          end;
//           TableGereCommit(tableUpdate);
//          tableUpdate.FlushBuffers;
//          DMExport.ReqControl.sql.Clear;
//          DMExport.ReqControl.sql.Add(' delete  from EcritureLettreTemp');
//          DMExport.ReqControl.Prepare;
//          DMExport.ReqControl.ExecSQL();
//          end;
//          ReqEcritureControlFiscal.next;
//      end;
//
//      ReqEcritureControlFiscal.Close;
//      ReqEcritureControlFiscal.SQL.Clear;
//
////      'JournalCode,JournalLib,EcritureNum,EcritureDate,compteNum,CompteLib,CompAuxNum,CompAuxLib,PieceRef,PieceDate,EcritureLib,debit,credit,EcritureLet'+
////      ',DateLet,validDate,MontantDevise,iDevise
//
//      ReqEcritureControlFiscal.SQL.Add('select * from EcritureControleFiscal order by EcritureDate,EcritureNum,id_ligne');
//      ReqEcritureControlFiscal.open;
//
////      DMExport.TableControlFiscal.close;
////      DMExport.TableControlFiscal.TableName:='EcritureControleFiscal';
////      DeFiltrageDataSet(DMExport.TableControlFiscal);
////      TableGereOpen(DMExport.TableControlFiscal);
//      listeEcriturePointee.Clear;
//
//      ChampTableVersVarListeEx(['JournalCode','JournalLib','EcritureNum','EcritureDate','CompteNum','CompteLib','CompAuxNum','CompAuxLib','PieceRef','PieceDate',
//      'EcritureLib','Debit','Credit','EcritureLet','DateLet','ValidDate','MontantDevise','IDevise'],ReqEcritureControlFiscal,listeEcriturePointee,'|',false,true);
//
//      for l:=1 to  listeEcriturePointee.count-1 do
//      begin
//          ligneControl:=listeEcriturePointee.Strings[l];
//          //EcritureDate
//          dateTmp.Date_:=StrToDate1(GetStringElement(ligneControl,4,'|'));
//          if(dateTmp.Date_<>0)then
//            begin
//                DecodeDate(dateTmp.Date_,annee,mois,jour);
//                dateTmp.AnStr:=IntToStr(annee);
//                dateTmp.MoisStr:=IntToStr(mois);
//                dateTmp.JourStr:=IntToStr(jour);
//                while(length(dateTmp.AnStr)<4)do dateTmp.AnStr:='20'+dateTmp.AnStr;
//                while(length(dateTmp.MoisStr)<2)do dateTmp.MoisStr:='0'+dateTmp.MoisStr;
//                while(length(dateTmp.JourStr)<2)do dateTmp.JourStr:='0'+dateTmp.JourStr;
//                dateTmp.DateStrFormat:=dateTmp.AnStr+dateTmp.MoisStr+dateTmp.JourStr;
//                ligneControl:=str_Setstringelement(ligneControl,4,'|',dateTmp.DateStrFormat);
//            end;
//          //PieceDate
//          dateTmp.Date_:=StrToDate1(GetStringElement(ligneControl,10,'|'));
//           if(dateTmp.Date_<>0)then
//            begin
//               DecodeDate(dateTmp.Date_,annee,mois,jour);
//                dateTmp.AnStr:=IntToStr(annee);
//                dateTmp.MoisStr:=IntToStr(mois);
//                dateTmp.JourStr:=IntToStr(jour);
//                while(length(dateTmp.AnStr)<4)do dateTmp.AnStr:='20'+dateTmp.AnStr;
//                while(length(dateTmp.MoisStr)<2)do dateTmp.MoisStr:='0'+dateTmp.MoisStr;
//                while(length(dateTmp.JourStr)<2)do dateTmp.JourStr:='0'+dateTmp.JourStr;
//                dateTmp.DateStrFormat:=dateTmp.AnStr+dateTmp.MoisStr+dateTmp.JourStr;
//                ligneControl:=str_Setstringelement(ligneControl,10,'|',dateTmp.DateStrFormat);
//            end;
//
//          //DateLet
//          dateTmp.Date_:=StrToDate1(GetStringElement(ligneControl,15,'|'));
//          if(dateTmp.Date_<>0)then
//            begin
//                DecodeDate(dateTmp.Date_,annee,mois,jour);
//                dateTmp.AnStr:=IntToStr(annee);
//                dateTmp.MoisStr:=IntToStr(mois);
//                dateTmp.JourStr:=IntToStr(jour);
//                while(length(dateTmp.AnStr)<4)do dateTmp.AnStr:='20'+dateTmp.AnStr;
//                while(length(dateTmp.MoisStr)<2)do dateTmp.MoisStr:='0'+dateTmp.MoisStr;
//                while(length(dateTmp.JourStr)<2)do dateTmp.JourStr:='0'+dateTmp.JourStr;
//                dateTmp.DateStrFormat:=dateTmp.AnStr+dateTmp.MoisStr+dateTmp.JourStr;
//                ligneControl:=str_Setstringelement(ligneControl,15,'|',dateTmp.DateStrFormat);
//            end;
//          //validDate
//          dateTmp.Date_:=StrToDate1(GetStringElement(ligneControl,16,'|'));
//          if(dateTmp.Date_<>0)then
//            begin
//                DecodeDate(dateTmp.Date_,annee,mois,jour);
//                dateTmp.AnStr:=IntToStr(annee);
//                dateTmp.MoisStr:=IntToStr(mois);
//                dateTmp.JourStr:=IntToStr(jour);
//                while(length(dateTmp.AnStr)<4)do dateTmp.AnStr:='20'+dateTmp.AnStr;
//                while(length(dateTmp.MoisStr)<2)do dateTmp.MoisStr:='0'+dateTmp.MoisStr;
//                while(length(dateTmp.JourStr)<2)do dateTmp.JourStr:='0'+dateTmp.JourStr;
//                dateTmp.DateStrFormat:=dateTmp.AnStr+dateTmp.MoisStr+dateTmp.JourStr;
//                ligneControl:=str_Setstringelement(ligneControl,16,'|',dateTmp.DateStrFormat);
//            end;
//          listeEcriturePointee.Strings[l]:=ligneControl;
//      end;
//      listeEcriturePointee.SaveToFile(CheminFichier);
//      listeEcriturePointee.Clear;
//      tableUpdate.Close;
//      tableLecture.close;
//      DMExport.TableControlFiscal.Close;
//      RequeteBalance.close;
//      ReqEcritureControlFiscal.Close;
//      DMExport.Requete.Close;
//      DMExport.ReqControl.Close;
//      DMExport.ReqPointage.Close;
//      DMExport.ReqEcriture.Close;
//  end;
//
// except
// TableGereRollBack(DMExport.TableControlFiscal);
// TableGereRollBack(DMExport.TableControlFiscal);
// ReqEcritureControlFiscal.Close;
// DMExport.ReqControl.Close;
// DMExport.ReqPointage.Close;
//  Affichage:=False;
//  Showmessage('Erreur lors de l''exportation de la balance !');
//  abort;
// end;
//finally
//  DecimalSeparator:='.';
//tableUpdate.Close;
//tableLecture.close;
//Initialise_TStringlist(listeEcriture);
//Initialise_TStringlist(listeExo);
//Initialise_TStringlist(listeTemp);
//Initialise_TStringlist(listeEcriturePointee);
//      tableUpdate.Close;
//      tableLecture.close;
//      DMExport.TableControlFiscal.Close;
//      RequeteBalance.close;
//      ReqEcritureControlFiscal.Close;
//      DMExport.Requete.Close;
//      DMExport.ReqControl.Close;
//      DMExport.ReqPointage.Close;
//      DMExport.ReqEcriture.Close;
//
// if Affichage then
//  begin
//   Showmessage('Fin de l''exportation des �critures pour le contr�le fiscal !');
//
////   if AnsiCompareFileName(ExcludeTrailingPathDelimiter(E.RepertoireExportBalance),ExcludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName)))<>0 then
////    begin
////     if MessageDlg('Le r�pertoire par d�faut d''exportation de la balance � chang�.'+
////                    RetourChariotDouble+
////                    'Ancien : '+
////                    RetourChariotDouble+
////                    ExcludeTrailingPathDelimiter(E.RepertoireExportBalance)+
////                    RetourChariotDouble+
////                    'Nouveau : '+
////                    RetourChariotDouble+
////                    ExcludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName))+
////                    RetourChariotDouble+
////                    'Voulez-Vous conserver ce changement ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
////             E.RepertoireExportBalance:=IncludeTrailingPathDelimiter(ExtractFileDir(DMExport.SaveDialog1.FileName));
////    end;
//  end;
//end;
//end;

procedure enregistreLettrage(idEcriture:integer;lettre:string;debit,credit:currency;datelettrage:Tdate; commit:boolean);
begin
try//finally
  try//except
    TableGereClose(DMExport.TableEcritureLettreTemp);
    DMExport.TableEcritureLettreTemp.TableName:='EcritureLettreTemp';
    TableGereOpen(DMExport.TableEcritureLettreTemp);
    if(commit)then TableGereStartTransaction(DMExport.TableEcritureLettreTemp);
    TableGereInsert(DMExport.TableEcritureLettreTemp);
    DMExport.TableEcritureLettreTemp.FindField('idEcriture').AsInteger:=idEcriture;
    DMExport.TableEcritureLettreTemp.FindField('lettre').AsString:=lettre;
    DMExport.TableEcritureLettreTemp.FindField('debit').AsCurrency:=debit;
    DMExport.TableEcritureLettreTemp.FindField('credit').AsCurrency:=credit;
    DMExport.TableEcritureLettreTemp.FindField('dateLettrage').AsDateTime:=datelettrage;
    TableGerePost(DMExport.TableEcritureLettreTemp);
  except
     TableGereRollBack(DMExport.TableEcritureLettreTemp);
  end;
finally
  if(commit)then TableGereCommit(DMExport.TableEcritureLettreTemp);
  DMExport.TableEcritureLettreTemp.Close;
end;
end;



//procedure LettrageTraitee(idEcriture:integer; commit:boolean);
//begin
//try//finally
//  try//except
//    if(idEcriture<>0)then
//      begin
//        TableGereClose(DMExport.TableEcritureLettreTemp);
//        DMExport.TableControlFiscal.TableName:='EcritureLettreTemp';
//        FiltrageDataSet(DMExport.TableEcritureLettreTemp,' traite=faux or traite = null ');
//        TableGereOpen(DMExport.TableEcritureLettreTemp);
//        if(commit)then TableGereStartTransaction(DMExport.TableEcritureLettreTemp);
//        while (DMExport.TableEcritureLettreTemp.Locate('idEcriture',IntToStr_Lgr(idEcriture),[])) do
//          begin
//            TableGereEdit(DMExport.TableEcritureLettreTemp);
//            DMExport.TableEcritureLettreTemp.FindField('traite').AsBoolean:=true;
//            TableGerePost(DMExport.TableEcritureLettreTemp);
//          end;
//      end;
//  except
//     TableGereRollBack(DMExport.TableEcritureLettreTemp);
//  end;
//finally
//  if(commit)then TableGereCommit(DMExport.TableEcritureLettreTemp);
//  DMExport.TableEcritureLettreTemp.Close;
//  DeFiltrageDataSet(DMExport.TableEcritureLettreTemp);
//end;
//end;
procedure LettrageTraitee(idEcriture:integer);
//var
//Req:Tquery;
begin
try//finally
  try//except
//    req:=TQuery.Create(DMExport);
    DMExport.ReqEcriture2.close;
    DMExport.ReqEcriture.DatabaseName:=DM_C_NomAliasDossier;
    DMExport.ReqEcriture2.SQL.Clear;
    if(idEcriture<>0)then
    begin
//      DMExport.ReqEcriture2.SQL.add(' update EcritureLettreTemp set traite=true  where idEcriture ='+IntToStr_Lgr(idEcriture) +' and (traite=null or traite=false)');
      DMExport.ReqEcriture2.SQL.add(' update EcritureLettreTemp set traite=true  where idEcriture ='+IntToStr_Lgr(idEcriture));
      DMExport.ReqEcriture2.ExecSQL;
    end;
    DMExport.ReqEcriture2.close;
  except
     //showmessage('id ecriture '+IntToStr_Lgr(idEcriture));
  end;
finally
  DMExport.ReqEcriture2.close;
//  req:=nil;
end;
end;

//procedure enregistreListeLettrage(ListeEcriture:Tstringlist;num:integer);
//var
//j:integer;
//begin
//  for j:=0 to  ListeEcriture.Count-1 do
//    begin
//        DMExport.ReqEcriture.Close;
//        DMExport.ReqEcriture.DatabaseName:=DM_C_NomAliasDossier;
//        DMExport.ReqEcriture.SQL.Clear;
//        DMExport.ReqEcriture.SQL.Add(' select * from ecriture where id='+str_getstringelement(listeEcriture.Strings[j],1,';'));
//        DMExport.ReqEcriture.open;
//        DMExport.ReqEcriture.first;
//        if(DMExport.ReqEcriture.RecordCount>0)then
//        enregistreLettrage(StrToInt_Lgr(str_getstringelement(listeEcriture.Strings[j],1,';')),IntToStr_Lgr(num),DMExport.ReqEcriture.findfield('debit').AsCurrency,
//           DMExport.ReqEcriture.findfield('credit').AsCurrency,StrToDate_Lgr(str_getstringelement(listeEcriture.Strings[j],2,';')),true);
//    end;
//end;


procedure enregistreListeLettrage(ListeEcriture:Tstringlist;num:integer);
var
j:integer;
begin
  for j:=0 to  ListeEcriture.Count-1 do
    begin
        DMExport.ReqEcriture.Close;
        DMExport.ReqEcriture.DatabaseName:=DM_C_NomAliasDossier;
        DMExport.ReqEcriture.SQL.Clear;
        DMExport.ReqEcriture.SQL.Add(' select * from ecriture where id='+str_getstringelement(listeEcriture.Strings[j],1,';'));
        DMExport.ReqEcriture.open;
        DMExport.ReqEcriture.first;

        enregistreLettrage(StrToInt_Lgr(str_getstringelement(listeEcriture.Strings[j],1,';')),IntToStr_Lgr(num),DMExport.ReqEcriture.findfield('debit').AsCurrency,
           DMExport.ReqEcriture.findfield('credit').AsCurrency,StrToDate_Lgr(str_getstringelement(listeEcriture.Strings[j],2,';')),true); 
    end;
end;

//function recuperePointagesLies_A_EcritureControlFiscal(idEcriture : integer ;debit,credit:currency):Tstringlist;
//var
//Req:TQuery;
//begin
// try//finally
// req:=TQuery.Create(DMExport);
// req.DatabaseName:=DM_C_NomAliasDossier;
// if(idEcriture<>0)then
//     begin
//         if(debit<>0)then
//           begin
//             req.SQL.Add(' select id_credit,cast(p.quand as date) from pointage p join EcritureControleFiscal ecf on ecf.idEcriture=p.id_debit');
//             Req.SQL.add('  where ecf.idEcriture='+IntToStr_Lgr(idEcriture) +' and p.id_credit not in(select idEcriture from EcritureLettreTemp) ');
//             Req.SQL.add('  and p.id_credit not in(select idEcriture from EcritureControleFiscal where ecritureLet<>'''')');
//           end
//         else
//           begin
//             req.SQL.Add(' select id_debit,cast(p.quand as date) from pointage p join EcritureControleFiscal ecf on ');
//             Req.SQL.add(' ecf.idEcriture=p.id_credit where ecf.idEcriture='+IntToStr_Lgr(idEcriture) );
//             req.SQL.Add(' and p.id_debit not in(select idEcriture from EcritureLettreTemp) and p.id_debit not in(select idEcriture from EcritureControleFiscal where ecritureLet<>'''')');
//           end;
//         req.Open;
//         result:=ChampTableVersListeEx(req,';',false,false);
//     end;
// finally
//   req.Close;
//   req:=nil;
// end;
//end;

function recuperePointagesLies_A_EcritureControlFiscal(idEcriture : integer ;debit,credit:currency):Tstringlist;
//var
//Req:TQuery;
begin
 try//finally
 try//except
// req:=TQuery.Create(DMExport);
DMExport.Requete2.close;
DMExport.Requete2.SQL.Clear;
 DMExport.Requete2.DatabaseName:=DM_C_NomAliasDossier;
 if(idEcriture<>0)then
     begin
         if(debit<>0)then
           begin
             DMExport.Requete2.SQL.Add(' select id_credit,cast(p.quand as date) from pointagePeriode p ');
             DMExport.Requete2.SQL.add('  where p.id_debit=:val and p.id_credit not in(select idEcriture from EcritureLettreTemp) ');
             DMExport.Requete2.SQL.add('  and p.id_credit not in(select idEcriture from EcritureControleFiscal where ecritureLet<>'''')');
           end
         else
           begin
             DMExport.Requete2.SQL.Add(' select id_debit,cast(p.quand as date) from pointagePeriode p ');
             DMExport.Requete2.SQL.add('  where p.id_credit=:val and p.id_debit not in(select idEcriture from EcritureLettreTemp) ');
             DMExport.Requete2.SQL.Add('  and p.id_debit not in(select idEcriture from EcritureControleFiscal where ecritureLet<>'''')');
           end;
//         req.Prepare;
          DMExport.Requete2.ParamByName('val').AsInteger:=idEcriture;
         DMExport.Requete2.Open;
         result:=ChampTableVersListeEx(DMExport.Requete2,';',false,false);
     end;
 except
    showmessage('recuperePointagesLies_A_EcritureControlFiscal : '+IntToStr_Lgr(idEcriture));
    abort;
 end;
 finally
   DMExport.Requete2.Close;
//   req:=nil;
 end;
end;



end.