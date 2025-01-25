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
  OPCION:0..4;
  X:t_dato_alumnos;
  RESPUESTA:STRING;
  pos:integer;
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
VALIDACION_CLAVE (RESPUESTA, POS, RAIZLEGAJO, RAIZAPYNOM);
IF RESPUESTA = 'S' THEN
BEGIN
WRITE ('ALTA DE ALUMNOS');
DARALTAALUMNO(ARCHIVOALUMNO, X);
PASAR_DATOS(ARCHIVOALUMNO,RAIZLEGAJO,RAIZAPYNOM);
END;
IF RESPUESTA = 'C' THEN
BEGIN
CLRSCR;
         GOTOXY(20,5);
         TEXTCOLOR(WHITE);
         WRITELN('A CONTINUACIÓN PODRA OBSERVAR LOS DATOS REGISTRADOS DEL ALUMNO SOLICITADO ');
         TEXTCOLOR(WHITE);
         MOSTRARALUMNO (archivoAlumno, POS);
         GOTOXY(20,27);
         TEXTCOLOR(WHITE);
         WRITELN ('PARA TERMINAR DE VISUALIZAR LOS DATOS Y PROCEDER AL MENU DE BM <<PRESIONE ENTER>>');
         READKEY;
         CLRSCR;
REPEAT

  CLRSCR;
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
            //1:DarAltaAlumno (archivoAlumno,x);
            1:BAJAALUMNO(archivoAlumno, POS);
            2:ModificarAlumno(archivoAlumno,POS);
            3:MOSTRARALUMNO (archivoAlumno,POS);
       END;
  UNTIL OPCION = 0 ;
  CLRSCR;
END;

end;

PROCEDURE MENUSEGUIMIENTO (var RAIZAPYNOM,RAIZLEGAJO,RAIZFECHA:T_PUNT_ARBOL; var archivoEval:t_archivo_eval; var ARCHIVOALUMNO:t_archivo_alumnos);
VAR
  OPCION:0..3;
  x:t_dato_eval;
  x2:t_dato_alumnos;
  RESPUESTA:STRING;
  POS:INTEGER;
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
VALIDACION_CLAVE (RESPUESTA, POS, RAIZLEGAJO, RAIZAPYNOM);
IF RESPUESTA = 'S' THEN
BEGIN
WRITE ('ALTA DE ALUMNOS');
DARALTAALUMNO(ARCHIVOALUMNO, X2);
PASAR_DATOS(ARCHIVOALUMNO,RAIZLEGAJO,RAIZAPYNOM);
END;
IF RESPUESTA = 'C' THEN
BEGIN
CLRSCR;
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
            1:DarAltaEval(archivoEval,x);
            2:modificarEval(raizfecha, raizlegajo,archivoEval);
            3:ConsultaEvaluacion(raizlegajo,archivoEval);
       END;
  UNTIL OPCION = 0 ;
  CLRSCR;
END;

end;

PROCEDURE MENULISTADOS (VAR ARCH:T_ARCHIVO_ALUMNOS; RAIZAPYNOM, RAIZLEGAJO:T_PUNT_ARBOL; var ARCH2:T_ARCHIVO_EVAL);
VAR
  OPCION:0..3;
BEGIN
  CLRSCR;
  TEXTCOLOR(WHITE);
  GOTOXY(49,10);
  WRITE('**BIENVENIDO AL ');
  TEXTCOLOR(GREEN);
  WRITELN('MENU DE LISTADOS**');
  REPEAT
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
            1: listado_apynom (ARCH, RAIZAPYNOM);
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
  CLRSCR;
  TEXTCOLOR(WHITE);
  GOTOXY(52,10);
  WRITE('**BIENVENIDO AL ');
  TEXTCOLOR(GREEN);
  WRITELN('MENU DE ESTADISTICAS**');
  REPEAT
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
BEGIN
     CREAR_ABRIR (ARCH);
      CREAR_ABRIR2 (ARCH2);
      CREAR_ARBOL ( RAIZ);
      CREAR_ARBOL ( RAIZ2);
      CREAR_ARBOL ( RAIZ3);
      PASAR_DATOS (ARCH,RAIZ,RAIZ2);
     TEXTCOLOR(WHITE);
     GOTOXY(40,10);
     WRITE('**BIENVENIDO A ');
     TEXTCOLOR(GREEN);
     WRITELN('SEGUIMIENTO DE APRENDIZAJE**');
  REPEAT
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