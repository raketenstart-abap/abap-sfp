CLASS zcl_sfp_wrap DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_sfp_wrap .
  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS build_exceptions
      RETURNING
        VALUE(result) TYPE abap_func_excpbind_tab .
ENDCLASS.



CLASS ZCL_SFP_WRAP IMPLEMENTATION.


  METHOD build_exceptions.

    DATA ls_exception TYPE abap_func_excpbind.

    ls_exception-name = 'USAGE_ERROR'.
    ls_exception-value = 1.
    INSERT ls_exception INTO TABLE result.

    ls_exception-name = 'SYSTEM_ERROR'.
    ls_exception-value = 2.
    INSERT ls_exception INTO TABLE result.

    ls_exception-name = 'INTERNAL_ERROR'.
    ls_exception-value = 3.
    INSERT ls_exception INTO TABLE result.

    ls_exception-name = 'OTHERS'.
    ls_exception-value = 10.
    INSERT ls_exception INTO TABLE result.

  ENDMETHOD.


  METHOD zif_sfp_wrap~fp_function_module_call.

    DATA lt_parameters TYPE abap_func_parmbind_tab.
    DATA ls_parameter  TYPE abap_func_parmbind.
    DATA lt_exceptions TYPE abap_func_excpbind_tab.

    ls_parameter-name = '/1BCDWB/DOCPARAMS'.
    ls_parameter-kind = abap_func_exporting.
    GET REFERENCE OF is_docparams INTO ls_parameter-value.
    INSERT ls_parameter INTO TABLE lt_parameters.

    ls_parameter-name = '/1BCDWB/FORMOUTPUT'.
    ls_parameter-kind = abap_func_importing.
    GET REFERENCE OF result INTO ls_parameter-value.
    INSERT ls_parameter INTO TABLE lt_parameters.

    lt_exceptions = build_exceptions( ).

    CALL FUNCTION iv_form_name
      PARAMETER-TABLE lt_parameters
      EXCEPTION-TABLE lt_exceptions.

    IF sy-subrc <> 0.
      DATA(ls_bapiret) = zcl_core_bapiret_utils=>build_bapiret_from_syst( ).
      DATA(lv_message) = ls_bapiret-message.

      RAISE EXCEPTION TYPE zcx_sfp_wrap
        EXPORTING
          textid       = zcx_sfp_wrap=>form_not_found
          mv_form_name = iv_form_name.
    ENDIF.

  ENDMETHOD.


  METHOD zif_sfp_wrap~fp_function_module_name.

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
        cx_fp_api_internal   = 3
        OTHERS               = 4.

    IF result IS INITIAL.
      RAISE EXCEPTION TYPE zcx_sfp_wrap
        EXPORTING
          textid       = zcx_sfp_wrap=>form_not_found
          mv_form_name = iv_form_name.
    ENDIF.

  ENDMETHOD.


  METHOD zif_sfp_wrap~fp_job_close.

    CALL FUNCTION 'FP_JOB_CLOSE'
      EXCEPTIONS
        usage_error    = 1
        system_error   = 2
        internal_error = 3
        OTHERS         = 4.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_sfp_wrap
        EXPORTING
          textid = zcx_sfp_wrap=>job_close_fail.
    ENDIF.

  ENDMETHOD.


  METHOD zif_sfp_wrap~fp_job_open.

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
      RAISE EXCEPTION TYPE zcx_sfp_wrap
        EXPORTING
          textid = zcx_sfp_wrap=>job_open_fail.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
