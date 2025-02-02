UNIT MANEJOEVAL;

{$CODEPAGE UTF8}

INTERFACE

USES
    CRT, ARCHIVOEVAL, UNITARBOL, SYSUTILS, VALIDACIONES, ARCHIVOALUM, ESTADISTICAS ;

PROCEDURE CARGARDATOSEVAL (VAR X:T_DATO_EVAL; VAR archivoAlumno:T_ARCHIVO_ALUMNOS; var archivoEval:T_ARCHIVO_eval; POS:INTEGER);
PROCEDURE PASAR_DATOS_EVAL (VAR ARCH: T_ARCHIVO_EVAL; VAR RAIZLEGAJO,RAIZFECHA:T_PUNT_ARBOL);
PROCEDURE DARALTAEVAL (VAR ARCHIVOEVAL:T_ARCHIVO_EVAL; VAR X:T_DATO_EVAL; VAR ARCHIVOALUMNO:T_ARCHIVO_ALUMNOS; POS:INTEGER);
PROCEDURE CARGARALTAEVAL (VAR ARCHIVOEVAL:T_ARCHIVO_EVAL; VAR X:T_DATO_EVAL);
PROCEDURE MUESTRADATOSEVAL(X:T_DATO_EVAL);
PROCEDURE CONSULTAEVALUACION(VAR RAIZLEGAJO: T_PUNT_ARBOL; VAR ARCHIVOEVAL: T_ARCHIVO_EVAL; VAR ARCHIVOALUMNO:T_ARCHIVO_ALUMNOS; POSALUMNO: INTEGER);
PROCEDURE MODIFICAREVAL(VAR RAIZAPYNOM, RAIZLEGAJO: T_PUNT_ARBOL; VAR ARCHIVOEVAL: T_ARCHIVO_EVAL; VAR ARCHIVOALUMNO:T_ARCHIVO_ALUMNOS; POSALUMNO:INTEGER);
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
    IF ((STRTOINT(X.FECHA_EVAL.ANIO)) > 0) AND ((STRTOINT(X.FECHA_EVAL.MES)) IN [1..12]) AND (STRTOINT(X.FECHA_EVAL.DIA) IN [1..31]) THEN
    BEGIN
      FECHA := (X.FECHA_EVAL.ANIO) + (X.FECHA_EVAL.MES) + (X.FECHA_EVAL.DIA);
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


PROCEDURE CARGARDATOSEVAL (VAR X:T_DATO_EVAL; VAR archivoAlumno:T_ARCHIVO_ALUMNOS; var archivoEval:T_ARCHIVO_eval; POS:INTEGER);
VAR
   I:BYTE;
   FECHA:STRING;
   VALORACION:INTEGER;
   Y:T_DATO_ALUMNOS;
   legajo:string;
BEGIN
     CLRSCR;
     GOTOXY(50,10);
     WRITELN('**DAR ALTA EVALUACIÓN**');
     TEXTCOLOR(GREEN);
     GOTOXY(45,12);
      SEEK(archivoAlumno, POS);
      READ(archivoAlumno, Y);
     X.NUM_LEGAJO :=  Y.NUM_LEGAJO;
     REPEAT
     TEXTCOLOR(GREEN);
     GOTOXY(45,14);
     WRITE('INGRESE DIA DE EVALUACIÓN: ');
     TEXTCOLOR(WHITE);
     READLN(X.FECHA_EVAL.DIA);
     while not validarFechaDiaMes(x.fecha_eval.dia) do
          begin
         GOTOXY(45,10);
          TEXTCOLOR(RED);
          writeln('DIA INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
          TEXTCOLOR(GREEN);
          GOTOXY(45,14);
          WRITE('INGRESE DIA DE EVALUACIÓN: ');
          TEXTCOLOR(WHITE);
          readln(X.FECHA_EVAL.DIA);
          GOTOXY(45,24);
          writeln('                                                                                             ');
          end;
     TEXTCOLOR(GREEN);
     GOTOXY(45,16);
     WRITE('INGRESE MES DE EVALUACIÓN: ');
     TEXTCOLOR(WHITE);
     READLN(X.FECHA_EVAL.MES);
      while not validarFechaDiaMes(x.fecha_eval.mes) do
          begin
         GOTOXY(45,10);
          TEXTCOLOR(RED);
          writeln('MES INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
          TEXTCOLOR(GREEN);
          GOTOXY(45,16);
          WRITE('INGRESE MES DE EVALUACIÓN: ');
          TEXTCOLOR(WHITE);
          readln(X.FECHA_EVAL.MES);
          GOTOXY(45,10);
          writeln('                                                                                             ');
          end;
     TEXTCOLOR(GREEN);
     GOTOXY(45,18);
     WRITE('INGRESE AÑO DE EVALUACIÓN: ');
     TEXTCOLOR(WHITE);
     READLN(X.FECHA_EVAL.ANIO);
     while not (validarFechaAnio(x.fecha_eval.anio)) do
          begin
         GOTOXY(45,10);
          TEXTCOLOR(RED);
          writeln('AÑO INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
          TEXTCOLOR(GREEN);
          GOTOXY(45,18);
          WRITE('INGRESE AÑO DE EVALUACIÓN: ');
          TEXTCOLOR(WHITE);
          readln(X.FECHA_EVAL.ANIO);
          GOTOXY(45,10);
          writeln('                                                                                             ');
          end;
     FECHA:=(X.FECHA_EVAL.DIA) + ' / ' + (X.FECHA_EVAL.MES) + ' / ' + (X.FECHA_EVAL.ANIO);
           if not EsFechaValida(FECHA) then
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
     end
           else
           begin
           legajo:=x.num_legajo;
           if fechaExistente (archivoEval,fecha,legajo) then
              begin
                clrscr;
                writeln('FECHA EXISTENTE. NO ES POSIBLE CARGAR MAS DE 1 EVALUACION POR DIA');
              end;
           end;
    until EsFechaValida(FECHA) and Not fechaExistente (archivoEval,fecha,legajo);

     GOTOXY(45,20);
WRITELN('INGRESE LAS VALORACIONES: ');
FOR I:=1 TO 5 DO
BEGIN
    CLRSCR;
    TEXTCOLOR(GREEN);
    GOTOXY(40,14);
    IF Y.DISCAPACIDAD[I] THEN
    BEGIN
        WRITELN('EN UNA ESCALA DEL 1 AL 4, INGRESE EL VALOR ADECUADO A LA DISCAPACIDAD');
        GOTOXY(40,16);
        TEXTCOLOR(RED);
        WRITELN('DONDE 1 ES EL VALOR MÍNIMO Y 4 EL MÁXIMO');
        GOTOXY(40,18);
        TEXTCOLOR(green);
        WRITE('VALORACIÓN PARA ', OBTENERNOMBREDISCAPACIDAD(i), ' : ');
        TEXTCOLOR(white);
        READLN(VALORACION);
         //Falta validar que solo sea numero
        WHILE (VALORACION < 1) OR (VALORACION > 4) DO
        BEGIN
            CLRSCR;
            TEXTCOLOR(RED);
            GOTOXY(40,10);
            WRITELN('POR FAVOR REVISE LA COHERENCIA DE SUS DATOS INGRESADOS');
            GOTOXY(40,12);
            TEXTCOLOR(GREEN);
            WRITELN('RECUERDE QUE EL VALOR DEBE ESTAR ENTRE 1 Y 4');
            GOTOXY(40,14);
            WRITE('VALORACIÓN ', I, ': ');
            TEXTCOLOR(WHITE);
            READLN(VALORACION);
        END;
    END
    ELSE
    BEGIN
        textcolor(lightgray);
        GOTOXY(35,14);
        WRITELN('LA DISCAPACIDAD : ', OBTENERNOMBREDISCAPACIDAD(i), ' NO APLICA EN ESTE ALUMNO');
        GOTOXY(40,15);
        WRITELN('POR LO TANTO, SE LE ASIGNARA UNA VALORACION DE CERO(0)');
        VALORACION := 0;
        GOTOXY(40,17);
        textcolor(red);
        WRITELN('OPRIME <<ENTER>> PARA CONTINUAR');
        READKEY;
    END;
    X.VALORACION[I] := VALORACION;


END;
clrscr;
textcolor(green);
gotoxy(40,2);
writeln('INGRESE UNA OBSERVACION PARA LA EVALUACION');
gotoxy(0,8);
write('observacion: ');
textcolor(white);
READLN(x.obs);

end;

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

PROCEDURE DARALTAEVAL (VAR ARCHIVOEVAL:T_ARCHIVO_EVAL; VAR X:T_DATO_EVAL; VAR ARCHIVOALUMNO:T_ARCHIVO_ALUMNOS; POS:INTEGER);
VAR
    FINARCH:CARDINAL;
BEGIN
    CARGARDATOSEVAL(X,ARCHIVOALUMNO,archivoeval,POS);
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
    IF (X.FECHA_EVAL.DIA = (COPY(FECHA, 1, 2))) AND
       (X.FECHA_EVAL.MES = (COPY(FECHA, 4, 2))) AND
       (X.FECHA_EVAL.ANIO = (COPY(FECHA, 7, 4))) THEN
      BUSCAREVALUACION := I;
  END;
END;
END;

PROCEDURE CONSULTAEVALUACION(VAR RAIZLEGAJO: T_PUNT_ARBOL; VAR ARCHIVOEVAL: T_ARCHIVO_EVAL; VAR ARCHIVOALUMNO:T_ARCHIVO_ALUMNOS; POSALUMNO: INTEGER);
VAR
  BUSCADOLEGAJO: STRING;
  BUSCADOFECHA: STRING;
  POS: INTEGER;
  X: T_DATO_EVAL;
  Y:T_DATO_ALUMNOS;
  DIA,MES,ANIO:STRING;
BEGIN
  CLRSCR;
  GOTOXY(52,10);
  WRITELN('**CONSULTA EVALUACION**');
  TEXTCOLOR(GREEN);
  GOTOXY(45,12);

  SEEK(ARCHIVOALUMNO,POSALUMNO);
  READ(ARCHIVOALUMNO,Y);
  X.NUM_LEGAJO:= Y.NUM_LEGAJO;
  BUSCADOLEGAJO:=   X.NUM_LEGAJO;

  TEXTCOLOR(GREEN);
  GOTOXY(27,14);
  WRITE('INGRESE FECHA DE LA EVALUACION. RECUERDE INGRESAR DIA MES Y AÑO POR SEPARADO');
   TEXTCOLOR(GREEN);
  GOTOXY(45,16);
  WRITE('INGRESE EL DIA: ');
  TEXTCOLOR(WHITE);
  READLN(DIA);
  TEXTCOLOR(GREEN);
  GOTOXY(45,18);
  WRITE('INGRESE EL MES: ');
  TEXTCOLOR(WHITE);
  READLN(MES);
  TEXTCOLOR(GREEN);
  GOTOXY(45,20);
  WRITE('INGRESE EL AÑO: ');
  TEXTCOLOR(WHITE);
  READLN(ANIO);
  buscadoFECHA := DIA + '/' + MES + '/' + ANIO;

  WHILE NOT  EsFechaValida(buscadoFecha) DO
  begin
       clrscr;
            TEXTCOLOR(RED);
        GOTOXY(45,11);
        writeln('FECHA INGRESADA NO VALIDA. POR FAVOR REVISE SUS DATOS');
        GOTOXY(42,12);
        WRITELN( 'RECUERDE DAR DIA, MES Y AÑO DE LA EVALUACION POR SEPARADO');
         TEXTCOLOR(GREEN);
        GOTOXY(45,14);
        WRITE('INGRESE FECHA DE LA EVALUACION: ');
         TEXTCOLOR(GREEN);
        GOTOXY(45,16);
        WRITE('INGRESE EL DIA: ');
        TEXTCOLOR(WHITE);
        READLN(DIA);
        TEXTCOLOR(GREEN);
        GOTOXY(45,18);
        WRITE('INGRESE EL MES: ');
        TEXTCOLOR(WHITE);
        READLN(MES);
        TEXTCOLOR(GREEN);
        GOTOXY(45,20);
        WRITE('INGRESE EL AÑO: ');
        TEXTCOLOR(WHITE);
        READLN(ANIO);
        buscadoFECHA := DIA + '/' + MES + '/' + ANIO;
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



PROCEDURE MODIFICAREVAL(VAR RAIZAPYNOM, RAIZLEGAJO: T_PUNT_ARBOL; VAR ARCHIVOEVAL: T_ARCHIVO_EVAL; VAR ARCHIVOALUMNO:T_ARCHIVO_ALUMNOS; POSALUMNO:INTEGER);
VAR
  LEGAJO, FECHA,OPCION: STRING;
  POS: INTEGER;
  X: T_DATO_EVAL;
  I: INTEGER;
  DIA,MES,ANIO:STRING;
  Y:T_DATO_ALUMNOS;
BEGIN
  CLRSCR;
  GOTOXY(50,10);
  WRITELN('**MODIFICAR EVALUACION**');                             //aca falto validar una fecha, revisar la consulta tambien
  TEXTCOLOR(GREEN);
  GOTOXY(45,12);

  SEEK(ARCHIVOALUMNO, POSALUMNO);
  READ(ARCHIVOALUMNO, Y);
  X.NUM_LEGAJO := Y.NUM_LEGAJO;

  TEXTCOLOR(GREEN);
  GOTOXY(45,14);
  WRITE('INGRESE EL DIA: ');
  TEXTCOLOR(WHITE);
  READLN(DIA);
  TEXTCOLOR(GREEN);
  GOTOXY(45,16);
  WRITE('INGRESE EL MES: ');
  TEXTCOLOR(WHITE);
  READLN(MES);
  TEXTCOLOR(GREEN);
  GOTOXY(45,18);
  WRITE('INGRESE EL AÑO: ');
  TEXTCOLOR(WHITE);
  READLN(ANIO);

  FECHA := DIA + '/' + MES + '/' + ANIO;

  WHILE NOT  EsFechaValida(Fecha) DO
  begin
       clrscr;
       TEXTCOLOR(RED);
        GOTOXY(45,11);
        writeln('FECHA INGRESADA NO VALIDA. POR FAVOR REVISE SUS DATOS');
        GOTOXY(42,12);
        WRITELN('RECUERDE DAR DIA, MES Y AÑO DE LA EVALUACION POR SEPARADO');
        TEXTCOLOR(GREEN);
        GOTOXY(45,14);
        WRITE('INGRESE DIA: ');
        TEXTCOLOR(WHITE);
        READLN(DIA);
        TEXTCOLOR(GREEN);
        GOTOXY(45,16);
        WRITE('INGRESE MES: ');
        TEXTCOLOR(WHITE);
        READLN(MES);
        TEXTCOLOR(GREEN);
        GOTOXY(45,18);
        WRITE('INGRESE AÑO: ');
        TEXTCOLOR(WHITE);
        READLN(ANIO);
        FECHA := DIA + '/' + MES + '/' + ANIO;

  end;
  POS := BUSCAREVALUACION(RAIZLEGAJO,ARCHIVOEVAL,X.NUM_LEGAJO,FECHA);
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

      TEXTCOLOR(YELLOW);
      GOTOXY(45,10);
      WRITELN('INGRESE EL CAMPO A MODIFICAR DE LA EVALUACION:');
       TEXTCOLOR(GREEN);
      GOTOXY(45,12);
      WRITE('0- ');
      TEXTCOLOR(WHITE);
      WRITELN('VOLVER AL MENÚ DE SEGUIMIENTO');
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
      while not esNumero(OPCION) or (OPCION < '0') or (OPCION > '3') do
       BEGIN
       GOTOXY(52,20);
       WRITE('                                                         ');
       TEXTCOLOR(GREEN);
       GOTOXY(45,20);
       WRITE('OPCION: ');
       TEXTCOLOR(WHITE);
       READLN(OPCION);
       END;

        CASE OPCION OF
          '1':
          BEGIN
            REPEAT
            CLRSCR;
            TEXTCOLOR(GREEN);
            GOTOXY(40,12);
            WRITE('INGRESE LA NUEVA FECHA DE LA EVALUACION (DD/MM/AAAA): ');
            TEXTCOLOR(GREEN);
             GOTOXY(45,14);
             WRITE('INGRESE DIA: ');
             TEXTCOLOR(WHITE);
             READLN(DIA);
             while not(EsNumero(DIA)) or (Length(DIA) <> 2) do
          begin
         GOTOXY(45,24);
          TEXTCOLOR(RED);
          writeln('DIA INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE. EJ: 02');
          TEXTCOLOR(GREEN);
          GOTOXY(45,14);
          WRITE('INGRESE DIA: ');
          TEXTCOLOR(WHITE);
          readln(DIA);
          GOTOXY(45,24);
          writeln('                                                                                             ');
          end;


             TEXTCOLOR(GREEN);
             GOTOXY(45,16);
             WRITE('INGRESE MES: ');
             TEXTCOLOR(WHITE);
             READLN(MES);
             while not(EsNumero(mes)) or (Length(mes) <> 2) do
          begin
         GOTOXY(45,24);
          TEXTCOLOR(RED);
          writeln('MES INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE. EJ: 01');
          TEXTCOLOR(GREEN);
          GOTOXY(45,16);
          WRITE('INGRESE MES: ');
          TEXTCOLOR(WHITE);
          readln(MES);
          GOTOXY(45,24);
          writeln('                                                                                             ');
          end;

             TEXTCOLOR(GREEN);
             GOTOXY(45,18);
             WRITE('INGRESE AÑO: ');
             TEXTCOLOR(WHITE);
             READLN(ANIO);
             while not(EsNumero(anio)) or (Length(anio) <> 4) do
          begin
         GOTOXY(45,24);
          TEXTCOLOR(RED);
          writeln('AÑO INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE. EJ: 2025');
          TEXTCOLOR(GREEN);
          GOTOXY(45,18);
          WRITE('INGRESE AÑO: ');
          TEXTCOLOR(WHITE);
          readln(ANIO);
          GOTOXY(45,24);
          writeln('                                                                                             ');
          end;

             FECHA := DIA + '/' + MES + '/' + ANIO;
           if not EsFechaValida(FECHA) then
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
     end
           else
           x.FECHA_EVAL.dia:=dia;
           x.FECHA_EVAL.mes:=mes;
           x.fecha_eval.anio:=anio;

    until EsFechaValida(FECHA);
          END;
          '2':
          BEGIN
           CLRSCR;
           TEXTCOLOR(GREEN);
           GOTOXY(45,11);
           WRITELN(' * INGRESE LA DISCAPACIDAD A MODIFICAR SU VALORACIÓN * ');
           TEXTCOLOR(WHITE);
           GOTOXY(45,13);
           WRITELN('1- PROBLEMAS DEL HABLA Y LENGUAJE');
           GOTOXY(45,14);
           WRITELN('2- DIFICULTAD PARA ESCRIBIR');
           GOTOXY(45,15);
           WRITELN('3- DIFICULTADES DE APRENDIZAJE VISUAL');
           GOTOXY(45,16);
           WRITELN('4- MEMORIA Y OTRAS DIFICULTADES DEL PENSAMIENTO');
           GOTOXY(45,17);
           WRITELN('5- DESTREZAS SOCIALES INADECUADAS');
           GOTOXY(45,19);
           TEXTCOLOR(GREEN);
           WRITE ('RESPUESTA: ');
           TEXTCOLOR(WHITE);
            READLN(I);

            GOTOXY(27,22);
            TEXTCOLOR(GREEN);
            WRITE('INGRESE LA NUEVA VALORACION (0-4) PARA ', OBTENERNOMBREDISCAPACIDAD(I), ': ');


              TEXTCOLOR(WHITE);
              if x.valoracion[i] = 0 then
                begin
                clrscr;
                GOTOXY(27,22);
                 writeln('ALUMNO NO POSEE DICHA DISCAPACIDAD. NO SE PUEDE VALORAR NI MODIFICAR');
                 GOTOXY(27,24);
                 TEXTCOLOR(RED);
                 writeln('OPRIMA <<ENTER>> PARA REGRESAR AL MENU');
                 READKEY;
                 end
                 else
              READLN(X.VALORACION[I]);       //reveer esto, solo modificar si esta disponible.
          END;
          '3':
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
        CLRSCR;
        GOTOXY(40,15);
        WRITELN('EVALUACION MODIFICADA CORRECTAMENTE');
      END;
  READKEY;
  CLRSCR;
END;

PROCEDURE MUESTRA_REGISTRO_POR_TABLA_EVAL (VAR X: T_DATO_EVAL);
VAR
  FECHA:STRING;
BEGIN
  FECHA:=(X.FECHA_EVAL.DIA) + ' / ' + (X.FECHA_EVAL.MES) + ' / ' + (X.FECHA_EVAL.ANIO);
  WITH X DO
  BEGIN
    WRITE(NUM_LEGAJO:10, FECHA:30, VALORACION[1]:12, VALORACION[2]:10, VALORACION[3]:10, VALORACION[4]:10, VALORACION[5]:10);
    WRITELN;
  END;
END;


 END.