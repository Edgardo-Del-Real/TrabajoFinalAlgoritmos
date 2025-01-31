UNIT MENUESFINAL;

{$CODEPAGE UTF8}

INTERFACE

USES
  CRT, ARCHIVOALUM, ARCHIVOEVAL, UNITARBOL, MANEJOALUMNO, MANEJOEVAL, LISTADOS, ESTADISTICAS, VALIDACIONES;

PROCEDURE MENUPRINCIAL ( );
PROCEDURE MENUESTADISTICAS (VAR ARCHIVOEVAL:T_ARCHIVO_EVAL; VAR ARCH:T_ARCHIVO_ALUMNOS);
PROCEDURE MENUALUMNO (var archivoAlumno:t_archivo_alumnos; var RAIZLEGAJO, RAIZAPYNOM:T_PUNT_ARBOL);
PROCEDURE MENUSEGUIMIENTO (var RAIZAPYNOM,RAIZLEGAJO,RAIZFECHA:T_PUNT_ARBOL; var archivoEval:t_archivo_eval; var ARCHIVOALUMNO:t_archivo_alumnos);
PROCEDURE MENULISTADOS (VAR ARCH:T_ARCHIVO_ALUMNOS; RAIZAPYNOM, RAIZLEGAJO:T_PUNT_ARBOL; var ARCH2:T_ARCHIVO_EVAL);

IMPLEMENTATION


PROCEDURE MENUALUMNO (var archivoAlumno:t_archivo_alumnos; var RAIZLEGAJO, RAIZAPYNOM:T_PUNT_ARBOL);
VAR
  OPCION: 0..4;
  X: t_dato_alumnos;
  RESPUESTA: STRING;
  pos: integer;
  CLAVE: STRING;
BEGIN
  CLRSCR;
  TEXTCOLOR(RED);
  GOTOXY(40,3);
  WRITELN('¡¡ ATENCIÓN !! ');
  GOTOXY(12,4);
  TEXTCOLOR(WHITE);
  WRITELN(' ------------------------------------------------------------------- ');
  GOTOXY(12,5);
  TEXTCOLOR(RED);
  WRITELN(' PARA PODER ACCEDER AL MENU DEBERA INGRESAR LA CLAVE CORRESPONDIENTE ');
  TEXTCOLOR(LIGHTBLUE);
  VALIDACION_CLAVE(RESPUESTA, POS, RAIZLEGAJO, RAIZAPYNOM, CLAVE);

  IF RESPUESTA = 'S' THEN
  BEGIN
    WRITE ('ALTA DE ALUMNOS');
    DARALTAALUMNO(ARCHIVOALUMNO, X, CLAVE);
    PASAR_DATOS(ARCHIVOALUMNO, RAIZLEGAJO, RAIZAPYNOM);
  END
  ELSE IF RESPUESTA = 'C' THEN
  BEGIN
    CLRSCR;
    GOTOXY(20,5);
    TEXTCOLOR(WHITE);
    WRITELN('A CONTINUACIÓN PODRA OBSERVAR LOS DATOS REGISTRADOS DEL ALUMNO SOLICITADO ');
    MOSTRARALUMNO(archivoAlumno, POS);

   SEEK(archivoAlumno, pos);
   READ(archivoAlumno, X);

    IF NOT x.ESTADO THEN
    BEGIN
      clrscr;
      GOTOXY(35,10);
      TEXTCOLOR(RED);
      WRITELN('EL ALUMNO SE ENCUENTRA DADO DE BAJA.');
      TEXTCOLOR(GREEN);
      GOTOXY(35,12);
      WRITE('¿DESEA DARLO DE ALTA NUEVAMENTE? (S/N): ');
      textcolor(white);
      READLN(RESPUESTA);
      IF UPCASE(RESPUESTA) = 'S' THEN
      BEGIN
        x.estado := True;
        SEEK(archivoAlumno, pos);
        WRITE(archivoAlumno, X);
      END;
    END
    ELSE
    BEGIN
     clrscr;
      GOTOXY(20,27);
      TEXTCOLOR(WHITE);
      WRITELN('PARA TERMINAR DE VISUALIZAR LOS DATOS Y PROCEDER AL MENU DE BM <<PRESIONE ENTER>>');
      READKEY;
      CLRSCR;
      REPEAT
        CLRSCR;
        MOSTRAR_NOMBRE_ALUMNO(ARCHIVOALUMNO, POS);
        TEXTCOLOR(WHITE);
        GOTOXY(50,10);
        WRITE('**BIENVENIDO AL ');
        TEXTCOLOR(GREEN);
        WRITELN('MENU DE ALUMNO**');
        TEXTCOLOR(GREEN);
        GOTOXY(52,12);
        WRITE('0- ');
        TEXTCOLOR(WHITE);
        WRITELN('VOLVER AL MENU PRINCIPAL');
        TEXTCOLOR(GREEN);
        GOTOXY(52,14);
        WRITE('1- ');
        TEXTCOLOR(WHITE);
        WRITELN('BAJA');
        TEXTCOLOR(GREEN);
        GOTOXY(52,16);
        WRITE('2- ');
        TEXTCOLOR(WHITE);
        WRITELN('MODIFICACIÓN');
        TEXTCOLOR(GREEN);
        GOTOXY(52,18);
        WRITE('3- ');
        TEXTCOLOR(WHITE);
        WRITELN('CONSULTA');
        TEXTCOLOR(GREEN);
        GOTOXY(52,20);
        WRITE('RESPUESTA: ');
        TEXTCOLOR(WHITE);
        READLN(OPCION);
        CASE OPCION OF
          1: BAJAALUMNO(archivoAlumno, POS);
          2: ModificarAlumno(archivoAlumno, POS);
          3: MOSTRARALUMNO(archivoAlumno, POS);
        END;
      UNTIL OPCION = 0;
      CLRSCR;
    END;
  END;
END;



PROCEDURE MENUSEGUIMIENTO (var RAIZAPYNOM,RAIZLEGAJO,RAIZFECHA:T_PUNT_ARBOL; var archivoEval:t_archivo_eval; var ARCHIVOALUMNO:t_archivo_alumnos);
VAR
  OPCION:0..3;
  x:t_dato_eval;
  x2:t_dato_alumnos;
  RESPUESTA:STRING;
  POS,POSALUMNO:INTEGER;
  CLAVE:STRING;
BEGIN

CLRSCR;
TEXTCOLOR(RED);
GOTOXY(40,3);
WRITELN('¡¡ ATENCIÓN !! ');
GOTOXY(12,4);
TEXTCOLOR(WHITE);
WRITELN(' ------------------------------------------------------------------- ');
GOTOXY(12,5);
TEXTCOLOR(RED);
WRITELN(' PARA PODER ACCEDER AL MENU DEBERA INGRESER LA CLAVE CORRESPONDIENTE ');
TEXTCOLOR(LIGHTBLUE);
VALIDACION_CLAVE (RESPUESTA, POS, RAIZLEGAJO, RAIZAPYNOM, CLAVE);
IF RESPUESTA = 'S' THEN
BEGIN
WRITE ('ALTA DE ALUMNOS');
DARALTAALUMNO(ARCHIVOALUMNO, X2,CLAVE);
PASAR_DATOS(ARCHIVOALUMNO,RAIZLEGAJO,RAIZAPYNOM);
END;
IF RESPUESTA = 'C' THEN
BEGIN
//CLRSCR;
        GOTOXY(20,2);
        TEXTCOLOR(WHITE);
        WRITELN('A CONTINUACIÓN PODRA OBSERVAR LOS DATOS REGISTRADOS DEL ALUMNO SOLICITADO ');
        TEXTCOLOR(WHITE);
        MOSTRARALUMNO (archivoAlumno, POS);
        GOTOXY(10,28);
        TEXTCOLOR(RED);
        WRITELN ('PARA TERMINAR DE VISUALIZAR LOS DATOS Y PROCEDER AL MENU DE ALTA Y MODIFICACION <<PRESIONE ENTER>>');
        READKEY;
  REPEAT

  CLRSCR;
  MOSTRAR_NOMBRE_ALUMNO (ARCHIVOALUMNO, POS);
  PASAR_DATOS_EVAL (archivoEval,RAIZLEGAJO,RAIZFECHA);
  TEXTCOLOR(WHITE);
  GOTOXY(48,10);
  WRITE('**BIENVENIDO AL ');
  TEXTCOLOR(GREEN);
  WRITELN('MENU DE SEGUIMIENTO**');
       TEXTCOLOR(GREEN);
       GOTOXY(52,12);
       WRITE('0- ');
       TEXTCOLOR(WHITE);
       WRITELN('VOLVER AL MENU PRINCIPAL');
       TEXTCOLOR(GREEN);
       GOTOXY(52,14);
       WRITE('1- ');
       TEXTCOLOR(WHITE);
       WRITELN('ALTA');
       TEXTCOLOR(GREEN);
       GOTOXY(52,16);
       WRITE('2- ');
       TEXTCOLOR(WHITE);
       WRITELN('MODIFICACIÓN');
       TEXTCOLOR(GREEN);
       GOTOXY(52,18);
       WRITE('3- ');
       TEXTCOLOR(WHITE);
       WRITELN('CONSULTA');
       TEXTCOLOR(GREEN);
       GOTOXY(52,20);
       WRITE('RESPUESTA: ');
       TEXTCOLOR(WHITE);
       READLN(OPCION);
       CASE OPCION OF
            1:DarAltaEval(archivoEval,x,ARCHIVOALUMNO,POS);
            2:modificarEval(raizfecha, raizlegajo,archivoEval,ARCHIVOALUMNO,POS);
            3:ConsultaEvaluacion(raizlegajo,archivoEval,ARCHIVOALUMNO,POS);
       END;
  UNTIL OPCION = 0 ;
  CLRSCR;
END;

end;

PROCEDURE MENULISTADOS (VAR ARCH:T_ARCHIVO_ALUMNOS; RAIZAPYNOM, RAIZLEGAJO:T_PUNT_ARBOL; var ARCH2:T_ARCHIVO_EVAL);
VAR
  OPCION:0..3;
  Y:INTEGER;
BEGIN
  REPEAT
       CLRSCR;
       TEXTCOLOR(WHITE);
       GOTOXY(49,10);
       WRITE('**BIENVENIDO AL ');
       TEXTCOLOR(GREEN);
       WRITELN('MENU DE LISTADOS**');
       TEXTCOLOR(GREEN);
       GOTOXY(52,12);
       WRITE('0- ');
       TEXTCOLOR(WHITE);
       WRITELN('VOLVER AL MENU PRINCIPAL');
       TEXTCOLOR(GREEN);
       GOTOXY(52,14);
       WRITE('1- ');
       TEXTCOLOR(WHITE);
       WRITELN('NOMBRE Y APELLIDO');
       TEXTCOLOR(GREEN);
       GOTOXY(52,16);
       WRITE('2- ');
       TEXTCOLOR(WHITE);
       WRITELN('EVALUCIONES DE UN ALUMNO');
       TEXTCOLOR(GREEN);
       GOTOXY(52,18);
       WRITE('3- ');
       TEXTCOLOR(WHITE);
       WRITELN('ALUMNOS CON DETERMINADA DISCAPACIDAD');
       TEXTCOLOR(GREEN);
       GOTOXY(52,20);
       WRITE('RESPUESTA: ');
       TEXTCOLOR(WHITE);
       READLN(OPCION);
       CASE OPCION OF
            1:begin
             generar_arbol(RAIZAPYNOM,ARCH);
             CLRSCR;
             MOSTRAR_ENCABEZADO_TABLA;
             inorden_apynom(RAIZAPYNOM, ARCH, y);
             {listado_apynom (ARCH, RAIZAPYNOM);}
             READKEY;
            end;
            2: ConsultaEvalDeAlumno(ARCH2,RAIZLEGAJO, RAIZAPYNOM);
            3:listado_por_enfermedad (ARCH);
       END;
  UNTIL OPCION = 0 ;
  CLRSCR;
END;

PROCEDURE MENUESTADISTICAS (VAR ARCHIVOEVAL:T_ARCHIVO_EVAL; VAR ARCH:T_ARCHIVO_ALUMNOS);
VAR
   OPCION:0..4;
BEGIN
  REPEAT
       CLRSCR;
       TEXTCOLOR(WHITE);
       GOTOXY(52,10);
       WRITE('**BIENVENIDO AL ');
       TEXTCOLOR(GREEN);
       WRITELN('MENU DE ESTADISTICAS**');
       TEXTCOLOR(GREEN);
       GOTOXY(45,12);
       WRITE('0- ');
       TEXTCOLOR(WHITE);
       WRITELN('VOLVER AL MENU PRINCIPAL');
       TEXTCOLOR(GREEN);
       GOTOXY(45,14);
       WRITE('1- ');
       TEXTCOLOR(WHITE);
       WRITELN('DISTRIBUCIÓN DE EVALUACIONES POR DISCAPACIDAD');
       TEXTCOLOR(GREEN);
       GOTOXY(45,16);
       WRITE('2- ');
       TEXTCOLOR(WHITE);
       WRITELN('DISCAPACIDAD QUE PRESENTAN MAYOR GRADO DE DIFICULTAD');
       TEXTCOLOR(GREEN);
       GOTOXY(45,18);
       WRITE('3- ');
       TEXTCOLOR(WHITE);
       WRITELN('CANTIDAD DE ALUMNOS POR UNA DETERMINADA DISCAPACIDAD');
       TEXTCOLOR(GREEN);
       GOTOXY(45,20);
       WRITE('RESPUESTA: ');
       TEXTCOLOR(WHITE);
       READLN(OPCION);
       CASE OPCION OF
            1:evaluacionesPorFecha(ARCHIVOEVAL);
            2:compararValoracionesPorFecha(ARCHIVOEVAL);
            3:MUESTRADISCAPACIDADES (ARCH);
       END;
  UNTIL OPCION = 0 ;
  CLRSCR;
END;

PROCEDURE MENUPRINCIAL ();
VAR
  OPCION:0..4;
  ARCH:T_ARCHIVO_ALUMNOS;
  ARCH2:T_ARCHIVO_EVAL;
  RAIZ,RAIZ2,RAIZ3:T_PUNT_ARBOL ;
  CLAVE:sTRING;
BEGIN
     CREAR_ABRIR (ARCH);
      CREAR_ABRIR2 (ARCH2);
      CREAR_ARBOL ( RAIZ);
      CREAR_ARBOL ( RAIZ2);
      CREAR_ARBOL ( RAIZ3);
      PASAR_DATOS (ARCH,RAIZ,RAIZ2);
  REPEAT
       clrscr;
       TEXTCOLOR(WHITE);
       GOTOXY(40,10);
       WRITE('**BIENVENIDO A ');
       TEXTCOLOR(GREEN);
       WRITELN('SEGUIMIENTO DE APRENDIZAJE**');
       TEXTCOLOR(GREEN);
       GOTOXY(52,12);
       WRITE('1- ');
       TEXTCOLOR(WHITE);
       WRITELN('ALUMNO');
       GOTOXY(52,14);
       TEXTCOLOR(GREEN);
       WRITE('2- ');
       TEXTCOLOR(WHITE);
       WRITELN('SEGUIMIENTO');
       GOTOXY(52,16);
       TEXTCOLOR(GREEN);
       WRITE('3- ');
       TEXTCOLOR(WHITE);
       WRITELN('LISTADOS');
       GOTOXY(52,18);
       TEXTCOLOR(GREEN);
       WRITE('4- ');
       TEXTCOLOR(WHITE);
       WRITELN('ESTADISTICAS');
       GOTOXY(52,20);
       TEXTCOLOR(GREEN);
       WRITE('0- ');
       TEXTCOLOR(WHITE);
       WRITELN('SALIR DEL PROGRAMA');
       GOTOXY(52,22);
       TEXTCOLOR(GREEN);
       WRITE('RESPUESTA: ');
       TEXTCOLOR(WHITE);
       READLN(OPCION);
         CASE OPCION OF
            1:MENUALUMNO (arch,RAIZ, RAIZ2);
            2:MENUSEGUIMIENTO (RAIZ2,RAIZ,RAIZ3,ARCH2,ARCH);
            3:MENULISTADOS (ARCH,RAIZ,RAIZ2,ARCH2);
            4:MENUESTADISTICAS (arch2, ARCH);
       END;
  UNTIL OPCION = 0 ;
  CERRAR(ARCH);
  CERRAR2(ARCH2);
END;



END.
