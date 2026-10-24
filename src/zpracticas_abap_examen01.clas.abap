CLASS zpracticas_abap_examen01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zpracticas_abap_examen01 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF ty_producto,
             id               TYPE i,
             descripcion      TYPE string,
             precio           TYPE p LENGTH 8 DECIMALS 2,
             stock            TYPE i,
             costo_inventario TYPE p LENGTH 10 DECIMALS 2,
           END OF ty_PRODUCTO.

    TYPES: tty_productos TYPE STANDARD TABLE OF ty_producto WITH EMPTY KEY.
*    DATA: lt_productos TYPE STANDARD TABLE OF ty_producto,
*          ls_productos TYPE ty_producto.

* TAREA 1 - INSERTAR 5 REGISTROS.
*    ls_productos-id = 1.
*    ls_productos-descripcion = 'Laptop'.
*    ls_productos-precio = '1250.00'.
*    ls_productos-stock = 0.
*    APPEND ls_productos TO lt_productos.

    DATA(lt_productos) = VALUE tty_productos(
    ( id = 1 descripcion = 'Laptop' precio = '1250.00' stock = 3 )
    ( id = 2 descripcion = 'Teléfono' precio = '850' stock = 12 )
    ( id = 3 descripcion = 'Monitor' precio = '950.75' stock = 4 )
    ( id = 4 descripcion = 'Cable USB' precio = '45.80' stock = 45 )
    ( id = 5 descripcion = 'Cargador' precio = '84.55' stock = 60 )
    ).
*APPEND VALUE #(
*  id = 1
*  descripcion = 'Laptop'
*  precio = '1250.00'
*  stock = 0
*) TO lt_productos.
*
*    ls_productos-id = 2.
*    ls_productos-descripcion = 'Teléfono'.
*    ls_productos-precio = '850.00'.
*    ls_productos-stock = 14.
*    APPEND ls_productos TO lt_productos.
*
*    ls_productos-id = 3.
*    ls_productos-descripcion = 'Monitor'.
*    ls_productos-precio = '950.75'.
*    ls_productos-stock = 4.
*    APPEND ls_productos TO lt_productos.
*
*    ls_productos-id = 4.
*    ls_productos-descripcion = 'Cable USB'.
*    ls_productos-precio = '45.80'.
*    ls_productos-stock = 65.
*    APPEND ls_productos TO lt_productos.
*
*    ls_productos-id = 5.
*    ls_productos-descripcion = 'Cargador'.
*    ls_productos-precio = '84.55'.
*    ls_productos-stock = 120.
*    APPEND ls_productos TO lt_productos.

*TAREA 2 - MOSTRAR TODOS LOS REGISTROS.
    out->write( '-----------------------------' &&
                'TAREA 2.- LISTADO DE PRODUCTOS' &&
                '------------------------------' ).
*    LOOP AT lt_productos INTO ls_productos.
*
*      out->write( |{ ls_productos-id }  | &&
*                  |{ ls_productos-descripcion }  | &&
*                  |{ ls_productos-precio }  | &&
*                  |{ ls_productos-stock }| ).
*    ENDLOOP.

    DATA(lt_productos_registrados) = VALUE tty_productos( FOR wa IN lt_productos ( wa ) ).
    out->write( lt_productos_registrados ).

*TAREA 3 - BUSCAR UN REGISTRO POR ID.
    out->write( 'TAREA 3.- BUSCAR UN REGISTRO POR ID - ID 3' ).
    READ TABLE lt_productos_registrados INTO data(ls_productos) WITH KEY id = 3.
    IF sy-subrc = 0.
      out->write( |Producto encontrado....: { ls_productos-descripcion }| ).
    ELSE.
      out->write( 'No se ha encontrado producto con ese ID' ).
    ENDIF.


*TAREA 4 - ACTUALIZAR STOCK DEL REGISTRO ENCONTRADO EN TAREA ANTERIOR.
    out->write( 'TAREA 4.- ACTUALIZAR STOCK DE REGISTRO DE TAREA ANTERIOR' ).
    READ TABLE lt_productos_registrados INTO ls_productos WITH KEY id = 3.
    IF sy-subrc = 0.
      out->write( '------------------------------------------------------' ).
      out->write( 'Actualización de Stock de Productos ' ).
      out->write( '------------------------------------------------------' ).
      out->write( |Id.............: { ls_productos-id }\n| &&
                  |Descripción....: { ls_productos-descripcion }\n| &&
                  |Precio.........: { ls_productos-precio }\n| &&
                  |Stock Anterior.: { ls_productos-stock }| ).
      ls_productos-stock = 0.
      MODIFY lt_productos FROM ls_productos INDEX sy-tabix.
      out->write( |Stock Actual...: { ls_productos-stock }| ).
      out->write( '------------------------------------------------------' ).
    ELSE.
      out->write( 'Producto no encontrado con ese ID...' ).
    ENDIF.

*   TAREA 5 - ELIMINAR PRODUCTOS CON STOCK 0.
    out->write( 'TARRA 5.- ELIMINAR REGISTROS CON STOCK 0' ).
    DELETE lt_productos_registrados WHERE stock = 0.
    out->write( 'LISTADO DE PRODUCTOS SIN STOCK CERO - 0' ).
    LOOP AT lt_productos_registrados INTO ls_productos.

      out->write( |{ ls_productos-id }  | &&
                  |{ ls_productos-descripcion }  | &&
                  |{ ls_productos-precio }  | &&
                  |{ ls_productos-stock }| ).
    ENDLOOP.

*    TAREA 6 - ORDENAR POR PRECIO DESCENDENTE.
    out->write( 'TAREA 6.- PRODUCTOS ORDENADOS POR PRECIO DESCENDENTE' ).
    SORT lt_productos BY precio DESCENDING.
    LOOP AT lt_productos_registrados INTO ls_productos.

      out->write( |{ ls_productos-id }  | &&
                  |{ ls_productos-descripcion }  | &&
                  |{ ls_productos-precio }  | &&
                  |{ ls_productos-stock }| ).
    ENDLOOP.

*   TAREA 7 - CALCULAR EL VALOR TOTAL DEL INVENTARIO.

    out->write( 'TAREA 7.- LISTADO DE PRODUCTOS CON TOTAL DE INVENTARIO' ).
    DATA: lv_suma_inventario TYPE p LENGTH 12 DECIMALS 2.
    CLEAR lv_suma_inventario.
    LOOP AT lt_productos ASSIGNING FIELD-SYMBOL(<fs_producto>).
      <fs_producto>-costo_inventario = <fs_producto>-precio * <fs_producto>-stock.
      lv_suma_inventario = lv_suma_inventario + <fs_producto>-costo_inventario.
      out->write( |{ <fs_producto>-id }           | &&

                    |{ <fs_producto>-descripcion }  | &&
                    |{ <fs_producto>-precio }       | &&
                    |{ <fs_producto>-stock }        | &&
                    |{ <fs_producto>-costo_inventario }| ).
    ENDLOOP.

    out->write( |TOTAL INVENTARIO GENERAL.....: { lv_suma_inventario }| ).

  ENDMETHOD.
ENDCLASS.
