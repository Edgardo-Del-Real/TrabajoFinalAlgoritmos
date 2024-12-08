UNIT archivoAlum;
{$CODEPAGE UTF8}

INTERFACE
USES
  crt;
CONST
  RUTA = '/home/edgardo/.dat';
TYPE
  t_fecha = record
    dia:1..31;
    mes:1..12;
    anio:byte;
  end;   
  t_dato_alumnos = record
    num_legajo:string[8];
    apynom:string[100];
    fecha_nac:t_fecha;  
    estado:boolean;
    discapacidad: array [1..5] of boolean;
  end;
  t_archivo_alumnos = file of t_dato_alumnos;

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

