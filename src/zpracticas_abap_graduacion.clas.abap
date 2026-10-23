CLASS zpracticas_abap_graduacion DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zpracticas_abap_graduacion IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    TYPES: BEGIN OF ty_reporte_graduacion,
             id      TYPE i,
             nombre  TYPE string,
             curso   TYPE string,
             seccion TYPE c LENGTH 1,
             estatus TYPE string,
           END OF ty_reporte_graduacion.

    TYPES: tty_reporte_graduacion TYPE STANDARD TABLE OF ty_reporte_graduacion WITH EMPTY KEY.

    DATA(lt_alumnos_nuevos) = VALUE tty_reporte_graduacion(
( id = 1 nombre = 'Carlos Amaro' curso = 'Tercer Semestre' seccion = 'A' estatus = 'Activo' )
( id = 2 nombre = 'Pedro Pérez' curso = 'Tercer Semestre' seccion = 'A' estatus = 'Activo' )
( id = 3 nombre = 'Jazmin Medina' curso = 'Primer Semestre' seccion = 'B' estatus = 'Activo' )
( id = 4 nombre = 'Antonio López' curso = 'Segundo Semestre' seccion = 'B' estatus = 'Activo' )
( id = 5 nombre = 'Juan Carlos Carrizales' curso = 'Cuarto Semestre' seccion = 'A' estatus = 'Activo' )
( id = 6 nombre = 'Ana Paola Echeverría' curso = 'Tercer Semestre' seccion = 'B' estatus = 'Activo' )
( id = 7 nombre = 'María Victoria Aranguren' curso = 'Primer Semestre' seccion = 'A' estatus = 'Activo' )
( id = 8 nombre = 'Eugenio Mendoza' curso = 'Tercer Primer' seccion = 'B'  estatus = 'Activo' )
( id = 9 nombre = 'Luis Alberto Chancho' curso = 'Segundo Semestre' seccion = 'A' estatus = 'Activo' )
( id = 10 nombre = 'Karla Zumoza' curso = 'Cuarto Semestre' seccion = 'b' estatus = 'Activo' )
).

    DATA: lt_candidatos_graduacion TYPE tty_reporte_graduacion.
    lt_candidatos_graduacion = VALUE #(
    FOR rg IN lt_alumnos_nuevos WHERE ( curso = 'Cuarto Semestre' )
    ( id = rg-id
      nombre = rg-nombre
      curso = rg-curso
      seccion = to_upper( rg-seccion )
      estatus = COND #( WHEN to_upper( rg-seccion ) = 'A'
                        THEN 'Apto para Graduarse'
                        ELSE 'Revisión Pendiente' ) )
                      ).

    out->write( '--- REPORTE FINAL DE CANDIDATOS A GRADUACIÓN ---' ).
    out->write( lt_candidatos_graduacion ).
  ENDMETHOD.
ENDCLASS.
