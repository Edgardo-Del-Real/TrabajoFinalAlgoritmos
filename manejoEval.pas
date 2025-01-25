UNIT MANEJOEVAL;

{$CODEPAGE UTF8}

INTERFACE

USES
    CRT, ARCHIVOEVAL, UNITARBOL,SYSUTILS, VALIDACIONES ;

PROCEDURE CARGARDATOSEVAL (VAR X:T_DATO_EVAL);
PROCEDURE PASAR_DATOS_EVAL (VAR ARCH: T_ARCHIVO_EVAL; VAR RAIZLEGAJO,RAIZFECHA:T_PUNT_ARBOL);
PROCEDURE DARALTAEVAL (VAR ARCHIVOEVAL:T_ARCHIVO_EVAL; VAR X:T_DATO_EVAL);
PROCEDURE CARGARALTAEVAL (VAR ARCHIVOEVAL:T_ARCHIVO_EVAL; VAR X:T_DATO_EVAL);
PROCEDURE MUESTRADATOSEVAL(X:T_DATO_EVAL);
PROCEDURE CONSULTAEVALUACION(VAR RAIZLEGAJO: T_PUNT_ARBOL; VAR ARCHIVOEVAL: T_ARCHIVO_EVAL);
PROCEDURE MODIFICAREVAL(VAR RAIZAPYNOM, RAIZLEGAJO: T_PUNT_ARBOL; VAR ARCHIVOEVAL: T_ARCHIVO_EVAL);
FUNCTION BUSCAREVALUACION(VAR RAIZLEGAJO: T_PUNT_ARBOL; VAR ARCHIVOEVAL: T_ARCHIVO_EVAL; LEGAJO: STRING; FECHA: STRING): INTEGER;
PROCEDURE MUESTRA_REGISTRO_POR_TABLA_EVAL (VAR X: T_DATO_EVAL);

IMPLEMENTATION


PROCEDURE PASAR_DATOS_EVAL(VAR ARCH: T_ARCHIVO_EVAL; VAR RAIZLEGAJO, RAIZFECHA: T_PUNT_ARBOL);
VAR
  X: T_DATO_EVAL;
  I: BYTE;
  R: T_DATO_ARBOL;
  FECHA: STRING;
BEGIN
  I := 0;
  IF FILESIZE(ARCH) = 0 THEN
  BEGIN
    WRITELN('El archivo está vacío.');
    EXIT;
  END;

  WHILE (I < FILESIZE(ARCH)) AND NOT EOF(ARCH) DO
  BEGIN
    SEEK(ARCH, I);
    READ(ARCH, X);

    // Validar los datos de la fecha
    IF (X.FECHA_EVAL.ANIO > 0) AND (X.FECHA_EVAL.MES IN [1..12]) AND (X.FECHA_EVAL.DIA IN [1..31]) THEN
    BEGIN
      FECHA := INTTOSTR(X.FECHA_EVAL.ANIO) + INTTOSTR(X.FECHA_EVAL.MES) + INTTOSTR(X.FECHA_EVAL.DIA);
      R.CLAVE := FECHA;
      R.POSARCH := I;
      AGREGAR_ARBOL(RAIZFECHA, R);
    END
    ELSE
    BEGIN
      WRITELN('Fecha inválida en el registro: ', I);
    END;

    I := I + 1;
  END;
END;

{
PROCEDURE PASAR_DATOS_EVAL (VAR ARCH: T_ARCHIVO_EVAL; VAR RAIZLEGAJO,RAIZFECHA:T_PUNT_ARBOL);
VAR
  X: T_DATO_EVAL;
  I:BYTE;
  R:T_DATO_ARBOL;
  FECHA:STRING;
BEGIN
  I:= 0;
  IF FILESIZE (ARCH) >= 1 THEN
  BEGIN
 WHILE NOT EOF(ARCH) DO
   BEGIN
     SEEK (ARCH, I);
     READ (ARCH, X);
     FECHA:=(INTTOSTR(X.FECHA_EVAL.ANIO))+(INTTOSTR(X.FECHA_EVAL.MES))+(INTTOSTR(X.FECHA_EVAL.DIA));
     R.CLAVE:=FECHA;
     R.POSARCH:= I;
     AGREGAR_ARBOL (RAIZFECHA, R);
     I:= I + 1;
   END;
 END;
END;         }


PROCEDURE CARGARDATOSEVAL (VAR X:T_DATO_EVAL);
VAR
   I:BYTE;
   FECHA:STRING;
   VALORACION:INTEGER;
BEGIN
     CLRSCR;
     GOTOXY(50,10);
     WRITELN('**DAR ALTA EVALUACIÓN**');
     TEXTCOLOR(GREEN);
     GOTOXY(45,12);
     WRITE('INGRESE NUMERO DE LEGAJO: ');
     TEXTCOLOR(WHITE);
     READLN(X.NUM_LEGAJO);               //esto no hay que pedirle porque se soluciona pidiendo la contraseña antes
     TEXTCOLOR(GREEN);
     GOTOXY(45,14);
     WRITE('INGRESE DIA DE EVALUACIÓN: ');
     TEXTCOLOR(WHITE);
     READLN(X.FECHA_EVAL.DIA);
     TEXTCOLOR(GREEN);
     GOTOXY(45,16);
     WRITE('INGRESE MES DE EVALUACIÓN: ');
     TEXTCOLOR(WHITE);
     READLN(X.FECHA_EVAL.MES);
     TEXTCOLOR(GREEN);
     GOTOXY(45,18);
     WRITE('INGRESE AÑO DE EVALUACIÓN: ');
     TEXTCOLOR(WHITE);
     READLN(X.FECHA_EVAL.ANIO);
     FECHA:=(INTTOSTR(X.FECHA_EVAL.DIA)) + ' / ' + (INTTOSTR(X.FECHA_EVAL.MES)) + ' / ' + (INTTOSTR(X.FECHA_EVAL.ANIO));
           WHILE NOT  EsFechaValida(Fecha) DO
           BEGIN
             CLRSCR;
             TEXTCOLOR(RED);
             GOTOXY(45,10);
             WRITELN('POR FAVOR REVISE LA COHERENCIA DE SUS DATOS INGRESADOR');
             GOTOXY(45,12);
             WRITELN('RECUERDE QUE NO PUEDE INGRESAR UNA FECHA POSTERIOR A LA DE HOY');
           GOTOXY(45,14);
           TEXTCOLOR(GREEN);
           WRITE('INGRESE DIA DE EVALUACIÓN: ');
           TEXTCOLOR(WHITE);
           READLN(X.FECHA_EVAL.DIA);
           TEXTCOLOR(GREEN);
           GOTOXY(45,16);
           WRITE('INGRESE MES DE EVALUACIÓN: ');
           TEXTCOLOR(WHITE);
           READLN(X.FECHA_EVAL.MES);
           TEXTCOLOR(GREEN);
           GOTOXY(45,18);
           WRITE('INGRESE AÑO DE EVALUACIÓN: ');
           TEXTCOLOR(WHITE);
           READLN(X.FECHA_EVAL.ANIO);
           FECHA:=(INTTOSTR(X.FECHA_EVAL.DIA)) + ' / ' + (INTTOSTR(X.FECHA_EVAL.MES)) + ' / ' + (INTTOSTR(X.FECHA_EVAL.ANIO));
           END;

     GOTOXY(45,20);
     WRITELN('INGRESE LAS VALORACIONES: ');
     FOR I:=1 TO 5 DO                                 //esto hay que validar
       BEGIN
          CLRSCR;
          VALORACION := 0;
          TEXTCOLOR(GREEN);
          GOTOXY(45,14);
          WRITELN('EN UNA ESCALA DEL 1 AL 4, INGRESE EL VALOR ADECUADO A LA DISCAPACIDAD');
          TEXTCOLOR(GREEN);
          GOTOXY(45,16);
          WRITELN('DONDE 1 ES EL VALOR MÍNIMO Y 4 EL MÁXIMO');
          GOTOXY(45,22);
          WRITE('VALORACIÓN ', I, ': ');
          TEXTCOLOR(WHITE);
          READLN(VALORACION);
          WHILE (VALORACION < 1) OR (VALORACION > 4) DO
          BEGIN
            CLRSCR;
            TEXTCOLOR(RED);
            GOTOXY(45,10);
            WRITELN('POR FAVOR REVISE LA COHERENCIA DE SUS DATOS INGRESADOR');
            GOTOXY(45,12);
            WRITELN('RECUERDE QUE EL VALOR DEBE ESTAR ENTRE 1 Y 4');
            GOTOXY(45,22);
            WRITE('VALORACIÓN ', I, ': ');
            TEXTCOLOR(WHITE);
            READLN(VALORACION);
          END;
          X.VALORACION[I] := VALORACION;
       END;
     TEXTCOLOR(GREEN);
     GOTOXY(45,24);
     WRITE('INGRESE UNA OBSERVACIÓN: ');
     TEXTCOLOR(WHITE);
     READLN(X.OBS);
     CLRSCR;
END;

PROCEDURE MUESTRADATOSEVAL(X:T_DATO_EVAL);
BEGIN
    CLRSCR;
    GOTOXY(42,10);
    WRITELN('DATOS ACTUALES DE LA EVALUACION:');
    TEXTCOLOR(GREEN);
    GOTOXY(45,12);
    WRITE('LEGAJO: ');
    TEXTCOLOR(WHITE);
    WRITELN(X.NUM_LEGAJO);
    TEXTCOLOR(GREEN);
    GOTOXY(45,14);
    WRITE('FECHA: ');
    TEXTCOLOR(WHITE);
    WRITELN(X.FECHA_EVAL.DIA, '/', X.FECHA_EVAL.MES, '/', X.FECHA_EVAL.ANIO);
    TEXTCOLOR(GREEN);
    GOTOXY(45,16);
    WRITE('VALORACION: ');
    TEXTCOLOR(WHITE);
    WRITELN(X.VALORACION[1], ' ', X.VALORACION[2], ' ', X.VALORACION[3], ' ', X.VALORACION[4], ' ', X.VALORACION[5]);
    TEXTCOLOR(GREEN);
    GOTOXY(45,18);
    WRITE('OBSERVACIONES: ');
    TEXTCOLOR(WHITE);
    WRITELN(X.OBS);
    READKEY;
    CLRSCR;
END;

PROCEDURE CARGARALTAEVAL (VAR ARCHIVOEVAL:T_ARCHIVO_EVAL; VAR X:T_DATO_EVAL);
BEGIN
    SEEK(ARCHIVOEVAL, FILESIZE(ARCHIVOEVAL));
    WRITE(ARCHIVOEVAL, X);
END;

PROCEDURE DARALTAEVAL (VAR ARCHIVOEVAL:T_ARCHIVO_EVAL; VAR X:T_DATO_EVAL);
VAR
    FINARCH:CARDINAL;
BEGIN
    CARGARDATOSEVAL(X);
    CARGARALTAEVAL(ARCHIVOEVAL, X);
END;

FUNCTION BUSCAREVALUACION(VAR RAIZLEGAJO: T_PUNT_ARBOL; VAR ARCHIVOEVAL: T_ARCHIVO_EVAL; LEGAJO: STRING; FECHA: STRING): INTEGER;
VAR
  POS,I: INTEGER;
  X: T_DATO_EVAL;
BEGIN
    BUSCAREVALUACION:=-1;
FOR I:=0 TO FILESIZE(ARCHIVOEVAL)-1 DO
  BEGIN
  SEEK(ARCHIVOEVAL, I);
  READ(ARCHIVOEVAL,X);
  IF X.NUM_LEGAJO = LEGAJO THEN
    BEGIN
    IF (X.FECHA_EVAL.DIA = (STRTOINT(COPY(FECHA, 1, 2)))) AND
       (X.FECHA_EVAL.MES = (STRTOINT(COPY(FECHA, 4, 2)))) AND
       (X.FECHA_EVAL.ANIO = (STRTOINT(COPY(FECHA, 7, 4)))) THEN
      BUSCAREVALUACION := I;
  END;
END;
END;

PROCEDURE CONSULTAEVALUACION(VAR RAIZLEGAJO: T_PUNT_ARBOL; VAR ARCHIVOEVAL: T_ARCHIVO_EVAL);
VAR
  BUSCADOLEGAJO: STRING;
  BUSCADOFECHA: STRING;
  POS: INTEGER;
  X: T_DATO_EVAL;
BEGIN
  CLRSCR;
  GOTOXY(52,10);
  WRITELN('**CONSULTA EVALUACION**');
  TEXTCOLOR(GREEN);
  GOTOXY(45,12);
  WRITE('INGRESE LEGAJO DEL ALUMNO: ');
  TEXTCOLOR(WHITE);
  READLN(BUSCADOLEGAJO);

  while not esnumero(buscadolegajo) do
  begin
    clrscr;
  TEXTCOLOR(GREEN);
  GOTOXY(45,12);
  WRITE('HUBO UN ERROR. INGRESE NUEVAMENTE EL LEGAJO DEL ALUMNO: ');
  TEXTCOLOR(WHITE);
  READLN(BUSCADOlegajo);
  end;

  TEXTCOLOR(GREEN);
  GOTOXY(45,14);
  WRITE('INGRESE FECHA DE LA EVALUACION (DD/MM/AAAA): ');
  TEXTCOLOR(WHITE);
  READLN(BUSCADOFECHA);
  WHILE NOT  EsFechaValida(buscadoFecha) DO   //aca hay que laburar un poquito mas por como cargar la fecha.
  begin
       clrscr;
       writeln('FECHA INGRESADA NO VALIDA. POR FAVOR REVISE SUS DATOS');
       WRITE('NUEVA FECHA: ');
       READLN(buscadoFECHA);
  end;

  POS := BUSCAREVALUACION(RAIZLEGAJO, ARCHIVOEVAL, BUSCADOLEGAJO, BUSCADOFECHA);
  IF POS = -1 THEN
    BEGIN
      GOTOXY(45,16);
      WRITELN('NO SE ENCUENTRA REGISTRO DE EVALUACION');
    END
  ELSE
    BEGIN
      SEEK(ARCHIVOEVAL, POS);
      READ(ARCHIVOEVAL, X);
      MUESTRADATOSEVAL(X);
    END;
    CLRSCR;
END;



PROCEDURE MODIFICAREVAL(VAR RAIZAPYNOM, RAIZLEGAJO: T_PUNT_ARBOL; VAR ARCHIVOEVAL: T_ARCHIVO_EVAL);
VAR
  LEGAJO, FECHA: STRING;
  POS: INTEGER;
  X: T_DATO_EVAL;
  OPCION,I: INTEGER;
BEGIN
  CLRSCR;
  GOTOXY(50,10);
  WRITELN('**MODIFICAR EVALUACION**');
  TEXTCOLOR(GREEN);
  GOTOXY(45,12);
  WRITE('INGRESE LEGAJO: ');
  TEXTCOLOR(WHITE);
  READLN(LEGAJO);

  while not esnumero(legajo) do
  begin
    clrscr;
  TEXTCOLOR(GREEN);
  GOTOXY(45,12);
  WRITE('HUBO UN ERROR. INGRESE NUEVAMENTE EL LEGAJO DEL ALUMNO: ');
  TEXTCOLOR(WHITE);
  READLN(legajo);
  end;

  TEXTCOLOR(GREEN);
  GOTOXY(45,14);
  WRITE('INGRESE FECHA DD/MM/AAAA: ');
  TEXTCOLOR(WHITE);
  READLN(FECHA);
  WHILE NOT  EsFechaValida(Fecha) DO
  begin
       clrscr;
       writeln('FECHA INGRESADA NO VALIDA. POR FAVOR REVISE SUS DATOS');
       WRITE('NUEVA FECHA: ');
       READLN(FECHA);
  end;
  POS := BUSCAREVALUACION(RAIZLEGAJO,ARCHIVOEVAL,LEGAJO,FECHA);
  IF POS = -1 THEN
    BEGIN
    GOTOXY(45,16);
    WRITELN('NO SE ENCUENTRA REGISTRO DE EVALUACION')
    END
  ELSE
    BEGIN
      SEEK(ARCHIVOEVAL, POS);
      READ(ARCHIVOEVAL, X);

      MUESTRADATOSEVAL(X);

      GOTOXY(45,12);
      WRITELN('INGRESE EL CAMPO A MODIFICAR DE LA EVALUACION:');
      TEXTCOLOR(GREEN);
      GOTOXY(45,14);
      WRITE('1- ');
      TEXTCOLOR(WHITE);
      WRITELN('FECHA DE LA EVALUACION (DD/MM/AAAA)');
      TEXTCOLOR(GREEN);
      GOTOXY(45,16);
      WRITE('2- ');
      TEXTCOLOR(WHITE);
      WRITELN('VALORACION (1-5)');
      TEXTCOLOR(GREEN);
      GOTOXY(45,18);
      WRITE('3- ');
      TEXTCOLOR(WHITE);
      WRITELN('OBSERVACIONES');
      TEXTCOLOR(GREEN);
      GOTOXY(45,20);
      WRITE('OPCION: ');
      TEXTCOLOR(WHITE);
      READLN(OPCION);

    IF (OPCION < 1) OR (OPCION > 3) THEN
      BEGIN
        GOTOXY(45,22);
        WRITELN('OPCION INVALIDA');
      END
    ELSE
      BEGIN
        CASE OPCION OF
          1:
          BEGIN
            CLRSCR;
            TEXTCOLOR(GREEN);
            GOTOXY(40,12);
            WRITE('INGRESE LA NUEVA FECHA DE LA EVALUACION (DD/MM/AAAA): ');
            TEXTCOLOR(WHITE);
            GOTOXY(92,12);
            WRITE();
            GOTOXY(94,12);
            READ(X.FECHA_EVAL.DIA);
            GOTOXY(96,12);
            TEXTCOLOR(GREEN);
            WRITE('/');
            GOTOXY(98,12);
            TEXTCOLOR(WHITE);
            READ(X.FECHA_EVAL.MES);
            GOTOXY(100,12);
            TEXTCOLOR(GREEN);
            WRITE('/');
            TEXTCOLOR(WHITE);
            READ(X.FECHA_EVAL.ANIO);
            FECHA:=(INTTOSTR(X.FECHA_EVAL.DIA)) + ' / ' + (INTTOSTR(X.FECHA_EVAL.MES)) + ' / ' + (INTTOSTR(X.FECHA_EVAL.ANIO));
           WHILE NOT  EsFechaValida(Fecha) DO
           BEGIN
             CLRSCR;
             TEXTCOLOR(RED);
             GOTOXY(40,10);
             WRITELN('POR FAVOR REVISE LA COHERENCIA DE SUS DATOS INGRESADOR');
             GOTOXY(40,12);
             WRITELN('RECUERDE QUE NO PUEDE INGRESAR UNA FECHA POSTERIOR A LA DE HOY');
             GOTOXY(40,14);
             TEXTCOLOR(GREEN);
             WRITE('INGRESE LA NUEVA FECHA DE LA EVALUACION (DD/MM/AAAA): ');
             TEXTCOLOR(WHITE);
              GOTOXY(92,14);
              WRITE();
              GOTOXY(94,14);
              READ(X.FECHA_EVAL.DIA);
              GOTOXY(96,14);
              TEXTCOLOR(GREEN);
              WRITE('/');
              GOTOXY(98,14);
              TEXTCOLOR(WHITE);
              READ(X.FECHA_EVAL.MES);
              GOTOXY(100,14);
              TEXTCOLOR(GREEN);
              WRITE('/');
              TEXTCOLOR(WHITE);
              READ(X.FECHA_EVAL.ANIO);
           FECHA:=(INTTOSTR(X.FECHA_EVAL.DIA)) + ' / ' + (INTTOSTR(X.FECHA_EVAL.MES)) + ' / ' + (INTTOSTR(X.FECHA_EVAL.ANIO));
           END;
          END;
          2:
          BEGIN
            CLRSCR;
            TEXTCOLOR(GREEN);
            GOTOXY(45,12);
            WRITE('INGRESE LA NUEVA VALORACION (1-5): ');
            FOR I:= 1 TO 5 DO
              TEXTCOLOR(WHITE);
              READLN(X.VALORACION[I]);       //reveer esto, hacer que solo se modifique 1 por vez y si esta disponible.
          END;
          3:
          BEGIN
            CLRSCR;
            TEXTCOLOR(GREEN);
            GOTOXY(45,12);
            WRITE('INGRESE LAS NUEVAS OBSERVACIONES: ');
            TEXTCOLOR(WHITE);
            READLN(X.OBS);
          END;
        END;

        SEEK(ARCHIVOEVAL, POS);
        WRITE(ARCHIVOEVAL, X);
        GOTOXY(45,20);
        WRITELN('EVALUACION MODIFICADA CORRECTAMENTE');
      END;
  END;
  READKEY;
  CLRSCR;
END;

PROCEDURE MUESTRA_REGISTRO_POR_TABLA_EVAL (VAR X: T_DATO_EVAL);
VAR
  FECHA:STRING;
BEGIN
  FECHA:=(INTTOSTR(X.FECHA_EVAL.DIA)) + ' / ' + (INTTOSTR(X.FECHA_EVAL.MES)) + ' / ' + (INTTOSTR(X.FECHA_EVAL.ANIO));
  WITH X DO
  BEGIN
    WRITE(NUM_LEGAJO:10, FECHA:30, VALORACION[1]:12, VALORACION[2]:10, VALORACION[3]:10, VALORACION[4]:10, VALORACION[5]:10);
    WRITELN;
  END;
END;




 END.