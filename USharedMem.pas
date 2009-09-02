unit USharedMem;
(* ã§óLÉÅÉÇÉä *)
(* Copyright (c) 2002 Twiddle <hetareprog@hotmail.com> *)

interface

uses
  SysUtils, Windows;

type
  (*-------------------------------------------------------*)
  THogeSharedMem = class(TObject)
  protected
    FMemory: Pointer;
    FHandle: Cardinal;
    FSize: Cardinal;
  public
    constructor Create(const name: string; size: Cardinal);
    destructor Destroy; override;
    property Memory: Pointer read FMemory;
    property Handle: Cardinal read FHandle;
    property Size: Cardinal read FSize;
  end;


(*=======================================================*)
implementation
(*=======================================================*)
constructor THogeSharedMem.Create(const name: string; size: Cardinal);
begin
  inherited Create;
  FSize := size;
  FMemory := nil;
  FHandle := CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0, size, PChar(name));
  if FHandle = 0 then
    raise EOSError.Create('CreateFileMapping');
  FMemory := MapViewOfFile(FHandle, FILE_MAP_ALL_ACCESS, 0, 0, size);
  if FMemory = nil then
    raise EOSError.Create('MapViewOfFile');
end;

destructor THogeSharedMem.Destroy;
begin
  if FMemory <> nil then
    UnmapViewOfFile(FMemory);
  if FHandle <> 0 then
    CloseHandle(FHandle);
  inherited;
end;


(*=======================================================*)


end.
