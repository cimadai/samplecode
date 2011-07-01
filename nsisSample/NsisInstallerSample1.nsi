; vim:sw=2:ts=2
;---------------------------------------------------------
; デスクトップへインストール/レジストリ書き込みのサンプル
;---------------------------------------------------------

;---------------------------------------------------------
; アプリケーション情報
;---------------------------------------------------------
  !define PRODUCT_NAME "NsisInstallerSample1"
  !define PRODUCT_PUBLISHER "Sample Co., Ltd."
  !define PRODUCT_DIR_REGKEY "Software\${PRODUCT_NAME}"

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
  SetOutPath $INSTDIR
  ; ファイル配置(フォルダがなければ自動で生成)
  File ${PRODUCT_NAME}.nsi

  ; レジストリ書き込み
  WriteRegStr HKCU "${PRODUCT_DIR_REGKEY}" "DisplayName" "${PRODUCT_NAME}"
  WriteRegDWORD HKCU "${PRODUCT_DIR_REGKEY}" "SomeValue" 100

  WriteUninstaller "uninstall.exe"
SectionEnd

;----------------------------------------------------------
; ショートカット作成
;----------------------------------------------------------
Section -AdditionalIcons
  SetOutPath $INSTDIR
  CreateDirectory "$SMPROGRAMS\Sample.com"
  CreateDirectory "$SMPROGRAMS\Sample.com\${PRODUCT_NAME}"
  CreateShortCut "$SMPROGRAMS\Sample.com\${PRODUCT_NAME}\Uninstall.lnk" "$INSTDIR\uninstall.exe"
SectionEnd

;--------------------------------
; Uninstaller
Section "Uninstall"
  ; レジストリ削除
  DeleteRegKey HKCU "${PRODUCT_DIR_REGKEY}"

  ; ファイル削除
  Delete $INSTDIR\uninstall.exe
  Delete $INSTDIR\${PRODUCT_NAME}.nsi

  ; スタートメニューの削除
  Delete "$SMPROGRAMS\Sample.com\${PRODUCT_NAME}\Uninstall.lnk"
  RMDir "$SMPROGRAMS\Sample.com\${PRODUCT_NAME}"
  RMDir "$SMPROGRAMS\Sample.com"

  ; ディレクトリ削除
  RMDir "$INSTDIR"
SectionEnd
