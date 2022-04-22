unit LibGestionParamXML;

interface

uses SysUtils,Forms,Dialogs,
     E2_Librairie_Obj,
     E2_Decl_Records,
     Lib_Chaine,
     DMXMLs,
     LibRessourceString,
     GR_Librairie_Obj,
     LibFichRep;

procedure InitialiseForm(NomUtil:String;Form:TForm);
Procedure DestroyForm(Form:TForm;User:String);
Procedure SauveXMLAvantFermer;
Procedure RecupXmlDossier(NomDossier:String);
function RecupXmlDossierValeur(NomDossier,nomXml:String):String;
implementation

uses DiversProjets;

procedure InitialiseForm(NomUtil:String;Form:TForm);
var
NomEcran:String;
FWState : integer;
Begin
  try
    FWState:=0;

    Form.Left:= StrToInt(DMXml.RetourneValItemVarEcran(NomUtil,Form.name,'Left'));
    Form.Top:= StrToInt(DMXml.RetourneValItemVarEcran(NomUtil,Form.name,'Top'));

    if Form.BorderStyle <> bsDialog then
      begin
        Form.Width:= StrToInt(DMXml.RetourneValItemVarEcran(NomUtil,Form.name,'Width'));
        Form.Height:= StrToInt(DMXml.RetourneValItemVarEcran(NomUtil,Form.name,'Height'));
      end;
    FWState:= StrToInt(DMXml.RetourneValItemVarEcran(NomUtil,Form.name,'WState'));

    if ((FWstate=-1) or (FWState=0)) then
       Form.WindowState:=WsNormal
       else
       Form.WindowState:=WsMaximized;

  except
    Form.Position:=poScreenCenter;
    abort;
  end;
End;

Procedure DestroyForm(Form:TForm;User:String);
Var
FWstate:integer;
Begin
try
  FWstate:=FormEtat(form);
//  case FWstate of
//     -1,1: ;
//     0:Begin
//        DMXml.ModifieVarEcran(User,Form.Name,'Left',IntToStr(Form.Left));
//        DMXml.ModifieVarEcran(User,Form.Name,'Top',IntToStr(Form.Top));
//        DMXml.ModifieVarEcran(User,Form.Name,'Width',IntToStr(Form.Width));
//        DMXml.ModifieVarEcran(User,Form.Name,'Height',IntToStr(Form.Height));
//       End;
//  end;
        DMXml.ModifieVarEcran(User,Form.Name,'Left',IntToStr(Form.Left));
        DMXml.ModifieVarEcran(User,Form.Name,'Top',IntToStr(Form.Top));
        DMXml.ModifieVarEcran(User,Form.Name,'Width',IntToStr(Form.Width));
        DMXml.ModifieVarEcran(User,Form.Name,'Height',IntToStr(Form.Height));
  DMXml.ModifieVarEcran(User,Form.Name,'WState',IntToStr(FormEtat(form)));
//            WriteInteger('Wstate',FormEtat(form));
except
 showmessage('Erreur � l''�criture dans ConfUtil.xml');
End;
End;

Procedure SauveXMLAvantFermer;
Begin
//AjouterFichierTexte('C:\messagesEpicea','SauveXMLAvantFermer');
if DMXml = nil then DMXml:=TDMXml.Create(Application.MainForm);
// Sauve les param�tres du dossier en cours
DMXml.ModifieVarDos(E.NomDossier,CXML_DirDos,E.RepertoireDossier);
DMXml.ModifieVarDos(E.NomDossier,'IDDos',IntToStr(E.ID_Dos));
DMXml.ModifieVarDos(E.NomDossier,'NomDos',E.NomDossier);
DMXml.ModifieVarDos(E.NomDossier,'NomExo',E.NomExo);
DMXml.ModifieVarDos(E.NomDossier,'DirImp',E.RepertoireImportEPI_DOS);

DMXml.ModifieVarDos(E.NomDossier,CXML_RepImportationEpiDos,E.RepertoireImportationEpiDos);
DMXml.ModifieVarDos(E.NomDossier,CXML_RepImportationSIEA,E.RepertoireImportationSIEA);
DMXml.ModifieVarDos(E.NomDossier,CXML_RepImportation,E.RepertoireImportation);
DMXml.ModifieVarDos(E.NomDossier,CXML_RepExportationBalance,E.RepertoireExportBalance);
DMXml.ModifieVarDos(E.NomDossier,CXML_RepExportationLiasse,E.RepertoireExportLiasse);
DMXml.ModifieVarDos(E.NomDossier,CXML_RepExportationDossier,E.RepertoireExportDossier);

DMXml.ModifieVarDos(E.NomDossier,CXML_RepRelanceTiers,E.RepertoireRelanceTiers);
//AjouterFichierTexte('C:\messagesEpicea','E.NomDossier : '+E.NomDossier+' - CXML_ParamFTP : '+E.ParamFTP.Fichier);
DMXml.ModifieVarDos(E.NomDossier,CXML_ParamFTP,E.ParamFTP.Fichier);

DMXml.ModifieVarDos(E.NomDossier,CXML_RepTelechargementReleve,E.RepTelechargementReleve);


DMXml.ModifieVarDos(E.NomDossier,'TypeDossier',IntToStr(TypeDossierToInt(E.TypeDossier)));
DMXml.ModifieVarDos(E.NomDossier,'TypeDossierDemo',IntToStr(TypeDossierToInt(E.TypeDossierdemo)));

//Exo_A_Verifier:string;
DMXml.ModifieVarDos(E.NomDossier,CXML_Exo_A_Verifier,E.Exo_A_Verifier);
DMXml.ModifieVarDos(E.NomDossier,CXML_DateVersion,E.DateVersion);
DMXml.ModifieVarDos(E.NomDossier,CXML_PlanDeSaisie,str_bool2str_LGR(ParamUtil.PlanDeSaisie,'Oui','Non'));
DMXml.ModifieVarDos(E.NomDossier,CXML_RepDblSauvegarde,E.RepertoireDblSauvegarde);


DMXml.ModifieVarDos(E.NomDossier,CXML_CompteBanqueDefaut,E.CompteBanqueDefaut);

DMXml.ModifieVarDos(E.NomDossier,CXML_ComptePointableCaisseEnregistreuse,E.ComptePointableCaisseEnregistreuse);
DMXml.ModifieVarDos(E.NomDossier,CXML_TauxTvaCaisseEnregistreuse,E.TauxTvaCaisseEnregistreuse);

DMXml.ModifieItemProgramme(CXML_NomSauvegarde,E.NomSauvegarde);
DMXml.ModifieItemProgramme(CXML_RepSauvegardeFermeture,E.RepertoireSauvegardeFermture);
DMXml.ModifieItemProgramme(CXML_RepSauvegardeFermetureCloud,E.RepertoireSauvegardeFermtureCloud);
DMXml.ModifieItemProgramme('AutoriserSauvegardeFermeture',str_bool2str_LGR(E.AutoriserSauvegardeFermeture,'Oui','Non'));
DMXml.ModifieItemProgramme('AfficherMessageSauvegardeFermeture',str_bool2str_LGR(E.AfficherMessageSauvegardeFermeture,'Oui','Non'));


// Sauve les param�tres de l'exercice en cours
//showmessage('Sauve parametre exercice');
DMXml.ModifieVarExo(E.NomDossier,E.NomExo,'DirExo',E.RepertoireExercice);
DMXml.ModifieVarExo(E.NomDossier,E.NomExo,'IDExo',IntToStr(E.ID_Exo));
DMXml.ModifieVarExo(E.NomDossier,E.NomExo,'NomExo',E.NomExo);

End;

function RecupXmlDossierValeur(NomDossier,nomXml:String):String;
Begin
if DMXml = nil then DMXml:=TDMXml.Create(Application.MainForm);
result:=DMXml.RetourneValVarDos(NomDossier,nomXml);
End;

procedure RecupXmlDossier(NomDossier:String);
Begin
if DMXml = nil then DMXml:=TDMXml.Create(Application.MainForm);

E.RepertoireImportation:=DMXml.RetourneValVarDos(NomDossier,CXML_RepImportation);
E.RepertoireExportBalance:=DMXml.RetourneValVarDos(NomDossier,CXML_RepExportationBalance);
E.RepertoireExportLiasse:=DMXml.RetourneValVarDos(NomDossier,CXML_RepExportationLiasse);
E.RepertoireExportDossier:=DMXml.RetourneValVarDos(NomDossier,CXML_RepExportationDossier);

E.RepertoireRelanceTiers:=DMXml.RetourneValVarDos(NomDossier,CXML_RepRelanceTiers);
E.ParamFTP.Fichier:=DMXml.RetourneValVarDos(NomDossier,CXML_ParamFTP);

E.RepTelechargementReleve:=DMXml.RetourneValVarDos(NomDossier,CXML_RepTelechargementReleve);
E.RepertoireSauvegardeFermture:=DMXml.RetourneValItemProgramme(CXML_RepSauvegardeFermeture);
E.RepertoireSauvegardeFermtureCloud:=DMXml.RetourneValItemProgramme(CXML_RepSauvegardeFermeturecloud);
E.RepertoireDblSauvegarde:=DMXml.RetourneValVarDos(NomDossier,CXML_RepDblSauvegarde);
E.CompteBanqueDefaut := DMXml.RetourneValVarDos(NomDossier,CXML_CompteBanqueDefaut);
E.NomSauvegarde :=DMXml.RetourneValItemProgramme(CXML_NomSauvegarde);
E.ComptePointableCaisseEnregistreuse :=DMXml.RetourneValVarDos(NomDossier,CXML_ComptePointableCaisseEnregistreuse);
E.TauxTvaCaisseEnregistreuse :=DMXml.RetourneValVarDos(NomDossier,CXML_TauxTvaCaisseEnregistreuse);
End;

end.
