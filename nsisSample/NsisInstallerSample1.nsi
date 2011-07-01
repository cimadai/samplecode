; vim:sw=2:ts=2
;---------------------------------------------------------
; �f�X�N�g�b�v�փC���X�g�[��/���W�X�g���������݂̃T���v��
;---------------------------------------------------------

;---------------------------------------------------------
; �A�v���P�[�V�������
;---------------------------------------------------------
  !define PRODUCT_NAME "NsisInstallerSample1"
  !define PRODUCT_PUBLISHER "Sample Co., Ltd."
  !define PRODUCT_DIR_REGKEY "Software\${PRODUCT_NAME}"

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
  SetOutPath $INSTDIR
  ; �t�@�C���z�u(�t�H���_���Ȃ���Ύ����Ő���)
  File ${PRODUCT_NAME}.nsi

  ; ���W�X�g����������
  WriteRegStr HKCU "${PRODUCT_DIR_REGKEY}" "DisplayName" "${PRODUCT_NAME}"
  WriteRegDWORD HKCU "${PRODUCT_DIR_REGKEY}" "SomeValue" 100

  WriteUninstaller "uninstall.exe"
SectionEnd

;----------------------------------------------------------
; �V���[�g�J�b�g�쐬
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
  ; ���W�X�g���폜
  DeleteRegKey HKCU "${PRODUCT_DIR_REGKEY}"

  ; �t�@�C���폜
  Delete $INSTDIR\uninstall.exe
  Delete $INSTDIR\${PRODUCT_NAME}.nsi

  ; �X�^�[�g���j���[�̍폜
  Delete "$SMPROGRAMS\Sample.com\${PRODUCT_NAME}\Uninstall.lnk"
  RMDir "$SMPROGRAMS\Sample.com\${PRODUCT_NAME}"
  RMDir "$SMPROGRAMS\Sample.com"

  ; �f�B���N�g���폜
  RMDir "$INSTDIR"
SectionEnd
