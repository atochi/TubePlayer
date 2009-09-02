unit StrSub;
(* 文字列サブルーチン *)
(* OpenJane and Delphi-MLの記事69334参考 *)

interface

uses
  SysUtils, Classes, Windows;

type

  TPSStream = class(TStringStream)
  public
    procedure SaveToFile(const fileName: string);
    procedure LoadFromFile(const fileName: string);
  end;

function HexToInt(const AString: string): Integer;
function StrUnify(const AString: string): string;
  
function StartWith(const substr: string;
                   const str: string;
                   offset: integer): boolean;

function FindPos(const substr: string;
                 const str: string;
                 offset: integer;
                 limit: integer = 0): integer;

function StrPosEx(StrStart, StrEnd, SubstrStart, SubstrEnd: PChar): PChar;
function AnsiStrPosEx(StrStart, StrEnd, SubstrStart, SubstrEnd: PChar): PChar;
function ReplaceString(const S: string;
                       const OldPattern: string;
                       const NewPattern: string): string;

function IgnoCaseReplaceString(const S: string;
                               const OldPattern: string;
                               const NewPattern: string): string;

function CustomStringReplace(const S: string; const
                             OldPattern: string;
                             const  NewPattern: string;
                             IgnoreCase : Boolean = False): String; overload;

procedure CustomStringReplace(var S : TStringList;
                              const OldPattern: string;
                              const  NewPattern: string;
                              IgnoreCase : Boolean = False); overload;
function GetBetweenText(const AString, Aleftstr, Arightstr: string): string;

implementation

(* ファイル保存 *)
procedure TPSStream.SaveToFile(const fileName: string);
var
  fs: TFileStream;
begin
  fs := TFileStream.Create(fileName, fmCreate);
  Position := 0;
  fs.CopyFrom(Self, Size);
  fs.Free;
end;

(* ファイル書出 *)
procedure TPSStream.LoadFromFile(const fileName: string);
var
  fs: TFileStream;
begin
  fs := TFileStream.Create(fileName, fmOpenRead);
  CopyFrom(fs, fs.Size);
  fs.Free;
end;

function HexToInt(const AString: string): Integer;
var
  i: integer;
  temp: int64;
begin
  temp := 0;
  for i := 1 to length(AString) do
  begin
    case AString[i] of
    '0'..'9': temp := temp * 16 + Ord(AString[i]) - Ord('0');
    'A'..'F': temp := temp * 16 + Ord(AString[i]) - Ord('A') + 10;
    'a'..'f': temp := temp * 16 + Ord(AString[i]) - Ord('a') + 10;
    else break;
    end;
  end;

  result := Integer(temp);
end;

//文字の統一(半角・カタカナ(コメントアウト)・大文字に)
function StrUnify(const AString: string): string;
var
  pstr: PChar;
  len: Integer;
begin
  len := Length(AString) + 1;
  pstr := StrAlloc(len);
  LCMapString($411, LCMAP_HALFWIDTH(* or LCMAP_KATAKANA*), PChar(AString),
    -1, pstr, len);
  LCMapString($411, LCMAP_UPPERCASE, pstr, -1, pstr, len);
  result := pstr;
  StrDispose(pstr);
end;

function StartWith(const substr: string;
                   const str: string;
                   offset: integer): boolean;
var
  index, lenSub, len: integer;
begin
  lenSub := Length(substr);
  len := Length(str);
  if (len - offset) < lenSub then
  begin
    result := False;
    exit;
  end;
  Dec(offset);
  for index := 1 to lenSub do
  begin
    if substr[index] <> str[offset + index] then
    begin
      result := False;
      exit;
    end;
  end;
  result := True;
end;

function FindPos(const substr: string;
                 const str: string;
                 offset: integer;
                 limit: integer): integer;
var
  index: integer;
  off: integer;
  len, lenSub: integer;
label NEXT;
begin
  lenSub := Length(substr);
  if (0 < limit) and (limit <= Length(str) - lenSub + 1) then
    len := limit
  else
    len := Length(str) - lenSub + 1;
  for index := offset to len do begin
    if (str[index] = substr[1]) then begin
      for off := 2 to lenSub do begin
        if (str[index + off -1] <> substr[off]) then
          goto NEXT;
      end;
      result := index;
      Exit;
    end;
    NEXT:
  end;
  result := 0;
end;

//ポインター＆アセンブラによる高速ポス
function StrPosEx(StrStart, StrEnd, SubstrStart, SubstrEnd: PChar): PChar;
asm
    PUSH    EBX
    PUSH    ESI
    PUSH    EDI

    MOV    ESI,ECX        { Point ESI to substr                   }
    MOV    EDI,EAX        { Point EDI to s                        }

    MOV    ECX,EDX        { ECX = search length                   }
    SUB    ECX,EAX

    MOV    EDX,SubstrEnd
    SUB    EDX,ESI

    DEC    EDX            { EDX = Length(substr) - 1              }
    JS      @@fail        { < 0 ? return 0                        }
    MOV    AL,[ESI]       { AL = first char of substr             }
    INC    ESI            { Point ESI to 2'nd char of substr      }

    SUB    ECX,EDX        { #positions in s to look at            }
                          { = Length(s) - Length(substr) + 1      }
    JLE    @@fail

@@loop:
    REPNE  SCASB
    JNE    @@fail
    MOV    EBX,ECX        { save outer loop counter               }
    PUSH    ESI           { save outer loop substr pointer        }
    PUSH    EDI           { save outer loop s pointer             }

    MOV    ECX,EDX
    REPE    CMPSB
    POP    EDI            { restore outer loop s pointer          }
    POP    ESI            { restore outer loop substr pointer     }
    JE      @@found
    MOV    ECX,EBX        { restore outer loop counter            }
    JMP    @@loop

@@fail:
    XOR    EAX,EAX
    JMP    @@exit

@@found:
    MOV    EAX,EDI        { EDI points of char after match        }
    DEC    EAX

@@exit:
    POP    EDI
    POP    ESI
    POP    EBX
end;

//AnsiPosの高速版
function AnsiStrPosEx(StrStart, StrEnd, SubstrStart, SubstrEnd: PChar): PChar;
var
  L2: Cardinal;
  ByteType : TMbcsByteType;
begin
  Result := nil;
  if (StrStart = nil) or (StrStart^ = #0) or
    (SubstrStart = nil) or (SubstrStart^ = #0) then Exit;

  L2 := SubstrEnd - SubstrStart;
  Result := StrPosEx(StrStart, StrEnd, SubstrStart, SubstrEnd);

  while (Result <> nil) and (Cardinal(StrEnd - Result) >= L2) do
  begin
    ByteType := StrByteType(StrStart, Integer(Result-StrStart));
    if (ByteType <> mbTrailByte) and
      (CompareString(LOCALE_USER_DEFAULT, SORT_STRINGSORT, Result, L2, SubstrStart, L2) = 2)
    then Exit;
    if (ByteType = mbLeadByte) then Inc(Result);
    Inc(Result);
    Result := StrPosEx(Result, StrEnd, SubStrStart, SubStrEnd);
  end;
  Result := nil;
end;

//高速文字列置換関数（大文字小文字の違いを無視しない）
function ReplaceString(const S: String; const OldPattern: String; const NewPattern: string): String;
var
  ReplaceCount: Integer;
  DestIndex: Integer;
  i, l: Integer;
  p, e, ps, pe: PChar;
  Count: Integer;
  olen: Integer;
begin
  Result := S;
  olen := Length(OldPattern);
  if olen = 0 then Exit;
  p := PChar(S);
  e := p + Length(S);
  ps := PChar(OldPattern);
  pe := ps + olen;
  ReplaceCount := 0;
  while p < e do
  begin
    p := AnsiStrPosEx(p, e, ps, pe);
    if p = nil then Break;
    Inc(ReplaceCount);
    Inc(p, olen);
  end;
  if ReplaceCount = 0 then Exit;
  SetString(Result, nil, Length(S) +
  (Length(NewPattern) - olen) * ReplaceCount);
  p := PChar(S);
  DestIndex := 1;
  l := Length( NewPattern );
  for i := 0 to ReplaceCount - 1 do
  begin
    Count := AnsiStrPosEx(p, e, ps, pe) - p;
    Move(p^, Result[DestIndex], Count);
    Inc(p, Count);//p := pp;
    Inc(DestIndex, Count);
    Move(NewPattern[1], Result[DestIndex], l);
    Inc(p, olen);
    Inc(DestIndex, l);
  end;
  Move(p^, Result[DestIndex], e - p);
end;

//高速文字列置換関数（大文字小文字の違いを無視する）
function IgnoCaseReplaceString(const S: String;const OldPattern:String;const NewPattern: string): String;
var
  ReplaceCount: Integer;
  DestIndex: Integer;
  i, l: Integer;
  p, e{, ps, pe}: PChar;
  p2, e2, ps2, pe2: PChar;
  Count: Integer;
  bufferS : String;
  bufferOldPattern : String;
begin
  Result := S;
  bufferS := AnsiLowerCase(S);
  bufferOldPattern := AnsiLowerCase(OldPattern);

  if OldPattern = '' then Exit;
  p  := PChar(S);
  p2  := PChar(bufferS);
  e  := p + Length(S);
  e2  := p2 + Length(bufferS);
  //ps  := PChar(OldPattern);
  ps2  := PChar(bufferOldPattern);
  //pe  := ps + Length(OldPattern);
  pe2  := ps2 + Length(bufferOldPattern);

  ReplaceCount := 0;
  while p2 < e2 do
  begin
    p2 := AnsiStrPosEx(p2, e2, ps2, pe2);
    if p2 = nil then Break;
    Inc(ReplaceCount);
    Inc(p2, Length(bufferOldPattern));
  end;
  if ReplaceCount = 0 then Exit;
  SetString(Result, nil, Length(bufferS) +
  (Length(NewPattern) - Length(bufferOldPattern)) * ReplaceCount);
  p2 := PChar(bufferS);
  DestIndex := 1;
  l := Length( NewPattern );
  for i := 0 to ReplaceCount - 1 do
  begin
    Count := AnsiStrPosEx(p2, e2, ps2, pe2) - p2;
    Move(p^, Result[DestIndex], Count);
    Inc(p, Count);//p := pp;
    Inc(p2, Count);//p := pp;
    Inc(DestIndex, Count);
    Move(NewPattern[1], Result[DestIndex], l);
    Inc(p, Length(OldPattern));
    Inc(p2, Length(OldPattern));
    Inc(DestIndex, l);
  end;
  Move(p^, Result[DestIndex], e - p);
end;

//高速文字列置換関数（汎用版１）
function CustomStringReplace(const S :String;
                             const OldPattern: String;
                             const  NewPattern: string;
                             IgnoreCase : Boolean): String;
begin
  if not IgnoreCase then
  begin
    Result := ReplaceString(S,OldPattern,NewPattern);
  end else
  begin
    Result := IgnoCaseReplaceString(S,OldPattern,NewPattern);
  end;
end;

//高速文字列置換関数（汎用版２）
procedure CustomStringReplace(
  var S : TStringList;
  const OldPattern: String;
  const  NewPattern: string;
  IgnoreCase : Boolean
);
var
  i : Integer;
begin
  S.BeginUpdate;
  if not IgnoreCase then
  begin
    for i := 0 to S.Count - 1 do
    begin
      S.Strings[i] := ReplaceString(S.Strings[i], OldPattern,NewPattern);
    end;
  end else
  begin
    for i := 0 to S.Count - 1 do
    begin
      S.Strings[i] := IgnoCaseReplaceString(S.Strings[i], OldPattern,NewPattern);
    end;
  end;
  S.EndUpdate;
end;

function GetBetweenText(const AString, Aleftstr, Arightstr: string): string;
var
  startpos, endpos: integer;
  leftstr, rightstr: string;
begin
  result := AnsiLowerCase(AString);
  leftstr := AnsiLowerCase(Aleftstr);
  rightstr := AnsiLowerCase(Arightstr);

  startpos := FindPos(leftstr, result, 1) + length(leftstr);
  endpos := FindPos(rightstr, result, startpos);
  if (length(leftstr) < startpos) and (0 < endpos) then
  begin
    result := Copy(AString, startpos, endpos - startpos);
  end
  else
    result := '';
end;

end.
