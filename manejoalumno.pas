UNIT manejoAlumno;
{$CODEPAGE UTF8}
INTERFACE
    USES  
        CRT, ARCHIVOALUM;
IMPLEMENTATION

procedure CargarAlumno (var archivoAlumno:t_archivo_alumnos);
var
    disc:string[1];
    i:byte;
begin
with archivoAlumno do
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