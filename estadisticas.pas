  unit estadisticas;

  {$CODEPAGE UTF8}

  interface

  uses
    Crt, SysUtils, ARCHIVOEVAL;

  procedure evaluacionesPorFecha(var ARCHIVOEVAL:T_ARCHIVO_EVAL);
  FUNCTION CONVERTIR_FECHA(X:STRING):INTEGER;
  function cantidad_evaluaciones_por_fecha (var archivoEval:t_archivo_eval; FF,FI:INTEGER):integer;

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

  end.

