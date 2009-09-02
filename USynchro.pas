unit USynchro;
(* “¯ŠúŠÖ˜A *)
(* Copyright (c) 2001,2002 Twiddle <hetareprog@hotmail.com> *)

(* ŽÀ‚Í—L‚é‚É‚Í—L‚é‚ç‚µ‚¢‚ª’¾–Ù  *)

interface

uses
  Windows;

const
  INFINITE      = Windows.INFINITE;
  WAIT_FAILED   = Windows.WAIT_FAILED;
  WAIT_OBJECT_0 = Windows.WAIT_OBJECT_0;


type
  (*-------------------------------------------------------*)
  {
  THogeCriticalSection = class(TObject)
  protected
    CRITICAL_SECTION: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Enter;
    procedure Leave;
  end;
  }
  (*-------------------------------------------------------*)
  THogeMutex = class(TObject)
  protected
    FHandle: THandle;
    FLastError: longword;
  public
    constructor Create(initialOwner: boolean = false; name: PChar = nil);
    destructor Destroy; override;
    function Wait(millisec: longword = INFINITE): longword;
    function Release: boolean;
    property handle: THandle read FHandle;
    property lastError: longword read FLastError;
  end;

  (*-------------------------------------------------------*)
  {
  THogeEvent = class(TObject)
  protected
    FHandle: THandle;
    FLastError: longword;
  public
    constructor Create(manualReset: boolean = false;
                       initialSignaled: boolean = false;
                       name: PChar = nil);
    destructor Destroy; override;
    function Wait(millisec: longword = INFINITE): longword;
    function SetEvent: boolean;
    function ResetEvent: boolean;
    property handle: THandle read FHandle;
    property lastError: longword read FLastError;
  end;
  }

(*=======================================================*)
implementation
(*=======================================================*)
{
constructor THogeCriticalSection.Create;
begin
  inherited Create;
  InitializeCriticalSection(CRITICAL_SECTION);
end;

destructor THogeCriticalSection.Destroy;
begin
  DeleteCriticalSection(CRITICAL_SECTION);
  inherited;
end;

procedure THogeCriticalSection.Enter;
begin
  EnterCriticalSection(CRITICAL_SECTION);
end;

procedure THogeCriticalSection.Leave;
begin
  LeaveCriticalSection(CRITICAL_SECTION);
end;
}
(*=======================================================*)
constructor THogeMutex.Create(initialOwner: boolean; name: PChar);
begin
  inherited Create;
  FHandle := CreateMutex(nil, initialOwner, name);
  FLastError := GetLastError;
end;

destructor THogeMutex.Destroy;
begin
  if FHandle <> 0 then
    CloseHandle(FHandle);
end;

function THogeMutex.Wait(millisec: longword): longword;
begin
  result := WaitForSingleObject(FHandle, millisec);
  FLastError := GetLastError;
end;

function THogeMutex.Release: boolean;
begin
  result := boolean(ReleaseMutex(FHandle));
  FLastError := GetLastError;
end;


(*=======================================================*)
{
constructor THogeEvent.Create(manualReset: boolean;
                              initialSignaled: boolean;
                              name: PChar);
begin
  inherited Create;
  FHandle := CreateEvent(nil, manualReset, initialSignaled, name);
  FLastError := GetLastError;
end;

destructor THogeEvent.Destroy;
begin
  if FHandle <> 0 then
    CloseHandle(FHandle);
end;

function THogeEvent.Wait(millisec: longword): longword;
begin
  result := WaitForSingleObject(FHandle, millisec);
  FLastError := GetLastError;
end;

function THogeEvent.SetEvent: boolean;
begin
  result := Windows.SetEvent(FHandle);
  FLastError := GetLastError;
end;

function THogeEvent.ResetEvent:boolean;
begin
  result := boolean(Windows.ResetEvent(FHandle));
  FLastError := GetLastError;
end;
}

end.
