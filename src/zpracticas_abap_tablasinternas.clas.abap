CLASS zpracticas_abap_tablasinternas DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zpracticas_abap_tablasinternas IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF ty_producto,
             id        TYPE i,
             nombre    TYPE string,
             categoria TYPE string,
             precio    TYPE p LENGTH 6 DECIMALS 2,
           END OF ty_producto.

    TYPES tty_productos TYPE STANDARD TABLE OF ty_producto WITH EMPTY KEY.

    DATA(lt_productos_origen) = VALUE tty_productos(
        ( id = 1 nombre = 'Laptop'     categoria = 'ELECTRONICA' precio = '1000.00' )
        ( id = 2 nombre = 'Teclado'    categoria = 'ELECTRONICA' precio = '45.00' )
        ( id = 3 nombre = 'Escritorio' categoria = 'MUEBLES'     precio = '250.00' )
        ( id = 4 nombre = 'Monitor'    categoria = 'ELECTRONICA' precio = '300.00' )
        ( id = 5 nombre = 'Silla'      categoria = 'MUEBLES'     precio = '80.00' ) ).


    DATA: lt_productos_filtrados TYPE tty_productos.

    lt_productos_filtrados = VALUE #(
                             FOR wa IN lt_productos_origen WHERE ( categoria = 'ELECTRONICA' )
                             ( id = wa-id )
                             ( nombre = wa-nombre )
                             ( categoria = wa-categoria )
                             ( precio = COND #( WHEN wa-precio > 100
                                                THEN wa-precio * '0.90'
                                                ELSE wa-precio ) )
                             ).

    out->write( lt_productos_filtrados ).
  ENDMETHOD.
ENDCLASS.
