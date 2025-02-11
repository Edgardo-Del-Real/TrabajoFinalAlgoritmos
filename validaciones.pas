UNIT VALIDACIONES;

{$CODEPAGE UTF8}

INTERFACE

USES
CRT, SYSUTILS, UNITARBOL, ARCHIVOEVAL;

FUNCTION FECHAEXISTENTE (VAR ARCHIVOEVAL:T_ARCHIVO_EVAL; FECHA:STRING;LEGAJO:STRING):BOOLEAN;
FUNCTION ESFECHAVALIDA(FECHASTR: STRING): BOOLEAN;
FUNCTION VALIDARFECHADIAMES(DIAMES: STRING): BOOLEAN;
FUNCTION VALIDARFECHAANIO(ANIO: STRING): BOOLEAN;
FUNCTION ESCADENA(INPUT: STRING): BOOLEAN;
FUNCTION ESNUMERO(INPUT: STRING): BOOLEAN;
 PROCEDURE INGRESAR_CLAVE (VAR RAIZLEGAJO,RAIZAPYNOM:T_PUNT_ARBOL; VAR POS:INTEGER; VAR CLAVE:STRING);
 PROCEDURE VALIDACION_CLAVE(VAR RESPUESTA: STRING; VAR POS: INTEGER;RAIZLEGAJO, RAIZAPYNOM: T_PUNT_ARBOL; VAR CLAVE:STRING);
 PROCEDURE PANTALLACARGA;
 PROCEDURE PANTALLACARGA2;
 PROCEDURE MOSTRARPANTALLAINICIO;


IMPLEMENTATION
 FUNCTION VALIDARFECHADIAMES(DIAMES: STRING): BOOLEAN;
 BEGIN
     IF ESNUMERO(DIAMES) AND (LENGTH(DIAMES) = 2) THEN
         VALIDARFECHADIAMES := TRUE
     ELSE
         VALIDARFECHADIAMES := FALSE;
 END;

 FUNCTION VALIDARFECHAANIO(ANIO: STRING): BOOLEAN;
 BEGIN
     IF ESNUMERO(ANIO) AND (LENGTH(ANIO) = 4) THEN
         VALIDARFECHAANIO := TRUE
     ELSE
         VALIDARFECHAANIO := FALSE;
 END;

FUNCTION FECHAEXISTENTE (VAR ARCHIVOEVAL:T_ARCHIVO_EVAL; FECHA:STRING; LEGAJO:STRING):BOOLEAN;
VAR
X:T_DATO_EVAL;
FECHAAUX:STRING;
I:BYTE;
BEGIN
    FECHAAUX:='';
    FECHAEXISTENTE:=FALSE;
   WHILE NOT EOF(ARCHIVOEVAL) DO
    BEGIN
        READ(ARCHIVOEVAL,X);
        IF X.NUM_LEGAJO = LEGAJO THEN
            BEGIN
               FECHAAUX:=(X.FECHA_EVAL.DIA) + ' / ' + (X.FECHA_EVAL.MES) + ' / ' + (X.FECHA_EVAL.ANIO);
            END;
        IF FECHAAUX = FECHA THEN
            FECHAEXISTENTE:=TRUE;
    END;
END;



PROCEDURE INGRESAR_CLAVE (VAR RAIZLEGAJO,RAIZAPYNOM:T_PUNT_ARBOL; VAR POS:INTEGER; VAR CLAVE:STRING);
BEGIN
REPEAT
 TEXTCOLOR(LIGHTBLUE);
 GOTOXY(40,15);
 WRITE ('INGRESAR CLAVE DEL ALUMNO: ');
 TEXTCOLOR(WHITE);
  READLN (CLAVE);
 UNTIL CLAVE <> '';
  POS := PREORDEN(RAIZLEGAJO, CLAVE);
   IF POS = -1 THEN
     POS := PREORDEN(RAIZAPYNOM, CLAVE);
 END;

 PROCEDURE VALIDACION_CLAVE(VAR RESPUESTA: STRING; VAR POS: INTEGER;RAIZLEGAJO, RAIZAPYNOM: T_PUNT_ARBOL; VAR CLAVE:STRING);
VAR
  INTENTO: INTEGER;
BEGIN
  INTENTO := 0;
  RESPUESTA := 'R';
  WHILE (RESPUESTA = 'R') AND (INTENTO < 3) DO
  BEGIN
    INC(INTENTO);
    INGRESAR_CLAVE(RAIZLEGAJO, RAIZAPYNOM, POS, CLAVE);
    IF POS = -1 THEN
    BEGIN

      GOTOXY(40,17);
      TEXTCOLOR(LIGHTRED);
      WRITE('ERROR: ');
      IF NOT ESNUMERO(CLAVE) THEN
      BEGIN
      TEXTCOLOR(WHITE);
      WRITE('LA CLAVE ES INVALIDA');
      END
      ELSE
      BEGIN
      WRITE('CLAVE INEXISTENTE. PARA CARGAR PRESIONE S ');
      GOTOXY(40,19);
      TEXTCOLOR(LIGHTBLUE);
      WRITE('PARA VOLVER AL MENU PRESIONE <<ENTER>>');
      GOTOXY(40,21);
      TEXTCOLOR(WHITE);
      WRITE('RESPUESTA: ');
      TEXTCOLOR(LIGHTBLUE);
      READLN(RESPUESTA);
      RESPUESTA := UPPERCASE(RESPUESTA);
      END;
    END
    ELSE
      RESPUESTA := 'C';  // SALIMOS DEL BUCLE SI LA CLAVE ES VÁLIDA
  END;

  IF (INTENTO >= 3) AND (RESPUESTA = 'R') THEN
    WRITELN('SE HAN AGOTADO LOS INTENTOS PERMITIDOS. POR FAVOR, CONTACTE AL ADMINISTRADOR DEL SISTEMA.');
END;

FUNCTION ESFECHAVALIDA(FECHASTR: STRING): BOOLEAN;
VAR
  FECHA: TDATETIME;
  FECHAACTUAL: TDATETIME;
BEGIN
  FECHAACTUAL := DATE;
  IF TRYSTRTODATE(FECHASTR, FECHA) THEN
  BEGIN
    IF FECHA > FECHAACTUAL THEN
      RESULT := FALSE
    ELSE
      RESULT := TRUE;
  END
  ELSE
    RESULT := FALSE;
END;

FUNCTION ESCADENA(INPUT: STRING): BOOLEAN;
VAR
  I: INTEGER;
  STOP: BOOLEAN;
BEGIN
  ESCADENA := (LENGTH(INPUT) > 0);
  STOP := NOT ESCADENA;
  I := 1;

  WHILE (I <= LENGTH(INPUT)) AND (NOT STOP) DO
  BEGIN
    IF NOT (UPCASE(INPUT[I]) IN ['A'..'Z', ' ']) THEN
    BEGIN
      ESCADENA := FALSE;
      STOP := TRUE;
    END;
    INC(I);
  END;
END;

FUNCTION ESNUMERO(INPUT: STRING): BOOLEAN;
VAR
  I: INTEGER;
  ESVALIDO: BOOLEAN;
BEGIN
  ESVALIDO := (LENGTH(INPUT) > 0);
  I := 1;

  WHILE (I <= LENGTH(INPUT)) AND ESVALIDO DO
  BEGIN
    IF NOT (INPUT[I] IN ['0'..'9']) THEN
      ESVALIDO := FALSE;
    INC(I);
  END;

  ESNUMERO := ESVALIDO;
END;


 PROCEDURE PANTALLACARGA;
VAR
  I, CENTROX, CENTROY, ANCHOCONSOLA, ALTOCONSOLA: INTEGER;
BEGIN
  CLRSCR;
  ANCHOCONSOLA := 120;
  ALTOCONSOLA := 35;
  CENTROX := (ANCHOCONSOLA DIV 2) - 20;
  CENTROY := (ALTOCONSOLA DIV 2) - 3;

  TEXTCOLOR(WHITE);
  GOTOXY(CENTROX, CENTROY);
  WRITE('CERRANDO EL PROGRAMA, POR FAVOR ESPERE ...');
  TEXTCOLOR(GREEN);

  GOTOXY(CENTROX, CENTROY + 2);
  WRITE('[');
  GOTOXY(CENTROX + 40, CENTROY + 2);
  WRITE(']');

  FOR I := CENTROX + 1 TO CENTROX + 39 DO
  BEGIN
    GOTOXY(I, CENTROY + 2);
    WRITE('-');
    DELAY(50);
  END;

  GOTOXY(CENTROX + 10, CENTROY + 4);
  TEXTCOLOR(WHITE);
  WRITELN('  CARGA COMPLETA!  ');
  DELAY(500);
END;

PROCEDURE PANTALLACARGA2;
VAR
  I, CENTROX, CENTROY, ANCHOCONSOLA, ALTOCONSOLA: INTEGER;
BEGIN
  CLRSCR;
  ANCHOCONSOLA := 120;
  ALTOCONSOLA := 35;
  CENTROX := (ANCHOCONSOLA DIV 2) - 20;
  CENTROY := (ALTOCONSOLA DIV 2) - 3;

  TEXTCOLOR(WHITE);
  GOTOXY(CENTROX, CENTROY);
  WRITE('CONFIRMANDO DATOS, POR FAVOR ESPERE ...');
  TEXTCOLOR(GREEN);

  GOTOXY(CENTROX, CENTROY + 2);
  WRITE('[');
  GOTOXY(CENTROX + 40, CENTROY + 2);
  WRITE(']');

  FOR I := CENTROX + 1 TO CENTROX + 39 DO
  BEGIN
    GOTOXY(I, CENTROY + 2);
    WRITE('-');
    DELAY(100);
  END;

  GOTOXY(CENTROX + 10, CENTROY + 4);
  TEXTCOLOR(WHITE);
  WRITELN('  CARGA EXITOSA !  ');
  DELAY(500);
END;


PROCEDURE MOSTRARPANTALLAINICIO;
CONST
    MENSAJES: ARRAY[1..5] OF STRING = (
        'ANALIZANDO BASES DE DATOS...',
        'CARGANDO MODULOS PRINCIPALES...',
        'OPTIMIZANDO RENDIMIENTO...',
        'VERIFICANDO INTEGRIDAD DE DATOS...',
        'INICIALIZANDO INTERFAZ...'
    );
VAR
    I, J: INTEGER;
    MENSAJEINDEX: INTEGER;
BEGIN
    CLRSCR;
    GOTOXY(45, 9);
    TEXTCOLOR(GREEN);
    WRITELN('---                    ---');
    TEXTCOLOR(WHITE);
    GOTOXY(49, 9);
    WRITELN('INICIANDO PROGRAMA');
    GOTOXY(49, 14);
    WRITELN('POR FAVOR ESPERE...');

    FOR I := 1 TO 20 DO
    BEGIN
        MENSAJEINDEX := RANDOM(5) + 1;
        GOTOXY(45, 18);
        WRITE(MENSAJES[MENSAJEINDEX], '            ');

        GOTOXY(45, 16);
        WRITE('[');
        FOR J := 1 TO I DO
            WRITE('=');
        FOR J := I + 1 TO 20 DO
            WRITE(' ');
        WRITE('] ', I * 5, '%');

        DELAY(400);
    END;

    GOTOXY(35, 23);
    TEXTCOLOR(GREEN);
    WRITELN('CARGA COMPLETA. PRESIONE UNA TECLA PARA CONTINUAR...');
    READKEY;
END;


END.