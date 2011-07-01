; vim:sw=2:ts=2
;---------------------------------------------------------
; ����DLL�ǂݍ��݂̃T���v��
;---------------------------------------------------------
!addplugindir ".\plugins"

;---------------------------------------------------------
; �A�v���P�[�V�������
;---------------------------------------------------------
  !define PRODUCT_NAME "NsisInstallerSample2"
  !define PRODUCT_PUBLISHER "Sample Co., Ltd."

;---------------------------------------------------------
; �e��ݒ�
;---------------------------------------------------------
  Caption "${PRODUCT_NAME} Setup"
  BrandingText "${PRODUCT_PUBLISHER}"

  ; �A�v���P�[�V������
  Name "${PRODUCT_NAME}"

  ; �C���X�g�[����̐ݒ�
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
  ; �����t�@�C���͔z�u���Ȃ�
  nsisPluginSample::messageBox "�^�C�g��" "���b�Z�[�W"
  nsisPluginSample::sayHello
  nsisPluginSample::showMami
SectionEnd

;--------------------------------
; Uninstaller
Section "Uninstall"
  ; �����t�@�C���͔z�u���ĂȂ��̂ō폜�����Ȃ�
SectionEnd
