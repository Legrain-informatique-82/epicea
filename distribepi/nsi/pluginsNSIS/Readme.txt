R�pertoire des plugins:
Si ces DLL sont copi�es dans le r�pertoire plugin de l'installation de NSIS, ce r�pertoire est inutile
et l'instruction : !addplugindir "pluginsNSIS" au d�but du fichier n'est plus n�cessaire.

DLL:
version.dll - pour d�tecter la version de Windows
http://nsis.sourceforge.net/Detect_Windows_Version

nsSCM.dll - pour le controle des services windows 
http://nsis.sourceforge.net/NsSCM_plug-in

FindProcDLL.dll - pour savoir si un processus est actif
http://nsis.sourceforge.net/FindProcDLL_plug-in