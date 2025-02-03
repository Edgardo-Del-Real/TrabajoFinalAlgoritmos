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


//PROCEDURE CARGARDATOSALUMNO (VAR X:T_DATO_ALUMNOS; CLAVE:STRING);
PROCEDURE CARGARDATOSALUMNO (VAR X:T_DATO_ALUMNOS; CLAVE:STRING; VAR ARCHIVOALUMNO:T_ARCHIVO_ALUMNOS);
PROCEDURE PASAR_DATOS (VAR ARCH: T_ARCHIVO_ALUMNOS; VAR RAIZLEGAJO,RAIZAPYNOM:T_PUNT_ARBOL);
PROCEDURE CARGARALUMNO(VAR ARCHIVOALUMNO:T_ARCHIVO_ALUMNOS; VAR FINARCH:CARDINAL; X:T_DATO_ALUMNOS);
PROCEDURE DARALTAALUMNO (VAR ARCHIVOALUMNO:T_ARCHIVO_ALUMNOS; VAR X:T_DATO_ALUMNOS; CLAVE:STRING);
PROCEDURE MUESTRADATOSALUMNO(X:T_DATO_ALUMNOS);
PROCEDURE MUESTRA_REGISTRO_POR_TABLA (VAR X: T_DATO_ALUMNOS);
procedure MOSTRARALUMNO (VAR ARCH:T_ARCHIVO_ALUMNOS ; POS:INTEGER);
PROCEDURE BAJAALUMNO(VAR ARCHIVOALUMNO: T_ARCHIVO_ALUMNOS; POS: INTEGER);
PROCEDURE MODIFICARALUMNO(VAR ARCHIVOALUMNO: T_ARCHIVO_ALUMNOS; POS:INTEGER);
PROCEDURE MOSTRAR_NOMBRE_ALUMNO (VAR ARCHIVOALUMNO:T_ARCHIVO_ALUMNOS; POS:INTEGER);
FUNCTION MostrarSiNo(condicion: BOOLEAN):sTRING;
FUNCTION MostrarEstado(condicion: BOOLEAN):string;

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

PROCEDURE CARGARDATOSALUMNO (VAR X:T_DATO_ALUMNOS; CLAVE:STRING; VAR ARCHIVOALUMNO:T_ARCHIVO_ALUMNOS);
VAR
    DISC:string;
    I:BYTE;
    FECHA:STRING;
    POS:INTEGER;
    Y:T_DATO_ALUMNOS;
BEGIN
  CLRSCR;
  WITH X DO
      BEGIN
        TEXTCOLOR(WHITE);
        GOTOXY(50,10);
        WRITELN('**ALTA ALUMNO**');
        TEXTCOLOR(GREEN);
        GOTOXY(45,12);
        WRITE('NUMERO DE LEGAJO: ', CLAVE);

        NUM_LEGAJO:= CLAVE;

    REPEAT
    POS := 0;

    WHILE NOT EsNumero(NUM_LEGAJO) DO
    BEGIN
        CLRSCR;
        TEXTCOLOR(GREEN);
        GOTOXY(42, 12);
        WRITE('HUBO UN ERROR. INGRESE NUEVAMENTE SU NUMERO DE LEGAJO: ');
        TEXTCOLOR(WHITE);
        READLN(NUM_LEGAJO);
    END;

    RESET(ARCHIVOALUMNO);

    WHILE NOT EOF(ARCHIVOALUMNO) DO
    BEGIN
        READ(ARCHIVOALUMNO, Y);

        IF NUM_LEGAJO = Y.NUM_LEGAJO THEN
        BEGIN
            CLRSCR;
            GOTOXY(42, 12);
            WRITE('HUBO UN ERROR. LEGAJO YA EXISTENTE. INGRESE UN NUEVO LEGAJO: ');
            TEXTCOLOR(WHITE);
            READLN(NUM_LEGAJO);

            RESET(ARCHIVOALUMNO);
        END
        ELSE
            POS := -1;
    END;
UNTIL POS = -1;



        TEXTCOLOR(GREEN);
        GOTOXY(45,14);
        WRITE('INGRESE NOMBRE Y APELLIDO: ');
        TEXTCOLOR(WHITE);
        READLN(APYNOM);
        apynom:=upCase(apynom);
        TEXTCOLOR(RED);


        while not EsCadena(APYNOM) and (apynom = '') do
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

PROCEDURE DARALTAALUMNO (VAR ARCHIVOALUMNO:T_ARCHIVO_ALUMNOS; VAR X:T_DATO_ALUMNOS; CLAVE:STRING);
VAR
    FINARCH:CARDINAL;
BEGIN
    CARGARDATOSALUMNO(X,CLAVE,ARCHIVOALUMNO);
    FINARCH:= FILESIZE(ARCHIVOALUMNO);
    CARGARALUMNO(ARCHIVOALUMNO, FINARCH, X);
END;

 PROCEDURE MUESTRADATOSALUMNO(X:T_DATO_ALUMNOS);
VAR
    I:BYTE;
    EstadoStr: STRING;
    Disc1, Disc2, Disc3, Disc4, Disc5: STRING;
BEGIN
  WITH X DO
    BEGIN
      CLRSCR;
      GOTOXY(10,5);
      TEXTCOLOR(YELLOW);
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
      EstadoStr := MostrarEstado(ESTADO);
      WRITE(EstadoStr); WRITELN;
      GOTOXY(10,15);
      TEXTCOLOR(GREEN);
      WRITELN('DISCAPACIDAD/ES:');
      TEXTCOLOR(WHITE);
      GOTOXY(10,17);
      WRITE('PROBLEMAS DEL HABLA Y LENGUAJE: ');
      TEXTCOLOR(GREEN);
      Disc1 := MostrarSiNo(DISCAPACIDAD[1]);
      WRITE(Disc1); WRITELN;
      TEXTCOLOR(WHITE);
      GOTOXY(10,19);
      WRITE('DIFICULTAD PARA ESCRIBIR: ');
      TEXTCOLOR(GREEN);
      Disc2 := MostrarSiNo(DISCAPACIDAD[2]);
      WRITE(Disc2); WRITELN;
      TEXTCOLOR(WHITE);
      GOTOXY(10,21);
      WRITE('DIFICULTADES DE APRENDIZAJE VISUAL: ');
      TEXTCOLOR(GREEN);
      Disc3 := MostrarSiNo(DISCAPACIDAD[3]);
      WRITE(Disc3); WRITELN;
      TEXTCOLOR(WHITE);
      GOTOXY(10,23);
      WRITE('MEMORIA Y OTRAS DIFICULTADES DEL PENSAMIENTO: ');
      TEXTCOLOR(GREEN);
      Disc4 := MostrarSiNo(DISCAPACIDAD[4]);
      WRITE(Disc4); WRITELN;
      TEXTCOLOR(WHITE);
      GOTOXY(10,25);
      WRITE('DESTREZAS SOCIALES INADECUADAS: ');
      TEXTCOLOR(GREEN);
      Disc5 := MostrarSiNo(DISCAPACIDAD[5]);
      WRITE(Disc5); WRITELN;
      TEXTCOLOR(WHITE);
    END;
END;

FUNCTION MostrarEstado(condicion: BOOLEAN):string;
BEGIN
  IF condicion THEN
   MostrarEstado :=  'ACTIVO'
  ELSE
     MostrarEstado :=  'INACTIVO';
END;


FUNCTION MostrarSiNo(condicion: BOOLEAN):string;
BEGIN
  IF condicion THEN
    MostrarSiNo :=  'SI'
  ELSE
    MostrarSiNo :=  'NO';
END;


procedure MOSTRARALUMNO (VAR ARCH:T_ARCHIVO_ALUMNOS ; POS:INTEGER);
VAR
  X:T_DATO_ALUMNOS;
  BEGIN
RESET(ARCH);
SEEK(ARCH, POS);
READ(ARCH, X);
MUESTRADATOSALUMNO(X);
GOTOXY(70,15);
TEXTCOLOR(YELLOW);
WRITE('OPRIMA <<ENTER>> PARA CONTINUAR ');
READKEY;
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
        TEXTCOLOR(GREEN);
        GOTOXY(35,13);
        WRITE('¿ESTÁ SEGURO QUE QUIERE DAR DE BAJA A ' );
        TEXTCOLOR(YELLOW);
        WRITE( X.APYNOM );
        TEXTCOLOR(GREEN);
        WRITE('?');
        GOTOXY(45,16);
         TEXTCOLOR(WHITE);
         WRITELN('S -> SÍ, DESEO DARLO DE BAJA');
         GOTOXY(45,18);
         WRITELN('N -> NO, DESEO VOLVER A MENÚ DE ALUMNO');

        REPEAT
          TEXTCOLOR(GREEN);
          GOTOXY(45,21);
          WRITE('RESPUESTA: ');
          TEXTCOLOR(WHITE);
          READLN(OP);
          OP := UPCASE(OP);
          IF (OP <> 'S') AND (OP <> 'N') THEN
            BEGIN
              GOTOXY(45,23);
              TEXTCOLOR(RED);
              WRITELN('** INGRESE UNA OPCIÓN VÁLIDA: S o N **');
              TEXTCOLOR(WHITE);
              DELAY(2000);
              GOTOXY(45,23);
              CLREOL;
              GOTOXY(55,21);
              CLREOL;
            END;
        UNTIL (OP = 'S') OR (OP = 'N');

        IF OP = 'S' THEN
          BEGIN
            PantallaCarga2;
            X.ESTADO := FALSE;
            SEEK(ARCHIVOALUMNO, POS);
            WRITE(ARCHIVOALUMNO, X);
            CLRSCR;
            GOTOXY(45,13);
            TEXTCOLOR(GREEN);
            WRITELN('ALUMNO DADO DE BAJA CORRECTAMENTE');
            GOTOXY(45,15);
            TEXTCOLOR(YELLOW);
            WRITELN('PRESIONE <<ENTER>> PARA CONTINUAR');
            READKEY;
          END;
      END;
END;

PROCEDURE MODIFICARALUMNO(VAR ARCHIVOALUMNO: T_ARCHIVO_ALUMNOS; POS:INTEGER);
VAR
  BUSCADO,FECHA_AUX: STRING;
  X: T_DATO_ALUMNOS;
  OPCION: STRING;
  I: BYTE;
  ARB: T_DATO_ARBOL;
  DISC:CHAR;
BEGIN

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

    REPEAT
    TEXTCOLOR(GREEN);
    GOTOXY(75,18);
    WRITE('RESPUESTA: ');
    TEXTCOLOR(WHITE);
    READLN(OPCION);

     IF NOT ESNUMERO(OPCION) OR (OPCION = '') THEN
      BEGIN
        TEXTCOLOR(RED);
        GOTOXY(75,22);
        WRITELN('ERROR: INGRESE UN NUMERO ENTRE 0 Y 3.');
        DELAY(1500);
        GOTOXY(75,22);
        CLREOL;
        GOTOXY(84,18);
        CLREOL;
      END
      ELSE
      BEGIN
        IF (OPCION < '0') OR (OPCION > '2') THEN
        BEGIN
          TEXTCOLOR(RED);
          GOTOXY(77,22);
          WRITELN('ERROR: OPCION FUERA DE RANGO.');
          DELAY(2000);
          GOTOXY(77,22);
          CLREOL;
          GOTOXY(86,18);
          CLREOL;
        END;
      END;
    UNTIL (ESNUMERO(OPCION)) AND (OPCION >= '0') AND (OPCION <= '2') AND (OPCION <> '');



    CASE OPCION OF
      '1':
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
      '2':
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

             while not(validarFechaDiaMes(X.FECHA_NAC.DIA)) do
          begin
         GOTOXY(45,24);
          TEXTCOLOR(RED);
          writeln('DIA INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
          TEXTCOLOR(GREEN);
          GOTOXY(45,12);
          WRITE('INGRESE DIA: ');
          TEXTCOLOR(WHITE);
          readln(X.FECHA_NAC.DIA);
          GOTOXY(45,24);
          writeln('                                                                                             ');
          end;

          TEXTCOLOR(GREEN);
          GOTOXY(45,14);
          WRITE('INGRESE MES: ');
          TEXTCOLOR(WHITE);
          READLN(X.FECHA_NAC.MES);

             while not validarFechaDiaMes(X.FECHA_NAC.MES) do
          begin
         GOTOXY(45,24);
          TEXTCOLOR(RED);
          writeln('MES INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
          TEXTCOLOR(GREEN);
          GOTOXY(45,14);
          WRITE('INGRESE MES: ');
          TEXTCOLOR(WHITE);
          readln(X.FECHA_NAC.MES);
          GOTOXY(45,24);
          writeln('                                                                                             ');
          end;

          TEXTCOLOR(GREEN);
          GOTOXY(45,16);
          WRITE('INGRESE AÑO: ');
          TEXTCOLOR(WHITE);
          READLN(X.FECHA_NAC.ANIO);
           while not validarFechaAnio(X.FECHA_NAC.ANIO) do
          begin
         GOTOXY(45,24);
          TEXTCOLOR(RED);
          writeln('AÑO INVALIDO, POR FAVOR VERIFIQUE E INGRESE NUEVAMENTE');
          TEXTCOLOR(GREEN);
          GOTOXY(45,16);
          WRITE('INGRESE AÑO: ');
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
    END;
    UNTIL opcion = '0';

    SEEK(ARCHIVOALUMNO, POS);
    WRITE(ARCHIVOALUMNO, X);
    PantallaCarga2;
    CLRSCR;
    GOTOXY(45,13);
    TEXTCOLOR(GREEN);
    WRITELN('ALUMNO MODIFICADO CORRECTAMENTE');
    GOTOXY(45,15);
    TEXTCOLOR(YELLOW);
    WRITELN('PRESIONE <<ENTER>> PARA CONTINUAR');
    READKEY;
  END;

end;

{PROCEDURE MUESTRA_REGISTRO_POR_TABLA (VAR X: T_DATO_ALUMNOS);
VAR
  FECHA:STRING;
BEGIN
  FECHA:=(X.FECHA_NAC.DIA) + ' / ' + (X.FECHA_NAC.MES) + ' / ' + (X.FECHA_NAC.ANIO);
 // WITH X DO
 // BEGIN
    WRITE(X.NUM_LEGAJO:10, X.APYNOM:28, FECHA:20, X.ESTADO:10, MOSTRARSINO(X.DISCAPACIDAD[1]):12, MOSTRARSINO(X.DISCAPACIDAD[2]):10, MOSTRARSINO(X.DISCAPACIDAD[3]):10, MOSTRARSINO(X.DISCAPACIDAD[4]):10, MOSTRARSINO(X.DISCAPACIDAD[5]):10);
    WRITELN;
  END;
//END;  }

{PROCEDURE MUESTRA_REGISTRO_POR_TABLA (VAR X: T_DATO_ALUMNOS);
VAR
  FECHA: STRING;
BEGIN
  FECHA := (X.FECHA_NAC.DIA) + ' / ' + (X.FECHA_NAC.MES) + ' / ' + (X.FECHA_NAC.ANIO);
  WITH X DO
  BEGIN
    WRITE(NUM_LEGAJO:10, APYNOM:28, FECHA:20, MostrarEstado(ESTADO):10, MostrarSiNo(DISCAPACIDAD[1]):12, MostrarSiNo(DISCAPACIDAD[2]):10, MostrarSiNo(DISCAPACIDAD[3]):10, MostrarSiNo(DISCAPACIDAD[4]):10, MostrarSiNo(DISCAPACIDAD[5]):10);
    WRITELN;
  END;
END;          }

PROCEDURE MUESTRA_REGISTRO_POR_TABLA (VAR X: T_DATO_ALUMNOS);
VAR
  FECHA, EstadoStr, Disc1, Disc2, Disc3, Disc4, Disc5: STRING;
BEGIN
  FECHA := (X.FECHA_NAC.DIA) + ' / ' + (X.FECHA_NAC.MES) + ' / ' + (X.FECHA_NAC.ANIO);
  EstadoStr := MostrarEstado(X.ESTADO);
  Disc1 := MostrarSiNo(X.DISCAPACIDAD[1]);
  Disc2 := MostrarSiNo(X.DISCAPACIDAD[2]);
  Disc3 := MostrarSiNo(X.DISCAPACIDAD[3]);
  Disc4 := MostrarSiNo(X.DISCAPACIDAD[4]);
  Disc5 := MostrarSiNo(X.DISCAPACIDAD[5]);

  WITH X DO
  BEGIN
    WRITE(NUM_LEGAJO:10, APYNOM:28, FECHA:20, EstadoStr:10, Disc1:12, Disc2:10, Disc3:10, Disc4:10, Disc5:10);
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