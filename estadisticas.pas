  UNIT ESTADISTICAS;

  {$CODEPAGE UTF8}

  INTERFACE

  USES
    CRT, SYSUTILS, ARCHIVOEVAL, ARCHIVOALUM;

  PROCEDURE EVALUACIONESPORFECHA(VAR ARCHIVOEVAL:T_ARCHIVO_EVAL);
  FUNCTION CONVERTIR_FECHA(X:STRING):INTEGER;
  FUNCTION CANTIDAD_EVALUACIONES_POR_FECHA (VAR ARCHIVOEVAL:T_ARCHIVO_EVAL; FF,FI:INTEGER):INTEGER;
  PROCEDURE COMPARARVALORACIONESPORFECHA(VAR ARCHIVOEVAL: T_ARCHIVO_EVAL);
  PROCEDURE MOSTRARRESULTADO(FECHAINICIO, FECHAFIN: STRING; MAXSUMATORIA, MAXVALORACION: INTEGER);
  PROCEDURE OBTENERSUMATORIAS(VAR ARCHIVOEVAL: T_ARCHIVO_EVAL; FECHAINICIO, FECHAFIN: STRING; VAR SUMATORIAS: ARRAY OF INTEGER);
  PROCEDURE MUESTRADISCAPACIDADES (VAR ARCH: T_ARCHIVO_ALUMNOS);
  FUNCTION CANTIDAD_ALUMNOS_DISCAPACIDAD (VAR ARCH: T_ARCHIVO_ALUMNOS ; RES:INTEGER):INTEGER;

  IMPLEMENTATION
  FUNCTION CONVERTIR_FECHA(X:STRING):INTEGER; //CONVIERTE LAS FECHAS DE FORMATO DD/MM/AAAA A N° DE DIAS
    VAR D,M,A:INTEGER;
    BEGIN
      D:= STRTOINT(COPY(X,1,2));
      M:= STRTOINT(COPY(X,4,2));
      A:= STRTOINT(COPY(X,7,4));
      CONVERTIR_FECHA:= ((A*365)+(M*30)+D);
    END;

  FUNCTION CANTIDAD_EVALUACIONES_POR_FECHA (VAR ARCHIVOEVAL:T_ARCHIVO_EVAL; FF,FI:INTEGER):INTEGER;
  VAR
     X:T_DATO_EVAL;
     CONT,FECHAENDIAS,I:INTEGER;
     FECHA:STRING;
     BEGIN
       CONT:=0;
        FOR I:=0 TO FILESIZE(ARCHIVOEVAL)-1 DO
            BEGIN
            SEEK(ARCHIVOEVAL,I);
            READ(ARCHIVOEVAL,X);
             FECHA:=(INTTOSTR(X.FECHA_EVAL.DIA))+'/'+(INTTOSTR(X.FECHA_EVAL.MES))+'/'+(INTTOSTR(X.FECHA_EVAL.ANIO));
             FECHAENDIAS:=CONVERTIR_FECHA(FECHA);
             IF (FECHAENDIAS>=FI) AND (FF>=FECHAENDIAS) THEN
                CONT:=CONT+1;

     END;
        CANTIDAD_EVALUACIONES_POR_FECHA:=CONT;
     END;

  PROCEDURE EVALUACIONESPORFECHA(VAR ARCHIVOEVAL:T_ARCHIVO_EVAL);
  VAR
     CONT:INTEGER;
     FECHA_INICIO,FECHA_FIN:STRING;
     FI,FF:INTEGER;
     BEGIN
       WRITELN('INGRESE FECHA DE INICIO DD/MM/AAAA');
       READLN(FECHA_INICIO);
       FI:=CONVERTIR_FECHA(FECHA_INICIO);
       WRITELN('INGRESE FECHA DE FIN DD/MM/AAAA');
       READLN(FECHA_FIN);
       FF:= CONVERTIR_FECHA(FECHA_FIN);
       CONT:=CANTIDAD_EVALUACIONES_POR_FECHA(ARCHIVOEVAL,FF,FI);
       WRITELN('LA CANTIDAD DE EVALUACIONES REALIZADADAS ENTRE: ', FECHA_INICIO, ' Y ', FECHA_FIN,' FUERON DE: ', CONT);

     END;

  FUNCTION OBTENERNOMBREDISCAPACIDAD(VALORACION: INTEGER): STRING;
  BEGIN
    CASE VALORACION OF
      1: OBTENERNOMBREDISCAPACIDAD := 'PROBLEMAS DEL HABLA Y LENGUAJE';
      2: OBTENERNOMBREDISCAPACIDAD := 'DIFICULTAD PARA ESCRIBIR';
      3: OBTENERNOMBREDISCAPACIDAD := 'DIFICULTADES DE APRENDIZAJE VISUAL';
      4: OBTENERNOMBREDISCAPACIDAD := 'MEMORIA Y OTRAS DIFICULTADES DEL PENSAMIENTO';
      5: OBTENERNOMBREDISCAPACIDAD := 'DESTREZAS SOCIALES INADECUADAS';
  END;
  END;

  PROCEDURE MOSTRARRESULTADO(FECHAINICIO, FECHAFIN: STRING; MAXSUMATORIA, MAXVALORACION: INTEGER);
BEGIN
  IF MAXVALORACION <> 0 THEN
  WRITELN('LA VALORACIÓN CON LA MAYOR SUMATORIA ENTRE ', FECHAINICIO, ' Y ', FECHAFIN, ' ES LA DE LA DIFICULTAD ', OBTENERNOMBREDISCAPACIDAD(MAXVALORACION), ' CON UNA SUMATORIA DE ', MAXSUMATORIA)
  ELSE
      WRITELN('NO ES POSIBLE DETERMINAR LA MAYOR VALUACION PARA UNA DIFICULTAD ENTRE LAS FECHAS INGRESADAS');
END;

  PROCEDURE ENCONTRARMAXSUMATORIA(SUMATORIAS: ARRAY OF INTEGER; VAR MAXSUMATORIA, MAXVALORACION: INTEGER);
VAR
  J: INTEGER;
BEGIN
  MAXSUMATORIA := 0;
  MAXVALORACION := 0;
  FOR J := 1 TO 5 DO
  BEGIN
    IF SUMATORIAS[J] > MAXSUMATORIA THEN
    BEGIN
      MAXSUMATORIA := SUMATORIAS[J];
      MAXVALORACION := J;
    END;
  END;
END;

  PROCEDURE COMPARARVALORACIONESPORFECHA(VAR ARCHIVOEVAL: T_ARCHIVO_EVAL);
VAR
  SUMATORIAS: ARRAY[1..5] OF INTEGER;
  FECHAINICIODIAS, FECHAFINDIAS, I, J, FECHAENDIAS, MAXSUMATORIA, MAXVALORACION: INTEGER;
  X: T_DATO_EVAL;
  FECHAINICIO, FECHAFIN, FECHA,MAXDISCAPACIDAD: STRING ;
BEGIN
  MAXSUMATORIA := 0;
  MAXVALORACION := 0;

  WRITELN('INGRESE FECHA DE INICIO DD/MM/AAAA');
  READLN(FECHAINICIO);
  WRITELN('INGRESE FECHA DE FIN DD/MM/AAAA');
  READLN(FECHAFIN);

  OBTENERSUMATORIAS( ARCHIVOEVAL, FECHAINICIO, FECHAFIN,  SUMATORIAS);

  ENCONTRARMAXSUMATORIA(SUMATORIAS, MAXSUMATORIA, MAXVALORACION);

  MOSTRARRESULTADO(FECHAINICIO, FECHAFIN, MAXSUMATORIA, MAXVALORACION);
END;

  PROCEDURE OBTENERSUMATORIAS(VAR ARCHIVOEVAL: T_ARCHIVO_EVAL; FECHAINICIO, FECHAFIN: STRING; VAR SUMATORIAS: ARRAY OF INTEGER);
VAR
  FECHAINICIODIAS, FECHAFINDIAS: INTEGER;
  I, J: INTEGER;
  X: T_DATO_EVAL;
  FECHA: STRING;
  FECHAENDIAS: INTEGER;
BEGIN
  FECHAINICIODIAS := CONVERTIR_FECHA(FECHAINICIO);
  FECHAFINDIAS := CONVERTIR_FECHA(FECHAFIN);

  FOR J := 1 TO 5 DO
    SUMATORIAS[J] := 0;

  FOR I := 0 TO FILESIZE(ARCHIVOEVAL) - 1 DO
  BEGIN
    SEEK(ARCHIVOEVAL, I);
    READ(ARCHIVOEVAL, X);

    FECHA := (INTTOSTR(X.FECHA_EVAL.DIA)) + '/' + (INTTOSTR(X.FECHA_EVAL.MES)) + '/' + (INTTOSTR(X.FECHA_EVAL.ANIO));
    FECHAENDIAS := CONVERTIR_FECHA(FECHA);

    IF (FECHAENDIAS >= FECHAINICIODIAS) AND (FECHAENDIAS <= FECHAFINDIAS) THEN
    BEGIN
      // SUMAR VALORACIONES
      FOR J := 1 TO 5 DO
        SUMATORIAS[J] := SUMATORIAS[J] + X.VALORACION[J];
    END;
  END;
END;

  PROCEDURE MUESTRADISCAPACIDADES (VAR ARCH: T_ARCHIVO_ALUMNOS);
  VAR
    RES:BYTE;
  BEGIN
      CLRSCR;
      WRITELN('1 - PROBLEMAS DEL HABLA Y LENGUAJE');
      WRITELN( '2 - DIFICULTAD PARA ESCRIBIR');
      WRITELN( '3 - DIFICULTADES DE APRENDIZAJE VISUAL');
      WRITELN( '4 - MEMORIA Y OTRAS DIFICULTADES DEL PENSAMIENTO');
      WRITELN ('5 - DESTREZAS SOCIALES INADECUADAS');
      WRITELN();
      WRITE('INGRESE LA DISCAPACIDAD A CONSULTAR SU CANTIDAD: ');
      READLN(RES);
      WRITELN('LA CANTIDAD  DE ALUMNOS QUE PRESENTAN LA DISCAPACIDAD ',OBTENERNOMBREDISCAPACIDAD(RES), ' ES DE ', CANTIDAD_ALUMNOS_DISCAPACIDAD(ARCH,RES));
      WRITELN('SOBRE UN TOTAL DE ', FILESIZE(ARCH), ' ALUMNOS');
      READKEY;
      CLRSCR;
  END;

  FUNCTION CANTIDAD_ALUMNOS_DISCAPACIDAD (VAR ARCH: T_ARCHIVO_ALUMNOS ; RES:INTEGER):INTEGER;
  VAR
    I:BYTE;
    X:T_DATO_ALUMNOS;
    CONT:WORD;
  BEGIN
    CONT := 0;
    FOR I := 0 TO FILESIZE(ARCH)-1 DO
     BEGIN
        SEEK(ARCH,I);
        READ(ARCH,X);
        IF X.DISCAPACIDAD[RES] THEN
        BEGIN
          CONT := CONT + 1;
        END;
     END;
    CANTIDAD_ALUMNOS_DISCAPACIDAD := CONT;
  END;

  END.
