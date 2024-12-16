unit VALIDACIONES;

{$CODEPAGE UTF8}

interface

uses
CRT, SYSUTILS;
function EsFechaValida(FechaStr: string): Boolean;
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




end.
