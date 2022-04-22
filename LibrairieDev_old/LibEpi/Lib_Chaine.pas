{***************************************************************
 * ID     : str01lib
 * Nom    : Str_lib
 * Chemin :
 ***************************************************************}

unit lib_chaine;

interface

uses SysUtils,Classes;

type
RetourPosition=record
  retour:boolean;
  Position:integer;
end;
type
   TStringArray = array of string;
//******************************************************************
{fonction qui renvoie un message pour les tests}
function traitementCodeErreur(numErreur:integer):string;
//******************************************************************
function str_int2str ( i : integer ) : string;
function str_str2int ( str : string ) : integer;
function str_bool2str ( booleen : boolean ) : string;   //OK
function str_bool2str_FR ( booleen : boolean ) : string; //OK
Function str_Empty ( Const Value : String ) : Boolean;   // ok
Function str_Empty_Numeric ( Const Value : String ) : Boolean; //isa le 14/11/2006
Function str_Empty_Numeric_Format ( Const Value : String ; Const FormatMonnaie : String ) : Boolean;//isa le 17/08/2007
function str_bool2str_LGR ( booleen : boolean ;ValeurVrai,ValeurFaux:String) : string;
function str_position(substr  ,str: string ) : integer;   // ok
function str_position_caseInsensitive ( substr , str : string ) : integer;//ok { isa  le  06/10/04 }
function str_lg( str : string ) : integer;   // OK
function str_souschaine ( str : string ; pos, nombre : integer ) : string; //OK
function str_n_prem_char ( str : string ; n : integer ) : string;    //OK
function str_n_der_char ( str : string ; n : integer ) : string;
function str_minuscule ( str : string ) : string;    // A revoir
function str_majuscule ( str : string ) : string;    // A Revoir
function str_minusculechar ( ch : char ) : char;     // A Revoir
function str_majusculeschar ( ch : char ) : char;    // A Revoir
function str_duplique ( str: string ; nb : integer ) : string;    // ok
function str_supprespaces ( str : string ) : string;    // ok
function str_supprespacesdroite ( str : string ) : string; // ok
function str_supprespacesgauche ( str : string ) : string; // ok
function str_ajouteAdroite ( str,Str2 : string ; lngth : integer) : string;   // ok
function str_ajouteAgauche ( str,Str2 : string ; lngth : integer) : string;
function str_ajouteAdroiteAgauche ( str, Str1, Str2 : string ; lngth1,lngth2 : integer ) : string;
function str_supprespacestout ( str : string ) : string;
function str_avant_nb ( str, substr : string ; nb : integer ) : string;
function str_avant ( str ,substr: string ) : string; // ok
function str_apres ( str, substr : string ) : string; // ok
function str_apres_nb ( str, substr : string ; nb : integer ) : string;
function str_recherchesouschaine ( source, pattern : string ) : RetourPosition;
function str_chiffreenlettre ( n : integer ) : string;
function str_remplacesouschaine ( str, sub1, sub2 : string ) : string;
function str_casse_maj_sep ( source, separateur : string ) : string;
function str_casse_maj ( str : string ) : string;
function Str_min_comp ( str1, str2 : string ) : string;
function str_max_comp ( str1, str2 : string ) : string;
function str_commence_par ( str, substr : string ) : boolean;
function str_fini_par ( str, substr : string ) : boolean;
function str_delimite ( str, debut, fin : string ) : string;
function str_concat ( str1, str2 : string ) : string;
function str_telephonea10chiffre ( ancientel, aposte : string ) : string;
function str_getstringelement ( astring : string ; apos : integer; csep : char ) : string;
Function str_QueDesChiffres ( s : String ) : String;
Function str_QueDesChiffresCurr_Char ( s : String; var key:char;PosSaisie:Integer ) : String;
Function Str_DoucleCar(Chaine,Car:string):string;
Function Str_Count_Str(SubStr,Str:string):integer;
Function str_Suppr_N_Car_ADroite(Str:string;NbCar:integer):string;      // OK
Function str_Suppr_N_Car_AGauche(Str:string;NbCar:integer):string;      // OK
Function str_Suppr_Repetition(Str,StrASupprimer:string):string;
Function str_ImportDosToWin(Text:String):String;
Function str_N_Car_IsNumeric(Text:String;N,LongueurRech:integer):Boolean;
Function Str_StrIsCurr(Text:String):Boolean;
Function Str_StrInt_To_StrCurr(Text:String):string;
Function Str_Mozilla(Text:String):String;
Function Str_QueDesChiffre_Integer(Text:String):String;
Function str_QueDesChiffresCurr ( s : String ) : String;overload;
Function str_QueDesChiffresCurr ( s, FormatChiffre : String ) : String;overload;
Function str_QueDesChiffresCurr_SQL ( s : String ) : String;
Function ChangeDecimalSeparator(Text:String):String;
Function Str_ChangeDecimalSeparatorEx(Text:String;Symbole:Char):String;
Function Str_StringToChaineASCII(Texte:String):String;
Function Str_ChaineToHEXA(Texte:String):String;
Function Str_StrToBool(Valeur,ValVrai,ValFaux:String):Boolean;
Function Str_SingulierToPluriel(Nb:Integer;MotAuSingulier:String):String;overload;
Function Str_SingulierToPluriel(Nb:Integer;MotAuSingulier:String;Affiche:Boolean):String;overload;
Function Str_UpperSQL(Text:String):String;
function str_Setstringelement ( astring : string ; apos : integer; csep : char ;NouvElement : string) : string;
Function Str_PositionVariable(Chaine:String;var PositionChaine:Integer;Var ChaineVariableDep,ChaineVariableFin,ChaineFixe1,ChaineFixe2:String):Boolean;

Function Str_StringAcceptSQL(Text1:String;ListeCaractereNonCorrects:Tstringlist):String;
function RetourListeCaractereNonCorrectString(Source:Tstringlist):Tstringlist;
{ isa  le  04/05/04 }
function StrToInt_Lgr(const S: string; const Default:integer = 0): Integer;
function StrToCurr_Lgr(const S: string; const Default:Currency = 0): Currency;
function StrToBool_Lgr(const S: string; const Default: boolean): boolean;
function StrToDate_Lgr(const S: string; const Default:TDateTime = 0): TDateTime;
function StrToFloat_Lgr(const S: string; const Default: Extended = 0): Extended;
function FloatToStr_Lgr(const S: extended; const Substr: string='0'; const Default: string=''): string;
function IntToStr_Lgr(const S: integer; const Substr: string='0'; const Default: string=''): string;
function CurrToStr_Lgr(const S: Currency; const Substr: string='0'; const Default: string=''): string;
function DateToStr_Lgr(const S: TDateTime; const Substr: string='0'; const Default: string=''): string;
function StrToStr_Lgr(const S: string; const Substr: string=''; const Default: string=''): string;
function StrNbCaractere( const S: string;  Substr: string=''; nb : integer=0;Avant:boolean=true) : string;
function str_remplacesouschaine_1ereOccurence_avecCasse ( str, sub1, sub2 : string ) : string;
function GereLibelle(Value:string ; Const Separateur:string=';'):String;
function IntToStr_Comble(const S: integer;  const Comble: integer): string;
function monSplit(chaine : String; delimiteur : string) : TStringList;
function monSplitArray(chaine : String; delimiteur : string) : TStringArray;
procedure Explode(Chaine: string; Liste : TStringList; Delimiteur: char; ExcludeEmpty: Boolean = False);
procedure ExplodeIncludeDelimiteur(Chaine: string; Liste : TStringList; Delimiteur: char; ExcludeEmpty: Boolean = False);

procedure rempliTstringlist(tab:array of string ; var liste:Tstringlist);
implementation

//uses ;


/////////////////////////////////////////////////////////////////////////--------<<<<<<<<<<<<
function traitementCodeErreur(numErreur:integer):string;
//
begin
  case numErreur of
    1: result := 'Cette zone est obligatoire !';
    11: result := '''O''(oui) ou ''N''(non) obligatoire !';
    2: result := 'Ce code n''existe pas ! (créer ou aide)';
    22: result := 'Ce code est déjà attribué !';
    3: result := 'Autres champs à remplir';
    33: result := 'Erreur de valeur !';
    4: result := 'Modifier autre table';
    5: result := 'pas supprimable: présent dans des écritures';
  end;{case}
end;

// /////////////////////////////////////////////////////////////////////

function str_int2str ( i : integer ) : string;
// retourne la forme chaine de caractere de 'i'
// ex: str_int2str ( 12 ) => '12'
begin
   result := inttostr ( i );
end;

// /////////////////////////////////////////////////////////////////////

function str_str2int ( str : string ) : integer;
// retourne la forme entiere de la chaine de caractere
// renvoie 0 si erreur
// ex: str_str2int ( '12' ) => 12
begin
   try
      result := strtoint ( str );
   except
      result := 0;
   end;
end;

// /////////////////////////////////////////////////////////////////////

function str_bool2str ( booleen : boolean ) : string;
// renvoie 'vrai' si 'true' en entrée sinon renvoie 'faux'
// ex: str_bool2str ( True ) => 'Vrai'
begin
   result := 'false';
   if booleen then
      result := 'true';
end;

// /////////////////////////////////////////////////////////////////////

function str_bool2str_FR ( booleen : boolean ) : string;
// renvoie 'vrai' si 'true' en entrée sinon renvoie 'faux'
// ex: str_bool2str ( True ) => 'Vrai'
begin
   result := 'Faux';
   if booleen then
      result := 'Vrai';
end;
// /////////////////////////////////////////////////////////////////////

Function str_Empty ( Const Value : String ) : Boolean;
// Retourne vrai si la valeur est vide ou pleine d'espace sinon False
// ex: str_Empty ( '           ' ) => True
Var
   i :Integer;
Begin
   Result:= True;
   i:= 1;
   While Result And ( i <= str_Lg ( Value ) ) Do
   Begin
      Result:= ( Value [ i ] <= #32 ) or ( Value [ i ] >= #124 );
      Inc ( i );
   End;
End;

Function str_Empty_Numeric_Format ( Const Value : String ; Const FormatMonnaie : String ) : Boolean;
// Retourne vrai si la valeur est vide, égale à 0 ou pleine d'espace sinon False
// ex: str_Empty ( '           ' ) => True
Var
   i :Integer;
Begin
   Result:= True;
   i:= 1;
   While Result And ( i <= str_Lg ( Value ) ) Do
   Begin
      Result:= ( Value [ i ] <= #32 ) or ( Value [ i ] = decimalseparator ) or ( Value [ i ] = FormatMonnaie )or ( Value [ i ] >= #124 ) or (Value[i]=#48);
      Inc ( i );
   End;
End;

Function str_Empty_Numeric ( Const Value : String ) : Boolean;
// Retourne vrai si la valeur est vide, égale à 0 ou pleine d'espace sinon False
// ex: str_Empty ( '           ' ) => True
Var
   i :Integer;
Begin
   Result:= True;
   i:= 1;
   While Result And ( i <= str_Lg ( Value ) ) Do
   Begin
      Result:= ( Value [ i ] <= #32 ) or ( Value [ i ] = decimalseparator ) or ( Value [ i ] >= #124 ) or (Value[i]=#48);
      Inc ( i );
   End;
End;
// /////////////////////////////////////////////////////////////////////
function str_bool2str_LGR ( booleen : boolean ;ValeurVrai,ValeurFaux:String) : string;
// renvoie 'vrai' si 'true' en entrée sinon renvoie 'faux'
// ex: str_bool2str ( True ) => 'Vrai'
begin
   result := ValeurFaux;
   if booleen then
      result := ValeurVrai;
end;
// /////////////////////////////////////////////////////////////////////

function str_position ( substr , str : string ) : integer;
// renvoie la position de 'substr' dans 'str' si non trouvee alors on renvoie 0
// ex: str_position ( 'o', 'Toto' ) => 2
begin
   result := pos (substr , str);
end;


function str_position_caseInsensitive ( substr , str : string ) : integer;
// renvoie la position de 'substr' dans 'str' si non trouvee alors on renvoie 0
// ex: str_position ( 'o', 'Toto' ) => 2
begin
   result:=pos(LowerCase(substr), LowerCase(str));
end;

// /////////////////////////////////////////////////////////////////////

function str_lg ( str : string ) : integer;
// retourne la longueur de la chaine 'str'
// ex: str_lg ( 'Toto' ) => 4
begin
   result := length ( str );
end;

// /////////////////////////////////////////////////////////////////////

function str_souschaine ( str : string ; pos, nombre : integer ) : string;
// retourne la chaine de caractere inclue dans 'str' étant à la position
// 'pos' et étant de longueur 'num'
// ex: str_souschaine ( 'neuneu', 1, 3 ) => 'neu'
begin
   result := copy ( str, pos, nombre );
end;

// /////////////////////////////////////////////////////////////////////

function str_n_prem_char ( str : string ; n : integer ) : string;
// retourne les n premiers caracteres de la chaine 'str'
// ex: str_n_prem_char ( 'neuneu', 4 ) => 'neun'
begin
   result := str_souschaine ( str, 1, n );
end;

// /////////////////////////////////////////////////////////////////////

function str_n_der_char ( str : string ; n : integer ) : string;
// retourne les n derniers carcteres de la chaine 'str'
// ex: str_n_der_char ( 'neuneu' , 2 ) => 'eu'
var
   i : byte;
begin
   result := str;
   if n < str_lg ( str ) then
   begin
      i := str_lg ( str ) - n + 1;
      result := str_souschaine ( str, i, n )
   end;
end;

// /////////////////////////////////////////////////////////////////////

function str_majuscule ( str : string ) : string;
// renvoie une chaine de caractere en majuscules et supprime les espaces
//avant et après.
// ex: str_majuscule ( ' toto ' ) => 'TOTO'
begin
   result := trim(uppercase ( str ));
end;

// /////////////////////////////////////////////////////////////////////

function str_minuscule ( str : string ) : string;
// renvoie une chaine de caractere en minuscules
// ex: str_majuscule ( 'TOTO' ) => 'toto'
begin
   result := lowercase ( str );
end;

// /////////////////////////////////////////////////////////////////////

function str_minusculechar ( ch : char ) : char;
// tranforme un caractere majuscule en minuscules
// ex: str_majusculeschar ( 'a' ) => 'A'
begin
   case ch of
      'a' .. 'z' : result := chr ( ord ( ch ) + 31 );
   else
      result := ch;
   end;
end;

// /////////////////////////////////////////////////////////////////////

function str_majusculeschar ( ch : char ) : char;
// retourne le caractere majuscule de 'ch'
// ex: str_majusculeschar ( 'a' ) => 'A'
begin
   result := upcase ( ch );
end;

// /////////////////////////////////////////////////////////////////////

function str_duplique ( str: string ; nb : integer ) : string;
// retourne une chaine de caractere contenant 'nb' caractere 'str'
// ex: str_duplique ( 'a', 12 ) => 'aaaaaaaaaaaa'
var
LengthDepart:integer;
begin
LengthDepart:=str_lg (str);
   result := '';
   while str_lg ( result ) < (nb * LengthDepart) do
      result := result + str;
end;

// /////////////////////////////////////////////////////////////////////

function str_supprespaces ( str : string ) : string;
// supprime les espaces supperflus à droite et à gauche de 'str'
// ex: str_supprespacesdroite ( '        Neuneu       ' ) => 'Neuneu'
begin
   result := trim ( str );
end;

// /////////////////////////////////////////////////////////////////////

function str_supprespacesdroite ( str : string ) : string;
// supprime tous les espaces superflus situés à droite de la chaine 'str'
// ex: str_supprespacesdroite ( 'Neuneu       ' ) => 'Neuneu'
begin
   while str_souschaine ( str, str_lg ( str ), 1 ) = ' ' do
      str := str_souschaine ( str, 1, str_lg ( str ) - 1 );
   result := str;
end;

// /////////////////////////////////////////////////////////////////////

function str_supprespacesgauche ( str : string ) : string; // ok
// supprime tous les espaces superflus situés à gauche de la chaine 'str'
// ex: str_supprespacesdroite ( 'Neuneu       ' ) => 'Neuneu'
begin
  result:=TrimLeft(str);
//   while str_souschaine ( str, str_lg ( str ), 1 ) = ' ' do
//      str := str_souschaine ( str, 1, str_lg ( str ) - 1 );
//   result := str;
end;
// /////////////////////////////////////////////////////////////////////

function str_ajouteAdroite ( str, Str2 : string ; lngth : integer) : string;
// concatene Str avec n caractère de Str2
// Si n = 0, tout Str2 est concaténé
begin
result:=concat(str,str2);
if lngth >= 0 then
delete(result,length(str)+lngth+1,length(result));
end;

// /////////////////////////////////////////////////////////////////////

function str_ajouteAgauche ( str, Str2 : string ; lngth : integer) : string;
// insere n caractères de Str2 à gauche de Str
// Si n > -1, tout Str2 est inséré
begin
//result:=StringOfChar(str2,lngth)+str;
result:=concat(str2,str);
if lngth > -1 then
delete(result,lngth+1,length(Str2)-lngth);
//  result := str_souschaine ( str, 1, lngth );
//  while str_lg ( result ) < lngth do
//    result := char + result;
end;

// /////////////////////////////////////////////////////////////////////

function str_ajouteAdroiteAgauche ( str, Str1, Str2 : string ; lngth1,lngth2 : integer ) : string;
// retourne une chaine de caractere contenant 'lngth' caracteres
// en ayant garder que 'lngth' caractere si length ( str ) >= lngth
// ou ayant mis lngth / 2 - length ( str ) espaces en debut et en fin de chaine
// ex: str_padc ( 'bonjour!', 4 ) => 'bonj'
// ex2: str_padc ( 'bonjour!', 12 ) => '  bonjour!  '
//var
//StrAux1,StrAux2:string;
begin
result:=str_ajouteAdroite ( Str,Str2,lngth2);
delete(result,1,length(Str));
result:=str_ajouteAGauche( Str,Str1,lngth1);
//   result := str_souschaine ( str, 1, lngth );
//   while str_lg ( result ) < lngth do
//   begin
//      result := result + char;
//      if str_lg ( result ) < lngth then
//         result := char + result;
//   end;
end;

// /////////////////////////////////////////////////////////////////////

function str_supprespacestout ( str : string ) : string;
// enleve tous les espaces dans une chaine
// ex: str_supprespacestout ( 'toto mange' ) => 'totomange'
var
   index : byte;
   instring : boolean;
begin
   instring := false;
   result := '';
   for index := 1 to str_lg ( str ) do
   begin
      if instring or ( str [ index ] in [ #33 .. #126 ] ) then
         result := str_concat ( result, str [ index ] );
      instring := ( ( str [ index ] = '''' ) and ( str [ index - 1 ] <> '\' ) )
                  xor instring;
   end;
end;

// /////////////////////////////////////////////////////////////////////

function str_avant_nb ( str, substr : string ; nb : integer ) : string;
// retourne la chaine précédant la chaine recherchée 'find' en extrayant 'nb' caracteres
// ex : apres ( 'tototatatiti', 'tata', 2 ) = 'to'
begin
   result := str_souschaine ( str_avant ( str, substr ), 1, nb );
end;

// /////////////////////////////////////////////////////////////////////

function str_avant ( str, substr : string ) : string;
// retourne la chaine précédent la chaine recherchée 'find'
// ex : avant ( 'tototatatiti', 'tata' ) = 'toto'
begin
   result := str_souschaine ( str, 1, str_position ( substr, str ) - 1 );
   if str_position ( substr, str ) = 0 then result := str;
end;

// /////////////////////////////////////////////////////////////////////

function str_apres (str , substr : string ) : string;
// retourne la chaine suivant la chaine recherchée 'find'
// ex : apres ( 'tototatatiti', 'tata' ) = 'titi'
begin
   result := str_souschaine ( str, str_position (substr ,str  ) + str_lg ( substr ),length(trim(str)));
   if str_position (substr ,str  ) = 0 then result := '';
end;

// /////////////////////////////////////////////////////////////////////

function str_apres_nb ( str, substr : string ; nb : integer ) : string;
// retourne la chaine suivant la chaine recherchée 'find' en extrayant 'nb' caracteres
// ex : apres ( 'tototatatiti', 'tata', 2 ) = 'ti'
begin
   result := str_souschaine ( str_apres ( str, substr ), 1, nb );
end;

// /////////////////////////////////////////////////////////////////////

//function str_recherchesouschaine ( source, pattern : string ) : boolean;
//// compare une chaine de caractere 'source' avec une autre chaine 'pattern'
//// 'source' ne peut contenir des caracteres generiques * ou ? contrairement
//// à 'pattern'. on peut par exemple chercher '*ne?' dans la chaine 'neuneu'
//// la fonction retournera true si '*une?' est inclue dans 'neuneu' sinon false
//// ex: str_recherchesouschaine ( 'neuneu', '*une?' ) => True
//// ex2: str_recherchesouschaine ( 'neuneu', '?une?' ) => False
//var
//   psource : array [ 0 .. 255 ] of char;
//   ppattern : array [ 0 .. 255 ] of char;
//   function matchpattern ( element, pattern : pchar ) : boolean;
//      function ispatternwild ( pattern : pchar ) : boolean;
//      begin
//         result := strscan ( pattern, '*' ) <> nil;
//         if not result then result := strscan ( pattern, '?' ) <> nil;
//      end;
//   begin
//   //result:=false;{ isa  le  10/02/04 }
//      if 0 = strcomp ( pattern, '*' ) then result := true
//      else if ( element^ = chr ( 0 ) ) and ( pattern^ <> chr ( 0 ) ) then
//         result := false
//      else if element^ = chr ( 0 ) then result := true
//      else begin
//         case pattern^ of
//         '*' : if matchpattern ( element, @pattern [ 1 ] ) then
//                  result := true
//               else
//                  result := matchpattern ( @element [ 1 ], pattern );
//         '?' : result := matchpattern ( @element [ 1 ], @pattern [ 1 ] );
//         else
//            if element^ = pattern^ then
//               result := matchpattern ( @element [ 1 ], @pattern [ 1 ] )
//            else
//               result := false;
//         end;
//      end;
//   end;
//begin
//   strpcopy ( psource, source );
//   strpcopy ( ppattern, pattern );
//   result := matchpattern ( psource, ppattern );
//end;

// /////////////////////////////////////////////////////////////////////
function str_recherchesouschaine ( source, pattern : string ) : RetourPosition;
// compare une chaine de caractere 'source' avec une autre chaine 'pattern'
// 'source' ne peut contenir des caracteres generiques * ou ? contrairement
// à 'pattern'. on peut par exemple chercher '*ne?' dans la chaine 'neuneu'
// la fonction retournera true si '*une?' est inclue dans 'neuneu' sinon false
// ex: str_recherchesouschaine ( 'neuneu', '*une?' ) => True
// ex2: str_recherchesouschaine ( 'neuneu', '?une?' ) => False
var
   psource : array [ 0 .. 255 ] of char;
   ppattern : array [ 0 .. 255 ] of char;
//   Depart:integer;
   function matchpattern ( element, pattern : pchar;var Increment:integer ) : boolean;
//   var
//     i:integer;
      function ispatternwild ( pattern : pchar ) : boolean;
      begin
         result := strscan ( pattern, '*' ) <> nil;
         if not result then result := strscan ( pattern, '?' ) <> nil;
      end;
   begin
   //result:=false;{ isa  le  10/02/04 }
//   i:=Increment;
      if 0 = strcomp ( pattern, '*' ) then result := true
      else if ( element^ = chr ( 0 ) ) and ( pattern^ <> chr ( 0 ) ) then
         result := false
      else if element^ = chr ( 0 ) then result := true
      else begin
         case pattern^ of
         '*' : if matchpattern ( element, @pattern [ 1 ],increment ) then
                  result := true
               else
                  result := matchpattern ( @element [ 1 ], pattern,increment );
         '?' : result := matchpattern ( @element [ 1 ], @pattern [ 1 ],increment );
         else
           begin
            if element^ = pattern^ then
               result := matchpattern ( @element [ 1 ], @pattern [ 1 ],increment )
            else
               result := false;
           inc(increment);
           end;
         end;
      end;
   end;
begin
   strpcopy ( psource, source );
   strpcopy ( ppattern, pattern );
   result.Position:=0;
   result.retour := matchpattern ( psource, ppattern,result.Position );
//   result.Position:=length(source)-length(string(Psource));
end;
// /////////////////////////////////////////////////////////////////////

function str_chiffreenlettre ( n : integer ) : string;
// transforme un nombre chiffré en son homologue lettré
// ex: 12 => douze
const
   unite : array [ 1 .. 16 ] of string = ( 'un', 'deux', 'trois', 'quatre',
                                           'cinq', 'six','sept', 'huit',
                                           'neuf', 'dix', 'onze', 'douze',
                                           'treize', 'quatorze', 'quinze', 'seize' );
   dizaine : array [ 2 .. 8 ] of string = ( 'vingt', 'trente', 'quarante', 'cinquante',
                                            'soixante', '', 'quatre-vingt' );
   coefs : array [ 0 .. 3 ] of string = ( 'cent', 'mille', 'million', 'milliard');
var
   temp : string;
   c,
   d,
   u,
   coef : byte;
   i : word;
   neg : boolean;
begin
   if n = 0 then begin
      result := 'zero';
      exit;
   end;
   result := '';
   neg := n < 0;
   if neg then n := -n;
   coef := 0;
   repeat
      u := n mod 10; n := n div 10; // récupère unité et dizaine
      d := n mod 10; n := n div 10; // récupère dizaine
      c := n mod 10; n := n div 10; // récupère centaine
      if d in [ 1, 7, 9 ] then
      begin
         dec ( d );
         inc ( u, 10 );
      end;
      temp := '';
      if d > 1 then
      begin
         temp := ' ' + dizaine [ d ];
         if ( d < 8 ) and ( ( u = 1 ) or ( u = 11 ) ) then
            temp := temp + ' et';
      end;
      if u > 16 then begin
         temp := temp + ' ' + unite [ 10 ];
         dec ( u, 10 );
      end;
      if u > 0 then
         temp := temp + ' ' + unite [ u ];
      if ( result = '' ) and ( d = 8 ) and ( u = 0 ) then
         result := 's';
      result := temp + result;
      if c > 0 then
      begin
         temp := '';
         if c > 1 then
            temp := ' ' + unite [ c ] + temp;
         temp := temp + '  ' + coefs [ 0 ] ;
         if ( result = '' ) and ( c > 1 ) then
            result := 's';
         result := temp + result;
      end;
      if n > 0 then
      begin
         inc ( coef );
         i := n mod 1000;
         if ( i > 1 ) and ( coef > 1 ) then
            result := 's' + result;
         if i > 0 then
            result := ' ' + coefs [ coef ] + result;
         if ( i = 1 ) and ( coef = 1 ) then
            dec ( n );
      end;
   until n = 0;
   if neg then
      result := 'moins' + result
end;

// /////////////////////////////////////////////////////////////////////

function str_remplacesouschaine ( str, sub1, sub2 : string ) : string;
// remplace dans la chaine 'str' toutes les occurences
// de la chaine 'sub1' par la chaine 'sub2'
// ex: str_remplacesouschaine ( 'Toto marche', 'marche', 'cours' ) => 'Toto cours'
var i:integer;
begin
   result := Str;
   while str_position (sub1 ,result) > 0 do begin
     i := str_position (sub1 ,Result);
     delete(Result,i,length(sub1));
     insert(sub2,Result,i);
//      result := result + str_souschaine ( str, 1, str_position ( sub1, str ) - 1 ) + sub2;
//      delete ( str, str_position (sub1 ,str  ) + str_lg ( sub1 ) - 1 , 1);
   end;
end;

// /////////////////////////////////////////////////////////////////////

function str_casse_maj_sep ( source, separateur : string ) : string;
// passe en majuscules la premiere lettre de toutes
// les parties de la chaine 'source' qui se situent
// apres le caractere 'separateur'
// ex: proper_sep ( 'toto mange', ' ' ) => 'Toto Mange'
var
   str : string;
   lastwasseparator : boolean;
   ndx : integer;
begin
   str := source;
   lastwasseparator := true;
   for ndx := 1 to str_lg ( source ) do
   begin
     if lastwasseparator then
        source [ ndx ] := str_majusculeschar ( source [ ndx ] )
     else
        source [ ndx ] := str_minusculechar ( source [ ndx ] );
     lastwasseparator := str_position ( source [ ndx ], separateur ) > 0;
   end;
   result := source;
end;

// /////////////////////////////////////////////////////////////////////

function str_casse_maj ( str : string ) : string;
// retourne une chaine de caractere 'str' avec la casse :
// la premiere lettre de chaque mot est en majuscule et toutes les autres
// en minuscules
// ex: str_casse_maj ( 'toto mange' ) => 'Toto Mange'
var
   t : string;
   i : integer;
   newword : boolean;
begin
   result := '';
   if str = '' then exit;
   result := str_minuscule ( str );
   t := str_majuscule ( result );
   newword := true;
   for i := 1 to str_lg ( result ) do
   begin
      if newword and ( result [ i ] in [ 'a' .. 'z' ] ) then
      begin
         result [ i ] := t [ i ];
         newword := false;
         continue;
      end;
      if str [ i ] in [ 'a' .. 'z', '''' ] then continue;
      newword := true;
   end;
end;

// /////////////////////////////////////////////////////////////////////

function Str_min_comp ( str1, str2 : string ) : string;
// retourne la chaine la plus petite
// ex: Str_min_comp ( 'Moi', 'Toi' ) => 'Moi'
begin
  if str1 < str2 then
     result := str1
  else
     result := str2;
end;

// /////////////////////////////////////////////////////////////////////

function str_max_comp ( str1, str2 : string ) : string;
// retourne la chaine la plus grande
// ex: Str_max_comp ( 'Moi', 'Toi' ) => 'Toi'
begin
  if str1 > str2 then
     result := str1
  else
     result := str2;
end;

// /////////////////////////////////////////////////////////////////////

function str_commence_par ( str, substr : string ) : boolean;
// retourne vrai si 'str' commence par 'substr' sinon retourne faux
// Rq : La casse est prise en compte // !!!! non, elle ne respecte plus la casse !!!!!
// ex: str_commence_par ( 'Bonjour toto!', 'Bon' ) => True
//var
//   lg_sub,
//   lg_str: integer;
begin
result:=pos(Substr,Str) = 1;
//   lg_sub := str_lg ( substr );
//   lg_str := str_lg ( str );
//   result := false;
//   if ( lg_str >= lg_sub ) and ( str_souschaine ( str, 1, lg_sub ) = substr ) then
//      result := true;
end;

// /////////////////////////////////////////////////////////////////////

function str_fini_par ( str, substr : string ) : boolean;
// retourne vrai si 'str' se fini par 'substr' sinon retourne faux
// Rq : la casse est prise en compte
// ex: str_fini_par ( 'Bonjour toto!', '!' ) => True
var
   lg_str,
   lg_sub : integer;
begin
   lg_sub := str_lg ( substr );
   lg_str := str_lg ( str );
   result := false;
   if ( lg_str > lg_sub ) and
      ( str_souschaine ( str, ( lg_str + 1 ) - lg_sub, lg_sub ) = substr ) then
      result := true;
end;

// /////////////////////////////////////////////////////////////////////

function str_delimite ( str, debut, fin : string ) : string;
// retourne la chaine qui se situe strictement entre les caracteres
// 'debut' et 'fin'
// ex: str_delimite ( 'toto a mange', 'o', 'ge' ) => 'to a man'
var
   temp : string;
   tmp1,
   tmp2 : integer;
begin
   temp := str;
   result :='';
   tmp1 := str_position ( debut, temp );
   if tmp1 > 0 then
   begin
      temp := str_souschaine ( temp, tmp1 + str_lg ( debut ), str_lg ( temp ) );
      tmp2 := str_position ( fin, temp );
      if tmp2 > 0 then
         result := str_souschaine ( temp, 1, tmp2 - 1 );
   end;
end;

// /////////////////////////////////////////////////////////////////////

function str_concat ( str1, str2 : string ) : string;
// retourne la chaine de concaténation str1 + str2
// ex: str_concat ( 'Toto ', 'mange' ) => 'Toto mange'
// Rq: Attention à la longueur ( < 255 )
begin
   result := '';
   if str_lg ( str1 ) + str_lg ( str2 ) <= 255 then
      result := str1 + str2;
end;

// /////////////////////////////////////////////////////////////////////

function str_telephonea10chiffre ( ancientel, aposte : string ) : string;
// transforme un num de tel à 8 chiffres en 10 chiffres avec mise en forme
//var
//   l,
//   d,
//   n,
//   p,
//   typenumero : integer;
//   chiffres : array [ 1 .. 20 ] of char;
//   tel8 :string [ 12 ];
begin
//   l:= str_lg ( ancientel );
//   n:= l;
//   p:= 0;
//   while ( n > 0 ) and ( p < 20 ) do
//   begin
//      if ancientel [ n ] in [ '0' .. '9' ] then
//      begin
//         inc ( p );
//         chiffres [ p ] := ancientel [ n ];
//      end;
//      dec ( n );
//   end;
//   if p >= 8 then
//   begin
//      if p = 8 then typenumero := 1
//      else begin
//         if p = 9 then
//             n:= str_str2int ( chiffres [ 9 ] )
//         else if p = 10 then
//             n:= str_str2int ( chiffres [ 10 ] + chiffres [ 9 ] )
//         else
//             n:= str_str2int ( chiffres [ 11 ] + chiffres [ 10 ] + chiffres [ 9 ] );
//         if ( p = 10 ) and ( n in [ 1 .. 6, 8 ] ) then typenumero:= 3
//         else if ( ( p = 9 ) and ( chiffres [ 9 ] = '1' ) ) or ( ( p = 11 ) and ( n = 161 ) ) then
//            typenumero:= 2
//         else
//         begin
//            n := str_str2int ( chiffres [ p ] + chiffres [ p - 1 ] );
//            if n = 19 then
//               if ( p = 11 ) and ( n in [ 590, 594, 596, 262, 508, 269 ] ) then
//                  typenumero := 4
//               else
//                  typenumero := 5
//            else
//               typenumero:= 6;
//         end;
//      end;
//      tel8 := chiffres [ 8 ] + chiffres [ 7 ] + ' '
//            + chiffres [ 6 ] + chiffres [ 5 ] + ' '
//            + chiffres [ 4 ] + chiffres [ 3 ] + ' '
//            + chiffres [ 2 ] + chiffres [ 1 ];
//   end
//   else
//      typenumero := 6;
//   if typenumero = 1 then
//   begin
//      // province
//      n:= str_str2int ( chiffres [ 8 ] + chiffres [ 7 ] );
//      if n = 9 then
//         result:= '06 ' + tel8
//      else if n = 5 then
//         result:= '08 00 ' + copy ( tel8, 4, 8 )
//      else
//         if n = 36 then
//         begin
//            if ( chiffres [ 8 ] = '6' ) and ( chiffres [ 7 ] = '3' ) then
//               result:= '08  ' + tel8
//            else
//               result:= '08 ' + tel8;
//         end
//      else
//         begin
//            try
//               d := str_str2int ( copy ( aposte, 1, 2 ) ); // departement
//            except
//               d := 0;
//            end;
//            if d in [ 75, 78, 91 .. 95 ] then
//               result := '01 ' + tel8
//            else if ( n in [ 31 .. 33, 35 .. 41, 43, 47, 48, 51, 54, 96 .. 99 ] ) then
//               result := '02 ' + tel8
//            else if ( n in [ 20 .. 29, 44, 60, 80..89 ] ) then
//               result:= '03 ' + tel8
//            else if ( n in [ 42, 50, 66 .. 79, 90 .. 95 ] ) then
//               result:= '04 ' + tel8
//            else if ( n in [ 34, 45, 46, 49, 53, 55 .. 59, 61 .. 65 ] ) then
//               result:= '05 ' + tel8;
//         end;
//   end
//   // ile de france
//   else if typenumero = 2 then
//      result := '01 ' + tel8
//   // numero déjat a 10 chiffres
//   else if typenumero = 3 then
//      result :=  chiffres [ 10 ] + chiffres [ 9 ] + ' ' + tel8
//   // dom
//   else if typenumero = 4 then
//      result :=  '0' + chiffres [ 9 ] + ' ' + tel8
//   else
//   begin
//      // tom ou etranger
//      if typenumero = 5 then
//         result :=  '00' + copy ( ancientel, 3, l )
//      // ?
//      else
//         result :=  ancientel;
//      for n := 1 to l do
//         if not ( result [ n ] in [ '0' .. '9' ] ) then
//            result [ n ] := ' ';
//
//  end;
end;

// /////////////////////////////////////////////////////////////////////

//******************************************************************************
function str_getstringelement ( astring : string ; apos : integer; csep : char ) : string;
//Function GetStringElement(aString :String; aPos :Integer; cSep :Char) :String;
// Retourne le mot dans une liste suivant la position demandée ex:
// GetStringElement('aaa;zzzz;eeee;',2,';'); retourne 'zzzz'
Var
	i, d, lg :Integer;
Begin

	lg:= Length(aString);
	d:= 1;
	i:= 1;
	While (d < aPos) And (i < lg) do
	Begin
		if (aString[i] = cSep) Then Inc(d);
		Inc(i);
	End;

	If (d = aPos) then
	Begin
		d:= i;
		While (i <= lg) do
		Begin
			if (aString[i] = cSep) Then Break;
			Inc(i);
		End;
		Result:= Copy(aString, d, (i-d));
	End
	Else Result:= '';
End;

//function str_getstringelement ( astring : string ; apos : integer; csep : char ) : string;
//// retourne le mot dans une liste suivant la position demandée ex:
//// ex: getstringelement('aaa;zzzz;eeee;',2,';') retourne 'zzzz'
//var
//   i,
//   d,
//   lg : integer;
//begin
//   lg := str_lg ( astring );
//   d := 1;
//   i := 1;
//   while ( d < apos ) and ( i < lg ) do
//      if astring [ i ] = csep then
//      begin
//         inc ( d );
//         inc ( i );
//      end;
//   if d = apos then
//   begin
//     d := i;
//     while i <= lg do
//     begin
//        if astring [ i ] = csep then
//        begin
//           break;
//           inc ( i );
//        end;
//        result:= str_souschaine ( astring, d, i - d );
//     end ;
//   end
//     else
//        result:= '';
//end;

// /////////////////////////////////////////////////////////////////////

Function str_QueDesChiffres ( s : String ) : String;
// Accepte que des chiffres et - . si - en premier caractère on ajoute 0 = 0.121
// Si un 1er caractère est un - et le 2ème un . on ajoute 0 entre deux = -0.121
// Si le dernier caractère est un . on l'efface
// Si il y a plus d'un separateur Decimal on efface 0..22 ou 0.2.2 =0.22
// Ex: Edit1.text:= QueDesChiffres(Edit1.text); 18/04/00
Var
   i : Integer;
   Unpoint : boolean;
Begin
   Result := '';
   Unpoint := False ;
   if str_Lg ( s ) = 0 then exit;
   For i := 1 to str_lg ( s ) do
      // Accepte de 0 à 9 et - .
      if ( s [ i ] in [ '0' .. '9', DecimalSeparator ] ) or
         ( ( i = 1 ) And ( s [ i ] = '-' ) ) then
         Result := Result + s [ i ];
   // Si un 1er caractère est un . on ajoute 0 avant
   if str_souschaine ( result, 1, 1 ) = DecimalSeparator then
      insert ( '0', result, 1 );
   // Si un 1er caractère est un - et le 2ème un . on ajoute 0 entre deux -0.2
   if ( str_souschaine ( result, 1, 1 ) = '-' ) and ( str_souschaine ( result, 2, 1 ) = DecimalSeparator ) then
      insert ( '0', result, 2 );
   // Si le dernier caractère est un . on l'efface
   if ( result [ str_lg ( result ) ] = DecimalSeparator ) then
      Delete ( result, str_lg ( result ), 1 );
   // Si il y a plus d'un DecimalSeparator on efface
   for i := 1 to str_lg ( result ) do
   begin
      if ( Unpoint = true ) and ( result [ i ] = DecimalSeparator ) then
         delete ( result, i, 1 );
      if ( Unpoint = False ) and ( result [ i ] = DecimalSeparator ) then
         Unpoint:=true ;
   End;
End;

Function str_QueDesChiffresCurr_Char ( s : String; var key:char; PosSaisie:Integer ) : String;
Var
   i : Integer;
//   Unpoint : boolean;
Begin
   for i := 1 to str_lg ( s ) do
   begin
      if ( s [ i ] = DecimalSeparator ) then
       begin
         if key = decimalSeparator then key:=#0;
         if ((length(Trim(copy(s,i+1,2))) > 1) and (PosSaisie >=i)) then
                  if not (key in [#27,#8,#9]) then key:=#0;
       end;
   End;
End;

Function str_QueDesChiffresCurr_SQL ( s : String ) : String;
Var
   i : Integer;
//   Unpoint : boolean;
Begin
 result:=str_QueDesChiffresCurr(s);
 for i := 1 to str_lg ( result ) do
 begin
    if ( result [ i ] = DecimalSeparator ) then
     begin
       result [ i ] := '.';
     end;
 End;

End;

Function str_QueDesChiffresCurr ( s, FormatChiffre : String ) : String;
Begin
result:=str_QueDesChiffresCurr(s);
result:=FormatCurr(FormatChiffre,StrToCurr_lgr(result));
End;


Function str_QueDesChiffresCurr ( s : String ) : String;
// Accepte que des chiffres et - . si - en premier caractère on ajoute 0 = 0.121
// Si un 1er caractère est un - et le 2ème un . on ajoute 0 entre deux = -0.121
// Si il y a plus d'un separateur Decimal on efface 0..22 ou 0.2.2 =0.22
// Ex: Edit1.text:= QueDesChiffres(Edit1.text); 18/04/00
Var
   i : Integer;
   Unpoint : boolean;
Begin
   Result := '';
   Unpoint := False ;
   if str_Lg ( s ) = 0 then exit;
   For i := 1 to str_lg ( s ) do
      // Accepte de 0 à 9 et - .
      if (s[i] in ['0'..'9',DecimalSeparator]) or
         ( ( i = 1 ) And ( s [ i ] = '-' ) ) then
         Result := Result + s [ i ];
   if( result<>'') then
   begin
   // Si un 1er caractère est un . on ajoute 0 avant
   if str_souschaine ( result, 1, 1 ) = DecimalSeparator then
      insert ( '0', result, 1 );

   // Si un 1er caractère est un - et le 2ème un . on ajoute 0 entre deux -0.2
   if ( str_souschaine ( result, 1, 1 ) = '-' ) and ( str_souschaine ( result, 2, 1 ) = DecimalSeparator ) then
      insert ( '0', result, 2 );

   // Si le dernier caractère est un . on ajoute 2 zero
   if (result [ str_lg ( result ) ] = DecimalSeparator ) then
      result := result + '00';

   // Si l'avant dernier caractère est un . on ajoute 1 zero
   if (  result [ str_lg ( result )-1 ] = DecimalSeparator ) then
      result := result + '0';

   // Si l'avant dernier caractère est un . on ajoute 1 zero
   if ( pos(DecimalSeparator,result) = 0 ) then
      result := result + DecimalSeparator + '00';

   // Si il y a plus d'un DecimalSeparator on efface
   for i := 1 to str_lg ( result ) do
   begin
      if ( Unpoint = true ) and ( result [ i ] = DecimalSeparator ) then
         delete ( result, i, 1 );
      if ( Unpoint = False ) and ( result [ i ] = DecimalSeparator ) then
         Unpoint:=true ;
   End;
   end;
   Result := Trim(Result);
End;


Function Str_DoucleCar(Chaine,Car:string):string;
var
i:integer;
Begin
i:=0;
result:=chaine;
while i < length(result) do
 begin
  inc(i);
  if result[i] = Car then
   begin
    insert(car,result,i);
    inc(i);
   end;
 end;

End;

Function Str_Count_Str(SubStr,Str:string):integer;
// Compte combien  de fois existe SubStr dans Str
//var
//i:integer;
Begin
  try
    result:=0;
    While pos(SubStr,Str) > 0 do
     begin
       inc(result);
       delete(Str,pos(SubStr,Str),length(SubStr));
     end;
  except;
   result:=0;
  end;
End;


Function str_Suppr_N_Car_ADroite(Str:string;NbCar:integer):string;
var
index:integer;
Begin
result:=Str;
index:=length(str)-NbCar+1;
delete(Result,index,NbCar);
End;

Function str_Suppr_N_Car_AGauche(Str:string;NbCar:integer):string;
Begin
result:=Str;
delete(Result,1,NbCar);
End;

Function str_Suppr_Repetition(Str,StrASupprimer:string):string;
// Supprime les répétitions présente dans Str
// Ex: ' totooo'  -> toto avec StrASupprimer = 'o'
// mais 'totooo, avec StrASupprimer = 'oo' ne change pas -> totooo
// Ex : '16///3' -> 16/3 avec StrASupprimer = '/'
var
S:string;
lgStrASupprimer,i:integer;
Begin
S:=Str;
lgStrASupprimer:=length(StrASupprimer);
i:=lgStrASupprimer+1;
result:=str_n_prem_char(str,lgStrASupprimer);
while i <= length(S) do
 begin
   if copy(Str,i,lgStrASupprimer) <> StrASupprimer then
   result:=result+copy(Str,i,lgStrASupprimer)
   else
   if copy(result,i-lgStrASupprimer,lgStrASupprimer) <> StrASupprimer then
   result:=result+copy(Str,i,lgStrASupprimer);
   inc(i,lgStrASupprimer);
 end;
End;

Function str_ImportDosToWin(Text:String):String;
var
i:integer;
Begin
result:=text;
for i:=0 to length(result)-1 do
 case ord(result[i]) of
    130:result[i]:=chr(233);// é
    133:result[i]:=chr(224);// à
    136:result[i]:=chr(234);// ê
    135:result[i]:=chr(231);// ç
    138:result[i]:=chr(232);// è
    147:result[i]:=chr(244);// ô
 end;

End;

// retourne vrai si Text contient N caractère numérique en cherchant
// uniquement sur la longueur désirée LongueurRech
// Si LongueurRech > length(Text) alors on fait la vérif uniquement sur la
// longueur effective de text
Function str_N_Car_IsNumeric(Text:String;N,LongueurRech:integer):Boolean;
var
I,J,NNumeric:integer;
Begin
result:=false;
NNUmeric:=N;
I:=LongueurRech;
if I > length(text) then I:=length(text);
for J:=1 to I do
 Begin
   if (text[j] in [ '0' .. '9']) then
    begin
     Dec(NNUmeric);
    end;
 End;
result:=(NNUmeric=0); // Si NNUmeric =  alors on à trouvé N chiffres sur la longuer de texte parcourue !
End;

Function Str_StrIsCurr(Text:String):Boolean;
var
I,J,Deb,NNumeric:integer;
TextTmp:String;
DecimalText:Boolean;
Begin
TextTmp:=str_supprespacestout(Text);
I:=length(textTmp)-1;
NNumeric := I;
Deb := 1;
DecimalText:=False;
if I > 0 then
 if textTmp[1] in ['-','+'] then
  begin
   Deb:=2;
   Dec(NNUmeric);
  end;
for J:=Deb to I do
 Begin
   if (textTmp[j] in [ '0' .. '9',DecimalSeparator]) then
    begin
     Dec(NNUmeric);
    end;
   if (textTmp[j] in [DecimalSeparator]) then
    begin
     DecimalText:=true;
    end;
 End;
result:=((NNUmeric=0) and (DecimalText=True)); // Si NNUmeric =  alors on à trouvé N chiffres sur la longuer de texte parcourue !
End;

Function Str_StrInt_To_StrCurr(Text:String):string;
var
i:integer;
DecimalText:Boolean;
TextFin:string;
Begin
DecimalText:=false;
for i:=1 to length(text) do
   if (text[i] in [DecimalSeparator]) then
    begin
     DecimalText:=true;
     if i = length(Text) then TextFin:='00';
    end;
if not DecimalText then result:=text+DecimalSeparator+'00';
End;

Function Str_Mozilla(Text:String):String;
Begin
result:=str_remplacesouschaine(text,'\','/');
result:=str_remplacesouschaine(result,' ','%20');
End;

Function Str_QueDesChiffre_Integer(Text:String):String;
var
i:integer;
Begin
result:='';
for i:=1 to length(text) do
   if (text[i] in ['0'..'9']) then
    begin
     Result:=result+text[i];
    end;
End;

Function ChangeDecimalSeparator(Text:String):String;
var
i:integer;
Begin
result:=Text;
for i:=1 to length(Result) do
   if (text[i] in ['.',',']) then
    begin
     Result[i]:=DecimalSeparator;
    end;
end;

// Change le décimalSeparator par le symbole // PB le 27/09/03
Function Str_ChangeDecimalSeparatorEx(Text:String;Symbole:Char):String;
var
i:integer;
Begin
result:=Text;
for i:=1 to length(Result) do
   if (text[i] = DecimalSeparator) then
    begin
     Result[i]:=Symbole;
    end;
end;

Function Str_StringToChaineASCII(Texte:String):String;
var
i:integer;
Begin
for i:=1 to length(texte) do
 result:=result+IntToStr(Ord(texte[i]));
End;


Function Str_ChaineToHEXA(Texte:String):String;
var
i:integer;
Begin
for i:=1 to length(texte) do
 begin
   result:=result+IntToHex(Ord(texte[i]),2);
 end;

End;

Function Str_StrToBool(Valeur,ValVrai,ValFaux:String):Boolean;
Begin
result :=False;
if Uppercase(Valeur) = UpperCase(ValVrai) then result :=true;
if Uppercase(Valeur) = UpperCase(ValFAux) then result :=False;
End;

Function Str_SingulierToPluriel(Nb:Integer;MotAuSingulier:String):String;
Begin
result:=' '+IntToStr(Nb)+' '+MotAuSingulier+' ';
if Nb > 1 then result:=' '+IntToStr(Nb)+' '+MotAuSingulier+'s ';
End;

Function Str_SingulierToPluriel(Nb:Integer;MotAuSingulier:String;Affiche:Boolean):String;
Begin
result:=' '+MotAuSingulier+' ';
if Nb > 1 then result:=' '+MotAuSingulier+'s ';
End;

Function Str_UpperSQL(Text:String):String;
var
i, Decalage:integer;
Begin
//Text:=AnsiQuotedStr(Text,'''');
//delete(Text,1,1);
//delete(Text,length(text)-1,1);
if not str_Empty(Text)then
    begin
    result := UpperCase(Text);
    Decalage:=0;
      for i:=0 to length(Text) do
         begin
          if Text[i] in ['é','ê','è','â','à','û','ù','ô',''''] then
           begin
            if Text[i] in ['é','ê','è'] then Result[i+Decalage] :='E';
            if Text[i] in ['â','à'] then Result[i+Decalage] :='A';
            if Text[i] in ['û','ù'] then Result[i+Decalage] :='U';
            if Text[i] in ['ô'] then Result[i+Decalage] :='O';
        //    if Text[i] in [''''] then
        //         begin
        //          Result[i+Decalage] :='''';
        //          inc(Decalage);
        //         end;
        //    if Text[i] in ['é','ê','è'] then Result := Result+'E';
        //    if Text[i] in ['â','à'] then Result :=Result+'A';
        //    if Text[i] in ['û','ù'] then Result :=Result+'U';
        //    if Text[i] in ['ô'] then Result :=Result+'O';
        //    if Text[i] in [''''] then
        //         begin
        //          Result:=Result+'''''';
        //         end;
           end;
        //  else
        //   begin
        //    Result :=Result+ uppercase(Text[i]);
        //   end;
         end;
    end;
End;



function str_Setstringelement ( astring : string ; apos : integer; csep : char ;NouvElement : string) : string;
//Function SetStringElement(aString :String; aPos :Integer; cSep :Char ;NouvElement : string) :String;
// Change le mot dans une liste suivant la position demandée Par le nouvel element ex:
// SetStringElement('aaa;zzzz;eeee;',2,';', 'Toto'); retourne 'aaa;Toto;eeee;'
Var
	i, d, lg :Integer;
  Partie1,Partie2:string;
Begin

	lg:= Length(aString);
	d:= 1;
	i:= 1;
	While (d < aPos) And (i < lg) do
	Begin
		if (aString[i] = cSep) Then Inc(d);
		Inc(i);
	End;

	If (d = aPos) then
	Begin
		d:= i;
		While (i <= lg) do
		Begin
			if (aString[i] = cSep) Then Break;
			Inc(i);
		End;
    delete(astring,d,(i-d));
    partie1:=Copy(aString, 1, d-1);
    partie2:=Copy(aString, d,length(astring)-length(partie1));
    result:=Partie1+NouvElement+Partie2;
	End
	Else Result:= '';
End;

// Paramètres :
// "Chaine" est la chaine à analyser, ex: +RN_A2_1_1:RN_A2_12_1
// "Position" retourne la position de la chaine variable
// "ChaineVariableDep" retourne la chaine de départ, ex : 1
// "ChaineVariableFin" retourne la chaine de fin, ex : 12
// "ChaineFixe1" retourne la chaine fixe du coté gauche
// "ChaineFixe2" retourne la chaine fixe du coté droit
Function Str_PositionVariable(Chaine:String;var PositionChaine:Integer;Var ChaineVariableDep,ChaineVariableFin,ChaineFixe1,ChaineFixe2:String):Boolean;
var
i,j:integer;
Chaine1,Chaine2:string;
Begin
result:=false;
if length(Chaine) > 0 then
 begin
  i:=1;
  if str_n_prem_char(Chaine,i) = '+' then
   delete(chaine,1,1);
  if str_n_prem_char(Chaine,i) = '-' then
   delete(chaine,1,1);

  Chaine1 := Chaine;
  delete(Chaine1,str_position(':',Chaine1),Length(Chaine1));

  Chaine2 := Chaine;
  delete(Chaine2,1,str_position(':',Chaine2));

  // Partie gauche
//  while str_n_prem_char(Chaine1,i) = str_n_prem_char(Chaine2,i) do
//   begin
//    inc(i);
//   end;
//  // On récupère uniquement la parti gauche jusqu'au séparateur
//  j:=1;
//  while str_souschaine(Chaine1,j,1) <> '_' do
//   begin
//    inc(j);
//   end;
//  // On récupère ici la première partie commune
//  ChaineFixe1:=str_n_prem_char(Chaine,i);
//  while str_n_der_char(ChaineFixe1,1) <> '_' do
//   delete(ChaineFixe1,length(ChaineFixe1),1);
////   dec(i);
////  ChaineFixe1:=str_n_prem_char(Chaine,i-j+1);
  i:=0;
  j:=1;
  while ((i < 2) and (j < length(Chaine1))) do
   begin
    if Chaine1[j] = '_' then inc(i);
    inc(j);
   end;
  ChaineFixe1:=str_n_prem_char(Chaine1,j-1);
  PositionChaine := j;

  // Partie droite
//  i:=1;//length(Chaine1);
//  j:=1;//length(Chaine2);
//  while str_n_der_char(Chaine1,i) = str_n_der_char(Chaine2,i) do
//   begin
//    inc(i);
////    inc(j);
//   end;
//  // On récupère uniquement la parti droite depuis le séparateur
//  j:=length(Chaine2)-i+1;
//  while str_souschaine(Chaine2,j,1) <> '_' do
//   begin
//    inc(j);
//   end;
//  ChaineFixe2 :=str_n_der_char(Chaine2,length(Chaine2)-j+1);

  i:=j;
  // Détermination de la 1° chaine variable
  ChaineVariableDep:='';
  while ((Chaine1[j] <> '_') and (j <= length(Chaine1))) do
   begin
    ChaineVariableDep:=ChaineVariableDep+Chaine1[j];
    inc(j);
   end;
  // Détermination de la 2° chaine variable
  ChaineVariableFin:='';
  while ((Chaine2[i] <> '_') and (i <= length(Chaine2))) do
    Begin
     ChaineVariableFin:=ChaineVariableFin+Chaine2[i];
     inc(i);
    ENd;

  if Str_Count_Str('_',Chaine1) = 2 then ChaineFixe2 := '';
  if Str_Count_Str('_',Chaine1) = 3 then
   begin
      j:=length(Chaine2);
      while str_souschaine(Chaine2,j,1) <> '_' do
       begin
        dec(j);
       end;
      ChaineFixe2 :=str_n_der_char(Chaine2,length(Chaine2)-j+1);
   end;
  // Détermination de la 1° chaine variable
//  ChaineVariableDep := Chaine1;
//  Delete(ChaineVariableDep,1,length(ChaineFixe1));
//  ChaineVariableDep:=str_Suppr_N_Car_ADroite(ChaineVariableDep,length(ChaineFixe2));

  // Détermination de la 2° chaine variable
//  ChaineVariableFin := Chaine2;
//  Delete(ChaineVariableFin,1,length(ChaineFixe1));
//  ChaineVariableFin:=str_Suppr_N_Car_ADroite(ChaineVariableFin,length(ChaineFixe2));

  result:=((length(ChaineVariableDep) > 0) and (length(ChaineVariableFin) > 0));

 end;
End;



//Permet de corriger un string qui comporte des caractères générique du language SQL
//on passe en paramètre une liste de valeurs refusées ainsi que leur correction
//cette liste est récupérée au préalable dans DMConst
Function Str_StringAcceptSQL(Text1:String;ListeCaractereNonCorrects:Tstringlist):String;
var
i,J:integer;
C_NonCorrect,C_Correct:integer;
Begin
result := Text1;
if ListeCaractereNonCorrects<>nil then
  if ((ListeCaractereNonCorrects.count<>0)and(Text1<>'')) then
    begin
    for i:=0 to length(Text1) do
     begin
        for j:=0 to ListeCaractereNonCorrects.count-1 do
         begin
          C_NonCorrect:= StrToIntDef(str_getstringelement(ListeCaractereNonCorrects.Strings[J],1,'='),0);
          C_Correct:= StrToIntDef(str_getstringelement(ListeCaractereNonCorrects.Strings[J],2,'='),0);
          if Text1[i] in [chr(C_NonCorrect)] then Result[i] :=chr(C_Correct);
         end;
     end;
    end;
End;

function RetourListeCaractereNonCorrectString(Source:Tstringlist):Tstringlist;
var
i:integer;
begin
result:=Tstringlist.Create;
  for i:=0 to source.Count-1 do
    result.Add(chr(StrToIntDef(str_getstringelement(Source.Strings[i],1,'='),0)));
end;

Function Str_DupliqueCar(Texte:String;Car:Char;NbCar:Integer):String;
//var
//i,Count:integer;
Begin
//result:='';
//for i:=0 to length(Texte) do
// begin
//   if Texte[i] <> car then
//    begin
//     result:=Result+Texte[i];
//    end
//   else
//    begin
//     result:=Result+ AnsiDequotedStr;
//    end;
// end;
////
End;

function StrToInt_Lgr(const S: string; const Default:integer): Integer;
var
  E: Integer;
begin
  Val(S, Result, E);
  if E <> 0 then
    Result:=Default;
end;

//function StrToCurr_Lgr(const S: string; const Default: Currency): Currency;
//begin
//  if not TextToFloat(PChar(S), Result, fvCurrency) then
//    Result := Default;
//end;


function StrToCurr_Lgr(const S: string; const Default: Currency): Currency;
var
valeur:string;
negatif:boolean;
begin
negatif:=false;
negatif:=(str_commence_par(trim(s),'-'));
valeur:=str_QueDesChiffres(trim(s));
  if not TextToFloat(PChar(valeur), Result, fvCurrency) then
    Result := Default
  else
    if ((negatif)and(result>0)) then result:=result*-1;
end;

function StrToBool_Lgr(const S: string; const Default: boolean): boolean;
var
STmp:string;
begin
STmp:=S;
if ((upperCase(s)='V')or (upperCase(s)='O') or (upperCase(s)='T'))then STmp:='True';
if ((upperCase(s)='F') or (upperCase(s)='N'))then STmp:='false';
  if not TryStrToBool(STmp, Result) then
    Result := Default;
end;

function StrToDate_Lgr(const S: string; const Default: TDateTime): TDateTime;
begin
  if not TryStrToDate(S, Result) then
    Result := Default;
end;


function StrToFloat_Lgr(const S: string; const Default: Extended): Extended;
begin
  if not TextToFloat(PChar(trim(S)), Result, fvExtended) then
    Result := Default;
end;

////////
function FloatToStr_Lgr(const S: extended; const Substr: string; const Default: string): string;
begin
  Result :=floattostr(S);
  if Result=Substr then
    Result:=Default;
end;

function CurrToStr_Lgr(const S: Currency; const Substr: string; const Default: string): string;
begin
  Result :=CurrToStr(S);
  if Result=Substr then
    Result:=Default;
end;

function DateToStr_Lgr(const S: TDateTime; const Substr: string; const Default: string): string;
begin
  Result :=DateToStr(S);
  if Result=Substr then
    Result:=Default;
end;

function IntToStr_Comble(const S: integer;  const Comble: integer): string;
begin
  Result :=IntToStr(S);
  if comble<>-1 then
    while Length(Result)<comble do
      result:='0'+result;
end;

function IntToStr_Lgr(const S: integer; const Substr: string; const Default: string): string;
begin
  Result :=IntToStr(S);
  if Result=Substr then
    Result:=Default;
end;

function StrToStr_Lgr(const S: string; const Substr: string; const Default: string): string;
begin
  Result :=S;
  if Result=Substr then
    Result:=Default;
end;

function StrNbCaractere( const S: string;  Substr: string;  nb : integer;Avant:boolean ) : string;
var
i:integer;
begin
result:='';
if nb>0 then
  begin
    while length(result+s)<nb do
      result:=result+substr;

    if avant then
      result := result +s
    else
      result := S+result ;
  end;
end;


function str_remplacesouschaine_1ereOccurence_avecCasse ( str, sub1, sub2 : string ) : string;
// remplace dans la chaine 'str' toutes les occurences
// de la chaine 'sub1' par la chaine 'sub2'
// ex: str_remplacesouschaine ( 'Toto marche', 'marche', 'cours' ) => 'Toto cours'
var i:integer;
begin
   result := Str;
//   while str_position_caseInsensitive (sub1 ,result) > 0 do begin
     i := str_position_caseInsensitive (sub1 ,Result);
     if i<>0 then
       begin
         delete(Result,i,length(sub1));
         insert(sub2,Result,i);
       end;
end;

function GereLibelle(Value:string ; Const Separateur:String):String;
begin
  Result:=StringReplace(Value,Separateur,'.',[rfReplaceAll, rfIgnoreCase])
end;


function monSplit(chaine : String; delimiteur : string) : TStringList;
var
L : TStringList;
begin
  L:=TStringList.create;
  L.text := StringReplace(chaine, delimiteur, #13#10, [rfReplaceAll]);
 
  monSplit:=L;
end;


function monSplitArray(chaine : String; delimiteur : string) : TStringArray;
var
L : TStringList;
tab:TStringArray;
i:integer;
begin
  L:=TStringList.create;
  L.text := StringReplace(chaine, delimiteur, #13#10, [rfReplaceAll]);
  SetLength(tab,l.Count);
  for i:=0 to l.Count -1 do
  begin
      tab[i]:=l.Strings[i];
  end;
  monSplitArray:=tab;
end;


procedure ExplodeIncludeDelimiteur(Chaine: string; Liste : TStringList; Delimiteur: char; ExcludeEmpty: Boolean = False);
begin
    Liste.Clear;
    while Pos(Delimiteur, Chaine)>0 do
    begin
          if Pos(Delimiteur, Chaine)<>1 then
            if ExcludeEmpty then
             Liste.Add(trim(Copy(Chaine,1,Pos(Delimiteur, Chaine))))
            else
             Liste.Add(Copy(Chaine,1,Pos(Delimiteur, Chaine)));
          Chaine:=Copy(Chaine,Pos(Delimiteur, Chaine)+1,length(Chaine));
    end;
    if Chaine<>'' then
       if ExcludeEmpty then
           Liste.Add(trim(Chaine))
       else
           Liste.Add(Chaine);
end;

procedure Explode(Chaine: string; Liste : TStringList; Delimiteur: char; ExcludeEmpty: Boolean = False);
begin
    Liste.Clear;
    while Pos(Delimiteur, Chaine)>0 do
    begin
          if Pos(Delimiteur, Chaine)<>1 then
           if ExcludeEmpty then
              Liste.Add(trim(Copy(Chaine,1,Pos(Delimiteur, Chaine)-1)))
           else
              Liste.Add(Copy(Chaine,1,Pos(Delimiteur, Chaine)-1));
          Chaine:=Copy(Chaine,Pos(Delimiteur, Chaine)+1,length(Chaine));
    end;
    if Chaine<>'' then
      if ExcludeEmpty then
        Liste.Add(trim(Chaine))
      else
        Liste.Add(Chaine);
end;


procedure rempliTstringlist(tab:array of string ; var liste:Tstringlist);
var
j:integer;
begin
if(liste=nil)then liste:=TStringList.Create;
  for j:=0 to length(tab)-1 do
  begin
     liste.Add(tab[j]);
  end;
end;
end.


// /////////////////////////////////////////////////////////////////////
