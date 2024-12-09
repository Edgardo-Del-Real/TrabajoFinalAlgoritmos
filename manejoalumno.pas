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
  X: T_DATO_alumnos;
  I:BYTE;
  R1,R:T_DATO_ARBOL;
BEGIN
  I:= 0;
  if FILESIZE (ARCH) >= 1 then
  begin                                                              //desp no va aca
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
 end;
END;

procedure CargarDatosAlumno (var x:t_dato_alumnos);
var
    disc:char;
    i:byte;
begin
with x do
    begin
    write('Igrese numero de legajo: ');
    readln(num_legajo);
    write('Ingrese Nombre y Apellido: ');
    readln(apynom);
    writeln('Ingrese Fecha de nacimiento. Ej: 08/09/2001');
    write('Ingrese dia ');
    readln(fecha_nac.dia);
    write('Ingrese mes ');
    readln(fecha_nac.mes);
    write('Ingrese Año de nacimiento: ');
    readln(fecha_nac.anio);
    writeln('Ahora seleccione las discapacidades ');
    writeln('Oprima T si la tiene y F si no la tiene');
    for i:=1 to 5 do
    BEGIN
        write('Discapacidad ', i, ' :');
        readln(disc);
        if UpCase(disc) = 'T' then
            discapacidad[i]:=true
        else
            discapacidad[i]:=false;
    end;
    estado:= true;
end;
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
    writeln('****DAR ALTA ALUMNO****');
    CargarDatosAlumno(x);
    FinArch:= FileSize(archivoAlumno);
    CargarAlumno(archivoAlumno, FinArch, x);
end;

procedure MuestraDatosAlumno(x:t_dato_alumnos);
var
    i:byte;
begin
clrscr;
with x do 
BEGIN
GOTOXY(45,7);
TEXTCOLOR (LIGHTBLUE);
WRITE('NUMERO DE LEGAJO: ');
TEXTCOLOR(WHITE);
WRITE(num_legajo);
GOTOXY(45,9);
TEXTCOLOR (LIGHTBLUE);
WRITE('NOMBRE Y APELLIDO: ');
TEXTCOLOR(WHITE);
WRITE(apynom);
GOTOXY(45,11);
TEXTCOLOR (LIGHTBLUE);
WRITE('FECHA DE NACIMIENTO: ');
TEXTCOLOR(WHITE);
WRITE(fecha_nac.dia,'/',fecha_nac.mes,'/',fecha_nac.anio); 
GOTOXY(45,13);
TEXTCOLOR (LIGHTBLUE);
WRITE('ESTADO: ');
TEXTCOLOR(WHITE);
WRITE(ESTADO);
GOTOXY(45,15);
TEXTCOLOR(LIGHTBLUE);
WRITEln('DISCAPACIDAD/ES');
TEXTCOLOR(WHITE);
WRITEln(' Problemas del habla y lenguaje: ', DISCAPACIDAD[1]);
WRITEln(' Dificultad para escribir: ', DISCAPACIDAD[2]);
WRITEln(' Dificultades de aprendizaje visual: ', DISCAPACIDAD[3]);
WRITEln(' Memoria y otras dificultades del pensamiento: ', DISCAPACIDAD[4]);
WRITEln(' Destrezas sociales inadecuadas: ', DISCAPACIDAD[5]);
END;
end;

procedure ConsultaAlumnos(var raizapynom, raizlegajo: t_punt_arbol ; VAR archivoAlumno:t_archivo_alumnos);
var
  buscado: string;
  pos: integer;
  x: t_dato_alumnos;
begin
  writeln('****CONSULTA ALUMNO POR APELLIDO Y NOMBRE****');
  write('INGRESE APELLIDO Y NOMBRE DEL ALUMNO O LEGAJO DEL ALUMNO: ');
  readln(buscado);
  pos := Preorden(raizapynom, buscado);
  if pos = -1 then
      POS := PREORDEN(raizlegajo, buscado);
  begin
    seek(archivoAlumno, pos);
    read(archivoAlumno, x);
    MuestraDatosAlumno(x);
  end;
end;



procedure BajaAlumno(var raizapynom, raizlegajo: t_punt_arbol; var archivoAlumno: t_archivo_alumnos);
var
  buscado: string;
  pos: integer;
  x: t_dato_alumnos;
begin
  writeln('****BAJA ALUMNO****');
  write('INGRESE APELLIDO Y NOMBRE DEL ALUMNO: ');
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
      writeln('ALUMNO YA DADO DE BAJA')
    end
    else
    begin
      x.estado := false;
      // Sobreescribir el registro en el archivo de alumnos
      seek(archivoAlumno, pos);
      write(archivoAlumno, x);
      
      writeln('ALUMNO DADO DE BAJA CORRECTAMENTE');
    end;
  end;
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
  writeln('****MODIFICAR ALUMNO****');
  write('INGRESE APELLIDO Y NOMBRE DEL ALUMNO: ');
  readln(buscado);
  pos := Preorden(raizapynom, buscado);
  if pos = -1 then
    pos := Preorden(raizlegajo, buscado);
  begin
    // Leer el registro del archivo de alumnos en la posición pos
    seek(archivoAlumno, pos);
    read(archivoAlumno, x);
    
    // Mostrar los datos actuales del alumno
    writeln('DATOS ACTUALES DEL ALUMNO:');
    MuestraDatosAlumno(x);

    writeln('QUE CAMPO DESEA MODIFICAR?');
    writeln('1- APELLIDO Y NOMBRES');
    writeln('2- FECHA DE NACIMIENTO');
    writeln('3- DISCAPACIDAD');
    writeln('4- ESTADO');
    write('OPCION: ');
    readln(opcion);
    case opcion of
      1:
        begin
          write('INGRESE NUEVO APELLIDO Y NOMBRES: ');
          readln(x.apynom);
          arb.clave := x.apynom;
          AGREGAR_ARBOL(raizapynom, arb);
        end;
      2:
        begin
          writeln('Ingrese Fecha de nacimiento. Ej: 08/09/2001');
          write('Ingrese dia ');
          readln(X.fecha_nac.dia);
          write('Ingrese mes ');
          readln(X.fecha_nac.mes);
          write('Ingrese Año de nacimiento: ');
          readln(X.fecha_nac.anio);
        end;
      3:
        begin
          writeln('INGRESE DISCAPACIDAD: ');
          writeln('Oprima T si la tiene y F si no la tiene');
            for i:= 1 to 5 do
            begin
                write('Discapacidad ', i, ' :');
                readln(disc);
                if UpCase(disc) = 'T' then
                X.discapacidad[i]:=true
                else
                X.discapacidad[i]:=false;
            end;
        end;
      4:
        begin
          writeln('SE CAMBIO EL ESTADO DEL ALUMNO');
          x.estado := not x.estado; 
        end;
    end;
    
    // Sobreescribir el registro en el archivo de alumnos
    seek(archivoAlumno, pos);
    write(archivoAlumno, x);
    
    writeln('ALUMNO MODIFICADO CORRECTAMENTE');
  end;
end;

end.
