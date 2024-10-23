UNIT archivoAlum;
{$CODEPAGE UTF8}

INTERFACE
USES
  crt;
CONST
  RUTA = 'C:\Users\lucia\OneDrive\Escritorio\Trabajo Final Algoritmos.dat';
TYPE
  t_fecha = record
    dia:string[2];
    mes:string[2];
    anio:byte;
  end;   
  t_dato_alum = record
    num_legajo:string[8];
    apynom:string[100];
    fecha_nac:t_fecha;
    estado:boolean;
    discapacidad: array [1..5] of boolean;
  end;
  t_archivo_alumnos = file of t_dato_alum;

Procedure crear_abrir (VAR arch:t_archivo_alumnos);
Procedure cerrar (VAR arch:t_archivo_alumnos);

IMPLEMENTATION
Procedure crear_abrir (VAR arch:t_archivo_alumnos);
begin
  assign(arch, ruta);
  {$I-}
  reset (arch);
  {$I+}
  if ioresult<>0 then
    rewrite(arch);
end;
Procedure cerrar (VAR arch:t_archivo_alumnos);
begin
  close(arch);
end;
end.                                         
