unit CommonUtils;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Types;

{ Variant系 }
function VarToWStr(const V: Variant): WideString;
function VarToInt(const V: Variant): Integer;
function VarToDouble(const V: Variant): Double;

{ DateTime系 }
function YouTubeDateToDateTimeStr(YouTubeDate: string): string;

{ File系 }
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

// YouTubeAPIの日付型をDelphiの日付形式に整形(GMT)
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

// URLからファイル名を抽出
function ExtractURIFile(const URI: string): string;
begin
  Result := Copy(URI, LastDelimiter('/', URI) + 1, MaxInt);
end;

// URLからファイル名を削除「/」付き
function ExtractURIDir(const URI: string): string;
begin
  Result := Copy(URI, 1, LastDelimiter('/', URI));
end;

end.
