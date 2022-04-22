Répertoire des plugins:
Si ces DLL sont copiées dans le répertoire plugin de l'installation de NSIS, ce répertoire est inutile
et l'instruction : !addplugindir "pluginsNSIS" au début du fichier n'est plus nécessaire.

DLL:
version.dll - pour détecter la version de Windows
http://nsis.sourceforge.net/Detect_Windows_Version

nsSCM.dll - pour le controle des services windows 
http://nsis.sourceforge.net/NsSCM_plug-in

FindProcDLL.dll - pour savoir si un processus est actif
http://nsis.sourceforge.net/FindProcDLL_plug-in