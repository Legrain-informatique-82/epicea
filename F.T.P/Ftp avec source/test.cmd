@echo off
rem ####################################################################
rem Contenu de FTPparam.txt
rem nicolas
rem lgr006
rem linux
rem ####################################################################

rem ####################################################################
rem envoi un fichier
rem 
envoi_ftp.exe param.txt /test FTPparam.txt o a

rem envoi_ftp.exe AdbeRdr708_fr_FR.exe /test FTPparam.txt n a

rem ####################################################################
rem envoi les fichiers du répertoire courant
rem envoi_ftp.exe . /test FTPparam.txt n a

rem ####################################################################
rem reception (get)
rem envoi_ftp.exe . /test FTPparam.txt n ga