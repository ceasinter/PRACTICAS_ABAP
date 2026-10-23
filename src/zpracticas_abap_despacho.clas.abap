CLASS zpracticas_abap_despacho DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zpracticas_abap_despacho IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    TYPES: BEGIN OF ty_pedido,
             id_pedido    TYPE i,
             id_cliente   TYPE i,
             fecha_pedido TYPE d,
             monto        TYPE p LENGTH 8 DECIMALS 2,
           END OF ty_pedido.

    TYPES: tty_pedidos TYPE  STANDARD TABLE OF ty_pedido WITH EMPTY KEY.

    DATA(lt_pedidos) = VALUE tty_pedidos(
    ( id_pedido = 1101 id_cliente = 1 fecha_pedido = '20261020' monto = '150.00' )
    ( id_pedido = 1102 id_cliente = 2 fecha_pedido = '20261021' monto = '340.50' )
    ( id_pedido = 1103 id_cliente = 3 fecha_pedido = '20261022' monto = '95.00' )
    ).

    TYPES: BEGIN OF ty_cliente,
             id_cliente   TYPE i,
             nombre       TYPE string,
             tipo_cliente TYPE string,
           END OF ty_cliente.

    TYPES: tty_clientes TYPE SORTED TABLE OF ty_cliente WITH UNIQUE KEY id_cliente.
    DATA(lt_clientes) = VALUE tty_clientes(
    ( id_cliente = 1 nombre = 'Distribuidora Neptuno' tipo_cliente = 'REGULAR' )
    ( id_cliente = 2 nombre = 'Tienda Los Alamos' tipo_cliente = 'VIP' )
    ( id_cliente = 3 nombre = 'Comercial Hipocampo' tipo_cliente = 'REGULAR' )
    ).

    TYPES: BEGIN OF ty_ruta,
             id_cliente   TYPE i,
             zona_destino TYPE string,
             dias_entrega TYPE i,
           END OF ty_ruta.

    TYPES: tty_rutas TYPE SORTED TABLE OF ty_ruta WITH UNIQUE KEY id_cliente.

    DATA(lt_rutas) = VALUE tty_rutas(
    ( id_cliente = 1 zona_destino = 'SUR' dias_entrega = 3 )
    ( id_cliente = 2 zona_destino = 'CENTRO' dias_entrega = 1 )
    ( id_cliente = 3 zona_destino = 'NORTE' dias_entrega = 2 )
    ).

    TYPES: BEGIN OF ty_monitor,
             id_pedido      TYPE i,
             nombre_cliente TYPE string,
             zona_destino   TYPE string,
             fecha_entrega  TYPE d,
             prioridad      TYPE string,
           END OF ty_monitor.
    TYPES: tty_monitores TYPE STANDARD TABLE OF ty_monitor WITH EMPTY KEY.

    DATA(lt_monitores) = VALUE tty_monitores(

    FOR ped IN lt_pedidos

    LET lv_fecha = ped-fecha_pedido
        lv_dias = lt_rutas[ id_cliente = ped-id_cliente ]-dias_entrega
        lv_fecha_entrega = lv_fecha + lv_dias
        lv_nombre_cliente = lt_clientes[ id_cliente = ped-id_cliente ]-nombre
        lv_zona_destino = lt_rutas[ id_cliente = ped-id_cliente ]-zona_destino
        lv_tipo_cliente = lt_clientes[ id_cliente = ped-id_cliente ]-tipo_cliente
    IN
    ( id_pedido = ped-id_pedido
     nombre_cliente = lv_nombre_cliente
     zona_destino = lv_zona_destino
     fecha_entrega = lv_fecha_entrega
     prioridad   = COND #( WHEN lv_tipo_cliente = 'VIP'
                           THEN 'ALTA'
                           WHEN lv_tipo_cliente = 'REGULAR' AND lv_zona_destino = 'NORTE'
                           THEN 'MEDIA'
                           ELSE 'BAJA' ) )
    ).

    out->write( '--- MONITOR DE PRIORIDAD DE DESPACHO ---' ).
    out->write( lt_monitores ).

    LOOP AT lt_monitores INTO DATA(ls_monitores).
      out->write( ls_monitores ).
    ENDLOOP.

    READ TABLE lt_monitores INTO ls_monitores WITH KEY id_pedido = 1102.
    IF sy-subrc = 0.
      out->write( |Usuario encontrado....: { ls_monitores-nombre_cliente }| ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
