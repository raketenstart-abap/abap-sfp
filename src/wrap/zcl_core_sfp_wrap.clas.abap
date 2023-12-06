CLASS zcl_core_sfp_wrap DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_core_sfp_wrap .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CORE_SFP_WRAP IMPLEMENTATION.


  METHOD zif_core_sfp_wrap~fp_function_module_name.

    TRY.
        CALL FUNCTION 'FP_FUNCTION_MODULE_NAME'
          EXPORTING
            i_name               = iv_form_name
          IMPORTING
            e_funcname           = result-function_name
            e_interface_type     = result-interface_type
            ev_funcname_inbound  = result-function_name_inbound
          EXCEPTIONS
            cx_fp_api_repository = 1
            cx_fp_api_usage      = 2
            cx_fp_api_internal   = 3.

      CATCH cx_fp_api_repository ##NO_HANDLER.
    ENDTRY.

    IF result IS INITIAL.
      RAISE EXCEPTION TYPE zcx_core_sfp_wrap
        EXPORTING
          textid       = zcx_core_sfp_wrap=>form_not_found
          mv_form_name = iv_form_name.
    ENDIF.

  ENDMETHOD.


  METHOD zif_core_sfp_wrap~fp_job_close.

    CALL FUNCTION 'FP_JOB_CLOSE'
      EXCEPTIONS
        usage_error    = 1
        system_error   = 2
        internal_error = 3
        OTHERS         = 4.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_core_sfp_wrap
        EXPORTING
          textid = zcx_core_sfp_wrap=>job_close_fail.
    ENDIF.

  ENDMETHOD.


  METHOD zif_core_sfp_wrap~fp_job_open.

    DATA ls_output_params TYPE sfpoutputparams.

    ls_output_params = is_output_params.

    CALL FUNCTION 'FP_JOB_OPEN'
      CHANGING
        ie_outputparams = ls_output_params
      EXCEPTIONS
        cancel          = 1
        usage_error     = 2
        system_error    = 3
        internal_error  = 4
        OTHERS          = 5.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_core_sfp_wrap
        EXPORTING
          textid = zcx_core_sfp_wrap=>job_open_fail.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
