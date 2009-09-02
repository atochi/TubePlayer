unit HTTPSub;

(* Personal”Å‚É‚ÍHTTPEncode‚ª‚È‚¢‚©‚ç‚Ë *)
(* Copyright (c) 2001,2002 hetareprog@hotmail.com *)


interface

uses
  SysUtils, StrSub;

function URLEncode(const str: string): string;
function URLDecode(const str: string): string;

implementation

{$B-} (* short circuit *)

function URLEncode(const str: string): string;
var
  s: string;
  i: integer;
begin
  s := '';
  for i := 1 to length(str) do
  begin
    case str[i] of
    '0'..'9','A'..'Z','a'..'z':
      s := s + str[i];
    else
      s := s + Format('%%%2.2X', [Ord(str[i])]);
    end;
  end;
  result := s;
end;

function URLDecode(const str: string): string;
var
  I: Integer;
begin
  Result := '';
  if Length(str) > 0 then
  begin
    I := 1;
    while I <= Length(str) do
    begin
      if str[I] = '%' then
        begin
          Result := Result + Chr(HexToInt(str[I+1]
                                       + str[I+2]));
          I := Succ(Succ(I));
        end
      else if str[I] = '+' then
        Result := Result + ' '
      else
        Result := Result + str[I];

      I := Succ(I);
    end;
  end;
end;

end.
