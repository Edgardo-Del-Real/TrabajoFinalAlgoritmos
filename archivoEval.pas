UNIT ARCHIVOEVAL;
{$CODEPAGE UTF8}

INTERFACE

USES
  CRT;

CONST
    RUTA = 'C:\Users\GAMER\Desktop\TrabajoFinalAlgoritmos.DAT';

TYPE
  T_FECHA = RECORD
    DIA:string[2];
    MES:string[2];
    ANIO:string[4];
  END;

  T_DATO_EVAL = RECORD
    NUM_LEGAJO:STRING[8];
    FECHA_EVAL:T_FECHA;
    VALORACION: ARRAY [1..5] OF INTEGER;
    OBS:STRING[255];
  END;

  T_ARCHIVO_EVAL = FILE OF T_DATO_EVAL;

PROCEDURE CREAR_ABRIR2 (VAR ARCH:T_ARCHIVO_EVAL);
PROCEDURE CERRAR2 (VAR ARCH:T_ARCHIVO_EVAL);

IMPLEMENTATION

PROCEDURE CREAR_ABRIR2 (VAR ARCH:T_ARCHIVO_EVAL);
BEGIN
    ASSIGN(ARCH, RUTA);
    {$I-}
    RESET(ARCH);
    {$I+}
    IF IORESULT<>0 THEN
        REWRITE(ARCH);
END;

PROCEDURE CERRAR2 (VAR ARCH:T_ARCHIVO_EVAL);
BEGIN
    CLOSE(ARCH);
END;
END.
