{***************************************************************
 *
 * Unit Name: referencement
 * Purpose  :
 * Author   :
 * History  :
 *
 ****************************************************************}

unit referencement;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   StdCtrls, ExtCtrls, ComCtrls, IBCtrls, ToolWin, Menus, Lib_chaine,E2_Decl_Records;
/////////////////////////////////////////////////////////////////////////////


//record de retour de la plus grande r�f�rence dans une liste de diff�rentes r�f�rences donn�es
//type
// TReference=record
//   Reference:string;
//   retour:boolean;
// end;


/////////////////////////////////////////////////////////////////////////////


   function reduc_mois ( const nb: integer; const mois_lettre: string ): string;
   // Etabli la nouvelle forme du mois pr�alablement choisie
   // en fonction du nombre nb de lettres voulues (1..3 )
   
   function constr_Compteur_numerique ( const cpt: integer; const nb: integer ) : string;
   // Transforme le compteur de fa�on � avoir nb chiffres
   
   function constr_Compteur_alphanumerique ( const cpt: integer ) : string;
   // Transforme l'entier passe en argument en un compteur alphanum�rique
   // ex: 000Z = 36

   function constr_Compteur_alphabetique ( const cpt: integer ) : string;
   // Transforme l'entier pass� en argument en un compteur alphabetique
   // ex: AAAZ = 26
      
   function assoc_mois ( const mois_lettre : string ): string;
   // Renvoie 'mois_lettre' transform� en mois chiffr�


   Function MaxReferenceDansListe(Valeur:string;Debut,Count:integer;Liste:TstringList):TReference;
   //renvoie la plus grande r�f�rence d'une liste donn�e, d'une sorte donn�e en fonction de parametres de tri


   Function MaxID_EcritureDansListe(Liste:TstringList):TReference;
   //renvoie le plus grand idEcriture d'une liste donn�e


// *******************************************************************



   // *******************************************************************
   // structure contenant les caract�ristiques de la r�f�rence
type
   type_ref = record
      ordre: array [ 1 .. 5 ] of string; // tableau contenant l'ordre des elts
      jour,          // jour en mode chiffr� ex: 02, 06, 11
      mois,          // mois en mode lettr� ex: Janvier, Mai, Juin
      annee,         // ann�e en mode complet ex: 1999, 2001
      type_compteur, // num�rique, alphab�tique, alphanum�rique
      code: string;  // Code de la r�f�rence
      //**********//
      nb_chiffres,   // nb de chiffres pour le compteur num�rique ex: 5 -> 00568
      lg_code,       // longueur
      nb_lettres_mois: integer; // le mois est r�duit sur nb_lettres_mois
      annee_abregee, // si vraie: forme r�duite pour l'ann�e ex: 2001 -> 01
      mois_chiffre,  // si vraie: forme chiffr� pour le mois ex: Avril -> 04
      mois_reduit: boolean; // si vraie: forme reduite pour le mois
                            // ex: Juin sur 2 lettres -> Ju
   end;
   function New_reference ( const ref_last: string; rtype: type_ref ): string;
   // Renvoie la r�f�rence qui suit Last_ref en la construisant � partir
   // de rtype qui contient les caract�ristiques de la r�f�rence � g�n�rer


   function New_Reference_Epicea(reference,Journal,CodeExo:string):TReference;
   //incr�mentation des r�f�rences d'Epicea
   // *******************************************************************

implementation

// /////////////////////////////////////////////////////// //
// FONCTION POUR LA CONSTRUCTION DE LA NOUVELLE REFERENCE  //
// /////////////////////////////////////////////////////// //

   function constr_Compteur_numerique ( const cpt: integer;
                                        const nb: integer ) : string;
   // Transforme le compteur de fa�on � avoir nb chiffres
   var
      max,
      i,temp: integer;
   begin
     temp := cpt;
     if temp = 0 then temp := 0;
      result := inttostr ( temp );
      max := 1;
      // on rempli chaque champs
      result := inttostr ( temp );
      for i := 1 to nb do
         max := max * 10;
      if max <= temp then
      begin
         // On ne peut plus g�n�rer un compteur sup�rieur
         result := '';
         exit;
      end;
      max := max div 10;
      while temp < max do
      begin
         result := '0' + result;
         max := max div 10;
      end;
   end;

// /////////////////////////////////////////////////////////////////////////////

   function constr_Compteur_alphabetique ( const cpt: integer ) : string;
   // Transforme l'entier pass� en argument en un compteur alphabetique
   // ex: AAAZ = 26
   const
      alpha: array [ 1 .. 26 ] of string =
             ( 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
               'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
               'U', 'V', 'W', 'X', 'Y', 'Z' );
   var
      chaine: string [ 4 ];
      nb: integer;
   begin
      nb := cpt;
      if nb < 27 then
         chaine := 'AAA' + alpha [ nb ]; // on change la 4� lettre

      if nb < 677 then
      begin
         // cas o� l'on doit changer les 2 dernieres lettres
         if ( nb mod 26 ) = 0 then chaine := 'AA' + alpha [ nb div 26 ]
                                                  + alpha [ 26 ]
            else chaine := 'AA' + alpha [ ( nb div 26 ) + 1 ]
                                + alpha [ nb mod 26 ];
      end

      else if nb < 17576 then
      begin
         // cas o� l'on doit changer les 3 derni�res lettres
         // 2� lettre
         if ( nb mod 676 ) = 0 then chaine := 'A' + alpha [ nb div 676 ]
            else chaine := 'A' + alpha [ ( nb div 676 ) + 1 ];
         // 3� lettre
         nb := nb mod 676;
         if nb = 0 then chaine := chaine + alpha [ 26 ]
            else chaine := chaine + alpha [ ( nb div 26 ) + 1 ];
         // 4� lettre
         nb := nb mod 26;
         if nb <> 0 then chaine := chaine + alpha [ nb ]
            else chaine := chaine + alpha [ 26 ];
      end

      else
      begin
         // cas o� l'on doit changer les 4 lettres
         // 1� lettre
         if ( nb mod 17576 ) = 0 then  chaine := alpha [ nb div 17576 ]
            else  chaine := alpha [ ( nb div 17576 ) + 1 ];
         // 2� lettre
         nb := nb mod 17576;
         if nb = 0 then chaine := chaine + alpha [ 26 ]
            else chaine := chaine + alpha [ ( nb div 676 ) + 1 ];
         // 3� lettre
         nb := nb mod 676;
         if nb = 0 then chaine := chaine + alpha [ 26 ]
            else chaine := chaine + alpha [ ( nb div 26 ) + 1 ];
         // 4� lettre
         nb := nb mod 26;
         if nb = 0 then chaine := chaine + alpha [ 26 ]
            else chaine := chaine + alpha [ nb ];
      end;

      result := chaine;
   end;

// /////////////////////////////////////////////////////////////////////////////

   function constr_Compteur_alphanumerique ( const cpt: integer ) : string;
   // Transforme l'entier passe en argument en un compteur alphanum�rique
   // ex: 000Z = 36
   const
      alphanum: array [ 1 .. 36 ] of string =
                ( '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
                  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
                  'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
                  'U', 'V', 'W', 'X', 'Y', 'Z' );
   var
      chaine: string [ 4 ];
      nb: integer;
   begin
      nb := cpt;
      if nb < 37 then
         chaine := '000' + alphanum [ nb ]; // On change la derniere lettre

      if nb < 1297 then
      begin
         // Cas o� l'on doit changer les 2 derni�res lettres
         if ( nb mod 36 ) = 0 then chaine := '00' + alphanum [ nb div 36 ]
                                                  + alphanum [ 36 ]
            else chaine := '00' + alphanum [ ( nb div 36 ) + 1 ]
                                + alphanum [ nb mod 36 ];
      end

      else if nb < 46656 then
      begin
         // Cas o� l'on doit changer les 3 derni�res lettres
         // 2� lettre
         if ( nb mod 1296 ) = 0 then chaine := '0' + alphanum [ nb div 1296 ]
            else chaine := '0' + alphanum [ ( nb div 1296 ) + 1 ];
         // 3� lettre
         nb := nb mod 1296;
         if nb = 0 then chaine := chaine + alphanum [ 36 ]
            else chaine := chaine + alphanum [ ( nb div 36 ) + 1 ];
         // 4� lettre
         nb := nb mod 36;
         if nb <> 0 then chaine := chaine + alphanum [ nb ]
            else chaine := chaine + alphanum [ 36 ];
      end

      else
      begin
         // Cas o� l'on doit changer les 4 lettres
         // 1� lettre
         if ( nb mod 46656 ) = 0 then chaine := alphanum [ nb div 46656 ]
            else chaine := alphanum [ ( nb div 46656 ) + 1 ];
         // 2� lettre
         nb := nb mod 46656;
         if nb = 0 then chaine := chaine + alphanum [ 36 ]
            else chaine := chaine + alphanum [ ( nb div 1296 ) + 1 ];
         // 3� lettre
         nb := nb mod 1296;
         if nb = 0 then chaine := chaine + alphanum [ 36 ]
            else chaine := chaine + alphanum [ ( nb div 36 ) + 1 ];
         // 4� lettre
         nb := nb mod 36;
         if nb = 0 then chaine := chaine + alphanum [ 36 ]
            else chaine := chaine + alphanum [ nb ];
      end;

      result := chaine;
   end;

// /////////////////////////////////////////////////////////////////////////////

   function assoc_mois ( const mois_lettre : string ): string;
   // Renvoie 'mois_lettre' transform� en mois chiffr�
   const
      NomMois: array [ 1 .. 12 ] of string =
                ( '01', '02', '03', '04', '05', '06',
                  '07', '08', '09', '10', '11', '12' );
   begin
      result := '';
      if (str_majuscule(mois_lettre)) = str_majuscule('Janvier') then result := NomMois [ 1 ];
      if (str_majuscule(mois_lettre)) = str_majuscule('Fevrier') then result := NomMois [ 2 ];
      if (str_majuscule(mois_lettre)) = str_majuscule('Mars') then result := NomMois [ 3 ];
      if (str_majuscule(mois_lettre)) = str_majuscule('Avril') then result := NomMois [ 4 ];
      if (str_majuscule(mois_lettre)) = str_majuscule('Mai') then result := NomMois [ 5 ];
      if (str_majuscule(mois_lettre)) = str_majuscule('Juin') then result := NomMois [ 6 ];
      if (str_majuscule(mois_lettre)) = str_majuscule('Juillet') then result := NomMois [ 7 ];
      if (str_majuscule(mois_lettre)) = str_majuscule('Ao�t') then result := NomMois [ 8 ];
      if (str_majuscule(mois_lettre)) = str_majuscule('Septembre') then result := NomMois [ 9 ];
      if (str_majuscule(mois_lettre)) = str_majuscule('Octobre') then result := NomMois [ 10 ];
      if (str_majuscule(mois_lettre)) = str_majuscule('Novembre') then result := NomMois [ 11 ];
      if (str_majuscule(mois_lettre)) = str_majuscule('Decembre') then result := NomMois [ 12 ];
   end;

// /////////////////////////////////////////////////////////////////////////////

   function reduc_mois ( const nb: integer; const mois_lettre: string ): string;
   // Etabli la nouvelle forme du mois pr�alablement choisie
   // en fonction du nombre nb de lettres voulues (1..3 )
   var
      i: integer;
   begin
      result := '';
      for i := 1 to nb do
         result := result + mois_lettre [ i ];
   end;

// /////////////////////////////////////////////////////////////////////////////

   function New_reference ( const ref_last: string; rtype: type_ref ): string;
   // Renvoie la r�f�rence qui suit Last_ref en la construisant � partir
   // de rtype qui contient les caract�ristiques de la r�f�rence � g�n�rer
   var
      ref_tmp,          // contient ref_last
      cpt_tmp,          // contient le compteur courant
      cpt_last: string; // contient le compteur de ref_last
      i,                // parcours du tableau d'ordre
      j,                // parcours de ref_last pour le compteur num�rique
      cpt,              // compteur courant
      pos_tmp: integer; // position courante dans ref_last
      resultat: string; // contient la r�f�rence qui suit ref_last
   begin
      pos_tmp := 1;
      ref_tmp := ref_last;
      resultat := '';
      i := low ( rtype.ordre );
      while ( rtype.ordre [ i ] <> '' ) and ( i <= high ( rtype.ordre ) ) do
      begin
         // On parcours le tableau d'ordre jusqu'a la fin ou jusqu'a ce que
         // l'on trouve une 'case' vide
         if ( (str_majuscule(rtype.ordre [ i ])) = str_majuscule('Jour') ) and ( rtype.jour <> '' ) then
         begin
            // On a trouv� 'Jour': on compl�te la r�f�rence suivante
            resultat := resultat + rtype.jour;
            pos_tmp := pos_tmp + 2;
         end
         else if ( (str_majuscule(rtype.ordre [ i ])) = str_majuscule('Annee') ) and ( rtype.annee <> '' ) then
         begin
            // On a trouv� 'Ann�e': on compl�te la r�f�rence suivante
            if rtype.annee_abregee then
            begin
               // On veut l'ann�e en abr�g�e
               resultat := resultat + rtype.annee [ 3 ] + rtype.annee [ 4 ];
               pos_tmp := pos_tmp + 2;
            end
            else
            begin
               resultat := resultat + rtype.annee;
               pos_tmp := pos_tmp + strlen ( Pchar ( rtype.annee ) );
            end
         end
         else if ( (str_majuscule(rtype.ordre [ i ])) = str_majuscule('Mois') ) and ( rtype.mois <> '' ) then
         begin
            // On a trouv� 'Mois': on compl�te la r�f�rence suivante
            if rtype.mois_reduit then
            begin
               // On veut l'ann�e en mode r�duit
               resultat := resultat + reduc_mois ( rtype.nb_lettres_mois,
                                                   rtype.mois );
               pos_tmp := pos_tmp + rtype.nb_lettres_mois;
            end
            else if rtype.mois_chiffre then
            begin
               // On veut l'ann�e en mode chiffr�e
               resultat := resultat + assoc_mois ( rtype.mois );
               pos_tmp := pos_tmp + 2;
            end
            else
            begin
               resultat := resultat + rtype.mois;
               pos_tmp := pos_tmp + strlen ( Pchar ( rtype.mois ) );
            end;
         end
         else if (((str_majuscule(rtype.ordre [ i ])) = str_majuscule('Code r�f�rence'))
              or ((str_majuscule(rtype.ordre [ i ])) = str_majuscule('Code reference'))) then
         begin
            // On a trouv� 'Code': on compl�te la r�f�rence suivante
            resultat := resultat + rtype.code;
            pos_tmp := pos_tmp + strlen ( Pchar ( rtype.code ) );
         end
         else if (str_majuscule(rtype.ordre [ i ])) = str_majuscule('Compteur') then
         begin
            if (((str_majuscule(rtype.type_compteur)) = str_majuscule('Alphanumerique'))
             or ((str_majuscule(rtype.type_compteur)) = str_majuscule('Alphanum�rique'))) then
            begin
               // C'est un compteur alphanum�rique
               cpt := 1;
               if ref_last = '' then
               begin
                  // C'est la premi�re r�f�rence que l'on entre
                  resultat := resultat + constr_compteur_alphanumerique ( 1 );
               end
               else
               begin
                  cpt_last := ref_last[pos_tmp]+ref_last[pos_tmp+1]+
                              ref_last[pos_tmp+2]+ref_last[pos_tmp+3]; 
                  cpt_tmp := constr_compteur_alphanumerique ( cpt );
                  // On recherche le compteur suivant
                  while cpt_tmp <> cpt_last do
                  begin
                     inc ( cpt );
                     cpt_tmp := constr_compteur_alphanumerique ( cpt );
                  end;
                  resultat := resultat + constr_compteur_alphanumerique ( cpt + 1 );
               end;
            end // end compteur alphanumerique
            else if (((str_majuscule(rtype.type_compteur)) = str_majuscule('Alphabetique'))
                 or ((str_majuscule(rtype.type_compteur)) = str_majuscule('Alphab�tique'))) then
            begin
               cpt := 1;
               if ref_tmp = '' then
               begin
                  // C'est la premi�re r�f�rence que l'on entre
                  resultat := resultat + constr_compteur_alphabetique ( 1 );
               end
               else
               begin
                  cpt_last := ref_last[pos_tmp]+ref_last[pos_tmp+1]+
                              ref_last[pos_tmp+2]+ref_last[pos_tmp+3];
                  cpt_tmp := constr_compteur_alphanumerique ( cpt );
                  // On recherche le compteur suivant
                  while cpt_tmp <> cpt_last do
                  begin
                     inc ( cpt );
                     cpt_tmp := constr_compteur_alphabetique ( cpt );
                  end;
                  resultat := resultat
                              + constr_compteur_alphabetique ( cpt + 1 );
                  pos_tmp := pos_tmp + 4;
               end;
            end // end compteur alphab�tique
            else if (((str_majuscule(rtype.type_compteur)) = str_majuscule('Numerique'))
                 or ((str_majuscule(rtype.type_compteur)) = str_majuscule('Num�rique'))) then
            begin
               cpt := 1;
               if ref_tmp = '' then
               begin
                  // C'est la premi�re r�f�rence que l'on entre
                  resultat := resultat +
                             constr_compteur_numerique ( 1, rtype.nb_chiffres );
               end
               else
               begin
                  // On forme un compteur poss�dant nb_chiffres chiffres
                  for j := 1 to rtype.nb_chiffres do
                     cpt_last := cpt_last + ref_tmp [ pos_tmp + j - 1 ];
                  cpt_last := stringofchar ( '0', rtype.nb_chiffres - length ( cpt_last ) )+cpt_last;
                  cpt_tmp := constr_compteur_numerique ( cpt,
                                                         rtype.nb_chiffres );
                  // On recherche le compteur suivant
                  while cpt_tmp <> cpt_last do
                  begin
                     inc ( cpt );
                     cpt_tmp := constr_compteur_numerique ( cpt,
                                                            rtype.nb_chiffres );
                  end;
                  resultat := resultat +
                              constr_compteur_numerique ( cpt + 1,
                                                          rtype.nb_chiffres );
               end;
            end; // end compteur numerique
         end; // end compteur
         inc ( i );
      end; // end while
      result := resultat;

         end;


/////////////////////////////////////////////////////////////////////////////////

//permet de r�cup�rer la plus grande des r�f�rences dans une liste de diff�rentes r�f�rences
Function MaxReferenceDansListe(Valeur:string;Debut,Count:integer;Liste:TstringList):TReference;
var
ListeTmp:tstringlist;
I:integer;
valeurTmp:string;
Begin
  try
  result.retour:=false;
  ListeTmp:=TStringList.Create;
    for i:=0 to liste.Count-1 do
    Begin
      if copy(liste.Strings[i],Debut,Count)=Valeur then
         ListeTmp.Add(liste.strings[i]);
    End;
   ListeTmp.Sorted:=true;
   if ListeTmp.Count<>0 then
     Begin
       result.Reference:=listeTmp.Strings[listetmp.Count-1];
       result.retour:=true;
     End;
  finally
  ListeTmp.Free;
  end;//fin du try finally
End;

/////////////////////////////////////////////////////////////////////////////////

//permet de r�cup�rer le plus grand des IDEcriture dans une liste de diff�rents idEcriture
Function MaxID_EcritureDansListe(Liste:TstringList):TReference;
//var
//ListeTmp:tstringlist;
//I:integer;
//valeurTmp:string;

Begin
  try
//  result.retour:=false;
//  ListeTmp:=TStringList.Create;
//
//    for i:=0 to liste.Count-1 do
//    Begin
//      if copy(liste.Strings[i],Debut,Count)=Valeur then
//         ListeTmp.Add(liste.strings[i]);
//    End;
   Liste.Sorted:=true;
   if Liste.Count<>0 then
     Begin
       result.Reference:=inttostr(strtoint(liste.Strings[liste.Count-1])+1);
       result.retour:=true;
     End;
  finally
  //ListeTmp.Free;
  end;//fin du try finally
End;


/////////////////////////////////////////////////////////////////////////////////
//permet d'incr�menter une r�f�rence d'Epicea avec une structure connue
function New_Reference_Epicea(reference,Journal,CodeExo:string):TReference;
var
refTmp:string;
Begin
result.retour:=false;
if reference<>'' then
   begin
   refTmp:=inttostr(strtoint(Copy(Reference,5,5))+1);
      while Length(refTmp)<>5 do
      insert('0',refTmp,1);
   result.Reference:=copy(reference,1,4)+reftmp;
   end
else
   result.Reference:=journal+codeExo+'00001';

if trim(result.Reference)<>'' then
   result.retour:=true;
End;

/////////////////////////////////////////////////////////////////////////////////


end.
// /////////////////////////////////////////////////////////////////////////////