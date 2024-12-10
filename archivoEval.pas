UNIT archivoEval;
{$CODEPAGE UTF8}

INTERFACE

USES
  crt;

CONST
    RUTA='C:\Users\GAMER\Desktop\TrabajoFinalAlgoritmos.dat';

TYPE
  t_fecha = record
    dia:1..31;
    mes:1..12;
    anio:word;
  end;

  t_dato_eval = record
    num_legajo:string[8];
    fecha_eval:t_fecha;
    valoracion: array [1..5] of integer;
    obs:string[255];
  end;

  t_archivo_eval = file of t_dato_eval;

Procedure crear_abrir2 (VAR arch:t_archivo_eval);
Procedure cerrar2 (VAR arch:t_archivo_eval);

IMPLEMENTATION

Procedure crear_abrir2 (VAR arch:t_archivo_eval);
begin
    assign(arch, ruta);
    {$I-}
    reset(arch);
    {$I+}
    If ioresult<>0 then
        rewrite(arch);
end;

Procedure cerrar2 (VAR arch:t_archivo_eval);
begin
    close(arch);
end;
end.