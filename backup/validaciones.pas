unit VALIDACIONES;

{$CODEPAGE UTF8}

interface

uses
CRT, SYSUTILS, unitarbol, archivoEVal;
function fechaExistente (var archivoeval:T_ARCHIVO_EVAL; fecha:string;legajo:string):boolean;
function EsFechaValida(FechaStr: string): Boolean;
function validarFechaDiaMes(diaMes: string): boolean;
function validarFechaAnio(anio: string): boolean;
function EsCadena(input: string): boolean;
function EsNumero(input: string): boolean;
 PROCEDURE INGRESAR_CLAVE (VAR RAIZLEGAJO,RAIZAPYNOM:T_PUNT_ARBOL; VAR POS:INTEGER; VAR CLAVE:STRING);
 PROCEDURE VALIDACION_CLAVE(VAR RESPUESTA: STRING; VAR POS: INTEGER;RAIZLEGAJO, RAIZAPYNOM: T_PUNT_ARBOL; VAR CLAVE:STRING);
 PROCEDURE PantallaCarga;
 PROCEDURE PantallaCarga2;
 procedure MostrarPantallaInicio;


implementation
 function validarFechaDiaMes(diaMes: string): boolean;
 begin
     if esNumero(diaMes) and (Length(diaMes) = 2) then
         validarFechaDiaMes := True
     else
         validarFechaDiaMes := False;
 end;

 function validarFechaAnio(anio: string): boolean;
 begin
     if esNumero(anio) and (Length(anio) = 4) then
         validarFechaAnio := True
     else
         validarFechaAnio := False;
 end;

function fechaExistente (var archivoeval:T_ARCHIVO_EVAL; fecha:string; legajo:string):boolean;
var
x:t_dato_Eval;
fechaAux:string;
i:byte;
begin
    fechaAux:='';
    fechaExistente:=false;
   while not eof(archivoeval) do
    begin
        read(archivoEval,x);
        if x.NUM_LEGAJO = legajo then
            begin
               FECHAAux:=(X.FECHA_EVAL.DIA) + ' / ' + (X.FECHA_EVAL.MES) + ' / ' + (X.FECHA_EVAL.ANIO);
            end;
        if fechaAux = fecha then
            fechaExistente:=true;
    end;
end;



PROCEDURE INGRESAR_CLAVE (VAR RAIZLEGAJO,RAIZAPYNOM:T_PUNT_ARBOL; VAR POS:INTEGER; VAR CLAVE:STRING);
BEGIN
REPEAT
 TEXTCOLOR(LIGHTBLUE);
 GOTOXY(40,15);
 WRITE ('INGRESAR CLAVE DEL ALUMNO: ');
 textcolor(white);
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
      IF not esNumero(CLAVE) then
      begin
      TEXTCOLOR(WHITE);
      WRITE('LA CLAVE ES INVALIDA');
      end
      else
      begin
      WRITE('CLAVE INEXISTENTE. PARA CARGAR PRESIONE S ');
      TEXTCOLOR(LIGHTBLUE);
      WRITE('PARA VOLVER AL MENU PRESIONE <<ENTER>>');
      TEXTCOLOR(WHITE);
      WRITE('REPUESTA: ');
      TEXTCOLOR(LIGHTBLUE);
      READLN(RESPUESTA);
      RESPUESTA := UPPERCASE(RESPUESTA);
      end;
    END
    ELSE
      RESPUESTA := 'C';  // SALIMOS DEL BUCLE SI LA CLAVE ES VÁLIDA
  END;

  IF (INTENTO >= 3) AND (RESPUESTA = 'R') THEN
    WRITELN('SE HAN AGOTADO LOS INTENTOS PERMITIDOS. POR FAVOR, CONTACTE AL ADMINISTRADOR DEL SISTEMA.');
END;

function EsFechaValida(FechaStr: string): Boolean;
var
  Fecha: TDateTime;
  FechaActual: TDateTime;
begin
  FechaActual := Date;
  if TryStrToDate(FechaStr, Fecha) then
  begin
    if Fecha > FechaActual then
      Result := False
    else
      Result := True;
  end
  else
    Result := False;
end;

function EsCadena(input: string): boolean;
var
  i: integer;
  stop: boolean;
begin
  EsCadena := true;
  stop := false;
  i := 1;
  while( i <= Length(input)) and (not stop) do
  begin
    if not (UPCASE(input[i]) in ['A'..'Z', ' ']) then
    begin
      EsCadena := false;
      stop := true;
    end;
    inc(i);
  end;
end;

 function EsNumero(input: string): boolean;
 var
   i: integer;
 begin
   // Verificar si todos los caracteres son dígitos
   for i := 1 to Length(input) do
   begin
     if not (input[i] in ['0'..'9']) then
     begin
       EsNumero := false;
       Exit;
     end;
   end;
   EsNumero := true;
 end;


 PROCEDURE PantallaCarga;
VAR
  i, centroX, centroY, anchoConsola, altoConsola: INTEGER;
BEGIN
  CLRSCR;
  anchoConsola := 120;
  altoConsola := 35;
  centroX := (anchoConsola DIV 2) - 20;
  centroY := (altoConsola DIV 2) - 3;

  TEXTCOLOR(WHITE);
  GOTOXY(centroX, centroY);
  WRITE('CERRANDO EL PROGRAMA, POR FAVOR ESPERE ...');
  TEXTCOLOR(GREEN);

  GOTOXY(centroX, centroY + 2);
  WRITE('[');
  GOTOXY(centroX + 40, centroY + 2);
  WRITE(']');

  FOR i := centroX + 1 TO centroX + 39 DO
  BEGIN
    GOTOXY(i, centroY + 2);
    WRITE('-');
    DELAY(50);
  END;

  GOTOXY(centroX + 10, centroY + 4);
  TEXTCOLOR(WHITE);
  WRITELN('  CARGA COMPLETA!  ');
  DELAY(500);
END;

PROCEDURE PantallaCarga2;
VAR
  i, centroX, centroY, anchoConsola, altoConsola: INTEGER;
BEGIN
  CLRSCR;
  anchoConsola := 120;
  altoConsola := 35;
  centroX := (anchoConsola DIV 2) - 20;
  centroY := (altoConsola DIV 2) - 3;

  TEXTCOLOR(WHITE);
  GOTOXY(centroX, centroY);
  WRITE('CONFIRMANDO DATOS, POR FAVOR ESPERE ...');
  TEXTCOLOR(GREEN);

  GOTOXY(centroX, centroY + 2);
  WRITE('[');
  GOTOXY(centroX + 40, centroY + 2);
  WRITE(']');

  FOR i := centroX + 1 TO centroX + 39 DO
  BEGIN
    GOTOXY(i, centroY + 2);
    WRITE('-');
    DELAY(100);
  END;

  GOTOXY(centroX + 10, centroY + 4);
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


end.
