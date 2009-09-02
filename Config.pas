unit Config;
(* �ݒ� *)

interface

uses
  SysUtils, Forms, Classes, IniFiles, Windows, USynchro,
  Graphics, StrSub;

type
  TConfig = class(TObject)
  private
    { Private �錾 }
  public
    { Public �錾 }
    BasePath: string;  //\�t���̃A�v���̃p�X
    IniPath: string;   //ini�t�@�C���̃p�X

    grepSearchList: TStringList; //�������X�g

    (* �ʐM *)
    //proxyCrt: THogeCriticalSection;
    netUserAgent: string;         //���[�U�[�G�[�W�F���g
    netUseProxy: boolean;         //�v���L�V���g��
    netProxyServer: string;       //�v���L�V�̃T�[�o�[
    netProxyPort: integer;        //�v���L�V�̃|�[�g
    netNoCache: boolean;          //�v���L�V�̃L���b�V�����g��Ȃ�
    netReadTimeout: integer;      //��M�^�C���A�E�g
    netConnectTimeout: integer;   //�ڑ��^�C���A�E�g
    //netRecvBufferSize: integer;

    (* �S�� *)
    optDeactiveOption: integer;      //��A�N�e�B�u�ɂȂ����ۂ̏��� 0:�������Ȃ� 1:�ŏ��� 2:�I������
    optAutoCloseTime: integer;       //�I������܂ł̎���
    optFPQuality: integer;           //FlashPlayer�̍Đ��i�� 0:low 1:high 2:autolow 3:autohigh 4:best
    optUseDefaultTitleBar: boolean;  //�W���̃^�C�g���o�[���g�p����
    optCloseToTray: boolean;         //�ŏ������Ƀ^�X�N�g���C�Ɋi�[
    optClearVideo: boolean;          //�ŏ������Ƀr�f�I�p�l������ɂ���
    optNewWindowAnytime: boolean;    //�V�����E�B���h�E�Ńr�f�I���J��
    optSearchHistoryCount: integer;  //��������
    optRecentlyViewedCount: integer; //�ŋߎ����������旚��
    optWheelScrollUnderCursor: boolean; //�J�[�\���̉��ɂ���y�C�����z�C�[���X�N���[��
    optAllowFavoriteDuplicate: boolean; //�u���C�ɓ���ɒǉ��v���t�H���_�̖����ōs��
    optAddFavoriteAtBottom: boolean;    //���C�ɓ���̏d����������
    optFavoriteClickOption: boolean;    //���C�ɓ�����N���b�N�œ�����J��
    optListClickOption: boolean;        //���X�g���N���b�N�œ�����J��
    optFormStayOnTopPlaying: boolean;   //�r�f�I�Đ����̂ݍőO�ʕ\���ɂ���

    (* �E�B���h�E *)
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
    optUsePlayer2: boolean;          //player2.swf�Ńr�f�I���Đ�����
    optAutoPlay: boolean;            //�ǂݍ��݂Ɠ����ɍĐ�����
    optUseMP4: boolean;              //H.264(fmt=18)�ōĐ�����
    optMP4Format: string;            //H.264�Đ����̃t�H�[�}�b�g
    optSkinPath: string;             //\�t���̃X�L���̃p�X
    optYouTubeAccount: string;       //YouTube�̃A�J�E���g(User Name)
    optYouTubePassword: string;      //YouTube�̃A�J�E���g(password)

    (* nicovideo *)
    optNicoVideoAccount: string;     //nicovideo�̃A�J�E���g(���[���A�h���X)
    optNicoVideoPassword: string;    //nicovideo�̃A�J�E���g(�p�X���[�h)

    optUseLocalPlayer: boolean;      //���[�J����player(flvplayer.swf)�ōĐ�����
    optNicoVideoAutoPlay: boolean;   //�ǂݍ��݂Ɠ����ɍĐ�����
    optAutoOverlayCheckOn: boolean;  //�u�R�����g��\���v�Ɏ����I�Ƀ`�F�b�N����

    (* �c�[���A�� *)
    optBrowserSpecified: boolean;    //�u���E�U���w�肷��
    optBrowserPath: string;          //�u���E�U�̃p�X
    optUseShellExecute: boolean;     //ShellExecute�Ńu���E�U���N������
    optDownloadOption: integer;      //�_�E�����[�h�I�v�V���� 0:�u���E�U��DL 1: �����_�E�����[�_��DL 2:�_�E�����[�h�c�[����DL 3:�N���b�v�{�[�h��URL���R�s�[
    optDownloaderPath: string;       //�_�E�����[�h�c�[���̃p�X
    optDownloaderOption: string;     //�_�E�����[�h�c�[���̈���

    (* ���� *)
    optListViewUseExtraBackColor: boolean; //���X�g�̔w�i��F��������
    clListViewOddBackColor: TColor;        //��s
    clListViewEvenBackColor: TColor;       //�����s

    (* ���̑� *)
    optFormStayOnTop: boolean;          //�őO��
    optToolBarFixed: boolean;           //�c�[���o�[�Œ�
    optShowToolbarMainMenu: boolean;    //���j���[�o�[
    optShowToolBarToolBar: boolean;     //�c�[���o�[
    optShowToolBarSearchBar: boolean;   //�����o�[
    optShowToolBarTitleBar: boolean;    //�r�f�I�^�C�g���o�[
    optShowLogPanel: boolean;           //���O�p�l��
    optShowFavoritePanel: boolean;      //���C�ɓ���p�l��
    optShowVideoInfoPanel: boolean;     //�r�f�I���p�l��
    optShowVideoRelatedPanel: boolean;  //�֘A�r�f�I�p�l��
    optShowSearchPanel: boolean;        //�����p�l��
    optShowPanelSearchToolBar: boolean; //�����o�[(�����p�l��)
    optShowSplitter: boolean;           //�X�v���b�^�[

    optChangeVideoScale: boolean;       //�r�f�I�X�P�[����ύX����(�j�R�j�R����p)

    optUpdateCheck: boolean;            //�A�b�v�f�[�g�`�F�b�N������
    optLastUpdateCheckTime: string;     //�O��A�b�v�f�[�g�`�F�b�N������
    optUpdateCheckFailedCount: integer; //�A�b�v�f�[�g�`�F�b�N�Ɏ��s������

    optSearchTarget: Integer;
    (*
    0:YouTube(�W��)1:YouTube(�֘A����)10:YouTube(�T�C�g������)

    2:�j�R�j�R����(���e�������V������) 3:�j�R�j�R����(���e�������Â���)
    4:�j�R�j�R����(�Đ���������)       5:�j�R�j�R����(�Đ������Ȃ���)
    6:�j�R�j�R����(�R�����g���V������) 7:�j�R�j�R����(�R�����g���Â���)
    8:�j�R�j�R����(�R�����g��������)   9:�j�R�j�R����(�R�����g�����Ȃ���)

    20:�j�R�j�R����(�^�O����-���e�������V������) 21:�j�R�j�R����(�^�O����-���e�������Â���)
    22:�j�R�j�R����(�^�O����-�Đ���������)       23:�j�R�j�R����(�^�O����-�Đ������Ȃ���)
    24:�j�R�j�R����(�^�O����-�R�����g���V������) 25:�j�R�j�R����(�^�O����-�R�����g���Â���)
    26:�j�R�j�R����(�^�O����-�R�����g��������)   27:�j�R�j�R����(�^�O����-�R�����g�����Ȃ���)
    *)
    optSearchVideosYouTubeCategory: Integer;  //Videos�擾���̃J�e�S��
    optSearchYouTubeCategory: Integer;        //Search���̃J�e�S��
    optSearchYouTubeSort: Integer;  //Search���̃\�[�g(0:Relevance 1:Date Added 2:View Count 3:Rating)

    optSearchNicoVideoCategory: Integer;        //�j�R�j�R���惉���L���O�̃J�e�S��

    optNicoVideoSession: string;  //�j�R�j�R�����cookie
    optYouTubeSession: string;    //YouTube��cookie

    ColorChanged: boolean;        //�J���[���ύX���ꂽ
    Modified: boolean;            //�R���t�B�O���X�V���ꂽ

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

  //���ύX�����ꍇ��TUIConfig.ButtonYouTubeSize2DefClick���C�����邱��
  optYouTubeWidth       := 450;
  optYouTubeHeight      := 370;
  optYouTubeWidthDef    := 0;
  optYouTubeHeightDef   := 0;
  //���ύX�����ꍇ��TUIConfig.ButtonNicoVideoSize2DefClick���C�����邱��
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

  //���o�[�W��������̃T�C�Y�ύX(�j�R�j�R����d�l�ύX���p)
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

//�p�X���[�h�̈Í�/������(cf.MyCipherStr)
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
