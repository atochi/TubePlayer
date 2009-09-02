unit UUpdateDlg;
(* �A�b�v�f�[�g�_�C�A���O *)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,
  TBXDkPanels, SpTBXControls;

type
  TUpdateDlg = class(TForm)
    Label1: TSpTBXLabel;
    VersionLabel: TSpTBXLabel;
    InfoImage: TImage;
    Label3: TSpTBXLabel;
    OKButton: TSpTBXButton;
    CancelButton: TSpTBXButton;
    CheckBoxOptUpdateCheck: TSpTBXCheckBox;
    //procedure HelpButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure CheckBoxOptUpdateCheckClick(Sender: TObject);
  private
    { Private �錾 }
  public
    { Public �錾 }
  end;

var
  UpdateDlg: TUpdateDlg;

implementation

uses Main;

{$R *.dfm}

{
procedure TUpdateDlg.HelpButtonClick(Sender: TObject);
begin
  MainWnd.OpenHtmlHelp('first/download.html');
end;
}

procedure TUpdateDlg.OKButtonClick(Sender: TObject);
begin
  MainWnd.OpenByBrowser(Main.DISTRIBUTORS_SITE);
  ModalResult := mrOK;
end;

procedure TUpdateDlg.CancelButtonClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TUpdateDlg.CheckBoxOptUpdateCheckClick(Sender: TObject);
begin
  Config.optUpdateCheck := not CheckBoxOptUpdateCheck.Checked;
  Config.Modified := true;
end;

end.
