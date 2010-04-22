unit CommonUtils;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Types;

{ Variant�n }
function VarToWStr(const V: Variant): WideString;
function VarToInt(const V: Variant): Integer;
function VarToDouble(const V: Variant): Double;

{ DateTime�n }
function YouTubeDateToDateTimeStr(YouTubeDate: string): string;

{ File�n }
function ExtractURIFile(const URI: string): string;
function ExtractURIDir(const URI: string): string;


implementation

uses
  StrSub;

function VarToWStr(const V: Variant): WideString;
begin
  if not VarIsNull(V) then
    Result := V
  else
    Result := '';
end;

function VarToInt(const V: Variant): Integer;
begin
  if not VarIsNull(V) then
    Result := V
  else
    Result := 0;
end;

function VarToDouble(const V: Variant): Double;
begin
  if not VarIsNull(V) then
    Result := V
  else
    Result := 0;
end;

// YouTubeAPI�̓��t�^��Delphi�̓��t�`���ɐ��`(GMT)
function YouTubeDateToDateTimeStr(YouTubeDate: string): string;
var
  p: Integer;
begin
  Result := CustomStringReplace(YouTubeDate, '-', '/', false);
  Result := CustomStringReplace(Result, 'T', ' ', false);
  p := Pos('.', Result);
  if p > 1 then
    Result := Copy(Result, 1, p - 1);
end;

// URL����t�@�C�����𒊏o
function ExtractURIFile(const URI: string): string;
begin
  Result := Copy(URI, LastDelimiter('/', URI) + 1, MaxInt);
end;

// URL����t�@�C�������폜�u/�v�t��
function ExtractURIDir(const URI: string): string;
begin
  Result := Copy(URI, 1, LastDelimiter('/', URI));
end;

end.
