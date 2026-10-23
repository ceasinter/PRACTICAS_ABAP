CLASS zpracticas_abap_auditoria_pago DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zpracticas_abap_auditoria_pago IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    TYPES: BEGIN OF ty_alumno,
             id      TYPE i,
             nombre  TYPE string,
             curso   TYPE string,
             seccion TYPE c LENGTH 1,
             estatus TYPE string,
           END OF ty_alumno.

    TYPES: tty_alumnos TYPE STANDARD TABLE OF ty_alumno WITH EMPTY KEY.

    DATA(lt_alumnos_nuevos) = VALUE tty_alumnos(
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

    TYPES: BEGIN OF ty_pago,
             id_alumno    TYPE i,
             monto_total  TYPE p LENGTH 8 DECIMALS 2,
             monto_pagado TYPE p LENGTH 8 DECIMALS 2,
           END OF ty_pago.

    TYPES: tty_pagos TYPE SORTED TABLE OF ty_pago WITH UNIQUE KEY id_alumno.

    DATA(lt_pagos) = VALUE tty_pagos(
                            ( id_alumno = 1 monto_total = '5000.00' monto_pagado = '5000.00' )
                            ( id_alumno = 2 monto_total = '5000.00' monto_pagado = '5000.00' )
                            ( id_alumno = 3 monto_total = '5000.00' monto_pagado = '3000.00' )
                            ( id_alumno = 4 monto_total = '5000.00' monto_pagado = '2000.85' )
                            ( id_alumno = 5 monto_total = '5000.00' monto_pagado = '4500.75' )
                            ( id_alumno = 6 monto_total = '5000.00' monto_pagado = '5000.00' )
                            ( id_alumno = 7 monto_total = '5000.00' monto_pagado = '2750.25' )
                            ( id_alumno = 8 monto_total = '5000.00' monto_pagado = '5000.00' )
                            ( id_alumno = 9 monto_total = '5000.00' monto_pagado = '4300.00' )
                            ( id_alumno = 10 monto_total = '5000.00' monto_pagado = '1850.00' ) ).


    TYPES: BEGIN OF ty_reporte,
             id          TYPE i,
             nombre      TYPE string,
             montot      TYPE p LENGTH 8 DECIMALS 2,
             montop      TYPE p LENGTH 8 DECIMALS 2,
             saldo_deuda TYPE p LENGTH 8 DECIMALS 2,
             bloqueado   TYPE abap_bool,
           END OF ty_reporte.

    TYPES: tty_reportes TYPE STANDARD TABLE OF ty_reporte WITH EMPTY KEY.


    DATA(lt_reporte_financiero) = VALUE tty_reportes(

FOR al IN lt_alumnos_nuevos
LET lv_deuda = CONV decfloat34( lt_pagos[ id_alumno = al-id ]-monto_total ) -
               CONV decfloat34( lt_pagos[ id_alumno = al-id ]-monto_pagado )
    lv_montot = lt_pagos[ id_alumno = al-id ]-monto_total
    lv_montop = lt_pagos[ id_alumno = al-id ]-monto_pagado
IN
( id          = al-id
 nombre      = al-nombre
* montot = lt_pagos[ id_alumno = al-id ]-monto_total
 montot = lv_montot
 montop = lv_montop
 saldo_deuda = lv_deuda
 bloqueado   = COND #( WHEN lv_deuda > 0
                       THEN abap_true
                       ELSE abap_false ) )
).

    out->write( '--- REPORTE DE AUDITORÍA DE PAGOS ---' ).
    out->write( lt_reporte_financiero ).


  ENDMETHOD.
ENDCLASS.
