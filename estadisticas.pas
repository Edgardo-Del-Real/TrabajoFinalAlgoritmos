UNIT ESTADISTICAS;

{$CODEPAGE UTF8}

INTERFACE

USES
  CRT, SYSUTILS, ARCHIVOEVAL, ARCHIVOALUM, VALIDACIONES;

PROCEDURE EVALUACIONESPORFECHA(VAR ARCHIVOEVAL:T_ARCHIVO_EVAL);
FUNCTION CONVERTIR_FECHA(X:STRING):INTEGER;
FUNCTION OBTENERNOMBREDISCAPACIDAD(VALORACION: INTEGER): STRING;
FUNCTION CANTIDAD_EVALUACIONES_POR_FECHA (VAR ARCHIVOEVAL:T_ARCHIVO_EVAL; FF,FI:INTEGER):INTEGER;
PROCEDURE COMPARARVALORACIONESPORFECHA(VAR ARCHIVOEVAL: T_ARCHIVO_EVAL);
PROCEDURE MOSTRARRESULTADO(FECHAINICIO, FECHAFIN: STRING; MAXSUMATORIA, MAXVALORACION: INTEGER);
PROCEDURE OBTENERSUMATORIAS(VAR ARCHIVOEVAL: T_ARCHIVO_EVAL; FECHAINICIO, FECHAFIN: STRING; VAR SUMATORIAS: ARRAY OF INTEGER);
PROCEDURE MUESTRADISCAPACIDADES (VAR ARCH: T_ARCHIVO_ALUMNOS);
FUNCTION CANTIDAD_ALUMNOS_DISCAPACIDAD (VAR ARCH: T_ARCHIVO_ALUMNOS ; RES:INTEGER):INTEGER;
FUNCTION ALUMNOS_ACTIVOS (VAR ARCH:T_ARCHIVO_ALUMNOS): INTEGER;


IMPLEMENTATION
FUNCTION CONVERTIR_FECHA(X:STRING):INTEGER;
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
           FECHA:=(X.FECHA_EVAL.DIA)+'/'+(X.FECHA_EVAL.MES)+'/'+(X.FECHA_EVAL.ANIO);
           FECHAENDIAS:=CONVERTIR_FECHA(FECHA);
           IF (FECHAENDIAS>=FI) AND (FF>=FECHAENDIAS) THEN
              CONT:=CONT+1;

   END;
      CANTIDAD_EVALUACIONES_POR_FECHA:=CONT;
   END;

PROCEDURE EVALUACIONESPORFECHA(VAR ARCHIVOEVAL:T_ARCHIVO_EVAL);
VAR
   CONT:INTEGER;
   FECHA_INICIO,FECHA_FIN,DIA,MES,ANIO:STRING;
   FI,FF:INTEGER;
   BEGIN
      repeat
   CLRSCR;
   TEXTCOLOR(GREEN);
   gotoxy(45,12);
   writeln('INGRESE FECHA INICIO');
    GOTOXY(45,14);
    WRITE('INGRESE EL DIA: ');
    TEXTCOLOR(WHITE);
    READLN(DIA);

    while not validarFechaDiaMes(DIA) do
            begin
            GOTOXY(55,14);
            writeln('                                                                                             ');
            GOTOXY(45,24);
            TEXTCOLOR(RED);
            writeln('DIA INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
            TEXTCOLOR(GREEN);
            GOTOXY(45,14);
            WRITE('INGRESE EL DIA: ');
            TEXTCOLOR(WHITE);
            readln(DIA);
            GOTOXY(45,24);
            writeln('                                                                                             ');
            end;

    TEXTCOLOR(GREEN);
    GOTOXY(45,16);
    WRITE('INGRESE EL MES: ');
    TEXTCOLOR(WHITE);
    READLN(MES);
    while not validarFechaDiaMes(MES) do
            begin
            GOTOXY(55,16);
            writeln('                                                                                             ');
            GOTOXY(45,24);
            TEXTCOLOR(RED);
            writeln('MES INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
            TEXTCOLOR(GREEN);
            GOTOXY(45,16);
            WRITE('INGRESE EL MES: ');
            TEXTCOLOR(WHITE);
            readln(MES);
            GOTOXY(45,24);
            writeln('                                                                                             ');
            end;

    TEXTCOLOR(GREEN);
    GOTOXY(45,18);
    WRITE('INGRESE EL AÑO: ');
    TEXTCOLOR(WHITE);
    READLN(ANIO);
   while not validarFechaAnio(ANIO) do
            begin
            GOTOXY(55,18);
            writeln('                                                                                             ');
            GOTOXY(45,24);
            TEXTCOLOR(RED);
            writeln('AÑO INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
            TEXTCOLOR(GREEN);
            GOTOXY(45,18);
            WRITE('INGRESE EL AÑO: ');
            TEXTCOLOR(WHITE);
            readln(ANIO);
            GOTOXY(45,24);
            writeln('                                                                                             ');
            end;

     FECHA_INICIO := DIA + '/' + MES + '/' + ANIO;
        if not EsFechaValida(FECHA_INICIO) then
            begin
              CLRSCR;
              TEXTCOLOR(RED);
              GOTOXY(30,15);
              writeln('FECHA INVALIDA. VUELVA A INGRESAR CORRECTAMENTE LOS DATOS');
              TEXTCOLOR(WHITE);
              GOTOXY(43,17);
              writeln('OPRIMA <<ENTER>> PARA RECARGAR');
              READKEY;
              CLRSCR;
            end;
           until EsFechaValida(FECHA_INICIO);

     FI:=CONVERTIR_FECHA(FECHA_INICIO);
     REPEAT
     clrscr;
     TEXTCOLOR(GREEN);
      GOTOXY(45,12);
      WRITE('INGRESE FECHA DE FIN: ');
      GOTOXY(45,14);
      WRITE('INGRESE EL DIA: ');
      TEXTCOLOR(WHITE);
      READLN(DIA);
      while not validarFechaDiaMes(DIA) do
                  begin
                  GOTOXY(55,14);
                  writeln('                                                                                             ');
                  GOTOXY(45,24);
                  TEXTCOLOR(RED);
                  writeln('DIA INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
                  TEXTCOLOR(GREEN);
                  GOTOXY(45,14);
                  WRITE('INGRESE EL DIA: ');
                  TEXTCOLOR(WHITE);
                  readln(DIA);
                  GOTOXY(45,24);
                  writeln('                                                                                             ');
                  end;
      TEXTCOLOR(GREEN);
      GOTOXY(45,16);
      WRITE('INGRESE EL MES: ');
      TEXTCOLOR(WHITE);
      READLN(MES);
           while not validarFechaDiaMes(MES) do
                  begin
                  GOTOXY(55,16);
                  writeln('                                                                                             ');
                  GOTOXY(45,24);
                  TEXTCOLOR(RED);
                  writeln('MES INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
                  TEXTCOLOR(GREEN);
                  GOTOXY(45,16);
                  WRITE('INGRESE EL MES: ');
                  TEXTCOLOR(WHITE);
                  readln(MES);
                  GOTOXY(45,24);
                  writeln('                                                                                             ');
                  end;
      TEXTCOLOR(GREEN);
      GOTOXY(45,18);
      WRITE('INGRESE EL AÑO: ');
      TEXTCOLOR(WHITE);
      READLN(ANIO);
      while not validarFechaAnio(ANIO) do
            begin
            GOTOXY(55,18);
            writeln('                                                                                             ');
            GOTOXY(45,24);
            TEXTCOLOR(RED);
            writeln('AÑO INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
            TEXTCOLOR(GREEN);
            GOTOXY(45,18);
            WRITE('INGRESE EL AÑO: ');
            TEXTCOLOR(WHITE);
            readln(ANIO);
            GOTOXY(45,24);
            writeln('                                                                                             ');
            end;

     FECHA_FIN := DIA + '/' + MES + '/' + ANIO;
      if not EsFechaValida(FECHA_FIN) then
     begin
       CLRSCR;
       TEXTCOLOR(RED);
       GOTOXY(30,15);
       writeln('FECHA INVALIDA. VUELVA A INGRESAR CORRECTAMENTE LOS DATOS');
       TEXTCOLOR(WHITE);
       GOTOXY(43,17);
       writeln('OPRIMA <<ENTER>> PARA RECARGAR');
       READKEY;
       CLRSCR;
     end;
    until EsFechaValida(FECHA_FIN);


     FF:= CONVERTIR_FECHA(FECHA_FIN);
     CONT:= CANTIDAD_EVALUACIONES_POR_FECHA(ARCHIVOEVAL,FF,FI);
     CLRSCR;
     TEXTCOLOR(LIGHTBLUE);
     gotoxy(52,14);
     WRITE('** RESULTADO **');
     TEXTCOLOR(WHITE);
     gotoxy(18,16);
     WRITE('LA CANTIDAD DE EVALUACIONES REALIZADADAS ENTRE EL ', FECHA_INICIO, ' Y ', FECHA_FIN,' FUERON DE: ');
     TEXTCOLOR(GREEN);
     WRITELN(CONT);
     readkey;
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
   begin
    CLRSCR;
    TEXTCOLOR(GREEN);
    GOTOXY(55,12);
    WRITELN('** RESULTADO **');
    GOTOXY(32,14);
    TEXTCOLOR(WHITE);
    WRITELN('LA VALORACIÓN CON LA MAYOR SUMATORIA ENTRE ', FECHAINICIO, ' Y ', FECHAFIN);
    GOTOXY(28,15);
    WRITELN('ES LA DE LA DIFICULTAD ', OBTENERNOMBREDISCAPACIDAD(MAXVALORACION), ' CON UNA SUMATORIA DE ', MAXSUMATORIA );
    READKEY;
   end
ELSE
    BEGIN
    CLRSCR;
    TEXTCOLOR(RED);
    GOTOXY(18,14);
    WRITELN('NO ES POSIBLE DETERMINAR LA MAYOR VALUACION PARA UNA DIFICULTAD ENTRE LAS FECHAS INGRESADAS');
    TEXTCOLOR(WHITE);
    GOTOXY(36,17);
    WRITELN('PRESIONE <<ENTER>> PARA TERMINAR DE VISUALIZAR');
    readkey;
    end;
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
FECHAINICIO, FECHAFIN, FECHA,MAXDISCAPACIDAD, DIA, MES, ANIO: STRING ;
BEGIN
MAXSUMATORIA := 0;
MAXVALORACION := 0;
    clrscr;
    repeat
    TEXTCOLOR(GREEN);
    GOTOXY(38,12);
    WRITELN('INGRESE FECHA DE INICIO POR CAMPO');
    TEXTCOLOR(GREEN);
    GOTOXY(45,14);
    WRITE('INGRESE EL DIA: ');
    TEXTCOLOR(WHITE);
    READLN(DIA);
       while not validarFechaDiaMes(DIA) do
            begin
            GOTOXY(55,14);
            writeln('                                                                                             ');
            GOTOXY(45,24);
            TEXTCOLOR(RED);
            writeln('DIA INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
            TEXTCOLOR(GREEN);
            GOTOXY(45,14);
            WRITE('INGRESE EL DIA: ');
            TEXTCOLOR(WHITE);
            readln(DIA);
            GOTOXY(45,24);
            writeln('                                                                                             ');
            end;

    TEXTCOLOR(GREEN);
    GOTOXY(45,16);
    WRITE('INGRESE EL MES: ');
    TEXTCOLOR(WHITE);
    READLN(MES);
        while not validarFechaDiaMes(MES) do
            begin
            GOTOXY(55,16);
            writeln('                                                                                             ');
            GOTOXY(45,24);
            TEXTCOLOR(RED);
            writeln('MES INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
            TEXTCOLOR(GREEN);
            GOTOXY(45,16);
            WRITE('INGRESE EL MES: ');
            TEXTCOLOR(WHITE);
            readln(MES);
            GOTOXY(45,24);
            writeln('                                                                                             ');
            end;

    TEXTCOLOR(GREEN);
    GOTOXY(45,18);
    WRITE('INGRESE EL AÑO: ');
    TEXTCOLOR(WHITE);
    READLN(ANIO);
     while not validarFechaANIO(ANIO) do
            begin
            GOTOXY(55,18);
            writeln('                                                                                             ');
            GOTOXY(45,24);
            TEXTCOLOR(RED);
            writeln('AÑO INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
            TEXTCOLOR(GREEN);
            GOTOXY(45,18);
            WRITE('INGRESE EL AÑO: ');
            TEXTCOLOR(WHITE);
            readln(ANIO);
            GOTOXY(45,24);
            writeln('                                                                                             ');
            end;

     FECHAINICIO := DIA + '/' + MES + '/' + ANIO;
     clrscr;

     if not EsFechaValida(FECHAINICIO) then
     begin
       CLRSCR;
       TEXTCOLOR(RED);
       GOTOXY(30,15);
       writeln('FECHA INVALIDA. VUELVA A INGRESAR CORRECTAMENTE LOS DATOS');
       TEXTCOLOR(YELLOW);
       GOTOXY(43,17);
       writeln('OPRIMA <<ENTER>> PARA RECARGAR');
       READKEY;
       CLRSCR;
     end;
    until EsFechaValida(FECHAINICIO);

    repeat
    TEXTCOLOR(GREEN);
    GOTOXY(38,12);
    WRITELN('INGRESE FECHA DE FIN POR CAMPO');
    GOTOXY(45,14);
    WRITE('INGRESE EL DIA: ');
    TEXTCOLOR(WHITE);
    READLN(DIA);
     while not validarFechaDiaMes(DIA) do
            begin
            GOTOXY(55,14);
            writeln('                                                                                             ');
            GOTOXY(45,24);
            TEXTCOLOR(RED);
            writeln('DIA INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
            TEXTCOLOR(GREEN);
            GOTOXY(45,14);
            WRITE('INGRESE EL DIA: ');
            TEXTCOLOR(WHITE);
            readln(DIA);
            GOTOXY(45,24);
            writeln('                                                                                             ');
            end;

    TEXTCOLOR(GREEN);
    GOTOXY(45,16);
    WRITE('INGRESE EL MES: ');
    TEXTCOLOR(WHITE);
    READLN(MES);
           while not validarFechaDiaMes(MES) do
            begin
            GOTOXY(55,16);
            writeln('                                                                                             ');
            GOTOXY(45,24);
            TEXTCOLOR(RED);
            writeln('MES INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
            TEXTCOLOR(GREEN);
            GOTOXY(45,16);
            WRITE('INGRESE EL MES: ');
            TEXTCOLOR(WHITE);
            readln(MES);
            GOTOXY(45,24);
            writeln('                                                                                             ');
            end;


    TEXTCOLOR(GREEN);
    GOTOXY(45,18);
    WRITE('INGRESE EL AÑO: ');
    TEXTCOLOR(WHITE);
    READLN(ANIO);
         while not validarFechaANIO(ANIO) do
            begin
            GOTOXY(55,18);
            writeln('                                                                                             ');
            GOTOXY(45,24);
            TEXTCOLOR(RED);
            writeln('AÑO INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
            TEXTCOLOR(GREEN);
            GOTOXY(45,18);
            WRITE('INGRESE EL AÑO: ');
            TEXTCOLOR(WHITE);
            readln(ANIO);
            GOTOXY(45,24);
            writeln('                                                                                             ');
            end;

     FECHAFIN := DIA + '/' + MES + '/' + ANIO;

        if not EsFechaValida(FECHAFIN) then
     begin
       CLRSCR;
       TEXTCOLOR(RED);
       GOTOXY(30,15);
       writeln('FECHA INVALIDA. VUELVA A INGRESAR CORRECTAMENTE LOS DATOS');
       TEXTCOLOR(YELLOW);
       GOTOXY(43,17);
       writeln('OPRIMA <<ENTER>> PARA RECARGAR');
       READKEY;
       CLRSCR;
     end;
    until EsFechaValida(FECHAFIN);

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

  FECHA := (X.FECHA_EVAL.DIA) + '/' + (X.FECHA_EVAL.MES) + '/' + (X.FECHA_EVAL.ANIO);
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
  RES:STRING;
  SALIR:BOOLEAN;
BEGIN
  SALIR := FALSE;
  REPEAT
    CLRSCR;
    TEXTCOLOR(GREEN);
    GOTOXY(53,10);
    WRITELN('DISCAPACIDADES ');
    TEXTCOLOR(WHITE);
    GOTOXY(50,10);
    WRITELN('**');
    GOTOXY(68,10);
    WRITELN('**');
    TEXTCOLOR(WHITE);

    TEXTCOLOR(GREEN);
    GOTOXY(45,12);
    WRITE('0- ');
    TEXTCOLOR(WHITE);
    WRITELN('VOLVER AL MENU ESTADISTICAS');

    TEXTCOLOR(GREEN);
    GOTOXY(45,14);
    WRITE('1- ');
    TEXTCOLOR(WHITE);
    WRITELN('PROBLEMAS DEL HABLA Y LENGUAJE');

    TEXTCOLOR(GREEN);
    GOTOXY(45,16);
    WRITE('2- ');
    TEXTCOLOR(WHITE);
    WRITELN('DIFICULTAD PARA ESCRIBIR');

      TEXTCOLOR(GREEN);
    GOTOXY(45,18);
    WRITE('3- ');
    TEXTCOLOR(WHITE);
    WRITELN('DIFICULTADES DE APRENDIZAJE VISUAL');

      TEXTCOLOR(GREEN);
    GOTOXY(45,20);
    WRITE('4- ');
    TEXTCOLOR(WHITE);
    WRITELN('MEMORIA Y OTRAS DIFICULTADES DEL PENSAMIENTO');

      TEXTCOLOR(GREEN);
    GOTOXY(45,22);
    WRITE('5- ');
    TEXTCOLOR(WHITE);
    WRITELN('DESTREZAS SOCIALES INADECUADAS');

    TEXTCOLOR(GREEN);
    GOTOXY(40,24);
    WRITE('INGRESE LA DISCAPACIDAD A CONSULTAR SU CANTIDAD: ');
    TEXTCOLOR(WHITE);
    READLN(RES);

    WHILE NOT ESNUMERO(RES) OR (RES < '0') OR (RES > '5') DO
       BEGIN
         CLRSCR;
         GOTOXY(45,22);
         WRITELN('RESPUESTA INCORRECTA. VERIFIQUE');
         TEXTCOLOR(GREEN);
         GOTOXY(40,24);
         WRITE('INGRESE LA DISCAPACIDAD A CONSULTAR SU CANTIDAD: ');
         TEXTCOLOR(WHITE);
         READLN(RES);
       end;

    IF RES = '0' THEN
      SALIR := TRUE
    ELSE
    BEGIN
      CLRSCR;
      TEXTCOLOR(LIGHTBLUE);
      GOTOXY(55,14);
      WRITELN('** RESULTADO **');
      TEXTCOLOR(WHITE);
      GOTOXY(30,16);
      WRITELN('LA CANTIDAD DE ALUMNOS QUE PRESENTAN ',OBTENERNOMBREDISCAPACIDAD(strtoint(RES)));
      GOTOXY(43,17);
      WRITELN(' ES DE ', CANTIDAD_ALUMNOS_DISCAPACIDAD(ARCH,(strtoint(RES))), ' SOBRE UN TOTAL DE ', ALUMNOS_ACTIVOS(ARCH), ' ALUMNOS');
      READKEY;
    END;
  UNTIL SALIR;
  CLRSCR;
END;

FUNCTION ALUMNOS_ACTIVOS (VAR ARCH:T_ARCHIVO_ALUMNOS): INTEGER;
VAR
  I,CONT:BYTE;
  X:T_DATO_ALUMNOS;
BEGIN
  CONT := 0;
   FOR I := 0 TO FILESIZE(ARCH)-1 DO
   BEGIN
      SEEK(ARCH,I);
      READ(ARCH,X);
      IF X.ESTADO THEN
      BEGIN
        CONT := CONT + 1;
      END;
   END;
  ALUMNOS_ACTIVOS := CONT;
END;

FUNCTION CANTIDAD_ALUMNOS_DISCAPACIDAD (VAR ARCH: T_ARCHIVO_ALUMNOS ; RES:INTEGER):INTEGER;
VAR
  I:BYTE;
  X:T_DATO_ALUMNOS;
  ACT:WORD;
BEGIN
  ACT := 0;
  FOR I := 0 TO FILESIZE(ARCH)-1 DO
   BEGIN
      SEEK(ARCH,I);
      READ(ARCH,X);
      IF X.DISCAPACIDAD[RES] AND X.ESTADO THEN
      BEGIN
        ACT := ACT + 1;
      END;
   END;
  CANTIDAD_ALUMNOS_DISCAPACIDAD := ACT;
END;


END.