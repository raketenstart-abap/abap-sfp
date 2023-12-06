INTERFACE zif_core_sfp_wrap
  PUBLIC .


  METHODS fp_function_module_name
    IMPORTING
      !iv_form_name TYPE fpname
    RETURNING
      VALUE(result) TYPE zcore_sfp_function_module
    RAISING
      zcx_core_sfp_wrap .
  METHODS fp_job_close
    RAISING
      zcx_core_sfp_wrap .
  METHODS fp_job_open
    IMPORTING
      !is_output_params TYPE sfpoutputparams
    RAISING
      zcx_core_sfp_wrap .
ENDINTERFACE.
