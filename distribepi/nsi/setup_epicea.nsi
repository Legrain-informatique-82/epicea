; ----------------------------------------
; - Programme    : Epicea-2 Windows      -
; - Version      : 1.0                   -
; - Copyright    : Le Grain S.A. 2009    -
; - NSIS version : (2.12) => 2.46        -
; - Auteur       : Nicolas               -
; ----------------------------------------
!addplugindir "pluginsNSIS" ; Repertoire contenant les plugins NSIS non standards

SetCompressor lzma ; zlib:probleme de compilation sur les 64bits

;Var VERSION_GENEREE
!include 'LogicLib.nsh'
;!include UAC.nsh ;
;!define UACSTR.I.ElvAbortReqAdmin "This fancy app requires admin rights fool" ;
;!include LogicLib.nsh ; Instructions logiques
;!include "Locate.nsh"
!include x64.nsh

!ifndef TYPE_VERSION
!define TYPE_VERSION "saisie-demo"
!endif



!ifndef REPERTOIRE_EXPORT_RCP
;!define REPERTOIRE_EXPORT_RCP "C:\Projet\distribepi\"
!define REPERTOIRE_EXPORT_RCP "E:\workspace_cd_legrain\distribepi\"
!endif

!ifndef NOM_SETUP
!define NOM_SETUP "setup_epi.exe"
!endif

;"Constantes"
;!define REPERTOIRE_EXPORT_RCP "C:\Projet\Epicea-2\Setup Epicea\Epicea fichiers pour setup de decembre 2008\"
!define INTALLEUR_BDE "setupBde.exe"
!define INSTALLEUR_SHOWMYPC "ShowMyPC.exe"
!define INIT_CLIENT "..\commun\InitClient.exe"
;!define INTALLEUR_JRE_32 "jre-7u9-windows-i586.exe"
!define INTALLEUR_JRE_32 "jre-7u25-windows-i586.exe"
!define INTALLEUR_JRE_64 "jre-7u25-windows-x64.exe"
;!define INTALLEUR_TOMCAT "apache-tomcat-7.0.33.exe"
!define INTALLEUR_TOMCAT "apache-tomcat-7.0.41.exe" 
!define INTALLEUR_BIRT "birt_4.2.1.war"
;!define INIT_VERSION "..\commun\InitVersion.exe"

!define REPERTOIRE_FICHCIER_COMMUN "${REPERTOIRE_EXPORT_RCP}commun"

!define BDE_INSTALL_DLL "BDEINST.dll"

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Epicea-2 Win"
!define PRODUCT_VERSION "2.0"
!define PRODUCT_VERSION_DETAIL "2.0.0.3"
!define PRODUCT_PUBLISHER "Le Grain Informatique"
!define PUBLISHER_WEB_SITE "http://www.legrain.fr"
!define PRODUCT_WEB_SITE "http://www.legrain.fr"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_HEADERIMAGE                                                                          
  ;!define MUI_HEADERIMAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Header\win.bmp"
  !define MUI_HEADERIMAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Header\nsis.bmp" ; optional
;!define MUI_HEADERIMAGE_BITMAP "modern-header 2.bmp"
!define MUI_COMPONENTSPAGE_CHECKBITMAP "${NSISDIR}\Contrib\Graphics\Checks\simple-round2.bmp"
  ;!define MUI_WELCOMEFINISHPAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Wizard\orange.bmp"

!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; ----------------------------- Liste des pages ----------------------------------                       

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page                     
!define MUI_LICENSEPAGE_CHECKBOX "1"
!insertmacro MUI_PAGE_LICENSE "${REPERTOIRE_FICHCIER_COMMUN}/Licence.rtf"
;Page de selection des composants
!insertmacro MUI_PAGE_COMPONENTS
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\epicea2.exe"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "French"

; MUI end ------

;------------------------------- Description des sections ---------------------------
;LangString DESC_SEC__DESINSTALL_BUREAU_DE_GESTION ${LANG_FRENCH} "Desinstallation d'Epicea."
LangString DESC_SEC_BUREAU_DE_GESTION ${LANG_FRENCH} "Epicea."

;-------------------------------- Global ---------------------------------------------
Name "${PRODUCT_NAME}" ;"${PRODUCT_NAME} ${PRODUCT_VERSION}"
XPStyle on
OutFile "${NOM_SETUP}"
InstallDir "$PROGRAMFILES\Lgr\Epicea"
ShowInstDetails show
ShowUnInstDetails show
Brandingtext "Le Grain Informatique (NSIS v2.46)"
;"NullSoft Install System v2.12"

;Informations pour l'onglet "version" des proprietes du setup
VIProductVersion "${PRODUCT_VERSION_DETAIL}"
VIAddVersionKey /LANG=${LANG_FRENCH} ProductName "${PRODUCT_NAME}"
VIAddVersionKey ProductVersion "${PRODUCT_VERSION}"
VIAddVersionKey /LANG=${LANG_FRENCH} CompanyName "${PRODUCT_PUBLISHER}"
VIAddVersionKey /LANG=${LANG_FRENCH} CompanyWebsite "${PUBLISHER_WEB_SITE}"
VIAddVersionKey /LANG=${LANG_FRENCH} FileVersion ""
VIAddVersionKey /LANG=${LANG_FRENCH} FileDescription "${PRODUCT_NAME}"
VIAddVersionKey /LANG=${LANG_FRENCH} LegalCopyright "${PRODUCT_PUBLISHER}"

;------------------------------- Sections -------------------------------------------

Section "Epicea" SEC_BUREAU_DE_GESTION
  SectionIn RO ;toujours coche
  Call installBDE
  
  ;Call installBDEAlias
  SetOutPath "$INSTDIR"
  ;File /r /x *.svn "${REPERTOIRE_FICHCIER_COMMUN}/"
  
  File /r /x *.svn "${REPERTOIRE_FICHCIER_COMMUN}\"
  ;File /r "${REPERTOIRE_FICHCIER_VERSION}"
  
Call initClient

;Call initVersion

Call installJava
Call installTomcat

SetOutPath "$INSTDIR\..\Tomcat\webapps\"
  File /oname=birt.war "${INTALLEUR_BIRT}"

;strcmp ${TYPE_VERSION} "normal" 0 +2
;File /r /x *.svn "${REPERTOIRE_EXPORT_RCP}\normal\" 
;strcmp ${TYPE_VERSION} "cogere" 0 +2
;File /r /x *.svn "${REPERTOIRE_EXPORT_RCP}\cogere\" 
;strcmp ${TYPE_VERSION} "demo" 0 +2
;File /r /x *.svn "${REPERTOIRE_EXPORT_RCP}\demo\"
;strcmp ${TYPE_VERSION} "saisie_normal" 0 +2
;File /r /x *.svn "${REPERTOIRE_EXPORT_RCP}\saisie\"
;strcmp ${TYPE_VERSION} "saisie_demo" 0 +2
;File /r /x *.svn "${REPERTOIRE_EXPORT_RCP}\saisie-demo\" 
;strcmp ${TYPE_VERSION} "saisie_cogere" 0 +2
;File /r /x *.svn "${REPERTOIRE_EXPORT_RCP}\saisie-cogere\"   
  
;!define REPERTOIRE_FICHCIER_VERSION "${REPERTOIRE_EXPORT_RCP}/${VERSION_GENEREE}/"
;  File /r "${REPERTOIRE_EXPORT_RCP}/$VERSION_GENEREE"

  CreateDirectory "$INSTDIR\..\Utilitaires"
  SetOutPath "$INSTDIR\..\Utilitaires"
  File "${REPERTOIRE_FICHCIER_COMMUN}\${INSTALLEUR_SHOWMYPC}"
  SetOutPath "$INSTDIR"
SectionEnd

;Insertion des description des sections
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  ;!insertmacro MUI_DESCRIPTION_TEXT ${SEC_DESINSTALL_BUREAU_DE_GESTION} $(DESC_SEC__DESINSTALL_BUREAU_DE_GESTION)
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_BUREAU_DE_GESTION} $(DESC_SEC_BUREAU_DE_GESTION)

!insertmacro MUI_FUNCTION_DESCRIPTION_END

Section -AdditionalIcons
  WriteIniStr "$INSTDIR\${PRODUCT_PUBLISHER}.url" "InternetShortcut" "URL" "${PUBLISHER_WEB_SITE}"
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  
  WriteIniStr "$INSTDIR\Tout sur gwi-hosting.com.url" "InternetShortcut" "URL" "http://www.gwi-hosting.com/"
  WriteIniStr "$INSTDIR\A la une - Actualites.url" "InternetShortcut" "URL" "http://www.legrain.fr/spip/"
  WriteIniStr "$INSTDIR\legrain.fr.url" "InternetShortcut" "URL" "http://www.legrain.fr"
  WriteIniStr "$INSTDIR\Support.url" "InternetShortcut" "URL" "http://www.legrain.fr/wiki"
  
  CreateDirectory "$SMPROGRAMS\Legrain\Epicea"
  CreateDirectory "$SMPROGRAMS\Legrain\Internet"
  CreateDirectory "$SMPROGRAMS\Legrain\Utilitaires"
  ;CreateShortCut "$SMPROGRAMS\Legrain\Epicea\Le Grain.lnk" "$INSTDIR\${PRODUCT_PUBLISHER}.url"
  ;CreateShortCut "$SMPROGRAMS\Legrain\Epicea\logiciel-gestion.fr.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  ;CreateShortCut "$SMPROGRAMS\Legrain\Epicea\Desinstallation.lnk" "$INSTDIR\uninst.exe"
  
  CreateShortCut "$SMPROGRAMS\Legrain\Internet\Tout sur gwi-hosting.com.lnk" "$INSTDIR\Tout sur gwi-hosting.com.url"
  CreateShortCut "$SMPROGRAMS\Legrain\A la une - Actualites.lnk" "$INSTDIR\A la une - Actualites.url"
  CreateShortCut "$SMPROGRAMS\Legrain\legrain.fr.lnk" "$INSTDIR\legrain.fr.url"
  CreateShortCut "$SMPROGRAMS\Legrain\Support.lnk" "$INSTDIR\Support.url"
  
  SetOutPath "$INSTDIR"
  CreateShortCut "$SMPROGRAMS\Legrain\Epicea\Epicea-2 Win.lnk" "$INSTDIR\epicea2.exe"
  CreateShortCut "$SMPROGRAMS\Legrain\Epicea\Restauration Epicea.lnk" "$INSTDIR\mdcogere.exe"
  CreateShortCut "$DESKTOP\Epicea-2 Win.lnk" "$INSTDIR\epicea2.exe"     
  CreateShortCut "$DESKTOP\Restauration Epicea.lnk" "$INSTDIR\mdcogere.exe"

  CreateShortCut "$SMPROGRAMS\Legrain\Utilitaires\ShowMyPC.lnk" "$INSTDIR\..\Utilitaires\${INSTALLEUR_SHOWMYPC}"
  CreateShortCut "$DESKTOP\ShowMyPC.lnk" "$INSTDIR\..\Utilitaires\${INSTALLEUR_SHOWMYPC}"

SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

;----------------------------------------- Fonctions --------------------------------------------------------- 
  ;RequestExecutionLevel user

Function .onInit

  InitPluginsDir
  ;${UAC.I.Elevate.AdminOnly}
  File /oname=$PLUGINSDIR\setupBde.exe "${INTALLEUR_BDE}"
  File /oname=$PLUGINSDIR\InitClient.exe "${INIT_CLIENT}"
  File /oname=$PLUGINSDIR\\install_jre32.exe "${INTALLEUR_JRE_32}"
  File /oname=$PLUGINSDIR\\install_jre64.exe "${INTALLEUR_JRE_64}"
  File /oname=$PLUGINSDIR\install_tomcat.exe "${INTALLEUR_TOMCAT}"
  ;File /oname=$PLUGINSDIR\InitVersion.exe "${INIT_VERSION}"
FunctionEnd

               
Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) a ete desinstalle avec succes de votre ordinateur."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Etes-vous certains de vouloir desinstaller totalement $(^Name) et tous ses composants ?" IDYES +2
  Abort
FunctionEnd

;Function installBDE
;  GetTempFileName $0
;  File /oname=$0 "${BDE_INSTALL_DLL}"
;  CallInstDLL $0 /NOUNLOAD DllRegisterServer
;FunctionEnd

Function installBDE
  DetailPrint "Installation BDE ..."
  SetDetailsPrint none
    ExecWait '$PLUGINSDIR\setupBde.exe /S /v/qn' ;
    ;ExecWait '$PLUGINSDIR\setupBde.exe'    ;
  SetDetailsPrint both
  DetailPrint "Installation BDE terminee."
FunctionEnd

Function installJava
  DetailPrint "Installation Java ..."
  DetailPrint "..."
  SetDetailsPrint none
  ExecWait 'net stop Tomcat7' ;
    
   ;CreateDirectory "$INSTDIR\..\jre"
   ;ExecWait '$PLUGINSDIR\install_jre32.exe /s "/qn INSTALLDIR=$INSTDIR\..\jre""';
    
   ; File /r "\var\opt\java\windows\jre1.7.0_09_x86\"
   
   ${If} ${RunningX64}
   			
   		${DisableX64FSRedirection} 
   		${Unless} ${FileExists} "$SYSDIR\javaw.exe"
   			;pas de jvm par defaut installée
   			;installation d'une jvm 64 bits par défaut car le setup de tomcat nécessite une jvm par défaut sur le systeme
   			;pour un OS 64bits, le setup de tomcat recherche en priorité une jvm 64 bits
        	ExecWait '$PLUGINSDIR\install_jre64.exe /s'
    	${EndUnless} 
    	${EnableX64FSRedirection} 
   		
   		;installation de la jvm "embarquée" pour le service tomcat et birt
   		;la jvm pour le service doit être du même type (32 ou 64 bits) que le service
   		SetOutPath "$PROGRAMFILES\Lgr\jre64"
   	 	CreateDirectory "$PROGRAMFILES\Lgr\jre64"
 		File /r "\var\opt\java\windows\jre7u25_64\"
 		 
  ${Else}
  
  		${Unless} ${FileExists} "$SYSDIR\javaw.exe" 
        	ExecWait '$PLUGINSDIR\install_jre32.exe /s'
    	${EndUnless} 
    
  		SetOutPath "$PROGRAMFILES\Lgr\jre32"
    	CreateDirectory "$PROGRAMFILES\Lgr\jre32"
 		File /r "\var\opt\java\windows\jre7u25_x86\" 
 		
  ${EndIf}
   
    
  SetDetailsPrint both
  DetailPrint "Installation de Java terminee."
FunctionEnd

Function installTomcat
	
  DetailPrint "Installation Tomcat..."
  DetailPrint "..."
  SetDetailsPrint none

  ;Desinstallation
  ${If} ${RunningX64}
    SetRegView 64
  ${EndIf}
  ReadRegStr $R0 HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Apache Tomcat 7.0 Tomcat7" "UninstallString"
  ;MessageBox MB_ICONINFORMATION|MB_OK "avant desinstalle"
  ExecWait '$R0 /S' ;
  ;MessageBox MB_ICONINFORMATION|MB_OK "apres desinstalle"
	
	;installation de tomcat et du service tomcat pour windows
	;sur un windows 64 bits, s'il y a une jvm par defaut 64 bits, le service 64bits est installé en priorité
	;si pas de jvm 64 bits par défaut, il utilise la 32 bits avec un service 32bits
	;si aucune jvm par défaut le setup de tomcat plante et l'installation de ne se fait pas
    ExecWait '$PLUGINSDIR\install_tomcat.exe /S /D=$INSTDIR\..\Tomcat' ;
    ExecWait '$INSTDIR\..\Tomcat\bin\tomcat7 //US//Tomcat7 --Startup=auto' ;
    ;ExecWait '$INSTDIR\..\Tomcat\bin\tomcat7 //US//Tomcat7 --Startup=manual' ;
    
     ${If} ${RunningX64}
   		    ExecWait '$PROGRAMFILES\Lgr\tomcat\bin\tomcat7 //US//Tomcat7 --JavaHome="$PROGRAMFILES\Lgr\jre64"' ;
    		ExecWait '$PROGRAMFILES\Lgr\tomcat\bin\tomcat7 //US//Tomcat7 --Jvm="$PROGRAMFILES\Lgr\jre64\bin\server\jvm.dll"' ;Sur windows les jvm 64 bits sont uniquement en server
  	${Else}
  		    ExecWait '$PROGRAMFILES\Lgr\tomcat\bin\tomcat7 //US//Tomcat7 --JavaHome="$PROGRAMFILES\Lgr\jre32"' ;
    		ExecWait '$PROGRAMFILES\Lgr\tomcat\bin\tomcat7 //US//Tomcat7 --Jvm="$PROGRAMFILES\Lgr\jre32\bin\client\jvm.dll"' ;Jvm 32 bits donc version client par defaut
  	${EndIf}
  
    ExecWait 'net start Tomcat7' ;

DeleteRegValue HKLM "Software\Microsoft\Windows\CurrentVersion\Run" "ApacheTomcatMonitor7.0_Tomcat7"
DeleteRegValue HKCU "Software\Microsoft\Windows\CurrentVersion\Run" "ApacheTomcatMonitor7.0_Tomcat7"

  SetDetailsPrint both
  DetailPrint "Installation de Tomcat terminee."
FunctionEnd

Function initClient
  DetailPrint "Initialisation du type de client ..."
  SetDetailsPrint none
  ExecWait '"$PLUGINSDIR\InitClient.exe" "$INSTDIR/InitClient.txt" "${TYPE_VERSION}"';
  SetDetailsPrint both
  DetailPrint "Initialisation du type de client terminee."
FunctionEnd

;Function initVersion
;  DetailPrint "Initialisation du num�ro de version ..."
 ; SetDetailsPrint none
 ; ExecWait '"$PLUGINSDIR\InitVersion.exe" "$INSTDIR/InitVersion.txt"';
 ; SetDetailsPrint both
 ; DetailPrint "Initialisation du num�ro de version terminee."
;FunctionEnd


;Le plugin BDEAlias est une dll, pour le faire fonctionner sur linux, il faudrait le re-compiler a partir des sources
;Cette fonction ne sert plus, les alias sont creees par l'install "setupBde" cree a partir des modules installShield Express
;Function installBDEAlias
;  BDEAlias::AddAlias '*A* Dossier' '*P* C:\Lgrdoss\EPICEA\demo' '*D* PARADOX' '*B* FALSE'
;  BDEAlias::AddAlias '*A* Exercice' '*P* C:\Lgrdoss\EPICEA\demo\exodemo' '*D* PARADOX' '*B* FALSE'
;  BDEAlias::AddAlias '*A* Program' '*P* C:\Program Files\Lgr\Epicea' '*D* PARADOX' '*B* FALSE'
;  BDEAlias::AddAlias '*A* ExoN1' '*P* C:\Lgrdoss\EPICEA\demo' '*D* PARADOX' '*B* FALSE'
;FunctionEnd

;---------------------------------------- UnInstall ------------------------------------------------------------

  
Section Uninstall
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"

  RMDir /r "$SMPROGRAMS\Legrain\Epicea"
  Delete "$DESKTOP\Epicea-2 Win.lnk"
  Delete "$DESKTOP\Restauration Epicea.lnk"
  
  Delete "$SMPROGRAMS\Legrain\Internet\Tout sur gwi-hosting.com.lnk"
  RMDir /r "$SMPROGRAMS\Legrain\Internet"
  
  Delete "$SMPROGRAMS\Legrain\A la une - Actualites.lnk"
  Delete "$SMPROGRAMS\Legrain\legrain.fr.lnk"
  Delete "$SMPROGRAMS\Legrain\Support.lnk"

  ;Delete "$SMPROGRAMS\Legrain\Utilitaires\ShowMyPC.lnk" 
  ;RMDir "$SMPROGRAMS\Legrain\Utilitaires"
  ;Delete "$DESKTOP\ShowMyPC.lnk" 

  RMDir "$SMPROGRAMS\Legrain\Epicea"
  
  Delete "$INSTDIR\*.exe"
  Delete "$INSTDIR\*.dll"
  Delete "$INSTDIR\*.bk"
  Delete "$INSTDIR\*.rtf"
  Delete "$INSTDIR\*.inf"
  Delete "$INSTDIR\*.bat"
  Delete "$INSTDIR\*.ini"
  Delete "$INSTDIR\*.txt"
  Delete "$INSTDIR\*.lnk"
  Delete "$INSTDIR\*.url"
  RMDir /r "$INSTDIR\Fiscal"
  RMDir /r "$INSTDIR\raccourcis_internet"
  
  
  ;RMDir /r "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  SetAutoClose true
SectionEnd
