unit DMXMLs;

interface

uses
  SysUtils, Classes,
  xmldom,
  XMLIntf,
  oxmldom,
  XMLDoc,
  Forms,
  Dialogs,
  LibFichREp,
  LibRessourceString,
  Gr_Librairie_Obj,
  E2_DEcl_REcords,
  msxmldom;

type
  TDMXml = class(TDataModule)
    XMLDocument1: TXMLDocument;
    XMLExportDossier: TXMLDocument;
    XMLImportDossier: TXMLDocument;
//    Function IndexNomUtil(NomUtil : string):Integer;
//    Function IndexNomEcran(NomUtil,NomEcran : string):Integer;
//    Function ValeurItem(NomUtil,NomItem:string):String;
//    Function ValeurItemEcran(NomUtil,NomEcran,NomItem:string):String;
//    Function ModifieItem(NomUtil,NomItem,NewValeur:string):String;
//    Function ModifieItemEcran(NomUtil,NomEcran,NomItem,NewValeur:string):String;
    Procedure ExportDossier(NomDos,CheminSauveDos:String);
    Function ImportDossier(NomDos,CheminSauveDos:String):Boolean;

    Function ModifieItemProgramme(NomVar,ValeurVar:string):Boolean;
    Function RetourneItemProgramme(NomVar:string):IxmlNode;
    Function RetourneValItemProgramme(NomVar:string):string;

    Function AjouteUtilisateur(NomUtil:string):boolean;
    Function RetourneItemUtilisateur(NomUtil:string):IXMLNode;

    Function RetourneItemEcran(NomUtil,NomEcran:string):IXMLNode;  //
    Function RetourneVarEcran( NomUtil,NomEcran:String):IXMLNode;
    Function RetourneItemVarEcran( NomUtil,NomEcran ,NomVar:String):IXMLNode;
    Function RetourneValItemVarEcran( NomUtil,NomEcran ,NomVar:String):String;
    Function ModifieVarEcran(NomUtil, NomEcran, NomVar, ValeurVar:string):boolean; // Ok

    Function AjouteDossier(NomDos,DirDos:string):boolean; // ok
    Function SupprimeDossier(NomDos:string):boolean; // ok
    Function RetourneItemDossier(NomDos:string):IXMLNode;  // OK
    Function RetourneVarDos(NomDos, NomVar:string):IXMLNode;  //
    Function RetourneValVarDos(NomDos, NomVar:string):String;  //
    Function ModifieVarDos(NomDos, NomVar, ValeurVar:string):boolean; // ok

    Function RetourneItemExo(NomDos,NomExo:string):IXMLNode;  //
    Function RetourneVarExo( NomDos,NomExo:String):IXMLNode;
    Function RetourneItemVarExo( NomDos,NomExo ,NomVar:String):IXMLNode;
    Function RetourneValItemVarExo( NomDos,NomExo ,NomVar:String):String;
    Function ModifieVarExo(NomDos, NomExo, NomVar, ValeurVar:string):boolean; // Ok

    Function GenereConfigUtil(Repertoire:String):boolean;
    Function SauveUserDef(NomUser:string):boolean;
    Function UserDef:string;
    procedure DataModuleCreate(Sender: TObject);
    procedure XMLDocument1AfterNodeChange(const Node: IXMLNode;
      ChangeType: TNodeChange);
    procedure XMLDocument1AfterOpen(Sender: TObject);
  private
    { Déclarations privées }

    Function AjouteEcran(NomUtil, NomEcran:string):IxmlNode;
    Function AjouteExo(NomDos, NomExo:string):IxmlNode;

  public
    { Déclarations publiques }
  end;

var
  DMXml: TDMXml;

implementation

{$R *.dfm}
//Function TDMXml.IndexNomUtil(NomUtil : string):Integer;
//var
//i:integer;
//begin
//  try
//    result := -1;
//    for i:=0 to XMLDocument1.DocumentElement.ChildNodes['utilisateur'].ChildNodes.Count-1 do
//     begin
//        if XMLDocument1.DocumentElement.ChildNodes[i].ChildNodes['nom'].Text = NomUtil
//       then
//        begin
//          result:=i;
//          exit;
//        end;
//     end;
//     if i=XMLDocument1.DocumentElement.ChildNodes['utilisateur'].ChildNodes.Count then result:=-1
//  except
//   result := -1;
//   showmessage('Erreur à la récup de DMXml.IndexUtil');
//   abort;
//  end;
//end;
//
//Function TDMXml.IndexNomEcran(NomUtil,NomEcran : string):Integer;
//var
//i,j:integer;
//begin
//  try
//    result := -1;
//     j:=IndexNomUtil(NomUtil);
////     XMLDocument1.DocumentElement.ChildNodes[j].ChildNodes['ecrans'].ChildNodes['ecran'].ChildNodes[NomItem].Text;
//     for i:=0 to XMLDocument1.DocumentElement.ChildNodes[j].ChildNodes['ecrans'].ChildNodes['ecran'].ChildNodes.Count-1 do
//     begin
//        if XMLDocument1.DocumentElement.ChildNodes[j].ChildNodes['ecrans'].ChildNodes['ecran'].ChildNodes[i].Text = NomEcran
//       then
//        begin
////          showmessage(XMLDocument1.DocumentElement.ChildNodes[j].ChildNodes['ecrans'].ChildNodes['ecran'].ChildNodes[i].Text);
//          result:=i;
//          exit;
//        end;
//     end;
//     if i=0 then result:=-1
//  except
//   result := -1;
//   showmessage('Erreur à la récup de DMXml.IndexNomEcran');
//   abort;
//  end;
//End;
//
//Function TDMXml.ValeurItem(NomUtil,NomItem:string):String;
//Begin
//
//if Uppercase(NomItem) = uppercase('nom') then
//result:=XMLDocument1.DocumentElement.ChildNodes[IndexNomUtil(NomUtil)].ChildNodes[NomItem].Text;
//
//if Uppercase(NomItem) = uppercase('name') then  //   ecrans
//result:=XMLDocument1.DocumentElement.ChildNodes[IndexNomUtil(NomUtil)].ChildNodes['ecrans'].ChildNodes['ecran'].ChildNodes[NomItem].Text;
//
//End;
//
//Function TDMXml.ValeurItemEcran(NomUtil,NomEcran,NomItem:string):String;
//var
//i,j:integer;
//Begin
//i:=IndexNomUtil(NomUtil);
//j:=IndexNomEcran(NomUtil,NomEcran);
//result:=XMLDocument1.DocumentElement.ChildNodes[i].ChildNodes['ecrans'].ChildNodes[j].ChildNodes['var'].ChildNodes[NomItem].Text
////if Uppercase(NomItem) = uppercase('nom') then
////result:=XMLDocument1.DocumentElement.ChildNodes[i].ChildNodes[NomItem].Text;
////
////if Uppercase(NomItem) = uppercase('name') then  //   ecrans
////result:=XMLDocument1.DocumentElement.ChildNodes[IndexNomUtil(NomUtil)].ChildNodes['ecrans'].ChildNodes['ecran'].ChildNodes['var'].ChildNodes[NomItem].Text;
//
//End;
//
//Function TDMXml.ModifieItem(NomUtil,NomItem,NewValeur:string):String;
//Begin
//
//  if NomItem = 'nom' then
//  XMLDocument1.DocumentElement.ChildNodes[IndexNomUtil(NomUtil)].ChildNodes[NomItem].Text := NewValeur;
//
//  if NomItem = 'name' then  // ecrans
//  XMLDocument1.DocumentElement.ChildNodes[IndexNomUtil(NomUtil)].ChildNodes['ecrans'].ChildNodes['ecran'].ChildNodes[NomItem].Text := NewValeur;
//
//  XMLDocument1.SaveToFile(XMLDocument1.FileName);
//
//  XMLDocument1.Active := false;
//  XMLDocument1.Active := true;
//
//End;
//
//Function TDMXml.ModifieItemEcran(NomUtil,NomEcran,NomItem,NewValeur:string):String;
//var
//i,j:integer;
//Begin
// i:=IndexNomUtil(NomUtil);
// j:=IndexNomEcran(NomUtil,NomEcran);
// if XMLDocument1.DocumentElement.ChildNodes[i].ChildNodes['ecrans'].ChildNodes[j].ChildNodes['var'].ChildNodes.IndexOf(NomItem) <> -1 then
//  XMLDocument1.DocumentElement.ChildNodes[i].ChildNodes['ecrans'].ChildNodes[j].ChildNodes['var'].ChildNodes[NomItem].Text := NewValeur
//  else
//   XMLDocument1.DocumentElement.ChildNodes[i].ChildNodes['ecrans'].ChildNodes[j].ChildNodes['var'].AddChild(NomItem).Text := NewValeur;
//
//  XMLDocument1.SaveToFile(XMLDocument1.FileName);
//
//  XMLDocument1.Active := false;
//  XMLDocument1.Active := true;
//
//End;
//
Procedure TDMXml.ExportDossier(NomDos,CheminSauveDos:String);
var
TexteNewFichierUtil:string;
Begin
 XMLExportDossier.Active := false;
 if FileExists(CheminSauveDos+'ExportDos.xml') then
    DeleteFile(CheminSauveDos+'ExportDos.xml');
 TexteNewFichierUtil:='<?xml version="1.0" encoding="iso-8859-1" ?>'+
                      '<config>'+
                      '<dossiers>'+
                        RetourneItemDossier(NomDos).XML+
                      '</dossiers>'+
                      '</config>';
 AjouterFichierTexte(CheminSauveDos+'ExportDos.xml',TexteNewFichierUtil);
 XMLExportDossier.FileName :=CheminSauveDos+'ExportDos.xml';
 XMLExportDossier.Active := true;
// XMLExportDossier.DocumentElement.AddChild('dossiers').ChildNodes.Add(RetourneItemDossier(NomDos).CloneNode(true));
// XMLExportDossier.SaveToFile('C:\Projet\Epicea-2\Execution\ComptaWeb\SauveDos.xml');
 XMLExportDossier.Active := false;
End;

function AddItem(NoeudPere,NoeudSource:IXMLNode):Boolean;
var
i:integer;
NoeudPereTmp,NodeAux:IXmlNode;
Begin
showmessage('AddItem : Ne marche pas, ne pas utiliser !!!');
abort;
showmessage('nbitem additem dossier'+inttostr(NoeudSource.ChildNodes.Count));

for i:=0 to NoeudSource.ChildNodes.Count-1 do
 begin
// if NoeudSource.ChildNodes.Get(i).ChildNodes.Count <> 0 then
  begin
    NoeudPereTmp:=NoeudPere.AddChild(NoeudSource.ChildNodes[i].NodeName);//.Text := 'eee';//NoeudSource.ChildNodes[i].Text;
    showmessage(NoeudSource.ChildNodes[i].NodeName);
    NodeAux :=  NoeudSource.ChildNodes.Get(i);
     if NodeAux.ChildNodes.Count > 0 then
      begin
//        if NodeAux
        showmessage('Noeud evec enfant '+NodeAux.ChildNodes[i].NodeName+' '+IntToStr(NodeAux.ChildNodes.Count));
//        showmessage('Noeud evec enfant '+NoeudSource.ChildNodes[i].NodeName+' '+IntToStr(NoeudSource.ChildNodes.Get(i).ChildNodes.Count));
      end;
  end
//  if NoeudSource.ChildNodes[i].HasChildNodes then
//   begin
//   end
//   else
//   begin
//   end;
 end;
//NoeudPere.AddChild(NoeudSource.NodeName).Text := 'ee';//NoeudSource.ChildNodes[0].Text;
End;

Function TDMXml.ImportDossier(NomDos,CheminSauveDos:String):Boolean;
var
XMLNode,XMLNodePere,XMLNodeSource:IxmlNode;
text:string;
Begin
showmessage('DMXml.ImportDossier : Ne marche pas, ne pas utiliser !!!');
abort;
  XMLNode:=nil;
  XMLNode:=RetourneItemDossier(NomDos);
  if XMLNode = nil then
   begin
    XMLImportDossier.FileName :=CheminSauveDos+'ExportDos.xml';
    XMLImportDossier.Active := true;
//    Text:= XMLImportDossier.DocumentElement.ChildNodes['config'].ChildNodes['dossiers'].ChildNodes['dossier'].xml;
//    Text:= XMLImportDossier.DocumentElement.ChildNodes['dossiers'].ChildNodes['dossier'].XML;
//    showmessage(text);
//    XMLNode:=XMLImportDossier.DocumentElement.ChildNodes['dossiers'].ChildNodes['dossier'];

    XMLNodePere:=XMLDocument1.DocumentElement.ChildNodes['dossiers'].AddChild('dossier');
    XMLNodeSource := XMLImportDossier.DocumentElement.ChildNodes['dossiers'].ChildNodes['dossier'];
    AddItem(XMLNodePere,XMLNodeSource);
    showmessage('nbitem import dossier'+inttostr(XMLImportDossier.DocumentElement.ChildNodes['dossiers'].ChildNodes['dossier'].ChildNodes.Count));
//    XMLNode.Text := text;
    //ChildNodes['config'].ChildNodes['dossiers'].xml;
//    XMLDocument1.DocumentElement.ChildNodes['dossiers'].ChildNodes.Add(XMLNode);
    //AddChild('dossier').NodeValue := text;
    //AddChild('dossier').Text := Text;
//    Text:= XMLImportDossier.DocumentElement.ChildNodes['config'].ChildNodes['dossiers'].Text;
//    showmessage(text);
//    Text:= XMLImportDossier.DocumentElement.ChildNodes['config'].Text;
//    showmessage(text);
    showmessage(XMLImportDossier.DocumentElement.ChildNodes['config'].ChildNodes['dossiers'].ChildNodes['dossier'].Text);
//    XMLDocument1.DocumentElement.AddChild(XMLImportDossier.DocumentElement.ChildNodes['config'].ChildNodes['dossiers'].ChildNodes['dossier'].Text);
//    showmessage(XMLImportDossier.DocumentElement.ChildNodes['config'].ChildNodes['dossiers'].ChildNodes['dossier'].Text);
//    XMLNode:=XMLDocument1.DocumentElement.ChildNodes['config'].ChildNodes['dossiers'].AddChild('dossier');
//    XMLImportDossier.DocumentElement.ChildNodes['config'].ChildNodes['dossiers'].ChildNodes['dossier'].ChildValues[XMLNode.Text];
//    showmessage(XMLImportDossier.DocumentElement.ChildNodes['config'].ChildNodes['dossiers'].ChildNodes['dossier'].Text);
    XMLDocument1.SaveToFile(XMLDocument1.FileName);
    XMLDocument1.Active := False;
    XMLDocument1.Active := True;
//    XMLDocument1.DocumentElement.ChildNodes['dossiers'].ChildNodes.Add(XMLImportDossier.DocumentElement.ChildNodes['dossiers'].ChildNodes['dossier'].CloneNode(False));
//    XMLExportDossier.DocumentElement.AddChild('dossiers').ChildNodes.Add(RetourneItemDossier(NomDos).CloneNode(true));
   End;
End;

Function TDMXml.ModifieItemProgramme(NomVar,ValeurVar:string):Boolean;
var
XMLNode:IxmlNode;
Begin
 try
  XMLNode:=RetourneItemProgramme(NomVar);
  if XMLNode = nil then
   begin
   
    ProtectObjetNil([DMXml,DMXml.XMLDocument1,TObject(DMXml.XMLDocument1.DocumentElement),TObject(DMXml.XMLDocument1.DocumentElement.ChildNodes['programme'])]);
    XMLNode:=DMXml.XMLDocument1.DocumentElement.ChildNodes['programme'].AddChild(NomVar);
    XMLNode.Text:=ValeurVar;
   end
   else
   begin
    XMLNode.Text:=ValeurVar;
   end;
 except
   result:=false;
   abort;
 end;
// PB le 28/09/03  DMXml.XMLDocument1.SaveToFile(DMXml.XMLDocument1.FileName);
End;

Function TDMXml.RetourneItemProgramme(NomVar:string):IxmlNode;
Begin
 try
 result:=nil;
  if DMXml.XMLDocument1.DocumentElement.ChildNodes['programme'].ChildNodes.IndexOf(NomVar) <> -1 then
   result:=DMXml.XMLDocument1.DocumentElement.ChildNodes['programme'].ChildNodes[NomVar];
// showmessage(DMXml.XMLDocument1.DocumentElement.ChildNodes['programme'].ChildNodes[NomVar].Text);
 except
  result:=nil;
  abort;
 end;
End;

Function TDMXml.RetourneValItemProgramme(NomVar:string):string;
Begin
 try
  result:=RetourneItemProgramme(NomVar).Text;
 except
  result:='';
 // abort;
 end;
End;

Function TDMXml.AjouteUtilisateur(NomUtil:string):boolean; // ok
var
XMLNode:IxmlNode;
Begin
XMLNode:=nil;
XMLNode:=RetourneItemUtilisateur(NomUtil);
if XMLNode = nil then
 begin
  XMLNode:=XMLDocument1.DocumentElement.ChildNodes['utilisateurs'].AddChild('utilisateur');
  XMLNode.AddChild('nom').Text := NomUtil;
  XMLNode.AddChild('ecrans');//.AddChild('ecran').AddChild('var');
// PB le 28/09/03  XMLDocument1.SaveToFile(XMLDocument1.FileName);

// PB le 28/09/03  XMLDocument1.Active := false;
// PB le 28/09/03  XMLDocument1.Active := true;
 end;
End;

Function TDMXml.AjouteEcran(NomUtil, NomEcran:string):IxmlNode; // Ok
var
XMLNode,XMLNodeEcran:IxmlNode;
Begin
XMLNode:=nil;
XMLNode:=RetourneItemUtilisateur(NomUtil);
if XMLNode <> nil then
 begin
  XMLNodeEcran := RetourneItemEcran(NomUtil, NomEcran);
  if XMLNodeEcran = nil then
   begin
    XMLNodeEcran:=XMLNode.ChildNodes['ecrans'].AddChild('ecran');
    XMLNodeEcran.AddChild('name').Text := NomEcran;
    XMLNodeEcran.AddChild('var');
// PB le 28/09/03    XMLDocument1.SaveToFile(XMLDocument1.FileName);

// PB le 28/09/03    XMLDocument1.Active := false;
// PB le 28/09/03    XMLDocument1.Active := true;
   end;
 end
 else
 begin
  showmessage('Erreur AjoutEcran ' +'L''utilisateur : '+NomUtil + 'n''existe pas !');
 end;
End;

Function TDMXml.ModifieVarEcran(NomUtil, NomEcran, NomVar, ValeurVar:string):boolean; // Ok
var
XMLNodeVar,XMLNodeItemVar,XMLNodeEcran:IxmlNode;
i:integer;
Begin
  XMLNodeEcran := RetourneItemEcran(NomUtil, NomEcran);
  if XMLNodeEcran = nil then
   begin
    XMLNodeEcran:=AjouteEcran(NomUtil,NomEcran);
   end;
  XMLNodeVar := RetourneVarEcran( NomUtil,NomEcran );
  if RetourneItemVarEcran(NomUtil,NomEcran,NomVar) = nil then
   XMLNodeVar.AddChild(NomVar).Text := ValeurVar
  else
   XMLNodeVar.ChildNodes[NomVar].Text := ValeurVar;
// PB le 28/09/03  XMLDocument1.SaveToFile(XMLDocument1.FileName);

// PB le 28/09/03    XMLDocument1.Active := false;
// PB le 28/09/03    XMLDocument1.Active := true;
//   end;
// end
// else
// begin
//  showmessage('Erreur AjoutEcran ' +'L''utilisateur : '+NomUtil + 'n''existe pas !');
// end;
End;

Function TDMXml.ModifieVarDos(NomDos, NomVar, ValeurVar:string):boolean; //
var
XMLNodeVar,XMLNodeItemVar,XMLNodeDos:IxmlNode;
i:integer;
Begin
  XMLNodeDos := RetourneItemDossier(NomDos);
  if XMLNodeDos <> nil then
   begin
    try
     XMLNodeDos.ChildValues[NomVar]; // Lève une exception si erreur de lecture
     XMLNodeDos.ChildNodes[NomVar].Text := ValeurVar;
    except
     XMLNodeDos.AddChild(NomVar).Text := ValeurVar;
     //showmessage('NomVar Dos n''existe pas');
    end;
   end;
//    XMLNodeEcran:=AjouteEcran(NomUtil,NomEcran);
//   end;
//  XMLNodeVar := RetourneVarEcr( NomUtil,NomEcran );
//  if RetourneItemVarEcran(NomUtil,NomEcran,NomVar) = nil then
//   XMLNodeVar.AddChild(NomVar).Text := ValeurVar
//  else
//   XMLNodeVar.ChildNodes[NomVar].Text := ValeurVar;

// PB le 28/09/03  XMLDocument1.SaveToFile(XMLDocument1.FileName);

// PB le 28/09/03    XMLDocument1.Active := false;
// PB le 28/09/03    XMLDocument1.Active := true;
//   end;
// end
// else
// begin
//  showmessage('Erreur AjoutEcran ' +'L''utilisateur : '+NomUtil + 'n''existe pas !');
// end;
End;

Function TDMXml.RetourneValVarDos(NomDos, NomVar:string):String;  //
Begin
try
  result:=RetourneVarDos(NomDos, NomVar).Text;;
except
  abort;
end;

End;

Function TDMXml.RetourneVarDos(NomDos, NomVar:string):IXMLNode;  //
var
XMLNodeVar,XMLNodeItemVar,XMLNodeDos:IxmlNode;
i:integer;
Begin
  XMLNodeDos := RetourneItemDossier(NomDos);
  if XMLNodeDos <> nil then
   begin
    try
     result:=nil;
     XMLNodeDos.ChildValues[NomVar]; // Lève une exception si erreur de lecture
     result:=XMLNodeDos.ChildNodes[NomVar];
//     showmessage(XMLNodeDos.ChildNodes[NomVar].Text);
    except
     result:=nil;
     showmessage('NomVar Dos n''existe pas');
    end;
   end;
//    XMLNodeEcran:=AjouteEcran(NomUtil,NomEcran);
//   end;
//  XMLNodeVar := RetourneVarEcr( NomUtil,NomEcran );
//  if RetourneItemVarEcran(NomUtil,NomEcran,NomVar) = nil then
//   XMLNodeVar.AddChild(NomVar).Text := ValeurVar
//  else
//   XMLNodeVar.ChildNodes[NomVar].Text := ValeurVar;

//  XMLDocument1.SaveToFile(XMLDocument1.FileName);
//
//    XMLDocument1.Active := false;
//    XMLDocument1.Active := true;
//   end;
// end
// else
// begin
//  showmessage('Erreur AjoutEcran ' +'L''utilisateur : '+NomUtil + 'n''existe pas !');
// end;
End;

Function TDMXml.RetourneItemUtilisateur(NomUtil:string):IXMLNode;  // OK
var
i:integer;
Begin
result:=nil;
i:=-1;
//j:=i;
//showmessage('Nb utilisateurs : ' + inttostr(XMLDocument1.DocumentElement.ChildNodes['utilisateurs'].ChildNodes.Count));
//showmessage('Nb utilisateur : ' + inttostr(XMLDocument1.DocumentElement.ChildNodes['utilisateurs'].ChildNodes['utilisateur'].ChildNodes.Count));
for i:=0 to XMLDocument1.DocumentElement.ChildNodes['utilisateurs'].ChildNodes.Count-1 do
 if XMLDocument1.DocumentElement.ChildNodes['utilisateurs'].ChildNodes[i].ChildNodes['nom'].text = NomUtil then
  begin
   result:=XMLDocument1.DocumentElement.ChildNodes['utilisateurs'].ChildNodes[i];
//   j:=i;
   break;
  end;
//ChildNodes['utilisateur'].
//i:=XMLDocument1.DocumentElement.ChildNodes['utilisateurs'].ChildNodes['utilisateur'].ChildNodes['nom'].ChildNodes.IndexOf(NomUtil);
//if j <>-1 then
// begin
//  result:=XMLDocument1.DocumentElement.ChildNodes['utilisateurs'].ChildNodes[j];
//  showmessage(XMLDocument1.DocumentElement.ChildNodes['utilisateurs'].ChildNodes[j].XML);
// end;
// else showmessage('non trouve');
End;

Function TDMXml.RetourneItemEcran(NomUtil,NomEcran:string):IXMLNode;  //  OK
var
i,j:integer;
XMLNode:IXMLNode;
Begin
result:=nil;
XMLNode := nil;
XMLNode:=RetourneItemUtilisateur(NomUtil);
i:=-1;
if XMLNode <> nil then
 begin
  for i:=0 to XMLNode.ChildNodes['ecrans'].ChildNodes.Count-1 do
   if XMLNode.ChildNodes['ecrans'].ChildNodes[i].ChildNodes['name'].text = NomEcran then
    begin
     result:=XMLNode.ChildNodes['ecrans'].ChildNodes[i];
     break;
    end;
  end;
//if result <> nil then
// begin
//  showmessage(XMLNode.ChildNodes['ecrans'].ChildNodes[i].XML);
// end
// else showmessage('non trouve');
End;

Function TDMXml.RetourneVarEcran( NomUtil,NomEcran :String):IXMLNode;
var
XMLNode:IXMLNode;
Begin
result:=nil;
XMLNode:=RetourneItemEcran(NomUtil,NomEcran);
if XMLNode <> nil then
 Result:=XMLNode.ChildNodes['var'];
//showmessage(Result.xml);
//
End;

Function TDMXml.RetourneItemVarEcran( NomUtil,NomEcran ,NomVar:String):IXMLNode; // OK
var
XMLNode:IXMLNode;
Begin
result:=nil;
XMLNode:=RetourneItemEcran(NomUtil,NomEcran);
//showmessage(XMLNode.xml);//
if XMLNode <> nil then
// if XMLNode.ChildNodes['var'].ChildNodes.IndexOf(NomVar) <> -1 then
 Result:=XMLNode.ChildNodes['var'].ChildNodes[NomVar];
//showmessage(Result.xml);//
End;

Function TDMXml.RetourneValItemVarEcran( NomUtil,NomEcran ,NomVar:String):String; // OK
Begin
  try
   result:='';
   result:=RetourneItemVarEcran( NomUtil,NomEcran ,NomVar).Text;
  except
   abort;
  end;
//showmessage(Result);//
End;


Function TDMXml.AjouteDossier(NomDos,DirDos:string):boolean; // ok
var
XMLNode:IxmlNode;
Begin
XMLNode:=nil;
XMLNode:=RetourneItemDossier(NomDos);
if XMLNode = nil then
 begin
  XMLNode:=XMLDocument1.DocumentElement.ChildNodes['dossiers'].AddChild('dossier');
  XMLNode.AddChild('NomDos').Text := NomDos;
  XMLNode.AddChild('Dirdos').Text := DirDos;
  XMLNode.AddChild('exercices');
// PB le 28/09/03  XMLDocument1.SaveToFile(XMLDocument1.FileName);

// PB le 28/09/03  XMLDocument1.Active := false;
// PB le 28/09/03  XMLDocument1.Active := true;
 end;
End;

Function TDMXml.SupprimeDossier(NomDos:string):boolean; // ok
var
XMLNode:IxmlNode;
Begin
XMLNode:=nil;
XMLNode:=RetourneItemDossier(NomDos);
if XMLNode <> nil then
 begin
//  XMLDocument1.DocumentElement.ChildNodes.Delete()
//  XMLNode.Text
//  XMLNode:=
  XMLDocument1.DocumentElement.ChildNodes['dossiers'].ChildNodes.Delete(NomDos)
//  AddChild('dossier');
//  XMLNode.AddChild('NomDos').Text := NomDos;
//  XMLNode.AddChild('Dirdos').Text := DirDos;
//  XMLNode.AddChild('exercices');
// PB le 28/09/03  XMLDocument1.SaveToFile(XMLDocument1.FileName);

// PB le 28/09/03  XMLDocument1.Active := false;
// PB le 28/09/03  XMLDocument1.Active := true;
 end;
End;

Function TDMXml.AjouteExo(NomDos, NomExo:string):IxmlNode;
var
XMLNode,XMLNodeExo:IxmlNode;
Begin
XMLNode:=nil;
XMLNode:=RetourneItemDossier(NomDos);
if XMLNode <> nil then
 begin
  XMLNodeExo := RetourneItemExo(NomDos, NomExo);
  if XMLNodeExo = nil then
   begin
    XMLNodeExo:=XMLNode.ChildNodes['exercices'].AddChild('exercice');
    XMLNodeExo.AddChild('NomExo').Text := NomExo;
    XMLNodeExo.AddChild('var');
// PB le 28/09/03    XMLDocument1.SaveToFile(XMLDocument1.FileName);

// PB le 28/09/03    XMLDocument1.Active := false;
// PB le 28/09/03    XMLDocument1.Active := true;
   end;
 end
 else
 begin
  showmessage('Erreur AjoutExo ' +'Le dossier : '+NomDos + 'n''existe pas !');
 end;
End;

Function TDMXml.RetourneItemDossier(NomDos:string):IXMLNode;  // OK
var
i:integer;
Begin
  result:=nil;
  for i:=0 to XMLDocument1.DocumentElement.ChildNodes['dossiers'].ChildNodes.Count-1 do
   if XMLDocument1.DocumentElement.ChildNodes['dossiers'].ChildNodes[i].ChildNodes['NomDos'].text = NomDos then
    begin
     result:=XMLDocument1.DocumentElement.ChildNodes['dossiers'].ChildNodes[i];
     break;
    end;
End;

Function TDMXml.RetourneItemExo(NomDos,NomExo:string):IXMLNode;  //
var
i,j:integer;
XMLNode:IXMLNode;
Begin
result:=nil;
XMLNode := nil;
XMLNode:=RetourneItemDossier(NomDos);
i:=-1;
if XMLNode <> nil then
 begin
  for i:=0 to XMLNode.ChildNodes['exercices'].ChildNodes.Count-1 do
   if XMLNode.ChildNodes['exercices'].ChildNodes[i].ChildNodes['NomExo'].text = NomExo then
    begin
     result:=XMLNode.ChildNodes['exercices'].ChildNodes[i];
     break;
    end;
  end;
//if result <> nil then
// begin
//  showmessage(XMLNode.ChildNodes['ecrans'].ChildNodes[i].XML);
// end
// else showmessage('non trouve');
end;

Function TDMXml.RetourneVarExo( NomDos,NomExo:String):IXMLNode;
var
XMLNode:IXMLNode;
Begin
result:=nil;
XMLNode:=RetourneItemExo(NomDos,NomExo);
if XMLNode <> nil then
 Result:=XMLNode.ChildNodes['var'];
//showmessage(Result.xml);
//
End;

Function TDMXml.RetourneItemVarExo( NomDos,NomExo ,NomVar:String):IXMLNode;
var
XMLNode:IXMLNode;
Begin
result:=nil;
XMLNode:=RetourneItemExo(NomDos,NomExo);
if XMLNode <> nil then
 if XMLNode.ChildNodes['var'].ChildNodes.IndexOf(NomVar) <> -1 then
 Result:=XMLNode.ChildNodes['var'].ChildNodes[NomVar];
//showmessage(Result.xml);//
End;

Function TDMXml.RetourneValItemVarExo( NomDos,NomExo ,NomVar:String):String;
var
XMLNode:IXMLNode;
Begin
result:='';
result:=RetourneItemVarExo(NomDos,NomExo ,NomVar).Text;
//showmessage(Result);//
End;

Function TDMXml.ModifieVarExo(NomDos, NomExo, NomVar, ValeurVar:string):boolean; // Ok
var
XMLNodeVar,XMLNodeItemVar,XMLNodeExo:IxmlNode;
i:integer;
Begin
  XMLNodeExo := RetourneItemExo(NomDos, NomExo);
  if XMLNodeExo = nil then
   begin
    XMLNodeExo:=AjouteExo(NomDos, NomExo);
   end;
  XMLNodeVar := RetourneVarExo( NomDos, NomExo);
  if RetourneItemVarExo(NomDos, NomExo,NomVar) = nil then
   XMLNodeVar.AddChild(NomVar).Text := ValeurVar
  else
   XMLNodeVar.ChildNodes[NomVar].Text := ValeurVar;
// PB le 28/09/03  XMLDocument1.SaveToFile(XMLDocument1.FileName);

// PB le 28/09/03    XMLDocument1.Active := false;
// PB le 28/09/03    XMLDocument1.Active := true;
End;

Function TDMXml.GenereConfigUtil(Repertoire:String):boolean;
var
TexteNewFichierUtil:String;
Begin
// <utilisateur>
//  <nom>Anonyme</nom>
//  <ecrans>
//    <ecran>
//     <name>Main</name>
//     <var>
//     </var>
//    </ecran>
//  </ecrans>
// </utilisateur>

if not FileExists(Repertoire+'ConfigUtil.xml') then
 begin
  TexteNewFichierUtil :='<?xml version="1.0" encoding="iso-8859-1" ?>'+
//                         '<config>'+
//                         '<utilisateur>'+
//                         '<nom>Anonyme</nom>'+
//                         '<ecrans>'+
//                         '<nomecran>Main</nomecran>'+
//                         '</ecrans>'+
//                         '</utilisateur>'+
//                         '</config>';

                           '<config>'+
                           '<programme>'+
                           ' <LastUser>'+C_NomUtilDEfaut+'</LastUser>'+
                           ' <QueryUser1></QueryUser1>'+
                           ' <QueryUser2>'+C_ValeurCleVide+'</QueryUser2>'+
                           '</programme>'+

                           '<utilisateurs>'+
                           '</utilisateurs>'+

                           '<dossiers>'+

                           ' <dossier>'+
                           '  <NomDos>'+C_NomDossierDemo+'</NomDos>'+
                           '   <'+CXML_DirDos+'>'+
                           ExtractFilePath(Application.ExeName)+ 'Demo'+
                           '   </DirDos>'+
                           '  <IDDos>0</IDDos>' +
                           '  <NomExo>'+C_NomExoDemo+'</NomExo>'+  // Indique le dernier exo utilisé
                           '  <exercices>'+
                           '    <exercice>'+
                           '     <NomExo>'+C_NomExoDemo+'</NomExo>'+
                           '     <var>'+
                           '     </var>'+
                           '    </exercice>'+
                           '  </exercices>'+
                           ' </dossier>'+

                           '</dossiers>'+
                           '</config>';

  AjouterFichierTexte(Repertoire+'ConfigUtil.xml',TexteNewFichierUtil);
  XMLDocument1.Active := false;
  XMLDocument1.FileName:=Repertoire+'ConfigUtil.xml';
  XMLDocument1.Active := true;

//  DMXml.AjouteUtilisateur('toto');
//  DMXml.ModifieVarEcran('toto','EcranVar','Var1','ValeurVar1');

//  AjouteUtilisateur('Phil');
//  AjouteUtilisateur('TEstAjout');
//  AjouteEcran('TEstAjout','EcranTEstAjout');
//  XMLDocument1.DocumentElement.Text := '<?xml version="1.0" encoding="iso-8859-1" ?>';
//  XMLDocument1.AddChild('config');
//  XMLDocument1.SaveToFile(Repertoire+'ConfigUtil.xml');
 end;
  XMLDocument1.Active := false;
  XMLDocument1.FileName:=Repertoire+'ConfigUtil.xml';
  XMLDocument1.Active := true;
End;

Function TDMXml.SauveUserDef(NomUser:String):boolean;
Begin
DMXml.XMLDocument1.DocumentElement.ChildNodes['programme'].ChildNodes['LastUser'].Text:=NomUser;
// PB le 28/09/03 DMXml.XMLDocument1.SaveToFile(DMXml.XMLDocument1.FileName);
End;

Function TDMXml.UserDef:string;
Begin
Result := 'Anonyme';
result:=DMXml.XMLDocument1.DocumentElement.ChildNodes['programme'].ChildNodes['LastUser'].Text;
//showmessage(DMXml.XMLDocument1.DocumentElement.ChildNodes['programme'].ChildNodes['LastUser'].XML);// childnodes['nom'].Text);
//showmessage(DMXml.XMLDocument1.DocumentElement.ChildNodes[1].childnodes['nom'].Text);
End;

procedure TDMXml.DataModuleCreate(Sender: TObject);
begin
//XMLDocument1.Active := true;
end;

procedure TDMXml.XMLDocument1AfterNodeChange(const Node: IXMLNode;
  ChangeType: TNodeChange);
begin
//showmessage(node.Text);
end;

procedure TDMXml.XMLDocument1AfterOpen(Sender: TObject);
var
i:integer;
begin
//XMLDocument1.DocumentElement.ChildNodes[0].ChildNodes['nom'].ChildNodes['ecrans'].ChildNodes['nomecran'].Text;
//showmessage(XMLDocument1.XML.Strings[0]); affiche la première ligne de config du fichier xml
//showmessage(XMLDocument1.XML.Strings[1]); affiche la deuxième ligne de config du fichier xml
//showmessage(XMLDocument1.XML.Strings[2]); affiche le contenu du fichier xml
//XMLDocument1.DocumentElement.ChildNodes.Count-1
//showmessage(XMLDocument1.DocumentElement.ChildNodes[2].ChildNodes['nom'].Text);
//showmessage(XMLDocument1.DocumentElement.ChildNodes[0].ChildNodes['ecrans'].ChildNodes['nomecran'].Text);
//showmessage(XMLDocument1.DocumentElement.ChildNodes[1].ChildNodes['nom'].Text);
//i:=IndexNomUtil('Toto');
//    for i:=0 to XMLDocument1.DocumentElement.ChildNodes.Count-1 do
//     showmessage(XMLDocument1.DocumentElement.ChildNodes[0].ChildNodes['nom'].Text);
//     if XMLDocument1.DocumentElement.ChildNodes[i].ChildNodes['nom'].Text = NomUtil
//showmessage(XMLDocument1.DocumentElement.ChildNodes[i].ChildNodes['nom'].Text);
//showmessage(XMLDocument1.DocumentElement.ChildNodes[i].ChildNodes['ecrans'].ChildNodes['nomecran'].Text);
//showmessage(Valeuritem('Anonyme','nomecran'));
//Node.ChildValues['utilisateur']);

end;

end.
