interface ZIF_SFP_WRAP
  public .


  methods FP_FUNCTION_MODULE_CALL
    importing
      !IV_FORM_NAME type FUNCNAME
      !IS_DOCPARAMS type SFPDOCPARAMS optional
    returning
      value(RESULT) type FPFORMOUTPUT
    raising
      ZCX_SFP_WRAP .
  methods FP_FUNCTION_MODULE_NAME
    importing
      !IV_FORM_NAME type FPNAME
    returning
      value(RESULT) type ZST_SFP_FUNCTION_MODULE_WRAP
    raising
      ZCX_SFP_WRAP .
  methods FP_JOB_CLOSE
    raising
      ZCX_SFP_WRAP .
  methods FP_JOB_OPEN
    importing
      !IS_OUTPUT_PARAMS type SFPOUTPUTPARAMS
    raising
      ZCX_SFP_WRAP .
endinterface.
