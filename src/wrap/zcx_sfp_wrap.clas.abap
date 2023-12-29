CLASS zcx_sfp_wrap DEFINITION
  PUBLIC
  INHERITING FROM zcx_root
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS:
      BEGIN OF form_not_found,
        msgid TYPE symsgid VALUE 'Z_ABAP_SFP',
        msgno TYPE symsgno VALUE '000',
        attr1 TYPE scx_attrname VALUE 'MV_FORM_NAME',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF form_not_found .
    CONSTANTS:
      BEGIN OF job_open_fail,
        msgid TYPE symsgid VALUE 'Z_ABAP_SFP',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF job_open_fail .
    CONSTANTS:
      BEGIN OF job_close_fail,
        msgid TYPE symsgid VALUE 'Z_ABAP_SFP',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF job_close_fail .
    CONSTANTS:
      BEGIN OF api_repository_not_reached,
        msgid TYPE symsgid VALUE 'Z_ABAP_SFP',
        msgno TYPE symsgno VALUE '008',
        attr1 TYPE scx_attrname VALUE 'MV_MESSAGE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF api_repository_not_reached .
    CONSTANTS:
      BEGIN OF api_repository_usage_error,
        msgid TYPE symsgid VALUE 'Z_ABAP_SFP',
        msgno TYPE symsgno VALUE '009',
        attr1 TYPE scx_attrname VALUE 'MV_MESSAGE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF api_repository_usage_error .
    CONSTANTS:
      BEGIN OF api_repository_internal_error,
        msgid TYPE symsgid VALUE 'Z_ABAP_SFP',
        msgno TYPE symsgno VALUE '010',
        attr1 TYPE scx_attrname VALUE 'MV_MESSAGE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF api_repository_internal_error .
    DATA mv_form_name TYPE fpname .
    DATA mv_message TYPE string .

    METHODS constructor
      IMPORTING
        !textid       LIKE if_t100_message=>t100key OPTIONAL
        !previous     LIKE previous OPTIONAL
        !mv_form_name TYPE fpname OPTIONAL
        !mv_message   TYPE string OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCX_SFP_WRAP IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.
    me->mv_form_name = mv_form_name .
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
