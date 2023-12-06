class ZCX_CORE_SSF_WRAP definition
  public
  inheriting from ZCX_ROOT
  create public .

public section.

  constants:
    begin of LANGUAGE_NOT_ACCEPTED,
      msgid type symsgid value 'ZCORE_SFP',
      msgno type symsgno value '003',
      attr1 type scx_attrname value 'MV_LANGUAGE',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of LANGUAGE_NOT_ACCEPTED .
  constants:
    begin of DEVICE_NOT_FOUND,
      msgid type symsgid value 'ZCORE_SFP',
      msgno type symsgno value '004',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of DEVICE_NOT_FOUND .
  constants:
    begin of SYSTEM_ERROR,
      msgid type symsgid value 'ZCORE_SFP',
      msgno type symsgno value '005',
      attr1 type scx_attrname value 'MV_FORM_NAME',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of SYSTEM_ERROR .
  constants:
    begin of FORM_NOT_FOUND,
      msgid type symsgid value 'ZCORE_SFP',
      msgno type symsgno value '006',
      attr1 type scx_attrname value 'MV_FORM_NAME',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of FORM_NOT_FOUND .
  constants:
    begin of FUNCTION_MODULE_NOT_FOUND,
      msgid type symsgid value 'ZCORE_SFP',
      msgno type symsgno value '007',
      attr1 type scx_attrname value 'MV_FORM_NAME',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of FUNCTION_MODULE_NOT_FOUND .
  data MV_LANGUAGE type SYLANGU .
  data MV_FORM_NAME type TDSFNAME .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !MV_LANGUAGE type SYLANGU optional
      !MV_FORM_NAME type TDSFNAME optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_CORE_SSF_WRAP IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->MV_LANGUAGE = MV_LANGUAGE .
me->MV_FORM_NAME = MV_FORM_NAME .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
