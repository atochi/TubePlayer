object UIConfig: TUIConfig
  Left = 339
  Top = 147
  BorderStyle = bsDialog
  Caption = #35373#23450
  ClientHeight = 445
  ClientWidth = 546
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object ButtonCancel: TSpTBXButton
    Left = 448
    Top = 408
    Width = 75
    Height = 25
    Caption = #12461#12515#12531#12475#12523
    TabOrder = 1
    OnClick = ButtonCancelClick
    LinkFont.Charset = SHIFTJIS_CHARSET
    LinkFont.Color = clBlue
    LinkFont.Height = -12
    LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
    LinkFont.Style = [fsUnderline]
  end
  object ButtonOK: TSpTBXButton
    Left = 360
    Top = 408
    Width = 75
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
  object TreeView: TTreeView
    Left = 8
    Top = 8
    Width = 121
    Height = 401
    Indent = 19
    ReadOnly = True
    TabOrder = 2
    OnChange = TreeViewChange
    Items.Data = {
      010000001D0000000000000000000000FFFFFFFFFFFFFFFF0000000000000000
      0490DD92E8}
  end
  object PageControl: TPageControl
    Left = 130
    Top = 8
    Width = 409
    Height = 401
    ActivePage = TabSheetYouTube
    MultiLine = True
    Style = tsFlatButtons
    TabOrder = 3
    OnChange = PageControlChange
    object TabSheetNet: TTabSheet
      Caption = #36890#20449
      TabVisible = False
      object Label1: TSpTBXLabel
        Left = 8
        Top = 16
        Width = 54
        Height = 12
        Caption = 'UserAgent'
        LinkFont.Charset = SHIFTJIS_CHARSET
        LinkFont.Color = clBlue
        LinkFont.Height = -12
        LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
        LinkFont.Style = [fsUnderline]
      end
      object Label5: TSpTBXLabel
        Left = 8
        Top = 48
        Width = 122
        Height = 12
        Caption = #21463#20449#12479#12452#12512#12450#12454#12488'('#12511#12522#31186')'
        LinkFont.Charset = SHIFTJIS_CHARSET
        LinkFont.Color = clBlue
        LinkFont.Height = -12
        LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
        LinkFont.Style = [fsUnderline]
      end
      object EditnetUserAgent: TSpTBXEdit
        Left = 72
        Top = 12
        Width = 281
        Height = 20
        TabOrder = 0
      end
      object EditnetReadTimeout: TSpTBXEdit
        Left = 136
        Top = 44
        Width = 73
        Height = 20
        TabOrder = 1
      end
      object GroupBox2: TSpTBXGroupBox
        Left = 8
        Top = 104
        Width = 305
        Height = 129
        Caption = 'Proxy'#35373#23450
        TabOrder = 3
        object Label2: TSpTBXLabel
          Left = 16
          Top = 77
          Width = 40
          Height = 12
          Caption = #12450#12489#12524#12473
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
        object Label3: TSpTBXLabel
          Left = 202
          Top = 77
          Width = 31
          Height = 12
          Caption = #12509#12540#12488
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
        object Label4: TSpTBXLabel
          Left = 192
          Top = 97
          Width = 2
          Height = 12
          Caption = ':'
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
        object CheckBoxnetUseProxy: TSpTBXCheckBox
          Left = 16
          Top = 24
          Width = 103
          Height = 15
          Caption = 'Proxy'#12434#20351#29992#12377#12427
          TabOrder = 0
        end
        object CheckBoxnetNoCache: TSpTBXCheckBox
          Left = 16
          Top = 48
          Width = 202
          Height = 15
          Caption = 'Proxy'#20351#29992#26178#12395#12461#12515#12483#12471#12517#12434#21033#29992#12377#12427
          TabOrder = 1
        end
        object EditnetProxyServer: TSpTBXEdit
          Left = 16
          Top = 93
          Width = 169
          Height = 20
          TabOrder = 2
        end
        object EditnetProxyPort: TSpTBXEdit
          Left = 200
          Top = 93
          Width = 57
          Height = 20
          TabOrder = 3
        end
      end
      object SpTBXLabel17: TSpTBXLabel
        Left = 8
        Top = 76
        Width = 122
        Height = 12
        Caption = #25509#32154#12479#12452#12512#12450#12454#12488'('#12511#12522#31186')'
        LinkFont.Charset = SHIFTJIS_CHARSET
        LinkFont.Color = clBlue
        LinkFont.Height = -12
        LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
        LinkFont.Style = [fsUnderline]
      end
      object EditnetConnectTimeout: TSpTBXEdit
        Left = 136
        Top = 72
        Width = 73
        Height = 20
        TabOrder = 2
      end
    end
    object TabSheetTools: TTabSheet
      Caption = #12484#12540#12523#36899#21205
      ImageIndex = 1
      TabVisible = False
      object Label7: TSpTBXLabel
        Left = 16
        Top = 40
        Width = 79
        Height = 12
        Caption = #12502#12521#12454#12470#12398#12497#12473
        LinkFont.Charset = SHIFTJIS_CHARSET
        LinkFont.Color = clBlue
        LinkFont.Height = -12
        LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
        LinkFont.Style = [fsUnderline]
      end
      object CheckBoxoptBrowserSpecified: TSpTBXCheckBox
        Left = 16
        Top = 16
        Width = 118
        Height = 15
        Caption = #12502#12521#12454#12470#12434#25351#23450#12377#12427
        TabOrder = 0
      end
      object EditoptBrowserPath: TSpTBXEdit
        Left = 16
        Top = 56
        Width = 289
        Height = 20
        TabOrder = 1
      end
      object ButtonSelBrowser: TSpTBXButton
        Left = 312
        Top = 54
        Width = 25
        Height = 25
        Caption = '...'
        TabOrder = 2
        OnClick = ButtonSelBrowserClick
        LinkFont.Charset = SHIFTJIS_CHARSET
        LinkFont.Color = clBlue
        LinkFont.Height = -12
        LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
        LinkFont.Style = [fsUnderline]
      end
      object GroupBox1: TSpTBXGroupBox
        Left = 16
        Top = 120
        Width = 329
        Height = 217
        Caption = #12499#12487#12458#12398#12480#12454#12531#12525#12540#12489#26041#27861
        TabOrder = 4
        object Label8: TSpTBXLabel
          Left = 32
          Top = 100
          Width = 69
          Height = 12
          Caption = #12484#12540#12523#12398#12497#12473
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
        object Label9: TSpTBXLabel
          Left = 72
          Top = 124
          Width = 24
          Height = 12
          Caption = #24341#25968
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
        object Label10: TSpTBXLabel
          Left = 104
          Top = 144
          Width = 209
          Height = 12
          Caption = #26377#21177#12394#22793#25968#12288'$URL'#12288#12288':'#12480#12454#12531#12525#12540#12489#20808'URL'
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
        object Label11: TSpTBXLabel
          Left = 171
          Top = 176
          Width = 97
          Height = 12
          Caption = '$TITLE  :'#12479#12452#12488#12523#21517
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
        object RadioButtonDownloadOption0: TSpTBXRadioButton
          Left = 16
          Top = 24
          Width = 251
          Height = 15
          Caption = #12487#12501#12457#12523#12488'/'#25351#23450#12398#12502#12521#12454#12470#12391#12480#12454#12531#12525#12540#12489#12377#12427
          TabOrder = 0
        end
        object RadioButtonDownloadOption1: TSpTBXRadioButton
          Left = 16
          Top = 48
          Width = 202
          Height = 15
          Caption = #20869#34101#12480#12454#12531#12525#12540#12480#12391#12480#12454#12531#12525#12540#12489#12377#12427
          Enabled = False
          TabOrder = 1
        end
        object RadioButtonDownloadOption2: TSpTBXRadioButton
          Left = 16
          Top = 72
          Width = 209
          Height = 15
          Caption = #12480#12454#12531#12525#12540#12489#12484#12540#12523#12391#12480#12454#12531#12525#12540#12489#12377#12427
          TabOrder = 2
        end
        object EditoptDownloaderPath: TSpTBXEdit
          Left = 104
          Top = 96
          Width = 169
          Height = 20
          TabOrder = 3
        end
        object ButtonSelDownloader: TSpTBXButton
          Left = 280
          Top = 94
          Width = 25
          Height = 25
          Caption = '...'
          TabOrder = 4
          OnClick = ButtonSelDownloaderClick
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
        object EditoptDownloaderOption: TSpTBXEdit
          Left = 104
          Top = 120
          Width = 169
          Height = 20
          TabOrder = 5
        end
        object RadioButtonDownloadOption3: TSpTBXRadioButton
          Left = 16
          Top = 192
          Width = 271
          Height = 15
          Caption = #12463#12522#12483#12503#12508#12540#12489#12395#12499#12487#12458#12501#12449#12452#12523#12398'URL'#12434#12467#12500#12540#12377#12427
          TabOrder = 6
        end
        object SpTBXLabel18: TSpTBXLabel
          Left = 171
          Top = 160
          Width = 82
          Height = 12
          Caption = '$URL2'#12288' :'#20803'URL'
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
      end
      object CheckBoxoptUseShellExecute: TSpTBXCheckBox
        Left = 16
        Top = 88
        Width = 195
        Height = 15
        Caption = 'ShellExecute'#12391#12502#12521#12454#12470#12434#36215#21205#12377#12427
        TabOrder = 3
      end
    end
    object TabSheetYouTube: TTabSheet
      Caption = 'YouTube'
      ImageIndex = 2
      TabVisible = False
      object CheckBoxoptUsePlayer2: TSpTBXCheckBox
        Left = 16
        Top = 16
        Width = 172
        Height = 15
        Caption = #12469#12452#12488#20869#12503#12524#12452#12516#12540#12391#20877#29983#12377#12427
        TabOrder = 0
      end
      object CheckBoxoptAutoPlay: TSpTBXCheckBox
        Left = 16
        Top = 40
        Width = 156
        Height = 15
        Caption = #35501#12415#36796#12415#12392#21516#26178#12395#20877#29983#12377#12427
        TabOrder = 1
      end
      object SpTBXLabel1: TSpTBXLabel
        Left = 16
        Top = 88
        Width = 206
        Height = 12
        Caption = #12473#12461#12531#12398#12501#12457#12523#12480' ('#27425#22238#36215#21205#26178#12363#12425#26377#21177')'
        LinkFont.Charset = SHIFTJIS_CHARSET
        LinkFont.Color = clBlue
        LinkFont.Height = -12
        LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
        LinkFont.Style = [fsUnderline]
      end
      object ComboBoxSkinPath: TSpTBXComboBox
        Left = 16
        Top = 104
        Width = 297
        Height = 20
        ItemHeight = 12
        TabOrder = 3
      end
      object ButtonSelSkinFolder: TSpTBXButton
        Tag = 1
        Left = 320
        Top = 102
        Width = 25
        Height = 25
        Caption = '...'
        TabOrder = 4
        OnClick = ButtonSelSkinFolderClick
        LinkFont.Charset = SHIFTJIS_CHARSET
        LinkFont.Color = clBlue
        LinkFont.Height = -12
        LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
        LinkFont.Style = [fsUnderline]
      end
      object SpTBXGroupBox1: TSpTBXGroupBox
        Left = 16
        Top = 144
        Width = 273
        Height = 97
        Caption = #12499#12487#12458#12469#12452#12474
        TabOrder = 5
        object SpTBXLabel3: TSpTBXLabel
          Left = 16
          Top = 33
          Width = 64
          Height = 12
          Caption = #12487#12501#12457#12523#12488#20516
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
        object SpTBXLabel4: TSpTBXLabel
          Left = 16
          Top = 65
          Width = 84
          Height = 12
          Caption = #12518#12540#12470#12540#35215#23450#20516
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
        object SpTBXLabel5: TSpTBXLabel
          Left = 120
          Top = 13
          Width = 28
          Height = 12
          Caption = 'Width'
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
        object SpTBXLabel6: TSpTBXLabel
          Left = 192
          Top = 13
          Width = 33
          Height = 12
          Caption = 'Height'
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
        object SpinEditYouTubeWidth: TSpTBXSpinEdit
          Left = 112
          Top = 61
          Width = 65
          Height = 20
          TabOrder = 2
          SpinButton.Left = 46
          SpinButton.Top = 0
          SpinButton.Width = 15
          SpinButton.Height = 16
          SpinButton.Align = alRight
          SpinButton.LinkFont.Charset = SHIFTJIS_CHARSET
          SpinButton.LinkFont.Color = clBlue
          SpinButton.LinkFont.Height = -12
          SpinButton.LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          SpinButton.LinkFont.Style = [fsUnderline]
          SpinOptions.MaxValue = 9999.000000000000000000
        end
        object SpinEditYouTubeHeight: TSpTBXSpinEdit
          Left = 184
          Top = 61
          Width = 65
          Height = 20
          TabOrder = 3
          SpinButton.Left = 46
          SpinButton.Top = 0
          SpinButton.Width = 15
          SpinButton.Height = 16
          SpinButton.Align = alRight
          SpinButton.LinkFont.Charset = SHIFTJIS_CHARSET
          SpinButton.LinkFont.Color = clBlue
          SpinButton.LinkFont.Height = -12
          SpinButton.LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          SpinButton.LinkFont.Style = [fsUnderline]
          SpinOptions.MaxValue = 9999.000000000000000000
        end
        object SpinEditYouTubeWidthDef: TSpTBXSpinEdit
          Left = 112
          Top = 32
          Width = 65
          Height = 20
          TabOrder = 0
          SpinButton.Left = 46
          SpinButton.Top = 0
          SpinButton.Width = 15
          SpinButton.Height = 16
          SpinButton.Align = alRight
          SpinButton.LinkFont.Charset = SHIFTJIS_CHARSET
          SpinButton.LinkFont.Color = clBlue
          SpinButton.LinkFont.Height = -12
          SpinButton.LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          SpinButton.LinkFont.Style = [fsUnderline]
          SpinOptions.MaxValue = 9999.000000000000000000
        end
        object SpinEditYouTubeHeightDef: TSpTBXSpinEdit
          Left = 184
          Top = 32
          Width = 65
          Height = 20
          TabOrder = 1
          SpinButton.Left = 46
          SpinButton.Top = 0
          SpinButton.Width = 15
          SpinButton.Height = 16
          SpinButton.Align = alRight
          SpinButton.LinkFont.Charset = SHIFTJIS_CHARSET
          SpinButton.LinkFont.Color = clBlue
          SpinButton.LinkFont.Height = -12
          SpinButton.LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          SpinButton.LinkFont.Style = [fsUnderline]
          SpinOptions.MaxValue = 9999.000000000000000000
        end
      end
      object SpTBXGroupBox4: TSpTBXGroupBox
        Left = 16
        Top = 280
        Width = 273
        Height = 81
        Caption = #12525#12464#12452#12531
        TabOrder = 7
        Visible = False
        object SpTBXLabel12: TSpTBXLabel
          Left = 16
          Top = 24
          Width = 57
          Height = 12
          Caption = 'User Name'
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
        object SpTBXLabel13: TSpTBXLabel
          Left = 16
          Top = 56
          Width = 54
          Height = 12
          Caption = #12497#12473#12527#12540#12489
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
        object EditoptYouTubeAccount: TSpTBXEdit
          Left = 96
          Top = 20
          Width = 153
          Height = 20
          TabOrder = 0
        end
        object EditoptYouTubePassword: TSpTBXEdit
          Left = 96
          Top = 52
          Width = 153
          Height = 20
          TabOrder = 1
          PasswordCharW = '*'
        end
      end
      object SpTBXLabel15: TSpTBXLabel
        Left = 16
        Top = 248
        Width = 358
        Height = 12
        Caption = #8251#12487#12501#12457#12523#12488#20516#12434'"0"'#12395#12377#12427#12392#12499#12487#12458#12434#38283#12367#12392#12365#12395#12469#12452#12474#12434#22793#26356#12375#12414#12379#12435#12290
        LinkFont.Charset = SHIFTJIS_CHARSET
        LinkFont.Color = clBlue
        LinkFont.Height = -12
        LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
        LinkFont.Style = [fsUnderline]
      end
      object ButtonYouTubeSize2Def: TSpTBXButton
        Left = 296
        Top = 216
        Width = 91
        Height = 25
        Caption = #35215#23450#20516#12395#25147#12377
        TabOrder = 6
        OnClick = ButtonYouTubeSize2DefClick
        LinkFont.Charset = SHIFTJIS_CHARSET
        LinkFont.Color = clBlue
        LinkFont.Height = -12
        LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
        LinkFont.Style = [fsUnderline]
      end
      object LabelSize: TSpTBXLabel
        Left = 296
        Top = 200
        Width = 94
        Height = 12
        Caption = #29694#22312#20516':(960'#215'540)'
        LinkFont.Charset = SHIFTJIS_CHARSET
        LinkFont.Color = clBlue
        LinkFont.Height = -12
        LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
        LinkFont.Style = [fsUnderline]
      end
      object CheckBoxoptUseMP4: TSpTBXCheckBox
        Left = 16
        Top = 64
        Width = 146
        Height = 15
        Caption = 'H.264(fmt=18)'#12391#20877#29983#12377#12427
        TabOrder = 2
      end
    end
    object TabSheetGeneral: TTabSheet
      Caption = #20840#33324
      ImageIndex = 3
      TabVisible = False
      object LabelListOdd: TLabel
        Left = 176
        Top = 160
        Width = 121
        Height = 17
        Alignment = taCenter
        AutoSize = False
        Caption = 'LabelListOdd'
        Color = clBtnFace
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object LabelListEven: TLabel
        Left = 176
        Top = 177
        Width = 121
        Height = 17
        Alignment = taCenter
        AutoSize = False
        Caption = 'LabelListEven'
        Color = clBtnFace
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label12: TLabel
        Left = 16
        Top = 208
        Width = 92
        Height = 12
        Caption = #26908#32034#23653#27508#25968'('#26368#22823')'
      end
      object Label13: TLabel
        Left = 16
        Top = 236
        Width = 160
        Height = 12
        Caption = #26368#36817#35222#32884#12375#12383#21205#30011#23653#27508#25968'('#26368#22823')'
      end
      object CheckBoxoptUpdateCheck: TSpTBXCheckBox
        Left = 16
        Top = 16
        Width = 219
        Height = 15
        Caption = #26368#26032#12496#12540#12472#12519#12531#12364#20844#38283#12373#12428#12383#12425#36890#30693#12377#12427
        TabOrder = 0
      end
      object RadioGroupoptFPQuality: TSpTBXRadioGroup
        Left = 16
        Top = 264
        Width = 321
        Height = 41
        Caption = 'FlashPlayer'#12398#20877#29983#21697#36074
        TabOrder = 11
        Columns = 5
        Items.Strings = (
          'low'
          'high'
          'autolow'
          'autohigh'
          'best')
      end
      object CheckBoxoptListViewUseExtraBackColor: TSpTBXCheckBox
        Left = 16
        Top = 160
        Width = 149
        Height = 15
        Caption = #12522#12473#12488#12398#32972#26223#12434#33394#20998#12369#12377#12427
        TabOrder = 6
      end
      object ButtonOdd: TSpTBXButton
        Tag = 1
        Left = 296
        Top = 160
        Width = 25
        Height = 17
        Caption = '...'
        TabOrder = 7
        OnClick = ButtonColorClick
        LinkFont.Charset = SHIFTJIS_CHARSET
        LinkFont.Color = clBlue
        LinkFont.Height = -12
        LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
        LinkFont.Style = [fsUnderline]
      end
      object ButtonEvwn: TSpTBXButton
        Tag = 2
        Left = 296
        Top = 177
        Width = 25
        Height = 17
        Caption = '...'
        TabOrder = 8
        OnClick = ButtonColorClick
        LinkFont.Charset = SHIFTJIS_CHARSET
        LinkFont.Color = clBlue
        LinkFont.Height = -12
        LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
        LinkFont.Style = [fsUnderline]
      end
      object CheckBoxoptWheelScrollUnderCursor: TSpTBXCheckBox
        Left = 16
        Top = 40
        Width = 259
        Height = 15
        Caption = #12459#12540#12477#12523#12398#19979#12395#12354#12427#12506#12452#12531#12434#12507#12452#12540#12523#12473#12463#12525#12540#12523
        TabOrder = 1
      end
      object SpinEditSearchHistoryCount: TSpTBXSpinEdit
        Left = 184
        Top = 204
        Width = 57
        Height = 20
        TabOrder = 9
        SpinButton.Left = 38
        SpinButton.Top = 0
        SpinButton.Width = 15
        SpinButton.Height = 16
        SpinButton.Align = alRight
        SpinButton.LinkFont.Charset = SHIFTJIS_CHARSET
        SpinButton.LinkFont.Color = clBlue
        SpinButton.LinkFont.Height = -12
        SpinButton.LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
        SpinButton.LinkFont.Style = [fsUnderline]
        SpinOptions.MaxValue = 9999.000000000000000000
      end
      object SpinEditRecentlyViewedCount: TSpTBXSpinEdit
        Left = 184
        Top = 232
        Width = 57
        Height = 20
        TabOrder = 10
        SpinButton.Left = 38
        SpinButton.Top = 0
        SpinButton.Width = 15
        SpinButton.Height = 16
        SpinButton.Align = alRight
        SpinButton.LinkFont.Charset = SHIFTJIS_CHARSET
        SpinButton.LinkFont.Color = clBlue
        SpinButton.LinkFont.Height = -12
        SpinButton.LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
        SpinButton.LinkFont.Style = [fsUnderline]
        SpinOptions.MaxValue = 9999.000000000000000000
      end
      object CheckBoxoptAllowFavoriteDuplicate: TSpTBXCheckBox
        Left = 16
        Top = 64
        Width = 165
        Height = 15
        Caption = #12362#27671#12395#20837#12426#12398#37325#35079#12434#35377#21487#12377#12427
        TabOrder = 2
      end
      object CheckBoxoptAddFavoriteAtBottom: TSpTBXCheckBox
        Left = 16
        Top = 88
        Width = 240
        Height = 15
        Caption = #12300#12362#27671#12395#20837#12426#12395#36861#21152#12301#12434#12501#12457#12523#12480#12398#26411#23614#12391#34892#12358
        TabOrder = 3
      end
      object CheckBoxoptFavoriteClickOption: TSpTBXCheckBox
        Left = 16
        Top = 112
        Width = 185
        Height = 15
        Caption = #12362#27671#12395#20837#12426#12434#12463#12522#12483#12463#12391#21205#30011#12434#38283#12367
        TabOrder = 4
      end
      object CheckBoxoptListClickOption: TSpTBXCheckBox
        Left = 16
        Top = 136
        Width = 158
        Height = 15
        Caption = #12522#12473#12488#12434#12463#12522#12483#12463#12391#21205#30011#12434#38283#12367
        TabOrder = 5
      end
    end
    object TabSheetWindow: TTabSheet
      Caption = #12454#12451#12531#12489#12454
      ImageIndex = 4
      TabVisible = False
      object RadioGroupoptDeactiveOption: TSpTBXRadioGroup
        Left = 16
        Top = 16
        Width = 185
        Height = 81
        Caption = #38750#12450#12463#12486#12451#12502#12395#12394#12387#12383#38555#12398#21205#20316
        TabOrder = 0
        OnClick = RadioGroupoptDeactiveOptionClick
        Items.Strings = (
          #20309#12418#12375#12394#12356
          #12454#12451#12531#12489#12454#12434#26368#23567#21270#12377#12427
          #12450#12503#12522#12465#12540#12471#12519#12531#12434#32066#20102#12377#12427)
      end
      object SpinEditAutoCloseTime: TSpTBXSpinEdit
        Left = 208
        Top = 70
        Width = 49
        Height = 20
        TabOrder = 1
        Visible = False
        SpinButton.Left = 30
        SpinButton.Top = 0
        SpinButton.Width = 15
        SpinButton.Height = 16
        SpinButton.Align = alRight
        SpinButton.LinkFont.Charset = SHIFTJIS_CHARSET
        SpinButton.LinkFont.Color = clBlue
        SpinButton.LinkFont.Height = -12
        SpinButton.LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
        SpinButton.LinkFont.Style = [fsUnderline]
        SpinOptions.MaxValue = 9999.000000000000000000
      end
      object LabelAutoCloseTime: TSpTBXLabel
        Left = 264
        Top = 74
        Width = 81
        Height = 12
        Caption = #31186#24460#12395#32066#20102#12377#12427
        Visible = False
        LinkFont.Charset = SHIFTJIS_CHARSET
        LinkFont.Color = clBlue
        LinkFont.Height = -12
        LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
        LinkFont.Style = [fsUnderline]
      end
      object CheckBoxoptUseDefaultTitleBar: TSpTBXCheckBox
        Left = 16
        Top = 104
        Width = 287
        Height = 15
        Caption = #27161#28310#12398#12479#12452#12488#12523#12496#12540#12434#20351#29992#12377#12427'('#27425#22238#36215#21205#26178#12363#12425#26377#21177')'
        TabOrder = 2
      end
      object CheckBoxoptCloseToTray: TSpTBXCheckBox
        Left = 16
        Top = 128
        Width = 193
        Height = 15
        Caption = #26368#23567#21270#26178#12399#12479#12473#12463#12488#12524#12452#12395#26684#32013#12377#12427
        TabOrder = 3
      end
      object CheckBoxoptClearVideo: TSpTBXCheckBox
        Left = 16
        Top = 152
        Width = 200
        Height = 15
        Caption = #26368#23567#21270#26178#12395#12499#12487#12458#12497#12493#12523#12434#31354#12395#12377#12427
        TabOrder = 4
      end
      object CheckBoxoptNewWindowAnytime: TSpTBXCheckBox
        Left = 16
        Top = 176
        Width = 194
        Height = 15
        Caption = #24120#12395#26032#12375#12356#12454#12451#12531#12489#12454#12391#12499#12487#12458#12434#38283#12367
        TabOrder = 5
      end
      object CheckBoxoptFormStayOnTopPlaying: TSpTBXCheckBox
        Left = 16
        Top = 200
        Width = 204
        Height = 15
        Caption = #12499#12487#12458#20877#29983#26178#12398#12415#26368#21069#38754#34920#31034#12395#12377#12427
        TabOrder = 7
      end
    end
    object TabSheetnicovideo: TTabSheet
      Caption = 'nicovideo'
      ImageIndex = 5
      TabVisible = False
      object SpTBXGroupBox2: TSpTBXGroupBox
        Left = 16
        Top = 88
        Width = 273
        Height = 121
        Caption = #12499#12487#12458#12469#12452#12474
        TabOrder = 3
        object SpinEditNicoVideoWidth: TSpTBXSpinEdit
          Left = 112
          Top = 61
          Width = 65
          Height = 20
          TabOrder = 2
          SpinButton.Left = 46
          SpinButton.Top = 0
          SpinButton.Width = 15
          SpinButton.Height = 16
          SpinButton.Align = alRight
          SpinButton.LinkFont.Charset = SHIFTJIS_CHARSET
          SpinButton.LinkFont.Color = clBlue
          SpinButton.LinkFont.Height = -12
          SpinButton.LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          SpinButton.LinkFont.Style = [fsUnderline]
          SpinOptions.MaxValue = 9999.000000000000000000
        end
        object SpinEditNicoVideoHeight: TSpTBXSpinEdit
          Left = 184
          Top = 61
          Width = 65
          Height = 20
          TabOrder = 3
          SpinButton.Left = 46
          SpinButton.Top = 0
          SpinButton.Width = 15
          SpinButton.Height = 16
          SpinButton.Align = alRight
          SpinButton.LinkFont.Charset = SHIFTJIS_CHARSET
          SpinButton.LinkFont.Color = clBlue
          SpinButton.LinkFont.Height = -12
          SpinButton.LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          SpinButton.LinkFont.Style = [fsUnderline]
          SpinOptions.MaxValue = 9999.000000000000000000
        end
        object SpTBXLabel2: TSpTBXLabel
          Left = 16
          Top = 36
          Width = 64
          Height = 12
          Caption = #12487#12501#12457#12523#12488#20516
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
        object SpTBXLabel7: TSpTBXLabel
          Left = 16
          Top = 65
          Width = 84
          Height = 12
          Caption = #12518#12540#12470#12540#35215#23450#20516
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
        object SpTBXLabel8: TSpTBXLabel
          Left = 120
          Top = 13
          Width = 28
          Height = 12
          Caption = 'Width'
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
        object SpTBXLabel9: TSpTBXLabel
          Left = 192
          Top = 13
          Width = 33
          Height = 12
          Caption = 'Height'
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
        object SpinEditNicoVideoWidthDef: TSpTBXSpinEdit
          Left = 112
          Top = 32
          Width = 65
          Height = 20
          TabOrder = 0
          SpinButton.Left = 46
          SpinButton.Top = 0
          SpinButton.Width = 15
          SpinButton.Height = 16
          SpinButton.Align = alRight
          SpinButton.LinkFont.Charset = SHIFTJIS_CHARSET
          SpinButton.LinkFont.Color = clBlue
          SpinButton.LinkFont.Height = -12
          SpinButton.LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          SpinButton.LinkFont.Style = [fsUnderline]
          SpinOptions.MaxValue = 9999.000000000000000000
        end
        object SpinEditNicoVideoHeightDef: TSpTBXSpinEdit
          Left = 184
          Top = 32
          Width = 65
          Height = 20
          TabOrder = 1
          SpinButton.Left = 46
          SpinButton.Top = 0
          SpinButton.Width = 15
          SpinButton.Height = 16
          SpinButton.Align = alRight
          SpinButton.LinkFont.Charset = SHIFTJIS_CHARSET
          SpinButton.LinkFont.Color = clBlue
          SpinButton.LinkFont.Height = -12
          SpinButton.LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          SpinButton.LinkFont.Style = [fsUnderline]
          SpinOptions.MaxValue = 9999.000000000000000000
        end
        object SpTBXLabel14: TSpTBXLabel
          Left = 16
          Top = 94
          Width = 70
          Height = 12
          Caption = #12469#12452#12474#22522#28310#20516
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
        object SpinEditNicoVideoWidthVideo: TSpTBXSpinEdit
          Left = 112
          Top = 90
          Width = 65
          Height = 20
          TabOrder = 4
          SpinButton.Left = 46
          SpinButton.Top = 0
          SpinButton.Width = 15
          SpinButton.Height = 16
          SpinButton.Align = alRight
          SpinButton.LinkFont.Charset = SHIFTJIS_CHARSET
          SpinButton.LinkFont.Color = clBlue
          SpinButton.LinkFont.Height = -12
          SpinButton.LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          SpinButton.LinkFont.Style = [fsUnderline]
          SpinOptions.MaxValue = 9999.000000000000000000
          SpinOptions.MinValue = 1.000000000000000000
          SpinOptions.Value = 1.000000000000000000
        end
        object SpinEditNicoVideoHeightVideo: TSpTBXSpinEdit
          Left = 184
          Top = 90
          Width = 65
          Height = 20
          TabOrder = 5
          SpinButton.Left = 46
          SpinButton.Top = 0
          SpinButton.Width = 15
          SpinButton.Height = 16
          SpinButton.Align = alRight
          SpinButton.LinkFont.Charset = SHIFTJIS_CHARSET
          SpinButton.LinkFont.Color = clBlue
          SpinButton.LinkFont.Height = -12
          SpinButton.LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          SpinButton.LinkFont.Style = [fsUnderline]
          SpinOptions.MaxValue = 9999.000000000000000000
          SpinOptions.MinValue = 1.000000000000000000
          SpinOptions.Value = 1.000000000000000000
        end
      end
      object SpTBXGroupBox3: TSpTBXGroupBox
        Left = 16
        Top = 296
        Width = 273
        Height = 81
        Caption = #12525#12464#12452#12531
        TabOrder = 6
        object SpTBXLabel10: TSpTBXLabel
          Left = 16
          Top = 24
          Width = 73
          Height = 12
          Caption = #12513#12540#12523#12450#12489#12524#12473
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
        object SpTBXLabel11: TSpTBXLabel
          Left = 16
          Top = 56
          Width = 54
          Height = 12
          Caption = #12497#12473#12527#12540#12489
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
        object EditoptNicoVideoAccount: TSpTBXEdit
          Left = 96
          Top = 20
          Width = 153
          Height = 20
          TabOrder = 2
        end
        object EditoptNicoVideoPassword: TSpTBXEdit
          Left = 96
          Top = 52
          Width = 153
          Height = 20
          TabOrder = 3
          PasswordCharW = '*'
        end
      end
      object SpTBXLabel16: TSpTBXLabel
        Left = 16
        Top = 216
        Width = 358
        Height = 12
        Caption = #8251#12487#12501#12457#12523#12488#20516#12434'"0"'#12395#12377#12427#12392#12499#12487#12458#12434#38283#12367#12392#12365#12395#12469#12452#12474#12434#22793#26356#12375#12414#12379#12435#12290
        LinkFont.Charset = SHIFTJIS_CHARSET
        LinkFont.Color = clBlue
        LinkFont.Height = -12
        LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
        LinkFont.Style = [fsUnderline]
      end
      object SpTBXGroupBox5: TSpTBXGroupBox
        Left = 16
        Top = 240
        Width = 273
        Height = 49
        Caption = #12499#12487#12458#20301#32622#35036#27491
        TabOrder = 4
        object SpinEditNicoVideoModTop: TSpTBXSpinEdit
          Left = 48
          Top = 20
          Width = 65
          Height = 20
          TabOrder = 0
          SpinButton.Left = 46
          SpinButton.Top = 0
          SpinButton.Width = 15
          SpinButton.Height = 16
          SpinButton.Align = alRight
          SpinButton.LinkFont.Charset = SHIFTJIS_CHARSET
          SpinButton.LinkFont.Color = clBlue
          SpinButton.LinkFont.Height = -12
          SpinButton.LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          SpinButton.LinkFont.Style = [fsUnderline]
          SpinOptions.MaxValue = 9999.000000000000000000
        end
        object SpinEditNicoVideoModLeft: TSpTBXSpinEdit
          Left = 160
          Top = 20
          Width = 65
          Height = 20
          TabOrder = 1
          SpinButton.Left = 46
          SpinButton.Top = 0
          SpinButton.Width = 15
          SpinButton.Height = 16
          SpinButton.Align = alRight
          SpinButton.LinkFont.Charset = SHIFTJIS_CHARSET
          SpinButton.LinkFont.Color = clBlue
          SpinButton.LinkFont.Height = -12
          SpinButton.LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          SpinButton.LinkFont.Style = [fsUnderline]
          SpinOptions.MaxValue = 9999.000000000000000000
        end
        object SpTBXLabel19: TSpTBXLabel
          Left = 16
          Top = 24
          Width = 21
          Height = 12
          Caption = 'Top:'
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
        object SpTBXLabel20: TSpTBXLabel
          Left = 128
          Top = 24
          Width = 22
          Height = 12
          Caption = 'Left:'
          LinkFont.Charset = SHIFTJIS_CHARSET
          LinkFont.Color = clBlue
          LinkFont.Height = -12
          LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
          LinkFont.Style = [fsUnderline]
        end
      end
      object ButtonNicoVideoSize2Def: TSpTBXButton
        Left = 296
        Top = 264
        Width = 91
        Height = 25
        Caption = #35215#23450#20516#12395#25147#12377
        TabOrder = 5
        OnClick = ButtonNicoVideoSize2DefClick
        LinkFont.Charset = SHIFTJIS_CHARSET
        LinkFont.Color = clBlue
        LinkFont.Height = -12
        LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
        LinkFont.Style = [fsUnderline]
      end
      object CheckBoxoptUseLocalPlayer: TSpTBXCheckBox
        Left = 16
        Top = 16
        Width = 242
        Height = 15
        Caption = #12525#12540#12459#12523#12398'player(nicoplayer.swf)'#12391#20877#29983#12377#12427
        TabOrder = 0
      end
      object LabelSize2: TSpTBXLabel
        Left = 296
        Top = 192
        Width = 94
        Height = 12
        Caption = #29694#22312#20516':(960'#215'540)'
        LinkFont.Charset = SHIFTJIS_CHARSET
        LinkFont.Color = clBlue
        LinkFont.Height = -12
        LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
        LinkFont.Style = [fsUnderline]
      end
      object CheckBoxoptAutoOverlayCheckOn: TSpTBXCheckBox
        Left = 16
        Top = 64
        Width = 222
        Height = 15
        Caption = #12300#12467#12513#12531#12488#38750#34920#31034#12301#12395#33258#21205#30340#12395#12481#12455#12483#12463#12377#12427
        TabOrder = 2
      end
      object CheckBoxoptNicoVideoAutoPlay: TSpTBXCheckBox
        Left = 16
        Top = 40
        Width = 156
        Height = 15
        Caption = #35501#12415#36796#12415#12392#21516#26178#12395#20877#29983#12377#12427
        TabOrder = 1
      end
    end
  end
  object OpenDialog: TOpenDialog
    Filter = #12502#12521#12454#12470'(*.exe)|*.exe|'#12377#12409#12390'(*.*)|*.*'
    Left = 8
    Top = 392
  end
  object OpenDialog1: TOpenDialog
    Filter = #12484#12540#12523'(*.exe;*.js;*.vbs)|*.exe;*.js;*.vbs|'#12377#12409#12390'(*.*)|*.*'
    Left = 40
    Top = 392
  end
  object ColorDialog: TColorDialog
    Left = 72
    Top = 392
  end
end
