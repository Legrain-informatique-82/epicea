{***************************************************************
 *
 * Unit Name: RB_Librairie
 * Purpose  :
 * Author   :  Blanchard
 * History  :
 *
 ****************************************************************}

unit RB_Librairie;

interface
function Min(Val1, Val2 : Currency) : Currency;
function Max(Val1, Val2 : Currency) : Currency;

implementation

function Min(Val1, Val2 : Currency) : Currency;
begin
   if Val1 > Val2 then Result := Val2
   else Result := Val1;
end;

function Max(Val1, Val2 : Currency) : Currency;
begin
   if Val1 > Val2 then Result := Val1
   else Result := Val2;
end;

end.
