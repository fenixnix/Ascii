extends Control

var db = []
var dbDict = {}
var data = []
var curSet = {}
var fileName = ""

signal select(set)

func _ready():
	InitDb(GlbDb.hidenDb)
	LoadDat("res://ect_set.json")

func InitDb(_db):
	db = _db
	for d in db:
		dbDict[str(d.id)] = d
	$HBox/DB.clear()
	for d in db:
		$HBox/DB.add_item("%d[%s]:%s"%[d.id,d.type,d.name])

func LoadDat(file):
	fileName = file
	var dir = Directory.new()
	if dir.file_exists(file):
		data = FileRW.LoadJsonFile(file)
		refresh_set_list()
		refresh_set()

func _on_DB_item_selected(index):
	ShowCard(GlbDb.hidenDb[index])

func _on_new_pressed():
	data.append({
		"name":$HBox/VBox/Menu/LineEdit.text,
		"set":{}
	})
	refresh_set_list()

func _on_setLst_item_selected(index):
	curSet = data[index]
	$HBox/VBox/SetName.text = curSet.name
	refresh_set()

func _on_List_item_selected(index):
	ShowCard(dbDict[curSet.set.keys()[index]])

func ShowCard(dat):
	$HBox/Card.texture = GlbDb.CardImg(dat.img)

func refresh_set_list():
	$HBox/VBox/setLst.clear()
	for s in data:
		$HBox/VBox/setLst.add_item(s.name)

func refresh_set():
	$HBox/VBox/List.clear()
	for k in curSet.get("set",{}).keys():
		$HBox/VBox/List.add_item("#%s:%s [*%d]"%[k,dbDict[k].name,curSet.set[k]])

func _on_DB_item_activated(index):
	add(str(db[index].id))
	refresh_set()

func _on_List_item_activated(index):
	rmv(index)
	refresh_set()

func add(id):
	if curSet.set.has(id):
		curSet.set[id] += 1
	else:
		curSet.set[id] = 1

func rmv(index):
	var key = curSet.set.keys()[index]
	curSet.set[key]-=1
	if curSet.set[key] <= 0:
		curSet.set.erase(key)

func _on_Save_pressed():
	FileRW.SaveJsonFile(fileName,data)

func _on_setLst_item_activated(index):
	data.remove(index)
	refresh_set_list()
	refresh_set()

func _on_Select_pressed():
	var tmp = []
	for k in curSet.set.keys():
		for c in range(curSet.set[k]):
			tmp.append(dbDict[k].duplicate(true))
	emit_signal("select",tmp)
	queue_free()

func _on_clear_pressed():
	curSet.set.clear()
	refresh_set()

func _on_SetName_text_changed(new_text):
	curSet.name = new_text
	refresh_set_list()
