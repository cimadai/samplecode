; vim:sw=2:ts=2
;---------------------------------------------------------
; ���ȉ𓀃A�[�J�C�u(��)�̃T���v��
;---------------------------------------------------------

;---------------------------------------------------------
; �A�v���P�[�V�������
;---------------------------------------------------------
  !define PRODUCT_NAME "NsisInstallerSample3"
  !define PRODUCT_PUBLISHER "Sample Co., Ltd."

;---------------------------------------------------------
; �e��ݒ�
;---------------------------------------------------------
  Caption "${PRODUCT_NAME} Setup"
  BrandingText "${PRODUCT_PUBLISHER}"
  InstallDir "$EXEDIR\NsisInstallerSample3"
  ShowInstDetails hide

  OutFile "${PRODUCT_NAME}.exe"

  ; ���[�U�[�����ŃC���X�g�[��
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

