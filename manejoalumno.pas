UNIT manejoAlumno;
{$CODEPAGE UTF8}
INTERFACE
    USES  
        CRT, ARCHIVOALUM;
IMPLEMENTATION

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
        write('Discapacidad ', i, ' :');
        readln(discapacidad);
        if UpCase(disc) = 'T' then
            discapacidad.i:=true;
    estado:=true;
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

procedure ConsultaAlumno (archivoAlumno:t_archivo_alumnos; pos:integer);
var
    x:t_dato_alum;
    begin
    seek(archivoAlumno,pos);
    read(archivoAlumno,x);
    MuestraDatosAlumno(x);
    end;

procedure BusquedaAlumno (archivoAlumno:t_archivo_alumnos; buscado:t_dato_alum; var pos:integer);
var
 i:byte;
begin
i := 0;
 while (buscado <> x.apynom) and (pos = 0) do
  begin
      seek(archivoAlumno,i);
      read(archivoAlumno,x);
      if x.apynom = buscado then
       pos := i 
      else
       i := i + 1;
  end;
end;

