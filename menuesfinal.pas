UNIT MENUESFINAL;

{$MODE OBJFPC}{$H+}

INTERFACE

USES
  CRT, archivoAlum, archivoEval;

PROCEDURE MENUPRINCIAL (VAR arch:t_archivo_alumnos; VAR arch2:t_archivo_eval; VAR raiz,raiz2:t_punt_arbol);
PROCEDURE MENUALUMNO ();
PROCEDURE MENUSEGUIMIENTO ();
PROCEDURE MENULISTADOS ();

IMPLEMENTATION
PROCEDURE MENUPRINCIAL; // (VAR arch:t_archivo_alumnos; VAR arch2:t_archivo_eval; VAR raiz,raiz2:t_punt_arbol);
VAR
  OPCION:0..4;
BEGIN
      crear_abrir (VAR arch:t_archivo_alumnos);
      crear_abrir (VAR arch:t_archivo_alumnos);
     // CREAR_ARBOL (VAR RAIZ:T_PUNT_ARBOL);
     // CREAR_ARBOL (VAR RAIZ:T_PUNT_ARBOL);
     TEXTCOLOR(WHITE);
     GOTOXY(40,10);
     WRITE('BIENVENIDO A ');
     TEXTCOLOR(GREEN);
     WRITELN('SEGUIMIENTO DE APRENDIZAJE');
  REPEAT
       TEXTCOLOR(GREEN);
       GOTOXY(52,12);
       WRITE('1- ');
       textcolor(white);
       writeln('ALUMNO');
       GOTOXY(52,14);
       textcolor(green);
       WRITE('2- ');
       textcolor(white);
       writeln('SEGUIMIENTO');
       GOTOXY(52,16);
       textcolor(green);
       WRITE('3- ');
       textcolor(white);
       writeln('LISTADOS');
       GOTOXY(52,18);
       textcolor(green);
       WRITE('4- ');
       textcolor(white);
       writeln('ESTADISTICAS');
       GOTOXY(52,20);
       textcolor(green);
       WRITE('RESPUESTA: ');
       textcolor(white);
       READLN(OPCION);
       //CASE OPCION OF
            //1:'';
            //2:'';
            //3:'';
            //4:'';
       //END;
  UNTIL OPCION = 0 ;
  readkey;
END;

PROCEDURE MENUALUMNO ();
VAR
  OPCION:0..4;
BEGIN
  REPEAT
       WRITELN('1- ALTA');
       WRITELN('2- BAJA');
       WRITELN('3- MODIFICACIÓN');
       WRITELN('4- CONSULTA');
       READLN(OPCION);
       {CASE OPCION OF
            1:DarAltaAlumno (archivoAlumno,x);
            2:'';
            3:'';
            4:'';
       END;}
  UNTIL OPCION = 0 ;
END;

PROCEDURE MENUSEGUIMIENTO ();
VAR
  OPCION:0..3;
BEGIN
  REPEAT
       WRITELN('1- ALTA');
       WRITELN('2- MODIFICACIÓN');
       WRITELN('3- CONSULTA');
       READLN(OPCION);
       {CASE OPCION OF
            1:'';
            2:'';
            3:'';
       END;}
  UNTIL OPCION = 0 ;
END;

PROCEDURE MENULISTADOS ();
VAR
  OPCION:0..3;
BEGIN
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
END;

PROCEDURE MENUESTADISTICAS ();
VAR
   OPCION:0..4;
BEGIN
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
END;



END.

