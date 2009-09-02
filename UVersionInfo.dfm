object VersionInfo: TVersionInfo
  Left = 462
  Top = 296
  BorderStyle = bsDialog
  Caption = #12496#12540#12472#12519#12531#24773#22577
  ClientHeight = 139
  ClientWidth = 252
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 12
  object LabelCopyright2: TLabel
    Left = 16
    Top = 56
    Width = 202
    Height = 12
    Caption = 'Copyright (C) 2007-2009 '#9670'Style/kK.s. '
  end
  object LabelVersion: TSpTBXLabel
    Left = 16
    Top = 16
    Width = 124
    Height = 12
    Caption = 'TubePlayer Version 2.xx'
    LinkFont.Charset = SHIFTJIS_CHARSET
    LinkFont.Color = clBlue
    LinkFont.Height = -12
    LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
    LinkFont.Style = [fsUnderline]
  end
  object LabelCopyright: TSpTBXLabel
    Left = 16
    Top = 40
    Width = 149
    Height = 12
    Caption = 'Copyright (C) 2009 Jane, Inc.'
    LinkFont.Charset = SHIFTJIS_CHARSET
    LinkFont.Color = clBlue
    LinkFont.Height = -12
    LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
    LinkFont.Style = [fsUnderline]
  end
  object LabelURI: TSpTBXLabel
    Left = 16
    Top = 80
    Width = 127
    Height = 12
    Cursor = crHandPoint
    Caption = 'http://janesoft.net/tube/'
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
    Font.Style = [fsUnderline]
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    OnClick = LabelURIClick
    LinkFont.Charset = SHIFTJIS_CHARSET
    LinkFont.Color = clBlue
    LinkFont.Height = -12
    LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
    LinkFont.Style = [fsUnderline]
  end
  object ButtonOK: TSpTBXButton
    Left = 92
    Top = 104
    Width = 76
    Height = 25
    Caption = 'OK'
    TabOrder = 0
    OnClick = ButtonOKClick
    LinkFont.Charset = SHIFTJIS_CHARSET
    LinkFont.Color = clBlue
    LinkFont.Height = -12
    LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
    LinkFont.Style = [fsUnderline]
  end
end
