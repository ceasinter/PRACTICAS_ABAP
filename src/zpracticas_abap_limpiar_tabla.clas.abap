CLASS zpracticas_abap_limpiar_tabla DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zpracticas_abap_limpiar_tabla IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    TYPES: BEGIN OF ty_cliente,
             id     TYPE i,
             nombre TYPE string,
             tax_id TYPE string,
             correo TYPE string,
           END OF ty_cliente.
    TYPES: tty_clientes TYPE STANDARD TABLE OF ty_cliente WITH EMPTY KEY.
    TYPES: tty_clientes_unicos TYPE SORTED TABLE OF ty_cliente WITH UNIQUE KEY tax_id.

    DATA(lt_clientes_origen) = VALUE tty_clientes(
        ( id = 1 nombre = 'Logistica Express' tax_id = '999-A' correo = 'contacto@logistica.com' )
        ( id = 2 nombre = 'Logistica Exp SRL' tax_id = '999-A' correo = 'antiguo@correo.com' ) " <-- DUPLICADO TAX_ID (Ignorar)
        ( id = 3 nombre = 'Ferreteria Central' tax_id = '888-B' correo = '' )                    " <-- CORREO VACÍO
        ( id = 4 nombre = 'Alimentos Globales' tax_id = '777-C' correo = 'admin_at_global.com' ) " <-- CORREO SIN @
    ).

    DATA lt_clientes_consolidados TYPE tty_clientes_unicos.
    LOOP AT lt_clientes_origen ASSIGNING FIELD-SYMBOL(<ls_migrado>).
      DATA(ls_nuevo_cliente) = VALUE ty_cliente( BASE <ls_migrado>
      tax_id = <ls_migrado>-tax_id
      nombre = <ls_migrado>-nombre
      correo = COND #(
                      WHEN <ls_migrado>-correo IS INITIAL
                      THEN |info@{ to_lower( replace( val = <ls_migrado>-nombre sub = ` ` with = `` occ = 0 ) ) }.com|

                      WHEN NOT <ls_migrado>-correo CA '@'
                      THEN 'CORREO INVALIDO'

                      ELSE <ls_migrado>-correo ) ).

      INSERT ls_nuevo_cliente INTO TABLE lt_clientes_consolidados.
    ENDLOOP.
    out->write( '--- MAESTRO DE CLIENTES DEPURADO Y LIMPIO ---' ).
    out->write( lt_clientes_consolidados ).

  ENDMETHOD.
ENDCLASS.
