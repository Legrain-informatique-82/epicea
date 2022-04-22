unit Dates;

{ Remarque importante à propos de la gestion mémoire des DLL : ShareMem doit
  être la première unité dans la clause USES de votre bibliothèque,
  ET dans la clause USES de votre projet (sélectionnez Voir-Source du projet)
  si vos DLLs exportent des procédures ou des fonctions passant en paramètre
  des chaînes ou des résultats de fonction.
  Ceci s'applique à toutes les chaînes passées par ou à vos DLLs - mêmes celles
  qui sont imbriquées dans des enregistrements ou des classes. ShareMem est
  l'unité d'interface au gestionnaire de mémoire partagée DELPHIMM.DLL, qui
  doit être déployé avec vos propres DLLs. Pour éviter l'emploi de DELPHIMM.DLL,
  passez vos chaînes en utilisant des paramètres PChar ou ShortString. }

interface
uses
SysUtils,
//WinTypes,
//WinProcs,
//Messages,
Classes,
//Graphics,
Controls,
//Dialogs,
//Forms,
//Registry,
//Db,
//DBTables,
gr_Librairie_obj,
//StdCtrls,
E2_Decl_Records;

{*******************************************************************************
Enregistrement servant à remplir une grille calendrier :
 col = indice colonne,
 semaine = indice ligne,
 chiffreJour = remplissage des cellules
*******************************************************************************}
type
  PListEnrGrid = ^ListEnrGrid;
  ListEnrGrid = Record
    Col:integer;
    Semaine:integer;
    ChiffreJour: integer;
end;

  Function GetFirstDayOfMonth(T:TDate):integer;stdcall;
  Function GetNbDayOfMonth(Mois,Annee:Word):Word;stdcall;
  function MoisStr(dateSaisie: TDate):string;stdcall;
  function jourStr(DateSaisie:TDate): string;stdcall;
  function jourCol(DateSaisie:TDate): integer;stdcall;

  Function JourSuivant(DateDep:TDate;NbrJour:integer):TDetailDate;stdcall;
  Function JourPrecedent(DateDep:TDate;NbrJour:integer):TDetailDate;stdcall;
  Function MoisSuivant(DateDep:TDate;NbrMois:integer):TDetailDate;stdcall;
  Function MoisPrecedent(DateDep:TDate;NbrMois:integer):TDetailDate;stdcall;
  Function JourOffset(DateDep:TDate;NbrJour:integer):TDetailDate;stdcall;
  Function MoisOffset(DateDep:TDate;NbrMois:integer):TDetailDate;stdcall;
  Function DateValide(DateAVerif:String):Boolean;stdcall;
  function HeureValide(HeureAVerif:String): Boolean;stdcall;
  Function TousLesJoursDuMois(DateDep:TDate): TList;stdcall;
  Function DateInfos(Date:TDate):TDetailDate;stdcall;
//  Function DateInfos1(Date:TDate):PChar;stdcall;
  Function CompareDate(Date1,Date2:TDate):Integer;stdcall;

//Var
//  DetailDate : TDetailDate;
//  EnrGrid : PListEnrGrid;
implementation
//{$R *.DFM}
// renvoie  1..7 (commance par dimanche)
// en fonction du 1er jour du mois...
//begin
Function GetFirstDayOfMonth(T:TDate):integer;//export;
Var
A,M,J : Word;
test : TDate;
begin
  DecodeDate(T,A,M,J);
  test:= EncodeDate(A,M,1);
  Result := dayofweek(test);
end;
//*****  Nombre de jours dans le mois
Function GetNbDayOfMonth(Mois,Annee:Word):Word;
begin
  result := 0;
  Case Mois of
    1  : Result:=31;
    2  : if Not IsLeapYear(Annee) then Result:=28 else Result:=29;
    3  : Result:=31;
    4  : Result:=30;
    5  : Result:=31;
    6  : Result:=30;
    7  : Result:=31;
    8  : Result:=31;
    9  : Result:=30;
    10 : Result:=31;
    11 : Result:=30;
    12 : Result:=31;
  End;
end;

function MoisStr(dateSaisie: TDate):string;
Var
A,M,J : Word;
begin
  DecodeDate(dateSaisie,A,M,J);
  case M of
    1: result :='Janvier';
    2: result :='Février';
    3: result :='Mars';
    4: result :='Avril';
    5: result :='Mai';
    6: result :='Juin';
    7: result :='Juillet';
    8: result :='Aout';
    9: result :='Septembre';
    10:result :='Octobre';
    11:result :='Novembre';
    12:result :='Decembre';
  end;
end;

function jourStr(DateSaisie:TDate): string;
var
  indiceJour: integer;
begin
  indiceJour := DayOfWeek(DateSaisie);
  case indiceJour of
    2:result := 'Lundi';
    3:result := 'Mardi';
    4:result := 'Mercredi';
    5:result := 'Jeudi';
    6:result := 'Vendredi';
    7:result := 'Samedi';
    1:result := 'Dimanche';
  end; 
end;

function jourCol(DateSaisie:TDate): integer;
var
  indiceJour: integer;
begin
  result := 0;
  indiceJour := DayOfWeek(DateSaisie);
  case indiceJour of
    1:result := 7; // = n° de colonne...
    2:result := 1;
    3:result := 2;
    4:result := 3;
    5:result := 4;
    6:result := 5;
    7:result := 6;
  end;
end;


Function JourSuivant(DateDep:TDate;NbrJour:integer):TDetailDate;
Var
A,M,J : Word;
DetailDate : TDetailDate;
begin
// on récupère le jour, le mois, l'année d'une date donnée
//  memJ := NbrJour;
  DecodeDate(DateDep,A,M,J);
  NbrJour := abs(NbrJour);
  if NbrJour <> 0 then
  begin
//*****************  total < fin du mois   *************************************
    if (((J + NbrJour) ) <= GetNbDayOfMonth(M,A)) then  J := ((J + NbrJour) )
    else
    begin
//*****************  total > fin du mois   *************************************
      while (((J + NbrJour) ) > GetNbDayOfMonth(M,A)) do
      begin
        NbrJour := ((J + NbrJour) - GetNbDayOfMonth(M,A));
        M := M + 1;                      // on change de mois
        if M > 12 then
        begin
          A := A + 1;                // on change d'année...
          M := 1;
        end;
        J := 0;
      end ;
      J := (J + NbrJour)
    end;
  end;
// j'enregistre ds liste : date, an, mois, jour
  detaildate.Date_ := encodedate(A,M,J);
  detaildate.an := A;
  detaildate.mois := M;
  detaildate.jour := J;
//  Jsuivant := true;
  result:= detaildate;
end;


Function JourPrecedent(DateDep:TDate;NbrJour:integer):Tdetaildate;
Var
A,M,J : Word;
DetailDate : TDetailDate;
begin
// on récupère le jour, le mois, l'année d'une date donnée
  DecodeDate(DateDep,A,M,J);
  NbrJour := abs(NbrJour);
  if NbrJour <> 0 then
  begin
//*************    j >  jours à soustraire  ****************
    if (((J - NbrJour) ) >= 1) then  J := (J - NbrJour)
    else
//*************    j < jours à soustraire  *****************
    begin
      while ((J - NbrJour) ) < 1 do
      begin
        M := M - 1;          // on change de mois
        if M < 1 then
        begin
          A := A - 1;        // on change d'année...
          M := 12;
        end;
        if NbrJour = J then   // j = 0
        begin
          J := GetNbDayOfMonth(M,A);   // on met le dernier jour du mois
        end
        else         // j <
        begin
          NbrJour := NbrJour - j;
          J := GetNbDayOfMonth(M,A);   // on met le dernier jour du mois
        end;
      end;
      J := (J - NbrJour) ;
    end;
  end;
// j'enregistre ds liste : date, an, mois, jour
  detaildate.Date_ := encodedate(A,M,J);
  detaildate.an := A;
  detaildate.mois := M;
  detaildate.jour := J;
//  Jsuivant := false;
  result:= detaildate;
end;

Function MoisSuivant(Datedep:TDate;NbrMois:integer):Tdetaildate;
Var
A,M,J : Word;
DetailDate : TDetailDate;
begin
// on récupère le jour, le mois, l'année d'une date donnée
  DecodeDate(DateDep,A,M,J);
  NBrMois := abs(NBrMois);
  if NBrMois <> 0 then
  begin
//*******************  total <= 1 an *******************************************
    if ((M + NbrMois)) <= 12 then  M := (M + NbrMois)
    else
    begin
//********************   total > 1 an ******************************************
      while ((M + NbrMois)) > 12 do
      begin
        A := A + 1;
        NbrMois := NbrMois - 12;
      end;
      M := (M + NbrMois);
    end;
  end;
  detaildate.Date_ := encodedate(A,M,J);
  detaildate.an := A;
  detaildate.mois := M;
  detaildate.jour := J;
//  Msuivant := true;
  result:= detaildate;
end;

{*******************************************************************************
     
*******************************************************************************}
Function MoisPrecedent(DateDep:TDate;NbrMois:integer):Tdetaildate;
Var
A,M,J : Word;
DetailDate : TDetailDate;
begin
// on récupère le jour, le mois, l'année d'une date donnée
  DecodeDate(DateDep,A,M,J);
  NBrMois := abs(NBrMois);
  if NbrMois <> 0 then
  begin
//**********************  M > mois à soustraire ********************************
    if ((M - NbrMois) ) >= 1 then  M := (M - NbrMois)
    else
    begin
//**********************  M < mois à soustraire ********************************
      while  NbrMois > 12 do
      begin
        A := A - 1;       // on change d'année...
        NbrMois := NbrMois - 12;
      end;
      if ((M - NbrMois) ) < 1 then  // cas particuliers :
      begin
        if (((M - NbrMois) ) <> 0) then   // M = -1
        begin
          A := A - 1;
          M := 12;
          NbrMois := 0;
          M := (M - NbrMois)
        end
        else
        begin
          A := A - 1;     // M = 0
          M := 12;
        end;
      end;
    end;
  end;
  detaildate.Date_ := encodedate(A,M,J);
  detaildate.an := A;
  detaildate.mois := M;
  detaildate.jour := J;
  result:= detaildate;
end;

{*******************************************************************************
     calcule le jour suivant ou précédent d'écart donné :
*******************************************************************************}
Function JourOffset(DateDep:TDate;NbrJour:integer):Tdetaildate;
begin
  if NbrJour <> 0 then
  begin
    result := joursuivant(DateDep,NbrJour);
  end
  else
  begin
    result := jourPrecedent(DateDep,NbrJour);
  end; 
end;

{*******************************************************************************
     calcule le mois suivant ou précédent d'écart donné :
*******************************************************************************}
Function MoisOffset(DateDep:TDate;NbrMois:integer):Tdetaildate;
begin
  if NbrMois > 0 then
  begin
    result := MoisSuivant(DateDep,Nbrmois);
  end
  else
  begin
    result := MoisPrecedent(DateDep,Nbrmois);
  end;
end;

{*******************************************************************************
     vérifie si une saisie correspond à un format 'date'...
*******************************************************************************}
Function DateValide(DateAVerif:String):Boolean;
var
  test: TDate;
begin
  try
    begin
      test := strtodate(dateaverif);
      result := true;
    end;
  except
    result := false;
  end;
end;

{*******************************************************************************
     vérifie si une saisie correspond à un format 'heure'...
*******************************************************************************}
function HeureValide(HeureAVerif:String): Boolean;
var
  test : TTime;
begin
  try
    begin
      test := strToTime(Heureaverif);
      result := true;
    end;
  except
    result := false;
  end;
end;


{*******************************************************************************
     Remplissage 'Calendrier' d'une grille en fonction d'une date donnée
*******************************************************************************}
Function TousLesJoursDuMois(DateDep:TDate): TList;
var
  i,max,Semaine,prem,reste : integer;
  A,M,J : word;
  NewDate: TDate;
  MyListgrid : TList;
  EnrGrid : PListEnrGrid;
begin
  MyListGrid := TList.Create;
  New(EnrGrid);
  semaine := 0;
  reste := 0;
{ récupère an, mois, jour en fonction de la date donnée :}
  DecodeDate(DateDep,A,M,J);
{ calcule le nbre de jours ds le mois: }
  max := GetNbDayOfMonth(M,A);
  try
   begin
    for i := 1 to max do  {pour ts les jours du mois:}
    begin
      J := i;
      DateDep := EncodeDate(A,M,J);
{*******************  calcul de la colonne  ***********************************}
      enrgrid^.Col := jourCol(DateDep);  {= indice de la colonne}
{******************   calcul de la ligne   ************************************}
      prem := GetFirstDayOfMonth(DateDep); {= indice du 1er du mois}
      prem := jourCol(prem);
      reste := 7 - prem;
      case prem of
        1 : reste := 0;
        2 : reste := 1;
        3 : reste := 2;
        4 : reste := 3;
        5 : reste := 4;
        6 : reste := 5;
        7 : reste := 6;
      end;
      if ((J + reste) mod 7) <> 0 then
        Semaine := ((J + reste) div 7)+1
      else
        semaine := ((J + reste) div 7);
      enrgrid^.Semaine := Semaine;
{*************************** jour **************************************}
      enrgrid^.ChiffreJour := J;
{********************  enregistrement ds la liste **********************}
      MyListGrid.Add(enrgrid);
      new(enrgrid);
    end;
    result := MyListGrid;
   end;
  except
    MyListGrid.Free;
  end;
end;

Function DateInfos1(Date:TDate):PChar;
//Function DateInfos(Date:TDate):TDetailDate;
var
DateStr:string;
An,Mois,Jour:Word;
Begin
try
result:=PChar(DateToSTr(Date));
//  result.Vide:=false;
//  DateStr:=DateToStr(Date);
//  result.Valide:=true;
//  if date=0 then result.Vide:=true;
//  DecodeDate(Date,An,Mois,Jour);
//  result.an:=An;
//  result.mois:=Mois;
//  result.jour:=Jour;
//  result.AnStr:=PChar(InttoStr(An));
//  result.MoisStr:=PChar(IntToStr(Mois));
//  result.JourStr:=PChar(IntToStr(Jour));
//  result.Date_:=Date;
//  result.DateStr:=PChar(DateStr);
except
//  result.Valide:=False;
end;

End;

//Function DateInfos(Date:TDate):PChar;
Function DateInfos(Date:TDate):TDetailDate;
var
DateStr:string;
An,Mois,Jour:Word;
Begin
try
  result.Vide:=false;
  DateStr:=DateToStr(Date);
  result.Valide:=true;
  if date=0 then result.Vide:=true;
  DecodeDate(Date,An,Mois,Jour);
  result.an:=An;
  result.mois:=Mois;
  result.jour:=Jour;
  result.AnStr:=PChar(InttoStr(An));
  result.MoisStr:=PChar(IntToStr(Mois));
  result.JourStr:=PChar(IntToStr(Jour));
  result.Date_:=Date;
  result.DateStr:=PChar(DateStr);
except
  result.Valide:=False;
end;

End;

Function CompareDate(Date1,Date2:TDate):Integer;
Begin
result:=-2;
if DAteInfos(DAte1).Valide and DateInfos(Date2).Valide then
   begin
    if Date1 > Date2 then result:=-1;
    if Date1 = Date2 then result:=0;
    if Date1 < Date2 then result:=1;
   end;
End;

exports
 GetFirstDayOfMonth name 'GetFirstDayOfMonth',
 GetNbDayOfMonth name 'GetNbDayOfMonth',
 MoisStr name 'MoisStr',
 jourStr name 'jourStr',
 jourCol name 'jourCol',

 JourSuivant name 'JourSuivant',
 JourPrecedent name 'JourPrecedent',
 MoisSuivant name 'MoisSuivant',
 MoisPrecedent name 'MoisPrecedent',
 JourOffset name 'JourOffset',
 MoisOffset name 'MoisOffset',
 DateValide name 'DateValide',
 HeureValide name 'HeureValide',
 TousLesJoursDuMois name 'TousLesJoursDuMois',
 DateInfos name 'DateInfos',
 CompareDate name 'CompareDate';

begin
end.
