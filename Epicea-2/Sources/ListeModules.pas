unit ListeModules;

interface

uses TStringlistLGR,XMLDoc, SysUtils, Classes,Dialogs,xmldom,Forms,XMLIntf,IAutorisationsEpicea;
type
  TListeModuleLGR = class(TObject)
    fichier:String;
    listeModule:TStringlistLGR1;
    dateDerValidation:TDateTime;
    
    constructor Create;
    destructor Destroy;
  private
    { Déclarations privées }


  public
     { Déclarations publiques }
         interfaceAutorisation:IXMLAutorisation;
     XMLFichierAutorisation: iXMLDocument;
     function retourneListeAutorisationsLocale(fichier: String ):TStringlistLGR1;
    function ReturnFichierAutorisationsServeur(liste:TStringlistLGR1):String;
    function InitialiseXML(stream:TStringStream):boolean;
  end;

var
  ListeModuleLGR: TListeModuleLGR;


implementation


constructor TListeModuleLGR.Create;
    //constructeur
begin
fichier:='';
listeModule:=TStringlistLGR1.Create;
dateDerValidation:=0;
  inherited Create;
end;

destructor TListeModuleLGR.Destroy;
//destructeur
begin

  inherited Destroy;
end;


function TListeModuleLGR.retourneListeAutorisationsLocale(fichier: String ):TStringlistLGR1;
var
 retour : TStringlistLGR1;
 i:integer;
 stream:TStringStream;
begin


stream:=TStringStream.Create(fichier);

retour:=TStringlistLGR1.Create;
   XMLFichierAutorisation:=TXMLDocument.Create(Application.MainForm);
//   IsXMLWellFormed('C:\LGRDOSS\EPICEA\essai_autorisations_epicea.xml');
//   XMLFichierAutorisation.LoadFromFile('C:\LGRDOSS\EPICEA\essai_autorisations_epicea.xml');
//      XMLFichierAutorisation.LoadFromFile('C:\LGRDOSS\EPICEA\report_lancement.xml');

   XMLFichierAutorisation.LoadFromStream(stream);
   XMLFichierAutorisation.Active:=true;
 interfaceAutorisation:=Getauth(XMLFichierAutorisation);
   if (XMLFichierAutorisation.DocumentElement = nil) then showmessage('');

for i:=0 to interfaceAutorisation.Modules.Count-1 do
  begin
  try

     retour.Add(interfaceAutorisation.Modules.Module[i].Nommodule);
  except
  end;

  end;

Result:= retour;

end;

function TListeModuleLGR.ReturnFichierAutorisationsServeur(liste:TStringlistLGR1):String;
var i:integer;
listeModule:TListeModuleLGR;
 stream:TStringStream;
Begin
  try
    InitialiseXML(stream);
   interfaceAutorisation:=Getauth(XMLFichierAutorisation);

     listeModule:=TListeModuleLGR.Create;
     for i:=0 to liste.Count-1 do
     begin
        interfaceAutorisation.Modules.Add.Nommodule:=liste.Strings[i];
     end;
     stream:=TStringStream.Create(interfaceAutorisation.XML);
    interfaceAutorisation.OwnerDocument.SaveToStream(stream);
    interfaceAutorisation.OwnerDocument.active:=false;
    result:=stream.DataString;
  except

  end;
End;


function TListeModuleLGR.InitialiseXML(stream:TStringStream):boolean;
var
  TexteNewFichierUtil:string;


begin

   XMLFichierAutorisation:=TXMLDocument.Create(Application.MainForm);
   stream :=TStringStream.Create('<?xml version="1.0" encoding="utf-8"?>'+'<auth>'+'</auth>');
   XMLFichierAutorisation.LoadFromStream(stream);
   XMLFichierAutorisation.Active:=true;


end;


end.
