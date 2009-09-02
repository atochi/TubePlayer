unit Config;
(* 設定 *)

interface

uses
  SysUtils, Forms, Classes, IniFiles, Windows, USynchro,
  Graphics, StrSub;

type
  TConfig = class(TObject)
  private
    { Private 宣言 }
  public
    { Public 宣言 }
    BasePath: string;  //\付きのアプリのパス
    IniPath: string;   //iniファイルのパス

    grepSearchList: TStringList; //検索リスト

    (* 通信 *)
    //proxyCrt: THogeCriticalSection;
    netUserAgent: string;         //ユーザーエージェント
    netUseProxy: boolean;         //プロキシを使う
    netProxyServer: string;       //プロキシのサーバー
    netProxyPort: integer;        //プロキシのポート
    netNoCache: boolean;          //プロキシのキャッシュを使わない
    netReadTimeout: integer;      //受信タイムアウト
    netConnectTimeout: integer;   //接続タイムアウト
    //netRecvBufferSize: integer;

    (* 全般 *)
    optDeactiveOption: integer;      //非アクティブになった際の処理 0:何もしない 1:最小化 2:終了する
    optAutoCloseTime: integer;       //終了するまでの時間
    optFPQuality: integer;           //FlashPlayerの再生品質 0:low 1:high 2:autolow 3:autohigh 4:best
    optUseDefaultTitleBar: boolean;  //標準のタイトルバーを使用する
    optCloseToTray: boolean;         //最小化時にタスクトレイに格納
    optClearVideo: boolean;          //最小化時にビデオパネルを空にする
    optNewWindowAnytime: boolean;    //新しいウィンドウでビデオを開く
    optSearchHistoryCount: integer;  //検索履歴数
    optRecentlyViewedCount: integer; //最近視聴した動画履歴数
    optWheelScrollUnderCursor: boolean; //カーソルの下にあるペインをホイールスクロール
    optAllowFavoriteDuplicate: boolean; //「お気に入りに追加」をフォルダの末尾で行う
    optAddFavoriteAtBottom: boolean;    //お気に入りの重複を許可する
    optFavoriteClickOption: boolean;    //お気に入りをクリックで動画を開く
    optListClickOption: boolean;        //リストをクリックで動画を開く
    optFormStayOnTopPlaying: boolean;   //ビデオ再生時のみ最前面表示にする

    (* ウィンドウ *)
    optYouTubeWidth: integer;
    optYouTubeHeight: integer;
    optYouTubeWidthDef: integer;
    optYouTubeHeightDef: integer;
    optNicoVideoWidth: integer;
    optNicoVideoHeight: integer;
    optNicoVideoWidthDef: integer;
    optNicoVideoHeightDef: integer;
    optNicoVideoWidthVideo: integer;
    optNicoVideoHeightVideo: integer;
    optNicoVideoModLeft: integer; 
    optNicoVideoModTop: integer;

    (* YouTube *)
    optUsePlayer2: boolean;          //player2.swfでビデオを再生する
    optAutoPlay: boolean;            //読み込みと同時に再生する
    optUseMP4: boolean;              //H.264(fmt=18)で再生する
    optMP4Format: string;            //H.264再生時のフォーマット
    optSkinPath: string;             //\付きのスキンのパス
    optYouTubeAccount: string;       //YouTubeのアカウント(User Name)
    optYouTubePassword: string;      //YouTubeのアカウント(password)

    (* nicovideo *)
    optNicoVideoAccount: string;     //nicovideoのアカウント(メールアドレス)
    optNicoVideoPassword: string;    //nicovideoのアカウント(パスワード)

    optUseLocalPlayer: boolean;      //ローカルのplayer(flvplayer.swf)で再生する
    optNicoVideoAutoPlay: boolean;   //読み込みと同時に再生する
    optAutoOverlayCheckOn: boolean;  //「コメント非表示」に自動的にチェックする

    (* ツール連動 *)
    optBrowserSpecified: boolean;    //ブラウザを指定する
    optBrowserPath: string;          //ブラウザのパス
    optUseShellExecute: boolean;     //ShellExecuteでブラウザを起動する
    optDownloadOption: integer;      //ダウンロードオプション 0:ブラウザでDL 1: 内蔵ダウンローダでDL 2:ダウンロードツールでDL 3:クリップボードにURLをコピー
    optDownloaderPath: string;       //ダウンロードツールのパス
    optDownloaderOption: string;     //ダウンロードツールの引数

    (* 検索 *)
    optListViewUseExtraBackColor: boolean; //リストの背景を色分けする
    clListViewOddBackColor: TColor;        //奇数行
    clListViewEvenBackColor: TColor;       //偶数行

    (* その他 *)
    optFormStayOnTop: boolean;          //最前面
    optToolBarFixed: boolean;           //ツールバー固定
    optShowToolbarMainMenu: boolean;    //メニューバー
    optShowToolBarToolBar: boolean;     //ツールバー
    optShowToolBarSearchBar: boolean;   //検索バー
    optShowToolBarTitleBar: boolean;    //ビデオタイトルバー
    optShowLogPanel: boolean;           //ログパネル
    optShowFavoritePanel: boolean;      //お気に入りパネル
    optShowVideoInfoPanel: boolean;     //ビデオ情報パネル
    optShowVideoRelatedPanel: boolean;  //関連ビデオパネル
    optShowSearchPanel: boolean;        //検索パネル
    optShowPanelSearchToolBar: boolean; //検索バー(検索パネル)
    optShowSplitter: boolean;           //スプリッター

    optChangeVideoScale: boolean;       //ビデオスケールを変更する(ニコニコ動画用)

    optUpdateCheck: boolean;            //アップデートチェックをする
    optLastUpdateCheckTime: string;     //前回アップデートチェックした日
    optUpdateCheckFailedCount: integer; //アップデートチェックに失敗した回数

    optSearchTarget: Integer;
    (*
    0:YouTube(標準)1:YouTube(関連検索)10:YouTube(サイト内検索)

    2:ニコニコ動画(投稿日時が新しい順) 3:ニコニコ動画(投稿日時が古い順)
    4:ニコニコ動画(再生が多い順)       5:ニコニコ動画(再生が少ない順)
    6:ニコニコ動画(コメントが新しい順) 7:ニコニコ動画(コメントが古い順)
    8:ニコニコ動画(コメントが多い順)   9:ニコニコ動画(コメントが少ない順)

    20:ニコニコ動画(タグ検索-投稿日時が新しい順) 21:ニコニコ動画(タグ検索-投稿日時が古い順)
    22:ニコニコ動画(タグ検索-再生が多い順)       23:ニコニコ動画(タグ検索-再生が少ない順)
    24:ニコニコ動画(タグ検索-コメントが新しい順) 25:ニコニコ動画(タグ検索-コメントが古い順)
    26:ニコニコ動画(タグ検索-コメントが多い順)   27:ニコニコ動画(タグ検索-コメントが少ない順)
    *)
    optSearchVideosYouTubeCategory: Integer;  //Videos取得時のカテゴリ
    optSearchYouTubeCategory: Integer;        //Search時のカテゴリ
    optSearchYouTubeSort: Integer;  //Search時のソート(0:Relevance 1:Date Added 2:View Count 3:Rating)

    optSearchNicoVideoCategory: Integer;        //ニコニコ動画ランキングのカテゴリ

    optNicoVideoSession: string;  //ニコニコ動画のcookie
    optYouTubeSession: string;    //YouTubeのcookie

    ColorChanged: boolean;        //カラーが変更された
    Modified: boolean;            //コンフィグが更新された

    constructor Create;
    destructor Destroy; override;
    procedure Initialize;
    procedure Load;
    procedure Save;
    function crypt(const s:string; decode:boolean = false):string;
  end;

const
  INI_WIN_SECT: string = 'WINDOW';
  INI_NET_SECT: string = 'NET';
  INI_OPT_SECT: string = 'OPTIONS';
  INI_CL_SECT: string  = 'COLOR';

implementation

uses
  Main;

constructor TConfig.Create;
begin
  inherited;
  //proxyCrt :=THogeCriticalSection.Create;
  Initialize;
end;

destructor TConfig.Destroy;
begin
  //proxyCrt.Free;
  grepSearchList.Free;
  inherited;
end;

procedure TConfig.Initialize;
begin
  BasePath := ExtractFilePath(Application.ExeName);
  IniPath := ChangeFileExt(Application.ExeName, '.ini');
  grepSearchList := TStringList.Create;

  netUseProxy := false;
  netProxyPort   := 0;
  netNoCache := false;
  netReadTimeout := 30000; 
  netConnectTimeout := 10000;
  //netRecvBufferSize := 32; (* GRecvBufferSizeDefault==1024*32 *)

  optDeactiveOption := 0;
  optAutoCloseTime := 0;
  optFPQuality := 3;
  optUseDefaultTitleBar := false;
  optCloseToTray := True;
  optClearVideo := false;
  optNewWindowAnytime := false;
  optSearchHistoryCount  := 24;
  optRecentlyViewedCount := 16;
  optWheelScrollUnderCursor := true;
  optAllowFavoriteDuplicate := true;
  optAddFavoriteAtBottom := false;
  optFavoriteClickOption := true;  
  optListClickOption := true;
  optFormStayOnTopPlaying := false;

  //▼変更した場合はTUIConfig.ButtonYouTubeSize2DefClickも修正すること
  optYouTubeWidth       := 450;
  optYouTubeHeight      := 370;
  optYouTubeWidthDef    := 0;
  optYouTubeHeightDef   := 0;
  //▼変更した場合はTUIConfig.ButtonNicoVideoSize2DefClickも修正すること
  optNicoVideoWidth     := 549;
  optNicoVideoHeight    := 473;
  optNicoVideoWidthDef  := 0;
  optNicoVideoHeightDef := 0;
  optNicoVideoWidthVideo  := 549;
  optNicoVideoHeightVideo := 473;
  optNicoVideoModLeft := 6;
  optNicoVideoModTop := 65;

  optUsePlayer2 := true;
  optAutoPlay := true;
  optUseMP4 := true;
  optMP4Format := '';
  optSkinPath := '';

  optYouTubeAccount := '';
  optYouTubePassword := '';

  optNicoVideoAccount := '';
  optNicoVideoPassword := '';

  optUseLocalPlayer := false; 
  optNicoVideoAutoPlay := false;
  optAutoOverlayCheckOn := false;

  optBrowserSpecified:= false;
  optBrowserPath:= '';  
  optUseShellExecute:= false;
  optDownloadOption := 0;
  optDownloaderPath:= '';
  optDownloaderOption:= '';

  optListViewUseExtraBackColor:= True;
  clListViewOddBackColor  := RGB($EF,$EF,$FF);
  clListViewEvenBackColor := RGB($FE,$FF,$FF);

  optFormStayOnTop:= false; 
  optToolBarFixed:= false;
  optShowToolbarMainMenu:= True;
  optShowToolBarToolBar:= True;
  optShowToolBarSearchBar:= True;
  optShowToolBarTitleBar:= True;
  optShowLogPanel:= false;   
  optShowFavoritePanel:= false;
  optShowVideoInfoPanel:= True;
  optShowVideoRelatedPanel:= True;
  optShowSearchPanel:= false;
  optShowPanelSearchToolBar:= false;
  optShowSplitter:= false;

  optChangeVideoScale:= True;

  optUpdateCheck := true;
  optLastUpdateCheckTime := '';
  optUpdateCheckFailedCount := 0;

  optSearchTarget := 0;
  optSearchVideosYouTubeCategory := 0;
  optSearchYouTubeCategory := 0;  
  optSearchYouTubeSort := 0;

  optSearchNicoVideoCategory := 0;

  optNicoVideoSession := '';
  optYouTubeSession := '';

  ColorChanged := false;
  Modified := false;
end;

procedure TConfig.Load;

  function GetFullPath(path: string): string;
  begin
    if (length(path) >= 2) and
       ((path[2] = ':') or (Copy(path, 1, 2) = '\\')) and
       DirectoryExists(path) then
      result := path
    else
      result := BasePath + 'skin\' + path;
    if (path[length(path)] <> '\') then
      result := result + '\';
    if (result = '\') or not DirectoryExists(result) then
      result := BasePath;
  end;

var
  ini: TMemIniFile;
  c: string;
begin
  ini := TMemIniFile.Create(IniPath);

  netUserAgent := ini.ReadString(INI_NET_SECT, 'UserAgent', USERAGENT);
  netUseProxy    := ini.ReadBool(INI_NET_SECT, 'UseProxy', netUseProxy);
  netProxyServer := ini.ReadString(INI_NET_SECT, 'ProxyServer', '');
  netProxyPort   := ini.ReadInteger(INI_NET_SECT, 'ProxyPort', netProxyPort);
  netNoCache := ini.ReadBool(INI_NET_SECT, 'NoCache', netNoCache);
  netReadTimeout := ini.ReadInteger(INI_NET_SECT, 'ReadTimeout', netReadTimeout);
  netConnectTimeout := ini.ReadInteger(INI_NET_SECT, 'ConnectTimeout', netConnectTimeout);
  //netRecvBufferSize := ini.ReadInteger(INI_NET_SECT, 'RecvBufferSize', netRecvBufferSize);

  optDeactiveOption := ini.ReadInteger(INI_OPT_SECT, 'DeactiveOption', optDeactiveOption);
  optAutoCloseTime := ini.ReadInteger(INI_OPT_SECT, 'AutoCloseTime', optAutoCloseTime);
  optFPQuality := ini.ReadInteger(INI_OPT_SECT, 'FPQuality', optFPQuality);
  optUseDefaultTitleBar := ini.ReadBool(INI_OPT_SECT, 'UseDefaultTitleBar', optUseDefaultTitleBar);
  optCloseToTray := ini.ReadBool(INI_OPT_SECT, 'CloseToTray', optCloseToTray);
  optClearVideo := ini.ReadBool(INI_OPT_SECT, 'ClearVideo', optClearVideo);
  optNewWindowAnytime := ini.ReadBool(INI_OPT_SECT, 'NewWindowAnytime', optNewWindowAnytime);
  optSearchHistoryCount := ini.ReadInteger(INI_OPT_SECT, 'SearchHistoryCount', optSearchHistoryCount); 
  optRecentlyViewedCount := ini.ReadInteger(INI_OPT_SECT, 'RecentlyViewedCount', optRecentlyViewedCount);
  optWheelScrollUnderCursor := ini.ReadBool(INI_OPT_SECT, 'WheelScrollUnderCursor', optWheelScrollUnderCursor);
  optAllowFavoriteDuplicate := ini.ReadBool(INI_OPT_SECT, 'AllowFavoriteDuplicate', optAllowFavoriteDuplicate);
  optAddFavoriteAtBottom := ini.ReadBool(INI_OPT_SECT, 'AddFavoriteAtBottom', optAddFavoriteAtBottom);
  optFavoriteClickOption := ini.ReadBool(INI_OPT_SECT, 'FavoriteClickOption', optFavoriteClickOption);
  optListClickOption := ini.ReadBool(INI_OPT_SECT, 'ListClickOption', optListClickOption);
  optFormStayOnTopPlaying := ini.ReadBool(INI_OPT_SECT, 'FormStayOnTopPlaying', optFormStayOnTopPlaying);

  optYouTubeWidth := ini.ReadInteger(INI_OPT_SECT, 'YouTubeWidth', optYouTubeWidth);
  optYouTubeHeight := ini.ReadInteger(INI_OPT_SECT, 'YouTubeHeight', optYouTubeHeight);
  optYouTubeWidthDef := ini.ReadInteger(INI_OPT_SECT, 'YouTubeWidthDef', optYouTubeWidthDef);
  optYouTubeHeightDef := ini.ReadInteger(INI_OPT_SECT, 'YouTubeHeightDef', optYouTubeHeightDef);
  optNicoVideoWidth := ini.ReadInteger(INI_OPT_SECT, 'NicoVideoWidth', optNicoVideoWidth);
  optNicoVideoHeight := ini.ReadInteger(INI_OPT_SECT, 'NicoVideoHeight', optNicoVideoHeight);
  optNicoVideoWidthDef := ini.ReadInteger(INI_OPT_SECT, 'NicoVideoWidthDef', optNicoVideoWidthDef);
  optNicoVideoHeightDef := ini.ReadInteger(INI_OPT_SECT, 'NicoVideoHeightDef', optNicoVideoHeightDef); 
  optNicoVideoWidthVideo := ini.ReadInteger(INI_OPT_SECT, 'NicoVideoWidthVideo', optNicoVideoWidthVideo);
  optNicoVideoHeightVideo := ini.ReadInteger(INI_OPT_SECT, 'NicoVideoHeightVideo', optNicoVideoHeightVideo);
  optNicoVideoModLeft := ini.ReadInteger(INI_OPT_SECT, 'NicoVideoModLeft', optNicoVideoModLeft);  
  optNicoVideoModTop := ini.ReadInteger(INI_OPT_SECT, 'NicoVideoModTop', optNicoVideoModTop);

  optUsePlayer2 := ini.ReadBool(INI_OPT_SECT, 'UsePlayer2', optUsePlayer2);
  optAutoPlay := ini.ReadBool(INI_OPT_SECT, 'AutoPlay', optAutoPlay);
  optUseMP4 := ini.ReadBool(INI_OPT_SECT, 'UseMP4', optUseMP4);
  if optUseMP4 then
    optMP4Format := YOUTUBE_MP4_FMT;
  optSkinPath := ini.ReadString(INI_OPT_SECT, 'SkinPath', optSkinPath);
  if (optSkinPath <> '') then
    optSkinPath := GetFullPath(optSkinPath);

  optYouTubeAccount := ini.ReadString(INI_OPT_SECT, 'YouTubeAccount', optYouTubeAccount);
  optYouTubePassword := crypt(ini.ReadString(INI_OPT_SECT, 'YouTubePassword', optYouTubePassword), True);

  optNicoVideoAccount := ini.ReadString(INI_OPT_SECT, 'NicoVideoAccount', optNicoVideoAccount);
  optNicoVideoPassword := crypt(ini.ReadString(INI_OPT_SECT, 'NicoVideoPassword', optNicoVideoPassword), True);

  optUseLocalPlayer := ini.ReadBool(INI_OPT_SECT, 'UseLocalPlayer', optUseLocalPlayer); 
  optNicoVideoAutoPlay := ini.ReadBool(INI_OPT_SECT, 'NicoVideoAutoPlay', optNicoVideoAutoPlay);
  optAutoOverlayCheckOn := ini.ReadBool(INI_OPT_SECT, 'AutoOverlayCheckOn', optAutoOverlayCheckOn);

  optBrowserSpecified := ini.ReadBool(INI_OPT_SECT, 'BrowserSpecified', optBrowserSpecified);
  optBrowserPath      := ini.ReadString(INI_OPT_SECT, 'BrowserPath', optBrowserPath);
  optUseShellExecute  := ini.ReadBool(INI_OPT_SECT, 'UseShellExecute', optUseShellExecute);
  optDownloadOption   := ini.ReadInteger(INI_OPT_SECT, 'DownloadOption', optDownloadOption);
  optDownloaderPath   := ini.ReadString(INI_OPT_SECT, 'DownloaderPath', optDownloaderPath);
  optDownloaderOption := ini.ReadString(INI_OPT_SECT, 'DownloaderOption', optDownloaderOption);

  optListViewUseExtraBackColor := ini.ReadBool(INI_OPT_SECT, 'ListViewUseExtraBackColor', optListViewUseExtraBackColor);
  c := ini.ReadString(INI_CL_SECT, 'ListViewOddBackColor', '');
  if c <> '' then
    clListViewOddBackColor  := HexToInt(c);
  c := ini.ReadString(INI_CL_SECT, 'ListViewEvenBackColor', '');
  if c <> '' then
    clListViewEvenBackColor := HexToInt(c);

  optFormStayOnTop := ini.ReadBool(INI_OPT_SECT, 'FormStayOnTop', optFormStayOnTop); 
  optToolBarFixed := ini.ReadBool(INI_OPT_SECT, 'ToolBarFixed', optToolBarFixed);
  optShowToolbarMainMenu := ini.ReadBool(INI_OPT_SECT, 'ShowToolbarMainMenu', optShowToolbarMainMenu);
  optShowToolBarToolBar := ini.ReadBool(INI_OPT_SECT, 'ShowToolBarToolBar', optShowToolBarToolBar);
  optShowToolBarSearchBar := ini.ReadBool(INI_OPT_SECT, 'ShowToolBarSearchBar', optShowToolBarSearchBar);
  optShowToolBarTitleBar := ini.ReadBool(INI_OPT_SECT, 'ShowToolBarTitleBar', optShowToolBarTitleBar);
  optShowLogPanel := ini.ReadBool(INI_OPT_SECT, 'ShowLogPanel', optShowLogPanel);
  optShowFavoritePanel := ini.ReadBool(INI_OPT_SECT, 'ShowFavoritePanel', optShowFavoritePanel);
  optShowVideoInfoPanel := ini.ReadBool(INI_OPT_SECT, 'ShowVideoInfoPanel', optShowVideoInfoPanel);
  optShowVideoRelatedPanel := ini.ReadBool(INI_OPT_SECT, 'ShowVideoRelatedPanel', optShowVideoRelatedPanel);
  optShowSearchPanel := ini.ReadBool(INI_OPT_SECT, 'ShowSearchPanel', optShowSearchPanel);
  optShowPanelSearchToolBar := ini.ReadBool(INI_OPT_SECT, 'ShowPanelSearchToolBar', optShowPanelSearchToolBar);
  optShowSplitter := ini.ReadBool(INI_OPT_SECT, 'ShowSplitter', optShowSplitter);
  
  optChangeVideoScale := ini.ReadBool(INI_OPT_SECT, 'ChangeVideoScale', optChangeVideoScale);

  optUpdateCheck := ini.ReadBool(INI_OPT_SECT, 'UpdateCheck', optUpdateCheck);
  optLastUpdateCheckTime := ini.ReadString(INI_OPT_SECT,'LastUpdateCheckTime',optLastUpdateCheckTime);
  optUpdateCheckFailedCount := ini.ReadInteger(INI_OPT_SECT, 'UpdateCheckFailedCount', optUpdateCheckFailedCount);

  optSearchTarget := ini.ReadInteger(INI_OPT_SECT, 'SearchTarget', optSearchTarget);
  optSearchVideosYouTubeCategory := ini.ReadInteger(INI_OPT_SECT, 'SearchVideosYouTubeCategory', optSearchVideosYouTubeCategory);
  optSearchYouTubeCategory := ini.ReadInteger(INI_OPT_SECT, 'SearchYouTubeCategory', optSearchYouTubeCategory);
  optSearchYouTubeSort := ini.ReadInteger(INI_OPT_SECT, 'SearchYouTubeSort', optSearchYouTubeSort);

  optSearchNicoVideoCategory := ini.ReadInteger(INI_OPT_SECT, 'SearchNicoVideoCategory', optSearchNicoVideoCategory);
  //optNicoVideoSession:= ini.ReadString(INI_OPT_SECT,'NicoVideoSession',optNicoVideoSession);


  if optNicoVideoWidthVideo <= 0 then
    optNicoVideoWidthVideo := 549;
  if optNicoVideoHeightVideo <= 0 then
    optNicoVideoHeightVideo := 443;

  //旧バージョンからのサイズ変更(ニコニコ動画仕様変更時用)
  if not optUseLocalPlayer and (optNicoVideoWidthVideo = 549) and (optNicoVideoHeightVideo = 443) and
     (optNicoVideoModLeft = 5) and (optNicoVideoModTop = 100) then
  begin
    optNicoVideoWidthVideo  := 549;
    optNicoVideoHeightVideo := 473;
    optNicoVideoModLeft := 6;
    optNicoVideoModTop := 65;
  end;

  ini.Free;
  if FileExists(BasePath + HISTORY_TXT) then
  try
    grepSearchList.LoadFromFile(BasePath + HISTORY_TXT)
  except
  end;
end;

procedure TConfig.Save;

  procedure SaveColors(ini: TMemIniFile);
  begin
    ini.WriteString(INI_CL_SECT, 'ListViewOddBackColor', IntToHex(clListViewOddBackColor, 8));
    ini.WriteString(INI_CL_SECT, 'ListViewEvenBackColor', IntToHex(clListViewEvenBackColor, 8));
    Main.Config.ColorChanged := false;
  end;

var
  ini: TMemIniFile;

begin
  ini := TMemIniFile.Create(IniPath);

  ini.WriteString(INI_NET_SECT, 'UserAgent', netUserAgent);
  ini.WriteBool(INI_NET_SECT, 'UseProxy', netUseProxy);
  ini.WriteString(INI_NET_SECT, 'ProxyServer', netProxyServer);
  ini.WriteInteger(INI_NET_SECT, 'ProxyPort', netProxyPort);
  ini.WriteBool(INI_NET_SECT, 'NoCache', netNoCache);
  ini.WriteInteger(INI_NET_SECT, 'ReadTimeout', netReadTimeout);
  ini.WriteInteger(INI_NET_SECT, 'ConnectTimeout', netConnectTimeout);
  //ini.WriteInteger(INI_NET_SECT, 'RecvBufferSize', netRecvBufferSize);

  ini.WriteInteger(INI_OPT_SECT, 'DeactiveOption', optDeactiveOption);
  ini.WriteInteger(INI_OPT_SECT, 'AutoCloseTime', optAutoCloseTime);
  ini.WriteInteger(INI_OPT_SECT, 'FPQuality', optFPQuality); 
  ini.WriteBool(INI_OPT_SECT, 'UseDefaultTitleBar', optUseDefaultTitleBar);
  ini.WriteBool(INI_OPT_SECT, 'CloseToTray', optCloseToTray);
  ini.WriteBool(INI_OPT_SECT, 'ClearVideo', optClearVideo);
  ini.WriteBool(INI_OPT_SECT, 'NewWindowAnytime', optNewWindowAnytime);
  ini.WriteInteger(INI_OPT_SECT, 'SearchHistoryCount', optSearchHistoryCount);
  ini.WriteInteger(INI_OPT_SECT, 'RecentlyViewedCount', optRecentlyViewedCount);
  ini.WriteBool(INI_OPT_SECT, 'WheelScrollUnderCursor', optWheelScrollUnderCursor);
  ini.WriteBool(INI_OPT_SECT, 'AllowFavoriteDuplicate', optAllowFavoriteDuplicate); 
  ini.WriteBool(INI_OPT_SECT, 'AddFavoriteAtBottom', optAddFavoriteAtBottom);
  ini.WriteBool(INI_OPT_SECT, 'FavoriteClickOption', optFavoriteClickOption);   
  ini.WriteBool(INI_OPT_SECT, 'ListClickOption', optListClickOption);
  ini.WriteBool(INI_OPT_SECT, 'FormStayOnTopPlaying', optFormStayOnTopPlaying);

  ini.WriteInteger(INI_OPT_SECT, 'YouTubeWidth', optYouTubeWidth);
  ini.WriteInteger(INI_OPT_SECT, 'YouTubeHeight', optYouTubeHeight);
  ini.WriteInteger(INI_OPT_SECT, 'YouTubeWidthDef', optYouTubeWidthDef);
  ini.WriteInteger(INI_OPT_SECT, 'YouTubeHeightDef', optYouTubeHeightDef);
  ini.WriteInteger(INI_OPT_SECT, 'NicoVideoWidth', optNicoVideoWidth);
  ini.WriteInteger(INI_OPT_SECT, 'NicoVideoHeight', optNicoVideoHeight);
  ini.WriteInteger(INI_OPT_SECT, 'NicoVideoWidthDef', optNicoVideoWidthDef);
  ini.WriteInteger(INI_OPT_SECT, 'NicoVideoHeightDef', optNicoVideoHeightDef);
  ini.WriteInteger(INI_OPT_SECT, 'NicoVideoWidthVideo', optNicoVideoWidthVideo);
  ini.WriteInteger(INI_OPT_SECT, 'NicoVideoHeightVideo', optNicoVideoHeightVideo);
  ini.WriteInteger(INI_OPT_SECT, 'NicoVideoModLeft', optNicoVideoModLeft);  
  ini.WriteInteger(INI_OPT_SECT, 'NicoVideoModTop', optNicoVideoModTop);

  ini.WriteBool(INI_OPT_SECT, 'UsePlayer2', optUsePlayer2);
  ini.WriteBool(INI_OPT_SECT, 'AutoPlay', optAutoPlay);
  ini.WriteBool(INI_OPT_SECT, 'UseMP4', optUseMP4);
  ini.WriteString(INI_OPT_SECT, 'SkinPath', optSkinPath);

  ini.WriteString(INI_OPT_SECT, 'YouTubeAccount', optYouTubeAccount);
  ini.WriteString(INI_OPT_SECT, 'YouTubePassword', crypt(optYouTubePassword));

  ini.WriteString(INI_OPT_SECT, 'NicoVideoAccount', optNicoVideoAccount);
  ini.WriteString(INI_OPT_SECT, 'NicoVideoPassword', crypt(optNicoVideoPassword));

  ini.WriteBool(INI_OPT_SECT, 'UseLocalPlayer', optUseLocalPlayer); 
  ini.WriteBool(INI_OPT_SECT, 'NicoVideoAutoPlay', optNicoVideoAutoPlay);
  ini.WriteBool(INI_OPT_SECT, 'AutoOverlayCheckOn', optAutoOverlayCheckOn);

  ini.WriteBool(INI_OPT_SECT, 'BrowserSpecified', optBrowserSpecified);
  ini.WriteString(INI_OPT_SECT, 'BrowserPath', optBrowserPath);
  ini.WriteBool(INI_OPT_SECT, 'UseShellExecute', optUseShellExecute);
  ini.WriteInteger(INI_OPT_SECT, 'DownloadOption', optDownloadOption);
  ini.WriteString(INI_OPT_SECT, 'DownloaderPath', optDownloaderPath);
  ini.WriteString(INI_OPT_SECT, 'DownloaderOption', optDownloaderOption);

  ini.WriteBool(INI_OPT_SECT, 'ListViewUseExtraBackColor', optListViewUseExtraBackColor);

  ini.WriteBool(INI_OPT_SECT, 'FormStayOnTop', optFormStayOnTop);
  ini.WriteBool(INI_OPT_SECT, 'ToolBarFixed', optToolBarFixed);
  ini.WriteBool(INI_OPT_SECT, 'ShowToolbarMainMenu', optShowToolbarMainMenu);
  ini.WriteBool(INI_OPT_SECT, 'ShowToolBarToolBar', optShowToolBarToolBar);
  ini.WriteBool(INI_OPT_SECT, 'ShowToolBarSearchBar', optShowToolBarSearchBar);
  ini.WriteBool(INI_OPT_SECT, 'ShowToolBarTitleBar', optShowToolBarTitleBar);
  ini.WriteBool(INI_OPT_SECT, 'ShowLogPanel', optShowLogPanel);     
  ini.WriteBool(INI_OPT_SECT, 'ShowFavoritePanel', optShowFavoritePanel);
  ini.WriteBool(INI_OPT_SECT, 'ShowVideoInfoPanel', optShowVideoInfoPanel);
  ini.WriteBool(INI_OPT_SECT, 'ShowVideoRelatedPanel', optShowVideoRelatedPanel);
  ini.WriteBool(INI_OPT_SECT, 'ShowSearchPanel', optShowSearchPanel); 
  ini.WriteBool(INI_OPT_SECT, 'ShowPanelSearchToolBar', optShowPanelSearchToolBar);
  ini.WriteBool(INI_OPT_SECT, 'ShowSplitter', optShowSplitter);

  ini.WriteBool(INI_OPT_SECT, 'ChangeVideoScale', optChangeVideoScale);

  ini.WriteBool(INI_OPT_SECT, 'UpdateCheck', optUpdateCheck);
  ini.WriteString(INI_OPT_SECT, 'LastUpdateCheckTime', optLastUpdateCheckTime);
  ini.WriteInteger(INI_OPT_SECT, 'UpdateCheckFailedCount', optUpdateCheckFailedCount);

  ini.WriteInteger(INI_OPT_SECT, 'SearchTarget', optSearchTarget);
  ini.WriteInteger(INI_OPT_SECT, 'SearchVideosYouTubeCategory', optSearchVideosYouTubeCategory);
  ini.WriteInteger(INI_OPT_SECT, 'SearchYouTubeCategory', optSearchYouTubeCategory);
  ini.WriteInteger(INI_OPT_SECT, 'SearchYouTubeSort', optSearchYouTubeSort);

  ini.WriteInteger(INI_OPT_SECT, 'SearchNicoVideoCategory', optSearchNicoVideoCategory);
  //ini.WriteString(INI_OPT_SECT, 'NicoVideoSession', optNicoVideoSession);

  if ColorChanged then
    SaveColors(ini);

  ini.UpdateFile;
  ini.Free;
  Modified := False;
end;

//パスワードの暗号/複合化(cf.MyCipherStr)
function TConfig.crypt(const s:string; decode:boolean = false):string;
var
  i,n,m,siz,r: integer;
const
  k = 'TubePlayer';
begin
  Result := '';
  try
    RandSeed := (ord(k[3])*$10000 + ord(k[1])*$100+ord(k[2]));
    siz := Length(s);
    if siz = 0 then
      exit;
    r := random($FFFF);
    if decode then
      siz := siz div 2;
    for i := 1 to siz do
    begin
      if decode then
        n := StrToInt('$' + copy(s,i*2-1,2))
      else
        n := ord(s[i]);
      m := (n xor ord(k[1+(i mod Length(k))]) xor random(256)) xor (r and $FF);
      if decode then
        r := (r*401 + m)
      else
        r := (r*401 + n);
      if decode then
        Result := Result + Char(m)
      else
        Result := Result + IntToHex(m,2);
    end;
  except
    Result := '';
  end;
end;

end.
