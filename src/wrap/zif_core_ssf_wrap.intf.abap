INTERFACE zif_core_ssf_wrap
  PUBLIC .


  METHODS ssf_get_device_type
    IMPORTING
      !iv_language    TYPE sylangu DEFAULT sy-langu
      !iv_application TYPE sfappl DEFAULT 'SAPDEFAULT'
    RETURNING
      VALUE(result)   TYPE rspoptype
    RAISING
      zcx_core_ssf_wrap .
  METHODS ssf_function_module_name
    IMPORTING
      !iv_form_name TYPE tdsfname
    RETURNING
      VALUE(result) TYPE rs38l_fnam
    RAISING
      zcx_core_ssf_wrap .
ENDINTERFACE.
