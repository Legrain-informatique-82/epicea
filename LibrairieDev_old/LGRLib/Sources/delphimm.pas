
{*******************************************************}
{                                                       }
{       Delphi Runtime Library                          }
{       Memory Manager Unit                             }
{                                                       }
{       Copyright (C) 1997 Borland International        }
{                                                       }
{*******************************************************}

library DelphiMM;

{$IMAGEBASE $41000000}


function GetAllocMemCount: Integer;
begin
  Result := AllocMemCount;
end;

function GetAllocMemSize: Integer;
begin
  Result := AllocMemSize;
end;

exports
  SysGetMem,
  SysFreeMem,
  SysReallocMem,
  GetHeapStatus,
  GetAllocMemCount,
  GetAllocMemSize;

begin
  IsMultiThread := True;
end.
