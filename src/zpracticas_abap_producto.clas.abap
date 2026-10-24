CLASS zpracticas_abap_producto DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zpracticas_abap_producto IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    TYPES: BEGIN OF ty_producto,
             id          TYPE i,
             descripcion TYPE string,
             precio      TYPE p LENGTH 8 DECIMALS 2,
             stock       TYPE i,
           END OF ty_producto.

    TYPES: tty_productos TYPE STANDARD TABLE OF ty_producto WITH EMPTY KEY.
    DATA: lt_productos TYPE TABLE OF ty_producto,
          ls_productos TYPE ty_producto.

    DATA(lt_productos_nuevos) = VALUE tty_productos(
    ( id = 1 descripcion = 'Teléfono' precio = '980.00' stock = 10 )
    ( id = 2 descripcion = 'Laptop' precio = '1850.00' stock = 4 )
    ( id = 3 descripcion = 'Cargador' precio = '35.50' stock = 65 )
    ( id = 4 descripcion = 'Cable USB' precio = '18.75' stock = 120 )
    ( id = 5 descripcion = 'Monitor' precio = '840.00' stock = 2 ) ).

  ENDMETHOD.
ENDCLASS.
