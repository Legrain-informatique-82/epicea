unit ScruteFichiers;
{principe d'utilisation :                                                       }
{SruteDossier explore votre disque dur � partir du dossier "Dossier"            }
{il ne prend que les fichiers corespondants au filtre "filtre" (ex :*.htm)      }
{et il ne prend que les fichiers ayant pour attribut "attributs" (mettre FaAnyFile pour tous les fichiers}
{si r�cursif est � true, alors il explore tous les sous dossiers                }
{Lorsqu'il trouve un fichier, il d�clenche la proc�dure PAdeclencherFichier     }
{Lorsqu'il trouve un dossier, il d�clenche la proc�dure PAdeclencherDossier     }
{Par d�faut ces proc�dures ne font rien. Vous pouvez cr�er par exemple une proc�dure

procedure maprocedure(NomFic:String;objet:Tobject);
begin
    ..ce que vous voulez faire; NomFic est le nom du fichier trouv�
end
avant de lancer ScruteDossier, il suffit de faire PAdeclencherFichier:=MaProcedure
pour que ce soit votre proc�dure qui soit d�clench�e lorsque SruteDossier trouve un fichier
Vous pouvez faire de m�me pour PADeclencheDossier}


interface

uses   Windows, Messages, SysUtils, Classes, Controls, Forms,Dialogs;

type TFDeclenche=procedure(NomFic:String;objet:Tobject);

var PAdeclencherFichier : TFDeclenche;
    PAdeclencherDossier : TFDeclenche;

Procedure ScruteDossier(Dossier:string;filtre:string;attributs:integer;recursif:boolean);

implementation

uses E2_CreatDos;

Procedure vide(Nom:String;objet:Tobject);
begin
//showmessage(Nom);
end;

Procedure videDos(Nom:String;objet:Tobject);
begin
showmessage(Nom);
end;

Procedure ScruteFichier(Dossier:string;filtre:string;Attributs:integer);
var FichierTrouve:string;
    Resultat:Integer;
    SearchRec:TSearchRec;
begin
  If Dossier[length(Dossier)]='\' then Dossier:=copy(Dossier,1,length(Dossier)-1);
  Resultat:=FindFirst(Dossier+'\'+filtre,Attributs,SearchRec);
  while Resultat=0 do
  begin
    Application.ProcessMessages; // rend la main � windows pour qu'il traite les autres applications (�vite que l'application garde trop longtemps la main
     if ((SearchRec.Attr and faDirectory)<=0) then // On a trouv� un Fichier (et non un dossier)
    begin
      FichierTrouve:=Dossier+'\'+SearchRec.Name;
      PAdeclencherFichier(Dossier+'\'+SearchRec.Name,nil);// FICHIER TROUVE : DECLENCHEMENT DE NOTRE PROCEDURE
    end;
    Resultat:=FindNext(SearchRec);
  end;
  FindClose(SearchRec);// lib�ration de la m�moire
end;


Procedure ScruteDossier(Dossier:string;filtre:string;attributs:integer;recursif:boolean);
var DossierTrouve:string;
    Resultat:Integer;
    SearchRec:TSearchRec;
begin
  If Dossier[length(Dossier)]='\' then Dossier:=copy(Dossier,1,length(Dossier)-1); // s'il y a un '\' � la fin, je le retire
//  ScruteFichier(Dossier,filtre,attributs); //pour trouver les fichiers du dossier
  Resultat:=FindFirst(Dossier+'\'+'*.*',FaDirectory{ + faHidden + faSysFile },SearchRec); //permet de trouver le premier sous dossier de Dossier
  while Resultat=0 do                                           // SearchRec contient tous les renseignements concernant le dossier trouv�
  begin
   if (SearchRec.Name<>'.') and (SearchRec.Name<>'..')
         and ((SearchRec.Attr and faDirectory)>0)then // C'est comme cela que je teste si on a trouv� un Dossier et non un fichier
    begin
      DossierTrouve:=Dossier+'\'+SearchRec.Name; // pour avoir le nom du dossier avec le chemin complet
//      DossierTrouve:=SearchRec.Name; // pour avoir le nom du dossier sans le chemin
      PADeclencherDossier(DossierTrouve,nil);// DOSSIER TROUVE : DECLENCHEMENT DE NOTRE PROCEDURE
      if recursif then
      begin
        ScruteDossier(DossierTrouve,filtre,attributs,recursif);// je relance la recherche mais cette fois � partir du dossier trouv�
      end;
      Application.ProcessMessages; // rend la main � windows pour qu'il traite les autres applications (�vite que l'application garde trop longtemps la main
    end;
    Resultat:=FindNext(SearchRec); // permet de trouver les sous dosssiers suivants
  end;
  FindClose(SearchRec);// lib�ration de la m�moire
end;


begin       // partie initialisation. Cette partie est d�clench�e en premier par Delphi
  PAdeclencherFichier:=vide;
  PAdeclencherDossier:=RempliTreeView;
end.
