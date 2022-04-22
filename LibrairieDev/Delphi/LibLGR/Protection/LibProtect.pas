unit LibProtect;

interface

Uses SysUtils,
  WinTypes,
//  WinProcs,
//  Messages,
//  Classes,
  Graphics,
//	Controls,
  Dialogs,
//  Forms,
//  Registry,
//  Db,
//  DBTables,
//  gr_Librairie_obj,
//  StdCtrls,
//  Grids,
  Lib_Chaine,
  DMXmls,
  E2_Decl_REcords,
  LibDates;

type
 TInfosUtilisateur =record
  Nom:String;
  Prenom:String;
  NomSoc:String;
  Adresse1Soc:String;
  Adresse2Soc:String;
  CP:String[5];
  Ville:String;
  NumLic:String;
  NbDossier:String;
  NumDisk:String;
  Options:STring;
 end;

 TUtilisateurDecoupe= record
  M1:String[4];
  M2:String[4];
  M3:String[4];
  M4:String[4];
  M5:String[4];
  MD1:TColor;
  MD2:TColor;
  MD3:TColor;
  MD4:TColor;
  MD5:TColor;
//  MD1:DWord;
//  MD2:DWord;
//  MD3:DWord;
//  MD4:DWord;
//  MD5:DWORD;
 end;

Function CompKey(Valeur:Integer):Boolean;
Function GenKey:Integer;
Function GetInfosUtilisateur:Boolean;
Function SetInfosUtilisateur:Boolean;
Function EvalPeriodeOK:Boolean;
Function VerifCodeUtilisateur:Boolean;
Function DemandeEnreg:Boolean;
Function GenereCode1(UtilisateurDecoupe:TUtilisateurDecoupe;Sep:String):String;
Function GenereCode2(Base:String):String;
Function GetRegisterKey:Boolean;
Function DecoupeUtilisateur(Utilisateur:TInfosUtilisateur):TUtilisateurDecoupe;
Function ChaineToHEXAToInt(Texte:String):Integer;
Function VerifFinQueryUser2(QueryUser1,QueryUser2:String):Boolean;
Function MB:DWord;

implementation

uses Windows;


Function CompKey(Valeur:Integer):Boolean;
Begin
try
  result:=Valeur=GenKey;
  if not result then abort;
except
 abort;
end;

End;

Function GenKey:Integer;
var
Aujourd:TDateTime;
MoisJour,HeurMin:String;
Mois,Jour,heure,min:String;
MoisD,JourD,heureD,minD:integer;
Var1,Var2:DWord;
SysTime:TSystemTime;
Begin
GetSystemTime(SysTime);

MoisD:=SysTime.wMonth;
JourD:=SysTime.wDay;
MoisJour:=str_ajouteAgauche(IntToHex(MoisD,2),'0000',4-length(IntToHex(MoisD,2))) +
          str_ajouteAgauche(IntToHex(JourD,2),'0000',4-length(IntToHex(JourD,2)));
HeureD:=SysTime.wHour;
MinD:=SysTime.wMinute;
HeurMin:= str_ajouteAgauche(IntToHex(HeureD,2),'0000',4-length(IntToHex(HeureD,2))) +
          str_ajouteAgauche(IntToHex(MinD,2),'0000',4-length(IntToHex(MinD,2)));

var1:=stringtocolor('$'+MoisJour);
Var2:=stringtocolor('$'+HeurMin);

result:=var1 xor var2;
End;

// retourne faux après fin de période d'évaluation.
Function EvalPeriodeOK:Boolean;
Begin
result:=false;
End;

Function GetInfosUtilisateur:Boolean;
Begin
result:=true;
// lecture des infos dans base registre ou fic Xml (pour code1)
End;

Function SetInfosUtilisateur:Boolean;
var
Utilisateur:TInfosUtilisateur;
Code1:String;
Begin


Utilisateur.Nom:='Blanc';
Utilisateur.Prenom:='Philippe';
Utilisateur.NomSoc:='LeGrain';
Utilisateur.Adresse1Soc:='La Gare';
Utilisateur.CP:='82130';
Utilisateur.Ville:='Monclar de Quercy';
Utilisateur.NumLic := '03090012';
Utilisateur.NbDossier := '01';
Utilisateur.NumDisk := '123124514';
Utilisateur.Options := '01204210';
Utilisateur.Prenom:=InputBox('Demande infos utilisateur','Saisie ton nom :',Utilisateur.Prenom);

Code1:=GenereCode1(DecoupeUtilisateur(Utilisateur),' - ');
DMXml.ModifieItemProgramme('QueryUser1',Code1);
Code1:=GenereCode1(DecoupeUtilisateur(Utilisateur),'');
DMXml.ModifieItemProgramme('QueryUser1',Code1);
   // Affichage fenetre info utilisateur
   // Creation DAns Base registre des données saisies ou fichier XML( a voir)

  result:=true;
End;

// si code enregistrement(Code2) existe alors
// Vérification avec la fonction de calcul de code2
// sinon demande d'enregistrment!
Function VerifCodeUtilisateur:Boolean;
var
Text1,Text2:String;
Begin
try
  try
   Text2:=DMXml.RetourneValItemProgramme('QueryUser2');
  except
    Text2:=C_ValeurCleVide;
  end;

  try
     Text1:=GenereCode2(DMXml.RetourneValItemProgramme('QueryUser1'));
  except
     Text1:='';
  end;

finally
   Result:= copy(Text2,1,16) = Text1;
   if result then
     result:=VerifFinQueryUser2(DMXml.RetourneValItemProgramme('QueryUser1'),DMXml.RetourneValItemProgramme('QueryUser2'));

end;

//DMXml.ModifieItemProgramme('QueryUser1','tt');
End;

Function DemandeEnreg:Boolean;
Begin
Result:= true;
End;

Function GenereCode1(UtilisateurDecoupe:TUtilisateurDecoupe;Sep:String):String;
Begin
UtilisateurDecoupe.MD1:=(UtilisateurDecoupe.MD1 xor UtilisateurDecoupe.MD4);
UtilisateurDecoupe.MD2:=(UtilisateurDecoupe.MD2 xor UtilisateurDecoupe.MD5);
UtilisateurDecoupe.MD3:=(UtilisateurDecoupe.MD3 xor UtilisateurDecoupe.MD2);
Result:= str_ajouteAgauche(IntToHex(UtilisateurDecoupe.MD1,2),'00000000',8-length(IntToHex(UtilisateurDecoupe.MD1,2))) +
         sep +
         str_ajouteAgauche(IntToHex(UtilisateurDecoupe.MD2,2),'00000000',8-length(IntToHex(UtilisateurDecoupe.MD2,2))) +
         sep +
         str_ajouteAgauche(IntToHex(UtilisateurDecoupe.MD3,2),'00000000',8-length(IntToHex(UtilisateurDecoupe.MD3,2)));
End;

Function GenereCode2(Base:String):String;
var
QueryUser2Code1,QueryUser2Code2,QueryUser2Code3:String;
Code1,Code2,Code3:String;
CodeD1,CodeD2,CodeD3:DWord;
C1,C2,C3,C4,C5,C6,C7,C8:String[2];
CD1,CD2,CD3,CD4,CD5,CD6,CD7,CD8:DWord;
Begin
// Calcul des 2/3 de QueryUser2 en fonction de QueryUser1
Code1:=Copy(Base,1,8);
Code2:=Copy(Base,9,8);
Code3:=Copy(Base,17,8);

//Calcul 1er Tiers QueryUser2
CodeD1:=stringtocolor('$'+Code1);
CodeD2:=stringtocolor('$'+Code2);
CodeD3:=stringtocolor('$'+Code3);

CodeD1 := CodeD1 xor CodeD2;
CodeD2 := CodeD2 xor CodeD3;

Code1:=str_ajouteAgauche(IntToHex(CodeD1,2),'00000000',8-length(IntToHex(CodeD1,2)));
Code2:=str_ajouteAgauche(IntToHex(CodeD2,2),'00000000',8-length(IntToHex(CodeD2,2)));


C1:=copy(Code1,1,2);
C2:=copy(Code1,3,2);
C3:=copy(Code1,5,2);
C4:=copy(Code1,7,2);

C5:=copy(Code2,1,2);
C6:=copy(Code2,3,2);
C7:=copy(Code2,5,2);
C8:=copy(Code2,7,2);

CD1:=stringtocolor('$'+C1);
CD2:=stringtocolor('$'+C2);
CD3:=stringtocolor('$'+C3);
CD4:=stringtocolor('$'+C4);

CD5:=stringtocolor('$'+C5);
CD6:=stringtocolor('$'+C6);
CD7:=stringtocolor('$'+C7);
CD8:=stringtocolor('$'+C8);

CD1:= CD1 xor CD8;
CD2:= CD2 xor CD7;
CD3:= CD3 xor CD6;
CD4:= CD4 xor CD5;


C1:=str_ajouteAgauche(IntToHex(CD1,2),'00',2-length(IntToHex(CD1,2)));
C2:=str_ajouteAgauche(IntToHex(CD2,2),'00',2-length(IntToHex(CD2,2)));
C3:=str_ajouteAgauche(IntToHex(CD3,2),'00',2-length(IntToHex(CD3,2)));
C4:=str_ajouteAgauche(IntToHex(CD4,2),'00',2-length(IntToHex(CD4,2)));

QueryUser2Code1 := C1 + C2 + C3 + C4;

CodeD1:=stringtocolor('$'+QueryUser2Code1);
CodeD2 := CodeD1 xor CodeD3;

QueryUser2Code2 := str_ajouteAgauche(IntToHex(CodeD2,2),'00000000',8-length(IntToHex(CodeD2,2)));

// Result recoit le Code2 VAlide
result := QueryUser2Code1 + QueryUser2Code2;

End;

Function GetRegisterKey:Boolean;
Begin
 showmessage('Demande de la clé à l''utilisateur');
 DMXml.ModifieItemProgramme('QueryUser2','63523A3E27340B01E129E2F7');
// DMXml.ModifieItemProgramme('QueryUser2','63523A3E27340B01E129E2F6');
End;

Function DecoupeUtilisateur(Utilisateur:TInfosUtilisateur):TUtilisateurDecoupe;
var
TT:String;
Begin
result.M1:=copy(Utilisateur.Nom,1,2)+copy(Utilisateur.Prenom,1,2);
result.M2:=copy(Utilisateur.NomSoc,1,2)+copy(Utilisateur.Adresse1Soc,1,2);
result.M3:=copy(Utilisateur.CP,1,2)+copy(Utilisateur.Ville,1,2);
result.M4:=copy(Utilisateur.NumDisk,1,2)+copy(Utilisateur.NumLic,1,2);
result.M5:=copy(Utilisateur.Options,1,2)+copy(Utilisateur.NbDossier,1,2);


Result.MD1:=ChaineToHEXAToInt(Result.M1);
Result.MD2:=ChaineToHEXAToInt(Result.M2);
Result.MD3:=ChaineToHEXAToInt(Result.M3);
Result.MD4:=ChaineToHEXAToInt(Result.M4);
Result.MD5:=ChaineToHEXAToInt(Result.M5);

End;

Function ChaineToHEXAToInt(Texte:String):Integer;
var
i:integer;
TextTmp:String;
IntTmp:Int64;
IntTmp2:Integer;
Begin
Try
  TextTmp:='';
  Result:=0;
  for i:=1 to length(texte) do
   begin
//   TryStrToInt64(IntToHex(Ord(texte[i]),2),IntTmp);
//   TryStrToInt(IntToHex(Ord(texte[i]),2),IntTmp2);
     TExtTmp:=TextTmp+IntToHex(Ord(texte[i]),2);
   end;
  result:=stringtocolor('$'+TextTmp);
except
 Showmessage('Erreur dans ChaineToHEXAToInt');
 result:=0; 
end;

End;

Function VerifFinQueryUser2(QueryUser1,QueryUser2:String):Boolean;
var
Code1,Code2:String;
CodeD1,CodeD2:DWord;
Begin
try
  if length(QueryUser1) <> 24 then abort;
  if length(QueryUser2) <> 24 then abort;
  Code1:=copy(QueryUser1,17,8);
  Code2:=copy(QueryUser2,17,8);
  CodeD1:=stringtocolor('$'+Code1);
  CodeD2:=stringtocolor('$'+Code2);
  CodeD2:= CodeD2 xor MB;
  result := CodeD1 = CodeD2;
except
 result:=false;
end;

End;

Function MB:DWord;
Begin
result:=$A54FD3C9;
End;

end.
