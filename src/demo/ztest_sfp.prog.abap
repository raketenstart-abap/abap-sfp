*&---------------------------------------------------------------------*
*& Report ZTEST_SFP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_sfp.

CLASS lcl DEFINITION
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS
      get_instance
        RETURNING VALUE(result) TYPE REF TO lcl.

    METHODS
      execute
        RETURNING VALUE(result) TYPE REF TO zca_file
        RAISING zcx_root.

    METHODS
      preview
      RAISING zcx_root.

  PRIVATE SECTION.
    DATA mo_sfp_print TYPE REF TO zif_sfp_print.

    METHODS
      constructor
        IMPORTING io_sfp_print TYPE REF TO zif_sfp_print OPTIONAL.

ENDCLASS.

CLASS lcl IMPLEMENTATION.
  METHOD execute.
    DATA(lo_print_format) = mo_sfp_print->execute(
      function_name = 'ZFAF_TEST_PDF'
    ).
    result = lo_print_format->converter( )->to_pdf( space ).
  ENDMETHOD.

  METHOD preview.
    mo_sfp_print->preview(
      function_name = 'ZFAF_TEST_PDF'
    ).
  ENDMETHOD.

  METHOD get_instance.
    CREATE OBJECT result.
  ENDMETHOD.

  METHOD constructor.
    IF io_sfp_print IS BOUND.
      mo_sfp_print = io_sfp_print.
    ELSE.
      CREATE OBJECT mo_sfp_print TYPE zcl_sfp_print.
    ENDIF.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  lcl=>get_instance( )->execute( )->downloader( )->local( ).

  lcl=>get_instance( )->preview( ).
