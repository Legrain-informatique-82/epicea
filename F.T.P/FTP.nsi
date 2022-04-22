;NSIS Modern User Interface version 1.63

!define MUI_PRODUCT "FTP" ;Define your own software name here
!define MUI_VERSION "1.0" ;Define your own software version here

!include "MUI.nsh"

;--------------------
;-- Configuration  --
;--------------------

  OutFile "FTP.exe"

  ;Page de selection du répertoire
  InstallDir "$PROGRAMFILES\${MUI_PRODUCT}"
  
  ;Mémorisation du répertoire d'insatllation
  InstallDirRegKey HKCU "Software\${MUI_PRODUCT}" ""
  
  ;Variable pour la gestion des raccourcis
  !define TEMP $R0

;--------------------------------------------
;-- Modern UI Configuration de l'interface --
;--------------------------------------------

  !define MUI_LICENSEPAGE
  !define MUI_WELCOMEPAGE
  !define MUI_COMPONENTSPAGE
  !define MUI_DIRECTORYPAGE
  !define MUI_FINISHPAGE
  
  !define MUI_ABORTWARNING
  
  !define MUI_UNINSTALLER
  !define MUI_UNCONFIRMPAGE
  
  !define MUI_ICON "${NSISDIR}\Contrib\Icons\setup.ico"
  !define MUI_UNICON "${NSISDIR}\Contrib\Icons\setup.ico"
  !define MUI_HEADERBITMAP "${NSISDIR}\Contrib\Icons\modern-header 2.bmp"
  !define MUI_SPECIALBITMAP "${NSISDIR}\Contrib\Icons\modern-wizard.bmp"
  
  !define MUI_STARTMENUPAGE
  !define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU" 
  !define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\${MUI_PRODUCT}" 
  !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"
  
  ;!define MUI_FINISHPAGE_RUN $INSTDIR\envoi_ftp.exe
  ;!define MUI_FINISHPAGE_RUN_NOTCHECKED
  
;----------------------------
;-- Langages de l'iterface --
;---------------------------- 
  !insertmacro MUI_LANGUAGE "French"
  
;------------------
;Language Strings

  ;Description des sections
  LangString DESC_SecCopyUI ${LANG_FRENCH} "Installation du client FTP."
  LangString DESC_SecCopyUI2 ${LANG_FRENCH} "Installation de l'aide."

;--------------------------------
;Donnée
  LicenseData /LANG=${LANG_FRENCH} "C:\ftp\Licence.txt"

;-------------------------------------------------------------------------------
;--------------------- Sections de l'installeur --------------------------------
;-------------------------------------------------------------------------------

Section "" Reg
;Section toujours exécutée
  ;Mémorisation du répertoire d'insatallation dans la base de registre
  WriteRegStr HKCU "Software\${MUI_PRODUCT}" "" $INSTDIR
  ;Ajout du programme dans le menu "Ajout/Suppression de programme" de Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ftp" "DisplayName" "ftp (remove only)"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ftp" "UninstallString" '"$INSTDIR\Uninstall.exe"'
  WriteUninstaller "$INSTDIR\Uninstall.exe"
SectionEnd

Section FTP SecCopyUI
  SectionIn RO ;toujours cocher
  SetOutPath "$INSTDIR"
 ; CreateDirectory "$INSTDIR\a"
  SetOutPath "$INSTDIR"
  File "C:\ftp\envoi_ftp.exe"
  File "C:\ftp\shdocvw.dll"
  File "C:\ftp\qtintf70.dll"
  File "C:\ftp\FTPparam.txt"
  
  !insertmacro MUI_STARTMENU_WRITE_BEGIN
  ;Création des raccourcis du menu démarrer et inscription dans la base de registre
    CreateDirectory "$SMPROGRAMS\${MUI_STARTMENUPAGE_VARIABLE}"
    CreateShortCut "$SMPROGRAMS\${MUI_STARTMENUPAGE_VARIABLE}\FTP.lnk" "$INSTDIR\envoi_ftp.exe"
    CreateShortCut "$DESKTOP\ftp.lnk" "$INSTDIR\envoi_ftp.exe"
    CreateShortCut "$SMPROGRAMS\${MUI_STARTMENUPAGE_VARIABLE}\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
  !insertmacro MUI_STARTMENU_WRITE_END
  
  WriteUninstaller "$INSTDIR\Uninstall.exe"
SectionEnd

Section "Aide" SecCopyUI2

  SetOutPath "$INSTDIR"
  ;CreateDirectory "$INSTDIR\b"
  SetOutPath "$INSTDIR"
  File "C:\ftp\*.htm"
  
  !insertmacro MUI_STARTMENU_WRITE_BEGIN
  ;Create shortcuts
    CreateDirectory "$SMPROGRAMS\${MUI_STARTMENUPAGE_VARIABLE}"
    CreateShortCut "$SMPROGRAMS\${MUI_STARTMENUPAGE_VARIABLE}\Aide.lnk" "$INSTDIR\aide.htm"
  !insertmacro MUI_STARTMENU_WRITE_END

SectionEnd

;Display the Finish header
;Insert this macro after the sections if you are not using a finish page
!insertmacro MUI_SECTIONS_FINISHHEADER

;--------------------------------
;Descriptions
;Insertion des description des sections
!insertmacro MUI_FUNCTIONS_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SecCopyUI} $(DESC_SecCopyUI)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecCopyUI2} $(DESC_SecCopyUI2)
!insertmacro MUI_FUNCTIONS_DESCRIPTION_END
 
;-------------------------------------------------------------------------------
;--------------------- Section du désinstalleur --------------------------------
;-------------------------------------------------------------------------------
Section "Uninstall"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ftp"
  Delete "$INSTDIR\Uninstall.exe"
  ;Delete "$INSTDIR\a\*.*"
  ;Delete "$INSTDIR\b\*.*"
  Delete "$INSTDIR\*.*"
  Delete "$DESKTOP\ftp.lnk"
 ; RMDir "$INSTDIR\a"
 ; RMDir "$INSTDIR\b"
  RMDir "$INSTDIR"
  
  ;supression des raccourcis du menu démarrer
  ReadRegStr ${TEMP} "${MUI_STARTMENUPAGE_REGISTRY_ROOT}" "${MUI_STARTMENUPAGE_REGISTRY_KEY}" "${MUI_STARTMENUPAGE_REGISTRY_VALUENAME}"
  StrCmp ${TEMP} "" noshortcuts
    Delete "$SMPROGRAMS\${TEMP}\FTP.lnk"
    Delete "$SMPROGRAMS\${TEMP}\Uninstall.lnk"
    Delete "$SMPROGRAMS\${TEMP}\Aide.lnk"
    RMDir "$SMPROGRAMS\${TEMP}" ;Only if empty, so it won't delete other shortcuts
  noshortcuts:

  DeleteRegKey /ifempty HKCU "Software\${MUI_PRODUCT}"
  
  ;Display the Finish header
  !insertmacro MUI_UNFINISHHEADER

SectionEnd