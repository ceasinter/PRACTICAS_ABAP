CLASS zpracticas_abap_consolidado DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zpracticas_abap_consolidado IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    TYPES: BEGIN OF ty_factura,
             id_factura  TYPE i,
             codigo_pais TYPE c LENGTH 2,
             monto       TYPE p LENGTH 8 DECIMALS 2,
           END OF ty_factura.
    TYPES: tty_facturas TYPE STANDARD TABLE OF ty_factura WITH EMPTY KEY.

    DATA(lt_facturas) = VALUE tty_facturas(
    ( id_factura = 1 codigo_pais = 'VE' monto = '1550.25' )
    ( id_factura = 2 codigo_pais = 'VE' monto = '2875.00' )
    ( id_factura = 3 codigo_pais = 'AR' monto = '4311.75' )
    ( id_factura = 4 codigo_pais = 'VE' monto = '18954.55' )
    ( id_factura = 5 codigo_pais = 'ES' monto = '14899.90' )
    ).

    " --- 2. ESTRUCTURA DEL REPORTE RESUMIDO ---
    TYPES: BEGIN OF ty_resumen,
             pais           TYPE string,
             monto_total    TYPE p LENGTH 10 DECIMALS 2,
             total_facturas TYPE i,
           END OF ty_resumen.
    TYPES: tty_resumen TYPE STANDARD TABLE OF ty_resumen WITH EMPTY KEY.

    DATA(lt_reporte_ventas) = VALUE tty_resumen(
    FOR GROUPS ls_grupo OF wa IN lt_facturas
      GROUP BY wa-codigo_pais
  ( pais           = ls_grupo
    monto_total    = REDUCE decfloat34( INIT total = 0 FOR f IN GROUP ls_grupo NEXT total = total + f-monto )
    total_facturas = REDUCE i( INIT cont = 0  FOR f IN GROUP ls_grupo NEXT cont = cont + 1 ) )
    ).

    out->write( '--- RESUMEN CONSOLIDADO DE VENTAS POR PAÍS ---' ).
    out->write( lt_reporte_ventas ).

  ENDMETHOD.
ENDCLASS.
