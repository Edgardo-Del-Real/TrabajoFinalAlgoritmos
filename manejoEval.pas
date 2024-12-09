UNIT manejoEval;

{$CODEPAGE UTF8}

INTERFACE

USES
    crt, ARCHIVOEVAL, UNITARBOL,SysUtils ;

procedure CargarDatosEval (var x:t_dato_eval);
PROCEDURE PASAR_DATOS_EVAL (VAR ARCH: T_ARCHIVO_EVAL; VAR RAIZLEGAJO,RAIZFECHA:T_PUNT_ARBOL);
procedure DarAltaEval (var archivoEval:t_archivo_eval; var x:t_dato_eval);
procedure CargarAltaEval (var archivoEval:t_archivo_eval; var x:t_dato_eval);
procedure MuestraDatosEval(x:t_dato_eval);
procedure ConsultaEvaluacion(var raizlegajo: t_punt_arbol; var archivoEval: t_archivo_eval);
procedure modificarEval(var raizapynom, raizlegajo: t_punt_arbol; var archivoEval: t_archivo_eval);
function BuscarEvaluacion(var raizlegajo: t_punt_arbol; var archivoEval: t_archivo_eval; legajo: string; fecha: string): integer;

IMPLEMENTATION
PROCEDURE PASAR_DATOS_EVAL (VAR ARCH: T_ARCHIVO_EVAL; VAR RAIZLEGAJO,RAIZFECHA:T_PUNT_ARBOL);
VAR
  X: T_DATO_EVAL;
  I:BYTE;
  R:T_DATO_ARBOL;
  fecha:string;
BEGIN
  I:= 0;
  if FILESIZE (ARCH) >= 1 then
  begin
 WHILE NOT EOF(ARCH) DO
   BEGIN
     SEEK (ARCH, I);
     READ (ARCH, X);
     fecha:=(IntToStr(x.fecha_eval.anio))+(IntToStr(x.fecha_eval.mes))+(IntToStr(x.fecha_eval.dia));
     R.CLAVE:=fecha;
     R.POSARCH:= I;
     AGREGAR_ARBOL (RAIZFECHA,R);
     I:= I + 1;
   END;
 end;
END;


procedure CargarDatosEval (var x:t_dato_eval);
var
   i:byte;
begin
     clrscr;
     gotoxy(50,10);
     writeln('**DAR ALTA EVALUACIÓN**');
     textcolor(green);
     gotoxy(45,12);
     write('INGRESE NUMERO DE LEGAJO: ');
     textcolor(white);
     readln(x.num_legajo);
     textcolor(green);
     gotoxy(45,14);
     write('INGRESE DIA DE EVALUACIÓN: ');
     textcolor(white);
     readln(x.fecha_eval.dia);
     textcolor(green);
     gotoxy(45,16);
     write('INGRESE MES DE EVALUACIÓN: ');
     textcolor(white);
     readln(x.fecha_eval.mes);
     textcolor(green);
     gotoxy(45,18);
     write('INGRESE AÑO DE EVALUACIÓN: ');
     textcolor(white);
     readln(x.fecha_eval.anio);
     textcolor(red);
     gotoxy(45,20);
     writeln('INGRESE LAS VALORACIONES: ');
     for i:=1 to 5 do
       begin
         textcolor(green);
         gotoxy(45,22);
         write('Valoración ', i, ': ');
         textcolor(white);
         readln(x.valoracion[i]);
       end;
     clrscr;
end;

procedure MuestraDatosEval(x:t_dato_eval);
begin
    clrscr;
    writeln('DATOS ACTUALES DE LA EVALUACION:');
    writeln('Legajo: ', x.num_legajo);
    writeln('Fecha: ', x.fecha_eval.dia, '/', x.fecha_eval.mes, '/', x.fecha_eval.anio);
    writeln('Valoracion: ', x.valoracion[1], ' ', x.valoracion[2], ' ', x.valoracion[3], ' ', x.valoracion[4], ' ', x.valoracion[5]);
    writeln('Observaciones: ', x.obs);
    clrscr;
end;

procedure CargarAltaEval (var archivoEval:t_archivo_eval; var x:t_dato_eval);
begin
    seek(archivoEval, filesize(archivoEval));
    write(archivoEval, x);
end;

procedure DarAltaEval (var archivoEval:t_archivo_eval; var x:t_dato_eval);
var
    FinArch:cardinal;
begin
    CargarDatosEval(x);
    CargarAltaEval(archivoEval, x);
end;

function BuscarEvaluacion(var raizlegajo: t_punt_arbol; var archivoEval: t_archivo_eval; legajo: string; fecha: string): integer;
var
  pos,i: integer;
  x: t_dato_eval;
begin
    BuscarEvaluacion:=-1;
for i:=0 to fileSize(archivoEval)-1 do
  begin
  seek(archivoEval, i);
  read(archivoEval,x);
  if x.num_legajo = legajo then
    begin
    if (x.fecha_eval.dia = (StrToInt(Copy(fecha, 1, 2)))) and
       (x.fecha_eval.mes = (StrToInt(Copy(fecha, 4, 2)))) and
       (x.fecha_eval.anio = (StrToInt(Copy(fecha, 7, 4)))) then
      BuscarEvaluacion := i;
  end;
end;
end;

procedure ConsultaEvaluacion(var raizlegajo: t_punt_arbol; var archivoEval: t_archivo_eval);
var
  buscadoLegajo: string;
  buscadoFecha: string;
  pos: integer;
  x: t_dato_eval;
begin
  writeln('**CONSULTA EVALUACION**');
  write('INGRESE LEGAJO DEL ALUMNO: ');
  readln(buscadoLegajo);
  write('INGRESE FECHA DE LA EVALUACION (DD/MM/AAAA): ');
  readln(buscadoFecha);
  
  pos := BuscarEvaluacion(raizlegajo, archivoEval, buscadoLegajo, buscadoFecha);
  if pos = -1 then
    writeln('NO SE ENCUENTRA REGISTRO DE EVALUACION')
  else
  begin
    seek(archivoEval, pos);
    read(archivoEval, x);
    writeln('DATOS DE LA EVALUACION:');
    MuestraDatosEval(x);
  end;
end;



procedure modificarEval(var raizapynom, raizlegajo: t_punt_arbol; var archivoEval: t_archivo_eval);
var
  legajo, fecha: string;
  pos: integer;
  x: t_dato_eval;
  opcion,i: integer;
begin
  clrscr;
  gotoxy(50,10);
  writeln('**MODIFICAR EVALUACION**');
  textcolor(green);
  gotoxy(45,12);
  write('INGRESE LEGAJO: ');
  textcolor(white);
  readln(LEGAJO);
  textcolor(green);
  gotoxy(45,14);
  write('INGRESE FECHA DD/MM/AAAA: ');
  textcolor(white);
  readln(FECHA);
  POS := BuscarEvaluacion(raizlegajo,archivoEval,legajo,fecha);
  if pos = -1 then
    begin
    gotoxy(45,16);
    writeln('NO SE ENCUENTRA REGISTRO DE EVALUACION')
    end
  else
    begin
      seek(archivoEval, pos);
      read(archivoEval, x);

      MuestraDatosEval(x);

      gotoxy(45,16);
      writeln('INGRESE EL CAMPO A MODIFICAR DE LA EVALUACION:');
      textcolor(green);
      gotoxy(45,18);
      write('1- ');
      textcolor(white);
      writeln('FECHA DE LA EVALUACION (DD/MM/AAAA)');
      textcolor(green);
      gotoxy(45,20);
      write('2- ');
      textcolor(white);
      writeln('VALORACION (1-5)');
      textcolor(green);
      gotoxy(45,22);
      write('3- ');
      textcolor(white);
      writeln('OBSERVACIONES');
      textcolor(green);
      gotoxy(45,24);
      write('OPCION: ');
      readln(opcion);
    
    if (opcion < 1) or (opcion > 3) then
      writeln('OPCION INVALIDA')
    else
    begin
      case opcion of
        1:
        begin
          write('INGRESE LA NUEVA FECHA DE LA EVALUACION (DD/MM/AAAA): ');
          readln(x.fecha_eval.dia, x.fecha_eval.mes, x.fecha_eval.anio);
        end;
        2:
        begin
          write('INGRESE LA NUEVA VALORACION (1-5): ');
          for i:= 1 to 5 do
            readln(x.valoracion[i]);
        end;
        3:
        begin
          write('INGRESE LAS NUEVAS OBSERVACIONES: ');
          readln(x.obs);
        end;
      end;
      
      seek(archivoEval, pos);
      write(archivoEval, x);
      
      writeln('EVALUACION MODIFICADA CORRECTAMENTE');
    end;
  end;
  clrscr;
end;

 end.