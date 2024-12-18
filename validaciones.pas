unit VALIDACIONES;

{$CODEPAGE UTF8}

interface

uses
CRT, SYSUTILS;
function EsFechaValida(FechaStr: string): Boolean;
function EsCadena(input: string): boolean;
//PROCEDURE VALIDACION_CLAVE(VAR RESPUESTA,BUSCADO: STRING; VAR POS: INTEGER;RAIZLEGAJO, RAIZAPYNOM: T_PUNT_ARBOL);

implementation

function EsFechaValida(FechaStr: string): Boolean;
var
  Fecha: TDateTime;
  FechaActual: TDateTime;
begin
  FechaActual := Date;
  if TryStrToDate(FechaStr, Fecha) then
  begin
    if Fecha > FechaActual then
      Result := False
    else
      Result := True;
  end
  else
    Result := False;
end;

function EsCadena(input: string): boolean;
var
  i: integer;
  stop: boolean;
begin
  EsCadena := true;
  stop := false;
  i := 1;
  while( i <= Length(input)) and (not stop) do
  begin
    if not (UPCASE(input[i]) in ['A'..'Z', ' ']) then
    begin
      EsCadena := false;
      stop := true;
    end;
    inc(i);
  end;
end;

// De acá para abajo es de validaciones de otros proyectos

// function ValidDNI(dni: string): Boolean;
// var
//   i: Integer;
// begin
//   ValidDNI := False;  { Inicia asumiendo que el DNI no es válido }

//   { Verifica que la longitud del DNI sea 8 caracteres }
//   if Length(dni) <> 8 then
//        else
//        begin
//   { Verifica que todos los caracteres sean dígitos }
//   for i := 1 to Length(dni) do
//   begin
//     if not IsDigit(dni[i]) then
//       Exit;
//   end;
//   { Si pasa todas las verificaciones, el DNI es válido }
//   ValidDNI := True;
//        end;
// end;

// function IsDigit(ch: char): Boolean;
// begin
//   IsDigit := (ch >= '0') and (ch <= '9');
// end;


// FUNCTION mayus(S: string): string;
// VAR
// i: integer;
// BEGIN
// IF Length(S) > 0 THEN
// S[1] := UpCase(S[1]);
// FOR i := 2 TO Length(S) DO
// IF S[i] <> ' ' THEN
//   S[i] := LowerCase(S[i])
// ELSE
//   // Hace que la primera letra de la palabra sea en Mayuscula
//   IF (i + 1 <= Length(S)) AND (S[i + 1] <> ' ') THEN
//     S[i + 1] := UpCase(S[i + 1]);
// mayus := S;
// END;

// procedure validar_valor(var a:string;minimo:longint;maximo:longint;var retorno:longint;msg:string);
// var aux,i:integer; r:longint;
// begin
//   repeat
//   clrscr;
//   writeln(msg);
//   readln(a);
//   //VALIDA SI EL DATO ES UN NUMERO
//   val(a,r,i);
//   //SI EL DATO ES UN NUMERO ENTONCES VALIDA SI ESTA DENTRO DEL RANGO
//   clrscr;
//   if i=0 then
//   begin
//    if (r>=minimo) and (r<=maximo) then
//      begin
//        retorno:=r ;
//        aux:=-1;
//      end
//   end
//   else
//     begin
//        aux:=0;
//     end;

//    clrscr;
//    write(msg);

//    until(aux=-1);
//    clrscr;
//   end;

// procedure LongIntToString(numero: LongInt; var cadena: String);
// begin
//   Str(numero, cadena);
// end;

// procedure validar_caracter(a:char;valido1:char;valido2:char; var retorno:char;msg:string);
// var
// r:real;
// i:integer;
// aux:integer;
// begin
//   aux:=0;

//   repeat
//   a:=readkey;
//   //VALIDA SI EL DATO ES UN CARACTER
//   val(a,r,i);
//   if(i<>0) then
//   begin
//   //SI EL DATO ES UN CARACTER ENTONCES COMPARA EL DATO CON LOS VALIDOS INGRESADOS
//   if (upcase(a)=valido1) or (upcase(a)=valido2) then
//   begin
//   //writeln('uno');
//   retorno:=a;
//   aux:=-1;
//   end;
//   clrscr;
//   writeln('seleccione "',valido1,'" o "',valido2,'" ');
//   writeln(msg);
//   end
//   else
//   begin
//   //writeln('dos');
//   clrscr;
//   writeln('seleccione "',valido1,'" o "',valido2,'" ');
//   writeln(msg);
//   aux:=0;
//   end;
//   until(aux=-1);
//   //writeln('tres');
//   //readkey;
//   clrscr;
// end;

// procedure validar_string_caracter(a:string;var retorno:string;msg:string);
// var
//   r:real;
//   i,x,y:integer;
//   aux:integer;

// begin
//   aux:=0;

//   repeat

//   {clrscr;}
//   {gotoxy(0,y-1);}
//   //DelLine;
//   write(msg);
//   x:=WhereX;
//   y:=WhereY;
//   readln(a);

//   //VALIDA SI EL DATO ES STRING
//   val(a,r,i);
//   if(i<>0) then
//   begin
//   retorno:=a;
//   aux:=-1;
//   end

//   else
//   begin
//   {clrscr;}
//   //write(msg);
//   gotoxy(1,y);
//   clreol;
//   aux:=0;
//   gotoxy(1,y);
//   clreol;
//   end;
//   if (a='') then
//   begin
//   gotoxy(1,y);
//   clreol;
//   end;
//   until(aux=-1) and (a<>'');
//   //readkey;
//   //clrscr;
// end;

// procedure validar_convertir(var a:string;minimo:longint;maximo:longint;var retorno:string;msg:string);
// var ret:longint;
// begin
//   validar_valor(a,minimo,maximo,ret,msg);
//   LongIntToString(ret,a);
//   retorno:=a;

// end;

// procedure validar_string_numerico(var a:string;var retorno:string;msg:string);
// var r:real; i:integer; aux,x,y:integer;

// begin
//   aux:=0;
//   repeat
//   //clrscr;
//   write(msg);
//   x:=WhereX;
//   y:=WhereY;
//   readln(a);

//   val(a,r,i);
//   if(i=0) then
//   begin
//   retorno:=a;
//   aux:=-1;
//   end

//   else
//   begin
//   //clrscr;
//   //write(msg);
//   gotoxy(1,y);
//   DelLine;
//   aux:=0;
//   end;

//   until(aux=-1);
//   //readkey;
//   //clrscr;
// end;

// procedure validar_cadena(var str: string; caracter: Char;var retorno:string;msg:string);
// var
//   i,x,y: Integer;
//   encontrado: Boolean;
// begin
//   repeat
//   //clrscr;
//   write(msg);
//   x:=WhereX;
//   y:=WhereY;
//   readln(str);
//   encontrado := False;

//   // Recorrer el string
//   for i := 1 to Length(str) do
//   begin
//     // Verificar si el carácter actual es igual al carácter buscado
//     if str[i] = caracter then
//     begin
//       encontrado := True;
//       retorno:=str;
//     end;
//   end;
//   if encontrado=false then
//   begin
//   gotoxy(1,y);
//   DelLine;
//   end;
//   until encontrado=true;
//    //clrscr;
// end;

// procedure validar_fecha(fechas:fecha;var dia,mes,anio:integer;msg:string);
// var
//   r1,r2,r3,x,y,x2,y2:integer;
//   aux:real;
//   i1,i2,i3:integer;
//   dia_aux,mes_aux,anio_aux:string;
// begin

//  repeat
//  aux:=1;
//  repeat
//  x:=Wherex;
//  y:=WhereY;
//  writeln(msg);
//  writeln('dia');
//  readln(dia_aux);
//  val(dia_aux,r1,i1);
//  writeln('mes');
//  readln(mes_aux);
//  val(mes_aux,r2,i2);
//  writeln('anio');
//  readln(anio_aux);
//  val(anio_aux,r3,i3);
//  //clrscr;
//  gotoxy(1,y);
//  DelLine;
//  //gotoxy(1,y+1);
//  DelLine;
//  //gotoxy(1,y+2);
//  DelLine;
//  //gotoxy(1,y+3);
//  DelLine;
//  //gotoxy(1,y+4);
//  DelLine;
//  //gotoxy(1,y+5);
//  DelLine;
//  //gotoxy(1,y+6);
//  DelLine;
//  //if (i1<>0 or i2<>0 or i3<>0) then

//  until (i1=0) and (i2=0) and (i3=0);
//  {x2:=WhereX;
//  y2:=WhereY;
//  gotoxy(1,y-1);
//  DelLine;
//  gotoxy(x2,y2);}

//  dia:=r1;
//  mes:=r2;
//  anio:=r3;
//  begin
//  if (anio>fechas.anio) then
//      aux:=2
//  else
//    if (anio=fechas.anio) then
//       begin
//       if (mes=fechas.mes) then
//          begin
//          if (dia>fechas.dia) then
//             aux:=2
//          end
//       else
//           if (mes>fechas.mes)then
//           begin
//           aux:=2
//           end;
//       end;
// end;

//  if mes>12 then
//    aux:=2;

//  if mes in [1,3,5,7,8,10,12]  then
//       begin
//     if dia>31 then
//           aux:=2;
//        end;
//  if mes in [4,6,9,11] then
//        begin
//        if dia>30 then
//            aux:=2;
//        end;

//  if mes=2 then
//      begin
//       if dia>29 then
//      aux:=2;
//       end;


//  until (aux=1);
//  //limpiar todo y mostrar bien


// end;

// procedure validar_clave(clave:string;var retorno:integer);
// var
//   r:real;
//   i:integer;
// begin

//  val(clave,r,i);

//  if (i=0) then
//  retorno:=i
//  else
//  retorno:=i;
// end;

// function EsCadena(input: string): boolean;
// var
//   i: integer;
// begin
//   // Verificar si todos los caracteres son letras o espacios
//   for i := 1 to Length(input) do
//   begin
//     if not (input[i] in ['A'..'Z', 'a'..'z', ' ']) then
//     begin
//       EsCadena := false;
//       Exit;
//     end;
//   end;
//   EsCadena := true;
// end;

// function EsNumero(input: string): boolean;
// var
//   i: integer;
// begin
//   // Verificar si todos los caracteres son dígitos
//   for i := 1 to Length(input) do
//   begin
//     if not (input[i] in ['0'..'9']) then
//     begin
//       EsNumero := false;
//       Exit;
//     end;
//   end;
//   EsNumero := true;
// end;

end.
