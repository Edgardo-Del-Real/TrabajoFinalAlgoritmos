UNIT manejoEval;

{$CODEPAGE UTF8}

INTERFACE

USES
    crt, ARCHIVOEVAL, UNITARBOL;

procedure CargarDatosEval (var x:t_dato_eval);
PROCEDURE PASAR_DATOS (VAR ARCH: T_ARCHIVO_eval; VAR RAIZLEGAJO,RAIZAPYNOM:T_PUNT_ARBOL);
procedure CargarAltaEval (var archivoEval:t_archivo_eval; var x:t_dato_eval);
procedure MuestraDatosEval(x:t_dato_eval);
procedure ConsultaEvaluacion(var raizlegajo: t_punt_arbol; var archivoEval: t_archivo_eval);
procedure modificarEval(var raizapynom, raizlegajo: t_punt_arbol; var archivoEval: t_archivo_eval);

IMPLEMENTATION

procedure CargarDatosEval (var x:t_dato_eval);
begin
    readln(x.num_legajo);
    readln(x.fecha_eval.dia);
    readln(x.fecha_eval.mes);
    readln(x.fecha_eval.anio);
    readln(x.valoracion[1]);
    readln(x.valoracion[2]);
    readln(x.valoracion[3]);
    readln(x.valoracion[4]);
    readln(x.valoracion[5]);
    readln(x.obs);
end;

procedure MuestraDatosEval(x:t_dato_eval);
begin
    writeln('Legajo: ', x.num_legajo);
    writeln('Fecha: ', x.fecha_eval.dia, '/', x.fecha_eval.mes, '/', x.fecha_eval.anio);
    writeln('Valoracion: ', x.valoracion[1], ' ', x.valoracion[2], ' ', x.valoracion[3], ' ', x.valoracion[4], ' ', x.valoracion[5]);
    writeln('Observaciones: ', x.obs);
end;

procedure CargarAltaEval (var archivoEval:t_archivo_eval; var x:t_dato_eval);
begin
    seek(archivoEval, filesize(archivoEval));
    write(archivoEval, x);
end;

procedure DarAltaAlumno (var archivoEval:t_archivo_eval; var x:t_dato_eval);
var
    FinArch:cardinal;
begin
    writeln('****DAR ALTA ALUMNO****');
    CargarDatosEval(x);
    CargarAltaEval(archivoEval, x);
end;

procedure ConsultaEvaluacion(var raizlegajo: t_punt_arbol; var archivoEval: t_archivo_eval);
var
  buscadoLegajo: string;
  buscadoFecha: string;
  pos: integer;
  x: t_dato_eval;
begin
  writeln('****CONSULTA EVALUACION****');
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

function BuscarEvaluacion(var raizlegajo: t_punt_arbol; var archivoEval: t_archivo_eval; legajo: string; fecha: string): integer;
var
  pos: integer;
  x: t_dato_eval;
begin
  pos := Preorden(raizlegajo, legajo);
  if pos = -1 then
    BuscarEvaluacion := -1
  else
  begin
    seek(archivoEval, pos);
    read(archivoEval, x);
    if (x.fecha_eval.dia = StrToInt(Copy(fecha, 1, 2))) and
       (x.fecha_eval.mes = StrToInt(Copy(fecha, 4, 2))) and
       (x.fecha_eval.anio = StrToInt(Copy(fecha, 7, 4))) then
      BuscarEvaluacion := pos
    else
      BuscarEvaluacion := -1;
  end;
end;

procedure modificarEval(var raizapynom, raizlegajo: t_punt_arbol; var archivoEval: t_archivo_eval);
var
  buscado: string;
  pos: integer;
  x: t_dato_eval;
  opcion: integer;
begin
  writeln('****MODIFICAR EVALUACION****');
  write('INGRESE LEGAJO O NOMBRE DEL ALUMNO: ');
  readln(buscado);
  pos := Preorden(raizlegajo, buscado);
  if pos = -1 then
    POS := PREORDEN(raizapynom, buscado);
  
  if pos = -1 then
    writeln('NO SE ENCUENTRA REGISTRO DE EVALUACION')
  else
  begin
    seek(archivoEval, pos);
    read(archivoEval, x);

    writeln('DATOS ACTUALES DE LA EVALUACION:');
    MuestraDatosEval(x);
      
    writeln('INGRESE EL CAMPO A MODIFICAR DE LA EVALUACION:');
    writeln('1- FECHA DE LA EVALUACION (DD/MM/AAAA)');
    writeln('2- VALORACION (1-5)');
    writeln('3- OBSERVACIONES');
    write('OPCION: ');
    readln(opcion);
    
    if opcion < 1 or opcion > 3 then
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
end;



