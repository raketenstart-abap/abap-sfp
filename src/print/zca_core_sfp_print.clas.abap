CLASS zca_core_sfp_print DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !io_sfp_wrap TYPE REF TO zif_core_sfp_wrap OPTIONAL .
  PROTECTED SECTION.

    DATA mo_sfp_wrap TYPE REF TO zif_core_sfp_wrap .

    METHODS close
      RAISING
        zcx_core_sfp_wrap .
    METHODS preview_form
      IMPORTING
        !iv_function_name TYPE fpname
      RETURNING
        VALUE(result)     TYPE zcore_sfp_function_module
      RAISING
        zcx_root .
    METHODS read_form
      IMPORTING
        !iv_function_name TYPE fpname
      RETURNING
        VALUE(result)     TYPE zcore_sfp_function_module
      RAISING
        zcx_root .
  PRIVATE SECTION.
ENDCLASS.



CLASS zca_core_sfp_print IMPLEMENTATION.


  METHOD close.

    mo_sfp_wrap->fp_job_close( ).

  ENDMETHOD.


  METHOD constructor.

    IF io_sfp_wrap IS BOUND.
      mo_sfp_wrap = io_sfp_wrap.
    ELSE.
      CREATE OBJECT mo_sfp_wrap TYPE zcl_core_sfp_wrap.
    ENDIF.

  ENDMETHOD.


  METHOD preview_form.

    DATA ls_output_params TYPE sfpoutputparams.

    TRY.
        mo_sfp_wrap->fp_job_open( ls_output_params ).

        result = mo_sfp_wrap->fp_function_module_name( iv_function_name ).

      CATCH zcx_core_sfp_wrap INTO DATA(lx_core_sfp_wrap).
        RAISE EXCEPTION TYPE zcx_root
          EXPORTING
            previous = lx_core_sfp_wrap.
    ENDTRY.

  ENDMETHOD.


  METHOD read_form.

    DATA ls_output_params TYPE sfpoutputparams.

    ls_output_params-nodialog = zcl_core_ssf_wrap=>yes.
    ls_output_params-dest     = zcl_core_ssf_wrap=>sc_destination.
    ls_output_params-reqnew   = zcl_core_ssf_wrap=>yes.
    ls_output_params-getpdf   = zcl_core_ssf_wrap=>yes.

    TRY.
        mo_sfp_wrap->fp_job_open( ls_output_params ).

        result = mo_sfp_wrap->fp_function_module_name( iv_function_name ).

      CATCH zcx_core_sfp_wrap INTO DATA(lx_core_sfp_wrap).
        RAISE EXCEPTION TYPE zcx_root
          EXPORTING
            previous = lx_core_sfp_wrap.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
