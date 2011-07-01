; vim:sw=2:ts=2
;---------------------------------------------------------
; 自作DLL読み込みのサンプル
;---------------------------------------------------------
!addplugindir ".\plugins"

;---------------------------------------------------------
; アプリケーション情報
;---------------------------------------------------------
  !define PRODUCT_NAME "NsisInstallerSample2"
  !define PRODUCT_PUBLISHER "Sample Co., Ltd."

;---------------------------------------------------------
; 各種設定
;---------------------------------------------------------
  Caption "${PRODUCT_NAME} Setup"
  BrandingText "${PRODUCT_PUBLISHER}"

  ; アプリケーション名
  Name "${PRODUCT_NAME}"

  ; インストール先の設定
  !define PRODUCT_BASE_DIR "$LOCALAPPDATA\${PRODUCT_NAME}"
  InstallDir $DESKTOP\${PRODUCT_NAME}

  OutFile "${PRODUCT_NAME}.exe"

  ; Request application privileges for Windows Vista
  RequestExecutionLevel user

;---------------------------------------------------------
; Pages
;---------------------------------------------------------
  Page directory
  Page instfiles

  UninstPage uninstConfirm
  UninstPage instfiles

Function .onInit
FunctionEnd

Section ""
  ; 何もファイルは配置しない
  nsisPluginSample::messageBox "タイトル" "メッセージ"
  nsisPluginSample::sayHello
  nsisPluginSample::showMami
SectionEnd

;--------------------------------
; Uninstaller
Section "Uninstall"
  ; 何もファイルは配置してないので削除もしない
SectionEnd
