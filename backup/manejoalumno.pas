UNIT MANEJOALUMNO;

{$CODEPAGE UTF8}

INTERFACE

    USES
        CRT, ARCHIVOALUM, UNITARBOL, SYSUTILS, VALIDACIONES;


  CONST
      DISCAPACIDADES: ARRAY[1..5] OF STRING =
          ('PROBLEMAS DEL HABLA Y LENGUAJE',
           'DIFICULTAD PARA ESCRIBIR',
           'DIFICULTADES DE APRENDIZAJE VISUAL',
           'MEMORIA Y OTRAS DIFICULTADES DEL PENSAMIENTO',
           'DESTREZAS SOCIALES INADECUADAS');

PROCEDURE CARGARDATOSALUMNO (VAR X:T_DATO_ALUMNOS);
PROCEDURE PASAR_DATOS (VAR ARCH: T_ARCHIVO_ALUMNOS; VAR RAIZLEGAJO,RAIZAPYNOM:T_PUNT_ARBOL);
PROCEDURE CARGARALUMNO(VAR ARCHIVOALUMNO:T_ARCHIVO_ALUMNOS; VAR FINARCH:CARDINAL; X:T_DATO_ALUMNOS);
PROCEDURE DARALTAALUMNO (VAR ARCHIVOALUMNO:T_ARCHIVO_ALUMNOS; VAR X:T_DATO_ALUMNOS);
PROCEDURE MUESTRADATOSALUMNO(X:T_DATO_ALUMNOS);
//PROCEDURE CONSULTAALUMNOS(VAR RAIZAPYNOM, RAIZLEGAJO: T_PUNT_ARBOL ; VAR ARCHIVOALUMNO:T_ARCHIVO_ALUMNOS);
// PROCEDURE BAJAALUMNO(VAR RAIZAPYNOM, RAIZLEGAJO: T_PUNT_ARBOL; VAR ARCHIVOALUMNO: T_ARCHIVO_ALUMNOS);
//PROCEDURE MODIFICARALUMNO(VAR RAIZAPYNOM, RAIZLEGAJO: T_PUNT_ARBOL; VAR ARCHIVOALUMNO: T_ARCHIVO_ALUMNOS);
PROCEDURE MUESTRA_REGISTRO_POR_TABLA (VAR X: T_DATO_ALUMNOS);
procedure MOSTRARALUMNO (VAR ARCH:T_ARCHIVO_ALUMNOS ; POS:INTEGER);
PROCEDURE BAJAALUMNO(VAR ARCHIVOALUMNO: T_ARCHIVO_ALUMNOS; POS: INTEGER);
PROCEDURE MODIFICARALUMNO(VAR ARCHIVOALUMNO: T_ARCHIVO_ALUMNOS; POS:INTEGER);
PROCEDURE MOSTRAR_NOMBRE_ALUMNO (VAR ARCHIVOALUMNO:T_ARCHIVO_ALUMNOS; POS:INTEGER);

IMPLEMENTATION

PROCEDURE PASAR_DATOS (VAR ARCH: T_ARCHIVO_ALUMNOS; VAR RAIZLEGAJO,RAIZAPYNOM:T_PUNT_ARBOL);
VAR
  X:T_DATO_ALUMNOS;
  I:BYTE;
  R1,R:T_DATO_ARBOL;
BEGIN
  I:=0;
  IF FILESIZE (ARCH) >= 1 THEN
  BEGIN
       WHILE NOT EOF(ARCH) DO
       BEGIN
         SEEK (ARCH, I);
         READ (ARCH, X);
         R.CLAVE:=X.NUM_LEGAJO;
         R.POSARCH:= I;
         AGREGAR_ARBOL (RAIZLEGAJO,R);
         R1.CLAVE:=X.APYNOM;
         R1.POSARCH:= I;
         AGREGAR_ARBOL (RAIZAPYNOM,R1);
         I:= I + 1;
       END;
  END;
END;

PROCEDURE CARGARDATOSALUMNO (VAR X:T_DATO_ALUMNOS);
VAR
    DISC:string;
    I:BYTE;
    FECHA:STRING;
BEGIN
  CLRSCR;
  WITH X DO
      BEGIN
        TEXTCOLOR(WHITE);
        GOTOXY(50,10);
        WRITELN('**ALTA ALUMNO**');
        TEXTCOLOR(GREEN);
        GOTOXY(45,12);
        WRITE('INGRESE NUMERO DE LEGAJO: ');
        TEXTCOLOR(WHITE);
        READLN(NUM_LEGAJO);

        while not EsNumero(NUM_LEGAJO) do
        begin
        clrscr;
        TEXTCOLOR(GREEN);
        GOTOXY(45,12);
        WRITE('HUBO UN ERROR. INGRESE NUEVAMENTE SU NUMERO DE LEGAJO: ');
        TEXTCOLOR(WHITE);
        READLN(NUM_LEGAJO);
        end;

        TEXTCOLOR(GREEN);
        GOTOXY(45,14);
        WRITE('INGRESE NOMBRE Y APELLIDO: ');
        TEXTCOLOR(WHITE);
        READLN(APYNOM);
        apynom:=upCase(apynom);
        TEXTCOLOR(RED);


        while not EsCadena(APYNOM) do
        begin
            CLRSCR;
            TEXTCOLOR(RED);
            GOTOXY(45,14);
            WRITELN('NOMBRE INGRESADO INVALIDO. POR FAVOR REVISE COHERENCIA DE SUS DATOS');
            TEXTCOLOR(GREEN);
            GOTOXY(45,16);
            WRITE('INGRESE NOMBRE Y APELLIDO: ');
            TEXTCOLOR(WHITE);
            READLN(APYNOM);
            apynom:=upCase(apynom);
        end;

        repeat
        TEXTCOLOR(RED);
        GOTOXY(45,16);
        WRITELN('INGRESE FECHA DE NACIMIENTO. EJ: 08/09/2001');
        TEXTCOLOR(GREEN);
        GOTOXY(45,18);
        WRITE('INGRESE DIA: ');
        TEXTCOLOR(WHITE);
        READLN(FECHA_NAC.DIA);
          while not(EsNumero(FECHA_NAC.DIA)) do
          begin
          GOTOXY(45,24);
          TEXTCOLOR(RED);
          writeln('DIA INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
          TEXTCOLOR(GREEN);
          GOTOXY(45,18);
          WRITE('INGRESE EL DIA: ');
          TEXTCOLOR(WHITE);
          readln(FECHA_NAC.DIA);
          GOTOXY(45,24);
          writeln('                                                                                             ');
          end;

        TEXTCOLOR(GREEN);
        GOTOXY(45,20);
        WRITE('INGRESE MES: ');
        TEXTCOLOR(WHITE);
        READLN(FECHA_NAC.MES);
         while not(EsNumero(FECHA_NAC.MES)) do
          begin
          GOTOXY(45,24);
          TEXTCOLOR(RED);
          writeln('MES INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
          TEXTCOLOR(GREEN);
          GOTOXY(45,20);
          WRITE('INGRESE EL MES: ');
          TEXTCOLOR(WHITE);
          readln(FECHA_NAC.MES);
          GOTOXY(45,24);
          writeln('                                                                                             ');
          end;

        TEXTCOLOR(GREEN);
        GOTOXY(45,22);
        WRITE('INGRESE AÑO DE NACIMIENTO: ');
        TEXTCOLOR(WHITE);
        READLN(FECHA_NAC.ANIO);

          while not(EsNumero(FECHA_NAC.ANIO)) do
          begin
         GOTOXY(45,24);
          TEXTCOLOR(RED);
          writeln('AÑO INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
          TEXTCOLOR(GREEN);
          GOTOXY(45,22);
          WRITE('INGRESE EL AÑO: ');
          TEXTCOLOR(WHITE);
          readln(FECHA_NAC.ANIO);
          GOTOXY(45,24);
          writeln('                                                                                             ');
          end;

        FECHA:=(X.FECHA_NAC.DIA) + ' / ' + (X.FECHA_NAC.MES) + ' / ' + (X.FECHA_NAC.ANIO);

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
     end;
    until EsFechaValida(FECHA);


        FOR I:=1 TO 5 DO
        BEGIN
              CLRSCR;
              GOTOXY(25,10);
              WRITE('AHORA SELECCIONE LAS DISCAPACIDADES, ');
              TEXTCOLOR(RED);
              WRITELN('OPRIMA T SI LA TIENE Y F SI NO LA TIENE');
              TEXTCOLOR(GREEN);
              GOTOXY(42,14);
              WRITE(DISCAPACIDADES[I],': ');
              TEXTCOLOR(WHITE);
              READLN(DISC);
              while (upcase(disc) <> 'T') and (upcase(disc) <> 'F') do
              begin
              GOTOXY(25,12);
              TEXTCOLOR(RED);
              WRITELN('ENTRADA INVALIDA. LIMITESE A INGRESAR T O F');
              TEXTCOLOR(GREEN);
              GOTOXY(42,14);
              WRITE(DISCAPACIDADES[I],': ');
              TEXTCOLOR(WHITE);
              READLN(DISC);
              end;
              IF UPCASE(DISC) = 'T' THEN
                  DISCAPACIDAD[I]:=TRUE
              ELSE
                  DISCAPACIDAD[I]:=FALSE;
        END;
        ESTADO:= TRUE;
      END;
  CLRSCR;
END;

PROCEDURE CARGARALUMNO(VAR ARCHIVOALUMNO:T_ARCHIVO_ALUMNOS; VAR FINARCH:CARDINAL; X:T_DATO_ALUMNOS);
BEGIN
SEEK(ARCHIVOALUMNO, FINARCH);
WRITE(ARCHIVOALUMNO,X);
END;

PROCEDURE DARALTAALUMNO (VAR ARCHIVOALUMNO:T_ARCHIVO_ALUMNOS; VAR X:T_DATO_ALUMNOS);
VAR
    FINARCH:CARDINAL;
BEGIN
    CARGARDATOSALUMNO(X);
    FINARCH:= FILESIZE(ARCHIVOALUMNO);
    CARGARALUMNO(ARCHIVOALUMNO, FINARCH, X);
END;

PROCEDURE MUESTRADATOSALUMNO(X:T_DATO_ALUMNOS);
VAR
    I:BYTE;
BEGIN
  WITH X DO
    BEGIN
      CLRSCR;
      GOTOXY(10,5);
      TEXTCOLOR(RED);
      WRITELN('DATOS ACTUALES DEL ALUMNO');
      GOTOXY(10,7);
      TEXTCOLOR (GREEN);
      WRITE('NUMERO DE LEGAJO: ');
      TEXTCOLOR(WHITE);
      WRITE(NUM_LEGAJO);
      GOTOXY(10,9);
      TEXTCOLOR (GREEN);
      WRITE('NOMBRE Y APELLIDO: ');
      TEXTCOLOR(WHITE);
      WRITE(APYNOM);
      GOTOXY(10,11);
      TEXTCOLOR (GREEN);
      WRITE('FECHA DE NACIMIENTO: ');
      TEXTCOLOR(WHITE);
      WRITE(FECHA_NAC.DIA,'/',FECHA_NAC.MES,'/',FECHA_NAC.ANIO);
      GOTOXY(10,13);
      TEXTCOLOR (GREEN);
      WRITE('ESTADO: ');
      TEXTCOLOR(WHITE);
      WRITE(ESTADO);
      GOTOXY(10,15);
      TEXTCOLOR(GREEN);
      WRITELN('DISCAPACIDAD/ES:');
      TEXTCOLOR(WHITE);
      GOTOXY(10,17);
      WRITE('PROBLEMAS DEL HABLA Y LENGUAJE: ');
      TEXTCOLOR(GREEN);
      WRITELN(DISCAPACIDAD[1]);
      TEXTCOLOR(WHITE);
      GOTOXY(10,19);
      WRITE('DIFICULTAD PARA ESCRIBIR: ');
      TEXTCOLOR(GREEN);
      WRITELN(DISCAPACIDAD[2]);
      TEXTCOLOR(WHITE);
      GOTOXY(10,21);
      WRITE('DIFICULTADES DE APRENDIZAJE VISUAL: ');
      TEXTCOLOR(GREEN);
      WRITELN(DISCAPACIDAD[3]);
      TEXTCOLOR(WHITE);
      GOTOXY(10,23);
      WRITE('MEMORIA Y OTRAS DIFICULTADES DEL PENSAMIENTO: ');
      TEXTCOLOR(GREEN);
      WRITELN(DISCAPACIDAD[4]);
      TEXTCOLOR(WHITE);
      GOTOXY(10,25);
      WRITE('DESTREZAS SOCIALES INADECUADAS: ');
      TEXTCOLOR(GREEN);
      WRITELN(DISCAPACIDAD[5]);
      READKEY;
    END;
END;

{PROCEDURE CONSULTAALUMNOS(VAR RAIZAPYNOM, RAIZLEGAJO: T_PUNT_ARBOL ; VAR ARCHIVOALUMNO:T_ARCHIVO_ALUMNOS);
VAR
  BUSCADO: STRING;
  POS: INTEGER;
  X: T_DATO_ALUMNOS;
BEGIN
  CLRSCR;
  GOTOXY(47,10);
  WRITELN('**CONSULTA ALUMNO POR LEGAJO**');
  TEXTCOLOR(GREEN);
  GOTOXY(45,12);
  WRITE('INGRESE LEGAJO DEL ALUMNO: ');
  TEXTCOLOR(WHITE);
  READLN(BUSCADO);

  while not esnumero(buscado) do
  begin
    clrscr;
  TEXTCOLOR(GREEN);
  GOTOXY(45,12);
  WRITE('HUBO UN ERROR. INGRESE NUEVAMENTE EL LEGAJO DEL ALUMNO: ');
  TEXTCOLOR(WHITE);
  READLN(BUSCADO);
  end;

  POS := PREORDEN(RAIZAPYNOM, BUSCADO);
  IF POS = -1 THEN
      POS := PREORDEN(RAIZLEGAJO, BUSCADO);
  BEGIN
    CLRSCR;
    MOSTRARALUMNO (ARCHIVOALUMNO, POS);
  END;
  READKEY;
  CLRSCR;
END;         }

procedure MOSTRARALUMNO (VAR ARCH:T_ARCHIVO_ALUMNOS ; POS:INTEGER);
VAR
  X:T_DATO_ALUMNOS;
  BEGIN
RESET(ARCH);
SEEK(ARCH, POS);
READ(ARCH, X);
MUESTRADATOSALUMNO(X);
end;


PROCEDURE BAJAALUMNO(VAR ARCHIVOALUMNO: T_ARCHIVO_ALUMNOS; POS: INTEGER);
VAR
  BUSCADO: STRING;
  X: T_DATO_ALUMNOS;
  op: char;
BEGIN
    CLRSCR;
    SEEK(ARCHIVOALUMNO, POS);
    READ(ARCHIVOALUMNO, X);

    IF NOT X.ESTADO THEN
      BEGIN
        GOTOXY(50,14);
        TEXTCOLOR(RED);
        WRITELN('ALUMNO YA DADO DE BAJA');
        READKEY;
      END
    ELSE
      BEGIN
        GOTOXY(45,14);
        WRITELN('ESTA SEGURO QUE QUIERE DAR DE BAJA A: ', X.APYNOM);
        GOTOXY(45,15);
        WRITE('RESPONDA S/N: ');
        READLN(OP);
        IF UPCASE(OP) = 'S' THEN
          BEGIN
           X.ESTADO := FALSE;
           // SOBREESCRIBIR EL REGISTRO EN EL ARCHIVO DE ALUMNOS
           SEEK(ARCHIVOALUMNO, POS);
           WRITE(ARCHIVOALUMNO, X);
           GOTOXY(45,17);
           WRITELN('ALUMNO DADO DE BAJA CORRECTAMENTE');
           GOTOXY(45,19);
           WRITELN('PRESIONE "ENTER" PARA CONTINUAR');
           READKEY;
          END;
      END;
  END;

PROCEDURE MODIFICARALUMNO(VAR ARCHIVOALUMNO: T_ARCHIVO_ALUMNOS; POS:INTEGER);
VAR
  BUSCADO,FECHA_AUX: STRING;
  X: T_DATO_ALUMNOS;
  OPCION: BYTE;
  I: BYTE;
  ARB: T_DATO_ARBOL;
  DISC:CHAR;
BEGIN

    // LEER EL REGISTRO DEL ARCHIVO DE ALUMNOS EN LA POSICIÓN POS
    SEEK(ARCHIVOALUMNO, POS);
    READ(ARCHIVOALUMNO, X);

    IF NOT X.ESTADO THEN
      BEGIN
       CLRSCR;
       TEXTCOLOR(RED);
       GOTOXY(40,14);
      WRITELN('ESTE ALUMNO ESTÁ DADO DE BAJA, NO PUEDE MODIFICARSE');
    READKEY
      end
    ELSE
    BEGIN
    // MOSTRAR LOS DATOS ACTUALES DEL ALUMNO
    CLRSCR;
    repeat
    MUESTRADATOSALUMNO(X);
    TEXTCOLOR(RED);
    GOTOXY(80,10);
    WRITELN('QUE CAMPO DESEA MODIFICAR?');
    TEXTCOLOR(GREEN);
    GOTOXY(75,12);
    WRITE('1- ');
    TEXTCOLOR(WHITE);
    WRITELN('NOMBRE Y APELLIDO');
    TEXTCOLOR(GREEN);
    GOTOXY(75,14);
    WRITE('2- ');
    TEXTCOLOR(WHITE);
    WRITELN('FECHA DE NACIMIENTO');
    TEXTCOLOR(GREEN);
        GOTOXY(75,16);
    WRITE('0- ');
    TEXTCOLOR(WHITE);
    WRITELN('VOLVER A MENU ALUMNO');
    TEXTCOLOR(GREEN);
    GOTOXY(75,18);
    WRITE('RESPUESTA: ');
    TEXTCOLOR(WHITE);
    READLN(OPCION);
    CASE OPCION OF
      1:
        BEGIN
          CLRSCR;
          TEXTCOLOR(GREEN);
          GOTOXY(45,10);
          WRITE('INGRESE NUEVO NOMBRE Y APELLIDO: ');
          TEXTCOLOR(WHITE);
          READLN(X.APYNOM);
        while not EsCadena(X.APYNOM) do
        begin
            CLRSCR;
            TEXTCOLOR(RED);
            GOTOXY(45,14);
            WRITELN('NOMBRE INGRESADO INVALIDO. POR FAVOR REVISE COHERENCIA DE SUS DATOS');
            TEXTCOLOR(GREEN);
            GOTOXY(45,16);
            WRITE('INGRESE NOMBRE Y APELLIDO: ');
            TEXTCOLOR(WHITE);
            READLN(X.APYNOM);
        end;
        END;
      2:
        BEGIN
        REPEAT
          CLRSCR;
          TEXTCOLOR(RED);
          GOTOXY(45,10);
          WRITELN('INGRESE FECHA DE NACIMIENTO. EJ: 08/09/2001');
          TEXTCOLOR(GREEN);
          GOTOXY(45,12);
          WRITE('INGRESE DIA: ');
          TEXTCOLOR(WHITE);
          READLN(X.FECHA_NAC.DIA);

             while not(EsNumero(X.FECHA_NAC.DIA)) do
          begin
         GOTOXY(45,24);
          TEXTCOLOR(RED);
          writeln('DIA INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
          TEXTCOLOR(GREEN);
          GOTOXY(45,12);
          WRITE('INGRESE DIA: ');
          TEXTCOLOR(WHITE);
          readln(X.FECHA_NAC.ANIO);
          GOTOXY(45,24);
          writeln('                                                                                             ');
          end;

          TEXTCOLOR(GREEN);
          GOTOXY(45,14);
          WRITE('INGRESE MES: ');
          TEXTCOLOR(WHITE);
          READLN(X.FECHA_NAC.MES);

             while not(EsNumero(X.FECHA_NAC.ANIO)) do
          begin
         GOTOXY(45,24);
          TEXTCOLOR(RED);
          writeln('MES INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
          TEXTCOLOR(GREEN);
          GOTOXY(45,14);
          WRITE('INGRESE MES: ');
          TEXTCOLOR(WHITE);
          readln(FECHA_NAC.MES);
          GOTOXY(45,24);
          writeln('                                                                                             ');
          end;

          TEXTCOLOR(GREEN);
          GOTOXY(45,16);
          WRITE('INGRESE AÑO DE NACIMIENTO: ');
          TEXTCOLOR(WHITE);
          READLN(X.FECHA_NAC.ANIO);
           while not(EsNumero(X.FECHA_NAC.ANIO)) do
          begin
         GOTOXY(45,24);
          TEXTCOLOR(RED);
          writeln('AÑO INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
          TEXTCOLOR(GREEN);
          GOTOXY(45,16);
          WRITE('INGRESE EL AÑO: ');
          TEXTCOLOR(WHITE);
          readln(X.FECHA_NAC.ANIO);
          GOTOXY(45,24);
          writeln('                                                                                             ');
          end;

           FECHA_AUX:= X.FECHA_NAC.DIA + '/' + X.FECHA_NAC.MES + '/' + X.FECHA_NAC.ANIO;
           if not EsFechaValida(FECHA_AUX) then
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
    until EsFechaValida(FECHA_AUX);


        END;
     { 3:
        BEGIN
          CLRSCR;
          GOTOXY(45,10);
          WRITELN('INGRESE DISCAPACIDAD: ');
          TEXTCOLOR(RED);
          GOTOXY(45,12);
          WRITELN('OPRIMA T SI LA TIENE Y F SI NO LA TIENE');
            FOR I:= 1 TO 5 DO
            BEGIN
                TEXTCOLOR(GREEN);
                GOTOXY(45,14);
                WRITE('DISCAPACIDAD ', I, ' :');
                TEXTCOLOR(WHITE);
                READLN(DISC);
                IF UPCASE(DISC) = 'T' THEN
                X.DISCAPACIDAD[I]:=TRUE
                ELSE
                X.DISCAPACIDAD[I]:=FALSE;
            END;
        END;
      4:
        BEGIN
          CLRSCR;
          TEXTCOLOR(RED);
          GOTOXY(45,10);
          WRITELN('SE CAMBIO EL ESTADO DEL ALUMNO');
          X.ESTADO := NOT X.ESTADO;
        END; }
    END;
    UNTIL opcion = 0;

    SEEK(ARCHIVOALUMNO, POS);
    WRITE(ARCHIVOALUMNO, X);
    TEXTCOLOR(WHITE);
    GOTOXY(45,20);
    WRITELN('ALUMNO MODIFICADO CORRECTAMENTE');
    READKEY;
    CLRSCR;
  END;

end;

PROCEDURE MUESTRA_REGISTRO_POR_TABLA (VAR X: T_DATO_ALUMNOS);
VAR
  FECHA:STRING;
BEGIN
  FECHA:=(X.FECHA_NAC.DIA) + ' / ' + (X.FECHA_NAC.MES) + ' / ' + (X.FECHA_NAC.ANIO);
  WITH X DO
  BEGIN
    WRITE(NUM_LEGAJO:10, APYNOM:28, FECHA:20, ESTADO:10, DISCAPACIDAD[1]:12, DISCAPACIDAD[2]:10, DISCAPACIDAD[3]:10, DISCAPACIDAD[4]:10, DISCAPACIDAD[5]:10);
    WRITELN;
  END;
END;

PROCEDURE MOSTRAR_NOMBRE_ALUMNO (VAR ARCHIVOALUMNO:T_ARCHIVO_ALUMNOS; POS:INTEGER);
VAR
  X: T_DATO_ALUMNOS;
  Longitud: INTEGER;
  Linea: STRING;
BEGIN
  RESET(ARCHIVOALUMNO);
  SEEK(ARCHIVOALUMNO, POS);
  READ(ARCHIVOALUMNO, X);

  Longitud := Length(X.APYNOM) + 15;
  Linea := StringOfChar('-', Longitud);

  GOTOXY(50, 23);
  TEXTCOLOR(LightGray);
  WRITE(Linea);
  TEXTCOLOR(GREEN);
  GOTOXY(53, 24);
  WRITE('Alumno: ');
  TEXTCOLOR(LightGray);
  WRITE(X.APYNOM);
  GOTOXY(50, 25);
  TEXTCOLOR(LightGray);
  WRITE(Linea);
END;

END.
