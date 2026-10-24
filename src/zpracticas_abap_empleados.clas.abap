CLASS zpracticas_abap_empleados DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zpracticas_abap_empleados IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    TYPES: BEGIN OF ty_empleado,
             id     TYPE i,
             nombre TYPE string,
             sueldo TYPE p LENGTH 8 DECIMALS 2,
           END OF ty_empleado.

    DATA: lt_empleados TYPE TABLE OF ty_empleado,
          ls_empleados TYPE ty_empleado.

    ls_empleados-id = 1.
    ls_empleados-nombre = 'Juan Carlos Medina'.
    ls_empleados-sueldo = '3850.00'.
    APPEND ls_empleados TO lt_empleados.

    ls_empleados-id = 2.
    ls_empleados-nombre = 'Ana María Mendoza'.
    ls_empleados-sueldo = '2985.75'.
    APPEND ls_empleados TO lt_empleados.


    LOOP AT lt_empleados INTO ls_empleados.
      out->write( ls_empleados-id &&
                  ls_empleados-nombre &&
                  ls_empleados-sueldo ).
    ENDLOOP.

    TYPES: BEGIN OF ty_persona,
             id        TYPE i,
             nombre    TYPE string,
             edad      TYPE i,
             fecha_nac TYPE d,
             etatura   TYPE i,
           END OF ty_persona.

    DATA: lt_personas TYPE TABLE OF ty_persona,
          ls_personas TYPE ty_persona.

    ls_personas-id = 1.
    ls_personas-nombre = 'Luis Enrique Ordoñez'.
    ls_personas-fecha_nac = '19991002'.
    ls_personas-edad = 27.
    ls_personas-etatura = 172.
    APPEND ls_personas TO lt_personas.

    LOOP AT lt_personas INTO ls_personas.
      out->write( ls_personas-id &&
                  ls_personas-nombre &&
                  ls_personas-fecha_nac &&
                  ls_personas-edad &&
                  ls_personas-etatura ).

    ENDLOOP.

    READ TABLE lt_empleados INTO ls_empleados WITH KEY id = 5.
    IF sy-subrc = 0.
      out->write( |Se ha encontrado el empleado....: { ls_empleados-nombre }| ).
    ELSE.
      out->write( 'Empleado no encontrado...' ).
    ENDIF.

    READ TABLE lt_personas INTO ls_personas WITH KEY id = 1.
    IF sy-subrc = 0.
      out->write( ls_personas-nombre ).
      ls_personas-nombre = 'Mariana Del Valle Uzcátegui'.
      MODIFY lt_personas FROM ls_personas INDEX sy-tabix.
      out->write( ls_personas-nombre ).
    ELSE.
      out->write( 'No se ha encontrado la persona...' ).
    ENDIF.

    DELETE lt_personas WHERE id = 1.
    out->write( 'Eliminado registro con ID.: 1' ).

    SORT lt_empleados BY nombre ASCENDING.
    out->write( lt_empleados ).
  ENDMETHOD.
ENDCLASS.
