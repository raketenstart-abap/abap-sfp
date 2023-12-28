interface ZIF_SFP_PRINT
  public .


  methods EXECUTE
    importing
      !FUNCTION_NAME type FPNAME
      !OUTPUT_PARAMETERS type SFPOUTPUTPARAMS optional
      !DOCUMENT_PARAMETERS type SFPDOCPARAMS optional
    returning
      value(RESULT) type ref to ZCA_FILE
    raising
      ZCX_SFP_WRAP .
  methods PREVIEW
    importing
      !FUNCTION_NAME type FPNAME
    raising
      ZCX_SFP_WRAP .
endinterface.
