unit UBugReport;
(* �o�O���|�[�g *)
(* http://homepage1.nifty.com/ht_deko/tech002.html *)
(* http://www.cafe-au-lait.info/softs/ *)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TntStdCtrls, Registry, Clipbrd, JMemory,
  TBXDkPanels, SpTBXControls;

const
  LABEL_CAPTION = 'TubePlayer �̕s��𔭌����ꂽ���͉��L�̃e���v���[�g��p����'+ #13#10 +
                  '�u�\�t�g�E�F�A�v�́uTubePlayer && SmileDownloader Part**�v�̃X���b�h�ɕ񍐂��ĉ������B' + #13#10 +
                  '�񍐂����Ƃɕs����ł������C���������Ǝv���܂��B';

  LABEL2_CAPTION = '���s��񍐂͍ŐV�o�[�W�����̂ݎ󂯕t���Ă��܂��B' + #13#10 +
                   '���o���邾���ڂ����A��̓I�ɂ��肢���܂��B�u�����������灢���ɂȂ�܂����v���B' + #13#10 +
                   '���G���[�_�C�A���O���o����͂��̓��e���Y���Ă��������B' + #13#10 +
                   '���G���[�_�C�A���O�Ƀt�H�[�J�X�𓖂Ă�Ctrl+C�ŃG���[�̓��e���R�s�[�ł��܂��B';

  CPUID_SUCCESS   = 0;//�֐��͐���ɏI������
  CPUID_DISABLED  = 1;//CPUID �͎g�p�ł��Ȃ�
  CPUID_MAXIINPUT = 2;//���擾�ԍ����ő���͒l�𒴂���

function EnableRDTSC: Boolean;
function GetCPUClock: String;
function timeGetTime:DWORD; stdcall; external 'winmm.dll';

function GetOSVersion:Integer;
function GetOSName:String;

function GetAvailableMemory: String;
function GetIEVersion: String;

function GetWSHVersion: String;
function GetExeVersion: String;
function GetFlashVersion: String;

function GetOption: String;

type
  TBugReport = class(TForm)
    Memo: TTntMemo;
    Label1: TSpTBXLabel;
    ButtonCopy: TSpTBXButton;
    Label2: TSpTBXLabel;
    LabelURI: TSpTBXLabel;
    procedure FormCreate(Sender: TObject);
    procedure ButtonCopyClick(Sender: TObject);
    procedure LabelURIClick(Sender: TObject);
  private
    { Private �錾 }
  public
    { Public �錾 }
  end;

  TCPUID = record
    case Integer of
      0:(
        idInput: Longword;          //�ő���擾�ԍ�
        idStr1 : array[0..3]of Char;//������1
        idStr2 : array[0..3]of Char;//������2
        idStr3 : array[0..3]of Char;//������3
      );
      1:(
       idEAX: Longword;//EAX ���W�X�^�̓��e
       idEBX: Longword;//EBX ���W�X�^�̓��e
       idECX: Longword;//ECX ���W�X�^�̓��e
       idEDX: Longword;//EDX ���W�X�^�̓��e
      );
    end;

var
  BugReport: TBugReport;

implementation

{$R *.dfm}

uses Main;

function GetCPUID(Input: DWORD; var Ident: TCPUID): Longint; assembler;
//******************************************************************************
// [ ���� ]
// Input = ���擾�ԍ�
// Ident = CPU�̏����i�[���� TCPUID ���R�[�h�ϐ�
//------------------------------------------------------------------------------
// [ �߂�l ]
// �֐�������ɏI��     = CPUID_SUCCESS
// CPUID �͎g�p�s��     = CPUID_DISABLED
// Input ���s��         = CPUID_MAXIINPUT
//******************************************************************************
asm
       //EAX = Input
       //EDX = Ident
       push   esi                  //esi ���v�b�V��
       push   edi                  //edi ���v�b�V��
       push   ebx                  //ebx ���v�b�V��
       mov    esi, eax             //Input �� esi �ɑޔ�
       mov    edi, edx             //Ident �� edi �ɑޔ�
       pushfd                      //EFLAGS ���v�b�V��
       pop    ecx                  //ecx �Ƀ|�b�v
       mov    edx, ecx             //ecx �͌�Ŏg���̂� edx �ɑ��
       xor    edx, $200000         //�r�b�g 21 �𔽓]
       push   edx                  //edx ���v�b�V��
       popfd                       //EFLAGS �Ƀ|�b�v
       pushfd                      //EFLAGS ���v�b�V��
       pop    edx                  //edx �Ƀ|�b�v
       xor    edx, ecx             //�r�b�g21���N���A����Ă��邩�H
       jz     @@ERR1               //ZF = 0�̏ꍇ CPUID ���g����
                                   //Ident.idInput �̃`�F�b�N
       xor    eax, eax             //eax := 0
       dw     $A20F                //CPUID����(�@�B��)
       cmp    esi, eax             //if Input > eax then
       jg     @@ERR2               //@@ERR2 �փW�����v
       test   esi, esi             //if Input = 0 then
       jz     @@ZERO               //@@ZERO �փW�����v
       mov    eax, esi             //eax := Input
       dw     $A20F                //CPUID
@@ZERO:
       mov    [edi], eax           //Ident.idEAX := eax
       mov    [edi+$04], ebx       //Ident.idEBX := ebx
       mov    [edi+$08], ecx       //Ident.idECX := ecx
       mov    [edi+$0C], edx       //Ident.idEDX := edx
       mov    eax, CPUID_SUCCESS   //Result := CPUID_SUCCESS
       jmp    @@EXIT               //�����
@@ERR1:
       mov    eax, CPUID_DISABLED  //Result := CPUID_DISABLED
       jmp    @@EXIT               //�����
@@ERR2:
       mov    eax, CPUID_MAXIINPUT //Result := CPUID_MAXIINPUT
@@EXIT:
       pop    ebx                  //ebx ���|�b�v
       pop    edi                  //edi ���|�b�v
       pop    esi                  //esi ���|�b�v
end;

function EnableRDTSC: Boolean;
begin
  asm
    push eax
    push ebx
    push ecx
    push edx
    mov eax, $0
    dw $A20F
    cmp eax, $0
    jz @@ERR
    mov eax, $1
    dw $A20F
    and edx, $10
    cmp edx, $10
    jnz @@ERR
    mov @Result, $1
    jmp @@EXIT
@@ERR:
    mov @Result, $0
@@EXIT:
    pop edx
    pop ecx
    pop ebx
    pop eax
  end;
end;

function GetCPUClock: String;
var
  StartLo     : DWORD;
  StartHi     : DWORD;
  CurrentLo   : DWORD;
  CurrentHi   : DWORD;
  TickCount   : DWORD;
  dwStart     : DWORD;
  dwEnd       : DWORD;
  lPre        : Int64;
  lStart      : Int64;
  lEnd        : Int64;
  lFrequency  : Int64;
  Clock       : Int64;
  Start       : Int64;
  Current     : Int64;
  ID          : TCPUID;
  totalTimeQPC: Double;
  totalTimeWT : Double;
const
  ERROR_RATE = 1000/1000.0/10;
begin
  try
    if (GetCPUID($80860000,ID)=CPUID_SUCCESS) and (ID.idEAX>$80860000) then
    begin
      GetCPUID($80860001, ID);
      Clock:=ID.idECX*1000000;
    end else if EnableRDTSC then
    begin
      QueryPerformanceCounter(lPre);
      QueryPerformanceCounter(lStart);
      asm
        dw $310F          // RDTSC����(�@�B��)
        mov StartLo, eax
        mov StartHi, edx
      end;
      dwStart:=timeGetTime;
      TickCount:=timeGetTime;
      while timeGetTime-TickCount<1000 do;
      dwEnd:=timeGetTime;
      asm
        dw $310F
        mov CurrentLo, eax
        mov CurrentHi, edx
      end;
      QueryPerformanceCounter(lEnd);
      QueryPerformanceFrequency(lFrequency);
      Start := StartHi;
      Start := StartLo or Start shl 32;
      Current := CurrentHi;
      Current := CurrentLo or Current shl 32;
      totalTimeQPC:=((lEnd-lStart)-(lStart-lPre))/lFrequency;
      totalTimeWT:=(dwEnd-dwStart)/1000;
      if ((totalTimeWT-ERROR_RATE)<totalTimeQPC) and (totalTimeQPC<(totalTimeWT+ERROR_RATE)) then
        Clock := Trunc((Current - Start)/totalTimeQPC)
      else
        Clock := Trunc((Current - Start)/totalTimeWT);
    end
    else
      Clock:=0;
    if Clock > 0 then
      Result := FormatFloat( '####', Clock / 1000000 ) +'MHz'
    else
      Result := '�s��';
  except
    Result := '�s��';
  end;
end;

function GetOSVersion:Integer;
var
  Version:TOSVERSIONINFO;
begin
  result := 0;
  Version.dwOSVersionInfoSize := SizeOf(Version);
  if GetVersionEx(Version) then
    result := (Version.dwMajorVersion  * 1000000) + (Version.dwMinorVersion * 10000) + Version.dwBuildNumber;
end;

//Windows<OS��or�o�[�W����> <�G�f�B�V����> <Server/Workstation> <[ServicePack]>
function GetOSName:String;
// http://msdn.microsoft.com/library/default.asp?url=/library/en-us/sysinfo/sysinfo_3a0i.asp
// http://msdn.microsoft.com/library/default.asp?url=/library/en-us/sysinfo/sysinfo_1o1e.asp
// http://www.microsoft.com/japan/support/kb/articles/JP158/2/38.asp
// http://msdn.microsoft.com/library/en-us/sysinfo/base/getting_the_system_version.asp
// http://msdn.microsoft.com/library/en-us/sysinfo/base/getnativesysteminfo.asp
type
TOSVERSIONINFOEX =
   packed record
     dwOSVersionInfoSize:Cardinal;
     dwMajorVersion     :Cardinal;
     dwMinorVersion     :Cardinal;
     dwBuildNumber      :Cardinal;
     dwPlatformId       :Cardinal;
     szCSDVersion       :array [0..127] of Char;
     wServicePackMajor  :Word;
     wServicePackMinor  :Word;
     wSuiteMask         :Word;
     wProductType       :Byte;
     wReserved          :Byte;
   end;
const
  VER_NT_WORKSTATION       = 1;
  VER_NT_DOMAIN_CONTROLLER = 2;
  VER_NT_SERVER            = 3;
  VER_SUITE_SMALLBUSINESS            = $0001;
  VER_SUITE_ENTERPRISE               = $0002;
  VER_SUITE_BACKOFFICE               = $0004;
  VER_SUITE_TERMINAL                 = $0010;
  VER_SUITE_SMALLBUSINESS_RESTRICTED = $0020;
  VER_SUITE_DATACENTER               = $0080;
  VER_SUITE_SINGLEUSERTS             = $0100;
  VER_SUITE_PERSONAL                 = $0200;
  VER_SUITE_BLADE                    = $0400;

  PROCESSOR_ARCHITECTURE_INTEL         =  0;
  PROCESSOR_ARCHITECTURE_MIPS          =  1;
  PROCESSOR_ARCHITECTURE_ALPHA         =  2;
  PROCESSOR_ARCHITECTURE_PPC           =  3;
  PROCESSOR_ARCHITECTURE_SHX           =  4;
  PROCESSOR_ARCHITECTURE_ARM           =  5;
  PROCESSOR_ARCHITECTURE_IA64          =  6;
  PROCESSOR_ARCHITECTURE_ALPHA64       =  7;
  PROCESSOR_ARCHITECTURE_MSIL          =  8;
  PROCESSOR_ARCHITECTURE_AMD64         =  9;
  PROCESSOR_ARCHITECTURE_IA32_ON_WIN64 = 10;
  SM_SERVERR2 = 80;
  PRODUCT_UNDEFINED                    = $00000000;
  PRODUCT_ULTIMATE                     = $00000001;
  PRODUCT_HOME_BASIC                   = $00000002;
  PRODUCT_HOME_PREMIUM                 = $00000003;
  PRODUCT_ENTERPRISE                   = $00000004;
  PRODUCT_HOME_BASIC_N                 = $00000005;
  PRODUCT_BUSINESS                     = $00000006;
  PRODUCT_STANDARD_SERVER              = $00000007;
  PRODUCT_DATACENTER_SERVER            = $00000008;
  PRODUCT_SMALLBUSINESS_SERVER         = $00000009;
  PRODUCT_ENTERPRISE_SERVER            = $0000000A;
  PRODUCT_STARTER                      = $0000000B;
  PRODUCT_DATACENTER_SERVER_CORE       = $0000000C;
  PRODUCT_STANDARD_SERVER_CORE         = $0000000D;
  PRODUCT_ENTERPRISE_SERVER_CORE       = $0000000E;
  PRODUCT_ENTERPRISE_SERVER_IA64       = $0000000F;
  PRODUCT_BUSINESS_N                   = $00000010;
  PRODUCT_WEB_SERVER                   = $00000011;
  PRODUCT_CLUSTER_SERVER               = $00000012;
  PRODUCT_HOME_SERVER                  = $00000013;
  PRODUCT_STORAGE_EXPRESS_SERVER       = $00000014;
  PRODUCT_STORAGE_STANDARD_SERVER      = $00000015;
  PRODUCT_STORAGE_WORKGROUP_SERVER     = $00000016;
  PRODUCT_STORAGE_ENTERPRISE_SERVER    = $00000017;
  PRODUCT_SERVER_FOR_SMALLBUSINESS     = $00000018;
  PRODUCT_SMALLBUSINESS_SERVER_PREMIUM = $00000019;  
var
  Unknown:Boolean;
  SP,
  Dmy:String;
  Version:TOSVERSIONINFO;
  VersionEX:TOSVERSIONINFOEX;
  SystemInfo:SYSTEM_INFO;
  {StatusEx begin}
  function StatusEx:TOSVERSIONINFOEX;
  var
    po :TFarProc;
    DLLWnd :THandle;
    VEX:TOSVERSIONINFOEX;
    GetVersionEx2:function(var LPOSVERSIONINFO:TOSVERSIONINFOEX):Boolean;stdcall;
  begin
    po := nil;
    DLLWnd := LoadLibrary('kernel32');
    if DLLWnd > 0 then
    begin
      try
        po := GetProcAddress(DLLWnd, 'GetVersionExA');
        if po <> nil then
        begin
          @GetVersionEx2 := po;
          VEX.dwOSVersionInfoSize := SizeOf(VEX);
          if GetVersionEx2(VEX) then
            result := VEX;
        end;
      finally
        FreeLibrary(DLLWnd);
      end;
    end;
  end;
  {StatusEx end}
  {StatusEx2 begin}
  function StatusEx2:SYSTEM_INFO;
  var
    po :TFarProc;
    DLLWnd :THandle;
    SI:SYSTEM_INFO;
    GetNativeSystemInfo:procedure(var LPSYSTEM_INFO:SYSTEM_INFO);stdcall;
  begin
    po := nil;
    DLLWnd := LoadLibrary('kernel32');
    if DLLWnd > 0 then
    begin
      try
        po := GetProcAddress(DLLWnd, 'GetNativeSystemInfo');
        if po <> nil then
        begin
          @GetNativeSystemInfo := po;
          GetNativeSystemInfo(SI);
          result := SI;
        end;
      finally
        FreeLibrary(DLLWnd);
      end;
    end;
  end;
  {StatusEx2 end}
  {StatusEx3 begin}
  function StatusEx3(OSMajor,OSMinor,SPMajor,SPMinor:DWORD):DWORD;
  var
    po :TFarProc;
    DLLWnd :THandle;
    PT:DWORD;
    GetProductInfo:function(AOSMajor,AOSMinor,ASPMajor,ASPMinor:DWORD; var ProductType:DWORD):Boolean;stdcall;
  begin
    result := 0;
    po := nil;
    DLLWnd := LoadLibrary('kernel32');
    if DLLWnd > 0 then
      begin
        try
          po := GetProcAddress(DLLWnd, 'GetProductInfo');
          if po <> nil then
            begin
              @GetProductInfo := po;
              GetProductInfo(OSMajor,OSMinor,SPMajor,SPMinor,PT);
              result := PT;
            end;
        finally
          FreeLibrary(DLLWnd);
        end;
      end;
  end;
  {StatusEx3 end}  
begin
  result := '';
  Version.dwOSVersionInfoSize := SizeOf(Version);
  if GetVersionEx(Version) then
  begin
    Dmy := 'Windows';
    SP := Trim(StrPas(Version.szCSDVersion));
    case Version.dwPlatformId of
      // Windows3.1(Win32s)
      VER_PLATFORM_WIN32s:
        Dmy := Dmy + Format('%d.%d(Win32s)',[Version.dwMajorVersion,Version.dwMinorVersion]);
      // Windows9x�n
      VER_PLATFORM_WIN32_WINDOWS:
        begin
          case Version.dwMinorVersion of
            // Windows95
            00:begin
                 Dmy := Dmy + '95';
                 case LOWORD(Version.dwBuildNumber) of
                   1111:
                     Dmy := Dmy + ' OSR2';
                   1212..1213:
                     Dmy := Dmy + ' OSR2.1';
                   1214..9999:
                     Dmy := Dmy + ' OSR2.5';
                 end;
               end;
            // Windows98
            10:begin
                 Dmy := Dmy + '98';
                 case LOWORD(Version.dwBuildNumber) of
                  2222..9999:
                   Dmy := Dmy + ' Second Edition';
                 end;
               end;
            // WindowsMe
            90:Dmy := Dmy + 'Me';
          end;
        end;
      // WindowsNT�n
      VER_PLATFORM_WIN32_NT:
        begin
          Unknown := False;
          case Version.dwMajorVersion of
            5:begin
                VersionEx := StatusEx;
                case Version.dwMinorVersion of
                  // 2000
                  0:begin
                      Dmy := Dmy + '2000 ';
                      case VersionEx.wProductType of
                        VER_NT_WORKSTATION:
                          Dmy := Dmy + 'Professional';
                      else
                        Dmy := Dmy + 'Server';
                      end;
                    end;
                  // XP
                  1:begin
                      case VersionEx.wProductType of
                        VER_NT_WORKSTATION:
                          begin
                            Dmy := Dmy + 'XP ';
                            if (VersionEx.wSuiteMask and VER_SUITE_PERSONAL) = VER_SUITE_PERSONAL then
                              Dmy := Dmy + 'Home Edition'
                            else
                              Dmy := Dmy + 'Professional';
                          end;
                      else
                        Dmy := Dmy + 'Server 2003';
                      end;
                    end;
                  // XP
                  2:begin
                      SystemInfo := StatusEx2;
                      case VersionEx.wProductType of
                        VER_NT_WORKSTATION:
                          begin
                            if SystemInfo.wProcessorArchitecture = PROCESSOR_ARCHITECTURE_AMD64 then
                              Dmy := Dmy + 'XP Professional x64 Edition'
                            else
                              Unknown := True;
                          end;
                        VER_NT_SERVER,
                        VER_NT_DOMAIN_CONTROLLER:
                          begin
                            Dmy := Dmy + 'Server 2003 ';
                            case SystemInfo.wProcessorArchitecture of
                              PROCESSOR_ARCHITECTURE_IA64:
                                begin
                                  if (VersionEx.wSuiteMask and VER_SUITE_DATACENTER)      = VER_SUITE_DATACENTER then
                                    Dmy := Dmy + 'Datacenter Edition for Itanium-based Systems'
                                  else if (VersionEx.wSuiteMask and VER_SUITE_ENTERPRISE) = VER_SUITE_ENTERPRISE then
                                    Dmy := Dmy + 'Enterprise Edition for Itanium-based Systems'
                                  else
                                    Dmy := Dmy + 'Standard Edition for Itanium-based Systems';
                                end;
                              PROCESSOR_ARCHITECTURE_AMD64:
                                begin
                                  if (VersionEx.wSuiteMask and VER_SUITE_DATACENTER)      = VER_SUITE_DATACENTER then
                                    Dmy := Dmy + 'Datacenter x64 Edition'
                                  else if (VersionEx.wSuiteMask and VER_SUITE_ENTERPRISE) = VER_SUITE_ENTERPRISE then
                                    Dmy := Dmy + 'Enterprise x64 Edition'
                                  else
                                    Dmy := Dmy + 'Standard x64 Edition';
                                end;
                            else
                              if (VersionEx.wSuiteMask and VER_SUITE_DATACENTER)      = VER_SUITE_DATACENTER then
                                Dmy := Dmy + 'Datacenter Edition'
                              else if (VersionEx.wSuiteMask and VER_SUITE_ENTERPRISE) = VER_SUITE_ENTERPRISE then
                                Dmy := Dmy + 'Enterprise Edition'
                              else if (VersionEx.wSuiteMask and VER_SUITE_BLADE)      = VER_SUITE_BLADE then
                                Dmy := Dmy + 'Web Edition'
                              else
                                Dmy := Dmy + 'Standard Edition';
                            end;
                          end;
                        else
                          Unknown := True;
                      end;
                    end;
                else
                  Unknown := True;
                end;
              end;
            6:begin
                VersionEx := StatusEx;
                case Version.dwMinorVersion of
                  0:begin
                      case VersionEx.wProductType of
                        VER_NT_WORKSTATION:
                          begin
                            Dmy := Dmy + ' Vista ';
                            case StatusEx3(Version.dwMajorVersion,Version.dwMinorVersion,0,0) of
                              PRODUCT_ULTIMATE:
                                Dmy := Dmy + 'Ultimate';
                              PRODUCT_HOME_BASIC:
                                Dmy := Dmy + 'Home Basic';
                              PRODUCT_HOME_PREMIUM:
                                Dmy := Dmy + 'Home Premium';
                              PRODUCT_ENTERPRISE:
                                Dmy := Dmy + 'Business';
                              PRODUCT_HOME_BASIC_N:
                                Dmy := Dmy + 'Home Basic N';
                              PRODUCT_BUSINESS:
                                Dmy := Dmy + 'Business';
                              PRODUCT_STARTER:
                                Dmy := Dmy + 'Starter Edition';
                              PRODUCT_BUSINESS_N:
                                Dmy := Dmy + 'Business N';
                            end;
                          end;
                      else
                        Dmy := Dmy + 'Server 2008 ';
                        if GetSystemMetrics(SM_SERVERR2) = 1 then
                          Dmy := Dmy + 'R2 ';
                        case StatusEx3(Version.dwMajorVersion,Version.dwMinorVersion,0,0) of
                          PRODUCT_STANDARD_SERVER:
                                          Dmy := Dmy + 'Standard Edition';
                          PRODUCT_DATACENTER_SERVER:
                            Dmy := Dmy + 'Datacenter Edition';
                          PRODUCT_SMALLBUSINESS_SERVER:
                            Dmy := Dmy + 'Small Business Server';
                          PRODUCT_ENTERPRISE_SERVER:
                            Dmy := Dmy + 'Enterprise Edition';
                          PRODUCT_DATACENTER_SERVER_CORE:
                           Dmy := Dmy + 'Datacenter Edition(Core)';
                          PRODUCT_STANDARD_SERVER_CORE:
                            Dmy := Dmy + 'Standard Edition(Core)';
                          PRODUCT_ENTERPRISE_SERVER_CORE:
                            Dmy := Dmy + 'Enterprise Edition(Core)';
                          PRODUCT_ENTERPRISE_SERVER_IA64:
                            Dmy := Dmy + 'Enterprise Edition for Itanium-based Systems';
                          PRODUCT_WEB_SERVER:
                            Dmy := Dmy + 'Web Server Edition';
                          PRODUCT_CLUSTER_SERVER:
                            Dmy := Dmy + 'Cluster Server Edition';
                          PRODUCT_HOME_SERVER:
                            Dmy := Dmy + 'Home Server Edition';
                          PRODUCT_STORAGE_EXPRESS_SERVER:
                            Dmy := Dmy + 'Storage Server Express Edition';
                          PRODUCT_STORAGE_STANDARD_SERVER:
                            Dmy := Dmy + 'Storage Server Standard Edition';
                          PRODUCT_STORAGE_WORKGROUP_SERVER:
                            Dmy := Dmy + 'Storage Server Workgroup Edition';
                          PRODUCT_STORAGE_ENTERPRISE_SERVER:
                            Dmy := Dmy + 'Storage Server Enterprise Edition';
                          PRODUCT_SERVER_FOR_SMALLBUSINESS:
                            Dmy := Dmy + 'for Small Business Edition';
                          PRODUCT_SMALLBUSINESS_SERVER_PREMIUM:
                            Dmy := Dmy + 'Small Business Server Premium Edition';
                        end;
                      end;
                      case SystemInfo.wProcessorArchitecture of
                        PROCESSOR_ARCHITECTURE_IA64:
                          Dmy := Dmy + '(IA64)';
                        PROCESSOR_ARCHITECTURE_AMD64:
                          Dmy := Dmy + '(x64)';
                      end;
                    end;
                else
                  Unknown := True;
                end;
              end;
          else
            Unknown := True;
          end;
          if Unknown then
            begin
              Dmy := Dmy + Format('NT%d.%d ',[Version.dwMajorVersion,Version.dwMinorVersion]);
              // NT4.0 SP6�ȍ~ or XP�ȍ~
              if (Version.dwMajorVersion >= 5) or
                 ((Version.dwMajorVersion = 4) and (Pos('6',SP) > 0)) then
              begin
                VersionEx := StatusEx;
                case VersionEx.wProductType of
                  VER_NT_WORKSTATION:
                     Dmy := Dmy + 'WorkStation';
                else
                  Dmy := Dmy + 'Server';
                end;
              end;
            end;
        end;
    end;
    if Length(SP) > 0 then
      Dmy := Dmy + Format(' [%s]',[SP]);
  end;
  result := Dmy;
end;

function GetAvailableMemory_NT: String;
var
  pmse : LPMEMORYSTATUSEX;
begin
  pmse := AllocMem(SizeOf(_MEMORYSTATUSEX));
  pmse^.dwLength := SizeOf(_MEMORYSTATUSEX);
  try
    if GlobalMemoryStatusNT(pmse) then
      Result := IntToStr(pmse.ullTotalPhys div 1024 div 1024) + 'MB (' + IntToStr(pmse.ullAvailPhys div 1024 div 1024) + 'MB Free)'
    else
      Result := '�s��';
  finally
    FreeMem(pmse,SizeOf(_MEMORYSTATUSEX));
  end;
end;

function GetAvailableMemory_9x: String;
var
  ms:TMemoryStatus;
begin
  try
    ms.dwLength := SizeOf(TMemoryStatus);
    GlobalMemoryStatus(ms);
    Result := IntToStr(ms.dwTotalPhys div 1024 div 1024) + 'MB (' + IntToStr(ms.dwAvailPhys div 1024 div 1024) + 'MB Free)';
  except
    Result := '�s��';
  end;
end;

function GetAvailableMemory: String;
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then //2000�ȍ~��API
    Result := GetAvailableMemory_NT
  else
    Result := GetAvailableMemory_9x;
end;

function GetIEVersion: string;
var
  R: TRegistry;
begin
  R := TRegistry.Create;
  try
    R.RootKey := HKEY_LOCAL_MACHINE;
    if R.OpenKeyReadOnly('Software\Microsoft\Internet Explorer') then
    begin
      try
        Result := R.ReadString('version');
      except
        Result := '�s��';
      end;
    end else
      Result := '�s��';
    R.CloseKey;
  finally
    R.Free;
  end;
end;

function GetWSHVersion: String;
const
  VBS_DLL = 'vbscript.dll';
var
  SystemPath : array [0..256] of char;
  DllPath: string;
begin
  Result := '�s��';
  GetSystemDirectory(SystemPath, sizeof(SystemPath));
  DllPath := String(SystemPath) + '\' + VBS_DLL;
  if not FileExists(DllPath) then
    exit;

  MainWnd.FileVerInfo.FileName := DllPath;
  if MainWnd.FileVerInfo.HasVerInfo then
    Result := MainWnd.FileVerInfo.FileVersion;
end;

function GetExeVersion: String;
begin
  Result := '�s��';
  MainWnd.FileVerInfo.FileName := ParamStr(0);
  if MainWnd.FileVerInfo.HasVerInfo then
    Result := MainWnd.FileVerInfo.FileVersion;
end;

function GetFlashVersion: String;
const
  FLASH9_OCX  = 'Flash9.ocx';
  FLASH9B_OCX = 'Flash9b.ocx';
  FLASH9C_OCX = 'Flash9c.ocx'; 
  FLASH9D_OCX = 'Flash9d.ocx';
  FLASH9E_OCX = 'Flash9e.ocx';
  FLASH9F_OCX = 'Flash9f.ocx';
  FLASH9G_OCX = 'Flash9g.ocx'; //�o�Ă��Ȃ�
  FLASH10A_OCX = 'Flash10a.ocx';
  FLASH10B_OCX = 'Flash10b.ocx'; //�܂��o�Ă��Ȃ�
  FLASH10C_OCX = 'Flash10c.ocx'; //�܂��o�Ă��Ȃ�

  FLASH8_OCX  = 'Flash8.ocx';
  FLASH_OCX   = 'Flash.ocx';
var
  SystemPath : array [0..256] of char;
  DllPath: string;
  IsOK: boolean;
begin
  Result := '�s��';
  IsOk := false;
  GetSystemDirectory(SystemPath, sizeof(SystemPath));   
  if not IsOk then
  begin
    DllPath := String(SystemPath) + '\Macromed\Flash\' + FLASH10C_OCX;
    if FileExists(DllPath) then
      IsOK := True;
  end;
  if not IsOk then
  begin
    DllPath := String(SystemPath) + '\Macromed\Flash\' + FLASH10B_OCX;
    if FileExists(DllPath) then
      IsOK := True;
  end;
  if not IsOk then
  begin
    DllPath := String(SystemPath) + '\Macromed\Flash\' + FLASH10A_OCX;
    if FileExists(DllPath) then
      IsOK := True;
  end;
  if not IsOk then
  begin
    DllPath := String(SystemPath) + '\Macromed\Flash\' + FLASH9G_OCX;
    if FileExists(DllPath) then
      IsOK := True;
  end;
  if not IsOk then
  begin
    DllPath := String(SystemPath) + '\Macromed\Flash\' + FLASH9F_OCX;
    if FileExists(DllPath) then
      IsOK := True;
  end;
  if not IsOk then
  begin
    DllPath := String(SystemPath) + '\Macromed\Flash\' + FLASH9E_OCX;
    if FileExists(DllPath) then
      IsOK := True;
  end;
  if not IsOk then
  begin
    DllPath := String(SystemPath) + '\Macromed\Flash\' + FLASH9D_OCX;
    if FileExists(DllPath) then
      IsOK := True;
  end;
  if not IsOk then
  begin
    DllPath := String(SystemPath) + '\Macromed\Flash\' + FLASH9C_OCX;
    if FileExists(DllPath) then
      IsOK := True;
  end;
  if not IsOk then
  begin
    DllPath := String(SystemPath) + '\Macromed\Flash\' + FLASH9B_OCX;
    if FileExists(DllPath) then
      IsOK := True;
  end;
  if not IsOk then
  begin
    DllPath := String(SystemPath) + '\Macromed\Flash\' + FLASH9_OCX;
    if FileExists(DllPath) then
      IsOK := True;
  end; 
  if not IsOk then
  begin
    DllPath := String(SystemPath) + '\Macromed\Flash\' + FLASH8_OCX;
    if FileExists(DllPath) then
      IsOK := True;
  end;
  if not IsOk then
  begin
    DllPath := String(SystemPath) + '\Macromed\Flash\' + FLASH_OCX;
    if FileExists(DllPath) then
      IsOK := True;
  end;
  if not IsOK then
    exit;

  MainWnd.FileVerInfo.FileName := DllPath;
  if MainWnd.FileVerInfo.HasVerInfo then
    Result := MainWnd.FileVerInfo.FileVersion;
end;

function GetOption: string;
begin
end;

procedure TBugReport.FormCreate(Sender: TObject);
begin
  Label1.Caption := LABEL_CAPTION;
  Label2.Caption := LABEL2_CAPTION;
  Memo.Lines.Add('�yTubePlayer�̃o�[�W�����z '+ Main.APPLICATION_NAME + ' Version ' + Main.VERSION + ' (' + GetExeVersion + ')');
  Memo.Lines.Add('�y Windows�̃o�[�W�����@ �z ' + GetOSName);
  Memo.Lines.Add('�y �@�@IE�̃o�[�W�����@�@�@�z ' + GetIEVersion);
  Memo.Lines.Add('�y�@�@FLASH�̃o�[�W���� �z ' + GetFlashVersion);
  Memo.Lines.Add('�y �@�@WSH�̃o�[�W�����@ �z ' + GetWSHVersion);
  Memo.Lines.Add('�y �@�@CPU�Ɠ��ڃ������@�@�z CPU:' + GetCPUClock + ' ������:' + GetAvailableMemory);
  //Memo.Lines.Add('�y �@�@�@�I�v�V�����@�@�@�@�z ' + GetOption);
  Memo.Lines.Add('�y �@�@�@�o�O�̊T�v�@�@�@�@�z ');
  Memo.Lines.Add('�y�o�O�̏ڂ����Č��菇 �z');
end;

procedure TBugReport.ButtonCopyClick(Sender: TObject);
begin
  Clipboard.AsText := Memo.Text;
  ModalResult := mrOK;
end;

procedure TBugReport.LabelURIClick(Sender: TObject);
begin
  Clipboard.AsText := Memo.Text;
  MainWnd.OpenByBrowser(Main.SOFTWARE_BBS_URI);
  ModalResult := mrOK;
end;

end.
