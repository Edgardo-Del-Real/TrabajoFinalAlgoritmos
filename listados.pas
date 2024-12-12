unit Listados;

{$codepage UTF8}

interface

uses
  UNITARBOL, archivoAlum, CRT, manejoAlumno;

PROCEDURE MOSTRAR_ENCABEZADO_TABLA;
procedure listado_apynom (VAR ARCH:T_ARCHIVO_ALUMNOS; RAIZAPYNOM: T_PUNT_ARBOL);
PROCEDURE MOSTRAR_REGISTRO_POR_POSICION(VAR ARCH:T_ARCHIVO_ALUMNOS; POS: WORD);
procedure listado_por_enfermedad (VAR ARCH:T_ARCHIVO_ALUMNOS);

implementation

PROCEDURE MOSTRAR_ENCABEZADO_TABLA;
BEGIN
  GOTOXY(1, 1);
  TEXTCOLOR(LIGHTBLUE);
  WRITELN('LEGAJO':10, ' NOMBRE Y APELLIDO   ':30, ' NACIMIENTO   ':20, ' ESTADO ':10, ' DIS1':10, ' DIS2':10, ' DIS3':10, ' DIS4':10, ' DIS5':10 );
  WRITELN;
  TEXTCOLOR(WHITE);
END;

PROCEDURE MOSTRAR_REGISTRO_POR_POSICION(VAR ARCH:T_ARCHIVO_ALUMNOS; POS: WORD);
VAR
  x: t_dato_alumnos;
BEGIN
  SEEK(ARCH, POS);
  READ(ARCH, x);
  MUESTRA_REGISTRO_POR_TABLA(x);
END;

PROCEDURE MOSTRAR_EN_ORDEN(VAR ARCH:T_ARCHIVO_ALUMNOS; RAIZ: T_PUNT_ARBOL);
BEGIN
  IF RAIZ <> NIL THEN
  BEGIN
    MOSTRAR_EN_ORDEN(ARCH, RAIZ^.SAI);
    MOSTRAR_REGISTRO_POR_POSICION(ARCH, RAIZ^.INFO.POSARCH);
    MOSTRAR_EN_ORDEN(ARCH, RAIZ^.SAD);
  END;
END;

procedure listado_apynom (VAR ARCH:T_ARCHIVO_ALUMNOS; RAIZAPYNOM: T_PUNT_ARBOL);
begin
  clrscr;
MOSTRAR_ENCABEZADO_TABLA;
MOSTRAR_EN_ORDEN(ARCH,RAIZAPYNOM);
readkey;
clrscr;
end;


procedure listado_por_enfermedad (VAR ARCH:T_ARCHIVO_ALUMNOS);
var
  pos,i:byte;
  x:t_Dato_alumnos;
begin
writeln('Ingrese la discapacidad a listar: ');
writeln('1- Problemas del habla y lenguaje ');
writeln('2- Dificultad para escribir ');
writeln('3- Dificultades de aprendizaje visual');
writeln('4- Memoria y otras dificultades del pensamiento ');
writeln('5- Destrezas sociales inadecuadas');
readln(pos);
clrscr;
MOSTRAR_ENCABEZADO_TABLA;
for i := 0 to filesize(arch)-1 do
 begin
  seek(arch,i);
  read(arch,x);

  if x.discapacidad[pos] then
   MUESTRA_REGISTRO_POR_TABLA(x);

 end;
readkey;
clrscr;
end;

{PROCEDURE MOSTRAR_ENCABEZADO_TABLA_ARCHIVO;
BEGIN
  GOTOXY(1, 1);
  TEXTCOLOR(LIGHTBLUE);
  WRITELN('LEGAJO':10, ' FECHA ':20, ' VALORACIONES ':10, ' VAL1':10, ' VAL2':10, ' VAL3':10, ' VAL4':10, ' VAL5':10 );
  WRITELN;
  TEXTCOLOR(WHITE);
END;        }


end.

