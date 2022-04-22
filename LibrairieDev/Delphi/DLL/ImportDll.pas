unit ImportDll;

interface
Uses
//SysUtils,
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
//Gr_Librairie_Obj,
//StdCtrls,
//Decl_record,
//Unit1,
//E2_Decl_Records,
variants;

Type
 TDetailDate = Record
     Date_:TDate;
     an:word;
     mois:word;
     jour:word;
     DateWord:word;
     AnStr:PChar;
     JourStr:PChar;
     MoisStr:PChar;
     Valide:boolean;
     DateStr:PChar;
     Vide:Boolean;
     end;
  TNumVersion=record
  Version:string;
  DateVersion:string;
  messageVersion:string;
  end;
  PNumVersion=^TNumVersion;

  Function GetFirstDayOfMonth(T:TDate):integer;
//  Function DateInfos1(Date:TDate):PChar;
//  Function DateInfos(Date:TDate):TDetailDate;
  Procedure AfficheAPropos(HandleParent:Integer;Titre,TypeClient:PChar);
  Procedure AfficheAvertDemo;
  Procedure Free_Form(IndexForm:Integer);
  Function AfficheSauvegarde(EnDLL:Boolean;ParamSauvegarde:PChar):Integer;
  Function AfficheSauvegardeFermeture(EnDLL:Boolean;ParamSauvegarde:PChar):Integer;
  Function AfficheSauvegarde_ancienne(EnDLL:Boolean;ParamSauvegarde:PChar):Integer;
  //Function AfficheRestauration(EnDLL:Boolean;ParamSauvegarde:PChar):Integer;
  Function AfficheReport(NomFichier,TitreForm,Titre2Edition,Titre3Edition:PChar;HeigthForm,WitdthForm,BtnImprimer,BtnAnnuler:Integer):integer;
  Function RenvoieNumVersion():PChar;
  Function numVersion:PNumVersion;
//Function numVersionComplete:String;
implementation

uses lib_chaine;
var
C_Date:string;
C_Version:string;
C_messageVersion:string;




  Function GetFirstDayOfMonth(T:TDate):integer;external 'LgrLib.dll' name 'GetFirstDayOfMonth';
  Function GetNbDayOfMonth(Mois,Annee:Word):Word;external 'LgrLib.dll' name 'GetNbDayOfMonth';
  function MoisStr(dateSaisie: TDate):string;external 'LgrLib.dll' name 'MoisStr';
  function jourStr(DateSaisie:TDate): string;external 'LgrLib.dll' name 'jourStr';
  function jourCol(DateSaisie:TDate): integer;external 'LgrLib.dll' name 'jourCol';

  Function JourSuivant(DateDep:TDate;NbrJour:integer):TDetailDate;external 'LgrLib.dll' name 'JourSuivant';
  Function JourPrecedent(DateDep:TDate;NbrJour:integer):TDetailDate;external 'LgrLib.dll' name 'JourPrecedent';
  Function MoisSuivant(DateDep:TDate;NbrMois:integer):TDetailDate;external 'LgrLib.dll' name 'MoisSuivant';
  Function MoisPrecedent(DateDep:TDate;NbrMois:integer):TDetailDate;external 'LgrLib.dll' name 'MoisPrecedent';
  Function JourOffset(DateDep:TDate;NbrJour:integer):TDetailDate;external 'LgrLib.dll' name 'JourOffset';
  Function MoisOffset(DateDep:TDate;NbrMois:integer):TDetailDate;external 'LgrLib.dll' name 'MoisOffset';

  Function DateValide(DateAVerif:String):Boolean;external 'LgrLib.dll' name 'DateValide';
  function HeureValide(HeureAVerif:String): Boolean;external 'LgrLib.dll' name 'HeureValide';
  Function TousLesJoursDuMois(DateDep:TDate): TList;external 'LgrLib.dll' name 'TousLesJoursDuMois';
//  Function DateInfos(Date:TDate):TDetailDate;external 'LgrLib.dll' name 'DateInfos';
//  Function DateInfos1(Date:TDate):PChar;external 'LgrLib.dll' name 'DateInfos1';
  Function CompareDate(Date1,Date2:TDate):Integer;external 'LgrLib.dll' name 'CompareDate';
  Procedure AfficheAPropos(HandleParent:Integer;Titre,TypeClient:PChar);external 'LgrLib.dll' name 'AfficheAPropos';
  Procedure AfficheAvertDemo;external 'LgrLib.dll' name 'AfficheAvertDemo';
  Function AfficheReport(NomFichier,TitreForm,Titre2Edition,Titre3Edition:PChar;HeigthForm,WitdthForm,BtnImprimer,BtnAnnuler:Integer):integer;external 'LgrLib.dll' name 'AfficheReport';
  Procedure Free_form(IndexForm:Integer);external 'LgrLib.dll' name 'Free_form';
  Function AfficheSauvegarde(EnDLL:Boolean;ParamSauvegarde:PChar):Integer;External 'LgrLib.dll' name 'AfficheSauvegarde';
  Function AfficheSauvegardeFermeture(EnDLL:Boolean;ParamSauvegarde:PChar):Integer;External 'LgrLib.dll' name 'AfficheSauvegardeFermeture';
  Function AfficheSauvegarde_ancienne(EnDLL:Boolean;ParamSauvegarde:PChar):Integer;External 'LgrLib.dll' name 'AfficheSauvegarde_ancienne';
//  Function AfficheRestauration(EnDLL:Boolean;ParamSauvegarde:PChar):Integer;External 'LgrLib.dll' name 'AfficheRestauration';
  Function RenvoieNumVersion():PChar;External 'LgrLib.dll' name 'RenvoieNumVersion';



   Function numVersion:PNumVersion;
  var
  retour:string;
  begin
      //retour:=RenvoieNumVersion();
      if(C_Version='')then
      begin
        retour:=RenvoieNumVersion;
        C_Version:=str_getstringelement(retour,1,'¤');
        C_Date:=str_getstringelement(retour,2,'¤');;
        C_messageVersion:=str_getstringelement(retour,3,'¤');;
      end;
      result:=new(PNumVersion);
      result.Version:=C_Version;
      result.DateVersion:=C_Date;
      result.messageVersion:=C_messageVersion;
  end;
end.
