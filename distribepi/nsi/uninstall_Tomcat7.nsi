; ----------------------------------------
; - Programme    : Epicea-2 Windows      -
; - Version      : 1.0                   -
; - Copyright    : Le Grain S.A. 2009    -
; - NSIS version : (2.12) => 2.46        -
; - Auteur       : Nicolas               -
; ----------------------------------------

SetCompressor lzma ; zlib:probleme de compilation sur les 64bits

;Var VERSION_GENEREE


!ifndef TYPE_VERSION
!define TYPE_VERSION "saisie-demo"
!endif



!ifndef REPERTOIRE_EXPORT_RCP
;!define REPERTOIRE_EXPORT_RCP "C:\Projet\distribepi\"
!define REPERTOIRE_EXPORT_RCP "E:\workspace_cd_legrain\distribepi\"
!endif

!ifndef NOM_SETUP
!define NOM_SETUP "uninstall_tomcat7.exe"
!endif

;"Constantes"
;!define REPERTOIRE_EXPORT_RCP "C:\Projet\Epicea-2\Setup Epicea\Epicea fichiers pour setup de decembre 2008\"


!define REPERTOIRE_FICHCIER_COMMUN "${REPERTOIRE_EXPORT_RCP}commun"


; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "uninstall tomcat 7"
!define PRODUCT_VERSION "2.0"
!define PRODUCT_VERSION_DETAIL "2.0.0.3"
!define PRODUCT_PUBLISHER "Le Grain Informatique"
!define PUBLISHER_WEB_SITE "http://www.legrain.fr"
!define PRODUCT_WEB_SITE "http://www.legrain.fr"


; ----------------------------- Liste des pages ----------------------------------                       


;------------------------------- Description des sections ---------------------------

;-------------------------------- Global ---------------------------------------------
Name "${PRODUCT_NAME}" ;"${PRODUCT_NAME} ${PRODUCT_VERSION}"
XPStyle on
OutFile "${NOM_SETUP}"
InstallDir "$PROGRAMFILES\Lgr\Epicea"
ShowInstDetails show
ShowUnInstDetails show
Brandingtext "Le Grain Informatique (NSIS v2.46)"
;"NullSoft Install System v2.12"

;------------------------------- Sections -------------------------------------------

Section "Epicea" SEC_BUREAU_DE_GESTION
  SectionIn RO ;toujours coche

  Call installTomcat

SectionEnd

;----------------------------------------- Fonctions --------------------------------------------------------- 

Function installTomcat
 ExecWait 'net stop Tomcat7' ;
	
  DetailPrint "Installation Tomcat..."
  DetailPrint "..."
SetRegView 64

ReadRegStr $R0 HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Apache Tomcat 7.0 Tomcat7" "UninstallString"
DetailPrint "aaa"
DetailPrint "$R0"
ExecWait '$R0 /S' ;


  SetDetailsPrint both
  DetailPrint "Installation de Tomcat terminee."
FunctionEnd
