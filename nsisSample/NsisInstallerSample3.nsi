; vim:sw=2:ts=2
;---------------------------------------------------------
; 自己解凍アーカイブ(風)のサンプル
;---------------------------------------------------------

;---------------------------------------------------------
; アプリケーション情報
;---------------------------------------------------------
  !define PRODUCT_NAME "NsisInstallerSample3"
  !define PRODUCT_PUBLISHER "Sample Co., Ltd."

;---------------------------------------------------------
; 各種設定
;---------------------------------------------------------
  Caption "${PRODUCT_NAME} Setup"
  BrandingText "${PRODUCT_PUBLISHER}"
  InstallDir "$EXEDIR\NsisInstallerSample3"
  ShowInstDetails hide

  OutFile "${PRODUCT_NAME}.exe"

  ; ユーザー権限でインストール
  RequestExecutionLevel user

Section ""
  SetOverwrite try

  SetOutPath "$EXEDIR\NsisInstallerSample3\samples"
  File ".\NsisInstallerSample1.nsi"
  File ".\NsisInstallerSample2.nsi"
  File ".\NsisInstallerSample3.nsi"

  SetOutPath "$EXEDIR\NsisInstallerSample3\samples\plugins"
  File ".\plugins\nsisPluginSample.dll"

  SetAutoClose true
SectionEnd

