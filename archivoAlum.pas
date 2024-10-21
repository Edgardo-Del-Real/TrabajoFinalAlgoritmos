UNIT archivoAlum;
{$CODEPAGE UTF8}

INTERFACE
USES
  crt;

CONST 
  N=100;
  RUTA = 'C:\Users\lucia\OneDrive\Escritorio.dat';
Type
  t_fecha = record
    dia:string[2];
    mes:string[2];
    anio:byte;
  end;
  t_dato = record
    num_legajo:string[8];
    apynom:string[100];
    fecha_nac:t_fecha;
    estado:boolean;
    discapacidad: array [1..5] of boolean;
  end;
  t_vector = array [1..N] of t_dato;
USES
  CRT;

IMPLEMENTATION

