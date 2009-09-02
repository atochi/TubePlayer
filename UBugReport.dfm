object BugReport: TBugReport
  Left = 329
  Top = 221
  BorderStyle = bsDialog
  Caption = #12496#12464#12524#12509#12540#12488
  ClientHeight = 345
  ClientWidth = 526
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TSpTBXLabel
    Left = 16
    Top = 16
    Width = 497
    Height = 12
    Caption = 'Label1'
    Wrapping = twWrap
    LinkFont.Charset = SHIFTJIS_CHARSET
    LinkFont.Color = clBlue
    LinkFont.Height = -12
    LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
    LinkFont.Style = [fsUnderline]
  end
  object Label2: TSpTBXLabel
    Left = 16
    Top = 280
    Width = 489
    Height = 12
    Caption = 'Label2'
    Wrapping = twWrap
    LinkFont.Charset = SHIFTJIS_CHARSET
    LinkFont.Color = clBlue
    LinkFont.Height = -12
    LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
    LinkFont.Style = [fsUnderline]
  end
  object LabelURI: TSpTBXLabel
    Left = 376
    Top = 40
    Width = 128
    Height = 12
    Cursor = crHandPoint
    Hint = #20869#23481#12434#12463#12522#12483#12503#12508#12540#12489#12395#12467#12500#12540#12375#12390#12477#12501#12488#12454#12455#12450#26495#12395#31227#21205#12375#12414#12377
    Caption = #12477#12501#12488#12454#12455#12450#26495#12395#31227#21205#12377#12427
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
    Font.Style = [fsUnderline]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = LabelURIClick
    LinkFont.Charset = SHIFTJIS_CHARSET
    LinkFont.Color = clBlue
    LinkFont.Height = -12
    LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
    LinkFont.Style = [fsUnderline]
  end
  object Memo: TTntMemo
    Left = 16
    Top = 64
    Width = 497
    Height = 209
    Lines.Strings = (
      #12304#19981#20855#21512#12305)
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object ButtonCopy: TSpTBXButton
    Left = 432
    Top = 304
    Width = 83
    Height = 25
    Caption = #20869#23481#12434#12467#12500#12540
    TabOrder = 1
    OnClick = ButtonCopyClick
    LinkFont.Charset = SHIFTJIS_CHARSET
    LinkFont.Color = clBlue
    LinkFont.Height = -12
    LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
    LinkFont.Style = [fsUnderline]
  end
end
