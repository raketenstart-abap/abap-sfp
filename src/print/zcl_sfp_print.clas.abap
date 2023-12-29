CLASS zcl_sfp_print DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_sfp_print .

    METHODS constructor
      IMPORTING
        !io_sfp_wrap TYPE REF TO zif_sfp_wrap OPTIONAL .
  PROTECTED SECTION.
private section.

  data MO_SFP_WRAP type ref to ZIF_SFP_WRAP .

  methods CALL
    importing
      !FORM_NAME type FUNCNAME
      !DOCPARAMS type SFPDOCPARAMS optional
    returning
      value(RESULT) type FPFORMOUTPUT
    raising
      ZCX_SFP_WRAP .
ENDCLASS.



CLASS ZCL_SFP_PRINT IMPLEMENTATION.


  METHOD call.

    result = mo_sfp_wrap->fp_function_module_call(
      iv_form_name = form_name
      is_docparams = docparams
    ).

  ENDMETHOD.


  METHOD constructor.

    IF io_sfp_wrap IS BOUND.
      mo_sfp_wrap = io_sfp_wrap.
    ELSE.
      CREATE OBJECT mo_sfp_wrap TYPE zcl_sfp_wrap.
    ENDIF.

  ENDMETHOD.


  METHOD zif_sfp_print~execute.

    DATA ls_function_module_wrap TYPE zst_sfp_function_module_wrap.
    DATA ls_output_parameters    TYPE sfpoutputparams.
    DATA ls_function_output      TYPE fpformoutput.

    MOVE-CORRESPONDING output_parameters TO ls_output_parameters.

    ls_output_parameters-nodialog = zcl_ssf_wrap=>yes.
    ls_output_parameters-dest     = zcl_ssf_wrap=>sc_destination.
    ls_output_parameters-reqnew   = zcl_ssf_wrap=>yes.
    ls_output_parameters-getpdf   = zcl_ssf_wrap=>yes.

*   " job open
    mo_sfp_wrap->fp_job_open( ls_output_parameters ).

    ls_function_module_wrap = mo_sfp_wrap->fp_function_module_name( function_name ).

    ls_function_output = call(
      form_name = ls_function_module_wrap-function_name
      docparams = document_parameters
    ).

*   " job close
    mo_sfp_wrap->fp_job_close( ).

    DATA ls_file_props TYPE zst_file_props.
    ls_file_props-raw = ls_function_output-pdf.

    CREATE OBJECT result TYPE zcl_file
      EXPORTING
        props = ls_file_props.

  ENDMETHOD.


  METHOD zif_sfp_print~preview.

    DATA ls_function_module_wrap TYPE zst_sfp_function_module_wrap.
    DATA ls_output_parameters    TYPE sfpoutputparams.

    mo_sfp_wrap->fp_job_open( ls_output_parameters ).

    ls_function_module_wrap = mo_sfp_wrap->fp_function_module_name( function_name ).

    call(
      form_name = ls_function_module_wrap-function_name
    ).

    mo_sfp_wrap->fp_job_close( ).

  ENDMETHOD.
ENDCLASS.
