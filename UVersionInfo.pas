unit UVersionInfo;
(* �o�[�W������� *)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  TBXDkPanels, SpTBXControls, StdCtrls;

function GetExeVersion: String;

type
  TVersionInfo = class(TForm)
    LabelVersion: TSpTBXLabel;
    LabelCopyright: TSpTBXLabel;
    ButtonOK: TSpTBXButton;
    LabelURI: TSpTBXLabel;
    LabelCopyright2: TLabel;
    procedure ButtonOKClick(Sender: TObject);
    procedure LabelURIClick(Sender: TObject);
  private
    { Private �錾 }
  public
    { Public �錾 }
  end;

var
  VersionInfo: TVersionInfo;

implementation

uses Main;

{$R *.dfm}

function GetExeVersion: String;
begin
  Result := '�s��';
  MainWnd.FileVerInfo.FileName := ParamStr(0);
  if MainWnd.FileVerInfo.HasVerInfo then
    Result := MainWnd.FileVerInfo.FileVersion;
end;

procedure TVersionInfo.ButtonOKClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TVersionInfo.LabelURIClick(Sender: TObject);
begin
  MainWnd.OpenByBrowser(LabelURI.Caption);
  ModalResult := mrOK;
end;

end.
