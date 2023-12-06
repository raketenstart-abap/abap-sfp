class ZCX_CORE_SFP_WRAP definition
  public
  inheriting from ZCX_ROOT
  create public .

public section.

  constants:
    begin of FORM_NOT_FOUND,
      msgid type symsgid value 'ZCORE_SFP',
      msgno type symsgno value '000',
      attr1 type scx_attrname value 'MV_FORM_NAME',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of FORM_NOT_FOUND .
  constants:
    begin of JOB_OPEN_FAIL,
      msgid type symsgid value 'ZCORE_SFP',
      msgno type symsgno value '001',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of JOB_OPEN_FAIL .
  constants:
    begin of JOB_CLOSE_FAIL,
      msgid type symsgid value 'ZCORE_SFP',
      msgno type symsgno value '002',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of JOB_CLOSE_FAIL .
  data MV_FORM_NAME type FPNAME .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !MV_FORM_NAME type FPNAME optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_CORE_SFP_WRAP IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->MV_FORM_NAME = MV_FORM_NAME .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
