  unit estadisticas;

  {$CODEPAGE UTF8}

  interface

  uses
    Crt, SysUtils, ARCHIVOEVAL;

  procedure evaluacionesPorFecha(var ARCHIVOEVAL:T_ARCHIVO_EVAL);
  FUNCTION CONVERTIR_FECHA(X:STRING):INTEGER;
  function cantidad_evaluaciones_por_fecha (var archivoEval:t_archivo_eval; FF,FI:INTEGER):integer;
  PROCEDURE compararValoracionesPorFecha(var archivoEval: T_ARCHIVO_EVAL);

  implementation
  FUNCTION CONVERTIR_FECHA(X:STRING):INTEGER; //CONVIERTE LAS FECHAS DE FORMATO DD/MM/AAAA A N° DE DIAS
    VAR D,M,A:INTEGER;
    BEGIN
      D:= STRTOINT(COPY(X,1,2));
      M:= STRTOINT(COPY(X,4,2));
      A:= STRTOINT(COPY(X,7,4));
      CONVERTIR_FECHA:= ((A*365)+(M*30)+D);
    END;

  function cantidad_evaluaciones_por_fecha (var archivoEval:t_archivo_eval; FF,FI:INTEGER):integer;
  var
     x:t_dato_eval;
     cont,fechaendias,I:integer;
     fecha:string;
     begin
       cont:=0;
        for i:=0 to FileSize(archivoEval)-1 do
            begin
            seek(archivoEval,i);
            read(archivoEval,x);
             FECHA:=(INTTOSTR(X.FECHA_EVAL.DIA))+'/'+(INTTOSTR(X.FECHA_EVAL.MES))+'/'+(INTTOSTR(X.FECHA_EVAL.ANIO));
             FechaEnDias:=CONVERTIR_FECHA(FECHA);
             IF (FECHAENDIAS>=FI) AND (FF>=FECHAENDIAS) THEN
                cont:=cont+1;

     end;
        cantidad_evaluaciones_por_fecha:=cont;
     end;

  procedure evaluacionesPorFecha(var ARCHIVOEVAL:T_ARCHIVO_EVAL);
  var
     cont:integer;
     fecha_inicio,fecha_fin:string;
     FI,FF:INTEGER;
     begin
       writeln('Ingrese fecha de inicio DD/MM/AAAA');
       readln(fecha_inicio);
       FI:=CONVERTIR_FECHA(Fecha_inicio);
       writeln('Ingrese fecha de fin DD/MM/AAAA');
       readln(fecha_fin);
       FF:= CONVERTIR_FECHA(Fecha_fin);
       cont:=CANTIDAD_EVALUACIONES_POR_FECHA(ARCHIVOEVAL,FF,FI);
       writeln('La cantidad de evaluaciones realizadadas entre: ', fecha_inicio, ' y ', fecha_fin,' fueron de: ', cont);

     end;

  FUNCTION ObtenerNombreDiscapacidad(valoracion: INTEGER): STRING;
  BEGIN
    CASE valoracion OF
      1: ObtenerNombreDiscapacidad := 'Problemas del habla y lenguaje';
      2: ObtenerNombreDiscapacidad := 'Dificultad para escribir';
      3: ObtenerNombreDiscapacidad := 'Dificultades de aprendizaje visual';
      4: ObtenerNombreDiscapacidad := 'Memoria y otras dificultades del pensamiento';
      5: ObtenerNombreDiscapacidad := 'Destrezas sociales inadecuadas';
  END;
  end;

  PROCEDURE compararValoracionesPorFecha(var archivoEval: T_ARCHIVO_EVAL);
VAR
  sumatorias: ARRAY[1..5] OF INTEGER;
  fechaInicioDias, fechaFinDias, i, j, fechaEnDias, maxSumatoria, maxValoracion: INTEGER;
  x: T_DATO_EVAL;
  fechaInicio, fechaFin, fecha,maxDiscapacidad: STRING ;
BEGIN
  maxSumatoria := 0;
  maxValoracion := 0;

  writeln('Ingrese fecha de inicio DD/MM/AAAA');
  readln(fechaInicio);
  writeln('Ingrese fecha de fin DD/MM/AAAA');
  readln(fechaFin);

  fechaInicioDias := CONVERTIR_FECHA(fechaInicio);
  fechaFinDias := CONVERTIR_FECHA(fechaFin);

  FOR j := 1 TO 5 DO
    sumatorias[j] := 0;

  FOR i := 0 TO FileSize(archivoEval) - 1 DO
  BEGIN
    SEEK(archivoEval, i);
    READ(archivoEval, x);

    fecha := (INTTOSTR(x.FECHA_EVAL.DIA)) + '/' + (INTTOSTR(x.FECHA_EVAL.MES)) + '/' + (INTTOSTR(x.FECHA_EVAL.ANIO));
    fechaEnDias := CONVERTIR_FECHA(fecha);

    IF (fechaEnDias >= fechaInicioDias) AND (fechaEnDias <= fechaFinDias) THEN
    BEGIN
      FOR j := 1 TO 5 DO
        sumatorias[j] := sumatorias[j] + x.VALORACION[j];
    END;
  END;

  FOR j := 1 TO 5 DO       // Encontrar la valoración con la mayor sumatoria
  BEGIN
    IF sumatorias[j] > maxSumatoria THEN
    BEGIN
      maxSumatoria := sumatorias[j];
      maxValoracion := j;
    END;
  END;

  WRITELN('La valoración con la mayor sumatoria entre ', fechaInicio, ' y ', fechaFin, ' es la discapacidad: ', ObtenerNombreDiscapacidad(maxValoracion) , ' con una sumatoria de ', maxSumatoria);
END;

  end.
