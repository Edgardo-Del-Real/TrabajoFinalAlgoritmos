UNIT manejoAlumno;
{$CODEPAGE UTF8}
INTERFACE
    USES  
        CRT, ARCHIVOALUM, UNITARBOL;

procedure CargarDatosAlumno (var x:t_dato_alumnos);
PROCEDURE PASAR_DATOS (VAR ARCH: T_ARCHIVO_alumnos; VAR RAIZLEGAJO,RAIZAPYNOM:T_PUNT_ARBOL);
procedure CargarAlumno(var archivoAlumno:t_archivo_alumnos; var FinArch:cardinal; x:t_dato_alumnos);
procedure DarAltaAlumno (var archivoAlumno:t_archivo_alumnos; var x:t_dato_alumnos);
procedure MuestraDatosAlumno(x:t_dato_alumnos);
procedure ConsultaAlumnos(var raizapynom, raizlegajo: t_punt_arbol ; VAR archivoAlumno:t_archivo_alumnos);
procedure BajaAlumno(var raizapynom, raizlegajo: t_punt_arbol; var archivoAlumno: t_archivo_alumnos);
procedure ModificarAlumno(var raizapynom, raizlegajo: t_punt_arbol; var archivoAlumno: t_archivo_alumnos);

IMPLEMENTATION
PROCEDURE PASAR_DATOS (VAR ARCH: T_ARCHIVO_alumnos; VAR RAIZLEGAJO,RAIZAPYNOM:T_PUNT_ARBOL);
VAR
  X:T_DATO_ALUMNOS;
  I:BYTE;
  R1,R:T_DATO_ARBOL;
BEGIN
  I:=0;
  IF FILESIZE (ARCH) >= 1 then
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

procedure CargarDatosAlumno (var x:t_dato_alumnos);
var
    disc:char;
    i:byte;
begin
  clrscr;
  with x do
      begin
        textcolor(white);
        gotoxy(50,10);
        writeln('**ALTA ALUMNO**');
        textcolor(green);
        gotoxy(45,12);
        write('Ingrese numero de legajo: ');
        textcolor(white);
        readln(num_legajo);
        textcolor(green);
        gotoxy(45,14);
        write('Ingrese nombre y apellido: ');
        textcolor(white);
        readln(apynom);
        textcolor(red);
        gotoxy(45,16);
        writeln('Ingrese Fecha de nacimiento. Ej: 08/09/2001');
        textcolor(green);
        gotoxy(45,18);
        write('Ingrese dia: ');
        textcolor(white);
        readln(fecha_nac.dia);
        textcolor(green);
        gotoxy(45,20);
        write('Ingrese mes: ');
        textcolor(white);
        readln(fecha_nac.mes);
        textcolor(green);
        gotoxy(45,22);
        write('Ingrese año de nacimiento: ');
        textcolor(white);
        readln(fecha_nac.anio);
        gotoxy(45,24);
        write('Ahora seleccione las discapacidades, ');
        textcolor(red);
        writeln('oprima T si la tiene y F si no la tiene');
        for i:=1 to 5 do
        BEGIN
              textcolor(green);
              gotoxy(45,27);
              write('Discapacidad ', i, ' :');
              textcolor(white);
              readln(disc);
              if UpCase(disc) = 'T' then
                  discapacidad[i]:=true
              else
                  discapacidad[i]:=false;
        end;
        estado:= true;
      end;
  clrscr;
end;

procedure CargarAlumno(var archivoAlumno:t_archivo_alumnos; var FinArch:cardinal; x:t_dato_alumnos);
begin
seek(archivoAlumno, FinArch);
Write(archivoAlumno,x);
end;

procedure DarAltaAlumno (var archivoAlumno:t_archivo_alumnos; var x:t_dato_alumnos);
var
    FinArch:cardinal;
begin
    CargarDatosAlumno(x); 
    FinArch:= FileSize(archivoAlumno);   // acá podriamos eliminar el finArch llamando al filesize del archivo nada mas
    CargarAlumno(archivoAlumno, FinArch, x);
end;

procedure MuestraDatosAlumno(x:t_dato_alumnos);
var
    i:byte;
begin
  clrscr;
  with x do
    BEGIN
      GOTOXY(45,5);
      TEXTCOLOR(RED);
      WRITELN('DATOS ACTUALES DEL ALUMNO');
      GOTOXY(45,7);
      TEXTCOLOR (GREEN);
      WRITE('NUMERO DE LEGAJO: ');
      TEXTCOLOR(WHITE);
      WRITE(num_legajo);
      GOTOXY(45,9);
      TEXTCOLOR (GREEN);
      WRITE('NOMBRE Y APELLIDO: ');
      TEXTCOLOR(WHITE);
      WRITE(apynom);
      GOTOXY(45,11);
      TEXTCOLOR (GREEN);
      WRITE('FECHA DE NACIMIENTO: ');
      TEXTCOLOR(WHITE);
      WRITE(fecha_nac.dia,'/',fecha_nac.mes,'/',fecha_nac.anio);
      GOTOXY(45,13);
      TEXTCOLOR (GREEN);
      WRITE('ESTADO: ');
      TEXTCOLOR(WHITE);
      WRITE(ESTADO);
      GOTOXY(45,15);
      TEXTCOLOR(GREEN);
      WRITELN('DISCAPACIDAD/ES:');
      TEXTCOLOR(WHITE);
      GOTOXY(45,17);
      WRITE('Problemas del habla y lenguaje: ');
      TEXTCOLOR(GREEN);
      WRITELN(DISCAPACIDAD[1]);
      TEXTCOLOR(WHITE);
      GOTOXY(45,19);
      WRITE('Dificultad para escribir: ');
      TEXTCOLOR(GREEN);
      WRITELN(DISCAPACIDAD[2]);
      TEXTCOLOR(WHITE);
      GOTOXY(45,21);
      WRITE('Dificultades de aprendizaje visual: ');
      TEXTCOLOR(GREEN);
      WRITELN(DISCAPACIDAD[3]);
      TEXTCOLOR(WHITE);
      GOTOXY(45,23);
      WRITE('Memoria y otras dificultades del pensamiento: ');
      TEXTCOLOR(GREEN);
      WRITELN(DISCAPACIDAD[4]);
      TEXTCOLOR(WHITE);
      GOTOXY(45,25);
      WRITE('Destrezas sociales inadecuadas: ');
      TEXTCOLOR(GREEN);
      WRITELN(DISCAPACIDAD[5]);
    END;
end;

procedure ConsultaAlumnos(var raizapynom, raizlegajo: t_punt_arbol ; VAR archivoAlumno:t_archivo_alumnos);
var
  buscado: string;
  pos: integer;
  x: t_dato_alumnos;
begin
  clrscr;
  gotoxy(47,10);
  writeln('**CONSULTA ALUMNO POR APELLIDO Y NOMBRE**');
  textcolor(green);
  gotoxy(45,12);
  write('INGRESE NOMBRE Y APELLIDO O LEGAJO DEL ALUMNO: ');
  textcolor(white);
  readln(buscado);
  pos := Preorden(raizapynom, buscado);
  if pos = -1 then
      POS := PREORDEN(raizlegajo, buscado);
  begin
    seek(archivoAlumno, pos);
    read(archivoAlumno, x);
    MuestraDatosAlumno(x);
  end;
  readkey;
  clrscr;
end;



procedure BajaAlumno(var raizapynom, raizlegajo: t_punt_arbol; var archivoAlumno: t_archivo_alumnos);
var
  buscado: string;
  pos: integer;
  x: t_dato_alumnos;
begin
  clrscr;
  textcolor(white);
  gotoxy(60,10);
  writeln('**BAJA ALUMNO**');
  textcolor(green);
  gotoxy(45,12);
  write('INGRESE APELLIDO Y NOMBRE O LEGAJO DEL ALUMNO: ');
  textcolor(white);
  readln(buscado);
  pos := Preorden(raizapynom, buscado);
  if pos = -1 then
    POS := PREORDEN(raizlegajo, buscado);
  begin
    // Leer el registro del archivo de alumnos en la posición pos
    seek(archivoAlumno, pos);
    read(archivoAlumno, x);
    
    if not x.estado then
      begin
        gotoxy(45,14);
        writeln('ALUMNO YA DADO DE BAJA')
      end
    else
      begin
        x.estado := false;
        // Sobreescribir el registro en el archivo de alumnos
        seek(archivoAlumno, pos);
        write(archivoAlumno, x);
        gotoxy(45,16);
        writeln('ALUMNO DADO DE BAJA CORRECTAMENTE');
      end;
  end;
  readkey;
  clrscr;
end;

procedure ModificarAlumno(var raizapynom, raizlegajo: t_punt_arbol; var archivoAlumno: t_archivo_alumnos);
var
  buscado: string;
  pos: integer;
  x: t_dato_alumnos;
  opcion: byte;
  i: byte;
  arb: t_dato_arbol;
  disc:char;
begin
  clrscr;
  gotoxy(60,10);
  writeln('**MODIFICAR ALUMNO**');
  textcolor(green);
  gotoxy(45,12);
  write('INGRESE APELLIDO Y NOMBRE DEL ALUMNO: ');
  textcolor(white);
  readln(buscado);
  pos := Preorden(raizapynom, buscado);
  if pos = -1 then
    pos := Preorden(raizlegajo, buscado);
  begin
    // Leer el registro del archivo de alumnos en la posición pos
    seek(archivoAlumno, pos);
    read(archivoAlumno, x);
    
    // Mostrar los datos actuales del alumno
    clrscr;
    MuestraDatosAlumno(x);
    readkey;
    clrscr;
    textcolor(red);
    gotoxy(45,10);
    writeln('QUE CAMPO DESEA MODIFICAR?');
    textcolor(green);
    gotoxy(45,12);
    write('1- ');
    textcolor(white);
    writeln('NOMBRE Y APELLIDO');
    textcolor(green);
    gotoxy(45,14);
    write('2- ');
    textcolor(white);
    writeln('FECHA DE NACIMIENTO');
    textcolor(green);
    gotoxy(45,16);
    write('3- ');
    textcolor(white);
    writeln('DISCAPACIDAD');
    textcolor(green);
    gotoxy(45,18);
    write('4- ');
    textcolor(white);
    writeln('ESTADO');
    textcolor(green);
    gotoxy(45,20);
    write('RESPUESTA: ');
    textcolor(white);
    readln(opcion);
    case opcion of
      1:
        begin
          clrscr;
          textcolor(green);
          gotoxy(45,10);
          write('INGRESE NUEVO NOMBRE Y APELLIDO: ');
          textcolor(white);
          readln(x.apynom);
          arb.clave := x.apynom;
          AGREGAR_ARBOL(raizapynom, arb);
        end;
      2:
        begin
          clrscr;
          textcolor(red);
          gotoxy(45,10);
          writeln('Ingrese Fecha de nacimiento. Ej: 08/09/2001');
          textcolor(green);
          gotoxy(45,12);
          write('Ingrese dia: ');
          textcolor(white);
          readln(X.fecha_nac.dia);
          textcolor(green);
          gotoxy(45,14);
          write('Ingrese mes: ');
          textcolor(white);
          readln(X.fecha_nac.mes);
          textcolor(green);
          gotoxy(45,16);
          write('Ingrese año de nacimiento: ');
          textcolor(white);
          readln(X.fecha_nac.anio);
        end;
      3:
        begin
          clrscr;
          gotoxy(45,10);
          writeln('INGRESE DISCAPACIDAD: ');
          textcolor(red);
          gotoxy(45,12);
          writeln('Oprima T si la tiene y F si no la tiene');
            for i:= 1 to 5 do
            begin
                textcolor(green);
                gotoxy(45,14);
                write('Discapacidad ', i, ' :');
                textcolor(white);
                readln(disc);
                if UpCase(disc) = 'T' then
                X.discapacidad[i]:=true
                else
                X.discapacidad[i]:=false;
            end;
        end;
      4:
        begin
          clrscr;
          textcolor(red);
          gotoxy(45,10);
          writeln('SE CAMBIO EL ESTADO DEL ALUMNO');
          x.estado := not x.estado;
        end;
    end;
    
    // Sobreescribir el registro en el archivo de alumnos
    seek(archivoAlumno, pos);
    write(archivoAlumno, x);
    textcolor(white);
    gotoxy(45,20);
    writeln('ALUMNO MODIFICADO CORRECTAMENTE');
  end;
  readkey;
  clrscr;
end;

end.