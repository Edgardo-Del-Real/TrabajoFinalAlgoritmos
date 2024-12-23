UNIT LISTADOS;

{$CODEPAGE UTF8}

INTERFACE

USES
  UNITARBOL, ARCHIVOALUM, CRT, MANEJOALUMNO, ARCHIVOEVAL, MANEJOEVAL;

PROCEDURE MOSTRAR_ENCABEZADO_TABLA;
PROCEDURE LISTADO_APYNOM (VAR ARCH:T_ARCHIVO_ALUMNOS; RAIZAPYNOM: T_PUNT_ARBOL);
PROCEDURE MOSTRAR_REGISTRO_POR_POSICION(VAR ARCH:T_ARCHIVO_ALUMNOS; POS: WORD);
PROCEDURE LISTADO_POR_ENFERMEDAD (VAR ARCH:T_ARCHIVO_ALUMNOS);
PROCEDURE CONSULTAEVALDEALUMNO(VAR ARCHIVOEVAL:T_ARCHIVO_EVAL; RAIZLEGAJO, RAIZAPYNOM:T_PUNT_ARBOL);
PROCEDURE MOSTRAR_ENCABEZADO_TABLA_ARCHIVO;

IMPLEMENTATION

PROCEDURE MOSTRAR_ENCABEZADO_TABLA;
BEGIN
  GOTOXY(1, 1);
  TEXTCOLOR(LIGHTBLUE);
  WRITELN('LEGAJO':10, ' NOMBRE Y APELLIDO   ':30, ' NACIMIENTO   ':20, ' ESTADO ':10, ' DIS1':10, ' DIS2':10, ' DIS3':10, ' DIS4':10, ' DIS5':10 );
  WRITELN;
  TEXTCOLOR(WHITE);
END;

PROCEDURE MOSTRAR_REGISTRO_POR_POSICION(VAR ARCH:T_ARCHIVO_ALUMNOS; POS: WORD);
VAR
  X: T_DATO_ALUMNOS;
BEGIN
  SEEK(ARCH, POS);
  READ(ARCH, X);
  MUESTRA_REGISTRO_POR_TABLA(X);
END;

PROCEDURE MOSTRAR_EN_ORDEN(VAR ARCH:T_ARCHIVO_ALUMNOS; RAIZ: T_PUNT_ARBOL);
BEGIN
  IF RAIZ <> NIL THEN
  BEGIN
    MOSTRAR_EN_ORDEN(ARCH, RAIZ^.SAI);
    MOSTRAR_REGISTRO_POR_POSICION(ARCH, RAIZ^.INFO.POSARCH);
    MOSTRAR_EN_ORDEN(ARCH, RAIZ^.SAD);
  END;
END;

PROCEDURE LISTADO_APYNOM (VAR ARCH:T_ARCHIVO_ALUMNOS; RAIZAPYNOM: T_PUNT_ARBOL);
BEGIN
  CLRSCR;
MOSTRAR_ENCABEZADO_TABLA;
MOSTRAR_EN_ORDEN(ARCH,RAIZAPYNOM);
READKEY;
CLRSCR;
END;


PROCEDURE LISTADO_POR_ENFERMEDAD (VAR ARCH:T_ARCHIVO_ALUMNOS);
VAR
  POS,I:BYTE;
  X:T_DATO_ALUMNOS;
BEGIN
  CLRSCR;
  GOTOXY(52,10);
  WRITELN('INGRESE LA DISCAPACIDAD A LISTAR: ');
  TEXTCOLOR(GREEN);
  GOTOXY(45,12);
  WRITE('1- ');
  TEXTCOLOR(WHITE);
  WRITELN('PROBLEMAS DEL HABLA Y LENGUAJE');
  TEXTCOLOR(GREEN);
  GOTOXY(45,14);
  WRITE('2- ');
  TEXTCOLOR(WHITE);
  WRITELN('DIFICULTAD PARA ESCRIBIR');
  TEXTCOLOR(GREEN);
  GOTOXY(45,16);
  WRITE('3- ');
  TEXTCOLOR(WHITE);
  WRITELN('DIFICULTADES DE APRENDIZAJE VISUAL');
  TEXTCOLOR(GREEN);
  GOTOXY(45,18);
  WRITE('4- ');
  TEXTCOLOR(WHITE);
  WRITELN('MEMORIA Y OTRAS DIFICULTADES DEL PENSAMIENTO');
  TEXTCOLOR(GREEN);
  GOTOXY(45,20);
  WRITE('5- ');
  TEXTCOLOR(WHITE);
  WRITELN('DESTREZAS SOCIALES INADECUADAS');
  TEXTCOLOR(GREEN);
  GOTOXY(45,22);
  WRITE('RESPUESTA: ');
  TEXTCOLOR(WHITE);
  READLN(POS);
  CLRSCR;
  MOSTRAR_ENCABEZADO_TABLA;
  FOR I := 0 TO FILESIZE(ARCH)-1 DO
   BEGIN
    SEEK(ARCH,I);
    READ(ARCH,X);

    IF X.DISCAPACIDAD[POS] THEN
     MUESTRA_REGISTRO_POR_TABLA(X);

   END;
  READKEY;
  CLRSCR;
END;

PROCEDURE MOSTRAR_ENCABEZADO_TABLA_ARCHIVO;
BEGIN
  GOTOXY(1, 1);
  TEXTCOLOR(LIGHTBLUE);
  WRITELN('LEGAJO':10, ' FECHA ':20, ' VALORACIONES ':10, ' VAL1':10, ' VAL2':10, ' VAL3':10, ' VAL4':10, ' VAL5':10 );
  WRITELN;
  TEXTCOLOR(WHITE);
END;

PROCEDURE CONSULTAEVALDEALUMNO(VAR ARCHIVOEVAL:T_ARCHIVO_EVAL; RAIZLEGAJO, RAIZAPYNOM:T_PUNT_ARBOL);
VAR
  BUSCADO: STRING;
  POS,I: INTEGER;
  X: T_DATO_EVAL;
BEGIN
  CLRSCR;
  GOTOXY(47,10);
  WRITELN('**CONSULTA DE EVALUACIONES POR ALUMNO**');
  TEXTCOLOR(GREEN);
  GOTOXY(45,12);
  WRITE('LEGAJO DEL ALUMNO: ');
  TEXTCOLOR(WHITE);
  READLN(BUSCADO);
  CLRSCR;
  MOSTRAR_ENCABEZADO_TABLA_ARCHIVO;
  FOR I:=0 TO FILESIZE(ARCHIVOEVAL) - 1 DO
   BEGIN
    SEEK(ARCHIVOEVAL,I);
    READ(ARCHIVOEVAL,X);
    IF X.NUM_LEGAJO = BUSCADO THEN
    BEGIN
    MUESTRA_REGISTRO_POR_TABLA_EVAL (X);
    END;
END;
  READKEY;
  CLRSCR;
END;



END.
