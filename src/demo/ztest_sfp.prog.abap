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

    TRY.
        DATA(lo_print_format) = mo_sfp_print->execute( function_name = 'ZFAF_TEST_PDF' ).

        lo_print_format->converter( )->to_pdf( )->downloader( )->local( ).

      CATCH zcx_root INTO DATA(lx_root).
        lx_root->raise_message( ).
    ENDTRY.

  ENDMETHOD.

  METHOD preview.
    TRY.
        mo_sfp_print->preview( function_name = 'ZFAF_TEST_PDF' ).

      CATCH zcx_root INTO DATA(lx_root).
        lx_root->raise_message( ).
    ENDTRY.
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
  " execute and download
  lcl=>get_instance( )->execute( ).
  " preview
  lcl=>get_instance( )->preview( ).
