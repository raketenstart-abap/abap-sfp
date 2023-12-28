CLASS zcx_ssf_wrap DEFINITION
  PUBLIC
  INHERITING FROM zcx_root
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS:
      BEGIN OF language_not_accepted,
        msgid TYPE symsgid VALUE 'Z_ABAP_SFP',
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE 'MV_LANGUAGE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF language_not_accepted .
    CONSTANTS:
      BEGIN OF device_not_found,
        msgid TYPE symsgid VALUE 'Z_ABAP_SFP',
        msgno TYPE symsgno VALUE '004',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF device_not_found .
    CONSTANTS:
      BEGIN OF system_error,
        msgid TYPE symsgid VALUE 'Z_ABAP_SFP',
        msgno TYPE symsgno VALUE '005',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF system_error .
    CONSTANTS:
      BEGIN OF form_not_found,
        msgid TYPE symsgid VALUE 'Z_ABAP_SFP',
        msgno TYPE symsgno VALUE '006',
        attr1 TYPE scx_attrname VALUE 'MV_FORM_NAME',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF form_not_found .
    CONSTANTS:
      BEGIN OF function_module_not_found,
        msgid TYPE symsgid VALUE 'Z_ABAP_SFP',
        msgno TYPE symsgno VALUE '007',
        attr1 TYPE scx_attrname VALUE 'MV_FORM_NAME',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF function_module_not_found .
    DATA mv_language TYPE sylangu .
    DATA mv_form_name TYPE tdsfname .

    METHODS constructor
      IMPORTING
        !textid       LIKE if_t100_message=>t100key OPTIONAL
        !previous     LIKE previous OPTIONAL
        !mv_language  TYPE sylangu OPTIONAL
        !mv_form_name TYPE tdsfname OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCX_SSF_WRAP IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.
    me->mv_language = mv_language .
    me->mv_form_name = mv_form_name .
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
