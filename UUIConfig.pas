unit UUIConfig;
(* 設定画面 *)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ShlObj, ActiveX, StrUtils,
  TBXDkPanels, SpTBXControls, SpTBXEditors,
  Config, TntStdCtrls;

type
  TUIConfig = class(TForm)
    ButtonOK: TSpTBXButton;
    ButtonCancel: TSpTBXButton;
    TreeView: TTreeView;
    PageControl: TPageControl;
    TabSheetNet: TTabSheet;
    Label1: TSpTBXLabel;
    EditnetUserAgent: TSpTBXEdit;
    CheckBoxnetUseProxy: TSpTBXCheckBox;
    CheckBoxnetNoCache: TSpTBXCheckBox;
    Label2: TSpTBXLabel;
    EditnetProxyServer: TSpTBXEdit;
    Label3: TSpTBXLabel;
    EditnetProxyPort: TSpTBXEdit;
    Label4: TSpTBXLabel;
    Label5: TSpTBXLabel;
    EditnetReadTimeout: TSpTBXEdit;
    TabSheetTools: TTabSheet;
    CheckBoxoptBrowserSpecified: TSpTBXCheckBox;
    Label7: TSpTBXLabel;
    EditoptBrowserPath: TSpTBXEdit;
    ButtonSelBrowser: TSpTBXButton;
    GroupBox1: TSpTBXGroupBox;
    RadioButtonDownloadOption0: TSpTBXRadioButton;
    RadioButtonDownloadOption1: TSpTBXRadioButton;
    RadioButtonDownloadOption2: TSpTBXRadioButton;
    Label8: TSpTBXLabel;
    EditoptDownloaderPath: TSpTBXEdit;
    ButtonSelDownloader: TSpTBXButton;
    Label9: TSpTBXLabel;
    EditoptDownloaderOption: TSpTBXEdit;
    RadioButtonDownloadOption3: TSpTBXRadioButton;
    TabSheetYouTube: TTabSheet;
    CheckBoxoptAutoPlay: TSpTBXCheckBox;
    CheckBoxoptUsePlayer2: TSpTBXCheckBox;
    GroupBox2: TSpTBXGroupBox;
    TabSheetGeneral: TTabSheet;
    CheckBoxoptCloseToTray: TSpTBXCheckBox;
    CheckBoxoptClearVideo: TSpTBXCheckBox;
    RadioGroupoptDeactiveOption: TSpTBXRadioGroup;
    OpenDialog: TOpenDialog;
    OpenDialog1: TOpenDialog;
    Label10: TSpTBXLabel;
    Label11: TSpTBXLabel;
    CheckBoxoptNewWindowAnytime: TSpTBXCheckBox;
    CheckBoxoptUpdateCheck: TSpTBXCheckBox;
    RadioGroupoptFPQuality: TSpTBXRadioGroup;
    SpinEditAutoCloseTime: TSpTBXSpinEdit;
    LabelAutoCloseTime: TSpTBXLabel;
    SpTBXLabel1: TSpTBXLabel;
    ComboBoxSkinPath: TSpTBXComboBox;
    ButtonSelSkinFolder: TSpTBXButton;
    CheckBoxoptUseDefaultTitleBar: TSpTBXCheckBox;
    CheckBoxoptListViewUseExtraBackColor: TSpTBXCheckBox;
    LabelListOdd: TLabel;
    LabelListEven: TLabel;
    ButtonOdd: TSpTBXButton;
    ButtonEvwn: TSpTBXButton;
    ColorDialog: TColorDialog;
    CheckBoxoptWheelScrollUnderCursor: TSpTBXCheckBox;
    Label12: TLabel;
    SpinEditSearchHistoryCount: TSpTBXSpinEdit;
    CheckBoxoptUseShellExecute: TSpTBXCheckBox;
    TabSheetWindow: TTabSheet;
    SpTBXLabel3: TSpTBXLabel;
    SpTBXLabel4: TSpTBXLabel;
    SpinEditYouTubeWidth: TSpTBXSpinEdit;
    SpinEditYouTubeHeight: TSpTBXSpinEdit;
    SpinEditNicoVideoWidth: TSpTBXSpinEdit;
    SpinEditNicoVideoHeight: TSpTBXSpinEdit;
    SpTBXLabel5: TSpTBXLabel;
    SpTBXLabel6: TSpTBXLabel;
    SpTBXGroupBox1: TSpTBXGroupBox;
    TabSheetnicovideo: TTabSheet;
    SpinEditYouTubeWidthDef: TSpTBXSpinEdit;
    SpinEditYouTubeHeightDef: TSpTBXSpinEdit;
    SpTBXGroupBox2: TSpTBXGroupBox;
    SpTBXLabel2: TSpTBXLabel;
    SpTBXLabel7: TSpTBXLabel;
    SpTBXLabel8: TSpTBXLabel;
    SpTBXLabel9: TSpTBXLabel;
    SpinEditNicoVideoWidthDef: TSpTBXSpinEdit;
    SpinEditNicoVideoHeightDef: TSpTBXSpinEdit;
    SpTBXGroupBox3: TSpTBXGroupBox;
    SpTBXLabel10: TSpTBXLabel;
    SpTBXLabel11: TSpTBXLabel;
    EditoptNicoVideoAccount: TSpTBXEdit;
    EditoptNicoVideoPassword: TSpTBXEdit;
    SpTBXGroupBox4: TSpTBXGroupBox;
    SpTBXLabel12: TSpTBXLabel;
    SpTBXLabel13: TSpTBXLabel;
    EditoptYouTubeAccount: TSpTBXEdit;
    EditoptYouTubePassword: TSpTBXEdit;
    Label13: TLabel;
    SpinEditRecentlyViewedCount: TSpTBXSpinEdit;
    SpTBXLabel14: TSpTBXLabel;
    SpinEditNicoVideoWidthVideo: TSpTBXSpinEdit;
    SpinEditNicoVideoHeightVideo: TSpTBXSpinEdit;
    SpTBXLabel15: TSpTBXLabel;
    SpTBXLabel16: TSpTBXLabel;
    CheckBoxoptFormStayOnTopPlaying: TSpTBXCheckBox;
    SpTBXLabel17: TSpTBXLabel;
    EditnetConnectTimeout: TSpTBXEdit;
    CheckBoxoptAllowFavoriteDuplicate: TSpTBXCheckBox;
    CheckBoxoptAddFavoriteAtBottom: TSpTBXCheckBox;
    SpTBXLabel18: TSpTBXLabel;
    SpTBXGroupBox5: TSpTBXGroupBox;
    SpinEditNicoVideoModTop: TSpTBXSpinEdit;
    SpinEditNicoVideoModLeft: TSpTBXSpinEdit;
    SpTBXLabel19: TSpTBXLabel;
    SpTBXLabel20: TSpTBXLabel;
    ButtonNicoVideoSize2Def: TSpTBXButton;
    ButtonYouTubeSize2Def: TSpTBXButton;
    CheckBoxoptUseLocalPlayer: TSpTBXCheckBox;
    LabelSize2: TSpTBXLabel;
    LabelSize: TSpTBXLabel;
    CheckBoxoptFavoriteClickOption: TSpTBXCheckBox;
    CheckBoxoptListClickOption: TSpTBXCheckBox;
    CheckBoxoptAutoOverlayCheckOn: TSpTBXCheckBox;
    CheckBoxoptUseMP4: TSpTBXCheckBox;
    CheckBoxoptNicoVideoAutoPlay: TSpTBXCheckBox;
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure PageControlChange(Sender: TObject);
    procedure CheckBoxoptUsePlayer2Click(Sender: TObject);
    procedure ButtonSelBrowserClick(Sender: TObject);
    procedure ButtonSelDownloaderClick(Sender: TObject);
    procedure RadioGroupoptDeactiveOptionClick(Sender: TObject);
    procedure ButtonSelSkinFolderClick(Sender: TObject);
    procedure ButtonColorClick(Sender: TObject);
    procedure ButtonNicoVideoSize2DefClick(Sender: TObject);
    procedure ButtonYouTubeSize2DefClick(Sender: TObject);
  private
    { Private 宣言 }
  public
    { Public 宣言 }
  end;

var
  UIConfig: TUIConfig;

function BrowseCallback(hWnd: HWND; uMsg: UINT; lParam: LPARAM; lpData: LPARAM): integer; stdcall; export;

implementation

uses Main;

{$R *.dfm}

procedure TUIConfig.ButtonOKClick(Sender: TObject);
var
  ReadTimeout, ConnectTimeout, port: integer;
begin
  try
    ReadTimeout := StrToInt(self.EditnetReadTimeout.Text);
  except
    self.PageControl.ActivePageIndex := 0;
    self.EditnetReadTimeout.SetFocus;
    MessageDlg('受信タイムアウト', mtError, [mbOK], 0);
    exit;
  end; 
  try
    ConnectTimeout := StrToInt(self.EditnetConnectTimeout.Text);
  except
    self.PageControl.ActivePageIndex := 0;
    self.EditnetConnectTimeout.SetFocus;
    MessageDlg('接続タイムアウト', mtError, [mbOK], 0);
    exit;
  end;
  port := 0;
  if 0 < length(EditnetProxyPort.Text) then
  begin
    try
      port := StrToInt(EditnetProxyPort.Text);
    except
      self.PageControl.ActivePageIndex := 0;
      self.EditnetProxyPort.SetFocus;
      MessageDlg('port', mtError, [mbOK], 0);
      exit;
    end;
  end;

  Main.Config.netUserAgent := self.EditnetUserAgent.Text;
  Main.Config.netReadTimeout := ReadTimeout;
  Main.Config.netConnectTimeout := ConnectTimeout;
  Main.Config.netUseProxy := self.CheckBoxnetUseProxy.Checked;
  Main.Config.netNoCache := not self.CheckBoxnetNoCache.Checked;
  Main.Config.netProxyServer := self.EditnetProxyServer.Text;
  Main.Config.netProxyPort := port;

  Main.Config.optDeactiveOption := self.RadioGroupoptDeactiveOption.ItemIndex;
  Main.Config.optAutoCloseTime := Trunc(self.SpinEditAutoCloseTime.Value);
  Main.Config.optFPQuality := self.RadioGroupoptFPQuality.ItemIndex;
  Main.Config.optUseDefaultTitleBar := self.CheckBoxoptUseDefaultTitleBar.Checked;
  Main.Config.optCloseToTray := self.CheckBoxoptCloseToTray.Checked;
  Main.Config.optClearVideo := self.CheckBoxoptClearVideo.Checked;
  Main.Config.optNewWindowAnytime := self.CheckBoxoptNewWindowAnytime.Checked;
  Main.Config.optSearchHistoryCount := Trunc(self.SpinEditSearchHistoryCount.Value);
  Main.Config.optRecentlyViewedCount := Trunc(self.SpinEditRecentlyViewedCount.Value);
  Main.Config.optWheelScrollUnderCursor := self.CheckBoxoptWheelScrollUnderCursor.Checked;
  Main.Config.optAllowFavoriteDuplicate := self.CheckBoxoptAllowFavoriteDuplicate.Checked;
  Main.Config.optAddFavoriteAtBottom := self.CheckBoxoptAddFavoriteAtBottom.Checked;
  Main.Config.optFavoriteClickOption := self.CheckBoxoptFavoriteClickOption.Checked;   
  Main.Config.optListClickOption := self.CheckBoxoptListClickOption.Checked;
  Main.Config.optFormStayOnTopPlaying := self.CheckBoxoptFormStayOnTopPlaying.Checked;

  Main.Config.optYouTubeWidth := Trunc(self.SpinEditYouTubeWidth.Value);
  Main.Config.optYouTubeHeight := Trunc(self.SpinEditYouTubeHeight.Value);
  Main.Config.optYouTubeWidthDef := Trunc(self.SpinEditYouTubeWidthDef.Value);
  Main.Config.optYouTubeHeightDef := Trunc(self.SpinEditYouTubeHeightDef.Value);
  Main.Config.optNicoVideoWidth := Trunc(self.SpinEditNicoVideoWidth.Value);
  Main.Config.optNicoVideoHeight := Trunc(self.SpinEditNicoVideoHeight.Value);
  Main.Config.optNicoVideoWidthDef := Trunc(self.SpinEditNicoVideoWidthDef.Value);
  Main.Config.optNicoVideoHeightDef := Trunc(self.SpinEditNicoVideoHeightDef.Value);
  Main.Config.optNicoVideoWidthVideo := Trunc(self.SpinEditNicoVideoWidthVideo.Value);
  Main.Config.optNicoVideoHeightVideo := Trunc(self.SpinEditNicoVideoHeightVideo.Value);
  Main.Config.optNicoVideoModLeft := Trunc(self.SpinEditNicoVideoModLeft.Value);
  Main.Config.optNicoVideoModTop := Trunc(self.SpinEditNicoVideoModTop.Value);

  Main.Config.optYouTubeAccount  := Self.EditoptYouTubeAccount.Text;
  Main.Config.optYouTubePassword := Self.EditoptYouTubePassword.Text;

  Main.Config.optNicoVideoAccount  := Self.EditoptNicoVideoAccount.Text;
  Main.Config.optNicoVideoPassword := Self.EditoptNicoVideoPassword.Text; 

  Main.Config.optUseLocalPlayer := self.CheckBoxoptUseLocalPlayer.Checked; 
  Main.Config.optNicoVideoAutoPlay := self.CheckBoxoptNicoVideoAutoPlay.Checked;
  Main.Config.optAutoOverlayCheckOn := self.CheckBoxoptAutoOverlayCheckOn.Checked;

  Main.Config.optListViewUseExtraBackColor := self.CheckBoxoptListViewUseExtraBackColor.Checked;
  Main.Config.clListViewOddBackColor  := self.LabelListOdd.Color;
  Main.Config.clListViewEvenBackColor := self.LabelListEven.Color;

  Main.Config.optBrowserSpecified := self.CheckBoxoptBrowserSpecified.Checked;
  Main.Config.optBrowserPath := self.EditoptBrowserPath.Text;
  Main.Config.optUseShellExecute := self.CheckBoxoptUseShellExecute.Checked;
  if RadioButtonDownloadOption0.Checked then
    Main.Config.optDownloadOption :=0
  else if RadioButtonDownloadOption1.Checked then
    Main.Config.optDownloadOption :=1
  else if RadioButtonDownloadOption2.Checked then
    Main.Config.optDownloadOption :=2
  else if RadioButtonDownloadOption3.Checked then
    Main.Config.optDownloadOption :=3;
  Main.Config.optDownloaderPath := self.EditoptDownloaderPath.Text;
  Main.Config.optDownloaderOption := self.EditoptDownloaderOption.Text;

  Main.Config.optUsePlayer2 := self.CheckBoxoptUsePlayer2.Checked;
  Main.Config.optAutoPlay := self.CheckBoxoptAutoPlay.Checked;
  Main.Config.optUseMP4 := self.CheckBoxoptUseMP4.Checked;
  if Main.Config.optUseMP4 then
    Main.Config.optMP4Format := YOUTUBE_MP4_FMT
  else
    Main.Config.optMP4Format := '';

  Main.Config.optSkinPath := self.ComboBoxSkinPath.Text;

  Main.Config.optUpdateCheck := self.CheckBoxoptUpdateCheck.Checked;

  Main.Config.Modified := True;
  ModalResult := mrOK;
end;

procedure TUIConfig.ButtonCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TUIConfig.FormShow(Sender: TObject);
begin
  self.LabelSize.Caption := '現在値:(' + IntToStr(MainWnd.Panel.Width) + '×' + IntToStr(MainWnd.Panel.Height) + ')';
  self.LabelSize2.Caption := self.LabelSize.Caption;

  self.EditnetUserAgent.Text := Main.Config.netUserAgent;
  self.EditnetReadTimeout.Text := IntToStr(Main.Config.netReadTimeout);
  self.EditnetConnectTimeout.Text := IntToStr(Main.Config.netConnectTimeout);
  self.CheckBoxnetUseProxy.Checked := Main.Config.netUseProxy;
  self.CheckBoxnetNoCache.Checked := not Main.Config.netNoCache;
  self.EditnetProxyServer.Text := Main.Config.netProxyServer;
  if 0 < Main.Config.netProxyPort then
    self.EditnetProxyPort.Text := IntToStr(Main.Config.netProxyPort)
  else
    self.EditnetProxyPort.Text := '';

  self.RadioGroupoptDeactiveOption.ItemIndex := Main.Config.optDeactiveOption;
  self.SpinEditAutoCloseTime.Value := Main.Config.optAutoCloseTime;
  self.RadioGroupoptFPQuality.ItemIndex := Main.Config.optFPQuality;
  self.CheckBoxoptUseDefaultTitleBar.Checked := Main.Config.optUseDefaultTitleBar;
  self.CheckBoxoptCloseToTray.Checked := Main.Config.optCloseToTray;
  self.CheckBoxoptClearVideo.Checked := Main.Config.optClearVideo;
  self.CheckBoxoptNewWindowAnytime.Checked := Main.Config.optNewWindowAnytime;
  self.SpinEditSearchHistoryCount.Value := Main.Config.optSearchHistoryCount; 
  self.SpinEditRecentlyViewedCount.Value := Main.Config.optRecentlyViewedCount;
  self.CheckBoxoptWheelScrollUnderCursor.Checked := Main.Config.optWheelScrollUnderCursor;
  self.CheckBoxoptAllowFavoriteDuplicate.Checked := Main.Config.optAllowFavoriteDuplicate;
  self.CheckBoxoptAddFavoriteAtBottom.Checked := Main.Config.optAddFavoriteAtBottom;
  self.CheckBoxoptFavoriteClickOption.Checked := Main.Config.optFavoriteClickOption; 
  self.CheckBoxoptListClickOption.Checked := Main.Config.optListClickOption;
  self.CheckBoxoptFormStayOnTopPlaying.Checked := Main.Config.optFormStayOnTopPlaying;

  self.SpinEditYouTubeWidth.Value := Main.Config.optYouTubeWidth;
  self.SpinEditYouTubeHeight.Value := Main.Config.optYouTubeHeight;
  self.SpinEditYouTubeWidthDef.Value := Main.Config.optYouTubeWidthDef;
  self.SpinEditYouTubeHeightDef.Value := Main.Config.optYouTubeHeightDef;
  self.SpinEditNicoVideoWidth.Value := Main.Config.optNicoVideoWidth;
  self.SpinEditNicoVideoHeight.Value := Main.Config.optNicoVideoHeight;
  self.SpinEditNicoVideoWidthDef.Value := Main.Config.optNicoVideoWidthDef;
  self.SpinEditNicoVideoHeightDef.Value := Main.Config.optNicoVideoHeightDef;
  self.SpinEditNicoVideoWidthVideo.Value := Main.Config.optNicoVideoWidthVideo;
  self.SpinEditNicoVideoHeightVideo.Value := Main.Config.optNicoVideoHeightVideo;
  self.SpinEditNicoVideoModLeft.Value := Main.Config.optNicoVideoModLeft;
  self.SpinEditNicoVideoModTop.Value := Main.Config.optNicoVideoModTop;

  Self.EditoptYouTubeAccount.Text  := Main.Config.optYouTubeAccount;
  Self.EditoptYouTubePassword.Text := Main.Config.optYouTubePassword;

  Self.EditoptNicoVideoAccount.Text  := Main.Config.optNicoVideoAccount;
  Self.EditoptNicoVideoPassword.Text := Main.Config.optNicoVideoPassword;

  self.CheckBoxoptUseLocalPlayer.Checked := Main.Config.optUseLocalPlayer; 
  self.CheckBoxoptNicoVideoAutoPlay.Checked := Main.Config.optNicoVideoAutoPlay;
  self.CheckBoxoptAutoOverlayCheckOn.Checked := Main.Config.optAutoOverlayCheckOn;

  self.CheckBoxoptListViewUseExtraBackColor.Checked := Main.Config.optListViewUseExtraBackColor;

  self.CheckBoxoptBrowserSpecified.Checked := Main.Config.optBrowserSpecified;
  self.EditoptBrowserPath.Text := Main.Config.optBrowserPath; 
  self.CheckBoxoptUseShellExecute.Checked := Main.Config.optUseShellExecute;
  case Main.Config.optDownloadOption of
    0: RadioButtonDownloadOption0.Checked := True;
    1: RadioButtonDownloadOption1.Checked := True;
    2: RadioButtonDownloadOption2.Checked := True;
    3: RadioButtonDownloadOption3.Checked := True;
  end;
  self.EditoptDownloaderPath.Text := Main.Config.optDownloaderPath;
  self.EditoptDownloaderOption.Text := Main.Config.optDownloaderOption;

  self.CheckBoxoptUsePlayer2.Checked := Main.Config.optUsePlayer2;
  self.CheckBoxoptAutoPlay.Checked := Main.Config.optAutoPlay; 
  self.CheckBoxoptUseMP4.Checked := Main.Config.optUseMP4;
  CheckBoxoptAutoPlay.Enabled := not CheckBoxoptUsePlayer2.Checked;
  self.ComboBoxSkinPath.Text := Main.Config.optSkinPath;

  self.CheckBoxoptUpdateCheck.Checked := Main.Config.optUpdateCheck;

  self.LabelListOdd.Caption  := '奇数行';
  self.LabelListEven.Caption := '偶数行';
  self.LabelListOdd.Color    := Main.Config.clListViewOddBackColor;
  self.LabelListEven.Color   := Main.Config.clListViewEvenBackColor;
end;

procedure TUIConfig.FormCreate(Sender: TObject);
begin
  TreeView.Items.BeginUpdate;
  TreeView.Items.AddChildObject(TreeView.Items.Item[0], TabSheetGeneral.Caption, TabSheetGeneral);
  TreeView.Items.AddChildObject(TreeView.Items.Item[0], TabSheetWindow.Caption, TabSheetWindow);
  TreeView.Items.AddChildObject(TreeView.Items.Item[0], TabSheetNet.Caption, TabSheetNet);
  TreeView.Items.AddChildObject(TreeView.Items.Item[0], TabSheetTools.Caption, TabSheetTools);
  TreeView.Items.AddChildObject(TreeView.Items.Item[0], TabSheetYouTube.Caption, TabSheetYouTube);
  TreeView.Items.AddChildObject(TreeView.Items.Item[0], TabSheetnicovideo.Caption, TabSheetnicovideo);
  TreeView.FullExpand;
  TreeView.Selected := TreeView.Items[1];
  TreeView.Items.EndUpdate;
end;

procedure TUIConfig.TreeViewChange(Sender: TObject; Node: TTreeNode);
begin
  if not (TObject(Node.Data) is TTabSheet) then
    exit;
  PageControl.ActivePage := TTabSheet(Node.Data);
  PageControlChange(Sender);
end;

procedure TUIConfig.PageControlChange(Sender: TObject);
var
  sr: TSearchRec;
begin
  self.Caption := '設定 - 【' + PageControl.ActivePage.Caption + '】';
  if PageControl.ActivePage.Tag = 1 then  // 初期化済み
    exit;

  if (PageControl.ActivePage = TabSheetGeneral) then
  begin
    if FindFirst(Main.Config.BasePath + 'skin\*', faDirectory, sr) = 0 then
    repeat
      if (sr.Attr = faDirectory) and
         (sr.Name <> '.') and (sr.Name <> '..') and (sr.Name <> 'Logs') then
        ComboBoxSkinPath.AddItem(sr.Name + '\', nil);
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;
  PageControl.ActivePage.Tag := 1; //初期化
end;

procedure TUIConfig.CheckBoxoptUsePlayer2Click(Sender: TObject);
begin
  CheckBoxoptAutoPlay.Enabled := not CheckBoxoptUsePlayer2.Checked;
end;

procedure TUIConfig.ButtonSelBrowserClick(Sender: TObject);
begin
  OpenDialog.FileName := EditoptBrowserPath.Text;
  if not OpenDialog.Execute then
    exit;
  EditoptBrowserPath.Text := OpenDialog.FileName;
end;

procedure TUIConfig.ButtonSelDownloaderClick(Sender: TObject);
begin
  OpenDialog1.FileName := EditoptDownloaderPath.Text;
  if not OpenDialog1.Execute then
    exit;
  EditoptDownloaderPath.Text := OpenDialog1.FileName;
end;

procedure TUIConfig.RadioGroupoptDeactiveOptionClick(Sender: TObject);
begin
  if self.RadioGroupoptDeactiveOption.ItemIndex = 2 then
  begin
    SpinEditAutoCloseTime.Visible := True;
    LabelAutoCloseTime.Visible := True;
  end else
  begin
    SpinEditAutoCloseTime.Visible := false;
    LabelAutoCloseTime.Visible := false;
  end;
end;

procedure TUIConfig.ButtonSelSkinFolderClick(Sender: TObject);
var
  path: string;
  pszPath: PChar;
  bi: TBrowseInfo;
  pidl: PItemIdList;
begin
  case TButton(Sender).Tag of
    1: path := ComboBoxSkinPath.Text;
  else exit;
  end;

  bi.hwndOwner := Handle;
  bi.pidlRoot := nil;
  bi.pszDisplayName := nil;
  bi.lpszTitle := 'フォルダを選択してください';
  bi.ulFlags := BIF_RETURNONLYFSDIRS or BIF_STATUSTEXT;
  bi.lpfn := @BrowseCallBack;
  bi.lParam := integer(PChar(path));
  bi.iImage := 0;

  pidl := SHBrowseForFolder(bi);
  if pidl <> nil then
  begin
    pszPath := StrAlloc(MAX_PATH);
    try
      SHGetPathFromIDList(pidl, pszPath);
      path := string(pszPath);
    finally
      StrDispose(pszPath);
    end;
    CoTaskMemFree(pidl);
    if not AnsiEndsStr('\', path) then
      path := path + '\';
  end;

  case TButton(Sender).Tag of
    1: ComboBoxSkinPath.Text := path;
  end;
end;

//フォルダ選択ダイアログ用コールバック関数
function BrowseCallback(hWnd: HWND; uMsg: UINT; lParam: LPARAM; lpData: LPARAM): integer;
var
  path: array[0..MAX_PATH] of Char;
begin
  result := 0;
  case uMsg of
  BFFM_INITIALIZED:
    SendMessage(hwnd, BFFM_SETSELECTION, 1, integer(lpData));
  BFFM_SELCHANGED:
    begin
      SHGetPathFromIDList(PItemIDList(lParam), path);
      SendMessage(hWnd, BFFM_SETSTATUSTEXT, 0, integer(@path));
    end;
  end;
end;

//背景色の変更
procedure TUIConfig.ButtonColorClick(Sender: TObject);
var
  tag: integer;
  Lbl: TLabel;
begin
  tag := TSpTBXButton(Sender).Tag;
  case tag of
    1: Lbl := LabelListOdd;
    2: Lbl := LabelListEven;
    else exit;
  end;

  ColorDialog.Color := Lbl.Color;
  if not ColorDialog.Execute then
    exit;

  Lbl.Color := ColorDialog.Color;

  Main.Config.ColorChanged := true;
end;

//ニコニコ動画のサイズ設定を規定値に戻す
procedure TUIConfig.ButtonNicoVideoSize2DefClick(Sender: TObject);
begin
  self.SpinEditNicoVideoWidth.Value := 549;
  self.SpinEditNicoVideoHeight.Value := 473; //415;
  self.SpinEditNicoVideoWidthDef.Value := 0;
  self.SpinEditNicoVideoHeightDef.Value := 0;
  self.SpinEditNicoVideoWidthVideo.Value := 549;
  self.SpinEditNicoVideoHeightVideo.Value := 473; //415;
  self.SpinEditNicoVideoModLeft.Value := 6;
  self.SpinEditNicoVideoModTop.Value := 65;
end;

//YouTubeのサイズ設定を規定値に戻す
procedure TUIConfig.ButtonYouTubeSize2DefClick(Sender: TObject);
begin
  self.SpinEditYouTubeWidth.Value := 450;
  self.SpinEditYouTubeHeight.Value := 370;
  self.SpinEditYouTubeWidthDef.Value := 0;
  self.SpinEditYouTubeHeightDef.Value := 0;
end;

end.

