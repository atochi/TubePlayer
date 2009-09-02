object InputDlg: TInputDlg
  Left = 211
  Top = 140
  BorderStyle = bsToolWindow
  Caption = #26908#32034
  ClientHeight = 36
  ClientWidth = 537
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object InputPanel: TSpTBXPanel
    Left = 0
    Top = 0
    Width = 537
    Height = 36
    Align = alTop
    TabOrder = 0
    object Button: TSpTBXButton
      Left = 504
      Top = 8
      Width = 25
      Height = 17
      Caption = 'OK'
      TabOrder = 0
      OnClick = ButtonClick
      LinkFont.Charset = SHIFTJIS_CHARSET
      LinkFont.Color = clBlue
      LinkFont.Height = -12
      LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
      LinkFont.Style = [fsUnderline]
    end
    object Edit: TComboBox
      Left = 8
      Top = 8
      Width = 489
      Height = 20
      Style = csSimple
      ItemHeight = 12
      TabOrder = 1
      OnKeyDown = EditKeyDown
      OnKeyPress = EditKeyPress
    end
  end
end
