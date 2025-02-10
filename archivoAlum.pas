UNIT ARCHIVOALUM;

{$CODEPAGE UTF8}

INTERFACE

USES
  CRT;

CONST
  RUTA = 'D:\Martin.DAT';

TYPE
  T_FECHA = RECORD
    DIA:string[2];
    MES:string[2];
    ANIO:string[4];
  END;

  T_DATO_ALUMNOS = RECORD
    NUM_LEGAJO:STRING[8];
    APYNOM:STRING[100];
    FECHA_NAC:T_FECHA;
    ESTADO:BOOLEAN;
    DISCAPACIDAD: ARRAY [1..5] OF BOOLEAN;
  END;

  T_ARCHIVO_ALUMNOS = FILE OF T_DATO_ALUMNOS;

PROCEDURE CREAR_ABRIR (VAR ARCH:T_ARCHIVO_ALUMNOS);
PROCEDURE CERRAR (VAR ARCH:T_ARCHIVO_ALUMNOS);

IMPLEMENTATION

PROCEDURE CREAR_ABRIR (VAR ARCH:T_ARCHIVO_ALUMNOS);
BEGIN
  ASSIGN(ARCH, RUTA);
  {$I-}
  RESET (ARCH);
  {$I+}
  IF IORESULT<>0 THEN
    REWRITE(ARCH);
END;

PROCEDURE CERRAR (VAR ARCH:T_ARCHIVO_ALUMNOS);
BEGIN
  CLOSE(ARCH);
END;

END.