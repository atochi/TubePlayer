unit CommonUtils;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Types, Forms;

{ Variant�n }
function VarToWStr(const V: Variant): WideString;
function VarToInt(const V: Variant): Integer;
function VarToDouble(const V: Variant): Double;

{ DateTime�n }
function YouTubeDateToDateTimeStr(YouTubeDate: string): string;

{ File�n }
function ExtractURIFile(const URI: string): string;
function ExtractURIDir(const URI: string): string;

{ Window�n }
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

//�gPita
procedure PitaMonitor(hWnd: THandle; var NewRect: TRect; Margin: SmallInt = 20);
var
  Monitor: TMonitor;
  MonitorRect: TRect;
begin
  //���j�^
  Monitor := Screen.MonitorFromWindow(hWnd, mdNearest);
  if not Assigned(Monitor) then
    exit;
  MonitorRect := Monitor.WorkareaRect;
  //��Pita
  if Abs(NewRect.Left - MonitorRect.Left) < Margin then
    OffsetRect(NewRect, MonitorRect.Left - NewRect.Left, 0)
  //�EPita
  else if Abs(MonitorRect.Right - NewRect.Right) < Margin then
    OffsetRect(NewRect, MonitorRect.Right - NewRect.Right, 0);
  //��Pita
  if Abs(NewRect.Top - MonitorRect.Top) < Margin then
    OffsetRect(NewRect, 0, MonitorRect.Top - NewRect.Top)
  //��Pita
  else if Abs(MonitorRect.Bottom - NewRect.Bottom) < Margin then
    OffsetRect(NewRect, 0, MonitorRect.Bottom - NewRect.Bottom);
end;

//Main�t�H�[�������K���őO�ʂɂ���ShowModal
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
