unit JMemory;

interface

uses
  Windows;

type

  DWORDLONG       = int64;
  _MEMORYSTATUSEX = packed record
    dwLength                : DWORD;
    dwMemoryLoad            : DWORD;
    ullTotalPhys            : DWORDLONG;
    ullAvailPhys            : DWORDLONG;
    ullTotalPageFile        : DWORDLONG;
    ullAvailPageFile        : DWORDLONG;
    ullTotalVirtual         : DWORDLONG;
    ullAvailVirtual         : DWORDLONG;
    ullAvailExtendedVirtual : DWORDLONG;
  end;
  MEMORYSTATUSEX   = _MEMORYSTATUSEX;
  LPMEMORYSTATUSEX = ^_MEMORYSTATUSEX;

  TGlobalMemoryStatusEx = function(const ApMemoryStatusEx : LPMEMORYSTATUSEX) : Bool; stdcall;

//GlobalMemoryStatusEx 関数へのポインタ
var
  GlobalMemoryStatusEx: TGlobalMemoryStatusEx = nil;

// 外部呼び出し用 HtmlHelp 関数の宣言
function GlobalMemoryStatusNT(const ApMemoryStatusEx : LPMEMORYSTATUSEX) : Bool;

implementation

var
  hkernel32: THandle = 0;

function GlobalMemoryStatusNT(const ApMemoryStatusEx : LPMEMORYSTATUSEX) : Bool;
begin
  Result := false;
  if Assigned(GlobalMemoryStatusEx) then
  begin
    Result := GlobalMemoryStatusEx(ApMemoryStatusEx);
  end;
end;

initialization
begin
  hkernel32 := LoadLibrary('kernel32.dll');
  if (hkernel32 <> 0) then
    try
      GlobalMemoryStatusEx := GetProcAddress(hkernel32, 'GlobalMemoryStatusEx');
    except
      GlobalMemoryStatusEx := nil;
    end;
end;

finalization
begin
  if (hkernel32 <> 0) then
  begin
    FreeLibrary(hkernel32);
    hkernel32 := 0;
  end;
end;

end.
