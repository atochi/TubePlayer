object MainWnd: TMainWnd
  Left = 192
  Top = 108
  Width = 759
  Height = 585
  Caption = 'TubePlayer'
  Color = clBtnFace
  Constraints.MaxHeight = 770
  Constraints.MaxWidth = 1280
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object SpTBXTitleBar: TSpTBXTitleBar
    Left = 0
    Top = 0
    Width = 751
    Height = 551
  end
  object PanelMain: TPanel
    Left = 0
    Top = 0
    Width = 751
    Height = 551
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object SpTBXSplitterLeft: TSpTBXSplitter
      Left = 132
      Top = 157
      Height = 372
      Cursor = crSizeWE
    end
    object SpTBXSplitterRight: TSpTBXSplitter
      Left = 482
      Top = 157
      Height = 372
      Cursor = crSizeWE
      Align = alRight
    end
    object DockBottom: TSpTBXDock
      Left = 0
      Top = 529
      Width = 751
      Height = 22
      FixAlign = True
      Position = dpBottom
      object ToolbarTitleBar: TSpTBXToolbar
        Left = 0
        Top = 0
        DockableTo = [dpTop, dpBottom]
        DockPos = 194
        DockRow = 1
        Images = ImageList
        ParentShowHint = False
        PopupMenu = PopupMenu
        ShowHint = True
        ShrinkMode = tbsmNone
        Stretch = True
        TabOrder = 0
        OnVisibleChanged = ToolbarTitleBarVisibleChanged
        Caption = #12499#12487#12458#12479#12452#12488#12523#12496#12540
        object LabelURL: TSpTBXLabelItem
          Caption = #12304'title'#12305
          Wrapping = twEndEllipsis
        end
      end
    end
    object DockLeft: TSpTBXDock
      Left = 137
      Top = 157
      Width = 9
      Height = 372
      FixAlign = True
      Position = dpLeft
    end
    object DockLeft2: TSpTBXMultiDock
      Left = 0
      Top = 157
      Width = 132
      Height = 372
      FixAlign = True
      Position = dpxLeft
      object SpTBXDockablePanelFavorite: TSpTBXDockablePanel
        Left = 0
        Top = 0
        Caption = #12362#27671#12395#20837#12426
        DockPos = 0
        TabOrder = 0
        Visible = False
        OnCloseQuery = SpTBXDockablePanelFavoriteCloseQuery
        object VirtualFavoriteView: TVirtualStringTree
          Left = 0
          Top = 26
          Width = 128
          Height = 326
          Align = alClient
          ClipboardFormats.Strings = (
            'Virtual Tree Data')
          DragMode = dmAutomatic
          EditDelay = 1000000
          Font.Charset = SHIFTJIS_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
          Font.Style = []
          Header.AutoSizeIndex = 0
          Header.Font.Charset = SHIFTJIS_CHARSET
          Header.Font.Color = clWindowText
          Header.Font.Height = -12
          Header.Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
          Header.Font.Style = []
          Header.MainColumn = -1
          Header.Options = [hoColumnResize, hoDrag]
          HintAnimation = hatNone
          HintMode = hmTooltip
          Images = ImageList
          ParentFont = False
          ParentShowHint = False
          PopupMenu = FavoritePopupMenu
          ShowHint = True
          TabOrder = 1
          TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoTristateTracking, toAutoDeleteMovedNodes, toDisableAutoscrollOnFocus, toDisableAutoscrollOnEdit]
          TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
          TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowTreeLines, toThemeAware]
          TreeOptions.SelectionOptions = [toMultiSelect, toRightClickSelect]
          OnClick = VirtualFavoriteViewClick
          OnContextPopup = VirtualFavoriteViewContextPopup
          OnDblClick = VirtualFavoriteViewDblClick
          OnDragAllowed = VirtualFavoriteViewDragAllowed
          OnDragOver = VirtualFavoriteViewDragOver
          OnDragDrop = VirtualFavoriteViewDragDrop
          OnEdited = VirtualFavoriteViewEdited
          OnEndDrag = VirtualFavoriteViewEndDrag
          OnGetText = VirtualFavoriteViewGetText
          OnGetImageIndex = VirtualFavoriteViewGetImageIndex
          OnGetHint = VirtualFavoriteViewGetHint
          OnKeyDown = VirtualFavoriteViewKeyDown
          OnNewText = VirtualFavoriteViewNewText
          Columns = <>
        end
      end
    end
    object DockRight: TSpTBXMultiDock
      Left = 487
      Top = 157
      Width = 264
      Height = 372
      FixAlign = True
      Position = dpxRight
      object SpTBXDockablePanelVideoInfo: TSpTBXDockablePanel
        Left = 0
        Top = 0
        Align = alClient
        Caption = #12499#12487#12458#24773#22577
        DockedWidth = 260
        DockPos = 0
        TabOrder = 0
        Visible = False
        OnCloseQuery = SpTBXDockablePanelVideoInfoCloseQuery
      end
      object SpTBXDockablePanelVideoRelated: TSpTBXDockablePanel
        Left = 0
        Top = 119
        Caption = #38306#36899#12499#12487#12458
        DockedWidth = 260
        DockPos = 119
        TabOrder = 1
        OnCloseQuery = SpTBXDockablePanelVideoRelatedCloseQuery
      end
      object SpTBXDockablePanelLog: TSpTBXDockablePanel
        Left = 0
        Top = 237
        Caption = #12525#12464
        DockedWidth = 260
        DockedHeight = 63
        DockPos = 237
        TabOrder = 2
        Visible = False
        OnCloseQuery = SpTBXDockablePanelLogCloseQuery
        object MemoLog: TMemo
          Left = 0
          Top = 26
          Width = 260
          Height = 89
          TabStop = False
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          Font.Charset = SHIFTJIS_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS UI Gothic'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 1
        end
      end
    end
    object DockRight2: TSpTBXDock
      Left = 473
      Top = 157
      Width = 9
      Height = 372
      FixAlign = True
      Position = dpRight
    end
    object DockTop: TSpTBXDock
      Left = 0
      Top = 0
      Width = 751
      Height = 157
      FixAlign = True
      object ToolbarMainMenu: TSpTBXToolbar
        Left = 0
        Top = 0
        CloseButton = False
        DockableTo = [dpTop, dpBottom]
        Images = ImageList
        MenuBar = True
        PopupMenu = PopupMenu
        ProcessShortCuts = True
        Stretch = True
        TabOrder = 0
        Caption = #12513#12491#12517#12540#12496#12540
        Customizable = False
        object MenuFile: TSpTBXSubmenuItem
          Caption = #12501#12449#12452#12523'(&F)'
          OnClick = MenuFileClick
          object MenuFileOpenNew: TSpTBXItem
            Caption = #26032#12375#12356'URL'#12434#38283#12367'(&N)...'
            Hint = #26032#12375#12356'URL'#12434#38283#12367
            Action = ActionOpenNew
          end
          object SpTBXSeparatorItem1: TSpTBXSeparatorItem
          end
          object MenuFileRecentlyViewed: TSpTBXSubmenuItem
            Caption = #26368#36817#35222#32884#12375#12383#21205#30011'(&V)'
          end
          object SpTBXSeparatorItem58: TSpTBXSeparatorItem
          end
          object SpTBXItem1: TSpTBXItem
            Caption = #12491#12467#12491#12467#24066#22580#12521#12531#12461#12531#12464#12434#38283#12367'(&I)'
            Action = ActionOpenNicoIchiba
          end
          object SpTBXSeparatorItem39: TSpTBXSeparatorItem
          end
          object MenuFilePlayDARAO: TSpTBXItem
            Caption = 'DARAO'#12434#35222#32884#12377#12427'(&Z)'
            Action = ActionPlayDARAO
          end
          object SpTBXSeparatorItem29: TSpTBXSeparatorItem
          end
          object MenuFileLogOut: TSpTBXSubmenuItem
            Caption = #12525#12464#12450#12454#12488'(&L)'
            object MenuFileLogOutFromYouTube: TSpTBXItem
              Caption = 'YouTube'#12363#12425#12525#12464#12450#12454#12488'(&Y)'
              Action = ActionLogOutFromYouTube
            end
            object MenuFileLogOutNicoVideo: TSpTBXItem
              Caption = #12491#12467#12491#12467#21205#30011#12363#12425#12525#12464#12450#12454#12488'(&N)'
              Action = ActionLogOutNicoVideo
            end
          end
          object SpTBXSeparatorItem45: TSpTBXSeparatorItem
          end
          object MenuFileRefresh: TSpTBXItem
            Caption = #20877#21462#24471'(&U)'
            Action = ActionRefresh
          end
          object MenuFileClearVideoPanel: TSpTBXItem
            Caption = #12499#12487#12458#12497#12493#12523#12434#31354#12395#12377#12427'(&C)'
            Hint = #12499#12487#12458#12497#12493#12523#12434#31354#12395#12377#12427
            Action = ActionClearVideoPanel
          end
          object SpTBXSeparatorItem13: TSpTBXSeparatorItem
          end
          object MenuFileCopyTitle: TSpTBXItem
            Caption = #12479#12452#12488#12523#12434#12467#12500#12540'(&0)'
            Action = ActionCopyTitle
          end
          object MenuFileCopyURL: TSpTBXItem
            Caption = 'URL'#12434#12467#12500#12540'(&1)'
            Action = ActionCopyURL
          end
          object MenuFileCopyTU: TSpTBXItem
            Caption = #12479#12452#12488#12523#12392'URL'#12434#12467#12500#12540'(&2)'
            Action = ActionCopyTU
          end
          object SpTBXSeparatorItem3: TSpTBXSeparatorItem
          end
          object MenuFileAddTag: TSpTBXItem
            Caption = #12479#12464#12434#26908#32034#12496#12540#12395#36861#21152#12377#12427'(&A)'
            Action = ActionAddTag
          end
          object MenuFileAddAuthor: TSpTBXItem
            Caption = #12518#12540#12470#12540#21517#12434#26908#32034#12496#12540#12395#36861#21152#12377#12427'(&B)'
            Action = ActionAddAuthor
          end
          object SpTBXSeparatorItem23: TSpTBXSeparatorItem
          end
          object MenuFileOpenPrimarySite: TSpTBXItem
            Caption = #20803#12493#12479#21205#30011#12434#38283#12367'(&P)'
            Action = ActionOpenPrimarySite
          end
          object SpTBXSeparatorItem16: TSpTBXSeparatorItem
          end
          object MenuFileSave: TSpTBXItem
            Caption = #12371#12398#12499#12487#12458#12434#20445#23384#12377#12427'(&S)...'
            Hint = #12371#12398#12499#12487#12458#12434#20445#23384#12377#12427
            Action = ActionSave
          end
          object MenuFileOpenByBrowser: TSpTBXItem
            Caption = #22806#37096#12502#12521#12454#12470#12391#38283#12367'(&O)...'
            Hint = #22806#37096#12502#12521#12454#12470#12391#38283#12367
            Action = ActionOpenByBrowser
          end
          object SpTBXSeparatorItem4: TSpTBXSeparatorItem
          end
          object MenuFileExit: TSpTBXItem
            Caption = #32066#20102'(&X)'
            Action = ActionExit
          end
        end
        object MenuView: TSpTBXSubmenuItem
          Caption = #34920#31034'(&V)'
          object MenuViewToolBarFixed: TSpTBXItem
            Caption = #12484#12540#12523#12496#12540#12434#22266#23450#12377#12427'(&F)'
            Action = ActionToolBarFixed
          end
          object SpTBXSeparatorItem18: TSpTBXSeparatorItem
          end
          object MenuViewToolBar: TSpTBXSubmenuItem
            Caption = #12484#12540#12523#12496#12540'(&T)'
            object MenuViewToolBarToggleMenuBar: TSpTBXItem
              Caption = #12513#12491#12517#12540#12496#12540'(&M)'
              Action = ActionToggleMenuBar
            end
            object MenuViewToolBarToggleToolBar: TSpTBXItem
              Caption = #12484#12540#12523#12496#12540'(&T)'
              Action = ActionToggleToolBar
            end
            object MenuViewToolBarToggleSearchBar: TSpTBXItem
              Caption = #26908#32034#12496#12540'(&S)'
              Action = ActionToggleSearchBar
            end
            object MenuViewToolBarToggleTitleBar: TSpTBXItem
              Caption = #12499#12487#12458#12479#12452#12488#12523#12496#12540'(&V)'
              Action = ActionToggleTitleBar
            end
          end
          object MenuViewLogPanel: TSpTBXItem
            Caption = #12525#12464#12497#12493#12523'(&L)'
            Action = ActionToggleLogPanel
          end
          object MenuViewFavoritePanel: TSpTBXItem
            Caption = #12362#27671#12395#20837#12426#12497#12493#12523'(&X)'
            Action = ActionToggleFavoritePanel
          end
          object MenuViewVideoInfoPanel: TSpTBXItem
            Caption = #12499#12487#12458#24773#22577#12497#12493#12523'(&V)'
            Hint = #12499#12487#12458#24773#22577#12497#12493#12523
            Action = ActionToggleVideoInfoPanel
          end
          object MenuViewVideoRelatedPanel: TSpTBXItem
            Caption = #38306#36899#12499#12487#12458#12497#12493#12523'(&R)'
            Hint = #38306#36899#12499#12487#12458#12497#12493#12523
            Action = ActionToggleVideoRelatedPanel
          end
          object MenuViewSearchPanel: TSpTBXItem
            Caption = #26908#32034#12497#12493#12523'(&Z)'
            Hint = #26908#32034#12497#12493#12523
            Action = ActionToggleSearchPanel
          end
          object MenuViewPanelSearchToolBar: TSpTBXItem
            Caption = #26908#32034#12496#12540'('#26908#32034#12497#12493#12523')(&B)'
            Action = ActionTogglePanelSearchToolBar
          end
          object MenuViewSplitter: TSpTBXItem
            Caption = #12473#12503#12522#12483#12479#12540'(&S)'
            Action = ActionToggleSplitter
          end
          object SpTBXSeparatorItem17: TSpTBXSeparatorItem
          end
          object MenuViewTheme: TSpTBXSubmenuItem
            Caption = #12486#12540#12510#22793#26356'(&0)'
            object SpTBXSkinGroupItem1: TSpTBXSkinGroupItem
            end
          end
          object SpTBXSeparatorItem2: TSpTBXSeparatorItem
          end
          object MenuViewStayOnTop: TSpTBXItem
            Caption = #26368#21069#38754'(&M)'
            Hint = #26368#21069#38754
            Action = ActionStayOnTop
          end
          object SpTBXSeparatorItem7: TSpTBXSeparatorItem
          end
          object MenuViewChangeVideoScale: TSpTBXItem
            Caption = #12499#12487#12458#12473#12465#12540#12523#12434#22793#26356#12377#12427'(&C)'
            Action = ActionChangeVideoScale
          end
          object SpTBXSeparatorItem40: TSpTBXSeparatorItem
          end
          object MenuViewUserWindowSize: TSpTBXItem
            Caption = #12454#12451#12531#12489#12454#12469#12452#12474#12434#12518#12540#12470#12540#35215#23450#20516#12395#12377#12427'(&U)'
            Hint = #12454#12451#12531#12489#12454#12469#12452#12474#12434#12518#12540#12470#12540#35215#23450#20516#12395#12377#12427
            Action = ActionUserWindowSize
          end
          object MenuViewDefaultWindowSize: TSpTBXItem
            Caption = #12454#12451#12531#12489#12454#12469#12452#12474#12434#35215#23450#20516#12395#25147#12377'(&W)'
            Action = ActionDefaultWindowSize
          end
          object MenuViewToggleWindowSize: TSpTBXItem
            Caption = #12454#12451#12531#12489#12454#12469#12452#12474#20999#26367'(&G)'
            Hint = #12454#12451#12531#12489#12454#12469#12452#12474#20999#26367
            Action = ActionToggleWindowSize
          end
          object SpTBXSeparatorItem12: TSpTBXSeparatorItem
          end
          object MenuViewMinimize: TSpTBXItem
            Caption = #26368#23567#21270'(&Y)'
            Action = ActionMinimize
          end
          object MenuViewHideInTaskTray: TSpTBXItem
            Caption = #12479#12473#12463#12488#12524#12452#12395#26684#32013'(&Z)'
            Action = ActionHideInTaskTray
          end
        end
        object MenuFavorite: TSpTBXSubmenuItem
          Caption = #12362#27671#12395#20837#12426'(&A)'
          OnClick = FavMenuCreate
          object MenuFavoriteAddFavorite: TSpTBXItem
            Caption = #12362#27671#12395#20837#12426#12395#36861#21152'(&A)'
            Action = ActionAddFavorite
          end
          object SpTBXSeparatorItem50: TSpTBXSeparatorItem
          end
        end
        object MenuSearch: TSpTBXSubmenuItem
          Caption = #26908#32034'(&S)'
          object MenuSearchSearchBarSearch: TSpTBXItem
            Caption = #26908#32034'(&F)'
            Hint = #26908#32034
            Action = ActionSearchBarSearch
          end
          object MenuSearchSearchBarAdd100: TSpTBXItem
            Caption = #36861#21152#26908#32034'(&A)'
            Hint = #36861#21152#26908#32034
            Action = ActionSearchBarAdd100
          end
          object MenuSearchSearchBarToggleListView: TSpTBXItem
            Caption = #34920#31034#20999#26367'(&S)'
            Hint = #34920#31034#20999#26367
            Action = ActionSearchBarToggleListView
          end
          object SpTBXSeparatorItem30: TSpTBXSeparatorItem
          end
          object MenuSearchToggleSearchTarget: TSpTBXSubmenuItem
            Caption = #26908#32034#20808#20999#26367'(&T)'
            ImageIndex = 13
            Images = ImageList
            object MenuSearchToggleSearchTargetYouTubeNormal: TSpTBXItem
              Caption = 'YouTube('#27161#28310#26908#32034')(&0)'
              ImageIndex = 13
              RadioItem = True
              OnClick = ActionToggleSearchTargetExecute
            end
            object MenuSearchToggleSearchTargetYouTubeRelated: TSpTBXItem
              Tag = 1
              Caption = 'YouTube('#38306#36899#26908#32034')(&1)'
              ImageIndex = 13
              RadioItem = True
              OnClick = ActionToggleSearchTargetExecute
            end
            object MenuSearchToggleSearchTargetYouTubeFromWebSite: TSpTBXItem
              Tag = 100
              Caption = 'YouTube('#12469#12452#12488#20869#26908#32034')(&2)'
              ImageIndex = 13
              OnClick = ActionToggleSearchTargetExecute
            end
            object SpTBXSeparatorItem59: TSpTBXSeparatorItem
            end
            object MenuSearchToggleSearchTargetNicoVideoNewRes: TSpTBXItem
              Tag = 2
              Caption = #12491#12467#12491#12467#21205#30011'('#25237#31295#26085#26178#12364#26032#12375#12356#38918')(&3)'
              ImageIndex = 14
              RadioItem = True
              OnClick = ActionToggleSearchTargetExecute
            end
            object MenuSearchToggleSearchTargetNicoVideoOldRes: TSpTBXItem
              Tag = 3
              Caption = #12491#12467#12491#12467#21205#30011'('#25237#31295#26085#26178#12364#21476#12356#38918')(&4)'
              ImageIndex = 14
              RadioItem = True
              OnClick = ActionToggleSearchTargetExecute
            end
            object SpTBXSeparatorItem60: TSpTBXSeparatorItem
            end
            object MenuSearchToggleSearchTargetNicoVideoMoreView: TSpTBXItem
              Tag = 4
              Caption = #12491#12467#12491#12467#21205#30011'('#20877#29983#12364#22810#12356#38918')(&5)'
              ImageIndex = 14
              RadioItem = True
              OnClick = ActionToggleSearchTargetExecute
            end
            object MenuSearchToggleSearchTargetNicoVideoLessView: TSpTBXItem
              Tag = 5
              Caption = #12491#12467#12491#12467#21205#30011'('#20877#29983#12364#23569#12394#12356#38918')(&6)'
              ImageIndex = 14
              RadioItem = True
              OnClick = ActionToggleSearchTargetExecute
            end
            object SpTBXSeparatorItem61: TSpTBXSeparatorItem
            end
            object SpTBXItem9: TSpTBXItem
              Tag = 6
              Caption = #12491#12467#12491#12467#21205#30011'('#12467#12513#12531#12488#12364#26032#12375#12356#38918')(&7)'
              ImageIndex = 14
              RadioItem = True
              OnClick = ActionToggleSearchTargetExecute
            end
            object SpTBXItem4: TSpTBXItem
              Tag = 7
              Caption = #12491#12467#12491#12467#21205#30011'('#12467#12513#12531#12488#12364#21476#12356#38918')(&8)'
              ImageIndex = 14
              RadioItem = True
              OnClick = ActionToggleSearchTargetExecute
            end
            object SpTBXSeparatorItem62: TSpTBXSeparatorItem
            end
            object SpTBXItem3: TSpTBXItem
              Tag = 8
              Caption = #12491#12467#12491#12467#21205#30011'('#12467#12513#12531#12488#12364#22810#12356#38918')(&9)'
              ImageIndex = 14
              RadioItem = True
              OnClick = ActionToggleSearchTargetExecute
            end
            object SpTBXItem2: TSpTBXItem
              Tag = 9
              Caption = #12491#12467#12491#12467#21205#30011'('#12467#12513#12531#12488#12364#23569#12394#12356#38918')(&A)'
              ImageIndex = 14
              RadioItem = True
              OnClick = ActionToggleSearchTargetExecute
            end
            object SpTBXSeparatorItem69: TSpTBXSeparatorItem
            end
            object SpTBXItem18: TSpTBXItem
              Tag = 10
              Caption = #12491#12467#12491#12467#21205#30011'('#12510#12452#12522#12473#12488#30331#37682#25968#12364#22810#12356#38918')(&B)'
              ImageIndex = 14
              RadioItem = True
              OnClick = ActionToggleSearchTargetExecute
            end
            object SpTBXItem17: TSpTBXItem
              Tag = 11
              Caption = #12491#12467#12491#12467#21205#30011'('#12510#12452#12522#12473#12488#30331#37682#25968#12364#23569#12394#12356#38918')(&C)'
              ImageIndex = 14
              RadioItem = True
              OnClick = ActionToggleSearchTargetExecute
            end
            object SpTBXSeparatorItem63: TSpTBXSeparatorItem
            end
            object MenuSearchToggleSearchTargetNicoVideoTag: TSpTBXItem
              Tag = 20
              Caption = #12491#12467#12491#12467#21205#30011'('#12479#12464#26908#32034'-'#25237#31295#26085#26178#12364#26032#12375#12356#38918')(&H)'
              ImageIndex = 14
              RadioItem = True
              OnClick = ActionToggleSearchTargetExecute
            end
            object SpTBXItem16: TSpTBXItem
              Tag = 21
              Caption = #12491#12467#12491#12467#21205#30011'('#12479#12464#26908#32034'-'#25237#31295#26085#26178#12364#21476#12356#38918')(&I)'
              ImageIndex = 14
              RadioItem = True
              OnClick = ActionToggleSearchTargetExecute
            end
            object SpTBXSeparatorItem64: TSpTBXSeparatorItem
            end
            object SpTBXItem15: TSpTBXItem
              Tag = 22
              Caption = #12491#12467#12491#12467#21205#30011'('#12479#12464#26908#32034'-'#20877#29983#12364#22810#12356#38918')(&J)'
              ImageIndex = 14
              RadioItem = True
              OnClick = ActionToggleSearchTargetExecute
            end
            object SpTBXItem14: TSpTBXItem
              Tag = 23
              Caption = #12491#12467#12491#12467#21205#30011'('#12479#12464#26908#32034'-'#20877#29983#12364#23569#12394#12356#38918')(&K)'
              ImageIndex = 14
              RadioItem = True
              OnClick = ActionToggleSearchTargetExecute
            end
            object SpTBXSeparatorItem65: TSpTBXSeparatorItem
            end
            object SpTBXItem13: TSpTBXItem
              Tag = 24
              Caption = #12491#12467#12491#12467#21205#30011'('#12479#12464#26908#32034'-'#12467#12513#12531#12488#12364#26032#12375#12356#38918')(&L)'
              ImageIndex = 14
              RadioItem = True
              OnClick = ActionToggleSearchTargetExecute
            end
            object SpTBXItem12: TSpTBXItem
              Tag = 25
              Caption = #12491#12467#12491#12467#21205#30011'('#12479#12464#26908#32034'-'#12467#12513#12531#12488#12364#21476#12356#38918')(&M)'
              ImageIndex = 14
              RadioItem = True
              OnClick = ActionToggleSearchTargetExecute
            end
            object SpTBXSeparatorItem66: TSpTBXSeparatorItem
            end
            object SpTBXItem11: TSpTBXItem
              Tag = 26
              Caption = #12491#12467#12491#12467#21205#30011'('#12479#12464#26908#32034'-'#12467#12513#12531#12488#12364#22810#12356#38918')(&N) '
              ImageIndex = 14
              RadioItem = True
              OnClick = ActionToggleSearchTargetExecute
            end
            object SpTBXItem10: TSpTBXItem
              Tag = 27
              Caption = #12491#12467#12491#12467#21205#30011'('#12479#12464#26908#32034'-'#12467#12513#12531#12488#12364#23569#12394#12356#38918')(&O)'
              ImageIndex = 14
              RadioItem = True
              OnClick = ActionToggleSearchTargetExecute
            end
            object SpTBXSeparatorItem70: TSpTBXSeparatorItem
            end
            object SpTBXItem20: TSpTBXItem
              Tag = 28
              Caption = #12491#12467#12491#12467#21205#30011'('#12479#12464#26908#32034'-'#12510#12452#12522#12473#12488#30331#37682#25968#12364#22810#12356#38918')(&P)'
              ImageIndex = 14
              RadioItem = True
              OnClick = ActionToggleSearchTargetExecute
            end
            object SpTBXItem19: TSpTBXItem
              Tag = 29
              Caption = #12491#12467#12491#12467#21205#30011'('#12479#12464#26908#32034'-'#12510#12452#12522#12473#12488#30331#37682#25968#12364#23569#12394#12356#38918')(&Q)'
              ImageIndex = 14
              RadioItem = True
              OnClick = ActionToggleSearchTargetExecute
            end
            object SpTBXSeparatorItem44: TSpTBXSeparatorItem
            end
            object MenuSearchToggleSearchTargetYouTubeSetting: TSpTBXSubmenuItem
              Tag = 9999
              Caption = 'YouTube('#12469#12452#12488#20869#26908#32034')'#12398#35373#23450'(&Z)'
              object MenuSearchToggleSearchTargetYouTubeSettingSort: TSpTBXSubmenuItem
                Caption = #12477#12540#12488'(&S)'
                OnClick = MenuSearchToggleSearchTargetYouTubeSettingSortClick
                object MenuSearchToggleSearchTargetYouTubeSettingSort0: TSpTBXItem
                  Caption = #38306#36899#24230'(&R)'
                  OnClick = MenuSearchToggleSearchTargetYouTubeSettingSortExecute
                end
                object MenuSearchToggleSearchTargetYouTubeSettingSort1: TSpTBXItem
                  Tag = 1
                  Caption = #36861#21152#26085'(&A)'
                  OnClick = MenuSearchToggleSearchTargetYouTubeSettingSortExecute
                end
                object MenuSearchToggleSearchTargetYouTubeSettingSort2: TSpTBXItem
                  Tag = 2
                  Caption = #20877#29983#22238#25968'(&V)'
                  OnClick = MenuSearchToggleSearchTargetYouTubeSettingSortExecute
                end
                object MenuSearchToggleSearchTargetYouTubeSettingSort3: TSpTBXItem
                  Tag = 3
                  Caption = #35413#20385'(&P)'
                  OnClick = MenuSearchToggleSearchTargetYouTubeSettingSortExecute
                end
              end
              object MenuSearchToggleSearchTargetYouTubeSettingCategory: TSpTBXSubmenuItem
                Caption = #12459#12486#12468#12522'(&C)'
                OnClick = MenuSearchToggleSearchTargetYouTubeSettingCategoryClick
                object MenuSearchToggleSearchTargetYouTubeSettingCategory0: TSpTBXItem
                  Caption = #12377#12409#12390'(&A)'
                  OnClick = MenuSearchToggleSearchTargetYouTubeSettingCategoryExecute
                end
                object MenuSearchToggleSearchTargetYouTubeSettingCategory2: TSpTBXItem
                  Tag = 2
                  Caption = #33258#21205#36554#12392#20055#12426#29289'(&B)'
                  OnClick = MenuSearchToggleSearchTargetYouTubeSettingCategoryExecute
                end
                object MenuSearchToggleSearchTargetYouTubeSettingCategory23: TSpTBXItem
                  Tag = 23
                  Caption = #12467#12513#12487#12451#12540'(&C)'
                  OnClick = MenuSearchToggleSearchTargetYouTubeSettingCategoryExecute
                end
                object MenuSearchToggleSearchTargetYouTubeSettingCategory24: TSpTBXItem
                  Tag = 24
                  Caption = #12456#12531#12479#12540#12486#12452#12513#12531#12488'(&D)'
                  OnClick = MenuSearchToggleSearchTargetYouTubeSettingCategoryExecute
                end
                object MenuSearchToggleSearchTargetYouTubeSettingCategory1: TSpTBXItem
                  Tag = 1
                  Caption = #26144#30011#12392#12450#12491#12513'(&E)'
                  OnClick = MenuSearchToggleSearchTargetYouTubeSettingCategoryExecute
                end
                object MenuSearchToggleSearchTargetYouTubeSettingCategory20: TSpTBXItem
                  Tag = 20
                  Caption = #12466#12540#12512#12392#12460#12472#12455#12483#12488'(&F)'
                  OnClick = MenuSearchToggleSearchTargetYouTubeSettingCategoryExecute
                end
                object MenuSearchToggleSearchTargetYouTubeSettingCategory26: TSpTBXItem
                  Tag = 26
                  Caption = #12495#12454#12484#12540' DIY(&G)'
                  OnClick = MenuSearchToggleSearchTargetYouTubeSettingCategoryExecute
                end
                object MenuSearchToggleSearchTargetYouTubeSettingCategory10: TSpTBXItem
                  Tag = 10
                  Caption = #38899#27005'(&H)'
                  OnClick = MenuSearchToggleSearchTargetYouTubeSettingCategoryExecute
                end
                object MenuSearchToggleSearchTargetYouTubeSettingCategory25: TSpTBXItem
                  Tag = 25
                  Caption = #12491#12517#12540#12473#12392#25919#27835'(&I)'
                  OnClick = MenuSearchToggleSearchTargetYouTubeSettingCategoryExecute
                end
                object MenuSearchToggleSearchTargetYouTubeSettingCategory22: TSpTBXItem
                  Tag = 22
                  Caption = #12502#12525#12464#12392#20154'(&J)'
                  OnClick = MenuSearchToggleSearchTargetYouTubeSettingCategoryExecute
                end
                object MenuSearchToggleSearchTargetYouTubeSettingCategory15: TSpTBXItem
                  Tag = 15
                  Caption = #12506#12483#12488#12392#21205#29289'(&K)'
                  OnClick = MenuSearchToggleSearchTargetYouTubeSettingCategoryExecute
                end
                object MenuSearchToggleSearchTargetYouTubeSettingCategory17: TSpTBXItem
                  Tag = 17
                  Caption = #12473#12509#12540#12484'(&L)'
                  OnClick = MenuSearchToggleSearchTargetYouTubeSettingCategoryExecute
                end
                object MenuSearchToggleSearchTargetYouTubeSettingCategory19: TSpTBXItem
                  Tag = 19
                  Caption = #26053#34892#12392#35370#21839#12473#12509#12483#12488'(&M)'
                  OnClick = MenuSearchToggleSearchTargetYouTubeSettingCategoryExecute
                end
              end
            end
          end
          object SpTBXSeparatorItem31: TSpTBXSeparatorItem
          end
          object MenuSearchYouTube: TSpTBXSubmenuItem
            Caption = 'YouTube(&Y)'
            ImageIndex = 13
            object MenuSearchYouTubeFeatured: TSpTBXItem
              Tag = 10
              Caption = #27880#30446#12398#21205#30011'(&F)'
              OnClick = GetYouTubeDataExecute
            end
            object SpTBXSeparatorItem38: TSpTBXSeparatorItem
            end
            object MenuSearchYouTubePopular: TSpTBXSubmenuItem
              Caption = #20154#27671#12398#21205#30011'(&P)'
              object MenuSearchYouTubePopularDay: TSpTBXItem
                Tag = 20
                Caption = #26412#26085#20998'(&0)'
                OnClick = GetYouTubeDataExecute
              end
              object MenuSearchYouTubePopularWeek: TSpTBXItem
                Tag = 21
                Caption = #20170#36913'(&1)'
                OnClick = GetYouTubeDataExecute
              end
              object MenuSearchYouTubePopularMonth: TSpTBXItem
                Tag = 22
                Caption = #20170#26376'(&2)'
                OnClick = GetYouTubeDataExecute
              end
              object MenuSearchYouTubePopularAll: TSpTBXItem
                Tag = 23
                Caption = #20840#26399#38291'(&3)'
                OnClick = GetYouTubeDataExecute
              end
            end
            object SpTBXSeparatorItem41: TSpTBXSeparatorItem
            end
            object MenuSearchYouTubeMostRecent: TSpTBXItem
              Tag = 100
              Caption = #26032#30528#21205#30011'('#26085#26412')(&N)'
              OnClick = GetYouTubeDataFromSiteExecute
            end
            object MenuSearchYouTubeMostViewed: TSpTBXSubmenuItem
              Caption = #20154#27671#12398#21205#30011'('#26085#26412')(&V)'
              object MenuSearchYouTubeMostViewedDay: TSpTBXItem
                Tag = 110
                Caption = #26412#26085#20998'(&0)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
              object MenuSearchYouTubeMostViewedWeek: TSpTBXItem
                Tag = 111
                Caption = #20170#36913'(&1)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
              object MenuSearchYouTubeMostViewedMonth: TSpTBXItem
                Tag = 112
                Caption = #20170#26376'(&2)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
              object MenuSearchYouTubeMostViewedAll: TSpTBXItem
                Tag = 113
                Caption = #20840#26399#38291'(&3)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
            end
            object MenuSearchYouTubeTopRated: TSpTBXSubmenuItem
              Caption = #35413#20385#12398#39640#12356#21205#30011'('#26085#26412')(&R)'
              object MenuSearchYouTubeTopRatedDay: TSpTBXItem
                Tag = 120
                Caption = #26412#26085#20998'(&0)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
              object MenuSearchYouTubeTopRatedWeek: TSpTBXItem
                Tag = 121
                Caption = #20170#36913'(&1)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
              object MenuSearchYouTubeTopRatedMonth: TSpTBXItem
                Tag = 122
                Caption = #20170#26376'(&2)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
              object MenuSearchYouTubeTopRatedAll: TSpTBXItem
                Tag = 123
                Caption = #20840#26399#38291'(&3)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
            end
            object MenuSearchYouTubeMostDiscussed: TSpTBXSubmenuItem
              Caption = #35441#38988#12398#21205#30011'('#26085#26412')(&C)'
              object MenuSearchYouTubeMostDiscussedDay: TSpTBXItem
                Tag = 130
                Caption = #26412#26085#20998'(&0)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
              object MenuSearchYouTubeMostDiscussedWeek: TSpTBXItem
                Tag = 131
                Caption = #20170#36913'(&1)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
              object MenuSearchYouTubeMostDiscussedMonth: TSpTBXItem
                Tag = 132
                Caption = #20170#26376'(&2)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
              object MenuSearchYouTubeMostDiscussedAll: TSpTBXItem
                Tag = 133
                Caption = #20840#26399#38291'(&3)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
            end
            object MenuSearchYouTubeTopFavorites: TSpTBXSubmenuItem
              Caption = #12362#27671#12395#20837#12426#30331#37682#12398#22810#12356#21205#30011'('#26085#26412')(&T)'
              object MenuSearchYouTubeTopFavoritesDay: TSpTBXItem
                Tag = 140
                Caption = #26412#26085#20998'(&0)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
              object MenuSearchYouTubeTopFavoritesWeek: TSpTBXItem
                Tag = 141
                Caption = #20170#36913'(&1)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
              object MenuSearchYouTubeTopFavoritesMonth: TSpTBXItem
                Tag = 142
                Caption = #20170#26376'(&2)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
              object MenuSearchYouTubeTopFavoritesAll: TSpTBXItem
                Tag = 143
                Caption = #20840#26399#38291'(&3)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
            end
            object MenuSearchYouTubeMostLinked: TSpTBXSubmenuItem
              Caption = #12522#12531#12463#25968#12398#22810#12356#21205#30011'('#26085#26412')(&L)'
              object MenuSearchYouTubeMostRespondedDay: TSpTBXItem
                Tag = 150
                Caption = #26412#26085#20998'(&0)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
              object MenuSearchYouTubeMostRespondedWeek: TSpTBXItem
                Tag = 151
                Caption = #20170#36913'(&1)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
              object MenuSearchYouTubeMostRespondedMonth: TSpTBXItem
                Tag = 152
                Caption = #20170#26376'(&2)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
              object MenuSearchYouTubeMostRespondedAll: TSpTBXItem
                Tag = 153
                Caption = #20840#26399#38291'(&3)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
            end
            object MenuSearchYouTubeMostResponded: TSpTBXSubmenuItem
              Caption = #12467#12513#12531#12488#12398#22810#12356#21205#30011'('#26085#26412')(&M)'
              object SpTBXItem8: TSpTBXItem
                Tag = 160
                Caption = #26412#26085#20998'(&0)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
              object SpTBXItem7: TSpTBXItem
                Tag = 161
                Caption = #20170#36913'(&1)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
              object SpTBXItem6: TSpTBXItem
                Tag = 162
                Caption = #20170#26376'(&2)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
              object SpTBXItem5: TSpTBXItem
                Tag = 163
                Caption = #20840#26399#38291'(&3)'
                OnClick = GetYouTubeDataFromSiteExecute
              end
            end
            object SpTBXSeparatorItem43: TSpTBXSeparatorItem
            end
            object MenuSearchYouTubeCategorySetting: TSpTBXSubmenuItem
              Caption = #12459#12486#12468#12522#35373#23450'(&Z)'
              Visible = False
              OnClick = MenuSearchYouTubeCategorySettingClick
              object MenuSearchYouTubeCategorySetting0: TSpTBXItem
                Caption = #12377#12409#12390'(&A)'
                OnClick = SetYouTubeCategoryExecute
              end
              object MenuSearchYouTubeCategorySetting2: TSpTBXItem
                Tag = 2
                Caption = #33258#21205#36554#12392#20055#12426#29289'(&B)'
                OnClick = SetYouTubeCategoryExecute
              end
              object MenuSearchYouTubeCategorySetting23: TSpTBXItem
                Tag = 23
                Caption = #12467#12513#12487#12451#12540'(&C)'
                OnClick = SetYouTubeCategoryExecute
              end
              object MenuSearchYouTubeCategorySetting24: TSpTBXItem
                Tag = 24
                Caption = #12456#12531#12479#12540#12486#12452#12513#12531#12488'(&D)'
                OnClick = SetYouTubeCategoryExecute
              end
              object MenuSearchYouTubeCategorySetting1: TSpTBXItem
                Tag = 1
                Caption = #26144#30011#12392#12450#12491#12513'(&E)'
                OnClick = SetYouTubeCategoryExecute
              end
              object MenuSearchYouTubeCategorySetting20: TSpTBXItem
                Tag = 20
                Caption = #12466#12540#12512#12392#12460#12472#12455#12483#12488'(&F)'
                OnClick = SetYouTubeCategoryExecute
              end
              object MenuSearchYouTubeCategorySetting26: TSpTBXItem
                Tag = 26
                Caption = #12495#12454#12484#12540' DIY(&G)'
                OnClick = SetYouTubeCategoryExecute
              end
              object MenuSearchYouTubeCategorySetting10: TSpTBXItem
                Tag = 10
                Caption = #38899#27005'(&H)'
                OnClick = SetYouTubeCategoryExecute
              end
              object MenuSearchYouTubeCategorySetting25: TSpTBXItem
                Tag = 25
                Caption = #12491#12517#12540#12473#12392#25919#27835'(&I)'
                OnClick = SetYouTubeCategoryExecute
              end
              object MenuSearchYouTubeCategorySetting22: TSpTBXItem
                Tag = 22
                Caption = #12502#12525#12464#12392#20154'(&J)'
                OnClick = SetYouTubeCategoryExecute
              end
              object MenuSearchYouTubeCategorySetting15: TSpTBXItem
                Tag = 15
                Caption = #12506#12483#12488#12392#21205#29289'(&K)'
                OnClick = SetYouTubeCategoryExecute
              end
              object MenuSearchYouTubeCategorySetting17: TSpTBXItem
                Tag = 17
                Caption = #12473#12509#12540#12484'(&L)'
                OnClick = SetYouTubeCategoryExecute
              end
              object MenuSearchYouTubeCategorySetting19: TSpTBXItem
                Tag = 19
                Caption = #26053#34892#12392#35370#21839#12473#12509#12483#12488'(&M)'
                OnClick = SetYouTubeCategoryExecute
              end
            end
          end
          object SpTBXSeparatorItem37: TSpTBXSeparatorItem
          end
          object MenuSearchNicoVideo: TSpTBXSubmenuItem
            Caption = #12491#12467#12491#12467#21205#30011'(&N)'
            ImageIndex = 14
            object MenuSearchNicoVideoRankingViewNewall: TSpTBXItem
              Tag = 10
              Caption = #20877#29983#12521#12531#12461#12531#12464'('#27598#26178')(&1)'
              OnClick = GetRankingExecute
            end
            object MenuSearchNicoVideoRankingViewDailyall: TSpTBXItem
              Tag = 20
              Caption = #20877#29983#12521#12531#12461#12531#12464'('#12487#12452#12522#12540')(&2)'
              OnClick = GetRankingExecute
            end
            object MenuSearchNicoVideoRankingViewWeeklyall: TSpTBXItem
              Tag = 30
              Caption = #20877#29983#12521#12531#12461#12531#12464'('#36913#38291')(&3)'
              OnClick = GetRankingExecute
            end
            object MenuSearchNicoVideoRankingViewMonthlyall: TSpTBXItem
              Tag = 40
              Caption = #20877#29983#12521#12531#12461#12531#12464'('#26376#38291')(&4)'
              OnClick = GetRankingExecute
            end
            object MenuSearchNicoVideoRankingViewTotalall: TSpTBXItem
              Tag = 50
              Caption = #20877#29983#12521#12531#12461#12531#12464'('#21512#35336')(&5)'
              OnClick = GetRankingExecute
            end
            object SpTBXSeparatorItem33: TSpTBXSeparatorItem
            end
            object MenuSearchNicoVideoRankingResNewall: TSpTBXItem
              Tag = 110
              Caption = #12467#12513#12531#12488#12521#12531#12461#12531#12464'('#27598#26178')(&6)'
              OnClick = GetRankingExecute
            end
            object MenuSearchNicoVideoRankingResDailyall: TSpTBXItem
              Tag = 120
              Caption = #12467#12513#12531#12488#12521#12531#12461#12531#12464'('#12487#12452#12522#12540')(&7)'
              OnClick = GetRankingExecute
            end
            object MenuSearchNicoVideoRankingResWeeklyall: TSpTBXItem
              Tag = 130
              Caption = #12467#12513#12531#12488#12521#12531#12461#12531#12464'('#36913#38291')(&8)'
              OnClick = GetRankingExecute
            end
            object MenuSearchNicoVideoRankingResMonthlyall: TSpTBXItem
              Tag = 140
              Caption = #12467#12513#12531#12488#12521#12531#12461#12531#12464'('#26376#38291')(&9)'
              OnClick = GetRankingExecute
            end
            object MenuSearchNicoVideoRankingResTotalall: TSpTBXItem
              Tag = 150
              Caption = #12467#12513#12531#12488#12521#12531#12461#12531#12464'('#21512#35336')(&0)'
              OnClick = GetRankingExecute
            end
            object SpTBXSeparatorItem34: TSpTBXSeparatorItem
            end
            object MenuSearchNicoVideoRankingMylistNewall: TSpTBXItem
              Tag = 210
              Caption = #12510#12452#12522#12473#12488#30331#37682#12521#12531#12461#12531#12464'('#27598#26178')(&A)'
              OnClick = GetRankingExecute
            end
            object MenuSearchNicoVideoRankingMylistTotalDailyall: TSpTBXItem
              Tag = 220
              Caption = #12510#12452#12522#12473#12488#30331#37682#12521#12531#12461#12531#12464'('#12487#12452#12522#12540')(&B)'
              OnClick = GetRankingExecute
            end
            object MenuSearchNicoVideoRankingMylistTotalWeeklyall: TSpTBXItem
              Tag = 230
              Caption = #12510#12452#12522#12473#12488#30331#37682#12521#12531#12461#12531#12464'('#36913#38291')(&C)'
              OnClick = GetRankingExecute
            end
            object MenuSearchNicoVideoRankingMylistTotalMonthlyall: TSpTBXItem
              Tag = 240
              Caption = #12510#12452#12522#12473#12488#30331#37682#12521#12531#12461#12531#12464'('#26376#38291')(&D)'
              OnClick = GetRankingExecute
            end
            object MenuSearchNicoVideoRankingMylistTotalall: TSpTBXItem
              Tag = 250
              Caption = #12510#12452#12522#12473#12488#30331#37682#12521#12531#12461#12531#12464'('#21512#35336')(&E)'
              OnClick = GetRankingExecute
            end
            object SpTBXSeparatorItem32: TSpTBXSeparatorItem
            end
            object MenuSearchNicoVideoNewarrival: TSpTBXItem
              Tag = 1
              Caption = #26032#30528#25237#31295#21205#30011' '#12488#12483#12503'300(&F)'
              OnClick = GetExtraExecute
            end
            object SpTBXSeparatorItem35: TSpTBXSeparatorItem
            end
            object MenuSearchNicoVideoRecent: TSpTBXItem
              Tag = 2
              Caption = #26368#26032#12467#12513#12531#12488#21205#30011' '#12488#12483#12503'300(&G)'
              OnClick = GetExtraExecute
            end
            object SpTBXSeparatorItem36: TSpTBXSeparatorItem
            end
            object MenuSearchNicoVideoRandom: TSpTBXItem
              Tag = 3
              Caption = #12365#12414#12368#12428#26908#32034'(&H)'
              Enabled = False
              Visible = False
              OnClick = GetExtraExecute
            end
            object MenuSearchNicoVideoHotlist: TSpTBXItem
              Tag = 4
              Caption = #12507#12483#12488#12522#12473#12488'(&H)'
              OnClick = GetExtraExecute
            end
            object SpTBXSeparatorItem67: TSpTBXSeparatorItem
            end
            object MenuSearchNicoVideoCategorySetting: TSpTBXSubmenuItem
              Caption = #12459#12486#12468#12522#35373#23450'(&Z)'
              OnClick = MenuSearchNicoVideoCategorySettingClick
              object MenuSearchNicoVideoCategorySetting0: TSpTBXItem
                Caption = #32207#21512'(&A)'
                OnClick = MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute
              end
              object MenuSearchNicoVideoCategorySetting1: TSpTBXItem
                Tag = 1
                Caption = #38899#27005'(&B)'
                OnClick = MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute
              end
              object MenuSearchNicoVideoCategorySetting2: TSpTBXItem
                Tag = 2
                Caption = #12456#12531#12479#12540#12486#12452#12513#12531#12488'(&C)'
                OnClick = MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute
              end
              object MenuSearchNicoVideoCategorySetting3: TSpTBXItem
                Tag = 3
                Caption = #12450#12491#12513'(&D)'
                OnClick = MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute
              end
              object MenuSearchNicoVideoCategorySetting4: TSpTBXItem
                Tag = 4
                Caption = #12466#12540#12512'(&E)'
                OnClick = MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute
              end
              object MenuSearchNicoVideoCategorySetting5: TSpTBXItem
                Tag = 5
                Caption = #21205#29289'(&F)'
                OnClick = MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute
              end
              object MenuSearchNicoVideoCategorySetting6: TSpTBXItem
                Tag = 6
                Caption = #12450#12531#12465#12540#12488'(&G)'
                OnClick = MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute
              end
              object MenuSearchNicoVideoCategorySetting7: TSpTBXItem
                Tag = 7
                Caption = #12521#12472#12458'(&H)'
                OnClick = MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute
              end
              object MenuSearchNicoVideoCategorySetting8: TSpTBXItem
                Tag = 8
                Caption = #12473#12509#12540#12484'(&I)'
                OnClick = MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute
              end
              object MenuSearchNicoVideoCategorySetting9: TSpTBXItem
                Tag = 9
                Caption = #25919#27835'(&J)'
                OnClick = MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute
              end
              object MenuSearchNicoVideoCategorySetting10: TSpTBXItem
                Tag = 10
                Caption = #12481#12515#12483#12488'(&K)'
                OnClick = MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute
              end
              object MenuSearchNicoVideoCategorySetting11: TSpTBXItem
                Tag = 11
                Caption = #31185#23398'(&L)'
                OnClick = MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute
              end
              object MenuSearchNicoVideoCategorySetting12: TSpTBXItem
                Tag = 12
                Caption = #27508#21490'(&M)'
                OnClick = MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute
              end
              object MenuSearchNicoVideoCategorySetting13: TSpTBXItem
                Tag = 13
                Caption = #26009#29702'(&N)'
                OnClick = MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute
              end
              object MenuSearchNicoVideoCategorySetting14: TSpTBXItem
                Tag = 14
                Caption = #33258#28982'(&O)'
                OnClick = MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute
              end
              object MenuSearchNicoVideoCategorySetting15: TSpTBXItem
                Tag = 15
                Caption = #26085#35352'(&P)'
                OnClick = MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute
              end
              object MenuSearchNicoVideoCategorySetting16: TSpTBXItem
                Tag = 16
                Caption = #36362#12387#12390#12415#12383'(&Q)'
                OnClick = MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute
              end
              object MenuSearchNicoVideoCategorySetting17: TSpTBXItem
                Tag = 17
                Caption = #27468#12387#12390#12415#12383'(&R)'
                OnClick = MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute
              end
              object MenuSearchNicoVideoCategorySetting18: TSpTBXItem
                Tag = 18
                Caption = #28436#22863#12375#12390#12415#12383'(&S)'
                OnClick = MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute
              end
              object MenuSearchNicoVideoCategorySetting19: TSpTBXItem
                Tag = 19
                Caption = #12491#12467#12491#12467#21205#30011#35611#24231'(&T)'
                OnClick = MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute
              end
              object MenuSearchNicoVideoCategorySetting20: TSpTBXItem
                Tag = 20
                Caption = #12381#12398#20182'(&U)'
                OnClick = MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute
              end
              object MenuSearchNicoVideoCategorySetting21: TSpTBXItem
                Tag = 21
                Caption = #12486#12473#12488'(&V)'
                OnClick = MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute
              end
              object MenuSearchNicoVideoCategorySetting22: TSpTBXItem
                Tag = 22
                Caption = 'R-18(&W)'
                OnClick = MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute
              end
            end
          end
          object SpTBXSeparatorItem27: TSpTBXSeparatorItem
          end
          object MenuSearchClearHistory: TSpTBXItem
            Caption = #26908#32034#23653#27508#21066#38500'(&D)...'
            Action = ActionClearSearchHistory
          end
        end
        object MenuTool: TSpTBXSubmenuItem
          Caption = #12484#12540#12523'(&T)'
          object MenuToolSetting: TSpTBXItem
            Caption = #35373#23450'(&Z)...'
            Hint = #35373#23450
            Action = ActionSetting
          end
          object SpTBXSeparatorItem15: TSpTBXSeparatorItem
          end
          object MenuToolCustomize: TSpTBXItem
            Caption = #12459#12473#12479#12510#12452#12474'(&C)...'
            Action = ActionCustomize
          end
          object SpTBXSeparatorItem26: TSpTBXSeparatorItem
          end
          object MenuToolClearRecentlyViewed: TSpTBXItem
            Caption = #26368#36817#35222#32884#12375#12383#21205#30011#12398#23653#27508#12434#21066#38500'...(&D)'
            Action = ActionClearRecentlyViewed
          end
          object SpTBXSeparatorItem42: TSpTBXSeparatorItem
          end
          object MenuToolAddReg: TSpTBXItem
            Caption = 'IE'#21491#12463#12522#12483#12463#12513#12491#12517#12540#12395#36861#21152'(&A)'
            Action = ActionAddReg
          end
          object MenuToolDelReg: TSpTBXItem
            Caption = 'IE'#21491#12463#12522#12483#12463#12513#12491#12517#12540#12363#12425#21066#38500'(&B)'
            Action = ActionDelReg
          end
        end
        object MenuHelp: TSpTBXSubmenuItem
          Caption = #12504#12523#12503'(&H)'
          object MenuHelpHelp: TSpTBXItem
            Caption = #12504#12523#12503'(&H)...'
            Hint = #12504#12523#12503
            Action = ActionHelp
          end
          object SpTBXSeparatorItem5: TSpTBXSeparatorItem
          end
          object MenuHelpOpen: TSpTBXSubmenuItem
            Caption = #22806#37096#12502#12521#12454#12470#12391#38283#12367'(&O)'
            object MenuHelpOpenYouTube: TSpTBXItem
              Caption = 'YouTube'#12434#38283#12367'(&Y)...'
              Action = ActionOpenYouTube
            end
            object SpTBXSeparatorItem56: TSpTBXSeparatorItem
            end
            object MenuHelpOpenNicoVideo: TSpTBXItem
              Caption = #12491#12467#12491#12467#21205#30011#12434#38283#12367'(&N)...'
              Action = ActionOpenNicoVideo
            end
            object MenuHelpOpenNicoVideoBlog: TSpTBXItem
              Caption = #12491#12467#12491#12467#21205#30011' '#38283#30330#32773#12502#12525#12464#12434#38283#12367'(&B)...'
              Action = ActionOpenNicoVideoBlog
            end
            object SpTBXSeparatorItem57: TSpTBXSeparatorItem
            end
            object MenuHelpOpenOfficialSite: TSpTBXItem
              Caption = 'TubePlayer'#20844#24335#12469#12452#12488#12434#38283#12367'(&T)...'
              Action = ActionOpenOfficialSite
            end
          end
          object SpTBXSeparatorItem55: TSpTBXSeparatorItem
          end
          object MenuHelpCheckUpdate: TSpTBXItem
            Caption = #12450#12483#12503#12487#12540#12488#12481#12455#12483#12463'(&U)...'
            Action = ActionCheckUpdate
          end
          object SpTBXSeparatorItem6: TSpTBXSeparatorItem
          end
          object MenuHelpBugReport: TSpTBXItem
            Caption = #12496#12464#12524#12509#12540#12488'(&B)...'
            Action = ActionBugReport
          end
          object MenuHelpVersion: TSpTBXItem
            Caption = #12496#12540#12472#12519#12531#24773#22577'(&V)...'
            Action = ActionVersion
          end
        end
      end
      object ToolbarSearchBar: TSpTBXToolbar
        Left = 424
        Top = 22
        AutoResize = False
        DockableTo = [dpTop, dpBottom]
        DockPos = 424
        DockRow = 1
        Images = ImageList
        ParentShowHint = False
        ShowHint = True
        Stretch = True
        TabOrder = 1
        OnVisibleChanged = ToolbarSearchBarVisibleChanged
        Caption = #26908#32034#12496#12540
        object SearchBarToggleSearchTarget: TSpTBXSubmenuItem
          Caption = #26908#32034#20808#20999#26367
          ImageIndex = 13
          Options = [tboDropdownArrow]
          LinkSubitems = MenuSearchToggleSearchTarget
        end
        object TBControlItem1: TTBControlItem
          Control = SearchBarComboBox
        end
        object SearchBarSearch: TSpTBXItem
          Caption = #26908#32034
          Hint = #26908#32034
          Action = ActionSearchBarSearch
        end
        object SearchBarAdd100: TSpTBXItem
          Caption = #36861#21152#26908#32034
          Hint = #36861#21152#26908#32034
          Action = ActionSearchBarAdd100
        end
        object SearchBarToggleListView: TSpTBXItem
          Caption = #34920#31034#20999#26367
          Hint = #34920#31034#20999#26367
          Action = ActionSearchBarToggleListView
        end
        object SearchBarComboBox: TSpTBXComboBox
          Left = 31
          Top = 1
          Width = 153
          Height = 20
          AutoComplete = False
          DropDownCount = 16
          ItemHeight = 12
          TabOrder = 0
          OnChange = SearchComboBoxChange
          OnKeyPress = SearchBarComboBoxKeyPress
        end
      end
      object ToolBarToolBar: TSpTBXToolbar
        Left = 0
        Top = 22
        DockPos = 0
        DockRow = 1
        Images = ImageList
        ParentShowHint = False
        PopupMenu = PopupMenu
        ShowHint = True
        Stretch = True
        TabOrder = 2
        OnVisibleChanged = ToolBarToolBarVisibleChanged
        Caption = #12484#12540#12523#12496#12540
        object ToolButtonSave: TSpTBXItem
          Caption = #12371#12398#12499#12487#12458#12434#20445#23384#12377#12427'...'
          Hint = #12371#12398#12499#12487#12458#12434#20445#23384#12377#12427
          Action = ActionSave
        end
        object ToolButtonOpenNew: TSpTBXItem
          Caption = #26032#12375#12356'URL'#12434#38283#12367'...'
          Hint = #26032#12375#12356'URL'#12434#38283#12367
          Action = ActionOpenNew
        end
        object ToolButtonRefresh: TSpTBXItem
          Caption = #20877#21462#24471
          Action = ActionRefresh
        end
        object ToolButtonClearVideoPanel: TSpTBXItem
          Caption = #12499#12487#12458#12497#12493#12523#12434#31354#12395#12377#12427
          Hint = #12499#12487#12458#12497#12493#12523#12434#31354#12395#12377#12427
          Action = ActionClearVideoPanel
        end
        object ToolButtonOpenByBrowser: TSpTBXItem
          Caption = #22806#37096#12502#12521#12454#12470#12391#38283#12367'...'
          Hint = #22806#37096#12502#12521#12454#12470#12391#38283#12367
          Action = ActionOpenByBrowser
        end
        object ToolButtonStayOnTop: TSpTBXItem
          Caption = #26368#21069#38754
          Hint = #26368#21069#38754
          Action = ActionStayOnTop
        end
        object ToolButtonToggleFavoritePanel: TSpTBXItem
          Caption = #12362#27671#12395#20837#12426
          Action = ActionToggleFavoritePanel
        end
        object ToolButtonVideoInfoPanel: TSpTBXItem
          Caption = #12499#12487#12458#24773#22577#12497#12493#12523
          Hint = #12499#12487#12458#24773#22577#12497#12493#12523
          Action = ActionToggleVideoInfoPanel
        end
        object ToolButtonVideoRelatedPanel: TSpTBXItem
          Caption = #38306#36899#12499#12487#12458#12497#12493#12523
          Hint = #38306#36899#12499#12487#12458#12497#12493#12523
          Action = ActionToggleVideoRelatedPanel
        end
        object ToolButtonToggleSearchPanel: TSpTBXItem
          Caption = #26908#32034#12497#12493#12523
          Hint = #26908#32034#12497#12493#12523
          Action = ActionToggleSearchPanel
        end
        object ToolButtonToggleWindowSize: TSpTBXItem
          Caption = #12454#12451#12531#12489#12454#12469#12452#12474#20999#26367
          Hint = #12454#12451#12531#12489#12454#12469#12452#12474#20999#26367
          Action = ActionToggleWindowSize
        end
        object ToolButtonAddFavorite: TSpTBXSubmenuItem
          Caption = #12362#27671#12395#20837#12426#12395#36861#21152
          ImageIndex = 16
          OnPopup = ToolButtonAddFavoritePopup
        end
        object ToolButtonSetting: TSpTBXItem
          Caption = #35373#23450'...'
          Hint = #35373#23450
          Action = ActionSetting
        end
        object ToolButtonHelp: TSpTBXItem
          Caption = #12504#12523#12503'...'
          Hint = #12504#12523#12503
          Action = ActionHelp
        end
      end
      object SpTBXDockablePanelSearch: TSpTBXDockablePanel
        Left = 0
        Top = 48
        Caption = #26908#32034
        DockedHeight = 105
        DockPos = 0
        DockRow = 3
        TabOrder = 3
        OnCloseQuery = SpTBXDockablePanelSearchCloseQuery
        Images = ImageList
        object DockablePanelSearchMenu: TSpTBXSubmenuItem
          Options = [tboDropdownArrow]
          LinkSubitems = PanelSearchMenu
        end
        object PanelBrowser: TPanel
          Left = 0
          Top = 32
          Width = 747
          Height = 73
          Align = alClient
          BevelOuter = bvNone
          Ctl3D = False
          ParentBackground = False
          ParentCtl3D = False
          TabOrder = 1
          Visible = False
        end
        object PanelListView: TPanel
          Left = 0
          Top = 32
          Width = 747
          Height = 73
          Align = alClient
          BevelOuter = bvNone
          Ctl3D = False
          ParentBackground = False
          ParentCtl3D = False
          TabOrder = 2
          object ListView: THogeListView
            Left = 0
            Top = 0
            Width = 747
            Height = 73
            Align = alClient
            BevelInner = bvLowered
            BevelOuter = bvNone
            Columns = <
              item
                Caption = #30058#21495
                Tag = 1
                Width = 40
              end
              item
                Caption = #12479#12452#12488#12523
                Tag = 2
                Width = 210
              end
              item
                Alignment = taRightJustify
                Caption = #20877#29983#26178#38291
                Tag = 3
                Width = 65
              end
              item
                Alignment = taRightJustify
                Caption = #35413#20385#24179#22343
                Tag = 4
                Width = 65
              end
              item
                Alignment = taRightJustify
                Caption = #35413#20385#25968
                Tag = 5
                Width = 55
              end
              item
                Alignment = taRightJustify
                Caption = #35222#32884#22238#25968
                Tag = 6
                Width = 65
              end
              item
                Caption = #21218#12356
                Tag = 7
                Width = 55
              end
              item
                Caption = #12518#12540#12470#12540#21517
                Tag = 8
                Width = 80
              end
              item
                Caption = #36861#21152#26178#38291
                Tag = 9
                Width = 140
              end
              item
                Caption = 'VideoID'
                Tag = 10
                Width = 80
              end>
            HideSelection = False
            HotTrackStyles = [htHandPoint, htUnderlineHot]
            MultiSelect = True
            ReadOnly = True
            RowSelect = True
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            TabStop = False
            ViewStyle = vsReport
            OnClick = ListViewClick
            OnColumnClick = ListViewColumnClick
            OnCustomDrawItem = ListViewCustomDrawItem
            OnData = ListViewData
            OnDblClick = ListViewDblClick
            OnKeyDown = ListViewKeyDown
            OnMouseDown = ListViewMouseDown
            OnSelectItem = ListViewSelectItem
          end
        end
        object PanelSearchToolbar: TSpTBXToolbar
          Left = 0
          Top = 10
          Width = 747
          Height = 22
          Align = alTop
          AutoResize = False
          DockableTo = []
          DockMode = dmCannotFloat
          Images = ImageList
          ShrinkMode = tbsmNone
          Stretch = True
          TabOrder = 3
          Color = clBtnFace
          Caption = 'PanelSearchToolbar'
          Customizable = False
          DesignSize = (
            747
            22)
          object PanelSearchMenu: TSpTBXSubmenuItem
            Options = [tboDropdownArrow]
            object PanelSearchYouTube: TSpTBXSubmenuItem
              Caption = 'YouTube(&Y)'
              ImageIndex = 13
              LinkSubitems = MenuSearchYouTube
            end
            object PanelSearchNicoVideo: TSpTBXSubmenuItem
              Caption = #12491#12467#12491#12467#21205#30011'(&N)'
              ImageIndex = 14
              LinkSubitems = MenuSearchNicoVideo
            end
          end
          object PanelSearchLabel: TSpTBXLabelItem
            Caption = #26908#32034':'
          end
          object PanelSearchToggleSearchTarget: TSpTBXSubmenuItem
            Caption = #26908#32034#20808#20999#26367
            ImageIndex = 13
            Options = [tboDropdownArrow]
            LinkSubitems = MenuSearchToggleSearchTarget
          end
          object TBControlItem2: TTBControlItem
            Control = PanelSearchComboBox
          end
          object PanelSearchSearch: TSpTBXItem
            Caption = #26908#32034
            Hint = #26908#32034
            Action = ActionSearchBarSearch2
          end
          object PanelSearchAdd100: TSpTBXItem
            Caption = #36861#21152#26908#32034
            Hint = #36861#21152#26908#32034
            Action = ActionSearchBarAdd100
          end
          object PanelSearchToggleListView: TSpTBXItem
            Caption = #34920#31034#20999#26367
            Hint = #34920#31034#20999#26367
            Action = ActionSearchBarToggleListView
          end
          object PanelSearchComboBox: TSpTBXComboBox
            Left = 81
            Top = 1
            Width = 241
            Height = 20
            AutoComplete = False
            Anchors = [akLeft, akTop, akRight]
            DropDownCount = 16
            ItemHeight = 12
            TabOrder = 0
            OnChange = SearchComboBoxChange
            OnKeyPress = PanelSearchComboBoxKeyPress
          end
        end
      end
    end
    object Panel: TSpTBXPanel
      Left = 146
      Top = 157
      Width = 327
      Height = 372
      Align = alClient
      TabOrder = 5
      OnResize = PanelResize
      Borders = False
      object LabelWSH: TSpTBXLabel
        Left = 16
        Top = 16
        Width = 373
        Height = 12
        Caption = 'LabelWSH'
        Visible = False
        Wrapping = twWrap
        LinkFont.Charset = SHIFTJIS_CHARSET
        LinkFont.Color = clBlue
        LinkFont.Height = -12
        LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
        LinkFont.Style = [fsUnderline]
      end
      object LabelWSH2: TSpTBXLabel
        Left = 16
        Top = 80
        Width = 373
        Height = 12
        Cursor = crHandPoint
        Caption = 'LabelWSH2'
        Font.Charset = SHIFTJIS_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = [fsUnderline]
        ParentFont = False
        Visible = False
        Wrapping = twWrap
        OnClick = LabelWSH2Click
        LinkFont.Charset = SHIFTJIS_CHARSET
        LinkFont.Color = clBlue
        LinkFont.Height = -12
        LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
        LinkFont.Style = [fsUnderline]
      end
      object LabelFlash: TSpTBXLabel
        Left = 16
        Top = 120
        Width = 373
        Height = 12
        Caption = 'LabelFlash'
        Visible = False
        Wrapping = twWrap
        LinkFont.Charset = SHIFTJIS_CHARSET
        LinkFont.Color = clBlue
        LinkFont.Height = -12
        LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
        LinkFont.Style = [fsUnderline]
      end
      object LabelFlash2: TSpTBXLabel
        Left = 16
        Top = 160
        Width = 373
        Height = 12
        Cursor = crHandPoint
        Caption = 'LabelFlash2'
        Font.Charset = SHIFTJIS_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = [fsUnderline]
        ParentFont = False
        Visible = False
        Wrapping = twWrap
        OnClick = LabelFlash2Click
        LinkFont.Charset = SHIFTJIS_CHARSET
        LinkFont.Color = clBlue
        LinkFont.Height = -12
        LinkFont.Name = #65325#65331' '#65328#12468#12471#12483#12463
        LinkFont.Style = [fsUnderline]
      end
      object CheckBoxThrough: TSpTBXCheckBox
        Left = 16
        Top = 200
        Width = 340
        Height = 15
        Caption = #27425#22238#36215#21205#26178#12363#12425'FLASH'#12392'WSH'#12398#12496#12540#12472#12519#12531#12481#12455#12483#12463#12434#12473#12523#12540#12377#12427
        TabOrder = 0
        Visible = False
        OnClick = CheckBoxThroughClick
      end
    end
  end
  object RegExp: TRegExp
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 62
    Top = 176
  end
  object TrayIcon: TJLTrayIcon
    Visible = False
    PopupMenu = PopupTaskTray
    OnMouseUp = TrayIconMouseUp
    Left = 62
    Top = 144
  end
  object ApplicationEvents: TApplicationEvents
    OnActivate = ApplicationEventsActivate
    OnDeactivate = ApplicationEventsDeactivate
    OnMessage = ApplicationEventsMessage
    OnMinimize = ApplicationEventsMinimize
    Left = 62
    Top = 112
  end
  object FileVerInfo: TFileVerInfo
    Left = 62
    Top = 208
  end
  object TimerSetSetBounds: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = TimerSetSetBoundsTimer
    Left = 24
    Top = 240
  end
  object TimerAutoClose: TTimer
    Enabled = False
    OnTimer = TimerAutoCloseTimer
    Left = 24
    Top = 208
  end
  object PopupTaskTray: TSpTBXPopupMenu
    Left = 688
    Top = 569
    object PopupTaskTrayRestore: TSpTBXItem
      Caption = #20803#12398#12469#12452#12474#12395#25147#12377'(&R)'
      Action = ActionTaskTrayRestore
    end
    object SpTBXSeparatorItem8: TSpTBXSeparatorItem
    end
    object PopupTaskTrayClose: TSpTBXItem
      Caption = #12450#12503#12522#12465#12540#12471#12519#12531#12398#32066#20102'(&X)'
      Action = ActionTaskTrayClose
    end
  end
  object PopupMenu: TSpTBXPopupMenu
    Images = ImageList
    OnPopup = PopupMenuPopup
    Left = 216
    Top = 273
    object PopupMenuCopyTitle: TSpTBXItem
      Caption = #12479#12452#12488#12523#12434#12467#12500#12540'(&0)'
      Action = ActionCopyTitle
    end
    object PopupMenuCopyURL: TSpTBXItem
      Caption = 'URL'#12434#12467#12500#12540'(&1)'
      Action = ActionCopyURL
    end
    object PopupMenuCopyTU: TSpTBXItem
      Caption = #12479#12452#12488#12523#12392'URL'#12434#12467#12500#12540'(&2)'
      Action = ActionCopyTU
    end
    object SpTBXSeparatorItem24: TSpTBXSeparatorItem
    end
    object PopupMenuAddTag: TSpTBXItem
      Caption = #12479#12464#12434#26908#32034#12496#12540#12395#36861#21152#12377#12427'(&A)'
      Action = ActionAddTag
    end
    object PopupMenuAddAuthor: TSpTBXItem
      Caption = #12518#12540#12470#12540#21517#12434#26908#32034#12496#12540#12395#36861#21152#12377#12427'(&U)'
      Action = ActionAddAuthor
    end
    object SpTBXSeparatorItem9: TSpTBXSeparatorItem
    end
    object PopupMenuAddFavorite: TSpTBXSubmenuItem
      Caption = #12362#27671#12395#20837#12426#12395#36861#21152'(&F)'
      ImageIndex = 16
    end
    object SpTBXSeparatorItem51: TSpTBXSeparatorItem
    end
    object PopupMenuView: TSpTBXSubmenuItem
      Caption = #34920#31034'(&H)'
      object PopupMenuViewToolBarFixed: TSpTBXItem
        Caption = #12484#12540#12523#12496#12540#12434#22266#23450#12377#12427'(&F)'
        Action = ActionToolBarFixed
      end
      object SpTBXSeparatorItem21: TSpTBXSeparatorItem
      end
      object PopupMenuViewToolBar: TSpTBXSubmenuItem
        Caption = #12484#12540#12523#12496#12540'(&T)'
        object PopupMenuViewToolBarToggleMenuBar: TSpTBXItem
          Caption = #12513#12491#12517#12540#12496#12540'(&M)'
          Action = ActionToggleMenuBar
        end
        object PopupMenuViewToolBarToggleToolBar: TSpTBXItem
          Caption = #12484#12540#12523#12496#12540'(&T)'
          Action = ActionToggleToolBar
        end
        object PopupMenuViewToolBarToggleSearchBar: TSpTBXItem
          Caption = #26908#32034#12496#12540'(&S)'
          Action = ActionToggleSearchBar
        end
        object PopupMenuViewToolBarToggleTitleBar: TSpTBXItem
          Caption = #12499#12487#12458#12479#12452#12488#12523#12496#12540'(&V)'
          Action = ActionToggleTitleBar
        end
      end
      object PopupMenuViewToggleLogPanel: TSpTBXItem
        Caption = #12525#12464#12497#12493#12523'(&L)'
        Action = ActionToggleLogPanel
      end
      object PopupMenuViewToggleFavoritePanel: TSpTBXItem
        Caption = #12362#27671#12395#20837#12426#12497#12493#12523'(&X)'
        Action = ActionToggleFavoritePanel
      end
      object PopupMenuViewToggleVideoInfoPanel: TSpTBXItem
        Caption = #12499#12487#12458#24773#22577#12497#12493#12523'(&V)'
        Hint = #12499#12487#12458#24773#22577#12497#12493#12523
        Action = ActionToggleVideoInfoPanel
      end
      object PopupMenuViewToggleVideoRelatedPanel: TSpTBXItem
        Caption = #38306#36899#12499#12487#12458#12497#12493#12523'(&R)'
        Hint = #38306#36899#12499#12487#12458#12497#12493#12523
        Action = ActionToggleVideoRelatedPanel
      end
      object PopupMenuViewToggleSearchPanel: TSpTBXItem
        Caption = #26908#32034#12497#12493#12523'(&Z)'
        Hint = #26908#32034#12497#12493#12523
        Action = ActionToggleSearchPanel
      end
      object PopupMenuViewTogglePanelSearchToolBar: TSpTBXItem
        Caption = #26908#32034#12496#12540'('#26908#32034#12497#12493#12523')(&B)'
        Action = ActionTogglePanelSearchToolBar
      end
      object PopupMenuViewSplitter: TSpTBXItem
        Caption = #12473#12503#12522#12483#12479#12540'(&S)'
        Action = ActionToggleSplitter
      end
      object SpTBXSeparatorItem20: TSpTBXSeparatorItem
      end
      object PopupMenuViewTheme: TSpTBXSubmenuItem
        Caption = #12486#12540#12510#22793#26356'(&E)'
        object SpTBXSkinGroupItem2: TSpTBXSkinGroupItem
        end
      end
    end
    object SpTBXSeparatorItem11: TSpTBXSeparatorItem
    end
    object PopupMenuChangeVideoScale: TSpTBXItem
      Caption = #12499#12487#12458#12473#12465#12540#12523#12434#22793#26356#12377#12427'(&C)'
      Action = ActionChangeVideoScale
    end
    object PopupMenuToggleWindowSize: TSpTBXItem
      Caption = #12454#12451#12531#12489#12454#12469#12452#12474#20999#26367'(&T)'
      Hint = #12454#12451#12531#12489#12454#12469#12452#12474#20999#26367
      Action = ActionToggleWindowSize
    end
    object SpTBXSeparatorItem10: TSpTBXSeparatorItem
    end
    object PopupMenuSave: TSpTBXItem
      Caption = #12371#12398#12499#12487#12458#12434#20445#23384#12377#12427'(&S)...'
      Hint = #12371#12398#12499#12487#12458#12434#20445#23384#12377#12427
      Action = ActionSave
    end
    object PopupMenuOpenNew: TSpTBXItem
      Caption = #26032#12375#12356'URL'#12434#38283#12367'(&N)...'
      Hint = #26032#12375#12356'URL'#12434#38283#12367
      Action = ActionOpenNew
    end
    object PopupMenuRefresh: TSpTBXItem
      Caption = #20877#21462#24471'(&B)'
      Action = ActionRefresh
    end
    object PopupMenuClearVideoPanel: TSpTBXItem
      Caption = #12499#12487#12458#12497#12493#12523#12434#31354#12395#12377#12427'(&D)'
      Hint = #12499#12487#12458#12497#12493#12523#12434#31354#12395#12377#12427
      Action = ActionClearVideoPanel
    end
    object PopupMenuOpenByBrowser: TSpTBXItem
      Caption = #22806#37096#12502#12521#12454#12470#12391#38283#12367'(&O)...'
      Hint = #22806#37096#12502#12521#12454#12470#12391#38283#12367
      Action = ActionOpenByBrowser
    end
    object PopupMenuStayOnTop: TSpTBXItem
      Caption = #26368#21069#38754'(&M)'
      Hint = #26368#21069#38754
      Action = ActionStayOnTop
    end
    object PopupMenuToggleVideoInfoPanel: TSpTBXItem
      Caption = #12499#12487#12458#24773#22577#12497#12493#12523'(&V)'
      Hint = #12499#12487#12458#24773#22577#12497#12493#12523
      Action = ActionToggleVideoInfoPanel
    end
    object PopupMenuToggleVideoRelatedPanel: TSpTBXItem
      Caption = #38306#36899#12499#12487#12458#12497#12493#12523'(&R)'
      Hint = #38306#36899#12499#12487#12458#12497#12493#12523
      Action = ActionToggleVideoRelatedPanel
    end
    object PopupMenuToggleSearchPanel: TSpTBXItem
      Caption = #26908#32034#12497#12493#12523'(&P)'
      Hint = #26908#32034#12497#12493#12523
      Action = ActionToggleSearchPanel
    end
    object PopupMenuSetting: TSpTBXItem
      Caption = #35373#23450'(&Z)...'
      Hint = #35373#23450
      Action = ActionSetting
    end
    object PopupMenuHelp: TSpTBXItem
      Caption = #12504#12523#12503'(&H)...'
      Hint = #12504#12523#12503
      Action = ActionHelp
    end
    object SpTBXSeparatorItem14: TSpTBXSeparatorItem
    end
    object PopupMenuExit: TSpTBXItem
      Caption = #32066#20102'(&X)'
      Action = ActionExit
    end
  end
  object ActionList: TTntActionList
    Images = ImageList
    Left = 24
    Top = 134
    object ActionListPopupCopyTitle: TTntAction
      Category = 'ListPopup'
      Caption = #12479#12452#12488#12523#12434#12467#12500#12540'(&0)'
      OnExecute = ActionListPopupCopyTitleExecute
    end
    object ActionExit: TTntAction
      Category = #12501#12449#12452#12523
      Caption = #32066#20102'(&X)'
      OnExecute = ActionExitExecute
    end
    object ActionOpenByBrowser: TTntAction
      Category = #12501#12449#12452#12523
      Caption = #22806#37096#12502#12521#12454#12470#12391#38283#12367'(&O)...'
      Hint = #22806#37096#12502#12521#12454#12470#12391#38283#12367
      ImageIndex = 2
      OnExecute = ActionOpenByBrowserExecute
    end
    object ActionOpenNew: TTntAction
      Category = #12501#12449#12452#12523
      Caption = #26032#12375#12356'URL'#12434#38283#12367'(&N)...'
      Hint = #26032#12375#12356'URL'#12434#38283#12367
      ImageIndex = 1
      OnExecute = ActionOpenNewExecute
    end
    object ActionSave: TTntAction
      Category = #12501#12449#12452#12523
      Caption = #12371#12398#12499#12487#12458#12434#20445#23384#12377#12427'(&S)...'
      Hint = #12371#12398#12499#12487#12458#12434#20445#23384#12377#12427
      ImageIndex = 0
      OnExecute = ActionSaveExecute
    end
    object ActionCopyTitle: TTntAction
      Category = #12501#12449#12452#12523
      Caption = #12479#12452#12488#12523#12434#12467#12500#12540'(&0)'
      OnExecute = ActionCopyTitleExecute
    end
    object ActionCopyURL: TTntAction
      Category = #12501#12449#12452#12523
      Caption = 'URL'#12434#12467#12500#12540'(&1)'
      OnExecute = ActionCopyURLExecute
    end
    object ActionCopyTU: TTntAction
      Category = #12501#12449#12452#12523
      Caption = #12479#12452#12488#12523#12392'URL'#12434#12467#12500#12540'(&2)'
      OnExecute = ActionCopyTUExecute
    end
    object ActionBugReport: TTntAction
      Category = #12504#12523#12503
      Caption = #12496#12464#12524#12509#12540#12488'(&B)...'
      OnExecute = ActionBugReportExecute
    end
    object ActionCheckUpdate: TTntAction
      Category = #12504#12523#12503
      Caption = #12450#12483#12503#12487#12540#12488#12481#12455#12483#12463'(&U)...'
      OnExecute = ActionCheckUpdateExecute
    end
    object ActionHelp: TTntAction
      Category = #12504#12523#12503
      Caption = #12504#12523#12503'(&H)...'
      Hint = #12504#12523#12503
      ImageIndex = 5
      OnExecute = ActionHelpExecute
    end
    object ActionVersion: TTntAction
      Category = #12504#12523#12503
      Caption = #12496#12540#12472#12519#12531#24773#22577'(&V)...'
      OnExecute = ActionVersionExecute
    end
    object ActionSetting: TTntAction
      Category = #12484#12540#12523
      Caption = #35373#23450'(&Z)...'
      Hint = #35373#23450
      ImageIndex = 4
      OnExecute = ActionSettingExecute
    end
    object ActionDefaultWindowSize: TTntAction
      Category = #34920#31034
      Caption = #12454#12451#12531#12489#12454#12469#12452#12474#12434#35215#23450#20516#12395#25147#12377'(&W)'
      OnExecute = ActionDefaultWindowSizeExecute
    end
    object ActionStayOnTop: TTntAction
      Category = #34920#31034
      Caption = #26368#21069#38754'(&T)'
      Hint = #26368#21069#38754
      ImageIndex = 3
      OnExecute = ActionStayOnTopExecute
    end
    object ActionCustomize: TTntAction
      Category = #12484#12540#12523
      Caption = #12459#12473#12479#12510#12452#12474'(&C)...'
      OnExecute = ActionCustomizeExecute
    end
    object ActionToggleMenuBar: TTntAction
      Category = #34920#31034
      Caption = #12513#12491#12517#12540#12496#12540'(&M)'
      OnExecute = ActionToggleMenuBarExecute
    end
    object ActionToggleToolBar: TTntAction
      Category = #34920#31034
      Caption = #12484#12540#12523#12496#12540'(&T)'
      OnExecute = ActionToggleToolBarExecute
    end
    object ActionToggleTitleBar: TTntAction
      Category = #34920#31034
      Caption = #12499#12487#12458#12479#12452#12488#12523#12496#12540'(&V)'
      OnExecute = ActionToggleTitleBarExecute
    end
    object ActionToolBarFixed: TTntAction
      Category = #34920#31034
      Caption = #12484#12540#12523#12496#12540#12434#22266#23450#12377#12427'(&F)'
      OnExecute = ActionToolBarFixedExecute
    end
    object ActionToggleLogPanel: TTntAction
      Category = #34920#31034
      Caption = #12525#12464#12497#12493#12523'(&L)'
      OnExecute = ActionToggleLogPanelExecute
    end
    object ActionToggleVideoInfoPanel: TTntAction
      Category = #34920#31034
      Caption = #12499#12487#12458#24773#22577#12497#12493#12523'(&V)'
      Hint = #12499#12487#12458#24773#22577#12497#12493#12523
      ImageIndex = 6
      OnExecute = ActionToggleVideoInfoPanelExecute
    end
    object ActionToggleSplitter: TTntAction
      Category = #34920#31034
      Caption = #12473#12503#12522#12483#12479#12540'(&S)'
      OnExecute = ActionToggleSplitterExecute
    end
    object ActionToggleVideoRelatedPanel: TTntAction
      Category = #34920#31034
      Caption = #38306#36899#12499#12487#12458#12497#12493#12523'(&R)'
      Hint = #38306#36899#12499#12487#12458#12497#12493#12523
      ImageIndex = 7
      OnExecute = ActionToggleVideoRelatedPanelExecute
    end
    object ActionToggleSearchPanel: TTntAction
      Category = #34920#31034
      Caption = #26908#32034#12497#12493#12523'(&Z)'
      Hint = #26908#32034#12497#12493#12523
      ImageIndex = 11
      OnExecute = ActionToggleSearchPanelExecute
    end
    object ActionListPopupCopyURL: TTntAction
      Category = 'ListPopup'
      Caption = 'URL'#12434#12467#12500#12540'(&1)'
      OnExecute = ActionListPopupCopyURLExecute
    end
    object ActionListPopupCopyTU: TTntAction
      Category = 'ListPopup'
      Caption = #12479#12452#12488#12523#12392'URL'#12434#12467#12500#12540'(&2)'
      OnExecute = ActionListPopupCopyTUExecute
    end
    object ActionTaskTrayClose: TTntAction
      Category = 'TaskTray'
      Caption = #12450#12503#12522#12465#12540#12471#12519#12531#12398#32066#20102'(&X)'
      OnExecute = ActionTaskTrayCloseExecute
    end
    object ActionTaskTrayRestore: TTntAction
      Category = 'TaskTray'
      Caption = #20803#12398#12469#12452#12474#12395#25147#12377'(&R)'
      OnExecute = ActionTaskTrayRestoreExecute
    end
    object ActionListOpenURL: TTntAction
      Category = 'ListPopup'
      Caption = #12371#12398#12499#12487#12458#12434#38283#12367'(&V)'
      OnExecute = ActionListOpenURLExecute
    end
    object ActionSearchBarSearch: TTntAction
      Category = #26908#32034
      Caption = #26908#32034
      Hint = #26908#32034
      ImageIndex = 8
      OnExecute = ActionSearchBarSearchExecute
    end
    object ActionSearchBarAdd100: TTntAction
      Category = #26908#32034
      Caption = #36861#21152#26908#32034
      Enabled = False
      Hint = #36861#21152#26908#32034
      ImageIndex = 9
      OnExecute = ActionSearchBarAdd100Execute
    end
    object ActionToggleSearchBar: TTntAction
      Category = #34920#31034
      Caption = #26908#32034#12496#12540'(&S)'
      OnExecute = ActionToggleSearchBarExecute
    end
    object ActionAddTag: TTntAction
      Category = #12501#12449#12452#12523
      Caption = #12479#12464#12434#26908#32034#12496#12540#12395#36861#21152#12377#12427'(&A)'
      OnExecute = ActionAddTagExecute
    end
    object ActionListAddTag: TTntAction
      Category = 'ListPopup'
      Caption = #12371#12398#12499#12487#12458#12398#12479#12464#12434#26908#32034#12496#12540#12395#36861#21152'(&A)'
      OnExecute = ActionListAddTagExecute
    end
    object ActionClearSearchHistory: TTntAction
      Category = #26908#32034
      Caption = #26908#32034#23653#27508#21066#38500'(&D)...'
      OnExecute = ActionClearSearchHistoryExecute
    end
    object ActionSearchBarToggleListView: TTntAction
      Category = #26908#32034
      Caption = #34920#31034#20999#26367
      Enabled = False
      Hint = #34920#31034#20999#26367
      ImageIndex = 7
      OnExecute = ActionSearchBarToggleListViewExecute
    end
    object ActionSearchBarSearch2: TTntAction
      Category = #26908#32034
      Caption = #26908#32034
      Hint = #26908#32034
      ImageIndex = 8
      OnExecute = ActionSearchBarSearch2Execute
    end
    object ActionTogglePanelSearchToolBar: TTntAction
      Category = #34920#31034
      Caption = #26908#32034#12496#12540'('#26908#32034#12497#12493#12523')(&B)'
      OnExecute = ActionTogglePanelSearchToolBarExecute
    end
    object ActionClearVideoPanel: TTntAction
      Category = #12501#12449#12452#12523
      Caption = #12499#12487#12458#12497#12493#12523#12434#31354#12395#12377#12427'(&C)'
      Hint = #12499#12487#12458#12497#12493#12523#12434#31354#12395#12377#12427
      ImageIndex = 10
      OnExecute = ActionClearVideoPanelExecute
    end
    object ActionAddAuthor: TTntAction
      Category = #12501#12449#12452#12523
      Caption = #12518#12540#12470#12540#21517#12434#26908#32034#12496#12540#12395#36861#21152#12377#12427'(&B)'
      OnExecute = ActionAddAuthorExecute
    end
    object ActionListAddAuthor: TTntAction
      Category = 'ListPopup'
      Caption = #12371#12398#12499#12487#12458#12398#12518#12540#12470#12540#12434#26908#32034#12496#12540#12395#36861#21152'(&B)'
      OnExecute = ActionListAddAuthorExecute
    end
    object ActionOpenPrimarySite: TTntAction
      Category = #12501#12449#12452#12523
      Caption = #20803#12493#12479#21205#30011#12434#38283#12367'(&P)'
      OnExecute = ActionOpenPrimarySiteExecute
    end
    object ActionUserWindowSize: TTntAction
      Category = #34920#31034
      Caption = #12454#12451#12531#12489#12454#12469#12452#12474#12434#12518#12540#12470#12540#35215#23450#20516#12395#12377#12427'(&U)'
      Hint = #12454#12451#12531#12489#12454#12469#12452#12474#12434#12518#12540#12470#12540#35215#23450#20516#12395#12377#12427
      ImageIndex = 12
      OnExecute = ActionUserWindowSizeExecute
    end
    object ActionAddReg: TTntAction
      Category = #12484#12540#12523
      Caption = 'IE'#21491#12463#12522#12483#12463#12513#12491#12517#12540#12395#36861#21152'(&A)'
      OnExecute = ActionAddRegExecute
    end
    object ActionDelReg: TTntAction
      Category = #12484#12540#12523
      Caption = 'IE'#21491#12463#12522#12483#12463#12513#12491#12517#12540#12363#12425#21066#38500'(&B)'
      OnExecute = ActionDelRegExecute
    end
    object ActionToggleWindowSize: TTntAction
      Category = #34920#31034
      Caption = #12454#12451#12531#12489#12454#12469#12452#12474#20999#26367'(&T)'
      Hint = #12454#12451#12531#12489#12454#12469#12452#12474#20999#26367
      ImageIndex = 12
      OnExecute = ActionToggleWindowSizeExecute
    end
    object ActionPlayDARAO: TTntAction
      Category = #12501#12449#12452#12523
      Caption = 'DARAO'#12434#35222#32884#12377#12427'(&Z)'
      OnExecute = ActionPlayDARAOExecute
    end
    object ActionToggleSearchTarget: TTntAction
      Category = #26908#32034
      Caption = #26908#32034#20999#26367'(&T)'
      OnExecute = ActionToggleSearchTargetExecute
    end
    object ActionChangeVideoScale: TTntAction
      Category = #34920#31034
      Caption = #12499#12487#12458#12473#12465#12540#12523#12434#22793#26356#12377#12427'(&C)'
      ImageIndex = 14
      OnExecute = ActionChangeVideoScaleExecute
    end
    object ActionRefresh: TTntAction
      Category = #12501#12449#12452#12523
      Caption = #20877#21462#24471'(&U)'
      ImageIndex = 18
      OnExecute = ActionRefreshExecute
    end
    object ActionClearRecentlyViewed: TTntAction
      Category = #12484#12540#12523
      Caption = #26368#36817#35222#32884#12375#12383#21205#30011#12434#21066#38500'(&D)...'
      OnExecute = ActionClearRecentlyViewedExecute
    end
    object ActionLogOutFromYouTube: TTntAction
      Category = #12501#12449#12452#12523
      Caption = 'YouTube'#12363#12425#12525#12464#12450#12454#12488'(&Y)'
      ImageIndex = 13
      OnExecute = ActionLogOutFromYouTubeExecute
    end
    object ActionLogOutNicoVideo: TTntAction
      Category = #12501#12449#12452#12523
      Caption = #12491#12467#12491#12467#21205#30011#12363#12425#12525#12464#12450#12454#12488'(&N)'
      ImageIndex = 14
      OnExecute = ActionLogOutNicoVideoExecute
    end
    object ActionToggleFavoritePanel: TTntAction
      Category = #34920#31034
      Caption = #12362#27671#12395#20837#12426#12497#12493#12523'(&X)'
      ImageIndex = 15
      OnExecute = ActionToggleFavoritePanelExecute
    end
    object ActionFavoritePopupOpen: TTntAction
      Category = 'FavoriteList'
      Caption = #12371#12398#12499#12487#12458#12434#38283#12367'(&V)'
      OnExecute = ActionFavoritePopupOpenExecute
    end
    object ActionFavoritePopupOpenByBrowser: TTntAction
      Category = 'FavoriteList'
      Caption = #22806#37096#12502#12521#12454#12470#12391#38283#12367'(&O)...'
      OnExecute = ActionFavoritePopupOpenByBrowserExecute
    end
    object ActionFavoritePopupCopyTitle: TTntAction
      Category = 'FavoriteList'
      Caption = #12479#12452#12488#12523#12434#12467#12500#12540'(&0)'
      OnExecute = ActionFavoritePopupCopyTitleExecute
    end
    object ActionFavoritePopupCopyURL: TTntAction
      Category = 'FavoriteList'
      Caption = 'URL'#12434#12467#12500#12540'(&1)'
      OnExecute = ActionFavoritePopupCopyURLExecute
    end
    object ActionFavoritePopupCopyTU: TTntAction
      Category = 'FavoriteList'
      Caption = #12479#12452#12488#12523#12392'URL'#12434#12467#12500#12540'(&2)'
      OnExecute = ActionFavoritePopupCopyTUExecute
    end
    object ActionFavoritePopupNew: TTntAction
      Category = 'FavoriteList'
      Caption = #26032#35215#12501#12457#12523#12480'(&N)'
      OnExecute = ActionFavoritePopupNewExecute
    end
    object ActionFavoritePopupEdit: TTntAction
      Category = 'FavoriteList'
      Caption = #21517#21069#12398#22793#26356'(&E)'
      OnExecute = ActionFavoritePopupEditExecute
    end
    object ActionFavoritePopupDelete: TTntAction
      Category = 'FavoriteList'
      Caption = #21066#38500'(&D)'
      OnExecute = ActionFavoritePopupDeleteExecute
    end
    object ActionAddFavorite: TTntAction
      Category = #12362#27671#12395#20837#12426
      Caption = #12362#27671#12395#20837#12426#12395#36861#21152'(&A)'
      ImageIndex = 16
      OnExecute = ActionAddFavoriteExecute
    end
    object ActionListOpenByBrowser: TTntAction
      Category = 'ListPopup'
      Caption = #22806#37096#12502#12521#12454#12470#12391#38283#12367'(&O)...'
      ImageIndex = 2
      OnExecute = ActionListOpenByBrowserExecute
    end
    object ActionListPopupSave: TTntAction
      Category = 'ListPopup'
      Caption = #12371#12398#12499#12487#12458#12434#20445#23384#12377#12427'(&S)...'
      ImageIndex = 0
      OnExecute = ActionListPopupSaveExecute
    end
    object ActionOpenYouTube: TTntAction
      Category = #12504#12523#12503
      Caption = 'YouTube'#12434#38283#12367'(&Y)...'
      ImageIndex = 13
      OnExecute = ActionOpenYouTubeExecute
    end
    object ActionOpenNicoVideo: TTntAction
      Category = #12504#12523#12503
      Caption = #12491#12467#12491#12467#21205#30011#12434#38283#12367'(&N)...'
      ImageIndex = 14
      OnExecute = ActionOpenNicoVideoExecute
    end
    object ActionOpenNicoVideoBlog: TTntAction
      Category = #12504#12523#12503
      Caption = #12491#12467#12491#12467#21205#30011' '#38283#30330#32773#12502#12525#12464#12434#38283#12367'(&B)...'
      ImageIndex = 14
      OnExecute = ActionOpenNicoVideoBlogExecute
    end
    object ActionOpenOfficialSite: TTntAction
      Category = #12504#12523#12503
      Caption = 'TubePlayer'#20844#24335#12469#12452#12488#12434#38283#12367'(&T)...'
      OnExecute = ActionOpenOfficialSiteExecute
    end
    object ActionMinimize: TTntAction
      Category = #34920#31034
      Caption = #26368#23567#21270'(&Y)'
      OnExecute = ActionMinimizeExecute
    end
    object ActionHideInTaskTray: TTntAction
      Category = #34920#31034
      Caption = #12479#12473#12463#12488#12524#12452#12395#26684#32013'(&Z)'
      OnExecute = ActionHideInTaskTrayExecute
    end
    object ActionOpenNicoIchiba: TTntAction
      Category = #12501#12449#12452#12523
      Caption = #12491#12467#12491#12467#24066#22580#12521#12531#12461#12531#12464#12434#38283#12367'(&I)'
      OnExecute = ActionOpenNicoIchibaExecute
    end
    object ActionFavoritePopupAddMylist: TTntAction
      Category = 'FavoriteList'
      Caption = #12510#12452#12522#12473#12488#12434#12362#27671#12395#20837#12426#12395#36861#21152'(&M)'
      OnExecute = ActionFavoritePopupAddMylistExecute
    end
  end
  object SpTBXCustomizer: TSpTBXCustomizer
    Images = ImageList
    MenuBar = ToolbarMainMenu
    SaveFormState = False
    OnLoad = SpTBXCustomizerLoad
    OnSave = SpTBXCustomizerSave
    Left = 24
    Top = 172
    object CustomOpenNew: TSpTBXItem
      Caption = #26032#12375#12356'URL'#12434#38283#12367
      Hint = #26032#12375#12356'URL'#12434#38283#12367
      Action = ActionOpenNew
    end
    object CustomRecentlyViewed: TSpTBXSubmenuItem
      Caption = #26368#36817#35222#32884
      Options = [tboDropdownArrow]
      OnClick = CustomRecentlyViewedClick
    end
    object CustomViewPlayDARAO: TSpTBXItem
      Caption = 'DARAO'
      Action = ActionPlayDARAO
    end
    object CustomLogOutFromYouTube: TSpTBXItem
      Caption = 'YouTube'#12363#12425#12525#12464#12450#12454#12488
      Action = ActionLogOutFromYouTube
    end
    object CustomLogOutNicoVideo: TSpTBXItem
      Caption = #12491#12467#12491#12467#21205#30011#12363#12425#12525#12464#12450#12454#12488
      Action = ActionLogOutNicoVideo
    end
    object CustomRefresh: TSpTBXItem
      Caption = #20877#21462#24471
      Action = ActionRefresh
    end
    object CustomClearVideoPanel: TSpTBXItem
      Caption = #12499#12487#12458#12497#12493#12523#12434#31354#12395#12377#12427
      Hint = #12499#12487#12458#12497#12493#12523#12434#31354#12395#12377#12427
      Action = ActionClearVideoPanel
    end
    object CustomCopyTitle: TSpTBXItem
      Caption = #12479#12452#12488#12523#12434#12467#12500#12540
      Action = ActionCopyTitle
    end
    object CustomCopyURL: TSpTBXItem
      Caption = 'URL'#12434#12467#12500#12540
      Action = ActionCopyURL
    end
    object CustomCopyTU: TSpTBXItem
      Caption = #12479#12452#12488#12523#12392'URL'#12434#12467#12500#12540
      Action = ActionCopyTU
    end
    object CustomAddTag: TSpTBXItem
      Caption = #12479#12464#12434#26908#32034#12496#12540#12395#36861#21152#12377#12427
      Action = ActionAddTag
    end
    object CustomAddAuthor: TSpTBXItem
      Caption = #12518#12540#12470#12540#21517#12434#26908#32034#12496#12540#12395#36861#21152#12377#12427
      Action = ActionAddAuthor
    end
    object CustomOpenPrimarySite: TSpTBXItem
      Caption = #20803#12493#12479#21205#30011#12434#38283#12367
      Action = ActionOpenPrimarySite
    end
    object CustomSave: TSpTBXItem
      Caption = #12371#12398#12499#12487#12458#12434#20445#23384#12377#12427
      Hint = #12371#12398#12499#12487#12458#12434#20445#23384#12377#12427
      Action = ActionSave
    end
    object CustomOpenByBrowser: TSpTBXItem
      Caption = #22806#37096#12502#12521#12454#12470#12391#38283#12367
      Hint = #22806#37096#12502#12521#12454#12470#12391#38283#12367
      Action = ActionOpenByBrowser
    end
    object CustomExit: TSpTBXItem
      Caption = #32066#20102
      Action = ActionExit
    end
    object CustomViewToggleMenuBar: TSpTBXItem
      Caption = #12513#12491#12517#12540#12496#12540
      Action = ActionToggleMenuBar
    end
    object CustomViewToggleToolBar: TSpTBXItem
      Caption = #12484#12540#12523#12496#12540
      Action = ActionToggleToolBar
    end
    object CustomViewToggleSearchBar: TSpTBXItem
      Caption = #26908#32034#12496#12540
      Action = ActionToggleSearchBar
    end
    object CustomViewToggleTitleBar: TSpTBXItem
      Caption = #12499#12487#12458#12479#12452#12488#12523#12496#12540
      Action = ActionToggleTitleBar
    end
    object CustomViewToolBarToolBarFixed: TSpTBXItem
      Caption = #12484#12540#12523#12496#12540#12434#22266#23450#12377#12427
      Action = ActionToolBarFixed
    end
    object CustomViewToggleLogPanel: TSpTBXItem
      Caption = #12525#12464#12497#12493#12523
      Action = ActionToggleLogPanel
    end
    object CustomViewToggleFavoritePanel: TSpTBXItem
      Caption = #12362#27671#12395#20837#12426#12497#12493#12523
      Action = ActionToggleFavoritePanel
    end
    object CustomViewToggleVideoInfoPanel: TSpTBXItem
      Caption = #12499#12487#12458#24773#22577#12497#12493#12523
      Hint = #12499#12487#12458#24773#22577#12497#12493#12523
      Action = ActionToggleVideoInfoPanel
    end
    object CustomToggleVideoRelatedPanel: TSpTBXItem
      Caption = #38306#36899#12499#12487#12458#12497#12493#12523
      Hint = #38306#36899#12499#12487#12458#12497#12493#12523
      Action = ActionToggleVideoRelatedPanel
    end
    object CustomViewToggleSearchPanel: TSpTBXItem
      Caption = #26908#32034#12497#12493#12523
      Hint = #26908#32034#12497#12493#12523
      Action = ActionToggleSearchPanel
    end
    object CustomViewTogglePanelSearchToolBar: TSpTBXItem
      Caption = #26908#32034#12496#12540'('#26908#32034#12497#12493#12523')'
      Action = ActionTogglePanelSearchToolBar
    end
    object CustomViewToggleSplitter: TSpTBXItem
      Caption = #12473#12503#12522#12483#12479#12540
      Action = ActionToggleSplitter
    end
    object CustomViewTheme: TSpTBXSubmenuItem
      Caption = #12486#12540#12510
      Options = [tboDropdownArrow]
      object SpTBXSkinGroupItem3: TSpTBXSkinGroupItem
      end
    end
    object CustomStayOnTop: TSpTBXItem
      Caption = #26368#21069#38754
      Hint = #26368#21069#38754
      Action = ActionStayOnTop
    end
    object CustomViewChangeVideoScale: TSpTBXItem
      Caption = #12499#12487#12458#12473#12465#12540#12523#12434#22793#26356#12377#12427
      Action = ActionChangeVideoScale
    end
    object CustomUserWindowSize: TSpTBXItem
      Caption = #12454#12451#12531#12489#12454#12469#12452#12474#12434#12518#12540#12470#12540#35215#23450#20516#12395#12377#12427
      Hint = #12454#12451#12531#12489#12454#12469#12452#12474#12434#12518#12540#12470#12540#35215#23450#20516#12395#12377#12427
      Action = ActionUserWindowSize
    end
    object CustomDefaultWindowSize: TSpTBXItem
      Caption = #12454#12451#12531#12489#12454#12469#12452#12474#12434#35215#23450#20516#12395#25147#12377
      Action = ActionDefaultWindowSize
    end
    object CustomActionToggleWindowSize: TSpTBXItem
      Caption = #12454#12451#12531#12489#12454#12469#12452#12474#20999#26367
      Hint = #12454#12451#12531#12489#12454#12469#12452#12474#20999#26367
      Action = ActionToggleWindowSize
    end
    object CustomAddFavorite: TSpTBXItem
      Caption = #12362#27671#12395#20837#12426#12395#36861#21152
      Action = ActionAddFavorite
    end
    object CustomSearchBarSearch: TSpTBXItem
      Caption = #26908#32034
      Hint = #26908#32034
      Action = ActionSearchBarSearch
    end
    object CustomSearchBarAdd100: TSpTBXItem
      Caption = #36861#21152#26908#32034
      Hint = #36861#21152#26908#32034
      Action = ActionSearchBarAdd100
    end
    object CustomSearchBarToggleListView: TSpTBXItem
      Caption = #34920#31034#20999#26367
      Hint = #34920#31034#20999#26367
      Action = ActionSearchBarToggleListView
    end
    object CustomToggleSearchTarget: TSpTBXSubmenuItem
      Caption = #26908#32034#20808#20999#26367
      Options = [tboDropdownArrow]
      LinkSubitems = MenuSearchToggleSearchTarget
    end
    object CustomYouTube: TSpTBXSubmenuItem
      Caption = 'YouTube'
      ImageIndex = 13
      Options = [tboDropdownArrow]
      LinkSubitems = MenuSearchYouTube
    end
    object CustomNicoVideo: TSpTBXSubmenuItem
      Caption = #12491#12467#12491#12467#21205#30011
      ImageIndex = 14
      Options = [tboDropdownArrow]
      LinkSubitems = MenuSearchNicoVideo
    end
    object CustomClearHistory: TSpTBXItem
      Caption = #26908#32034#23653#27508#21066#38500
      Action = ActionClearSearchHistory
    end
    object CustomSetting: TSpTBXItem
      Caption = #35373#23450
      Hint = #35373#23450
      Action = ActionSetting
    end
    object CustomCustomize: TSpTBXItem
      Caption = #12459#12473#12479#12510#12452#12474
      Action = ActionCustomize
    end
    object CustomClearRecentlyViewed: TSpTBXItem
      Caption = #26368#36817#35222#32884#12375#12383#21205#30011#12434#21066#38500
      Action = ActionClearRecentlyViewed
    end
    object CustomHelp: TSpTBXItem
      Caption = #12504#12523#12503
      Hint = #12504#12523#12503
      Action = ActionHelp
    end
    object CustomOpenYouTube: TSpTBXItem
      Caption = 'YouTube'#12434#38283#12367
      Action = ActionOpenYouTube
    end
    object CustomOpenNicoVideo: TSpTBXItem
      Caption = #12491#12467#12491#12467#21205#30011#12434#38283#12367
      Action = ActionOpenNicoVideo
    end
    object CustomOpenNicoVideoBlog: TSpTBXItem
      Caption = #12491#12467#12491#12467#21205#30011' '#38283#30330#32773#12502#12525#12464#12434#38283#12367
      Action = ActionOpenNicoVideoBlog
    end
    object CustomOpenOfficialSite: TSpTBXItem
      Caption = 'TubePlayer'#20844#24335#12469#12452#12488#12434#38283#12367
      Action = ActionOpenOfficialSite
    end
    object CustomCheckUpdate: TSpTBXItem
      Caption = #12450#12483#12503#12487#12540#12488#12481#12455#12483#12463
      Action = ActionCheckUpdate
    end
    object CustomBugReport: TSpTBXItem
      Caption = #12496#12464#12524#12509#12540#12488
      Action = ActionBugReport
    end
    object CustomVersion: TSpTBXItem
      Caption = #12496#12540#12472#12519#12531#24773#22577
      Action = ActionVersion
    end
  end
  object XMLDocument: TXMLDocument
    Left = 62
    Top = 244
    DOMVendorDesc = 'MSXML'
  end
  object ListPopupMenu: TSpTBXPopupMenu
    Images = ImageList
    OnPopup = ListPopupMenuPopup
    Left = 209
    Top = 109
    object ListPopupOpenURL: TSpTBXItem
      Caption = #12371#12398#12499#12487#12458#12434#38283#12367'(&V)'
      Action = ActionListOpenURL
    end
    object SpTBXSeparatorItem22: TSpTBXSeparatorItem
    end
    object ListPopupAddTag: TSpTBXItem
      Caption = #12371#12398#12499#12487#12458#12398#12479#12464#12434#26908#32034#12496#12540#12395#36861#21152'(&A)'
      Action = ActionListAddTag
    end
    object ListPopupAddAuthor: TSpTBXItem
      Caption = #12371#12398#12499#12487#12458#12398#12518#12540#12470#12540#21517#12434#26908#32034#12496#12540#12395#36861#21152'(&B)'
      Action = ActionListAddAuthor
    end
    object SpTBXSeparatorItem25: TSpTBXSeparatorItem
    end
    object ListPopupAddFavorite: TSpTBXSubmenuItem
      Caption = #12362#27671#12395#20837#12426#12395#36861#21152'(&A)'
      ImageIndex = 16
    end
    object SpTBXSeparatorItem52: TSpTBXSeparatorItem
    end
    object ListPopupCopy: TSpTBXSubmenuItem
      Caption = #12467#12500#12540'(&C)'
      object ListPopupCopyTitle: TSpTBXItem
        Caption = #12479#12452#12488#12523#12434#12467#12500#12540'(&0)'
        Action = ActionListPopupCopyTitle
      end
      object ListPopupCopyURL: TSpTBXItem
        Caption = 'URL'#12434#12467#12500#12540'(&1)'
        Action = ActionListPopupCopyURL
      end
      object ListPopupCopyTU: TSpTBXItem
        Caption = #12479#12452#12488#12523#12392'URL'#12434#12467#12500#12540'(&2)'
        Action = ActionListPopupCopyTU
      end
    end
    object SpTBXSeparatorItem19: TSpTBXSeparatorItem
    end
    object ListPopupOpenByBrowser: TSpTBXItem
      Caption = #22806#37096#12502#12521#12454#12470#12391#38283#12367'(&O)...'
      Action = ActionListOpenByBrowser
    end
    object SpTBXSeparatorItem53: TSpTBXSeparatorItem
    end
    object ActionListSave: TSpTBXItem
      Caption = #12371#12398#12499#12487#12458#12434#20445#23384#12377#12427'(&S)...'
      Action = ActionListPopupSave
    end
    object SpTBXSeparatorItem54: TSpTBXSeparatorItem
    end
    object ListPopupToggleListView: TSpTBXItem
      Caption = #34920#31034#20999#26367'(&T)'
      ImageIndex = 7
      OnClick = ActionSearchBarToggleListViewExecute
    end
  end
  object XMLDocument2: TXMLDocument
    Left = 62
    Top = 273
    DOMVendorDesc = 'MSXML'
  end
  object TimerSetSearchBar: TTimer
    Enabled = False
    Interval = 200
    OnTimer = TimerSetSearchBarTimer
    Left = 22
    Top = 310
  end
  object SearchTimer: TTimer
    Enabled = False
    Interval = 300
    OnTimer = SearchTimerTimer
    Left = 22
    Top = 342
  end
  object FavoritePopupMenu: TSpTBXPopupMenu
    Images = ImageList
    OnPopup = FavoritePopupMenuPopup
    Left = 72
    Top = 429
    object FavoritePopupOpen: TSpTBXItem
      Caption = #12371#12398#12499#12487#12458#12434#38283#12367'(&V)'
      Action = ActionFavoritePopupOpen
      Enabled = False
    end
    object SpTBXSeparatorItem46: TSpTBXSeparatorItem
    end
    object FavoritePopupOpenByBrowser: TSpTBXItem
      Caption = #22806#37096#12502#12521#12454#12470#12391#38283#12367'(&O)...'
      Action = ActionFavoritePopupOpenByBrowser
      Enabled = False
      ImageIndex = 2
    end
    object SpTBXSeparatorItem47: TSpTBXSeparatorItem
    end
    object FavoritePopupCopy: TSpTBXSubmenuItem
      Caption = #12467#12500#12540'(&C)'
      object FavoritePopupCopyTitle: TSpTBXItem
        Caption = #12479#12452#12488#12523#12434#12467#12500#12540'(&0)'
        Action = ActionFavoritePopupCopyTitle
      end
      object FavoritePopupCopyURL: TSpTBXItem
        Caption = 'URL'#12434#12467#12500#12540'(&1)'
        Action = ActionFavoritePopupCopyURL
      end
      object FavoritePopupCopyTU: TSpTBXItem
        Caption = #12479#12452#12488#12523#12392'URL'#12434#12467#12500#12540'(&2)'
        Action = ActionFavoritePopupCopyTU
      end
    end
    object SpTBXSeparatorItem48: TSpTBXSeparatorItem
    end
    object FavoritePopupAddMylist: TSpTBXItem
      Caption = #12510#12452#12522#12473#12488#12434#12362#27671#12395#20837#12426#12395#36861#21152'(&M)'
      Action = ActionFavoritePopupAddMylist
    end
    object SpTBXSeparatorItem68: TSpTBXSeparatorItem
    end
    object FavoritePopupNew: TSpTBXItem
      Caption = #26032#35215#12501#12457#12523#12480'(&N)'
      Action = ActionFavoritePopupNew
    end
    object FavoritePopupEdit: TSpTBXItem
      Caption = #21517#21069#12398#22793#26356'(&E)'
      Action = ActionFavoritePopupEdit
    end
    object SpTBXSeparatorItem49: TSpTBXSeparatorItem
    end
    object FavoritePopupDelete: TSpTBXItem
      Caption = #21066#38500'(&D)'
      Action = ActionFavoritePopupDelete
      Enabled = False
    end
  end
  object ImageList: TImageList
    Left = 24
    Top = 272
    Bitmap = {
      494C010113001800040010001000FFFFFFFFFF00FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000006000000001002000000000000060
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ACAA
      A8009E9E9E000000000000000000000000000000000000000000000000009EB4
      C7009E9E9E00AFAFAF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A37C7600A37C7600A37C
      7600A37C7600A37C7600A37C7600A37C7600A37C7600A37C7600A37C7600A37C
      7600A37C7600A37C760000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007FB8D0000C85
      AF00216E930098989800000000000000000000000000000000007FB8D0005EA2
      BE003188AF009898980000000000000000000000000000000000DFDFDF00D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600DFDFDF000000000000000000AE7F7200EECBB800EFC1
      AB00ECBDA500ECBDA500ECBDA500ECBDA500ECBDA500ECBDA500ECBDA500ECBD
      A500ECBDA500A37C760000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009EB4C7007FB8
      D0000FD0FD000C85AF009898980000000000000000007FB8D0007FB8D0008BEF
      FF003188AF00B9B9B900000000000000000000000000C8C8C800838383006D6D
      6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D
      6D006D6D6D006D6D6D0083838300C8C8C80000000000AE7F7200FAE1C500FAE1
      C500F9DDC200F9DDC200F9D7C000F8D6B700F8D6B700F8D6B700F7D1B100F7D1
      B100ECBDA500A37C760000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005EA2
      BE006FD8F8000FD0FD0025A6CD009898980083A6BE009ECDCF0055E5FD0018C3
      EE0052879000000000000000000000000000DFDFDF001D82B5001B81B300187E
      B000167CAE001379AB001076A8000D73A5000B71A300086EA000066C9E00046A
      9C0002689A00016799004C4C4C008383830000000000B1867A00F8E3CE00F8E3
      CE0001980100B9D4A10071BC650034A6340071BC6500E6D3AA00F7D1B100F7D1
      B100EFC1AB00A37C760000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009EB4
      C70095D7E4000FD0FD0038DCFE003FB4D90095D7E4008BEFFF0038DCFE000298
      CB0077939F000000000000000000000000002287BA0067CCFF002085B80099FF
      FF006FD4FF006FD4FF006FD4FF006FD4FF006FD4FF006FD4FF006FD4FF006FD4
      FF003BA0D30099FFFF00016799006E6E6E0000000000B88F7F00FAE7D400F8E3
      CE00019801000198010001980100019801000198010034A63400F8D6B700F8D6
      B700EFC1AB00A37C760000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000083A6BE0038DCFE000FD0FD0055E5FD0093F8FF0093F8FF0055E5FD001D79
      A30000000000000000000000000000000000258ABD0067CCFF00278CBF0099FF
      FF007BE0FF007BE0FF007BE0FF007BE0FF007BE0FF007BE0FF007BE0FF007BE0
      FF0044A9DC0099FFFF0002689A006D6D6D0000000000BF958200FAE7D400FAE7
      D400019801000198010010971300B9D4A100F8E3CE0014A21B00F9D7C000F8D6
      B700E7C8AC00A37C760000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B6B4
      B2001D79A3007CDEFE000FD0FD0038DCFE006AEFFF0093F8FF006FD8F8004F54
      81009E9E9E00000000000000000000000000288DC00067CCFF002D92C50099FF
      FF0085EBFF0085EBFF0085EBFF0085EBFF0085EBFF0085EBFF0085EBFF0085EB
      FF004EB3E60099FFFF00046A9C006D6D6D0000000000C99B8200F9ECDB00F9EC
      DB0001980100019801000198010001980100F8E3CE00F9D7C000F9DDC200F9D7
      C000E7C8AC00A37C760000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008B9BA9003188
      AF0018C3EE0023D6FD000FD0FD0023D6FD0055E5FD0093F8FF008BEFFF0050AE
      D100216E930077939F0000000000000000002A8FC20067CCFF003398CB0099FF
      FF0091F7FF0091F7FF0091F7FF0091F7FF0091F7FF0091F7FF0091F7FF0091F7
      FF0057BCEF0099FFFF00066C9E006D6D6D0000000000D4A38200FBEFE200F9EC
      DB00F9ECDB00FAE7D400FAE7D400F8E3CE00FAE1C500F9DDC200F9DDC200F9DD
      C200EECBB800A37C760000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005287900025A6CD0055E5
      FD006AEFFF0038DCFE0023D6FD000FD0FD0055E5FD006AEFFF0040C8BC001CAB
      3D0025A6CD000298CB004F548100000000002D92C5006FD4FF003499CC0099FF
      FF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FF
      FF0060C5F80099FFFF00086EA0006E6E6E0000000000DAA88700FBEFE200FBEF
      E200F9ECDB00F9ECDB00FAE7D400019801000198010001980100FAE1C500FAE1
      C500EECBB800A37C760000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005EA2BE0023D6FD008BEFFF00B9F2
      FA00B9F2FA009BE5F00082E6FE000FD0FD0023D6FD0055E5FD00248B37003DCD
      6A00248B370038DCFE0040C6F300216E93002F94C7007BE0FF002D92C500FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0081E6FF00FFFFFF000B71A3008C8C8C0000000000DAA88700F9F3ED00FCF2
      E60010971300B9D4A100F9ECDB00B9D4A1000198010001980100F8E3CE00FAE1
      C500EECBB800A37C760000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009EB4C7005EA2BE005EA2BE003188
      AF003188AF001D79A30095D7E40023D6FD0025A6CD00248B37001CAB3D004BD7
      7C001CAB3D00248B3700528790005EA2BE003196C90085EBFF0081E6FF002D92
      C5002D92C5002D92C5002D92C5002D92C5002D92C500288DC0002489BC002085
      B8001C81B4001B81B3001B81B300DFDFDF0000000000DAA88700F9F3ED00F9F3
      ED008CB48D000198010001980100019801000198010001980100FAE7D400F8E3
      CE00EECBB800A37C760000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003188AF0083A6BE0040C8BC001CAB3D003DCD6A004BD77C0056E7
      89004BD77C003DCD6A001CAB3D008CB48D003398CB0091F7FF008EF4FF008EF4
      FF008EF4FF008EF4FF008EF4FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00167CAE008C8C8C00DEDEDE000000000000000000DAA88700FFFFFF00F9F3
      ED00F9F3ED0071BC65000198010001980100B9D4A10001980100FAE7D400FAE7
      D400EECBB800A37C760000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005EA2BE005694B50055E5FD002D97BC00248B37001CAB3D004BD7
      7C001CAB3D00248B37007BAF8000000000003499CC00FFFFFF0099FFFF0099FF
      FF0099FFFF0099FFFF00FFFFFF00258ABD002287BA001F84B7001D82B5001B81
      B300187EB000DFDFDF00000000000000000000000000DAA88700FFFFFF00FFFF
      FF00FCF7EF00F9F3ED00FCF2E600FCF2E600FBEFE200FDD6CA00FDD6CA00F5B0
      A800B1867A008B86870000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009EB4C7002D97BC00B2DDEF002D97BC008B9BA900248B37003DCD
      6A00539A5600000000000000000000000000000000003499CC00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF002A8FC200C8C8C8000000000000000000000000000000
      00000000000000000000000000000000000000000000DAA88700FFFFFF00FEFC
      FB00FFFFFF00FCF7EF00F9F3ED00FCF2E600FCF2E600F5A64200F5A64200DD8C
      4300D5B7A4000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005EA2BE0083A6BE002D97BC00000000007BAF80001CAB
      3D007BAF800000000000000000000000000000000000000000003499CC003398
      CB003196C9002F94C700DFDFDF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DAA88700FFFFFF00FFFF
      FF00FEFCFB00FEFCFB00FFFFFF00FCF7EF00F9F3ED00DAA88700EBB37300D5B7
      A400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000005EA2BE009EB4C70000000000000000008CB4
      8D00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DAA88700DAA88700DAA8
      8700DAA88700DAA88700DAA88700DAA88700D4A38200DAA88700D5B7A4000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008383FF006969
      FF006E6EFF006161FF005959FF005A5AFF005A5AFF005656FF006464FF007070
      FF006363FF008282FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BABBBC006595
      AE00AFB5B8000000000000000000000000000000000000000000BABBBC0083A8
      BB009DB0BA00000000000000000000000000B5717100D2462700D2462700D246
      2700D2462700D2462700D2462700D2462700D2462700D2462700D2462700D246
      2700D2462700D2462700D246270000000000000000005D5DFF002C2CFF004141
      FF002828FF003838FF004444FF002E2EFF003131FF005151FF002E2EFF000F0F
      FF006565FF001D1DFF005A5AFF00000000000000000000000000333333003333
      3300000000000000000000000000000000000000000000000000000000000000
      00003333330033333300000000000000000000000000000000006595AE008AE8
      FE001B8BB70083A8BB000000000000000000000000009DB0BA0083A8BB00D6FC
      FF005C7A8C00000000000000000000000000E29D9100F9F9F900FFF5EB00FFF2
      E600FFECDA00FFE8D300FFE3C800FFDFC200FFDAB700FFD7B000FFD2A500FFCE
      A000FFC89500FFC48F00D246270000000000000000003C3CFF000A0AFF000000
      00003333FF00D4D4FF0000000000A5A5FF00B9B9FF0000000000AEAEFF007C7C
      FF0000000000E0E0FF001616FF00000000000000000000000000000000000000
      0000333333000000000000000000000000000000000000000000000000003333
      3300000000000000000000000000000000000000000000000000AFB5B800B6CF
      E00038D0FA000DA2D1006595AE000000000083A8BB00B6CFE000AFF1FE0029C5
      F10077A0B500000000000000000000000000E29D9100F9F9F900D2462700D246
      2700D2462700D2462700D2462700D2462700FFDFC200FFDAB700FFD7B000FFD2
      A500FFCEA000FFC89500D246270000000000000000003333FF000A0AFF000000
      00003434FF00CBCBFF007272FF00A5A5FF00B0B0FF006363FF00B3B3FF00C9C9
      FF005757FF007979FF002222FF00000000000000000000000000333333003333
      3300333333003333330033333300333333003333330033333300333333003333
      330033333300333333000000000000000000000000000000000000000000789E
      BA008AE8FE0013D0FF002FBBDB005C7A8C00B6CFE000AFF1FE0013D0FF001B8B
      B70000000000000000000000000000000000E29D9100F9F9F900D2462700FFF5
      EB00FFE8D300FFDDBD009DBA6800D2462700FFE3C800FFDFC200FFDAB700FFD7
      B000FFD2A500FFCEA000D246270000000000000000003333FF000B0BFF00FBFB
      FF003333FF00C6C6FF008585FF00A2A2FF00ACACFF005B5BFF00ACACFF00B7B7
      FF00DADAFF00DDDDFF000F0FFF00000000000000000033333300333333000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000033333300333333000000000000000000000000000000000083A8
      BB00EDF1D40025D4FF0043DFFE007BF2FF00C7F5FE007BF2FF0029C5F1006595
      AE0000000000000000000000000000000000E29D9100F9F9F900D2462700FFF5
      EB00FFF5EB00FFE8D3006AB05000D24627008BC17200FFE3C800FFDFC200FFDA
      B700FFD7B000FFD2A500D246270000000000000000003434FF000202FF00F6F6
      FF002727FF00E6E6FF009E9EFF00B9B9FF00A1A1FF00EFEFFF00B9B9FF00A0A0
      FF00E2E2FF00DFDFFF000202FF00000000000000000033333300333333000000
      0000000000000000000000000000333333003333330000000000000000000000
      0000000000003333330033333300000000000000000000000000000000000000
      00004DA1C00066DFFB0025D4FF005DE9FF0091FBFE0091FBFE00349CC4009DB0
      BA0000000000000000000000000000000000E29D9100F9F9F900D2462700FFF5
      EB00FFF5EB00FFF2E700FFE8D3002C9A2100008400002C9B2300D7D7A900FFD7
      B00000840000FFD7B000D246270000000000000000003333FF000505FF000000
      00004A4AFF004A4AFF004D4DFF003535FF00DEDEFF00B2B2FF003737FF001212
      FF00A6A6FF002B2BFF003D3DFF00000000000000000033333300333333000000
      0000333333003333330000000000000000000000000000000000000000000000
      000000000000333333003333330000000000000000000000000083A8BB00349C
      C40008CCFD0013D0FF0008CCFD0043DFFE007BF2FF0091FBFE0066DFFB001B8B
      B7006595AE00000000000000000000000000E29D9100F9F9F900B7433000B743
      3000B7433000B7433000B7433000B7433000088B070000840000088A06002C9B
      230000840000FFDAB700D246270000000000000000001919FF00D8D8FF000000
      0000000000002727FF001010FF000000FF00F2F2FF002F2FFF000000FF002626
      FF001E1EFF00A9A9FF007676FF00000000000000000033333300333333000000
      0000333333003333330000000000000000000000000000000000000000000000
      000000000000333333003333330000000000AFB5B8004DA1C00011B6E70043DF
      FE005DE9FF0038D0FA0008CCFD0025D4FF005DE9FF0091FBFE0091FBFE0043DF
      FE0011B6E7001B8BB70083A8BB0000000000E29D9100F9F9F900D5806A00D562
      4700D5624700D5624700D5624700D5806A00B0D8A30000840000008400000084
      000000840000FFDFC200D24627000000000000000000AFAFFF002626FF001312
      FF001E20FF003333FF003636FF003838FF001E1FFF002E2EFF005757FF008688
      FF00C2C2FF00D1D1FF00AAAAFF00000000000000000033333300333333000000
      0000000000000000000000000000000000000000000000000000333333003333
      330000000000333333003333330000000000349CC4008AE8FE00AFF1FE00C7F5
      FE00D6FCFF00C7F5FE0066DFFB0013D0FF0043DFFE00C7F5FE00D6FCFF00AFF1
      FE008AE8FE008AE8FE00349CC40000000000E29D9100F9F9F900FFFFFA00FFFF
      F700FFFFF400FFFFF400FFFCF000FFFAEC00FFF9EC002C9B2300008400000084
      000000840000FFE3C800D2462700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000033333300333333000000
      0000000000000000000000000000000000000000000000000000333333003333
      33000000000033333300333333000000000077A0B50077A0B500349CC400349C
      C400349CC400349CC400C7F5FE0008CCFD0025D4FF001B8BB700349CC400349C
      C400349CC400349CC40083A8BB0000000000E29D9100F9F9F900FFFFFA00FFFF
      F700FFFFF400FFFFF400FFFCF000FFFAEC000084000000840000008400000084
      000000840000FFE8D300D2462700000000000000000000000000000000000000
      0000CCCCCC00EEEEEE0022222200000000002222220000000000333333000000
      0000000000000000000000000000000000000000000033333300333333000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003333330033333300000000000000000000000000000000000000
      0000000000009DB0BA00349CC40013D0FF0011B6E700789EBA00000000000000
      000000000000000000000000000000000000E29D9100F9F9F900FFFFFA00FFFF
      F700FFFFF400FFFFF400FFFCF000FFFAEC00FFF9EC00FFF7E800FFF5E600FFF4
      E400FFF2E600FFECDA00D2462700000000000000000000000000000000000000
      0000CCCCCC000000000022222200EEEEEE0011111100BBBBBB00000000008888
      8800111111000000000000000000000000000000000000000000333333003333
      3300333333003333330033333300333333003333330033333300333333003333
      3300333333003333330000000000000000000000000000000000000000000000
      00000000000000000000349CC40066DFFB000DA2D100AFB5B800000000000000
      000000000000000000000000000000000000E29D9100F9F9F900FFFFFA00FFFF
      F700FFFFF400FFFFF400FFFCF000FFFAEC00FFF9EC00FFF7E800FFF5E600FFF4
      E400FFF2E600FFF0E100D2462700000000000000000000000000EEEEEE000000
      0000CCCCCC000000000022222200EEEEEE0011111100BBBBBB0000000000CCCC
      CC00111111000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000333333003333330000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000349CC400B0F0FF001B8BB70000000000000000000000
      000000000000000000000000000000000000B7433000B7433000B7433000B743
      3000B7433000B7433000B7433000B7433000B7433000B7433000B7433000B743
      3000B7433000B7433000B7433000000000000000000000000000777777000000
      000055555500EEEEEE002222220000000000222222000000000000000000CCCC
      CC00111111000000000000000000000000000000000000000000000000000000
      0000000000003333330033333300000000000000000033333300333333000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000083A8BB007DC4EA005C7A8C0000000000000000000000
      000000000000000000000000000000000000D5806A00D5624700D5624700D562
      4700D5624700D5624700D5624700D5624700D5624700D5624700D5624700D562
      4700D5624700D5624700D5806A000000000000000000DDDDDD00000000008888
      880000000000DDDDDD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003333
      3300333333000000000000000000000000000000000000000000000000003333
      3300333333000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000DA2D100BABBBC0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000ACAAA8008B868700BEA1
      A300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000093645F0093645F009364
      5F0093645F0093645F0093645F0093645F0093645F0093645F0093645F009364
      5F0093645F0093645F000000000000000000000000008383830069688F00A88E
      9000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000083A6BE004A7BC500807E
      A300BEA1A3000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000095000000950000009500000095000000950000000000000000
      000000000000000000000000000000000000000000009C645700EEBBA400ECB2
      9900E9AE9200E9AE9200E9AE9200E9AE9200E9AE9200E9AE9200E9AE9200E9AE
      9200E9AE920093645F00000000000000000000000000608AA2005670C2006968
      8F00A88E90000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080BEEE0050B3FD004A7B
      C500807EA300BEA1A30000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000095000092FB9F0078DF7C0078DF7C0000950000000000000000
      00000000000000000000000000000000000000000000A46C5B00FBD9BE00FAD8
      BB00FAD5B600FAD3B400F9D1AF00F9CEAB00FACDA800F9C9A300F7C7A000F9C4
      9C00E9AE920093645F0000000000000000000000000065ABEB002B9FFD005670
      C20069688F00A88E900000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080BEEE0050B3
      FD004A7BC500807EA300BEA1A300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000095000092FB9F0041DA5A0078DF7C0000950000000000000000
      00000000000000000000000000000000000000000000AB725E00FBDDC300FBDA
      C000FAD8BC00FAD5B800FAD3B500FAD1B000FACFAD00F9CCA800F9CAA400F9C8
      A000ECB2990093645F000000000000000000000000000000000065ABEB002B9F
      FD005670C20069688F00A88E9000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000080BE
      EE0050B3FD004A7BC500807EA300B6B4B2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000095000092FB9F0041DA5A0078DF7C0000950000000000000000
      00000000000000000000000000000000000000000000B4796200FBE1C900FBDD
      C600FBDCC200D7C6CE00FAD7BA00FAD3B600FAD2B100EBC7B000FFCFA300FACA
      A500ECB2990093645F000000000000000000000000007171710071717100447E
      9C002B9FFD005670C200594F460068676700594F4600594F4600594F46007171
      7100717171007171710071717100000000000000000000000000000000000000
      000080BEEE0050B3FD006B85D300A2A3A400C2AAA100C99B8200C99B8200C99B
      8200CAA58D00BEA1A30000000000000000000000000000000000000000000000
      0000000000000095000092FB9F0041DA5A0078DF7C0000950000000000000000
      00000000000000000000000000000000000000000000BB806500FBE2CE00FBDF
      CA00C3BEDC00082BFC004A61E900D7C6CE004A5FE4001F3DEE00EBC7B000F9CE
      AB00EDB7A00093645F00000000000000000000000000D0462600D0462600D046
      2600447E9C008E9FB100B17E6600FCE4A800FEF8ED00FFFFFF00FEFDF7009064
      5E0025292500D046260052391E00000000000000000000000000000000000000
      00000000000080BEEE00C3C2C200B88F7F00C2AAA100F7D1B100FDF0C600F9EC
      DB00E3DEC000D5B7A400CAA58D00000000000095000000950000009500000095
      0000009500000095000092FB9F0041DA5A0078DF7C0000950000009500000095
      00000095000000950000009500000000000000000000C3886900FBE6D400FCE4
      D100EBDFDF001F40F7000021FF001335F7000021FF001F3EF100EBCCB700F9D2
      B000EDB7A00093645F00000000000000000000000000E19C9200FCEEDF00FCEE
      DF00FCEEDF00A9AAAA00D6C29500FAEFB900FAEFB900FCEDD900FEFDF700FEFD
      F70063605D00FCEEDF00D0462600000000000000000000000000000000000000
      00000000000000000000C2AAA100DAA88700FDF0C600FDF0C600FEFED700FEFE
      E900FEFCFB00FFFFFF00C6B2A300BF9C930000950000C8FFD60092FB9F0092FB
      9F0092FB9F0092FB9F0092FB9F0041DA5A0078DF7C0078DF7C0078DF7C0078DF
      7C0078DF7C0078DF7C00009500000000000000000000CA8F6D00FCE9D800FCE7
      D400FBE4D200EBDFDF00082BFC000021FF00082AFB00EBD2C400FFDCB800FAD4
      B500EEBBA40093645F00000000000000000000000000E19C9200FDF4EA00FADF
      C900D5CDC500C6A48E00DCC99A00D6C29500D5CDC500D8D7D600EADEE100FEF8
      ED00BF988000EB848600D0462600000000000000000000000000000000000000
      00000000000000000000CAA58D00E6D3AA00FEE4B600FDF0C600FEFED700FEFE
      E900FEFCFB00FEFCFB00E3DEC000C99B820000950000C8FFD6004BDA5F004BDA
      5F004BDA5F004BDA5F004BDA5F004BDA5F004BDA5F0041DA5A004BDA5F004BDA
      5F004BDA5F004BDA5F00009500000000000000000000D3967100FEECDE00FCE9
      D900FCE7D7004A65F4000021FF000021FF000021FF004A61E900FFDFC200FAD7
      BA00EEBCA70093645F00000000000000000000000000E19C9200FDF4EA00F9E3
      CF00FAC8B500CEB59200CEB59200CEB59200D6C4C400E9D6C400E9D6C400F9E8
      D500C6A48E00EB848600D0462600000000000000000000000000000000000000
      00000000000000000000C99B8200FDF0C600FBD7AB00FDF0C600FEFED700FEFE
      E900FEFEE900FEFEE900F9ECDB00C99B820000950000C8FFD600C8FFD600C8FF
      D600AEFFAB00AEFFAB00AEFFAB004BDA5F0092FB9F0092FB9F0092FB9F0092FB
      9F0092FB9F0092FB9F00009500000000000000000000D3967100FCF0E400FCED
      DF00B0BBF5000021FF001F41FA00D7D1E1001F40F700082BFC00D7C6CE00FBD9
      BE00F0C0AA0093645F00000000000000000000000000E19C9200FDF4EA00EADE
      E100EADEE100C9AAA500F0D3AE00D6C29500DCC99A00F0D3AE00F0D3AE00FFFD
      B200BD876D00E9D6C400D0462600000000000000000000000000000000000000
      00000000000000000000C99B8200FDF0C600FEE4B600FDF0C600FEFED700FEFE
      D700FEFED700FEFED700FDF0C600BF9582000095000000950000009500000095
      00000095000000950000C8FFD6004DE06A0092FB9F0000950000009500000095
      00000095000000950000009500000000000000000000D3967100FEF5ED00FEF5
      ED00FCEEE1009DABF500EBDFDF00FCE7D500EBDFDF00C3BEDC00FFE7CF00FBDD
      C400F0C1AE0093645F00000000000000000000000000E19C9200FDF4EA00F9E3
      CF00FCEEDF00F8A29600C3BDB800E7E8ED00F0D3AE00FBC68F00FCE4A800EABE
      8400807A7700FCEEDF00D0462600000000000000000000000000000000000000
      00000000000000000000CAA58D00F8D6B700FBEFE200FEE4B600FDF0C600FDF0
      C600FDF0C600FDF0C600E6D3AA00C99B82000000000000000000000000000000
      00000000000000950000C8FFD6004DE06A0092FB9F0000950000000000000000
      00000000000000000000000000000000000000000000D3967100FFFAF500FFFA
      F500FEF7F100FEF4E900FCEEE100FCECDE00FCE9DA00FCE7D500FBE2CE00FBDF
      C900F1BCAA0093645F00000000000000000000000000E19C9200FDF4EA00FADD
      C300FADFC900FADDC300EB848600CBB6AD00DCC99A00DCC99A00CEB592009A87
      8400F9E3CF00FCEEDF00D0462600000000000000000000000000000000000000
      00000000000000000000C6B2A300D5AE9200FFFFFF00FCF7EF00FDF0C600FBD7
      AB00FEE4B600FDF0C600DAA88700BEA1A3000000000000000000000000000000
      00000000000000950000C8FFD6005DE87A0092FB9F0000950000000000000000
      00000000000000000000000000000000000000000000D3967100FFFFFF00FFFF
      FF00FFFAF500FEF7F100FFF4EB00FEEEE300FCEDDF00FCEBDA00FFCAC000F2A2
      9800A272670073737300000000000000000000000000E19C9200FDF4EA00F9E8
      D500FCEEDF00FDF4EA00FCEEDF00EAB39B00EB848600E19C9200ECBEA800FCEE
      DF00FCEEDF00FCEEDF00D0462600000000000000000000000000000000000000
      0000000000000000000000000000CAA58D00D5AE9200F9D7C000FDF0C600FDF0
      C600FBD7AB00DAA88700BF9C9300000000000000000000000000000000000000
      00000000000000950000C8FFD6005DE87A0092FB9F0000950000000000000000
      00000000000000000000000000000000000000000000D3967100FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFAF500FEF5ED00FCF0E600FCEDE100F5932E00D87D
      2C00C7A48C0000000000000000000000000000000000E19C9200FDF4EA00FCF1
      E400FCF1E400FCF1E400FDF4EA00FDF4EA00FDF4EA00FDF4EA00FDF4EA00FDF4
      EA00FDF4EA00FCEEDF00D0462600000000000000000000000000000000000000
      000000000000000000000000000000000000C6B2A300C99B8200C99B8200C99B
      8200CAA58D00C2AAA10000000000000000000000000000000000000000000000
      00000000000000950000C8FFD600AEFFAB00AEFFAB0000950000000000000000
      00000000000000000000000000000000000000000000D3967100FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFBF500FEF5ED00FCF0E700E4A26000C7A4
      8C000000000000000000000000000000000000000000B6433000B6433000B643
      3000B6433000B6433000B6433000B6433000B6433000B6433000B6433000B643
      3000B6433000B6433000B6433000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000095000000950000009500000095000000950000000000000000
      00000000000000000000000000000000000000000000D3967100D3967100D396
      7100D3967100D3967100D3967100D5997200D3967100D3967100C7A48C000000
      00000000000000000000000000000000000000000000EB848600D4614700D461
      4700D4614700D4614700D4614700D4614700D4614700D4614700D4614700D461
      4700D4614700D4614700F47D6600000000000000000000000000000000002A2A
      2A00905347002A2A2A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000896B6400896B6400896B6400896B6400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000085695E008F6F5B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A74E
      0700F6B08300DB8C2C000000000000000000000000001327AA000134FD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000896B6400896B6400E8E7E400F9ECDB00F4F5F600F9ECDB00896B6400896B
      6400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000966B4B00CE9F6F00AB784D0085695E000000
      000000000000000000000000000000000000CC670100CC670100CC670100CC67
      0100CC670100CC670100CC670100CC670100CC670100CC670100CC670100CC67
      0100CC670100CC670100CC67010000000000C2600100C2600100C26001009053
      4700F6B08300DB8C2C00C2600100C2600100807EA300193FFA002C66E600464C
      B100C2600100C2600100C260010000000000000000000000000000000000896B
      6400FCF9F400FCF9F400F8D6B700D5B7A400EFBD9500E3DEC000FCF9F400FBEF
      E200896B64000000000000000000000000000000000000000000000000000000
      00000000000000000000966B4B00CAAA8700FFF7C4009463410085695E000000
      000000000000000000000000000000000000CC670100FFFFFF00FFFCF800FFF8
      F000FFF3E700FFF1E300FFECD900FFE9D300FFE5CA00FFE2C500FFDDBB00FFDB
      B500FFD5AB00FFD3A700CC67010000000000C2600100FEFCFB00F9F3ED009053
      4700DAA05C00D7740100FAE1C500F9ECDB00807EA300193FFA002C72ED00464C
      B100FBD7AB00FBD7AB00C2600100000000000000000000000000F8E3CE00FCF9
      F400FAE7D400DAA05C00DAA05C00FCF9F400FCF9F400DE924E00DE924E00E8E7
      E400F9ECDB00896B640000000000000000000000000000000000000000000000
      0000937565008A644C00E7CAA800FFDCB300FFDCB300AF87640055280E006844
      360085695E00000000000000000000000000CC670100FFFFFF00FFFFFF00B3B1
      AF00B3B1AF00FFF3E700ECE0D400B3ADA800B3ADA800FFE5CA00FFE2C500B3AA
      A000B3AAA000FFD4A900CC67010000000000C2600100FEFCFB00FEFCFB009053
      4700DAA05C00D7740100F9ECDB00F9ECDB00807EA3002C66E6003A93F600464C
      B100FBD7AB00FBD7AB00C26001000000000000000000F8E3CE00FCF9F400FAE7
      D400D17B2300DE924E00DE924E00FCF9F400FCF9F400DE924E00DE924E00D17B
      2300E8E7E400FBEFE200896B6400000000000000000000000000BAA79D00BAA7
      9D00D2B69900E7CAA800FDE4BF00FFE9C700FFF8D100F5D6B300D8B89300AD89
      64005E2F150085695E000000000000000000CC670100FFFFFF00FFFFFF004C7A
      FF004C7AFF00FFF8F000F9EEE3009934010099340100FFE9D300FFE5CA000199
      CC000199CC00FFDAB300CC67010000000000C2600100FEFCFB00FEFCFB009053
      4700DAA05C00D7740100F9F3ED00F9F3ED005A5BC5002C72ED0040A4FE00464C
      B100F9DDC200FBD7AB00C26001000000000000000000F8E3CE00FCF9F400DAA0
      5C00DAA05C00DE924E00DE924E00EFBD9500EFBD9500DE924E00DE924E00DE92
      4E00DE924E00FCF9F400896B64000000000000000000C9B6A700E8DBC700EDD5
      B800FFEBCC00F8D6B700C0704F00E9956300DD8D5C00DFA67B00FFE7C300F4D6
      B100D7B6940073472900896F650000000000CC670100FFFFFF00FFFFFF004C7A
      FF004C7AFF00FFFBF600FFF8F0009934010099340100FFECD900FFE9D3000199
      CC000199CC00FFDBB700CC67010000000000C2600100FEFCFB00FEFCFB009053
      4700DE924E00D17B2300F9F3ED00FDF0C600807EA3003A93F60040A4FE00464C
      B100FAE1C500F9DDC200C260010000000000F8E3CE00FCF9F400F9D7C000DAA0
      5C00DE924E00F5A64200DE924E00F9ECDB00E8E7E400DE924E00DE924E00DAA0
      5C00DE924E00E3DEC000FBEFE200896B6400CBB8A200E8DBC700EED8C100FFEF
      D100FFEECF00FFFFE200B4816200790000008F2E0600F7E5C400FFEDCB00FFE7
      C300F5D7B700DABD9B005B2D140000000000CC670100FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFBF600FFFBF600FFF0E200FFF0E200FFECD900FFEC
      D900FFE2C500FFE1C200CC67010000000000C2600100FEFCFB00FEFCFB009053
      4700DE924E00D17B2300F9F3ED00F9F3ED00807EA3003A93F60064C8FE00464C
      B100F9ECDB00F9DDC200C260010000000000F8E3CE00FCF9F400E7C8AC00DE92
      4E00DE924E00DE924E00DE924E00FBEFE200FCF9F400FBCF9F00DE924E00DE92
      4E00DE924E00D5AE9200FCF9F400896B6400C5B2A000E8DBC700FFF0D700FFEC
      D200FFE7CE00FFFFED00CFB295006F000000A4583700FFFFF000FFE7C900FFE5
      C600FFEAC900FCE3C500AD8A6B0090766D00CC670100FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFBF600FFF0E200FFF5EA00FFF0E200FFEC
      D900FFE2C500FFE3C800CC67010000000000C2600100FEFCFB00FEFCFB009053
      4700DE924E00D17B2300C2AAA100FEFCFB008B9BA9005694B5004F5481007470
      A500FAE1C500FAE1C500C260010000000000F8E3CE00FCF9F400F9D7C000DAA0
      5C00DE924E00F5A64200DE924E00DE924E00FBEFE200FCF9F400E3DEC000DAA0
      5C00DB8C2C00EFBD9500FCF9F4007C767300CFBFAE00F8E7D500FFF4DF00FFEC
      D600FFECD600FFFFF300CDAF940074000000A5573600FFFFF100FFE8CF00FFE5
      CA00FFEACF00FFEBD100E4CAAF00886A5C00CC670100FFFFFF00FFFFFF00B3AD
      A800B3ADA800FFFFFF00FFFFFF00B3ADA800B3ADA800FFF8F000FFF5EB00B3AD
      A800B3ADA800FFE9D200CC67010000000000C2600100FEFCFB00FEFCFB009053
      4700C6803A00C6803A00D5B7A400FEFCFB00F9ECDB008B868700EDEBE800C2AA
      A100F9ECDB00F9ECDB00C260010000000000F8E3CE00FCF9F400FAE7D400EFBD
      9500DAA05C00E7C8AC00DAA05C00DE924E00DAA05C00F9ECDB00FCF9F400EBB3
      7300DE924E00E3DEC000FCF9F400896B6400CFC2B700FDEFE000FFF4E300FFEF
      DE00FFF0DC00FFFFFF00D6C1AA0077000000A6583600FFFFF800FFEDD500FFE9
      D000FFECD200FFF2D900ECD7C000866A5C00CC670100FFFFFF00FFFFFF00CC99
      9900CC999900FFFFFF00FFFFFF00E27F0B00E27F0B00FFFCF900FFF8F0000199
      010001990100FFEAD600CC67010000000000C2600100F9F3ED007C767300FEFC
      FB007C7673007C767300C3C2C200EDEBE8008B8687008B868700D1D1CB008B86
      8700F8E3CE00F9ECDB00C26001000000000000000000F8E3CE00FCF9F400E3DE
      C000EBB37300FCF9F400F9ECDB00DAA05C00F9B74F00E8E7E400FCF9F400EBB3
      7300DAA05C00FBEFE200CEBAB30000000000D0C7BD00FDF5E900FFF8EB00FFF2
      E600FFFDEF00EFE6DA008C3D1E00650000008C3C2300FFFFFE00FFF0DD00FFEB
      D600FFEED900FFFAE500F2DEC900977E7200CC670100FFFFFF00FFFFFF00CC99
      9900CC999900FFFFFF00FFFFFF00E27F0B00E27F0B00FFFFFF00FFFCF9000199
      010001990100FFF0E100CC67010000000000C26001007C767300D5D9DA00896B
      640098989800A2A3A400989898008B868700F9F3ED00D5D9DA00D5D9DA00EDEB
      E8008B868700F9ECDB00C26001000000000000000000F8E3CE00FCF9F400F9EC
      DB00F8D6B700F9D7C000FCF9F400FBEFE200FBEFE200FCF9F400E3DEC000DB8C
      2C00FAE7D400FCF9F400CEBAB30000000000DFD4C800F7F4EF00FFFFF900FFF6
      EC00FFFFF900E6D9C900B3938200BAA59A00C2AEA300FFFFF800FFF4E300FFEE
      DC00FFFAEB00FFFFFC00E2CAB400977E7200CC670100FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFE00FFF9
      F300FFF8EF00FFF2E500CC67010000000000C26001007C767300D5D9DA00D5D9
      DA007C767300B6B4B200C3C2C2008B868700C3C2C200A2A3A4008B868700EDEB
      E8008B868700F9F3ED00C2600100000000000000000000000000F8E3CE00FCF9
      F400FBEFE200E3DEC000F9ECDB00FBEFE200F9ECDB00E3DEC000DAA05C00FAE7
      D400FCF9F400CEBAB300000000000000000000000000E4E5E500FFFFFF00FFFF
      FA00FFFBF300FFFFFF00FFFFFA00F9C8A600FFFEEE00FFFFFF00FFF5E800FFFA
      EF00FFFFFF00FFFFFF00AF97870000000000CC670100DF7B0100DF7B0100DF7B
      0100DF7B0100DF7B0100DF7B0100DF7B0100DF7B0100DF7B0100DF7B0100DF7B
      0100DF7B0100DF7B0100CC67010000000000C2600100D5D9DA0098989800A2A3
      A400989898009FA5C300B6B4B200C3C2C200AFAFAF00D7740100D7740100D5D9
      DA00B1867A00D7740100C260010000000000000000000000000000000000F8E3
      CE00FCF9F400FCF9F400FAE7D400F8D6B700E7C8AC00F9D7C000FCF9F400FCF9
      F400F8E3CE000000000000000000000000000000000000000000EDEDEF00FFFF
      FF00FFFFFF00FFFFFF008E574E005D0000009A452800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D1BDAD000000000000000000CE690100CF6A0100CF6A0100CF6A
      0100CF6A0100CF6A0100CF6A0100CF6A0100CF6A0100CF6A0100CF6A0100CF6A
      0100CF6A0100CF6A0100CE6F0E0000000000C2600100C2600100C2600100896B
      6400896B64007C767300896B6400C2600100896B6400C2600100D7740100896B
      6400C2600100C2600100C2600100000000000000000000000000000000000000
      0000F8E3CE00F8E3CE00FCF9F400FCF9F400FCF9F400FCF9F400F8E3CE00F8E3
      CE0000000000000000000000000000000000000000000000000000000000F2F4
      F500FFFFFF00FFFFFF00D7CEC90062414400C5B5AF00FFFFFF00FFFFFF00FFFF
      FE00E8DED500000000000000000000000000C9BDAD00D2741400D2741400D274
      1400D2741400D2741400D2741400D2741400D2741400D2741400D2741400D274
      1400D2741400D2741400CAB7A00000000000C2600100D7740100D7740100D774
      0100CF741500D7740100D7740100D7740100CF741500D7740100D7740100CF74
      1500D7740100D7740100C2600100000000000000000000000000000000000000
      00000000000000000000F8E3CE00E8E7E400F8E3CE00F8E3CE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EAE3DC00F6F3EF00FBF8F400FBF8F400FBF8F400FBF8F400D8CBC3000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000006A1
      D0000FA3D20023AAD70006A1D000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009DCBE50069B1
      DC0096C7E000D5E8ED0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000090645E009064
      5E0090645E0090645E0090645E0090645E0090645E0090645E0090645E009064
      5E0090645E0090645E0090645E00000000000000000000000000BF3D4500DE5A
      5A00DE5A5A00ACAAA800ACAAA800ACAAA800ACAAA800ACAAA800ACAAA800BF3D
      4500BF3D4500DE5A5A00DE5A5A000000000000000000000000000000000006A1
      D00006A1D0007AD6F60053C4E90006A1D00006A1D00006A1D000000000000000
      00000000000000000000000000000000000000000000A7D6E8003CA1D9000000
      000000000000A9CFE300B1D4E500000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C685B00ECBE
      A800EAB39B00E8AE9200E8AE9200E8AE9200E8AE9200E8AE9200E8AE9200E8AE
      9200E8AE9200E8AE920090645E000000000000000000B88F7F00DD7E7700DD7E
      7700DE5A5A00AEA19B00CEBAB300FEC2BA00FEFCFB00F3F1EE00DDE3E200BF3D
      4500BF3D4500DD7E7700DE5A5A000000000000000000000000000000000006A1
      D00006A1D000ADECFF0087E5FF0084E3FC0076DBF60063CDED0006A1D00006A1
      D00000000000000000000000000000000000000000006DC2E5007AC3DF000000
      000000000000BBAD9D00BA894D00C98B2F00D2952F00CF8E2B00BD813400B195
      78000000000000000000000000000000000000000000000000009C685B00FAD9
      BB00FAD9BB00F9D0B900F9D0B900F0D3AE00F9D0A600F9D0A600F5CAA600FAC9
      9A00FAC99A00E8AE920090645E000000000000000000B88F7F00DD7E7700DD7E
      7700DE5A5A00CEBAB300DD7E7700C99B8200D5D9DA00FEFCFB00F3F1EE00BF3D
      4500BF3D4500DD7E7700DE5A5A000000000006A1D00006A1D00006A1D00006A1
      D00006A1D000BDF0FC008EECFF008EECFF008EECFF008EECFF008BEAFD007EE1
      F70006A1D00006A1D00000000000000000000000000070CCE90056B8DC000000
      00007B584000C1700900E8A72A00F5D05E00FBE37E00F5D46600EBAE2F00CC7D
      0D008A4F19000000000000000000000000000000000000000000A2706200FADD
      C300FAD9BB00FAD9BB00F9D0B900F0D3AE00F0D3AE00F9D0A600F5CAA600FAC9
      9A00FAC99A00EAB39B0090645E000000000000000000B88F7F00DD7E7700DD7E
      7700DE5A5A00CEC9C300DE5A5A00B1867A00B6B4B200D5D9DA00FEFCFB00BF3D
      4500BF3D4500DD7E7700DE5A5A000000000006A1D00006A1D0009DE4FC0006A1
      D00053BFEA0006A1D000AAF8FF009BF7FF009BF7FF009BF7FF009BF7FF009BF7
      FF0083DEFE0006A1D0000000000000000000000000008DE5F40019A7E0006A59
      48009B4D0300D2820D00E9A92900E6B94A00BF9D4B00C9A04300E7AB2B00D58A
      0E00BE6A04006A38100000000000000000000000000000000000B17E6600FADF
      C900FADDC300FAD9BB00FAD9BB00F9D0B900F9D0B900F0D3AE00F0D3AE00CBB6
      AD00C9AAA5009D9A970090645E000000000000000000B88F7F00DD7E7700DD7E
      7700DE5A5A00CEC9C300BF9C9300B6B4B200ACAAA800B6B4B200D1D1CB00BF3D
      4500BF3D4500DD7E7700DE5A5A000000000006A1D00006A1D0009BE0F30006A1
      D00065C7F30006A1D000BAFCFE00A1FDFF00A1FDFF00A1FDFF00A1FDFF00A1FD
      FF0088E0FF0093E1F30006A1D0000000000000000000A3F8FB0025B5EB005379
      7500A5520200C3740700CD8E1C00AAA393000000000000000000B08A4D00CE84
      0B00BC6805008B46040061534B00000000000000000000000000B17E6600F9E3
      CF00FADFC900FADDC300FADDC300FAD9BB00F9D0B900F9D0B900CBB6AD00B9A2
      9F009D9A9700C9AAA50090645E000000000000000000B88F7F00DD7E7700DD7E
      7700DD7E7700DD7E7700DD7E7700DD7E7700DD7E7700DD7E7700DD7E7700DD7E
      7700DD7E7700DD7E7700DE5A5A000000000006A1D00006A1D0008FD3E90006A1
      D0006DD0FA0006A1D000ACE4F200C9FDFE00C1FFFF00B5FFFF00B0FFFF00B0FF
      FF008EE1FF00C2F6FE0006A1D0000000000000000000BBF5F70059C8E4001FAF
      DF00965C1B00A0590300A1733200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD876D00F9E8
      D500F9E3CF00FADFC900FADDC300FADDC300FAD9BB00CBB6AD00B9A29F009D9A
      9700B9A29F00C9AAA50090645E000000000000000000B88F7F00DD7E7700DD7E
      7700D18D8C00D18D8C00D18D8C00D18D8C00D18D8C00D18D8C00D18D8C00D18D
      8C00DD7E7700DD7E7700DE5A5A000000000006A1D0005BC0E90006A1D00006A1
      D00081DFFE0072D7F70006A1D00006A1D00006A1D000D5F6FA00D2FFFF00CCFF
      FF0098E1FF00D8F8FF00D8F8FF0006A1D000000000000000000057ABAA0031BB
      E800529A9800824802009C601100B4853300BA893500BC8C3800BA8C3500AC81
      340099702F007E5B2E00513C2E00000000000000000000000000C4917100F9E8
      D500F9E3CF00F9E3CF00FADFC900FADFC900C9AAA5009D9A97009D9A9700B9A2
      9F00CBB6AD00ECBEA80090645E000000000000000000B88F7F00DD7E7700D18D
      8C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D18D8C00DD7E7700DE5A5A000000000006A1D00080D4FC0006A1D00006A1
      D00094F0FF0094F0FF0094F0FF0094F0FF0084E5F70006A1D00006A1D00006A1
      D00006A1D00006A1D00006A1D00006A1D0000000000000000000487570005FBA
      C1002EBDEE00636E4A00713E0500AC6B0800BE7C0E00C4830F00C5880F00C786
      0300AC6F01008550020041210200000000000000000000000000D1967100FCEE
      DF00F9E8D500F9E8D500F9E8D500F9E3CF0014131300594F46009D9A9700C3BD
      B800FAD9BB00FADFC90090645E000000000000000000B88F7F00DD7E7700D18D
      8C00FFFFFF00CEC9C300C3C2C200C3C2C200C3C2C200C3C2C200CEC9C300FFFF
      FF00D18D8C00DD7E7700DE5A5A000000000006A1D00085DAFF0006A1D00006A1
      D000AAFCFF00A1FDFF00A1FDFF00AAFCFF00A5F0F900A5F0F900A5F0F900A5F0
      F90006A1D00000000000000000000000000000000000000000004C474200518F
      7D005AC7DB003DB8DE0069645100000000000000000000000000B1A68700B882
      0700AC750500936407004F341500000000000000000000000000D1967100FCF1
      E400FCEDD900F9E8D500F9E8D500F9E8D500594F460014131300594F4600128F
      12000D720800128F1200845251000000000000000000B88F7F00DD7E7700D18D
      8C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D18D8C00DD7E7700DE5A5A000000000006A1D00090E5FF006BD3F20006A1
      D000D0F8FC00CAFFFF00C1FFFF00C7F6FA0006A1D00006A1D00006A1D00006A1
      D00006A1D00000000000000000000000000000000000000000008E908F004F3C
      14005EA38A0058C9E5003FAAC400A6B0AF000000000000000000A5894600BB8D
      1800B6881500976D10007C716100000000000000000000000000D1967100FCF1
      E400FCEEDF00FCEEDF00FCEDD900F9E8D500F9E8D500594F4600128F120014A6
      0F001EBE18001EBE1800128F12000000000000000000B88F7F00DD7E7700D18D
      8C00FFFFFF00CEC9C300C3C2C200C3C2C200C3C2C200C3C2C200CEC9C300FFFF
      FF00D18D8C00DD7E7700DE5A5A000000000006A1D0009EF1FF0092F0FE0081E6
      F40006A1D00006A1D00006A1D00006A1D00080E6F20006A1D000000000000000
      0000000000000000000000000000000000000000000000000000000000005146
      3800816636007BA58A005CCCE5004DABBA0085764C0090784300AF904700BE9B
      4100B9933800765B270000000000000000000000000000000000D1967100FEF8
      ED00FCF1E400FCF1E400FCEDD900FCEDD900F9E8D500128F12001EBE180039C3
      340039C334001EBE18001EBE1800128F120000000000B88F7F00DD7E7700D18D
      8C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D18D8C00DD7E7700DE5A5A000000000006A1D000BAFCFF00A4FFFF00A1FF
      FF00AEFCFE00BAF2F900A9EBF6009EEDF60085EAF40006A1D000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000061564A00A4917100B1B69C007BCDDF005DC1D300C7C2A100CFBA8D00C0AA
      7B00836F4C000000000000000000CCE0E6000000000000000000D1967100FFFB
      F300FDF4EA00FCF1E400FCF1E400FCEEDF00FCEEDF000D72080039C3340061DC
      5C0061DC5C0061DC5C001EBE18000D72080000000000B88F7F00DD7E7700D18D
      8C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D18D8C00DD7E7700DE5A5A000000000006A1D000B6EAF400A7F0F700AEF5
      FA00AFEAF40006A1D00006A1D00006A1D00006A1D00006A1D000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009093910095938900B7B4A9008EC3D00050BEDD0098AFAB009B98
      8E00000000000000000000000000BDD7E2000000000000000000D1967100FEFD
      F700FEF8ED00FEF8ED00FDF4EA00FCF1E400FCF1E400128F120061DC5C0092E2
      8B0092E28B0061DC5C0039C33400128F120000000000B88F7F00BF3D4500D18D
      8C00ACAAA800ACAAA800ACAAA800ACAAA800ACAAA800ACAAA800ACAAA800ACAA
      A800D18D8C00BF3D450000000000000000000000000006A1D00006A1D00006A1
      D00006A1D0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000085D4EE0081CE
      EB00C2E1EB00E0EDEF00D5E7EC009DC6DB000000000000000000D1967100FFFF
      FF00FFFBF300FFFBF300FEF8ED00FDF4EA00FDF4EA00FCF1E400128F1200D1F8
      D000BFE7BE0088D38000128F1200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000AFD9EA009ACBE4009BC9DF00000000000000000000000000D1967100D196
      7100D1967100D1967100D1967100D1967100D1967100D1967100D1967100128F
      12000D720800128F12000000000000000000424D3E000000000000003E000000
      2800000040000000600000000100010000000000000300000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000E7E3FFFF80030000C3C3C00180030000
      C183800080030000E007000080030000E007000080030000F00F000080030000
      E007000080030000C00300008003000080010000800300000000000080030000
      0000000080030000F800000180030000F801000380030000F80780FF80070000
      FC47C1FF800F0000FE6FFFFF801F0000FFFFC003FFFFC7C700018001CFF3C387
      00019249F7EFC10700019001C003E00F000180019FF9E00F000180019E79F00F
      0001900193F9C0070001980193F90001000180019FC900010001FFFF9FC90001
      0001E0479FF9F83F0001E407C003FC3F0001C407FE7FFC7F0001C047F99FFC7F
      000183FFE7E7FE7FFFFFD7FFFFFFFFFF8FFFFFFF80038FFF87FFF83F800387FF
      83FFF83F800383FFC1FFF83F8003C1FFE0FFF83F80038001F003F83F80038001
      F801000180038001FC00000180038001FC00000180038001FC00000180038001
      FC00000180038001FC00F83F80038001FC00F83F80038001FE01F83F80078001
      FF03F83F800F8001FFFFF83F801F8001E3FFFC3FFF3FFFFFE39FF00FFE1F0001
      0001E007FC1F00010001C003F007000100018001C00300010001800180010001
      0001000000010001000100000000000100010000000000010001000000000001
      000180010000000100018001000000010001C003800100010001E007C0030001
      0001F00FE00700010001FC3FF01FFFFFFFFFE1FFC3FFC001C001E03F99FFC001
      8001E00F980FC001800100039007C001800100038003C0018001000180C1C001
      8001000181FFC00180010000C001C00180010000C001C00180010007C1C1C001
      80010007C0C1C0018001003FE003C0008001003FF006C0008001003FF80EC000
      800387FFFFC0C001FFFFFFFFFFF1C003}
  end
  object TimerGetNicoVideoData: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = TimerGetNicoVideoDataTimer
    Left = 24
    Top = 381
  end
end
