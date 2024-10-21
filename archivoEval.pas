UNIT archivoEval;
{$CODEPAGE UTF8}

INTERFACE
USES
  crt;

CONST 
  N=100;

Type
  t_fecha = record
    dia:string[2];
    mes:string[2];
    anio:byte;
  end;
  t_dato = record
    num_legajo:string[8];
    fecha_eval:t_fecha;
    valSegDif: array [1..5] of int [0..4];
    obs:string[10000];
  end;
  t_vector = array [1..N] of t_dato;
USES
  CRT;

IMPLEMENTATION
