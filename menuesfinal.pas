UNIT MENUESFINAL;

{$MODE OBJFPC}{$H+}

INTERFACE

USES
  CRT, ARCHIVOALUM, ARCHIVOEVAL, UNITARBOL, MANEJOALUMNO, MANEJOEVAL;

PROCEDURE MENUPRINCIAL ();
PROCEDURE MENUALUMNO (var archivoAlumno:t_archivo_alumnos; var RAIZLEGAJO, RAIZAPYNOM:T_PUNT_ARBOL);
PROCEDURE MENUSEGUIMIENTO (var RAIZLEGAJO, RAIZAPYNOM:T_PUNT_ARBOL; var archivoEval:t_archivo_eval);
PROCEDURE MENULISTADOS ();

IMPLEMENTATION


PROCEDURE MENUALUMNO (var archivoAlumno:t_archivo_alumnos; var RAIZLEGAJO, RAIZAPYNOM:T_PUNT_ARBOL);
VAR
  OPCION:0..4;
  x:t_dato_alumnos;
BEGIN
  CLRSCR;
  REPEAT
       WRITELN('1- ALTA');
       WRITELN('2- BAJA');
       WRITELN('3- MODIFICACIÓN');
       WRITELN('4- CONSULTA');
       READLN(OPCION);
       CASE OPCION OF
            1:DarAltaAlumno (archivoAlumno,x);
            2:BajaAlumno(raizapynom,raizlegajo,archivoAlumno);
            3:ModificarAlumno(raizapynom, raizlegajo,archivoAlumno);
            4:ConsultaAlumnos(raizapynom, raizlegajo,archivoAlumno);
       END;
  UNTIL OPCION = 0 ;
  CLRSCR;
END;

PROCEDURE MENUSEGUIMIENTO (var RAIZLEGAJO, RAIZAPYNOM:T_PUNT_ARBOL; var archivoEval:t_archivo_eval);
VAR
  OPCION:0..3;
  x:t_dato_eval;
BEGIN
  CLRSCR;
  REPEAT
       WRITELN('1- ALTA');
       WRITELN('2- MODIFICACIÓN');
       WRITELN('3- CONSULTA');
       READLN(OPCION);
       CASE OPCION OF
            1:DarAltaEval(archivoEval,x);
            2:modificarEval(raizapynom, raizlegajo,archivoEval);
            3:ConsultaEvaluacion(raizlegajo,archivoEval);
       END;
  UNTIL OPCION = 0 ;
  CLRSCR;
END;

PROCEDURE MENULISTADOS ();
VAR
  OPCION:0..3;
BEGIN
  CLRSCR;
  REPEAT
       WRITELN('1- NOMBRE Y APELLIDO');
       WRITELN('2- EVALUCIONES DE UN ALUMNO');
       WRITELN('3- ALUMNOS CON DETERMINADA DISCAPACIDAD');
       READLN(OPCION);
       {CASE OPCION OF
            1:'';
            2:'';
            3:'';
       END; }
  UNTIL OPCION = 0 ;
  CLRSCR;
END;

PROCEDURE MENUESTADISTICAS ();
VAR
   OPCION:0..4;
BEGIN
  CLRSCR;
  REPEAT
       WRITELN('1- DISTRIBUCIÓN DE EVALUACIONES POR DISCAPACIDAD');
       WRITELN('2- DISCAPACIDAD QUE PRESENTAN MAYOR GRADO DE DIFICULTAD');
       WRITELN('3- //');//INVENTAR UNA OPCION NUEVA
       READLN(OPCION);
       {CASE OPCION OF
            1:'';
            2:'';
            3:'';
       END;}
  UNTIL OPCION = 0 ;
  CLRSCR;
END;

PROCEDURE MENUPRINCIAL ();
VAR
  OPCION:0..4;
  ARCH:T_ARCHIVO_ALUMNOS;
  ARCH2:T_ARCHIVO_EVAL;
  RAIZ,RAIZ2:T_PUNT_ARBOL;
BEGIN
      CREAR_ABRIR (ARCH);
      CREAR_ABRIR2 (ARCH2);
      CREAR_ARBOL ( RAIZ);
      CREAR_ARBOL ( RAIZ2);
      PASAR_DATOS (ARCH,RAIZ,RAIZ2);
     TEXTCOLOR(WHITE);
     GOTOXY(40,10);
     WRITE('BIENVENIDO A ');
     TEXTCOLOR(GREEN);
     WRITELN('SEGUIMIENTO DE APRENDIZAJE');
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
       WRITE('RESPUESTA: ');
       TEXTCOLOR(WHITE);
       READLN(OPCION);
         CASE OPCION OF
            1:MENUALUMNO (arch,RAIZ, RAIZ2);
            2:MENUSEGUIMIENTO (RAIZ, RAIZ2,ARCH2);
            3:MENULISTADOS ();
            //4:MENUESTADISTICAS ();
       END;
  UNTIL OPCION = 0 ;
  CERRAR(ARCH);
  CERRAR2(ARCH2);
END;



END.