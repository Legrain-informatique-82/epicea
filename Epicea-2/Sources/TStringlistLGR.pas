unit TStringlistLGR;

interface
uses Classes;

type TStringlistLGR1 = class(TStringlist)
  private
  FList: PStringItemList;

  public
    destructor Destroy; override;
    function indexOfCol(const S: string;const Col:integer;Separator:char): integer;
    function FindCol(const S: string;const Col:integer; var Index: Integer;Separator:char): Boolean;
    procedure QuickSort(L, R: Integer; SCompare: TStringListSortCompare);
  procedure CustomSort(Compare: TStringListSortCompare);
  end;

implementation

uses lib_chaine;

procedure TStringlistLGR1.QuickSort(L, R: Integer; SCompare: TStringListSortCompare);
var
  I, J, P: Integer;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while SCompare(self, I, P) < 0 do
        Inc(I);
      while SCompare(self, J, P) > 0 do
        Dec(J);
      if I <= J then
      begin
         Exchange(I, J);
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(L, J, SCompare);
    L := I;
  until I >= R;
end;

procedure TStringlistLGR1.CustomSort(Compare: TStringListSortCompare);
begin
  if not Sorted and (self.Count > 1) then
  begin
    Changing;
    QuickSort(0, self.Count - 1, Compare);
    Changed;
  end;
end;




function TStringlistLGR1.indexOfCol(const S: string;const Col:integer;Separator:char): integer;
begin
if not Sorted then
begin
  for Result := 0 to GetCount - 1 do
    if CompareStrings(str_getstringelement(Get(Result),col,Separator), S) = 0 then Exit;
  Result := -1;
end
else
begin
   if not FindCol(S,col,result,Separator) then Result := -1;
end;
end;


function TStringlistLGR1.FindCol(const S: string;const Col:integer; var Index: Integer;Separator:char): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := GetCount - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := CompareStrings(str_getstringelement(FList^[I].FString,col,Separator), S);
    if C < 0 then L := I + 1 else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        if Duplicates <> dupAccept then L := I;
      end;
    end;
  end;
  Index := L;
end;


destructor TStringlistLGR1.Destroy;
begin
  inherited Destroy;
end;
end.
