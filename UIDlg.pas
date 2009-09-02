unit UIDlg;
(* インプットダイアログ *)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  TBXDkPanels, SpTBXControls;

type
  (*-------------------------------------------------------*)
  TInputDlg = class(TForm)
    Button: TSpTBXButton;
    InputPanel: TSpTBXPanel;
    Edit: TComboBox;
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private 宣言 }
  public
    { Public 宣言 }
  end;

var
  InputDlg: TInputDlg;

implementation

{$R *.dfm}

uses
  Main;

procedure TInputDlg.FormShow(Sender: TObject);
begin
  if length(Edit.Text) > 256 then
     Edit.Text := Copy(Edit.Text, 1, 256);  Edit.SelectAll;
  Edit.SetFocus;
  ImeMode := ImeMode;
  SetImeMode(Handle,userImeMode);
end;

procedure TInputDlg.EditKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    #$1B: ModalResult := -1;
    #$D:  ModalResult := 3;
  end;
end;

procedure TInputDlg.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: ModalResult := -1;
  end;
end;

procedure TInputDlg.FormCreate(Sender: TObject);
begin
  Top := MainWnd.Top;
  Left := MainWnd.Left;
  Edit.AutoComplete := false;
end;

procedure TInputDlg.ButtonClick(Sender: TObject);
begin
  ModalResult := 3;
end;

procedure TInputDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //▼ダイアログを閉じる際にIME状態を保存
  SaveImeMode(handle);
end;

end.
