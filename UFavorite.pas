unit UFavorite;
(* お気に入り *)

interface

uses
  Classes, SysUtils, StrUtils, Dialogs, Controls,
  UXMLSub;

type
  TFavoriteList = class;

  (*-------------------------------------------------------*)
  TFavBase = class(TObject)
  protected
    changed: boolean;
    procedure SetName(const name: string);
  public
    FName:     string;
    parent:   TFavBase;
    constructor Create(parentNode: TFavBase);
    destructor Destroy; override;
    procedure Remove;
    procedure Delete(obj: TFavBase); virtual;
    procedure DeleteAndAdd(obj, newobj: TFavBase); virtual;
    procedure AddNext(obj, newobj: TFavBase); virtual;
    property name: string read FName write SetName;
  end;

  (*-------------------------------------------------------*)
  TFavorite = class(TFavBase)
  public
    location: string;
    id: string;
    times: string;
    addtime: string;
    playtime: string;
    user: string;
    value: string;
    comment: string;
    etc: string;
    etc2: string;
    constructor Create(parentNode: TFavoriteList);
    destructor Destroy; override;
  end;

  (*-------------------------------------------------------*)
  TFavoriteList = class(TFavBase)
  protected
    list: TList;
    function GetCount: integer;
    function GetItems(index: integer): TFavBase;
  public
    expanded:    boolean;
    constructor Create(parentNode: TFavoriteList);
    destructor Destroy; override;
    procedure Clear;
    procedure Add(obj: TFavBase);
    procedure Insert(index: integer; item: TFavBase);
    procedure Delete(obj: TFavBase); override;
    procedure DeleteAndAdd(obj, newobj: TFavBase); override;
    procedure AddNext(obj, newobj: TFavBase); override;
    procedure FindDelete(const location, id: string);
    procedure FindDeleteAndAdd(const location, id : string; newitem: TFavBase);
    procedure FindAndAddNext(const location, id : string; newitem: TFavBase);
    function IndexOf(item: TFavBase): integer;
    function Find(const location, id: string): TFavorite;
    function IsChanged: boolean;
    procedure ClearChanged;
    property Count: integer read Getcount;
    property Items[index: integer]: TFavBase read GetItems;
  end;

  (*-------------------------------------------------------*)
  TFavorites = class(TFavoriteList)
  protected
    FSelected: integer;
    FTop:      integer;
    procedure SetSelected(val: integer);
    procedure SetTop(val: integer);
  public
    updata: boolean;
    constructor Create;
    function Load(const path: string): boolean;
    procedure Save(const path: string);
    property selected: integer read FSelected write SetSelected;
    property top: integer read FTop write SetTop;
  end;

(*=======================================================*)
implementation
(*=======================================================*)
constructor TFavBase.Create(parentNode: TFavBase);
begin
  parent := parentNode;
  changed:= false;
end;

destructor TFavBase.Destroy;
begin
  Remove;
  inherited;
end;

procedure TFavBase.Remove;
begin
  if parent <> nil then
  begin
    parent.Delete(self);
    parent := nil;
  end;
end;

procedure TFavBase.Delete(obj: TFavBase);
begin
end;

procedure TFavBase.DeleteAndAdd(obj, newobj: TFavBase);
begin
end;

procedure TFavBase.AddNext(obj, newobj: TFavBase);
begin
end;

procedure TFavBase.SetName(const name: string);
begin
  FName := name;
  changed := true;
end;

(*=======================================================*)
constructor TFavorite.Create(parentNode: TFavoriteList);
begin
  parent := parentNode;
end;

destructor TFavorite.Destroy;
begin
  location := '';
  id := '';
  times := '';
  addtime := '';
  playtime := '';
  user := '';
  value := '';
  comment := '';
  etc := '';
  etc2 := '';
  inherited;
end;

(*=======================================================*)
constructor TFavoriteList.Create(parentNode: TFavoriteList);
begin
  inherited Create(parentNode);
  list := TList.Create;
end;

destructor TFavoriteList.Destroy;
begin
  Clear;
  list.Free;
  inherited Destroy;
end;

procedure TFavoriteList.Clear;
begin
  while 0 < list.Count do
    TFavBase(list.Items[0]).Free;
end;

procedure TFavoriteList.Add(obj: TFavBase);
begin
  if obj is TFavoriteList then
  begin
    if TFavoriteList(obj).parent <> self then
    begin
      TFavoriteList(obj).Remove;
      TFavoriteList(obj).parent := self;
    end;
    list.Add(obj);
    changed := true;
  end
  else if obj is TFavorite then
  begin
    if TFavorite(obj).parent <> self then
    begin
      TFavorite(obj).Remove;
      TFavorite(obj).parent := self;
    end;
    list.Add(obj);
    changed := true;
  end;
end;

procedure TFavoriteList.Insert(index: integer; item: TFavBase);
begin
  if item is TFavoriteList then
  begin
    if TFavoriteList(item).parent <> self then
    begin
      TFavoriteList(item).Remove;
      TFavoriteList(item).parent := self;
    end;
    list.Insert(index, item);
    changed := true;
  end
  else if item is TFavorite then
  begin
    if TFavorite(item).parent <> self then
    begin
      TFavorite(item).Remove;
      TFavorite(item).parent := self;
    end;
    list.Insert(index, item);
    changed := true;
  end;
end;

procedure TFavoriteList.Delete(obj: TFavBase);
var
  i: integer;
begin
  i := list.IndexOf(obj);
  if i < 0 then
    exit;
  list.Delete(i);
  changed := true;
end;

procedure TFavoriteList.DeleteAndAdd(obj, newobj: TFavBase);
var
  i: integer;
begin
  i := list.IndexOf(obj);
  if i < 0 then
    exit;
  list.Delete(i);
  if TFavorite(newobj).parent <> self then
  begin
    TFavorite(newobj).Remove;
    TFavorite(newobj).parent := self;
  end;
  list.Insert(i, newobj);
  changed := true;
end;

procedure TFavoriteList.AddNext(obj, newobj: TFavBase);
var
  i: integer;
begin
  i := list.IndexOf(obj);
  if i < 0 then
    exit;
  if TFavorite(newobj).parent <> self then
  begin
    TFavorite(newobj).Remove;
    TFavorite(newobj).parent := self;
  end;
  list.Insert(i + 1, newobj);
  changed := true;
end;

procedure TFavoriteList.FindDelete(const location, id: string);
var
  item: TFavorite;
begin
  item := nil;
  repeat
    if (item <> nil) and (item.parent <> nil) then
    begin
      item.parent.Delete(item);
      item.Free;
    end;
    item := Find(location, id);
  until item = nil;
end;

procedure TFavoriteList.FindDeleteAndAdd(const location, id : string; newitem: TFavBase);
var
  item: TFavorite;
begin
  item := Find(location, id);
  if (item <> nil) and (item.parent <> nil) then
  begin
    item.parent.DeleteAndAdd(item, newitem);
    item.Free;
  end;
end;

procedure TFavoriteList.FindAndAddNext(const location, id : string; newitem: TFavBase);
var
  item: TFavorite;
begin
  item := Find(location, id);
  if (item <> nil) and (item.parent <> nil) then
  begin
    item.parent.AddNext(item, newitem);
  end;
end;

function TFavoriteList.GetCount: integer;
begin
  result := list.Count;
end;

function TFavoriteList.GetItems(index: integer): TFavBase;
begin
  result := list.Items[index];
end;

function TFavoriteList.IndexOf(item: TFavBase): integer;
begin
  result := list.IndexOf(item);
end;

function TFavoriteList.Find(const location, id: string): TFavorite;
var
  i: integer;
  item: TFavorite;
begin
  for i := 0 to list.Count -1 do
  begin
    if Items[i] is TFavoriteList then
    begin
      result := (Items[i] as TFavoriteList).Find(location, id,);
      if (result <> nil) then
        exit;
    end
    else begin
      item := (Items[i] as TFavorite);
      if (item.location = location) and (item.id = id) then
      begin
        result := item;
        exit;
      end;
    end;
  end;
  result := nil;
end;

function TFavoriteList.IsChanged: boolean;
var
  i: integer;
begin
  if changed then
  begin
    result := true;
    exit;
  end;
  for i := 0 to list.Count -1 do
  begin
    if Items[i] is TFavoriteList then
    begin
      result := (Items[i] as TFavoriteList).IsChanged;
      if result then
        exit;
    end
    else begin
      result := (Items[i] as TFavorite).changed;
      if result then
        exit;
    end;
  end;
  result := false;
end;

procedure TFavoriteList.ClearChanged;
var
  i: integer;
begin
  changed := false;
  for i := 0 to list.Count -1 do
  begin
    if Items[i] is TFavoriteList then
      (Items[i] as TFavoriteList).ClearChanged
    else
      (Items[i] as TFavorite).changed := false;
  end;
end;

(*=======================================================*)
constructor TFavorites.Create;
begin
  inherited Create(nil);
  top := 0;
  selected := -1;
  FName := 'お気に入り';
end;

function TFavorites.Load(const path: string): boolean;
var
  favFolder: TFavoriteList;
  modified: boolean;
  procedure AddNode(parent: TFavoriteList; element: TXMLElement);
  var
    i: integer;
    el: TXMLElement;
    favNode: TFavorite;
  begin
    for i := 0 to element.Count -1 do
    begin
      el := element.Items[i];
      if (el.elementType = xmleELEMENT) then
      begin
        if el.text = 'folder' then
        begin
          favFolder := TFavoriteList.Create(parent);
          try favFolder.FName := el.attrib.Values['name']; except end;
          try favFolder.expanded := (el.attrib.Values['expanded'] = 'true'); except end;
          parent.Add(favFolder);
          AddNode(favFolder, el);
        end
        else if el.text = 'item' then
        begin
          favNode := TFavorite.Create(parent);
          try favNode.FName := el.attrib.Values['name']; except end;
          try favNode.location := el.attrib.Values['location']; except end;
          try favNode.id := el.attrib.Values['id']; except end;
          try favNode.addtime := el.attrib.Values['addtime']; except end;
          try favNode.playtime   := el.attrib.Values['playtime']; except end;
          try favNode.user    := el.attrib.Values['user']; except end;
          try favNode.value := el.attrib.Values['value']; except end; 
          try favNode.comment := el.attrib.Values['comment']; except end;
          try favNode.etc := el.attrib.Values['etc']; except end;
          try favNode.etc2 := el.attrib.Values['etc2']; except end;
          parent.Add(favNode);
        end;
      end;
    end;
  end;
var
  fstream: TFileStream;
  doc: TXMLDoc;
  elem: TXMLElement;
  i: integer;
begin
  result := false;
  modified := false;
  fstream := nil;
  doc := nil;
  while true do
  try
    fstream := TFileStream.Create(path, fmOpenRead);
    doc := TXMLDoc.Create;
    doc.LoadFromStream(fstream);
    Clear;
    (* favoriteを探す *)
    for i := 0 to doc.Count -1 do
    begin
      elem := doc.Items[i];
      if (elem.elementType = xmleELEMENT) and
         (elem.text = 'favorite') then
      begin
        try expanded := (elem.attrib.Values['expanded'] <> 'false'); except end;
        try top := StrToInt(elem.attrib.Values['top']); except end;
        try self.selected := StrToInt(elem.attrib.Values['selected']); except end;
        AddNode(self, elem);
        break;
      end;
    end;
    fstream.Free;
    doc.Free;
    result := true;
    break;
  except
    if fstream <> nil then
      fstream.Free;
    if doc <> nil then
      doc.Free;
    if not FileExists(path) then
    begin
      result := true;
      break;
    end;
    if MessageDlg('お気に入りの読み込みに失敗しました。' + #10 +
                  '他のソフト等でfavorites.datを使用している場合は終了させて下さい。',
                  mtError, [mbAbort, mbRetry], 0) = mrAbort then
    begin
      result := false;
      break;
    end;
  end;
  ClearChanged;

  (* データ修正用コードです *)
  if result and modified then
    Save(path);
end;

const
  TrueFalse: array[0..1] of string = ('false', 'true');

procedure TFavorites.Save(const path: string);
var
  favFile: TStringList;
  procedure SetOutputList(listNode: TFavoriteList; indent: integer);
  var
    i: integer;
  begin
    for i := 0 to listNode.Count -1 do
    begin
      if TObject(listNode.Items[i]) is TFavorite then
      begin
        with TFavorite(listNode.Items[i]) do
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
      end
      else if TObject(listNode.Items[i]) is TFavoriteList then
      begin
        with TFavoriteList(listNode.Items[i]) do
        begin
          favFile.Add(StringOfChar(' ', indent * 2)
                      + Format('<folder name="%s" expanded="%s">',
                      [XMLQuoteEncode(name), TrueFalse[Integer(expanded)]]));
          SetOutputList(TFavoriteList(listNode.Items[i]), indent + 1);
          favFile.Add(StringOfChar(' ', indent * 2)
                      + '</folder>');
        end;
      end;
    end;
  end;
begin
  if not updata and not IsChanged then
    exit;
  favFile := TStringList.Create;
  favFile.Add(Format('<favorite top="%d" selected="%d">', [top, selected]));
  SetOutputList(self, 1);
  favFile.Add('</favorite>');
  try
    favFile.SaveToFile(path);
  except
  end;
  favFile.Free;
end;

procedure TFavorites.SetSelected(val: integer);
begin
  if FSelected <> val then
  begin
    FSelected := val;
    changed := true;
  end;
end;

procedure TFavorites.SetTop(val: integer);
begin
  if FTop <> val then
  begin
    FTop := val;
    changed := true;
  end;
end;


end.
