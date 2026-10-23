CLASS zpracticas_abap_alumnos DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zpracticas_abap_alumnos IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    TYPES: BEGIN OF ty_alumnos,
             id      TYPE i,
             nombre  TYPE string,
             curso   TYPE string,
             seccion TYPE c LENGTH 1,
           END OF ty_alumnos.

    TYPES: tty_alumnos TYPE STANDARD TABLE OF ty_alumnos WITH EMPTY KEY.

    DATA(lt_alumnos_nuevos) = VALUE tty_alumnos(
    ( id = 1 nombre = 'Carlos Amaro' curso = 'Tercer Semestre' seccion = 'A' )
    ( id = 2 nombre = 'Pedro Pérez' curso = 'Tercer Semestre' seccion = 'A' )
    ( id = 3 nombre = 'Jazmin Medina' curso = 'Primer Semestre' seccion = 'B' )
    ( id = 4 nombre = 'Antonio López' curso = 'Segundo Semestre' seccion = 'B' )
    ( id = 5 nombre = 'Juan Carlos Carrizales' curso = 'Cuarto Semestre' seccion = 'A' )
    ( id = 6 nombre = 'Ana Paola Echeverría' curso = 'Tercer Semestre' seccion = 'B' )
    ( id = 7 nombre = 'María Victoria Aranguren' curso = 'Primer Semestre' seccion = 'A' )
    ( id = 8 nombre = 'Eugenio Mendoza' curso = 'Tercer Primer' seccion = 'B' )
    ( id = 9 nombre = 'Luis Alberto Chancho' curso = 'Segundo Semestre' seccion = 'A' )
    ( id = 10 nombre = 'Karla Zumoza' curso = 'Cuarto Semestre' seccion = 'A' )
    ).

    DATA(lt_alumnos_registrados) = VALUE tty_alumnos( FOR wa IN lt_alumnos_nuevos ( wa ) ).
    out->write( lt_alumnos_registrados ).

    DATA(lt_alumnos_filtrados) = VALUE tty_alumnos(
                                 FOR af IN lt_alumnos_registrados WHERE ( curso = 'Tercer Semestre'  AND seccion = 'A' )
                                 ( id = af-id
                                   nombre = af-nombre
                                   curso = af-curso
                                   seccion = af-seccion ) ).
    out->write( lt_alumnos_filtrados ).
  ENDMETHOD.
ENDCLASS.
