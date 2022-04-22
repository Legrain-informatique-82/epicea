unit ImportDll;

interface
Uses
//SysUtils,
//WinTypes,
//WinProcs,
//Messages,
Classes,
//E2_Decl_Records,
//Graphics,
Controls;
//Dialogs,
//Forms,
//Registry,
//Db,
//DBTables,
//Gr_Librairie_Obj,
//StdCtrls;


  Function GetFirstDayOfMonth(T:TDate):integer;
//  Function DateInfos1(Date:TDate):PChar;
  //Function DateInfos(Date:TDate):TDetailDate;

implementation

  Function GetFirstDayOfMonth(T:TDate):integer;external 'LgrLib.dll' name 'GetFirstDayOfMonth';
  Function GetNbDayOfMonth(Mois,Annee:Word):Word;external 'LgrLib.dll' name 'GetNbDayOfMonth';
  function MoisStr(dateSaisie: TDate):string;external 'LgrLib.dll' name 'MoisStr';
  function jourStr(DateSaisie:TDate): string;external 'LgrLib.dll' name 'jourStr';
  function jourCol(DateSaisie:TDate): integer;external 'LgrLib.dll' name 'jourCol';

//  Function JourSuivant(DateDep:TDate;NbrJour:integer):TDetailDate;external 'LgrLib.dll' name 'JourSuivant';
//  Function JourPrecedent(DateDep:TDate;NbrJour:integer):TDetailDate;external 'LgrLib.dll' name 'JourPrecedent';
//  Function MoisSuivant(DateDep:TDate;NbrMois:integer):TDetailDate;external 'LgrLib.dll' name 'MoisSuivant';
//  Function MoisPrecedent(DateDep:TDate;NbrMois:integer):TDetailDate;external 'LgrLib.dll' name 'MoisPrecedent';
//  Function JourOffset(DateDep:TDate;NbrJour:integer):TDetailDate;external 'LgrLib.dll' name 'JourOffset';
//  Function MoisOffset(DateDep:TDate;NbrMois:integer):TDetailDate;external 'LgrLib.dll' name 'MoisOffset';

  Function DateValide(DateAVerif:String):Boolean;external 'LgrLib.dll' name 'DateValide';
  function HeureValide(HeureAVerif:String): Boolean;external 'LgrLib.dll' name 'HeureValide';
  Function TousLesJoursDuMois(DateDep:TDate): TList;external 'LgrLib.dll' name 'TousLesJoursDuMois';
//  Function DateInfos(Date:TDate):TDetailDate;external 'LgrLib.dll' name 'DateInfos';
//  Function DateInfos1(Date:TDate):PChar;external 'LgrLib.dll' name 'DateInfos1';
  Function CompareDate(Date1,Date2:TDate):Integer;external 'LgrLib.dll' name 'CompareDate';

end.
