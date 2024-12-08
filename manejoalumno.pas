UNIT manejoAlumno;
{$CODEPAGE UTF8}
INTERFACE
    USES  
        CRT, ARCHIVOALUM;
IMPLEMENTATION

procedure CargarDatosAlumno (var x:t_dato_alumnos ; var raizapynom,raiznumlegajo:t_punt_arbol);
var
    disc:char;
    i:byte;
    arb:t_dato_arbol;
begin
with x do
    begin
    write('Igrese numero de legajo: ');
    readln(num_legajo);
    arb.clave := num_legajo;
    write('Ingrese Nombre y Apellido: ');
    readln(apynom);
    arb.clave := apynom;
    // ?? No se sobrescribe
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
        write('Discapacidad ', i, ' :');
        readln(discapacidad);
        if UpCase(disc) = 'T' then
            discapacidad.i:=true;
        else
            discapacidad.i:=false;
    end;
    estado:= true;
    AGREGAR_ARBOL(raizapynom,arb);
    AGREGAR_ARBOL(raiznumlegajo,arb);
    
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
    FinArch:= FileSize(archivoAlumno);
    CargarDatosAlumno(x);
    CargarAlumno(archivoAlumno, FinArch, x);
end;

procedure MuestraDatosAlumno(x:t_dato_alumnos);
begin
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
WRITE('DISCAPACIDAD/ES');
TEXTCOLOR(WHITE);
FOR I:=1 TO 5 do
    WRITE('DISCAPACIDAD : ', I);
END;                   
end;

{procedure ConsultaAlumno (archivoAlumno:t_archivo_alumnos);
var
    x:t_dato_alumnos;
    buscado:string;
    pos:integer;
begin
    writeln('****CONSULTA ALUMNO****');
    write('INGRESE APELLIDO Y NOMBRE DEL ALUMNO: ');
    readln(buscado);
    BusquedaAlumno(archivoAlumno,buscado,pos);
    if pos = 0 then
        writeln('NO SE ENCUENTRA REGISTRO DE ALUMNO')
    else
    begin
        seek(archivoAlumno,pos);
        read(archivoAlumno,x);
        MuestraDatosAlumno(x);
    end;
end;

procedure BusquedaAlumno (archivoAlumno:t_archivo_alumnos; buscado:string ; var pos:integer);
var
 i:byte;
begin
i := 0;
pos := 0;
 while (buscado <> x.apynom) and (pos = 0) and (not eof(archivoAlumno)) do
  begin
      seek(archivoAlumno,i);
      read(archivoAlumno,x);
      if x.apynom = buscado then
       pos := i 
      else
       i := i + 1;
  end;
end;}

procedure ConsultaAlumnoPorApynom(var raizapynom: t_punt_arbol ; archivoAlumno:t_archivo_alumnos);
var
  buscado: string;
  pos: integer;
  x: t_dato_alumnos;
begin
  writeln('****CONSULTA ALUMNO POR APELLIDO Y NOMBRE****');
  write('INGRESE APELLIDO Y NOMBRE DEL ALUMNO: ');
  readln(buscado);
  pos := Preorden(raizapynom, buscado);
  if pos = -1 then
    writeln('NO SE ENCUENTRA REGISTRO DE ALUMNO')
  else
  begin
    seek(archivoAlumno, pos);
    read(archivoAlumno, x);
    MuestraDatosAlumno(x);
  end;
end;



procedure BajaAlumno(var raizapynom: t_punt_arbol; var archivoAlumno: t_archivo_alumnos);
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
    writeln('NO SE ENCUENTRA REGISTRO DE ALUMNO')
  else
  begin
    // Leer el registro del archivo de alumnos en la posición pos
    seek(archivoAlumno, pos);
    read(archivoAlumno, x);
    
    if not x.estado then
    begin
      writeln('ALUMNO YA DADO DE BAJA')
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

procedure ModificarAlumno(var raizapynom: t_punt_arbol; var archivoAlumno: t_archivo_alumnos);
var
  buscado: string;
  pos: integer;
  x: t_dato_alumnos;
  opcion: byte;
  i: byte;
  arb: t_dato_arbol;
begin
  writeln('****MODIFICAR ALUMNO****');
  write('INGRESE APELLIDO Y NOMBRE DEL ALUMNO: ');
  readln(buscado);
  pos := Preorden(raizapynom, buscado);
  if pos = -1 then
    writeln('NO SE ENCUENTRA REGISTRO DE ALUMNO')
  else
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
          writeln('INGRESE NUEVA FECHA DE NACIMIENTO:');
          readln(x.fecha_nac);
        end;
      3:
        begin
          writeln('INGRESE DISCAPACIDAD: ');
          writeln('Oprima T si la tiene y F si no la tiene');
            for i:= 1 to 5 do
            begin
                write('Discapacidad ', i, ' :');
                readln(discapacidad);
                if UpCase(disc) = 'T' then
                discapacidad.i:=true;
                else
                discapacidad.i:=false;
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

