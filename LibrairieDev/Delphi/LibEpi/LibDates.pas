{***************************************************************
 *
 * Unit Name: LibDates
 * Purpose  :
 * Author   :
 * History  :
 *
 ****************************************************************}

unit LibDates;

interface

Uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics,
	Controls, Dialogs, Forms, Registry, Db, DBTables,StrUtils,
   StdCtrls, Grids,
   GR_Librairie_Obj,
   Lib_Chaine;

type
   TDetailDate = Record
     Date_:TDate;
     an:word;
     mois:word;
     jour:word;
     DateWord:word;
     AnStr:string;
     JourStr:string;
     MoisStr:string;
     Valide:boolean;
     DateStr:String;
     Vide:Boolean;
     DateReal:Real;
     DatePourSQLStr:String;
     DateStrFormat:String;
     JourMois:string;
     MoisAnnee:string;
     MoisAnneeStr:string;
   end;

    TDetailTime = Record
     Time_:TTime;
     Heure : word;
     minute:word;
     Seconde:word;
     HeureWord:word;
     HeureStr:string;
     MinuteStr:string;
     SecondeStr:string;
     Valide:boolean;
     HoraireStr:String;
     Vide:Boolean;
     HeureReal:Real;
     HeureStrFormate:String;
    end;


  Function GetFirstDayOfMonth(T:TDate):integer;
  Function GetNbDayOfMonth(Mois,Annee:Word):Word;
  function MoisStr(Date:TDate):string;
  function MoisStrReduit(Date:TDate):string;
  function jourStr(indiceJour:integer): string;
  function jourCol(indiceJour:integer): integer;

  Function JourSuivant(DateDep:TDate;NbrJour:integer):TDetailDate;
  Function JourPrecedent(DateDep:TDate;NbrJour:integer):TDetailDate;
  Function MoisSuivant(DateDep:TDate;NbrMois:integer):TDetailDate;
  Function MoisPrecedent(DateDep:TDate;NbrMois:integer):TDetailDate;
  Function JourOffset(DateDep:TDate;NbrJour:integer):TDetailDate;
  Function MoisOffset(DateDep:TDate;NbrMois:integer):TDetailDate;
  Function DateValide(DateAVerif:String):Boolean;
  Function TousLesJoursDuMois(DateDep:TDate): TDetailDate;
  Function DateInfos(Date:TDate;FormatReduit:boolean=false):TDetailDate;overload;
  Function DateInfos(Date:TDate;Separateur:String;FormatReduit:boolean=false):TDetailDate;overload;
  Function CompareDate(Date1,Date2:TDate):Integer;
  Function DateDsIntervale(DateDeb,DateTestee,DateFin:TDate;MessageLGR:TMessageLGR):Boolean;overload;
  Function DateDsIntervale(DateDeb,DateTestee,DateFin:TDate):Boolean;overload;
  Function TrimestrePrec(DateCourante:TDate; Var DateDebutTrimestrePrec, DateFinTrimestrePrec:TDate):Boolean;
  Function TrimestreEnCours(DateCourante:TDate; Var DateDebutTrimestrePrec, DateFinTrimestrePrec:TDate):Integer;
  Function NbDeJours(Date1,Date2:TDate):integer;
  Function NbAnne(Date1,Date2:TDate):Integer;
  Function NbAnneReel(Date1,Date2:TDate):Integer;
  Function NbMois(Date1,Date2:TDate):Integer;
  procedure initialiserDetailDate(var DetailDate:TdetailDate);
  Function AnneePrecedente(DateDep:TDate;NbrAnnee:integer):TDetailDate;
  Function AnneeDefaut(DateDeb,DateFin:TDate;JourMois:string):TDetailDate;
  Function NbDeJours_SurBase360(Date1,Date2:TDate;AmortLin:boolean):integer;
  function KeyPressDate(var Key: Char;Var Text:string;Var selstart:Integer;SelLength:Integer) :boolean;
//  Procedure InitDateDefaut(DateDef:TDate;var VarDate : array of TDateTime);
  Procedure InitDateDefaut(DateDef:TDate;var VarDate :TDateTime);
  function dateInfos_Str(date:string):string;
  Function AnneeDefaut_SurDerniereDateSaisie(DateDeb,DateFin,DerniereDateSaisie:TDate;JourMois:string):TDetailDate;
  Function AnneeDefaut_SurDerniereDateSaisie_Modifie(DateDeb,DateFin,DerniereDateSaisie:TDate;JourMois:string):TDetailDate; //**** isa le 22/10/2007 ***
  Function TempsEcoule(Date_ : TDateTime):String;
  Function HeureInfos(Horaire:TTime;Separateur:String):TDetailTime;
  function Str_String_To_DateString(Date:string;Format:integer=0):string;
  function Str_String_To_HeureString(Heure,h,Mn,s:string):string;
  function DateToStr_SQL(const D: Tdate; const Default: String='Null'): String;

Var
  an, mois, jour, memJ, memM: word;
  col : integer;
//  DetailDate : TDetailDate;
  TabJour : array[1..31] of TDetailDate;
  Jsuivant, Msuivant: boolean;



implementation
// renvoie  1..7 (commance par dimanche)
// en fonction du 1er jour du mois...
Function GetFirstDayOfMonth(T:TDate):integer;
Var
A,M,J : Word;
test : TDate;
begin
  DecodeDate(T,A,M,J);
  an := A;
  mois := M;
  test:= EncodeDate(A,M,1);
  Result := dayofweek(test);
end;

//*****  Nombre de jours dans le mois
Function GetNbDayOfMonth(Mois,Annee:Word):Word;
begin
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

function MoisStr(Date:TDate):string;
Var
A,M,J : Word;
begin
// on récupère le jour, le mois, l'année d'une date donnée
  DecodeDate(Date,A,M,J);
  case M of
    1: result :='Janvier';
    2: result :='Février';
    3: result :='Mars';
    4: result :='Avril';
    5: result :='Mai';
    6: result :='Juin';
    7: result :='Juillet';
    8: result :='Août';
    9: result :='Septembre';
    10:result :='Octobre';
    11:result :='Novembre';
    12:result :='Décembre';
  end;
end;

function MoisStrReduit(Date:TDate):string;
Var
A,M,J : Word;
begin
// on récupère le jour, le mois, l'année d'une date donnée
  DecodeDate(Date,A,M,J);
  case M of
    1: result :='Janv.';
    2: result :='Fév.';
    3: result :='Mar.';
    4: result :='Avr.';
    5: result :='Mai';
    6: result :='Juin';
    7: result :='Juil.';
    8: result :='Août';
    9: result :='Sep.';
    10:result :='Oct.';
    11:result :='Nov.';
    12:result :='Déc.';
  end;
end;

function jourStr(indiceJour:integer): string;
begin
// function DayOfWeek(Tdate) renvoie un indiceJour :
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

function jourCol(indiceJour:integer): integer;
begin
// function DayOfWeek(date) renvoie un indiceJour:
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
//Var
//A,M,J,JourDsMois,reste : Word;
begin
//// on récupère le jour, le mois, l'année d'une date donnée
//  memJ := NbrJour;
//  DecodeDate(DateDep,A,M,J);
////*****************  total < fin du mois   *************************************
//  if (((J + NbrJour) + 1) <= GetNbDayOfMonth(M,A)) then
//  begin
//    J := ((J + NbrJour) + 1);
//  end
//  else
//  begin
////*****************  total > fin du mois   *************************************
//    while (((J + NbrJour) + 1) > GetNbDayOfMonth(M,A)) do
//    begin
//      NbrJour := ((J + NbrJour) - GetNbDayOfMonth(M,A));
//      M := M + 1;                      // on change de mois
//      if M > 12 then
//      begin
//        A := A + 1;                // on change d'année...
//        M := 1;
//      end;
//      J := 0;
//    end ;
//      J := (J + NbrJour) + 1
//  end;
  DateDep:=DateDep+abs(NbrJour);
  result.Date_ := DateDep;
  result:=DateInfos(DateDep);
//  DecodeDate(DateDep,A,M,J);
////  encodedate(A,M,J);
//  detaildate.an := A;
//  detaildate.mois := M;
//  detaildate.jour := J;
//  result:= detaildate;
////// j'enregistre ds liste : date, an, mois, jour
//  detaildate.Date_ := encodedate(A,M,J);
//  detaildate.an := A;
//  detaildate.mois := M;
//  detaildate.jour := J;
//  Jsuivant := true;
//  result:= detaildate;
end;


Function JourPrecedent(DateDep:TDate;NbrJour:integer):Tdetaildate;
Var
A,M,J : Word;
begin
//// on récupère le jour, le mois, l'année d'une date donnée
//  memJ := NbrJour;
//  DecodeDate(DateDep,A,M,J);
////*************    j >  jours à soustraire  ****************
//  if (((J - NbrJour) - 1) >= 1) then
//  begin
//    J := (J - NbrJour) - 1;
//  end
//  else
////*************    j < jours à soustraire  *****************
//  begin
//    while ((J - NbrJour) - 1) < 1 do
//    begin
//      M := M - 1;          // on change de mois
//      if M < 1 then
//      begin
//        A := A - 1;        // on change d'année...
//        M := 12;
//      end;
//      if NbrJour = J then   // j = 0
//      begin
//        J := GetNbDayOfMonth(M,A);   // on met le dernier jour du mois
//      end
//      else         // j <
//      begin
//        NbrJour := NbrJour - j;
//        J := GetNbDayOfMonth(M,A);   // on met le dernier jour du mois
//      end;
//    end;
//    J := (J - NbrJour) - 1;
//  end;
// j'enregistre ds liste : date, an, mois, jour
  DateDep:=DateDep-abs(NbrJour);
  result.Date_ := DateDep;
  result:=DateInfos(DateDep);
  DecodeDate(DateDep,A,M,J);
//  encodedate(A,M,J);
  result.an := A;
  result.mois := M;
  result.jour := J;
//  result:= detaildate;
end;

Function MoisSuivant(Datedep:TDate;NbrMois:integer):Tdetaildate;
Var
A,M,J,NbJourMois: Word;
DernierJourMois:boolean;
//Annee,Mois,Jour : Word;
begin
DernierJourMois:=false;
// on récupère le jour, le mois, l'année d'une date donnée
  memM := NbrMois;
  DecodeDate(DateDep,A,M,J);
  //vérifier si jour = dernier jour du mois avant modif
  NbJourMois:=GetNbDayOfMonth(M,A);
  if NbJourMois = j then
     DernierJourMois:=true;
//*******************  total <= 1 an *******************************************
  if ((M + NbrMois)+ 1) <= 12 then  M := (M + NbrMois)+ 1
  else
  begin
//********************   total > 1 an ******************************************
  while ((M + NbrMois)+ 1) > 12 do
  begin
    A := A + 1;
    NbrMois := NbrMois - 12;
  end;
  M := (M + NbrMois)+ 1;
  end;
//vérifier si jour n'est pas supérieur au nombre de jours réel du mois
  NbJourMois:=GetNbDayOfMonth(M,A);
  if NbJourMois < j then
     j:=NbJourMois
  else
    if DernierJourMois then
      j:=NbJourMois;
   
  result.Date_ := encodedate(A,M,J);
  result.an := A;
  result.mois := M;
  result.jour := J;
  Msuivant := true;
//  result:= detaildate;

// Changer le code ci-dessus par le code ci dessous
// est plus fiable // PB le 06/04/04
// mais la fonction est utilisée à de nombreux endroits .....
//    DecodeDate(DateDep,Annee, Mois, Jour);
//    IncAMonth(Annee, Mois, Jour,NbrMois);
//    DateDep:=EncodeDate(Annee, Mois, Jour);
//    result :=DateInFos(DateDep);
end;


// // PB le 05/04/04 : j'ai tout changé, donc, à vérifier pour les dates un peu biscornues
Function MoisPrecedent(DateDep:TDate;NbrMois:integer):Tdetaildate;
Var
//A,M,J,NbJourMois : Word;
//DernierJourMois:boolean;
Annee,Mois,Jour : Word;
begin
//DernierJourMois:=false;
////showmessage(DateToStr(DateDep));
//// on récupère le jour, le mois, l'année d'une date donnée
////  memM := NbrMois;
//  DecodeDate(DateDep,A,M,J);
////vérifier si jour = dernier jour du mois avant modif
//    NbJourMois:=GetNbDayOfMonth(M,A);
//  if NbJourMois = j then
//     DernierJourMois:=true;
//    NBrMois := abs ( NBrMois );
//   if NbrMois <> 0 then
//      // M > mois à soustraire
//      if ( M - NbrMois ) >= 1 then
//         M := M - NbrMois
//      else
//
////**********************  M > mois à soustraire ********************************
////  if ((M - NbrMois) - 1) >= 1 then  M := (M - NbrMois) - 1
////  else
//  begin
////**********************  M < mois à soustraire ********************************
//    while  NbrMois > 12 do
//    begin
//      A := A - 1;       // on change d'année...
//      NbrMois := NbrMois - 12;
//    end;
//    if ((M - NbrMois) - 1) < 1 then  // cas particuliers :
//    begin
//      if (((M - NbrMois) - 1) <> 0) then   // M = -1
//      begin
//        A := A - 1;
//        M := 12;
//        NbrMois := 0;
//        M := (M - NbrMois)-1
//      end
//      else
//      begin
//        A := A - 1;     // M = 0
//        M := 12;
//      end;
//    end;
//  end;
////vérifier si jour n'est pas supérieur au nombre de jours réel du mois
//  NbJourMois:=GetNbDayOfMonth(M,A);
//  if NbJourMois < j then
//     j:=NbJourMois
//  else
//    if DernierJourMois then
//      j:=NbJourMois;
//  result.Date_ := encodedate(A,M,J);
////showmessage(DateToStr(detaildate.Date_ ));
//  result.an := A;
//  result.mois := M;
//  result.jour := J;
////  result:= detaildate;
    DecodeDate(DateDep,Annee, Mois, Jour);
    IncAMonth(Annee, Mois, Jour,NbrMois);
    DateDep:=EncodeDate(Annee, Mois, Jour);
    result :=DateInFos(DateDep);
end;

Function JourOffset(DateDep:TDate;NbrJour:integer):Tdetaildate;
begin
initialiserDetailDate(result);
  if NbrJour >= 0 then
  begin
    result := joursuivant(DateDep,NbrJour);
  end;
  if NbrJour < 0 then
  begin
    result := jourPrecedent(DateDep,NbrJour);
  end;
end;

Function MoisOffset(DateDep:TDate;NbrMois:integer):Tdetaildate;
begin
  if NbrMois > 0 then
  begin
//    test := (NbrMois * 30)+ 30;
//    result := JourSuivant(DateDep,test);
    result := MoisSuivant(DateDep,Nbrmois);
  end
  else
  begin
    result := MoisPrecedent(DateDep,Nbrmois);
  end;
end;

Function DateValide(DateAVerif:String):Boolean;
var
  test: TDate;
begin
  try
    begin
      if DateAVerif <> '00/00/0000' then
       begin
         test := strtodate(dateaverif);
         result := test > 0;
       end
       else
       result:=false;
    end;
  except
    result := false;
  end;
end;

Function TousLesJoursDuMois(DateDep:TDate):TDetailDate;
var
  i,max,indcol : integer;
  A,M,J : word;
begin
   DecodeDate(DateDep,A,M,J); // récupère an, mois, jour en fonction de la donnée
   indcol := GetFirstDayOfMonth(DateDep); // indice du 1er du mois
   col := jourCol(indcol);  // indice de la colonne
   max := GetNbDayOfMonth(M,A);  // nbre de jours ds le mois

   J := 1;    // on démarre au 1er du mois
   dateDep := encodedate(A,M,J);
   result.Date_ := DateDep;
   result.an := A;
   result.mois := M;
   result.jour := J;
   TabJour[1] := result;
   jourSuivant(dateDep,1);  // on calcule le suivant (1er enregistrement...)

   for i := 2 to (max) do
   begin
   TabJour[i] := result;  // on enregistre ds le tableau
   result := jourSuivant(result.Date_,1);//on passe au suivant
   end;
end;

Function DateInfos(Date:TDate;Separateur:String;FormatReduit:boolean):TDetailDate;
var
DetailDate:TDetailDAte;
Begin
DetailDate:=DateInfos(Date);
result.DateStrFormat:=DetailDate.JourStr+separateur+DetailDate.MoisStr+separateur+DetailDate.AnStr;
End;

Function DateInfos(Date:TDate;FormatReduit:boolean):TDetailDate;
var
DateStr:string;
An,Mois,Jour:Word;
Begin
try
  result.Vide:=false;
  result.Valide:=true;
  DateStr:=DateToStr(Date);
  if date=0 then result.Vide:=true;
  DecodeDate(Date,An,Mois,Jour);
  result.an:=An;
  result.mois:=Mois;
  result.jour:=Jour;
  result.AnStr:=InttoStr(An);
  result.MoisStr:=IntToStr(Mois);
  if Mois < 10 then result.MoisStr:='0'+result.MoisStr;
  result.JourStr:=IntToStr(Jour);
  if Jour < 10 then result.JourStr:='0'+result.JourStr;
  result.Date_:=Date;
  result.DateStr:=DateStr;
  if FormatReduit then
    begin
      result.AnStr:=copy(result.AnStr,3,2);
      result.DateStr:=result.JourStr+'/'+result.MoisStr+'/'+result.AnStr;
    end;
  result.DateReal := (Date);
  result.DatePourSQLStr:=result.MoisStr+'/'+result.JourStr+'/'+result.AnStr;
  result.DateStrFormat:= result.JourStr+'/'+result.MoisStr+'/'+result.AnStr;
  result.JourMois:=result.JourStr+'/'+result.MoisStr;
  result.MoisAnnee:=result.MoisStr+'/'+result.AnStr;
  result.MoisAnneeStr:=MoisStr(Date)+'/'+result.AnStr;
except
  result.Valide:=False;
end;

End;

Function HeureInfos(Horaire:TTime;Separateur:String):TDetailTime;
var
HoraireStr:string;
Heure,Minute,Seconde,MSeconde:Word;
Begin
try
  result.Vide:=false;
  result.Valide:=true;
  HoraireStr:=TimeToStr(Date);
  if date=0 then result.Vide:=true;
  DecodeTime(Horaire,Heure,Minute,Seconde,MSeconde);
  result.Heure:=Heure;
  result.minute:=Minute;
  result.Seconde:=Seconde;
  result.HeureStr:=InttoStr(Heure);
  result.MinuteStr:=IntToStr(Minute);
  result.SecondeStr:=IntToStr(Seconde);
  result.Time_:=Horaire;
  result.HoraireStr:=HoraireStr;
  result.HeureStrFormate:=result.HeureStr+Separateur+result.MinuteStr+Separateur+result.SecondeStr;
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

// DateDeb <= DateTestee <=DateFin
Function DateDsIntervale(DateDeb,DateTestee,DateFin:TDate;MessageLGR:TMessageLGR):Boolean;
Begin
result:=false;
result:=CompareDate(DateDeb,Datefin)<>-2;
if result then
 Begin
  result:=CompareDate(DateDeb-1,DateTestee)=1;
  if result then
      result:=CompareDate(DateTestee,DateFin+1)=1;
 end;
//à finir 'MessageLGR'
End;


Function DateDsIntervale(DateDeb,DateTestee,DateFin:TDate):Boolean;
Begin
result:=false;
result:=CompareDate(DateDeb,Datefin)<>-2;
if result then
 Begin
  result:=CompareDate(DateDeb-1,DateTestee)=1;
  if result then
      result:=CompareDate(DateTestee,DateFin+1)=1;
 end;
End;


Function TrimestrePrec(DateCourante:TDate; Var DateDebutTrimestrePrec, DateFinTrimestrePrec:TDate):Boolean;
//Var
//DAteTmp1,DAteTmp2:TDate;
Begin
showmessage('La fonction TrimestrePrec doit être verifié, ses résultats ne sont plus valide !');
// Avant de remmetre en service, il vérifier les valeur retournées par moisOffset !!!!!!!!!!!!!!!!

//result:=DateValide(DAteToStr(DateCourante));
//if result then
// Begin
//     case DateInfos(DateCourante).mois of
//        1:begin
//          DateTmp1:=MoisOffset(DateCourante,-3).Date_;
//          DateTmp2:=MoisOffset(DateCourante,-1).Date_;
//         end;
//        2:begin
//          DateTmp1:=MoisOffset(DateCourante,-4).Date_;
//          DateTmp2:=MoisOffset(DateCourante,-2).Date_;
//         end;
//        3:begin
//          DateTmp1:=MoisOffset(DateCourante,-5).Date_;
//          DateTmp2:=MoisOffset(DateCourante,-3).Date_;
//         end;
//        4:begin
//          DateTmp1:=MoisOffset(DateCourante,-3).Date_;
//          DateTmp2:=MoisOffset(DateCourante,-1).Date_;
//         end;
//        5:begin
//          DateTmp1:=MoisOffset(DateCourante,-4).Date_;
//          DateTmp2:=MoisOffset(DateCourante,-2).Date_;
//         end;
//        6:begin
//          DateTmp1:=MoisOffset(DateCourante,-5).Date_;
//          DateTmp2:=MoisOffset(DateCourante,-3).Date_;
//         end;
//        7:begin
//          DateTmp1:=MoisOffset(DateCourante,-3).Date_;
//          DateTmp2:=MoisOffset(DateCourante,-1).Date_;
//         end;
//        8:begin
//          DateTmp1:=MoisOffset(DateCourante,-4).Date_;
//          DateTmp2:=MoisOffset(DateCourante,-2).Date_;
//         end;
//        9:begin
//          DateTmp1:=MoisOffset(DateCourante,-5).Date_;
//          DateTmp2:=MoisOffset(DateCourante,-3).Date_;
//         end;
//        10:begin
//          DateTmp1:=MoisOffset(DateCourante,-3).Date_;
//          DateTmp2:=MoisOffset(DateCourante,-1).Date_;
//         end;
//        11:begin
//          DateTmp1:=MoisOffset(DateCourante,-4).Date_;
//          DateTmp2:=MoisOffset(DateCourante,-2).Date_;
//         end;
//        12:begin
//          DateTmp1:=MoisOffset(DateCourante,-5).Date_;
//          DateTmp2:=MoisOffset(DateCourante,-3).Date_;
//         end;
//     end;
//DateDebutTrimestrePrec:=encodeDate(Dateinfos(DateTmp1).an,Dateinfos(DateTmp1).mois,1);
//DateFinTrimestrePrec:=encodeDate(Dateinfos(DateTmp2).an,Dateinfos(DateTmp2).mois,GetNbDayOfMonth(Dateinfos(DateTmp2).mois,Dateinfos(DateTmp2).an));
//End;

//    showmessage(inttostr(GetNbDayOfMonth(Dateinfos(DateTmp).mois,Dateinfos(DateTmp).an)));
//    showmessage(inttostr(Dateinfos(DateTmp).mois));
//    showmessage(inttostr(Dateinfos(DateTmp).an));
End;

Function TrimestreEnCours(DateCourante:TDate; Var DateDebutTrimestrePrec, DateFinTrimestrePrec:TDate):Integer;
Begin
showmessage('La fonction TrimestreEnCours doit être verifié, ses résultats ne sont plus valide !');
// Avant de remmetre en service, il vérifier les valeur retournées par moisOffset !!!!!!!!!!!!!!!!

result:=0;
//  try
//    case DateInfos(DateCourante).mois of
//       1..3:begin
//              result:=1;
//              DateDebutTrimestrePrec:=encodeDate(Dateinfos(DateCourante).an,1,1);
//              DateFinTrimestrePrec:=encodeDate(Dateinfos(DateCourante).an,3,31);
//            end;
//       4..6:begin
//             result:=2;
//              DateDebutTrimestrePrec:=encodeDate(Dateinfos(DateCourante).an,4,1);
//              DateFinTrimestrePrec:=encodeDate(Dateinfos(DateCourante).an,6,30);
//            end;
//       7..9:begin
//              result:=3;
//              DateDebutTrimestrePrec:=encodeDate(Dateinfos(DateCourante).an,7,1);
//              DateFinTrimestrePrec:=encodeDate(Dateinfos(DateCourante).an,9,30);
//            end;
//       10..12:begin
//                result:=4;
//              DateDebutTrimestrePrec:=encodeDate(Dateinfos(DateCourante).an,10,1);
//              DateFinTrimestrePrec:=encodeDate(Dateinfos(DateCourante).an,12,31);
//              end;
//    end;
//  except
//    result:=0;
//  end;
End;


Function NbDeJours(Date1,Date2:TDate):integer;
var
Negatif:boolean;
aux:extended;
AuxStr:string;
Begin
  Negatif:=(Date1 -Date2) < 0;
  if negatif then
  aux:=int((Date1 -Date2) * -1)+1
  else
  aux:=int(Date1 -Date2)+1;
  auxStr:=FloatToStr(aux);
  result:=strToInt(AuxStr);
End;

Function NbAnne(Date1,Date2:TDate):Integer;
var
Negatif:boolean;
Begin
  Negatif:=(DateInfos(DAte1).an - DateInfos(DAte2).an) < 0;
  if negatif then
  result:=((DateInfos(DAte1).an - DateInfos(DAte2).an)*-1)+1
  else
  result:=(DateInfos(DAte1).an - DateInfos(DAte2).an)+1;
End;

Function NbAnneReel(Date1,Date2:TDate):Integer;
var
Negatif:boolean;
Begin
  Negatif:=(DateInfos(DAte1).an - DateInfos(DAte2).an) < 0;
  if negatif then
  result:=((DateInfos(DAte2).an - DateInfos(DAte1).an))
  else
  result:=(DateInfos(DAte1).an - DateInfos(DAte2).an);
End;


Function NbMois(Date1,Date2:TDate):Integer;
var
Negatif:boolean;
DateTmp:TDate;
//aux:Word;
//AuxStr:string;
//i:integer;
begin
    Negatif:=(DAte1 - DAte2)<= 0;
//  Negatif:=(DateInfos(DAte1).an - DateInfos(DAte2).an) <= 0;
    result:=0;
  if negatif then
   begin
    DateTmp:=Date1;
//    while (DateTmp <= Date2) do
    while (DateTmp < Date2) do  //isa le 31-03-03
     Begin
     DateTmp:=MoisSuivant(DateTmp,0).Date_;
     inc(result);
     End;
   end
   else
   begin
    DateTmp:=Date2;
    //while (DateTmp <= Date1) do //isa le 05-05-03
    while (DateTmp < Date1) do
     Begin
     DateTmp:=MoisSuivant(DateTmp,0).Date_;
     inc(result);
     End;
   end;
//showmessage(Inttostr(result));
end;


procedure initialiserDetailDate(var DetailDate:TdetailDate);
Begin
     DetailDate.Date_:=0;
     DetailDate.an:=0;
     DetailDate.mois:=0;
     DetailDate.jour:=0;
     DetailDate.DateWord:=0;
     DetailDate.AnStr:='';
     DetailDate.JourStr:='';
     DetailDate.MoisStr:='';
     DetailDate.Valide:=false;
     DetailDate.DateStr:='';
     DetailDate.Vide:=false;
     DetailDate.JourMois:='';
     DetailDate.MoisAnnee:='';
End;



Function AnneePrecedente(DateDep:TDate;NbrAnnee:integer):TDetailDate;
Var
A,M,J: Word;
//JourDsMois : Word;
begin
// on récupère le jour, le mois, l'année d'une date donnée
  DecodeDate(DateDep,A,M,J);
  A:=A-abs(NbrAnnee);
  EncodeDate(A,M,J);
  result.Date_ := EncodeDate(A,M,J);
  result.an := A;
  result.mois := M;
  result.jour := J;
//  result:= detaildate;
end;

Function AnneeDefaut(DateDeb,DateFin:TDate;JourMois:string):TDetailDate;
var
Annee:integer;
MoisStr,JourStr:string;
Begin
initialiserDetailDate(result);
if empty(JourMois) then JourMois:=DAteinfos(now).DateStr;
MoisStr:='';
JourStr:='';
annee:=-1;
if ((DAteDeb = 0) and (DateFin=0)) then annee:=DAteinfos(now).an;
  while str_fini_par(JourMois,DateSeparator) do JourMois:=str_Suppr_N_Car_ADroite(JourMois,1);

 if Str_Count_Str(DateSeparator,JourMois) > 2 then
  JourMois:=str_Suppr_Repetition(JourMois,DateSeparator);
  case Str_Count_Str(DateSeparator,JourMois) of
     0:begin
        JourStr:=copy(JourMois,1,2);
        if length(JourMois)> 2 then
        MoisStr:=copy(JourMois,3,2);
       end;
     1:begin
        JourStr:=GetStringElement(JourMois,1,'/');
        MoisStr:=GetStringElement(JourMois,2,'/');
       end;
     2:begin
        JourStr:=GetStringElement(JourMois,1,'/');
        MoisStr:=GetStringElement(JourMois,2,'/');
        annee:=StrToInt(GetStringElement(JourMois,3,'/'));
       end;
  end;

if empty(MoisStr) then
 MoisStr:=DAteinfos(now).MoisStr
 else
 if StrToInt(MoisStr) > 12 then
  MoisStr:=DAteinfos(now).MoisStr;

  if ((annee > 0) and (annee <= 50)) then annee:=annee+2000;
if annee = 0 then annee:=2000;
if ((annee > 50) and (annee < 100)) then annee:=annee+1900;
if annee = -1 then
 begin
  if StrToInt(MoisStr) >= DateInfos(DateDeb).mois then annee:=DateInfos(DateDeb).an;
  if StrToInt(MoisStr) <= DateInfos(DateFin).mois then Annee:=DateInfos(DateFin).an;
 end;

if empty(JourStr) then
 JourStr:=DAteinfos(now).JourStr
 else
 if StrToInt(JourStr) > GetNbDayOfMonth(StrToInt(MoisStr),annee) then
  JourStr:=IntToSTr(GetNbDayOfMonth(StrToInt(MoisStr),annee));

result.Date_:=EncodeDate(Annee,StrToInt(MoisStr),StrToInt(JourStr));
result:=DateInfos(result.Date_);

End;

Function NbDeJours_SurBase360(Date1,Date2:TDate;AmortLin:boolean):integer;
var
jour1,jour2,Mois1,Mois2,annee1,annee2:word;
nbMoisAux:integer;
Begin
result:=0;
//nbMoisAux:=0;
decodedate(date1,annee1,mois1,jour1);
decodedate(date2,annee2,mois2,jour2);
if jour1=31 then jour1:=30;
if jour2=31 then jour2:=30;
if date1=date2 then
  result:=1
else
  begin
    if jour1=GetNbDayOfMonth(mois1,annee1) then
      result:=1
    else
      begin
        if jour2-jour1<0 then
          begin
            result:=30-jour1+jour2+1;
          end
        else
          result:=(jour2-jour1)+1;
      end;
  end;
if mois2-mois1<0 then
  nbMoisAux:=12-mois1+mois2
else
    nbMoisAux:=mois2-mois1;
if not AmortLin then
  begin//si amortissement Degressif on calcul au mois près
    if ((result<30)and(result<>0)) then
      result:=30;
  end;//fin si amortissement Degressif on calcul au mois près
result:=result+(nbMoisAux*30);
if ((result=0)and(annee1<>annee2))then
  result:=360;
End;


//******************************************************************************
function KeyPressDate(var Key: Char;Var Text:string;Var selstart:Integer;SelLength:Integer) :boolean;
Var
 dt :TDateTime;
 texte:string;
Begin
Result:=false;
   if key =#13 then exit;
   if (key = #32) or (key = '.') then
   Begin
      key:= DateSeparator;
      Result:= True;
   End
   Else if (Key In ['-', '+']) then
   Begin
      dt:= StrToDate2(Text);
      if (Dt = 0) then Dt:= SysUtils.Date
      Else if (Key = '-') then
           begin
           dt:= Dt -1;
           text:=DateToStr(dt);
           end
           Else
           begin
           Dt:= Dt +1;
           text:=DateToStr(dt);
           end;
      Key:= #0;
      Result:= False;
      exit;
   End
   Else if not (Key in [#0..#31, '0'..'9', DateSeparator]) then
   Begin
      messagebeep(0);
      Key:= #0;
      Result:= False;
   End
   Else Result:= True;
   if ((length(text)=2) and (key <> DateSeparator) and (key <> #8)) then
      if pos('/',text) = 0 then
                       Begin
                        texte:=text;
                        text:=texte+DateSeparator;
                        selstart:=length(text);
                       End;
   if ((length(text)=5) and (key <> DateSeparator) and (key <> #8)) then
      if pos('/',text) = 3 then
                       Begin
                        texte:=text;
                        text:=texte+DateSeparator;
                        selstart:=length(text);
                       End;
   if length(text)>=6 then
      if pos('/',text) = 0 then
                       Begin
                        texte:=text;
                        insert('/',texte,3);
                        insert('/',texte,6);
                        text:=texte+key;
//                        key:=#0;
//                        UpdateContents;
                        selstart:=length(text);
                       End;

   if length(text)>=10 then
    begin
     if ((key <> #8) and (SelLength=0))
     then key:=#0
     else
     if ((key <> #8) and (SelLength>0))
      then
      begin
       delete(Text,SelStart+1,SelLength);
      end;
    end;
     if ((key = #8) and (SelLength>0)) then
       begin
         delete(Text,SelStart+1,SelLength);
         key:=#0;
       end;
End;

Procedure InitDateDefaut(DateDef:TDate;var VarDate : TDateTime);
//Procedure InitDateDefaut(DateDef:TDate;var VarDate : array of TDateTime);
//var
//i:integer;
Begin
//For i:=0 to high(VarDate) do
//  Begin
//   if VarDate[i]= 0 then
//     VarDate[i]:=DateDef;
//  End;
if VarDate= 0 then
     VarDate:=DateDef;
End;

function dateInfos_Str(date:string):string;
var
J,M,A:string;
Annee:integer;
valide:boolean;
begin
result:='';
valide:=true;
try
if strtodate(date)>0 then
  begin
    if Length(trim(date))<10 then
      Begin//si
        A:=copy(date,Length(trim(date))-1,Length(trim(date)));
        if not empty(A)then
          begin
            Annee:=strtoint(trim(A));
            if Annee>=50 then Annee:=Annee+1900 else
              Annee:=Annee+2000;
            A:=inttostr(Annee);
            delete(date,Length(trim(date))-1,Length(date));
            date:=date+A;
          end;
      End;//fin si
    result:=date;
  end;  
except
  valide:=false;
end;
if not valide then
  Begin//si pas valide
     if Str_Count_Str(DateSeparator,date) > 2 then
      date:=str_Suppr_Repetition(date,DateSeparator);
    j:=copy(date,1,2);
    if pos(dateseparator,date)<>0 then
      Begin//si
        delete(date,1,pos(dateseparator,date));
        M:=copy(date,1,pos(dateseparator,date)-1);
        delete(date,1,pos(dateseparator,date));
        A:=date;
      End;//fin si
    //on recompose la date
    if not empty(j) then
      Begin//si
        if length(trim(j))<2 then
          j:='0'+j;
        result:=j;
        if not empty(M) then
          begin
            result:=result+'/'+M;
            if not empty(A)then
              begin
                Annee:=strtoint(trim(A));
                if Annee>=50 then Annee:=Annee+1900 else
                  Annee:=Annee+2000;
                A:=inttostr(Annee);
                result:=result+'/'+A;
              end;
          end;
      End;//fin si
  End;//fin si pas valide
end;


Function AnneeDefaut_SurDerniereDateSaisie(DateDeb,DateFin,DerniereDateSaisie:TDate;JourMois:string):TDetailDate;
var
Annee:integer;
//i,NbDateSeparateur:integer;
//mois:word;
MoisStr,JourStr:string;
Begin
initialiserDetailDate(result);
//i:=length(JourMois);
if empty(JourMois) then JourMois:=DAteinfos(DerniereDateSaisie).DateStr;
MoisStr:='';
JourStr:='';
annee:=-1;
if ((DAteDeb = 0) and (DateFin=0)) then annee:=DAteinfos(DerniereDateSaisie).an;
//NbDateSeparateur:=0;
  while str_fini_par(JourMois,DateSeparator) do JourMois:=str_Suppr_N_Car_ADroite(JourMois,1);

 if Str_Count_Str(DateSeparator,JourMois) > 2 then
  JourMois:=str_Suppr_Repetition(JourMois,DateSeparator);
  case Str_Count_Str(DateSeparator,JourMois) of
     0:begin
        JourStr:=copy(JourMois,1,2);
        if length(JourMois)> 2 then
        MoisStr:=copy(JourMois,3,2);
       end;
     1:begin
        JourStr:=GetStringElement(JourMois,1,'/');
        MoisStr:=GetStringElement(JourMois,2,'/');
       end;
     2:begin
        JourStr:=GetStringElement(JourMois,1,'/');
        MoisStr:=GetStringElement(JourMois,2,'/');
        annee:=StrToInt(GetStringElement(JourMois,3,'/'));
       end;
  end;

if empty(MoisStr) then
 MoisStr:=DAteinfos(DerniereDateSaisie).MoisStr
 else
 if StrToInt(MoisStr) > 12 then
  MoisStr:=DAteinfos(DerniereDateSaisie).MoisStr;

  if ((annee > 0) and (annee <= 50)) then annee:=annee+2000;
if annee = 0 then annee:=2000;
if ((annee > 50) and (annee < 100)) then annee:=annee+1900;
if annee = -1 then
 begin
  annee:=DateInfos(DerniereDateSaisie).an;
  If annee>DateInfos(DateFin).an then
    begin
      if StrToInt(MoisStr) >= DateInfos(DateDeb).mois then annee:=DateInfos(DateDeb).an;
      if StrToInt(MoisStr) <= DateInfos(DateFin).mois then Annee:=DateInfos(DateFin).an;
    end;
 end;

if empty(JourStr) then
 JourStr:=DAteinfos(DerniereDateSaisie).JourStr
 else
 if StrToInt(JourStr) > GetNbDayOfMonth(StrToInt(MoisStr),annee) then
  JourStr:=IntToSTr(GetNbDayOfMonth(StrToInt(MoisStr),annee));

result.Date_:=EncodeDate(Annee,StrToInt(MoisStr),StrToInt(JourStr));
result:=DateInfos(result.Date_);

End;


Function AnneeDefaut_SurDerniereDateSaisie_Modifie(DateDeb,DateFin,DerniereDateSaisie:TDate;JourMois:string):TDetailDate;
var
Annee:integer;
//i,NbDateSeparateur:integer;
//mois:word;
MoisStr,JourStr:string;
Begin
initialiserDetailDate(result);
//i:=length(JourMois);
if empty(JourMois) then JourMois:=DAteinfos(DerniereDateSaisie).DateStr;
MoisStr:='';
JourStr:='';
annee:=-1;
if ((DAteDeb = 0) and (DateFin=0)) then annee:=DAteinfos(DerniereDateSaisie).an;
//NbDateSeparateur:=0;
  while str_fini_par(JourMois,DateSeparator) do JourMois:=str_Suppr_N_Car_ADroite(JourMois,1);

 if Str_Count_Str(DateSeparator,JourMois) > 2 then
  JourMois:=str_Suppr_Repetition(JourMois,DateSeparator);
  case Str_Count_Str(DateSeparator,JourMois) of
     0:begin
        JourStr:=copy(JourMois,1,2);
        if length(JourMois)> 2 then
        MoisStr:=copy(JourMois,3,2);
       end;
     1:begin
        JourStr:=trim(GetStringElement(JourMois,1,'/'));
        MoisStr:=trim(GetStringElement(JourMois,2,'/'));
       end;
     2:begin
        JourStr:=trim(GetStringElement(JourMois,1,'/'));
        MoisStr:=trim(GetStringElement(JourMois,2,'/'));
        annee:=StrToInt_Lgr(trim(GetStringElement(JourMois,3,'/')),-1);
       end;
  end;

if empty(MoisStr) then
 MoisStr:=DAteinfos(DerniereDateSaisie).MoisStr
 else
 if StrToInt(MoisStr) > 12 then
  MoisStr:=DAteinfos(DerniereDateSaisie).MoisStr;

  if ((annee > 0) and (annee <= 50)) then annee:=annee+2000;
if annee = 0 then annee:=2000;
if ((annee > 50) and (annee < 100)) then annee:=annee+1900;
if annee = -1 then
 begin
  annee:=DateInfos(DerniereDateSaisie).an;
  If annee>DateInfos(DateFin).an then
    begin
      if StrToInt(MoisStr) >= DateInfos(DateDeb).mois then annee:=DateInfos(DateDeb).an;
      if StrToInt(MoisStr) <= DateInfos(DateFin).mois then Annee:=DateInfos(DateFin).an;
    end;
 end;

if empty(JourStr) then
 JourStr:=DAteinfos(DerniereDateSaisie).JourStr
 else
 if StrToInt(JourStr) > GetNbDayOfMonth(StrToInt(MoisStr),annee) then
  JourStr:=IntToSTr(GetNbDayOfMonth(StrToInt(MoisStr),annee));

result.Date_:=EncodeDate(Annee,StrToInt(MoisStr),StrToInt(JourStr));
result:=DateInfos(result.Date_);

End;


Function TempsEcoule(Date_ : TDateTime):String;
var
hh,mn,ss,Ms:word;
Begin
//DateInfos(Date_).JourStr
DecodeTime(Date_,hh,mn,ss,Ms);
if date_ < 1 then
result:='0 Jour '+ IntTostr(hh)+' h '+IntTostr(mn)+' mn'
//else result:= FloatToStr(int(DateInfos(Date_).DateReal))+' jours, ' + TimeToStr(Frac(DateInfos(Date_).DateReal));
else
if date_>=2 then
result:= FloatToStr(int(DateInfos(Date_).DateReal))+' jours, ' + IntTostr(hh)+' h '+IntTostr(mn)+' mn'
else result:= FloatToStr(int(DateInfos(Date_).DateReal))+' jour, ' + IntTostr(hh)+' h '+IntTostr(mn)+' mn';
//else result:= DateInfos(Date_).MoisStr+' mois '+DateInfos(Date_).JourStr+' jours, ' + IntTostr(hh)+' h '+IntTostr(mn)+' mn';
End;


//Remplace une chaine de caractère représentant une date mais sans séparateur '/' par
//une chaîne représentant une date formatée
// ex: 20122003 => 20/12/2003
function Str_String_To_DateString(Date:string;Format:integer):string;
var
A,M,J:String;
begin
  try
      case length(date) of
         8:begin

           end;
         7:begin
             date:='0'+date;
           end;
        //else abort;
      end;//fin du case
     case Format of
        {jj/MM/AA}0:begin
                       result:=copy(date,1,2)+'/'+copy(date,3,2)+'/'+copy(date,7,2);//8 caractères au final
                    end;
      {jj/MM/AAAA}1:Begin
                       result:=copy(date,1,2)+'/'+copy(date,3,2)+'/'+copy(date,5,4);//10 caractères au final
                    end;
      {AAAA/MM/jj}2:Begin
                       A:=copy(date,1,4);
                       M:= copy(date,5,2);
                       J:= copy(date,7,2);
                       result:=J+'/'+M+'/'+A;//10 caractères au final
                    end;
      {AAAA-MM-jj}3:Begin
                       A:=copy(date,1,4);
                       M:= copy(date,6,2);
                       J:= copy(date,9,2);
                       result:=J+'/'+M+'/'+A;//10 caractères au final
                    end;
      {jj/MM/AAAA}4:Begin
                       J:=copy(date,1,2);
                       M:= copy(date,4,2);
                       A:= copy(date,7,4);
                       result:=A+'-'+M+'-'+J;//10 caractères au final
                    end;
     end;//fin du case
   datevalide(result);
  except
    result:='';
  end;
end;

//Remplace une chaine de caractère représentant une heure mais sans séparateur ':' par
//une chaîne représentant une heure formatée
// ex: 201220 => 20:12:20 -> par defaut sinon
// 201220 => 20 h 12 mn 20 s (si les séparateur ne sont pas vide !!!
function Str_String_To_HeureString(Heure,h,Mn,s:string):string;
begin
  try
      case length(Heure) of
         6:begin

           end;
         5:begin
             Heure:='0'+Heure;
           end;
        else abort;
      end;//fin du case
   if Str_empty(h) then h:=':';
   if Str_empty(mn) then mn:=':';
   result:=copy(Heure,1,2)+h+copy(Heure,3,2)+mn+copy(Heure,5,2)+s;
  except
    result:='';
  end;
end;

function DateToStr_SQL(const D: Tdate; const Default: String): String;
begin
Result := Default;
  if D<>0 then
    Result := datetostr(D);
end;

end.
