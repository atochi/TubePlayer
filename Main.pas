unit Main;
(* Copyright (c) 2009-2010 Jane, Inc. <info@janesoft.net> *)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, ActiveX,
  AppEvnts, Menus, ExtCtrls, ComCtrls, StdCtrls, ImgList,
  OleServer,  IniFiles, ShellAPI, IMM, StrUtils, Clipbrd, DateUtils, Registry,
  //WSH
  VBScript_RegExp_55_TLB,
  //EmbeddedWB
  EmbeddedWB, EwbCore,
  //XML
  SHDocVw_EWB, xmldom, XMLIntf, msxmldom, XMLDoc, oxmldom,
  //TNT
  TntActnList, ActnList, TntStdCtrls,
  //ToolBar2000
  TB2Item, TB2Toolbar, TB2Dock, TB2ExtItems,
  //TBX
  TBXDkPanels,
  //SpTBXLib
  SpTBXSkins, SpTBXItem, SpTBXDkPanels, SpTBXEditors, SpTBXControls,
  SpTBXCustomizer,
  //SpTBXLib_skins
  spSkinGold, spSkinGreener, spSkinHackerBW, spSkinVistaBlue,
  //etc
  SHDocVw_TLB, MSHTML_TLB, //css書き換え用
  CommonUtils,
  //IdCookie, //セッション取得用
  WinInet, URLMon, //Proxy切り替え用
  FileVerInfo, UAsync, USynchro, USharedMem, StrSub, HTTPSub, JLTrayIcon,
  HogeListView, Config, UFavorite, UXMLSub, VirtualTrees;

const
  VERSION  = '2.30β';
  APPLICATION_NAME  = 'TubePlayer';

  DISTRIBUTORS_SITE = 'http://janesoft.net/tube/';
  UPDATE_CHECK_URI  = 'http://janesoft.net/tube/version.txt'; 
  COPYRIGHT         = 'Copyright (C) 2009-2010 Jane, Inc.';
  COPYRIGHT2        = 'Copyright (C) 2007-2009 ◆Style/kK.s.';

  JANE_BBS_URI = 'http://jbbs.livedoor.jp/internet/8173/';

  USERAGENT = 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0)';

  LAYOUT_INI   = 'layout.ini';
  CHECK_DAT    = 'check.dat';
  URLEXEC_DAT  = 'URLExec.dat';
  HISTORY_TXT  = 'SearchHistory.txt';
  MTOOLIMG_BMP = 'mtoolimg.bmp';
  SKINS_FOLDER = 'skins/';

  FAVORITES_DAT         = 'favorites.dat';
  FAVORITES_DAT_BAK     = 'favorites.dat.bak';
  FAVORITES_DAT_BAK2    = 'favorites.dat.bak2';
  FAVORITES_DAT_BAK3    = 'favorites.dat.bak3';

  RECENTLY_VIEWED_DAT = 'RecentlyViewed.dat';

  //ビデオ情報パネル用
  HEADER_HTML_TEMPLATE = 'Header.html';
  RES_HTML_TEMPLATE    = 'Res.html';
  FOOTER_HTML_TEMPLATE = 'Footer.html';

  //関連ビデオパネル用
  R_HEADER_HTML_TEMPLATE  = 'R_Header.html';
  R_CONTENT_HTML_TEMPLATE = 'R_Content.html';
  R_FOOTER_HTML_TEMPLATE  = 'R_Footer.html';

  //検索パネル用
  S_HEADER_HTML_TEMPLATE  = 'S_Header.html';
  S_CONTENT_HTML_TEMPLATE = 'S_Content.html';
  S_FOOTER_HTML_TEMPLATE  = 'S_Footer.html';

  TRUEFALSE: array[0..1] of string = ('false', 'true');

  FLASH_QUALITY: array[0..4] of string
    = ('low',
       'high',
       'autolow',
       'autohigh',
       'best');

  URI_TARGET: array[0..4] of string
    = ('http://(?:ime\.nu/)?(?:[^/]+\.)?youtube\.com/(?:(?:verify_age\?next_url=/)?(?:w/)?(?:watch)?(?:\?|%3F).*v(?:=|%3D)|(?:.+?/)?v/|vi/|.+?[?&]video_id=)([\w\-]{11})(?:&(?:.+))?',
       'http://(?:ime\.nu/)?(?:\w+\.)?youtube\.com/v/(.+)',
       'http://(?:ime\.nu/)?(?:www\.)?nicovideo\.jp/watch\?v=([^&#]+)(?:.+)?',
       'http://(?:ime\.nu/)?(?:www.flog.jp/w.php/http://)?(?:www\.)?nicovideo\.jp/watch/([^/]+)(?:.+)?',
       'http://(?:ime\.nu/)?(?:www\.)?nicovideo\.jp/redir\?p=(.+)');

  GET_TITLE     = '<title>(.+)<\/title>';
  GET_YOUTUBE_TITLE  = 'content="([^"]+)"';
  GET_NICO_TITLE  = '‐ニコニコ動画\([^)]+\)';

  GET_USER_ITEM = 'http://gdata.youtube.com/feeds/api/users/(.+)';
  GET_ICHIBA_ITEM = 'http://ichiba.nicovideo.jp/item/(.+)';
  GET_ICHIBA_RELATION = 'http://ichiba.nicovideo.jp/relationvideo/';
  GET_MYLIST = 'http://www.nicovideo.jp/mylist/(?:\d+)(?:/\d+)?';

  //YouTube
  (*
  //embedの規定値
  YOUTUBE_DEFAULT_WIDTH   = 425;
  YOUTUBE_DEFAULT_HEIGHT  = 350;
  *)

  //mp4のformat
  YOUTUBE_MP4_FMT = '&fmt=18';

  //player2の規定値
  YOUTUBE_DEFAULT_WIDTH2  = 450;
  YOUTUBE_DEFAULT_HEIGHT2 = 370;

  YOUTUBE_GET_VIDEOID   = '&t=([^&]+)&';
  YOUTUBE_GET_PLAYER = '<param\s+name=\\"movie\\"\s+value=\\"(.+?)\\">';
  YOUTUBE_GET_FLASHVARS = '<param\s+name=\\"flashvars\\"\s+value=\\"(.+?)\\">';
  YOUTUBE_GET_FLASHVARS_ADS = '(&ad_[^=]+=)[^&]+';
  YOUTUBE_GET_FLASHVARS_EDIT = '(&iv_module=[^&]+)_edit([^&]+)';

  YOUTUBE_GET_URI_FRONT = 'http://gdata.youtube.com/feeds/api/videos';
  YOUTUBE_GET_SEARCH_URI_FRONT  = YOUTUBE_GET_URI_FRONT;
  YOUTUBE_GET_DETAILS_URI_FRONT = YOUTUBE_GET_URI_FRONT + '/';
  YOUTUBE_GET_RELATED_URI_FRONT = YOUTUBE_GET_DETAILS_URI_FRONT;
  YOUTUBE_GET_RELATED_URI_BACK = '/related';

  YOUTUBE_GET_VIDEO_URI    = 'http://www.youtube.com/get_video?&video_id=';
  YOUTUBE_USER_PROFILE_URI = 'http://www.youtube.com/user/';

  YOUTUBE_GET_WATCH_URI    = 'http://www.youtube.com/watch?v=';

  YOUTUBE_LOGIN_URI        = 'http://www.youtube.com/login';
  YOUTUBE_LOGOUT_URI       = 'http://www.youtube.com/#';
  YOUTUBE_VERIFY_AGE_URI   = 'http://www.youtube.com/verify_age';

  YOUTUBE_URI   = 'http://www.youtube.com/';
  YOUTUBE_VIDEO_PLAYER  = 'http://www.youtube.com/v/'; //jpは070620現在ない

  YOUTUBE_GET_STANDARDFEEDS_URI_BASE = 'http://gdata.youtube.com/feeds/api/standardfeeds';
  YOUTUBE_GET_STANDARDFEEDS_URI = YOUTUBE_GET_STANDARDFEEDS_URI_BASE + '/JP';
  YOUTUBE_GET_FEATURED_ALL_URI = YOUTUBE_GET_STANDARDFEEDS_URI_BASE + '/recently_featured';
  YOUTUBE_GET_POPULAR_ALL_URI_FRONT = YOUTUBE_GET_STANDARDFEEDS_URI_BASE + '/most_viewed';
  YOUTUBE_GET_RECENT_URI = YOUTUBE_GET_STANDARDFEEDS_URI + '/most_recent';
  YOUTUBE_GET_POPULAR_URI_FRONT = YOUTUBE_GET_STANDARDFEEDS_URI + '/most_viewed';
  YOUTUBE_GET_RATED_URI_FRONT = YOUTUBE_GET_STANDARDFEEDS_URI + '/top_rated';
  YOUTUBE_GET_DISCUSSED_URI_FRONT = YOUTUBE_GET_STANDARDFEEDS_URI + '/most_discussed';
  YOUTUBE_GET_FAVORITES_URI_FRONT = YOUTUBE_GET_STANDARDFEEDS_URI + '/top_favorites';
  YOUTUBE_GET_LINKED_URI_FRONT = YOUTUBE_GET_STANDARDFEEDS_URI + '/most_linked';
  YOUTUBE_GET_RESPONDED_URI_FRONT = YOUTUBE_GET_STANDARDFEEDS_URI + '/most_responded';

  YOUTUBE_GET_SEARCH_URI = 'http://www.youtube.com/results?search_type=search_videos&search_query=';

  //nicovideo
  //規定値
  NICOVIDEO_DEFAULT_WIDTH  = 545;
  NICOVIDEO_DEFAULT_HEIGHT = 413;

  NICOVIDEO_GET_ID = 'nicoplayer\.swf\?([^\"]+)\"';
  NICOVIDEO_URI = 'http://www.nicovideo.jp/';
  NICOVIDEO_BLOG_URI = 'http://blog.nicovideo.jp/';
  NICOVIDEO_ICHIBA_URI = 'http://ichiba.nicovideo.jp/';
  NICOVIDEO_ICHIBA_RANK_URI = 'http://ichiba.nicovideo.jp/ranking/';
  NICOVIDEO_GET_URI = 'http://www.nicovideo.jp/watch/';
  NICOVIDEO_GET_URI_AFTER = '?oldplayer=1';
  NICOVIDEO_GET_VIDEO_URI = 'http://www.nicovideo.jp/api/getflv?v=';
  NICOVIDEO_RESOURCE_URI = 'http://res.nicovideo.jp/';
  NICOVIDEO_PLAYER_URI = 'http://www.nicovideo.jp/swf/';

  NICOVIDEO_MYLIST_URI = 'http://www.nicovideo.jp/mylist/';

  NICOVIDEO_GET_SEARCH_URI = 'http://www.nicovideo.jp/search/';
  NICOVIDEO_GET_SEARCH_TAG_URI = 'http://www.nicovideo.jp/tag/';

  NICOVIDEO_GET_ICHIBA1 = 'http://ichiba1.nicovideo.jp/embed/?action=showMain&v=';
  NICOVIDEO_GET_ICHIBA2 = 'http://ichiba2.nicovideo.jp/embed/?action=showMain&v=';
  NICOVIDEO_GET_ICHIBA3 = 'http://ichiba3.nicovideo.jp/embed/?action=showMain&v=';
  NICOVIDEO_GET_ICHIBA4 = 'http://ichiba4.nicovideo.jp/embed/?action=showMain&v=';

  NICOVIDEO_LOGIN_URI  = 'https://secure.nicovideo.jp/secure/login?site=niconico';
  NICOVIDEO_LOGOUT_URI = 'https://secure.nicovideo.jp/secure/logout';

  //Amazon
  AMAZON_AWS_URI_FRONT = 'http://webservices.amazon.co.jp/onca/xml?Service=AWSECommerceService&SubscriptionId=12958Y8JSAP3473V5WG2&AssociateTag=';

  AMAZON_AWS_TAG_NICO = 'nicovideojp-22'; //ニワンゴのタグ
  AMAZON_AWS_TAG_TUBE = 'janesoft-22';    //ジェーンのタグ

  AMAZON_AWS_URI_BACK = '&Version=2005-10-05&Operation=ItemLookup&ResponseGroup=Small,OfferSummary,ItemAttributes,Reviews,Images&ContentType=text/xml&IdType=ASIN&ItemId=';

  //Ameba Vision
  AMEBAVISION_URI = 'http://vision.ameba.jp/watch.do?movie=';

  //ソート
  LVSC_NUMBER         = 1;
  LVSC_TITLE          = 2;
  LVSC_PLAYTIME       = 3;
  LVSC_RATING_AVG     = 4;
  LVSC_RATING_COUNT   = 5;
  LVSC_VIEW_COUNT     = 6;
  LVSC_SPEED          = 7;
  LVSC_AUTHOR         = 8;
  LVSC_UPLOAD_TIME    = 9;
  LVSC_VIDEOID        = 10;

  //ビデオ情報パネル
  DEFAULT_HEADER =  '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'+ #13#10 +
                    '<html lang="ja">'+ #13#10 +
                    '<head>'+ #13#10 +
                    '<meta http-equiv="content-style-type" content="text/css">'+ #13#10 +
                    '<meta http-equiv="content-type" content="text/html; charset=Shift_JIS">'+ #13#10 +
                    '<link rel="stylesheet" href="Default.css" type="text/css">'+ #13#10 +
                    '<style type="text/css">'+ #13#10 +
                    '<!-- span.bold{font-weight: bold;} span.red{color: red;} dl{margin: 0;} dd{margin-left: 10px;} -->'+ #13#10 +
                    '</style>'+ #13#10 +
                    '<title>TubePlayer</title>'+ #13#10 +
                    '</head>'+ #13#10 +
                    '<body>'+ #13#10 +
                    '投稿者:<span class="bold">$AUTHOR_LINK</span><br>'+ #13#10 +
                    '追加日:<span class="bold">$UPLOAD_TIME</span><br>'+ #13#10 +
                    '再生時間:<span class="bold">$PLAYTIME</span><br>'+ #13#10 +
                    '評価:<span class="red">$RATING</span> ($RATING_COUNT 件の評価)<br>'+ #13#10 +
                    '再生回数:<span class="bold">$VIEW_COUNT</span><br>'+ #13#10 +
                    'コメント数:<span class="bold">$COMMENT_COUNT</span><br>'+ #13#10 +
                    'お気に入り登録:<span class="bold">$FAVORITED_COUNT</span><br>'+ #13#10 +
                    '<br>'+ #13#10 +
                    '<span class="bold">コメントと動画レスポンス</span>'+ #13#10 +
                    '<dl>';

  DEFAULT_RES    =  '<dt><span class="bold">$NAME_LINK</span><br>$DATE</dt>'+ #13#10 +
                    '<dd>$MESSAGE<br><br></dd>';

  DEFAULT_FOOTER =  '</dl>'+ #13#10 +
                    '<span class="bold"><a href="http://www.youtube.com/comment_servlet?all_comments&v=$VIDEOID">$COMMENT_COUNT 件すべてのコメントを表示</a></span><br>'+ #13#10 +
                    '<br>' + #13#10 +
                    'powered by <a href="http://www.youtube.com">YouTube</a><br>' + #13#10 +
                    '</body>'+ #13#10 +
                    '</html>';

  //関連ビデオパネル
  R_DEFAULT_HEADER =  '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'+ #13#10 +
                      '<html lang="ja">'+ #13#10 +
                      '<head>'+ #13#10 +
                      '<meta http-equiv="content-style-type" content="text/css">'+ #13#10 +
                      '<meta http-equiv="content-type" content="text/html; charset=Shift_JIS">'+ #13#10 +
                      '<style type="text/css">'+ #13#10 +
                      '<!-- span.bold{font-weight: bold;} dl{margin: 0;} dd{margin-left: 10px;} td{font-size: smaller;} img{width:91px; height:68px;} -->'+ #13#10 +
                      '</style>'+ #13#10 +
                      '<title>TubePlayer</title>'+ #13#10 +
                      '</head>'+ #13#10 +
                      '<body>'+ #13#10 +
                      '<table>';

  R_DEFAULT_CONTENT = '<tr><td><a href ="http://youtube.com/watch?v=$VIDEOID"><img src="$THUMBNAIL_URL1" alt="$VIDEOTITLE"></a></td>'+ #13#10 +
                      '<td><span class="bold"><a href ="http://youtube.com/watch?v=$VIDEOID">$VIDEOTITLE</a></span><br>'+ #13#10 +
                      '<span class="bold">$PLAYTIME</span><br>'+ #13#10 +
                      '投稿者:<span class="bold">$AUTHOR_LINK</span><br>'+ #13#10 +
                      '再生回数:<span class="bold">$VIEW_COUNT</span>'+ #13#10 +
                      '</td></tr>';

  R_DEFAULT_FOOTER =  '</table>'+ #13#10 +
                      '<br>' + #13#10 +
                      'powered by <a href="http://www.youtube.com">YouTube</a><br>' + #13#10 +
                      '</body>'+ #13#10 +
                      '</html>';

  //検索パネル(YouTube)
  S_DEFAULT_HEADER =  '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'+ #13#10 +
                      '<html lang="ja">'+ #13#10 +
                      '<head>'+ #13#10 +
                      '<meta http-equiv="content-style-type" content="text/css">'+ #13#10 +
                      '<meta http-equiv="content-type" content="text/html; charset=Shift_JIS">'+ #13#10 +
                      '<style type="text/css">'+ #13#10 +
                      '<!-- span.bold{font-weight: bold;} span.red{color: red;} dl{margin: 0;} dd{margin-left: 10px;} td{font-size: smaller;} img{width:130px; height:97px;} -->'+ #13#10 +
                      '</style>'+ #13#10 +
                      '<title>TubePlayer</title>'+ #13#10 +
                      '</head>'+ #13#10 +
                      '<body>'+ #13#10 +
                      '<table>';

  S_DEFAULT_CONTENT = '<tr><td><a href ="http://youtube.com/watch?v=$VIDEOID"><img src="$THUMBNAIL_URL1" alt="$VIDEOTITLE"></a></td>'+ #13#10 +
                      '<td><a href ="http://youtube.com/watch?v=$VIDEOID"><img src="$THUMBNAIL_URL2" alt="$VIDEOTITLE"></a></td>'+ #13#10 +
                      '<td><a href ="http://youtube.com/watch?v=$VIDEOID"><img src="$THUMBNAIL_URL3" alt="$VIDEOTITLE"></a></td>'+ #13#10 +
                      '<td><span class="bold"><a href ="http://youtube.com/watch?v=$VIDEOID">$VIDEOTITLE</a></span><br>'+ #13#10 +
                      '追加日:<span class="bold">$UPLOAD_TIME</span><br>' + #13#10 +
                      '投稿者:<span class="bold">$AUTHOR_LINK</span><br>'+ #13#10 +
                      '<span class="bold">$PLAYTIME</span><br>'+ #13#10 +
                      '評価:<span class="red">$RATING</span><br>'+ #13#10 +
                      '再生回数:<span class="bold">$VIEW_COUNT</span>'+ #13#10 +
                      '</td></tr>';

  S_DEFAULT_FOOTER =  '</table>'+ #13#10 +
                      '<br>' + #13#10 +
                      'powered by <a href="http://www.youtube.com">YouTube</a><br>' + #13#10 +
                      '</body>'+ #13#10 +
                      '</html>';

  //検索パネル(ニコニコ動画)
  NICO_DEFAULT_HEADER  = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"'+ #13#10 +
                         '"http://www.w3.org/TR/html4/loose.dtd">'+ #13#10 +
                         '<html lang="ja">'+ #13#10 +
                         '<head>'+ #13#10 +
                         '<meta http-equiv="content-style-type" content="text/css">'+ #13#10 +
                         '<meta http-equiv="content-type" content="text/html; charset=Shift_JIS">'+ #13#10 +
                         '<base href="http://www.nicovideo.jp/">'+ #13#10 +
                         '<link rel="stylesheet" type="text/css" href="http://res.nicovideo.jp/css/common.css" charset="utf-8">'+ #13#10 +
                         '<title>TubePlayer</title>'+ #13#10 +
                         '</head>'+ #13#10 +
                         '<body style="background:">';

  NICO_DEFAULT_FOOTER  = '<br>'+ #13#10 +
                         'powered by <a href="http://www.nicovideo.jp">ニコニコ動画</a><br>' + #13#10 +
                         '</body>'+ #13#10 +
                         '</html>';

  //ニコニコ市場検索パネル用
  NICO_ICHIBA_HEADER2  = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"'+ #13#10 +
                         '"http://www.w3.org/TR/html4/loose.dtd">'+ #13#10 +
                         '<html lang="ja">'+ #13#10 +
                         '<head>'+ #13#10 +
                         '<meta http-equiv="content-style-type" content="text/css">'+ #13#10 +
                         '<meta http-equiv="content-type" content="text/html; charset=Shift_JIS">'+ #13#10 +
                         '<style type="text/css">'+ #13#10 +
                         '<!-- *{margin: 0; padding: 0;} body{margin: 5px;} img{border: 0;} tr td{vertical-align: top;}>'+ #13#10 +
                         '</style>'+ #13#10 +
                         '<title>TubePlayer</title>'+ #13#10 +
                         '</head>'+ #13#10 +
                         '<body>'+ #13#10 +
                         '<table>';

  NICO_ICHIBA_FOOTER2  = '</table>'+ #13#10 +
                         '<br>'+ #13#10 +
                         'powered by <a href="' + NICOVIDEO_ICHIBA_URI + '">ニコニコ市場</a><br>' + #13#10 +
                         '</body>'+ #13#10 +
                         '</html>';
  //ランキング用
  NICO2_DEFAULT_HEADER  =  '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"'+ #13#10 +
                           '"http://www.w3.org/TR/html4/loose.dtd">'+ #13#10 +
                           '<html lang="ja">'+ #13#10 +
                           '<head>'+ #13#10 +
                           '<meta http-equiv="content-style-type" content="text/css">'+ #13#10 +
                           '<meta http-equiv="content-type" content="text/html; charset=Shift_JIS">'+ #13#10 +
                           '<base href="http://www.nicovideo.jp/">'+ #13#10 +
                           '<link rel="stylesheet" type="text/css" href="http://res.nicovideo.jp/css/common.css" charset="utf-8">'+ #13#10 +
                           '<style type="text/css"><!--'+ #13#10 +
                           'td.rank_num  { color:#999; text-align:right; font-weight:bold;}'+ #13#10 +
                           'td.data      { word-break:break-all; overflow:hidden;}'+ #13#10 +
                           'td.data .res { background:#FFF; font-weight:bold; border:solid 2px #CCC; margin-top:4px; padding:3px;}'+ #13#10 +
                           '--></style>'+ #13#10 +
                           '<title>TubePlayer</title>'+ #13#10 +
                           '</head>'+ #13#10 +
                           '<body style="background:">'+ #13#10 +
                           '<table width="640" border="0" cellspacing="0" cellpadding="4" summary="結果">';

  NICO2_DEFAULT_FOOTER  =  '</table>'+ #13#10 +
                           '<br>'+ #13#10 +
                           'powered by <a href="http://www.nicovideo.jp">ニコニコ動画</a><br>' + #13#10 +
                           '</body>'+ #13#10 +
                           '</html>';

  //きまぐれ検索用
  NICO3_DEFAULT_HEADER  =  '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"'+ #13#10 +
                           '"http://www.w3.org/TR/html4/loose.dtd">'+ #13#10 +
                           '<html lang="ja">'+ #13#10 +
                           '<head>'+ #13#10 +
                           '<meta http-equiv="content-style-type" content="text/css">'+ #13#10 +
                           '<meta http-equiv="content-type" content="text/html; charset=Shift_JIS">'+ #13#10 +
                           '<base href="http://www.nicovideo.jp/">'+ #13#10 +
                           '<link rel="stylesheet" type="text/css" href="http://res.nicovideo.jp/css/common.css" charset="utf-8">'+ #13#10 +
                           '<script type="text/javascript" src="js/_.js"></script>'+ #13#10 +
                           '<style type="text/css"><!--'+ #13#10 +
                           '.fkd_A { position:relative; z-index:9;}'+ #13#10 +
                           '.fkd_B { position:absolute; top:96px; left:64px; display:none;}'+ #13#10 +
                           '.fkd_C { width:148px; background:#FFF; color:#666; border:solid #999; border-width:0px 2px; padding:0px 6px;}'+ #13#10 +
                           '.thumb { border:solid 1px #333;}'+ #13#10 +
                           '--></style>'+ #13#10 +
                           '<title>TubePlayer</title>'+ #13#10 +
                           '</head>'+ #13#10 +
                           '<body style="background:">';

  //ビデオパネル用
  NICO4_DEFAULT_HEADER  =  '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"'+ #13#10 +
                           '"http://www.w3.org/TR/html4/loose.dtd">'+ #13#10 +
                           '<html lang="ja">'+ #13#10 +
                           '<head>'+ #13#10 +
                           '<meta http-equiv="content-type" content="text/html; charset=Shift_JIS">'+ #13#10 +
                           '<meta http-equiv="content-style-type" content="text/css">'+ #13#10 +
                           '<base href="http://www.nicovideo.jp/">'+ #13#10 +
                           '<link rel="stylesheet" type="text/css" href="http://res.nicovideo.jp/css/common.css" charset="utf-8">'+ #13#10 + 
                           '<link rel="stylesheet" type="text/css" href="http://res.nicovideo.jp/css/watch.css" charset="utf-8">'+ #13#10 +
                           //'<script type="text/javascript" src="js/prototype.js"></script>'+ #13#10 +
                           //'<script type="text/javascript" src="js/_.js"></script>'+ #13#10 +
                           '<title>TubePlayer</title>'+ #13#10 +
                           '</head>'+ #13#10 +
                           '<body style="background:; width:auto;padding:4px;">';

  //マイリスト用
  NICO5_DEFAULT_HEADER  =  '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"'+ #13#10 +
                           '"http://www.w3.org/TR/html4/loose.dtd">'+ #13#10 +
                           '<html lang="ja">'+ #13#10 +
                           '<head>'+ #13#10 +
                           '<meta http-equiv="content-type" content="text/html; charset=Shift_JIS">'+ #13#10 +
                           '<meta http-equiv="content-style-type" content="text/css">'+ #13#10 +
                           '<base href="http://www.nicovideo.jp/">'+ #13#10 +
                           '<link rel="stylesheet" type="text/css" href="http://res.nicovideo.jp/css/common.css" charset="utf-8">'+ #13#10 +
                           '<title>TubePlayer</title>'+ #13#10 +
                           '</head>'+ #13#10 +
                           '<body style="background:">'+ #13#10 +
                           '<table width="640" border="0" cellpadding="4" cellspacing="0" style="margin-bottom:16px;">';

  //ニコニコ市場用
  NICO_ICHIBA_HEADER  = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"'+ #13#10 +
                        '"http://www.w3.org/TR/html4/loose.dtd">'+ #13#10 +
                        '<html lang="ja">'+ #13#10 +
                        '<head>'+ #13#10 +
                        '<meta http-equiv="content-style-type" content="text/css">'+ #13#10 +
                        '<meta http-equiv="content-type" content="text/html; charset=Shift_JIS">'+ #13#10 +
                        '<style type="text/css">'+ #13#10 +
                        '<!-- span.bold{font-weight: bold;} span.red{font-weight: bold; color: red;} body{font-size: smaller;}-->'+ #13#10 +
                        '</style>'+ #13#10 +
                        '<title>TubePlayer</title>'+ #13#10 +
                        '</head>'+ #13#10 +
                        '<body>';

  NICO_ICHIBA_CONTENT = '<tr><td colspan="2">'+ #13#10 +
                        '<span class="bold"><a href="$URL">$TITLE</a></span>'+ #13#10 +
                        '</td></tr>'+ #13#10 +
                        '<tr><td>'+ #13#10 +
                        '<span><a href="$URL"><img src="$IMAGE_URL" alt="$TITLE" /></a></span>'+ #13#10 +
                        '</td>'+ #13#10 +
                        '<td>'+ #13#10 +
                        '$BINDING:$ARTIST<br>'+ #13#10 +
                        '販売元:$PUBLISHER<br>'+ #13#10 +
                        '発売日:$RELEASEDATE<br>'+ #13#10 +
                        'おすすめ度:<img src="$STAR" border="0" alt="$AVERAGERATING" />($TOTALREVIEWS件の評価)<br>'+ #13#10 +
                        '購入:$BUY クリック:$CLICK ( 全体$TOTAL_CLICK)<br>'+ #13#10 +
                        '価格:<span class="bold">$PRICE</span> (定価:$LISTPRICE)<br>'+ #13#10 +
                        '<a href="' + NICOVIDEO_ICHIBA_URI + 'item/az$ASIN" style="color:#777777">関連動画を開く &gt;&gt;</a>'+ #13#10 +
                        '</td></tr>';

  NICO_ICHIBA_CONTENT2 = '<tr><td colspan="2">'+ #13#10 +
                        '<span class="bold"><a href="$URL">$TITLE</a></span>'+ #13#10 +
                        '</td></tr>'+ #13#10 +
                        '<tr><td>'+ #13#10 +
                        '<span><a href="$URL"><img src="$IMAGE_URL" alt="$TITLE" /></a></span>'+ #13#10 +
                        '</td>'+ #13#10 +
                        '<td>'+ #13#10 +
                        '$BINDING:$ARTIST<br>'+ #13#10 +
                        '販売元:$PUBLISHER<br>'+ #13#10 +
                        '発売日:$RELEASEDATE<br>'+ #13#10 +
                        'おすすめ度:<img src="$STAR" border="0" alt="$AVERAGERATING" />($TOTALREVIEWS件の評価)<br>'+ #13#10 +
                        'ランキング:<span class="bold">$RANK</span>(デイリー)<br>'+ #13#10 +
                        'いままでに$BUYが購入しました。<br>'+ #13#10 +
                        '価格:<span class="bold">$PRICE</span> (定価:$LISTPRICE)<br>'+ #13#10 +
                        '<a href="' + NICOVIDEO_ICHIBA_URI + 'item/az$ASIN" style="color:#777777">関連動画を開く &gt;&gt;</a>'+ #13#10 +
                        '</td></tr>';

  NICO_ICHIBA_FOOTER  = '<br>'+ #13#10 +
                        '(Amazon.co.jpアソシエイト)<br><br>' + #13#10 +
                        'powered by <a href="http://www.amazon.co.jp/gp/redirect.html?ie=UTF8&location=http%3A%2F%2Fwww.amazon.co.jp%2F&tag=janesoft-22&linkCode=ur2&camp=247&creative=1211">Amazon.co.jp</a>' +
                        ' &amp; <a href="' + NICOVIDEO_ICHIBA_URI + '">ニコニコ市場</a><br>' + #13#10 +
                        '</body>'+ #13#10 +
                        '</html>';

  LABEL_WSH_CAPTION    = 'TubePlayer は正規表現の処理をWindows Scriptに依存しているため、'+ #13#10 +
                         'IE5.5に付属のWindows Script 5.5以上の環境が必要です。' + #13#10 +
                         'IE5.5より前のIEをご使用の方は、 IE6以降にアップグレードするか、' + #13#10 +
                         '下記のURLからWindows Scriptの最新版をインストールする必要があります。';
  LABEL_WSH2_CAPTION   = 'http://www.microsoft.com/japan/msdn/scripting/';

  LABEL_FLASH_CAPTION  = 'TubePlayer の再生部はIE版のFlashPlayer9を利用しています。'+ #13#10 +
                         'FlashPlayerのバージョンが古い方は下記のURLから'+ #13#10 +
                         'FlashPlayer9をインストールする必要があります。';
  LABEL_FLASH2_CAPTION = 'http://www.adobe.com/shockwave/download/index.cgi?Lang='+ #13#10 +
                         'Japanese&P1_Prod_Version=ShockwaveFlash';

  NICO_ACCESS_LOCKED   =  '短時間での連続アクセスはご遠慮ください';
  NICO_LOGIN_MESSAGE   =  'ログインしてください';

type
  PDataItem = ^TDataItem;
  TDataItem = record
    Title: WideString;
    Data: TFavoriteList;
    ImageIndex: integer; //(13:YouTube 14:nicovideo 11:mylist(ニコニコ動画))
  end;

  TSearchData = class(TObject)
  private
    author:             string; //動画を所有しているユーザー名
    author_link:        string; //動画を所有しているユーザー名(リンクつき)
    video_id:           string; //動画のID
    video_title:        string; //ビデオのタイトル
    playtime_seconds:   string; //動画の再生時間(秒)
    playtime:           string; //動画の再生時間(x:xx)
    rating_avg:         string; //評価平均
    rating:             string; //5段階評価(評価平均を四捨五入、★で表示)
    rationg_count:      string; //評価数
    description:        string; //動画の説明文
    view_count:         string; //閲覧回数
    upload_unixtime:    string; //動画がアップロードされた時間(unixtime)
    upload_time:        string; //動画がアップロードされた時間
    comment_count:      string; //コメント数
    tags:               string; //ビデオのタグ一覧
    thumbnail_url1:     string; //ビデオのサムネイルのURL(YouTube標準のサムネイル)
    thumbnail_url2:     string; //ビデオのサムネイルのURL
    thumbnail_url3:     string; //ビデオのサムネイルのURL
    html:               string; //ニコニコ動画の表示切替用
    liststate:          integer; //絞込み中かどうか
    video_type:         integer; //(0: YouTube 1:nicovideo)
  end;

  TAsinData = class(TObject)
  private
    ASIN:          string; //ASIN
    URL:           string; //DetailPageURL(ダイレクト先)
    Image_URL:     string; //MediumImageのURL
    Artist:        string; //Artist,Actor,Creator,Brand
    Binding:       string; //種類(Binding)
    Publisher:     string; //販売元(Label)
    ReleaseDate:   string; //発売日(ReleaseDate)
    Title:         string; //タイトル(Title)
    ListPrice:     string; //定価(ListPrice)
    Price:         string; //価格(LowestNewPrice)
    AverageRating: string; //評価(AverageRating)
    TotalReviews:  string; //評価数(TotalReviews)
    (* *)
    buy:           string; //購入者数
    click:         string; //クリック数
    total_click:   string; //クリック数(全体)
    rank:          string; //ニコニコ市場ランキング
  end;

  TCommentData = record
    number:             string; //発言番号(最新コメントから順に番号を付けています)
    author:             string; //コメント投稿者
    author_link:        string; //コメント投稿者(リンクつき)
    text:               string; //コメント本文
    time:               string; //コメント投稿時間
  end;

  TRelatedData = record
    thumbnail_url1:     string; //ビデオのサムネイルのURL(YouTube標準のサムネイル)
    thumbnail_url2:     string; //ビデオのサムネイルのURL
    thumbnail_url3:     string; //ビデオのサムネイルのURL
    video_id:           string; //動画のID
    video_title:        string; //ビデオのタイトル
    playtime:           string; //動画の再生時間(x:xx表示)
    author:             string; //動画を所有しているユーザー名
    author_link:        string; //動画を所有しているユーザー名(リンクつき)
    view_count:         string; //閲覧回数
  end;

  TCommentList = array of TCommentData;
  TRelatedList = array of TRelatedData;

  TVideoData = record
    video_id:           string; //動画のID
    video_ext:          string; //動画の拡張子
    dl_video_id:        string; //動画のDL先
    comment_count:      string; //コメント数
    favorited_count:    string; //お気に入りに登録された回数
    author:             string; //動画を所有しているユーザー名
    author_link:        string; //動画を所有しているユーザー名(リンクつき)
    video_title:        string; //ビデオのタイトル
    rating_avg:         string; //評価平均
    rating:             string; //5段階評価(評価平均を四捨五入、★で表示)
    rationg_count:      string; //評価数
    tags:               string; //ビデオのタグ一覧
    description:        string; //動画の説明文
    update_time:        string; //更新された時間
    view_count:         string; //閲覧回数
    upload_time:        string; //動画がアップロードされた時間
    playtime_seconds:   string; //動画の再生時間(秒)
    playtime:           string; //動画の再生時間(x:xx表示)
    recording_date:     string; //録画した時間
    recording_location: string; //録画した場所
    recording_country:  string; //録画した国
    thumbnail_url1:     string; //ビデオのサムネイルのURL(YouTube標準のサムネイル)
    thumbnail_url2:     string; //ビデオのサムネイルのURL
    thumbnail_url3:     string; //ビデオのサムネイルのURL
    channnel:           string; //ビデオの所属するカテゴリ名
    CommentList:        TCommentList;
    RelatedList:        TRelatedList;
    video_type:         integer; //ビデオのタイプ(0:YouTube,1:nicovideo(YouTube),2:nicovideo(AmebaVision),3:nicovideo(SMILEVIDEO),4:nicovideo(etc),5:nicovideo(?p=))
  end;

  TANLVideoData = class(TObject)
  public
    video_id:           string; //動画のID                                   id
    upload_unixtime:    string; //動画がアップロードされた時間(unixtime)     published
    upload_time:        string; //動画がアップロードされた時間
    update_unixtime:    string; //更新された時間(unixtime)                   updated
    update_time:        string; //更新された時間
    author:             string; //動画を所有しているユーザー名               author name
    author_link:        string; //動画を所有しているユーザー名(リンクつき)   author uri
    comment_url:        string; //コメントURL                                gd:comments.feedLink href
    comment_count:      string; //コメント数                                 gd:comments.feedLink countHint
    channnel:           string; //ビデオの所属するカテゴリ名                 media:group.media:category
    description:        string; //動画の説明文                               media:group.media:description
    keywords:           string; //ビデオのタグ一覧                           media:group.media:keywords
    player_url:         string; //プレイヤーのURL                            media:group.media:player url
    thumbnail_url0:     string; //ビデオのサムネイルのURL                    media:group.media:thumbnail url
    thumbnail_url1:     string; //ビデオのサムネイルのURL                    media:group.media:thumbnail url
    thumbnail_url2:     string; //ビデオのサムネイルのURL                    media:group.media:thumbnail url
    thumbnail_url3:     string; //ビデオのサムネイルのURL                    media:group.media:thumbnail url
    thumbnail_url:      string; //ビデオのサムネイルのURL(default)
    video_title:        string; //ビデオのタイトル                           media:group.media:title
    playtime_seconds:   string; //動画の再生時間(秒)                         media:group.yt:duration seconds
    playtime:           string; //動画の再生時間(x:xx)
    rating_avg:         string; //評価平均                                   gd:rating average
    rating:             string; //5段階評価(評価平均を四捨五入、★で表示)
    rationg_count:      string; //評価数                                     gd:rating numRaters
    favorited_count:    string; //お気に入りに登録された回数                 yt:statistics favoriteCount
    view_count:         string; //閲覧回数                                   yt:statistics viewCount
    recording_date:     string; //録画した時間                               yt:recorded
    recording_location: string; //録画した場所                               yt:location
    video_type:         integer; //(0: YouTube 1:nicovideo)
  end;

  TMainWnd = class(TForm)
    RegExp: TRegExp;
    TrayIcon: TJLTrayIcon;
    ApplicationEvents: TApplicationEvents;
    ImageList: TImageList;
    Panel: TSpTBXPanel;
    LabelWSH: TSpTBXLabel;
    LabelWSH2: TSpTBXLabel;
    LabelFlash: TSpTBXLabel;
    LabelFlash2: TSpTBXLabel;
    FileVerInfo: TFileVerInfo;
    TimerSetSetBounds: TTimer;
    CheckBoxThrough: TSpTBXCheckBox;
    TimerAutoClose: TTimer;
    ToolbarTitleBar: TSpTBXToolbar;
    PopupTaskTray: TSpTBXPopupMenu;
    PopupTaskTrayRestore: TSpTBXItem;
    PopupTaskTrayClose: TSpTBXItem;
    PopupMenu: TSpTBXPopupMenu;
    PopupMenuCopyURL: TSpTBXItem;
    PopupMenuCopyTU: TSpTBXItem;
    PopupMenuSave: TSpTBXItem;
    PopupMenuOpenNew: TSpTBXItem;
    PopupMenuOpenByBrowser: TSpTBXItem;
    PopupMenuStayOnTop: TSpTBXItem;
    PopupMenuSetting: TSpTBXItem;
    PopupMenuHelp: TSpTBXItem;
    PopupMenuExit: TSpTBXItem;
    ToolBarToolBar: TSpTBXToolbar;
    ToolButtonSave: TSpTBXItem;
    ToolButtonOpenNew: TSpTBXItem;
    ToolButtonOpenByBrowser: TSpTBXItem;
    ToolButtonStayOnTop: TSpTBXItem;
    ToolButtonSetting: TSpTBXItem;
    ToolButtonHelp: TSpTBXItem;
    ToolbarMainMenu: TSpTBXToolbar;
    MenuHelp: TSpTBXSubmenuItem;
    MenuTool: TSpTBXSubmenuItem;
    MenuView: TSpTBXSubmenuItem;
    MenuFile: TSpTBXSubmenuItem;
    MenuFileOpenNew: TSpTBXItem;
    MenuFileOpenByBrowser: TSpTBXItem;
    MenuFileSave: TSpTBXItem;
    MenuFileCopyTU: TSpTBXItem;
    MenuFileCopyURL: TSpTBXItem;
    MenuViewDefaultWindowSize: TSpTBXItem;
    MenuViewStayOnTop: TSpTBXItem;
    MenuToolSetting: TSpTBXItem;
    MenuHelpVersion: TSpTBXItem;
    MenuHelpBugReport: TSpTBXItem;
    MenuHelpCheckUpdate: TSpTBXItem;
    MenuHelpHelp: TSpTBXItem;
    ActionList: TTntActionList;
    ActionExit: TTntAction;
    ActionOpenByBrowser: TTntAction;
    ActionOpenNew: TTntAction;
    ActionSave: TTntAction;
    ActionCopyTU: TTntAction;
    ActionCopyURL: TTntAction;
    ActionBugReport: TTntAction;
    ActionCheckUpdate: TTntAction;
    ActionHelp: TTntAction;
    ActionVersion: TTntAction;
    ActionSetting: TTntAction;
    ActionDefaultWindowSize: TTntAction;
    ActionStayOnTop: TTntAction;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    SpTBXSeparatorItem3: TSpTBXSeparatorItem;
    SpTBXSeparatorItem5: TSpTBXSeparatorItem;
    SpTBXSeparatorItem6: TSpTBXSeparatorItem;
    DockTop: TSpTBXDock;
    DockBottom: TSpTBXDock;
    MenuViewTheme: TSpTBXSubmenuItem;
    SpTBXSkinGroupItem1: TSpTBXSkinGroupItem;
    PopupMenuViewTheme: TSpTBXSubmenuItem;
    SpTBXSkinGroupItem2: TSpTBXSkinGroupItem;
    SpTBXSeparatorItem7: TSpTBXSeparatorItem;
    SpTBXSeparatorItem8: TSpTBXSeparatorItem;
    SpTBXSeparatorItem9: TSpTBXSeparatorItem;
    SpTBXSeparatorItem11: TSpTBXSeparatorItem;
    SpTBXSeparatorItem14: TSpTBXSeparatorItem;
    LabelURL: TSpTBXLabelItem;
    SpTBXCustomizer: TSpTBXCustomizer;
    ActionCustomize: TTntAction;
    MenuToolCustomize: TSpTBXItem;
    SpTBXSeparatorItem15: TSpTBXSeparatorItem;
    CustomCopyTU: TSpTBXItem;
    CustomCopyURL: TSpTBXItem;
    CustomOpenNew: TSpTBXItem;
    CustomVersion: TSpTBXItem;
    CustomBugReport: TSpTBXItem;
    CustomCheckUpdate: TSpTBXItem;
    CustomCustomize: TSpTBXItem;
    CustomDefaultWindowSize: TSpTBXItem;
    CustomExit: TSpTBXItem;
    SpTBXSeparatorItem17: TSpTBXSeparatorItem;
    MenuViewToolBar: TSpTBXSubmenuItem;
    MenuViewToolBarFixed: TSpTBXItem;
    MenuViewToolBarToggleToolBar: TSpTBXItem;
    MenuViewToolBarToggleTitleBar: TSpTBXItem;
    MenuViewToolBarToggleMenuBar: TSpTBXItem;
    ActionToggleMenuBar: TTntAction;
    ActionToggleToolBar: TTntAction;
    ActionToggleTitleBar: TTntAction;
    ActionToolBarFixed: TTntAction;
    CustomViewToggleTitleBar: TSpTBXItem;
    CustomViewToggleToolBar: TSpTBXItem;
    CustomViewToggleMenuBar: TSpTBXItem;
    CustomViewToolBarToolBarFixed: TSpTBXItem;
    PopupMenuView: TSpTBXSubmenuItem;
    SpTBXSeparatorItem20: TSpTBXSeparatorItem;
    PopupMenuViewToolBar: TSpTBXSubmenuItem;
    PopupMenuViewToolBarFixed: TSpTBXItem;
    PopupMenuViewToolBarToggleTitleBar: TSpTBXItem;
    PopupMenuViewToolBarToggleToolBar: TSpTBXItem;
    PopupMenuViewToolBarToggleMenuBar: TSpTBXItem;
    SpTBXDockablePanelLog: TSpTBXDockablePanel;
    MemoLog: TMemo;
    ActionToggleLogPanel: TTntAction;
    MenuViewLogPanel: TSpTBXItem;
    CustomViewToggleLogPanel: TSpTBXItem;
    PopupMenuViewToggleLogPanel: TSpTBXItem;
    XMLDocument: TXMLDocument;
    SpTBXDockablePanelVideoInfo: TSpTBXDockablePanel;
    ActionToggleVideoInfoPanel: TTntAction;
    MenuViewVideoInfoPanel: TSpTBXItem;
    CustomViewToggleVideoInfoPanel: TSpTBXItem;
    PopupMenuViewToggleVideoInfoPanel: TSpTBXItem;
    ToolButtonVideoInfoPanel: TSpTBXItem;
    PopupMenuToggleVideoInfoPanel: TSpTBXItem;
    DockLeft2: TSpTBXMultiDock;
    DockRight: TSpTBXMultiDock;
    DockLeft: TSpTBXDock;
    SpTBXTitleBar: TSpTBXTitleBar;
    PanelMain: TPanel;
    DockRight2: TSpTBXDock;
    SpTBXSplitterLeft: TSpTBXSplitter;
    SpTBXSplitterRight: TSpTBXSplitter;
    ActionToggleSplitter: TTntAction;
    MenuViewSplitter: TSpTBXItem;
    PopupMenuViewSplitter: TSpTBXItem;
    CustomViewToggleSplitter: TSpTBXItem;
    SpTBXDockablePanelVideoRelated: TSpTBXDockablePanel;
    ActionToggleVideoRelatedPanel: TTntAction;
    MenuViewVideoRelatedPanel: TSpTBXItem;
    PopupMenuViewToggleVideoRelatedPanel: TSpTBXItem;
    ToolButtonVideoRelatedPanel: TSpTBXItem;
    PopupMenuToggleVideoRelatedPanel: TSpTBXItem;
    SpTBXDockablePanelSearch: TSpTBXDockablePanel;
    ActionToggleSearchPanel: TTntAction;
    MenuViewSearchPanel: TSpTBXItem;
    PopupMenuViewToggleSearchPanel: TSpTBXItem;
    CustomViewToggleSearchPanel: TSpTBXItem;
    ListView: THogeListView;
    ListPopupMenu: TSpTBXPopupMenu;
    ListPopupCopy: TSpTBXSubmenuItem;
    ListPopupCopyTU: TSpTBXItem;
    ListPopupCopyURL: TSpTBXItem;
    ActionListPopupCopyURL: TTntAction;
    ActionListPopupCopyTU: TTntAction;
    ActionTaskTrayClose: TTntAction;
    ActionTaskTrayRestore: TTntAction;
    SpTBXSeparatorItem22: TSpTBXSeparatorItem;
    ListPopupOpenURL: TSpTBXItem;
    ActionListOpenURL: TTntAction;
    ToolbarSearchBar: TSpTBXToolbar;
    SearchBarSearch: TSpTBXItem;
    SearchBarComboBox: TSpTBXComboBox;
    TBControlItem1: TTBControlItem;
    ActionSearchBarSearch: TTntAction;
    XMLDocument2: TXMLDocument;
    ActionSearchBarAdd100: TTntAction;
    SearchBarAdd100: TSpTBXItem;
    ActionToggleSearchBar: TTntAction;
    MenuViewToolBarToggleSearchBar: TSpTBXItem;
    CustomViewToggleSearchBar: TSpTBXItem;
    PopupMenuViewToolBarToggleSearchBar: TSpTBXItem;
    SpTBXSeparatorItem23: TSpTBXSeparatorItem;
    MenuFileAddTag: TSpTBXItem;
    ActionAddTag: TTntAction;
    SpTBXSeparatorItem24: TSpTBXSeparatorItem;
    PopupMenuAddTag: TSpTBXItem;
    ActionListAddTag: TTntAction;
    SpTBXSeparatorItem25: TSpTBXSeparatorItem;
    ListPopupAddTag: TSpTBXItem;
    ActionClearSearchHistory: TTntAction;
    SpTBXSeparatorItem26: TSpTBXSeparatorItem;
    MenuSearchClearHistory: TSpTBXItem;
    ActionSearchBarToggleListView: TTntAction;
    SearchBarToggleListView: TSpTBXItem;
    PanelBrowser: TPanel;
    PanelListView: TPanel;
    PanelSearchToolbar: TSpTBXToolbar;
    PanelSearchLabel: TSpTBXLabelItem;
    PanelSearchComboBox: TSpTBXComboBox;
    TBControlItem2: TTBControlItem;
    PanelSearchToggleListView: TSpTBXItem;
    PanelSearchAdd100: TSpTBXItem;
    PanelSearchSearch: TSpTBXItem;
    ActionSearchBarSearch2: TTntAction;
    ActionTogglePanelSearchToolBar: TTntAction;
    MenuViewPanelSearchToolBar: TSpTBXItem;
    PopupMenuViewTogglePanelSearchToolBar: TSpTBXItem;
    CustomViewTheme: TSpTBXSubmenuItem;
    SpTBXSkinGroupItem3: TSpTBXSkinGroupItem;
    CustomViewTogglePanelSearchToolBar: TSpTBXItem;
    SpTBXSeparatorItem19: TSpTBXSeparatorItem;
    ListPopupToggleListView: TSpTBXItem;
    ActionClearVideoPanel: TTntAction;
    MenuFileClearVideoPanel: TSpTBXItem;
    ToolButtonClearVideoPanel: TSpTBXItem;
    CustomClearVideoPanel: TSpTBXItem;
    CustomAddTag: TSpTBXItem;
    CustomSave: TSpTBXItem;
    CustomOpenByBrowser: TSpTBXItem;
    CustomToggleVideoRelatedPanel: TSpTBXItem;
    CustomStayOnTop: TSpTBXItem;
    CustomClearHistory: TSpTBXItem;
    CustomSetting: TSpTBXItem;
    CustomHelp: TSpTBXItem;
    TimerSetSearchBar: TTimer;
    ToolButtonToggleSearchPanel: TSpTBXItem;
    PopupMenuToggleSearchPanel: TSpTBXItem;
    ActionAddAuthor: TTntAction;
    MenuFileAddAuthor: TSpTBXItem;
    CustomAddAuthor: TSpTBXItem;
    PopupMenuAddAuthor: TSpTBXItem;
    ActionListAddAuthor: TTntAction;
    ListPopupAddAuthor: TSpTBXItem;
    SearchTimer: TTimer;
    SpTBXSeparatorItem10: TSpTBXSeparatorItem;
    SpTBXSeparatorItem13: TSpTBXSeparatorItem;
    ActionOpenPrimarySite: TTntAction;
    SpTBXSeparatorItem16: TSpTBXSeparatorItem;
    MenuFileOpenPrimarySite: TSpTBXItem;
    CustomOpenPrimarySite: TSpTBXItem;
    ActionUserWindowSize: TTntAction;
    MenuViewUserWindowSize: TSpTBXItem;
    CustomUserWindowSize: TSpTBXItem;
    ActionAddReg: TTntAction;
    ActionDelReg: TTntAction;
    MenuToolDelReg: TSpTBXItem;
    SpTBXSeparatorItem27: TSpTBXSeparatorItem;
    MenuToolAddReg: TSpTBXItem;
    ActionToggleWindowSize: TTntAction;
    MenuViewToggleWindowSize: TSpTBXItem;
    CustomActionToggleWindowSize: TSpTBXItem;
    PopupMenuToggleWindowSize: TSpTBXItem;
    ToolButtonToggleWindowSize: TSpTBXItem;
    SearchBarToggleSearchTarget: TSpTBXSubmenuItem;
    MenuSearch: TSpTBXSubmenuItem;
    MenuSearchSearchBarToggleListView: TSpTBXItem;
    MenuSearchSearchBarAdd100: TSpTBXItem;
    MenuSearchSearchBarSearch: TSpTBXItem;
    MenuSearchToggleSearchTarget: TSpTBXSubmenuItem;
    SpTBXSeparatorItem30: TSpTBXSeparatorItem;
    ActionToggleSearchTarget: TTntAction;
    PanelSearchToggleSearchTarget: TSpTBXSubmenuItem;
    MenuSearchToggleSearchTargetYouTubeNormal: TSpTBXItem;
    MenuSearchToggleSearchTargetNicoVideoNewRes: TSpTBXItem;
    MenuSearchToggleSearchTargetNicoVideoLessView: TSpTBXItem;
    MenuSearchToggleSearchTargetNicoVideoMoreView: TSpTBXItem;
    MenuSearchToggleSearchTargetNicoVideoOldRes: TSpTBXItem;
    MenuSearchToggleSearchTargetYouTubeRelated: TSpTBXItem;
    SpTBXSeparatorItem31: TSpTBXSeparatorItem;
    MenuSearchNicoVideo: TSpTBXSubmenuItem;
    SpTBXSeparatorItem32: TSpTBXSeparatorItem;
    MenuSearchNicoVideoRankingViewNewall: TSpTBXItem;
    MenuSearchNicoVideoRankingViewDailyall: TSpTBXItem;
    MenuSearchNicoVideoRankingViewTotalall: TSpTBXItem;
    MenuSearchNicoVideoRankingResNewall: TSpTBXItem;
    MenuSearchNicoVideoRankingResDailyall: TSpTBXItem;
    MenuSearchNicoVideoRankingResTotalall: TSpTBXItem;
    MenuSearchNicoVideoRankingMylistTotalall: TSpTBXItem;
    MenuSearchNicoVideoRandom: TSpTBXItem;
    MenuSearchNicoVideoRecent: TSpTBXItem;
    MenuSearchNicoVideoNewarrival: TSpTBXItem;
    SpTBXSeparatorItem35: TSpTBXSeparatorItem;
    SpTBXSeparatorItem36: TSpTBXSeparatorItem;
    SpTBXSeparatorItem37: TSpTBXSeparatorItem;
    MenuSearchYouTube: TSpTBXSubmenuItem;
    MenuSearchYouTubePopularAll: TSpTBXItem;
    MenuSearchYouTubePopularMonth: TSpTBXItem;
    MenuSearchYouTubePopularWeek: TSpTBXItem;
    MenuSearchYouTubePopularDay: TSpTBXItem;
    MenuSearchYouTubeFeatured: TSpTBXItem;
    SpTBXSeparatorItem38: TSpTBXSeparatorItem;
    MenuSearchNicoVideoRankingMylistNewall: TSpTBXItem;
    MenuSearchNicoVideoRankingMylistTotalDailyall: TSpTBXItem;
    SpTBXSeparatorItem39: TSpTBXSeparatorItem;
    MenuFileRecentlyViewed: TSpTBXSubmenuItem;
    ActionChangeVideoScale: TTntAction;
    SpTBXSeparatorItem40: TSpTBXSeparatorItem;
    MenuViewChangeVideoScale: TSpTBXItem;
    CustomViewChangeVideoScale: TSpTBXItem;
    MenuSearchToggleSearchTargetNicoVideoTag: TSpTBXItem;
    ActionRefresh: TTntAction;
    MenuFileRefresh: TSpTBXItem;
    CustomRefresh: TSpTBXItem;
    CustomSearchBarToggleListView: TSpTBXItem;
    CustomSearchBarAdd100: TSpTBXItem;
    CustomSearchBarSearch: TSpTBXItem;
    CustomNicoVideo: TSpTBXSubmenuItem;
    CustomYouTube: TSpTBXSubmenuItem;
    CustomToggleSearchTarget: TSpTBXSubmenuItem;
    CustomRecentlyViewed: TSpTBXSubmenuItem;
    PanelSearchMenu: TSpTBXSubmenuItem;
    PanelSearchNicoVideo: TSpTBXSubmenuItem;
    PanelSearchYouTube: TSpTBXSubmenuItem;
    DockablePanelSearchMenu: TSpTBXSubmenuItem;
    MenuSearchYouTubePopular: TSpTBXSubmenuItem;
    MenuSearchYouTubeTopFavorites: TSpTBXSubmenuItem;
    MenuSearchYouTubeMostDiscussed: TSpTBXSubmenuItem;
    MenuSearchYouTubeTopRated: TSpTBXSubmenuItem;
    MenuSearchYouTubeMostViewed: TSpTBXSubmenuItem;
    SpTBXSeparatorItem41: TSpTBXSeparatorItem;
    MenuSearchYouTubeMostViewedMonth: TSpTBXItem;
    MenuSearchYouTubeMostViewedWeek: TSpTBXItem;
    MenuSearchYouTubeMostViewedDay: TSpTBXItem;
    MenuSearchYouTubeTopRatedMonth: TSpTBXItem;
    MenuSearchYouTubeTopRatedWeek: TSpTBXItem;
    MenuSearchYouTubeTopRatedDay: TSpTBXItem;
    MenuSearchYouTubeMostDiscussedMonth: TSpTBXItem;
    MenuSearchYouTubeMostDiscussedWeek: TSpTBXItem;
    MenuSearchYouTubeMostDiscussedDay: TSpTBXItem;
    MenuSearchYouTubeTopFavoritesMonth: TSpTBXItem;
    MenuSearchYouTubeTopFavoritesWeek: TSpTBXItem;
    MenuSearchYouTubeTopFavoritesDay: TSpTBXItem;
    MenuSearchYouTubeMostViewedAll: TSpTBXItem;
    MenuSearchYouTubeTopRatedAll: TSpTBXItem;
    MenuSearchYouTubeMostDiscussedAll: TSpTBXItem;
    MenuSearchYouTubeTopFavoritesAll: TSpTBXItem;
    MenuSearchYouTubeMostRecent: TSpTBXItem;
    ActionClearRecentlyViewed: TTntAction;
    SpTBXSeparatorItem42: TSpTBXSeparatorItem;
    MenuToolClearRecentlyViewed: TSpTBXItem;
    CustomClearRecentlyViewed: TSpTBXItem;
    ActionCopyTitle: TTntAction;
    MenuFileCopyTitle: TSpTBXItem;
    PopupMenuCopyTitle: TSpTBXItem;
    CustomCopyTitle: TSpTBXItem;
    ActionListPopupCopyTitle: TTntAction;
    ListPopupCopyTitle: TSpTBXItem;
    SpTBXSeparatorItem43: TSpTBXSeparatorItem;
    MenuSearchYouTubeCategorySetting: TSpTBXSubmenuItem;
    MenuSearchYouTubeCategorySetting19: TSpTBXItem;
    MenuSearchYouTubeCategorySetting17: TSpTBXItem;
    MenuSearchYouTubeCategorySetting15: TSpTBXItem;
    MenuSearchYouTubeCategorySetting22: TSpTBXItem;
    MenuSearchYouTubeCategorySetting25: TSpTBXItem;
    MenuSearchYouTubeCategorySetting10: TSpTBXItem;
    MenuSearchYouTubeCategorySetting26: TSpTBXItem;
    MenuSearchYouTubeCategorySetting20: TSpTBXItem;
    MenuSearchYouTubeCategorySetting1: TSpTBXItem;
    MenuSearchYouTubeCategorySetting24: TSpTBXItem;
    MenuSearchYouTubeCategorySetting23: TSpTBXItem;
    MenuSearchYouTubeCategorySetting2: TSpTBXItem;
    MenuSearchYouTubeCategorySetting0: TSpTBXItem;
    MenuSearchToggleSearchTargetYouTubeFromWebSite: TSpTBXItem;
    SpTBXSeparatorItem44: TSpTBXSeparatorItem;
    MenuSearchToggleSearchTargetYouTubeSetting: TSpTBXSubmenuItem;
    MenuSearchToggleSearchTargetYouTubeSettingCategory: TSpTBXSubmenuItem;
    MenuSearchToggleSearchTargetYouTubeSettingSort: TSpTBXSubmenuItem;
    MenuSearchToggleSearchTargetYouTubeSettingSort3: TSpTBXItem;
    MenuSearchToggleSearchTargetYouTubeSettingSort2: TSpTBXItem;
    MenuSearchToggleSearchTargetYouTubeSettingSort1: TSpTBXItem;
    MenuSearchToggleSearchTargetYouTubeSettingSort0: TSpTBXItem;
    MenuSearchToggleSearchTargetYouTubeSettingCategory19: TSpTBXItem;
    MenuSearchToggleSearchTargetYouTubeSettingCategory17: TSpTBXItem;
    MenuSearchToggleSearchTargetYouTubeSettingCategory15: TSpTBXItem;
    MenuSearchToggleSearchTargetYouTubeSettingCategory22: TSpTBXItem;
    MenuSearchToggleSearchTargetYouTubeSettingCategory25: TSpTBXItem;
    MenuSearchToggleSearchTargetYouTubeSettingCategory10: TSpTBXItem;
    MenuSearchToggleSearchTargetYouTubeSettingCategory26: TSpTBXItem;
    MenuSearchToggleSearchTargetYouTubeSettingCategory20: TSpTBXItem;
    MenuSearchToggleSearchTargetYouTubeSettingCategory1: TSpTBXItem;
    MenuSearchToggleSearchTargetYouTubeSettingCategory24: TSpTBXItem;
    MenuSearchToggleSearchTargetYouTubeSettingCategory23: TSpTBXItem;
    MenuSearchToggleSearchTargetYouTubeSettingCategory2: TSpTBXItem;
    MenuSearchToggleSearchTargetYouTubeSettingCategory0: TSpTBXItem;
    ActionLogOutFromYouTube: TTntAction;
    ActionLogOutNicoVideo: TTntAction;
    SpTBXSeparatorItem45: TSpTBXSeparatorItem;
    MenuFileLogOut: TSpTBXSubmenuItem;
    MenuFileLogOutNicoVideo: TSpTBXItem;
    MenuFileLogOutFromYouTube: TSpTBXItem;
    CustomLogOutNicoVideo: TSpTBXItem;
    CustomLogOutFromYouTube: TSpTBXItem;
    SpTBXSeparatorItem18: TSpTBXSeparatorItem;
    SpTBXSeparatorItem21: TSpTBXSeparatorItem;
    SpTBXDockablePanelFavorite: TSpTBXDockablePanel;
    ActionToggleFavoritePanel: TTntAction;
    CustomViewToggleFavoritePanel: TSpTBXItem;
    PopupMenuViewToggleFavoritePanel: TSpTBXItem;
    MenuViewFavoritePanel: TSpTBXItem;
    ToolButtonToggleFavoritePanel: TSpTBXItem;
    VirtualFavoriteView: TVirtualStringTree;
    FavoritePopupMenu: TSpTBXPopupMenu;
    MenuFavorite: TSpTBXSubmenuItem;
    FavoritePopupOpen: TSpTBXItem;
    FavoritePopupOpenByBrowser: TSpTBXItem;
    FavoritePopupCopy: TSpTBXSubmenuItem;
    FavoritePopupDelete: TSpTBXItem;
    FavoritePopupNew: TSpTBXItem;
    FavoritePopupEdit: TSpTBXItem;
    FavoritePopupCopyTU: TSpTBXItem;
    FavoritePopupCopyURL: TSpTBXItem;
    FavoritePopupCopyTitle: TSpTBXItem;
    SpTBXSeparatorItem46: TSpTBXSeparatorItem;
    SpTBXSeparatorItem47: TSpTBXSeparatorItem;
    SpTBXSeparatorItem48: TSpTBXSeparatorItem;
    SpTBXSeparatorItem49: TSpTBXSeparatorItem;
    ActionFavoritePopupOpen: TTntAction;
    ActionFavoritePopupOpenByBrowser: TTntAction;
    ActionFavoritePopupCopyTitle: TTntAction;
    ActionFavoritePopupCopyURL: TTntAction;
    ActionFavoritePopupCopyTU: TTntAction;
    ActionFavoritePopupNew: TTntAction;
    ActionFavoritePopupEdit: TTntAction;
    ActionFavoritePopupDelete: TTntAction;
    MenuFavoriteAddFavorite: TSpTBXItem;
    SpTBXSeparatorItem50: TSpTBXSeparatorItem;
    ActionAddFavorite: TTntAction;
    CustomAddFavorite: TSpTBXItem;
    SpTBXSeparatorItem51: TSpTBXSeparatorItem;
    PopupMenuAddFavorite: TSpTBXSubmenuItem;
    ToolButtonAddFavorite: TSpTBXSubmenuItem;
    ListPopupAddFavorite: TSpTBXSubmenuItem;
    SpTBXSeparatorItem52: TSpTBXSeparatorItem;
    SpTBXSeparatorItem53: TSpTBXSeparatorItem;
    ListPopupOpenByBrowser: TSpTBXItem;
    ActionListOpenByBrowser: TTntAction;
    MenuSearchYouTubeMostLinked: TSpTBXSubmenuItem;
    MenuSearchYouTubeMostResponded: TSpTBXSubmenuItem;
    MenuSearchYouTubeMostRespondedAll: TSpTBXItem;
    MenuSearchYouTubeMostRespondedMonth: TSpTBXItem;
    MenuSearchYouTubeMostRespondedWeek: TSpTBXItem;
    MenuSearchYouTubeMostRespondedDay: TSpTBXItem;
    SpTBXItem5: TSpTBXItem;
    SpTBXItem6: TSpTBXItem;
    SpTBXItem7: TSpTBXItem;
    SpTBXItem8: TSpTBXItem;
    MenuSearchNicoVideoRankingViewWeeklyall: TSpTBXItem;
    MenuSearchNicoVideoRankingViewMonthlyall: TSpTBXItem;
    MenuSearchNicoVideoRankingResWeeklyall: TSpTBXItem;
    MenuSearchNicoVideoRankingResMonthlyall: TSpTBXItem;
    MenuSearchNicoVideoRankingMylistTotalWeeklyall: TSpTBXItem;
    MenuSearchNicoVideoRankingMylistTotalMonthlyall: TSpTBXItem;
    TimerGetNicoVideoData: TTimer;
    PopupMenuChangeVideoScale: TSpTBXItem;
    ToolButtonRefresh: TSpTBXItem;
    ActionListPopupSave: TTntAction;
    SpTBXSeparatorItem54: TSpTBXSeparatorItem;
    ActionListSave: TSpTBXItem;
    ActionOpenYouTube: TTntAction;
    ActionOpenNicoVideo: TTntAction;
    ActionOpenNicoVideoBlog: TTntAction;
    SpTBXSeparatorItem55: TSpTBXSeparatorItem;
    MenuHelpOpen: TSpTBXSubmenuItem;
    MenuHelpOpenNicoVideoBlog: TSpTBXItem;
    MenuHelpOpenNicoVideo: TSpTBXItem;
    MenuHelpOpenYouTube: TSpTBXItem;
    SpTBXSeparatorItem56: TSpTBXSeparatorItem;
    SpTBXSeparatorItem57: TSpTBXSeparatorItem;
    ActionOpenOfficialSite: TTntAction;
    MenuHelpOpenOfficialSite: TSpTBXItem;
    CustomOpenOfficialSite: TSpTBXItem;
    CustomOpenNicoVideoBlog: TSpTBXItem;
    CustomOpenNicoVideo: TSpTBXItem;
    CustomOpenYouTube: TSpTBXItem;
    PopupMenuClearVideoPanel: TSpTBXItem;
    PopupMenuRefresh: TSpTBXItem;
    ActionMinimize: TTntAction;
    ActionHideInTaskTray: TTntAction;
    SpTBXSeparatorItem12: TSpTBXSeparatorItem;
    MenuViewHideInTaskTray: TSpTBXItem;
    MenuViewMinimize: TSpTBXItem;
    ActionOpenNicoIchiba: TTntAction;
    SpTBXItem1: TSpTBXItem;
    SpTBXSeparatorItem58: TSpTBXSeparatorItem;
    SpTBXSeparatorItem4: TSpTBXSeparatorItem;
    MenuFileExit: TSpTBXItem;
    SpTBXSeparatorItem59: TSpTBXSeparatorItem;
    SpTBXSeparatorItem60: TSpTBXSeparatorItem;
    SpTBXSeparatorItem61: TSpTBXSeparatorItem;
    SpTBXItem2: TSpTBXItem;
    SpTBXItem3: TSpTBXItem;
    SpTBXItem4: TSpTBXItem;
    SpTBXItem9: TSpTBXItem;
    SpTBXSeparatorItem62: TSpTBXSeparatorItem;
    SpTBXSeparatorItem63: TSpTBXSeparatorItem;
    SpTBXItem10: TSpTBXItem;
    SpTBXItem11: TSpTBXItem;
    SpTBXItem12: TSpTBXItem;
    SpTBXItem13: TSpTBXItem;
    SpTBXItem14: TSpTBXItem;
    SpTBXItem15: TSpTBXItem;
    SpTBXItem16: TSpTBXItem;
    SpTBXSeparatorItem64: TSpTBXSeparatorItem;
    SpTBXSeparatorItem65: TSpTBXSeparatorItem;
    SpTBXSeparatorItem66: TSpTBXSeparatorItem;
    SpTBXSeparatorItem33: TSpTBXSeparatorItem;
    SpTBXSeparatorItem34: TSpTBXSeparatorItem;
    SpTBXSeparatorItem67: TSpTBXSeparatorItem;
    MenuSearchNicoVideoCategorySetting: TSpTBXSubmenuItem;
    MenuSearchNicoVideoCategorySetting22: TSpTBXItem;
    MenuSearchNicoVideoCategorySetting21: TSpTBXItem;
    MenuSearchNicoVideoCategorySetting20: TSpTBXItem;
    MenuSearchNicoVideoCategorySetting19: TSpTBXItem;
    MenuSearchNicoVideoCategorySetting18: TSpTBXItem;
    MenuSearchNicoVideoCategorySetting17: TSpTBXItem;
    MenuSearchNicoVideoCategorySetting16: TSpTBXItem;
    MenuSearchNicoVideoCategorySetting15: TSpTBXItem;
    MenuSearchNicoVideoCategorySetting14: TSpTBXItem;
    MenuSearchNicoVideoCategorySetting13: TSpTBXItem;
    MenuSearchNicoVideoCategorySetting12: TSpTBXItem;
    MenuSearchNicoVideoCategorySetting11: TSpTBXItem;
    MenuSearchNicoVideoCategorySetting10: TSpTBXItem;
    MenuSearchNicoVideoCategorySetting9: TSpTBXItem;
    MenuSearchNicoVideoCategorySetting8: TSpTBXItem;
    MenuSearchNicoVideoCategorySetting7: TSpTBXItem;
    MenuSearchNicoVideoCategorySetting6: TSpTBXItem;
    MenuSearchNicoVideoCategorySetting5: TSpTBXItem;
    MenuSearchNicoVideoCategorySetting4: TSpTBXItem;
    MenuSearchNicoVideoCategorySetting3: TSpTBXItem;
    MenuSearchNicoVideoCategorySetting2: TSpTBXItem;
    MenuSearchNicoVideoCategorySetting1: TSpTBXItem;
    MenuSearchNicoVideoCategorySetting0: TSpTBXItem;
    ActionFavoritePopupAddMylist: TTntAction;
    FavoritePopupAddMylist: TSpTBXItem;
    SpTBXSeparatorItem68: TSpTBXSeparatorItem;
    SpTBXSeparatorItem69: TSpTBXSeparatorItem;
    SpTBXItem17: TSpTBXItem;
    SpTBXItem18: TSpTBXItem;
    SpTBXSeparatorItem70: TSpTBXSeparatorItem;
    SpTBXItem19: TSpTBXItem;
    SpTBXItem20: TSpTBXItem;
    MenuSearchNicoVideoHotlist: TSpTBXItem;
    SpTBXSeparatorItem28: TSpTBXSeparatorItem;
    MenuOpenJaneBBS: TSpTBXItem;
    ActionOpenJaneBBS: TTntAction;
    procedure WebBrowserCreate;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure WebBrowserBeforeNavigate2(Sender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure WebBrowserNavigateComplete2(ASender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);
    procedure WebBrowser4NavigateComplete2(ASender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);
    procedure WebBrowserTitleChange(ASender: TObject; const Text: WideString);
    procedure LoadCustomImageList(const path: string; var ImageList: TImageList);
    procedure ApplicationEventsMinimize(Sender: TObject);
    procedure ApplicationEventsDeactivate(Sender: TObject);
    procedure ApplicationEventsActivate(Sender: TObject);
    procedure ActionTaskTrayCloseExecute(Sender: TObject);
    procedure ActionTaskTrayRestoreExecute(Sender: TObject);
    procedure TrayIconMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MainWndRestore;
    procedure ApplicationEventsMessage(var Msg: tagMSG;
      var Handled: Boolean);
    function UnixTime2String(const str: string): String;
    function UnixTime2DateTime(const str: string): TDateTime;
    procedure OpenByBrowser(const URI: string);
    procedure CommandExecuteForTool(URI: string; OrgURI: string;Title: string);
    procedure LabelWSH2Click(Sender: TObject);
    procedure LabelFlash2Click(Sender: TObject);
    procedure TimerSetSetBoundsTimer(Sender: TObject);
    procedure CheckBoxThroughClick(Sender: TObject);
    procedure TimerAutoCloseTimer(Sender: TObject);
    procedure ListViewData(Sender: TObject; Item: TListItem);
    procedure ListViewColumnClick(Sender: TObject;
      Column: TListColumn);
    procedure ListViewColumnSort(columnIndex: Integer);
    procedure ActionSettingExecute(Sender: TObject);
    procedure ActionExitExecute(Sender: TObject);
    procedure ActionOpenByBrowserExecute(Sender: TObject);
    procedure ActionOpenNewExecute(Sender: TObject);
    procedure ActionSaveExecute(Sender: TObject);
    procedure ActionCopyTUExecute(Sender: TObject);
    procedure ActionCopyURLExecute(Sender: TObject);
    procedure ActionBugReportExecute(Sender: TObject);
    procedure ActionCheckUpdateExecute(Sender: TObject);
    procedure ActionCheckUpdateOnStartUpExecute(Sender: TObject);
    procedure ActionHelpExecute(Sender: TObject);
    procedure ActionVersionExecute(Sender: TObject);
    procedure ActionDefaultWindowSizeExecute(Sender: TObject);
    procedure ActionStayOnTopExecute(Sender: TObject);
    procedure SpTBXCustomizerSave(Sender: TObject;
      ExtraOptions: TStringList);
    procedure SpTBXCustomizerLoad(Sender: TObject;
      ExtraOptions: TStringList);
    procedure ActionCustomizeExecute(Sender: TObject);
    procedure ActionToggleMenuBarExecute(Sender: TObject);
    procedure ActionToggleToolBarExecute(Sender: TObject);
    procedure ToolBarToolBarVisibleChanged(Sender: TObject);
    procedure ActionToggleTitleBarExecute(Sender: TObject);
    procedure ToolbarTitleBarVisibleChanged(Sender: TObject);
    procedure ActionToolBarFixedExecute(Sender: TObject);
    procedure ActionToggleLogPanelExecute(Sender: TObject);
    procedure SpTBXDockablePanelLogCloseQuery(Sender: TObject;
      var CanClose: Boolean);
    procedure ActionToggleVideoInfoPanelExecute(Sender: TObject);
    procedure SpTBXDockablePanelVideoInfoCloseQuery(Sender: TObject;
      var CanClose: Boolean);
    procedure ActionToggleSplitterExecute(Sender: TObject);
    procedure ActionToggleVideoRelatedPanelExecute(Sender: TObject);
    procedure SpTBXDockablePanelVideoRelatedCloseQuery(Sender: TObject;
      var CanClose: Boolean);
    procedure ActionToggleSearchPanelExecute(Sender: TObject);
    //procedure ShowVideoData;
    procedure ClearVideoData;
    procedure ClearSearchList;
    procedure ClearAsinList;
    procedure ClearAsinRankList;
    procedure ListViewClick(Sender: TObject);
    procedure ListViewDblClick(Sender: TObject);
    procedure ListViewCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure ListViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListViewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListPopupMenuPopup(Sender: TObject);
    procedure ListViewSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ActionListPopupCopyURLExecute(Sender: TObject);
    procedure ActionListPopupCopyTUExecute(Sender: TObject);
    procedure ActionListOpenURLExecute(Sender: TObject);
    procedure ActionSearchBarSearchExecute(Sender: TObject);
    procedure ActionSearchBarAdd100Execute(Sender: TObject);
    procedure SearchBarComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure ActionToggleSearchBarExecute(Sender: TObject);
    procedure ToolbarSearchBarVisibleChanged(Sender: TObject);
    procedure ActionAddTagExecute(Sender: TObject);
    procedure ActionListAddTagExecute(Sender: TObject);
    procedure ActionClearSearchHistoryExecute(Sender: TObject);
    procedure ToolbarSearchBarResize(Sender: TObject);
    procedure ActionSearchBarToggleListViewExecute(Sender: TObject);
    procedure ActionSearchBarSearch2Execute(Sender: TObject);
    procedure PanelSearchComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure ActionTogglePanelSearchToolBarExecute(Sender: TObject);
    procedure SpTBXDockablePanelSearchCloseQuery(Sender: TObject;
      var CanClose: Boolean);
    procedure ActionClearVideoPanelExecute(Sender: TObject);
    procedure TimerSetSearchBarTimer(Sender: TObject);
    procedure ActionAddAuthorExecute(Sender: TObject);
    procedure ActionListAddAuthorExecute(Sender: TObject);
    procedure SearchTimerTimer(Sender: TObject);
    procedure SearchComboBoxChange(Sender: TObject);
    procedure ListViewSearchNarrowing(cb: TComboBox);
    procedure ActionOpenPrimarySiteExecute(Sender: TObject);
    procedure ActionUserWindowSizeExecute(Sender: TObject);
    procedure ActionAddRegExecute(Sender: TObject);
    procedure ActionDelRegExecute(Sender: TObject);
    function EmbeddedWBTranslateAccelerator(const lpMsg: PMsg;
      const pguidCmdGroup: PGUID; const nCmdID: Cardinal): HRESULT;
    procedure ActionToggleWindowSizeExecute(Sender: TObject);
    procedure ActionToggleSearchTargetExecute(Sender: TObject);
    procedure GetExtraExecute(Sender: TObject);
    procedure GetRankingExecute(Sender: TObject);
    procedure GetYouTubeDataExecute(Sender: TObject);
    procedure GetYouTubeDataFromSiteExecute(Sender: TObject);
    procedure OnYouTubeGetSearchResults(sender: TAsyncReq);
    function IsPrivacyZoneOK: boolean;
    procedure AddRecentlyViewed(const Title: String; VideoID: String; Location: String);
    procedure RecentlyViewedClick(Sender: TObject);
    procedure MenuFileClick(Sender: TObject);
    procedure PanelResize(Sender: TObject);
    procedure ActionChangeVideoScaleExecute(Sender: TObject);
    procedure ActionRefreshExecute(Sender: TObject);
    procedure CustomRecentlyViewedClick(Sender: TObject);
    procedure ActionClearRecentlyViewedExecute(Sender: TObject);
    procedure ActionCopyTitleExecute(Sender: TObject);
    procedure ActionListPopupCopyTitleExecute(Sender: TObject);
    procedure SetYouTubeCategoryExecute(Sender: TObject);
    procedure MenuSearchYouTubeCategorySettingClick(Sender: TObject);
    procedure MenuSearchToggleSearchTargetYouTubeSettingSortClick(
      Sender: TObject);
    procedure MenuSearchToggleSearchTargetYouTubeSettingSortExecute(
      Sender: TObject);
    procedure MenuSearchToggleSearchTargetYouTubeSettingCategoryClick(
      Sender: TObject);
    procedure MenuSearchToggleSearchTargetYouTubeSettingCategoryExecute(
      Sender: TObject);
    procedure ActionLogOutFromYouTubeExecute(Sender: TObject);
    procedure ActionLogOutNicoVideoExecute(Sender: TObject);
    procedure ActionToggleFavoritePanelExecute(Sender: TObject);
    procedure SpTBXDockablePanelFavoriteCloseQuery(Sender: TObject;
      var CanClose: Boolean);
    procedure UpdateFavorites;
    procedure FavoriteMenuItemCreate(Sender: TSpTBXSubmenuItem; ItemClickEvent :TNotifyEvent);
    procedure OnFavoriteShortcutMenuClick(Sender: TObject);
    procedure FavMenuCreate(Sender: TObject);
    procedure UpdateFavoritesMenu;
    procedure SaveFavorites(save: boolean = true);
    procedure UpdateVirtualFavoriteView(Select: boolean);
    procedure VirtualFavoriteViewClick(Sender: TObject);
    procedure VirtualFavoriteViewContextPopup(Sender: TObject;
      MousePos: TPoint; var Handled: Boolean);
    procedure VirtualFavoriteViewDblClick(Sender: TObject);
    procedure VirtualFavoriteViewDragAllowed(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure VirtualFavoriteViewDragDrop(Sender: TBaseVirtualTree;
      Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
      Shift: TShiftState; Pt: TPoint; var Effect: Integer;
      Mode: TDropMode);
    procedure VirtualFavoriteViewDragOver(Sender: TBaseVirtualTree;
      Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint;
      Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
    procedure VirtualFavoriteViewEdited(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure VirtualFavoriteViewEndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure VirtualFavoriteViewGetHint(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex;
      var LineBreakStyle: TVTTooltipLineBreakStyle;
      var HintText: WideString);
    procedure VirtualFavoriteViewGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure VirtualFavoriteViewGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure VirtualFavoriteViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure VirtualFavoriteViewNewText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
    procedure ActionFavoritePopupOpenExecute(Sender: TObject);
    procedure ActionFavoritePopupOpenByBrowserExecute(Sender: TObject);
    procedure ActionFavoritePopupCopyTitleExecute(Sender: TObject);
    procedure ActionFavoritePopupCopyURLExecute(Sender: TObject);
    procedure ActionFavoritePopupCopyTUExecute(Sender: TObject);
    procedure ActionFavoritePopupNewExecute(Sender: TObject);
    procedure ActionFavoritePopupEditExecute(Sender: TObject);
    procedure ActionFavoritePopupDeleteExecute(Sender: TObject);
    procedure RegisterFavorite(parent: TFavoriteList = nil; index: integer = 0;
                               AtBottom: boolean = false);
    procedure RegisterFavorite2(SearchData: TSearchData; parent: TFavoriteList = nil; index: integer = 0;
                               AtBottom: boolean = false);
    procedure ActionAddFavoriteExecute(Sender: TObject);
    procedure ListPopupAddFavoriteExecute(Sender: TObject);
    procedure PopupMenuAddFavoriteExecute(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    //procedure ToolButtonAddFavoriteClick(Sender: TObject);
    procedure ToolButtonAddFavoritePopup(Sender: TTBCustomItem;
      FromLink: Boolean);
    procedure FavoritePopupMenuPopup(Sender: TObject);
    procedure ActionListOpenByBrowserExecute(Sender: TObject);
    procedure SetProxy(const ProxyHostAndPort: String);
    procedure SetDirectConnection;
    procedure TimerGetNicoVideoDataTimer(Sender: TObject);
    //function IsShortCut(var Message: TWMKey): Boolean; override;
    procedure ActionListPopupSaveExecute(Sender: TObject);
    procedure ActionOpenYouTubeExecute(Sender: TObject);
    procedure ActionOpenNicoVideoExecute(Sender: TObject);
    procedure ActionOpenNicoVideoBlogExecute(Sender: TObject);
    procedure ActionOpenOfficialSiteExecute(Sender: TObject);
    procedure GetNicoIchibaExecute(const URI: String);
    procedure GetNicoMylistExecute(const URI: String);
    procedure ActionMinimizeExecute(Sender: TObject);
    procedure ActionHideInTaskTrayExecute(Sender: TObject);
    procedure ActionOpenNicoIchibaExecute(Sender: TObject);
    procedure MenuSearchNicoVideoCategorySettingClick(Sender: TObject);
    procedure MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute(Sender: TObject);
    procedure ActionFavoritePopupAddMylistExecute(Sender: TObject);
    procedure ActionOpenJaneBBSExecute(Sender: TObject);
  private
    { Private 宣言 }
    procedure ON_WM_COPYDATA(var msg: TWMCopyData); message WM_COPYDATA;
    procedure Clear(Browser: TEmbeddedWB);
    procedure WebBrowserDocumentComplete(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure WebBrowserNewWindow2(Sender: TObject;
      var ppDisp: IDispatch; var Cancel: WordBool);
    procedure SetURI(URI: String);
    procedure SetURIwithClear(URI: String);

    procedure OnNicoVideoPreConnect(sender: TAsyncReq; code: TAsyncNotifyCode);
    procedure OnYouTubePreConnect(sender: TAsyncReq; code: TAsyncNotifyCode);
    (*
    procedure OnDoneNicoVideoSession(sender: TAsyncReq);
    procedure OnNotify(sender: TAsyncReq; code: TAsyncNotifyCode);
    *)

    procedure OnDoneNicoVideo(sender: TAsyncReq);
    procedure OnDoneNicoVideoIchiba(sender: TAsyncReq); 
    procedure OnDoneNicoIchibaRanking(sender: TAsyncReq);
    procedure OnDoneAmazon(sender: TAsyncReq); 
    procedure OnDoneAmazon2(sender: TAsyncReq);
    procedure OnDoneNicoVideoGetURI(sender: TAsyncReq);
    procedure OnDoneYouTube(sender: TAsyncReq);
    procedure OnDoneYouTubeDetails(sender: TAsyncReq);
    procedure OnDoneYouTubeComments(sender: TAsyncReq);
    procedure OnDoneYouTubeRelated(sender: TAsyncReq);
    procedure OnAnalysis(sender: TAsyncReq);
    procedure OnTubePreConnect(sender: TAsyncReq; code: TAsyncNotifyCode);
    procedure OnNicoVideoSearch(sender: TAsyncReq);
    procedure OnNicoVideoGetRanking(sender: TAsyncReq);
    procedure OnYouTubeSearch(sender: TAsyncReq);
    procedure OnDoneNicoIchiba(sender: TAsyncReq);
    procedure OnDoneNicoMyList(sender: TAsyncReq);
    function YouTubeEntryXMLAnalize(EntryNode: IXMLNode; NS_media, NS_gd, NS_yt: DOMString): TANLVideoData;
  protected
    procedure WndProc(var Msg: TMessage); override;
  public
    { Public 宣言 }
    procedure Log(const str: string); overload;
    procedure Log(const FormatStr: string; FormatAry: array of const); overload;
  end;

//指定した拡張子に関連付けられた実行ファイルのフルパス名を取得するAPI
function AssocQueryString(
         flags,str: DWORD;
         pszAssoc : PChar;
         pszExtra : PChar;
         pszOut   : PChar;
         pcchOut  : PDWORD):
         HRESULT; stdcall; external 'shlwapi.dll' name 'AssocQueryStringA';

//IEのプライバシー設定を取得するAPI
function PrivacyGetZonePreferenceW(
         dwZone: DWORD;
         dwType: DWORD;
         pdwTemplate: LPDWORD;
         pszBuffer: LPWSTR;
         pdwBufferLength: LPDWORD):
         DWORD; stdcall; external 'wininet.dll' name 'PrivacyGetZonePreferenceW';

//IEのプライバシー設定を変更するAPI
function PrivacySetZonePreferenceW(
         dwZone: DWORD;
         dwType: DWORD;
         dwTemplate: DWORD;
         pszPreference: LPCWSTR):
         DWORD; stdcall; external 'wininet.dll' name 'PrivacySetZonePreferenceW';

var
  MainWnd: TMainWnd;
  Config: TConfig;
  favorites: TFavorites; //お気に入り
  WebBrowser: TEmbeddedWB;  //ビデオパネル
  WebBrowser2: TEmbeddedWB; //ビデオ情報パネル
  WebBrowser3: TEmbeddedWB; //関連ビデオパネル
  WebBrowser4: TEmbeddedWB; //検索パネル
  AsyncManager: TAsyncManager;
  procGet: TAsyncReq;  //データ取得用
  procGet2: TAsyncReq; //アップデートチェック用
  procGet3: TAsyncReq; //検索用
  procGet4: TAsyncReq; //ダウンロードURL取得用
  userImeMode: TImeMode;
  USEPLAYER2: Boolean; //player2を用いるかどうか
  USELOCALPLAYER: Boolean; //ローカルのplayer(flvplayer.swf)で再生するかどうか
  LastIchibaCheckTime: TDateTime; //最後にニコニコ市場を取得した時間

const
  WND_SUFFIX = 'WND';
  MAX_URL_LEN = 1024;
  WM_MY_TRAYICON = WM_APP + $500;

function IsPrimaryInstance: Boolean;
function OnStartup: Boolean;
procedure SaveImeMode(wnd: HWND);
procedure CommandExecute(command: string);

implementation

uses UUIConfig, UVersionInfo, UIDlg, UUpdateDlg, UBugReport;

{$R *.dfm}

var
  HogeMutex: THogeMutex;
  TimeZoneBias: integer;
  sharedResourceName: string;
  initialURL: TStringList;
  MyWindowHandle: THogeSharedMem;
  HostAppWnd: HWND = 0;
  WndSendMsg: HWND = 0;

  NewWindow: Boolean;

  StartUpFileVerInfo: TFileVerInfo;

  StartUpRegExp: TRegExp;
  StartUpURI: String;

  currentSortColumn: integer;  //現在のソート

  IsOK: boolean;         //FLASHとWSHが対応バージョンであるかどうか
  DocComplete: boolean;  //ページの書き換えが完了したかどうか(ビデオパネル)
  DocComplete2: boolean; //ページの書き換えが完了したかどうか(ビデオ情報パネル)
  DocComplete3: boolean; //ページの書き換えが完了したかどうか(関連ビデオパネル)
  DocComplete4: boolean; //ページの書き換えが完了したかどうか(検索パネル)

  tmpURI: String;        //ビデオのURL
  tmpURI2Form: String;   //ビデオのURLをフォームに対応させたもの('&'の変換)
  tmpID: String;         //ビデオのID

  tmpSearchURI: String;  //検索URLを一時的に保存
  SearchList: TList;     //検索結果を格納
  SearchType: Integer;   //検索先(0:YouTube(検索) 10:YouTube(APIデータ取得) 20:YouTube(データ取得) 1:ニコニコ動画(検索) 2:ニコニコ動画(ランキング) 3:ニコニコ動画(新着投稿) 4:ニコニコ動画(きまぐれ検索) 5:ニコニコ動画(タグ検索) 6:ニコニコ動画(ホットリスト) 8:マイリスト 9:ニコニコ市場)
  tmpSearchWord: string;
  tmpLabelWord: string;
  SearchPage: integer;
  totalResults: Integer;
  SearchedEnd: boolean; //絞込みしたかどうか

  AsinList: TList;        //ニコニコ市場(Amazon)のデータを格納
  AsinRankList: TList; //ニコニコ市場ランキング(Amazon)のデータを格納

  VideoData: TVideoData; //ビデオの詳細情報を格納

  NoPopup: Boolean;      //アップデートチェック後最新版がなかった場合にポップアップを出すかどうか

  RecentlyViewedVideos: TStringList; //最近視聴した動画

  HeaderHTML: string; //Header.htmlの内容
  ResHTML: string;    //Res.htmlの内容
  FooterHTML: string; //Footer.htmlの内容

  R_HeaderHTML: string;  //R_Header.htmlの内容
  R_ContentHTML: string; //R_Content.htmlの内容
  R_FooterHTML: string;  //R_Footer.htmlの内容
  
  S_HeaderHTML: string;  //S_Header.htmlの内容
  S_ContentHTML: string; //S_Content.htmlの内容
  S_FooterHTML: string;  //S_Footer.htmlの内容

  RightClicked: Boolean;

  NicoVideoRetryCount: integer;
  YouTubeRetryCount: integer;

  (*
  //左クリック押下中に移動可能にする
  ClickPos: TPoint;
  PrevTop: Integer;
  PrevLeft: Integer;
  DragMoving: Boolean;
  *)

//指定した拡張子に関連付けられた実行ファイルのフルパス名を取得する
function GetRelatedExe(ext:string): string;
var
  p: array [0..MAX_PAtH] of Char;
  q: DWORD;
  startpos, endpos: integer;
begin
  Result := '';
  q := MAX_PATH;
  AssocQueryString(0, 1, PChar(ext), 'open', p, Addr(q));
  Result := p;
  if Length(Result) > 0 then
  begin
    if AnsiStartsStr('"', Result) then //""で囲まれている場合
    begin
      startpos := 2;
      endpos := PosEx('"', Result, startpos);
      Result := Copy(Result, startpos, endpos - startpos);
    end;
    Result := CustomStringReplace(Result,  '"%1"', '');
    Result := CustomStringReplace(Result,  '%1', '');
  end;
end;

function IsThisClassName(hWindow: HWND; const AClassName: String): Boolean;
var
  p: PChar;
  str: String;
  alen, clen: Integer;
begin
  alen := Length(AClassName);
  p := StrAlloc(alen + 1);
  try
    clen := GetClassName(hWindow, p, alen + 1);
    SetString(str, p, clen);
    Result := str = AClassName;
  finally
    StrDispose(p);
  end;
end;

function IsThisWindowName(hWindow: HWND; const AWindowName: String): Boolean;
var
  p: PChar;
  str: String;
  len: Integer;
begin
  len := GetWindowTextLength(hWindow);
  p := StrAlloc(len + 1);
  try
    len := GetWindowText(hWindow, p, len + 1);
    SetString(str, p, len);
    Result := str = AWindowName;
  finally
    StrDispose(p);
  end;
end;

function EnumWndProc(hWindow:HWND; lData:LPARAM): BOOL; stdcall;
begin
  result := true;
  if GetProp(hWindow,PChar(lData)) = 8888 then
  begin
    HostAppWnd := hWindow;
    result := false;
  end;
end;

function EnumThreadProc(hWindow: HWND; lData: LPARAM): BOOL; stdcall;
begin
  Result := True;

  if IsThisClassName(hWindow, 'TMainWnd') then
  begin
    WndSendMsg := hWindow;
    Result := False;
  end;
end;

function EnumTrayIconProc(hWindow: HWND; lData: LPARAM): BOOL; stdcall;
begin
  Result := True;

  if IsThisWindowName(hWindow, 'JLTrayIcon') and
     IsThisClassName(hWindow, 'TPUtilWindow') then
  begin
    Result := False;
    SendMessage(hWindow, WM_MY_TRAYICON, WParam(hWindow), LParam(WM_LBUTTONUP));
  end;
end;

function IsPrimaryInstance: Boolean;
begin
  HogeMutex := THogeMutex.Create(false, PChar(sharedResourceName));
  if HogeMutex.lastError <> 0 then
  begin
    HogeMutex.Free;
    result := false;
  end
  else
    result := true;
end;

//タブ区切りの文字列を分解する
procedure SetTabTextToStrings(aStrings: TStrings; const aValue: String);
var
  p, p1: PChar;
  s: string;
begin
  aStrings.BeginUpdate;
  try
    aStrings.Clear;
    p := PChar(aValue);
    while p^ in [#1..#$8,#10..#$1F] do p := CharNext(p);
    while p^ <> #0 do
    begin
      p1 := p;
      while (p^ > #$1F) do p := CharNext(p);
      SetString(s, p1, p - p1);
      aStrings.Add(s);
      while p^ in [#1..#$8,#10..#$1F] do p := CharNext(p);
      if p^ = #$9 then
      begin
        repeat
          p := CharNext(p);
        until not (p^ in [#1..#$8,#10..#$1F]);
      end;
    end;
  finally
    aStrings.EndUpdate;
  end;
end;

//スタートアップの処理
//二重起動を防ぐ＆すでに起動していればアクティブ化/URLを送る
//非対応のURLが送られてきたらブラウザかURLExec.datで指定されたコマンドにURLを送って終了
function OnStartup: Boolean;

  procedure OpenByBrowser2(const URI: string);
  begin
    if Length(URI) <= 0 then
      exit;
    if Config.optBrowserSpecified then
    begin
      if Config.optUseShellExecute then
        ShellExecute(0, 'open', PChar(Config.optBrowserPath), PChar(URI), nil, SW_SHOW)
      else
        CommandExecute(Config.optBrowserPath + ' ' + URI);
    end else
    begin
      if Config.optUseShellExecute then
        ShellExecute(0, 'open', PChar(URI), nil, nil, SW_SHOW)
      else
        CommandExecute(GetRelatedExe('.HTML') + ' ' + URI);
    end;
  end;

  function CheckWSHVer(version: String): Boolean;
  var
    strlist: TStringList;
  begin
    result := false;
    if Length(version) <= 0 then
     exit;
    strlist := TStringList.Create;
    strlist.Delimiter := '.';
    strlist.DelimitedText := version;
    if (Length(strlist[0]) > 0) and (StrToInt(strlist[0]) >= 5) and
       (Length(strlist[1]) > 0) and (StrToInt(strlist[1]) >= 5) then
      result := True;
    strlist.Free;
  end;

var
  wnd: HWND;
  i,j: integer;
  cd: TCopyDataStruct;
  s: string;
  active: boolean;
  searchflag: boolean;
  pID: Cardinal;
  flag: boolean;
  basePath: String;
  URLExecList: TStringList;
  URLExecRepace: TStringList;
  URLExecCommand: TStringList;
  RegExpFile:TStringList;
  RegExpStr: TStringList;
  command: String;
  URI: String;
  Si:TStartupInfo;
  Pi:TProcessInformation;
const
  VBS_DLL = 'vbscript.dll';
  FLASH9_OCX   = 'Flash9.ocx';
  FLASH9B_OCX  = 'Flash9b.ocx';
  FLASH9C_OCX  = 'Flash9c.ocx';
  FLASH9D_OCX  = 'Flash9d.ocx';
  FLASH9E_OCX  = 'Flash9e.ocx';
  FLASH9F_OCX  = 'Flash9f.ocx';
  FLASH9G_OCX  = 'Flash9g.ocx'; //出ていない
  FLASH10A_OCX = 'Flash10a.ocx';
  FLASH10B_OCX = 'Flash10b.ocx'; //まだ出ていない
  FLASH10C_OCX = 'Flash10c.ocx'; //まだ出ていない
var
  SystemPath : array [0..256] of char;
  DllPath: string;
  WSHVer: String;
  ShiftKey: boolean;
begin
  sharedResourceName := CustomStringReplace(ExtractFileDir(Application.ExeName),
                                            '\', '-', True);
  initialURL := TStringList.Create;
  active := true;
  searchflag := false;
  IsOK := True;

  ShiftKey := (GetKeyState(VK_SHIFT) < 0);

  basePath := ExtractFilePath(Application.ExeName);
  if not FileExists(basePath + CHECK_DAT) then
  begin
    IsOK := false;
    GetSystemDirectory(SystemPath, sizeof(SystemPath));
    DllPath := GetFlashOcxFilePath;
    if FileExists(DllPath) then
      IsOK := True;
    //ここから↓ 消してもいいけど残しておく
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
    //ここまで↑ 消してもいいけど残しておく
    if IsOK then
    begin
      DllPath := String(SystemPath) + '\' + VBS_DLL;
      if not FileExists(DllPath) then
        IsOK := false
      else
      begin
        StartUpFileVerInfo := TFileVerInfo.Create(nil);
        StartUpFileVerInfo.FileName := DllPath;
        if StartUpFileVerInfo.HasVerInfo then
        begin
          WSHVer := StartUpFileVerInfo.FileVersion;
          if not CheckWSHVer(WSHVer) then
            IsOK := false;
        end;
        StartUpFileVerInfo.Free;
      end;
    end;
    if IsOK then
    begin
      initialURL.SaveToFile(basePath + CHECK_DAT);
    end else
    begin
      result := true;
      NewWindow := true;
      exit;
    end;
  end;

  if 0 < System.ParamCount then
  begin
    for i := 1 to System.ParamCount do
    begin
      if MAX_URL_LEN < Length(System.ParamStr(i)) then
        continue;
      if not StartWith('-', System.ParamStr(i), 1) then
        initialURL.Add(System.ParamStr(i));
      if CompareStr('-h', System.ParamStr(i)) = 0 then
        active := false
      else
        s := s + System.ParamStr(i) + #13#10;
      if CompareStr('-s', System.ParamStr(i)) = 0 then
        searchflag := true;
    end;
  end;

  if searchflag then
  begin
    if initialURL.Count > 0 then
    begin
      for i := 0 to initialURL.Count - 1 do
      begin
        StartUpURI := StartUpURI + ' ' + initialURL.Strings[i];
      end;
    end;
  end else
  if initialURL.Count > 0 then
  begin
    if FileExists(basePath + URLEXEC_DAT) then
    begin
      RegExpFile := TStringList.Create;
      try
        RegExpFile.LoadFromFile(BasePath + URLEXEC_DAT);
      except
        RegExpFile.Free;
      end;
      if Assigned(RegExpFile) then
      begin
        URLExecList := TStringList.Create;
        URLExecRepace := TStringList.Create;
        URLExecCommand := TStringList.Create;
        RegExpStr := TStringList.Create;
        RegExpStr.Delimiter := #9;
        try
          for i := 0 to RegExpFile.Count - 1 do
          begin
            RegExpStr.Clear;
            SetTabTextToStrings(RegExpStr, RegExpFile[i]);
            if (RegExpStr.Count < 3) or
               (RegExpStr[0] = '') or
               (RegExpStr[2] = '') or
               (RegExpStr[0][1] = ';') or
               (RegExpStr[0][1] = '''') or
               ((RegExpStr[0][1] = '/') and (RegExpStr[0][2] = '/')) then
              Continue;

            RegExpStr[2] := CustomStringReplace(RegExpStr[2], '$BASEPATH', basePath, True);
            RegExpStr[2] := CustomStringReplace(RegExpStr[2], '\\', '\');

            URLExecList.Add(RegExpStr[0]);
            URLExecRepace.Add(RegExpStr[1]);
            URLExecCommand.Add(RegExpStr[2]);
          end;
        finally
          FreeAndNil(RegExpFile);
          FreeAndNil(RegExpStr);
        end;
        if Assigned(URLExecList) and (URLExecList.Count > 0) and
           (Length(URLExecList.Strings[0]) = 0) then
        begin
          FreeAndNil(URLExecList);
          FreeAndNil(URLExecRepace);
          FreeAndNil(URLExecCommand);
        end;
      end;
    end;

    flag := false;

    StartUpRegExp := TRegExp.Create(nil);
    StartUpRegExp.IgnoreCase := True;
    StartUpRegExp.Global := True;

    for i := 0 to initialURL.Count - 1 do
    begin
      try
        URI := initialURL.Strings[i];

        StartUpRegExp.Pattern := GET_USER_ITEM;
        if StartUpRegExp.Test(URI) then //YouTubeユーザー検索
        begin
          StartUpURI := 'user:' + StartUpRegExp.Replace(URI, '$1');
          flag := True;
          break;
        end;

        StartUpRegExp.Pattern := GET_ICHIBA_ITEM;
        if StartUpRegExp.Test(URI) then //ニコニコ市場
        begin
          StartUpURI := URI;
          flag := True;
          break;
        end;

        StartUpRegExp.Pattern := GET_MYLIST;
        if StartUpRegExp.Test(URI) then //マイリスト
        begin
          StartUpURI := URI;
          flag := True;
          break;
        end;

        for j := Low(URI_TARGET) to High(URI_TARGET) do
        begin
          StartUpRegExp.Pattern := URI_TARGET[j];
          if StartUpRegExp.Test(URI) then
          begin
            StartUpURI := URI;
            flag := True;
            break;
          end;
        end;
      except
        on E: Exception do
        begin
          MessageDlg(e.Message + #13#10 + URI + #13#10 + StartUpRegExp.Pattern, mtError, [mbOK], -1);
        end;
      end;
      if flag then
        break;

      if Assigned(URLExecList) then
      begin
        URI := initialURL.Strings[i];
        try
          for j := 0 to URLExecList.Count - 1 do
          begin
            StartUpRegExp.Pattern := URLExecList.Strings[j];
            if StartUpRegExp.Test(URI) then
            begin
              URI := StartUpRegExp.Replace(URI, URLExecRepace.Strings[j]);
              command := URLExecCommand.Strings[j];
              command := CustomStringReplace(command, '$URL', URI, True);
              if (AnsiPos(URI, command) <= 0) then
                command := command + ' ' + URI;
              GetStartupInfo(Si);
              CreateProcess(nil, PAnsiChar(command), nil, nil, false, 0, nil, nil, Si, Pi);
              CloseHandle(Pi.hProcess);
              CloseHandle(Pi.hThread);

              StartUpRegExp.Free;
              FreeAndNil(initialURL);
              FreeAndNil(URLExecList);
              FreeAndNil(URLExecRepace);
              FreeAndNil(URLExecCommand);

              result := false;
              exit;
            end;
          end;
        except
          on E: Exception do
          begin
            MessageDlg(e.Message + #13#10 + URI + #13#10 + StartUpRegExp.Pattern, mtError, [mbOK], -1);
          end;
        end;
      end;

    end;

    StartUpRegExp.Free;
    if not flag or ShiftKey then //Shiftキー押下時は外部ブラウザに送る
    begin
      Config := TConfig.Create;
      Config.Load;
      for i := 0 to initialURL.Count - 1 do
      begin
        OpenByBrowser2(initialURL.Strings[i]);
      end;
      Config.Free;
      FreeAndNil(initialURL);
      if Assigned(URLExecList) then FreeAndNil(URLExecList);
      if Assigned(URLExecRepace) then FreeAndNil(URLExecRepace);
      if Assigned(URLExecCommand) then FreeAndNil(URLExecCommand);
      result := false;
      exit;
    end;

  end;

  FreeAndNil(initialURL);

  Config := TConfig.Create;
  Config.Load;
  if Config.optNewWindowAnytime then
  begin
    result := true;
    NewWindow := true;
    exit;
  end;

  if IsPrimaryInstance then
  begin
    result := true;
    SetProp(Application.Handle, PChar(sharedResourceName), 8888);
  end else
  begin
    Config.Free;

    result := false;

    EnumWindows(@EnumWndProc, Integer(PChar(sharedResourceName)));
    if HostAppWnd = 0 then
      exit;

    pID := GetWindowThreadProcessId(HostAppWnd, nil);
    EnumThreadWindows(pID, @EnumThreadProc, 0);
    wnd := WndSendMsg;
    if wnd = 0 then
      exit;

    if 0 < System.ParamCount then
    begin
      cd.cbData := Length(s) + 1;
      cd.lpData := StrAlloc(cd.cbData);
      try
        StrCopy(cd.lpData, PChar(s));
        SendMessage(wnd, WM_COPYDATA, WPARAM(wnd), LPARAM(@cd));
      finally
        StrDispose(cd.lpData);
      end;
    end;
    if active then
    begin
      EnumThreadWindows(pID, @EnumTrayIconProc, 0);
      SetForegroundWindow(wnd);
    end;
  end;
end;

//IME状態を保存してオフに
procedure SaveImeMode(wnd: HWND);
var
  imc: HIMC;
begin
  imc := ImmGetContext(wnd);
  if ImmGetOpenStatus(imc) then
    userImeMode := imOpen
  else
    userImeMode := imClose;
  ImmReleaseContext(wnd, imc);
  SetImeMode(wnd, imClose);
end;

//コマンドを実行
procedure CommandExecute(command: string);
var
  Si:TStartupInfo;
  Pi:TProcessInformation;
begin
  if Length(command) <= 0 then
    exit;
  GetStartupInfo(Si);
  CreateProcess(nil, PAnsiChar(command), nil, nil, false, 0, nil, nil, Si, Pi);
  CloseHandle(Pi.hProcess);
  CloseHandle(Pi.hThread);
end;

//ウィンドウの最大化・通常・最小化のイベントをフックする
procedure TMainWnd.WndProc(var Msg: TMessage);
var
  PWinPos: PWindowPos;
  NewRect: TRect;
begin
  inherited WndProc(Msg);
  if Self.Visible then
  begin
    case Msg.Msg of
      WM_SIZE:
      begin
        case TWMSize(Msg).SizeType of
          SIZE_RESTORED:
          begin
            SearchBarComboBox.Width := 0;
            TimerSetSearchBar.Enabled := false;
            TimerSetSearchBar.Enabled := True; //一応リサイズイベントを発生させる
            ActionDefaultWindowSize.Enabled := True;
            ActionUserWindowSize.Enabled := True;
            ActionToggleWindowSize.Enabled  := True;
          end;
          SIZE_MAXIMIZED:
          begin
            ActionDefaultWindowSize.Enabled := false;
            ActionUserWindowSize.Enabled := false;
            ActionToggleWindowSize.Enabled  := false;
          end;
        end;
      end;
      WM_WINDOWPOSCHANGING:
      begin
        //枠Pita
        PWinPos := PWindowPos(Msg.LParam);
        if (PWinPos^.hwnd = Handle) and (PWinPos^.flags and SWP_NOMOVE = 0) then
        begin
          NewRect.Left := PWinPos^.x;
          NewRect.Top := PWinPos^.y;
          NewRect.Right := NewRect.Left + Width;
          NewRect.Bottom := NewRect.Top + Height;
          PitaMonitor(Handle, NewRect, 10);
          PWinPos^.x := NewRect.Left;
          PWinPos^.y := NewRect.Top;
        end;
      end;
    end;
  end;
end;

//ビデオパネルを作成する
procedure TMainWnd.WebBrowserCreate;
begin
  WebBrowser := TEmbeddedWB.Create(self);
  TWinControl(WebBrowser).Parent := Self.Panel;
  TWinControl(WebBrowser).Align := alClient;
  WebBrowser.DisabledPopupMenus := [rcmAll];
  WebBrowser.HandleNeeded;
  WebBrowser.Loaded;
  WebBrowser.UserAgent := Config.netUserAgent;
  WebBrowser.Silent := True;
  WebBrowser.DisableErrors.EnableDDE := false;
  WebBrowser.DisableErrors.ScriptErrorsSuppressed := false;
  WebBrowser.DisableErrors.fpExceptions := false;
  WebBrowser.OnDocumentComplete := WebBrowserDocumentComplete;
  WebBrowser.OnNewWindow2 := WebBrowserNewWindow2;
  WebBrowser.OnNavigateComplete2 := WebBrowserNavigateComplete2;
  WebBrowser.OnBeforeNavigate2 := WebBrowserBeforeNavigate2;
  WebBrowser.OnTitleChange := WebBrowserTitleChange;
  WebBrowser.EnableMessageHandler := True;

  //WebBrowser.DownloadOptions := WebBrowser.DownloadOptions + [DontExecuteScripts];
  //WebBrowser.DisableCtrlShortcuts := 'ACNFP'; //バグ！

  //WebBrowser.EnableMessageHandler; //ニコニコ動画はEnableMessageHandlerが必要
  //WebBrowser.OnTranslateAccelerator := EmbeddedWBTranslateAccelerator;
end;

//フォーム作成時の処理
procedure TMainWnd.FormCreate(Sender: TObject);

  procedure LoadString(const fname: string; var str: string);
  var
    pss: TPSStream;
  begin
    if FileExists(fname) then
    begin
      pss := TPSStream.Create('');
      try
        pss.LoadFromFile(fname);
        str := pss.DataString;
      except
      end;
      pss.Free;
    end;
  end;

var
  wnd: HWND;
  p: Pointer;
  TimeZoneInfo: _TIME_ZONE_INFORMATION;
  Path: String;
  Back: Integer;
  Rec: TSearchRec;
  skn_flg: boolean;
begin
  Log(Main.APPLICATION_NAME + ' Version ' + Main.VERSION);

  if not Assigned(Config) then
  begin
    Config := TConfig.Create;
    Config.Load;
  end;

  if not Config.optUseDefaultTitleBar then
  begin
    SpTBXTitleBar.Active := True;
    PanelMain.Parent := SpTBXTitleBar;
  end else
    SpTBXTitleBar.Active := false;


  if not(NewWindow or Config.optNewWindowAnytime) then
  begin
    MyWindowHandle := nil;
    try
      MyWindowHandle
          := THogeSharedMem.Create(sharedResourceName + WND_SUFFIX, SizeOf(wnd));
      p := MyWindowHandle.Memory;
      Move(wnd, p^, SizeOf(wnd));
    except
    end;
  end;

  //スキン読み込み
  Path := Config.BasePath + SKINS_FOLDER;
  if DirectoryExists(Path) then
  begin
    skn_flg := false;
    try
      try
        Back := FindFirst(Path + '*.skn', FaAnyFile, Rec);
        while Back = 0 do
        begin
          if (Rec.Name <> '.') and (Rec.Name <> '..') then
          begin
            SkinManager.SkinsList.AddSkinFromFile(Path + Rec.Name);
            skn_flg := true;
          end;
          Back := FindNext(Rec);
        end;
      finally
        FindClose(Rec);
      end;
    except
    end;
    if skn_flg then
    begin
      SpTBXSkinGroupItem1.Recreate;
      SpTBXSkinGroupItem2.Recreate;
      SpTBXSkinGroupItem3.Recreate;
    end;
  end;

  //保存レイアウトを適用
  if not FileExists(Config.BasePath + LAYOUT_INI) then
    SkinManager.SetSkin('Xito')
  else
    SpTBXCustomizer.Load(Config.BasePath + LAYOUT_INI);

  //お気に入り
  favorites := TFavorites.Create;
  favorites.name := 'お気に入り';
  favorites.Load(Config.BasePath + FAVORITES_DAT);
  UpdateFavorites;

  ActionStayOnTop.Execute;
  ActionToggleMenuBar.Execute;
  ActionToggleToolBar.Execute;
  ActionToggleSearchBar.Execute;
  ActionToggleTitleBar.Execute;
  ActionToggleLogPanel.Execute;  
  ActionToggleFavoritePanel.Execute;
  ActionToggleVideoInfoPanel.Execute;
  ActionToggleVideoRelatedPanel.Execute;
  ActionToggleSearchPanel.Execute;
  ActionTogglePanelSearchToolBar.Execute;
  ActionToggleSplitter.Execute;

  ActionToolBarFixed.Execute;

  ActionChangeVideoScale.Execute;

  if not IsOK then
  begin
    LabelFlash.Visible := True;
    LabelFlash2.Visible := True;
    LabelWSH.Visible := True;
    LabelWSH2.Visible := True;
    CheckBoxThrough.Visible := True;

    LabelFlash.Caption := LABEL_FLASH_CAPTION;
    LabelFlash2.Caption := LABEL_FLASH2_CAPTION;
    LabelWSH.Caption := LABEL_WSH_CAPTION;
    LabelWSH2.Caption := LABEL_WSH2_CAPTION;

    ActionSave.Enabled := false;
    ActionAddTag.Enabled := false;
    ActionAddAuthor.Enabled := false;

    ActionOpenNew.Enabled := false;
    ActionOpenByBrowser.Enabled := false;
    ActionOpenPrimarySite.Enabled := false; 
    ActionCopyTitle.Enabled := false;
    ActionCopyTU.Enabled := false;
    ActionCopyURL.Enabled := false;
    ActionClearVideoPanel.Enabled := false;
    ActionAddFavorite.Enabled := false;
    ToolButtonAddFavorite.Enabled := false;
    ToolButtonAddFavorite.Checked := false;
    ActionRefresh.Enabled := false;
    ActionSearchBarSearch.Enabled := false;
    ActionSearchBarSearch2.Enabled := false;
    Log('');
    Log('WSH/FlashPlayerを最新バージョンにアップデートしてください。'+ #13#10);
    Application.OnMessage := nil;
    exit;
  end;
  
  GetTimeZoneInformation(TimeZoneInfo);
  TimeZoneBias := TimeZoneInfo.Bias * 60;

  userImeMode := imDontCare;
  AsyncManager := TAsyncManager.Create;
  procGet  := nil;
  procGet2 := nil;
  procGet3 := nil;
  procGet4 := nil;
  LoadCustomImageList(Config.BasePath + MTOOLIMG_BMP, ImageList);

  RecentlyViewedVideos := TStringList.Create;
  if (Config.optRecentlyViewedCount > 0) and FileExists(Config.BasePath + RECENTLY_VIEWED_DAT) then
  try
    RecentlyViewedVideos.LoadFromFile(Config.BasePath + RECENTLY_VIEWED_DAT);
  except
  end;

  if Length(Config.optSkinPath) > 0 then
  begin
    LoadString(Config.optSkinPath  + HEADER_HTML_TEMPLATE, HeaderHTML);
    LoadString(Config.optSkinPath  + RES_HTML_TEMPLATE, ResHTML);
    LoadString(Config.optSkinPath  + FOOTER_HTML_TEMPLATE, FooterHTML);

    LoadString(Config.optSkinPath  + R_HEADER_HTML_TEMPLATE, R_HeaderHTML);
    LoadString(Config.optSkinPath  + R_CONTENT_HTML_TEMPLATE, R_ContentHTML);
    LoadString(Config.optSkinPath  + R_FOOTER_HTML_TEMPLATE, R_FooterHTML);

    LoadString(Config.optSkinPath  + S_HEADER_HTML_TEMPLATE, S_HeaderHTML);
    LoadString(Config.optSkinPath  + S_CONTENT_HTML_TEMPLATE, S_ContentHTML);
    LoadString(Config.optSkinPath  + S_FOOTER_HTML_TEMPLATE, S_FooterHTML);
  end;

  if Length(HeaderHTML) <= 0 then
    HeaderHTML := DEFAULT_HEADER;
  if Length(ResHTML) <= 0 then
    ResHTML    := DEFAULT_RES;
  if Length(FooterHTML) <= 0 then
    FooterHTML := DEFAULT_FOOTER;

  if Length(R_HeaderHTML) <= 0 then
    R_HeaderHTML  := R_DEFAULT_HEADER;
  if Length(R_ContentHTML) <= 0 then
    R_ContentHTML := R_DEFAULT_CONTENT;
  if Length(R_FooterHTML) <= 0 then
    R_FooterHTML  := R_DEFAULT_FOOTER;

  if Length(S_HeaderHTML) <= 0 then
    S_HeaderHTML  := S_DEFAULT_HEADER;
  if Length(S_ContentHTML) <= 0 then
    S_ContentHTML := S_DEFAULT_CONTENT;
  if Length(S_FooterHTML) <= 0 then
    S_FooterHTML  := S_DEFAULT_FOOTER;

  //ビデオパネル
  WebBrowserCreate;
  Clear(WebBrowser);

  //ビデオ情報パネル
  WebBrowser2 := TEmbeddedWB.Create(self);
  TWinControl(WebBrowser2).Parent := Self.SpTBXDockablePanelVideoInfo;
  TWinControl(WebBrowser2).Align := alClient;
  WebBrowser2.HandleNeeded;
  WebBrowser2.Loaded;
  WebBrowser2.UserAgent := Config.netUserAgent;
  WebBrowser2.UserInterfaceOptions := WebBrowser2.UserInterfaceOptions + [EnableThemes];
  WebBrowser2.Silent := True;
  WebBrowser2.DisableErrors.EnableDDE := false;
  WebBrowser2.DisableErrors.ScriptErrorsSuppressed := false;
  WebBrowser2.DisableErrors.fpExceptions := false;
  WebBrowser2.OnDocumentComplete := WebBrowserDocumentComplete;
  WebBrowser2.OnBeforeNavigate2 := WebBrowserBeforeNavigate2;
  WebBrowser2.EnableMessageHandler := false;
  WebBrowser2.DownloadOptions := WebBrowser2.DownloadOptions + [DontExecuteScripts];
  Clear(WebBrowser2);

  //関連ビデオパネル
  WebBrowser3 := TEmbeddedWB.Create(self);
  TWinControl(WebBrowser3).Parent := Self.SpTBXDockablePanelVideoRelated;
  TWinControl(WebBrowser3).Align := alClient;
  WebBrowser3.HandleNeeded;
  WebBrowser3.Loaded;
  WebBrowser3.UserAgent := Config.netUserAgent;
  WebBrowser3.UserInterfaceOptions := WebBrowser3.UserInterfaceOptions + [EnableThemes];
  WebBrowser3.Silent := True;
  WebBrowser3.DisableErrors.EnableDDE := false;
  WebBrowser3.DisableErrors.ScriptErrorsSuppressed := false;
  WebBrowser3.DisableErrors.fpExceptions := false;
  WebBrowser3.OnDocumentComplete := WebBrowserDocumentComplete;
  WebBrowser3.OnBeforeNavigate2 := WebBrowserBeforeNavigate2;
  WebBrowser3.EnableMessageHandler := false;
  WebBrowser3.DownloadOptions := WebBrowser3.DownloadOptions + [DontExecuteScripts];
  Clear(WebBrowser3);

  //検索パネル
  WebBrowser4 := TEmbeddedWB.Create(self);
  TWinControl(WebBrowser4).Parent := PanelBrowser;
  TWinControl(WebBrowser4).Align := alClient;
  WebBrowser4.HandleNeeded;
  WebBrowser4.Loaded;
  WebBrowser4.UserAgent := Config.netUserAgent;
  WebBrowser4.UserInterfaceOptions := WebBrowser4.UserInterfaceOptions + [EnableThemes];
  WebBrowser4.Silent := True;
  WebBrowser4.DisableErrors.EnableDDE := false;
  WebBrowser4.DisableErrors.ScriptErrorsSuppressed := false;
  WebBrowser4.DisableErrors.fpExceptions := false;
  WebBrowser4.OnDocumentComplete := WebBrowserDocumentComplete;
  WebBrowser4.OnBeforeNavigate2 := WebBrowserBeforeNavigate2;
  WebBrowser4.OnNavigateComplete2 := WebBrowser4NavigateComplete2;
  WebBrowser4.EnableMessageHandler := false;
  WebBrowser4.DownloadOptions := WebBrowser4.DownloadOptions + [DontExecuteScripts];
  Clear(WebBrowser4);

  if Config.netUseProxy and (Length(Config.netProxyServer) > 0) then
  begin
    SetProxy(Config.netProxyServer + ':' + IntToStr(Config.netProxyPort));
  end;

  RegExp.IgnoreCase := True;
  RegExp.Global := True;
  ClearVideoData;

  SearchList := TList.Create;
  AsinList := TList.Create;
  AsinRankList := TList.Create;
  currentSortColumn := high(integer);

  if (Length(StartUpURI) > 0) and not AnsiStartsStr('http', StartUpURI) then
  begin
    SetURI('');
    SearchBarComboBox.Text := StartUpURI;
    PanelSearchComboBox.Text := StartUpURI;
    ActionSearchBarSearch.Execute;
  end else
  begin
    RegExp.Pattern := GET_ICHIBA_ITEM;
    if RegExp.Test(StartUpURI) then //ニコニコ市場
    begin
      SetURI('');
      GetNicoIchibaExecute(StartUpURI);
    end else
    begin
      RegExp.Pattern := GET_MYLIST;
      if RegExp.Test(StartUpURI) then //マイリスト
      begin
        SetURI('');
        GetNicoMylistExecute(StartUpURI);
      end else
        SetURI(StartUpURI);
    end;
  end;

  ActiveControl := PanelMain;
  ToolbarSearchBar.OnResize := ToolbarSearchBarResize;
  ToolbarSearchBarResize(self);

  SearchBarComboBox.Items.Assign(Config.grepSearchList);
  PanelSearchComboBox.Items.Assign(Config.grepSearchList);

  ActionToggleSearchTargetExecute(nil);

  Panel.Tag := 300;

  //アップデートチェック
  if Config.optUpdateCheck then
    ActionCheckUpdateOnStartUpExecute(Self);
end;

//フォーム破棄時の処理
procedure TMainWnd.FormDestroy(Sender: TObject);
var
  s: Cardinal;
  //startpos, endpos: integer;
begin
  hide;
  ClearVideoData;
  
  if Assigned(SearchList) then
  begin
    ClearSearchList;
    SearchList.Free;
  end;

  if Assigned(AsinList) then
  begin
    ClearAsinList;
    AsinList.Free;
  end;

  if Assigned(AsinRankList) then
  begin
    ClearAsinRankList;
    AsinRankList.Free;
  end;

  SaveFavorites;
  favorites.Free;

  if Assigned(RecentlyViewedVideos) then
  begin
    if Config.optRecentlyViewedCount > 0 then
    begin
      try
        RecentlyViewedVideos.SaveToFile(Config.BasePath + RECENTLY_VIEWED_DAT)
      except
      end;
    end else
      SysUtils.DeleteFile(Config.BasePath + RECENTLY_VIEWED_DAT);
    RecentlyViewedVideos.Free;
  end;

  if (config.optSearchHistoryCount > 0) and (Config.grepSearchList.Text <> '') then
  begin
    while config.optSearchHistoryCount < Config.grepSearchList.Count do
    begin
      Config.grepSearchList.Delete(Config.grepSearchList.Count -1);
    end;
    try
      Config.grepSearchList.SaveToFile(Config.BasePath + HISTORY_TXT)
    except
    end;
  end
  else
    SysUtils.DeleteFile(Config.BasePath + HISTORY_TXT);

  ToolbarSearchBar.OnResize := nil;
  SpTBXCustomizer.Save(Config.BasePath + LAYOUT_INI);

  if Assigned(Config) then
  begin
    if Config.Modified then
    begin
      {
      if (Length(Config.optNicoVideoSession) > 0) and (AnsiPos('user_session=', Config.optNicoVideoSession) > 0) then
      begin
        startpos := PosEx('user_session=', Config.optNicoVideoSession, 0);
        endpos := PosEx(';', Config.optNicoVideoSession, startpos);
        Config.optNicoVideoSession := Copy(Config.optNicoVideoSession, startpos, endpos - startpos);
      end;
      }
      Config.Save;
    end;
    Config.Free;
  end;

  if Assigned(AsyncManager) then
  begin
    AsyncManager.WaitForTerminateAll;
    AsyncManager.Free;
  end;
  if Assigned(HogeMutex) then
    HogeMutex.Free;
  if Assigned(MyWindowHandle) then
    MyWindowHandle.Free;

  if Assigned(WebBrowser) then
  begin
    Clear(WebBrowser);
    s := GetTickCount;
    while not DocComplete do
    begin
      Application.ProcessMessages;
      sleep(1);
      if (GetTickCount > s + 10000) then
        break;
    end;
    WebBrowser.Free;
  end;

  if Assigned(WebBrowser2) then
  begin
    Clear(WebBrowser2);
    s := GetTickCount;
    while not DocComplete2 do
    begin
      Application.ProcessMessages;
      sleep(1);
      if (GetTickCount > s + 10000) then
        break;
    end;
    WebBrowser2.Free;
  end;

  if Assigned(WebBrowser3) then
  begin
    Clear(WebBrowser3);
    s := GetTickCount;
    while not DocComplete3 do
    begin
      Application.ProcessMessages;
      sleep(1);
      if (GetTickCount > s + 10000) then
        break;
    end;
    WebBrowser3.Free;
  end;

  if Assigned(WebBrowser4) then
  begin
    Clear(WebBrowser4);
    s := GetTickCount;
    while not DocComplete4 do
    begin
      Application.ProcessMessages;
      sleep(1);
      if (GetTickCount > s + 10000) then
        break;
    end;
    WebBrowser4.Free;
  end;
end;

//タスクトレイからの復帰時用
procedure TMainWnd.FormShow(Sender: TObject);
begin
  if TrayIcon.Visible then
    TrayIcon.Hide;
  //if Config.optUseDefaultTitleBar then  //環境によりアプリケーションが最大化できない対策
  begin
    Constraints.MaxWidth := 3200;
    Constraints.MaxHeight := 2400;
  end;
end;

//リンククリック時の処理
procedure TMainWnd.WebBrowserBeforeNavigate2(Sender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
var
  i: integer;
  s: Cardinal;
  command: String;
  Si:TStartupInfo;
  Pi:TProcessInformation;

  Matches: MatchCollection;
  SearchWord: String;
begin
  if (Length(URL) > 0) and
     (AnsiStartsStr('http://', URL) or AnsiStartsStr('https://', URL)) and
     not ((Sender = WebBrowser) and (SameText(NICOVIDEO_ICHIBA_URI, URL) or AnsiStartsStr(NICOVIDEO_ICHIBA_RANK_URI, URL))) and
     not SameText(NICOVIDEO_LOGOUT_URI, URL) and
     not SameText(YOUTUBE_LOGOUT_URI, URL) and
     not AnsiEndsStr('.swf', URL) and //YouTubeプレイヤーからの呼び出し
     (NicoVideoRetryCount = 0) and (YouTubeRetryCount = 0) then
  begin
    RegExp.Pattern := GET_USER_ITEM;
    if RegExp.Test(URL) then //YouTubeユーザー検索
    begin
      Cancel := true;
      SearchWord := 'user:' + RegExp.Replace(URL, '$1');
      SearchBarComboBox.Text := SearchWord;
      PanelSearchComboBox.Text := SearchWord;
      ActionSearchBarSearch.Execute;
      exit;
    end;

    RegExp.Pattern := GET_ICHIBA_ITEM;
    if RegExp.Test(URL) then //ニコニコ市場
    begin
      Cancel := true;
      GetNicoIchibaExecute(URL);
      exit;
    end;

    RegExp.Pattern := GET_MYLIST;
    if RegExp.Test(URL) then //マイリスト
    begin
      Cancel := true;
      GetNicoMylistExecute(URL);
      exit;
    end;

    RegExp.Pattern := 'http://www\.nicovideo\.jp/tag/(.+)';
    if RegExp.Test(URL) then //ニコニコ動画のタグ検索
    begin
      Cancel := true;
      Matches := RegExp.Execute(URL) as MatchCollection;
      SearchWord := AnsiString(Match(Matches.Item[0]).Value);
      if Length(SearchWord) > 0 then
      begin
        SearchWord := RegExp.Replace(SearchWord, '$1');
        SearchBarComboBox.Text := UTF8toAnsi(URLDecode(SearchWord));
        if Config.optSearchTarget <> 24 then
        begin
          Self.tag := 24;
          ActionToggleSearchTargetExecute(Self);
        end;
        if ActionSearchBarSearch.Enabled then
          ActionSearchBarSearch.Execute;
      end;
      exit;
    end;

    for i := Low(URI_TARGET) to High(URI_TARGET) do
    begin
      RegExp.Pattern := URI_TARGET[i];
      if RegExp.Test(URL) then
      begin
        Cancel := true;

        if (tmpID = RegExp.Replace(URL, '$1')) then //cf.http://www.nicovideo.jp/watch/sm5327131
          exit;

        if Config.optNewWindowAnytime then
        begin
          command := Application.ExeName + ' ' + URL;
          GetStartupInfo(Si);
          CreateProcess(nil, PAnsiChar(command), nil, nil, false, 0, nil, nil, Si, Pi);
          CloseHandle(Pi.hProcess);
          CloseHandle(Pi.hThread);
          exit;
        end else
        begin
          ClearVideoData;
          Clear(WebBrowser);
          Clear(WebBrowser2);
          Clear(WebBrowser3);
          s := GetTickCount;
          while not DocComplete do
          begin
            Application.ProcessMessages;
            sleep(1);
            if (GetTickCount > s + 10000) then
              break;
          end;
          SetURI(URL);
          exit;
        end;
      end;
    end;
    Cancel := true;
    OpenByBrowser(URL);
  end;
end;

//ビデオパネル用
procedure TMainWnd.WebBrowserNavigateComplete2(ASender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);
var
  loginURL, flag, target, PostData, Headers, URL2: OleVariant;
  Data: Pointer;
  strPostData: string;
  (*
  NicoTitle: String;
  Source: String;
  Matches: MatchCollection;
  *)
begin
  if ((tmpURI = NICOVIDEO_LOGOUT_URI) and SameText(NICOVIDEO_URI, URL)) or //ニコニコ動画はログアウト後トップに
     ((tmpURI = YOUTUBE_LOGOUT_URI) and SameText(YOUTUBE_LOGOUT_URI, URL)) then
  begin
    SetURI('');
    Log('ログアウト完了');
    MessageBeep(MB_ICONASTERISK);
    MessageDlg('ログアウトしました。', mtInformation, [mbOK], -1);
  end
  (*YouTubeのログインの仕様が変わったためログインできなくなった。
    対策法が見つかるまでコメントアウトする。
  else if (VideoData.video_type in [0]) and
          not SameText(URL, 'about:blank') and (YouTubeRetryCount in [1,2,3,100,101,102]) then //YouTube
  begin
    Inc(YouTubeRetryCount);
    Config.optYouTubeSession := WebBrowser.Cookie;
    //Config.Modified := True;
    if Length(Config.optYouTubeSession) > 0 then
    begin
      if (AnsiPos('LOGIN_INFO=', Config.optYouTubeSession) = 0) then
      begin
        if not (YouTubeRetryCount in [2,101]) then
        begin
          Log('Cookie取得失敗');
          Clear(WebBrowser);
          LabelURL.Caption := '【データ取得失敗】' + tmpURI2Form;
          exit;
        end;
        OleVariant(WebBrowser.Document).write('');
        WebBrowser.Refresh;
        Log('ログイン中...');
        loginURL := YOUTUBE_LOGIN_URI;
        flag := EmptyParam;
        target := EmptyParam;
        strPostData  := 'username=' + URLEncode(Config.optYouTubeAccount) + '&password=' + URLEncode(Config.optYouTubePassword) + '&action_login=Log+In';
        PostData := VarArrayCreate([0, Length(strPostData) - 1], varByte);
        Data := VarArrayLock(PostData);
        try
          Move(strPostData[1], Data^, Length(strPostData));
        finally
          VarArrayUnlock(PostData);
        end;
        Headers := 'Content-Type: application/x-www-form-urlencoded';
        WebBrowser.Navigate2(loginURL, flag, target, PostData, Headers);
        exit;
      end else //ログイン中
      begin
        if (AnsiPos('is_adult=', Config.optYouTubeSession) = 0) then
        begin
          if not (YouTubeRetryCount in [2,3,101,102]) then
          begin
            Log('Cookie取得失敗');
            Clear(WebBrowser);
            LabelURL.Caption := '【データ取得失敗】' + tmpURI2Form;
            exit;
          end;
          OleVariant(WebBrowser.Document).write('');
          WebBrowser.Refresh;
          Log('認証中...');
          loginURL := YOUTUBE_VERIFY_AGE_URI;
          flag := EmptyParam;
          target := EmptyParam;
          strPostData  := 'next_url=/watch?v=' + VideoData.video_id + '&action_confirm=Confirm';
          PostData := VarArrayCreate([0, Length(strPostData) - 1], varByte);
          Data := VarArrayLock(PostData);
          try
            Move(strPostData[1], Data^, Length(strPostData));
          finally
            VarArrayUnlock(PostData);
          end;
          Headers := 'Content-Type: application/x-www-form-urlencoded';
          WebBrowser.Navigate2(loginURL, flag, target, PostData, Headers);
          exit;
        end;
      end;
      Log('Cookie取得完了');
    end else
    begin
      if (YouTubeRetryCount > 2) or not IsPrivacyZoneOK then
      begin
        Log('Cookie取得失敗');
        Clear(WebBrowser);
        LabelURL.Caption := '【データ取得失敗】' + tmpURI2Form;
        exit;
      end else
      begin
        OleVariant(WebBrowser.Document).write('');
        WebBrowser.Refresh;
        Log('ログイン中...');
        loginURL := YOUTUBE_LOGIN_URI;
        flag := EmptyParam;
        target := EmptyParam;
        strPostData  := 'username=' + URLEncode(Config.optYouTubeAccount) + '&password=' + URLEncode(Config.optYouTubePassword) + '&action_login=Log+In';
        PostData := VarArrayCreate([0, Length(strPostData) - 1], varByte);
        Data := VarArrayLock(PostData);
        try
          Move(strPostData[1], Data^, Length(strPostData));
        finally
          VarArrayUnlock(PostData);
        end;
        Headers := 'Content-Type: application/x-www-form-urlencoded';
        WebBrowser.Navigate2(loginURL, flag, target, PostData, Headers);
        exit;
      end;
    end;

    OleVariant(WebBrowser.Document).write('');
    WebBrowser.Refresh;

    if (Length(Config.optYouTubeSession) > 0) and (AnsiPos('youtube.com', WebBrowser.LocationURL) > 0) then
    begin
      Log('');
      Log('データ取得開始 ' + YOUTUBE_GET_WATCH_URI + VideoData.video_id + Config.optMP4Format);
      procGet := AsyncManager.Get(YOUTUBE_GET_WATCH_URI + VideoData.video_id + Config.optMP4Format, OnDoneYouTube, OnYouTubePreConnect);
    end;
  end
  *)
  else if (VideoData.video_type in [1..5]) and
       not SameText(URL, 'about:blank') and (NicoVideoRetryCount in [1,2,100,101,200,255]) then //nicovideo
  begin
    Inc(NicoVideoRetryCount);
    Config.optNicoVideoSession := WebBrowser.Cookie;
    Config.optNicoVideoSession := CustomStringReplace(Config.optNicoVideoSession,  'col=4', 'col=2');
    //Config.Modified := True;
    if Length(Config.optNicoVideoSession) > 0 then
    begin
      if ((NicoVideoRetryCount = 2) and (AnsiPos('user_session=', Config.optNicoVideoSession) = 0)) or (NicoVideoRetryCount = 101) then
      begin
        OleVariant(WebBrowser.Document).write('');
        WebBrowser.Refresh;
        Log('ログイン中...');
        loginURL := NICOVIDEO_LOGIN_URI;
        flag := EmptyParam;
        target := EmptyParam;
        strPostData  := 'mail=' + URLEncode(Config.optNicoVideoAccount) + '&password=' + URLEncode(Config.optNicoVideoPassword);
        PostData := VarArrayCreate([0, Length(strPostData) - 1], varByte);
        Data := VarArrayLock(PostData);
        try
          Move(strPostData[1], Data^, Length(strPostData));
        finally
          VarArrayUnlock(PostData);
        end;
        NicoVideoRetryCount := 200;
        Headers := 'Content-Type: application/x-www-form-urlencoded';
        WebBrowser.Navigate2(loginURL, flag, target, PostData, Headers);
        exit;
      end;
      Log('Cookie取得完了');
    end else
    begin
      if (NicoVideoRetryCount > 2) or not IsPrivacyZoneOK then
      begin
        Log('Cookie取得失敗');
        Clear(WebBrowser);
        LabelURL.Caption := '【データ取得失敗】' + tmpURI2Form;
        exit;
      end else
      begin
        OleVariant(WebBrowser.Document).write('');
        WebBrowser.Refresh;
        Log('ログイン中...');
        loginURL := NICOVIDEO_LOGIN_URI;
        flag := EmptyParam;
        target := EmptyParam;
        strPostData  := 'mail=' + URLEncode(Config.optNicoVideoAccount) + '&password=' + URLEncode(Config.optNicoVideoPassword);
        PostData := VarArrayCreate([0, Length(strPostData) - 1], varByte);
        Data := VarArrayLock(PostData);
        try
          Move(strPostData[1], Data^, Length(strPostData));
        finally
          VarArrayUnlock(PostData);
        end;
        NicoVideoRetryCount := 200;
        Headers := 'Content-Type: application/x-www-form-urlencoded';
        WebBrowser.Navigate2(loginURL, flag, target, PostData, Headers);
        exit;
      end;
    end;

    (*
    Source := WebBrowser.DocumentSource;
    RegExp.Pattern := GET_TITLE;
    try
      if RegExp.Test(Source) then
      begin
        Matches := RegExp.Execute(Source) as MatchCollection;
        VideoData.video_title := AnsiString(Match(Matches.Item[0]).Value);
        if Length(VideoData.video_title) > 0 then
        begin
          VideoData.video_title := RegExp.Replace(VideoData.video_title, '$1');

          RegExp.Pattern := GET_NICO_TITLE;
          if RegExp.Test(VideoData.video_title) then
          begin
            Matches := RegExp.Execute(VideoData.video_title) as MatchCollection;
            NicoTitle := AnsiString(Match(Matches.Item[0]).Value);
            VideoData.video_title := CustomStringReplace(VideoData.video_title, NicoTitle, '', True);
          end;
          {
          VideoData.video_title := CustomStringReplace(VideoData.video_title, '‐ニコニコ動画(SP1)', '', True);
          VideoData.video_title := CustomStringReplace(VideoData.video_title, '‐ニコニコ動画(SP2)', '', True); //一応
          VideoData.video_title := CustomStringReplace(VideoData.video_title, '‐ニコニコ動画(SP3)', '', True); //一応
          }
          VideoData.video_title := CustomStringReplace(VideoData.video_title, '‐ニコニコ動画', '', True); //βが外れた時用

          VideoData.video_title := CustomStringReplace(VideoData.video_title,  '&quot;', '"');
          VideoData.video_title := CustomStringReplace(VideoData.video_title,  '&amp;', '&');
          VideoData.video_title := CustomStringReplace(VideoData.video_title,  '&lt; ', '<');
          VideoData.video_title := CustomStringReplace(VideoData.video_title,  '&gt;', '>');
          Log('タイトル:' + VideoData.video_title);
        end;
      end;
    except
      on E: Exception do
      begin
        Log(e.Message  + #13#10 + Source + #13#10 + RegExp.Pattern);
        Log('タイトルの分析に失敗しました。');
      end;
    end;
    *)

    OleVariant(WebBrowser.Document).write('');
    WebBrowser.Refresh;

    if (Length(Config.optNicoVideoSession) > 0) and
       (AnsiPos('nicovideo.jp', WebBrowser.LocationURL) > 0) then
    begin
      Log('');
      if NicoVideoRetryCount = 201 then //ログイン直後
      begin
        Config.optNicoVideoSession := '';
        Log('Cookie取得開始');
        NicoVideoRetryCount := 255;
        flag := $0E;
        if VideoData.video_type = 5 then
          URL2 := NICOVIDEO_URI + '?p=' + VideoData.video_id
        else
          URL2 := NICOVIDEO_GET_URI + VideoData.video_id + NICOVIDEO_GET_URI_AFTER;
        WebBrowser.Navigate2(URL2, flag);
      end else
      begin
        if VideoData.video_type = 5 then
        begin
          Log('データ取得開始 ' + NICOVIDEO_URI + '?p=' + VideoData.video_id);
          procGet := AsyncManager.Get(NICOVIDEO_URI + '?p=' + VideoData.video_id, OnDoneNicoVideo, OnNicoVideoPreConnect);
        end else
        begin
          //Log('データ取得開始 ' + NICOVIDEO_GET_URI + VideoData.video_id);
          //procGet := AsyncManager.Get(NICOVIDEO_GET_URI + VideoData.video_id, OnDoneNicoVideo, OnNicoVideoPreConnect);
          Log('データ取得開始 ' + WebBrowser.LocationURL);
          procGet := AsyncManager.Get(WebBrowser.LocationURL, OnDoneNicoVideo, OnNicoVideoPreConnect);
        end;
      end;
    end;
  end;
end;

//検索パネル用
procedure TMainWnd.WebBrowser4NavigateComplete2(ASender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);
var
  loginURL, flag, target, PostData, Headers: OleVariant;
  Data: Pointer;
  strPostData: string;
begin
  if SameText(URL, NICOVIDEO_URI) and (Length(tmpSearchURI) > 0) and
    (NicoVideoRetryCount in [1,2,100,101]) then //nicovideo
  begin
    Inc(NicoVideoRetryCount);
    Config.optNicoVideoSession := WebBrowser4.Cookie;
        Config.optNicoVideoSession := CustomStringReplace(Config.optNicoVideoSession,  'col=4', 'col=2');
    Config.Modified := True;
    if Length(Config.optNicoVideoSession) > 0 then
    begin
      if (AnsiPos('user_session=', Config.optNicoVideoSession) = 0) or (NicoVideoRetryCount = 101) then
      begin
        OleVariant(WebBrowser4.Document).write('');
        WebBrowser4.Refresh;
        Log('ログイン中...');
        loginURL := NICOVIDEO_LOGIN_URI;
        flag := EmptyParam;
        target := EmptyParam;
        strPostData  := 'mail=' + URLEncode(Config.optNicoVideoAccount) + '&password=' + URLEncode(Config.optNicoVideoPassword);
        PostData := VarArrayCreate([0, Length(strPostData) - 1], varByte);
        Data := VarArrayLock(PostData);
        try
          Move(strPostData[1], Data^, Length(strPostData));
        finally
          VarArrayUnlock(PostData);
        end;
        Headers := 'Content-Type: application/x-www-form-urlencoded';
        WebBrowser4.Navigate2(loginURL, flag, target, PostData, Headers);
        exit;
      end;
      Log('Cookie取得完了');
    end else
    begin
      if (NicoVideoRetryCount > 2) or not IsPrivacyZoneOK then
      begin
        Log('Cookie取得失敗');
        Clear(WebBrowser4);
        LabelURL.Caption := '【データ取得失敗】' + tmpURI2Form;
        SpTBXDockablePanelSearch.Caption := '【データ取得失敗】';
        exit;
      end else
      begin
        OleVariant(WebBrowser4.Document).write('');
        WebBrowser4.Refresh;
        Log('ログイン中...');
        loginURL := NICOVIDEO_LOGIN_URI;
        flag := EmptyParam;
        target := EmptyParam;
        strPostData  := 'mail=' + URLEncode(Config.optNicoVideoAccount) + '&password=' + URLEncode(Config.optNicoVideoPassword);
        PostData := VarArrayCreate([0, Length(strPostData) - 1], varByte);
        Data := VarArrayLock(PostData);
        try
          Move(strPostData[1], Data^, Length(strPostData));
        finally
          VarArrayUnlock(PostData);
        end;
        Headers := 'Content-Type: application/x-www-form-urlencoded';
        WebBrowser4.Navigate2(loginURL, flag, target, PostData, Headers);
        exit;
      end;
    end;

    Clear(WebBrowser4);

    if (Length(Config.optNicoVideoSession) > 0) and ActionSearchBarSearch.Enabled then
    begin
      ActionSearchBarSearch.Enabled := false;
      ActionSearchBarSearch2.Enabled := false;
      ActionSearchBarAdd100.Enabled := false;

      MenuSearchNicoVideo.Enabled := false;
      MenuSearchYouTube.Enabled := false;

      PanelBrowser.Visible := false;
      PanelListView.Visible := true;
      ActionSearchBarToggleListView.Checked := false;
      ActionSearchBarToggleListView.Enabled := false;
      Log('');
      Log('再取得開始');
      case SearchType of
        1,3,4,6: procGet3 := AsyncManager.Get(tmpSearchURI, OnNicoVideoSearch, OnNicoVideoPreConnect);
        2:       procGet3 := AsyncManager.Get(tmpSearchURI, OnNicoVideoGetRanking, OnNicoVideoPreConnect);
        8:       procGet3 := AsyncManager.Get(tmpSearchURI, OnDoneNicoMyList, OnNicoVideoPreConnect);
      end;
    end;
  end;
end;

//タイトルバーの変更に対応
procedure TMainWnd.WebBrowserTitleChange(ASender: TObject; const Text: WideString);
begin
  ;
end;

//ログに書き込む
procedure TMainWnd.Log(const str: string);
var
  txt: String;
  SelPos: Integer;
begin
  while 256 <= MemoLog.Lines.Count do
  begin
    MemoLog.SelStart := 0;
    MemoLog.SelLength := SendMessage(MemoLog.Handle, EM_LINEINDEX, 96, 0);
    MemoLog.SelText := '';
  end;
  if 0 < MemoLog.Lines.Count then
    txt := #13#10 + str
  else
    txt := str;
  SelPos := SendMessage(MemoLog.Handle, WM_GETTEXTLENGTH, 0, 0);
  SendMessage(MemoLog.Handle, EM_SETSEL, SelPos, SelPos);
  SendMessage(MemoLog.Handle, EM_REPLACESEL, 0, Longint(PChar(txt)));
  SendMessage(MemoLog.Handle, EM_SETSEL, SelPos, SelPos);
  MemoLog.SelStart := SelPos;
  MemoLog.SelLength := 0;
end;

procedure TMainWnd.Log(const FormatStr: string; FormatAry: array of const);
begin
  Log(Format(FormatStr, FormatAry));
end;

//カスタムイメージを読み込んで適用する
procedure TMainWnd.LoadCustomImageList(const path: string; var ImageList: TImageList);
var
  bmpl, bmps: TBitmap;
  size, i, j: Integer;
begin
  if not FileExists(path) then
    exit;
  bmpl := TBitmap.Create;
  bmpl.LoadFromFile(path);
  size := bmpl.Height;
  bmps := TBitmap.Create;
  bmps.Height := size;
  bmps.Width := size;
  ImageList.Clear;
  ImageList.Height := size;
  ImageList.Width := size;
  j := 0;
  for i := 0 to bmpl.width div size - 1 do
  begin
    BitBlt(bmps.Canvas.Handle,0,0,size,size,bmpl.Canvas.Handle,j,0,SRCCOPY);
    ImageList.AddMasked(bmps, clFuchsia);
    j := j + size;
  end;
  bmpl.Free;
  bmps.Free;
end;

//最小化時にタスクトレイに格納
procedure TMainWnd.ApplicationEventsMinimize(Sender: TObject);
var
  s: Cardinal;
begin
  if Config.optCloseToTray then
  begin
    Hide;
    ShowWindow(Application.Handle, SW_HIDE);
    TrayIcon.Show;
  end;
  if Config.optClearVideo and (Length(tmpURI) > 0) then
  begin
    ClearVideoData;
    Clear(WebBrowser);
    Clear(WebBrowser2);
    Clear(WebBrowser3);
    s := GetTickCount;
    while not DocComplete do
    begin
      Application.ProcessMessages;
      sleep(1);
      if (GetTickCount > s + 10000) then
        break;
    end;
    SetURI('');
  end;
end;

//タスクトレイから終了
procedure TMainWnd.ActionTaskTrayCloseExecute(Sender: TObject);
begin
  TrayIcon.Hide;
  Close;
end;

//タスクトレイから復帰
procedure TMainWnd.ActionTaskTrayRestoreExecute(Sender: TObject);
begin
  MainWndRestore;
end;

//タスクトレイ上のクリック処理
procedure TMainWnd.TrayIconMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    MainWndRestore;
  end;
end;

//タスクトレイから復帰
procedure TMainWnd.MainWndRestore;
begin
  ShowWindow(Application.Handle,SW_SHOW);
  Application.Restore;
  Show;
  SetFocus;
  Application.BringToFront;
end;

//マウス・キーイベントをフックする
procedure TMainWnd.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);

  function MouseInPane(control: TControl; point: TPoint): boolean;
  begin
    Result := False;
    if not InvalidPoint(point) then
    begin
      point := control.ScreenToClient(point);
      result := (0 <= point.X) and (point.X < control.Width) and
                (0 <= point.Y) and (point.Y < control.Height);
    end;
  end;

var
  pt: TPoint;
  Wnd: HWND;
  FOleInPlaceActiveObject: IOleInPlaceActiveObject;
begin

  case Msg.message of
    WM_KEYDOWN: //WebBrowssrのメッセージを処理する
    begin
      if (WebBrowser <> nil) and (WebBrowser.Document <> nil) and
         (IsChild(WebBrowser.Handle, Msg.hwnd)) and
         (VideoData.video_type in [1..5]) then  //ニコニコ動画
      begin
        try
          FOleInPlaceActiveObject := WebBrowser.ControlInterface as IOleInPlaceActiveObject;
          Handled := (FOleInPlaceActiveObject.TranslateAccelerator(Msg)) = S_OK;
          if not Handled and
             ((Msg.wParam = VK_LEFT) or (Msg.wParam = VK_RIGHT)) then
          begin
            Handled := True;
            TranslateMessage(Msg);
            DispatchMessage(Msg);
          end;
        except
          Log('ERROR:ApplicationEventsMessage');
        end;
      end;
    end;
    WM_RBUTTONDOWN:
    begin
      if not Active then
        exit;
      if (GetKeyState(VK_LBUTTON) < 0) or (GetKeyState(VK_CONTROL) < 0) then
        exit;
      pt := Msg.pt;
      if MouseInPane(WebBrowser, pt) then
      begin
        RightClicked := True;
        Handled := True;
      end;
    end;
    WM_RBUTTONUP:
    begin
      if not Active then
        exit;
      if RightClicked then
      begin
        RightClicked := false;
        pt := Msg.pt;
        if MouseInPane(WebBrowser, pt) then //ビデオパネル右クリック時に独自メニューを出す
          PopupMenu.Popup(pt.X, pt.Y);
        Handled := True;
      end;
    end;
    WM_MOUSEWHEEL:
    begin
      if Config.optWheelScrollUnderCursor then //ホイールメッセージをマウスカーソル下のコントロールに送る
      begin
        Wnd := WindowFromPoint(Point(Smallint(LOWORD(Msg.lParam)), Smallint(HIWORD(Msg.lParam))));
        if (Wnd <> 0) and (Msg.hwnd <> Wnd) then
        begin
          Handled := true;
          SendMessage(Wnd, Msg.message, Msg.wParam, Msg.lParam);
        end;
      end;
    end;
    (*
    //左クリック押下中に移動可能にする
    WM_LBUTTONDOWN:
    begin
      DragMoving := True;
      ClickPos := Msg.pt;
      PrevLeft := Self.Left;
      PrevTop := Self.Top;
      Handled := True;
    end;
    WM_LBUTTONUP:
    begin
      DragMoving := False;
    end;
    WM_MOUSEMOVE:
    begin
      pt := Msg.pt;
      if DragMoving and (pt.X <> ClickPos.X) or (pt.Y <> ClickPos.Y) then
      begin
        ReleaseCapture;
        SendMessage(Handle, WM_SYSCOMMAND, SC_MOVE or 2, MakeLParam(pt.X, pt.Y));
        DragMoving := False;
      end;
    end;
    *)
  end;
end;

//アプリが非アクティブになった際の処理
procedure TMainWnd.ApplicationEventsDeactivate(Sender: TObject);
begin
  (*
  //最前面時にリストのツールチップが出ないことへの対策
  if Config.optFormStayOnTop and not ToolbarMainMenu.Floating and
     not ToolBarToolBar.Floating and not ToolbarSearchBar.Floating and
     not SpTBXDockablePanelSearch.Floating and not SpTBXDockablePanelVideoInfo.Floating and
     not SpTBXDockablePanelVideoRelated.Floating and not ToolbarTitleBar.Floating and
     not SpTBXDockablePanelLog.Floating then
    SetWindowPos(Handle,HWND_TOPMOST,0,0,0,0,SWP_NOSIZE or SWP_NOMOVE);
  *)
  if SpTBXTitleBar.Active then
    SpTBXTitleBar.InvalidateBackground;
  case Config.optDeactiveOption of
    0: exit;
    1: Application.Minimize;
    2:
     begin
       if Config.optAutoCloseTime > 0 then
       begin
         TimerAutoClose.Interval := Config.optAutoCloseTime * 1000;
         TimerAutoClose.Enabled := True;
       end else
         Application.MainForm.Close;
     end;
  end;
end;

//アプリがアクティブになった際の処理
procedure TMainWnd.ApplicationEventsActivate(Sender: TObject);
begin
  (*
  //最前面時にリストのツールチップが出ないことへの対策
  if Config.optFormStayOnTop and not ToolbarMainMenu.Floating and
     not ToolBarToolBar.Floating and not ToolbarSearchBar.Floating and
     not SpTBXDockablePanelSearch.Floating and not SpTBXDockablePanelVideoInfo.Floating and
     not SpTBXDockablePanelVideoRelated.Floating and not ToolbarTitleBar.Floating and
     not SpTBXDockablePanelLog.Floating then
    SetWindowPos(Handle,HWND_NOTOPMOST,0,0,0,0,SWP_NOSIZE or SWP_NOMOVE);
  *)
  if SpTBXTitleBar.Active then
    SpTBXTitleBar.InvalidateBackground;
  if TimerAutoClose.Enabled then
    TimerAutoClose.Enabled := false;
end;

//送られてきたURLを処理する
procedure TMainWnd.ON_WM_COPYDATA(var msg: TWMCopyData);
var
  buf: PChar;
  option: TStringList;
  i, j: integer;
  flag: boolean;
  URI: String;
  searchflag: boolean;
  searchword: String;
begin
  buf := StrAlloc(msg.CopyDataStruct.cbData);
  option := TStringList.Create;
  try
    StrCopy(buf, msg.CopyDataStruct.lpData);
    option.Text := buf;
    searchflag := false;
    for i := 0 to option.Count - 1 do
    begin
      if CompareStr('-s', option.Strings[i]) = 0 then
        searchflag := true;
    end;
    if searchflag then
    begin
      for i := 0 to option.Count - 1 do
      begin
        if CompareStr('-s', option.Strings[i]) <> 0 then
          searchword := searchword + ' ' + option.Strings[i];
      end;
      SearchBarComboBox.Text := searchword;
      PanelSearchComboBox.Text := searchword;
      ActionSearchBarSearch.Execute;
      exit;
    end;
    flag := false;
    for i := 0 to option.Count - 1 do
    begin
      try
        URI := option.Strings[i];

        RegExp.Pattern := GET_USER_ITEM;
        if RegExp.Test(URI) then //YouTubeユーザー検索
        begin
          URI := 'user:' + RegExp.Replace(URI, '$1');
          SearchBarComboBox.Text := URI;
          PanelSearchComboBox.Text := URI;
          ActionSearchBarSearch.Execute;
          break;
        end;

        RegExp.Pattern := GET_ICHIBA_ITEM;
        if RegExp.Test(URI) then //ニコニコ市場
        begin
          GetNicoIchibaExecute(URI);
          break;
        end;

        RegExp.Pattern := GET_MYLIST;
        if RegExp.Test(URI) then //マイリスト
        begin
          GetNicoMylistExecute(URI);
          break;
        end;

        for j := Low(URI_TARGET) to High(URI_TARGET) do
        begin
          RegExp.Pattern := URI_TARGET[j];
          if RegExp.Test(URI) then
          begin
            if (Length(tmpURI) > 0) and (tmpURI = URI) then
            begin
              flag := True;
              break;
            end;
            SetURIwithClear(URI);
            flag := True;
            break;
          end;
        end;
      except
        on E: Exception do
        begin
          MessageDlg(e.Message  + #13#10 + URI + #13#10 + RegExp.Pattern, mtError, [mbOK], -1);
          Log('');
          Log(e.Message  + #13#10 + URI + #13#10 + RegExp.Pattern);
          exit;
        end;
      end;
      if flag then
        break;
    end;
  finally
    StrDispose(buf);
    option.Free;
  end;
end;

//ビデオパネルを空にする
procedure TMainWnd.Clear(Browser: TEmbeddedWB);
var
  URL: OleVariant;
  flag: OleVariant;
begin
  if Assigned(Browser) then
  begin
    if Browser = WebBrowser then
      DocComplete := False
    else if Browser = WebBrowser2 then
      DocComplete2 := False
    else if Browser = WebBrowser3 then
      DocComplete3 := False
    else if Browser = WebBrowser4 then
      DocComplete4 := False;
    URL := 'about:blank';
    flag := $0E;
    Browser.Navigate2(URL, flag);
  end;
end;

//ページ書き換え完了後の処理
procedure TMainWnd.WebBrowserDocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  inherited;
  if Sender = WebBrowser then
  begin
    DocComplete  := True;
    if WebBrowser.Document = nil then
      exit;
    if (VideoData.video_type = 0) then //YouTube
    begin
      if TimerSetSetBounds.Enabled then
        TimerSetSetBoundsTimer(Self);
    end
    else if (VideoData.video_type in [1..5]) then //ニコニコ動画
    begin
      try
        WebBrowser.OleObject.Document.getElementById('flvplayer').SetVariable('Stage.scaleMode',0);
      except
        Log('ERROR:Stage.scaleMode');
      end;

      //動画の自動再生
      if Config.optNicoVideoAutoPlay then
      begin
        try
          WebBrowser.OleObject.Document.getElementById('flvplayer').SetVariable('autoPlayPremium', 1);
          WebBrowser.OleObject.Document.getElementById('flvplayer').SetVariable('videowindow.playButton._visible', 0);
          WebBrowser.OleObject.Document.getElementById('flvplayer').SetVariable('tabmenu.adView._visible', 0);
          WebBrowser.OleObject.Document.getElementById('flvplayer').SetVariable('video_base.thmbImage_mc._visible', 0);
        except
          Log('ERROR:autoPlayPremium');
        end;
      end;

      //広告、時報をオフ
      try
        WebBrowser.OleObject.Document.getElementById('flvplayer').SetVariable('GETMARQUEE_URL', '');
        WebBrowser.OleObject.Document.getElementById('flvplayer').SetVariable('tabmenu.adView._visible', 0);
      except
        Log('ERROR:autoPlayPremium');
      end;

      if TimerSetSetBounds.Enabled then
        TimerSetSetBoundsTimer(Self);
      TimerGetNicoVideoData.Interval := 5000;
      TimerGetNicoVideoData.Enabled := True;
    end;
  end
  else if Sender = WebBrowser2 then
    DocComplete2  := True
  else if Sender = WebBrowser3 then
    DocComplete3  := True
  else if Sender = WebBrowser4 then
    DocComplete4  := True;
end;

//targetを指定された場合用
procedure TMainWnd.WebBrowserNewWindow2(Sender: TObject;
  var ppDisp: IDispatch; var Cancel: WordBool);
begin
  ppDisp := WebBrowser2.Application;
end;

//ブラウザをクリアしてURLを開く
procedure TMainWnd.SetURIwithClear(URI: String);
var
  s: Cardinal;
begin
  ClearVideoData;
  Clear(WebBrowser);
  Clear(WebBrowser2);
  Clear(WebBrowser3);
  s := GetTickCount;
  while not DocComplete do
  begin
    Application.ProcessMessages;
    sleep(1);
    if (GetTickCount > s + 5000) then
      break;
  end;
  SetURI(URI);
end;

//URLをチェックして対応していれば取得する
procedure TMainWnd.SetURI(URI: String);
var
  innerHTML: String;
  i: integer;
  option: String;
  quality: String;
  URL: OleVariant;
  flag: OleVariant;
begin
  if (Length(URI) > 0) and (tmpURI = URI) then
    exit;

  USEPLAYER2 := Config.optUsePlayer2 xor (GetKeyState(VK_SHIFT) < 0); //Shiftキー押下時はトグル
  USELOCALPLAYER := Config.optUseLocalPlayer xor (GetKeyState(VK_SHIFT) < 0);  //Shiftキー押下時はトグル

  tmpURI := URI;
  tmpURI2Form :=  CustomStringReplace(tmpURI, '&', '&&', false);

  tmpID := '';
  ListView.Invalidate;
  ClearAsinList;

  if Length(URI) <= 0 then
  begin
    innerHTML := '<html><head><title>TubePlayer</title><style type="text/css">'#10 +
                 '<!--body{color: #000000;background: #000000;margin: 0;padding: 0;border: 0;overflow: hidden} -->'#10 +
                 '</style></head><body></body></html>';
    WebBrowser.LoadFromString(innerHTML);
    //WebBrowser.DisableMessageHandler;
    //WebBrowser.OnTranslateAccelerator := nil;
    ActiveControl := PanelMain;
    exit;
  end;

  try
    for i := Low(URI_TARGET) to High(URI_TARGET) do
    begin
      RegExp.Pattern := URI_TARGET[i];
      if RegExp.Test(URI) then
      begin
        VideoData.video_id := RegExp.Replace(URI, '$1');
        if i in [2,3,4] then
        begin
          if AnsiStartsStr('ut', VideoData.video_id) then
          begin
            VideoData.video_type := 1;
          end
          else if AnsiStartsStr('am', VideoData.video_id) then
          begin
            VideoData.video_type := 2;
          end
          else if AnsiStartsStr('sm', VideoData.video_id) then
          begin
            VideoData.video_type := 3;
          end
           else if AnsiStartsStr('so', VideoData.video_id) then //対応できるようにする
          begin
            OpenByBrowser(URI);
            ActionClearVideoPanelExecute(nil);
            exit;
          end
          else //それ以外
          begin
            VideoData.video_type := 4;
          end;
        end else
        if i = 5 then
        begin
          VideoData.video_type := 5;
        end;
        break;
      end;
    end;
  except
    on E: Exception do
    begin
      MessageDlg(e.Message  + #13#10 + URI + #13#10 + RegExp.Pattern, mtError, [mbOK], -1);
      Log('');
      Log(e.Message  + #13#10 + URI + #13#10 + RegExp.Pattern);
      exit;
    end;
  end;

  if (VideoData.video_type in [1..5]) and
     ((Length(Config.optNicoVideoAccount) = 0) or (Length(Config.optNicoVideoPassword) = 0)) then
  begin
    ShowMessage('ニコニコ動画の視聴にはアカウントが必要です。' + #13#10 + 'アカウント設定は、設定＞nicovideoでしてください。');
    exit;
  end;

  ActionOpenByBrowser.Enabled := True;
  ActionCopyTitle.Enabled := True;
  ActionCopyTU.Enabled := True;
  ActionCopyURL.Enabled := True;
  ActionClearVideoPanel.Enabled := True;
  ActionAddFavorite.Enabled := True;   
  ToolButtonAddFavorite.Enabled := True;
  case VideoData.video_type of
    0: ToolButtonAddFavorite.Checked := (favorites.Find('YouTube', VideoData.video_id) <> nil);
    1,2,3,4: ToolButtonAddFavorite.Checked := (favorites.Find('nicovideo', VideoData.video_id) <> nil);
    5: ToolButtonAddFavorite.Checked := (favorites.Find('nicovideo2', VideoData.video_id) <> nil);
  end;
  ActionRefresh.Enabled := True;

  if Config.optFormStayOnTopPlaying then
  begin
    Config.optFormStayOnTop := false;
    ActionStayOnTop.Execute;
  end;

  if (VideoData.video_type = 0) and not USEPLAYER2 then
  begin
    option := '';
    if Config.optAutoPlay then
      option := '&autoplay=1';

    case Config.optFPQuality of
      0: quality := FLASH_QUALITY[0];
      1: quality := FLASH_QUALITY[1];
      2: quality := FLASH_QUALITY[2];
      3: quality := FLASH_QUALITY[3];
      4: quality := FLASH_QUALITY[4];
    end;

    innerHTML := '<html><head><title>TubePlayer</title><style type="text/css">'#10 +
                 '<!-- body{color: #000000;background: #000000;margin: 0;padding: 0;border: 0;overflow: hidden}'#10 +
                 'embed#EmbedFlash{background: #000000;margin: 0;padding: 0; border: 0; width:expression(document.body.offsetWidth); height:expression(document.body.offsetHeight)} -->'#10 +
                 '</style></head><body>'#10 +
                 '<embed id="EmbedFlash" src=' +
                 YOUTUBE_VIDEO_PLAYER +
                 VideoData.video_id +
                 option +
                 ' type=application/x-shockwave-flash wmode=transparent quality=' +
                 quality +
                 '></embed></body></html>';

    WebBrowser.LoadFromString(innerHTML);

    Panel.Tag := 300;
    if (Self.WindowState = wsNormal) and
       (Config.optYouTubeWidthDef > 0) and (Config.optYouTubeHeightDef > 0) then
    begin
      Panel.Tag := 100;
      if SpTBXTitleBar.Active then
      begin
        Self.Width :=  Config.optYouTubeWidthDef + GetSystemMetrics(SM_CXFRAME) * 2 + Self.BorderWidth * 2 + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width + SpTBXSplitterLeft.Width + SpTBXSplitterRight.Width;
        Self.Height := Config.optYouTubeHeightDef + GetSystemMetrics(SM_CYFRAME) * 2 + DockTop.Height + DockBottom.Height + SpTBXTitleBar.FTitleBarHeight;
      end else
      begin
        Self.Width :=  Config.optYouTubeWidthDef + GetSystemMetrics(SM_CXFRAME) * 2 + Self.BorderWidth * 2 + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width + SpTBXSplitterLeft.Width + SpTBXSplitterRight.Width;
        Self.Height := Config.optYouTubeHeightDef + GetSystemMetrics(SM_CYCAPTION) + GetSystemMetrics(SM_CYSIZEFRAME) * 2 + DockTop.Height + DockBottom.Height;
      end;
    end;

    //SetBounds(Self.Left, Self.Top, Self.Width-1, Self.Height);
    PanelMain.BorderWidth := 1;
    TimerSetSetBounds.Enabled := True;
  end;

  tmpID := VideoData.video_id;
  YouTubeRetryCount := 0;
  NicoVideoRetryCount := 0;

  LabelURL.Caption := '【データ取得中】' + tmpURI2Form;
  Log('');
  case VideoData.video_type of
    0: //YouTube
      begin
        Log('データ取得開始 ' + YOUTUBE_GET_WATCH_URI + VideoData.video_id + Config.optMP4Format);
        procGet := AsyncManager.Get(YOUTUBE_GET_WATCH_URI + VideoData.video_id + Config.optMP4Format, OnDoneYouTube, OnYouTubePreConnect);
      end;
    1,2,3,4: //nicovideo
      begin
        Log('データ取得開始 ' + NICOVIDEO_GET_URI + VideoData.video_id + NICOVIDEO_GET_URI_AFTER);
        //procGet := AsyncManager.Get(NICOVIDEO_GET_URI + VideoData.video_id, OnDoneNicoVideo, OnNicoVideoPreConnect);
        NicoVideoRetryCount := 1;
        Log('');
        Log('Cookie取得開始');
        Config.optNicoVideoSession := '';
        //WebBrowser.Free;
        //WebBrowserCreate;
        URL := NICOVIDEO_GET_URI + VideoData.video_id + NICOVIDEO_GET_URI_AFTER;
        flag := $0E;
        WebBrowser.Navigate2(URL, flag);
      end;
    5: //nicovideo(?p=)
      begin
        Log('データ取得開始 ' + NICOVIDEO_URI + '?p=' + VideoData.video_id);
        //procGet := AsyncManager.Get(NICOVIDEO_URI + '?p=' + VideoData.video_id, OnDoneNicoVideo, OnNicoVideoPreConnect);
        NicoVideoRetryCount := 1;
        Log('');
        Log('Cookie取得開始');
        Config.optNicoVideoSession := '';
        //WebBrowser.Free;
        //WebBrowserCreate;
        URL := NICOVIDEO_URI + '?p=' + VideoData.video_id + '?oldplayer=1';
        flag := $0E;
        WebBrowser.Navigate2(URL, flag);
      end;
  end;
end;

//nicovideo取得時にcookieを追加する
procedure TMainWnd.OnNicoVideoPreConnect(sender: TAsyncReq; code: TAsyncNotifyCode);
begin
  if code <> ancPRECONNECT then
    exit;
  if Length(Config.optNicoVideoSession) > 0 then
    TAsyncReq(sender).IdHTTP.Request.CustomHeaders.Add('Cookie: ' + Config.optNicoVideoSession);


  //リダイレクトの設定
  TAsyncReq(sender).IdHTTP.HandleRedirects := True;
  TAsyncReq(sender).IdHTTP.RedirectMaximum := 2;
end;

//YouTube取得時にcookieを追加する
procedure TMainWnd.OnYouTubePreConnect(sender: TAsyncReq; code: TAsyncNotifyCode);
begin
  if code <> ancPRECONNECT then
    exit;
  if Length(Config.optYouTubeSession) > 0 then
    TAsyncReq(sender).IdHTTP.Request.CustomHeaders.Add('Cookie: ' + Config.optYouTubeSession);
end;

(*
//nicovideoセッションコード取得完了用
procedure TMainWnd.OnDoneNicoVideoSession(sender: TAsyncReq);
var
  Cookies: TIdCookies;
  i: integer;
begin
  if procGet = sender then
  begin
    Log('【nicovideo(OnDoneNicoVideoSession)】' + sender.IdHTTP.ResponseText);
    case sender.IdHTTP.ResponseCode of
    200,302:
      begin
        Cookies := sender.IdHTTP.CookieManager.CookieCollection;
        for i := 0 to Cookies.Count -1 do
        begin
          if SameText(Cookies[i].CookieName, 'user_session') then
          begin
            Config.optNicoVideoSession := Cookies[i].Value;
            Config.Modified := True;
            Log('セッションコード取得完了');
            break;
          end;
        end;
        if Length(Config.optNicoVideoSession) > 0 then
        begin
          Log('');
          Log('データ取得開始 ' + NICOVIDEO_GET_URI + VideoData.video_id);
          procGet := AsyncManager.Get(NICOVIDEO_GET_URI + VideoData.video_id, OnDoneNicoVideo, OnNicoVideoPreConnect);
          exit;
        end else
        begin
          Log('データの取得に失敗しました。');
          LabelURL.Caption := '【データ取得失敗】' + tmpURI2Form;
        end;
      end;
    else
      begin
        Log('データの取得に失敗しました。');
        LabelURL.Caption := '【データ取得失敗】' + tmpURI2Form;
      end;
    end;

    procGet := nil;
  end;
end;

//セッションコード取得用
procedure TMainWnd.OnNotify(sender: TAsyncReq; code: TAsyncNotifyCode);
begin
  case code of
  ancPRECONNECT:
    begin
      sender.IdHTTP.AllowCookies := True;
    end;
  end;
end;
*)

//nicovideo(ニコニコ動画)から取得した情報を処理する
procedure TMainWnd.OnDoneNicoVideo(sender: TAsyncReq);

  procedure GetRetry;
  var
    URL: OleVariant;
  begin
    if (NicoVideoRetryCount = 0) and
       (Length(Config.optNicoVideoAccount) > 0) and (Length(Config.optNicoVideoPassword) > 0) then
    begin
      Inc(NicoVideoRetryCount);
      Log('');
      Log('Cookie取得開始');
      Config.optNicoVideoSession := '';
      URL := NICOVIDEO_GET_URI + VideoData.video_id + NICOVIDEO_GET_URI_AFTER;
      WebBrowser.Navigate2(URL);
    end
    else if (NicoVideoRetryCount < 100) and (Length(Config.optNicoVideoSession) > 0) then
    begin
      NicoVideoRetryCount := 100;
      Log('');
      Log('Cookie再取得開始');
      Config.optNicoVideoSession := '';
      URL := NICOVIDEO_GET_URI + VideoData.video_id + NICOVIDEO_GET_URI_AFTER;
      WebBrowser.Navigate2(URL);
    end else
    begin
      Log('データの取得に失敗しました。');
      LabelURL.Caption := '【データ取得失敗】' + tmpURI2Form;
    end;
  end;

var
  i: integer;
  ContentList: TStringList;
  Content: String;
  Matches: MatchCollection;
  innerHTML: String;
  quality: String;
  title_flag: boolean;
  videoid_flag: boolean;

  NicoTitle: String;

  user_id: String;
  video_id: String;

  infoContents: String;
  tmpInfo: String;

  flvContents: String;
  ICHIBA_URI: String;
  busyflag: boolean;

  addVariable: String;
  Variable_flag: boolean;
  tmpVariable: String;
const
  GET_USER_ID  = 'user_id = ''(\d+)''';
  GET_VIDEO_ID = 'video_id = ''(\w+)''';

  GET_VARIABLE = 'so\.addVariable\("([^"]+)",[\s]+"([^"]+)"\)';

begin
  if procGet = sender then
  begin
    Log('【nicovideo(OnDoneNicoVideo)】' + sender.IdHTTP.ResponseText);
    case sender.IdHTTP.ResponseCode of
    200: (* OK *)
      begin
        busyflag := false;
        Log('データ分析開始');
        LabelURL.Caption := '【データ分析中】' + tmpURI2Form;

        title_flag := false;
        videoid_flag := false;

        user_id  := '';
        video_id := '';

        tmpInfo := '';
        infoContents := '';

        flvContents := '';

        addVariable := '';
        Variable_flag := false;

        ContentList := TStringList.Create;
        try
          ContentList.Text := procGet.Content;
          //Content := UTF8toAnsi(procGet.Content); では文字変換に失敗
          for i := 0 to ContentList.Count -1 do
          begin
            ContentList[i] := UTF8toAnsi(ContentList[i]);
            Content := ContentList[i];
            if Length(Content) <= 0 then
              Continue;

            if (AnsiPos(NICO_ACCESS_LOCKED, ContentList[i]) > 0) then
            begin
              busyflag := true;
              break;
            end;

            if not title_flag then
            begin
              RegExp.Pattern := GET_TITLE;
              try
                if RegExp.Test(Content) then
                begin
                  Matches := RegExp.Execute(Content) as MatchCollection;
                  VideoData.video_title := AnsiString(Match(Matches.Item[0]).Value);
                  if Length(VideoData.video_title) > 0 then
                  begin
                    VideoData.video_title := RegExp.Replace(VideoData.video_title, '$1');

                    RegExp.Pattern := GET_NICO_TITLE;
                    if RegExp.Test(VideoData.video_title) then
                    begin
                      Matches := RegExp.Execute(VideoData.video_title) as MatchCollection;
                      NicoTitle := AnsiString(Match(Matches.Item[0]).Value);
                      VideoData.video_title := CustomStringReplace(VideoData.video_title, NicoTitle, '', True);
                    end;

                    VideoData.video_title := CustomStringReplace(VideoData.video_title, '‐ニコニコ動画', '', True); //βが外れた時用

                    VideoData.video_title := CustomStringReplace(VideoData.video_title,  '&quot;', '"');
                    VideoData.video_title := CustomStringReplace(VideoData.video_title,  '&amp;', '&');
                    VideoData.video_title := CustomStringReplace(VideoData.video_title,  '&lt; ', '<');
                    VideoData.video_title := CustomStringReplace(VideoData.video_title,  '&gt;', '>');
                    Log('タイトル:' + VideoData.video_title);
                  end;
                end;
              except
                on E: Exception do
                begin
                  Log(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern);
                  Log('タイトルの分析に失敗しました。');
                end;
              end;
            end;

            if not videoid_flag then
            begin
              RegExp.Pattern := NICOVIDEO_GET_ID;
              try
                if RegExp.Test(Content) then
                begin
                  Matches := RegExp.Execute(Content) as MatchCollection;
                  VideoData.dl_video_id := AnsiString(Match(Matches.Item[0]).Value);
                  if Length(VideoData.dl_video_id) > 0 then
                  begin
                    VideoData.dl_video_id := RegExp.Replace(VideoData.dl_video_id, '$1');
                    Log('VideoID:' + VideoData.dl_video_id);
                    ActionSave.Enabled := True;
                  end;
                  videoid_flag := True;
                end;
              except
                on E: Exception do
                begin
                  MessageDlg(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern, mtError, [mbOK], -1);
                  Log(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern);
                  Log('VideoIDの分析に失敗しました。');
                  videoid_flag := True;
                end;
              end;
            end;

            if (Length(user_id) = 0) then
            begin
              RegExp.Pattern := GET_USER_ID;
              try
                if RegExp.Test(Content) then
                begin
                  Matches := RegExp.Execute(Content) as MatchCollection;
                  user_id := AnsiString(Match(Matches.Item[0]).Value);
                  if Length(user_id) > 0 then
                  begin
                    user_id := RegExp.Replace(user_id, '$1');
                    Log('user_id:' + user_id);
                  end;
                end;
              except
                on E: Exception do
                begin
                  //MessageDlg(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern, mtError, [mbOK], -1);
                  Log(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern);
                  Log('user_idの分析に失敗しました。');
                end;
              end;
            end;

            if (Length(video_id) = 0) then
            begin
              RegExp.Pattern := GET_VIDEO_ID;
              try
                if RegExp.Test(Content) then
                begin
                  Matches := RegExp.Execute(Content) as MatchCollection;
                  video_id := AnsiString(Match(Matches.Item[0]).Value);
                  if Length(video_id) > 0 then
                  begin
                    video_id := RegExp.Replace(video_id, '$1');
                    Log('video_id:' + video_id);
                  end;
                end;
              except
                on E: Exception do
                begin
                  //MessageDlg(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern, mtError, [mbOK], -1);
                  Log(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern);
                  Log('video_idの分析に失敗しました。');
                end;
              end;
            end;

            if Variable_flag then
            begin
              if (AnsiPos('</script>', Content) > 0) then
                Variable_flag := false
              else
              begin
                RegExp.Pattern := GET_VARIABLE;
                try
                  if RegExp.Test(Content) then
                  begin
                    Matches := RegExp.Execute(Content) as MatchCollection;
                    tmpVariable := AnsiString(Match(Matches.Item[0]).Value);
                    if Length(tmpVariable) > 0 then
                    begin
                      addVariable := addVariable + RegExp.Replace(tmpVariable, '$1') + '=' + RegExp.Replace(tmpVariable, '$2') + '&';
                      if (AnsiPos('movie_type', Content) > 0) then
                        VideoData.video_ext := '.' + RegExp.Replace(tmpVariable, '$2');
                    end;
                  end;
                except
                  on E: Exception do
                  begin
                    Log(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern);
                  end;
                end;
              end;
            end
            else if Length(addVariable) = 0 then
            begin
              if (AnsiPos('new SWFObject', Content) > 0) and
                 (AnsiPos('"flvplayer"', Content) > 0) then
                Variable_flag := true;
            end;

            //if title_flag and videoid_flag then
              //break;
          end; //for

          //ビデオ情報パネル用

          //どのサイトかを示すアイコン
          RegExp.Pattern := 'src="(http://res\.nicovideo\.jp/img/common/cms/[^"]+)"';
          try
            if RegExp.Test(ContentList.Text) then
            begin
              Matches := RegExp.Execute(ContentList.Text) as MatchCollection;
              tmpInfo := AnsiString(Match(Matches.Item[0]).Value);
              if Length(tmpInfo) > 0 then
              begin
                infoContents := '<img src="' + RegExp.Replace(tmpInfo, '$1') + '">' + #13#10;
              end;
            end;
          except
            on E: Exception do
            begin
              Log(e.Message  + #13#10 + RegExp.Pattern);
            end;
          end;

          //投稿日
          RegExp.Pattern := '(\d{2,4}年\d{2}月\d{2}日\s\d{2}:\d{2}:\d{2})';
          try
            if RegExp.Test(ContentList.Text) then
            begin
              Matches := RegExp.Execute(ContentList.Text) as MatchCollection;
              tmpInfo := AnsiString(Match(Matches.Item[0]).Value);
              if Length(tmpInfo) > 0 then
              begin
                infoContents := infoContents + '<p class="TXT12" style="margin-top:2px;"><strong>' + tmpInfo + '</strong> 投稿</p>' + #13#10;
              end;
            end;
          except
            on E: Exception do
            begin
              Log(e.Message  + #13#10 + RegExp.Pattern);
            end;
          end;

          //タイトル
          RegExp.Pattern := '(<h1(.|\n)+?</h1>)';
          try
            if RegExp.Test(ContentList.Text) then
            begin
              Matches := RegExp.Execute(ContentList.Text) as MatchCollection;
              tmpInfo := AnsiString(Match(Matches.Item[0]).Value);
              if Length(tmpInfo) > 0 then
              begin
                infoContents := infoContents + tmpInfo + #13#10;
              end;
            end;
          except
            on E: Exception do
            begin
              Log(e.Message  + #13#10 + RegExp.Pattern);
            end;
          end;

          //コメント
          RegExp.Pattern := 'class="video_des_tit">(?:.|\n)+?(<p class="font12">(?:.|\n)+?</p>)';
          try
            if RegExp.Test(ContentList.Text) then
            begin
              Matches := RegExp.Execute(ContentList.Text) as MatchCollection;
              tmpInfo := AnsiString(Match(Matches.Item[0]).Value);
              if Length(tmpInfo) > 0 then
              begin
                tmpInfo := RegExp.Replace(tmpInfo, '$1');
                tmpInfo := CustomStringReplace(tmpInfo, 'class="font12"', 'style="font-size:12px; line-height:1.5;  background:#F9F9F9; border:solid #999; border-width:2px; padding:6px;"');
                infoContents := infoContents +
                                tmpInfo +
                                #13#10;
              end;
            end;
          except
            on E: Exception do
            begin
              Log(e.Message  + #13#10 + RegExp.Pattern);
            end;
          end;

          //登録タグ
          RegExp.Pattern := '(<div id="video_tags">(.|\n)+?</div>)';
          try
            if RegExp.Test(ContentList.Text) then
            begin
              Matches := RegExp.Execute(ContentList.Text) as MatchCollection;
              tmpInfo := AnsiString(Match(Matches.Item[0]).Value);
              if Length(tmpInfo) > 0 then
              begin
                tmpInfo := CustomStringReplace(tmpInfo,  '<nobr>', '');
                tmpInfo := CustomStringReplace(tmpInfo,  '</nobr>', ''); 
                tmpInfo := CustomStringReplace(tmpInfo,  '【編集】', '');
                infoContents := infoContents + tmpInfo + #13#10;
              end;
            end;
          except
            on E: Exception do
            begin
              Log(e.Message  + #13#10 + RegExp.Pattern);
            end;
          end;

        finally
          ContentList.Free;
        end;

        if Length(addVariable) > 0 then
          addVariable := Copy(addVariable, 1, Length(addVariable) -1)
        else
          addVariable := 'v=' + VideoData.video_id + '&us=0&ad=web_pc_player_marquee';

        if Length(VideoData.video_title) > 0 then
        begin
          LabelURL.Caption := '【' + VideoData.video_title + '】';
          LabelURL.Hint := VideoData.video_title + #13#10 + tmpURI2Form;
          Self.Caption := APPLICATION_NAME + ' - [' +VideoData.video_title + ']';
          Application.Title := Self.Caption;
          if SpTBXTitleBar.Active then
            SpTBXTitleBar.Caption := Self.Caption;
          if VideoData.video_type <> 5 then
            AddRecentlyViewed(VideoData.video_title, VideoData.video_id ,'nicovideo')
          else
            AddRecentlyViewed(VideoData.video_title, VideoData.video_id ,'nicovideo2');

        end else
          LabelURL.Caption := tmpURI2Form;

        Log('データ分析完了');


        if busyflag then
        begin
          Log('アクセス規制で有効なデータを取得できませんでした。');
          LabelURL.Caption := '【アクセス規制中】' + tmpURI2Form;
        end
        else if Length(VideoData.dl_video_id) > 0 then
        begin
          NicoVideoRetryCount := 0;
          (*
          if VideoData.video_type = 1 then
          begin
            ActionAddTag.Enabled := True;
            ActionAddAuthor.Enabled := True;
          end;
          *)
          if VideoData.video_type in [1,2] then
            ActionOpenPrimarySite.Enabled := true;

          case Config.optFPQuality of
            0: quality := FLASH_QUALITY[0];
            1: quality := FLASH_QUALITY[1];
            2: quality := FLASH_QUALITY[2];
            3: quality := FLASH_QUALITY[3];
            4: quality := FLASH_QUALITY[4];
          end;

          if USELOCALPLAYER then
          begin
            innerHTML := '<html><head><title>TubePlayer</title>'#10 +
                         '<base href="' + NICOVIDEO_URI + '">'#10 +
                         '<style type="text/css">'#10 +
                         '<!-- body{color: #000000;background: #000000;margin: 0;padding: 0;border: 0;overflow: hidden} -->'#10 +
                         '<!-- div{position:absolute; left:' + IntToStr(-Config.optNicoVideoModLeft) + 'px; top:' + IntToStr(-Config.optNicoVideoModTop) + 'px;} -->'#10 +
                         '</style>'#10 +
                         '</head><body>'#10 +
                         '<div>' +
                         '<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" id="flvplayer" width="952" height="540"'#10 +
                         'codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0">'#10 +
                         '<param name="movie" value="' + Config.BasePath + 'bin\nicoplayer.swf?' + VideoData.dl_video_id + '">'#10 +
                         '<param name="FlashVars" value="' + addVariable + '">'#10 +
                         '<param name="quality" value="' + quality + '">'#10 +
                         '<param name="bgcolor" value="#ffffff">'#10 +
                         '<param name="allowScriptAccess" value="always">'#10 +
                         '</object>'#10 +
                         '</div>' +
                         '</body></html>';
          end else
          begin
            innerHTML := '<html><head><title>TubePlayer</title>'#10 +
                         '<base href="' + NICOVIDEO_URI + '">'#10 +
                         '<style type="text/css">'#10 +
                         '<!-- body{color: #000000;background: #000000;margin: 0;padding: 0;border: 0;overflow: hidden} -->'#10 +
                         '<!-- div{position:absolute; left:' + IntToStr(-Config.optNicoVideoModLeft) + 'px; top:' + IntToStr(-Config.optNicoVideoModTop) + 'px;} -->'#10 +
                         '</style>'#10 +
                         '</head><body>'#10 +
                         '<div>' +
                         '<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" id="flvplayer" width="952" height="540"'#10 +
                         'codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0">'#10 +
                         '<param name="movie" value="' + NICOVIDEO_PLAYER_URI + 'nicoplayer.swf?' + VideoData.dl_video_id + '">'#10 +
                         '<param name="FlashVars" value="' + addVariable + '">'#10 +
                         '<param name="quality" value="' + quality + '">'#10 +
                         '<param name="bgcolor" value="#ffffff">'#10 +
                         '<param name="allowScriptAccess" value="always">'#10 +
                         '</object>'#10 +
                         '</div>' +
                         '</body></html>';
          end;

          //WebBrowser.EnableMessageHandler;
          //WebBrowser.OnTranslateAccelerator := EmbeddedWBTranslateAccelerator;
          //log(innerHTML);
          WebBrowser.LoadFromString(innerHTML);

          Panel.Tag := 30;
          if (Self.WindowState = wsNormal) and
             (Config.optNicoVideoWidthDef > 0) and (Config.optNicoVideoHeightDef > 0) then
          begin
            Panel.Tag := 10;
            if SpTBXTitleBar.Active then
            begin
              Self.Width :=  Config.optNicoVideoWidthDef + GetSystemMetrics(SM_CXFRAME) * 2 + Self.BorderWidth * 2 + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width + SpTBXSplitterLeft.Width + SpTBXSplitterRight.Width;
              Self.Height := Config.optNicoVideoHeightDef + GetSystemMetrics(SM_CYFRAME) * 2 + DockTop.Height + DockBottom.Height + SpTBXTitleBar.FTitleBarHeight;
            end else
            begin
              Self.Width :=  Config.optNicoVideoWidthDef + GetSystemMetrics(SM_CXFRAME) * 2 + Self.BorderWidth * 2 + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width + SpTBXSplitterLeft.Width + SpTBXSplitterRight.Width;
              Self.Height := Config.optNicoVideoHeightDef + GetSystemMetrics(SM_CYCAPTION) + GetSystemMetrics(SM_CYSIZEFRAME) * 2 + DockTop.Height + DockBottom.Height;
            end;
          end;

          if Config.optChangeVideoScale then
          begin
            //SetBounds(Self.Left, Self.Top, Self.Width-1, Self.Height);
            PanelMain.BorderWidth := 1;
            TimerSetSetBounds.Enabled := True;
          end;

          //ビデオ情報パネル用
          if Length(infoContents) > 0 then
          begin
            infoContents := CustomStringReplace(infoContents,  'target="_blank"', '');
            innerHTML := NICO4_DEFAULT_HEADER + infoContents + NICO_DEFAULT_FOOTER;
            WebBrowser2.LoadFromString(innerHTML);
          end;
        end else
        begin
          Log('VideoIDを取得できませんでした。');
          Log('データ再取得開始');
          GetRetry;
        end;

      end;
    302:
      begin
        GetRetry;
      end;
    else
      begin
        Log('データの取得に失敗しました。');
        LabelURL.Caption := '【データ取得失敗】' + tmpURI2Form;
      end;
    end;

    procGet := nil;

    if Length(VideoData.dl_video_id) > 0 then
    begin
      if Length(video_id) = 0 then
        video_id := VideoData.video_id;

      (* ニコニコ市場取得処理を付けるまでコメントアウト
      Log('');
      SpTBXDockablePanelVideoRelated.Caption := '関連商品' + ' <取得中>';
      Log('ニコニコ市場取得開始 (' + VideoData.video_id + ')');

      randomize;
      case random(4) of
        0: ICHIBA_URI := NICOVIDEO_GET_ICHIBA1;
        1: ICHIBA_URI := NICOVIDEO_GET_ICHIBA2;
        2: ICHIBA_URI := NICOVIDEO_GET_ICHIBA3;
        3: ICHIBA_URI := NICOVIDEO_GET_ICHIBA4;
        else
          ICHIBA_URI := NICOVIDEO_GET_ICHIBA3;
      end;
      //Log(ICHIBA_URI + video_id + '&js_user_id=' + user_id);
      procGet := AsyncManager.Get(ICHIBA_URI + video_id + '&js_user_id=' + user_id, OnDoneNicoVideoIchiba, OnNicoVideoPreConnect);
      *)
    end;
  end;
end;

//ニコニコ市場から取得した情報を処理する
procedure TMainWnd.OnDoneNicoVideoIchiba(sender: TAsyncReq);
var
  i: integer;
  ContentList: TStringList;
  Content: String;
  Matches: MatchCollection;
  //innerHTML: String;
  asin: String;
  extract: String;
  j: integer;
  already: boolean;
  AsinData: TAsinData;
  AsinDatas: String;
const
  GET_ASIN   = '/item/az([^"]+)"';
  GET_ASIN2  = '/ASIN/([^%]+)%';
  GET_BUY    = '>([,\d]+人)</strong>が購入';
  GET_CLICK  = '(?:この動画で<strong>([,\d]+人)</strong>、)?全体で([,\d]+人)がクリック';
  //GET_BUY2   = '購入：<strong(?:[^>]+)?>([,\d]+人)<\/strong>';
  //GET_CLICK2 = 'クリック：<strong(?:[^>]+)?>([,\d]+)<\/strong>';
begin
  if procGet = sender then
  begin
    Log('【nicovideo(OnDoneNicoVideoIchiba)】' + sender.IdHTTP.ResponseText);
    case sender.IdHTTP.ResponseCode of
    200: (* OK *)
      begin
        Log('データ分析開始');
        ContentList := TStringList.Create;
        try
          ContentList.Text := procGet.Content;
          for i := 0 to ContentList.Count -1 do
          begin
            asin := '';
            Content := URLDecode(UTF8toAnsi(ContentList[i]));
            if Length(Content) > 0 then
            begin
              RegExp.Pattern := GET_ASIN;
              try
                if RegExp.Test(Content) then
                begin
                  Matches := RegExp.Execute(Content) as MatchCollection;
                  asin := AnsiString(Match(Matches.Item[0]).Value);
                  if Length(asin) > 0 then
                  begin
                    asin := RegExp.Replace(asin, '$1');
                  end;
                end;
              except
                on E: Exception do
                begin
                  //MessageDlg(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern, mtError, [mbOK], -1);
                  Log(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern);
                  Log('ASINの分析に失敗しました。');
                end;
              end;
              if Length(asin) = 0 then
              begin
                RegExp.Pattern := GET_ASIN2;
                try
                  if RegExp.Test(Content) then
                  begin
                    Matches := RegExp.Execute(Content) as MatchCollection;
                    asin := AnsiString(Match(Matches.Item[0]).Value);
                    if Length(asin) > 0 then
                    begin
                      asin := RegExp.Replace(asin, '$1');
                    end;
                  end;
                except
                  on E: Exception do
                  begin
                    //MessageDlg(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern, mtError, [mbOK], -1);
                    Log(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern);
                    Log('ASINの分析に失敗しました。');
                  end;
                end;
              end;
              if Length(asin) > 0 then
              begin
                already := false;
                for j := 0 to AsinList.Count -1 do
                begin
                  if SameText(asin, TAsinData(AsinList[j]).ASIN) then
                  begin
                    already := true;
                    break;
                  end;
                end;
                if not already then
                begin
                  AsinList.Add(TAsinData.Create);
                  TAsinData(AsinList.Last).ASIN := asin;
                end;
              end;

              if AsinList.Count > 0 then
              begin
                AsinData := AsinList.Last;
                if Length(AsinData.buy) = 0 then
                begin
                  RegExp.Pattern := GET_BUY;
                  extract := '';
                  try
                    if RegExp.Test(Content) then
                    begin
                      Matches := RegExp.Execute(Content) as MatchCollection;
                      extract := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(extract) > 0 then
                      begin
                        AsinData.buy := RegExp.Replace(extract, '$1');
                      end;
                    end;
                  except
                  end;
                end;

                if (Length(AsinData.click) = 0) and (Length(AsinData.total_click) = 0) then
                begin
                  RegExp.Pattern := GET_CLICK;
                  extract := '';
                  try
                    if RegExp.Test(Content) then
                    begin
                      Matches := RegExp.Execute(Content) as MatchCollection;
                      extract := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(extract) > 0 then
                      begin
                        AsinData.click := RegExp.Replace(extract, '$1');
                        AsinData.total_click := RegExp.Replace(extract, '$2');
                      end;
                    end;
                  except
                  end;
                end;
                (*
                if (Length(AsinData.buy) = 0) then
                begin
                  RegExp.Pattern := GET_BUY2;
                  extract := '';
                  try
                    if RegExp.Test(Content) then
                    begin
                      Matches := RegExp.Execute(Content) as MatchCollection;
                      extract := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(extract) > 0 then
                      begin
                        AsinData.buy := RegExp.Replace(extract, '$1');
                      end;
                    end;
                  except
                  end;
                end;

                if (Length(AsinData.click) = 0) then
                begin
                  RegExp.Pattern := GET_CLICK2;
                  extract := '';
                  try
                    if RegExp.Test(Content) then
                    begin
                      Matches := RegExp.Execute(Content) as MatchCollection;
                      extract := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(extract) > 0 then
                      begin
                        AsinData.click := RegExp.Replace(extract, '$1');
                        AsinData.total_click := '-'
                      end;
                    end;
                  except
                  end;
                end;
                *)
              end
            end;
          end;
        finally
          ContentList.Free;
        end;
        SpTBXDockablePanelVideoRelated.Caption := '関連商品';
        Log('データ分析完了');
      end;
    else
      begin
        SpTBXDockablePanelVideoRelated.Caption := '関連商品' + ' <取得失敗>';
        Log('データの取得に失敗しました。');
        //MessageDlg('データの取得に失敗しました。', mtError, [mbOK], -1);
      end;
    end;
    procGet:= nil;

    if AsinList.Count > 0 then
    begin
      for i := 0 to AsinList.Count -1 do
      begin
        AsinDatas := AsinDatas + TAsinData(AsinList[i]).ASIN + ','
      end;
      AsinDatas := LeftStr(AsinDatas, Length(AsinDatas)-1);
      Log('');
      SpTBXDockablePanelVideoRelated.Caption := '関連商品' + ' <取得中>';
      Log('Amazon商品データ取得開始 (' + VideoData.video_id + ')');
      procGet := AsyncManager.Get(AMAZON_AWS_URI_FRONT + AMAZON_AWS_TAG_NICO + AMAZON_AWS_URI_BACK + AsinDatas, OnDoneAmazon);
    end else
    begin
      if AsinRankList.Count > 0 then
      begin
        if ((Trunc(Now) - Trunc(LastIchibaCheckTime)) = 0) then
        begin
          randomize;
          for i := 0 to AsinRankList.Count -1 do
          begin
            j := random(AsinRankList.Count);
            if j > 0 then
              AsinRankList.Move(j, 0);
          end;
          for i := 0 to AsinRankList.Count -1 do
          begin
            if i > 9 then
              break;
            AsinDatas := AsinDatas + TAsinData(AsinRankList[i]).ASIN + ',';
          end;
          AsinDatas := LeftStr(AsinDatas, Length(AsinDatas)-1);
          Log('');
          SpTBXDockablePanelVideoRelated.Caption := 'おすすめ商品' + ' <取得中>';
          Log('Amazon商品データ取得開始 (' + VideoData.video_id + ')');
          procGet := AsyncManager.Get(AMAZON_AWS_URI_FRONT + AMAZON_AWS_TAG_TUBE + AMAZON_AWS_URI_BACK + AsinDatas, OnDoneAmazon2);
          exit;
        end;
      end;
      LastIchibaCheckTime := Now;
      ClearAsinRankList;
      Log('');
      SpTBXDockablePanelVideoRelated.Caption := 'おすすめ商品' + ' <取得中>';
      Log('ニコニコ市場ランキング取得開始 (' + VideoData.video_id + ')');
      procGet := AsyncManager.Get(NICOVIDEO_ICHIBA_RANK_URI, OnDoneNicoIchibaRanking, OnNicoVideoPreConnect);
    end;

  end;
end;

//ニコニコ市場ランキングから取得した情報を処理する
procedure TMainWnd.OnDoneNicoIchibaRanking(sender: TAsyncReq);
var
  i: integer;
  ContentList: TStringList;
  Content: String;
  Matches: MatchCollection;
  innerHTML: String;
  asin: String;
  extract: String;
  j: integer;
  already: boolean;
  AsinData: TAsinData;
  AsinDatas: String;
  mainStart: boolean;
const
  GET_START = ' ランキング　開始 ';
  GET_ASIN  = 'http://ichiba.nicovideo.jp/item/([^"]+)"';
  GET_BUY   = '<span class="noticeTextB">([,\d]+)</span>';
begin
  if procGet = sender then
  begin
    Log('【nicovideo(OnDoneNicoIchibaRanking)】' + sender.IdHTTP.ResponseText);
    case sender.IdHTTP.ResponseCode of
    200: (* OK *)
      begin
        Log('データ分析開始');
        ContentList := TStringList.Create;
        try
          ContentList.Text := procGet.Content;
          mainStart := false;
          for i := 0 to ContentList.Count -1 do
          begin
            Content := URLDecode(UTF8toAnsi(ContentList[i]));
            if not mainStart then
            begin
              if (AnsiPos(GET_START, Content) > 0) then
                mainStart := true;
              continue;  
            end;
            asin := '';
            if Length(Content) > 0 then
            begin
              RegExp.Pattern := GET_ASIN;
              try
                if RegExp.Test(Content) then
                begin
                  Matches := RegExp.Execute(Content) as MatchCollection;
                  asin := AnsiString(Match(Matches.Item[0]).Value);
                  if Length(asin) > 0 then
                  begin
                    asin := RegExp.Replace(asin, '$1');
                    if AnsiStartsStr('az', asin) then //将来の市場拡大のため？
                    begin
                      asin := Copy(asin, 3, Length(asin));
                    end;
                  end;
                end;
              except
                on E: Exception do
                begin
                  //MessageDlg(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern, mtError, [mbOK], -1);
                  Log(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern);
                  Log('ASINの分析に失敗しました。');
                end;
              end;
              if Length(asin) > 0 then
              begin
                already := false;
                for j := 0 to AsinRankList.Count -1 do
                begin
                  if SameText(asin, TAsinData(AsinRankList[j]).ASIN) then
                  begin
                    already := true;
                    break;
                  end;
                end;
                if not already then
                begin
                  AsinRankList.Add(TAsinData.Create);
                  TAsinData(AsinRankList.Last).ASIN := asin;
                  TAsinData(AsinRankList.Last).rank := IntToStr(AsinRankList.Count) + '位';
                end;
              end;

              if AsinRankList.Count > 0 then
              begin
                AsinData := AsinRankList.Last;
                if Length(AsinData.buy) = 0 then
                begin
                  RegExp.Pattern := GET_BUY;
                  extract := '';
                  try
                    if RegExp.Test(Content) then
                    begin
                      Matches := RegExp.Execute(Content) as MatchCollection;
                      extract := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(extract) > 0 then
                      begin
                        AsinData.buy := RegExp.Replace(extract, '$1') + '人';
                      end;
                      //if AsinRankList.Count > 49 then //取得は50位まで
                        //break;
                    end;
                  except
                  end;
                end;
              end

            end;
          end;
        finally
          ContentList.Free;
        end;
        SpTBXDockablePanelVideoRelated.Caption := 'おすすめ商品';
        Log('データ分析完了');
      end;
    else
      begin
        SpTBXDockablePanelVideoRelated.Caption := 'おすすめ商品' + ' <取得失敗>';
        Log('データの取得に失敗しました。');
        //MessageDlg('データの取得に失敗しました。', mtError, [mbOK], -1);
      end;
    end;
    procGet:= nil;

    if AsinRankList.Count > 0 then
    begin
      randomize;
      for i := 0 to AsinRankList.Count -1 do
      begin
        j := random(AsinRankList.Count);
        if j > 0 then
          AsinRankList.Move(j, 0);
      end;
      for i := 0 to AsinRankList.Count -1 do
      begin
        if i > 9 then
          break;
        AsinDatas := AsinDatas + TAsinData(AsinRankList[i]).ASIN + ',';
      end;
      AsinDatas := LeftStr(AsinDatas, Length(AsinDatas)-1);
      Log('');
      SpTBXDockablePanelVideoRelated.Caption := 'おすすめ商品' + ' <取得中>';
      Log('Amazon商品データ取得開始 (' + VideoData.video_id + ')');
      procGet := AsyncManager.Get(AMAZON_AWS_URI_FRONT + AMAZON_AWS_TAG_TUBE + AMAZON_AWS_URI_BACK + AsinDatas, OnDoneAmazon2);
      //log(AMAZON_AWS_URI + AsinDatas);
    end else
    begin
      innerHTML := NICO_ICHIBA_HEADER +
                   'まだ登録がありません。' +
                   NICO_ICHIBA_FOOTER;
      WebBrowser3.LoadFromString(innerHTML);
    end;

  end;
end;

//Amazonから取得した情報を処理する
procedure TMainWnd.OnDoneAmazon(sender: TAsyncReq);

  procedure Build(XMLNode: IXMLNode);
  var
    i: integer;
    NewXMLNode2: IXMLNode;
    NewXMLNode3: IXMLNode;
    AsinData: TAsinData;
    asin: string;
  begin
    if (XMLNode.NodeType = ntElement) then
    begin
      if (XMLNode.NodeName = 'Item') then
      begin
        try
          asin := XMLNode.ChildValues['ASIN'];
        except
        end;
        if Length(asin) > 0 then
        begin
          AsinData := nil;
          for i := 0 to AsinList.Count -1 do
          begin
            if SameText(asin, TAsinData(AsinList[i]).ASIN) then
            begin
              AsinData := TAsinData(AsinList[i]);
              break;
            end;
          end;
          if Assigned(AsinData) then
          begin
            try
              AsinData.URL := XMLNode.ChildValues['DetailPageURL'];
            except
            end;

            NewXMLNode2 := XMLNode.ChildNodes.FindNode('SmallImage');
            if Assigned(NewXMLNode2) then
            begin
              try
                AsinData.Image_URL := NewXMLNode2.ChildValues['URL'];
              except
              end;
            end;

            NewXMLNode2 := XMLNode.ChildNodes.FindNode('ItemAttributes');
            if Assigned(NewXMLNode2) then
            begin
              try
                AsinData.Artist := NewXMLNode2.ChildValues['Artist'];
              except
              end;

              if Length(AsinData.Artist) = 0 then
              try
                AsinData.Artist := NewXMLNode2.ChildValues['Actor'];
              except
              end;

              if Length(AsinData.Artist) = 0 then
              try
                AsinData.Artist := NewXMLNode2.ChildValues['Creator'];
              except
              end;

              if Length(AsinData.Artist) = 0 then
              try
                AsinData.Artist := NewXMLNode2.ChildValues['Brand'];
              except
              end;

              try
                AsinData.Binding := NewXMLNode2.ChildValues['Binding'];
              except
              end;

              try
                AsinData.Publisher := NewXMLNode2.ChildValues['Publisher'];
              except
              end;

              try
                AsinData.ReleaseDate := NewXMLNode2.ChildValues['ReleaseDate'];
              except
              end;

              try
                AsinData.Title := NewXMLNode2.ChildValues['Title'];
              except
              end;

              NewXMLNode3 := NewXMLNode2.ChildNodes.FindNode('ListPrice');
              if Assigned(NewXMLNode3) then
              begin
                try
                  AsinData.ListPrice := NewXMLNode3.ChildValues['FormattedPrice'];
                except
                end;
              end;
            end;

            NewXMLNode2 := XMLNode.ChildNodes.FindNode('OfferSummary');
            if Assigned(NewXMLNode2) then
            begin
              NewXMLNode3 := NewXMLNode2.ChildNodes.FindNode('LowestNewPrice');
              if Assigned(NewXMLNode3) then
              begin
                try
                  AsinData.Price := NewXMLNode3.ChildValues['FormattedPrice'];
                except
                end;
              end;
            end;

            NewXMLNode2 := XMLNode.ChildNodes.FindNode('CustomerReviews');
            if Assigned(NewXMLNode2) then
            begin
              try
                AsinData.AverageRating := NewXMLNode2.ChildValues['AverageRating'];
              except
              end;
              try
                AsinData.TotalReviews := NewXMLNode2.ChildValues['TotalReviews'];
              except
              end;
            end;
          end;
        end;
      end else
      begin
        for i :=  0 to XMLNode.ChildNodes.Count - 1 do
        begin
          Build(XMLNode.ChildNodes.Nodes[i]);
        end;
      end;
    end;
  end;

var
  i: integer;
  ContentList: TStringList;
  Content: String;
  innerHTML: String;
  AsinData: TAsinData;
  star_url: String;
begin
  if procGet = sender then
  begin
    Log('【Amazon(OnDoneAmazon)】' + sender.IdHTTP.ResponseText);
    case sender.IdHTTP.ResponseCode of
    200: (* OK *)
      begin
        Log('データ分析開始');
        ContentList := TStringList.Create;
        try
          ContentList.Text := procGet.Content;
          for i := 0 to ContentList.Count -1 do
          begin
            Content := ContentList[i]; //URLDecode(UTF8toAnsi(ContentList[i]));
            if Length(Content) > 0 then
              XMLDocument.XML.Add(Content);
          end;
        finally
          ContentList.Free;
        end;

        if XMLDocument.XML.Count <= 0 then
        begin
          Log('有効なデータを取得できませんでした。');
          Log('データ分析完了');
          procGet:= nil;
          exit;
        end;


        try
          XMLDocument.Active := True;
        except
          on E: Exception do
          begin
            //MessageDlg(e.Message  + #13#10 + 'XMLの解析に失敗しました。', mtError, [mbOK], -1);
            Log(e.Message);
            Log('XMLの解析に失敗しました。');
            SpTBXDockablePanelVideoRelated.Caption := '関連商品' + ' <解析失敗>';
            XMLDocument.Active := false;
            XMLDocument.XML.Clear;
            procGet:= nil;
            exit;
          end;
        end;
        Build(XMLDocument.DocumentElement);
        XMLDocument.Active := false;
        XMLDocument.XML.Clear;

        innerHTML := NICO_ICHIBA_HEADER +
                     '<table>'+ #13#10;

        for i := 0 to AsinList.Count -1 do
        begin
          AsinData := TAsinData(AsinList[i]);
          Content := NICO_ICHIBA_CONTENT;

          if SameText('5.0', AsinData.AverageRating) then
            star_url := 'http://images-jp.amazon.com/images/G/01/detail/stars-5-0.gif'
          else if SameText('4.5', AsinData.AverageRating) then
            star_url := 'http://images-jp.amazon.com/images/G/01/detail/stars-4-5.gif'
          else if SameText('4.0', AsinData.AverageRating) then
            star_url := 'http://images-jp.amazon.com/images/G/01/detail/stars-4-0.gif'
          else if SameText('3.5', AsinData.AverageRating) then
            star_url := 'http://images-jp.amazon.com/images/G/01/detail/stars-3-5.gif'
          else if SameText('3.0', AsinData.AverageRating) then
            star_url := 'http://images-jp.amazon.com/images/G/01/detail/stars-3-0.gif'
          else if SameText('2.5', AsinData.AverageRating) then
            star_url := 'http://images-jp.amazon.com/images/G/01/detail/stars-2-5.gif'
          else if SameText('2.0', AsinData.AverageRating) then
            star_url := 'http://images-jp.amazon.com/images/G/01/detail/stars-2-0.gif'
          else if SameText('1.5', AsinData.AverageRating) then
            star_url := 'http://images-jp.amazon.com/images/G/01/detail/stars-1-5.gif'
          else if SameText('1.0', AsinData.AverageRating) then
            star_url := 'http://images-jp.amazon.com/images/G/01/detail/stars-1-0.gif'
          else if SameText('0.5', AsinData.AverageRating) then
            star_url := 'http://images-jp.amazon.com/images/G/01/detail/stars-0-5.gif'
          else
            star_url := 'http://images-jp.amazon.com/images/G/01/detail/stars-0-0.gif';

          if Length(AsinData.Image_URL) = 0 then
            AsinData.Image_URL := 'http://images-jp.amazon.com/images/G/09/icons/books/comingsoon_books.gif';

          if Length(AsinData.Binding) = 0 then
            AsinData.Binding := 'その他';

          if Length(AsinData.Publisher) = 0 then
            AsinData.Publisher := '-';

          if Length(AsinData.ReleaseDate) = 0 then
            AsinData.ReleaseDate := '-';

          if Length(AsinData.ListPrice) = 0 then
            AsinData.ListPrice := '-';

          if Length(AsinData.Price) = 0 then
            AsinData.Price := '-'; 

          if Length(AsinData.AverageRating) = 0 then
            AsinData.AverageRating := '0.0';

          if Length(AsinData.TotalReviews) = 0 then
            AsinData.TotalReviews := '0';

          if Length(AsinData.buy) = 0 then
            AsinData.buy := '0人'
          else
            AsinData.buy := '<span class="red">' + AsinData.buy + '</span>';

          if Length(AsinData.click) = 0 then
            AsinData.click := '0';

          if Length(AsinData.total_click) = 0 then
            AsinData.total_click := '0';

          Content := CustomStringReplace(Content, '$ASIN', AsinData.ASIN, True);
          Content := CustomStringReplace(Content, '$URL', AsinData.URL, True);
          Content := CustomStringReplace(Content, '$IMAGE_URL', AsinData.Image_URL, True);
          Content := CustomStringReplace(Content, '$ARTIST', AsinData.Artist, True);
          Content := CustomStringReplace(Content, '$BINDING', AsinData.Binding, True);
          Content := CustomStringReplace(Content, '$PUBLISHER', AsinData.Publisher, True);
          Content := CustomStringReplace(Content, '$RELEASEDATE', AsinData.ReleaseDate, True);
          Content := CustomStringReplace(Content, '$TITLE', AsinData.Title, True);
          Content := CustomStringReplace(Content, '$LISTPRICE', AsinData.ListPrice, True);
          Content := CustomStringReplace(Content, '$PRICE', AsinData.Price, True);
          Content := CustomStringReplace(Content, '$AVERAGERATING', AsinData.AverageRating, True);
          Content := CustomStringReplace(Content, '$TOTALREVIEWS', AsinData.TotalReviews, True);
          Content := CustomStringReplace(Content, '$BUY', AsinData.buy, True);
          Content := CustomStringReplace(Content, '$CLICK', AsinData.click, True);
          Content := CustomStringReplace(Content, '$TOTAL_CLICK', AsinData.total_click, True);
          Content := CustomStringReplace(Content, '$STAR', star_url, True);

          innerHTML := innerHTML + Content;

          (*
          Log('*****');
          Log('ASIN:' + AsinData.ASIN);
          Log('URL:' + AsinData.URL);
          Log('Image_URL:' + AsinData.Image_URL);
          Log('Artist:' + AsinData.Artist);
          Log('Binding:' + AsinData.Binding);
          Log('Publisher:' + AsinData.Publisher);
          Log('ReleaseDate:' + AsinData.ReleaseDate);
          Log('Title:' + AsinData.Title);
          Log('ListPrice:' + AsinData.ListPrice);
          Log('Price:' + AsinData.Price);
          Log('AverageRating:' + AsinData.AverageRating);
          Log('TotalReviews:' + AsinData.TotalReviews);
          Log('buy:' + AsinData.buy);
          Log('click:' + AsinData.click);
          Log('total_click:' + AsinData.total_click);
          *)
        end;
        innerHTML := innerHTML + '</table>'+ #13#10 + NICO_ICHIBA_FOOTER;
        WebBrowser3.LoadFromString(innerHTML);

        SpTBXDockablePanelVideoRelated.Caption := '関連商品';
        Log('データ分析完了');
      end;
    else
      begin
        SpTBXDockablePanelVideoRelated.Caption := '関連商品' + ' <取得失敗>';
        Log('データの取得に失敗しました。');
        //MessageDlg('データの取得に失敗しました。', mtError, [mbOK], -1);
      end;
    end;
    procGet:= nil;
  end;
end;

//Amazonから取得した情報を処理する(ニコニコ市場ランキングから)
procedure TMainWnd.OnDoneAmazon2(sender: TAsyncReq);

  procedure Build(XMLNode: IXMLNode);
  var
    i: integer;
    NewXMLNode2: IXMLNode;
    NewXMLNode3: IXMLNode;
    AsinData: TAsinData;
    asin: string;
  begin
    if (XMLNode.NodeType = ntElement) then
    begin
      if (XMLNode.NodeName = 'Item') then
      begin
        try
          asin := XMLNode.ChildValues['ASIN'];
        except
        end;
        if Length(asin) > 0 then
        begin
          AsinData := nil;
          for i := 0 to AsinRankList.Count -1 do
          begin
            if SameText(asin, TAsinData(AsinRankList[i]).ASIN) then
            begin
              AsinData := TAsinData(AsinRankList[i]);
              break;
            end;
          end;
          if Assigned(AsinData) then
          begin
            try
              AsinData.URL := XMLNode.ChildValues['DetailPageURL'];
            except
            end;

            NewXMLNode2 := XMLNode.ChildNodes.FindNode('SmallImage');
            if Assigned(NewXMLNode2) then
            begin
              try
                AsinData.Image_URL := NewXMLNode2.ChildValues['URL'];
              except
              end;
            end;

            NewXMLNode2 := XMLNode.ChildNodes.FindNode('ItemAttributes');
            if Assigned(NewXMLNode2) then
            begin
              try
                AsinData.Artist := NewXMLNode2.ChildValues['Artist'];
              except
              end;

              if Length(AsinData.Artist) = 0 then
              try
                AsinData.Artist := NewXMLNode2.ChildValues['Actor'];
              except
              end;

              if Length(AsinData.Artist) = 0 then
              try
                AsinData.Artist := NewXMLNode2.ChildValues['Creator'];
              except
              end;

              if Length(AsinData.Artist) = 0 then
              try
                AsinData.Artist := NewXMLNode2.ChildValues['Brand'];
              except
              end;

              try
                AsinData.Binding := NewXMLNode2.ChildValues['Binding'];
              except
              end;

              try
                AsinData.Publisher := NewXMLNode2.ChildValues['Publisher'];
              except
              end;

              try
                AsinData.ReleaseDate := NewXMLNode2.ChildValues['ReleaseDate'];
              except
              end;

              try
                AsinData.Title := NewXMLNode2.ChildValues['Title'];
              except
              end;

              NewXMLNode3 := NewXMLNode2.ChildNodes.FindNode('ListPrice');
              if Assigned(NewXMLNode3) then
              begin
                try
                  AsinData.ListPrice := NewXMLNode3.ChildValues['FormattedPrice'];
                except
                end;
              end;
            end;

            NewXMLNode2 := XMLNode.ChildNodes.FindNode('OfferSummary');
            if Assigned(NewXMLNode2) then
            begin
              NewXMLNode3 := NewXMLNode2.ChildNodes.FindNode('LowestNewPrice');
              if Assigned(NewXMLNode3) then
              begin
                try
                  AsinData.Price := NewXMLNode3.ChildValues['FormattedPrice'];
                except
                end;
              end;
            end;

            NewXMLNode2 := XMLNode.ChildNodes.FindNode('CustomerReviews');
            if Assigned(NewXMLNode2) then
            begin
              try
                AsinData.AverageRating := NewXMLNode2.ChildValues['AverageRating'];
              except
              end;
              try
                AsinData.TotalReviews := NewXMLNode2.ChildValues['TotalReviews'];
              except
              end;
            end;
          end;
        end;
      end else
      begin
        for i :=  0 to XMLNode.ChildNodes.Count - 1 do
        begin
          Build(XMLNode.ChildNodes.Nodes[i]);
        end;
      end;
    end;
  end;

var
  i: integer;
  ContentList: TStringList;
  Content: String;
  innerHTML: String;
  AsinData: TAsinData;
  star_url: String;
begin
  if procGet = sender then
  begin
    Log('【Amazon(OnDoneAmazon2)】' + sender.IdHTTP.ResponseText);
    case sender.IdHTTP.ResponseCode of
    200: (* OK *)
      begin
        Log('データ分析開始');
        ContentList := TStringList.Create;
        try
          ContentList.Text := procGet.Content;
          for i := 0 to ContentList.Count -1 do
          begin
            Content := ContentList[i]; //URLDecode(UTF8toAnsi(ContentList[i]));
            if Length(Content) > 0 then
              XMLDocument.XML.Add(Content);
          end;
        finally
          ContentList.Free;
        end;

        if XMLDocument.XML.Count <= 0 then
        begin
          Log('有効なデータを取得できませんでした。');
          Log('データ分析完了');
          procGet:= nil;
          exit;
        end;


        try
          XMLDocument.Active := True;
        except
          on E: Exception do
          begin
            //MessageDlg(e.Message  + #13#10 + 'XMLの解析に失敗しました。', mtError, [mbOK], -1);
            Log(e.Message);
            Log('XMLの解析に失敗しました。');
            SpTBXDockablePanelVideoRelated.Caption := 'おすすめ商品' + ' <解析失敗>';
            XMLDocument.Active := false;
            XMLDocument.XML.Clear;
            procGet:= nil;
            exit;
          end;
        end;
        Build(XMLDocument.DocumentElement);
        XMLDocument.Active := false;
        XMLDocument.XML.Clear;


        innerHTML := NICO_ICHIBA_HEADER +
                     'まだ登録がありません。おすすめ商品を表示します。<br>'+ #13#10 +
                     '<table>'+ #13#10;


        for i := 0 to AsinRankList.Count -1 do
        begin
          if i > 9 then
            break;
          AsinData := TAsinData(AsinRankList[i]);
          Content := NICO_ICHIBA_CONTENT2;

          if SameText('5.0', AsinData.AverageRating) then
            star_url := 'http://images-jp.amazon.com/images/G/01/detail/stars-5-0.gif'
          else if SameText('4.5', AsinData.AverageRating) then
            star_url := 'http://images-jp.amazon.com/images/G/01/detail/stars-4-5.gif'
          else if SameText('4.0', AsinData.AverageRating) then
            star_url := 'http://images-jp.amazon.com/images/G/01/detail/stars-4-0.gif'
          else if SameText('3.5', AsinData.AverageRating) then
            star_url := 'http://images-jp.amazon.com/images/G/01/detail/stars-3-5.gif'
          else if SameText('3.0', AsinData.AverageRating) then
            star_url := 'http://images-jp.amazon.com/images/G/01/detail/stars-3-0.gif'
          else if SameText('2.5', AsinData.AverageRating) then
            star_url := 'http://images-jp.amazon.com/images/G/01/detail/stars-2-5.gif'
          else if SameText('2.0', AsinData.AverageRating) then
            star_url := 'http://images-jp.amazon.com/images/G/01/detail/stars-2-0.gif'
          else if SameText('1.5', AsinData.AverageRating) then
            star_url := 'http://images-jp.amazon.com/images/G/01/detail/stars-1-5.gif'
          else if SameText('1.0', AsinData.AverageRating) then
            star_url := 'http://images-jp.amazon.com/images/G/01/detail/stars-1-0.gif'
          else if SameText('0.5', AsinData.AverageRating) then
            star_url := 'http://images-jp.amazon.com/images/G/01/detail/stars-0-5.gif'
          else
            star_url := 'http://images-jp.amazon.com/images/G/01/detail/stars-0-0.gif';

          if Length(AsinData.Image_URL) = 0 then
            AsinData.Image_URL := 'http://images-jp.amazon.com/images/G/09/icons/books/comingsoon_books.gif';

          if Length(AsinData.Binding) = 0 then
            AsinData.Binding := 'その他';

          if Length(AsinData.Publisher) = 0 then
            AsinData.Publisher := '-';

          if Length(AsinData.ReleaseDate) = 0 then
            AsinData.ReleaseDate := '-';

          if Length(AsinData.ListPrice) = 0 then
            AsinData.ListPrice := '-';

          if Length(AsinData.Price) = 0 then
            AsinData.Price := '-'; 

          if Length(AsinData.AverageRating) = 0 then
            AsinData.AverageRating := '0.0';

          if Length(AsinData.TotalReviews) = 0 then
            AsinData.TotalReviews := '0';

          if Length(AsinData.buy) = 0 then
            AsinData.buy := '-人'
          else
            AsinData.buy := '<span class="red">' + AsinData.buy + '</span>';


          Content := CustomStringReplace(Content, '$ASIN', AsinData.ASIN, True);
          Content := CustomStringReplace(Content, '$URL', AsinData.URL, True);
          Content := CustomStringReplace(Content, '$IMAGE_URL', AsinData.Image_URL, True);
          Content := CustomStringReplace(Content, '$ARTIST', AsinData.Artist, True);
          Content := CustomStringReplace(Content, '$BINDING', AsinData.Binding, True);
          Content := CustomStringReplace(Content, '$PUBLISHER', AsinData.Publisher, True);
          Content := CustomStringReplace(Content, '$RELEASEDATE', AsinData.ReleaseDate, True);
          Content := CustomStringReplace(Content, '$TITLE', AsinData.Title, True);
          Content := CustomStringReplace(Content, '$LISTPRICE', AsinData.ListPrice, True);
          Content := CustomStringReplace(Content, '$PRICE', AsinData.Price, True);
          Content := CustomStringReplace(Content, '$AVERAGERATING', AsinData.AverageRating, True);
          Content := CustomStringReplace(Content, '$TOTALREVIEWS', AsinData.TotalReviews, True);
          Content := CustomStringReplace(Content, '$BUY', AsinData.buy, True);
          Content := CustomStringReplace(Content, '$RANK', AsinData.rank, True);
          Content := CustomStringReplace(Content, '$STAR', star_url, True);

          innerHTML := innerHTML + Content;

          (*
          Log('*****');
          Log('ASIN:' + AsinData.ASIN);
          Log('URL:' + AsinData.URL);
          Log('Image_URL:' + AsinData.Image_URL);
          Log('Artist:' + AsinData.Artist);
          Log('Binding:' + AsinData.Binding);
          Log('Publisher:' + AsinData.Publisher);
          Log('ReleaseDate:' + AsinData.ReleaseDate);
          Log('Title:' + AsinData.Title);
          Log('ListPrice:' + AsinData.ListPrice);
          Log('Price:' + AsinData.Price);
          Log('AverageRating:' + AsinData.AverageRating);
          Log('TotalReviews:' + AsinData.TotalReviews);
          Log('buy:' + AsinData.buy);
          Log('click:' + AsinData.click);
          Log('total_click:' + AsinData.total_click);
          *)
        end;
        innerHTML := innerHTML + '</table>'+ #13#10 + NICO_ICHIBA_FOOTER;
        WebBrowser3.LoadFromString(innerHTML);

        SpTBXDockablePanelVideoRelated.Caption := 'おすすめ商品';
        Log('データ分析完了');
      end;
    else
      begin
        SpTBXDockablePanelVideoRelated.Caption := 'おすすめ商品' + ' <取得失敗>';
        Log('データの取得に失敗しました。');
        //MessageDlg('データの取得に失敗しました。', mtError, [mbOK], -1);
      end;
    end;
    procGet:= nil;
  end;
end;

//YouTubeから取得した情報を処理する(watch?v=からの取得完了時)
procedure TMainWnd.OnDoneYouTube(sender: TAsyncReq);

  procedure GetRetry;
  var
    URL: OleVariant;
  begin
    if (YouTubeRetryCount = 0) and
       (Length(Config.optYouTubeAccount) > 0) and (Length(Config.optYouTubePassword) > 0) then
    begin
      Inc(YouTubeRetryCount);
      Log('');
      Log('Cookie取得開始');
      Config.optYouTubeSession := '';
      URL := YOUTUBE_GET_WATCH_URI + VideoData.video_id + Config.optMP4Format;
      WebBrowser.Navigate2(URL);
    end
    else if (YouTubeRetryCount < 100) and (Length(Config.optYouTubeSession) > 0) then
    begin
      YouTubeRetryCount := 100;
      Log('');
      Log('Cookie再取得開始');
      Config.optYouTubeSession := '';
      URL := YOUTUBE_GET_WATCH_URI + VideoData.video_id + Config.optMP4Format;
      WebBrowser.Navigate2(URL);
    end else
    begin
      Log('データの取得に失敗しました。');
      LabelURL.Caption := '【データ取得失敗】' + tmpURI2Form;
    end;
  end;

var
  i: integer;
  ContentList: TStringList;
  Content: String;
  Matches: MatchCollection;
  innerHTML: String;
  quality: String;
  title_flag: boolean;
  videoid_flag: boolean;
  video_player_flag: boolean;
  flashvars_flag: boolean;
  dl_video_id : string;
  //URL: OleVariant; 
  video_player: string;
  flashvars: string;
begin
  if procGet = sender then
  begin
    Log('【YouTube(OnDoneYouTube)】' + sender.IdHTTP.ResponseText);
    case sender.IdHTTP.ResponseCode of
    200: (* OK *)
      begin
        Log('データ分析開始');
        LabelURL.Caption := '【データ分析中】' + tmpURI2Form;

        title_flag := false;
        videoid_flag := false;
        video_player_flag := false;
        flashvars_flag := false;

        ContentList := TStringList.Create;
        try
          ContentList.Text := procGet.Content;
          //Content := UTF8toAnsi(procGet.Content); では文字変換に失敗
          for i := 0 to ContentList.Count -1 do
          begin
            ContentList[i] := UTF8toAnsi(ContentList[i]);
            Content := ContentList[i];
            if Length(Content) <= 0 then
              Continue;
            if not title_flag then
            begin
              RegExp.Pattern := GET_YOUTUBE_TITLE;
              begin
                try
                  if RegExp.Test(Content) then
                  begin
                    Matches := RegExp.Execute(Content) as MatchCollection;
                    VideoData.video_title := AnsiString(Match(Matches.Item[0]).Value);
                    if Length(VideoData.video_title) > 0 then
                    begin
                      VideoData.video_title := RegExp.Replace(VideoData.video_title, '$1');
                      VideoData.video_title := CustomStringReplace(VideoData.video_title, 'YouTube - ', '', True);
                      VideoData.video_title := CustomStringReplace(VideoData.video_title,  '&quot;', '"');
                      VideoData.video_title := CustomStringReplace(VideoData.video_title,  '&amp;', '&');
                      VideoData.video_title := CustomStringReplace(VideoData.video_title,  '&lt; ', '<');
                      VideoData.video_title := CustomStringReplace(VideoData.video_title,  '&gt;', '>');
                      Log('タイトル:' + VideoData.video_title);
                    end;
                    title_flag := True;
                  end;
                except
                  on E: Exception do
                  begin
                    Log(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern);
                    Log('タイトルの分析に失敗しました。');
                    title_flag := True;
                  end;
                end;
              end;
            end;

            if not videoid_flag then
            begin
              RegExp.Pattern := YOUTUBE_GET_VIDEOID;
              try
                if RegExp.Test(Content) then
                begin
                  Matches := RegExp.Execute(Content) as MatchCollection;
                  VideoData.dl_video_id := AnsiString(Match(Matches.Item[0]).Value);
                  if Length(VideoData.dl_video_id) > 0 then
                  begin
                    VideoData.dl_video_id := RegExp.Replace(VideoData.dl_video_id, '$1');
                    Log('VideoID:' + VideoData.dl_video_id);
                  end;
                  videoid_flag := True;
                end;
              except
                on E: Exception do
                begin
                  MessageDlg(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern, mtError, [mbOK], -1);
                  Log(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern);
                  Log('VideoIDの分析に失敗しました。');
                  videoid_flag := True;
                end;
              end;
            end;

            if not video_player_flag then
            begin
              RegExp.Pattern := YOUTUBE_GET_PLAYER;
              try
                if RegExp.Test(Content) then
                begin
                  Matches := RegExp.Execute(Content) as MatchCollection;
                  video_player := AnsiString(Match(Matches.Item[0]).Value);
                  if Length(video_player) > 0 then
                  begin
                    video_player := RegExp.Replace(video_player, '$1');
                    video_player := CustomStringReplace(video_player, '\', '');
                    //Log('player:' + video_player);
                  end;
                  video_player_flag := True;
                end;
              except
                on E: Exception do
                begin
                  MessageDlg(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern, mtError, [mbOK], -1);
                  Log(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern);
                  Log('playerの分析に失敗しました。');
                  video_player_flag := True;
                end;
              end;
            end;

            if not flashvars_flag then
            begin
              RegExp.Pattern := YOUTUBE_GET_FLASHVARS;
              try
                if RegExp.Test(Content) then
                begin
                  Matches := RegExp.Execute(Content) as MatchCollection;
                  flashvars:= AnsiString(Match(Matches.Item[0]).Value);
                  if Length(flashvars) > 0 then
                  begin
                    flashvars := RegExp.Replace(flashvars, '$1');
                    //Log('flashvars:' + flashvars);
                  end;

                  if Length(flashvars) > 0 then //広告削除
                  begin
                    RegExp.Pattern := YOUTUBE_GET_FLASHVARS_ADS;
                    try
                      if RegExp.Test(flashvars) then
                        flashvars := RegExp.Replace(flashvars, '$1');
                    except
                      on E: Exception do
                      begin
                        MessageDlg(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern, mtError, [mbOK], -1);
                        Log(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern);
                        Log('flashvars_Adの分析に失敗しました。');
                      end;
                    end;
                  end;

                  if Length(flashvars) > 0 then //アノテーションエディタ削除
                  begin
                    RegExp.Pattern := YOUTUBE_GET_FLASHVARS_EDIT;
                    try
                      if RegExp.Test(flashvars) then
                        flashvars := RegExp.Replace(flashvars, '$1$2');
                    except
                      on E: Exception do
                      begin
                        MessageDlg(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern, mtError, [mbOK], -1);
                        Log(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern);
                        Log('flashvars_editの分析に失敗しました。');
                      end;
                    end;
                  end;

                  if Config.optAutoPlay then
                    flashvars := flashvars + '&autoplay=1'
                  else
                    flashvars := flashvars + '&autoplay=0';

                  flashvars_flag := True;
                end;
              except
                on E: Exception do
                begin
                  MessageDlg(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern, mtError, [mbOK], -1);
                  Log(e.Message  + #13#10 + Content + #13#10 + RegExp.Pattern);
                  Log('flashvarsの分析に失敗しました。');
                  flashvars_flag := True;
                end;
              end;
            end;

            if title_flag and videoid_flag and
               video_player_flag and flashvars_flag then
              break;
          end;

        finally  
          Log('データ分析完了');
          ContentList.Free;
        end;

        if Length(VideoData.video_title) > 0 then
        begin
          LabelURL.Caption := '【' + VideoData.video_title + '】';
          LabelURL.Hint := VideoData.video_title + #13#10 + tmpURI2Form;
          Self.Caption := APPLICATION_NAME + ' - [' +VideoData.video_title + ']';
          Application.Title := Self.Caption;
          if SpTBXTitleBar.Active then
            SpTBXTitleBar.Caption := Self.Caption;
          AddRecentlyViewed(VideoData.video_title, VideoData.video_id, 'YouTube');
        end else
          LabelURL.Caption := tmpURI2Form;
        Log('データ分析完了');
        if Length(VideoData.dl_video_id) > 0 then
        begin
          YouTubeRetryCount := 0;
          ActionSave.Enabled := True;
          ActionAddTag.Enabled := True;
          ActionAddAuthor.Enabled := True;
          if USEPLAYER2 then
          begin

            case Config.optFPQuality of
              0: quality := FLASH_QUALITY[0];
              1: quality := FLASH_QUALITY[1];
              2: quality := FLASH_QUALITY[2];
              3: quality := FLASH_QUALITY[3];
              4: quality := FLASH_QUALITY[4];
            end;
            //log(VideoData.dl_video_id);
            dl_video_id := URLDecode(VideoData.dl_video_id);

            innerHTML := '<html><head><title>TubePlayer</title>'#10 +
                         '<base href="' + YOUTUBE_URI + '">'#10 +
                         '<style type="text/css">'#10 +
                         '<!-- body{color: #000000;background: #000000;margin: 0;padding: 0;border: 0;overflow: hidden}'#10 +
                         'embed#EmbedFlash{background: #000000;margin: 0;padding: 0; border: 0; width:expression(document.body.offsetWidth); height:expression(document.body.offsetHeight)} -->'#10 +
                         '</style>'#10 +
                         '</head><body>'#10 +
                         '<embed id="EmbedFlash" src="' + video_player + '"' +
                         ' type=application/x-shockwave-flash wmode=transparent quality=' +
                         quality +
                         ' allowfullscreen="true"' +
                         ' AllowScriptAccess="always"' +
                         ' FlashVars=' + flashvars +
                         '></embed></body></html>';
            //log(innerHTML);
            WebBrowser.LoadFromString(innerHTML);

            //URL := YOUTUBE_VIDEO_PLAYER2 + dl_video_id;
            //WebBrowser.Navigate2(URL); //再生後のリンククリックで動画が開かなくなったので直接開くようにした

            Panel.Tag := 300;
            if (Self.WindowState = wsNormal) and
               (Config.optYouTubeWidthDef > 0) and (Config.optYouTubeHeightDef > 0) then
            begin
              Panel.Tag := 100;
              if SpTBXTitleBar.Active then
              begin
                Self.Width :=  Config.optYouTubeWidthDef + GetSystemMetrics(SM_CXFRAME) * 2 + Self.BorderWidth * 2 + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width + SpTBXSplitterLeft.Width + SpTBXSplitterRight.Width;
                Self.Height := Config.optYouTubeHeightDef + GetSystemMetrics(SM_CYFRAME) * 2 + DockTop.Height + DockBottom.Height + SpTBXTitleBar.FTitleBarHeight;
              end else
              begin
                Self.Width :=  Config.optYouTubeWidthDef + GetSystemMetrics(SM_CXFRAME) * 2 + Self.BorderWidth * 2 + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width + SpTBXSplitterLeft.Width + SpTBXSplitterRight.Width;
                Self.Height := Config.optYouTubeHeightDef + GetSystemMetrics(SM_CYCAPTION) + GetSystemMetrics(SM_CYSIZEFRAME) * 2 + DockTop.Height + DockBottom.Height;
              end;
            end;

            //SetBounds(Self.Left, Self.Top, Self.Width-1, Self.Height);
            PanelMain.BorderWidth := 1;
            TimerSetSetBounds.Enabled := True;
          end;
        end else
        begin
          Log('VideoIDを取得できませんでした。');
          (*YouTubeのログインの仕様が変わったためログインできなくなった。
            対策法が見つかるまでコメントアウトする。
          Log('データ再取得開始');
          GetRetry;
          *)
          procGet := nil;
          exit;
        end;
      end;
    302,303:
      begin
        GetRetry;
        procGet := nil;
        exit;
      end;
    else
      begin
        Log('データの取得に失敗しました。');
        LabelURL.Caption := '【データ取得失敗】' + tmpURI2Form;
      end;
    end;

    procGet := nil;

    Log('');
    SpTBXDockablePanelVideoInfo.Caption := 'ビデオ情報' + ' <取得中>';
    Log('詳細データ取得開始 (' + VideoData.video_id + ')');
    //Log(YOUTUBE_GET_DETAILS_URI_FRONT + VideoData.video_id);
    procGet := AsyncManager.Get(YOUTUBE_GET_DETAILS_URI_FRONT + VideoData.video_id, OnDoneYouTubeDetails);
  end;
end;

//YouTubeから取得した情報を処理する(YouTube Apiからの取得完了時)
procedure TMainWnd.OnDoneYouTubeDetails(sender: TAsyncReq);
var
  CommentsURL: String;

  procedure Build(XMLNode: IXMLNode);
  var
    NS_media, NS_gd, NS_yt: DOMString;
    ANLData: TANLVideoData;
  begin
    NS_media := VarToWStr(XMLNode.Attributes['xmlns:media']);
    NS_gd := VarToWStr(XMLNode.Attributes['xmlns:gd']);
    NS_yt := VarToWStr(XMLNode.Attributes['xmlns:yt']);

    ANLData := YouTubeEntryXMLAnalize(XMLNode, NS_media, NS_gd, NS_yt);
    if Assigned(ANLData) then
    begin
      try
        with VideoData do
        begin
          video_type := ANLData.video_type;
          video_id := ANLData.video_id;
          author := ANLData.author;
          author_link := ANLData.author_link;
          channnel := ANLData.channnel;
          description := ANLData.description;
          video_title := ANLData.video_title;
          thumbnail_url1 := ANLData.thumbnail_url;
          thumbnail_url2 := ANLData.thumbnail_url2;
          thumbnail_url3 := ANLData.thumbnail_url1;
          playtime_seconds := ANLData.playtime_seconds;
          playtime := ANLData.playtime;
          tags := ANLData.keywords;
          rating_avg := ANLData.rating_avg;
          rating := ANLData.rating;
          rationg_count := ANLData.rationg_count;
          view_count := ANLData.view_count;
          update_time := ANLData.update_time;
          upload_time := ANLData.upload_time;
          comment_count := ANLData.comment_count;
          favorited_count := ANLData.favorited_count;
          recording_date := ANLData.recording_date;
          recording_location := ANLData.recording_location;
        end;
        CommentsURL := ANLData.comment_url;
      finally
        ANLData.Free;
      end;
    end;
  end;

var
  HintString: String;
begin
  CommentsURL := '';
  if procGet = sender then
  begin
    Log('【YouTube(OnDoneYouTubeDetails)】' + sender.IdHTTP.ResponseText);
    case sender.IdHTTP.ResponseCode of
    200: (* OK *)
      begin
        Log('データ分析開始');
        XMLDocument.XML.Text := procGet.Content;

        if XMLDocument.XML.Count <= 0 then
        begin
          Log('有効なデータを取得できませんでした。');
          Log('データ分析完了');
          procGet := nil;
          exit;
        end;

        try
          XMLDocument.Active := True;
        except
          on E: Exception do
          begin
            Log(e.Message);
            Log('XMLの解析に失敗しました。');
            SpTBXDockablePanelVideoInfo.Caption := 'ビデオ情報' + ' <解析失敗>';
            XMLDocument.Active := false;
            XMLDocument.XML.Clear;
            procGet := nil;
            exit;
          end;
        end;
        Build(XMLDocument.DocumentElement);
        XMLDocument.Active := false;
        XMLDocument.XML.Clear;

        if Length(VideoData.video_title) > 0 then
        begin
          LabelURL.Caption := '【' + VideoData.video_title + '】';
          HintString := VideoData.video_title + #13#10 + tmpURI2Form;
          if Length(VideoData.rating) > 0 then
          begin
            HintString := HintString + #13#10 + '評価:' + VideoData.rating;
            if Length(VideoData.rationg_count) > 0 then
              HintString := HintString + ' (' + VideoData.rationg_count + ' 件の評価)';
          end;
          if Length(VideoData.view_count) > 0 then
            HintString := HintString + #13#10 + '再生回数:' + VideoData.view_count;
          if Length(VideoData.comment_count) > 0 then
            HintString := HintString + #13#10 + 'コメント:' + VideoData.comment_count;
          if Length(VideoData.favorited_count) > 0 then
            HintString := HintString + #13#10 + 'お気に入り登録:' + VideoData.favorited_count;
          LabelURL.Hint := HintString;
          Self.Caption := APPLICATION_NAME + ' - [' +VideoData.video_title + ']';
          Application.Title := Self.Caption;
          if SpTBXTitleBar.Active then
            SpTBXTitleBar.Caption := Self.Caption;
        end;

        Log('データ分析完了');
      end;
    else
      begin
        SpTBXDockablePanelVideoInfo.Caption := 'ビデオ情報' + ' <取得失敗>';
        Log('詳細データの取得に失敗しました。');
      end;
    end;

    procGet := nil;

    if Length(CommentsURL) > 0 then
    begin
      Log('コメント取得開始 (' + VideoData.video_id + ')');
      procGet := AsyncManager.Get(CommentsURL, OnDoneYouTubeComments);
    end;
  end;
end;

procedure TMainWnd.OnDoneYouTubeComments(sender: TAsyncReq);
  procedure Build(XMLNode: IXMLNode);
  var
    EntryNode: IXMLNode;
    Node: IXMLNode;
    NS_openSearch: DOMString;
    itemsPerPage: Integer;
    i: Integer;
    unixtime: string;
  begin
    NS_openSearch := VarToWStr(XMLNode.Attributes['xmlns:openSearch']);
    Node := XMLNode.ChildNodes.FindNode('itemsPerPage', NS_openSearch);
    if Assigned(Node) then
      itemsPerPage := VarToInt(Node.NodeValue)
    else
      exit;

    SetLength(VideoData.CommentList, itemsPerPage);

    EntryNode := XMLNode.ChildNodes.FindNode('entry');
    i := 0;
    while Assigned(EntryNode) and (EntryNode.NodeName = 'entry') do
    begin
      with VideoData.CommentList[i] do
      begin
        number := IntToStr(i + 1);

        Node := EntryNode.ChildNodes.FindNode('author');
        if Assigned(Node) then
        begin
          author := VarToStr(Node.ChildValues['name']);
          author_link := Format('<a href="%s">%s</a>', [VarToStr(Node.ChildValues['uri']), author]);
        end;

        text := VarToStr(EntryNode.ChildValues['content']);
        unixtime := VarToStr(EntryNode.ChildValues['published']);
        if Length(unixtime) > 0 then
          time := UnixTime2String(unixtime);
      end;
      EntryNode := XMLNode.ChildNodes.FindSibling(EntryNode, 1);
      Inc(i);
    end;
    
    if i < itemsPerPage - 1 then
      SetLength(VideoData.CommentList, i + 1);
  end;

var
  i: integer;
  innerHTML: String;
  Res: String;
begin
  try
    if procGet = sender then
    begin
      Log('【YouTube(OnDoneYouTubeComments)】' + sender.IdHTTP.ResponseText);
      case sender.IdHTTP.ResponseCode of
      200: (* OK *)
        begin
          Log('データ分析開始');
          XMLDocument.XML.Text := procGet.Content;

          if XMLDocument.XML.Count <= 0 then
          begin
            Log('有効なデータを取得できませんでした。');
            Log('データ分析完了');
            exit;
          end;

          try
            XMLDocument.Active := True;
          except
            on E: Exception do
            begin
              Log(e.Message);
              Log('XMLの解析に失敗しました。');
              SpTBXDockablePanelVideoInfo.Caption := 'ビデオ情報' + ' <解析失敗>';
              XMLDocument.Active := false;
              XMLDocument.XML.Clear;
              exit;
            end;
          end;
          Build(XMLDocument.DocumentElement);
          XMLDocument.Active := false;
          XMLDocument.XML.Clear;

          innerHTML := HeaderHTML;

          for i := 0 to Length(VideoData.CommentList) -1 do
          begin
            Res := ResHTML;
            with VideoData.CommentList[i] do
            begin
              Res := CustomStringReplace(Res, '$BR', '<br>');
              Res := CustomStringReplace(Res, '$NUMBER', number);
              Res := CustomStringReplace(Res, '$NAME_LINK', author_link);
              Res := CustomStringReplace(Res, '$NAME', author);
              Res := CustomStringReplace(Res, '$MESSAGE', text);
              Res := CustomStringReplace(Res, '$DATE', time);
            end;
            innerHTML := innerHTML + Res;
          end;

          innerHTML := innerHTML + FooterHTML;

          with VideoData do
          begin
            innerHTML := CustomStringReplace(innerHTML, '$SKINPATH', Config.optSkinPath);
            innerHTML := CustomStringReplace(innerHTML, '$BR', '<br>');
            innerHTML := CustomStringReplace(innerHTML, '$VIDEOTITLE', video_title);
            innerHTML := CustomStringReplace(innerHTML, '$VIDEOID', video_id);
            innerHTML := CustomStringReplace(innerHTML, '$AUTHOR_LINK', author_link);
            innerHTML := CustomStringReplace(innerHTML, '$AUTHOR', author);
            innerHTML := CustomStringReplace(innerHTML, '$THUMBNAIL_URL1', thumbnail_url1);
            innerHTML := CustomStringReplace(innerHTML, '$THUMBNAIL_URL2', thumbnail_url2);
            innerHTML := CustomStringReplace(innerHTML, '$THUMBNAIL_URL3', thumbnail_url3);
            innerHTML := CustomStringReplace(innerHTML, '$TAGS', tags);
            innerHTML := CustomStringReplace(innerHTML, '$CHANNEL', channnel);
            innerHTML := CustomStringReplace(innerHTML, '$RATING_AVG', rating_avg);
            innerHTML := CustomStringReplace(innerHTML, '$RATING_COUNT', rationg_count);
            innerHTML := CustomStringReplace(innerHTML, '$RATING', rating);
            innerHTML := CustomStringReplace(innerHTML, '$VIEW_COUNT', view_count);
            innerHTML := CustomStringReplace(innerHTML, '$DESCRIPTION', description);
            innerHTML := CustomStringReplace(innerHTML, '$COMMENT_COUNT', comment_count);
            innerHTML := CustomStringReplace(innerHTML, '$FAVORITED_COUNT', favorited_count);
            innerHTML := CustomStringReplace(innerHTML, '$UPDATE_TIME', update_time);
            innerHTML := CustomStringReplace(innerHTML, '$UPLOAD_TIME', upload_time);
            innerHTML := CustomStringReplace(innerHTML, '$PLAYTIME_SECONDS', playtime_seconds);
            innerHTML := CustomStringReplace(innerHTML, '$PLAYTIME', playtime);
            innerHTML := CustomStringReplace(innerHTML, '$RECORDING_DATE', recording_date);
            innerHTML := CustomStringReplace(innerHTML, '$RECORDING_LOCATION', recording_location);
            innerHTML := CustomStringReplace(innerHTML, '$RECORDING_COUNTRY', recording_country);
          end;

          WebBrowser2.LoadFromString(innerHTML);

          Log('データ分析完了');

          SpTBXDockablePanelVideoInfo.Caption := 'ビデオ情報';
        end;
      else
        begin
          SpTBXDockablePanelVideoInfo.Caption := 'ビデオ情報' + ' <取得失敗>';
          Log('コメントの取得に失敗しました。');
        end;
      end;
    end;
  finally
    procGet := nil;
  end;

  if Length(VideoData.tags) > 0 then
  begin
    Log('');
    SpTBXDockablePanelVideoRelated.Caption := '関連ビデオ' + ' <取得中>';
    Log('関連ビデオ取得開始 (' + VideoData.video_id + ')');
    procGet := AsyncManager.Get(YOUTUBE_GET_RELATED_URI_FRONT + VideoData.video_id + YOUTUBE_GET_RELATED_URI_BACK, OnDoneYouTubeRelated);
  end;
end;


//YouTubeから取得した情報を処理する(RelatedVideoの取得完了時)
procedure TMainWnd.OnDoneYouTubeRelated(sender: TAsyncReq);

  procedure Build(XMLNode: IXMLNode);
  var
    EntryNode: IXMLNode;
    Node: IXMLNode;
    NS_media, NS_gd, NS_yt, NS_openSearch: DOMString;
    ANLData: TANLVideoData;
    itemsPerPage: Integer;
    i: Integer;
  begin
    NS_media := VarToWStr(XMLNode.Attributes['xmlns:media']);
    NS_gd := VarToWStr(XMLNode.Attributes['xmlns:gd']);
    NS_yt := VarToWStr(XMLNode.Attributes['xmlns:yt']);
    NS_openSearch := VarToWStr(XMLNode.Attributes['xmlns:openSearch']);

    Node := XMLNode.ChildNodes.FindNode('itemsPerPage', NS_openSearch);
    if Assigned(Node) then
      itemsPerPage := VarToInt(Node.NodeValue)
    else
      exit;

    SetLength(VideoData.RelatedList, itemsPerPage);

    EntryNode := XMLNode.ChildNodes.FindNode('entry');
    i := 0;
    while Assigned(EntryNode) and (EntryNode.NodeName = 'entry') do
    begin
      ANLData := YouTubeEntryXMLAnalize(EntryNode, NS_media, NS_gd, NS_yt);
      if Assigned(ANLData) then
      begin
        try
          with VideoData.RelatedList[i] do
          begin
            thumbnail_url1 := ANLData.thumbnail_url;
            thumbnail_url2 := ANLData.thumbnail_url2;
            thumbnail_url3 := ANLData.thumbnail_url1;
            video_id := ANLData.video_id;
            video_title := ANLData.video_title;
            playtime := ANLData.playtime;
            author := ANLData.author;
            author_link := ANLData.author_link;
            view_count := ANLData.view_count;
          end;
          Inc(i);
        finally
          ANLData.Free;
        end;
      end;
      EntryNode := XMLNode.ChildNodes.FindSibling(EntryNode, 1);
    end;

    if i < itemsPerPage - 1 then
      SetLength(VideoData.RelatedList, i + 1);
  end;
var
  innerHTML: String;
  Content: String;
  i: integer;
begin
  try
    if procGet = sender then
    begin
      Log('【YouTube(OnDoneYouTubeRelated)】' + sender.IdHTTP.ResponseText);
      case sender.IdHTTP.ResponseCode of
      200: (* OK *)
        begin
          Log('データ分析開始');

          XMLDocument.XML.Text := procGet.Content;

          if XMLDocument.XML.Count <= 0 then
          begin
            Log('有効なデータを取得できませんでした。');
            Log('データ分析完了');
            exit;
          end;

          try
            XMLDocument.Active := True;
          except
            on E: Exception do
            begin
              Log(e.Message);
              Log('XMLの解析に失敗しました。');
              SpTBXDockablePanelVideoRelated.Caption := '関連ビデオ' + ' <取得失敗>';
              XMLDocument.Active := false;
              XMLDocument.XML.Clear;
              exit;
            end;
          end;
          Build(XMLDocument.DocumentElement);
          XMLDocument.Active := false;
          XMLDocument.XML.Clear;

          innerHTML := R_HeaderHTML;
          for i := 0 to Length(VideoData.RelatedList) -1 do
          begin
            Content := R_ContentHTML;
            with VideoData.RelatedList[i] do
            begin
              if video_id = VideoData.video_id then
                Continue;
              Content := CustomStringReplace(Content, '$THUMBNAIL_URL1', thumbnail_url1);
              Content := CustomStringReplace(Content, '$THUMBNAIL_URL2', thumbnail_url2);
              Content := CustomStringReplace(Content, '$THUMBNAIL_URL3', thumbnail_url3);
              Content := CustomStringReplace(Content, '$VIDEOID', video_id);
              Content := CustomStringReplace(Content, '$VIDEOTITLE', video_title);
              Content := CustomStringReplace(Content, '$PLAYTIME', playtime);
              Content := CustomStringReplace(Content, '$AUTHOR_LINK', author_link);
              Content := CustomStringReplace(Content, '$AUTHOR', author);
              Content := CustomStringReplace(Content, '$VIEW_COUNT', view_count);
            end;
            innerHTML := innerHTML + Content;
          end;

          innerHTML := innerHTML + R_FooterHTML;
          innerHTML := CustomStringReplace(innerHTML, '$SKINPATH', Config.optSkinPath);

          WebBrowser3.LoadFromString(innerHTML);

          SpTBXDockablePanelVideoRelated.Caption := '関連ビデオ';
          Log('データ分析完了');
        end;
      else
        begin
          SpTBXDockablePanelVideoRelated.Caption := '関連ビデオ' + ' <取得失敗>';
          Log('関連ビデオの取得に失敗しました。');
        end;
      end;
    end;
  finally
    procGet := nil;
  end;
end;


//UnixTimeをStringに変換する
function TMainWnd.UnixTime2String(const str: string): String;
var
  tim: integer;
  DateTime: TDateTime;
begin
  try
    tim := StrToInt(str);
  except
    result := '';
    exit;
  end;
  DateTime := (tim - TimeZoneBias)/(24*60*60) + UnixDateDelta;
  Result := FormatDateTime('yyyy/mm/dd(aaa) hh:nn:ss', DateTime);
end;

//UnixTimeをDateTimeに変換する
function TMainWnd.UnixTime2DateTime(const str: string): TDateTime;
var
  tim: integer;
begin
  try
    tim := StrToInt(str);
  except
    result := 0;
    exit;
  end;
  result := (tim - TimeZoneBias)/(24*60*60) + UnixDateDelta;
end;

//ブラウザで開く
procedure TMainWnd.OpenByBrowser(const URI: string);
begin
  if Length(URI) <= 0 then
    exit;
  if Config.optBrowserSpecified then
  begin
    if Config.optUseShellExecute then
      ShellExecute(0, 'open', PChar(Config.optBrowserPath), PChar(URI), nil, SW_SHOW)
    else
      CommandExecute(Config.optBrowserPath + ' ' + URI);
  end else
  begin
    if Config.optUseShellExecute then
      ShellExecute(0, 'open', PChar(URI), nil, nil, SW_SHOW)
    else
      CommandExecute(GetRelatedExe('.HTML') + ' ' + URI);
  end;
end;

//ダウンロードツールにURL/タイトルを送る
procedure TMainWnd.CommandExecuteForTool(URI: string; OrgURI: string; Title: string);
var
  command: String;
  Extension: String;
  Si: TStartupInfo;
  Pi: TProcessInformation;
begin
  if (Length(URI) <= 0) and (Length(OrgURI) <= 0) then
    exit;
  if Length(Config.optDownloaderPath) <= 0 then
    exit;

  command := Config.optDownloaderPath;
  Extension := ExtractFileExt(command);
  if (AnsiCompareText(Extension, '.js') = 0) or (AnsiCompareText(Extension, '.vbs') = 0) then
    command := 'wscript.exe "' + command + '"';

  if Length(Config.optDownloaderOption) > 0 then
    command := command + ' ' + Config.optDownloaderOption;

  if AnsiContainsStr(command, '$URL2') then
    command := CustomStringReplace(command, '$URL2', OrgURI);
  if AnsiContainsStr(command, '$URL') then
    command := CustomStringReplace(command, '$URL', URI);
  if AnsiContainsStr(command, '$TITLE') then
    command := CustomStringReplace(command, '$TITLE', Title);

  GetStartupInfo(Si);
  CreateProcess(nil, PAnsiChar(command), nil, nil, false, 0, nil, nil, Si, Pi);
  CloseHandle(Pi.hProcess);
  CloseHandle(Pi.hThread);
end;

//アップデートチェック後のバージョンを分析する
procedure TMainWnd.OnAnalysis(sender: TAsyncReq);

  function CompareVersion(Now,New: String): Boolean;
  var
    NowMajor, NewMajor, NowMinor, NewMinor: integer;
  begin
    result := false;
    if Now = New then
    begin
      Config.optUpdateCheckFailedCount := 0;
      exit;
    end;
    try
      if PosEx('/', New) > 0 then //将来のversion.txtの仕様変更用
      begin
        New := Copy(New, 0, PosEx('/', New) -1);
      end;
      if PosEx('β', Now) > 0 then
      begin
        Now := Copy(Now, 0, PosEx('β', Now) -1);
        if Now = New then
        begin
          result := true;     
          Config.optUpdateCheckFailedCount := 0;
          exit;
        end;
      end;
      NowMajor := StrToIntDef(Copy(Now, 0, PosEx('.', Now) -1), 9999);
      NewMajor := StrToIntDef(Copy(New, 0, PosEx('.', New) -1), 0);
      if NewMajor - NowMajor > 0 then
      begin
        result := true;
        Config.optUpdateCheckFailedCount := 0;
        exit;
      end
      else if NewMajor - NowMajor = 0 then
      begin
        NowMinor := StrToIntDef(Copy(Now, PosEx('.', Now) +1, high(integer)), 9999);
        NewMinor := StrToIntDef(Copy(New, PosEx('.', New) +1, high(integer)), 0);
        if NewMinor - NowMinor > 0 then
        begin
          result := true;
          Config.optUpdateCheckFailedCount := 0;
          exit;
        end;
      end;
      Config.optUpdateCheckFailedCount := 0;
    except
      on E: Exception do
      begin
        MessageDlg(e.Message, mtError, [mbOK], -1);
        Log(e.Message);
        Log('データの分析に失敗しました。');
        Inc(Config.optUpdateCheckFailedCount);
        if NoPopup then
        begin
          if Config.optUpdateCheckFailedCount > 29 then
          begin
            Log('自動アップデートチェック機能をオフにしました。');
            MessageDlg('更新情報を30回連続して取得できませんでした。' + #13#10 + '自動アップデートチェック機能をオフにしました。', mtInformation, [mbOK], -1);
            Config.optUpdateCheck := false;
            Config.optLastUpdateCheckTime := '';
            Config.optUpdateCheckFailedCount := 0;
          end;
        end else
          MessageDlg('データの分析に失敗しました。', mtInformation, [mbOK], -1);
      end;
    end;
  end;

var
  New: String;
begin
  if procGet2 = sender then
  begin
    Log('【TubePlayer公式サイト】' + sender.IdHTTP.ResponseText);
    case sender.IdHTTP.ResponseCode of
    200: (* OK *)
      begin
        New := sender.Content;
        if New = 'END' then //将来アップデートチェック機能を無効にするため用
        begin
          Config.optUpdateCheck := false;
          Log('アップデートチェックサービスは終了しました。');
          procGet2 := nil;
          exit;
        end;
        if CompareVersion(VERSION, New) then
        begin
          Log('最新バージョンの入手が可能です。');
          Log('アップデートチェック完了');
          UpdateDlg := TUpdateDlg.Create(self);
          UpdateDlg.VersionLabel.Caption := 'Version ' + VERSION + ' → ' + 'Version ' + New;
          UpdateDlg.CheckBoxOptUpdateCheck.Checked := not Config.optUpdateCheck;
          try
            ShowModalDlg(Self, UpdateDlg, Config.optFormStayOnTop);
          finally
            UpdateDlg.Release;
          end;

        end
        else if Config.optUpdateCheckFailedCount = 0 then
        begin
          Log('最新バージョンを使用しています。');
          Log('アップデートチェック完了');
          if not NoPopup then
            MessageDlg('最新バージョンを使用しています。', mtInformation, [mbOK], -1);
        end;
      end;
    else
      begin
        if NoPopup then
        begin
          Inc(Config.optUpdateCheckFailedCount);
          if Config.optUpdateCheckFailedCount > 6 then
          begin
            Log('自動アップデートチェック機能をオフにしました。');
            MessageDlg('更新情報を7回連続して取得できませんでした。' + #13#10 + '自動アップデートチェック機能をオフにしました。', mtInformation, [mbOK], -1);
            Config.optUpdateCheck := false;
            Config.optLastUpdateCheckTime := '';
            Config.optUpdateCheckFailedCount := 0;
          end;
        end;
        Log('バージョン情報を取得できませんでした。');
      end;
    end;
    procGet2 := nil;
    if Config.Modified then
      Config.Save;
  end;
end;

//UserAgentをTubePlayer/x.xxに変更
procedure TMainWnd.OnTubePreConnect(sender: TAsyncReq; code: TAsyncNotifyCode);
var
  userAgent: string;
begin
  if code <> ancPRECONNECT then
    exit;
  userAgent := APPLICATION_NAME  + '/' + Main.VERSION;
  TAsyncReq(sender).IdHTTP.Request.UserAgent := userAgent;

  //リダイレクトの設定
  TAsyncReq(sender).IdHTTP.HandleRedirects := True;
  TAsyncReq(sender).IdHTTP.RedirectMaximum := 2;
end;

//WSHの取得ページをIEで開く
procedure TMainWnd.LabelWSH2Click(Sender: TObject);
var
  URI: String;
begin
  URI := 'http://www.microsoft.com/japan/msdn/scripting/';
  CommandExecute(GetRelatedExe('.HTML') + ' ' + URI);
end;

//FlashPlayerの取得ページを開く
procedure TMainWnd.LabelFlash2Click(Sender: TObject);
var
  URI: String;
begin
  URI := 'http://www.adobe.com/shockwave/download/index.cgi?Lang=Japanese&P1_Prod_Version=ShockwaveFlash';
  CommandExecute(GetRelatedExe('.HTML') + ' ' + URI);
end;

//WSHとFLASHの対応を示すcheck.datの作成/削除
procedure TMainWnd.CheckBoxThroughClick(Sender: TObject);
var
  datPath: String;
  Checklist: TStringList;
begin
  datPath := ExtractFilePath(Application.ExeName) + CHECK_DAT;
  if CheckBoxThrough.Checked then
  begin
    Checklist := TStringList.Create;
    try
      Checklist.SaveToFile(datPath);
    except
      on E: Exception do
      begin
        MessageDlg(e.Message, mtError, [mbOK], -1);
        Log(e.Message);
      end;
    end;
    Checklist.Free;
  end else
  begin
    if FileExists(datPath) then
      DeleteFile(datPath);
  end;
end;

//IEコンポのサイズを無理やり変更してFlashPlayerをビデオパネルのサイズにする
procedure TMainWnd.TimerSetSetBoundsTimer(Sender: TObject);
begin
  TimerSetSetBounds.Enabled := false;
  //SetBounds(Self.Left, Self.Top, Self.Width +1, Self.Height);
  PanelMain.BorderWidth := 0;
end;

//アプリケーションの自動終了用のタイマー
procedure TMainWnd.TimerAutoCloseTimer(Sender: TObject);
begin
  TimerAutoClose.Enabled := false;
  Application.MainForm.Close;
end;

//検索結果を表示
procedure TMainWnd.ListViewData(Sender: TObject; Item: TListItem);
var
  SearchData: TSearchData;

  function GetAddString(column: integer): string;
  begin
    result := '';
    case column of
    LVSC_NUMBER:
      begin
        result := IntToStr(SearchList.IndexOf(SearchData) +1);
      end;
    LVSC_TITLE:
      begin
        result := CustomStringReplace(SearchData.video_title,  '&#039;', '''');
        //result := SearchData.video_title;
      end;
    LVSC_PLAYTIME:
      begin
        result := SearchData.playtime;
      end;
    LVSC_RATING_AVG:
      begin
        result := SearchData.rating_avg;
      end;
    LVSC_RATING_COUNT:
      begin
        result := SearchData.rationg_count;
      end;
    LVSC_VIEW_COUNT:
      begin
        result := SearchData.view_count;
      end;
    LVSC_SPEED:
      begin
        if (Length(SearchData.view_count) > 0) and (Length(SearchData.upload_time) > 0) then
        try
          result := FloatToStrF(StrToIntDef(SearchData.view_count, 0) / (MinutesBetween(now, UnixTime2DateTime(SearchData.upload_unixtime)) +1) * 60 * 24 ,
                                ffFixed, 7, 1);
        except
          result := '0';
        end;
      end;
    LVSC_AUTHOR:
      begin
        result := SearchData.author;
      end;
    LVSC_UPLOAD_TIME:
      begin
        result := SearchData.upload_time;
      end;
    LVSC_VIDEOID:
      begin
        result := SearchData.video_id;
      end;
    end;
  end;

var
  i: integer;
begin
  SearchData := ListView.List[Item.Index];
  if SearchData = nil then
    exit;
  Item.Data := SearchData;

  Item.Caption := GetAddString(ListView.Columns[0].Tag);
  for i := 1 to ListView.Columns.Count -1 do
  begin
    Item.SubItems.Add(GetAddString(ListView.Columns[i].Tag));
  end;

end;

//カラムをクリックしてソート
procedure TMainWnd.ListViewColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  ListViewColumnSort(Column.Tag);
end;

//ソート
function XVAL(i:integer):integer;
begin
  if i <= 0 then
    result := high(integer)
  else
    result := i;
end;

//番号
function ListCompareFuncNumber(Item1, Item2: Pointer): integer;
begin
  result := SearchList.IndexOf(Item1) - SearchList.IndexOf(Item2);
  if currentSortColumn = -LVSC_NUMBER then
    result := -result;
end;

//タイトル
function ListCompareFuncTitle(Item1, Item2: Pointer): integer;
begin
  result := AnsiCompareStr(TSearchData(Item1).video_title, TSearchData(Item2).video_title);
  if currentSortColumn = -LVSC_TITLE then
    result := -result;
end;

//再生時間
function ListCompareFuncPlayTime(Item1, Item2: Pointer): integer;
begin
  result := StrToIntDef(TSearchData(Item1).playtime_seconds, 0) - StrToIntDef(TSearchData(Item2).playtime_seconds, 0);
  if currentSortColumn = -LVSC_PLAYTIME then
    result := -result;
end;

//評価平均
function ListCompareFuncRatingAvg(Item1, Item2: Pointer): integer;
begin
  result := Trunc(StrToFloatDef(TSearchData(Item1).rating_avg, 0)*1000 - StrToFloatDef(TSearchData(Item2).rating_avg, 0)*1000);
  if currentSortColumn = -LVSC_RATING_AVG then
    result := -result;
end;

//評価回数
function ListCompareFuncRatingCount(Item1, Item2: Pointer): integer;
begin
  result := StrToIntDef(TSearchData(Item1).rationg_count, 0) - StrToIntDef(TSearchData(Item2).rationg_count, 0);
  if currentSortColumn = -LVSC_RATING_COUNT then
    result := -result;
end;

//閲覧回数
function ListCompareFuncViewCount(Item1, Item2: Pointer): integer;
begin
  result := StrToIntDef(TSearchData(Item1).view_count, 0) - StrToIntDef(TSearchData(Item2).view_count, 0);
  if currentSortColumn = -LVSC_VIEW_COUNT then
    result := -result;
end;

//ユーザー名
function ListCompareFuncAuthor(Item1, Item2: Pointer): integer;
begin
  result := AnsiCompareStr(TSearchData(Item1).author, TSearchData(Item2).author);
  if currentSortColumn = -LVSC_AUTHOR then
    result := -result;
end;

//追加時間
function ListCompareFuncUploadTime(Item1, Item2: Pointer): integer;
begin
  result := StrToIntDef(TSearchData(Item1).upload_unixtime, 0) - StrToIntDef(TSearchData(Item2).upload_unixtime, 0);
  if currentSortColumn = -LVSC_UPLOAD_TIME then
    result := -result;
end;

//VideoID
function ListCompareFuncVideoID(Item1, Item2: Pointer): integer;
begin
  result := AnsiCompareStr(TSearchData(Item1).video_id, TSearchData(Item2).video_id);
  if currentSortColumn = -LVSC_VIDEOID then
    result := -result;
end;

//勢い
function ListCompareFuncSpeed(Item1, Item2: Pointer): integer;
var
  c1, c2: Integer;
begin
  try
    c1 := Trunc(StrToIntDef(TSearchData(Item1).view_count, 0) / (MinutesBetween(now, MainWnd.UnixTime2DateTime(TSearchData(Item1).upload_unixtime)) +1) *60 *24 *1000);
  except
    c1 := 0;
  end;
  try
    c2 := Trunc(StrToIntDef(TSearchData(Item2).view_count, 0) / (MinutesBetween(now, MainWnd.UnixTime2DateTime(TSearchData(Item2).upload_unixtime)) +1) *60 *24 *1000);
  except
    c2 := 0;
  end;

  if currentSortColumn = -LVSC_SPEED then
  begin
    if c1 = 0 then
      c1 := high(integer);
    if c2 = 0 then
      c2 := high(integer);
    result := c1 - c2;
  end else
    result := c2 - c1;

  if result = 0 then
    result := ListCompareFuncUploadTime(Item1, Item2);
end;

//検索にヒットした動画を上げる
function ListCompareFuncSearchItem(Item1, Item2: Pointer): Integer;
begin
  Result := TSearchData(Item2).liststate - TSearchData(Item1).liststate;
  if result <> 0 then
    exit;
  if TSearchData(Item2).liststate > 1 then
    Result := ListCompareFuncNumber(Item1, Item2);
end;

function ListCompare(Item1, Item2: Pointer): Integer;
begin
  Result := 0;

  if SearchedEnd then
    Result := ListCompareFuncSearchItem(Item1, Item2);

  if Result <> 0 then
    exit;

  case abs(currentSortColumn) of
    LVSC_NUMBER:         Result := ListCompareFuncNumber(Item1, Item2);
    LVSC_TITLE:          Result := ListCompareFuncTitle(Item1, Item2);
    LVSC_PLAYTIME:       Result := ListCompareFuncPlayTime(Item1, Item2);
    LVSC_RATING_AVG:     Result := ListCompareFuncRatingAvg(Item1, Item2);
    LVSC_RATING_COUNT:   Result := ListCompareFuncRatingCount(Item1, Item2);
    LVSC_VIEW_COUNT:     Result := ListCompareFuncViewCount(Item1, Item2);
    LVSC_SPEED:          Result := ListCompareFuncSpeed(Item1, Item2);
    LVSC_AUTHOR:         Result := ListCompareFuncAuthor(Item1, Item2);
    LVSC_UPLOAD_TIME:    Result := ListCompareFuncUploadTime(Item1, Item2);
    LVSC_VIDEOID:        Result := ListCompareFuncVideoID(Item1, Item2);
  end;

  if Result <> 0 then
    exit;

  Result := ListCompareFuncNumber(Item1, Item2);
end;

procedure TMainWnd.ListViewColumnSort(columnIndex: Integer);
begin
  //▼すでにソートされていたら逆順(負号)に設定する
  if columnIndex = currentSortColumn then
  begin
    if currentSortColumn = 0 then
      currentSortColumn := 1
    else
      currentSortColumn := -columnIndex
  end else
    currentSortColumn := columnIndex;

  ListView.Sort(@ListCompare);
end;

(* ActiveXでファイルをダウンロードする
function DoFileDownload(var lpszFile :WideChar): LONGBOOL; stdcall; external 'shdocvw.dll';

procedure DoOnFileDownlaod(const URL: string);
var
  WideURL: array of WideChar;
begin
  SetLength(WideURL, 2084);
  StringToWideChar(URL, @WideURL[0], 2083);
  DoFileDownload(WideURL[0]);
end;
*)

//設定画面を開く
procedure TMainWnd.ActionSettingExecute(Sender: TObject);
var
  IsProxy: Boolean;
begin
  IsProxy := Config.netUseProxy and (Length(Config.netProxyServer) > 0);
  UIConfig := TUIConfig.Create(self);
  try
    ShowModalDlg(Self, UIConfig, Config.optFormStayOnTop);
  finally
    UIConfig.Release;
  end;
  if Config.ColorChanged then
  begin
    ListView.Invalidate;
  end;
  if Config.Modified then
  begin
    if Config.netUseProxy and (Length(Config.netProxyServer) > 0) then
    begin
      SetProxy(Config.netProxyServer + ':' + IntToStr(Config.netProxyPort));
    end
    else if IsProxy then
      SetDirectConnection;
    {
    if Config.optUseDefaultTitleBar then
    begin
      PanelMain.Parent := Self;
      SpTBXTitleBar.Active := False;
    end else
    begin
      SpTBXTitleBar.Active := True;
      PanelMain.Parent := SpTBXTitleBar;
      SpTBXTitleBar.Caption := Self.Caption;
    end;
    }
    Config.Save;
    Config.Modified := false;
  end;
end;

//アプリを終了する
procedure TMainWnd.ActionExitExecute(Sender: TObject);
begin
  Application.MainForm.Close;
end;

//ビデオをブラウザで開く
procedure TMainWnd.ActionOpenByBrowserExecute(Sender: TObject);
begin
  OpenByBrowser(tmpURI);
end;

//新しいURLを開く
procedure TMainWnd.ActionOpenNewExecute(Sender: TObject);
const
  NICO_TARGET = '(?:sm|am|fz)\d+';

  function URIDialog: String;
  var
    rc: integer;
    clip: String;
    i: integer;
    flag: boolean;
  begin
    if InputDlg = nil then
      InputDlg := TInputDlg.Create(self);
    InputDlg.Caption := 'URLを入力してください';
    clip := Clipboard.AsText;
    if Length(clip) > 0 then
    begin
      flag := false;
      for i := Low(URI_TARGET) to High(URI_TARGET) do
      begin
        RegExp.Pattern := URI_TARGET[i];
        if RegExp.Test(clip) then
        begin
          flag := true;
          break;
        end;
      end;

      RegExp.Pattern := NICO_TARGET;
      if not flag and RegExp.Test(clip) then
      begin
        flag := true;
      end;

      RegExp.Pattern := GET_USER_ITEM;
      if not flag and RegExp.Test(clip) then //YouTubeユーザー検索
      begin
        flag := true;
      end;

      RegExp.Pattern := GET_ICHIBA_ITEM;
      if not flag and RegExp.Test(clip) then //ニコニコ市場
      begin
        flag := true;
      end;

      RegExp.Pattern := GET_MYLIST;
      if not flag and RegExp.Test(clip) then //マイリスト
      begin
        flag := true;
      end;

      if not flag then
        clip := '';
    end;
    InputDlg.Edit.Text := clip;

    rc := ShowModalDlg(Self, InputDlg, Config.optFormStayOnTop);
    if (rc <> 3) then
      Result:= '$$$'
    else
      Result := Trim(InputDlg.Edit.Text);
  end;

var
  URI: String;
  i: integer;
begin
  URI := URIDialog;
  if Length(URI) > 0 then
  begin
    if URI = '$$$' then
      exit;
    for i := Low(URI_TARGET) to High(URI_TARGET) do
    begin
      RegExp.Pattern := URI_TARGET[i];
      if RegExp.Test(URI) then
      begin
        SetURIwithClear(URI);
        exit;
      end;
    end;

    RegExp.Pattern := NICO_TARGET;
    if RegExp.Test(URI) then
    begin
      URI := NICOVIDEO_GET_URI + URI;
      SetURIwithClear(URI);
      exit;
    end;

    RegExp.Pattern := GET_USER_ITEM;
    if RegExp.Test(URI) then //YouTubeユーザー検索
    begin
      URI := 'user:' + RegExp.Replace(URI, '$1');
      SearchBarComboBox.Text := URI;
      PanelSearchComboBox.Text := URI;
      ActionSearchBarSearch.Execute;
      exit;
    end;

    RegExp.Pattern := GET_ICHIBA_ITEM;
    if RegExp.Test(URI) then //ニコニコ市場
    begin
      GetNicoIchibaExecute(URI);
      exit;
    end;

    RegExp.Pattern := GET_MYLIST;
    if RegExp.Test(URI) then //マイリスト
    begin
      GetNicoMylistExecute(URI);
      exit;
    end;

    OpenByBrowser(URI);
  end else
  begin
    SetURIwithClear('');
  end;
end;

//ビデオを保存する
procedure TMainWnd.ActionSaveExecute(Sender: TObject);
var
  URI: string;
  OrgURI: string;
  Title: string;
begin
  if (Length(VideoData.dl_video_id) > 0) or
     ((Config.optDownloadOption = 2) and AnsiContainsStr(Config.optDownloaderOption, '$URL2')) then
  begin
    if VideoData.video_type = 0 then //YouTube
    begin
      URI := YOUTUBE_GET_VIDEO_URI + VideoData.dl_video_id;
      OrgURI := YOUTUBE_GET_WATCH_URI + VideoData.video_id + Config.optMP4Format;
      Title := VideoData.video_title;
      if Length(VideoData.video_title) > 0 then
      begin
        Title := CustomStringReplace(Title, '＼', '_');
        Title := CustomStringReplace(Title, '/', '_');
        Title := CustomStringReplace(Title, ':', '_');
        Title := CustomStringReplace(Title, '*', '_');
        Title := CustomStringReplace(Title, '?', '_');
        Title := CustomStringReplace(Title, '"', '_');
        Title := CustomStringReplace(Title, '<', '_');
        Title := CustomStringReplace(Title, '>', '_');
        Title := CustomStringReplace(Title, '|', '_');
      end;
      if Config.optUseMP4 then
        Clipboard.AsText := Title + '.mp4'
      else
        Clipboard.AsText := Title + '.flv';

      case Config.optDownloadOption of
        0: OpenByBrowser(URI); //デフォルト/指定のブラウザでダウンロード
        1: ;//★内蔵ダウンローダでダウンロード
        2: begin  //ダウンロードツールでダウンロード
             if Config.optUseMP4 then
               CommandExecuteForTool(URI, OrgURI, Title + '.mp4')
             else
               CommandExecuteForTool(URI, OrgURI, Title + '.flv');
           end;
        3: Clipboard.AsText := URI; //クリップボードにコピー
      end;
    end else if VideoData.video_type in [1..5] then  //ニコニコ動画
    begin
      if AnsiStartsStr('http://', VideoData.dl_video_id) then
      begin
        URI := VideoData.dl_video_id;
        OrgURI := NICOVIDEO_GET_URI + VideoData.video_id;
        Title := VideoData.video_title;
        if Length(VideoData.video_title) > 0 then
        begin
          Title := CustomStringReplace(Title, '＼', '_');
          Title := CustomStringReplace(Title, '/', '_');
          Title := CustomStringReplace(Title, ':', '_');
          Title := CustomStringReplace(Title, '*', '_');
          Title := CustomStringReplace(Title, '?', '_');
          Title := CustomStringReplace(Title, '"', '_');
          Title := CustomStringReplace(Title, '<', '_');
          Title := CustomStringReplace(Title, '>', '_');
          Title := CustomStringReplace(Title, '|', '_');
        end;
        if Length(VideoData.video_ext) > 0 then
          Title := Title + VideoData.video_ext
        else
          Title := Title + '.flv';
        Clipboard.AsText := Title;

        case Config.optDownloadOption of
          0: OpenByBrowser(URI); //デフォルト/指定のブラウザでダウンロード
          1: ;//★内蔵ダウンローダでダウンロード
          2: CommandExecuteForTool(URI, OrgURI, Title); //ダウンロードツールでダウンロード
          3: Clipboard.AsText := URI; //クリップボードにコピー
        end;
      end else
      begin
        Log('');
        Log('データ取得開始');
        Log(NICOVIDEO_GET_VIDEO_URI + VideoData.video_id);
        procGet4 := AsyncManager.Get(NICOVIDEO_GET_VIDEO_URI + VideoData.video_id, OnDoneNicoVideoGetURI, OnNicoVideoPreConnect);
      end;
    end;
  end;
end;

//nicovideo(ニコニコ動画)から取得した情報(DL先URL)を処理する
procedure TMainWnd.OnDoneNicoVideoGetURI(sender: TAsyncReq);
var
  i: integer;
  ContentList: TStringList;
  Content: String;
  URI: string;
  OrgURI: string;
  Title: String;
  startpos, endpos: integer;
begin
  if procGet4 = sender then
  begin
    Log('【nicovideo(OnDoneNicoVideoGetURI)】' + sender.IdHTTP.ResponseText);
    case sender.IdHTTP.ResponseCode of
    200: (* OK *)
      begin
        Log('データ分析開始');
        ContentList := TStringList.Create;
        try
          ContentList.Text := procGet4.Content;
          for i := 0 to ContentList.Count -1 do
          begin
            Content := URLDecode(UTF8toAnsi(ContentList[i]));
            if Length(Content) > 0 then
            begin
              if AnsiPos('url=', Content) > 0 then
              begin
                startpos := PosEx('url=', Content) + 4;
                endpos := PosEx('&', Content, startpos);
                URI := Copy(Content, startpos, endpos - startpos);
                break;
              end;
            end else
              Continue;
          end;
        finally
          ContentList.Free;
        end;
        Log('データ分析完了');
      end;
    else
      begin
        Log('データの取得に失敗しました。');
        MessageDlg('データの取得に失敗しました。', mtError, [mbOK], -1);
      end;
    end;
    procGet4:= nil;
    OrgURI := NICOVIDEO_GET_URI + VideoData.video_id;

    if (Length(URI) > 0) or
       (Config.optDownloadOption = 2) and AnsiContainsStr(Config.optDownloaderOption, '$URL2') then
    begin
      Title := VideoData.video_title;
      if Length(VideoData.video_title) > 0 then
      begin
        Title := CustomStringReplace(Title, '＼', '_');
        Title := CustomStringReplace(Title, '/', '_');
        Title := CustomStringReplace(Title, ':', '_');
        Title := CustomStringReplace(Title, '*', '_');
        Title := CustomStringReplace(Title, '?', '_');
        Title := CustomStringReplace(Title, '"', '_');
        Title := CustomStringReplace(Title, '<', '_');
        Title := CustomStringReplace(Title, '>', '_');
        Title := CustomStringReplace(Title, '|', '_');
      end;
      
      if Length(VideoData.video_ext) > 0 then
        Title := Title + VideoData.video_ext
      else
        Title := Title + '.flv';
      Clipboard.AsText := Title;

      case Config.optDownloadOption of
        0: OpenByBrowser(URI); //デフォルト/指定のブラウザでダウンロード
        1: ;//★内蔵ダウンローダでダウンロード
        2: CommandExecuteForTool(URI, OrgURI, Title); //ダウンロードツールでダウンロード
        3: Clipboard.AsText := URI; //クリップボードにコピー
      end;
    end else
    begin
      Log('データの取得に失敗しました。');
      MessageDlg('データの取得に失敗しました。', mtError, [mbOK], -1);
    end;

  end;
end;

//ビデオのタイトルとURLをコピーする
procedure TMainWnd.ActionCopyTUExecute(Sender: TObject);
begin
  if Length(VideoData.video_title) > 0 then
    Clipboard.AsText := VideoData.video_title +#13#10 + tmpURI
  else
    Clipboard.AsText := tmpURI;
end;

//ビデオのURLをコピーする
procedure TMainWnd.ActionCopyURLExecute(Sender: TObject);
begin
  Clipboard.AsText := tmpURI;
end;

//バグレポートを開く
procedure TMainWnd.ActionBugReportExecute(Sender: TObject);
begin
  BugReport := TBugReport.Create(self);
  try
    ShowModalDlg(Self, BugReport, Config.optFormStayOnTop);
  finally
    BugReport.Release;
  end;
end;

//アップデートチェックをする
procedure TMainWnd.ActionCheckUpdateExecute(Sender: TObject);
begin
  NoPopup := false;
  ShortDateFormat := 'yy/mm/dd';

  Config.optLastUpdateCheckTime := DateToStr(Now);
  Config.Modified := true;
  Log('');
  Log('アップデートチェック開始');
  procGet2 := AsyncManager.Get(UPDATE_CHECK_URI, OnAnalysis, OnTubePreConnect);
end;

//アップデートチェック(起動時用)
procedure TMainWnd.ActionCheckUpdateOnStartUpExecute(Sender: TObject);
var
  i: integer;
begin
  NoPopup := false;
  ShortDateFormat := 'yy/mm/dd';
  try
    NoPopup := true;
    if Config.optLastUpdateCheckTime <> '' then
    begin
      i := Trunc(Now) - Trunc(StrToDate(Config.optLastUpdateCheckTime));
      if i = 0 then
        exit;
    end;
  except
    on E: Exception do
    begin
      MessageDlg(e.Message, mtError, [mbOK], -1);
      Log(e.Message);
      Config.optLastUpdateCheckTime := '';
    end;
  end;

  Config.optLastUpdateCheckTime := DateToStr(Now);
  Config.Modified := true;
  Log('');
  Log('アップデートチェック開始');
  procGet2 := AsyncManager.Get(UPDATE_CHECK_URI, OnAnalysis, OnTubePreConnect);
end;

//ヘルプファイルを開く
procedure TMainWnd.ActionHelpExecute(Sender: TObject);
var
  path: String;
begin
  path := Config.BasePath + 'help.txt';
  if Config.optUseShellExecute then
    ShellExecute(Handle,'open',PChar(path),'','',SW_SHOW)
  else
    CommandExecute(GetRelatedExe('.TXT') + ' ' + path);
end;

//バージョン情報を開く
procedure TMainWnd.ActionVersionExecute(Sender: TObject);
begin
  VersionInfo := TVersionInfo.Create(self);
  VersionInfo.LabelVersion.Caption := Main.APPLICATION_NAME + ' Version ' + Main.VERSION + ' (' + GetExeVersion + ')';
  VersionInfo.LabelURI.Caption := Main.DISTRIBUTORS_SITE;
  VersionInfo.LabelCopyright.Caption := Main.COPYRIGHT; 
  VersionInfo.LabelCopyright2.Caption := Main.COPYRIGHT2;
  try
    ShowModalDlg(Self, VersionInfo, Config.optFormStayOnTop);
  finally
    VersionInfo.Release;
  end;
end;

//ウィンドウサイズを規定値に戻す
procedure TMainWnd.ActionDefaultWindowSizeExecute(Sender: TObject);
var
  VideoWidth: integer;
  VideoHeight: integer;
begin
  if VideoData.video_type in [1..5] then //nicovideo
  begin
    Panel.Tag := 10;
    VideoWidth  := Config.optNicoVideoWidthDef;
    VideoHeight := Config.optNicoVideoHeightDef;
  end else //YouTube
  begin
    Panel.Tag := 100;
    VideoWidth  := Config.optYouTubeWidthDef;
    VideoHeight := Config.optYouTubeHeightDef;
  end;
  if SpTBXTitleBar.Active then
  begin
    Self.Width :=  VideoWidth + GetSystemMetrics(SM_CXFRAME) * 2 + Self.BorderWidth * 2 + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width + SpTBXSplitterLeft.Width + SpTBXSplitterRight.Width;
    Self.Height := VideoHeight + GetSystemMetrics(SM_CYFRAME) * 2 + DockTop.Height + DockBottom.Height + SpTBXTitleBar.FTitleBarHeight;
  end else
  begin
    Self.Width :=  VideoWidth + GetSystemMetrics(SM_CXFRAME) * 2 + Self.BorderWidth * 2 + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width + SpTBXSplitterLeft.Width + SpTBXSplitterRight.Width;
    Self.Height := VideoHeight + GetSystemMetrics(SM_CYCAPTION) + GetSystemMetrics(SM_CYSIZEFRAME) * 2 + DockTop.Height + DockBottom.Height;
  end;
end;

//最前面
procedure TMainWnd.ActionStayOnTopExecute(Sender: TObject);
begin
  if Self.Visible then
  begin
    Config.optFormStayOnTop := not Config.optFormStayOnTop;
    Config.Modified := True;
  end else if Config.optFormStayOnTopPlaying then //ビデオ再生時のみ最前面表示にする
    Config.optFormStayOnTop := (Length(tmpURI) > 0);

  ActionStayOnTop.Checked := Config.optFormStayOnTop;

  if Config.optFormStayOnTop then
    SetWindowPos(Handle,HWND_TOPMOST,0,0,0,0,SWP_NOSIZE or SWP_NOMOVE) //FormStyle := fsStayOnTop
  else
    SetWindowPos(Handle,HWND_NOTOPMOST,0,0,0,0,SWP_NOSIZE or SWP_NOMOVE); //FormStyle := fsNormal;
end;

//ウィンドウの位置・状態を保存する
procedure TMainWnd.SpTBXCustomizerSave(Sender: TObject;
  ExtraOptions: TStringList);
var
  Placement: TWindowPlacement;
  R: PRect;
  i: integer;
begin
  DockTop.AllowDrag := true;
  DockBottom.AllowDrag := true;
  DockLeft.AllowDrag := true;
  DockLeft2.AllowDrag := true;
  DockRight.AllowDrag := true;
  DockRight2.AllowDrag := true;

  Placement.length := SizeOf(Placement);
  R := @Placement.rcNormalPosition;
  GetWindowPlacement(Self.Handle, @Placement);
  if Monitor.Primary then
  begin
    ExtraOptions.Values['Top'] := IntToStr(R^.Top + Monitor.WorkareaRect.Top);
    ExtraOptions.Values['Left'] := IntToStr(R^.Left + Monitor.WorkareaRect.Left);
  end else
  begin
    ExtraOptions.Values['Top'] := IntToStr(R^.Top);
    ExtraOptions.Values['Left'] := IntToStr(R^.Left);
  end;
  ExtraOptions.Values['Width'] := IntToStr(R^.Right - R^.Left);
  ExtraOptions.Values['Height'] := IntToStr(R^.Bottom - R^.Top);

  ExtraOptions.Values['WindowState'] := IntToStr(Ord(WindowState));

  (* Columns *)
  for i := 0 to ListView.Columns.Count -1 do
    ExtraOptions.Values['Column' + IntToStr(ListView.Column[i].Tag)] := IntToStr(ListView.Column[i].Width);
end;

//保存されているウィンドウの位置・状態を復元する
procedure TMainWnd.SpTBXCustomizerLoad(Sender: TObject;
  ExtraOptions: TStringList);
var
  Left,Top: Integer;
  Width,Height: Integer;
  S: string;
  i: integer;
begin
  Left := StrToInt(ExtraOptions.Values['Left']);
  Top  := StrToInt(ExtraOptions.Values['Top']);

  Width := StrToIntDef(ExtraOptions.Values['Width'] , -1);
  if Width <= 0 then
    Width := 425;
  Height := StrToIntDef(ExtraOptions.Values['Height'] , -1);
  if Height <= 0 then
    Height := 435;

  SetBounds(Left, Top, Width, Height);

  S := ExtraOptions.Values['WindowState'];
  if Length(S) > 0 then
    WindowState := TWindowState(StrToInt(S));

  (* Columns *)
  ListView.Items.BeginUpdate;
  for i := 0 to ListView.Columns.Count -1 do
    ListView.Column[i].Width := StrToIntDef(ExtraOptions.Values['Column' + IntToStr(ListView.Column[i].Tag)], ListView.Column[i].Width);
  ListView.Items.EndUpdate;
end;

//カスタマイザーを起動
procedure TMainWnd.ActionCustomizeExecute(Sender: TObject);
begin
  SpTBXCustomizer.Show;
end;

//メニューバー表示切替
procedure TMainWnd.ActionToggleMenuBarExecute(Sender: TObject);
var
  width,height: integer;
begin
  width  := Self.Width - DockLeft.Width - DockLeft2.Width - DockRight.Width - DockRight2.Width;
  height := Self.Height - DockBottom.Height - DockTop.Height;
  if Self.Visible then
  begin
    Config.optShowToolbarMainMenu := not Config.optShowToolbarMainMenu;
    Config.Modified := True;
  end;
  ToolbarMainMenu.Visible := Config.optShowToolbarMainMenu;
  ActionToggleMenuBar.Checked := Config.optShowToolbarMainMenu;

  if (Self.WindowState = wsNormal) and (width > 0) and (height > 0) then
  begin
    width  := width + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width;
    height := height + DockBottom.Height + DockTop.Height;
    if (Self.Width <> width) or (Self.height <> height ) then
    begin
      SetBounds(Self.Left, Self.Top, width, height);
      SearchBarComboBox.Width := SearchBarComboBox.Width -1;
      TimerSetSearchBar.Enabled := true;
    end else
    begin
      SetBounds(Self.Left, Self.Top, width, height);
    end;
  end;
end;

//ツールバー表示切替
procedure TMainWnd.ActionToggleToolBarExecute(Sender: TObject);
var
  width,height: integer;
begin
  width  := Self.Width - DockLeft.Width - DockLeft2.Width - DockRight.Width - DockRight2.Width;
  height := Self.Height - DockBottom.Height - DockTop.Height;
  if Self.Visible then
  begin
    Config.optShowToolBarToolBar := not Config.optShowToolBarToolBar;
    Config.Modified := True;
  end;
  ToolBarToolBar.Visible := Config.optShowToolBarToolBar;
  ActionToggleToolBar.Checked := Config.optShowToolBarToolBar;

  if (Self.WindowState = wsNormal) and (width > 0) and (height > 0) then
  begin
    width  := width + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width;
    height := height + DockBottom.Height + DockTop.Height;
    if (Self.Width <> width) or (Self.height <> height ) then
    begin
      SetBounds(Self.Left, Self.Top, width, height);
      SearchBarComboBox.Width := SearchBarComboBox.Width -1;
      TimerSetSearchBar.Enabled := true;
    end else
    begin
      SetBounds(Self.Left, Self.Top, width, height);
    end;
  end;
end;

//ツールバー表示切替時の処理(カスタマイズからの変更用)
procedure TMainWnd.ToolBarToolBarVisibleChanged(Sender: TObject);
var
  width,height: integer;
begin
  width  := Self.Width - DockLeft.Width - DockLeft2.Width - DockRight.Width - DockRight2.Width;
  height := Self.Height - DockBottom.Height - DockTop.Height;
  if Self.Visible then
  begin
    Config.optShowToolBarToolBar := ToolBarToolBar.Visible;
    Config.Modified := True;
    ActionToggleToolBar.Checked := ToolBarToolBar.Visible;
  end;

  if (Self.WindowState = wsNormal) and (width > 0) and (height > 0) then
  begin
    width  := width + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width;
    height := height + DockBottom.Height + DockTop.Height;
    if (Self.Width <> width) or (Self.height <> height ) then
    begin
      SetBounds(Self.Left, Self.Top, width, height);
      SearchBarComboBox.Width := SearchBarComboBox.Width -1;
      TimerSetSearchBar.Enabled := true;
    end else
    begin
      SetBounds(Self.Left, Self.Top, width, height);
    end;
  end;
end;

//ビデオタイトルバー表示切替
procedure TMainWnd.ActionToggleTitleBarExecute(Sender: TObject);
var
  width,height: integer;
begin
  width  := Self.Width - DockLeft.Width - DockLeft2.Width - DockRight.Width - DockRight2.Width;
  height := Self.Height - DockBottom.Height - DockTop.Height;
  if Self.Visible then
  begin
    Config.optShowToolbarTitleBar := not Config.optShowToolbarTitleBar;
    Config.Modified := True;
  end;
  ToolbarTitleBar.Visible := Config.optShowToolbarTitleBar;
  ActionToggleTitleBar.Checked := Config.optShowToolbarTitleBar;

  if (Self.WindowState = wsNormal) and (width > 0) and (height > 0) then
  begin
    width  := width + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width;
    height := height + DockBottom.Height + DockTop.Height;
    if (Self.Width <> width) or (Self.height <> height ) then
    begin
      SetBounds(Self.Left, Self.Top, width, height);
      SearchBarComboBox.Width := SearchBarComboBox.Width -1;
      TimerSetSearchBar.Enabled := true;
    end else
    begin
      SetBounds(Self.Left, Self.Top, width, height);
    end;
  end;
end;

//ビデオタイトルバー表示切替時の処理(カスタマイズからの変更用)
procedure TMainWnd.ToolbarTitleBarVisibleChanged(Sender: TObject);
var
  width,height: integer;
begin
  width  := Self.Width - DockLeft.Width - DockLeft2.Width - DockRight.Width - DockRight2.Width;
  height := Self.Height - DockBottom.Height - DockTop.Height;
  if Self.Visible then
  begin
    Config.optShowToolbarTitleBar := ToolbarTitleBar.Visible;
    Config.Modified := True;
    ActionToggleTitleBar.Checked := ToolbarTitleBar.Visible;
  end;

  if (Self.WindowState = wsNormal) and (width > 0) and (height > 0) then
  begin
    width  := width + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width;
    height := height + DockBottom.Height + DockTop.Height;
    if (Self.Width <> width) or (Self.height <> height ) then
    begin
      SetBounds(Self.Left, Self.Top, width, height);
      SearchBarComboBox.Width := SearchBarComboBox.Width -1;
      TimerSetSearchBar.Enabled := true;
    end else
    begin
      SetBounds(Self.Left, Self.Top, width, height);
    end;
  end;
end;

//ツールバーを固定する
procedure TMainWnd.ActionToolBarFixedExecute(Sender: TObject);
begin
  if Self.Visible then
  begin
    Config.optToolBarFixed := not Config.optToolBarFixed;
    Config.Modified := True;
  end;
  ActionToolBarFixed.Checked := Config.optToolBarFixed;
  DockTop.AllowDrag := not Config.optToolBarFixed;
  DockBottom.AllowDrag := not Config.optToolBarFixed;
  DockLeft.AllowDrag := not Config.optToolBarFixed;
  DockLeft2.AllowDrag := not Config.optToolBarFixed;
  DockRight.AllowDrag := not Config.optToolBarFixed;
  DockRight2.AllowDrag := not Config.optToolBarFixed;
end;

//ログパネルの表示切替
procedure TMainWnd.ActionToggleLogPanelExecute(Sender: TObject);
var
  width,height: integer;
begin
  width  := Self.Width - DockLeft.Width - DockLeft2.Width - DockRight.Width - DockRight2.Width;
  height := Self.Height - DockBottom.Height - DockTop.Height;
  if Self.Visible then
  begin
    Config.optShowLogPanel := not Config.optShowLogPanel;
    Config.Modified := True;
  end;
  SpTBXDockablePanelLog.Visible := Config.optShowLogPanel;
  ActionToggleLogPanel.Checked := Config.optShowLogPanel;

  if (Self.WindowState = wsNormal) and (width > 0) and (height > 0) then
  begin
    width  := width + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width;
    height := height + DockBottom.Height + DockTop.Height;
    if (Self.Width <> width) or (Self.height <> height ) then
    begin
      SetBounds(Self.Left, Self.Top, width, height);
      SearchBarComboBox.Width := SearchBarComboBox.Width -1;
      TimerSetSearchBar.Enabled := true;
    end else
    begin
      SetBounds(Self.Left, Self.Top, width, height);
    end;
  end;
end;

//ログパネルを閉じるボタンから閉じたとき用
procedure TMainWnd.SpTBXDockablePanelLogCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  ActionToggleLogPanel.Execute;
end;

//ビデオ情報パネルの表示切替
procedure TMainWnd.ActionToggleVideoInfoPanelExecute(Sender: TObject);
var
  width,height: integer;
begin
  width  := Self.Width - DockLeft.Width - DockLeft2.Width - DockRight.Width - DockRight2.Width;
  height := Self.Height - DockBottom.Height - DockTop.Height;
  if Self.Visible then
  begin
    Config.optShowVideoInfoPanel := not Config.optShowVideoInfoPanel;
    Config.Modified := True;
  end;
  SpTBXDockablePanelVideoInfo.Visible := Config.optShowVideoInfoPanel;
  ActionToggleVideoInfoPanel.Checked := Config.optShowVideoInfoPanel;

  if (Self.WindowState = wsNormal) and (width > 0) and (height > 0) then
  begin
    width  := width + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width;
    height := height + DockBottom.Height + DockTop.Height;
    if (Self.Width <> width) or (Self.height <> height ) then
    begin
      SetBounds(Self.Left, Self.Top, width, height);
      SearchBarComboBox.Width := SearchBarComboBox.Width -1;
      TimerSetSearchBar.Enabled := true;
    end else
    begin
      SetBounds(Self.Left, Self.Top, width, height);
    end;
  end;
end;

//ビデオ情報パネルを閉じるボタンから閉じたとき用
procedure TMainWnd.SpTBXDockablePanelVideoInfoCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  ActionToggleVideoInfoPanel.Execute;
end;

//スプリッターの表示切替
procedure TMainWnd.ActionToggleSplitterExecute(Sender: TObject);
begin
  if Self.Visible then
  begin
    Config.optShowSplitter := not Config.optShowSplitter;
    Config.Modified := True;
  end;
  if Config.optShowSplitter then
  begin
    SpTBXSplitterLeft.Visible := True;
    SpTBXSplitterLeft.Width := 3;
    SpTBXSplitterRight.Visible := True;
    SpTBXSplitterRight.Width := 3;
  end else
  begin
    SpTBXSplitterLeft.Visible := false;
    SpTBXSplitterLeft.Width := 0;
    SpTBXSplitterRight.Visible := false;
    SpTBXSplitterRight.Width := 0;
  end;
  ActionToggleSplitter.Checked := Config.optShowSplitter;
end;

//関連ビデオパネルの表示切替
procedure TMainWnd.ActionToggleVideoRelatedPanelExecute(Sender: TObject);
var
  width,height: integer;
begin
  width  := Self.Width - DockLeft.Width - DockLeft2.Width - DockRight.Width - DockRight2.Width;
  height := Self.Height - DockBottom.Height - DockTop.Height;
  if Self.Visible then
  begin
    Config.optShowVideoRelatedPanel := not Config.optShowVideoRelatedPanel;
    Config.Modified := True;
  end;
  SpTBXDockablePanelVideoRelated.Visible := Config.optShowVideoRelatedPanel;
  ActionToggleVideoRelatedPanel.Checked := Config.optShowVideoRelatedPanel;

  if (Self.WindowState = wsNormal) and (width > 0) and (height > 0) then
  begin
    width  := width + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width;
    height := height + DockBottom.Height + DockTop.Height;
    if (Self.Width <> width) or (Self.height <> height ) then
    begin
      SetBounds(Self.Left, Self.Top, width, height);
      SearchBarComboBox.Width := SearchBarComboBox.Width -1;
      TimerSetSearchBar.Enabled := true;
    end else
    begin
      SetBounds(Self.Left, Self.Top, width, height);
    end;
  end;
end;

//関連ビデオパネルを閉じるボタンから閉じたとき用
procedure TMainWnd.SpTBXDockablePanelVideoRelatedCloseQuery(
  Sender: TObject; var CanClose: Boolean);
begin
  ActionToggleVideoRelatedPanel.Execute;
end;

//検索パネルの表示切替
procedure TMainWnd.ActionToggleSearchPanelExecute(Sender: TObject);
var
  width,height: integer;
begin
  width  := Self.Width - DockLeft.Width - DockLeft2.Width - DockRight.Width - DockRight2.Width;
  height := Self.Height - DockBottom.Height - DockTop.Height;
  if Self.Visible then
  begin
    Config.optShowSearchPanel := not Config.optShowSearchPanel;
    Config.Modified := True;
  end;
  SpTBXDockablePanelSearch.Visible := Config.optShowSearchPanel;
  ActionToggleSearchPanel.Checked := Config.optShowSearchPanel;

  if (Self.WindowState = wsNormal) and (width > 0) and (height > 0) then
  begin
    width  := width + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width;
    height := height + DockBottom.Height + DockTop.Height;
    if (Self.Width <> width) or (Self.height <> height ) then
    begin
      SetBounds(Self.Left, Self.Top, width, height);
      SearchBarComboBox.Width := SearchBarComboBox.Width -1;
      TimerSetSearchBar.Enabled := true;
    end else
    begin
      SetBounds(Self.Left, Self.Top, width, height);
    end;
  end;
end;

(*
//ビデオ情報をログに表示
procedure TMainWnd.ShowVideoData;
begin
  Log(VideoData.video_id);
  Log(VideoData.dl_video_id);
  Log(VideoData.comment_count);
  Log(VideoData.favorited_count);

  Log(VideoData.author);
  Log(VideoData.author_link);
  Log(VideoData.video_title);
  Log(VideoData.rating_avg);
  Log(VideoData.rating);
  Log(VideoData.rationg_count);
  Log(VideoData.tags);
  Log(VideoData.description);
  Log(VideoData.update_time);
  Log(VideoData.view_count);
  Log(VideoData.upload_time);
  Log(VideoData.playtime_seconds);
  Log(VideoData.playtime);
  Log(VideoData.recording_date);
  Log(VideoData.recording_location);
  Log(VideoData.recording_country);
  Log(VideoData.thumbnail_url1);
  Log(VideoData.thumbnail_url2);
  Log(VideoData.thumbnail_url3);
  Log(VideoData.channnel);

  for i := 0 to Length(VideoData.CommentList) -1 do
  begin
    with VideoData.CommentList[i] do
    begin
      Log(number);
      Log(author);
      Log(author_link);
      Log(text);
      Log(time);
    end;
  end;

  for i := 0 to Length(VideoData.RelatedList) -1 do
  begin
    with VideoData.RelatedList[i] do
    begin
      Log(thumbnail_url1);
      Log(thumbnail_url2);
      Log(thumbnail_url3);
      Log(video_id);
      Log(video_title);
      Log(playtime);
      Log(author);
      Log(author_link);
      Log(view_count);
    end;
  end;

  for i:= 0 to SearchList.Count -1 do
  begin
    with TSearchData(SearchList.Items[i]) do
    begin
      Log(author);
      Log(author_link);
      Log(video_id);
      Log(video_title);
      Log(playtime_seconds);
      Log(playtime);
      Log(rating_avg);
      Log(rating);
      Log(rationg_count);
      Log(description);
      Log(view_count);
      Log(upload_unixtime);
      Log(upload_time);
      Log(comment_count);
      Log(tags);
      Log(thumbnail_url1);
      Log(thumbnail_url2);
      Log(thumbnail_url3);
    end;
  end;

end;
*)

//ビデオ情報をクリア
procedure TMainWnd.ClearVideoData;
begin
  ActionOpenByBrowser.Enabled := false;
  ActionOpenPrimarySite.Enabled := false;
  ActionCopyTitle.Enabled := false;
  ActionCopyTU.Enabled := false;
  ActionCopyURL.Enabled := false;
  ActionClearVideoPanel.Enabled := false;
  ActionAddFavorite.Enabled := false;  
  ToolButtonAddFavorite.Enabled := false;
  ToolButtonAddFavorite.Checked := false;
  ActionRefresh.Enabled := false;

  ActionSave.Enabled := false;
  ActionAddTag.Enabled := false;
  ActionAddAuthor.Enabled := false;

  tmpURI := '';
  LabelURL.Caption := '【title】';
  LabelURL.Hint := '';
  Self.Caption := APPLICATION_NAME;
  Application.Title := Self.Caption;
  if SpTBXTitleBar.Active then
    SpTBXTitleBar.Caption := Self.Caption;

  VideoData.video_id := '';
  VideoData.video_ext := '';
  VideoData.dl_video_id := '';
  VideoData.comment_count := '';
  VideoData.favorited_count := '';

  VideoData.author := '';
  VideoData.author_link := '';
  VideoData.video_title := '';
  VideoData.rating_avg := '';
  VideoData.rating := '';
  VideoData.rationg_count := '';
  VideoData.tags := '';
  VideoData.description := '';
  VideoData.update_time := '';
  VideoData.view_count := '';
  VideoData.upload_time := '';
  VideoData.playtime_seconds := '';
  VideoData.playtime := '';
  VideoData.recording_date := '';
  VideoData.recording_location := '';
  VideoData.recording_country := '';
  VideoData.thumbnail_url1 := '';
  VideoData.thumbnail_url2 := '';
  VideoData.thumbnail_url3 := '';
  VideoData.channnel := '';
  SetLength(VideoData.CommentList, 0);
  SetLength(VideoData.RelatedList, 0);
  VideoData.video_type := 0;
end;

//検索結果をクリア
procedure TMainWnd.ClearSearchList;
var
  i: integer;
begin
  ListView.List := nil;
  for i := 0 to SearchList.Count -1 do
  begin
    TSearchData(SearchList.Items[i]).Free;
  end;
  SearchList.Clear;
  SearchedEnd := false;
end;

//ニコニコ市場のデータをクリア
procedure TMainWnd.ClearAsinList;
var
  i: integer;
begin
  for i := 0 to AsinList.Count -1 do
  begin
    TAsinData(AsinList.Items[i]).Free;
  end;
  AsinList.Clear;
end;

//ニコニコ市場ランキングのデータをクリア
procedure TMainWnd.ClearAsinRankList;
var
  i: integer;
begin
  for i := 0 to AsinRankList.Count -1 do
  begin
    TAsinData(AsinRankList.Items[i]).Free;
  end;
  AsinRankList.Clear;
end;

//リストをクリック
procedure TMainWnd.ListViewClick(Sender: TObject);
var
  item: TListItem;
  SearchData: TSearchData;
  s: Cardinal;
begin
  if not Config.optListClickOption then
    exit;

  if GetKeyState(VK_CONTROL) < 0 then
    exit;
  if (GetKeyState(VK_SHIFT) < 0) then //Shiftで複数選択
    exit;

  if ListView.SelCount > 1 then
    item := ListView.ItemFocused
  else
    item := ListView.Selected;
  if item = nil then
    exit;

  SearchData := TSearchData(item.Data);
  ClearVideoData;
  Clear(WebBrowser);
  Clear(WebBrowser2);
  Clear(WebBrowser3);
  s := GetTickCount;
  while not DocComplete do
  begin
    Application.ProcessMessages;
    sleep(1);
    if (GetTickCount > s + 5000) then
      break;
  end;
  case SearchType of
    0,10,20:   SetURI(YOUTUBE_GET_WATCH_URI + SearchData.video_id + Config.optMP4Format);
    1,2,3,4,6,8,9: SetURI(NICOVIDEO_GET_URI + SearchData.video_id);
  end;
end;

//リストをダブルクリック
procedure TMainWnd.ListViewDblClick(Sender: TObject);
var
  item: TListItem;
  SearchData: TSearchData;
  s: Cardinal;
begin
  if GetKeyState(VK_CONTROL) < 0 then
    exit;
  if (GetKeyState(VK_SHIFT) < 0) then //Shiftで複数選択
    exit;

  if ListView.SelCount > 1 then
    item := ListView.ItemFocused
  else
    item := ListView.Selected;
  if item = nil then
    exit;

  SearchData := TSearchData(item.Data);
  ClearVideoData;
  Clear(WebBrowser);
  Clear(WebBrowser2);
  Clear(WebBrowser3);
  s := GetTickCount;
  while not DocComplete do
  begin
    Application.ProcessMessages;
    sleep(1);
    if (GetTickCount > s + 5000) then
      break;
  end;
  case SearchType of
    0,10,20:   SetURI(YOUTUBE_GET_WATCH_URI + SearchData.video_id + Config.optMP4Format);
    1,2,3,4,6,8,9: SetURI(NICOVIDEO_GET_URI + SearchData.video_id);
  end;
end;

//リストの描画
procedure TMainWnd.ListViewCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);

begin
  Sender.Canvas.Brush.Style := bsClear; //下線が残るのを避ける

  if config.optListViewUseExtraBackColor then
  begin
    if Item.Index and 1 = 0 then
      Sender.Canvas.Brush.Color := config.clListViewOddBackColor
    else
      Sender.Canvas.Brush.Color := config.clListViewEvenBackColor;
  end else
    Sender.Canvas.Brush.Color := ListView.Color;


  if TSearchData(Item.Data).liststate <> 0 then
  begin
    Sender.Canvas.Font.Color := clRed;
  end;

  if CompareStr(tmpID, TSearchData(Item.Data).video_id) = 0 then
  begin
    Sender.Canvas.Font.Style := Sender.Canvas.Font.Style + [fsBold];
  end;

  if (cdsHot in state) then
  begin
    Sender.Canvas.Font.Style := Sender.Canvas.Font.Style + [fsUnderline];
    Sender.Canvas.Font.Color := clHotLight;
  end;
end;

//リストでキーを押した際の動作
procedure TMainWnd.ListViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
  VK_RETURN:
    begin
      ListViewClick(Sender);
    end;
  VK_APPS:
    begin
      if ListView.Selected <> nil then
        ListView.PopupMenu := ListPopupMenu;
    end;
  end;
end;

//リストでマウスを押した際の動作
procedure TMainWnd.ListViewMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ListView.Selected <> nil then
    ListView.PopupMenu := ListPopupMenu
  else
    ListView.PopupMenu := nil;
end;

//リストメニューポップアップ時の処理
procedure TMainWnd.ListPopupMenuPopup(Sender: TObject);
var
  item: TListItem;
begin
  item := ListView.Selected;
  if item = nil then
  begin
    ListPopupAddFavorite.Enabled := false;
    exit;
  end;
  ListViewSelectItem(ListView, item, true);
  ActionListAddTag.Enabled := (SearchType = 0) or (SearchType = 10) or (SearchType = 20);
  ActionListAddAuthor.Enabled := (SearchType = 0) or (SearchType = 10) or (SearchType = 20);

  ActionListPopupSave.Enabled := (ListView.SelCount = 1);
  ActionListPopupSave.Visible := ((Config.optDownloadOption = 2) and AnsiContainsStr(Config.optDownloaderOption, '$URL2'));
  ListPopupAddFavorite.Enabled := True;
  FavoriteMenuItemCreate(ListPopupAddFavorite, ListPopupAddFavoriteExecute);
end;

//リストポップメニューのポップアップ時の処理
procedure TMainWnd.ListViewSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
(*
var
  SearchData: TSearchData;
*)
begin
  if Selected then
  begin
    ListView.PopupMenu := ListPopupMenu;
    if ListView.SelCount > 1 then
    begin
      ActionListOpenURL.Enabled := false;
      ActionListAddTag.Enabled  := false;
    end else
    begin 
      ActionListOpenURL.Enabled := true;
      ActionListAddTag.Enabled  := true;
    end;
    (*
    SearchData := TSearchData(Item.Data);
    *)
  end;
end;

//URLをコピー(リストから)
procedure TMainWnd.ActionListPopupCopyURLExecute(Sender: TObject);
var
  item: TListItem;
  SearchData: TSearchData;
  tmpstring: String;
begin
  item := ListView.Selected;
  if item = nil then
    exit;
  if ListView.SelCount > 1 then
  begin
    SearchData := nil;
    tmpstring := '';
    while (item <> nil) and (item.Data <> SearchData) do
    begin
      SearchData := TSearchData(item.Data);
      with SearchData do
      begin
        if SearchData <> nil then
        begin
          case SearchType of
            0,10,20:   tmpstring := tmpstring + YOUTUBE_GET_WATCH_URI + SearchData.video_id + Config.optMP4Format + #13#10;
            1,2,3,4,6,8,9: tmpstring := tmpstring + NICOVIDEO_GET_URI + SearchData.video_id + #13#10;
          end;
        end;
      end;
      item := ListView.GetNextItem(item, sdBelow, [isSelected]);
    end;
    Clipboard.AsText := TrimRight(tmpstring);
  end else
  begin
    SearchData := TSearchData(item.Data);
    if SearchData = nil then
      exit;
    case SearchType of
      0,10,20:   Clipboard.AsText := YOUTUBE_GET_WATCH_URI + SearchData.video_id + Config.optMP4Format;
      1,2,3,4,6,8,9: Clipboard.AsText := NICOVIDEO_GET_URI + SearchData.video_id;
    end;
  end;
end;

//タイトルとURLをコピー(リストから)
procedure TMainWnd.ActionListPopupCopyTUExecute(Sender: TObject);
var
  item: TListItem;
  SearchData: TSearchData;
  tmpstring: String;
begin
  item := ListView.Selected;
  if item = nil then
    exit;
  if ListView.SelCount > 1 then
  begin
    SearchData := nil;
    tmpstring := '';
    while (item <> nil) and (item.Data <> SearchData) do
    begin
      SearchData := TSearchData(item.Data);
      with SearchData do
      begin
        if SearchData <> nil then
        begin
          case SearchType of
            0,10,20:   tmpstring := tmpstring + CustomStringReplace(SearchData.video_title,  '&#039;', '''') + #13#10 +
                                  YOUTUBE_GET_WATCH_URI + SearchData.video_id + Config.optMP4Format + #13#10;
            1,2,3,4,6,8,9: tmpstring := tmpstring + CustomStringReplace(SearchData.video_title,  '&#039;', '''') + #13#10 +
                                  NICOVIDEO_GET_URI + SearchData.video_id + #13#10;
          end;
        end;
      end;
      item := ListView.GetNextItem(item, sdBelow, [isSelected]);
    end;
    Clipboard.AsText := TrimRight(tmpstring);
  end else
  begin
    SearchData := TSearchData(item.Data);
    if SearchData = nil then
      exit;
    case SearchType of
      0,10,20:   Clipboard.AsText := CustomStringReplace(SearchData.video_title,  '&#039;', '''') + #13#10 +
                                   YOUTUBE_GET_WATCH_URI + SearchData.video_id + Config.optMP4Format;
      1,2,3,4,6,8,9: Clipboard.AsText := CustomStringReplace(SearchData.video_title,  '&#039;', '''') + #13#10 +
                                   NICOVIDEO_GET_URI + SearchData.video_id;
    end;
  end;
end;

//ビデオを開く(リストから)
procedure TMainWnd.ActionListOpenURLExecute(Sender: TObject);
var
  item: TListItem;
  SearchData: TSearchData;
  URI: String;
begin
  item := ListView.Selected;
  if item = nil then
    exit;
  SearchData := TSearchData(item.Data);
  if SearchData = nil then
    exit;
  if Length(SearchData.video_id) = 0 then
    exit;
  case SearchType of
    0,10,20:   URI := YOUTUBE_GET_WATCH_URI + SearchData.video_id + Config.optMP4Format;
    1,2,3,4,6,8,9: URI := NICOVIDEO_GET_URI + SearchData.video_id;
  end;
  SetURIwithClear(URI);
end;

//検索
procedure TMainWnd.ActionSearchBarSearchExecute(Sender: TObject);
var
  LabelWord: String;
  SearchWord: String;
  URI: String;
  i: integer;
  search_sort: String;
begin
  SearchWord := SearchBarComboBox.Text;
  if Length(SearchWord) <= 0 then
    exit;

  if AnsiStartsText('user:', SearchWord) and not (Config.optSearchTarget in [0,1]) then
  begin
    Self.Tag := 0;
    ActionToggleSearchTargetExecute(Self);
  end;

  if (Config.optSearchTarget in [2..11,20..29]) and
     ((Length(Config.optNicoVideoAccount) = 0) or (Length(Config.optNicoVideoPassword) = 0)) then
  begin
    ShowMessage('ニコニコ動画の視聴にはアカウントが必要です。' + #13#10 + 'アカウント設定は、設定＞nicovideoでしてください。');
    exit;
  end;

  case Config.optSearchTarget of
    0:  LabelWord := 'YouTube(標準検索) ';
    1:  LabelWord := 'YouTube(関連検索) ';
    100: LabelWord := 'YouTube(カスタム検索) ';
    2:  LabelWord := 'ニコニコ動画(投稿日時が新しい順) ';
    3:  LabelWord := 'ニコニコ動画(投稿日時が古い順) ';
    4:  LabelWord := 'ニコニコ動画(再生が多い順) ';
    5:  LabelWord := 'ニコニコ動画(再生が少ない順) ';
    6:  LabelWord := 'ニコニコ動画(コメントが新しい順) ';
    7:  LabelWord := 'ニコニコ動画(コメントが古い順)';
    8:  LabelWord := 'ニコニコ動画(コメントが多い順)';
    9:  LabelWord := 'ニコニコ動画(コメントが少ない順) ';
    10: LabelWord := 'ニコニコ動画(マイリスト登録数が多い順)';
    11: LabelWord := 'ニコニコ動画(マイリスト登録数が少ない順) ';
    20: LabelWord := 'ニコニコ動画(タグ検索-投稿日時が新しい順) ';
    21: LabelWord := 'ニコニコ動画(タグ検索-投稿日時が古い順) ';
    22: LabelWord := 'ニコニコ動画(タグ検索-再生が多い順) ';
    23: LabelWord := 'ニコニコ動画(タグ検索-再生が少ない順) ';
    24: LabelWord := 'ニコニコ動画(タグ検索-コメントが新しい順) ';
    25: LabelWord := 'ニコニコ動画(タグ検索-コメントが古い順) ';
    26: LabelWord := 'ニコニコ動画(タグ検索-コメントが多い順) ';
    27: LabelWord := 'ニコニコ動画(タグ検索-コメントが少ない順) ';
    28: LabelWord := 'ニコニコ動画(タグ検索-マイリスト登録数が多い順) ';
    29: LabelWord := 'ニコニコ動画(タグ検索-マイリスト登録数が少ない順) ';
  end;
  if Config.optSearchTarget = 100 then
  begin
    case Config.optSearchYouTubeSort of
      0:
      begin
        LabelWord := LabelWord + '[関連度]';
        search_sort := 'relevance';
      end;
      1:
      begin
        LabelWord := LabelWord + '[追加日]';
        search_sort := 'published';
      end;
      2:
      begin
        LabelWord := LabelWord + '[再生回数]';
        search_sort := 'viewCount';
      end;
      3:
      begin
        LabelWord := LabelWord + '[評価]';
        search_sort := 'rating';
      end;
    end;
    case Config.optSearchYouTubeCategory of
      0:  LabelWord := LabelWord + '[すべて] ';
      2:  LabelWord := LabelWord + '[自動車と乗り物] ';
      23: LabelWord := LabelWord + '[コメディー] ';
      24: LabelWord := LabelWord + '[エンターテイメント] ';
      1:  LabelWord := LabelWord + '[映画とアニメ] ';
      20: LabelWord := LabelWord + '[ゲームとガジェット] ';
      26: LabelWord := LabelWord + '[ハウツー DIY] ';
      10: LabelWord := LabelWord + '[音楽] ';
      25: LabelWord := LabelWord + '[ニュースと政治] ';
      22: LabelWord := LabelWord + '[ブログと人] ';
      15: LabelWord := LabelWord + '[ペットと動物] ';
      17: LabelWord := LabelWord + '[スポーツ] ';
      19: LabelWord := LabelWord + '[旅行と訪問スポット] ';
    end;
  end
  else if Config.optSearchTarget in [0, 1] then
    search_sort := 'relevance';

  ActionSearchBarSearch.Enabled := false;
  ActionSearchBarSearch2.Enabled := false;
  ActionSearchBarAdd100.Enabled := false;

  MenuSearchNicoVideo.Enabled := false;
  MenuSearchYouTube.Enabled := false;

  PanelBrowser.Visible := false;
  PanelListView.Visible := true;
  ActionSearchBarToggleListView.Checked := false;
  ActionSearchBarToggleListView.Enabled := false;

  i := Config.grepSearchList.IndexOf(SearchWord); //同じものがあるか検索
  If i = -1 Then
  begin
    Config.grepSearchList.Insert(0, SearchWord);
  end else
  begin
    Config.grepSearchList.Move(i, 0);
  end;
  SearchBarComboBox.Items.Assign(Config.grepSearchList);
  SearchBarComboBox.Text := SearchWord;
  PanelSearchComboBox.Items.Assign(Config.grepSearchList);
  PanelSearchComboBox.Text := SearchWord;

  CustomStringReplace(SearchWord, '　', ' ');
  ClearSearchList;
  SearchPage := 1;
  tmpSearchWord := SearchWord;
  tmpLabelWord := LabelWord;
  if not ActionToggleSearchPanel.Checked then
    ActionToggleSearchPanel.Execute;

  tmpSearchURI := '';
  case Config.optSearchTarget of
    0,1,100: //YouTube(API)
      begin
        SearchType := 0;
        Log('検索開始 [%s]   [1-50]', [SearchWord]);
        SpTBXDockablePanelSearch.Caption := LabelWord + Format('[%s]   [1-50]   <取得中>', [SearchWord]);

        if Config.optSearchTarget = 100 then
        begin
          case Config.optSearchYouTubeCategory of
            2:  URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/Autos';
            23: URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/Comedy';
            24: URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/Entertainment';
            1:  URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/Film';
            20: URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/Games';
            26: URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/Howto';
            10: URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/Music';
            25: URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/News';
            22: URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/People';
            15: URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/Animals';
            17: URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/Sports';
            19: URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/Travel';
            else URI := YOUTUBE_GET_SEARCH_URI_FRONT;
          end;
        end
        else
          URI := YOUTUBE_GET_SEARCH_URI_FRONT;

        if AnsiStartsText('user:', SearchWord) then
        begin
          SearchWord := Copy(SearchWord, 6, high(integer));
          SearchWord := URLEncode(UTF8Encode(SearchWord));
          URI := URI + Format('?racy=include&author=%s&orderby=%s&start-index=1&max-results=50',
                              [SearchWord, search_sort]);
        end else
        begin
          SearchWord := URLEncode(UTF8Encode(SearchWord));
          URI := URI + Format('?racy=include&vq=%s&orderby=%s&start-index=1&max-results=50',
                              [SearchWord, search_sort]);
        end;

        Log('');
        procGet3 := AsyncManager.Get(URI, OnYouTubeSearch);
      end;
    2..11,20..29: //ニコニコ動画
      begin
        SearchType := 1;
        NicoVideoRetryCount := 0;
        Log('検索開始 [' + SearchWord + ']   [1-' + IntToStr(SearchPage*30) + ']');
        SpTBXDockablePanelSearch.Caption := LabelWord + '[' + SearchWord + ']   [1-' + IntToStr(SearchPage*30) + ']   <取得中>';
        SearchWord := URLEncode(UTF8Encode(SearchWord));
        case Config.optSearchTarget of
          2:  URI := NICOVIDEO_GET_SEARCH_URI + SearchWord + '?page=1&sort=f&order=d'; //投稿日時が新しい順
          3:  URI := NICOVIDEO_GET_SEARCH_URI + SearchWord + '?page=1&sort=f&order=a'; //投稿日時が古い順
          4:  URI := NICOVIDEO_GET_SEARCH_URI + SearchWord + '?page=1&sort=v&order=d'; //再生が多い順
          5:  URI := NICOVIDEO_GET_SEARCH_URI + SearchWord + '?page=1&sort=v&order=a'; //再生が少ない順
          6:  URI := NICOVIDEO_GET_SEARCH_URI + SearchWord + '?page=1&sort=n&order=d'; //コメントが新しい順
          7:  URI := NICOVIDEO_GET_SEARCH_URI + SearchWord + '?page=1&sort=n&order=a'; //コメントが古い順
          8:  URI := NICOVIDEO_GET_SEARCH_URI + SearchWord + '?page=1&sort=r&order=d'; //コメントが多い順
          9:  URI := NICOVIDEO_GET_SEARCH_URI + SearchWord + '?page=1&sort=r&order=a'; //コメントが少ない順 
          10: URI := NICOVIDEO_GET_SEARCH_URI + SearchWord + '?page=1&sort=m&order=d'; //マイリスト登録数が多い順
          11: URI := NICOVIDEO_GET_SEARCH_URI + SearchWord + '?page=1&sort=m&order=a'; //マイリスト登録数が少ない順
          20: URI := NICOVIDEO_GET_SEARCH_TAG_URI + SearchWord + '?page=1&sort=f&order=d'; //タグ検索-投稿日時が新しい順
          21: URI := NICOVIDEO_GET_SEARCH_TAG_URI + SearchWord + '?page=1&sort=f&order=a'; //タグ検索-投稿日時が古い順
          22: URI := NICOVIDEO_GET_SEARCH_TAG_URI + SearchWord + '?page=1&sort=v&order=d'; //タグ検索-再生が多い順
          23: URI := NICOVIDEO_GET_SEARCH_TAG_URI + SearchWord + '?page=1&sort=v&order=a'; //タグ検索-再生が少ない順
          24: URI := NICOVIDEO_GET_SEARCH_TAG_URI + SearchWord + '?page=1&sort=n&order=d'; //タグ検索-コメントが新しい順
          25: URI := NICOVIDEO_GET_SEARCH_TAG_URI + SearchWord + '?page=1&sort=n&order=a'; //タグ検索-コメントが古い順
          26: URI := NICOVIDEO_GET_SEARCH_TAG_URI + SearchWord + '?page=1&sort=r&order=d'; //タグ検索-コメントが多い順
          27: URI := NICOVIDEO_GET_SEARCH_TAG_URI + SearchWord + '?page=1&sort=r&order=a'; //タグ検索-コメントが少ない順   
          28: URI := NICOVIDEO_GET_SEARCH_TAG_URI + SearchWord + '?page=1&sort=m&order=d'; //タグ検索-マイリスト登録数が多い順
          29: URI := NICOVIDEO_GET_SEARCH_TAG_URI + SearchWord + '?page=1&sort=m&order=a'; //タグ検索-マイリスト登録数が少ない順
        end;
        Log('');
        procGet3 := AsyncManager.Get(URI, OnNicoVideoSearch, OnNicoVideoPreConnect);
      end;
  end;
  tmpSearchURI := URI;
end;

//追加検索
procedure TMainWnd.ActionSearchBarAdd100Execute(Sender: TObject);
var
  LabelWord: String;
  SearchWord: String;
  URI: String;
  StartIdx: Integer;
  search_sort: String;
begin
  if Length(tmpSearchWord) <= 0 then
    exit;

  SearchWord := tmpSearchWord;
  ActionSearchBarSearch.Enabled := false;
  ActionSearchBarSearch2.Enabled := false;
  ActionSearchBarAdd100.Enabled := false;

  MenuSearchNicoVideo.Enabled := false;
  MenuSearchYouTube.Enabled := false;

  PanelBrowser.Visible := false;
  PanelListView.Visible := true;
  ActionSearchBarToggleListView.Checked := false;
  ActionSearchBarToggleListView.Enabled := false;

  Inc(SearchPage);
  if not ActionToggleSearchPanel.Checked then
    ActionToggleSearchPanel.Execute;

  case Config.optSearchTarget of
    0:  LabelWord := 'YouTube(標準検索) ';
    1:  LabelWord := 'YouTube(関連検索) ';
    100: LabelWord := 'YouTube(カスタム検索) ';
    2:  LabelWord := 'ニコニコ動画(投稿日時が新しい順) ';
    3:  LabelWord := 'ニコニコ動画(投稿日時が古い順) ';
    4:  LabelWord := 'ニコニコ動画(再生が多い順) ';
    5:  LabelWord := 'ニコニコ動画(再生が少ない順) ';
    6:  LabelWord := 'ニコニコ動画(コメントが新しい順) ';
    7:  LabelWord := 'ニコニコ動画(コメントが古い順)';
    8:  LabelWord := 'ニコニコ動画(コメントが多い順)';
    9:  LabelWord := 'ニコニコ動画(コメントが少ない順) ';
    10: LabelWord := 'ニコニコ動画(マイリスト登録数が多い順)';
    11: LabelWord := 'ニコニコ動画(マイリスト登録数が少ない順) ';
    20: LabelWord := 'ニコニコ動画(タグ検索-投稿日時が新しい順) ';
    21: LabelWord := 'ニコニコ動画(タグ検索-投稿日時が古い順) ';
    22: LabelWord := 'ニコニコ動画(タグ検索-再生が多い順) ';
    23: LabelWord := 'ニコニコ動画(タグ検索-再生が少ない順) ';
    24: LabelWord := 'ニコニコ動画(タグ検索-コメントが新しい順) ';
    25: LabelWord := 'ニコニコ動画(タグ検索-コメントが古い順) ';
    26: LabelWord := 'ニコニコ動画(タグ検索-コメントが多い順) ';
    27: LabelWord := 'ニコニコ動画(タグ検索-コメントが少ない順) '; 
    28: LabelWord := 'ニコニコ動画(タグ検索-マイリスト登録数が多い順) ';
    29: LabelWord := 'ニコニコ動画(タグ検索-マイリスト登録数が少ない順) ';
  end;
  if Config.optSearchTarget = 100 then
  begin
    case Config.optSearchYouTubeSort of
      0:
      begin
        LabelWord := LabelWord + '[関連度]';
        search_sort := 'relevance';
      end;
      1:
      begin
        LabelWord := LabelWord + '[追加日]';
        search_sort := 'published';
      end;
      2:
      begin
        LabelWord := LabelWord + '[再生回数]';
        search_sort := 'viewCount';
      end;
      3:
      begin
        LabelWord := LabelWord + '[評価]';
        search_sort := 'rating';
      end;
    end;
    case Config.optSearchYouTubeCategory of
      0:  LabelWord := LabelWord + '[すべて] ';
      2:  LabelWord := LabelWord + '[自動車と乗り物] ';
      23: LabelWord := LabelWord + '[コメディー] ';
      24: LabelWord := LabelWord + '[エンターテイメント] ';
      1:  LabelWord := LabelWord + '[映画とアニメ] ';
      20: LabelWord := LabelWord + '[ゲームとガジェット] ';
      26: LabelWord := LabelWord + '[ハウツー DIY] ';
      10: LabelWord := LabelWord + '[音楽] ';
      25: LabelWord := LabelWord + '[ニュースと政治] ';
      22: LabelWord := LabelWord + '[ブログと人] ';
      15: LabelWord := LabelWord + '[ペットと動物] ';
      17: LabelWord := LabelWord + '[スポーツ] ';
      19: LabelWord := LabelWord + '[旅行と訪問スポット] ';
    end;
  end
  else if Config.optSearchTarget in [0, 1] then
    search_sort := 'relevance';
  tmpLabelWord := LabelWord;

  case SearchType of
    2: //ニコニコ動画(ランキング)
      begin
        NicoVideoRetryCount := 0;
        Log('ランキング取得開始');
        SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   [1-' + IntToStr(SearchPage*100) + ']   <取得中>';
        Log('');
        URI := tmpSearchURI + '/?page=' + IntToStr(SearchPage);
        procGet3 := AsyncManager.Get(URI, OnNicoVideoGetRanking, OnNicoVideoPreConnect);
        exit;
      end;
    3: //ニコニコ動画(新着投稿・コメント)
      begin
        NicoVideoRetryCount := 0;
        Log(SearchWord + '   [1-' + IntToStr(SearchPage*30) + '] 取得開始');
        SpTBXDockablePanelSearch.Caption := SearchWord +  '   [1-' + IntToStr(SearchPage*30) + ']   <取得中>';
        URI := tmpSearchURI + '?page=' + IntToStr(SearchPage);
        Log('');
        procGet3 := AsyncManager.Get(URI, OnNicoVideoSearch, OnNicoVideoPreConnect);
        exit;
      end;
  end;

  case Config.optSearchTarget of
    0,1,100: //YouTube
      begin
        SearchType := 0;
        StartIdx := ((SearchPage-1)*50) + 1;
        Log('');
        Log('検索開始 [%s]   [%d-%d]', [SearchWord, StartIdx, StartIdx + 50 - 1]);
        SpTBXDockablePanelSearch.Caption := LabelWord + Format('[%s]   [%d-%d]   <取得中>', [SearchWord, StartIdx, StartIdx + 49]);

        if Config.optSearchTarget = 100 then
        begin
          case Config.optSearchYouTubeCategory of
            2:  URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/Autos';
            23: URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/Comedy';
            24: URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/Entertainment';
            1:  URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/Film';
            20: URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/Games';
            26: URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/Howto';
            10: URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/Music';
            25: URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/News';
            22: URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/People';
            15: URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/Animals';
            17: URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/Sports';
            19: URI := YOUTUBE_GET_SEARCH_URI_FRONT + '/-/Travel';
            else URI := YOUTUBE_GET_SEARCH_URI_FRONT;
          end;
        end
        else
          URI := YOUTUBE_GET_SEARCH_URI_FRONT;

        if AnsiStartsText('user:', SearchWord) then
        begin
          SearchWord := Copy(SearchWord, 6, high(integer));
          SearchWord := URLEncode(UTF8Encode(SearchWord));
          URI := URI + Format('?racy=include&author=%s&orderby=%s&start-index=%d&max-results=50',
                              [SearchWord, search_sort, StartIdx]);
        end else
        begin
          SearchWord := URLEncode(UTF8Encode(SearchWord));
          URI := URI + Format('?racy=include&vq=%s&orderby=%s&start-index=%d&max-results=50',
                              [SearchWord, search_sort, StartIdx]);
        end;
        procGet3 := AsyncManager.Get(URI, OnYouTubeSearch);
        tmpSearchURI := URI;
      end;
    2..11,20..29: //ニコニコ動画
      begin
        SearchType := 1;
        NicoVideoRetryCount := 0;

        Log('検索開始 [' + SearchWord + ']   [1-' + IntToStr(SearchPage*30) + ']');
        SpTBXDockablePanelSearch.Caption := LabelWord + '[' + SearchWord + ']   [1-' + IntToStr(SearchPage*30) + ']   <取得中>';

        SearchWord := URLEncode(UTF8Encode(SearchWord));
        case Config.optSearchTarget of
          2:  URI := NICOVIDEO_GET_SEARCH_URI + SearchWord + '?page=' + IntToStr(SearchPage) + '&sort=f&order=d'; //投稿が新しい順
          3:  URI := NICOVIDEO_GET_SEARCH_URI + SearchWord + '?page=' + IntToStr(SearchPage) + '&sort=f&order=a'; //投稿が古い順
          4:  URI := NICOVIDEO_GET_SEARCH_URI + SearchWord + '?page=' + IntToStr(SearchPage) + '&sort=v&order=d'; //再生が多い順
          5:  URI := NICOVIDEO_GET_SEARCH_URI + SearchWord + '?page=' + IntToStr(SearchPage) + '&sort=v&order=a'; //再生が少ない順
          6:  URI := NICOVIDEO_GET_SEARCH_URI + SearchWord + '?page=' + IntToStr(SearchPage) + '&sort=n&order=d'; //コメントが新しい順
          7:  URI := NICOVIDEO_GET_SEARCH_URI + SearchWord + '?page=' + IntToStr(SearchPage) + '&sort=n&order=a'; //コメントが古い順
          8:  URI := NICOVIDEO_GET_SEARCH_URI + SearchWord + '?page=' + IntToStr(SearchPage) + '&sort=r&order=d'; //コメントが多い順
          9:  URI := NICOVIDEO_GET_SEARCH_URI + SearchWord + '?page=' + IntToStr(SearchPage) + '&sort=r&order=a'; //コメントが少ない順
          10: URI := NICOVIDEO_GET_SEARCH_URI + SearchWord + '?page=' + IntToStr(SearchPage) + '&sort=m&order=d'; //マイリスト登録数が多い順
          11: URI := NICOVIDEO_GET_SEARCH_URI + SearchWord + '?page=' + IntToStr(SearchPage) + '&sort=m&order=a'; //マイリスト登録数が少ない順
          20: URI := NICOVIDEO_GET_SEARCH_TAG_URI + SearchWord + '?page=' + IntToStr(SearchPage) + '&sort=f&order=d'; //タグ検索-投稿日時が新しい順
          21: URI := NICOVIDEO_GET_SEARCH_TAG_URI + SearchWord + '?page=' + IntToStr(SearchPage) + '&sort=f&order=a'; //タグ検索-投稿日時が古い順
          22: URI := NICOVIDEO_GET_SEARCH_TAG_URI + SearchWord + '?page=' + IntToStr(SearchPage) + '&sort=v&order=d'; //タグ検索-再生が多い順
          23: URI := NICOVIDEO_GET_SEARCH_TAG_URI + SearchWord + '?page=' + IntToStr(SearchPage) + '&sort=v&order=a'; //タグ検索-再生が少ない順
          24: URI := NICOVIDEO_GET_SEARCH_TAG_URI + SearchWord + '?page=' + IntToStr(SearchPage) + '&sort=n&order=d'; //タグ検索-コメントが新しい順
          25: URI := NICOVIDEO_GET_SEARCH_TAG_URI + SearchWord + '?page=' + IntToStr(SearchPage) + '&sort=n&order=a'; //タグ検索-コメントが古い順
          26: URI := NICOVIDEO_GET_SEARCH_TAG_URI + SearchWord + '?page=' + IntToStr(SearchPage) + '&sort=r&order=d'; //タグ検索-コメントが多い順
          27: URI := NICOVIDEO_GET_SEARCH_TAG_URI + SearchWord + '?page=' + IntToStr(SearchPage) + '&sort=r&order=a'; //タグ検索-コメントが少ない順 
          28: URI := NICOVIDEO_GET_SEARCH_TAG_URI + SearchWord + '?page=' + IntToStr(SearchPage) + '&sort=m&order=d'; //タグ検索-マイリスト登録数が多い順
          29: URI := NICOVIDEO_GET_SEARCH_TAG_URI + SearchWord + '?page=' + IntToStr(SearchPage) + '&sort=m&order=a'; //タグ検索-マイリスト登録数が少ない順
        end;
        Log('');
        procGet3 := AsyncManager.Get(URI, OnNicoVideoSearch, OnNicoVideoPreConnect);
        tmpSearchURI := URI;
      end;
  end;
end;

//検索結果を処理する
procedure TMainWnd.OnNicoVideoSearch(sender: TAsyncReq);
var
  i: integer;
  TotalCount: String;
  ContentList: TStringList;
  SearchDataList: TStringList;
  tmpSearchData: String;
  LabelWord: String;
  DataStart: boolean;
  Matches: MatchCollection;
  tmp, min, sec: string;
  tmptime: String;
  DateTime: TDateTime;
  second: integer;
  busyflag: boolean;
  errorflag: boolean;

  procedure GetRetry;
  var
    URL: OleVariant;
  begin
    if (NicoVideoRetryCount = 0) and
       (Length(Config.optNicoVideoAccount) > 0) and (Length(Config.optNicoVideoPassword) > 0) then
    begin
      Inc(NicoVideoRetryCount);
      Log('');
      Log('Cookie取得開始');
      Config.optNicoVideoSession := '';
      URL := NICOVIDEO_URI;
      WebBrowser4.Navigate2(URL);
    end
    else if (NicoVideoRetryCount < 100) and (Length(Config.optNicoVideoSession) > 0) then
    begin
      NicoVideoRetryCount := 100;
      Log('');
      Log('Cookie再取得開始');
      Config.optNicoVideoSession := '';
      URL := NICOVIDEO_URI;
      WebBrowser4.Navigate2(URL);
    end else
    begin
      case SearchType of
        1,10: SpTBXDockablePanelSearch.Caption := LabelWord + '[' + tmpSearchWord + ']   <取得失敗>';
        3,4,6: SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   <取得失敗>';
      end;
      Log('検索に失敗しました。');
    end;
  end;

const
  GET_TOTALCOUNT       = '<strong(?:[^>]+)?>([\d,]+)件?</strong>';
  GET_VIDEO_TITLE      = '<span class="vinfo_title">([^<]+)</span>';
  GET_VIDEO_ID         = '"watch\/([^"]+)"';
  GET_PLAYTIME_SECONDS = '>(\d{1,3}):(\d{2})<';
  GET_VIEW_COUNT       = '<strong class="vinfo_view">([\d,]+)</strong>';
  GET_RATIONG_COUNT    = '<strong class="vinfo_res">([\d,]+)</strong>';
  GET_UPLOAD_TIME      = '(\d+)/(\d+)/(\d+)[\s]?(\d+):(\d+)';
begin
  if procGet3 = sender then
  begin
    case Config.optSearchTarget of
      2:  LabelWord := 'ニコニコ動画(投稿日時が新しい順) ';
      3:  LabelWord := 'ニコニコ動画(投稿日時が古い順) ';
      4:  LabelWord := 'ニコニコ動画(再生が多い順) ';
      5:  LabelWord := 'ニコニコ動画(再生が少ない順) ';
      6:  LabelWord := 'ニコニコ動画(コメントが新しい順) ';
      7:  LabelWord := 'ニコニコ動画(コメントが古い順)';
      8:  LabelWord := 'ニコニコ動画(コメントが多い順)';
      9:  LabelWord := 'ニコニコ動画(コメントが少ない順) '; 
      10: LabelWord := 'ニコニコ動画(マイリスト登録数が多い順)';
      11: LabelWord := 'ニコニコ動画(マイリスト登録数が少ない順) ';
      20: LabelWord := 'ニコニコ動画(タグ検索-投稿日時が新しい順) ';
      21: LabelWord := 'ニコニコ動画(タグ検索-投稿日時が古い順) ';
      22: LabelWord := 'ニコニコ動画(タグ検索-再生が多い順) ';
      23: LabelWord := 'ニコニコ動画(タグ検索-再生が少ない順) ';
      24: LabelWord := 'ニコニコ動画(タグ検索-コメントが新しい順) ';
      25: LabelWord := 'ニコニコ動画(タグ検索-コメントが古い順) ';
      26: LabelWord := 'ニコニコ動画(タグ検索-コメントが多い順) ';
      27: LabelWord := 'ニコニコ動画(タグ検索-コメントが少ない順) ';  
      28: LabelWord := 'ニコニコ動画(タグ検索-マイリスト登録数が多い順) ';
      29: LabelWord := 'ニコニコ動画(タグ検索-マイリスト登録数が少ない順) ';
    end;
    Log('【nicovideo(OnNicoVideoSearch)】' + sender.IdHTTP.ResponseText);
    case sender.IdHTTP.ResponseCode of
    200: (* OK *)
      begin
        busyflag := false;
        errorflag := false;
        Log('データ分析開始');

        ContentList := TStringList.Create;
        SearchDataList := TStringList.Create;
        try
          ContentList.Text := procGet3.Content;
          TotalCount := '';
          for i := 0 to ContentList.Count -1 do
          begin
            ContentList[i] := UTF8toAnsi(ContentList[i]);

            if (AnsiPos(NICO_LOGIN_MESSAGE, ContentList[i]) > 0) then
            begin
              errorflag := true;
              break;
            end
            else if (AnsiPos(NICO_ACCESS_LOCKED, ContentList[i]) > 0) then
            begin
              busyflag := true;
              break;
            end;

            if Length(TotalCount) = 0 then //件があればそれを取得
            begin
              RegExp.Pattern := GET_TOTALCOUNT;
              begin
                try
                  if RegExp.Test(ContentList[i]) then
                  begin
                    Matches := RegExp.Execute(ContentList[i]) as MatchCollection;
                    TotalCount := AnsiString(Match(Matches.Item[0]).Value);
                    if Length(TotalCount) > 0 then
                    begin
                      TotalCount := '/' + RegExp.Replace(TotalCount, '$1');
                      TotalCount := CustomStringReplace(TotalCount, ',', '');
                    end;
                  end;
                except
                  TotalCount := '';
                end;
              end;
            end;
          end;
          if not errorflag and not busyflag then
          begin
            DataStart := false;
            tmpSearchData := '';
            for i := 0 to ContentList.Count -1 do
            begin
              {
              if SearchType = 4 then //きまぐれ検索(現在未使用)
              begin
                if (AnsiPos('<a href="watch/', ContentList[i]) > 0) then
                begin
                  DataStart := True;
                  tmpSearchData := ContentList[i];
                end else if DataStart and (AnsiPos('</td>', ContentList[i]) > 0) then
                begin
                  DataStart := false;
                  //tmpSearchData := tmpSearchData + ContentList[i];
                  if (AnsiPos('コメント', tmpSearchData) > 0) then
                    SearchDataList.Add(tmpSearchData);
                  tmpSearchData := '';
                end else if DataStart then
                begin
                  tmpSearchData := tmpSearchData + ContentList[i];
                end;
              end else //通常検索・新着投稿動画・ホットリスト
              }
              begin
                if (AnsiPos('class="thumb_frm"', ContentList[i]) > 0) then
                begin
                  DataStart := True;
                  tmpSearchData := ContentList[i];
                end else if DataStart and (AnsiPos('</div>', ContentList[i]) > 0) and
                            (AnsiPos('<!---->', ContentList[i-1]) > 0) then
                begin
                  DataStart := false;
                  tmpSearchData := tmpSearchData + '</div>';
                  SearchDataList.Add(tmpSearchData);
                  tmpSearchData := '';
                end else if DataStart then
                begin
                  tmpSearchData := tmpSearchData + ContentList[i];
                end;
              end;
            end;
            if SearchDataList.Count > 0 then
            begin
              for i := 0 to SearchDataList.Count -1 do
              begin
                tmpSearchData := SearchDataList.Strings[i];
                SearchList.Add(TSearchData.Create);
                with TSearchData(SearchList.Last) do
                begin
                  video_type := 1;
                  html := tmpSearchData;
                  RegExp.Pattern := GET_VIDEO_TITLE;
                  begin
                    try
                      if RegExp.Test(tmpSearchData) then
                      begin
                        Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                        video_title := AnsiString(Match(Matches.Item[0]).Value);
                        if Length(video_title) > 0 then
                        begin
                          video_title := RegExp.Replace(video_title, '$1');
                          video_title := CustomStringReplace(video_title,  '&quot;', '"');
                          video_title := CustomStringReplace(video_title,  '&amp;', '&');
                          video_title := CustomStringReplace(video_title,  '&lt; ', '<');
                          video_title := CustomStringReplace(video_title,  '&gt;', '>');
                        end;
                        //Log(video_title);
                      end;
                    except
                      video_title := '';
                    end;
                  end;
                  RegExp.Pattern := GET_VIDEO_ID;
                  begin
                    try
                      if RegExp.Test(tmpSearchData) then
                      begin
                        Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                        video_id := AnsiString(Match(Matches.Item[0]).Value);
                        if Length(video_id) > 0 then
                          video_id := RegExp.Replace(video_id, '$1');
                        //Log(video_id);
                      end;
                    except
                      video_id := '';
                    end;
                  end;
                  RegExp.Pattern := GET_PLAYTIME_SECONDS;
                  begin
                    try
                      if RegExp.Test(tmpSearchData) then
                      begin
                        Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                        tmp := AnsiString(Match(Matches.Item[0]).Value);
                        if Length(tmp) > 0 then
                        begin
                          min := RegExp.Replace(tmp, '$1');
                          sec := RegExp.Replace(tmp, '$2');
                          if (Length(min) > 0) and (Length(sec) > 0) then
                          try
                            playtime_seconds := IntToStr(StrToInt(min)*60 + StrToInt(sec));
                          except
                            playtime_seconds := ''
                          end;
                        end;
                        //Log(playtime_seconds);
                        if Length(playtime_seconds) > 0 then
                        begin
                          second := StrToIntDef(playtime_seconds, 0);
                          try
                            playtime := FormatFloat('0#', (second div 60)) + ':' + FormatFloat('0#', (second mod 60));
                          except
                            playtime := playtime_seconds + 'sec';
                          end;
                        end;
                        //Log(playtime);
                      end;
                    except
                    end;
                  end;
                  RegExp.Pattern := GET_VIEW_COUNT;
                  begin
                    try
                      if RegExp.Test(tmpSearchData) then
                      begin
                        Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                        view_count := AnsiString(Match(Matches.Item[0]).Value);
                        if Length(view_count) > 0 then
                        begin
                          view_count := RegExp.Replace(view_count, '$1');
                          view_count := CustomStringReplace(view_count, ',', '');
                        end;
                        //Log(view_count);
                      end;
                    except
                      view_count := '';
                    end;
                  end;
                  RegExp.Pattern := GET_RATIONG_COUNT; //コメント数
                  begin
                    try
                      if RegExp.Test(tmpSearchData) then
                      begin
                        Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                        rationg_count := AnsiString(Match(Matches.Item[0]).Value);
                        if Length(rationg_count) > 0 then
                        begin
                          rationg_count := RegExp.Replace(rationg_count, '$1');
                          rationg_count := CustomStringReplace(rationg_count, ',', '');
                        end;
                        //Log(rationg_count);
                      end;
                    except
                      rationg_count := '';
                    end;
                  end;
                  RegExp.Pattern := GET_UPLOAD_TIME; //アップロードされた時間
                  begin
                    try
                      if RegExp.Test(tmpSearchData) then
                      begin
                        Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                        tmp := AnsiString(Match(Matches.Item[0]).Value);
                        if Length(tmp) > 0 then
                        begin
                          tmptime := RegExp.Replace(tmp, '$1') + '/' + RegExp.Replace(tmp, '$2') + '/' + RegExp.Replace(tmp, '$3') + ' ' +
                                     RegExp.Replace(tmp, '$4') + ':' + RegExp.Replace(tmp, '$5');
                          DateSeparator := '/';
                          DateTime := StrToDateTime(tmptime);
                          upload_unixtime := IntToStr(DateTimeToUnix(DateTime));
                          upload_time := FormatDateTime('yyyy/mm/dd(aaa) hh:nn:ss', DateTime);
                        end;
                        //Log(upload_time);
                      end;
                    except
                      upload_unixtime := '';
                      upload_time := '';
                    end;
                  end;
                  if (Length(playtime_seconds) > 0) and (Length(rationg_count) > 0) and
                      not SameText(playtime_seconds, '0') then
                  try
                    rating_avg := FloatToStrF(StrToIntDef(rationg_count, 0) / StrToIntDef(playtime_seconds, 9999) * 60 ,
                                          ffFixed, 7, 1);
                  except
                    rating_avg := '';
                  end;
                end;
              end;
            end;
          end;

        finally
          ContentList.Free;
          SearchDataList.Free;
        end;
        Log('データ分析完了');

        if busyflag then
        begin
          case SearchType of
            1,10: SpTBXDockablePanelSearch.Caption := LabelWord + '[' + tmpSearchWord + ']   <アクセス規制中>';
            3,4,6: SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   <アクセス規制中>';
          end;
          Log('アクセス規制で有効なデータを取得できませんでした。');
        end
        else if errorflag then
        begin
          Log('データ再取得開始');
          GetRetry;
        end else
        begin
          NicoVideoRetryCount := 0;
          ListView.List := SearchList;
          currentSortColumn := high(integer);
          if SearchList.Count > 0 then
          begin
            case SearchType of
              1,10: SpTBXDockablePanelSearch.Caption := LabelWord + '[' + tmpSearchWord + ']   [1-' + IntToStr(SearchList.Count) + TotalCount + ']';
              3,4,6:  SpTBXDockablePanelSearch.Caption := tmpSearchWord +  '   [1-' + IntToStr(SearchList.Count) + TotalCount + ']';
              5:    SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   ' + LabelWord + '[' + tmpSearchWord + ']   [1-' + IntToStr(SearchList.Count) + TotalCount + ']';
            end;
            ActionSearchBarToggleListView.Enabled := true;
          end else
          begin
            SpTBXDockablePanelSearch.Caption := LabelWord + '[' + tmpSearchWord + ']   <該当データなし>';
          end;
          Log('検索完了');
        end;
      end;
    302:
      begin
        GetRetry;
      end;
    else
      begin
        SpTBXDockablePanelSearch.Caption := LabelWord + '[' + tmpSearchWord + ']   <取得失敗>';
        Log('検索に失敗しました。');
      end;
    end;
    procGet3 := nil;
    ActionSearchBarSearch.Enabled := True;
    ActionSearchBarSearch2.Enabled := True;
    case SearchType of
      1: //ニコニコ動画(通常検索)
      begin
      if SearchList.Count >= SearchPage * 30 then
        ActionSearchBarAdd100.Enabled := true
      else
        ActionSearchBarAdd100.Enabled := false;
      end;
      3: //ニコニコ動画(新着投稿)
      begin
      if (SearchList.Count >= SearchPage * 30) and (SearchPage * 30 < 300) then
        ActionSearchBarAdd100.Enabled := true
      else
        ActionSearchBarAdd100.Enabled := false;
      end;
      4,6: //ニコニコ動画(きまぐれ検索/ホットリスト)
      begin
        ActionSearchBarAdd100.Enabled := false;
      end;
      5: //ニコニコ動画(タグ検索)
      begin
      if (SearchList.Count >= SearchPage * 30) and (SearchPage * 30 < 300) then
        ActionSearchBarAdd100.Enabled := true
      else
        ActionSearchBarAdd100.Enabled := false;
      end;
    end;
    MenuSearchNicoVideo.Enabled := true;
    MenuSearchYouTube.Enabled := true;
  end;
end;

//検索結果を処理する
procedure TMainWnd.OnYouTubeSearch(sender: TAsyncReq);

  procedure Build(XMLNode: IXMLNode);
  var
    EntryNode: IXMLNode;
    Node: IXMLNode;
    NS_media, NS_gd, NS_yt, NS_openSearch: DOMString;
    SearchData: TSearchData;
    ANLData: TANLVideoData;
  begin
    NS_media := VarToWStr(XMLNode.Attributes['xmlns:media']);
    NS_gd := VarToWStr(XMLNode.Attributes['xmlns:gd']);
    NS_yt := VarToWStr(XMLNode.Attributes['xmlns:yt']);
    NS_openSearch := VarToWStr(XMLNode.Attributes['xmlns:openSearch']);

    EntryNode := XMLNode.ChildNodes.FindNode('entry');
    while Assigned(EntryNode) and (EntryNode.NodeName = 'entry') do
    begin
      ANLData := YouTubeEntryXMLAnalize(EntryNode, NS_media, NS_gd, NS_yt);
      if Assigned(ANLData) then
      begin
        try
          SearchData := TSearchData.Create;
          with SearchData do
          begin
            video_type := ANLData.video_type;
            liststate := 0;
            video_id := ANLData.video_id;
            author := ANLData.author;
            author_link := ANLData.author_link;
            description := ANLData.description;
            video_title := ANLData.video_title;
            thumbnail_url1 := ANLData.thumbnail_url;
            thumbnail_url2 := ANLData.thumbnail_url2;
            thumbnail_url3 := ANLData.thumbnail_url1;
            playtime_seconds := ANLData.playtime_seconds;
            playtime := ANLData.playtime;
            tags := ANLData.keywords;
            rating_avg := ANLData.rating_avg;
            rating := ANLData.rating;
            rationg_count := ANLData.rationg_count;
            view_count := ANLData.view_count;
            upload_unixtime := ANLData.upload_unixtime;
            upload_time := ANLData.upload_time;
            comment_count := ANLData.comment_count;
          end;
          SearchList.Add(SearchData);
        finally
          ANLData.Free;
        end;
      end;
      EntryNode := XMLNode.ChildNodes.FindSibling(EntryNode, 1);
    end;

    Node := XMLNode.ChildNodes.FindNode('totalResults', NS_openSearch);
    if Assigned(Node) then
      totalResults := VarToInt(Node.NodeValue);
  end;

//var
//  LabelWord: String;
begin
  if procGet3 = sender then
  begin
  {
    case Config.optSearchTarget of
      0: LabelWord := 'YouTube(標準検索) ';
      1: LabelWord := 'YouTube(関連検索) ';
      100: LabelWord := 'YouTube(カスタム検索) ';
    end;
    }

    Log('【YouTube(OnYouTubeSearch)】' + sender.IdHTTP.ResponseText);
    case sender.IdHTTP.ResponseCode of
    200: (* OK *)
      begin
        Log('データ分析開始');
        XMLDocument2.XML.Text := procGet3.Content;
        try
          XMLDocument2.Active := True;
        except
          on E: Exception do
          begin
            //MessageDlg(e.Message  + #13#10 + 'XMLの解析に失敗しました。', mtError, [mbOK], -1);
            Log(e.Message);
            Log('XMLの解析に失敗しました。');
            SpTBXDockablePanelSearch.Caption := tmpLabelWord + '[' + tmpSearchWord + ']   <解析失敗>';
            XMLDocument2.Active := false;
            XMLDocument2.XML.Clear;
            procGet3 := nil;
            ActionSearchBarSearch.Enabled := True;
            ActionSearchBarSearch2.Enabled := True;
            ActionSearchBarAdd100.Enabled := false;
            MenuSearchNicoVideo.Enabled := true;
            MenuSearchYouTube.Enabled := true;
            exit;
          end;
        end;
        Build(XMLDocument2.DocumentElement);
        XMLDocument2.Active := false;
        XMLDocument2.XML.Clear;
        Log('データ分析完了');

        ListView.List := SearchList;
        currentSortColumn := high(integer);
        if SearchList.Count > 0 then
        begin
          case SearchType of
            0:  SpTBXDockablePanelSearch.Caption := tmpLabelWord + '[' + tmpSearchWord + ']   [1-' + IntToStr(SearchList.Count) + ']';
            10: SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   [1-' + IntToStr(SearchList.Count) + ']';
            20: SpTBXDockablePanelSearch.Caption := tmpSearchWord;
          end;
          ActionSearchBarToggleListView.Enabled := true;
        end else
          SpTBXDockablePanelSearch.Caption := tmpLabelWord + '[' + tmpSearchWord + ']   <該当データなし>';
        Log('検索完了');
      end;
    else
      begin
        SpTBXDockablePanelSearch.Caption := tmpLabelWord + '[' + tmpSearchWord + ']   <取得失敗>';
        Log('検索に失敗しました。');
      end;
    end;
    procGet3 := nil;
    ActionSearchBarSearch.Enabled := True;
    ActionSearchBarSearch2.Enabled := True;
    case SearchType of
      0:
      begin
        if SearchList.Count >= SearchPage * 50 then
          ActionSearchBarAdd100.Enabled := true
        else
          ActionSearchBarAdd100.Enabled := false;
      end;
      10:
      begin
          ActionSearchBarAdd100.Enabled := false;
      end;
    end;
    MenuSearchNicoVideo.Enabled := true;
    MenuSearchYouTube.Enabled := true;
  end;
end;

//Enterキー押下で検索
procedure TMainWnd.SearchBarComboBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  case Key of
    #$D:
    begin
      if (Length(tmpSearchWord) > 0) and ActionSearchBarAdd100.Enabled and
        AnsiSameText(tmpSearchWord, SearchBarComboBox.Text) then
        ActionSearchBarAdd100.Execute
      else
        ActionSearchBarSearch.Execute;
    end;
  end;
end;

//検索バー表示切替
procedure TMainWnd.ActionToggleSearchBarExecute(Sender: TObject);
var
  width,height: integer;
begin
  width  := Self.Width - DockLeft.Width - DockLeft2.Width - DockRight.Width - DockRight2.Width;
  height := Self.Height - DockBottom.Height - DockTop.Height;
  if Self.Visible then
  begin
    Config.optShowToolBarSearchBar := not Config.optShowToolBarSearchBar;
    Config.Modified := True;
  end;
  ToolBarSearchBar.Visible := Config.optShowToolBarSearchBar;
  ActionToggleSearchBar.Checked := Config.optShowToolBarSearchBar;

  if (Self.WindowState = wsNormal) and (width > 0) and (height > 0) then
  begin
    width  := width + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width;
    height := height + DockBottom.Height + DockTop.Height;
    if (Self.Width <> width) or (Self.height <> height ) then
    begin
      SetBounds(Self.Left, Self.Top, width, height);
      SearchBarComboBox.Width := SearchBarComboBox.Width -1;
      TimerSetSearchBar.Enabled := true;
    end else
    begin
      SetBounds(Self.Left, Self.Top, width, height);
    end;
  end;
end;

//検索バー表示切替時の処理(カスタマイズからの変更用)
procedure TMainWnd.ToolBarSearchBarVisibleChanged(Sender: TObject);
var
  width,height: integer;
begin
  width  := Self.Width - DockLeft.Width - DockLeft2.Width - DockRight.Width - DockRight2.Width;
  height := Self.Height - DockBottom.Height - DockTop.Height;
  if Self.Visible then
  begin
    Config.optShowToolBarSearchBar := ToolBarSearchBar.Visible;
    Config.Modified := True;
    ActionToggleSearchBar.Checked := ToolBarSearchBar.Visible;
  end;
  
  if (Self.WindowState = wsNormal) and (width > 0) and (height > 0) then
  begin
    width  := width + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width;
    height := height + DockBottom.Height + DockTop.Height;
    if (Self.Width <> width) or (Self.height <> height ) then
    begin
      SetBounds(Self.Left, Self.Top, width, height);
      SearchBarComboBox.Width := SearchBarComboBox.Width -1;
      TimerSetSearchBar.Enabled := true;
    end else
    begin
      SetBounds(Self.Left, Self.Top, width, height);
    end;
  end;
end;

//タグを検索バーに追加
procedure TMainWnd.ActionAddTagExecute(Sender: TObject);
begin
  if Length(VideoData.tags) > 0 then
  begin
    SearchBarComboBox.Text := VideoData.tags;
    PanelSearchComboBox.Text := VideoData.tags;
  end;
  if not ActionToggleSearchBar.Checked then
  begin
    if ActionTogglePanelSearchToolBar.Checked then
    begin
      if not ActionToggleSearchPanel.Checked then
        ActionToggleSearchPanel.Execute
    end else
      ActionToggleSearchBar.Execute;
  end;
end;

//タグを検索バーに追加(リストから)
procedure TMainWnd.ActionListAddTagExecute(Sender: TObject);
var
  item: TListItem;
  SearchData: TSearchData;
begin
  item := ListView.Selected;
  if item = nil then
    exit;
  SearchData := TSearchData(item.Data);
  if SearchData = nil then
    exit;
  if Length(SearchData.tags) > 0 then
  begin
    SearchBarComboBox.Text := SearchData.tags;
    PanelSearchComboBox.Text := SearchData.tags;
  end;
  if not ActionToggleSearchBar.Checked then
  begin
    if ActionTogglePanelSearchToolBar.Checked then
    begin
      if not ActionToggleSearchPanel.Checked then
        ActionToggleSearchPanel.Execute
    end else
      ActionToggleSearchBar.Execute;
  end;
end;

//検索履歴の削除
procedure TMainWnd.ActionClearSearchHistoryExecute(Sender: TObject);
begin
   if Config.grepSearchList.Count < 1 then
   begin
     ShowMessage('検索履歴はありません');
     exit;
   end;
   MessageBeep(MB_ICONEXCLAMATION);
   if MessageDlg('検索履歴を消去します。よろしいですか？', mtWarning, mbOKCancel, -1) = mrOK then
   begin
     Config.grepSearchList.Clear;
     SearchBarComboBox.Clear;
     PanelSearchComboBox.Clear;
     SysUtils.DeleteFile(Config.BasePath + HISTORY_TXT);
     MessageBeep(MB_ICONASTERISK);
   end;
end;

//検索バーのリサイズ
procedure TMainWnd.ToolbarSearchBarResize(Sender: TObject);
var
  tmpWidth: integer;
begin
  ToolbarSearchBar.OnResize := nil;

  if ToolbarSearchBar.Floating then
    ToolbarSearchBar.Update
  else
  begin
    tmpWidth := ToolbarSearchBar.Width - (ToolbarSearchBar.Items.Count -1)*28;
    if tmpWidth < 0 then
      tmpWidth := 0;
    SearchBarComboBox.Width := tmpWidth;
  end;
  ToolbarSearchBar.OnResize := ToolbarSearchBarResize;
end;

//リストを切り替える
procedure TMainWnd.ActionSearchBarToggleListViewExecute(Sender: TObject);
var
  s: cardinal;
  innerHTML: String;
  Content: String;
  i: integer;
  item: TListItem;
  SearchData: TSearchData;
  EnableAdd100: boolean;
begin
  ActionSearchBarToggleListView.Checked := not ActionSearchBarToggleListView.Checked;
  if ActionSearchBarToggleListView.Checked then
  begin
    if not ActionToggleSearchPanel.Checked then
      ActionToggleSearchPanel.Execute;
    Clear(WebBrowser4);
    s := GetTickCount;
    while not DocComplete4 do
    begin
      Application.ProcessMessages;
      sleep(1);
      if (GetTickCount > s + 5000) then
        break;
    end;
    PanelBrowser.Visible := true;
    PanelListView.Visible := false;

    ActionSearchBarSearch.Enabled := false;
    ActionSearchBarSearch2.Enabled := false;
    EnableAdd100 := ActionSearchBarAdd100.Enabled;
    ActionSearchBarAdd100.Enabled := false;
    MenuSearchNicoVideo.Enabled := false;
    MenuSearchYouTube.Enabled := false;

    case SearchType of
      0,10,20: //YouTube
        begin
          innerHTML := S_HeaderHTML;

          if (ListView.SelCount > 1) or (Sender = ListPopupToggleListView) then
          begin
            item := ListView.Selected;
            SearchData := nil;
            while (item <> nil) and (item.Data <> SearchData) do
            begin
              Content := S_ContentHTML;
              SearchData := TSearchData(item.Data);
              with SearchData do
              begin
                Content := CustomStringReplace(Content, '$AUTHOR_LINK', author_link);
                Content := CustomStringReplace(Content, '$AUTHOR', author);
                Content := CustomStringReplace(Content, '$VIDEOID', video_id);
                Content := CustomStringReplace(Content, '$VIDEOTITLE', video_title);
                Content := CustomStringReplace(Content, '$PLAYTIME_SECONDS', playtime_seconds);
                Content := CustomStringReplace(Content, '$PLAYTIME', playtime);
                Content := CustomStringReplace(Content, '$RATING_AVG', rating_avg);
                Content := CustomStringReplace(Content, '$RATING_COUNT', rationg_count);
                Content := CustomStringReplace(Content, '$RATING', rating);
                Content := CustomStringReplace(Content, '$DESCRIPTION', description);
                Content := CustomStringReplace(Content, '$VIEW_COUNT', view_count);
                Content := CustomStringReplace(Content, '$UPLOAD_TIME', upload_time);
                Content := CustomStringReplace(Content, '$COMMENT_COUNT', comment_count);
                Content := CustomStringReplace(Content, '$TAGS', tags);
                Content := CustomStringReplace(Content, '$THUMBNAIL_URL1', thumbnail_url1);
                Content := CustomStringReplace(Content, '$THUMBNAIL_URL2', thumbnail_url2);
                Content := CustomStringReplace(Content, '$THUMBNAIL_URL3', thumbnail_url3);
              end;
              innerHTML := innerHTML + Content + #13#10;
              item := ListView.GetNextItem(item, sdBelow, [isSelected]);
            end;
          end else
          begin
            for i := 0 to ListView.Items.Count -1 do
            begin
              Content := S_ContentHTML;
              SearchData := TSearchData(ListView.Items[i].Data);
              with SearchData do
              begin
                Content := CustomStringReplace(Content, '$AUTHOR_LINK', author_link);
                Content := CustomStringReplace(Content, '$AUTHOR', author);
                Content := CustomStringReplace(Content, '$VIDEOID', video_id);
                Content := CustomStringReplace(Content, '$VIDEOTITLE', video_title);
                Content := CustomStringReplace(Content, '$PLAYTIME_SECONDS', playtime_seconds);
                Content := CustomStringReplace(Content, '$PLAYTIME', playtime);
                Content := CustomStringReplace(Content, '$RATING_AVG', rating_avg);
                Content := CustomStringReplace(Content, '$RATING_COUNT', rationg_count);
                Content := CustomStringReplace(Content, '$RATING', rating);
                Content := CustomStringReplace(Content, '$DESCRIPTION', description);
                Content := CustomStringReplace(Content, '$VIEW_COUNT', view_count);
                Content := CustomStringReplace(Content, '$UPLOAD_TIME', upload_time);
                Content := CustomStringReplace(Content, '$COMMENT_COUNT', comment_count);
                Content := CustomStringReplace(Content, '$TAGS', tags);
                Content := CustomStringReplace(Content, '$THUMBNAIL_URL1', thumbnail_url1);
                Content := CustomStringReplace(Content, '$THUMBNAIL_URL2', thumbnail_url2);
                Content := CustomStringReplace(Content, '$THUMBNAIL_URL3', thumbnail_url3);
              end;
              innerHTML := innerHTML + Content + #13#10;
            end;
          end;
          innerHTML := innerHTML + S_FooterHTML;
          innerHTML := CustomStringReplace(innerHTML, '$SKINPATH', Config.optSkinPath);
        end;
      1,2,3,4,6,8,9: //ニコニコ動画(検索・ランキング) マイリスト/ニコニコ市場
        begin
          case SearchType of
            1,3: innerHTML := NICO_DEFAULT_HEADER;
            2:   innerHTML := NICO2_DEFAULT_HEADER;
            4,6: innerHTML := NICO3_DEFAULT_HEADER;
            8:   innerHTML := NICO5_DEFAULT_HEADER;
            9:   innerHTML := NICO_ICHIBA_HEADER2;
          end;
          if (ListView.SelCount > 1) or (Sender = ListPopupToggleListView) then
          begin
            item := ListView.Selected;
            SearchData := nil;
            while (item <> nil) and (item.Data <> SearchData) do
            begin
              SearchData := TSearchData(item.Data);
              with SearchData do
              begin
                Content := html;
                if SearchType = 2 then //ダミーgifを変換
                  Content := CustomStringReplace(Content, 'src="/img/_.gif"', 'src="http://tn-skr2.smilevideo.jp/smile?i=' + Copy(video_id, 3, high(integer)) + '"');
              end;
              innerHTML := innerHTML + Content + #13#10;
              item := ListView.GetNextItem(item, sdBelow, [isSelected]);
            end;
          end else
          begin
            for i := 0 to ListView.Items.Count -1 do
            begin
              SearchData := TSearchData(ListView.Items[i].Data);
              with SearchData do
              begin
                Content := html;
                if SearchType = 2 then //ダミーgifを変換
                  Content := CustomStringReplace(Content, 'src="/img/_.gif"', 'src="http://tn-skr2.smilevideo.jp/smile?i=' + Copy(video_id, 3, high(integer)) + '"');
              end;
              innerHTML := innerHTML + Content + #13#10;
            end;
          end;
          case SearchType of
            1,3,4,6: innerHTML := innerHTML + NICO_DEFAULT_FOOTER;
            2: innerHTML := innerHTML + NICO2_DEFAULT_FOOTER;
            8: innerHTML := innerHTML + NICO2_DEFAULT_FOOTER;
            9: innerHTML := innerHTML + NICO_ICHIBA_FOOTER2;
          end;
        end;
    end;

    WebBrowser4.LoadFromString(innerHTML);

    ActionSearchBarSearch.Enabled := true;
    ActionSearchBarSearch2.Enabled := true;
    ActionSearchBarAdd100.Enabled := EnableAdd100;
    MenuSearchNicoVideo.Enabled := true;
    MenuSearchYouTube.Enabled := true;
  end else
  begin
    PanelBrowser.Visible := false;
    PanelListView.Visible := true;
    Clear(WebBrowser4);
  end;
end;

//検索パネルから検索
procedure TMainWnd.ActionSearchBarSearch2Execute(Sender: TObject);
begin
  SearchBarComboBox.Text := PanelSearchComboBox.Text;
  ActionSearchBarSearch.Execute;
end;

//Enterキー押下で検索(検索パネル)
procedure TMainWnd.PanelSearchComboBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  case Key of
    #$D:
    begin
      if (Length(tmpSearchWord) > 0) and ActionSearchBarAdd100.Enabled and
        AnsiSameText(tmpSearchWord, PanelSearchComboBox.Text) then
        ActionSearchBarAdd100.Execute
      else
        ActionSearchBarSearch2.Execute;
    end;
  end;
end;

//検索パネルの検索バー表示切替
procedure TMainWnd.ActionTogglePanelSearchToolBarExecute(Sender: TObject);
var
  width,height: integer;
begin
  width  := Self.Width - DockLeft.Width - DockLeft2.Width - DockRight.Width - DockRight2.Width;
  height := Self.Height - DockBottom.Height - DockTop.Height;
  if Self.Visible then
  begin
    Config.optShowPanelSearchToolBar := not Config.optShowPanelSearchToolBar;
    Config.Modified := True;
  end;
  PanelSearchToolbar.Visible := Config.optShowPanelSearchToolBar;
  ActionTogglePanelSearchToolBar.Checked := Config.optShowPanelSearchToolBar;

  if (Self.WindowState = wsNormal) and (width > 0) and (height > 0) then
  begin
    width  := width + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width;
    height := height + DockBottom.Height + DockTop.Height;
    if (Self.Width <> width) or (Self.height <> height ) then
    begin
      SetBounds(Self.Left, Self.Top, width, height);
      SearchBarComboBox.Width := SearchBarComboBox.Width -1;
      TimerSetSearchBar.Enabled := true;
    end else
    begin
      SetBounds(Self.Left, Self.Top, width, height);
    end;
  end;
end;

//検索パネルを閉じるボタンから閉じたとき用
procedure TMainWnd.SpTBXDockablePanelSearchCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  ActionToggleSearchPanel.Execute;
end;

//ビデオパネルを空にする
procedure TMainWnd.ActionClearVideoPanelExecute(Sender: TObject);
var
  s: Cardinal;
begin
  if (Length(tmpURI) > 0) then
  begin
    ClearVideoData;
    Clear(WebBrowser);
    Clear(WebBrowser2);
    Clear(WebBrowser3);
    SpTBXDockablePanelVideoRelated.Caption := '関連ビデオ';
    s := GetTickCount;
    while not DocComplete do
    begin
      Application.ProcessMessages;
      sleep(1);
      if (GetTickCount > s + 10000) then
        break;
    end;
    SetURI('');
  end;
  if Config.optFormStayOnTopPlaying then
  begin
    Config.optFormStayOnTop := true;
    ActionStayOnTop.Execute;
  end;
  TimerGetNicoVideoData.Enabled := false;
end;

//検索バーのリサイズイベントを発生させる
procedure TMainWnd.TimerSetSearchBarTimer(Sender: TObject);
begin
  TimerSetSearchBar.Enabled := false;
  ToolbarSearchBarResize(self);
end;

//ユーザー名を検索バーに追加
procedure TMainWnd.ActionAddAuthorExecute(Sender: TObject);
begin
  if Length(VideoData.author) > 0 then
  begin
    SearchBarComboBox.Text := 'user:' + VideoData.author;
    PanelSearchComboBox.Text := 'user:' + VideoData.author;
  end;
  if not ActionToggleSearchBar.Checked then
  begin
    if ActionTogglePanelSearchToolBar.Checked then
    begin
      if not ActionToggleSearchPanel.Checked then
        ActionToggleSearchPanel.Execute
    end else
      ActionToggleSearchBar.Execute;
  end;
end;

//ユーザー名を検索バーに追加(リストから)
procedure TMainWnd.ActionListAddAuthorExecute(Sender: TObject);
var
  item: TListItem;
  SearchData: TSearchData;
begin
  item := ListView.Selected;
  if item = nil then
    exit;
  SearchData := TSearchData(item.Data);
  if SearchData = nil then
    exit;
  if Length(SearchData.author) > 0 then
  begin
    SearchBarComboBox.Text := 'user:' + SearchData.author;
    PanelSearchComboBox.Text := 'user:' + SearchData.author;
  end;
  if not ActionToggleSearchBar.Checked then
  begin
    if ActionTogglePanelSearchToolBar.Checked then
    begin
      if not ActionToggleSearchPanel.Checked then
        ActionToggleSearchPanel.Execute
    end else
      ActionToggleSearchBar.Execute;
  end;
end;

//リスト内検索のタイマーイベント
procedure TMainWnd.SearchTimerTimer(Sender: TObject);
begin
  SearchTimer.Enabled := False;
  ListViewSearchNarrowing(TComboBox(SearchTimer.Tag));
end;

//検索バーのコンボボックス用
procedure TMainWnd.SearchComboBoxChange(Sender: TObject);
begin
  if not ActionSearchBarSearch.Enabled then
    exit;
  if ListView.Items.Count = 0 then
    exit;
  SearchTimer.Enabled := False;
  SearchTimer.Enabled := True;
  SearchTimer.Tag := Integer(Sender);
end;

//リスト内検索絞込み
procedure TMainWnd.ListViewSearchNarrowing(cb: TComboBox);
var
  keywordList: TStringList;
  i,j: integer;
begin
  if not ActionSearchBarSearch.Enabled then
    exit;
  if ListView.Items.Count = 0 then
    exit;
  if cb = nil then
    exit;

  keywordList := TStringList.Create;
  try
    keywordList.Delimiter := #$20;
    keywordList.DelimitedText := CustomStringReplace(cb.Text, #$81#$40, #$20);
    if keywordList.Count = 0 then
    begin
      for i := 0 to ListView.Items.Count - 1 do
        TSearchData(ListView.Items[i].Data).liststate := 0;
      ListView.Repaint;
      exit;
    end;
    keywordList.Text := StrUnify(keywordList.Text);

    for i := 0 to keywordList.Count - 1 do
    begin
      for j := 0 to ListView.Items.Count - 1 do
      begin
        if (i > 0) and (TSearchData(ListView.List[j]).liststate = 0) then
          Continue;

        if AnsiContainsText(StrUnify(TSearchData(ListView.List[j]).video_title), keywordList.Strings[i]) then
        begin
          TSearchData(ListView.List[j]).liststate := 1;
          SearchedEnd := True;
        end else
          TSearchData(ListView.List[j]).liststate := 0;

      end;
    end;
  finally
    keywordList.Free;
  end;

  ListView.DoubleBuffered := True;
  ListView.Sort(@ListCompare);
  ListView.SetTopItem(ListView.Items[0]);
  ListView.Repaint;
  ListView.DoubleBuffered := False;
  SearchedEnd := (TSearchData(ListView.Items[0].Data).liststate <> 0);
  if SearchedEnd then
    currentSortColumn := high(integer);

end;

//元ネタ動画を開く(nicovideo用)
procedure TMainWnd.ActionOpenPrimarySiteExecute(Sender: TObject);
var
  s: Cardinal;
  VideoID: String;
begin
  if VideoData.video_type = 1 then //YouTube
  begin
    VideoID := Copy(VideoData.video_id, 3, high(integer)); //idからutを除去
    ClearVideoData;
    Clear(WebBrowser);
    Clear(WebBrowser2);
    Clear(WebBrowser3);
    s := GetTickCount;
    while not DocComplete do
    begin
      Application.ProcessMessages;
      sleep(1);
      if (GetTickCount > s + 5000) then
        break;
    end;
    SetURI(YOUTUBE_GET_WATCH_URI + VideoID + Config.optMP4Format);
    exit;
  end
  else if VideoData.video_type = 2 then //AmebaVision
  begin
    VideoID := Copy(VideoData.video_id, 3, high(integer)); //idからamを除去
    OpenByBrowser(AMEBAVISION_URI + VideoID);
  end;
end;

//ウィンドウサイズをユーザー規定値にする
procedure TMainWnd.ActionUserWindowSizeExecute(Sender: TObject);
var
  VideoWidth: integer;
  VideoHeight: integer;
begin
  if VideoData.video_type in [1..5] then //nicovideo
  begin
    Panel.Tag := 20;
    VideoWidth  := Config.optNicoVideoWidth;
    VideoHeight := Config.optNicoVideoHeight;
  end else //YouTube
  begin
    Panel.Tag := 200;
    VideoWidth  := Config.optYouTubeWidth;
    VideoHeight := Config.optYouTubeHeight;
  end;
  if SpTBXTitleBar.Active then
  begin
    Self.Width :=  VideoWidth + GetSystemMetrics(SM_CXFRAME) * 2 + Self.BorderWidth * 2 + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width + SpTBXSplitterLeft.Width + SpTBXSplitterRight.Width;
    Self.Height := VideoHeight + GetSystemMetrics(SM_CYFRAME) * 2 + DockTop.Height + DockBottom.Height + SpTBXTitleBar.FTitleBarHeight;
  end else
  begin
    Self.Width :=  VideoWidth + GetSystemMetrics(SM_CXFRAME) * 2 + Self.BorderWidth * 2 + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width + SpTBXSplitterLeft.Width + SpTBXSplitterRight.Width;
    Self.Height := VideoHeight + GetSystemMetrics(SM_CYCAPTION) + GetSystemMetrics(SM_CYSIZEFRAME) * 2 + DockTop.Height + DockBottom.Height;
  end;
end;

//IE右クリックメニューに追加
procedure TMainWnd.ActionAddRegExecute(Sender: TObject);

  procedure CreateHtmlFile;
  var
    SL: TStringList;
  begin
    SL := TStringList.Create;
    try
      SL.Add('<SCRIPT LANGUAGE="JavaScript" defer>');
      SL.Add('var wnd = external.menuArguments;');
      SL.Add('var doc = wnd.document;');
      SL.Add('var evt = wnd.event;');
      SL.Add('var elm = doc.elementFromPoint(evt.clientX, evt.clientY);');
      SL.Add('var act = doc.activeElement;');
      SL.Add('var txt = doc.selection.createRange().text');
      SL.Add('var loc = wnd.location;');
      SL.Add('var url = loc.href;');
      SL.Add('while (elm.parentElement) {');
      SL.Add('  if (act.tagName=="A") {');
      SL.Add('    if(act.href.match(/^http/)) {');
      SL.Add('      url = act.href;');
      SL.Add('    }');
      SL.Add('    break;');
      SL.Add('  }');
      SL.Add('  else if (doc.selection) {');
      SL.Add('    if (txt.match(/[\w-]\.[a-z]{2}/)) {');
      SL.Add('      url = txt.replace(/\s/g,"");');
      SL.Add('      url = url.replace(/^(h|)ttp:\/\//,"");');
      SL.Add('      url = "http://"+url;');
      SL.Add('    }');
      SL.Add('    break;');
      SL.Add('  }');
      SL.Add('  elm = elm.parentElement;');
      SL.Add('}');
      SL.Add('url = url.replace(/^http:\/\/ime\.nu\//,"http://");');
      SL.Add('</SCRIPT>');
      SL.Add('<SCRIPT language="VBScript" defer>');
      SL.Add('Dim WshShell');
      SL.Add('Set WshShell = CreateObject("WScript.Shell")');
      SL.Add('WshShell.Run Chr(34) & "' + Application.ExeName + '" & Chr(34) & " " & Chr(34) & url & Chr(34), 1');
      SL.Add('</SCRIPT>');
      if not DirectoryExists(Config.BasePath + 'IEMenu') then
        ForceDirectories(Config.BasePath + 'IEMenu');
      SL.SaveToFile(Config.BasePath + 'IEMenu\IEMenuExt.htm');
    finally
      SL.Free;
    end;
  end;

var
  R: TRegistry;
begin
  MessageBeep(MB_ICONEXCLAMATION);
  if MessageDlg('IE右クリックメニューに「TubePlayerで開く」を追加します。'  + #13#10 + 'よろしいですか？', mtWarning, mbOKCancel, -1) = mrOK then
  begin
    R := TRegistry.Create;
    try
      R.RootKey := HKEY_CURRENT_USER;
      if R.OpenKey('\Software\Microsoft\Internet Explorer\MenuExt\TubePlayerで開く(&Z)', true) then
      begin
        R.WriteString('', Config.BasePath + 'IEMenu\IEMenuExt.htm');
        R.WriteInteger('Contexts' , 51);
        CreateHtmlFile;
      end else
      begin
        MessageBeep(MB_ICONERROR);
        MessageDlg('レジストリにアクセスできませんでした。', mtInformation, [mbOk], 0);
        exit;
      end;
      R.CloseKey;
    finally
      R.Free;
    end;
    MessageBeep(MB_ICONASTERISK);
    MessageDlg('IE右クリックメニューに「TubePlayerで開く」を追加しました。'  + #13#10 + 'アンインストールの際は「IE右クリックメニューから削除」を実行してください。', mtInformation, [mbOk], 0);
  end;
end;

//IE右クリックメニューから削除
procedure TMainWnd.ActionDelRegExecute(Sender: TObject);
var
  R: TRegistry;
begin
  MessageBeep(MB_ICONEXCLAMATION);
  if MessageDlg('IE右クリックメニューから「TubePlayerで開く」を削除します。'  + #13#10 + 'よろしいですか？', mtWarning, mbOKCancel, -1) = mrOK then
  begin
    R := TRegistry.Create;
    try
      R.RootKey := HKEY_CURRENT_USER;
      R.DeleteKey('\Software\Microsoft\Internet Explorer\MenuExt\TubePlayerで開く(&Z)');
      if FileExists(Config.BasePath + 'IEMenu\IEMenuExt.htm') then
        DeleteFile(Config.BasePath + 'IEMenu\IEMenuExt.htm');
      R.CloseKey;
    finally
      R.Free;
    end;
    MessageBeep(MB_ICONASTERISK);
    MessageDlg('IE右クリックメニューから「TubePlayerで開く」を削除しました。', mtInformation, [mbOk], 0);
  end;
end;

//デフォルトのアクセラレータキーを無効にする(ニコニコ動画でキーが効かない対策)
function TMainWnd.EmbeddedWBTranslateAccelerator(const lpMsg: PMsg;
  const pguidCmdGroup: PGUID; const nCmdID: Cardinal): HRESULT;
begin
  result := S_OK;
end;

//ウィンドウサイズ切替
procedure TMainWnd.ActionToggleWindowSizeExecute(Sender: TObject);
var
  VideoWidth: integer;
  VideoHeight: integer;
begin
  if VideoData.video_type in [1..5] then //nicovideo
  begin
    if (Panel.Tag <> 20) or
       ((Panel.Width <> Config.optNicoVideoWidth) and (Panel.Height <> Config.optNicoVideoHeight)) then
    begin
      Panel.Tag := 20;
      VideoWidth  := Config.optNicoVideoWidth;
      VideoHeight := Config.optNicoVideoHeight;
    end else
    begin
      Panel.Tag := 10;
      VideoWidth  := Config.optNicoVideoWidthDef;
      VideoHeight := Config.optNicoVideoHeightDef;
      if (VideoWidth = 0) or (VideoHeight = 0) then
      begin
        VideoWidth  := NICOVIDEO_DEFAULT_WIDTH;
        VideoHeight := NICOVIDEO_DEFAULT_HEIGHT;
      end;
    end;
  end else //YouTube
  begin
    if (Panel.Tag <> 200) or
       ((Panel.Width <> Config.optYouTubeWidth) and (Panel.Height <> Config.optYouTubeHeight)) then
    begin
      Panel.Tag := 200;
      VideoWidth  := Config.optYouTubeWidth;
      VideoHeight := Config.optYouTubeHeight;
    end else
    begin
      Panel.Tag := 100;
      VideoWidth  := Config.optYouTubeWidthDef;
      VideoHeight := Config.optYouTubeHeightDef;
      if (VideoWidth = 0) or (VideoHeight = 0) then
      begin
        VideoWidth  := YOUTUBE_DEFAULT_WIDTH2;
        VideoHeight := YOUTUBE_DEFAULT_HEIGHT2;
      end;
    end;
  end;
  if SpTBXTitleBar.Active then
  begin
    Self.Width :=  VideoWidth + GetSystemMetrics(SM_CXFRAME) * 2 + Self.BorderWidth * 2 + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width + SpTBXSplitterLeft.Width + SpTBXSplitterRight.Width;
    Self.Height := VideoHeight + GetSystemMetrics(SM_CYFRAME) * 2 + DockTop.Height + DockBottom.Height + SpTBXTitleBar.FTitleBarHeight;
  end else
  begin
    Self.Width :=  VideoWidth + GetSystemMetrics(SM_CXFRAME) * 2 + Self.BorderWidth * 2 + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width + SpTBXSplitterLeft.Width + SpTBXSplitterRight.Width;
    Self.Height := VideoHeight + GetSystemMetrics(SM_CYCAPTION) + GetSystemMetrics(SM_CYSIZEFRAME) * 2 + DockTop.Height + DockBottom.Height;
  end;
end;

//検索サイトの変更
procedure TMainWnd.ActionToggleSearchTargetExecute(Sender: TObject);
var
  i: integer;
begin
  if Sender <> nil then
  begin
    case TComponent(Sender).Tag of
      0:  Config.optSearchTarget  := 0;  //YouTube(標準)
      1:  Config.optSearchTarget  := 1;  //YouTube(関連検索)
      100: Config.optSearchTarget := 100; //YouTube(サイト内検索)
      2:  Config.optSearchTarget  := 2;  //ニコニコ動画(投稿日時が新しい順)
      3:  Config.optSearchTarget  := 3;  //ニコニコ動画(投稿日時が古い順)
      4:  Config.optSearchTarget  := 4;  //ニコニコ動画(再生が多い順)
      5:  Config.optSearchTarget  := 5;  //ニコニコ動画(再生が少ない順)
      6:  Config.optSearchTarget  := 6;  //ニコニコ動画(コメントが新しい順)
      7:  Config.optSearchTarget  := 7;  //ニコニコ動画(コメントが古い順)
      8:  Config.optSearchTarget  := 8;  //ニコニコ動画(コメントが多い順)
      9:  Config.optSearchTarget  := 9;  //ニコニコ動画(コメントが少ない順) 
      10: Config.optSearchTarget  := 10; //ニコニコ動画(マイリスト登録数が多い順)
      11: Config.optSearchTarget  := 11; //ニコニコ動画(マイリスト登録数が少ない順)
      20: Config.optSearchTarget  := 20; //ニコニコ動画(タグ検索-投稿日時が新しい順)
      21: Config.optSearchTarget  := 21; //ニコニコ動画(タグ検索-投稿日時が古い順)
      22: Config.optSearchTarget  := 22; //ニコニコ動画(タグ検索-再生が多い順)
      23: Config.optSearchTarget  := 23; //ニコニコ動画(タグ検索-再生が少ない順)
      24: Config.optSearchTarget  := 24; //ニコニコ動画(タグ検索-コメントが新しい順)
      25: Config.optSearchTarget  := 25; //ニコニコ動画(タグ検索-コメントが古い順)
      26: Config.optSearchTarget  := 26; //ニコニコ動画(タグ検索-コメントが多い順)
      27: Config.optSearchTarget  := 27; //ニコニコ動画(タグ検索-コメントが少ない順) 
      28: Config.optSearchTarget  := 28; //ニコニコ動画(タグ検索-マイリスト登録数が多い順)
      29: Config.optSearchTarget  := 29; //ニコニコ動画(タグ検索-マイリスト登録数が少ない順)
    end;
    Config.Modified := True;
    ActionSearchBarAdd100.Enabled := false;
  end;

  for i := 0 to MenuSearchToggleSearchTarget.Count -1 do
  begin
    MenuSearchToggleSearchTarget[i].Checked := (Config.optSearchTarget = MenuSearchToggleSearchTarget[i].Tag);
  end;

  Case Config.optSearchTarget of
    0,1,100: //YouTube
    begin
      MenuSearchToggleSearchTarget.ImageIndex := 13;
      SearchBarToggleSearchTarget.ImageIndex := 13;
      PanelSearchToggleSearchTarget.ImageIndex := 13;
      CustomToggleSearchTarget.ImageIndex := 13;
    end;
    2..11,20..29: //ニコニコ動画
    begin
      MenuSearchToggleSearchTarget.ImageIndex := 14;
      SearchBarToggleSearchTarget.ImageIndex := 14;
      PanelSearchToggleSearchTarget.ImageIndex := 14;
      CustomToggleSearchTarget.ImageIndex := 14;
    end;
  end;
end;

//新着投稿動画 トップ300/最新コメント動画 トップ300/きまぐれ検索
procedure TMainWnd.GetExtraExecute(Sender: TObject);
var
  URI: String;
  LabelWord: String;
begin
  if Sender = nil then
    exit;
  if not ActionSearchBarSearch.Enabled then
    exit;

  ActionSearchBarSearch.Enabled := false;
  ActionSearchBarSearch2.Enabled := false;
  ActionSearchBarAdd100.Enabled := false;

  MenuSearchNicoVideo.Enabled := false;
  MenuSearchYouTube.Enabled := false;

  PanelBrowser.Visible := false;
  PanelListView.Visible := true;
  ActionSearchBarToggleListView.Checked := false;
  ActionSearchBarToggleListView.Enabled := false;

  ClearSearchList;
  SearchPage := 1;
  if not ActionToggleSearchPanel.Checked then
    ActionToggleSearchPanel.Execute;

  case TSpTBXItem(Sender).Tag of
    1:  URI := 'http://www.nicovideo.jp/newarrival';
    2:  URI := 'http://www.nicovideo.jp/recent';
    3:  URI := 'http://www.nicovideo.jp/random'; 
    4:  URI := 'http://www.nicovideo.jp/hotlist';
    else exit;
  end;
  case TSpTBXItem(Sender).Tag of
    1:  LabelWord := '新着投稿動画 トップ300';
    2:  LabelWord := '最新コメント動画 トップ300';
    3:  LabelWord := 'きまぐれ検索';    
    4:  LabelWord := 'ホットリスト';
  end;

  tmpSearchURI := '';
  tmpSearchWord := LabelWord;
  NicoVideoRetryCount := 0;
  Log(LabelWord + ' 取得開始');
  case TSpTBXItem(Sender).Tag of
    1,2:
    begin
      SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   [1-30]   <取得中>';
      SearchType := 3;
    end;
    3:
    begin
      SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   <取得中>';
      SearchType := 4;
    end; 
    4:
    begin
      SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   <取得中>';
      SearchType := 6;
    end;
  end;
  Log('');
  procGet3 := AsyncManager.Get(URI, OnNicoVideoSearch, OnNicoVideoPreConnect);
  tmpSearchURI := URI;
end;

//ニコニコ動画の各種ランキングを取得
procedure TMainWnd.GetRankingExecute(Sender: TObject);
var
  URI: String;
  LabelWord: String;
  AddURI: String;
  AddLabel: String;
begin
  if Sender = nil then
    exit;
  if not ActionSearchBarSearch.Enabled then
    exit;

  if ((Length(Config.optNicoVideoAccount) = 0) or (Length(Config.optNicoVideoPassword) = 0)) then
  begin
    ShowMessage('ニコニコ動画の視聴にはアカウントが必要です。' + #13#10 + 'アカウント設定は、設定＞nicovideoでしてください。');
    exit;
  end;

  ActionSearchBarSearch.Enabled := false;
  ActionSearchBarSearch2.Enabled := false;
  ActionSearchBarAdd100.Enabled := false;

  MenuSearchNicoVideo.Enabled := false;
  MenuSearchYouTube.Enabled := false;

  PanelBrowser.Visible := false;
  PanelListView.Visible := true;
  ActionSearchBarToggleListView.Checked := false;
  ActionSearchBarToggleListView.Enabled := false;

  ClearSearchList;
  SearchPage := 1;
  if not ActionToggleSearchPanel.Checked then
    ActionToggleSearchPanel.Execute;

  case Config.optSearchNicoVideoCategory of
    0:  begin AddURI := 'all';      AddLabel := '総合' end;
    1:  begin AddURI := 'music';    AddLabel := '音楽' end;
    2:  begin AddURI := 'ent';      AddLabel := 'エンターテイメント' end;
    3:  begin AddURI := 'anime';    AddLabel := 'アニメ' end;
    4:  begin AddURI := 'game';     AddLabel := 'ゲーム' end;
    5:  begin AddURI := 'animal';   AddLabel := '動物' end;
    6:  begin AddURI := 'que';      AddLabel := 'アンケート' end;
    7:  begin AddURI := 'radio';    AddLabel := 'ラジオ' end;
    8:  begin AddURI := 'sport';    AddLabel := 'スポーツ' end;
    9:  begin AddURI := 'politics'; AddLabel := '政治' end;
    10: begin AddURI := 'chat';     AddLabel := 'チャット' end;
    11: begin AddURI := 'science';  AddLabel := '科学' end;
    12: begin AddURI := 'history';  AddLabel := '歴史' end;
    13: begin AddURI := 'cooking';  AddLabel := '料理' end;
    14: begin AddURI := 'nature';   AddLabel := '自然' end;
    15: begin AddURI := 'diary';    AddLabel := '日記' end;
    16: begin AddURI := 'dance';    AddLabel := '踊ってみた' end;
    17: begin AddURI := 'sing';     AddLabel := '歌ってみた' end;
    18: begin AddURI := 'play';     AddLabel := '演奏してみた' end;
    19: begin AddURI := 'lecture';  AddLabel := 'ニコニコ動画講座' end;
    20: begin AddURI := 'other';    AddLabel := 'その他' end;
    21: begin AddURI := 'test';     AddLabel := 'テスト' end;
    22: begin AddURI := 'r18';      AddLabel := 'R-18' end;
    else
        begin AddURI := 'all';      AddLabel := '総合' end;
  end;

  case TSpTBXItem(Sender).Tag of
    10,110,210: begin AddURI := 'all';      AddLabel := '総合' end;
  end;

  case TSpTBXItem(Sender).Tag of
    10: URI := 'http://www.nicovideo.jp/ranking/view/hourly/' + AddURI;
    20: URI := 'http://www.nicovideo.jp/ranking/view/daily/' + AddURI;
    30: URI := 'http://www.nicovideo.jp/ranking/view/weekly/' + AddURI;
    40: URI := 'http://www.nicovideo.jp/ranking/view/monthly/' + AddURI;
    50: URI := 'http://www.nicovideo.jp/ranking/view/total/' + AddURI;

    110: URI := 'http://www.nicovideo.jp/ranking/res/hourly/' + AddURI;
    120: URI := 'http://www.nicovideo.jp/ranking/res/daily/' + AddURI;
    130: URI := 'http://www.nicovideo.jp/ranking/res/weekly/' + AddURI;
    140: URI := 'http://www.nicovideo.jp/ranking/res/monthly/' + AddURI;
    150: URI := 'http://www.nicovideo.jp/ranking/res/total/' + AddURI;

    210: URI := 'http://www.nicovideo.jp/ranking/mylist/hourly/' + AddURI;
    220: URI := 'http://www.nicovideo.jp/ranking/mylist/daily/' + AddURI;
    230: URI := 'http://www.nicovideo.jp/ranking/mylist/weekly/' + AddURI;
    240: URI := 'http://www.nicovideo.jp/ranking/mylist/monthly/' + AddURI;
    250: URI := 'http://www.nicovideo.jp/ranking/mylist/total/' + AddURI;
    else exit;
  end;
  case TSpTBXItem(Sender).Tag of
    10: LabelWord := AddLabel +  ' - 再生ランキング(毎時)';
    20: LabelWord := AddLabel +  ' - 再生ランキング(デイリー)';
    30: LabelWord := AddLabel +  ' - 再生ランキング(週間)';
    40: LabelWord := AddLabel +  ' - 再生ランキング(月間)';
    50: LabelWord := AddLabel +  ' - 再生ランキング(合計)';

    110: LabelWord := AddLabel +  ' - コメントランキング(毎時)';
    120: LabelWord := AddLabel +  ' - コメントランキング(デイリー)';
    130: LabelWord := AddLabel +  ' - コメントランキング(週間)';
    140: LabelWord := AddLabel +  ' - コメントランキング(月間)';
    150: LabelWord := AddLabel +  ' - コメントランキング(合計)';

    210: LabelWord := AddLabel +  ' - マイリスト登録ランキング(毎時)';
    220: LabelWord := AddLabel +  ' - マイリスト登録ランキング(デイリー)';
    230: LabelWord := AddLabel +  ' - マイリスト登録ランキング(週間)';
    240: LabelWord := AddLabel +  ' - マイリスト登録ランキング(月間)';
    250: LabelWord := AddLabel +  ' - マイリスト登録ランキング(合計)';
  end;

  tmpSearchURI := '';
  tmpSearchWord := LabelWord;
  SearchType := 2;
  NicoVideoRetryCount := 0;
  Log('ランキング取得開始');
  SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   [1-100]   <取得中>';
  Log('');
  procGet3 := AsyncManager.Get(URI, OnNicoVideoGetRanking, OnNicoVideoPreConnect);
  tmpSearchURI := URI;
end;

//ニコニコ動画のランキングを処理する
procedure TMainWnd.OnNicoVideoGetRanking(sender: TAsyncReq);
var
  i: integer;
  TotalCount: String;
  ContentList: TStringList;
  SearchDataList: TStringList;
  tmpSearchData: String;
  IsSearchDone: boolean;
  ContentsStart: boolean;
  DataStart: boolean;
  Matches: MatchCollection;
  tmp, min, sec: String;
  tmptime: String;
  DateTime: TDateTime;
  second: integer;
  busyflag: boolean;
  errorflag: boolean;

  procedure GetRetry;
  var
    URL: OleVariant;
  begin
    if (NicoVideoRetryCount = 0) and
       (Length(Config.optNicoVideoAccount) > 0) and (Length(Config.optNicoVideoPassword) > 0) then
    begin
      Inc(NicoVideoRetryCount);
      Log('');
      Log('Cookie取得開始');
      Config.optNicoVideoSession := '';
      URL := NICOVIDEO_URI;
      WebBrowser4.Navigate2(URL);
    end
    else if (NicoVideoRetryCount < 100) and (Length(Config.optNicoVideoSession) > 0) then
    begin
      NicoVideoRetryCount := 100;
      Log('');
      Log('Cookie再取得開始');
      Config.optNicoVideoSession := '';
      URL := NICOVIDEO_URI;
      WebBrowser4.Navigate2(URL);
    end else
    begin
      SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   <取得失敗>';
      Log('データの取得に失敗しました。');
    end;
  end;

const
  GET_VIDEO_TITLE      = 'href="(?:http://www\.nicovideo\.jp/)?watch\/[^"]+">([^<]+)<\/a>';
  GET_VIDEO_ID         = 'watch\/([^"]+)">';
  GET_PLAYTIME_SECONDS = '>(\d{1,3}):(\d{2})<';
  GET_VIEW_COUNT       = '再生 <strong>([\d,]+)<\/strong>';
  GET_RATIONG_COUNT    = 'コメ <strong>([\d,]+)<\/strong>';
  GET_UPLOAD_TIME      = '(\d+)年(\d+)月(\d+)日[\s]?(\d+):(\d+)';
begin
  if procGet3 = sender then
  begin

    Log('【nicovideo(OnNicoVideoGetRanking)】' + sender.IdHTTP.ResponseText);
    case sender.IdHTTP.ResponseCode of
    200: (* OK *)
      begin
        IsSearchDone := false;
        busyflag := false;
        errorflag := false;
        Log('データ分析開始');

        ContentList := TStringList.Create;
        SearchDataList := TStringList.Create;
        try
          ContentList.Text := procGet3.Content;
          TotalCount := '';
          for i := 0 to ContentList.Count -1 do
          begin
            ContentList[i] := UTF8toAnsi(ContentList[i]);
            if not IsSearchDone then
            begin
              if (AnsiPos('class="thumb_frm"', ContentList[i]) > 0) then
                IsSearchDone := True
              else if (AnsiPos(NICO_LOGIN_MESSAGE, ContentList[i]) > 0) then
              begin
                errorflag := true;
                break;
              end
              else if (AnsiPos(NICO_ACCESS_LOCKED, ContentList[i]) > 0) then
              begin
                busyflag := true;
                break;
              end;
            end;
          end;
          if IsSearchDone then
          begin
            ContentsStart := false;
            DataStart := false;
            tmpSearchData := '';
            for i := 0 to ContentList.Count -1 do
            begin
              if not ContentsStart then
              begin
                if (AnsiPos('class="thumb_frm"', ContentList[i]) > 0) then
                  ContentsStart := True;
                Continue;
              end;
              if AnsiStartsStr('<tr', ContentList[i]) then
              begin
                DataStart := True;
                tmpSearchData := ContentList[i];
              end else if DataStart and AnsiEndsStr('</tr>', ContentList[i]) then
              begin
                DataStart := false;
                tmpSearchData := tmpSearchData + ContentList[i];
                if (AnsiPos('class="vinfo_last_res"', tmpSearchData) > 0) or
                   ((AnsiPos('href="watch/so', tmpSearchData) > 0) and
                    (AnsiPos('class="TXT12"', tmpSearchData) > 0)
                   )then
                  SearchDataList.Add(tmpSearchData);
                tmpSearchData := '';
              end else if DataStart then
              begin
                tmpSearchData := tmpSearchData + ContentList[i];
              end;
            end;

            if SearchDataList.Count > 0 then
            begin
              for i := 0 to SearchDataList.Count -1 do
              begin
                tmpSearchData := SearchDataList.Strings[i];
                SearchList.Add(TSearchData.Create);
                with TSearchData(SearchList.Last) do
                begin
                  video_type := 1;
                  html := tmpSearchData;
                  RegExp.Pattern := GET_VIDEO_TITLE;
                  begin
                    try
                      if RegExp.Test(tmpSearchData) then
                      begin
                        Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                        video_title := AnsiString(Match(Matches.Item[0]).Value);
                        if Length(video_title) > 0 then
                        begin
                          video_title := RegExp.Replace(video_title, '$1');
                          video_title := CustomStringReplace(video_title,  '&quot;', '"');
                          video_title := CustomStringReplace(video_title,  '&amp;', '&');
                          video_title := CustomStringReplace(video_title,  '&lt; ', '<');
                          video_title := CustomStringReplace(video_title,  '&gt;', '>');
                        end;
                        //Log(video_title);
                      end;
                    except
                      video_title := '';
                    end;
                  end;
                  RegExp.Pattern := GET_VIDEO_ID;
                  begin
                    try
                      if RegExp.Test(tmpSearchData) then
                      begin
                        Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                        video_id := AnsiString(Match(Matches.Item[0]).Value);
                        if Length(video_id) > 0 then
                          video_id := RegExp.Replace(video_id, '$1');
                        //Log(video_id);
                      end;
                    except
                      video_id := '';
                    end;
                  end;
                  RegExp.Pattern := GET_PLAYTIME_SECONDS;
                  begin
                    try
                      if RegExp.Test(tmpSearchData) then
                      begin
                        Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                        tmp := AnsiString(Match(Matches.Item[0]).Value);
                        if Length(tmp) > 0 then
                        begin
                          min := RegExp.Replace(tmp, '$1');
                          sec := RegExp.Replace(tmp, '$2');
                          if (Length(min) > 0) and (Length(sec) > 0) then
                          try
                            playtime_seconds := IntToStr(StrToInt(min)*60 + StrToInt(sec));
                          except
                            playtime_seconds := ''
                          end;
                        end;
                        //Log(playtime_seconds);
                        if Length(playtime_seconds) > 0 then
                        begin
                          second := StrToIntDef(playtime_seconds, 0);
                          try
                            playtime := FormatFloat('0#', (second div 60)) + ':' + FormatFloat('0#', (second mod 60));
                          except
                            playtime := playtime_seconds + 'sec';
                          end;
                        end;
                        //Log(playtime);
                      end;
                    except
                    end;
                  end;
                  RegExp.Pattern := GET_VIEW_COUNT;
                  begin
                    try
                      if RegExp.Test(tmpSearchData) then
                      begin
                        Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                        view_count := AnsiString(Match(Matches.Item[0]).Value);
                        if Length(view_count) > 0 then
                        begin
                          view_count := RegExp.Replace(view_count, '$1');
                          view_count := CustomStringReplace(view_count,  ',', '');
                        end;
                        //Log(view_count);
                      end;
                    except
                      view_count := '';
                    end;
                  end;
                  RegExp.Pattern := GET_RATIONG_COUNT; //コメント数
                  begin
                    try
                      if RegExp.Test(tmpSearchData) then
                      begin
                        Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                        rationg_count := AnsiString(Match(Matches.Item[0]).Value);
                        if Length(rationg_count) > 0 then
                        begin
                          rationg_count := RegExp.Replace(rationg_count, '$1');
                          rationg_count := CustomStringReplace(rationg_count,  ',', '');
                        end;
                        //Log(rationg_count);
                      end;
                    except
                      rationg_count := '';
                    end;
                  end;
                  RegExp.Pattern := GET_UPLOAD_TIME; //アップロードされた時間
                  begin
                    try
                      if RegExp.Test(tmpSearchData) then
                      begin
                        Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                        tmp := AnsiString(Match(Matches.Item[0]).Value);
                        if Length(tmp) > 0 then
                        begin
                          tmptime := RegExp.Replace(tmp, '$1') + '/' + RegExp.Replace(tmp, '$2') + '/' + RegExp.Replace(tmp, '$3') + ' ' +
                                     RegExp.Replace(tmp, '$4') + ':' + RegExp.Replace(tmp, '$5');
                          DateSeparator := '/';
                          DateTime := StrToDateTime(tmptime);
                          upload_unixtime := IntToStr(DateTimeToUnix(DateTime));
                          upload_time := FormatDateTime('yyyy/mm/dd(aaa) hh:nn:ss', DateTime);
                        end;
                        //Log(upload_time);
                      end;
                    except
                      upload_unixtime := '';
                      upload_time := '';
                    end;
                  end;
                  if (Length(playtime_seconds) > 0) and (Length(rationg_count) > 0) and (StrToInt(playtime_seconds) > 0) then
                  begin
                    rating_avg := FloatToStrF(StrToIntDef(rationg_count, 0) / StrToInt(playtime_seconds) * 60 ,
                                                          ffFixed, 7, 1);
                  end;
                end;
              end;
            end;
          end;

        finally
          ContentList.Free;
          SearchDataList.Free;
        end;
        Log('データ分析完了');

        if busyflag then
        begin
          Log('アクセス規制で有効なデータを取得できませんでした。');
          SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   <アクセス規制中>';
        end
        else if not IsSearchDone then
        begin
          Log('有効なデータを取得できませんでした。');
          if errorflag then
          begin
            Log('データ再取得開始');
            GetRetry;
          end else
          begin
            SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   <取得失敗>';
            Log('データの取得に失敗しました。');
          end;
        end else
        begin
          NicoVideoRetryCount := 0;
          ListView.List := SearchList;
          currentSortColumn := high(integer);
          if SearchList.Count > 0 then
          begin
            SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   [1-' + IntToStr(SearchList.Count) + ']';
            ActionSearchBarToggleListView.Enabled := true;
          end else
            SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   <該当データなし>';
          Log('取得完了');
        end;
      end;
    {
    302:
      begin
        GetRetry;
      end;
    }
    else
      begin
        SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   <取得失敗>';
        Log('データの取得に失敗しました。');
      end;
    end;
    procGet3 := nil;
    ActionSearchBarSearch.Enabled := True;
    ActionSearchBarSearch2.Enabled := True;
    if (SearchList.Count >= SearchPage * 100) and
       ((AnsiPos('総合' , tmpSearchWord) > 0) and
        (AnsiPos('毎時' , tmpSearchWord) = 0) and //毎時は100位まで
        (SearchPage * 100 < 300)
       ) then
    begin
      ActionSearchBarAdd100.Enabled := true
    end else
      ActionSearchBarAdd100.Enabled := false;
    MenuSearchNicoVideo.Enabled := true;
    MenuSearchYouTube.Enabled := true;
  end;
end;

//YouTubeからデータを取得
procedure TMainWnd.GetYouTubeDataExecute(Sender: TObject);
var
  URI: String;
  LabelWord: String;
begin
  if Sender = nil then
    exit;
  if not ActionSearchBarSearch.Enabled then
    exit;

  ActionSearchBarSearch.Enabled := false;
  ActionSearchBarSearch2.Enabled := false;
  ActionSearchBarAdd100.Enabled := false;

  MenuSearchNicoVideo.Enabled := false;
  MenuSearchYouTube.Enabled := false;

  PanelBrowser.Visible := false;
  PanelListView.Visible := true;
  ActionSearchBarToggleListView.Checked := false;
  ActionSearchBarToggleListView.Enabled := false;

  ClearSearchList;
  SearchPage := 1;
  if not ActionToggleSearchPanel.Checked then
    ActionToggleSearchPanel.Execute;
  case TSpTBXItem(Sender).Tag of
    10:  URI := YOUTUBE_GET_FEATURED_ALL_URI + '?';
    20:  URI := YOUTUBE_GET_POPULAR_ALL_URI_FRONT + '?time=today';
    21:  URI := YOUTUBE_GET_POPULAR_ALL_URI_FRONT + '?time=this_week';
    22:  URI := YOUTUBE_GET_POPULAR_ALL_URI_FRONT + '?time=this_month';
    23:  URI := YOUTUBE_GET_POPULAR_ALL_URI_FRONT + '?time=all_time';
    else exit;
  end;
  URI := URI + '&start-index=1&max-results=50';
  case TSpTBXItem(Sender).Tag of
    10:  LabelWord := 'YouTube - 注目の動画';
    20:  LabelWord := 'YouTube - 人気の動画(本日分)';
    21:  LabelWord := 'YouTube - 人気の動画(今週)';
    22:  LabelWord := 'YouTube - 人気の動画(今月)';
    23:  LabelWord := 'YouTube - 人気の動画(全期間)';
  end;

  tmpSearchURI := '';
  tmpSearchWord := LabelWord;
  SearchType := 10;
  NicoVideoRetryCount := 0;
  Log(LabelWord + '取得開始');
  SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   <取得中>';
  Log('');
  procGet3 := AsyncManager.Get(URI, OnYouTubeSearch);
  tmpSearchURI := URI;
end;

//YouTubeのウェブサイトからデータを取得
procedure TMainWnd.GetYouTubeDataFromSiteExecute(Sender: TObject);
var
  URI: String;
  LabelWord: String;
  Category: String;
begin
  if Sender = nil then
    exit;
  if not ActionSearchBarSearch.Enabled then
    exit;

  ActionSearchBarSearch.Enabled := false;
  ActionSearchBarSearch2.Enabled := false;
  ActionSearchBarAdd100.Enabled := false;

  MenuSearchNicoVideo.Enabled := false;
  MenuSearchYouTube.Enabled := false;

  PanelBrowser.Visible := false;
  PanelListView.Visible := true;
  ActionSearchBarToggleListView.Checked := false;
  ActionSearchBarToggleListView.Enabled := false;

  ClearSearchList;
  SearchPage := 1;

  if not ActionToggleSearchPanel.Checked then
    ActionToggleSearchPanel.Execute;

  case TSpTBXItem(Sender).Tag of
    100: URI := YOUTUBE_GET_RECENT_URI;
    110..113: URI := YOUTUBE_GET_POPULAR_URI_FRONT;
    120..123: URI := YOUTUBE_GET_RATED_URI_FRONT;
    130..133: URI := YOUTUBE_GET_DISCUSSED_URI_FRONT;
    140..143: URI := YOUTUBE_GET_FAVORITES_URI_FRONT;
    150..153: URI := YOUTUBE_GET_LINKED_URI_FRONT;
    160..163: URI := YOUTUBE_GET_RESPONDED_URI_FRONT;
    else exit;
  end;

  case Config.optSearchVideosYouTubeCategory of
    2:  URI := URI + '/-/Autos';
    23: URI := URI + '/-/Comedy';
    24: URI := URI + '/-/Entertainment';
    1:  URI := URI + '/-/Film';
    20: URI := URI + '/-/Games';
    26: URI := URI + '/-/Howto';
    10: URI := URI + '/-/Music';
    25: URI := URI + '/-/News';
    22: URI := URI + '/-/People';
    15: URI := URI + '/-/Animals';
    17: URI := URI + '/-/Sports';
    19: URI := URI + '/-/Travel';
  end;

  if TSpTBXItem(Sender).Tag <> 100 then
  begin
    case (TSpTBXItem(Sender).Tag mod 10) of
      0: URI := URI + '?time=today&';
      1: URI := URI + '?time=this_week&';
      2: URI := URI + '?time=this_month&';
      3: URI := URI + '?time=all_time&';
    end;
  end
  else
    URI := URI + '?';

  URI := URI + 'start-index=1&max-results=50';

  case Config.optSearchVideosYouTubeCategory of
    0:  Category := '[すべて]';
    2:  Category := '[自動車と乗り物]';
    23: Category := '[コメディー]';
    24: Category := '[エンターテイメント]';
    1:  Category := '[映画とアニメ]';
    20: Category := '[ゲームとガジェット]';
    26: Category := '[ハウツー DIY]';
    10: Category := '[音楽]';
    25: Category := '[ニュースと政治]';
    22: Category := '[ブログと人]';
    15: Category := '[ペットと動物]';
    17: Category := '[スポーツ]';
    19: Category := '[旅行と訪問スポット]';
  end;

  case TSpTBXItem(Sender).Tag of
    100:  LabelWord := 'YouTube - 新着動画(日本)' + Category;
    110:  LabelWord := 'YouTube - 人気の動画(日本)' + Category + '(本日分)';
    111:  LabelWord := 'YouTube - 人気の動画(日本)' + Category + '(今週)';
    112:  LabelWord := 'YouTube - 人気の動画(日本)' + Category + '(今月)';
    113:  LabelWord := 'YouTube - 人気の動画(日本)' + Category + '(全期間)';
    120:  LabelWord := 'YouTube - 評価の高い動画(日本)' + Category + '(本日分)';
    121:  LabelWord := 'YouTube - 評価の高い動画(日本)' + Category + '(今週)';
    122:  LabelWord := 'YouTube - 評価の高い動画(日本)' + Category + '(今月)';
    123:  LabelWord := 'YouTube - 評価の高い動画(日本)' + Category + '(全期間)';
    130:  LabelWord := 'YouTube - 話題の動画(日本)' + Category + '(本日分)';
    131:  LabelWord := 'YouTube - 話題の動画(日本)' + Category + '(今週)';
    132:  LabelWord := 'YouTube - 話題の動画(日本)' + Category + '(今月)';
    133:  LabelWord := 'YouTube - 話題の動画(日本)' + Category + '合計)';
    140:  LabelWord := 'YouTube - お気に入り登録の多い動画(日本)' + Category + '(本日分)';
    141:  LabelWord := 'YouTube - お気に入り登録の多い動画(日本)' + Category + '(今週)';
    142:  LabelWord := 'YouTube - お気に入り登録の多い動画(日本)' + Category + '(今月)';
    143:  LabelWord := 'YouTube - お気に入り登録の多い動画(日本)' + Category + '(全期間)';
    150:  LabelWord := 'YouTube - リンク数の多い動画(日本)' + Category + '(本日分)';
    151:  LabelWord := 'YouTube - リンク数の多い動画(日本)' + Category + '(今週)';
    152:  LabelWord := 'YouTube - リンク数の多い動画(日本)' + Category + '(今月)';
    153:  LabelWord := 'YouTube - リンク数の多い動画(日本)' + Category + '(全期間)';
    160:  LabelWord := 'YouTube - コメントの多い動画(日本)' + Category + '(本日分)';
    161:  LabelWord := 'YouTube - コメントの多い動画(日本)' + Category + '(今週)';
    162:  LabelWord := 'YouTube - コメントの多い動画(日本)' + Category + '(今月)';
    163:  LabelWord := 'YouTube - コメントの多い動画(日本)' + Category + '(全期間)';
  end;
  tmpSearchURI := '';
  tmpSearchWord := LabelWord;
  SearchType := 20;
  Log(LabelWord + '取得開始');
  SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   <取得中>';
  Log('');
  procGet3 := AsyncManager.Get(URI, OnYouTubeSearch);
  tmpSearchURI := URI;
end;

//YouTubeのデータ(サイト内検索)を処理する
procedure TMainWnd.OnYouTubeGetSearchResults(sender: TAsyncReq);
var
  i: integer;
  TotalCount: String;
  ContentList: TStringList;
  SearchDataList: TStringList;
  tmpSearchData: String;
  LabelWord: String;
  DataStart: boolean;
  Matches: MatchCollection;
  tmp, min, sec: String;
  IsNext: boolean;
  s_rating: string;
  e_rating: Extended;
  i_rating: integer;
const
  GET_TOTALCOUNT        = ' / <strong>([\d,]+)<';
  GET_VIDEO_ID          = '\/watch\?v=([^"]+)"';
  GET_VIDEO_TITLE       = 'title="([^"]+)"';
  GET_THUMBNAIL_URL1    = 'src="([^"]+)"';
  GET_PLAYTIME_SECONDS  = '(\d+):(\d+)';
  GET_AUTHOR            = 'href="/user/([^"]+)"';
  GET_VIEW_COUNT        = '再生回数 ([\d,]+)';
  //GET_RATIONG_COUNT     = 'ratingCount">([\d,]+)[ ]?件の評価';
  GET_RATIONG            = 'ratingVS-([^"]+)"';
  GET_UPLOAD_TIME_MI_AGO = '>(\d+)[ ]?分前';
  GET_UPLOAD_TIME_H_AGO  = '>(\d+)[ ]?時間前';
  GET_UPLOAD_TIME_D_AGO  = '>(\d+)[ ]?日前';
  GET_UPLOAD_TIME_W_AGO  = '>(\d+)[ ]?週前';
  GET_UPLOAD_TIME_MO_AGO  = '>(\d+)[ ]?か?月前';
  GET_UPLOAD_TIME_Y_AGO  = '>(\d+)[ ]?年前';
  GET_UPLOAD_TIME        = '(\d{10})'; //UNIXTIME

  GET_NEXT = '次へ</a>';
begin
  if procGet3 = sender then
  begin

    Log('【YouTube(OnYouTubeGetSearchResults)】' + sender.IdHTTP.ResponseText);
    IsNext := false;
    case sender.IdHTTP.ResponseCode of
    200: (* OK *)
      begin
        if Config.optSearchTarget = 100 then
        begin
          LabelWord := 'YouTube(サイト内検索) ';
          case Config.optSearchYouTubeSort of
            0: LabelWord := LabelWord + '[関連度]';
            1: LabelWord := LabelWord + '[追加日]';
            2: LabelWord := LabelWord + '[再生回数]';
            3: LabelWord := LabelWord + '[評価]';
          end;
          case Config.optSearchYouTubeCategory of
            0:  LabelWord := LabelWord + '[すべて] ';
            2:  LabelWord := LabelWord + '[自動車と乗り物] ';
            23: LabelWord := LabelWord + '[コメディー] ';
            24: LabelWord := LabelWord + '[エンターテイメント] ';
            1:  LabelWord := LabelWord + '[映画とアニメ] ';
            20: LabelWord := LabelWord + '[ゲームとガジェット] ';
            26: LabelWord := LabelWord + '[ハウツー DIY] ';
            10: LabelWord := LabelWord + '[音楽] ';
            25: LabelWord := LabelWord + '[ニュースと政治] ';
            22: LabelWord := LabelWord + '[ブログと人] ';
            15: LabelWord := LabelWord + '[ペットと動物] ';
            17: LabelWord := LabelWord + '[スポーツ] ';
            19: LabelWord := LabelWord + '[旅行と訪問スポット] ';
          end;
        end;
        Log('データ分析開始');

        ContentList := TStringList.Create;
        SearchDataList := TStringList.Create;
        try
          ContentList.Text := procGet3.Content;
          DataStart := false;
          tmpSearchData := '';
          IsNext := false;
          for i := 0 to ContentList.Count -1 do
          begin
            ContentList[i] := UTF8toAnsi(ContentList[i]);
            if not IsNext and (AnsiPos(GET_NEXT, ContentList[i]) > 0) then
              IsNext := True;

            if not DataStart and (AnsiPos('<div class="video-entry">', ContentList[i]) > 0) then
            begin
              DataStart := True;
              tmpSearchData := ContentList[i];
            end else if DataStart and (AnsiPos('<div class="video-entry">', ContentList[i]) > 0) then
            begin
              SearchDataList.Add(tmpSearchData);
              tmpSearchData := ContentList[i];
            end else if DataStart and (AnsiPos('<!-- end search results -->', ContentList[i]) > 0) then
            begin
              DataStart := false;
              SearchDataList.Add(tmpSearchData);
              tmpSearchData := '';
            end else if DataStart then
            begin
              tmpSearchData := tmpSearchData + ContentList[i];
            end;

            if Length(TotalCount) = 0 then
            begin
              RegExp.Pattern := GET_TOTALCOUNT;
              begin
                try
                  if RegExp.Test(ContentList[i]) then
                  begin
                    Matches := RegExp.Execute(ContentList[i]) as MatchCollection;
                    TotalCount := AnsiString(Match(Matches.Item[0]).Value);
                    if Length(TotalCount) > 0 then
                    begin
                      TotalCount := '/' + RegExp.Replace(TotalCount, '$1');
                      TotalCount := CustomStringReplace(TotalCount, ',', '');
                    end;
                  end;
                except
                  TotalCount := '';
                end;
              end;
            end;
          end;

          if SearchDataList.Count > 0 then
          begin
            for i := 0 to SearchDataList.Count -1 do
            begin
              tmpSearchData := SearchDataList.Strings[i];
              SearchList.Add(TSearchData.Create);
              with TSearchData(SearchList.Last) do
              begin
                video_type := 0;
                RegExp.Pattern := GET_VIDEO_TITLE; //タイトル
                begin
                  try
                    if RegExp.Test(tmpSearchData) then
                    begin
                      Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                      video_title := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(video_title) > 0 then
                        video_title := RegExp.Replace(video_title, '$1');
                      video_title := CustomStringReplace(video_title,  '&quot;', '"');
                      video_title := CustomStringReplace(video_title,  '&amp;', '&');
                      video_title := CustomStringReplace(video_title,  '&lt; ', '<');
                      video_title := CustomStringReplace(video_title,  '&gt;', '>');
                      //Log(video_title);
                    end;
                  except
                    video_title := '';
                  end;
                end;
                RegExp.Pattern := GET_VIDEO_ID; //ビデオID
                begin
                  try
                    if RegExp.Test(tmpSearchData) then
                    begin
                      Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                      video_id := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(video_id) > 0 then
                        video_id := RegExp.Replace(video_id, '$1');
                      //Log(video_id);
                    end;
                  except
                    video_id := '';
                  end;
                end;
                RegExp.Pattern := GET_PLAYTIME_SECONDS; //再生時間
                begin
                  try
                    if RegExp.Test(tmpSearchData) then
                    begin
                      Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                      playtime := AnsiString(Match(Matches.Item[0]).Value);
                      //Log(playtime);
                      tmp := playtime;
                      if Length(tmp) > 0 then
                      begin
                        min := RegExp.Replace(tmp, '$1');
                        sec := RegExp.Replace(tmp, '$2');
                        if (Length(min) > 0) and (Length(sec) > 0) then
                        try
                          playtime_seconds := IntToStr(StrToInt(min)*60 + StrToInt(sec));
                        except
                          playtime_seconds := ''
                        end;
                      end;
                      //Log(playtime_seconds);
                    end;
                  except
                  end;
                end;
                RegExp.Pattern := GET_VIEW_COUNT; //再生回数
                begin
                  try
                    if RegExp.Test(tmpSearchData) then
                    begin
                      Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                      view_count := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(view_count) > 0 then
                      begin
                        view_count := RegExp.Replace(view_count, '$1');
                        view_count := CustomStringReplace(view_count,  ',', '');
                      end;
                      //Log(view_count);
                    end;
                  except
                    view_count := '';
                  end;
                end;
                (*
                RegExp.Pattern := GET_RATIONG_COUNT; //評価数
                begin
                  try
                    if RegExp.Test(tmpSearchData) then
                    begin
                      Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                      rationg_count := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(rationg_count) > 0 then
                      begin
                        rationg_count := RegExp.Replace(rationg_count, '$1');
                        rationg_count := CustomStringReplace(rationg_count,  ',', '');
                      end;
                      //Log(rationg_count);
                    end;
                  except
                    rationg_count := '';
                  end;
                end;
                *)
                RegExp.Pattern := GET_AUTHOR;  //ユーザー名
                begin
                  try
                    if RegExp.Test(tmpSearchData) then
                    begin
                      Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                      author := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(author) > 0 then
                      begin
                        author := RegExp.Replace(author, '$1');
                      end;
                      //Log(author);
                    end;
                  except
                    author := '';
                  end;
                end;
                if Length(author) > 0 then
                  author_link := '<a href="' + YOUTUBE_USER_PROFILE_URI + author +'">' + author + '</a>';
                RegExp.Pattern := GET_THUMBNAIL_URL1;  //サムネイル
                begin
                  try
                    if RegExp.Test(tmpSearchData) then
                    begin
                      Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                      thumbnail_url1 := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(thumbnail_url1) > 0 then
                      begin
                        thumbnail_url1 := RegExp.Replace(thumbnail_url1, '$1');
                      end;
                      //Log(thumbnail_url1);
                    end;
                  except
                    thumbnail_url1 := '';
                  end;
                end;
                if Length(thumbnail_url1) > 0 then
                begin
                  thumbnail_url2 := CustomStringReplace(thumbnail_url1, '/default.jpg', '/2.jpg');
                  thumbnail_url3 := CustomStringReplace(thumbnail_url1, '/default.jpg', '/3.jpg');
                  thumbnail_url1 := CustomStringReplace(thumbnail_url1, '/default.jpg', '/1.jpg');
                end;
                //レイティング
                s_rating := '';
                e_rating := 0;
                RegExp.Pattern := GET_RATIONG;
                begin
                  try
                    if RegExp.Test(tmpSearchData) then
                    begin
                      Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                      s_rating := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(s_rating) > 0 then
                      begin
                        s_rating := RegExp.Replace(s_rating, '$1');
                        TextToFloat(PChar(s_rating), e_rating, fvExtended);
                      end;
                    end;
                  except
                    s_rating := '';
                    e_rating := 0;
                  end;
                end;
                rating_avg := s_rating;
                i_rating := Round(e_rating);
                case i_rating of
                  0:   rating := '☆☆☆☆☆';
                  1:   rating := '★☆☆☆☆';
                  2:   rating := '★★☆☆☆';
                  3:   rating := '★★★☆☆';
                  4:   rating := '★★★★☆';
                  else rating := '★★★★★';
                end;
                //アップロード時間
                RegExp.Pattern := GET_UPLOAD_TIME_MI_AGO;
                begin
                  try
                    if RegExp.Test(tmpSearchData) then
                    begin
                      Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                      upload_unixtime := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(upload_unixtime) > 0 then
                      begin
                        upload_unixtime := RegExp.Replace(upload_unixtime, '$1');
                      end;
                      upload_unixtime := IntToStr(DateTimeToUnix(now) - StrToInt(upload_unixtime) * 60);
                      //Log(upload_unixtime);
                    end;
                  except
                    upload_unixtime := '';
                  end;
                end;
                if Length(upload_unixtime) = 0 then
                begin
                  RegExp.Pattern := GET_UPLOAD_TIME_H_AGO;
                  begin
                    try
                      if RegExp.Test(tmpSearchData) then
                      begin
                        Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                        upload_unixtime := AnsiString(Match(Matches.Item[0]).Value);
                        if Length(upload_unixtime) > 0 then
                        begin
                          upload_unixtime := RegExp.Replace(upload_unixtime, '$1');
                        end;
                        upload_unixtime := IntToStr(DateTimeToUnix(now) - StrToInt(upload_unixtime) * 60 * 60);
                        //Log(upload_unixtime);
                      end;
                    except
                      upload_unixtime := '';
                    end;
                  end;
                end;
                if Length(upload_unixtime) = 0 then
                begin
                  RegExp.Pattern := GET_UPLOAD_TIME_D_AGO;
                  begin
                    try
                      if RegExp.Test(tmpSearchData) then
                      begin
                        Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                        upload_unixtime := AnsiString(Match(Matches.Item[0]).Value);
                        if Length(upload_unixtime) > 0 then
                        begin
                          upload_unixtime := RegExp.Replace(upload_unixtime, '$1');
                        end;
                        upload_unixtime := IntToStr(DateTimeToUnix(now) - StrToInt(upload_unixtime) * 60 * 60 * 24);
                        //Log(upload_unixtime);
                      end;
                    except
                      upload_unixtime := '';
                    end;
                  end;
                end;
                if Length(upload_unixtime) = 0 then
                begin
                  RegExp.Pattern := GET_UPLOAD_TIME_W_AGO;
                  begin
                    try
                      if RegExp.Test(tmpSearchData) then
                      begin
                        Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                        upload_unixtime := AnsiString(Match(Matches.Item[0]).Value);
                        if Length(upload_unixtime) > 0 then
                        begin
                          upload_unixtime := RegExp.Replace(upload_unixtime, '$1');
                        end;
                        upload_unixtime := IntToStr(DateTimeToUnix(now) - StrToInt(upload_unixtime) * 60 * 60 * 24 * 7);
                        //Log(upload_unixtime);
                      end;
                    except
                      upload_unixtime := '';
                    end;
                  end;
                end;
                if Length(upload_unixtime) = 0 then
                begin
                  RegExp.Pattern := GET_UPLOAD_TIME_MO_AGO;
                  begin
                    try
                      if RegExp.Test(tmpSearchData) then
                      begin
                        Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                        upload_unixtime := AnsiString(Match(Matches.Item[0]).Value);
                        if Length(upload_unixtime) > 0 then
                        begin
                          upload_unixtime := RegExp.Replace(upload_unixtime, '$1');
                        end;
                        upload_unixtime := IntToStr(DateTimeToUnix(now) - StrToInt(upload_unixtime) * 60 * 60 * 24 * 30);
                        //Log(upload_unixtime);
                      end;
                    except
                      upload_unixtime := '';
                    end;
                  end;
                end;
                if Length(upload_unixtime) = 0 then
                begin
                  RegExp.Pattern := GET_UPLOAD_TIME_Y_AGO;
                  begin
                    try
                      if RegExp.Test(tmpSearchData) then
                      begin
                        Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                        upload_unixtime := AnsiString(Match(Matches.Item[0]).Value);
                        if Length(upload_unixtime) > 0 then
                        begin
                          upload_unixtime := RegExp.Replace(upload_unixtime, '$1');
                        end;
                        upload_unixtime := IntToStr(DateTimeToUnix(now) - StrToInt(upload_unixtime) * 60 * 60 * 24 * 365);
                        //Log(upload_unixtime);
                      end;
                    except
                      upload_unixtime := '';
                    end;
                  end;
                end;
                if Length(upload_unixtime) = 0 then
                begin
                  RegExp.Pattern := GET_UPLOAD_TIME; //アップロードされた時間
                  begin
                    try
                      if RegExp.Test(tmpSearchData) then
                      begin
                        Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                        upload_unixtime := AnsiString(Match(Matches.Item[0]).Value);
                        if Length(upload_unixtime) > 0 then
                        begin
                          upload_unixtime := RegExp.Replace(upload_unixtime, '$1');
                          upload_unixtime := CustomStringReplace(upload_unixtime,  ',', '');
                        end;
                        //Log(upload_unixtime);
                      end;
                    except
                      upload_unixtime := '';
                    end;
                  end;
                end;  
                if Length(upload_unixtime) > 0 then
                  upload_time := UnixTime2String(upload_unixtime);
              end;
            end;
          end;
        finally
          ContentList.Free;
          SearchDataList.Free;
        end;
        Log('データ分析完了');

        ListView.List := SearchList;
        currentSortColumn := high(integer);
        if SearchList.Count > 0 then
        begin
          SpTBXDockablePanelSearch.Caption := LabelWord + '[' + tmpSearchWord + ']   [1-' + IntToStr(SearchList.Count) + TotalCount + ']';
          ActionSearchBarToggleListView.Enabled := true;
        end else
          SpTBXDockablePanelSearch.Caption := LabelWord + '[' + tmpSearchWord + ']   <該当データなし>';
        Log('取得完了');

      end;
    else
      begin
        SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   <取得失敗>';
        Log('データの取得に失敗しました。');
      end;
    end;
    procGet3 := nil;
    ActionSearchBarSearch.Enabled := True;
    ActionSearchBarSearch2.Enabled := True;
    if IsNext then
      ActionSearchBarAdd100.Enabled := true
    else
      ActionSearchBarAdd100.Enabled := false;
    MenuSearchNicoVideo.Enabled := true;
    MenuSearchYouTube.Enabled := true;
  end;
end;

//IEのプライバシー設定を中に変更する
function TMainWnd.IsPrivacyZoneOK: boolean;
const
  URLZONE_INTERNET = 3;
  PRIVACY_TYPE_FIRST_PARTY = 0;
  PRIVACY_TYPE_THIRD_PARTY = 1;
  PRIVACY_TEMPLATE_NO_COOKIES = 0;
  PRIVACY_TEMPLATE_HIGH  = 1;
  PRIVACY_TEMPLATE_MEDIUM_HIGH = 2;
  PRIVACY_TEMPLATE_MEDIUM = 3;
  PRIVACY_TEMPLATE_MEDIUM_LOW = 4;
  PRIVACY_TEMPLATE_LOW = 5;
  PRIVACY_TEMPLATE_CUSTOM = 100;
  PRIVACY_TEMPLATE_ADVANCED = 101;
var
  dwCookie1,BufLen: DWORD;
begin
  result := false;
  dwCookie1 := 0;
  BufLen := 0;
  PrivacyGetZonePreferenceW(URLZONE_INTERNET, PRIVACY_TYPE_FIRST_PARTY, @dwCookie1, nil, @BufLen);
  if (dwCookie1 in [PRIVACY_TEMPLATE_MEDIUM_HIGH, PRIVACY_TEMPLATE_MEDIUM, PRIVACY_TEMPLATE_MEDIUM_LOW, PRIVACY_TEMPLATE_LOW]) then
  begin
    result := True;
  end else
  begin
    MessageBeep(MB_ICONEXCLAMATION);
    if MessageDlg('Cookieを取得するため、IEのプライバシー設定を中に変更します。' + #13#10 + 'よろしいですか？' , mtWarning, mbOKCancel, -1) = mrOK then
    begin
      PrivacySetZonePreferenceW(URLZONE_INTERNET, PRIVACY_TYPE_FIRST_PARTY, PRIVACY_TEMPLATE_MEDIUM, nil);
      PrivacySetZonePreferenceW(URLZONE_INTERNET, PRIVACY_TYPE_THIRD_PARTY, PRIVACY_TEMPLATE_MEDIUM, nil);
      Log('IEのプライバシー設定を中に変更しました。');
      result := True;
      //MessageBeep(MB_ICONASTERISK);
    end;
  end;
end;

//最近視聴した動画に追加する
procedure TMainWnd.AddRecentlyViewed(const Title: String; VideoID: String; Location: String);
var
  s: String;
  i: Integer;
begin
  if Config.optRecentlyViewedCount <= 0 then
    exit;
  s := Title + #9 + VideoID + #9 + Location;
  with RecentlyViewedVideos do
  begin
    i := IndexOf(s);
    if i = 0 then
      exit;
    if 0 < i then
      Delete(i);
    while Config.optRecentlyViewedCount <= Count do
      Delete(Count -1);
    Insert(0, s);
  end;
end;

//最近視聴した動画を視聴する
procedure TMainWnd.RecentlyViewedClick(Sender: TObject);
var
  i: integer;
  VideoData: TStringList;
  URI: String;
begin
  i := TSpTBXItem(Sender).Tag;
  if (0 <= i) and (i <= RecentlyViewedVideos.Count -1) then
  begin
    VideoData := TStringList.Create;
    SetTabTextToStrings(VideoData, RecentlyViewedVideos[i]);
    if SameText('YouTube', VideoData[2]) then
      URI := YOUTUBE_GET_WATCH_URI
    else if SameText('nicovideo', VideoData[2]) then
      URI := NICOVIDEO_GET_URI
    else if SameText('nicovideo2', VideoData[2]) then
      URI := NICOVIDEO_URI + '?p=';
    URI := URI + VideoData[1];

    VideoData.Free;
    RecentlyViewedVideos.Delete(i);
    SetURIwithClear(URI);
  end;
end;

//最近視聴した動画をメニューに構築する
procedure TMainWnd.MenuFileClick(Sender: TObject);
var
  i: Integer;
  VideoData: TStringList;
  menuItem: TSpTBXItem;
  num: String;
begin
  MenuFileRecentlyViewed.Clear;
  if RecentlyViewedVideos.Count > 0 then
  begin
    MenuFileRecentlyViewed.Enabled := True;
    VideoData := TStringList.Create;
    try
      for i := 0 to RecentlyViewedVideos.Count -1 do
      begin
        VideoData.Clear;
        SetTabTextToStrings(VideoData, RecentlyViewedVideos[i]);
        menuItem := TSpTBXItem.Create(MenuFileRecentlyViewed);
        MenuFileRecentlyViewed.Add(menuItem);
        if i > 8 then
          num := IntToStr(i+1)
        else
          num := '&' + IntToStr(i+1);
        menuItem.Caption := num + ' ' + CustomStringReplace(VideoData[0], '&', '&&');
        menuItem.Tag := i;
        menuItem.OnClick := RecentlyViewedClick;
        if SameText('YouTube', VideoData[2]) then
          menuItem.ImageIndex := 13
        else if SameText('nicovideo', VideoData[2]) or SameText('nicovideo2', VideoData[2]) then
          menuItem.ImageIndex := 14;
      end;
    finally
      VideoData.Free;
    end;
  end else
    MenuFileRecentlyViewed.Enabled := False;
end;

//ビデオパネルのリサイズ
procedure TMainWnd.PanelResize(Sender: TObject);
var
  wScale, hScale: integer;
  Scale: Integer;
begin
  if WebBrowser.Document = nil then
    exit;
  if (VideoData.video_type in [1..5]) then //ニコニコ動画
  begin
    if Config.optChangeVideoScale then
    begin
      wScale := Trunc(Panel.Width  * 100 div Config.optNicoVideoWidthVideo);
      hScale := Trunc(Panel.Height * 100 div Config.optNicoVideoHeightVideo);
      if wScale > hScale then
        Scale := hScale
      else
        Scale := wScale;
      if Scale > 1000 then
        Scale := 1000
      else if Scale < 20 then
        Scale := 20;

      try
        IHTMLDocument2(WebBrowser.Document).body.style.setAttribute(
          'zoom', IntToStr(Scale) + '%',0);
      except
      end;
    end else
    begin
      try
        IHTMLDocument2(WebBrowser.Document).body.style.setAttribute(
          'zoom', '100%',0);
      except
      end;
    end;
  end;
end;

//「ビデオスケールを変更する」設定の切り替え(ニコニコ動画用)
procedure TMainWnd.ActionChangeVideoScaleExecute(Sender: TObject);
begin
  if Self.Visible then
  begin
    Config.optChangeVideoScale := not Config.optChangeVideoScale;
    Config.Modified := True;
    PanelResize(Self);
  end;
  ActionChangeVideoScale.Checked := Config.optChangeVideoScale;
end;

//開いているビデオを再取得
procedure TMainWnd.ActionRefreshExecute(Sender: TObject);
var
  URI: String;
begin
  if Length(tmpURI) <= 0 then
    exit;
  URI := tmpURI;
  SetURIwithClear(URI);
end;

//最近視聴した動画をメニューに構築する(カスタマイズ機能から)
procedure TMainWnd.CustomRecentlyViewedClick(Sender: TObject);
var
  i: Integer;
  VideoData: TStringList;
  menuItem: TSpTBXItem;
  num: String;
begin
  CustomRecentlyViewed.Clear;
  if RecentlyViewedVideos.Count > 0 then
  begin
    VideoData := TStringList.Create;
    try
      for i := 0 to RecentlyViewedVideos.Count -1 do
      begin
        VideoData.Clear;
        SetTabTextToStrings(VideoData, RecentlyViewedVideos[i]);
        menuItem := TSpTBXItem.Create(CustomRecentlyViewed);
        CustomRecentlyViewed.Add(menuItem);
        if i > 8 then
          num := IntToStr(i+1)
        else
          num := '&' + IntToStr(i+1);
        menuItem.Caption := num + ' ' + CustomStringReplace(VideoData[0], '&', '&&');
        menuItem.Tag := i;
        menuItem.OnClick := RecentlyViewedClick;
        if SameText('YouTube', VideoData[2]) then
          menuItem.ImageIndex := 13
        else if SameText('nicovideo', VideoData[2]) or SameText('nicovideo2', VideoData[2]) then
          menuItem.ImageIndex := 14;
        menuItem.Images := ImageList;
      end;
    finally
      VideoData.Free;
    end;
  end;
end;

//最近視聴した動画の履歴を削除
procedure TMainWnd.ActionClearRecentlyViewedExecute(Sender: TObject);
begin
   if (RecentlyViewedVideos = nil) or (RecentlyViewedVideos.Count < 1) then
   begin
     ShowMessage('最近視聴した動画の履歴はありません');
     exit;
   end;

   MessageBeep(MB_ICONEXCLAMATION);
   if MessageDlg('最近視聴した動画の履歴を消去します。よろしいですか？', mtWarning, mbOKCancel, -1) = mrOK then
   begin
     RecentlyViewedVideos.Clear;
     SysUtils.DeleteFile(Config.BasePath + RECENTLY_VIEWED_DAT);
     MessageBeep(MB_ICONASTERISK);
   end;
end;

//ビデオのタイトルをコピーする
procedure TMainWnd.ActionCopyTitleExecute(Sender: TObject);
begin
  if Length(VideoData.video_title) > 0 then
    Clipboard.AsText := VideoData.video_title;
end;

//タイトルをコピー(リストから)
procedure TMainWnd.ActionListPopupCopyTitleExecute(Sender: TObject);
var
  item: TListItem;
  SearchData: TSearchData;
  tmpstring: String;
begin
  item := ListView.Selected;
  if item = nil then
    exit;
  if ListView.SelCount > 1 then
  begin
    SearchData := nil;
    tmpstring := '';
    while (item <> nil) and (item.Data <> SearchData) do
    begin
      SearchData := TSearchData(item.Data);
      tmpstring := tmpstring + CustomStringReplace(SearchData.video_title,  '&#039;', '''') + #13#10;
      //tmpstring := tmpstring + SearchData.video_title + #13#10;
      item := ListView.GetNextItem(item, sdBelow, [isSelected]);
    end;
    Clipboard.AsText := TrimRight(tmpstring);
  end else
  begin
    SearchData := TSearchData(item.Data);
    if SearchData = nil then
      exit;
    Clipboard.AsText := CustomStringReplace(SearchData.video_title,  '&#039;', '''');
    //Clipboard.AsText := SearchData.video_title;
  end;
end;

//検索＞YouTubeの「カテゴリ設定」を設定する
procedure TMainWnd.SetYouTubeCategoryExecute(Sender: TObject);
begin
  Config.optSearchVideosYouTubeCategory := TComponent(Sender).Tag;
  Config.Modified := True;
end;

//検索＞YouTubeの「カテゴリ設定」にチェックを付ける
procedure TMainWnd.MenuSearchYouTubeCategorySettingClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to MenuSearchYouTubeCategorySetting.Count -1 do
  begin
    MenuSearchYouTubeCategorySetting[i].Checked := (Config.optSearchVideosYouTubeCategory = MenuSearchYouTubeCategorySetting[i].Tag);
  end;
end;

//YouTubeの「ソート」にチェックを付ける
procedure TMainWnd.MenuSearchToggleSearchTargetYouTubeSettingSortClick(
  Sender: TObject);
var
  i: integer;
begin
  for i := 0 to MenuSearchToggleSearchTargetYouTubeSettingSort.Count -1 do
  begin
    MenuSearchToggleSearchTargetYouTubeSettingSort[i].Checked := (Config.optSearchYouTubeSort = MenuSearchToggleSearchTargetYouTubeSettingSort[i].Tag);
  end;
end;

//YouTube設定の「ソート」を設定する
procedure TMainWnd.MenuSearchToggleSearchTargetYouTubeSettingSortExecute(Sender: TObject);
begin
  Config.optSearchYouTubeSort := TComponent(Sender).Tag;
  Config.Modified := True;
end;

//YouTube設定の「カテゴリ」にチェックを付ける
procedure TMainWnd.MenuSearchToggleSearchTargetYouTubeSettingCategoryClick(
  Sender: TObject);
var
  i: integer;
begin
  for i := 0 to MenuSearchToggleSearchTargetYouTubeSettingCategory.Count -1 do
  begin
    MenuSearchToggleSearchTargetYouTubeSettingCategory[i].Checked := (Config.optSearchYouTubeCategory = MenuSearchToggleSearchTargetYouTubeSettingCategory[i].Tag);
  end;
end;

//YouTube設定の「カテゴリ」を設定する
procedure TMainWnd.MenuSearchToggleSearchTargetYouTubeSettingCategoryExecute(
  Sender: TObject);
begin
  Config.optSearchYouTubeCategory := TComponent(Sender).Tag;
  Config.Modified := True;
end;

//YouTubeからログアウト
procedure TMainWnd.ActionLogOutFromYouTubeExecute(Sender: TObject);
var
  logoutURL, flag, target, PostData, Headers: OleVariant;
  Data: Pointer;
  strPostData: string;
begin
  MessageBeep(MB_ICONEXCLAMATION);
  if MessageDlg('YouTubeからログアウトします。よろしいですか？', mtWarning, mbOKCancel, -1) = mrOK then
  begin
    Log('');
    Log('YouTubeログアウト開始');
    ActionClearVideoPanelExecute(nil);
    tmpURI := YOUTUBE_LOGOUT_URI;
    logoutURL := YOUTUBE_LOGOUT_URI;
    flag := EmptyParam;
    target := EmptyParam;
    strPostData  := '&action_logout=1';
    PostData := VarArrayCreate([0, Length(strPostData) - 1], varByte);
    Data := VarArrayLock(PostData);
    try
      Move(strPostData[1], Data^, Length(strPostData));
    finally
      VarArrayUnlock(PostData);
    end;
    Headers := 'Content-Type: application/x-www-form-urlencoded';
    WebBrowser.Navigate2(logoutURL, flag, target, PostData, Headers);
  end;
end;

//ニコニコ動画からログアウト
procedure TMainWnd.ActionLogOutNicoVideoExecute(Sender: TObject);
var
  logoutURL: OleVariant;
begin
  MessageBeep(MB_ICONEXCLAMATION);
  if MessageDlg('ニコニコ動画からログアウトします。よろしいですか？', mtWarning, mbOKCancel, -1) = mrOK then
  begin
    Log('');
    Log('ニコニコ動画ログアウト開始');
    ActionClearVideoPanelExecute(nil);
    tmpURI := NICOVIDEO_LOGOUT_URI;
    logoutURL := NICOVIDEO_LOGOUT_URI;
    WebBrowser.Navigate2(logoutURL);
  end;
end;

//お気に入りパネルの表示切替
procedure TMainWnd.ActionToggleFavoritePanelExecute(Sender: TObject);
var
  width,height: integer;
begin
  width  := Self.Width - DockLeft.Width - DockLeft2.Width - DockRight.Width - DockRight2.Width;
  height := Self.Height - DockBottom.Height - DockTop.Height;
  if Self.Visible then
  begin
    Config.optShowFavoritePanel := not Config.optShowFavoritePanel;
    Config.Modified := True;
  end;
  SpTBXDockablePanelFavorite.Visible := Config.optShowFavoritePanel;
  ActionToggleFavoritePanel.Checked := Config.optShowFavoritePanel;

  if (Self.WindowState = wsNormal) and (width > 0) and (height > 0) then
  begin
    width  := width + DockLeft.Width + DockLeft2.Width + DockRight.Width + DockRight2.Width;
    height := height + DockBottom.Height + DockTop.Height;
    if (Self.Width <> width) or (Self.height <> height ) then
    begin
      SetBounds(Self.Left, Self.Top, width, height);
      SearchBarComboBox.Width := SearchBarComboBox.Width -1;
      TimerSetSearchBar.Enabled := true;
    end else
    begin
      SetBounds(Self.Left, Self.Top, width, height);
    end;
  end;
end;

//お気に入りパネルを閉じるボタンから閉じたとき用
procedure TMainWnd.SpTBXDockablePanelFavoriteCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  ActionToggleFavoritePanel.Execute;
end;

//お気に入りの表示
procedure TMainWnd.UpdateFavorites;

  procedure AddNodes(parent: PVirtualNode; favs: TFavoriteList);
  var
    node: PVirtualNode;

    i: integer;
    me: PVirtualNode;
    Data: PDataItem;
  begin
    me := VirtualFavoriteView.AddChild(parent);
    Data := VirtualFavoriteView.GetNodeData(me);

    Data^.Title:= favs.name;
    Data^.Data := favs;

    if favs is TFavoriteList then
      Data^.ImageIndex := 17;

    for i := 0 to favs.Count -1 do
    begin
      if TObject(favs.Items[i]) is TFavorite then
      begin
        node := VirtualFavoriteView.AddChild(me);

        Data := VirtualFavoriteView.GetNodeData(node);
        Data^.Title:= (favs.Items[i]).name;
        Data^.Data := TFavoriteList(favs.Items[i]);

        if SameText('YouTube', TFavorite(favs.Items[i]).location) then
        begin
          Data^.ImageIndex := 13;
        end
        else if SameText('nicovideo', TFavorite(favs.Items[i]).location) or
                SameText('nicovideo2', TFavorite(favs.Items[i]).location) then
        begin
          if SameText('mylist', TFavorite(favs.Items[i]).value) then
            Data^.ImageIndex := 11
          else
            Data^.ImageIndex := 14;
        end else
          Data^.ImageIndex := -1;

      end
      else if TObject(favs.Items[i]) is TFavoriteList then
      begin
        AddNodes(me, TFavoriteList(favs.Items[i]));
      end;
    end;
  end;

var
  i: integer;
  vnode,topnode: PVirtualNode;
  Data: PDataItem;
begin
  VirtualFavoriteView.BeginUpdate;
  VirtualFavoriteView.Clear;
  VirtualFavoriteView.NodeDataSize := SizeOf(TDataItem);
  VirtualFavoriteView.RootNodeCount := 0;
  AddNodes(nil, favorites);

  vnode := VirtualFavoriteView.GetFirst;
  VirtualFavoriteView.Expanded[vnode] := true;
  vnode := VirtualFavoriteView.GetNext(vnode);
  topnode := nil;
  i := 1;
  while vnode <> nil do
  begin
    Data := VirtualFavoriteView.GetNodeData(vnode);
    if TObject(Data^.Data) is TFavoriteList then
      VirtualFavoriteView.Expanded[vnode] := TFavoriteList(Data^.Data).expanded;
    if i = favorites.selected then
      VirtualFavoriteView.Selected[vnode] := true;
    if i = favorites.top then
      topnode := vnode;
    vnode := VirtualFavoriteView.GetNext(vnode);
    inc(i);
  end;
  VirtualFavoriteView.EndUpdate;
  if topnode <> nil then
    VirtualFavoriteView.TopNode := topnode;
  UpdateFavoritesMenu;
end;

//お気に入りに追加を階層化
procedure TMainWnd.FavoriteMenuItemCreate(Sender: TSpTBXSubmenuItem; ItemClickEvent :TNotifyEvent);

  procedure AddFavItem(favList: TFavoriteList; parent: TSpTBXSubmenuItem);
  var
    item: TSpTBXItem;
    itemparent: TSpTBXSubmenuItem;
    sep: TSpTBXSeparatorItem;
    i: integer;
    childfavlist: TFavoriteList;
  begin
    for i := 0 to favList.Count -1 do
    begin
      if favList.Items[i] is TFavoriteList then
      begin
        childfavlist := TFavoriteList(favList.Items[i]);
        itemparent := TSpTBXSubmenuItem.Create(parent);
        itemparent.ImageIndex := 17;
        parent.Add(itemparent);
        AddFavItem(childfavlist, itemparent);
      end;
    end;
    if parent.Count > 0 then
    begin
      parent.Caption := CustomStringReplace(favlist.name, '&', '&&');
      item := TSpTBXItem.Create(parent);
      item.Caption := '「' + CustomStringReplace(favList.name, '&', '&&') + '」に追加';
      item.Tag := Integer(favList);
      item.OnClick := ItemClickEvent;
      item.ImageIndex := 16;
      parent.Insert(0, item);
      sep := TSpTBXSeparatorItem.Create(parent);
      parent.Insert(1, sep);
    end else
    begin
      parent.Caption := CustomStringReplace(favlist.name, '&', '&&');
      item := TSpTBXItem.Create(parent);
      item.Caption := '「' + CustomStringReplace(favList.name, '&', '&&') + '」に追加';
      item.Tag := Integer(favList);
      item.OnClick := ItemClickEvent;
      item.ImageIndex := 16;
      parent.Insert(0, item);
    end;
  end;
var
  menuItem: TSpTBXItem;
begin
  Sender.Clear;
  AddFavItem(favorites, Sender);
  if Sender.Count = 0 then //お気に入りがない場合
  begin
    menuItem := TSpTBXItem.Create(parent);
    menuItem.Caption := '「' + CustomStringReplace(favorites.name, '&', '&&') + '」に追加';
    menuItem.Tag := 0;
    menuItem.OnClick := ItemClickEvent;
    Sender.Insert(0, menuItem);
  end;
  Sender.Caption  := 'お気に入りに追加(&A)';
  Sender.Action   := nil;
  Sender.OnClick  := nil;
end;

//メニューのお気に入りクリック時の処理
procedure TMainWnd.OnFavoriteShortcutMenuClick(Sender: TObject);
var
  URI: String;
begin
  if (Sender is TSpTBXItem) and
     (TObject((Sender as TSpTBXItem).Tag) is TFavorite) then
  begin
    with TFavorite(TObject((Sender as TSpTBXItem).Tag)) do
    begin
      if SameText('YouTube', location) then
      begin
        URI := YOUTUBE_GET_WATCH_URI + id + Config.optMP4Format;
      end
      else if SameText('nicovideo', location) then
      begin
        if SameText('mylist', value) then
        begin
          URI := NICOVIDEO_MYLIST_URI + id;
          GetNicoMylistExecute(URI);
          exit;
        end;
        URI := NICOVIDEO_GET_URI + id;
      end
      else if SameText('nicovideo2', location) then
      begin
        URI := NICOVIDEO_URI + '?p=' + id;
      end else
        exit;
      SetURIwithClear(URI);
    end;
  end;
end;

//メニューにお気に入りを構築
procedure TMainWnd.FavMenuCreate(Sender: TObject);
  procedure AddFavItem(favList: TFavoriteList; parent: TSpTBXSubmenuItem);
  var
    menuItem: TSpTBXItem;
    menuItem2: TSpTBXSubmenuItem;
    i: integer;
  begin
    for i := 0 to favList.Count -1 do
    begin
      if favList.Items[i] is TFavoriteList then
      begin
        menuItem2 := TSpTBXSubmenuItem.Create(parent);
        menuItem2.Caption := CustomStringReplace(favList.Items[i].name, '&', '&&') ;
        parent.Add(menuItem2);
        menuItem2.ImageIndex := 17;
        menuItem2.Tag := Integer(favList.Items[i]);
        menuItem2.OnClick := FavMenuCreate;
      end else
      begin
        menuItem := TSpTBXItem.Create(parent);
        menuItem.Caption := CustomStringReplace(favList.Items[i].name, '&', '&&') ;
        parent.Add(menuItem);
        if SameText('YouTube', TFavorite(favList.Items[i]).location) then
        begin
          menuItem.ImageIndex := 13;
        end
        else if SameText('nicovideo', TFavorite(favList.Items[i]).location) or
                SameText('nicovideo2', TFavorite(favList.Items[i]).location) then
        begin
          menuItem.ImageIndex := 14;
        end else
          menuItem.ImageIndex := -1;
        menuItem.Tag := Integer(favList.Items[i]);
        menuItem.OnClick := OnFavoriteShortcutMenuClick;
      end;
    end;
  end;

var
  i, startIndex: integer;
  favList: TFavoriteList;
begin
  if not (Sender is TSpTBXSubmenuItem) then
    exit;

  with TSpTBXSubmenuItem(Sender) do
  begin
    if Tag = -1 then
      exit
    else if Tag = 0 then
    begin
      favList := favorites;
      startIndex := 2;
    end else
    begin
      favList := TFavoriteList(Tag);
      startIndex := 0;
    end;
    for i := startIndex to Count -1 do
    begin
      if (items[i].ImageIndex = 17) and (items[i].Count = 0) and
         (items[i] is TSpTBXSubmenuItem) then
        AddFavItem(TFavoriteList(favList.Items[i - startIndex]), TSpTBXSubmenuItem(items[i]));
    end;
    Tag := -1;
  end;
end;

procedure TMainWnd.UpdateFavoritesMenu;
var
  i: integer;
  menuItem: TSpTBXItem;
  menuItem2: TSpTBXSubmenuItem;
begin
  for i := MenuFavorite.Count -1 downto 2 do
    MenuFavorite.Items[i].Free;
  //MenuFavorite.Clear;
  MenuFavorite.Tag := 0;

  for i := 0 to favorites.Count -1 do
  begin
    if favorites.Items[i] is TFavoriteList then
    begin
      menuItem2 := TSpTBXSubmenuItem.Create(MenuFavorite);
      menuItem2.Caption := CustomStringReplace(favorites.Items[i].name, '&', '&&') ;
      MenuFavorite.Add(menuItem2);
      menuItem2.ImageIndex := 17;
      menuItem2.OnClick := FavMenuCreate;
      menuItem2.Tag := Integer(favorites.Items[i]);
    end else
    begin
      menuItem := TSpTBXItem.Create(MenuFavorite);
      menuItem.Caption := CustomStringReplace(favorites.Items[i].name, '&', '&&') ;
      MenuFavorite.Add(menuItem);
      if SameText('YouTube', TFavorite(favorites.Items[i]).location) then
      begin
        menuItem.ImageIndex := 13;
      end
      else if SameText('nicovideo', TFavorite(favorites.Items[i]).location) or
              SameText('nicovideo2', TFavorite(favorites.Items[i]).location) then
      begin
        if SameText('mylist', TFavorite(favorites.Items[i]).value) then
          menuItem.ImageIndex := 11
        else
          menuItem.ImageIndex := 14;
      end else
        menuItem.ImageIndex := -1;
      menuItem.Tag := Integer(favorites.Items[i]);
      menuItem.OnClick := OnFavoriteShortcutMenuClick;
    end;
  end;
end;

procedure TMainWnd.SaveFavorites(save: boolean = true);
var
  vnode, snode: PVirtualNode;
  Data: PDataItem;
  i, sel, top: integer;
begin
  vnode := VirtualFavoriteView.GetFirst;
  vnode := VirtualFavoriteView.GetNext(vnode);
  snode := VirtualFavoriteView.GetFirstSelected;
  sel := -1;
  top := 0;
  i := 1;
  while vnode <> nil do
  begin
    Data := VirtualFavoriteView.GetNodeData(vnode);
    if TObject(Data^.Data) is TFavoriteList then
      TFavoriteList(Data^.Data).expanded := VirtualFavoriteView.Expanded[vnode];
    if (snode <> nil) and (snode = vnode) then
      sel := i;
    if vnode = VirtualFavoriteView.TopNode then
      top := i;
    Inc(i);
    vnode := VirtualFavoriteView.GetNext(vnode);
  end;

  favorites.top := top;
  favorites.selected := sel;

  if save then
  begin
    favorites.updata := true;
    if FileExists(Config.BasePath + FAVORITES_DAT_BAK3) then
      SysUtils.DeleteFile(Config.BasePath + FAVORITES_DAT_BAK3);
    if FileExists(Config.BasePath + FAVORITES_DAT_BAK2) then
      SysUtils.RenameFile(Config.BasePath + FAVORITES_DAT_BAK2, Config.BasePath + FAVORITES_DAT_BAK3);
    if FileExists(Config.BasePath + FAVORITES_DAT_BAK) then
      SysUtils.RenameFile(Config.BasePath + FAVORITES_DAT_BAK, Config.BasePath + FAVORITES_DAT_BAK2);
    if FileExists(Config.BasePath + FAVORITES_DAT) then
      SysUtils.RenameFile(Config.BasePath + FAVORITES_DAT, Config.BasePath + FAVORITES_DAT_BAK);
    favorites.Save(Config.BasePath + FAVORITES_DAT);
  end;
end;

procedure TMainWnd.UpdateVirtualFavoriteView(Select: boolean);
var
  favFile: TStringList;
  procedure SetOutputList(parent: TFavoriteList; Node: PVirtualNode; indent: integer);
  var
    i: integer;
    VNode, TempNode: PVirtualNode;
    Data: PDataItem;
  begin
    VNode := Node;
    TempNode := Node;
    for i := 0 to TempNode.TotalCount -1 do
    begin
      VNode := VirtualFavoriteView.GetNext(VNode);
      if (VNode = nil) then
        break;
      Data := VirtualFavoriteView.GetNodeData(VNode);

      if (VNode <> nil) and (VNode.Parent = TempNode) and
         (TObject(Data^.Data) is TFavoriteList) then
      begin
        with TFavoriteList(Data^.Data) do
        begin
          favFile.Add(StringOfChar(' ', indent * 2)
                      + Format('<folder name="%s" expanded="%s">',
                      [XMLQuoteEncode(name), TRUEFALSE[Integer(expanded)]]));
          SetOutputList(TFavoriteList(Data^.Data), VNode, indent + 1);
          favFile.Add(StringOfChar(' ', indent * 2)
                      + '</folder>');
        end;
      end
      else if (VNode <> nil) and (VNode.Parent = TempNode) and
              (TObject(Data^.Data) is TFavorite) then
      begin
        with TFavorite(Data^.Data) do
        begin
          favFile.Add(StringOfChar(' ', indent * 2)
                      + Format('<item name="%s" location="%s" id="%s" times="%s" addtime="%s" playtime="%s" user="%s" value="%s" comment="%s" etc="%s" etc2="%s"/>',
                      [XMLQuoteEncode(name),
                       XMLQuoteEncode(location),
                       XMLQuoteEncode(id),
                       XMLQuoteEncode(times),
                       XMLQuoteEncode(addtime),
                       XMLQuoteEncode(playtime),
                       XMLQuoteEncode(user),
                       XMLQuoteEncode(value),
                       XMLQuoteEncode(comment),
                       XMLQuoteEncode(etc),
                       XMLQuoteEncode(etc2)]));
        end;
      end;
    end;
  end;
var
  BaseNode: PVirtualNode;
  BaseData: PDataItem;
  sel: integer;
begin
  SaveFavorites(false);
  if Select then
    sel := favorites.selected
  else
    sel := -1;

  BaseNode := VirtualFavoriteView.GetFirst;
  if BaseNode <> nil then
    BaseData := VirtualFavoriteView.GetNodeData(BaseNode);

  favFile := TStringList.Create;
  favFile.Add('<favorite top="' + IntToStr(favorites.top) +'" selected="' + IntToStr(sel) + '">');
  SetOutputList(BaseData^.Data, BaseNode, 1);
  favFile.Add('</favorite>');
  try
    favorites.updata := true;
    if FileExists(Config.BasePath + FAVORITES_DAT_BAK3) then
      SysUtils.DeleteFile(Config.BasePath + FAVORITES_DAT_BAK3);
    if FileExists(Config.BasePath + FAVORITES_DAT_BAK2) then
      SysUtils.RenameFile(Config.BasePath + FAVORITES_DAT_BAK2, Config.BasePath + FAVORITES_DAT_BAK3);
    if FileExists(Config.BasePath + FAVORITES_DAT_BAK) then
      SysUtils.RenameFile(Config.BasePath + FAVORITES_DAT_BAK, Config.BasePath + FAVORITES_DAT_BAK2);
    if FileExists(Config.BasePath + FAVORITES_DAT) then
      SysUtils.RenameFile(Config.BasePath + FAVORITES_DAT, Config.BasePath + FAVORITES_DAT_BAK);
    favFile.SaveToFile(Config.BasePath + FAVORITES_DAT);
  except
  end;
  favFile.Free;

  favorites.Load(Config.BasePath + FAVORITES_DAT);
  favorites.updata := true;

  UpdateFavorites;
end;

procedure TMainWnd.VirtualFavoriteViewClick(Sender: TObject);
var
  vnode: PVirtualNode;
  Data: PDataItem;
  URI: String;
begin
  if (GetKeyState(VK_SHIFT) < 0) or
     (GetKeyState(VK_CONTROL) < 0) then
    exit;
  if VirtualFavoriteView.SelectedCount > 1 then
    exit;

  vnode := VirtualFavoriteView.GetFirstSelected;
  if vnode <> nil then
  begin
    Data := VirtualFavoriteView.GetNodeData(vnode);
    if TObject(Data^.Data) is TFavorite then
    begin
      if not Config.optFavoriteClickOption then
        exit;
      case Data^.ImageIndex of
        13: URI := YOUTUBE_GET_WATCH_URI + TFavorite(Data^.Data).id + Config.optMP4Format;
        14: URI := NICOVIDEO_GET_URI + TFavorite(Data^.Data).id;
        11: begin
              URI := NICOVIDEO_MYLIST_URI + TFavorite(Data^.Data).id;
              GetNicoMylistExecute(URI);
              exit;
            end;
      else exit;
      end;
      SetURIwithClear(URI);
    end else
    begin
      if (VirtualFavoriteView.GetFirst <> vnode) then
      begin
        if VirtualFavoriteView.AlreadyToggled then
          VirtualFavoriteView.AlreadyToggled := false
        else
          VirtualFavoriteView.ToggleNode(vnode);
      end;
    end;
  end;
end;

procedure TMainWnd.VirtualFavoriteViewContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  if VirtualFavoriteView.IsEditing then
    VirtualFavoriteView.PopupMenu := nil
  else
    VirtualFavoriteView.PopupMenu := FavoritePopupMenu;
end;

procedure TMainWnd.VirtualFavoriteViewDblClick(Sender: TObject);
var
  vnode: PVirtualNode;
  Data: PDataItem;
  URI: String;
begin
  vnode := VirtualFavoriteView.GetFirstSelected;
  if vnode <> nil then
  begin
    Data := VirtualFavoriteView.GetNodeData(vnode);
    if TObject(Data^.Data) is TFavorite then
    begin
      case Data^.ImageIndex of
        13: URI := YOUTUBE_GET_WATCH_URI + TFavorite(Data^.Data).id + Config.optMP4Format;
        14: URI := NICOVIDEO_GET_URI + TFavorite(Data^.Data).id;
        11: begin
              URI := NICOVIDEO_MYLIST_URI + TFavorite(Data^.Data).id;
              GetNicoMylistExecute(URI);
              exit;
            end;
      end;
      SetURIwithClear(URI);
    end;
  end;
end;

procedure TMainWnd.VirtualFavoriteViewDragAllowed(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := (Node <> VirtualFavoriteView.RootNode);
end;

procedure TMainWnd.VirtualFavoriteViewDragDrop(Sender: TBaseVirtualTree;
  Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
  Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  AttachMode: TVTNodeAttachMode;
  I: Integer;
  vnode: PVirtualNode;
  Data: PDataItem;
begin
  vnode := Sender.DropTargetNode;
  Data := VirtualFavoriteView.GetNodeData(vnode);

  if Data = nil then //空白にDropで消えるのを防ぐ
  begin
    AttachMode := amAddChildLast;
    Effect := DROPEFFECT_MOVE;
    Sender.ProcessDrop(DataObject, VirtualFavoriteView.GetFirst, Effect, Attachmode);
    exit;
  end;

  for i := Low(Formats) to High(Formats) do
  begin
    //if Formats[i] = CF_VIRTUALTREE then
    begin
      case Mode of
        dmAbove:
          begin
            if (VirtualFavoriteView.GetFirst <> vnode) then  //「お気に入り」より上位には登録しない
              AttachMode := amInsertBefore
            else
              AttachMode := amAddChildFirst;
          end;
        dmOnNode:
          begin
            if not(TObject(Data^.Data) is TFavoriteList) then //対象がフォルダ
              AttachMode := amInsertBefore
            else //対象がスレ・板
            begin
              if (ssCtrl in Shift) then  //Ctrlキー押下時はフォルダに入れない
              begin
                if (VirtualFavoriteView.GetFirst <> vnode) then  //「お気に入り」より上位には登録しない
                  AttachMode := amInsertBefore
                else
                  AttachMode := amAddChildFirst;
              end else
              begin
                if not VirtualFavoriteView.Expanded[vnode] then //対象フォルダが閉じていれば開く
                  VirtualFavoriteView.ToggleNode(vnode);
                AttachMode := amAddChildFirst;
                Include(Sender.DropTargetNode.States,vsExpanded);
              end;
            end;
          end;
        dmBelow:
          begin
            vnode := Sender.DropTargetNode;
            if (VirtualFavoriteView.GetFirst <> vnode) then //「お気に入り」より上位には登録しない
              AttachMode := amInsertAfter
            else
              AttachMode := amAddChildFirst;
          end;
      else
        if Assigned(Source) and (Source is TBaseVirtualTree) and (Sender <> Source) then
          AttachMode := amInsertBefore
        else
          AttachMode := amNowhere;
      end;

      (*
      if DataObject <> nil then
      begin
      if (Shift = [ssCtrl]) then
        Effect := DROPEFFECT_COPY
      else
        Effect := DROPEFFECT_MOVE;
      end;
      *)

      Effect := DROPEFFECT_MOVE;

      Sender.ProcessDrop(DataObject, Sender.DropTargetNode, Effect, Attachmode);
    end;
  end;
end;

procedure TMainWnd.VirtualFavoriteViewDragOver(Sender: TBaseVirtualTree;
  Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint;
  Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
begin
  Accept := true;
end;

procedure TMainWnd.VirtualFavoriteViewEdited(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
begin
  UpdateVirtualFavoriteView(true);
  //▼お気に入りの名前変更終了時にIME状態を保存
  SaveImeMode(handle);
end;

procedure TMainWnd.VirtualFavoriteViewEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  UpdateVirtualFavoriteView(false);
end;

procedure TMainWnd.VirtualFavoriteViewGetHint(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex;
  var LineBreakStyle: TVTTooltipLineBreakStyle; var HintText: WideString);
var
  Data: PDataItem;
begin
  Data := Sender.GetNodeData(Node);
  if Assigned(Data) then
    HintText := Data^.Title;
end;

procedure TMainWnd.VirtualFavoriteViewGetImageIndex(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PDataItem;
begin
  Data := Sender.GetNodeData(Node);
  if Kind in [ikNormal, ikSelected] then //これがないとImageがかぶる
  begin
    if Assigned(Data) then
      ImageIndex := Data^.ImageIndex;
  end;
end;

procedure TMainWnd.VirtualFavoriteViewGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PDataItem;
begin
  Data := Sender.GetNodeData(Node);
  if Assigned(Data) then
    CellText := Data^.Title;
end;

procedure TMainWnd.VirtualFavoriteViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  vnode, vnode2: PVirtualNode;
  Data: PDataItem;
begin
  //▼アイテム名変更時は無効
  if VirtualFavoriteView.IsEditing then
   	exit;

  case Key of
  VK_F2:
    begin
      if VirtualFavoriteView.SelectedCount = 1 then
      begin
        ActionFavoritePopupEdit.Execute;
      end;
    end;
  //▼Deleteを警告付きで復活
  VK_DELETE:
    begin
      if VirtualFavoriteView.SelectedCount > 0 then
      begin
        vnode := VirtualFavoriteView.GetFirstSelected;
        Data := VirtualFavoriteView.GetNodeData(vnode);
        if ((Data^.Data) <> favorites) and
           (MessageDlg('削除します。よろしいですか？', mtWarning, mbOKCancel, -1) = mrOk) then
          ActionFavoritePopupDelete.Execute;
      end;
    end;
  VK_INSERT:
    begin
      ActionFavoritePopupNew.Execute;
    end;
  VK_RETURN:
    begin
      if VirtualFavoriteView.SelectedCount > 0 then
      begin
        vnode := VirtualFavoriteView.GetFirstSelected;
        Data := VirtualFavoriteView.GetNodeData(vnode);
        if not (TObject(Data^.Data) is TFavoriteList) then
          ActionFavoritePopupOpen.Execute;
      end;
    end;
  //▼お気に入りの順序がえ
  VK_UP:
    begin
      if ssAlt in Shift then
      begin
        key := 0;
        if VirtualFavoriteView.SelectedCount <> 1 then
          exit;

        vnode := VirtualFavoriteView.GetFirstSelected;
        vnode2 := VirtualFavoriteView.GetPrevious(vnode);
        if (vnode2 = nil) or (vnode2 = VirtualFavoriteView.GetFirst) then
          exit;
        Data := VirtualFavoriteView.GetNodeData(vnode2.Parent);
        if (TObject(Data^.Data) is TFavoriteList) and
           not VirtualFavoriteView.Expanded[vnode2.Parent] then
          VirtualFavoriteView.ToggleNode(vnode2.Parent);

        VirtualFavoriteView.MoveTo(vnode, vnode2, amInsertBefore,false);
        UpdateVirtualFavoriteView(true);
      end;
    end;
  VK_DOWN:
    begin
      if ssAlt in Shift then
      begin
        key := 0;
        if VirtualFavoriteView.SelectedCount <> 1 then
          exit;

        vnode := VirtualFavoriteView.GetFirstSelected;
        Data := VirtualFavoriteView.GetNodeData(vnode);
        if (TObject(Data^.Data) is TFavoriteList) then
        begin
          vnode2 := VirtualFavoriteView.GetNext(vnode);
          if (vnode2 = nil) then
            exit;
          while vnode2.Parent = vnode do
          begin
            vnode2 := VirtualFavoriteView.GetNext(vnode2);
            if (vnode2 = nil) then
              exit;
          end;
        end else
        begin
          vnode2 := VirtualFavoriteView.GetNext(vnode);
          if (vnode2 = nil) then
            exit;
        end;
        Data := VirtualFavoriteView.GetNodeData(vnode2);
        if (TObject(Data^.Data) is TFavoriteList) and
           not VirtualFavoriteView.Expanded[vnode2] then
          VirtualFavoriteView.ToggleNode(vnode2);
        if (TObject(Data^.Data) is TFavoriteList) then
          VirtualFavoriteView.MoveTo(vnode, vnode2, amAddChildFirst,false)
        else
          VirtualFavoriteView.MoveTo(vnode, vnode2, amInsertAfter,false);
        UpdateVirtualFavoriteView(true);
      end;
    end;
  end;
end;

procedure TMainWnd.VirtualFavoriteViewNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
  Data: PDataItem;
begin
  Data := Sender.GetNodeData(Node);
  if Assigned(Data) then
  begin
    Data^.Title := NewText;
    TFavBase(Data^.Data).name := NewText;
  end;
end;

//このビデオを開く
procedure TMainWnd.ActionFavoritePopupOpenExecute(Sender: TObject);
var
  vnode: PVirtualNode;
  Data: PDataItem;
  URI: String;
begin
  if VirtualFavoriteView.SelectedCount = 0 then
    exit;

  vnode := VirtualFavoriteView.GetFirstSelected;
  if vnode <> nil then
  begin
    Data := VirtualFavoriteView.GetNodeData(vnode);
    if TObject(Data^.Data) is TFavorite then
    begin
      case Data^.ImageIndex of
        13: URI := YOUTUBE_GET_WATCH_URI + TFavorite(Data^.Data).id + Config.optMP4Format;
        14: URI := NICOVIDEO_GET_URI + TFavorite(Data^.Data).id;
        11: begin
              URI := NICOVIDEO_MYLIST_URI + TFavorite(Data^.Data).id;
              GetNicoMylistExecute(URI);
              exit;
            end;
      end;
      SetURIwithClear(URI);
    end;
  end;
end;

//外部ブラウザで開く
procedure TMainWnd.ActionFavoritePopupOpenByBrowserExecute(
  Sender: TObject);
var
  vnode: PVirtualNode;
  Data: PDataItem;
  URI: String;
begin
  if VirtualFavoriteView.SelectedCount = 0 then
    exit;

  vnode := VirtualFavoriteView.GetFirstSelected;
  if vnode <> nil then
  begin
    Data := VirtualFavoriteView.GetNodeData(vnode);
    if TObject(Data^.Data) is TFavorite then
    begin
      case Data^.ImageIndex of
        13: URI := YOUTUBE_GET_WATCH_URI + TFavorite(Data^.Data).id + Config.optMP4Format;
        14: URI := NICOVIDEO_GET_URI + TFavorite(Data^.Data).id;
        11: URI := NICOVIDEO_MYLIST_URI + TFavorite(Data^.Data).id;
      end;
      OpenByBrowser(URI);
    end;
  end;
end;

//タイトルをコピー
procedure TMainWnd.ActionFavoritePopupCopyTitleExecute(Sender: TObject);
var
  vnode: PVirtualNode;
  Data: PDataItem;
  tmpString: String;
begin
  if VirtualFavoriteView.SelectedCount = 0 then
    exit;

  vnode := VirtualFavoriteView.GetFirstSelected;
  while vnode <> nil do
  begin
    Data := VirtualFavoriteView.GetNodeData(vnode);
    if TObject(Data^.Data) is TFavorite then
    begin
      with TFavorite(Data^.Data) do
      begin
        tmpString := tmpString + TFavorite(Data^.Data).name + #13#10;
      end;
    end;
    vnode := VirtualFavoriteView.GetNextSelected(vnode);
  end;
  Clipboard.AsText := TrimRight(tmpString);
end;

//URLをコピー
procedure TMainWnd.ActionFavoritePopupCopyURLExecute(Sender: TObject);
var
  vnode: PVirtualNode;
  Data: PDataItem;
  tmpString: String;
begin
  if VirtualFavoriteView.SelectedCount = 0 then
    exit;

  vnode := VirtualFavoriteView.GetFirstSelected;
  while vnode <> nil do
  begin
    Data := VirtualFavoriteView.GetNodeData(vnode);
    if TObject(Data^.Data) is TFavorite then
    begin
      case Data^.ImageIndex of
        13: tmpString := tmpString + YOUTUBE_GET_WATCH_URI + TFavorite(Data^.Data).id + Config.optMP4Format + #13#10;
        14: tmpString := tmpString + NICOVIDEO_GET_URI + TFavorite(Data^.Data).id + #13#10;
        11: tmpString := tmpString + NICOVIDEO_MYLIST_URI + TFavorite(Data^.Data).id + #13#10;
      end;
    end;
    vnode := VirtualFavoriteView.GetNextSelected(vnode);
  end;
  Clipboard.AsText := TrimRight(tmpString);
end;

//タイトルとURLをコピー
procedure TMainWnd.ActionFavoritePopupCopyTUExecute(Sender: TObject);
var
  vnode: PVirtualNode;
  Data: PDataItem;
  tmpString: String;
begin
  if VirtualFavoriteView.SelectedCount = 0 then
    exit;

  vnode := VirtualFavoriteView.GetFirstSelected;
  while vnode <> nil do
  begin
    Data := VirtualFavoriteView.GetNodeData(vnode);
    if TObject(Data^.Data) is TFavorite then
    begin
      case Data^.ImageIndex of
        13: tmpString := tmpString + TFavorite(Data^.Data).name + #13#10 + YOUTUBE_GET_WATCH_URI + TFavorite(Data^.Data).id + Config.optMP4Format + #13#10;
        14: tmpString := tmpString + TFavorite(Data^.Data).name + #13#10 + NICOVIDEO_GET_URI + TFavorite(Data^.Data).id + #13#10;
        11: tmpString := tmpString + TFavorite(Data^.Data).name + #13#10 + NICOVIDEO_MYLIST_URI + TFavorite(Data^.Data).id + #13#10;
      end;
    end;
    vnode := VirtualFavoriteView.GetNextSelected(vnode);
  end;
  Clipboard.AsText := TrimRight(tmpString);
end;

//新規フォルダ
procedure TMainWnd.ActionFavoritePopupNewExecute(Sender: TObject);
  function NewFolder(var parent: TFavoriteList): TFavoriteList;
  begin
    result := TFavoriteList.Create(parent);
    result.name := '新しいフォルダ';
    result.expanded := false;
    parent.expanded := true;
  end;
var
  vnode: PVirtualNode;
  Data, Data2: PDataItem;
  parent: TFavoriteList;
begin
  vnode := VirtualFavoriteView.GetFirstSelected;
  Data := VirtualFavoriteView.GetNodeData(vnode);
  SaveFavorites(false);

  if vnode = nil then
  begin
    parent := favorites;
    parent.Insert(0, NewFolder(parent));
  end
  else if (TObject(Data^.Data) is TFavoriteList) and (0 <= GetKeyState(VK_CONTROL)) then
  begin
    parent := Data^.Data;
    parent.Insert(0, NewFolder(parent));
  end else
  begin
    vnode := vnode.Parent;
    Data2 := VirtualFavoriteView.GetNodeData(vnode);
    parent := TFavoriteList(Data2^.Data);
    parent.Insert(parent.IndexOf(Data^.Data), NewFolder(parent));
  end;
  SaveFavorites(true);
  UpdateFavorites;
end;

//名前の変更
procedure TMainWnd.ActionFavoritePopupEditExecute(Sender: TObject);
var
  vnode: PVirtualNode;
begin
  if VirtualFavoriteView.SelectedCount <> 1 then
    exit;
  vnode := VirtualFavoriteView.GetFirstSelected;

  if Assigned(vnode) and (vnode.Parent <> VirtualFavoriteView.RootNode) then
    VirtualFavoriteView.EditNode(vnode, -1);
end;

//削除
procedure TMainWnd.ActionFavoritePopupDeleteExecute(Sender: TObject);
var
  Data: PDataItem;

  Nodes: TNodeArray;
  I: Integer;
  LevelChange: Boolean;
begin
  if VirtualFavoriteView.SelectedCount = 0 then
    exit;
  Nodes := nil;

  VirtualFavoriteView.BeginUpdate;
  try
    Nodes := VirtualFavoriteView.GetSortedSelection(True);
    for I := High(Nodes) downto 1 do
    begin
      Data := VirtualFavoriteView.GetNodeData(Nodes[I]);
      TObject(Data^.Data).Free;
      LevelChange := Nodes[I].Parent <> Nodes[I - 1].Parent;
      VirtualFavoriteView.DeleteNode(Nodes[I], LevelChange);
    end;
    Data := VirtualFavoriteView.GetNodeData(Nodes[0]);
    TObject(Data^.Data).Free;
    VirtualFavoriteView.DeleteNode(Nodes[0]);
  finally
    VirtualFavoriteView.EndUpdate;
  end;

  UpdateVirtualFavoriteView(false);
end;

//お気に入りに登録する
procedure TMainWnd.RegisterFavorite(parent: TFavoriteList = nil; index: integer = 0;
                                    AtBottom: boolean = false);
var
  fav: TFavorite;
begin
  fav := nil;
  if Length(VideoData.video_id) > 0 then
  begin
    if VideoData.video_type = 0 then //YouTube
    begin
      //▼重複許可
      if not Config.optAllowFavoriteDuplicate and
         (favorites.Find('YouTube', VideoData.video_id) <> nil) then
        exit;
      fav := TFavorite.Create(favorites);
      fav.name := VideoData.video_title;
      fav.location := 'YouTube';
      fav.id := VideoData.video_id;
      fav.addtime := IntToStr(DateTimeToUnix(now));
      fav.playtime := VideoData.playtime_seconds;
      fav.user := VideoData.author;
    end
    else if VideoData.video_type in [1..5] then  //ニコニコ動画
    begin
      //▼重複許可
      if not Config.optAllowFavoriteDuplicate and
         (favorites.Find('nicovideo', VideoData.video_id) <> nil) or
         (favorites.Find('nicovideo2', VideoData.video_id) <> nil) then
        exit;
      fav := TFavorite.Create(favorites);
      fav.name := VideoData.video_title;
      if VideoData.video_type <> 5 then
        fav.location := 'nicovideo'
      else
        fav.location := 'nicovideo2';
      fav.id := VideoData.video_id;
      fav.addtime := IntToStr(DateTimeToUnix(now));
      fav.playtime := VideoData.playtime_seconds;
      fav.user := VideoData.author;
    end;
  end else
    exit;

  if fav = nil then
    exit;

  if (parent = nil) or (parent.name = '') then
  begin
    if AtBottom or (Config.optAddFavoriteAtBottom xor (GetKeyState(VK_SHIFT) < 0)) then //732
      favorites.Add(fav)
    else
      favorites.Insert(0, fav)
  end else
  begin
    if (index = 0) and Config.optAddFavoriteAtBottom xor (GetKeyState(VK_SHIFT) < 0) then //732
      parent.Insert(parent.Count, fav)
    else
      parent.Insert(index, fav);
  end;
  SaveFavorites(true);
  UpdateFavorites;
end;

//お気に入りに登録する(リストから)
procedure TMainWnd.RegisterFavorite2(SearchData: TSearchData; parent: TFavoriteList = nil; index: integer = 0;
                                     AtBottom: boolean = false);
var
  fav: TFavorite;
begin
  fav := nil;
  if Length(SearchData.video_id) > 0 then
  begin
    if SearchData.video_type = 0 then //YouTube
    begin
      //▼重複許可
      if not Config.optAllowFavoriteDuplicate and
         (favorites.Find('YouTube', SearchData.video_id) <> nil) then
        exit;
      fav := TFavorite.Create(favorites);
      fav.name := SearchData.video_title;
      fav.location := 'YouTube';
      fav.id := SearchData.video_id;
      fav.addtime := IntToStr(DateTimeToUnix(now));
      fav.playtime := SearchData.playtime_seconds;
      fav.user := SearchData.author;
    end
    else if SearchData.video_type = 1 then  //ニコニコ動画
    begin
      //▼重複許可
      if not Config.optAllowFavoriteDuplicate and
         (favorites.Find('nicovideo', SearchData.video_id) <> nil) then
        exit;
      fav := TFavorite.Create(favorites);
      fav.name := SearchData.video_title;
      fav.location := 'nicovideo';
      fav.id := SearchData.video_id;
      fav.addtime := IntToStr(DateTimeToUnix(now));
      fav.playtime := SearchData.playtime_seconds;
      fav.user := SearchData.author;
    end;
  end else
    exit;

  if fav = nil then
    exit;

  if (parent = nil) or (parent.name = '') then
  begin
    if AtBottom or (Config.optAddFavoriteAtBottom xor (GetKeyState(VK_SHIFT) < 0)) then //732
      favorites.Add(fav)
    else
      favorites.Insert(0, fav)
  end else
  begin
    if (index = 0) and Config.optAddFavoriteAtBottom xor (GetKeyState(VK_SHIFT) < 0) then //732
      parent.Insert(parent.Count, fav)
    else
      parent.Insert(index, fav);
  end;
  SaveFavorites(true);
  UpdateFavorites;
end;

//お気に入りに追加(メニューから)
procedure TMainWnd.ActionAddFavoriteExecute(Sender: TObject);
begin
  if Length(VideoData.video_id) > 0 then
  begin
    RegisterFavorite;
    ToolButtonAddFavorite.Checked := True;
  end;
end;

//お気に入りに追加(リストから)
procedure TMainWnd.ListPopupAddFavoriteExecute(Sender: TObject);
var
  item: TListItem;
  SearchData: TSearchData;
begin
  item := ListView.Selected;
  if item = nil then
    exit;
  if ListView.SelCount > 1 then
  begin
    SearchData := nil;
    while (item <> nil) and (item.Data <> SearchData) do
    begin
      SearchData := TSearchData(item.Data);
      RegisterFavorite2(SearchData, TFavoriteList(TMenuItem(Sender).Tag));
      item := ListView.GetNextItem(item, sdBelow, [isSelected]);
    end;
  end else
  begin
    SearchData := TSearchData(item.Data);
    if SearchData = nil then
      exit;
    RegisterFavorite2(SearchData, TFavoriteList(TMenuItem(Sender).Tag));
  end;
end;

//お気に入りに追加(PopupMenu)
procedure TMainWnd.PopupMenuAddFavoriteExecute(Sender: TObject);
var
  favlist: TFavoriteList;
begin
  if Length(VideoData.video_id) = 0 then
    exit;
  if TMenuItem(Sender).Tag > 0 then
    favlist := TFavoriteList(TMenuItem(Sender).Tag)
  else
    favlist := favorites;

  RegisterFavorite(favlist);
  ToolButtonAddFavorite.Checked := True;
end;

//お気に入りに追加を作成(PopupMenu)
procedure TMainWnd.PopupMenuPopup(Sender: TObject);
begin
  if ActionAddFavorite.Enabled then
  begin
    PopupMenuAddFavorite.Enabled := true;
    FavoriteMenuItemCreate(PopupMenuAddFavorite, PopupMenuAddFavoriteExecute);
  end else
    PopupMenuAddFavorite.Enabled := false;
end;

{
//お気に入りに追加を作成(ToolButtonAddFavorite)
procedure TMainWnd.ToolButtonAddFavoriteClick(Sender: TObject);
begin
  if ActionAddFavorite.Enabled then
    FavoriteMenuItemCreate(ToolButtonAddFavorite, PopupMenuAddFavoriteExecute);
end;
}

//お気に入りに追加を作成(ToolButtonAddFavorite)
procedure TMainWnd.ToolButtonAddFavoritePopup(Sender: TTBCustomItem;
  FromLink: Boolean);
begin
  if ActionAddFavorite.Enabled then
    FavoriteMenuItemCreate(ToolButtonAddFavorite, PopupMenuAddFavoriteExecute);
end;

procedure TMainWnd.FavoritePopupMenuPopup(Sender: TObject);
var
  vnode: PVirtualNode;
  Data: PDataItem;
  b: boolean;
begin
  if VirtualFavoriteView.SelectedCount = 0 then
  begin
    FavoritePopupOpen.Enabled := false;
    FavoritePopupOpenByBrowser.Enabled := false;
    FavoritePopupCopyURL.Enabled := false;
    FavoritePopupCopyTITLE.Enabled := false;
    FavoritePopupCopyTU.Enabled := false;
    FavoritePopupEdit.Enabled := false;
    FavoritePopupDelete.Enabled := false;
    exit;
  end;
  vnode := VirtualFavoriteView.GetFirstSelected;
  Data := VirtualFavoriteView.GetNodeData(vnode);

  FavoritePopupDelete.Enabled := (Data^.Data) <> favorites;
  FavoritePopupEdit.Enabled   := ((Data^.Data) <> favorites) and (VirtualFavoriteView.SelectedCount = 1);
  b := not (TObject(Data^.Data) is TFavoriteList);
  FavoritePopupOpen.Enabled := b;
  FavoritePopupOpenByBrowser.Enabled := b;

  if (VirtualFavoriteView.SelectedCount > 1) then
  begin
    if not b then
    begin
      vnode := VirtualFavoriteView.GetNextSelected(vnode);
      Data := VirtualFavoriteView.GetNodeData(vnode);
      while vnode <> nil do
      begin
        if (TObject(Data^.Data) is TFavorite) then
        begin
          FavoritePopupOpen.Enabled := true;
          FavoritePopupOpenByBrowser.Enabled := true;
          FavoritePopupCopyURL.Enabled := true;
          FavoritePopupCopyTITLE.Enabled := true;
          FavoritePopupCopyTU.Enabled  := true;
          break;
        end;
        vnode := VirtualFavoriteView.GetNextSelected(vnode);
      end;
    end;
  end else
  begin                               
    FavoritePopupCopyURL.Enabled := b;
    FavoritePopupCopyTITLE.Enabled := b;
    FavoritePopupCopyTU.Enabled  := b;
  end;
end;

//検索リストから外部ブラウザで開く
procedure TMainWnd.ActionListOpenByBrowserExecute(Sender: TObject);
var
  item: TListItem;
  SearchData: TSearchData;
  URI: String;
begin
  item := ListView.Selected;
  if item = nil then
    exit;
  SearchData := TSearchData(item.Data);
  if SearchData = nil then
    exit;
  if Length(SearchData.video_id) = 0 then
    exit;
  case SearchType of
    0,10,20: URI := YOUTUBE_GET_WATCH_URI + SearchData.video_id + Config.optMP4Format;
    1,2,3,4,6,8,9: URI := NICOVIDEO_GET_URI + SearchData.video_id;
  end;
  OpenByBrowser(URI);
end;

//TWebBrowserのプロキシ切り替え
procedure TMainWnd.SetProxy(const ProxyHostAndPort: String);
var
  info: TInternetProxyInfo;
begin
  try
    info.dwAccessType := INTERNET_OPEN_TYPE_PROXY;
    info.lpszProxy := PChar(ProxyHostAndPort);
    info.lpszProxyBypass:= nil;
    UrlMkSetSessionOption(INTERNET_OPTION_PROXY, @info, sizeof(info), 0);
  except
    Log('proxy設定エラー')
  end;
end;

//TWebBrowserのプロキシを元に戻す
procedure TMainWnd.SetDirectConnection;
var
  info: TInternetProxyInfo;
begin
  try
    info.dwAccessType := INTERNET_OPEN_TYPE_DIRECT;
    info.lpszProxy := nil;
    info.lpszProxyBypass:= nil;
    UrlMkSetSessionOption(INTERNET_OPTION_PROXY, @info,sizeof(info), 0);
  except
    Log('proxy設定エラー')
  end;
end;

//ニコニコ動画の情報を取得するタイマー
procedure TMainWnd.TimerGetNicoVideoDataTimer(Sender: TObject);
var
  Members, Comments, MyLists, URI: String;
begin
  TimerGetNicoVideoData.Enabled := false;
  if WebBrowser.Document = nil then
    exit;

  if (VideoData.video_type in [1..5]) then //ニコニコ動画
  begin
    //再生数とコメント数を取得する
    try
      Members  := WebBrowser.OleObject.Document.getElementById('flvplayer').GetVariable('header.Members.text');
      Comments := WebBrowser.OleObject.Document.getElementById('flvplayer').GetVariable('header.Comments.text');
      MyLists  := WebBrowser.OleObject.Document.getElementById('flvplayer').GetVariable('header.MyLists.text');
      if (Length(Members) > 0) and (Length(Comments) > 0) then
      begin
        LabelURL.Caption := '【' + VideoData.video_title + '】 再生:' + Members + ' コメント:' + Comments + ' マイリスト:' + MyLists;
        LabelURL.Hint := VideoData.video_title + #13#10 +
                         tmpURI2Form + #13#10 +
                         '再生:' + Members + #13#10 +
                         'コメント:' + Comments + #13#10 +
                         'マイリスト:' + MyLists;
      end;
    except
      Log('ERROR:header.Members.text/header.Comments.text');
      if TimerGetNicoVideoData.Interval = 10000 then
        exit;
    end;

    TimerGetNicoVideoData.Interval := 10000;
    TimerGetNicoVideoData.Enabled := True;

    if AnsiStartsText('http://', VideoData.dl_video_id) then
      exit;

    //動画の自動再生の再設定
    if Config.optNicoVideoAutoPlay then
    begin
      try
        WebBrowser.OleObject.Document.getElementById('flvplayer').SetVariable('autoPlayPremium', 1); 
        WebBrowser.OleObject.Document.getElementById('flvplayer').SetVariable('Overlay._alpha', 100);
        WebBrowser.OleObject.Document.getElementById('flvplayer').SetVariable('videowindow.playButton._visible', 0);
        WebBrowser.OleObject.Document.getElementById('flvplayer').SetVariable('tabmenu.adView._visible', 0);
        WebBrowser.OleObject.Document.getElementById('flvplayer').SetVariable('video_base.thmbImage_mc._visible', 0);
      except
        Log('ERROR:autoPlayPremium');
      end;
    end;

    //コメント非表示の設定
    if Config.optAutoOverlayCheckOn then
    begin
      try
        WebBrowser.OleObject.Document.getElementById('flvplayer').SetVariable('OverlayFlag', 0);
        WebBrowser.OleObject.Document.getElementById('flvplayer').SetVariable('Overlay._visible', 0);
        WebBrowser.OleObject.Document.getElementById('flvplayer').SetVariable('controller.controller_submenu.OverlayOff._visible', 0);
        WebBrowser.OleObject.Document.getElementById('flvplayer').SetVariable('controller.controller_submenu.OverlayOn._visible', 1);
      except
        Log('ERROR:Overlay._visible');
      end;
    end;

    //メッセージをログに追加する
    try
      Log('');
      Log(WebBrowser.OleObject.Document.getElementById('flvplayer').GetVariable('systemMessage.text'));
    except
      Log('ERROR:systemMessage.text');
    end;


    //DL先URLを取得する
    try
      URI := WebBrowser.OleObject.Document.getElementById('flvplayer').GetVariable('o.url');
      VideoData.dl_video_id := URI;
    except
      Log('ERROR:o.url');
    end;

    {
    TimerGetNicoVideoData.Enabled := true;
    //再生時間(現在)
    try
      Log(WebBrowser.OleObject.Document.getElementById('flvplayer').GetVariable('player.stream_ns.time'));
    except
      Log('ERROR:player.stream_ns.time');
    end;

    //再生時間(トータル)
    try
      Log(WebBrowser.OleObject.Document.getElementById('flvplayer').GetVariable('player._contentLength'));
    except
      Log('ERROR:player._contentLength');
    end;
    }
  end;
end;

(* うまくいかない
//ショートカット抑止
function TMainWnd.IsShortCut(var Message: TWMKey): Boolean;
begin
  if VirtualFavoriteView.IsEditing or
     SearchBarComboBox.Focused or
     PanelSearchComboBox.Focused then
  begin
    result := false;
    exit;
  end;
  result := inherited IsShortCut(Message) or ToolbarMainMenu.IsShortCut(Message);
end;
*)

//ビデオを保存する(リストから)
procedure TMainWnd.ActionListPopupSaveExecute(Sender: TObject);
var
  item: TListItem;
  SearchData: TSearchData;
  URI: String;
  Title: string;
begin
  item := ListView.Selected;
  if item = nil then
    exit;
  SearchData := TSearchData(item.Data);
  if SearchData = nil then
    exit;
  if Length(SearchData.video_id) = 0 then
    exit;

  Title := SearchData.video_title;
  if Length(Title) > 0 then
  begin
    Title := CustomStringReplace(Title, '＼', '_');
    Title := CustomStringReplace(Title, '/', '_');
    Title := CustomStringReplace(Title, ':', '_');
    Title := CustomStringReplace(Title, '*', '_');
    Title := CustomStringReplace(Title, '?', '_');
    Title := CustomStringReplace(Title, '"', '_');
    Title := CustomStringReplace(Title, '<', '_');
    Title := CustomStringReplace(Title, '>', '_');
    Title := CustomStringReplace(Title, '|', '_');
  end;

  case SearchType of
    0,10,20: //YouTube
    begin
      if ((Config.optDownloadOption = 2) and AnsiContainsStr(Config.optDownloaderOption, '$URL2')) then
      begin
        URI := YOUTUBE_GET_WATCH_URI + SearchData.video_id;
        CommandExecuteForTool('', URI, Title + '.flv');  //ダウンロードツールでダウンロード
      end else
      begin
        //
      end;
    end;
    1,2,3,4,5,6,8,9: //nicovideo
    begin
      if ((Config.optDownloadOption = 2) and AnsiContainsStr(Config.optDownloaderOption, '$URL2')) then
      begin
        URI := NICOVIDEO_GET_URI + SearchData.video_id;
        CommandExecuteForTool('', URI, Title + '.flv');  //ダウンロードツールでダウンロード
      end else
      begin
        //
      end;
    end;
  end;
end;

//YouTubeを開く
procedure TMainWnd.ActionOpenYouTubeExecute(Sender: TObject);
begin
  OpenByBrowser(YOUTUBE_URI);
end;

//ニコニコ動画を開く
procedure TMainWnd.ActionOpenNicoVideoExecute(Sender: TObject);
begin
  OpenByBrowser(NICOVIDEO_URI);
end;

//ニコニコ動画 開発者ブログを開く
procedure TMainWnd.ActionOpenNicoVideoBlogExecute(Sender: TObject);
begin
  OpenByBrowser(NICOVIDEO_BLOG_URI);
end;

//TubePlayer公式サイトを開く
procedure TMainWnd.ActionOpenOfficialSiteExecute(Sender: TObject);
begin
  OpenByBrowser(DISTRIBUTORS_SITE);
end;

//ニコニコ市場を取得する
procedure TMainWnd.GetNicoIchibaExecute(const URI: String);
var
  LabelWord: String;
  URL: string;
begin
  if not ActionSearchBarSearch.Enabled then
    exit;

  ActionSearchBarSearch.Enabled := false;
  ActionSearchBarSearch2.Enabled := false;
  ActionSearchBarAdd100.Enabled := false;

  MenuSearchNicoVideo.Enabled := false;
  MenuSearchYouTube.Enabled := false;

  PanelBrowser.Visible := false;
  PanelListView.Visible := true;
  ActionSearchBarToggleListView.Checked := false;
  ActionSearchBarToggleListView.Enabled := false;

  ClearSearchList;
  SearchPage := 1;
  if not ActionToggleSearchPanel.Checked then
    ActionToggleSearchPanel.Execute;

  LabelWord := 'ニコニコ市場(' + URI + ')';

  tmpSearchURI := '';
  tmpSearchWord := LabelWord;
  SearchType := 9;
  NicoVideoRetryCount := 0;
  Log('ニコニコ市場取得開始');
  SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   <取得中>';
  Log('');

  URL := URI;
  RegExp.Pattern := GET_ICHIBA_ITEM;
  if RegExp.Test(URL) then
  begin
    URL := RegExp.Replace(URL, '$1');
    URL := GET_ICHIBA_RELATION + URL;
  end;

  procGet3 := AsyncManager.Get(URL, OnDoneNicoIchiba, OnNicoVideoPreConnect);
  tmpSearchURI := URL;
end;

//ニコニコ市場を処理する
procedure TMainWnd.OnDoneNicoIchiba(sender: TAsyncReq);
var
  i: integer;
  TotalCount: String;
  ContentList: TStringList;
  SearchDataList: TStringList;
  tmpSearchData: String;
  ContentsStart: boolean;
  //DataStart: boolean;
  Matches: MatchCollection;

  tmp, min, sec: String;
  tmptime: String;
  DateTime: TDateTime;
  second: integer;

  datastart: boolean;
  Content: String;

const
  GET_START            = '関連動画　開始';
  GET_END              = '関連動画　終了';
  GET_VIDEO_TITLE      = '">([^<]+)</a>';
  GET_VIDEO_ID         = 'watch\/([^"]+)"';

  GET_PLAYTIME_SECONDS = '[^\d時](\d+)分(\d+)秒';
  GET_VIEW_COUNT       = '再生：<strong(?:[^>]+)?>([\d,]+)<\/strong>';
  GET_RATIONG_COUNT    = 'コメント：<strong(?:[^>]+)?>([\d,]+)<\/strong>';
  GET_UPLOAD_TIME      = '(\d+)/(\d+)/(\d+)\s(\d+):(\d+)';

begin
  if procGet3 = sender then
  begin

    Log('【nicovideo(OnDoneNicoIchiba)】' + sender.IdHTTP.ResponseText);
    case sender.IdHTTP.ResponseCode of
    200: (* OK *)
      begin
        Log('データ分析開始');

        ContentList := TStringList.Create;
        SearchDataList := TStringList.Create;
        try
          ContentList.Text := procGet3.Content;
          TotalCount := '';

          ContentsStart := false;
          datastart := false;
          tmpSearchData := '';
          for i := 0 to ContentList.Count -1 do
          begin
            Content := UTF8toAnsi(ContentList[i]);
            if Length(Content) <= 0 then
              Continue;
            if not ContentsStart then
            begin
              if (AnsiPos(GET_START, Content) > 0) then
                ContentsStart := True;
              Continue;
            end;
            if ContentsStart then
            begin
              if (AnsiPos('<tr valign="top"', Content) > 0) then
              begin
                if Length(tmpSearchData) > 0 then
                  SearchDataList.Add(tmpSearchData);
                tmpSearchData := '';
                datastart := true;
                tmpSearchData := Content;
              end
              else if datastart then
              begin
                if (AnsiPos('</table>', Content) > 0) then
                begin
                  SearchDataList.Add(tmpSearchData);
                  datastart := false;
                end else
                  tmpSearchData := tmpSearchData + Content;
              end;
            end;

            if (AnsiPos(GET_END, Content) > 0) then
              break;
          end;

          if SearchDataList.Count > 0 then
          begin
            for i := 0 to SearchDataList.Count -1 do
            begin
              //Log(SearchDataList.Strings[i]);
              tmpSearchData := SearchDataList.Strings[i];
              SearchList.Add(TSearchData.Create);
              with TSearchData(SearchList.Last) do
              begin
                video_type := 1;
                html := tmpSearchData;
                RegExp.Pattern := GET_VIDEO_TITLE;
                begin
                  try
                    if RegExp.Test(tmpSearchData) then
                    begin
                      Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                      video_title := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(video_title) > 0 then
                        video_title := RegExp.Replace(video_title, '$1');
                      video_title := CustomStringReplace(video_title,  '&quot;', '"');
                      video_title := CustomStringReplace(video_title,  '&amp;', '&');
                      video_title := CustomStringReplace(video_title,  '&lt; ', '<');
                      video_title := CustomStringReplace(video_title,  '&gt;', '>');
                      //Log(video_title);
                    end;
                  except
                    video_title := '';
                  end;
                end;
                RegExp.Pattern := GET_VIDEO_ID;
                begin
                  try
                    if RegExp.Test(tmpSearchData) then
                    begin
                      Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                      video_id := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(video_id) > 0 then
                        video_id := RegExp.Replace(video_id, '$1');
                      //Log(video_id);
                    end;
                  except
                    video_id := '';
                  end;
                end;

                RegExp.Pattern := GET_PLAYTIME_SECONDS;
                begin
                  try
                    if RegExp.Test(tmpSearchData) then
                    begin
                      Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                      tmp := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(tmp) > 0 then
                      begin
                        min := RegExp.Replace(tmp, '$1');
                        sec := RegExp.Replace(tmp, '$2');
                        if (Length(min) > 0) and (Length(sec) > 0) then
                        try
                          playtime_seconds := IntToStr(StrToInt(min)*60 + StrToInt(sec));
                        except
                          playtime_seconds := ''
                        end;
                      end;
                      //Log(playtime_seconds);
                      if Length(playtime_seconds) > 0 then
                      begin
                        second := StrToIntDef(playtime_seconds, 0);
                        try
                          playtime := FormatFloat('0#', (second div 60)) + ':' + FormatFloat('0#', (second mod 60));
                        except
                          playtime := playtime_seconds + 'sec';
                        end;
                      end;
                      //Log(playtime);
                    end;
                  except
                  end;
                end;
                RegExp.Pattern := GET_VIEW_COUNT;
                begin
                  try
                    if RegExp.Test(tmpSearchData) then
                    begin
                      Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                      view_count := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(view_count) > 0 then
                      begin
                        view_count := RegExp.Replace(view_count, '$1');
                        view_count := CustomStringReplace(view_count,  ',', '');
                      end;
                      //Log(view_count);
                    end;
                  except
                    view_count := '';
                  end;
                end;
                RegExp.Pattern := GET_RATIONG_COUNT; //コメント数
                begin
                  try
                    if RegExp.Test(tmpSearchData) then
                    begin
                      Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                      rationg_count := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(rationg_count) > 0 then
                      begin
                        rationg_count := RegExp.Replace(rationg_count, '$1');
                        rationg_count := CustomStringReplace(rationg_count,  ',', '');
                      end;
                      //Log(rationg_count);
                    end;
                  except
                    rationg_count := '';
                  end;
                end;
                RegExp.Pattern := GET_UPLOAD_TIME; //アップロードされた時間
                begin
                  try
                    if RegExp.Test(tmpSearchData) then
                    begin
                      Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                      tmp := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(tmp) > 0 then
                      begin
                        tmptime := RegExp.Replace(tmp, '$1') + '/' + RegExp.Replace(tmp, '$2') + '/' + RegExp.Replace(tmp, '$3') + ' ' +
                                   RegExp.Replace(tmp, '$4') + ':' + RegExp.Replace(tmp, '$5');
                        DateSeparator := '/';
                        DateTime := StrToDateTime(tmptime);
                        upload_unixtime := IntToStr(DateTimeToUnix(DateTime));
                        upload_time := FormatDateTime('yyyy/mm/dd(aaa) hh:nn:ss', DateTime);
                      end;
                      //Log(upload_time);
                    end;
                  except
                    upload_unixtime := '';
                    upload_time := '';
                  end;
                end;
                if (Length(playtime_seconds) > 0) and (Length(rationg_count) > 0) and (StrToInt(playtime_seconds) > 0) then
                begin
                  rating_avg := FloatToStrF(StrToIntDef(rationg_count, 0) / StrToInt(playtime_seconds) * 60 ,
                                                        ffFixed, 7, 1);
                end;
                
                (*
                Log('*****');
                Log(video_title);
                Log(video_id);
                Log(playtime_seconds);
                Log(playtime);
                Log(view_count);
                Log(rationg_count);
                Log(upload_time);
                *)

              end;
            end;
          end;

        finally
          ContentList.Free;
          SearchDataList.Free;
        end;
        Log('データ分析完了');

        NicoVideoRetryCount := 0;
        ListView.List := SearchList;
        currentSortColumn := high(integer);
        if SearchList.Count > 0 then
        begin
          SpTBXDockablePanelSearch.Caption := tmpSearchWord;
          ActionSearchBarToggleListView.Enabled := true;
        end else
          SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   <該当データなし>';
        Log('取得完了');

      end;
    else
      begin
        SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   <取得失敗>';
        Log('データの取得に失敗しました。');
      end;
    end;
    procGet3 := nil;
    ActionSearchBarSearch.Enabled := True;
    ActionSearchBarSearch2.Enabled := True;
    ActionSearchBarAdd100.Enabled := false;

    MenuSearchNicoVideo.Enabled := true;
    MenuSearchYouTube.Enabled := true;
  end;
end;

//マイリストを開く
procedure TMainWnd.GetNicoMylistExecute(const URI: String);
var
  LabelWord: String;
begin
  if not ActionSearchBarSearch.Enabled then
    exit;

  ActionSearchBarSearch.Enabled := false;
  ActionSearchBarSearch2.Enabled := false;
  ActionSearchBarAdd100.Enabled := false;

  MenuSearchNicoVideo.Enabled := false;
  MenuSearchYouTube.Enabled := false;

  PanelBrowser.Visible := false;
  PanelListView.Visible := true;
  ActionSearchBarToggleListView.Checked := false;
  ActionSearchBarToggleListView.Enabled := false;

  ClearSearchList;
  SearchPage := 1;
  if not ActionToggleSearchPanel.Checked then
    ActionToggleSearchPanel.Execute;

  LabelWord := 'マイリスト(' + URI + ')';

  tmpSearchURI := '';
  tmpSearchWord := LabelWord;
  SearchType := 8;
  NicoVideoRetryCount := 0;
  Log('マイリスト取得開始');
  SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   <取得中>';
  Log('');
  procGet3 := AsyncManager.Get(URI, OnDoneNicoMyList, OnNicoVideoPreConnect);
  tmpSearchURI := URI;
end;

//マイリスト
procedure TMainWnd.OnDoneNicoMyList(sender: TAsyncReq);
var
  i: integer;
  TotalCount: String;
  ContentList: TStringList;
  SearchDataList: TStringList;
  tmpSearchData: String;
  ContentsStart: boolean;
  DataStart: boolean;
  Matches: MatchCollection;
  tmp, min, sec: String;
  tmptime: String;
  DateTime: TDateTime;
  second: integer;

  Content: String;

  procedure GetRetry;
  var
    URL: OleVariant;
  begin
    if (NicoVideoRetryCount = 0) and
       (Length(Config.optNicoVideoAccount) > 0) and (Length(Config.optNicoVideoPassword) > 0) then
    begin
      Inc(NicoVideoRetryCount);
      Log('');
      Log('Cookie取得開始');
      Config.optNicoVideoSession := '';
      URL := NICOVIDEO_URI;
      WebBrowser4.Navigate2(URL);
    end
    else if (NicoVideoRetryCount < 100) and (Length(Config.optNicoVideoSession) > 0) then
    begin
      NicoVideoRetryCount := 100;
      Log('');
      Log('Cookie再取得開始');
      Config.optNicoVideoSession := '';
      URL := NICOVIDEO_URI;
      WebBrowser4.Navigate2(URL);
    end else
    begin
      SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   <取得失敗>';
      Log('データの取得に失敗しました。');
    end;
  end;

const
  GET_VIDEO_TITLE      = '>([^<]+)</a></h3>';
  GET_VIDEO_ID         = 'watch\/([^"]+)">';
  GET_PLAYTIME_SECONDS = '>(\d{1,3}):(\d{2})<';
  GET_VIEW_COUNT       = '再生：<strong(?:[^>]+)?>([\d,]+)</strong>';
  GET_RATIONG_COUNT    = 'コメント：<strong(?:[^>]+)?>([\d,]+)</strong>';
  GET_UPLOAD_TIME      = '(\d+)年(\d+)月(\d+)日[\s]?(\d+)[:|：|時](\d+)[:|：|分](\d+)';
begin
  if procGet3 = sender then
  begin

    Log('【nicovideo(OnDoneNicoMyList)】' + sender.IdHTTP.ResponseText);
    case sender.IdHTTP.ResponseCode of
    200: (* OK *)
      begin
        Log('データ分析開始');

        ContentList := TStringList.Create;
        SearchDataList := TStringList.Create;
        try
          ContentList.Text := procGet3.Content;
          TotalCount := '';

          ContentsStart := false;
          DataStart := false;
          tmpSearchData := '';
          for i := 0 to ContentList.Count -1 do
          begin
            Content := UTF8toAnsi(ContentList[i]);
            if Length(Content) <= 0 then
              Continue;
            if not ContentsStart then
            begin
              if (AnsiPos('id="mylists"', Content) > 0) or (AnsiPos('summary="一覧"', Content) > 0) then
                ContentsStart := True
              else if (AnsiPos('>登録はありません。<"', Content) > 0) then
              begin
                ContentsStart := True;
                break;
              end;
              Continue;
            end;
            if not DataStart and (AnsiPos('<tr ', Content) > 0) then
            begin
              DataStart := True;
              tmpSearchData := Content;
            end
            else if DataStart and (AnsiPos('</tr>', Content) > 0) then
            begin
              tmpSearchData := tmpSearchData + Content;
              if (AnsiPos('コメント', tmpSearchData) > 0) then
              begin
                RegExp.Pattern := GET_VIDEO_ID;
                if RegExp.Test(tmpSearchData) then
                  SearchDataList.Add(tmpSearchData);
              end;
              DataStart := false;
              tmpSearchData := '';
            end else if DataStart then
            begin
              tmpSearchData := tmpSearchData + Content;
            end;
          end;

          if SearchDataList.Count > 0 then
          begin
            for i := 0 to SearchDataList.Count -1 do
            begin
              //Log(SearchDataList.Strings[i]);
              tmpSearchData := SearchDataList.Strings[i];
              SearchList.Add(TSearchData.Create);
              with TSearchData(SearchList.Last) do
              begin
                video_type := 1;
                html := tmpSearchData;
                RegExp.Pattern := GET_VIDEO_TITLE;
                begin
                  try
                    if RegExp.Test(tmpSearchData) then
                    begin
                      Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                      video_title := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(video_title) > 0 then
                        video_title := RegExp.Replace(video_title, '$1');
                      video_title := CustomStringReplace(video_title,  '&quot;', '"');
                      video_title := CustomStringReplace(video_title,  '&amp;', '&');
                      video_title := CustomStringReplace(video_title,  '&lt; ', '<');
                      video_title := CustomStringReplace(video_title,  '&gt;', '>');
                      //Log(video_title);
                    end;
                  except
                    video_title := '';
                  end;
                end;
                RegExp.Pattern := GET_VIDEO_ID;
                begin
                  try
                    if RegExp.Test(tmpSearchData) then
                    begin
                      Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                      video_id := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(video_id) > 0 then
                        video_id := RegExp.Replace(video_id, '$1');
                      //Log(video_id);
                    end;
                  except
                    video_id := '';
                  end;
                end;
                RegExp.Pattern := GET_PLAYTIME_SECONDS;
                begin
                  try
                    if RegExp.Test(tmpSearchData) then
                    begin
                      Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                      tmp := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(tmp) > 0 then
                      begin
                        min := RegExp.Replace(tmp, '$1');
                        sec := RegExp.Replace(tmp, '$2');
                        if (Length(min) > 0) and (Length(sec) > 0) then
                        try
                          playtime_seconds := IntToStr(StrToInt(min)*60 + StrToInt(sec));
                        except
                          playtime_seconds := ''
                        end;
                      end;
                      //Log(playtime_seconds);
                      if Length(playtime_seconds) > 0 then
                      begin
                        second := StrToIntDef(playtime_seconds, 0);
                        try
                          playtime := FormatFloat('0#', (second div 60)) + ':' + FormatFloat('0#', (second mod 60));
                        except
                          playtime := playtime_seconds + 'sec';
                        end;
                      end;
                      //Log(playtime);
                    end;
                  except
                  end;
                end;
                RegExp.Pattern := GET_VIEW_COUNT;
                begin
                  try
                    if RegExp.Test(tmpSearchData) then
                    begin
                      Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                      view_count := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(view_count) > 0 then
                      begin
                        view_count := RegExp.Replace(view_count, '$1');
                        view_count := CustomStringReplace(view_count,  ',', '');
                      end;
                      //Log(view_count);
                    end;
                  except
                    view_count := '';
                  end;
                end;
                RegExp.Pattern := GET_RATIONG_COUNT; //コメント数
                begin
                  try
                    if RegExp.Test(tmpSearchData) then
                    begin
                      Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                      rationg_count := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(rationg_count) > 0 then
                      begin
                        rationg_count := RegExp.Replace(rationg_count, '$1');
                        rationg_count := CustomStringReplace(rationg_count,  ',', '');
                      end;
                      //Log(rationg_count);
                    end;
                  except
                    rationg_count := '';
                  end;
                end;
                RegExp.Pattern := GET_UPLOAD_TIME; //アップロードされた時間
                begin
                  try
                    if RegExp.Test(tmpSearchData) then
                    begin
                      Matches := RegExp.Execute(tmpSearchData) as MatchCollection;
                      tmp := AnsiString(Match(Matches.Item[0]).Value);
                      if Length(tmp) > 0 then
                      begin
                        tmptime := RegExp.Replace(tmp, '$1') + '/' + RegExp.Replace(tmp, '$2') + '/' + RegExp.Replace(tmp, '$3') + ' ' +
                                   RegExp.Replace(tmp, '$4') + ':' + RegExp.Replace(tmp, '$5');
                        DateSeparator := '/';
                        DateTime := StrToDateTime(tmptime);
                        upload_unixtime := IntToStr(DateTimeToUnix(DateTime));
                        upload_time := FormatDateTime('yyyy/mm/dd(aaa) hh:nn:ss', DateTime);
                      end;
                      //Log(upload_time);
                    end;
                  except
                    upload_unixtime := '';
                    upload_time := '';
                  end;
                end;
                if (Length(playtime_seconds) > 0) and (Length(rationg_count) > 0) and (StrToInt(playtime_seconds) > 0) then
                begin
                  rating_avg := FloatToStrF(StrToIntDef(rationg_count, 0) / StrToInt(playtime_seconds) * 60 ,
                                                        ffFixed, 7, 1);
                end;

                (*
                Log('*****');
                Log(video_title);
                Log(video_id);
                Log(playtime_seconds);
                Log(playtime);
                Log(view_count);
                Log(rationg_count);
                Log(upload_time);
                *)

              end;
            end;
          end;

        finally
          ContentList.Free;
          SearchDataList.Free;
        end;
        Log('データ分析完了');

        if not ContentsStart then
        begin
          Log('有効なデータを取得できませんでした。');
          Log('データ再取得開始');
          GetRetry;
        end else
        begin
          NicoVideoRetryCount := 0;
          ListView.List := SearchList;
          currentSortColumn := high(integer);
          if SearchList.Count > 0 then
          begin
            SpTBXDockablePanelSearch.Caption := tmpSearchWord;
            ActionSearchBarToggleListView.Enabled := true;
          end else
            SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   <該当データなし>';
          Log('取得完了');
        end;
      end;
    else
      begin
        SpTBXDockablePanelSearch.Caption := tmpSearchWord + '   <取得失敗>';
        Log('データの取得に失敗しました。');
      end;
    end;
    procGet3 := nil;
    ActionSearchBarSearch.Enabled := True;
    ActionSearchBarSearch2.Enabled := True;
    ActionSearchBarAdd100.Enabled := false;

    MenuSearchNicoVideo.Enabled := true;
    MenuSearchYouTube.Enabled := true;
  end;
end;

//最小化
procedure TMainWnd.ActionMinimizeExecute(Sender: TObject);
begin
  Application.Minimize;
end;

//タスクトレイに格納
procedure TMainWnd.ActionHideInTaskTrayExecute(Sender: TObject);
begin
  Hide;
  ShowWindow(Application.Handle, SW_HIDE);
  TrayIcon.Show;
end;

//ニコニコ市場ランキングを開く
procedure TMainWnd.ActionOpenNicoIchibaExecute(Sender: TObject);
var
  URL: OleVariant;
begin
  ActionClearVideoPanel.Execute;
  URL := NICOVIDEO_ICHIBA_URI;
  WebBrowser.Navigate2(URL);
  tmpURI := URL;
  ActionClearVideoPanel.Enabled := True;
  LabelURL.Caption := 'ニコニコ市場ランキング';
  Self.Caption := APPLICATION_NAME + ' - [' + 'ニコニコ市場ランキング' + ']';
  Application.Title := Self.Caption;
  if SpTBXTitleBar.Active then
    SpTBXTitleBar.Caption := Self.Caption;
  if Config.optFormStayOnTopPlaying then
  begin
    Config.optFormStayOnTop := false;
    ActionStayOnTop.Execute;
  end;
end;

//NicoVideo設定の「カテゴリ」にチェックを付ける
procedure TMainWnd.MenuSearchNicoVideoCategorySettingClick(
  Sender: TObject);
var
  i: integer;
begin
  for i := 0 to MenuSearchNicoVideoCategorySetting.Count -1 do
  begin
    MenuSearchNicoVideoCategorySetting[i].Checked := (Config.optSearchNicoVideoCategory = MenuSearchNicoVideoCategorySetting[i].Tag);
  end;
end;

//NicoVideo設定の「カテゴリ」を設定する
procedure TMainWnd.MenuSearchToggleSearchTargetNicoVideoSettingCategoryExecute(
  Sender: TObject);
begin
  Config.optSearchNicoVideoCategory := TComponent(Sender).Tag;
  Config.Modified := True;
end;

//マイリストをお気に入りに追加
procedure TMainWnd.ActionFavoritePopupAddMylistExecute(Sender: TObject);
const
  NICO_TARGET = 'http://(?:www\.)?nicovideo\.jp/mylist/(.+)';
  //http://www.nicovideo.jp/mylist/1411396/2642157

  function URIDialog: String;
  var
    rc: integer;
    clip: String;
    flag: boolean;
  begin
    if InputDlg = nil then
      InputDlg := TInputDlg.Create(self);
    InputDlg.Caption := 'マイリストのURLを入力してください';
    clip := Clipboard.AsText;
    flag := false;
    if Length(clip) > 0 then
    begin
      RegExp.Pattern := NICO_TARGET;
      if not flag and RegExp.Test(clip) then
      begin
        flag := true;
      end;

      if not flag then
        clip := '';
    end;
    InputDlg.Edit.Text := clip;

    rc := ShowModalDlg(Self, InputDlg, Config.optFormStayOnTop);

    if (rc <> 3) then
      Result:= '$$$'
    else
      Result := Trim(InputDlg.Edit.Text);
  end;

  function NewFavorite(var parent: TFavoriteList; URI: String): TFavorite;
  begin
    result := TFavorite.Create(favorites);
    result.name := URI;
    result.location := 'nicovideo';
    result.id := URI;
    result.value := 'mylist';
    result.addtime := IntToStr(DateTimeToUnix(now));
    parent.expanded := true;
  end;
var
  vnode: PVirtualNode;
  Data, Data2: PDataItem;
  parent: TFavoriteList;
  URI: String;
begin
  URI := URIDialog;
  if Length(URI) > 0 then
  begin
    if URI = '$$$' then
      exit;

    RegExp.Pattern := NICO_TARGET;
    if RegExp.Test(URI) then
    begin
      URI := RegExp.Replace(URI, '$1');
      if Length(URI) > 0 then
      begin
        vnode := VirtualFavoriteView.GetFirstSelected;
        Data := VirtualFavoriteView.GetNodeData(vnode);
        SaveFavorites(false);

        if vnode = nil then
        begin
          parent := favorites;
          parent.Insert(0, NewFavorite(parent, URI));
        end
        else if (TObject(Data^.Data) is TFavoriteList) and (0 <= GetKeyState(VK_CONTROL)) then
        begin
          parent := Data^.Data;
          parent.Insert(0, NewFavorite(parent, URI));
        end else
        begin
          vnode := vnode.Parent;
          Data2 := VirtualFavoriteView.GetNodeData(vnode);
          parent := TFavoriteList(Data2^.Data);
          parent.Insert(parent.IndexOf(Data^.Data), NewFavorite(parent, URI));
        end;
        SaveFavorites(true);
        UpdateFavorites;
      end;
    end;
  end;
end;

//YouTubeAPI結果XMLのEntryNodeを解析
function TMainWnd.YouTubeEntryXMLAnalize(EntryNode: IXMLNode; NS_media, NS_gd, NS_yt: DOMString): TANLVideoData;
var
  Node, Node2: IXMLNode;
  second: integer;
  rate: integer;
  datetime: TDateTime;
begin
  Result := TANLVideoData.Create;
  try
    with Result do
    begin
      video_type := 0;

      video_id := ExtractURIFile(VarToStr(EntryNode.ChildValues['id']));

      upload_time := VarToStr(EntryNode.ChildValues['published']);
      if Length(upload_time) > 0 then
      begin
        datetime := StrToDateTime(YouTubeDateToDateTimeStr(upload_time));
        upload_time := FormatDateTime('yyyy/mm/dd(aaa) hh:nn:ss', datetime + (TimeZoneBias/(24*60*60)));
        upload_unixtime := IntToStr(DateTimeToUnix(datetime));
      end;

      update_time := VarToStr(EntryNode.ChildValues['updated']);
      if Length(update_time) > 0 then
      begin
        datetime := StrToDateTime(YouTubeDateToDateTimeStr(update_time));
        update_time := FormatDateTime('yyyy/mm/dd(aaa) hh:nn:ss', datetime + (TimeZoneBias/(24*60*60)));
        update_unixtime := IntToStr(DateTimeToUnix(datetime));
      end;

      Node := EntryNode.ChildNodes.FindNode('author');
      if Assigned(Node) then
      begin
        author := VarToStr(Node.ChildValues['name']);
        author_link := Format('<a href="%s">%s</a>', [VarToStr(Node.ChildValues['uri']), author]);
      end;

      Node := EntryNode.ChildNodes.FindNode('comments', NS_gd);
      if Assigned(Node) then
      begin
        Node2 := Node.ChildNodes.FindNode('feedLink', NS_gd);
        if Assigned(Node2) then
        begin
          comment_url := VarToStr(Node2.Attributes['href']);
          comment_count := VarToStr(Node2.Attributes['countHint']);
        end;
      end;

      Node := EntryNode.ChildNodes.FindNode('group', NS_media);
      if Assigned(Node) then
      begin
        Node2 := Node.ChildNodes.FindNode('category', NS_media);
        if Assigned(Node2) then
          channnel := VarToStr(Node2.NodeValue);

        Node2 := Node.ChildNodes.FindNode('description', NS_media);
        if Assigned(Node2) then
          description := VarToStr(Node2.NodeValue);

        Node2 := Node.ChildNodes.FindNode('keywords', NS_media);
        if Assigned(Node2) then
          keywords := VarToStr(Node2.NodeValue);

        Node2 := Node.ChildNodes.FindNode('player', NS_media);
        if Assigned(Node2) then
          player_url := VarToStr(Node2.Attributes['url']);

        Node2 := Node.ChildNodes.FindNode('thumbnail', NS_media);
        if Assigned(Node2) then
        begin
          thumbnail_url  := ExtractURIDir(VarToStr(Node2.Attributes['url']));
          thumbnail_url0 := thumbnail_url + '0.jpg';
          thumbnail_url1 := thumbnail_url + '1.jpg';
          thumbnail_url2 := thumbnail_url + '2.jpg';
          thumbnail_url3 := thumbnail_url + '3.jpg';
          thumbnail_url  := thumbnail_url + 'default.jpg';
        end;

        Node2 := Node.ChildNodes.FindNode('title', NS_media);
        if Assigned(Node2) then
          video_title := VarToStr(Node2.NodeValue);

        Node2 := Node.ChildNodes.FindNode('duration', NS_yt);
        if Assigned(Node2) then
          playtime_seconds := VarToStr(Node2.Attributes['seconds']);
        if Length(playtime_seconds) > 0 then
        begin
          second := StrToIntDef(playtime_seconds, 0);
          playtime := Format('%.1d:%.2d', [(second div 60), (second mod 60)]);
        end;
      end;

      Node := EntryNode.ChildNodes.FindNode('rating', NS_gd);
      if Assigned(Node) then
      begin
        rating_avg := Format('%1.2f', [VarToDouble(Node.Attributes['average'])]);
        rationg_count := VarToStr(Node.Attributes['numRaters']);

        if Length(rating_avg) > 0 then
        begin
          rate := Round(StrToFloatDef(rating_avg, 0));
          case rate of
            0:   rating := '☆☆☆☆☆';
            1:   rating := '★☆☆☆☆';
            2:   rating := '★★☆☆☆';
            3:   rating := '★★★☆☆';
            4:   rating := '★★★★☆';
            else rating := '★★★★★';
          end;
        end;
      end;

      Node := EntryNode.ChildNodes.FindNode('statistics', NS_yt);
      if Assigned(Node) then
      begin
        favorited_count := VarToStr(Node.Attributes['favoriteCount']);
        view_count := VarToStr(Node.Attributes['viewCount']);
      end;

      Node := EntryNode.ChildNodes.FindNode('recorded', NS_yt);
      if Assigned(Node) then
      begin
        recording_date := VarToStr(Node.NodeValue);
        recording_date := CustomStringReplace(recording_date, '-', '/', false);
        try
          recording_date := FormatDateTime('yyyy/mm/dd(aaa)', StrToDateTime(recording_date));
        except
          recording_date := VarToStr(Node.NodeValue);
        end;
      end;

      Node := EntryNode.ChildNodes.FindNode('location', NS_yt);
      if Assigned(Node) then
        recording_location := VarToStr(Node.NodeValue);
    end;
  except
    FreeAndNil(Result);
  end;
end;

//ジェーンBBSを開く
procedure TMainWnd.ActionOpenJaneBBSExecute(Sender: TObject);
begin
  OpenByBrowser(Main.JANE_BBS_URI);
end;

initialization
  OleInitialize(nil);

finalization
  OleUninitialize;

end.
