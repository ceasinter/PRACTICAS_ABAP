CLASS zpracticas_abap_reporte_ventas DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zpracticas_abap_reporte_ventas IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF ty_vendedor,
             id_vendedor TYPE i,
             nombre      TYPE string,
             monto_venta TYPE decfloat16,
             porcentaje  TYPE p LENGTH 5 DECIMALS 2,
           END OF ty_vendedor.

    TYPES: BEGIN OF ty_reporte_salida,
             id_vendedor TYPE string,
             nombre      TYPE string,
             monto_venta TYPE decfloat16,
             porcentaje  TYPE string,
           END OF ty_reporte_salida.

    TYPES: tty_vendedores TYPE STANDARD TABLE OF ty_vendedor WITH EMPTY KEY.
    TYPES tty_reporte_salida TYPE STANDARD TABLE OF ty_reporte_salida WITH EMPTY KEY.

    DATA(lt_ventas_mes) = VALUE tty_vendedores(
    ( id_vendedor = 1 nombre = 'Marcos Rodriguez'  monto_venta = '15000.00' )
    ( id_vendedor = 2 nombre = 'Juan Enporli'  monto_venta = '45000.00' )
    ( id_vendedor = 3 nombre = 'Martha Medina' monto_venta = '22000.00' )
    ( id_vendedor = 4 nombre = 'Fabiana Delgado' monto_venta = '60000.00' )
    ( id_vendedor = 5 nombre = 'Enrique Dugarte' monto_venta = '12000.00' )
    ).

    out->write( '=== REPORTE DE EFICIENCIA DE EJECUTIVOS ===' ).
    out->write( |Datos procesados el: { cl_abap_context_info=>get_system_date( ) DATE = USER }| ).
    out->write( '------------------------------------------' ).

    DATA(lv_total_global) = REDUCE decfloat16(
    INIT total = VALUE decfloat16( )
    FOR ls_emp IN lt_ventas_mes
    NEXT total = total + ls_emp-monto_venta
    ).

    out->write( |Ventas Totales de la Empresa: { lv_total_global STYLE = SCALE_PRESERVING }| ).
    out->write( '------------------------------------------' ).

    DATA lt_top_3_reporte TYPE tty_reporte_salida.


    IF lv_total_global > 0.
      DATA(lt_porcentaje) = VALUE tty_reporte_salida(
      FOR porc IN lt_ventas_mes
      ( id_vendedor = porc-id_vendedor
        nombre = porc-nombre
        monto_venta = porc-monto_venta
        porcentaje   = |{ ( porc-monto_venta / lv_total_global ) * 100 STYLE = SCALE_PRESERVING NUMBER = USER } %| )
      ).

      SORT lt_porcentaje BY monto_venta DESCENDING.
      lt_top_3_reporte = VALUE tty_reporte_salida(
      FOR i = 1 WHILE i <= lines( lt_porcentaje ) AND i <= 3
      ( lt_porcentaje[ i ] ) ).
      out->write( 'Resultados del TOP 3 de Ejecutivos con Mayor Rendimiento:' ).
      out->write( lt_top_3_reporte ).
    ELSE.
      out->write( 'No se encontraron registros de ventas para procesar.' ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
