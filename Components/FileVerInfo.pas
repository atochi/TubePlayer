(*************************************************************************

  ファイルのバージョン情報を取得するコンポーネント　TFileVerInfo

  (C) Tiny Mouse
  2004.08.13

*************************************************************************)

unit FileVerInfo;

interface

uses
  Windows, SysUtils, Classes, Graphics, ShellApi;

type
  TFileVerInfo = class(TComponent)
  private
    FVerInfo: Pointer;
    FFileName: TFileName;
    FHasVerInfo: Boolean;
    {
    FLargeIcon: TIcon;
    FSmallIcon: TIcon;
    }
  protected
    procedure Loaded; override;
    procedure SetFileName(Value: TFileName);
    function GetVerInfo(Key: String): String;
    function GetLocaleCharsetID: String;
    function QueryValue(SubBlock: String): String;
    function GetCompanyName: String;
    function GetFileDescription: String;
    function GetFileVersion: String;
    function GetInternalName: String;
    function GetLegalCopyright: String;
    function GetLegalTrademarks: String;
    function GetOriginalFileName: String;
    function GetProductName: String;
    function GetProductVersion: String;
    function GetComments: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property HasVerInfo: Boolean read FHasVerInfo;
    property VerInfo[Key: String]: String read GetVerInfo;
    property CompanyName: String read GetCompanyName;
    property FileDescription: String read GetFileDescription;
    property FileVersion: String read GetFileVersion;
    property InternalName: String read GetInternalName;
    property LegalCopyright: String read GetLegalCopyright;
    property LegalTrademarks: String read GetLegalTrademarks;
    property OriginalFileName: String read GetOriginalFileName;
    property ProductName: String read GetProductName;
    property ProductVersion: String read GetProductVersion;
    property Comments: String read GetComments;
    {
    property LargeIcon: TIcon read FLargeIcon;
    property SmallIcon: TIcon read FSmallIcon;
    }
  published
    property FileName: TFileName read FFileName write SetFileName;
  end;

procedure Register;

implementation

uses Forms;

procedure Register;
begin
  RegisterComponents('Samples', [TFileVerInfo]);
end;

{************************************************************************}

constructor TFileVerInfo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FVerInfo := nil;
  FFileName := '';
  FHasVerInfo := False;
  {
  FLargeIcon := TIcon.Create;
  FSmallIcon := TIcon.Create;
  }
end;

destructor TFileVerInfo.Destroy;
begin
  {
  FLargeIcon.Free;
  FSmallIcon.Free;
  }
  if Assigned(FVerInfo) then
  begin
    FreeMem(FVerInfo);
    FVerInfo := nil;
  end;

  inherited Destroy;
end;

procedure TFileVerInfo.Loaded;
begin
  inherited Loaded;
  if (FFileName = '') and not (csDesigning in ComponentState) then
    SetFileName(Application.ExeName);
end;

procedure TFileVerInfo.SetFileName(Value: TFileName);
var
  VerInfoSize: DWORD;
  Handle: DWORD;
  //FileInfo: TSHFileInfo;
begin
  FFileName := Value;
  if Assigned(FVerInfo) then
  begin
    FreeMem(FVerInfo);
    FVerInfo := nil;
  end;

  FHasVerInfo := False;
  VerInfoSize := GetFileVersionInfoSize(PChar(FFileName), Handle);
  if VerInfoSize = 0 then
    Exit;
  GetMem(FVerInfo, VerInfoSize);
  if not GetFileVersionInfo(PChar(FFileName), Handle, VerInfoSize, FVerInfo) then
    Exit;
  FHasVerInfo := True;
  {
  SHGetFileInfo(PChar(FFileName), 0, FileInfo, SizeOf(FileInfo), SHGFI_ICON or SHGFI_LARGEICON);
  FLargeIcon.Handle := FileInfo.hIcon;
  SHGetFileInfo(PChar(FFileName), 0, FileInfo, SizeOf(FileInfo), SHGFI_ICON or SHGFI_SMALLICON);
  FSmallIcon.Handle := FileInfo.hIcon;
  }
end;

function TFileVerInfo.GetVerInfo(Key: String): String;
begin
  Result := QueryValue('\StringFileInfo\' + GetLocaleCharsetID + '\' + Key);
end;

function TFileVerInfo.GetLocaleCharsetID: String;
type
  TWordArray = array [0..1023] of Word;
  PWordArray = ^TWordArray;
var
  buf: PChar;
  size: UINT;
  n: Integer;
begin
  Result := '';
  if not Assigned(FVerInfo) then
    Exit;
  if not VerQueryValue(FVerInfo, PChar('\VarFileInfo\Translation'), Pointer(buf), size) then
    Exit;
  for n := size div 4 - 1 downto 0 do
  begin
    if (n = 0) or (PWordArray(buf) ^ [n * 2] = GetUserDefaultLangID) then
    begin
      Result := IntToHex(PWordArray(buf) ^ [n * 2 + 0], 4) +
                IntToHex(PWordArray(buf) ^ [n * 2 + 1], 4);
    end;
  end;
end;

function TFileVerInfo.QueryValue(SubBlock: String): String;
var
  buf: PChar;
  size: UINT;
begin
  Result := '';
  if not Assigned(FVerInfo) then
    Exit;
  if not VerQueryValue(FVerInfo, PChar(SubBlock), Pointer(buf), size) then
    Exit;
  Result := String(buf);
end;

function TFileVerInfo.GetCompanyName: String;
begin
  Result := GetVerInfo('CompanyName');
end;

function TFileVerInfo.GetFileDescription: String;
begin
  Result := GetVerInfo('FileDescription');
end;

function TFileVerInfo.GetFileVersion: String;
begin
  Result := GetVerInfo('FileVersion');
end;

function TFileVerInfo.GetInternalName: String;
begin
  Result := GetVerInfo('InternalName');
end;

function TFileVerInfo.GetLegalCopyright: String;
begin
  Result := GetVerInfo('LegalCopyright');
end;

function TFileVerInfo.GetLegalTrademarks: String;
begin
  Result := GetVerInfo('LegalTrademarks');
end;

function TFileVerInfo.GetOriginalFileName: String;
begin
  Result := GetVerInfo('OriginalFileName');
end;

function TFileVerInfo.GetProductName: String;
begin
  Result := GetVerInfo('ProductName');
end;

function TFileVerInfo.GetProductVersion: String;
begin
  Result := GetVerInfo('ProductVersion');
end;

function TFileVerInfo.GetComments: String;
begin
  Result := GetVerInfo('Comments');
end;

end.
