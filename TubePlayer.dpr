program TubePlayer;

uses
  FastMM4,
  FastMove,
  Forms,
  Main in 'Main.pas' {MainWnd},
  USynchro in 'USynchro.pas',
  USharedMem in 'USharedMem.pas',
  JLTrayIcon in 'Components\JLTrayIcon.pas',
  UAsync in 'UAsync.pas',
  Config in 'Config.pas',
  UIDlg in 'UIDlg.pas',
  UVersionInfo in 'UVersionInfo.pas' {VersionInfo},
  UUIConfig in 'UUIConfig.pas' {UIConfig},
  StrSub in 'StrSub.pas',
  UUpdateDlg in 'UUpdateDlg.pas' {UpdateDlg},
  UBugReport in 'UBugReport.pas' {BugReport},
  FileVerInfo in 'Components\FileVerInfo.pas',
  HTTPSub in 'HTTPSub.pas',
  UFavorite in 'UFavorite.pas',
  JMemory in 'Components\JMemory.pas',
  CommonUtils in 'CommonUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'TubePlayer';
  if not Main.OnStartup then
    exit;
  Application.CreateForm(TMainWnd, MainWnd);
  Application.Run;
end.
