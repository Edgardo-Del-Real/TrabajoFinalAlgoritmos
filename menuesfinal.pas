UNIT MENUESFINAL;

{$MODE OBJFPC}{$H+}

INTERFACE

USES
  CRT, ARCHIVOALUM, ARCHIVOEVAL;

PROCEDURE MENUPRINCIAL ();
PROCEDURE MENUALUMNO ();
PROCEDURE MENUSEGUIMIENTO ();
PROCEDURE MENULISTADOS ();

IMPLEMENTATION
PROCEDURE MENUPRINCIAL ();
VAR
  OPCION:0..4;
BEGIN
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

