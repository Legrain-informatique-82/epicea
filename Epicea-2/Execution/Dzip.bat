@echo off
rem exemple.bat %1 %2 %3
rem %1 : répertoire contenant 7z.exe
rem %2 : nom du fichier de destination exemple.zip

 
rem ---------------------------------------
rem Répertoire d'exécution de 7Zip

SET repzip=%1
 
rem ---------------------------------------
rem Répertoire à compresser

SET repacompresser=%2
 
rem ---------------------------------------
cd %repzip%
%repzip%\7za.exe x %repacompresser% -o"C:\poubelle\sauvegarde\"

SET errorzip=%ErrorLevel%

 
rem ---------------------------------------
rem retour du code erreur de 7Zip
exit %errorzip%
