unit CommonUtils;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Types, Forms;

{ Variant系 }
function VarToWStr(const V: Variant): WideString;
function VarToInt(const V: Variant): Integer;
function VarToDouble(const V: Variant): Double;

{ DateTime系 }
function YouTubeDateToDateTimeStr(YouTubeDate: string): string;

{ File系 }
function ExtractURIFile(const URI: string): string;
function ExtractURIDir(const URI: string): string;

{ Window系 }
procedure PitaMonitor(hWnd: THandle; var NewRect: TRect; Margin: SmallInt = 20);
function ShowModalDlg(MainForm, ModalForm: TForm; StayOnTop: Boolean): Integer;

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

//枠Pita
procedure PitaMonitor(hWnd: THandle; var NewRect: TRect; Margin: SmallInt = 20);
var
  Monitor: TMonitor;
  MonitorRect: TRect;
begin
  //モニタ
  Monitor := Screen.MonitorFromWindow(hWnd, mdNearest);
  if not Assigned(Monitor) then
    exit;
  MonitorRect := Monitor.WorkareaRect;
  //左Pita
  if Abs(NewRect.Left - MonitorRect.Left) < Margin then
    OffsetRect(NewRect, MonitorRect.Left - NewRect.Left, 0)
  //右Pita
  else if Abs(MonitorRect.Right - NewRect.Right) < Margin then
    OffsetRect(NewRect, MonitorRect.Right - NewRect.Right, 0);
  //上Pita
  if Abs(NewRect.Top - MonitorRect.Top) < Margin then
    OffsetRect(NewRect, 0, MonitorRect.Top - NewRect.Top)
  //下Pita
  else if Abs(MonitorRect.Bottom - NewRect.Bottom) < Margin then
    OffsetRect(NewRect, 0, MonitorRect.Bottom - NewRect.Bottom);
end;

//Mainフォームよりも必ず最前面にくるShowModal
function ShowModalDlg(MainForm, ModalForm: TForm; StayOnTop: Boolean): Integer;
begin
  if StayOnTop then
    SetWindowPos(MainForm.Handle,HWND_NOTOPMOST,0,0,0,0,SWP_NOSIZE or SWP_NOMOVE);
  try
    Result := ModalForm.ShowModal;
  finally
    if StayOnTop then
      SetWindowPos(MainForm.Handle,HWND_TOPMOST,0,0,0,0,SWP_NOSIZE or SWP_NOMOVE);
  end;
end;

end.
