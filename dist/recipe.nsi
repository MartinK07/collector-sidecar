; -------------------------------
; Start
 
 
  Name "Graylog Sidecar"
  !define MUI_FILE "savefile"
  !define MUI_BRANDINGTEXT "Graylog Sidecar v0.0.1"
  CRCCheck On
 
  !include "${NSISDIR}\Contrib\Modern UI\System.nsh"
 
 
;---------------------------------
;General
 
  OutFile "sidecar_installer.exe"
  ShowInstDetails "nevershow"
  ShowUninstDetails "nevershow"
  ;SetCompressor "bzip2"
 
  ;!define MUI_ICON ""
  ;!define MUI_UNICON ""
  ;!define MUI_SPECIALBITMAP ""
 
 
;--------------------------------
;Folder selection page
 
  InstallDir "$PROGRAMFILES\graylog\sidecar"
 
 
;--------------------------------
;Modern UI Configuration
 
  !define MUI_WELCOMEPAGE  
  !define MUI_LICENSEPAGE
  !define MUI_DIRECTORYPAGE
  !define MUI_ABORTWARNING
  !define MUI_UNINSTALLER
  !define MUI_UNCONFIRMPAGE
  !define MUI_FINISHPAGE  
 
 
;--------------------------------
;Language
 
  !insertmacro MUI_LANGUAGE "English"
 
 
;-------------------------------- 
;Modern UI System
 
  ;!insertmacro MUI_SYSTEM 
 
 
;--------------------------------
;Data
 
  LicenseData "../LICENSE"
 
 
;-------------------------------- 
;Installer Sections     
Section "Install"
 
;Add files
  SetOutPath "$INSTDIR\generated"  
  SetOutPath "$INSTDIR"
 
  File "../sidecar.exe"
  File /oname=sidecar.ini "../sidecar_windows.ini"
  File "../LICENSE"

  WriteUninstaller "$INSTDIR\uninstall.exe"
 
SectionEnd
 
 
;--------------------------------    
;Uninstaller Section  
Section "Uninstall"
 
;Delete Files 
  RMDir /r "$INSTDIR\*.*"    
 
;Remove the installation directory
  RMDir "$INSTDIR"
  RMDir "$PROGRAMFILES\graylog"
 
SectionEnd
 
 
;--------------------------------    
;MessageBox Section
 
 
;Function that calls a messagebox when installation finished correctly
Function .onInstSuccess
  MessageBox MB_OK "You have successfully installed Graylog Sidecar."
FunctionEnd
 
 
Function un.onUninstSuccess
  MessageBox MB_OK "You have successfully uninstalled Graylog Sidecar."
FunctionEnd