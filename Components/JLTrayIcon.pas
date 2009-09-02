unit JLTrayIcon;
(* タスクトレイにアイコン表示 *)
(* Copyright (c) 2005 ◆aiai/zdSWk *)

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Menus, Forms, ShellAPI;

type
  TJLTrayIcon = class(TComponent)
  private
    FPopupMenu: TPopupMenu;
    FHandle: HWND;
    FIcon: HICON;
    FMouseUp: TMouseEvent;
    FNotifyIconData: TNotifyIconData;
    FVisible: Boolean;
    procedure SetVisible(AVisible: Boolean);
    procedure ShowPopupMenu;
  protected
    procedure DoButtonUp(Button: TMouseButton);
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure WndProc(var Message: TMessage);
    procedure Show;
    procedure Hide;
    property Handle: HWND read FHandle;
  published
    property Visible: Boolean read FVisible write SetVisible;
    property PopupMenu: TPopupMenu read FPopupMenu write FPopupMenu;
    property OnMouseUp: TMouseEvent read FMouseUp write FMouseUp;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TJLTrayIcon]);
end;

const
  WM_MY_TRAYICON = WM_APP + $500;

var
  uTaskBarRecreate: Cardinal;


 { TJLTrayIcon }

constructor TJLTrayIcon.Create(AOwner: TComponent);
var
  largeIcon: HICON;
begin
  inherited Create(AOwner);

  FVisible := False;

  if not (csDesigning in ComponentState) then
  begin
    FHandle := classes.AllocateHWnd(WndProc);
    SetWindowText(FHandle, PChar('JLTrayIcon'));

    ExtractIconEx(PChar(ParamStr(0)), 0, largeIcon, FIcon, 1);
    DestroyIcon(largeIcon);
    zeromemory(@FNotifyIconData, sizeof(TNotifyIconData));
    With FNotifyIconData do
    begin
      cbSize := sizeof(TNotifyIconData);
      Wnd := FHandle;
      uID := UINT(FHandle);
      uFlags := NIF_ICON or NIF_TIP or NIF_MESSAGE;
      uCallbackMessage := WM_MY_TRAYICON;
      hIcon := FIcon;
      StrPLCopy(szTip, Application.Title, sizeof(szTip) - 1);
    end;
  end;
end;

destructor TJLTrayIcon.Destroy;
begin
  if not (csDesigning in ComponentState) then
  begin
    if FVisible then
      Hide;
    DestroyIcon(FIcon);
    classes.DeallocateHWnd(FHandle);
  end;
    
  inherited Destroy;
end;

procedure TJLTrayIcon.SetVisible(AVisible: Boolean);
begin
  if FVisible <> AVisible then
  begin
    if AVisible then
      Show
    else
      Hide;
  end;
end;

procedure TJLTrayIcon.ShowPopupMenu;
var
  point: TPoint;
begin
  if Assigned(FPopupMenu) and GetCursorPos(point)
    and not InvalidPoint(point) then
  begin
    SetForegroundWindow(Application.MainForm.Handle);
    FPopupMenu.Popup(point.X, point.Y);
  end;
end;

procedure TJLTrayIcon.DoButtonUp(Button: TMouseButton);
var
  point: TPoint;
  Shift: TShiftState;
begin
  if GetCursorPos(point) and not InvalidPoint(point) then
  begin
    Shift := [];
    if GetKeyState(VK_SHIFT) < 0 then Include(Shift, ssShift);
    if GetKeyState(VK_CONTROL) < 0 then Include(Shift, ssCtrl);
    if GetKeyState(VK_LBUTTON) < 0 then Include(Shift, ssLeft);
    if GetKeyState(VK_RBUTTON) < 0 then Include(Shift, ssRight);
    if GetKeyState(VK_MBUTTON) < 0 then Include(Shift, ssMiddle);
    if GetKeyState(VK_MENU) < 0 then Include(Shift, ssAlt);

    MouseUp(Button, Shift, point.X, point.Y);
  end;
end;

procedure TJLTrayIcon.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if Assigned(FMouseUp) then
    FMouseUp(Self, Button, Shift, X, Y);
end;

procedure TJLTrayIcon.WndProc(var Message: TMessage);
begin
  try
    With Message do
      if (Msg = WM_MY_TRAYICON) and (WParam = Integer(FNotifyIconData.uID)) then
        case LParam of
          WM_LBUTTONUP: DoButtonUp(mbLeft);
          WM_RBUTTONUP: begin
            DoButtonUp(mbRight);
            ShowPopupMenu;
          end;
        else
          Result := DefWindowProc(FHandle, Msg, wParam, lParam);
        end
      else if (Msg = uTaskBarRecreate) and FVisible then
        Shell_NotifyIcon(NIM_ADD, @FNotifyIconData)
      else
        Result := DefWindowProc(FHandle, Msg, WParam, LParam);
  except
    Application.HandleException(Self);
  end;
end;

procedure TJLTrayIcon.Show;
begin
  if not FVisible then
  begin
    FVisible := True;
    Shell_NotifyIcon(NIM_ADD, @FNotifyIconData);
  end;
end;

procedure TJLTrayIcon.Hide;
var
  tnid: TNotifyIconData;
begin
  if FVisible then
  begin
    tnid.cbSize := sizeof(TNotifyIconData);
    tnid.Wnd := FNotifyIconData.Wnd;
    tnid.uID := FNotifyIconData.uID;
    FVisible := False;
    Shell_NotifyIcon(NIM_DELETE, @tnid);
  end;
end;

Initialization
  //タスクバーが作り直されたときに送られてくるメッセージの番号をもらう
  uTaskBarRecreate := RegisterWindowMessage('TaskbarCreated');

end.
 