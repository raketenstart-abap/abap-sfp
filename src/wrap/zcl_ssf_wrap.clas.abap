CLASS zcl_ssf_wrap DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_ssf_wrap .

    CONSTANTS sc_destination TYPE rspopname VALUE 'LP01' ##NO_TEXT.
    CONSTANTS yes TYPE abap_bool VALUE 'X' ##NO_TEXT.
    CONSTANTS no TYPE abap_bool VALUE space ##NO_TEXT.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SSF_WRAP IMPLEMENTATION.


  METHOD zif_ssf_wrap~ssf_function_module_name.

    CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
      EXPORTING
        formname           = iv_form_name
      IMPORTING
        fm_name            = result
      EXCEPTIONS
        no_form            = 1
        no_function_module = 2
        OTHERS             = 3.

    CASE sy-subrc.
      WHEN 0.
        RETURN.

      WHEN 1.
        RAISE EXCEPTION TYPE zcx_ssf_wrap
          EXPORTING
            textid = zcx_ssf_wrap=>form_not_found.

      WHEN 2.
        RAISE EXCEPTION TYPE zcx_ssf_wrap
          EXPORTING
            textid = zcx_ssf_wrap=>function_module_not_found.

      WHEN OTHERS.
        RAISE EXCEPTION TYPE zcx_ssf_wrap.
    ENDCASE.

  ENDMETHOD.


  METHOD zif_ssf_wrap~ssf_get_device_type.

    CALL FUNCTION 'SSF_GET_DEVICE_TYPE'
      EXPORTING
        i_language             = iv_language
        i_application          = iv_application
      IMPORTING
        e_devtype              = result
      EXCEPTIONS
        no_language            = 1
        language_not_installed = 2
        no_devtype_found       = 3
        system_error           = 4
        OTHERS                 = 5.

    CASE sy-subrc.
      WHEN 1
        OR 2.
        RAISE EXCEPTION TYPE zcx_ssf_wrap
          EXPORTING
            textid      = zcx_ssf_wrap=>language_not_accepted
            mv_language = sy-langu.
      WHEN 3.
        RAISE EXCEPTION TYPE zcx_ssf_wrap
          EXPORTING
            textid = zcx_ssf_wrap=>device_not_found.
      WHEN 4.
        RAISE EXCEPTION TYPE zcx_ssf_wrap
          EXPORTING
            textid = zcx_ssf_wrap=>system_error.
    ENDCASE.

  ENDMETHOD.
ENDCLASS.
